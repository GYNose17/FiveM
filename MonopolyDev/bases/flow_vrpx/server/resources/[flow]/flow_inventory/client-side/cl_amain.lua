local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPserver = Tunnel.getInterface("vRP","flow_inventory")

src = {}
Tunnel.bindInterface("flow_inventory",src)
vSERVER = Tunnel.getInterface("flow_inventory")

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
local droplist = {}
local plyCooldown = GetGameTimer()
local segundos = 0
local inPaintball = false
local myInventory = false
local myChestVehicle = nil
local myOrgChest = nil
local myChestHouse = nil
local myStore = nil
local myRevistar = nil

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- MOC
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
RegisterKeyMapping("moc","Abrir a mochila","keyboard","OEM_3")
RegisterCommand("moc",function(source,args)
	if not IsPlayerFreeAiming(PlayerPedId()) and GetEntityHealth(PlayerPedId()) > 105 and not myInventory and NetworkIsSessionActive() and segundos <= 0 and not vRP.isHandcuffed() and not inPaintball and not invclose then
		if not IsScreenFadedOut() then
			segundos = 2
			myInventory = true
			SetNuiFocus(true,true)
			TransitionToBlurred(1000)
			SetCursorLocation(0.5,0.5)
			SendNUIMessage({ action = "showMenu" })
		end
	end
end)

RegisterKeyMapping("pmalas","Abrir Porta Malas","keyboard","PAGEUP")
RegisterCommand("pmalas",function(source,args)
	if not IsPlayerFreeAiming(PlayerPedId()) and GetEntityHealth(PlayerPedId()) > 105 and myChestVehicle == nil and NetworkIsSessionActive() and segundos <= 0 and not vRP.isHandcuffed() then
		local mPlaca,mName,mNet,mPortaMalas,mPrice,mLock = vRP.ModelName(5)
		if mPlaca and not mLock and vSERVER.checkVehicleOpen(mPlaca) and mPortaMalas ~= nil then
			segundos = 2
			myChestVehicle = { mPlaca,mName }
			SetNuiFocus(true, true)
			TransitionToBlurred(1000)
			SetCursorLocation(0.5,0.5)
			SendNUIMessage({ action = "showVehicles", log = "chestVehicle" })
		end
	end
end)

RegisterNetEvent('OpenPMalas', function()
	if not IsPlayerFreeAiming(PlayerPedId()) and GetEntityHealth(PlayerPedId()) > 105 and myChestVehicle == nil and NetworkIsSessionActive() and segundos <= 0 and not vRP.isHandcuffed() then
		local mPlaca,mName,mNet,mPortaMalas,mPrice,mLock = vRP.ModelName(5)
		if mPlaca and not mLock and vSERVER.checkVehicleOpen(mPlaca) and mPortaMalas ~= nil then
			segundos = 2
			myChestVehicle = { mPlaca,mName }
			SetNuiFocus(true, true)
			TransitionToBlurred(1000)
			SetCursorLocation(0.5,0.5)
			SendNUIMessage({ action = "showVehicles", log = "chestVehicle" })
		end
	end
end)

RegisterKeyMapping("ochest","Abrir bau de org","keyboard","E")
RegisterCommand("ochest",function(source,args)
	if not IsPlayerFreeAiming(PlayerPedId()) and GetEntityHealth(PlayerPedId()) > 105 and myOrgChest == nil and NetworkIsSessionActive() and segundos <= 0 and not vRP.isHandcuffed() then
		local ped = PlayerPedId()
		local coords = GetEntityCoords(ped)

		for k,v in pairs(cfg.chestOrgs) do
			local distance = #(coords - v.coords)
			
			if distance <= 2.5 then
				segundos = 2

				if k then
					if vSERVER.checkOrgOpen(v.perm, v.org) then
						myOrgChest = { k,v.org,v.maxbau }
						SetNuiFocus(true, true)
						TransitionToBlurred(1000)
						SetCursorLocation(0.5,0.5)
						SendNUIMessage({ action = "showOrgChest", log = "chestOrg" })
					end
				end
			end
		end

	end
end)

RegisterKeyMapping("ostore","Abrir loja de vendas","keyboard","E")
RegisterCommand("ostore",function(source,args)
	if not IsPlayerFreeAiming(PlayerPedId()) and GetEntityHealth(PlayerPedId()) > 105 and myStore == nil and NetworkIsSessionActive() and segundos <= 0 and not vRP.isHandcuffed() then
		
		local ped = PlayerPedId()
		local coords = GetEntityCoords(ped)

		for k,v in pairs(cfg.storesLocs) do
			local distance = #(coords - v.coords)

			if distance <= 1.5 then
				segundos = 2

				if v.perm == nil or vSERVER.checkPermission(v.perm) then
					
					myStore = { v.type }
					SetNuiFocus(true, true)
					TransitionToBlurred(1000)
					SetCursorLocation(0.5,0.5)
					SendNUIMessage({ action = "showStore" })
				end
			end
		end
			
	end
end)
 
RegisterCommand("revistar",function(source,args)
	if not IsPlayerFreeAiming(PlayerPedId()) and GetEntityHealth(PlayerPedId()) > 105 and myRevistar == nil and NetworkIsSessionActive() and segundos <= 0 and not vRP.isHandcuffed() and not IsPedInAnyVehicle(PlayerPedId()) then
		if not insafezone then
			segundos = 2
			local revistar = vSERVER.checkOpenRevistar()
			if revistar then
				vSERVER._setRevistar(revistar, true)
				myRevistar = { revistar }
				SetNuiFocus(true, true)
				TransitionToBlurred(1000)
				SetCursorLocation(0.5,0.5)
				SendNUIMessage({ action = "showRevistar" })
			end
		else
			TriggerEvent('Notify','negado','Você não pode revistar em zona safe!')
		end
	end
end)

RegisterNetEvent('inspectEvent', function()
	if not IsPlayerFreeAiming(PlayerPedId()) and GetEntityHealth(PlayerPedId()) > 105 and myRevistar == nil and NetworkIsSessionActive() and segundos <= 0 and not vRP.isHandcuffed() and not IsPedInAnyVehicle(PlayerPedId()) then
		if not insafezone then
			segundos = 2
			local revistar = vSERVER.checkOpenRevistar()
			if revistar then
				vSERVER._setRevistar(revistar, true)
				myRevistar = { revistar }
				SetNuiFocus(true, true)
				TransitionToBlurred(1000)
				SetCursorLocation(0.5,0.5)
				SendNUIMessage({ action = "showRevistar" })
			end
		else
			TriggerEvent('Notify','negado','Você não pode revistar em zona safe!')
		end
	end
end)


RegisterCommand("invsee",function(source,args)
	if not IsPlayerFreeAiming(PlayerPedId()) and GetEntityHealth(PlayerPedId()) > 105 and myRevistar == nil and NetworkIsSessionActive() and segundos <= 0 and not vRP.isHandcuffed() and not IsPedInAnyVehicle(PlayerPedId()) then
		segundos = 2
		local revistar = vSERVER.checkOpenRevistar(true, args[1])
		if revistar then
			vSERVER._setRevistar(revistar, true)
			myRevistar = { revistar }
			SetNuiFocus(true, true)
			TransitionToBlurred(1000)
			SetCursorLocation(0.5,0.5)
			SendNUIMessage({ action = "showRevistar" })
		end
	end
end)

RegisterNetEvent('openAdminChest', function(id, org, bau)
	myOrgChest = { id, org, bau }
	SetNuiFocus(true, true)
	TransitionToBlurred(1000)
	SetCursorLocation(0.5,0.5)
	SendNUIMessage({ action = "showOrgChest", log = "chestOrg" })
end)

RegisterNetEvent('openCarChest', function(plate, car)
	if vSERVER.checkVehicleOpen(plate) then
		myChestVehicle = { plate,car }
		SetNuiFocus(true, true)
		TransitionToBlurred(1000)
		SetCursorLocation(0.5,0.5)
		SendNUIMessage({ action = "showVehicles", log = "chestVehicle" })
	end
end)

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- HOTKEYS
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
local useDelay = false

RegisterKeyMapping("useslot 1", "Hotkey 1", "keyboard", "1")
RegisterKeyMapping("useslot 2", "Hotkey 2", "keyboard", "2")
RegisterKeyMapping("useslot 3", "Hotkey 3", "keyboard", "3")
RegisterKeyMapping("useslot 4", "Hotkey 4", "keyboard", "4")
RegisterKeyMapping("useslot 5", "Hotkey 5", "keyboard", "5")
RegisterKeyMapping("useslot 6", "Hotkey 6", "keyboard", "6")

RegisterCommand('useslot', function(source,args)
	local value = parseInt(args[1])
	if value > 0 and value <= 6 then
		if not useDelay then
			useDelay = true

			vSERVER._useItem(value, 1)
			
			SetTimeout(5 * 1000, function() useDelay = false end)
		end
	end
end)

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- NUIS CALLBACKS INVENTARIO PERSONAL
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("requestMochila",function(data,cb)
	if NetworkIsSessionActive() then
		local ped = PlayerPedId()
		local coords = GetEntityCoords(ped)
		local dropItems = {}

		for k,v in pairs(droplist) do
			local bowz,cdz = GetGroundZFor_3dCoord(v["x"],v["y"],v["z"])
			local dist = #(coords - vector3(v["x"],v["y"],cdz))
			if dist <= 1.5 then
				table.insert(dropItems,{ name = v["name"], key = v.key, amount = v["count"], index = v["index"], peso = v["peso"], desc = v["desc"], png = v["png"], id = k })
			end
		end
		
		local inventario,peso,maxpeso,infos,amountMoc = vSERVER.Mochila()
		if inventario then
			cb({ inventario = inventario, drop = dropItems, peso = peso, maxpeso = maxpeso, infos = infos, amountMoc = amountMoc })
		end
	end
end)

RegisterNUICallback("updateSlot",function(data,cb)
	if NetworkIsSessionActive() then
		-- if not inservicedrogas then
			TriggerEvent("vrp_sound:source",'slot',0.1)
			vSERVER._updateSlot(data.item, data.slot, data.target, data.targetname, data.targetamount, parseInt(data.amount))
		-- else
		-- 	TriggerEvent("Notify","negado","Você não pode fazer isto em rota de drogas!")
		-- end
	end
end)

RegisterNetEvent("vrp_inventory:closeup") -- no-wifi
AddEventHandler("vrp_inventory:closeup",function(value)
		SetNuiFocus(false,false)
		TransitionFromBlurred(1000)
		SendNUIMessage({ action = "hideMenu" })
	
		if myInventory then
			myInventory = false
		end
	
		if myChestVehicle ~= nil then
			vSERVER._setVehicleClose(myChestVehicle[1],myChestVehicle[2])
			myChestVehicle = nil
		end
	
		if myOrgChest ~= nil then
			vSERVER._setOrgClose(myOrgChest[2])
			myOrgChest = nil
		end
	
		if myChestHouse ~= nil then
			vSERVER._setHouseClose(myChestHouse[1])
			myChestHouse = nil
		end
	
		if myRevistar ~= nil then
			vSERVER._setRevistar(myRevistar[1], false)
			myRevistar = nil
		end
	
		if myStore ~= nil then
			myStore = nil
		end
end)

RegisterNUICallback("invClose",function(data,cb)
	src.closeInventory()
end)

RegisterNUICallback("useItem",function(data)
	if NetworkIsSessionActive() then
		local amount = data.amount
		vSERVER._useItem(data.slot, amount)
	end
end)

RegisterNUICallback("sendItem",function(data)
	if NetworkIsSessionActive() then
		vSERVER._sendItem(data.item,data.slot,data.amount)
	end
end)

RegisterNUICallback("dropItem",function(data)
	if NetworkIsSessionActive() then
		-- not inservicedrogas then
			if not IsScreenFadedOut() then
				local amount = data.amount
				
				if amount == nil or amount <= 1 then
					amount = 1
				end

				vSERVER._droparItem(data.slot, amount)
			end
		-- else
		-- 	TriggerEvent("Notify","negado","Você não pode fazer isto em rota de drogas!")
		-- end
	end
end)

RegisterNUICallback("pickupItem",function(data)
	if NetworkIsSessionActive() then
		if not IsScreenFadedOut() then
			vSERVER._pegarItem(data.id, data.target, data.amount)
		end
	end
end)


src.SetAnim = function(amount)
	vRP.loadAnimSet("move_m@drunk@moderatedrunk")
		
	SetTimeout(60000*amount, function()
		if GetEntityModel(PlayerPedId()) == GetHashKey("mp_m_freemode_01") then
			vRP.loadAnimSet("move_m@confident")
		elseif GetEntityModel(PlayerPedId()) == GetHashKey("mp_f_freemode_01") then
			vRP.loadAnimSet("move_f@heels@c")
		end
	end)
end
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- NUIS CALLBACKS INVENTARIO VEICULO
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("requestVehicle",function(data,cb)
	if NetworkIsSessionActive() then
		if myChestVehicle ~= nil then
			local inventario,inventario2,peso,maxpeso,peso2,maxpeso2,infos,infosVehicle,amountMoc = vSERVER.openVehicles(myChestVehicle[1],myChestVehicle[2])
			if inventario and inventario2 then
				cb({ inventario = inventario, inventario2 = inventario2, peso = peso, maxpeso = maxpeso, peso2 = peso2, maxpeso2 = maxpeso2, infos = infos, infosVehicle = infosVehicle, amountMoc = amountMoc })
			end
		end
	end
end)

RegisterNUICallback("updateVehicleSlots",function(data,cb)
--[[ 	if NetworkIsSessionActive() then
		TriggerEvent("vrp_sound:source",'slot',0.1)
		vSERVER.updateVehicleSlots(data.item, data.slot, data.target, data.targetname, data.targetamount, parseInt(data.amount), myChestVehicle[1],myChestVehicle[2])
	end ]]
end)

RegisterNUICallback("takeVehicle",function(data,cb)
	if NetworkIsSessionActive() then
		if (plyCooldown - GetGameTimer()) > 0 then return end
		plyCooldown = (GetGameTimer() + 1000)

		vSERVER._retirarVehicle(data.item, data.amount, data.slot, data.target, myChestVehicle[1],myChestVehicle[2])
	end
end)

RegisterNUICallback("storeVehicle",function(data,cb)
	if NetworkIsSessionActive() then
		if (plyCooldown - GetGameTimer()) > 0 then return end
		plyCooldown = (GetGameTimer() + 1000)

		vSERVER._colocarVehicle(data.item,data.amount,data.slot, myChestVehicle[1],myChestVehicle[2])
	end
end)

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- NUIS CALLBACKS INVENTARIO FACTION
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("requestOrgChest",function(data,cb)
	if NetworkIsSessionActive() then
		if myOrgChest ~= nil then
			local inventario,inventario2,peso,maxpeso,peso2,maxpeso2,infos,infosOrg,amountMoc = vSERVER.openOrgChest(myOrgChest[1],myOrgChest[2],myOrgChest[3])
			if inventario and inventario2 then
				cb({ inventario = inventario, inventario2 = inventario2, peso = peso, maxpeso = maxpeso, peso2 = peso2, maxpeso2 = maxpeso2, infos = infos, infosOrg = infosOrg, amountMoc = amountMoc })
			end
		end
	end
end)

RegisterNUICallback("updateOrgSlots",function(data,cb)
--[[ 	if NetworkIsSessionActive() then
		TriggerEvent("vrp_sound:source",'slot',0.1)
		vSERVER.updateOrgSlots(data.item, data.slot, data.target, data.targetname, data.targetamount, parseInt(data.amount), myOrgChest[2])
	end ]]
end)

RegisterNUICallback("takeOrgChest",function(data,cb)
	if NetworkIsSessionActive() then
		if (plyCooldown - GetGameTimer()) > 0 then return end
		plyCooldown = (GetGameTimer() + 1000)

		vSERVER._retirarOrgChest(data.item, data.amount, data.slot, data.target, myOrgChest[2], myOrgChest[1])
	end
end)

RegisterNUICallback("storeOrgChest",function(data,cb)
	if NetworkIsSessionActive() then
		if (plyCooldown - GetGameTimer()) > 0 then return end
		plyCooldown = (GetGameTimer() + 1000)

		vSERVER._colocarOrgChest(data.item,data.amount,data.slot, myOrgChest[2], myOrgChest[3], myOrgChest[1])
	end
end)

Citizen.CreateThread(function()
    while true do
        local time = 1000
        local ped = PlayerPedId()
		local coords = GetEntityCoords(ped)
	
		for k,v in pairs(cfg.chestOrgs) do
			local distance = #(coords - v.coords)
			if distance <= 2.5 then
				time = 5
				DrawText3D(v.coords[1],v.coords[2],v.coords[3],"Pressione ~g~E~w~ para abrir")
			end
		end

        Citizen.Wait(time)
    end
end)

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- NUIS CALLBACKS INVENTARIO HOUSE
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("fl0w:myHouseChest", function(id, houseID, maxBau)
	if not IsPlayerFreeAiming(PlayerPedId()) and GetEntityHealth(PlayerPedId()) > 105 and NetworkIsSessionActive() and segundos <= 0 and not vRP.isHandcuffed() and myChestHouse == nil then
		if vSERVER.checkHouseChest(id) then
			myChestHouse = { id,houseID,maxBau }
			SetNuiFocus(true, true)
			TransitionToBlurred(1000)
			SetCursorLocation(0.5,0.5)
			SendNUIMessage({ action = "showChestHouse" })
		end
	end
end)

RegisterNUICallback("requestHouseChest",function(data,cb)
	if NetworkIsSessionActive() then
		if myChestHouse ~= nil then
			local inventario,inventario2,peso,maxpeso,peso2,maxpeso2,infos,infosOrg,amountMoc = vSERVER.openHouseChest(myChestHouse[1],myChestHouse[2],myChestHouse[3])
			if inventario and inventario2 then
				cb({ inventario = inventario, inventario2 = inventario2, peso = peso, maxpeso = maxpeso, peso2 = peso2, maxpeso2 = maxpeso2, infos = infos, infosOrg = infosOrg, amountMoc = amountMoc })
			end
		end
	end
end)

RegisterNUICallback("updateChestSlots",function(data,cb)
--[[ 	if NetworkIsSessionActive() then
		TriggerEvent("vrp_sound:source",'slot',0.1)
		vSERVER.updateHouseSlots(data.item, data.slot, data.target, data.targetname, data.targetamount,  parseInt(data.amount), myChestHouse[1])
	end ]]
end)

RegisterNUICallback("takeHouseChest",function(data,cb)
	if NetworkIsSessionActive() then
		if (plyCooldown - GetGameTimer()) > 0 then return end
		plyCooldown = (GetGameTimer() + 1000)

		vSERVER._retirarHouseChest(data.item, data.amount, data.slot, data.target, myChestHouse[1])
	end
end)

RegisterNUICallback("storeHouseChest",function(data,cb)
	if NetworkIsSessionActive() then
		if (plyCooldown - GetGameTimer()) > 0 then return end
		plyCooldown = (GetGameTimer() + 1000)

		vSERVER._colocarHousehest(data.item,data.amount,data.slot, myChestHouse[1])
	end
end)

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- NUIS CALLBACKS INVENTARIO REVISTAR
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("requestRevistar",function(data,cb)
	if NetworkIsSessionActive() then
		if myRevistar ~= nil then
			local inventario,inventario2,peso,maxpeso,peso2,maxpeso2,infos,infoNPlayer,amountMoc = vSERVER.openRevistar(myRevistar[1])
			if inventario and inventario2 then
				cb({ inventario = inventario, inventario2 = inventario2, peso = peso, maxpeso = maxpeso, peso2 = peso2, maxpeso2 = maxpeso2, infos = infos, infoNPlayer = infoNPlayer, amountMoc = amountMoc })
			end
		end
	end
end)

RegisterNUICallback("colocarItemRevistar",function(data,cb)
	if NetworkIsSessionActive() then
		if (plyCooldown - GetGameTimer()) > 0 then return end
		plyCooldown = (GetGameTimer() + 1000)

		vSERVER._addItemRevistar(myRevistar[1], data.item, data.slot, data.amount)
	end
end)

RegisterNUICallback("retirarItemRevistar",function(data,cb)
	if NetworkIsSessionActive() then
		if (plyCooldown - GetGameTimer()) > 0 then return end
		plyCooldown = (GetGameTimer() + 1000)

		vSERVER._retirarItemRevistar(myRevistar[1], data.item, data.target, data.amount, data.slot)
	end
end)

function src.checkAnim()
    if IsEntityPlayingAnim(GetPlayerPed(-1),"random@arrests@busted","idle_a",3) then
        return true
    end
end

function src.checkPositions(player,nplayer)
	local distance = #(player - nplayer)
	if distance >= 3.5 then
		return true
	end
end
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- NUIS CALLBACKS STORE
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("requestStore",function(data,cb)
	if NetworkIsSessionActive() then
		if myStore ~= nil then
			local inventario,inventario2,peso,maxpeso,peso2,maxpeso2,infos,infosOrg,amountMoc = vSERVER.openStore(myStore[1])
			if inventario and inventario2 then
				cb({ inventario = inventario, inventario2 = inventario2, peso = peso, maxpeso = maxpeso, peso2 = peso2, maxpeso2 = maxpeso2, infos = infos, infosOrg = infosOrg, amountMoc = amountMoc })
			end
		end
	end
end)

RegisterNUICallback("buyStore",function(data,cb)
	if NetworkIsSessionActive() then
		if (plyCooldown - GetGameTimer()) > 0 then return end
		plyCooldown = (GetGameTimer() + 1000)

		vSERVER._buyStore(myStore[1], data.item, data.target, data.amount)
	end
end)

RegisterNUICallback("sellStore",function(data,cb)
	if NetworkIsSessionActive() then
		if (plyCooldown - GetGameTimer()) > 0 then return end
		plyCooldown = (GetGameTimer() + 1000)
		
		vSERVER._sellStore(myStore[1], data.item, data.amount)
	end
end)

Citizen.CreateThread(function()
    while true do
        local time = 1000
		local ped = PlayerPedId()
		local coords = GetEntityCoords(ped)

		for k,v in pairs(cfg.storesLocs) do
			local distance = #(coords - v.coords)

			if distance <= 1.5 then
				time = 5
				DrawText3D(v.coords[1],v.coords[2],v.coords[3], "Pressione ~g~[E]~w~ para acessar.")
			end
		end

		Citizen.Wait(time)
    end
end)


local blip = {}
function criarSellBlips()
    for k,v in pairs(cfg.storesLocs) do
		if v.blip and v.blipName ~= nil then
		 	blip[k] = AddBlipForCoord(v.coords[1],v.coords[2],v.coords[3])
			SetBlipSprite(blip[k], v.blipID)
			SetBlipColour(blip[k], v.blipColor)
			SetBlipScale(blip[k], 0.5)
			SetBlipAsShortRange(blip[k], true)
			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString(v.blipName)
			EndTextCommandSetBlipName(blip[k])
		end
    end
end

Citizen.CreateThread(function()
    criarSellBlips()
end)

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- SISTEMA DE DROPAR ITENS
-----------------------------------------------------------------------------------------------------------------------------------------
function src.updateDrops(id,marker)
	droplist[id] = marker
end

function src.removeDrop(id)
	if droplist[id] ~= nil then
		droplist[id] = nil
	end
end

Citizen.CreateThread(function()
    while true do
        local time = 1000
        local ped = PlayerPedId()
		local coords = GetEntityCoords(ped)

		for k,v in pairs(droplist) do
			local bowz,cdz = GetGroundZFor_3dCoord(v.x,v.y,v.z)
			local distance = #(coords - vector3(v.x,v.y,cdz))
			if distance <= 15 then
				time = 5
				DrawMarker(28,v.x,v.y,cdz+0.1,0,0,0,180.0,0,0,0.05,0.05,0.05,0,129,254,100,0,0,0,0)
			end
		end

        Citizen.Wait(time)
    end
end)

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- FUNCIONALIDADE DE ITENS DO INVENTARIO
-----------------------------------------------------------------------------------------------------------------------------------------
local oxygen = 0
local in_scuba = false
local attachedProp = 0
local scubaMask = 0
local scubaTank = 0

function src.setScuba(status)
    if status then
        attachProp("p_s_scuba_tank_s", 24818, -0.25, -0.25, 0.0, 180.0, 90.0, 0.0)
        attachProp("p_s_scuba_mask_s", 12844, 0.0, 0.0, 0.0, 180.0, 90.0, 0.0)
        in_scuba = true
        oxygen = 100
    else
        in_scuba = false
        DeleteEntity(scubaMask)
        DeleteEntity(scubaTank)
    end
end

function src.checkScuba()
    return in_scuba
end

function attachProp(attachModelSent,boneNumberSent,x,y,z,xR,yR,zR)
	local attachModel = GetHashKey(attachModelSent)
    local bone = GetPedBoneIndex(GetPlayerPed(-1), boneNumberSent)

	RequestModel(attachModel)
	while not HasModelLoaded(attachModel) do
		Citizen.Wait(100)
    end

    if tonumber(attachModel) == 1569945555 then
        attachedProp = CreateObject(attachModel, 1.0, 1.0, 1.0, 1, 1, 0)
        scubaTank = attachedProp
    elseif tonumber(attachModel) == 138065747 then
        attachedProp = CreateObject(attachModel, 1.0, 1.0, 1.0, 1, 1, 0)
        scubaMask = attachedProp
    end

    SetEntityCollision(attachedProp, false, 0)
    AttachEntityToEntity(attachedProp, GetPlayerPed(-1), bone, x, y, z, xR, yR, zR, 1, 1, 0, 0, 2, 1)
end

Citizen.CreateThread(function()
	while true do
		local time = 1000
        if IsPedSwimmingUnderWater(GetPlayerPed(-1)) and in_scuba then
            time = 5
            if oxygen > 50 then
                drawTxt("VOCÊ POSSUI ~g~"..oxygen.."% ~w~ DE OXIGÊNIO.",4,0.5,0.96,0.50,255,255,255,100)
                SetPedDiesInWater(GetPlayerPed(-1), false)
                SetPedMaxTimeUnderwater(GetPlayerPed(-1), 10.0)
            elseif oxygen > 30 then
                drawTxt("VOCÊ POSSUI ~b~"..oxygen.."% ~w~ DE OXIGÊNIO.",4,0.5,0.96,0.50,255,255,255,100)
                SetPedDiesInWater(GetPlayerPed(-1), false)
                SetPedMaxTimeUnderwater(GetPlayerPed(-1), 10.0)
            elseif oxygen > 0 then
                drawTxt("VOCÊ POSSUI ~r~"..oxygen.."% ~w~ DE OXIGÊNIO.",4,0.5,0.96,0.50,255,255,255,100)
                SetPedDiesInWater(GetPlayerPed(-1), false)
                SetPedMaxTimeUnderwater(GetPlayerPed(-1), 10.0)
            elseif oxygen <= 0 then
                drawTxt("~r~VOCÊ NÃO POSSUI MAIS OXIGÊNIO.",4,0.5,0.96,0.50,255,255,255,100)
                SetPedDiesInWater(GetPlayerPed(-1), true)
                SetPedMaxTimeUnderwater(GetPlayerPed(-1), 0.0)
                oxygen = 0
            end
        elseif IsPedSwimmingUnderWater(GetPlayerPed(-1)) and not in_scuba then
            SetPedMaxTimeUnderwater(GetPlayerPed(-1), 10.0)
            SetPedDiesInWater(GetPlayerPed(-1), true)
        end
        Citizen.Wait(time)
    end
end)

Citizen.CreateThread(function()
	while true do
		local time = 5000
        if IsPedSwimmingUnderWater(GetPlayerPed(-1)) and in_scuba then
            oxygen = oxygen - 1
        end
        Citizen.Wait(time)
    end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- SISTEMA DE ENERGETICO
-----------------------------------------------------------------------------------------------------------------------------------------
local energetico = false

function src.setEnergetico(status)
	if status then
		SetRunSprintMultiplierForPlayer(PlayerId(),1.15)
		energetico = true
	else
		SetRunSprintMultiplierForPlayer(PlayerId(),1.0)
		RestorePlayerStamina(PlayerId(),1.0)
		energetico = false
	end
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- SISTEMA DE USAR BANDAGEM
-----------------------------------------------------------------------------------------------------------------------------------------
local bandagem = false
local tempoBandagem = 0
local oldHealth = 0

function src.useBandagem()
	bandagem = true
	tempoBandagem = 60
	oldHealth = GetEntityHealth(PlayerPedId())
end

Citizen.CreateThread(function()
	while true do
		local time = 1000
		if bandagem then
			if GetEntityHealth(PlayerPedId()) > 250 then
				tempoBandagem = 0
				bandagem = false
				TriggerEvent("Notify","negado","<b>[BANDAGEM]</b> Vida cheia.", 5)
			end

			tempoBandagem = tempoBandagem - 1
			
			if tempoBandagem <= 0 then
				tempoBandagem = 0
				bandagem = false
				TriggerEvent("Notify","negado","<b>[BANDAGEM]</b> acabou a bandagem..", 5)
			end

			if oldHealth > GetEntityHealth(PlayerPedId()) and bandagem then
				tempoBandagem = 0
				bandagem = false
				TriggerEvent("Notify","negado","<b>[BANDAGEM]</b> Você sofreu algum dano.", 5)
			end

			if GetEntityHealth(PlayerPedId()) <= 105 and bandagem then
				tempoBandagem = 0
				bandagem = false
				TriggerEvent("Notify","negado","<b>[BANDAGEM]</b> Você morreu.", 5)
			end

			if GetEntityHealth(PlayerPedId()) > 105 and bandagem and GetEntityHealth(PlayerPedId()) < 250 then
				SetEntityHealth(PlayerPedId(), GetEntityHealth(PlayerPedId()) + 2)
			end
			
			if GetEntityHealth(PlayerPedId()) >= 250 and bandagem then
				tempoBandagem = 0
				bandagem = false
				SetEntityHealth(PlayerPedId(), 250)
				TriggerEvent("Notify","negado","<b>[BANDAGEM]</b> Vida cheia.", 5)
			end
		end
		Citizen.Wait(time)
	end
end)

Citizen.CreateThread(function()
	while true do
		local time = 5000
		if bandagem then
			oldHealth = GetEntityHealth(PlayerPedId())
		end

		Citizen.Wait(time)
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- SISTEMA DE ENCHER A GARRAFA
-----------------------------------------------------------------------------------------------------------------------------------------
function src.checkFountain()
	local ped = PlayerPedId()
	local coords = GetEntityCoords(ped)

	if DoesObjectOfTypeExistAtCoords(coords,0.7,GetHashKey("prop_watercooler"),true) or DoesObjectOfTypeExistAtCoords(coords,0.7,GetHashKey("prop_watercooler_dark"),true) then
		return true,"fountain"
	end

	if IsEntityInWater(ped) then
		return true,"floor"
	end

	return false
end

function src.startAnimHotwired()
	while not HasAnimDictLoaded("anim@amb@clubhouse@tutorial@bkr_tut_ig3@") do
		RequestAnimDict("anim@amb@clubhouse@tutorial@bkr_tut_ig3@")
		Citizen.Wait(10)
	end
	TaskPlayAnim(PlayerPedId(),"anim@amb@clubhouse@tutorial@bkr_tut_ig3@","machinic_loop_mechandplayer",3.0,3.0,-1,49,5.0,0,0,0)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- Atualizar Armas
-----------------------------------------------------------------------------------------------------------------------------------------
local in_arena = false

function src.updateWeapons()
	if not in_arena then
 		vRPserver.updateWeapons(vRP.getWeapons())
	end
end

RegisterNetEvent("flow_survival:updateArena")
AddEventHandler("flow_survival:updateArena", function(boolean)
    in_arena = boolean
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- REPARAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent('reparar')
AddEventHandler('reparar',function(vehicle)
	TriggerServerEvent("tryreparar",VehToNet(vehicle))
end)

RegisterNetEvent('syncreparar')
AddEventHandler('syncreparar',function(index)
	if NetworkDoesNetworkIdExist(index) then
		local v = NetToVeh(index)
		local fuel = GetVehicleFuelLevel(v)
		if DoesEntityExist(v) then
			if IsEntityAVehicle(v) then
				SetVehicleFixed(v)
				SetVehicleDirtLevel(v,0.0)
				SetVehicleUndriveable(v,false)
				SetEntityAsMissionEntity(v,true,true)
				SetVehicleOnGroundProperly(v)
				SetVehicleFuelLevel(v,fuel)
			end
		end
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- REPARAR PNEUS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent('repararpneus')
AddEventHandler('repararpneus',function(vehicle)
	if IsEntityAVehicle(vehicle) then
		TriggerServerEvent("tryrepararpneus",VehToNet(vehicle))
	end
end)

RegisterNetEvent('syncrepararpneus')
AddEventHandler('syncrepararpneus',function(index)
	if NetworkDoesNetworkIdExist(index) then
        local v = NetToEnt(index)
        if DoesEntityExist(v) then
            for i = 0,8 do
                SetVehicleTyreFixed(v,i)
            end
        end
    end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNCTIONS
-----------------------------------------------------------------------------------------------------------------------------------------
function src.updateInventory(action)
	SendNUIMessage({ action = action })
end

function src.closeInventory()
	SetNuiFocus(false,false)
	TransitionFromBlurred(1000)
	SendNUIMessage({ action = "hideMenu" })

	if myInventory then
		myInventory = false
	end

	if myChestVehicle ~= nil then
		vSERVER._setVehicleClose(myChestVehicle[1],myChestVehicle[2])
		myChestVehicle = nil
	end

	if myOrgChest ~= nil then
		vSERVER._setOrgClose(myOrgChest[2])
		myOrgChest = nil
	end

	if myChestHouse ~= nil then
		vSERVER._setHouseClose(myChestHouse[1])
		myChestHouse = nil
	end

	if myRevistar ~= nil then
		vSERVER._setRevistar(myRevistar[1], false)
		myRevistar = nil
	end

	if myStore ~= nil then
		myStore = nil
	end
end

function src.trunkchestAnim(vehID, status)
	if NetworkDoesNetworkIdExist(vehID) then
		local v = NetToVeh(vehID)
		
		local isopen = GetVehicleDoorAngleRatio(v,5)
		if DoesEntityExist(v) then
			if IsEntityAVehicle(v) then
				if isopen == 0 then
					SetVehicleDoorOpen(v,5,0,0)
				else
					SetVehicleDoorShut(v,5,0)
				end
			end
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DRUGS ANIM
-----------------------------------------------------------------------------------------------------------------------------------------
local inUseDrug = false
local countdownDrug = 0
RegisterNetEvent('inventory:useDrugs', function(drug)
	local ped = PlayerPedId()
	if not inUseDrug then
		inUseDrug = true

		if drug == "cocaina" then
			if GetEntityHealth(ped) <= 170 then
				TriggerEvent("Notify","negado","Você está com a vida muito baixa não pode utilizar.", 5)
				inUseDrug = false
				return
			end

			countdownDrug = 15
			calc_health = (GetEntityHealth(ped) * 0.2)

			SetEntityHealth(ped, parseInt(GetEntityHealth(ped) - calc_health))
			SetRunSprintMultiplierForPlayer(PlayerId(),1.15)

			CreateThread(function()
				while inUseDrug do
					countdownDrug = countdownDrug - 1

					if countdownDrug <= 0 then
						inUseDrug = false
						SetRunSprintMultiplierForPlayer(PlayerId(),1.0)
						RestorePlayerStamina(PlayerId(),1.0)
						break;
					end
					Wait( 1000 )
				end
			end)

			return
		end


	end
end)

function src.isInDrug()
	return inUseDrug
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- OUTROS
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("nation_paintball:updateSurvival", function(bool)
	inPaintball = bool
end)

AddEventHandler("onResourceStop",function()
	if GetCurrentResourceName() then
        src.closeInventory()
	end
end)

Citizen.CreateThread(function()
    while true do
        if segundos > 0 then
            segundos = segundos - 1
        end

        if segundos <= 0 then
            segundos = 0
        end
		
		Citizen.Wait(1000)
    end
end)

function DrawText3D(x,y,z,text)
	local onScreen,_x,_y = World3dToScreen2d(x,y,z)
	SetTextFont(4)
	SetTextScale(0.35,0.35)
	SetTextColour(255,255,255,100)
	SetTextEntry("STRING")
	SetTextCentre(1)
	AddTextComponentString(text)
	DrawText(_x,_y)
	local factor = (string.len(text)) / 400
	DrawRect(_x,_y+0.0125,0.01+factor,0.03,0,0,0,100)
end
 
function drawTxt(text,font,x,y,scale,r,g,b,a)
	SetTextFont(font)
	SetTextScale(scale,scale)
	SetTextColour(r,g,b,a)
	SetTextOutline()
	SetTextCentre(1)
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(x,y)
end

exports("setinvclose", function(status)
	invclose = status
end)

exports("setinsafe", function(status)
	insafezone = status
end)

exports("checkdrogas", function(status)
	inservicedrogas = status
end)