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
Tunnel.bindInterface("races", Baixada)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Payments = {}
local RequiredItem = "credential"
-----------------------------------------------------------------------------------------------------------------------------------------
-- FINISH
-----------------------------------------------------------------------------------------------------------------------------------------
function Baixada.Finish(Number, Points)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		local vehName = vRPC.VehicleName(source)
		local Consult = vRP.Query("races/Result",{ Race = Number, Passport = Passport })

		if Payments[Passport] then
			local Rand = math.random(Races[Number]["Payment"][1], Races[Number]["Payment"][2])
			vRP.GenerateItem(Passport, "dollars", Rand, true)
			vRP.PutExperience(Passport, "Runner", 1)

			local Ranking = vRP.Query("races/TopFive",{ Race = Number })
			if Ranking[1] then
				if parseInt(Ranking[1]["Points"]) > parseInt(Points) then
					vRP.GenerateItem(Passport, "racetrophy", 1, true)
				end
			end

			exports["markers"]:Exit(source)
			Payments[Passport] = nil
		end

		if Consult[1] then
			if parseInt(Points) < parseInt(Consult[1]["Points"]) then
				vRP.Query("races/Records",{ Race = Number, Passport = Passport, Vehicle = VehicleName(vehName), Points = parseInt(Points) })
			end
		else
			vRP.Query("races/Insert",{ Race = Number, Passport = Passport, Name = vRP.FullName(Passport), Vehicle = VehicleName(vehName), Points = parseInt(Points) })
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- START
-----------------------------------------------------------------------------------------------------------------------------------------
function Baixada.Start(Number)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and Races[Number] then
		if not Races[Number]["Cooldown"][Passport] then
			Races[Number]["Cooldown"][Passport] = os.time()
		end

		if os.time() >= Races[Number]["Cooldown"][Passport] then
			Payments[Passport] = false

			if vRP.InventoryItemAmount(Passport, RequiredItem)[1] > 0 then
				if vRP.TakeItem(Passport, RequiredItem, 1) then
					exports["markers"]:Enter(source, "Corredor")

					Races[Number]["Cooldown"][Passport] = os.time() + 3600
					Payments[Passport] = true

					local Service = vRP.NumPermission("Policia")
					for Passports,Sources in pairs(Service) do
						async(function()
							TriggerClientEvent("Notify", Sources, "policia", "Encontramos um veículo participando de uma corrida clandestina e todos os policiais foram avisados.", "Circuitos", 5000)
							vRPC.PlaySound(Sources, "Beep_Red", "DLC_HEIST_HACKING_SNAKE_SOUNDS")
						end)
					end

					return Races[Number]["Explosive"]
				end
			end

			return false
		else
			local Cooldown = Races[Number]["Cooldown"][Passport] - os.time()
			TriggerClientEvent("Notify", source, "azul", "Aguarde <b>"..Cooldown.."</b> segundos.", "Circuitos", 5000)
		end
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- RANKING
-----------------------------------------------------------------------------------------------------------------------------------------
function Baixada.Ranking(Number)
	local Consult = vRP.Query("races/Ranking",{ Race = Number })
	return Consult
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CANCEL
-----------------------------------------------------------------------------------------------------------------------------------------
function Baixada.Cancel()
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		if Payments[Passport] then
			Payments[Passport] = nil
			exports["markers"]:Exit(source)
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DISCONNECT
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("Disconnect", function(Passport,source)
	if Payments[Passport] then
		Payments[Passport] = nil
		exports["markers"]:Exit(source)
	end
end)