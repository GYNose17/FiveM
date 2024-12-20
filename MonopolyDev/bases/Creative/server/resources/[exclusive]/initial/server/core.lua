-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
Baixada = {}
Tunnel.bindInterface("initial", Baixada)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECK
-----------------------------------------------------------------------------------------------------------------------------------------
function Baixada.Check()
	local source = source
	local Passport = vRP.Passport(source)
	local Datatable = vRP.UserData(Passport, "Initial")
	if json.encode(Datatable) == "[]" then
		return true
	end
	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SAVE
-----------------------------------------------------------------------------------------------------------------------------------------
function Baixada.Save(Name)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		if vRP.UserData(Passport, "Initial") == 1 then
			TriggerClientEvent("Notify", source, "vermelho", "Você já escolheu o seu veículo inicial.", "Aviso", 5000)
		else
			vRP.Query("playerdata/SetData",{ Passport = Passport, Name = "Initial", Information = json.encode(1) })
			vRP.Query("vehicles/initialVehicles",{ Passport = Passport, vehicle = Name, plate = vRP.GeneratePlate(), work = "false" })

			local Identity = vRP.Identity(Passport)
			if Identity then
				if Identity["Sex"] == "M" then
					TriggerClientEvent("Notify", source, "azul", NotifyText, "Bem-vindo " .. Identity["Name"] .. " " .. Identity["Lastname"], 30000)
				elseif Identity["Sex"] == "F" then
					TriggerClientEvent("Notify", source, "azul", NotifyText, "Bem-vinda " .. Identity["Name"] .. " " .. Identity["Lastname"], 30000)
				end
			end
		end
	end
end