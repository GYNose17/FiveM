-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Plants = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLANTSTYPES
-----------------------------------------------------------------------------------------------------------------------------------------
local PlantsTypes = {
	["weedclone"] = { "weedclone", "Maconha", "weedbud" },
	["mushseed"] = { "mushseed", "Cogumelo", "mushroom" }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLANTS
-----------------------------------------------------------------------------------------------------------------------------------------
exports("Plants", function(Model, Owner, Coords, Route, Points, Type)
	local Number = 0

	repeat
		Number = Number + 1
	until not Plants[tostring(Number)]

	Plants[tostring(Number)] = {
		["Model"] = Model,
		["Type"] = Type,
		["Owner"] = Owner,
		["Coords"] = { mathLength(Coords["x"]), mathLength(Coords["y"]), mathLength(Coords["z"]) },
		["Time"] = os.time() + 10800,
		["Points"] = Points,
		["Fertilizer"] = 0,
		["Route"] = Route
	}

	TriggerClientEvent("plants:New", -1, tostring(Number), Plants[tostring(Number)])
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLANTS:COLLECT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("plants:Collect")
AddEventHandler("plants:Collect", function(Number)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and Plants[Number] then
		if (os.time() - Plants[Number]["Time"]) > 3600 then
			Plants[Number] = nil
			TriggerClientEvent("plants:Remove", -1, Number)
			TriggerClientEvent("dynamic:closeSystem", source)
			TriggerClientEvent("Notify", source, "amarelo", "A plantação apodreceu.", "Atenção", 5000)
		else
			if os.time() >= Plants[Number]["Time"] then
				local Temporary = Plants[Number]

				if (vRP.InventoryWeight(Passport) + itemWeight(PlantsTypes[Plants[Number]["Type"]][3])) <= vRP.GetWeight(Passport) then
					Player(source)["state"]["Cancel"] = true
					Player(source)["state"]["Buttons"] = true
					TriggerClientEvent("dynamic:closeSystem", source)
					TriggerClientEvent("Progress", source, "Coletando", 10000)
					vRPC.PlayAnim(source, false, { "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer" }, true)

					Wait(10000)

					vRP.GenerateItem(Passport, PlantsTypes[Plants[Number]["Type"]][3].."-"..Temporary["Points"], 1, true)
					TriggerClientEvent("plants:Remove", -1, Number)
					Player(source)["state"]["Buttons"] = false
					Player(source)["state"]["Cancel"] = false
					Plants[Number] = nil
					vRPC.Destroy(source)
				else
					TriggerClientEvent("Notify", source, "vermelho", "Mochila cheia.", "Aviso", 5000)
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLANTS:CLONING
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("plants:Cloning")
AddEventHandler("plants:Cloning", function(Number)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and Plants[Number] then
		if (os.time() - Plants[Number]["Time"]) > 3600 then
			Plants[Number] = nil
			TriggerClientEvent("plants:Remove", -1, Number)
			TriggerClientEvent("dynamic:closeSystem", source)
			TriggerClientEvent("Notify", source, "amarelo", "A plantação apodreceu.", "Atenção", 5000)
		else
			if (Plants[Number]["Time"] - os.time()) <= 5400 then
				local Temporary = Plants[Number]

				if (vRP.InventoryWeight(Passport) + itemWeight(PlantsTypes[Plants[Number]["Type"]][1]) * 2) <= vRP.GetWeight(Passport) then
					Player(source)["state"]["Cancel"] = true
					Player(source)["state"]["Buttons"] = true
					TriggerClientEvent("dynamic:closeSystem", source)
					TriggerClientEvent("Progress", source, "Clonando", 10000)
					vRPC.PlayAnim(source, false, { "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer" }, true)

					Wait(10000)

					local Points = parseInt(Temporary["Points"]) + 1
					if Points > 100 then
						Points = 100
					end

					vRP.GenerateItem(Passport, PlantsTypes[Plants[Number]["Type"]][1].."-"..Points, 2, true)
					TriggerClientEvent("plants:Remove", -1, Number)
					Player(source)["state"]["Buttons"] = false
					Player(source)["state"]["Cancel"] = false
					Plants[Number] = nil
					vRPC.Destroy(source)
				else
					TriggerClientEvent("Notify", source, "vermelho", "Mochila cheia.", "Aviso", 5000)
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLANTS:FERTILIZER
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("plants:Fertilizer")
AddEventHandler("plants:Fertilizer", function(Number)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and Plants[Number] then
		if (os.time() - Plants[Number]["Time"]) > 3600 then
			Plants[Number] = nil
			TriggerClientEvent("plants:Remove", -1, Number)
			TriggerClientEvent("dynamic:closeSystem", source)
			TriggerClientEvent("Notify", source, "amarelo", "A plantação apodreceu.", "Atenção", 5000)
		else
			if Plants[Number]["Fertilizer"] < 3 and (Plants[Number]["Time"] - os.time()) >= 600 then
				local ConsultFertilizer = vRP.InventoryItemAmount(Passport, "fertilizer")
				if ConsultFertilizer[1] <= 0 then
					TriggerClientEvent("Notify", source, "amarelo", "Você precisa de <b>1x "..itemName("fertilizer").."</b>.", "Atenção", 5000)
				else
					Player(source)["state"]["Cancel"] = true
					Player(source)["state"]["Buttons"] = true
					TriggerClientEvent("dynamic:closeSystem", source)
					TriggerClientEvent("Progress", source, "Fertilizando", 60000)
					vRPC.PlayAnim(source, false,{ "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer" },true)

					Wait(60000)

					TriggerClientEvent("Notify", source, "verde", "Fertilização completa.", "Sucesso", 5000)
					Plants[Number]["Fertilizer"] = Plants[Number]["Fertilizer"] + 1
					Plants[Number]["Time"] = Plants[Number]["Time"] - 600
					vRP.RemoveItem(Passport, "fertilizer", 1, true)
					Player(source)["state"]["Buttons"] = false
					Player(source)["state"]["Cancel"] = false
					vRPC.Destroy(source)
				end
			else
				TriggerClientEvent("Notify", source, "amarelo", "A plantação já foi fertilizada ao máximo.", "Atenção", 5000)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLANTS:REMOVE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("plants:Remove")
AddEventHandler("plants:Remove", function(Number)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and Plants[Number] then
		Plants[Number] = nil
		TriggerClientEvent("plants:Remove", -1, Number)
		TriggerClientEvent("dynamic:closeSystem", source)
		TriggerClientEvent("Notify", source, "verde", "A plantação foi removida.", "Sucesso", 5000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLANTS:VERIFY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("plants:Verify")
AddEventHandler("plants:Verify", function(Number)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and Plants[Number] then
		local FullName = vRP.FullName(Plants[Number]["Owner"])
		if FullName then
			if (os.time() - Plants[Number]["Time"]) > 3600 then
				Validity = "Plantação Apodrecida"
			else
				Validity = "Plantação Ativa"
			end

			local Collect = "A coleta está disponível"
			if os.time() < Plants[Number]["Time"] then
				Collect = Calculate(Plants[Number]["Time"] - os.time())
			end

			local Cloning = "A clonagem está disponível"
			if (Plants[Number]["Time"] - os.time()) > 5400 then
				Cloning = Calculate(Plants[Number]["Time"] - os.time() - 5400)
			end

			TriggerClientEvent("Notify", source, "azul", "<b>Planta:</b> " .. Number .. " <b>Por:</b> " .. FullName .. ".<br><b>Status:</b> " .. Validity .. ".<br><b>Pureza da folhagem:</b> " .. parseInt(Plants[Number]["Points"]) .. "%.<br><b>Fertilização da plantação:</b> " .. parseInt(Plants[Number]["Fertilizer"]) .. "%.<br><b>Dimensão da plantação:</b> " .. parseInt(Plants[Number]["Route"]) .. ".<br><b>Coleta:</b> " .. Collect .. ".<br><b>Clonagem:</b> " .. Cloning .. ".", false, 10000)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INFORMATIONS
-----------------------------------------------------------------------------------------------------------------------------------------
function BAIXADA.Informations(Number)
	if Plants[Number] then
		if (os.time() - Plants[Number]["Time"]) > 3600 then
			Plants[Number] = nil
			TriggerClientEvent("plants:Remove", -1, Number)
			TriggerClientEvent("dynamic:closeSystem", source)
			TriggerClientEvent("Notify", source, "amarelo", "A plantação apodreceu.", "Atenção", 5000)
		else
			local Collect = "A coleta está disponível"
			if os.time() < Plants[Number]["Time"] then
				Collect = "Aguarde <yellow>" .. Calculate(Plants[Number]["Time"] - os.time()) .. "</yellow>."
			end

			local Cloning = "A clonagem está disponível"
			if (Plants[Number]["Time"] - os.time()) > 5400 then
				Cloning = "Aguarde <yellow>" .. Calculate(Plants[Number]["Time"] - os.time() - 5400) .. "</yellow>."
			end

			local Status = "Plantação <yellow>" .. parseInt(Plants[Number]["Points"]) .. "%</yellow> pura e fertilizada <yellow>" .. parseInt(Plants[Number]["Fertilizer"]) .. "x</yellow>."

			return { Collect, Cloning, Status }
		end
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SAVESERVER
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("SaveServer", function(Silenced)
	vRP.SetServerData("Plants", Plants)

	if not Silenced then
		print("O resource Plants salvou os dados.")
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADSTART
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	Plants = vRP.GetServerData("Plants")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECT
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("Connect", function(Passport, source)
	TriggerClientEvent("plants:Table", source, Plants)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CALCULATE
-----------------------------------------------------------------------------------------------------------------------------------------
function Calculate(Seconds)
	local Days = math.floor(Seconds / 86400)
	Seconds = Seconds - Days * 86400
	local Hours = math.floor(Seconds / 3600)
	Seconds = Seconds - Hours * 3600
	local Minutes = math.floor(Seconds / 60)
	Seconds = Seconds - Minutes * 60

	if Days > 0 then
		return string.format("%d Dia, %d Hora, %d Minutos", Days, Hours, Minutes)
	elseif Hours > 0 then
		return string.format("%d Hora, %d Minutos e %d Segundos", Hours, Minutes, Seconds)
	elseif Minutes > 0 then
		return string.format("%d Minutos e %d Segundos", Minutes, Seconds)
	elseif Seconds > 0 then
		return string.format("%d Segundos", Seconds)
	end
end