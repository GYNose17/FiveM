-----------------------------------------------------------------------------------------------------------------------------------------
-- PAYMENTTAXI
-----------------------------------------------------------------------------------------------------------------------------------------
function BAIXADA.PaymentTaxi()
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		local Experience = vRP.GetExperience(Passport,"Taxi")
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

		vRP.PaymentService(Passport,Valuation,true)
		vRP.PutExperience(Passport,"Taxi",1)
		vRP.UpgradeStress(Passport,2)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PERMISSIONTAXI
-----------------------------------------------------------------------------------------------------------------------------------------
function BAIXADA.PermissionTaxi(Status)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		if Status then
			Player(source)["state"]["Taxi"] = true
		else
			Player(source)["state"]["Taxi"] = false
		end
	end

	return true
end