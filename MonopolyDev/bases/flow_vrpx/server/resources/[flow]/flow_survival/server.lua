function src.receberMorte(source, motivo, ksource)
    if source == 0 or source == nil then
        return
    end

    local user_id = vRP.getUserId(source)
    if user_id then
        local discord_UserID = GetPlayerIdentifiers(source)
        local coords = GetEntityCoords(GetPlayerPed(source))
        local kuser_id = "Ninguem"
        local discord_kUserID
        if ksource ~= 0 or ksource == nil then
            local id = vRP.getUserId(ksource)
            if id then
                kuser_id = "ID: " .. id
                discord_kUserID = GetPlayerIdentifiers(ksource)
            end
        end
        local discordID = ""
        if discord_UserID ~= nil then
            for k, v in pairs(discord_UserID) do
                if string.find(v, "discord:") then
                    discordID = "<@" .. string.gsub(v, "discord:", "") .. ">\n"
                end
            end
        end

        local discordkID = ""
        if discord_kUserID ~= nil then
            for k, v in pairs(discord_kUserID) do
                if string.find(v, "discord:") then
                    discordkID = "<@" .. string.gsub(v, "discord:", "") .. ">\n"
                end
            end
        end
        if user_id == nil or kuser_id == nil then
            return
        end
        corpoWebHook = {
            {
                ["color"] = cfg.color,
                ["title"] = "**" .. ":skull_crossbones:  | Novo Registro" .. "**\n",
                ["thumbnail"] = { ["url"] = cfg.logo },
                ["description"] = "**Vitima:**\n```cs\n- ID: " .. user_id .. "  ```" .. discordID .. "\n**Causa da Morte:**\n```cs\n- " .. motivo .. " ```\n**Assasino:**\n```cs\n- " .. kuser_id .. " ```" .. discordkID .. "\n**Coordenadas:**\n```cs\n" .. tD(coords[1]) .. "," .. tD(coords[2]) .. "," .. tD(coords[3]) .. " ```\n**Horario:**\n```cs\n" .. os.date("[%d/%m/%Y as %H:%M]") .. " ```",
                ["footer"] = { ["text"] = "Fast Fivem", },
            }
        }

        sendToDiscord(cfg.weebhook, corpoWebHook)
    end
end

function sendToDiscord(weebhook, message)
    PerformHttpRequest(weebhook, function(err, text, headers)
    end, 'POST', json.encode({ embeds = message }), { ['Content-Type'] = 'application/json' })
end

function tD(n)
    n = math.ceil(n * 100) / 100
    return n
end

RegisterCommand('finalizar',function(source,args,rawCommand)
    local source = source
    local user_id = vRP.getUserId(source)
    local nplayer = vRPclient.getNearestPlayer(source,2)
    if nplayer then
        if vRPclient.getHealth(nplayer) <= 101 and not vRPclient.getFinalizado(nplayer) then

            TriggerClientEvent("Notify",source,"aviso","Você finalizou uma pessoa!")
            TriggerClientEvent("Notify",nplayer,"aviso","Você foi finalizado!")
            TriggerClientEvent("finalizar", nplayer, 5) 
            local nuser_id = vRP.getUserId(nplayer)
        else
            TriggerClientEvent("Notify",source,"aviso","Você não pode finalizar esta pessoa.")
        end
    end
end)