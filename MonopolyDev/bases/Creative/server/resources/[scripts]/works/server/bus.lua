-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Active = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- PAYMENTBUS
-----------------------------------------------------------------------------------------------------------------------------------------
function BAIXADA.PaymentBus(Selected)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and not Active[Passport] and BusLocations[Selected] then
		Active[Passport] = true

		local Coords = vRP.GetEntityCoords(source)
		if not Selected or not vRPC.LastVehicle(source,"bus") or #(Coords - BusLocations[Selected]) > 25 then
			exports["vrp"]:Embed("Payments","**Passaporte:** "..Passport.."\n**Função:** Payment do Motorista",3092790)
		end

		local Experience = vRP.GetExperience(Passport,"Bus")
		local Level = ClassCategory(Experience)
		local Valuation = 115

		if Level == 2 or Level == 3 or Level == 5 then
			Valuation = Valuation + 20
		elseif Level == 6 or Level == 7 or Level == 8 then
			Valuation = Valuation + 40
		elseif Level == 9 or Level == 10 then
			Valuation = Valuation + 60
		end

		local Buffs = exports["inventory"]:Buffs("Dexterity",Passport)
		if Buffs and Buffs > os.time() then
			Valuation = Valuation + (Valuation * 0.1)
		end

		if exports["party"]:DoesExist(Passport) then
			local Members = exports["party"]:Room(Passport,source,20)
			if parseInt(#Members) >= 2 then
				Valuation = Valuation + (Valuation * 0.1)
			end
		end

		vRP.PaymentService(Passport,Valuation,true)
		vRP.PutExperience(Passport,"Bus",1)

		Active[Passport] = nil
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DISCONNECT
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("Disconnect",function(Passport,source)
	if Active[Passport] then
		Active[Passport] = nil
	end
end)