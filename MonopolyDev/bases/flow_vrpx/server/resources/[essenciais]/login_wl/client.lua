local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
vCLIENT = {}
Tunnel.bindInterface(GetCurrentResourceName(), vCLIENT)
vSERVER = Tunnel.getInterface(GetCurrentResourceName())





RegisterCommand("ida",function()
    if vSERVER.getWhitelist() then
        TriggerEvent("Notify","aviso"," funcionando")
        SetNuiFocus(true, true)
        SendNUIMessage({action = 'open',id = id});
    end
end)


Citizen.CreateThread(function()
    while timer do
        Citizen.Wait(2000)
        local whitelist , user_id = vSERVER.getWhitelist()
        if whitelist or  1 then
            return false
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        local whitelist, user_id = vSERVER.getWhitelist()
        if whitelist then
            SetNuiFocus(false, false)
            SendNUIMessage({action = 'close'})
        else
            SetNuiFocus(true, true)
            SendNUIMessage({action = 'open', id = user_id});
        end
        Citizen.Wait(1)
    end
end)