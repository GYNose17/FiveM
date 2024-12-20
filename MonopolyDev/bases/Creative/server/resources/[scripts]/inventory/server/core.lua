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
Tunnel.bindInterface("inventory",Baixada)
vCLIENT = Tunnel.getInterface("inventory")
vPLAYER = Tunnel.getInterface("player")
vGARAGE = Tunnel.getInterface("garages")
vSURVIVAL = Tunnel.getInterface("survival")
vKEYBOARD = Tunnel.getInterface("keyboard")
vPARAMEDIC = Tunnel.getInterface("paramedic")
vLOCKPICK = Tunnel.getInterface("lockpicking")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
Drops = {}
Drugs = {}
Carry = {}
Ammos = {}
Loots = {}
Boxes = {}
Active = {}
Trashs = {}
Armors = {}
Plates = {}
Trunks = {}
Healths = {}
Whistle = {}
Animals = {}
Attachs = {}
TowList = {}
Pumpjack = {}
Scanners = {}
Property = {}
Temporary = {}
AtmTimers = {}
Dismantle = {}
Registers = {}
TheftTimers = {}
RobberyType = {}
Electricity = {}
VerifyObjects = {}
VerifyAnimals = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- BUFFS
-----------------------------------------------------------------------------------------------------------------------------------------
Buffs = {
	["Dexterity"] = {},
	["Luck"] = {}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- OBJECTS
-----------------------------------------------------------------------------------------------------------------------------------------
Objects = {
	["1"] = { x = 594.59, y = 146.52, z = 97.30, h = 70.04, object = "sm_prop_smug_crate_s_medical", item = "", Distance = 50, mode = "Medic" },
	["2"] = { x = 660.44, y = 268.29, z = 102.04, h = 152.09, object = "sm_prop_smug_crate_s_medical", item = "", Distance = 50, mode = "Medic" },
	["3"] = { x = 552.54, y = -198.45, z = 53.75, h = 89.32, object = "sm_prop_smug_crate_s_medical", item = "", Distance = 50, mode = "Medic" },
	["4"] = { x = 339.75, y = -580.95, z = 73.42, h = 67.19, object = "sm_prop_smug_crate_s_medical", item = "", Distance = 50, mode = "Medic" },
	["5"] = { x = 696.12, y = -965.69, z = 23.26, h = 271.33, object = "sm_prop_smug_crate_s_medical", item = "", Distance = 50, mode = "Medic" },
	["6"] = { x = -2235.42, y = 363.52, z = 173.91, h = 23.73, object = "sm_prop_smug_crate_s_medical", item = "", Distance = 50, mode = "Medic" },
	["7"] = { x = 1382.1, y = -2081.97, z = 51.25, h = 220.16, object = "sm_prop_smug_crate_s_medical", item = "", Distance = 50, mode = "Medic" },
	["8"] = { x = 589.32, y = -2802.73, z = 5.32, h = 328.01, object = "sm_prop_smug_crate_s_medical", item = "", Distance = 50, mode = "Medic" },
	["9"] = { x = -453.19, y = -2810.47, z = 6.56, h = 225.82, object = "sm_prop_smug_crate_s_medical", item = "", Distance = 50, mode = "Medic" },
	["10"] = { x = -1007.18, y = -2836.12, z = 13.20, h = 149.3, object = "sm_prop_smug_crate_s_medical", item = "", Distance = 50, mode = "Medic" },
	["11"] = { x = -2018.21, y = -361.03, z = 47.36, h = 324.55, object = "sm_prop_smug_crate_s_medical", item = "", Distance = 50, mode = "Medic" },
	["12"] = { x = -1727.77, y = 250.26, z = 61.65, h = 24.7, object = "sm_prop_smug_crate_s_medical", item = "", Distance = 50, mode = "Medic" },
	["13"] = { x = -1089.6, y = 2717.05, z = 18.33, h = 40.52, object = "sm_prop_smug_crate_s_medical", item = "", Distance = 50, mode = "Medic" },
	["14"] = { x = 321.27, y = 2874.98, z = 42.71, h = 27.62, object = "sm_prop_smug_crate_s_medical", item = "", Distance = 50, mode = "Medic" },
	["15"] = { x = 1163.47, y = 2722.09, z = 37.26, h = 179.11, object = "sm_prop_smug_crate_s_medical", item = "", Distance = 50, mode = "Medic" },
	["16"] = { x = 1745.86, y = 3326.69, z = 40.30, h = 115.55, object = "sm_prop_smug_crate_s_medical", item = "", Distance = 50, mode = "Medic" },
	["17"] = { x = 2013.4, y = 3934.36, z = 31.65, h = 236.38, object = "sm_prop_smug_crate_s_medical", item = "", Distance = 50, mode = "Medic" },
	["18"] = { x = 2526.3, y = 4191.6, z = 44.53, h = 236.44, object = "sm_prop_smug_crate_s_medical", item = "", Distance = 50, mode = "Medic" },
	["19"] = { x = 2874.05, y = 4861.57, z = 61.35, h = 87.57, object = "sm_prop_smug_crate_s_medical", item = "", Distance = 50, mode = "Medic" },
	["20"] = { x = 1985.16, y = 6200.39, z = 41.33, h = 330.21, object = "sm_prop_smug_crate_s_medical", item = "", Distance = 50, mode = "Medic" },
	["21"] = { x = 1552.97, y = 6610.24, z = 2.12, h = 145.64, object = "sm_prop_smug_crate_s_medical", item = "", Distance = 50, mode = "Medic" },
	["22"] = { x = -298.32, y = 6392.66, z = 29.87, h = 302.99, object = "sm_prop_smug_crate_s_medical", item = "", Distance = 50, mode = "Medic" },
	["23"] = { x = -813.88, y = 5384.45, z = 33.77, h = 356.87, object = "sm_prop_smug_crate_s_medical", item = "", Distance = 50, mode = "Medic" },
	["24"] = { x = -1606.5, y = 5259.26, z = 1.35, h = 114.45, object = "sm_prop_smug_crate_s_medical", item = "", Distance = 50, mode = "Medic" },
	["25"] = { x = -199.22, y = 3638.8, z = 63.70, h = 39.84, object = "sm_prop_smug_crate_s_medical", item = "", Distance = 50, mode = "Medic" },
	["26"] = { x = -1487.45, y = 2688.99, z = 2.94, h = 317.89, object = "sm_prop_smug_crate_s_medical", item = "", Distance = 50, mode = "Medic" },
	["27"] = { x = -3266.12, y = 1139.82, z = 1.91, h = 249.17, object = "sm_prop_smug_crate_s_medical", item = "", Distance = 50, mode = "Medic" },
	["28"] = { x = 170.71, y = -1070.94, z = 28.5, h = 339.6, object = "sm_prop_smug_crate_s_medical", item = "", Distance = 50, mode = "Medic" },
	["29"] = { x = 487.23, y = -1093.93, z = 28.71, h = 0.74, object = "sm_prop_smug_crate_s_medical", item = "", Distance = 50, mode = "Medic" },
	["30"] = { x = 584.63, y = -1419.69, z = 18.52, h = 180.41, object = "sm_prop_smug_crate_s_medical", item = "", Distance = 50, mode = "Medic" },
	["31"] = { x = 694.07, y = -1453.5, z = 19.03, h = 0.45, object = "sm_prop_smug_crate_s_medical", item = "", Distance = 50, mode = "Medic" },
	["32"] = { x = 892.49, y = -2490.3, z = 28.88, h = 175.48, object = "sm_prop_smug_crate_s_medical", item = "", Distance = 50, mode = "Medic" },
	["33"] = { x = 1463.09, y = -2613.91, z = 48.17, h = 76.65, object = "sm_prop_smug_crate_s_medical", item = "", Distance = 50, mode = "Medic" },
	["34"] = { x = 1877.42, y = -1065.71, z = 80.22, h = 97.79, object = "sm_prop_smug_crate_s_medical", item = "", Distance = 50, mode = "Medic" },
	["35"] = { x = 2557.67, y = -598.5, z = 64.23, h = 12.71, object = "sm_prop_smug_crate_s_medical", item = "", Distance = 50, mode = "Medic" },
	["36"] = { x = 2546.8, y = 395.31, z = 107.92, h = 268.3, object = "sm_prop_smug_crate_s_medical", item = "", Distance = 50, mode = "Medic" },
	["37"] = { x = 2074.59, y = 1403.29, z = 74.88, h = 300.3, object = "sm_prop_smug_crate_s_medical", item = "", Distance = 50, mode = "Medic" },
	["38"] = { x = 2405.44, y = 2903.85, z = 39.67, h = 217.41, object = "sm_prop_smug_crate_s_medical", item = "", Distance = 50, mode = "Medic" },
	["39"] = { x = 2895.84, y = 3735.4, z = 43.5, h = 289.37, object = "sm_prop_smug_crate_s_medical", item = "", Distance = 50, mode = "Medic" },
	["40"] = { x = 1677.25, y = 4882.36, z = 46.62, h = 59.7, object = "sm_prop_smug_crate_s_medical", item = "", Distance = 50, mode = "Medic" },
	["41"] = { x = -437.08, y = 6339.84, z = 12.06, h = 216.59, object = "sm_prop_smug_crate_s_medical", item = "", Distance = 50, mode = "Medic" },
	["42"] = { x = 431.15, y = 6472.57, z = 28.08, h = 140.5, object = "sm_prop_smug_crate_s_medical", item = "", Distance = 50, mode = "Medic" },
	["43"] = { x = -2303.74, y = 3389.16, z = 30.56, h = 324.26, object = "sm_prop_smug_crate_s_medical", item = "", Distance = 50, mode = "Medic" },
	["44"] = { x = -2096.92, y = 3258.17, z = 32.12, h = 239.97, object = "sm_prop_smug_crate_s_medical", item = "", Distance = 50, mode = "Medic" },
	["45"] = { x = -1773.55, y = 2995.46, z = 32.11, h = 330.02, object = "sm_prop_smug_crate_s_medical", item = "", Distance = 50, mode = "Medic" },
	["46"] = { x = -2086.61, y = 2816.89, z = 32.27, h = 354.52, object = "sm_prop_smug_crate_s_medical", item = "", Distance = 50, mode = "Medic" },
	["47"] = { x = -1511.83, y = 1520.27, z = 114.59, h = 255.31, object = "sm_prop_smug_crate_s_medical", item = "", Distance = 50, mode = "Medic" },

	["48"] = { x = 574.01, y = 132.56, z = 98.48, h = 70.99, object = "prop_mb_crate_01a", item = "", Distance = 50, mode = "Weapons" },
	["49"] = { x = 344.79, y = 929.2, z = 202.44, h = 268.09, object = "prop_mb_crate_01a", item = "", Distance = 50, mode = "Weapons" },
	["50"] = { x = -123.8, y = 1896.67, z = 196.34, h = 358.95, object = "prop_mb_crate_01a", item = "", Distance = 50, mode = "Weapons" },
	["51"] = { x = -1099.85, y = 2703.51, z = 21.99, h = 221.35, object = "prop_mb_crate_01a", item = "", Distance = 50, mode = "Weapons" },
	["52"] = { x = -2198.91, y = 4243.21, z = 46.92, h = 128.84, object = "prop_mb_crate_01a", item = "", Distance = 50, mode = "Weapons" },
	["53"] = { x = -1487.02, y = 4983.14, z = 62.67, h = 174.11, object = "prop_mb_crate_01a", item = "", Distance = 50, mode = "Weapons" },
	["54"] = { x = 1346.49, y = 6396.73, z = 32.42, h = 90.94, object = "prop_mb_crate_01a", item = "", Distance = 50, mode = "Weapons" },
	["55"] = { x = 2535.72, y = 4661.39, z = 33.08, h = 316.4, object = "prop_mb_crate_01a", item = "", Distance = 50, mode = "Weapons" },
	["56"] = { x = 1155.62, y = -1334.48, z = 33.72, h = 174.97, object = "prop_mb_crate_01a", item = "", Distance = 50, mode = "Weapons" },
	["57"] = { x = 1116.06, y = -2498.07, z = 32.37, h = 193.39, object = "prop_mb_crate_01a", item = "", Distance = 50, mode = "Weapons" },
	["58"] = { x = 261.06, y = -3135.82, z = 4.8, h = 88.83, object = "prop_mb_crate_01a", item = "", Distance = 50, mode = "Weapons" },
	["59"] = { x = -1619.81, y = -1035.0, z = 12.16, h = 50.84, object = "prop_mb_crate_01a", item = "", Distance = 50, mode = "Weapons" },
	["60"] = { x = -3420.87, y = 977.0, z = 10.91, h = 226.29, object = "prop_mb_crate_01a", item = "", Distance = 50, mode = "Weapons" },
	["61"] = { x = -1909.53, y = 4624.93, z = 56.07, h = 135.57, object = "prop_mb_crate_01a", item = "", Distance = 50, mode = "Weapons" },
	["62"] = { x = 894.51, y = 3211.45, z = 38.09, h = 273.04, object = "prop_mb_crate_01a", item = "", Distance = 50, mode = "Weapons" },
	["63"] = { x = 1791.71, y = 4602.84, z = 36.69, h = 185.86, object = "prop_mb_crate_01a", item = "", Distance = 50, mode = "Weapons" },
	["64"] = { x = 464.8, y = 6462.03, z = 28.76, h = 334.71, object = "prop_mb_crate_01a", item = "", Distance = 50, mode = "Weapons" },
	["65"] = { x = 63.22, y = 6323.67, z = 37.87, h = 301.22, object = "prop_mb_crate_01a", item = "", Distance = 50, mode = "Weapons" },
	["66"] = { x = -736.64, y = 5594.98, z = 40.66, h = 268.78, object = "prop_mb_crate_01a", item = "", Distance = 50, mode = "Weapons" },
	["67"] = { x = 720.76, y = 2330.87, z = 50.76, h = 179.99, object = "prop_mb_crate_01a", item = "", Distance = 50, mode = "Weapons" },
	["68"] = { x = 1909.47, y = 611.47, z = 177.41, h = 65.57, object = "prop_mb_crate_01a", item = "", Distance = 50, mode = "Weapons" },
	["69"] = { x = 1796.6, y = -1350.06, z = 98.75, h = 61.5, object = "prop_mb_crate_01a", item = "", Distance = 50, mode = "Weapons" },
	["70"] = { x = 955.32, y = -3101.26, z = 4.91, h = 266.38, object = "prop_mb_crate_01a", item = "", Distance = 50, mode = "Weapons" },
	["71"] = { x = -1306.41, y = -3387.9, z = 12.95, h = 59.92, object = "prop_mb_crate_01a", item = "", Distance = 50, mode = "Weapons" },
	["72"] = { x = -1219.66, y = -2079.82, z = 13.16, h = 351.04, object = "prop_mb_crate_01a", item = "", Distance = 50, mode = "Weapons" },
	["73"] = { x = -1203.53, y = -1804.25, z = 2.91, h = 245.4, object = "prop_mb_crate_01a", item = "", Distance = 50, mode = "Weapons" },
	["74"] = { x = -720.47, y = -399.49, z = 33.9, h = 351.27, object = "prop_mb_crate_01a", item = "", Distance = 50, mode = "Weapons" },
	["75"] = { x = -503.39, y = -1438.17, z = 13.16, h = 346.71, object = "prop_mb_crate_01a", item = "", Distance = 50, mode = "Weapons" },
	["76"] = { x = 1398.24, y = 2117.57, z = 104.02, h = 131.36, object = "prop_mb_crate_01a", item = "", Distance = 50, mode = "Weapons" },
	["77"] = { x = -1811.62, y = 3104.09, z = 31.85, h = 60.36, object = "prop_mb_crate_01a", item = "", Distance = 50, mode = "Weapons" },
	["78"] = { x = -1812.86, y = 3101.95, z = 31.85, h = 62.1, object = "prop_mb_crate_01a", item = "", Distance = 50, mode = "Weapons" },
	["79"] = { x = -1850.29, y = 3156.66, z = 31.82, h = 150.22, object = "prop_mb_crate_01a", item = "", Distance = 50, mode = "Weapons" },
	["80"] = { x = -2052.86, y = 3173.31, z = 31.82, h = 240.03, object = "prop_mb_crate_01a", item = "", Distance = 50, mode = "Weapons" },
	["81"] = { x = -2409.94, y = 3355.95, z = 31.83, h = 61.29, object = "prop_mb_crate_01a", item = "", Distance = 50, mode = "Weapons" },
	["82"] = { x = -2450.39, y = 2946.63, z = 31.97, h = 330.0, object = "prop_mb_crate_01a", item = "", Distance = 50, mode = "Weapons" },

	["83"] = { x = -257.5, y = -966.54, z = 30.22, h = 26.06, object = "gr_prop_gr_rsply_crate03a", item = "", Distance = 50, mode = "Supplies" },
	["84"] = { x = -2682.86, y = 2304.87, z = 20.85, h = 164.19, object = "gr_prop_gr_rsply_crate03a", item = "", Distance = 50, mode = "Supplies" },
	["85"] = { x = -1282.33, y = 2559.98, z = 17.4, h = 148.06, object = "gr_prop_gr_rsply_crate03a", item = "", Distance = 50, mode = "Supplies" },
	["86"] = { x = 159.65, y = 3118.8, z = 42.44, h = 16.37, object = "gr_prop_gr_rsply_crate03a", item = "", Distance = 50, mode = "Supplies" },
	["87"] = { x = 1061.43, y = 3527.62, z = 33.15, h = 255.93, object = "gr_prop_gr_rsply_crate03a", item = "", Distance = 50, mode = "Supplies" },
	["88"] = { x = 2370.22, y = 3156.55, z = 47.21, h = 221.77, object = "gr_prop_gr_rsply_crate03a", item = "", Distance = 50, mode = "Supplies" },
	["89"] = { x = 2520.51, y = 2637.83, z = 36.95, h = 314.33, object = "gr_prop_gr_rsply_crate03a", item = "", Distance = 50, mode = "Supplies" },
	["90"] = { x = 2572.37, y = 477.44, z = 107.68, h = 269.49, object = "gr_prop_gr_rsply_crate03a", item = "", Distance = 50, mode = "Supplies" },
	["91"] = { x = 1223.15, y = -1079.56, z = 37.53, h = 123.38, object = "gr_prop_gr_rsply_crate03a", item = "", Distance = 50, mode = "Supplies" },
	["92"] = { x = 1048.49, y = -247.53, z = 68.66, h = 149.33, object = "gr_prop_gr_rsply_crate03a", item = "", Distance = 50, mode = "Supplies" },
	["93"] = { x = 499.41, y = -529.38, z = 23.76, h = 262.13, object = "gr_prop_gr_rsply_crate03a", item = "", Distance = 50, mode = "Supplies" },
	["94"] = { x = 592.53, y = -2115.87, z = 4.76, h = 100.96, object = "gr_prop_gr_rsply_crate03a", item = "", Distance = 50, mode = "Supplies" },
	["95"] = { x = 523.43, y = -2578.67, z = 13.82, h = 318.38, object = "gr_prop_gr_rsply_crate03a", item = "", Distance = 50, mode = "Supplies" },
	["96"] = { x = -2.98, y = -1299.67, z = 28.28, h = 359.37, object = "gr_prop_gr_rsply_crate03a", item = "", Distance = 50, mode = "Supplies" },
	["97"] = { x = 183.11, y = -1086.93, z = 28.28, h = 348.57, object = "gr_prop_gr_rsply_crate03a", item = "", Distance = 50, mode = "Supplies" },
	["98"] = { x = 713.88, y = -850.95, z = 23.3, h = 271.63, object = "gr_prop_gr_rsply_crate03a", item = "", Distance = 50, mode = "Supplies" },
	["99"] = { x = -2438.82, y = 2999.82, z = 32.07, h = 194.35, object = "gr_prop_gr_rsply_crate03a", item = "", Distance = 50, mode = "Supplies" },
	["100"] = { x = -2440.04, y = 2999.46, z = 32.07, h = 194.41, object = "gr_prop_gr_rsply_crate03a", item = "", Distance = 50, mode = "Supplies" },
	["101"] = { x = -2092.59, y = 3113.14, z = 31.82, h = 240.25, object = "gr_prop_gr_rsply_crate03a", item = "", Distance = 50, mode = "Supplies" },
	["102"] = { x = -1824.95, y = 3016.0, z = 31.82, h = 329.62, object = "gr_prop_gr_rsply_crate03a", item = "", Distance = 50, mode = "Supplies" },
	["103"] = { x = -202.03, y = 3651.99, z = 50.74, h = 192.39, object = "gr_prop_gr_rsply_crate03a", item = "", Distance = 50, mode = "Supplies" },
	["104"] = { x = -203.41, y = 3651.71, z = 50.74, h = 192.96, object = "gr_prop_gr_rsply_crate03a", item = "", Distance = 50, mode = "Supplies" },
	["105"] = { x = 2007.81, y = 4964.86, z = 40.71, h = 158.28, object = "gr_prop_gr_rsply_crate03a", item = "", Distance = 50, mode = "Supplies" },
	["106"] = { x = 1904.26, y = 4930.73, z = 47.97, h = 156.61, object = "gr_prop_gr_rsply_crate03a", item = "", Distance = 50, mode = "Supplies" },
	["107"] = { x = 1702.14, y = 4819.3, z = 40.96, h = 97.05, object = "gr_prop_gr_rsply_crate03a", item = "", Distance = 50, mode = "Supplies" },
	["108"] = { x = 2030.66, y = 4727.43, z = 40.61, h = 294.35, object = "gr_prop_gr_rsply_crate03a", item = "", Distance = 50, mode = "Supplies" },
	["109"] = { x = 2122.12, y = 4784.69, z = 39.98, h = 116.71, object = "gr_prop_gr_rsply_crate03a", item = "", Distance = 50, mode = "Supplies" },
	["110"] = { x = 2177.23, y = 2169.39, z = 116.31, h = 229.64, object = "gr_prop_gr_rsply_crate03a", item = "", Distance = 50, mode = "Supplies" },
	["111"] = { x = 2395.2, y = 2032.72, z = 90.35, h = 318.06, object = "gr_prop_gr_rsply_crate03a", item = "", Distance = 50, mode = "Supplies" },
	["112"] = { x = 2619.31, y = 1691.36, z = 26.6, h = 270.01, object = "gr_prop_gr_rsply_crate03a", item = "", Distance = 50, mode = "Supplies" },
	["113"] = { x = 1454.52, y = -1680.69, z = 65.03, h = 25.31, object = "gr_prop_gr_rsply_crate03a", item = "", Distance = 50, mode = "Supplies" },
	["114"] = { x = 1453.05, y = -1681.37, z = 64.96, h = 24.93, object = "gr_prop_gr_rsply_crate03a", item = "", Distance = 50, mode = "Supplies" },
	["115"] = { x = 240.42, y = -1864.8, z = 25.82, h = 49.31, object = "gr_prop_gr_rsply_crate03a", item = "", Distance = 50, mode = "Supplies" },
	["116"] = { x = -139.01, y = -1995.56, z = 21.81, h = 181.56, object = "gr_prop_gr_rsply_crate03a", item = "", Distance = 50, mode = "Supplies" },
	["117"] = { x = -343.54, y = -1333.09, z = 36.31, h = 89.4, object = "gr_prop_gr_rsply_crate03a", item = "", Distance = 50, mode = "Supplies" },
	["118"] = { x = -350.99, y = -1333.15, z = 36.31, h = 269.98, object = "gr_prop_gr_rsply_crate03a", item = "", Distance = 50, mode = "Supplies" },
	["119"] = { x = -346.45, y = -1337.38, z = 36.31, h = 359.9, object = "gr_prop_gr_rsply_crate03a", item = "", Distance = 50, mode = "Supplies" },
	["120"] = { x = -267.45, y = -971.56, z = 30.22, h = 25.86, object = "gr_prop_gr_rsply_crate03a", item = "", Distance = 50, mode = "Supplies" },

	-- ROBBERY CLOTHESHOP
	["121"] = { x = 70.27, y = -1389.11, z = 29.13, h = 90.28, object = "p_v_43_safe_s", item = "", Distance = 50 },
	["122"] = { x = -706.01, y = -150.49, z = 37.17, h = 28.61, object = "p_v_43_safe_s", item = "", Distance = 50 },
	["123"] = { x = -167.66, y = -301.67, z = 39.49, h = 161.34, object = "p_v_43_safe_s", item = "", Distance = 50 },
	["124"] = { x = -821.69, y = -1067.22, z = 11.08, h = 31.23, object = "p_v_43_safe_s", item = "", Distance = 50 },
	["125"] = { x = -1186.62, y = -772.55, z = 17.09, h = 215.93, object = "p_v_43_safe_s", item = "", Distance = 50 },
	["126"] = { x = -1446.85, y = -240.38, z = 49.57, h = 316.88, object = "p_v_43_safe_s", item = "", Distance = 50 },
	["127"] = { x = 5.53, y = 6506.07, z = 31.63, h = 222.68, object = "p_v_43_safe_s", item = "", Distance = 50 },
	["128"] = { x = 1699.51, y = 4819.72, z = 41.82, h = 277.02, object = "p_v_43_safe_s", item = "", Distance = 50 },
	["129"] = { x = 117.83, y = -223.56, z = 54.31, h = 70.89, object = "p_v_43_safe_s", item = "", Distance = 50 },
	["130"] = { x = 621.58, y = 2765.81, z = 41.84, h = 275.02, object = "p_v_43_safe_s", item = "", Distance = 50 },
	["131"] = { x = 1200.46, y = 2715.37, z = 37.98, h = 0.24, object = "p_v_43_safe_s", item = "", Distance = 50 },
	["132"] = { x = -3178.48, y = 1044.46, z = 20.62, h = 66.61, object = "p_v_43_safe_s", item = "", Distance = 50 },
	["133"] = { x = -1102.05, y = 2716.93, z = 18.86, h = 40.85, object = "p_v_43_safe_s", item = "", Distance = 50 },
	["134"] = { x = 430.72, y = -810.01, z = 29.25, h = 270.35, object = "p_v_43_safe_s", item = "", Distance = 50 },

	-- ROBBERY WEAPONSSHOP
	["135"] = { x = 1688.78, y = 3759.13, z = 34.46, h = 47.5, object = "p_v_43_safe_s", item = "", Distance = 50 },
	["136"] = { x = 256.35, y = -47.51, z = 69.7, h = 249.76, object = "p_v_43_safe_s", item = "", Distance = 50 },
	["137"] = { x = 846.13, y = -1036.62, z = 27.95, h = 178.74, object = "p_v_43_safe_s", item = "", Distance = 50 },
	["138"] = { x = -335.18, y = 6083.29, z = 31.21, h = 45.57, object = "p_v_43_safe_s", item = "", Distance = 50 },
	["139"] = { x = -665.98, y = -932.24, z = 21.58, h = 358.38, object = "p_v_43_safe_s", item = "", Distance = 50 },
	["140"] = { x = -1301.93, y = -391.36, z = 36.45, h = 255.85, object = "p_v_43_safe_s", item = "", Distance = 50 },
	["141"] = { x = -1122.59, y = 2698.25, z = 18.31, h = 42.82, object = "p_v_43_safe_s", item = "", Distance = 50 },
	["142"] = { x = 2571.67, y = 291.28, z = 108.49, h = 180.02, object = "p_v_43_safe_s", item = "", Distance = 50 },
	["143"] = { x = 2571.66, y = 291.29, z = 108.49, h = 181.06, object = "p_v_43_safe_s", item = "", Distance = 50 },
	["144"] = { x = 19.57, y = -1103.0, z = 29.55, h = 339.07, object = "p_v_43_safe_s", item = "", Distance = 50 },
	["145"] = { x = 813.92, y = -2160.34, z = 29.37, h = 179.33, object = "p_v_43_safe_s", item = "", Distance = 50 },

	-- ROBBERY BARBERSHOP
	["146"] = { x = -807.9, y = -180.83, z = 37.32, h = 299.3, object = "p_v_43_safe_s", item = "", Distance = 50 },
	["147"] = { x = 139.56, y = -1704.12, z = 29.05, h = 320.25, object = "p_v_43_safe_s", item = "", Distance = 50 },
	["148"] = { x = -1278.11, y = -1116.66, z = 6.75, h = 270.07, object = "p_v_43_safe_s", item = "", Distance = 50 },
	["149"] = { x = 1928.89, y = 3734.04, z = 32.6, h = 29.2, object = "p_v_43_safe_s", item = "", Distance = 50 },
	["150"] = { x = 1217.05, y = -473.45, z = 65.96, h = 255.89, object = "p_v_43_safe_s", item = "", Distance = 50 },
	["151"] = { x = -34.08, y = -157.01, z = 56.83, h = 159.63, object = "p_v_43_safe_s", item = "", Distance = 50 },
	["152"] = { x = -274.5, y = 6225.27, z = 31.45, h = 225.27, object = "p_v_43_safe_s", item = "", Distance = 50 },

	-- ROBBERY TATTOOSHOP
	["153"] = { x = 1327.98, y = -1654.78, z = 52.03, h = 218.71, object = "p_v_43_safe_s", item = "", Distance = 50 },
	["154"] = { x = -1149.04, y = -1428.64, z = 4.71, h = 215.2, object = "p_v_43_safe_s", item = "", Distance = 50 },
	["155"] = { x = 322.01, y = 186.24, z = 103.34, h = 339.28, object = "p_v_43_safe_s", item = "", Distance = 50 },
	["156"] = { x = -3175.64, y = 1075.54, z = 20.58, h = 65.96, object = "p_v_43_safe_s", item = "", Distance = 50 },
	["157"] = { x = 1866.01, y = 3748.07, z = 32.79, h = 299.38, object = "p_v_43_safe_s", item = "", Distance = 50 },
	["158"] = { x = -295.51, y = 6199.21, z = 31.24, h = 133.05, object = "p_v_43_safe_s", item = "", Distance = 50 },

	-- OTHER OBJECTS
	["9998"] = { x = -584.12, y = -1062.95, z = 22.38, h = 33.14, object = "bkr_prop_fakeid_clipboard_01a", item = "", Distance = 15 },
	["9999"] = { x = -1188.9, y = -897.82, z = 13.95, h = 130.04, object = "bkr_prop_fakeid_clipboard_01a", item = "", Distance = 15 }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- PRODUCTS
-----------------------------------------------------------------------------------------------------------------------------------------
Products = {
	["paper"] = {
		{ ["timer"] = 20, ["need"] = { { ["item"] = "woodlog", ["amount"] = 3 } }, ["needAmount"] = 1, ["item"] = "paper", ["itemAmount"] = 1 }
	},
	["tablecoke"] = {
		{ ["timer"] = 20, ["need"] = {
				{ ["item"] = "sulfuric", ["amount"] = 1 },
				{ ["item"] = "cokebud",  ["amount"] = 1 }
			}, ["needAmount"] = 1, ["item"] = "cocaine", ["itemAmount"] = 3
		}
	},
	["tablemeth"] = {
		{ ["timer"] = 20, ["need"] = {
				{ ["item"] = "saline",  ["amount"] = 1 },
				{ ["item"] = "acetone", ["amount"] = 1 }
			}, ["needAmount"] = 1, ["item"] = "meth", ["itemAmount"] = 3
		}
	},
	["tableweed"] = {
		{ ["timer"] = 20, ["need"] = {
				{ ["item"] = "silk",    ["amount"] = 1 },
				{ ["item"] = "weedbud", ["amount"] = 1 }
			}, ["needAmount"] = 1, ["item"] = "joint", ["itemAmount"] = 1
		}
	},
	["milkBottle"] = {
		{ ["timer"] = 30, ["need"] = "emptybottle", ["needAmount"] = 1, ["item"] = "milkbottle", ["itemAmount"] = 1 }
	},
	["scanner"] = {
		{ ["timer"] = 30, ["item"] = "sheetmetal", ["itemAmount"] = 1 },
		{ ["timer"] = 30, ["item"] = "roadsigns", ["itemAmount"] = 1 },
		{ ["timer"] = 30, ["item"] = "syringe", ["itemAmount"] = 3 },
		{ ["timer"] = 30, ["item"] = "fishingrod", ["itemAmount"] = 1 },
		{ ["timer"] = 30, ["item"] = "plate", ["itemAmount"] = 1 },
		{ ["timer"] = 30, ["item"] = "aluminum", ["itemAmount"] = 3 },
		{ ["timer"] = 30, ["item"] = "copper", ["itemAmount"] = 3 },
		{ ["timer"] = 30, ["item"] = "lighter", ["itemAmount"] = 1 },
		{ ["timer"] = 30, ["item"] = "battery", ["itemAmount"] = 1 },
		{ ["timer"] = 30, ["item"] = "metalcan", ["itemAmount"] = 1 }
	},
	["cemitery"] = {
		{ ["timer"] = 10, ["item"] = "silk", ["itemAmount"] = 1 },
		{ ["timer"] = 10, ["item"] = "cotton", ["itemAmount"] = 1 },
		{ ["timer"] = 10, ["item"] = "plaster", ["itemAmount"] = 1 },
		{ ["timer"] = 10, ["item"] = "pouch", ["itemAmount"] = 1 },
		{ ["timer"] = 10, ["item"] = "WEAPON_SWITCHBLADE", ["itemAmount"] = 1 },
		{ ["timer"] = 10, ["item"] = "joint", ["itemAmount"] = 1 },
		{ ["timer"] = 10, ["item"] = "acetone", ["itemAmount"] = 1 },
		{ ["timer"] = 10, ["item"] = "slipper", ["itemAmount"] = 1 },
		{ ["timer"] = 10, ["item"] = "water", ["itemAmount"] = 1 },
		{ ["timer"] = 10, ["item"] = "copper", ["itemAmount"] = 1 },
		{ ["timer"] = 10, ["item"] = "cigarette", ["itemAmount"] = 1 },
		{ ["timer"] = 10, ["item"] = "lighter", ["itemAmount"] = 1 },
		{ ["timer"] = 10, ["item"] = "elastic", ["itemAmount"] = 1 },
		{ ["timer"] = 10, ["item"] = "rose", ["itemAmount"] = 1 },
		{ ["timer"] = 10, ["item"] = "teddy", ["itemAmount"] = 1 },
		{ ["timer"] = 10, ["item"] = "binoculars", ["itemAmount"] = 1 },
		{ ["timer"] = 10, ["item"] = "camera", ["itemAmount"] = 1 },
		{ ["timer"] = 10, ["item"] = "silvercoin", ["itemAmount"] = 1 },
		{ ["timer"] = 10, ["item"] = "goldcoin", ["itemAmount"] = 1 },
		{ ["timer"] = 10, ["item"] = "watch", ["itemAmount"] = 1 },
		{ ["timer"] = 10, ["item"] = "bracelet", ["itemAmount"] = 1 },
		{ ["timer"] = 10, ["item"] = "WEAPON_BRICK", ["itemAmount"] = 3 },
		{ ["timer"] = 10, ["item"] = "WEAPON_SHOES", ["itemAmount"] = 2 },
		{ ["timer"] = 10, ["item"] = "dices", ["itemAmount"] = 1 },
		{ ["timer"] = 10, ["item"] = "cup", ["itemAmount"] = 1 }
	},
	["fishfillet"] = {
		{ ["timer"] = 10, ["need"] = "fishfillet", ["needAmount"] = 1, ["item"] = "cookedfishfillet", ["itemAmount"] = 1 }
	},
	["marshmallow"] = {
		{ ["timer"] = 10, ["need"] = "sugar", ["needAmount"] = 4, ["item"] = "marshmallow", ["itemAmount"] = 1 }
	},
	["animalmeat"] = {
		{ ["timer"] = 10, ["need"] = "meat", ["needAmount"] = 1, ["item"] = "cookedmeat", ["itemAmount"] = 1 }
	},
	["emptybottle"] = {
		{ ["timer"] = 2, ["need"] = "emptybottle", ["needAmount"] = 1, ["item"] = "water", ["itemAmount"] = 1 }
	},
	["packagebox"] = {
		{ ["timer"] = 5, ["item"] = "packagebox", ["itemAmount"] = 1 }
	},
	["laundry"] = {
		{ ["timer"] = 60, ["need"] = "dollars2", ["needAmount"] = 1000, ["item"] = "dollars", ["itemAmount"] = 1000 }
	},
	["foodjuice"] = {
		{ ["timer"] = 10, ["item"] = "foodjuice", ["itemAmount"] = 1 }
	},
	["foodburger"] = {
		{ ["timer"] = 10, ["item"] = "foodburger", ["itemAmount"] = 1 }
	},
	["foodbox"] = {
		{ ["timer"] = 10, ["need"] = {
			{ ["item"] = "foodburger", ["amount"] = 1 },
			{ ["item"] = "foodjuice", ["amount"] = 1 }
		}, ["needAmount"] = 1, ["item"] = "foodbox", ["itemAmount"] = 1 }
	},
	["foodboxtoy"] = {
		{ ["timer"] = 10, ["need"] = {
				{ ["item"] = "drugtoy", ["amount"] = 1 }
			}, ["needAmount"] = 1, ["item"] = "foodboxtoy", ["itemAmount"] = 1
		}
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- STEALPEDS
-----------------------------------------------------------------------------------------------------------------------------------------
StealPeds = {
	{ ["Item"] = "dollars2", ["Min"] = 150, ["Max"] = 225 }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- STEALITENS
-----------------------------------------------------------------------------------------------------------------------------------------
StealItens = {
	{ ["Item"] = "dollars2", ["Min"] = 150, ["Max"] = 225 }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- LOOTITENS
-----------------------------------------------------------------------------------------------------------------------------------------
LootItens = {
	["Medic"] = {
		["Players"] = {},
		["Cooldown"] = 3600,
		["List"] = {
			{ ["item"] = "alcohol", ["min"] = 2, ["max"] = 4 },
			{ ["item"] = "codeine", ["min"] = 2, ["max"] = 4 },
			{ ["item"] = "amphetamine", ["min"] = 2, ["max"] = 4 },
			{ ["item"] = "acetone", ["min"] = 2, ["max"] = 4 },
			{ ["item"] = "saline", ["min"] = 2, ["max"] = 4 },
			{ ["item"] = "sulfuric", ["min"] = 2, ["max"] = 4 },
			{ ["item"] = "expectorant", ["min"] = 2, ["max"] = 4 },
			{ ["item"] = "syringe", ["min"] = 2, ["max"] = 4 }
		}
	},
	["Weapons"] = {
		["Players"] = {},
		["Cooldown"] = 3600,
		["List"] = {
			{ ["item"] = "pistolbody", ["min"] = 1, ["max"] = 2 },
			{ ["item"] = "smgbody", ["min"] = 1, ["max"] = 2 },
			{ ["item"] = "riflebody", ["min"] = 1, ["max"] = 2 },
			{ ["item"] = "roadsigns", ["min"] = 2, ["max"] = 4 },
			{ ["item"] = "techtrash", ["min"] = 2, ["max"] = 4 },
			{ ["item"] = "sheetmetal", ["min"] = 2, ["max"] = 4 },
			{ ["item"] = "explosives", ["min"] = 2, ["max"] = 4 },
			{ ["item"] = "aluminum", ["min"] = 6, ["max"] = 8 },
			{ ["item"] = "copper", ["min"] = 6, ["max"] = 8 }
		}
	},
	["Supplies"] = {
		["Players"] = {},
		["Cooldown"] = 3600,
		["List"] = {
			{ ["item"] = "vote", ["min"] = 2, ["max"] = 4 },
			{ ["item"] = "tarp", ["min"] = 2, ["max"] = 4 },
			{ ["item"] = "techtrash", ["min"] = 2, ["max"] = 4 },
			{ ["item"] = "sheetmetal", ["min"] = 2, ["max"] = 4 },
			{ ["item"] = "roadsigns", ["min"] = 2, ["max"] = 4 },
			{ ["item"] = "sulfuric", ["min"] = 2, ["max"] = 4 },
			{ ["item"] = "saline", ["min"] = 2, ["max"] = 4 },
			{ ["item"] = "alcohol", ["min"] = 2, ["max"] = 4 },
			{ ["item"] = "explosives", ["min"] = 2, ["max"] = 4 },
			{ ["item"] = "aluminum", ["min"] = 4, ["max"] = 8 },
			{ ["item"] = "copper", ["min"] = 4, ["max"] = 8 },
			{ ["item"] = "chlorine", ["min"] = 1, ["max"] = 2 }
		}
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- HUNTERINFLUENCE
-----------------------------------------------------------------------------------------------------------------------------------------
HunterInfluence = {
	{ 2203.71, 5595.54, 53.73, 400 },
	{ 2116.84, 1943.06, 93.63, 400 },
	{ -2096.91, 2341.5, 33.28, 400 }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- MICROSCOPE
-----------------------------------------------------------------------------------------------------------------------------------------
Microscope = {
	{ 482.95, -988.61, 30.68 },
	{ 312.47, -562.1, 43.29 },
	{ 368.33, -1592.01, 25.44 },
	{ 1772.18, 2577.82, 45.73 }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- DIVERLIST
-----------------------------------------------------------------------------------------------------------------------------------------
DiverList = {
    { ["Item"] = "gold_pure", ["Min"] = 5, ["Max"] = 10 },
    { ["Item"] = "gemstone", ["Min"] = 1, ["Max"] = 2 },
    { ["Item"] = "glassbottle", ["Min"] = 3, ["Max"] = 6 },
    { ["Item"] = "dollars", ["Min"] = 275, ["Max"] = 575 }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY
-----------------------------------------------------------------------------------------------------------------------------------------
function Baixada.Inventory()
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		if GetPlayerRoutingBucket(source) < 900000 then
			if vRP.CheckRolepass(source) then
				TriggerEvent("vRP:Rewards",source)
			end
		end

		local Inventory = {}
		local Inv = vRP.Inventory(Passport)
		for Index,v in pairs(Inv) do
			if (parseInt(v["amount"]) <= 0 or not itemBody(v["item"])) then
				vRP.RemoveItem(Passport,v["item"],parseInt(v["amount"]),false)
			else
				v["amount"] = parseInt(v["amount"])
				v["peso"] = itemWeight(v["item"])
				v["index"] = itemIndex(v["item"])
				v["name"] = itemName(v["item"])
				v["key"] = v["item"]
				v["slot"] = Index

				v["desc"] = "<item>"..v["name"].."</item>"

				local Split = splitString(v["item"])
				local Description = itemDescription(v["item"])

				if Description then
					v["desc"] = v["desc"].."<br><description>"..Description.."</description>"
				else
					if Split[1] == "identity" or Split[1] == "fidentity" then
						local Number = parseInt(Split[2])
						local Identity = vRP.Identity(Number)

						if Split[1] == "fidentity" then
							Identity = vRP.FalseIdentity(Number)
						end

						if Identity then
							v["Port"] = "Não"
							v["Medic"] = "Inativo"
							v["Passport"] = Number
							v["Premium"] = "Inativo"
							v["Rolepass"] = "Inativo"
							v["Blood"] = Sanguine(Identity["Blood"])
							v["Name"] = Identity["Name"].." "..Identity["Lastname"]

							if Identity["Gun"] == 1 then
								v["Port"] = "Sim"
							end

							if Number == Passport and Split[1] == "identity" then
								if Identity["Medic"] > os.time() then
									v["Medic"] = MinimalTimers(Identity["Medic"] - os.time())
								end

								if Identity["Premium"] > os.time() then
									v["Premium"] = MinimalTimers(Identity["Premium"] - os.time())
								end

								if Identity["Rolepass"] > 0 then
									v["Rolepass"] = "Ativo"
								end
							end

							if Split[1] == "fidentity" then
								v["desc"] = v["desc"].."<br><description>Número: <green>"..v["Passport"].."</green>.<br>Nome: <green>"..v["Name"].."</green>.<br>Tipo Sanguíneo: <green>"..v["Blood"].."</green>.<br>Porte de Armas: <green>"..v["Port"].."</green>.</description>"
							else
								v["desc"] = v["desc"].."<br><description>Número: <green>"..v["Passport"].."</green>.<br>Nome: <green>"..v["Name"].."</green>.<br>Tipo Sanguíneo: <green>"..v["Blood"].."</green>.<br>Porte de Armas: <green>"..v["Port"].."</green>.<br>Plano Médico: <green>"..v["Medic"].."</green>.<br>Passe Mensal: <green>"..v["Rolepass"].."</green>.<br>Premium: <green>"..v["Premium"].."</green>.</description>"
							end
						end
					end

					if Split[1] == "driverlicense" then
						local Number = parseInt(Split[2])
						local Identity = vRP.Identity(Number)
						if Identity then
							v["Passport"] = Number
							v["Driverlicense"] = "Inativa"
							v["Name"] = Identity["Name"].." "..Identity["Lastname"]

							if Number == Passport then
								if Identity["Driver"] == 1 then
									v["Driverlicense"] = "Ativa"
								elseif Identity["Driver"] == 2 then
									v["Driverlicense"] = "Apreendida"
								end
							end

							v["desc"] = v["desc"].."<br><description>Número: <green>"..v["Passport"].."</green>.<br>Nome: <green>"..v["Name"].."</green>.<br>Habilitação: <green>"..v["Driverlicense"].."</green>.</description>"
						end
					end

					if Split[1] == "vehkey" then
						v["desc"] = v["desc"].."<br><description>Placa do Veículo: <green>"..Split[2].."</green>.</description>"
					end

					if Split[1] == "card" then
						v["desc"] = v["desc"].."<br><description>Saldo bancário disponível: <green>$"..parseFormat(vRP.GetBank(source)).."</green>.</description>"
					end

					if Split[1] == "paper" and Split[2] then
						v["desc"] = v["desc"].."<br><description>"..vRP.GetServerData(v["item"])..".</description>"
					end

					if itemType(Split[1]) == "Armamento" and Split[3] then
						v["desc"] = v["desc"].."<br><description>Nome de registro: <green>"..vRP.FullName(Split[3]).."</green>.</description>"
					end

					if Split[1] == "evidence01" or Split[1] == "evidence02" and Split[2] then
						v["desc"] = v["desc"].."<br><description>Tipo sanguíneo encontrado: <green>"..Sanguine(vRP.Identity(Split[2])["Blood"]).."</green>.</description>"
					end

					if Split[1] == "weedclone" or Split[1] == "weedbud" or Split[1] == "joint" then
						local Item = "da clonagem"
						if Split[1] == "weedbud" then
							Item = "da folha"
						elseif Split[1] == "joint" then
							Item = "do baseado"
						end

						v["desc"] = v["desc"].."<br><description>A pureza "..Item.." se encontra em <green>"..(Split[2] or 0).."%</green>.</description>"
					end
				end

				local Max = itemMaxAmount(v["item"])
				if not Max then
					Max = "S/L"
				end

				v["desc"] = v["desc"].."<br><legenda>Economia: <r>"..itemEconomy(v["item"]).."</r> <s>|</s> Máximo: <r>"..Max.."</r></legenda>"

				if Split[2] then
					if itemCharges(v["item"]) then
						v["charges"] = parseInt(Split[2] * 33)
					end

					if itemDurability(v["item"]) then
						v["durability"] = parseInt(os.time() - Split[2])
						v["days"] = itemDurability(v["item"])
					end
				end

				Inventory[Index] = v
			end
		end

		return Inventory,vRP.InventoryWeight(Passport),vRP.GetWeight(Passport)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SEND
-----------------------------------------------------------------------------------------------------------------------------------------
function Baixada.Send(Slot,Amount)
	local source = source
	local Slot = tostring(Slot)
	local Amount = parseInt(Amount,true)
	local Passport = vRP.Passport(source)
	if Passport and not Active[Passport] and not exports["hud"]:Wanted(Passport) then
		local ClosestPed = vRPC.ClosestPed(source,2)
		if ClosestPed then
			Active[Passport] = os.time() + 100

			local Inv = vRP.Inventory(Passport)
			if not Inv[Slot] or not Inv[Slot]["item"] then
				Active[Passport] = nil

				return
			end

			local Item = Inv[Slot]["item"]
			if vRP.CheckDamaged(Item) or itemBlock(Item) then
				Active[Passport] = nil

				return
			end

			local OtherPassport = vRP.Passport(ClosestPed)
			if not vRP.MaxItens(OtherPassport,Item,Amount) then
				if (vRP.InventoryWeight(OtherPassport) + itemWeight(Item) * Amount) <= vRP.GetWeight(OtherPassport) then
					Active[Passport] = os.time() + 3
					Player(source)["state"]["Cancel"] = true
					Player(source)["state"]["Buttons"] = true
					Player(ClosestPed)["state"]["Cancel"] = true
					Player(ClosestPed)["state"]["Buttons"] = true
					vRPC.CreateObjects(source,"mp_safehouselost@","package_dropoff","prop_paper_bag_small",16,28422,0.0,-0.05,0.05,180.0,0.0,0.0)

					repeat
						if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
							vRPC.Destroy(source)
							Active[Passport] = nil
							Player(source)["state"]["Cancel"] = false
							Player(source)["state"]["Buttons"] = false
							Player(ClosestPed)["state"]["Cancel"] = false
							Player(ClosestPed)["state"]["Buttons"] = false

							if vRP.TakeItem(Passport,Item,Amount,true,Slot) then
								vRP.GiveItem(OtherPassport,Item,Amount,true)
								TriggerClientEvent("inventory:Update",source,"Backpack")
								TriggerClientEvent("inventory:Update",ClosestPed,"Backpack")
							end
						end

						Wait(100)
					until not Active[Passport]
				else
					TriggerClientEvent("Notify",source,"vermeho","Mochila cheia.","Aviso",5000)
				end
			else
				TriggerClientEvent("Notify",source,"vermeho","Limite atingido.","Aviso",5000)
			end

			Active[Passport] = nil
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DELIVER
-----------------------------------------------------------------------------------------------------------------------------------------
function Baixada.Deliver(Work)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and not Active[Passport] then
		Active[Passport] = os.time() + 100

		if Work == "Lumberman" then
			local RandLogs = math.random(5)

			if not vRPC.LastVehicle(source,"ratloader") then
				TriggerClientEvent("Notify",source,"amarelo","Precisa utilizar o veículo do <b>Lenhador</b>.","Atenção",5000)
				Active[Passport] = nil

				return false
			end

			if vRP.TakeItem(Passport,"woodlog",RandLogs,true,Slot) then
				local Experience = vRP.GetExperience(Passport,"Lumberman")
				local Level = ClassCategory(Experience)
				local Valuation = 150

				if Level == 2 or Level == 3 then
					Valuation = Valuation + 25
				elseif Level == 4 or Level == 5 then
					Valuation = Valuation + 30
				elseif Level == 6 or Level == 7 then
					Valuation = Valuation + 35
				elseif Level == 8 or Level == 9 then
					Valuation = Valuation + 40
				elseif Level == 10 then
					Valuation = Valuation + 50
				end

				if exports["party"]:DoesExist(Passport) then
					local Members = exports["party"]:Room(Passport,source,10)
					if parseInt(#Members) >= 2 then
						Valuation = Valuation + (Valuation * 0.1)
					end
				end

				if Buffs["Dexterity"][Passport] and Buffs["Dexterity"][Passport] > os.time() then
					Valuation = Valuation + (Valuation * 0.1)
				end

				vRP.GenerateItem(Passport,"dollars",Valuation,true)
				Active[Passport] = nil

				return true
			else
				TriggerClientEvent("Notify", source, "amarelo", "Você precisa de <b>"..RandLogs.."x "..itemName("woodlog").."</b>.", "Atenção", 5000)
			end
		elseif Work == "Transporter" then
			if not vRPC.LastVehicle(source,"stockade") then
				TriggerClientEvent("Notify",source,"amarelo","Precisa utilizar o veículo do <b>Transportador</b>.","Atenção",5000)
				Active[Passport] = nil

				return false
			end

			if vRP.TakeItem(Passport,"pouch",1,true,Slot) then
				local Experience = vRP.GetExperience(Passport,"Transporter")
				local Level = ClassCategory(Experience)
				local Valuation = 60

				if Level == 2 or Level == 3 then
					Valuation = Valuation + 15
				elseif Level == 4 or Level == 5 then
					Valuation = Valuation + 25
				elseif Level == 6 or Level == 7 then
					Valuation = Valuation + 35
				elseif Level == 8 or Level == 9 then
					Valuation = Valuation + 45
				elseif Level == 10 then
					Valuation = Valuation + 50
				end

				if exports["party"]:DoesExist(Passport) then
					local Members = exports["party"]:Room(Passport,source,10)
					if parseInt(#Members) >= 2 then
						Valuation = Valuation + (Valuation * 0.1)
					end
				end

				if Buffs["Dexterity"][Passport] and Buffs["Dexterity"][Passport] > os.time() then
					Valuation = Valuation + (Valuation * 0.1)
				end

				vRP.GenerateItem(Passport,"dollars",Valuation,true)
				vRP.PutExperience(Passport,"Transporter",1)
				Active[Passport] = nil

				return true
			else
				TriggerClientEvent("Notify", source, "amarelo", "Você precisa de <b>1x "..itemName("pouch").."</b>.", "Atenção", 5000)
			end
		elseif Work == "Burgershot" then
			if vRP.TakeItem(Passport,"foodbox",1,true,Slot) then
				local Experience = vRP.GetExperience(Passport,"Delivery")
				local Level = ClassCategory(Experience)
				local Valuation = 140

				if Level == 2 or Level == 3 then
					Valuation = Valuation + 20
				elseif Level == 4 or Level == 5 then
					Valuation = Valuation + 30
				elseif Level == 6 or Level == 7 then
					Valuation = Valuation + 40
				elseif Level == 8 or Level == 9 then
					Valuation = Valuation + 50
				elseif Level == 10 then
					Valuation = Valuation + 60
				end

				if exports["party"]:DoesExist(Passport) then
					local Members = exports["party"]:Room(Passport,source,10)
					if parseInt(#Members) >= 2 then
						Valuation = Valuation + (Valuation * 0.1)
					end
				end

				if Buffs["Dexterity"][Passport] and Buffs["Dexterity"][Passport] > os.time() then
					Valuation = Valuation + (Valuation * 0.1)
				end

				if vRP.TakeItem(Passport,"dollars2",300) then
					Valuation = Valuation + 150
				end

				vRP.GenerateItem(Passport,"dollars",Valuation,true)
				vRP.PutExperience(Passport,"Delivery",1)
				Active[Passport] = nil

				return true
			else
				TriggerClientEvent("Notify", source, "amarelo", "Você precisa de <b>1x "..itemName("foodbox").."</b>.", "Atenção", 5000)
			end
		elseif Work == "Milkman" then
			local MilkItem = "milkbottle"
			local RandBottles = math.random(3)

			if vRP.TakeItem(Passport,MilkItem,RandBottles,true,Slot) then
				local Experience = vRP.GetExperience(Passport,"Delivery")
				local Level = ClassCategory(Experience)
				local Valuation = 55

				if Level == 2 or Level == 3 then
					Valuation = Valuation + 5
				elseif Level == 4 or Level == 5 then
					Valuation = Valuation + 10
				elseif Level == 6 or Level == 7 then
					Valuation = Valuation + 15
				elseif Level == 8 or Level == 9 then
					Valuation = Valuation + 20
				elseif Level == 10 then
					Valuation = Valuation + 25
				end

				if exports["party"]:DoesExist(Passport) then
					local Members = exports["party"]:Room(Passport,source,10)
					if parseInt(#Members) >= 2 then
						Valuation = Valuation + (Valuation * 0.1)
					end
				end

				if Buffs["Dexterity"][Passport] and Buffs["Dexterity"][Passport] > os.time() then
					Valuation = Valuation + (Valuation * 0.1)
				end

				if vRP.TakeItem(Passport,"dollars2",300) then
					Valuation = Valuation + 150
				end

				vRP.GenerateItem(Passport,"dollars",Valuation,true)
				vRP.PutExperience(Passport,"Delivery",1)
				Active[Passport] = nil

				return true
			else
				TriggerClientEvent("Notify", source, "amarelo", "Você precisa de <b>"..RandBottles.."x "..itemName(MilkItem).."</b>.", "Atenção", 5000)
			end
		elseif Work == "Ballas" or Work == "Families" or Work == "Vagos" or Work == "Aztecas" or Work == "Bloods" then
			vRP.GenerateItem(Passport,"dollars3",100,true)
			Active[Passport] = nil

			return true
		end

		Active[Passport] = nil
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- WATERS
-----------------------------------------------------------------------------------------------------------------------------------------
local Waters = {
	["soap"] = true,
	["scuba"] = true,
	["fishingrod"] = true,
	["oxygencylinder"] = true
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- USE
-----------------------------------------------------------------------------------------------------------------------------------------
function Baixada.Use(Slot,Amount)
	local source = source
	local Slot = tostring(Slot)
	local Amount = parseInt(Amount)
	local Passport = vRP.Passport(source)
	if Passport and not Active[Passport] then
		if Amount <= 0 then Amount = 1 end

		local Inventory = vRP.Inventory(Passport)
		if not Inventory[Slot] or not Inventory[Slot]["item"] then
			return
		end

		local Split = splitString(Inventory[Slot]["item"], "-")
		local Full = Inventory[Slot]["item"]
		local Item = Split[1]

		if Player(source)["state"]["Handcuff"] and Item ~= "lockpick" then
			return
		end

		if itemDurability(Full) and vRP.CheckDamaged(Full) then
			TriggerClientEvent("Notify",source,"amarelo","<b>"..itemName(Item).."</b> danificado.","Atenção",5000)

			return
		end

		if Item ~= "rope"or Item ~= "soap" then
			if (Waters[Item] and not vCLIENT.Water(source)) or (not Waters[Item] and vCLIENT.Water(source)) then
				return
			end
		end

		if itemType(Full) == "Armamento" and parseInt(Slot) <= 5 and not Player(source)["state"]["Safezone"] then
			if vRPC.InsideVehicle(source) and not itemVehicle(Full) then
				return
			end

			if vCLIENT.CheckArms(source) then
				TriggerClientEvent("Notify",source,"vermelho","Mão machucada.","Aviso",5000)

				return
			end

			if vCLIENT.ReturnWeapon(source) then
				local Check,AmmoClip,Weapon = vCLIENT.StoreWeapon(source)

				if Check then
					local Ammunation = itemAmmo(Weapon)
					if Ammunation then
						if AmmoClip > 0 then
							if not Ammos[Passport] then
								Ammos[Passport] = {}
							end

							Ammos[Passport][Ammunation] = AmmoClip
						else
							if Ammos[Passport] and Ammos[Passport][Ammunation] then
								Ammos[Passport][Ammunation] = nil
							end
						end
					end

					TriggerClientEvent("NotifyItens",source,{ "-",itemIndex(Weapon),1,itemName(Weapon) })
					exports["inventory"]:CleanWeapons(Passport,false)
				end
			else
				local Attach = {}
				local AmmoClip = 0
				local Ammunation = itemAmmo(Item)
				if Ammunation then
					if Ammos[Passport] and Ammos[Passport][Ammunation] then
						AmmoClip = Ammos[Passport][Ammunation]
					end
				end

				if vCLIENT.ExistAttachs(source,Item) then
					if Attachs[Passport] and Attachs[Passport][Item] then
						Attach = Attachs[Passport][Item]
					end
				end

				if vCLIENT.TakeWeapon(source,Item,AmmoClip,Attach) then
					TriggerClientEvent("NotifyItens",source,{ "+",itemIndex(Full),1,itemName(Full) })
				end
			end
		elseif itemType(Full) == "Munição" then
			local Check,AmmoClip,Weapon = vCLIENT.InfoWeapon(source,Item)

			if Check then
				if Weapon == "WEAPON_PETROLCAN" then
					if (AmmoClip + Amount) > 4500 then
						Amount = 4500 - AmmoClip
					end
				elseif Weapon == "WEAPON_FIREEXTINGUISHER" then
					if (AmmoClip + Amount) > 2000 then
						Amount = 2000 - AmmoClip
					end
				elseif Weapon == "WEAPON_RPG" then
					if (AmmoClip + Amount) > 20 then
						Amount = 20 - AmmoClip
					end
				else
					if (AmmoClip + Amount) > 250 then
						Amount = 250 - AmmoClip
					end
				end

				if Item ~= itemAmmo(Weapon) or Amount <= 0 then
					return
				end

				if vRP.TakeItem(Passport,Full,Amount,false,Slot) then
					if not Ammos[Passport] then
						Ammos[Passport] = {}
					end

					Ammos[Passport][Item] = AmmoClip + Amount

					TriggerClientEvent("NotifyItens",source,{ "+",itemIndex(Full),Amount,itemName(Full) })
					TriggerClientEvent("inventory:Update",source,"Backpack")
					vCLIENT.Reloading(source,Weapon,Amount)
				end
			end
		elseif itemType(Full) == "Throwing" then
			if vCLIENT.ReturnWeapon(source) then
				local Check,AmmoClip,Weapon = vCLIENT.StoreWeapon(source)

				if Check then
					local Amunnation = itemAmmo(Weapon)
					if Amunnation then
						if AmmoClip > 0 then
							if not Ammos[Passport] then
								Ammos[Passport] = {}
							end

							Ammos[Passport][Amunnation] = AmmoClip
						else
							if Ammos[Passport] and Ammos[Passport][Amunnation] then
								Ammos[Passport][Amunnation] = nil
							end
						end
					end

					TriggerClientEvent("NotifyItens",source,{ "-",itemIndex(Weapon),1,itemName(Weapon) })
					exports["inventory"]:CleanWeapons(Passport,false)
				end
			else
				if vCLIENT.TakeWeapon(source,Item,1,nil,Full) then
					TriggerClientEvent("NotifyItens",source,{ "+",itemIndex(Full),1,itemName(Full) })
				end
			end
		elseif Item == "ATTACH_FLASHLIGHT" or Item == "ATTACH_CROSSHAIR" or Item == "ATTACH_SILENCER" or Item == "ATTACH_MAGAZINE" or Item == "ATTACH_GRIP" then
			local Weapon = vCLIENT.ReturnWeapon(source)
			if Weapon then
				if vCLIENT.CheckAttachs(source,Item,Weapon) then
					if not Attachs[Passport] then
						Attachs[Passport] = {}
					end

					if not Attachs[Passport][Weapon] then
						Attachs[Passport][Weapon] = {}
					end

					if not Attachs[Passport][Weapon][Item] then
						if vRP.TakeItem(Passport,Full,1,false,Slot) then
							TriggerClientEvent("NotifyItens",source,{ "+",itemIndex(Full),1,itemName(Full) })
							TriggerClientEvent("inventory:Update",source,"Backpack")
							Attachs[Passport][Weapon][Item] = true
							vCLIENT.Attachs(source,Item,Weapon)
						end
					else
						TriggerClientEvent("Notify",source,"amarelo","O armamento já possui um componente equipado.","Atenção",5000)
					end
				else
					TriggerClientEvent("Notify",source,"amarelo","O armamento já possui um componente equipado.","Atenção",5000)
				end
			end
		elseif Use[Item] then
			Use[Item](source,Passport,Amount,Slot,Full,Item,Split)
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:SAVETEMPORARY
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("inventory:saveTemporary",function(Passport)
	exports["inventory"]:CleanWeapons(Passport,false)

	if not Temporary[Passport] and Ammos[Passport] and Attachs[Passport] then
		Temporary[Passport] = {
			["Ammos"] = Ammos[Passport],
			["Attachs"] = Attachs[Passport]
		}

		Attachs[Passport] = {
			["WEAPON_COMBATPISTOL"] = {
				["ATTACH_FLASHLIGHT"] = true
			},
			["WEAPON_PISTOL_MK2"] = {
				["ATTACH_FLASHLIGHT"] = true,
				["ATTACH_CROSSHAIR"] = true
			}
		}

		Ammos[Passport] = {
			["WEAPON_PISTOL_AMMO"] = 250
		}
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:APPLYTEMPORARY
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("inventory:applyTemporary", function(Passport)
	exports["inventory"]:CleanWeapons(Passport, true)

	if Temporary[Passport] and Ammos[Passport] and Attachs[Passport] then
		Attachs[Passport] = Temporary[Passport]["Attachs"]
		Ammos[Passport] = Temporary[Passport]["Ammos"]
		Temporary[Passport] = nil
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CANCEL
-----------------------------------------------------------------------------------------------------------------------------------------
function Baixada.Cancel()
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		if Active[Passport] ~= nil then
			Active[Passport] = nil
			vGARAGE.UpdateHotwired(source, false)
			Player(source)["state"]["Buttons"] = false
			TriggerClientEvent("Progress", source, "Cancelando", 1000)

			if VerifyObjects[Passport] then
				local Model = VerifyObjects[Passport][1]
				local Hash = VerifyObjects[Passport][2]

				if Trashs[Model] then
					if Trashs[Model][Hash] then
						Trashs[Model][Hash] = nil
					end
				end

				if Pumpjack[Model] then
					if Pumpjack[Model][Hash] then
						Pumpjack[Model][Hash] = nil
					end
				end

				VerifyObjects[Passport] = nil
			end

			if VerifyAnimals[Passport] then
				local Model = VerifyAnimals[Passport][1]

				if Animals[Model] then
					local netObjects = VerifyAnimals[Passport][2]

					if Animals[Model][netObjects] then
						Animals[Model][netObjects] = Animals[Model][netObjects] - 1
						VerifyAnimals[Passport] = nil
					end
				end
			end

			if Loots[Passport] then
				local myLoots = Loots[Passport]

				if Boxes[myLoots] then
					if Boxes[myLoots][Passport] then
						Boxes[myLoots][Passport] = nil
					end
				end

				Loots[Passport] = nil
			end
		end

		if Scanners[Passport] then
			TriggerClientEvent("inventory:updateScanner", source, false)
			TriggerClientEvent("inventory:ScannerBlips", source)
			Player(source)["state"]["Buttons"] = false
			Player(source)["state"]["Scanner"] = false
			Scanners[Passport] = nil
		end

		if Player(source)["state"]["Camera"] then
			TriggerClientEvent("inventory:Camera",source)
		end

		vRPC.Destroy(source)

		if GetPlayerRoutingBucket(source) > 900000 then
			TriggerEvent("arena:Cancel", source, Passport)
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- VERIFYWEAPON
-----------------------------------------------------------------------------------------------------------------------------------------
function Baixada.VerifyWeapon(Item,Ammo)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and not vRP.ConsultItem(Passport,Item,1) then
		local Ammunation = itemAmmo(Item)
		if Ammunation and Ammos[Passport] and Ammos[Passport][Ammunation] then
			if Ammo and Ammo > 0 then
				Ammos[Passport][Ammunation] = Ammo
			end

			if Ammos[Passport][Ammunation] > 0 then
				vRP.GenerateItem(Passport,Ammunation,Ammos[Passport][Ammunation])
				Ammos[Passport][Ammunation] = nil
			end
		end

		if Attachs[Passport] and Attachs[Passport][Item] then
			for Component,_ in pairs(Attachs[Passport][Item]) do
				vRP.GenerateItem(Passport,Component,1)
			end

			Attachs[Passport][Item] = nil
		end

		TriggerClientEvent("inventory:Update",source,"Backpack")
		exports["inventory"]:CleanWeapons(Passport,false)

		return false
	end

	return true
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKEXISTWEAPONS
-----------------------------------------------------------------------------------------------------------------------------------------
function Baixada.CheckExistWeapons(Item)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and Item ~= "" and Item and not vRP.ConsultItem(Passport,Item,1) then
		return true
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- REMOVETHROWING
-----------------------------------------------------------------------------------------------------------------------------------------
function Baixada.RemoveThrowing(Item)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and Item ~= "" and Item ~= nil then
		vRP.TakeItem(Passport,Item,1)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PREVENTWEAPONS
-----------------------------------------------------------------------------------------------------------------------------------------
function Baixada.PreventWeapons(Item,Ammo)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and Ammos[Passport] then
		local Ammunation = itemAmmo(Item)

		if Ammunation and Ammos[Passport][Ammunation] then
			if Ammo > 0 then
				Ammos[Passport][Ammunation] = Ammo
			else
				Ammos[Passport][Ammunation] = nil
				exports["inventory"]:CleanWeapons(Passport,false)
			end
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- VERIFYOBJECTS
-----------------------------------------------------------------------------------------------------------------------------------------
function Baixada.VerifyObjects(Entity,Service)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and not Active[Passport] then
		if Service == "Parkimeter" then
			local ConsultNails = vRP.InventoryItemAmount(Passport, "WEAPON_NAIL_AMMO")
			if ConsultNails[1] <= 0 then
				TriggerClientEvent("Notify",source,"amarelo","Você precisa de <b>1x "..itemName("WEAPON_NAIL_AMMO").."</b>.","Atenção",5000)
				return
			end
		elseif Service == "Pumpjack" then
			if not vCLIENT.CheckWeapon(source, "WEAPON_CROWBAR") then
				TriggerClientEvent("Notify",source,"amarelo","Você precisa colocar o <b>"..itemName("WEAPON_CROWBAR").."</b> em mãos.","Atenção",5000)
				return
			end
		elseif Service == "Gasoline" then
			if not vCLIENT.CheckWeapon(source, "WEAPON_PETROLCAN") then
				TriggerClientEvent("Notify",source,"amarelo","Você precisa colocar o <b>"..itemName("WEAPON_PETROLCAN").."</b> em mãos.","Atenção",5000)
				return
			end
		end

		if Entity[1] ~= nil and Entity[2] ~= nil and Entity[4] ~= nil then
			local Hash = Entity[1]
			local Model = Entity[2]
			local Coords = Entity[4]

			if not VerifyObjects[Passport] then
				if not Trashs[Model] then
					Trashs[Model] = {}
				end

				if not Pumpjack[Model] then
					Pumpjack[Model] = {}
				end

				for k, v in pairs(Trashs[Model]) do
					if k == Hash and os.time() <= v["timer"] then
						local Cooldown = MinimalTimers(v["timer"] - os.time())
						TriggerClientEvent("Notify", source, "azul", "Aguarde <b>" .. Cooldown .. "</b>.", false, 5000)
						return
					end
				end

				for k, v in pairs(Pumpjack[Model]) do
					if k == Hash and os.time() <= v["timer"] then
						local Cooldown = MinimalTimers(v["timer"] - os.time())
						TriggerClientEvent("Notify", source, "azul", "Aguarde <b>" .. Cooldown .. "</b>.", false, 5000)
						return
					end
				end

				if Service == "Parkimeter" then
					vRP.RemoveItem(Passport, "WEAPON_NAIL_AMMO", 1, true)
				end

				if Service == "CarWreck" then
					Active[Passport] = os.time() + 30
					TriggerClientEvent("Progress", source, "Vasculhando", 30000)
					vRPC.PlayAnim(source, false, { "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer" }, true)
				elseif Service == "Pumpjack" then
					Active[Passport] = os.time() + 60
					TriggerClientEvent("vRP:Explosion", source, Coords)
					TriggerClientEvent("Progress", source, "Roubando", 60000)
					vRPC.PlayAnim(source, false, { "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer" }, true)

					local Service = vRP.NumPermission("Policia")
					for Passports, Sources in pairs(Service) do
						async(function()
							TriggerClientEvent("NotifyPush", Sources, { code = 31, title = "Roubo de Petróleo", x = Coords["x"], y = Coords["y"], z = Coords["z"], criminal = "Alarme de segurança", blipColor = 44 })
						end)
					end
				elseif Service == "Gasoline" then
					Active[Passport] = os.time() + 60
					TriggerClientEvent("Progress", source, "Roubando", 60000)
					vRPC.PlayAnim(source, false, { "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer" }, true)

					SetTimeout(50000, function()
						vRPC.PlaySound(source, "Beep_Green", "DLC_HEIST_HACKING_SNAKE_SOUNDS")

						local Service = vRP.NumPermission("Policia")
						for Passports, Sources in pairs(Service) do
							async(function()
								TriggerClientEvent("NotifyPush", Sources, { code = 31, title = "Roubo de Gasolina", x = Coords["x"], y = Coords["y"], z = Coords["z"], criminal = "Alarme de segurança", blipColor = 44 })
							end)
						end
					end)
				elseif Service == "Bricks" then
					Active[Passport] = os.time() + 30
					TriggerClientEvent("Progress", source, "Vasculhando", 30000)
					vRPC.PlayAnim(source, false, { "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer" }, true)

					local Service = vRP.NumPermission("Policia")
					for Passports, Sources in pairs(Service) do
						async(function()
							TriggerClientEvent("NotifyPush", Sources, { code = 31, title = "Roubo de Materiais", x = Coords["x"], y = Coords["y"], z = Coords["z"], criminal = "Alarme de segurança", blipColor = 44 })
						end)
					end
				else
					Active[Passport] = os.time() + 10
					TriggerClientEvent("Progress", source, "Vasculhando", 10000)
					vRPC.PlayAnim(source, false, { "amb@prop_human_bum_bin@base", "base" }, true)
				end

				VerifyObjects[Passport] = { Model, Hash }
				Player(source)["state"]["Buttons"] = true
				TriggerClientEvent("inventory:Close", source)

				if Service == "Pumpjack" then
					Pumpjack[Model][Hash] = { ["timer"] = os.time() + 7200 }
				else
					Trashs[Model][Hash] = { ["timer"] = os.time() + 3600 }
				end

				repeat
					if os.time() >= parseInt(Active[Passport]) then
						Active[Passport] = nil
						vRPC.stopAnim(source, false)
						Player(source)["state"]["Buttons"] = false

						local itemSelect = { "", 1 }

						if Service == "Lixeiro" then
							local Experience = vRP.GetExperience(Passport, "Garbageman")
							local Level = ClassCategory(Experience)
							local Valuation = math.random(8,12)

							if Level == 4 or Level == 5 then
								Valuation = Valuation + math.random(2)
							elseif Level == 6 or Level == 7 then
								Valuation = Valuation + math.random(3)
							elseif Level == 8 or Level == 9 or Level == 10 then
								Valuation = Valuation + math.random(4)
							end

							if vRPC.LastVehicle(source, "trash") then
								local randItem = math.random(140)
								if parseInt(randItem) >= 101 and parseInt(randItem) <= 120 then
									itemSelect = { "titanium", Valuation }
								elseif parseInt(randItem) >= 81 and parseInt(randItem) <= 100 then
									itemSelect = { "metalcan", Valuation }
								elseif parseInt(randItem) >= 61 and parseInt(randItem) <= 80 then
									itemSelect = { "battery", Valuation }
								elseif parseInt(randItem) >= 41 and parseInt(randItem) <= 60 then
									itemSelect = { "elastic", Valuation }
								elseif parseInt(randItem) >= 21 and parseInt(randItem) <= 40 then
									itemSelect = { "plasticbottle", Valuation }
								elseif parseInt(randItem) <= 20 then
									itemSelect = { "glassbottle", Valuation }
								end

								vRP.PutExperience(Passport, "Garbageman", 1)
							else
								itemSelect = { "recyclable", math.random(6, 12) }
							end
						elseif Service == "Jornaleiro" then
							itemSelect = { "newspaper", math.random(3) }
						elseif Service == "Parkimeter" then
							local randPark = math.random(70)
							if parseInt(randPark) >= 31 and parseInt(randPark) <= 60 then
								itemSelect = { "goldcoin", math.random(2, 4) }
							elseif parseInt(randPark) <= 30 then
								itemSelect = { "silvercoin", math.random(3, 6) }
							end
						elseif Service == "CarWreck" then
							itemSelect = { "scrap", math.random(6, 12) }
						elseif Service == "Pumpjack" then
							local randOil = math.random(15)
							if parseInt(randOil) >= 0 and parseInt(randOil) <= 10 then
								TriggerClientEvent("vRP:Explosion", source, Coords)
								itemSelect = { "oilbarrel", 1 }
							end
						elseif Service == "Gasoline" then
							local randGasoline = math.random(15)
							if parseInt(randGasoline) >= 0 and parseInt(randGasoline) <= 10 then
								itemSelect = { "WEAPON_PETROLCAN_AMMO", math.random(500, 1000) }
							end
						elseif Service == "Bricks" then
							local randBricks = math.random(15)
							if parseInt(randBricks) >= 0 and parseInt(randBricks) <= 10 then
								itemSelect = { "WEAPON_BRICK", math.random(3, 6) }
							end
						elseif Service == "Fruits" then
							local randFruits = math.random(40)
							if parseInt(randFruits) >= 31 and parseInt(randFruits) <= 40 then
								itemSelect = { "banana", math.random(3, 6) }
							elseif parseInt(randFruits) >= 21 and parseInt(randFruits) <= 30 then
								itemSelect = { "apple", math.random(3, 6) }
							elseif parseInt(randFruits) >= 11 and parseInt(randFruits) <= 20 then
								itemSelect = { "orange", math.random(3, 6) }
							elseif parseInt(randFruits) <= 10 then
								itemSelect = { "tange", math.random(3, 6) }
							end
						end

						if itemSelect[1] == "" then
							if Service == "Parkimeter" then
								local Players = vRPC.ClosestPeds(source, 10)
								for _, v in pairs(Players) do
									async(function()
										TriggerClientEvent("Notify",v,"azul","Um <b>Parquímetro</b> próximo a você irá explodir em <b>10 Segundos</b>.",false,10000)
									end)
								end

								SetTimeout(10000, function()
									TriggerClientEvent("vRP:Explosion", source, Coords)
								end)
							elseif Service == "Gasoline" then
								local Players = vRPC.ClosestPeds(source, 10)
								for _, v in pairs(Players) do
									async(function()
										TriggerClientEvent("Notify",v,"azul","Uma <b>Bomba de Gasolina</b> próxima a você irá explodir em <b>30 Segundos</b>.",false,30000)
									end)
								end

								SetTimeout(30000, function()
									TriggerClientEvent("vRP:Explosion", source, Coords)
								end)
							elseif Service == "Pumpjack" then
								TriggerClientEvent("Notify",source,"vermelho","<b>Bomba de Vareta de Sucção</b> vazia.","Aviso",5000)
							elseif Service == "Gasoline" then
								TriggerClientEvent("Notify",source,"vermelho","<b>Bomba de Gasolina</b> vazia.","Aviso",5000)
							elseif Service == "Lixeiro" then
								local RandomCough = math.random(100)
								if RandomCough >= 50 then
									vRP.UpgradeCough(Passport, math.random(2))
								end

								TriggerClientEvent("Notify",source,"vermelho","Nada encontrado.","Aviso",5000)
							else
								TriggerClientEvent("Notify",source,"vermelho","Nada encontrado.","Aviso",5000)
							end

							vRP.UpgradeStress(Passport, 1)
						else
							if (vRP.InventoryWeight(Passport) + itemWeight(itemSelect[1]) * itemSelect[2]) <= vRP.GetWeight(Passport) then
								if Service == "Pumpjack" then
									vRP.GenerateItem(Passport, itemSelect[1], itemSelect[2], true)
									vRP.UpgradeStress(Passport, math.random(2, 4))
								else
									vRP.GenerateItem(Passport, itemSelect[1], itemSelect[2], true)
									vRP.UpgradeStress(Passport, 1)
								end
							else
								TriggerClientEvent("Notify", source, "vermelho", "Mochila cheia.", "Aviso", 5000)
								Trashs[Model][Hash] = nil
								Pumpjack[Model][Hash] = nil
							end
						end

						VerifyObjects[Passport] = nil
					end

					Wait(100)
				until not Active[Passport]
			end
		else
			TriggerClientEvent("Notify", source, "vermelho", "Nada encontrado.", "Aviso", 5000)
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- LOOT
-----------------------------------------------------------------------------------------------------------------------------------------
function Baixada.Loot(Entity,Service)
	local source = source
	local Entity = tostring(Entity)
	local Passport = vRP.Passport(source)
	if Passport and LootItens[Service] then
		if not Loots[Passport] and not Active[Passport] then
			if not Boxes[Entity] then
				Boxes[Entity] = {}
			end

			if Boxes[Entity][Passport] then
				if os.time() <= Boxes[Entity][Passport] then
					local Cooldown = MinimalTimers(Boxes[Entity][Passport] - os.time())
					TriggerClientEvent("Notify", source, "azul", "Aguarde <b>" .. Cooldown .. "</b>.", false, 5000)
					return
				end
			end

			Loots[Passport] = Entity
			Active[Passport] = os.time() + 10
			Player(source)["state"]["Buttons"] = true
			TriggerClientEvent("inventory:Close", source)
			TriggerClientEvent("Progress", source, "Vasculhando", 10000)
			Boxes[Entity][Passport] = os.time() + LootItens[Service]["Cooldown"]
			vRPC.PlayAnim(source,false,{ "anim@amb@clubhouse@tutorial@bkr_tut_ig3@","machinic_loop_mechandplayer" },true)

			repeat
				if os.time() >= parseInt(Active[Passport]) then
					Active[Passport] = nil
					vRPC.stopAnim(source, false)
					Player(source)["state"]["Buttons"] = false

					local randItem = math.random(#LootItens[Service]["List"])
					local randAmount = math.random(LootItens[Service]["List"][randItem]["min"],
						LootItens[Service]["List"][randItem]["max"])
					local itemSelect = { LootItens[Service]["List"][randItem]["item"], randAmount }

					if (vRP.InventoryWeight(Passport) + itemWeight(itemSelect[1]) * itemSelect[2]) <= vRP.GetWeight(Passport) then
						if Buffs["Luck"][Passport] then
							if Buffs["Luck"][Passport] > os.time() then
								vRP.GenerateItem(Passport, itemSelect[1], itemSelect[2] * 0.1, true)
							end
						else
							vRP.GenerateItem(Passport, itemSelect[1], itemSelect[2], true)
						end
					else
						TriggerClientEvent("Notify", source, "vermelho", "Mochila cheia.", "Aviso", 5000)
						Boxes[Entity][Passport] = nil
					end

					Loots[Passport] = nil
				end

				Wait(100)
			until not Active[Passport]
		end
	end
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:APPLYPLATE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("inventory:applyPlate")
AddEventHandler("inventory:applyPlate", function(Entity)
	local source = source
	local consultItem = {}
	local Plate = Entity[1]
	local Passport = vRP.Passport(source)
	if Passport and not Active[Passport] then
		if not Plates[Plate] then
			consultItem = vRP.InventoryItemAmount(Passport, "plate")
			if consultItem[1] <= 0 then
				TriggerClientEvent("Notify", source, "vermelho", "Precisa de <b>1x " .. itemName("plate") .. "</b>.",
					"Atenção", 5000)
				return
			end
		end

		local consultPliers = vRP.InventoryItemAmount(Passport, "pliers")
		if consultPliers[1] <= 0 then
			TriggerClientEvent("Notify", source, "vermelho", "Precisa de <b>1x " .. itemName("pliers") .. "</b>.", "Atenção", 5000)
			return
		end

		if Plates[Plate] ~= nil then
			if os.time() < Plates[Plate][1] then
				local plateTimers = parseInt(Plates[Plate][1] - os.time())
				if plateTimers ~= nil then
					TriggerClientEvent("Notify", source, "azul", "Aguarde " .. CompleteTimers(plateTimers) .. ".", false, 5000)
				end

				return
			end
		end

		Active[Passport] = os.time() + 10
		Player(source)["state"]["Buttons"] = true
		TriggerClientEvent("Progress", source, "Trocando", 10000)
		vRPC.PlayAnim(source, false, { "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer" }, true)

		repeat
			if os.time() >= parseInt(Active[Passport]) then
				Active[Passport] = nil
				vRPC.stopAnim(source, false)
				Player(source)["state"]["Buttons"] = false

				if not Plates[Plate] then
					if vRP.TakeItem(Passport, consultItem[2], 1, true) then
						local newPlate = vRP.GeneratePlate()
						TriggerEvent("plateEveryone", newPlate)
						Plates[newPlate] = { os.time() + 3600, Plate }

						local Network = NetworkGetEntityFromNetworkId(Entity[4])
						if DoesEntityExist(Network) and not IsPedAPlayer(Network) and GetEntityType(Network) == 2 then
							SetVehicleNumberPlateText(Network, newPlate)
						end
					end
				else
					local Network = NetworkGetEntityFromNetworkId(Entity[4])
					if DoesEntityExist(Network) and not IsPedAPlayer(Network) and GetEntityType(Network) == 2 then
						SetVehicleNumberPlateText(Network, Plates[Plate][2])
					end

					if math.random(100) >= 50 then
						vRP.GenerateItem(Passport, "plate", 1, true)
					else
						TriggerClientEvent("Notify", source, "azul", "Após remove-la a mesma quebrou.", false, 5000)
					end

					TriggerEvent("plateReveryone", Plate)
					Plates[Plate] = nil
				end
			end

			Wait(100)
		until not Active[Passport]
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- STEALTRUNK
-----------------------------------------------------------------------------------------------------------------------------------------
function Baixada.StealTrunk(Entity)
	local source = source
	local Plate = Entity[1]
	local Network = Entity[4]
	local vehModels = Entity[2]
	local Passport = vRP.Passport(source)
	if Passport and not Active[Passport] then
		if not vCLIENT.CheckWeapon(source, "WEAPON_CROWBAR") then
			TriggerClientEvent("Notify", source, "amarelo", "Você precisa colocar o <b>" .. itemName("WEAPON_CROWBAR") .. "</b> em mãos.", "Atenção", 5000)
			return
		end

		if not vRP.PassportPlate(Plate) then
			if not Trunks[Plate] then
				Trunks[Plate] = os.time()
			end

			if os.time() >= Trunks[Plate] then
				vRPC.PlayAnim(source, false, { "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer" }, true)
				Active[Passport] = os.time() + 100

				if vRP.Task(source, 4, 10500) then
					Active[Passport] = os.time() + 20
					Player(source)["state"]["Buttons"] = true
					TriggerClientEvent("Progress", source, "Vasculhando", 20000)
					TriggerClientEvent("player:Residuals", source, "Resíduo de Ferro.")
					TriggerClientEvent("player:VehicleDoors", source, Network, "open")

					repeat
						if os.time() >= parseInt(Active[Passport]) then
							Active[Passport] = nil
							vRPC.stopAnim(source, false)
							Player(source)["state"]["Buttons"] = false
							TriggerClientEvent("player:VehicleDoors", source, Network, "close")

							if not Trunks[Plate] or os.time() >= Trunks[Plate] then
								local Rand = math.random(#StealItens)
								local Amount = math.random(StealItens[Rand]["Min"],StealItens[Rand]["Max"])

								if (vRP.InventoryWeight(Passport) + itemWeight(StealItens[Rand]["Item"]) * Amount) <= vRP.GetWeight(Passport) then
									vRP.GenerateItem(Passport, StealItens[Rand]["Item"], Amount, true)
									Trunks[Plate] = os.time() + 3600
									vRP.UpgradeStress(Passport, 2)
								else
									TriggerClientEvent("Notify", source, "Aviso", "Mochila cheia.", "amarelo", 5000)
								end
							end
						end

						Wait(100)
					until not Active[Passport]
				else
					TriggerClientEvent("inventory:vehicleAlarm", source, Network, Plate)
					vRPC.stopAnim(source, false)
					Active[Passport] = nil

					local Coords = vRP.GetEntityCoords(source)
					local Service = vRP.NumPermission("Policia")
					for Passports, Sources in pairs(Service) do
						async(function()
							TriggerClientEvent("NotifyPush", Sources, { code = 31, title = "Roubo de Veículo", x = Coords["x"], y = Coords["y"], z = Coords["z"], vehicle = VehicleName(vehModels) .. " - " .. Plate, blipColor = 44 })
						end)
					end
				end
			else
				TriggerClientEvent("Notify", source, "vermelho", "Nada encontrado.", "Aviso", 5000)
			end
		else
			TriggerClientEvent("Notify", source, "amarelo", "Veículo protegido pela seguradora.", "Atenção", 1000)
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ANIMALS
-----------------------------------------------------------------------------------------------------------------------------------------
function Baixada.Animals(Entity)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		if Entity[2] ~= nil and Entity[3] ~= nil then
			local Ped = GetPlayerPed(source)
			local Coords = GetEntityCoords(Ped)
			if not vCLIENT.CheckWeapon(source, "WEAPON_SWITCHBLADE") then
				TriggerClientEvent("Notify", source, "amarelo", "Você precisa colocar o <b>" .. itemName("WEAPON_SWITCHBLADE") .. "</b> em mãos.", "Atenção", 5000)
				return
			end

			local Model = Entity[2]
			local netObjects = Entity[3]

			if not Animals[Model] then
				Animals[Model] = {}
			end

			if not Animals[Model][netObjects] then
				Animals[Model][netObjects] = 0
			end

			if not VerifyAnimals[Passport] and not Active[Passport] and Animals[Model][netObjects] < 5 then
				if (vRP.InventoryWeight(Passport) + 2.25) <= vRP.GetWeight(Passport) then
					if vRP.Task(source, 1, 10000) then
						Active[Passport] = os.time() + 10
						TriggerClientEvent("Progress", source, "Esfolando", 10000)

						if not vCLIENT.animalAnim(source) then
							vRPC.Destroy(source)
							vRPC.PlayAnim(source, false, { "amb@medic@standing@kneel@base", "base" }, true)
							vRPC.PlayAnim(source, true, { "anim@gangops@facility@servers@bodysearch@", "player_search" }, true)
						end

						Player(source)["state"]["Buttons"] = true
						TriggerClientEvent("inventory:Close", source)
						VerifyAnimals[Passport] = { Model, netObjects }
						Animals[Model][netObjects] = Animals[Model][netObjects] + 1

						repeat
							if os.time() >= parseInt(Active[Passport]) then
								Active[Passport] = nil
								VerifyAnimals[Passport] = nil
								Player(source)["state"]["Buttons"] = false

								if Animals[Model] then
									if Player(source)["state"]["Hunting"] then
										if Model == 1682622302 then
											coyoteList = { "coyote1star", "coyote2star", "coyote3star" }
											local coyoteRandom = math.random(#coyoteList)
											local coyoteSelects = coyoteList[coyoteRandom]
											vRP.GenerateItem(Passport, coyoteSelects, 1, true)
										elseif Model == 307287994 then
											mtlionList = { "mtlion1star", "mtlion2star", "mtlion3star" }
											local mtlionRandom = math.random(#mtlionList)
											local mtlionSelects = mtlionList[mtlionRandom]
											vRP.GenerateItem(Passport, mtlionSelects, 1, true)
										elseif Model == -832573324 then
											boarList = { "boar1star", "boar2star", "boar3star" }
											local boarRandom = math.random(#boarList)
											local boarSelects = boarList[boarRandom]
											vRP.GenerateItem(Passport, boarSelects, 1, true)
										elseif Model == -664053099 then
											deerList = { "deer1star", "deer2star", "deer3star" }
											local deerRandom = math.random(#deerList)
											local deerSelects = deerList[deerRandom]
											vRP.GenerateItem(Passport, deerSelects, 1, true)
										end
									else
										otherList = { "animalpelt", "meat", "animalfat", "leather" }
										local otherRandom = math.random(#otherList)
										local otherSelects = otherList[otherRandom]
										vRP.GenerateItem(Passport, otherSelects, math.random(2, 4), true)
									end

									vRPC.Destroy(source)
									Animals[Model][netObjects] = nil
									TriggerEvent("DeletePed", netObjects)
									Player(source)["state"]["Hunting"] = false
								end

								local Experience = vRP.GetExperience(Passport, "Hunter")
								local Category = ClassCategory(Experience)
								local Valuation = 100

								if Category == 1 then
									Valuation = Valuation + 10
								elseif Category == 2 then
									Valuation = Valuation + 20
								elseif Category == 3 then
									Valuation = Valuation + 30
								elseif Category == 4 then
									Valuation = Valuation + 40
								elseif Category == 5 then
									Valuation = Valuation + 50
								elseif Category == 6 then
									Valuation = Valuation + 60
								elseif Category == 7 then
									Valuation = Valuation + 70
								elseif Category == 8 then
									Valuation = Valuation + 80
								elseif Category == 9 then
									Valuation = Valuation + 90
								elseif Category == 10 then
									Valuation = Valuation + 100
								end

								if Buffs["Dexterity"][Passport] then
									if Buffs["Dexterity"][Passport] > os.time() then
										Valuation = Valuation + (Valuation * 0.1)
									end
								end

								vRP.PutExperience(Passport, "Hunter", 1)
								vRPC.stopAnim(source, false)
							end

							Wait(100)
						until not Active[Passport]
					end
				else
					TriggerClientEvent("Notify", source, "vermelho", "Mochila cheia.", "Aviso", 5000)
				end
			end
		else
			TriggerClientEvent("Notify", source, "vermelho", "Nada encontrado.", "Aviso", 5000)
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- STOREOBJECTS
-----------------------------------------------------------------------------------------------------------------------------------------
function Baixada.StoreObjects(Number)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and Objects[Number] then
		if (vRP.InventoryWeight(Passport) + itemWeight(Objects[Number]["item"])) <= vRP.GetWeight(Passport) then
			vRP.GiveItem(Passport,Objects[Number]["item"],1,true)
			TriggerClientEvent("objects:Remover",-1,Number)
			Objects[Number] = nil
		else
			TriggerClientEvent("Notify",source,"vermelho","Mochila cheia.","Aviso",5000)
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GENERATEOBJECTS
-----------------------------------------------------------------------------------------------------------------------------------------
function Baixada.GenerateObjects(Number)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and Objects[Number] then
		if (vRP.InventoryWeight(Passport) + itemWeight("oilgallon") * 3) <= vRP.GetWeight(Passport) then
			vRP.GenerateItem(Passport,"oilgallon",3,true)
			TriggerClientEvent("objects:Remover",-1,Number)
			Objects[Number] = nil
		else
			TriggerClientEvent("Notify",source,"vermelho","Mochila cheia.","Aviso",5000)
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- MAKEPRODUCTS
-----------------------------------------------------------------------------------------------------------------------------------------
function Baixada.MakeProducts(Table)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and not Active[Passport] then
		local Split = splitString(Table, "-")
		local Selected = Split[1]

		if Products[Selected] then
			if Selected == "foodjuice" or Selected == "foodburger" or Selected == "foodbox" then
				if not vRP.HasGroup(Passport,"Restaurantes") then
					return
				end
			end

			if Selected == "cemitery" and not vRP.Task(source,3,7500) then
				TriggerEvent("Wanted",source,Passport,60)

				local Coords = vRP.GetEntityCoords(source)
				local Service = vRP.NumPermission("Policia")
				for Passports, Sources in pairs(Service) do
					async(function()
						vRPC.PlaySound(Sources,"ATM_WINDOW","HUD_FRONTEND_DEFAULT_SOUNDSET")
						TriggerClientEvent("NotifyPush",Sources,{ code = 20, title = "Roubo de Pertences", x = Coords["x"], y = Coords["y"], z = Coords["z"], criminal = "Alarme de segurança", color = 16 })
					end)
				end
			end

			local Need = {}
			local Consult = {}
			local Number = math.random(#Products[Selected])

			if Products[Selected][Number]["item"] then
				if vRP.MaxItens(Passport, Products[Selected][Number]["item"], Products[Selected][Number]["itemAmount"]) then
					TriggerClientEvent("Notify", source, "vermelho", "Limite atingido.", "Aviso", 3000)
					return
				end

				if (vRP.InventoryWeight(Passport) + itemWeight(Products[Selected][Number]["item"]) * Products[Selected][Number]["itemAmount"]) > vRP.GetWeight(Passport) then
					TriggerClientEvent("Notify", source, "vermelho", "Mochila cheia.", "Aviso", 5000)
					return
				end
			end

			if Products[Selected][Number]["need"] then
				local needItem = Products[Selected][Number]["need"]

				if type(needItem) == "table" then
					for k, v in pairs(needItem) do
						Consult = vRP.InventoryItemAmount(Passport, v["item"])
						if Consult[1] < v["amount"] then
							TriggerClientEvent("Notify", source, "amarelo", "Necessário possuir <b>" .. v["amount"] .. "x " .. itemName(v["item"]) .. "</b>.", "Atenção", 5000)
							return
						end

						Need[k] = { Consult[2], v["amount"] }
					end
				else
					needAmount = Products[Selected][Number]["needAmount"]
					Consult = vRP.InventoryItemAmount(Passport, needItem)
					if Consult[1] < needAmount then
						TriggerClientEvent("Notify", source, "amarelo", "Necessário possuir <b>" .. needAmount .. "x " .. itemName(needItem) .. "</b>.", "Atenção", 5000)
						return
					end

					if Selected == "laundry" then
						Consult = vRP.InventoryItemAmount(Passport, "chlorine")
						if Consult[1] < 1 then
							TriggerClientEvent("Notify", source, "amarelo", "Necessário possuir <b>1x " .. itemName("chlorine") .. "</b>.", "Atenção", 5000)
							return
						end
					end
				end
			end

			Player(source)["state"]["Buttons"] = true
			Active[Passport] = os.time() + Products[Selected][Number]["timer"]
			TriggerClientEvent("Progress", source, "Produzindo", Products[Selected][Number]["timer"] * 1000)
			
			if Selected == "foodjuice" then
				vRPC.PlayAnim(source, false, {"amb@prop_human_parking_meter@female@idle_a","idle_a_female"}, true)
			elseif Selected == "foodburger" then
				vRPC.PlayAnim(source, false, {"anim@amb@business@coc@coc_unpack_cut@","fullcut_cycle_v6_cokecutter"}, true)
			elseif Selected == "foodbox" then
				vRPC.PlayAnim(source, false, {"amb@prop_human_parking_meter@female@idle_a","idle_a_female"}, true)
			elseif Selected == "cemitery" then
				vRPC.PlayAnim(source, false, {"amb@medic@standing@tendtodead@idle_a","idle_a"}, true)
			elseif Selected == "emptybottle" then
				vRPC.PlayAnim(source, false, {"amb@prop_human_parking_meter@female@idle_a","idle_a_female"}, true)
			elseif Selected == "paper" then
				vRPC.PlayAnim(source, false, { "anim@amb@business@coc@coc_unpack_cut@", "fullcut_cycle_v6_cokecutter" }, true)
			elseif Selected == "milkBottle" then
				vRPC.PlayAnim(source, false, { "amb@prop_human_parking_meter@female@idle_a", "idle_a_female" }, true)
			elseif Selected == "fishfillet" then
				vRPC.PlayAnim(source, false, { "anim@amb@business@coc@coc_unpack_cut@", "fullcut_cycle_v6_cokecutter" }, true)
			elseif Selected == "marshmallow" then
				vRPC.PlayAnim(source, false, { "anim@amb@business@coc@coc_unpack_cut@", "fullcut_cycle_v6_cokecutter" }, true)
			elseif Selected == "animalmeat" then
				vRPC.PlayAnim(source, false, { "anim@amb@business@coc@coc_unpack_cut@", "fullcut_cycle_v6_cokecutter" }, true)
			elseif Selected == "tablecoke" then
				vRPC.PlayAnim(source, false, { "anim@amb@business@coc@coc_unpack_cut@", "fullcut_cycle_v6_cokecutter" }, true)

				if vRP.Task(source,3,7500) then
					TriggerClientEvent("Notify", source, "verde", "Você acertou na mistura.", "Sucesso", 5000)
				else
					local Coords = vRP.GetEntityCoords(source)
					TriggerClientEvent("vRP:CoordExplosion", source, Coords["x"], Coords["y"], Coords["z"])
				end
			elseif Selected == "tablemeth" then
				vRPC.PlayAnim(source, false, { "anim@amb@business@coc@coc_unpack_cut@", "fullcut_cycle_v6_cokecutter" }, true)

				if vRP.Task(source,3,7500) then
					TriggerClientEvent("Notify", source, "verde", "Você acertou na mistura.", "Sucesso", 5000)
				else
					local Coords = vRP.GetEntityCoords(source)
					TriggerClientEvent("vRP:CoordExplosion", source, Coords["x"], Coords["y"], Coords["z"])
				end
			elseif Selected == "tableweed" then
				vRPC.PlayAnim(source, false, { "anim@amb@business@coc@coc_unpack_cut@", "fullcut_cycle_v6_cokecutter" }, true)

				if vRP.Task(source,3,7500) then
					TriggerClientEvent("Notify", source, "verde", "Você acertou na mistura.", "Sucesso", 5000)
				else
					local Coords = vRP.GetEntityCoords(source)
					TriggerClientEvent("vRP:CoordExplosion", source, Coords["x"], Coords["y"], Coords["z"])
				end
			else
				vRPC.PlayAnim(source,false,{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"},true)
			end

			repeat
				if os.time() >= parseInt(Active[Passport]) then
					Player(source)["state"]["Buttons"] = false
					vRPC.Destroy(source,"two")
					Active[Passport] = nil
					local Points = 0

					if Selected ~= "scanner" then
						vRPC.stopAnim(source, false)
					end

					if Products[Selected][Number]["need"] then
						if type(Products[Selected][Number]["need"]) == "table" then
							for k, v in pairs(Need) do
								local Split = splitString(v[1], "-")
								if Split[1] == "weedbud" and Split[2] ~= nil then
									Points = Split[2]
								end

								vRP.RemoveItem(Passport, v[1], v[2], false)
							end
						else
							vRP.RemoveItem(Passport, Consult[2], needAmount, false)
						end
					end

					if Products[Selected][Number]["item"] then
						if Selected == "tableweed" then
							vRP.GenerateItem(Passport, Products[Selected][Number]["item"] .. "-" .. Points,
								Products[Selected][Number]["itemAmount"], true)
						else
							vRP.GenerateItem(Passport, Products[Selected][Number]["item"],
								Products[Selected][Number]["itemAmount"], true)

							if Selected == "milkBottle" then
								vRP.UpgradeStress(Passport, math.random(2))
							elseif Selected == "laundry" then
								TriggerEvent("Wanted",source,Passport,60)

								vRP.UpgradeStress(Passport, math.random(2,4))
								vRP.RemoveItem(Passport, "chlorine", 1, true)
								vRP.RemoveItem(Passport, "dollars2", 1000, true)
							end
						end
					end
				end

				Wait(100)
			until not Active[Passport]
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DISMANTLE
-----------------------------------------------------------------------------------------------------------------------------------------
function Baixada.Dismantle(Entity)
	local source = source
	local vehName = Entity[2]
	local Passport = vRP.Passport(source)
	if Passport and not Active[Passport] then
		Active[Passport] = os.time() + 60
		Player(source)["state"]["Buttons"] = true
		TriggerClientEvent("inventory:Close", source)
		TriggerClientEvent("Progress", source, "Desmanchando", 60000)
		vRPC.PlayAnim(source, false, { "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer" }, true)

		repeat
			if os.time() >= parseInt(Active[Passport]) then
				Active[Passport] = nil
				vRPC.Destroy(source)
				Player(source)["state"]["Buttons"] = false
				TriggerEvent("garages:dismantleVehicle", Entity[4], Entity[1])
				TriggerClientEvent("player:Residuals", source, "Resíduo de Metal.")
				TriggerClientEvent("player:Residuals", source, "Resíduo de Alumínio.")

				local Class = 1
				if Dismantle[Passport] then
					Class = ClassCategory(Dismantle[Passport])
				end

				local AmountItens = math.random(100, 150)
				local VehSelected = "suspension"
				local VehParts = math.random(4)
				local VehRandom = 1000

				if Class == 1 then
					VehRandom = math.random(4500)
					AmountItens = math.random(150, 200)
				elseif Class == 2 then
					VehRandom = math.random(4500)
					AmountItens = math.random(150, 200)
				elseif Class == 3 then
					VehRandom = math.random(4500)
					AmountItens = math.random(150, 200)
				elseif Class == 4 then
					VehRandom = math.random(3500)
					AmountItens = math.random(200, 250)
				elseif Class == 5 then
					VehRandom = math.random(3500)
					AmountItens = math.random(200, 250)
				elseif Class == 6 then
					VehRandom = math.random(3500)
					AmountItens = math.random(200, 250)
				elseif Class == 7 then
					VehRandom = math.random(2500)
					AmountItens = math.random(250, 300)
				elseif Class == 8 then
					VehRandom = math.random(2500)
					AmountItens = math.random(250, 300)
				elseif Class == 9 then
					VehRandom = math.random(2500)
					AmountItens = math.random(250, 300)
				elseif Class == 10 then
					VehRandom = math.random(1500)
					AmountItens = math.random(350, 400)
				end

				if VehParts <= 1 then
					VehSelected = "engine"
				elseif VehParts == 2 then
					VehSelected = "transmission"
				elseif VehParts == 3 then
					VehSelected = "brake"
				end

				if VehRandom <= 10 then
					vRP.GenerateItem(Passport, VehSelected .. "e", 1, true)
				elseif VehRandom >= 10 and VehRandom <= 30 then
					vRP.GenerateItem(Passport, VehSelected .. "d", 1, true)
				elseif VehRandom >= 31 and VehRandom <= 60 then
					vRP.GenerateItem(Passport, VehSelected .. "c", 1, true)
				elseif VehRandom >= 61 and VehRandom <= 100 then
					vRP.GenerateItem(Passport, VehSelected .. "b", 1, true)
				elseif VehRandom >= 101 and VehRandom <= 150 then
					vRP.GenerateItem(Passport, VehSelected .. "a", 1, true)
				end

				if exports["party"]:DoesExist(Passport) then
					local Members = exports["party"]:Room(Passport,source,20)
					if parseInt(#Members) >= 2 then
						for _, v in pairs(Members) do
							vRP.GenerateItem(v["Passport"], "dollars", AmountItens * #Members, true)
							vRP.PutExperience(v["Passport"], "Dismantle", 2)
						end
					else
						vRP.GenerateItem(Passport, "dollars", AmountItens, true)
						vRP.PutExperience(Passport, "Dismantle", 1)
					end
				else
					vRP.GenerateItem(Passport, "dollars", AmountItens, true)
					vRP.PutExperience(Passport, "Dismantle", 1)
				end

				vRP.GenerateItem(Passport, "dismantle", 1, true)

				if math.random(1000) <= 100 then
					vRP.GenerateItem(Passport, "plate", 1, true)
				end
			end

			Wait(100)
		until not Active[Passport]
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- REMOVETYRES
-----------------------------------------------------------------------------------------------------------------------------------------
function Baixada.RemoveTyres(Entity)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and not Active[Passport] and Entity[2] ~= "veto" and Entity[2] ~= "veto2" then
		if not vCLIENT.CheckWeapon(source,"WEAPON_WRENCH") then
			TriggerClientEvent("Notify",source,"Aviso","<b>Chave Inglesa</b> não encontrada.","amarelo",5000)

			return false
		end

		local Vehicle = NetworkGetEntityFromNetworkId(Entity[4])
		if DoesEntityExist(Vehicle) and not IsPedAPlayer(Vehicle) and GetEntityType(Vehicle) == 2 then
			if vCLIENT.tyreHealth(source,Entity[4],Entity[5]) == 1000.0 then
				if vRP.MaxItens(Passport,"tyres",1) then
					TriggerClientEvent("Notify",source,"Aviso","Limite atingido.","amarelo",5000)

					return false
				end

				if vRP.Task(source,3,5000) then
					Active[Passport] = os.time() + 10
					TriggerClientEvent("Progress",source,"Removendo",10000)

					repeat
						if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
							Active[Passport] = nil

							local Vehicle = NetworkGetEntityFromNetworkId(Entity[4])
							if DoesEntityExist(Vehicle) and not IsPedAPlayer(Vehicle) and GetEntityType(Vehicle) == 2 then
								if vCLIENT.tyreHealth(source,Entity[4],Entity[5]) == 1000.0 then
									local Players = vRPC.Players(source)
									for _,v in pairs(Players) do
										async(function()
											TriggerClientEvent("inventory:explodeTyres",v,Entity[4],Entity[1],Entity[5])
										end)
									end

									vRP.GenerateItem(Passport,"tyres",1,true)
								end
							end
						end

						Wait(100)
					until not Active[Passport]
				end
			end
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:DRINK
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("inventory:Drink")
AddEventHandler("inventory:Drink",function()
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and not Active[Passport] then
		vRPC.AnimActive(source)

		if Buffs["Luck"][Passport] then
			if Buffs["Luck"][Passport] > os.time() then
				Active[Passport] = os.time() + 5
				TriggerClientEvent("Progress",source,"Bebendo",5000)
			end
		else
			Active[Passport] = os.time() + 10
			TriggerClientEvent("Progress",source,"Bebendo",10000)
		end

		Player(source)["state"]["Buttons"] = true
		TriggerClientEvent("inventory:Close", source)
		vRPC.CreateObjects(source,"amb@world_human_drinking@coffee@male@idle_a","idle_c","prop_plastic_cup_02",49,28422)

		repeat
			if os.time() >= parseInt(Active[Passport]) then
				Active[Passport] = nil

				if Buffs["Luck"][Passport] then
					if Buffs["Luck"][Passport] > os.time() then
						if GlobalState["Temperature"] >= TemperatureHot then
							vRP.UpgradeThirst(Passport, 60)
						else
							vRP.UpgradeThirst(Passport, 30)
						end
					end
				else
					if GlobalState["Temperature"] >= TemperatureHot then
						vRP.UpgradeThirst(Passport, 30)
					else
						vRP.UpgradeThirst(Passport, 15)
					end
				end

				vRPC.Destroy(source,"one")
				Player(source)["state"]["Buttons"] = false
			end

			Wait(100)
		until not Active[Passport]
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- STEALPEDS
-----------------------------------------------------------------------------------------------------------------------------------------
function Baixada.StealPeds()
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		local Rand = math.random(#StealPeds)
		local Amount = math.random(StealPeds[Rand]["Min"],StealPeds[Rand]["Max"])

		if vRP.MaxItens(Passport,StealPeds[Rand]["Item"],Amount) then
			TriggerClientEvent("Notify",source,"vermelho","Limite atingido.","Aviso",5000)
			return true
		end

		if (vRP.InventoryWeight(Passport) + itemWeight(StealPeds[Rand]["Item"]) * Amount) <= vRP.GetWeight(Passport) then
			vRP.GenerateItem(Passport,StealPeds[Rand]["Item"],Amount,true)

			if math.random(100) >= 75 and vRP.DoesEntityExist(source) then
				TriggerEvent("Wanted",source,Passport,60)

				local Coords = vRP.GetEntityCoords(source)
				local Service = vRP.NumPermission("Policia")
				for Passports,Sources in pairs(Service) do
					async(function()
						vRPC.PlaySound(Sources,"ATM_WINDOW","HUD_FRONTEND_DEFAULT_SOUNDSET")
						TriggerClientEvent("NotifyPush",Sources,{ code = 32, title = "Assalto a mão armada", x = Coords["x"], y = Coords["y"], z = Coords["z"], criminal = "Ligação Anônima", color = 16 })
					end)
				end
			end
		else
			TriggerClientEvent("Notify",source,"vermelho","Mochila cheia.","Aviso",5000)
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYER:ROLLVEHICLE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("player:RollVehicle")
AddEventHandler("player:RollVehicle",function(Entity)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and not Active[Passport] then
		if vRP.ConsultItem(Passport,"carjack",1) then
			vRPC.AnimActive(source)
			Active[Passport] = os.time() + 60
			Player(source)["state"]["Buttons"] = true
			TriggerClientEvent("inventory:Close",source)
			TriggerClientEvent("Progress",source,"Desvirando",60000)
			vRPC.PlayAnim(source,false,{"mini@repair","fixing_a_player"},true)

			repeat
				if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
					vRPC.Destroy(source)
					Active[Passport] = nil
					Player(source)["state"]["Buttons"] = false

					local Players = vRPC.Players(source)
					for _,v in pairs(Players) do
						async(function()
							TriggerClientEvent("target:RollVehicle",v,Entity[4])
						end)
					end
				end

				Wait(100)
			until not Active[Passport]
		else
			TriggerClientEvent("Notify",source,"amarelo","Você precisa de <b>1x "..itemName("carjack").."</b>.","Atenção",5000)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REGISTERSTIMERS
-----------------------------------------------------------------------------------------------------------------------------------------
function Baixada.RegistersTimers(Number)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		if not vCLIENT.CheckWeapon(source,"WEAPON_CROWBAR") then
			TriggerClientEvent("Notify",source,"amarelo","Você precisa colocar o <b>"..itemName("WEAPON_CROWBAR").."</b> em mãos.","Atenção",5000)
			return false
		end

		if Registers[Number] then
			if GetGameTimer() < Registers[Number] then
				TriggerClientEvent("Notify",source,"vermelho","Sistema indisponível no momento.","Aviso",5000)
				return false
			else
				InitRegisters(Number, source)
				return true
			end
		else
			InitRegisters(Number, source)
			return true
		end
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- INITREGISTERS
-----------------------------------------------------------------------------------------------------------------------------------------
function InitRegisters(Number,source)
	Registers[Number] = GetGameTimer() + (20 * 60000)

	if math.random(100) >= 75 then
		local Ped = GetPlayerPed(source)
		local Coords = GetEntityCoords(Ped)

		local Service = vRP.NumPermission("Policia")
		for Passports,Sources in pairs(Service) do
			async(function()
				TriggerClientEvent("NotifyPush", Sources,{ code = 31, title = "Caixa Registradora", x = Coords["x"], y = Coords["y"], z = Coords["z"], criminal = "Alarme de segurança", blipColor = 16 })
			end)
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- REGISTERSPAY
-----------------------------------------------------------------------------------------------------------------------------------------
function Baixada.RegistersPay()
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		local Rand = math.random(365,725)

		vRP.UpgradeStress(Passport,2)
		vRP.GenerateItem(Passport,"dollars2",parseInt(Rand),true)

		TriggerEvent("Wanted",source,Passport,300)
		TriggerClientEvent("player:Residuals",source,"Resíduo de Arrombamento.")
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- MAKEPACKAGE
-----------------------------------------------------------------------------------------------------------------------------------------
function Baixada.MakePackage(Service)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and not Active[Passport] then
		vRPC.AnimActive(source)
		Active[Passport] = os.time() + 10
		Player(source)["state"]["Buttons"] = true
		TriggerClientEvent("inventory:Close", source)
		TriggerClientEvent("Progress", source, "Pegando pacote", 10000)
		vRPC.PlayAnim(source, false, { "mini@repair", "fixing_a_player" }, true)

		repeat
			if os.time() >= parseInt(Active[Passport]) then
				Active[Passport] = nil
				vRPC.Destroy(source)
				Player(source)["state"]["Buttons"] = false
				if vRP.MaxItens(Passport, Service, 1) then
					TriggerClientEvent("Notify", source, "vermelho", "Limite atingido.", "Aviso", 5000)
				else
					vRP.GenerateItem(Passport, Service, 1, true)

					if vCLIENT.TakePackage(source) then
						vCLIENT.CheckPackage(source)
					end
				end
			end

			Wait(100)
		until not Active[Passport]
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DELIVERPACKAGE
-----------------------------------------------------------------------------------------------------------------------------------------
function Baixada.DeliverPackage(Service)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		if vRP.TakeItem(Passport,Service,1,true) then
			vCLIENT.FinishPackage(source)

			local Experience = vRP.GetExperience(Passport,"Delivery")
			local Category = ClassCategory(Experience)
			local Valuation = 3500

			if Category == 1 then
				Valuation = Valuation + 10
			elseif Category == 2 then
				Valuation = Valuation + 20
			elseif Category == 3 then
				Valuation = Valuation + 30
			elseif Category == 4 then
				Valuation = Valuation + 40
			elseif Category == 5 then
				Valuation = Valuation + 50
			elseif Category == 6 then
				Valuation = Valuation + 60
			elseif Category == 7 then
				Valuation = Valuation + 70
			elseif Category == 8 then
				Valuation = Valuation + 80
			elseif Category == 9 then
				Valuation = Valuation + 90
			elseif Category == 10 then
				Valuation = Valuation + 100
			end

			if Buffs["Dexterity"][Passport] then
				if Buffs["Dexterity"][Passport] > os.time() then
					Valuation = Valuation + (Valuation * 0.1)
				end
			end

			TriggerClientEvent("inventory:Update",source,"Backpack")
			vRP.GenerateItem(Passport,"dollars",Valuation,true)
			vRP.PutExperience(Passport,"Delivery",1)
		else
			TriggerClientEvent("Notify",source,"amarelo","Você precisa de <b>1x "..itemName(Service).."</b>.","Atenção",5000)
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SHOTSFIRED
-----------------------------------------------------------------------------------------------------------------------------------------
function Baixada.ShotsFired(Vehicle)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		if Vehicle then
			Vehicle = "Disparos de um veículo"
		else
			Vehicle = "Disparos com arma de fogo"
		end

		local Coords = vRP.GetEntityCoords(source)
		local Service = vRP.NumPermission("Policia")
		for Passports,Sources in pairs(Service) do
			async(function()
				vRPC.PlaySound(Sources,"ATM_WINDOW","HUD_FRONTEND_DEFAULT_SOUNDSET")
				TriggerClientEvent("NotifyPush",Sources,{ code = 10, title = Vehicle, x = Coords["x"], y = Coords["y"], z = Coords["z"], color = 6 })
			end)
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- EVIDENCE
-----------------------------------------------------------------------------------------------------------------------------------------
function Baixada.Evidence(Mode)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		local Color = 0
		if Mode == "Yellow" then
			Color = 1
		elseif Mode == "Red" then
			Color = 2
		elseif Mode == "Green" then
			Color = 3
		elseif Mode == "Blue" then
			Color = 4
		end

		exports["inventory"]:DropsServer(vRPC.EntityCoordsZ(source),"evidence0"..Color.."-"..Passport.."-"..vRP.Identity(Passport)["License"],1,Player(source)["state"]["Route"])
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- EXPERIENCE
-----------------------------------------------------------------------------------------------------------------------------------------
function Baixada.Experience(Category)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		return vRP.GetExperience(Passport,Category)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TOGGLETOW
-----------------------------------------------------------------------------------------------------------------------------------------
function Baixada.ToggleTow()
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		if TowList[Passport] then
			TowList[Passport] = nil
		else
			TowList[Passport] = source
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:CALLTOW
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("inventory:CallTow",function(source,vehName,Plate)
	local Ped = GetPlayerPed(source)
	if DoesEntityExist(Ped) then
		local Coords = GetEntityCoords(Ped)

		for k,v in pairs(TowList) do
			async(function()
				TriggerClientEvent("NotifyPush", v,{ code = 51, title = "Registro de Veículo", x = Coords["x"], y = Coords["y"], z = Coords["z"], vehicle = VehicleName(vehName).." - "..Plate, blipColor = 33 })
			end)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PAYMENTTOW
-----------------------------------------------------------------------------------------------------------------------------------------
function Baixada.PaymentTow(Network,Plate)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and not Active[Passport] then
		Active[Passport] = true

		TriggerEvent("garages:DeleteVehicle", Network, Plate)

		local AmountItens = math.random(5, 10)

		if (vRP.InventoryWeight(Passport) + AmountItens) <= vRP.GetWeight(Passport) then
			local VehParts = math.random(4)
			local VehSelected = "suspension"
			local Tow = vRP.GetExperience(Passport, "Tows")
			local Class = ClassCategory(Tow)
			local VehRandom = 1000

			if Class == 1 then
				VehRandom = math.random(4500)
			elseif Class == 2 then
				VehRandom = math.random(4500)
			elseif Class == 3 then
				VehRandom = math.random(4500)
			elseif Class == 4 then
				VehRandom = math.random(3500)
			elseif Class == 5 then
				VehRandom = math.random(3500)
			elseif Class == 6 then
				VehRandom = math.random(3500)
			elseif Class == 7 then
				VehRandom = math.random(2500)
			elseif Class == 8 then
				VehRandom = math.random(2500)
			elseif Class == 9 then
				VehRandom = math.random(2500)
			elseif Class == 10 then
				VehRandom = math.random(1500)
			end

			if VehParts <= 1 then
				VehSelected = "engine"
			elseif VehParts == 2 then
				VehSelected = "transmission"
			elseif VehParts == 3 then
				VehSelected = "brake"
			end

			if VehRandom <= 10 then
				vRP.GenerateItem(Passport, VehSelected .. "e", 1, true)
			elseif VehRandom >= 10 and VehRandom <= 30 then
				vRP.GenerateItem(Passport, VehSelected .. "d", 1, true)
			elseif VehRandom >= 31 and VehRandom <= 60 then
				vRP.GenerateItem(Passport, VehSelected .. "c", 1, true)
			elseif VehRandom >= 61 and VehRandom <= 100 then
				vRP.GenerateItem(Passport, VehSelected .. "b", 1, true)
			elseif VehRandom >= 101 and VehRandom <= 150 then
				vRP.GenerateItem(Passport, VehSelected .. "a", 1, true)
			end

			vRP.GenerateItem(Passport, "plastic", AmountItens, true)
			vRP.GenerateItem(Passport, "glass", AmountItens, true)
			vRP.GenerateItem(Passport, "rubber", AmountItens, true)
			vRP.GenerateItem(Passport, "copper", AmountItens, true)
			vRP.GenerateItem(Passport, "aluminum", AmountItens, true)

			vRP.PutExperience(Passport, "Tows", math.random(2, 3))
		else
			TriggerClientEvent("Notify", source, "vermelho", "Mochila cheia.", "Aviso", 5000)
		end

		Active[Passport] = nil
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:SERVERTOW
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("inventory:ServerTow")
AddEventHandler("inventory:ServerTow",function(Vehicle,Vehicle02,Mode)
	local source = source
	local Players = vRPC.Players(source)
	for _,v in pairs(Players) do
		async(function()
			TriggerClientEvent("inventory:ClientTow",v,Vehicle,Vehicle02,Mode)
		end)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:SENDLETTER
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("inventory:SendLetter")
AddEventHandler("inventory:SendLetter",function()
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		if vRP.ConsultItem(Passport,"paper",1) then
			local Keyboard = vKEYBOARD.Secondary(source,"Passaporte:","Mensagem:")
			if Keyboard then
				if vRP.TakeItem(Passport,"paper",1,true) then
					local Time = os.time()

					vRP.SetServerData("paper-"..Time,Keyboard[2])
					vRP.GenerateItem(Keyboard[1],"paper-"..Time,1,true)
				end
			end
		else
			TriggerClientEvent("Notify",source,"amarelo","Você precisa de <b>1x "..itemName("paper").."</b>.","Atenção",5000)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:BUFFSERVER
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("inventory:BuffServer",function(source,Passport,Name,Amount)
	if not Buffs[Name][Passport] then
		Buffs[Name][Passport] = 0
	end

	if os.time() >= Buffs[Name][Passport] then
		Buffs[Name][Passport] = os.time() + Amount
	else
		Buffs[Name][Passport] = Buffs[Name][Passport] + Amount

		if (Buffs[Name][Passport] - os.time()) >= 3600 then
			Buffs[Name][Passport] = os.time() + 3600
		end
	end

	TriggerClientEvent("hud:"..Name,source,Buffs[Name][Passport] - os.time())
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- BUFFS
-----------------------------------------------------------------------------------------------------------------------------------------
exports("Buffs",function(Mode,Passport)
	return Buffs[Mode][Passport]
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SAVESERVER
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("SaveServer",function(Silenced)
	local List = vRP.Players()
	for Passport,_ in pairs(List) do
		vRP.Query("playerdata/SetData",{ Passport = Passport, Name = "Attachs", Information = json.encode(Attachs[Passport]) })
		vRP.Query("playerdata/SetData",{ Passport = Passport, Name = "Ammos", Information = json.encode(Ammos[Passport]) })
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DISCONNECT
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("Disconnect",function(Passport)
	if Ammos[Passport] or Attachs[Passport] then
		if Temporary[Passport] then
			Ammos[Passport] = Temporary[Passport]["Ammos"]
			Attachs[Passport] = Temporary[Passport]["Attachs"]
			Temporary[Passport] = nil
		end

		vRP.Query("playerdata/SetData",{ Passport = Passport, Name = "Attachs", Information = json.encode(Attachs[Passport]) })
		vRP.Query("playerdata/SetData",{ Passport = Passport, Name = "Ammos", Information = json.encode(Ammos[Passport]) })

		Attachs[Passport] = nil
		Ammos[Passport] = nil
	end

	if Active[Passport] then
		Active[Passport] = nil
	end

	if TowList[Passport] then
		TowList[Passport] = nil
	end

	if VerifyObjects[Passport] then
		VerifyObjects[Passport] = nil
	end

	if VerifyAnimals[Passport] then
		VerifyAnimals[Passport] = nil
	end

	if Loots[Passport] then
		Loots[Passport] = nil
	end

	if Healths[Passport] then
		Healths[Passport] = nil
	end

	if Armors[Passport] then
		Armors[Passport] = nil
	end

	if Scanners[Passport] then
		Scanners[Passport] = nil
	end

	if Carry[Passport] then
		if vRP.Passport(Carry[Passport]) then
			TriggerClientEvent("inventory:Carry",Carry[Passport],nil,"Detach")
			Player(Carry[Passport])["state"]["Carry"] = false
			vRPC.Destroy(Carry[Passport])
		end

		Carry[Passport] = nil
	end

	if Drugs[Passport] then
		Drugs[Passport] = nil
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECT
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("Connect",function(Passport,source)
	Ammos[Passport] = vRP.UserData(Passport,"Ammos")
	Attachs[Passport] = vRP.UserData(Passport,"Attachs")

	TriggerClientEvent("objects:Table",source,Objects)
	TriggerClientEvent("inventory:Drops",source,Drops)

	for Name,_ in pairs(Buffs) do
		if Buffs[Name] and Buffs[Name][Passport] and os.time() < Buffs[Name][Passport] then
			TriggerClientEvent("hud:"..Name,source,Buffs[Name][Passport] - os.time())
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLEANWEAPONS
-----------------------------------------------------------------------------------------------------------------------------------------
exports("CleanWeapons",function(Passport,Clean)
	local source = vRP.Source(Passport)
	if source then
		local Ped = GetPlayerPed(source)
		local Weapon = GetSelectedPedWeapon(Ped)

		RemoveWeaponFromPed(Ped,Weapon)
		RemoveAllPedWeapons(Ped,false)
		SetPedAmmo(Ped,Weapon,0)

		if Clean then
			Attachs[Passport] = {}
			Ammos[Passport] = {}
		end
	end
end)