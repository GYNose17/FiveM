local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

src = {}
Tunnel.bindInterface("bm_daily",src)
Proxy.addInterface("bm_daily",src)

vCLIENT = Tunnel.getInterface("bm_daily")

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- QUERYS
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
vRP._prepare("bm_daily/setHour","REPLACE INTO bm_daily(user_id,time) VALUES(@user_id, @time)")
vRP._prepare("bm_daily/getHour", "SELECT time FROM bm_daily WHERE user_id = @user_id")
vRP._prepare("bm_daily/getTopHour", "SELECT nome,sobrenome,total_hour FROM vrp_user_identities ORDER BY total_hour DESC LIMIT 5;")
vRP._prepare("bm_daily/setAllHour", "UPDATE vrp_user_identities SET total_hour = total_hour + @time WHERE user_id = @user_id")
vRP._prepare("bm_daily/createTable", "CREATE TABLE IF NOT EXISTS `bm_daily` ( `user_id` int(11) NOT NULL DEFAULT 0, `time` int(11) DEFAULT NULL, PRIMARY KEY (`user_id`) ) ENGINE=InnoDB DEFAULT CHARSET=latin1;")
vRP._prepare("bm_daily/WipeTable", "DELETE from bm_daily")

async(function()
    if config.createTable then
        vRP._execute("bm_daily/createTable", {})
    end

    vRP._execute("bm_daily/WipeTable", {})
end)
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- FUNCTIONS DAILY
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
local daily = {
    users = {}
}

function daily:Set(user_id, time)
    self.users[user_id] = { time = time }
end

function daily:Rem(user_id)
    if self.users[user_id] then
        self.users[user_id] = nil
    end
end

function daily:getUserTime(user_id)
    if not self.users[user_id] then
        daily:Set(user_id, 0)
    end

    return self.users[user_id].time
end

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- FUNCTIONS CRATE
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
local crates = {
    users = {},
    userOpenneds = {}
}

function crates:Set(user_id, nivel)
    self.users[user_id] = { time = os.time(), crate = nivel }
end

function crates:Level(user_id)
    if not self.users[user_id] then
        self.users[user_id] = { time = 0, crate = 1 }
    end

    return self.users[user_id]
end

function crates:SetOpenned(user_id, id, item)
    self.userOpenneds[user_id] = { id = id, item = item }
end

function crates:GetOpenned(user_id)
    if not self.userOpenneds[user_id] then
        self.userOpenneds[user_id] = { id = 1, item = "none" }
    end

    return self.userOpenneds[user_id]
end

src.openChest = function()
    local source = source
    local user_id = vRP.getUserId(source)
    
    if user_id then
        local user = crates:Level(user_id)
        local userTime = daily:getUserTime(user_id)

        if user ~= nil then
            if (os.time() - user.time) < 15 then
                TriggerClientEvent("Notify",source,"negado","Aguarde para abrir uma caixa novamente...")
                return
            end

            if user.crate > #config.recompensas then
                TriggerClientEvent("Notify",source,"sucesso","Você já abriu todas as caixas...")
                return
            end

            if userTime < config.recompensas[user.crate].time then
                TriggerClientEvent("Notify",source,"sucesso","Você não possui o tempo necessario para abrir essa caixa...")
                return
            end

            local percentual = math.random(0,100)
            itensDisponiveis = {}
            for k,v in pairs(config.recompensas[user.crate].rewards) do
                if percentual <= v.chance then
                    itensDisponiveis[#itensDisponiveis + 1] = { item = v.item, nome = v.nome, amount = v.amount, notify = v.notify }
                end
            end

            if #itensDisponiveis > 0 then
                local random = math.random(1,#itensDisponiveis)
                local win = itensDisponiveis[random]        
                if win.notify then
                    local identity = vRP.getUserIdentity(user_id)
                    if identity then
                        TriggerClientEvent('chat:addMessage',-1,{template='<div style="display:flex;align-items:center;justify-content:center;padding:10px;margin:5px 0;background-image: linear-gradient(to right, rgba(255, 111, 156,1) 3%, rgba(255, 168, 82,0) 95%);border-radius: 5px;"><img width="32" style="float: left;" src="https://cdn.discordapp.com/attachments/863971735145545758/888308945305886740/treasure-chest.png">'..identity.nome..' '..identity.sobrenome..' Ganhou (<b>'..win.nome..' '..win.amount..'x)</b></div>'})
                    end
                end

                vRP.giveInventoryItem(user_id, win.item, win.amount, true)

                crates:SetOpenned(user_id, user.crate + 1, win.item)
                crates:Set(user_id, user.crate + 1)
            end
        end
    end
end

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- OTHERS FUNCTIONS
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
local checkHackers = {}
function src.updateTime()
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
        if not checkHackers[source] then checkHackers[source] = 0 end

        if (os.time() - checkHackers[source]) < 50 then
            print("ID: "..user_id.. " Possivel Tentativa de Injetar Horas. ( "..os.time() - checkHackers[source].. " )")
            return
        end
        checkHackers[source] = os.time()

        local userTime = daily:getUserTime(user_id)
        daily:Set(user_id, userTime + 1)
    end
end

function src.GetItensCaixa()
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
        local myCrate = crates:Level(user_id).crate
        if myCrate then
            if myCrate <= 0 or myCrate ~= nil then
                myCrate = 1
            end
            
            return config.recompensas[parseInt(myCrate)].rewards
        end
    end
end

function src.GetRanking()
    local source = source
    local user_id = vRP.getUserId(source)
    local rankList = {}

    if user_id then
        local topHours = vRP.query("bm_daily/getTopHour", { })
        if #topHours > 0 then
            for k in pairs(topHours) do
                rankList[k] = { nome = topHours[k].nome.. " " ..topHours[k].sobrenome, hours = topHours[k].total_hour }
            end
        end

        return rankList
    end
end

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- COMMANDS
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('online', function(source,args)
    local user_id = vRP.getUserId(source)

    if user_id then
        local myCrate = crates:Level(user_id).crate
        local infos = {}

        if myCrate > #config.recompensas then
            infos = {
                myTime = daily:getUserTime(user_id),
                itensCaixa = {},
                timeCaixa = 1440,
                lastOpenned = crates:GetOpenned(user_id),
                totalCaixa = #config.recompensas
            }
        else
            infos = {
                myTime = daily:getUserTime(user_id),
                itensCaixa = config.recompensas[parseInt(myCrate)].rewards,
                timeCaixa = config.recompensas[parseInt(myCrate)].time,
                lastOpenned = crates:GetOpenned(user_id),
                totalCaixa = #config.recompensas
            }
        end

        vCLIENT._openNui(source, infos)
    end
end)

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- EVENTOS
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("vRP:playerSpawn",function(user_id,source,first_spawn)
    if user_id then
        if user_id then
            local myTime = vRP.query("bm_daily/getHour", { user_id = user_id })
            if #myTime > 0 then
                print(user_id, myTime[1].time)
                daily:Set(user_id, myTime[1].time)
                return
            end
    
            daily:Set(user_id, 0)
        end
    end
end)

AddEventHandler("playerDropped", function()
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
        vRP._execute("bm_daily/setHour", { user_id = user_id, time = daily:getUserTime(user_id)  })
        vRP._execute("bm_daily/setAllHour", { user_id = user_id, time = daily:getUserTime(user_id) })
        
        daily:Rem(user_id)
    end
end)