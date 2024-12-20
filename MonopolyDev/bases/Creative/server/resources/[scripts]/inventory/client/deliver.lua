-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Blip = nil
local Worked = nil
local Progress = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- LIST
-----------------------------------------------------------------------------------------------------------------------------------------
List = {
	["Burgershot"] = {
		["Coords"] = vec3(-1198.08,-892.01,14.13),
		["Weight"] = { 0.15,1.0 },
		["Label"] = "ENTREGAR",
		["Route"] = false,
		["Locate"] = 1
	},
	["Lumberman"] = {
		["Coords"] = vec3(1961.61,5179.26,47.94),
		["Weight"] = { 0.5,1.0 },
		["Label"] = "ENTREGAR",
		["Route"] = false,
		["Locate"] = 1
	},
	["Transporter"] = {
		["Coords"] = vec3(264.74,219.99,101.67),
		["Weight"] = { 0.50,2.0 },
		["Label"] = "ENTREGAR",
		["Route"] = true,
		["Locate"] = 1
	},
	["Milkman"] = {
		["Coords"] = vec3(2435.82,4774.08,34.37),
		["Weight"] = { 0.50,2.0 },
		["Label"] = "ENTREGAR",
		["Route"] = false,
		["Locate"] = 1
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- LOCATIONS
-----------------------------------------------------------------------------------------------------------------------------------------
Locations = {
	["Burgershot"] = {
		vec3(-1335.86,-1146.8,6.72),
		vec3(-1349.7,-1161.59,4.5),
		vec3(-1108.31,-1527.15,6.77),
		vec3(-1084.41,-1559.2,4.79),
		vec3(-1076.91,-1553.97,4.63),
		vec3(-1065.98,-1545.79,4.9),
		vec3(-1057.75,-1540.66,5.04),
		vec3(-1027.64,-1575.52,5.27),
		vec3(-1041.56,-1590.46,4.99),
		vec3(-1032.02,-1620.15,5.11),
		vec3(-1023.52,-1614.4,5.09),
		vec3(-1088.21,-1230.76,2.91),
		vec3(-1095.5,-1219.22,2.68),
		vec3(-946.24,-1122.88,2.14),
		vec3(-1122.68,-1089.41,2.54),
		vec3(-1114.33,-1069.16,2.14),
		vec3(-1022.58,-896.9,5.41),
		vec3(-1031.2,-902.96,3.69),
		vec3(-1090.5,-926.55,3.10),
		vec3(-1489.92,-671.36,33.38),
		vec3(-1465.12,-639.62,33.38),
		vec3(-1452.38,-653.18,33.38),
		vec3(-1476.1,-671.67,33.38),
		vec3(-1498.11,-664.76,29.02),
		vec3(-1482.17,-652.11,29.57),
		vec3(-1458.98,-659.32,29.57),
		vec3(-1471.46,-668.4,29.57),
		vec3(-1710.6,-493.88,41.62),
		vec3(-1706.82,-453.41,42.65),
		vec3(-1698.21,-460.39,41.65),
		vec3(-1692.96,-464.72,41.65),
		vec3(-1699.91,-474.87,41.65),
		vec3(-1712.76,-477.2,41.65),
		vec3(-1714.15,-463.58,41.65),
		vec3(-1667.51,-441.27,40.36),
		vec3(-1643.05,-411.74,42.07),
		vec3(-1622.78,-379.81,43.71),
		vec3(-1543.01,-249.01,48.27),
		vec3(-1541.22,-276.61,48.27),
		vec3(-1582.53,-278.16,48.27),
		vec3(-1764.17,-707.8,10.62),
		vec3(-1777.06,-701.52,10.51),
		vec3(-1876.93,-584.47,11.85),
		vec3(-1883.32,-578.95,11.81),
		vec3(-1979.96,-520.06,11.88),
		vec3(-1967.76,-531.85,12.17),
		vec3(-1958.03,-538.37,11.9),
		vec3(-1913.56,-574.15,11.42),
		vec3(-1901.3,-586.28,11.86),
		vec3(-1477.1,-674.45,29.03)
	},
	["Lumberman"] = {
		vec3(-513.92,-1019.31,23.47),
		vec3(-1604.18,-832.26,10.08),
		vec3(-536.48,-45.61,42.57),
		vec3(-53.01,79.35,71.62),
		vec3(581.16,139.13,99.48),
		vec3(814.39,-93.48,80.6),
		vec3(1106.93,-355.03,67.01),
		vec3(1070.71,-780.46,58.36),
		vec3(1142.82,-986.58,45.91),
		vec3(1200.55,-1276.6,35.23),
		vec3(967.81,-1829.29,31.24),
		vec3(809.16,-2222.61,29.65),
		vec3(684.61,-2741.62,6.02),
		vec3(263.47,-2506.62,6.45),
		vec3(94.66,-2676.38,6.01),
		vec3(-43.87,-2519.91,7.4),
		vec3(182.93,-2027.68,18.28),
		vec3(-306.86,-2191.84,10.84),
		vec3(-570.95,-1775.95,23.19),
		vec3(-350.03,-1569.9,25.23),
		vec3(-128.36,-1394.12,29.57),
		vec3(67.84,-1399.02,29.37),
		vec3(343.13,-1297.91,32.51),
		vec3(485.92,-1477.41,29.29),
		vec3(139.81,-1337.41,29.21),
		vec3(263.82,-1346.16,31.93),
		vec3(-723.33,-1112.41,10.66),
		vec3(-842.54,-1128.21,7.02),
		vec3(488.46,-898.56,25.94)
	},
	["Transporter"] = {
		vec3(1166.96,-456.18,66.79),
		vec3(1138.25,-468.88,66.73),
		vec3(1077.72,-776.45,58.23),
		vec3(296.37,-894.21,29.22),
		vec3(295.68,-896.13,29.22),
		vec3(147.72,-1035.81,29.34),
		vec3(145.98,-1035.19,29.34),
		vec3(119.17,-883.6,31.12),
		vec3(112.81,-819.38,31.34),
		vec3(114.47,-776.49,31.41),
		vec3(111.26,-775.34,31.44),
		vec3(24.41,-946.06,29.35),
		vec3(5.23,-919.71,29.55),
		vec3(-203.73,-861.36,30.26),
		vec3(-301.66,-830.01,32.42),
		vec3(-303.34,-829.87,32.42),
		vec3(-710.13,-819.0,23.72),
		vec3(-712.86,-819.01,23.72),
		vec3(-821.53,-1081.91,11.12),
		vec3(-1109.76,-1690.72,4.36),
		vec3(-1314.83,-836.08,16.95),
		vec3(-1315.78,-834.69,16.95),
		vec3(-1305.4,-706.25,25.33),
		vec3(-1569.98,-546.48,34.95),
		vec3(-1571.22,-547.41,34.95),
		vec3(-2072.45,-317.28,13.31),
		vec3(-2975.11,380.01,15.0),
		vec3(-2958.96,487.79,15.47),
		vec3(-2956.77,487.73,15.47),
		vec3(-3144.32,1127.46,20.86),
		vec3(-3240.64,1008.62,12.82),
		vec3(-3241.18,997.56,12.55),
		vec3(-3044.0,594.65,7.73),
		vec3(-3040.74,593.06,7.9),
		vec3(-1410.23,-98.82,52.44),
		vec3(-1409.7,-100.41,52.39),
		vec3(-1430.08,-211.08,46.51),
		vec3(-1415.96,-211.88,46.51),
		vec3(-1289.28,-226.69,42.44),
		vec3(-1285.67,-224.32,42.44),
		vec3(-1286.12,-213.6,42.44),
		vec3(-1282.62,-210.94,42.44),
		vec3(-1205.7,-324.75,37.86),
		vec3(-1204.87,-326.34,37.83),
		vec3(-846.13,-341.41,38.67),
		vec3(-846.75,-340.19,38.67),
		vec3(-866.61,-187.68,37.83),
		vec3(-867.61,-186.07,37.84),
		vec3(-165.07,234.78,94.91),
		vec3(-165.05,232.69,94.91),
		vec3(89.71,2.37,68.31),
		vec3(285.49,143.41,104.17),
		vec3(380.85,323.44,103.56),
		vec3(228.3,338.44,105.56)
	},
	["Milkman"] = {
		vec3(1662.03,4776.11,42.34),
		vec3(1663.84,4739.69,42.01),
		vec3(1719.09,4677.13,43.66),
		vec3(1682.81,4689.61,43.07),
		vec3(1673.64,4658.21,43.41),
		vec3(1725.47,4642.58,43.88)
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADSTART
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	for Name,v in pairs(List) do
		exports["target"]:AddCircleZone("Deliver:"..Name,v["Coords"],v["Weight"][1],{
			name = "Deliver:"..Name,
			heading = 0.0,
			useZ = true
		},{
			shop = Name,
			Distance = v["Weight"][2],
			options = {
				{
					event = "deliver:Init",
					tunnel = "shop",
					label = "Trabalhar"
				}
			}
		})
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DRAWTEXT3D
-----------------------------------------------------------------------------------------------------------------------------------------
local function DrawText3D(Coords,Text)
	local onScreen,x,y = World3dToScreen2d(Coords["x"],Coords["y"],Coords["z"])

	if onScreen then
		SetTextFont(4)
		SetTextCentre(true)
		SetTextProportional(1)
		SetTextScale(0.35,0.35)
		SetTextColour(200,200,200,200)

		SetTextEntry("STRING")
		AddTextComponentString(Text)
		EndTextCommandDisplayText(x,y)

		local Width = string.len(Text) / 350
		DrawRect(x,y + 0.0125,Width,0.03,15,15,15,200)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- BLIPMARKERSERVICE
-----------------------------------------------------------------------------------------------------------------------------------------
local function BlipMarkerService()
	if Blip and DoesBlipExist(Blip) then
		RemoveBlip(Blip)
		Blip = nil
	end

	if Worked then
		local Selected = List[Worked]["Locate"]
		local Coords = Locations[Worked][Selected]
		Blip = AddBlipForCoord(Coords["x"],Coords["y"],Coords["z"])
		SetBlipSprite(Blip,1)
		SetBlipColour(Blip,77)
		SetBlipScale(Blip,0.5)
		SetBlipRoute(Blip,true)
		SetBlipAsShortRange(Blip,true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString("Entrega")
		EndTextCommandSetBlipName(Blip)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DELIVER:INIT
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("deliver:Init",function(Service)
	if Locations[Service] then
		local Permission = List[Service]["Permission"]
		if Permission and not LocalPlayer["state"][Permission] then
			return false
		end

		if Progress then
			Worked = nil
			Progress = false
			TriggerEvent("Notify","amarelo","Trabalho finalizado.","Atenção",5000)

			for Name,_ in pairs(List) do
				exports["target"]:LabelText("Deliver:"..Name,"Trabalhar")
			end

			if Blip and DoesBlipExist(Blip) then
				RemoveBlip(Blip)
				Blip = nil
			end
		else
			Progress = true
			Worked = Service
			BlipMarkerService()
			TriggerEvent("Notify","verde","Trabalho iniciado.","Sucesso",5000)

			for Name,_ in pairs(List) do
				exports["target"]:LabelText("Deliver:"..Name,"Finalizar")
			end

			while Progress do
				local TimeDistance = 999
				local Ped = PlayerPedId()
				if not IsPedInAnyVehicle(Ped) then
					local Coords = GetEntityCoords(Ped)
					local Selected = List[Worked]["Locate"]
					local Distance = #(Coords - Locations[Worked][Selected])

					if Distance <= 10.0 then
						TimeDistance = 1
						DrawText3D(Locations[Worked][Selected],"~g~G~w~   "..List[Worked]["Label"])

						if Distance <= 1.0 and IsControlJustPressed(1,47) and vSERVER.Deliver(Worked) then
							if List[Worked]["Route"] then
								if Selected >= #Locations[Worked] then
									List[Worked]["Locate"] = 1
								else
									List[Worked]["Locate"] = List[Worked]["Locate"] + 1
								end
							else
								List[Worked]["Locate"] = math.random(#Locations[Worked])
							end

							BlipMarkerService()
						end
					end
				end

				Wait(TimeDistance)
			end
		end
	end
end)