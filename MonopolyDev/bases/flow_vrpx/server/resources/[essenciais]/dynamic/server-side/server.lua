-----------------------------------------------------------------------------------------------------------------------------------------
Tunnel = module("vrp","lib/Tunnel")
Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
SjR = {}
Tunnel.bindInterface("dynamic", SjR)
SjRClient = Tunnel.getInterface("dynamic")


function SjR.execRoupa(roupa)
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
        local mycloth = vRP.getUData(user_id,"roupas")
        local roup = json.decode(mycloth) or {}
        roup = roupa
        vRP.setUData(user_id,"roupas",json.encode(roup))
    end
end


function SjR.execRoupa2(roupa)
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
        local mycloth = vRP.getUData(user_id,"roupasP")
        local roup = json.decode(mycloth) or {}
        local name = vRP.prompt(source, "Digite o slot que deseja colocar a roupa - 1 ou 2", '')
        if name and name ~= '' and parseInt(name) == 1 or parseInt(name) == 2 then
            roup[name] = roupa
            vRP.setUData(user_id,"roupasP",json.encode(roup))
        end
    end

end

function SjR.getRoupas2()
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
        local mycloth = vRP.getUData(user_id,"roupasP")
        local roup = json.decode(mycloth) or {}
        return roup
    end
end

function SjR.getRoupas()
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
        local mycloth = vRP.getUData(user_id,"roupas")
        local roup = json.decode(mycloth) or {}
        return roup
    end
end

local vips = {
    "Platina",
    "Esmeralda",
    "Black",
    "Supreme",
    "Faixa"
}

function SjR.hasPermission()
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
        for k,v in pairs(vips) do
            if vRP.hasPermission(user_id, v) then
                return true
            end
        end
    end
end

function SjR.setRoupa()
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
        local mycloth = vRP.getUData(user_id,"roupas")
        local roup = json.decode(mycloth) or {}
        if roup then
            vRPclient.setCustomization(source,roup)
        end
    end
end

function SjR.setRoupa2(slot)
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
        local mycloth = vRP.getUData(user_id,"roupasP")
        local roup = json.decode(mycloth) or {}
        if roup and roup[slot] then
            vRPclient.setCustomization(source,roup[slot])
        end
    end
end