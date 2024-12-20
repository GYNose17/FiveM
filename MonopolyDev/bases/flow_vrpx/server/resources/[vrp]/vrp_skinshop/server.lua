local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

dPN = {}
Tunnel.bindInterface("vrp_skinshop",dPN)
Proxy.addInterface("vrp_skinshop",dPN)
dPNclient = Tunnel.getInterface("vrp_skinshop")

AddEventHandler("onResourceStart",function(resourceName)
    if GetCurrentResourceName() == resourceName then
    end
end)


