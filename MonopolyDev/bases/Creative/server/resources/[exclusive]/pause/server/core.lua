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
Tunnel.bindInterface("pause", Baixada)
-----------------------------------------------------------------------------------------------------------------------------------------
-- COUNTSHOPPING
-----------------------------------------------------------------------------------------------------------------------------------------
local function CountShopping()
	local Shopping = {}
	for k, v in pairs(ShopItens) do
		if (#Shopping + 1) > 5 then break end
		Shopping[#Shopping + 1] = {
			["Image"] = itemIndex(k),
			["Name"] = itemName(k),
			["Index"] = k,
			["Amount"] = 1,
			["Price"] = v["Price"],
			["Discount"] = v["Discount"]
		}
	end
	return Shopping
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- COUNTCAROUSEL
-----------------------------------------------------------------------------------------------------------------------------------------
local function CountCarousel()
	local Carousel = {}
	local counter = 0
	for k, v in pairs(ShopItens) do
		if (#Carousel + 1) > 3 then break end
		if v["Discount"] ~= 0 then
			Carousel[#Carousel + 1] = {
				["id"] = counter,
				["Index"] = k,
				["Image"] = itemIndex(k),
				["Name"] = itemName(k),
				["Amount"] = 1,
				["Price"] = v["Price"],
				["Discount"] = v["Price"] * (1 - (v["Discount"] / 100))
			}
			counter = counter + 1
		end
	end
	return Carousel
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- HOME
-----------------------------------------------------------------------------------------------------------------------------------------
function Baixada.Home()
	local Source = source
	local Passport = vRP.Passport(Source)
	local Identity = vRP.Identity(Passport)
	if Identity then
		local Experience = {}
		for k, v in pairs(Works) do
			Experience[#Experience + 1] = {
				ClassWork(v),
				parseInt(vRP.GetExperience(Passport, v)) or 0
			}
		end

		local Account = vRP.Account(Identity["License"])
		return {
			["Information"] = {
				["Name"] = Identity["Name"] .. " " .. Identity["Lastname"],
				["Sex"] = Identity["Sex"],
				["Blood"] = Sanguine(Identity["Blood"]),
				["Passport"] = Passport,
				["Bank"] = Identity["Bank"],
				["Phone"] = Identity["Phone"],
				["Diamonds"] = Account["Gemstone"]
			},
			["Premium"] = PremiumRenew,
			["Medic"] = (Identity["Medic"] / 3600) / 24,
			["Shopping"] = CountShopping(),
			["Carousel"] = CountCarousel(),
			["Box"] = Boxes[1],
			["Experience"] = Experience
		}
	end

	return false
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- DIAMONDSLIST
-----------------------------------------------------------------------------------------------------------------------------------------
function Baixada.DiamondsList()
	local Shop = {}
	for k, v in pairs(ShopItens) do
		Shop[#Shop + 1] = {
			["Index"] = k,
			["Description"] = itemDescription(k),
			["Image"] = itemIndex(k),
			["Name"] = itemName(k),
			["Price"] = v["Price"],
			["Discount"] = v["Discount"],
		}
	end

	return Shop
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- DIAMONDSBUY
-----------------------------------------------------------------------------------------------------------------------------------------
function Baixada.DiamondsBuy(Item, Amount)
	if ShopItens[Item] then
		local source = source
		local Passport = vRP.Passport(source)
		local Price = ShopItens[Item]["Price"] * ((100 - ShopItens[Item]["Discount"]) / 100)
		if vRP.PaymentGemstone(Passport, Amount * Price) then
			if itemMode(Item) == "Chest" then
				vRP.GiveItem(Passport, Item.."-"..os.time().."-"..(math.random(1000,5000) + Passport), Amount)
			else
				vRP.GenerateItem(Passport, Item, Amount)
			end
			return true
		end
	end
	return false
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- OPENBOXES
-----------------------------------------------------------------------------------------------------------------------------------------
function Baixada.OpenBoxes(Number)
	if Number then
		local source = source
		local Passport = vRP.Passport(source)
		if vRP.PaymentGemstone(Passport, tonumber(Boxes[Number]["Price"])) then
			return math.random(#ContentBoxes[Number])
		end
	end
	return false
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- PAYMENTBOXES
-----------------------------------------------------------------------------------------------------------------------------------------
function Baixada.PaymentBoxes(Number, Index)
	local source = source
	local Passport = vRP.Passport(source)

	vRP.GenerateItem(Passport, ContentBoxes[Number][Index]["Item"], ContentBoxes[Number][Index]["Amount"])

	return "Ok"
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- DISCONNECT
-----------------------------------------------------------------------------------------------------------------------------------------
function Baixada.Disconnect()
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		vRP.Kick(source, "Volte sempre!")
	end
end