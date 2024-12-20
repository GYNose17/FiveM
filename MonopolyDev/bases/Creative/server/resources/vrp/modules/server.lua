Sources = {}
Characters = {}
CharactersArena = {}
GlobalState["Players"] = {}
local Players = {}
local Prepares = {}

local Global = {}
local Salary = {}
local srvData = {}

Objects = {}
local Timer = { ["Weed"] = {}, ["Chemical"] = {}, ["Alcohol"] = {} }

function vRP.Query(Name, Params)
    return exports["oxmysql"]:query_async(Prepares[Name], Params)
end

function vRP.Prepare(Name, Query)
    Prepares[Name] = Query
end

function vRP.Identities(source)
    local Result = false

    local Identifiers = GetPlayerIdentifiers(source)
    for _, v in pairs(Identifiers) do
        if string.find(v, BaseMode) then
            local SplitName = splitString(v, ":")
            Result = SplitName[2]
            break
        end
    end

    return Result
end

function vRP.Archive(Archive, Text)
    Archive = io.open(Archive, "a")
    if Archive then
        Archive.write(Archive, Text .. "\n")
    end
    Archive.close(Archive)
end

function vRP.Banned(License)
    local Consult = vRP.Query("banneds/GetBanned", { License = License })
    if Consult and Consult[1] then
        if Consult[1].Time <= os.time() then
            vRP.Query("banneds/RemoveBanned", { License = License })
            return false
        end
        return true
    end
    return false
end

function CheckToken(source, License)
    for _, Token in pairs(GetPlayerTokens(source)) do
        if vRP.Query("banneds/GetToken", { Token = Token })[1] then
            return false
        end
        vRP.Query("banneds/InsertToken", { Token = Token, License = License })
    end
    return true
end

function vRP.Account(License)
    return vRP.Query("accounts/Account", { License = License })[1] or false
end

function vRP.UserData(Passport, Key)
    local Consult = vRP.Query("playerdata/GetData", { Passport = Passport, Name = Key })
    if Consult and Consult[1] then
        return json.decode(Consult[1].Information)
    end
    return {}
end

function vRP.InsidePropertys(Passport, Coords)
    local Datatable = vRP.Datatable(Passport)
    if Datatable then
        Datatable.Pos = { x = mathLength(Coords.x), y = mathLength(Coords.y), z = mathLength(Coords.z) }
    end
end

function vRP.Inventory(Passport)
    local Datatable = vRP.Datatable(Passport)
    if Datatable then
        if not Datatable.Inventory then
            Datatable.Inventory = {}
        end
        return Datatable.Inventory
    end
    return {}
end

function vRP.SaveTemporary(Passport, source, Route)
    local Ped = GetPlayerPed(source)
    local Datatable = vRP.Datatable(Passport)
    if not CharactersArena[Passport] and Datatable then
        CharactersArena[Passport] = {}
        CharactersArena[Passport].Inventory = Datatable.Inventory
        CharactersArena[Passport].Health = GetEntityHealth(Ped)
        CharactersArena[Passport].Armour = GetPedArmour(Ped)
        CharactersArena[Passport].Stress = Datatable.Stress
        CharactersArena[Passport].Hunger = Datatable.Hunger
        CharactersArena[Passport].Thirst = Datatable.Thirst
        CharactersArena[Passport].route = Route

        SetPedArmour(Ped, 100)
        vRPC.SetHealth(source, 200)
        vRP.UpgradeHunger(Passport, 100)
        vRP.UpgradeThirst(Passport, 100)
        vRP.DowngradeStress(Passport, 100)

        TriggerEvent("inventory:saveTemporary", Passport)

        Datatable.Inventory = {}
        for Number, v in pairs(ArenaItens) do
            vRP.GenerateItem(Passport, Number, v, false)
        end

        TriggerEvent("vRP:BucketServer", source, "Enter", Route)
    end
end

function vRP.ApplyTemporary(Passport, source)
    local Datatable = vRP.Datatable(Passport)
    if CharactersArena[Passport] and Datatable then
        Datatable.Inventory = {}
        Datatable.Inventory = CharactersArena[Passport].Inventory
        Datatable.Stress = CharactersArena[Passport].Stress
        Datatable.Hunger = CharactersArena[Passport].Hunger
        Datatable.Thirst = CharactersArena[Passport].Thirst
        TriggerClientEvent("hud:Thirst", source, Datatable.Thirst)
        TriggerClientEvent("hud:Hunger", source, Datatable.Hunger)
        TriggerClientEvent("hud:Stress", source, Datatable.Stress)
        SetPedArmour(GetPlayerPed(source), CharactersArena[Passport].Armour)
        vRPC.SetHealth(source, CharactersArena[Passport].Health)
        TriggerEvent("inventory:applyTemporary", Passport)
        TriggerEvent("vRP:BucketServer", source, "Exit")
        CharactersArena[Passport] = nil
    end
end

function vRP.SkinCharacter(Passport, Hash)
    local Datatable = vRP.Datatable(Passport)
    if Datatable then
        Datatable.Skin = Hash
    end
end

function vRP.Passport(source)
    if Characters[source] then
        return Characters[source].id
    end
    return false
end

function vRP.Players()
    return Sources
end

function vRP.Source(Passport)
    return Sources[parseInt(Passport)] or false
end

function vRP.Datatable(Passport)
    if Characters[Sources[parseInt(Passport)]] then
        return Characters[Sources[parseInt(Passport)]].table
    end
    return false
end

function vRP.Kick(source, Reason)
    DropPlayer(source, Reason)
end

AddEventHandler("playerDropped", function(Reason)
    if Characters[source] and DoesEntityExist(GetPlayerPed(source)) then
        Disconnect(source, GetEntityHealth(GetPlayerPed(source)), GetPedArmour(GetPlayerPed(source)),
            GetEntityCoords(GetPlayerPed(source)), Reason)
    end
end)

function Disconnect(source, Health, Armour, Coords, Reason)
    local Passport = vRP.Passport(source)
    local Datatable = vRP.Datatable(Passport)
    if Passport then
        exports["vrp"]:Embed("Disconnect", "**Source:** " .. source .. [[

**Passaporte:** ]] .. Passport .. [[

**Health:** ]] .. Health .. [[

**Armour:** ]] .. Armour .. [[

**Cds:** ]] .. Coords .. [[

**Motivo:** ]] .. Reason, 3092790)
        if Datatable then
            if CharactersArena[Passport] then
                Datatable.Stress = CharactersArena[Passport].Stress
                Datatable.Hunger = CharactersArena[Passport].Hunger
                Datatable.Thirst = CharactersArena[Passport].Thirst
                Datatable.Armour = CharactersArena[Passport].Armour
                Datatable.Health = CharactersArena[Passport].Health
                Datatable.Inventory = CharactersArena[Passport].Inventory
                Datatable.Pos = { x = BackArenaPos.x, y = BackArenaPos.y, z = BackArenaPos.z }
                TriggerEvent("arena:Players", "-", CharactersArena[Passport].route)
                CharactersArena[Passport] = nil
            else
                Datatable.Health = Health
                Datatable.Armour = Armour
                Datatable.Pos = {
                    x = mathLength(Coords.x),
                    y = mathLength(Coords.y),
                    z = mathLength(
                        Coords.z)
                }
            end
            if Datatable.Health <= 100 then
                TriggerClientEvent("hud:Textform", -1, Coords,
                    "<b>Passaporte:</b> " .. Passport .. "<br><b>Motivo:</b> " .. Reason,
                    CombatLogMinutes * 60000)
            end
            TriggerEvent("Disconnect", Passport, source)

            vRP.Query("playerdata/SetData",
                { Passport = Passport, Name = "Datatable", Information = json.encode(Datatable) })
            Characters[source] = nil
            Sources[Passport] = nil
            if GlobalState.Players[source] and Players[source] then
                Players[source] = nil
                GlobalState.Players = Players
                GlobalState:set("Players", GlobalState.Players, true)
            end
        end
    end
end

AddEventHandler("SaveServer", function()
    for k, _ in pairs(Sources) do
        local Datatable = vRP.Datatable(k)
        if Datatable then
            vRP.Query("playerdata/SetData",
                { Passport = k, Name = "Datatable", Information = json.encode(Datatable) })
        end
    end
end)

AddEventHandler("Queue:Connecting", function(source, identifiers, deferrals)
    deferrals.defer()
    local Identity = vRP.Identities(source)
    if Identity then
        local Account = vRP.Account(Identity)
        if not Account then
            vRP.Query("accounts/NewAccount", { License = Identity })
        end
        if Maintenance then
            if MaintenanceLicenses[Identity] then
                deferrals.done()
            else
                deferrals.done(MaintenanceText)
            end
        elseif not vRP.Banned(Identity) then
            Account = vRP.Account(Identity)
            if Whitelisted then
                if Account["Whitelist"] then
                    deferrals.done()
                else
                    deferrals.done(ReleaseText .. ": " .. Account["id"])
                end
            else
                deferrals.done()
            end
        else
            CheckToken(Identity)
            deferrals.done(BannedText .. ".")
        end
    else
        deferrals.done("Conexão perdida.")
    end
    TriggerEvent("Queue:Remove", identifiers)
end)

function vRP.CharacterChosen(source, Passport, Model)
    Sources[Passport] = source
    if not Characters[source] then
        local Query = vRP.Query("characters/Person", { id = Passport })
        local Identity = vRP.Identities(source)
        local Account = vRP.Account(Identity)
        if #Query > 0 then
            Characters[source] = {}
            Characters[source].id = Query[1]["id"]
            Characters[source].License = Query[1]["License"]
            Characters[source].Phone = Query[1]["Phone"]
            Characters[source].Name = Query[1]["Name"]
            Characters[source].Lastname = Query[1]["Lastname"]
            Characters[source].Sex = Query[1]["Sex"]
            Characters[source].Bank = Query[1]["Bank"]
            Characters[source].Blood = Query[1]["Blood"]
            Characters[source].Medic = Query[1]["Medic"]
            Characters[source].Fines = Query[1]["Fines"]
            Characters[source].Taxs = Query[1]["Taxs"]
            Characters[source].Gun = Query[1]["Gun"]
            Characters[source].Driver = Query[1]["Driver"]
            Characters[source].Prison = Query[1]["Prison"]
            Characters[source].Deleted = Query[1]["Deleted"]
            Characters[source].Rolepass = Account["Rolepass"]
            Characters[source].Premium = Account["Premium"]
            Characters[source].Discord = Account["Discord"]
            Characters[source].Characters = Account["Characters"]
            Characters[source].table = vRP.UserData(Passport, "Datatable")

            Players[source] = { Passport, Query[1]["Name"] .. " " .. Query[1]["Lastname"] }
            GlobalState.Players = Players

            GlobalState:set("Players", GlobalState.Players, true)
        end
        if Model then
            Characters[source].table.Skin = Model
            Characters[source].table.Inventory = {}
            for k, v in pairs(CharacterItens) do
                vRP.GenerateItem(Passport, k, v, false)
            end
            if NewItemIdentity then
                vRP.GenerateItem(Passport, "identity-" .. Passport, 1, false)
            end
            vRP.Query("playerdata/SetData",
                {
                    Passport = Passport,
                    Name = "Barbershop",
                    Information = json.encode({ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
                        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 })
                })

            vRP.Query("playerdata/SetData",
                { Passport = Passport, Name = "Clothings", Information = json.encode(StartClothes[Model]) })

            vRP.Query("playerdata/SetData",
                {
                    Passport = Passport,
                    Name = "Datatable",
                    Information = json.encode(Characters[source]
                        .table)
                })
        end
        if Account.Gemstone > 0 then
            TriggerClientEvent("hud:AddGemstone", source, Account.Gemstone)
        end
        exports["vrp"]:Embed("Connect", "**Source:** " .. source .. [[

**Passaporte:** ]] .. Passport .. [[

**Nome:** ]] .. vRP.FullName(Passport) .. [[

**Address:** ]] .. GetPlayerEndpoint(source), 3092790)
    end
    TriggerEvent("CharacterChosen", Passport, source)
end

CreateThread(function()
    SetMapName(ServerName)
    SetGameType(ServerName)
    SetRoutingBucketEntityLockdownMode(0, EntityLockdown)
end)

AddEventHandler("vRP:Rewards", function(source)
    local Date = parseInt(os.date("%d"))
    if Characters[source] and Characters[source].Rolepass > 0 and Date > Characters[source].Rolepass and Rewards[Date] then
        vRP.GenerateItem(Characters[source].id, Rewards[Date].item, Rewards[Date].amount, false)
        TriggerClientEvent("inventory:Update", source, "Backpack")
        if Date >= 30 then
            vRP.UpdateRolepass(source, 0)
        else
            vRP.UpdateRolepass(source, Date)
        end
    end
end)

AddEventHandler("vRP:ActivePass", function(source)
    if Characters[source] then
        local Date = parseInt(os.date("%d"))
        for k = 1, Date do
            if Rewards[Date] then
                vRP.GenerateItem(Characters[source].id, Rewards[k].item, Rewards[k].amount, false)
                TriggerClientEvent("inventory:Update", source, "Backpack")
            end
        end
        if Date >= 30 then
            vRP.UpdateRolepass(source, 0)
        else
            vRP.UpdateRolepass(source, Date)
        end
    end
end)

function getQueue(ids, trouble, source, connect)
    for k, v in ipairs(connect and Queue.Connecting or Queue.List) do
        local inQueue = false

        if not source then
            for _, i in ipairs(v["ids"]) do
                if inQueue then
                    break
                end

                for _, o in ipairs(ids) do
                    if o == i then
                        inQueue = true
                        break
                    end
                end
            end
        else
            inQueue = ids == v["source"]
        end

        if inQueue then
            if trouble then
                return k, connect and Queue.Connecting[k] or Queue.List[k]
            end

            return true
        end
    end

    return false
end

function LicenseRunning(source)
    local result = false
    local identifiers = GetPlayerIdentifiers(source)
    for _, v in pairs(identifiers) do
        if string.find(v, BaseMode) then
            result = true
            break
        end
    end

    return result
end

function CheckPriority(player)
    for _, identifier in pairs(GetPlayerIdentifiers(player)) do
        if string.find(identifier, BaseMode) and vRP.LicensePremium(splitString(identifier, ":")[2]) then
            break
        end
    end

    return 10
end

function addQueue(ids, connectTime, name, source, deferrals)
    if getQueue(ids) then
        return
    end

    local tmp = {
        source = source,
        ids = ids,
        name = name,
        firstconnect = connectTime,
        priority = CheckPriority(ids),
        timeout = 0,
        deferrals = deferrals
    }

    local _pos = false
    local queueCount = #Queue.List + 1

    for k, v in ipairs(Queue.List) do
        if tmp["priority"] then
            if not v["priority"] then
                _pos = k
            else
                if tmp["priority"] > v["priority"] then
                    _pos = k
                end
            end

            if _pos then
                break
            end
        end
    end

    if not _pos then
        _pos = #Queue.List + 1
    end

    table.insert(Queue.List, _pos, tmp)
end

function removeQueue(ids, source)
    if getQueue(ids, false, source) then
        local pos, data = getQueue(ids, true, source)
        table.remove(Queue.List, pos)
    end
end

function isConnect(ids, source, refresh)
    local k, v = getQueue(ids, refresh and true or false, source and true or false, true)

    if not k then
        return false
    end

    if refresh and k and v then
        Queue.Connecting[k]["timeout"] = 0
    end

    return true
end

function removeConnect(ids, source)
    for k, v in ipairs(Queue.Connecting) do
        local connect = false

        if not source then
            for _, i in ipairs(v["ids"]) do
                if connect then
                    break
                end

                for _, o in ipairs(ids) do
                    if o == i then
                        connect = true
                        break
                    end
                end
            end
        else
            connect = ids == v["source"]
        end

        if connect then
            table.remove(Queue.Connecting, k)
            return true
        end
    end

    return false
end

function addConnect(ids, ignorePos, autoRemove, done)
    local function removeFromQueue()
        if not autoRemove then
            return
        end

        done(Lang.Error)
        removeConnect(ids)
        removeQueue(ids)
    end

    if #Queue.Connecting >= 100 then
        removeFromQueue()
        return false
    end

    if isConnect(ids) then
        removeConnect(ids)
    end

    local pos, data = getQueue(ids, true)
    if not ignorePos and (not pos or pos > 1) then
        removeFromQueue()
        return false
    end

    table.insert(Queue.Connecting, data)
    removeQueue(ids)

    return true
end

function steamIds(source)
    return GetPlayerIdentifiers(source)
end

function updateData(source, ids, deferrals)
    local pos, data = getQueue(ids, true)
    Queue.List[pos]["ids"] = ids
    Queue.List[pos]["timeout"] = 0
    Queue.List[pos]["source"] = source
    Queue.List[pos]["deferrals"] = deferrals
end

function notFull(firstJoin)
    local canJoin = Queue.Counts + #Queue.Connecting < Queue.Max and #Queue.Connecting < 100
    if firstJoin and canJoin then
        canJoin = #Queue.List <= 1
    end

    return canJoin
end

function setPosition(ids, newPos)
    local pos, data = getQueue(ids, true)
    table.remove(Queue.List, pos)
    table.insert(Queue.List, newPos, data)
end

CreateThread(function()
    local function playerConnect(name, setKickReason, deferrals)
        local source = source
        local ids = steamIds(source)
        local connecting = true
        local connectTime = os.time()
        deferrals.defer()

        CreateThread(function()
            while connecting do
                Wait(500)
                if not connecting then
                    return
                end

                deferrals.update(Lang.Connecting)
            end
        end)

        Wait(1000)
        local function done(message)
            connecting = false
            CreateThread(function()
                if message then
                    deferrals.update(tostring(message) and tostring(message) or "")
                end

                Wait(1000)

                if message then
                    deferrals.done(tostring(message) and tostring(message) or "")
                    CancelEvent()
                end
            end)
        end

        local function update(message)
            connecting = false
            deferrals.update(tostring(message) and tostring(message) or "")
        end

        if not LicenseRunning(source) then
            done("Você esta sem sua steam ou algum dos nossos identificadores abertos.")
            CancelEvent()
            return
        end

        local reason = "Removido da fila."

        local function setReason(message)
            reason = tostring(message)
        end

        TriggerEvent("Queue:playerJoinQueue", source, setReason)

        if WasEventCanceled() then
            done(reason)

            removeQueue(ids)
            removeConnect(ids)

            CancelEvent()
            return
        end

        if getQueue(ids) then
            rejoined = true
            updateData(source, ids, deferrals)
        else
            addQueue(ids, connectTime, name, source, deferrals)
        end

        if isConnect(ids, false, true) then
            removeConnect(ids)

            if notFull() then
                local added = addConnect(ids, true, true, done)
                if not added then
                    CancelEvent()
                    return
                end

                done()
                TriggerEvent("Queue:Connecting", source, ids, deferrals)

                return
            else
                addQueue(ids, connectTime, name, source, deferrals)
                setPosition(ids, 1)
            end
        end

        local pos, data = getQueue(ids, true)

        if not pos or not data then
            done(Lang.Error)
            RemoveFromQueue(ids)
            RemoveFromConnecting(ids)
            CancelEvent()
            return
        end

        if notFull(true) then
            local added = addConnect(ids, true, true, done)
            if not added then
                CancelEvent()
                return
            end

            done()

            TriggerEvent("Queue:Connecting", source, ids, deferrals)

            return
        end

        update(string.format(Lang.Position, pos, #Queue.List))

        CreateThread(function()
            if rejoined then
                return
            end

            Queue.Threads = Queue.Threads + 1
            local dotCount = 0

            while true do
                Wait(1000)
                local dots = ""

                dotCount = dotCount + 1
                if dotCount > 3 then
                    dotCount = 0
                end

                for i = 1, dotCount do
                    dots = dots .. "."
                end

                local pos, data = getQueue(ids, true)

                if not pos or not data then
                    if data and data.deferrals then
                        data.deferrals.done(Lang.Error)
                    end

                    CancelEvent()
                    removeQueue(ids)
                    removeConnect(ids)
                    Queue.Threads = Queue.Threads - 1
                    return
                end

                if pos <= 1 and notFull() then
                    local added = addConnect(ids)
                    data.deferrals.update(Lang.Join)
                    Wait(500)

                    if not added then
                        data.deferrals.done(Lang.Error)
                        CancelEvent()
                        Queue.Threads = Queue.Threads - 1
                        return
                    end

                    data.deferrals.update("Carregando conexão com o servidor.")

                    removeQueue(ids)
                    Queue.Threads = Queue.Threads - 1

                    TriggerEvent("Queue:Connecting", source, data.ids, data.deferrals)

                    return
                end

                local message = string.format(
                    ServerName .. "\n\n" ..
                    Lang.Position ..
                    "%s\nEvite punições, fique por dentro das regras de conduta.\nAtualizações frequentes, deixe sua sugestão em nosso discord.",
                    pos, #Queue.List, dots)
                data.deferrals.update(message)
            end
        end)
    end

    AddEventHandler("playerConnecting", playerConnect)

    local function checkTimeOuts()
        local i = 1

        while i <= #Queue.List do
            local data = Queue.List[i]
            local lastMsg = GetPlayerLastMsg(data.source)

            if lastMsg == 0 or lastMsg >= 30000 then
                data.timeout = data.timeout + 1
            else
                data.timeout = 0
            end

            if not data.ids or not data.name or not data.firstconnect or data.priority == nil or not data.source then
                data.deferrals.done(Lang.Error)
                table.remove(Queue.List, i)
            elseif (data.timeout >= 120) and os.time() - data.firstconnect > 5 then
                data.deferrals.done(Lang.Error)
                removeQueue(data.source, true)
                removeConnect(data.source, true)
            else
                i = i + 1
            end
        end

        i = 1

        while i <= #Queue.Connecting do
            local data = Queue.Connecting[i]
            local lastMsg = GetPlayerLastMsg(data.source)
            data.timeout = data.timeout + 1

            if ((data.timeout >= 300 and lastMsg >= 35000) or data.timeout >= 340) and os.time() - data.firstconnect > 5 then
                removeQueue(data.source, true)
                removeConnect(data.source, true)
            else
                i = i + 1
            end
        end

        SetTimeout(1000, checkTimeOuts)
    end

    checkTimeOuts()
end)

RegisterServerEvent("Queue:Connect")
AddEventHandler("Queue:Connect", function()
    local source = source

    if not Queue.Players[source] then
        local ids = steamIds(source)
        Queue.Counts = Queue.Counts + 1
        Queue.Players[source] = true
        removeQueue(ids)
        removeConnect(ids)
    end
end)

AddEventHandler("playerDropped", function()
    local source = source

    if Queue.Players[source] then
        local ids = steamIds(source)

        Queue.Counts = Queue.Counts - 1
        Queue.Players[source] = nil
        removeQueue(ids)
        removeConnect(ids)
    end
end)

AddEventHandler("Queue:remove", function(ids)
    removeQueue(ids)
    removeConnect(ids)
end)

function vRP.WeedReturn(Passport)
    if Timer["Weed"][Passport] then
        if os.time() < Timer["Weed"][Passport] then
            return parseInt(Timer["Weed"][Passport] - os.time())
        else
            Timer["Weed"][Passport] = nil
        end
    end
    return 0
end

function vRP.WeedTimer(Passport, Time)
    if Timer["Weed"][Passport] then
        Timer["Weed"][Passport] = Timer["Weed"][Passport] + Time * 60
    else
        Timer["Weed"][Passport] = os.time() + Time * 60
    end
end

function vRP.ChemicalReturn(Passport)
    if Timer["Chemical"][Passport] then
        if os.time() < Timer["Chemical"][Passport] then
            return parseInt(Timer["Chemical"][Passport] - os.time())
        else
            Timer["Chemical"][Passport] = nil
        end
    end
    return 0
end

function vRP.ChemicalTimer(Passport, Time)
    if Timer["Chemical"][Passport] then
        Timer["Chemical"][Passport] = Timer["Chemical"][Passport] + Time * 60
    else
        Timer["Chemical"][Passport] = os.time() + Time * 60
    end
end

function vRP.AlcoholReturn(Passport)
    if Timer["Alcohol"][Passport] then
        if os.time() < Timer["Alcohol"][Passport] then
            return parseInt(Timer["Alcohol"][Passport] - os.time())
        else
            Timer["Alcohol"][Passport] = nil
        end
    end
    return 0
end

function vRP.AlcoholTimer(Passport, Time)
    if Timer["Alcohol"][Passport] then
        Timer["Alcohol"][Passport] = Timer["Alcohol"][Passport] + Time * 60
    else
        Timer["Alcohol"][Passport] = os.time() + Time * 60
    end
end

function vRP.FalseIdentity(Passport)
    return vRP.Query("fidentity/Result", { id = Passport })[1] or false
end

function vRP.Identity(Passport)
    local source = vRP.Source(Passport)
    if Characters[source] then
        return Characters[source] or false
    else
        return vRP.Query("characters/Person", { id = Passport })[1] or false
    end
end

function vRP.FullName(Passport)
    local Identity = vRP.Identity(Passport)
    return Identity.Name .. " " .. Identity.Lastname
end

function vRP.InitPrison(Passport, Amount)
    local source = vRP.Source(Passport)
    if parseInt(Amount) > 0 then
        vRP.Query("characters/InsertPrison", { Passport = Passport, Prison = parseInt(Amount) })
        if Characters[source] then
            Characters[source].Prison = Characters[source].Prison + parseInt(Amount)
        end
    end
end

function vRP.UpdatePrison(Passport, Amount)
    local source = vRP.Source(Passport)
    if parseInt(Amount) > 0 then
        vRP.Query("characters/ReducePrison", { Passport = Passport, Prison = parseInt(Amount) })
        if Characters[source] then
            Characters[source].Prison = Characters[source].Prison - parseInt(Amount)
            if 0 == Characters[source].Prison then
                exports["markers"]:Exit(source)
                Characters[source].Prison = 0
                TriggerClientEvent("police:Prisioner", source, false)
                vRP.Teleport(source, BackPrison.x, BackPrison.y, BackPrison.z)
                TriggerClientEvent("Notify", source, "verde", "Serviços finalizados.", "Sucesso", 5000)
            else
                TriggerClientEvent("Notify", source, "azul",
                    "Restam <b>" .. Characters[source].Prison .. " serviços</b>.",
                    "Sistema Penitenciário", 5000)
            end
        end
    end
end

function vRP.UpdateGunlicense(Passport, Status)
    local source = vRP.Source(Passport)
    vRP.Query("characters/UpdateGun", { Passport = Passport, Gun = Status })
    if Characters[source] then
        Characters[source].Gun = Status
    end
end

function vRP.GetDriverLicense(Passport)
    local source = vRP.Source(Passport)
    if Characters[source] then
        return Characters[source].Driver
    end
end

function vRP.UpdateDriverLicense(Passport, Time)
    local source = vRP.Source(Passport)
    vRP.Query("characters/UpdateDriver", { Passport = Passport, Driver = parseInt(Time) })
    if Characters[source] then
        Characters[source].Driver = parseInt(Time)
    end
end

function vRP.UpgradeChars(source)
    if Characters[source] then
        vRP.Query("accounts/UpdateCharacters", { License = Characters[source].License })
        Characters[source].Characters = Characters[source].Characters + 1
    end
end

function vRP.UserGemstone(License)
    return vRP.Account(License).Gemstone or 0
end

function vRP.UpgradeGemstone(Passport, Amount)
    if parseInt(Amount) > 0 and vRP.Identity(Passport) then
        vRP.Query("accounts/AddGemstone",
            { License = vRP.Identity(Passport).License, Gemstone = parseInt(Amount) })
        if Characters[vRP.Source(Passport)] then
            TriggerClientEvent("hud:AddGemstone", vRP.Source(Passport), parseInt(Amount))
        end
    end
end

function vRP.UpgradeNames(Passport, Name, Lastname)
    local source = vRP.Source(Passport)

    vRP.Query("characters/UpdateName", { Passport = Passport, Name = Name, Lastname = Lastname })
    if Characters[source] then
        Characters[source].Name = Name
        Characters[source].Lastname = Lastname
    end
end

function vRP.UpgradePhone(Passport, Phone)
    local source = vRP.Source(Passport)
    vRP.Query("characters/UpdatePhone", { Passport = Passport, Phone = Phone })
    if Characters[source] then
        Characters[source].Phone = Phone
    end
end

function vRP.PassportPlate(Plate)
    return vRP.Query("vehicles/plateVehicles", { plate = Plate })[1] or false
end

function vRP.UserPhone(Phone)
    return vRP.Query("characters/Phone", { Phone = Phone })[1] or false
end

function vRP.GenerateString(Format)
    local Number = ""
    for k = 1, #Format do
        if "D" == string.sub(Format, k, k) then
            Number = Number .. string.char(string.byte("0") + math.random(0, 9))
        elseif "L" == string.sub(Format, k, k) then
            Number = Number .. string.char(string.byte("A") + math.random(0, 25))
        else
            Number = Number .. string.sub(Format, k, k)
        end
    end
    return Number
end

function vRP.GeneratePlate()
    local Passport = nil
    local Serial = ""

    repeat
        local NewPlate = vRP.GenerateString("DDLLLDDD")
        Passport = vRP.PassportPlate(NewPlate)
        Serial = NewPlate
    until not Passport

    return Serial
end

function vRP.GeneratePhone()
    local Passport = nil
    local Phone = ""

    repeat
        local NewPhone = vRP.GenerateString("DDD-DDD")
        Passport = vRP.UserPhone(NewPhone)
        Phone = NewPhone
    until not Passport

    return Phone
end

function vRP.ConsultItem(Passport, Item, Amount)
    if vRP.Source(Passport) then
        if Amount > vRP.InventoryItemAmount(Passport, Item)[1] then
            return false
        elseif vRP.CheckDamaged(vRP.InventoryItemAmount(Passport, Item)[2]) then
            return false
        end
    end
    return true
end

function vRP.GetWeight(Passport)
    local Datatable = vRP.Datatable(Passport)
    if vRP.Source(Passport) and Datatable then
        if not Datatable.Weight then
            Datatable.Weight = BackpackWeightDefault
        end
        return Datatable.Weight
    end
    return 0
end

function vRP.SetWeight(Passport, Amount)
    local Datatable = vRP.Datatable(Passport)
    if vRP.Source(Passport) and Datatable then
        if not Datatable.Weight then
            Datatable.Weight = BackpackWeightDefault
        end
        Datatable.Weight = Datatable.Weight + Amount
    end
end

function vRP.RemoveWeight(Passport, Amount)
    local Datatable = vRP.Datatable(Passport)
    if vRP.Source(Passport) and Datatable then
        if not Datatable.Weight then
            Datatable.Weight = BackpackWeightDefault
        end
        Datatable.Weight = Datatable.Weight - Amount
    end
end

function vRP.SwapSlot(Passport, Slot, Target)
    local source = vRP.Source(Passport)
    local Inventory = vRP.Inventory(Passport)
    Slot = tostring(Slot)
    Target = tostring(Target)
    if source and Inventory then
        Inventory[Target], Inventory[Slot] = Inventory[Slot], Inventory[Target]
        if parseInt(Target) <= 5 and parseInt(Slot) > 5 then
            if "Armamento" == itemType(Inventory[Target].item) then
                TriggerClientEvent("inventory:RemoveWeapon", source, Inventory[Target].item)
            end
            if "Armamento" == itemType(Inventory[Slot].item) then
                TriggerClientEvent("inventory:CreateWeapon", source, Inventory[Slot].item)
            end
        elseif parseInt(Slot) <= 5 and parseInt(Target) > 5 then
            if "Armamento" == itemType(Inventory[Slot].item) then
                TriggerClientEvent("inventory:RemoveWeapon", source, Inventory[Slot].item)
            end
            if "Armamento" == itemType(Inventory[Target].item) then
                TriggerClientEvent("inventory:CreateWeapon", source, Inventory[Target].item)
            end
        end
    end
end

function vRP.InventoryWeight(Passport)
    local Weight = 0
    if vRP.Source(Passport) then
        for _, v in pairs(vRP.Inventory(Passport)) do
            Weight = Weight + (itemWeight(v.item) * v.amount)
        end
    end
    return Weight
end

function vRP.CheckDamaged(Item)
    if itemDurability(Item) and splitString(Item, "-")[2] and parseInt((3600 * itemDurability(Item) - parseInt(os.time() - splitString(Item, "-")[2])) / (3600 * itemDurability(Item)) * 100) <= 1 then
        return true
    end
    return false
end

function vRP.ChestWeight(Items)
    local Weight = 0
    for _, v in pairs(Items) do
        Weight = Weight + (itemWeight(v.item) * v.amount)
    end
    return Weight
end

function vRP.InventoryItemAmount(Passport, Item)
    if vRP.Source(Passport) then
        for _, v in pairs(vRP.Inventory(Passport)) do
            if splitString(Item, "-")[1] == splitString(v.item, "-")[1] then
                return { parseInt(v.amount), v.item }
            end
        end
    end
    return { 0, "" }
end

function vRP.InventoryFull(Passport, Item)
    if vRP.Source(Passport) then
        for _, v in pairs(vRP.Inventory(Passport)) do
            if v.item == Item then
                return true
            end
        end
    end
    return false
end

function vRP.ItemAmount(Passport, Item)
    if vRP.Source(Passport) then
        for _, v in pairs(vRP.Inventory(Passport)) do
            if splitString(v["item"], "-")[1] == splitString(Item, "-")[1] then
                return v["amount"]
            end
        end
    end
    return 0
end

function vRP.GiveItem(Passport, Item, Amount, Notify, Slot)
    local source = vRP.Source(Passport)
    if source and parseInt(Amount) > 0 then
        local Inventory = vRP.Inventory(Passport)
        if not Slot then
            local newSlot = 0
            repeat
                newSlot = newSlot + 1
            until nil == Inventory[tostring(newSlot)] or Inventory[tostring(newSlot)] and Inventory[tostring(newSlot)].item == Item

            if not Inventory[tostring(newSlot)] then
                Inventory[tostring(newSlot)] = { amount = parseInt(Amount), item = Item }
                if parseInt(tostring(newSlot)) <= 5 and "Armamento" == itemType(Item) then
                    TriggerClientEvent("inventory:CreateWeapon", source, Item)
                end
            elseif Inventory[tostring(newSlot)] and Inventory[tostring(newSlot)].item == Item then
                Inventory[tostring(newSlot)].amount = Inventory[tostring(newSlot)].amount +
                    parseInt(Amount)
            end
            if Notify and itemBody(Item) then
                TriggerClientEvent("NotifyItens", source,
                    { "+", itemIndex(Item), parseInt(Amount), itemName(Item) })
            end
        else
            Slot = tostring(Slot)
            if Inventory[Slot] then
                if Inventory[Slot].item == Item then
                    Inventory[Slot].amount = Inventory[Slot].amount + parseInt(Amount)
                end
            else
                Inventory[Slot] = { amount = parseInt(Amount), item = Item }
                if parseInt(Slot) <= 5 and "Armamento" == itemType(Item) then
                    TriggerClientEvent("inventory:CreateWeapon", source, Item)
                end
            end
            if Notify and itemBody(Item) then
                TriggerClientEvent("NotifyItens", source,
                    { "+", itemIndex(Item), parseInt(Amount), itemName(Item) })
            end
        end
    end
end

function vRP.GenerateItem(Passport, Item, Amount, Notify, Slot)
    local source = vRP.Source(Passport)
    if source and parseInt(Amount) > 0 then
        local Inventory = vRP.Inventory(Passport)
        if itemDurability(Item) then
            if "Armamento" == itemType(Item) then
                Item = Item .. "-" .. os.time() .. "-" .. Passport
            else
                Item = Item .. "-" .. os.time()
            end
        elseif itemCharges(Item) then
            Item = Item .. "-" .. itemCharges(Item)
        end
        if not Slot then
            local newSlot = 0
            repeat
                newSlot = newSlot + 1
            until nil == Inventory[tostring(newSlot)] or Inventory[tostring(newSlot)] and Inventory[tostring(newSlot)].item == Item
            if not Inventory[tostring(newSlot)] then
                Inventory[tostring(newSlot)] = { amount = parseInt(Amount), item = Item }
                if parseInt(tostring(i)) <= 5 and "Armamento" == itemType(Item) then
                    TriggerClientEvent("inventory:CreateWeapon", source, Item)
                end
            elseif Inventory[tostring(newSlot)] and Inventory[tostring(newSlot)].item == Item then
                Inventory[tostring(newSlot)].amount = Inventory[tostring(newSlot)].amount +
                    parseInt(Amount)
            end
            if Notify and itemBody(Item) then
                TriggerClientEvent("NotifyItens", source,
                    { "+", itemIndex(Item), parseInt(Amount), itemName(Item) })
            end
        else
            Slot = tostring(Slot)
            if Inventory[Slot] then
                if Inventory[Slot].item == Item then
                    Inventory[Slot].amount = Inventory[Slot].amount + parseInt(Amount)
                end
            else
                Inventory[Slot] = { amount = parseInt(Amount), item = Item }
                if parseInt(Slot) <= 5 and "Armamento" == itemType(Item) then
                    TriggerClientEvent("inventory:CreateWeapon", source, Item)
                end
            end
            if Notify and itemBody(Item) then
                TriggerClientEvent("NotifyItens", source,
                    { "+", itemIndex(Item), parseInt(Amount), itemName(Item) })
            end
        end
    end
end

function vRP.MaxItens(Passport, Item, Amount)
    if itemBody(Item) and vRP.Source(Passport) and itemMaxAmount(Item) then
        local Count = 0
        if vRP.Source(Passport) then
            for _, v in pairs(vRP.Inventory(Passport)) do
                if splitString(v["item"], "-")[1] == splitString(Item, "-")[1] then
                    Count = Count + v["amount"]
                end
            end
        end
        
        if vRP.HasGroup(Passport, "Restaurantes") then
            if Count + parseInt(Amount) > itemMaxAmount(Item) * 5 then
                return true
            end
        elseif Count + parseInt(Amount) > itemMaxAmount(Item) then
            return true
        end
    end
    return false
end

function vRP.TakeItem(Passport, Item, Amount, Notify, Slot)
    local take = false
    local source = vRP.Source(Passport)
    if source and parseInt(Amount) > 0 then
        local Inventory = vRP.Inventory(Passport)
        if not Slot then
            for k, v in pairs(Inventory) do
                if v["item"] == Item and parseInt(Amount) <= v["amount"] then
                    v["amount"] = v["amount"] - parseInt(Amount)
                    if 0 >= v["amount"] then
                        if "Armamento" == itemType(Item) or "Throwing" == itemType(Item) then
                            TriggerClientEvent("inventory:verifyWeapon", source, Item)
                        end
                        if parseInt(k) <= 5 then
                            TriggerClientEvent("inventory:RemoveWeapon", source, Item)
                        end
                        if "Animal" == itemType(splitString(Item, "-")[1]) then
                            TriggerClientEvent("dynamic:animalFunctions", source, "destroy")
                        end
                        if "scuba" == splitString(Item, "-")[1] then
                            TriggerClientEvent("hud:ScubaRemove", source)
                        end
                        if "radio" == splitString(Item, "-")[1] then
                            TriggerClientEvent("radio:RadioClean", source)
                        end
                        Inventory[k] = nil
                    end
                    if Notify and itemBody(Item) then
                        TriggerClientEvent("NotifyItens", source,
                            { "-", itemIndex(Item), parseInt(Amount), itemName(Item) })
                    end
                    take = true
                    break
                end
            end
        elseif Inventory[Slot] and Inventory[Slot].item == Item and parseInt(Amount) <= Inventory[Slot].amount then
            Inventory[Slot].amount = Inventory[Slot].amount - parseInt(Amount)
            if 0 >= Inventory[Slot].amount then
                if "Armamento" == itemType(Item) or "Throwing" == itemType(Item) then
                    TriggerClientEvent("inventory:verifyWeapon", source, Item)
                end
                if parseInt(Slot) <= 5 then
                    TriggerClientEvent("inventory:RemoveWeapon", source, Item)
                end
                if "Animal" == itemType(splitString(Item, "-")[1]) then
                    TriggerClientEvent("dynamic:animalFunctions", source, "destroy")
                end
                if "scuba" == splitString(Item, "-")[1] then
                    TriggerClientEvent("hud:ScubaRemove", source)
                end
                if "radio" == splitString(Item, "-")[1] then
                    TriggerClientEvent("radio:RadioClean", source)
                end
                Inventory[Slot] = nil
            end
            if Notify and itemBody(Item) then
                TriggerClientEvent("NotifyItens", source,
                    { "-", itemIndex(Item), parseInt(Amount), itemName(Item) })
            end
            take = true
        end
    end
    return take
end

function vRP.RemoveItem(Passport, Item, Amount, Notify)
    local source = vRP.Source(Passport)
    if source and parseInt(Amount) > 0 then
        local Inventory = vRP.Inventory(Passport)
        for k, v in pairs(Inventory) do
            if v["item"] == Item and parseInt(Amount) <= v["amount"] then
                v["amount"] = v["amount"] - parseInt(Amount)
                if 0 >= v["amount"] then
                    if "Armamento" == itemType(Item) or "Throwing" == itemType(Item) then
                        TriggerClientEvent("inventory:verifyWeapon", source, Item)
                    end
                    if parseInt(k) <= 5 then
                        TriggerClientEvent("inventory:RemoveWeapon", source, Item)
                    end
                    if "Animal" == itemType(splitString(Item, "-")[1]) then
                        TriggerClientEvent("dynamic:animalFunctions", source, "destroy")
                    end
                    if "scuba" == splitString(Item, "-")[1] then
                        TriggerClientEvent("hud:ScubaRemove", source)
                    end
                    if "radio" == splitString(Item, "-")[1] then
                        TriggerClientEvent("radio:RadioClean", source)
                    end
                    Inventory[k] = nil
                end
                if Notify and itemBody(Item) then
                    TriggerClientEvent("NotifyItens", source,
                        { "-", itemIndex(Item), parseInt(Amount), itemName(Item) })
                end
                break
            end
        end
    end
end

function vRP.GetServerData(Key)
    if nil == srvData[Key] then
        local Rows = vRP.Query("entitydata/GetData", { Name = Key })
        if parseInt(#Rows) > 0 then
            srvData[Key] = {
                ["data"] = json.decode(Rows[1]["Information"]),
                ["timer"] = os.time() + 180
            }
        else
            srvData[Key] = {
                ["data"] = {},
                ["timer"] = os.time() + 180
            }
        end
    end
    return srvData[Key]["data"] or {}
end

function vRP.SetServerData(Key, Data)
    srvData[Key] = {
        ["data"] = Data,
        ["timer"] = os.time() + 180
    }
end

function vRP.RemServerData(Key)
    srvData[Key] = { data = {}, timer = os.time() + 180 }
end

CreateThread(function()
    while true do
        for k, v in pairs(srvData) do
            if v.timer > 0 then
                v.timer = v.timer - 1
                if v.timer <= 0 then
                    vRP.Query("entitydata/SetData", { Name = k, Information = json.encode(v.data) })
                    srvData[k] = nil
                end
            end
        end
        Wait(60000)
    end
end)

AddEventHandler("SaveServer", function(Save)
    for k, v in pairs(srvData) do
        if "[]" == json.encode(v.data) or "{}" ~= json.encode(v.data) then
            vRP.Query("entitydata/RemoveData", { Name = k })
            vRP.Query("entitydata/SetData", { Name = k, Information = json.encode(v.data) })
        end
    end
    if not Save then
        print("O resource ^2vRP^7 salvou os dados.")
    end
end)

function vRP.TakeChest(Passport, Data, Amount, Slot, Target)
    local source = vRP.Source(Passport)
    local Datatable = vRP.GetServerData(Data)
    Slot = tostring(Slot)
    Target = tostring(Target)
    if source and parseInt(Amount) > 0 and Datatable[Slot] then
        local Inventory = vRP.Inventory(Passport)
        if vRP.MaxItens(Passport, Datatable[Slot].item, parseInt(Amount)) then
            TriggerClientEvent("Notify", source, "vermelho", "Limite atingido.", "Aviso", 5000)
            return true
        end
        if vRP.InventoryWeight(Passport) + itemWeight(Datatable[Slot].item) * parseInt(Amount) <= vRP.GetWeight(Passport) then
            if Inventory[Target] then
                if Datatable[Slot] and Inventory[Target].item == Datatable[Slot].item and parseInt(Amount) <= Datatable[Slot].amount then
                    Inventory[Target].amount = Inventory[Target].amount + parseInt(Amount)
                    Datatable[Slot].amount = Datatable[Slot].amount - parseInt(Amount)
                    if 0 >= Datatable[Slot].amount then
                        Datatable[Slot] = nil
                    end
                end
            elseif Datatable[Slot] and parseInt(Amount) <= Datatable[Slot].amount then
                Inventory[Target] = { amount = parseInt(Amount), item = Datatable[Slot].item }
                Datatable[Slot].amount = Datatable[Slot].amount - parseInt(Amount)
                if parseInt(Target) <= 5 and "Armamento" == itemType(Datatable[Slot].item) then
                    TriggerClientEvent("inventory:CreateWeapon", source, Datatable[Slot].item)
                end
                if 0 >= Datatable[Slot].amount then
                    Datatable[Slot] = nil
                end
            end
        end
    end
    return false
end

function vRP.StoreChest(Passport, Data, Amount, Weight, Slot, Target)
    local source = vRP.Source(Passport)
    local Inventory = vRP.Inventory(Passport)
    local Datatable = vRP.GetServerData(Data)
    Slot = tostring(Slot)
    Target = tostring(Target)
    if source and parseInt(Amount) > 0 and Inventory[Slot] and Weight >= vRP.ChestWeight(Datatable) + itemWeight(Inventory[Slot].item) * parseInt(Amount) then
        if Datatable[Target] then
            if Inventory[Slot] then
                if Inventory[Slot].item ~= Datatable[Target].item then
                    return
                end
                if not (parseInt(Amount) <= Inventory[Slot].amount) then
                    return
                end
                Datatable[Target].amount = Datatable[Target].amount + parseInt(Amount)
                Inventory[Slot].amount = Inventory[Slot].amount - parseInt(Amount)
                if 0 >= Inventory[Slot].amount then
                    if "Armamento" == itemType(Inventory[Slot].item) or "Throwing" == itemType(Inventory[Slot].item) then
                        TriggerClientEvent("inventory:verifyWeapon", source, Inventory[Slot].item)
                        if parseInt(Slot) <= 5 then
                            TriggerClientEvent("inventory:RemoveWeapon", source, Inventory[Slot].item)
                        end
                        if "Animal" == itemType(splitString(Inventory[Slot].item, "-")[1]) then
                            TriggerClientEvent("dynamic:animalFunctions", source, "destroy")
                        end
                        if "scuba" == splitString(Inventory[Slot].item, "-")[1] then
                            TriggerClientEvent("hud:ScubaRemove", source)
                        end
                        if "radio" == splitString(Item, "-")[1] then
                            TriggerClientEvent("radio:RadioClean", source)
                        end
                    end
                    Inventory[Slot] = nil
                end
            end
        elseif Inventory[Slot] and parseInt(Amount) <= Inventory[Slot].amount then
            Datatable[Target] = { amount = parseInt(Amount), item = Inventory[Slot].item }
            Inventory[Slot].amount = Inventory[Slot].amount - parseInt(Amount)
            if 0 >= Inventory[Slot].amount then
                if "Armamento" == itemType(Inventory[Slot].item) or "Throwing" == itemType(Inventory[Slot].item) then
                    TriggerClientEvent("inventory:verifyWeapon", source, Inventory[Slot].item)
                    if parseInt(Slot) <= 5 then
                        TriggerClientEvent("inventory:RemoveWeapon", source, Inventory[Slot].item)
                    end
                    if "Animal" == itemType(splitString(Inventory[Slot].item, "-")[1]) then
                        TriggerClientEvent("dynamic:animalFunctions", source, "destroy")
                    end
                    if "scuba" == splitString(Inventory[Slot].item, "-")[1] then
                        TriggerClientEvent("hud:ScubaRemove", source)
                    end
                    if "radio" == splitString(Item, "-")[1] then
                        TriggerClientEvent("radio:RadioClean", source)
                    end
                end
                Inventory[Slot] = nil
            end
        end
    end
    return false
end

function vRP.UpdateChest(Passport, Data, Slot, Target, Amount)
    Amount = parseInt(Amount)
    Slot = tostring(Slot)
    Target = tostring(Target)
    local Datatable = vRP.GetServerData(Data)
    if vRP.Source(Passport) and Amount > 0 and Datatable[Slot] then
        if Datatable[Target] then
            if Datatable[Slot] then
                if Datatable[Slot].item == Datatable[Target].item then
                    if Amount <= Datatable[Slot].amount then
                        Datatable[Slot].amount = Datatable[Slot].amount - Amount
                        if 0 >= Datatable[Slot].amount then
                            Datatable[Slot] = nil
                        end
                        Datatable[Target].amount = Datatable[Target].amount + Amount
                    end
                else
                    Datatable[Target], Datatable[Slot] = Datatable[Slot], Datatable[Target]
                end
            end
        elseif Datatable[Slot] and Amount <= Datatable[Slot].amount then
            Datatable[Slot].amount = Datatable[Slot].amount - Amount
            Datatable[Target] = { item = Datatable[Slot].item, amount = Amount }
            if 0 >= Datatable[Slot].amount then
                Datatable[Slot] = nil
            end
        end
    end
    return false
end

function vRP.DirectChest(Chest, Slot, Amount)
    local Datatable = vRP.GetServerData("Chest:" .. Chest)
    if Datatable[Slot] then
        if "dollars" == Datatable[Slot].item then
            Datatable[Slot].amount = Datatable[Slot].amount + parseInt(Amount)
        else
            Datatable[Slot] = { item = "dollars", amount = parseInt(Amount) }
        end
    else
        Datatable[Slot] = { item = "dollars", amount = parseInt(Amount) }
    end
end

function vRP.ChestPremium(Name)
    if vRP.Query("chests/GetChests", { Name = Name })[1].Premium > 0 then
        return true
    end
    return false
end

function tvRP.UpdateInventory(Slot, Target, Amount)
    local source = source
    local Passport = vRP.Passport(source)
    if Passport and parseInt(Amount) > 0 then
        local Inventory = vRP.Inventory(Passport)
        Slot = tostring(Slot)
        Target = tostring(Target)
        if Inventory[Slot] then
            if Inventory[Target] then
                if Inventory[Slot].item == Inventory[Target].item then
                    if parseInt(Amount) <= Inventory[Slot].amount then
                        Inventory[Slot].amount = Inventory[Slot].amount - parseInt(Amount)
                        Inventory[Target].amount = Inventory[Target].amount + parseInt(Amount)
                        if 0 >= Inventory[Slot].amount then
                            if parseInt(Slot) <= 5 and "Armamento" == itemType(Inventory[Slot].item) then
                                TriggerClientEvent("inventory:RemoveWeapon", source, Inventory[Slot]
                                    .item)
                            end
                            Inventory[Slot] = nil
                        end
                    end
                elseif Inventory[Slot].item and Inventory[Target].item then
                    if Inventory[Slot].item == "repairkit0" .. string.sub(Inventory[Slot].item, 11, 12) then
                        if vRP.CheckDamaged(Inventory[Target].item) and 1 == Inventory[Target].amount and Inventory[Slot].item == "repairkit0" .. string.sub(Inventory[Slot].item, 11, 12) and itemRepair(Inventory[Target].item) then
                            if itemRepair(Inventory[Target].item) == Inventory[Slot].item then
                                if vRP.TakeItem(Passport, Inventory[Slot].item, 1, false, Slot) then
                                    if splitString(Inventory[Target].item, "-")[3] then
                                        Inventory[Target].item = splitString(Inventory[Target].item, "-")
                                            [1] ..
                                            "-" ..
                                            os.time() ..
                                            "-" .. splitString(Inventory[Target].item, "-")[3]
                                        TriggerClientEvent("Notify", source, "verde", "Reparado.",
                                            "Sucesso", 5000)
                                    else
                                        Inventory[Target].item = splitString(Inventory[Target].item, "-")
                                            [1] ..
                                            "-" .. os.time()
                                        TriggerClientEvent("Notify", source, "verde", "Reparado.",
                                            "Sucesso", 5000)
                                    end
                                end
                            else
                                TriggerClientEvent("Notify", source, "amarelo",
                                    "Repare usando <b>1x " ..
                                    itemName(itemRepair(Inventory[Target].item)) .. "</b>.",
                                    "Atenção", 5000)
                            end
                        end
                    else
                        Inventory[Target], Inventory[Slot] = Inventory[Slot], Inventory[Target]
                        if parseInt(Target) <= 5 then
                            if parseInt(Slot) > 5 then
                                if "Armamento" == itemType(Inventory[Target].item) then
                                    TriggerClientEvent("inventory:RemoveWeapon", source,
                                        Inventory[Target].item)
                                end
                                if "Armamento" == itemType(Inventory[Slot].item) then
                                    TriggerClientEvent("inventory:CreateWeapon", source,
                                        Inventory[Slot].item)
                                end
                            end
                        elseif parseInt(Slot) <= 5 and parseInt(Target) > 5 then
                            if "Armamento" == itemType(Inventory[Slot].item) then
                                TriggerClientEvent("inventory:RemoveWeapon", source, Inventory[Slot]
                                    .item)
                            end
                            if "Armamento" == itemType(Inventory[Target].item) then
                                TriggerClientEvent("inventory:CreateWeapon", source,
                                    Inventory[Target].item)
                            end
                        end
                    end
                end
            elseif Inventory[Slot] and parseInt(Amount) <= Inventory[Slot].amount then
                Inventory[Target] = { item = Inventory[Slot].item, amount = parseInt(Amount) }
                Inventory[Slot].amount = Inventory[Slot].amount - parseInt(Amount)
                if 0 >= Inventory[Slot].amount then
                    if parseInt(Slot) <= 5 and parseInt(Target) > 5 and "Armamento" == itemType(Inventory[Slot].item) then
                        TriggerClientEvent("inventory:RemoveWeapon", source, Inventory[Slot].item)
                    end
                    if parseInt(Target) <= 5 and parseInt(Slot) > 5 and "Armamento" == itemType(Inventory[Slot].item) then
                        TriggerClientEvent("inventory:CreateWeapon", source, Inventory[Slot].item)
                    end
                    Inventory[Slot] = nil
                end
            end
        else
            TriggerClientEvent("inventory:Update", source, "Backpack")
        end
    end
end

function vRP.SetPremium(source)
    if Characters[source] then
        vRP.Query("accounts/SetPremium",
            { License = Characters[source].License, Premium = os.time() + 2592000 })
        Characters[source].Premium = parseInt(os.time() + 2592000)
        vRP.SetWeight(Passport, BackpackWeightPremiumDefault)
    end
end

function vRP.UpgradePremium(source)
    if Characters[source] then
        vRP.Query("accounts/UpgradePremium", { License = Characters[source].License })
        Characters[source].Premium = Characters[source].Premium + 2592000
        vRP.SetWeight(Passport, BackpackWeightPremiumDefault)
    end
end

function vRP.UserPremium(Passport)
    local source = vRP.Source(Passport)
    local HasPermission = vRP.HasPermission(Passport, "Premium")
    if Characters[source] then
        if Characters[source].Premium < os.time() then
            if HasPermission then
                vRP.RemovePermission(Passport, "Premium")
                return false
            end
        else
            if HasPermission then
                return true
            end
        end
    end
    return false
end

function vRP.LicensePremium(License)
    local Account = vRP.Account(License)
    if Account and Account.Premium >= os.time() then
        return true
    end
    return false
end

function vRP.SetMedicPlan(Passport)
    local source = vRP.Source(Passport)
    if Characters[source] then
        vRP.Query("characters/SetMedicplan", { Passport = Passport, Medic = os.time() + 604800 })
        Characters[source].Medic = parseInt(os.time() + 604800)
    end
end

function vRP.UpgradeMedicPlan(Passport)
    local source = vRP.Source(Passport)
    if Characters[source] then
        vRP.Query("characters/UpdateMedicplan", { Passport = Passport })
        Characters[source].Medic = Characters[source].Medic + 604800
    end
end

function vRP.UserMedicPlan(Passport)
    if Sources[Passport] and Characters[Sources[Passport]] and Characters[Sources[Passport]].Medic >= os.time() then
        return true
    end
    return false
end

function vRP.LicenseMedicPlan(License)
    if vRP.Account(License) and vRP.Account(License).Medic >= os.time() then
        return true
    end
    return false
end

function vRP.UpdateRolepass(source, Day)
    if Characters[source] then
        vRP.Query("accounts/Rolepass", { License = Characters[source].License, Rolepass = Day })
        Characters[source].Rolepass = Day
    end
end

function vRP.CheckRolepass(source)
    if Characters[source] and Characters[source].Rolepass > 0 then
        return true
    end
    return false
end

RegisterServerEvent("CleanVehicle")
AddEventHandler("CleanVehicle", function(entIndex)
    local Vehicle = NetworkGetEntityFromNetworkId(entIndex)
    if DoesEntityExist(Vehicle) and not IsPedAPlayer(Vehicle) and 2 == GetEntityType(Vehicle) then
        SetVehicleDirtLevel(Vehicle, 0)
    end
end)

exports("Embed", function(Webhook, Message, Color)
    PerformHttpRequest(Discords[Webhook], function() end, "POST",
        json.encode({
            avatar_url =
            "https://cdn.discordapp.com/attachments/1144313259567104082/1174708548542935091/75fc270339121966a8163a5f8d4e3a69-1.png?ex=65689397&is=65561e97&hm=9a7f81a3080cc5f8fa5c6194036d41cd3ea8ba415f4022d8da7b77d79ed28dfc&",
            username = ServerName,
            embeds = { { color = Color, description = Message } }
        }),
        { ["Content-Type"] = "application/json" })
end)

function vRP.GiveBank(Passport, Amount)
    local source = vRP.Source(Passport)
    if parseInt(Amount) > 0 then
        vRP.Query("characters/AddBank", { Passport = Passport, Bank = parseInt(Amount) })
        if NewBank then
            exports["bank"]:AddTransactions(Passport, "entry", parseInt(Amount))
        end
        if Characters[source] then
            Characters[source].Bank = Characters[source].Bank + parseInt(Amount)
            TriggerClientEvent("NotifyItens", source, { "+", "dollars", parseInt(Amount), "Dólares" })
        end
    end
end

function vRP.RemoveBank(Passport, Amount)
    local source = vRP.Source(Passport)
    if parseInt(Amount) > 0 then
        vRP.Query("characters/RemBank", { Passport = Passport, Bank = parseInt(Amount) })
        if NewBank then
            exports["bank"]:AddTransactions(Passport, "exit", parseInt(Amount))
        end
        if Characters[source] then
            Characters[source].Bank = Characters[source].Bank - parseInt(Amount)
            if 0 > Characters[source].Bank then
                Characters[source].Bank = 0
            end
            TriggerClientEvent("NotifyItens", source, { "-", "dollars", parseInt(Amount), "Dólares" })
        end
    end
end

function vRP.GetBank(source)
    if Characters[source] then
        return Characters[source].Bank
    end
    return 0
end

function vRP.GetFine(Passport)
    return vRP.Identity(Passport)["Fines"] or 0
end

function vRP.GiveFine(Passport, Amount)
    local source = vRP.Source(Passport)
    if parseInt(Amount) > 0 then
        vRP.Query("characters/AddFines", { Passport = Passport, Fines = parseInt(Amount) })
        if Characters[source] then
            Characters[source].Fines = Characters[source].Fines + parseInt(Amount)
        end
    end
end

function vRP.RemoveFine(Passport, Amount)
    local source = vRP.Source(Passport)
    if parseInt(Amount) > 0 then
        vRP.Query("characters/RemFines", { Passport = Passport, Fines = parseInt(Amount) })
        if Characters[source] then
            Characters[source].Fines = Characters[source].Fines - parseInt(Amount)
            if 0 > Characters[source].Fines then
                Characters[source].Fines = 0
            end
        end
    end
end

function vRP.RemoveAllFines(Passport)
    local source = vRP.Source(Passport)
    if Characters[source] then
        vRP.Query("characters/RemFines", { Passport = Passport, Fines = Characters[source].Fines })
        Characters[source].Fines = 0
        if NewBank then
            local Consult = vRP.Query("fines/List", { Passport = Passport })
            for _, Fine in pairs(Consult) do
                vRP.Query("fines/Remove", { Passport = Passport, id = Fine.id })
            end
        end
    end
end

function vRP.GetTax(source)
    if Characters[source] then
        return Characters[source].Taxs
    end
    return 0
end

function vRP.GiveTax(Passport, Amount)
    local source = vRP.Source(Passport)
    if parseInt(Amount) > 0 then
        vRP.Query("characters/AddTaxs", { Passport = Passport, Taxs = parseInt(Amount) })
        if Characters[source] then
            Characters[source].Taxs = Characters[source].Taxs + parseInt(Amount)
        end
    end
end

function vRP.RemoveTax(Passport, Amount)
    local source = vRP.Source(Passport)
    if parseInt(Amount) > 0 then
        vRP.Query("characters/RemTaxs", { Passport = Passport, Taxs = parseInt(Amount) })
        if Characters[source] then
            Characters[source].Taxs = Characters[source].Taxs - parseInt(Amount)
            if 0 > Characters[source].Taxs then
                Characters[source].Taxs = 0
            end
        end
    end
end

function vRP.PaymentGemstone(Passport, Amount)
    local source = vRP.Source(Passport)
    if parseInt(Amount) > 0 and Characters[source] and parseInt(Amount) <= vRP.UserGemstone(Characters[source].License) then
        vRP.Query("accounts/RemoveGemstone",
            { License = Characters[source].License, Gemstone = parseInt(Amount) })
        TriggerClientEvent("hud:RemoveGemstone", source, parseInt(Amount))
        return true
    end
    return false
end

function vRP.PaymentBank(Passport, Amount)
    local source = vRP.Source(Passport)
    if parseInt(Amount) > 0 and Characters[source] and parseInt(Amount) <= Characters[source].Bank then
        vRP.RemoveBank(Passport, parseInt(Amount))
        return true
    end
    return false
end

function vRP.PaymentFull(Passport, Amount)
    local source = vRP.Source(Passport)
    if parseInt(Amount) > 0 then
        if vRP.TakeItem(Passport, "dollars", parseInt(Amount), true) then
            return true
        elseif vRP.TakeItem(Passport, "dollars3", parseInt(Amount), true) then
            TriggerEvent("Wanted", source, Passport, 60)
            local Coords = vRP.GetEntityCoords(source)
            for _, v in pairs(vRP.NumPermission("Policia")) do
                async(function()
                    TriggerClientEvent("NotifyPush", v,
                        {
                            code = 20,
                            title = "Tentativa de Golpe",
                            x = Coords.x,
                            y = Coords.y,
                            z = Coords.z,
                            criminal = "Ligação Anônima",
                            color = 16
                        })
                end)
            end
            return true
        elseif Characters[source] then
            if parseInt(Amount) <= Characters[source].Bank then
                if vRP.ConsultItem(Passport, "card", 1) then
                    if not GlobalState.Blackout then
                        vRP.RemoveBank(Passport, parseInt(Amount))
                        return true
                    else
                        TriggerClientEvent("Notify", source, "vermelho",
                            "No momento não estamos aceitando <b>" ..
                            itemName("card") .. "</b> pois estamos sem eletricidade.", "Aviso", 5000)
                    end
                else
                    TriggerClientEvent("Notify", source, "vermelho",
                        "Você precisa de <b>1x " .. itemName("card") .. "</b>.", "Aviso", 5000)
                end
            end
        else
            TriggerClientEvent("Notify", source, "vermelho", "<b>Saldo</b> insuficiente.", "Aviso", 5000)
        end
    end
    return false
end

function vRP.WithdrawCash(Passport, Amount)
    local source = vRP.Source(Passport)
    if parseInt(Amount) > 0 and Characters[source] and parseInt(Amount) <= Characters[source].Bank then
        vRP.RemoveBank(Passport, parseInt(Amount))
        vRP.GenerateItem(Passport, "dollars", parseInt(Amount), true)
        return true
    end
    return false
end

function vRP.PaymentService(Passport, Amount, Notify)
    vRP.GenerateItem(Passport, "dollars", Amount, Notify)
end

AddEventHandler("CharacterChosen", function(Passport, source)
    local Datatable = vRP.Datatable(Passport)
    local Identity = vRP.Identity(Passport)
    if Datatable and Identity then
        if Datatable.Pos then
            if not (Datatable.Pos.x and Datatable.Pos.y and Datatable.Pos.z) then
                Datatable.Pos = { x = SpawnCoords.x, y = SpawnCoords.y, z = SpawnCoords.z }
            end
        else
            Datatable.Pos = { x = SpawnCoords.x, y = SpawnCoords.y, z = SpawnCoords.z }
        end
        if not Datatable.Skin then
            Datatable.Skin = "mp_m_freemode_01"
        end
        if not Datatable.Inventory then
            Datatable.Inventory = {}
        end
        if not Datatable.Health then
            Datatable.Health = 200
        end
        if not Datatable.Armour then
            Datatable.Armour = 0
        end
        if not Datatable.Stress then
            Datatable.Stress = 0
        end
        if not Datatable.Cough then
            Datatable.Cough = 0
        end
        if not Datatable.Hunger then
            Datatable.Hunger = 100
        end
        if not Datatable.Thirst then
            Datatable.Thirst = 100
        end
        if not Datatable.Oxygen then
            Datatable.Oxygen = 100
        end
        if not Datatable.Weight then
            Datatable.Weight = BackpackWeightDefault
        end
        vRPC.Skin(source, Datatable.Skin)
        vRP.SetArmour(source, Datatable.Armour)
        vRPC.SetHealth(source, Datatable.Health)
        vRP.Teleport(source, Datatable.Pos.x, Datatable.Pos.y, Datatable.Pos.z)
        TriggerClientEvent("barbershop:Apply", source, vRP.UserData(Passport, "Barbershop"))
        TriggerClientEvent("skinshop:Apply", source, vRP.UserData(Passport, "Clothings"))
        TriggerClientEvent("tattooshop:Apply", source, vRP.UserData(Passport, "Tatuagens"))
        TriggerClientEvent("hud:Thirst", source, Datatable.Thirst)
        TriggerClientEvent("hud:Hunger", source, Datatable.Hunger)
        TriggerClientEvent("hud:Stress", source, Datatable.Stress)
        TriggerClientEvent("hud:Cough", source, Datatable.Cough)
        TriggerClientEvent("vRP:Active", source, Passport, Identity.Name .. " " .. Identity.Lastname)
        Player(source).state.Passport = Passport
        if "yes" == GetResourceMetadata("vrp", "creator") then
            if 1 == vRP.UserData(Passport, "Creator") then
                if Global[Passport] then
                    TriggerClientEvent("spawn:Finish", source, false, false)
                else
                    TriggerClientEvent("spawn:Finish", source, true,
                        vec3(Datatable.Pos.x, Datatable.Pos.y, Datatable.Pos.z))
                end
            else
                vRP.Query("playerdata/SetData",
                    { Passport = Passport, Name = "Creator", Information = json.encode(1) })
                TriggerClientEvent("spawn:Finish", source, false, true)
            end
        elseif Global[Passport] then
            TriggerClientEvent("spawn:Finish", source, false, false)
        else
            TriggerClientEvent("spawn:Finish", source, true,
                vec3(Datatable.Pos.x, Datatable.Pos.y, Datatable.Pos.z))
        end
        TriggerEvent("Connect", Passport, source, nil == Global[Passport])
        Global[Passport] = true
    end
end)

RegisterServerEvent("vRP:justObjects")
AddEventHandler("vRP:justObjects", function()
    local source = source
    local Passport = vRP.Passport(source)
    if Passport then
        local Inventory = vRP.Inventory(Passport)
        for k = 1, 5 do
            if Inventory[tostring(k)] and "Armamento" == itemType(Inventory[tostring(k)].item) then
                TriggerClientEvent("inventory:CreateWeapon", source, Inventory[tostring(k)].item)
            end
        end
    end
end)

RegisterServerEvent("vRP:BackpackWeight")
AddEventHandler("vRP:BackpackWeight", function(value)
    local source = source
    local Passport = vRP.Passport(source)
    local Datatable = vRP.Datatable(Passport)
    if Passport and value and not Global[Passport] then
        Datatable.Weight = Datatable.Weight + value
        Global[Passport] = true
    end
end)

RegisterServerEvent("DeleteObject")
AddEventHandler("DeleteObject", function(index, value)
    local source = source
    local Passport = vRP.Passport(source)
    if Passport and value and Objects[Passport] and Objects[Passport][value] then
        index = Objects[Passport][value]
        Objects[Passport][value] = nil
    end
    TriggerEvent("DeleteObjectServer", index)
end)

AddEventHandler("DeleteObjectServer", function(entIndex)
    local Network = NetworkGetEntityFromNetworkId(entIndex)
    if DoesEntityExist(Network) and not IsPedAPlayer(Network) and 3 == GetEntityType(Network) then
        DeleteEntity(Network)
    end
end)

RegisterServerEvent("DeletePed")
AddEventHandler("DeletePed", function(entIndex)
    local Network = NetworkGetEntityFromNetworkId(entIndex)
    if DoesEntityExist(Network) and not IsPedAPlayer(Network) and 1 == GetEntityType(Network) then
        DeleteEntity(Network)
    end
end)

AddEventHandler("DebugObjects", function(value)
    if Objects[value] then
        for k, _ in pairs(Objects[value]) do
            Objects[value][k] = nil
            TriggerEvent("DeleteObjectServer", k)
        end
    end
end)

AddEventHandler("DebugWeapons", function(value)
    if Objects[value] then
        for _, k in pairs(Objects[value]) do
            TriggerEvent("DeleteObjectServer", k)
            Objects[value] = nil
        end
        Objects[value] = nil
    end
end)

RegisterCommand("gg", function(source)
    local Passport = vRP.Passport(source)
    if GetPlayerRoutingBucket(source) < 900000 and Passport and SURVIVAL.CheckDeath(source) then
        if vRP.UserPremium(Passport) then
            if ClearInventoryPremium then
                vRP.ClearInventory(Passport)
            end
        elseif CleanDeathInventory then
            vRP.ClearInventory(Passport)
        end
        local Datatable = vRP.Datatable(Passport)
        if WipeBackpackDeath and Datatable and Datatable.Weight then
            Datatable.Weight = BackpackWeightDefault
        end
        vRP.UpgradeThirst(Passport, 100)
        vRP.UpgradeHunger(Passport, 100)
        vRP.DowngradeCough(Passport, 100)
        vRP.DowngradeStress(Passport, 100)
        SURVIVAL.Respawn(source)
        TriggerClientEvent("dynamic:animalFunctions", source, "destroy")
        exports["vrp"]:Embed("Airport", "**Source:** " .. source .. [[

**Passaporte:** ]] .. Passport .. [[

**Address:** ]] .. GetPlayerEndpoint(source), 3092790)
    end
end)

function vRP.ClearInventory(Passport)
    local Datatable = vRP.Datatable(Passport)
    if vRP.Source(Passport) and Datatable and Datatable.Inventory then
        if vRP.ConsultItem(Passport, "backpackp-" .. Passport, 1) then
            vRP.RemServerData("backpackp:" .. Passport)
        elseif vRP.ConsultItem(Passport, "backpackm-" .. Passport, 1) then
            vRP.RemServerData("backpackm:" .. Passport)
        elseif vRP.ConsultItem(Passport, "backpackg-" .. Passport, 1) then
            vRP.RemServerData("backpackg:" .. Passport)
        end
        exports["inventory"]:CleanWeapons(parseInt(Passport), true)
        TriggerEvent("DebugObjects", parseInt(Passport))
        TriggerEvent("DebugWeapons", parseInt(Passport))
        Datatable.Inventory = {}
    end
end

function vRP.UpgradeThirst(Passport, Amount)
    local Datatable = vRP.Datatable(Passport)
    local source = vRP.Source(Passport)
    if Datatable and source then
        if not Datatable.Thirst then
            Datatable.Thirst = 0
        end
        Datatable.Thirst = Datatable.Thirst + parseInt(Amount)
        if Datatable.Thirst > 100 then
            Datatable.Thirst = 100
        end
        TriggerClientEvent("hud:Thirst", source, Datatable.Thirst)
    end
end

function vRP.UpgradeHunger(Passport, Amount)
    local Datatable = vRP.Datatable(Passport)
    local source = vRP.Source(Passport)
    if Datatable and source then
        if not Datatable.Hunger then
            Datatable.Hunger = 0
        end
        Datatable.Hunger = Datatable.Hunger + parseInt(Amount)
        if Datatable.Hunger > 100 then
            Datatable.Hunger = 100
        end
        TriggerClientEvent("hud:Hunger", source, Datatable.Hunger)
    end
end

function vRP.UpgradeStress(Passport, Amount)
    local Datatable = vRP.Datatable(Passport)
    local source = vRP.Source(Passport)
    if Datatable and source then
        if not Datatable.Stress then
            Datatable.Stress = 0
        end
        Datatable.Stress = Datatable.Stress + parseInt(Amount)
        if Datatable.Stress > 100 then
            Datatable.Stress = 100
        end
        TriggerClientEvent("hud:Stress", source, Datatable.Stress)
    end
end

function vRP.UpgradeOxygen(Passport, Amount)
    local Datatable = vRP.Datatable(Passport)
    local source = vRP.Source(Passport)
    if Datatable and source then
        if not Datatable.Oxygen then
            Datatable.Oxygen = 0
        end
        Datatable.Oxygen = Datatable.Oxygen + parseInt(Amount)
        if Datatable.Oxygen > 100 then
            Datatable.Oxygen = 100
        end
        TriggerClientEvent("hud:Oxygen", source, Datatable.Oxygen)
    end
end

function vRP.UpgradeCough(Passport, Amount)
    local Datatable = vRP.Datatable(Passport)
    local source = vRP.Source(Passport)
    if Datatable and source then
        if not Datatable.Cough then
            Datatable.Cough = 0
        end
        Datatable.Cough = Datatable.Cough + parseInt(Amount)
        if Datatable.Cough > 100 then
            Datatable.Cough = 100
        end
        TriggerClientEvent("hud:Cough", source, Datatable.Cough)
    end
end

function vRP.DowngradeThirst(Passport, Amount)
    local Datatable = vRP.Datatable(Passport)
    local source = vRP.Source(Passport)
    if Datatable and source then
        if not Datatable.Thirst then
            Datatable.Thirst = 100
        end
        Datatable.Thirst = Datatable.Thirst - parseInt(Amount)
        if Datatable.Thirst < 0 then
            Datatable.Thirst = 0
        end
        TriggerClientEvent("hud:Thirst", source, Datatable.Thirst)
    end
end

function vRP.DowngradeHunger(Passport, Amount)
    local Datatable = vRP.Datatable(Passport)
    local source = vRP.Source(Passport)
    if Datatable and source then
        if not Datatable.Hunger then
            Datatable.Hunger = 100
        end
        Datatable.Hunger = Datatable.Hunger - parseInt(Amount)
        if Datatable.Hunger < 0 then
            Datatable.Hunger = 0
        end
        TriggerClientEvent("hud:Hunger", source, Datatable.Hunger)
    end
end

function vRP.DowngradeStress(Passport, Amount)
    local Datatable = vRP.Datatable(Passport)
    local source = vRP.Source(Passport)
    if Datatable and source then
        if not Datatable.Stress then
            Datatable.Stress = 0
        end
        Datatable.Stress = Datatable.Stress - parseInt(Amount)
        if Datatable.Stress < 0 then
            Datatable.Stress = 0
        end
        TriggerClientEvent("hud:Stress", source, Datatable.Stress)
    end
end

function vRP.DowngradeOxygen(Passport, Amount)
    local Datatable = vRP.Datatable(Passport)
    local source = vRP.Source(Passport)
    if Datatable and source then
        if not Datatable.Oxygen then
            Datatable.Oxygen = 0
        end
        Datatable.Oxygen = Datatable.Oxygen - parseInt(Amount)
        if Datatable.Oxygen < 0 then
            Datatable.Oxygen = 0
        end
        TriggerClientEvent("hud:Oxygen", source, Datatable.Oxygen)
    end
end

function vRP.DowngradeCough(Passport, Amount)
    local Datatable = vRP.Datatable(Passport)
    local source = vRP.Source(Passport)
    if Datatable and source then
        if not Datatable.Cough then
            Datatable.Cough = 0
        end
        Datatable.Cough = Datatable.Cough - parseInt(Amount)
        if Datatable.Cough < 0 then
            Datatable.Cough = 0
        end
        TriggerClientEvent("hud:Cough", source, Datatable.Cough)
    end
end

function tvRP.Foods()
    local source = source
    local Passport = vRP.Passport(source)
    local Datatable = vRP.Datatable(Passport)
    if source and Datatable then
        if not Datatable.Thirst then
            Datatable.Thirst = 100
        end
        if not Datatable.Hunger then
            Datatable.Hunger = 100
        end
        Datatable.Hunger = Datatable.Hunger - 1
        Datatable.Thirst = Datatable.Thirst - 1
        if Datatable.Thirst < 0 then
            Datatable.Thirst = 0
        end
        if Datatable.Hunger < 0 then
            Datatable.Hunger = 0
        end
    end
end

function vRP.GetHealth(source)
    return GetEntityHealth(GetPlayerPed(source))
end

function vRP.ModelPlayer(source)
    if GetEntityModel(GetPlayerPed(source)) == GetHashKey("mp_f_freemode_01") then
        return "mp_f_freemode_01"
    end
    return "mp_m_freemode_01"
end

function vRP.GetExperience(Passport, Work)
    local Datatable = vRP.Datatable(Passport)
    if Datatable and not Datatable[Work] then
        Datatable[Work] = 0
    end
    return Datatable[Work] or 0
end

function vRP.PutExperience(Passport, Work, Number)
    local Datatable = vRP.Datatable(Passport)
    if Datatable then
        if not Datatable[Work] then
            Datatable[Work] = 0
        end
        Datatable[Work] = Datatable[Work] + Number
    end
end

function vRP.SetArmour(source, Amount)
    local Ped = GetPlayerPed(source)
    if GetPedArmour(Ped) + Amount > 100 then
        Amount = 100 - GetPedArmour(Ped)
    end
    SetPedArmour(Ped, GetPedArmour(Ped) + Amount)
end

function vRP.Teleport(source, x, y, z)
    SetEntityCoords(GetPlayerPed(source), x + 1.0E-4, y + 1.0E-4, z + 1.0E-4, false, false, false, false)
end

function vRP.GetEntityCoords(source)
    return GetEntityCoords(GetPlayerPed(source))
end

function tvRP.CreatePed(Model, x, y, z, heading, typ)
    local Ped = CreatePed(typ, GetHashKey(Model), x, y, z, heading, true, false)
    while true do
        if DoesEntityExist(Ped) then
            break
        end
        if not (1000 >= 0) then
            break
        end
        Wait(1)
    end
    if DoesEntityExist(Ped) then
        return true, NetworkGetNetworkIdFromEntity(Ped)
    end
    return false
end

function tvRP.CreateObject(Model, x, y, z, Weapon)
    local source = source
    local Passport = vRP.Passport(source)
    if Passport then
        local SpawnObjects = 0
        local Object = CreateObject(GetHashKey(Model), x, y, z, true, true, false)

        while not DoesEntityExist(Object) and SpawnObjects <= 1000 do
            SpawnObjects = SpawnObjects + 1
            Wait(1)
        end
        local Network = NetworkGetNetworkIdFromEntity(Object)
        if DoesEntityExist(Object) then
            if Weapon then
                if not Objects[Passport] then
                    Objects[Passport] = {}
                end
                Objects[Passport][Weapon] = Network
            else
                if not Objects[Passport] then
                    Objects[Passport] = {}
                end
                Objects[Passport][Network] = true
            end
            return true, Network
        end
    end
    return false
end

CreateThread(function()
    while true do
        for k, v in pairs(Sources) do
            if TemperatureEffect then
                if GlobalState["Temperature"] >= TemperatureHot then
                    vRP.DowngradeHunger(k, ConsumeHunger)
                    vRP.DowngradeThirst(k, ConsumeThirst * 2)
                elseif GlobalState["Temperature"] <= TemperatureCold then
                    vRP.DowngradeHunger(k, ConsumeHunger * 2)
                    vRP.DowngradeThirst(k, ConsumeThirst)
                else
                    vRP.DowngradeHunger(k, ConsumeHunger)
                    vRP.DowngradeThirst(k, ConsumeThirst)
                end
            else
                vRP.DowngradeHunger(k, ConsumeHunger)
                vRP.DowngradeThirst(k, ConsumeThirst)
            end
        end

        Wait(CooldownHungerThrist)
    end
end)

RegisterServerEvent("vRP:BucketClient")
AddEventHandler("vRP:BucketClient", function(value)
    local source = source
    local Passport = vRP.Passport(source)
    if Passport then
        if "Enter" == value then
            Player(source).state.Route = Passport
            SetPlayerRoutingBucket(source, Passport)
        else
            Player(source).state.Route = 0
            SetPlayerRoutingBucket(source, 0)
        end
    end
end)

RegisterServerEvent("vRP:BucketServer")
AddEventHandler("vRP:BucketServer", function(source, value, bucket)
    if "Enter" == value then
        Player(source).state.Route = bucket
        SetPlayerRoutingBucket(source, bucket)
        if bucket > 0 then
            SetRoutingBucketEntityLockdownMode(0, EntityLockdown)
            SetRoutingBucketPopulationEnabled(bucket, false)
        end
    else
        Player(source).state.Route = 0
        SetPlayerRoutingBucket(source, 0)
    end
end)

function vRP.Groups()
    return Groups
end

function vRP.DataGroups(Permission)
    return vRP.GetServerData("Permissions:" .. Permission)
end

function vRP.GetUserType(Passport, Type)
    for k, _ in pairs(Groups) do
        local Datatable = vRP.GetServerData("Permissions:" .. k)
        if Groups[k]["Type"] and Groups[k]["Type"] == Type and Datatable[tostring(Passport)] then
            return k
        end
    end
    return false
end

function vRP.CheckGroup(Permission)
    if Groups[Permission] and Groups[Permission] then
        return true
    end
    return false
end

function vRP.GroupType(Permission)
    if Groups[Permission] and Groups[Permission]["Type"] then
        return Groups[Permission]["Type"]
    end
    return false
end

function vRP.GroupMax(Permission)
    if Groups[Permission] and Groups[Permission]["Max"] then
        return Groups[Permission]["Max"]
    end
    return false
end

function vRP.GroupCount(Permission)
    if Groups[Permission] then
        local Entitys = vRP.DataGroups(Permission)
        local Count = 0
        for i in pairs(Entitys) do
            Count = Count + 1
        end
        return Count
    end
    return 0
end

function vRP.UserHierarchy(Passport, Permission)
    local Datatable = vRP.GetServerData("Permissions:" .. Permission)
    if Datatable[tostring(Passport)] then
        return Datatable[tostring(Passport)]
    end
    return false
end

function vRP.Hierarchy(Permission)
    if Groups[Permission] and Groups[Permission]["Hierarchy"] then
        return Groups[Permission]["Hierarchy"]
    end
    return false
end

function vRP.GroupSalary(Permission, Hierarchy)
    if Hierarchy then
        for k, v in pairs(Groups) do
            if k == Permission then
                if Hierarchy then
                    return v["Salary"][Hierarchy]
                else
                    return v["Salary"]
                end
            end
        end
    end
end

function vRP.NumPermission(Permission)
    local Services = {}
    local Amount = 0

    if Groups[Permission] and Groups[Permission]["Parent"] then
        for k, _ in pairs(Groups[Permission]["Parent"]) do
            if Groups[k] and Groups[k]["Service"] then
                for i, j in pairs(Groups[k]["Service"]) do
                    if j and Characters[j] and not ({})[i] then
                        Amount = Amount + 1
                        Services[i] = j
                    end
                end
            end
        end
    end
    return Services, Amount
end

function vRP.ServiceToggle(Source, Passport, Permission, Silenced)
    local Perm = splitString(Permission, "-")
    if Characters[Source] and Groups[Perm[1]] and Groups[Perm[1]]["Service"] then
        if Groups[Perm[1]]["Service"][tostring(Passport)] == Source then
            vRP.ServiceLeave(Source, tostring(Passport), Perm[1], Silenced)
        elseif vRP.HasGroup(tostring(Passport), Perm[1]) and not Groups[Perm[1]]["Service"][tostring(Passport)] then
            vRP.ServiceEnter(Source, tostring(Passport), Perm[1], Silenced)
        end
    end
end

function vRP.ServiceEnter(Source, Passport, Permission, Silenced)
    if Characters[Source] and Groups[Permission] then
        if Groups[Permission]["Client"] then
            Player(Source)["state"][Permission] = true
            TriggerClientEvent("service:Label", Source, Permission, "Sair de Serviço")
            for k, v in pairs(Groups["Policia"]["Parent"]) do
                if k == Permission and v then
                    Player(Source)["state"]["Policia"] = true
                end
            end
        end
        if GroupBlips[Permission] then
            exports["markers"]:Enter(Source, Permission)
        end
        if Groups[Permission]["Salary"] then
            TriggerEvent("Salary:Add", tostring(Passport), Permission)
        end
        Groups[Permission]["Service"][tostring(Passport)] = Source
        exports["vrp"]:Embed("Services",
            "**Passaporte:** " .. Passport .. "\n**Entrou na permissão:** " .. Permission,
            3042892)
        if not Silenced then
            TriggerClientEvent("Notify", Source, "verde", "Entrou em serviço.", false, 5000)
        end
    end
end

function vRP.ServiceLeave(Source, Passport, Permission, Silenced)
    if Characters[Source] and Groups[Permission] then
        if Groups[Permission]["Client"] then
            Player(Source)["state"][Permission] = false
            TriggerClientEvent("service:Label", Source, Permission, "Entrar em Serviço")
            for k, v in pairs(Groups["Policia"]["Parent"]) do
                if k == Permission and v then
                    Player(Source)["state"]["Policia"] = false
                end
            end
        end
        if GroupBlips[Permission] then
            exports["markers"]:Exit(Source)
            TriggerClientEvent("radio:RadioClean", Source)
        end
        if Groups[Permission]["Service"] then
            TriggerEvent("Salary:Remove", tostring(Passport), Permission)
        end
        if Groups[Permission]["Service"] and Groups[Permission]["Service"][tostring(Passport)] then
            Groups[Permission]["Service"][tostring(Passport)] = nil
        end
        exports["vrp"]:Embed("Services",
            "**Passaporte:** " .. Passport .. "\n**Saiu da permissão:** " .. Permission,
            3042892)
        if not Silenced then
            TriggerClientEvent("Notify", Source, "verde", "Saiu de serviço.", false, 5000)
        end
    end
end

function vRP.SetPermission(Passport, Permission, Level, Mode)
    local Datatable = vRP.GetServerData("Permissions:" .. Permission)
    if Groups[Permission] then
        if Mode then
            if "Demote" == Mode then
                Datatable[tostring(Passport)] = Datatable[tostring(Passport)] + 1
                if Datatable[tostring(Passport)] > #Groups[Permission]["Hierarchy"] then
                    Datatable[tostring(Passport)] = #Groups[Permission]["Hierarchy"]
                end
            else
                Datatable[tostring(Passport)] = Datatable[tostring(Passport)] - 1
                if Datatable[tostring(Passport)] < 1 then
                    Datatable[tostring(Passport)] = 1
                end
            end
        else
            if Level then
                Level = parseInt(Level)
                if Level > #Groups[Permission]["Hierarchy"] then
                    Level = #Groups[Permission]["Hierarchy"]
                    Datatable[tostring(Passport)] = Level
                else
                    Datatable[tostring(Passport)] = Level
                end
            end
            if not Level then
                Datatable[tostring(Passport)] = #Groups[Permission]["Hierarchy"]
            end
        end
        vRP.ServiceEnter(vRP.Source(Passport), tostring(Passport), Permission, true)
        vRP.Query("entitydata/SetData",
            { Name = "Permissions:" .. Permission, Information = json.encode(Datatable) })
    end
end

function vRP.RemovePermission(Passport, Permission)
    local Datatable = vRP.GetServerData("Permissions:" .. Permission)
    if Groups[Permission] then
        if Groups[Permission]["Service"] and Groups[Permission]["Service"][tostring(Passport)] then
            Groups[Permission]["Service"][tostring(Passport)] = nil
        end
        if Datatable[tostring(Passport)] then
            Datatable[tostring(Passport)] = nil
            vRP.ServiceLeave(vRP.Source(tostring(Passport)), tostring(Passport), Permission, true)
            vRP.Query("entitydata/SetData",
                { Name = "Permissions:" .. Permission, Information = json.encode(Datatable) })
        end
    end
end

function vRP.HasPermission(Passport, Permission, Level)
    local Datatable = vRP.GetServerData("Permissions:" .. Permission)
    if Datatable[tostring(Passport)] then
        if not Level or Level >= Datatable[tostring(Passport)] then
            return true
        end
    end
    return false
end

function vRP.HasGroup(Passport, Permission, Level)
    if Groups[Permission] then
        for k, _ in pairs(Groups[Permission]["Parent"]) do
            local Datatable = vRP.GetServerData("Permissions:" .. k)
            if Datatable[tostring(Passport)] then
                if not Level or Level >= Datatable[tostring(Passport)] then
                    return true
                end
            end
        end
    end
    return false
end

function vRP.HasService(Passport, Permission)
    if Groups[Permission] then
        for k, _ in pairs(Groups[Permission]["Parent"]) do
            if Groups[k]["Service"][tostring(Passport)] then
                return true
            end
        end
    end
    return false
end

AddEventHandler("Salary:Add", function(Passport, Permission)
    if not Salary[Permission] then
        Salary[Permission] = {}
    end
    if not Salary[Permission][Passport] then
        Salary[Permission][Passport] = os.time() + SalarySeconds
    end
end)

AddEventHandler("Salary:Remove", function(Passport, Permission)
    if Permission then
        if Salary[Permission] and Salary[Permission][Passport] then
            Salary[Permission][Passport] = nil
        end
    else
        for k, _ in pairs(Salary) do
            if Salary[k][Passport] then
                Salary[k][Passport] = nil
            end
        end
    end
end)

CreateThread(function()
    while true do
        Wait(60000)
        for _, k in pairs(vRP.Players()) do
            local Passport = vRP.Passport(k)
            if Passport then
                for i, _ in pairs(Salary) do
                    if Salary[i][Passport] then
                        local Hierarchy = vRP.UserHierarchy(Passport, i)
                        if os.time() >= Salary[i][Passport] and Hierarchy and vRP.GroupSalary(i, Hierarchy) then
                            if Groups[i]["Type"] == "Work" then
                                if vRP.HasService(Passport, i) then
                                    vRP.GiveBank(Passport, vRP.GroupSalary(i, Hierarchy))
                                    Salary[i][Passport] = os.time() + SalarySeconds
                                end
                            else
                                vRP.GiveBank(Passport, vRP.GroupSalary(i, Hierarchy))
                                Salary[i][Passport] = os.time() + SalarySeconds
                            end
                        end
                    else
                        Salary[i][Passport] = os.time() + SalarySeconds
                    end
                end
            end
        end
    end
end)

function vRP.Blackout()
    if GlobalState["Blackout"] then
        SetTimeout(BlackoutTime, function()
            GlobalState["Blackout"] = false
            TriggerClientEvent("Notify", -1, "azul", BlackoutText, "Central de Eletricidade", 10000)
        end)
    end
end

AddEventHandler("Connect", function(Passport, Source)
    for k, _ in pairs(Groups) do
        if vRP.GetServerData("Permissions:" .. k)[tostring(Passport)] then
            if Groups[k]["Service"] then
                vRP.ServiceToggle(Source, Passport, k, true)
            end
            if Groups[k]["Salary"] then
                TriggerEvent("Salary:Add", tostring(Passport), k)
            end
            if vRP.HasGroup(Passport, "Admin") then
                Player(Source)["state"]["Admin"] = true
            end
        end
    end
end)

AddEventHandler("Disconnect", function(Passport, Source)
    for k, _ in pairs(Groups) do
        if Groups[k]["Service"][tostring(Passport)] then
            if GroupBlips[k] then
                exports["markers"]:Exit(Source)
            end
            Groups[k]["Service"][tostring(Passport)] = false
        end
        if Groups[k] and Groups[k]["Salary"] then
            TriggerEvent("Salary:Remove", tostring(Passport), k)
        end
        if vRP.HasGroup(Passport, "Admin") then
            Player(Source)["state"]["Admin"] = false
        end
    end
    TriggerEvent("DebugObjects", Passport)
    TriggerEvent("DebugWeapons", Passport)
    for k, _ in pairs(Salary) do
        if Salary[k][Passport] then
            Salary[k][Passport] = nil
        end
    end
end)