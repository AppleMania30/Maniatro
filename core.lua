--- STEAMODDED HEADER
--- MOD_NAME: Maniatro
--- MOD_ID: Maniatro
--- MOD_AUTHOR: AppleMania
--- MOD_DESCRIPTION: Mis cojones
--- PREFIX: mania

if not Maniatro then
    Maniatro = {}
end

G.C.MANIA_GREEN = HEX("14b82d")
G.C.MANIA_WHITE = HEX("ffffff")

local mod_path = "" .. SMODS.current_mod.path
Maniatro.path = mod_path
Maniatro_config = SMODS.current_mod.config

SMODS.current_mod.optional_features = {
    retrigger_joker = true,
    post_trigger = true,
}

SMODS.ObjectType({
	key = "Maniatromod",
	default = "j_maniatro",
	cards = {},
	inject = function(self)
		SMODS.ObjectType.inject(self)
	end,
})

local files = NFS.getDirectoryItems(mod_path .. "items")
for _, file in ipairs(files) do
    print("[MANIATRO] Cargando archivo " .. file)
    local f, err = SMODS.load_file("items/" .. file)
    if err then
        error(err)
    end
    f()
end

local files = NFS.getDirectoryItems(mod_path .. "libs/")
for _, file in ipairs(files) do
	print("[MANIATRO] Cargando archivo de librería " .. file)
	local f, err = SMODS.load_file("libs/" .. file)
	if err then
		error(err) 
	end
	f()
end

local files = NFS.getDirectoryItems(mod_path .. "localization")
for _, file in ipairs(files) do
    print("[MANIATRO] Cargando localización " .. file)
    local f, err = SMODS.load_file("localization/" .. file)
    if err then
        error(err)
    end
    f()
end

local oldfunc = Game.main_menu
Game.main_menu = function(change_context)
    local ret = oldfunc(change_context)
    
    G.SPLASH_BACK:define_draw_steps({
        {
            shader = "splash",
            send = {
                { name = "time", ref_table = G.TIMERS, ref_value = "REAL_SHADER" },
                { name = 'vort_speed', val = 0.4 },
                { name = 'colour_1', val = HEX('a2e332') }, 
                { name = 'colour_2', val = HEX('c6f452') },
                { name = 'mid_flash', val = 0 },
            },
        },
    })
    
    return ret
end

SMODS.current_mod.extra_tabs = function()
    return {
        {
            label = 'Credits',
            tab_definition_function = function()
                local text_scale = 0.4
                local header_scale = 0.6
                local padding = 0.05
                local section_padding = 0.1
                
                return {
                    n = G.UIT.ROOT, 
                    config = {
                        align = "cm", 
                        padding = 0.2, 
                        colour = G.C.BLACK, 
                        r = 0.1, 
                        emboss = 0.05,
                        minh = 6, 
                        minw = 10
                    }, 
                    nodes = {
                        {n = G.UIT.C, config = {align = "tm", padding = 0.2}, nodes = {
                            {n = G.UIT.R, config = {align = "cm", padding = 0.1}, nodes = {
                                {n = G.UIT.T, config = {
                                    text = "CREDITS", 
                                    scale = header_scale * 1.2, 
                                    colour = HEX('32CD32'), 
                                    shadow = true
                                }}
                            }},
                            
                            {n = G.UIT.R, config = {align = "cm", padding = section_padding, outline_colour = HEX('32CD32'), r = 0.1, outline = 1}, nodes = {
                                {n = G.UIT.C, config = {align = "tm", padding = section_padding}, nodes = {
                                    {n = G.UIT.R, config = {align = "cm", padding = section_padding, outline_colour = G.C.JOKER_GREY, r = 0.1, outline = 1}, nodes = {
                                        {n = G.UIT.R, config = {align = "cm", padding = padding}, nodes = {
                                            {n = G.UIT.T, config = {
                                                text = "Project Lead", 
                                                scale = header_scale, 
                                                colour = HEX('5bc90f'), 
                                                shadow = true
                                            }}
                                        }},
                                        {n = G.UIT.R, config = {align = "cm", padding = padding}, nodes = {
                                            {n = G.UIT.T, config = {
                                                text = "AppleMania", 
                                                scale = text_scale, 
                                                colour = G.C.UI.TEXT_LIGHT, 
                                                shadow = true
                                            }}
                                        }}
                                    }},
                                    
                                    {n = G.UIT.R, config = {align = "cm", padding = 0.05}, nodes = {}},
                                    
                                    {n = G.UIT.R, config = {align = "cm", padding = section_padding, outline_colour = G.C.JOKER_GREY, r = 0.1, outline = 1}, nodes = {
                                        {n = G.UIT.R, config = {align = "cm", padding = padding}, nodes = {
                                            {n = G.UIT.T, config = {
                                                text = "Programmers", 
                                                scale = header_scale, 
                                                colour = HEX('81dd12'), 
                                                shadow = true
                                            }}
                                        }},
                                        {n = G.UIT.R, config = {align = "cm", padding = padding}, nodes = {
                                            {n = G.UIT.T, config = {
                                                text = "AppleMania", 
                                                scale = text_scale, 
                                                colour = G.C.UI.TEXT_LIGHT, 
                                                shadow = true
                                            }}
                                        }},
                                        {n = G.UIT.R, config = {align = "cm", padding = padding}, nodes = {
                                            {n = G.UIT.T, config = {
                                                text = "DoggoDS", 
                                                scale = text_scale, 
                                                colour = G.C.UI.TEXT_LIGHT, 
                                                shadow = true
                                            }}
                                        }},
                                        {n = G.UIT.R, config = {align = "cm", padding = padding}, nodes = {
                                            {n = G.UIT.T, config = {
                                                text = "Dogg-Fly", 
                                                scale = text_scale, 
                                                colour = G.C.UI.TEXT_LIGHT, 
                                                shadow = true
                                            }}
                                        }}
                                    }}
                                }},
                                
                                {n = G.UIT.C, config = {align = "tm", padding = section_padding}, nodes = {
                                    {n = G.UIT.R, config = {align = "cm", padding = section_padding, outline_colour = G.C.JOKER_GREY, r = 0.1, outline = 1, minh = 4}, nodes = {
                                        {n = G.UIT.R, config = {align = "cm", padding = padding}, nodes = {
                                            {n = G.UIT.T, config = {
                                                text = "Idea Providers", 
                                                scale = header_scale, 
                                                colour = HEX('f75294'), 
                                                shadow = true
                                            }}
                                        }},
                                        {n = G.UIT.R, config = {align = "cm", padding = 0}, nodes = {
                                            {n = G.UIT.C, config = {align = "tl", padding = 0.05}, nodes = {
                                                {n = G.UIT.R, config = {align = "tm", padding = padding * 0.5}, nodes = {
                                                    {n = G.UIT.T, config = {text = "AppleMania", scale = text_scale * 0.9, colour = G.C.UI.TEXT_LIGHT, shadow = true}}
                                                }},
                                                {n = G.UIT.R, config = {align = "tm", padding = padding * 0.5}, nodes = {
                                                    {n = G.UIT.T, config = {text = "LukexsGame", scale = text_scale * 0.9, colour = G.C.UI.TEXT_LIGHT, shadow = true}}
                                                }},
                                                {n = G.UIT.R, config = {align = "tm", padding = padding * 0.5}, nodes = {
                                                    {n = G.UIT.T, config = {text = "DoggoDS", scale = text_scale * 0.9, colour = G.C.UI.TEXT_LIGHT, shadow = true}}
                                                }},
                                                {n = G.UIT.R, config = {align = "tm", padding = padding * 0.5}, nodes = {
                                                    {n = G.UIT.T, config = {text = "Xifox", scale = text_scale * 0.9, colour = G.C.UI.TEXT_LIGHT, shadow = true}}
                                                }},
                                                {n = G.UIT.R, config = {align = "tm", padding = padding * 0.5}, nodes = {
                                                    {n = G.UIT.T, config = {text = "Javier25", scale = text_scale * 0.9, colour = G.C.UI.TEXT_LIGHT, shadow = true}}
                                                }},
                                                {n = G.UIT.R, config = {align = "tm", padding = padding * 0.5}, nodes = {
                                                    {n = G.UIT.T, config = {text = "Nauiyo", scale = text_scale * 0.9, colour = G.C.UI.TEXT_LIGHT, shadow = true}}
                                                }},
                                                {n = G.UIT.R, config = {align = "tm", padding = padding * 0.5}, nodes = {
                                                    {n = G.UIT.T, config = {text = "Julio24pro", scale = text_scale * 0.9, colour = G.C.UI.TEXT_LIGHT, shadow = true}}
                                                }}
                                            }},
                                            {n = G.UIT.C, config = {align = "tl", padding = 0.05}, nodes = {
                                                {n = G.UIT.R, config = {align = "tm", padding = padding * 0.5}, nodes = {
                                                    {n = G.UIT.T, config = {text = "Bimaker15", scale = text_scale * 0.9, colour = G.C.UI.TEXT_LIGHT, shadow = true}}
                                                }},
                                                {n = G.UIT.R, config = {align = "tm", padding = padding * 0.5}, nodes = {
                                                    {n = G.UIT.T, config = {text = "Bunbxnblxxd", scale = text_scale * 0.9, colour = G.C.UI.TEXT_LIGHT, shadow = true}}
                                                }},
                                                {n = G.UIT.R, config = {align = "tm", padding = padding * 0.5}, nodes = {
                                                    {n = G.UIT.T, config = {text = "Lauxs_v0", scale = text_scale * 0.9, colour = G.C.UI.TEXT_LIGHT, shadow = true}}
                                                }},
                                                {n = G.UIT.R, config = {align = "tm", padding = padding * 0.5}, nodes = {
                                                    {n = G.UIT.T, config = {text = "Alberto.rueda_07", scale = text_scale * 0.9, colour = G.C.UI.TEXT_LIGHT, shadow = true}}
                                                }},
                                                {n = G.UIT.R, config = {align = "tm", padding = padding * 0.5}, nodes = {
                                                    {n = G.UIT.T, config = {text = "Jesu.supongo", scale = text_scale * 0.9, colour = G.C.UI.TEXT_LIGHT, shadow = true}}
                                                }},
                                                {n = G.UIT.R, config = {align = "tm", padding = padding * 0.5}, nodes = {
                                                    {n = G.UIT.T, config = {text = "K4l1z_33", scale = text_scale * 0.9, colour = G.C.UI.TEXT_LIGHT, shadow = true}}
                                                }},
                                                {n = G.UIT.R, config = {align = "tm", padding = padding * 0.5}, nodes = {
                                                    {n = G.UIT.T, config = {text = "Dogg-Fly", scale = text_scale * 0.9, colour = G.C.UI.TEXT_LIGHT, shadow = true}}
                                                }}
                                            }},
                                            {n = G.UIT.C, config = {align = "tl", padding = 0.05}, nodes = {
                                                {n = G.UIT.R, config = {align = "tm", padding = padding * 0.5}, nodes = {
                                                    {n = G.UIT.T, config = {text = "Enderjed", scale = text_scale * 0.9, colour = G.C.UI.TEXT_LIGHT, shadow = true}}
                                                }},
                                                {n = G.UIT.R, config = {align = "tm", padding = padding * 0.5}, nodes = {
                                                    {n = G.UIT.T, config = {text = "Adumbasswaffle", scale = text_scale * 0.9, colour = G.C.UI.TEXT_LIGHT, shadow = true}}
                                                }},
                                                {n = G.UIT.R, config = {align = "tm", padding = padding * 0.5}, nodes = {
                                                    {n = G.UIT.T, config = {text = "Zombieboy139", scale = text_scale * 0.9, colour = G.C.UI.TEXT_LIGHT, shadow = true}}
                                                }},
                                                {n = G.UIT.R, config = {align = "tm", padding = padding * 0.5}, nodes = {
                                                    {n = G.UIT.T, config = {text = "DragoniteChamp", scale = text_scale * 0.9, colour = G.C.UI.TEXT_LIGHT, shadow = true}}
                                                }},
                                                {n = G.UIT.R, config = {align = "tm", padding = padding * 0.5}, nodes = {
                                                    {n = G.UIT.T, config = {text = "InkystA", scale = text_scale * 0.9, colour = G.C.UI.TEXT_LIGHT, shadow = true}}
                                                }},
                                                {n = G.UIT.R, config = {align = "tm", padding = padding * 0.5}, nodes = {
                                                    {n = G.UIT.T, config = {text = "AbelSketch", scale = text_scale * 0.9, colour = G.C.UI.TEXT_LIGHT, shadow = true}}
                                                }},
                                                {n = G.UIT.R, config = {align = "tm", padding = padding * 0.5}, nodes = {
                                                    {n = G.UIT.T, config = {text = "SrJesusss", scale = text_scale * 0.9, colour = G.C.UI.TEXT_LIGHT, shadow = true}}
                                                }}
                                            }}
                                        }}
                                    }}
                                }}
                            }}
                        }}
                    }
                }
            end
        },
    }
end

function tableContains(value, tbl)
  for _, v in ipairs(tbl) do
    if v == value then
      return true
    end
  end
  return false
end

MANIATRO = {}

local gameMainMenuRef = Game.main_menu
function Game:main_menu(change_context)
    gameMainMenuRef(self, change_context)
    UIBox({
        definition = {
            n = G.UIT.ROOT,
            config = {
                align = "cm",
                colour = G.C.UI.TRANSPARENT_DARK
            },
            nodes = {
                {
                    n = G.UIT.T,
                    config = {
                        scale = 0.3,
                        text = "Maniatro V5.0.0",
                        colour = G.C.UI.TEXT_LIGHT
                    }
                }
            }
        },
        config = {
            align = "tli",
            bond = "Weak",
            offset = {
                x = 0,
                y = 0.0
            },
            major = G.ROOM_ATTACH
        }
    })
end

SMODS.current_mod.menu_cards = function()
    return {
        remove_original = true,
        { rank = 'Ace', suit = 'mania_applesuit' }
    }
end

