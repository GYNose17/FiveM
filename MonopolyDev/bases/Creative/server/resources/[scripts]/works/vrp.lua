Tunnel = module("vrp", "lib/Tunnel")
Proxy = module("vrp", "lib/Proxy")

if IsDuplicityVersion() then -- Server imports
    vRP = Proxy.getInterface("vRP")
    vRPC = Tunnel.getInterface("vRP")

    BAIXADA = {}
    Tunnel.bindInterface("baixada-works", BAIXADA)
    
    KEYBOARD = Tunnel.getInterface("keyboard")
    BAIXADA_CLIENT = Tunnel.getInterface("baixada-works")
else -- Client imports
    vRP = Proxy.getInterface("vRP")
    vRPS = Tunnel.getInterface("vRP")

    BAIXADA = {}
    Tunnel.bindInterface("baixada-works", BAIXADA)

    BAIXADA_SERVER = Tunnel.getInterface("baixada-works")
end