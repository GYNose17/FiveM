-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
tvRP = {}
Proxy.addInterface("vRP",tvRP)
Tunnel.bindInterface("vRP",tvRP)
vRPS = Tunnel.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Blipmin = false
local Information = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLOSESTPEDS
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.ClosestPeds(Radius)
	local Selected = {}
	local Ped = PlayerPedId()
	local Radius = Radius + 0.0001
	local Coords = GetEntityCoords(Ped)
	local GamePool = GetGamePool("CPed")

	for _,Entity in pairs(GamePool) do
		local Index = NetworkGetPlayerIndexFromPed(Entity)

		if Index and IsPedAPlayer(Entity) and NetworkIsPlayerConnected(Index) then
			if #(Coords - GetEntityCoords(Entity)) <= Radius then
				Selected[#Selected + 1] = GetPlayerServerId(Index)
			end
		end
	end

	return Selected
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLOSESTPED
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.ClosestPed(Radius)
	local Selected = false
	local Ped = PlayerPedId()
	local Radius = Radius + 0.0001
	local Coords = GetEntityCoords(Ped)
	local GamePool = GetGamePool("CPed")

	for _,Entity in pairs(GamePool) do
		local Index = NetworkGetPlayerIndexFromPed(Entity)

		if Index and Entity ~= PlayerPedId() and IsPedAPlayer(Entity) and NetworkIsPlayerConnected(Index) then
			local EntityCoords = GetEntityCoords(Entity)
			local EntityDistance = #(Coords - EntityCoords)

			if EntityDistance < Radius then
				Selected = GetPlayerServerId(Index)
				Radius = EntityDistance
			end
		end
	end

	return Selected
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETPLAYERS
-----------------------------------------------------------------------------------------------------------------------------------------
function GetPlayers()
	local Selected = {}
	local GamePool = GetGamePool("CPed")

	for _,Entity in pairs(GamePool) do
		local Index = NetworkGetPlayerIndexFromPed(Entity)

		if Index and IsPedAPlayer(Entity) and NetworkIsPlayerConnected(Index) then
			Selected[Entity] = GetPlayerServerId(Index)
		end
	end

	return Selected
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYERS
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.Players()
	return GetPlayers()
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- BLIPADMIN
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.BlipAdmin()
	Blipmin = not Blipmin

	while Blipmin do
		for Entity,v in pairs(GetPlayers()) do
			if GlobalState["Players"][v] then
				DrawText3D(GetEntityCoords(Entity),GlobalState["Players"][v][1].." "..GlobalState["Players"][v][2].." ~g~H:~w~ "..GetEntityHealth(Entity).." ~y~A:~w~ "..GetPedArmour(Entity),0.275)
			end
		end

		Wait(0)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYSOUND
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.PlaySound(Dict,Name)
	PlaySoundFrontend(-1,Dict,Name,false)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PASSPORTENALBLE
-----------------------------------------------------------------------------------------------------------------------------------------
function PassportEnable()
	if UsableF7 and not Information and not IsPauseMenuActive() then
		Information = true

		while Information do
			local Ped = PlayerPedId()
			local Coords = GetEntityCoords(Ped)

			for Entity,v in pairs(GetPlayers()) do
				local OtherCoords = GetEntityCoords(Entity)
				if HasEntityClearLosToEntity(Ped,Entity,17) and #(Coords - OtherCoords) <= 5 then
					DrawText3D(OtherCoords,"~w~"..GlobalState["Players"][v][1],0.45)
				end
			end

			Wait(0)
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PASSPORTDISABLE
-----------------------------------------------------------------------------------------------------------------------------------------
function PassportDisable()
	Information = false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- REGISTERCOMMAND
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("+Information",PassportEnable)
RegisterCommand("-Information",PassportDisable)
RegisterKeyMapping("+Information","Visualizar passaportes.","keyboard","F7")
-----------------------------------------------------------------------------------------------------------------------------------------
-- DRAWTEXT3D
-----------------------------------------------------------------------------------------------------------------------------------------
function DrawText3D(Coords,Text,Weight)
	local onScreen,x,y = World3dToScreen2d(Coords["x"],Coords["y"],Coords["z"] + 1.10)

	if onScreen then
		SetTextFont(4)
		SetTextCentre(true)
		SetTextProportional(1)
		SetTextScale(0.35,0.35)
		SetTextColour(255,255,255,150)

		SetTextEntry("STRING")
		AddTextComponentString(Text)
		EndTextCommandDisplayText(x,y)

		local Width = string.len(Text) / 160 * Weight
		DrawRect(x,y + 0.0125,Width,0.03,15,15,15,175)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local NoClip = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- NOCLIP
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.noClip()
	NoClip = not NoClip
	local Ped = PlayerPedId()

	if NoClip then
		LocalPlayer["state"]:set("Blastoise",true,false)
		LocalPlayer["state"]:set("Charizard",true,false)

		SetEntityCollision(Ped,false,false)
	else
		SetEntityCollision(Ped,true,true)

		LocalPlayer["state"]:set("Blastoise",false,false)
		LocalPlayer["state"]:set("Charizard",false,false)
	end

	while NoClip do
		local Speed = 1.0
		local Ped = PlayerPedId()
		local cX,cY,cZ = GetCamDirections()
		local Coords = GetEntityCoords(Ped)
		local X,Y,Z = table.unpack(Coords)

		if IsControlPressed(0,21) then
			Speed = 5.0
		end

		if IsControlPressed(0,32) then
			X = X + Speed * cX
			Y = Y + Speed * cY
			Z = Z + Speed * cZ
		end

		if IsControlPressed(0,269) then
			X = X - Speed * cX
			Y = Y - Speed * cY
			Z = Z - Speed * cZ
		end

		if IsControlPressed(0,10) then
			Z = Z + 0.25
		end

		if IsControlPressed(0,11) then
			Z = Z - 0.25
		end

		SetEntityCoordsNoOffset(Ped,X,Y,Z,false,false,false)

		Wait(0)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETCAMDIRECTION
-----------------------------------------------------------------------------------------------------------------------------------------
function GetCamDirections()
	local Ped = PlayerPedId()
	local Pitch = GetGameplayCamRelativePitch()
	local Heading = GetGameplayCamRelativeHeading() + GetEntityHeading(Ped)
	local x = -math.sin(Heading * math.pi / 180.0)
	local y = math.cos(Heading * math.pi / 180.0)
	local z = math.sin(Pitch * math.pi / 180.0)
	local Len = math.sqrt(x * x + y * y + z * z)
	if Len ~= 0 then
		x = x / Len
		y = y / Len
		z = z / Len
	end

	return x,y,z
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Flags = 0
local Dict = nil
local Name = nil
local Active = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYANIM
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.PlayAnim(Upper,Sequency,Loop)
	local Ped = PlayerPedId()

	if Sequency["task"] then
		tvRP.stopAnim(true)

		if Sequency["task"] == "PROP_HUMAN_SEAT_CHAIR_MP_PLAYER" then
			local Coords = GetEntityCoords(Ped)
			local Heading = GetEntityHeading(Ped)
			TaskStartScenarioAtPosition(Ped,Sequency["task"],Coords["x"],Coords["y"],Coords["z"] - 1,Heading,0,0,false)
		else
			TaskStartScenarioInPlace(Ped,Sequency["task"],0,false)
		end
	else
		Flags = 0
		tvRP.stopAnim(Upper)

		if LoadAnim(Sequency[1]) then
			if Upper then
				Flags = Flags + 48
			end

			if Loop then
				Flags = Flags + 1
			end

			Dict = Sequency[1]
			Name = Sequency[2]

			if Flags == 49 then
				Active = true
			end

			TaskPlayAnim(Ped,Sequency[1],Sequency[2],8.0,8.0,-1,Flags,0,0,0,0)
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADANIM
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		local TimeDistance = 999
		local Ped = PlayerPedId()
		if Active and GetEntityHealth(Ped) > 100 then
			TimeDistance = 1

			local Ped = PlayerPedId()
			if not IsEntityPlayingAnim(Ped,Dict,Name,3) then
				TaskPlayAnim(Ped,Dict,Name,8.0,8.0,-1,Flags,1,0,0,0)
			end

			DisableControlAction(0,18,true)
			DisableControlAction(0,24,true)
			DisableControlAction(0,25,true)
			DisableControlAction(0,257,true)
			DisableControlAction(0,263,true)
			DisableControlAction(0,140,true)
			DisableControlAction(0,142,true)
			DisableControlAction(0,143,true)
			DisablePlayerFiring(Ped,true)
		end

		Wait(TimeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- STOPANIM
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.stopAnim(Upper)
	Active = false
	local Ped = PlayerPedId()

	if Upper then
		ClearPedSecondaryTask(Ped)
	else
		ClearPedTasks(Ped)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ANIMACTIVE
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.AnimActive()
	Active = false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- MODELEXIST
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.ModelExist(Hash)
	return IsModelInCdimage(Hash)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETHEALTH
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.SetHealth(Health)
	local Ped = PlayerPedId()
	SetEntityHealth(Ped,Health)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPGRADEHEALTH
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.UpgradeHealth(Number)
	local Ped = PlayerPedId()
	local Health = GetEntityHealth(Ped)
	if Health > 100 then
		SetEntityHealth(Ped,Health + Number)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DOWNGRADEHEALTH
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.DowngradeHealth(Number)
	local Ped = PlayerPedId()
	local Health = GetEntityHealth(Ped)

	SetEntityHealth(Ped,Health - Number)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ENTIITYCOORDSZ
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.EntityCoordsZ()
	local Ped = PlayerPedId()
	local Coords = GetEntityCoords(Ped)
	local _,GroundZ = GetGroundZFor_3dCoord(Coords["x"],Coords["y"],Coords["z"])

	return vec3(Coords["x"],Coords["y"],GroundZ)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYINGANIM
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.PlayingAnim(Dict,Name)
	return IsEntityPlayingAnim(PlayerPedId(),Dict,Name,3)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SKIN
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.Skin(Hash)
	if LoadModel(Hash) then
		LocalPlayer["state"]:set("Charizard",true,false)

		local Pid = PlayerId()
		local Ped = PlayerPedId()

		SetPlayerModel(Pid,Hash)
		SetPedComponentVariation(Ped,5,0,0,1)
		SetModelAsNoLongerNeeded(Hash)

		tvRP.ReloadCharacter()
		ReloadCharacter(Pid,Ped)

		LocalPlayer["state"]:set("Charizard",false,false)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- RELOADCHARACTER
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.ReloadCharacter()
	exports["skinshop"]:Apply()
	exports["barbershop"]:Apply()
	exports["tattooshop"]:Apply()
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP:ACTIVE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("vRP:Active")
AddEventHandler("vRP:Active",function(Passport,Name)
	TriggerEvent("hud:Passport",Passport)
	LocalPlayer["state"]:set("Name",Name,false)
	LocalPlayer["state"]:set("Active",true,false)
	LocalPlayer["state"]:set("Blastoise",true,false)

	local Pid = PlayerId()
	local Ped = PlayerPedId()

	ReloadCharacter(Pid,Ped)
	FreezeEntityPosition(Ped,false)
	NetworkSetFriendlyFireOption(true)
	SetCanAttackFriendly(Ped,true,false)

	SetTimeout(10000,function()
		LocalPlayer["state"]:set("Blastoise",false,false)
	end)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HEALTHRECHARGE
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		local Pid = PlayerId()
		local Ped = PlayerPedId()

		SetPlayerHealthRechargeMultiplier(Pid,0.0)
		SetPlayerHealthRechargeLimit(Pid,0.0)

		if GetPlayerMaxArmour(Ped) ~= 100 then
			SetPlayerMaxArmour(Ped,100)
		end

		if GetPlayerMaxStamina(Pid) ~= 100.0 then
			SetPlayerMaxStamina(Pid,100.0)
		end

		Wait(100)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- RELOADCHARACTER
-----------------------------------------------------------------------------------------------------------------------------------------
function ReloadCharacter(Pid,Ped)
	StopAudioScenes()
	RemovePickups(Pid)
	SetMaxWantedLevel(0)
	SetRandomBoats(false)
	SetRandomTrains(false)
	DisableIdleCamera(true)
	SetGarbageTrucks(false)
	SetPedHelmet(Ped,false)
	SetDeepOceanScaler(0.0)
	SetPedMaxHealth(Ped,200)
	SetPlayerTargetingMode(0)
	SetRandomEventFlag(false)
	SetPoliceRadarBlips(false)
	DistantCopCarSirens(false)
	SetWeaponsNoAutoswap(true)
	SetEntityMaxHealth(Ped,200)
	SetAiWeaponDamageModifier(0.5)
	SetAllVehicleGeneratorsActive()
	SetPoliceIgnorePlayer(Ped,true)
	SetArtificialLightsState(false)
	SetPlayerCanUseCover(Pid,false)
	SetPedSteersAroundPeds(Ped,true)
	SetEveryoneIgnorePlayer(Ped,true)
	DisableVehicleDistantlights(true)
	SetAiMeleeWeaponDamageModifier(5.0)
	SetDispatchCopsForPlayer(Ped,false)
	SetFlashLightKeepOnWhileMoving(true)
	SetPedDropsWeaponsWhenDead(Ped,false)
	SetPedCanLosePropsOnDamage(Ped,false,0)

	SetPedConfigFlag(Ped,48,true)
	SetPedConfigFlag(Ped,35,false)
	SetPedConfigFlag(Ped,438,true)
	SetForceFootstepUpdate(Ped,true)
	SetPedAudioFootstepLoud(Ped,true)
	SetPedAudioFootstepQuiet(Ped,true)

	SetBlipAlpha(GetNorthRadarBlip(),0)
	ReplaceHudColourWithRgba(116,65,130,226,255)

	StartAudioScene("CHARACTER_CHANGE_IN_SKY_SCENE")
	SetAudioFlag("DisableFlightMusic",true)
	SetAudioFlag("PoliceScannerDisabled",true)
	SetScenarioGroupEnabled("Heist_Island_Peds",true)
	SetScenarioTypeEnabled("WORLD_VEHICLE_BIKE_OFF_ROAD_RACE",false)
	SetScenarioTypeEnabled("WORLD_VEHICLE_BUSINESSMEN",false)
	SetScenarioTypeEnabled("WORLD_VEHICLE_EMPTY",false)
	SetScenarioTypeEnabled("WORLD_VEHICLE_MECHANIC",false)
	SetScenarioTypeEnabled("WORLD_VEHICLE_MILITARY_PLANES_BIG",false)
	SetScenarioTypeEnabled("WORLD_VEHICLE_MILITARY_PLANES_SMALL",false)
	SetScenarioTypeEnabled("WORLD_VEHICLE_POLICE_BIKE",false)
	SetScenarioTypeEnabled("WORLD_VEHICLE_POLICE_CAR",false)
	SetScenarioTypeEnabled("WORLD_VEHICLE_POLICE_NEXT_TO_CAR",false)
	SetScenarioTypeEnabled("WORLD_VEHICLE_SALTON_DIRT_BIKE",false)
	SetScenarioTypeEnabled("WORLD_VEHICLE_SALTON",false)
	SetScenarioTypeEnabled("WORLD_VEHICLE_STREETRACE",false)
	SetStaticEmitterEnabled("LOS_SANTOS_VANILLA_UNICORN_01_STAGE",false)
	SetStaticEmitterEnabled("LOS_SANTOS_VANILLA_UNICORN_02_MAIN_ROOM",false)
	SetStaticEmitterEnabled("LOS_SANTOS_VANILLA_UNICORN_03_BACK_ROOM",false)
	SetStaticEmitterEnabled("se_dlc_aw_arena_construction_01",false)
	SetStaticEmitterEnabled("se_dlc_aw_arena_crowd_background_main",false)
	SetStaticEmitterEnabled("se_dlc_aw_arena_crowd_exterior_lobby",false)
	SetStaticEmitterEnabled("se_dlc_aw_arena_crowd_interior_lobby",false)
	SetStaticEmitterEnabled("se_walk_radio_d_picked",false)
	StartAudioScene("DLC_MPHEIST_TRANSITION_TO_APT_FADE_IN_RADIO_SCENE")
	StartAudioScene("FBI_HEIST_H5_MUTE_AMBIENCE_SCENE")
	SetAmbientZoneListStatePersistent("AZL_DLC_Hei4_Island_Zones",true,true)
	SetAmbientZoneListStatePersistent("AZL_DLC_Hei4_Island_Disabled_Zones",false,true)
	SetWeaponDamageModifier("WEAPON_BAT",0.25)
	SetWeaponDamageModifier("WEAPON_FROST",0.25)
	SetWeaponDamageModifier("WEAPON_KATANA",0.25)
	SetWeaponDamageModifier("WEAPON_HAMMER",0.25)
	SetWeaponDamageModifier("WEAPON_WRENCH",0.25)
	SetWeaponDamageModifier("WEAPON_THERMAL",0.25)
	SetWeaponDamageModifier("WEAPON_UNARMED",0.25)
	SetWeaponDamageModifier("WEAPON_HATCHET",0.25)
	SetWeaponDamageModifier("WEAPON_CROWBAR",0.25)
	SetWeaponDamageModifier("WEAPON_MACHETE",0.25)
	SetWeaponDamageModifier("WEAPON_POOLCUE",0.25)
	SetWeaponDamageModifier("WEAPON_KNUCKLE",0.25)
	SetWeaponDamageModifier("WEAPON_KARAMBIT",0.25)
	SetWeaponDamageModifier("WEAPON_GOLFCLUB",0.25)
	SetWeaponDamageModifier("WEAPON_BATTLEAXE",0.25)
	SetWeaponDamageModifier("WEAPON_SWITCHBLADE",0.0)
	SetWeaponDamageModifier("WEAPON_FLASHLIGHT",0.25)
	SetWeaponDamageModifier("WEAPON_NIGHTSTICK",0.35)
	SetWeaponDamageModifier("WEAPON_SMOKEGRENADE",0.0)
	SetWeaponDamageModifier("WEAPON_STONE_HATCHET",0.25)

	for Number = 1,121 do
		EnableDispatchService(Number,false)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- REMOVEPICKUPS
-----------------------------------------------------------------------------------------------------------------------------------------
function RemovePickups(Pid)
	local Pickups = {
		"PICKUP_AMMO_BULLET_MP",
		"PICKUP_AMMO_FIREWORK",
		"PICKUP_AMMO_FIREWORK_MP",
		"PICKUP_AMMO_FLAREGUN",
		"PICKUP_AMMO_GRENADELAUNCHER",
		"PICKUP_AMMO_GRENADELAUNCHER_MP",
		"PICKUP_AMMO_HOMINGLAUNCHER",
		"PICKUP_AMMO_MG",
		"PICKUP_AMMO_MINIGUN",
		"PICKUP_AMMO_MISSILE_MP",
		"PICKUP_AMMO_PISTOL",
		"PICKUP_AMMO_RIFLE",
		"PICKUP_AMMO_RPG",
		"PICKUP_AMMO_SHOTGUN",
		"PICKUP_AMMO_SMG",
		"PICKUP_AMMO_SNIPER",
		"PICKUP_ARMOUR_STANDARD",
		"PICKUP_CAMERA",
		"PICKUP_CUSTOM_SCRIPT",
		"PICKUP_GANG_ATTACK_MONEY",
		"PICKUP_HEALTH_SNACK",
		"PICKUP_HEALTH_STANDARD",
		"PICKUP_MONEY_CASE",
		"PICKUP_MONEY_DEP_BAG",
		"PICKUP_MONEY_MED_BAG",
		"PICKUP_MONEY_PAPER_BAG",
		"PICKUP_MONEY_PURSE",
		"PICKUP_MONEY_SECURITY_CASE",
		"PICKUP_MONEY_VARIABLE",
		"PICKUP_MONEY_WALLET",
		"PICKUP_PARACHUTE",
		"PICKUP_PORTABLE_CRATE_FIXED_INCAR",
		"PICKUP_PORTABLE_CRATE_FIXED_INCAR_SMALL",
		"PICKUP_PORTABLE_CRATE_FIXED_INCAR_WITH_PASSENGERS",
		"PICKUP_PORTABLE_CRATE_UNFIXED",
		"PICKUP_PORTABLE_CRATE_UNFIXED_INAIRVEHICLE_WITH_PASSENGERS",
		"PICKUP_PORTABLE_CRATE_UNFIXED_INCAR",
		"PICKUP_PORTABLE_CRATE_UNFIXED_INCAR_SMALL",
		"PICKUP_PORTABLE_CRATE_UNFIXED_INCAR_WITH_PASSENGERS",
		"PICKUP_PORTABLE_CRATE_UNFIXED_LOW_GLOW",
		"PICKUP_PORTABLE_DLC_VEHICLE_PACKAGE",
		"PICKUP_PORTABLE_PACKAGE",
		"PICKUP_SUBMARINE",
		"PICKUP_VEHICLE_ARMOUR_STANDARD",
		"PICKUP_VEHICLE_CUSTOM_SCRIPT",
		"PICKUP_VEHICLE_CUSTOM_SCRIPT_LOW_GLOW",
		"PICKUP_VEHICLE_CUSTOM_SCRIPT_NO_ROTATE",
		"PICKUP_VEHICLE_HEALTH_STANDARD",
		"PICKUP_VEHICLE_HEALTH_STANDARD_LOW_GLOW",
		"PICKUP_VEHICLE_MONEY_VARIABLE",
		"PICKUP_VEHICLE_WEAPON_APPISTOL",
		"PICKUP_VEHICLE_WEAPON_ASSAULTSMG",
		"PICKUP_VEHICLE_WEAPON_COMBATPISTOL",
		"PICKUP_VEHICLE_WEAPON_GRENADE",
		"PICKUP_VEHICLE_WEAPON_MICROSMG",
		"PICKUP_VEHICLE_WEAPON_MOLOTOV",
		"PICKUP_VEHICLE_WEAPON_PISTOL",
		"PICKUP_VEHICLE_WEAPON_PISTOL50",
		"PICKUP_VEHICLE_WEAPON_SAWNOFF",
		"PICKUP_VEHICLE_WEAPON_SMG",
		"PICKUP_VEHICLE_WEAPON_SMOKEGRENADE",
		"PICKUP_VEHICLE_WEAPON_STICKYBOMB",
		"PICKUP_WEAPON_ADVANCEDRIFLE",
		"PICKUP_WEAPON_APPISTOL",
		"PICKUP_WEAPON_ASSAULTRIFLE",
		"PICKUP_WEAPON_ASSAULTRIFLE_MK2",
		"PICKUP_WEAPON_ASSAULTSHOTGUN",
		"PICKUP_WEAPON_ASSAULTSMG",
		"PICKUP_WEAPON_AUTOSHOTGUN",
		"PICKUP_WEAPON_BAT",
		"PICKUP_WEAPON_BATTLEAXE",
		"PICKUP_WEAPON_BOTTLE",
		"PICKUP_WEAPON_BULLPUPRIFLE",
		"PICKUP_WEAPON_BULLPUPRIFLE_MK2",
		"PICKUP_WEAPON_BULLPUPSHOTGUN",
		"PICKUP_WEAPON_CARBINERIFLE",
		"PICKUP_WEAPON_CARBINERIFLE_MK2",
		"PICKUP_WEAPON_COMBATMG",
		"PICKUP_WEAPON_COMBATMG_MK2",
		"PICKUP_WEAPON_COMBATPDW",
		"PICKUP_WEAPON_COMBATPISTOL",
		"PICKUP_WEAPON_COMPACTLAUNCHER",
		"PICKUP_WEAPON_COMPACTRIFLE",
		"PICKUP_WEAPON_CROWBAR",
		"PICKUP_WEAPON_DAGGER",
		"PICKUP_WEAPON_DBSHOTGUN",
		"PICKUP_WEAPON_DOUBLEACTION",
		"PICKUP_WEAPON_FIREWORK",
		"PICKUP_WEAPON_FLAREGUN",
		"PICKUP_WEAPON_FLASHLIGHT",
		"PICKUP_WEAPON_GOLFCLUB",
		"PICKUP_WEAPON_GRENADE",
		"PICKUP_WEAPON_GRENADELAUNCHER",
		"PICKUP_WEAPON_GUSENBERG",
		"PICKUP_WEAPON_HAMMER",
		"PICKUP_WEAPON_HATCHET",
		"PICKUP_WEAPON_HEAVYPISTOL",
		"PICKUP_WEAPON_HEAVYSHOTGUN",
		"PICKUP_WEAPON_HEAVYSNIPER",
		"PICKUP_WEAPON_HEAVYSNIPER_MK2",
		"PICKUP_WEAPON_HOMINGLAUNCHER",
		"PICKUP_WEAPON_KNIFE",
		"PICKUP_WEAPON_KNUCKLE",
		"PICKUP_WEAPON_MACHETE",
		"PICKUP_WEAPON_MACHINEPISTOL",
		"PICKUP_WEAPON_MARKSMANPISTOL",
		"PICKUP_WEAPON_MARKSMANRIFLE",
		"PICKUP_WEAPON_MARKSMANRIFLE_MK2",
		"PICKUP_WEAPON_MG",
		"PICKUP_WEAPON_MICROSMG",
		"PICKUP_WEAPON_MINIGUN",
		"PICKUP_WEAPON_MINISMG",
		"PICKUP_WEAPON_MOLOTOV",
		"PICKUP_WEAPON_MUSKET",
		"PICKUP_WEAPON_NIGHTSTICK",
		"PICKUP_WEAPON_PETROLCAN",
		"PICKUP_WEAPON_PIPEBOMB",
		"PICKUP_WEAPON_PISTOL",
		"PICKUP_WEAPON_PISTOL_MK2",
		"PICKUP_WEAPON_PISTOL50",
		"PICKUP_WEAPON_POOLCUE",
		"PICKUP_WEAPON_PROXMINE",
		"PICKUP_WEAPON_PUMPSHOTGUN",
		"PICKUP_WEAPON_PUMPSHOTGUN_MK2",
		"PICKUP_WEAPON_RAILGUN",
		"PICKUP_WEAPON_REVOLVER",
		"PICKUP_WEAPON_REVOLVER_MK2",
		"PICKUP_WEAPON_RPG",
		"PICKUP_WEAPON_SAWNOFFSHOTGUN",
		"PICKUP_WEAPON_SMG",
		"PICKUP_WEAPON_SMG_MK2",
		"PICKUP_WEAPON_SMOKEGRENADE",
		"PICKUP_WEAPON_SNIPERRIFLE",
		"PICKUP_WEAPON_SNSPISTOL",
		"PICKUP_WEAPON_SNSPISTOL_MK2",
		"PICKUP_WEAPON_SPECIALCARBINE",
		"PICKUP_WEAPON_SPECIALCARBINE_MK2",
		"PICKUP_WEAPON_STICKYBOMB",
		"PICKUP_WEAPON_STONE_HATCHET",
		"PICKUP_WEAPON_STUNGUN",
		"PICKUP_WEAPON_SWITCHBLADE",
		"PICKUP_WEAPON_VINTAGEPISTOL",
		"PICKUP_WEAPON_WRENCH",
		"PICKUP_WEAPON_RAYCARBINE"
	}

	for Number = 1,#Pickups do
		ToggleUsePickupsForPlayer(Pid,GetHashKey(Pickups[Number]),false)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHARIZARD
-----------------------------------------------------------------------------------------------------------------------------------------
AddStateBagChangeHandler("Charizard", ("player:%s"):format(LocalPlayer["state"]["Player"]), function(Name, Key, Value)
	SetEntityVisible(PlayerPedId(), not Value, 0)
end) -----------------------------------------------------------------------------------------------------------------------------------------
-- BLASTOISE
-----------------------------------------------------------------------------------------------------------------------------------------
AddStateBagChangeHandler("Blastoise", ("player:%s"):format(LocalPlayer["state"]["Player"]), function(Name, Key, Value)
	SetEntityInvincible(PlayerPedId(), Value, 0)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local LastTravel = nil
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLOSESTVEHICLE
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.ClosestVehicle(Radius)
	local Selected = 0
	local Ped = PlayerPedId()
	local Radius = Radius + 0.0001
	local Coords = GetEntityCoords(Ped)
	if IsAnyVehicleNearPoint(Coords, Radius) then
		Selected = GetClosestVehicle(Coords, Radius, 0, 231807)
		if Selected == 0 then
			Selected = GetClosestVehicle(Coords, Radius, 0, 391551)
		end
	end

	return Selected
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVEHICLE
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.InsideVehicle()
	local Ped = PlayerPedId()
	return IsPedInAnyVehicle(Ped)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- VEHICLELIST
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.VehicleList(Radius)
	local Vehicle = nil
	local Ped = PlayerPedId()
	if IsPedInAnyVehicle(Ped) then
		Vehicle = GetVehiclePedIsUsing(Ped)
	else
		Vehicle = tvRP.ClosestVehicle(Radius)
	end

	if IsEntityAVehicle(Vehicle) then
		local Network = VehToNet(Vehicle)
		local Class = GetVehicleClass(Vehicle)
		local Model = GetEntityArchetypeName(Vehicle)
		local Plate = GetVehicleNumberPlateText(Vehicle)

		return Vehicle,Network,Plate,Model,Class
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- VEHICLEAROUND
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.VehicleAround()
	local Ped = PlayerPedId()
	local Vehicle = tvRP.ClosestVehicle(4)

	if IsEntityAVehicle(Vehicle) then
		local PlayerAround = {}
		for _, Player in ipairs(GetActivePlayers()) do
			PlayerAround[#PlayerAround + 1] = GetPlayerServerId(Player)
		end

		return Vehicle, NetworkGetNetworkIdFromEntity(Vehicle), PlayerAround
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- VEHICLENAME
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.VehicleName()
	local Ped = PlayerPedId()
	if IsPedInAnyVehicle(Ped) then
		local Vehicle = GetVehiclePedIsUsing(Ped)

		return GetEntityArchetypeName(Vehicle)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- VEHICLEMODEL
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.VehicleModel(Vehicle)
	return GetEntityArchetypeName(Vehicle)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- VEHICLEHASH
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.VehicleHash()
	local Ped = PlayerPedId()
	if IsPedInAnyVehicle(Ped) then
		local Vehicle = GetLastDrivenVehicle()
		local Model = GetEntityModel(Vehicle)

		return Model
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- LASTVEHICLE
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.LastVehicle(Name)
	local Vehicle = GetLastDrivenVehicle()
	if DoesEntityExist(Vehicle) and Name == GetEntityArchetypeName(Vehicle) then
		return true
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CALCULATETRAVEL
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.CalculateTravel()
	local Ped = PlayerPedId()
	local Coords = GetEntityCoords(Ped)

	if not LastTravel then
		LastTravel = Coords
	end

	return CalculateTravelDistanceBetweenPoints(Coords, LastTravel)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATETRAVEL
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.UpdateTravel()
	local Ped = PlayerPedId()
	local Coords = GetEntityCoords(Ped)

	LastTravel = Coords
end


-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP:ADDEXPLOSION
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("vRP:AddExplosion")
AddEventHandler("vRP:AddExplosion", function(X, Y, Z, Type, Damage, Audible, Invisible, Camera)
	AddExplosion(X, Y, Z, Type, Damage, Audible, Invisible, Camera)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP:COORDEXPLOSION
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("vRP:CoordExplosion")
AddEventHandler("vRP:CoordExplosion", function(X, Y, Z)
	AddExplosion(X, Y, Z, 2, 1.0, true, false, false)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP:EXPLOSION
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("vRP:Explosion")
AddEventHandler("vRP:Explosion", function(Coords)
	AddExplosion(Coords, 2, 1.0, true, false, false)
end)
