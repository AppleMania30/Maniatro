-- Apple Suit

SMODS.Atlas {
    key = 'applesuit',
    path = "applesuit.png",
    px = 71,
    py = 95
}

SMODS.Atlas {
    key = 'applesuithc',
    path = "applesuithc.png",
    px = 71,
    py = 95
}

SMODS.Atlas {
    key = 'appleicon',
    path = "appleicon.png",
    px = 18,
    py = 18
}

SMODS.Suit{
    key = 'applesuit',
    card_key = 'APL',
    lc_atlas = 'applesuit',
    hc_atlas = 'applesuithc',
    lc_ui_atlas = 'appleicon',
    hc_ui_atlas = 'appleicon',
    pos = { x = 0, y = 0 },
    ui_pos = { x = 0, y = 0 },
    lc_colour = HEX('56a507'),
    hc_colour = HEX('87cf0a'),
    in_pool = function(self, args)
        if G and G.GAME and G.GAME.selected_back and G.GAME.selected_back.effect
           and G.GAME.selected_back.effect.center
           and G.GAME.selected_back.effect.center.key == "b_checkered" then
            return false
        end
        return true
    end,
    loc_txt = {
        singular = 'Manzana',
        plural = 'Manzanas'
    }
}
