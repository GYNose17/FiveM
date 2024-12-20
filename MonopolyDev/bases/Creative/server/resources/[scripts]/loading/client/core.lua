-----------------------------------------------------------------------------------------------------------------------------------------
-- ONCLIENTRESOURCESTART
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("onClientResourceStart")
AddEventHandler("onClientResourceStart", function(Resource)
	if (GetCurrentResourceName() ~= Resource) then
		return
	end

	DoScreenFadeOut(500)
	DisplayRadar(false)
	ShutdownLoadingScreen()
	ShutdownLoadingScreenNui()
	TriggerEvent("spawn:Opened")
end)
