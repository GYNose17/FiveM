Citizen.CreateThread(function()
	RegisterCommand("+entityTarget",playerTargetEnable)
	RegisterCommand("-entityTarget",playerTargetDisable)
	RegisterKeyMapping("+entityTarget","Target","keyboard","LMENU")
	
	
	AddBoxZone("Banco01", vector3(-1212.41, -332.45, 37.78), 2.8, 6.4, {
		name = "Banco01",
		heading = 25,
		minZ = 34.98,
		maxZ = 38.98
	}, {
		options = {
			{
				event = "llimao:sendbank",
				label = "Banco",
				tunnel = "server"
			}
		},
		distance = 2.0
	})	
	
	AddBoxZone("Banco02", vector3(-351.79, -50.23, 49.05), 0.6, 6.0, {
		name = "Banco02",
		heading = 340,
		minZ = 45.85,
		maxZ = 50.25
	}, {
		options = {
			{
				event = "llimao:sendbank",
				label = "Banco",
				tunnel = "server"
			}
		},
		distance = 2.0
	})		
	
	AddBoxZone("Banco03", vector3(313.44, -279.71, 54.17), 1.0, 6.0, {
		name = "Banco03",
		heading = 340,
		minZ = 51.37,
		maxZ = 55.37
	}, {
		options = {
			{
				event = "llimao:sendbank",
				label = "Banco",
				tunnel = "server"
			}
		},
		distance = 2.0
	})		
	
	AddBoxZone("Banco04", vector3(148.97, -1041.08, 29.37), 1.0, 6.2, {
		name = "Banco04",
		heading = 340,
		minZ = 26.37,
		maxZ = 30.37
	}, {
		options = {
			{
				event = "llimao:sendbank",
				label = "Banco",
				tunnel = "server"
			}
		},
		distance = 2.0
	})		
	
	AddBoxZone("Banco05", vector3(-2962.03, 482.35, 15.71), 0.8, 5.8, {
		name = "Banco05",
		heading = 268,
		minZ = 12.71,
		maxZ = 16.71
	}, {
		options = {
			{
				event = "llimao:sendbank",
				label = "Banco",
				tunnel = "server"
			}
		},
		distance = 2.0
	})		
	
	AddBoxZone("Banco06", vector3(-112.18, 6470.08, 31.63), 0.8, 6.1, {
		name = "Banco06",
		heading = 315,
		minZ = 30.63,
		maxZ = 32.83
	}, {
		options = {
			{
				event = "llimao:sendbank",
				label = "Banco",
				tunnel = "server"
			}
		},
		distance = 2.0
	})		
	
	AddBoxZone("Banco07", vector3(1175.59, 2707.21, 38.09), 0.8, 6.1, {
		name = "Banco07",
		heading = 0,
		minZ = 35.09,
		maxZ = 39.09
	}, {
		options = {
			{
				event = "llimao:sendbank",
				label = "Banco",
				tunnel = "server"
			}
		},
		distance = 2.0
	})	
	
	AddBoxZone("Bancopraca", vector3(147.51, -1036.12, 29.34), 0.4, 1.4, {
		name = "Bancopraca",
		heading = 341,
		minZ = 28.74,
		maxZ = 30.74
	}, {
		options = {
			{
				event = "llimao:sendbank",
				label = "Banco",
				tunnel = "server"
			}
		},
		distance = 2.0
	})	
	
	AddBoxZone("Bancopraca2", vector3(145.85, -1035.61, 29.34), 0.4, 1.4, {
		name = "Bancopraca2",
		heading = 340,
		minZ = 28.54,
		maxZ = 30.54
	}, {
		options = {
			{
				event = "llimao:sendbank",
				label = "Banco",
				tunnel = "server"
			}
		},
		distance = 2.0
	})
	AddBoxZone("Bancomecanica", vector3(2744.76, 3481.76, 55.26), 0.7, 0.7, {
		name = "Bancomecanica",
		heading = 335,
		--debugPoly = true,
		minZ = 52.06,
		maxZ = 56.06
	  }, {
		options = {
			{
				event = "llimao:sendbank",
				label = "Banco",
				tunnel = "server"
			}
		},
		distance = 2.0
	})
	
end)