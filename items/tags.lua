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
                    context.card:set_edition("e_mania_citrico", true) -- custom citrus edition
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