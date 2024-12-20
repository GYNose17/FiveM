local Blip = nil
local Selected = 1
local Active = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- LOCATIONS
-----------------------------------------------------------------------------------------------------------------------------------------
Locations = {
	vec3(413.87,-573.13,28.75),
	vec3(743.77,-81.13,56.26),
	vec3(1263.59,544.75,80.79),
	vec3(1516.82,848.37,77.1),
	vec3(1723.68,1556.02,84.57),
	vec3(1907.65,2404.3,54.54),
	vec3(2375.93,2828.99,44.64),
	vec3(2337.51,2978.25,48.17),
	vec3(2270.01,3145.05,48.56),
	vec3(1940.04,3312.56,45.34),
	vec3(1750.37,3414.64,38.06),
	vec3(1572.66,3717.62,34.49),
	vec3(1825.98,3944.52,33.3),
	vec3(2027.33,3781.79,32.28),
	vec3(2233.9,3819.68,33.99),
	vec3(2474.15,4165.52,37.46),
	vec3(2473.75,4538.34,35.01),
	vec3(2653.23,4808.08,33.65),
	vec3(2762.88,4982.85,33.95),
	vec3(2630.59,5112.64,44.79),
	vec3(2323.11,5205.29,59.82),
	vec3(2009.71,5167.9,47.53),
	vec3(1763.23,5013.45,52.5),
	vec3(1696.5,4680.26,43.08),
	vec3(2062.48,4683.54,41.16),
	vec3(2485.55,4468.09,35.15),
	vec3(2470.62,4043.54,37.54),
	vec3(1916.95,3636.9,33.8),
	vec3(1126.81,3536.68,34.71),
	vec3(871.14,3633.41,32.94),
	vec3(411.28,3537.83,34.02),
	vec3(219.37,3255.51,41.69),
	vec3(191.99,2932.75,44.74),
	vec3(-335.98,2886.61,44.75),
	vec3(-539.07,2750.93,40.78),
	vec3(-714.73,2374.99,65.83),
	vec3(-762.4,1990.7,129.93),
	vec3(-847.02,1783.93,173.18),
	vec3(-781.89,1526.26,223.92),
	vec3(-706.12,926.41,233.82),
	vec3(-1063.93,787.3,166.27),
	vec3(-1426.77,494.54,112.83),
	vec3(-1079.96,313.32,65.39),
	vec3(-881.38,-129.85,37.93),
	vec3(-812.07,-340.31,37.02),
	vec3(-916.6,-526.79,35.62),
	vec3(-859.29,-717.27,26.25),
	vec3(-901.7,-883.64,15.59),
	vec3(-803.65,-836.84,20.59),
	vec3(-799.0,-1073.94,11.54),
	vec3(-665.7,-1515.21,12.05),
	vec3(-453.3,-1776.88,20.62),
	vec3(-207.4,-1809.73,29.91),
	vec3(130.17,-1820.8,27.06),
	vec3(-180.87,-2186.07,10.31),
	vec3(-68.96,-1969.1,17.56),
	vec3(-206.87,-1809.15,29.91),
	vec3(-36.69,-1820.95,26.29),
	vec3(109.73,-1845.34,25.43),
	vec3(309.29,-1901.76,26.42),
	vec3(278.71,-2123.67,15.87),
	vec3(453.28,-2102.33,21.74),
	vec3(422.63,-1871.74,26.84),
	vec3(501.74,-1734.14,29.1),
	vec3(387.79,-1560.14,29.3),
	vec3(203.65,-1344.34,29.28),
	vec3(373.48,-1286.72,32.45),
	vec3(500.91,-1099.79,29.15),
	vec3(486.02,-677.07,25.93)
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- BUS:INIT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("bus:Init")
AddEventHandler("bus:Init",function()
	if Active then
		if DoesBlipExist(Blip) then
			RemoveBlip(Blip)
			Blip = nil
		end

		exports["target"]:LabelText("WorkBus","Trabalhar")
		TriggerEvent("Notify","amarelo","Trabalho finalizado.","Atenção",5000)
		Active = false
	else
		exports["target"]:LabelText("WorkBus","Finalizar")
		TriggerEvent("Notify","verde","Trabalho iniciado.","Sucesso",5000)
		Active = true
		MakeBlips()
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADACTIVE
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		local TimeDistance = 999
		if Active then
			local Ped = PlayerPedId()
			if IsPedInAnyVehicle(Ped) then
				local Vehicle = GetVehiclePedIsUsing(Ped)
				if GetEntityArchetypeName(Vehicle) == "bus" then
					local Coords = GetEntityCoords(Ped)
					local Distance = #(Coords - Locations[Selected])

					if Distance <= 200 then
						TimeDistance = 1

						DrawMarker(22,Locations[Selected]["x"],Locations[Selected]["y"],Locations[Selected]["z"] + 3.0,0.0,0.0,0.0,0.0,180.0,0.0,7.5,7.5,5.0,65,130,226,100,0,0,0,1)
						DrawMarker(1,Locations[Selected]["x"],Locations[Selected]["y"],Locations[Selected]["z"] - 3.0,0.0,0.0,0.0,0.0,0.0,0.0,15.0,15.0,10.0,255,255,255,50,0,0,0,0)

						if Distance <= 10 then
							BAIXADA_SERVER.PaymentBus(Selected)

							if Selected >= #Locations then
								Selected = 1
							else
								Selected = Selected + 1
							end

							MakeBlips()
						end
					end
				end
			end
		end

		Wait(TimeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- MAKEBLIPS
-----------------------------------------------------------------------------------------------------------------------------------------
function MakeBlips()
	if DoesBlipExist(Blip) then
		RemoveBlip(Blip)
		Blip = nil
	end

	Blip = AddBlipForCoord(Locations[Selected]["x"],Locations[Selected]["y"],Locations[Selected]["z"])
	SetBlipSprite(Blip,1)
	SetBlipDisplay(Blip,4)
	SetBlipAsShortRange(Blip,true)
	SetBlipColour(Blip,77)
	SetBlipScale(Blip,0.75)
	SetBlipRoute(Blip,true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("Motorista")
	EndTextCommandSetBlipName(Blip)
end