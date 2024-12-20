-----------------------------------------------------------------------------------------------------------------------------------------
-- PAYMENT
-----------------------------------------------------------------------------------------------------------------------------------------
function Baixada.Payment(Value, Speed)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and not Active[Passport] then
		if not vRP.HasService(Passport, "Policia") and not vRP.HasService(Passport, "Paramedico") then
			Active[Passport] = true

			TriggerClientEvent("sounds:Private", source, "speedcamera", 0.5)

			local Service, Total = vRP.NumPermission("Policia")
			for Passports, Sources in pairs(Service) do
				async(function()
					TriggerClientEvent("Notify", Sources, "policia", "Alguém foi notado pelo <b>Radar de Velocidade</b>.",
						"Radar de Velocidade", 5000)
					vRPC.PlaySound(Sources, "Beep_Red", "DLC_HEIST_HACKING_SNAKE_SOUNDS")
				end)
			end

			if NewBank then
				exports["bank"]:AddFines(Passport, Passport, Value, "Velocidade captada: " .. math.floor(Speed) .. ".")
			end

			exports["markers"]:Enter(source, "Corredor")
			TriggerClientEvent("Notify", source, "amarelo", "Você excedeu o limite máximo de velocidade.",
				"Passou com " .. math.floor(Speed) .. " Km/h", 10000)

			Active[Passport] = nil

			SetTimeout(10000, function()
				exports["markers"]:Exit(source)
			end)
		else
			TriggerClientEvent("Notify", source, "amarelo", "Você passou imperceptível pelo <b>Radar de Velocidade</b>",
				"Atenção", 5000)
		end
	end
end
