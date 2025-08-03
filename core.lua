--- STEAMODDED HEADER
--- MOD_NAME: Maniatro
--- MOD_ID: Maniatro
--- MOD_AUTHOR: AppleMania
--- MOD_DESCRIPTION: ¡30 nuevos Jokers para Balatro!
--- PREFIX: mania
----------------------------------------------------------
----------- MOD CODE -------------------------------------

if not Maniatro then
    Maniatro = {}
end

-- Definición de colores personalizados
G.C.MANIA_GREEN = HEX("14b82d")
G.C.MANIA_WHITE = HEX("ffffff")

-- Configuración básica del mod
local mod_path = "" .. SMODS.current_mod.path
Maniatro.path = mod_path
Maniatro_config = SMODS.current_mod.config

-- Características opcionales
SMODS.current_mod.optional_features = {
    retrigger_joker = true,
    post_trigger = true,
}

-- Maniatro joker pool
SMODS.ObjectType({
	key = "Maniatromod",
	default = "j_maniatro",
	cards = {},
	inject = function(self)
		SMODS.ObjectType.inject(self)
		-- insert base game food jokers
	end,
})

-- Carga de archivos de items
local files = NFS.getDirectoryItems(mod_path .. "items")
for _, file in ipairs(files) do
    print("[MANIATRO] Cargando archivo " .. file)
    local f, err = SMODS.load_file("items/" .. file)
    if err then
        error(err)
    end
    f()
end

--Load lib files
local files = NFS.getDirectoryItems(mod_path .. "libs/")
for _, file in ipairs(files) do
	print("[MANIATRO] Cargando archivo de librería " .. file)
	local f, err = SMODS.load_file("libs/" .. file)
	if err then
		error(err) 
	end
	f()
end

-- Carga de archivos de localización
local files = NFS.getDirectoryItems(mod_path .. "localization")
for _, file in ipairs(files) do
    print("[MANIATRO] Cargando localización " .. file)
    local f, err = SMODS.load_file("localization/" .. file)
    if err then
        error(err)
    end
    f()
end

----------------------------------------------------------
----------- MOD CODE END ----------------------------------