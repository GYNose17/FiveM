-----------------------------------------------------------------------------------------------------------------------------------------
-- GROUPS
-----------------------------------------------------------------------------------------------------------------------------------------
Groups = {
	["Admin"] = {
		["Parent"] = {
			["Admin"] = true
		},
		["Hierarchy"] = { "Administrador", "Moderador", "Suporte" },
		["Service"] = {},
		["Client"] = true
	},
	["Premium"] = {
		["Parent"] = {
			["Premium"] = true
		},
		["Hierarchy"] = { "Platina", "Ouro", "Prata", "Bronze" },
		["Salary"] = { 2500, 2250, 2000, 1750 },
		["Service"] = {},
		["Client"] = true
	},
	["Buff"] = {
		["Parent"] = {
			["Buff"] = true
		},
		["Hierarchy"] = { "Chefe" },
		["Salary"] = { 2250 },
		["Service"] = {}
	},
	-----------------------------------------------------------------------------------------------------------------------------------------
	-- Works
	-----------------------------------------------------------------------------------------------------------------------------------------
	["Lspd"] = {
		["Parent"] = {
			["Lspd"] = true
		},
		["Hierarchy"] = { "Chefe", "Capitão", "Tenente", "Sargento", "Corporal", "Oficial", "Cadete" },
		["Salary"] = { 2725, 2500, 2500, 2225, 2225, 2000, 2000 },
		["Service"] = {},
		["Type"] = "Work",
		["Client"] = true
	},
	["Sheriff"] = {
		["Parent"] = {
			["Sheriff"] = true
		},
		["Hierarchy"] = { "Chefe", "Capitão", "Tenente", "Sargento", "Corporal", "Oficial", "Cadete" },
		["Salary"] = { 2725, 2500, 2500, 2225, 2225, 2000, 2000 },
		["Service"] = {},
		["Type"] = "Work",
		["Client"] = true
	},
	["Corrections"] = {
		["Parent"] = {
			["Corrections"] = true
		},
		["Hierarchy"] = { "Chefe", "Capitão", "Tenente", "Sargento", "Corporal", "Oficial", "Cadete" },
		["Salary"] = { 2725, 2500, 2500, 2225, 2225, 2000, 2000 },
		["Service"] = {},
		["Type"] = "Work"
	},
	["Paramedico"] = {
		["Parent"] = {
			["Paramedico"] = true
		},
		["Hierarchy"] = { "Diretor", "Assistente", "Conselheiro", "Médico", "Enfermeiro", "Residente" },
		["Salary"] = { 2725, 2500, 2500, 2225, 2225, 2000 },
		["Service"] = {},
		["Type"] = "Work",
		["Client"] = true
	},
	["Burgershot"] = {
		["Parent"] = {
			["Burgershot"] = true
		},
		["Hierarchy"] = { "Chefe", "Sub-Chefe", "Gerente", "Conselheiro", "Membro" },
		["Service"] = {},
		["Type"] = "Work",
		["Client"] = true,
		["Max"] = 30
	},
	["Ballas"] = {
		["Parent"] = {
			["Ballas"] = true
		},
		["Hierarchy"] = { "Chefe", "Sub-Chefe", "Gerente", "Conselheiro", "Membro" },
		["Service"] = {},
		["Type"] = "Work",
		["Client"] = true,
		["Max"] = 30
	},
	["Vagos"] = {
		["Parent"] = {
			["Vagos"] = true
		},
		["Hierarchy"] = { "Chefe", "Sub-Chefe", "Gerente", "Conselheiro", "Membro" },
		["Service"] = {},
		["Type"] = "Work",
		["Client"] = true,
		["Max"] = 30
	},
	["Families"] = {
		["Parent"] = {
			["Families"] = true
		},
		["Hierarchy"] = { "Chefe", "Sub-Chefe", "Gerente", "Conselheiro", "Membro" },
		["Service"] = {},
		["Type"] = "Work",
		["Client"] = true,
		["Max"] = 30
	},
	["Aztecas"] = {
		["Parent"] = {
			["Aztecas"] = true
		},
		["Hierarchy"] = { "Chefe", "Sub-Chefe", "Gerente", "Conselheiro", "Membro" },
		["Service"] = {},
		["Type"] = "Work",
		["Client"] = true,
		["Max"] = 30
	},
	["Bloods"] = {
		["Parent"] = {
			["Bloods"] = true
		},
		["Hierarchy"] = { "Chefe", "Sub-Chefe", "Gerente", "Conselheiro", "Membro" },
		["Service"] = {},
		["Type"] = "Work",
		["Client"] = true,
		["Max"] = 30
	},
	-----------------------------------------------------------------------------------------------------------------------------------------
	-- Groups
	-----------------------------------------------------------------------------------------------------------------------------------------
	["Policia"] = {
		["Parent"] = {
			["Lspd"] = true,
			["Sheriff"] = true,
			["Corrections"] = true
		},
		["Hierarchy"] = { "Chefe" },
		["Service"] = {},
		["Type"] = "Group"
	},
	["Emergencia"] = {
		["Parent"] = {
			["Lspd"] = true,
			["Sheriff"] = true,
			["Corrections"] = true,
			["Paramedico"] = true
		},
		["Hierarchy"] = { "Chefe" },
		["Service"] = {},
		["Type"] = "Group"
	},
	["Restaurantes"] = {
		["Parent"] = {
			["BurgerShot"] = true
		},
		["Hierarchy"] = { "Chefe" },
		["Service"] = {},
		["Type"] = "Group"
	},
	["Gangs"] = {
		["Parent"] = {
			["Ballas"] = true,
			["Vagos"] = true,
			["Families"] = true,
			["Aztecas"] = true,
			["Bloods"] = true
		},
		["Hierarchy"] = { "Chefe" },
		["Service"] = {},
		["Type"] = "Group"
	},
	-----------------------------------------------------------------------------------------------------------------------------------------
	-- Enterprises
	-----------------------------------------------------------------------------------------------------------------------------------------
	["Mecanico01"] = {
		["Parent"] = {
			["Mecanico01"] = true
		},
		["Hierarchy"] = { "Chefe", "Sub-Chefe", "Gerente", "Funcionário" },
		["Service"] = {},
		["Type"] = "Work",
		["Client"] = true,
		["Max"] = 5
	},
	["Mecanico02"] = {
		["Parent"] = {
			["Mecanico02"] = true
		},
		["Hierarchy"] = { "Chefe", "Sub-Chefe", "Gerente", "Funcionário" },
		["Service"] = {},
		["Type"] = "Work",
		["Client"] = true,
		["Max"] = 5
	},
	["Mecanico03"] = {
		["Parent"] = {
			["Mecanico03"] = true
		},
		["Hierarchy"] = { "Chefe", "Sub-Chefe", "Gerente", "Funcionário" },
		["Service"] = {},
		["Type"] = "Work",
		["Client"] = true,
		["Max"] = 5
	},
	["Mecanico04"] = {
		["Parent"] = {
			["Mecanico04"] = true
		},
		["Hierarchy"] = { "Chefe", "Sub-Chefe", "Gerente", "Funcionário" },
		["Service"] = {},
		["Type"] = "Work",
		["Client"] = true,
		["Max"] = 5
	},
	["Mecanico05"] = {
		["Parent"] = {
			["Mecanico05"] = true
		},
		["Hierarchy"] = { "Chefe", "Sub-Chefe", "Gerente", "Funcionário" },
		["Service"] = {},
		["Type"] = "Work",
		["Client"] = true,
		["Max"] = 5
	}
}
