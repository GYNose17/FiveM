-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Packages = 0
local Blip = nil
local BoxVehicles = {}
local inService = false
local inPackage = false
local HandPackage = false
local InitPackage = { -439.03, -2796.89, 7.3 }
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADPACKAGE
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		local timeDistance = 500
		local ped = PlayerPedId()

		if inService then
			if not IsPedInAnyVehicle(ped) then
				local vehicle = getNearVehicle(11)
				local coords = GetEntityCoords(ped)

				if DoesEntityExist(vehicle) and GetEntityModel(vehicle) == GetHashKey("boxville4") then
					local coordsVeh = GetOffsetFromEntityInWorldCoords(vehicle, 0.0, -3.5, 0.0)
					local distance = #(coords - coordsVeh)
					if distance <= 1.2 then
						timeDistance = 4
						local plate = GetVehicleNumberPlateText(vehicle)

						if inPackage then
							if BoxVehicles[plate] == nil then
								DrawText3D(coordsVeh.x, coordsVeh.y, coordsVeh.z,
									"~g~G~w~  GUARDAR  ~b~0/" .. MaximumPackages, 550, 0.0225, 0.06)
							else
								DrawText3D(coordsVeh.x, coordsVeh.y, coordsVeh.z,
									"~g~G~w~  GUARDAR  ~b~" .. BoxVehicles[plate] .. "/" .. MaximumPackages, 550, 0.0225,
									0.06)
							end

							if IsControlJustPressed(1, 47) and BAIXADA_SERVER.AddPackage(plate) then
								inPackage = false
								HandPackage = false
								vRP.Destroy("one")
							end
						else
							if BoxVehicles[plate] == nil then
								DrawText3D(coordsVeh.x, coordsVeh.y, coordsVeh.z,
									"~g~G~w~  GUARDAR  ~b~0/" .. MaximumPackages, 550, 0.0225, 0.06)
							else
								DrawText3D(coordsVeh.x, coordsVeh.y, coordsVeh.z,
									"~g~G~w~  RETIRAR  ~b~" .. BoxVehicles[plate] .. "/" .. MaximumPackages, 550, 0.0225,
									0.06)
							end

							if IsControlJustPressed(1, 47) and BoxVehicles[plate] then
								if BoxVehicles[plate] > 0 then
									inPackage = true
									HandPackage = true
									TriggerServerEvent("postop:Remove", plate)
									vRP.CreateObjects("anim@heists@box_carry@", "idle", "hei_prop_heist_box", 50, 28422)
								end
							end
						end
					end
				end

				local distance = #(coords - vector3(InitPackage[1], InitPackage[2], InitPackage[3]))
				if distance <= 2 then
					timeDistance = 4

					if inPackage then
						DrawText3D(InitPackage[1], InitPackage[2], InitPackage[3], "~g~G~w~  GUARDAR", 350, 0.0125, 0.03)
					else
						DrawText3D(InitPackage[1], InitPackage[2], InitPackage[3], "~g~G~w~  RETIRAR", 350, 0.0125, 0.03)
					end

					if IsControlJustPressed(1, 47) then
						if inPackage then
							inPackage = false
							vRP.Destroy("one")
						else
							inPackage = true
							vRP.CreateObjects("anim@heists@box_carry@", "idle", "hei_prop_heist_box", 50, 28422)
						end
					end
				end

				local distance = #(coords - vector3(DeliveryCoords[Packages][1], DeliveryCoords[Packages][2], DeliveryCoords[Packages][3]))
				if distance <= 30 then
					timeDistance = 4
					DrawText3D(DeliveryCoords[Packages][1], DeliveryCoords[Packages][2], DeliveryCoords[Packages][3],
						"~g~G~w~  ENTREGAR", 350, 0.0125, 0.03)
					if distance <= 0.6 and IsControlJustPressed(1, 47) and HandPackage then
						inPackage = false
						HandPackage = false
						BAIXADA_SERVER.PaymentPackage()
						vRP.Destroy("one")
						BlipMarkerService()
					end
				end
			end
		end

		Wait(timeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADBLOCK
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		local timeDistance = 500
		if inPackage then
			timeDistance = 4
			DisableControlAction(1, 245, true)
			DisableControlAction(1, 167, true)
			DisableControlAction(1, 21, true)
			DisableControlAction(1, 22, true)
			DisableControlAction(1, 23, true)
		end

		Wait(timeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- POSTOP:UPDATE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("postop:Update")
AddEventHandler("postop:Update", function(status)
	BoxVehicles = status
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- POSTOP:INIT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("postop:Init")
AddEventHandler("postop:Init", function()
	if inService then
		inService = false

		TriggerEvent("Notify", "amarelo", "Trabalho finalizado.", "Atenção", 5000)
		exports["target"]:LabelText("WorkPostman", "Trabalhar")

		if Blip and DoesBlipExist(Blip) then
			RemoveBlip(Blip)
			Blip = nil
		end
	else
		inService = true

		TriggerEvent("Notify", "verde", "Trabalho iniciado.", "Sucesso", 5000)
		exports["target"]:LabelText("WorkPostman", "Finalizar")

		BlipMarkerService()
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- BLIPMARKERSERVICE
-----------------------------------------------------------------------------------------------------------------------------------------
function BlipMarkerService()
	if Blip and DoesBlipExist(Blip) then
		RemoveBlip(Blip)
		Blip = nil
	end

	Packages = math.random(#DeliveryCoords)
	Blip = AddBlipForCoord(DeliveryCoords[Packages][1], DeliveryCoords[Packages][2], DeliveryCoords[Packages][3])
	SetBlipSprite(Blip, 1)
	SetBlipColour(Blip, 77)
	SetBlipScale(Blip, 0.5)
	SetBlipRoute(Blip, true)
	SetBlipAsShortRange(Blip, true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("Entrega")
	EndTextCommandSetBlipName(Blip)
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- DRAWTEXT3D
-----------------------------------------------------------------------------------------------------------------------------------------
function DrawText3D(x, y, z, text)
	local onScreen, _x, _y = GetScreenCoordFromWorldCoord(x, y, z)

	if onScreen then
		SetTextFont(4)
		SetTextCentre(true)
		SetTextProportional(1)
		SetTextScale(0.35, 0.35)
		SetTextColour(255, 255, 255, 150)

		SetTextEntry("STRING")
		AddTextComponentString(text)
		EndTextCommandDisplayText(_x, _y)

		local Width = string.len(text) / 160 * 0.45
		DrawRect(_x, _y + 0.0125, Width, 0.03, 15, 15, 15, 175)
	end
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- GETNEARVEHICLES
-----------------------------------------------------------------------------------------------------------------------------------------
function getNearVehicles(radius)
	local r = {}
	local coords = GetEntityCoords(PlayerPedId())

	local vehs = {}
	local it, veh = FindFirstVehicle()
	if veh then
		table.insert(vehs, veh)
	end
	local ok
	repeat
		ok, veh = FindNextVehicle(it)
		if ok and veh then
			table.insert(vehs, veh)
		end
	until not ok
	EndFindVehicle(it)

	for _, veh in pairs(vehs) do
		local coordsVeh = GetEntityCoords(veh)
		local distance = #(coords - coordsVeh)
		if distance <= radius then
			r[veh] = distance
		end
	end
	return r
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- GETNEARVEHICLE
-----------------------------------------------------------------------------------------------------------------------------------------
function getNearVehicle(radius)
	local veh
	local vehs = getNearVehicles(radius)
	local min = radius + 0.0001
	for _veh, dist in pairs(vehs) do
		if dist < min then
			min = dist
			veh = _veh
		end
	end
	return veh
end
