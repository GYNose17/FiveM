local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")

src = {}
Tunnel.bindInterface("vrp_farms",src)
vSERVER = Tunnel.getInterface("vrp_farms")

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
local isOpenned = false
local blips = {}
local in_rota = false
local itemRoute = ""
local itemName = ""
local bancadaName = ""
local itemAmountRoute = 0
local itemMinAmountRoute = 0
local itemMaxAmountRoute = 0
local itemNumRoute = 0
local segundos = 0

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- MENUS
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function openNui(bancada, itens, bBancada)
	if not isOpenned then
		SetNuiFocus(true,true)
		TransitionToBlurred(1000)
		SendNUIMessage({ showmenu = true, bancada = bancada, itens = itens,  bancadaName = bBancada })
		isOpenned = true
	end
end

RegisterNUICallback("closeNui", function(data, cb)
	if isOpenned then
		SetNuiFocus(false, false)
		TransitionFromBlurred(1000)
		SendNUIMessage({ hidemenu = true })
		isOpenned = false
	end
end)

RegisterNUICallback("fabricarItem", function(data, cb)
	vSERVER.fabricarItem(data.item, data.minAmount, data.maxAmount, data.bancada)
end)

function src.closeNui()
	SetNuiFocus(false, false)
	TransitionFromBlurred(1000)
	SendNUIMessage({ hidemenu = true })
	isOpenned = false
end

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- ABRIR MENU
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local time = 1000
		if not isOpenned and not in_rota then 
			for k,v in pairs(cfg.initRoutesPositions)  do
				local ped = PlayerPedId()
				local x,y,z = table.unpack(GetEntityCoords(ped))
				local bowz,cdz = GetGroundZFor_3dCoord(v.coords[1],v.coords[2],v.coords[3])
				local distance = GetDistanceBetweenCoords(v.coords[1],v.coords[2],cdz,x,y,z,true)

				if distance <= 1.5 then
					DrawText3D(v.coords[1],v.coords[2],v.coords[3], v.text)
					time = 5
					if IsControlJustPressed(0,38) and vSERVER.checkPermission(v.perm) then
						local bName,bItens,bBancada = vSERVER.requestBancada(v.type)
						if bName and bItens then
							openNui(bName,bItens,bBancada)
						end
					end
				end
				
			end
		end

		Citizen.Wait(time)
	end
end)

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- ROTAS
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function src.iniciarRota(item, itemName2, minAmount, maxAmount, bancada)
	if not in_rota then
		in_rota = true
		itemNumRoute = math.random(#cfg.allRoutes)
		bancadaName = bancada
		itemRoute = item
		itemName = itemName2
		itemMinAmountRoute = minAmount
		itemMaxAmountRoute = maxAmount
		itemAmountRoute = math.random(itemMinAmountRoute,itemMaxAmountRoute)
		exports.flow_hud:setMinimapActive(false)

		CriandoBlip(itemNumRoute, bancadaName)

		async(function()
			while in_rota do
				local time = 1000
				local ped = PlayerPedId()
				local pedCoords = GetEntityCoords(ped)
				if bancadaName == "ILHA" then
					local distance = #(pedCoords - cfg.ilhaRoutes[parseInt(itemNumRoute)].coords)
					if distance <= 15.0 then
						time = 5
						DrawMarker(21,cfg.ilhaRoutes[parseInt(itemNumRoute)].coords[1],cfg.ilhaRoutes[parseInt(itemNumRoute)].coords[2],cfg.ilhaRoutes[parseInt(itemNumRoute)].coords[3],0,0,0,0,180.0,130.0,1.0,1.0,0.5, 25,140,255,180 ,1,0,0,1)

						if distance <= 2.0 then
							if IsControlJustReleased(1, 51) and segundos <= 0 and not IsPedInAnyVehicle(PlayerPedId()) then 
								segundos = 5

								if vSERVER.giveItem(itemRoute, parseInt(itemAmountRoute)) then
									itemNumRoute = itemNumRoute + 1

									if itemNumRoute > #cfg.ilhaRoutes then
										itemNumRoute = 1
									end

									itemAmountRoute = math.random(itemMinAmountRoute,itemMaxAmountRoute)
									RemoveBlip(blips)
									CriandoBlip(itemNumRoute, bancadaName)
								end
							end
						end
					end
				elseif bancadaName == "BENNYS" then
					local distance = #(pedCoords - cfg.bennysRoutes[parseInt(itemNumRoute)].coords)
					if distance <= 15.0 then
						time = 5
						DrawMarker(21,cfg.bennysRoutes[parseInt(itemNumRoute)].coords[1],cfg.bennysRoutes[parseInt(itemNumRoute)].coords[2],cfg.bennysRoutes[parseInt(itemNumRoute)].coords[3],0,0,0,0,180.0,130.0,1.0,1.0,0.5, 25,140,255,180 ,1,0,0,1)

						if distance <= 2.0 then
							if IsControlJustReleased(1, 51) and segundos <= 0 and not IsPedInAnyVehicle(PlayerPedId()) then 
								segundos = 5

								if vSERVER.giveItem(itemRoute, parseInt(itemAmountRoute)) then
									itemNumRoute = itemNumRoute + 1

									if itemNumRoute > #cfg.bennysRoutes then
										itemNumRoute = 1
									end

									itemAmountRoute = math.random(itemMinAmountRoute,itemMaxAmountRoute)
									RemoveBlip(blips)
									CriandoBlip(itemNumRoute, bancadaName)
								end
							end
						end
					end
				else
					local distance = #(pedCoords - cfg.allRoutes[parseInt(itemNumRoute)].coords)
					if distance <= 15.0 then
						time = 5
						DrawMarker(21,cfg.allRoutes[parseInt(itemNumRoute)].coords[1],cfg.allRoutes[parseInt(itemNumRoute)].coords[2],cfg.allRoutes[parseInt(itemNumRoute)].coords[3],0,0,0,0,180.0,130.0,1.0,1.0,0.5, 25,140,255,180 ,1,0,0,1)

						if distance <= 2.0 then
							if IsControlJustReleased(1, 51) and segundos <= 0 and not IsPedInAnyVehicle(PlayerPedId()) then 
								segundos = 5

								if vSERVER.giveItem(itemRoute, parseInt(itemAmountRoute), parseInt(itemNumRoute)) then
									vRP._playAnim(false,{{"pickup_object","pickup_low"}},false)
									itemNumRoute = math.random(#cfg.allRoutes)

									if itemNumRoute > #cfg.allRoutes then
										itemNumRoute = 1
									end

									itemAmountRoute = math.random(itemMinAmountRoute,itemMaxAmountRoute)
									RemoveBlip(blips)
									CriandoBlip(itemNumRoute, bancadaName)
								end
							end
						end
					end
				end

				Citizen.Wait(time)
			end
		end)
	end
end

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- EM SERVIÇO
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local time = 1000
		if in_rota then
			time = 5
			drawTxt("~w~Aperte ~r~F7~w~ se deseja finalizar a entrega.\nColete ~y~"..itemAmountRoute.."x "..itemName.."~w~.", 0.215,0.94)

			if IsControlJustPressed(0, 168) and not IsPedInAnyVehicle(PlayerPedId()) then
				in_rota = false
				itemRoute = ""
				itemName = ""
				itemAmountRoute = 0
				itemNumRoute = 0
				RemoveBlip(blips)
				exports.flow_hud:setMinimapActive(false)
			end
		end
		
		Citizen.Wait(time)
	end
end)

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- FUNCTION
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function DrawText3D(x, y, z, text)
	local onScreen,_x,_y = World3dToScreen2d(x,y,z)
	SetTextFont(4)
	SetTextScale(0.35,0.35)
	SetTextColour(255,255,255,150)
	SetTextEntry("STRING")
	SetTextCentre(1)
	AddTextComponentString(text)
	DrawText(_x,_y)
end

function drawTxt(text,x,y)
	local res_x, res_y = GetActiveScreenResolution()

	SetTextFont(4)
	SetTextScale(0.3,0.3)
	SetTextColour(255,255,255,255)
	SetTextOutline()
	SetTextCentre(1)
	SetTextEntry("STRING")
	AddTextComponentString(text)

	if res_x >= 2000 then
		DrawText(x+0.076,y)
	else
		DrawText(x,y)
	end
end

function CriandoBlip(selecionado, bancada)
	if bancada == "ILHA" then
		blips = AddBlipForCoord(cfg.ilhaRoutes[parseInt(selecionado)].coords[1],cfg.ilhaRoutes[parseInt(selecionado)].coords[2],cfg.ilhaRoutes[parseInt(selecionado)].coords[3])
		SetBlipSprite(blips,1)
		SetBlipColour(blips,5)
		SetBlipScale(blips,0.4)
		SetBlipAsShortRange(blips,false)
		SetBlipRoute(blips,true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString("Coleta")
		EndTextCommandSetBlipName(blips)
	elseif bancada == "BENNYS" then
		blips = AddBlipForCoord(cfg.bennysRoutes[parseInt(selecionado)].coords[1],cfg.bennysRoutes[parseInt(selecionado)].coords[2],cfg.bennysRoutes[parseInt(selecionado)].coords[3])
		SetBlipSprite(blips,1)
		SetBlipColour(blips,5)
		SetBlipScale(blips,0.4)
		SetBlipAsShortRange(blips,false)
		SetBlipRoute(blips,true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString("Coleta")
		EndTextCommandSetBlipName(blips)
	else
		blips = AddBlipForCoord(cfg.allRoutes[parseInt(itemNumRoute)].coords[1],cfg.allRoutes[parseInt(itemNumRoute)].coords[2],cfg.allRoutes[parseInt(itemNumRoute)].coords[3])

		SetBlipSprite(blips,1)
		SetBlipColour(blips,5)
		SetBlipScale(blips,0.4)
		SetBlipAsShortRange(blips,false)
		SetBlipRoute(blips,true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString("Coleta")
		EndTextCommandSetBlipName(blips)
	end
end

Citizen.CreateThread(function()
	while true do
		local time = 1000
		if segundos >= 0 then
			segundos = segundos - 1

			if segundos <= 0 then
				segundos = 0
			end
		end
		Citizen.Wait(time)
	end
end)