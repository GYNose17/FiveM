
RegisterKeyMapping("12302791083789021839021","Abrir Menu de Call","keyboard","f5")
RegisterCommand("12302791083789021839021",function(source,args)
    SetNuiFocus(true, true)
    SendNUIMessage({ action = 'open' })
end)

RegisterNetEvent("notificacoesnui")
AddEventHandler("notificacoesnui", function(type, title, description, persistent)
    SetNuiFocus(true, true)
    SendNUIMessage({ action = 'open' })
end)

RegisterNUICallback("close", function(data, cb)
	SetNuiFocus(false)
end)

RegisterNUICallback("tryAcceptRequest", function(data, cb)
    if data.id then
        TriggerServerEvent("alerts:tryAcceptRequest", data.id)
    end

	cb({})
end)

RegisterNetEvent("alerts:sendNotification")
AddEventHandler("alerts:sendNotification", function(type, title, description, persistent)
    SendNUIMessage({ action = 'addNotification', type = type, title = title, description = description, persistent = persistent })
end)

RegisterNetEvent("alerts:sendRequest")
AddEventHandler("alerts:sendRequest", function(type, title, description, id)
    SendNUIMessage({ action = 'addRequest', type = type, title = title, description = description, id = id })
end)

RegisterNetEvent("alerts:setAcceptedRequest")
AddEventHandler("alerts:setAcceptedRequest", function(requestId, userId)
    SendNUIMessage({ action = 'setAcceptedRequest', id = requestId, user_id = userId })
end)