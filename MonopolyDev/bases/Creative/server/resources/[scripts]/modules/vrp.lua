Tunnel = module("vrp", "lib/Tunnel")
Proxy = module("vrp", "lib/Proxy")

if IsDuplicityVersion() then -- Server importation
    vRP = Proxy.getInterface("vRP")
    vRPC = Tunnel.getInterface("vRP")

    BAIXADA = {}
    Tunnel.bindInterface("baixada-module", BAIXADA)

    KEYBOARD = Tunnel.getInterface("keyboard")
    BAIXADA_CLIENT = Tunnel.getInterface("baixada-module")
else -- Client importation
    vRP = Proxy.getInterface("vRP")

    BAIXADA = {}
    Tunnel.bindInterface("baixada-module", BAIXADA)

    BAIXADA_SERVER = Tunnel.getInterface("baixada-module")
end
