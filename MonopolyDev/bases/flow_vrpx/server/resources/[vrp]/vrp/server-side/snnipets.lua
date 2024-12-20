local pressetHooks = {
    ["ENTRADA"] = { "https://discord.com/api/webhooks/1092239249081909268/piLBMxsBdlRY7MxRYvOYKTJlFLlsdsF9xujqTxX7_iE6NLirB1EIMXo2lNe291T-52Te" },
    ["SAIDA"] = { "" },
    ["DROPAR"] = { "" },
    ["ENVIAR"] = { "" },
    ["EQUIPAR"] = { "" },
    ["GARMAS"] = { "" },
    ["SAQUEAR"] = { "" },
    ["BAUCARRO"] = { "" },
    ["BAUCASAS"] = { "" },
    ["CRASHS"] = { "" },
    ["MORTE"] = { "" },
    ["ROUBOGERAIS"] = { "" },
    ["ROUBOAMMU"] = { "" },
    ["ROUBOCAIXA"] = { "" },
    ["ROUBOREGISTRADORA"] = { "" },
    ["BANCODEPOSITAR"] = { "" },
    ["BANCOSACAR"] = { "" },
    ["BANCOENVIAR"] = { "" },
    ["COMPRARVEICULO"] = { "" },
    ["WL"] = { "" },
    ["IDS"] = { "" },
    ["TPTO"] = { "" },
    ["TPTOME"] = { "" },
    ["GOD"] = { "" },
    ["GOID"] = { "" },
    ["KICK"] = { "" },
    ["BAN"] = { "" },
    ["PRENDERADM"] = { "" },
    ["AADM"] = { "" },
    ["KILL"] = { "" },
    ["ITEM"] = { "" },
    ["TPWAY"] = { "" },
    ["ACEITARCHAMADOADMIN"] = { "" },
    ["GROUPADD"] = { "" },
    ["GROUPREM"] = { "" },
    ["SPAWNCAR"] = { "" },
    ["MONEY"] = { "" },
    ["BATERPONTOADMIN"] = { "" },
    ["PRENDER"] = { "" },
    ["COPYPRESET"] = { "" },
    ["SETPRESET"] = { "" },
    ["REVISTARADM"] = { "" },
    ["VAULTADM"] = { "" },
    ["HOUSEADMCHEST"] = { "" },
    ["FUEL"] = { "" },
    ["LOCKPICK"] = { "" },
    ["ADDCARRO"] = { "" },
    ["RENOMEAR"] = { "" },
    ["CRAFT"] = { "" },
    ["GETITEM"] = { "" },
    ["REMCARRO"] = { "" },
    ["DESMANCHADO"] = { "https://discord.com/api/webhooks/1111817122667053087/xN12OTRt22jW18K5dlDQ65R6c1JL2JFCxpLIQTp8Xls7e_Fr3OP4bk_Vbeprd7VNJpah" },
}

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- DISCORD WEEBHOOK
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function vRP.sendLog(weebhook, mensagge)
    if weebhook and mensagge then
        if pressetHooks[weebhook] ~= nil then
            SendWebhookMessage(pressetHooks[weebhook][1],mensagge)
        else
            SendWebhookMessage(weebhook,mensagge)
        end
    end
end

function SendWebhookMessage(webhook,message)
    if webhook ~= "none" then
        PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({content = message}), { ['Content-Type'] = 'application/json' })
    end
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- DESLOGAR DENTRO DA PROPRIEDADE
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.atualizarPosicao(user_id,x,y,z)
    local data = vRP.getUserDataTable(user_id)
    if user_id then
        if data then
            data.position = { x = x, y = y, z = z }
        end
    end
end

function vRP.limparArmas(user_id)
    local data = vRP.getUserDataTable(user_id)
    if user_id then
        if data then
            data.weapons = {}
        end
    end
end

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- OUTROS
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler('playerDropped', function (reason)
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then

        if reason == "Game crashed: gta-core-five.dll!CrashCommand (0x0)" then
            vRP._setBanned(user_id, true, "Usou comando para forjar o crash")
            vRP.sendLog("CRASHS", "O ID "..user_id.." utilizou o comando _crash.")
        end
    end
end)
