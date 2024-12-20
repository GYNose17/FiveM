-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Spectate = {}
local Blips = false
local Checkpoint = 0
-----------------------------------------------------------------------------------------------------------------------------------------
-- GLOBALSTATE
-----------------------------------------------------------------------------------------------------------------------------------------
GlobalState["Quake"] = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADMIN:DYNAMIC
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("admin:Dynamic")
AddEventHandler("admin:Dynamic", function(Mode, Source)
	local source = Source or source
	local Passport = vRP.Passport(source)
	if Passport then
		if Mode == "wl" then
			if vRP.HasGroup(Passport, "Admin", 1) then
				local Keyboard = KEYBOARD.Secondary(source, "ID da Whitelist:", "Status: (0 inativa, 1 ativa)")
				if Keyboard then
					TriggerClientEvent("Notify", source, "verde", "Whitelist editada.", "Sucesso", 5000)
					exports["vrp"]:Embed("Admin",
						"**Passaporte:** " .. Passport .. "\n**Comando:** wl " .. Keyboard[1] .. " " .. Keyboard[2],
						0xa3c846)

					vRP.Query("accounts/SetWhitelist", { Whitelist = Keyboard[2], id = Keyboard[1] })
				end
			else
				TriggerClientEvent("Notify", source, "amarelo", "Você não tem permissões para isso.", "Atenção",
					5000)
			end
		elseif Mode == "rename" then
			if vRP.HasGroup(Passport, "Admin", 2) then
				local Keyboard = KEYBOARD.Tertiary(source, "ID:", "Nome:", "Sobrenome:")
				if Keyboard then
					vRP.UpgradeNames(Keyboard[1], Keyboard[2], Keyboard[3])
					TriggerClientEvent("Notify", source, "verde", "Nome atualizado.", "Sucesso", 5000)
					exports["vrp"]:Embed("Admin",
						"**Passaporte:** " ..
						Passport .. "\n**Comando:** rename " .. Keyboard[1] .. " " .. Keyboard[2] .. " " .. Keyboard[3],
						0xa3c846)
				end
			else
				TriggerClientEvent("Notify", source, "amarelo", "Você não tem permissões para isso.", "Atenção",
					5000)
			end
		elseif Mode == "ugroups" then
			if vRP.HasGroup(Passport, "Admin") then
				local Keyboard = KEYBOARD.Primary(source, "ID:")
				if Keyboard then
					local Result = ""
					local Groups = vRP.Groups()
					local OtherPassport = Keyboard[1]
					for Permission, _ in pairs(Groups) do
						local Data = vRP.DataGroups(Permission)
						if Data[OtherPassport] then
							Result = Result ..
								"<b>Permissão:</b> " ..
								Permission .. "<br><b>Nível:</b> " .. Data[OtherPassport] .. "<br>"
						end
					end

					if Result ~= "" then
						TriggerClientEvent("Notify", source, "azul", Result, "Grupos Pertencentes", 10000)
					end
				end
			else
				TriggerClientEvent("Notify", source, "amarelo", "Você não tem permissões para isso.", "Atenção",
					5000)
			end
		elseif Mode == "clearinv" then
			if vRP.HasGroup(Passport, "Admin") then
				local Keyboard = KEYBOARD.Primary(source, "ID:")
				if Keyboard then
					vRP.ClearInventory(Keyboard[1])
					TriggerClientEvent("Notify", source, "verde", "Limpeza concluída.", "Sucesso", 5000)
					exports["vrp"]:Embed("Admin", "**Passaporte:** " .. Passport ..
						"\n**Comando:** clearinv " .. Keyboard[1], 0xa3c846)
				end
			else
				TriggerClientEvent("Notify", source, "amarelo", "Você não tem permissões para isso.", "Atenção",
					5000)
			end
		elseif Mode == "gem" then
			if vRP.HasGroup(Passport, "Admin") then
				local Keyboard = KEYBOARD.Secondary(source, "ID:", "Quantidade:")
				if Keyboard then
					local Amount = parseInt(Keyboard[2])
					local OtherPassport = parseInt(Keyboard[1])
					local Identity = vRP.Identity(OtherPassport)
					if Identity then
						TriggerClientEvent("Notify", source, "verde", "Gemas entregues.", "Sucesso", 5000)
						exports["vrp"]:Embed("Admin",
							"**Passaporte:** " .. Passport .. "\n**Comando:** gem " .. Keyboard[1] .. " " .. Keyboard[2],
							0xa3c846)

						vRP.UpgradeGemstone(OtherPassport, Amount)
					end
				end
			else
				TriggerClientEvent("Notify", source, "amarelo", "Você não tem permissões para isso.", "Atenção",
					5000)
			end
		elseif Mode == "blips" then
			if vRP.HasGroup(Passport, "Admin", 2) then
				vRPC.BlipAdmin(source)
			else
				TriggerClientEvent("Notify", source, "amarelo", "Você não tem permissões para isso.", "Atenção",
					5000)
			end
		elseif Mode == "flash" then
			if vRP.HasGroup(Passport, "Admin", 2) then
				TriggerClientEvent("admin:Flash", source)
			else
				TriggerClientEvent("Notify", source, "amarelo", "Você não tem permissões para isso.", "Atenção",
					5000)
			end
		elseif Mode == "god" then
			if vRP.HasGroup(Passport, "Admin", 2) then
				local Keyboard = KEYBOARD.Primary(source, "ID:")
				if Keyboard then
					exports["vrp"]:Embed("Admin", "**Passaporte:** " .. Passport .. "\n**Comando:** god " .. Keyboard[1],
						0xa3c846)

					local OtherPassport = parseInt(Keyboard[1])
					local ClosestPed = vRP.Source(OtherPassport)
					if ClosestPed then
						vRP.UpgradeThirst(OtherPassport, 100)
						vRP.UpgradeHunger(OtherPassport, 100)
						vRP.DowngradeCough(OtherPassport, 100)
						vRP.DowngradeStress(OtherPassport, 100)
						vRP.Revive(ClosestPed, 200)

						TriggerClientEvent("paramedic:Reset", ClosestPed)

						vRPC.Destroy(ClosestPed)
					end
				end
			else
				TriggerClientEvent("Notify", source, "amarelo", "Você não tem permissões para isso.", "Atenção",
					5000)
			end
		elseif Mode == "armour" then
			if vRP.HasGroup(Passport, "Admin", 2) then
				local Keyboard = KEYBOARD.Primary(source, "ID:")
				if Keyboard then
					exports["vrp"]:Embed("Admin", "**Passaporte:** " .. Passport .. "\n**Comando:** armour " ..
						Keyboard[1], 0xa3c846)

					local OtherPassport = parseInt(Keyboard[1])
					local ClosestPed = vRP.Source(OtherPassport)
					if ClosestPed then
						vRP.SetArmour(ClosestPed, 100)
					end
				end
			else
				TriggerClientEvent("Notify", source, "amarelo", "Você não tem permissões para isso.", "Atenção",
					5000)
			end
		elseif Mode == "item" then
			if vRP.HasGroup(Passport, "Admin") then
				local Keyboard = KEYBOARD.Secondary(source, "Nome do Item:", "Quantidade:")
				if Keyboard then
					if itemBody(Keyboard[1]) ~= nil then
						exports["vrp"]:Embed("Admin",
							"**Passaporte:** " .. Passport .. "\n**Comando:** item " .. Keyboard[1] .. " " .. Keyboard
							[2], 0xa3c846)

						if itemMode(Keyboard[1]) == "Chest" then
							vRP.GiveItem(Passport, Keyboard[1] ..
							"-" .. os.time() .. "-" .. (math.random(1000, 5000) + Passport), parseInt(Keyboard[2]), true)
						else
							vRP.GenerateItem(Passport, Keyboard[1], parseInt(Keyboard[2]), true)
						end
					end
				end
			else
				TriggerClientEvent("Notify", source, "amarelo", "Você não tem permissões para isso.", "Atenção",
					5000)
			end
		elseif Mode == "item2" then
			if vRP.HasGroup(Passport, "Admin") then
				local Keyboard = KEYBOARD.Tertiary(source, "ID:", "Nome do Item:", "Quantidade:")
				if Keyboard then
					if itemBody(Keyboard[2]) ~= nil then
						exports["vrp"]:Embed("Admin",
							"**Passaporte:** " ..
							Passport .. "\n**Comando:** item2 " .. Keyboard[1] .. " " .. Keyboard[2] .. " " ..
							Keyboard[3], 0xa3c846)

						if itemMode(Keyboard[1]) == "Chest" then
							vRP.GiveItem(parseInt(Keyboard[1]), Keyboard[2] ..
							"-" .. os.time() .. "-" .. (math.random(1000, 5000) + Passport), parseInt(Keyboard[3]), true)
						else
							vRP.GenerateItem(parseInt(Keyboard[1]), Keyboard[2], parseInt(Keyboard[3]), true)
						end
					end
				end
			else
				TriggerClientEvent("Notify", source, "amarelo", "Você não tem permissões para isso.", "Atenção",
					5000)
			end
		elseif Mode == "itemall" then
			if vRP.HasGroup(Passport, "Admin") then
				local Keyboard = KEYBOARD.Secondary(source, "Nome do Item:", "Quantidade:")
				if Keyboard then
					if itemBody(Keyboard[1]) ~= nil then
						exports["vrp"]:Embed("Admin",
							"**Passaporte:** " .. Passport .. "\n**Comando:** itemall " .. Keyboard[1] ..
							" " .. Keyboard[2], 0xa3c846)

						local List = vRP.Players()
						for AllPlayers, _ in pairs(List) do
							async(function()
								if itemMode(Keyboard[1]) == "Chest" then
									vRP.GiveItem(AllPlayers,Keyboard[1].."-"..os.time().."-"..(math.random(1000,5000) + Passport),parseInt(Keyboard[2]), true)
								else
									vRP.GenerateItem(AllPlayers, Keyboard[1], parseInt(Keyboard[2]), true)
								end
							end)
						end

						TriggerClientEvent("Notify", source, "verde", "Envio concluído.", "Sucesso", 5000)
					end
				end
			else
				TriggerClientEvent("Notify", source, "amarelo", "Você não tem permissões para isso.", "Atenção",
					5000)
			end
		elseif Mode == "delete" then
			if vRP.HasGroup(Passport, "Admin", 2) then
				local Keyboard = KEYBOARD.Primary(source, "ID:")
				if Keyboard then
					exports["vrp"]:Embed("Admin", "**Passaporte:** " .. Passport .. "\n**Comando:** unban " ..
						Keyboard[1], 0xa3c846)

					TriggerClientEvent("dynamic:closeSystem", source)

					if vRP.Request(source, "Deletar Conta", "Você tem certeza?") then
						local OtherPassport = parseInt(Keyboard[1])
						vRP.Query("characters/Delete", { Passport = OtherPassport })
						TriggerClientEvent("Notify", source, "verde", "Personagem <b>" .. OtherPassport ..
							"</b> deletado.", "Sucesso", 5000)
					end
				end
			else
				TriggerClientEvent("Notify", source, "amarelo", "Você não tem permissões para isso.", "Atenção",
					5000)
			end
		elseif Mode == "skin" then
			if vRP.HasGroup(Passport, "Admin", 2) then
				local Keyboard = KEYBOARD.Secondary(source, "ID:", "Skin:")
				if Keyboard then
					local ClosestPed = vRP.Source(Keyboard[1])
					if ClosestPed then
						vRPC.Skin(ClosestPed, Keyboard[2])
						vRP.SkinCharacter(parseInt(Keyboard[1]), Keyboard[2])
						exports["vrp"]:Embed("Admin",
							"**Passaporte:** " .. Passport .. "\n**Comando:** skin " .. Keyboard[1] .. " " .. Keyboard
							[2], 0xa3c846)
						TriggerClientEvent("Notify", source, "verde",
							"Skin <b>" .. Keyboard[2] .. "</b> setada no ID " .. parseInt(Keyboard[1]) .. ".", "Sucesso",
							5000)
					end
				end
			else
				TriggerClientEvent("Notify", source, "amarelo", "Você não tem permissões para isso.", "Atenção",
					5000)
			end
		elseif Mode == "resetskin" then
			if vRP.HasGroup(Passport, "Admin", 2) then
				local Keyboard = KEYBOARD.Primary(source, "ID:")
				if Keyboard then
					local ClosestPed = vRP.Source(Keyboard[1])
					if ClosestPed then
						local OtherPassport = parseInt(Keyboard[1])
						local Identity = vRP.Identity(OtherPassport)
						if Identity then
							if Identity["Sex"] == "M" then
								vRPC.Skin(ClosestPed, "mp_m_freemode_01")
								vRP.SkinCharacter(parseInt(Keyboard[1]), "mp_m_freemode_01")
							elseif Identity["Sex"] == "F" then
								vRPC.Skin(ClosestPed, "mp_f_freemode_01")
								vRP.SkinCharacter(parseInt(Keyboard[1]), "mp_f_freemode_01")
							end

							exports["vrp"]:Embed("Admin",
								"**Passaporte:** " .. Passport .. "\n**Comando:** resetskin " .. Keyboard[1], 0xa3c846)
							TriggerClientEvent("Notify", source, "verde",
								"Skin do ID " .. parseInt(Keyboard[1]) .. " foi resetada.", "Sucesso", 5000)
						end
					end
				end
			else
				TriggerClientEvent("Notify", source, "amarelo", "Você não tem permissões para isso.", "Atenção",
					5000)
			end
		elseif Mode == "nc" then
			if vRP.HasGroup(Passport, "Admin", 2) then
				vRPC.noClip(source)
			else
				TriggerClientEvent("Notify", source, "amarelo", "Você não tem permissões para isso.", "Atenção",
					5000)
			end
		elseif Mode == "kick" then
			if vRP.HasGroup(Passport, "Admin", 2) then
				local Keyboard = KEYBOARD.Primary(source, "ID:")
				if Keyboard then
					local OtherSource = vRP.Source(Keyboard[1])
					if OtherSource then
						TriggerClientEvent("Notify", source, "verde", "Passaporte <b>" .. Keyboard[1] .. "</b> expulso.",
							"Sucesso", 5000)
						exports["vrp"]:Embed("Admin", "**Passaporte:** " .. Passport ..
							"\n**Comando:** kick " .. Keyboard[1], 0xa3c846)
						vRP.Kick(OtherSource, "Expulso da cidade.")
					end
				end
			else
				TriggerClientEvent("Notify", source, "amarelo", "Você não tem permissões para isso.", "Atenção",
					5000)
			end
		elseif Mode == "ban" then
			if vRP.HasGroup(Passport, "Admin", 2) then
				local Keyboard = KEYBOARD.Secondary(source, "ID:", "Dias:")
				if Keyboard then
					local Days = parseInt(Keyboard[2])
					local OtherPassport = parseInt(Keyboard[1])
					local Identity = vRP.Identity(OtherPassport)
					if Identity then
						local OtherSource = vRP.Source(OtherPassport)
						if OtherSource then
							local Token = GetPlayerTokens(OtherSource)
							for k, v in pairs(Token) do
								vRP.Kick(OtherPassport, "Banido.")
								vRP.Query("banneds/InsertBanned",
									{ License = Identity["License"], Token = v, Time = Days })
							end

							exports["vrp"]:Embed("Admin",
								"**Passaporte:** " .. Passport .. "\n**Comando:** ban " .. Keyboard[1] ..
								" " .. Keyboard[2], 0xa3c846)
							TriggerClientEvent("Notify", source, "amarelo",
								"Passaporte <b>" .. OtherPassport .. "</b> banido por <b>" .. Days .. "</b> dias.",
								"Atenção", 5000)
						end
					end
				end
			else
				TriggerClientEvent("Notify", source, "amarelo", "Você não tem permissões para isso.", "Atenção",
					5000)
			end
		elseif Mode == "unban" then
			if vRP.HasGroup(Passport, "Admin", 2) then
				local Keyboard = KEYBOARD.Primary(source, "ID:")
				if Keyboard then
					local OtherPassport = parseInt(Keyboard[1])
					local Identity = vRP.Identity(OtherPassport)
					if Identity then
						vRP.Query("banneds/RemoveBanned", { License = Identity["License"] })
						exports["vrp"]:Embed("Admin", "**Passaporte:** " ..
							Passport .. "\n**Comando:** unban " .. Keyboard[1], 0xa3c846)
						TriggerClientEvent("Notify", source, "verde", "Passaporte <b>" ..
							OtherPassport .. "</b> desbanido.", "Sucesso", 5000)
					end
				end
			else
				TriggerClientEvent("Notify", source, "amarelo", "Você não tem permissões para isso.", "Atenção",
					5000)
			end
		elseif Mode == "timeset" then
			if vRP.HasGroup(Passport, "Admin", 1) then
				local Keyboard = KEYBOARD.Tertiary(source, "Hora:", "Minuto:", "Clima:")
				if Keyboard then
					GlobalState["Hours"] = parseInt(Keyboard[1])
					GlobalState["Minutes"] = parseInt(Keyboard[2])
					GlobalState["Weather"] = Keyboard[3]
				end
			else
				TriggerClientEvent("Notify", source, "amarelo", "Você não tem permissões para isso.", "Atenção",
					5000)
			end
		elseif Mode == "temperatureset" then
			if vRP.HasGroup(Passport, "Admin", 1) then
				local Keyboard = KEYBOARD.Primary(source, "Temperatura:")
				if Keyboard then
					GlobalState["Temperature"] = parseInt(Keyboard[1])
				end
			else
				TriggerClientEvent("Notify", source, "amarelo", "Você não tem permissões para isso.", "Atenção",
					5000)
			end
		elseif Mode == "blackoutset" then
			if vRP.HasGroup(Passport, "Admin", 1) then
				if GlobalState["Blackout"] then
					GlobalState["Blackout"] = false
					TriggerClientEvent("Notify", source, "amarelo", "Modo blackout desativado.", "Atenção", 5000)
				else
					GlobalState["Blackout"] = true
					TriggerClientEvent("Notify", source, "verde", "Modo blackout ativado.", "Sucesso", 5000)
				end
			else
				TriggerClientEvent("Notify", source, "amarelo", "Você não tem permissões para isso.", "Atenção",
					5000)
			end
		elseif Mode == "cds" then
			if vRP.HasGroup(Passport, "Admin", 2) then
				local Ped = GetPlayerPed(source)
				local Coords = GetEntityCoords(Ped)
				local Heading = GetEntityHeading(Ped)

				KEYBOARD.Copy(source, "Cordenadas:",
					mathLength(Coords["x"]) ..
					"," .. mathLength(Coords["y"]) .. "," .. mathLength(Coords["z"]) .. "," .. mathLength(Heading))
			else
				TriggerClientEvent("Notify", source, "amarelo", "Você não tem permissões para isso.", "Atenção",
					5000)
			end
		elseif Mode == "tpcds" then
			if vRP.HasGroup(Passport, "Admin", 2) then
				local Keyboard = KEYBOARD.Primary(source, "Coordenada:")
				if Keyboard then
					local Split = splitString(Keyboard[1], ",")
					vRP.Teleport(source, Split[1] or 0, Split[2] or 0, Split[3] or 0)
				end
			else
				TriggerClientEvent("Notify", source, "amarelo", "Você não tem permissões para isso.", "Atenção",
					5000)
			end
		elseif Mode == "group" then
			if vRP.HasGroup(Passport, "Admin", 1) then
				local Keyboard = KEYBOARD.Tertiary(source, "ID:", "Grupo:", "Hierarquia:")
				if Keyboard then
					local Level = Keyboard[3]
					local Permission = Keyboard[2]
					local OtherPassport = Keyboard[1]

					if vRP.CheckGroup(Permission) then
						if vRP.GroupType(Permission) == "Work" then
							if not vRP.GetUserType(OtherPassport, "Work") then
								exports["vrp"]:Embed("Admin",
									"**Passaporte:** " ..
									Passport .. "\n**Comando:** group " .. OtherPassport .. " " .. Permission .. " " .. Level,
									0xa3c846)
								TriggerClientEvent("Notify", source, "verde",
									"Adicionado <b>" .. Permission .. "</b> ao passaporte <b>" .. OtherPassport .. "</b>.",
									"Sucesso", 5000)
								vRP.SetPermission(OtherPassport, Permission, Level)
								
								if exports["painel"]:Buff(Permission) > 0 then
									vRP.SetPermission(OtherPassport, "Buff")
								end
							else
								TriggerClientEvent("Notify", source, "amarelo", "O passaporte já pertence a outro grupo.",
									"Atenção", 5000)
							end
						else
							exports["vrp"]:Embed("Admin",
								"**Passaporte:** " ..
								Passport .. "\n**Comando:** group " .. OtherPassport .. " " .. Permission .. " " .. Level,
								0xa3c846)
							TriggerClientEvent("Notify", source, "verde",
								"Adicionado <b>" .. Permission .. "</b> ao passaporte <b>" .. OtherPassport .. "</b>.",
								"Sucesso", 5000)
							vRP.SetPermission(OtherPassport, Permission, Level)
						end
					end
				end
			else
				TriggerClientEvent("Notify", source, "amarelo", "Você não tem permissões para isso.", "Atenção",
					5000)
			end
		elseif Mode == "ungroup" then
			if vRP.HasGroup(Passport, "Admin", 1) then
				local Keyboard = KEYBOARD.Secondary(source, "ID:", "Grupo:")
				if Keyboard and vRP.CheckGroup(Keyboard[2]) then
					TriggerClientEvent("Notify", source, "verde",
						"Removido <b>" .. Keyboard[2] .. "</b> ao passaporte <b>" .. Keyboard[1] .. "</b>.", "Sucesso",
						5000)
					exports["vrp"]:Embed("Admin",
						"**Passaporte:** " .. Passport .. "\n**Comando:** ungroup " .. Keyboard[1] .. " " .. Keyboard[2],
						0xa3c846)
					vRP.RemovePermission(Keyboard[1], Keyboard[2])
					if vRP.GroupType(Keyboard[2]) == "Work" then
						vRP.RemovePermission(Keyboard[1], "Buff")
					end
				end
			else
				TriggerClientEvent("Notify", source, "amarelo", "Você não tem permissões para isso.", "Atenção",
					5000)
			end
		elseif Mode == "tptome" then
			if vRP.HasGroup(Passport, "Admin", 2) then
				local Keyboard = KEYBOARD.Primary(source, "ID:")
				if Keyboard then
					local ClosestPed = vRP.Source(Keyboard[1])
					if ClosestPed then
						local Ped = GetPlayerPed(source)
						local Coords = GetEntityCoords(Ped)

						vRP.Teleport(ClosestPed, Coords["x"], Coords["y"], Coords["z"])
					end
				end
			else
				TriggerClientEvent("Notify", source, "amarelo", "Você não tem permissões para isso.", "Atenção",
					5000)
			end
		elseif Mode == "tpto" then
			if vRP.HasGroup(Passport, "Admin", 2) then
				local Keyboard = KEYBOARD.Primary(source, "ID:")
				if Keyboard then
					local ClosestPed = vRP.Source(Keyboard[1])
					if ClosestPed then
						local Ped = GetPlayerPed(ClosestPed)
						local Coords = GetEntityCoords(Ped)
						vRP.Teleport(source, Coords["x"], Coords["y"], Coords["z"])
					end
				end
			else
				TriggerClientEvent("Notify", source, "amarelo", "Você não tem permissões para isso.", "Atenção",
					5000)
			end
		elseif Mode == "tpway" then
			if vRP.HasGroup(Passport, "Admin", 2) then
				BAIXADA_CLIENT.teleportWay(source)
			else
				TriggerClientEvent("Notify", source, "amarelo", "Você não tem permissões para isso.", "Atenção",
					5000)
			end
		elseif Mode == "tuning" then
			if vRP.HasGroup(Passport, "Admin") then
				TriggerClientEvent("admin:Tuning", source)
			else
				TriggerClientEvent("Notify", source, "amarelo", "Você não tem permissões para isso.", "Atenção",
					5000)
			end
		elseif Mode == "fix" then
			if vRP.HasGroup(Passport, "Admin") then
				local Vehicle, Network, Plate = vRPC.VehicleList(source, 10)
				if Vehicle then
					local Players = vRPC.Players(source)
					for _, v in pairs(Players) do
						async(function()
							TriggerClientEvent("inventory:repairAdmin", v, Network, Plate)
						end)
					end
				end
			else
				TriggerClientEvent("Notify", source, "amarelo", "Você não tem permissões para isso.", "Atenção",
					5000)
			end
		elseif Mode == "fuel" then
			if vRP.HasGroup(Passport, "Admin", 2) then
				if not vRPC.InsideVehicle(source) then
					local Vehicle, Network, Plate = vRPC.VehicleList(source, 10)
					if Vehicle then
						local Keyboard = KEYBOARD.Primary(source, "Litros:")
						if Keyboard then
							local Networked = NetworkGetEntityFromNetworkId(Network)
							Entity(Networked)["state"]:set("Fuel", Keyboard[1], true)
							TriggerClientEvent("Notify", source, "verde",
								"Veículo com <b>" .. parseInt(Keyboard[1]) .. "% de Gasolina</b>.", "Sucesso", 5000)
						end
					end
				else
					TriggerClientEvent("Notify", source, "amarelo", "Você precisa sair do veículo.", "Atenção", 5000)
				end
			else
				TriggerClientEvent("Notify", source, "amarelo", "Você não tem permissões para isso.", "Atenção",
					5000)
			end
		elseif Mode == "limparea" then
			if vRP.HasGroup(Passport, "Admin", 2) then
				local Ped = GetPlayerPed(source)
				local Coords = GetEntityCoords(Ped)
				BAIXADA_CLIENT.Limparea(source, Coords)
			else
				TriggerClientEvent("Notify", source, "amarelo", "Você não tem permissões para isso.", "Atenção",
					5000)
			end
		elseif Mode == "hash" then
			if vRP.HasGroup(Passport, "Admin") then
				local Vehicle = vRPC.VehicleHash(source)
				if Vehicle then
					KEYBOARD.Copy(source, "Hash do veículo:", Vehicle)
				end
			else
				TriggerClientEvent("Notify", source, "amarelo", "Você não tem permissões para isso.", "Atenção",
					5000)
			end
		elseif Mode == "setbank" then
			if vRP.HasGroup(Passport, "Admin") then
				local Keyboard = KEYBOARD.Secondary(source, "ID:", "Quantidade:")
				if Keyboard then
					vRP.GiveBank(Keyboard[1], Keyboard[2])
					TriggerClientEvent("Notify", source, "verde", "Envio concluído.", "Sucesso", 5000)
				end
			else
				TriggerClientEvent("Notify", source, "amarelo", "Você não tem permissões para isso.", "Atenção",
					5000)
			end
		elseif Mode == "rembank" then
			if vRP.HasGroup(Passport, "Admin") then
				local Keyboard = KEYBOARD.Secondary(source, "ID:", "Quantidade:")
				if Keyboard then
					vRP.RemoveBank(Keyboard[1], Keyboard[2])
					TriggerClientEvent("Notify", source, "verde", "Remoção concluída.", "Sucesso", 5000)
				end
			else
				TriggerClientEvent("Notify", source, "amarelo", "Você não tem permissões para isso.", "Atenção",
					5000)
			end
		elseif Mode == "players" then
			if vRP.HasGroup(Passport, "Admin", 2) then
				TriggerClientEvent("Notify", source, "azul", "<b>Jogadores Conectados:</b> " .. GetNumPlayerIndices(),
					false, 5000)
			else
				TriggerClientEvent("Notify", source, "amarelo", "Você não tem permissões para isso.", "Atenção",
					5000)
			end
		elseif Mode == "playersconnected" then
			if vRP.HasGroup(Passport, "Admin", 2) then
				local List = vRP.Players()
				local Players = ""
				for k, v in pairs(List) do
					Players = Players .. k .. ": " .. vRP.FullName(k) .. "\n"
				end

				KEYBOARD.Copy(source, "Players Conectados:", Players)
			else
				TriggerClientEvent("Notify", source, "amarelo", "Você não tem permissões para isso.", "Atenção",
					5000)
			end
		elseif Mode == "announce" then
			if vRP.HasGroup(Passport, "Admin") then
				local Keyboard = KEYBOARD.Quadruple(source, "Tema:", "Anúncio:", "Título:", "Segundos:")
				if Keyboard then
					TriggerClientEvent("Notify", -1, Keyboard[1], Keyboard[2], Keyboard[3], Keyboard[4] * 1000)
					exports["vrp"]:Embed("Admin",
						"**Passaporte:** " ..
						Passport ..
						"\n**Comando:** announce " ..
						Keyboard[1] .. " " .. Keyboard[2] .. " " .. Keyboard[3] .. " " .. Keyboard[4] * 1000, 0xa3c846)
				end
			else
				TriggerClientEvent("Notify", source, "amarelo", "Você não tem permissões para isso.", "Atenção",
					5000)
			end
		elseif Mode == "setcar" then
			if vRP.HasGroup(Passport, "Admin") then
				local Keyboard = KEYBOARD.Secondary(source, "ID:", "Veículo:")
				if Keyboard and Keyboard[1] and Keyboard[2] then
					if VehicleExist(Keyboard[2]) then
						local Consult = vRP.Query("vehicles/selectVehicles",
							{ Passport = Keyboard[1], vehicle = Keyboard[2] })
						if Consult[1] then
							TriggerClientEvent("Notify", source, "amarelo",
								"O passaporte <b>" .. Keyboard[1] .. "</b> já possui o veículo <b>" ..
								Keyboard[2] .. "</b>", "Atenção", 5000)
						else
							exports["vrp"]:Embed("Admin",
								"**Passaporte:** " .. Passport .. "\n**Comando:** setcar " ..
								Keyboard[1] .. " " .. Keyboard[2], 0xa3c846)
							vRP.Query("vehicles/addVehicles",
								{
									Passport = Keyboard[1],
									vehicle = Keyboard[2],
									plate = vRP.GeneratePlate(),
									work = "false"
								})
							TriggerClientEvent("Notify", source, "verde",
								"O veículo <b>" ..
								Keyboard[2] .. "</b> foi adicionado para o passaporte <b>" .. Keyboard[1] .. "<b>.",
								"Sucesso", 5000)
						end
					else
						TriggerClientEvent("Notify", source, "amarelo", "Esse carro não existe.", "Atenção", 5000)
					end
				end
			else
				TriggerClientEvent("Notify", source, "amarelo", "Você não tem permissões para isso.", "Atenção",
					5000)
			end
		elseif Mode == "remcar" then
			if vRP.HasGroup(Passport, "Admin") then
				local Keyboard = KEYBOARD.Secondary(source, "ID:", "Veículo:")
				if Keyboard then
					exports["vrp"]:Embed("Admin",
						"**Passaporte:** " .. Passport .. "\n**Comando:** remcar " .. Keyboard[1] .. " " .. Keyboard[2],
						0xa3c846)
					TriggerClientEvent("Notify", source, "verde", "Veículo removido com sucesso.", "Sucesso", 5000)
					vRP.Query("vehicles/removeVehicles", { Passport = Keyboard[1], vehicle = Keyboard[2] })
				end
			else
				TriggerClientEvent("Notify", source, "amarelo", "Você não tem permissões para isso.", "Atenção",
					5000)
			end
		elseif Mode == "driverlicense" then
			if vRP.HasGroup(Passport, "Admin") then
				local Keyboard = KEYBOARD.Secondary(source, "ID:", "(0 Zerada, 1 Liberada, 2 Apreendida)")
				if Keyboard then
					exports["vrp"]:Embed("Admin",
						"**Passaporte:** " .. Passport .. "\n**Comando:** driverlicense " ..
						Keyboard[1] .. " " .. Keyboard[2], 0xa3c846)
					TriggerClientEvent("Notify", source, "verde", "CNH atualizada.", "Sucesso", 5000)
					vRP.UpdateDriverLicense(Keyboard[1], Keyboard[2])
				end
			else
				TriggerClientEvent("Notify", source, "amarelo", "Você não tem permissões para isso.", "Atenção",
					5000)
			end
		elseif Mode == "clearprison" then
			if vRP.HasGroup(Passport, "Admin", 2) then
				local Keyboard = KEYBOARD.Primary(source, "ID:")
				if Keyboard then
					local OtherPlayer = vRP.Source(Keyboard[1])
					if OtherPlayer then
						exports["vrp"]:Embed("Admin",
							"**Passaporte:** " .. Passport .. "\n**Comando:** clearprison " .. Keyboard[1], 0xa3c846)
						exports["markers"]:Exit(OtherPlayer)
						TriggerClientEvent("Notify", source, "verde", "Prisão zerada.", "Sucesso", 5000)
						vRP.Query("characters/CleanPrison", { Passport = Keyboard[1] })
						Player(OtherPlayer)["state"]["Prison"] = false
					end
				end
			else
				TriggerClientEvent("Notify", source, "amarelo", "Você não tem permissões para isso.", "Atenção",
					5000)
			end
		elseif Mode == "stats" then
			local _, TotalPolicia = vRP.NumPermission("Policia")
			local _, TotalParamedico = vRP.NumPermission("Paramedico")

			TriggerClientEvent("Notify", source, "azul",
				"Atualmente <b>" ..
				parseInt(GetNumPlayerIndices()) ..
				"</b> pessoas conectadas.<br><br>Atualmente <b>" ..
				parseInt(TotalPolicia) ..
				" Policiais</b> conectados.<br>Atualmente <b>" ..
				parseInt(TotalParamedico) .. " Paramédicos</b> conectados.", ServerName, 10000)
		elseif Mode == "statsPolicia" then
			local _, TotalPolicia = vRP.NumPermission("Policia")
			TriggerClientEvent("Notify", source, "policia",
				"Existem <b>" .. parseInt(TotalPolicia) .. "</b> companheiros com você.", "Polícia", 5000)
		elseif Mode == "statsParamedico" then
			local _, TotalParamedico = vRP.NumPermission("Paramedico")
			TriggerClientEvent("Notify", source, "hospital",
				"Existem <b>" .. parseInt(TotalParamedico) .. "</b> companheiros com você.", "Paramédico", 5000)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- NC
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("nc", function(source)
	TriggerEvent("admin:Dynamic", "nc", source)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- USOURCE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("usource", function(source, Message)
	local Passport = vRP.Passport(source)
	local OtherSource = parseInt(Message[1])
	if Passport and OtherSource and OtherSource > 0 and vRP.Passport(OtherSource) and vRP.HasGroup(Passport, "Admin") then
		TriggerClientEvent("Notify", source, "azul", "<b>Passaporte:</b> " .. vRP.Passport(OtherSource), "Informações",
			5000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ID
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("id", function(source, Message)
	local Passport = vRP.Passport(source)
	local OtherPassport = parseInt(Message[1])
	if Passport and OtherPassport and OtherPassport > 0 and vRP.Identity(OtherPassport) and vRP.HasGroup(Passport, "Admin") then
		TriggerClientEvent("Notify", source, "azul", "<b>Nome:</b> " .. vRP.FullName(OtherPassport), false, 5000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- QUAKE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("quake", function(source)
	local Passport = vRP.Passport(source)
	if source == 0 or (Passport and vRP.HasGroup(Passport, "Admin", 1)) then
		TriggerClientEvent("Notify",-1,"vermelho","Os geólogos informaram para nossa unidade governamental que foi encontrado um abalo de magnitude <b>" .. (math.random(50, 70) / 10) .. "</b> na <b>Escala Richter</b>, encontrem abrigo até que o mesmo passe.","Terromoto",60000)
		GlobalState["Quake"] = true
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SHUTDOWN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("shutdown",function(source)
	TriggerClientEvent("Notify",-1,"vermelho","Os geólogos informaram para nossa unidade governamental que foi encontrado um abalo de magnitude <b>" .. (math.random(50, 70) / 10) .. "</b> na <b>Escala Richter</b>, encontrem abrigo até que o mesmo passe.","Terromoto",60000)
	GlobalState["Quake"] = true

	if source ~= 0 then
		local Passport = vRP.Passport(source)
		if not vRP.HasGroup(Passport,"Admin",1) then
			return
		end
	end

	SetTimeout(60000, function()
		local List = vRP.Players()
		for _,Sources in pairs(List) do
			vRP.Kick(Sources,"Desconectado, a cidade reiniciou.")
			Wait(100)
		end

		TriggerEvent("SaveServer",false)
	end)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- KICKALL
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("kickall", function(source)
	if source ~= 0 then
		local Passport = vRP.Passport(source)
		if not vRP.HasGroup(Passport, "Admin", 1) then
			return
		end
	end

	local List = vRP.Players()
	for _, Sources in pairs(List) do
		vRP.Kick(Sources, "Desconectado, a cidade reiniciou.")
		Wait(100)
	end

	TriggerEvent("SaveServer", false)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SAVE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("save", function(source)
	if source ~= 0 then
		local Passport = vRP.Passport(source)
		if not vRP.HasGroup(Passport, "Admin", 1) then
			return
		end
	end

	TriggerEvent("SaveServer", false)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SAVEAUTO
-----------------------------------------------------------------------------------------------------------------------------------------
local LastSave = os.time() + 300
CreateThread(function()
	while true do
		Wait(60000)

		if os.time() >= LastSave then
			TriggerEvent("SaveServer", true)
			LastSave = os.time() + 300
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADMIN:COPYCOORDS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("admin:CopyCoords")
AddEventHandler("admin:CopyCoords", function(Coords)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		KEYBOARD.Copy(source, "Cordenadas:",
			mathLength(Coords["x"]) .. "," .. mathLength(Coords["y"]) .. "," .. mathLength(Coords["z"]))
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONSOLE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("console", function(source, Message, History)
	if source == 0 then
		TriggerClientEvent("Notify", -1, "default", History:sub(9), "Prefeitura", 60000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ONLINES
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("onlines", function(source)
	if source == 0 then
		print("Atualmente ^2" .. ServerName .. " ^0tem ^5" .. GetNumPlayerIndices() .. " Onlines^0.")
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TPWAY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("limbo", function(source)
	local Passport = vRP.Passport(source)
	if Passport and vRP.GetHealth(source) <= 100 then
		BAIXADA_CLIENT.teleportLimbo(source)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DEVTOOLSKICK
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("admin:DevToolsKick")
AddEventHandler("admin:DevToolsKick", function()
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		vRP.Kick(source, "Expulso da cidade.")
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SPECTATE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("spectate", function(source, Message)
	local Passport = vRP.Passport(source)
	if Passport then
		if vRP.HasGroup(Passport, "Admin") then
			if Spectate[Passport] then
				local Ped = GetPlayerPed(Spectate[Passport])
				if DoesEntityExist(Ped) then
					SetEntityDistanceCullingRadius(Ped, 0.0)
				end

				TriggerClientEvent("admin:resetSpectate", source)
				Spectate[Passport] = nil

				TriggerClientEvent("Notify", source, "amarelo", "Modo espião desativado.", "Atenção", 5000)
			else
				local OtherSource = vRP.Source(Message[1])
				if OtherSource then
					local OtherPassport = vRP.Passport(OtherSource)
					local FullName = vRP.FullName(OtherPassport)
					if OtherPassport and FullName then
						if vRP.Request(source, "Administração", "Você realmente deseja espionar <b>" .. FullName .. "</b>?") then
							local Ped = GetPlayerPed(OtherSource)
							if DoesEntityExist(Ped) then
								SetEntityDistanceCullingRadius(Ped, 999999999.0)
								Wait(1000)
								TriggerClientEvent("admin:initSpectate", source, OtherSource)
								Spectate[Passport] = OtherSource

								TriggerClientEvent("Notify", source, "verde", "Você está espiando <b>" ..
									FullName .. "</b>.", "Sucesso", 5000)
							end
						end
					end
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DISCONNECT
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("Disconnect", function(Passport)
	if Spectate[Passport] then
		Spectate[Passport] = nil
	end
end)
