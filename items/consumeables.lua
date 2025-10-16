-- La acidez
SMODS.Atlas{
    key = 'acidity',
    path = 'acidity.png',
    px = 71,
    py = 95,
}

SMODS.Consumable{
    key = 'acidity',
    set = 'Tarot',
    loc_txt = {
        name = 'La acidez',
        text = {
            'Mejora {C:attention}2 cartas{}',
            'seleccionadas a {C:attention}Carta ácida{}'
        }
    },
    atlas = 'acidity',
    pos = {x = 0, y = 0},
    cost = 3,
    unlocked = true,
    discovered = true,
    hidden = false,
    can_repeat_soul = false,

    use = function(self, card, area, copier)
        local used_card = copier or card
        if #G.hand.highlighted == 2 then
            -- Animación inicial
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.4,
                func = function()
                    play_sound('tarot1')
                    used_card:juice_up(0.3, 0.5)
                    return true
                end
            }))

            -- Animación de volteo y jugo antes de aplicar mejora
            for i = 1, #G.hand.highlighted do
                local percent = 1.15 - (i - 0.999) / (#G.hand.highlighted - 0.998) * 0.3
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.15,
                    func = function()
                        G.hand.highlighted[i]:flip()
                        play_sound('card1', percent)
                        G.hand.highlighted[i]:juice_up(0.3, 0.3)
                        return true
                    end
                }))
            end

            delay(0.2)

            -- Aplicar mejora a Carta Ácida
            for i = 1, #G.hand.highlighted do
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.1,
                    func = function()
                        G.hand.highlighted[i]:set_ability(G.P_CENTERS['m_mania_citrico'])
                        return true
                    end
                }))
            end

            -- Animación de volteo y jugo después de aplicar mejora
            for i = 1, #G.hand.highlighted do
                local percent = 0.85 + (i - 0.999) / (#G.hand.highlighted - 0.998) * 0.3
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.15,
                    func = function()
                        G.hand.highlighted[i]:flip()
                        play_sound('tarot2', percent, 0.6)
                        G.hand.highlighted[i]:juice_up(0.3, 0.3)
                        return true
                    end
                }))
            end

            -- Quitar selección
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.2,
                func = function()
                    G.hand:unhighlight_all()
                    return true
                end
            }))

            delay(0.5)
        end
    end,

    can_use = function(self, card)
        return (#G.hand.highlighted == 2)
    end
}

-- La dulzura
SMODS.Atlas{
    key = 'sweetness',
    path = 'sweetness.png',
    px = 71,
    py = 95,
}

SMODS.Consumable{
    key = 'sweetness',
    set = 'Tarot',
    loc_txt = {
        name = 'La dulzura',
        text = {
            'Mejora {C:attention}2 cartas{}',
            'seleccionadas a {C:attention}Carta dulce{}'
        }
    },
    atlas = 'sweetness',
    pos = {x = 0, y = 0},
    cost = 3,
    unlocked = true,
    discovered = true,
    hidden = false,
    can_repeat_soul = false,

    use = function(self, card, area, copier)
        local used_card = copier or card
        if #G.hand.highlighted == 2 then
            -- Animación inicial
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.4,
                func = function()
                    play_sound('tarot1')
                    used_card:juice_up(0.3, 0.5)
                    return true
                end
            }))

            -- Animación de volteo y jugo antes de aplicar mejora
            for i = 1, #G.hand.highlighted do
                local percent = 1.15 - (i - 0.999) / (#G.hand.highlighted - 0.998) * 0.3
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.15,
                    func = function()
                        G.hand.highlighted[i]:flip()
                        play_sound('card1', percent)
                        G.hand.highlighted[i]:juice_up(0.3, 0.3)
                        return true
                    end
                }))
            end

            delay(0.2)

            -- Aplicar mejora a Carta dulce
            for i = 1, #G.hand.highlighted do
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.1,
                    func = function()
                        G.hand.highlighted[i]:set_ability(G.P_CENTERS['m_mania_dulce'])
                        return true
                    end
                }))
            end

            -- Animación de volteo y jugo después de aplicar mejora
            for i = 1, #G.hand.highlighted do
                local percent = 0.85 + (i - 0.999) / (#G.hand.highlighted - 0.998) * 0.3
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.15,
                    func = function()
                        G.hand.highlighted[i]:flip()
                        play_sound('tarot2', percent, 0.6)
                        G.hand.highlighted[i]:juice_up(0.3, 0.3)
                        return true
                    end
                }))
            end

            -- Quitar selección
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.2,
                func = function()
                    G.hand:unhighlight_all()
                    return true
                end
            }))

            delay(0.5)
        end
    end,

    can_use = function(self, card)
        return (#G.hand.highlighted == 2)
    end
}

-- La Manzana
SMODS.Atlas{
    key = 'manzana',
    path = 'manzana.png',
    px = 71,
    py = 95,
}

SMODS.Consumable{
    key = 'manzana',
    set = 'Tarot',
    loc_txt = {
        name = 'La manzana',
        text = {
            'Mejora {C:attention}3 cartas{}',
            'seleccionadas a {C:green}Manzanas{}'
        }
    },
    atlas = 'manzana',
    pos = {x = 0, y = 0},
    cost = 3,
    unlocked = true,
    discovered = true,
    hidden = false,
    can_repeat_soul = false,

    use = function(self, card, area, copier)
        local used_card = copier or card
        if #G.hand.highlighted == 3 then
            -- Animación inicial
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.4,
                func = function()
                    play_sound('tarot1')
                    used_card:juice_up(0.3, 0.5)
                    return true
                end
            }))

            -- Animación de volteo y jugo antes de aplicar mejora
            for i = 1, #G.hand.highlighted do
                local percent = 1.15 - (i - 0.999) / (#G.hand.highlighted - 0.998) * 0.3
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.15,
                    func = function()
                        G.hand.highlighted[i]:flip()
                        play_sound('card1', percent)
                        G.hand.highlighted[i]:juice_up(0.3, 0.3)
                        return true
                    end
                }))
            end

            delay(0.2)

            -- Cambiar el palo a Manzanas
            for i = 1, #G.hand.highlighted do
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.1,
                    func = function()
                        local card = G.hand.highlighted[i]
                        card:change_suit('mania_applesuit')
                        return true
                    end
                }))
            end

            -- Animación de volteo y jugo después de aplicar cambio
            for i = 1, #G.hand.highlighted do
                local percent = 0.85 + (i - 0.999) / (#G.hand.highlighted - 0.998) * 0.3
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.15,
                    func = function()
                        G.hand.highlighted[i]:flip()
                        play_sound('tarot2', percent, 0.6)
                        G.hand.highlighted[i]:juice_up(0.3, 0.3)
                        return true
                    end
                }))
            end

            -- Quitar selección
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.2,
                func = function()
                    G.hand:unhighlight_all()
                    return true
                end
            }))

            delay(0.5)
        end
    end,

    can_use = function(self, card)
        return (#G.hand.highlighted == 3)
    end
}

-- Vitamina
SMODS.Atlas{
    key = 'vitamina',
    path = 'vitamina.png',
    px = 71,
    py = 95,
}

SMODS.Consumable {
    key = 'vitamina',
    set = 'Spectral',
    pos = { x = 0, y = 0 },
    loc_txt = {
        name = 'Vitamina',
        text = {
        [1] = 'Agrega un {C:green}sello cítrico{}',
        [2] = 'a {C:attention}1{} carta seleccionada',
        [3] = 'de tu mano.'
    }
    },
    cost = 4,
    unlocked = true,
    discovered = true,
    hidden = false,
    can_repeat_soul = false,
    atlas = 'vitamina',
    use = function(self, card, area, copier)
        local used_card = copier or card
        if #G.hand.highlighted == 1 then
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.4,
                func = function()
                    play_sound('tarot1')
                    used_card:juice_up(0.3, 0.5)
                    return true
                end
            }))
            for i = 1, #G.hand.highlighted do
                local percent = 1.15 - (i - 0.999) / (#G.hand.highlighted - 0.998) * 0.3
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.15,
                    func = function()
                        G.hand.highlighted[i]:flip()
                        play_sound('card1', percent)
                        G.hand.highlighted[i]:juice_up(0.3, 0.3)
                        return true
                    end
                }))
            end
            delay(0.2)
            for i = 1, #G.hand.highlighted do
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.1,
                    func = function()
                        G.hand.highlighted[i]:set_seal("mania_sellocitrico", nil, true)
                        return true
                    end
                }))
            end
            for i = 1, #G.hand.highlighted do
                local percent = 0.85 + (i - 0.999) / (#G.hand.highlighted - 0.998) * 0.3
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.15,
                    func = function()
                        G.hand.highlighted[i]:flip()
                        play_sound('tarot2', percent, 0.6)
                        G.hand.highlighted[i]:juice_up(0.3, 0.3)
                        return true
                    end
                }))
            end
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.2,
                func = function()
                    G.hand:unhighlight_all()
                    return true
                end
            }))
            delay(0.5)
        end
    end,
    can_use = function(self, card)
        return (#G.hand.highlighted == 1)
    end
}

-- Aditivo
SMODS.Atlas{
    key = 'aditivo',
    path = 'aditivo.png',
    px = 71,
    py = 95,
}

SMODS.Consumable {
    key = 'aditivo',
    set = 'Spectral',
    pos = { x = 0, y = 0 },
    config = { extra = {
        edition_amount = 1,
        destroy_joker_amount = 1
    } },
    loc_txt = {
        name = 'Aditivo',
        text = {
            [1] = 'Agrega {C:dark_edition}cítrico{} a {C:attention}un{} comodín al azar,',
            [2] = 'pero destruye {C:attention}otro{} comodín al azar.'
        }
    },
    cost = 3,
    unlocked = true,
    discovered = true,
    hidden = false,
    can_repeat_soul = false,
    atlas = 'aditivo',
    use = function(self, card, area, copier)
        local used_card = copier or card
            local jokers_to_edition = {}
            local eligible_jokers = {}
            
            if 'any' == 'editionless' then
                eligible_jokers = SMODS.Edition:get_edition_cards(G.jokers, true)
            else
                for _, joker in pairs(G.jokers.cards) do
                    if joker.ability.set == 'Joker' then
                        eligible_jokers[#eligible_jokers + 1] = joker
                    end
                end
            end
            
            if #eligible_jokers > 0 then
                local temp_jokers = {}
                for _, joker in ipairs(eligible_jokers) do 
                    temp_jokers[#temp_jokers + 1] = joker 
                end
                
                pseudoshuffle(temp_jokers, 76543)
                
                for i = 1, math.min(card.ability.extra.edition_amount, #temp_jokers) do
                    jokers_to_edition[#jokers_to_edition + 1] = temp_jokers[i]
                end
            end

            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.4,
                func = function()
                    play_sound('timpani')
                    used_card:juice_up(0.3, 0.5)
                    return true
                end
            }))

            for _, joker in pairs(jokers_to_edition) do
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.2,
                    func = function()
                        joker:set_edition({ mania_citrico = true }, true)
                        return true
                    end
                }))
            end
            delay(0.6)
            local jokers_to_destroy = {}
            local deletable_jokers = {}
            
            for _, joker in pairs(G.jokers.cards) do
                if joker.ability.set == 'Joker' and not SMODS.is_eternal(joker, card) then
                    deletable_jokers[#deletable_jokers + 1] = joker
                end
            end
            
            if #deletable_jokers > 0 then
                local temp_jokers = {}
                for _, joker in ipairs(deletable_jokers) do 
                    temp_jokers[#temp_jokers + 1] = joker 
                end
                
                pseudoshuffle(temp_jokers, 98765)
                
                for i = 1, math.min(1, #temp_jokers) do
                    jokers_to_destroy[#jokers_to_destroy + 1] = temp_jokers[i]
                end
            end

            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.4,
                func = function()
                    play_sound('tarot1')
                    used_card:juice_up(0.3, 0.5)
                    return true
                end
            }))

            local _first_dissolve = nil
            G.E_MANAGER:add_event(Event({
                trigger = 'before',
                delay = 0.75,
                func = function()
                    for _, joker in pairs(jokers_to_destroy) do
                        joker:start_dissolve(nil, _first_dissolve)
                        _first_dissolve = true
                    end
                    return true
                end
            }))
            delay(0.6)
    end,
    can_use = function(self, card)
        return true
    end
}

--Simbolos Cloverpit
SMODS.Atlas({
    key = "CustomConsumables", 
    path = "CustomConsumables.png", 
    px = 71,
    py = 95, 
    atlas_table = "ASSET_ATLAS"
})

SMODS.ConsumableType {
    key = 'simbolos',
    primary_colour = HEX('400513'),
    secondary_colour = HEX('400513'),
    collection_rows = { 3, 4 },
    shop_rate = 5,
    cards = {
        ['c_mania_cerezas'] = true,
        ['c_mania_limon'] = true,
        ['c_mania_campanas'] = true,
        ['c_mania_treboles'] = true,
        ['c_mania_monedas'] = true,
        ['c_mania_diamantes'] = true,
        ['c_mania_sietes'] = true
    },
    loc_txt = {
        name = "Simbolos",
        collection = "Cloverpit",
    }
}

SMODS.Consumable {
    key = 'cerezas',
    set = 'simbolos',
    pos = { x = 0, y = 0 },
    config = { extra = {
        dollars_value = 2,
        mult_bonus = 2
    } },
    loc_txt = {
        name = 'Cerezas',
        text = {
        [1] = '{C:green}Consumir:{} {C:money}+2${}',
        [2] = '{C:green}Mantener:{} Cada {C:attention}2{} que',
        [3] = 'puntúe da {C:red}+2{} multi'
    }
    },
    cost = 2,
    unlocked = true,
    discovered = true,
    hidden = false,
    can_repeat_soul = false,
    atlas = 'CustomConsumables',
  calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            if context.other_card:get_id() == 2 then
                return {
                    mult = card.ability.extra.mult_bonus,
                    card = card
                }
            end
        end
  end,
  use = function(self, card, area, copier)
        local used_card = copier or card
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.4,
                func = function()
                    card_eval_status_text(used_card, 'extra', nil, nil, nil, {message = "+"..tostring(2).." $", colour = G.C.MONEY})
                    ease_dollars(2, true)
                    return true
                end
            }))
            delay(0.6)
    end,
    can_use = function(self, card)
        return true
    end
}

SMODS.Consumable {
    key = 'limon',
    set = 'simbolos',
    pos = { x = 1, y = 0 },
    config = { extra = {
        dollars_value = 2,
        dollar_bonus = 1
    } },
    loc_txt = {
        name = 'Limon',
        text = {
        [1] = '{C:green}Consumir:{} {C:money}+2${}',
        [2] = '{C:green}Mantener:{} Cada carta de',
        [3] = '{C:attention}Diamantes{} da {C:money}+1${}'
    }
    },
    cost = 2,
    unlocked = true,
    discovered = true,
    hidden = false,
    can_repeat_soul = false,
    atlas = 'CustomConsumables',
  calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            if context.other_card:is_suit('Diamonds') then
                return {
                    dollars = card.ability.extra.dollar_bonus,
                    card = card
                }
            end
        end
  end,
  use = function(self, card, area, copier)
        local used_card = copier or card
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.4,
                func = function()
                    card_eval_status_text(used_card, 'extra', nil, nil, nil, {message = "+"..tostring(2).." $", colour = G.C.MONEY})
                    ease_dollars(2, true)
                    return true
                end
            }))
            delay(0.6)
    end,
    can_use = function(self, card)
        return true
    end
}

SMODS.Consumable {
    key = 'treboles',
    set = 'simbolos',
    pos = { x = 2, y = 0 },
    config = { extra = {
        dollars_value = 3,
        mult_bonus = 3
    } },
    loc_txt = {
        name = 'Treboles',
        text = {
        [1] = '{C:green}Consumir:{} {C:money}+3${}',
        [2] = '{C:green}Mantener:{} Cada carta de',
        [3] = '{C:attention}Tréboles{} da {C:red}+3{} multi'
    }
    },
    cost = 3,
    unlocked = true,
    discovered = true,
    hidden = false,
    can_repeat_soul = false,
    atlas = 'CustomConsumables',
  calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            if context.other_card:is_suit('Clubs') then
                return {
                    mult = card.ability.extra.mult_bonus,
                    card = card
                }
            end
        end
  end,
  use = function(self, card, area, copier)
        local used_card = copier or card
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.4,
                func = function()
                    card_eval_status_text(used_card, 'extra', nil, nil, nil, {message = "+"..tostring(3).." $", colour = G.C.MONEY})
                    ease_dollars(3, true)
                    return true
                end
            }))
            delay(0.6)
    end,
    can_use = function(self, card)
        return true
    end
}

SMODS.Consumable {
    key = 'campanas',
    set = 'simbolos',
    pos = { x = 3, y = 0 },
    config = { extra = {
        dollars_value = 3,
        free_reroll_used = false
    } },
    loc_txt = {
        name = 'Campanas',
        text = {
        [1] = '{C:green}Consumir:{} {C:money}+3${}',
        [2] = '{C:green}Mantener:{} Una {C:attention}reposición',
        [3] = '{C:attention}gratis{} al final de la ronda'
    }
    },
    cost = 3,
    unlocked = true,
    discovered = true,
    hidden = false,
    can_repeat_soul = false,
    atlas = 'CustomConsumables',
  calculate = function(self, card, context)
        if context.ending_shop and not card.ability.extra.free_reroll_used then
            card.ability.extra.free_reroll_used = true
            G.E_MANAGER:add_event(Event({
                func = function()
                    if G.shop_jokers then
                        local cost = G.GAME.current_round.reroll_cost or 5
                        card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize('k_reroll'), colour = G.C.MONEY})
                        G.GAME.current_round.reroll_cost = 0
                        G.FUNCS.reroll_shop()
                        G.GAME.current_round.reroll_cost = cost
                    end
                    return true
                end
            }))
        end
        if context.end_of_round and not context.individual and not context.repetition then
            card.ability.extra.free_reroll_used = false
        end
  end,
  use = function(self, card, area, copier)
        local used_card = copier or card
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.4,
                func = function()
                    card_eval_status_text(used_card, 'extra', nil, nil, nil, {message = "+"..tostring(3).." $", colour = G.C.MONEY})
                    ease_dollars(3, true)
                    return true
                end
            }))
            delay(0.6)
    end,
    can_use = function(self, card)
        return true
    end
}

SMODS.Consumable {
    key = 'diamantes',
    set = 'simbolos',
    pos = { x = 4, y = 0 },
    config = { extra = {
        dollars_value = 5,
        xmult = 1.5
    } },
    loc_txt = {
        name = 'Diamantes',
        text = {
        [1] = '{C:green}Consumir:{} {C:money}+5${}',
        [2] = '{C:green}Mantener:{} Cada carta de',
        [3] = '{C:attention}Diamantes{} da {X:mult,C:white}X1.5{} multi'
    }
    },
    cost = 3,
    unlocked = true,
    discovered = true,
    hidden = false,
    can_repeat_soul = false,
    atlas = 'CustomConsumables',
  calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            if context.other_card:is_suit('Diamonds') then
                return {
                    x_mult = card.ability.extra.xmult,
                    card = card
                }
            end
        end
  end,
  use = function(self, card, area, copier)
        local used_card = copier or card
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.4,
                func = function()
                    card_eval_status_text(used_card, 'extra', nil, nil, nil, {message = "+"..tostring(5).." $", colour = G.C.MONEY})
                    ease_dollars(5, true)
                    return true
                end
            }))
            delay(0.6)
    end,
    can_use = function(self, card)
        return true
    end
}

SMODS.Consumable {
    key = 'monedas',
    set = 'simbolos',
    pos = { x = 5, y = 0 },
    config = { extra = {
        dollars_value = 5,
        end_round_dollars = 5
    } },
    loc_txt = {
        name = 'Monedas',
        text = {
        [1] = '{C:green}Consumir:{} {C:money}+5${}',
        [2] = '{C:green}Mantener:{} {C:money}+5${} al',
        [3] = 'final de cada ronda'
    }
    },
    cost = 3,
    unlocked = true,
    discovered = true,
    hidden = false,
    can_repeat_soul = false,
    atlas = 'CustomConsumables',
  calculate = function(self, card, context)
        if context.end_of_round and not context.individual and not context.repetition then
            return {
                message = "+"..tostring(card.ability.extra.end_round_dollars).." $",
                dollars = card.ability.extra.end_round_dollars,
                colour = G.C.MONEY,
                card = card
            }
        end
  end,
  use = function(self, card, area, copier)
        local used_card = copier or card
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.4,
                func = function()
                    card_eval_status_text(used_card, 'extra', nil, nil, nil, {message = "+"..tostring(5).." $", colour = G.C.MONEY})
                    ease_dollars(5, true)
                    return true
                end
            }))
            delay(0.6)
    end,
    can_use = function(self, card)
        return true
    end
}

SMODS.Consumable {
    key = 'sietes',
    set = 'simbolos',
    pos = { x = 6, y = 0 },
    config = { extra = {
        dollars_value = 7,
        xmult = 2.5
    } },
    loc_txt = {
        name = 'Sietes',
        text = {
        [1] = '{C:green}Consumir:{} {C:money}+7${}',
        [2] = '{C:green}Mantener:{} Cada {C:attention}7{}',
        [3] = 'jugado da {X:mult,C:white}X2.5{} multi'
    }
    },
    cost = 3,
    unlocked = true,
    discovered = true,
    hidden = false,
    can_repeat_soul = false,
    atlas = 'CustomConsumables',
  calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            if context.other_card:get_id() == 7 then
                return {
                    x_mult = card.ability.extra.xmult,
                    card = card
                }
            end
        end
  end,
  use = function(self, card, area, copier)
        local used_card = copier or card
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.4,
                func = function()
                    card_eval_status_text(used_card, 'extra', nil, nil, nil, {message = "+"..tostring(7).." $", colour = G.C.MONEY})
                    ease_dollars(7, true)
                    return true
                end
            }))
            delay(0.6)
    end,
    can_use = function(self, card)
        return true
    end
}


-- Cartucho
SMODS.Atlas({
    key = "cartuchito", 
    path = "bala.png", 
    px = 71,
    py = 95, 
    atlas_table = "ASSET_ATLAS"
})

SMODS.ConsumableType {
    key = 'municion',
    primary_colour = HEX('a14916'),
    secondary_colour = HEX('a14916'),
    collection_rows = { 2, 2 },
    shop_rate = 1,
    cards = {
        ['c_mania_shell'] = true,
    },
    loc_txt = {
        name = "Cartucho",
        collection = "Municion",
    }
}

SMODS.Consumable{
    key = 'shell',
    set = 'municion',
    loc_txt = {
        name = 'Cartucho de escopeta',
        text = {
            'Aumenta {X:mult,C:white}+2.25X{} multi al {C:attention}Comodín armero{}',
        }
    },
    atlas = 'cartuchito',
    pos = {x = 0, y = 0},
    cost = 3,
    unlocked = true,
    discovered = true,
    hidden = false,
    can_repeat_soul = false,

    use = function(self, card, area, copier)
        local used_card = copier or card
        
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                play_sound('tarot1')
                used_card:juice_up(0.3, 0.5)
                return true
            end
        }))
        
        delay(0.5)
    end,

    can_use = function(self, card)
        return true
    end
}