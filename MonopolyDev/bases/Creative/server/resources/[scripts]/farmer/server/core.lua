-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRPC = Tunnel.getInterface("vRP")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Itens = {}
local Active = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- GLOBALSTATE
-----------------------------------------------------------------------------------------------------------------------------------------
for Number,v in pairs(Objects) do
	GlobalState["Farmer:"..Number] = 0

	if v["Event"] == "farmer:Minerman" then
		local Rand = math.random(#Minerman)
		GlobalState["FarmerObjects:"..Number] = Minerman[Rand]["Model"]
		Itens[Number] = Minerman[Rand]["Item"]
	else
		GlobalState["FarmerObjects:"..Number] = v["Model"]
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- MINERMAN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("farmer:Minerman")
AddEventHandler("farmer:Minerman",function(Number)
	local Tasks = 8
	local source = source
	local Detectable = false
	local Passport = vRP.Passport(source)
	if Passport and not Active[Passport] then
		if not Number or type(Number) == "table" then
			exports["vrp"]:Embed("Payments","**Passaporte:** "..Passport.."\n**Função:** Payment do Farmer",3092790)
			Active[Passport] = true

			return false
		end

		if GlobalState["Farmer:"..Number] and GlobalState["Work"] >= GlobalState["Farmer:"..Number] then
			Active[Passport] = true

			if vRP.ConsultItem(Passport,"WEAPON_PICKAXE",1) then
				Detectable = "WEAPON_PICKAXE"
			end

			if vRP.ConsultItem(Passport,"WEAPON_PICKAXE_PLUS",1) then
				Detectable = "WEAPON_PICKAXE_PLUS"
				Tasks = 5
			end

			if Detectable then
				local Valuation = math.random(2,3)
				if (vRP.InventoryWeight(Passport) + itemWeight(Itens[Number]) * Valuation) <= vRP.GetWeight(Passport) then
					vRPC.CreateObjects(source,"melee@large_wpn@streamed_core","ground_attack_on_spot","prop_tool_pickaxe",1,18905,0.10,-0.1,0.0,-92.0,260.0,5.0)
					Player(source)["state"]["Buttons"] = true
					Player(source)["state"]["Cancel"] = true

					if vRP.Task(source,Tasks,15000) then
						if GlobalState["Work"] >= GlobalState["Farmer:"..Number] then
							GlobalState["Farmer:"..Number] = GlobalState["Work"] + math.random(36,48)

							local Experience = vRP.GetExperience(Passport,"Minerman")
							local Level = ClassCategory(Experience)

							if Level == 3 or Level == 4 or Level == 5 then
								Valuation = Valuation + 1
							elseif Level == 6 or Level == 7 or Level == 8 then
								Valuation = Valuation + 2
							elseif Level == 9 or Level == 10 then
								Valuation = Valuation + 3
							end

							if exports["party"]:DoesExist(Passport) then
								local Members = exports["party"]:Room(Passport,source,20)
								if parseInt(#Members) >= 2 then
									Valuation = Valuation + #Members
								end
							end

							local Buffs = exports["inventory"]:Buffs("Luck",Passport)
							if Buffs and Buffs > os.time() and math.random(100) >= 75 then
								Valuation = Valuation * 2
							end

							vRP.GenerateItem(Passport,Itens[Number],Valuation,true)
							vRP.PutExperience(Passport,"Minerman",1)
							vRP.UpgradeStress(Passport,1)

							local Rand = math.random(#Minerman)
							GlobalState["FarmerObjects:"..Number] = Minerman[Rand]["Model"]
							Itens[Number] = Minerman[Rand]["Item"]
						end
					end

					Player(source)["state"]["Buttons"] = false
					Player(source)["state"]["Cancel"] = false
					vRPC.Destroy(source)
				else
					TriggerClientEvent("Notify",source,"vermelho","Mochila cheia.","Aviso",5000)
				end
			else
				TriggerClientEvent("Notify",source,"vermelho","<b>Picareta</b> não encontrada.","Aviso",5000)
			end

			Active[Passport] = nil
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FRUITMAN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("farmer:Fruitman")
AddEventHandler("farmer:Fruitman",function(Number)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and not Active[Passport] then
		if not Number or type(Number) == "table" then
			exports["vrp"]:Embed("Payments","**Passaporte:** "..Passport.."\n**Função:** Payment do Farmer",3092790)
			Active[Passport] = true

			return false
		end

		if GlobalState["Farmer:"..Number] and GlobalState["Work"] >= GlobalState["Farmer:"..Number] then
			Active[Passport] = true

			local Ped = GetPlayerPed(source)
			if DoesEntityExist(Ped) and GetSelectedPedWeapon(Ped) == GetHashKey("WEAPON_HATCHET") then
				local Items = { "acerola","banana","guarana","tomato","passion","grape","tange","orange","apple","strawberry","coffee2" }
				local Select = math.random(#Items)
				local Valuation = math.random(3,5)
				if (vRP.InventoryWeight(Passport) + itemWeight(Items[Select]) * Valuation) <= vRP.GetWeight(Passport) then
					vRPC.PlayAnim(source,false,{"lumberjackaxe@idle","idle"},true)
					TriggerClientEvent("Progress",source,"Colhendo",11000)
					Player(source)["state"]["Buttons"] = true
					Player(source)["state"]["Cancel"] = true
					local timeProgress = 10

					repeat
						if timeProgress ~= 10 then
							Wait(400)
						end

						Wait(700)
						TriggerClientEvent("sounds:Private",source,"lumberman",0.1)
						timeProgress = timeProgress - 1
					until timeProgress <= 0

					Wait(400)

					if GlobalState["Work"] >= GlobalState["Farmer:"..Number] then
						GlobalState["Farmer:"..Number] = GlobalState["Work"] + 30

						local Experience = vRP.GetExperience(Passport,"Fruitman")
						local Level = ClassCategory(Experience)

						if Level == 3 or Level == 4 or Level == 5 then
							Valuation = Valuation + 1
						elseif Level == 6 or Level == 7 or Level == 8 then
							Valuation = Valuation + 2
						elseif Level == 9 or Level == 10 then
							Valuation = Valuation + 3
						end

						if exports["party"]:DoesExist(Passport) then
							local Members = exports["party"]:Room(Passport,source,20)
							if parseInt(#Members) >= 2 then
								Valuation = Valuation + #Members
							end
						end

						local Buffs = exports["inventory"]:Buffs("Luck",Passport)
						if Buffs and Buffs > os.time() and math.random(100) >= 90 then
							Valuation = Valuation * 2
						end

						vRP.GenerateItem(Passport,Items[Select],Valuation,true)
						vRP.PutExperience(Passport,"Fruitman",1)
						vRP.UpgradeStress(Passport,1)
					end

					Player(source)["state"]["Buttons"] = false
					Player(source)["state"]["Cancel"] = false
					vRPC.Destroy(source)
				else
					TriggerClientEvent("Notify",source,"vermelho","Mochila cheia.","Aviso",5000)
				end
			else
				TriggerClientEvent("Notify",source,"vermelho","<b>"..itemName("WEAPON_HATCHET").."</b> não encontrado.","Aviso",5000)
			end

			Active[Passport] = nil
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- LUMBERMAN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("farmer:Lumberman")
AddEventHandler("farmer:Lumberman",function(Number)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and not Active[Passport] then
		if not Number or type(Number) == "table" then
			exports["vrp"]:Embed("Payments","**Passaporte:** "..Passport.."\n**Função:** Payment do Farmer",3092790)
			Active[Passport] = true

			return false
		end

		if GlobalState["Farmer:"..Number] and GlobalState["Work"] >= GlobalState["Farmer:"..Number] then
			Active[Passport] = true

			local Ped = GetPlayerPed(source)
			if DoesEntityExist(Ped) and GetSelectedPedWeapon(Ped) == GetHashKey("WEAPON_HATCHET") then
				local Valuation = math.random(3,5)
				if (vRP.InventoryWeight(Passport) + itemWeight("woodlog") * Valuation) <= vRP.GetWeight(Passport) then
					vRPC.PlayAnim(source,false,{"lumberjackaxe@idle","idle"},true)
					TriggerClientEvent("Progress",source,"Cortando",11000)
					Player(source)["state"]["Buttons"] = true
					Player(source)["state"]["Cancel"] = true
					local timeProgress = 10

					repeat
						if timeProgress ~= 10 then
							Wait(400)
						end

						Wait(700)
						TriggerClientEvent("sounds:Private",source,"lumberman",0.1)
						timeProgress = timeProgress - 1
					until timeProgress <= 0

					Wait(400)

					if GlobalState["Work"] >= GlobalState["Farmer:"..Number] then
						GlobalState["Farmer:"..Number] = GlobalState["Work"] + 30

						local Buffs = exports["inventory"]:Buffs("Luck",Passport)
						if Buffs and Buffs > os.time() and math.random(100) >= 90 then
							Valuation = Valuation * 2
						end

						vRP.GenerateItem(Passport,"woodlog",Valuation,true)
						vRP.UpgradeStress(Passport,1)
					end

					Player(source)["state"]["Buttons"] = false
					Player(source)["state"]["Cancel"] = false
					vRPC.Destroy(source)
				else
					TriggerClientEvent("Notify",source,"vermelho","Mochila cheia.","Aviso",5000)
				end
			else
				TriggerClientEvent("Notify",source,"vermelho","<b>"..itemName("WEAPON_HATCHET").."</b> não encontrado.","Aviso",5000)
			end

			Active[Passport] = nil
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TRANSPORTER
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("farmer:Transporter")
AddEventHandler("farmer:Transporter",function(Number)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and not Active[Passport] then
		if not Number or type(Number) == "table" then
			exports["vrp"]:Embed("Payments","**Passaporte:** "..Passport.."\n**Função:** Payment do Farmer",3092790)
			Active[Passport] = true

			return false
		end

		if GlobalState["Farmer:"..Number] and GlobalState["Work"] >= GlobalState["Farmer:"..Number] then
			Active[Passport] = true

			if (vRP.InventoryWeight(Passport) + itemWeight("pouch")) <= vRP.GetWeight(Passport) then
				vRPC.PlayAnim(source,false,{"pickup_object","pickup_low"},true)
				TriggerClientEvent("Progress",source,"Coletando",1000)
				Player(source)["state"]["Buttons"] = true
				Player(source)["state"]["Cancel"] = true

				Wait(1000)

				if GlobalState["Work"] >= GlobalState["Farmer:"..Number] then
					GlobalState["Farmer:"..Number] = GlobalState["Work"] + 6

					local Valuation = 1

					local Buffs = exports["inventory"]:Buffs("Luck",Passport)
					if Buffs and Buffs > os.time() and math.random(100) >= 90 then
						Valuation = Valuation * 2
					end

					vRP.GenerateItem(Passport,"pouch",Valuation,true)
					vRP.UpgradeStress(Passport,1)
				end

				Player(source)["state"]["Buttons"] = false
				Player(source)["state"]["Cancel"] = false
				vRPC.Destroy(source)
			else
				TriggerClientEvent("Notify",source,"vermelho","Mochila cheia.","Aviso",5000)
			end

			Active[Passport] = nil
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DIVER
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("farmer:Diver")
AddEventHandler("farmer:Diver",function(Number)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and not Active[Passport] then
		if not Number or type(Number) == "table" then
			exports["vrp"]:Embed("Payments","**Passaporte:** "..Passport.."\n**Função:** Payment do Farmer",3092790)
			Active[Passport] = true

			return false
		end

		if GlobalState["Farmer:"..Number] and GlobalState["Work"] >= GlobalState["Farmer:"..Number] then
			Active[Passport] = true

			if (vRP.InventoryWeight(Passport) + itemWeight("woodenbarrel")) <= vRP.GetWeight(Passport) then
				vRPC.PlayAnim(source,false,{"anim@amb@clubhouse@tutorial@bkr_tut_ig3@","machinic_loop_mechandplayer" },true)
				TriggerClientEvent("Progress",source,"Coletando",30000)
				Player(source)["state"]["Buttons"] = true
				Player(source)["state"]["Cancel"] = true

				Wait(30000)

				if GlobalState["Work"] >= GlobalState["Farmer:"..Number] then
					GlobalState["Farmer:"..Number] = GlobalState["Work"] + math.random(15,30)

					local Valuation = 1
					local Buffs = exports["inventory"]:Buffs("Luck",Passport)
					if Buffs and Buffs > os.time() and math.random(100) >= 90 then
						Valuation = Valuation * 2
					end

					vRP.GenerateItem(Passport,"woodenbarrel",Valuation,true)
					vRP.PutExperience(Passport,"Diver",1)
					vRP.UpgradeStress(Passport,math.random(2,4))
				end

				Player(source)["state"]["Buttons"] = false
				Player(source)["state"]["Cancel"] = false
				vRPC.Destroy(source)
			else
				TriggerClientEvent("Notify",source,"vermelho","Mochila cheia.","Aviso",5000)
			end

			Active[Passport] = nil
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DISCONNECT
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("Disconnect",function(Passport,source)
	if Active[Passport] then
		Active[Passport] = nil
	end
end)