local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

Config = {
    Social = { -- REDES SOCIAIS
    ['INSTAGRAM'] = {
        active = true,
        url = 'https://www.instagram.com/', -- LINK QUE SERA REDERICIONADO APOS CLICAR
        image = 'images/instagram-icon.svg'
    },

    ['TIKTOK'] = {
        active = true,
        url = 'https://www.tiktok.com/', -- LINK QUE SERA REDERICIONADO APOS CLICAR
        image = 'images/tiktok-icon.svg'
    },

    ['LOJA VIP'] = {
        active = true,
        url = 'https://www.hydrus.gg/', -- LINK QUE SERA REDERICIONADO APOS CLICAR
        image = 'images/loja-icon.svg'
    },

    ['DISCORD'] = {
        active = true,
        url = 'https://discord.gg/', -- LINK QUE SERA REDERICIONADO APOS CLICAR
        image = 'images/discord-icon.svg'
    },
},

Info = {
    main = {
        name = function(user_id, source, identity) 
            return identity.nome .. " " .. identity.sobrenome
        end,

        genre = function(user_id, source) 
            return (GetEntityModel(GetPlayerPed(source)) == GetHashKey('mp_m_freemode_01') and "HOMEM" or "MULHER")
        end,

        image = function(user_id, source)
            local rows = vRP.query("identity/getImagem", { user_id = user_id })

            return (#rows > 0 and rows[1].avatarURL or "nao-encontrado.png" )
        end,

        wallet = function(user_id, source) 
            return vRP.getMoney(user_id)
        end,

        bank = function(user_id, source) 
            return vRP.getBankMoney(user_id)
        end,
    },

    others = {
        ['VIP'] = function(user_id, source, identity) 
            local Vips = { -- Coloque aqui o nome do seus VIPS
                "Bronze",
                "Prata",
                "Ouro",
                "Platina",
                "Diamante",
                "Esmeralda",
                "Safira",
                "Rubi",
                "RubiPlus"
            }

            local FormatVips = {}
            for index in pairs(Vips) do
                if vRP.hasGroup(user_id, Vips[index]) then
                    FormatVips[#FormatVips + 1] = Vips[index]
                end
            end           

            return (#FormatVips == 0 and "Nenhum" or FormatVips)
        end,

        ['TRABALHO'] = function(user_id, source, identity) 
            return vRP.getUserGroupByType(user_id, "org")
        end,

        ['IDENTIDADE'] = function(user_id, source, identity) 
            return identity.nome
        end,

        ['IDADE'] = function(user_id, source, identity) 
            return identity.idade
        end,

        ['TELEFONE'] = function(user_id, source, identity) 
            return identity.telefone
        end,
    }
},


Status = {
    func = vRP.getUsersByPermission, -- SUA FUNCAO DE CONTAR AS PERMISSOES

    list = {
        ['Mecanicos'] = "mecanico.online",
        ['Paramedicos'] = "perm.unizk",
        ['Policiais'] = "policia.online",
        ['Ilegal'] = "perm.ilegal",
        ['Administradores'] = "admin.perm",
        }
    },
}

vRP._prepare("identity/getImagem", "SELECT avatarURL from smartphone_instagram WHERE user_id = @user_id ")

function Identity(user_id)
    return vRP.getUserIdentity(user_id)
end

function UserId(source)
    return vRP.getUserId(source)
end