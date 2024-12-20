-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vHOSPITAL = Tunnel.getInterface("vrp_hospital")
vGARAGES = Proxy.getInterface("garages")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Zones = {}
local Models = {}
local success = false
local innerEntity = {}
local dismantleList = {}
local setDistance = 10.0
local targetActive = false
local adminService = false
local policeService = false
local paramedicService = false
local mecanicoService = false

local in_area = 0 
local deitado = false

local other = nil
local drag = false
local carregado = false

-----------------------------------------------------------------------------------------------------------------------------------------
-- POLICE:UPDATESERVICE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("police:updateService")
AddEventHandler("police:updateService",function(status)
	policeService = status
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PARAMEDIC:UPDATESERVICE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent('paramedic:updateService')
AddEventHandler('paramedic:updateService', function(status)
	paramedicService = status
end)-----------------------------------------------------------------------------------------------------------------------------------------
-- MECANICA:UPDATESERVICE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent('llimao:mecUpdateService')
AddEventHandler('llimao:mecUpdateService', function(status)
	mecanicoService = status
end)
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- CASAS NO TARGET BY llimao
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent('llimao:casastarget')
AddEventHandler('llimao:casastarget', function(x,y,z,tipo)
	if tipo == "casa" then
		AddBoxZone("Casa"..x.."", vector3(x,y,z+0.9), 3, 3, {
			name = "Casa"..x.."",
			maxZ = z + 1.0
		}, {
			options = {
				{
					event = "llimao:trancardestrancar",
					label = "Trancar/Destrancar",
					tunnel = "server"
				},
				{
					event = "llimao:entrar",
					label = "Entrar",
					tunnel = "server"
				}
			},
			distance = 2.0
		})
	elseif tipo == "apartamento" then
		AddBoxZone("Apartameno"..x.."", vector3(x,y,z+0.9), 3, 3, {
			name = "Apartameno"..x.."",
			maxZ = z
		}, {
			options = {
				{
					event = "llimao:entrar",
					label = "Entrar",
					tunnel = "server"
				},
				{
					event = "llimao:comprar",
					label = "Comprar apartamento",
					tunnel = "server"
				}
			},
			distance = 2.0
		})
	end
end)
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- MACAS NO TARGET BY llimao
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("llimao:enviarmaca")
AddEventHandler("llimao:enviarmaca", function(macas)
	for i = 1, #macas do
		local x, y, z = macas[i].deitado[1], macas[i].deitado[2], macas[i].deitado[3]
		
		AddBoxZone("Maca"..x.."", vector3(x,y,z), 2.0, 2.0, {
			name = "Maca"..x.."",
			maxZ = z
		}, {
			options = {
				{
					event = "llimao:deitarcl",
					label = "Deitar",
					tunnel = "client"
				}
			},
			distance = 2.0
		})
		
    end
end)
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- ENTREGA DE DROGA NO TARGET
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("llimao:enviar_coordTarget")
AddEventHandler("llimao:enviar_coordTarget", function(pedCoords,source)
	local x, y, z = pedCoords.x, pedCoords.y, pedCoords.z
	AddBoxZone("PedDroga"..source.."", vector3(x,y,z+1), 2.0, 2.0, {
		name = "PedDroga"..source.."",
		maxZ = z
	}, {
		options = {
			{
				event = "llimao:entregar",
				label = "Entregar",
				tunnel = "client"
			}
		},
		distance = 2.0
	})	
end)

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- REMOVER TARGET DA ENTREGA DE DROGA NO TARGET
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("llimao:remover_target")
AddEventHandler("llimao:remover_target", function(source)
	RemoveBoxZone("PedDroga"..source.."")	
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- TARGET:TOGGLEADMIN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("target:toggleAdmin")
AddEventHandler("target:toggleAdmin",function()
	if adminService then
		setDistance = 10.0
		adminService = false
		TriggerEvent("Notify","sucesso","Sistema desativado.",5)
	else
		setDistance = 99.0
		adminService = true
		TriggerEvent("Notify","sucesso","Sistema ativado.",5)
	end
end)

local markerType = 1 -- Tipo do marcador (vermelho)
local markerSize = vector3(1.0, 1.0, 1.0) -- Tamanho do marcador
local markerColor = vector3(255, 0, 0) -- Cor do marcador (vermelho)

-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADSYSTEM
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	RegisterCommand("+entityTarget",playerTargetEnable)
	RegisterCommand("-entityTarget",playerTargetDisable)
	RegisterKeyMapping("+entityTarget","Target","keyboard","LMENU")
	TriggerServerEvent("llimao:getcordshome")
	TriggerEvent("llimao:recebermacas")
	
	for k,v in pairs(cfg.chestOrgs) do
		local coords = v.coords
		local org = v.org
		local x, y, z = coords.x, coords.y, coords.z
		
		AddBoxZone(org, vector3(x, y, z), 2.5, 1.5, {
			name = org,
			debugPoly = false,
			heading = 62.2,
			minZ = coords.z - 1.0,
			maxZ = coords.z + 1.0
		}, {
			options = {
				{
					event = "llimao:openorgchest",
					label = "Bau "..org.."",
					tunnel = "server"
				}
			},
			distance = 2.0
		})
		
	end	
	
	for k,v in pairs(cfgrm.locationRoubos) do
		local coords = v.coords
		local tipo = v.type
		local x, y, z = coords.x, coords.y, coords.z
		if tipo == "Caixa Eletronico" then
			AddBoxZone("Roubar"..k, vector3(x, y, z), 3.5, 1.5, {
				name = "Roubar"..k,
				debugPoly = false,
				heading = v.heading,
				minZ = coords.z - 1.0,
				maxZ = coords.z + 1.0
			}, {
				options = {
					{
						event = "roubarcaixa",
						label = v.mensagem,
						tunnel = "client"
					},		
					{
						event = "llimao:sendbank",
						label = "Banco",
						tunnel = "server"
					}
				},
				distance = 2.0
			})
		elseif tipo == "Registradora" then
			AddBoxZone("Roubar"..k, vector3(x, y, z+0.5), 1.5, 0.5, {
				name = "Roubar"..k,
				debugPoly = false,
				heading = v.heading,
				minZ = coords.z - 1.0,
				maxZ = coords.z + 1.0
			}, {
				options = {
					{
						event = "roubarcaixa",
						label = v.mensagem,
						tunnel = "client"
					},		

				},
				distance = 2.0
			})
		else
			AddBoxZone("Roubar"..k, vector3(x, y, z+1.5), 2.5, 0.5, {
				name = "Roubar"..k,
				debugPoly = false,
				heading = v.heading,
				minZ = coords.z - 1.0,
				maxZ = coords.z + 1.0
			}, {
				options = {
					{
						event = "roubarcaixa",
						label = v.mensagem,
						tunnel = "client"
					},		

				},
				distance = 2.0
			})
		end
		
	end
	
	--INTERIOR CLASSE D
	
	AddBoxZone("classed", vector3(151.33, -1008.34, -99.0), 1.6, 0.6, {
		name = "classed",
		heading = 270,
		--debugPoly = true,
		minZ = -101.6,
		maxZ = -97.6
	}, {
		options = {
			{
				event = "llimao:trancardestrancar",
				label = "Trancar/Destrancar",
				tunnel = "server"
			},			
			{
				event = "llimao:sair",
				label = "Sair",
				tunnel = "server"
			},
		},
		distance = 2.0
	})	
	
	--INTERIOR CLASSE C
	
	AddBoxZone("classec", vector3(3978.13, 7450.73, 418.68), 1.0, 2.0, {
		name = "classec",
		heading = 270,
		--debugPoly = true,
		minZ = 416.08,
		maxZ = 420.08
	}, {
		options = {
			{
				event = "llimao:trancardestrancar",
				label = "Trancar/Destrancar",
				tunnel = "server"
			},			
			{
				event = "llimao:sair",
				label = "Sair",
				tunnel = "server"
			},
		},
		distance = 2.0
	})	
	
	--INTERIOR CLASSE B
	
	AddBoxZone("classeb", vector3(3377.84, 7945.03, 386.14), 1.7, 0.7, {
		name = "classeb",
		heading = 270,
		--debugPoly = true,
		minZ = 383.74,
		maxZ = 387.74
	}, {
		options = {
			{
				event = "llimao:trancardestrancar",
				label = "Trancar/Destrancar",
				tunnel = "server"
			},			
			{
				event = "llimao:sair",
				label = "Sair",
				tunnel = "server"
			},
		},
		distance = 2.0
	})	
	
	--INTERIOR CLASSE A
	
	AddBoxZone("classea", vector3(3988.16, 7714.06, 445.44), 1.6, 0.5, {
		name = "classea",
		heading = 0,
		--debugPoly = true,
		minZ = 443.04,
		maxZ = 447.04
	}, {
		options = {
			{
				event = "llimao:trancardestrancar",
				label = "Trancar/Destrancar",
				tunnel = "server"
			},			
			{
				event = "llimao:sair",
				label = "Sair",
				tunnel = "server"
			},
		},
		distance = 2.0
	})		
	
	--INTERIOR exclusivo01
	
	AddBoxZone("exclusivo01", vector3(3970.08, 7356.75, 421.53), 1.6, 2.1, {
		name = "exclusivo01",
		heading = 305,
		--debugPoly = true,
		minZ = 419.53,
		maxZ = 423.53
	}, {
		options = {
			{
				event = "llimao:trancardestrancar",
				label = "Trancar/Destrancar",
				tunnel = "server"
			},			
			{
				event = "llimao:sair",
				label = "Sair",
				tunnel = "server"
			},
		},
		distance = 2.0
	})			
	
	



	AddBoxZone("lojaroupa", vector3(75.56, -1387.66, 29.38), 0.5, 0.5, {
		name = "lojaroupa",
		heading = 0,
		--debugPoly = true,
		minZ = 26.18,
		maxZ = 30.18
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
	AddBoxZone("Farmacia", vector3(-665.58, 321.94, 83.08), 2.9, 1.5, {
		name = "Farmacia",
		heading = 355,
		--debugPoly = true,
		minZ = 80.08,
		maxZ = 84.08
	  }, {
		options = {
			{
				event = "llimao:openstore",
				label = "Farmacia",
				tunnel = "peds"
			}
		},
		distance = 2.0
	})

	AddBoxZone("Bebidas", vector3(129.22, -1283.84, 29.27), 0.7, 0.7, {
		name = "Bebidas",
		heading = 300,
		--debugPoly = true,
		minZ = 26.27,
		maxZ = 30.27
	}, {
		options = {
			{
				event = "llimao:openstore",
				label = "Bebidas",
				tunnel = "server"
			}
		},
		distance = 2.0
	})	
	
	AddBoxZone("DJVanila", vector3(120.05, -1281.67, 29.48), 1.8, 0.4, {
		name = "DJVanila",
		heading = 210,
		--debugPoly = true,
		minZ = 25.88,
		maxZ = 29.88
	}, {
		options = {
			{
				event = "llimao:trocarmusicasv",
				label = "Música",
				tunnel = "server"
			}
		},
		distance = 2.0
	})	
	
	AddTargetModel({ -171943901,1805980844,-99500382,1262298127,1737474779,2040839490,1037469683,867556671,-1521264200,-741944541,-591349326,-293380809,-628719744,-1317098115,1630899471,38932324,-523951410,725259233,764848282,2064599526,536071214,589738836,146905321,47332588,-1118419705,538002882,-377849416,96868307,-1195678770,-606800174,-71417349 },{
		options = {
			{
				event = "target:animSentar",
				label = "Sentar",
				tunnel = "client"
			}
		},
		distance = 1.00
	})	
	
	AddTargetModel({ -586091884 },{
		options = {
			{
				event = "llimao:open_airdropsv",
				label = "Abrir AirDrop",
				tunnel = "server"
			}
		},
		distance = 1.00
	})			

end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- paramedic
-----------------------------------------------------------------------------------------------------------------------------------------
--paramedic TWOPED
local paramedicMenu = {
	{
		event = "llimao:reanimar",
		label = "Reanimar",
		tunnel = "paramedic"
	},
	{
		event = "tratamento:llimao",
		label = "Tratamento",
		tunnel = "paramedic"
	},
	{
		event = "deitar:paciente",
		label = "Deitar Paciente",
		tunnel = "paramedic"
	},	
	{
		event = "llimao:colocarnoveiculo",
		label = "Colocar no Veiculo",
		tunnel = "paramedic"
	},
	{
		event = "llimao:carregarpaciente",
		label = "Carregar Paciente",
		tunnel = "server"
	},
	{
		event = "llimao:cobrar",
		label = "Cobrança",
		tunnel = "server"
	}
}
--paramedic veh
local paramedicoVeh = {
	{
		event = "llimao:tirardoveiculo",
		label = "Remover do veiculo",
		tunnel = "paramedic" 
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- policia
-----------------------------------------------------------------------------------------------------------------------------------------
--TWOPED DA POLICIA
local policePed = {
	{
		event = "inspectEventPolice0",
		label = "Revistar",
		tunnel = "server"
	},
	{
		event = "llimao:algemardesalgemar",
		label = "Algemar/Desalgemar",
		tunnel = "server"
	},
	{
		event = "Danike:prender",
		label = "Prender",
		tunnel = "police"
	},	
	{
		event = "llimao:colocarnoveiculoPM",
		label = "Colocar no Veiculo",
		tunnel = "police"
	},		
	{
		event = "llimao:aprenderitens",
		label = "Apreender Itens",
		tunnel = "police"
	},

	{
		event = "rg:pedir",
		label = "Pedir RG",
		tunnel = "police"
	},
	{
		event = "llimao:cobrar",
		label = "Cobrança",	
		tunnel = "server"
	}

}
--CARRO POLICIA
local policeVeh = {
	{
		event = "llimao:Verificaplaca",
		label = "Verificar Placa",
		tunnel = "police"
	},
	{
		event = "llimao:deterveiculo",
		label = "Detenção do Veículo",
		tunnel = "police"
	},
	{
		event = "llimao:tirardoveiculo",
		label = "Remover do veiculo",
		tunnel = "police"
	},
	{
		event = "llimao:openpmalas",
		label = "Abrir Porta-Malas",
		tunnel = "server" 
	},
	{
		event = "player:trunkin",
		label = "Entrar/Sair Porta-Malas",
		tunnel = "server" 
	}
}

-----------------------------------------------------------------------------------------------------------------------------------------
-- player normal
-----------------------------------------------------------------------------------------------------------------------------------------
--CARRO PLAYER NORMAL
local playerVeh = {
	{
		event = "llimao:openpmalas",
		label = "Abrir Porta-Malas",
		tunnel = "server" 
	},
	{
		event = "player:trunkin",
		label = "Entrar/Sair Porta-Malas",
		tunnel = "server" 
	}
}
--TWOPED PLAYER NORMAL
local twoPed = {
	{
		event = "inspectEvent",
		label = "Roubar",
		tunnel = "client"
	},
	{
		event = "llimao:cobrar",
		label = "Cobrança",
		tunnel = "server"
	},
	{
		event = "llimao:algemardesalgemar",
		label = "Algemar/Desalgemar",
		tunnel = "server"
	},
	{
		event = "llimao:capuz",
		label = "Encapuzar",
		tunnel = "server"
	},
	{
		event = "namorar:pedido",
		label = "Pedir em Namoro",
		tunnel = "server"
	},
	{
		event = "casar:pedido",
		label = "Pedir em Noivado",
		tunnel = "server"
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- MENO DO ADM
-----------------------------------------------------------------------------------------------------------------------------------------
local adminMenu = {
	{
		event = "tryDeleteObject",
		label = "Deletar Objeto",
		tunnel = "admin"
	},
	{
		event = "garages:deleteVehicle",
		label = "Deletar Veículo",
		tunnel = "admin"
	}
}

---------------------------------------------------------
--TARGET MECANICA BY LIMA
---------------------------------------------------------
local lLimaoMecanica = {
	{
		event = "llimao:repararpneus",
		label = "Reparar Pneu(s)",
		tunnel = "server"
	},
	{
		event = "llimao:repararmotor",
		label = "Reparar Motor",
		tunnel = "server"
	},
	{
		event = "llimao:repararlataria",
		label = "Reparar Lataria",
		tunnel = "server"
	},
}

-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYERTARGETENABLE
-----------------------------------------------------------------------------------------------------------------------------------------

function playerTargetEnable()
	if vRP.isHandcuffed() or success or IsPedArmed(PlayerPedId(),6) or IsPedInAnyVehicle(PlayerPedId()) then
		return
	end

	targetActive = true

	SendNUIMessage({ response = "openTarget" })

	while targetActive do
		local ped = PlayerPedId()
		local coords = GetEntityCoords(ped)
		local hit,entCoords,entity = RayCastGamePlayCamera(setDistance)

		if hit == 1 then
			innerEntity = {}

			if GetEntityType(entity) ~= 0 then
				if adminService then
					if DoesEntityExist(entity) then
						if #(coords - entCoords) <= setDistance then
							success = true

							NetworkRegisterEntityAsNetworked(entity)
							while not NetworkGetEntityIsNetworked(entity) do
								NetworkRegisterEntityAsNetworked(entity)
								Citizen.Wait(1)
							end

							local netObjects = NetworkGetNetworkIdFromEntity(entity)
							SetNetworkIdCanMigrate(netObjects,true)
							NetworkSetNetworkIdDynamic(netObjects,false)
							SetNetworkIdExistsOnAllMachines(netObjects,true)

							if IsEntityAVehicle(entity) then
								innerEntity = { netObjects,GetVehicleNumberPlateText(entity) }
							else
								innerEntity = { netObjects }
							end

							SendNUIMessage({ response = "validTarget", data = adminMenu })

							while success and targetActive do
								local ped = PlayerPedId()
								local coords = GetEntityCoords(ped)
								local hit,entCoords,entity = RayCastGamePlayCamera(setDistance)

								DisablePlayerFiring(ped,true)

								if (IsControlJustReleased(1,24) or IsDisabledControlJustReleased(1,24)) then
									SetCursorLocation(0.5,0.5)
									SetNuiFocus(true,true)
								end

								if GetEntityType(entity) == 0 or #(coords - entCoords) > setDistance then
									success = false
								end

								Citizen.Wait(1)
							end

							SendNUIMessage({ response = "leftTarget" })
						end
					end
				elseif IsEntityAVehicle(entity) then
					if #(coords - entCoords) <= 1.0 then
						success = true

						innerEntity = { GetVehicleNumberPlateText(entity) }

						if policeService then 
							SendNUIMessage({ response = "validTarget", data = policeVeh })
						elseif paramedicService then 
							SendNUIMessage({ response = "validTarget", data = paramedicoVeh })
						elseif mecanicoService then
							SendNUIMessage({ response = "validTarget", data = lLimaoMecanica })
						else
							SendNUIMessage({ response = "validTarget", data = playerVeh })
						end

						while success and targetActive do
							local ped = PlayerPedId()
							local coords = GetEntityCoords(ped)
							local hit,entCoords,entity = RayCastGamePlayCamera(setDistance)

							DisablePlayerFiring(ped,true)

							if (IsControlJustReleased(1,24) or IsDisabledControlJustReleased(1,24)) then
								SetCursorLocation(0.5,0.5)
								SetNuiFocus(true,true)
							end

							if GetEntityType(entity) == 0 or #(coords - entCoords) > 1.0 then
								success = false
							end

							Citizen.Wait(1)
						end

						SendNUIMessage({ response = "leftTarget" })
					end
				elseif IsPedAPlayer(entity)  then
					if #(coords - entCoords) <= 1.0 then
						local index = NetworkGetPlayerIndexFromPed(entity)
						local source = GetPlayerServerId(index)

						success = true
						innerEntity = { source }
						if policeService then
							SendNUIMessage({ response = "validTarget", data = policePed })
						elseif paramedicService then
							SendNUIMessage({ response = "validTarget", data = paramedicMenu })						
						else
							SendNUIMessage({ response = "validTarget", data = twoPed })
						end

						while success and targetActive do
							local ped = PlayerPedId()
							local coords = GetEntityCoords(ped)
							local hit,entCoords,entity = RayCastGamePlayCamera(setDistance)

							DisablePlayerFiring(ped,true)

							if (IsControlJustReleased(1,24) or IsDisabledControlJustReleased(1,24)) then
								SetCursorLocation(0.5,0.5)
								SetNuiFocus(true,true)
							end

							if GetEntityType(entity) == 0 or #(coords - entCoords) > 1.0 then
								success = false
							end

							Citizen.Wait(1)
						end

						SendNUIMessage({ response = "leftTarget" })
					end
				elseif IsPedAPlayer(entity) and paramedicService then
					if #(coords - entCoords) <= 1.0 then
						local index = NetworkGetPlayerIndexFromPed(entity)
						local source = GetPlayerServerId(index)

						success = true
						innerEntity = { source,entity }
						SendNUIMessage({ response = "validTarget", data = paramedicMenu })

						while success and targetActive do
							local ped = PlayerPedId()
							local coords = GetEntityCoords(ped)
							local hit,entCoords,entity = RayCastGamePlayCamera(setDistance)

							DisablePlayerFiring(ped,true)

							if (IsControlJustReleased(1,24) or IsDisabledControlJustReleased(1,24)) then
								SetCursorLocation(0.5,0.5)
								SetNuiFocus(true,true)
							end

							if GetEntityType(entity) == 0 or #(coords - entCoords) > 1.0 then
								success = false
							end

							Citizen.Wait(1)
						end

						SendNUIMessage({ response = "leftTarget" })
					end
				else
					for k,v in pairs(Models) do
						if DoesEntityExist(entity) then
							if k == GetEntityModel(entity) then
								if #(coords - entCoords) <= Models[k]["distance"] then

									if Models[k]["desmanche"] then
										local distance = #(coords - vector3(602.39,-437.2,24.75))
										if distance > 25 then
											goto scapeModel
										end
									end

									success = true

									NetworkRegisterEntityAsNetworked(entity)
									while not NetworkGetEntityIsNetworked(entity) do
										NetworkRegisterEntityAsNetworked(entity)
										Citizen.Wait(1)
									end

									while not NetworkHasControlOfEntity(entity) do
										NetworkRequestControlOfEntity(entity)
										Citizen.Wait(1)
									end

									local netObjects = NetworkGetNetworkIdFromEntity(entity)
									SetNetworkIdCanMigrate(netObjects,true)
									NetworkSetNetworkIdDynamic(netObjects,false)
									SetNetworkIdExistsOnAllMachines(netObjects,true)

									innerEntity = { entity,k,netObjects,GetEntityCoords(entity) }
									SendNUIMessage({ response = "validTarget", data = Models[k]["options"] })

									while success and targetActive do
										local ped = PlayerPedId()
										local coords = GetEntityCoords(ped)
										local hit,entCoords,entity = RayCastGamePlayCamera(setDistance)

										DisablePlayerFiring(ped,true)

										if (IsControlJustReleased(1,24) or IsDisabledControlJustReleased(1,24)) then
											SetCursorLocation(0.5,0.5)
											SetNuiFocus(true,true)
										end

										if GetEntityType(entity) == 0 or #(coords - entCoords) > Models[k]["distance"] then
											success = false
										end

										Citizen.Wait(1)
									end

									SendNUIMessage({ response = "leftTarget" })
								end
							end
						end
					end

					::scapeModel::
				end
			end

			for k,v in pairs(Zones) do
				if Zones[k]:isPointInside(entCoords) then
					if #(coords - Zones[k]["center"]) <= v["targetoptions"]["distance"] then
						success = true

						SendNUIMessage({ response = "validTarget", data = Zones[k]["targetoptions"]["options"] })

						if v["targetoptions"]["shop"] ~= nil then
							innerEntity = { v["targetoptions"]["shop"] }
						end

						while success and targetActive do
							local ped = PlayerPedId()
							local coords = GetEntityCoords(ped)
							local hit,entCoords,entity = RayCastGamePlayCamera(setDistance)

							DisablePlayerFiring(ped,true)

							if (IsControlJustReleased(1,24) or IsDisabledControlJustReleased(1,24)) then
								SetCursorLocation(0.5,0.5)
								SetNuiFocus(true,true)
							end

							if not Zones[k]:isPointInside(entCoords) or #(coords - Zones[k]["center"]) > v["targetoptions"]["distance"] then
								success = false
							end

							Citizen.Wait(1)
						end

						SendNUIMessage({ response = "leftTarget" })
					end
				end
			end
		end

		Citizen.Wait(250)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- REMOVETARGETMODEL
-----------------------------------------------------------------------------------------------------------------------------------------
function RemoveTargetModel(models)
	for k,v in pairs(models) do
		if Models[v] then
			Models[v] = nil
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- REMOVER BOX ZONE #llimao	
-----------------------------------------------------------------------------------------------------------------------------------------
function RemoveBoxZone(name)
    Zones[name] = nil
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TARGET:SENTAR
-----------------------------------------------------------------------------------------------------------------------------------------
local chairs = {
	[-171943901] = 0.0,
	[-109356459] = 0.5,
	[1805980844] = 0.5,
	[-99500382] = 0.3,
	[1262298127] = 0.0,
	[1737474779] = 0.5,
	[2040839490] = 0.0,
	[1037469683] = 0.4,
	[867556671] = 0.4,
	[-1521264200] = 0.0,
	[-741944541] = 0.4,
	[-591349326] = 0.5,
	[-293380809] = 0.5,
	[-628719744] = 0.5,
	[-1317098115] = 0.5,
	[1630899471] = 0.5,
	[38932324] = 0.5,
	[-523951410] = 0.5,
	[725259233] = 0.5,
	[764848282] = 0.5,
	[2064599526] = 0.5,
	[536071214] = 0.5,
	[589738836] = 0.5,
	[146905321] = 0.5,
	[47332588] = 0.5,
	[-1118419705] = 0.5,
	[538002882] = -0.1,
	[-377849416] = 0.5,
	[96868307] = 0.5,
	[-1195678770] = 0.7,
	[-606800174] = 0.5,
	[-71417349] = 1.0

}



RegisterNetEvent("target:animSentar")
AddEventHandler("target:animSentar",function()
	local ped = PlayerPedId()
	if GetEntityHealth(ped) > 101 then
		local objCoords = GetEntityCoords(innerEntity[1])

		FreezeEntityPosition(innerEntity[1],true)
		SetEntityCoords(ped,objCoords["x"],objCoords["y"],objCoords["z"] + chairs[innerEntity[2]],1,0,0,0)
		if chairs[innerEntity[2]] == 0.7 then
			SetEntityHeading(ped,GetEntityHeading(innerEntity[1]))
		else
			SetEntityHeading(ped,GetEntityHeading(innerEntity[1]) - 180.0)
		end

		vRP.playAnim(false,{ task = "PROP_HUMAN_SEAT_CHAIR_MP_PLAYER" },false)
	end
end)

RegisterNetEvent("target:animSentar2")
AddEventHandler("target:animSentar2",function()
	local ped = PlayerPedId()
	if GetEntityHealth(ped) > 101 then
		-- Obtém o identificador do objeto
		local object = GetClosestObjectOfType(10.0, 20.0, 30.0, 5.0, GetHashKey("v_corp_offchair"), false)
		
		-- Define a posição do jogador na cadeira
		local playerCoords = GetEntityCoords(PlayerPedId())
		local chairCoords = GetOffsetFromEntityInWorldCoords(object, offsetX, offsetY, offsetZ)
		SetEntityCoords(PlayerPedId(), chairCoords)
		
		-- Define a animação do jogador
		TaskPlayAnim(PlayerPedId(), "anim@heists@ornate_bank@chat_manager", "enter", 1.0, 1.0, -1, 0, 1, false, false, false)
		
		-- Aguarda o término da animação
		while IsEntityPlayingAnim(PlayerPedId(), "anim@heists@ornate_bank@chat_manager", "enter", 3) do
			Citizen.Wait(0)
		end
		
		-- Define a posição do jogador novamente
		SetEntityCoords(PlayerPedId(), playerCoords)

	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
--[ PRISÃO ]-----------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
local prisioneiro = false
local reducaopenal = false

RegisterNetEvent('prisioneiro')
AddEventHandler('prisioneiro',function(status)
	prisioneiro = status
	reducaopenal = false
	local ped = PlayerPedId()
	if prisioneiro then
		SetEntityInvincible(ped,true)
		FreezeEntityPosition(ped,true)
		SetEntityVisible(ped,false,false)
		SetTimeout(10000,function()
			SetEntityInvincible(ped,false)
			FreezeEntityPosition(ped,false)
			SetEntityVisible(ped,true,false)
		end)
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(5000)
		if prisioneiro then
			local distance = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),1700.5,2605.2,45.5,true)
			if distance >= 150 then
				SetEntityCoords(PlayerPedId(),1680.1,2513.0,45.5)
				TriggerEvent("Notify","aviso","O agente penitenciário encontrou você tentando escapar.")
			end
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		wait = 1000
		if prisioneiro then
			local distance1 = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),1691.59,2566.05,45.56,true)
			local distance2 = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),1669.51,2487.71,45.82,true)

			if GetEntityHealth(PlayerPedId()) <= 100 then
				reducaopenal = false
				vRP._DeletarObjeto()
			end

			if distance1 <= 100 and not reducaopenal then
				wait = 5
				DrawMarker(21,1691.59,2566.05,45.56,0,0,0,0,180.0,130.0,1.0,1.0,0.5,255,0,0,100,1,0,0,1)
				if distance1 <= 1.2 then
					daleminhapikatxt("PRESSIONE  ~r~E~w~  PARA PEGAR A CAIXA",4,0.5,0.93,0.50,255,255,255,180)
					if IsControlJustPressed(0,38) then
						reducaopenal = true
						ResetPedMovementClipset(PlayerPedId(),0)
						SetRunSprintMultiplierForPlayer(PlayerId(),1.0)
						vRP._CarregarObjeto("anim@heists@box_carry@","idle","hei_prop_heist_box",50,28422)
					end
				end
			end

			if distance2 <= 100 and reducaopenal then
				wait = 5
				DrawMarker(21,1669.51,2487.71,45.82,0,0,0,0,180.0,130.0,1.0,1.0,0.5,255,0,0,100,1,0,0,1)
				if distance2 <= 1.2 then
					daleminhapikatxt("PRESSIONE  ~r~E~w~  PARA ENTREGAR A CAIXA",4,0.5,0.93,0.50,255,255,255,180)
					if IsControlJustPressed(0,38) then
						reducaopenal = false
						TriggerServerEvent("danike:pena")
						vRP._DeletarObjeto()
					end
				end
			end
		end
		Citizen.Wait(wait)
	end
end)

Citizen.CreateThread(function()
	while true do
		wait = 1000
		if reducaopenal then
			wait = 5
			BlockWeaponWheelThisFrame()
			DisableControlAction(0,21,true)
			DisableControlAction(0,22,true)
			DisableControlAction(0,24,true)
			DisableControlAction(0,25,true)
			DisableControlAction(0,29,true)
			DisableControlAction(0,32,true)
			DisableControlAction(0,33,true)
			DisableControlAction(0,34,true)
			DisableControlAction(0,35,true)
			DisableControlAction(0,56,true)
			DisableControlAction(0,58,true)
			DisableControlAction(0,73,true)
			DisableControlAction(0,75,true)
			DisableControlAction(0,140,true)
			DisableControlAction(0,141,true)
			DisableControlAction(0,142,true)
			DisableControlAction(0,143,true)
			DisableControlAction(0,166,true)
			DisableControlAction(0,167,true)
			DisableControlAction(0,170,true)
			DisableControlAction(0,177,true)
			DisableControlAction(0,182,true)
			DisableControlAction(0,187,true)
			DisableControlAction(0,188,true)
			DisableControlAction(0,189,true)
			DisableControlAction(0,190,true)
			DisableControlAction(0,243,true)
			DisableControlAction(0,245,true)
			DisableControlAction(0,246,true)
			DisableControlAction(0,257,true)
			DisableControlAction(0,263,true)
			DisableControlAction(0,264,true)
			DisableControlAction(0,268,true)
			DisableControlAction(0,269,true)
			DisableControlAction(0,270,true)
			DisableControlAction(0,271,true)
			DisableControlAction(0,288,true)
			DisableControlAction(0,289,true)
			DisableControlAction(0,303,true)
			DisableControlAction(0,311,true)
			DisableControlAction(0,344,true)
		end
		Citizen.Wait(wait)
	end
end)

function daleminhapikatxt(text,font,x,y,scale,r,g,b,a)
	SetTextFont(font)
	SetTextScale(scale,scale)
	SetTextColour(r,g,b,a)
	SetTextOutline()
	SetTextCentre(1)
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(x,y)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYERTARGETDISABLE
-----------------------------------------------------------------------------------------------------------------------------------------
function playerTargetDisable()
	if success or not targetActive then
		return
	end

	targetActive = false
	SendNUIMessage({ response = "closeTarget" })
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SELECTTARGET
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("selectTarget",function(data,cb)
	success = false
	targetActive = false
	SetNuiFocus(false,false)
	SendNUIMessage({ response = "closeTarget" })

	if data["tunnel"] == "client" then
		TriggerEvent(data["event"],innerEntity)
	elseif data["tunnel"] == "server" then
		TriggerServerEvent(data["event"],innerEntity)
	elseif data["tunnel"] == "shop" then
		TriggerEvent(data["event"],innerEntity[1])
	elseif data["tunnel"] == "paramedic" then
		TriggerServerEvent(data["event"],innerEntity[1])
	elseif data["tunnel"] == "police" then
		TriggerServerEvent(data["event"],innerEntity,data["service"])
	elseif data["tunnel"] == "objects" then
		TriggerServerEvent(data["event"],innerEntity[3])
	elseif data["tunnel"] == "admin" then
		TriggerServerEvent(data["event"],innerEntity[1],innerEntity[2])
	else
		TriggerServerEvent(data["event"])
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLOSETARGET
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("closeTarget",function(data,cb)
	success = false
	targetActive = false
	SetNuiFocus(false,false)
	SendNUIMessage({ response = "closeTarget" })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- RESETDEBUG
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("target:resetDebug")
AddEventHandler("target:resetDebug",function()
	success = false
	targetActive = false
	SetNuiFocus(false,false)
	SendNUIMessage({ response = "closeTarget" })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ROTATIONTODIRECTION
-----------------------------------------------------------------------------------------------------------------------------------------
function RotationToDirection(rotation)
	local adjustedRotation = {
		x = (math.pi / 180) * rotation["x"],
		y = (math.pi / 180) * rotation["y"],
		z = (math.pi / 180) * rotation["z"]
	}

	local direction = {
		x = -math.sin(adjustedRotation["z"]) * math.abs(math.cos(adjustedRotation["x"])),
		y = math.cos(adjustedRotation["z"]) * math.abs(math.cos(adjustedRotation["x"])),
		z = math.sin(adjustedRotation["x"])
	}

	return direction
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- RAYCASTGAMEPLAYCAMERA
-----------------------------------------------------------------------------------------------------------------------------------------
function RayCastGamePlayCamera(distance)
	local cameraCoord = GetGameplayCamCoord()
	local cameraRotation = GetGameplayCamRot()
	local direction = RotationToDirection(cameraRotation)

	local destination = {
		x = cameraCoord["x"] + direction["x"] * distance,
		y = cameraCoord["y"] + direction["y"] * distance,
		z = cameraCoord["z"] + direction["z"] * distance
	}

	local a,b,c,d,e = GetShapeTestResult(StartShapeTestRay(cameraCoord["x"],cameraCoord["y"],cameraCoord["z"],destination["x"],destination["y"],destination["z"],-1,PlayerPedId(),0))

	return b,c,e
end

--CORNO

-----------------------------------------------------------------------------------------------------------------------------------------
-- ADDCIRCLEZONE
-----------------------------------------------------------------------------------------------------------------------------------------
function AddCircleZone(name,center,radius,options,targetoptions)
	Zones[name] = CircleZone:Create(center,radius,options)
	Zones[name]["targetoptions"] = targetoptions
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADDBOXZONE
-----------------------------------------------------------------------------------------------------------------------------------------
function AddBoxZone(name,center,length,width,options,targetoptions)
	Zones[name] = BoxZone:Create(center,length,width,options)
	Zones[name]["targetoptions"] = targetoptions
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADDPOLYZONE
-----------------------------------------------------------------------------------------------------------------------------------------
function AddPolyzone(name,points,options,targetoptions)
	Zones[name] = PolyZone:Create(points,options)
	Zones[name]["targetoptions"] = targetoptions
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADDTARGETMODEL
-----------------------------------------------------------------------------------------------------------------------------------------
function AddTargetModel(models,parameteres)
	for k,v in pairs(models) do
		Models[v] = parameteres
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- EXPORTS
-----------------------------------------------------------------------------------------------------------------------------------------
exports("AddBoxZone",AddBoxZone)
exports("AddPolyzone",AddPolyzone)
exports("AddCircleZone",AddCircleZone)
exports("AddTargetModel",AddTargetModel)