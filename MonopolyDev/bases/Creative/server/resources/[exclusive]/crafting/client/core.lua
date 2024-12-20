-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp", "lib/Tunnel")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
vSERVER = Tunnel.getInterface("crafting")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Select = ""
local Active = nil
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADSTART
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	for Number = 1, #Crafting do
		exports["target"]:AddCircleZone("Crafting:" .. Number, Crafting[Number][1], 0.5, {
			name = "Crafting:" .. Number,
			heading = 0.0,
			useZ = true
		}, {
			shop = Number,
			Distance = 1.0,
			options = {
				{
					event = "crafting:Open",
					label = "Abrir",
					tunnel = "shop"
				}
			}
		})
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLOSE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Close", function(Data, Callback)
	SetNuiFocus(false, false)

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- OWNED
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Owned", function(Data, Callback)
	Callback(vSERVER.Owned(Data["id"], Data["key"]))
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CANCEL
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Cancel", function(Data, Callback)
	Active = nil

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CRAFTING
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Crafting", function(Data, Callback)
	if not Active then
		Active = GetGameTimer() + Data["time"] * 1000
		Callback(true)

		repeat
			if Active and GetGameTimer() >= Active then
				Active = nil
				vSERVER.Crafting(Data["id"], Data["key"], Data["amount"])
			end

			Wait(100)
		until not Active
	else
		TriggerEvent("Notify", "azul", "Produção em andamento.", false, 5000)
		Callback(false)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CRAFTING:OPEN
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("crafting:Open", function(Number)
	if Crafting[Number] then
		if not vSERVER.Permission(Crafting[Number][2]) then
			return
		end
		
		if Crafting[Number][2] ~= Select and Active and GetGameTimer() < Active then
			TriggerEvent("Notify", "azul", "Produção em andamento.", false, 5000)
			return
		end

		SetNuiFocus(true, true)
		Select = Crafting[Number][2]
		SendNUIMessage({ action = "OpenCraft", data = vSERVER.Request(Select) })
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CRAFTING:PRODUCTION
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("crafting:Production", function(Number, Mode)
	if Mode ~= Select and Active and GetGameTimer() < Active then
		TriggerEvent("Notify", "azul", "Produção em andamento.", false, 5000)

		return false
	end

	if vSERVER.Permission(Mode) then
		Select = Mode
		SetNuiFocus(true, true)
		SendNUIMessage({ action = "OpenCraft", data = vSERVER.Request(Select) })
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CRAFTING:PHARMACY
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("crafting:Pharmacy", function()
	if not vSERVER.Permission("Pharmacy") and not exports["hud"]:Wanted() then
		return
	end
	
	if "Pharmacy" ~= Select and Active and GetGameTimer() < Active then
		TriggerEvent("Notify", "azul", "Produção em andamento.", false, 5000)
		return
	end

	SetNuiFocus(true, true)
	Select = "Pharmacy"
	SendNUIMessage({ action = "OpenCraft", data = vSERVER.Request(Select) })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CRAFTING:MINERMAN
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("crafting:Minerman", function()
	if not vSERVER.Permission("Mining") and not exports["hud"]:Wanted() then
		return
	end
	
	if "Mining" ~= Select and Active and GetGameTimer() < Active then
		TriggerEvent("Notify", "azul", "Produção em andamento.", false, 5000)
		return
	end

	SetNuiFocus(true, true)
	Select = "Mining"
	SendNUIMessage({ action = "OpenCraft", data = vSERVER.Request(Select) })
end)
