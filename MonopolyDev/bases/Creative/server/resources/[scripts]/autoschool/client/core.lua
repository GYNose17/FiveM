-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
vSERVER = Tunnel.getInterface("autoschool")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
Area = 0
Route = 0
Errors = 0
Mount = nil
Hits = false
Checks = nil
OnRoad = false
InSchool = false
AutoDrive = false
SaveCoords = { 0.0, 0.0, 0.0 }
-----------------------------------------------------------------------------------------------------------------------------------------
-- AUTOSCHOOL:START
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("autoschool:start")
AddEventHandler("autoschool:start", function()
	if vSERVER.Payment() then
		if not InSchool then
			InSchool = true

			local Ped = PlayerPedId()
			local Coords = GetEntityCoords(Ped)
			SaveCoords = { Coords["x"], Coords["y"], Coords["z"] }
			DoScreenFadeOut(1000)
			Wait(1000)

			AutoDrive = true
			SpawnVehicle("dilettante")
			SetPedIntoVehicle(Ped, Mount, -1)

			LocalPlayer["state"]:set("Commands", true, true)
			LocalPlayer["state"]:set("TestDrive", true, false)
			LocalPlayer["state"]:set("DrivingSchool", true, false)

			DoScreenFadeIn(1000)

			TriggerEvent("autoschool:route")
		else
			TriggerEvent("Notify", "amarelo", "Você não pode fazer isso agora.", "Atenção", 5000)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SPAWNVEHICLE
-----------------------------------------------------------------------------------------------------------------------------------------
function SpawnVehicle(Data)
	if LoadModel(Data) then
		Mount = CreateVehicle(Data, 213.7, 388.78, 106.46, 170.08, false, false)

		SetVehicleModKit(Mount, 0)
		ToggleVehicleMod(Mount, 18, true)
		SetVehicleExtraColours(Mount, 147, 147)
		SetVehicleMod(Mount, 11, GetNumVehicleMods(Mount, 11) - 1, false)
		SetVehicleMod(Mount, 12, GetNumVehicleMods(Mount, 12) - 1, false)
		SetVehicleMod(Mount, 13, GetNumVehicleMods(Mount, 13) - 1, false)
		SetVehicleMod(Mount, 15, GetNumVehicleMods(Mount, 15) - 1, false)

		SetVehicleNumberPlateText(Mount, "PDMSPORT")
		SetModelAsNoLongerNeeded(Mount)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- AUTOSCHOOL:ROUTE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("autoschool:route")
AddEventHandler("autoschool:route", function()
	if AutoDrive then
		Route = 1
		OnRoad = true
		MakeBlips(214.75, 363.58, 106.23)
		SendNUIMessage({ Action = "Display", Mode = "block" })
		FreezeEntityPosition(GetVehiclePedIsUsing(GetPlayerPed(-1)), true)
		SendNUIMessage({ Action = "Message", Message = "AGUARDE A NOTIFICAÇÃO" })
		TriggerEvent("Notify", "amarelo", "Siga a rota marcada em seu <b>GPS</b> seguindo as instruções, você está sendo avaliado, seus errors podem acarretar na falha do seu teste.", "Atenção", 10000)

		SetTimeout(10000, function()
			FreezeEntityPosition(GetVehiclePedIsUsing(GetPlayerPed(-1)), false)
			SendNUIMessage({ Action = "Message", Message = "VEÍCULO LIBERADO, BOA SORTE" })
		end)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADDRIVE
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		local TimeDistance = 999

		if AutoDrive then
			TimeDistance = 1

			local Ped = PlayerPedId()
			if not IsPedInAnyVehicle(Ped) then
				RemoveBlips()
				CancelAutoschool()
				vSERVER.RemoveDrive()
				LocalPlayer["state"]:set("Commands", false, true)
				LocalPlayer["state"]:set("TestDrive", false, false)
				LocalPlayer["state"]:set("DrivingSchool", false, false)
				SetEntityCoords(Ped, SaveCoords[1], SaveCoords[2], SaveCoords[3], false, false, false, false)

				if DoesEntityExist(Mount) then
					DeleteEntity(Mount)
				end
			end
		end

		Wait(TimeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CANCELAUTOSCHOOL
-----------------------------------------------------------------------------------------------------------------------------------------
function CancelAutoschool()
	if AutoDrive then
		Area = 0
		Route = 0
		OnRoad = false
		InSchool = false
		AutoDrive = false

		SendNUIMessage({ Action = "Display", Mode = "none" })
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADERROS
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		Wait(3000)

		local Ped = PlayerPedId()
		local Vehicle = GetVehiclePedIsIn(Ped)
		local Velocity = GetEntitySpeed(Vehicle) * 2.236936
		if InSchool then
			if Area == 1 then
				if Velocity > 60 then
					Errors = Errors + 1
					TriggerEvent("Notify", "amarelo", "Você excedeu o limite de velocidade.", "Atenção", 5000)
				end
			elseif Area == 2 then
				if Velocity > 80 then
					Errors = Errors + 1
					TriggerEvent("Notify", "amarelo", "Você excedeu o limite de velocidade.", "Atenção", 5000)
				end
			elseif Area == 3 then
				if Velocity > 120 then
					Errors = Errors + 1
					TriggerEvent("Notify", "amarelo", "Você excedeu o limite de velocidade.", "Atenção", 5000)
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADVELOCITY
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		local TimeDistance = 1000
		if InSchool then
			TimeDistance = 5

			local Ped = PlayerPedId()
			local Vehicle = GetVehiclePedIsIn(Ped)
			if HasEntityCollidedWithAnything(Vehicle) and not Hits then
				Hits = true

				SetTimeout(5000, function()
					Hits = false
					Errors = Errors + 1
					TriggerEvent("Notify", "amarelo", "Você bateu o veículo.", "Atenção", 5000)
				end)
			end
		end

		Wait(TimeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- AUTOSCHOOL:FINISH
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("autoschool:finish")
AddEventHandler("autoschool:finish", function()
	if InSchool then
		InSchool = false
		SetEntityCoords(PlayerPedId(), SaveCoords[1], SaveCoords[2], SaveCoords[3], false, false, false, false)

		if Errors >= 3 then
			TriggerEvent("Notify", "vermelho", "Teste <b>negado</b>, acumulando no total: <b>" .. Errors .. " Erros</b>.", "Aviso", 5000)
		else
			TriggerEvent("Notify", "verde", "Teste <b>aprovado</b>, <b>Parabéns</b>.", "Sucesso", 5000)
			vSERVER.Finish()
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- MAKEBLIPS
-----------------------------------------------------------------------------------------------------------------------------------------
function MakeBlips(x, y, z)
	if DoesBlipExist(Checks) then
		RemoveBlip(Checks)
		Checks = nil
	end

	Checks = AddBlipForCoord(x, y, z)
	SetBlipSprite(Checks, 12)
	SetBlipColour(Checks, 2)
	SetBlipScale(Checks, 0.9)
	SetBlipRoute(Checks, true)
	SetBlipAsShortRange(Checks, true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("Auto Escola")
	EndTextCommandSetBlipName(Checks)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- REMOVEBLIPS
-----------------------------------------------------------------------------------------------------------------------------------------
function RemoveBlips()
	if DoesBlipExist(Checks) then
		RemoveBlip(Checks)
		Checks = nil
	end
end