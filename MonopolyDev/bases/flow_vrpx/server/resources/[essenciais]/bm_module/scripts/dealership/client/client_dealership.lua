---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
local config = dealershipConfig


local in_testDriver = false
local count_testdrive = 0
local vehID = 0

local opennedConce
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- THREAD
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
    while true do
        local time = 1000
        local pedCoords = GetEntityCoords(PlayerPedId())
        for k in pairs(config.locations) do
            local distance = #(pedCoords - config.locations[k].coords)
            if distance <= 15.0 then
                time = 5
                DrawMarker(36,config.locations[k].coords[1],config.locations[k].coords[2],config.locations[k].coords[3],0,0,0,0,0,0,1.0,1.0,1.0, 131, 133, 132,155, 1,1,1,1)
                DrawMarker(27,config.locations[k].coords[1],config.locations[k].coords[2],config.locations[k].coords[3]-0.97,0,0,0,0,0,0,1.0,1.0,0.5, 131, 133, 132,155, 0,0,0,1)

                if IsControlJustPressed(0,38) and distance < 2 then
                    dealerShipOpenNui()
                    opennedConce = k
                end
            end
        end

        Wait( time )
    end
end) 

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- FUNCTIONS
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function dealerShipOpenNui()
    SetNuiFocus(true, true)
    SendNUIMessage({ action = "dealership", dir = config.main['dir'] })
end

function initTestDriver(veh, id)
    id = parseInt(id)
    if config.locations[id] then
        local cpos = config.locations[id].coords
        local pos = config.locations[id].test_drive

        local mhash = GetHashKey(veh)
        while not HasModelLoaded(mhash) do
            RequestModel(mhash)
            Wait(200)
        end

        DoScreenFadeOut(500)

        Wait( 1000 )
        SetEntityCoords(PlayerPedId(), pos.x,pos.y,pos.z)
        Wait( 500 )

        local veh = CreateVehicle(mhash, pos.x,pos.y,pos.z,pos.w, true, true)
        if veh then
            while not DoesEntityExist(veh) do
                Wait(200)
            end

            while not NetworkDoesEntityExistWithNetworkId(VehToNet(veh)) do
                Wait(200)
            end

            local netid = VehToNet(veh)

            if not IsEntityAVehicle(veh) then
                return
            end

            SetVehicleNumberPlateText(veh, "TEST-DRIVE")
            SetEntityAsMissionEntity(veh, true, true)
            SetVehicleOnGroundProperly(veh)
            SetVehRadioStation(veh, "OFF")
            SetVehicleDirtLevel(veh, 0.0)
            SetVehicleDoorsLocked(veh, 2)
            SetPedIntoVehicle(PlayerPedId(),veh,-1)
            SetVehicleEngineHealth(veh, 1000.0)
            SetVehicleBodyHealth(veh, 1000.0)
            SetVehicleFuelLevel(veh, 100.0)
            SetModelAsNoLongerNeeded(mhash)
            DoScreenFadeIn(300)

            vehID = veh
        end

        in_testDriver = true
        count_testdrive = config.main['cooldownTestDriver']
        CreateThread(function()
            while in_testDriver do
                drawTxt("Para cancelar o test-driver pressione ~r~F6",4,0.5,0.93,0.50,255,255,255,120)
                drawTxt("Tempo restante: ~b~"..count_testdrive.."~w~ segundo(s)",4,0.5,0.96,0.50,255,255,255,120)
                
                if IsControlJustPressed(0, 167) then
                    in_testDriver = false

                    if vehID > 0 then
                        DeleteEntity(vehID)
                        vehID = 0

                        DoScreenFadeOut(500)
                        Wait( 1000 )

                        SetEntityCoords(PlayerPedId(), cpos.x,cpos.y,cpos.z)

                        Wait( 1000 )
                        DoScreenFadeIn(300)
                    end
                end

                if #(GetEntityCoords(PlayerPedId()) - vec3(pos.x,pos.y,pos.z)) >= config.main['maxDistanceTestDriver'] then
                    in_testDriver = false

                    if vehID > 0 then
                        DeleteEntity(vehID)
                        vehID = 0

                        DoScreenFadeOut(500)
                        Wait( 1000 )
                        
                        SetEntityCoords(PlayerPedId(), cpos.x,cpos.y,cpos.z)

                        Wait( 1000 )
                        DoScreenFadeIn(300)
                    end
                end

                if count_testdrive <= 0 then
                    in_testDriver = false
                    count_testdrive = 0
                    
                    if vehID > 0 then
                        DeleteEntity(vehID)
                        vehID = 0

                        DoScreenFadeOut(500)
                        Wait( 1000 )
                        
                        SetEntityCoords(PlayerPedId(), cpos.x,cpos.y,cpos.z)

                        Wait( 1000 )
                        DoScreenFadeIn(300)
                    end
                end

                if vehID > 0 then
                    if not DoesEntityExist(vehID) then
                        in_testDriver = false
                        vehID = 0

                        DoScreenFadeOut(500)
                        Wait( 1000 )
                        
                        SetEntityCoords(PlayerPedId(), cpos.x,cpos.y,cpos.z)

                        Wait( 1000 )
                        DoScreenFadeIn(300)
                    end
                end

                Wait( 5 )
            end
        end)

        CreateThread(function()
            while in_testDriver do
                if count_testdrive > 0 then
                    count_testdrive = count_testdrive - 1
                end

                Wait( 1000 )
            end
        end)
    end
end

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- CALLBACKS
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback('requestConceVehicles', function(data, cb)
    local list,discount = vTunnel.dealershipRequest('requestList')
    local t = {}

    for k in pairs(list) do
        if discount > 0 then
            price = parseInt(list[k].price - (list[k].price * discount/100))
        else
            price = list[k].price
        end
        
        t[#t + 1] = {
            spawn = k,
            name = list[k].name,
            price = price,
            stock = list[k].stock,
            type = list[k].type,
            trunk = list[k].trunk,
            aceleration = GetVehicleModelAcceleration(GetHashKey(k)) or 0,
            maxspeed = GetVehicleModelEstimatedMaxSpeed(GetHashKey(k)) * 3.605936 or 0,
            braking = GetVehicleModelMaxBraking(GetHashKey(k)) or 0,
            agility = GetVehicleModelEstimatedAgility(GetHashKey(k)) or 0,
        }
    end
    cb({ list = t, dir = garagesConfig.main['dir'] })
end)

RegisterNUICallback('requestMyVehicles', function(data, cb)
    local myVehicles = vTunnel.dealershipRequest("requestMyVehicles", {})

    local t = {}
    for i = 1, #myVehicles do
        t[#t + 1] = {
            spawn =  myVehicles[i].spawn,
            name = myVehicles[i].name,
            price = myVehicles[i].price,
            stock =  myVehicles[i].stock,
            type =  myVehicles[i].type,
            trunk =  myVehicles[i].trunk,
            aceleration = GetVehicleModelAcceleration(GetHashKey(myVehicles[i].spawn)) or 0,
            maxspeed = GetVehicleModelEstimatedMaxSpeed(GetHashKey(myVehicles[i].spawn)) * 3.605936 or 0,
            braking = GetVehicleModelMaxBraking(GetHashKey(myVehicles[i].spawn)) or 0,
            agility = GetVehicleModelEstimatedAgility(GetHashKey(myVehicles[i].spawn)) or 0,
        }
    end

    cb({ list = t, dir = garagesConfig.main['dir'] })
end)

RegisterNUICallback('buyVehicle', function(data, cb)
    closeNui()
    vTunnel._dealershipBuyVehicle(data.vehicle)
end)

RegisterNUICallback('sellVehicle', function(data, cb)
    closeNui()
    vTunnel._dealershipSellVehicle(data.vehicle)
end)

RegisterNUICallback('testDrive', function(data, cb)
    closeNui()
    initTestDriver(data.vehicle, opennedConce)
end)

closeNui = function()
    SetNuiFocus(false, false)
    SendNUIMessage({ action = "hideMenu" })
end

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- COMANDOS
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('addVeh2', function(source,args)
    vTunnel._dealershipBuyVehicle("oracle2")
end)

function drawTxt(text,font,x,y,scale,r,g,b,a)
    SetTextFont(font)
    SetTextScale(scale,scale)
    SetTextColour(r,g,b,a)
    SetTextOutline()
    SetTextCentre(1)
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x,y)
end
