-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRPC = Tunnel.getInterface("vRP")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHAT:SERVERMESSAGE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("chat:ServerMessage")
AddEventHandler("chat:ServerMessage", function(Tags, Message)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		if not vRP.Groups()[Tags] then
			if "ooc" == Tags then
				local Identity = vRP.Identity(Passport)
				local Messages = Message:gsub("[<>]","")
				
				local Players = vRPC.ClosestPeds(source,10)
				for _, v in pairs(Players) do
					async(function()
						TriggerClientEvent("chat:ClientMessage", v, Identity["Name"].. " " ..Identity["Lastname"], Messages, Tags)
					end)
				end
			else
				TriggerClientEvent("chat:ClientMessage", -1, Identity["Name"].. " " ..Identity["Lastname"], Messages, Tags)
			end
		elseif vRP.HasService(vRP.Passport(source),Tags) then
			local Identity = vRP.Identity(Passport)
			local Messages = Message:gsub("[<>]","")
			for _, v in pairs(vRP.NumPermission(Tags)) do
				async(function()
					TriggerClientEvent("chat:ClientMessage", v, Identity["Name"].. " " ..Identity["Lastname"], Messages, Tags)
				end)
			end
		end
	end
end)