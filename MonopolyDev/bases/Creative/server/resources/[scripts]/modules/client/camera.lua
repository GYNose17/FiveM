-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local fov_max = 80.0
local fov_min = 5.0
local zoomspeed = 3.0
local speed_lr = 4.0
local speed_ud = 4.0
local toggle_helicam = 51
local toggle_vision = 25
local toggle_rappel = 154
local toggle_lock_on = 22
local toggle_display = 44
local maxtargetdistance = 700
local target_vehicle = nil
local vehicle_display = 0
local helicam = false
local fov = (fov_max + fov_min) * 0.5
local vision_state = 0
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREAD
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		if NetworkIsSessionStarted() then
			DecorRegister("SpotvectorX", 3)
			DecorRegister("SpotvectorY", 3)
			DecorRegister("SpotvectorZ", 3)
			DecorRegister("Target", 3)
			return
		end
		Wait(0)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- OPEN
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		if IsPlayerInPolmav() then
			local lPed = GetPlayerPed(-1)
			local heli = GetVehiclePedIsIn(lPed)

			if IsHeliHighEnough(heli) then
				if IsControlJustPressed(0, toggle_helicam) then
					TriggerEvent("hud:Active", false)
					PlaySoundFrontend(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", false)
					helicam = true
				end

				if IsControlJustPressed(0, toggle_rappel) then
					Citizen.Trace("try to rappel")
					if GetPedInVehicleSeat(heli, 1) == lPed or GetPedInVehicleSeat(heli, 2) == lPed then
						PlaySoundFrontend(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", false)
						TaskRappelFromHeli(GetPlayerPed(-1), 1)
					else
						TriggerEvent("Notify", "vermelho", "Você não pode utilizar o <b>Rapel</b> no momento!", "Aviso",
							5000)
					end
				end
			end

			if IsControlJustPressed(0, toggle_display) and GetPedInVehicleSeat(heli, -1) == lPed then
				ChangeDisplay()
			end
		end

		if helicam then
			SetTimecycleModifier("heliGunCam")
			SetTimecycleModifierStrength(0.3)
			local scaleform = RequestScaleformMovie("HELI_CAM")
			while not HasScaleformMovieLoaded(scaleform) do
				Wait(0)
			end
			local lPed = GetPlayerPed(-1)
			local heli = GetVehiclePedIsIn(lPed)
			local cam = CreateCam("DEFAULT_SCRIPTED_FLY_CAMERA", true)
			AttachCamToEntity(cam, heli, 0.0, 0.0, -1.5, true)
			SetCamRot(cam, 0.0, 0.0, GetEntityHeading(heli))
			SetCamFov(cam, fov)
			RenderScriptCams(true, false, 0, 1, 0)
			PushScaleformMovieFunction(scaleform, "SET_CAM_LOGO")
			PushScaleformMovieFunctionParameterInt(0)
			PopScaleformMovieFunctionVoid()
			local locked_on_vehicle = nil
			while helicam and not IsEntityDead(lPed) and (GetVehiclePedIsIn(lPed) == heli) and IsHeliHighEnough(heli) do
				if IsControlJustPressed(0, toggle_helicam) then
					TriggerEvent("hud:Active", true)
					helicam = false
				end

				if IsControlJustPressed(0, toggle_vision) then
					PlaySoundFrontend(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", false)
					ChangeVision()
				end

				if IsControlJustPressed(0, toggle_display) then
					ChangeDisplay()
				end

				if locked_on_vehicle then
					if DoesEntityExist(locked_on_vehicle) then
						PointCamAtEntity(cam, locked_on_vehicle, 0.0, 0.0, 0.0, true)
						RenderVehicleInfo(locked_on_vehicle)
						local coords1 = GetEntityCoords(heli)
						local coords2 = GetEntityCoords(locked_on_vehicle)
						local target_distance = GetDistanceBetweenCoords(coords1.x, coords1.y, coords1.z, coords2.x,
							coords2.y, coords2.z, false)
						if IsControlJustPressed(0, toggle_lock_on) or target_distance > maxtargetdistance then
							PlaySoundFrontend(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", false)
							DecorRemove(target_vehicle, "Target")
							target_vehicle = nil
							locked_on_vehicle = nil
							local rot = GetCamRot(cam, 2)
							local fov = GetCamFov(cam)
							cam = cam
							DestroyCam(old_cam, false)
							cam = CreateCam("DEFAULT_SCRIPTED_FLY_CAMERA", true)
							AttachCamToEntity(cam, heli, 0.0, 0.0, -1.5, true)
							SetCamRot(cam, rot, 2)
							SetCamFov(cam, fov)
							RenderScriptCams(true, false, 0, 1, 0)
						end
					else
						locked_on_vehicle = nil
						target_vehicle = nil
					end
				else
					local zoomvalue = (1.0 / (fov_max - fov_min)) * (fov - fov_min)
					CheckInputRotation(cam, zoomvalue)
					local vehicle_detected = GetVehicleInView(cam)
					if DoesEntityExist(vehicle_detected) then
						RenderVehicleInfo(vehicle_detected)
						if IsControlJustPressed(0, toggle_lock_on) then
							PlaySoundFrontend(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", false)
							locked_on_vehicle = vehicle_detected

							if target_vehicle then
								DecorRemove(target_vehicle, "Target")
							end

							target_vehicle = vehicle_detected
							NetworkRequestControlOfEntity(target_vehicle)
							local target_netID = VehToNet(target_vehicle)
							SetNetworkIdCanMigrate(target_netID, true)
							NetworkRegisterEntityAsNetworked(VehToNet(target_vehicle))
							SetNetworkIdExistsOnAllMachines(target_vehicle, true)
							SetEntityAsMissionEntity(target_vehicle, true, true)
							target_plate = GetVehicleNumberPlateText(target_vehicle)
							DecorSetInt(locked_on_vehicle, "Target", 2)
						end
					end
				end

				HandleZoom(cam)
				HideHUDThisFrame()
				PushScaleformMovieFunction(scaleform, "SET_ALT_FOV_HEADING")
				PushScaleformMovieFunctionParameterFloat(GetEntityCoords(heli).z)
				PushScaleformMovieFunctionParameterFloat(zoomvalue)
				PushScaleformMovieFunctionParameterFloat(GetCamRot(cam, 2).z)
				PopScaleformMovieFunctionVoid()
				DrawScaleformMovieFullscreen(scaleform, 255, 255, 255, 255)
				Wait(0)
			end
			helicam = false
			ClearTimecycleModifier()
			fov = (fov_max + fov_min) * 0.5
			RenderScriptCams(false, false, 0, 1, 0)
			SetScaleformMovieAsNoLongerNeeded(scaleform)
			DestroyCam(cam, false)
			SetNightvision(false)
			SetSeethrough(false)
		end

		if IsPlayerInPolmav() and target_vehicle and not helicam and vehicle_display ~= 2 then
			RenderVehicleInfo(target_vehicle)
		end
		Wait(0)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ISPLAYERINPOLMAV
-----------------------------------------------------------------------------------------------------------------------------------------
function IsPlayerInPolmav()
	local lPed = GetPlayerPed(-1)
	local vehicle = GetVehiclePedIsIn(lPed)
	for i = 1, #AllowVehicles do
		rightveh = IsVehicleModel(vehicle, AllowVehicles[i])
		if rightveh then
			return IsVehicleModel(vehicle, AllowVehicles[i])
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ISHELIHIGHENOUGH
-----------------------------------------------------------------------------------------------------------------------------------------
function IsHeliHighEnough(heli)
	return GetEntityHeightAboveGround(heli) > 1.5
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHANGEVISION
-----------------------------------------------------------------------------------------------------------------------------------------
function ChangeVision()
	if vision_state == 0 then
		SetNightvision(true)
		vision_state = 1
	elseif vision_state == 1 then
		SetNightvision(false)
		SetSeethrough(true)
		vision_state = 2
	else
		SetSeethrough(false)
		vision_state = 0
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHANGEDISPLAY
-----------------------------------------------------------------------------------------------------------------------------------------
function ChangeDisplay()
	if vehicle_display == 0 then
		vehicle_display = 1
	elseif vehicle_display == 1 then
		vehicle_display = 2
	else
		vehicle_display = 0
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- HIDEHUDTHISFRAME
-----------------------------------------------------------------------------------------------------------------------------------------
function HideHUDThisFrame()
	HideHelpTextThisFrame()
	HideHudAndRadarThisFrame()
	HideHudComponentThisFrame(19)
	HideHudComponentThisFrame(1)
	HideHudComponentThisFrame(2)
	HideHudComponentThisFrame(3)
	HideHudComponentThisFrame(4)
	HideHudComponentThisFrame(13)
	HideHudComponentThisFrame(11)
	HideHudComponentThisFrame(12)
	HideHudComponentThisFrame(15)
	HideHudComponentThisFrame(18)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKINPUTROTATION
-----------------------------------------------------------------------------------------------------------------------------------------
function CheckInputRotation(cam, zoomvalue)
	local rightAxisX = GetDisabledControlNormal(0, 220)
	local rightAxisY = GetDisabledControlNormal(0, 221)
	local rotation = GetCamRot(cam, 2)
	if rightAxisX ~= 0.0 or rightAxisY ~= 0.0 then
		new_z = rotation.z + rightAxisX * -1.0 * (speed_ud) * (zoomvalue + 0.1)
		new_x = math.max(math.min(20.0, rotation.x + rightAxisY * -1.0 * (speed_lr) * (zoomvalue + 0.1)), -89.5)
		SetCamRot(cam, new_x, 0.0, new_z, 2)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- HANDLEZOOM
-----------------------------------------------------------------------------------------------------------------------------------------
function HandleZoom(cam)
	if IsControlJustPressed(0, 241) then
		fov = math.max(fov - zoomspeed, fov_min)
	end
	if IsControlJustPressed(0, 242) then
		fov = math.min(fov + zoomspeed, fov_max)
	end
	local current_fov = GetCamFov(cam)
	if math.abs(fov - current_fov) < 0.1 then
		fov = current_fov
	end
	SetCamFov(cam, current_fov + (fov - current_fov) * 0.05)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETVEHICLEINVIEW
-----------------------------------------------------------------------------------------------------------------------------------------
function GetVehicleInView(cam)
	local coords = GetCamCoord(cam)
	local forward_vector = RotAnglesToVec(GetCamRot(cam, 2))
	local rayhandle = CastRayPointToPoint(coords, coords + (forward_vector * 200.0), 10,
		GetVehiclePedIsIn(GetPlayerPed(-1)), 0)
	local _, _, _, _, entityHit = GetRaycastResult(rayhandle)
	if entityHit > 0 and IsEntityAVehicle(entityHit) then
		return entityHit
	else
		return nil
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- RENDERVEHICLEINFO
-----------------------------------------------------------------------------------------------------------------------------------------
function RenderVehicleInfo(vehicle)
	if DoesEntityExist(vehicle) then
		local model = GetEntityModel(vehicle)
		local vehname = GetLabelText(GetDisplayNameFromVehicleModel(model))
		local licenseplate = GetVehicleNumberPlateText(vehicle)
		vehspeed = GetEntitySpeed(vehicle) * 2.236936

		SetTextFont(0)
		SetTextProportional(1)
		if vehicle_display == 0 then
			SetTextScale(0.0, 0.49)
		elseif vehicle_display == 1 then
			SetTextScale(0.0, 0.55)
		end
		SetTextColour(255, 255, 255, 255)
		SetTextDropshadow(0, 0, 0, 0, 255)
		SetTextEdge(1, 0, 0, 0, 255)
		SetTextDropShadow()
		SetTextOutline()
		SetTextEntry("STRING")
		if vehicle_display == 0 then
			AddTextComponentString("Velocidade: " ..
				math.ceil(vehspeed) .. " KM/H" .. "\nModelo: " .. vehname .. "\nPlaca: " .. licenseplate)
		elseif vehicle_display == 1 then
			AddTextComponentString("Modelo: " .. vehname .. "\nPlaca: " .. licenseplate)
		end
		DrawText(0.45, 0.9)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ROTANGLESTOVEC
-----------------------------------------------------------------------------------------------------------------------------------------
function RotAnglesToVec(rot)
	local z = math.rad(rot.z)
	local x = math.rad(rot.x)
	local num = math.abs(math.cos(x))
	return vector3(-math.sin(z) * num, math.cos(z) * num, math.sin(x))
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ENUMERATEENTITIES
-----------------------------------------------------------------------------------------------------------------------------------------
local entityEnumerator = {
	__gc = function(enum)
		if enum.destructor and enum.handle then
			enum.destructor(enum.handle)
		end
		enum.destructor = nil
		enum.handle = nil
	end
}
local function EnumerateEntities(initFunc, moveFunc, disposeFunc)
	return coroutine.wrap(function()
		local iter, id = initFunc()
		if not id or id == 0 then
			disposeFunc(iter)
			return
		end

		local enum = { handle = iter, destructor = disposeFunc }
		setmetatable(enum, entityEnumerator)

		local next = true
		repeat
			coroutine.yield(id)
			next, id = moveFunc(iter)
		until not next

		enum.destructor, enum.handle = nil, nil
		disposeFunc(iter)
	end)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ENUMERATEVEHICLES
-----------------------------------------------------------------------------------------------------------------------------------------
function EnumerateVehicles()
	return EnumerateEntities(FindFirstVehicle, FindNextVehicle, EndFindVehicle)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- FINDVEHICLEBYPLATE
-----------------------------------------------------------------------------------------------------------------------------------------
function FindVehicleByPlate(Plate)
	for vehicle in EnumerateVehicles() do
		if GetVehicleNumberPlateText(vehicle) == Plate then
			return vehicle
		end
	end
end