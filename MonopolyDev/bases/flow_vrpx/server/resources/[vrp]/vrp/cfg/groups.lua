local cfg = {}

cfg.groups = {
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- ADMINISTRAÇÃO
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	["developer"] = { _config = { gtype = "staff", salario = 0 }, "admin.permissao", "dv.permissao", "ticket.permissao", "developer.permissao","player.blips", "player.noclip", "player.teleport", "player.secret", "player.spec", "player.wall","spec.permissao", "mqcu.permissao", "perm.ptr.staff","player.som", "perm.algemar" },
	["developeroff"] = { _config = { gtype = "staff", salario = 0 }, "perm.user", "staffoff.permissao", "perm.ptr.staff", "perm.algemar" },
	["admin"] = { _config = { gtype = "staff", salario = 20000 }, "admin.permissao", "dv.permissao", "ticket.permissao", "player.blips", "player.noclip", "player.teleport", "player.secret", "player.spec", "player.wall","spec.permissao", "mqcu.permissao", "perm.ptr.staff", "perm.algemar" },
	["adminoff"] = { _config = { gtype = "staff", salario = 0 }, "perm.user", "staffoff.permissao", "perm.ptr.staff", "perm.algemar" },
	["moderador"] = { _config = { gtype = "staff", salario = 15000 }, "moderador.permissao", "dv.permissao", "ticket.permissao", "player.blips", "player.noclip", "player.teleport", "player.secret", "player.spec", "player.wall","spec.permissao", "mqcu.permissao", "perm.ptr.staff", "perm.algemar" },
	["moderadoroff"] = { _config = { gtype = "staff", salario = 0 }, "perm.user", "staffoff.permissao", "perm.ptr.staff", "perm.algemar" },
	["suporte"] = { _config = { gtype = "staff", salario = 10000 }, "suporte.permissao", "dv.permissao", "ticket.permissao", "player.blips", "player.noclip", "player.teleport", "player.secret", "player.spec", "player.wall","spec.permissao", "mqcu.permissao", "perm.ptr.staff", "perm.algemar" },
	["suporteoff"] = { _config = { gtype = "staff", salario = 0 }, "perm.user", "staffoff.permissao", "perm.ptr.staff", "perm.algemar" },
	["user"] = { "perm.user"},
	["streamer"] = { _config = { gtype = "staff" }, "player.blips", "player.noclip", "player.teleport", "player.secret", "player.spec", "player.wall", "mqcu.permissao", "streamer.permissao", "perm.algemar" },
	["investidoranjo"] = { _config = { gtype = "staff" }, "investidoranjo.permissao" },

	------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	-- VIPS
	------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	["Inicial"] = { _config = { gtype = "inicial", salario = 3000, ptr = nil }, "perm.vips", "perm.inicial" },
	["Bronze"] = { _config = { gtype = "bronze", salario = 2000, ptr = nil }, "perm.vips", "perm.bronze","perm.booster" },
	["Prata"] = { _config = { gtype = "prata", salario = 4000, ptr = nil }, "perm.vips", "perm.prata", "perm.booster" },
	["Ouro"] = { _config = { gtype = "ouro", salario = 6000, ptr = nil }, "perm.vips", "perm.ouro", "perm.booster","perm.roupas" },
	["Platina"] = { _config = { gtype = "platina", salario = 8000, ptr = nil }, "perm.vips", "perm.platina", "perm.booster","perm.roupas" },
	["Diamante"] = { _config = { gtype = "diamante", salario = 10000, ptr = nil }, "perm.vips", "perm.diamante", "perm.booster","perm.roupas","perm.mochila"},
	["Esmeralda"] = { _config = { gtype = "esmeralda", salario = 15000, ptr = nil }, "perm.vips", "perm.esmeralda", "perm.booster", "perm.roupas", "perm.mochila","player.som" },
	["Safira"] = { _config = { gtype = "safira", salario = 20000, ptr = nil }, "perm.vips", "perm.safira", "perm.booster", "perm.roupas", "perm.mochila","player.som" },
	["Rubi"] = { _config = { gtype = "rubi", salario = 25000, ptr = nil }, "perm.vips", "perm.rubi", "perm.booster", "perm.roupas", "perm.mochila","player.som"},
	["RubiPlus"] = { _config = { gtype = "rubiplus", salario = 30000, ptr = nil }, "perm.vips", "perm.rubiplus", "perm.booster", "perm.roupas", "perm.mochila","player.som" },

	["Exclusivo Março"] = { _config = { gtype = "vipmarco", salario = 30000, ptr = nil }, "perm.vips", "perm.vipmarco", "perm.booster", "perm.roupas", "perm.mochila","player.som" },
	["Exclusivo Pascoa"] = { _config = { gtype = "vippascoa", salario = 30000, ptr = nil }, "perm.vips", "perm.vippascoa", "perm.booster", "perm.roupas", "perm.mochila","player.som" },
	["Exclusivo Maio"] = { _config = { gtype = "vipmaio", salario = 30000, ptr = nil }, "perm.vips", "perm.vipmaio", "perm.booster", "perm.roupas", "perm.mochila","player.som" },
	["Carnaval"] = { _config = { gtype = "vipcarnaval", salario = 3000, ptr = nil }, "perm.vips", "perm.vipcarnaval", "perm.booster", "perm.roupas", "perm.mochila","player.som" },

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- BENEFICIOS
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	["Estagiario"] = { _config = { gtype = "jobdois", salario = 2000, ptr = nil }, "perm.estagiario"},
	["Funcionario"] = { _config = { gtype = "jobtres", salario = 4000, ptr = nil }, "perm.funcionario"},
	["Gerente"] = { _config = { gtype = "jobquatro", salario = 6000, ptr = nil }, "perm.gerente"},
	["Patrao"] = { _config = { gtype = "jobcinco", salario = 8000, ptr = nil }, "perm.patrao"},
	["CasaDoFranklin"] = { _config = { gtype = "jobseis", salario = 0, ptr = nil }, "perm.franklin"},
	["spotify"] = { _config = { gtype = "spotify", salario = 0, ptr = nil },"player.som"},
	["Booster"] = { _config = { salario = nil, ptr = nil }, "perm.booster" },
	["Verificado"] = { _config = { salario = nil, ptr = nil }, "perm.verificado"},
	["Vagas"] = { _config = { salario = nil, ptr = nil }, "perm.vagastres"},
	["VagasQuarenta"] = { _config = { salario = nil, ptr = nil }, "perm.vagasquarenta"}, 
	["valecasa"] = { _config = { salario = nil, ptr = nil }, "valecasa.permissao"}, 
	["valegaragem"] = { _config = { salario = nil, ptr = nil }, "valegaragem.permissao"}, 
	["ValeCasaEsmeralda"] = { _config = { salario = nil, ptr = nil }, "valecasaesmeralda.permissao"}, 
	["ValeCasaRubi"] = { _config = { salario = nil, ptr = nil }, "valecasarubi.permissao"}, 
    ["playboy"] = { _config = { salario = nil, ptr = nil }, "playboy.permissao"}, 
	["malibu"] = { _config = { salario = nil, ptr = nil }, "perm.malibu"}, 
	["starckhouse"] = { _config = { salario = nil, ptr = nil }, "perm.starckhouse"}, 
	["snakehouse"] = { _config = { salario = nil, ptr = nil }, "perm.snakehouse"}, 
	["beiramarhouse"] = { _config = { salario = nil, ptr = nil }, "perm.beiramarhouse"}, 
	["casadolado"] = { _config = { salario = nil, ptr = nil }, "perm.casadolago"}, 
	["manobras"] = { _config = { salario = nil, ptr = nil }, "perm.manobras"}, 
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- OUTROS
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	["paintball"] = { _config = { salario = nil, ptr = nil }, "player.blips", "player.noclip", "player.teleport", "player.secret", "player.spec", "player.wall" },
	["Porte de Armas"] = { _config = { salario = nil, ptr = nil }, "perm.portearmas" },

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- POLICIA
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	["Coronel"] = { _config = { gtype = "org", salario = 17000, ptr = true, orgName = "Policia" },"policia.online", "perm.policia", "perm.baupolicialider", "player.blips","perm.disparo", "perm.portasolicia", "perm.algemar", "perm.countpolicia" },
	["Tenente Coronel"] = { _config = { gtype = "org", salario = 18000, ptr = true, orgName = "Policia" },"policia.online", "perm.policia", "perm.baupolicialider", "player.blips", "perm.disparo", "perm.portasolicia", "perm.algemar", "perm.countpolicia"  },
	["Major"] = { _config = { gtype = "org", salario = 17000, ptr = true, orgName = "Policia" },"policia.online", "perm.policia", "player.blips", "perm.disparo", "perm.portasolicia", "perm.algemar", "perm.countpolicia"  },
	["Comando Rocam"] = { _config = { gtype = "org", salario = 17000, ptr = true, orgName = "Policia" },"policia.online", "perm.rocam", "perm.policia", "player.blips", "perm.disparo", "perm.portasolicia", "perm.algemar", "perm.countpolicia"  },
	["Rocam"] = { _config = { gtype = "org", salario = 17000, ptr = true, orgName = "Policia" },"policia.online", "perm.rocam", "perm.policia", "player.blips", "perm.disparo", "perm.portasolicia", "perm.algemar", "perm.countpolicia"  },
	["Capitao"] = { _config = { gtype = "org", salario = 16000, ptr = true , orgName = "Policia"},"policia.online", "perm.policia", "player.blips", "perm.disparo", "perm.portasolicia", "perm.algemar", "perm.countpolicia"  },
	["Primeiro Tenente"] = { _config = { gtype = "org", salario = 15000, ptr = true, orgName = "Policia" },"policia.online", "perm.policia", "player.blips", "perm.disparo", "perm.portasolicia", "perm.algemar", "perm.countpolicia"  },
	["Segundo Tenente"] = { _config = { gtype = "org", salario = 14000, ptr = true, orgName = "Policia" },"policia.online", "perm.policia", "player.blips", "perm.disparo", "perm.portasolicia", "perm.algemar", "perm.countpolicia"  },
	["Sub Tenente"] = { _config = { gtype = "org", salario = 13000, ptr = true, orgName = "Policia" },"policia.online", "perm.policia", "player.blips", "perm.disparo", "perm.portasolicia", "perm.algemar", "perm.countpolicia"  },
	["Primeiro Sargento"] = { _config = { gtype = "org", salario = 12000, ptr = true, orgName = "Policia" },"policia.online", "perm.policia", "player.blips", "perm.disparo", "perm.portasolicia", "perm.algemar", "perm.countpolicia"  },
	["Segundo Sargento"] = { _config = { gtype = "org", salario = 11000, ptr = true, orgName = "Policia" },"policia.online", "perm.policia", "player.blips", "perm.disparo", "perm.portasolicia", "perm.algemar", "perm.countpolicia"  },
	["Terceiro Sargento"] = { _config = { gtype = "org", salario = 10000, ptr = true, orgName = "Policia" },"policia.online", "perm.policia", "player.blips", "perm.disparo", "perm.portasolicia", "perm.algemar", "perm.countpolicia"  },
	["Cabo"] = { _config = { gtype = "org", salario = 9000, ptr = true, orgName = "Policia" }, "perm.policia","policia.online", "player.blips", "perm.disparo", "perm.portasolicia", "perm.algemar", "perm.countpolicia"  },
	["Soldado"] = { _config = { gtype = "org", salario = 8000, ptr = true, orgName = "Policia" }, "perm.policia","policia.online", "player.blips", "perm.disparo", "perm.portasolicia", "perm.algemar", "perm.countpolicia"  },
	["Aluno"] = { _config = { gtype = "org", salario = 7000, ptr = true, orgName = "Policia" }, "perm.policia","policia.online", "player.blips", "perm.disparo", "perm.portasolicia", "perm.algemar", "perm.countpolicia"  },
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- POLICIA BOPE
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	["ComandoBope"] = { _config = { gtype = "org", salario = 17000, ptr = true, orgName = "Bope" },"policia.online", "perm.policia", "perm.bope", "perm.baupolicialider", "player.blips","perm.disparo", "perm.portasolicia", "perm.algemar", "perm.countpolicia" },
	["SubComandoBope"] = { _config = { gtype = "org", salario = 18000, ptr = true, orgName = "Bope" },"policia.online", "perm.policia", "perm.bope", "perm.baupolicialider", "player.blips", "perm.disparo", "perm.portasolicia", "perm.algemar", "perm.countpolicia"  },
	["SupervisorBope"] = { _config = { gtype = "org", salario = 17000, ptr = true, orgName = "Bope" },"policia.online", "perm.policia", "perm.bope", "player.blips", "perm.disparo", "perm.portasolicia", "perm.algemar", "perm.countpolicia"  },
	["EliteBope"] = { _config = { gtype = "org", salario = 17000, ptr = true, orgName = "Bope" },"policia.online", "perm.policia", "perm.bope", "player.blips", "perm.disparo", "perm.portasolicia", "perm.algemar", "perm.countpolicia"  },
	["EstagiarioBope"] = { _config = { gtype = "org", salario = 17000, ptr = true, orgName = "Bope" },"policia.online", "perm.policia", "perm.bope", "player.blips", "perm.disparo", "perm.portasolicia", "perm.algemar", "perm.countpolicia"  },


------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- POLICIA CIVIL
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	 ["DelegadoGeral"] = { _config = { gtype = "org", salario = 25000, ptr = true, orgName = "PoliciaCivil" },"policia.online", "perm.policiacivil", "perm.baupoliciacivillider", "player.blips", "perm.disparo", "perm.portasolicia", "perm.algemar", "perm.countpolicia"  },
	 ["Delegado"] = { _config = { gtype = "org", salario = 25000, ptr = true, orgName = "PoliciaCivil" },"policia.online", "perm.policiacivil", "perm.baupoliciacivillider", "player.blips", "perm.disparo", "perm.portasolicia", "perm.algemar", "perm.countpolicia"  },
	 ["Core"] = { _config = { gtype = "org", salario = 15000, ptr = true, orgName = "PoliciaCivil" },"policia.online", "perm.policiacivil", "player.blips", "perm.disparo", "perm.policia.radio", "perm.portasolicia", "perm.algemar", "perm.countpolicia" },
	 ["Perito"] = { _config = { gtype = "org", salario = 12000, ptr = true, orgName = "PoliciaCivil" },"policia.online", "perm.policiacivil", "player.blips", "perm.disparo", "perm.portasolicia", "perm.algemar", "perm.countpolicia"  },
	 ["Escrivao"] = { _config = { gtype = "org", salario = 10000, ptr = true, orgName = "PoliciaCivil" },"policia.online", "perm.policiacivil", "player.blips", "perm.disparo", "perm.portasolicia", "perm.algemar", "perm.countpolicia"  },
	 ["Investigador"] = { _config = { gtype = "org", salario = 8000, ptr = true, orgName = "PoliciaCivil" },"policia.online", "perm.policiacivil", "player.blips", "perm.disparo", "perm.portasolicia", "perm.algemar", "perm.countpolicia"  },
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- HOSPITAL
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	["Diretor"] = { _config = { gtype = "org", salario = 27000, ptr = true, orgName = "Hospital" },"dv.permissao", "perm.unizk" },
	["Vice Diretor"] = { _config = { gtype = "org", salario = 25000, ptr = true, orgName = "Hospital"},"dv.permissao", "perm.unizk" },
	["Gestao"] = { _config = { gtype = "org", salario = 23000, ptr = true, orgName = "Hospital"},"dv.permissao", "perm.unizk" },
	["Medico Psiquiatra"] = { _config = { gtype = "org", salario = 20000, ptr = true, orgName = "Hospital"},"dv.permissao", "perm.unizk" },
	["Medico"] = { _config = { gtype = "org", salario = 17000, ptr = true, orgName = "Hospital"},"dv.permissao", "perm.unizk" },
	["Enfermeiro"] = { _config = { gtype = "org", salario = 15000, ptr = true, orgName = "Hospital"}, "perm.unizk" },
	["Socorrista"] = { _config = { gtype = "org", salario = 10000, ptr = true, orgName = "Hospital"}, "perm.unizk" },
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- JUDICIARIO
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	--["Ministro"] = { _config = { gtype = "org", salario = 20000, ptr = true, orgName = "Judiciario"}, "perm.judiciario" },
	["Juiz"] = { _config = { gtype = "org", salario = 10000, ptr = nil, orgName = "Judiciario"}, "perm.judiciario" },
	--["Desembargador"] = { _config = { gtype = "org", salario = 10000, orgName = "Judiciario"}, "perm.judiciario" },
	["Promotor"] = { _config = { gtype = "org", salario = 8000, ptr = nil, orgName = "Judiciario"}, "perm.judiciario" },
	["Advogado"] = { _config = { gtype = "org", salario = 5000, ptr = nil, orgName = "Judiciario"}, "perm.judiciario" },
	
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  /groupadd 1 "lider bloods"
-- ARMAS
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	--MAFIA01--
	["Lider [MAFIA01]"] = { _config = { gtype = "org", salario = nil, ptr = nil, orgName = "Mafia01", orgType = "fArmas"}, "perm.mafia01", "perm.lidermafia01", "perm.arma", "perm.ilegal", "perm.baumafia01"},
	["Sub-Lider [MAFIA01]"] = { _config = { gtype = "org", salario = nil, ptr = nil, orgName = "Mafia01", orgType = "fArmas" }, "perm.lidermafia01", "perm.mafia01", "perm.arma", "perm.ilegal", "perm.baumafia01"},
	["Gerente [MAFIA01]"] = { _config = { gtype = "org", salario = nil, ptr = nil, orgName = "Mafia01", orgType = "fArmas" }, "perm.mafia01", "perm.arma", "perm.ilegal", "perm.baumafia01"},
	["Membro [MAFIA01]"] = { _config = { gtype = "org", salario = nil, ptr = nil, orgName = "Mafia01", orgType = "fArmas" }, "perm.mafia01", "perm.arma", "perm.ilegal", "perm.baumafia01"},
	["Novato [MAFIA01]"] = { _config = { gtype = "org", salario = nil, ptr = nil, orgName = "Mafia01", orgType = "fArmas" }, "perm.mafia01", "perm.arma", "perm.ilegal"},

	--MAFIA02--
	["Lider [MAFIA02]"] = { _config = { gtype = "org", salario = nil, ptr = nil, orgName = "Mafia02", orgType = "fArmas"}, "perm.mafia02", "perm.lidermafia02", "perm.arma", "perm.ilegal", "perm.baumafia02"},
	["Sub-Lider [MAFIA02]"] = { _config = { gtype = "org", salario = nil, ptr = nil, orgName = "Mafia02", orgType = "fArmas" }, "perm.lidermafia02", "perm.mafia02", "perm.arma", "perm.ilegal", "perm.baumafia02"},
	["Gerente [MAFIA02]"] = { _config = { gtype = "org", salario = nil, ptr = nil, orgName = "Mafia02", orgType = "fArmas" }, "perm.mafia02", "perm.arma", "perm.ilegal", "perm.baumafia02"},
	["Membro [MAFIA02]"] = { _config = { gtype = "org", salario = nil, ptr = nil, orgName = "Mafia02", orgType = "fArmas" }, "perm.mafia02", "perm.arma", "perm.ilegal", "perm.baumafia02"},
	["Novato [MAFIA02]"] = { _config = { gtype = "org", salario = nil, ptr = nil, orgName = "Mafia02", orgType = "fArmas" }, "perm.mafia02", "perm.arma", "perm.ilegal"},

	--MAFIA03--
	["Lider [MAFIA03]"] = { _config = { gtype = "org", salario = nil, ptr = nil, orgName = "Mafia03", orgType = "fArmas"}, "perm.mafia03", "perm.gerentemafia03", "perm.lidermafia03", "perm.arma", "perm.ilegal", "perm.baumafia03"},
	["Sub-Lider [MAFIA03]"] = { _config = { gtype = "org", salario = nil, ptr = nil, orgName = "Mafia03", orgType = "fArmas" }, "perm.gerentemafia03", "perm.lidermafia03", "perm.mafia03", "perm.arma", "perm.ilegal", "perm.baumafia03"},
	["Gerente [MAFIA03]"] = { _config = { gtype = "org", salario = nil, ptr = nil, orgName = "Mafia03", orgType = "fArmas" }, "perm.gerentemafia03", "perm.mafia03", "perm.arma", "perm.ilegal", "perm.baumafia03"},
	["Membro [MAFIA03]"] = { _config = { gtype = "org", salario = nil, ptr = nil, orgName = "Mafia03", orgType = "fArmas" }, "perm.mafia03", "perm.arma", "perm.ilegal", "perm.baumafia03"},
	["Novato [MAFIA03]"] = { _config = { gtype = "org", salario = nil, ptr = nil, orgName = "Mafia03", orgType = "fArmas" }, "perm.mafia03", "perm.arma", "perm.ilegal"},

	--EGITO--
	["Lider [EGITO]"] = { _config = { gtype = "org", salario = nil, ptr = nil, orgName = "Egito", orgType = "fArmas"}, "perm.lideregito", "perm.egito", "perm.arma", "perm.ilegal", "perm.bauegito"},
	["Sub-Lider [EGITO]"] = { _config = { gtype = "org", salario = nil, ptr = nil, orgName = "Egito", orgType = "fArmas"}, "perm.lideregito", "perm.egito", "perm.arma", "perm.ilegal", "perm.bauegito"},
	["Gerente [EGITO]"] = { _config = { gtype = "org", salario = nil, ptr = nil, orgName = "Egito", orgType = "fArmas"}, "perm.egito", "perm.arma", "perm.ilegal", "perm.bauegito"},
	["Membro [EGITO]"] = { _config = { gtype = "org", salario = nil, ptr = nil, orgName = "Egito", orgType = "fArmas"}, "perm.egito", "perm.arma", "perm.ilegal", "perm.bauegito"},
	["Novato [EGITO]"] = { _config = { gtype = "org", salario = nil, ptr = nil, orgName = "Egito", orgType = "fArmas"}, "perm.egito", "perm.arma", "perm.ilegal"},

	--FRANCA--
	["Lider [FRANCA]"] = { _config = { gtype = "org", salario = 6000, ptr = nil, orgName = "Franca", orgType = "fArmas"}, "perm.franca", "perm.liderfranca", "perm.arma", "perm.ilegal", "perm.baufranca"},
	["Sub-Lider [FRANCA]"] = { _config = { gtype = "org", salario = 6000, ptr = nil, orgName = "Franca", orgType = "fArmas"}, "perm.liderfranca", "perm.franca", "perm.arma", "perm.ilegal", "perm.baufranca"},
	["Gerente [FRANCA]"] = { _config = { gtype = "org", salario = 6000, ptr = nil, orgName = "Franca", orgType = "fArmas"}, "perm.franca", "perm.arma", "perm.ilegal", "perm.baufranca"},
	["Membro [FRANCA]"] = { _config = { gtype = "org", salario = 6000, ptr = nil, orgName = "Franca", orgType = "fArmas"}, "perm.franca", "perm.arma", "perm.ilegal", "perm.baufranca"},
	["Novato [FRANCA]"] = { _config = { gtype = "org", salario = 6000, ptr = nil, orgName = "Franca", orgType = "fArmas"}, "perm.franca", "perm.arma", "perm.ilegal"},
	
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- MUNIÇÃO
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	--YAKUZA--
	["Lider [YAKUZA]"] = { _config = { gtype = "org", salario = nil, ptr = nil, orgName = "Yakuza", orgType = "fMunicao"}, "perm.yakuza", "perm.lideryakuza", "perm.muni", "perm.ilegal", "perm.bauyakuza"},
	["Sub-Lider [YAKUZA]"] = { _config = { gtype = "org", salario = nil, ptr = nil, orgName = "Yakuza", orgType = "fMunicao"}, "perm.lideryakuza", "perm.yakuza", "perm.muni", "perm.ilegal", "perm.bauyakuza"},
	["Gerente [YAKUZA]"] = { _config = { gtype = "org", salario = nil, ptr = nil, orgName = "Yakuza", orgType = "fMunicao"}, "perm.yakuza", "perm.muni", "perm.ilegal", "perm.bauyakuza"},
	["Membro [YAKUZA]"] = { _config = { gtype = "org", salario = nil, ptr = nil, orgName = "Yakuza", orgType = "fMunicao"}, "perm.yakuza", "perm.muni", "perm.ilegal", "perm.bauyakuza"},
	["Novato [YAKUZA]"] = { _config = { gtype = "org", salario = nil, ptr = nil, orgName = "Yakuza", orgType = "fMunicao"}, "perm.yakuza", "perm.muni", "perm.ilegal"},

	--CHINA--
	["Lider [CHINA]"] = { _config = { gtype = "org", salario = nil, ptr = nil, orgName = "China", orgType = "fMunicao"}, "perm.liderchina", "perm.china", "perm.muni", "perm.ilegal", "perm.bauchina"},
	["Sub-Lider [CHINA]"] = { _config = { gtype = "org", salario = nil, ptr = nil, orgName = "China", orgType = "fMunicao"}, "perm.liderchina", "perm.china", "perm.muni", "perm.ilegal", "perm.bauchina"},
	["Gerente [CHINA]"] = { _config = { gtype = "org", salario = nil, ptr = nil, orgName = "China", orgType = "fMunicao"}, "perm.china", "perm.muni", "perm.ilegal", "perm.bauchina"},
	["Membro [CHINA]"] = { _config = { gtype = "org", salario = nil, ptr = nil, orgName = "China", orgType = "fMunicao"}, "perm.china", "perm.muni", "perm.ilegal", "perm.bauchina"},
	["Novato [CHINA]"] = { _config = { gtype = "org", salario = nil, ptr = nil, orgName = "China", orgType = "fMunicao"}, "perm.china", "perm.muni", "perm.ilegal"},

	--BRATVA--
	["Lider [BRATVA]"] = { _config = { gtype = "org", salario = nil, ptr = nil, orgName = "Bratva", orgType = "fMunicao"}, "perm.liderbratva", "perm.bratva", "perm.muni", "perm.ilegal", "perm.baubratva"},
	["Sub-Lider [BRATVA]"] = { _config = { gtype = "org", salario = nil, ptr = nil, orgName = "Bratva", orgType = "fMunicao"}, "perm.liderbratva", "perm.bratva", "perm.muni", "perm.ilegal", "perm.baubratva"},
	["Gerente [BRATVA]"] = { _config = { gtype = "org", salario = nil, ptr = nil, orgName = "Bratva", orgType = "fMunicao"}, "perm.bratva", "perm.muni", "perm.ilegal", "perm.baubratva"},
	["Membro [BRATVA]"] = { _config = { gtype = "org", salario = nil, ptr = nil, orgName = "Bratva", orgType = "fMunicao"}, "perm.bratva", "perm.muni", "perm.ilegal", "perm.baubratva"},
	["Novato [BRATVA]"] = { _config = { gtype = "org", salario = nil, ptr = nil, orgName = "Bratva", orgType = "fMunicao"}, "perm.bratva", "perm.muni", "perm.ilegal"},

	--CARTEL--
	["Lider [CARTEL]"] = { _config = { gtype = "org", salario = nil, ptr = nil, orgName = "Cartel", orgType = "fMunicao"}, "perm.cartel", "perm.lidercartel", "perm.muni", "perm.ilegal", "perm.baucartel"},
	["Sub-Lider [CARTEL]"] = { _config = { gtype = "org", salario = nil, ptr = nil, orgName = "Cartel", orgType = "fMunicao"}, "perm.lidercartel", "perm.cartel", "perm.muni", "perm.ilegal", "perm.baucartel"},
	["Gerente [CARTEL]"] = { _config = { gtype = "org", salario = nil, ptr = nil, orgName = "Cartel", orgType = "fMunicao"}, "perm.cartel", "perm.muni", "perm.ilegal", "perm.baucartel"},
	["Membro [CARTEL]"] = { _config = { gtype = "org", salario = nil, ptr = nil, orgName = "Cartel", orgType = "fMunicao"}, "perm.cartel", "perm.muni", "perm.ilegal", "perm.baucartel"},
	["Novato [CARTEL]"] = { _config = { gtype = "org", salario = nil, ptr = nil, orgName = "Cartel", orgType = "fMunicao"}, "perm.cartel", "perm.muni", "perm.ilegal"},

	--TRIADE--
	["Lider [TRIADE]"] = { _config = { gtype = "org", salario = 4000, ptr = nil, orgName = "Triade", orgType = "fMunicao"}, "perm.triade", "perm.lidertriade", "perm.muni", "perm.ilegal", "perm.bautriade"},
	["Sub-Lider [TRIADE]"] = { _config = { gtype = "org", salario = 4000, ptr = nil, orgName = "Triade", orgType = "fMunicao"}, "perm.lidertriade", "perm.triade", "perm.muni", "perm.ilegal", "perm.bautriade"},
	["Gerente [TRIADE]"] = { _config = { gtype = "org", salario = 4000, ptr = nil, orgName = "Triade", orgType = "fMunicao"}, "perm.triade", "perm.muni", "perm.ilegal", "perm.bautriade"},
	["Membro [TRIADE]"] = { _config = { gtype = "org", salario = 4000, ptr = nil, orgName = "Triade", orgType = "fMunicao"}, "perm.triade", "perm.muni", "perm.ilegal", "perm.bautriade"},
	["Novato [TRIADE]"] = { _config = { gtype = "org", salario = 4000, ptr = nil, orgName = "Triade", orgType = "fMunicao"}, "perm.triade", "perm.muni", "perm.ilegal"},
	
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- DESMANCHE
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	--FURIOUS--
	["Lider [FURIOUS]"] = { _config = { gtype = "org", salario = nil, ptr = nil, orgName = "Furious", orgType = "fDesmanche"}, "perm.furious", "perm.liderfurious", "perm.gerentefurious", "perm.desmanche", "perm.ilegal", "perm.baufurious"},
	["Sub-Lider [FURIOUS]"] = { _config = { gtype = "org", salario = nil, ptr = nil, orgName = "Furious", orgType = "fDesmanche"}, "perm.liderfurious", "perm.gerentefurious", "perm.furious", "perm.desmanche", "perm.ilegal", "perm.baufurious"},
	["Gerente [FURIOUS]"] = { _config = { gtype = "org", salario = nil, ptr = nil, orgName = "Furious", orgType = "fDesmanche"}, "perm.gerentefurious", "perm.furious", "perm.desmanche", "perm.ilegal", "perm.baufurious"},
	["Membro [FURIOUS]"] = { _config = { gtype = "org", salario = nil, ptr = nil, orgName = "Furious", orgType = "fDesmanche"}, "perm.furious", "perm.desmanche", "perm.ilegal", "perm.baufurious"},
	["Novato [FURIOUS]"] = { _config = { gtype = "org", salario = nil, ptr = nil, orgName = "Furious", orgType = "fDesmanche"}, "perm.furious", "perm.desmanche", "perm.ilegal"},

	--ELEMENTS--
	["Lider [ELEMENTS]"] = { _config = { gtype = "org", salario = nil, ptr = nil, orgName = "Elements", orgType = "fDesmanche"}, "perm.elements", "perm.desmanche", "perm.liderelements", "perm.ilegal", "perm.bauelements"},
	["Sub-Lider [ELEMENTS]"] = { _config = { gtype = "org", salario = nil, ptr = nil, orgName = "Elements", orgType = "fDesmanche"}, "perm.liderelements", "perm.elements", "perm.desmanche", "perm.ilegal", "perm.bauelements"},
	["Gerente [ELEMENTS]"] = { _config = { gtype = "org", salario = nil, ptr = nil, orgName = "Elements", orgType = "fDesmanche"}, "perm.elements", "perm.desmanche", "perm.ilegal", "perm.bauelements"},
	["Membro [ELEMENTS]"] = { _config = { gtype = "org", salario = nil, ptr = nil, orgName = "Elements", orgType = "fDesmanche"}, "perm.elements", "perm.desmanche", "perm.ilegal", "perm.bauelements"},
	["Novato [ELEMENTS]"] = { _config = { gtype = "org", salario = nil, ptr = nil, orgName = "Elements", orgType = "fDesmanche"}, "perm.elements", "perm.desmanche", "perm.ilegal"},

	--TURQUIA--
	["Lider [TURQUIA]"] = { _config = { gtype = "org", salario = 4000, ptr = nil, orgName = "Turquia", orgType = "fDesmanche"}, "perm.liderturquia", "perm.turquia", "perm.desmanche", "perm.ilegal", "perm.bauturquia", "perm.bauliderturquia"},
	["Sub-Lider [TURQUIA]"] = { _config = { gtype = "org", salario = 4000, ptr = nil, orgName = "Turquia", orgType = "fDesmanche"}, "perm.liderturquia", "perm.turquia", "perm.desmanche", "perm.ilegal", "perm.bauturquia", "perm.bauliderturquia"},
	["Gerente [TURQUIA]"] = { _config = { gtype = "org", salario = 4000, ptr = nil, orgName = "Turquia", orgType = "fDesmanche"}, "perm.turquia", "perm.desmanche", "perm.ilegal", "perm.bauturquia", "perm.bauliderturquia"},
	["Membro [TURQUIA]"] = { _config = { gtype = "org", salario = 4000, ptr = nil, orgName = "Turquia", orgType = "fDesmanche"}, "perm.turquia", "perm.desmanche", "perm.ilegal", "perm.bauturquia"},
	["Novato [TURQUIA]"] = { _config = { gtype = "org", salario = 4000, ptr = nil, orgName = "Turquia", orgType = "fDesmanche"}, "perm.turquia", "perm.desmanche", "perm.ilegal"},

	--GRECIA--
	["Lider [GRECIA]"] = { _config = { gtype = "org", salario = nil, ptr = nil, orgName = "Grecia", orgType = "fDesmanche"}, "perm.lidergrecia", "perm.grecia", "perm.liderbaugrecia", "perm.desmanche", "perm.ilegal", "perm.baugrecia"},
	["Sub-Lider [GRECIA]"] = { _config = { gtype = "org", salario = nil, ptr = nil, orgName = "Grecia", orgType = "fDesmanche"}, "perm.lidergrecia", "perm.grecia","perm.liderbaugrecia",  "perm.desmanche", "perm.ilegal", "perm.baugrecia"},
	["Gerente [GRECIA]"] = { _config = { gtype = "org", salario = nil, ptr = nil, orgName = "Grecia", orgType = "fDesmanche"}, "perm.grecia", "perm.desmanche","perm.liderbaugrecia",  "perm.ilegal", "perm.baugrecia"},
	["Membro [GRECIA]"] = { _config = { gtype = "org", salario = nil, ptr = nil, orgName = "Grecia", orgType = "fDesmanche"}, "perm.grecia", "perm.desmanche", "perm.ilegal", "perm.baugrecia"},
	["Novato [GRECIA]"] = { _config = { gtype = "org", salario = nil, ptr = nil, orgName = "Grecia", orgType = "fDesmanche"}, "perm.grecia", "perm.desmanche", "perm.ilegal"},

	--ROXOS--
	["Lider [ROXOS]"] = { _config = { gtype = "org", salario = nil, ptr = nil, orgName = "Roxos", orgType = "fDesmanche"}, "perm.liderroxos", "perm.roxos", "perm.desmanche", "perm.ilegal", "perm.bauroxos"},
	["Sub-Lider [ROXOS]"] = { _config = { gtype = "org", salario = nil, ptr = nil, orgName = "Roxos", orgType = "fDesmanche"}, "perm.liderroxos", "perm.roxos", "perm.desmanche", "perm.ilegal", "perm.bauroxos"},
	["Gerente [ROXOS]"] = { _config = { gtype = "org", salario = nil, ptr = nil, orgName = "Roxos", orgType = "fDesmanche"}, "perm.roxos", "perm.desmanche", "perm.ilegal", "perm.bauroxos"},
	["Membro [ROXOS]"] = { _config = { gtype = "org", salario = nil, ptr = nil, orgName = "Roxos", orgType = "fDesmanche"}, "perm.roxos", "perm.desmanche", "perm.ilegal", "perm.bauroxos"},
	["Novato [ROXOS]"] = { _config = { gtype = "org", salario = nil, ptr = nil, orgName = "Roxos", orgType = "fDesmanche"}, "perm.roxos", "perm.desmanche", "perm.ilegal"},

	

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- LAVAGEM
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	--VANILLA--
	["Lider [VANILLA]"] = { _config = { gtype = "org", salario = nil, ptr = nil, orgName = "Vanilla", orgType = "fLavagem"}, "perm.lidervanilla", "perm.vanilla", "perm.lavagem", "perm.ilegal", "perm.bauvanilla"},
	["Sub-Lider [VANILLA]"] = { _config = { gtype = "org", salario = nil, ptr = nil, orgName = "Vanilla",orgType = "fLavagem"}, "perm.lidervanilla", "perm.vanilla", "perm.lavagem", "perm.ilegal", "perm.bauvanilla"},	
	["Gerente [VANILLA]"] = { _config = { gtype = "org", salario = nil, ptr = nil, orgName = "Vanilla",orgType = "fLavagem"}, "perm.vanilla", "perm.lavagem", "perm.ilegal", "perm.bauvanilla"},
	["Membro [VANILLA]"] = { _config = { gtype = "org", salario = nil, ptr = nil, orgName = "Vanilla",orgType = "fLavagem"}, "perm.vanilla", "perm.lavagem", "perm.ilegal", "perm.bauvanilla"},
	["Novato [VANILLA]"] = { _config = { gtype = "org", salario = nil, ptr = nil, orgName = "Vanilla",orgType = "fLavagem"}, "perm.vanilla", "perm.lavagem", "perm.ilegal"},

	--BAHAMAS--
	["Lider [BAHAMAS]"] = { _config = { gtype = "org", salario = nil, ptr = nil, orgName = "Bahamas", orgType = "fLavagem"}, "perm.liderbahamas", "perm.bahamas", "perm.lavagem", "perm.ilegal", "perm.baubahamas"},
	["Sub-Lider [BAHAMAS]"] = { _config = { gtype = "org", salario = nil, ptr = nil, orgName = "Bahamas", orgType = "fLavagem"}, "perm.liderbahamas", "perm.bahamas", "perm.lavagem", "perm.ilegal", "perm.baubahamas"},
	["Gerente [BAHAMAS]"] = { _config = { gtype = "org", salario = nil, ptr = nil, orgName = "Bahamas", orgType = "fLavagem"}, "perm.bahamas", "perm.lavagem", "perm.ilegal", "perm.baubahamas"},
	["Membro [BAHAMAS]"] = { _config = { gtype = "org", salario = nil, ptr = nil, orgName = "Bahamas", orgType = "fLavagem"}, "perm.bahamas", "perm.lavagem", "perm.ilegal", "perm.baubahamas"},
	["Novato [BAHAMAS]"] = { _config = { gtype = "org", salario = nil, ptr = nil, orgName = "Bahamas", orgType = "fLavagem"}, "perm.bahamas", "perm.lavagem", "perm.ilegal"},

	--CASSINO--
	["Lider [CASSINO]"] = { _config = { gtype = "org", salario = nil, ptr = nil, orgName = "Cassino", orgType = "fLavagem"}, "perm.cassino", "perm.lidercassino", "perm.lavagem", "perm.ilegal", "perm.baucassino"},
	["Sub-Lider [CASSINO]"] = { _config = { gtype = "org", salario = nil, ptr = nil, orgName = "Cassino", orgType = "fLavagem"}, "perm.lidercassino", "perm.cassino", "perm.lavagem", "perm.ilegal", "perm.baucassino"},
	["Gerente [CASSINO]"] = { _config = { gtype = "org", salario = nil, ptr = nil, orgName = "Cassino", orgType = "fLavagem"}, "perm.cassino", "perm.lavagem", "perm.ilegal", "perm.baucassino"},
	["Membro [CASSINO]"] = { _config = { gtype = "org", salario = nil, ptr = nil, orgName = "Cassino", orgType = "fLavagem"}, "perm.cassino", "perm.lavagem", "perm.ilegal", "perm.baucassino"},
	["Novato [CASSINO]"] = { _config = { gtype = "org", salario = nil, ptr = nil, orgName = "Cassino", orgType = "fLavagem"}, "perm.cassino", "perm.lavagem", "perm.ilegal"},

	--GALAXY--
	["Lider [GALAXY]"] = { _config = { gtype = "org", salario = nil, ptr = nil, orgName = "Galaxy", orgType = "fLavagem"}, "perm.galaxy", "perm.lidergalaxy", "perm.lavagem", "perm.ilegal", "perm.baugalaxy"},
	["Sub-Lider [GALAXY]"] = { _config = { gtype = "org", salario = nil, ptr = nil, orgName = "Galaxy", orgType = "fLavagem"}, "perm.lidergalaxy", "perm.galaxy", "perm.lavagem", "perm.ilegal", "perm.baugalaxy"},
	["Gerente [GALAXY]"] = { _config = { gtype = "org", salario = nil, ptr = nil, orgName = "Galaxy", orgType = "fLavagem"}, "perm.galaxy", "perm.lavagem", "perm.ilegal", "perm.baugalaxy"},
	["Membro [GALAXY]"] = { _config = { gtype = "org", salario = nil, ptr = nil, orgName = "Galaxy", orgType = "fLavagem"}, "perm.galaxy", "perm.lavagem", "perm.ilegal", "perm.baugalaxy"},
	["Novato [GALAXY]"] = { _config = { gtype = "org", salario = nil, ptr = nil, orgName = "Galaxy", orgType = "fLavagem"}, "perm.galaxy", "perm.lavagem", "perm.ilegal"},

	--ANONYMOUS--
	["Lider [ANONYMOUS]"] = { _config = { gtype = "org", salario = 6000, ptr = nil, orgName = "Anonymous", orgType = "fArmas"}, "perm.gerenteanonymous", "perm.anonymous", "perm.lideranonymous", "perm.lavagem", "perm.ilegal", "perm.bauanonymous", "perm.baulideranonymous"},
	["Sub-Lider [ANONYMOUS]"] = { _config = { gtype = "org", salario = 6000, ptr = nil, orgName = "Anonymous", orgType = "fArmas"}, "perm.gerenteanonymous","perm.lideranonymous", "perm.anonymous", "perm.lavagem", "perm.ilegal", "perm.bauanonymous", "perm.baulideranonymous"},
	["Gerente [ANONYMOUS]"] = { _config = { gtype = "org", salario = 6000, ptr = nil, orgName = "Anonymous", orgType = "fArmas"}, "perm.gerenteanonymous","perm.anonymous", "perm.lavagem", "perm.ilegal", "perm.bauanonymous", "perm.baulideranonymous"},
	["Membro [ANONYMOUS]"] = { _config = { gtype = "org", salario = 6000, ptr = nil, orgName = "Anonymous", orgType = "fArmas"}, "perm.anonymous", "perm.lavagem", "perm.ilegal", "perm.bauanonymous"},
	["Novato [ANONYMOUS]"] = { _config = { gtype = "org", salario = 6000, ptr = nil, orgName = "Anonymous", orgType = "fArmas"}, "perm.anonymous", "perm.lavagem", "perm.ilegal"},

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- DROGAS
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

	--NIGERIA--
	["Lider [NIGERIA]"] = { _config = { gtype = "org", salario = nil, ptr = nil, orgName = "Nigeria", orgType = "Drogas"}, "perm.nigeria", "perm.lidernigeria", "perm.maconha", "perm.ilegal", "perm.baunigeria"},
	["Sub-Lider [NIGERIA]"] = { _config = { gtype = "org", salario = nil, ptr = nil, orgName = "Nigeria", orgType = "Drogas"}, "perm.lidernigeria", "perm.nigeria", "perm.maconha", "perm.ilegal", "perm.baunigeria"},
	["Gerente [NIGERIA]"] = { _config = { gtype = "org", salario = nil, ptr = nil, orgName = "Nigeria", orgType = "Drogas"}, "perm.nigeria", "perm.maconha", "perm.ilegal", "perm.baunigeria"},
	["Membro [NIGERIA]"] = { _config = { gtype = "org", salario = nil, ptr = nil, orgName = "Nigeria", orgType = "Drogas"}, "perm.nigeria", "perm.maconha", "perm.ilegal", "perm.baunigeria"},
	["Novato [NIGERIA]"] = { _config = { gtype = "org", salario = nil, ptr = nil, orgName = "Nigeria", orgType = "Drogas"}, "perm.nigeria", "perm.maconha", "perm.ilegal"},
	
	--ESCOCIA--
	["Lider [ESCOCIA]"] = { _config = { gtype = "org", salario = nil, ptr = nil, orgName = "Escocia", orgType = "Drogas"}, "perm.escocia", "perm.liderescocia", "perm.cocaina", "perm.ilegal", "perm.bauescocia"},
	["Sub-Lider [ESCOCIA]"] = { _config = { gtype = "org", salario = nil, ptr = nil, orgName = "Escocia", orgType = "Drogas"}, "perm.liderescocia", "perm.escocia", "perm.cocaina", "perm.ilegal", "perm.bauescocia"},
	["Gerente [ESCOCIA]"] = { _config = { gtype = "org", salario = nil, ptr = nil, orgName = "Escocia", orgType = "Drogas"}, "perm.escocia", "perm.cocaina", "perm.ilegal", "perm.bauescocia"},
	["Membro [ESCOCIA]"] = { _config = { gtype = "org", salario = nil, ptr = nil, orgName = "Escocia", orgType = "Drogas"}, "perm.escocia", "perm.cocaina", "perm.ilegal", "perm.bauescocia"},
	["Novato [ESCOCIA]"] = { _config = { gtype = "org", salario = nil, ptr = nil, orgName = "Escocia", orgType = "Drogas"}, "perm.escocia", "perm.cocaina", "perm.ilegal"},

	--SUECIA--
	["Lider [SUECIA]"] = { _config = { gtype = "org", salario = nil, ptr = nil, orgName = "Suecia", orgType = "Drogas"}, "perm.suecia", "perm.lidersuecia", "perm.drogas", "perm.balinha", "perm.ilegal", "perm.bausuecia"},
	["Sub-Lider [SUECIA]"] = { _config = { gtype = "org", salario = nil, ptr = nil, orgName = "Suecia", orgType = "Drogas"}, "perm.lidersuecia", "perm.suecia", "perm.drogas", "perm.balinha", "perm.ilegal", "perm.bausuecia"},
	["Gerente [SUECIA]"] = { _config = { gtype = "org", salario = nil, ptr = nil, orgName = "Suecia", orgType = "Drogas"}, "perm.suecia", "perm.drogas", "perm.balinha", "perm.ilegal", "perm.bausuecia"},
	["Membro [SUECIA]"] = { _config = { gtype = "org", salario = nil, ptr = nil, orgName = "Suecia", orgType = "Drogas"}, "perm.suecia", "perm.drogas", "perm.balinha", "perm.ilegal", "perm.bausuecia"},
	["Novato [SUECIA]"] = { _config = { gtype = "org", salario = nil, ptr = nil, orgName = "Suecia", orgType = "Drogas"}, "perm.suecia", "perm.drogas", "perm.balinha", "perm.ilegal"},

	--BLOODS--
	["Lider [BLOODS]"] = { _config = { gtype = "org", salario = nil, ptr = nil, orgName = "Bloods", orgType = "Drogas"}, "perm.bloods", "perm.liderbloods", "perm.drogas", "perm.heroina", "perm.ilegal", "perm.baubloods"},
	["Sub-Lider [BLOODS]"] = { _config = { gtype = "org", salario = nil, ptr = nil, orgName = "Bloods", orgType = "Drogas"}, "perm.liderbloods", "perm.bloods", "perm.drogas", "perm.ilegal", "perm.heroina", "perm.baubloods"},
	["Gerente [BLOODS]"] = { _config = { gtype = "org", salario = nil, ptr = nil, orgName = "Bloods", orgType = "Drogas"}, "perm.bloods", "perm.drogas", "perm.ilegal", "perm.heroina", "perm.baubloods"},
	["Membro [BLOODS]"] = { _config = { gtype = "org", salario = nil, ptr = nil, orgName = "Bloods", orgType = "Drogas"}, "perm.bloods", "perm.drogas", "perm.ilegal", "perm.heroina", "perm.baubloods"},
	["Novato [BLOODS]"] = { _config = { gtype = "org", salario = nil, ptr = nil, orgName = "Bloods", orgType = "Drogas"}, "perm.bloods", "perm.drogas", "perm.heroina", "perm.ilegal"},
 
	--CRIPS--
	["Lider [CRIPS]"] = { _config = { gtype = "org", salario = nil, ptr = nil, orgName = "Crips", orgType = "Drogas"}, "perm.crips", "perm.lidercrips", "perm.drogas", "perm.metanfetamina", "perm.ilegal", "perm.baucrips"},
	["Sub-Lider [CRIPS]"] = { _config = { gtype = "org", salario = nil, ptr = nil, orgName = "Crips", orgType = "Drogas"}, "perm.lidercrips", "perm.crips", "perm.drogas", "perm.ilegal", "perm.metanfetamina", "perm.baucrips"},
	["Gerente [CRIPS]"] = { _config = { gtype = "org", salario = nil, ptr = nil, orgName = "Crips", orgType = "Drogas"}, "perm.crips", "perm.drogas", "perm.ilegal", "perm.metanfetamina", "perm.baucrips"},
	["Membro [CRIPS]"] = { _config = { gtype = "org", salario = nil, ptr = nil, orgName = "Crips", orgType = "Drogas"}, "perm.crips", "perm.drogas", "perm.ilegal", "perm.metanfetamina", "perm.baucrips"},
	["Novato [CRIPS]"] = { _config = { gtype = "org", salario = nil, ptr = nil, orgName = "Crips", orgType = "Drogas"}, "perm.crips", "perm.drogas", "perm.metanfetamina", "perm.ilegal"},

	--ISRAEL--
	["Lider [ISRAEL]"] = { _config = { gtype = "org", salario = nil, ptr = nil, orgName = "Israel", orgType = "Drogas"}, "perm.israel", "perm.liderisrael", "perm.opio", "perm.ilegal", "perm.bauisrael", "perm.liderbauisrael" },
	["Sub-Lider [ISRAEL]"] = { _config = { gtype = "org", salario = nil, ptr = nil, orgName = "Israel", orgType = "Drogas"}, "perm.liderisrael", "perm.israel", "perm.opio", "perm.ilegal", "perm.bauisrael", "perm.liderbauisrael" },
	["Gerente [ISRAEL]"] = { _config = { gtype = "org", salario = nil, ptr = nil, orgName = "Israel", orgType = "Drogas"}, "perm.israel", "perm.opio", "perm.ilegal", "perm.bauisrael", "perm.liderbauisrael" },
	["Membro [ISRAEL]"] = { _config = { gtype = "org", salario = nil, ptr = nil, orgName = "Israel", orgType = "Drogas"}, "perm.israel", "perm.opio", "perm.ilegal", "perm.bauisrael"},
	["Novato [ISRAEL]"] = { _config = { gtype = "org", salario = nil, ptr = nil, orgName = "Israel", orgType = "Drogas"}, "perm.israel", "perm.opio", "perm.ilegal"},

	--COLOMBIA--
	["Lider [COLOMBIA]"] = { _config = { gtype = "org", salario = nil, ptr = nil, orgName = "Colombia", orgType = "Drogas"}, "perm.colombia", "perm.lidercolombia", "perm.drogas", "perm.haxixe", "perm.ilegal", "perm.baucolombia", "perm.baulidercolombia"},
	["Sub-Lider [COLOMBIA]"] = { _config = { gtype = "org", salario = nil, ptr = nil, orgName = "Colombia", orgType = "Drogas"}, "perm.lidercolombia", "perm.colombia", "perm.drogas", "perm.haxixe", "perm.baucolombia", "perm.baulidercolombia"},
	["Gerente [COLOMBIA]"] = { _config = { gtype = "org", salario = nil, ptr = nil, orgName = "Colombia", orgType = "Drogas"}, "perm.colombia", "perm.drogas", "perm.ilegal", "perm.haxixe", "perm.baucolombia", "perm.baulidercolombia"},
	["Membro [COLOMBIA]"] = { _config = { gtype = "org", salario = nil, ptr = nil, orgName = "Colombia", orgType = "Drogas"}, "perm.colombia", "perm.drogas", "perm.ilegal", "perm.haxixe", "perm.baucolombia"},
	["Novato [COLOMBIA]"] = { _config = { gtype = "org", salario = nil, ptr = nil, orgName = "Colombia", orgType = "Drogas"}, "perm.colombia", "perm.drogas", "perm.haxixe", "perm.ilegal"}, 

	--COSTA RICA-- 
	["Lider [COSTA RICA]"] = { _config = { gtype = "org", salario = nil, ptr = nil, orgName = "CostaRica", orgType = "Drogas"}, "perm.costarica", "perm.lidercostarica", "perm.drogas", "perm.maconha", "perm.ilegal", "perm.baucostarica", "perm.baulidercostarica"},
	["Sub-Lider [COSTA RICA]"] = { _config = { gtype = "org", salario = nil, ptr = nil, orgName = "CostaRica", orgType = "Drogas"}, "perm.lidercostarica", "perm.costarica", "perm.drogas", "perm.ilegal", "perm.maconha", "perm.baucostarica", "perm.baulidercostarica"},
	["Gerente [COSTA RICA]"] = { _config = { gtype = "org", salario = nil, ptr = nil, orgName = "CostaRica", orgType = "Drogas"}, "perm.costarica", "perm.drogas", "perm.ilegal", "perm.maconha", "perm.baucostarica", "perm.baulidercostarica"},
	["Membro [COSTA RICA]"] = { _config = { gtype = "org", salario = nil, ptr = nil, orgName = "CostaRica", orgType = "Drogas"}, "perm.costarica", "perm.drogas", "perm.ilegal", "perm.maconha", "perm.baucostarica"},
	["Novato [COSTA RICA]"] = { _config = { gtype = "org", salario = nil, ptr = nil, orgName = "CostaRica", orgType = "Drogas"}, "perm.costarica", "perm.drogas", "perm.maconha", "perm.ilegal"},

	--MEDELIN--
	["Lider [MEDELIN]"] = { _config = { gtype = "org", salario = nil, ptr = nil, orgName = "Medelin", orgType = "Drogas"}, "perm.medelin", "perm.lidermedelin", "perm.drogas", "perm.cocaina", "perm.ilegal", "perm.baumedelin"},
	["Sub-Lider [MEDELIN]"] = { _config = { gtype = "org", salario = nil, ptr = nil, orgName = "Medelin", orgType = "Drogas"}, "perm.lidermedelin", "perm.medelin", "perm.drogas", "perm.ilegal", "perm.cocaina", "perm.baumedelin"},
	["Gerente [MEDELIN]"] = { _config = { gtype = "org", salario = nil, ptr = nil, orgName = "Medelin", orgType = "Drogas"}, "perm.medelin", "perm.drogas", "perm.ilegal", "perm.cocaina", "perm.baumedelin"},
	["Membro [MEDELIN]"] = { _config = { gtype = "org", salario = nil, ptr = nil, orgName = "Medelin", orgType = "Drogas"}, "perm.medelin", "perm.drogas", "perm.ilegal", "perm.cocaina", "perm.baumedelin"},
	["Novato [MEDELIN]"] = { _config = { gtype = "org", salario = nil, ptr = nil, orgName = "Medelin", orgType = "Drogas"}, "perm.medelin", "perm.drogas", "perm.cocaina", "perm.ilegal"},

	--VAGOS--
	["Lider [VAGOS]"] = { _config = { gtype = "org", salario = nil, ptr = nil, orgName = "Vagos", orgType = "Drogas"}, "perm.vagos", "perm.lidervagos", "perm.drogas", "perm.heroina", "perm.ilegal", "perm.bauvagos"},
	["Sub-Lider [VAGOS]"] = { _config = { gtype = "org", salario = nil, ptr = nil, orgName = "Vagos", orgType = "Drogas"}, "perm.lidervagos", "perm.vagos", "perm.drogas", "perm.ilegal", "perm.heroina", "perm.bauvagos"},
	["Gerente [VAGOS]"] = { _config = { gtype = "org", salario = nil, ptr = nil, orgName = "Vagos", orgType = "Drogas"}, "perm.vagos", "perm.drogas", "perm.ilegal", "perm.heroina", "perm.bauvagos"},
	["Membro [VAGOS]"] = { _config = { gtype = "org", salario = nil, ptr = nil, orgName = "Vagos", orgType = "Drogas"}, "perm.vagos", "perm.drogas", "perm.ilegal", "perm.heroina", "perm.bauvagos"},
	["Novato [VAGOS]"] = { _config = { gtype = "org", salario = nil, ptr = nil, orgName = "Vagos", orgType = "Drogas"}, "perm.vagos", "perm.drogas", "perm.heroina", "perm.ilegal"},

	--RUSSIA-- 
	["Lider [RUSSIA]"] = { _config = { gtype = "org", salario = nil, ptr = nil, orgName = "Russia", orgType = "Drogas"}, "perm.russia", "perm.liderrussia", "perm.drogas", "perm.cocaina", "perm.ilegal", "perm.baurussia"},
	["Sub-Lider [RUSSIA]"] = { _config = { gtype = "org", salario = nil, ptr = nil, orgName = "Russia", orgType = "Drogas"}, "perm.liderrussia", "perm.russia", "perm.drogas", "perm.ilegal", "perm.cocaina", "perm.baurussia"},
	["Gerente [RUSSIA]"] = { _config = { gtype = "org", salario = nil, ptr = nil, orgName = "Russia", orgType = "Drogas"}, "perm.russia", "perm.drogas", "perm.ilegal", "perm.cocaina", "perm.baurussia"},
	["Membro [RUSSIA]"] = { _config = { gtype = "org", salario = nil, ptr = nil, orgName = "Russia", orgType = "Drogas"}, "perm.russia", "perm.drogas", "perm.ilegal", "perm.cocaina", "perm.baurussia"},
	["Novato [RUSSIA]"] = { _config = { gtype = "org", salario = nil, ptr = nil, orgName = "Russia", orgType = "Drogas"}, "perm.russia", "perm.drogas", "perm.cocaina", "perm.ilegal"},

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-----[COLETE]-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	--BRASIL-- 
	["Lider [BRASIL]"] = { _config = { gtype = "org", salario = nil, ptr = nil, orgName = "Brasil", orgType = "fColete"}, "perm.brasil", "perm.liderbrasil", "perm.colete",  "perm.ilegal", "perm.baubrasil"},
	["Sub-Lider [BRASIL]"] = { _config = { gtype = "org", salario = nil, ptr = nil, orgName = "Brasil", orgType = "fColete"}, "perm.liderbrasil", "perm.brasil", "perm.colete",  "perm.ilegal", "perm.baubrasil"},
	["Gerente [BRASIL]"] = { _config = { gtype = "org", salario = nil, ptr = nil, orgName = "Brasil", orgType = "fColete"}, "perm.brasil", "perm.colete", "perm.ilegal",  "perm.baubrasil"},
	["Membro [BRASIL]"] = { _config = { gtype = "org", salario = nil, ptr = nil, orgName = "Brasil", orgType = "fColete"}, "perm.brasil", "perm.colete", "perm.ilegal",  "perm.baubrasil"},
	["Novato [BRASIL]"] = { _config = { gtype = "org", salario = nil, ptr = nil, orgName = "Brasil", orgType = "fColete"}, "perm.brasil", "perm.colete",  "perm.ilegal"},

	--PARAGUAI--
	["Lider [PARAGUAI]"] = { _config = { gtype = "org", salario = nil, ptr = nil, orgName = "Paraguai", orgType = "fColete"}, "perm.paraguai", "perm.liderparaguai", "perm.colete",  "perm.ilegal", "perm.bauparaguai"},
	["Sub-Lider [PARAGUAI]"] = { _config = { gtype = "org", salario = nil, ptr = nil, orgName = "Paraguai", orgType = "fColete"}, "perm.liderparaguai", "perm.paraguai", "perm.colete", "perm.ilegal", "perm.bauparaguai"},
	["Gerente [PARAGUAI]"] = { _config = { gtype = "org", salario = nil, ptr = nil, orgName = "Paraguai", orgType = "fColete"}, "perm.paraguai", "perm.colete", "perm.ilegal",  "perm.bauparaguai"},
	["Membro [PARAGUAI]"] = { _config = { gtype = "org", salario = nil, ptr = nil, orgName = "Paraguai", orgType = "fColete"}, "perm.paraguai", "perm.colete", "perm.ilegal",  "perm.bauparaguai"},
	["Novato [PARAGUAI]"] = { _config = { gtype = "org", salario = nil, ptr = nil, orgName = "Paraguai", orgType = "fColete"}, "perm.paraguai", "perm.colete",  "perm.ilegal"},

	--MILICIA-- 
    ["Lider [MILICIA]"] = { _config = { gtype = "org", salario = nil, ptr = nil, orgName = "Milicia", orgType = "fColete"}, "perm.milicia", "perm.lidermilicia", "perm.colete", "perm.ilegal", "perm.baumilicia"},
    ["Sub-Lider [MILICIA]"] = { _config = { gtype = "org", salario = nil, ptr = nil, orgName = "Milicia", orgType = "fColete"}, "perm.lidermilicia", "perm.milicia", "perm.colete", "perm.ilegal", "perm.baumilicia"},
    ["Gerente [MILICIA]"] = { _config = { gtype = "org", salario = nil, ptr = nil, orgName = "Milicia", orgType = "fColete"}, "perm.milicia", "perm.colete", "perm.ilegal", "perm.baumilicia"},
    ["Membro [MILICIA]"] = { _config = { gtype = "org", salario = nil, ptr = nil, orgName = "Milicia", orgType = "fColete"}, "perm.milicia", "perm.colete", "perm.ilegal", "perm.baumilicia"},
    ["Novato [MILICIA]"] = { _config = { gtype = "org", salario = nil, ptr = nil, orgName = "Milicia", orgType = "fColete"}, "perm.milicia", "perm.colete", "perm.ilegal"},
	
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Mecanica
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    ["Lider [Mecanica]"] = { _config = { gtype = "org", salario = 3500, ptr = nil, orgName = "Mecanica" },"mecanico.online", "dv.permissao", "perm.mecanica", "perm.lidermecanica", "perm.tunar", "perm.baumecanica"},
    ["Sub-Lider [Mecanica]"] = { _config = { gtype = "org", salario = 3000, ptr = nil, orgName = "Mecanica" },"mecanico.online", "perm.mecanica", "perm.tunar", "perm.baumecanica"},
	["Gerente [Mecanica]"] = { _config = { gtype = "org", salario = 2500, ptr = nil, orgName = "Mecanica" },"mecanico.online", "perm.mecanica", "perm.tunar", "perm.baumecanica"},
	["Membro [Mecanica]"] = { _config = { gtype = "org", salario = 2000, ptr = nil, orgName = "Mecanica" },"mecanico.online", "perm.mecanica", "perm.tunar", "perm.baumecanica"},
	["Novato [Mecanica]"] = { _config = { gtype = "org", salario = 1500, ptr = nil, orgName = "Mecanica" },"mecanico.online", "perm.mecanica", "perm.tunar"},

	
}

cfg.users = {
	[1] = { "developer" },
}

cfg.selectors = { }

return cfg
