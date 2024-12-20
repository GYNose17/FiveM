-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local FinalPrice = 0
local HasCaught = false
local ExtraPrice = true
local EnableBlips = true
-----------------------------------------------------------------------------------------------------------------------------------------
-- DEFAULTPRICE
-----------------------------------------------------------------------------------------------------------------------------------------
local DefaultPrice60 = 100
local DefaultPrice80 = 300
local DefaultPrice120 = 500
-----------------------------------------------------------------------------------------------------------------------------------------
-- EXTRAPRICE
-----------------------------------------------------------------------------------------------------------------------------------------
local ExtraPrice10 = 125
local ExtraPrice20 = 595
local ExtraPrice30 = 1145
-----------------------------------------------------------------------------------------------------------------------------------------
-- AREAS60
-----------------------------------------------------------------------------------------------------------------------------------------
local Areas60 = {
	{ X = -521.92, Y = -1770.01, Z = 21.42 }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- AREAS80
-----------------------------------------------------------------------------------------------------------------------------------------
local Areas80 = {
	{ X = 2578.46, Y = 4245.33, Z = 41.8 }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- AREAS120
-----------------------------------------------------------------------------------------------------------------------------------------
local Areas120 = {
	{ X = 1578.62, Y = -980.07, Z = 60.09 },
	{ X = 2134.19, Y = -572.18, Z = 95.1 },
	{ X = 714.88, Y = 6511.94, Z = 27.41 },
	{ X = -2658.32, Y = 2632.84, Z = 16.68 }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADSPEEDCAMERA
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		local TimeDistance = 999

		-- Areas 60
		for k in pairs(Areas60) do
			local PlayerCoords = GetEntityCoords(GetPlayerPed(-1), false)
			local Distance = Vdist(PlayerCoords["x"], PlayerCoords["y"], PlayerCoords["z"], Areas60[k]["X"], Areas60[k]["Y"], Areas60[k]["Z"])

			if Distance <= 20 then
				local Ped = GetPlayerPed(-1)
				local PedVehicle = GetVehiclePedIsIn(Ped, false)
				local Speed = GetEntitySpeed(Ped) * 2.236936
				local MaxSpeed = 60

				if Speed > MaxSpeed then
					if IsPedInAnyVehicle(Ped, false) then
						if (GetPedInVehicleSeat(PedVehicle, -1) == Ped) then
							if HasCaught == false then						
								if ExtraPrice == true then
									if Speed >= MaxSpeed + 30 then
										FinalPrice = DefaultPrice60 + ExtraPrice30
									elseif Speed >= MaxSpeed + 20 then
										FinalPrice = DefaultPrice60 + ExtraPrice20
									elseif Speed >= MaxSpeed + 10 then
										FinalPrice = DefaultPrice60 + ExtraPrice10
									else
										FinalPrice = DefaultPrice60
									end

									vSERVER.Payment(FinalPrice, Speed)
								else
									vSERVER.Payment(DefaultPrice60, Speed)
								end

								HasCaught = true
								Wait(10000)
							end
						end
					end

					HasCaught = false
				end
			end
		end

		-- Areas 80
		for k in pairs(Areas80) do
			local PlayerCoords = GetEntityCoords(GetPlayerPed(-1), false)
			local Distance = Vdist(PlayerCoords["x"], PlayerCoords["y"], PlayerCoords["z"], Areas80[k]["X"], Areas80[k]["Y"], Areas80[k]["Z"])

			if Distance <= 20 then
				local Ped = GetPlayerPed(-1)
				local PedVehicle = GetVehiclePedIsIn(Ped, false)
				local Speed = GetEntitySpeed(Ped) * 2.236936
				local MaxSpeed = 80

				if Speed > MaxSpeed then
					if IsPedInAnyVehicle(Ped, false) then
						if (GetPedInVehicleSeat(PedVehicle, -1) == Ped) then
							if HasCaught == false then						
								if ExtraPrice == true then
									if Speed >= MaxSpeed + 30 then
										FinalPrice = DefaultPrice80 + ExtraPrice30
									elseif Speed >= MaxSpeed + 20 then
										FinalPrice = DefaultPrice80 + ExtraPrice20
									elseif Speed >= MaxSpeed + 10 then
										FinalPrice = DefaultPrice80 + ExtraPrice10
									else
										FinalPrice = DefaultPrice80
									end

									vSERVER.Payment(FinalPrice, Speed)
								else
									vSERVER.Payment(DefaultPrice80, Speed)
								end

								HasCaught = true
								Wait(10000)
							end
						end
					end

					HasCaught = false
				end
			end
		end

		-- Areas 120
		for k in pairs(Areas120) do
			local PlayerCoords = GetEntityCoords(GetPlayerPed(-1), false)
			local Distance = Vdist(PlayerCoords["x"], PlayerCoords["y"], PlayerCoords["z"], Areas120[k]["X"], Areas120[k]["Y"], Areas120[k]["Z"])

			if Distance <= 20 then
				local Ped = GetPlayerPed(-1)
				local PedVehicle = GetVehiclePedIsIn(Ped, false)
				local Speed = GetEntitySpeed(Ped) * 2.236936
				local MaxSpeed = 120

				if Speed > MaxSpeed then
					if IsPedInAnyVehicle(Ped, false) then
						if (GetPedInVehicleSeat(PedVehicle, -1) == Ped) then
							if HasCaught == false then						
								if ExtraPrice == true then
									if Speed >= MaxSpeed + 30 then
										FinalPrice = DefaultPrice120 + ExtraPrice30
									elseif Speed >= MaxSpeed + 20 then
										FinalPrice = DefaultPrice120 + ExtraPrice20
									elseif Speed >= MaxSpeed + 10 then
										FinalPrice = DefaultPrice120 + ExtraPrice10
									else
										FinalPrice = DefaultPrice120
									end

									vSERVER.Payment(FinalPrice, Speed)
								else
									vSERVER.Payment(DefaultPrice120, Speed)
								end

								HasCaught = true
								Wait(10000)
							end
						end
					end

					HasCaught = false
				end
			end
		end

		Wait(TimeDistance)
	end
end)