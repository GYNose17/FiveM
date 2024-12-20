----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- CONEXÃO
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

src = {}
Tunnel.bindInterface("flow_hud",src)
vCLIENT = Tunnel.getInterface("flow_hud")

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- SISTEMA DE CLIMA
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
local hora = 12
local minuto = 0
GlobalState.time = {}

Citizen.CreateThread(function()
    while true do
        
        if parseInt(hora) >= 00 and parseInt(hora) < 8 then
            minuto = minuto + 6
        else
            minuto = minuto + 2
        end

        if parseInt(minuto) >= 60 then
            hora = hora + 1
            minuto = 0

            if parseInt(hora) >= 24 then
                hora = 0
            end
        end

        GlobalState.time = { hora,parseInt(minuto) }

        Citizen.Wait( 10 * 1000 )
    end
end)

RegisterCommand('time', function(source,args)
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
        if vRP.hasPermission(user_id, "admin.permissao") then
            if args[1] and args[2] and parseInt(args[1]) >= 0 and parseInt(args[1]) <= 23 and parseInt(args[2]) >= 0 and parseInt(args[2]) <= 60 then
                hora = parseInt(args[1])
                minuto = parseInt(args[2])

                GlobalState.time = { hora,parseInt(minuto) }
            else
                TriggerClientEvent("Notify",source,"negado","Digite o tempo corretamente, entre 00 00 ate 23 00", 5)
            end
        end
    end
end)

function src.requestHud()
	local source = source
	local user_id = vRP.getUserId(source)

	print("Peguei o troxa do - ".. user_id)
end

function src.checkhud()
    local source = source
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id,"admin.permissao")  then
        return true
    end
end
