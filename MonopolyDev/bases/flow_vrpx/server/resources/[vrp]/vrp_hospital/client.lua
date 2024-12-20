local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")

src = {}
Tunnel.bindInterface("vrp_hospital",src)
vSERVER = Tunnel.getInterface("vrp_hospital")

local segundos = 0

----------------------------------------------------------------------------------------------------------------------------------------
-- SISTEMA DE TRATAMENTO
----------------------------------------------------------------------------------------------------------------------------------------
local in_area = 0 
local deitado = false
local tratamento = false
local segundosT = 0
local vida = 0

local macas = {
    [1] = { 1133.11,-1578.36,35.38 , deitado = { 1133.04,-1579.95,36.29,175.66 } },
    [2] = { 1127.93,-1580.62,35.38 , deitado = { 1126.48,-1580.55,36.29,90.68 } },
    [3] = { 1127.94,-1583.77,35.38 , deitado = { 1126.45,-1584.34,36.29,83.96 } },
    [4] = { 1127.9,-1588.21,35.38 , deitado = { 1126.38,-1588.11,36.29,87.49 } },
    [5] = { 1128.0,-1591.37,35.38 , deitado = { 1126.53,-1592.01,36.29,83.49 } },
    [6] = {1147.68,-1562.66,35.38 , deitado = { 1148.83,-1563.03,36.29,178.54 } },
    [7] = {1147.73,-1565.88,35.38 , deitado = { 1149.05,-1565.77,36.29,5.67} },   
    [8] = {1137.54,-1572.92,35.38 , deitado = { 1137.78,-1573.59,36.33,93.82} }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECAR AREA
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local time = 1000
		local x,y,z = table.unpack(GetEntityCoords(PlayerPedId()))

		for k,v in pairs(macas) do
            local entrada = (GetDistanceBetweenCoords(v[1],v[2],v[3],x,y,z,true) <= 2)

			if entrada then
				in_area = tonumber(k)
			end 
		end

		Citizen.Wait(time)
	end
end)

function src.retirarMascaraH()
    SetPedComponentVariation(PlayerPedId(), 1, 0,0,2)
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- SISTEMA DE MACAS
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local time = 1000
		local ped = PlayerPedId()
		local x,y,z = table.unpack(GetEntityCoords(PlayerPedId()))

		if tonumber(in_area) > 0 and not deitado then
			if GetDistanceBetweenCoords(macas[tonumber(in_area)][1],macas[tonumber(in_area)][2],macas[tonumber(in_area)][3],x,y,z,true) <= 1.5 then
				time = 5
				DrawText3Ds(macas[tonumber(in_area)][1],macas[tonumber(in_area)][2],macas[tonumber(in_area)][3], "~b~[MACA: "..tonumber(tonumber(in_area)).."]\n~w~[~g~E~w~] Deitar\n~w~[~b~F~w~] Iniciar tratamento")


                if IsControlJustReleased(1, 51) and segundos <= 0 and vSERVER.checkPagamento(3000) then
                    segundos = 5
                    DoScreenFadeOut(1000)

                    Citizen.Wait(2000)
                    SetEntityHeading(ped, macas[tonumber(in_area)].deitado[4])
                    SetEntityCoords(ped, macas[tonumber(in_area)].deitado[1],macas[tonumber(in_area)].deitado[2],macas[tonumber(in_area)].deitado[3]-0.9)
                    vRP.playAnim(false,{{"amb@world_human_sunbathe@female@back@idle_a","idle_a",1}},true)

                    Citizen.Wait(2000)
                    DoScreenFadeIn(1000)

                    if vSERVER.checkUNZIK() then
                        deitado = true
                        tratamento = false
                        segundosT = 0
                        TriggerEvent("blockcel", true)
                    else
                        deitado = true
                        tratamento = true
                        segundosT = 30
                        vida = 110
                        SetEntityHealth(ped, vida)
                        vSERVER._blockCommands(59)
                        TriggerEvent("Notify","importante","Nenhum medico em expediente, você esta sendo tratado pelos medicos da prefeitura", 5)
                        TriggerEvent("blockcel", true)
                    end
                end

                if IsControlJustReleased(1, 49) and segundos <= 0 then
                    segundos = 5
                    if vSERVER.checkTratamento() then
                        TriggerEvent("Notify","importante","Você iniciou tratamento nesse jogador.", 5)
                    end
                end
            end

			if GetDistanceBetweenCoords(macas[tonumber(in_area)][1],macas[tonumber(in_area)][2],macas[tonumber(in_area)][3],x,y,z,true) >= 3 then
				in_area = 0
			end
		end
	
		Citizen.Wait(time)
	end
end) 

-----------------------------------------------------------------------------------------------------------------------------------------
-- DEITADO
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
    while true do
        local time = 1000

        if deitado and not tratamento and segundosT == 0 then
            time = 5
            drawTxt("VOCÊ ESTÁ ~r~DEITADO~w~, PARA LEVANTAR PRESSIONE ~b~[F6]~w~ OU AGUARDE UM MÉDICO VIR TE ATENDER.",4,0.5,0.96,0.50,255,255,255,180)

            if IsControlJustPressed(0, 167) then
                deitado = false
                segundosT = 0
                tratamento = false
                TriggerEvent("blockcel", false)
            end
            
            DisableControlAction(2, 37, true)
            if IsDisabledControlJustPressed(2, 37) then
				SetCurrentPedWeapon(GetPlayerPed(-1),GetHashKey("WEAPON_UNARMED"),true)
            end
        elseif deitado and tratamento and segundosT > 0 then
            time = 5
            drawTxt("VOCÊ ESTÁ EM ~b~TRATAMENTO~w~, AGUARDE ~b~"..segundosT.."~w~ SEGUNDO(s) PARA SE LEVANTAR.",4,0.5,0.96,0.50,255,255,255,180)

            DisableControlAction(2, 37, true)
            if IsDisabledControlJustPressed(2, 37) then
				SetCurrentPedWeapon(GetPlayerPed(-1),GetHashKey("WEAPON_UNARMED"),true)
            end
        elseif deitado and segundosT == -1 and not tratamento then
            time = 5
            drawTxt("SEU ~b~TRATAMENTO~w~ ACABOU, PRESSIONE ~b~[F6]~w~ PARA LEVANTAR.",4,0.5,0.96,0.50,255,255,255,180)
   
            if IsControlJustPressed(0, 167) then
                deitado = false
                segundosT = 0
                tratamento = false
                TriggerEvent("blockcel", false)
            end

            DisableControlAction(2, 37, true)
            if IsDisabledControlJustPressed(2, 37) then
				SetCurrentPedWeapon(GetPlayerPed(-1),GetHashKey("WEAPON_UNARMED"),true)
            end
        end

        Citizen.Wait(time)
    end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- SISTEMA TRATAMENTO
-----------------------------------------------------------------------------------------------------------------------------------------
function src.iniciarTratamento()
    deitado = true
    tratamento = true
    segundosT = 60

    vida = 110
    SetEntityHealth(ped, vida)
end

function src.checkPaciente()
    return deitado,tratamento
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- CONTADOR TRATAMENTO
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
    while true do
        local time = 1000
        local ped = PlayerPedId()

        if deitado and tratamento and segundosT > 0 then
            segundosT = segundosT - 1

            if vida >= 300 then
                SetEntityHealth(ped, 300)
            else
                vida = vida + 6
                SetEntityHealth(ped, vida)
            end

            if segundosT == 0 then
                tratamento = false
                segundosT = -1
            end
        end

        Citizen.Wait(time)
    end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- OUTROS
-----------------------------------------------------------------------------------------------------------------------------------------
function src.checkSexo()
    if GetEntityModel(PlayerPedId()) == GetHashKey("mp_m_freemode_01") then
        return "H"
    elseif GetEntityModel(PlayerPedId()) == GetHashKey("mp_f_freemode_01") then
        return "M"
    end
end

Citizen.CreateThread(function()
    while true do
        local time = 1000
        if segundos > 0 then
            segundos = segundos - 1

            if segundos <= 0 then
                segundos = 0 
            end
        end

        Citizen.Wait(time)
    end
end)

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
