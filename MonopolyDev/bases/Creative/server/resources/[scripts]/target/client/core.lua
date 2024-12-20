-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
vSERVER = Tunnel.getInterface("target")
vPLAYER = Tunnel.getInterface("player")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Zones = {}
local Models = {}
local Selected = {}
local Sucess = false
local Dismantleds = 1
local FreezeDismantle = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- DISMANTLE
-----------------------------------------------------------------------------------------------------------------------------------------
local Dismantle = {
	vec3(943.23, -1497.87, 30.11),
	vec3(-1172.57, -2037.65, 13.75),
	vec3(-524.94, -1680.63, 19.21),
	vec3(1358.14, -2095.41, 52.0),
	vec3(602.47, -437.82, 24.75),
	vec3(-413.86, -2179.29, 10.31),
	vec3(146.51, 320.62, 112.14),
	vec3(520.91, 169.14, 99.36),
	vec3(1137.99, -794.32, 57.59),
	vec3(-93.07, -2549.6, 6.0),
	vec3(820.07, -488.43, 30.46),
	vec3(1078.62, -2325.56, 30.25),
	vec3(1204.69, -3116.71, 5.50)
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- TARGET:DISMANTLES
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("target:Dismantles")
AddEventHandler("target:Dismantles", function()
	if not FreezeDismantle then
		FreezeDismantle = true
		Dismantleds = math.random(#Dismantle)
		TriggerEvent("NotifyPush", { code = 20, title = "Localização do Desmanche", x = Dismantle[Dismantleds]["x"], y = Dismantle[Dismantleds]["y"], z = Dismantle[Dismantleds]["z"], text = "Você pode me entregar o veículo ou também pode guardar na garagem para você usar por algum tempo.", blipColor = 60 })
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TARGET:DISMANTLERESET
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("target:DismantleReset")
AddEventHandler("target:DismantleReset", function()
	FreezeDismantle = false

	local Backup = Dismantleds
	repeat
		Dismantleds = math.random(#Dismantle)
	until Backup ~= Dismantleds
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TYRELIST
-----------------------------------------------------------------------------------------------------------------------------------------
local tyreList = {
	["wheel_lf"] = 0,
	["wheel_rf"] = 1,
	["wheel_lm"] = 2,
	["wheel_rm"] = 3,
	["wheel_lr"] = 4,
	["wheel_rr"] = 5
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- TYRES
-----------------------------------------------------------------------------------------------------------------------------------------
local Tyres = {
	["wheel_lf"] = 0,
	["wheel_rf"] = 1,
	["wheel_lm"] = 2,
	["wheel_rm"] = 3,
	["wheel_lr"] = 4,
	["wheel_rr"] = 5
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- FUELS
-----------------------------------------------------------------------------------------------------------------------------------------
local Fuels = {
	vec3(273.83, -1253.46, 28.29),
	vec3(273.83, -1261.29, 28.29),
	vec3(273.83, -1268.63, 28.29),
	vec3(265.06, -1253.46, 28.29),
	vec3(265.06, -1261.29, 28.29),
	vec3(265.06, -1268.63, 28.29),
	vec3(256.43, -1253.46, 28.29),
	vec3(256.43, -1261.29, 28.29),
	vec3(256.43, -1268.63, 28.29),
	vec3(2680.90, 3266.40, 54.39),
	vec3(2678.51, 3262.33, 54.39),
	vec3(-2104.53, -311.01, 12.16),
	vec3(-2105.39, -319.21, 12.16),
	vec3(-2106.06, -325.57, 12.16),
	vec3(-2097.48, -326.48, 12.16),
	vec3(-2096.81, -320.11, 12.16),
	vec3(-2096.09, -311.90, 12.16),
	vec3(-2087.21, -312.81, 12.16),
	vec3(-2088.08, -321.03, 12.16),
	vec3(-2088.75, -327.39, 12.16),
	vec3(-2551.39, 2327.11, 32.24),
	vec3(-2558.02, 2326.70, 32.24),
	vec3(-2558.48, 2334.13, 32.24),
	vec3(-2552.60, 2334.46, 32.24),
	vec3(-2558.77, 2341.48, 32.24),
	vec3(-2552.39, 2341.89, 32.24),
	vec3(186.97, 6606.21, 31.06),
	vec3(179.67, 6604.93, 31.06),
	vec3(172.33, 6603.63, 31.06),
	vec3(818.99, -1026.24, 25.44),
	vec3(810.7, -1026.24, 25.44),
	vec3(810.7, -1030.94, 25.44),
	vec3(818.99, -1030.94, 25.44),
	vec3(818.99, -1026.24, 25.44),
	vec3(827.3, -1026.24, 25.64),
	vec3(827.3, -1030.94, 25.64),
	vec3(1207.07, -1398.16, 34.39),
	vec3(1204.2, -1401.03, 34.39),
	vec3(1210.07, -1406.9, 34.39),
	vec3(1212.94, -1404.03, 34.39),
	vec3(1178.97, -339.54, 68.37),
	vec3(1186.4, -338.23, 68.36),
	vec3(1184.89, -329.7, 68.31),
	vec3(1177.46, -331.01, 68.32),
	vec3(1175.71, -322.3, 68.36),
	vec3(1183.13, -320.99, 68.36),
	vec3(629.64, 263.84, 102.27),
	vec3(629.64, 273.97, 102.27),
	vec3(620.99, 273.97, 102.27),
	vec3(621.0, 263.84, 102.27),
	vec3(612.44, 263.84, 102.27),
	vec3(612.43, 273.96, 102.27),
	vec3(2588.41, 358.56, 107.66),
	vec3(2588.65, 364.06, 107.66),
	vec3(2581.18, 364.39, 107.66),
	vec3(2580.94, 358.89, 107.66),
	vec3(2573.55, 359.21, 107.66),
	vec3(2573.79, 364.71, 107.66),
	vec3(174.99, -1568.44, 28.33),
	vec3(181.81, -1561.96, 28.33),
	vec3(176.03, -1555.91, 28.33),
	vec3(169.3, -1562.26, 28.33),
	vec3(-329.81, -1471.63, 29.73),
	vec3(-324.74, -1480.41, 29.73),
	vec3(-317.26, -1476.09, 29.73),
	vec3(-322.33, -1467.31, 29.73),
	vec3(-314.92, -1463.03, 29.73),
	vec3(-309.85, -1471.79, 29.73),
	vec3(1786.08, 3329.86, 40.42),
	vec3(1785.04, 3331.48, 40.35),
	vec3(50.31, 2778.54, 57.05),
	vec3(48.92, 2779.59, 57.05),
	vec3(264.98, 2607.18, 43.99),
	vec3(263.09, 2606.8, 43.99),
	vec3(1035.45, 2674.44, 38.71),
	vec3(1043.22, 2674.45, 38.71),
	vec3(1043.22, 2667.92, 38.71),
	vec3(1035.45, 2667.91, 38.71),
	vec3(1209.59, 2658.36, 36.9),
	vec3(1208.52, 2659.43, 36.9),
	vec3(1205.91, 2662.05, 36.9),
	vec3(2539.8, 2594.81, 36.96),
	vec3(2001.55, 3772.21, 31.4),
	vec3(2003.92, 3773.48, 31.4),
	vec3(2006.21, 3774.96, 31.4),
	vec3(2009.26, 3776.78, 31.4),
	vec3(1684.6, 4931.66, 41.23),
	vec3(1690.1, 4927.81, 41.23),
	vec3(1705.74, 6414.61, 31.77),
	vec3(1701.73, 6416.49, 31.77),
	vec3(1697.76, 6418.35, 31.77),
	vec3(-97.06, 6416.77, 30.65),
	vec3(-91.29, 6422.54, 30.65),
	vec3(-1808.71, 799.96, 137.69),
	vec3(-1803.62, 794.4, 137.69),
	vec3(-1797.22, 800.56, 137.66),
	vec3(-1802.31, 806.12, 137.66),
	vec3(-1795.93, 811.97, 137.7),
	vec3(-1790.83, 806.41, 137.7),
	vec3(-1438.07, -268.69, 45.41),
	vec3(-1444.5, -274.23, 45.41),
	vec3(-1435.5, -284.68, 45.41),
	vec3(-1429.07, -279.15, 45.41),
	vec3(-732.64, -932.51, 18.22),
	vec3(-732.64, -939.32, 18.22),
	vec3(-724.0, -939.32, 18.22),
	vec3(-724.0, -932.51, 18.22),
	vec3(-715.43, -932.51, 18.22),
	vec3(-715.43, -939.32, 18.22),
	vec3(-532.28, -1212.71, 17.33),
	vec3(-529.51, -1213.96, 17.33),
	vec3(-524.92, -1216.15, 17.33),
	vec3(-522.23, -1217.42, 17.33),
	vec3(-518.52, -1209.5, 17.33),
	vec3(-521.21, -1208.23, 17.33),
	vec3(-525.8, -1206.04, 17.33),
	vec3(-528.57, -1204.8, 17.33),
	vec3(-72.03, -1765.1, 28.53),
	vec3(-69.45, -1758.01, 28.55),
	vec3(-77.59, -1755.05, 28.81),
	vec3(-80.17, -1762.14, 28.8),
	vec3(-63.61, -1767.93, 28.27),
	vec3(-61.03, -1760.85, 28.31)
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADSTART
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	RegisterCommand("+entityTarget", TargetEnable)
	RegisterCommand("-entityTarget", TargetDisable)
	RegisterKeyMapping("+entityTarget", "Interação auricular.", "keyboard", "LMENU")

	AddCircleZone("Autoschool", vec3(216.08, -1389.87, 30.58), 0.50, {
		name = "Autoschool",
		heading = 0.0
	}, {
		Distance = 2.0,
		options = {
			{
				event = "autoschool:start",
				label = "Solicitar Habilitação",
				tunnel = "client"
			}
		}
	})

	AddCircleZone("Laundry01", vec3(1136.01, -992.07, 46.46), 0.2, {
		name = "Laundry01",
		heading = 0.0,
		useZ = true
	}, {
		Distance = 1.0,
		options = {
			{
				event = "inventory:MakeProducts",
				label = "Usar Máquina",
				tunnel = "products",
				service = "laundry"
			}
		}
	})

	AddCircleZone("Laundry02", vec3(1135.83, -990.69, 46.4), 0.2, {
		name = "Laundry02",
		heading = 0.0,
		useZ = true
	}, {
		Distance = 1.0,
		options = {
			{
				event = "inventory:MakeProducts",
				label = "Usar Máquina",
				tunnel = "products",
				service = "laundry"
			}
		}
	})

	AddCircleZone("Laundry03", vec3(1135.65, -989.39, 46.47), 0.2, {
		name = "Laundry03",
		heading = 0.0,
		useZ = true
	}, {
		Distance = 1.0,
		options = {
			{
				event = "inventory:MakeProducts",
				label = "Usar Máquina",
				tunnel = "products",
				service = "laundry"
			}
		}
	})

	AddCircleZone("Laundry04", vec3(1135.49, -988.15, 46.34), 0.2, {
		name = "Laundry04",
		heading = 0.0,
		useZ = true
	}, {
		Distance = 1.0,
		options = {
			{
				event = "inventory:MakeProducts",
				label = "Usar Máquina",
				tunnel = "products",
				service = "laundry"
			}
		}
	})

	AddCircleZone("Prison", vec3(1690.5, 2529.67, 45.56), 0.5, {
		name = "Prison",
		heading = 0.0
	}, {
		Distance = 0.75,
		options = {
			{
				event = "police:Scape",
				label = "Escapar",
				tunnel = "server"
			}
		}
	})

	AddCircleZone("Electricity", vec3(2101.75, 2322.74, 94.53), 0.5, {
		name = "Electricity",
		heading = 0.0
	}, {
		Distance = 0.75,
		options = {
			{
				event = "inventory:Electricity",
				label = "Sabotar",
				tunnel = "server"
			}
		}
	})

	AddBoxZone("WorkPostman", vec3(-424.36, -2789.78, 6.52), 0.5, 0.5, {
		name = "WorkPostman",
		heading = 0.0,
		minZ = 6.52 - 0.75,
		maxZ = 6.52 + 0.75
	}, {
		Distance = 1.0,
		options = {
			{
				event = "postop:Init",
				label = "Trabalhar",
				tunnel = "client"
			}
		}
	})

	AddBoxZone("WorkCleaner", vec3(-1275.5, -1139.56, 6.79), 0.5, 0.5, {
		name = "WorkCleaner",
		heading = 266.46,
		minZ = 6.79 - 0.75,
		maxZ = 6.79 + 0.75
	}, {
		Distance = 1.0,
		options = {
			{
				event = "cleaner:Init",
				label = "Trabalhar",
				tunnel = "client"
			}
		}
	})

	AddBoxZone("WorkBus", vec3(453.47, -602.34, 28.59), 0.5, 0.5, {
		name = "WorkBus",
		heading = 266.46,
		minZ = 28.59 - 0.75,
		maxZ = 28.59 + 0.75
	}, {
		Distance = 1.0,
		options = {
			{
				event = "bus:Init",
				label = "Trabalhar",
				tunnel = "client"
			}
		}
	})

	AddBoxZone("WorkTaxi", vec3(894.97, -179.14, 74.7), 0.5, 0.5, {
		name = "WorkTaxi",
		heading = 331.66,
		minZ = 74.7 - 0.75,
		maxZ = 74.7 + 0.75
	}, {
		Distance = 1.0,
		options = {
			{
				event = "taxi:Init",
				label = "Trabalhar",
				tunnel = "client"
			}
		}
	})

	AddCircleZone("BurgershotJuice", vec3(-1189.86, -904.94, 14.42), 0.2, {
		name = "BurgershotJuice",
		heading = 0.0,
		useZ = true
	}, {
		Distance = 1.25,
		options = {
			{
				event = "inventory:MakeProducts",
				label = "Encher Copo",
				tunnel = "products",
				service = "foodjuice"
			}
		}
	})

	AddCircleZone("BurgershotBurger", vec3(-1196.42, -904.34, 14.17), 0.2, {
		name = "BurgershotBurger",
		heading = 0.0,
		useZ = true
	}, {
		Distance = 1.0,
		options = {
			{
				event = "inventory:MakeProducts",
				label = "Montar Lanche",
				tunnel = "products",
				service = "foodburger"
			}
		}
	})

	AddCircleZone("BurgershotBox", vec3(-1191.29,-906.4,14.4), 0.2, {
		name = "BurgershotBox",
		heading = 0.0,
		useZ = true
	}, {
		Distance = 1.25,
		options = {
			{
				event = "inventory:MakeProducts",
				label = "Montar Combo",
				tunnel = "products",
				service = "foodbox"
			}, {
				event = "inventory:MakeProducts",
				label = "Montar Combo com Brinquedo",
				tunnel = "products",
				service = "foodboxtoy"
			}
		}
	})

	AddCircleZone("CallWorks01", vec3(-1190.22, -902.49, 14.34), 0.20, {
		name = "CallWorks01",
		heading = 0.0,
		useZ = true
	}, {
		Distance = 1.25,
		options = {
			{
				event = "target:Announces",
				label = "Anunciar",
				tunnel = "proserver",
				service = "Burgershot"
			}
		}
	})

	AddBoxZone("CallWorks02", vec3(311.83, -593.31, 43.08), 0.25, 0.25, {
		name = "CallWorks02",
		heading = 0.0,
		minZ = 43.00,
		maxZ = 43.25
	}, {
		Distance = 1.25,
		options = {
			{
				event = "target:Medicplan",
				label = "Plano de Saúde",
				tunnel = "server"
			}, {
				event = "target:Announces",
				label = "Anunciar",
				tunnel = "proserver",
				service = "Paramedico"
			}
		}
	})

	AddTargetModel({ 858993389, 2913180574 }, {
		options = {
			{
				event = "inventory:ObjectsVerify",
				label = "Roubar Frutas",
				tunnel = "shop",
				service = "Fruits"
			}
		},
		Distance = 1.0
	})

	AddTargetModel({ 1281992692, 1158960338, 1511539537, -78626473, -429560270 }, {
		options = {
			{
				event = "target:Call",
				label = "Ligar para Delegacia",
				tunnel = "proserver",
				service = "Policia"
			}, {
				event = "target:Call",
				label = "Ligar para Hospital",
				tunnel = "proserver",
				service = "Paramedico"
			}
		},
		Distance = 1.0
	})

	AddTargetModel({ -1207886863, 568309711, 200010599, 1888301071, 1677473970, 323971301 }, {
		options = {
			{
				event = "inventory:ObjectsVerify",
				label = "Procurar Petróleo",
				tunnel = "shop",
				service = "Pumpjack"
			}
		},
		Distance = 1.0
	})

	AddTargetModel({ -2007231801, 1339433404, 1694452750, 1933174915, -462817101, -469694731, -164877493, 486135101 }, {
		options = {
			{
				event = "shops:BuyGasoline",
				label = "Comprar Combustível",
				tunnel = "server"
			}, {
				event = "inventory:ObjectsVerify",
				label = "Roubar Combustível",
				tunnel = "shop",
				service = "Gasoline"
			}, {
				event = "shops:SellOil",
				label = "Vender Petróleo",
				tunnel = "server"
			}
		},
		Distance = 0.75
	})

	AddTargetModel({ 654385216, 161343630, -430989390, 1096374064, -1519644200, -1932041857, 207578973, -487222358 }, {
		options = {
			{
				event = "slotmachine:Init",
				label = "Sentar",
				tunnel = "client"
			}
		},
		Distance = 0.75
	})

	AddTargetModel({ -1691644768, -742198632 }, {
		options = {
			{
				event = "inventory:MakeProducts",
				label = "Encher",
				tunnel = "products",
				service = "emptybottle"
			},
			{
				event = "inventory:Drink",
				label = "Beber",
				tunnel = "server"
			}
		},
		Distance = 0.75
	})

	AddTargetModel({ 200846641, -97646180, -366155374 }, {
		options = {
			{
				event = "inventory:MakeProducts",
				label = "Encher",
				tunnel = "products",
				service = "emptybottle"
			},
		},
		Distance = 0.75
	})

	AddTargetModel({ 690372739 }, {
		options = {
			{
				event = "shops:Coffee",
				label = "Comprar",
				tunnel = "client"
			}
		},
		Distance = 1.25
	})

	AddTargetModel({ -654402915, 1421582485 }, {
		options = {
			{
				event = "shops:Donut",
				label = "Comprar",
				tunnel = "client"
			}
		},
		Distance = 1.25
	})

	AddTargetModel({ 992069095, 1114264700 }, {
		options = {
			{
				event = "shops:Soda",
				label = "Comprar",
				tunnel = "client"
			}
		},
		Distance = 1.25
	})

	AddTargetModel({ 1129053052 }, {
		options = {
			{
				event = "shops:Hamburger",
				label = "Comprar",
				tunnel = "client"
			}
		},
		Distance = 1.25
	})

	AddTargetModel({ -1581502570 }, {
		options = {
			{
				event = "shops:Hotdog",
				label = "Comprar",
				tunnel = "client"
			}
		},
		Distance = 1.25
	})

	AddTargetModel({ 73774428 }, {
		options = {
			{
				event = "shops:Cigarette",
				label = "Comprar",
				tunnel = "client"
			}
		},
		Distance = 1.25
	})

	AddTargetModel({ -272361894 }, {
		options = {
			{
				event = "shops:Chihuahua",
				label = "Comprar",
				tunnel = "client"
			}
		},
		Distance = 1.0
	})

	AddTargetModel({ 1099892058 }, {
		options = {
			{
				event = "shops:Water",
				label = "Comprar",
				tunnel = "client"
			}
		},
		Distance = 1.0
	})

	AddTargetModel({ 1711856655, -1672689514, -1951226014 }, {
		options = {
			{
				event = "inventory:ObjectsVerify",
				label = "Vasculhar",
				tunnel = "shop",
				service = "Bricks"
			}
		},
		Distance = 1.0
	})

	AddTargetModel({ -1940238623, 2108567945 }, {
		options = {
			{
				event = "inventory:ObjectsVerify",
				label = "Vasculhar",
				tunnel = "shop",
				service = "Parkimeter"
			}
		},
		Distance = 0.75
	})

	AddTargetModel(
	{ -832573324, -1430839454, 1457690978, 1682622302, 402729631, -664053099, 307287994, -1323586730,
		111281960, -541762431, -745300483, -417505688 }, {
		options = {
			{
				event = "inventory:Animals",
				label = "Esfolar",
				tunnel = "shop"
			}
		},
		Distance = 1.25
	})

	AddTargetModel(
	{ 684586828, 577432224, -1587184881, -1426008804, -228596739, 1437508529, -1096777189, -468629664, 1143474856,
		-2096124444, -115771139, 1329570871, -130812911 }, {
		options = {
			{
				event = "inventory:ObjectsVerify",
				label = "Vasculhar",
				tunnel = "shop",
				service = "Lixeiro"
			}
		},
		Distance = 0.75
	})

	AddTargetModel({ -206690185, 666561306, 218085040, -58485588, 1511880420, 682791951 }, {
		options = {
			{
				event = "inventory:ObjectsVerify",
				label = "Vasculhar",
				tunnel = "shop",
				service = "Lixeiro"
			}, {
				event = "player:enterTrash",
				label = "Esconder",
				tunnel = "client"
			}, {
				event = "player:checkTrash",
				label = "Verificar",
				tunnel = "server"
			}, {
				event = "chest:Open",
				label = "Abrir",
				tunnel = "entity",
				service = "Custom"
			}
		},
		Distance = 0.75
	})

	AddTargetModel(
	{ 1898296526, 1069797899, 1434516869, -896997473, -1748303324, -1366478936, 2090224559, -52638650, 591265130,
		-915224107, -273279397, 322493792, 10106915, 1120812170 }, {
		options = {
			{
				event = "inventory:ObjectsVerify",
				label = "Vasculhar",
				tunnel = "shop",
				service = "CarWreck"
			}
		},
		Distance = 1.00
	})

	AddCircleZone("Dealership01", vec3(-56.94, -1098.77, 26.42), 0.55, {
		name = "Dealership01",
		heading = 0.0
	}, {
		shop = "Santos",
		Distance = 1.5,
		options = {
			{
				event = "pdm:Open",
				label = "Abrir",
				tunnel = "shop"
			}
		}
	})

	AddCircleZone("Dealership02", vec3(1224.78, 2728.01, 38.0), 0.5, {
		name = "Dealership02",
		heading = 0.0
	}, {
		shop = "Sandy",
		Distance = 2.0,
		options = {
			{
				event = "pdm:Open",
				label = "Abrir",
				tunnel = "shop"
			}
		}
	})

	AddCircleZone("Yoga01", vec3(-492.83, -217.31, 35.61), 0.5, {
		name = "Yoga01",
		heading = 0.0
	}, {
		Distance = 1.25,
		options = {
			{
				event = "player:Yoga",
				label = "Yoga",
				tunnel = "client"
			}
		}
	})

	AddCircleZone("Yoga02", vec3(-492.87, -219.03, 36.55), 0.5, {
		name = "Yoga02",
		heading = 0.0
	}, {
		Distance = 1.25,
		options = {
			{
				event = "player:Yoga",
				label = "Yoga",
				tunnel = "client"
			}
		}
	})

	AddCircleZone("Yoga03", vec3(-492.89, -220.68, 36.51), 0.5, {
		name = "Yoga03",
		heading = 0.0
	}, {
		Distance = 1.25,
		options = {
			{
				event = "player:Yoga",
				label = "Yoga",
				tunnel = "client"
			}
		}
	})

	AddCircleZone("Yoga04", vec3(-490.21, -220.91, 36.51), 0.5, {
		name = "Yoga04",
		heading = 0.0
	}, {
		Distance = 1.25,
		options = {
			{
				event = "player:Yoga",
				label = "Yoga",
				tunnel = "client"
			}
		}
	})

	AddCircleZone("Yoga05", vec3(-490.18, -219.24, 36.58), 0.5, {
		name = "Yoga05",
		heading = 0.0
	}, {
		Distance = 1.25,
		options = {
			{
				event = "player:Yoga",
				label = "Yoga",
				tunnel = "client"
			}
		}
	})

	AddCircleZone("Yoga06", vec3(-490.16, -217.33, 36.63), 0.5, {
		name = "Yoga06",
		heading = 0.0
	}, {
		Distance = 1.25,
		options = {
			{
				event = "player:Yoga",
				label = "Yoga",
				tunnel = "client"
			}
		}
	})

	AddCircleZone("Cemitery", vec3(-1745.57, -205.19, 57.37), 0.5, {
		name = "Cemitery",
		heading = 0.0
	}, {
		Distance = 1.0,
		options = {
			{
				event = "cemitery:initBody",
				label = "Conversar",
				tunnel = "client"
			}
		}
	})

	AddCircleZone("CassinoWheel", vec3(988.37, 43.06, 71.3), 0.5, {
		name = "CassinoWheel",
		heading = 0.0
	}, {
		Distance = 1.5,
		options = {
			{
				event = "luckywheel:Target",
				label = "Roda da Fortuna",
				tunnel = "client"
			}
		}
	})

	AddTargetModel({ 1211559620, 1363150739, -1186769817, 261193082, -756152956, -1383056703, 720581693 }, {
		options = {
			{
				event = "inventory:ObjectsVerify",
				label = "Vasculhar",
				tunnel = "shop",
				service = "Jornaleiro"
			}
		},
		Distance = 0.75
	})

	AddTargetModel({ 1363150739 }, {
		options = {
			{
				event = "inventory:SendLetter",
				label = "Enviar Carta",
				tunnel = "server"
			}
		},
		Distance = 0.75
	})
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TARGETENABLE
-----------------------------------------------------------------------------------------------------------------------------------------
function TargetEnable()
	if LocalPlayer["state"]["Active"] and not IsPauseMenuActive() then
		local Ped = PlayerPedId()
		if (not LocalPlayer["state"]["Admin"] and LocalPlayer["state"]["Charizard"]) or LocalPlayer["state"]["Camera"] or LocalPlayer["state"]["Freecam"] or LocalPlayer["state"]["Carry"] or not MumbleIsConnected() or LocalPlayer["state"]["Buttons"] or LocalPlayer["state"]["Commands"] or LocalPlayer["state"]["Handcuff"] or Sucess or IsPedArmed(Ped,6) or IsPedInAnyVehicle(Ped) then
			return
		end

		SendNUIMessage({ Action = "Open" })
		LocalPlayer["state"]:set("Target",true,false)

		while LocalPlayer["state"]["Target"] do
			local hitZone, entCoords, Entity = RayCastGamePlayCamera()

			if hitZone == 1 then
				local Coords = GetEntityCoords(Ped)

				for k, v in pairs(Zones) do
					if Zones[k]:isPointInside(entCoords) then
						if #(Coords - Zones[k]["center"]) <= v["targetoptions"]["Distance"] then
							if v["targetoptions"]["shop"] ~= nil then
								Selected = v["targetoptions"]["shop"]
							end

							SendNUIMessage({ Action = "Valid", data = Zones[k]["targetoptions"]["options"] })

							Sucess = true
							while Sucess do
								local Ped = PlayerPedId()
								local Coords = GetEntityCoords(Ped)
								local _, entCoords = RayCastGamePlayCamera()

								if (IsControlJustReleased(1, 24) or IsDisabledControlJustReleased(1, 24)) then
									SetCursorLocation(0.5, 0.5)
									SetNuiFocus(true, true)
								end

								if not Zones[k]:isPointInside(entCoords) or #(Coords - Zones[k]["center"]) > v["targetoptions"]["Distance"] then
									Sucess = false
								end

								Wait(1)
							end

							SendNUIMessage({ Action = "Left" })
						end
					end
				end

				if GetEntityType(Entity) ~= 0 then
					if IsEntityAVehicle(Entity) then
						local Plate = GetVehicleNumberPlateText(Entity)
						if #(Coords - entCoords) <= 1.0 and Plate ~= "PDMSPORT" then
							local Network = nil
							local Combustivel = false
							local vehModel = GetEntityModel(Entity)
							SetEntityAsMissionEntity(Entity, true, true)

							if NetworkGetEntityIsNetworked(Entity) then
								Network = VehToNet(Entity)
							end

							Selected = { Plate, vRP.VehicleModel(Entity), Entity, Network }

							local Menu = {}

							for _, v in pairs(Fuels) do
								if #(Coords - v) <= 2.5 then
									Combustivel = true
									break
								end
							end

							if not Combustivel then
								if GetSelectedPedWeapon(Ped) == 883325847 then
									Selected[5] = true
									Menu[#Menu + 1] = { event = "engine:Supply", label = "Abastecer", tunnel = "client" }
								else
									if GlobalState["Plates"][Plate] then
										if GetVehicleDoorLockStatus(Entity) == 1 then
											for k,Tyre in pairs(Tyres) do
												local Wheel = GetEntityBoneIndexByName(Entity, k)
												if Wheel ~= -1 then
													local CoordsWheel = GetWorldPositionOfEntityBone(Entity, Wheel)
													if #(Coords - CoordsWheel) <= 1.0 then
														Selected[5] = Tyre
														Menu[#Menu + 1] = { event = "inventory:RemoveTyres", label = "Retirar Pneu", tunnel = "client" }
													end
												end
											end

											Menu[#Menu + 1] = { event = "trunkchest:openTrunk", label = "Abrir Porta-Malas", tunnel = "server" }
											Menu[#Menu + 1] = { event = "player:checkTrunk", label = "Checar Porta-Malas", tunnel = "server" }
										end

										Menu[#Menu + 1] = { event = "garages:Key", label = "Criar Chave Cópia", tunnel = "police" }
										Menu[#Menu + 1] = { event = "inventory:applyPlate", label = "Trocar Placa", tunnel = "server" }
									else
										if Selected[2] == "stockade" then
											Menu[#Menu + 1] = { event = "inventory:Stockade", label = "Vasculhar", tunnel = "server" }
										end

										if Selected[2] == "pounder" or Selected[2] == "pounder2" then
											Menu[#Menu + 1] = { event = "inventory:Pounder", label = "Vasculhar", tunnel = "server" }
										end
									end

									if not IsThisModelABike(vehModel) then
										local Rolling = GetEntityRoll(Entity)
										if Rolling > 75.0 or Rolling < -75.0 then
											Menu[#Menu + 1] = { event = "player:RollVehicle", label = "Desvirar", tunnel = "server" }
										else
											if GetEntityBoneIndexByName(Entity, "boot") ~= -1 then
												local Trunk = GetEntityBoneIndexByName(Entity, "boot")
												local CoordsTrunk = GetWorldPositionOfEntityBone(Entity, Trunk)
												if #(Coords - CoordsTrunk) <= 1.75 then
													if GetVehicleDoorLockStatus(Entity) == 1 then
														Menu[#Menu + 1] = { event = "player:enterTrunk", label = "Entrar no Porta-Malas", tunnel = "client" }
													else
														Menu[#Menu + 1] = { event = "trunkchest:forceTrunk", label = "Forçar Porta-Malas", tunnel = "server" }
													end

													Menu[#Menu + 1] = { event = "inventory:StealTrunk", label = "Arrombar Porta-Malas", tunnel = "client" }
												end
											end
										end
									end

									if LocalPlayer["state"]["Policia"] then
										Menu[#Menu + 1] = { event = "police:Plate", label = "Verificar Placa", tunnel = "police" }

										if GlobalState["Plates"][Plate] then
											Menu[#Menu + 1] = { event = "police:ArrestVehicles", label = "Apreender Veículo", tunnel = "police" }
										end
									else
										if Plate == "DISM"..(1000 + LocalPlayer["state"]["Passport"]) then
											if #(Coords - Dismantle[Dismantleds]) <= 15 then
												Menu[#Menu + 1] = { event = "inventory:Dismantle", label = "Desmanchar", tunnel = "client" }
											end
										end

										if #(Coords - vec3(405.21, -1638.34, 29.28)) <= 15 then
											Menu[#Menu + 1] = { event = "inventory:Tow", label = "Rebocar", tunnel = "client" }
										end
									end

									Menu[#Menu + 1] = { event = "engine:Vehrify", label = "Verificar", tunnel = "client" }
								end
							else
								Selected[5] = false
								Menu[#Menu + 1] = { event = "engine:Supply", label = "Abastecer", tunnel = "client" }
							end

							SendNUIMessage({ Action = "Valid", data = Menu })

							Sucess = true
							while Sucess do
								local Ped = PlayerPedId()
								local Coords = GetEntityCoords(Ped)
								local _, entCoords, Entity = RayCastGamePlayCamera()

								if (IsControlJustReleased(1, 24) or IsDisabledControlJustReleased(1, 24)) then
									SetCursorLocation(0.5, 0.5)
									SetNuiFocus(true, true)
								end

								if GetEntityType(Entity) == 0 or #(Coords - entCoords) > 1.0 then
									Sucess = false
								end

								Wait(1)
							end

							SendNUIMessage({ Action = "Left" })
						end
					elseif IsPedAPlayer(Entity) then
						if #(Coords - entCoords) <= 2.0 then
							local index = NetworkGetPlayerIndexFromPed(Entity)
							local source = GetPlayerServerId(index)
							local Menu = {}

							Selected = { source }
							
							if LocalPlayer["state"]["Policia"] then
								Menu[#Menu + 1] = { event = "police:Inspect", label = "Revistar", tunnel = "paramedic" }
								Menu[#Menu + 1] = { event = "police:ArrestItens", label = "Apreender Itens", tunnel = "paramedic" }
								Menu[#Menu + 1] = { event = "autoschool:SeizeCnh", label = "Apreender CNH", tunnel = "paramedic" }
								Menu[#Menu + 1] = { event = "police:prisonClothes", label = "Uniforme Presidiário", tunnel = "police" }
							elseif LocalPlayer["state"]["Paramedico"] then
								if GetEntityHealth(Entity) <= 100 then
									Menu[#Menu + 1] = { event = "paramedic:Revive", label = "Reanimar", tunnel = "paramedic" }
								else
									Menu[#Menu + 1] = { event = "paramedic:Treatment", label = "Tratamento", tunnel = "paramedic" }
									Menu[#Menu + 1] = { event = "paramedic:Reposed", label = "Colocar de Repouso", tunnel = "paramedic" }
									Menu[#Menu + 1] = { event = "paramedic:Bandage", label = "Passar Ataduras", tunnel = "paramedic" }
									Menu[#Menu + 1] = { event = "paramedic:presetBurn", label = "Roupa de Queimadura", tunnel = "paramedic" }
									Menu[#Menu + 1] = { event = "paramedic:presetPlaster", label = "Colocar Gesso", tunnel = "paramedic" }
									Menu[#Menu + 1] = { event = "paramedic:extractBlood", label = "Extrair Sangue", tunnel = "paramedic" }
								end

								Menu[#Menu + 1] = { event = "paramedic:Diagnostic", label = "Informações", tunnel = "paramedic" }
							end

							if GetEntityHealth(Entity) <= 100 then
								Menu[#Menu + 1] = { event = "police:Inspect", label = "Saquear", tunnel = "paramedic" }
							end

							if IsEntityPlayingAnim(Entity, "random@mugging3", "handsup_standing_base", 3) then
								Menu[#Menu + 1] = { event = "police:Inspect", label = "Revistar", tunnel = "paramedic" }
								Menu[#Menu + 1] = { event = "player:checkShoes", label = "Roubar Sapatos", tunnel = "paramedic" }
							end

							if GetEntityHealth(Entity) > 100 then
								Menu[#Menu + 1] = { event = "player:Charge", label = "Cobrança", tunnel = "paramedic" }
								
								local Reputation = vPLAYER.GetReputation(source)
								if Reputation then
									Menu[#Menu + 1] = { event = "player:Like", label = "👍 Curtir ["..parseInt(Reputation[1]).."]", tunnel = "paramedic" }
									Menu[#Menu + 1] = { event = "player:UnLike", label = "👎 Descurtir ["..parseInt(Reputation[2]).."]", tunnel = "paramedic" }
								end
							end

							SendNUIMessage({ Action = "Valid", data = Menu })

							Sucess = true
							while Sucess do
								local Ped = PlayerPedId()
								local Coords = GetEntityCoords(Ped)
								local _, entCoords, Entity = RayCastGamePlayCamera()

								if (IsControlJustReleased(1, 24) or IsDisabledControlJustReleased(1, 24)) then
									SetCursorLocation(0.5, 0.5)
									SetNuiFocus(true, true)
								end

								if GetEntityType(Entity) == 0 or #(Coords - entCoords) > 2.0 then
									Sucess = false
								end

								Wait(1)
							end

							SendNUIMessage({ Action = "Left" })
						end
					else
						for k, v in pairs(Models) do
							if DoesEntityExist(Entity) then
								if k == GetEntityModel(Entity) then
									if #(Coords - entCoords) <= Models[k]["Distance"] then
										local objNet = nil
										if NetworkGetEntityIsNetworked(Entity) then
											objNet = ObjToNet(Entity)
										end

										Selected = { Entity, k, objNet, GetEntityCoords(Entity) }

										SendNUIMessage({ Action = "Valid", data = Models[k]["options"] })

										Sucess = true
										while Sucess do
											local Ped = PlayerPedId()
											local Coords = GetEntityCoords(Ped)
											local _, entCoords, Entity = RayCastGamePlayCamera()

											if (IsControlJustReleased(1, 24) or IsDisabledControlJustReleased(1, 24)) then
												SetCursorLocation(0.5, 0.5)
												SetNuiFocus(true, true)
											end

											if GetEntityType(Entity) == 0 or #(Coords - entCoords) > Models[k]["Distance"] then
												Sucess = false
											end

											Wait(1)
										end

										SendNUIMessage({ Action = "Left" })
									end
								end
							end
						end
					end
				end
			end

			Wait(100)
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TARGET:ROLLVEHICLE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("target:RollVehicle")
AddEventHandler("target:RollVehicle", function(Network)
	if NetworkDoesNetworkIdExist(Network) then
		local Vehicle = NetToEnt(Network)
		if DoesEntityExist(Vehicle) then
			SetVehicleOnGroundProperly(Vehicle)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TARGETDISABLE
-----------------------------------------------------------------------------------------------------------------------------------------
function TargetDisable()
	if Sucess or not LocalPlayer["state"]["Target"] then
		return
	end

	SendNUIMessage({ Action = "Close" })
	LocalPlayer["state"]:set("Target", false, false)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SELECT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Select", function(Data, Callback)
	Sucess = false
	SetNuiFocus(false, false)
	SendNUIMessage({ Action = "Close" })
	LocalPlayer["state"]:set("Target", false, false)

	if Data["tunnel"] == "client" then
		TriggerEvent(Data["event"], Selected)
	elseif Data["tunnel"] == "shop" then
		TriggerEvent(Data["event"], Selected, Data["service"])
	elseif Data["tunnel"] == "entity" then
		TriggerEvent(Data["event"], Selected[1], Data["service"])
	elseif Data["tunnel"] == "products" then
		TriggerEvent(Data["event"], Data["service"])
	elseif Data["tunnel"] == "server" then
		TriggerServerEvent(Data["event"], Selected)
	elseif Data["tunnel"] == "police" then
		TriggerServerEvent(Data["event"], Selected, Data["service"])
	elseif Data["tunnel"] == "paramedic" then
		TriggerServerEvent(Data["event"], Selected[1], Data["service"])
	elseif Data["tunnel"] == "proserver" then
		TriggerServerEvent(Data["event"], Data["service"])
	end

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLOSE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Close", function(Data, Callback)
	Sucess = false
	SetNuiFocus(false, false)
	SendNUIMessage({ Action = "Close" })
	LocalPlayer["state"]:set("Target", false, false)

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DEBUG
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("target:Debug")
AddEventHandler("target:Debug", function()
	Sucess = false
	SetNuiFocus(false, false)
	SendNUIMessage({ Action = "Close" })
	LocalPlayer["state"]:set("Target", false, false)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETCOORDSFROMCAM
-----------------------------------------------------------------------------------------------------------------------------------------
function GetCoordsFromCam(Distance, Coords)
	local Rotation = GetGameplayCamRot()
	local Adjuste = vec3((math.pi / 180) * Rotation["x"], (math.pi / 180) * Rotation["y"], (math.pi / 180) * Rotation["z"])
	local Direction = vec3(-math.sin(Adjuste[3]) * math.abs(math.cos(Adjuste[1])), math.cos(Adjuste[3]) * math.abs(math.cos(Adjuste[1])), math.sin(Adjuste[1]))

	return vec3(Coords[1] + Direction[1] * Distance, Coords[2] + Direction[2] * Distance, Coords[3] + Direction[3] * Distance)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- RAYCASTGAMEPLAYCAMERA
-----------------------------------------------------------------------------------------------------------------------------------------
function RayCastGamePlayCamera()
	local Ped = PlayerPedId()
	local Cam = GetGameplayCamCoord()
	local Cam2 = GetCoordsFromCam(10.0, Cam)
	local Handle = StartExpensiveSynchronousShapeTestLosProbe(Cam, Cam2, -1, Ped, 4)
	local _, Hit, Coords, _, Entitys = GetShapeTestResult(Handle)

	return Hit, Coords, Entitys
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADDCIRCLEZONE
-----------------------------------------------------------------------------------------------------------------------------------------
function AddCircleZone(Name, Center, Radius, Options, Target)
	Zones[Name] = CircleZone:Create(Center, Radius, Options)
	Zones[Name]["targetoptions"] = Target
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- REMCIRCLEZONE
-----------------------------------------------------------------------------------------------------------------------------------------
function RemCircleZone(Name)
	if Zones[Name] then
		Zones[Name]:destroy()
		Zones[Name] = nil
	end

	if Sucess then
		Sucess = false
		SetNuiFocus(false, false)
		SendNUIMessage({ Action = "Close" })
		LocalPlayer["state"]:set("Target", false, false)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADDTARGETMODEL
-----------------------------------------------------------------------------------------------------------------------------------------
function AddTargetModel(Model, Options)
	for _, v in pairs(Model) do
		Models[v] = Options
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- LABELTEXT
-----------------------------------------------------------------------------------------------------------------------------------------
function LabelText(Name, Text)
	if Zones[Name] then
		Zones[Name]["targetoptions"]["options"][1]["label"] = Text
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- LABELOPTIONS
-----------------------------------------------------------------------------------------------------------------------------------------
function LabelOptions(Name, Text)
	if Zones[Name] then
		Zones[Name]["targetoptions"]["options"] = Text
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADDBOXZONE
-----------------------------------------------------------------------------------------------------------------------------------------
function AddBoxZone(Name, Center, Length, Width, Options, Target)
	Zones[Name] = BoxZone:Create(Center, Length, Width, Options)
	Zones[Name]["targetoptions"] = Target
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- EXPORTS
-----------------------------------------------------------------------------------------------------------------------------------------
exports("LabelText", LabelText)
exports("AddBoxZone", AddBoxZone)
exports("LabelOptions", LabelOptions)
exports("RemCircleZone", RemCircleZone)
exports("AddCircleZone", AddCircleZone)
exports("AddTargetModel", AddTargetModel)