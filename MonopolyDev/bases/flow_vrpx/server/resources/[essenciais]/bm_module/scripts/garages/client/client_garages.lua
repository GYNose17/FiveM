---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS  GERAIS
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
garages = garagesConfig.garagesLocs
types = garagesConfig.typeGarages

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS  GARAGEM
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
nearestGarages = {}
blockDuplicate = {}
opennedGarageId = 0
opennedGarageType = ""
segundos = 0
lock = false
vehicleClasses = { [0] = "vehicle", [1] = "vehicle", [2] = "vehicle", [3] = "vehicle", [4] = "vehicle", [5] = "vehicle", [6] = "vehicle", [7] = "vehicle", [8] = "vehicle", [9] = "vehicle", [10] = "vehicle", [11] = "vehicle", [12] = "vehicle", [13] = "vehicle", [14] = "boat", [15] = "heli", [16] = "heli", [17] = "vehicle", [18] = "vehicle", [19] = "vehicle", [20] = "vehicle", }

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- THREAD
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
    while true do  
        local time = 1000
        local plyCoords = GetEntityCoords(PlayerPedId())

        for i in pairs(nearestGarages) do
            if nearestGarages[i] then
                time = 5

                local coords = nearestGarages[i].coords
                local distance = #(plyCoords - coords)

                DrawMarker(36,coords.x,coords.y,coords.z,0,0,0,0,0,0,1.0,1.0,1.0, 167, 59, 255,155, 1,1,1,1)
                DrawMarker(27,coords.x,coords.y,coords.z-0.97,0,0,0,0,0,0,1.0,1.0,0.5, 167, 59, 255,155, 0,0,0,1)

                if IsControlJustPressed(0,38) and distance < 2 then
                    if nearestGarages[i].permiss == nil or vTunnel.garageCheckPermission(nearestGarages[i].permiss) then
                        if nearestGarages[i].type == "Homes" then
                            if vTunnel.garageCheckHouseOwner(nearestGarages[i].houseID) then
                                openNui(i, nearestGarages[i].type)
                            end
                        else
                            openNui(i, nearestGarages[i].type)
                        end
                    end
                end

            end
        end

        Wait( time )
    end
end)

CreateThread(function()
    CreateBlips()

    while true do
        local time = 1000
        local pedCoords = GetEntityCoords(PlayerPedId())

        for i in pairs(garages) do
            if #(garages[i].coords - pedCoords) <= garages[i].blipDistance then
                nearestGarages[i] = garages[i]
            elseif nearestGarages[i] then
                nearestGarages[i] = nil
            end
        end

        Wait(time)
    end
end)

CreateThread(function()
    while true do
        if segundos > 0 then
            segundos = segundos - 1
        end

        Wait( 1000 )
    end
end)

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- CALLBACKS
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback('requestGarages', function(data, cb)
    local t = {}
    if types[opennedGarageType].type == "public" then
        local list = vTunnel.garageGetUserVehicles()
        for i = 1, #list do
            if types[opennedGarageType].listCars == nil or types[opennedGarageType].listCars[vehicleClasses[GetVehicleClassFromName(GetHashKey(list[i].vehicle))]] or vehicleClasses[GetVehicleClassFromName(GetHashKey(list[i].vehicle))] == nil then
                t[#t + 1] = {
                    ['vehicle'] = list[i].vehicle,
                    ['name'] = (garagesConfig.listCars[GetHashKey(list[i].vehicle)] == nil) and list[i].vehicle or garagesConfig.listCars[GetHashKey(list[i].vehicle)].name,
                    ['aceleration'] = GetVehicleModelAcceleration(GetHashKey(list[i].vehicle)) or 0,
                    ['maxspeed'] = GetVehicleModelEstimatedMaxSpeed(GetHashKey(list[i].vehicle)) * 3.605936 or 0,
                    ['braking'] = GetVehicleModelMaxBraking(GetHashKey(list[i].vehicle)) or 0,
                    ['agility'] = GetVehicleModelEstimatedAgility(GetHashKey(list[i].vehicle)) or 0,
                    ['plate'] = list[i].plate,
                    ['engine'] = list[i].engine,
                    ['body'] = list[i].body,
                    ['fuel'] = list[i].fuel,
                    ['status'] = list[i].status,
                    ['ipva'] = list[i].ipva,
                    ['custom'] = list[i].custom,
                    ['favorite'] = list[i].favorite
                }
            end
        end
    elseif types[opennedGarageType].type == "service" then
        for i = 1, #types[opennedGarageType].vehicles do
            t[#t + 1] = {
                ['vehicle'] = types[opennedGarageType].vehicles[i].vehicle,
                ['name'] = (garagesConfig.listCars[GetHashKey(types[opennedGarageType].vehicles[i].vehicle)] == nil) and types[opennedGarageType].vehicles[i].vehicle or garagesConfig.listCars[GetHashKey(types[opennedGarageType].vehicles[i].vehicle)].name,
                ['aceleration'] = GetVehicleModelAcceleration(GetHashKey(types[opennedGarageType].vehicles[i].vehicle)) or 0,
                ['maxspeed'] = GetVehicleModelEstimatedMaxSpeed(GetHashKey(types[opennedGarageType].vehicles[i].vehicle)) * 3.605936 or 0,
                ['braking'] = GetVehicleModelMaxBraking(GetHashKey(types[opennedGarageType].vehicles[i].vehicle)) or 0,
                ['agility'] = GetVehicleModelEstimatedAgility(GetHashKey(types[opennedGarageType].vehicles[i].vehicle)) or 0,
                ['plate'] = "Teste",
                ['engine'] = 1000,
                ['body'] = 1000,
                ['fuel'] = 100,
                ['favorite'] = 0,
                ['status'] = 0,
                ['ipva'] = 0,
                ['custom'] = {}
            }
        end
    else
        print(opennedGarageType..": Erro de configuração, contate um administrador")
    end
    
    cb({ cars = t, isPublic = (types[opennedGarageType].type == "public"), dir = garagesConfig.main['dir'] })
end)

RegisterNUICallback('spawnCar', function(data, cb)
    if segundos == 0 then
        segundo = 2

        local spawnCoords = RegisterTunnel.garageCheckSpawnLock(opennedGarageId)
        if spawnCoords then
            if types[opennedGarageType].type == "public" then
                if data.pending then
                    vTunnel._garageTryPaymentVehicle(data.name)
                else
                    TriggerServerEvent("garage:garageTrySpawnVehicle", true, data.name, spawnCoords)
                end
            else
                TriggerServerEvent("garage:garageTrySpawnVehicle", false, data.name, spawnCoords)
            end
        else
            TriggerEvent('Notify', 'negado', 'Todas as vagas dessa garagem estão lotadas.', 5)
        end
        
    end
end)

RegisterNUICallback('storeCar', function(data, cb)
    if segundos == 0 then
        if types[opennedGarageType].type == "public" then
            if data.status then
                local vehicle = GetClosestVehiclePlayer(20.0)
                if vehicle and vehicle > 0 then
                    vTunnel._garageStoreUserVehicle(true, data.name, data.status, VehToNet(vehicle)) -- GUARDAR VEICULO PROXIMO
                else
                    TriggerEvent("Notify","negado","Nenhum veiculo proximo.",5)
                end
            else
                vTunnel._garageStoreUserVehicle(true, data.name)
            end
        else
            if data.status then
                local vehicle = GetClosestVehiclePlayer(20.0)
                if vehicle and vehicle > 0 then
                    vTunnel._garageStoreUserVehicle(false, data.name, data.status, VehToNet(vehicle)) -- GUARDAR VEICULO PROXIMO
                else
                    TriggerEvent("Notify","negado","Nenhum veiculo proximo.",5)
                end
            else
                vTunnel._garageStoreUserVehicle(false, data.name)
            end
        end

        if blockDuplicate[data.name] then
            blockDuplicate[data.name] = nil
        end
    end
end)

RegisterNUICallback('setFavorite', function(data, cb)
    if segundos == 0 then
        segundos = 3
        vTunnel._garageSetFavorite(data.vehicle, data.favorite)
    end
end)

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- FUNCTIONS
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function RegisterTunnel.garageAnimLock(index, v)
    local status = (v == 2) and 'Destrancado' or 'Trancado'
    TriggerEvent("Notify","importante","Veiculo <b>".. status .."</b>",5)
    vRP._playAnim(true, {{"anim@mp_player_intmenu@key_fob@","fob_click"}}, false)

    if NetworkDoesNetworkIdExist(index) then
        TriggerEvent("vrp_sound:source",'lock',0.1)

		local v = NetToVeh(index)
		if DoesEntityExist(v) then
			if IsEntityAVehicle(v) then
				SetVehicleLights(v,2)
				Wait(200)
				SetVehicleLights(v,0)
				Wait(200)
				SetVehicleLights(v,2)
				Wait(200)
				SetVehicleLights(v,0)
			end
		end
	end
end

function RegisterTunnel.syncLock(index)
	if NetworkDoesNetworkIdExist(index) then
		local v = NetToVeh(index)
		if DoesEntityExist(v) then
			if IsEntityAVehicle(v) then
				local locked = GetVehicleDoorLockStatus(v)
				if locked == 1 then
                    TriggerEvent('Notify', 'importante', 'Veiculo Trancado .', 5000)
					SetVehicleDoorsLocked(v,2)
				else
                    TriggerEvent('Notify', 'importante', 'Veiculo Destrancado .', 5000)
					SetVehicleDoorsLocked(v,1)
				end
				SetVehicleLights(v,2)
				Wait(200)
				SetVehicleLights(v,0)
				Wait(200)
				SetVehicleLights(v,2)
				Wait(200)
				SetVehicleLights(v,0)
			end
		end
	end
end

function RegisterTunnel.garageGetNearestVehicle(distance)
    local veh = GetClosestVehiclePlayer(distance)

    if veh then
        return VehToNet(veh)
    end

    return false
end

function RegisterTunnel.garageGetVehicleFuel(veh)
    if IsEntityAVehicle(NetToVeh(veh)) then
        return GetVehicleFuelLevel(NetToVeh(veh))
    end
end

function RegisterTunnel.garageCheckSpawnLock(garageID)
    local spawnCoords
    for k,v in pairs(garages[garageID].spawnCoords) do
        if GetClosestVehicle(v.x,v.y,v.z, 4.0, 0 ,71) == 0 then
            spawnCoords = v
            break;
        end
    end

    return spawnCoords
end

function openNui(id, type)
    opennedGarageId = id
    opennedGarageType = type
    
    SetNuiFocus(true, true)
    SendNUIMessage({ action = "garages" })
end

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- EVENTS
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("garage:clientSpawnVehicle",function(name, info, isPersonal, spawnLoc)
    local mhash = GetHashKey(name)
    if not blockDuplicate[name] then
        blockDuplicate[name] = true
        SetTimeout(10 * 1000, function() if blockDuplicate[name] then blockDuplicate[name] = nil end end)

        while not HasModelLoaded(mhash) do
            RequestModel(mhash)

            Wait(200)
        end

        if isPersonal then
            if spawnLoc then
                local veh = CreateVehicle(mhash, spawnLoc.x,spawnLoc.y,spawnLoc.z,spawnLoc.w, true, true)
                    
                while not DoesEntityExist(veh) do
                    print("Entity nao encontrada")
                    Wait(200)
                end

                while not NetworkDoesEntityExistWithNetworkId(VehToNet(veh)) do
                    print("NETID nao encontrado")
                    Wait(200)
                end

                local netid = VehToNet(veh)

                if not IsEntityAVehicle(veh) then
                    print("Nao e um veiculo")
                    return
                end

                SetVehicleNumberPlateText(veh, info.plate)
                SetEntityAsMissionEntity(veh, true, true)
                SetVehicleOnGroundProperly(veh)
                SetVehRadioStation(veh, "OFF")
                SetVehicleDirtLevel(veh, 0.0)
                SetVehicleDoorsLocked(veh, 2)
                SetPedIntoVehicle(PlayerPedId(),veh,-1)
                SetVehicleEngineHealth(veh, info.engine + 0.0)
                SetVehicleBodyHealth(veh, info.body + 0.0)
                SetVehicleFuelLevel(veh, info.fuel + 0.0)
                SetModelAsNoLongerNeeded(mhash)
                SetVehicleMods(veh, info.custom)

                print(name, netid, isPersonal)
                TriggerServerEvent("garage:registerVehicle", name, netid, isPersonal)
            end
        else
            if spawnLoc then
                local veh = CreateVehicle(mhash, spawnLoc.x,spawnLoc.y,spawnLoc.z,spawnLoc.w, true, true)
                    
                while not DoesEntityExist(veh) do
                    print("Entity nao encontrada")
                    Wait(200)
                end

                while not NetworkDoesEntityExistWithNetworkId(VehToNet(veh)) do
                    print("NETID nao encontrado")
                    Wait(200)
                end

                local netid = VehToNet(veh)

                if not IsEntityAVehicle(veh) then
                    print("Nao e um veiculo")
                    return
                end

                SetVehicleNumberPlateText(veh, info.plate)
                SetEntityAsMissionEntity(veh, true, true)
                SetVehicleOnGroundProperly(veh)
                SetVehRadioStation(veh, "OFF")
                SetVehicleDirtLevel(veh, 0.0)
                SetVehicleDoorsLocked(veh, 2)
                SetPedIntoVehicle(PlayerPedId(),veh,-1)
                SetVehicleEngineHealth(veh, info.engine + 0.0)
                SetVehicleBodyHealth(veh, info.body + 0.0)
                SetVehicleFuelLevel(veh, info.fuel + 0.0)
                SetModelAsNoLongerNeeded(mhash)
                SetVehicleMods(veh, info.custom)

                print(name, netid, isPersonal)
                TriggerServerEvent("garage:registerVehicle", name, netid, isPersonal)
            end
        end
    end
end)

RegisterNetEvent("garage:updateVehicle",function(netid, info, isPersonal)
    if isPersonal then
        while not NetworkDoesEntityExistWithNetworkId(netid) do
            print("Nao encontrado netid")
            Wait(200)
        end

        local entity = NetworkGetEntityFromNetworkId(netid)

        while not DoesEntityExist(entity) do
            print("Entity nao encontrada")
            Wait(200)
        end

        if not IsEntityAVehicle(entity) then
            print("Nao eh um veiculo")
            return
        end

        local nveh = NetToVeh(netid)
        if nveh then
            SetVehicleDoorsLocked(nveh, 2)
            SetEntityAsMissionEntity(nveh, true, true)
            SetVehicleOnGroundProperly(nveh)
            SetVehRadioStation(nveh, "OFF")
            SetVehicleDirtLevel(nveh, 0.0)
            SetPedIntoVehicle(PlayerPedId(),nveh,-1)
            SetVehicleEngineHealth(nveh, info.engine + 0.0)
            SetVehicleBodyHealth(nveh, info.body + 0.0)
            SetVehicleFuelLevel(nveh, info.fuel + 0.0)
            SetVehicleMods(nveh, info.custom)          
        end
    else
        while not NetworkDoesEntityExistWithNetworkId(netid) do
            print("Nao encontrado netid")
            Wait(200)
        end

        local entity = NetworkGetEntityFromNetworkId(netid)

        while not DoesEntityExist(entity) do
            print("Entity nao encontrada")
            Wait(200)
        end

        if not IsEntityAVehicle(entity) then
            print("Nao eh um veiculo")
            return
        end

        local nveh = NetToVeh(netid)
        if nveh then
            SetVehicleDoorsLocked(nveh, 2)
            SetEntityAsMissionEntity(nveh, true, true)
            SetVehicleOnGroundProperly(nveh)
            SetVehRadioStation(nveh, "OFF")
            SetVehicleDirtLevel(nveh, 0.0)
            SetPedIntoVehicle(PlayerPedId(),nveh,-1)
            SetVehicleEngineHealth(nveh, info.engine + 0.0)
            SetVehicleBodyHealth(nveh, info.body + 0.0)
            SetVehicleFuelLevel(nveh, info.fuel + 0.0)
            SetVehicleMods(nveh, info.custom)          
        end
    end
end)

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- HANDLERS
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("flow:reciveGarages")
AddEventHandler("flow:reciveGarages", function(all,houses,id)
    if all then
        for k in pairs(houses) do
            if houses[k] and houses[k].garagem ~= nil and houses[k].garagem['garagem'] ~= nil then
                garages[(1000 + k)] = { -- SE TIVER + 1000 GARAGEM CRIADA, AUMENTAR AQUI... [ 1000 + IDDACASA ]
                    type = "Homes",
                    houseID = k,
                    blipDistance = 5.0,

                    coords = vec3(houses[k].garagem['garagem'].x,houses[k].garagem['garagem'].y,houses[k].garagem['garagem'].z), 
                    spawnCoords = {
                        vector4(houses[k].garagem['spawn'].x,houses[k].garagem['spawn'].y,houses[k].garagem['spawn'].z,houses[k].garagem['spawn'].h),
                    }
                }
            end
        end
    else
        v = houses
        garages[(1000 + id)] = { -- SE TIVER + 1000 GARAGEM CRIADA, AUMENTAR AQUI... [ 1000 + IDDACASA ]
            type = "Homes",
            houseID = id,
            blipDistance = 5.0,

            coords = vec3(v.garagem['garagem'].x,v.garagem['garagem'].y,v.garagem['garagem'].z), 
            spawnCoords = {
                vector4(v.garagem['spawn'].x,v.garagem['spawn'].y,v.garagem['spawn'].z,v.garagem['spawn'].h),
            }
        }
    end
end)

AddEventHandler("gameEventTriggered",function(eventName, args)
    if eventName == "CEventNetworkPlayerEnteredVehicle" and args[1] == PlayerId() then
        if GetPedInVehicleSeat(args[2], -1) == PlayerPedId() then 
            if segundos == 0 then
                segundos = 2
                vTunnel._garageUpdateVehicleJoin(VehToNet(args[2]))
            end
        end
    end
end)

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- COMANDOS
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('lockvehicle', function(source,args)
    local plyCoords = GetEntityCoords(PlayerPedId())
    local vehicle,hash = GetClosestVehiclePlayer(5.0)
    if vehicle then
        if segundos == 0 then
            segundos = 2
            vTunnel._garageTryLockVehicle(VehToNet(vehicle),hash)
        end
    end
end)
RegisterKeyMapping('lockvehicle', 'Trancar/Destrancar Veiculo', 'keyboard', 'L')

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- OTHERS FUNCTIONS
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
CreateBlips = function()
    for i = 1, #garages do
        print(types[garages[i].type])
        if types[garages[i].type].blip['showBlip'] then
            local blip = AddBlipForCoord(garages[i].coords[1],garages[i].coords[2],garages[i].coords[3])
            SetBlipSprite(blip, types[garages[i].type].blip['blipId'])
            SetBlipAsShortRange(blip,true)
            SetBlipColour(blip, types[garages[i].type].blip['blipColor'])
            SetBlipScale(blip, types[garages[i].type].blip['blipScale'])
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString(types[garages[i].type].blip['name'])
            EndTextCommandSetBlipName(blip)
        end
    end
end

length = function(array)
	local len = 0
	for i in pairs(array) do 
		if array[i] then
			len = len+1
		end
	end
	return len
end

GetClosestVehiclePlayer = function(range)
    local ped = PlayerPedId()
    local vehicles = GetGamePool("CVehicle")

    local vehID
    local min = range+0.0001
    local vehHash
    for i = 1, #vehicles do
        local veh = vehicles[i]
        local dist = #(GetEntityCoords(ped) - GetEntityCoords(veh))

        if IsEntityAVehicle(veh) and dist <= range then
            if dist < min then
                min = dist
                vehID = veh
                vehHash = GetEntityModel(veh)
            end
        end
    end

    return vehID,vehHash
end

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- TUNAGEM
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
local colors = {
	["cromado"] = { 120 },
	["metálico"] = { 0, 147, 1, 11, 2, 3, 4, 5, 6, 7, 8, 9, 10, 27, 28, 29, 150, 30, 31, 32, 33, 34, 143, 35, 135, 137, 136, 36, 38, 138, 99, 90, 88, 89, 91, 49, 50, 51, 52, 53, 54, 92, 141, 61, 62, 63, 64, 65, 66, 67, 68, 69, 73, 70, 74, 96, 101, 95, 94, 97, 103, 104, 98, 100, 102, 99, 105, 106, 71, 72, 142, 145, 107, 111, 112 },
	["fosco"] = { 12, 13 ,14 ,131 ,83 ,82 ,84 ,149 ,148 ,39 ,40 ,41 ,42 ,55 ,128 ,151 ,155 ,152 ,153 ,154 },
	["metal"] = { 117 ,118 ,119 ,158 ,159 }
}

local mod = {
	["aerofólio"] = 0,
	["parachoque-dianteiro"] = 1,
	["parachoque-traseiro"] = 2,
	["saias"] = 3,
	["escapamento"] = 4,
	["roll-cage"] = 5,
	["grelha"] = 6,
	["capô"] = 7,
	["para-lama"] = 8,
	["teto"] = 10,
	["motor"] = 11,
	["freios"] = 12,
	["transmissão"] = 13,
	["buzina"] = 14,
	["suspensão"] = 15,
	["blindagem"] = 16,
	["turbo"] = 18,
	["smoke"] = 20,
	["farol"] = 22,
	["dianteira"] = 23,
	["traseira"] = 24,
	["ornaments"] = 28,
	["dashboard"] = 29,
	["dials"] = 30,
	["doors"] = 31,
	["seats"] = 32,
	["plaques"] = 35,
	["arch-cover"] = 42,
	["janela"] = 46,
	["decal"] = 48,
}

local wheeltype = {
	["stock"] = -1,
	["sport"] = 0,
	["muscle"] = 1,
	["lowrider"] = 2,
	["suv"] = 3,
	["offroad"] = 4,
	["tuner"] = 5,
	["highend"] = 7,
}

function SetVehicleMods(veh,myveh) 
	SetVehicleModKit(veh,0)
	if not myveh or not myveh.customPcolor then
		return
	end
	local bug = false
	local primary = myveh.color[1]
	local secondary = myveh.color[2]
	local cprimary = myveh.customPcolor
	if cprimary['1'] then
		bug = true
	end
	local csecondary = myveh.customScolor
	local perolado = myveh.extracolor[1]
	local wheelcolor = myveh.extracolor[2]
	local neoncolor = myveh.neoncolor
	local smokecolor = myveh.smokecolor
	ClearVehicleCustomPrimaryColour(veh)
	ClearVehicleCustomSecondaryColour(veh)
	SetVehicleWheelType(veh,myveh.wheeltype)
	SetVehicleColours(veh,primary,secondary)
	if bug then
		SetVehicleCustomPrimaryColour(veh,cprimary['1'],cprimary['2'],cprimary['3'])
		SetVehicleCustomSecondaryColour(veh,csecondary['1'],csecondary['2'],csecondary['3'])
	else
		SetVehicleCustomPrimaryColour(veh,cprimary[1],cprimary[2],cprimary[3])
		SetVehicleCustomSecondaryColour(veh,csecondary[1],csecondary[2],csecondary[3])
	end
	SetVehicleExtraColours(veh,perolado,wheelcolor)
	SetVehicleNeonLightsColour(veh,neoncolor[1],neoncolor[2],neoncolor[3])
	SetVehicleXenonLightsColour(veh,myveh.xenoncolor)
	SetVehicleNumberPlateTextIndex(veh,myveh.plateindex)
	SetVehicleWindowTint(veh,myveh.windowtint)
	for i,t in pairs(myveh.mods) do 
		if tonumber(i) == 22 or tonumber(i) == 18 then
			if t.mod > 0 then
				ToggleVehicleMod(veh,tonumber(i),true)
			else
				ToggleVehicleMod(veh,tonumber(i),false)
			end
		elseif tonumber(i) == 20 then
			smokeColor(veh,smokecolor)
		elseif tonumber(i) == 23 or tonumber(i) == 24 then
			SetVehicleMod(veh,tonumber(i),tonumber(t.mod),tonumber(t.variation))
		else
			SetVehicleMod(veh,tonumber(i),tonumber(t.mod))
		end
	end
	SetVehicleTyresCanBurst(veh,myveh.bulletProofTyres)
	if myveh.neon then
		for i = 0, 3 do
			SetVehicleNeonLightEnabled(veh,i,true)
		end
	else
		for i = 0, 3 do
			SetVehicleNeonLightEnabled(veh,i,false)
		end
	end

end

function setNeon(veh,toggle)
	for i = 0, 3 do
		SetVehicleNeonLightEnabled(veh,i,toggle)
	end
end

function setXenon(veh,toggle)
	ToggleVehicleMod(veh,mod["farol"],toggle)
end

function smokeColor(veh,color)
	local r,g,b = parseInt(color[1]),parseInt(color[2]),parseInt(color[3])
	ToggleVehicleMod(veh,mod["smoke"],true)
	SetVehicleTyreSmokeColor(veh,r,g,b)
end

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- THREADS
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
   TriggerEvent('updateVehList', garagesConfig.listCars)
end)