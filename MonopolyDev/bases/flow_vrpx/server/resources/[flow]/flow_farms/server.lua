local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

src = {}
Tunnel.bindInterface("vrp_farms", src)
Proxy.addInterface("vrp_farms", src)

vCLIENT = Tunnel.getInterface("vrp_farms")

local actived = {}
local validItems = {}

Citizen.CreateThread(function()
    for k, v in pairs(cfg.bancadaNui) do
        for item, data in pairs(v.itens) do
            validItems[item] = {
                max = 50
            }
        end
    end
end)

function src.requestBancada(bancada)
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
        local itens = {}
        local items = cfg.bancadaNui[bancada].itens
        if items then
            for k, v in pairs(items) do
                if vRP.getItemName(v.id) then
                    table.insert(itens, {
                        id = v.id,
                        imagem = cfg.gerais["imagens"] .. v.id .. cfg.gerais["formatoImagens"],
                        nome = vRP.getItemName(v.id),
                        minAmount = v.minAmount,
                        maxAmount = v.maxAmount,
                        action = k
                    })
                end
            end

            return cfg.bancadaNui[bancada].bancadaName, itens, bancada
        end
    end
end

function src.fabricarItem(item, minAmount, maxAmount, bancada)
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
        local status, time = exports['vrp']:getCooldown(user_id, "farms")
        if status then
            exports['vrp']:setCooldown(user_id, "farms", 10)

            vCLIENT._iniciarRota(source, item, vRP.getItemName(item), minAmount, maxAmount, bancada)
            TriggerClientEvent("Notify", source, "importante", "Você iniciou as rotas de <b>" .. vRP.getItemName(item) .. "</b>.", 3)
            vCLIENT._closeNui(source)
        else
            TriggerClientEvent("Notify", source, "negado", "Aguarde <b>" .. time .. " segundo(s)</b> para iniciar novamente.", 3)
        end
    end
end

function src.giveItem(item, amount)
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
        if vRP.computeInvWeight(user_id) + vRP.getItemWeight(item) * amount <= vRP.getInventoryMaxWeight(user_id) then
            if not validItems[item] then
                print(("user_id %s attempt spawn %s x %s"):format(user_id, item, amount))
                DropPlayer(source, "Tentou spawnar " .. item .. " x" .. amount)
                vRP.setBanned(user_id, 1)
                return
            end

            vRP.giveInventoryItem(user_id, item, amount, true)
            return true
        else
            TriggerClientEvent("Notify", source, "negado", "Sua mochila está cheia.", 3)
        end
    end
end

function src.checkPermission(perm)
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
        if perm == nil or vRP.hasPermission(user_id, perm) then
            return true
        end
    end
end

function src.giveItem(item, quantidade)
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
        if not validItems[item] then
            DropPlayer(source, "Tentou spawnar " .. item .. " x" .. quantidade)
            vRP.setBanned(user_id, 1)
            print(("user_id %s attempt spawn %s x %s"):format(user_id, item, quantidade))
            return
        end
        if vRP.computeInvWeight(user_id) + vRP.getItemWeight(item) <= vRP.getInventoryMaxWeight(user_id) then
            vRP.giveInventoryItem(user_id, item, quantidade, true)
            return true
        end
    end
end
