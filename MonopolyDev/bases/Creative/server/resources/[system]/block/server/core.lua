-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- BLOCK:WARN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("block:Warn")
AddEventHandler("block:Warn", function()
    local source = source
    local Passport = vRP.Passport(source)
    for k,v in pairs(AllowPassports) do
        if Passport and tostring(Passport) == k then
            return
        end
    end
    vRP.Kick(source, "Não use o DevTools!")
end)
