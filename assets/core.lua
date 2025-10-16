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

SMODS.current_mod.extra_tabs = function()
    return {
        {
            label = 'Creditos',
            tab_definition_function = function()
                return {
                    n = G.UIT.ROOT, 
                    config = {
                        align = "cm", 
                        padding = 0.2, 
                        colour = G.C.BLACK, 
                        r = 0.1, 
                        minw = 10, 
                        minh = 8
                    }, 
                    nodes = {
                        {
                            n = G.UIT.C, 
                            config = {align = "cm", padding = 0.1}, 
                            nodes = {
                                -- Título
                                {
                                    n = G.UIT.R, 
                                    config = {align = "cm", padding = 0.15}, 
                                    nodes = {
                                        {
                                            n = G.UIT.T, 
                                            config = {
                                                text = "CREDITOS", 
                                                colour = G.C.UI.TEXT_LIGHT, 
                                                scale = 0.7
                                            }
                                        }
                                    }
                                },
                                -- Espacio
                                {
                                    n = G.UIT.R, 
                                    config = {align = "cm", padding = 0.1}, 
                                    nodes = {}
                                },
                                -- Creador
                                {
                                    n = G.UIT.R, 
                                    config = {align = "cm", padding = 0.05}, 
                                    nodes = {
                                        {
                                            n = G.UIT.T, 
                                            config = {
                                                text = "AppleMania", 
                                                colour = G.C.GREEN, 
                                                scale = 0.55
                                            }
                                        }
                                    }
                                },
                                {
                                    n = G.UIT.R, 
                                    config = {align = "cm", padding = 0.02}, 
                                    nodes = {
                                        {
                                            n = G.UIT.T, 
                                            config = {
                                                text = "¡He creado esto!", 
                                                colour = G.C.UI.TEXT_LIGHT, 
                                                scale = 0.4
                                            }
                                        }
                                    }
                                },
                                {
                                    n = G.UIT.R, 
                                    config = {align = "cm", padding = 0.1}, 
                                    nodes = {}
                                },
                                -- Ideas (Título)
                                {
                                    n = G.UIT.R, 
                                    config = {align = "cm", padding = 0.05}, 
                                    nodes = {
                                        {
                                            n = G.UIT.T, 
                                            config = {
                                                text = "Ideas:", 
                                                colour = G.C.GREEN, 
                                                scale = 0.5
                                            }
                                        }
                                    }
                                },
                                -- Lista de gente
                                {
                                    n = G.UIT.R,
                                    config = {align = "cm", padding = 0.02},
                                    nodes = {
                                        {
                                            n = G.UIT.T,
                                            config = {
                                                text = "Xifox, LukexsGame, Javier25, DoggoDS,", 
                                                colour = G.C.UI.TEXT_LIGHT,
                                                scale = 0.4
                                            }
                                        }
                                    }
                                },
                                {
                                    n = G.UIT.R,
                                    config = {align = "cm", padding = 0.02},
                                    nodes = {
                                        {
                                            n = G.UIT.T,
                                            config = {
                                                text = " Nauiyo, Julio24pro, Bunbxnblxxd, Lauxs_v0,", 
                                                colour = G.C.UI.TEXT_LIGHT,
                                                scale = 0.4
                                            }
                                        }
                                    }
                                },
                                {
                                    n = G.UIT.R,
                                    config = {align = "cm", padding = 0.02},
                                    nodes = {
                                        {
                                            n = G.UIT.T,
                                            config = {
                                                text = " Alberto.rueda_07, Jesu.supongo, K4l1zz_33 ", 
                                                colour = G.C.UI.TEXT_LIGHT,
                                                scale = 0.4
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            end,
        }
    }
end

----------------------------------------------------------
----------- MOD CODE END ----------------------------------