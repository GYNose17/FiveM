local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

src = {}
Tunnel.bindInterface("vrp_hospital",src)
Proxy.addInterface("vrp_hospital",src)

vCLIENT = Tunnel.getInterface("vrp_hospital")
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- COMANDOS
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
local tentativas = {}
local choice_primeiroSocorros = {function(source,choice)
	local user_id = vRP.getUserId(source)
	if user_id ~= nil then
		local nplayer = vRPclient.getNearestPlayer(source,5)
			if nplayer then
				local nuser_id = vRP.getUserId(nplayer)
				if (GetEntityHealth(GetPlayerPed(nplayer)) <= 105) then
					if tentativas[tonumber(nuser_id)] == nil then tentativas[tonumber(nuser_id)] = 0 end
					local chance = math.random(100)

					if tentativas[tonumber(nuser_id)] >= 0 then
						if chance >= 25 then -- PADRAO 50
							if vRP.request(nplayer, "Você deseja aceitar o tratamento por <b>$ 2.000</b> ?") then
								if vRP.tryFullPayment(tonumber(nuser_id), 2000) then --aqui altera o valor do pagamento do tratamento
									tentativas[tonumber(nuser_id)] = 0
									TriggerClientEvent("Notify",nplayer,"sucesso","Você está com <b>pulsação</b>, aguarde o medicamento fazer efeito.", 5)
									TriggerClientEvent("Notify",source,"sucesso","O Cidadão está com <b>pulsação</b>, realizando tratamento.", 5)
									exports["vrp"]:setBlockCommand(source, 13)
									vRP.giveMoney(user_id, 2000)

									SetTimeout(3*1000, function()  
										vRPclient._playAnim(source, false,{{"mini@cpr@char_a@cpr_def","cpr_intro"}},true)
										SetTimeout(10*1000, function()  
											vRPclient._stopAnim(source, false)
											vRPclient._setHealth(nplayer, 110)
										end)
									end)
								else
									TriggerClientEvent("Notify",source,"negado","O Cidadão não possui dinheiro.", 5)
								end
							end
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
end}

local choice_carregarPaciente = {function(player,choice)
	local user_id = vRP.getUserId(player)
	local nplayer = vRPclient.getNearestPlayer(player,10)
	if user_id ~= nil then
		if nplayer then
			if (GetEntityHealth(GetPlayerPed(nplayer)) <= 105) then
				vRPclient._playAnim(player,true,{{"anim@heists@box_carry@", "idle"}},1,true)
				vRPclient._playAnim(nplayer,false,{{"dead","dead_a"}},1,true)
				vRPclient._setDrag(nplayer, player)
			else
				TriggerClientEvent("Notify",player,"negado","Este jogador não esta em coma.", 3)
			end
		end
	end
end}

local choice_soltarPaciente = {function(player,choice)
	local user_id = vRP.getUserId(player)
	local nplayer = vRPclient.getNearestPlayer(player,10)
	if user_id ~= nil then
		if nplayer then
			vRPclient._stopAnim(player,true)
			vRPclient._stopAnim(player,false)
			vRPclient._unDrag(nplayer, player)
		end
	end
end}

local choice_colocarPaciente = {function(player,choice)
	local user_id = vRP.getUserId(player)
	if user_id ~= nil then
		  local nplayer = vRPclient.getNearestPlayer(player,10)
		  if nplayer then
			  local nuser_id = vRP.getUserId(nplayer)
			  if nuser_id ~= nil then
				  if (GetEntityHealth(GetPlayerPed(nplayer)) <= 105) then
					  vRPclient._stopAnim(player, true)
					  vRPclient._stopAnim(player, false)
					  vRPclient._unDrag(nplayer, player)
					  vRPclient._putInNearestVehicleAsPassenger(nplayer, 5)
				  else
					TriggerClientEvent("Notify",player,"negado","Este jogador não esta em coma.", 3)
				  end
			  end
		  else
			TriggerClientEvent("Notify",player,"negado","Nenhum jogador proximo.", 5)
		  end
	end
end}

local choice_multar = {function(source,choice)
	local user_id = vRP.getUserId(source)
	if user_id then
		local nplayer = vRPclient.getNearestPlayer(source,4)
		local nuser_id = vRP.getUserId(nplayer)
		if nplayer then
			local valorMulta = vRP.prompt(source, "Digite o valor da Multa: ", "")

			if tonumber(valorMulta) >= 1 and tonumber(valorMulta) <= 500000 then
				local motivoMulta = vRP.prompt(source, "Digite o motivo da Multa: ", "")
				if motivoMulta ~= nil and motivoMulta ~= "" then
					TriggerClientEvent("Notify",source,"importante","Você multou o cidadao em <b>$ "..vRP.format(valorMulta).."</b>", 5)
					TriggerClientEvent("Notify",nplayer,"importante","Você foi multado no valor de <b>$ "..vRP.format(valorMulta).."</b> pelo motivo <b>"..motivoMulta.."</b>", 5)
					vRP.execute("vRP/add_multa",{ user_id = nuser_id, multas = tonumber(valorMulta) })
					--src.adicionarCriminal(nuser_id, "MULTA", motivoMulta)
					vRP.sendLog("", "O "..user_id.." Multou o ID: "..nuser_id.." no valor de: R$ "..valorMulta)
				else
					TriggerClientEvent("Notify",source,"importante","Digite um motivo correto", 5)
				end
			else
				TriggerClientEvent("Notify",source,"importante","Digite um valor correto entre 1-500000 ", 5)
			end
		end
	end
end}

local choice_tirarPaciente = {function(player,choice)
	local user_id = vRP.getUserId(player)
	if user_id ~= nil then
		  local nplayer = vRPclient.getNearestPlayer(player,10)
		  if nplayer then
			  local nuser_id = vRP.getUserId(nplayer)
			  if nuser_id ~= nil then
				local plyCoords = GetEntityCoords(GetPlayerPed(player))
            	local x,y,z = plyCoords[1],plyCoords[2],plyCoords[3]
				
				vRPclient._ejectVehicle(nplayer, {})
				vRPclient._teleport(nplayer,x,y,z)
				vRPclient._playAnim(nplayer,false,"dead","dead_a",1,true)
			  end
		  else
			TriggerClientEvent("Notify",player,"negado","Nenhum jogador proximo.", 5)
		  end
	end
end}

RegisterCommand('tratamento', function(source,args)
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
							if vRP.request(nplayer, "Você deseja aceitar o tratamento por <b>$ 2.000</b> ?",30) then
								if vRP.tryFullPayment(tonumber(nuser_id), 2000) then
									tentativas[tonumber(nuser_id)] = 0
									TriggerClientEvent("Notify",nplayer,"sucesso","Você está com <b>pulsação</b>, aguarde o medicamento fazer efeito.", 5)
									TriggerClientEvent("Notify",source,"sucesso","O Cidadão está com <b>pulsação</b>, realizando tratamento.", 5)
									exports["vrp"]:setBlockCommand(source, 13)
									vRP.giveMoney(user_id, 2000)

									SetTimeout(3*1000, function()  
										vRPclient.playAnim(source, false,{{"mini@cpr@char_a@cpr_def","cpr_intro"}},true)
										SetTimeout(10*1000, function()  
											vRPclient._stopAnim(source, false)
											vRPclient._setHealth(nplayer, 110)
										end)
									end)
								else
									TriggerClientEvent("Notify",source,"negado","O Cidadão não possui dinheiro.", 5)
								end
							end
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

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- MENUS
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
vRP._registerMenuBuilder("unizk_menu", function(add, data)
	local user_id = vRP.getUserId(data.player)
	if user_id then
		local choices = {}
		choices["1. Primeiro Socorros"] = choice_primeiroSocorros
		choices["2. Carregar Paciente"] = choice_carregarPaciente
		choices["3. Soltar Paciente"] = choice_soltarPaciente
		choices["4. Colocar no Veiculo"] = choice_colocarPaciente
		choices["5. Tirar do Veiculo"] = choice_tirarPaciente
		choices["6. Retirar mascara"] = choice_rmascarah
		choices["7. Multar"] = choice_multar
		
		add(choices)
	end
end)

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- RETIRAR MASCARA
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
local choice_rmascarah = {function(source,choice)
    local user_id = vRP.getUserId(source)
	if user_id ~= nil then
		local nplayer = vRPclient.getNearestPlayer(source,3)
		if nplayer then
			vCLIENT._retirarMascaraH(nplayer)
		else
			TriggerClientEvent("Notify",source,"negado","Nenhum jogador proximo.", 5)
		end
	end
end}
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--  SISTEMA DE MACA HOSPITAL
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function src.checkUNZIK()
	local unizk = vRP.getUsersByPermission("perm.unizk")
	local count = 0
	
	for k,v in pairs(unizk) do
		if vRP.checkPatrulhamento(parseInt(v)) then
			count = count + 1
		end
 	end
	 
	if count > 0 then
		return true
	else
		return false
	end
end

local delay = {}
function src.checkTratamento()
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
					vRP.giveMoney(user_id, 2500)
					vCLIENT._iniciarTratamento(nplayer)
					exports["vrp"]:setBlockCommand(nuser_id, 59)
					delay[user_id] = nil
					return true
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
end

function src.checkPagamento(valor)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.tryFullPayment(user_id, valor) then
			return true
		else
			TriggerClientEvent("Notify",source,"negado","Você não possui dinheiro.", 5)
		end
	end
end

function src.blockCommands(segundos)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		exports["vrp"]:setBlockCommand(user_id, segundos)
	end
end