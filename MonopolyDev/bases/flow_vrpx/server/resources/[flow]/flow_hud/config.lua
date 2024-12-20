--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- CONFIGS
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Config = {
    Hud = {
        threadPlyDelay = 800, -- Delay da a pé ( quanto menor mais rapido a atualizacao da hud mas menos otimizado.. )
        threadVehicleDelay = 100, -- Delay da Thread No Veiculo ( quanto menor mais rapido a atualizacao da hud mas menos otimizado.. )
        speedometer = 3.6, -- Multiplicador da velocidade [ ATUALMENTE EM KM/h ]

        cupom = { -- SISTEMA DE CUPOM
            active = true, -- Ativado / Desativado

            name = "pokemon2" -- nome do cupom
        },
        
        assault = { -- Horario de Assalto
            active = true, -- Ativado / Desativado

            hourInit = "21", -- Hora que inicia
            hourFinish = "07" -- Hora que acaba
        },

        foodSystem = { -- SISTEMA DE FOME E SEDE
            active = true, -- Ativado / Desativado
            eventHunger = "vRP.upgradeThirst",
            eventThrist = "vRP.upgradeHunger"
        },
		
        seatbelt = { -- SISTEMA DE CINTO DE SEGURANCA
            key = "g", -- Tecla para colocar/retirar o cinto
        },

        colors = { -- Cores da HUD
            primaryBgColor = "#402e62", -- Cor do lado esquerdo do gradient do background roxo escuro
            secundaryBgColor = "#3f315b80", -- Cor do lado direito do gradient do background roxo escuro
            primaryIconColor = "#a84efd", -- Cor do lado esquerdo do gradiente do icone roxo claro
            secondaryIconColor = "#43315b", -- Cor do lado direito do gradiente do icone roxo escuro
            borderColor = "#7d5ca7", -- Cor da borda roxo bebe
            titleColor = "#8b4efd", --"#7B4EFD", -- Cor dos titulos
            subtitleColor = "#ffffff", -- Cor dos textos em baixo
        },

        events = { -- CONFIGURE SEUS EVENTOS PARA SEU VOIP FUNCIONAR 100% COM A HUD
            range = "pma-voice:setTalkingMode", -- SEU EVENTO QUE SEU VOIP ENVIA PARA ALTERAR AS INFORMACOES NA HUD ( ALTERAR DISTANCIA DO VOIP )
            radio = "hud:RadioDisplay", -- SEU EVENTO QUE SEU VOIP ENVIA PARA ALTERAR AS INFORMACOES NA HUD ( ALTERAR FREQUENCIA DO RADIO )
        },
    },

    Notify = {
        eventName = "Notify",

        colors = { -- CORES DA NOTIFY ( SIM, POSSIVEL VC CRIAR MAIS TIPOS DE NOTIFYS )
            ["aviso"] = {
                title = "#4A93FF",
                background = "#4E95FF",
                border = "#5D7CAB"
            },
            ["sucesso"] = {
                title = "#5CA795",
                background = "#46BFBF",
                border = "#5CA795"
            },
            ["negado"] = {
                title = "#FD4E4E",
                background = "#FD4E4E",
                border = "#A75C5C"
            },
            ["importante"] = {
                title = "#FFEB81",
                background = "#FFE34F",
                border = "#A79B5C"
            },
        }
    },
    
    Chat = {
        eventNameAlerts = "NotifyAlert", -- Notify de Alertas
        eventNameChat = "chatMessage",
        
        Alerts = { -- COMANDOS DE ALERTAS ( NOTIFY DIFERENCIADA )
			
			{
                commandName = "avisoadm", -- Comando
                permiss = "dono.permissao", -- Permissao para usar o comando
                SeePermission = nil, -- Permissao que vai ver essa notificação ( nil =  todos )
                author = true, -- Se vai enviar o nome do author ex: flow zera enviou...
                time = 60, -- Tempo em segundo(s) que o alerta vai ficar na tela
                title = "Prefeitura", -- Titulo do alerta
                color = {
                    title = "#5CA795", -- Verde
                    background = "#2F2E62", -- 
                    border = "#5E5CA7"
                }
            },
			
			{
                commandName = "adm", -- Comando
                permiss = "dono.permissao", -- Permissao para usar o comando
                SeePermission = nil, -- Permissao que vai ver essa notificação ( nil =  todos )
                author = true, -- Se vai enviar o nome do author ex: flow zera enviou...
                time = 60, -- Tempo em segundo(s) que o alerta vai ficar na tela
                title = "Prefeitura", -- Titulo do alerta
                color = {
                    title = "#5CA795", -- Verde
                    background = "#2F2E62", -- 
                    border = "#5E5CA7"
                }
            },
			
			{
                commandName = "anuncio", -- Comando
                permiss = "perm.disparo", -- Permissao para usar o comando
                SeePermission = nil, -- Permissao que vai ver essa notificação ( nil =  todos )
                author = true, -- Se vai enviar o nome do author ex: flow zera enviou...
                time = 60, -- Tempo em segundo(s) que o alerta vai ficar na tela
                title = "Policia", -- Titulo do alerta
                color = {
                    title = "#FFFFFF", -- Verde
                    background = "#6BF5FF", -- 
                    border = "#0FF"
                }
            },
			
			{
                commandName = "festa", -- Comando
                permiss = "dono.permissao", -- Permissao para usar o comando
                SeePermission = nil, -- Permissao que vai ver essa notificação ( nil =  todos )
                author = true, -- Se vai enviar o nome do author ex: flow zera enviou...
                time = 25, -- Tempo em segundo(s) que o alerta vai ficar na tela
                title = "festinha", -- Titulo do alerta
                color = {
                    title = "#00FFFF", -- Verde
                    background = "#EE82EE", -- 
                    border = "#8B008B"
                }
            },
			
            
        },
       
        Commands = { -- CHAT PARA ORGANIZACOES E ETC
		
			{
                commandName = "chatadm",
                permiss = "prefeitura.permissao", -- Permissao para usar o comando
                SeePermission = "prefeitura.permissao", -- Permissao que vai ver essa notificação ( nil =  todos )
                author = true, -- Se vai enviar o nome do author ex: flow zera enviou...
                title = "ADM: ", -- Titulo da mensagem
                color = { 
                    background = "#2F2E62", -- Cor do Fundo da Mensagem em RGB
                },
            },
			
            {
                commandName = "pd",
                permiss = "perm.disparo", -- Permissao para usar o comando
                SeePermission = "perm.disparo", -- Permissao que vai ver essa notificação ( nil =  todos )
                author = true, -- Se vai enviar o nome do author ex: flow zera enviou...
                title = "190: ", -- Titulo da mensagem
                color = { 
                    background = "#2F2E62", -- Cor do Fundo da Mensagem em RGB
                },
            },
			
            {
                commandName = "192",
                permiss = "perm.unizk", -- Permissao para usar o comando
                SeePermission = nil, -- Permissao que vai ver essa notificação ( nil =  todos )
                author = true, -- Se vai enviar o nome do author ex: flow zera enviou...
                title = "SAMU: ", -- Titulo da mensagem
                color = { 
                    background = "#FF0000", -- Cor do Fundo da Mensagem em RGB
                },
            },
			
            {
                commandName = "ilegal",
                permiss = "perm.ilegal", -- Permissao para usar o comando
                SeePermission = "perm.ilegal", -- Permissao que vai ver essa notificação ( nil =  todos )
                author = false, -- Se vai enviar o nome do author ex: flow zera enviou...
                title = "ILEGAL: ", -- Titulo da mensagem
                color = { 
                    background = "#000000", -- Cor do Fundo da Mensagem em RGB
                },
            },

            {
                commandName = "190",
                permiss = "perm.disparo", -- Permissao para usar o comando
                SeePermission = nil, -- Permissao que vai ver essa notificação ( nil =  todos )
                author = true, -- Se vai enviar o nome do author ex: flow zera enviou...
                title = "190: ", -- Titulo da mensagem
                color = { 
                    background = "#2647F4", -- Cor do Fundo da Mensagem em RGB
                },
            },
			
			{
                commandName = "tw",
                permiss = nil, -- Permissao para usar o comando
                SeePermission = nil, -- Permissao que vai ver essa notificação ( nil =  todos )
                author = true, -- Se vai enviar o nome do author ex: flow zera enviou...
                title = "TW: ", -- Titulo da mensagem
                color = { 
                    background = "#000000", -- Cor do Fundo da Mensagem em RGB
                },
            },
			
			{
                commandName = "adv",
                permiss = "juridico.permissao", -- Permissao para usar o comando
                SeePermission = nil, -- Permissao que vai ver essa notificação ( nil =  todos )
                author = true, -- Se vai enviar o nome do author ex: flow zera enviou...
                title = "Juridico: ", -- Titulo da mensagem
                color = { 
                    background = "#2647F4", -- Cor do Fundo da Mensagem em RGB
                },
            },
			
		
        },
        
        Proximity = { -- CHATS PARA JOGADORES PROXIMOS
            active = true, -- SE O CHAT PARA JOGADORES PROXIMO FOR ATIVO.
            
            List = {
                {
                    permiss = "admin.permissao", -- Permissao
                    prefix = "[ADMIN]", -- Prefix da mensagem [ADMIN]: Enviou
                    distance = 30.0, -- Defina a distancia de quem pode ver esse chat
                    color = { 
                        background = "#2F2E62", -- Cor do Fundo da Mensagem em HEX
                    },
                },

                {
                    permiss = "acessovip.permissao", -- Permissao
                    prefix = "[VIP]", -- Prefix da mensagem [ADMIN]: Enviou
                    distance = 30.0, -- Defina a distancia de quem pode ver esse chat
                    color = { 
                        background = "#DAA520", -- Cor do Fundo da Mensagem em HEX 2F2E62
                    },
                },

                { -- CHAT PARA JOGADORES SEM PERMISSAO, DISTANCIA 30.0 METROS ( SEMPRE DEIXAR EM ULTIMO CASO QUEIRA HABILITAR PARA RANDOLAS )
                    permiss = nil, -- Permissao
                    prefix = "[PLAYER]", -- Prefix da mensagem [PLAYER]: Enviou
                    distance = 30.0, -- Defina a distancia de quem pode ver esse chat
                    color = { 
                        background = "#2F2E62", -- Cor do Fundo da Mensagem em HEX
                    },
                },
            }
        },

        filter = { -- FILTRO DE COMANDOS
            { command = "/dancar", desc = "Dance com seus amigos." },
            { command = "/namorar", desc = "Namore alguem." },
            { command = "/flow", desc = "Gatão." },
            { command = "/boliva", desc = "Feioso." },
        },

        Langs = { -- Traduçoes
            ['notPermiss'] = function(source) TriggerClientEvent(Config.Notify.eventName, source, "negado","Você não possui permissão.", 5) end,
        }
    },
    
    ProgressBar = {
        eventName = "progress",

        color = {
            title = "#a75c5c",
            background = "#000000",
            border = "#ff3333"
        }
    },
    
    NotifyItens = {
        eventName = "NotifyItem",
        imgDir = "http://noc.anjusroleplay.cloud/images/"
    }
}

if SERVER then -- CONFIGURE SUAS FUNCTIONS SERVER-SIDES
    function getUserId(source)
        return vRP.getUserId(source)
    end

    function getUserIdentity(user_id)
        return vRP.getUserIdentity(user_id)
    end

    function hasPermission(user_id, perm)
        return vRP.hasPermission(user_id, perm)
    end

    function getUsersByPermission(perm)
        return vRP.getUsersByPermission(perm)
    end

    AddEventHandler('onResourceStart', function(resourceName)
        if (GetCurrentResourceName() == resourceName) then
            ExecuteCommand("setr game_enableFlyThroughWindscreen true")
        end
    end)
end


--[[ 
    TUTORIAL: COMO USAR O CHAT

    SERVER-SIDE
    TriggerClientEvent('chatMessage', source, message) (MENSAGEM)
    TriggerClientEvent('chatMessage', source, "[CHAT LOCAL]", message) (PREFIX | MENSAGEM)
    TriggerClientEvent('chatMessage', source, "[CHAT LOCAL]", {255,0,0}, message) (PREFIX | COLOR | MENSAGEM)

    CLIENT-SIDE
    TriggerEvent('chatMessage', message) (MENSAGEM)
    TriggerEvent('chatMessage', "[CHAT LOCAL]", message) (PREFIX | MENSAGEM)
    TriggerEvent('chatMessage', "[CHAT LOCAL]", {255,0,0}, message) (PREFIX | COLOR | MENSAGEM)
]]