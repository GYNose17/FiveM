------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- HEALTH SYSTEM
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function tvRP.varyHealth(variation)
    local ped = PlayerPedId()
    local n = math.floor(GetEntityHealth(ped)+variation)
    SetEntityHealth(ped,n)
end

function tvRP.getHealth()
    return GetEntityHealth(PlayerPedId())
end

function tvRP.setHealth(health)
    local n = math.floor(health)
    SetEntityHealth(PlayerPedId(),n)
end

function tvRP.setFriendlyFire(flag)
    NetworkSetFriendlyFireOption(flag)
    SetCanAttackFriendly(PlayerPedId(),flag,flag)
end

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- flow SURVIVAL
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
local isComa = false

AddEventHandler("flow_survival:updateComa", function(boolean)
    isComa = boolean
end)

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- FOME E SEDE
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- function tvRP.sedeFome()
-- 	vRPserver.varyHunger(-100)
-- end

-- Citizen.CreateThread(function()
-- 	while true do
-- 		Citizen.Wait(6000)
-- 		if IsPlayerPlaying(PlayerId()) then
-- 			local ped = PlayerPedId()
-- 			local vthirst = 0.1
-- 			local vhunger = 0.1

-- 			if IsPedOnFoot(ped) then
-- 				local factor = math.min(tvRP.getSpeed(),0.001)

-- 				vthirst = vthirst+0.1*factor
-- 				vhunger = vhunger+0.1*factor
-- 			end

-- 			if IsPedInMeleeCombat(ped) then
-- 				vthirst = vthirst+0.1
-- 				vhunger = vhunger+0.1
-- 			end

-- 			if IsPedHurt(ped) or IsPedInjured(ped) then
-- 				vthirst = vthirst+0.1
-- 				vhunger = vhunger+0.1
-- 			end

-- 			if vthirst > 0 then
-- 				vRPserver.varyThirst(vthirst/0.1)
-- 			end

-- 			if vhunger > 0 then
-- 				vRPserver.varyHunger(vhunger/0.1)
-- 			end

-- 		end
-- 	end
-- end)

function tvRP.sedeFome()
	vRPserver.varyHunger(-100)
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10000) -- Aumenta o tempo de espera para 10 segundos

		if IsPlayerPlaying(PlayerId()) then
			local ped = PlayerPedId()
			local vthirst = 0.1 -- Valor inicial de sede
			local vhunger = 0.1 -- Valor inicial de fome

			if IsPedOnFoot(ped) then
				local factor = math.min(tvRP.getSpeed(), 0.001)
				vthirst = vthirst + 0.05 * factor -- Reduz o incremento de sede
				vhunger = vhunger + 0.05 * factor -- Reduz o incremento de fome
			end

			if IsPedInMeleeCombat(ped) then
				vthirst = vthirst + 0.1 -- Mantém o incremento de sede
				vhunger = vhunger + 0.1 -- Mantém o incremento de fome
			end

			if IsPedHurt(ped) or IsPedInjured(ped) then
				vthirst = vthirst + 0.1 -- Mantém o incremento de sede
				vhunger = vhunger + 0.1 -- Mantém o incremento de fome
			end

			if vthirst > 0 then
				vRPserver.varyThirst(vthirst / 0.1) -- Normaliza o valor de sede
			end

			if vhunger > 0 then
				vRPserver.varyHunger(vhunger / 0.1) -- Normaliza o valor de fome
			end
		end
	end
end)


----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- FUNCTIONS
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
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
