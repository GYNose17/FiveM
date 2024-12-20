local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")

src = {}
Tunnel.bindInterface("vrp_roupas",src)
vSERVER = Tunnel.getInterface("vrp_roupas")

-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local cam = -1
local customCamLocation = nil
local creatingCharacter = false
local old_skin = {}
local carrinho = {}
local pagamento = 0

-----------------------------------------------------------------------------------------------------------------------------------------
-- SKINDATA
-----------------------------------------------------------------------------------------------------------------------------------------
local skinData = {
	["pants"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 },
	["arms"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 },
	["t-shirt"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 },
	["torso2"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 },
	["vest"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 },
	["bag"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 },
	["shoes"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 },
	["mask"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 },
	["hat"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 },
	["glass"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 },
	["ear"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 },
	["watch"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 },
	["bracelet"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 },
	["accessory"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 },
	["decals"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 }
}

-----------------------------------------------------------------------------------------------------------------------------------------
-- LOCATESHOPS
-----------------------------------------------------------------------------------------------------------------------------------------
local locateShops = {
	{ 425.31,-806.08,29.5, false},

}
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADSYSTEM
-----------------------------------------------------------------------------------------------------------------------------------------
-- Citizen.CreateThread(function()
-- 	while true do
-- 		local timeDistance = 1000
-- 		local ped = PlayerPedId()
-- 		if not IsPedInAnyVehicle(ped) and not creatingCharacter then
-- 			local coords = GetEntityCoords(ped)

-- 			for k,v in pairs(locateShops) do
-- 				local distance = #(coords - vector3(v[1],v[2],v[3]))
-- 				if distance <= 3 then
-- 					timeDistance = 4
-- 					DrawText3D(v[1],v[2],v[3],"Pressione ~g~E~w~ para abrir")

-- 					if IsControlJustPressed(0,38) and vSERVER.checkOpen() then
-- 						customCamLocation = nil
-- 						openMenu({ { menu = "character", label = "Roupas", selected = true }, { menu = "accessoires", label = "Utilidades", selected = false } })
-- 					end
-- 				end
-- 			end
-- 		end

-- 		Citizen.Wait(timeDistance)
-- 	end
-- end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- DRAWTEXT3D
-----------------------------------------------------------------------------------------------------------------------------------------
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

-----------------------------------------------------------------------------------------------------------------------------------------
-- ROTATERIGHT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("rotateRight",function()
	local ped = PlayerPedId()
	local heading = GetEntityHeading(ped)
	SetEntityHeading(ped,heading+30)
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- ROTATELEFT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("rotateLeft",function()
	local ped = PlayerPedId()
	local heading = GetEntityHeading(ped)
	SetEntityHeading(ped,heading-30)
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- CLOTHINGCATEGORYS
-----------------------------------------------------------------------------------------------------------------------------------------
local clothingCategorys = {
	["arms"] = { type = "variation", id = 3 },
	["t-shirt"] = { type = "variation", id = 8 },
	["torso2"] = { type = "variation", id = 11 },
	["pants"] = { type = "variation", id = 4 },
	["vest"] = { type = "variation", id = 9 },
	["shoes"] = { type = "variation", id = 6 },
	["bag"] = { type = "variation", id = 5 },
	["mask"] = { type = "mask", id = 1 },
	["hat"] = { type = "prop", id = 0 },
	["glass"] = { type = "prop", id = 1 },
	["ear"] = { type = "prop", id = 2 },
	["watch"] = { type = "prop", id = 6 },
	["bracelet"] = { type = "prop", id = 7 },
	["accessory"] = { type = "variation", id = 7 },
	["decals"] = { type = "variation", id = 10 }
}

-----------------------------------------------------------------------------------------------------------------------------------------
-- GETMAXVALUES
-----------------------------------------------------------------------------------------------------------------------------------------
function GetMaxValues()
	maxModelValues = {
		["arms"] = { type = "character", item = 0, texture = 0 },
		["t-shirt"] = { type = "character", item = 0, texture = 0 },
		["torso2"] = { type = "character", item = 0, texture = 0 },
		["pants"] = { type = "character", item = 0, texture = 0 },
		["shoes"] = { type = "character", item = 0, texture = 0 },
		["vest"] = { type = "character", item = 0, texture = 0 },
		["accessory"] = { type = "character", item = 0, texture = 0 },
		["decals"] = { type = "character", item = 0, texture = 0 },
		["bag"] = { type = "character", item = 0, texture = 0 },
		["mask"] = { type = "accessoires", item = 0, texture = 0 },
		["hat"] = { type = "accessoires", item = 0, texture = 0 },
		["glass"] = { type = "accessoires", item = 0, texture = 0 },
		["ear"] = { type = "accessoires", item = 0, texture = 0 },
		["watch"] = { type = "accessoires", item = 0, texture = 0 },
		["bracelet"] = { type = "accessoires", item = 0, texture = 0 }
	}

	local ped = PlayerPedId()
	for k,v in pairs(clothingCategorys) do
		if v.type == "variation" then
			maxModelValues[k].item = GetNumberOfPedDrawableVariations(ped,v.id)
			maxModelValues[k].texture = GetNumberOfPedTextureVariations(ped,v.id,GetPedDrawableVariation(ped,v.id)) -1
		end

		if v.type == "mask" then
			maxModelValues[k].item = GetNumberOfPedDrawableVariations(ped,v.id)
			maxModelValues[k].texture = GetNumberOfPedTextureVariations(ped,v.id,GetPedDrawableVariation(ped,v.id))
		end

		if v.type == "overlay" then
			maxModelValues[k].item = GetNumHeadOverlayValues(v.id)
			maxModelValues[k].texture = 45
		end

		if v.type == "prop" then
			maxModelValues[k].item = GetNumberOfPedPropDrawableVariations(ped,v.id)
			maxModelValues[k].texture = GetNumberOfPedPropTextureVariations(ped,v.id,GetPedPropIndex(ped,v.id))
		end
	end

	SendNUIMessage({ action = "updateMax", maxValues = maxModelValues })
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- OPENMENU
-----------------------------------------------------------------------------------------------------------------------------------------
function openMenu(allowedMenus)
	creatingCharacter = true
	old_skin = vRP.getCustomization()

	GetMaxValues()

	SendNUIMessage({ action = "open", menus = allowedMenus, currentClothing = skinData })

	SetNuiFocus(true,true)
	SetCursorLocation(0.9,0.25)

	enableCam()
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- ENABLECAM
-----------------------------------------------------------------------------------------------------------------------------------------
function enableCam()
	local coords = GetOffsetFromEntityInWorldCoords(PlayerPedId(),0,2.0,0)
	RenderScriptCams(false,false,0,1,0)
	DestroyCam(cam,false)

	if not DoesCamExist(cam) then
		cam = CreateCam("DEFAULT_SCRIPTED_CAMERA",true)
		SetCamActive(cam,true)
		RenderScriptCams(true,false,0,true,true)
		SetCamCoord(cam,coords.x,coords.y,coords.z+0.5)
		SetCamRot(cam,0.0,0.0,GetEntityHeading(PlayerPedId())+180)
	end

	if customCamLocation ~= nil then
		SetCamCoord(cam,customCamLocation.x,customCamLocation.y,customCamLocation.z)
	end
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- ROTATECAM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("rotateCam",function(data)
	local rotType = data.type
	local ped = PlayerPedId()
	local coords = GetOffsetFromEntityInWorldCoords(ped,0,2.0,0)

	if rotType == "left" then
		SetEntityHeading(ped,GetEntityHeading(ped)-10)
		SetCamCoord(cam,coords.x,coords.y, coords.z+0.5)
		SetCamRot(cam,0.0,0.0,GetEntityHeading(ped)+180)
	else
		SetEntityHeading(ped,GetEntityHeading(ped)+10)
		SetCamCoord(cam,coords.x,coords.y,coords.z+0.5)
		SetCamRot(cam,0.0,0.0,GetEntityHeading(ped)+180)
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- SETUPCAM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("setupCam",function(data)
	local value = data.value

	if value == 1 then
		local coords = GetOffsetFromEntityInWorldCoords(PlayerPedId(),0,0.75,0)
		SetCamCoord(cam,coords.x,coords.y,coords.z+0.65)
	elseif value == 2 then
		local coords = GetOffsetFromEntityInWorldCoords(PlayerPedId(),0,1.0,0)
		SetCamCoord(cam,coords.x,coords.y,coords.z+0.2)
	elseif value == 3 then
		local coords = GetOffsetFromEntityInWorldCoords(PlayerPedId(),0,1.0,0)
		SetCamCoord(cam,coords.x,coords.y,coords.z+-0.5)
	else
		local coords = GetOffsetFromEntityInWorldCoords(PlayerPedId(),0,2.0,0)
		SetCamCoord(cam,coords.x,coords.y,coords.z+0.5)
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- DISABLECAM
-----------------------------------------------------------------------------------------------------------------------------------------
function disableCam()
	RenderScriptCams(false,true,250,1,0)
	DestroyCam(cam,false)
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATESKIN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("updateSkin",function(data)
	ChangeVariation(data)
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATESKINONINPUT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("updateSkinOnInput",function(data)
	ChangeVariation(data)
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- CHANGEVARIATION
-----------------------------------------------------------------------------------------------------------------------------------------
function ChangeVariation(data)
	local ped = PlayerPedId()
	local clothingCategory = data.clothingType
	local type = data.type
	local item = data.articleNumber
	

	if not carrinho[clothingCategory] then
		carrinho[clothingCategory] = true
		pagamento = pagamento+50
	end

	if clothingCategory == "pants" then
		if type == "item" then
			SetPedComponentVariation(ped,4,item,0,2)
			skinData["pants"].item = item
		elseif type == "texture" then
			local curItem = GetPedDrawableVariation(ped,4)
			SetPedComponentVariation(ped,4,curItem,item,2)
			skinData["pants"].texture = item
		end
	elseif clothingCategory == "arms" then
		if type == "item" then
			SetPedComponentVariation(ped,3,item,0,2)
			skinData["arms"].item = item
		elseif type == "texture" then
			local curItem = GetPedDrawableVariation(ped,3)
			SetPedComponentVariation(ped,3,curItem,item,2)
			skinData["arms"].texture = item
		end
	elseif clothingCategory == "t-shirt" then
		if type == "item" then
			SetPedComponentVariation(ped,8,item,0,2)
			skinData["t-shirt"].item = item
		elseif type == "texture" then
			local curItem = GetPedDrawableVariation(ped,8)
			SetPedComponentVariation(ped,8,curItem,item,2)
			skinData["t-shirt"].texture = item
		end
	elseif clothingCategory == "vest" then
		if type == "item" then
			SetPedComponentVariation(ped,9,item,0,2)
			skinData["vest"].item = item
		elseif type == "texture" then
			SetPedComponentVariation(ped,9,skinData["vest"].item,item,2)
			skinData["vest"].texture = item
		end
	elseif clothingCategory == "bag" then
		if type == "item" then
			SetPedComponentVariation(ped,5,item,0,2)
			skinData["bag"].item = item
		elseif type == "texture" then
			SetPedComponentVariation(ped,5,skinData["bag"].item,item,2)
			skinData["bag"].texture = item
		end
	elseif clothingCategory == "decals" then
		if type == "item" then
			SetPedComponentVariation(ped,10,item,0,2)
			skinData["decals"].item = item
		elseif type == "texture" then
			SetPedComponentVariation(ped,10,skinData["decals"].item,item,2)
			skinData["decals"].texture = item
		end
	elseif clothingCategory == "accessory" then
		if type == "item" then
			SetPedComponentVariation(ped,7,item,0,2)
			skinData["accessory"].item = item
		elseif type == "texture" then
			SetPedComponentVariation(ped,7,skinData["accessory"].item,item,2)
			skinData["accessory"].texture = item
		end
	elseif clothingCategory == "torso2" then
		if type == "item" then
			SetPedComponentVariation(ped,11,item,0,2)
			skinData["torso2"].item = item
		elseif type == "texture" then
			local curItem = GetPedDrawableVariation(ped,11)
			SetPedComponentVariation(ped,11,curItem,item,2)
			skinData["torso2"].texture = item
		end
	elseif clothingCategory == "shoes" then
		if type == "item" then
			SetPedComponentVariation(ped,6,item,0,2)
			skinData["shoes"].item = item
		elseif type == "texture" then
			local curItem = GetPedDrawableVariation(ped,6)
			SetPedComponentVariation(ped,6,curItem,item,2)
			skinData["shoes"].texture = item
		end
	elseif clothingCategory == "mask" then
		if type == "item" then
			SetPedComponentVariation(ped,1,item,0,2)
			skinData["mask"].item = item
		elseif type == "texture" then
			local curItem = GetPedDrawableVariation(ped,1)
			SetPedComponentVariation(ped,1,curItem,item,2)
			skinData["mask"].texture = item
		end
	elseif clothingCategory == "hat" then
		if type == "item" then
			if item ~= -1 then
				SetPedPropIndex(ped,0,item,skinData["hat"].texture,2)
			else
				ClearPedProp(ped,0)
			end
			skinData["hat"].item = item
		elseif type == "texture" then
			SetPedPropIndex(ped,0,skinData["hat"].item,item,2)
			skinData["hat"].texture = item
		end
	elseif clothingCategory == "glass" then
		if type == "item" then
			if item ~= -1 then
				SetPedPropIndex(ped,1,item,skinData["glass"].texture,2)
				skinData["glass"].item = item
			else
				ClearPedProp(ped,1)
			end
		elseif type == "texture" then
			SetPedPropIndex(ped,1,skinData["glass"].item,item,2)
			skinData["glass"].texture = item
		end
	elseif clothingCategory == "ear" then
		if type == "item" then
			if item ~= -1 then
				SetPedPropIndex(ped,2,item,skinData["ear"].texture,2)
			else
				ClearPedProp(ped,2)
			end
			skinData["ear"].item = item
		elseif type == "texture" then
			SetPedPropIndex(ped,2,skinData["ear"].item,item,2)
			skinData["ear"].texture = item
		end
	elseif clothingCategory == "watch" then
		if type == "item" then
			if item ~= -1 then
				SetPedPropIndex(ped,6,item,skinData["watch"].texture,2)
			else
				ClearPedProp(ped,6)
			end
			skinData["watch"].item = item
		elseif type == "texture" then
			SetPedPropIndex(ped,6,skinData["watch"].item,item,2)
			skinData["watch"].texture = item
		end
	elseif clothingCategory == "bracelet" then
		if type == "item" then
			if item ~= -1 then
				SetPedPropIndex(ped,7,item,skinData["bracelet"].texture,2)
			else
				ClearPedProp(ped,7)
			end
			skinData["bracelet"].item = item
		elseif type == "texture" then
			SetPedPropIndex(ped,7,skinData["bracelet"].item,item,2)
			skinData["bracelet"].texture = item
		end
	end

	GetMaxValues()
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- SAVECLOTHING
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("saveClothing",function(data)
	if vSERVER.payment(tonumber(pagamento)) then
		pagamento = 0
		old_skin = {}
	else
		vRP.setCustomization(old_skin)
	end
end)

RegisterNUICallback("resetOutfit",function()
	vRP.setCustomization(old_skin)
end)

RegisterNUICallback("close",function()
	disableCam()
	SetNuiFocus(false,false)
	creatingCharacter = false
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- SISTEMA DE ITENS
-----------------------------------------------------------------------------------------------------------------------------------------
function src.updateClothes(tipo,item,textura)
	local ped = PlayerPedId()

	if textura == nil then
		textura = 0
	end
	
	if tipo == "oculos" then
		SetPedPropIndex(ped, 1, item,textura,2)
	elseif tipo == "chapeu" then
		SetPedPropIndex(ped, 0, item,textura,2)
	elseif tipo == "colete" then
		SetPedComponentVariation(ped, 9,item,textura,2)
	elseif tipo == "acessorio" then
		SetPedComponentVariation(ped, 7,item,textura,2)
	elseif tipo == "sapato" then
		SetPedComponentVariation(ped, 6,item,textura,2)
	elseif tipo == "mochila" then
		SetPedComponentVariation(ped, 5,item,textura,2)
	elseif tipo == "mascara" then
		SetPedComponentVariation(ped, 1,item,textura,2)
	elseif tipo == "jaqueta" then
		SetPedComponentVariation(ped, 11,item,textura,2)
	elseif tipo == "mao" then
		SetPedComponentVariation(ped, 3,item,textura,2)
	elseif tipo == "calca" then
		SetPedComponentVariation(ped, 4,item,textura,2)
	elseif tipo == "blusa" then
		SetPedComponentVariation(ped, 8,item,textura,2)
	elseif tipo == "mochila" then
		SetPedComponentVariation(ped, 5,item,textura,2)
	end
	
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- CRIAR BLIP
-----------------------------------------------------------------------------------------------------------------------------------------
local blips = {}

Citizen.CreateThread(function()
	SetNuiFocus(false,false)
	criarblips()
end)

function criarblips()
	for k,v in pairs(locateShops) do
		if v[4] then
			blips[k] = AddBlipForCoord(v[1],v[2],v[3])
			SetBlipSprite(blips[k], 73)
			SetBlipColour(blips[k], 13)
			SetBlipScale(blips[k], 0.5)
			SetBlipAsShortRange(blips[k], true)
			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString("Loja de Roupas")
			EndTextCommandSetBlipName(blips[k])
		end
	end
end


