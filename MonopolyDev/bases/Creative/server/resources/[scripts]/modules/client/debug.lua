-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Debug = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- TOGGLEDEBUG
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("debug:Toggle")
AddEventHandler("debug:Toggle",function()
	Debug = not Debug

	if Debug then
		debugon()
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DEBUG:TARGET
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("debug:Target")
AddEventHandler("debug:Target", function()
	CreateThread(function()
		while true do
			local Ped = PlayerPedId()
			local Camera = GetGameplayCamCoord()
			local Handler = StartExpensiveSynchronousShapeTestLosProbe(Camera,GetCoordsFromCam(25.0,Camera),-1,Ped,4)
			local _,_,Coords = GetShapeTestResult(Handler)

			DrawMarker(28,Coords["x"],Coords["y"],Coords["z"],0.0,0.0,0.0,0.0,0.0,0.0,0.05,0.05,0.05,65,130,226,100,0,0,0,0)

			if IsControlJustPressed(1,38) then
				TriggerServerEvent("admin:CopyCoords",Coords)
				break
			end

			Wait(1)
		end
	end)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETVEHICLE
-----------------------------------------------------------------------------------------------------------------------------------------
function GetVehicle()
	local playerped = GetPlayerPed(-1)
	local playerCoords = GetEntityCoords(playerped)
	local handle, ped = FindFirstVehicle()
	local success
	local rped = nil
	local distanceFrom

	repeat
		local pos = GetEntityCoords(ped)
		local distance = GetDistanceBetweenCoords(playerCoords, pos, true)
		if canPedBeUsed(ped) and distance < 3.0 and (distanceFrom == nil or distance < distanceFrom) then
			distanceFrom = distance
			rped = ped

			if IsEntityTouchingEntity(GetPlayerPed(-1), ped) then
				DrawText3D(pos["x"],pos["y"],pos["z"]+1, "Veh: " .. ped .. " Model: " .. GetEntityModel(ped) .. " IN CONTACT" )
			else
				DrawText3D(pos["x"],pos["y"],pos["z"]+1, "Veh: " .. ped .. " Model: " .. GetEntityModel(ped) .. "" )
			end
		end

		success, ped = FindNextVehicle(handle)
	until not success

	EndFindVehicle(handle)

	return rped
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETOBJECT
-----------------------------------------------------------------------------------------------------------------------------------------
function GetObject()
	local playerped = GetPlayerPed(-1)
	local playerCoords = GetEntityCoords(playerped)
	local handle, ped = FindFirstObject()
	local success
	local rped = nil
	local distanceFrom

	repeat
		local pos = GetEntityCoords(ped)
		local distance = GetDistanceBetweenCoords(playerCoords, pos, true)
		if distance < 15.0 then
			distanceFrom = distance
			rped = ped

			if IsEntityTouchingEntity(GetPlayerPed(-1), ped) then
				DrawText3D(pos["x"],pos["y"],pos["z"]+1, "Obj: " .. ped .. " Model: " .. GetEntityModel(ped) .. " IN CONTACT" )
			else
				DrawText3D(pos["x"],pos["y"],pos["z"]+1, "Obj: " .. ped .. " Model: " .. GetEntityModel(ped) .. "" )
			end
		end

		success, ped = FindNextObject(handle)
	until not success

	EndFindObject(handle)

	return rped
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETNPC
-----------------------------------------------------------------------------------------------------------------------------------------
function getNPC()
	local playerped = GetPlayerPed(-1)
	local playerCoords = GetEntityCoords(playerped)
	local handle, ped = FindFirstPed()
	local success
	local rped = nil
	local distanceFrom

	repeat
		local pos = GetEntityCoords(ped)
		local distance = GetDistanceBetweenCoords(playerCoords, pos, true)
		if canPedBeUsed(ped) and distance < 3.0 and (distanceFrom == nil or distance < distanceFrom) then
			distanceFrom = distance
			rped = ped

			if IsEntityTouchingEntity(GetPlayerPed(-1), ped) then
				DrawText3D(pos["x"],pos["y"],pos["z"], "Ped: " .. ped .. " Model: " .. GetEntityModel(ped) .. " Relationship HASH: " .. GetPedRelationshipGroupHash(ped) .. " IN CONTACT" )
			else
				DrawText3D(pos["x"],pos["y"],pos["z"], "Ped: " .. ped .. " Model: " .. GetEntityModel(ped) .. " Relationship HASH: " .. GetPedRelationshipGroupHash(ped) )
			end
		end

		success, ped = FindNextPed(handle)
	until not success

	EndFindPed(handle)

	return rped
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CANPEDBEUSED
-----------------------------------------------------------------------------------------------------------------------------------------
function canPedBeUsed(ped)
	if ped == nil then
		return false
	end

	if ped == GetPlayerPed(-1) then
		return false
	end

	if not DoesEntityExist(ped) then
		return false
	end

	return true
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DEBUGON
-----------------------------------------------------------------------------------------------------------------------------------------
function debugon()
	CreateThread(function()
		while true do
			Wait(1)

			if Debug then
				local pos = GetEntityCoords(GetPlayerPed(-1))
				local forPos = GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), 0, 1.0, 0.0)
				local backPos = GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), 0, -1.0, 0.0)
				local LPos = GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), 1.0, 0.0, 0.0)
				local RPos = GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), -1.0, 0.0, 0.0) 
				local forPos2 = GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), 0, 2.0, 0.0)
				local backPos2 = GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), 0, -2.0, 0.0)
				local LPos2 = GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), 2.0, 0.0, 0.0)
				local RPos2 = GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), -2.0, 0.0, 0.0)    
				local x, y, z = table.unpack(GetEntityCoords(GetPlayerPed(-1), true))
				local currentStreetHash, intersectStreetHash = GetStreetNameAtCoord(x, y, z, currentStreetHash, intersectStreetHash)
				currentStreetName = GetStreetNameFromHashKey(currentStreetHash)

				DrawText2D(0.20,0.70,0.4,0.4,0.30, "~w~Heading: ~g~" .. GetEntityHeading(GetPlayerPed(-1)),55,155,55,255)
				DrawText2D(0.20,0.72,0.4,0.4,0.30, "~w~Coords: ~g~" .. pos,55,155,55,255)
				DrawText2D(0.20,0.74,0.4,0.4,0.30, "~w~Attached Ent: ~g~" .. GetEntityAttachedTo(GetPlayerPed(-1)),55,155,55,255)
				DrawText2D(0.20,0.76,0.4,0.4,0.30, "~w~Health: ~g~" .. GetEntityHealth(GetPlayerPed(-1)),55,155,55,255)
				DrawText2D(0.20,0.78,0.4,0.4,0.30, "~w~H a G: ~g~" .. GetEntityHeightAboveGround(GetPlayerPed(-1)),55,155,55,255)
				DrawText2D(0.20,0.80,0.4,0.4,0.30, "~w~Model: ~g~" .. GetEntityModel(GetPlayerPed(-1)),55,155,55,255)
				DrawText2D(0.20,0.82,0.4,0.4,0.30, "~w~Speed: ~g~" .. GetEntitySpeed(GetPlayerPed(-1)),55,155,55,255)
				DrawText2D(0.20,0.84,0.4,0.4,0.30, "~w~Frame Time: ~g~" .. GetFrameTime(),55,155,55,255)
				DrawText2D(0.20,0.86,0.4,0.4,0.30, "~w~Street: ~g~" .. currentStreetName,55,155,55,255)

				local nearped = getNPC()
				local veh = GetVehicle()
				local nearobj = GetObject()
			else
				Wait(5000)
			end
		end
	end)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DRAWTEXT2D
-----------------------------------------------------------------------------------------------------------------------------------------
function DrawText2D(x,y,width,height,scale,text,r,g,b,a)
	SetTextFont(4)
	SetTextProportional(0)
	SetTextScale(0.30,0.30)
	SetTextColour(r,g,b,a)
	SetTextDropShadow(0,0,0,0,255)
	SetTextEdge(1,0,0,0,255)
	SetTextDropShadow()
	SetTextOutline()
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(x-width/2,y-height/2+0.005)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DRAWTEXT3D
-----------------------------------------------------------------------------------------------------------------------------------------
function DrawText3D(x,y,z,text)
	local onScreen,_x,_y = GetScreenCoordFromWorldCoord(x,y,z)

	if onScreen then
		BeginTextCommandDisplayText("STRING")
		AddTextComponentSubstringKeyboardDisplay(text)
		SetTextColour(255,255,255,150)
		SetTextScale(0.35,0.35)
		SetTextFont(4)
		SetTextCentre(1)
		EndTextCommandDisplayText(_x,_y)

		local width = string.len(text) / 160 * 0.45
		DrawRect(_x,_y + 0.0125,width,0.03,0,0,0,150)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETCOORDSFROMCAM
-----------------------------------------------------------------------------------------------------------------------------------------
function GetCoordsFromCam(Distance,Coords)
	local Rotation = GetGameplayCamRot()
	local Adjustes = vec3((math.pi / 180) * Rotation["x"],(math.pi / 180) * Rotation["y"],(math.pi / 180) * Rotation["z"])
	local Direction = vec3(-math.sin(Adjustes[3]) * math.abs(math.cos(Adjustes[1])),math.cos(Adjustes[3]) * math.abs(math.cos(Adjustes[1])),math.sin(Adjustes[1]))

	return vec3(Coords[1] + Direction[1] * Distance, Coords[2] + Direction[2] * Distance, Coords[3] + Direction[3] * Distance)
end