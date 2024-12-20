------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- QUERYS DEALERSHIP
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
vRP._prepare("bm_module/dealership/createTable", "CREATE TABLE IF NOT EXISTS `bm_dealership` ( `vehicle` varchar(50) NOT NULL, `stock` int(11) DEFAULT 0, PRIMARY KEY (`vehicle`) ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4; ")
vRP._prepare("bm_module/dealership/getVehicles", "SELECT * FROM bm_dealership")
vRP._prepare("bm_module/dealership/updateStock", "UPDATE bm_dealership SET stock = @stock WHERE vehicle = @vehicle")
vRP._prepare("bm_module/dealership/removeVehicle", "DELETE FROM bm_dealership WHERE vehicle = @vehicle")
vRP._prepare("bm_module/dealership/addVehicle", "REPLACE INTO bm_dealership(vehicle,stock) VALUES(@vehicle,@stock)")

vRP._prepare("bm_module/dealership/getVehicle", "SELECT veiculo FROM vrp_user_veiculos WHERE user_id = @user_id AND veiculo = @vehicle")
vRP._prepare("bm_module/dealership/totalVehicles", "SELECT COUNT(veiculo) as qtd FROM vrp_user_veiculos WHERE user_id = @user_id")
vRP._prepare("bm_module/dealership/addUserVehicle", "INSERT INTO vrp_user_veiculos(user_id,veiculo,ipva) VALUES(@user_id,@vehicle,@ipva)")
vRP._prepare("bm_module/dealership/removeUserVehicle", "DELETE FROM vrp_user_veiculos WHERE veiculo = @vehicle AND user_id = @user_id")

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- FUNCTIONS DEALERSHIP
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
local dealership = {
    list = {}
}

function dealership:addCar(index, value, insert)
    self.list[index] = value

    if insert then
        vRP._execute("bm_module/dealership/addVehicle", { vehicle = index, stock = self.list[index].stock })
    end
end

function dealership:remCar(index)
    if not self.list[index] then return end

    self.list[index] = nil
    vRP._execute("bm_module/dealership/removeVehicle", { vehicle = index })
end

function dealership:getCar(index)
    if not index then return end
    if not self.list[index] then print("Cadastrar o veiculo: "..index) return false end

    return self.list[index]
end

function dealership:updateStock(index, amount)
    if not self.list[index] then return end

    self.list[index].stock = amount
    vRP._execute("bm_module/dealership/updateStock", { vehicle = index, stock = self.list[index].stock })
end

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- TUNNELS
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function RegisterTunnel.dealershipRequest(type, value)
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
        if type == "addCar" then
            dealership:addCar(value.vehicle, {
                name = getVehicleName(value.vehicle),
                stock = value.stock,
                price = getVehiclePrice(value.vehicle),
                type = getVehicleType(value.vehicle)
            }, true)

            return
        end

        if type == "remCar" then
            dealership:remCar(value)
            return
        end

        if type == "updateCar" then
            dealership:updateStock(value.vehicle, value.amount)
            return
        end

        if type == "requestList" then
            local vips = dealershipConfig.main['zoneVips']
            local discount = 0
            for i = 1, #dealershipConfig.main['zoneVips'] do
                if vRP.hasPermission(user_id, vips[i].permission) then
                    discount = vips[i].discount
                end
            end
            return dealership.list, discount
        end

        if type == "requestMyVehicles" then
            local query = vRP.query("bm_module/garages/getAllUserVehicles", { user_id = user_id })
            local t = {}
            
            for i = 1, #query do
                local vehPrice = getVehiclePrice(query[i].veiculo)

                t[#t + 1] = {
                    spawn =  query[i].veiculo,
                    name = getVehicleName(query[i].veiculo),
                    price = parseInt(vehPrice - (vehPrice * dealershipConfig.main['sellVehicle'] / 100)),
                    type = getVehicleType(query[i].veiculo) or "nenhum",
                    stock = dealership:getCar(query[i].veiculo).stock or 0,
                    trunk = dealership:getCar(query[i].veiculo).trunk or 0,
                }
            end

            return t
        end
    end
end

function RegisterTunnel.dealershipBuyVehicle(name)
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
        local status, time = exports['vrp']:getCooldown(user_id, "conce")
        if status then
            exports['vrp']:setCooldown(user_id, "conce", 5)

            local car = dealership:getCar(name)
            if car then
                if car.stock <= 0 then
                    TriggerClientEvent("Notify",source,"negado","Veiculo sem stock.", 5)
                    return
                end

                local query = vRP.query("bm_module/dealership/getVehicle", { user_id = user_id, vehicle = name })
                if #query > 0 then
                    TriggerClientEvent("Notify",source,"negado","Você já possui esse veiculo em sua garagem.", 5)
                    return
                end

                local maxCars, totalCars = getUserAmountCars(user_id)
                if totalCars >= maxCars then
                    TriggerClientEvent("Notify",source,"negado","Você não possui mais vagas na garagem.", 5)
                    return
                end

                local vips = dealershipConfig.main['zoneVips']
                local discount = 0
                for i = 1, #dealershipConfig.main['zoneVips'] do
                    if vRP.hasPermission(user_id, vips[i].permission) then
                        discount = vips[i].discount
                    end
                end

                local price = parseInt(car.price - ( car.price * discount/100 ))
                if vRP.tryFullPayment(user_id, price) then
                    TriggerClientEvent("Notify",source,"sucesso","Parabens pela compra!!! Você comprou um <b>"..car.name.."</b> por <b>R$ "..vRP.format(price).."</b>", 5)
                    
                    vRP.execute("bm_module/dealership/addUserVehicle", { user_id = user_id, vehicle = name, ipva = os.time() })
                    dealership:updateStock(name, (car.stock - 1))
                else
                    TriggerClientEvent("Notify",source,"negado","Você não possui dinheiro.", 5)
                end
            end
        end
    end
end

function RegisterTunnel.dealershipSellVehicle(name)
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
        local status, time = exports['vrp']:getCooldown(user_id, "conce")
        if status then
            exports['vrp']:setCooldown(user_id, "conce", 5)

            local car = dealership:getCar(name)
            if car then
                local query = vRP.query("bm_module/dealership/getVehicle", { user_id = user_id, vehicle = name })
                if #query > 0 then
                    local price = parseInt(car.price - (car.price * dealershipConfig.main['sellVehicle'] / 100))

                    vRP.giveMoney(user_id, price)
                    TriggerClientEvent("Notify",source,"sucesso","Você vendeu seu veiculo <b>"..car.name.."</b> para concessionaria e recebeu R$ ".. price, 5)

                    vRP.execute("bm_module/dealership/removeUserVehicle", { user_id = user_id, vehicle = name })
                    vRP.sendLog("https://discord.com/api/webhooks/1033206127820804168/mVmgJXu3w1X8FOmdh9ROmHwRjwM7gQiUKsSKtntITwfUFmklc6_zv2w0_OInbYCxV9rJ", "```prolog\n[USER_ID]: "..user_id.."\n[VENDEU]: "..car.name.."\n[POR]: "..price.."```")
                else
                    TriggerClientEvent("Notify",source,"negado","Você não possui esse veiculo em sua garagem.", 5)
                end
            end
        end
    end
end

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- OTHERS FUNCTIONS
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function getUserAmountCars(user_id)
    if user_id then
        local query = vRP.query("bm_module/dealership/totalVehicles", { user_id = user_id })
        if query then
            local maxCars = dealershipConfig.main['maxCars']
            local vips = dealershipConfig.main['zoneVips']
            local totalCars = query[1].qtd
            for i = 1, #dealershipConfig.main['zoneVips'] do
                if vRP.hasPermission(user_id, vips[i].permission) then
                    maxCars = maxCars + vips[i].maxCars
                end
            end

            return maxCars,totalCars
        end
    end
end

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- LOAD DEALERSHIP VEHICLES
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
    vRP._execute("bm_module/dealership/createTable", {})

    local query = vRP.query("bm_module/dealership/getVehicles", {})
    for i = 1, #query do
        dealership:addCar(query[i].vehicle, {
            name = getVehicleName(query[i].vehicle),
            stock = query[i].stock,
            price = getVehiclePrice(query[i].vehicle),
            type = getVehicleType(query[i].vehicle),
            trunk = getVehicleTrunk(query[i].vehicle)
        }, false)
    end
end)

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- COMMANDS
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('conce', function(source, args)
    local user_id = vRP.getUserId(source)
    if user_id then
        if not vRP.hasPermission(user_id, "developer.permissao") then return end

        local query = vRP.query("bm_module/dealership/getVehicles", {})
        local t = ""

        for i = 1, #query do
            t = t..", "..query[i].vehicle
        end

        local v_value = vRP.prompt(source, "Digite o veiculo: ", t)
        if v_value == "" or not v_value then
            return
        end

        local s_value = vRP.prompt(source, "Digite a quantidade de estoque: ", 100)
        if s_value == "" or not s_value then
            return
        end

        dealership:updateStock(v_value, s_value)
        TriggerClientEvent("Notify",source,"sucesso","Você alterou o stock do veiculo: "..v_value.." para "..s_value.."x .", 5)
    end
end)