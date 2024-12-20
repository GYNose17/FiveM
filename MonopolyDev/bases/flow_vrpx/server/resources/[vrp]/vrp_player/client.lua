local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPserver = Tunnel.getInterface("vRP","vrp_player")

src = {}
Tunnel.bindInterface("vrp_player",src)
vSERVER = Tunnel.getInterface("vrp_player")
local user_id = nil
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- DISCORD API
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
        local players = vSERVER.CheckPlayers()
        SetDiscordAppId(1130952862957060096) --token do seu BOT
        SetDiscordRichPresenceAssetText('discord.gg/cEwAsnrDe7') --LINK do seu discord
		SetDiscordRichPresenceAsset("logo")
        SetRichPresence("Jogadores Conectados: "..players)
        SetDiscordRichPresenceAction(0, "JOGAR", "fivem/cfx.re/join/z6kyd9") -- link do seu server.cfx
        SetDiscordRichPresenceAction(1, "DISCORD", "discord.gg/cEwAsnrDe7")--LINK do seu discord
        Citizen.Wait(200*10000)
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- DESABILITAR X NA MOTO
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
    while true do
        local timeDistance = 500
        local ped = PlayerPedId()
		if IsPedInAnyVehicle(ped) then
            local vehicle = GetVehiclePedIsIn(ped)
			if (GetPedInVehicleSeat(vehicle, -1) == ped or GetPedInVehicleSeat(vehicle, 0) == ped) and GetVehicleClass(vehicle) == 8 then
				timeDistance = 4
                DisableControlAction(0, 345, true)
            end
		end
		Citizen.Wait(timeDistance)
    end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- FIX TRUNKIN
-----------------------------------------------------------------------------------------------------------------------------------------
local isInTrunkIn = true

src.updateTrunkIn = function(vehicle, status)
	if status then
		isInTrunkIn = status
		isTrunkVehID = vehicle
	else
		isTrunkVehID = nil
		isInTrunkIn = false
	end

	CreateThread(function()
		while isInTrunkIn do
			--drawTxt("Pressione~p~ E ~w~ Para Sair do Porta-malas.",4,0.5,0.93,0.50,255,255,255,200)

			if IsControlJustReleased(0,51) then
				TriggerServerEvent('trunkin')
			end
			Wait(0)
		end
	end)
end

Citizen.CreateThread(function()
	while true do
		local time = 1000
		if isInTrunkIn then
			time = 300
			if isTrunkVehID ~= nil then
				if not IsEntityAVehicle(isTrunkVehID) then
					isTrunkVehID = nil
					isInTrunkIn = false
					DetachEntity(PlayerPedId(), true, true)
					SetEntityVisible(PlayerPedId(), true)
					SetEntityInvincible(PlayerPedId(), false)
					vRP.setMalas(false)
				end
			end
		end

		Citizen.Wait(time)
	end
end)

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- CONTADOR DE SALARIO
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		vSERVER.rCountSalario()
		Citizen.Wait(300*1000)
	end
end)

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- EMPURRAR E CAIR
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
        local time = 500
        
        if IsPedJumping(PlayerPedId()) then
            time = 5
            if IsControlJustReleased(0,51) then
                if not IsPedInAnyVehicle(PlayerPedId()) then
                    local ForwardVector = GetEntityForwardVector(PlayerPedId())
                    local Tackled = {}

                    SetEntityHealth(PlayerPedId(),GetEntityHealth(PlayerPedId())-10)
                    SetPedToRagdollWithFall(PlayerPedId(),1500,2000,0,ForwardVector,1.0,0.0,0.0,0.0,0.0,0.0,0.0)

                    while IsPedRagdoll(PlayerPedId()) do
                        Citizen.Wait(1)
                        for Key,Value in ipairs(GetTouchedPlayers()) do
                            if not Tackled[Value] then
                                Tackled[Value] = true
                                vSERVER.TackleServerPlayer(GetPlayerServerId(Value),ForwardVector.x,ForwardVector.y,ForwardVector.z,GetPlayerName(PlayerId()))
                            end
                        end
                    end
                end
            end
        end

        Citizen.Wait(time)
	end
end)

function src.TackleClientPlayer(ForwardVectorX,ForwardVectorY,ForwardVectorZ,Tackler)
    SetPedToRagdollWithFall(PlayerPedId(),1500,1500,0,ForwardVectorX,ForwardVectorY,ForwardVectorZ,10.0,0.0,0.0,0.0,0.0,0.0,0.0)
end

function GetPlayers()
    local Players = {}
    for i = 0,256 do
        if NetworkIsPlayerActive(i) then
            table.insert(Players,i)
        end
    end
    return Players
end

function GetTouchedPlayers()
    local TouchedPlayer = {}
    for Key,Value in ipairs(GetPlayers()) do
		if IsEntityTouchingEntity(PlayerPedId(),GetPlayerPed(Value)) then
			table.insert(TouchedPlayer,Value)
		end
    end
    return TouchedPlayer
end

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- TROCAR DE BANCO
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function src.seatPlayer(index)
    local ped = PlayerPedId()
    local vehicle = GetVehiclePedIsUsing(ped)

    if IsEntityAVehicle(vehicle) and IsPedInAnyVehicle(ped) then
        if parseInt(index) <= 1 or index == nil then
            seat = -1
        elseif parseInt(index) == 2 then
            seat = 0
        elseif parseInt(index) == 3 then
            seat = 1
        elseif parseInt(index) == 4 then
            seat = 2
        elseif parseInt(index) == 5 then
            seat = 3
        elseif parseInt(index) == 6 then
            seat = 4
        elseif parseInt(index) == 7 then
            seat = 5
        elseif parseInt(index) >= 8 then
            seat = 6
        end

        if IsVehicleSeatFree(vehicle,seat) then
            SetPedIntoVehicle(ped,vehicle,seat)
        end
    end
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- [ ATTACHS ]---------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("attachs",function(source,args)
	local ped = PlayerPedId()
    if vSERVER.checkAttachs() then
        if GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_COMBATPISTOL") then
            GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_COMBATPISTOL"),GetHashKey("COMPONENT_AT_PI_FLSH"))
        elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_SMG") then
            GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_SMG"),GetHashKey("COMPONENT_AT_AR_FLSH"))
            GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_SMG"),GetHashKey("COMPONENT_AT_SCOPE_MACRO_02"))
        elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_COMBATPDW") then
            GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_COMBATPDW"),GetHashKey("COMPONENT_AT_AR_FLSH"))
            GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_COMBATPDW"),GetHashKey("COMPONENT_AT_SCOPE_SMALL"))
            GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_COMBATPDW"),GetHashKey("COMPONENT_AT_AR_AFGRIP"))
        elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_PUMPSHOTGUN_MK2") then
            GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_PUMPSHOTGUN_MK2"),GetHashKey("COMPONENT_AT_SIGHTS"))
            GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_PUMPSHOTGUN_MK2"),GetHashKey("COMPONENT_AT_SCOPE_SMALL_MK2"))
            GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_PUMPSHOTGUN_MK2"),GetHashKey("COMPONENT_AT_AR_FLSH"))
        elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_CARBINERIFLE") then
            GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_CARBINERIFLE"),GetHashKey("COMPONENT_AT_AR_FLSH"))
            GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_CARBINERIFLE"),GetHashKey("COMPONENT_AT_AR_AFGRIP"))
            GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_CARBINERIFLE"),GetHashKey("COMPONENT_AT_SCOPE_MEDIUM"))
        elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_MICROSMG") then
            GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_MICROSMG"),GetHashKey("COMPONENT_AT_PI_FLSH"))
            GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_MICROSMG"),GetHashKey("COMPONENT_AT_SCOPE_MACRO"))
        elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_ASSAULTRIFLE") then
            GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_ASSAULTRIFLE"),GetHashKey("COMPONENT_AT_AR_FLSH"))
            GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_ASSAULTRIFLE"),GetHashKey("COMPONENT_AT_SCOPE_MACRO"))
            GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_ASSAULTRIFLE"),GetHashKey("COMPONENT_AT_AR_AFGRIP"))
            GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_ASSAULTRIFLE"),GetHashKey("COMPONENT_ASSAULTRIFLE_VARMOD_LUXE"))
        elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_PISTOL_MK2") then
            GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_PISTOL_MK2"),GetHashKey("COMPONENT_AT_PI_RAIL"))
            GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_PISTOL_MK2"),GetHashKey("COMPONENT_AT_PI_FLSH_02"))
            GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_PISTOL_MK2"),GetHashKey("COMPONENT_AT_PI_COMP"))
        elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_REVOLVER_MK2") then
            GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_REVOLVER_MK2"),GetHashKey("COMPONENT_AT_PI_FLSH"))
            GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_REVOLVER_MK2"),GetHashKey("COMPONENT_AT_SIGHTS"))
            GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_REVOLVER_MK2"),GetHashKey("COMPONENT_REVOLVER_MK2_CAMO_IND_01"))	
        elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_ASSAULTSMG") then
            GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_ASSAULTSMG"),GetHashKey("COMPONENT_AT_AR_FLSH"))
            GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_ASSAULTSMG"),GetHashKey("COMPONENT_AT_SCOPE_MACRO"))
            GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_ASSAULTSMG"),GetHashKey("COMPONENT_ASSAULTSMG_VARMOD_LOWRIDER"))
        elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_PISTOL") then
            GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_PISTOL"),GetHashKey("COMPONENT_AT_PI_FLSH"))
        elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_CARBINERIFLE_MK2") then
            GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_CARBINERIFLE_MK2"),GetHashKey("COMPONENT_SPECIALCARBINE_MK2_CLIP_02"))	
            GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_CARBINERIFLE_MK2"),GetHashKey("COMPONENT_AT_MUZZLE_06"))
            GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_CARBINERIFLE_MK2"),GetHashKey("COMPONENT_AT_SIGHTS"))
            GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_CARBINERIFLE_MK2"),GetHashKey("COMPONENT_AT_SCOPE_MEDIUM_MK2"))
            GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_CARBINERIFLE_MK2"),GetHashKey("COMPONENT_AT_AR_FLSH"))
            
        elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_SPECIALCARBINE") then
            GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_SPECIALCARBINE"),GetHashKey("COMPONENT_AT_AR_FLSH"))
            GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_SPECIALCARBINE"),GetHashKey("COMPONENT_AT_SCOPE_MEDIUM"))
            GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_SPECIALCARBINE"),GetHashKey("COMPONENT_AT_AR_AFGRIP"))
            GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_SPECIALCARBINE"),GetHashKey("COMPONENT_SPECIALCARBINE_CLIP_01"))
        elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_CARBINERIFLE_MK2") then
            GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_CARBINERIFLE_MK2"),GetHashKey("COMPONENT_AT_SIGHTS"))
            GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_CARBINERIFLE_MK2"),GetHashKey("COMPONENT_AT_MUZZLE_04"))
            GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_CARBINERIFLE_MK2"),GetHashKey("COMPONENT_AT_AR_AFGRIP_02"))
            GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_CARBINERIFLE_MK2"),GetHashKey("COMPONENT_AT_AR_FLSH"))
        elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_ASSAULTRIFLE_MK2") then
            GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_ASSAULTRIFLE_MK2"),GetHashKey("COMPONENT_AT_AR_FLSH"))
            GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_ASSAULTRIFLE_MK2"),GetHashKey("COMPONENT_AT_SCOPE_MEDIUM_MK2"))
            GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_ASSAULTRIFLE_MK2"),GetHashKey("COMPONENT_AT_AR_AFGRIP_02"))
            GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_ASSAULTRIFLE_MK2"),GetHashKey("COMPONENT_AT_MUZZLE_01"))
        elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_BULLPUPRIFLE_MK2") then
            GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_BULLPUPRIFLE_MK2"),GetHashKey("COMPONENT_BULLPUPRIFLE_MK2_CLIP_01"))
            GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_BULLPUPRIFLE_MK2"),GetHashKey("COMPONENT_AT_AR_FLSH"))
            GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_BULLPUPRIFLE_MK2"),GetHashKey("COMPONENT_AT_SIGHTS"))
            GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_BULLPUPRIFLE_MK2"),GetHashKey("COMPONENT_AT_MUZZLE_04"))
            GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_BULLPUPRIFLE_MK2"),GetHashKey("COMPONENT_AT_BP_BARREL_01"))
            GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_BULLPUPRIFLE_MK2"),GetHashKey("COMPONENT_AT_AR_AFGRIP_02"))
            GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_BULLPUPRIFLE_MK2"),GetHashKey("COMPONENT_BULLPUPRIFLE_MK2_CAMO_09"))
        elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_SPECIALCARBINE_MK2") then	
            GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_SPECIALCARBINE_MK2"),GetHashKey("COMPONENT_AT_AR_FLSH"))
            GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_SPECIALCARBINE_MK2"),GetHashKey("COMPONENT_AT_AR_AFGRIP_02"))
            GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_SPECIALCARBINE_MK2"),GetHashKey("COMPONENT_AT_SCOPE_MEDIUM_MK2"))
            GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_SPECIALCARBINE_MK2"),GetHashKey("COMPONENT_SPECIALCARBINE_MK2_CLIP_01"))
            GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_SPECIALCARBINE_MK2"),GetHashKey("COMPONENT_AT_MUZZLE_04"))
        end
    end
end)


RegisterNetEvent('Weapon:Attachs')
AddEventHandler('Weapon:Attachs', function() 
	local ped = PlayerPedId()
	GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_COMBATPISTOL"),GetHashKey("COMPONENT_AT_PI_FLSH"))

	GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_SMG"),GetHashKey("COMPONENT_AT_AR_FLSH"))
	GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_SMG"),GetHashKey("COMPONENT_AT_SCOPE_MACRO_02"))


	GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_COMBATPDW"),GetHashKey("COMPONENT_AT_AR_FLSH"))
	GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_COMBATPDW"),GetHashKey("COMPONENT_AT_SCOPE_SMALL"))
	GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_COMBATPDW"),GetHashKey("COMPONENT_AT_AR_AFGRIP"))

	GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_PUMPSHOTGUN_MK2"),GetHashKey("COMPONENT_AT_SIGHTS"))
	GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_PUMPSHOTGUN_MK2"),GetHashKey("COMPONENT_AT_SCOPE_SMALL_MK2"))
	GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_PUMPSHOTGUN_MK2"),GetHashKey("COMPONENT_AT_AR_FLSH"))

	GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_CARBINERIFLE"),GetHashKey("COMPONENT_AT_AR_FLSH"))
	GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_CARBINERIFLE"),GetHashKey("COMPONENT_AT_AR_AFGRIP"))
	GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_CARBINERIFLE"),GetHashKey("COMPONENT_AT_SCOPE_MEDIUM"))

	GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_MICROSMG"),GetHashKey("COMPONENT_AT_PI_FLSH"))
	GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_MICROSMG"),GetHashKey("COMPONENT_AT_SCOPE_MACRO"))

	GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_ASSAULTRIFLE"),GetHashKey("COMPONENT_AT_AR_FLSH"))
	GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_ASSAULTRIFLE"),GetHashKey("COMPONENT_AT_SCOPE_MACRO"))
	GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_ASSAULTRIFLE"),GetHashKey("COMPONENT_AT_AR_AFGRIP"))
	GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_ASSAULTRIFLE"),GetHashKey("COMPONENT_ASSAULTRIFLE_VARMOD_LUXE"))

	GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_PISTOL_MK2"),GetHashKey("COMPONENT_AT_PI_RAIL"))
	GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_PISTOL_MK2"),GetHashKey("COMPONENT_AT_PI_FLSH_02"))
	GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_PISTOL_MK2"),GetHashKey("COMPONENT_AT_PI_COMP"))

	GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_REVOLVER_MK2"),GetHashKey("COMPONENT_AT_PI_FLSH"))
	GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_REVOLVER_MK2"),GetHashKey("COMPONENT_AT_SIGHTS"))
	GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_REVOLVER_MK2"),GetHashKey("COMPONENT_REVOLVER_MK2_CAMO_IND_01"))	

	GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_ASSAULTSMG"),GetHashKey("COMPONENT_AT_AR_FLSH"))
	GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_ASSAULTSMG"),GetHashKey("COMPONENT_AT_SCOPE_MACRO"))
	GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_ASSAULTSMG"),GetHashKey("COMPONENT_ASSAULTSMG_VARMOD_LOWRIDER"))

	GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_PISTOL"),GetHashKey("COMPONENT_AT_PI_FLSH"))

	GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_CARBINERIFLE_MK2"),GetHashKey("COMPONENT_SPECIALCARBINE_MK2_CLIP_02"))	
	GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_CARBINERIFLE_MK2"),GetHashKey("COMPONENT_AT_MUZZLE_06"))
	GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_CARBINERIFLE_MK2"),GetHashKey("COMPONENT_AT_SIGHTS"))
	GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_CARBINERIFLE_MK2"),GetHashKey("COMPONENT_AT_SCOPE_MEDIUM_MK2"))
	GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_CARBINERIFLE_MK2"),GetHashKey("COMPONENT_AT_AR_FLSH"))

	GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_SPECIALCARBINE"),GetHashKey("COMPONENT_AT_AR_FLSH"))
	GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_SPECIALCARBINE"),GetHashKey("COMPONENT_AT_SCOPE_MEDIUM"))
	GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_SPECIALCARBINE"),GetHashKey("COMPONENT_AT_AR_AFGRIP"))
	GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_SPECIALCARBINE"),GetHashKey("COMPONENT_SPECIALCARBINE_CLIP_01"))

	GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_CARBINERIFLE_MK2"),GetHashKey("COMPONENT_AT_SIGHTS"))
	GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_CARBINERIFLE_MK2"),GetHashKey("COMPONENT_AT_MUZZLE_04"))
	GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_CARBINERIFLE_MK2"),GetHashKey("COMPONENT_AT_AR_AFGRIP_02"))
	GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_CARBINERIFLE_MK2"),GetHashKey("COMPONENT_AT_AR_FLSH"))

	GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_ASSAULTRIFLE_MK2"),GetHashKey("COMPONENT_AT_AR_FLSH"))
	GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_ASSAULTRIFLE_MK2"),GetHashKey("COMPONENT_AT_SCOPE_MEDIUM_MK2"))
	GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_ASSAULTRIFLE_MK2"),GetHashKey("COMPONENT_AT_AR_AFGRIP_02"))
	GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_ASSAULTRIFLE_MK2"),GetHashKey("COMPONENT_AT_MUZZLE_01"))

	GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_BULLPUPRIFLE_MK2"),GetHashKey("COMPONENT_BULLPUPRIFLE_MK2_CLIP_01"))
	GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_BULLPUPRIFLE_MK2"),GetHashKey("COMPONENT_AT_AR_FLSH"))
	GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_BULLPUPRIFLE_MK2"),GetHashKey("COMPONENT_AT_SIGHTS"))
	GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_BULLPUPRIFLE_MK2"),GetHashKey("COMPONENT_AT_MUZZLE_04"))
	GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_BULLPUPRIFLE_MK2"),GetHashKey("COMPONENT_AT_BP_BARREL_01"))
	GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_BULLPUPRIFLE_MK2"),GetHashKey("COMPONENT_AT_AR_AFGRIP_02"))
	GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_BULLPUPRIFLE_MK2"),GetHashKey("COMPONENT_BULLPUPRIFLE_MK2_CAMO_09"))

	GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_SPECIALCARBINE_MK2"),GetHashKey("COMPONENT_AT_AR_FLSH"))
	GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_SPECIALCARBINE_MK2"),GetHashKey("COMPONENT_AT_AR_AFGRIP_02"))
	GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_SPECIALCARBINE_MK2"),GetHashKey("COMPONENT_AT_SCOPE_MEDIUM_MK2"))
	GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_SPECIALCARBINE_MK2"),GetHashKey("COMPONENT_SPECIALCARBINE_MK2_CLIP_01"))
	GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_SPECIALCARBINE_MK2"),GetHashKey("COMPONENT_AT_MUZZLE_04"))

	TriggerEvent("Notify","sucesso","Você usou o item <b>ATTACHS</b> em todas suas armas equipadas.",5)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- [ COR ]---------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("cor",function(source,args)
    if vSERVER.checkAttachs() then
        local tinta = parseInt(args[1])
        if tinta >= 0 then
            SetPedWeaponTintIndex(PlayerPedId(),GetSelectedPedWeapon(PlayerPedId()),tinta)
        else
            TriggerEvent("Notify","negado","Você precisa especificar uma pintura válida.",5)
        end
    end
end)

RegisterNetEvent('changeWeaponColor')
AddEventHandler('changeWeaponColor', function(cor) 
    local tinta = tonumber(cor)
    local ped = PlayerPedId()
    local arma = GetSelectedPedWeapon(ped)
    if tinta >= 0 then
        SetPedWeaponTintIndex(ped,arma,tinta)
    end
 
end)

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- /FPS
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("fps",function(source,args)
    if args[1] == "on" then
        SetTimecycleModifier("cinema")
        TriggerEvent("Notify","sucesso","Boost de fps ligado!", 5)
    elseif args[1] == "off" then
        SetTimecycleModifier("default")
        TriggerEvent("Notify","sucesso","Boost de fps desligado!", 5)
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- /VTUNING
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("vtuning",function(source,args)
	local vehicle = vRP.getNearestVehicle(3)
	if IsEntityAVehicle(vehicle) then
		local motor = GetVehicleMod(vehicle,11)
		local freio = GetVehicleMod(vehicle,12)
		local transmissao = GetVehicleMod(vehicle,13)
		local suspensao = GetVehicleMod(vehicle,15)
		local blindagem = GetVehicleMod(vehicle,16)
		local body = GetVehicleBodyHealth(vehicle)
		local engine = GetVehicleEngineHealth(vehicle)
		local fuel = GetVehicleFuelLevel(vehicle)

		if motor == -1 then
			motor = "Desativado"
		elseif motor == 0 then
			motor = "Nível 1 / "..GetNumVehicleMods(vehicle,11)
		elseif motor == 1 then
			motor = "Nível 2 / "..GetNumVehicleMods(vehicle,11)
		elseif motor == 2 then
			motor = "Nível 3 / "..GetNumVehicleMods(vehicle,11)
		elseif motor == 3 then
			motor = "Nível 4 / "..GetNumVehicleMods(vehicle,11)
		elseif motor == 4 then
			motor = "Nível 5 / "..GetNumVehicleMods(vehicle,11)
		end

		if freio == -1 then
			freio = "Desativado"
		elseif freio == 0 then
			freio = "Nível 1 / "..GetNumVehicleMods(vehicle,12)
		elseif freio == 1 then
			freio = "Nível 2 / "..GetNumVehicleMods(vehicle,12)
		elseif freio == 2 then
			freio = "Nível 3 / "..GetNumVehicleMods(vehicle,12)
		end

		if transmissao == -1 then
			transmissao = "Desativado"
		elseif transmissao == 0 then
			transmissao = "Nível 1 / "..GetNumVehicleMods(vehicle,13)
		elseif transmissao == 1 then
			transmissao = "Nível 2 / "..GetNumVehicleMods(vehicle,13)
		elseif transmissao == 2 then
			transmissao = "Nível 3 / "..GetNumVehicleMods(vehicle,13)
		elseif transmissao == 3 then
			transmissao = "Nível 4 / "..GetNumVehicleMods(vehicle,13)
		end

		if suspensao == -1 then
			suspensao = "Desativado"
		elseif suspensao == 0 then
			suspensao = "Nível 1 / "..GetNumVehicleMods(vehicle,15)
		elseif suspensao == 1 then
			suspensao = "Nível 2 / "..GetNumVehicleMods(vehicle,15)
		elseif suspensao == 2 then
			suspensao = "Nível 3 / "..GetNumVehicleMods(vehicle,15)
		elseif suspensao == 3 then
			suspensao = "Nível 4 / "..GetNumVehicleMods(vehicle,15)
		end

		if blindagem == -1 then
			blindagem = "Desativado"
		elseif blindagem == 0 then
			blindagem = "Nível 1 / "..GetNumVehicleMods(vehicle,16)
		elseif blindagem == 1 then
			blindagem = "Nível 2 / "..GetNumVehicleMods(vehicle,16)
		elseif blindagem == 2 then
			blindagem = "Nível 3 / "..GetNumVehicleMods(vehicle,16)
		elseif blindagem == 3 then
			blindagem = "Nível 4 / "..GetNumVehicleMods(vehicle,16)
		elseif blindagem == 4 then
			blindagem = "Nível 5 / "..GetNumVehicleMods(vehicle,16)
		end

		TriggerEvent("Notify","importante","<b>Motor:</b> "..motor.."<br><b>Freio:</b> "..freio.."<br><b>Transmissão:</b> "..transmissao.."<br><b>Suspensão:</b> "..suspensao.."<br><b>Blindagem:</b> "..blindagem.."<br><b>Chassi:</b> "..parseInt(body/10).."%<br><b>Engine:</b> "..parseInt(engine/10).."%<br><b>Gasolina:</b> "..parseInt(fuel).."%", 15)
	end
end)

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- SISTEMA DE PUXAR A ARMA
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
local data = {		
	["peds"] = {
	  ["mp_m_freemode_01"] = { ["components"] = { [7] = { [1] = 3, [6] = 5, [8] = 2, [42] = 43, [110] = 111, [119] = 120 }, [8] = { [16] = 18 } } },
	  ["mp_f_freemode_01"] = { ["components"] = { [7] = { [1] = 3, [6] = 5, [8] = 2, [29] = 30, [81] = 82 }, [8] = { [9] = 10 } } },
	}
}

local default_weapon = GetHashKey(data.weapon)
local active = false
local ped = nil
local currentPedData = nil
local holstered = true
local in_arena = false

RegisterNetEvent("flow_survival:updateArena", function(boolean)
	in_arena = boolean
end)

local skins = {
	"mp_m_freemode_01",
	"mp_f_freemode_01",
}
 
local weapons = { 
	"WEAPON_SNSPISTOL_MK2",
	"WEAPON_PISTOL_MK2",
	"WEAPON_HATCHET",
	"WEAPON_KNIFE",
	"WEAPON_FLARE",
	"WEAPON_POOLCUE",
	"WEAPON_BATTLEAXE",
	"WEAPON_BAT",
	"WEAPON_BOTTLE",
	"WEAPON_FLASHLIGHT",
	"WEAPON_CROWBAR",
	"WEAPON_GOLFCLUB",
	"WEAPON_DAGGER",
	"WEAPON_HAMMER",
	"WEAPON_WRENCH",
	"WEAPON_SWITCHBLADE",
	"WEAPON_KNUCKLE",
	"WEAPON_MACHINEPISTOL",
	"WEAPON_SMG_MK2",
	"WEAPON_SMG",
	"WEAPON_ASSAULTSMG",
	"WEAPON_SAWNOFFSHOTGUN",
	"AMMO_PUMPSHOTGUN_MK2",
	"WEAPON_ASSAULTRIFLE_MK2",
	"WEAPON_HEAVYSNIPER",
	"WEAPON_ASSAULTRIFLE",
	"WEAPON_SPECIALCARBINE_MK2",
	"WEAPON_CARBINERIFLE",
	"WEAPON_CARBINERIFLE_MK2",
	"WEAPON_SPECIALCARBINE",
	"WEAPON_STUNGUN",
	"WEAPON_FIREWORK",
	"WEAPON_SNOWBALL",
	"WEAPON_BZGAS"
}

Citizen.CreateThread(function()
	while true do
		local time = 650
		local ped = PlayerPedId()
		if not in_arena and DoesEntityExist( ped ) and not IsEntityDead( ped ) and not IsPedInAnyVehicle(PlayerPedId(), true) and CheckSkin(ped) then
			loadAnimDict( "rcmjosh4" )
			loadAnimDict( "weapons@pistol@" )
			if CheckWeapon(ped) then
				time = 200
				if holstered then
					TaskPlayAnim(ped, "rcmjosh4", "josh_leadout_cop2", 8.0, 2.0, -1, 48, 10, 0, 0, 0 )
					Citizen.Wait(600)
					ClearPedTasks(ped)
					holstered = false
				end
			elseif not CheckWeapon(ped) then
				time = 200
				if not holstered then
					TaskPlayAnim(ped, "weapons@pistol@", "aim_2_holster", 8.0, 2.0, -1, 48, 10, 0, 0, 0 )
					Citizen.Wait(500)
					ClearPedTasks(ped)

					holstered = true
				end
			end
		end

		Citizen.Wait(time)
	end
end)

function table_invert(t)
  local s={}
  for k,v in pairs(t) do
    s[v]=k
  end
  return s
end

function CheckSkin(ped)
	for i = 1, #skins do
		if GetHashKey(skins[i]) == GetEntityModel(ped) then
			return true
		end
	end
	return false
end

function CheckWeapon(ped)
	for i = 1, #weapons do
		if GetHashKey(weapons[i]) == GetSelectedPedWeapon(ped) then
			return true
		end
	end
	return false
end

function DisableActions(ped)
	DisableControlAction(1, 37, true)
	DisablePlayerFiring(ped, true)
end

function loadAnimDict( dict )
	while ( not HasAnimDictLoaded( dict ) ) do
		RequestAnimDict( dict )
		Citizen.Wait( 0 )
	end
end

Citizen.CreateThread(function()
  while true do
    ped = GetPlayerPed(-1)
    local ped_hash = GetEntityModel(ped)
    local enable = false 
    for ped, data in pairs(data.peds) do
      if GetHashKey(ped) == ped_hash then 
        enable = true
        if data.enabled ~= nil then
          enable = data.enabled
        end
        currentPedData = data
        break
      end
    end
    active = enable
    Citizen.Wait(5000)
  end
end)

local last_weapon = nil
Citizen.CreateThread(function()
  while true do
    if not in_arena and active then
      current_weapon = GetSelectedPedWeapon(ped)
      if current_weapon ~= last_weapon then
        
        for component, holsters in pairs(currentPedData.components) do
          local holsterDrawable = GetPedDrawableVariation(ped, component)
          local holsterTexture = GetPedTextureVariation(ped, component)

          local emptyHolster = holsters[holsterDrawable]
          if emptyHolster and current_weapon == default_weapon then
            SetPedComponentVariation(ped, component, emptyHolster, holsterTexture, 0)
            break
          end

          local filledHolster = table_invert(holsters)[holsterDrawable]
          if filledHolster and current_weapon ~= default_weapon and last_weapon == default_weapon then
            SetPedComponentVariation(ped, component, filledHolster, holsterTexture, 0)
            break
          end
        end
      end
      last_weapon = current_weapon
    end
    Citizen.Wait(500)
  end
end)

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- FIX LIMBO
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
local garagens = {
	{ 213.90,-809.08,31.01},
	{ 596.69,91.42,93.12},
	{ 275.41,-345.24,45.17},
	{ 56.08,-876.53,30.65},
	{ -348.95,-874.39,31.31},
	{ -340.64,266.31,85.67},
	{ -773.59,5597.57,33.60},
	{ 317.17,2622.99,44.45},
	{ 459.6,-986.55,25.7},
	{ -1184.93,-1509.98,4.64},
	{ -73.32,-2004.20,18.27}
}

Citizen.CreateThread(function()
	while true do
		local ped = PlayerPedId()
		local x,y,z = table.unpack(GetEntityCoords(ped))
		if z < -110 then
			if IsPedInAnyVehicle(ped) then
				vSERVER._deleteVeh(VehToNet(GetVehiclePedIsIn(ped)))
				teleportPlayerProxmityCoords(x,y,z)
				TriggerEvent('Notify', 'negado', 'Você caiu no limbo com seu veiculo e foi teleportado para a garagem mais proxima.', 5)
			end
		end

		Citizen.Wait(1000)
	end
end)

--NPC DAS LOJAS--
local pedlist = {
	{ ['x'] = -656.65, ['y'] = -858.77, ['z'] = 24.5, ['h'] = 353.72, ['hash'] = 0x69E8ABC3, ['hash2'] = "cs_tom" }, --digital den
	{ ['x'] = 77.38, ['y'] = -1387.68, ['z'] = 29.38, ['h'] = 178.121, ['hash'] = 0xC7496729, ['hash2'] = "a_f_y_runner_01"}, --loja de roupas
	{ ['x'] = -2299.52, ['y'] = 325.84, ['z'] = 174.6, ['h'] = 290.36, ['hash'] = 0x4D5696F7, ['hash2'] = "mp_m_bogdangoon"}, --contrabando

	--{ ['x'] = -438.68, ['y'] = -324.54, ['z'] = 34.92, ['h'] = 152.81, ['hash'] = 0xD47303AC, ['hash2'] = "s_m_m_doctor_01"}, --hospital
	{ ['x'] = -1632.1, ['y'] = -1015.49, ['z'] = 13.13, ['h'] = 319.81, ['hash'] = 0x8D8F1B10, ['hash2'] = "s_m_y_swat_01"}, --arena pvp
	{ ['x'] = 440.85, ['y'] = -978.9, ['z'] = 30.68, ['h'] = 189.75, ['hash'] = 0x8D8F1B10, ['hash2'] = "s_m_y_swat_01"}, --NPC AULA DP STRIPER





}

   CreateThread(function()
	for k,v in pairs(pedlist) do
	 RequestModel(GetHashKey(v.hash2))
	 while not HasModelLoaded(GetHashKey(v.hash2)) do Wait(100) end
	 ped = CreatePed(4,v.hash,v.x,v.y,v.z-1,v.h,false,true)
	 peds = ped
	 FreezeEntityPosition(ped,true)
	 SetEntityInvincible(ped,true)
	 SetBlockingOfNonTemporaryEvents(ped,true)
	end
   end)

function teleportPlayerProxmityCoords(x,y,z)
	local array = {}
	local coordenadas = {}

	for k,v in pairs(garagens) do
		local distanceAtual = parseInt(Vdist2(v[1],v[2],v[3], td(x),td(y),td(z)))
		table.insert(array, distanceAtual)
		coordenadas[distanceAtual] = { x = v[1], y = v[2], z = v[3] }
	end

	if coordenadas[math.min(table.unpack(array))] then
		SetEntityCoords(PlayerPedId(),coordenadas[math.min(table.unpack(array))].x,coordenadas[math.min(table.unpack(array))].y,coordenadas[math.min(table.unpack(array))].z)
	end

end

function td(n)
	n = math.ceil(n * 100) / 100
	return n
end

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- EMPURRAR VEICULO
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
local First = vector3(0.0, 0.0, 0.0)
local Second = vector3(5.0, 5.0, 5.0)
local Vehicle = {Coords = nil, Vehicle = nil, Dimension = nil, IsInFront = false, Distance = nil}
local empurrando = false

Citizen.CreateThread(function()
    while true do

        local time = 1000
        local ped = PlayerPedId()
        local posped = GetEntityCoords(GetPlayerPed(-1))
        local entityWorld = GetOffsetFromEntityInWorldCoords(ped, 0.0, 20.0, 0.0)
        local rayHandle = CastRayPointToPoint(posped.x, posped.y, posped.z, entityWorld.x, entityWorld.y, entityWorld.z, 10, ped, 0)
        local a, b, c, d, closestVehicle = GetRaycastResult(rayHandle)
        local Distance = GetDistanceBetweenCoords(c.x, c.y, c.z, posped.x, posped.y, posped.z, false);
        local vehicleCoords = GetEntityCoords(closestVehicle)
        local dimension = GetModelDimensions(GetEntityModel(closestVehicle), First, Second)
        if Distance < 6.0  and not IsPedInAnyVehicle(ped, false) then
            Vehicle.Coords = vehicleCoords
            Vehicle.Dimensions = dimension
            Vehicle.Vehicle = closestVehicle
            Vehicle.Distance = Distance
            if GetDistanceBetweenCoords(GetEntityCoords(closestVehicle) + GetEntityForwardVector(closestVehicle), GetEntityCoords(ped), true) > GetDistanceBetweenCoords(GetEntityCoords(closestVehicle) + GetEntityForwardVector(closestVehicle) * -1, GetEntityCoords(ped), true) then
                Vehicle.IsInFront = false
            else
                Vehicle.IsInFront = true
            end
        else
            Vehicle = {Coords = nil, Vehicle = nil, Dimensions = nil, IsInFront = false, Distance = nil}
        end
        Citizen.Wait(time)
    end
end)

Citizen.CreateThread(function()
    local lerpCurrentAngle = 0.0
    while true do 
    local ped = PlayerPedId()
    local time = 1000
    if Vehicle.Vehicle ~= nil then
        time = 5
            if IsControlPressed(0, 244) and IsVehicleSeatFree(Vehicle.Vehicle, -1) and not IsEntityAttachedToEntity(ped, Vehicle.Vehicle) then
                NetworkRequestControlOfEntity(Vehicle.Vehicle)

                if Vehicle.IsInFront then    
                    AttachEntityToEntity(PlayerPedId(), Vehicle.Vehicle, GetPedBoneIndex(6286), 0.0, Vehicle.Dimensions.y * -1 + 0.1 , Vehicle.Dimensions.z + 1.0, 0.0, 0.0, 180.0, 0.0, false, false, true, false, true)
                else
                    AttachEntityToEntity(PlayerPedId(), Vehicle.Vehicle, GetPedBoneIndex(6286), 0.0, Vehicle.Dimensions.y - 0.3, Vehicle.Dimensions.z  + 1.0, 0.0, 0.0, 0.0, 0.0, false, false, true, false, true)
                end
                if not empurrando then
                    empurrando = true
                    RequestAnimDict('missfinale_c2ig_11')
                    TaskPlayAnim(ped, 'missfinale_c2ig_11', 'pushcar_offcliff_m', 2.0, -8.0, -1, 35, 0, 0, 0, 0)
                end
                Citizen.Wait(200)
                    while true do
                    Citizen.Wait(5)

                    local speed = GetFrameTime() * 50
                    if IsDisabledControlPressed(0, 34) then
                        SetVehicleSteeringAngle(Vehicle.Vehicle, lerpCurrentAngle)
                        lerpCurrentAngle = lerpCurrentAngle + speed
                    elseif IsDisabledControlPressed(0, 9) then
                        SetVehicleSteeringAngle(Vehicle.Vehicle, lerpCurrentAngle)
                        lerpCurrentAngle = lerpCurrentAngle - speed
                    else
                        SetVehicleSteeringAngle(Vehicle.Vehicle, lerpCurrentAngle)
    
                        if lerpCurrentAngle < -0.02 then    
                            lerpCurrentAngle = lerpCurrentAngle + speed
                        elseif lerpCurrentAngle > 0.02 then
                            lerpCurrentAngle = lerpCurrentAngle - speed
                        else
                            lerpCurrentAngle = 0.0
                        end
                    end

                    if lerpCurrentAngle > 15.0 then
                        lerpCurrentAngle = 15.0
                    elseif lerpCurrentAngle < -15.0 then
                        lerpCurrentAngle = -15.0
                    end

                    if Vehicle.IsInFront then
                        SetVehicleForwardSpeed(Vehicle.Vehicle, -1.0)
                    else
                        SetVehicleForwardSpeed(Vehicle.Vehicle, 1.0)
                    end

                    if HasEntityCollidedWithAnything(Vehicle.Vehicle) then
                        SetVehicleOnGroundProperly(Vehicle.Vehicle)
                    end

                    if not IsDisabledControlPressed(0, 244) then
                        empurrando = false
                        DetachEntity(ped, false, false)
                        StopAnimTask(ped, 'missfinale_c2ig_11', 'pushcar_offcliff_m', 2.0)
                        FreezeEntityPosition(ped, false)
                        break
                    end
                end
            end
        end

        Citizen.Wait(time)
    end  
end)

function DrawText3D(x,y,z, text)
	local onScreen,_x,_y = World3dToScreen2d(x,y,z)
	SetTextFont(4)
	SetTextScale(0.35,0.35)
	SetTextColour(255,255,255,150)
	SetTextEntry("STRING")
	SetTextCentre(1)
	AddTextComponentString(text)
	DrawText(_x,_y)
	local factor = (string.len(text))/370
	DrawRect(_x,_y+0.0125,0.01+factor,0.03,0,0,0,80)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PRESSME
-----------------------------------------------------------------------------------------------------------------------------------------
local showMe = {}
local flagged       = false
RegisterNetEvent("vrp_player:pressMe")
AddEventHandler("vrp_player:pressMe",function(source,text,v)
	local pedSource = GetPlayerFromServerId(source)
	if pedSource ~= -1 then
		blocks = {"font size=", "font size =", "<font", "size=", "<font size=", "<font size =", "width", "zoom", "transform: scale(", "transform:"}
		for i = 1,#blocks do 
			if string.match(string.lower(text),blocks[i]) then 
			  flagged = true 
			end
		end
		if flagged then 
			flagged = false
			return
		else
			flagged = false
			showMe[GetPlayerPed(pedSource)] = { text,v[1],v[2],v[3],v[4],v[5] }
		end

	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADSHOWMEDISPLAY
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local timeDistance = 500
		local ped = PlayerPedId()
		local coords = GetEntityCoords(ped)
		for k,v in pairs(showMe) do
			local coordsMe = GetEntityCoords(k)
			local distance = #(coords - coordsMe)
			if distance <= 5 then
				timeDistance = 4
				if HasEntityClearLosToEntity(ped,k,17) then
					showMe3D(coordsMe.x,coordsMe.y,coordsMe.z+0.3,string.upper(v[1]),v[3],v[4],v[5],v[6])
				end
			end
		end

		Citizen.Wait(timeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TRHEADSHOWMETIMER
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		for k,v in pairs(showMe) do
			if v[2] > 0 then
				v[2] = v[2] - 1
				if v[2] <= 0 then
					showMe[k] = nil
				end
			end
		end
		Citizen.Wait(1000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SHOWME3D
-----------------------------------------------------------------------------------------------------------------------------------------
function showMe3D(x,y,z,text,h,back,color,opacity)
	SetTextFont(4)
	SetTextCentre(1)
	SetTextEntry("STRING")
	SetTextScale(0.35,0.35)
	SetTextColour(255,255,255,150)
	AddTextComponentString(text)
	SetDrawOrigin(x,y,z,0)
	DrawText(0.0,0.0)
	local factor = (string.len(text) / 375) + 0.01
	DrawRect(0.0,0.0125,factor,0.03,38,42,56,200)
	ClearDrawOrigin()
end
-----------------------------------------------------------------------------------------------------------------------------------------
--[ ABRIR PORTAS DO VEICULO ]------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("portas",function(source,args)
	local vehicle = vRP.getNearestVehicle(7)
	if IsEntityAVehicle(vehicle) then
		if parseInt(args[1]) == 5 then
			TriggerServerEvent("trytrunk",VehToNet(vehicle))
		else
			TriggerServerEvent("trydoors",VehToNet(vehicle),args[1])
		end
	end
end)

RegisterNetEvent("syncdoors")
AddEventHandler("syncdoors",function(index,door)
	if NetworkDoesNetworkIdExist(index) then
		local v = NetToVeh(index)
		local isopen = GetVehicleDoorAngleRatio(v,0) and GetVehicleDoorAngleRatio(v,1)
		if DoesEntityExist(v) then
			if IsEntityAVehicle(v) then
				if door == "1" then
					if GetVehicleDoorAngleRatio(v,0) == 0 then
						SetVehicleDoorOpen(v,0,0,0)
					else
						SetVehicleDoorShut(v,0,0)
					end
				elseif door == "2" then
					if GetVehicleDoorAngleRatio(v,1) == 0 then
						SetVehicleDoorOpen(v,1,0,0)
					else
						SetVehicleDoorShut(v,1,0)
					end
				elseif door == "3" then
					if GetVehicleDoorAngleRatio(v,2) == 0 then
						SetVehicleDoorOpen(v,2,0,0)
					else
						SetVehicleDoorShut(v,2,0)
					end
				elseif door == "4" then
					if GetVehicleDoorAngleRatio(v,3) == 0 then
						SetVehicleDoorOpen(v,3,0,0)
					else
						SetVehicleDoorShut(v,3,0)
					end
				elseif door == nil then
					if isopen == 0 then
						SetVehicleDoorOpen(v,0,0,0)
						SetVehicleDoorOpen(v,1,0,0)
						SetVehicleDoorOpen(v,2,0,0)
						SetVehicleDoorOpen(v,3,0,0)
					else
						SetVehicleDoorShut(v,0,0)
						SetVehicleDoorShut(v,1,0)
						SetVehicleDoorShut(v,2,0)
						SetVehicleDoorShut(v,3,0)
					end
				end
			end
		end
	end
end)

RegisterNetEvent("synctrunk")
AddEventHandler("synctrunk",function(index)
	if NetworkDoesNetworkIdExist(index) then
		local v = NetToVeh(index)
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
end)
-----------------------------------------------------------------------------------------------------------------------------------------
--[ ABRE E FECHA OS VIDROS ]-------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
local vidros = false
RegisterCommand("vidros",function(source,args)
	local vehicle = vRP.getNearestVehicle(7)
	if IsEntityAVehicle(vehicle) then
		TriggerServerEvent("trywins",VehToNet(vehicle))
	end
end)

RegisterNetEvent("syncwins")
AddEventHandler("syncwins",function(index)
	if NetworkDoesNetworkIdExist(index) then
		local v = NetToVeh(index)
		if DoesEntityExist(v) then
			if IsEntityAVehicle(v) then
				if vidros then
					vidros = false
					RollUpWindow(v,0)
					RollUpWindow(v,1)
					RollUpWindow(v,2)
					RollUpWindow(v,3)
				else
					vidros = true
					RollDownWindow(v,0)
					RollDownWindow(v,1)
					RollDownWindow(v,2)
					RollDownWindow(v,3)
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
--[ ABRIR CAPO DO VEICULO ]--------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("capo",function(source,args)
	local vehicle = vRP.getNearestVehicle(7)
	if IsEntityAVehicle(vehicle) then
		TriggerServerEvent("tryhood",VehToNet(vehicle))
	end
end)

RegisterNetEvent("synchood")
AddEventHandler("synchood",function(index)
	if NetworkDoesNetworkIdExist(index) then
		local v = NetToVeh(index)
		local isopen = GetVehicleDoorAngleRatio(v,4)
		if DoesEntityExist(v) then
			if IsEntityAVehicle(v) then
				if isopen == 0 then
					SetVehicleDoorOpen(v,4,0,0)
				else
					SetVehicleDoorShut(v,4,0)
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- /SKIN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("skinmenu")
AddEventHandler("skinmenu",function(mhash)
    while not HasModelLoaded(mhash) do
        RequestModel(mhash)
        Citizen.Wait(10)
    end

    if HasModelLoaded(mhash) then
        SetPlayerModel(PlayerId(),mhash)
        SetModelAsNoLongerNeeded(mhash)
    end
end)



local enableMessages = true
local timeout = 10 * 1000 * 60 -- from ms, to sec, to min

Citizen.CreateThread(function()
    while true do
    	if enableMessages then
    	    TriggerEvent('chat:addMessage',{template='<div style="display:flex;align-items:center;justify-content:center;padding:10px;margin:5px 0;background-image: linear-gradient(to right, rgba(89, 48, 192,0.8) 3%, rgba(89, 48, 192,0) 95%);border-radius: 5px;"><b>DIGITE /ONLINE PARA RECEBER PRÊMIOS E ITENS EXCLUSIVOS</b></div>'})
    	end
    	Citizen.Wait(timeout)
    end
end)

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- SISTEMA DE GRAU
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
local comecar = false
local dict = "rcmextreme2atv"
local anims = {
	"idle_b",
	"idle_c",
	"idle_d",
	"idle_e"
}

Citizen.CreateThread(function()
	while true do 
		local idle = 1000
		local ped = PlayerPedId()
		local bike = GetVehiclePedIsIn(ped)
		local speed = GetEntitySpeed(bike)*3.6
		if comecar == true then
			if IsPedOnAnyBike(ped) then
				if speed >= 5 then
					idle = 5
					while not HasAnimDictLoaded(dict) do 
						Wait(0)
						RequestAnimDict(dict)
					end
	
					if IsControlJustPressed(0,174) or IsControlJustPressed(0,108) then -- Seta Esquerda ou NumPad 4 = Manobra esquerda
						TaskPlayAnim(ped,dict,anims[1], 8.0, -8.0, -1, 32, 0, false, false, false)
						
					elseif IsControlJustPressed(0,175) or IsControlJustPressed(0,107) then -- Seta Direita ou NumPad 6 = Manobra direita
						TaskPlayAnim(ped,dict,anims[2], 8.0, -8.0, -1, 32, 0, false, false, false)
	
					elseif IsControlJustPressed(0,173) or IsControlJustPressed(0,110) then -- Seta para Baixo ou NumPad 5 = Manobra lados
						TaskPlayAnim(ped,dict,anims[3], 8.0, -8.0, -1, 32, 0, false, false, false)
	
					elseif IsControlJustPressed(0,27) or IsControlJustPressed(0,111) then -- Seta para Cima ou NumPad 8 = Manobra cima
						TaskPlayAnim(ped,dict,anims[4], 8.0, -8.0, -1, 32, 0, false, false, false)
					end
				end
			end
		end
		Citizen.Wait(idle)
	end
end)

RegisterCommand("manobras",function(raw,args)
	if comecar == false then
		if vSERVER.checkPermVip() then
			comecar = true
			TriggerEvent("Notify","sucesso","Você está preparado para fazer as manobras")
		else
			TriggerEvent("Notify","negado","Você não tem permissão")
			return false
		end
	else
		comecar = false
		TriggerEvent("Notify","importante","Você está parou de fazer manobras")
	end
end)

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
