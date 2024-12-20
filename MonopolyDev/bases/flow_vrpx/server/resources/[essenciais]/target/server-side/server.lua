local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPC = Tunnel.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

src = {}
Tunnel.bindInterface("vrp_admin",src)
Proxy.addInterface("vrp_admin",src)

vCLIENT = Tunnel.getInterface("vrp_hospital")
vCLIENT2 = Tunnel.getInterface("flow_inventory")
vCLIENT3 = Tunnel.getInterface("vrp_policia")

local tentativas = {}
local delayShip = {}

local other = nil
local drag = false
local carregado = false

local cobrado = {}


RegisterNetEvent('llimao:reanimar')
AddEventHandler('llimao:reanimar', function()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id ~= nil then
		if vRP.hasPermission(user_id, "perm.unizk") then
			local nplayer = vRPclient.getNearestPlayer(source,5)
			if nplayer then
				local nuser_id = vRP.getUserId(nplayer)
				if (GetEntityHealth(GetPlayerPed(nplayer)) <= 105) then
					if tentativas[tonumber(nuser_id)] == nil then tentativas[tonumber(nuser_id)] = 0 end
						local chance = math.random(100)
	
						if tentativas[tonumber(nuser_id)] >= 0 then
							if chance >= 0 then -- PADRAO 50
								tentativas[tonumber(nuser_id)] = 0
								TriggerClientEvent("Notify",nplayer,"sucesso","Você está com <b>pulsação</b>, aguarde o medicamento fazer efeito.", 5)
								TriggerClientEvent("Notify",source,"sucesso","O Cidadão está com <b>pulsação</b>, realizando tratamento.", 5)
								exports["vrp"]:setBlockCommand(source, 13)
								vRP.giveMoney(user_id, 2000)
	
								SetTimeout(2*1000, function()  
									vRPclient.playAnim(source, false,{{"mini@cpr@char_a@cpr_def","cpr_intro"}},true)
									SetTimeout(10*1000, function()  
										vRPclient._stopAnim(source, false)
										vRPclient._setHealth(nplayer, 110)
									end)
								end)
							else
								tentativas[tonumber(nuser_id)] = 1 + tentativas[tonumber(nuser_id)]
								if tentativas[tonumber(nuser_id)] >= 2 then
									TriggerClientEvent("Notify",source,"negado","O Cidadão acabou <b>morrendo</b> pois não aguentou os ferimentos.", 5)
									TriggerClientEvent("Notify",nplayer,"negado","Você não resistiu aos <b>ferimentos</b>", 5)
									vRPclient._setComa(nplayer, 15)
									tentativas[tonumber(nuser_id)] = -1
									
									SetTimeout(15*1000, function()  
										vRPclient._killPlayer(nplayer)
										tentativas[tonumber(nuser_id)] = 0
									end)
								else
									TriggerClientEvent("Notify",source,"negado","O Cidadão está sem <b>pulsação</b>, tente novamente.", 5)
									TriggerClientEvent("Notify",nplayer,"negado","Você está sem <b>pulsação</b>, o medico ira tentar novamente pela ultima vez", 5)
								end
							end
						else
							TriggerClientEvent("Notify",source,"negado","O Cidadão está <b>morto</b>.", 5)
						end	
				else
					TriggerClientEvent("Notify",source,"negado","Este jogador não esta em coma.", 3)
				end
			else
				TriggerClientEvent("Notify",source,"negado","Nenhum jogador proximo.", 5)
			end
		end
	end
end)

local delay = {}
RegisterNetEvent('tratamento:llimao')
AddEventHandler('tratamento:llimao', function()
	local source = source
	local user_id = vRP.getUserId(source)
	local nplayer = vRPclient.getNearestPlayer(source, 5)
	local nuser_id = vRP.getUserId(nplayer)
	if nplayer then
		delay[user_id] = true
		
		local deitado,tratamento = vCLIENT.checkPaciente(nplayer)
		if deitado then
			if not tratamento then
				if vRP.hasPermission(user_id, "perm.unizk") then
					vRPclient._playAnim(source, false, {{"amb@prop_human_parking_meter@female@idle_a", "idle_a_female"}}, true )
					if vRP.request(nplayer, "Você deseja aceitar o tratamento por <b>$ 2.000</b> ?",30) then

						TriggerClientEvent("progress", source, 20)
						exports["vrp"]:setBlockCommand(user_id, 15)
												
						SetTimeout(20000,function()
							TriggerClientEvent("Notify",source,"sucesso","Tratamento iniciado.", 5)
							vRP.giveMoney(user_id, 2500)
							vCLIENT._iniciarTratamento(nplayer)
							exports["vrp"]:setBlockCommand(nuser_id, 59)
							vRPclient._stopAnim(source, false)
							delay[user_id] = nil
							return true
						end)
						

					else
						TriggerClientEvent("Notify",source,"negado","O paciente recusou o tratamento.", 5)
					end

				else
					TriggerClientEvent("Notify",source,"negado","Você não está em expediente para realizar o tratamento.", 5)
				end
			else
				TriggerClientEvent("Notify",source,"negado","Este paciente ja esta em tratamento.", 5)
			end
		else
			TriggerClientEvent("Notify",source,"negado","Nenhum paciente deitado na maca.", 5)
		end

		delay[user_id] = nil
	else
		TriggerClientEvent("Notify",source,"negado","Nenhum jogador proximo.", 5)
	end
end)

RegisterNetEvent('llimao:revistarc')
AddEventHandler('llimao:revistarc', function()
	
	local source = source
	local user_id = vRP.getUserId(source)
	
	local nplayer = vRPclient.getNearestPlayer(source, 5)
	local nuser_id = vRP.getUserId(nplayer)
	
	local ped = GetPlayerPed(nplayer)
	if ped and DoesEntityExist(ped) then
		local items = vRP.getInventory(nuser_id)
		local info = ""
		for k,v in pairs(items) do
			info = info .. k .. ": " .. v.amount .. "<br>"
		end
		TriggerClientEvent("llimao:revistar", source, info)
	else
		TriggerClientEvent('Notify', source, 'negado', 'Não há jogadores por perto')
	end
	
end)

RegisterNetEvent('llimao:algemardesalgemar')
AddEventHandler('llimao:algemardesalgemar', function()

	local source = source
	local user_id = vRP.getUserId(source)
	local nplayer = vRPclient.getNearestPlayer(source, 5)
	local nuser_id = vRP.getUserId(nplayer)
	
	if nplayer then

		if not vCLIENT2.checkAnim(nplayer) and not vRPclient.isHandcuffed(nplayer) and not vRP.checkPatrulhamento(user_id) then
			TriggerClientEvent("Notify", source, "importante", "O jogador não está algemado ou rendido.", 5)
			return
		end
		
		if not vRPclient.isHandcuffed(nplayer) then
			if vRP.tryGetInventoryItem(user_id, "algemas", 1, true, slot) then
				vRP.giveInventoryItem(user_id, "chave_algemas", 1, true)
				vCLIENT3._arrastar(nplayer, source)
				
				vRPclient._playAnim(source, false,{{"mp_arrest_paired", "cop_p2_back_left"}},false)
				vRPclient._playAnim(nplayer, false,{{"mp_arrest_paired", "crook_p2_back_left"}},false)
				
				SetTimeout(3500,function()
					vRPclient._stopAnim(source, false)
					vRPclient._toggleHandcuff(nplayer)
					vCLIENT3._arrastar(nplayer, source)
					TriggerClientEvent("vrp_sound:source", source, "cuff", 0.1)
					TriggerClientEvent("vrp_sound:source", nplayer, "cuff", 0.1)
					vRPclient.setHandcuffed(nplayer, true)
				end)
				
			else
				TriggerClientEvent( "Notify", source, "negado", "Você não possui algemas.", 6 )
			end
		elseif vRPclient.isHandcuffed(nplayer) then
			if vRP.tryGetInventoryItem(user_id, "chave_algemas", 1) then
				
				vCLIENT3.arrastar(nplayer,source)
				vRPclient._playAnim(source,false,{{"mp_arresting","a_uncuff"}},false)
				
				SetTimeout(4400,function()
					TriggerClientEvent("vrp_sound:source",source,'uncuff',0.1)
					TriggerClientEvent("vrp_sound:source",nplayer,'uncuff',0.1)
					vRPclient.setHandcuffed(nplayer, false)
					vCLIENT3.arrastar(nplayer,source)
				end)
				
			else
				TriggerClientEvent( "Notify", source, "negado", "Você não possui chave de algemas.", 5 )
			end
		end
	end
end)

RegisterNetEvent('Danike:prender')
AddEventHandler('Danike:prender', function()
    local source = source
    local user_id = vRP.getUserId(source)

    local nplayer = vRPclient.getNearestPlayer(source, 5)
    local nuser_id = vRP.getUserId(nplayer)

    if nuser_id then
		if vRP.hasPermission(user_id,"perm.policia") or vRP.hasPermission(user_id,"perm.policiacivil") then
			vRPclient._CarregarObjeto(source,"amb@code_human_in_bus_passenger_idles@female@tablet@idle_a","idle_b","prop_cs_tablet",49,60309)
			local id = vRP.prompt(source,"Passaporte:","")
			local tempo = vRP.prompt(source,"Tempo:","")
			local crimes = vRP.prompt(source,"Crimes:","")
			if id == "" or tempo == "" or crimes == "" then
				vRPclient._DeletarObjeto(source)
				return
			end
			local oficialid = vRP.getUserIdentity(user_id)
			local identity = vRP.getUserIdentity(parseInt(id))
			local nplayer = vRP.getUserSource(parseInt(id))
			if vRP.request(source,"Deseja prender o Passaporte: <b>"..id.." "..identity["nome"].." "..identity["sobrenome"].."</b> por <b>"..vRP.format(parseInt(tempo)).." meses</b> ?",30) then
				vRP.setUData(parseInt(id),"vRP:prisao",json.encode(parseInt(tempo)))
				prison_lock(parseInt(id))
				TriggerClientEvent("vrp_sound:source",source,'jaildoor',0.7)
	
				randmoney = math.random(10,150)
				vRP.injectMoneyLimpo(user_id,parseInt(randmoney))
				TriggerClientEvent("Notify",source,"sucesso","Prisão efetuada com sucesso.")
				TriggerClientEvent("Notify",source,"importante","Você recebeu <b>$"..vRP.format(parseInt(randmoney)).." dólares</b> de bonificação.")
				vRPclient.playSound(source,"Hack_Success","DLC_HEIST_BIOLAB_PREP_HACKING_SOUNDS")
				if nplayer ~= nil then
					vRPclient.setHandcuffed(nplayer,false)
					TriggerClientEvent('prisioneiro',nplayer,true)
					vRPclient.teleport(nplayer,1680.1,2513.0,45.5)
					TriggerClientEvent('removealgemas',nplayer)
					TriggerClientEvent("vrp_sound:source",nplayer,'jaildoor',0.7)
					TriggerClientEvent("Notify",nplayer,"importante","Você foi preso por <b>"..vRP.format(parseInt(tempo)).." meses</b>.<br><b>Motivo:</b> "..crimes..".")
					vRPclient.playSound(nplayer,"Hack_Success","DLC_HEIST_BIOLAB_PREP_HACKING_SOUNDS")
					SetTimeout(1000,function()
						local model = vRPclient.getModelPlayer(nplayer)
						if model == "mp_m_freemode_01" then
							TriggerClientEvent("updateRoupas",nplayer,{ -1,0,-1,0,0,0,15,0,64,6,15,0,1,0,238,0,-1,0,0,0,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1 })
						elseif model == "mp_f_freemode_01" then
							TriggerClientEvent("updateRoupas",nplayer,{ -1,0,0,0,0,0,4,0,101,6,7,0,1,1,247,0,0,0,0,0,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1 })
						end
					end)
				end
			end
			vRPclient._DeletarObjeto(source) 
		end
	end
end)


-- Verifica o tempo de prisão ao entrar no servidor ou ressuscitar
RegisterServerEvent("vRP:playerSpawn")
AddEventHandler("vRP:playerSpawn", function(user_id, source, first_spawn)
    local player = vRP.getUserSource(parseInt(user_id))
    if player then
        SetTimeout(30000, function()
            local value = vRP.getUData(parseInt(user_id), "vRP:prisao")
            local tempo = json.decode(value) or -1

            if tempo > 0 then
                TriggerClientEvent('prisioneiro', player, true)
                vRPclient.teleport(player, 1680.1, 2513.0, 46.5)
                prison_lock(parseInt(user_id))
            end
        end)
    end
end)

-- Função para controlar o tempo de prisão
function prison_lock(target_id)
    local player = vRP.getUserSource(parseInt(target_id))
    if player then
        SetTimeout(60000, function()
            local value = vRP.getUData(parseInt(target_id), "vRP:prisao")
            local tempo = json.decode(value) or 0

            if tempo > 0 then
                TriggerClientEvent("Notify", player, "importante", "Ainda vai passar <b>" .. tempo .. " meses</b> preso.")
                vRP.setUData(parseInt(target_id), "vRP:prisao", json.encode(tempo - 1))
                prison_lock(parseInt(target_id))
            elseif tempo == 0 then
                TriggerClientEvent('prisioneiro', player, false)
                vRPclient.teleport(player, 1850.5, 2604.0, 45.5)
                vRP.setUData(parseInt(target_id), "vRP:prisao", json.encode(-1))
                TriggerClientEvent("Notify", player, "importante", "Sua sentença terminou, esperamos não vê-lo novamente.")
            end
            vRPclient.PrisionGod(player)
        end)
    end
end

-- Reduzir a pena do jogador
RegisterServerEvent("danike:pena")
AddEventHandler("danike:pena", function()
    local source = source
    local user_id = vRP.getUserId(source)
    local value = vRP.getUData(parseInt(user_id), "vRP:prisao")
    local tempo = json.decode(value) or 0

    if tempo >= 20 then
        vRP.setUData(parseInt(user_id), "vRP:prisao", json.encode(tempo - 4))
        TriggerClientEvent("Notify", source, "importante", "Sua pena foi reduzida em <b>4 meses</b>, continue o trabalho.")
    else
        TriggerClientEvent("Notify", source, "importante", "Atingiu o limite da redução de pena, não precisa mais trabalhar.")
    end
end)


RegisterNetEvent('llimao:colocarnoveiculo')
AddEventHandler('llimao:colocarnoveiculo', function()
	local source = source
	local user_id = vRP.getUserId(source)
	local nplayer = vRPclient.getNearestPlayer(source, 5)
	local nuser_id = vRP.getUserId(nplayer)
	
	if user_id ~= nil then
		  local nplayer = vRPclient.getNearestPlayer(source,10)
		  if nplayer then
			  local nuser_id = vRP.getUserId(nplayer)
			  if nuser_id ~= nil then
				  if (GetEntityHealth(GetPlayerPed(nplayer)) <= 105) then
					  vRPclient._stopAnim(source, true)
					  vRPclient._stopAnim(source, false)
					  vRPclient._unDrag(nplayer, source)
					  vRPclient._putInNearestVehicleAsPassenger(nplayer, 5)
				  else
					TriggerClientEvent("Notify",source,"negado","Este jogador não esta em coma.", 3)
				  end
			  end
		  else
			TriggerClientEvent("Notify",source,"negado","Nenhum jogador proximo.", 5)
		  end
	end

end)


RegisterNetEvent('llimao:cobrar')
AddEventHandler('llimao:cobrar', function()
	
	local source = source
	local user_id = vRP.getUserId(source)
	
	local nplayer = vRPclient.getNearestPlayer(source,3)
	local nuser_id = vRP.getUserId(nplayer)
	
	local identity = vRP.getUserIdentity(nuser_id)
	local identity2 = vRP.getUserIdentity(user_id)
	
	if not cobrado[tonumber(nuser_id)] then
		cobrado[tonumber(nuser_id)] = 0
	end
	
	if cobrado[tonumber(nuser_id)] == 0 then
		local valor_cobrar = parseInt(vRP.prompt(source, "Quanto deseja cobrar? ",""))
		if not VerificarNumero(valor_cobrar) then
			if tonumber(valor_cobrar) then
				cobrado[tonumber(nuser_id)] = 1
				if valor_cobrar == 0 then
					TriggerClientEvent("Notify",source,"negado","Digite um valor valido!", 5)
					cobrado[tonumber(nuser_id)] = 0
				elseif vRP.request(nplayer, "Pagar uma cobrança para "..identity2.nome.." "..identity2.sobrenome.." no valor de <b>$ "..vRP.format(valor_cobrar).." </b> ?", 15) then
					if vRP.tryFullPayment(nuser_id, valor_cobrar) then
						vRP.giveMoney(user_id, valor_cobrar)
					
						TriggerClientEvent("Notify",source,"sucesso","Você recebeu uma transferencia de <b>"..identity.nome.." "..identity.sobrenome.."</b> no valor de<b>$ "..vRP.format(valor_cobrar).."</b>", 5)
						TriggerClientEvent("Notify",nplayer,"sucesso","Voce fez um pagamento para "..identity2.nome.." "..identity2.sobrenome.." no valor de <b>$ "..vRP.format(valor_cobrar).."!", 5)
						
						cobrado[tonumber(nuser_id)] = 0
					
					else
						TriggerClientEvent("Notify",source,"negado","O Cidadão não tem dinheiro suficiente!", 5)
						TriggerClientEvent("Notify",nplayer,"negado","Você não tem dinheiro para isso!", 5)
						cobrado[tonumber(nuser_id)] = 0
					end
				else
					TriggerClientEvent("Notify",source,"negado","O Cidadão não pagou a sua cobrança!", 5)
					cobrado[tonumber(nuser_id)] = 0
				end
			else
				TriggerClientEvent("Notify",source,"negado","Digite um valor valido!", 5)
				cobrado[tonumber(nuser_id)] = 0
			end
		else
			TriggerClientEvent("Notify",source,"negado","Digite um valor valido!", 5)
		end
	else
		TriggerClientEvent("Notify",source,"negado","Uma cobrança já está em andamento, aguarde...", 5)
	end
end)

RegisterNetEvent('llimao:colocarnoveiculoPM')
AddEventHandler('llimao:colocarnoveiculoPM', function()
	local user_id = vRP.getUserId(source)
	local nplayer = vRPclient.getNearestPlayer(source,10)
	if vRPclient.getHealth(source) <= 101 or vRPclient.isHandcuffed(source) then
		return
	end
	if vRP.hasPermission(user_id,"perm.policiacivil") or vRP.hasPermission(user_id,"perm.policia") or vRP.hasPermission(user_id,"perm.unizk") or vRP.hasPermission(user_id,"perm.mecanica") or vRPclient.getHealth(nplayer) <= 101 then
		if nplayer then
			vRPclient.putInNearestVehicleAsPassenger(nplayer,7)
		end
	end
end)

RegisterNetEvent('llimao:tirardoveiculo')
AddEventHandler('llimao:tirardoveiculo', function()

	local user_id = vRP.getUserId(source)
	local nplayer = vRPclient.getNearestPlayer(source,4)
	if vRP.hasPermission(user_id,"perm.policiacivil") or vRP.hasPermission(user_id,"perm.policia") or vRP.hasPermission(user_id,"perm.unizk") or vRP.hasPermission(user_id,"perm.mecanica") or vRPclient.getHealth(nplayer) <= 101 then
		if user_id then
			if nplayer then
				if vRPclient.isHandcuffed(nplayer) then
					vRPclient._ejectVehicle(nplayer, {})
					TriggerClientEvent("Notify",source,"negado","Voce retirou o cidadao no veiculo.", 5)
				else
					TriggerClientEvent("Notify",source,"negado","O Jogador não está algemado.", 5)
				end
			else
				TriggerClientEvent("Notify",source,"negado","Nenhum jogador proximo.", 5)
			end
		end
	end
end)

RegisterNetEvent('llimao:capuz')
AddEventHandler('llimao:capuz', function()
	
	local source = source
	local user_id = vRP.getUserId(source)
	local nplayer = vRPclient.getNearestPlayer(source, 5)
	
	if nplayer then
		local nuser_id = vRP.getUserId(nplayer)
		local nplayer = vRPclient.getNearestPlayer(source, 5)
		if vRPclient.isHandcuffed(nplayer) then
			if vRPclient.isCapuz(nplayer) then
				vRPclient._setCapuz(nplayer, false)
			elseif vRP.tryGetInventoryItem(user_id, "capuz", 1) then
				vRP.sendLog("", "O USER_ID: "..user_id.. " Usou o Capuz no USER_ID: "..nuser_id)
				vRPclient._setCapuz(nplayer, true)
			else
				TriggerClientEvent( "Notify", source, "negado", "Você não tem capuz.", 6 )
			end
		else
			TriggerClientEvent( "Notify", source, "negado", "O Cidadão não está algemado.", 6 )
		end
	else
		TriggerClientEvent( "Notify", source, "negado", "Nenhum cidadao proximo.", 6 )
	end
	
end)

RegisterNetEvent('llimao:Verificaplaca')
AddEventHandler('llimao:Verificaplaca', function()
	local source = source
    local user_id = vRP.getUserId(source)
	if user_id then
		local mPlaca,mName = vRPclient.ModelName(source, 5)
		local nuser_id = vRP.getUserByRegistration(mPlaca)
		if nuser_id then
			local identity = vRP.getUserIdentity(nuser_id)
			if identity then
				TriggerClientEvent("Notify",source,"importante","• Veiculo: <b>"..mName.."</b><br>• Placa: <b>"..mPlaca.."</b><br>• Proprietario: <b>"..identity.nome.. " "..identity.sobrenome.. "</b> (<b>"..identity.idade.."</b>)<br>• Telefone: <b>"..identity.telefone.."</b> <br>• Passaporte: <b>"..identity.user_id.."</b> ", 10)
			end
		else
			TriggerClientEvent("Notify",source,"negado","Não foi possivel consultar esse veiculo.", 5)
		end
	end
end)

RegisterNetEvent('llimao:repararmotor')
AddEventHandler('llimao:repararmotor', function()
	local source = source
    local user_id = vRP.getUserId(source)
	if user_id then
		if not vRPclient.isInVehicle(source) then
			local vehicle = vRPclient.getNearestVehicle(source, 4)
			if vehicle then
				if vRP.tryGetInventoryItem(user_id, "militec", 1, true, slot) or vRP.hasPermission(user_id, "perm.bennys") then
					vRPclient._playAnim( source, false, {{"mini@repair", "fixing_a_player"}}, true )
					TriggerClientEvent("progress", source, 15)
					exports["vrp"]:setBlockCommand(user_id, 15)
					
					TriggerClientEvent("abrircapo", source, vehicle)
					
					SetTimeout(15000,function()
						TriggerClientEvent("repararm", source, vehicle)
						vRPclient._stopAnim(source, false)
						TriggerClientEvent( "Notify", source, "sucesso", "Motor reparado.", 6 )
					end)
				else
					TriggerClientEvent( "Notify", source, "negado", "Você precisa de uma militec.", 5 )
				end
			else
				TriggerClientEvent( "Notify", source, "negado", "Nenhum veiculo próximo.", 5 )
			end
		else
			TriggerClientEvent( "Notify", source, "negado", "Você precisa sair do veiculo.", 5 )
		end
	end
end)

RegisterNetEvent('llimao:repararlataria')
AddEventHandler('llimao:repararlataria', function()
	local source = source
    local user_id = vRP.getUserId(source)
	if user_id then
		if not vRPclient.isInVehicle(source) then
			local vehicle = vRPclient.getNearestVehicle(source, 4)
			if vehicle then
				if vRP.tryGetInventoryItem(user_id, "desamassador", 1, true, slot) or vRP.hasPermission(user_id, "perm.bennys") then
					vRPclient._playAnim( source, false, {{"mini@repair", "fixing_a_player"}}, true )
					TriggerClientEvent("progress", source, 20)
					exports["vrp"]:setBlockCommand(user_id, 15)
					
					SetTimeout(20000,function()
						TriggerClientEvent("reparar", source, vehicle)
						
						vRPclient._stopAnim(source, false)
						TriggerClientEvent( "Notify", source, "sucesso", "Lataria reparada.", 5 )
					end)
				else
					TriggerClientEvent( "Notify", source, "negado", "Você precisa de um Reparo de Lataria.", 5 )
				end
			else
				TriggerClientEvent( "Notify", source, "negado", "Nenhum veiculo próximo.", 5 )
			end
		else
			TriggerClientEvent( "Notify", source, "negado", "Você precisa sair do veiculo.", 5 )
		end
	end
end)



RegisterNetEvent('casar:pedido')
AddEventHandler('casar:pedido', function()
	local source = source
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	
	if user_id then
		if not delayShip[user_id] then delayShip[user_id] = 0 end

		if vRP.getInventoryItemAmount(user_id, "alianca") <= 0 then
			TriggerClientEvent("Notify",source,"negado","Você não possui uma aliança.",5)
			return
		end

		if (os.time() - delayShip[user_id]) < 3 then
			TriggerClientEvent("Notify",source,"negado","Aguarde para fazer um pedido novamente.",5)
			return
		end

		local shipUserId = getRelacionamento(user_id)
		if shipUserId.tipo ~= nil then
			if shipUserId.tipo == "Casado(a)" then
				TriggerClientEvent("Notify",source,"negado","Sossega! Você já está Casado(a).",5)
				return
			end

			local nplayer = vRPclient.getNearestPlayer(source, 5)
			if nplayer then
				local nuser_id = vRP.getUserId(nplayer)
				local nidentity = vRP.getUserIdentity(nuser_id)
				if nuser_id then
					if shipUserId.user_id == nuser_id then
						TriggerClientEvent("Notify",source,"negado","Você está fazendo o pedido de casamento...",5)

						local requestCasamento = vRP.request(nplayer, "O(a) "..identity.nome.. " "..identity.sobrenome.." Está pedindo você em casamento, deseja aceitar?", 15)
						if requestCasamento then
							delayShip[user_id] = os.time()
							delayShip[nuser_id] = os.time()
							TriggerClientEvent('chat:addMessage',-1,{template='<div style="display:flex;align-items:center;justify-content:center;padding:10px;margin:5px 0;background-image: linear-gradient(to right, rgba(240, 108, 108,0.8) 3%, rgba(240, 86, 86,0) 95%);border-radius: 5px;"><img width="32" style="float: left;" src="https://cdn.discordapp.com/attachments/928341690828345445/979172601610002453/hearts.png">'..identity.nome.. ' '..identity.sobrenome..' e '..nidentity.nome..' '..nidentity.sobrenome..' acabaram de se casar.</b></div>'})
					
							TriggerClientEvent("emotes", nplayer, "beijar")
							TriggerClientEvent("emotes", source, "beijar")
					
							vRP._execute("setRelacionamento", { user_id = nuser_id, relacionamento = json.encode({ tipo = "Casado(a)", user_id = user_id, data = os.date("%d/%m/%Y", os.time()), name = identity.nome.. " ".. identity.sobrenome }) })
							vRP._execute("setRelacionamento", { user_id = user_id, relacionamento = json.encode({ tipo = "Casado(a)", user_id = nuser_id, data = os.date("%d/%m/%Y", os.time()), name = nidentity.nome.. " ".. nidentity.sobrenome }) })
							vRP._updateIdentity(user_id)
							vRP._updateIdentity(nuser_id)
							vRP.tryGetInventoryItem(user_id, "alianca", 1)
						else
							TriggerClientEvent("emotes", source, "triste")
							TriggerClientEvent("emotes", nplayer, "wtf")
							vRPclient._stopAnim(source, false)
							vRPclient._stopAnim(nplayer, false)
							TriggerClientEvent("Notify",source,"negado","Seu Pedido foi recusado.",5)
						end
					else
						TriggerClientEvent("Notify",source,"negado","Essa pessoa não namora você.",5)
					end
				end
			end
		else
			TriggerClientEvent("Notify",source,"negado","Você não está em uma relação no momento.",5)
			return
		end
	end
end)

RegisterNetEvent('namorar:pedido')
AddEventHandler('namorar:pedido', function()
    local source = source
    local user_id = vRP.getUserId(source)
    local identity = vRP.getUserIdentity(user_id)

    if user_id then
        if not delayShip[user_id] then delayShip[user_id] = 0 end

        if vRP.getInventoryItemAmount(user_id, "alianca") <= 0 then
            TriggerClientEvent("Notify",source,"negado","Você não possui uma aliança.",5)
            return
        end

        if (os.time() - delayShip[user_id]) < 3 then
            TriggerClientEvent("Notify",source,"negado","Aguarde para fazer um pedido novamente.",5)
            return
        end

        local nplayer = vRPclient.getNearestPlayer(source, 5)
        if nplayer then
            local nuser_id = vRP.getUserId(nplayer)
            local nidentity = vRP.getUserIdentity(nuser_id)
            if nuser_id then
                local shipNUserId = getRelacionamento(nuser_id)
                if shipNUserId.tipo ~= nil then
                    TriggerClientEvent("Notify",source,"negado","Este Jogador já está em uma relação no momento.",5)
                    return
                end
                TriggerClientEvent("Notify",source,"negado","Você está fazendo o pedido de namoro...",5)

                TriggerClientEvent("emotes", nplayer, "cruzar")
                TriggerClientEvent("emotes", source, "ajoelhar")
                TriggerClientEvent("emotes", source, "rosa")

                local requestCasamento = vRP.request(nplayer, "O(a) "..identity.nome.. " "..identity.sobrenome.." Está pedindo sua mão em namoro, deseja aceitar?",15)
                if requestCasamento then
                    delayShip[user_id] = os.time()
                    delayShip[nuser_id] = os.time()

                    TriggerClientEvent('chat:addMessage',-1,{template='<div style="display:flex;align-items:center;justify-content:center;padding:10px;margin:5px 0;background-image: linear-gradient(to right, rgba(240, 108, 108,0.8) 3%, rgba(240, 86, 86,0) 95%);border-radius: 5px;"><img width="32" style="float: left;" src="https://cdn.discordapp.com/attachments/928341690828345445/979172601610002453/hearts.png">'..identity.nome.. ' '..identity.sobrenome..' está namorando '..nidentity.nome..' '..nidentity.sobrenome..'</b></div>'})
                    TriggerClientEvent("emotes", nplayer, "beijar")
                    TriggerClientEvent("emotes", source, "beijar")

					vRP._execute("setRelacionamento", { user_id = nuser_id, relacionamento = json.encode({ tipo = "Namorando", user_id = user_id, data = os.date("%d/%m/%Y", os.time()), name = identity.nome.. " ".. identity.sobrenome }) })
					vRP._execute("setRelacionamento", { user_id = user_id, relacionamento = json.encode({ tipo = "Namorando", user_id = nuser_id, data = os.date("%d/%m/%Y", os.time()), name = nidentity.nome.. " ".. nidentity.sobrenome }) })
					vRP._updateIdentity(user_id)
					vRP._updateIdentity(nuser_id)
					vRP.tryGetInventoryItem(user_id, "alianca", 1)
				else
					TriggerClientEvent("emotes", source, "triste")
					TriggerClientEvent("emotes", nplayer, "wtf")
					vRPclient._stopAnim(source, false)
					vRPclient._stopAnim(nplayer, false)
					TriggerClientEvent("Notify",source,"negado","Seu Pedido foi recusado.",5)
				end
			end
		end
	end
end)

function getRelacionamento(user_id)
    local query = vRP.query("getRelacionamento", { user_id = user_id })
    if #query > 0 then
        return json.decode(query[1].relacionamento)
    end

    return false
end

function VerificarNumero(str)
	return string.match(str, "[%+%-]") ~= nil
end