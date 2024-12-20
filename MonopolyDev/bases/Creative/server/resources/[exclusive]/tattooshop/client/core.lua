-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
vSERVER = Tunnel.getInterface("tattooshop")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Active = {}
local Camera = nil
local Default = nil
local Tattooshop = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- TATTOOSHOP:APPLY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("tattooshop:Apply")
AddEventHandler("tattooshop:Apply", function(Table)
	Tattooshop = Table
	exports["tattooshop"]:Apply()
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- APPLY
-----------------------------------------------------------------------------------------------------------------------------------------
exports("Apply", function(Table, Ped)
	if not Ped then
		Ped = PlayerPedId()
	end

	if Table then
		Tattooshop = Table
	end

	ClearPedDecorations(Ped)

	for Index, Overlay in pairs(Tattooshop) do
		AddPedDecorationFromHashes(Ped, Overlay, Index)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- OPENTATTOOSHOP
-----------------------------------------------------------------------------------------------------------------------------------------
function OpenTattooshop()
	CameraActive()
	SetNuiFocus(true, true)

	local Ped = PlayerPedId()
	if GetEntityModel(Ped) == GetHashKey("mp_f_freemode_01") then
		Active = Dataset["mp_f_freemode_01"]

		SetPedComponentVariation(Ped, 1, Preset["mp_f_freemode_01"]["mask"]["item"], Preset["mp_f_freemode_01"]["mask"]["texture"], 1)
		SetPedComponentVariation(Ped, 3, Preset["mp_f_freemode_01"]["arms"]["item"], Preset["mp_f_freemode_01"]["arms"]["texture"], 1)
		SetPedComponentVariation(Ped, 4, Preset["mp_f_freemode_01"]["pants"]["item"], Preset["mp_f_freemode_01"]["pants"]["texture"], 1)
		SetPedComponentVariation(Ped, 5, Preset["mp_f_freemode_01"]["backpack"]["item"], Preset["mp_f_freemode_01"]["backpack"]["texture"], 1)
		SetPedComponentVariation(Ped, 6, Preset["mp_f_freemode_01"]["shoes"]["item"], Preset["mp_f_freemode_01"]["shoes"]["texture"], 1)
		SetPedComponentVariation(Ped, 7, Preset["mp_f_freemode_01"]["accessory"]["item"], Preset["mp_f_freemode_01"]["accessory"]["texture"], 1)
		SetPedComponentVariation(Ped, 8, Preset["mp_f_freemode_01"]["tshirt"]["item"], Preset["mp_f_freemode_01"]["tshirt"]["texture"], 1)
		SetPedComponentVariation(Ped, 9, Preset["mp_f_freemode_01"]["vest"]["item"], Preset["mp_f_freemode_01"]["vest"]["texture"], 1)
		SetPedComponentVariation(Ped, 10, Preset["mp_f_freemode_01"]["decals"]["item"], Preset["mp_f_freemode_01"]["decals"]["texture"], 1)
		SetPedComponentVariation(Ped, 11, Preset["mp_f_freemode_01"]["torso"]["item"], Preset["mp_f_freemode_01"]["torso"]["texture"], 1)
	else
		Active = Dataset["mp_m_freemode_01"]

		SetPedComponentVariation(Ped, 1, Preset["mp_m_freemode_01"]["mask"]["item"], Preset["mp_m_freemode_01"]["mask"]["texture"], 1)
		SetPedComponentVariation(Ped, 3, Preset["mp_m_freemode_01"]["arms"]["item"], Preset["mp_m_freemode_01"]["arms"]["texture"], 1)
		SetPedComponentVariation(Ped, 4, Preset["mp_m_freemode_01"]["pants"]["item"], Preset["mp_m_freemode_01"]["pants"]["texture"], 1)
		SetPedComponentVariation(Ped, 5, Preset["mp_m_freemode_01"]["backpack"]["item"], Preset["mp_m_freemode_01"]["backpack"]["texture"], 1)
		SetPedComponentVariation(Ped, 6, Preset["mp_m_freemode_01"]["shoes"]["item"], Preset["mp_m_freemode_01"]["shoes"]["texture"], 1)
		SetPedComponentVariation(Ped, 7, Preset["mp_m_freemode_01"]["accessory"]["item"], Preset["mp_m_freemode_01"]["accessory"]["texture"], 1)
		SetPedComponentVariation(Ped, 8, Preset["mp_m_freemode_01"]["tshirt"]["item"], Preset["mp_m_freemode_01"]["tshirt"]["texture"], 1)
		SetPedComponentVariation(Ped, 9, Preset["mp_m_freemode_01"]["vest"]["item"], Preset["mp_m_freemode_01"]["vest"]["texture"], 1)
		SetPedComponentVariation(Ped, 10, Preset["mp_m_freemode_01"]["decals"]["item"], Preset["mp_m_freemode_01"]["decals"]["texture"], 1)
		SetPedComponentVariation(Ped, 11, Preset["mp_m_freemode_01"]["torso"]["item"], Preset["mp_m_freemode_01"]["torso"]["texture"], 1)
	end

	ClearAllPedProps(Ped)

	vRP.playAnim(true, { "mp_sleep", "bind_pose_180" }, true)

	SendNUIMessage({ shop = Active, tattoo = Tattooshop })
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- CAMERAACTIVE
-----------------------------------------------------------------------------------------------------------------------------------------
function CameraActive()
	if DoesCamExist(Camera) then
		RenderScriptCams(false, false, 0, false, false)
		SetCamActive(Camera, false)
		DestroyCam(Camera, false)
		Camera = nil
	end

	local Ped = PlayerPedId()
	local Heading = GetEntityHeading(Ped)
	Camera = CreateCam("DEFAULT_SCRIPTED_CAMERA", true)
	local Coords = GetOffsetFromEntityInWorldCoords(Ped, 0.25, 1.0, 0.0)

	SetCamCoord(Camera, Coords["x"], Coords["y"], Coords["z"])

	RenderScriptCams(true, true, 100, true, true)
	SetCamRot(Camera, 0.0, 0.0, Heading + 180)
	SetEntityHeading(Ped, Heading)
	SetCamActive(Camera, true)
	Default = Coords["z"]
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- CLOSE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Close", function(Data, Callback)
	if DoesCamExist(Camera) then
		RenderScriptCams(false, false, 0, false, false)
		SetCamActive(Camera, false)
		DestroyCam(Camera, false)
		Camera = nil
	end

	exports["skinshop"]:Apply()
	vSERVER.Update(Tattooshop)
	SetNuiFocus(false, false)
	vRP.Destroy()

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADSTART
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	local Tables = {}

	for Number = 1, #TattooLocations do
		Tables[#Tables + 1] = { TattooLocations[Number]["x"], TattooLocations[Number]["y"], TattooLocations[Number]["z"],
			2.0, "E", "Tatuagem", "Pressione para abrir" }
	end

	TriggerEvent("hoverfy:Insert", Tables)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADTattooLocations
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		local TimeDistance = 999
		local Ped = PlayerPedId()
		if not IsPedInAnyVehicle(Ped) then
			local Coords = GetEntityCoords(Ped)

			for Number = 1, #TattooLocations do
				if #(Coords - TattooLocations[Number]) <= 2.0 then
					TimeDistance = 1

					if IsControlJustPressed(1, 38) and not exports["hud"]:Wanted() and not exports["hud"]:Reposed() then
						OpenTattooshop()
					end
				end
			end
		end

		Wait(TimeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHANGE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Change", function(Data, Callback)
	local Ped = PlayerPedId()
	local Number = Data["id"]
	local Types = Data["type"]

	if Active[Types] and Active[Types][Number] then
		local Name = Active[Types][Number]["name"]

		if Tattooshop[Name] then
			Tattooshop[Name] = nil
		else
			Tattooshop[Name] = Active[Types][Number]["part"]
		end

		ClearPedDecorations(Ped)

		for Index, Overlay in pairs(Tattooshop) do
			AddPedDecorationFromHashes(Ped, Overlay, Index)
		end
	end

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLEAN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Clean", function(Data, Callback)
	ClearPedDecorations(PlayerPedId())
	Tattooshop = {}

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ROTATE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Rotate", function(Data, Callback)
	local Ped = PlayerPedId()

	if Data["direction"] == "Left" then
		SetEntityHeading(Ped, GetEntityHeading(Ped) - 5)
	elseif Data["direction"] == "Right" then
		SetEntityHeading(Ped, GetEntityHeading(Ped) + 5)
	elseif Data["direction"] == "Top" then
		local Coords = GetCamCoord(Camera)
		if Coords["z"] + 0.05 <= Default + 0.50 then
			SetCamCoord(Camera, Coords["x"], Coords["y"], Coords["z"] + 0.05)
		end
	elseif Data["direction"] == "Bottom" then
		local Coords = GetCamCoord(Camera)
		if Coords["z"] - 0.05 >= Default - 0.50 then
			SetCamCoord(Camera, Coords["x"], Coords["y"], Coords["z"] - 0.05)
		end
	end

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HANDSUP
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("HandsUp", function(Data, Callback)
	local Ped = PlayerPedId()
	if IsEntityPlayingAnim(Ped, "random@mugging3", "handsup_standing_base", 3) then
		StopAnimTask(Ped, "random@mugging3", "handsup_standing_base", 8.0)
		vRP.AnimActive()
	else
		vRP.playAnim(true, { "random@mugging3", "handsup_standing_base" }, true)
	end

	Callback("Ok")
end)
