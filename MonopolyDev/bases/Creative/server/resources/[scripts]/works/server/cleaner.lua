-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Delay = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKPROPERTY
-----------------------------------------------------------------------------------------------------------------------------------------
function BAIXADA.CheckProperty(Number)
	local source = source
	if not Delay[Number] or Delay[Number] <= os.time() then
		Delay[Number] = os.time() + (15 * 60)
		return true
	else
		TriggerClientEvent("Notify", source, "azul", "Aguarde "..CompleteTimers(tonumber(Delay[Number]) - tonumber(os.time()))..".", false, 5000)
		return false
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PAYMENTHOUSE
-----------------------------------------------------------------------------------------------------------------------------------------
function BAIXADA.PaymentHouse(ServicesDone)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		local Completed = true
		for k,v in pairs(ServicesDone) do
			if not v then
				Completed = false
				break
			end
		end

		if Completed then
			local Experience = vRP.GetExperience(Passport,"Cleaner")
			local Level = ClassCategory(Experience)
			local Valuation = #ServicesDone * math.random(30, 60)

			if Level == 2 or Level == 3 or Level == 5 then
				Valuation = Valuation + 10
			elseif Level == 6 or Level == 7 or Level == 8 then
				Valuation = Valuation + 20
			elseif Level == 9 or Level == 10 then
				Valuation = Valuation + 30
			end

			local Buffs = exports["inventory"]:Buffs("Dexterity",Passport)
			if Buffs and Buffs > os.time() then
				Valuation = Valuation + (Valuation * 0.1)
			end
			vRP.PaymentService(Passport, Valuation, true)
			vRP.PutExperience(Passport, "Cleaner", 1)
		end
	end
end