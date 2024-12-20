-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp", "lib/Tunnel")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
Baixada = {}
Tunnel.bindInterface("request", Baixada)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Active = false
local Results = false
local Seconds = GetGameTimer()
-----------------------------------------------------------------------------------------------------------------------------------------
-- SUCESS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Sucess", function(Data, Callback)
	Results = true
	Active = false

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FAILURE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Failure", function(Data, Callback)
	Results = false
	Active = false

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNCTION
-----------------------------------------------------------------------------------------------------------------------------------------
function Baixada.Function(Title, Message)
	if Active then
		return false
	end

	SendNUIMessage({ name = "Open", payload = { Title, Message } })
	Seconds = GetGameTimer() + 15000
	Active = true

	while Active do
		if GetGameTimer() >= Seconds then
			SendNUIMessage({ name = "Close" })
			Results = false
			Active = false
		end

		Wait(0)
	end

	return Results
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- Y
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("Y", function()
	if Active then
		SendNUIMessage({ name = "Y" })
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- U
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("U", function()
	if Active then
		SendNUIMessage({ name = "U" })
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- KEYMAPPING
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterKeyMapping("Y", "Aceitar requisições.", "keyboard", "Y")
RegisterKeyMapping("U", "Rejeitar requisições.", "keyboard", "U")
