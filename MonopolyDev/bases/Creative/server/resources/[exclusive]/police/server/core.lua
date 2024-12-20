-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRPC = Tunnel.getInterface("vRP")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
Baixada = {}
Tunnel.bindInterface("police", Baixada)
vCLIENT = Tunnel.getInterface("police")
vKEYBOARD = Tunnel.getInterface("keyboard")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Active = {}
local Reduces = {}
local PlateSave = {}
local Announces = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- SEARCH
-----------------------------------------------------------------------------------------------------------------------------------------
function Baixada.Search(OtherPassport)
	local source = source
	local Passport = vRP.Passport(source)
	OtherPassport = parseInt(OtherPassport)
	local Identity = vRP.Identity(OtherPassport)
	if Passport and Identity then
		local fines = vRP.GetFine(OtherPassport)
		local records = vRP.Query("prison/Personal", { nuser_id = OtherPassport })
		local ports = vRP.Query("gunlicense/List")
		local port = Identity["Gun"]
		return {
			true,
			Identity["Name"] .. " " .. Identity["Lastname"],
			Identity["Phone"],
			fines,
			records,
			port,
			ports,
			0
		}
	end

	return { false }
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- PRISON
-----------------------------------------------------------------------------------------------------------------------------------------
function Baixada.Prison(nuser_id, services, fines, text, association, residual, url, cops)
	local source = source
	local Passport = vRP.Passport(source)
	if Active[Passport] == nil then
		Active[Passport] = true

		local Identity = vRP.Identity(Passport)
		if Identity then
			local OtherPlayer = vRP.Source(nuser_id)
			if OtherPlayer then
				vCLIENT.Sync(OtherPlayer, true, true)
				Player(OtherPlayer)["state"]["Prison"] = true
				TriggerClientEvent("radio:RadioClean", OtherPlayer)
				exports["markers"]:Enter(OtherPlayer, "Prisioneiro")
				TriggerClientEvent("Notify", OtherPlayer, "amarelo",
					"As lixeiras do pátio estão disponíveis para <b>vasculhar</b> em troca de redução penal.",
					"Sistema Penitenciário", 10000)
			end

			vRP.Query("prison/Insert", {
				police = Identity["Name"] .. " " .. Identity["Lastname"],
				nuser_id = parseInt(nuser_id),
				services = services,
				fines = fines,
				text = text,
				date = os.date("%d/%m/%Y") .. " ás " .. os.date("%H:%M"),
				cops = cops,
				association = association,
				residual = residual,
				url = url
			})

			TriggerClientEvent("Notify", source, "verde", "Prisão efetuada.", "Sucesso", 5000)
			vRP.InitPrison(nuser_id, services)

			if fines > 0 then
				vRP.GiveFine(nuser_id, fines)
				exports["bank"]:AddFines(Passport, nuser_id, fines, text)

				if NewBankTaxs then
					exports["bank"]:AddTaxs(nuser_id, "Prefeitura", fines * 0.2, "Sistema Penitenciário.")
				end
			end

			exports["vrp"]:Embed("Prison",
				"**Por:** " ..
				parseFormat(Passport) ..
				"\n**Passaporte:** " ..
				parseFormat(nuser_id) ..
				"\n**Serviços:** " ..
				parseFormat(services) ..
				"\n**Multa:** $" ..
				parseFormat(fines) .. "\n**Horário:** " .. os.date("%H:%M:%S") .. "\n**Motivo:** " .. text, 3092790)
		end

		Active[Passport] = nil
		return true
	end
	return false
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKPRISON
-----------------------------------------------------------------------------------------------------------------------------------------
function Baixada.CheckPrison(prisonId)
	local records = vRP.Query("prison/Get", { id = parseInt(prisonId) })

	if records[1] then
		return {
			true,
			{},
			records[1]
		}
	end

	return { false }
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- FINE
-----------------------------------------------------------------------------------------------------------------------------------------
function Baixada.Fine(nuser_id, fines, text)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and fines > 0 then
		if Active[Passport] == nil then
			Active[Passport] = true

			exports["vrp"]:Embed("Prison",
				"**Por:** " ..
				parseFormat(Passport) ..
				"\n**Passaporte:** " ..
				parseFormat(nuser_id) ..
				"\n**Multa:** $" ..
				parseFormat(fines) .. "\n**Horário:** " .. os.date("%H:%M:%S") .. "\n**Motivo:** " .. text, 3092790)

			TriggerClientEvent("Notify", source, "verde", "Multa aplicada.", "Sucesso", 5000)
			TriggerClientEvent("police:Update", source, "reloadFine")
			vRP.GiveFine(nuser_id, fines, text, Passport)

			if fines > 0 then
				vRP.GiveFine(nuser_id, fines)
				exports["bank"]:AddFines(Passport, nuser_id, fines, text)

				if NewBankTaxs then
					exports["bank"]:AddTaxs(nuser_id, "Prefeitura", fines * 0.2, "Sistema Penitenciário.")
				end
			end

			Active[Passport] = nil
		end
	end
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- SEARCHGUNLICENSE
-----------------------------------------------------------------------------------------------------------------------------------------
function Baixada.SearchGunlicense()
	local ports = vRP.Query("gunlicense/List")
	if ports[1] then
		return {
			true,
			ports
		}
	end

	return { false }
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- GIVEGUNLICENSE
-----------------------------------------------------------------------------------------------------------------------------------------
function Baixada.GiveGunlicense(user_id, serial, status, weapon, exame)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		if Active[Passport] == nil and vRP.HasGroup(Passport, "Policia", 1) then
			Active[Passport] = true

			local Identity = vRP.Identity(Passport)
			local Identit = vRP.Identity(user_id)
			if Identity and Identit then
				vRP.Query("gunlicense/Insert", {
					identity = Identit["Name"] .. " " .. Identit["Lastname"],
					user_id = user_id,
					portType = status,
					serial = serial,
					weapon = weapon,
					exam = exame,
					nidentity = Identity["Name"] .. " " .. Identity["Lastname"],
					date = os.date("%d/%m/%Y") .. " ás " .. os.date("%H:%M")
				})
			end

			TriggerClientEvent("Notify", source, "verde", "Porte adicionado.", "Sucesso", 5000)
			TriggerClientEvent("police:Update", source, "reloadPortes")

			Active[Passport] = nil
		end
	end
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- GETGUNLICENSE
-----------------------------------------------------------------------------------------------------------------------------------------
function Baixada.GetGunlicense(portId)
	local port = vRP.Query("gunlicense/Personal", { portId = parseInt(portId) })

	if port[1] then
		return {
			true,
			port[1]
		}
	end

	return { false }
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- EDITGUNLICENSE
-----------------------------------------------------------------------------------------------------------------------------------------
function Baixada.EditGunlicense(portId, user_id, serial, status, weapon, exame)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		if Active[Passport] == nil and vRP.HasGroup(Passport, "Policia", 1) then
			Active[Passport] = true

			local Identity = vRP.Identity(Passport)
			local Identit = vRP.Identity(user_id)
			if Identity and Identit then
				vRP.Query("gunlicense/Update", {
					portId = portId,
					identity = Identit["Name"] .. " " .. Identit["Lastname"],
					user_id = user_id,
					portType = status,
					serial = serial,
					weapon = weapon,
					exam = exame,
					nidentity = Identity["Name"] .. " " .. Identity["Lastname"],
					date = os.date("%d/%m/%Y") .. " ás " .. os.date("%H:%M")
				})
			end

			TriggerClientEvent("Notify", source, "verde", "Porte atualiado.", "Sucesso", 5000)
			TriggerClientEvent("police:Update", source, "reloadPortes")

			Active[Passport] = nil
		end
	end
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- DELETEGUNLICENSE
-----------------------------------------------------------------------------------------------------------------------------------------
function Baixada.DeleteGunlicense(portId)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		if Active[Passport] == nil and vRP.HasGroup(Passport, "Policia", 1) then
			Active[Passport] = true

			vRP.Query("gunlicense/Remove", { portId = portId })

			TriggerClientEvent("Notify", source, "verde", "Porte deletado.", "Sucesso", 5000)
			TriggerClientEvent("police:Update", source, "reloadPortes")

			Active[Passport] = nil
		end
	end
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- GETWARRANT
-----------------------------------------------------------------------------------------------------------------------------------------
function Baixada.GetWarrant()
	local warrant = vRP.Query("warrants/List")
	if warrant[1] then
		return {
			true,
			warrant
		}
	end

	return { false }
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKWARRANT
-----------------------------------------------------------------------------------------------------------------------------------------
function Baixada.CheckWarrant(id)
	local warrant = vRP.Query("warrants/Personal", { id = id })
	if warrant[1] then
		return {
			true,
			warrant[1]["identity"],
			warrant[1]
		}
	end
	return { false }
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- DELETEWARRANT
-----------------------------------------------------------------------------------------------------------------------------------------
function Baixada.DeleteWarrant(id)
	local source = source
	local Passport = vRP.Passport(source)
	if vRP.HasGroup(Passport, "Policia", 1) then
		vRP.Query("warrants/Remove", { id = id })

		TriggerClientEvent("police:Update", source, "reloadProcurados")
	end
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- WARRANT
-----------------------------------------------------------------------------------------------------------------------------------------
function Baixada.Warrant(user_id, reason)
	local source = source
	local Passport = vRP.Passport(source)
	if vRP.HasGroup(Passport, "Policia", 1) then
		local Identity = vRP.Identity(Passport)
		local Identit = vRP.Identity(user_id)
		if Identity and Identit then
			vRP.Query("warrants/Insert", {
				user_id = user_id,
				identity = Identit["Name"] .. " " .. Identit["Lastname"],
				status = "Procurado",
				nidentity = Identity["Name"] .. " " .. Identity["Lastname"],
				timeStamp = os.date("%d/%m/%Y") .. " ás " .. os.date("%H:%M"),
				reason = reason
			})

			TriggerClientEvent("police:Update", source, "reloadProcurados")
		end
	end
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- REPORTS
-----------------------------------------------------------------------------------------------------------------------------------------
function Baixada.Reports()
	return vRP.Query("reports/List")
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- ADDREPORT
-----------------------------------------------------------------------------------------------------------------------------------------
function Baixada.AddReport(data)
	if data["victim_id"] and data["victim_report"] and data["victim_name"] then
		local source = source
		local Passport = vRP.Passport(source)
		if Passport then
			if Active[Passport] == nil then
				Active[Passport] = true

				local Identity = vRP.Identity(Passport)
				if Identity then
					vRP.Query("reports/Insert", {
						victim_id = data["victim_id"],
						police_name = Identity["Name"] .. " " .. Identity["Lastname"],
						solved = nil,
						victim_name = data["victim_name"],
						created_at = os.date("%d/%m/%Y") .. " ás " .. os.date("%H:%M"),
						victim_report = data["victim_report"],
						updated_at = os.date("%d/%m/%Y") .. " ás " .. os.date("%H:%M")
					})
				end
				Active[Passport] = nil
			end
		end
	end
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- REPORTSOLVED
-----------------------------------------------------------------------------------------------------------------------------------------
function Baixada.ReportSolved(id)
	vRP.Query("reports/Solved", { id = id, updated_at = os.date("%d/%m/%Y") .. " ás " .. os.date("%H:%M") })
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- REPORTREMOVE
-----------------------------------------------------------------------------------------------------------------------------------------
function Baixada.ReportRemove(id)
	vRP.Query("reports/Remove", { id = id })
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- POLICE:PRISONCLOTHES
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("police:prisonClothes")
AddEventHandler("police:prisonClothes", function(entity)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and vRP.GetHealth(source) > 100 then
		local mHash = vRP.ModelPlayer(entity[1])
		if mHash == "mp_m_freemode_01" or mHash == "mp_f_freemode_01" then
			TriggerClientEvent("skinshop:Apply", entity[1], Preset[mHash])
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATEPORT
-----------------------------------------------------------------------------------------------------------------------------------------
function Baixada.UpdatePort(OtherPassport)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and vRP.HasGroup(Passport, "Policia", 1) then
		local PortStatus = "Desativado"
		local OtherPassport = parseInt(OtherPassport)
		local Identity = vRP.Identity(OtherPassport)

		if parseInt(Identity["Gun"]) == 0 then
			PortStatus = "Ativado"
			vRP.UpdateGunlicense(OtherPassport, 1)
		else
			vRP.UpdateGunlicense(OtherPassport, 0)
		end

		TriggerClientEvent("Notify", source, "verde", "Porte atualizado.", "Sucesso", 5000)
		TriggerClientEvent("police:Update", source, "reloadSearch", parseInt(OtherPassport))

		if NewBankTaxs then
			exports["bank"]:AddTaxs(OtherPassport, "Prefeitura", 35, "Atualização de Identidade.")
		end

		exports["vrp"]:Embed("Prison",
			"**Por:** " ..
			parseFormat(Passport) ..
			"\n**Passaporte:** " ..
			parseFormat(OtherPassport) .. "\n**Porte:** " .. PortStatus .. "\n**Horário:** " .. os.date("%H:%M:%S"),
			3092790)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLEANREC
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("cleanrec", function(source, Message)
	local Passport = vRP.Passport(source)
	if Passport and vRP.HasGroup(Passport, "Policia", 1) and Message[1] and tonumber(Message[1]) then
		vRP.Query("prison/Clean", { ["nuser_id"] = tonumber(Message[1]) })
		if NewBankTaxs then
			exports["bank"]:AddTaxs(tonumber(Message[1]), "Prefeitura", 1250, "Limpeza de Ficha.")
		end
		
		TriggerClientEvent("Notify", source, "verde", "Ficha limpa.", "Sucesso", 5000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- POLICE:REDUCES
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("police:Reduces")
AddEventHandler("police:Reduces", function(Number)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		local Identity = vRP.Identity(Passport)
		if parseInt(Identity["Prison"]) > 0 then
			if not Reduces[Number] then
				Reduces[Number] = {}
			end

			if Reduces[Number][Passport] then
				if os.time() > Reduces[Number][Passport] then
					reduceFunction(source, Passport, Number)
				else
					TriggerClientEvent("Notify", source, "vermelho", "Nada encontrado.", "Sistema Penitenciário", 5000)
				end
			else
				reduceFunction(source, Passport, Number)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REDUCEFUNCTION
-----------------------------------------------------------------------------------------------------------------------------------------
function reduceFunction(source, Passport, Number)
	vRPC.PlayAnim(source, false, { "amb@prop_human_bum_bin@base", "base" }, true)
	TriggerClientEvent("Progress", source, "Vasculhando", 10000)
	Reduces[Number][Passport] = os.time() + 600
	Player(source)["state"]["Buttons"] = true
	Player(source)["state"]["Cancel"] = true
	local timeProgress = 10

	repeat
		Wait(1000)
		timeProgress = timeProgress - 1
	until timeProgress <= 0

	local Random = math.random(#PrisonItens)
	local Amount = math.random(PrisonItens[Random]["Min"], PrisonItens[Random]["Max"])
	vRP.GenerateItem(Passport, PrisonItens[Random]["Item"], Amount, true)

	if vRP.HasGroup(Passport, "Premium") then
		vRP.UpdatePrison(Passport, source, 2)
	else
		vRP.UpdatePrison(Passport, source, 1)
	end

	Player(source)["state"]["Buttons"] = false
	Player(source)["state"]["Cancel"] = false
	vRPC.Destroy(source)
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- POLICE:SCAPE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("police:Scape")
AddEventHandler("police:Scape", function()
	local source = source
	local Passport = vRP.Passport(source)
	local Service, Total = vRP.NumPermission("Policia")
	if Passport then
		if Total >= 2 then
			if vRP.TakeItem(Passport, "key", 1, true) then
				Player(source)["state"]["Prison"] = false

				exports["markers"]:Exit(source)
				vCLIENT.Sync(source, true, false)
				vRP.Query("characters/CleanPrison", { Passport = Passport })

				for Passports, Sources in pairs(Service) do
					async(function()
						vRPC.PlaySound(Sources, "Beep_Red", "DLC_HEIST_HACKING_SNAKE_SOUNDS")
						TriggerClientEvent("Notify", Sources, "amarelo",
							"Encontramos um fugitivo da penitenciária e todos os policiais foram avisados.",
							"Sistema Penitenciário", 5000)
					end)
				end
			else
				TriggerClientEvent("Notify", source, "amarelo", "Você precisa de <b>1x " .. itemName("key") .. "</b>.",
					"Atenção", 5000)
			end
		else
			TriggerClientEvent("Notify", source, "amarelo", "Contingente indisponível.", "Atenção", 5000)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- POLICE:PLATE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("police:Plate")
AddEventHandler("police:Plate", function(Entity)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		runPlate(source, Entity[1])
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- RUNPLATE
-----------------------------------------------------------------------------------------------------------------------------------------
function runPlate(source, Plate)
	local Passport = vRP.PassportPlate(Plate)
	if Passport then
		local Identity = vRP.Identity(Passport["Passport"])
		vRPC.PlaySound(source, "Event_Message_Purple", "GTAO_FM_Events_Soundset")
		TriggerClientEvent("Notify", source, "azul",
			"<b>Passaporte:</b> " ..
			Identity["id"] ..
			"<br><b>Nome:</b> " .. Identity["Name"] .. " " .. Identity["Lastname"] ..
			"<br><b>Nº:</b> " .. Identity["Phone"], false, 10000)
	else
		if not PlateSave[Plate] then
			PlateSave[Plate] = { PlateName[math.random(#PlateName)] .. " " .. PlateLastname[math.random(#PlateLastname)],
				vRP.GeneratePhone() }
		end

		vRPC.PlaySound(source, "Event_Message_Purple", "GTAO_FM_Events_Soundset")
		TriggerClientEvent("Notify", source, "azul",
			"<b>Passaporte:</b> 9.999<br><b>Nome:</b> " .. PlateSave[Plate][1] .. "<br><b>Nº:</b> " ..
			PlateSave[Plate][2], false, 10000)
	end
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- POLICE:ARRESTVEHICLES
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("police:ArrestVehicles")
AddEventHandler("police:ArrestVehicles", function(Entity)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		if vRP.Request(source, "Impound", "Apreender o veículo?") then
			local Passport = vRP.PassportPlate(Entity[1])
			if Passport then
				local Vehicle = vRP.Query("vehicles/selectVehicles",
					{ Passport = Passport["Passport"], vehicle = Entity[2] })
				if Vehicle[1] then
					if Vehicle[1]["arrest"] <= os.time() then
						vRP.Query("vehicles/arrestVehicles", { Passport = Passport["Passport"], vehicle = Entity[2] })
						TriggerClientEvent("Notify", source, "verde", "Veículo apreendido.", "Sucesso", 5000)
					else
						TriggerClientEvent("Notify", source, "vermelho", "Veículo já se encontra apreendido.", "Aviso",
							5000)
					end
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- POLICE:ARRESTITENS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("police:ArrestItens")
AddEventHandler("police:ArrestItens", function(Entity)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		local OtherPassport = vRP.Passport(Entity)
		local Inventory = vRP.Inventory(OtherPassport)
		if Inventory then
			for i = 1, vRP.GetWeight(OtherPassport) do
				local Slot = tostring(i)
				if Inventory[Slot] then
					if itemArrest(Inventory[Slot]["item"]) then
						vRP.RemoveItem(OtherPassport, Inventory[Slot]["item"], Inventory[Slot]["amount"], ArrestNotify)
					end
				end
			end
		end
	end
end)
--------------------------------------------------------------------------------------------------------------------------------------------------
-- CONNECT
--------------------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("Connect", function(Passport, source)
	local Identity = vRP.Identity(Passport)
	if parseInt(Identity["Prison"]) > 0 then
		Player(source)["state"]["Prison"] = true
		exports["markers"]:Enter(source, "Prisioneiro")
		TriggerClientEvent("Notify", source, "amarelo",
			"Você ainda precisa cumprir <b>" ..
			parseInt(Identity["Prison"]) .. " Serviços</b> para ter a redução penal zerada.", "Sistema Penitenciário",
			10000)
	end

	if Active[Passport] == true then
		Active[Passport] = nil
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DISCONNECT
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("Disconnect", function(Passport)
	if Active[Passport] then
		Active[Passport] = nil
	end

	if Announces[Passport] then
		Announces[Passport] = nil
	end
end)