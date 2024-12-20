RegisterNUICallback('onClose', function(data, cb)
    SetNuiFocus(false, false)
    SendNUIMessage({ action = "hideMenu" })
end)

RegisterNUICallback('dev_tools', function(data, cb)
    vTunnel._DevTools()
end)