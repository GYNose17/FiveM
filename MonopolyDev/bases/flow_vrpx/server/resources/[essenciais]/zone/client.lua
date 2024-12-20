------------------------------------
------------------------------------
------------------------------------
-- SAFEZONE NORMAL
------------------------------------
------------------------------------
------------------------------------

local zones = {
	{ ['x'] = 168.40252685547, ['y'] = -996.16967773438, ['z'] = 29.35410118103, range = 150.0}, -- 168.40252685547,-996.16967773438,29.35410118103,
	{ ['x'] = -40.35, ['y'] = -1096.67, ['z'] = 26.43, range = 20.0},
	{ ['x'] = -1609.85, ['y'] = -1005.44, ['z'] = 13.01, range = 100.0},
	{ ['x'] = 1678.6, ['y'] = 2513.39, ['z'] = 45.57, range = 240.0},
	{ ['x'] = -445.61, ['y'] = -315.64, ['z'] = 34.92, range = 120.0},
	{ ['x'] = 1163.83, ['y'] = -1524.21, ['z'] = 36.48, range = 100.0},
	{ ['x'] = 1825.09, ['y'] = 3794.26, ['z'] = 33.33, range = 200.0},
	-- { ['x'] = -147.23, ['y'] = 6294.95, ['z'] = 31.24, range = 20.0},
	{ ['x'] = 565.79,['y'] = -1756.23, ['z'] = 29.17, range = 20.0},
	{ ['x'] = 2733.04, ['y'] = 3481.82, ['z'] = 55.0, range = 100.0},
	{ ['x'] = 55.24, ['y'] = -867.57, ['z'] = 30.55, range = 100.0},

}

local notifIn = false
local notifOut = false
local closestZone = 1


Citizen.CreateThread(function()
	while not NetworkIsPlayerActive(PlayerId()) do
		Citizen.Wait(0)
	end
	
	while true do
		local playerPed = GetPlayerPed(-1)
		local x, y, z = table.unpack(GetEntityCoords(playerPed, true))
		local minDistance = 100000
		for i = 1, #zones, 1 do
			dist = Vdist(zones[i].x, zones[i].y, zones[i].z, x, y, z)
			if dist < minDistance then
				minDistance = dist
				closestZone = i
			end
		end
		Citizen.Wait(15000)
	end
end)

Citizen.CreateThread(function()
	while not NetworkIsPlayerActive(PlayerId()) do
		Citizen.Wait(0)
	end
	
	while true do
		Citizen.Wait(0)
		local player = GetPlayerPed(-1)
		local x,y,z = table.unpack(GetEntityCoords(player, true))
		local dist = Vdist(zones[closestZone].x, zones[closestZone].y, zones[closestZone].z, x, y, z)

		if dist <= zones[closestZone].range then  -- Aqui você pode alterar o RAIO da Zona de Segurança. Lembre-se, tudo o que você colocar aqui DOBRARÁ porque 
			if not notifIn then	-- é uma esfera. Portanto, 50 resultará em um diâmetro de 100. Presumo que sejam metros. Nenhuma pista para ser honesto.																		  
				NetworkSetFriendlyFireOption(false)
				ClearPlayerWantedLevel(PlayerId())
				SetCurrentPedWeapon(player,GetHashKey("WEAPON_UNARMED"),true)
				exports["flow_inventory"]:setinsafe(true)
				-- exports["vrp_carry"]:setcarregar2(true)
				TriggerEvent("pNotify:SendNotification",{
					text = "<b style='color:#1E90FF'>Você está em uma SafeZone</b>",
					type = "success",
					timeout = (3000),
					layout = "bottomcenter",
					queue = "global"
				})
				notifIn = true
				notifOut = false
			end
		else
			if not notifOut then
				exports["flow_inventory"]:setinsafe(false)
				-- exports["vrp_carry"]:setcarregar2(false)
				NetworkSetFriendlyFireOption(true)
				TriggerEvent("pNotify:SendNotification",{
					text = "<b style='color:#1E90FF'>Você NÃO ESTÁ MAIS numa SafeZone</b>",
					type = "error",
					timeout = (3000),
					layout = "bottomcenter",
					queue = "global"
				})
				notifOut = true
				notifIn = false
			end
		end

		if notifIn then
		DisableControlAction(2, 37, true) -- desabilitar roda de arma (Tab)
		DisablePlayerFiring(player,true) -- Desativa o disparo todos juntos se, de alguma forma, ignorarem inzone Mouse Disable
      	DisableControlAction(0, 106, true) -- Desative os controles do mouse no jogo
			if IsDisabledControlJustPressed(2, 37) then --se Tab for pressionado, enviar mensagem de erro
				SetCurrentPedWeapon(player,GetHashKey("WEAPON_UNARMED"),true) -- se a guia for pressionada, eles serão desarmados (isso é para cobrir a falha do veículo até que eu resolva tudo)
				exports["flow_inventory"]:setinsafe(true)
				-- exports["vrp_carry"]:setcarregar2(true)
				TriggerEvent("pNotify:SendNotification",{
					text = "<b style='color:#1E90FF'>Você não pode usar armas em uma zona segura</b>",
					type = "error",
					timeout = (3000),
					layout = "bottomcenter",
					queue = "global"
				})
			end
			if IsDisabledControlJustPressed(0, 106) then --se o botão esquerdo for pressionado, enviar mensagem de erro
				SetCurrentPedWeapon(player,GetHashKey("WEAPON_UNARMED"),true) -- Se eles clicarem, serão desarmados
				exports["flow_inventory"]:setinsafe(true)
				-- exports["vrp_carry"]:setcarregar2(true)
				TriggerEvent("pNotify:SendNotification",{
					text = "<b style='color:#1E90FF'>Você não pode fazer isso em uma zona segura</b>",
					type = "error",
					timeout = (3000),
					layout = "bottomcenter",
					queue = "global"
				})
			end
			
		end
		-- Comente as linhas 142 - 145 se você não quiser um marcador.
	 	--if DoesEntityExist(player) then	      --The -1.0001 will place it on the ground flush		-- SIZING CIRCLE |  x    y    z | R   G    B   alpha| *more alpha more transparent*
	 	--	DrawMarker(1, zones[closestZone].x, zones[closestZone].y, zones[closestZone].z-1.0001, 0, 0, 0, 0, 0, 0, 100.0, 100.0, 2.0, 13, 232, 255, 155, 0, 0, 2, 0, 0, 0, 0) -- heres what all these numbers are. Honestly you dont really need to mess with any other than what isnt 0.
	 		--DrawMarker(type, float posX, float posY, float posZ, float dirX, float dirY, float dirZ, float rotX, float rotY, float rotZ, float scaleX, float scaleY, float scaleZ, int red, int green, int blue, int alpha, BOOL bobUpAndDown, BOOL faceCamera, int p19(LEAVE AS 2), BOOL rotate, char* textureDict, char* textureName, BOOL drawOnEnts)
	 	--end
	end
end)


------------------------------------
------------------------------------
------------------------------------
-- INTERNET
------------------------------------
------------------------------------
------------------------------------


local internet = true -- Váriavel que vai gerenciar se o jogador tem internet ou não.
local keys = {22,37,45,80,140,250,263,310,140,141,257,142,143,24,25,58} -- Teclas que vão ser desabilitadas quando a internet cair, verificar em https://docs.fivem.net/docs/game-references/controls/

function block()
    Citizen.CreateThread( function()
        while not internet do
            TriggerEvent('vrp_inventory:closeup')
            local ped = PlayerPedId()
            for k,v in pairs(keys) do 
                DisableControlAction(0, v, true) -- Nativa para desabilitar as teclas
            end
                DisablePlayerFiring(ped, true) -- Desativa o tiro
            Citizen.Wait(0)
        end
    end)
end

RegisterNUICallback("lock",function(data,cb) -- Callback quando a internet cai
    if not internet then
        return
    end
    internet = false -- Seta a váriavel de internet como false
	block() -- ativa a thread pra bloquear teclas 
    local ped = PlayerPedId()
	TriggerEvent('Notify','sucesso','Após ela voltar, irá demorar cerca de 1 minuto para você ter acesso a alguns comandos dentro da cidade por motivos de segurança!',20)
	TriggerEvent('Notify','sucesso','Sua internet perdeu a conexão com o servidor, você está impedido de fazer algumas ações!',20)
	exports["flow_inventory"]:setinvclose(true)
    FreezeEntityPosition(ped,true) --  Freeza o jogador
    cb('ok')
end)


RegisterNUICallback("unlock",function(data,cb) -- Callback quando a internet volta
    if internet then
        return
    end
	TriggerEvent('Notify','sucesso','Sua internet voltou, aguarde até que toda conexão tenha sido estabelecida para você ter acesso a 100% da cidade!',20)
	internet = true -- Seta a váriavel de internet como true
	Wait(60000)
	TriggerEvent('Notify','sucesso','Conexão 100% estabelecida!',20)
	local ped = PlayerPedId()
	FreezeEntityPosition(ped,false) -- Remove o freeze do jogador
	exports["flow_inventory"]:setinvclose(false)
	cb('ok')
end)
