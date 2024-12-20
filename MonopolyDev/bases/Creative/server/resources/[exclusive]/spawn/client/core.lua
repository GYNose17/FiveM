-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp", "lib/Tunnel")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
vSERVER = Tunnel.getInterface("spawn")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Camera = nil
-----------------------------------------------------------------------------------------------------------------------------------------
-- SPAWN:OPENED
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("spawn:Opened", function()
	local Ped = PlayerPedId()
	LocalPlayer["state"]:set("Blastoise", true, false)
	LocalPlayer["state"]:set("Charizard", true, false)
	SetEntityCoords(Ped, SpawnOpen["x"], SpawnOpen["y"], SpawnOpen["z"], false, false, false, false)
	FreezeEntityPosition(Ped, true)
	SetEntityHeading(Ped, SpawnOpen["h"])
	SetEntityHealth(Ped, 100)
	SetPedArmour(Ped, 0)

	Camera = CreateCam("DEFAULT_SCRIPTED_CAMERA", true)
	SetCamCoord(Camera, CamOpen["x"], CamOpen["y"], CamOpen["z"])
	RenderScriptCams(true, true, 0, true, true)
	SetCamRot(Camera, 0.0, 0.0, CamOpen["h"], 2)
	SetCamActive(Camera, true)

	Characters = vSERVER.Characters()
	if parseInt(#Characters) > 0 then
		Customization(Characters[1])
	end

	Wait(5000)
	
	if IsScreenFadedOut() then
		DoScreenFadeIn(500)
	end

	SetNuiFocus(true, true)
	SendNUIMessage({ name = "Spawn", payload = Characters })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHARACTERCHOSEN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("CharacterChosen", function(Data, Callback)
	if vSERVER.CharacterChosen(Data["Passport"]) then
		SendNUIMessage({ name = "Close" })
	end

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- NEWCHARACTER
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("NewCharacter", function(Data, Callback)
	Callback(vSERVER.NewCharacter(Data["name"], Data["lastname"], Data["sex"]))
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SWITCHCHARACTER
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("SwitchCharacter", function(Data, Callback)
	for _, v in pairs(Characters) do
		if v["Passport"] == Data["Passport"] then
			Customization(v, true)
			break
		end
	end

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SPAWN:FINISH
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("spawn:Finish")
AddEventHandler("spawn:Finish", function(Open, Barbershop)
	if Open then
		SpawnLocations[1] = { ["Coords"] = Barbershop, ["name"] = "" }

		for Number,v in pairs(SpawnLocations) do
			local Road = GetStreetNameAtCoord(v["Coords"]["x"], v["Coords"]["y"], v["Coords"]["z"])
			SpawnLocations[Number]["name"] = GetStreetNameFromHashKey(Road)
		end

		SetCamCoord(Camera, SpawnLocations[1]["Coords"]["x"], SpawnLocations[1]["Coords"]["y"], SpawnLocations[1]["Coords"]["z"] + 1)
		SendNUIMessage({ name = "Location", payload = SpawnLocations })
		LocalPlayer["state"]:set("Charizard", true, false)
		SetCamRot(Camera, 0.0, 0.0, 0.0, 2)
	else
		LocalPlayer["state"]:set("Charizard", false, false)
		TriggerServerEvent("vRP:BucketClient", "Exit")
		SendNUIMessage({ name = "Close" })
		TriggerEvent("hud:Active", true)
		SetNuiFocus(false, false)

		if DoesCamExist(Camera) then
			RenderScriptCams(false, false, 0, false, false)
			SetCamActive(Camera, false)
			DestroyCam(Camera, false)
			Camera = nil
		end

		if Barbershop then
			Wait(1000)
			TriggerServerEvent("vRP:BucketClient", "Enter")
			TriggerEvent("barbershop:Open", "open")
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SPAWN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Spawn", function(Data, Callback)
	if DoesCamExist(Camera) then
		RenderScriptCams(false, false, 0, false, false)
		SetCamActive(Camera, false)
		DestroyCam(Camera, false)
		Camera = nil
	end

	LocalPlayer["state"]:set("Charizard", false, false)
	TriggerServerEvent("vRP:BucketClient", "Exit")
	TriggerServerEvent("vRP:justObjects")
	SendNUIMessage({ name = "Close" })
	TriggerEvent("hud:Active", true)
	SetNuiFocus(false, false)

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHOSEN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Chosen", function(Data, Callback)
	local Ped = PlayerPedId()
	local Index = Data["index"]

	SetEntityCoords(Ped, SpawnLocations[Index]["Coords"]["x"], SpawnLocations[Index]["Coords"]["y"], SpawnLocations[Index]["Coords"]["z"] - 1)
	SetCamCoord(Camera, SpawnLocations[Index]["Coords"]["x"], SpawnLocations[Index]["Coords"]["y"], SpawnLocations[Index]["Coords"]["z"] + 1)
	SetCamRot(Camera, 0.0, 0.0, 0.0, 2)

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CUSTOMIZATION
-----------------------------------------------------------------------------------------------------------------------------------------
function Customization(Table, Check)
	if LoadModel(Table["Skin"]) then
		if Check then
			if GetEntityModel(PlayerPedId()) ~= GetHashKey(Table["Skin"]) then
				SetPlayerModel(PlayerId(), Table["Skin"])
				SetPedComponentVariation(PlayerPedId(), 5, 0, 0, 1)
			end
		else
			SetPlayerModel(PlayerId(), Table["Skin"])
			SetPedComponentVariation(PlayerPedId(), 5, 0, 0, 1)
		end

		local Ped = PlayerPedId()
		local Random = math.random(#Anims)
		if LoadAnim(Anims[Random]["Dict"]) then
			TaskPlayAnim(Ped, Anims[Random]["Dict"], Anims[Random]["Name"], 8.0, 8.0, -1, 1, 1, 0, 0, 0)
		end

		exports["skinshop"]:Apply(Table["Clothes"], Ped)
		exports["barbershop"]:Apply(Table["Barber"], Ped)
		exports["tattooshop"]:Apply(Table["Tattoos"], Ped)

		LocalPlayer["state"]:set("Charizard", false, false)
	end
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- SPAWN:INCREMENT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("spawn:Increment")
AddEventHandler("spawn:Increment", function(Tables)
	for _, v in pairs(Tables) do
		SpawnLocations[#SpawnLocations + 1] = { ["Coords"] = v["Coords"], ["name"] = "" }
	end
end)
