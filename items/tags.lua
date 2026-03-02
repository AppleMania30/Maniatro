-- Etiquetas de Maniatro
SMODS.Atlas{
    key = 'tag_citrica',
    path = 'tag_citrica.png',
    px = 32,
    py = 32,
}

-- Etiqueta Cítrica
SMODS.Tag {
    key = "citrica",
    loc_txt = {
        name = 'Etiqueta cítrica',
        text = { "El siguiente comodín de la tienda",
                "de edición base es {C:green}gratuito{} y",
                "se convierte en {C:dark_edition}cítrico{}" }
    },
    atlas = "tag_citrica",
    pos = { x = 0, y = 0 },
    apply = function(self, tag, context)
        if context.type == 'store_joker_modify' then
            if context.card and context.card.ability.set == 'Joker'
               and not context.card.edition and not context.card.temp_edition then
                local lock = tag.ID
                G.CONTROLLER.locks[lock] = true
                context.card.temp_edition = true
                tag:yep('+', G.C.GREEN, function()
                    context.card.temp_edition = nil
                    context.card:set_edition("e_mania_citrico", true) 
                    context.card.ability.couponed = true
                    context.card:set_cost()
                    G.CONTROLLER.locks[lock] = nil
                    return true
                end)
                tag.triggered = true
                return true
            end
        end
    end
}

-- Etiqueta Inusual
SMODS.Atlas{
    key = 'tag_maniatro_inusual',
    path = 'tag_acida.png',
    px = 32,
    py = 32,
}

SMODS.Tag {
    key = "maniatro_inusual",
    loc_txt = {
        name = 'Etiqueta Maniatro Inusual',
        text = {
            "La tienda tiene un",
            "{C:uncommon}comodín Maniatro inusual{} gratuito"
        }
    },
    atlas = "tag_maniatro_inusual",
    pos = { x = 0, y = 0 },
    apply = function(self, tag, context)
        if context.type == 'store_joker_create' then
            local candidates = {}
            for _, v in pairs(G.P_CENTER_POOLS['Maniatromod']) do
                if v.rarity == 2 then
                    candidates[#candidates + 1] = v.key
                end
            end
            local chosen = pseudorandom_element(candidates, pseudoseed("maniatrotag_inusual")) or "j_joker"
            local card = SMODS.create_card({
                set = "Joker",
                area = context.area,
                key = chosen,
                key_append = "maniatrotaginusual"
            })
            create_shop_card_ui(card, 'Joker', context.area)
            card.states.visible = false
            tag:yep('+', G.C.GREEN, function()
                card:start_materialize()
                card.ability.couponed = true
                card:set_cost()
                return true
            end)
            tag.triggered = true
            return card
        end
    end
}

-- Etiqueta Raro
SMODS.Atlas{
    key = 'tag_maniatro_raro',
    path = 'tag_dulce.png',
    px = 32,
    py = 32,
}

SMODS.Tag {
    key = "maniatro_raro",
    loc_txt = {
        name = 'Etiqueta Maniatro Raro',
        text = {
            "La tienda tiene un",
            "{C:rare}comodín Maniatro raro{} gratuito"
        }
    },
    atlas = "tag_maniatro_raro",
    pos = { x = 0, y = 0 },
    apply = function(self, tag, context)
        if context.type == 'store_joker_create' then
            local candidates = {}
            for _, v in pairs(G.P_CENTER_POOLS['Maniatromod']) do
                if v.rarity == 3 then
                    candidates[#candidates + 1] = v.key
                end
            end
            local chosen = pseudorandom_element(candidates, pseudoseed("maniatrotag_raro")) or "j_joker"
            local card = SMODS.create_card({
                set = "Joker",
                area = context.area,
                key = chosen,
                key_append = "maniatrotagraro"
            })
            create_shop_card_ui(card, 'Joker', context.area)
            card.states.visible = false
            tag:yep('+', G.C.GREEN, function()
                card:start_materialize()
                card.ability.couponed = true
                card:set_cost()
                return true
            end)
            tag.triggered = true
            return card
        end
    end
}