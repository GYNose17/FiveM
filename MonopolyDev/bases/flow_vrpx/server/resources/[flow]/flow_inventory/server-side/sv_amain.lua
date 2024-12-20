local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
local Tools = module("vrp","lib/Tools")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

src = {}
Tunnel.bindInterface("flow_inventory",src)
Proxy.addInterface("flow_inventory",src)

vCLIENT = Tunnel.getInterface("flow_inventory")

local arena = Tunnel.getInterface("flow_arena")
local func = exports["vrp"]
local delayGarmas = {}

-------------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local idgens = Tools.newIDGenerator()
local allItems = {}

local weebhook = {
	vehicles = {}
}

--CLASSES DAS ARMAS--
local classWeapons = {
    ["WEAPON_SNSPISTOL_MK2"] = "PISTOLAS",
    ["WEAPON_PISTOL_MK2"] = "PISTOLAS",
    ["WEAPON_COMBATPISTOL"] = "PISTOLAS",
    ["WEAPON_HEAVYPISTOL"] = "PISTOLAS",
    ["WEAPON_PISTOL50"] = "PISTOLAS",
    ["WEAPON_GUSENBERG"] = "SEMI-RIFLE",
    ["WEAPON_MACHINEPISTOL"] = "SEMI-RIFLE",
    ["WEAPON_SMG_MK2"] = "SEMI-RIFLE",
    ["WEAPON_SMG"] = "SEMI-RIFLE",
    ["WEAPON_ASSAULTSMG"] = "SEMI-RIFLE",
	["WEAPON_COMBATPDW"] = "SEMI-RIFLE",
    ["WEAPON_SAWNOFFSHOTGUN"] = "SHOTGUN",
    ["WEAPON_PUMPSHOTGUN_MK2"] = "SHOTGUN",
    ["WEAPON_ASSAULTRIFLE"] = "RIFLE",
	["WEAPON_COMBATMG_MK2"] = "RIFLE",
    ["WEAPON_ASSAULTRIFLE_MK2"] = "RIFLE",
    ["WEAPON_SPECIALCARBINE_MK2"] = "RIFLE",
    ["WEAPON_CARBINERIFLE"] = "RIFLE",
    ["WEAPON_SPECIALCARBINE"] = "RIFLE",
    ["WEAPON_STUNGUN"] = "STUNGUN",
    
}

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- SISTEMA DE INVENTARIO PERSONAL
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
local droplist = {}
local dropCooldown = {}

function src.Mochila()
	local source = source
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)

	if user_id then
		
		local inv = vRP.getInventory(user_id)
		local amountMoc = vRP.getMochilaAmount(user_id)
		if inv then 
			local inventory = {}
 
			for k,v in pairs(inv) do
				if allItems[v.item] then
					if (parseInt(v["amount"]) <= 0 or allItems[v.item] == nil) then
						vRP.removeInventoryItem(user_id,v.item,parseInt(v["amount"]))
					else
						v["amount"] = parseInt(v["amount"])
						v["name"] = allItems[v["item"]].name
						v["peso"] = allItems[v["item"]].weight
						v["index"] = allItems[v["item"]].tipo
						v["key"] = v["item"]
						v["slot"] = k
						inventory[k] = v
					end
				end
			end
			
			local org = vRP.getUserGroupByType(user_id,"org")
			if org == nil or org == "" then org = "Nenhum(a)" end

			return inventory,vRP.computeInvWeight(user_id),vRP.getInventoryMaxWeight(user_id), { identity["nome"].." "..identity["sobrenome"],user_id,identity["telefone"],identity["registro"], org }, amountMoc
		end
	end
end

function src.useItem(slot, amount)
    local source = source
    local user_id = vRP.getUserId(source)

    if user_id then
        local inv = vRP.getInventory(user_id)
        if inv then
            if not inv[tostring(slot)] or inv[tostring(slot)].item == nil then
                return
            end

            local item = inv[tostring(slot)].item
            local itemType = vRP.getItemType(item)
            if itemType then
				local status,time = func:getCooldown(user_id, "inventario")
                if status then
					if amount == nil or amount <= 0 then
						amount = vRP.getInventoryItemAmount(user_id, item)
					end
					
                        if itemType == "usar" then 
							func:setCooldown(user_id, "inventario", 2)
							
                            if item == "mochila" then
                                local maxMochila = {}
								maxMochila[user_id] = 3

                                if tonumber(maxMochila[user_id]) > tonumber(vRP.getMochilaAmount(user_id)) then
                                    if vRP.tryGetInventoryItem(user_id, item, 1, true, slot) then
                                        vRP.addMochila(user_id)
                                        TriggerClientEvent( "Notify", source, "importante", "Você equipou a mochila, limite maximo de <b>(" .. vRP.getMochilaAmount(user_id) .. "/" .. maxMochila[user_id] .. ")</b> mochilas.", 6000 )
                                    end
                                else
                                    TriggerClientEvent( "Notify", source, "negado", "Você ja antigiu o limite maximo de <b>(" .. maxMochila[user_id] .. ")</b> mochilas.", 6000 )
                                end

                            elseif item == "scubagear" then
                                if not vCLIENT.checkScuba(source) then
                                    if vRP.tryGetInventoryItem(user_id, item, 1, true, slot) then
                                        vCLIENT._setScuba(source, true)
                                    end
                                else
                                    TriggerClientEvent( "Notify", source, "negado", "Você ja possui uma scuba equipada, para retira-la /rscuba", 6000 )
                                end

							elseif item == "capuz" then
								if vRP.tryGetInventoryItem(user_id, item, 1, true, slot) then
									local nplayer = vRPclient.getNearestPlayer(source, 5)
									if nplayer then
										local nuser_id = vRP.getUserId(nplayer)

										if vRPclient.isCapuz(nplayer) then
											vRPclient._setCapuz(nplayer, false)
											TriggerClientEvent( "Notify", source, "sucesso", "Você retirou o capuz desse jogador.", 6000 )
										else
											vRPclient._setCapuz(nplayer, true)
											TriggerClientEvent( "Notify", source, "sucesso", "Você colocou o capuz nesse jogador, para retirar use o item novamente.", 6000 )
										end

										vRP.sendLog("", "O USER_ID: "..user_id.. " Usou o Capuz no USER_ID: "..nuser_id)
									else
										TriggerClientEvent( "Notify", source, "negado", "Nenhum jogador proximo.", 6000 )
									end
								end
								
                            elseif item == "emptybottle" then
                                local status, style = vCLIENT.checkFountain(source)
                                if status then
                                    if vRP.tryGetInventoryItem(user_id, item, 1, true, slot) then
                                        if style == "fountain" then
                                            vCLIENT._closeInventory(source)
                                            vRPclient._playAnim( source, false, {{"amb@prop_human_parking_meter@female@idle_a", "idle_a_female"}}, true )
                                        elseif style == "floor" then
                                            vCLIENT._closeInventory(source)
                                            vRPclient._playAnim( source, false, {{"amb@world_human_bum_wash@male@high@base", "base"}}, true )
                                        end

                                        TriggerClientEvent("progress", source, 10)
                                        exports["vrp"]:setBlockCommand(user_id, 10)
                                        SetTimeout( 10000, function() vRP.giveInventoryItem(user_id, "water", 1, true) vRPclient._stopAnim(source, false) vCLIENT._updateInventory(source, "updateMochila") end )
                                    end
                                end
                            elseif item == "maconha" or item == "cocaina" or item == "lsd" or item == "heroina" or item == "metanfetamina" or item == "lancaperfume" or item == "balinha" then
								if not vCLIENT.isInDrug(source) then
									if vRP.tryGetInventoryItem(user_id, item, 1, true, slot) then
										vRPclient._playAnim( source, true, {{"mp_player_int_uppersmoke", "mp_player_int_smoke"}}, true )

										SetTimeout(2000,function() vRPclient._stopAnim(source, false) TriggerClientEvent("inventory:useDrugs", source, item) end)
									end
								else
									TriggerClientEvent( "Notify", source, "negado", "Você ja está sobre um efeito de uma droga..", 6000 )
								end
							elseif item == "attachs" then
                                if vRP.tryGetInventoryItem(user_id, item, 1, true, slot) then
									TriggerClientEvent("Weapon:Attachs", source)
                                end
							elseif item == "body_armor" then
								if vRP.tryGetInventoryItem(user_id,item,1, true,slot) then
									vRPclient.setArmour(source,100)
									TriggerClientEvent('coletebalistico',source)
									vCLIENT.closeInventory(source)
								end	

                            elseif item == "lockpick" then
								
                                local plate,mName,mNet,mPortaMalas,mPrice,mLock,mModel = vRPclient.ModelName(source, 7)
                                local plateUser = vRP.getUserByRegistration(plate)
								
                                local plyCoords = GetEntityCoords(GetPlayerPed(source))
            					local x,y,z = plyCoords[1],plyCoords[2],plyCoords[3]

                                if plateUser then
                                    if mLock then
                                        vCLIENT._closeInventory(source)

                                        Wait(1000)
                                        vCLIENT._startAnimHotwired(source)
                                        if vRP.tryGetInventoryItem(user_id, "lockpick", 1, true, slot) then
                                            local finished = vRPclient.taskBar(source, 2500, math.random(7, 15))
                                            if finished then
                                                local finished = vRPclient.taskBar(source, 1500, math.random(7, 15))
                                                if finished then
                                                    local finished = vRPclient.taskBar(source, 1000, math.random(7, 15))
                                                    if finished then
														local entity = NetworkGetEntityFromNetworkId(mNet)
														if entity then
															SetVehicleDoorsLocked(entity,1)
														end

                                                        TriggerClientEvent("vrp_sound:source", source, "lock", 0.1)
                                                        TriggerClientEvent( "Notify", source, "negado", "Você destrancou o veiculo, cuidado a policia foi acionada.", 6000 )
														vRP.sendLog("LOCKPICK", "**SUCESSO** O [ID: " .. user_id .. "] Roubou o veiculo " .. mModel .. "(ID:" .. plateUser .. ") nas nas cordenadas: " .. x .. "," .. y .. "," .. z )
                                                    end
                                                end
                                            end

											exports['vrp']:alertPolice({ x = x, y = y, z = z, blipID = 161, blipColor = 63, blipScale = 0.5, time = 20, code = "911", title = "Veiculo Roubado (" .. mModel .. ")", name = "Um novo registro de tentativa de roubo de veiculo, Modelo: " .. mModel .. " Placa: " .. plate .. ". "})
                                            vRPclient._stopAnim(source, false)
                                            vCLIENT._updateInventory(source, "updateMochila")
                                        end
                                    else
                                        TriggerClientEvent( "Notify", source, "negado", "Este veiculo ja esta destracando.", 6000 )
                                    end
                                else
                                    TriggerClientEvent( "Notify", source, "negado", "Este veiculo não pode ser roubado.", 6000 )
                                end
                            elseif item == "repairkit2" then
                                if not vRPclient.isInVehicle(source) then
                                    local vehicle = vRPclient.getNearestVehicle(source, 7)
									if vRP.tryGetInventoryItem(user_id, "repairkit2", 1, true, slot) or vRP.hasPermission(user_id, "perm.bennys") then
										vRPclient._playAnim( source, false, {{"mini@repair", "fixing_a_player"}}, true )
										TriggerClientEvent("progress", source, 30)
										exports["vrp"]:setBlockCommand(user_id, 35)
										SetTimeout(30000,function()
											TriggerClientEvent("reparar", source, vehicle)
											vRPclient._stopAnim(source, false)
											TriggerClientEvent( "Notify", source, "sucesso", "Você reparou o veiculo.", 6000 )
										end)
									end
                                else
                                    TriggerClientEvent( "Notify", source, "negado", "Precisa estar próximo ou fora do veículo para efetuar os reparos.", 6000 )
                                end

							elseif item == "pneus" then
                                if not vRPclient.isInVehicle(source) then
                                    local vehicle = vRPclient.getNearestVehicle(source, 7)
									if vRP.tryGetInventoryItem(user_id, "pneus", 1, true, slot) then
										vRPclient._playAnim(source,false,{{"anim@amb@clubhouse@tutorial@bkr_tut_ig3@","machinic_loop_mechandplayer"}},true)
										TriggerClientEvent("progress", source, 30)
										exports["vrp"]:setBlockCommand(user_id, 15)
										SetTimeout(10000,function()
												TriggerClientEvent('repararpneus',source,vehicle)
												vRPclient._stopAnim(source, false)
												TriggerClientEvent( "Notify", source, "sucesso", "Você reparou o pneu do veiculo.", 6000 )
											end)
									end
                                else
                                    TriggerClientEvent( "Notify", source, "negado", "Precisa estar próximo ou fora do veículo para efetuar os reparos.", 6000 )
                                end

								
                            elseif item == "algemas" then
                                local nplayer = vRPclient.getNearestPlayer(source, 3)
                                if nplayer then
									if not vCLIENT.checkAnim(nplayer) then
										TriggerClientEvent("Notify",source,"importante","O jogador não está rendido.", 5)
										return
									end

                                    if not vRPclient.isHandcuffed(nplayer) then
                                        if vRP.tryGetInventoryItem(user_id, "algemas", 1, true, slot) then
                                            vRP.giveInventoryItem(user_id, "chave_algemas", 1, true)
                                            vCLIENT._arrastar(nplayer, source)
                                            vRPclient._playAnim( source, false, {{"mp_arrest_paired", "cop_p2_back_left"}}, false )
                                            vRPclient._playAnim( nplayer, false, {{"mp_arrest_paired", "crook_p2_back_left"}}, false )
                                            SetTimeout(3500,function()
                                                    vRPclient._stopAnim(source, false)
                                                    vRPclient._toggleHandcuff(nplayer)
                                                    vCLIENT._arrastar(nplayer, source)
                                                    TriggerClientEvent("vrp_sound:source", source, "cuff", 0.1)
                                                    TriggerClientEvent("vrp_sound:source", nplayer, "cuff", 0.1)
                                                    vRPclient._setHandcuffed(nplayer, true)
                                                end)
                                        else
                                            TriggerClientEvent( "Notify", source, "negado", "Você não possui algemas.", 6000 )
                                        end
                                    end
                                else
                                    TriggerClientEvent("Notify", source, "negado", "Nenhum jogador proximo.", 5)
                                end
                            elseif item == "chave_algemas" then
                                local nplayer = vRPclient.getNearestPlayer(source, 3)
                                if nplayer then
                                    if vRPclient.isHandcuffed(source) then
                                        if vRP.tryGetInventoryItem(user_id, "chave_algemas", 1, true, slot) then
                                            vRP.giveInventoryItem(user_id, "algemas", 1, true)
                                            TriggerClientEvent("vrp_sound:source", source, "uncuff", 0.4)
                                            TriggerClientEvent("vrp_sound:source", nplayer, "uncuff", 0.4)
                                            vRPclient._setHandcuffed(nplayer, false)
                                        else
                                            TriggerClientEvent( "Notify", source, "negado", "Você não possui chave de algemas.", 6000 )
                                        end
                                    end
                                else
                                    TriggerClientEvent("Notify", source, "negado", "Nenhum jogador proximo.", 5)
                                end
                            end
                        end

						if itemType == "usarVIP" then
							if item == "alterarplaca" then
								local vehicle = vRPclient.getNearestVehicle(source,4)
								local plate,mName,mNetVeh = vRPclient.ModelName(source, 4)
								local PlacaID = vRP.getUserByRegistration(plate)

								if tonumber(PlacaID) == tonumber(user_id) then
									if plate then
										vCLIENT._closeInventory(source)

										Wait(500)
										local placa = vRP.prompt(source, "Digite sua placa: (MAX 7) (EXEMPLO: THA0001)", "")
										if placa ~= nil and placa ~= "" and placa and string.len(placa) == 7 then
											if checkPlate(placa) then
												if vRP.request(source, "Tem certeza que deseja alterar a placa do seu veiculo para <b>"..placa.."</b> ?", 30) then
													if vRP.tryGetInventoryItem(user_id,item,1, true, slot) then
														exports['bm_module']:deleteVehicle(source, vehicle)
														vRP.execute("vRP/update_plate",{ user_id = user_id, veiculo = mName, placa = placa })
														vRP.updatePlate(placa, user_id)
														
														TriggerClientEvent("Notify",source,"sucesso","Você alterou a placa do seu veiculo para: <b> "..placa.." </b>.", 15)
													end
												end
											else
												TriggerClientEvent("Notify",source,"negado","Esta placa ja existe", 5)
											end
										else
											TriggerClientEvent("Notify",source,"negado","Digite a placa correta. (EXEMPLO: THA0001)", 5)
										end
									else
										TriggerClientEvent("Notify",source,"negado","Nenhum veiculo proximo.", 5)
									end
								else
									TriggerClientEvent("Notify",source,"negado","Este veiculo nao pertence a você", 5)
								end
							elseif item == "alterarrg" then
								vCLIENT._closeInventory(source)
								Wait(500)
								local numero = vRP.prompt(source, "Digite o numero: (MAX 6) (EXEMPLO: ABC123)", "")
								if numero ~= nil and numero ~= "" and numero and string.len(numero) == 6 then
									if checkRG(numero) then
										if vRP.request(source, "Tem certeza que deseja alterar seu rg para <b>"..numero.."</b> ?", 30) then
											if vRP.tryGetInventoryItem(user_id,item,1, true, slot) then
												vRP.updateIdentity(user_id)
												vRP.execute("vRP/update_registro",{ user_id = user_id, registro = numero })
												TriggerClientEvent("Notify",source,"sucesso","Você trocou o seu rg para <b>"..numero.."</b>, aguarde a cidade reiniciar para alteração ser feita.", 15)
											end
										end
									else
										TriggerClientEvent("Notify",source,"negado","Este rg ja existe.", 5)
									end
								else
									TriggerClientEvent("Notify",source,"negado","Digite o rg correto. (EXEMPLO: ABC123)", 5)
								end
							elseif item == "alterartelefone" then
								vCLIENT._closeInventory(source)
								Wait(500)
								local numero = vRP.prompt(source, "Digite o numero: (MAX 6) (EXEMPLO: 123456)", "")
								if tonumber(numero) ~= nil and numero ~= "" and tonumber(numero) and string.len(numero) == 6 then
									numero = formatNumber(numero)
									if checkNumber(numero) then
										if vRP.request(source, "Tem certeza que deseja alterar o numero de telefone para <b>"..numero.."</b> ?", 30) then
											if vRP.tryGetInventoryItem(user_id,item,1, true, slot) then
												vRP.execute("vRP/update_number",{ user_id = user_id, telefone = numero })
												TriggerClientEvent("Notify",source,"sucesso","Você trocou o numero de telefone para <b>"..numero.."</b>, aguarde a cidade reiniciar para alteração ser feita.", 15)
											end
										end
									else
										TriggerClientEvent("Notify",source,"negado","Este numero de telefone ja existe.", 5)
									end
								else
									TriggerClientEvent("Notify",source,"negado","Digite o numero de telefone correto. (EXEMPLO: 123456)", 5)
								end
							end
						end

						if itemType == "equipar" then
                            func:setCooldown(user_id, "inventario", 5)

                            local data = vRP.getUserDataTable(user_id)
                            local myWeapons = data.weapons
                            local blockWeapons = {}
                            local bloqueado = false

                            for k,v in pairs(myWeapons) do
                                local categoria = classWeapons[k]
                                if categoria ~= nil then
                                    blockWeapons[categoria] = true
                                end

                                local categoria2 = classWeapons[item]
                                if categoria2 ~= nil then
                                    if blockWeapons[categoria2] ~= nil then
                                        bloqueado = true
                                    end
                                end
                            end

                            if not bloqueado then
                                if vRP.tryGetInventoryItem(user_id,item,1, true, slot) then
									delayGarmas[user_id] = os.time()
									
                                    local weapons = {}
                                    weapons[item] = { ammo = 0 }
                                    vRPclient._giveWeapons(source,weapons)

                                    vCLIENT._updateWeapons(source)
                                    vRP.sendLog("EQUIPAR", "O ID "..user_id.." equipou a arma "..vRP.getItemName(item)..".")
                                end
                            else
                                TriggerClientEvent("Notify",source,"negado","Você ja possui uma arma dessa classe equipada!", 5)
                            end
                        end

						if itemType == "recarregar" then
							func:setCooldown(user_id, "inventario", 5)

							local weapon = string.gsub(item, "AMMO_","WEAPON_")
							local municao = vRPclient.getAmmo(source, weapon)
							local maxMunicao = 250
							if vRPclient.checkWeapon(source, weapon) then
								if municao < 250 then
									if maxMunicao <= amount then
										maxMunicao = maxMunicao - municao
										amount = maxMunicao
									else
										maxMunicao = maxMunicao - municao
										if amount > maxMunicao then
											amount = maxMunicao
										end
									end
				
									if vRP.tryGetInventoryItem(user_id, item, amount, true, slot) then
										local weapons = {}
										weapons[weapon] = { ammo = amount }
										vRPclient._giveWeapons(source,weapons,false)

										vRP.sendLog("EQUIPAR", "O ID "..user_id.." recarregou a municao "..vRP.getItemName(item).." na quantidade de "..amount.." x.")
									end
								else
									TriggerClientEvent("Notify",source,"negado","Sua <b>"..vRP.getItemName(weapon).."</b> ja esta com seu maximo de munição", 5)
								end
							else
								TriggerClientEvent("Notify",source,"negado","Você precisa estar com a <b>"..vRP.getItemName(weapon).."</b> na mão para recarregar.", 5)
							end
						end


						if itemType == "beber" then
							func:setCooldown(user_id, "inventario", 5)
 							local fome,sede = vRP.itemFood(item)

							if vRP.tryGetInventoryItem(user_id, item, 1, true, slot) then
								TriggerClientEvent("progress",source, 10*amount)
								play_drink(source, item, 10*amount)
								SetTimeout((10*amount)*1000, function()
									vRP.varyThirst(user_id, tonumber(sede)*amount)

								end)
							end
						end

						if itemType == "comer" then
							func:setCooldown(user_id, "inventario", 5)
							local fome,sede = vRP.itemFood(item)

							if vRP.tryGetInventoryItem(user_id, item, 1, true, slot) then
								TriggerClientEvent("progress",source, 10*amount)
								play_eat(source, item, 5*amount)
								SetTimeout((5*amount)*500, function() 
									vRP.varyHunger(user_id, tonumber(fome)*amount) 
								end)
							end
							
						end

						if itemType == "bebera" then
							local fome,sede = vRP.itemFood(item)
							func:setCooldown(user_id, "inventario", 10*amount)

							TriggerClientEvent("progress",source, 10*amount,"Bebendo")
							play_drink(source, item, 10*amount)
				
							if vRP.tryGetInventoryItem(user_id, item, 1, true, slot) then
								SetTimeout(15*1000, function()
									vRPclient._playScreenEffect(source, "RaceTurbo", 60*amount)
									vRPclient._playScreenEffect(source, "DrugsTrevorClownsFight", 60*amount)
									--vCLIENT._SetAnim(source, amount) comenta essa linha aqui
								end)
							end
						end

						if itemType == "remedio" then
							func:setCooldown(user_id, "inventario", 5)

							if item == "bandagem" then
								if vRP.tryGetInventoryItem(user_id, item, 1, true, slot) then
									vRPclient._CarregarObjeto(source,"amb@world_human_clipboard@male@idle_a","idle_c","v_ret_ta_firstaid",49,60309)

									TriggerClientEvent("progress",source, 15)
									SetTimeout(15*1000, function()
										vRPclient._DeletarObjeto(source)
										vCLIENT._useBandagem(source)
										TriggerClientEvent( "Notify", source, "importante", "Você utilizou a bandagem, não tome nenhum tipo de dano para não ser cancelada..", 6000 )
									end)
									
								end
							end
						end

                        vCLIENT._updateInventory(source, "updateMochila")
                else
                    TriggerClientEvent( "Notify", source, "negado", "Aguarde <b>" .. time .. " segundo(s)</b> para utilizar isso novamente.", 6000 )
                end
            end
        end
    end
end

function src.droparItem(slot,amount)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local status,time = func:getCooldown(user_id, "drop")

		if GetPlayerRoutingBucket(source) ~= 0 then
			TriggerClientEvent( "Notify", source, "negado", "Você não pode item agora.", 6000 )
			return
		end

		if status then
			func:setCooldown(user_id, "drop", 2)

			local inv = vRP.getInventory(user_id)
			if inv then
				if not inv[tostring(slot)] or inv[tostring(slot)].item == nil then
					return
				end

				local itemName = inv[tostring(slot)].item
				if vRP.tryGetInventoryItem(user_id,itemName, parseInt(amount), true, slot) then
					vRPclient._playAnim(source,true,{{"pickup_object","pickup_low"}},false)
					src.createDropItem(itemName,parseInt(amount),source)
					vCLIENT._updateInventory(source, "updateMochila")

					vRP.sendLog("DROPAR", "O ID "..user_id.." dropou o item "..vRP.getItemName(itemName).." na quantidade de "..amount.."x.")
				end
			end
		else
			TriggerClientEvent( "Notify", source, "negado", "Aguarde <b>" .. time .. " segundo(s)</b> para utilizar isso novamente.", 6000 )
		end
	end
end

function src.pegarItem(id,slot,amount)
	local source = source
    local user_id = vRP.getUserId(source)
	if user_id then
		local status,time = func:getCooldown(user_id, "pegar")
		if GetPlayerRoutingBucket(source) ~= 0 then
			TriggerClientEvent( "Notify", source, "negado", "Você não pode pegar item agora.", 6000 )
			return
		end

		if status then
			func:setCooldown(user_id, "pegar", 2)

			if droplist[id] == nil then
				return
			end
			
			if dropCooldown[id] then
				return
			end
			dropCooldown[id] = true

			if vRP.computeInvWeight(user_id)+vRP.getItemWeight(tostring(droplist[id].item))*parseInt(amount) <= vRP.getInventoryMaxWeight(user_id) then
				dropCache = droplist[id]

				if (droplist[id].count - amount) >= 1 then 
					vCLIENT._removeDrop(-1, id)
					
					local newamount = droplist[id].count - amount
					src.createDropItem(droplist[id].item, newamount, source)

					droplist[id] = nil
					idgens:free(id)
				else
					vCLIENT._removeDrop(-1, id)
					droplist[id] = nil
					idgens:free(id)
				end

				if tostring(dropCache.item) == "money" then
					vRP.giveInventoryItem(user_id,tostring(dropCache.item),parseInt(amount), true, vRP.getItemInSlot(user_id, "money", slot))
				else
					vRP.giveInventoryItem(user_id,tostring(dropCache.item),parseInt(amount), true, slot)
				end
				
				vRP.sendLog("1011262581341691935/18kKvuutYrVeqI6B35-NSDd3hm3wMo6AUGZUX1EH1qfDspQgQoXKWhpZ3KO8IhyAIkgy", "O ID "..user_id.." pegou o item do chão "..dropCache.item.." na quantidade de "..amount.."x.")
				vCLIENT._updateInventory(source, "updateMochila")
			else
				TriggerClientEvent( "Notify", source, "negado", "Mochila cheia.", 6000 )
			end

			dropCooldown[id] = nil
		else
			TriggerClientEvent( "Notify", source, "negado", "Aguarde <b>" .. time .. " segundo(s)</b> para utilizar isso novamente.", 6000 )
		end
	end
end

function src.sendItem(item,slot,amount)
	local source = source
    local user_id = vRP.getUserId(source)
	if user_id then
		local status,time = func:getCooldown(user_id, "enviar")
		if GetPlayerRoutingBucket(source) ~= 0 then
			TriggerClientEvent( "Notify", source, "negado", "Você não enviar item agora.", 6000 )
			return
		end

		if status then
			func:setCooldown(user_id, "enviar", 60)

			if amount == nil or amount <= 0 then
				amount = vRP.getInventoryItemAmount(user_id, item)
			end

			local nplayer = vRPclient.getNearestPlayer(source, 3)
			if nplayer then
				local nuser_id = vRP.getUserId(nplayer)
				if vRP.computeInvWeight(nuser_id)+vRP.getItemWeight(tostring(item))*parseInt(amount) <= vRP.getInventoryMaxWeight(nuser_id) then

					if item == "money" or item == "dirty_money" then

						if amount >= 15000000 then
							vRP.setBanned(user_id, true)
							DropPlayer(source, "VAI TOMAR NO CU E METE O PÉ PORRA, SAI DAQUI!")
							vRP.sendLog("ENVIAR", "@everyone | O ID "..user_id.." enviou o item "..vRP.getItemName(item).." na quantidade de "..amount.."x para o id "..nuser_id.." (SUSPEITO HACK)")
						elseif amount >= 500000 then
							if vRP.tryGetInventoryItem(user_id, item, parseInt(amount), true, slot) then 

								vRPclient._playAnim(source,true,{{"mp_common","givetake1_a"}},false)
								vRP.giveInventoryItem(nuser_id, item, parseInt(amount), true)
								vRPclient._playAnim(nplayer,true,{{"mp_common","givetake1_a"}},false)
								vRP.sendLog("ENVIAR", "@everyone | O ID "..user_id.." enviou o item "..vRP.getItemName(item).." na quantidade de "..amount.."x para o id "..nuser_id..".")
							end
						else
							if vRP.tryGetInventoryItem(user_id, item, parseInt(amount), true, slot) then 
								vRPclient._playAnim(source,true,{{"mp_common","givetake1_a"}},false)
								vRP.giveInventoryItem(nuser_id, item, parseInt(amount), true)
								vRPclient._playAnim(nplayer,true,{{"mp_common","givetake1_a"}},false)
								vRP.sendLog("ENVIAR", "O ID "..user_id.." enviou o item "..vRP.getItemName(item).." na quantidade de "..amount.."x para o id "..nuser_id..".")
							end
						end
						
					elseif item == "WEAPON_PISTOL_MK2" or item == "WEAPON_SPECIALCARBINE_MK2" or item == "WEAPON_ASSAULTRIFLE_MK2" then

							if amount >= 9 then
								if vRP.tryGetInventoryItem(user_id, item, parseInt(amount), true, slot) then 
	
								vRPclient._playAnim(source,true,{{"mp_common","givetake1_a"}},false)
								vRP.giveInventoryItem(nuser_id, item, parseInt(amount), true)
								vRPclient._playAnim(nplayer,true,{{"mp_common","givetake1_a"}},false)
								vRP.sendLog("ENVIAR", "@everyone | O ID "..user_id.." enviou o item "..vRP.getItemName(item).." na quantidade de "..amount.."x para o id "..nuser_id..".")
								end
							else
								if vRP.tryGetInventoryItem(user_id, item, parseInt(amount), true, slot) then 
									vRPclient._playAnim(source,true,{{"mp_common","givetake1_a"}},false)
									vRP.giveInventoryItem(nuser_id, item, parseInt(amount), true)
									vRPclient._playAnim(nplayer,true,{{"mp_common","givetake1_a"}},false)
									vRP.sendLog("ENVIAR", "O ID "..user_id.." enviou o item "..vRP.getItemName(item).." na quantidade de "..amount.."x para o id "..nuser_id..".")
								end
							end

					elseif vRP.tryGetInventoryItem(user_id, item, parseInt(amount), true, slot) then
						vRPclient._playAnim(source,true,{{"mp_common","givetake1_a"}},false)
						vRP.giveInventoryItem(nuser_id, item, parseInt(amount), true)
						vRPclient._playAnim(nplayer,true,{{"mp_common","givetake1_a"}},false)
						vRP.sendLog("ENVIAR", "O ID "..user_id.." enviou o item "..vRP.getItemName(item).." na quantidade de "..amount.."x para o id "..nuser_id..".")
					end


				else
					TriggerClientEvent( "Notify", source, "negado", "Mochila do jogador cheia.", 5)
				end 

				vCLIENT._updateInventory(nplayer, "updateMochila")
				vCLIENT._updateInventory(source, "updateMochila")
			else
				TriggerClientEvent( "Notify", source, "negado", "Nenhum jogador proximo.", 6000 )
			end
		else
			TriggerClientEvent( "Notify", source, "negado", "CALMA AI PO, ESPERE UM POUCO PARA ENVIAR OUTRO ITEM | TEMPO:"..time.."!", 6000 )
		end
	end
end

function src.updateSlot(itemName, slot, target, targetName, targetamount, amount)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local firstItemAmount = vRP.getInventoryItemAmount(user_id, itemName)

		if amount == nil or amount <= 0 then 
			amount = 1 
		end

		if targetamount == nil or targetamount <= 0 then 
			targetamount = 1
		end

		local inv = vRP.getInventory(user_id)
		if inv then
			if targetName ~= nil then
				if itemName ~= targetName then
					if vRP.tryGetInventoryItem(user_id, itemName, firstItemAmount, false, slot) then
						if vRP.tryGetInventoryItem(user_id, targetName, targetamount, false, target) then 
							vRP.giveInventoryItem(user_id, itemName, firstItemAmount, false, target)
							vRP.giveInventoryItem(user_id, targetName, targetamount, false, slot)
						end
					end
				else
					if vRP.tryGetInventoryItem(user_id, itemName, amount, false, slot) then
						vRP.giveInventoryItem(user_id, itemName, amount, false, target)
					end
				end
			else
				if vRP.tryGetInventoryItem(user_id, itemName, amount, false, slot) then
					vRP.giveInventoryItem(user_id, itemName, amount, false, target)
				end
			end
		end
	end
end

function src.checkPermission(permission)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasPermission(user_id, permission) then
			return true
		end
	end
end

function checkPlate(plate)
	local rows = vRP.query("vRP/getPlate", {placa = plate} ) or nil
	if not rows[1] then
		return true
	end
end

function checkNumber(numero)
	local rows = vRP.query("vRP/getNumber", {telefone = numero} ) or nil
	if not rows[1] then
		return true
	end
end

function checkRG(numero)
	local rows = vRP.query("vRP/getRegistro", {registro = numero} ) or nil
	if not rows[1] then
		return true
	end
end

function formatNumber(n)
	local left,num,right = string.match(n,'^([^%d]*%d)(%d*)(.-)$')
	return left..(num:reverse():gsub('(%d%d%d)','%1-'):reverse())..right
end

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- SISTEMA DE INVENTARIO DE VEICULOS
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
local openedVehicle = {}
local userVehicleOppened = {}
local dataVehicle = {}

function src.openVehicles(plate,name)
	plate = plate:gsub(" ", "")

	local source = source
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	local amountMoc = vRP.getMochilaAmount(user_id)

	if user_id then
		if plate and name then
			if openedVehicle[plate] == user_id then
				local inv = vRP.getInventory(user_id)
				local myInventory = {}
				if inv then
					for k,v in pairs(inv) do
						if allItems[v["item"]] then
							v["amount"] = parseInt(v["amount"])
							v["name"] = allItems[v["item"]].name
							v["peso"] = allItems[v["item"]].weight
							v["index"] = allItems[v["item"]].tipo
							v["key"] = v["item"]
							v["slot"] = k
							myInventory[k] = v
						end
					end
				end

				if dataVehicle[plate..":"..name] == nil then
					local nuser_id = vRP.getUserByRegistration(plate)
					if nuser_id then
						local rows = vRP.query("vRP/get_portaMalas",{ user_id = parseInt(nuser_id), veiculo = string.lower(name) }) or {}
						if #rows > 0 then
							local malas = json.decode(rows[1].portamalas) or {}
							dataVehicle[plate..":"..name] = { malas,name,plate,false }
						else
							local rows = vRP.getSData("tmpChest:"..name.."_"..plate)
							dataVehicle[plate..":"..name] = { json.decode(rows) or {}, name, plate,true }
						end
					else
						local rows = vRP.getSData("tmpChest:"..name.."_"..plate)
						dataVehicle[plate..":"..name] = { json.decode(rows) or {}, name, plate,true }
					end
				end

				local myVehicle = {}
				local weight = 0.0
				if dataVehicle[plate..":"..name] then
					for k,v in pairs(dataVehicle[plate..":"..name][1]) do
						if allItems[v["item"]] then
							myVehicle[k] = {
								["amount"] = parseInt(v["amount"]),
								["name"] = allItems[v["item"]].name,
								["peso"] = allItems[v["item"]].weight,
								["index"] = allItems[v["item"]].tipo,
								["key"] = v["item"],
								["slot"] = k
							}

							weight = weight + (allItems[v["item"]].weight*parseInt(v["amount"]))
						end
					end
				end

				if not weebhook.vehicles[user_id] then
					weebhook.vehicles[user_id] = ""
				end

				return myInventory,myVehicle,vRP.computeInvWeight(user_id),vRP.getInventoryMaxWeight(user_id),weight,vRP.getVehicleTrunk(name),{identity["nome"].." "..identity["sobrenome"],user_id}, { plate,vRP.getVehicleName(name) },amountMoc
			else
				vCLIENT._closeInventory(source)
			end
			
		end
	end
end

function src.colocarVehicle(item,amount,slot,plate,name)
	plate = plate:gsub(" ", "")
	
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id and plate then
		if GetPlayerPing(source) > 0 then
			if item == "money" then
				TriggerClientEvent( "Notify", source, "negado", "Você não pode fazer isso com esse item.", 6000 )
				return
			end

			if openedVehicle[plate] and openedVehicle[plate] == user_id and dataVehicle[plate..":"..name][1] ~= nil then
				if vRP.computeItemsWeight(dataVehicle[plate..":"..name][1])+vRP.getItemWeight(item)*parseInt(amount) <= vRP.getVehicleTrunk(name) then
					if vRP.tryGetInventoryItem(user_id, item, amount, true) then
						dataVehicle[plate..":"..name][1][tostring(slot)] =  { amount = amount, item = item }
						weebhook.vehicles[user_id] = weebhook.vehicles[user_id].. "\nCOLOCOU: "..vRP.getItemName(item).." "..amount.." x"
					end
				else
					TriggerClientEvent( "Notify", source, "negado", "Porta malas cheio.", 6000 )
				end
			else
				vCLIENT._closeInventory(source)
			end
		end
	end

end

function src.retirarVehicle(item,amount,slot,target,plate,name)
	plate = plate:gsub(" ", "")

	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if GetPlayerPing(source) > 0 then
			if plate then
				if openedVehicle[plate] and dataVehicle[plate..":"..name] and openedVehicle[plate] == user_id and dataVehicle[plate..":"..name][1][tostring(slot)].item ~= nil then
					if vRP.computeInvWeight(user_id)+vRP.getItemWeight(tostring(dataVehicle[plate..":"..name][1][tostring(slot)].item))*parseInt(amount) <= vRP.getInventoryMaxWeight(user_id) then
						if item == "money" then
							vRP.giveInventoryItem(user_id, dataVehicle[plate..":"..name][1][tostring(slot)].item, amount, true, vRP.getItemInSlot(user_id, "money", target))
						else
							vRP.giveInventoryItem(user_id, dataVehicle[plate..":"..name][1][tostring(slot)].item, amount, true, target)
						end

						dataVehicle[plate..":"..name][1][tostring(slot)].amount = dataVehicle[plate..":"..name][1][tostring(slot)].amount - amount
						if dataVehicle[plate..":"..name][1][tostring(slot)].amount <= 0 then
							dataVehicle[plate..":"..name][1][tostring(slot)] = nil
						end

						weebhook.vehicles[user_id] = weebhook.vehicles[user_id].. "\nRETIROU: "..vRP.getItemName(item).." "..amount.."x "
					else
						TriggerClientEvent( "Notify", source, "negado", "Mochila cheia.", 6000 )
					end
				else
					vCLIENT._closeInventory(source)
				end
			end
		end
	end
	
end

function src.updateVehicleSlots(itemName, slot, target, targetName, targetamount, amount, plate, name)
	local source = source
	local user_id = vRP.getUserId(source)
	local plate = string.gsub(plate, " ","")

	if user_id and plate then
		if openedVehicle[plate] == user_id then
			if amount == nil or amount <= 0 then 
				amount = 1 
			end

			if targetamount == nil or targetamount <= 0 then 
				targetamount = 1
			end

			if itemName ~= targetName then
				dataVehicle[plate..":"..name][1][tostring(slot)].amount = dataVehicle[plate..":"..name][1][tostring(slot)].amount - amount
				dataVehicle[plate..":"..name][1][tostring(target)] = { amount = amount, item = itemName }

				if itemName and targetName then
					dataVehicle[plate..":"..name][1][tostring(slot)] = { amount = targetamount, item = targetName }
				end

				if dataVehicle[plate..":"..name][1][tostring(slot)].amount <= 0 then
					dataVehicle[plate..":"..name][1][tostring(slot)] = nil
				end

				if dataVehicle[plate..":"..name][1][tostring(target)].amount <= 0 then
					dataVehicle[plate..":"..name][1][tostring(target)] = nil
				end
				
			else
				dataVehicle[plate..":"..name][1][tostring(slot)].amount = dataVehicle[plate..":"..name][1][tostring(slot)].amount - amount
				dataVehicle[plate..":"..name][1][tostring(target)].amount = dataVehicle[plate..":"..name][1][tostring(target)].amount + amount

				if dataVehicle[plate..":"..name][1][tostring(slot)].amount <= 0 then
					dataVehicle[plate..":"..name][1][tostring(slot)] = nil
				end

				if dataVehicle[plate..":"..name][1][tostring(target)].amount <= 0 then
					dataVehicle[plate..":"..name][1][tostring(target)] = nil
				end
			end
		else
			vCLIENT._closeInventory(source)
		end

	end
end

function src.checkVehicleOpen(plate)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local plate = string.gsub(plate, " ","")
		if openedVehicle[plate] == nil then
			openedVehicle[plate] = user_id
			userVehicleOppened[user_id] = plate
			return true
		else
			TriggerClientEvent("Notify",source,"negado","Este porta malas ja esta sendo utilizado por outra pessoa.", 3)
		end
	end
end

function src.setVehicleClose(plate, name)
	local source = source
	local user_id = vRP.getUserId(source)
	local plate = string.gsub(plate, " ","")
	if user_id then
		if weebhook.vehicles[user_id] then
			Log("1011263198407708692/WB1gqq5LACOr5Z_bXmvK5gAETq3RfnZlTjHg6yFcb1aHPMhyl_xnNQqVJ9nCqwmiMMrg", "```prolog\n[USER_ID]: "..user_id.." [VEICULO]: "..name.." [PLACA]: "..plate.."\n\n[ACOES]: "..weebhook.vehicles[user_id].."```")
		end
		
		weebhook.vehicles[user_id] = nil
		openedVehicle[plate] = nil
		userVehicleOppened[user_id] = nil
	end
end

function save_vehicles_chest()
	local count = 0

	for k in pairs(dataVehicle) do
		local nuser_id = vRP.getUserByRegistration(dataVehicle[k][3])
		if nuser_id then
			if not dataVehicle[k][4] then
				if openedVehicle[dataVehicle[k][3]] == nil then
					vRP.execute("vRP/update_portaMalas",{ user_id = nuser_id, veiculo = dataVehicle[k][2], portamalas = json.encode(dataVehicle[k][1]) })
					dataVehicle[k] = nil
					count = count + 1
				end
			else
				if openedVehicle[dataVehicle[k][3]] == nil then
					vRP.setSData("tmpChest:"..dataVehicle[k][2].."_"..dataVehicle[k][3], json.encode(dataVehicle[k][1]))
					dataVehicle[k] = nil
					count = count + 1
				end
			end
		else
			if openedVehicle[dataVehicle[k][3]] == nil then
				vRP.setSData("tmpChest:"..dataVehicle[k][2].."_"..dataVehicle[k][3], json.encode(dataVehicle[k][1]))
				dataVehicle[k] = nil
				count = count + 1
			end
		end
	end

	if count > 0 then
		--print("^1[INVENTARIO] ^0Total de porta malas salvo(s): ^1"..count)
	end

	SetTimeout(10*1000,save_vehicles_chest)
end

function Log(webhook,message)
    if webhook ~= "none" then
        PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({content = message}), { ['Content-Type'] = 'application/json' })
    end
end

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- SISTEMA DE INVENTARIO DE FACTOPMS
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
local openedOrg = {}
local userOrgOppened = {}
local dataOrgChest = {}

function src.openOrgChest(id,org,maxbau)
	local source = source
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	if user_id then
		local amountMoc = vRP.getMochilaAmount(user_id)

		if openedOrg[org] == user_id then
			local inv = vRP.getInventory(user_id)
			local myInventory = {}
			if inv then
				for k,v in pairs(inv) do
					if allItems[v["item"]] then
						if v.amount > 0 then
							v["amount"] = parseInt(v["amount"])
							v["name"] = allItems[v["item"]].name
							v["peso"] = allItems[v["item"]].weight
							v["index"] = allItems[v["item"]].tipo
							v["key"] = v["item"]
							v["slot"] = k

							myInventory[k] = v
						end
					end
				end
			end

			if dataOrgChest[org] == nil then
				local rows = vRP.getSData("orgChest:"..org)
				dataOrgChest[org] = { json.decode(rows) or {} }
			end

			local myOrgChest = {}
			local weight = 0.0
			for k,v in pairs(dataOrgChest[org][1]) do
				if allItems[v["item"]] then
					myOrgChest[k] = {
						["amount"] = parseInt(v["amount"]),
						["name"] = allItems[v["item"] ].name,
						["peso"] = allItems[v["item"] ].weight,
						["index"] = allItems[v["item"] ].tipo,
						["key"] = v["item"],
						["slot"] = k
					}

					weight = weight + (allItems[v["item"]].weight*parseInt(v["amount"]))
				end
			end 

			return myInventory,myOrgChest,vRP.computeInvWeight(user_id),vRP.getInventoryMaxWeight(user_id),weight,maxbau,{identity["nome"].." "..identity["sobrenome"],user_id}, { id,org },amountMoc
		else
			vCLIENT._closeInventory(source)
		end
	end
end

function src.colocarOrgChest(item,amount,slot, org, maxBau, id)
	local source = source
	local user_id = vRP.getUserId(source)

	if user_id and org then
		if openedOrg[org] == user_id then
			if item == "money" then
				TriggerClientEvent( "Notify", source, "negado", "Você não pode fazer isso com esse item.", 6000 )
				return
			end

			if vRP.computeItemsWeight(dataOrgChest[org][1])+vRP.getItemWeight(item)*parseInt(amount) <= maxBau then
				if vRP.tryGetInventoryItem(user_id, item, amount, true) then
					dataOrgChest[org][1][tostring(slot)] =  { amount = amount, item = item }

					if cfg.chestOrgs[id] then
						if cfg.chestOrgs[id].weebhook ~= nil then
							vRP.sendLog(cfg.chestOrgs[id].weebhook, "```css\n["..org.."]\n"..os.date("[%d/%m/%Y] [%X]").." O (ID: "..user_id..") colocou o item ("..vRP.getItemName(item).. " " ..amount.."x)```")
						end
					end
				end
			else
				TriggerClientEvent( "Notify", source, "negado", "Bau cheio.", 6000 )
			end
		else
			vCLIENT._closeInventory(source)
		end
	end

end

function src.retirarOrgChest(item,amount,slot,target, org, id)
	local source = source
	local user_id = vRP.getUserId(source)

	if user_id then
		if openedOrg[org] == user_id then
			if vRP.computeInvWeight(user_id)+vRP.getItemWeight(tostring(dataOrgChest[org][1][tostring(slot)].item))*parseInt(amount) <= vRP.getInventoryMaxWeight(user_id) then
				if item == "money" then
					vRP.giveInventoryItem(user_id, dataOrgChest[org][1][tostring(slot)].item, amount, true, vRP.getItemInSlot(user_id, "money", target))
				else
					vRP.giveInventoryItem(user_id, dataOrgChest[org][1][tostring(slot)].item, amount, true, target)
				end

				dataOrgChest[org][1][tostring(slot)].amount = dataOrgChest[org][1][tostring(slot)].amount - amount
				if dataOrgChest[org][1][tostring(slot)].amount <= 0 then
					dataOrgChest[org][1][tostring(slot)] = nil
				end

				if cfg.chestOrgs[id] then
					if cfg.chestOrgs[id].weebhook ~= nil then
						vRP.sendLog(cfg.chestOrgs[id].weebhook, "```css\n["..org.."]\n"..os.date("[%d/%m/%Y] [%X]").." O (ID: "..user_id..") retirou o item ("..vRP.getItemName(item).. " " ..amount.."x)```")
					end
				end
			else
				TriggerClientEvent( "Notify", source, "negado", "Mochila cheia.", 6000 )
			end
		else
			vCLIENT._closeInventory(source)
		end
	end
	
end

function src.updateOrgSlots(itemName, slot, target, targetName, targetamount, amount, org)
	local source = source
	local user_id = vRP.getUserId(source)

	if user_id and org then
		if openedOrg[org] == user_id then
			if amount == nil or amount <= 0 then 
				amount = 1 
			end

			if targetamount == nil or targetamount <= 0 then 
				targetamount = 1
			end

			if itemName ~= targetName then
				if dataOrgChest[org] ~= nil then
					dataOrgChest[org][1][tostring(slot)].amount = dataOrgChest[org][1][tostring(slot)].amount - amount
					dataOrgChest[org][1][tostring(target)] = { amount = amount, item = itemName }

					if itemName and targetName then
						dataOrgChest[org][1][tostring(slot)] = { amount = targetamount, item = targetName }
					end

					if dataOrgChest[org][1][tostring(slot)].amount <= 0 then
						dataOrgChest[org][1][tostring(slot)] = nil
					end

					if dataOrgChest[org][1][tostring(target)].amount <= 0 then
						dataOrgChest[org][1][tostring(target)] = nil
					end
				end
			else
				dataOrgChest[org][1][tostring(slot)].amount = dataOrgChest[org][1][tostring(slot)].amount - amount
				dataOrgChest[org][1][tostring(target)].amount = dataOrgChest[org][1][tostring(target)].amount + amount

				if dataOrgChest[org][1][tostring(slot)].amount <= 0 then
					dataOrgChest[org][1][tostring(slot)] = nil
				end

				if dataOrgChest[org][1][tostring(target)].amount <= 0 then
					dataOrgChest[org][1][tostring(target)] = nil
				end
			end

		else
			vCLIENT._closeInventory(source)
		end
	end
end

function src.checkOrgOpen(permission, org)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasPermission(user_id, permission) then
			if openedOrg[org] == nil then
				openedOrg[org] = user_id
				userOrgOppened[user_id] = org
	
				return true
			else
				TriggerClientEvent("Notify",source,"negado","Este bau ja esta sendo utilizado por outra pessoa.", 3)
			end
		end
	end
end

function src.setOrgClose(org)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		openedOrg[org] = nil
		userOrgOppened[user_id] = nil
	end
end

function save_org_chest()
	for k in pairs(dataOrgChest) do
		if openedOrg[k] == nil then
			vRP.setSData("orgChest:"..k, json.encode(dataOrgChest[k][1]))
			dataOrgChest[k] = nil
		end
	end

	SetTimeout(60*1000,save_org_chest)
end

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- INVENTARIO HOUSE
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
local openedHouseChest = {}
local userHouseOppened = {}
local dataHouseChest = {}

function src.openHouseChest(id, houseID, maxBau)
	local source = source
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	if user_id then
		local amountMoc = vRP.getMochilaAmount(user_id)

		if openedHouseChest[id] == user_id then
			local inv = vRP.getInventory(user_id)
			local myInventory = {}
			if inv then
				for k,v in pairs(inv) do
					if allItems[v["item"]] then
						v["amount"] = parseInt(v["amount"])
						v["name"] = allItems[v["item"]].name
						v["peso"] = allItems[v["item"]].weight
						v["index"] = allItems[v["item"]].tipo
						v["key"] = v["item"]
						v["slot"] = k

						myInventory[k] = v
					end
				end
			end

			if dataHouseChest[id] == nil then
				local rows = vRP.query("flow/allInfoHome", { id = id })
				dataHouseChest[id] = { json.decode(rows[1].bau) or {}, houseID, maxBau }
			end

			local myHouseChest = {}
			local weight = 0.0
			for k,v in pairs(dataHouseChest[id][1]) do
				if allItems[v["item"]] then
					myHouseChest[k] = {
						["amount"] = parseInt(v["amount"]),
						["name"] = allItems[v["item"]].name,
						["peso"] = allItems[v["item"]].weight,
						["index"] = allItems[v["item"]].tipo,
						["key"] = v["item"],
						["slot"] = k
					}
					weight = weight + (allItems[v["item"]].weight*parseInt(v["amount"]))
				end
			end 

			return myInventory,myHouseChest,vRP.computeInvWeight(user_id),vRP.getInventoryMaxWeight(user_id),weight,dataHouseChest[id][3] + 0.0,{identity["nome"].." "..identity["sobrenome"],user_id}, { houseID },amountMoc
		else
			TriggerClientEvent("Notify",source,"negado","Este bau ja esta sendo utilizado por outra pessoa.", 3)
			vCLIENT._closeInventory(source)
		end
	end
end

function src.colocarHousehest(item,amount,slot, id)
	local source = source
	local user_id = vRP.getUserId(source)

	if user_id and id then
		if openedHouseChest[id] == user_id or vRP.hasPermission(user_id, "developer.permissao") then
			if item == "money" then
				TriggerClientEvent( "Notify", source, "negado", "Você não pode fazer isso com esse item.", 6000 )
				return
			end

			if vRP.computeItemsWeight(dataHouseChest[id][1])+vRP.getItemWeight(item)*parseInt(amount) <= dataHouseChest[id][3] + 0.0 then
				if vRP.tryGetInventoryItem(user_id, item, amount, true) then
					dataHouseChest[id][1][tostring(slot)] =  { amount = amount, item = item }
				end

				vRP.sendLog("BAUCASAS", "** COLOCOU ** O ID "..user_id.." colocou o item "..vRP.getItemName(item).." na quantidade de "..amount.."x da propriedade "..dataHouseChest[id][2].." ")
			else
				TriggerClientEvent( "Notify", source, "negado", "Bau cheio.", 6000 )
			end
		else
			vCLIENT._closeInventory(source)
		end
	end

end

function src.retirarHouseChest(item,amount,slot,target, id)
	local source = source
	local user_id = vRP.getUserId(source)

	if user_id then
		if openedHouseChest[id] == user_id or vRP.hasPermission(user_id, "admin.permissao") then
			if vRP.computeInvWeight(user_id)+vRP.getItemWeight(tostring(dataHouseChest[id][1][tostring(slot)].item))*parseInt(amount) <= vRP.getInventoryMaxWeight(user_id) then
				if item == "money" then
					vRP.giveInventoryItem(user_id, dataHouseChest[id][1][tostring(slot)].item, amount, true, vRP.getItemInSlot(user_id, "money", target))
				else
					vRP.giveInventoryItem(user_id, dataHouseChest[id][1][tostring(slot)].item, amount, true, target)
				end

				dataHouseChest[id][1][tostring(slot)].amount = dataHouseChest[id][1][tostring(slot)].amount - amount
				if dataHouseChest[id][1][tostring(slot)].amount <= 0 then
					dataHouseChest[id][1][tostring(slot)] = nil
				end

				vRP.sendLog("BAUCASAS", "** RETIRAR ** O ID "..user_id.." retirou o item "..vRP.getItemName(item).." na quantidade de "..amount.."x da propriedade "..dataHouseChest[id][2].." ")
			else
				TriggerClientEvent( "Notify", source, "negado", "Mochila cheia.", 6000 )
			end
		else
			vCLIENT._closeInventory(source)
		end
	end
	
end

function src.updateHouseSlots(itemName, slot, target, targetName, targetamount, amount, id)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id and id then
		if openedHouseChest[id] == user_id or vRP.hasPermission(user_id, "developer.permissao") then
			if amount == nil or amount <= 0 then 
				amount = 1 
			end

			if targetamount == nil or targetamount <= 0 then 
				targetamount = 1
			end

			if itemName ~= targetName then
				dataHouseChest[id][1][tostring(slot)].amount = dataHouseChest[id][1][tostring(slot)].amount - amount
				dataHouseChest[id][1][tostring(target)] = { amount = amount, item = itemName }

				if itemName and targetName then
					dataHouseChest[id][1][tostring(slot)] = { amount = targetamount, item = targetName }
				end

				if dataHouseChest[id][1][tostring(slot)].amount <= 0 then
					dataHouseChest[id][1][tostring(slot)] = nil
				end

				if dataHouseChest[id][1][tostring(target)].amount <= 0 then
					dataHouseChest[id][1][tostring(target)] = nil
				end
				
			else
				dataHouseChest[id][1][tostring(slot)].amount = dataHouseChest[id][1][tostring(slot)].amount - amount
				dataHouseChest[id][1][tostring(target)].amount = dataHouseChest[id][1][tostring(target)].amount + amount

				if dataHouseChest[id][1][tostring(slot)].amount <= 0 then
					dataHouseChest[id][1][tostring(slot)] = nil
				end

				if dataHouseChest[id][1][tostring(target)].amount <= 0 then
					dataHouseChest[id][1][tostring(target)] = nil
				end
			end
		else
			vCLIENT._closeInventory(source)
		end
	end
end

function src.checkHouseChest(id)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if openedHouseChest[id] == nil then
			openedHouseChest[id] = user_id
			userHouseOppened[user_id] = id
			return true
		else
			TriggerClientEvent("Notify",source,"negado","Este bau ja esta sendo utilizado por outra pessoa.", 3)
		end
	end
end

function src.setHouseClose(id)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		openedHouseChest[id] = nil
		userHouseOppened[user_id] = nil
	end
end

function save_house_chest()
	local count = 0
	for k in pairs(dataHouseChest) do
		if openedHouseChest[k] == nil then
			vRP.execute("flow/updateBau", { id = k, bau = json.encode(dataHouseChest[k][1])} )
			dataHouseChest[k] = nil
		end
	end

	SetTimeout(60*1000,save_house_chest)
end
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- SISTEMA DE INVENTARIO REVISTAR
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
local openedRevistar = {}

function src.openRevistar(nuser_id)
	local source = source
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	local nplayer = vRP.getUserSource(parseInt(nuser_id))
	if user_id then
		local amountMoc = vRP.getMochilaAmount(user_id)

		if nplayer then
			if openedRevistar[nuser_id] == user_id then
				local identity2 = vRP.getUserIdentity(nuser_id)

				local inv = vRP.getInventory(user_id)
				local myInventory = {}
				if inv then
					for k,v in pairs(inv) do
						if allItems[v["item"]] then
							v["amount"] = parseInt(v["amount"])
							v["name"] = allItems[v["item"]].name
							v["peso"] = allItems[v["item"]].weight
							v["index"] = allItems[v["item"]].tipo
							v["key"] = v["item"]
							v["slot"] = k

							myInventory[k] = v
						end
					end
				end

				local inv2 = vRP.getInventory(nuser_id)
				local myHouseChest = {}
				local weight = 0.0

				for k,v in pairs(inv2) do
					if allItems[v["item"]] then
						myHouseChest[k] = {
							["amount"] = parseInt(v["amount"]),
							["name"] = allItems[v["item"]].name,
							["peso"] = allItems[v["item"]].weight,
							["index"] = allItems[v["item"]].tipo,
							["key"] = v["item"],
							["slot"] = k
						}
						weight = weight + (allItems[v["item"]].weight*parseInt(v["amount"]))
					end
				end 
				return myInventory,myHouseChest,vRP.computeInvWeight(user_id),vRP.getInventoryMaxWeight(user_id),weight,vRP.getInventoryMaxWeight(nuser_id),{identity["nome"].." "..identity["sobrenome"],user_id}, { identity2.nome, identity2.sobrenome, nuser_id },amountMoc
			else
				vCLIENT._closeInventory(source)
			end

		end
	end
end

function src.checkOpenRevistar()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local nplayer = vRPclient.getNearestPlayer(source, 5)
		local nuser_id = vRP.getUserId(nplayer)
		if nplayer then
			if vRP.hasPermission(nuser_id, "perm.disparo") and vRP.checkPatrulhamento(nuser_id) then
				TriggerClientEvent("Notify",source,"negado","Você não pode saquear um policia em patrulhamento.", 10000)
				return
			end

			if vRP.hasPermission(nuser_id, "perm.unizk") then
				TriggerClientEvent("Notify",source,"negado","Você não pode saquear um medico.", 10000)
				return
			end

			if openedRevistar[nuser_id] == nil then
				
				if vCLIENT.checkAnim(nplayer) or (GetEntityHealth(GetPlayerPed(nplayer)) <= 105) or vRPclient.isHandcuffed(nplayer) then
					TriggerClientEvent("Notify",source,"sucesso","Iniciando revista...", 5000)
					TriggerClientEvent("Notify",nplayer,"negado","Você está sendo revistado...", 5000)
	
					local weapons = vRPclient.replaceWeapons(nplayer,{})
					for k,v in pairs(weapons) do
							vRP.giveInventoryItem(nuser_id, k, 1, true)
						if v.ammo > 0 then
							local weapon = string.gsub(k, "WEAPON_","AMMO_")
							vRP.giveInventoryItem(nuser_id, weapon, v.ammo, true)
						end
					end
					
					vCLIENT._updateWeapons(nplayer)
					vCLIENT._closeInventory(nplayer)

					return nuser_id
				else
					TriggerClientEvent("Notify",source,"negado","O jogador precisa estar em coma ou rendido.", 10000)
				end
			else
				TriggerClientEvent("Notify",source,"negado","Este jogador ja esta sendo revistado por outra pessoa.", 10000)
			end
		end

		return false
	end
end

function src.setRevistar(id, status)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if status then
			openedRevistar[id] = user_id
		else
			openedRevistar[id] = nil
		end
	end
end

local itensblock = {
	["kevlar"] = true,
	["pano"] = true,
	["linha"] = true,
	["algemas"] = true,
	["chave_algemas"] = true,
	["c4"] = true,
	--["bolsadinheiro"] = true,
	["masterpick"] = true,
	["pendrive"] = true,
	["furadeira"] = true,
	["lockpick"] = true,
	["m-aco"] = true,
	["m-capa_colete"] = true,
	["m-corpo_ak47_mk2"] = true,
	["m-corpo_g3"] = true,
	["m-corpo_machinepistol"] = true,
	["m-corpo_pistol_mk2"] = true,
	["m-corpo_shotgun"] = true,
	["m-corpo_smg_mk2"] = true,
	["m-corpo_snspistol_mk2"] = true,
	["m-gatilho"] = true,
	["capsulas"] = true,
	["polvora"] = true,

	["pecadearma"] = true,
	["rodacarro"] = true,
	["portacarro"] = true,
	["rodamoto"] = true,
    ["discofreio"] = true,
	["parachoque"] = true,
	["volante"] = true,
	["motorcarro"] = true,
	["motormoto"] = true,
	
	["metal"] = true,
	["molas"] = true,
	["gatilho"] = true,
	["m-malha"] = true,
	["m-placametal"] = true,
	["m-tecido"] = true,
	["c-cobre"] = true,
	["c-ferro"] = true,
	["c-fio"] = true,
	["c-polvora"] = true,
	["l-alvejante"] = true,
	["folhamaconha"] = true,
	["maconha"] = true,
	["pastabase"] = true,
	["cocaina"] = true,
	["acidolsd"] = true,
	["body_armor"] = true,
	["capuz"] = true,
	["dirty_money"] = true,
	["scubagear"] = true,
	["relogioroubado"] = true,
	["colarroubado"] = true,
	["anelroubado"] = true,
	["brincoroubado"] = true,
	["pulseiraroubada"] = true,
	["carnedepuma"] = true,
	["carnedelobo"] = true,
	["carnedejavali"] = true,
	["lsd"] = true,
	["morfina"] = true,
	["heroina"] = true,
	["anfetamina"] = true,
	["metanfetamina"] = true,
	["tartaruga"] = true,
	["WEAPON_SNSPISTOL_MK2"] = true,
	["WEAPON_COMBATMG_MK2"] = true,
	["AMMO_SNSPISTOL_MK2"] = true,
	["WEAPON_PISTOL_MK2"] = true,
	["WEAPON_GUSENBERG"] = true,
	["WEAPON_PISTOL50"] = true,
	["WEAPON_HEAVYPISTOL"] = true,
	["WEAPON_HATCHET"] = true,
	["AMMO_PISTOL_MK2"] = true,
	["WEAPON_COMBATPISTOL"] = true,
	["WEAPON_COMBATPDW"] = true,
	["AMMO_COMBATPISTOL"] = true,
	["WEAPON_MACHINEPISTOL"] = true,
	["AMMO_MACHINEPISTOL"] = true,
	["WEAPON_SMG_MK2"] = true,
	["AMMO_SMG_MK2"] = true,
	["WEAPON_SMG"] = true,
	["AMMO_SMG"] = true,
	["WEAPON_ASSAULTSMG"] = true,
	["AMMO_ASSAULTSMG"] = true,
	["WEAPON_SAWNOFFSHOTGUN"] = true,
	["AMMO_SAWNOFFSHOTGUN"] = true,
	["WEAPON_PUMPSHOTGUN_MK2"] = true,
	["AMMO_PUMPSHOTGUN_MK2"] = true,
	["WEAPON_ASSAULTRIFLE_MK2"] = true,
	["AMMO_ASSAULTRIFLE_MK2"] = true,
	["WEAPON_SPECIALCARBINE_MK2"] = true,
	["AMMO_SPECIALCARBINE_MK2"] = true,
	["WEAPON_CARBINERIFLE"] = true,
	["AMMO_CARBINERIFLE"] = true,
	["WEAPON_SPECIALCARBINE"] = true,
	["AMMO_SPECIALCARBINE"] = true,
	["WEAPON_STUNGUN"] = true,
	["WEAPON_PETROLCAN"] = true,
	["AMMO_PETROLCAN"] = true,
}

function src.retirarItemRevistar(id, item, target, amount, slot)
	local source = source
	local user_id = vRP.getUserId(source)
	local nplayer = vRP.getUserSource(id)
	if user_id then
		if nplayer then
			if openedRevistar[id] == user_id then

				if vRP.hasPermission(user_id,"perm.policia") or vRP.hasPermission(user_id,"perm.policiacivil") then
					if itensblock[item] ~= nil then
						TriggerClientEvent("Notify",source,"negado","Você não pode pegar esse item de bandidos.", 3)
						return
					end
				end

				if item == "WEAPON_STUNGUN" then
					TriggerClientEvent("Notify",source,"negado","Você não pode pegar esse item.", 3)
					return
				end

				if vRP.computeInvWeight(user_id)+vRP.getItemWeight(tostring(item))*parseInt(amount) <= vRP.getInventoryMaxWeight(user_id) then
					if vRP.tryGetInventoryItem(id, item, amount, true, slot) then
						if item == "money" then
							vRP.giveInventoryItem(user_id, item, amount, true, vRP.getItemInSlot(user_id, "money", target))
						else
							vRP.giveInventoryItem(user_id, item, amount, true, target)
						end

						vRP.sendLog("SAQUEAR", "O ID "..user_id.." saqueou o item "..vRP.getItemName(item).." na quantidade "..amount.."x do ID "..id..".")
					end
				else
					TriggerClientEvent( "Notify", source, "negado", "Mochila cheia.", 6000 )
				end
				
			else
				vCLIENT._closeInventory(source)
			end
		end
	end
end

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- NUIS CALLBACKS STORES
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function src.openStore(id)
	local source = source
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	if user_id then
		local amountMoc = vRP.getMochilaAmount(user_id)
		local inv = vRP.getInventory(user_id)
		local myInventory = {}
		if inv then
			for k,v in pairs(inv) do
				if (parseInt(v["amount"]) <= 0 or allItems[v.item] == nil) then
					vRP.removeInventoryItem(user_id,v.item,parseInt(v["amount"]))
				else
					v["amount"] = parseInt(v["amount"])
					v["name"] = allItems[v["item"]].name
					v["peso"] = allItems[v["item"]].weight
					v["index"] = allItems[v["item"]].tipo
					v["key"] = v["item"]
					v["slot"] = k

					myInventory[k] = v
				end
			end
		end

		if cfg.stores[id] then
			local items = cfg.stores[id].items
			local myStore = {}
			for k,v in pairs(items) do
				if allItems[v.item] then
					v["name"] = allItems[v.item].name
					v["buyPrice"] = v.priceBuy
					v["sellPrice"] = v.priceSell
					v["key"] = v.item

					myStore[v.slot] = v
				end
			end

			return myInventory,myStore,vRP.computeInvWeight(user_id),vRP.getInventoryMaxWeight(user_id),0,9999,{identity["nome"].." "..identity["sobrenome"],user_id}, { id },amountMoc
		end

	end
end

function src.buyStore(id, item, target, amount)
	amount = parseInt(amount)
	
	if amount == nil or amount <= 0 then
		amount = 1
	end
	
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if cfg.stores[id] then
			local items = cfg.stores[id].items
			if items[item].priceBuy ~= nil then
				if vRP.computeInvWeight(user_id)+vRP.getItemWeight(tostring(item))*parseInt(amount) <= vRP.getInventoryMaxWeight(user_id) then
					if parseInt(items[item].priceBuy) == 0 or vRP.tryPayment(user_id, parseInt(items[item].priceBuy)*amount) then
						vRP.giveInventoryItem(user_id, item, amount, true, target)
						
						if parseInt(items[item].priceBuy)*amount > 0 then
							TriggerClientEvent( "Notify", source, "sucesso", "Você pagou <b>$ "..vRP.format(parseInt(items[item].priceBuy)*amount).."</b>.", 6000 )
						end
					else
						TriggerClientEvent( "Notify", source, "negado", "Você não possui dinheiro.", 6000 )
					end
				else
					TriggerClientEvent( "Notify", source, "negado", "Mochila cheia.", 6000 )
				end
			end
		end
	end
end

function src.sellStore(id, item, amount)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if cfg.stores[id] then
			local items = cfg.stores[id].items
			local bonus = cfg.stores[id].bonus
			local dinheiro = cfg.stores[id].money
			local isNearStore = false 
			local plyCoords = GetEntityCoords(GetPlayerPed(source))

			for i = 1,#cfg.storesLocs do
				if cfg.storesLocs[i].type == id then 
					if #(plyCoords - cfg.storesLocs[i].coords) <= 10 then
						isNearStore = true 
					end
				end
			end

			if dinheiro == "limpo" then dinheiro = "money" elseif dinheiro == "sujo" then dinheiro = "dirty_money" else return end
			if item and items[item] and items[item].sellPrice ~= nil then 
				if vRP.tryGetInventoryItem(user_id, item, amount) then
					if bonus then
						vRP.giveInventoryItem(user_id, dinheiro, parseInt(items[item].sellPrice)*amount, true)
					else
						vRP.giveInventoryItem(user_id, dinheiro, parseInt(items[item].sellPrice)*amount, true)
					end
	
					vCLIENT._updateInventory(source, "updateStore")
				else
					TriggerClientEvent( "Notify", source, "negado", "Você não possui dinheiro.", 6000 )
				end
			 end
			 
		end
	end
end

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- SISTEMA DE DROPAR DROPAR ITEM
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function src.createDropItem(item,count,source)
    local id = idgens:gen()
    local coords = GetEntityCoords(GetPlayerPed(source))

    droplist[id] = { item = item, count = count, x = coords[1], y = coords[2], z = coords[3], name = vRP.getItemName(item), key = item, index = vRP.getItemType(item), peso = vRP.getItemWeight(item) }
	vCLIENT._updateDrops(source,id,droplist[id]) 

	local nplayers = vRPclient.getNearestPlayers(source, 100)
	for k in pairs(nplayers) do
		vCLIENT._updateDrops(k, id,droplist[id]) 
	end
end

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- FUNÇÕES DE UTILIZAÇÃO DE ITENS INVENTARIO
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function play_eat(source, tipo, segundos)
	local prop = ""
	-- COMIDAS
	if tipo == "pao" then
		prop = "prop_food_burg2"
	elseif tipo == "sanduiche" then
		prop = "prop_cs_burger_01"
	elseif tipo == "pizza" then
		prop = "prop_taco_01"
	elseif tipo == "barrac" then
		prop = "prop_choc_meto"
	elseif tipo == "cachorroq" then
		prop = "prop_cs_hotdog_01"
	elseif tipo == "pipoca" then
		prop = "ng_proc_food_chips01b"
	elseif tipo == "donut" then
		prop = "prop_amb_donut"
	elseif tipo == "paoq" then
		prop = "prop_food_cb_nugets"
	elseif tipo == "marmita" then
		prop = "prop_taco_01"
	elseif tipo == "coxinha" then
		prop = "prop_food_cb_nugets"
	else
		prop = "prop_cs_burger_01"
	end

	vRPclient._CarregarObjeto(source,"amb@code_human_wander_eating_donut@male@idle_a","idle_c",prop,49,28422)
	SetTimeout(segundos*1000, function() vRPclient._DeletarObjeto(source) end)
end

function play_drink(source, tipo, segundos)
	local prop = ""
	-- BEBIDAS
	if tipo == "energetico" then
		prop = "prop_energy_drink"
	elseif tipo == "water" then
		prop = "prop_ld_flow_bottle"
	elseif tipo == "cafe" then
		prop = "prop_fib_coffee"
	elseif tipo == "cocacola" then
		prop = "ng_proc_sodacan_01a"
	elseif tipo == "sucol" then
		prop = "ng_proc_sodacan_01b"
	elseif tipo == "sucol2" then
		prop = "ng_proc_sodacan_01b"
	elseif tipo == "sprunk"then
		prop = "ng_proc_sodacan_01b"

	-- BEBIDAS ALCOLICAS
	elseif tipo == "cerveja" then
		prop = "prop_amb_beer_bottle"
	elseif tipo == "whisky" then
		prop = "prop_drink_whisky"
	elseif tipo == "vodka" then
		prop = "p_whiskey_notop" 
	elseif tipo == "pinga" then
		prop = "p_whiskey_notop" 
	elseif tipo == "corote" then
		prop = "ng_proc_sodacan_01b"
	elseif tipo == "absinto" then
		prop = "prop_drink_whisky"
	elseif tipo == "skolb" then
		prop = "ng_proc_sodacan_01b"
	else
		prop = "prop_ld_flow_bottle"
	end
	
	vRPclient._CarregarObjeto(source,"amb@world_human_drinking@beer@male@idle_a","idle_a",prop,49,28422)
    SetTimeout(segundos*1000, function() vRPclient._DeletarObjeto(source) end)
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- COMANDOS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('rscuba', function(source,args)
	local user_id = vRP.getUserId(source)
    if user_id then
		local status,time = func:getCooldown(user_id, "rscuba")

        local ok = vRP.request(source, "Você deseja retirar a sua scuba?", 30)
        if ok and (GetEntityHealth(GetPlayerPed(source)) > 105) and status then
			func:setCooldown(user_id, "enviar", 5)

            if vCLIENT.checkScuba(source) then
                vCLIENT._setScuba(source, false)
                TriggerClientEvent("Notify",source,"negado","Você retirou sua scuba, não conseguimos recuperar ela houve um vazamento.", 5)
            else
                TriggerClientEvent("Notify",source,"negado","Você não possui scuba equipada.", 5)
            end
        end
	end
end)

RegisterCommand('reparar', function(source,args)
	local user_id = vRP.getUserId(source)
    if user_id then
		if not vRPclient.isInVehicle(source) then
			local vehicle = vRPclient.getNearestVehicle(source, 7)
			if vRP.hasPermission(user_id, "perm.bennys") or vRP.hasPermission(user_id, "perm.mecanica") then
				vRPclient._playAnim(source, false, {{"mini@repair", "fixing_a_player"}}, true )
				TriggerClientEvent("progress", source, 30)
				
				SetTimeout(30000,function()
					TriggerClientEvent("reparar", source, vehicle)
					vRPclient._stopAnim(source, false)
					TriggerClientEvent( "Notify", source, "sucesso", "Você reparou o veiculo.", 6000 )
				end)
			end
		else
			TriggerClientEvent( "Notify", source, "negado", "Precisa estar próximo ou fora do veículo para efetuar os reparos.", 6000 )
		end
	end
end)

RegisterCommand('garmas', function(source,args)
    local user_id = vRP.getUserId(source)
    if user_id then
        local ok = vRP.request(source, "Você deseja guardar suas armas?", 30)
		local status, time = exports['vrp']:getCooldown(user_id, "garmas")
        if ok and GetEntityHealth(GetPlayerPed(source)) > 105 and status then
            exports['vrp']:setCooldown(user_id, "garmas", 10)

            if not vRP.checkPatrulhamento(user_id) then
                local weapons = vRPclient.replaceWeapons(source,{})
                local mensagem = ""
				delayGarmas[user_id] = os.time()
                vCLIENT._updateWeapons(source)

                for k,v in pairs(weapons) do
                    if k == "WEAPON_STUNGUN" or k == "WEAPON_PETROLCAN" then 
                        TriggerClientEvent("Notify",source,"negado","Não é possivel guardar <b>"..vRP.getItemName(k).."</b> na mochila..", 5)
                    else
                        vRP.giveInventoryItem(user_id, k, 1, true)

                        if v.ammo > 0 then
                            local ammo = string.gsub(k, "WEAPON_","AMMO_")
                            vRP.giveInventoryItem(user_id, ammo, v.ammo, true)
                        end
                        
                        if v.ammo > 0 then
                            mensagem = mensagem.. "(Arma: "..k.." Municao: "..v.ammo.."x) - "
                        else
                            mensagem = mensagem.. "(Arma: "..k.." Municao: 0x) - "
                        end
                    end
                end

                TriggerClientEvent("Notify",source,"sucesso","Você guardou seu armamento na mochila.", 5)
                vRP.sendLog("GARMAS", "O ID "..user_id.." guardou  [ "..mensagem.." ] ")
            else
                TriggerClientEvent("Notify",source,"negado","Você não pode guardar armas em patrulhamento.", 5)
            end
        end
    end
end)

AddEventHandler("vRP:playerLeave",function(user_id,source)
    if user_id then
        if delayGarmas[user_id] then
			if (os.time() - delayGarmas[user_id] <= 5) then
				delayGarmas[user_id] = nil
				vRP.execute("flow/insertBanned", { user_id = user_id, motivo = "Dupando Armas", banimento = os.date("%d/%m/%Y as %H:%M"), desbanimento = "Nunca", time = 0, hwid = 1 })
				return
			end

			delayGarmas[user_id] = nil
		end
    end
end)

RegisterServerEvent("playerleaveteste")
AddEventHandler("playerleaveteste",function(playerSrc, reason)
	local user_id = vRP.getUserId(playerSrc)
	vRP.sendLog("https://discordapp.com/api/webhooks/1012346199350710342/krskuJFMSHGGGNxqPVyk5o5R_OUzKid0gKlzaCuBLT-aofpl4pNFGOrj_bYufspxR9mU", "O ID "..user_id.." MOTIVO:  [ "..reason.." ] ")
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- REPARAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("tryreparar")
AddEventHandler("tryreparar",function(nveh)
	TriggerClientEvent("syncreparar",-1,nveh)
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- REPARAR PNEUS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("tryrepararpneus")
AddEventHandler("tryrepararpneus",function(nveh)
	TriggerClientEvent("syncrepararpneus",-1,nveh)
end)

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- FUNCTIONS
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	vRP.execute("vRP/inv_deltmpchest",{})
end)

AddEventHandler("vRP:playerLeave",function(user_id,source)
	if user_id then 
		if userOrgOppened[user_id] then
			print("(ID: "..user_id.. ") Quitou/Crashou com Bau da Organização ("..userOrgOppened[user_id]..") aberto.")
			
			openedOrg[userOrgOppened[user_id]] = nil
			userOrgOppened[user_id] = nil
		end

		if userHouseOppened[user_id] then
			print("(ID: "..user_id.. ") Quitou/Crashou com Bau da Casa ("..userHouseOppened[user_id]..") aberto.")
			
			openedHouseChest[userHouseOppened[user_id]] = nil
			userHouseOppened[user_id] = nil
		end

		if userVehicleOppened[user_id] then
			print("(ID: "..user_id.. ") Quitou/Crashou com Bau do Carro ("..userVehicleOppened[user_id]..") aberto.")
			
			openedVehicle[userVehicleOppened[user_id]] = nil
			userVehicleOppened[user_id] = nil
		end

		if weebhook.vehicles[user_id] then
			weebhook.vehicles[user_id] = nil
		end
		
	end
end)

CreateThread(function()
	allItems = vRP.getAllItens()

	save_org_chest()
	save_vehicles_chest()
	save_house_chest()
end)


RegisterServerEvent("saveInventory")
AddEventHandler("saveInventory",function()
	print("Inventarios Salvos...")
	save_org_chest()
	save_vehicles_chest()
	save_house_chest()
end)