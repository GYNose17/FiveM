
--##CONFIGURAÇÃOD OS PNC##--
--LOJAS DOS POSTO / MERCADIN
local npcloja = "mp_m_shopkeep_01"
local npcloja_hash = 0x18CE57D0

--HOSPITAL / FARMACIA
local npcmedico = "s_m_m_doctor_01"
local npcmedico_hash = 0xD47303AC


--BARMAN / BARES
local npcbarman = "s_m_y_barman_01"
local npcbarman_hash = 0xE5A11106

local npcloja_roupas = "s_f_y_shop_low"
local npcloja_roupas_hash = 0xA96E2604

local npc_loja_peixe = "a_m_m_hillbilly_01"
local npc_loja_peixe_hash = 0x6C9B2849

local npc_loja_tartaruga = "ig_chef"
local npc_loja_tartaruga_hash = 0x49EADBF6

local npc_loja_faca = "csb_prologuedriver"
local npc_loja_faca_hash = 0xF00B49DB

local npc_loja_mandeiras = "ig_old_man2"
local npc_loja_mandeiras_hash = 0xEF154C47

local npc_loja_joais = "s_f_y_shop_mid"
local npc_loja_joais_hash = 0x3EECBA5D

local npc_loja_joais_vender = "s_m_y_devinsec_01"
local npc_loja_joais_vender_hash = 0x9B557274

local npc_loja_fazendeiro = "a_m_m_farmer_01"
local npc_loja_fazendeiro_hash = 0x94562DD7

local npc_loja_ammu = "s_m_y_ammucity_01"
local npc_loja_ammu_hash = 0x9E08633D

local npc_loja_mercadonegro = "s_m_y_ammucity_01"
local npc_loja_mercadonegro_hash = 0x9E08633D


local pedlist = {
	{['x'] = -706.1, ['y'] = -914.82, ['z'] = 19.21, ['h'] = 79.07, ['hash'] =  npcloja_hash, ['hash2'] = npcloja},
	{['x'] = 24.45, ['y'] = -1347.99, ['z'] = 29.49, ['h'] = 265.13, ['hash'] =  npcloja_hash, ['hash2'] = npcloja},
	{['x'] = 1134.22, ['y'] = -983.02, ['z'] = 46.4, ['h'] = 265.54, ['hash'] =  npcloja_hash, ['hash2'] = npcloja},
	{['x'] = 1164.91, ['y'] = -323.53, ['z'] = 69.2, ['h'] = 112.39, ['hash'] =  npcloja_hash, ['hash2'] = npcloja},
	{['x'] = 372.44, ['y'] = 325.81, ['z'] = 103.56, ['h'] = 246.82, ['hash'] =  npcloja_hash, ['hash2'] = npcloja},
	{['x'] = 2558.0, ['y'] = 380.72, ['z'] = 108.61, ['h'] = 351.09, ['hash'] =  npcloja_hash, ['hash2'] = npcloja},
	{['x'] = 2678.52, ['y'] = 3279.06, ['z'] = 55.23, ['h'] = 323.32, ['hash'] =  npcloja_hash, ['hash2'] = npcloja},
	{['x'] = 1960.34, ['y'] = 3739.48, ['z'] = 32.35, ['h'] = 297.85, ['hash'] =  npcloja_hash, ['hash2'] = npcloja},
	{['x'] = 1393.59, ['y'] = 3606.76, ['z'] = 34.98, ['h'] = 198.31, ['hash'] =  npcloja_hash, ['hash2'] = npcloja},
	{['x'] = 1165.19, ['y'] = 2710.9, ['z'] = 38.15, ['h'] = 168.48, ['hash'] =  npcloja_hash, ['hash2'] = npcloja},
	{['x'] = 548.99, ['y'] = 2671.98, ['z'] = 42.16, ['h'] = 92.58, ['hash'] =  npcloja_hash, ['hash2'] = npcloja},
	{['x'] = 1697.29, ['y'] = 4923.37, ['z'] = 42.06, ['h'] = 315.80, ['hash'] =  npcloja_hash, ['hash2'] = npcloja},
	{['x'] = 1727.54, ['y'] = 6414.72, ['z'] = 35.03, ['h'] = 234.93, ['hash'] =  npcloja_hash, ['hash2'] = npcloja},
	{['x'] = -3241.7, ['y'] = 999.88, ['z'] = 12.82, ['h'] = 351.71, ['hash'] =  npcloja_hash, ['hash2'] = npcloja},
	{['x'] = -2966.32, ['y'] = 391.52, ['z'] = 15.05, ['h'] = 88.37, ['hash'] =  npcloja_hash, ['hash2'] = npcloja},
	{['x'] = -3038.41, ['y'] = 584.64, ['z'] = 7.9, ['h'] = 19.00, ['hash'] =  npcloja_hash, ['hash2'] = npcloja},
	{['x'] = -1819.46, ['y'] = 793.47, ['z'] = 138.08, ['h'] = 129.16, ['hash'] =  npcloja_hash, ['hash2'] = npcloja},
	{['x'] = -1486.62, ['y'] = -377.59, ['z'] = 40.15, ['h'] = 128.64, ['hash'] =  npcloja_hash, ['hash2'] = npcloja},
	{['x'] = -47.4, ['y'] = -1758.67, ['z'] = 29.42, ['h'] = 44.70, ['hash'] =  npcloja_hash, ['hash2'] = npcloja},
	{['x'] = -1221.42, ['y'] = -907.91, ['z'] = 12.32, ['h'] = 19.30, ['hash'] =  npcloja_hash, ['hash2'] = npcloja},
	{['x'] = -665.78, ['y'] = 321.78, ['z'] = 83.09, ['h'] = 271.05, ['hash'] =  npcmedico_hash, ['hash2'] = npcmedico},
	{['x'] = 129.3, ['y'] = -1283.73, ['z'] = 29.27, ['h'] = 132.96, ['hash'] =  npcbarman_hash, ['hash2'] = npcbarman},
	{['x'] = -1392.09, ['y'] = -604.9, ['z'] = 30.31, ['h'] = 94.01, ['hash'] =  npcbarman_hash, ['hash2'] = npcbarman},
	{['x'] = -3277.75, ['y'] = 969.8, ['z'] = 8.34, ['h'] = 189.24, ['hash'] =  npc_loja_peixe_hash, ['hash2'] = npc_loja_peixe},
	{['x'] = 3725.31, ['y'] = 4525.69, ['z'] = 22.46, ['h'] = 171.27, ['hash'] =  npc_loja_tartaruga_hash, ['hash2'] = npc_loja_tartaruga},
	{['x'] = -552.3, ['y'] = 5348.33, ['z'] = 74.75, ['h'] = 60.49, ['hash'] =  npc_loja_mandeiras_hash, ['hash2'] = npc_loja_mandeiras},
	{['x'] = -840.56, ['y'] = 5398.65, ['z'] = 34.61, ['h'] = 301.18, ['hash'] =  npc_loja_faca_hash, ['hash2'] = npc_loja_faca},
	{['x'] = -621.98, ['y'] = -232.24, ['z'] = 38.05, ['h'] = 113.05, ['hash'] =  npc_loja_joais_hash, ['hash2'] = npc_loja_joais},
	{['x'] = -619.52, ['y'] = -225.65, ['z'] = 38.05, ['h'] = 142.98, ['hash'] =  npc_loja_joais_vender_hash, ['hash2'] = npc_loja_joais_vender},
	{['x'] = 2885.48, ['y'] = 4387.43, ['z'] = 50.73, ['h'] = 207.48, ['hash'] =  npc_loja_fazendeiro_hash, ['hash2'] = npc_loja_fazendeiro},
	{['x'] = 1690.74, ['y'] = 3759.38, ['z'] = 34.69, ['h'] = 225.51, ['hash'] =  npc_loja_ammu_hash, ['hash2'] = npc_loja_ammu},
	{['x'] = 254.09, ['y'] = -49.99, ['z'] = 69.94, ['h'] = 66.00, ['hash'] =  npc_loja_ammu_hash, ['hash2'] = npc_loja_ammu},
	{['x'] = 842.93, ['y'] = -1035.29, ['z'] = 28.19, ['h'] = 345.45, ['hash'] =  npc_loja_ammu_hash, ['hash2'] = npc_loja_ammu},
	{['x'] = -332.24, ['y'] = 6084.41, ['z'] = 31.46, ['h'] = 207.25, ['hash'] =  npc_loja_ammu_hash, ['hash2'] = npc_loja_ammu},
	{['x'] = -663.87, ['y'] = -933.49, ['z'] = 21.82, ['h'] = 179.13, ['hash'] =  npc_loja_ammu_hash, ['hash2'] = npc_loja_ammu},
	{['x'] = -1303.97, ['y'] = -394.2, ['z'] = 36.7, ['h'] = 73.45, ['hash'] =  npc_loja_ammu_hash, ['hash2'] = npc_loja_ammu},
	{['x'] = -1119.23, ['y'] = 2699.61, ['z'] = 18.55, ['h'] = 206.95, ['hash'] =  npc_loja_ammu_hash, ['hash2'] = npc_loja_ammu},
	{['x'] = 2567.97, ['y'] = 292.57, ['z'] = 108.73, ['h'] = 345.15, ['hash'] =  npc_loja_ammu_hash, ['hash2'] = npc_loja_ammu},
	{['x'] = -3174.03, ['y'] = 1087.4, ['z'] = 20.84, ['h'] = 240.42, ['hash'] =  npc_loja_ammu_hash, ['hash2'] = npc_loja_ammu},
	{['x'] = 22.36, ['y'] = -1105.37, ['z'] = 29.79, ['h'] = 140.90, ['hash'] =  npc_loja_ammu_hash, ['hash2'] = npc_loja_ammu},
	{['x'] = 811.09, ['y'] = -2159.12, ['z'] = 29.62, ['h'] = 358.10, ['hash'] =  npc_loja_ammu_hash, ['hash2'] = npc_loja_ammu},
	{['x'] = 706.84, ['y'] = -966.71, ['z'] = 30.41, ['h'] = 2.5, ['hash'] =  npc_loja_mercadonegro_hash, ['hash2'] = npc_loja_mercadonegro},
}

CreateThread(function()
	for k,v in pairs(pedlist) do
		RequestModel(GetHashKey(v.hash2))
		while not HasModelLoaded(GetHashKey(v.hash2)) do Wait(100) end
		ped = CreatePed(4,v.hash,v.x,v.y,v.z-1,v.h,false,true)
		peds = ped
		FreezeEntityPosition(ped,true)
		SetEntityInvincible(ped,true)
		SetBlockingOfNonTemporaryEvents(ped,true)
	end
end) 