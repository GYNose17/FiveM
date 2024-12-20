local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPserver = Tunnel.getInterface("vRP","bm_daily")

src = {}
Tunnel.bindInterface("bm_daily",src)
vSERVER = Tunnel.getInterface("bm_daily")
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


Citizen.CreateThread(function()
    while true do
        vSERVER._updateTime()

        Citizen.Wait( 5 * 60 * 1000 )
    end
end)

function src.openNui(infos)
    if infos then
        SetNuiFocus(true, true)
        SendNUIMessage({ action = true, info = infos })
    end
end

RegisterNUICallback('openChest', function()
    SetNuiFocus(false, false)
    SendNUIMessage({ action = false })
    vSERVER._openChest()
end)


RegisterNUICallback('close', function()
    SetNuiFocus(false, false)
    SendNUIMessage({ action = false })
end)

RegisterNUICallback("changeMenu", function(data, cb)
    if data.action == "chances" then
        local info = vSERVER.GetItensCaixa()
        if info then
            cb({ info = info, type = "chances" })
        end
    elseif data.action == "ranking" then
        local ranking = vSERVER.GetRanking()
        if ranking then
            cb({ info = ranking, type = "ranking" })
        end
    end
end)



RegisterNUICallback('dev_tools', function(data, cb)
    vSERVER._DevTools()
end)

