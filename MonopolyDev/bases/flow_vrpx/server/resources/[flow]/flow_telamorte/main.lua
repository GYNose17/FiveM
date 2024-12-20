Citizen.CreateThread(function()
    while true do
        if GetEntityHealth(PlayerPedId()) <= 101 then
            SendNUIMessage({
			    setDisplay = true
	        })
        else 
            SendNUIMessage({
			    setDisplay = false
	        })
        end
        Citizen.Wait(100)
    end
end)