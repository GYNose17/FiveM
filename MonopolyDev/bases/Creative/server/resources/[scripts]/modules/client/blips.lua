-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADMANEUVERS
-----------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADMANEUVERS
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		local TimeDistance = 999

		local Ped = PlayerPedId()
		local Vehicle = GetVehiclePedIsIn(Ped)
		local Speed = GetEntitySpeed(Vehicle) * 2.236936
		if IsPedOnAnyBike(Ped) then
			if Speed >= 5 then
				TimeDistance = 5

				while not HasAnimDictLoaded("rcmextreme2atv") do
					Wait(0)
					RequestAnimDict("rcmextreme2atv")
				end

				if IsControlJustPressed(0, 172) then
					TaskPlayAnim(Ped, "rcmextreme2atv", "idle_e", 8.0, -8.0, -1, 32, 0, false, false, false)
					
					Wait(1000)
				elseif IsControlJustPressed(0, 173) then
					TaskPlayAnim(Ped, "rcmextreme2atv", "idle_d", 8.0, -8.0, -1, 32, 0, false, false, false)

					Wait(1000)
				elseif IsControlJustPressed(0, 174) then
					TaskPlayAnim(Ped, "rcmextreme2atv", "idle_b", 8.0, -8.0, -1, 32, 0, false, false, false)

					Wait(1000)
				elseif IsControlJustPressed(0, 175) then
					TaskPlayAnim(Ped, "rcmextreme2atv", "idle_c", 8.0, -8.0, -1, 32, 0, false, false, false)

					Wait(1000)
				end
			end
		end

		Wait(TimeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- MAPZOOM
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	SetMapZoomDataLevel(0, 0.96, 0.9, 0.08, 0.0, 0.0)
	SetMapZoomDataLevel(1, 1.6, 0.9, 0.08, 0.0, 0.0)
	SetMapZoomDataLevel(2, 8.6, 0.9, 0.08, 0.0, 0.0)
	SetMapZoomDataLevel(3, 12.3, 0.9, 0.08, 0.0, 0.0)
	SetMapZoomDataLevel(4, 22.3, 0.9, 0.08, 0.0, 0.0)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- BLIPS
-----------------------------------------------------------------------------------------------------------------------------------------
local Blips = {
	{ 1239.87,  -3257.2,  7.09,   67,  62, "Caminhoneiro",            0.5 },
	{ 280.38,   -584.45,  43.29,  80,  59, "Hospital",                0.5 },
	{ -247.42,  6331.39,  32.42,  80,  59, "Hospital",                0.5 },
	{ 55.43,    -876.19,  30.66,  357, 19, "Garagem Gratuita",        0.6 },
	{ 598.04,   2741.27,  42.07,  357, 62, "Garagem Paga",            0.6 },
	{ -136.36,  6357.03,  31.49,  357, 19, "Garagem Gratuita",        0.6 },
	{ 275.23,   -345.54,  45.17,  357, 62, "Garagem Paga",            0.6 },
	{ 596.40,   90.65,    93.12,  357, 62, "Garagem Paga",            0.6 },
	{ -340.76,  265.97,   85.67,  357, 62, "Garagem Paga",            0.6 },
	{ -2030.01, -465.97,  11.60,  357, 62, "Garagem Paga",            0.6 },
	{ -1184.92, -1510.00, 4.64,   357, 62, "Garagem Paga",            0.6 },
	{ 214.02,   -808.44,  31.01,  357, 62, "Garagem Paga",            0.6 },
	{ -348.88,  -874.02,  31.31,  357, 62, "Garagem Paga",            0.6 },
	{ 67.74,    12.27,    69.21,  357, 62, "Garagem Paga",            0.6 },
	{ 361.90,   297.81,   103.88, 357, 62, "Garagem Paga",            0.6 },
	{ 1035.89,  -763.89,  57.99,  357, 62, "Garagem Paga",            0.6 },
	{ -796.63,  -2022.77, 9.16,   357, 62, "Garagem Paga",            0.6 },
	{ 453.27,   -1146.76, 29.52,  357, 62, "Garagem Paga",            0.6 },
	{ 528.66,   -146.3,   58.38,  357, 62, "Garagem Paga",            0.6 },
	{ -1159.48, -739.32,  19.89,  357, 62, "Garagem Paga",            0.6 },
	{ 101.22,   -1073.68, 29.38,  357, 62, "Garagem Paga",            0.6 },
	{ 1725.21,  4711.77,  42.11,  357, 62, "Garagem Paga",            0.6 },
	{ 1624.05,  3566.14,  35.15,  357, 19, "Garagem Gratuita",        0.6 },
	{ -73.35,   -2004.6,  18.27,  357, 62, "Garagem Paga",            0.6 },
	{ -1275.5,  -1139.56, 6.79,   411, 11, "Jardineiro",              0.6 },
	{ -424.36,  -2789.78, 6.52,   501, 31, "Carteiro",                0.6 },
	{ -1204.85, -1564.27, 4.6,    126, 13, "Academia",                0.6 },
	{ 1138.12,  -990.96,  46.12,  366, 43, "Lavanderia",              0.6 },
	{ 426.57,   -981.71,  30.7,   60,  10, "Departamento Policial",   0.6 },
	{ 29.2,     -1351.89, 29.34,  52,  36, "Loja de Departamento",    0.5 },
	{ 2561.74,  385.22,   108.61, 52,  36, "Loja de Departamento",    0.5 },
	{ 1160.21,  -329.4,   69.03,  52,  36, "Loja de Departamento",    0.5 },
	{ -711.99,  -919.96,  19.01,  52,  36, "Loja de Departamento",    0.5 },
	{ -54.56,   -1758.56, 29.05,  52,  36, "Loja de Departamento",    0.5 },
	{ 375.87,   320.04,   103.42, 52,  36, "Loja de Departamento",    0.5 },
	{ -3237.48, 1004.72,  12.45,  52,  36, "Loja de Departamento",    0.5 },
	{ 1730.64,  6409.67,  35.0,   52,  36, "Loja de Departamento",    0.5 },
	{ 543.51,   2676.85,  42.14,  52,  36, "Loja de Departamento",    0.5 },
	{ 1966.53,  3737.95,  32.18,  52,  36, "Loja de Departamento",    0.5 },
	{ 2684.73,  3281.2,   55.23,  52,  36, "Loja de Departamento",    0.5 },
	{ 1696.12,  4931.56,  42.07,  52,  36, "Loja de Departamento",    0.5 },
	{ -1820.18, 785.69,   137.98, 52,  36, "Loja de Departamento",    0.5 },
	{ 1395.35,  3596.6,   34.86,  52,  36, "Loja de Departamento",    0.5 },
	{ -2977.14, 391.22,   15.03,  52,  36, "Loja de Departamento",    0.5 },
	{ -3034.99, 590.77,   7.8,    52,  36, "Loja de Departamento",    0.5 },
	{ 1144.46,  -980.74,  46.19,  52,  36, "Loja de Departamento",    0.5 },
	{ 1166.06,  2698.17,  37.95,  52,  36, "Loja de Departamento",    0.5 },
	{ -1493.12, -385.55,  39.87,  52,  36, "Loja de Departamento",    0.5 },
	{ -1228.6,  -899.7,   12.27,  52,  36, "Loja de Departamento",    0.5 },
	{ 1692.27,  3760.91,  34.69,  76,  6,  "Loja de Armas",           0.4 },
	{ 253.8,    -50.47,   69.94,  76,  6,  "Loja de Armas",           0.4 },
	{ 842.54,   -1035.25, 28.19,  76,  6,  "Loja de Armas",           0.4 },
	{ -331.67,  6084.86,  31.46,  76,  6,  "Loja de Armas",           0.4 },
	{ -662.37,  -933.58,  21.82,  76,  6,  "Loja de Armas",           0.4 },
	{ -1304.12, -394.56,  36.7,   76,  6,  "Loja de Armas",           0.4 },
	{ -1118.98, 2699.73,  18.55,  76,  6,  "Loja de Armas",           0.4 },
	{ 2567.98,  292.62,   108.73, 76,  6,  "Loja de Armas",           0.4 },
	{ -3173.51, 1088.35,  20.84,  76,  6,  "Loja de Armas",           0.4 },
	{ 22.53,    -1105.52, 29.79,  76,  6,  "Loja de Armas",           0.4 },
	{ 810.22,   -2158.99, 29.62,  76,  6,  "Loja de Armas",           0.4 },
	{ -815.12,  -184.15,  37.57,  71,  62, "Barbearia",               0.5 },
	{ 139.56,   -1704.12, 29.05,  71,  62, "Barbearia",               0.5 },
	{ -1278.11, -1116.66, 6.75,   71,  62, "Barbearia",               0.5 },
	{ 1928.89,  3734.04,  32.6,   71,  62, "Barbearia",               0.5 },
	{ 1217.05,  -473.45,  65.96,  71,  62, "Barbearia",               0.5 },
	{ -34.08,   -157.01,  56.83,  71,  62, "Barbearia",               0.5 },
	{ -274.5,   6225.27,  31.45,  71,  62, "Barbearia",               0.5 },
	{ 86.06,    -1391.64, 29.23,  366, 62, "Loja de Roupas",          0.5 },
	{ -719.94,  -158.18,  37.0,   366, 62, "Loja de Roupas",          0.5 },
	{ -152.79,  -306.79,  38.67,  366, 62, "Loja de Roupas",          0.5 },
	{ -816.39,  -1081.22, 11.12,  366, 62, "Loja de Roupas",          0.5 },
	{ -1206.51, -781.5,   17.12,  366, 62, "Loja de Roupas",          0.5 },
	{ -1458.26, -229.79,  49.2,   366, 62, "Loja de Roupas",          0.5 },
	{ -2.41,    6518.29,  31.48,  366, 62, "Loja de Roupas",          0.5 },
	{ 1682.59,  4819.98,  42.04,  366, 62, "Loja de Roupas",          0.5 },
	{ 129.46,   -205.18,  54.51,  366, 62, "Loja de Roupas",          0.5 },
	{ 618.49,   2745.54,  42.01,  366, 62, "Loja de Roupas",          0.5 },
	{ 1197.93,  2698.21,  37.96,  366, 62, "Loja de Roupas",          0.5 },
	{ -3165.74, 1061.29,  20.84,  366, 62, "Loja de Roupas",          0.5 },
	{ -1093.76, 2703.99,  19.04,  366, 62, "Loja de Roupas",          0.5 },
	{ 414.86,   -807.57,  29.34,  366, 62, "Loja de Roupas",          0.5 },
	{ -1728.06, -1050.69, 1.71,   356, 62, "Embarcações",             0.6 },
	{ -776.72,  -1495.02, 2.29,   356, 62, "Embarcações",             0.6 },
	{ -893.97,  5687.78,  3.29,   356, 62, "Embarcações",             0.6 },
	{ 1509.64,  3788.7,   33.51,  356, 62, "Embarcações",             0.6 },
	{ -1745.57, -205.19,  57.37,  89,  62, "Cemitério",               0.5 },
	{ 232.55,   202.84,   105.4,  67,  24, "Transportador",           0.6 },
	{ -172.89,  6381.32,  31.48,  403, 5,  "Farmácia",                0.7 },
	{ 1690.07,  3581.68,  35.62,  403, 5,  "Farmácia",                0.7 },
	{ 326.5,    -1074.43, 29.47,  403, 5,  "Farmácia",                0.7 },
	{ 114.39,   -4.85,    67.82,  403, 5,  "Farmácia",                0.7 },
	{ 213.75,   -1835.36, 27.57,  403, 5,  "Farmácia",                0.7 },
	{ 82.54,    -1553.28, 29.59,  318, 62, "Lixeiro",                 0.6 },
	{ 287.36,   2843.6,   44.7,   318, 62, "Lixeiro",                 0.6 },
	{ -413.97,  6171.58,  31.48,  318, 62, "Lixeiro",                 0.6 },
	{ -428.56,  -1728.33, 19.79,  467, 11, "Reciclagem",              0.6 },
	{ 180.07,   2793.29,  45.65,  467, 11, "Reciclagem",              0.6 },
	{ -195.42,  6264.62,  31.49,  467, 11, "Reciclagem",              0.6 },
	{ 408.98,   -1622.71, 29.28,  357, 9,  "Impound",                 0.6 },
	{ -361.85,  -132.89,  38.67,  402, 18, "Mecânica",                0.7 },
	{ -1142.1,  -1987.5,  13.16,  402, 18, "Mecânica",                0.7 },
	{ 1178.96,  2651.42,  37.81,  402, 18, "Mecânica",                0.7 },
	{ 116.95,   6615.26,  31.85,  402, 18, "Mecânica",                0.7 },
	{ 718.03,   -1088.61, 22.36,  402, 18, "Mecânica",                0.7 },
	{ -205.64,  -1306.65, 31.31,  402, 18, "Mecânica",                0.7 },
	{ 2955.13,  2807.17,  41.5,   78,  62, "Mineradora",              0.6 },
	{ 2101.75,  2322.74,  94.53,  515, 10, "Central de Eletricidade", 0.7 },
	{ 562.36,   2741.56,  42.87,  273, 11, "Animal Park",             0.5 },
	{ 1327.98,  -1654.78, 52.03,  75,  13, "Loja de Tatuagem",        0.5 },
	{ -1149.04, -1428.64, 4.71,   75,  13, "Loja de Tatuagem",        0.5 },
	{ 322.01,   186.24,   103.34, 75,  13, "Loja de Tatuagem",        0.5 },
	{ -3175.64, 1075.54,  20.58,  75,  13, "Loja de Tatuagem",        0.5 },
	{ 1866.01,  3748.07,  32.79,  75,  13, "Loja de Tatuagem",        0.5 },
	{ -295.51,  6199.21,  31.24,  75,  13, "Loja de Tatuagem",        0.5 },
	{ 2435.82,  4774.08,  34.37,  77,  62, "Leiteiro",                0.5 },
	{ 2057.89,  5109.83,  46.34,  76,  62, "Agricultor",              0.5 },
	{ 1654.84,  4862.14,  41.99,  76,  62, "Agricultor",              0.5 },
	{ 1965.2,   5179.44,  47.9,   285, 62, "Lenhador",                0.5 },
	{ -1177.93, -884.13,  13.88,  439, 62, "Restaurante",             0.7 },
	{ -70.49,   -1104.59, 26.12,  225, 62, "Concessionária",          0.6 },
	{ -679.13,  5839.52,  17.3,   141, 62, "Caçador",                 0.7 },
	{ -1816.64, -1193.73, 14.31,  68,  62, "Pescador",                0.7 },
	{ 216.08,   -1389.87, 30.58,  641, 11, "Auto Escola",             0.6 },
	{ -535.04,  -221.34,  37.64,  267, 5,  "Prefeitura",              0.6 },
	{ 918.69,   50.33,    80.9,   679, 32, "Cassino",                 0.7 },
	{ -628.79,  -238.7,   38.05,  617, 84, "Joalheria",               0.6 },
	{ 454.73,   -600.83,  28.56,  513, 62, "Motorista",               0.5 },
	{ 894.97,   -179.14,  74.7,   198, 66, "Taxista",                 0.5 },
	{ 46.66,    -1749.79, 29.64,  478, 31, "Loja de Materiais",       0.7 },
	{ 2747.28,  3473.04,  55.67,  478, 31, "Loja de Materiais",       0.7 },
	{ 265.09,   -1258.94, 29.13,  361, 35, "Posto de Gasolina",       0.4 },
	{ -2097.61, -320.57,  13.16,  361, 35, "Posto de Gasolina",       0.4 },
	{ -2555.19, 2334.31,  33.08,  361, 35, "Posto de Gasolina",       0.4 },
	{ 179.99,   6602.84,  31.86,  361, 35, "Posto de Gasolina",       0.4 },
	{ 818.92,   -1028.65, 26.89,  361, 35, "Posto de Gasolina",       0.4 },
	{ 1207.05,  -1403.68, 36.26,  361, 35, "Posto de Gasolina",       0.4 },
	{ 1181.61,  -330.8,   69.78,  361, 35, "Posto de Gasolina",       0.4 },
	{ 619.47,   270.18,   103.26, 361, 35, "Posto de Gasolina",       0.4 },
	{ 2581.01,  362.42,   108.88, 361, 35, "Posto de Gasolina",       0.4 },
	{ 174.86,   -1562.55, 29.87,  361, 35, "Posto de Gasolina",       0.4 },
	{ -319.25,  -1470.23, 30.5,   361, 35, "Posto de Gasolina",       0.4 },
	{ 1786.08,  3329.86,  40.42,  361, 35, "Posto de Gasolina",       0.4 },
	{ 48.92,    2779.59,  57.05,  361, 35, "Posto de Gasolina",       0.4 },
	{ 264.98,   2607.18,  43.99,  361, 35, "Posto de Gasolina",       0.4 },
	{ 1039.9,   2671.05,  39.53,  361, 35, "Posto de Gasolina",       0.4 },
	{ 1208.52,  2659.43,  36.9,   361, 35, "Posto de Gasolina",       0.4 },
	{ 2539.8,   2594.81,  36.96,  361, 35, "Posto de Gasolina",       0.4 },
	{ 2006.21,  3774.96,  31.4,   361, 35, "Posto de Gasolina",       0.4 },
	{ 1690.1,   4927.81,  41.23,  361, 35, "Posto de Gasolina",       0.4 },
	{ 1701.73,  6416.49,  31.77,  361, 35, "Posto de Gasolina",       0.4 },
	{ -91.29,   6422.54,  30.65,  361, 35, "Posto de Gasolina",       0.4 },
	{ -1797.22, 800.56,   137.66, 361, 35, "Posto de Gasolina",       0.4 },
	{ -1435.5,  -284.68,  45.41,  361, 35, "Posto de Gasolina",       0.4 },
	{ -732.64,  -939.32,  18.22,  361, 35, "Posto de Gasolina",       0.4 },
	{ -524.92,  -1216.15, 17.33,  361, 35, "Posto de Gasolina",       0.4 },
	{ -69.45,   -1758.01, 28.55,  361, 35, "Posto de Gasolina",       0.4 }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADTIMERS
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		InvalidateIdleCam()
		InvalidateVehicleIdleCam()

		SetCreateRandomCops(false)
		CancelCurrentPoliceReport()
		SetCreateRandomCopsOnScenarios(false)
		SetCreateRandomCopsNotOnScenarios(false)
		SetPedInfiniteAmmoClip(PlayerPedId(), false)

		Wait(1000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADTIMERS
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		for Number = 1, 22 do
			if Number ~= 14 and Number ~= 16 then
				HideHudComponentThisFrame(Number)
			end
		end

		BlockWeaponWheelThisFrame()
		DisableControlAction(0, 37, true)
		DisableControlAction(0, 204, true)
		DisableControlAction(0, 211, true)
		DisableControlAction(0, 349, true)
		DisableControlAction(0, 192, true)
		DisableControlAction(0, 157, true)
		DisableControlAction(0, 158, true)
		DisableControlAction(0, 159, true)
		DisableControlAction(0, 160, true)
		DisableControlAction(0, 161, true)
		DisableControlAction(0, 162, true)
		DisableControlAction(0, 163, true)
		DisableControlAction(0, 164, true)
		DisableControlAction(0, 165, true)

		SetVehicleDensityMultiplierThisFrame(0.25)
		SetRandomVehicleDensityMultiplierThisFrame(0.25)
		SetParkedVehicleDensityMultiplierThisFrame(0.25)
		SetScenarioPedDensityMultiplierThisFrame(0.25, 0.25)
		SetPedDensityMultiplierThisFrame(0.25)

		local Pid = PlayerId()
		local Ped = PlayerPedId()
		if IsPedArmed(Ped, 6) then
			DisableControlAction(1, 140, true)
			DisableControlAction(1, 141, true)
			DisableControlAction(1, 142, true)
		end

		if IsPedUsingActionMode(Ped) then
			SetPedUsingActionMode(Ped, -1, -1, 1)
		end

		if IsPedInAnyVehicle(Ped) then
			DisableControlAction(0, 345, true)
		end

		SetPauseMenuActive(false)
		DisablePlayerVehicleRewards(Pid)

		if not DisableTargetMode then
			SetPlayerLockonRangeOverride(Pid, 0.0)
		end

		SetWeatherTypeNow(GlobalState["Weather"])
		SetWeatherTypePersist(GlobalState["Weather"])
		SetWeatherTypeNowPersist(GlobalState["Weather"])

		SetArtificialLightsState(GlobalState["Blackout"])
		SetArtificialLightsStateAffectsVehicles(false)

		if GlobalState["Weather"] == "XMAS" then
			SetForceVehicleTrails(true)
			SetForcePedFootstepsTracks(true)
		else
			SetForceVehicleTrails(false)
			SetForcePedFootstepsTracks(false)
		end

		if IsPlayerWantedLevelGreater(Pid, 0) then
			ClearPlayerWantedLevel(Pid)
		end

		if LocalPlayer["state"]["Active"] then
			NetworkOverrideClockTime(GlobalState["Hours"], GlobalState["Minutes"], 00)
		else
			NetworkOverrideClockTime(12, 00, 00)
		end

		if IsPedOnFoot(GetPlayerPed(-1)) then
			SetRadarZoom(1100)
		elseif IsPedInAnyVehicle(GetPlayerPed(-1), true) then
			SetRadarZoom(1100)
		end

		Wait(0)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TELEPORT
-----------------------------------------------------------------------------------------------------------------------------------------
local Teleport = {
	{ 330.19,  -601.21, 43.29,  343.65,  -581.77, 28.8 },
	{ 343.65,  -581.77, 28.8,   330.19,  -601.21, 43.29 },

	{ 327.16,  -603.53, 43.29,  338.97,  -583.85, 74.16 },
	{ 338.97,  -583.85, 74.16,  327.16,  -603.53, 43.29 },

	{ -741.07, 5593.13, 41.66,  446.19,  5568.79, 781.19 },
	{ 446.19,  5568.79, 781.19, -741.07, 5593.13, 41.66 },

	{ -740.78, 5597.04, 41.66,  446.37,  5575.02, 781.19 },
	{ 446.37,  5575.02, 781.19, -740.78, 5597.04, 41.66 },

	{ -71.05,  -801.01, 44.23,  -75.0,   -824.54, 321.29 },
	{ -75.0,   -824.54, 321.29, -71.05,  -801.01, 44.23 }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADTELEPORT
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		local TimeDistance = 999
		local Ped = PlayerPedId()
		if not IsPedInAnyVehicle(Ped) then
			local Coords = GetEntityCoords(Ped)

			for Number = 1, #Teleport do
				local v = Teleport[Number]
				if #(Coords - vec3(v[1], v[2], v[3])) <= 1 then
					TimeDistance = 1

					if IsControlJustPressed(1, 38) then
						SetEntityCoords(Ped, v[4], v[5], v[6])
					end
				end
			end
		end

		Wait(TimeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- OPENOBJECTS
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		local TimeDistance = 999
		local Ped = PlayerPedId()
		if not IsPedInAnyVehicle(Ped) then
			local Coords = GetEntityCoords(Ped)

			local Distance = #(Coords - vec3(253.73, 224.19, 101.91))
			if Distance <= 1.5 then
				TimeDistance = 1

				if IsControlJustPressed(1, 38) then
					local Handle, Object = FindFirstObject()
					local Finished = false

					repeat
						local Heading = GetEntityHeading(Object)
						local CoordsObj = GetEntityCoords(Object)
						local DistanceObjs = #(CoordsObj - Coords)

						if DistanceObjs < 3.0 and GetEntityModel(Object) == 961976194 then
							if Heading > 150.0 then
								SetEntityHeading(Object, 0.0)
							else
								SetEntityHeading(Object, 160.0)
							end

							FreezeEntityPosition(Object, true)
							Finished = true
						end

						Finished, Object = FindNextObject(Handle)
					until not Finished

					EndFindObject(Handle)
				end
			end
		end

		Wait(TimeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ALPHAS
-----------------------------------------------------------------------------------------------------------------------------------------
local Alphas = {
	-- Car Wash
	{ vec3(24.27, -1391.96, 28.7), 200, 54, 15.0 },
	{ vec3(167.69, -1715.92, 28.66), 200, 54, 15.0 },
	{ vec3(-699.86, -932.84, 18.38), 200, 54, 15.0 },

	-- Speed Cameras
	{ vec3(-521.92, -1770.01, 21.42), 200, 76, 15.0 },
	{ vec3(2578.46, 4245.33, 41.8), 200, 76, 15.0 },
	{ vec3(1578.62, -980.07, 60.09), 200, 76, 15.0 },
	{ vec3(2134.19, -572.18, 95.1), 200, 76, 15.0 },
	{ vec3(714.88, 6511.94, 27.41), 200, 76, 15.0 },
	{ vec3(-2658.32, 2632.84, 16.68), 200, 76, 15.0 },
	
	-- Scuba
	{ vec3(767.19, 7192.03, -30.16), 200, 21, 100.0 },

	-- Ilegal
	{ vec3(-472.08, 6287.5, 14.63), 200, 59, 20.0 },

	-- Pescaria
	{ vec3(-1227.49, 4389.84, 5.12), 200, 30, 100.0 },

	-- Caça
	{ vec3(2203.71, 5595.54, 53.73), 150, 69, 400.0 },
	{ vec3(2116.84, 1943.06, 93.63), 150, 69, 400.0 },
	{ vec3(-2096.91, 2341.5, 33.28), 150, 69, 400.0 },

	-- Influence
	{ vec3(1272.26, -1712.57, 54.76), 150, 58, 100.0 },
	{ vec3(95.58, -1985.56, 20.44), 150, 58, 100.0 },
	{ vec3(-31.47, -1434.84, 31.49), 150, 58, 100.0 },
	{ vec3(347.45, -2069.06, 20.89), 150, 58, 100.0 },
	{ vec3(512.29, -1803.52, 28.51), 150, 58, 100.0 },
	{ vec3(230.55, -1753.35, 28.98), 150, 58, 100.0 },

	-- Bikes
	{ vec3(156.44, -1065.79, 30.04), 200, 64, 10.0 },
	{ vec3(-1188.13, -1574.47, 4.35), 200, 64, 10.0 },
	{ vec3(-777.44, 5593.64, 33.63), 200, 64, 10.0 },
	{ vec3(435.06, -647.39, 28.73), 200, 64, 10.0 },
	{ vec3(-896.38, -779.06, 15.91), 200, 64, 10.0 },
	{ vec3(-1668.56, -998.63, 7.38), 200, 64, 10.0 },
	{ vec3(102.53, -1957.14, 20.74), 200, 64, 10.0 },
	{ vec3(-161.23, -1623.57, 33.65), 200, 64, 10.0 },
	{ vec3(337.84, -2036.2, 21.37), 200, 64, 10.0 },
	{ vec3(524.05, -1829.38, 28.43), 200, 64, 10.0 },
	{ vec3(232.37, -1756.87, 29.0), 200, 64, 10.0 },
	{ vec3(143.91, 6653.49, 31.53), 200, 64, 10.0 },
	{ vec3(1703.32, 4820.19, 41.97), 200, 64, 10.0 },
	{ vec3(958.53, 3618.86, 32.67), 200, 64, 10.0 },
	{ vec3(1032.52, 2656.05, 39.55), 200, 64, 10.0 }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADSTART
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	for Number = 1, #Alphas do
		local Blip = AddBlipForRadius(Alphas[Number][1]["x"], Alphas[Number][1]["y"], Alphas[Number][1]["z"], Alphas[Number][4])
		SetBlipAlpha(Blip, Alphas[Number][2])
		SetBlipColour(Blip, Alphas[Number][3])
	end

	for Number = 1, #Blips do
		local Blip = AddBlipForCoord(Blips[Number][1], Blips[Number][2], Blips[Number][3])
		SetBlipSprite(Blip, Blips[Number][4])
		SetBlipDisplay(Blip, 4)
		SetBlipAsShortRange(Blip, true)
		SetBlipColour(Blip, Blips[Number][5])
		SetBlipScale(Blip, Blips[Number][7])
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString(Blips[Number][6])
		EndTextCommandSetBlipName(Blip)
	end

	local Tables = {}

	for Number = 1, #Teleport do
		Tables[#Tables + 1] = { Teleport[Number][1], Teleport[Number][2], Teleport[Number][3], 2.5, "E", "Porta de Acesso", "Pressione para acessar" }
		Tables[#Tables + 1] = { 253.73, 224.19, 101.91, 1.5, "E", "Porta do Cofre", "Pressione para abrir/fechar" }
	end

	TriggerEvent("hoverfy:Insert", Tables)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ISLAND
-----------------------------------------------------------------------------------------------------------------------------------------
local Island = {
	"h4_islandairstrip",
	"h4_islandairstrip_props",
	"h4_islandx_mansion",
	"h4_islandx_mansion_props",
	"h4_islandx_props",
	"h4_islandxdock",
	"h4_islandxdock_props",
	"h4_islandxdock_props_2",
	"h4_islandxtower",
	"h4_islandx_maindock",
	"h4_islandx_maindock_props",
	"h4_islandx_maindock_props_2",
	"h4_IslandX_Mansion_Vault",
	"h4_islandairstrip_propsb",
	"h4_beach",
	"h4_beach_props",
	"h4_beach_bar_props",
	"h4_islandx_barrack_props",
	"h4_islandx_checkpoint",
	"h4_islandx_checkpoint_props",
	"h4_islandx_Mansion_Office",
	"h4_islandx_Mansion_LockUp_01",
	"h4_islandx_Mansion_LockUp_02",
	"h4_islandx_Mansion_LockUp_03",
	"h4_islandairstrip_hangar_props",
	"h4_IslandX_Mansion_B",
	"h4_islandairstrip_doorsclosed",
	"h4_Underwater_Gate_Closed",
	"h4_mansion_gate_closed",
	"h4_aa_guns",
	"h4_IslandX_Mansion_GuardFence",
	"h4_IslandX_Mansion_Entrance_Fence",
	"h4_IslandX_Mansion_B_Side_Fence",
	"h4_IslandX_Mansion_Lights",
	"h4_islandxcanal_props",
	"h4_beach_props_party",
	"h4_islandX_Terrain_props_06_a",
	"h4_islandX_Terrain_props_06_b",
	"h4_islandX_Terrain_props_06_c",
	"h4_islandX_Terrain_props_05_a",
	"h4_islandX_Terrain_props_05_b",
	"h4_islandX_Terrain_props_05_c",
	"h4_islandX_Terrain_props_05_d",
	"h4_islandX_Terrain_props_05_e",
	"h4_islandX_Terrain_props_05_f",
	"h4_islandx_terrain_01",
	"h4_islandx_terrain_02",
	"h4_islandx_terrain_03",
	"h4_islandx_terrain_04",
	"h4_islandx_terrain_05",
	"h4_islandx_terrain_06",
	"h4_ne_ipl_00",
	"h4_ne_ipl_01",
	"h4_ne_ipl_02",
	"h4_ne_ipl_03",
	"h4_ne_ipl_04",
	"h4_ne_ipl_05",
	"h4_ne_ipl_06",
	"h4_ne_ipl_07",
	"h4_ne_ipl_08",
	"h4_ne_ipl_09",
	"h4_nw_ipl_00",
	"h4_nw_ipl_01",
	"h4_nw_ipl_02",
	"h4_nw_ipl_03",
	"h4_nw_ipl_04",
	"h4_nw_ipl_05",
	"h4_nw_ipl_06",
	"h4_nw_ipl_07",
	"h4_nw_ipl_08",
	"h4_nw_ipl_09",
	"h4_se_ipl_00",
	"h4_se_ipl_01",
	"h4_se_ipl_02",
	"h4_se_ipl_03",
	"h4_se_ipl_04",
	"h4_se_ipl_05",
	"h4_se_ipl_06",
	"h4_se_ipl_07",
	"h4_se_ipl_08",
	"h4_se_ipl_09",
	"h4_sw_ipl_00",
	"h4_sw_ipl_01",
	"h4_sw_ipl_02",
	"h4_sw_ipl_03",
	"h4_sw_ipl_04",
	"h4_sw_ipl_05",
	"h4_sw_ipl_06",
	"h4_sw_ipl_07",
	"h4_sw_ipl_08",
	"h4_sw_ipl_09",
	"h4_islandx_mansion",
	"h4_islandxtower_veg",
	"h4_islandx_sea_mines",
	"h4_islandx",
	"h4_islandx_barrack_hatch",
	"h4_islandxdock_water_hatch",
	"h4_beach_party"
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADCAYO
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	local CayoPerico = false

	while true do
		local Ped = PlayerPedId()
		local Coords = GetEntityCoords(Ped)

		if #(Coords - vec3(4840.57, -5174.42, 2.0)) <= 2000 then
			if not CayoPerico then
				for _,v in pairs(Island) do
					RequestIpl(v)
				end

				SetIslandHopperEnabled("HeistIsland", true)
				SetAiGlobalPathNodesType(1)
				SetDeepOceanScaler(0.0)
				LoadGlobalWaterType(1)
				CayoPerico = true
			end
		else
			if CayoPerico then
				for _,v in pairs(Island) do
					RemoveIpl(v)
				end

				SetIslandHopperEnabled("HeistIsland", false)
				SetAiGlobalPathNodesType(0)
				SetDeepOceanScaler(1.0)
				LoadGlobalWaterType(0)
				CayoPerico = false
			end
		end

		Wait(1000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADRAPPEL
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		local TimeDistance = 999
		local Ped = PlayerPedId()
		if IsPedInAnyHeli(Ped) then
			TimeDistance = 1

			local Vehicle = GetVehiclePedIsUsing(Ped)
			if IsControlJustPressed(1, 154) and not IsAnyPedRappellingFromHeli(Vehicle) and (GetPedInVehicleSeat(Vehicle, 1) == Ped or GetPedInVehicleSeat(Vehicle, 2) == Ped) then
				TaskRappelFromHeli(Ped, 1)
			end
		end

		Wait(TimeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- IPLOADER
-----------------------------------------------------------------------------------------------------------------------------------------
local InfoList = {
	{
		["Props"] = {
			"swap_clean_apt",
			"layer_debra_pic",
			"layer_whiskey",
			"swap_sofa_A"
		},
		["Coords"] = vec3(-1150.70, -1520.70, 10.60)
	}, {
		["Props"] = {
			"csr_beforeMission",
			"csr_inMission"
		},
		["Coords"] = vec3(-47.10, -1115.30, 26.50)
	}, {
		["Props"] = {
			"V_Michael_bed_tidy",
			"V_Michael_M_items",
			"V_Michael_D_items",
			"V_Michael_S_items",
			"V_Michael_L_Items"
		},
		["Coords"] = vec3(-802.30, 175.00, 72.80)
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADIPLOADER
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	for _,v in pairs(InfoList) do
		local Interior = GetInteriorAtCoords(v["Coords"])
		LoadInterior(Interior)

		if v["Props"] then
			for _,i in pairs(v["Props"]) do
				EnableInteriorProp(Interior, i)
			end
		end

		RefreshInterior(Interior)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADMARKED
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		for _,Entity in pairs(GetGamePool("CPed")) do
			if (NetworkGetEntityOwner(Entity) == -1 or NetworkGetEntityOwner(Entity) == PlayerId()) and GetPedArmour(Entity) <= 0 and not NetworkGetEntityIsNetworked(Entity) then
				if IsPedInAnyVehicle(Entity) then
					local Vehicle = GetVehiclePedIsUsing(Entity)
					if NetworkGetEntityIsNetworked(Vehicle) then
						TriggerServerEvent("garages:Delete", NetworkGetNetworkIdFromEntity(Vehicle), GetVehicleNumberPlateText(Vehicle))
					else
						DeleteEntity(Vehicle)
					end
				else
					DeleteEntity(Entity)
				end
			end
		end

		for _,Vehicle in pairs(GetGamePool("CVehicle")) do
			if (NetworkGetEntityOwner(Vehicle) == -1 or NetworkGetEntityOwner(Vehicle) == PlayerId()) and not NetworkGetEntityIsNetworked(Vehicle) and GetVehicleNumberPlateText(Vehicle) ~= "PDMSPORT" then
				DeleteEntity(Vehicle)
			end
		end

		Wait(5000)
	end
end)