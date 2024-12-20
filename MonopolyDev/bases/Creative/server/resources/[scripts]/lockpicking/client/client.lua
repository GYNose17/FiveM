-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
Baixada = {}
Tunnel.bindInterface("lockpicking",Baixada)

local Answer = nil

RegisterNUICallback("succeed", function()
    SetNuiFocus(false, false)
    if Answer then
        Answer:resolve(true)
    end
end)

RegisterNUICallback("failed", function()
    SetNuiFocus(false, false)
    if Answer then
        Answer:resolve(false)
    end
end)

function startLockpick(maxAttempts, difficulty, pins)
    if not maxAttempts then
        maxAttempts = Config.DefaultMaxAttempts
    end
    if not difficulty or type(difficulty) ~= "number" then
        difficulty = Config.DefaultDifficulty
    elseif difficulty > 7 then
        difficulty = 7
    end
    if not pins or type(pins) ~= "number" then
        pins = Config.DefaultPinAmount
    elseif pins > 9 then
        pins = 9
    end
    SendNUIMessage({
        action = "startLockpick",
        data = {maxAttempts = maxAttempts, difficulty = difficulty, pins = pins},
    })
    SetNuiFocus(true, true)

    if Answer then Answer:resolve(false) end

    Answer = promise.new()

    local result = Citizen.Await(Answer)
    Answer = nil

    return result
end

exports('startLockpick', startLockpick)

function Baixada.Task()
	local result = startLockpick()
	return result
end