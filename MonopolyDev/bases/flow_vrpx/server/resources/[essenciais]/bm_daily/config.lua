config = {}
config.createTable = true -- Criar tabela no banco de dados Automaticamente
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- RECOMPENSAS
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
config.recompensas = {
    [1] = {
        time = 60, -- TEMPO PARA RECOMPENSA ( MINUTOS )
        rewards = {
            { item = "maconha", nome = "Maconha", amount = 10, chance = 60, notify = false },
            { item = "radio", nome = "Radio", amount = 2, chance = 50, notify = false },
            { item = "mochila", nome = "Mochila", amount = 2, chance = 40, notify = false },
            { item = "celular", nome = "Celular", amount = 2, chance = 100, notify = false },
            { item = "roupas", nome = "Roupas", amount = 2, chance = 40, notify = false },
            { item = "repairkit", nome = "Kit de Reparos", amount = 2, chance = 60, notify = false },
            { item = "dirty_money", nome = "Dinheiro Sujo", amount = 1000, chance = 50, notify = false },
            { item = "WEAPON_SNSPISTOL_MK2", nome = "Pistola Fajuta", amount = 1, chance = 10, notify = true },
        }
    },

    [2] = {
        time = 120, -- TEMPO PARA RECOMPENSA ( MINUTOS )
        rewards = {
            { item = "maconha", nome = "Maconha", amount = 20, chance = 55, notify = false },
            { item = "radio", nome = "Radio", amount = 3, chance = 40, notify = false },
            { item = "mochila", nome = "Mochila", amount = 3, chance = 40, notify = false },
            { item = "celular", nome = "Celular", amount = 3, chance = 100, notify = false },
            { item = "roupas", nome = "Roupas", amount = 3, chance = 40, notify = false },
            { item = "repairkit", nome = "Kit de Reparos", amount = 2, chance = 50, notify = false },
            { item = "dirty_money", nome = "Dinheiro Sujo", amount = 5000, chance = 45, notify = false },
            { item = "WEAPON_SNSPISTOL_MK2", nome = "Pistola Fajuta", amount = 1, chance = 20, notify = true },
        }
    },

    [3] = {
        time = 300, -- TEMPO PARA RECOMPENSA ( MINUTOS )
        rewards = {
            { item = "maconha", nome = "Maconha", amount = 30, chance = 50, notify = false },
            { item = "radio", nome = "Radio", amount = 4, chance = 45, notify = false },
            { item = "mochila", nome = "Mochila", amount = 4, chance = 45, notify = false },
            { item = "celular", nome = "Celular", amount = 4, chance = 100, notify = false },
            { item = "roupas", nome = "Roupas", amount = 4, chance = 45, notify = false },
            { item = "repairkit", nome = "Kit de Reparos", amount = 4, chance = 50, notify = false },
            { item = "dirty_money", nome = "Dinheiro Sujo", amount = 10000, chance = 40, notify = false },
            { item = "cocaina", nome = "Cocaina", amount = 30, chance = 50, notify = false },
            { item = "WEAPON_SNSPISTOL_MK2", nome = "Pistola Fajuta", amount = 1, chance = 30, notify = true },
            { item = "AMMO_SNSPISTOL_MK2", nome = "M. Pistola Fajuta", amount = 30, chance = 15, notify = false },
            { item = "WEAPON_PISTOL_MK2", nome = "Five-Seven", amount = 1, chance = 5, notify = true },
            { item = "AMMO_PISTOL_MK2", nome = "M. Five-Seven", amount = 20, chance = 5, notify = false },
            { item = "WEAPON_KNIFE", nome = "Faca", amount = 1, chance = 10, notify = true },
            { item = "WEAPON_SWITCHBLADE", nome = "Canivete", amount = 1, chance = 10, notify = true },
        }
    },

    [4] = {
        time = 420, -- TEMPO PARA RECOMPENSA ( MINUTOS )
        rewards = {
            { item = "algemas", nome = "Algemas", amount = 1, chance = 50, notify = false },
            { item = "corda", nome = "Corda", amount = 1, chance = 100, notify = false },
            { item = "WEAPON_PISTOL_MK2", nome = "Five-Seven", amount = 1, chance = 10, notify = true },
            { item = "AMMO_PISTOL_MK2", nome = "M. Five-Seven", amount = 55, chance = 10, notify = false },
            { item = "WEAPON_KNIFE", nome = "Faca", amount = 1, chance = 10, notify = true },
            { item = "WEAPON_SWITCHBLADE", nome = "Canivete", amount = 1, chance = 10, notify = true },
            { item = "WEAPON_ASSAULTRIFLE", nome = "AK-47", amount = 1, chance = 10, notify = true },
            { item = "AMMO_ASSAULTRIFLE", nome = "M. AK-47", amount = 80, chance = 10, notify = false },
            { item = "WEAPON_MACHINEPISTOL", nome = "Tec-9", amount = 1, chance = 10, notify = true },
            { item = "AMMO_MACHINEPISTOL", nome = "M. Tec-9", amount = 80, chance = 10, notify = false },
        }
    },

    [5] = {
        time = 540, -- TEMPO PARA RECOMPENSA ( MINUTOS )
        rewards = {
            { item = "algemas", nome = "Algemas", amount = 1, chance = 45, notify = false },
            { item = "corda", nome = "Corda", amount = 1, chance = 100, notify = false },
            { item = "WEAPON_PISTOL_MK2", nome = "Five-Seven", amount = 1, chance = 15, notify = true },
            { item = "AMMO_PISTOL_MK2", nome = "M. Five-Seven", amount = 55, chance = 15, notify = false },
            { item = "WEAPON_KNIFE", nome = "Faca", amount = 1, chance = 15, notify = true },
            { item = "WEAPON_SWITCHBLADE", nome = "Canivete", amount = 1, chance = 10, notify = true },
            { item = "WEAPON_ASSAULTRIFLE", nome = "AK-47", amount = 1, chance = 15, notify = true },
            { item = "AMMO_ASSAULTRIFLE", nome = "M. AK-47", amount = 120, chance = 15, notify = false },
            { item = "WEAPON_MACHINEPISTOL", nome = "Tec-9", amount = 1, chance = 15, notify = true },
            { item = "AMMO_MACHINEPISTOL", nome = "M. Tec-9", amount = 120, chance = 15, notify = false },
        }
    },

    [6] = {
        time = 660, -- TEMPO PARA RECOMPENSA ( MINUTOS )
        rewards = {
            { item = "algemas", nome = "Algemas", amount = 2, chance = 40, notify = false },
            { item = "corda", nome = "Corda", amount = 2, chance = 40, notify = false },
            { item = "lsd", nome = "LSD", amount = 40, chance = 50, notify = false },
            { item = "WEAPON_PISTOL_MK2", nome = "Five-Seven", amount = 1, chance = 20, notify = true },
            { item = "AMMO_PISTOL_MK2", nome = "M. Five-Seven", amount = 100, chance = 100, notify = false },
            { item = "WEAPON_KNIFE", nome = "Faca", amount = 1, chance = 20, notify = true },
            { item = "WEAPON_SWITCHBLADE", nome = "Canivete", amount = 1, chance = 20, notify = true },
            { item = "WEAPON_ASSAULTRIFLE", nome = "AK-47", amount = 1, chance = 20, notify = true },
            { item = "AMMO_ASSAULTRIFLE", nome = "M. AK-47", amount = 100, chance = 20, notify = false },
            { item = "WEAPON_ASSAULTRIFLE_MK2", nome = "AK-47 MK2", amount = 1, chance = 20, notify = true },
            { item = "AMMO_ASSAULTRIFLE_MK2", nome = "M. AK-47 MK2", amount = 100, chance = 20, notify = false },
        }
    },

    [7] = {
        time = 780, -- TEMPO PARA RECOMPENSA ( MINUTOS )
        rewards = {
            { item = "algemas", nome = "Algemas", amount = 2, chance = 35, notify = false },
            { item = "corda", nome = "Corda", amount = 2, chance = 35, notify = false },
            { item = "lsd", nome = "LSD", amount = 60, chance = 50, notify = false },
            { item = "WEAPON_HAMMER", nome = "Martelo", amount = 1, chance = 15, notify = true },
            { item = "WEAPON_BAT", nome = "Taco de baseball", amount = 1, chance = 15, notify = true },
            { item = "WEAPON_ASSAULTRIFLE", nome = "AK-47", amount = 1, chance = 25, notify = true },
            { item = "AMMO_ASSAULTRIFLE", nome = "M. AK-47", amount = 120, chance = 100, notify = false },
            { item = "WEAPON_ASSAULTRIFLE_MK2", nome = "AK-47 MK2", amount = 1, chance = 25, notify = true },
            { item = "AMMO_ASSAULTRIFLE_MK2", nome = "M. AK-47 MK2", amount = 120, chance = 20, notify = false },
        }
    },

    [8] = {
        time = 900, -- TEMPO PARA RECOMPENSA ( MINUTOS )
        rewards = {
            { item = "algemas", nome = "Algemas", amount = 3, chance = 30, notify = false },
            { item = "corda", nome = "Corda", amount = 3, chance = 30, notify = false },
            { item = "lsd", nome = "LSD", amount = 80, chance = 45, notify = false },
            { item = "WEAPON_HAMMER", nome = "Martelo", amount = 1, chance = 15, notify = true },
            { item = "WEAPON_KNUCKLE", nome = "Soco Ingles", amount = 1, chance = 1, notify = true },
            { item = "WEAPON_ASSAULTRIFLE", nome = "AK-47", amount = 1, chance = 30, notify = true },
            { item = "AMMO_ASSAULTRIFLE", nome = "M. AK-47", amount = 150, chance = 100, notify = false },
            { item = "WEAPON_ASSAULTRIFLE_MK2", nome = "AK-47 MK2", amount = 1, chance = 30, notify = true },
            { item = "AMMO_ASSAULTRIFLE_MK2", nome = "M. AK-47 MK2", amount = 120, chance = 30, notify = false },
            { item = "WEAPON_SPECIALCARBINE_MK2", nome = "G3", amount = 1, chance = 5, notify = true },
            { item = "AMMO_SPECIALCARBINE_MK2", nome = "M. G3", amount = 50, chance = 5, notify = false },
        }
    },

    [9] = {
        time = 1020, -- TEMPO PARA RECOMPENSA ( MINUTOS )
        rewards = {
            { item = "algemas", nome = "Algemas", amount = 3, chance = 25, notify = false },
            { item = "corda", nome = "Corda", amount = 3, chance = 25, notify = false },
            { item = "lsd", nome = "LSD", amount = 100, chance = 35, notify = false },
            { item = "WEAPON_HAMMER", nome = "Martelo", amount = 1, chance = 20, notify = true },
            { item = "WEAPON_KNUCKLE", nome = "Soco Ingles", amount = 1, chance = 5, notify = true },
            { item = "WEAPON_ASSAULTRIFLE_MK2", nome = "AK-47 MK2", amount = 1, chance = 30, notify = true },
            { item = "AMMO_ASSAULTRIFLE_MK2", nome = "M. AK-47 MK2", amount = 150, chance = 100, notify = false },
            { item = "WEAPON_SPECIALCARBINE_MK2", nome = "G3", amount = 1, chance = 10, notify = true },
            { item = "AMMO_SPECIALCARBINE_MK2", nome = "M. G3", amount = 100, chance = 10, notify = false },
        }
    },

    [10] = {
        time = 1140, -- TEMPO PARA RECOMPENSA ( MINUTOS )
        rewards = {
            { item = "algemas", nome = "Algemas", amount = 3, chance = 25, notify = false },
            { item = "corda", nome = "Corda", amount = 3, chance = 25, notify = false },
            { item = "lsd", nome = "LSD", amount = 120, chance = 30, notify = false },
            { item = "WEAPON_HAMMER", nome = "Martelo", amount = 1, chance = 30, notify = true },
            { item = "WEAPON_KNUCKLE", nome = "Soco Ingles", amount = 1, chance = 10, notify = true },
            { item = "WEAPON_KNIFE", nome = "Faca", amount = 1, chance = 30, notify = true },
            { item = "WEAPON_SWITCHBLADE", nome = "Canivete", amount = 1, chance = 30, notify = true },
            { item = "WEAPON_BAT", nome = "Taco de baseball", amount = 1, chance = 30, notify = true },
            { item = "WEAPON_ASSAULTRIFLE", nome = "AK-47", amount = 1, chance = 30, notify = true },
            { item = "AMMO_ASSAULTRIFLE", nome = "M. AK-47", amount = 80, chance = 30, notify = false },
            { item = "WEAPON_MACHINEPISTOL", nome = "Tec-9", amount = 1, chance = 30, notify = true },
            { item = "AMMO_MACHINEPISTOL", nome = "M. Tec-9", amount = 120, chance = 100, notify = false },
            { item = "WEAPON_PISTOL_MK2", nome = "Five-Seven", amount = 1, chance = 30, notify = true },
            { item = "AMMO_PISTOL_MK2", nome = "M. Five-Seven", amount = 120, chance = 30, notify = false },
            { item = "WEAPON_ASSAULTRIFLE_MK2", nome = "AK-47 MK2", amount = 1, chance = 30, notify = true },
            { item = "AMMO_ASSAULTRIFLE_MK2", nome = "M. AK-47 MK2", amount = 120, chance = 30, notify = false },
            { item = "WEAPON_SPECIALCARBINE_MK2", nome = "G3", amount = 1, chance = 15, notify = true },
            { item = "AMMO_SPECIALCARBINE_MK2", nome = "M. G3", amount = 120, chance = 15, notify = false },
        }
    },

    [11] = {
        time = 1260, -- TEMPO PARA RECOMPENSA ( MINUTOS )
        rewards = {
            { item = "algemas", nome = "Algemas", amount = 3, chance = 15, notify = false },
            { item = "corda", nome = "Corda", amount = 3, chance = 15, notify = false },
            { item = "lsd", nome = "LSD", amount = 150, chance = 25, notify = false },
            { item = "WEAPON_HAMMER", nome = "Martelo", amount = 1, chance = 30, notify = true },
            { item = "WEAPON_KNUCKLE", nome = "Soco Ingles", amount = 1, chance = 15, notify = true },
            { item = "WEAPON_KNIFE", nome = "Faca", amount = 1, chance = 30, notify = true },
            { item = "WEAPON_SWITCHBLADE", nome = "Canivete", amount = 1, chance = 30, notify = true },
            { item = "WEAPON_BAT", nome = "Taco de baseball", amount = 1, chance = 30, notify = true },
            { item = "WEAPON_ASSAULTRIFLE", nome = "AK-47", amount = 1, chance = 30, notify = true },
            { item = "AMMO_ASSAULTRIFLE", nome = "M. AK-47", amount = 80, chance = 30, notify = false },
            { item = "WEAPON_MACHINEPISTOL", nome = "Tec-9", amount = 1, chance = 30, notify = true },
            { item = "AMMO_MACHINEPISTOL", nome = "M. Tec-9", amount = 120, chance = 30, notify = false },
            { item = "WEAPON_PISTOL_MK2", nome = "Five-Seven", amount = 1, chance = 30, notify = true },
            { item = "AMMO_PISTOL_MK2", nome = "M. Five-Seven", amount = 120, chance = 100, notify = false },
            { item = "WEAPON_ASSAULTRIFLE_MK2", nome = "AK-47 MK2", amount = 1, chance = 30, notify = true },
            { item = "AMMO_ASSAULTRIFLE_MK2", nome = "M. AK-47 MK2", amount = 120, chance = 30, notify = false },
            { item = "WEAPON_SPECIALCARBINE_MK2", nome = "G3", amount = 1, chance = 20, notify = true },
            { item = "AMMO_SPECIALCARBINE_MK2", nome = "M. G3", amount = 120, chance = 20, notify = false },
        }
    },

    [12] = {
        time = 1380, -- TEMPO PARA RECOMPENSA ( MINUTOS )
        rewards = {
            { item = "algemas", nome = "Algemas", amount = 3, chance = 10, notify = false },
            { item = "corda", nome = "Corda", amount = 3, chance = 10, notify = false },
            { item = "lsd", nome = "LSD", amount = 180, chance = 20, notify = false },
            { item = "WEAPON_HAMMER", nome = "Martelo", amount = 1, chance = 30, notify = true },
            { item = "WEAPON_KNUCKLE", nome = "Soco Ingles", amount = 1, chance = 20, notify = true },
            { item = "WEAPON_KNIFE", nome = "Faca", amount = 1, chance = 30, notify = true },
            { item = "WEAPON_SWITCHBLADE", nome = "Canivete", amount = 1, chance = 30, notify = true },
            { item = "WEAPON_BAT", nome = "Taco de baseball", amount = 1, chance = 30, notify = true },
            { item = "WEAPON_ASSAULTRIFLE", nome = "AK-47", amount = 1, chance = 30, notify = true },
            { item = "AMMO_ASSAULTRIFLE", nome = "M. AK-47", amount = 80, chance = 30, notify = false },
            { item = "WEAPON_MACHINEPISTOL", nome = "Tec-9", amount = 1, chance = 30, notify = true },
            { item = "AMMO_MACHINEPISTOL", nome = "M. Tec-9", amount = 120, chance = 30, notify = false },
            { item = "WEAPON_PISTOL_MK2", nome = "Five-Seven", amount = 1, chance = 30, notify = true },
            { item = "AMMO_PISTOL_MK2", nome = "M. Five-Seven", amount = 120, chance = 100, notify = false },
            { item = "WEAPON_ASSAULTRIFLE_MK2", nome = "AK-47 MK2", amount = 1, chance = 30, notify = true },
            { item = "AMMO_ASSAULTRIFLE_MK2", nome = "M. AK-47 MK2", amount = 120, chance = 30, notify = false },
            { item = "WEAPON_SPECIALCARBINE_MK2", nome = "G3", amount = 1, chance = 25, notify = true },
            { item = "AMMO_SPECIALCARBINE_MK2", nome = "M. G3", amount = 120, chance = 25, notify = false },
        }
    },


    [13] = {
        time = 1500, -- TEMPO PARA RECOMPENSA ( MINUTOS )
        rewards = {
            { item = "algemas", nome = "Algemas", amount = 3, chance = 10, notify = false },
            { item = "corda", nome = "Corda", amount = 3, chance = 10, notify = false },
            { item = "lsd", nome = "LSD", amount = 200, chance = 20, notify = false },
            { item = "WEAPON_HAMMER", nome = "Martelo", amount = 1, chance = 30, notify = true },
            { item = "WEAPON_KNUCKLE", nome = "Soco Ingles", amount = 1, chance = 30, notify = true },
            { item = "WEAPON_KNIFE", nome = "Faca", amount = 1, chance = 30, notify = true },
            { item = "WEAPON_SWITCHBLADE", nome = "Canivete", amount = 1, chance = 30, notify = true },
            { item = "WEAPON_BAT", nome = "Taco de baseball", amount = 1, chance = 30, notify = true },
            { item = "WEAPON_ASSAULTRIFLE", nome = "AK-47", amount = 1, chance = 30, notify = true },
            { item = "AMMO_ASSAULTRIFLE", nome = "M. AK-47", amount = 80, chance = 30, notify = false },
            { item = "WEAPON_MACHINEPISTOL", nome = "Tec-9", amount = 1, chance = 30, notify = true },
            { item = "AMMO_MACHINEPISTOL", nome = "M. Tec-9", amount = 120, chance = 30, notify = false },
            { item = "WEAPON_PISTOL_MK2", nome = "Five-Seven", amount = 1, chance = 30, notify = true },
            { item = "AMMO_PISTOL_MK2", nome = "M. Five-Seven", amount = 120, chance = 100, notify = false },
            { item = "WEAPON_ASSAULTRIFLE_MK2", nome = "AK-47 MK2", amount = 1, chance = 30, notify = true },
            { item = "AMMO_ASSAULTRIFLE_MK2", nome = "M. AK-47 MK2", amount = 120, chance = 30, notify = false },
            { item = "WEAPON_SPECIALCARBINE_MK2", nome = "G3", amount = 1, chance = 30, notify = true },
            { item = "AMMO_SPECIALCARBINE_MK2", nome = "M. G3", amount = 120, chance = 30, notify = false },
        }
    },
}