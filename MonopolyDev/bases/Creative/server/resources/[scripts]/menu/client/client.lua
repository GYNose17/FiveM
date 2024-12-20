-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- OPEN
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	local Tables = {}
	for  _, v in pairs(Restaurants) do
		Tables[#Tables + 1] = { v["Coords"][1], v["Coords"][2], v["Coords"][3],2.0,"E","Cardápio","Pressione para abrir" }
	end
	TriggerEvent("hoverfy:Insert",Tables)

	while true do
		local Ped = PlayerPedId()
		local PlayerCoord = GetEntityCoords(Ped)
		local Sleep = 1000
		for _, v in pairs(Restaurants) do
			local Distance = GetDistanceBetweenCoords(v["Coords"][1], v["Coords"][2], v["Coords"][3],
				PlayerCoord[1], PlayerCoord[2], PlayerCoord[3])
			if Distance < 2.0 then
				Sleep = 3
				if IsControlJustReleased(0, 38) then
					TransitionToBlurred(100)
					SetNuiFocus(true, true)
					SendNUIMessage({ action = "Open", payload = v["Image"] })
					if not IsPedInAnyVehicle(Ped) then
						vRP.Destroy()
						vRP.CreateObjects("amb@code_human_in_bus_passenger_idles@female@tablet@base", "base",
							"prop_cs_tablet", 50, 28422)
					end
				end
			end
		end
		Wait(Sleep)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLOSE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Close", function(data)
	SetNuiFocus(false, false)
	SendNUIMessage({ action = "Close" })
	TransitionFromBlurred(100)
	vRP.Destroy()
end)
