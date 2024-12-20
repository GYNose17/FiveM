-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRPS = Tunnel.getInterface("vRP")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
Baixada = {}
Tunnel.bindInterface("hud",Baixada)
vSERVER = Tunnel.getInterface("hud")
-----------------------------------------------------------------------------------------------------------------------------------------
-- GLOBAL
-----------------------------------------------------------------------------------------------------------------------------------------
Display = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Hood = false
local Gemstone = 0
local Pause = false
local Road = "Alta Street"
local Crossing = "Alta Street"
-----------------------------------------------------------------------------------------------------------------------------------------
-- PRINCIPAL
-----------------------------------------------------------------------------------------------------------------------------------------
local Health = 999
local Armour = 999
-----------------------------------------------------------------------------------------------------------------------------------------
-- THIRST
-----------------------------------------------------------------------------------------------------------------------------------------
local Thirst = 999
local ThirstTimer = 0
local ThirstAmount = 90000
local ThirstDelay = GetGameTimer()
-----------------------------------------------------------------------------------------------------------------------------------------
-- HUNGER
-----------------------------------------------------------------------------------------------------------------------------------------
local Hunger = 999
local HungerTimer = 0
local HungerAmount = 90000
local HungerDelay = GetGameTimer()
-----------------------------------------------------------------------------------------------------------------------------------------
-- STRESS
-----------------------------------------------------------------------------------------------------------------------------------------
local Stress = 999
local StressTimer = 0
-----------------------------------------------------------------------------------------------------------------------------------------
-- COUGH
-----------------------------------------------------------------------------------------------------------------------------------------
local Cough = 999
local CoughTimer = 0
-----------------------------------------------------------------------------------------------------------------------------------------
-- WANTED
-----------------------------------------------------------------------------------------------------------------------------------------
local Wanted = 0
local WantedTimer = 0
-----------------------------------------------------------------------------------------------------------------------------------------
-- REPOSED
-----------------------------------------------------------------------------------------------------------------------------------------
local Reposed = 0
local ReposedTimer = 0
-----------------------------------------------------------------------------------------------------------------------------------------
-- LUCK
-----------------------------------------------------------------------------------------------------------------------------------------
local Luck = 0
local LuckTimer = 0
-----------------------------------------------------------------------------------------------------------------------------------------
-- DEXTERITY
-----------------------------------------------------------------------------------------------------------------------------------------
local Dexterity = 0
local DexterityTimer = 0
-----------------------------------------------------------------------------------------------------------------------------------------
-- OXYGEN
-----------------------------------------------------------------------------------------------------------------------------------------
Mask = nil
Tank = nil
Oxygen = 100
OxygenTimers = GetGameTimer()
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADTIMER
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		if LocalPlayer["state"]["Active"] then
			local Ped = PlayerPedId()

			if IsPauseMenuActive() then
				if not Pause and Display then
					SendNUIMessage({ Action = "Body", Status = false })
					Pause = true
				end
			else
				if Display then
					if Pause then
						SendNUIMessage({ Action = "Body", Status = true })
						Pause = false
					end

					local Coords = GetEntityCoords(Ped)
					local Armouring = GetPedArmour(Ped)
					local Healing = GetEntityHealth(Ped) - 100
					local MinRoad,MinCross = GetStreetNameAtCoord(Coords["x"],Coords["y"],Coords["z"])
					local FullRoad = GetStreetNameFromHashKey(MinRoad)
					local FullCross = GetStreetNameFromHashKey(MinCross)

					if Health ~= Healing then
						if Healing < 0 then
							Healing = 0
						end

						SendNUIMessage({ Action = "Health", Number = Healing })
						Health = Healing
					end

					if Armour ~= Armouring then
						SendNUIMessage({ Action = "Armour", Number = Armouring })
						Armour = Armouring
					end

					if FullRoad ~= "" and Road ~= FullRoad then
						SendNUIMessage({ Action = "Road", Name = FullRoad })
						Road = FullRoad
					end

					if FullCross ~= "" and Crossing ~= FullCross then
						SendNUIMessage({ Action = "Crossing", Name = FullCross })
						Crossing = FullCross
					end

					SendNUIMessage({ Action = "Clock", Hours = GlobalState["Hours"], Minutes = GlobalState["Minutes"] })

					SendNUIMessage({ Action = "Temperature", Temperature = GlobalState["Temperature"] })
				end
			end

			if Luck > 0 and LuckTimer <= GetGameTimer() then
				Luck = Luck - 1
				LuckTimer = GetGameTimer() + 1000
			end

			if Dexterity > 0 and DexterityTimer <= GetGameTimer() then
				Dexterity = Dexterity - 1
				DexterityTimer = GetGameTimer() + 1000
			end

			if Wanted > 0 and WantedTimer <= GetGameTimer() then
				Wanted = Wanted - 1
				WantedTimer = GetGameTimer() + 1000
				SendNUIMessage({ Action = "Wanted", Number = Wanted })
			end

			if Reposed > 0 and ReposedTimer <= GetGameTimer() then
				Reposed = Reposed - 1
				ReposedTimer = GetGameTimer() + 1000
				SendNUIMessage({ Action = "Reposed", Number = Reposed })
			end

			if GetEntityHealth(Ped) > 100 then
				if Hunger < 15 and HungerTimer <= GetGameTimer() then
					HungerTimer = GetGameTimer() + 10000
					ApplyDamageToPed(Ped, math.random(2), false)
					TriggerEvent("Notify", "fome", "Sofrendo com a fome.", false, 2500)
				end

				if Thirst < 15 and ThirstTimer <= GetGameTimer() then
					ThirstTimer = GetGameTimer() + 10000
					ApplyDamageToPed(Ped, math.random(2), false)
					TriggerEvent("Notify", "sede", "Sofrendo com a sede.", false, 2500)
				end

				if Stress >= 40 and StressTimer <= GetGameTimer() then
					StressTimer = GetGameTimer() + 10000
					TriggerEvent("Notify", "roxo", "Sofrendo com o estresse.", false, 2500)

					AnimpostfxPlay("MenuMGIn")
					SetTimeout(1500, function()
						AnimpostfxStop("MenuMGIn")
					end)
				end
				
				if Cough >= 20 and CoughTimer <= GetGameTimer() then
					CoughTimer = GetGameTimer() + 30000
					ApplyDamageToPed(Ped, math.random(2), false)
					TriggerEvent("Notify", "amarelo", "Sofrendo com a tosse.", false, 2500)

					vRP.PlayAnim(true, { "timetable@gardener@smoking_joint", "idle_cough" }, true)
					SetTimeout(4000, function()
						vRP.Destroy("one")
						vSERVER.GetCough(math.random(3, 6))
					end)
				end

				if Oxygen <= 0 and OxygenTimer <= GetGameTimer() then
					OxygenTimer = GetGameTimer() + 30000
					ApplyDamageToPed(Ped, math.random(15,30), false)
					TriggerEvent("Notify", "amarelo", "Sofrendo com a falta de <b>Oxigênio</b>.", "Oxigênio", 2500)
				end
			end
		end

		Wait(1000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HUD:PASSPORT
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("hud:Passport",function(Number)
	SendNUIMessage({ Action = "Passport", Number = Number })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADDSTATEBAGCHANGEHANDLER
-----------------------------------------------------------------------------------------------------------------------------------------
AddStateBagChangeHandler("Safezone", ("player:%s"):format(LocalPlayer["state"]["Player"]), function(Name, Key, Value)
	SendNUIMessage({ Action = "Safe", Status = Value })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HUD:VOIP
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("hud:Voip",function(Number)
	local Target = { "BAIXO","NORMAL","MEDIO","ALTO","MEGAFONE" }

	SendNUIMessage({ Action = "Voip", Voip = Target[Number] })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HUD:VOICE
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("hud:Voice",function(Status)
	SendNUIMessage({ Action = "Voice", Status = Status and "#00bc7e" or "#FFFFFF" })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HUD:WANTED
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("hud:Wanted")
AddEventHandler("hud:Wanted",function(Seconds)
	Wanted = Seconds
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- WANTED
-----------------------------------------------------------------------------------------------------------------------------------------
exports("Wanted", function()
	return Wanted > 0 and true or false
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HUD:REPOSED
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("hud:Reposed")
AddEventHandler("hud:Reposed",function(Seconds)
	Reposed = Seconds
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REPOSED
-----------------------------------------------------------------------------------------------------------------------------------------
exports("Reposed",function()
	return Reposed > 0 and true or false
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HUD:ACTIVE
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("hud:Active",function(Status)
	SendNUIMessage({ Action = "Body", Status = Status })
	Display = Status
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HUD
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("hud",function()
	Display = not Display
	SendNUIMessage({ Action = "Body", Status = Display })

	if not Display then
		if IsMinimapRendering() then
			DisplayRadar(false)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PROGRESS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("Progress")
AddEventHandler("Progress",function(Message,Timer)
	SendNUIMessage({ Action = "Progress", Message = Message, Timer = Timer })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- MUMBLECONNECTED
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("mumbleConnected",function()
	SendNUIMessage({ Action = "Voip", Voip = "Online" })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- MUMBLEDISCONNECTED
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("mumbleDisconnected",function()
	SendNUIMessage({ Action = "Voip", Voip = "Offline" })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HUD:THIRST
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("hud:Thirst")
AddEventHandler("hud:Thirst",function(Number)
	if Thirst ~= Number then
		SendNUIMessage({ Action = "Thirst", Number = Number })
		Thirst = Number
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HUD:HUNGER
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("hud:Hunger")
AddEventHandler("hud:Hunger",function(Number)
	if Hunger ~= Number then
		SendNUIMessage({ Action = "Hunger", Number = Number })
		Hunger = Number
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HUD:STRESS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("hud:Stress")
AddEventHandler("hud:Stress",function(Number)
	if Stress ~= Number then
		SendNUIMessage({ Action = "Stress", Number = Number })
		Stress = Number
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HUD:COUGH
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("hud:Cough")
AddEventHandler("hud:Cough", function(Number)
	if Cough ~= Number then
		SendNUIMessage({ Action = "Cough", Number = Number })
		Cough = Number
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HUD:OXYGEN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("hud:Oxygen")
AddEventHandler("hud:Oxygen", function(Number)
	SendNUIMessage({ Action = "Oxygen", Number = Number })
	Oxygen = Number
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HUD:LUCK
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("hud:Luck")
AddEventHandler("hud:Luck",function(Seconds)
	Luck = Seconds
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HUD:DEXTERITY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("hud:Dexterity")
AddEventHandler("hud:Dexterity",function(Seconds)
	Dexterity = Seconds
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HUD:ADDGEMSTONE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("hud:AddGemstone")
AddEventHandler("hud:AddGemstone",function(Number)
	Gemstone = Gemstone + Number

	SendNUIMessage({ Action = "Gemstone", Number = Gemstone })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HUD:REMOVEGEMSTONE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("hud:RemoveGemstone")
AddEventHandler("hud:RemoveGemstone",function(Number)
	Gemstone = Gemstone - Number

	if Gemstone < 0 then
		Gemstone = 0
	end

	SendNUIMessage({ Action = "Gemstone", Number = Gemstone })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HUD:RADIO
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("hud:Radio",function(Frequency)
	if type(Frequency) == "number" then
		SendNUIMessage({ Action = "Frequency", Frequency = Frequency })
	else
		SendNUIMessage({ Action = "Frequency", Frequency = Frequency })
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HEALTH
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("Health",function()
	Health = 999
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HUNGER
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("Hunger",function(Value)
	HungerAmount = Value
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THIRST
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("Thirst",function(Value)
	ThirstAmount = Value
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HUD:HOOD
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("hud:Hood")
AddEventHandler("hud:Hood",function()
	if Hood then
		DoScreenFadeIn(0)
		Hood = false
	else
		DoScreenFadeOut(0)
		Hood = true
	end
end)