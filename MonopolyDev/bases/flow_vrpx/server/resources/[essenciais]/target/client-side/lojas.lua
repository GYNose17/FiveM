for _, storeLoc in ipairs(cfg.storesLocs) do
    
	local x = storeLoc.coords.x
	local y = storeLoc.coords.y
	local z = storeLoc.coords.z
	local storeType = storeLoc.type


	if storeType == "Ammunation" then

		AddBoxZone(""..storeType..""..x.."", vector3(x,y,z), 3.8, 3.6, {
			name = ""..storeType..""..x.."",
			--heading = 320,
			minZ = z - 1.0,
			maxZ = z + 1.0
		}, {
			options = {
				{
					event = "llimao:openstore",
					label = storeType,
					tunnel = "server"
				}
			},
			distance = 2.0
		})    

	end

end
Citizen.CreateThread(function()
	RegisterCommand("+entityTarget",playerTargetEnable)
	RegisterCommand("-entityTarget",playerTargetDisable)
	RegisterKeyMapping("+entityTarget","Target","keyboard","LMENU")
	
	AddBoxZone("Loja01", vector3(-47.39, -1758.66, 29.42), 0.8, 0.6, {
		name = "Loja",
		heading = 320,
		minZ = 26.42,
		maxZ = 30.42
	}, {
		options = {
			{
				event = "llimao:openstore",
				label = "Loja",
				tunnel = "server"
			}
		},
		distance = 2.0
	})	
	
	AddBoxZone("Loja02", vector3(-1221.49, -907.88, 12.33), 0.8, 0.6, {
		name = "Loja",
		heading = 35,
		minZ = 9.33,
		maxZ = 13.33
	}, {
		options = {
			{
				event = "llimao:openstore",
				label = "Loja",
				tunnel = "server"
			}
		},
		distance = 2.0
	})	
	
	AddBoxZone("Loja03", vector3(24.63, -1347.97, 29.5), 0.8, 0.6, {
		name = "loja",
		heading = 355,
		minZ = 26.7,
		maxZ = 30.7
	}, {
		options = {
			{
				event = "llimao:openstore",
				label = "Loja",
				tunnel = "server"
			}
		},
		distance = 2.0
	})	
	
	AddBoxZone("Loja04", vector3(1134.26, -982.97, 46.42), 0.8, 0.6, {
		name = "Loja",
		heading = 0,
		minZ = 43.42,
		maxZ = 47.42
	}, {
		options = {
			{
				event = "llimao:openstore",
				label = "Loja",
				tunnel = "server"
			}
		},
		distance = 2.0
	})	
	
	AddBoxZone("Loja05", vector3(1164.92, -323.51, 69.21), 0.8, 0.6, {
		name = "Loja",
		heading = 10,
		minZ = 66.21,
		maxZ = 70.21
	}, {
		options = {
			{
				event = "llimao:openstore",
				label = "Loja",
				tunnel = "server"
			}
		},
		distance = 2.0
	})
	
	AddBoxZone("Loja06", vector3(372.5, 325.85, 103.57), 0.8, 0.6, {
		name = "Loja",
		heading = 345,
		minZ = 100.57,
		maxZ = 104.57
	}, {
		options = {
			{
				event = "llimao:openstore",
				label = "Loja",
				tunnel = "server"
			}
		},
		distance = 2.0
	})	
	
	AddBoxZone("Loja07", vector3(2557.97, 380.77, 108.62), 0.8, 0.6, {
		name = "Loja",
		heading = 265,
		minZ = 105.62,
		maxZ = 109.62
	}, {
		options = {
			{
				event = "llimao:openstore",
				label = "Loja",
				tunnel = "server"
			}
		},
		distance = 2.0
	})	
	
	AddBoxZone("Loja08", vector3(2678.51, 3279.1, 55.24), 0.8, 0.6, {
		name = "Loja",
		heading = 60,
		minZ = 52.24,
		maxZ = 56.24
	}, {
		options = {
			{
				event = "llimao:openstore",
				label = "Loja",
				tunnel = "server"
			}
		},
		
		distance = 2.0
	})	
	
	AddBoxZone("Loja09", vector3(1960.46, 3739.58, 32.34), 0.8, 0.6, {
		name = "Loja",
		heading = 30,
		minZ = 29.34,
		maxZ = 33.34
	}, {
		options = {
			{
				event = "llimao:openstore",
				label = "Loja",
				tunnel = "server"
			}
		},
		distance = 2.0
	})	
	
	AddBoxZone("Loja10", vector3(1393.68, 3606.62, 34.98), 0.8, 0.6, {
		name = "Loja",
		heading = 290,
		minZ = 31.98,
		maxZ = 35.98
	}, {
		options = {
			{
				event = "llimao:openstore",
				label = "Loja",
				tunnel = "server"
			}
		},
		distance = 2.0
	})	
	
	AddBoxZone("Loja11", vector3(1165.16, 2710.86, 38.16), 0.8, 0.6, {
		name = "Loja",
		heading = 90,
		minZ = 35.16,
		maxZ = 39.16
	}, {
		options = {
			{
				event = "llimao:openstore",
				label = "Loja",
				tunnel = "server"
			}
		},
		distance = 2.0
	})	
	
	AddBoxZone("Loja12", vector3(549.08, 2671.99, 42.16), 0.8, 0.6, {
		name = "Loja",
		heading = 355,
		minZ = 39.16,
		maxZ = 43.16
	}, {
		options = {
			{
				event = "llimao:openstore",
				label = "Loja",
				tunnel = "server"
			}
		},
		distance = 2.0
	})	

	AddBoxZone("Loja13", vector3(1697.35, 4923.41, 42.06), 0.8, 0.6, {
		name = "Loja",
		heading = 50,
		minZ = 39.06,
		maxZ = 43.06
	}, {
		options = {
			{
				event = "llimao:openstore",
				label = "Loja",
				tunnel = "server"
			}
		},
		distance = 2.0
	})	
	
	AddBoxZone("Loja14", vector3(1727.6, 6414.72, 35.04), 0.8, 0.6, {
		name = "Loja",
		heading = 155,
		minZ = 32.04,
		maxZ = 36.04
	}, {
		options = {
			{
				event = "llimao:openstore",
				label = "Loja",
				tunnel = "server"
			}
		},
		distance = 2.0
	})	
	
	AddBoxZone("Loja15", vector3(-3241.71, 999.87, 12.83), 0.8, 0.6, {
		name = "Loja",
		heading = 265,
		minZ = 9.83,
		maxZ = 13.83
	}, {
		options = {
			{
				event = "llimao:openstore",
				label = "Loja",
				tunnel = "server"
			}
		},
		distance = 2.0
	})	
	
	AddBoxZone("Loja16", vector3(-2966.36, 391.59, 15.04), 0.8, 0.6, {
		name = "Loja",
		heading = 0,
		minZ = 12.04,
		maxZ = 16.04
	}, {
		options = {
			{
				event = "llimao:openstore",
				label = "Loja",
				tunnel = "server"
			}
		},
		distance = 2.0
	})	
	
	AddBoxZone("Loja17", vector3(-3038.46, 584.74, 7.91), 0.8, 0.6, {
		name = "Loja",
		heading = 105,
		minZ = 4.91,
		maxZ = 8.91
	}, {
		options = {
			{
				event = "llimao:openstore",
				label = "Loja",
				tunnel = "server"
			}
		},
		distance = 2.0
	})	
	
	AddBoxZone("Loja18", vector3(-1819.45, 793.48, 138.11), 0.8, 0.6, {
		name = "Loja",
		heading = 225,
		minZ = 135.11,
		maxZ = 139.11
	}, {
		options = {
			{
				event = "llimao:openstore",
				label = "Loja",
				tunnel = "server"
			}
		},
		distance = 2.0
	})	
	
	AddBoxZone("Loja19", vector3(-1486.65, -377.65, 40.16), 0.8, 0.6, {
		name = "Loja",
		heading = 225,
		minZ = 37.16,
		maxZ = 41.16
	}, {
		options = {
			{
				event = "llimao:openstore",
				label = "Loja",
				tunnel = "server"
			}
		},
		distance = 2.0
	})	
	
	AddBoxZone("Loja20", vector3(-706.07, -914.86, 19.22), 0.8, 0.6, {
		name = "Loja",
		heading = 0,
		minZ = 16.22,
		maxZ = 20.22
	}, {
		options = {
			{
				event = "llimao:openstore",
				label = "Loja",
				tunnel = "server"
			}
		},
		distance = 2.0
	})		
	
	AddBoxZone("Conce", vector3(-40.34, -1094.55, 27.27), 1.2, 1.4, {
		name = "Conce",
		heading = 25,
		--debugPoly = true,
		minZ = 24.67,
		maxZ = 28.67
	  }, {
		options = {
			{
				event = "llimao:openconce",
				label = "Concessionária",
				tunnel = "server"
			}
		},
		distance = 2.0
	})		
	
	AddBoxZone("lojapeixe", vector3(-3277.71, 969.84, 8.35), 0.5, 0.7, {
		name = "lojapeixe",
		heading = 359,
		minZ = 5.15,
		maxZ = 9.15
	  }, {
		options = {
			{
				event = "llimao:openstore",
				label = "Venda de Peixes",
				tunnel = "server"
			}
		},
		distance = 2.0
	})	
	
	AddBoxZone("lojatartaruga", vector3(3725.3, 4525.75, 22.47), 0.7, 0.7, {
		name = "lojatartaruga",
		heading = 355,
		--debugPoly = true,
		minZ = 19.47,
		maxZ = 23.47
	}, {
		options = {
			{
				event = "llimao:openstore",
				label = "Venda de Tartaruga",
				tunnel = "server"
			}
		},
		distance = 2.0
	})	
	
	AddBoxZone("mercado negro", vector3(706.81, -966.87, 30.41), 0.9, 0.7, {
		name = "mercado negro",
		heading = 3,
		--debugPoly = true,
		minZ = 27.21,
		maxZ = 31.21
	  }, {
		options = {
			{
				event = "llimao:openstore",
				label = "Mercado Negro",
				tunnel = "server"
			}
		},
		distance = 2.0
	})	


	AddBoxZone("Arsenal", vector3(1306.69, -770.69, 65.66), 0.7, 1.9, {
		name = "Arsenal",
		heading = 333,
		--debugPoly = true,
		minZ = 62.46,
		maxZ = 66.46
	  }, {
		options = {
			{
				event = "llimao:openstore",
				label = "Arsenal PMESP",
				tunnel = "server"
			}
		},
		distance = 2.0
	})	
	
	AddBoxZone("Arsenalprf", vector3(2604.49, 5341.4, 47.62), 1.7, 1.3, {
		name = "Arsenalprf",
		heading = 106,
		--debugPoly = true,
		minZ = 45.02,
		maxZ = 49.02
	  }, {
		options = {
			{
				event = "llimao:openstore",
				label = "Arsenal PRF",
				tunnel = "server"
			}
		},
		distance = 2.0
	})
  ---- ROTA -------------------------------------------------------------
	AddBoxZone("Arsenalrota", vector3(-2067.92, -484.48, 12.49), 1.3, 1.1, {
		name = "Arsenalrota",
		heading = 320,
		--debugPoly = true,
		minZ = 9.89,
		maxZ = 13.89
	  }, {
		options = {
			{
				event = "llimao:openstore",
				label = "Arsenal ROTA",
				tunnel = "server"
			}
		},
		distance = 2.0
	})

	AddBoxZone("CivilArsenal", vector3(279.09, -346.39, 49.57), 0.6, 3.0, {
		name = "CivilArsenal",
		heading = 340,
		--debugPoly = true,
		minZ = 46.77,
		maxZ = 50.77
	  }, {
		options = {
			{
				event = "llimao:openstore",
				label = "Arsenal CIVIL",
				tunnel = "server"
			}
		},
		distance = 2.0
	})
	AddBoxZone("Oficina", vector3(2718.73, 3505.57, 55.26), 4.9, 0.9, {
		name = "Oficina",
		heading = 247,
		--debugPoly = true,
		minZ = 52.66,
		maxZ = 56.66
	  }, {
		options = {
			{
				event = "llimao:openstore",
				label = "Oficina",
				tunnel = "server"
			}
		},
		distance = 2.5
	})

	
	AddBoxZone("lojabox", vector3(-551.96, 5348.22, 74.75), 0.7, 1.5, {
		name = "lojabox",
		heading = 345,
		--debugPoly = true,
		minZ = 71.75,
		maxZ = 75.75
	}, {
		options = {
			{
				event = "llimao:openstore",
				label = "Venda de Madeira",
				tunnel = "server"
			}
		},
		distance = 2.0
	})	
	
	AddBoxZone("joais", vector3(-622.11, -232.77, 38.06), 1.6, 2.8, {
		name = "joais",
		heading = 305,
		minZ = 37.06,
		maxZ = 39.46
	}, {
		options = {
			{
				event = "llimao:openstore",
				label = "Comprar Joais",
				tunnel = "server"
			}
		},
		distance = 1.5
	})	
	
	AddBoxZone("lojavenderjoais", vector3(-619.42, -225.74, 38.06), 0.7, 0.9, {
		name = "lojavenderjoais",
		heading = 300,
		--debugPoly = true,
		minZ = 36.86,
		maxZ = 39.46
	}, {
		options = {
			{
				event = "llimao:openstore",
				label = "Vender Joais",
				tunnel = "server"
			}
		},
		distance = 1.5
	})	
	AddBoxZone("fazenda2", vector3(2885.51, 4387.44, 50.66), 0.9, 0.9, {
		name = "fazenda2",
		heading = 25,
		--debugPoly = true,
		minZ = 48.06,
		maxZ = 52.06
	  }, {
		options = {
			{
				event = "llimao:openstore",
				label = "Vendinha",
				tunnel = "server"
			}
		},
		distance = 2.5
	})	
	
end)