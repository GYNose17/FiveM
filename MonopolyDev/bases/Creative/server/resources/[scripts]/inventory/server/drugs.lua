-----------------------------------------------------------------------------------------------------------------------------------------
-- DRUGSINFLUENCES
-----------------------------------------------------------------------------------------------------------------------------------------
DrugsInfluences = {
	{ 1272.26, -1712.57, 54.76, 100 },
	{ 95.58, -1985.56, 20.44, 100 },
	{ -31.47, -1434.84, 31.49, 100 },
	{ 347.45, -2069.06, 20.89, 100 },
	{ 512.29, -1803.52, 28.51, 100 },
	{ 230.55, -1753.35, 28.98, 100 }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- LIST
-----------------------------------------------------------------------------------------------------------------------------------------
local List = {
	["weedsack"] = {
		["Price"] = { ["Min"] = 400, ["Max"] = 450 },
		["Amount"] = { ["Min"] = 1, ["Max"] = 1 }
	},
	["cokesack"] = {
		["Price"] = { ["Min"] = 400, ["Max"] = 450 },
		["Amount"] = { ["Min"] = 1, ["Max"] = 1 }
	},
	["methsack"] = {
		["Price"] = { ["Min"] = 1250, ["Max"] = 1500 },
		["Amount"] = { ["Min"] = 1, ["Max"] = 1 }
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKDRUGS
-----------------------------------------------------------------------------------------------------------------------------------------
function Baixada.CheckDrugs()
	local Return = false
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		for Item,v in pairs(List) do
			local Price = math.random(v["Price"]["Min"],v["Price"]["Max"])
			local Amount = math.random(v["Amount"]["Min"],v["Amount"]["Max"])

			if vRP.ConsultItem(Passport,Item,Amount) then
				Drugs[Passport] = { Item,Amount,Price * Amount }
				Return = true

				break
			end
		end
	end

	return Return
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PAYMENTDRUGS
-----------------------------------------------------------------------------------------------------------------------------------------
function Baixada.PaymentDrugs()
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and not Active[Passport] and Drugs[Passport] and vRP.TakeItem(Passport,Drugs[Passport][1],Drugs[Passport][2]) then
		Active[Passport] = true

		local Valuation = Drugs[Passport][3]
		if Buffs["Dexterity"][Passport] and Buffs["Dexterity"][Passport] > os.time() then
			Valuation = Valuation + (Valuation * 0.1)
		end

		local Ped = GetPlayerPed(source)
		local Coords = GetEntityCoords(Ped)
		for k,v in pairs(DrugsInfluences) do
			local Distance = #(Coords - vec3(v[1],v[2],v[3]))
			if Distance <= v[4] then
				Valuation = Valuation + (Valuation * 0.1)
			end
		end

		TriggerClientEvent("player:Residuals",source,"Resíduo Orgânico.")

		if math.random(100) >= 50 then
			vRP.GenerateItem(Passport,"dollars2",Valuation,true)
		else
			vRP.GenerateItem(Passport,"dollars3",Valuation,true)
		end

		if math.random(100) >= 70 then
			TriggerEvent("Wanted",source,Passport,60)

			local Coords = vRP.GetEntityCoords(source)
			local Service = vRP.NumPermission("Policia")
			for Passports,Sources in pairs(Service) do
				async(function()
					TriggerClientEvent("sounds:Private",Sources,"crime",0.25)
					TriggerClientEvent("NotifyPush",Sources,{ code = 20, title = "Venda de Drogas", x = Coords["x"], y = Coords["y"], z = Coords["z"], criminal = "Ligação Anônima", color = 16 })
				end)
			end
		end

		Active[Passport] = nil
		Drugs[Passport] = nil
	end
end