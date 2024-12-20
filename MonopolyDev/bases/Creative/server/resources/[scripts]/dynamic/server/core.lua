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
Tunnel.bindInterface("dynamic", Baixada)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Animals = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- REGISTERANIMAL
-----------------------------------------------------------------------------------------------------------------------------------------
function Baixada.RegisterAnimal(objNet)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		Animals[Passport] = objNet
	end
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- CLEARANIMAL
-----------------------------------------------------------------------------------------------------------------------------------------
function Baixada.ClearAnimal()
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		TriggerEvent("DeletePed", Animals[Passport])
		Animals[Passport] = nil
	end
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- EXPERIENCE
-----------------------------------------------------------------------------------------------------------------------------------------
function Baixada.Experience()
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		local Experiences = {
			[ClassWork("Minerman")] = vRP.GetExperience(Passport, "Minerman"),
			[ClassWork("Lumberman")] = vRP.GetExperience(Passport, "Lumberman"),
			[ClassWork("Transporter")] = vRP.GetExperience(Passport, "Transporter"),
			[ClassWork("Delivery")] = vRP.GetExperience(Passport, "Delivery"),
			[ClassWork("Garbageman")] = vRP.GetExperience(Passport, "Garbageman"),
			[ClassWork("Hunter")] = vRP.GetExperience(Passport, "Hunter"),
			[ClassWork("Dismantle")] = vRP.GetExperience(Passport, "Dismantle"),
			[ClassWork("Fruitman")] = vRP.GetExperience(Passport, "Fruitman"),
			[ClassWork("Tows")] = vRP.GetExperience(Passport, "Tows"),
			[ClassWork("Fisherman")] = vRP.GetExperience(Passport, "Fisherman"),
			[ClassWork("Runner")] = vRP.GetExperience(Passport, "Runner"),
			[ClassWork("Trucker")] = vRP.GetExperience(Passport, "Trucker"),
			[ClassWork("Bus")] = vRP.GetExperience(Passport, "Bus"),
			[ClassWork("Taxi")] = vRP.GetExperience(Passport, "Taxi"),
			[ClassWork("Cleaner")] = vRP.GetExperience(Passport, "Cleaner"),
			[ClassWork("Diver")] = vRP.GetExperience(Passport, "Diver"),
			[ClassWork("Postman")] = vRP.GetExperience(Passport, "Postman")
		}

		return Experiences
	end
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- PEDSTATS
-----------------------------------------------------------------------------------------------------------------------------------------
function Baixada.PedStats()
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		local Stats = {
			["Likes"] = vRP.GetLikes(Passport),
			["Unlikes"] = vRP.GetUnLikes(Passport)
		}

		return Stats
	end
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- CODES
-----------------------------------------------------------------------------------------------------------------------------------------
local Codes = {
	["13"] = {
		["Message"] = "Oficial desmaiado/ferido",
		["Blip"] = 6
	},
	["20"] = {
		["Message"] = "Localização",
		["Blip"] = 6
	},
	["38"] = {
		["Message"] = "Abordagem de trânsito",
		["Blip"] = 6
	},
	["78"] = {
		["Message"] = "Apoio com prioridade",
		["Blip"] = 6
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- DYNAMIC:TENCODE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("dynamic:Tencode")
AddEventHandler("dynamic:Tencode", function(Number)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and vRP.HasService(Passport, "Policia") and Codes[Number] then
		local FullName = vRP.FullName(Passport)
		local Coords = vRP.GetEntityCoords(source)
		local Service = vRP.NumPermission("Policia")

		for Passports, Sources in pairs(Service) do
			async(function()
				vRPC.PlaySound(Sources, "ATM_WINDOW", "HUD_FRONTEND_DEFAULT_SOUNDSET")
				TriggerClientEvent("NotifyPush", Sources,
					{ code = Number, title = Codes[Number]["Message"], x = Coords["x"], y = Coords["y"], z = Coords["z"],
						name = FullName, color = Codes[Number]["Blip"] })
			end)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DISCONNECT
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("Disconnect", function(Passport)
	if Animals[Passport] then
		TriggerEvent("DeletePed", Animals[Passport])
		Animals[Passport] = nil
	end
end)
