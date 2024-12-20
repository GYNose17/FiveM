-----------------------------------------------------------------------------------------------------------------------------------------
-- DEBUG
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("debug",function(source)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		if vRP.HasGroup(Passport,"Admin") then
			TriggerClientEvent("debug:Toggle",source)
		end
	end
end)-----------------------------------------------------------------------------------------------------------------------------------------
-- TARGET
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("target",function(source)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		if vRP.HasGroup(Passport,"Admin") then
			TriggerClientEvent("debug:Target",source)
		end
	end
end)