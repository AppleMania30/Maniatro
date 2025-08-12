-- Booster Atlas
SMODS.Atlas{
    key = 'boosteratlas',
    path = 'boosters.png',
    px = 71,
    py = 95,
}

-- Booster Pack 1
SMODS.Booster{
    key = 'booster_maniatro',
    atlas = 'boosteratlas', 
    pos = { x = 0, y = 0 },
    discovered = true,
    loc_txt= {
        name = 'Semillas de manzanas',
        text = {
            "{C:green}¡Elige un joker de 3 de la edición Maniatro!{}"
        },
        group_name = "¡Planta tus semillas!"
    },
    draw_hand = false,
    config = {
        extra = 3,
        choose = 1, 
    },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.choose, card.ability.extra } }
    end,
    weight = 1,
    cost = 5,
    kind = "ManiatroPack",
    create_card = function(self, card, i)
        ease_background_colour(HEX("91f723"))
        return SMODS.create_card({
            set = "Maniatromod",
            area = G.pack_cards,
            skip_materialize = true,
            soulable = true,
        })
    end,
    select_card = 'jokers',
    in_pool = function() return true end
}

-- Booster Pack 2
SMODS.Booster{
    key = 'booster_maniatro2',
    atlas = 'boosteratlas', 
    pos = { x = 1, y = 0 },
    discovered = true,
    loc_txt= {
        name = 'Semillas de tomates',
        text = {
            "{C:red}¡Elige un joker de 4 de la edición Maniatro!{}"
        },
        group_name = "¡Planta tus semillas!"
    },
    draw_hand = false,
    config = {
        extra = 4,
        choose = 1, 
    },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.choose, card.ability.extra } }
    end,
    weight = 0.8,
    cost = 5,
    kind = "ManiatroPack",
    create_card = function(self, card, i)
        ease_background_colour(HEX("cc1033"))
        return SMODS.create_card({
            set = "Maniatromod",
            area = G.pack_cards,
            skip_materialize = true,
            soulable = true,
        })
    end,
    select_card = 'jokers',
    in_pool = function() return true end
}

-- Booster Pack 3
SMODS.Booster{
    key = 'booster_maniatro3',
    atlas = 'boosteratlas', 
    pos = { x = 0, y = 1 },
    discovered = true,
    loc_txt= {
        name = 'Semillas de arandanos',
        text = {
            "{C:spectral}¡Elige un joker de 5 de la edición Maniatro!{}"
        },
        group_name = "¡Planta tus semillas!"
    },
    draw_hand = false,
    config = {
        extra = 5,
        choose = 1, 
    },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.choose, card.ability.extra } }
    end,
    weight = 0.6,
    cost = 5,
    kind = "ManiatroPack",
    create_card = function(self, card, i)
        ease_background_colour(HEX("103ee3"))
        return SMODS.create_card({
            set = "Maniatromod",
            area = G.pack_cards,
            skip_materialize = true,
            soulable = true,
        })
    end,
    select_card = 'jokers',
    in_pool = function() return true end
}

-- Booster Pack 4
SMODS.Booster{
    key = 'booster_maniatro4',
    atlas = 'boosteratlas', 
    pos = { x = 1, y = 1 },
    discovered = true,
    loc_txt= {
        name = 'Semillas de sandias',
        text = {
            "{C:uncommon}¡Elige 2 jokers de 7 de la edición Maniatro!{}"
        },
        group_name = "¡Planta tus semillas!"
    },
    draw_hand = false,
    config = {
        extra = 7,
        choose = 2, 
    },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.choose, card.ability.extra } }
    end,
    weight = 0.4,
    cost = 5,
    kind = "ManiatroPack",
    create_card = function(self, card, i)
        ease_background_colour(HEX("5b9e3e"))
        return SMODS.create_card({
            set = "Maniatromod",
            area = G.pack_cards,
            skip_materialize = true,
            soulable = true,
        })
    end,
    select_card = 'jokers',
    in_pool = function() return true end
}