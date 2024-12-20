-----------------------------------------------------------------------------------------------------------------------------------------
-- INTERIORS
-----------------------------------------------------------------------------------------------------------------------------------------
Interiors = {
	["Emerald"] = {
		["Exit"] = vec3(28.7,-24.39,-24.01),
		["Vault"] = vec3(26.13,-32.94,-24.01),
		["Fridge"] = vec3(19.07,-29.69,-24.01),
		["Clothes"] = vec3(30.62,-28.19,-24.01)
	},
	["Diamond"] = {
		["Exit"] = vec3(51.78,-38.83,-26.02),
		["Vault"] = vec3(52.38,-45.34,-24.01),
		["Fridge"] = vec3(45.95,-46.48,-24.01),
		["Clothes"] = vec3(54.44,-45.33,-24.01)
	},
	["Ruby"] = {
		["Exit"] = vec3(86.72,-91.62,-24.2),
		["Vault"] = vec3(92.52,-105.4,-24.2),
		["Fridge"] = vec3(96.53,-98.03,-24.2),
		["Clothes"] = vec3(96.91,-108.13,-24.2)
	},
	["Sapphire"] = {
		["Exit"] = vec3(71.71,65.94,-23.4),
		["Vault"] = vec3(86.85,72.15,-24.01),
		["Fridge"] = vec3(83.89,81.95,-24.01),
		["Clothes"] = vec3(60.19,70.16,-24.6)
	},
	["Amethyst"] = {
		["Exit"] = vec3(164.0,-137.8,-17.79),
		["Vault"] = vec3(160.86,-149.92,-17.79),
		["Fridge"] = vec3(160.09,-156.67,-19.19),
		["Clothes"] = vec3(150.4,-157.34,-23.99)
	},
	["Amber"] = {
		["Exit"] = vec3(118.44,-108.5,-23.57),
		["Vault"] = vec3(117.82,-112.02,-31.21),
		["Fridge"] = vec3(122.26,-110.26,-23.59),
		["Clothes"] = vec3(124.49,-118.62,-27.4)
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- EXPORTS
-----------------------------------------------------------------------------------------------------------------------------------------
exports("Interiors",function()
	local Table = {}

	for Name,v in pairs(Interiors) do
		Table[#Table + 1] = Name
	end

	return Table
end)