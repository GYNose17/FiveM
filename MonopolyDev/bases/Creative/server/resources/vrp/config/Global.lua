-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
UsableF7 = true                                                         -- Mostrar id encima das cabeças
Whitelisted = true                                                      -- Whitelist no servidor
CombatLogMinutes = 3                                                    -- Segundos para entrar em combatlog
SalarySeconds = 1800                                                    -- Tempo do salário
BannedText = "Banido"                                                   -- Texto de banimento
CleanDeathInventory = true                                              -- Limpar inventário ao dar /gg
ClearInventoryPremium = true                                            -- Limpar inventário de premiums ao dar /gg
ServerName = "Baixada RP"                                            -- Nome do servidor
ReleaseText = "Efetue sua liberação enviando o seu número de whitelist" -- Texto de liberação da whitelist
SpawnCoords = vec3(-29.82, -140.96, 56.04)                              -- Coordenada padrão de spawn ao criar um personagem
BackArenaPos = vec3(-1046.43, -474.55, 36.78)                           -- Coordenada padrão da arena
SpawnPrison = vec3(1679.94, 2513.07, 45.56)                             -- Coordenada padrão da prisão
BackPrison = vec3(1896.15, 2604.44, 45.75)                              -- Coordenada padrão de saida da prisão
BikesBackpack = true                                                    -- Receber peso na mochila andando de bicicleta
BackpackWeightPremiumDefault = 25                                       -- Peso padrão do inventário Premium
BackpackWeightDefault = 30                                              -- Peso padrão do inventário
WipeBackpackDeath = false                                               -- Limpar inventário ao morrer
NewItemIdentity = true                                                  -- Dar o item identidade ao criar um personagem
BurstTyresBySpeed = true                                                -- Estourar pneus quando atingir grandes velocidades forçando o veículo
ShakeVehicleCamera = true                                               -- Balançar a câmera do personagem quando bater o veículo
ObjectsBlips = true                                                     -- Ativar blips das caixas de loot
ObjectsBlipAlpha = 200                                                  -- Opacidade do blip das caixas de loot
ObjectsBlipColour = 85                                                  -- Cor do blip das caixas de loot
BlackoutTime = 600000                                                   -- Tempo para o blackout acabar (600000 = 10 minutos)
BlackoutText =
"Os serviços em nossa central foram reestabelecidos."                   -- Texto da notificação padrão para blackout desativado
-----------------------------------------------------------------------------------------------------------------------------------------
-- TEMPERATURE
-----------------------------------------------------------------------------------------------------------------------------------------
TemperatureHot = 22      -- Temperatura minima para ativar o efeito de calor
TemperatureCold = 18     -- Temperatura minima para ativar o efeito de frio
TemperatureEffect = true -- Efeitos causados por baixas ou altas temperaturas do clima
-----------------------------------------------------------------------------------------------------------------------------------------
-- BASE
-----------------------------------------------------------------------------------------------------------------------------------------
BaseMode = "license" -- license ou steam
-----------------------------------------------------------------------------------------------------------------------------------------
-- IGNOREF7
-----------------------------------------------------------------------------------------------------------------------------------------
IgnoreF7 = { -- Ids que podem usar o f7
	[1] = true
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- BANK
-----------------------------------------------------------------------------------------------------------------------------------------
NewBank = true         -- true se você tiver o nosso bank
NewBankTaxs = true     -- true se você quiser ativar os impostos
NewBankMinTaxs = 15000 -- true se quiser ativar os impostos na base com o nosso bank
-----------------------------------------------------------------------------------------------------------------------------------------
-- ENTITYLOCKDOWN
-----------------------------------------------------------------------------------------------------------------------------------------
EntityLockdown = "relaxed" -- relaxed ou inactive
-----------------------------------------------------------------------------------------------------------------------------------------
-- HUNGER / THIRST
-----------------------------------------------------------------------------------------------------------------------------------------
ConsumeHunger = 1            -- Quantos % vai consumir da fome
ConsumeThirst = 1            -- Quantos % vai consumir da sede
CooldownHungerThrist = 60000 -- Tempo de desgaste
-----------------------------------------------------------------------------------------------------------------------------------------
-- MAINTENANCE
-----------------------------------------------------------------------------------------------------------------------------------------
Maintenance = false      -- true para ativar a manutenção
MaintenanceText =
"Servidor em manutenção" -- Texto exibido quando o servidor está em manutenção
MaintenanceLicenses = {  -- licenses que podem entrar na manutenção
	[""] = true
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- ARENAITENS
-----------------------------------------------------------------------------------------------------------------------------------------
ArenaItens = { -- Itens que são dados ao entrar na arena
	["WEAPON_COMBATPISTOL"] = 1,
	["WEAPON_PISTOL_MK2"] = 1,
	["WEAPON_PISTOL_AMMO"] = 1000
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHARACTERITENS
-----------------------------------------------------------------------------------------------------------------------------------------
CharacterItens = { -- Itens que são dados ao criar um personagem
	["water"] = 1,
	["sandwich"] = 1,
	["cellphone"] = 1
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- GROUPBLIPS
-----------------------------------------------------------------------------------------------------------------------------------------
GroupBlips = { -- Serviços com blips em tempo real
	["Lspd"] = true,
	["Sheriff"] = true,
	["Corrections"] = true,
	["Paramedico"] = true
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- STARTCLOTHES
-----------------------------------------------------------------------------------------------------------------------------------------
StartClothes = { -- Roupas padrões ao criar um personagem
	["mp_m_freemode_01"] = {
		["pants"] = { item = 0, texture = 0 },
		["arms"] = { item = 0, texture = 0 },
		["tshirt"] = { item = 1, texture = 0 },
		["torso"] = { item = 0, texture = 0 },
		["vest"] = { item = 0, texture = 0 },
		["shoes"] = { item = 0, texture = 0 },
		["mask"] = { item = 0, texture = 0 },
		["backpack"] = { item = 0, texture = 0 },
		["hat"] = { item = -1, texture = 0 },
		["glass"] = { item = 0, texture = 0 },
		["ear"] = { item = -1, texture = 0 },
		["watch"] = { item = -1, texture = 0 },
		["bracelet"] = { item = -1, texture = 0 },
		["accessory"] = { item = 0, texture = 0 },
		["decals"] = { item = 0, texture = 0 }
	},
	["mp_f_freemode_01"] = {
		["pants"] = { item = 0, texture = 0 },
		["arms"] = { item = 0, texture = 0 },
		["tshirt"] = { item = 1, texture = 0 },
		["torso"] = { item = 0, texture = 0 },
		["vest"] = { item = 0, texture = 0 },
		["shoes"] = { item = 0, texture = 0 },
		["mask"] = { item = 0, texture = 0 },
		["backpack"] = { item = 0, texture = 0 },
		["hat"] = { item = -1, texture = 0 },
		["glass"] = { item = 0, texture = 0 },
		["ear"] = { item = -1, texture = 0 },
		["watch"] = { item = -1, texture = 0 },
		["bracelet"] = { item = -1, texture = 0 },
		["accessory"] = { item = 0, texture = 0 },
		["decals"] = { item = 0, texture = 0 }
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- LANG
-----------------------------------------------------------------------------------------------------------------------------------------
Lang = { -- Configuração de idioma da fila
	["Join"] = "Entrando...",
	["Connecting"] = "Conectando...",
	["Position"] = "Você é o %d/%d da fila, aguarde sua conexão",
	["Error"] = "Conexão perdida."
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- QUEUE
-----------------------------------------------------------------------------------------------------------------------------------------
Queue = { -- Configuração da fila
	["List"] = {},
	["Players"] = {},
	["Counts"] = 0,
	["Connecting"] = {},
	["Threads"] = 0,
	["Max"] = 2048
}
