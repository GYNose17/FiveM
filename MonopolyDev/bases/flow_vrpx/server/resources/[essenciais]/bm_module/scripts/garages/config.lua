garagesConfig = {}

garagesConfig.main = {
	dir = "http://127.0.0.1:/ultimate/carros/",
	spawnClientVehicle = true, -- Spawnar veiculo via client-side

	clearVehicle = { -- LIMPAR VEICULOS QUE NÃO ESTEJAM USADOS
		enable = true,  -- CASO QUEIRA ATIVAR / DESATIVAR
		time = 15, -- TEMPO EM MINUTOS
	},

	ipvaVencimento = 7, -- DIAS PARA O VENCIMENTO DO IPVA
	ipvaValue = 0.05, -- 5% VALOR  DO VEICULO IPVA

	detidoValue = 0.15, -- 5% VALOR DO VEICULO DETIDO
	retidoValue = 0.15, -- 10% VALOR DO VEICULO RETIDO 

	defaultCarPrice = 5000, -- Valor padrão caso o carro não seja encontrado na lista abaixo.
	defaultCarChest = 50, -- Valor padrão caso o carro não seja encontrado na lista abaixo.

	commands = {
		prefix = "veh", -- PREFIX
		sellVeh = "vender", -- comando para vender carro /veh vender
		keyAdd = "add", -- comando para add chave carro /veh add
		keyRem = "rem", -- comando para rem chave carro /veh rem
	}
}

garagesConfig.listCars = {

----------------------------------------------------------------------------------------------------------------------------------------------------------------
-------[Viaturas]-----------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------
	[GetHashKey('amarokcore')] = { model = "amarokcore", price = 1000000, banned = false, name = "Amarok Core", trunk = 30, type = "service" },
	[GetHashKey('corollap2')] = { model = "corollap2", price = 1000000, banned = false, name = "corollap2", trunk = 30, type = "service" },
	[GetHashKey('corollapcerj')] = { model = "corollapcerj", price = 1000000, banned = false, name = "corollapcerj", trunk = 30, type = "service" },
	[GetHashKey('corollapmerj1')] = { model = "corollapmerj1", price = 1000000, banned = false, name = "corollapmerj1", trunk = 30, type = "service" },
	[GetHashKey('dusterpcerj1')] = { model = "dusterpcerj1", price = 1000000, banned = false, name = "dusterpcerj1", trunk = 30, type = "service" },
	[GetHashKey('dusterpmerjb')] = { model = "dusterpmerjb", price = 1000000, banned = false, name = "dusterpmerjb", trunk = 30, type = "service" },
	[GetHashKey('frontierbope')] = { model = "frontierbope", price = 1000000, banned = false, name = "frontierbope", trunk = 30, type = "service" },
	[GetHashKey('bellpc')] = { model = "bellpc", price = 1000000, banned = false, name = "bellpc", trunk = 30, type = "service" }, --heli civil
	[GetHashKey('hiluxbope')] = { model = "hiluxbope", price = 1000000, banned = false, name = "hiluxbope", trunk = 30, type = "service" },
	[GetHashKey('hiluxgat')] = { model = "hiluxgat", price = 1000000, banned = false, name = "hiluxgat", trunk = 30, type = "service" },
	[GetHashKey('l200bopeg')] = { model = "l200bopeg", price = 1000000, banned = false, name = "l200bopeg", trunk = 30, type = "service" },
	[GetHashKey('maverickbp')] = { model = "maverickbp", price = 1000000, banned = false, name = "maverickbp", trunk = 30, type = "service" },
	[GetHashKey('pajerod')] = { model = "pajerod", price = 1000000, banned = false, name = "pajerod", trunk = 30, type = "service" },
	[GetHashKey('s10bpve')] = { model = "s10bpve", price = 1000000, banned = false, name = "s10bpve", trunk = 30, type = "service" },
	[GetHashKey('s10pcerj')] = { model = "s10pcerj", price = 1000000, banned = false, name = "s10pcerj", trunk = 30, type = "service" },
	[GetHashKey('trailsamu')] = { model = "trailsamu", price = 1000000, banned = false, name = "trailsamu", trunk = 30, type = "service" },
	[GetHashKey('versapcerj')] = { model = "versapcerj", price = 1000000, banned = false, name = "versapcerj", trunk = 30, type = "service" },
	[GetHashKey('nissanversa')] = { model = "nissanversa", price = 1000000, banned = false, name = "nissanversa", trunk = 30, type = "service" },
	[GetHashKey('xt660pmerj')] = { model = "xt660pmerj", price = 1000000, banned = false, name = "xt660pmerj", trunk = 30, type = "service" },

----------------------------------------------------------------------------------------------------------------------------------------------------------------
-------[Motos Mod]-----------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
	[GetHashKey('r1250')] = { model = "r1250", price = 1000000, banned = false, name = "r1250", trunk = 30, type = "vip" },
	[GetHashKey('450crf')] = { model = "450crf", price = 1000000, banned = false, name = "450crf", trunk = 30, type = "vip" },
	[GetHashKey('biz25')] = { model = "biz25", price = 1000000, banned = false, name = "biz25", trunk = 30, type = "vip" },
	[GetHashKey('bros60')] = { model = "bros60", price = 1000000, banned = false, name = "bros60", trunk = 30, type = "vip" },
	[GetHashKey('dm1200')] = { model = "dm1200", price = 1000000, banned = false, name = "dm1200", trunk = 30, type = "vip" },
	[GetHashKey('r1')] = { model = "r1", price = 1000000, banned = false, name = "r1", trunk = 30, type = "vip" },
	[GetHashKey('r6')] = { model = "r6", price = 1000000, banned = false, name = "r6", trunk = 30, type = "vip" },
	[GetHashKey('xj')] = { model = "xj", price = 1000000, banned = false, name = "xj", trunk = 30, type = "vip" },
	[GetHashKey('xt66')] = { model = "xt66", price = 1000000, banned = false, name = "xt66", trunk = 30, type = "vip" },
	[GetHashKey('z1000')] = { model = "z1000", price = 1000000, banned = false, name = "z1000", trunk = 30, type = "vip" },

----------------------------------------------------------------------------------------------------------------------------------------------------------------
-------[Carros Mod]-----------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
    [GetHashKey('f300')] = { model = 'f300', price = 1000000, banned = false, name = 'f300', trunk = 70, type = 'vip'},
    [GetHashKey('fxxkevo')] = { model = 'fxxkevo', price = 1000000, banned = false, name = 'fxxkevo', trunk = 70, type = 'vip'},
	[GetHashKey('180sx')] = { model = '180sx', price = 1000000, banned = false, name = '180sx', trunk = 70, type = 'vip'},
	[GetHashKey('350z')] = { model = '350z', price = 1000000, banned = false, name = '350z', trunk = 70, type = 'vip'},
	[GetHashKey('a802')] = { model = 'a802', price = 1000000, banned = false, name = 'a802', trunk = 70, type = 'vip'},
	[GetHashKey('audir8')] = { model = 'audir8', price = 1000000, banned = false, name = 'audir8', trunk = 70, type = 'vip'},
	[GetHashKey('audirs7')] = { model = 'audirs7', price = 1000000, banned = false, name = 'audirs7', trunk = 70, type = 'vip'},
	[GetHashKey('bmwm1wb')] = { model = 'bmwm1wb', price = 1000000, banned = false, name = 'bmwm1wb', trunk = 70, type = 'vip'},
	[GetHashKey('bmwm5e34')] = { model = 'bmwm5e34', price = 1000000, banned = false, name = 'bmwm5e34', trunk = 70, type = 'vip'},
	[GetHashKey('bmwm8')] = { model = 'bmwm8', price = 1000000, banned = false, name = 'bmwm8', trunk = 70, type = 'vip'},
	[GetHashKey('bnrpandem')] = { model = 'bnrpandem', price = 1000000, banned = false, name = 'bnrpandem', trunk = 70, type = 'vip'},
	[GetHashKey('brz13')] = { model = 'brz13', price = 1000000, banned = false, name = 'brz13', trunk = 70, type = 'vip'},
	[GetHashKey('camaro')] = { model = 'camaro', price = 1000000, banned = false, name = 'camaro', trunk = 70, type = 'vip'},
	[GetHashKey('civictyper')] = { model = 'civictyper', price = 1000000, banned = false, name = 'civictyper', trunk = 70, type = 'vip'},
	[GetHashKey('dodgecharger1970')] = { model = 'dodgecharger1970', price = 1000000, banned = false, name = 'dodgecharger1970', trunk = 70, type = 'vip'},
	[GetHashKey('dodgechargersrt')] = { model = 'dodgechargersrt', price = 1000000, banned = false, name = 'dodgechargersrt', trunk = 70, type = 'vip'},
	[GetHashKey('dodgeramtrx')] = { model = 'dodgeramtrx', price = 1000000, banned = false, name = 'dodgeramtrx', trunk = 70, type = 'vip'},
	[GetHashKey('f8t')] = { model = 'f8t', price = 1000000, banned = false, name = 'f8t', trunk = 70, type = 'vip'},
	[GetHashKey('fd')] = { model = 'fd', price = 1000000, banned = false, name = 'fd', trunk = 70, type = 'vip'},
	[GetHashKey('ferrarif12')] = { model = 'ferrarif12', price = 1000000, banned = false, name = 'ferrarif12', trunk = 70, type = 'vip'},
	[GetHashKey('fnfcivic')] = { model = 'fnfcivic', price = 1000000, banned = false, name = 'fnfcivic', trunk = 70, type = 'vip'},
	[GetHashKey('fordmustang')] = { model = 'fordmustang', price = 1000000, banned = false, name = 'fordmustang', trunk = 70, type = 'vip'},
	[GetHashKey('lamborghinihuracan')] = { model = 'lamborghinihuracan', price = 1000000, banned = false, name = 'lamborghinihuracan', trunk = 70, type = 'vip'},
	[GetHashKey('lancerevolution9')] = { model = 'lancerevolution9', price = 1000000, banned = false, name = 'lancerevolution9', trunk = 70, type = 'vip'},
	[GetHashKey('lancerevolutionx')] = { model = 'lancerevolutionx', price = 1000000, banned = false, name = 'lancerevolutionx', trunk = 70, type = 'vip'},
	[GetHashKey('m3e46')] = { model = 'm3e46', price = 1000000, banned = false, name = 'm3e46', trunk = 70, type = 'vip'},
	[GetHashKey('mazdarx72')] = { model = 'mazdarx72', price = 1000000, banned = false, name = 'mazdarx72', trunk = 70, type = 'vip'},
	[GetHashKey('mclarenp1')] = { model = 'mclarenp1', price = 1000000, banned = false, name = 'mclarenp1', trunk = 70, type = 'vip'},
	[GetHashKey('mercedesgt63')] = { model = 'mercedesgt63', price = 1000000, banned = false, name = 'mercedesgt63', trunk = 70, type = 'vip'},
	[GetHashKey('mustangfast')] = { model = 'mustangfast', price = 1000000, banned = false, name = 'mustangfast', trunk = 70, type = 'vip'},
	[GetHashKey('nissangtr3')] = { model = 'nissangtr3', price = 1000000, banned = false, name = 'nissangtr3', trunk = 70, type = 'vip'},
	[GetHashKey('porsche911')] = { model = 'porsche911', price = 1000000, banned = false, name = 'porsche911', trunk = 70, type = 'vip'},
	[GetHashKey('s15rb')] = { model = 's15rb', price = 1000000, banned = false, name = 's15rb', trunk = 70, type = 'vip'},
	[GetHashKey('skyliner34')] = { model = 'skyliner34', price = 1000000, banned = false, name = 'Skyline', trunk = 70, type = 'vip'},
	[GetHashKey('subarubrz')] = { model = 'subarubrz', price = 1000000, banned = false, name = 'subarubrz', trunk = 70, type = 'vip'},
	[GetHashKey('toyotasupra2')] = { model = 'toyotasupra2', price = 1000000, banned = false, name = 'toyotasupra2', trunk = 70, type = 'vip'},
	[GetHashKey('urus')] = { model = 'urus', price = 1000000, banned = false, name = 'urus', trunk = 70, type = 'vip'},
	[GetHashKey('velar')] = { model = 'velar', price = 1000000, banned = false, name = 'velar', trunk = 70, type = 'vip'},
	[GetHashKey('f450c')] = { model = 'f450c', price = 1000000, banned = false, name = 'f450c', trunk = 70, type = 'vip'},




	--[[VEÍCULOS VELOZES E FURIOSOS]]--
	[GetHashKey('rmodskyline34')] = { model = "rmodskyline34", price = 1500000, banned = false, name = 'Skyline R34', trunk = 40, type = 'vip' },
	[GetHashKey('fnflan')] = { model = 'fnflan', price = 1500000, banned = false, name = 'Mitsubishi Lancer Evolution IX GSR', trunk = 30, type = 'vip'},
	[GetHashKey('ff4wrx')] = { model = 'ff4wrx', price = 1500000, banned = false, name = 'Subaru Impreza Fast and Furious', trunk = 30, type = 'vip'},
	[GetHashKey('2f2fmk4')] = { model = '2f2fmk4', price = 1500000, banned = false, name = 'Toyota Supra Fast and Furious', trunk = 30, type = 'vip'},
	[GetHashKey('fnfmk4')] = { model = 'fnfmk4', price = 1500000, banned = false, name = 'Toyota Supra Fast and Furious 2', trunk = 30, type = 'vip'},
	[GetHashKey('fnfmits')] = { model = 'fnfmits', price = 1500000, banned = false, name = 'Mitsubishi Eclipse do Brian', trunk = 30, type = 'vip'},
	[GetHashKey('fnfrx7')] = { model = 'fnfrx7', price = 1500000, banned = false, name = 'Mazda RX7 do Han', trunk = 0, type = 'vip'},
	[GetHashKey('2f2fmle7')] = { model = '2f2fmle7', price = 1500000, banned = false, name = 'Lancer Evolution do Brian', trunk = 30, type = 'vip'},
	[GetHashKey('2f2fgts')] = { model = '2f2fgts', price = 1500000, banned = false, name = 'Mitsubishi Spyder do Roman', trunk = 30, type = 'vip'},
		
	--[[VEÍCULOS EMPREGOS]]--
	[GetHashKey('quadri')] = { model = 'quadri', price = 1000000, banned = false, name = 'Quadriciclo', trunk = 0, type = 'service'},
	[GetHashKey('phantom')] = { model = 'phantom', price = 1000000, banned = false, name = 'Phantom', trunk = 0, type = 'service'},
	[GetHashKey('trash2')] = { model = 'trash2', price = 1000000, banned = false, name = 'Trash 2', trunk = 0, type = 'service' },
	[GetHashKey('tiptruck')] = { model = 'tiptruck', price = 1000000, banned = false, name = 'Tip Truck', trunk = 80, type = 'service' },
	[GetHashKey('boxville2')] = { model = 'boxville2', price = 1000000, banned = false, name = 'Box ville', trunk = 80, type = 'service' },
	[GetHashKey('airbus')] = { model = 'airbus', price = 1000000, banned = false, name = 'Airbus', trunk = nil, type = 'service' },
	[GetHashKey('bus')] = { model = 'bus', price = 1000000, banned = false, name = 'Bus', trunk = nil, type = 'service' },
	[GetHashKey('dinghy')] = { model = 'dinghy', price = 1000000, banned = false, name = 'Dinghy', trunk = nil, type = 'service' },
	[GetHashKey('dinghy2')] = { model = 'dinghy2', price = 1000000, banned = false, name = 'Dinghy 2', trunk = nil, type = 'service' },
	[GetHashKey('dinghy3')] = { model = 'dinghy3', price = 1000000, banned = false, name = 'Dinghy 3', trunk = nil, type = 'service' },
	[GetHashKey('dinghy4')] = { model = 'dinghy4', price = 1000000, banned = false, name = 'Dinghy 4', trunk = nil, type = 'service' },
	[GetHashKey('trailerlogs')] = { model = 'trailerlogs', price = 1000000, banned = false, name = 'Trailer Logs', trunk = nil, type = 'service' },
	[GetHashKey('taxi')] = { model = 'taxi', price = 1000000, banned = false, name = 'Táxi', trunk = nil, type = 'service' },
	[GetHashKey('towtruck2')] = { model = 'towtruck2', price = 1000000, banned = false, name = 'TowTruck 2', trunk = nil, type = 'service' },
	[GetHashKey('flatbed')] = { model = 'flatbed', price = 1000000, banned = false, name = 'Flatbed', trunk = nil, type = 'service' },

	--[[HELIS]]--
	[GetHashKey('supervolito')] = { model = 'supervolito', price = 1500000, banned = false, name = 'HELI HP', trunk = 150, type = 'vip' },
	[GetHashKey('supervolito2')] = { model = 'supervolito2', price = 1500000, banned = false, name = 'Supervolito 2', trunk = 150, type = 'vip' },
	[GetHashKey('frogger')] = { model = 'frogger', price = 1500000, banned = false, name = 'Frogger', trunk = 150, type = 'vip' },
	[GetHashKey('frogger2')] = { model = 'frogger2', price = 1500000, banned = false, name = 'Frogger2', trunk = 150, type = 'vip' },
	[GetHashKey('volatus')] = { model = 'volatus', price = 1500000, banned = false, name = 'Volatus', trunk = 150, type = 'vip' },
	[GetHashKey('luxor')] = { model = 'luxor', price = 1500000, banned = false, name = 'Luxor', trunk = 50, type = 'vip' },
	[GetHashKey('swift2')] = { model = 'swift2', price = 1500000, banned = false, name = 'Swift2', trunk = 150, type = 'vip' },

	--[[FIM DOS VIP]]--
	[GetHashKey('furia')] = { model = 'furia', price = 10000000, banned = false, name = 'Furia', trunk = 50, type = 'imports' },
	[GetHashKey('italirsx')] = { model = 'italirsx', price = 10000000, banned = false, name = 'ItaliRSX', trunk = 30, type = 'outros' },
	[GetHashKey('krieger')] = { model = 'krieger', price = 4000000, banned = false, name = 'Krieger', trunk = 30, type = 'imports', },
	[GetHashKey('emerus')] = { model = 'emerus', price = 2000000, banned = false, name = 'Emerus', trunk = 30, type = 'imports' },
	[GetHashKey('zorrusso')] = { model = 'zorrusso', price = 3500000, banned = false, name = 'Zorrusso', trunk = 30, type = 'imports'  },
	[GetHashKey('thrax')] = { model = 'thrax', price = 5000000, banned = false, name = 'Thrax', trunk = 30, type = 'imports' },
	[GetHashKey('vstr')] = { model = 'vstr', price = 200000, banned = false, name = 'Vstr', trunk = 30, type = 'outros' },
	[GetHashKey('caracara2')] = { model = 'caracara2', price = 1000000, banned = false, name = 'Caracara2', trunk = 90, type = 'suvs' },
	[GetHashKey('verus')] = { model = 'verus', price = 1000000, banned = false, name = 'Verus', trunk = 50, type = 'motos' },
	[GetHashKey('hellion')] = { model = "hellion", price = 800000, banned = false, name = "Hellion", trunk = 70, type = 'suvs' },
	[GetHashKey('novak')] = { model = "novak", price = 800000, banned = false, name = "Novak", trunk = 70, type = 'suvs' },
	[GetHashKey('rebla')] = { model = 'rebla', price = 800000, banned = false, name = 'Rebla', trunk = 70, type = 'suvs' },
	[GetHashKey('paragon')] = { model = 'paragon', price = 800000, banned = false, name = 'Paragon', trunk = 30, type = 'outros' },
	[GetHashKey('jugular')] = { model = 'jugular', price = 700000, banned = false, name = 'Jugular', trunk = 30, type = 'outros' },
	[GetHashKey('komoda')] = { model = 'komoda', price = 850000, banned = false, name = 'Komoda', trunk = 30, type = 'outros' },
	[GetHashKey('drafter')] = { model = 'drafter', price = 800000, banned = false, name = 'Drafter', trunk = 30, type = 'outros' },
	[GetHashKey('benson')] = { model = "benson", price = 10000000, banned = false, name = "Benson", trunk = 1000, type = 'service' },
	[GetHashKey('brickade')] = { model = 'brickade', price = 1000000, banned = false, name = 'Brickade', trunk = 2000, type = 'vip' },
	[GetHashKey('club')] = { model = 'club', price = 800000, banned = false, name = 'Club', trunk = 30, type = 'outros' },
	[GetHashKey('kanjo')] = { model = 'kanjo', price = 90000, banned = false, name = 'Kanjo', trunk = 30, type = 'outros'},
	[GetHashKey('issi5')] = { model = 'issi5', price = 1000000, banned = false, name = 'Issi 5', trunk = 30, type = 'outros' },
	[GetHashKey('issi4')] = { model = 'issi4', price = 1000000, banned = false,  name = 'Issi 4', trunk = 30, type = 'outros' },
	[GetHashKey('panto')] = { model = 'panto', price = 5000, banned = false, name = 'Panto', trunk = 30, type = 'outros' },
	[GetHashKey('glendale2')] = { model = 'glendale2', price = 250000, banned = false, name = 'Glendale 2', trunk = 30, type = 'sedans' },
	[GetHashKey('regina')] = { model = 'regina', price = 200000, banned = false,  name = 'Regina', trunk = 30, type = 'sedans' },
	[GetHashKey('romero')] = { model = 'romero', price = 500000, banned = false, name = 'Funerário', trunk = 30, type = 'sedans' },
	[GetHashKey('stretch')] = { model = 'stretch', price = 15000000, banned = false, name = 'Limousine', trunk = 60, type = 'sedans' },
	[GetHashKey('pbus2')] = { model = 'pbus2', price = 1000, banned = false, name = 'Bus Fest', trunk = 0, type = 'service' },
	[GetHashKey('imorgon')] = { model = 'imorgon', price = 900000, banned = false, name = 'Imorgon', trunk = 30, type = 'outros' },
	[GetHashKey('issi7')] = { model = 'issi7', price = 400000, banned = false, name = 'Issi 7', trunk = 30, type = 'outros'},
	[GetHashKey('locust')] = { model = 'locust', price = 2000000, banned = false, name = 'Ocelot', trunk = 45, type = 'outros' },
	[GetHashKey('neo')] = { model = 'neo', price = 2000000, banned = false, name = 'Neo', trunk = 30, type = 'outros' },
	[GetHashKey('penumbra2')] = { model = 'penumbra2', price = 600000, banned = false, name = 'Penumbra 2', trunk = 30, type = 'outros' },
	[GetHashKey('revolter')] = { model = 'revolter', price = 200000, banned = false, name = 'Revolter', trunk = 30, type = 'outros' },
	[GetHashKey('schafter2')] = { model = 'schafter2', price = 100000, banned = false, name = 'Schafter 2', trunk = 30, type = 'outros' },
	[GetHashKey('blista')] = { model = 'blista', price = 90000, banned = false, name = 'Blista', trunk = 40, type = 'outros'},

	[GetHashKey('sultan2')] = { model = 'sultan2', price = 500000, banned = false, name = 'Sultan 2', trunk = 30, type = 'outros' },
	[GetHashKey('dynasty')] = { model = 'dynasty', price = 200000, banned = false, name = 'Dynasty', trunk = 30, type = 'outros' },
	[GetHashKey('manana2')] = { model = 'manana2', price = 300000, banned = false, name = 'Manana 2', trunk = 30, type = 'outros' },
	[GetHashKey('peyote3')] = { model = 'peyote3', price = 300000, banned = false, name = 'Peyote 3', trunk = 30, type = 'outros' },
	[GetHashKey('retinue2')] = { model = 'retinue2', price = 300000, banned = false, name = 'Retinue 2', trunk = 30, type = 'outros' },
	[GetHashKey('savestra')] = { model = 'savestra', price = 400000, banned = false, name = 'Savestra', trunk = 30, type = 'outros' },
	-- [GetHashKey('viseris')] = { model = 'viseris', price = 600000, banned = false, name = 'Viseris', trunk = 30, type = 'outros' },
	[GetHashKey('s80')] = { model = 's80', price = 1000000, banned = false, name = 'S80', trunk = 30, type = 'imports' },
	[GetHashKey('tigon')] = { model = 'tigon', price = 2000000, banned = false, name = 'Tigon', trunk = 30, type = 'imports' },
	[GetHashKey('brioso')] = { model = 'brioso', price = 45000, banned = false, name = 'Brioso', trunk = 30, type = 'outros' },
	[GetHashKey('brioso2')] = { model = "brioso2", price = 70000, banned = false, name = "Brioso 2", trunk = 30, type = 'outros' },
	[GetHashKey('dilettante')] = { model = 'dilettante', price = 100000, banned = false, name = 'Dilettante', trunk = 30, type = 'outros' },
	[GetHashKey('primo2')] = { model = 'primo2', price = 25000, banned = false, name = 'Primo2', trunk = 40, type = 'suvs' },
	[GetHashKey('chino')] = { model = 'chino', price = 150000, banned = false, name = 'Chino', trunk = 50, type = 'outros' },
	[GetHashKey('chino2')] = { model = 'chino2', price = 600000, banned = false, name = 'Chino2', trunk = 60, type = 'outros' },
	[GetHashKey('coquette3')] = { model = 'coquette3', price = 1500000, banned = false, name = 'Coquette3', trunk = 40, type = 'outros' },
	[GetHashKey('dominator')] = { model = 'dominator', price = 200000, banned = false, name = 'Dominator', trunk = 50, type = 'outros' },
	[GetHashKey('dominator2')] = { model = 'dominator2', price = 300000, banned = false, name = 'Dominator2', trunk = 50, type = 'outros' },
	[GetHashKey('dukes')] = { model = 'dukes', price = 200000, banned = false, name = 'Dukes', trunk = 40, type = 'outros' },
	[GetHashKey('faction')] = { model = 'faction', price = 140000, banned = false, name = 'Faction', trunk = 50, type = 'outros' },
	[GetHashKey('faction2')] = { model = 'faction2', price = 500000, banned = false, name = 'Faction2', trunk = 40, type = 'outros' },
	[GetHashKey('faction3')] = { model = 'faction3', price = 500000, banned = false, name = 'Faction3', trunk = 60, type = 'outros' },
	[GetHashKey('gauntlet4')] = { model = 'gauntlet4', price = 1000000, banned = false, name = 'Gauntlet 4', trunk = 30, type = 'outros' },
	[GetHashKey('gauntlet3')] = { model = 'gauntlet3', price = 150000, banned = false, name = 'Gauntlet 3', trunk = 30, type = 'outros' },
	[GetHashKey('gauntlet2')] = { model = 'gauntlet2', price = 400000, banned = false, name = 'Gauntlet2', trunk = 40, type = 'outros' },
	[GetHashKey('hermes')] = { model = 'hermes', price = 200000, banned = false, name = 'Hermes', trunk = 50, type = 'outros' },
	[GetHashKey('hotknife')] = { model = 'hotknife', price = 500000, banned = false, name = 'Hotknife', trunk = 30, type = 'outros' },
	[GetHashKey('moonbeam')] = { model = 'moonbeam', price = 10000000, banned = false, name = 'Moonbeam', trunk = 80, type = 'outros' },
	[GetHashKey('moonbeam2')] = { model = 'moonbeam2', price = 5000000, banned = false, name = 'Moonbeam2', trunk = 70, type = 'outros' },
	[GetHashKey('nightshade')] = { model = 'nightshade', price = 450000, banned = false, name = 'Nightshade', trunk = 30, type = 'outros' },
	[GetHashKey('picador')] = { model = 'picador', price = 200000, banned = false, name = 'Picador', trunk = 90, type = 'outros' },
	[GetHashKey('ruiner')] = { model = 'ruiner', price = 100000, banned = false, name = 'Ruiner', trunk = 50, type = 'outros' },
	[GetHashKey('sabregt')] = { model = 'sabregt', price = 120000, banned = false, name = 'Sabregt', trunk = 60, type = 'outros' },
	[GetHashKey('sabregt2')] = { model = 'sabregt2', price = 150000, banned = false, name = 'Sabregt2', trunk = 60, type = 'outros' },
	[GetHashKey('gburrito')] = { model = 'gburrito', price = 1500000, banned = false, name = 'GBurrito', trunk = 100, type = 'service' },
	[GetHashKey('slamvan')] = { model = 'slamvan', price = 800000, banned = false, name = 'Slamvan', trunk = 80, type = 'outros' },
	[GetHashKey('slamvan2')] = { model = 'slamvan2', price = 800000, banned = false, name = 'Slamvan2', trunk = 50, type = 'service' },
	[GetHashKey('slamvan3')] = { model = 'slamvan3', price = 800000, banned = false, name = 'Slamvan3', trunk = 80, type = 'outros' },
	[GetHashKey('stalion')] = { model = 'stalion', price = 400000, banned = false, name = 'Stalion', trunk = 30, type = 'outros' },
	[GetHashKey('stalion2')] = { model = 'stalion2', price = 260000, banned = false, name = 'Stalion2', trunk = 20, type = 'outros' },
	[GetHashKey('tampa')] = { model = 'tampa', price = 200000, banned = false, name = 'Tampa', trunk = 40, type = 'outros' },
	[GetHashKey('vigero')] = { model = 'vigero', price = 170000, banned = false, name = 'Vigero', trunk = 30, type = 'outros' },
	[GetHashKey('virgo')] = { model = 'virgo', price = 150000, banned = false, name = 'Virgo', trunk = 60, type = 'outros' },
	[GetHashKey('virgo2')] = { model = 'virgo2', price = 150000, banned = false, name = 'Virgo2', trunk = 50, type = 'outros' },
	[GetHashKey('virgo3')] = { model = 'virgo3', price = 150000, banned = false, name = 'Virgo3', trunk = 60, type = 'outros' },
	[GetHashKey('voodoo')] = { model = 'voodoo', price = 300000, banned = false, name = 'Voodoo', trunk = 60, type = 'outros' },
	[GetHashKey('voodoo2')] = { model = 'voodoo2', price = 100000, banned = false, name = 'Voodoo2', trunk = 60, type = 'outros' },
	[GetHashKey('yosemite')] = { model = 'yosemite', price = 800000, banned = false, name = 'Yosemite', trunk = 130, type = 'outros' },
	[GetHashKey('yosemite3')] = { model = 'yosemite3', price = 1000000, banned = false, name = 'Yosemite 3', trunk = 70, type = 'outros' },
	[GetHashKey('bfinjection')] = { model = 'bfinjection', price = 60000, banned = false, name = 'Bfinjection', trunk = 20, type = 'suvs' },
	[GetHashKey('bifta')] = { model = 'bifta', price = 800000, banned = false, name = 'Bifta', trunk = 20, type = 'suvs' },
	[GetHashKey('bodhi2')] = { model = 'bodhi2', price = 900000, banned = false, name = 'Bodhi2', trunk = 90, type = 'suvs' },
	[GetHashKey('brawler')] = { model = 'brawler', price = 4000000, banned = false, name = 'Brawler', trunk = 100, type = 'outros' },
	[GetHashKey('trophytruck')] = { model = 'trophytruck', price = 2000000, banned = false, name = 'Trophytruck', trunk = 10, type = 'suvs' },
	[GetHashKey('trophytruck2')] = { model = 'trophytruck2', price = 2000000, banned = false, name = 'Trophytruck2', trunk = 15, type = 'suvs' },
	[GetHashKey('dubsta3')] = { model = 'dubsta3', price = 5000000, banned = false, name = 'Dubsta3', trunk = 90, type = 'suvs' },
	[GetHashKey('mesa3')] = { model = 'mesa3', price = 1500000, banned = false, name = 'Mesa3', trunk = 60, type = 'suvs' },
	[GetHashKey('rancherxl')] = { model = 'rancherxl', price = 200000, banned = false, name = 'Rancherxl', trunk = 70, type = 'suvs' },
	[GetHashKey('rebel')] = { model = 'rebel', price = 2500000, banned = false, name = 'Rebel', trunk = 250, type = 'service' },
	[GetHashKey('rebel2')] = { model = 'rebel2', price = 2000000, banned = false, name = 'Rebel2', trunk = 200, type = 'suvs' },
	[GetHashKey('riata')] = { model = 'riata', price = 2500000, banned = false, name = 'Riata', trunk = 250, type = 'suvs' },
	[GetHashKey('dloader')] = { model = 'dloader', price = 150000, banned = false, name = 'Dloader', trunk = 80, type = 'outros' },
	[GetHashKey('ratloader')] = { model = 'ratloader', price = 1000000, banned = false, name = 'Caminhão', trunk = 80, type = 'service' },
	[GetHashKey('sandking')] = { model = 'sandking', price = 2500000, banned = false, name = 'Sandking', trunk = 250, type = 'suvs' },
	[GetHashKey('sandking2')] = { model = 'sandking2', price = 2500000, banned = false, name = 'Sandking2', trunk = 250, type = 'outros' },
	[GetHashKey('baller')] = { model = 'baller', price = 1000000, banned = false, name = 'Baller', trunk = 50, type = 'suvs' },
	[GetHashKey('baller2')] = { model = 'baller2', price = 1500000, banned = false, name = 'Baller2', trunk = 50, type = 'suvs' },
	[GetHashKey('baller3')] = { model = 'baller3', price = 2000000, banned = false, name = 'Baller3', trunk = 50, type = 'suvs' },
	[GetHashKey('baller4')] = { model = 'baller4', price = 2500000, banned = false, name = 'Baller4', trunk = 50, type = 'suvs' },
		-- aqui
	[GetHashKey('baller5')] = { model = 'baller5', price = 270000, banned = false, name = 'Baller5', trunk = 50, type = 'vip' },
	[GetHashKey('baller6')] = { model = 'baller6', price = 280000, banned = false, name = 'Baller6', trunk = 50, type = 'suvs' },
	[GetHashKey('bjxl')] = { model = 'bjxl', price = 1000000, banned = false, name = 'Bjxl', trunk = 50, type = 'suvs' },
	[GetHashKey('cavalcade')] = { model = 'cavalcade', price = 500000, banned = false, name = 'Cavalcade', trunk = 60, type = 'suvs' },
	[GetHashKey('cavalcade2')] = { model = 'cavalcade2', price = 200000, banned = false, name = 'Cavalcade2', trunk = 60, type = 'suvs' },
	[GetHashKey('contender')] = { model = 'contender', price = 7000000, banned = false, name = 'Contender', trunk = 80, type = 'suvs' },
	[GetHashKey('dubsta')] = { model = 'dubsta', price = 1500000, banned = false, name = 'Dubsta', trunk = 70, type = 'suvs' },
	[GetHashKey('dubsta2')] = { model = 'dubsta2', price = 2000000, banned = false, name = 'Dubsta2', trunk = 70, type = 'suvs' },
	[GetHashKey('fq2')] = { model = 'fq2', price = 400000, banned = false, name = 'Fq2', trunk = 50, type = 'suvs' },
	[GetHashKey('granger')] = { model = 'granger', price = 600000, banned = false, name = 'Granger', trunk = 100, type = 'suvs' },
	[GetHashKey('gresley')] = { model = 'gresley', price = 300000, banned = false, name = 'Gresley', trunk = 50, type = 'suvs' },
	[GetHashKey('habanero')] = { model = 'habanero', price = 220000, banned = false, name = 'Habanero', trunk = 50, type = 'suvs' },
	[GetHashKey('seminole')] = { model = 'seminole', price = 230000, banned = false, name = 'Seminole', trunk = 60, type = 'suvs' },
	[GetHashKey('seminole2')] = { model = 'seminole2', price = 800000, banned = false, name = 'Seminole 2', trunk = 70, type = 'suvs' },
	[GetHashKey('serrano')] = { model = 'serrano', price = 250000, banned = false, name = 'Serrano', trunk = 50, type = 'suvs' },
	[GetHashKey('xls')] = { model = 'xls', price = 400000, banned = false, name = 'Xls', trunk = 50, type = 'suvs' },
	[GetHashKey('xls2')] = { model = 'xls2', price = 350000, banned = false, name = 'Xls2', trunk = 50, type = 'outros' },
	[GetHashKey('asea')] = { model = 'asea', price = 100000, banned = false, name = 'Asea', trunk = 30, type = 'sedans' },
	[GetHashKey('asterope')] = { model = 'asterope', price = 150000, banned = false, name = 'Asterope', trunk = 30, type = 'sedans' },
	[GetHashKey('cog55')] = { model = 'cog55', price = 200000, banned = false, name = 'Cog55', trunk = 50, type = 'sedans' },
	[GetHashKey('cog552')] = { model = 'cog552', price = 200000, banned = false, name = 'Cog552', trunk = 50, type = 'outros' },
	[GetHashKey('cognoscenti')] = { model = 'cognoscenti', price = 190000, banned = false, name = 'Cognoscenti', trunk = 50, type = 'outros' },
	[GetHashKey('cognoscenti2')] = { model = 'cognoscenti2', price = 200000, banned = false, name = 'Cognoscenti2', trunk = 50, type = 'outros' },
	[GetHashKey('stanier')] = { model = 'stanier', price = 130000, banned = false, name = 'Stanier', trunk = 60, type = 'sedans' },
	[GetHashKey('stratum')] = { model = 'stratum', price = 100000, banned = false, name = 'Stratum', trunk = 70, type = 'sedans' },
	[GetHashKey('importsd')] = { model = 'importsd', price = 150000, banned = false, name = 'importsd', trunk = 30, type = 'sedans' },
	[GetHashKey('surge')] = { model = 'surge', price = 220000, banned = false, name = 'Surge', trunk = 60, type = 'sedans' },
	[GetHashKey('tailgater')] = { model = 'tailgater', price = 160000, banned = false, name = 'Tailgater', trunk = 50, type = 'sedans' },
	[GetHashKey('warrener')] = { model = 'warrener', price = 100000, banned = false, name = 'Warrener', trunk = 40, type = 'sedans' },
	[GetHashKey('washington')] = { model = 'washington', price = 150000, banned = false, name = 'Washington', trunk = 60, type = 'sedans' },
	[GetHashKey('alpha')] = { model = 'alpha', price = 200000, banned = false, name = 'Alpha', trunk = 40, type = 'outros' },
	[GetHashKey('banshee')] = { model = 'banshee', price = 300000, banned = false, name = 'Banshee', trunk = 30, type = 'outros' },
	[GetHashKey('bestiagts')] = { model = 'bestiagts', price = 400000, banned = false, name = 'Bestiagts', trunk = 60, type = 'outros' },
	[GetHashKey('blista2')] = { model = 'blista2', price = 100000, banned = false, name = 'Blista2', trunk = 40, type = 'outros' },
	[GetHashKey('blista3')] = { model = 'blista3', price = 200000, banned = false, name = 'Blista3', trunk = 40, type = 'outros' },
	[GetHashKey('buffalo')] = { model = 'buffalo', price = 450000, banned = false, name = 'Buffalo', trunk = 50, type = 'outros' },
	[GetHashKey('buffalo2')] = { model = 'buffalo2', price = 450000, banned = false, name = 'Buffalo2', trunk = 30, type = 'outros' },
	[GetHashKey('buffalo3')] = { model = 'buffalo3', price = 400000, banned = false, name = 'Buffalo3', trunk = 50, type = 'outros' },
	[GetHashKey('carbonizzare')] = { model = 'carbonizzare', price = 1500000, banned = false, name = 'Carbonizzare', trunk = 30, type = 'outros' },
	[GetHashKey('comet2')] = { model = 'comet2', price = 400000, banned = false, name = 'Comet2', trunk = 40, type = 'outros' },
	[GetHashKey('comet3')] = { model = 'comet3', price = 500000, banned = false, name = 'Comet3', trunk = 40, type = 'outros' },
	[GetHashKey('comet5')] = { model = 'comet5', price = 1250000, banned = false, name = 'Comet5', trunk = 40, type = 'outros' },
	[GetHashKey('coquette')] = { model = 'coquette', price = 500000, banned = false, name = 'Coquette', trunk = 30, type = 'outros' },
	[GetHashKey('coquette4')] = { model = 'coquette4', price = 8000000, banned = false, name = 'Coquette 4', trunk = 130, type = 'outros' },
	[GetHashKey('elegy')] = { model = 'elegy', price = 500000, banned = false, name = 'Elegy', trunk = 30, type = 'outros' },
	[GetHashKey('elegy2')] = { model = 'elegy2', price = 400000, banned = false, name = 'Elegy2', trunk = 30, type = 'outros' },
	[GetHashKey('feltzer2')] = { model = 'feltzer2', price = 200000, banned = false, name = 'Feltzer2', trunk = 40, type = 'outros' },
	[GetHashKey('furoregt')] = { model = 'furoregt', price = 200000, banned = false, name = 'Furoregt', trunk = 30, type = 'outros' },
	[GetHashKey('fusilade')] = { model = 'fusilade', price = 200000, banned = false, name = 'Fusilade', trunk = 40, type = 'outros' },
	[GetHashKey('futo')] = { model = 'futo', price = 150000, banned = false, name = 'Futo', trunk = 40, type = 'outros' },
	[GetHashKey('jester')] = { model = 'jester', price = 5000000, banned = false, name = 'Jester', trunk = 30, type = 'outros' },
	[GetHashKey('khamelion')] = { model = 'khamelion', price = 1000000, banned = false, name = 'Khamelion', trunk = 50, type = 'outros' },
	[GetHashKey('kuruma2')] = { model = "kuruma2", price = 3000000, banned = false, name = 'Kuruma 2', trunk = 30, type = 'vip' },
	[GetHashKey('kuruma')] = { model = 'kuruma', price = 750000, banned = false, name = 'Kuruma', trunk = 40, type = 'outros' },

	[GetHashKey('massacro')] = { model = 'massacro', price = 750000, banned = false, name = 'Massacro', trunk = 40, type = 'outros' },
	[GetHashKey('massacro2')] = { model = 'massacro2', price = 1000000, banned = false, name = 'Massacro2', trunk = 40, type = 'outros' },
	[GetHashKey('ninef')] = { model = 'ninef', price = 950000, banned = false, name = 'Ninef', trunk = 40, type = 'outros' },
	[GetHashKey('ninef2')] = { model = 'ninef2', price = 950000, banned = false, name = 'Ninef2', trunk = 40, type = 'outros' },
	[GetHashKey('omnis')] = { model = 'omnis', price = 200000, banned = false, name = 'Omnis', trunk = 20, type = 'outros' },
	[GetHashKey('pariah')] = { model = 'pariah', price = 950000, banned = false, name = 'Pariah', trunk = 30, type = 'outros' },
	[GetHashKey('penumbra')] = { model = 'penumbra', price = 800000, banned = false, name = 'Penumbra', trunk = 40, type = 'outros' },
	[GetHashKey('raiden')] = { model = 'raiden', price = 850000, banned = false, name = 'Raiden', trunk = 50, type = 'outros' },
	[GetHashKey('rapidgt')] = { model = 'rapidgt', price = 800000, banned = false, name = 'Rapidgt', trunk = 20, type = 'outros' },
	[GetHashKey('rapidgt2')] = { model = 'rapidgt2', price = 1000000, banned = false, name = 'Rapidgt2', trunk = 20, type = 'outros' },
	[GetHashKey('ruston')] = { model = 'ruston', price = 3000000, banned = false, name = 'Ruston', trunk = 30, type = 'outros' },
	[GetHashKey('schafter3')] = { model = 'schafter3', price = 300000, banned = false, name = 'Schafter3', trunk = 50, type = 'outros' },
	[GetHashKey('schafter4')] = { model = 'schafter4', price = 250000, banned = false, name = 'Schafter4', trunk = 30, type = 'outros' },
	[GetHashKey('schafter5')] = { model = 'schafter5', price = 175000, banned = false, name = 'Schafter5', trunk = 50, type = 'outros' },
	[GetHashKey('schwarzer')] = { model = 'schwarzer', price = 250000, banned = false, name = 'Schwarzer', trunk = 50, type = 'outros' },
	[GetHashKey('sentinel3')] = { model = 'sentinel3', price = 350000, banned = false, name = 'Sentinel3', trunk = 30, type = 'outros' },
	[GetHashKey('seven70')] = { model = 'seven70', price = 1000000, banned = false, name = 'Seven70', trunk = 20, type = 'outros' },
	[GetHashKey('specter')] = { model = 'specter', price = 2000000, banned = false, name = 'Specter', trunk = 20, type = 'outros' },
	[GetHashKey('specter2')] = { model = 'specter2', price = 900000, banned = false, name = 'Specter2', trunk = 20, type = 'outros' },
	[GetHashKey('streiter')] = { model = 'streiter', price = 600000, banned = false, name = 'Streiter', trunk = 70, type = 'outros' },
	[GetHashKey('sultan')] = { model = 'sultan', price = 800000, banned = false, name = 'Sultan', trunk = 50, type = 'outros' },
	[GetHashKey('surano')] = { model = 'surano', price = 1500000, banned = false, name = 'Surano', trunk = 30, type = 'outros' },
	[GetHashKey('tampa2')] = { model = 'tampa2', price = 300000, banned = false, name = 'Tampa2', trunk = 20, type = 'outros' },
	[GetHashKey('tropos')] = { model = 'tropos', price = 450000, banned = false, name = 'Tropos', trunk = 20, type = 'outros' },
	[GetHashKey('verlierer2')] = { model = 'verlierer2', price = 350000, banned = false, name = 'Verlierer2', trunk = 20, type = 'outros' },
	[GetHashKey('btype')] = { model = 'btype', price = 1000000, banned = false, name = 'Btype', trunk = 40, type = 'outros' },
	[GetHashKey('btype2')] = { model = 'btype2', price = 1500000, banned = false, name = 'Btype2', trunk = 20, type = 'outros' },
	[GetHashKey('btype3')] = { model = 'btype3', price = 1000000, banned = false, name = 'Btype3', trunk = 40, type = 'outros' },
	[GetHashKey('casco')] = { model = 'casco', price = 500000, banned = false, name = 'Casco', trunk = 50, type = 'outros' },
	[GetHashKey('cheetah')] = { model = 'cheetah', price = 1000000, banned = false, name = 'Cheetah', trunk = 20, type = 'imports' },
	[GetHashKey('coquette2')] = { model = 'coquette2', price = 400000, banned = false, name = 'Coquette2', trunk = 40, type = 'outros' },
	[GetHashKey('feltzer3')] = { model = 'feltzer3', price = 390000, banned = false, name = 'Feltzer3', trunk = 40, type = 'outros' },
	[GetHashKey('gt500')] = { model = 'gt500', price = 600000, banned = false, name = 'GT500', trunk = 40, type = 'outros' },
	[GetHashKey('infernus2')] = { model = 'infernus2', price = 1000000, banned = false, name = 'Infernus2', trunk = 20, type = 'outros' },
	[GetHashKey('jb700')] = { model = 'jb700', price = 250000, banned = false, name = 'Jb700', trunk = 30, type = 'outros' },
	[GetHashKey('mamba')] = { model = 'mamba', price = 400000, banned = false, name = 'Mamba', trunk = 50, type = 'outros' },
	[GetHashKey('manana')] = { model = 'manana', price = 75000, banned = false, name = 'Manana', trunk = 60, type = 'outros' },
	[GetHashKey('monroe')] = { model = 'monroe', price = 400000, banned = false, name = 'Monroe', trunk = 20, type = 'outros' },
	[GetHashKey('peyote')] = { model = 'peyote', price = 80000, banned = false, name = 'Peyote', trunk = 50, type = 'outros' },
	[GetHashKey('pigalle')] = { model = 'pigalle', price = 80000, banned = false, name = 'Pigalle', trunk = 60, type = 'outros' },
	[GetHashKey('rapidgt3')] = { model = 'rapidgt3', price = 650000, banned = false, name = 'Rapidgt3', trunk = 40, type = 'outros' },
	[GetHashKey('retinue')] = { model = 'retinue', price = 200000, banned = false, name = 'Retinue', trunk = 40, type = 'outros' },
	[GetHashKey('stinger')] = { model = 'stinger', price = 450000, banned = false, name = 'Stinger', trunk = 20, type = 'outros' },
	[GetHashKey('stingergt')] = { model = 'stingergt', price = 400000, banned = false, name = 'Stingergt', trunk = 20, type = 'outros' },
	[GetHashKey('torero')] = { model = 'torero', price = 300000, banned = false, name = 'Torero', trunk = 30, type = 'outros' },
	[GetHashKey('tornado')] = { model = 'tornado', price = 100000, banned = false, name = 'Tornado', trunk = 70, type = 'outros' },
	[GetHashKey('tornado2')] = { model = 'tornado2', price = 300000, banned = false, name = 'Tornado2', trunk = 60, type = 'outros' },
	[GetHashKey('tornado5')] = { model = 'tornado5', price = 500000, banned = false, name = 'Tornado5', trunk = 60, type = 'outros' },
	[GetHashKey('tornado6')] = { model = 'tornado6', price = 800000, banned = false, name = 'Tornado6', trunk = 50, type = 'outros' },
	[GetHashKey('turismo2')] = { model = 'turismo2', price = 1000000, banned = false, name = 'Turismo2', trunk = 30, type = 'outros' },
	[GetHashKey('ztype')] = { model = 'ztype', price = 1000000, banned = false, name = 'Ztype', trunk = 20, type = 'outros' },
	[GetHashKey('adder')] = { model = 'adder', price = 700000, banned = false, name = 'Adder', trunk = 20, type = 'outros' },
	[GetHashKey('autarch')] = { model = 'autarch', price = 3000000, banned = false, name = 'Autarch', trunk = 20, type = 'imports' },
	[GetHashKey('banshee2')] = { model = 'banshee2', price = 700000, banned = false, name = 'Banshee2', trunk = 20, type = 'imports' },
	[GetHashKey('bullet')] = { model = 'bullet', price = 800000, banned = false, name = 'Bullet', trunk = 20, type = 'imports' },
	[GetHashKey('cheetah2')] = { model = 'cheetah2', price = 1000000, banned = false, name = 'Cheetah2', trunk = 20, type = 'outros' },
	[GetHashKey('entityxf')] = { model = 'entityxf', price = 1500000, banned = false, name = 'Entityxf', trunk = 20, type = 'imports' },
	[GetHashKey('fmj')] = { model = 'fmj', price = 1200000, banned = false, name = 'Fmj', trunk = 20, type = 'imports' },
	[GetHashKey('gp1')] = { model = 'gp1', price = 2000000, banned = false, name = 'Gp1', trunk = 20, type = 'imports' },
	[GetHashKey('infernus')] = { model = 'infernus', price = 700000, banned = false, name = 'Infernus', trunk = 20, type = 'imports' },
	[GetHashKey('nero')] = { model = 'nero', price = 4500000, banned = false, name = 'Nero', trunk = 20, type = 'imports' },
	[GetHashKey('nero2')] = { model = 'nero2', price = 3000000, banned = false, name = 'Nero2', trunk = 20, type = 'imports' },
	[GetHashKey('osiris')] = { model = 'osiris', price = 4000000, banned = false, name = 'Osiris', trunk = 20, type = 'imports' },
	[GetHashKey('penetrator')] = { model = 'penetrator', price = 1200000, banned = false, name = 'Penetrator', trunk = 20, type = 'imports' },
	[GetHashKey('pfister811')] = { model = 'pfister811', price = 2000000, banned = false, name = 'Pfister811', trunk = 20, type = 'imports' },
	[GetHashKey('reaper')] = { model = 'reaper', price = 2500000, banned = false, name = 'Reaper', trunk = 20, type = 'imports' },
	[GetHashKey('sc1')] = { model = 'sc1', price = 2500000, banned = false, name = 'Sc1', trunk = 20, type = 'imports' },
	[GetHashKey('sultanrs')] = { model = 'sultanrs', price = 2000000, banned = false, name = 'Sultan RS', trunk = 30, type = 'imports' },
	[GetHashKey('t20')] = { model = 't20', price = 2500000, banned = false, name = 'T20', trunk = 20, type = 'imports' },
	[GetHashKey('tempesta')] = { model = 'tempesta', price = 4000000, banned = false, name = 'Tempesta', trunk = 20, type = 'imports' },
	[GetHashKey('turismor')] = { model = 'turismor', price = 5000000, banned = false, name = 'Turismor', trunk = 20, type = 'imports' },
	[GetHashKey('tyrus')] = { model = 'tyrus', price = 1200000, banned = false, name = 'Tyrus', trunk = 20, type = 'imports' },
	[GetHashKey('vacca')] = { model = 'vacca', price = 1000000, banned = false, name = 'Vacca', trunk = 30, type = 'imports' },
	[GetHashKey('visione')] = { model = 'visione', price = 10000000, banned = false, name = 'Visione', trunk = 20, type = 'imports' },
	[GetHashKey('voltic')] = { model = 'voltic', price = 800000, banned = false, name = 'Voltic', trunk = 20, type = 'imports' },
	[GetHashKey('zentorno')] = { model = 'zentorno', price = 10000000, banned = false, name = 'Zentorno', trunk = 20, type = 'imports' },
	[GetHashKey('sadler')] = { model = 'sadler', price = 1500000, banned = false, name = 'Sadler', trunk = 70, type = 'utility' },
	[GetHashKey('bison')] = { model = 'bison', price = 1000000, banned = false, name = 'Bison', trunk = 70, type = 'outros' },
	[GetHashKey('bison2')] = { model = 'bison2', price = 1000000, banned = false, name = 'Bison2', trunk = 70, type = 'outros' },
	[GetHashKey('bobcatxl')] = { model = 'bobcatxl', price = 650000, banned = false, name = 'Bobcatxl', trunk = 100, type = 'outros' },
	[GetHashKey('burrito')] = { model = 'burrito', price = 2000000, banned = false, name = 'Burrito', trunk = 200, type = 'outros' },
	[GetHashKey('burrito2')] = { model = 'burrito2', price = 3000000, banned = false, name = 'Burrito2', trunk = 300, type = 'outros' },
	[GetHashKey('burrito3')] = { model = 'burrito3', price = 4000000, banned = false, name = 'Burrito3', trunk = 400, type = 'outros' },
	[GetHashKey('burrito4')] = { model = 'burrito4', price = 5000000, banned = false, name = 'Burrito4', trunk = 500, type = 'outros' },
	[GetHashKey('minivan')] = { model = 'minivan', price = 800000, banned = false, name = 'Minivan', trunk = 70, type = 'outros' },
	[GetHashKey('minivan2')] = { model = 'minivan2', price = 5000000, banned = false, name = 'Minivan2', trunk = 60, type = 'outros' },
	[GetHashKey('paradise')] = { model = 'paradise', price = 1000000, banned = false, name = 'Paradise', trunk = 120, type = 'outros' },
	[GetHashKey('pony')] = { model = 'pony', price = 160000, banned = false, name = 'Pony', trunk = 120, type = 'outros' },
	[GetHashKey('pony2')] = { model = 'pony2', price = 2000000, banned = false, name = 'Pony2', trunk = 120, type = 'outros' },
	[GetHashKey('rumpo')] = { model = 'rumpo', price = 1000000, banned = false, name = 'Rumpo', trunk = 120, type = 'outros' },
	[GetHashKey('rumpo2')] = { model = 'rumpo2', price = 160000, banned = false, name = 'Rumpo2', trunk = 120, type = 'outros' },
	[GetHashKey('rumpo3')] = { model = 'rumpo3', price = 2000000, banned = false, name = 'Rumpo3', trunk = 120, type = 'outros' },
	[GetHashKey('speedo')] = { model = 'speedo', price = 500000, banned = false, name = 'Speedo', trunk = 120, type = 'service' },
	[GetHashKey('surfer')] = { model = 'surfer', price = 500000, banned = false, name = 'Surfer', trunk = 80, type = 'outros' },
	[GetHashKey('youga')] = { model = 'youga', price = 1500000, banned = false, name = 'Youga', trunk = 250, type = 'outros' },
	[GetHashKey('youga2')] = { model = 'youga2', price = 750000, banned = false, name = 'Youga2', trunk = 80, type = 'service' },
	[GetHashKey('tractor2')] = { model = 'tractor2', price = 160000, banned = false, name = 'Tractor2', trunk = 80, type = 'service' },
	[GetHashKey('huntley')] = { model = 'huntley', price = 400000, banned = false, name = 'Huntley', trunk = 60, type = 'suvs' },
	[GetHashKey('landstalker')] = { model = 'landstalker', price = 600000, banned = false, name = 'Landstalker', trunk = 70, type = 'suvs' },
	[GetHashKey('landstalker2')] = { model = 'landstalker2', price = 800000, banned = false, name = 'Landstalker 2', trunk = 70, type = 'suvs' },
	[GetHashKey('mesa')] = { model = 'mesa', price = 400000, banned = false, name = 'Mesa', trunk = 50, type = 'suvs' },
	[GetHashKey('patriot')] = { model = 'patriot', price = 800000, banned = false, name = 'Patriot', trunk = 70, type = 'suvs' },
	[GetHashKey('radi')] = { model = 'radi', price = 300000, banned = false, name = 'Radi', trunk = 50, type = 'suvs' },
	[GetHashKey('rocoto')] = { model = 'rocoto', price = 110000, banned = false, name = 'Rocoto', trunk = 60, type = 'suvs' },
	[GetHashKey('tyrant')] = { model = 'tyrant', price = 5000000, banned = false, name = 'Tyrant', trunk = 30, type = 'imports' },
	[GetHashKey('entity2')] = { model = 'entity2', price = 1500000, banned = false, name = 'Entity2', trunk = 20, type = 'imports' },
	[GetHashKey('cheburek')] = { model = 'cheburek', price = 230000, banned = false, name = 'Cheburek', trunk = 50, type = 'outros' },
	[GetHashKey('hotring')] = { model = 'hotring', price = 500000, banned = false, name = 'Hotring', trunk = 60, type = 'outros' },
	[GetHashKey('jester2')] = { model = "jester2", price = 1000000, banned = false, name = 'Jester 2', trunk = 30, type = 'imports'},
	[GetHashKey('jester3')] = { model = 'jester3', price = 1000000, banned = false, name = 'Jester3', trunk = 30, type = 'outros' },
	[GetHashKey('flashgt')] = { model = 'flashgt', price = 700000, banned = false, name = 'Flashgt', trunk = 30, type = 'outros' },
	[GetHashKey('ellie')] = { model = 'ellie', price = 400000, banned = false, name = 'Ellie', trunk = 50, type = 'outros' },
	[GetHashKey('michelli')] = { model = 'michelli', price = 200000, banned = false, name = 'Michelli', trunk = 40, type = 'outros' },
	[GetHashKey('fagaloa')] = { model = 'fagaloa', price = 100000, banned = false, name = 'Fagaloa', trunk = 80, type = 'outros' },
	[GetHashKey('dominator3')] = { model = 'dominator3', price = 400000, banned = false, name = 'Dominator3', trunk = 30, type = 'outros' },
	[GetHashKey('issi3')] = { model = 'issi3', price = 100000, banned = false, name = 'Issi3', trunk = 20, type = 'outros' },
	[GetHashKey('taipan')] = { model = 'taipan', price = 2000000, banned = false, name = 'Taipan', trunk = 20, type = 'imports' },
	[GetHashKey('gb200')] = { model = 'gb200', price = 500000, banned = false, name = 'Gb200', trunk = 20, type = 'outros' },
	[GetHashKey('guardian')] = { model = 'guardian', price = 5000000, banned = false, name = 'Guardian', trunk = 150, type = 'industrial' },
	[GetHashKey('kamacho')] = { model = 'kamacho', price = 1500000, banned = false, name = 'Kamacho', trunk = 90, type = 'suvs' },
	[GetHashKey('neon')] = { model = 'neon', price = 2000000, banned = false, name = 'Neon', trunk = 30, type = 'outros' },
	[GetHashKey('cyclone')] = { model = 'cyclone', price = 1000000, banned = false, name = 'Cyclone', trunk = 20, type = 'imports' },
	[GetHashKey('italigtb')] = { model = 'italigtb', price = 1000000, banned = false, name = 'Italigtb', trunk = 20, type = 'imports' },
	[GetHashKey('italigtb2')] = { model = 'italigtb2', price = 1500000, banned = false, name = 'Italigtb2', trunk = 20, type = 'imports' },
	[GetHashKey('vagner')] = { model = 'vagner', price = 2000000, banned = false, name = 'Vagner', trunk = 20, type = 'imports' },
	[GetHashKey('xa21')] = { model = 'xa21', price = 10000000, banned = false, name = 'Xa21', trunk = 20, type = 'imports' },
	[GetHashKey('tezeract')] = { model = 'tezeract', price = 7000000, banned = false, name = 'Tezeract', trunk = 20, type = 'outros' },
	[GetHashKey('prototipo')] = { model = 'prototipo', price = 10000000, banned = false, name = 'Prototipo', trunk = 20, type = 'imports' },
	[GetHashKey('patriot2')] = { model = 'patriot2', price = 5000000, banned = false, name = 'Patriot2', trunk = 60, type = 'suvs' },
	[GetHashKey('stafford')] = { model = 'stafford', price = 200000, banned = false, name = 'Stafford', trunk = 40, type = 'sedans' },
	[GetHashKey('swinger')] = { model = 'swinger', price = 550000, banned = false, name = 'Swinger', trunk = 20, type = 'outros' },
	[GetHashKey('clique')] = { model = 'clique', price = 200000, banned = false, name = 'Clique', trunk = 40, type = 'outros' },
	[GetHashKey('deveste')] = { model = 'deveste', price = 2000000, banned = false, name = 'Deveste', trunk = 20, type = 'outros' },
	[GetHashKey('deviant')] = { model = 'deviant', price = 1000000, banned = false, name = 'Deviant', trunk = 50, type = 'outros' },
	[GetHashKey('impaler')] = { model = 'impaler', price = 1300000, banned = false, name = 'Impaler', trunk = 60, type = 'outros' },
	[GetHashKey('italigto')] = { model = 'italigto', price = 5000000, banned = false, name = 'Italigto', trunk = 30, type = 'outros' },
	[GetHashKey('schlagen')] = { model = 'schlagen', price = 500000, banned = false, name = 'Schlagen', trunk = 30, type = 'outros' },
	[GetHashKey('toros')] = { model = 'toros', price = 5000000, banned = false, name = 'Toros', trunk = 50, type = 'suvs' },
	[GetHashKey('tulip')] = { model = 'tulip', price = 850000, banned = false, name = 'Tulip', trunk = 60, type = 'outros' },
	[GetHashKey('vamos')] = { model = 'vamos', price = 900000, banned = false, name = 'Vamos', trunk = 60, type = 'outros' },
	[GetHashKey('freecrawler')] = { model = 'freecrawler', price = 900000, banned = false, name = 'Freecrawler', trunk = 50, type = 'suvs' },
	[GetHashKey('fugitive')] = { model = 'fugitive', price = 190000, banned = false, name = 'Fugitive', trunk = 30, type = 'sedans' },
	[GetHashKey('le7b')] = { model = 'le7b', price = 3000000, banned = false, name = 'Le7b', trunk = 20, type = 'imports' },
	[GetHashKey('lurcher')] = { model = 'lurcher', price = 200000, banned = false, name = 'Lurcher', trunk = 60, type = 'outros' },
	[GetHashKey('lynx')] = { model = 'lynx', price = 800000, banned = false, name = 'Lynx', trunk = 30, type = 'outros' },
	[GetHashKey('raptor')] = { model = 'raptor', price = 1000000, banned = false, name = 'Raptor', trunk = 20, type = 'outros' },
	[GetHashKey('sheava')] = { model = 'sheava', price = 4000000, banned = false, name = 'Sheava', trunk = 20, type = 'imports' },
	[GetHashKey('z190')] = { model = 'z190', price = 400000, banned = false, name = 'Z190', trunk = 40, type = 'outros' },
	[GetHashKey('akuma')] = { model = 'akuma', price = 2000000, banned = false, name = 'Akuma', trunk = 15, type = 'motos' },
	[GetHashKey('avarus')] = { model = 'avarus', price = 200000, banned = false, name = 'Avarus', trunk = 15, type = 'motos' },
	[GetHashKey('bagger')] = { model = 'bagger', price = 200000, banned = false, name = 'Bagger', trunk = 40, type = 'motos' },
	[GetHashKey('bati')] = { model = 'bati', price = 1000000, banned = false, name = 'Bati', trunk = 15, type = 'motos' },
	[GetHashKey('bati2')] = { model = 'bati2', price = 800000, banned = false, name = 'Bati2', trunk = 15, type = 'motos' },
	[GetHashKey('bf400')] = { model = 'bf400', price = 1000000, banned = false, name = 'Bf400', trunk = 15, type = 'motos' },
	[GetHashKey('carbonrs')] = { model = 'carbonrs', price = 800000, banned = false, name = 'Carbonrs', trunk = 15, type = 'motos' },
	[GetHashKey('chimera')] = { model = 'chimera', price = 400000, banned = false, name = 'Chimera', trunk = 15, type = 'motos' },
	[GetHashKey('cliffhanger')] = { model = 'cliffhanger', price = 250000, banned = false, name = 'Cliffhanger', trunk = 15, type = 'motos' },
	[GetHashKey('daemon')] = { model = 'daemon', price = 200000, banned = false, name = 'Daemon', trunk = 15, type = 'motos' },
	[GetHashKey('daemon2')] = { model = 'daemon2', price = 200000, banned = false, name = 'Daemon2', trunk = 15, type = 'motos' },
	[GetHashKey('defiler')] = { model = 'defiler', price = 700000, banned = false, name = 'Defiler', trunk = 15, type = 'motos' },
	[GetHashKey('diablous')] = { model = 'diablous', price = 500000, banned = false, name = 'Diablous', trunk = 15, type = 'motos' },
	[GetHashKey('diablous2')] = { model = 'diablous2', price = 700000, banned = false, name = 'Diablous2', trunk = 15, type = 'motos' },
	[GetHashKey('double')] = { model = 'double', price = 800000, banned = false, name = 'Double', trunk = 15, type = 'motos' },
	[GetHashKey('enduro')] = { model = 'enduro', price = 400000, banned = false, name = 'Enduro', trunk = 15, type = 'motos' },
	[GetHashKey('esskey')] = { model = 'esskey', price = 400000, banned = false, name = 'Esskey', trunk = 15, type = 'motos' },
	[GetHashKey('faggio')] = { model = 'faggio', price = 4000, banned = false, name = 'Faggio', trunk = 30, type = 'motos' },
	[GetHashKey('faggio2')] = { model = 'faggio2', price = 5000, banned = false, name = 'Faggio2', trunk = 30, type = 'motos' },
	[GetHashKey('faggio3')] = { model = 'faggio3', price = 5000, banned = false, name = 'Faggio3', trunk = 30, type = 'motos' },
	[GetHashKey('fcr')] = { model = 'fcr', price = 300000, banned = false, name = 'Fcr', trunk = 15, type = 'motos' },
	[GetHashKey('fcr2')] = { model = 'fcr2', price = 400000, banned = false, name = 'Fcr2', trunk = 15, type = 'motos' },
	[GetHashKey('gargoyle')] = { model = 'gargoyle', price = 450000, banned = false, name = 'Gargoyle', trunk = 15, type = 'motos' },
	[GetHashKey('hakuchou')] = { model = 'hakuchou', price = 3000000, banned = false, name = 'Hakuchou', trunk = 15, type = 'motos' },
	[GetHashKey('hakuchou2')] = { model = 'hakuchou2', price = 1000000, banned = false, name = 'Hakuchou2', trunk = 15, type = 'motos' },
	[GetHashKey('hexer')] = { model = 'hexer', price = 200000, banned = false, name = 'Hexer', trunk = 15, type = 'motos' },
	[GetHashKey('innovation')] = { model = 'innovation', price = 200000, banned = false, name = 'Innovation', trunk = 15, type = 'motos' },
	[GetHashKey('lectro')] = { model = 'lectro', price = 200000, banned = false, name = 'Lectro', trunk = 15, type = 'motos' },
	[GetHashKey('manchez')] = { model = 'manchez', price = 800000, banned = false, name = 'Manchez', trunk = 15, type = 'motos' },
	[GetHashKey('nemesis')] = { model = 'nemesis', price = 250000, banned = false, name = 'Nemesis', trunk = 15, type = 'motos' },
	[GetHashKey('nightblade')] = { model = 'nightblade', price = 800000, banned = false, name = 'Nightblade', trunk = 15, type = 'outros' },
	[GetHashKey('pcj')] = { model = 'pcj', price = 300000, banned = false, name = 'Pcj', trunk = 15, type = 'motos' },
	[GetHashKey('ruffian')] = { model = 'ruffian', price = 450000, banned = false, name = 'Ruffian', trunk = 15, type = 'motos' },
	[GetHashKey('sanchez')] = { model = 'sanchez', price = 400000, banned = false, name = 'Sanchez', trunk = 15, type = 'motos' },
	[GetHashKey('sanchez2')] = { model = 'sanchez2', price = 500000, banned = false, name = 'Sanchez2', trunk = 15, type = 'motos' },
	[GetHashKey('sanctus')] = { model = 'sanctus', price = 400000, banned = false, name = 'Sanctus', trunk = 15, type = 'motos' },
	[GetHashKey('sovereign')] = { model = 'sovereign', price = 1500000, banned = false, name = 'Sovereign', trunk = 50, type = 'motos' },
	[GetHashKey('thrust')] = { model = 'thrust', price = 650000, banned = false, name = 'Thrust', trunk = 15, type = 'motos' },
	[GetHashKey('vader')] = { model = 'vader', price = 400000, banned = false, name = 'Vader', trunk = 15, type = 'motos' },
	[GetHashKey('vindicator')] = { model = 'vindicator', price = 1000000, banned = false, name = 'Vindicator', trunk = 15, type = 'motos' },
	[GetHashKey('vortex')] = { model = 'vortex', price = 800000, banned = false, name = 'Vortex', trunk = 15, type = 'motos' },
	[GetHashKey('wolfsbane')] = { model = 'wolfsbane', price = 400000, banned = false, name = 'Wolfsbane', trunk = 15, type = 'motos' },
	[GetHashKey('zombiea')] = { model = 'zombiea', price = 250000, banned = false, name = 'Zombiea', trunk = 15, type = 'motos' },
	[GetHashKey('zombieb')] = { model = 'zombieb', price = 250000, banned = false, name = 'Zombieb', trunk = 15, type = 'motos' },
	[GetHashKey('blazer')] = { model = 'blazer', price = 750000, banned = false, name = 'Blazer', trunk = 15, type = 'motos' },
	[GetHashKey('blazer4')] = { model = 'blazer4', price = 800000, banned = false, name = 'Blazer4', trunk = 15, type = 'motos' },
	[GetHashKey('shotaro')] = { model = 'shotaro', price = 2000000, banned = false, name = 'Shotaro', trunk = 30, type = 'motos' },
	[GetHashKey('ratbike')] = { model = 'ratbike', price = 200000, banned = false, name = 'Ratbike', trunk = 30, type = 'motos' },
	[GetHashKey('policiaheli')] = { model = 'policiaheli', price = 1000000, banned = false, name = 'Policia Helicóptero', trunk = 0, type = 'service' },
	[GetHashKey('fbi2')] = { model = 'fbi2', price = 1000000, banned = false, name = 'Granger SOG', trunk = 0, type = 'service' },
	[GetHashKey('policeb')] = { model = 'policeb', price = 1000000, banned = false, name = 'Harley Davidson', trunk = 0, type = 'service' },
	[GetHashKey('paramedicoambu')] = { model = 'paramedicoambu', price = 1000000, banned = false, name = 'Ambulância', trunk = 0, type = 'service' },
	[GetHashKey('paramedicocharger2014')] = { model = 'paramedicocharger2014', price = 1000000, banned = false, name = 'Dodge Charger 2014', trunk = 0, type = 'service' },
	[GetHashKey('pbus')] = { model = 'pbus', price = 1000000, banned = false, name = 'Ônibus da Penitenciária', trunk = 0, type = 'service' },
	[GetHashKey('mule4')] = { model = 'mule4', price = 4000000, banned = false, name = 'Mule 4', trunk = 400, type = 'outros' },
	[GetHashKey('rallytruck')] = { model = 'rallytruck', price = 20000000, banned = false, name = 'RallyTruck', trunk = 2000, type = 'vip' },
	[GetHashKey('bus')] = { model = 'bus', price = 1000000, banned = false, name = 'Ônibus', trunk = 0, type = 'service' },
	[GetHashKey('flatbed')] = { model = 'flatbed', price = 1000000, banned = false, name = 'Reboque', trunk = 0, type = 'service' },
	[GetHashKey('towtruck')] = { model = 'towtruck', price = 1000000, banned = false, name = 'Towtruck', trunk = 0, type = 'service' },
	[GetHashKey('towtruck2')] = { model = 'towtruck2', price = 1000000, banned = false, name = 'Towtruck2', trunk = 0, type = 'service' },
	[GetHashKey('ratloader')] = { model = 'ratloader', price = 1000000, banned = false, name = 'Caminhão', trunk = 80, type = 'service' },
	[GetHashKey('ratloader2')] = { model = 'ratloader2', price = 180000, banned = false, name = 'Ratloader2', trunk = 70, type = 'outros' },
	[GetHashKey('rubble')] = { model = 'rubble', price = 1000000, banned = false, name = 'Caminhão', trunk = 100, type = 'service' },
	[GetHashKey('taxi')] = { model = 'taxi', price = 1000000, banned = false, name = 'Taxi', trunk = 0, type = 'service' },
	[GetHashKey('boxville4')] = { model = 'boxville4', price = 1000000, banned = false, name = 'Caminhão', trunk = 70, type = 'service' },
	[GetHashKey('trash2')] = { model = 'trash2', price = 1000000, banned = false, name = 'Caminhão', trunk = 100, type = 'service' },
	[GetHashKey('tiptruck')] = { model = 'tiptruck', price = 1000000, banned = false, name = 'Tiptruck', trunk = 100, type = 'service' },
	[GetHashKey('scorcher')] = { model = 'scorcher', price = 1000000, banned = false, name = 'Scorcher', trunk = 0, type = 'service' },
	[GetHashKey('tribike')] = { model = 'tribike', price = 1000000, banned = false, name = 'Tribike', trunk = 0, type = 'service' },
	[GetHashKey('tribike2')] = { model = 'tribike2', price = 1000000, banned = false, name = 'Tribike2', trunk = 0, type = 'service' },
	[GetHashKey('tribike3')] = { model = 'tribike3', price = 1000000, banned = false, name = 'Tribike3', trunk = 0, type = 'service' },
	[GetHashKey('fixter')] = { model = 'fixter', price = 1000000, banned = false, name = 'Fixter', trunk = 0, type = 'service' },
	[GetHashKey('cruiser')] = { model = 'cruiser', price = 1000000, banned = false, name = 'Cruiser', trunk = 0, type = 'service' },
	[GetHashKey('bmx')] = { model = 'bmx', price = 1000000, banned = false, name = 'Bmx', trunk = 100, type = 'service' },
	[GetHashKey('dinghy')] = { model = 'dinghy', price = 1000000, banned = false, name = 'Dinghy', trunk = 100, type = 'vip' },
	[GetHashKey('jetmax')] = { model = 'jetmax', price = 1000000, banned = false, name = 'Jetmax', trunk = 100, type = 'vip' },
	[GetHashKey('marquis')] = { model = 'marquis', price = 1000000, banned = false, name = 'Marquis', trunk = 100, type = 'vip' },
	[GetHashKey('seashark3')] = { model = 'seashark3', price = 1000000, banned = false, name = 'Seashark3', trunk = 100, type = 'vip' },
	[GetHashKey('speeder')] = { model = 'speeder', price = 1000000, banned = false, name = 'Speeder', trunk = 100, type = 'vip' },
	[GetHashKey('speeder2')] = { model = 'speeder2', price = 1000000, banned = false, name = 'Speeder2', trunk = 100, type = 'vip' },
	[GetHashKey('squalo')] = { model = 'squalo', price = 1000000, banned = false, name = 'Squalo', trunk = 100, type = 'vip' },
	[GetHashKey('suntrap')] = { model = 'suntrap', price = 1000000, banned = false, name = 'Suntrap', trunk = 100, type = 'vip' },
	[GetHashKey('toro')] = { model = 'toro', price = 1000000, banned = false, name = 'Toro', trunk = 100, type = 'vip' },
	[GetHashKey('toro2')] = { model = 'toro2', price = 1000000, banned = false, name = 'Toro2', trunk = 100, type = 'vip' },
	[GetHashKey('tropic')] = { model = 'tropic', price = 1000000, banned = false, name = 'Tropic', trunk = 100, type = 'vip' },
	[GetHashKey('tropic2')] = { model = 'tropic2', price = 1000000, banned = false, name = 'Tropic2', trunk = 100, type = 'vip' },
	[GetHashKey('yacht2')] = { model = 'yacht2', price = 1000000, banned = false, name = 'yacht2', trunk = 100, type = 'vip' },
	[GetHashKey('phantom')] = { model = 'phantom', price = 1000000, banned = false, name = 'Phantom', trunk = 0, type = 'service' },
	[GetHashKey('packer')] = { model = 'packer', price = 800000, banned = false, name = 'Packer', trunk = 100, type = 'service' },
	[GetHashKey('importsvolito')] = { model = 'importsvolito', price = 1000000, banned = false, name = 'importsvolito', trunk = 100, type = 'vip' },
	[GetHashKey('importsvolito2')] = { model = 'importsvolito2', price = 1000000, banned = false, name = 'importsvolito2', trunk = 100, type = 'vip' },
	[GetHashKey('seasparrow')] = { model = 'seasparrow', price = 1000000, banned = false, name = 'Paramédico Helicóptero Água', trunk = 0, type = 'service' },
	[GetHashKey('cuban800')] = { model = 'cuban800', price = 1000000, banned = false, name = 'Cuban800', trunk = 100, type = 'vip' },
	[GetHashKey('mammatus')] = { model = 'mammatus', price = 1000000, banned = false, name = 'Mammatus', trunk = 100, type = 'vip' },
	[GetHashKey('vestra')] = { model = 'vestra', price = 1000000, banned = false, name = 'Vestra', trunk = 100, type = 'vip' },
	[GetHashKey('velum2')] = { model = 'velum2', price = 1000000, banned = false, name = 'Velum2', trunk = 100, type = 'vip' },
	[GetHashKey('buzzard2')] = { model = 'buzzard2', price = 1000000, banned = false, name = 'Buzzard2', trunk = 100, type = 'vip' },
	[GetHashKey('maverick')] = { model = 'maverick', price = 1000000, banned = false, name = 'Maverick', trunk = 0, type = 'service' },
	[GetHashKey('tanker2')] = { model = 'tanker2', price = 1000000, banned = false, name = 'Gas', trunk = 0, type = 'service' },
	[GetHashKey('armytanker')] = { model = 'armytanker', price = 1000000, banned = false, name = 'Diesel', trunk = 0, type = 'service' },
	[GetHashKey('tvtrailer')] = { model = 'tvtrailer', price = 1000000, banned = false, name = 'Show', trunk = 0, type = 'service' },
	[GetHashKey('trailerlogs')] = { model = 'trailerlogs', price = 1000000, banned = false, name = 'Woods', trunk = 0, type = 'service' },
	[GetHashKey('tr4')] = { model = 'tr4', price = 1000000, banned = false, name = 'Cars', trunk = 0, type = 'service' },
	[GetHashKey('nissangtr')] = { model = 'nissangtr', price = 3000000, banned = false, name = 'Nissan GTR', trunk = 100, type = 'vip' },
	[GetHashKey('weevil')] = { model = 'weevil', price = 150000, banned = false, name = 'Fusca', trunk = 150, type = 'vip' },
	[GetHashKey('nissan370z')] = { model = 'nissan370z', price = 1000000, banned = false, name = 'Nissan 370Z', trunk = 40, type = 'vip' },
	[GetHashKey('dodgechargersrt')] = { model = 'dodgechargersrt', price = 2000000, banned = false, name = 'Dodge Charger SRT', trunk = 50, type = 'import' },
	[GetHashKey('14r8')] = { model = '14r8', price = 1000000, banned = false, name = 'Audi R8 2014', trunk = 30, type = 'vip' },
	[GetHashKey('bmwm3f80')] = { model = 'bmwm3f80', price = 1350000, banned = false, name = 'BMW M3 F80', trunk = 50, type = 'import' },
	[GetHashKey('nissangtrnismo')] = { model = 'nissangtrnismo', price = 2900000, banned = false, name = 'Nissan GTR Nismo', trunk = 40, type = 'vip' },
	
	[GetHashKey('seasparrow2')] = { model = 'seasparrow2', price = 1500000, banned = false, name = 'Sea Sparrow2', trunk = 30, type = 'vip' },
	[GetHashKey('mule')] = { model = 'mule', price = 1500000, banned = false, name = 'Mule', trunk = 1000, type = 'vip' },

	[GetHashKey('mercedesa45')] = { model = 'mercedesa45', price = 1200000, banned = false, name = 'Mercedes A45', trunk = 40, type = 'import' },
	[GetHashKey('rcbandito')] = { model = 'rcbandito', price = 1200000, banned = false, name = 'Mini carro', trunk = 10, type = 'vip' },
	[GetHashKey('focusrs')] = { model = 'focusrs', price = 1000000, banned = false, name = 'Focus RS', trunk = 40, type = 'import' },
	[GetHashKey('lancerevolution9')] = { model = 'lancerevolution9', price = 1400000, banned = false, name = 'Lancer Evolution 9', trunk = 50, type = 'import' },
	[GetHashKey('ninjah2')] = { model = 'ninjah2', price = 1000000, banned = false, name = 'Ninja H2', trunk = 15, type = 'vip' },
	[GetHashKey('trr')] = { model = 'trr', price = 1000000, banned = false, name = 'KTM TRR', trunk = 15, type = 'vip' },
	[GetHashKey('p1')] = { model = 'p1', price = 1000000, banned = false, name = 'Mclaren P1', trunk = 20, type = 'vip' },
	[GetHashKey('i8')] = { model = 'i8', price = 1000000, banned = false, name = 'BMW i8', trunk = 35, type = 'vip' },
	[GetHashKey('bme6tun')] = { model = 'bme6tun', price = 1000000, banned = false, name = 'BMW M5', trunk = 50, type = 'vip' },
	[GetHashKey('aperta')] = { model = 'aperta', price = 1000000, banned = false, name = 'La Ferrari', trunk = 20, type = 'vip' },
	[GetHashKey('bettle')] = { model = 'bettle', price = 1000000, banned = false, name = 'New Bettle', trunk = 35, type = 'vip' },
	[GetHashKey('senna')] = { model = 'senna', price = 1000000, banned = false, name = 'Mclaren Senna', trunk = 20, type = 'vip' },
	[GetHashKey('bnteam')] = { model = 'bnteam', price = 1000000, banned = false, name = 'Bentley', trunk = 20, type = 'vip' },
	[GetHashKey('rmodlp770')] = { model = 'rmodlp770', price = 1000000, banned = false, name = 'Lamborghini Centenario', trunk = 20, type = 'vip' },
	[GetHashKey('s15')] = { model = 's15', price = 1000000, banned = false, name = 'Nissan Silvia S15', trunk = 20, type = 'vip' },
	[GetHashKey('amggtr')] = { model = 'amggtr', price = 1000000, banned = false, name = 'Mercedes AMG', trunk = 20, type = 'vip' },
	[GetHashKey('lamtmc')] = { model = 'lamtmc', price = 1000000, banned = false, name = 'Lamborghini Terzo', trunk = 20, type = 'vip' },
	[GetHashKey('vantage')] = { model = 'vantage', price = 1000000, banned = false, name = 'Aston Martin Vantage', trunk = 20, type = 'vip' },
	[GetHashKey('slsamg')] = { model = 'slsamg', price = 1000000, banned = false, name = 'Mercedes SLS', trunk = 20, type = 'vip' },
	[GetHashKey('g65amg')] = { model = 'g65amg', price = 1000000, banned = false, name = 'Mercedes G65', trunk = 0, type = 'vip' },
	[GetHashKey('celta')] = { model = 'celta', price = 30000, banned = false, name = 'Celta Paredão', trunk = 0, type = 'vip' },
	[GetHashKey('eleanor')] = { model = 'eleanor', price = 1000000, banned = false, name = 'Mustang Eleanor', trunk = 30, type = 'vip' },
	[GetHashKey('rmodamgc63')] = { model = 'rmodamgc63', price = 1000000, banned = false, name = 'Mercedes AMG C63', trunk = 40, type = 'vip' },
	[GetHashKey('palameila')] = { model = 'palameila', price = 1000000, banned = false, name = 'Porsche Pamodelra', trunk = 50, type = 'vip' },
	[GetHashKey('cb500x')] = { model = 'cb500x', price = 1000000, banned = false, name = 'Honda CB500', trunk = 15, type = 'vip' },
	[GetHashKey('rsvr16')] = { model = 'rsvr16', price = 1000000, banned = false, name = 'Ranger Rover', trunk = 50, type = 'vip' },
	[GetHashKey('19ramdonk')] = { model = '19ramdonk', price = 1000000, banned = false, name = 'Dodge Ram Donk', trunk = 80, type = 'vip' },
	[GetHashKey('silv86')] = { model = 'silv86', price = 1000000, banned = false, name = 'Silverado Donk', trunk = 80, type = 'vip' },
	[GetHashKey('bc')] = { model = 'bc', price = 1000000, banned = false, name = 'Pagani Huayra', trunk = 20, type = 'vip' },
	[GetHashKey('70camarofn')] = { model = '70camarofn', price = 1000000, banned = false, name = 'camaro Z28 1970', trunk = 20, type = 'vip' },
	[GetHashKey('bbentayga')] = { model = 'bbentayga', price = 1000000, banned = false, name = 'Bentley Bentayga', trunk = 50, type = 'vip' },
	[GetHashKey('nissantitan17')] = { model = 'nissantitan17', price = 1000000, banned = false, name = 'Nissan Titan 2017', trunk = 120, type = 'vip' },
	[GetHashKey('regera')] = { model = 'regera', price = 1000000, banned = false, name = 'Koenigsegg Regera', trunk = 20, type = 'vip' },
	[GetHashKey('msohs')] = { model = 'msohs', price = 1000000, banned = false, name = 'Mclaren 688 HS', trunk = 20, type = 'vip' },
	[GetHashKey('gt17')] = { model = 'gt17', price = 1000000, banned = false, name = 'Ford GT 17', trunk = 20, type = 'vip' },
	[GetHashKey('19ftype')] = { model = '19ftype', price = 1000000, banned = false, name = 'Jaguar F-Type', trunk = 50, type = 'vip' },
	[GetHashKey('488gtb')] = { model = '488gtb', price = 1000000, banned = false, name = 'Ferrari 488 GTB', trunk = 30, type = 'vip' },
	[GetHashKey('m2')] = { model = 'm2', price = 1000000, banned = false, name = 'BMW M2', trunk = 50, type = 'vip' },
	[GetHashKey('defiant')] = { model = 'defiant', price = 1000000, banned = false, name = 'AMC Javelin 72', trunk = 40, type = 'vip' },
	[GetHashKey('f12tdf')] = { model = 'f12tdf', price = 1000000, banned = false, name = 'Ferrari F12 TDF', trunk = 20, type = 'vip' },
	[GetHashKey('71gtx')] = { model = '71gtx', price = 1000000, banned = false, name = 'Plymouth 71 GTX', trunk = 50, type = 'vip' },
	[GetHashKey('porsche992')] = { model = 'porsche992', price = 1000000, banned = false, name = 'Porsche 992', trunk = 20, type = 'vip' },
	[GetHashKey('18macan')] = { model = '18macan', price = 1000000, banned = false, name = 'Porsche Macan', trunk = 60, type = 'vip' },
	[GetHashKey('m6e63')] = { model = 'm6e63', price = 1000000, banned = false, name = 'BMW M6 E63', trunk = 50, type = 'vip' },
	[GetHashKey('180sx')] = { model = '180sx', price = 1000000, banned = false, name = 'Nissan 180SX', trunk = 10, type = 'vip' },
	[GetHashKey('hondafk8')] = { model = 'hondafk8', price = 1700000, banned = false, name = 'Honda FK8', trunk = 40, type = 'import' },
	[GetHashKey('mustangmach1')] = { model = 'mustangmach1', price = 1100000, banned = false, name = 'Mustang Mach 1', trunk = 40, type = 'import' },
	[GetHashKey('porsche930')] = { model = 'porsche930', price = 1300000, banned = false, name = 'Porsche 930', trunk = 20, type = 'import' },
	[GetHashKey('raptor2017')] = { model = 'raptor2017', price = 2000000, banned = false, name = 'Ford Raptor 2017', trunk = 150, type = 'vip' },
	[GetHashKey('filthynsx')] = { model = 'filthynsx', price = 1000000, banned = false, name = 'Honda NSX', trunk = 20, type = 'vip' },
	[GetHashKey('2018zl1')] = { model = '2018zl1', price = 1000000, banned = false, name = 'Camaro ZL1', trunk = 40, type = 'vip' },
	[GetHashKey('eclipse')] = { model = 'eclipse', price = 1000000, banned = false, name = 'Mitsubishi Eclipse', trunk = 30, type = 'vip' },
	[GetHashKey('lp700r')] = { model = 'lp700r', price = 1000000, banned = false, name = 'Lamborghini LP700R', trunk = 0, type = 'vip' },
	[GetHashKey('db11')] = { model = 'db11', price = 1000000, banned = false, name = 'Aston Martin DB11', trunk = 0, type = 'vip' },
	[GetHashKey('beetle74')] = { model = 'beetle74', price = 500000, banned = false, name = 'Fusca 74', trunk = 40, type = 'import' },
	[GetHashKey('fe86')] = { model = 'fe86', price = 500000, banned = false, name = 'Escorte', trunk = 40, type = 'import' },
	[GetHashKey('type263')] = { model = 'type263', price = 500000, banned = false, name = 'Kombi 63', trunk = 60, type = 'import' },
	[GetHashKey('pistas')] = { model = 'pistas', price = 1000000, banned = false, name = 'Ferrari Pista', trunk = 30, type = 'vip' },
	[GetHashKey('yzfr125')] = { model = 'yzfr125', price = 1000000, banned = false, name = 'Yamaha YZF R125', trunk = 10, type = 'vip' },
	[GetHashKey('mt03')] = { model = 'mt03', price = 1000000, banned = false, name = 'Yamaha MT 03', trunk = 10, type = 'vip' },
	[GetHashKey('flatbed3')] = { model = 'flatbed3', price = 1000000, banned = false, name = 'flatbed3', trunk = 0, type = 'service' },
	[GetHashKey('20r1')] = { model = '20r1', price = 1000000, banned = false, name = 'Yamaha YZF R1', trunk = 10, type = 'vip' },
	[GetHashKey('SVR14')] = { model = 'SVR14', price = 1000000, banned = false, name = 'Ranger Rover', trunk = 50, type = 'vip' },
	[GetHashKey('Bimota')] = { model = 'Bimota', price = 1000000, banned = false, name = 'Ducati Bimota', trunk = 10, type = 'vip' },
	[GetHashKey('r8ppi')] = { model = 'r8ppi', price = 1000000, banned = false, name = 'Audi R8 PPI Razor', trunk = 30, type = 'vip' },
	[GetHashKey('bobbes2')] = { model = 'bobbes2', price = 1000000, banned = false, name = 'Harley D. Bobber S', trunk = 15, type = 'vip' },
	[GetHashKey('bobber')] = { model = 'bobber', price = 1000000, banned = false, name = 'Harley D. Bobber ', trunk = 15, type = 'vip' },
	[GetHashKey('911tbs')] = { model = '911tbs', price = 1000000, banned = false, name = 'Porsche 911S', trunk = 25, type = 'vip' },
	[GetHashKey('rc')] = { model = 'rc', price = 1000000, banned = false, name = 'KTM RC', trunk = 15, type = 'vip' },
	[GetHashKey('brutus')] = { model = 'brutus', price = 1500000, banned = false, name = 'Brutus', trunk = 2000, type = 'vip' },
	[GetHashKey('cargobob2')] = { model = 'cargobob2', price = 1000000, banned = false, name = 'Cargo Bob', trunk = 0, type = 'service' },
	[GetHashKey('cargobob')] = { model = 'cargobob', price = 1500000, banned = false, name = 'CargoBob', trunk = 50, type = 'vip' },
	[GetHashKey('zx10r')] = { model = 'zx10r', price = 1000000, banned = false, name = 'Kawasaki ZX10R', trunk = 20, type = 'vip' },
	
}

garagesConfig.typeGarages = {	

	['garagemLS'] = {
        type = "service", -- [ public / service ]

        blip = {
			showBlip = false, -- Exibir BLIP
            name = 'Garagem', -- Nome do BLIP
            blipId = 357, -- ID DO BLIP = https://docs.fivem.net/docs/game-references/blips/
            blipColor = 0, -- Cor do BLIP
            blipScale = 0.5, -- Tamanho do Blip
        },  

        vehicles = {
            {vehicle = 'bison2'}
        },
    },

	['garagemPrisao'] = {
        type = "service", -- [ public / service ]

        blip = {
			showBlip = false, -- Exibir BLIP
            name = 'Garagem', -- Nome do BLIP
            blipId = 357, -- ID DO BLIP = https://docs.fivem.net/docs/game-references/blips/
            blipColor = 0, -- Cor do BLIP
            blipScale = 0.5, -- Tamanho do Blip
        },  

        vehicles = {
            {vehicle = 'blazer'}
        },
    },

	['garagemAeroporto'] = {
        type = "service", -- [ public / service ]

        blip = {
			showBlip = false, -- Exibir BLIP
            name = 'Garagem', -- Nome do BLIP
            blipId = 357, -- ID DO BLIP = https://docs.fivem.net/docs/game-references/blips/
            blipColor = 0, -- Cor do BLIP
            blipScale = 0.5, -- Tamanho do Blip
        },  

        vehicles = {
            {vehicle = 'faggio'}
        },
    },

	['garagemHeliPolicia'] = {
        type = "service", -- [ public / service ]

        blip = {
			showBlip = false, -- Exibir BLIP
            name = 'Garagem', -- Nome do BLIP
            blipId = 357, -- ID DO BLIP = https://docs.fivem.net/docs/game-references/blips/
            blipColor = 0, -- Cor do BLIP
            blipScale = 0.5, -- Tamanho do Blip
        },  

        vehicles = {
            {vehicle = 'polmav'}
        },
    },

	['garagemHeliCivil'] = {
        type = "service", -- [ public / service ]

        blip = {
			showBlip = false, -- Exibir BLIP
            name = 'Garagem', -- Nome do BLIP
            blipId = 357, -- ID DO BLIP = https://docs.fivem.net/docs/game-references/blips/
            blipColor = 0, -- Cor do BLIP
            blipScale = 0.5, -- Tamanho do Blip
        },  

        vehicles = {
            {vehicle = 'bellpc'},

			
        },
    },


	['garagemPolicia'] = {
        type = "service", -- [ public / service ]

        blip = {
			showBlip = false, -- Exibir BLIP
            name = 'Garagem', -- Nome do BLIP
            blipId = 357, -- ID DO BLIP = https://docs.fivem.net/docs/game-references/blips/
            blipColor = 0, -- Cor do BLIP
            blipScale = 0.5, -- Tamanho do Blip
        },  

        vehicles = {
            {vehicle = 'xt660pmerj'},
			{vehicle = 'corollapmerj1'},
			{vehicle = 'dusterpmerjb'},
			{vehicle = 'hiluxgat'},
			{vehicle = 's10bpve'},
			{vehicle = 'nissanversa'},
			
        },
    },

	['garagemBope'] = {
        type = "service", -- [ public / service ]

        blip = {
			showBlip = false, -- Exibir BLIP
            name = 'Garagem', -- Nome do BLIP
            blipId = 357, -- ID DO BLIP = https://docs.fivem.net/docs/game-references/blips/
            blipColor = 0, -- Cor do BLIP
            blipScale = 0.5, -- Tamanho do Blip
        },  

        vehicles = {
            {vehicle = 'frontierbope'},
			{vehicle = 'hiluxbope'},
			{vehicle = 'l200bopeg'},
			{vehicle = 'maverickbp'},
		
        },
    },

	['garagemCivil'] = {
        type = "service", -- [ public / service ]

        blip = {
			showBlip = false, -- Exibir BLIP
            name = 'Garagem', -- Nome do BLIP
            blipId = 357, -- ID DO BLIP = https://docs.fivem.net/docs/game-references/blips/
            blipColor = 0, -- Cor do BLIP
            blipScale = 0.5, -- Tamanho do Blip
        },  

        vehicles = {
            {vehicle = 'corollap2'},
			{vehicle = 'corollapcerj'},
			{vehicle = 'dusterpcerj1'},
			{vehicle = 'frontiercore'},
			{vehicle = 'pajerod'},
			{vehicle = 's10pcerj'},
			{vehicle = 'versapcerj'},
			
        },
    },

	['garagemHospital'] = {
        type = "service", -- [ public / service ]

        blip = {
			showBlip = false, -- Exibir BLIP
            name = 'Garagem', -- Nome do BLIP
            blipId = 357, -- ID DO BLIP = https://docs.fivem.net/docs/game-references/blips/
            blipColor = 0, -- Cor do BLIP
            blipScale = 0.5, -- Tamanho do Blip
        },  

        vehicles = {
            {vehicle = 'ambulance'},
			{vehicle = 'trailsamu'},
        },
    },

	['garagemHeliHospital'] = {
        type = "service", -- [ public / service ]

        blip = {
			showBlip = false, -- Exibir BLIP
            name = 'Garagem', -- Nome do BLIP
            blipId = 357, -- ID DO BLIP = https://docs.fivem.net/docs/game-references/blips/
            blipColor = 0, -- Cor do BLIP
            blipScale = 0.5, -- Tamanho do Blip
        },  

        vehicles = {
            {vehicle = 'supervolito'}

        },
    },

    ['garagemMecanico'] = {
        type = "service", -- [ public / service ]

        blip = {
			showBlip = false, -- Exibir BLIP
            name = 'Garagem', -- Nome do BLIP
            blipId = 357, -- ID DO BLIP = https://docs.fivem.net/docs/game-references/blips/
            blipColor = 0, -- Cor do BLIP
            blipScale = 0.5, -- Tamanho do Blip
        },  

        vehicles = {
            {vehicle = 'towtruck'},
        },
    },

	['vipilegal'] = {
        type = "service", -- [ public / service ]

        blip = {
			showBlip = false, -- Exibir BLIP
            name = 'Garagem', -- Nome do BLIP
            blipId = 357, -- ID DO BLIP = https://docs.fivem.net/docs/game-references/blips/
            blipColor = 0, -- Cor do BLIP
            blipScale = 0.5, -- Tamanho do Blip
        },  

        vehicles = {
            {vehicle = 'lancerevolutionx'},
        },
    },

    ['Publica'] = {
        type = "public", -- [ public / service ]

        blip = {
			showBlip = true, -- Exibir BLIP
            name = 'Garagem', -- Nome do BLIP
            blipId = 357, -- ID DO BLIP = https://docs.fivem.net/docs/game-references/blips/
            blipColor = 3, -- Cor do BLIP
            blipScale = 0.5, -- Tamanho do Blip
        },  

        listCars = {
            vehicle = true,
            heli = false,
            boat = false
        },
    },

	['PublicaHeli'] = {
        type = "public", -- [ public / service ]

        blip = {
			showBlip = true, -- Exibir BLIP
            name = 'Garagem Helicoptero', -- Nome do BLIP
            blipId = 43, -- ID DO BLIP = https://docs.fivem.net/docs/game-references/blips/
            blipColor = 0, -- Cor do BLIP
            blipScale = 0.5, -- Tamanho do Blip
        },  

        listCars = {
            vehicle = false,
            heli = true,
            boat = false
        },
    },

	['PublicaAviao'] = {
        type = "public", -- [ public / service ]

        blip = {
			showBlip = false, -- Exibir BLIP
            name = 'Garagem Avião', -- Nome do BLIP
            blipId = 43, -- ID DO BLIP = https://docs.fivem.net/docs/game-references/blips/
            blipColor = 0, -- Cor do BLIP
            blipScale = 0.5, -- Tamanho do Blip
        },  

        listCars = {
            vehicle = false,
            heli = true,
            boat = false
        },
    },
	

	['PublicaBarcos'] = {
        type = "public", -- [ public / service ]

        blip = {
			showBlip = true, -- Exibir BLIP
            name = 'Garagem Barcos', -- Nome do BLIP
            blipId = 410, -- ID DO BLIP = https://docs.fivem.net/docs/game-references/blips/
            blipColor = 0, -- Cor do BLIP
            blipScale = 0.5, -- Tamanho do Blip
        },  

        listCars = {
            vehicle = false,
            heli = false,
            boat = true
        },
    },

	['Homes'] = {
        type = "public", -- [ public / service ]

        blip = {
			showBlip = false, -- Exibir BLIP
            name = 'Garagem', -- Nome do BLIP
            blipId = 357, -- ID DO BLIP = https://docs.fivem.net/docs/game-references/blips/
            blipColor = 0, -- Cor do BLIP
            blipScale = 0.5, -- Tamanho do Blip
        },  

        listCars = {
            vehicle = true,
            heli = false,
            boat = false
        },
    },
}

garagesConfig.garagesLocs = {


	{
        type = "garagemLS",
        blipDistance = 5.0,
        permiss = "perm.ls",

        coords = vec3(-395.16,-113.98,38.69),     
        spawnCoords = {
            vector4(-392.61,-118.74,38.13,299.31)
        }
    },



	{
        type = "PublicaHeli",
        blipDistance = 5.0,
        permiss = nil,

        coords = vec3(-2030.75,-465.67,11.59), 
        spawnCoords = {
            vector4(-2019.71,-476.53,11.39,321.75)
        }
    },

	{
        type = "PublicaHeli",
        blipDistance = 5.0,
        permiss = nil,

        coords = vec3(-325.08,-777.44,53.25), 
        spawnCoords = {
            vector4(-321.95,-760.14,53.25,41.87)
        }
    },

	{
        type = "garagemPrisao",
        blipDistance = 5.0,
        permiss = nil,

        coords = vec3(1851.84,2586.04,45.68), 
        spawnCoords = {
            vector4(1854.64,2578.71,45.25, 267.56)
        }
    },

	{
        type = "PublicaAviao",
        blipDistance = 5.0,
        permiss = nil,

        coords = vec3(-1033.55,-3017.34,13.95), 
        spawnCoords = {
            vector4(-1068.22,-3027.37,13.93,62.27)
        }
    },
	
	{
        type = "garagemAeroporto",
        blipDistance = 5.0,
        permiss = nil,

        coords = vec3(-1031.73,-2729.09,13.75), 
        spawnCoords = {
            vector4(-1028.46,-2725.83,13.68, 317.42)
        }
    },

	{
		type = "garagemHeliPolicia",  --helipolicia 
		blipDistance = 5.0,
		permiss = "perm.policia",

		coords = vec3(461.87,-981.94,43.69), 
		spawnCoords = {
			vector4(450.65,-981.57,43.69,228.05)
		}
	},

	{
        type = "garagemHospital",
        blipDistance = 5.0,
        permiss = "perm.unizk",

        coords = vec3(1130.68,-1517.72,34.85),     
        spawnCoords = {
            vector4(1125.09,-1515.74,34.69, 356.36)
        }
    },

	{
        type = "garagemHeliHospital",
        blipDistance = 5.0,
        permiss = "perm.unizk",

        coords = vec3(1140.99,-1620.85,34.88),     
        spawnCoords = {
            vector4(1140.32,-1611.37,34.69, 356.36)
        }
    },
	


	{
        type = "PublicaHeli",
        blipDistance = 5.0,
        permiss = nil,

        coords = vec3(-158.09,-1542.43,35.06), 
        spawnCoords = {
            vector4(-141.94,-1550.82,35.1,319.27)
        }
    },

	{
		type = "garagemPolicia",
		blipDistance = 5.0,
		permiss = "perm.policia",

		coords = vec3(457.67,-1007.65,28.29), 
		spawnCoords = {
			vector4(445.93,-1024.8,28.19,6.33),
			vector4(442.71,-1025.51,28.27,6.33),
			vector4(438.98,-1026.55,28.36,6.33),
			vector4(435.09,-1026.17,28.41,6.33),
			vector4(431.21,-1027.16,28.49,6.33)


		}
	},

	{
		type = "garagemCivil",
		blipDistance = 5.0,
		permiss = "perm.policiacivil",

		coords = vec3(825.9,166.44,82.77), 
		spawnCoords = {
			vector4(829.21,151.24,81.87,325.92),
			vector4(826.44,152.92,81.87,325.92),
			vector4(823.96,154.09,81.87,325.92)
		}
	},

	{
		type = "garagemHeliCivil",
		blipDistance = 5.0,
		permiss = "perm.policiacivil",

		coords = vec3(846.73,165.83,91.04), --846.73,165.83,91.04
		spawnCoords = {
			vector4(840.53,163.79,91.04,325.92),

		}
	},

	{
		type = "garagemBope",
		blipDistance = 5.0,
		permiss = "perm.bope",

		coords = vec3(-894.55,-2033.11,9.3), 
		spawnCoords = {
			vector4(-896.34,-2036.1,8.86,223.48)
		}
	},


    {
        type = "garagemMecanico",
        blipDistance = 5.0,
        permiss = "perm.mecanica",

        coords = vec3(811.38,-937.53,26.5), 
        spawnCoords = {
            vector4(818.55,-942.31,26.5, 172.78)
        }
    },



	{
		type = "PublicaBarcos", -- GARAGEM DO CHAVES
		blipDistance = 5.0,
		permiss = nil,

		coords = vec3(-187.96,787.09,198.1),
		spawnCoords = {
			vector4(-202.95,772.34,197.09,132.18)
		}
	},

	{
		type = "PublicaBarcos", -- GARAGEM DO CHAVES
		blipDistance = 5.0,
		permiss = nil,

		coords = vec3(36.8,860.71,197.72),
		spawnCoords = {
			vector4(67.38,874.67,195.98,311.55)
		}
	},

	{
		type = "Publica",  --garagem geral
		blipDistance = 5.0,
		permiss = nil,

		coords = vec3(329.24,-201.28,54.22), 
		spawnCoords = {
			vector4(326.56,-207.87,54.09,159.37) 
		}
	},

    {
        type = "Publica",
        blipDistance = 5.0,
        permiss = nil,

        coords = vec3(317.25, 2623.139892578125, 44.459999084472656), 
        spawnCoords = {
            vector4(326.27,2621.65,44.06, 89.01),
            vector4(326.15,2625.46,44.08,88.34), 
        }
    },

	{
        type = "Publica",
        blipDistance = 5.0,
        permiss = nil,

        coords = vec3(-1644.44,-987.5,13.01), 
        spawnCoords = {
			vector4(-1634.16,-983.27,13.01,321.39)
        }
    },
	
	{
        type = "Publica",
        blipDistance = 5.0,
        permiss = nil,

        coords = vec3(-1184.53,-1509.4,4.65), 
        spawnCoords = {
			vector4(-1185.59,-1493.41,4.38,126.8)
        }
    },
	
	{
        type = "Publica",
        blipDistance = 5.0,
        permiss = nil,

        coords = vec3(1551.57,3526.5,35.65), 
        spawnCoords = {
			vector4(1547.15,3527.77,35.45,126.8)
        }
    },


	{
		type = "Publica", -- GARAGEM DA PRACA
		blipDistance = 5.0,
		permiss = nil,

		coords = vec3(213.90,-809.08,31.01), 
		spawnCoords = {
			vector4(223.29,-798.99,30.24,247.84),
			vector4(224.59,-796.50,30.24,249.23), 
			vector4(225.54,-794.01,30.24,246.92),
			vector4(227.58,-789.02,30.26,248.55),
			vector4(217.64,-799.16,30.77,69.69),
			vector4(218.92,-794.24,30.77,71.07),
			vector4(225.78,-791.43,30.68,252.26)
		}
	},

	{
		type = "Publica", -- GARAGEM DA PRACA PREDIO
		blipDistance = 5.0,
		permiss = nil,

		coords = vec3(1163.36,-1536.58,34.86), 
		spawnCoords = {
			vector4(1168.41,-1546.29,34.69,266.31),
			vector4(1167.46,-1553.19,34.69,265.65),
			vector4(1167.58,-1560.0,34.69,271.47)
		}
	},

	{
		type = "Publica", -- GARAGEM DA PRACA PREDIO
		blipDistance = 5.0,
		permiss = nil,

		coords = vec3(100.5,-1073.31,29.37), 
		spawnCoords = {
			vector4(111.14,-1081.21,28.53,340.67),
		}
	},
	
	{
		type = "Publica", -- GARAGEM DA PRACA BANCO
		blipDistance = 5.0,
		permiss = nil,

		coords = vec3(596.69,91.42,93.12), 
		spawnCoords = {
			vector4(598.46,98.26,92.48,248.26),
			vector4(599.35,102.41,92.48,251.97),  
			vector4(602.69,118.89,92.48,247.97),
			vector4(609.36,103.75,92.37,69.77), 
			vector4(610.45,107.12,92.41,68.28), 
			vector4(601.33,115.11,92.48,249.30), 
			vector4(611.80,110.97,92.46,68.63), 
			vector4(612.90,114.45,92.47,71.08), 
		}
	},

	{
		type = "Publica", -- GARAGEM DO CHAVES
		blipDistance = 5.0,
		permiss = nil,

		coords = vec3(275.41,-345.24,45.17),
		spawnCoords = {
			vector4(282.63,-342.09,44.49,251.15), 
			vector4(284.15,-338.84,44.49,249.29), 
			vector4(285.08,-335.68,44.49,250.24)
		}
	},

	{
		type = "Publica", -- GARAGEM DA PRACA LOS SANTOS
		blipDistance = 5.0,
		permiss = nil,

		coords = vec3(56.08,-876.53,30.65), 
		spawnCoords = {
			vector4(50.65,-872.78,30.02,160.89), 
			vector4(46.94,-871.23,30.03,161.22),  
			vector4(43.44,-870.17,30.04,160.49),
			vector4(53.24,-888.34,29.80,340.64), 
			vector4(49.96,-887.14,29.80,339.94),
			vector4(46.66,-885.97,29.81,340.49), 
			vector4(47.56,-870.92,30.46,161.31),
			vector4(53.97,-864.84,30.57,345.61),
			vector4(60.66,-866.54,30.55,346.02),
			vector4(44.02,-870.71,30.46,163.68)
		}
	},

	{
		type = "Publica", -- GARAGEM ESTACIONAMENTO VERMELHO
		blipDistance = 5.0,
		permiss = nil,

		coords = vec3(-348.95,-874.39,31.31), 
		spawnCoords = {
			vector4(-344.30,-874.50,30.64,168.84),
			vector4(-339.76,-875.48,30.64,167.00), 
			vector4(-336.22,-876.30,30.64,168.03), 
			vector4(-332.53,-876.64,30.64,167.36), 
			vector4(-328.90,-877.51,30.64,168.03)
		}
	},

	{
		type = "Publica", -- GARAGEM DE PALETO
		blipDistance = 5.0,
		permiss = nil,

		coords = vec3(-773.59,5597.57,33.60), 
		spawnCoords = {
			vector4(-771.57,5578.38,33.06,90.17), 
			vector4(-771.65,5575.43,33.06,88.56),  
			vector4(-771.53,5572.42,33.06,90.13)
		}
	},

	{
		type = "Publica", -- GARAGEM DO FARM
		blipDistance = 5.0,
		permiss = nil,

		coords = vec3(1894.55,3715.24,32.76), 
		spawnCoords = {
			vector4(1886.56,3716.88,32.88,121.783), 
			vector4(1884.61,3720.17,32.87,117.481)
		}
	},
	

	{
		type = "PublicaBarcos", -- GARAGEM BARCOS
		blipDistance = 5.0,
		permiss = nil,

		coords = vec3(-1803.32,-1230.27,1.6), 
		spawnCoords = {
			vector4(-1769.34,-1256.47,-0.12,232.4)
		}
	},
	
}