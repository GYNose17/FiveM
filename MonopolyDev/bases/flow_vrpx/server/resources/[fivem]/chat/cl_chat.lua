local chatInputActive = false
local chatHidden = true
local chatLoaded = false

RegisterNetEvent('chatMessage')
RegisterNetEvent('chat:addTemplate')
RegisterNetEvent('chat:addMessage')
RegisterNetEvent('chat:clear')
RegisterNetEvent('__cfx_internal:serverPrint')

AddEventHandler('chatMessage', function(author, color, text)
  local args = { text }
  if author ~= "" then
    table.insert(args, 1, author)
  end
  SendNUIMessage({ type = 'ON_MESSAGE', message = { color = color, multiline = true, args = args } })
end)

AddEventHandler('__cfx_internal:serverPrint', function(msg)
  SendNUIMessage({ type = 'ON_MESSAGE', message = { templateId = 'print', multiline = true, args = { msg } } })
end)

AddEventHandler('chat:addMessage', function(message)
  SendNUIMessage({ type = 'ON_MESSAGE', message = message })
end)

AddEventHandler('chat:addSuggestion', function(nome, help, params)
  SendNUIMessage({ type = 'ON_SUGGESTION_ADD', suggestion = { nome = nome, help = help, params = params or nil } })
end)

AddEventHandler('chat:addSuggestions', function(suggestions)
  for _, suggestion in ipairs(suggestions) do
    SendNUIMessage({ type = 'ON_SUGGESTION_ADD', suggestion = suggestion })
  end
end)

AddEventHandler('chat:removeSuggestion', function(nome)
  SendNUIMessage({ type = 'ON_SUGGESTION_REMOVE', nome = nome })
end)

AddEventHandler('chat:addTemplate', function(id, html)
  SendNUIMessage({ type = 'ON_TEMPLATE_ADD', template = { id = id, html = html } })
end)

AddEventHandler('chat:clear', function(nome)
  SendNUIMessage({ type = 'ON_CLEAR' })
end)

RegisterNUICallback('chatResult', function(data, cb)
  chatInputActive = false
  SetNuiFocus(false)

  if not data.canceled then
    local id = PlayerId()

    local r, g, b = 0, 0x99, 255

    if data.message:sub(1, 1) == '/' then
     ExecuteCommand(data.message:sub(2))
    end
  end

  cb('ok')
end)

local function refreshThemes()
  local themes = {}

  for resIdx = 0, GetNumResources() - 1 do
    local resource = GetResourceByFindIndex(resIdx)

    if GetResourceState(resource) == 'started' then
      local numThemes = GetNumResourceMetadata(resource, 'chat_theme')

      if numThemes > 0 then
        local themenome = GetResourceMetadata(resource, 'chat_theme')
        local themeData = json.decode(GetResourceMetadata(resource, 'chat_theme_extra') or 'null')

        if themenome and themeData then
          themeData.baseUrl = 'nui://' .. resource .. '/'
          themes[themenome] = themeData
        end
      end
    end
  end

  SendNUIMessage({ type = 'ON_UPDATE_THEMES', themes = themes })
end

AddEventHandler('onClientResourceStart', function(resnome)
  Wait(500)
  refreshThemes()
end)

AddEventHandler('onClientResourceStop', function(resnome)
  Wait(500)
  refreshThemes()
end)

RegisterNUICallback('loaded', function(data, cb)
  refreshThemes()
  chatLoaded = true
  cb('ok')
end)

RegisterKeyMapping("ochat","Abrir Chat","keyboard","t")
RegisterCommand('ochat', function(source,args)
  if not chatInputActive then
    if IsControlPressed(0, 245) then
      chatInputActive = true

      SendNUIMessage({ type = 'ON_OPEN' })
      SetNuiFocus(true)
    end
  end
end)

Citizen.CreateThread(function()
  SetTextChatEnabled(false)
  SetNuiFocus(false)
  while true do
    local time = 1000
    if chatLoaded then
      time = 300
        local shouldBeHidden = false
        if IsScreenFadedOut() or IsPauseMenuActive() then
          shouldBeHidden = true
        end

        if (shouldBeHidden and not chatHidden) or (not shouldBeHidden and chatHidden) then
          chatHidden = shouldBeHidden

          SendNUIMessage({ type = 'ON_SCREEN_STATE_CHANGE', shouldHide = shouldBeHidden })
        end
    end

    Citizen.Wait(time)
  end
end)
