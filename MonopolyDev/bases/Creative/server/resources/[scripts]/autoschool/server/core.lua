-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRPC = Tunnel.getInterface("vRP")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
Baixada = {}
Tunnel.bindInterface("autoschool", Baixada)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Active = {}
local PlateVeh = {}
local LicensePrice = 1200
-----------------------------------------------------------------------------------------------------------------------------------------
-- PAYMENT
-----------------------------------------------------------------------------------------------------------------------------------------
function Baixada.Payment()
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		if not Active[Passport] then
			Active[Passport] = true

			if not exports["hud"]:Wanted(Passport) then
				if vRP.GetDriverLicense(Passport) >= 1 then
					TriggerClientEvent("Notify", source, "amarelo", "Você já possuí <b>Carteira de Habilitação</b>.", "Atenção", 5000)
				else
					if GlobalState["Hours"] >= 08 and GlobalState["Hours"] < 23 then
						if vRP.HasGroup(Passport, "Premium") then
							if vRP.Request(source, "Carteira de Habilitação", "Tentar tirar uma <b>Carteira de Habilitação</b> por <b>$" .. parseInt(LicensePrice * 0.50) .. "</b>?") then
								if vRP.PaymentFull(Passport, LicensePrice * 0.50) then
									Active[Passport] = nil

									PlateVeh[Passport] = "PDMSPORT"
									TriggerEvent("plateEveryone", PlateVeh[Passport])

									Player(source)["state"]["Route"] = Passport
									SetPlayerRoutingBucket(source, Passport)

									return true
								end
							end
						else
							if vRP.Request(source, "Carteira de Habilitação", "Tentar tirar uma <b>Carteira de Habilitação</b> por <b>$" .. parseInt(LicensePrice) .. "</b>?") then
								if vRP.PaymentFull(Passport, LicensePrice) then
									Active[Passport] = nil

									PlateVeh[Passport] = "PDMSPORT"
									TriggerEvent("plateEveryone", PlateVeh[Passport])

									Player(source)["state"]["Route"] = Passport
									SetPlayerRoutingBucket(source, Passport)

									return true
								end
							end
						end
					else
						TriggerEvent("Notify", "azul", "Estamos fechados por agora, nosso horário de funcionamento é das <b>08</b> ás <b>23 Horas</b>.", "Prefeitura", 5000)
					end
				end
			end

			Active[Passport] = nil
		end
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- FINISH
-----------------------------------------------------------------------------------------------------------------------------------------
function Baixada.Finish()
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		vRP.UpdateDriverLicense(Passport, 1)
		vRP.GenerateItem(Passport, "driverlicense"..Passport, 1, false)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- AUTOSCHOOL:SEIZECNH
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("autoschool:SeizeCnh")
AddEventHandler("autoschool:SeizeCnh", function(Entity)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		local OtherPassport = vRP.Passport(Entity)
		local FullName = vRP.FullName(OtherPassport)
		if vRP.GetDriverLicense(OtherPassport) == 0 then
			TriggerClientEvent("Notify", source, "amarelo", "<b>" .. FullName .. "</b> não possúi <b>" .. itemName("driverlicense") .. "</b>.", "Atenção", 5000)
		elseif vRP.GetDriverLicense(OtherPassport) == 1 then
			if vRP.Request(source, "Carteira de Habilitação", "Apreender a <b>" .. itemName("driverlicense") .. "</b> de <b>" .. FullName .. "</b>?") then
				vRP.UpdateDriverLicense(Entity, 2)
				TriggerClientEvent("Notify", Entity, "amarelo", "Você teve sua <b>" .. itemName("driverlicense") .. "</b> apreendida.", "Atenção", 5000)
				TriggerClientEvent("Notify", source, "amarelo", "Você apreendeu a <b>" .. itemName("driverlicense") .. "</b> de <b>" .. FullName .. "</b>.", "Atenção", 5000)
			end
		elseif vRP.GetDriverLicense(OtherPassport) == 2 then
			TriggerClientEvent("Notify", source, "amarelo", "<b>" .. FullName .. "</b> já possúi a <b>" .. itemName("driverlicense") .. "</b> apreendida.", "Atenção", 5000)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REMOVEDRIVE
-----------------------------------------------------------------------------------------------------------------------------------------
function Baixada.RemoveDrive()
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		TriggerEvent("plateReveryone", PlateVeh[Passport])

		Player(source)["state"]["Route"] = 0
		SetPlayerRoutingBucket(source, 0)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DISCONNECT
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("Disconnect", function(Passport)
	if Active[Passport] then
		Active[Passport] = nil
	end

	if PlateVeh[Passport] then
		PlateVeh[Passport] = nil
	end
end)