local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
local Tools = module("vrp","lib/Tools")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

src = {}
Tunnel.bindInterface("vrp_trafico",src)
Proxy.addInterface("vrp_trafico",src)

vCLIENT = Tunnel.getInterface("vrp_trafico")

local cfg = module("cfg/groups")
local groups = cfg.groups

local cfg2 = module("vrp_trafico","cfg/trafico")
local trafico = cfg2.trafico
 
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- CHECAGENS
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function src.checkFaction(tipo)
	local source = source
	local user_id = vRP.getUserId(source)
    if user_id then

        if not src.checkOrgType() then 
            return 
        end

        if src.checkOrgType() == tipo or tipo == "Ilha" then
			return true
		end

        return false
	end
end

function src.checkDominacao(tipo)
	local source = source
	local user_id = vRP.getUserId(source)
    if user_id then

        if trafico[tipo].Controlado[1] == src.checkOrg() then
            return true
        end

        return false
	end
end

function src.checkOrg()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local getGroup = vRP.getUserGroupByType(user_id, "org") or 0
		for k,v in pairs(groups) do
			if groups[k] and groups[k]._config ~= nil and k then
				local getOrg = groups[k]._config.orgName
				if k == getGroup then
					return getOrg
				end
			end
		end
	end
end

function src.checkOrgType()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local getGroup = vRP.getUserGroupByType(user_id, "org") or 0
		for k,v in pairs(groups) do
			if groups[k] and groups[k]._config ~= nil and k then
				local getOrg = groups[k]._config.orgType
				if k == getGroup then
					return getOrg
				end
			end
		end

        return false
	end
end


function convertSeconds(seconds)
	local seconds = tonumber(seconds)
  
	if seconds <= 0 then
	  return "00:00";
	else
	  hours = string.format("%02.f", math.floor(seconds/3600));
	  mins = string.format("%02.f", math.floor(seconds/60 - (hours*60)));
	  return hours.." hora(s) "..mins.." minuto(s)"
	end
end
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- DOMINACAO DE TERRITORIO
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
local areaDominada = {}
local dominando = {}

function src.iniciarDominacao(area, org)
	local source = source
	local user_id = vRP.getUserId(source)
    if user_id then
        if string.upper(trafico[area].Controlado[1]) ~= string.upper(org) then
            if not dominando[user_id] then
                if not areaDominada[area] and areaDominada[area] == nil then
                    local segundos = 900
                    areaDominada[area] = 3600 --horas dominadas
                    dominando[user_id] = true
                    vCLIENT._toggleContador(source, true, 20)

                    async(function()
                        while dominando[user_id] do
                            
                            segundos = segundos + 1
                            if segundos == 1 then
                                TriggerClientEvent("Notify",source, "importante","Você iniciou a dominação não passe de <b>"..trafico[area].Distancia[1].."m</b>, caso contrario a dominação sera cancelada.", 5)
                                TriggerClientEvent('chatMessage', -1, '^8[NATIVIDADE NEWS] ^0Uma zona de conflito esta sendo dominada nesse momento.')
                                vCLIENT._dominando(source, true, user_id, area)
                                vCLIENT._setBlips(-1, true, area, trafico[area].Cordenadas[1],trafico[area].Cordenadas[2],trafico[area].Cordenadas[3])
                            elseif segundos == 120 then
                                TriggerClientEvent('chatMessage', -1, '^8[NATIVIDADE NEWS] ^0Uma zona de conflito esta sendo dominada nesse momento.')
                            elseif segundos == 240 then
                                TriggerClientEvent('chatMessage', -1, '^8[NATIVIDADE NEWS] ^0Uma zona de conflito esta sendo dominada nesse momento.')
                            elseif segundos == 480 then
                                TriggerClientEvent('chatMessage', -1, '^8[NATIVIDADE NEWS] ^0Uma zona de conflito esta sendo dominada nesse momento.')
                            elseif segundos >= 900 then --mudar aqui -- por isso
                                local zonas = vRP.getSData("vRP:GangZone")
                                local rzonas = json.decode(zonas)

                                rzonas[area] = { dominado = org }
                                vRP.setSData("vRP:GangZone", json.encode(rzonas))

                                TriggerClientEvent('chatMessage', -1, '^8[NATIVIDADE NEWS] ^0Uma zona de conflito foi dominada com sucesso.')
                                TriggerClientEvent("Notify",source,"importante","Sua Organizacao dominou este local", 5)

                                if area == "Lsd" then
                                    vRP.giveInventoryItem(user_id, "lsd", math.random(200,400),true)
                                end

                                Wait(1000)
                                atualizarZonas()
                                dominando[user_id] = false
                                areaDominada[area] = 3600 -- HORAS DOMINADAS
                                vCLIENT._dominando(source, false, user_id, area)
                                vCLIENT._setBlips(-1, false, area)
                            end

                            if GetEntityHealth(GetPlayerPed(source)) <= 105 then
                                TriggerClientEvent('chatMessage', -1, '^8[NATIVIDADE NEWS] ^0A zona de conflito foi controlada, um dos invasores morreu e perderam o controle da zona.')
                                TriggerClientEvent("Notify",source,"importante","Sua Organizacao perdeu o controle dessa zona", 5)
                                vCLIENT._dominando(source, false, user_id, area)
                                vCLIENT._toggleContador(source, false, 0)
                                dominando[user_id] = false
                                areaDominada[area] = 5800
                            end

                            Citizen.Wait(1000)

                        end
                    end)

                else
                    TriggerClientEvent("Notify",source,"importante","Esta zona ja teve uma guerra recentemente aguarde <b> "..convertSeconds(areaDominada[area]).." </b> .", 5)
                end
            else
                TriggerClientEvent("Notify",source,"importante","Voce ja esta dominando este local ", 5)
            end
        else
            TriggerClientEvent("Notify",source,"negado","Você não pode dominar uma área que já é sua.", 5)
        end

	end
end

function src.cancelDomination(user_id, area)
	local source = source
	dominando[user_id] = false
    areaDominada[area] = 5800
    vCLIENT.toggleContador(source, false, 0)
    vCLIENT.setBlips(-1, false, area)
	TriggerClientEvent('chatMessage', -1, '^8[NATIVIDADE NEWS] ^0A zona de conflito foi controlada, um dos invasores fugiram.')
	TriggerClientEvent("Notify",source,"importante","Sua Organizacao perdeu o controle dessa zona", 5)
end


RegisterCommand('dominacao', function(source,args)
    local mensagem = ""

    for k,v in pairs(trafico) do
        if k ~= "Maconha" then
            if areaDominada[k] ~= nil then
                mensagem = mensagem.."Zona <b>"..k.."</b>:<br> Dominada: <b>["..trafico[k].Controlado[1].."]</b> <br>Status: <b>"..convertMins(areaDominada[k]).."</b><br><br>"
            else
                mensagem = mensagem.."Zona <b>"..k.."</b>:<br> Dominada: <b>["..trafico[k].Controlado[1].."]</b> <br>Status: <b>Disponivel</b><br><br>"
            end
        end
    end

    TriggerClientEvent("Notify",source,"importante",mensagem, 5)
end)

function convertMins(seconds)
	local seconds = tonumber(seconds)

	if seconds <= 0 then
	  return "00:00";
	else
	  hours = string.format("%02.f", math.floor(seconds/3600));
      mins = string.format("%02.f", math.floor(seconds/60 - (hours*60)));
      secs = string.format("%02.f", math.floor(seconds - hours*3600 - mins *60));
	  return hours..":"..mins..":"..secs
	end
end

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- SISTEMA DE FARM
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function src.checkOwner(id)
	local source = source
    local user_id = vRP.getUserId(source)
	local org = src.checkOrg()
    if user_id then
        if trafico[id].Controlado[1] == org then
			return true
		else
			TriggerClientEvent("Notify",source,"negado","Voce precisa dominar essa zona primeiro", 5)
		end
	end
end

function src.giveItem(item,quantidade) --arrumar
	local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
        print(("user_id %s attempt spawn %s x %s"):format(user_id, item, quantidade))
        return true
    end
end

function src.tryDrogas()
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
        if vRP.tryGetInventoryItem(user_id, "folhamaconha", 1, true) then
            vRP.giveInventoryItem(user_id, "maconha", 2, true)
            return true
        elseif vRP.tryGetInventoryItem(user_id, "pastabase", 1, true) then
            vRP.giveInventoryItem(user_id, "cocaina", 2, true)
            return true
        elseif vRP.tryGetInventoryItem(user_id, "tiner", 1, true) then
            vRP.giveInventoryItem(user_id, "lancaperfume", 2, true)
            return true
        elseif vRP.tryGetInventoryItem(user_id, "acidolsd", 1, true) then
            vRP.giveInventoryItem(user_id, "lsd", 2, true)
            return true
        elseif vRP.tryGetInventoryItem(user_id, "opiopapoula", 1, true) then
            vRP.giveInventoryItem(user_id, "heroina", 2, true)
            return true
        elseif vRP.tryGetInventoryItem(user_id, "podemd", 1, true) then
            vRP.giveInventoryItem(user_id, "balinha", 2, true)
            return true
        elseif vRP.tryGetInventoryItem(user_id, "anfetamina", 1, true) then
            vRP.giveInventoryItem(user_id, "metanfetamina", 2, true)
            return true
        end
    end
end

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- CARREGAR ZONAS DOMINADAS
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function atualizarZonas(first)
    local zonas = vRP.getSData("vRP:GangZone")
    local rzonas = json.decode(zonas) or {} -- Certifique-se de inicializar rzonas como uma tabela vazia, caso a decodificação falhe

    if first then
        rzonas["Lsd"] = nil
        rzonas["Maconha"] = nil

        vRP.setSData("vRP:GangZone", json.encode(rzonas))
    end

    for k, v in pairs(rzonas) do
        if trafico[k] and trafico[k].Controlado then
            trafico[k].Controlado[1] = v.dominado
        end
    end

    vCLIENT._enviarStatus(-1, trafico)
end

CreateThread(function()
    Wait(3000)
    atualizarZonas(true)
end)


RegisterCommand('resetartemp', function(source,args)
    local user_id = vRP.getUserId(source)
    if user_id then
        if vRP.hasPermission(user_id, "developer.permissao") then
            local area = args[1]
            if area ~= nil and area ~= "" then
                areaDominada[area] = 0
                TriggerClientEvent("Notify",source,"negado","Voce resetou a area: "..area, 5)
            end
        end
    end
end)
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--  CONTADOR
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10000)
		for k,v in pairs(areaDominada) do
			if v > 0 then
				areaDominada[k] = v - 10
			end

			if areaDominada[k] == 0 then
				areaDominada[k] = nil
			end
		end
	end
end)
