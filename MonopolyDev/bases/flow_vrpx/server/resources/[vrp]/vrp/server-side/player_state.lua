----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- CARREGAR CONTA QUANDO ENTRAR
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("vRP:playerSpawn",function(user_id,source,first_spawn)
    if user_id then
        local data = vRP.getUserDataTable(user_id)
        local user = vRP.getUserApparence(user_id)

        if first_spawn then
            if data then
                local colete = data.colete or 0
                local weapons = data.weapons or {}
                local health = data.health or 400
                
                Wait(3000)
                if not data.position or data.position == nil then
                    data.position = {}
                end

                if data.weapons == nil then
                    data.weapons = {}
                end

                if data.colete == nil then
                    data.colete = 0
                end

                if data.health == nil then
                    data.health = 300
                end

                if data.hunger == nil then
                    data.hunger = 0
                end

                if data.thirst == nil then
                    data.thirst = 0
                end

                if user then
                    vRPclient._setCustomization(source, user.clothes)
                end

                if user.controller then
                    if user.controller > 0 then
                        TriggerEvent("tattos:init", user_id)
                        TriggerEvent("barbershop:init", user_id)
                    end
                end

                SetTimeout(5000, function() -- 5000
                    local source = vRP.getUserSource(user_id)

                    if source then
                        vRPclient._giveWeapons(source, weapons, true)
                        vRPclient._setHealth(source, parseInt(health))
                        vRPclient._setArmour(source, colete)

                        vRPclient._setJogando(source,true)
                    end
                end)

                vRPclient._teleport(source,data.position.x,data.position.y,data.position.z)
            end
        else
            if user then
                vRPclient._setCustomization(source, user.clothes)
            end
        end
    end
end)

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- UPDATE ACCOUNT
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function tvRP.updatePos(x,y,z)
    local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local data = vRP.getUserDataTable(user_id)
		if data then
			data.position = { x = tonumber(x), y = tonumber(y), z = tonumber(z) }
		end
	end
end

function tvRP.updateArmor(armor)
	local user_id = vRP.getUserId(source)
	if user_id then
		local data = vRP.getUserDataTable(user_id)
		if data then
			data.colete = armor
		end
	end
end

function tvRP.updateWeapons(weapons)
	local user_id = vRP.getUserId(source)
	if user_id then
		local data = vRP.getUserDataTable(user_id)
		if data then
			data.weapons = weapons
		end
	end
end

function tvRP.updateHealth(health)
	local user_id = vRP.getUserId(source)
	if user_id then
		local data = vRP.getUserDataTable(user_id)
		if data then
			data.health = health
		end
	end
end

function tvRP.updateClothes(clothes)
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
        vRP.execute("apparence/roupas",{ user_id = user_id, roupas = json.encode(clothes) })
        vRP.updateUserApparence(user_id, "clothes", clothes)
    end
end
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- CLEAR ACCOUNT
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function vRP.clearAccount(user_id)
    local source = vRP.getUserSource(user_id)
    if user_id then
        local data = vRP.getUserDataTable(user_id)

        data.inventory = {}
        data.weapons = {}

        vRP.clearInventory(user_id)
		vRPclient._setHandcuffed(source,false)
        vRPclient._replaceWeapons(source,{})

        if not vRP.hasPermission(user_id,"perm.mochila") then
            data.mochila = { quantidade = 0, perder = 0 }
        end
    end
end


----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- BLOCK COMMANDS
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
local time = {
    users = {}
}

function time:set(user_id, segundos)
    if segundos > 0 then
        self.users[user_id] = ( os.time() + segundos )
        return
    end

    if self.users[user_id] then
        self.users[user_id] = nil
    end
end

function time:check(user_id)
    if self.users[user_id] then
        if (self.users[user_id] - os.time()) <= 0 then
            self.users[user_id] = nil
            return true
        end

        TriggerClientEvent("Notify", vRP.getUserSource(user_id),"negado","Você precisa esperar <b>"..(self.users[user_id] - os.time()).." segundo(s)</b> para executar essa ação.", 5)
        return false
    end

    return true
end

Citizen.CreateThread(function()
    while true do
        for k in pairs(time.users) do
            if time.users[k] then
                if (time.users[k] - os.time()) <= 0 then
                    time.users[k] = nil
                end
            end
        end

        Wait(5 * 60 * 1000)
    end
end)

exports("setBlockCommand", function(...)
    return time:set(...)
end)

exports("checkCommand", function(...)
    return time:check(...)
end)