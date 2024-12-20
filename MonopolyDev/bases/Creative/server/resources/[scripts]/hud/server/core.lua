-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRPC = Tunnel.getInterface("vRP")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
Baixada = {}
Tunnel.bindInterface("hud", Baixada)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
GlobalState["Work"] = 0
GlobalState["Points"] = 0
GlobalState["Hours"] = 12
GlobalState["Minutes"] = 0
GlobalState["Temperature"] = 20
GlobalState["Weather"] = "CLEAR"
GlobalState["Blackout"] = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- WEATHERLIST
-----------------------------------------------------------------------------------------------------------------------------------------
local WeatherList = { "CLEAR", "EXTRASUNNY", "SMOG", "OVERCAST", "CLOUDS", "CLEARING" }
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADSYNC
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		GlobalState["Work"] = GlobalState["Work"] + 1
		GlobalState["Points"] = GlobalState["Points"] + 1
		GlobalState["Minutes"] = GlobalState["Minutes"] + 1

		if GlobalState["Points"] >= 30 then
			if math.random(100) >= 50 then
				if GlobalState["Weather"] == "CLEAR" or GlobalState["Weather"] == "EXTRASUNNY" then
					if math.random(100) >= 50 then
						GlobalState["Temperature"] = GlobalState["Temperature"] + math.random(2)
					else
						GlobalState["Temperature"] = GlobalState["Temperature"] - math.random(2)
					end
				end
			else
				if GlobalState["Weather"] == "SMOG" or GlobalState["Weather"] == "OVERCAST" then
					if math.random(100) >= 50 then
						GlobalState["Temperature"] = GlobalState["Temperature"] - math.random(2)
					else
						GlobalState["Temperature"] = GlobalState["Temperature"] + math.random(2)
					end
				end
			end

			GlobalState["Points"] = 0
		end

		if GlobalState["Minutes"] >= 60 then
			GlobalState["Hours"] = GlobalState["Hours"] + 1
			GlobalState["Minutes"] = 0

			if GlobalState["Hours"] >= 24 then
				GlobalState["Hours"] = 0

				repeat
					RandWeather = math.random(#WeatherList)
				until GlobalState["Weather"] ~= WeatherList[RandWeather]

				GlobalState["Weather"] = WeatherList[RandWeather]
				GlobalState["Temperature"] = 20
			end
		end

		Wait(10000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETCOUGH
-----------------------------------------------------------------------------------------------------------------------------------------
function Baixada.GetCough(Value)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		local ClosestPed = vRPC.ClosestPed(source, 3)
		if ClosestPed then
			local OtherPassport = vRP.Passport(ClosestPed)
			if OtherPassport and vRP.GetHealth(ClosestPed) > 100 and math.random(0,100) <= 30 then
				vRP.UpgradeCough(OtherPassport, Value)
			end
		end
	end
end