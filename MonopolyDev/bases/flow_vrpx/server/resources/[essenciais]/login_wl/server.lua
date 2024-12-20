local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------

vSERVER = {}
Tunnel.bindInterface(GetCurrentResourceName(), vSERVER)
vCLIENT = Tunnel.getInterface(GetCurrentResourceName())

vRP.prepare("get_whitelist", "SELECT * FROM vrp_users WHERE id = @id")

function vSERVER.getWhitelist()
    local source = source
    local user_id = vRP.getUserId(source)
    local query = vRP.query("get_whitelist", {id = user_id})
    
    if #query > 0 then
        return query[1]["whitelist"], user_id
    end
    return false
end

CreateThread(function()
    while true do
        Wait(0)

        local source = source
        local user_id = vRP.getUserId(source)
        if user_id ~= nil then
            local query = vRP.query("get_whitelist", {id = user_id})
            if query ~= nil and #query == 0 then
                TriggerClientEvent("checkWt", source)
            end
        end
    end
end)
