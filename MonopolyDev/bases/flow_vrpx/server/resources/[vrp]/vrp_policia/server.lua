local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
local Tools = module("vrp","lib/Tools")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

src = {}
Tunnel.bindInterface("vrp_policia",src)
Proxy.addInterface("vrp_policia",src)

vCLIENT = Tunnel.getInterface("vrp_policia")

local idgens = Tools.newIDGenerator()

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Itens Ilegais
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
local blackItens = {
	"algemas",
	"chave_algemas",
	"c4",
	--"bolsadinheiro",
	"masterpick",
	"pendrive",
	"furadeira",
	"lockpick",
	"m-aco",
	"m-capa_colete",
	"m-corpo_ak47_mk2",
	"m-corpo_g3",
	"m-corpo_machinepistol",
	"m-corpo_pistol_mk2",
	"m-corpo_shotgun",
	"m-corpo_smg_mk2",
	"m-corpo_snspistol_mk2",
	"m-gatilho",
	"capsulas",
	"polvora",
	"pecadearma",
	"pecadearma",
	"rodacarro",
	"portacarro",
	"rodamoto",
    "discofreio",
	"parachoque",
	"volante",
	"motorcarro",
	"motormoto",
	"kevlar",
	"pano",
	"linha",
	"metal",
	"molas",
	"gatilho",
	"m-malha",
	"aluminio",
	"m-tecido",
	"c-cobre",
	"c-ferro",
	"c-fio",
	"c-polvora",
	"l-alvejante",
	"folhamaconha",
	"maconha",
	"haxixe",
	"resinacannabis",
	"pastabase",
	"cocaina",
	"acidolsd",
	"colete",
	"capuz",
	"dirty_money",
	"scubagear",
	"relogioroubado",
	"colarroubado",
	"anelroubado",
	"brincoroubado",
	"pulseiraroubada",
	"carnedepuma",
	"carnedelobo",
	"carnedejavali",
	"lsd",
	"morfina",
	"heroina",
	"anfetamina",
	"metanfetamina",
	"tartaruga",
	"WEAPON_SNSPISTOL_MK2",
	"AMMO_SNSPISTOL_MK2",
	"WEAPON_PISTOL_MK2",
	"WEAPON_GUSENBERG",
	"WEAPON_PISTOL50",
	"WEAPON_HATCHET",
	"AMMO_PISTOL_MK2",
	"WEAPON_COMBATPISTOL",
	"WEAPON_COMBATPDW",
	"AMMO_COMBATPISTOL",
	"WEAPON_MACHINEPISTOL",
	"AMMO_MACHINEPISTOL",
	"WEAPON_SMG_MK2",
	"AMMO_SMG_MK2",
	"WEAPON_SMG",
	"AMMO_SMG",
	"WEAPON_ASSAULTSMG",
	"AMMO_ASSAULTSMG",
	"WEAPON_SAWNOFFSHOTGUN",
	"AMMO_SAWNOFFSHOTGUN",
	"WEAPON_PUMPSHOTGUN_MK2",
	"AMMO_PUMPSHOTGUN_MK2",
	"WEAPON_ASSAULTRIFLE_MK2",
	"AMMO_ASSAULTRIFLE_MK2",
	"WEAPON_SPECIALCARBINE_MK2",
	"AMMO_SPECIALCARBINE_MK2",
	"WEAPON_CARBINERIFLE",
	"AMMO_CARBINERIFLE",
	"WEAPON_SPECIALCARBINE",
	"AMMO_SPECIALCARBINE",
	"WEAPON_STUNGUN",
	"WEAPON_PETROLCAN",
	"AMMO_PETROLCAN",
}

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- PEGAR RG
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
local choice_pedirrg = {function(source,choice)
    local user_id = vRP.getUserId(source)
	local nplayer = vRPclient.getNearestPlayer(source,4)
	if user_id then
		if nplayer then
			local nuser_id = vRP.getUserId(nplayer)
			local identity = vRP.getUserIdentity(nuser_id)
			local carteira = vRP.getMoney(nuser_id)
			local trabalho = vRP.getUserGroupByType(nuser_id, "job") if (trabalho == nil or trabalho == "") or (trabalho == "Vendedor de Drogas" or trabalho == "Traficante de Tartartuga" or trabalho == "Hacker" or trabalho == "Cacador" or trabalho == "Clandestino") then trabalho = "Desempregado" end

			if vCLIENT.enviarIdentidade(source, true, identity.user_id, identity.nome,identity.sobrenome,identity.idade,identity.registro,identity.telefone,vRP.format(carteira),trabalho) then
				TriggerClientEvent("Notify",nplayer,"importante","O Policial esta checando seu documento.", 5)
				if vRP.request(source, "Deseja fechar a identidade do individuo?", 120) then
					vCLIENT._enviarIdentidade(source, false) else vCLIENT.enviarIdentidade(source, false)
				end
            end
        else
            TriggerClientEvent("Notify",source,"negado","Nenhum jogador proximo.", 5)
		end
	end
end}

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- SISTEMA DE PRISAO
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
local tempoPrisao = {}

local choice_prisao = {function(source,choice)
    local user_id = vRP.getUserId(source)
	if user_id then
		local nplayer = vRPclient.getNearestPlayer(source, 2)
		if nplayer then
			local nuser_id = vRP.getUserId(nplayer)
			local tempo = vRP.prompt(source, "Digite o tempo da prisao: ", "")
			if tempo ~= nil and tempo ~= "" and tonumber(tempo) then
				if tonumber(tempo) > 180 then tempo = 180 end
				if tonumber(tempo) < 1 then tempo = 1 end
				local motivo = vRP.prompt(source, "Digite o motivo:", "")
				if motivo ~= nil and motivo ~= "" then
					local multas = vRP.prompt(source, "Digite o valor em multas: ", "")
					if multas ~= nil and multas ~= "" and tonumber(multas) then
						if tonumber(multas) >= 200000 then multas = 200000 end
						if tonumber(multas) >= 0 then multas = 0 end

						tempoPrisao[nuser_id] = tempo

						TriggerClientEvent("Notify",nplayer, "importante","Você esta sendo levado para prisao, caso deslogar/crashar sera adicionado +10min em sua pena.", 5)

						TriggerClientEvent("Notify",nplayer,"importante","Você foi preso/multado no valor de <b>$ "..vRP.format(multas).."</b> pelo motivo <b>"..motivo.."</b>", 5)
						vRP.execute("vRP/add_multa",{ user_id = nuser_id, multas = tonumber(multas) })

						src.adicionarCriminal(nuser_id, "PRISAO", motivo)
						src.setarPrisioneiro(nuser_id)
						vCLIENT._levarPrisioneiro(nplayer, tempo)
						exports["vrp"]:setBlockCommand(nuser_id, 800)

						vRP.clearInventory(nuser_id)
						TriggerClientEvent("Notify",nplayer, "importante","Os guardas apreenderam seus itens.", 5)


						vRP.sendLog("PRENDER", "O Policial "..user_id.." prendeu o ID "..nuser_id.. " por "..tempo.." mes(s) pelo motivo de "..motivo.. " e aplico $"..vRP.format(multas).." em multas.")
					end
				end
			end
		else
			TriggerClientEvent("Notify",source,"negado","Nenhum jogador proximo.", 5)
		end
	end
end}

function src.setarPrisioneiro(user_id)
	local source = vRP.getUserSource(user_id)
	if user_id then
		vRP.setHunger(user_id,0)
		vRP.setThirst(user_id,0)
		vRPclient._setHealth(source, 300)
		vRPclient._setHandcuffed(source,true)
		vRP.clearInventory(user_id)

		vRPclient._giveWeapons(source, {}, true)
		vCLIENT._updateWeapons(source)
		TriggerClientEvent("Notify",source,"negado","Seus Itens ilegais foram apreendidos.", 5)
	end
end

function src.colocarPrisao(time)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		time = time - 5

		if time <= 0 then
			time = 0
		end

		TriggerClientEvent('chatMessage', -1, 'PRISÃO', { 0, 0, 0 }, '^0 O ^3'.. GetPlayerName(source) ..' ^0 foi preso(a) e condenado(a) por ^3'.. time ..' ^0mes(s).')
		vRP.setUData(user_id,"vRP:prisao",json.encode(tonumber(time)))
		vCLIENT._prisioneiro(source, true)
		src.setarPrisioneiro(user_id)
		tempoPrisao[user_id] = nil
		vRPclient._setHandcuffed(source,false)
		prison_lock(parseInt(user_id))
	end
end

function prison_lock(user_id)
	local source = vRP.getUserSource(parseInt(user_id))
	if source then
		SetTimeout(60000, function()
			local value = vRP.getUData(parseInt(user_id), "vRP:prisao")
			local tempo = json.decode(value) or 0

			if parseInt(tempo) >= 1 then
				vRP.setUData(parseInt(user_id), "vRP:prisao", json.encode(parseInt(tempo)-1))
				vRPclient._setHealth(source, 300)
				TriggerClientEvent("Notify",source,"importante","Você ainda vai passar "..parseInt(tempo).." meses na prisão.", 5)
				prison_lock(parseInt(user_id))
			elseif parseInt(tempo) == 0 or parseInt(tempo) == -1 then
				vCLIENT._prisioneiro(source, false)
				vRP.setUData(parseInt(user_id), "vRP:prisao", json.encode(-1))
				TriggerClientEvent("Notify",source,"importante","Sua detenção acabou, esperamos não ve-lo novamente.", 5)
				vRPclient._teleport(source, 1847.94,2586.04,45.68)
			end

		end)
	end
end

function prison_soltar(user_id)
	local source = vRP.getUserSource(parseInt(user_id))
	if source then
		--SetTimeout(60000,function()
			local value = vRP.getUData(parseInt(user_id), "vRP:prisao")
			local tempo = json.decode(value) or 0
			if parseInt(tempo) >= 0 then
				vCLIENT.prisioneiro(source, false)
				vRP.setUData(parseInt(user_id), "vRP:prisao", json.encode(-1))
				TriggerClientEvent("Notify",source,"importante","Sua detenção acabou, esperamos não ve-lo novamente.", 5)
				vRPclient._teleport(source, 1847.94,2586.04,45.68)
				vRP.carregarConta(user_id, false)
				vRPclient._addPrisioneiro(source, false)
			end
		--end)
	end
end

RegisterCommand('prenderpm',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"admin.permissao") or vRP.hasPermission(user_id,"developer.permissao") then
	local idPlayer = vRP.prompt(source, "Digite o ID:", "")
		if tonumber(idPlayer) then
			local nplayer = vRP.getUserSource(tonumber(idPlayer))
			if nplayer then
				local motivoPrisao = vRP.prompt(source, "Digite o motivo da soltura", "")
				if motivoPrisao ~= nil and motivoPrisao ~= "" then
					local nidentity = vRP.getUserIdentity(tonumber(idPlayer))
					if nidentity then
						prison_soltar(tonumber(idPlayer))
						vRP.sendLog("PRENDERADM", "O ADMIN "..user_id.." SOLTOU O ID: "..idPlayer.."PELO MOTIVO: "..motivoPrisao)
					end
				else
					TriggerClientEvent('chatMessage', source, '^2Digite o Motivo Corretamente.')
				end
			else
				local motivoPrisao = vRP.prompt(source, "Digite o motivo da soltura", "")
				if motivoPrisao ~= nil and motivoPrisao ~= "" then
					TriggerClientEvent('chatMessage', source, '** Jogador Offline ** ^2 Você soltou '..idPlayer..' por '..motivoPrisao..'!')
					vRP.setUData(tonumber(idPlayer),"vRP:prisao", json.encode(-1))
					vRP.sendLog("PRENDERADM", "O ADMIN "..user_id.." SOLTOU O ID: "..idPlayer.."PELO MOTIVO: "..motivoPrisao)
				end
			end
		else
			TriggerClientEvent('chatMessage', source, '^2Digite o ID Do player Corretamente.')
		end
	end
end)

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- ALGEMAR
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
local choice_algemar = {function(source,choice)
    local user_id = vRP.getUserId(source)
	if user_id ~= nil then
		local nplayer = vRPclient.getNearestPlayer(source,3)
		if nplayer then
			if not vCLIENT.checkAnim(nplayer) and not vRP.hasPermission(user_id, "admin.permissao") then
				TriggerClientEvent("Notify",source,"importante","O jogador não está rendido.", 5)
				return
			end
			
			if vRP.getInventoryItemAmount(user_id, "algemas") >= 1 or vRP.hasPermission(user_id, "perm.policiacivil") or vRP.hasPermission(user_id, "perm.policia") or vRP.hasPermission(user_id, "admin.permissao") or vRP.hasPermission(user_id, "moderador.permissao") or vRP.hasPermission(user_id,"suporte.permissao") then
				if vRPclient._isHandcuffed(nplayer) then
					TriggerClientEvent("vrp_sound:source",source,'uncuff',0.4)
					TriggerClientEvent("vrp_sound:source",nplayer,'uncuff',0.4)
					vRPclient._setHandcuffed(nplayer, false)
				else
					vCLIENT.arrastar(nplayer,source)
					vRPclient._playAnim(source,false,{{"mp_arrest_paired","cop_p2_back_left"}},false)
					vRPclient._playAnim(nplayer,false,{{"mp_arrest_paired","crook_p2_back_left"}},false)
					SetTimeout(3500,function()
						vRPclient._stopAnim(source,false)
						vRPclient._toggleHandcuff(nplayer)
						vCLIENT._arrastar(nplayer,source)
						TriggerClientEvent("vrp_sound:source",source,'cuff',0.1)
						TriggerClientEvent("vrp_sound:source",nplayer,'cuff',0.1)
						vRPclient._setHandcuffed(nplayer, true)
					end)
				end
			end
		end
	end
end} 


function src.algemar()
	local source = source
    local user_id = vRP.getUserId(source)
	if user_id ~= nil then		
		if vRP.getInventoryItemAmount(user_id, "algemas") >= 1 or vRP.hasPermission(user_id, "perm.policiacivil") or vRP.hasPermission(user_id, "perm.policia") or vRP.hasPermission(user_id, "admin.permissao") or vRP.hasPermission(user_id, "moderador.permissao") or vRP.hasPermission(user_id," suporte.permissao") then
			local nplayer = vRPclient.getNearestPlayer(source,3)
			if nplayer then
				--[[ if not vRP.hasPermission(user_id, "perm.policiacivil") then
					if not vRP.hasPermission(user_id, "admin.permissao") and not vRP.hasPermission(user_id, "perm.policia") then
						if not vCLIENT.checkAnim(nplayer) and not vRPclient.isHandcuffed(nplayer) then
							TriggerClientEvent("Notify",source,"importante","O jogador não está rendido.", 5)
							return
						end
					end
				end ]]

				if not vCLIENT.checkAnim(nplayer) and not vRP.hasPermission(user_id, "perm.algemar") then
					TriggerClientEvent("Notify",source,"importante","O jogador não está rendido.", 5)
					return
				end

				if not vRPclient.isInVehicle(nplayer) then
					if vRPclient.isHandcuffed(nplayer) then
						TriggerClientEvent("vrp_sound:source",source,'uncuff',0.4)
						TriggerClientEvent("vrp_sound:source",nplayer,'uncuff',0.4)
						vRPclient._setHandcuffed(nplayer, false)
					else
						vCLIENT._arrastar(nplayer,source)
						vRPclient._playAnim(source,false,{{"mp_arrest_paired","cop_p2_back_left"}},false)
						vRPclient._playAnim(nplayer,false,{{"mp_arrest_paired","crook_p2_back_left"}},false)
						SetTimeout(3500,function()
							vRPclient._stopAnim(source,false)
							vRPclient._toggleHandcuff(nplayer)
							vCLIENT._arrastar(nplayer,source)
							TriggerClientEvent("vrp_sound:source",source,'cuff',0.1)
							TriggerClientEvent("vrp_sound:source",nplayer,'cuff',0.1)
							vRPclient._setHandcuffed(nplayer, true)
						end)
					end
				end
			end
		end
	end
end

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- RETIRAR MASCARA
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
local choice_rmascara = {function(source,choice)
    local user_id = vRP.getUserId(source)
	if user_id ~= nil then
		local nplayer = vRPclient.getNearestPlayer(source,3)
		if nplayer then
			vCLIENT._retirarMascara(nplayer)
		else
			TriggerClientEvent("Notify",source,"negado","Nenhum jogador proximo.", 5)
		end
	end
end} 

RegisterCommand('rmascara',function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"perm.policia") or vRP.hasPermission(user_id,"perm.unizk") then
		if user_id ~= nil then
			local nplayer = vRPclient.getNearestPlayer(source,3)
			if nplayer then
				vCLIENT._retirarMascara(nplayer)
			else
				TriggerClientEvent("Notify",source,"negado","Nenhum jogador proximo.", 5)
			end
		end
	end
end)

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- ARRASTAR
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
local choice_arrastar = {function(source,choice)
	local user_id = vRP.getUserId(source)
	if user_id ~= nil then
		local nplayer = vRPclient.getNearestPlayer(source,3)
		if nplayer then
			if vRP.hasPermission(user_id, "perm.policia") or vRP.hasPermission(user_id,"perm.unizk") or vRP.hasPermission(user_id,"perm.lidermecanica") then

				if vRP.hasPermission(user_id,"perm.unizk") and not vRP.checkPatrulhamento(user_id) then
					vCLIENT._arrastar(nplayer,source)
				elseif not vRP.checkPatrulhamento(user_id) then
					return
				end
			end
			
			vCLIENT._arrastar(nplayer,source)
		else
			TriggerClientEvent("Notify",source,"negado","Nenhum jogador proximo.", 5)
		end
	end
end}

function src.arrastar()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id ~= nil then
		if vRP.hasPermission(user_id, "perm.policia") or vRP.hasPermission(user_id,"perm.lidermecanica") or vRP.hasPermission(user_id, "perm.policiacivil") or vRP.hasPermission(user_id, "admin.permissao") or vRP.hasPermission(user_id, "moderador.permissao") or vRP.hasPermission(user_id,"suporte.permissao") or vRP.hasPermission(user_id,"perm.unizk") or vRP.hasPermission(user_id, "perm.policiacivil") then
			local nplayer = vRPclient.getNearestPlayer(source,3)
			if nplayer then
				vCLIENT._arrastar(nplayer,source)
			end
		end
	end
end


------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- COLOCAR NO VEICULO
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
local choice_colocarveh = {function(source,choice)
	local user_id = vRP.getUserId(source)
	local nplayer = vRPclient.getNearestPlayer(source,4)
	if user_id then
		if nplayer then
			if vRPclient.isHandcuffed(nplayer) then
				vRPclient._putInNearestVehicleAsPassenger(nplayer, 5)
				TriggerClientEvent("Notify",source,"sucesso","Voce colocou o cidadao no veiculo.", 5)
			else
				TriggerClientEvent("Notify",source,"negado","O Jogador não está algemado.", 5)
			end
		else
			TriggerClientEvent("Notify",source,"negado","Nenhum jogador proximo.", 5)
		end
	end
end}

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- RETIRAR DO VEICULO
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
local choive_retirarveh = {function(source,choice)
	local user_id = vRP.getUserId(source)
	local nplayer = vRPclient.getNearestPlayer(source,4)
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
end}

RegisterCommand('rv',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local nplayer = vRPclient.getNearestPlayer(source,4)
	if vRP.hasPermission(user_id,"perm.policia") or vRP.hasPermission(user_id,"perm.unizk")  or vRP.hasPermission(user_id,"admin.permissao") then 
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

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- APREENDER ITENS
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
local choice_apreenderitens = {function(source,choice)
	local user_id = vRP.getUserId(source)
	local nplayer = vRPclient.getNearestPlayer(source,4)
	local nuser_id = vRP.getUserId(nplayer)
	if user_id then
		if nplayer then
			for k,v in pairs(blackItens) do
				if vRP.getInventoryItemAmount(nuser_id, v) > 0 then
					vRP.tryGetInventoryItem(nuser_id, v, vRP.getInventoryItemAmount(nuser_id, v), true)
				end
			end

			vRPclient._giveWeapons(nplayer, {}, true)
			vCLIENT._updateWeapons(nplayer)

			TriggerClientEvent("Notify",nplayer,"negado","Seus Itens ilegais foram apreendidos.", 5)
			TriggerClientEvent("Notify",source,"sucesso","Você aprendeu os itens ilegais.", 5)
		else
			TriggerClientEvent("Notify",source,"negado","Nenhum jogador proximo.", 5)
		end
	end
end}

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- CONSULTAR VEICULO
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
local choice_consultarveh = {function(source,choice)
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
end}

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- APREENDER VEICULO
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
local choice_apv = {function(source,choice)
	local user_id = vRP.getUserId(source)
	if user_id then
		local mPlaca,mName,mNetVeh = vRPclient.ModelName(source, 5)
		local nuser_id = vRP.getUserByRegistration(mPlaca)
		local rows = vRP.query("vRP/get_veiculos_status", {user_id = nuser_id, veiculo = mName})

		if nuser_id then
			local identity = vRP.getUserIdentity(nuser_id)
			
			if identity then
				if #rows > 0 and rows[1] and rows[1].status == 0 then
					vRP.execute("vRP/set_status",{ user_id = nuser_id, veiculo = mName, status = 1})
					exports['bm_module']:deleteVehicle(source, vRPclient.getNearestVehicle(source, 5))
					
					TriggerClientEvent("Notify",source,"importante","<b> VEICULO APREENDIDO: </b> <br>• Veiculo: <b>"..mName.."</b><br>• Placa: <b>"..mPlaca.."</b><br>• Proprietario: <b>"..identity.nome.. " "..identity.sobrenome.. "</b> (<b>"..identity.idade.."</b>)<br>• Telefone: <b>"..identity.telefone.."</b> ", 15)
				else
					TriggerClientEvent("Notify",source,"importante","Este veiculo ja se encontra apreendido ", 5)
				end
			end

		end
	end
end}


RegisterCommand('detido',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"perm.policia") or vRP.hasPermission(user_id,"perm.unizk")  or vRP.hasPermission(user_id,"admin.permissao") then 
		local mPlaca,mName,mNetVeh = vRPclient.ModelName(source, 5)
		local nuser_id = vRP.getUserByRegistration(mPlaca)
		local rows = vRP.query("vRP/get_veiculos_status", {user_id = nuser_id, veiculo = mName})

		if nuser_id then
			local identity = vRP.getUserIdentity(nuser_id)
			
			if identity then
				if #rows > 0 and rows[1] and rows[1].status == 0 then
					vRP.execute("vRP/set_status",{ user_id = nuser_id, veiculo = mName, status = 1})
					exports['bm_module']:deleteVehicle(source, vRPclient.getNearestVehicle(source, 5))
					
					TriggerClientEvent("Notify",source,"importante","<b> VEICULO APREENDIDO: </b> <br>• Veiculo: <b>"..mName.."</b><br>• Placa: <b>"..mPlaca.."</b><br>• Proprietario: <b>"..identity.nome.. " "..identity.sobrenome.. "</b> (<b>"..identity.idade.."</b>)<br>• Telefone: <b>"..identity.telefone.."</b> ", 15)
				else
					TriggerClientEvent("Notify",source,"importante","Este veiculo ja se encontra apreendido ", 5)
				end
			end

		end
	end
end)
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- MULTAR
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
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
					src.adicionarCriminal(nuser_id, "MULTA", motivoMulta)
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

RegisterCommand('multar',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasPermission(user_id,"perm.unizk") then
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
						src.adicionarCriminal(nuser_id, "MULTA", motivoMulta)
					else
						TriggerClientEvent("Notify",source,"importante","Digite um motivo correto", 5)
					end
				else
					TriggerClientEvent("Notify",source,"importante","Digite um valor correto entre 1-500000 ", 5)
				end
			end
		end
	end
end)

RegisterCommand('limparficha',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"admin.permissao") then
		if user_id then
			local nuser_id = tonumber(args[1])
			if nuser_id ~= nil then
				local gCriminal = {}
				vRP.execute("vRP/add_criminal",{ user_id = nuser_id, criminal = json.encode(gCriminal) })
				TriggerClientEvent("Notify",source,"sucesso","Você limpo a ficha do (ID: "..nuser_id..") .", 5)
			end
		end
	end
end)

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- FICHA CRIMINAL
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function src.adicionarCriminal(user_id, tipo, criminal)
	local source = vRP.getUserSource(user_id)
	local cCriminal = vRP.query("vRP/get_user_identity",{ user_id = user_id })
	local gCriminal = json.decode(cCriminal[1].criminal) or nil
	if user_id then
	  gCriminal[os.time()] = {tipo = tipo, motivo = criminal}
	  vRP.execute("vRP/add_criminal",{ user_id = user_id, criminal = json.encode(gCriminal) })
	end
end

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- QTH
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('p', function(source,args)
	local source = source
	local user_id = vRP.getUserId(source)
	local plyCoords = GetEntityCoords(GetPlayerPed(source))
    local x,y,z = plyCoords[1],plyCoords[2],plyCoords[3]
	
	if user_id then
		if vRP.hasPermission(user_id, "perm.disparo") then
			local identity = vRP.getUserIdentity(user_id)
			exports['vrp']:alertPolice({ x = x, y = y, z = z, blipID = 304, blipColor = 3, blipScale = 0.7, time = 20, code = "911", title = "QTH", name = "QTH DE "..identity.nome.." "..identity.sobrenome.." ." })
		end
	end
end)

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- NOTIFICAO DE DISPARO
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function src.sendLocationFire(x,y,z)
	local source = source
	local user_id = vRP.getUserId(source)
	local plyCoords = GetEntityCoords(GetPlayerPed(source))
    local x,y,z = plyCoords[1],plyCoords[2],plyCoords[3]
	
	if user_id then
		if not vRP.hasPermission(user_id, "perm.disparo") then
			exports['vrp']:alertPolice({ x = x, y = y, z = z, blipID = 161, blipColor = 63, blipScale = 0.5, time = 10, code = "911", title = "QRU Disparos", name = "Um novo registro de disparos foi registrado." })
		end
	end
end

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- SISTEMA DE REDUZIR PENA
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function src.reduzirPrisao(reduzir)
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
        local value = vRP.getUData(parseInt(user_id), "vRP:prisao")
        local tempo = json.decode(value) or 0
        if tempo > 0 then
            vRP.setUData(user_id,"vRP:prisao", json.encode(tonumber(tempo-reduzir)))
            TriggerClientEvent("Notify",source,"sucesso","Parabens! Você acabou de reduzir <b>"..reduzir.." mes(es)</b> de sua prisão, agora restam <b>"..tempo-reduzir.."</b> meses.", 5)
        end
    end
end

function src.checkTempoPrisao()
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
        local value = vRP.getUData(parseInt(user_id), "vRP:prisao")
        local tempo = json.decode(value) or 0
        return tonumber(tempo)
    end
end

function src.blockCommands(tempo)
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
        exports["vrp"]:setBlockCommand(user_id, tempo)
    end
end

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Sistema de ficha criminal
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function src.infoUser(user)
	local source = source 
	if user then
		local identity = vRP.getUserIdentity(parseInt(user))
		local infos = vRP.query("vRP/get_user_identity",{ user_id = user })
		local criminal = json.decode(infos[1].criminal)
		local prisoes = 0
		local avisos = 0

		for k,v in pairs(criminal) do 
			if v.tipo == "PRISAO" then
				prisoes = prisoes + 1
			end

			if v.tipo == "MULTA" then
				avisos = avisos + 1
			end
		end


		if identity then
			return infos[1].multas,identity.nome,identity.sobrenome,identity.registro,parseInt(identity.idade),prisoes,avisos
		end
	end
end

function src.arrestsUser(user)
	local source = source
	if user then
		local infos = vRP.query("vRP/get_user_identity",{ user_id = user })
		local criminal = json.decode(infos[1].criminal)
		local arrest = {}
		if infos then
			for k,v in pairs(criminal) do
				if v.tipo == "PRISAO" then
					table.insert(arrest,{ data = os.date("%d/%m/%Y", k), value = 0, info = v.motivo, officer = "Policia SX" })
				end
			end
			return arrest
		end
	end 
end

function src.ticketsUser(user)
	local source = source
	if user then
		local infos = vRP.query("vRP/get_user_identity",{ user_id = user })
		local criminal = json.decode(infos[1].criminal)
		local ticket = {}
		if infos then
			for k,v in pairs(criminal) do
				if v.tipo == "MULTA" then
					table.insert(ticket,{ data = os.date("%d/%m/%Y", k), value = 0, info = v.motivo, officer = "Policia SX" })
				end
			end
			return ticket
		end
	end
end

function src.warningsUser(user)
	local source = source
	if user then
		local warning = {}
		table.insert(warning,{ data = "Em Breve", value = "0", info = "Em Breve", officer = "Em Breve" })
		return warning
	end
end

function src.checkPermission()
	local source = source
	local user_id = vRP.getUserId(source)
	return vRP.hasPermission(user_id,"perm.policia")
end

RegisterCommand('soltarh', function(source,args)
	local user_id = vRP.getUserId(source)
	local nplayer = vRPclient.getNearestPlayer(source,2)
	if user_id and nplayer then
		if vRP.hasPermission(user_id, "admin.permissao") then
			vCLIENT._arrastar(source,nplayer)
		end
	end
end)

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- MENU
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
vRP._registerMenuBuilder("police_menu", function(add, data)
	local user_id = vRP.getUserId(data.player)
	if user_id then
		local choices = {}
        choices["01. Pedir RG"] = choice_pedirrg
        choices["02. Algemar"] = choice_algemar
        choices["03. Arrastar"] = choice_arrastar
		choices["04. Prender"] = choice_prisao
		choices["05. Colocar Veiculo"] = choice_colocarveh
        choices["06. Retirar Veiculo"] = choive_retirarveh
		choices["07. Apreender Itens"] = choice_apreenderitens
		choices["08. Consultar Veiculo"] = choice_consultarveh
        choices["09. Apreender Veiculo"] = choice_apv
		choices["10. Multar"] = choice_multar
		choices["11. Retirar Mascara"] = choice_rmascara
		add(choices)
	end
end)

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- OUTROS
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("vRP:playerSpawn",function(user_id, source, first_spawn)
	if user_id then
		local value = vRP.getUData(parseInt(user_id), "vRP:prisao")
		local tempo = json.decode(value)
		if tempo then
			if tempo == nil then tempo = 0 end

			if parseInt(tempo) > 0 then
				vRPclient._teport(source, 1679.09,2514.52,45.57)
				prison_lock(parseInt(user_id))
				vCLIENT._prisioneiro(source, true)
				-- vCLIENT.setarRoupasPrisional(source)
			end
		end
	end
end)

AddEventHandler("vRP:playerLeave",function(user_id, player)
	if user_id then
		if tempoPrisao[user_id] ~= nil then
			TriggerClientEvent('chatMessage', -1, 'PRISÃO', { 0, 0, 0 }, '^0 O ^3'.. GetPlayerName(player) ..' ^0 tentou escapar do transporte para a prisao e foi pego.')
			vRP.setUData(user_id,"vRP:prisao",json.encode(tonumber(tempoPrisao[user_id]+10)))
			tempoPrisao[user_id] = nil
		end
	end
end)