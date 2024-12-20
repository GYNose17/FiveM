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
Tunnel.bindInterface("target", Baixada)
vKEYBOARD = Tunnel.getInterface("keyboard")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Price = 750
local Calls = {}
local Announces = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKIN
-----------------------------------------------------------------------------------------------------------------------------------------
function Baixada.CheckIn()
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		if vRP.GetHealth(source) <= 100 then
			if vRP.PaymentFull(Passport, Price * 2) then
				vRP.UpgradeHunger(Passport, 30)
				vRP.UpgradeThirst(Passport, 30)
				TriggerEvent("Reposed", source, Passport, 900)

				return true
			end
		else
			if vRP.UserMedicPlan(Passport) then
				if vRP.Request(source, "Hospital", "Prosseguir o tratamento por <b>$" .. parseInt(Price * 0.50) .. "</b> dólares?") then
					if vRP.PaymentFull(Passport, Price * 0.50) then
						vRP.UpgradeHunger(Passport, 30)
						vRP.UpgradeThirst(Passport, 30)
						TriggerEvent("Reposed", source, Passport, 900)

						return true
					end
				end
			else
				if vRP.Request(source, "Hospital", "Prosseguir o tratamento por <b>$" .. parseInt(Price) .. "</b> dólares?") then
					if vRP.PaymentFull(Passport, Price) then
						vRP.UpgradeHunger(Passport, 30)
						vRP.UpgradeThirst(Passport, 30)
						TriggerEvent("Reposed", source, Passport, 900)

						return true
					end
				end
			end
		end
	end

	return false
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- TARGET:ANNOUNCES
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("target:Announces")
AddEventHandler("target:Announces", function(Service)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		if not Announces[Service] then
			Announces[Service] = os.time()
		end

		if os.time() >= Announces[Service] then
			if Service == "Policia" then
				if vRP.HasGroup(Passport, "Policia") then
					Announces[Service] = os.time() + 600
					TriggerClientEvent("Notify", -1, "policia", "Sinta-se seguro(a) agora mesmo, pois há policiais realizando patrulhas em nossa cidade neste exato instante.", "Los Santos Police Department", 15000)
				else
					TriggerClientEvent("Notify", source, "vermelho", "Você não pode enviar um anúncio.", "Aviso", 5000)
				end
			elseif Service == "Paramedico" then
				if vRP.HasGroup(Passport, "Paramedico") then
					Announces[Service] = os.time() + 600
					TriggerClientEvent("Notify", -1, "hospital", "Estamos em busca de doadores de sangue, seja solidário e ajude o próximo, procure um de nossos profissionais.", "Pillbox Medical Center", 15000)
				else
					TriggerClientEvent("Notify", source, "vermelho", "Você não pode enviar um anúncio.", "Aviso", 5000)
				end
			else
				if vRP.HasGroup(Passport, Service) then
					Announces[Service] = os.time() + 600
					TriggerClientEvent("Notify", -1, "default", "Estamos em busca de trabalhadores, compareça ao estabelecimento, procure um de nossos funcionários e consulte nosso serviço de entregas.", Service, 15000)
				else
					TriggerClientEvent("Notify", source, "vermelho", "Você não pode enviar um anúncio.", "Aviso", 5000)
				end
			end
		else
			local Cooldown = parseInt(Announces[Service] - os.time())
			TriggerClientEvent("Notify", source, "azul", "Aguarde <b>" .. Cooldown .. "</b> segundos.", false, 5000)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TARGET:CALL
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("target:Call")
AddEventHandler("target:Call", function(Service)
	local source = source
	local Passport = vRP.Passport(source)
	local Identity = vRP.Identity(Passport)
	if Passport and Identity then
		if not Calls[Service] then
			Calls[Service] = os.time()
		end

		if os.time() >= Calls[Service] then
			if vRP.Request(source, "Emergência", "Você realmente deseja ligar para <b>" .. Service .. "</b> por <b>$25</b>?") then
				TriggerClientEvent("emotes", source, "ligar")

				local Keyboard = vKEYBOARD.Area(source,"Qual o motivo do chamado?")
				if Keyboard then
					if vRP.PaymentFull(Passport,25) then
						local Coords = vRP.GetEntityCoords(source)
						local Permission = vRP.NumPermission(Service)
						for Passports,Sources in pairs(Permission) do
							async(function()
								TriggerClientEvent("NotifyPush",Sources,{ code = 20, phone = Identity["Phone"], title = "Chamado de " .. vRP.FullName(Passport), text = Keyboard[1], x = Coords["x"], y = Coords["y"], z = Coords["z"], time = "Recebido às " .. os.date("%H:%M"), blipColor = 2 })
							end)
						end

						if NewBankTaxs then
							exports["bank"]:AddTaxs(Passport,"Prefeitura",25,"Telefone Coletivo.")
						end

						Calls[Service] = os.time() + 350
					end
				end

				vRPC.Destroy(source, "one")
			end
		else
			local Cooldown = MinimalTimers(Calls[Service] - os.time())
			TriggerClientEvent("Notify", source, "azul", "Aguarde <b>" .. Cooldown .. "</b> segundos.", false, 5000)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TARGET:MEDICPLAN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("target:Medicplan")
AddEventHandler("target:Medicplan", function()
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		if vRP.Request(source, "Hospital", "Assinar o plano de saúde por <b>$" .. parseInt(10000) .. "</b>? Lembrando que a duração do mesmo é de 7 dias.") then
			if vRP.PaymentFull(Passport, 10000) then
				vRP.SetMedicPlan(Passport)
				TriggerClientEvent("Notify", source, "azul", "Você assinou o plano de saúde por <b>7 dias</b>.",
					"Pillbox Medical", 5000)
			end
		end
	end
end)