local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPserver = Tunnel.getInterface("vRP","vrp_banco")

src = {}
Tunnel.bindInterface("vrp_banco",src)
vSERVER = Tunnel.getInterface("vrp_banco")
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
local segundos = 0
local oppened = nil

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- BANCO teste
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
local locations = {
  [1] = { tipo = "banco", coords = vec3(150.12,-1040.8,29.38), text = "[~r~Banco~w~]\n ~w~~r~E~w~ para acessar" },
  [2] = { tipo = "banco", coords = vec3(237.35,217.86,106.29), text = "[~r~Banco~w~]\n ~w~~r~E~w~ para acessar" },
  [3] = { tipo = "banco", coords = vec3(314.09,-279.04,54.18), text = "[~r~Banco~w~]\n ~w~~r~E~w~ para acessar" },
  [4] = { tipo = "banco", coords = vec3(-2962.58,482.54,15.71), text = "[~r~Banco~w~]\n ~w~~r~E~w~ para acessar" },
  [5] = { tipo = "banco", coords = vec3(-112.29,6469.39,31.63), text = "[~r~Banco~w~]\n ~w~~r~E~w~ para acessar" },
  [6] = { tipo = "banco", coords = vec3(-1215.57,-324.39,37.71), text = "[~r~Banco~w~]\n ~w~~r~E~w~ para acessar" },
  [7] = { tipo = "banco", coords = vec3(-349.31,-44.9,49.04), text = "[~r~Banco~w~]\n ~w~~r~E~w~ para acessar" },
  [8] = { tipo = "banco", coords = vec3(-1212.57,-330.67,37.79), text = "[~r~Banco~w~]\n ~w~~r~E~w~ para acessar" },
  [9] = { tipo = "banco", coords = vec3(-351.18,-49.91,49.05), text = "[~r~Banco~w~]\n ~w~~r~E~w~ para acessar" },
  [10] = { tipo = "banco", coords = vec3(-350.85,-49.92,49.05), text = "[~r~Banco~w~]\n ~w~~r~E~w~ para acessar" },

  [10] = { tipo = "caixaeletronico", coords = vec3(89.57,2.16,68.32), text = "[~r~Caixa Eletronico~w~]\n ~w~~r~E~w~ para acessar\n ~w~~r~F~w~ para roubar" },
  [13] = { tipo = "caixaeletronico", coords = vec3(-821.61,-1082.05,11.13), text = "[~r~Caixa Eletronico~w~]\n ~w~~r~E~w~ para acessar\n ~w~~r~F~w~ para roubar" },
  [14] = { tipo = "caixaeletronico", coords = vec3(1686.60,4815.74,42.00), text = "[~r~Caixa Eletronico~w~]\n ~w~~r~E~w~ para acessar\n ~w~~r~F~w~ para roubar" },
  [15] = { tipo = "caixaeletronico", coords = vec3(-386.82,6045.96,31.50), text = "[~r~Caixa Eletronico~w~]\n ~w~~r~E~w~ para acessar\n ~w~~r~F~w~ para roubar" },
  [16] = { tipo = "caixaeletronico", coords = vec3(1172.47,2702.48,38.17), text = "[~r~Caixa Eletronico~w~]\n ~w~~r~E~w~ para acessar\n ~w~~r~F~w~ para roubar" },
  [17] = { tipo = "banco", coords = vec3(1968.07,3743.59,32.34), text = "[~r~Caixa Eletronico~w~]\n ~w~~r~E~w~ para acessar\n ~w~~r~F~w~ para roubar" },
  [18] = { tipo = "caixaeletronico", coords = vec3(2558.94,350.94,108.62), text = "[~r~Caixa Eletronico~w~]\n ~w~~r~E~w~ para acessar\n ~w~~r~F~w~ para roubar" },
  [19] = { tipo = "caixaeletronico", coords = vec3(1153.74,-326.77,69.20), text = "[~r~Caixa Eletronico~w~]\n ~w~~r~E~w~ para acessar\n ~w~~r~F~w~ para roubar" },
  [20] = { tipo = "caixaeletronico", coords = vec3(-56.98,-1752.12,29.42), text = "[~r~Caixa Eletronico~w~]\n ~w~~r~E~w~ para acessar\n ~w~~r~F~w~ para roubar" },
  [21] = { tipo = "caixaeletronico", coords = vec3(-3241.09,997.48,12.55), text = "[~r~Caixa Eletronico~w~]\n ~w~~r~E~w~ para acessar\n ~w~~r~F~w~ para roubar" },
  [22] = { tipo = "caixaeletronico", coords = vec3(-1827.16,784.97,138.30), text = "[~r~Caixa Eletronico~w~]\n ~w~~r~E~w~ para acessar\n ~w~~r~F~w~ para roubar" },
  [23] = { tipo = "caixaeletronico", coords = vec3(-1091.33,2708.48,18.95), text = "[~r~Caixa Eletronico~w~]\n ~w~~r~E~w~ para acessar\n ~w~~r~F~w~ para roubar" },
  [24] = { tipo = "caixaeletronico", coords = vec3(112.63,-819.19,31.33), text = "[~r~Caixa Eletronico~w~]\n ~w~~r~E~w~ para acessar\n ~w~~r~F~w~ para roubar" },
  [25] = { tipo = "caixaeletronico", coords = vec3(-256.15,-716.03,33.51), text = "[~r~Caixa Eletronico~w~]\n ~w~~r~E~w~ para acessar\n ~w~~r~F~w~ para roubar" },
  [26] = { tipo = "caixaeletronico", coords = vec3(-258.62,-723.49,33.43), text = "[~r~Caixa Eletronico~w~]\n ~w~~r~E~w~ para acessar\n ~w~~r~F~w~ para roubar" },
  [27] = { tipo = "caixaeletronico", coords = vec3(174.32,6637.82,31.57), text = "[~r~Caixa Eletronico~w~]\n ~w~~r~E~w~ para acessar\n ~w~~r~F~w~ para roubar" },
  [28] = { tipo = "caixaeletronico", coords = vec3(-660.69,-853.86,24.48), text = "[~r~Caixa Eletronico~w~]\n ~w~~r~E~w~ para acessar\n ~w~~r~F~w~ para roubar" },
  [29] = { tipo = "caixaeletronico", coords = vec3(147.64,-1035.50,29.34), text = "[~r~Caixa Eletronico~w~]\n ~w~~r~E~w~ para acessar" },
  [30] = { tipo = "caixaeletronico", coords = vec3(146.09,-1034.96,29.34), text = "[~r~Caixa Eletronico~w~]\n ~w~~r~E~w~ para acessar" },
  [31] = { tipo = "caixaeletronico", coords = vec3(-866.53,-187.66,37.83), text = "[~r~Caixa Eletronico~w~]\n ~w~~r~E~w~ para acessar\n ~w~~r~F~w~ para roubar" },
  [32] = { tipo = "caixaeletronico", coords = vec3(-867.49,-186.01,37.83), text = "[~r~Caixa Eletronico~w~]\n ~w~~r~E~w~ para acessar\n ~w~~r~F~w~ para roubar" },
  [33] = { tipo = "caixaeletronico", coords = vec3(418.82,-986.33,29.39), text = "[~r~Caixa Eletronico~w~]\n ~w~~r~E~w~ para acessar\n ~w~~r~F~w~ para roubar" },
  [34] = { tipo = "caixaeletronico", coords = vec3(296.18,-591.49,43.27), text = "[~r~Caixa Eletronico~w~]\n ~w~~r~E~w~ para acessar\n ~w~~r~F~w~ para roubar" },
  [35] = { tipo = "caixaeletronico", coords = vec3(296.23,-894.11,29.22), text = "[~r~Caixa Eletronico~w~]\n ~w~~r~E~w~ para acessar\n ~w~~r~F~w~ para roubar" },
  [36] = { tipo = "caixaeletronico", coords = vec3(295.67,-896.07,29.21), text = "[~r~Caixa Eletronico~w~]\n ~w~~r~E~w~ para acessar\n ~w~~r~F~w~ para roubar" },
  [37] = { tipo = "caixaeletronico", coords = vec3(-717.56,-915.68,19.21), text = "[~r~Caixa Eletronico~w~]\n ~w~~r~E~w~ para acessar\n ~w~~r~F~w~ para roubar" },
  [38] = { tipo = "caixaeletronico", coords = vec3(33.16,-1348.11,29.49), text = "[~r~Caixa Eletronico~w~]\n ~w~~r~E~w~ para acessar\n ~w~~r~F~w~ para roubar" },
  [39] = { tipo = "caixaeletronico", coords = vec3(130.05,-1292.67,29.26), text = "[~r~Caixa Eletronico~w~]\n ~w~~r~E~w~ para acessar\n ~w~~r~F~w~ para roubar" },
  [40] = { tipo = "caixaeletronico", coords = vec3(129.63,-12,29.26), text = "[~r~Caixa Eletronico~w~]\n ~w~~r~E~w~ para acessar\n ~w~~r~F~w~ para roubar" },
  [41] = { tipo = "caixaeletronico", coords = vec3(129.21,-1291.11,29.26), text = "[~r~Caixa Eletronico~w~]\n ~w~~r~E~w~ para acessar\n ~w~~r~F~w~ para roubar" },
  [42] = { tipo = "caixaeletronico", coords = vec3(288.95,-1256.81,29.44), text = "[~r~Caixa Eletronico~w~]\n ~w~~r~E~w~ para acessar\n ~w~~r~F~w~ para roubar" },
  [43] = { tipo = "caixaeletronico", coords = vec3(-31.49,-1121.46,26.55), text = "[~r~Caixa Eletronico~w~]\n ~w~~r~E~w~ para acessar\n ~w~~r~F~w~ para roubar" },
  [44] = { tipo = "caixaeletronico", coords = vec3(-203.75,-861.52,30.26), text = "[~r~Caixa Eletronico~w~]\n ~w~~r~E~w~ para acessar\n ~w~~r~F~w~ para roubar" },
  [45] = { tipo = "caixaeletronico", coords = vec3(-1109.71,-1690.73,4.37), text = "[~r~Caixa Eletronico~w~]\n ~w~~r~E~w~ para acessar\n ~w~~r~F~w~ para roubar" },
  [46] = { tipo = "caixaeletronico", coords = vec3(-1430.10,-211.08,46.50), text = "[~r~Caixa Eletronico~w~]\n ~w~~r~E~w~ para acessar\n ~w~~r~F~w~ para roubar" },
  [47] = { tipo = "caixaeletronico", coords = vec3(540.28,2671.14,42.15), text = "[~r~Caixa Eletronico~w~]\n ~w~~r~E~w~ para acessar\n ~w~~r~F~w~ para roubar" },
  [48] = { tipo = "caixaeletronico", coords = vec3(2683.08,3286.57,55.24), text = "[~r~Caixa Eletronico~w~]\n ~w~~r~E~w~ para acessar\n ~w~~r~F~w~ para roubar" },
  [49] = { tipo = "caixaeletronico", coords = vec3(2564.62,2584.77,38.08), text = "[~r~Caixa Eletronico~w~]\n ~w~~r~E~w~ para acessar\n ~w~~r~F~w~ para roubar" },
  [50] = { tipo = "caixaeletronico", coords = vec3(1077.71,-776.35,58.23), text = "[~r~Caixa Eletronico~w~]\n ~w~~r~E~w~ para acessar\n ~w~~r~F~w~ para roubar" },
  [51] = { tipo = "caixaeletronico", coords = vec3(1735.34,6410.66,35.04), text = "[~r~Caixa Eletronico~w~]\n ~w~~r~E~w~ para acessar\n ~w~~r~F~w~ para roubar" },
  [52] = { tipo = "caixaeletronico", coords = vec3(-3240.82,1008.61,12.84), text = "[~r~Caixa Eletronico~w~]\n ~w~~r~E~w~ para acessar\n ~w~~r~F~w~ para roubar" },
  [53] = { tipo = "caixaeletronico", coords = vec3(-2975.28,380.17,15.0), text = "[~r~Caixa Eletronico~w~]\n ~w~~r~E~w~ para acessar\n ~w~~r~F~w~ para roubar" },
  [54] = { tipo = "caixaeletronico", coords = vec3(-2956.87,487.64,15.47), text = "[~r~Caixa Eletronico~w~]\n ~w~~r~E~w~ para acessar\n ~w~~r~F~w~ para roubar" },
  [55] = { tipo = "caixaeletronico", coords = vec3(-2958.95,487.78,15.47), text = "[~r~Caixa Eletronico~w~]\n ~w~~r~E~w~ para acessar\n ~w~~r~F~w~ para roubar" },
  [56] = { tipo = "caixaeletronico", coords = vec3(-254.34,-692.32,33.61), text = "[~r~Caixa Eletronico~w~]\n ~w~~r~E~w~ para acessar\n ~w~~r~F~w~ para roubar" },
  [57] = { tipo = "caixaeletronico", coords = vec3(-301.72,-830.24,32.42), text = "[~r~Caixa Eletronico~w~]\n ~w~~r~E~w~ para acessar\n ~w~~r~F~w~ para roubar" },
  [58] = { tipo = "caixaeletronico", coords = vec3(-303.28,-829.9,32.42), text = "[~r~Caixa Eletronico~w~]\n ~w~~r~E~w~ para acessar\n ~w~~r~F~w~ para roubar" },
  [59] = { tipo = "caixaeletronico", coords = vec3(315.26,-593.74,43.29), text = "[~r~Caixa Eletronico~w~]\n ~w~~r~E~w~ para acessar\n ~w~~r~F~w~ para roubar" },
  [60] = { tipo = "caixaeletronico", coords = vec3(-201.57,-1309.38,31.3), text = "[~r~Caixa Eletronico~w~]\n ~w~~r~E~w~ para acessar\n ~w~~r~F~w~ para roubar" },
  [61] = { tipo = "caixaeletronico", coords = vec3(817.13,-929.31,32.4), text = "[~r~Caixa Eletronico~w~]\n ~w~~r~E~w~ para acessar" },
  [62] = { tipo = "caixaeletronico", coords = vec3(-809.36,-1238.23,7.34), text = "[~r~Caixa Eletronico~w~]\n ~w~~r~E~w~ para acessar" },
  [64] = { tipo = "caixaeletronico", coords = vec3(380.49,323.55,103.57), text = "[~r~Caixa Eletronico~w~]\n ~w~~r~E~w~ para acessar" },
  [65] = { tipo = "caixaeletronico", coords = vec3(93.01,124.93,80.54), text = "[~r~Caixa Eletronico~w~]\n ~w~~r~E~w~ para acessar" },
  [66] = { tipo = "caixaeletronico", coords = vec3(-3040.79,593.09,7.91), text = "[~r~Caixa Eletronico~w~]\n ~w~~r~E~w~ para acessar" },
  [67] = { tipo = "caixaeletronico", coords = vec3(-1047.41,300.88,71.67), text = "[~r~Caixa Eletronico~w~]\n ~w~~r~E~w~ para acessar" },
  [68] = { tipo = "caixaeletronico", coords = vec3(-1868.83,2062.01,140.97), text = "[~r~Caixa Eletronico~w~]\n ~w~~r~E~w~ para acessar" },
  [69] = { tipo = "caixaeletronico", coords = vec3(-2678.61,1304.73,152.02), text = "[~r~Caixa Eletronico~w~]\n ~w~~r~E~w~ para acessar" },
  [70] = { tipo = "caixaeletronico", coords = vec3(-2365.56,1754.8,212.12), text = "[~r~Caixa Eletronico~w~]\n ~w~~r~E~w~ para acessar" },


  [71] = { tipo = "banco", coords = vec3(-1386.39,-597.44,30.31), text = "[~r~Banco~w~]\n ~w~~r~E~w~ para acessar" },
  [72] = { tipo = "banco", coords = vec3(-562.36,287.42,82.18), text = "[~r~Banco~w~]\n ~w~~r~E~w~ para acessar" },
  [73] = { tipo = "banco", coords = vec3(-435.82,-325.95,34.91), text = "[~r~Banco~w~]\n ~w~~r~E~w~ para acessar" },
  [74] = { tipo = "banco", coords = vec3(-432.5,1098.45,327.68), text = "[~r~Banco~w~]\n ~w~~r~E~w~ para acessar" },
  [75] = { tipo = "banco", coords = vec3(-1074.34,-827.44,27.03), text = "[~r~Banco~w~]\n ~w~~r~E~w~ para acessar" },
  [76] = { tipo = "banco", coords = vec3(-262.41,-725.35,125.46), text = "[~r~Banco~w~]\n ~w~~r~E~w~ para acessar" },
  [77] = { tipo = "banco", coords = vec3(413.58,-1498.7,33.8), text = "[~r~Banco~w~]\n ~w~~r~E~w~ para acessar" },

 
  [78] = { tipo = "banco", coords = vec3(-228.14,-335.53,29.99), text = "[~r~Banco~w~]\n ~w~~r~E~w~ para acessar" },
  [79] = { tipo = "banco", coords = vec3(1249.11,-1143.0,38.06), text = "[~r~Banco~w~]\n ~w~~r~E~w~ para acessar" },
  [80] = { tipo = "banco", coords = vec3(2731.03,3480.24,55.25), text = "[~r~Banco~w~]\n ~w~~r~E~w~ para acessar" },
  [81] = { tipo = "banco", coords = vec3(-1754.74,-205.96,57.83), text = "[~r~Banco~w~]\n ~w~~r~E~w~ para acessar" },
  [82] = { tipo = "banco", coords = vec3(3026.3,3009.38,91.58), text = "[~r~Banco~w~]\n ~w~~r~E~w~ para acessar" },
  [83] = { tipo = "banco", coords = vec3(1269.33,-1383.91,47.28), text = "[~r~Banco~w~]\n ~w~~r~E~w~ para acessar" },
  [84] = { tipo = "banco", coords = vec3(-1522.23,831.42,181.59), text = "[~r~Banco~w~]\n ~w~~r~E~w~ para acessar" },
  [85] = { tipo = "banco", coords = vec3(1850.17,424.41,166.7), text = "[~r~Banco~w~]\n ~w~~r~E~w~ para acessar" },
  [86] = { tipo = "banco", coords = vec3(-1982.95,-496.68,16.45), text = "[~r~Banco~w~]\n ~w~~r~E~w~ para acessar" },
  [87] = { tipo = "banco", coords = vec3(364.84,-2048.08,22.22), text = "[~r~Banco~w~]\n ~w~~r~E~w~ para acessar" },
  [88] = { tipo = "banco", coords = vec3(-417.85,867.43,233.77), text = "[~r~Banco~w~]\n ~w~~r~E~w~ para acessar" },
  [89] = { tipo = "banco", coords = vec3(421.09,15.84,91.93), text = "[~r~Banco~w~]\n ~w~~r~E~w~ para acessar" },
  [90] = { tipo = "banco", coords = vec3(1000.17,-132.07,74.05), text = "[~r~Banco~w~]\n ~w~~r~E~w~ para acessar" },
  [91] = { tipo = "banco", coords = vec3(802.29,-290.95,66.52), text = "[~r~Banco~w~]\n ~w~~r~E~w~ para acessar" },
  [92] = { tipo = "banco", coords = vec3(-67.42,838.04,231.33), text = "[~r~Banco~w~]\n ~w~~r~E~w~ para acessar" },
  [93] = { tipo = "banco", coords = vec3(-1065.4,-840.76,5.11), text = "[~r~Banco~w~]\n ~w~~r~E~w~ para acessar" },
  [94] = { tipo = "banco", coords = vec3(879.83,1034.77,280.72), text = "[~r~Banco~w~]\n ~w~~r~E~w~ para acessar" },
  [95] = { tipo = "banco", coords = vec3(-3233.96,813.84,14.07), text = "[~r~Banco~w~]\n ~w~~r~E~w~ para acessar" },
  [96] = { tipo = "banco", coords = vec3(2458.77,3778.95,48.58), text = "[~r~Banco~w~]\n ~w~~r~E~w~ para acessar" },
  [97] = { tipo = "banco", coords = vec3(-1497.4,115.5,55.64), text = "[~r~Banco~w~]\n ~w~~r~E~w~ para acessar" },
  [98] = { tipo = "banco", coords = vec3(1152.43,-1535.03,35.38), text = "[~r~Banco~w~]\n ~w~~r~E~w~ para acessar" },

  [99] = { tipo = "caixaeletronico", coords = vec3(-2425.92,3273.71,32.97), text = "[~r~Caixa Eletronico~w~]\n ~w~~r~E~w~ para acessar" },
  
  
  
  
  


}

Citizen.CreateThread(function()
    while true do
      local time = 1000
      local pedCoords = GetEntityCoords(PlayerPedId())
        for k,v in pairs(locations) do
            local distance = #(pedCoords - v.coords)
            if distance <= 0.7 then
                time = 5
                DrawText3D(v.coords[1], v.coords[2], v.coords[3]+0.2, "~g~E~w~   ABRIR",400)
                if IsControlJustPressed(0,38) and distance <= 5.5 then
                  local banco,carteira,identidade,multas,checkout = vSERVER.openBank()
                  print(k)
                  if checkout and oppened == nil then
                    oppened = v.tipo
                    TransitionToBlurred(1000)
                    
                    SetNuiFocus(true, true)
                    SendNUIMessage({ openBank = true, bank = banco, cart = carteira, identidade = identidade, multas = multas })
                  end
                end
            end
        end

      Citizen.Wait(time)
    end
end)


------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- NUI CALLBACKS
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback('balance', function(data, cb)
  SendNUIMessage({openSection = "balance"})
end)

RegisterNUICallback('withdraw', function(data, cb)
  SendNUIMessage({openSection = "withdraw"})
end)

RegisterNUICallback('deposit', function(data, cb)
  SendNUIMessage({openSection = "deposit"})
end)

RegisterNUICallback('transfer', function(data, cb)
  SendNUIMessage({openSection = "transfer"})
end)


RegisterNUICallback('withdrawSubmit', function(data, cb)
  if oppened ~= nil and segundos <= 0 and NetworkIsSessionActive() then
    segundos = 5
    print(data.amount)
    if vSERVER.sacarDinheiro(data.amount) then
      vSERVER.updateBank()
    end
  end
end)

RegisterNUICallback('depositSubmit', function(data, cb)
    if oppened ~= nil and oppened == "banco" and segundos <= 0 and NetworkIsSessionActive() then
      segundos = 5
      if vSERVER.depositarDinheiro(data.amount) then
        vSERVER.updateBank()
      end
    else
      TriggerEvent("Notify","negado","Você so pode efetuar depositos em um banco.", 5)
    end
end)

RegisterNUICallback('transferSubmit', function(data, cb)
  if oppened ~= nil and segundos <= 0 and NetworkIsSessionActive() then
    segundos = 5
    if vSERVER.transferirDinheiro(data.toPlayer, data.amount) then
      vSERVER.updateBank()
    end
  end
end)

RegisterNUICallback('multasSubmit', function(data, cb)
  if oppened ~= nil and segundos <= 0 and NetworkIsSessionActive() then
    segundos = 5
    if vSERVER.pagarMultas(data.amount) then
      vSERVER.updateBank()
    end
  end
end)

RegisterNUICallback('close', function(data, cb)
  TransitionFromBlurred(1000)

  SendNUIMessage({openBank = false})
  oppened = nil

  SetNuiFocus(false, false)
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNCTIONS
-----------------------------------------------------------------------------------------------------------------------------------------
function src.atualizarBanco(banco,carteira,multas)
  SendNUIMessage({ updateBalance = true, bank = banco, cart = carteira, multas = multas })
end

Citizen.CreateThread(function()
    while true do
      segundos = segundos - 1
      if segundos <= 0 then
        segundos = 0
      end
      Citizen.Wait(1000)
    end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- DRAW3DS
-----------------------------------------------------------------------------------------------------------------------------------------
function DrawText3D(x,y,z,text)
	SetTextFont(4)
	SetTextCentre(1)
	SetTextEntry("STRING")
	SetTextScale(0.35,0.35)
	SetTextColour(255,255,255,150)
	AddTextComponentString(text)
	SetDrawOrigin(x,y,z,0)
	DrawText(0.0,0.0)
	local factor = (string.len(text) / 375) + 0.01
	DrawRect(0.0,0.0125,factor,0.03,38,42,56,200)
	ClearDrawOrigin()
end