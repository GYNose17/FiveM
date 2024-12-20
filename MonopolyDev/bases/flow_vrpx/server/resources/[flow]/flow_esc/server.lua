local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

flow = {}
Tunnel.bindInterface("flow_esc", flow)

function flow.RequestMenu()
    local source = source
    local identity = Identity(user_id)  
    local user_id = vRP.getUserId(source)
     if not user_id then return end
        local identity = Identity(user_id)
    if not identity then return end
        local Payload = {}
    Payload.main = {
        user_id = user_id,
        name = Config.Info.main.name(user_id, source, identity) or "Individo Indigente",
        genre = Config.Info.main.genre(user_id, source) or "Indefinido",
        wallet = Config.Info.main.wallet(user_id, source) or 0,
        bank = Config.Info.main.bank(user_id, source) or 0,
        image = Config.Info.main.image(user_id, source) or "Nenhuma"
    }
   Payload.others = {}
    for index in pairs(Config.Info.others) do
        Payload.others[index] = Config.Info.others[index](user_id, source, identity)
    end
    Payload.amountPlys = GetNumPlayerIndices()
    Payload.status = {}
    for index in pairs(Config.Status.list) do
        Payload.status[index] = (#Config.Status.func(Config.Status.list[index])) or 0
    end
    Payload.maxPlayers = GetConvarInt("sv_maxclients", 2048)
    return Payload
end