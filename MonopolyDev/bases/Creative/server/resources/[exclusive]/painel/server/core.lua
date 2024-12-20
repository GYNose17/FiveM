-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
Baixada = {}
Tunnel.bindInterface("painel", Baixada)
vCLIENT = Tunnel.getInterface("painel")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Active = {}
local Painel = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- BUFFDAYS
-----------------------------------------------------------------------------------------------------------------------------------------
exports("Buff", function(Permission)
	local Consult = vRP.Query("chests/GetChests", { Name = Permission })
	local Days = math.floor((Consult[1]["Premium"] - os.time()) / 86400)

	if Consult[1]["Premium"] < os.time() and Consult[1]["Premium"] > 0 then
		vRP.Query("chests/DowngradeChests", { Name = Permission })
		vRP.Query("chests/Premium", { Name = Permission, Premium = 0 })

		local Entitys = vRP.DataGroups(Permission)
		for Number, v in pairs(Entitys) do
			local Number = parseInt(Number)
			vRP.RemovePermission(Number, "Buff")
		end
	end

	return Days > 0 and Days or 0
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADBUFF
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	local Groups = vRP.Groups()
	for k, _ in pairs(Groups) do
		if vRP.GroupType(k) == "Work" and vRP.Query("chests/GetChests", { Name = k })[1] then
			exports["painel"]:Buff(k)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PAINEL
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("painel", function(source)
	local Passport = vRP.Passport(source)
	if Passport then
		local Groups = vRP.Groups()
		for k, _ in pairs(Groups) do
			if vRP.GroupType(k) == "Work" and vRP.HasService(Passport, k) then
				Painel[Passport] = k
				break
			end
		end
		if Painel[Passport] then
			local Members = {}
			local Sources = vRP.Players()
			local Entitys = vRP.DataGroups(Painel[Passport])
			local Hierarchy = vRP.Hierarchy(Painel[Passport])
			local Max = vRP.GroupMax(Painel[Passport])
			local Count = vRP.GroupCount(Painel[Passport])

			for Number, v in pairs(Entitys) do
				local Number = parseInt(Number)
				local Identity = vRP.Identity(Number)
				if Identity then
					if vRP.HasPermission(Number, Painel[Passport], 1) then
						Members[#Members + 1] = {
							["name"] = Identity["Name"] .. " " .. Identity["Lastname"],
							["phone"] = Identity["Phone"],
							["online"] = Sources[Number],
							["id"] = Number,
							["role"] = Hierarchy[v] or Hierarchy,
							["role_id"] = v
						}
					else
						Members[#Members + 1] = {
							["name"] = Identity["Name"] .. " " .. Identity["Lastname"],
							["phone"] = Identity["Phone"],
							["online"] = Sources[Number],
							["id"] = Number,
							["role"] = Hierarchy[v] or Hierarchy
						}
					end
				end
			end

			local Data = {
				client_role = vRP.UserHierarchy(Passport, Painel[Passport]),
				members = Members,
				groupName = Max and Painel[Passport] .. "( " .. Count .. "/" .. Max .. " )" or Painel[Passport]
			}

			vCLIENT.Open(source, Data, exports["painel"]:Buff(Painel[Passport]), Price)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ENTERPRISE:OPEN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("enterprise:Open", function(Permission)
	print(Permission)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DIMISS
-----------------------------------------------------------------------------------------------------------------------------------------
function Baixada.Dismiss(Number)
	local source = source
	local Number = parseInt(Number)
	local Passport = vRP.Passport(source)

	if Active[Passport] and Active[Passport] > os.time() then
		return false
	end
	Active[Passport] = os.time() + 3

	if Passport and Painel[Passport] and Passport ~= Number then
		if vRP.HasPermission(Passport, Painel[Passport], 1) then
			vRP.RemovePermission(Number, Painel[Passport])
			vRP.RemovePermission(Number, "Buff")

			TriggerClientEvent("Notify", source, "verde", "Passaporte removido.", Painel[Passport], 5000)

			local Members = {}
			local Sources = vRP.Players()
			local Entitys = vRP.DataGroups(Painel[Passport])
			local Hierarchy = vRP.Hierarchy(Painel[Passport])

			for Number, v in pairs(Entitys) do
				local Number = parseInt(Number)
				local Identity = vRP.Identity(Number)
				if Identity then
					if vRP.HasPermission(Number, Painel[Passport], 1) then
						Members[#Members + 1] = {
							["name"] = Identity["Name"] .. " " .. Identity["Lastname"],
							["phone"] = Identity["phone"],
							["online"] = Sources[Number],
							["id"] = Number,
							["role"] = Hierarchy[1] or Hierarchy,
							["role_id"] = 1
						}
					else
						Members[#Members + 1] = {
							["name"] = Identity["Name"] .. " " .. Identity["Lastname"],
							["phone"] = Identity["Phone"],
							["online"] = Sources[Number],
							["id"] = Number,
							["role"] = Hierarchy[v] or Hierarchy
						}
					end
				end
			end

			return Members
		end
	end
	return false
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- INVITE
-----------------------------------------------------------------------------------------------------------------------------------------
function Baixada.Invite(OtherPassport)
	local source = source
	local OtherPassport = parseInt(OtherPassport)
	local Passport = vRP.Passport(source)
	local Identity = vRP.Identity(Passport)
	local otherSource = vRP.Source(OtherPassport)

	if Active[Passport] and Active[Passport] > os.time() then
		return false
	end
	Active[Passport] = os.time() + 3

	if Passport and Painel[Passport] and Passport ~= OtherPassport and vRP.Identity(OtherPassport) and otherSource and vRP.HasPermission(Passport, Painel[Passport], 1) then
		local Max = vRP.GroupMax(Painel[Passport])
		local Count = vRP.GroupCount(Painel[Passport])
		if Max and Count >= Max then
			TriggerClientEvent("Notify", source, "vermelho", "Limite atingido.", Painel[Passport], 5000)
			return
		end

		if not vRP.GetUserType(OtherPassport, "Work") then
			TriggerClientEvent("Notify", source, "amarelo", "O convite foi enviado.", Painel[Passport], 5000)
			if vRP.Request(otherSource, "Painel", Identity["Name"] .. " " .. Identity["Lastname"] .. " te convidou para se juntar a organização " .. Painel[Passport] .. ", você aceita esse convite?") then
				vRP.SetPermission(OtherPassport, Painel[Passport])

				if exports["painel"]:Buff(Painel[Passport]) > 0 then
					vRP.SetPermission(OtherPassport, "Buff")
				end

				TriggerClientEvent("Notify", source, "verde", "O convite foi aceito.", Painel[Passport], 5000)

				local Sources = vRP.Players()
				local Hierarchy = vRP.UserHierarchy(OtherPassport, Painel[Passport])
				local Identity = vRP.Identity(OtherPassport)

				return {
					["name"] = Identity["Name"] .. " " .. Identity["Lastname"],
					["phone"] = Identity["Phone"],
					["online"] = Sources[OtherPassport],
					["id"] = OtherPassport,
					["role"] = vRP.Hierarchy(Painel[Passport])[Hierarchy]
				}
			else
				TriggerClientEvent("Notify", source, "vermelho", "O convite foi recusado.", Painel[Passport], 5000)
			end
		else
			TriggerClientEvent("Notify", source, "amarelo", "O passaporte já pertence a outro grupo.",
				"Atenção", 5000)
		end
	end
	return false
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- HIERARCHY
-----------------------------------------------------------------------------------------------------------------------------------------
function Baixada.Hierarchy(OtherPassport, Mode)
	local source = source
	local Passport = vRP.Passport(source)

	if Active[Passport] and Active[Passport] > os.time() then
		return false
	end
	Active[Passport] = os.time() + 3

	if Passport and Painel[Passport] and Passport ~= OtherPassport and vRP.Identity(OtherPassport) then
		if vRP.HasPermission(Passport, Painel[Passport], 1) then
			if not vRP.HasPermission(OtherPassport, Painel[Passport], 2) or Mode == "Demote" then
				vRP.SetPermission(OtherPassport, Painel[Passport], false, Mode)

				TriggerClientEvent("Notify", source, "verde", "Hierarquia atualizada.", Painel[Passport], 5000)

				local Hierarchy = vRP.UserHierarchy(OtherPassport, Painel[Passport])
				return { vRP.Hierarchy(Painel[Passport])[Hierarchy] }
			end
		end
	end
	return false
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- TRANSACTIONS
-----------------------------------------------------------------------------------------------------------------------------------------
function Baixada.Transactions()
	local source = source
	local Passport = vRP.Passport(source)

	local Bank = vRP.Query("chests/GetChests", { Name = Painel[Passport] })[1]["Bank"]
	local Transactions = {}
	local Consult = vRP.Query("painel/List", { Permission = Painel[Passport] })
	for k, v in pairs(Consult) do
		Transactions[#Transactions + 1] = {
			["Type"] = v["Type"],
			["Value"] = v["Price"]
		}
	end
	return {
		["Balance"] = Bank,
		["Transactions"] = Transactions
	}
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- WITHDRAW
-----------------------------------------------------------------------------------------------------------------------------------------
function Baixada.Withdraw(Price)
	local source = source
	local Passport = vRP.Passport(source)
	Price = tonumber(Price)

	if Active[Passport] and Active[Passport] > os.time() then
		return false
	end
	Active[Passport] = os.time() + 3

	if Passport and Painel[Passport] and (vRP.HasPermission(Passport, Painel[Passport], 1) or vRP.HasPermission(Passport, Painel[Passport], 2)) then
		local Bank = vRP.Query("chests/GetChests", { Name = Painel[Passport] })[1]["Bank"]
		if Price <= Bank then
			vRP.Query("painel/Add", { Passport = Passport, Permission = Painel[Passport], Type = "exit", Price = Price })
			vRP.Query("chests/RemBank", { Name = Painel[Passport], Bank = Price })

			vRP.GenerateItem(Passport, "dollars", Price, true)

			local Bank = vRP.Query("chests/GetChests", { Name = Painel[Passport] })[1]["Bank"]
			local Transactions = {}
			local Consult = vRP.Query("painel/List", { Permission = Painel[Passport] })
			for k, v in pairs(Consult) do
				Transactions[#Transactions + 1] = {
					["Type"] = v["Type"],
					["Value"] = v["Price"]
				}
			end
			return {
				["Balance"] = Bank,
				["Transactions"] = Transactions
			}
		end
	end
	return false
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- DEPOSIT
-----------------------------------------------------------------------------------------------------------------------------------------
function Baixada.Deposit(Price)
	local source = source
	local Passport = vRP.Passport(source)
	Price = tonumber(Price)

	if Active[Passport] and Active[Passport] > os.time() then
		return false
	end
	Active[Passport] = os.time() + 3

	if Passport and Painel[Passport] and (vRP.HasPermission(Passport, Painel[Passport], 1) or vRP.HasPermission(Passport, Painel[Passport], 2)) then
		if vRP.PaymentFull(Passport, Price) then
			vRP.Query("painel/Add", { Passport = Passport, Permission = Painel[Passport], Type = "entry", Price = Price })
			vRP.Query("chests/AddBank", { Name = Painel[Passport], Bank = Price })

			local Bank = vRP.Query("chests/GetChests", { Name = Painel[Passport] })[1]["Bank"]
			local Transactions = {}
			local Consult = vRP.Query("painel/List", { Permission = Painel[Passport] })
			for k, v in pairs(Consult) do
				Transactions[#Transactions + 1] = {
					["Type"] = v["Type"],
					["Value"] = v["Price"]
				}
			end
			return {
				["Balance"] = Bank,
				["Transactions"] = Transactions
			}
		end
	end
	return false
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- BUY
-----------------------------------------------------------------------------------------------------------------------------------------
function Baixada.Buy()
	local source = source
	local Passport = vRP.Passport(source)

	if Active[Passport] and Active[Passport] > os.time() then
		return false
	end
	Active[Passport] = os.time() + 3

	if Passport and Painel[Passport] and (vRP.HasPermission(Passport, Painel[Passport], 1) or vRP.HasPermission(Passport, Painel[Passport], 2)) then
		if vRP.PaymentFull(Passport, Price) then
			vRP.Query("chests/UpgradeChests", { Name = Painel[Passport] })
			vRP.Query("chests/Premium", { Name = Painel[Passport], Premium = os.time() + (86400 * Duration) })

			local Entitys = vRP.DataGroups(Painel[Passport])
			for Number, v in pairs(Entitys) do
				local Number = parseInt(Number)
				vRP.SetPermission(Number, "Buff", 1)
			end
		end
	end
	return exports["painel"]:Buff(Painel[Passport])
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- CLOSE
-----------------------------------------------------------------------------------------------------------------------------------------
function Baixada.Close()
	local source = source
	local Passport = vRP.Passport(source)
	if Painel[Passport] then
		Painel[Passport] = nil
	end
end