local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
local Tools = module("vrp","lib/Tools")
local idgens = Tools.newIDGenerator()

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")


------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
local disabled = {}    
local requests = {}
local blips = {}

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- WEBHOOK
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
local url_ignoredTickets = ''
local notifyuserlog = ''

function sendWebhookMessage(webhook, message)
    if webhook then
        PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({content = message}), { ['Content-Type'] = 'application/json' })
    end
end

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- COMANDOS 
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('call',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if args[1] == nil then
		return
	end

    if args [1] == "admin" or args [1] == "staff" or args [1] == "adm" or args [1] == "god" then
        local status, time = exports['vrp']:getCooldown(user_id, "callgod")
        if status then 
            exports['vrp']:setCooldown(user_id, "callgod", 240)
	        TriggerEvent('alerts:sendRequestToGroup', user_id, args[1], nil)
        else
            TriggerClientEvent("Notify",source,"sucesso","Você só pode fazer chamado novamente em ".. time .." segundos.", 15000)
        end
    else
        TriggerClientEvent("Notify",source,"negado","Você não colocou o argumento correto, tente: /call god")
    end
end)

RegisterCommand('notifyall', function(source, args, rawCommand)
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id, "admin.permissao") or vRP.hasPermission(user_id,"mod.permissao") then
        local user_id = vRP.getUserId(source)

        local type = vRP.prompt(source, "Tipo","Admin")
        local title = vRP.prompt(source, "Título","AVISO DA ADMINISTRAÇÃO")
        local description = vRP.prompt(source, "Descrição","")
        local persistentText = vRP.prompt(source, "Ficar no Menu de chamadas? (0 ou 1)","")
        local persistent = false

        if persistentText == "1" then
            persistent = true
        end

        --vRP.sendLog("https://discord.com/api/webhooks/1009212935815565553/kM9Zl8HybI70m5_m5bk4D_pRv1tjo3fdzHXjYOqIc0dpfWMT4wSHF-3qnDvEIST8v8HF", "O ADMIN "..user_id.." ANUNCIOU "..type.." TITULO "..title.." DESCRICAO "..description.." FICOU NO MENU "..persistent.." ")
        if string.len(type) > 0 and string.len(title) > 0 and string.len(description) > 0 then
            TriggerClientEvent("alerts:sendNotification", -1, type, title, description, persistent)
        end
    end
end)

RegisterCommand('notifyuser', function(source, args, rawCommand)
    local user_id = vRP.getUserId(source)

    if vRP.hasPermission(user_id, "admin.permissao") and args[1] then
        local user_id = vRP.getUserId(source)

        local target_source = vRP.getUserSource(parseInt(args[1]))

        if target_source then
            local type = vRP.prompt(source, "Tipo","Private")
            local title = vRP.prompt(source, "Título","AVISO DA ADMINISTRAÇÃO")
            local description = vRP.prompt(source, "Descrição","")
            local persistentText = vRP.prompt(source, "Ficar no Menu de chamadas? (0 ou 1)","")
            local persistent = false

            if persistentText == "1" then
                persistent = true
            end

            --vRP.sendLog("https://discord.com/api/webhooks/1009212935815565553/kM9Zl8HybI70m5_m5bk4D_pRv1tjo3fdzHXjYOqIc0dpfWMT4wSHF-3qnDvEIST8v8HF", "O ADMIN "..user_id.." ANUNCIOU "..type.." TITULO "..title.." DESCRICAO "..description.." FICOU NO MENU "..persistent.." ")
            if string.len(type) > 0 and string.len(title) > 0 and string.len(description) > 0 then
                TriggerClientEvent("alerts:sendNotification", target_source, type, title, description, persistent)
            end
        end        
    end
end)

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- EVENTOS
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("alerts:sendRequest")
AddEventHandler("alerts:sendRequestToGroup", function(requested_by, group, description)
    if description == nil then
        description = vRP.prompt(vRP.getUserSource(requested_by), "Descreva seu pedido (máx. 150 caracteres)","")
    end

    if description == '' then
       return TriggerClientEvent("Notify",vRP.getUserSource(requested_by),"negado","Por favor, digite algo no seu chamado, assim, iremos te atender melhor.")
    end
    
    if description then

        local perm = ''
        local icon = ''

        if group == 'admin' or group == 'staff' or group == 'adm' or group == 'god' then
            perm = 'ticket.permissao'
            icon = 'admin'
        else
            return
        end

        local id = idgens:gen()
        local identity = vRP.getUserIdentity(requested_by)
        if identity.sobrenome ~= nil then
            fullname = identity.nome.." "..identity.sobrenome
        else
            fullname = identity.nome
        end

        local timeShift = 4 * 60 * 60 
        TriggerEvent('alerts:sendRequest', requested_by, perm, icon, '['..requested_by..'] '..fullname, description, id)
    end
end)

RegisterServerEvent("alerts:sendRequest")
AddEventHandler("alerts:sendRequest", function(requested_by, permission, type, title, description, id)
    if requests[id] == nil and vRP.getUserSource(requested_by) then
        requests[id] = {
            requested_by = requested_by,
            permission = permission,
            descricao = description,
            timer = 60
        }
        
        if string.len(description) > 150 then
            description = string.sub(description, 1, 150)
        end
        local user_id_enviou = vRP.getUserSource(parseInt(requested_by))
        TriggerClientEvent("alerts:sendNotification", user_id_enviou, "admin", "Chamado Enviado", "Chamado enviado! Por favor, aguarde no local.", true)


        local possiblePlayers = vRP.getUsersByPermission(permission)

        for l, user_id in pairs(possiblePlayers) do
            local source = vRP.getUserSource(parseInt(user_id))

            if source  then
                TriggerClientEvent("alerts:sendRequest", source, type, title, description, id)
            end
        end
    end
end)

RegisterServerEvent("alerts:tryAcceptRequest")
AddEventHandler("alerts:tryAcceptRequest", function(id)
    id = parseInt(id)
    if requests[id] ~= nil then
        local source = source
        local user_id = vRP.getUserId(source)
   
        if vRP.hasPermission(user_id, requests[id].permission) then
            local requested_by = requests[id].requested_by
            local text_chamado = requests[id].descricao
            local possiblePlayers = vRP.getUsersByPermission(requests[id].permission)

            requests[id] = nil
            local requester_source = vRP.getUserSource(requested_by)
            local user_identity = vRP.getUserIdentity(user_id)
            local user_name = ""

            if user_identity.sobrenome ~= nil then
                user_name = user_identity.nome.." "..user_identity.sobrenome
            else
                user_name = user_identity.nome
            end
            
            TriggerClientEvent("alerts:sendNotification", requester_source, "admin", "Chamado Aceito", "<b>["..user_id.."] "..user_name.."</b> atendeu o seu chamado! Por favor, aguarde no local.", true)

            local requester_coords = GetEntityCoords(GetPlayerPed(requester_source))
            vRPclient._setGPS(source, requester_coords.x, requester_coords.y)
            vRPclient._teleport(source, requester_coords.x, requester_coords.y, requester_coords.z)


            
            blips[id] = {
                user_id = user_id,
                instance = vRPclient.addBlip(source, requester_coords.x, requester_coords.y, requester_coords.z, 358, 71, "Chamado", 0.6, false),
                timer = 120
            }

            for l, possible_user_id in pairs(possiblePlayers) do
                local source = vRP.getUserSource(parseInt(possible_user_id))

                if source then
                    if user_id ~= possible_user_id then
                        TriggerClientEvent("alerts:setAcceptedRequest", source, id, user_id)
                        --exports.bm_module:addCall(user_id) -- adicionar chamados
                    else
                        TriggerClientEvent("alerts:setAcceptedRequest", source, id, "ok")
                        --exports.bm_module:addCall(user_id) -- adicionar chamados
                    end
                end
            end
            
            exports.bm_module:addCall(user_id)
            sendWebhookMessage(url_ignoredTickets, "```prolog\n[SOLICITANTE]: "..requested_by.." \n[LOC. SOLICITANTE]: "..requester_coords.x .. ',' .. requester_coords.y .. ',' .. requester_coords.z.." \n[DESCRICAO]: "..text_chamado.."  \n[STAFF QUE ACEITOU]: "..user_id.. " "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")

        end
    end
end)


Citizen.CreateThread(function()
    while true do
        for k, v in pairs(requests) do
            if v.timer > 0 then
                v.timer = v.timer - 1

                if v.timer <= 0 then
                    local triggerSource = vRP.getUserSource(v.requested_by)
                    local triggerCoords = {x = 0, y = 0, z = 0}

                    if triggerSource then
                        triggerCoords = GetEntityCoords(GetPlayerPed(triggerSource))
                        TriggerClientEvent("alerts:sendNotification", triggerSource, "warning", "Ninguém por aqui...", "Ninguém pôde atender o seu chamado no momento. Por favor, tente novamente.", true)
                    end

                    local possiblePlayers = vRP.getUsersByPermission(v.permission)
                    local textOutput = ''

                    for l, possible_user_id in pairs(possiblePlayers) do
                        local source = vRP.getUserSource(parseInt(possible_user_id))
        
                        if source and requested_by ~= possible_user_id then
                            local coords = GetEntityCoords(GetPlayerPed(source))
                            textOutput = textOutput .. '[' .. possible_user_id ..'] \n'

                            TriggerClientEvent("alerts:setAcceptedRequest", source, k, "ninguém")
                        end
                    end

                    sendWebhookMessage(url_ignoredTickets, "```prolog\n[SOLICITANTE]: "..v.requested_by.." \n[LOC. SOLICITANTE]: "..triggerCoords.x .. ',' .. triggerCoords.y .. ',' .. triggerCoords.z.." \n[DESCRICAO]: "..v.descricao.."  \n[PERMISSAO]: "..v.permission.. " \n[EM SERVICO]: "..textOutput.. " "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
                    requests[k] = nil
                end
            end
        end

        for k, v in pairs(blips) do
            if v.timer > 0 then
                v.timer = v.timer - 1

                if v.timer <= 0 then
                    if vRP.getUserSource(v.user_id) then
                        vRPclient.removeBlip(vRP.getUserSource(v.user_id), v.instance)
                    end
                    blips[k] = nil
                end
            end
        end
        Citizen.Wait(1000)
    end
end)

