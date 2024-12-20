local Tunnel = module('vrp','lib/Tunnel')
local Proxy = module('vrp','lib/Proxy')
vRP = Proxy.getInterface('vRP')
vSERVER = Tunnel.getInterface('radio')


local privateChannel = {
  {channel = 1, perm = "admin.permissao"},
  {channel = 112, perm = "perm.hospital"},
  {channel = 911, perm = "perm.policia"},
  {channel = 922, perm = "perm.bope"},
  {channel = 933, perm = "perm.policiacivil"},



}

local GuiOpened = false

RegisterCommand("radio", function()
    if vSERVER.hasRadio() then
        openGui()
    else
        TriggerEvent("Notify","negado","Você não pode utilizar um radio agora ou você não possui um radio.")
    end
end)

RegisterNetEvent('radioGui')
AddEventHandler('radioGui', function()
  if vSERVER.hasRadio() then
    openGui()
  else
    TriggerEvent("Notify","negado","Você não pode utilizar um radio agora ou você não possui um radio.")
  end
  Wait(1)
end)

RegisterNetEvent('ChannelSet')
AddEventHandler('ChannelSet', function(chan)
  SendNUIMessage({set = true, setChannel = chan})
end)

RegisterNetEvent('radio:resetNuiCommand')
AddEventHandler('radio:resetNuiCommand', function()
    SendNUIMessage({reset = true})
end)

function checkPermission(data)
  if privateChannel then
    for k, v in pairs(privateChannel) do
      local selectedChannel = parseInt(data.channel) or nil
      if selectedChannel then
        if parseInt(v.channel) == selectedChannel then
          if not vSERVER.hasPermission(v.perm) then
            TriggerEvent("Notify","negado","Você não tem permissão para entrar nessa frequencia.")
            return false
          end
        end
      end
    end
  end
  return true
end

function openGui()
  if not GuiOpened then
    GuiOpened = true
    SetNuiFocus(false,false)
    SetNuiFocus(true,true)
    SendNUIMessage({open = true})
  else
    GuiOpened = false
    SetNuiFocus(false,false)
    SendNUIMessage({open = false})
  end
  TriggerEvent("animation:radio",GuiOpened)
  --ExecuteCommand("hud")
end


RegisterNUICallback('click', function(data, cb)
  PlaySound(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
end)

RegisterNUICallback('volumeRadio', function(data, cb)
  MumbleSetVolumeOverride(PlayerPedId(), data.volume + 0.0)
  PlaySound(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
end)

local volume = 0.0

RegisterNUICallback('volumeUp', function(data, cb)
  print(volume)
  if volume <= 0.9 then
    volume = volume + 0.1
    MumbleSetVolumeOverride(PlayerPedId(), volume)
  else
  end
end)

RegisterNUICallback('volumeDown', function(data, cb)
  if volume >= 0.0 then
    volume = volume - 0.1
    MumbleSetVolumeOverride(PlayerPedId(), volume)
  else
  end
end)

RegisterNUICallback('cleanClose', function(data, cb)
  TriggerEvent("InteractSound_CL:PlayOnOne","radioclick",0.6)
  GuiOpened = false
  SetNuiFocus(false,false)
  SendNUIMessage({open = false})
  TriggerEvent("animation:radio",GuiOpened)
end)

RegisterNUICallback('poweredOn', function(data, cb)
  if checkPermission(data) then
    TriggerEvent("InteractSound_CL:PlayOnOne","radioclick",0.6)
    local fuckingidiot = tonumber(data.channel)
    if fuckingidiot == nil then
      fuckingidiot = 0
    end
    local newChannel = fuckingidiot

    if fuckingidiot < 10 and fuckingidiot > 0 then
      newChannel = fuckingidiot
    end
    

    if newChannel == 0 then
      exports["pma-voice"]:removePlayerFromRadio()
      exports["pma-voice"]:setVoiceProperty('radioEnabled',false)
      TriggerEvent("hud:RadioDisplay", 0)

      
    else
      TriggerEvent("hud:RadioDisplay", parseInt(newChannel))
      exports["pma-voice"]:setRadioChannel(parseInt(newChannel))
      exports["pma-voice"]:setVoiceProperty('radioEnabled',true)
    end
  end

end)

RegisterNUICallback('poweredOff', function(data, cb)
  exports["pma-voice"]:removePlayerFromRadio()
  exports["pma-voice"]:setVoiceProperty('radioEnabled',false)
  TriggerEvent("hud:RadioDisplay", 0)
end)

RegisterNUICallback('close', function(data, cb)
  if checkPermission(data) then
    TriggerEvent("InteractSound_CL:PlayOnOne","radioclick",0.6)
    local fuckingidiot = tonumber(data.channel)
    if fuckingidiot == nil then
      fuckingidiot = 0
    end
    local newChannel = fuckingidiot

    if fuckingidiot < 10 and fuckingidiot > 0 then
      newChannel = fuckingidiot
    end
    
    if newChannel == 0 then
      exports["pma-voice"]:removePlayerFromRadio()
      exports["pma-voice"]:setVoiceProperty('radioEnabled',false)
      TriggerEvent("hud:RadioDisplay", 0)
    else
      TriggerEvent("hud:RadioDisplay", newChannel)
      exports["pma-voice"]:setRadioChannel(parseInt(newChannel))
      exports["pma-voice"]:setVoiceProperty('radioEnabled',true)

    end

    GuiOpened = false
    SetNuiFocus(false,false)
    SendNUIMessage({open = false})
    TriggerEvent("animation:radio",GuiOpened)
  end
end)

RegisterNetEvent('animation:radio')
AddEventHandler('animation:radio', function(enable)
    local lPed = PlayerPedId()
    inPhone = enable

    RequestAnimDict("cellphone@")
    while not HasAnimDictLoaded("cellphone@") do
        Citizen.Wait(0)
    end

    local intrunk = false
    if not intrunk then
        TaskPlayAnim(lPed, "cellphone@", "cellphone_text_in", 2.0, 3.0, -1, 49, 0, 0, 0, 0)
    end
    Citizen.Wait(300)
    if inPhone then
        Citizen.Wait(150)
        while inPhone do

            local dead = false
            if dead then
                closeGui()
                inPhone = false
            end
            local intrunk = false
            if not intrunk and not IsEntityPlayingAnim(lPed, "cellphone@", "cellphone_text_read_base", 3) and not IsEntityPlayingAnim(lPed, "cellphone@", "cellphone_swipe_screen", 3) then
                TaskPlayAnim(lPed, "cellphone@", "cellphone_text_read_base", 2.0, 3.0, -1, 49, 0, 0, 0, 0)
            end
            Citizen.Wait(1)
        end
        local intrunk = false
        if not intrunk then
            ClearPedTasks(PlayerPedId())
        end
    else
        local intrunk = false
        if not intrunk then
            Citizen.Wait(100)
            ClearPedTasks(PlayerPedId())
            TaskPlayAnim(lPed, "cellphone@", "cellphone_text_out", 2.0, 1.0, 5.0, 49, 0, 0, 0, 0)
            Citizen.Wait(400)
            Citizen.Wait(400)
            ClearPedTasks(PlayerPedId())
        end
    end
end)
