-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRPC = Tunnel.getInterface("vRP")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
Baixada = {}
Tunnel.bindInterface("trucker",Baixada)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Active = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- PAYMENT
-----------------------------------------------------------------------------------------------------------------------------------------
function Baixada.Payment()
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and not Active[Passport] then
		Active[Passport] = true

		local Coords = vRP.GetEntityCoords(source)
		if not vRPC.LastVehicle(source,"packer") or #(Coords - vec3(1256.59,-3239.63,5.17)) > 25 then
			exports["vrp"]:Embed("Payments","**Passaporte:** "..Passport.."\n**Função:** Payment do Trucker",0xa3c846)
		end

		local Experience = vRP.GetExperience(Passport,"Trucker")
		local Level = ClassCategory(Experience)
		local Valuation = math.random(1225,1525)

		if Level == 2 then
			Valuation = Valuation + 100
		elseif Level == 3 then
			Valuation = Valuation + 125
		elseif Level == 4 then
			Valuation = Valuation + 150
		elseif Level == 5 then
			Valuation = Valuation + 175
		elseif Level == 6 then
			Valuation = Valuation + 200
		elseif Level == 7 then
			Valuation = Valuation + 225
		elseif Level == 8 then
			Valuation = Valuation + 250
		elseif Level == 9 then
			Valuation = Valuation + 275
		elseif Level == 10 then
			Valuation = Valuation + 300
		end

		local Buffs = exports["inventory"]:Buffs("Dexterity",Passport)
		if Buffs and Buffs > os.time() then
			Valuation = Valuation + (Valuation * 0.1)
		end

		vRP.PaymentService(Passport,Valuation,true)
		vRP.PutExperience(Passport,"Trucker",math.random(3))

		Active[Passport] = nil
	end
end