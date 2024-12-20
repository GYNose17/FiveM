-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
local Baixada = {}
Tunnel.bindInterface("party",Baixada)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Config = {
    ["Room"] = {},
    ["Users"] = {}
}
local Active = {}
local Amounts = 0
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETROOMS
-----------------------------------------------------------------------------------------------------------------------------------------
function Baixada.GetRooms()
	local source = source
	local Passport = vRP.Passport(source)
	
	if Passport then
		local Room = {}
		for Index,v in pairs(Config["Room"]) do
			if CountTable(v["Users"]) == 0 then
				Room[#Room + 1] = nil
				Config["Room"][#Room + 1] = nil
			else
				Room[#Room + 1] = {
					["Identity"] = v["Identity"],
					["Id"] = Index,
					["Name"] = v["Name"],
					["Password"] = v["Password"] or false,
					["Users"] = CountTable(v["Users"])
				}
			end
		end

		return {
			["group"] = Config["Users"][Passport] or false,
			["room"] = Room
		}
	else
		return {}
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CREATEROOM
-----------------------------------------------------------------------------------------------------------------------------------------
function Baixada.CreateRoom(Name,Password)
	local source = source
	local Passport = vRP.Passport(source)
    
	if Active[Passport] and Active[Passport] > os.time() then
		return false
	end
	Active[Passport] = os.time() + 3
	
	if Passport and not Config["Users"][Passport] then
        Amounts = Amounts + 1
        Config["Room"][Amounts] = {
            ["Created"] = Passport,
            ["Identity"] = vRP.Identity(Passport)["Name"].." "..vRP.Identity(Passport)["Lastname"],
            ["Name"] = Name,
            ["Password"] = Password,
            ["Users"] = {
                [Passport] = source
            }
        }
        Config["Users"][Passport] = Amounts

        return {
            ["room"] = {
                ["Id"] = Amounts,
                ["Identity"] = Config["Room"][Amounts]["Identity"],
                ["Name"] = Name,
                ["Password"] = Password or false,
                ["Users"] = CountTable(Config["Room"][Amounts]["Users"])
            }
        }
    end
	
	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETMEMBERS
-----------------------------------------------------------------------------------------------------------------------------------------
function Baixada.GetMembers(Number)
	local source = source
	local Passport = vRP.Passport(source)
	
	Number = Number or Config["Users"][Passport]

	if Passport and Config["Room"][Number] and Config["Room"][Number]["Users"] then
		local Room = {}
		for OtherPassport,v in pairs(Config["Room"][Number]["Users"]) do
			Room[#Room + 1] = {
				["Passport"] = OtherPassport,
				["Name"] = vRP.Identity(OtherPassport)["Name"].." "..vRP.Identity(OtherPassport)["Lastname"]
			}
		end
		return {
			["Members"] = Room,
			["Created"] = Config["Room"][Number]["Identity"],
			["Identity"] = Config["Room"][Number]["Identity"],
			["Name"] = Config["Room"][Number]["Name"],
			["Users"] = CountTable(Config["Room" ][Number]["Users"])
		}
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- LEAVEROOM
-----------------------------------------------------------------------------------------------------------------------------------------
function Baixada.LeaveRoom(Room)
	local source = source
	local Passport = vRP.Passport(source)
	
	if Active[Passport] and Active[Passport] > os.time() then
		return false
	end
	Active[Passport] = os.time() + 3
	
	Room = Room or Config["Users"][Passport]

	if Config["Room"][Room] then
		Config["Users"][Passport] = nil
		Config["Room"][Room]["Users"][Passport] = nil

		if Config["Room"][Room]["Created"] == Passport then
			for k,v in pairs(Config["Room"][Room]["Users"]) do
				Config["Room"][Room]["Users"][k] = nil
				Config["Users"][k] = nil
				TriggerClientEvent("party:ResetNui", vRP.Source(k))
			end
			Config["Room"][Room] = nil
		elseif CountTable(Config["Room"][Room]["Users"]) == 0 then
			Config["Room"][Room] = nil
		end
	end
    TriggerClientEvent("party:ResetNui",source)
    return {}
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ENTERROOM
-----------------------------------------------------------------------------------------------------------------------------------------
function Baixada.EnterRoom(Number, Password)
	local source = source
	local Passport = vRP.Passport(source)

	if Active[Passport] and Active[Passport] > os.time() then
		return false
	end
	Active[Passport] = os.time() + 3
	
	if Config["Room"][Number] then
		if Config["Users"][Passport] then
			if Number ~= Config["Users"][Passport] then
				if Config["Users"][Passport] then
					Baixada.LeaveRoom(Config["Users"][Passport])
				end
			
				Config["Users"][Passport] = Number
				Config["Room"][Number]["Users"][Passport] = source
			end
		else
			Config["Users"][Passport] = Number
			Config["Room"][Number]["Users"][Passport] = source
			
			TriggerClientEvent("party:ResetNui", source)
        end
    end
	
	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- KICKROOM
-----------------------------------------------------------------------------------------------------------------------------------------
function Baixada.KickRoom(Kick,OtherPassport)
	local source = source
	local Room = nil
	local Passport = vRP.Passport(source)

	if Active[Passport] and Active[Passport] > os.time() then
		return false
	end
	Active[Passport] = os.time() + 3

	if Config["Users"][OtherPassport] then
		Room = Config["Users"][OtherPassport]
		if Config["Room"][Room]["Created"] == Passport and OtherPassport ~= Passport then
			Config["Room"][Room]["Users"][OtherPassport] = nil
			Config["Users"][OtherPassport] = nil
			
			TriggerClientEvent("party:ResetNui", vRP.Source(OtherPassport))
			return Baixada.GetRooms()
		end
	else
		return false
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DISCONNECT
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("Disconnect", function(Passport)
	if Config["Users"][Passport] then
		Room = Config["Users"][Passport]
	
		if Config["Room"][Room] then
			Config["Users"][Passport] = nil
			Config["Room"][Room]["Users"][Passport] = nil
	
			if Config["Room"][Room]["Created"] == Passport then
				for k,v in pairs(Config["Room"][Room]["Users"]) do
					Config["Room"][Room]["Users"][k] = nil
					Config["Users"][k] = nil
					TriggerClientEvent("party:ResetNui", vRP.Source(k))
				end
				Config["Room"][Room] = nil
			elseif CountTable(Config["Room"][Room]["Users"]) == 0 then
				Config["Room"][Room] = nil
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DOESEXIST
-----------------------------------------------------------------------------------------------------------------------------------------
exports("DoesExist",function(Passport)
	if Passport then
		if Config["Users"][Passport] then
			return true
		end
	end

	return false
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ROOM
-----------------------------------------------------------------------------------------------------------------------------------------
exports("Room",function(Passport,Source,Distance)
	local Room = {}
    if Config["Users"][Passport] and Config["Room"][Config["Users"][Passport]] then
        for k, v in pairs(Config["Room"][Config["Users"][Passport]]["Users"]) do
            if Distance >= #(GetEntityCoords(GetPlayerPed(Source)) - GetEntityCoords(GetPlayerPed(v))) then
                Room[#Room + 1] = {
                    ["Passport"] = k,
                    ["Source"] = v
                }
            end
        end
    end
    return Room
end)