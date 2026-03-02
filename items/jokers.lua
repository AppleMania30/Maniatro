--- STEAMODDED HEADER
--- MOD_NAME: Maniatro
--- MOD_ID: MANIATRO
--- MOD_AUTHOR: AppleMania
--- MOD_DESCRIPTION: No
--- PREFIX: mania
----------------------------------------------
------------ MOD CODE -------------------------

-- Apple
SMODS.Atlas{
    key = 'apple',
    path = 'apple.png',
    px = 71,
    py = 95,
}

SMODS.Joker{
    key = 'apple',
    loc_txt = {
        name = 'Manzana verde',
        text = {
            'Si juegas exactamente {C:attention}5{} cartas,',
            'ganas {C:money}+3${} y {C:mult}+5{} multi por esa mano.'
        }
    },
    atlas = 'apple',
    rarity = 1,
    cost = 4,
    pools = {['Maniatromod'] = true},
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = false,
    perishable_compat = false,
    pos = {x=0, y=0},
    config = {},

    loc_vars = function(self, info_queue, center)
    info_queue[#info_queue+1] = {key = 'mania_credit_idea', set = 'Other', vars = { "AppleMania" }}
    return { vars = {} }
    end,

    calculate = function(self, card, context)
        if context.joker_main and context.full_hand and #context.full_hand == 5 then
            return {
                message = 'Yum...',
                mult_mod = 5,
                dollars = 3
            }
        end
    end,
}

-- Granny Smith
SMODS.Atlas{
    key = 'apple_plus',
    path = 'apple_plus.png',
    px = 71,
    py = 95,
}

SMODS.Joker{
    key = 'apple_plus',
    loc_txt = {
        name = 'Granny Smith',
        text = {
            'Si la mano jugada es un {C:green}#1#{}, añade',
            'una {C:green,E:1}carta ácida{} a tu mano.',
            '{C:inactive}El tipo de mano cambia cada ronda.'
        }
    },
    atlas = 'apple_plus',
    rarity = 2,
    cost = 7,
    pools = {['Maniatromod'] = true},
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = false,
    perishable_compat = false,
    config = { extra = { target_hand = nil } },

    loc_vars = function(self, info_queue, center)
        local target_hand = center.ability.extra.target_hand or "unknown"

        if target_hand == "mania_pkr_perdida" then
            target_hand = "Loss"
        elseif target_hand == "mania_pkr_triple_pareja" then
            target_hand = "Triple Pareja"
        elseif target_hand == "mania_pkr_doble_trio" then
            target_hand = "Doble Trío"
        elseif target_hand == "mania_pkr_color_plus" then
            target_hand = "Color+"
        end

        info_queue[#info_queue+1] = {key = 'mania_credit_idea', set = 'Other', vars = { "AppleMania" }}
        return { vars = { target_hand } }
    end,

    calculate = function(self, card, context)
        if context.setting_blind and not context.blueprint then
            local hands = {
                "Pair",
                "Two Pair",
                "Three of a Kind",
                "Straight",
                "Flush",
                "Full House",
                "Four of a Kind",
                "Straight Flush",
                "mania_pkr_perdida",
                "mania_pkr_triple_pareja",
                "mania_pkr_doble_trio",
                "mania_pkr_color_plus"
            }
            card.ability.extra.target_hand = hands[math.random(#hands)]
        end

        if context.joker_main and context.scoring_name and context.scoring_name == card.ability.extra.target_hand then
            SMODS.add_card{
                set = 'Enhanced',
                area = G.hand,
                enhancement = 'm_mania_citrico'
            }
            return {
                message = "Yum yum...",
                colour = G.C.GREEN
            }
        end
    end
}

-- Comodín Fructífero
SMODS.Atlas{
    key = 'fructifero',
    path = 'fructifero.png', 
    px = 71,
    py = 95,
}

SMODS.Joker{
    key = 'fructifero',
    loc_txt = {
        name = 'Comodín fructífero',
        text = {
            '{C:mult}+3{} multi por cada',
            'carta jugada con el palo',
            'de {C:green}Manzana{} cuando anota.'
        }
    },
    atlas = 'fructifero',
    rarity = 1,
    cost = 4,
    pools = {['Maniatromod'] = true},
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    pos = {x = 0, y = 0},
    config = { extra = { mult = 3, suit = 'mania_applesuit' } },

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = {key = 'mania_credit_idea', set = 'Other', vars = { "AppleMania" }}
        return {
            vars = {
                card.ability.extra.mult,
                localize(card.ability.extra.suit, 'suits_singular')
            }
        }
    end,

    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and context.other_card then
            if context.other_card:is_suit(card.ability.extra.suit) then
                return {
                    mult = card.ability.extra.mult,
                }
            end
        end
    end,

    check_for_unlock = function(self, args)
        unlock_card(self)
    end,
}

-- Ushanka
SMODS.Atlas{
    key = 'ushanka',
    path = 'bun.png',
    px = 71,
    py = 95,
}

SMODS.Joker{
    key = 'ushanka',
    loc_txt = {
        name = 'Ushanka',
        text = {
            'Obtienes {C:dark_edition}+1{} espacio de Joker',
            'pero tu mano se reduce en {C:red}-1{} carta'
        }
    },
    atlas = 'ushanka',
    rarity = 2,
    cost = 6,
    pools = {['Maniatromod'] = true},
    unlocked = true,
    discovered = true,
    blueprint_compat = false,
    eternal_compat = false,
    perishable_compat = false,
    pos = {x=0, y=0},
    config = {},

    loc_vars = function(self, info_queue, center)
        info_queue[#info_queue+1] = {key = 'mania_credit_idea', set = 'Other', vars = { "AppleMania" }}
        return { vars = {} }
    end,

    add_to_deck = function(self, card, from_debuff)
        G.jokers.config.card_limit = G.jokers.config.card_limit + 2
        G.hand.config.card_limit = G.hand.config.card_limit - 1
    end,

    remove_from_deck = function(self, card, from_debuff)
        G.jokers.config.card_limit = G.jokers.config.card_limit - 2
        G.hand.config.card_limit = G.hand.config.card_limit + 1
    end,
}

-- Ushanka desgastado
SMODS.Atlas{
    key = 'ushanka_des',
    path = 'ushanka_des.png', 
    px = 71,
    py = 95,
}

SMODS.Joker{
    key = 'ushanka_des',
    loc_txt = {
        name = 'Ushanka desgastado',
        text = {
            'Cada {C:attention}4{} rondas, hay un {C:green,E:1}25%{} de probabilidad',
            'de conseguir {C:dark_edition}+1{} espacio para Jokers.',
            '{C:inactive}Rondas: {C:attention}#1#/4{}'
        }
    },
    atlas = 'ushanka_des',
    rarity = 3,
    cost = 10,
    pools = {['Maniatromod'] = true},
    unlocked = true,
    discovered = true,
    blueprint_compat = false,
    eternal_compat = false,
    perishable_compat = false,
    pos = {x=0, y=0},
    config = {
        extra = {
            rounds_completed = 0,
            rounds_needed = 4,
            processed_round_end = false
        }
    },

    loc_vars = function(self, info_queue, center)
        info_queue[#info_queue+1] = {key = 'mania_credit_idea', set = 'Other', vars = { "AppleMania" }}
        return { vars = { center.ability.extra.rounds_completed } }
    end,

    calculate = function(self, card, context)
        if context.setting_blind and not context.blueprint then
            card.ability.extra.processed_round_end = false
            return
        end

        if context.end_of_round and not context.blueprint and not card.ability.extra.processed_round_end then
            card.ability.extra.processed_round_end = true
            card.ability.extra.rounds_completed = card.ability.extra.rounds_completed + 1
            
            if card.ability.extra.rounds_completed >= card.ability.extra.rounds_needed then
                card.ability.extra.rounds_completed = 0  
                
                if math.random() < 0.25 then
                    G.jokers.config.card_limit = G.jokers.config.card_limit + 1
                    
                    G.E_MANAGER:add_event(Event({
                        trigger = 'after',
                        delay = 0.5,
                        func = function()
                            card_eval_status_text(card, 'extra', nil, nil, nil, {
                                message = "Slot gained!",
                                colour = G.C.SUITS.Diamonds
                            })
                            card:juice_up(0.3, 0.5)
                            return true
                        end
                    }))
                else
                    G.E_MANAGER:add_event(Event({
                        trigger = 'after',
                        delay = 0.3,
                        func = function()
                            card_eval_status_text(card, 'extra', nil, nil, nil, {
                                message = "Not gained...",
                                colour = G.C.RED
                            })
                            return true
                        end
                    }))
                end
            else
                local remaining = card.ability.extra.rounds_needed - card.ability.extra.rounds_completed
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.3,
                    func = function()
                        card_eval_status_text(card, 'extra', nil, nil, nil, {
                            message = remaining .. " round" .. (remaining > 1 and "s" or "") .. " to attempt",
                            colour = G.C.SUITS.Diamonds
                        })
                        return true
                    end
                }))
            end
        end
    end,

    set_ability = function(self, card, initial, delay_sprites)
        card.ability.extra = card.ability.extra or {}
        card.ability.extra.rounds_completed = card.ability.extra.rounds_completed or 0
        card.ability.extra.rounds_needed = card.ability.extra.rounds_needed or 4
        card.ability.extra.processed_round_end = card.ability.extra.processed_round_end or false
    end,

    load = function(self, card, card_table)
        card.ability.extra = card.ability.extra or {}
        card.ability.extra.rounds_completed = card_table.ability.extra and card_table.ability.extra.rounds_completed or 0
        card.ability.extra.rounds_needed = card_table.ability.extra and card_table.ability.extra.rounds_needed or 4
        card.ability.extra.processed_round_end = false 
    end,

    check_for_unlock = function(self, args)
        unlock_card(self)
    end,
}

-- Xifox 
SMODS.Atlas{
    key = 'xifox',
    path = 'xifox.png',
    px = 71,
    py = 95,
}

SMODS.Joker{
    key = 'xifox',
    loc_txt = {
        name = 'Xifox',
        text = {
            '{X:mult,C:white}X2{} multi por cada {C:attention}7{} que puntúe.'
        }
    },
    atlas = 'xifox',
    rarity = 3,
    cost = 8,
    pools = {['Maniatromod'] = true},
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = false,
    perishable_compat = false,
    pos = {x=0, y=0},
    config = { extra = {xmult = 2} },

    loc_vars = function(self, info_queue, center)
        info_queue[#info_queue+1] = {key = 'mania_credit_idea', set = 'Other', vars = { "AppleMania, LukexsGame, Xifox" }}
        return { vars = { center.ability.extra.xmult } }
    end,

    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and context.other_card then
            if context.other_card:get_id() == 7 then
                return {
                    x_mult = card.ability.extra.xmult,
                    message = 'x' .. card.ability.extra.xmult,
                    colour = G.C.RED
                }
            end
        end
    end,
}

-- Xifox desgastado 
SMODS.Atlas{
    key = 'xifox_des',
    path = 'xifox_des.png',
    px = 71,
    py = 95,
}

SMODS.Joker{
    key = 'xifox_des',
    loc_txt = {
        name = 'Xifox desgastado',
        text = {
            'Si juegas un {C:attention}7{}, hay un {C:green,E:1}10%{} de',
            'probabilidad de hacerlo {C:dark_edition}policromo{}.'
        }
    },
    atlas = 'xifox_des',
    rarity = 3,
    cost = 10,
    pools = {['Maniatromod'] = true},
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = false,
    perishable_compat = false,
    pos = {x=0, y=0},
    config = {},

    loc_vars = function(self, info_queue, center)
        info_queue[#info_queue+1] = {key = 'mania_credit_idea', set = 'Other', vars = { "AppleMania" }}
        return { vars = {} }
    end,

    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and context.other_card then
            local oc = context.other_card

            if oc.get_id and type(oc.get_id) == "function" then
                local id = oc:get_id()
                if id == 7 then
                    if math.random() < 0.10 then
                        if oc.set_edition and type(oc.set_edition) == "function" then
                            G.E_MANAGER:add_event(Event({
                                trigger = 'after',
                                delay = 0.1,
                                func = function()
                                    local ok, err = pcall(function()
                                        oc:set_edition({polychrome = true}, true)
                                    end)
                                    if not ok then
                                        print("Error al aplicar polychrome:", err)
                                    else
                                        oc:juice_up(0.3, 0.5)
                                        card_eval_status_text(card, 'extra', nil, nil, nil, {
                                            message = "Polychrome!",
                                            colour = G.C.GREEN
                                        })
                                    end
                                    return true
                                end
                            }))
                        else
                            print("Advertencia: context.other_card no tiene set_edition")
                        end

                        return {
                            message = "¡Chacho!",
                            colour = G.C.GREEN
                        }
                    end
                end
            end
        end
    end,

    check_for_unlock = function(self, args)
        unlock_card(self)
    end,
}

-- Net
SMODS.Atlas{
    key = 'net',
    path = 'net.png',
    px = 71,
    py = 95,
}

SMODS.Joker{
    key = 'net',
    loc_txt = {
        name = 'NET',
        text = {
            'Si la mano jugada tiene exactamente {C:purple}tres palos{} distintos,',
            ' NET dará {X:chips,C:white} X2 {} chips.'
        }
    },
    atlas = 'net',
    rarity = 3,
    cost = 7,
    pools = {['Maniatromod'] = true},
    unlocked = true,
    discovered = true,
    blueprint_compat = false,
    eternal_compat = false,
    perishable_compat = false,
    pos = {x=0, y=0},
    config = {},

    loc_vars = function(self, info_queue, center)
        info_queue[#info_queue+1] = {key = 'mania_credit_idea', set = 'Other', vars = { "AppleMania" }}
        return { vars = {} }
    end,

    calculate = function(self, card, context)
        if context.joker_main and context.full_hand then
            local suits = {}
            for _, c in ipairs(context.full_hand) do
                suits[c.base.suit] = true
            end
            local count = 0
            for _ in pairs(suits) do count = count + 1 end
            if count == 3 then
                return {
                    message = '. . .',
                    x_chips = 2
                }
            end
        end
    end,
}

--Mun
SMODS.Atlas{
    key = 'mun',
    path = 'mun.png',
    px = 71,
    py = 95,
}

SMODS.Joker{
    key = 'mun',
    loc_txt = {
        name = 'Insomnio',
        text = {
            '{X:mult,C:white}X#1#{} multi',
            'Al comenzar una ronda, tiene {C:green,E:1}50%{} de ganar {X:mult,C:white}+0.5X{}.',
            'Si falla, se destruye.'
        }
    },
    atlas = 'mun',
    rarity = 3,
    cost = 8,
    pools = {['Maniatromod'] = true},
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = false,
    perishable_compat = false,
    pos = {x = 0, y = 0},
    config = { extra = { xmult = 1.5, gain = 0.5 } },

    loc_vars = function(self, info_queue, center)
        info_queue[#info_queue+1] = {key = 'mania_credit_idea', set = 'Other', vars = { "AppleMania" }}
        return { vars = { string.format("%.1f", center.ability.extra.xmult) } }
    end,

    calculate = function(self, card, context)
        if context.setting_blind and not context.blueprint then
            local success = math.random() < 0.50
            
            if success then
                card.ability.extra.xmult = card.ability.extra.xmult + card.ability.extra.gain
                card_eval_status_text(card, 'extra', nil, nil, nil, {
                    message = '+' .. card.ability.extra.gain .. 'x',
                    colour = G.C.RED
                })
                return {}
            else
                G.E_MANAGER:add_event(Event({
                    func = function()
                        play_sound('tarot1')
                        card.T.r = -0.2
                        card:juice_up(0.3, 0.4)
                        card.states.drag.is = false
                        card.children.center.pinch.x = true
                        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, blockable = false,
                            func = function()
                                G.jokers:remove_card(card)
                                card:remove()
                                card = nil
                                return true
                            end}))
                        return true
                    end
                }))
                return {
                    message = 'For being an asshole.',
                    colour = G.C.RED
                }
            end
        end

        if context.joker_main then
            return {
                Xmult_mod = card.ability.extra.xmult,
                message = 'x' .. string.format("%.1f", card.ability.extra.xmult),
                colour = G.C.RED
            }
        end
    end,

    check_for_unlock = function(self, args)
        unlock_card(self)
    end,
}

-- Proto
SMODS.Atlas{
    key = 'proto',
    path = 'proto.png',
    px = 71,
    py = 95,
}

SMODS.Joker{
    key = 'proto',
    loc_txt = {
        name = 'Proto',
        text = {
            'Por cada ronda, copia la habilidad',
            'de un {C:attention}Joker aleatorio{}.',
            'Copiando: {C:attention}#1#{}'
        }
    },
    atlas = 'proto',
    rarity = 4,
    cost = 15,
    pools = {['Maniatromod'] = true},
    unlocked = true,
    discovered = true,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = false,
    pos = { x = 0, y = 0 },
    config = {
        extra = {
            target_joker = nil,
            current_round = 0
        }
    },

    loc_vars = function(self, info_queue, center)
        info_queue[#info_queue+1] = {key = 'mania_credit_idea', set = 'Other', vars = { "AppleMania, DoggoDS" }}
        local target_name = "None"
        if center.ability.extra.target_joker
        and center.ability.extra.target_joker.config
        and center.ability.extra.target_joker.config.center then
            local name_data = center.ability.extra.target_joker.config.center.loc_txt
            if name_data and name_data.name then
                target_name = name_data.name
            else
                target_name = center.ability.extra.target_joker.config.center.name or "Unknown"
            end
        end
        return { vars = { target_name } }
    end,

    calculate = function(self, card, context)
        if context.setting_blind and not context.blueprint then
            local available_jokers = {}
            for _, joker in ipairs(G.jokers.cards) do
                if joker ~= card and joker.config and joker.config.center then
                    table.insert(available_jokers, joker)
                end
            end
            if #available_jokers > 0 then
                card.ability.extra.target_joker = available_jokers[math.random(#available_jokers)]
            else
                card.ability.extra.target_joker = nil
            end
            return
        end

        if card.ability.extra.target_joker then
            return SMODS.blueprint_effect(card, card.ability.extra.target_joker, context)
        end
    end,

    set_ability = function(self, card, initial, delay_sprites)
        card.ability.extra = card.ability.extra or {}
        card.ability.extra.target_joker = card.ability.extra.target_joker or nil
        card.ability.extra.current_round = card.ability.extra.current_round or (G.GAME and G.GAME.round or 0)
    end,

    load = function(self, card, card_table)
        card.ability.extra = card.ability.extra or {}
        card.ability.extra.target_joker = nil
        card.ability.extra.current_round = card_table.ability.extra and card_table.ability.extra.current_round or (G.GAME and G.GAME.round or 0)
    end,

    check_for_unlock = function(self, args)
        unlock_card(self)
    end,
}

-- FATAL
SMODS.Atlas{
    key = 'fatal',
    path = 'fatal.png',
    px = 71,
    py = 95,
}

SMODS.Joker{
    key = 'fatal',
    loc_txt = {
        name = 'FATAL',
        text = {
            '. . .'
        }
    },
    atlas = 'fatal',
    rarity = 4,
    cost = 10,
    pools = {['Maniatromod'] = true},
    unlocked = true,
    discovered = true,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = false,
    pos = { x = 0, y = 0 },
    config = {
        extra = {
            emult = 2 
        }
    },

    loc_vars = function(self, info_queue, center)
        info_queue[#info_queue+1] = {key = 'mania_credit_idea', set = 'Other', vars = { "AppleMania" }}
        return {
            vars = { center.ability.extra.emult }
        }
    end,

    calculate = function(self, card, context)
        if context.joker_main and context.cardarea == G.jokers then
            return {
                e_mult = card.ability.extra.emult,
                message = ". . .",
                colour = G.C.MULT
            }
        end
    end,

    set_ability = function(self, card, initial, delay_sprites)
        card.ability.extra = card.ability.extra or {}
        card.ability.extra.emult = card.ability.extra.emult or 2
    end,

    check_for_unlock = function(self, args)
        unlock_card(self)
    end,
}

-- OCEAN
SMODS.Atlas{
    key = 'ocean',
    path = 'ocean.png',
    px = 71,
    py = 95,
}

SMODS.Joker{
    key = 'ocean',
    loc_txt = {
        name = 'OCEAN',
        text = {
            '. . .'
        }
    },
    atlas = 'ocean',
    rarity = 4,
    cost = 20,
    pools = {['Maniatromod'] = true},
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    pos = { x = 0, y = 0 },
    config = {
        extra = {
            echips = 2 
        }
    },

    loc_vars = function(self, info_queue, center)
        info_queue[#info_queue+1] = {key = 'mania_credit_idea', set = 'Other', vars = { "AppleMania" }}
        return {
            vars = { center.ability.extra.echips }
        }
    end,

    calculate = function(self, card, context)
        if context.joker_main and context.cardarea == G.jokers then
            return {
                e_chips = card.ability.extra.echips,
                message = ". . .",
                colour = G.C.CHIPS
            }
        end
    end,

    set_ability = function(self, card, initial, delay_sprites)
        card.ability.extra = card.ability.extra or {}
        card.ability.extra.echips = card.ability.extra.echips or 2
    end,

    check_for_unlock = function(self, args)
        unlock_card(self)
    end,
}

-- Keep Rollin'
SMODS.Atlas{
    key = 'rollin',
    path = 'rollin.png',
    px = 71,
    py = 95,
}

SMODS.Joker{
    key = 'rollin',
    loc_txt = {
        name = "Keep Rollin'",
        text = {
            'Cualquier carta de {C:spades}picas{} jugada',
            'tiene un {C:green,E:1}25%{} de probabilidad de retriggearse.',
            'Si acierta, lo vuelve a intentar en la misma carta.'
        }
    },
    atlas = 'rollin',
    rarity = 2,
    cost = 7,
    pools = {['Maniatromod'] = true},
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = false,
    perishable_compat = false,
    pos = {x=0, y=0},
    soul_pos = { x = 0, y = 1 },
    config = {},

    loc_vars = function(self, info_queue, center)
        info_queue[#info_queue+1] = {key = 'mania_credit_idea', set = 'Other', vars = { "DoggoDS" }}
        return { vars = {} }
    end,

    calculate = function(self, card, context)
        if context.repetition and context.cardarea == G.play and context.other_card then
            if context.other_card:is_suit('Spades') then
                local repetitions = 0
                local continue_rolling = true
                
                while continue_rolling do
                    if math.random() < 0.25 then 
                        repetitions = repetitions + 1
                    else
                        continue_rolling = false
                    end
                end
                
                if repetitions > 0 then
                    local message = 'Keep Rollin!'
                    if repetitions > 1 then
                        message = 'Keep Rollin! x' .. repetitions
                    end
                    
                    return {
                        message = message,
                        repetitions = repetitions,
                        card = context.other_card,
                        colour = G.C.BLUE
                    }
                end
            end
        end
    end,

    check_for_unlock = function(self, args)
        unlock_card(self)
    end,
}

-- Jolteon
SMODS.Atlas{
    key = 'jolteon',
    path = 'jolteon.png',
    px = 71,
    py = 95,
}

SMODS.Joker{
    key = 'jolteon',
    loc_txt = {
        name = 'Jolteon',
        text = {
            'Las cartas jugadas con el palo de {C:diamonds}Diamantes{} tienen:',
            '{C:green}25%{} de probabilidad de dar {C:blue}+1{} mano',
            '{C:green}60%{} de probabilidad de {C:attention}copiarse{} a la mano',
            '{C:green}60%{} de probabilidad de {C:red}destruirse{}'
        }
    },
    atlas = 'jolteon',
    rarity = 3,
    cost = 6,
    pools = {['Maniatromod'] = true},
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    pos = {x = 0, y = 0},
    soul_pos = { x = 0, y = 1 },
    config = {
        extra = {
            odds_hand = 4,
            odds_copy = 5,
            odds_destroy = 5,
            hands = 1
        }
    },

    loc_vars = function(self, info_queue, center)
        info_queue[#info_queue+1] = {key = 'mania_credit_idea', set = 'Other', vars = { "DoggoDS" }}
        return { 
            vars = {
                center.ability.extra.odds_hand,
                center.ability.extra.odds_copy,
                center.ability.extra.odds_destroy
            } 
        }
    end,

    calculate = function(self, card, context)
        if context.destroy_card and context.destroy_card.should_destroy then
            return { remove = true }
        end

        if context.individual and context.cardarea == G.play then
            context.other_card.should_destroy = false
            
            if context.other_card:is_suit("Diamonds") then
                if pseudorandom('jolteon_hand') < G.GAME.probabilities.normal / card.ability.extra.odds_hand then
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {
                                message = "+" .. tostring(card.ability.extra.hands) .. " Hand",
                                colour = G.C.SUITS.Diamonds
                            })
                            G.GAME.current_round.hands_left = G.GAME.current_round.hands_left + card.ability.extra.hands
                            return true
                        end
                    }))
                end

                if pseudorandom('jolteon_copy') < (3 * G.GAME.probabilities.normal) / card.ability.extra.odds_copy then
                    G.playing_card = (G.playing_card and G.playing_card + 1) or 1
                    local copied_card = copy_card(context.other_card, nil, nil, G.playing_card)
                    copied_card:add_to_deck()
                    G.deck.config.card_limit = G.deck.config.card_limit + 1
                    table.insert(G.playing_cards, copied_card)
                    G.hand:emplace(copied_card)
                    copied_card.states.visible = nil
                    
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            copied_card:start_materialize()
                            card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {
                                message = "Copied!",
                                colour = G.C.SUITS.Diamonds
                            })
                            return true
                        end
                    }))
                end

                if pseudorandom('jolteon_destroy') < (3 * G.GAME.probabilities.normal) / card.ability.extra.odds_destroy then
                    context.other_card.should_destroy = true
                    card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {
                        message = "Destroyed!",
                        colour = G.C.RED
                    })
                end
            end
        end
    end,
}

-- Loss
SMODS.Atlas{
    key = 'loss',
    path = 'loss.png',
    px = 71,
    py = 95,
}

SMODS.Joker{
    key = 'loss',
    loc_txt = {
        name = 'Loss',
        text = {
            'Si la mano jugada es {C:attention}Loss{},',
            'gana {X:mult,C:white}X3{} multi.'
        }
    },
    atlas = 'loss',
    rarity = 2,
    cost = 5,
    pools = {['Maniatromod'] = true},
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = false,
    perishable_compat = false,
    pos = {x=0, y=0},
    config = {},

    loc_vars = function(self, info_queue, center)
        info_queue[#info_queue+1] = {key = 'mania_credit_idea', set = 'Other', vars = { "LukexsGame, AppleMania" }}
        return { vars = {} }
    end,

    calculate = function(self, card, context)
        if context.joker_main and context.poker_hands and context.poker_hands['mania_pkr_perdida'] then
            return {
                message = 'Loss',
                Xmult_mod = 3
            }
        end
    end,

    check_for_unlock = function(self, args)
        unlock_card(self)
    end,
}

-- Obituary
SMODS.Atlas{
    key = 'obituary',
    path = 'obituary.png',
    px = 71,
    py = 95,
}

SMODS.Joker{
    key = 'obituary',
    loc_txt = {
        name = 'Obituary',
        text = {
            'Cada {C:attention}As{} o {C:attention}2{} jugado dará {C:mult}+4{} multi.'
        }
    },
    atlas = 'obituary',
    rarity = 2,
    cost = 6,
    pools = {['Maniatromod'] = true},
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    pos = {x=0, y=0},
    config = {
        extra = {
            mult_per_card = 4,
        }
    },

    loc_vars = function(self, info_queue, center)
        info_queue[#info_queue+1] = {key = 'mania_credit_idea', set = 'Other', vars = { "AppleMania" }}
        return { vars = {} }
    end,

    calculate = function(self, card, context)
        if context.individual 
           and context.cardarea == G.play 
           and context.other_card 
           and not context.repetition then

            local id = context.other_card:get_id()
            if id == 14 or id == 2 then
                return {
                    mult = card.ability.extra.mult_per_card,
                    message = "+" .. card.ability.extra.mult_per_card .. " Mult",
                    colour = G.C.MULT
                }
            end
        end
    end,

    check_for_unlock = function(self, args)
        unlock_card(self)
    end,
}

-- Amongla 
SMODS.Atlas{
    key = 'amongla',
    path = 'amongla.png',
    px = 71,
    py = 95,
}

SMODS.Joker{
    key = 'amongla',
    loc_txt = {
        name = 'Amongla',
        text = {
            '{X:mult,C:white}X#1#{} multi',
            '{C:green,E:1}0.125%{} de probabilidad',
            'de cerrar el juego.'
        }
    },
    atlas = 'amongla',
    rarity = 3,
    cost = 8,
    pools = {['Maniatromod'] = true},
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = false,
    perishable_compat = false,
    pos = {x = 0, y = 0},
    config = { extra = { xmult = 3 } },

    loc_vars = function(self, info_queue, center)
        info_queue[#info_queue+1] = {key = 'mania_credit_idea', set = 'Other', vars = { "AppleMania" }}
        return { vars = { center.ability.extra.xmult } }
    end,

    calculate = function(self, card, context)
        if context.joker_main then
            if math.random(1, 8) == 1 then
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.5,
                    func = function()
                        card_eval_status_text(card, 'extra', nil, nil, nil, {
                            message = 'AMONGLA',
                            colour = G.C.RED
                        })
                        
                        G.E_MANAGER:add_event(Event({
                            trigger = 'after',
                            delay = 1.0,
                            func = function()
                                love.event.quit()
                                return true
                            end
                        }))
                        return true
                    end
                }))
            end
            
            return {
                message = "x" .. card.ability.extra.xmult,
                Xmult_mod = card.ability.extra.xmult,
                colour = G.C.RED
            }
        end
    end,

    check_for_unlock = function(self, args)
        unlock_card(self)
    end,
}

-- Amongla desgastado
SMODS.Atlas{
    key = 'amongla_des',
    path = 'amongla_des.png',  
    px = 71,
    py = 95,
}

SMODS.Joker{
    key = 'amongla_des',
    loc_txt = {
        name = 'Amongla desgastado',
        text = {
            '{X:mult,C:white}X#1#{} multi',
            '{C:green,E:1}25%{} de probabilidad',
            'de cerrar el juego.'
        }
    },
    atlas = 'amongla_des',
    rarity = 4,
    cost = 10,
    pools = {['Maniatromod'] = true},
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = false,
    perishable_compat = false,
    pos = {x = 0, y = 0},
    config = { extra = { xmult = 6 } },

    loc_vars = function(self, info_queue, center)
        info_queue[#info_queue+1] = {key = 'mania_credit_idea', set = 'Other', vars = { "AppleMania" }}
        return { vars = { center.ability.extra.xmult } }
    end,

    calculate = function(self, card, context)
        if context.joker_main then
            if math.random() < 0.25 then
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.5,
                    func = function()
                        card_eval_status_text(card, 'extra', nil, nil, nil, {
                            message = '¡GILIPOLLAS!',
                            colour = G.C.RED
                        })

                        G.E_MANAGER:add_event(Event({
                            trigger = 'after',
                            delay = 1.0,
                            func = function()
                                love.event.quit()
                                return true
                            end
                        }))
                        return true
                    end
                }))
            end

            return {
                message = "x" .. card.ability.extra.xmult,
                Xmult_mod = card.ability.extra.xmult,
                colour = G.C.RED
            }
        end
    end,

    set_ability = function(self, card, initial, delay_sprites)
        card.ability.extra = card.ability.extra or {}
        card.ability.extra.xmult = card.ability.extra.xmult or 6
    end,

    check_for_unlock = function(self, args)
        unlock_card(self)
    end,
}

-- Red Dead Redemption II
SMODS.Atlas{
    key = 'arthur_honor',
    path = 'rdr.png',
    px = 71,
    py = 95,
}

SMODS.Joker{
    key = 'arthur_honor',
    loc_txt = {
        name = 'Red Dead Redemption II',
        text = {
            'Si ganas la ronda en tu primer intento, {C:mult}+15{} multi',
            'Si usas más de un intento, {C:red}-5{} multi al acabar de la ronda.',
            'Actual: {C:mult}+#1#{} multi'
        }
    },
    atlas = 'arthur_honor',
    rarity = 2,
    cost = 6,
    pools = {['Maniatromod'] = true},
    unlocked = true,
    discovered = true,
    blueprint_compat = false,
    eternal_compat = false,
    perishable_compat = false,
    pos = {x = 0, y = 0},
    config = { 
        extra = { 
            current_mult = 0,
            mult_gain = 15,
            mult_loss = 5,
            round_attempts = 0,
            round_won = false
        } 
    },

    loc_vars = function(self, info_queue, center)
        info_queue[#info_queue+1] = {key = 'mania_credit_idea', set = 'Other', vars = { "AppleMania, Xifox" }}
        return { vars = { center.ability.extra.current_mult } }
    end,

    calculate = function(self, card, context)
        if context.setting_blind and not context.blueprint then
            card.ability.extra.round_attempts = 0
            card.ability.extra.round_won = false
        end

        if context.joker_main and not card.ability.extra.round_won then
            card.ability.extra.round_attempts = card.ability.extra.round_attempts + 1
        end

        if context.end_of_round and not context.blueprint and not card.ability.extra.round_won then
            card.ability.extra.round_won = true
            
            if card.ability.extra.round_attempts == 1 then
                card.ability.extra.current_mult = card.ability.extra.current_mult + card.ability.extra.mult_gain
                
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.3,
                    func = function()
                        card_eval_status_text(card, 'extra', nil, nil, nil, {
                            message = "High Honor! +" .. card.ability.extra.mult_gain .. " Mult",
                            colour = G.C.GREEN
                        })
                        return true
                    end
                }))
                
            else
                local prev_mult = card.ability.extra.current_mult
                card.ability.extra.current_mult = math.max(0, prev_mult - card.ability.extra.mult_loss)
                
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.3,
                    func = function()
                        card_eval_status_text(card, 'extra', nil, nil, nil, {
                            message = "Low Honor... -" .. card.ability.extra.mult_loss .. " Mult",
                            colour = G.C.RED
                        })
                        return true
                    end
                }))
            end
        end

        if context.joker_main and card.ability.extra.current_mult > 0 then
            return {
                mult_mod = card.ability.extra.current_mult,
                message = "+" .. card.ability.extra.current_mult .. " Multi (Arthur)",
                colour = G.C.MULT
            }
        end
    end,

    set_ability = function(self, card, initial, delay_sprites)
        card.ability.extra = card.ability.extra or {}
        card.ability.extra.current_mult = card.ability.extra.current_mult or 0
        card.ability.extra.mult_gain = card.ability.extra.mult_gain or 15
        card.ability.extra.mult_loss = card.ability.extra.mult_loss or 5
        card.ability.extra.round_attempts = card.ability.extra.round_attempts or 0
        card.ability.extra.round_won = card.ability.extra.round_won or false
    end,

    check_for_unlock = function(self, args)
        unlock_card(self)
    end,
}

-- Minion Pigs
SMODS.Atlas{
    key = 'minion_pigs',
    path = 'pigs.png',
    px = 71,
    py = 95,
}

SMODS.Joker{
    key = 'minion_pigs',
    loc_txt = {
        name = 'Minion Pigs',
        text = {
            'Por cada {C:green}Joker de rareza común{}',
            'adquirido, este Joker obtiene',
            '{C:red}+#1#{} multi.',
            'Actual: {C:red}+#2#{} multi'
        }
    },
    atlas = 'minion_pigs',
    rarity = 3,
    cost = 7,
    pools = {['Maniatromod'] = true},
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    pos = {x=0, y=0},
    config = {
        extra = {
            mult_per_common = 15,
            total_mult = 0
        }
    },
    loc_vars = function(self, info_queue, center)
        info_queue[#info_queue+1] = {key = 'mania_credit_idea', set = 'Other', vars = { "AppleMania" }}
        return {
            vars = {
                center.ability.extra.mult_per_common,
                center.ability.extra.total_mult
            }
        }
    end,
    calculate = function(self, card, context)
        if context.joker_main and card.ability.extra.total_mult > 0 then
            return {
                mult_mod = card.ability.extra.total_mult,
                message = localize{type = 'variable', key = 'a_mult', vars = {card.ability.extra.total_mult}},
                colour = G.C.GREEN
            }
        end

        if context.buying_card and context.card and context.card.ability and context.card.ability.set == 'Joker' then
            card.ability.extra.mult_per_common = card.ability.extra.mult_per_common or 15

            if context.card.config and context.card.config.center and context.card.config.center.rarity == 1 then
                card.ability.extra.total_mult = card.ability.extra.total_mult + card.ability.extra.mult_per_common

                return {
                    message = "Common Joker acquired! +" .. card.ability.extra.mult_per_common .. " Mult",
                    colour = G.C.GREEN,
                    card = card
                }
            end
        end
    end,
    update = function(self, card)
        local common_jokers = 0
        if G and G.jokers and G.jokers.cards then
            for _, j in ipairs(G.jokers.cards) do
                if j.config and j.config.center and j.config.center.rarity == 1 and j ~= card then
                    common_jokers = common_jokers + 1
                end
            end
        end
        card.ability.extra.total_mult = common_jokers * card.ability.extra.mult_per_common
    end,
    set_ability = function(self, card, initial, delay_sprites)
        card.ability.extra = card.ability.extra or {}
        card.ability.extra.total_mult = card.ability.extra.total_mult or 0
        card.ability.extra.mult_per_common = card.ability.extra.mult_per_common or 15

        if initial then
            local common_jokers = 0
            if G and G.jokers and G.jokers.cards then
                for _, joker in ipairs(G.jokers.cards) do
                    if joker.config and joker.config.center and joker.config.center.rarity == 1 and joker ~= card then
                        common_jokers = common_jokers + 1
                    end
                end
            end
            card.ability.extra.total_mult = common_jokers * card.ability.extra.mult_per_common
        end
    end,
}

-- Ale 
SMODS.Atlas{
    key = 'ale',
    path = 'ale.png',
    px = 71,
    py = 95,
}

SMODS.Joker{
    key = 'ale',
    loc_txt = {
        name = 'Ale',
        text = {
            'Cada vez que juegas una mano, hay una probabilidad',
            'del {C:green,E:1}50%{} de darte {C:blue}+50{} chips o quitarte {C:red}-50{} chips.'
        }
    },
    atlas = 'ale',
    rarity = 2,
    cost = 6,
    pools = {['Maniatromod'] = true},
    unlocked = true,
    discovered = true,
    blueprint_compat = false,
    eternal_compat = false,
    perishable_compat = false,
    pos = {x = 0, y = 0},
    config = { extra = { chips = 50 } },

    loc_vars = function(self, info_queue, center)
        info_queue[#info_queue+1] = {key = 'mania_credit_idea', set = 'Other', vars = { "AppleMania" }}
        return { vars = {} }
    end,

    calculate = function(self, card, context)
        if context.joker_main then
            local gain = math.random() < 0.5
            local value = card.ability.extra.chips
            return {
                chip_mod = gain and value or -value,
                message = gain and ("+50 chips"):format(value) or ("-50 chips"):format(value),
                colour = gain and G.C.BLUE or G.C.RED
            }
        end
    end,

    check_for_unlock = function(self, args)
        unlock_card(self)
    end,
}

-- Bima
SMODS.Atlas{
    key = 'bima',
    path = 'bima.png',  
    px = 71,
    py = 95,
}

SMODS.Joker{
    key = 'bima',
    loc_txt = {
        name = 'Bima',
        text = {
            'Si la mano jugada contiene',
            '{C:attention}dos ases{}, gana {X:mult,C:white}+0.5X{} multi',
            '{C:inactive}(Actual: {X:mult,C:white}X#1#{C:inactive})'
        }
    },
    atlas = 'bima',
    rarity = 3,
    cost = 9,
    pools = {['Maniatromod'] = true},
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = false,
    perishable_compat = false,
    pos = {x = 0, y = 0},
    config = {
        extra = {
            x_mult = 1.0
        }
    },
    
    loc_vars = function(self, info_queue, center)
        info_queue[#info_queue+1] = {key = 'mania_credit_idea', set = 'Other', vars = { "AppleMania" }}
        return {
            vars = {
                center.ability.extra.x_mult
            }
        }
    end,

    calculate = function(self, card, context)
        if context.joker_main then
            local ace_count = 0
            if G.play and G.play.cards then
                for _, played_card in ipairs(G.play.cards) do
                    if played_card:get_id() == 14 then
                        ace_count = ace_count + 1
                    end
                end
            end
            
            if ace_count >= 2 then
                card.ability.extra.x_mult = card.ability.extra.x_mult + 0.5
                
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.1,
                    func = function()
                        card_eval_status_text(card, 'extra', nil, nil, nil, {
                            message = ace_count .. " Aces! +0.5X",
                            colour = G.C.RED
                        })
                        return true
                    end
                }))
            end
            
            if card.ability.extra.x_mult > 1 then
                return {
                    x_mult = card.ability.extra.x_mult,
                    message = "X" .. card.ability.extra.x_mult,
                    colour = G.C.MULT
                }
            end
        end
    end,

    check_for_unlock = function(self, args)
        unlock_card(self)
    end,
}

-- Doggo
SMODS.Atlas{
    key = 'doggo',
    path = 'doggo.png',
    px = 71,
    py = 95,
}

SMODS.Joker{
    key = 'doggo',
    loc_txt = {
        name = 'Doggo',
        text = {
            '{C:attention}X#1#{} mult al jugar la última mano.',
            'Carga {C:green}+#2#{} por cada ficha generada.',
            '{C:inactive}(Carga actual: {C:attention}#1#{})'
        }
    },
    atlas = 'doggo',
    rarity = 3,
    cost = 6,
    pools = {['Maniatromod'] = true},
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    pos = {x = 0, y = 0},
    config = { extra = { Charge = 1 } },

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = {key = 'mania_credit_idea', set = 'Other', vars = { "DoggoDS" }}
        return { vars = { card.ability.extra.Charge, (G.GAME.current_round.current_hand.chips or 0) * 0.0025 } }
    end,

    calculate = function(self, card, context)
        if context.before and context.cardarea == G.jokers and not context.blueprint then
            return {
                func = function()
                    card.ability.extra.Charge = card.ability.extra.Charge + (G.GAME.current_round.current_hand.chips) * 0.0025
                    return true
                end,
                message = "Charge!"
            }
        end
        if context.cardarea == G.jokers and context.joker_main then
            if to_big(G.GAME.current_round.hands_left) == to_big(0) then
                local Charge_value = card.ability.extra.Charge
                card.ability.extra.Charge = 1
                return {
                    e_mult = Charge_value
                }
            end
        end
    end
}

-- Lukexs
SMODS.Atlas{
    key = 'lukexs',
    path = 'lukexs.png',
    px = 71,
    py = 95,
}

SMODS.Joker{
    key = 'lukexs',
    config = {
        extra = {}
    },
    loc_txt = {
        name = 'Lukexs',
        text = {
            [1] = 'Cada vez que pases una {C:attention}ciega jefe{},',
            [2] = 'un {C:attention}Rey{} de un palo aleatorio de',
            [3] = '{C:attention}acero{}, {C:dark_edition}policromo{} y con',
            [4] = '{C:red}sello rojo{} se añade a tu baraja.'
        }
    },
    pos = { x = 0, y = 0 },
    cost = 7,
    rarity = 3,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'lukexs',
    pools = { ['Maniatromod'] = true },

    loc_vars = function(self, info_queue, center)
        info_queue[#info_queue+1] = {key = 'mania_credit_idea', set = 'Other', vars = { "AppleMania" }}
        return { vars = {} }
    end,

    calculate = function(self, card, context)
        if context.end_of_round and context.main_eval and G.GAME.blind.boss  then
            local suit_prefix = pseudorandom_element({'H','S','D','C'}, pseudoseed("lukexs_suit"))
            local card_front = G.P_CARDS[suit_prefix..'_K']
            local base_card = create_playing_card({
                front = card_front,
                center = G.P_CENTERS.m_steel
            }, G.discard, true, false, nil, true)
            
            base_card:set_seal("Red", true)
            
            base_card:set_edition("e_polychrome", true)
            
            G.E_MANAGER:add_event(Event({
                func = function()
                    base_card:start_materialize()
                    G.play:emplace(base_card)
                    return true
                end
            }))
            return {
                func = function()
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            G.deck.config.card_limit = G.deck.config.card_limit + 1
                            return true
                        end
                    }))
                    draw_card(G.play, G.deck, 90, 'up')
                    SMODS.calculate_context({ playing_card_added = true, cards = { base_card } })
                end,
                message = "Bee Movie."
            }
        end
    end
}

-- Javier25
SMODS.Atlas{
    key = 'javier25',
    path = 'javier.png',
    px = 71,
    py = 95,
}

SMODS.Joker{
    key = 'javier25',
    loc_txt = {
        name = 'Javier25',
        text = {
            '{C:blue}+1{} tamaño de jugada.'
        }
    },
    atlas = 'javier25',
    rarity = 2,
    cost = 6,
    pools = {['Maniatromod'] = true},
    unlocked = true,
    discovered = true,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    pos = { x = 0, y = 0 },
    config = {},

    loc_vars = function(self, info_queue, center)
        info_queue[#info_queue+1] = {key = 'mania_credit_idea', set = 'Other', vars = { "AppleMania" }}
        return { vars = {} }
    end,

    add_to_deck = function(self, card, from_debuff)
        SMODS.change_play_limit(1)
    end,

    remove_from_deck = function(self, card, from_debuff)
        SMODS.change_play_limit(-1)
    end,

    check_for_unlock = function(self, args)
        unlock_card(self)
    end,
}

-- Julio
SMODS.Atlas{
    key = 'julio',
    path = 'julio.png',
    px = 71,
    py = 95
}

SMODS.Joker{
    key = 'julio',
    loc_txt = {
        name = 'Julio',
        text = {
            '{C:spectral}+#1#{} multi',
            'Cada {C:spectral}4 manos{} jugadas,',
            '{X:dark_edition,C:white}^2{} multi',
            '{C:inactive}Manos: {C:spectral}#2#/4'
        }
    },
    atlas = 'julio',
    rarity = 4,
    cost = 20,
    pools = {},  
    unlocked = true,  
    discovered = true,  
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = false,
    pos = {x = 0, y = 0},
    config = { 
        extra = { 
            base_mult = 2.4,
            hands_played = 0,
            squaring_cycles = 0
        } 
    },

    loc_vars = function(self, info_queue, center)
        info_queue[#info_queue+1] = {key = 'mania_credit_idea', set = 'Other', vars = { "Julio24pro" }}
        return { 
            vars = { 
                center.ability.extra.base_mult, 
                center.ability.extra.hands_played,
                "N/A"  
            } 
        }
    end,

    calculate = function(self, card, context)
        if context.joker_main then
            card.ability.extra.hands_played = card.ability.extra.hands_played + 1
            
            local current_mult = card.ability.extra.base_mult ^ (card.ability.extra.squaring_cycles + 1)
            
            if card.ability.extra.hands_played >= 4 then
                card.ability.extra.hands_played = 0
                
                local old_mult = current_mult
                current_mult = current_mult * current_mult 
                
                card.ability.extra.base_mult = current_mult
                card.ability.extra.squaring_cycles = 0  
                
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.1,
                    func = function()
                        card_eval_status_text(card, 'extra', nil, nil, nil, {
                            message = "Squared! " .. old_mult .. "² = +" .. current_mult,
                            colour = G.C.BLUE
                        })
                        return true
                    end
                }))
            end
            
            return {
                mult_mod = current_mult,
                message = "+" .. current_mult .. " Multi",
                colour = G.C.MULT
            }
        end
    end,

    set_ability = function(self, card, initial, delay_sprites)
        card.ability.extra = card.ability.extra or {}
        card.ability.extra.base_mult = card.ability.extra.base_mult or 24
        card.ability.extra.hands_played = card.ability.extra.hands_played or 0
        card.ability.extra.squaring_cycles = card.ability.extra.squaring_cycles or 0
        
        if initial then
            self.discovered = true
        end
    end,

    add_to_deck = function(self, card, from_debuff)
        self.discovered = true
    end,

    can_use = function(self, card)
        return true  
    end,

    get_weight = function(self)
        return 0 
    end,

    check_for_unlock = function(self, args)
        return false
    end,
}

-- Al revés
SMODS.Atlas{
    key = 'al_reves',
    path = 'alreves.png', 
    px = 71,
    py = 95,
}

SMODS.Joker {
    key = 'al_reves',
    loc_txt = {
        name = 'Al Revés',
        text = {
            'Al comprar cualquier {C:attention}comodín{}',
            'se vuelve {C:dark_edition}negativo{}, {C:dark_edition}cítrico{} o {C:dark_edition}iridiscente{}',
            ' ',
            'La mano jugada y las cartas en mano',
            '{C:attention}contribuyen a la puntuación{}',
            'y se reactivan {C:attention}#1#{} vez(veces)',
            '{C:inactive}(Igual al número de comodines poseídos)',
        }
    },
    atlas = 'al_reves',
    pools = { ['Maniatromod'] = true },
    pos = { x = 0, y = 0 },
    cost = 20,
    rarity = 4,
    unlocked = true,
    discovered = true,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = false,

    loc_vars = function(self, info_queue, center)
        info_queue[#info_queue+1] = {key = 'mania_credit_idea', set = 'Other', vars = { ". . ." }}
    return { vars = { G.jokers and #G.jokers.cards or 0 } }
    end,

    calculate = function(self, card, context)
        if context.buying_card and not context.blueprint then
            local target = context.card
            if target and target ~= card and target.ability and target.ability.set == 'Joker' and not target.edition then
                target.about_to_get_edition_from_alreves = true
                G.E_MANAGER:add_event(Event({
                    func = function()
                        target.about_to_get_edition_from_alreves = nil
                        local roll = math.random(3)
                        if roll == 1 then
                            target:set_edition({ negative = true }, true)
                        elseif roll == 2 then
                            target:set_edition({ mania_citrico = true }, true)
                        else
                            target:set_edition({ mania_iridiscente = true }, true)
                        end
                        return true
                    end
                }))
                card_eval_status_text(card, 'extra', nil, nil, nil, {
                    message = '. . .',
                    colour = G.C.DARK_EDITION,
                })
            end
        end

        if context.repetition and not context.blueprint then
            local scoring_card = context.other_card
            if scoring_card and (scoring_card.area == G.hand or scoring_card.area == G.play) then
                local joker_count = #G.jokers.cards
                if joker_count > 0 then
                    return {
                        message = localize('k_again_ex'),
                        repetitions = joker_count,
                        card = card,
                    }
                end
            end
        end
    end,
}

function add_alreves_cards(scoring_hand)
    if next(SMODS.find_card('j_mania_al_reves')) then
        for i = 1, #G.hand.cards do
            local c = G.hand.cards[i]
            if c and not c.highlighted and not (c.config and c.config.center and c.config.center.unhighlightable) then
                table.insert(scoring_hand, c)
            end
        end
    end
end

function is_scoring_area_alreves(area)
    if area == G.play then return true end
    if next(SMODS.find_card('j_mania_al_reves')) then
        return area == G.hand
    end
end

-- Caja vacía
SMODS.Atlas{
    key = 'box',
    path = 'box.png',
    px = 71,
    py = 95
}

SMODS.Joker{
    key = 'box',
    loc_txt = {
        name = 'Caja vacía',
        text = {
            '. . .',
            '{C:spectral}#1#/4',
        }
    },
    atlas = 'box',
    rarity = 3,
    cost = 10,
    pools = {['Maniatromod'] = true},
    unlocked = true,
    discovered = true,
    blueprint_compat = false,
    eternal_compat = false,
    perishable_compat = false,
    pos = {x = 0, y = 0},
    config = { 
        extra = { 
            hands_played = 0
        } 
    },

    loc_vars = function(self, info_queue, center)
        info_queue[#info_queue+1] = {key = 'mania_credit_idea', set = 'Other', vars = { "Julio24pro" }}
        return { vars = { center.ability.extra.hands_played } }
    end,

    calculate = function(self, card, context)
        if context.joker_main then
            card.ability.extra.hands_played = card.ability.extra.hands_played + 1
            
            if card.ability.extra.hands_played >= 4 then
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.3,
                    func = function()
                        local julio = create_card('Joker', G.jokers, nil, nil, nil, nil, 'j_mania_julio')
                        julio:add_to_deck()
                        G.jokers:emplace(julio)
                        
                        card_eval_status_text(julio, 'extra', nil, nil, nil, {
                            message = "Julio has awakened!",
                            colour = G.C.BLUE
                        })
                        
                        G.jokers:remove_card(card)
                        card:remove()
                        
                        return true
                    end
                }))
                
                return {
                    message = "Transforming!",
                    colour = G.C.BLUE
                }
            else
                return {
                    message = card.ability.extra.hands_played .. "/4 hands",
                    colour = G.C.BLUE
                }
            end
        end
    end,

    set_ability = function(self, card, initial, delay_sprites)
        card.ability.extra = card.ability.extra or {}
        card.ability.extra.hands_played = card.ability.extra.hands_played or 0
    end,

    check_for_unlock = function(self, args)
        unlock_card(self)
    end,
}

-- Nauiyo
SMODS.Atlas{
    key = 'nauiyo',
    path = 'nauiyo.png',
    px = 71,
    py = 95,
}

SMODS.Joker{
    key = 'nauiyo',
    loc_txt = {
        name = 'Nauiyo',
        text = {
            '{X:mult,C:white}+0.2X{} por cada carta más en tu baraja,',
            '{X:mult,C:white}-0.2X{} por cada carta menos en tu baraja.',
            'Actual: {X:mult,C:white}X#1#{} multi',
        }
    },
    atlas = 'nauiyo',
    rarity = 3,
    cost = 7,
    pools = {['Maniatromod'] = true},
    unlocked = true,
    discovered = true,
    blueprint_compat = false,
    eternal_compat = false,
    perishable_compat = false,
    pos = {x = 0, y = 0},
    config = {
        extra = {
            xmult = 1.0,
            last_max_deck_size = 52 
        }
    },

    loc_vars = function(self, info_queue, center)
        local current_mult = center.ability.extra.xmult or 1.0
        info_queue[#info_queue+1] = {key = 'mania_credit_idea', set = 'Other', vars = { "Nauiyo" }}
        return { vars = { string.format("%.1f", current_mult) } }
    end,

    calculate = function(self, card, context)
        if context.joker_main then
            return {
                x_mult = card.ability.extra.xmult,
                message = 'x' .. string.format("%.1f", card.ability.extra.xmult),
                colour = G.C.RED
            }
        end
    end,

    update = function(self, card, dt)
        if G.deck and G.GAME and G.GAME.current_round then
            local current_max_deck_size = G.deck.config.card_limit or 52
            local last_max_size = card.ability.extra.last_max_deck_size
            
            if current_max_deck_size ~= last_max_size then
                local difference = current_max_deck_size - last_max_size
                local xmult_change = difference * 0.2
                
                card.ability.extra.xmult = math.max(0.1, card.ability.extra.xmult + xmult_change)
                card.ability.extra.last_max_deck_size = current_max_deck_size
                
                if difference > 0 then
                    card_eval_status_text(card, 'extra', nil, nil, nil, {
                        message = '+X' .. string.format("%.1f", math.abs(xmult_change)) .. ' (+'.. difference ..' max cards)',
                        colour = G.C.GREEN
                    })
                elseif difference < 0 then
                    card_eval_status_text(card, 'extra', nil, nil, nil, {
                        message = '-X' .. string.format("%.1f", math.abs(xmult_change)) .. ' ('.. difference ..' max cards)',
                        colour = G.C.RED
                    })
                end
            end
        end
    end,

    set_ability = function(self, card, initial, delay_sprites)
        card.ability.extra = card.ability.extra or {}
        card.ability.extra.xmult = card.ability.extra.xmult or 1.0
        
        if initial and G.deck then
            card.ability.extra.last_max_deck_size = G.deck.config.card_limit or 52
        else
            card.ability.extra.last_max_deck_size = card.ability.extra.last_max_deck_size or 52
        end
    end,

    check_for_unlock = function(self, args)
        unlock_card(self)
    end,
}

-- Tablet 
SMODS.Atlas{
    key = 'tablet',
    path = 'tablet.png',
    px = 71,
    py = 95,
}

SMODS.Joker{
    key = 'tablet',
    loc_txt = {
        name = 'Tablet',
        text = {
            'Si repites el mismo {C:purple}tipo de mano{} en dos jugadas seguidas,',
            'el multiplicador pasa a {X:mult,C:white}X2.5{} y aumenta',
            '{X:mult,C:white}+0.5X{} por cada repetición adicional.',
            'Actual: {X:mult,C:white}X#1#{} multi'
        }
    },
    atlas = 'tablet',
    rarity = 3,
    cost = 8,
    pools = {['Maniatromod'] = true},
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = false,
    perishable_compat = false,
    pos = {x = 0, y = 0},
    config = { 
        extra = { 
            last_hand_type = nil,
            consecutive_count = 0,
            base_mult = 2.5,
            increment = 0.5
        } 
    },

    loc_vars = function(self, info_queue, center)
        local current_mult = 0
        if center.ability.extra.consecutive_count > 0 then
            current_mult = center.ability.extra.base_mult + 
                          (center.ability.extra.increment * (center.ability.extra.consecutive_count - 1))
        end
        info_queue[#info_queue+1] = {key = 'mania_credit_idea', set = 'Other', vars = { "AppleMania" }}
        return { vars = { string.format("%.1f", current_mult) } }
    end,

    calculate = function(self, card, context)
        if context.joker_main and context.scoring_name then
            local current_hand_type = context.scoring_name
            
            print("Tablet detectó mano: " .. tostring(current_hand_type))
            
            if current_hand_type then
                if card.ability.extra.last_hand_type == current_hand_type then
                    card.ability.extra.consecutive_count = card.ability.extra.consecutive_count + 1
                    
                    local total_mult = card.ability.extra.base_mult + 
                                      (card.ability.extra.increment * (card.ability.extra.consecutive_count - 1))
                    
                    card.ability.extra.last_hand_type = current_hand_type

                    card.canvas_text = SMODS.CanvasSprite({
                        text_colour = G.C.RED,
                        ref_table = card.ability.extra,
                        ref_value = 'canvas_mult_display',
                        text_offset = {x = 0, y = -30},
                        text_width = 48,
                        text_height = 16,
                    })
                    card.ability.extra.canvas_mult_display = string.format("X%.1f", total_mult)
                    
                    return {
                        message = string.format("x%.1f (%s x%d)", total_mult, current_hand_type, card.ability.extra.consecutive_count + 1),
                        Xmult_mod = total_mult,
                        colour = G.C.RED
                    }
                else
                    card.ability.extra.consecutive_count = 0
                    card.ability.extra.last_hand_type = current_hand_type
                    card.canvas_text = nil
                    card.ability.extra.canvas_mult_display = nil
                    
                    print("Tablet: Nueva mano, reiniciando contador")
                end
            end
        end
    end,

    set_ability = function(self, card, initial, delay_sprites)
        card.ability.extra = card.ability.extra or {}
        card.ability.extra.last_hand_type = card.ability.extra.last_hand_type or nil
        card.ability.extra.consecutive_count = card.ability.extra.consecutive_count or 0
        card.ability.extra.base_mult = card.ability.extra.base_mult or 2.5
        card.ability.extra.increment = card.ability.extra.increment or 0.5
    end,

    check_for_unlock = function(self, args)
        unlock_card(self)
    end,
}

-- Espejo
SMODS.Atlas{
    key = 'espejo',
    path = 'espejo.png',
    px = 71,
    py = 95,
}

SMODS.Joker{
    key = 'espejo',
    loc_txt = {
        name = 'Espejo',
        text = {
            'Cada {C:attention}4 rondas{}, crea una copia',
            'del último Joker vendido.',
            '{C:inactive}Último vendido: {C:attention}#1#{}',
            '{C:inactive}Rondas restantes: {C:attention}#2#{}'
        }
    },
    atlas = 'espejo',
    rarity = 3,
    cost = 8,
    pools = {['Maniatromod'] = true},
    unlocked = true,
    discovered = true,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = false,
    pos = {x = 0, y = 0},
    config = {
        extra = {
            last_sold_joker = nil,
            last_sold_name = "None",
            rounds_remaining = 4,
            processed_round_end = false
        }
    },

    loc_vars = function(self, info_queue, center)
        info_queue[#info_queue+1] = {key = 'mania_credit_idea', set = 'Other', vars = { "AppleMania" }}
        return {
            vars = {
                center.ability.extra.last_sold_name,
                center.ability.extra.rounds_remaining
            }
        }
    end,

    calculate = function(self, card, context)
        if context.setting_blind and not context.blueprint then
            card.ability.extra.processed_round_end = false
            return
        end

        if context.selling_card and context.card and context.card.ability and context.card.ability.set == 'Joker' then
            card.ability.extra.last_sold_joker = context.card.config.center.key
            
            local joker_name = "Unknown"
            if context.card.config and context.card.config.center then
                local center = context.card.config.center
                if center.loc_txt and center.loc_txt.name then
                    joker_name = center.loc_txt.name
                elseif center.name then
                    joker_name = center.name
                end
            end
            
            card.ability.extra.last_sold_name = joker_name
            
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.1,
                func = function()
                    card_eval_status_text(card, 'extra', nil, nil, nil, {
                        message = "Saved: " .. joker_name,
                        colour = G.C.BLUE
                    })
                    return true
                end
            }))
            
            return {
                message = "Joker saved!",
                colour = G.C.MONEY
            }
        end

        if context.end_of_round and not context.blueprint and not card.ability.extra.processed_round_end then
            card.ability.extra.processed_round_end = true
            card.ability.extra.rounds_remaining = card.ability.extra.rounds_remaining - 1
            
            if card.ability.extra.rounds_remaining <= 0 and card.ability.extra.last_sold_joker then
                local joker_key = card.ability.extra.last_sold_joker
                
                if G.P_CENTERS[joker_key] then
                    G.E_MANAGER:add_event(Event({
                        trigger = 'after',
                        delay = 0.5,
                        func = function()
                            local new_joker = create_card('Joker', G.jokers, nil, nil, nil, nil, joker_key)
                            new_joker:add_to_deck()
                            G.jokers:emplace(new_joker)
                            
                            card:juice_up(0.3, 0.5)
                            new_joker:juice_up(0.3, 0.5)
                            
                            card_eval_status_text(card, 'extra', nil, nil, nil, {
                                message = "Copied!",
                                colour = G.C.GREEN
                            })
                            
                            return true
                        end
                    }))
                    
                    card.ability.extra.rounds_remaining = 4
                    card.ability.extra.last_sold_joker = nil
                    card.ability.extra.last_sold_name = "None"
                    
                    return {
                        message = "Joker replicated!",
                        colour = G.C.MULT
                    }
                else
                    card.ability.extra.rounds_remaining = 4
                    card.ability.extra.last_sold_joker = nil
                    card.ability.extra.last_sold_name = "None"

                    return {
                        message = "Error!",
                        colour = G.C.RED
                    }
                end
            else
                local remaining = card.ability.extra.rounds_remaining
                if remaining > 0 then
                    G.E_MANAGER:add_event(Event({
                        trigger = 'after',
                        delay = 0.3,
                        func = function()
                            card_eval_status_text(card, 'extra', nil, nil, nil, {
                                message = remaining .. " round" .. (remaining > 1 and "s" or ""),
                                colour = G.C.BLUE
                            })
                            return true
                        end
                    }))
                end
            end
        end
    end,

    set_ability = function(self, card, initial, delay_sprites)
        card.ability.extra = card.ability.extra or {}
        card.ability.extra.last_sold_joker = card.ability.extra.last_sold_joker or nil
        card.ability.extra.last_sold_name = card.ability.extra.last_sold_name or "None"
        card.ability.extra.rounds_remaining = card.ability.extra.rounds_remaining or 4
        card.ability.extra.processed_round_end = card.ability.extra.processed_round_end or false
    end,

    load = function(self, card, card_table)
        card.ability.extra = card.ability.extra or {}
        card.ability.extra.last_sold_joker = card_table.ability.extra and card_table.ability.extra.last_sold_joker or nil
        card.ability.extra.last_sold_name = card_table.ability.extra and card_table.ability.extra.last_sold_name or "None"
        card.ability.extra.rounds_remaining = card_table.ability.extra and card_table.ability.extra.rounds_remaining or 4
        card.ability.extra.processed_round_end = false
    end,

    check_for_unlock = function(self, args)
        unlock_card(self)
    end,
}

-- Bella
SMODS.Atlas{
    key = 'bella',
    path = 'bella.png',
    px = 71,
    py = 95,
}

SMODS.Joker{
    key = 'bella',
    loc_txt = {
        name = 'Bella',
        text = {
            'Por cada {C:dark_edition}gato{} que tengas',
            'comprado, {X:chips,C:white}+2X{} chips.',
            'Actual: {X:chips,C:white}X#1#{}'
        }
    },
    atlas = 'bella',
    rarity = 3,
    cost = 8,
    pools = {['Maniatromod'] = true},
    unlocked = true,
    discovered = true,
    blueprint_compat = false,
    eternal_compat = false,
    perishable_compat = false,
    pos = {x = 0, y = 0},
    config = { extra = { cat_count = 0, x_chips = 1 } },
    loc_vars = function(self, info_queue, center)
        info_queue[#info_queue+1] = {key = 'mania_credit_idea', set = 'Other', vars = { "AppleMania" }}
        return { vars = { center.ability.extra.x_chips } }
    end,
    calculate = function(self, card, context)
        if context.setting_blind and not context.blueprint then
            card.ability.extra.cat_count = 0
            local cat_jokers = {'j_mania_rufino', 'j_mania_sappho', 'j_mania_evil_pisu', 'j_mania_mia', 'j_mania_galileo', 'j_mania_jack', 'j_mania_kiki'}
            
            for _, j in ipairs(G.jokers.cards) do
                if j.config and j.config.center then
                    for _, cat_key in ipairs(cat_jokers) do
                        if j.config.center.key == cat_key then
                            card.ability.extra.cat_count = card.ability.extra.cat_count + 1
                            break
                        end
                    end
                end
            end
            
            card.ability.extra.x_chips = math.max(1, 2 * card.ability.extra.cat_count)
            
            if card.ability.extra.cat_count > 0 then
                return {
                    message = 'Cats: '..card.ability.extra.cat_count,
                    colour = G.C.PURPLE
                }
            end
        end
        
        if context.joker_main and card.ability.extra.x_chips > 1 then
            return {
                message = 'X'..card.ability.extra.x_chips..' Chips',
                x_chips = card.ability.extra.x_chips,
                colour = G.C.CHIPS
            }
        end
    end,
    check_for_unlock = function(self, args)
        unlock_card(self)
    end,
}

-- Rufino
SMODS.Atlas{
    key = 'rufino',
    path = 'rufino.png',
    px = 71,
    py = 95,
}

SMODS.Joker{
    key = 'rufino',
    loc_txt = {
        name = 'Rufino',
        text = {
            '{C:red}+#1#{} multi por cada {C:purple}consumible{} usado.',
            'Actual: {C:red}+#2#{} multi'
        }
    },
    atlas = 'rufino',
    rarity = 2,
    cost = 6,
    pools = {['Maniatromod'] = true},
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    pos = {x = 0, y = 0}, 
    config = { 
        extra = { 
            mult_per_consumed = 3,
            total_mult = 0
        } 
    },

    loc_vars = function(self, info_queue, center)
        info_queue[#info_queue+1] = {key = 'mania_credit_idea', set = 'Other', vars = { "AppleMania" }}
        return { 
            vars = { 
                center.ability.extra.mult_per_consumed,
                center.ability.extra.total_mult 
            } 
        }
    end,

    calculate = function(self, card, context)
        if context.joker_main and card.ability.extra.total_mult > 0 then
            return {
                mult_mod = card.ability.extra.total_mult,
                message = localize{type = 'variable', key = 'a_mult', vars = {card.ability.extra.total_mult}},
                colour = G.C.RED
            }
        end

        if context.using_consumeable and context.consumeable then
            card.ability.extra.total_mult = card.ability.extra.total_mult + card.ability.extra.mult_per_consumed
            
            return {
                message = "Card consumed! +" .. card.ability.extra.mult_per_consumed .. " Mult",
                colour = G.C.RED,
                card = card
            }
        end
    end,

    set_ability = function(self, card, initial, delay_sprites)
        card.ability.extra = card.ability.extra or {}
        card.ability.extra.total_mult = card.ability.extra.total_mult or 0
        card.ability.extra.mult_per_consumed = card.ability.extra.mult_per_consumed or 3
    end,

    check_for_unlock = function(self, args)
        unlock_card(self)
    end,
}



-- EVIL Rufino
SMODS.Atlas{
    key = 'evil_rufino',
    path = 'evilrufino.png',
    px = 71,
    py = 95,
}
SMODS.Joker{
    key = 'evil_rufino',
    loc_txt = {
        name = 'EVIL Rufino',
        text = {
            '{X:mult,C:white}X#1#{} multi',
            'Aumenta {X:mult,C:white}+0.01X{} por',
            'cada segundo transcurrido.',
        }
    },
    atlas = 'evil_rufino',
    rarity = 4,
    cost = 8,
    pools = {['Maniatromod'] = true},
    unlocked = true,
    discovered = true,
    blueprint_compat = false,
    eternal_compat = false,
    perishable_compat = false,
    pos = {x = 0, y = 0}, 
    config = {
        extra = {
            xmult = 1.0,
            start_time = nil
        }
    },

    loc_vars = function(self, info_queue, center)
        if not center.ability.extra.start_time then
            center.ability.extra.start_time = love.timer.getTime()
        end
        local elapsed = love.timer.getTime() - center.ability.extra.start_time
        local current_mult = 1.0 + (elapsed * 0.01)
        info_queue[#info_queue+1] = {key = 'mania_credit_idea', set = 'Other', vars = { "AppleMania" }}
        return { vars = { string.format("%.2f", current_mult) } }
    end,

    calculate = function(self, card, context)
        if context.joker_main then
            if not card.ability.extra.start_time then
                card.ability.extra.start_time = love.timer.getTime()
            end
            local elapsed = love.timer.getTime() - card.ability.extra.start_time
            local current_mult = 1.0 + (elapsed * 0.01)
            return {
                Xmult_mod = current_mult,
                message = "X" .. string.format("%.2f", current_mult),
                colour = G.C.RED
            }
        end
    end,

    set_ability = function(self, card, initial, delay_sprites)
        card.ability.extra = card.ability.extra or {}
        card.ability.extra.start_time = card.ability.extra.start_time or love.timer.getTime()
    end,

    check_for_unlock = function(self, args)
        unlock_card(self)
    end,
}

-- Sappho
SMODS.Atlas{
    key = 'sappho',
    path = 'sappho.png',
    px = 71,
    py = 95,
}
SMODS.Joker{
    key = 'sappho',
    loc_txt = {
        name = 'Sappho',
        text = {
            '{X:mult,C:white}X#1#{} multi si la mano jugada',
            'no contiene ninguna {C:purple}figura.{}',
        }
    },
    atlas = 'sappho',
    rarity = 2,
    cost = 7,
    pools = {['Maniatromod'] = true},
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = false,
    perishable_compat = false,
    pos = {x = 0, y = 0}, 
    config = { extra = { xmult = 2 } },

    loc_vars = function(self, info_queue, center)
        info_queue[#info_queue+1] = {key = 'mania_credit_idea', set = 'Other', vars = { "Lauxs_v0" }}
        return { vars = { center.ability.extra.xmult } }
    end,

    calculate = function(self, card, context)
        if context.joker_main and context.full_hand then
            local has_face_card = false
            
            for _, played_card in ipairs(context.full_hand) do
                local rank = played_card:get_id()
                if rank == 11 or rank == 12 or rank == 13 then  
                    has_face_card = true
                    break
                end
            end
            
            if not has_face_card then
                return {
                    message = "X" .. card.ability.extra.xmult .. " (No faces)",
                    Xmult_mod = card.ability.extra.xmult,
                    colour = G.C.RED
                }
            end
        end
    end,

    check_for_unlock = function(self, args)
        unlock_card(self)
    end,
}

-- Mia
SMODS.Atlas{
    key = 'mia',
    path = 'mia.png',
    px = 71,
    py = 95,
}

SMODS.Joker{
    key = 'mia',
    loc_txt = {
        name = 'Mia',
        text = {
            'Si ganas la ronda sin hacer ningún descarte,',
            'gana {C:chips}+25{} chips.',
            'Si descartas, perderá todo el progreso.',
            'Actual: {C:chips}+#1#{} chips'
        }
    },
    atlas = 'mia',
    rarity = 2,
    cost = 6,
    pools = {['Maniatromod'] = true},
    unlocked = true,
    discovered = true,
    blueprint_compat = false,
    eternal_compat = false,
    perishable_compat = false,
    pos = {x = 0, y = 0},
    config = {
        extra = {
            chips = 0,
            discarded_this_round = false,
            processed_round_end = false
        }
    },

    loc_vars = function(self, info_queue, center)
        info_queue[#info_queue+1] = {key = 'mania_credit_idea', set = 'Other', vars = { "Bunbxnblxxd" }}
        return { vars = { center.ability.extra.chips } }
    end,

    calculate = function(self, card, context)
        if context.setting_blind and not context.blueprint then
            card.ability.extra.discarded_this_round = false
            card.ability.extra.processed_round_end = false
            return
        end

        if context.discard and not context.blueprint then
            if not card.ability.extra.discarded_this_round then
                card.ability.extra.discarded_this_round = true
                
                if card.ability.extra.chips > 0 then
                    card.ability.extra.chips = 0
                    
                    G.E_MANAGER:add_event(Event({
                        trigger = 'after',
                        delay = 0.1,
                        func = function()
                            card_eval_status_text(card, 'extra', nil, nil, nil, {
                                message = "Progress lost!",
                                colour = G.C.RED
                            })
                            return true
                        end
                    }))
                end
            end
        end

        if context.end_of_round and not context.blueprint and not card.ability.extra.processed_round_end then
            card.ability.extra.processed_round_end = true
            
            if not card.ability.extra.discarded_this_round then
                card.ability.extra.chips = card.ability.extra.chips + 25
                
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.3,
                    func = function()
                        card_eval_status_text(card, 'extra', nil, nil, nil, {
                            message = "+25 Permanent Chips",
                            colour = G.C.CHIPS
                        })
                        return true
                    end
                }))
                
                return {
                    message = "No discards!",
                    colour = G.C.GREEN
                }
            end
        end

        if context.joker_main and card.ability.extra.chips > 0 then
            return {
                chip_mod = card.ability.extra.chips,
                message = "+" .. card.ability.extra.chips .. " Chips (Mia)",
                colour = G.C.CHIPS
            }
        end
    end,

    set_ability = function(self, card, initial, delay_sprites)
        card.ability.extra = card.ability.extra or {}
        card.ability.extra.chips = card.ability.extra.chips or 0
        card.ability.extra.discarded_this_round = card.ability.extra.discarded_this_round or false
        card.ability.extra.processed_round_end = card.ability.extra.processed_round_end or false
    end,

    load = function(self, card, card_table)
        card.ability.extra = card.ability.extra or {}
        card.ability.extra.chips = card_table.ability.extra and card_table.ability.extra.chips or 0
        card.ability.extra.discarded_this_round = false
        card.ability.extra.processed_round_end = false
    end,

    check_for_unlock = function(self, args)
        unlock_card(self)
    end,
}

-- Galileo
SMODS.Atlas{
    key = 'galileo',
    path = 'galileo.png',
    px = 71,
    py = 95,
}

SMODS.Joker{
    key = 'galileo',
    loc_txt = {
        name = 'Galileo',
        text = {
            'Cuando usas una {C:planet}carta planetaria{}, hay un {C:green,E:1}50%{} de ',
            'probabilidad de que este Joker gane {X:mult,C:white}+0.5X{} multi.',
            'Solo aplica el multiplicador si la mano jugada es un {C:attention}color{}.',
            '{C:inactive}Actual: {X:mult,C:white}X#1#'
        }
    },
    atlas = 'galileo',
    rarity = 3,
    cost = 8,
    pools = {['Maniatromod'] = true},
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = false,
    perishable_compat = false,
    pos = {x = 0, y = 0},
    config = { extra = { x_mult = 1.0, gain = 0.5 } },

    loc_vars = function(self, info_queue, center)
        info_queue[#info_queue+1] = {key = 'mania_credit_idea', set = 'Other', vars = { "K4l1z_33" }}
        return {
            vars = { string.format("%.1f", center.ability.extra.x_mult) }
        }
    end,

    calculate = function(self, card, context)
        if context.using_consumeable and context.consumeable then
            if context.consumeable.ability.set == 'Planet' then
                if pseudorandom('galileo') < 0.5 then
                    card.ability.extra.x_mult = card.ability.extra.x_mult + card.ability.extra.gain
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            card:juice_up(0.3, 0.5)
                            card_eval_status_text(card, 'extra', nil, nil, nil, {
                                message = localize{type='variable', key='a_xmult', vars={card.ability.extra.gain}},
                                colour = G.C.RED
                            })
                            return true
                        end
                    }))
                end
            end
        end

        if context.joker_main and context.scoring_name == "Flush" then
            return {
                x_mult = card.ability.extra.x_mult,
                message = localize{type='variable', key='a_xmult', vars={card.ability.extra.x_mult}},
                colour = G.C.MULT
            }
        end
    end,

    set_ability = function(self, card, initial, delay_sprites)
        card.ability.extra = card.ability.extra or {}
        card.ability.extra.x_mult = card.ability.extra.x_mult or 1.0
        card.ability.extra.gain = card.ability.extra.gain or 0.5
    end,

    load = function(self, card, card_table)
        card.ability.extra = card_table.ability.extra or { x_mult = 1.0, gain = 0.5 }
    end,

    check_for_unlock = function(self, args)
        unlock_card(self)
    end,
}

-- Jack
SMODS.Atlas{
    key = 'jack',
    path = 'jack.png',
    px = 71,
    py = 95,
}

SMODS.Joker{
    key = 'jack',
    loc_txt = {
        name = 'Jack',
        text = {
            'Al final de la tienda, destruye todos los {C:purple}consumibles{}',
            'y gana {C:blue}+10{} chips por cada uno.',
            '{C:inactive}Actual: {C:blue}+#1#{} chips'
        }
    },
    atlas = 'jack',
    rarity = 2,
    cost = 6,
    pools = {['Maniatromod'] = true},
    unlocked = true,
    discovered = true,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    pos = {x = 0, y = 0},
    config = {
        extra = {
            chips = 0,
            chips_per_consumable = 10
        }
    },

    loc_vars = function(self, info_queue, center)
        info_queue[#info_queue+1] = {key = 'mania_credit_idea', set = 'Other', vars = { "Adumbasswaffle" }}
        return { vars = { center.ability.extra.chips } }
    end,

    calculate = function(self, card, context)
        if context.joker_main and card.ability.extra.chips > 0 then
            return {
                chip_mod = card.ability.extra.chips,
                message = "+" .. card.ability.extra.chips .. " Chips",
                colour = G.C.CHIPS
            }
        end

        if context.ending_shop and not context.blueprint then
            if G.consumeables and G.consumeables.cards and #G.consumeables.cards > 0 then
                local consumables_count = #G.consumeables.cards
                local total_chips_gained = consumables_count * card.ability.extra.chips_per_consumable
                
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.3,
                    func = function()
                        for i = #G.consumeables.cards, 1, -1 do
                            local consumable = G.consumeables.cards[i]
                            consumable:start_dissolve()
                        end
                        
                        card.ability.extra.chips = card.ability.extra.chips + total_chips_gained
                        
                        card_eval_status_text(card, 'extra', nil, nil, nil, {
                            message = "+" .. total_chips_gained .. " Chips (" .. consumables_count .. " consumed)",
                            colour = G.C.CHIPS
                        })
                        
                        return true
                    end
                }))
                
                return {
                    message = "Consuming...",
                    colour = G.C.PURPLE
                }
            end
        end
    end,

    set_ability = function(self, card, initial, delay_sprites)
        card.ability.extra = card.ability.extra or {}
        card.ability.extra.chips = card.ability.extra.chips or 0
        card.ability.extra.chips_per_consumable = card.ability.extra.chips_per_consumable or 10
    end,

    load = function(self, card, card_table)
        card.ability.extra = card.ability.extra or {}
        card.ability.extra.chips = card_table.ability.extra and card_table.ability.extra.chips or 0
        card.ability.extra.chips_per_consumable = card_table.ability.extra and card_table.ability.extra.chips_per_consumable or 10
    end,

    check_for_unlock = function(self, args)
        unlock_card(self)
    end,
}

-- Kiki Mow Mow
SMODS.Atlas{
    key = 'kiki',
    path = 'kikimowmow.png', 
    px = 71,
    py = 95,
}

SMODS.Joker{
    key = 'kiki',
    loc_txt = {
        name = 'Kiki Mow Mow',
        text = {
            'Al jugar exactamente {C:attention}5 cartas{},',
            'hay una probabilidad de {C:green}#1# en #2#{} de que',
            'una de ellas se vuelva {C:attention}Oro{}, {C:attention}Acero{} o {C:attention}Vidrio{}.'
        }
    },
    atlas = 'kiki',
    rarity = 2,
    cost = 6,
    pools = {['Maniatromod'] = true},
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    pos = {x = 0, y = 0},
    config = { extra = { odds = 4 } },

    loc_vars = function(self, info_queue, center)
        info_queue[#info_queue+1] = {key = 'mania_credit_idea', set = 'Other', vars = { "DragoniteChamp" }}
        return { vars = { G.GAME.probabilities.normal, center.ability.extra.odds } }
    end,

    calculate = function(self, card, context)
        if context.before and context.full_hand and #context.full_hand == 5 then
            
            if pseudorandom('kiki') < G.GAME.probabilities.normal / card.ability.extra.odds then
                
                local target_card = pseudorandom_element(context.full_hand, pseudoseed('kiki_gift'))
                
                local enhancements = {'m_gold', 'm_steel', 'm_glass'}
                local chosen_enhancement = enhancements[math.random(#enhancements)]
                
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.4,
                    func = function()
                        target_card:set_ability(G.P_CENTERS[chosen_enhancement])
                        target_card:juice_up()
                        card_eval_status_text(card, 'extra', nil, nil, nil, {
                            message = "Mow Mow!",
                            colour = G.C.MONEY
                        })
                        return true
                    end
                }))
            end
        end
    end
}

-- Pompo
SMODS.Atlas{
    key = 'pompo',
    path = 'pompo.png',
    px = 71,
    py = 95,
}

SMODS.Joker{
    key = 'pompo',
    loc_txt = {
        name = 'Pompo',
        text = {
            'Por cada {C:purple}#3# consumibles{} usados, gana {C:green}+1!{} multi',
            'Actual: {C:green}#1#!{} = {C:red}+#2#{} multi'
        }
    },
    atlas = 'pompo',
    rarity = 3,
    cost = 9,
    pools = {['Maniatromod'] = true},
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = false,
    perishable_compat = false,
    pos = {x=0, y=0},

    config = {
        extra = {
            consumables_used = 0,
            factorial_level = 1, 
            actual_multiplier = 1 
        }
    },

    loc_vars = function(self, info_queue, center)
        local remaining = 5 - (center.ability.extra.consumables_used % 5)
        if remaining == 5 then remaining = 0 end
        info_queue[#info_queue+1] = {key = 'mania_credit_idea', set = 'Other', vars = { "AppleMania, Bimaker15" }} 
        
        return { 
            vars = { 
                center.ability.extra.factorial_level, 
                center.ability.extra.actual_multiplier,
                remaining == 0 and 5 or remaining
            } 
        }
    end,

    calculate = function(self, card, context)
        if context.consumeable then
            card.ability.extra.consumables_used = card.ability.extra.consumables_used + 1

            if card.ability.extra.consumables_used % 5 == 0 then
                card.ability.extra.factorial_level = card.ability.extra.factorial_level + 1
                
                local function factorial(n)
                    if n <= 1 then return 1 end
                    local result = 1
                    for i = 1, n do
                        result = result * i
                    end
                    return result
                end
                
                card.ability.extra.actual_multiplier = factorial(card.ability.extra.factorial_level)

                return {
                    message = "+1! (" .. card.ability.extra.factorial_level .. "! = +" .. card.ability.extra.actual_multiplier .. " multi)",
                    colour = G.C.GREEN
                }
            end
        end

        if context.joker_main and card.ability.extra.actual_multiplier > 1 then
            return {
                message = "+" .. card.ability.extra.actual_multiplier .. " (" .. card.ability.extra.factorial_level .. "!)",
                mult_mod = card.ability.extra.actual_multiplier,
                colour = G.C.RED
            }
        end
    end,

    set_ability = function(self, card, initial, delay_sprites)
        card.ability.extra = card.ability.extra or {}
        card.ability.extra.consumables_used = card.ability.extra.consumables_used or 0
        card.ability.extra.factorial_level = card.ability.extra.factorial_level or 1
        card.ability.extra.actual_multiplier = card.ability.extra.actual_multiplier or 1
    end,

    load = function(self, card, card_table)
        card.ability.extra = card.ability.extra or {}
        card.ability.extra.consumables_used = card_table.ability.extra and card_table.ability.extra.consumables_used or 0
        card.ability.extra.factorial_level = card_table.ability.extra and card_table.ability.extra.factorial_level or 1
        card.ability.extra.actual_multiplier = card_table.ability.extra and card_table.ability.extra.actual_multiplier or 1
        
        if card.ability.extra.factorial_level > 1 then
            local function factorial(n)
                if n <= 1 then return 1 end
                local result = 1
                for i = 1, n do
                    result = result * i
                end
                return result
            end
            card.ability.extra.actual_multiplier = factorial(card.ability.extra.factorial_level)
        end
    end,

    check_for_unlock = function(self, args)
        unlock_card(self)
    end,
}

-- Luna 2 
SMODS.Atlas{
    key = 'luna2',
    path = 'luna2.png',
    px = 71,
    py = 95,
}

SMODS.Joker{
    key = 'luna2',
    loc_txt = {
        name = 'Luna',
        text = {
            'Gana {C:chips}+#1#{} fichas permanentes',
            'por cada carta jugada que puntúe.',
            '{C:inactive}(Actual: {C:chips}+#2#{C:inactive} fichas)'
        }
    },
    atlas = 'luna2',
    rarity = 2,
    cost = 5,
    pools = {['Maniatromod'] = true},
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    pos = {x=0, y=0},
    config = { extra = { chips_per_card = 2, total_chips = 0 } },

    loc_vars = function(self, info_queue, center)
        info_queue[#info_queue+1] = {key = 'mania_credit_idea', set = 'Other', vars = { "Enderjed" }}
        return { vars = { center.ability.extra.chips_per_card, center.ability.extra.total_chips } }
    end,

    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            card.ability.extra.total_chips = card.ability.extra.total_chips + card.ability.extra.chips_per_card
            
            return {
                extra = { focus = card, message = 'Hair!', colour = G.C.CHIPS },
                card = card
            }
        end

        if context.joker_main and card.ability.extra.total_chips > 0 then
            return {
                chip_mod = card.ability.extra.total_chips,
                message = "+" .. card.ability.extra.total_chips .. " Chips",
                colour = G.C.CHIPS
            }
        end
    end,

    set_ability = function(self, card, initial, delay_sprites)
        card.ability.extra = card.ability.extra or {}
        card.ability.extra.chips_per_card = 2
        card.ability.extra.total_chips = 0
    end,

    load = function(self, card, card_table)
        card.ability.extra = card_table.ability.extra or { chips_per_card = 2, total_chips = 0 }
    end
}

-- Blue
SMODS.Atlas{
    key = 'blue',
    path = 'blue.png',
    px = 71,
    py = 95,
}

SMODS.Joker{
    key = 'blue',
    loc_txt = {
        name = 'Blue',
        text = {
            'Sin {C:attention}Luna{}: {C:red}+#1#{} multi por espacio',
            'de consumible vacío.',
            'Con {C:attention}Luna{}: {X:blue,C:white}X#2#{} fichas'
        }
    },
    atlas = 'blue',
    rarity = 2,
    cost = 5,
    pools = {['Maniatromod'] = true},
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    pos = {x=0, y=0},

    config = {
        extra = {
            base_mult = 10,
            empty_slot_mult = 10,
            synergy_xchips = 1.75
        }
    },

    loc_vars = function(self, info_queue, center)
        local empty_slots = (G.consumeables and G.consumeables.config.card_limit or 2) - #(G.consumeables and G.consumeables.cards or {})
        local mult_per_slot = center.ability.extra.empty_slot_mult
        info_queue[#info_queue+1] = {key = 'mania_credit_idea', set = 'Other', vars = { "LukexsGame, DoggoDS" }}
        
        return { 
            vars = { 
                mult_per_slot,
                center.ability.extra.synergy_xchips
            } 
        }
    end,

    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main then
            local has_luna = false
            for i = 1, #G.jokers.cards do
                if G.jokers.cards[i].config.center.key == "j_mania_luna" then
                    has_luna = true
                    break
                end
            end

            if has_luna then
                return {
                    message = "X" .. card.ability.extra.synergy_xchips .. " chips (with Luna)",
                    Xchip_mod = card.ability.extra.synergy_xchips,
                    colour = G.C.BLUE
                }
            else
                local empty_slots = (G.consumeables and G.consumeables.config.card_limit or 2) - #(G.consumeables and G.consumeables.cards or {})
                local total_mult = empty_slots * card.ability.extra.empty_slot_mult
                
                return {
                    message = "+" .. total_mult .. " mult (" .. empty_slots .. " slots)",
                    mult_mod = total_mult,
                    colour = G.C.RED
                }
            end
        end
    end,

    set_ability = function(self, card, initial, delay_sprites)
        card.ability.extra = card.ability.extra or {}
        card.ability.extra.base_mult = card.ability.extra.base_mult or 10
        card.ability.extra.empty_slot_mult = card.ability.extra.empty_slot_mult or 10
        card.ability.extra.synergy_xchips = card.ability.extra.synergy_xchips or 1.75
    end,

    load = function(self, card, card_table)
        card.ability.extra = card.ability.extra or {}
        card.ability.extra.base_mult = card_table.ability.extra and card_table.ability.extra.base_mult or 10
        card.ability.extra.empty_slot_mult = card_table.ability.extra and card_table.ability.extra.empty_slot_mult or 10
        card.ability.extra.synergy_xchips = card_table.ability.extra and card_table.ability.extra.synergy_xchips or 1.75
    end,

    check_for_unlock = function(self, args)
        unlock_card(self)
    end,
}

-- Luna
SMODS.Atlas{
    key = 'luna',
    path = 'luna.png',
    px = 71,
    py = 95,
}

SMODS.Joker{
    key = 'luna',
    loc_txt = {
        name = 'Luna',
        text = {
            'Sin {C:attention}Blue{}: {C:blue}+50{} fichas por',
            'consumible que tengas.',
            'Con {C:attention}Blue{}: {X:red,C:white}X#2#{} multi'
        }
    },
    atlas = 'luna',
    rarity = 2,
    cost = 5,
    pools = {['Maniatromod'] = true},
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    pos = {x=0, y=0},

    config = {
        extra = {
            base_chips = 50,
            consumable_chips = 50,
            synergy_xmult = 1.75
        }
    },

    loc_vars = function(self, info_queue, center)
        local consumables_count = #(G.consumeables and G.consumeables.cards or {})
        local total_chips = consumables_count * center.ability.extra.consumable_chips
        info_queue[#info_queue+1] = {key = 'mania_credit_idea', set = 'Other', vars = { "LukexsGame, DoggoDS" }}
        
        return { 
            vars = { 
                total_chips,
                center.ability.extra.synergy_xmult
            } 
        }
    end,

    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main then
            local has_blue = false
            for i = 1, #G.jokers.cards do
                if G.jokers.cards[i].config.center.key == "j_mania_blue" then
                    has_blue = true
                    break
                end
            end

            if has_blue then
                return {
                    message = "X" .. card.ability.extra.synergy_xmult .. " mult (with Blue)",
                    Xmult_mod = card.ability.extra.synergy_xmult,
                    colour = G.C.RED
                }
            else
                local consumables_count = #(G.consumeables and G.consumeables.cards or {})
                local total_chips = consumables_count * card.ability.extra.consumable_chips
                
                return {
                    message = "+" .. total_chips .. " chips (" .. consumables_count .. " consumables)",
                    chip_mod = total_chips,
                    colour = G.C.BLUE
                }
            end
        end
    end,

    set_ability = function(self, card, initial, delay_sprites)
        card.ability.extra = card.ability.extra or {}
        card.ability.extra.base_chips = card.ability.extra.base_chips or 50
        card.ability.extra.consumable_chips = card.ability.extra.consumable_chips or 50
        card.ability.extra.synergy_xmult = card.ability.extra.synergy_xmult or 1.75
    end,

    load = function(self, card, card_table)
        card.ability.extra = card.ability.extra or {}
        card.ability.extra.base_chips = card_table.ability.extra and card_table.ability.extra.base_chips or 50
        card.ability.extra.consumable_chips = card_table.ability.extra and card_table.ability.extra.consumable_chips or 50
        card.ability.extra.synergy_xmult = card_table.ability.extra and card_table.ability.extra.synergy_xmult or 1.75
    end,

    check_for_unlock = function(self, args)
        unlock_card(self)
    end,
}

-- Tortuga
SMODS.Atlas{
    key = 'tortuga',
    path = 'tortuga.png',
    px = 71,
    py = 95,
}

SMODS.Joker{
    key = 'tortuga',
    loc_txt = {
        name = 'Tortuga',
        text = {
            '{C:inactive}No hace nada.{}'
        }
    },
    atlas = 'tortuga',
    rarity = 3,
    cost = 10,
    pools = {['Maniatromod'] = true},
    unlocked = true,
    discovered = true,
    blueprint_compat = false,
    eternal_compat = false,
    perishable_compat = false,
    pos = {x = 0, y = 0},
    config = {},

    loc_vars = function(self, info_queue, center)
        info_queue[#info_queue+1] = {key = 'mania_credit_idea', set = 'Other', vars = { "DoggoDS" }}
        return { vars = {} }
    end,

    calculate = function(self, card, context)
        return 
    end,

    add_to_deck = function(self, card, from_debuff)
        G.GAME.tortuga_active = true
    end,

    remove_from_deck = function(self, card, from_debuff)
        G.GAME.tortuga_active = false
    end,

    check_for_unlock = function(self, args)
        unlock_card(self)
    end,
}

if not G.OLD_CREATE_CARD then
    G.OLD_CREATE_CARD = create_card
    function create_card(_type, area, legendary, _rarity, skip_materialize, soulable, forced_key, key_append)
        if _type == 'Spectral' and G.GAME and G.GAME.tortuga_active and not forced_key then
            local roll = pseudorandom('tortuga_soul')
            if roll < 0.5 then
                forced_key = 'c_soul'
            end
        end
        return G.OLD_CREATE_CARD(_type, area, legendary, _rarity, skip_materialize, soulable, forced_key, key_append)
    end
end

-- Hamdo
SMODS.Atlas{
    key = 'hamdo',
    path = 'hamdo.png',
    px = 71,
    py = 95,
}

SMODS.Joker{
    key = 'hamdo',
    loc_txt = {
        name = 'Hamdo',
        text = {
            'Al final de cada ronda, {C:attention}consume{}',
            'un {C:purple}consumible{} al azar y gana',
            '{C:money}+$5{} de valor de venta.',
        }
    },
    atlas = 'hamdo',
    rarity = 2,
    cost = 6,
    pools = {['Maniatromod'] = true},
    unlocked = true,
    discovered = true,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = false,
    pos = {x = 0, y = 0},
    config = {
        extra = {
            sell_value = 5
        }
    },

    loc_vars = function(self, info_queue, center)
        info_queue[#info_queue+1] = {key = 'mania_credit_idea', set = 'Other', vars = { "Zombieboy139" }}
        return { vars = { center.ability.extra_value or 0 } }
    end,

    calculate = function(self, card, context)
        if context.end_of_round and context.game_over == false and context.main_eval then
            local target_cards = {}
            for i, consumable in ipairs(G.consumeables.cards) do
                table.insert(target_cards, consumable)
            end
            
            if #target_cards > 0 then
                return {
                    func = function()
                        local card_to_destroy = pseudorandom_element(target_cards, pseudoseed('hamdo_eat'))
                        G.E_MANAGER:add_event(Event({
                            func = function()
                                card_to_destroy:start_dissolve()
                                return true
                            end
                        }))
                        card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {
                            message = "¡Ñam!", 
                            colour = G.C.PURPLE
                        })
                        return true
                    end,
                    extra = {
                        func = function()
                            local my_pos = nil
                            for i = 1, #G.jokers.cards do
                                if G.jokers.cards[i] == card then
                                    my_pos = i
                                    break
                                end
                            end
                            if my_pos then
                                local target_card = G.jokers.cards[my_pos]
                                target_card.ability.extra_value = (target_card.ability.extra_value or 0) + card.ability.extra.sell_value
                                target_card:set_cost()
                            end
                            return true
                        end,
                        message = "+$" .. tostring(card.ability.extra.sell_value) .. " Valor de venta",
                        colour = G.C.MONEY
                    }
                }
            end
        end
    end,

    check_for_unlock = function(self, args)
        unlock_card(self)
    end,
}

-- Gafas de Spamton
SMODS.Atlas{
    key = 'spamton',
    path = 'spamton.png',
    px = 71,
    py = 95,
}

SMODS.Joker{
    key = 'spamton',
    loc_txt = {
        name = 'Gafas de Spamton',
        text = {
            'Gana {X:mult,C:white}+1X{} multi por cada Joker',
            'vendido durante una ronda.',
            'Actual: {X:mult,C:white}X#1#{} multi'
        }
    },
    atlas = 'spamton',
    rarity = 3,
    cost = 8,
    pools = {['Maniatromod'] = true},
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = false,
    pos = {x=0, y=0},
    config = { 
        extra = { 
            xmult = 1,
            jokers_sold_this_round = 0,
            processed_round_end = false
        } 
    },

    loc_vars = function(self, info_queue, center)
        info_queue[#info_queue+1] = {key = 'mania_credit_idea', set = 'Other', vars = { "AppleMania" }}
        return { vars = { string.format("%.1f", center.ability.extra.xmult) } }
    end,

    calculate = function(self, card, context)
        if context.setting_blind and not context.blueprint then
            card.ability.extra.xmult = 1
            card.ability.extra.jokers_sold_this_round = 0
            card.ability.extra.processed_round_end = false
            return
        end

        if context.selling_card and context.card and context.card.ability and context.card.ability.set == "Joker" then
            card.ability.extra.jokers_sold_this_round = card.ability.extra.jokers_sold_this_round + 1
            card.ability.extra.xmult = 1 + card.ability.extra.jokers_sold_this_round
            
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.1,
                func = function()
                    card_eval_status_text(card, 'extra', nil, nil, nil, {
                        message = "+1X Multi (X" .. string.format("%.1f", card.ability.extra.xmult) .. " total)",
                        colour = G.C.MULT
                    })
                    return true
                end
            }))
            
            return {
                message = "Joker sold!",
                colour = G.C.MONEY
            }
        end

        if context.joker_main and card.ability.extra.xmult > 1 then
            return {
                Xmult_mod = card.ability.extra.xmult,
                message = "X" .. string.format("%.1f", card.ability.extra.xmult),
                colour = G.C.MULT
            }
        end
    end,

    set_ability = function(self, card, initial, delay_sprites)
        card.ability.extra = card.ability.extra or {}
        card.ability.extra.xmult = card.ability.extra.xmult or 1
        card.ability.extra.jokers_sold_this_round = card.ability.extra.jokers_sold_this_round or 0
        card.ability.extra.processed_round_end = card.ability.extra.processed_round_end or false
    end,

    load = function(self, card, card_table)
        card.ability.extra = card.ability.extra or {}
        card.ability.extra.xmult = card_table.ability.extra and card_table.ability.extra.xmult or 1
        card.ability.extra.jokers_sold_this_round = card_table.ability.extra and card_table.ability.extra.jokers_sold_this_round or 0
        card.ability.extra.processed_round_end = false 
    end,

    check_for_unlock = function(self, args)
        unlock_card(self)
    end,
}

-- Tenna
SMODS.Atlas{
    key = 'tenna',
    path = 'tenna.png',
    px = 71,
    py = 95,
}

SMODS.Joker{
    key = 'tenna',
    loc_txt = {
        name = 'Mr. (Ant)Tenna',
        text = {
            'Todo lo que hay en la tienda',
            'tiene un {C:green,E:1}50%{} de descuento.'
        }
    },
    atlas = 'tenna',
    rarity = 3,
    cost = 8,
    pools = {['Maniatromod'] = true},
    unlocked = true,
    discovered = true,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    pos = {x = 0, y = 0},
    config = { extra = { discount = 50 } },

    loc_vars = function(self, info_queue, center)
        info_queue[#info_queue+1] = {key = 'mania_credit_idea', set = 'Other', vars = { "AppleMania, LukexsGame" }}
        return { vars = { center.ability.extra.discount } }
    end,

    add_to_deck = function(self, card, from_debuff)
        G.GAME.discount_percent = (G.GAME.discount_percent or 0) + card.ability.extra.discount
        
        G.E_MANAGER:add_event(Event({
            func = function()
                for k, v in pairs(G.I.CARD) do
                    if v.set_cost then 
                        v:set_cost() 
                    end
                end
                return true 
            end 
        }))
    end,

    remove_from_deck = function(self, card, from_debuff)
        G.GAME.discount_percent = (G.GAME.discount_percent or 0) - card.ability.extra.discount
        
        G.E_MANAGER:add_event(Event({
            func = function()
                for k, v in pairs(G.I.CARD) do
                    if v.set_cost then 
                        v:set_cost() 
                    end
                end
                return true 
            end 
        }))
    end,

    check_for_unlock = function(self, args)
        unlock_card(self)
    end,
}

-- Balatro Tomorrow
SMODS.Atlas{
    key = 'balatro_tomorrow',
    path = 'tomorrow.png',
    px = 71,
    py = 95,
}

SMODS.Joker{
    key = 'balatro_tomorrow',
    loc_txt = {
        name = 'Balatro Tomorrow',
        text = {
            'Gana {X:chips,C:white}+0.25X{} chips por cada ronda ganada.',
            'Actual: {X:chips,C:white}X#1#{} chips',
        }
    },
    atlas = 'balatro_tomorrow',
    rarity = 3,
    cost = 8,
    pools = {['Maniatromod'] = true},
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    pos = {x=0, y=0},
    config = { 
        extra = { 
            xchips = 1.0,
            last_round = 0
        } 
    },

    loc_vars = function(self, info_queue, center)
        info_queue[#info_queue+1] = {key = 'mania_credit_idea', set = 'Other', vars = { "AppleMania" }}
        return { vars = { string.format("%.2f", center.ability.extra.xchips) } }
    end,

    calculate = function(self, card, context)
        if context.joker_main then
            return {
                message = 'X' .. string.format("%.2f", card.ability.extra.xchips),
                x_chips = card.ability.extra.xchips,
                colour = G.C.CHIPS
            }
        end

        if context.end_of_round and not context.blueprint then
            local current_round = G.GAME.round or 0
            local game_state = G.STATE or 0
            
            if current_round > card.ability.extra.last_round then
                card.ability.extra.last_round = current_round
                card.ability.extra.xchips = card.ability.extra.xchips + 0.25
                
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.3,
                    blockable = false,
                    func = function()
                        card_eval_status_text(card, 'extra', nil, nil, nil, {
                            message = '+0.25X (' .. string.format("%.2f", card.ability.extra.xchips) .. 'X total)',
                            colour = G.C.CHIPS
                        })
                        return true
                    end
                }))
                
                return {
                    message = 'Round won!',
                    colour = G.C.GREEN
                }
            end
        end
    end,

    set_ability = function(self, card, initial, delay_sprites)
        card.ability.extra = card.ability.extra or {}
        card.ability.extra.xchips = card.ability.extra.xchips or 1.0
        card.ability.extra.last_round = card.ability.extra.last_round or (G.GAME and G.GAME.round or 0)
    end,

    load = function(self, card, card_table)
        card.ability.extra = card.ability.extra or {}
        card.ability.extra.xchips = card_table.ability.extra and card_table.ability.extra.xchips or 1.0
        card.ability.extra.last_round = card_table.ability.extra and card_table.ability.extra.last_round or (G.GAME and G.GAME.round or 0)
    end,

    check_for_unlock = function(self, args)
        unlock_card(self)
    end,
}

-- Determinación
SMODS.Atlas{
    key = 'determination',
    path = 'determination.png',
    px = 71,
    py = 95,
}

SMODS.Joker{
    key = 'determination',
    loc_txt = {
        name = 'Determinación',
        text = {
            'Este Joker aplica {X:mult,C:white}X#1#{} multi.',
            'Cuantas más manos juegues, más fuerte se vuelve.',
            '{C:inactive}Manos: {C:attention}#2#/#3#{}  |||  Nivel: {C:attention}#4#{}'
        }
    },
    atlas = 'determination',
    rarity = 4,
    cost = 12,
    pools = {['Maniatromod'] = true},
    unlocked = true,
    discovered = true,
    blueprint_compat = false,
    eternal_compat = false,
    perishable_compat = false,
    pos = {x = 0, y = 0},
    config = {
        extra = {
            level = 1,
            max_level = 20,
            hands_played = 0,
            hands_needed = 3,
            current_mult = 5
        }
    },

    loc_vars = function(self, info_queue, center)
        info_queue[#info_queue+1] = {key = 'mania_credit_idea', set = 'Other', vars = { "AppleMania" }}
        return { vars = {
            center.ability.extra.current_mult,
            center.ability.extra.hands_played,
            center.ability.extra.hands_needed,
            center.ability.extra.level
        } }
    end,

    calculate = function(self, card, context)
        if context.joker_main and not context.blueprint then
            card.ability.extra.hands_played = card.ability.extra.hands_played + 1

            if card.ability.extra.hands_played >= card.ability.extra.hands_needed 
            and card.ability.extra.level < card.ability.extra.max_level then

                card.ability.extra.level = card.ability.extra.level + 1
                card.ability.extra.current_mult = card.ability.extra.current_mult + 1
                card.ability.extra.hands_played = 0
                card.ability.extra.hands_needed = card.ability.extra.hands_needed + 1

                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.5,
                    func = function()
                        card_eval_status_text(card, 'extra', nil, nil, nil, {
                            message = "LEVEL " .. card.ability.extra.level .. "!",
                            colour = G.C.RED
                        })
                        card:juice_up(0.3, 0.5)
                        return true
                    end
                }))
            end

            return {
                Xmult_mod = card.ability.extra.current_mult,
                message = "X" .. card.ability.extra.current_mult,
                colour = G.C.RED
            }
        end
    end,

    set_ability = function(self, card, initial, delay_sprites)
        card.ability.extra = card.ability.extra or {}
        card.ability.extra.level = card.ability.extra.level or 1
        card.ability.extra.max_level = card.ability.extra.max_level or 20
        card.ability.extra.hands_played = card.ability.extra.hands_played or 0
        card.ability.extra.hands_needed = card.ability.extra.hands_needed or 3
        card.ability.extra.current_mult = card.ability.extra.current_mult or 5
    end,

    check_for_unlock = function(self, args)
        unlock_card(self)
    end,
}

-- Weezer
SMODS.Atlas{
    key = 'weezer',
    path = 'weezer.png',
    px = 71,
    py = 95,
}

SMODS.Sound{
    key = 'weezer_sound',
    path = 'weezer.ogg',
}

SMODS.Joker{
    key = 'weezer',
    loc_txt = {
        name = 'Weezer',
        text = {
            'Este Joker se duplica cada 3 rondas.',
            'Por cada {C:blue}Weezer{} repetido, ganará {X:mult,C:white}+0.5X{} multi.',
            'Actual: {X:mult,C:white}X#1#{} multi | Rondas: {C:attention}#2#/3{}'
        }
    },
    atlas = 'weezer',
    rarity = 2,
    cost = 7,
    pools = {['Maniatromod'] = true},
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = false,
    perishable_compat = false,
    pos = {x = 0, y = 0},
    config = {
        extra = {
            rounds_completed = 0,
            rounds_needed = 3,
            mult_per_weezer = 0.5,
            processed_round_end = false
        }
    },

    loc_vars = function(self, info_queue, center)
        local weezer_count = 0
        if G and G.jokers and G.jokers.cards then
            for _, joker in ipairs(G.jokers.cards) do
                if joker.config and joker.config.center and joker.config.center.key == 'j_mania_weezer' then
                    weezer_count = weezer_count + 1
                end
            end
        end
        local individual_mult = 1.0 + (center.ability.extra.mult_per_weezer * (weezer_count - 1))
        info_queue[#info_queue+1] = {key = 'mania_credit_idea', set = 'Other', vars = { "DoggoDS" }}
        return { vars = { 
            string.format("%.1f", individual_mult),
            center.ability.extra.rounds_completed 
        } }
    end,

    calculate = function(self, card, context)
        if context.setting_blind and not context.blueprint then
            card.ability.extra.processed_round_end = false
            return
        end

        if context.joker_main then
            local weezer_count = 0
            for _, joker in ipairs(G.jokers.cards) do
                if joker.config and joker.config.center and joker.config.center.key == 'j_mania_weezer' then
                    weezer_count = weezer_count + 1
                end
            end
            
            if weezer_count > 0 then
                local individual_mult = 1.0 + (card.ability.extra.mult_per_weezer * (weezer_count - 1))
                
                if individual_mult > 1.0 then
                    return {
                        Xmult_mod = individual_mult,
                        message = "X" .. string.format("%.1f", individual_mult),
                        colour = G.C.MULT
                    }
                end
            end
        end

        if context.end_of_round and not context.blueprint and not card.ability.extra.processed_round_end then
            card.ability.extra.processed_round_end = true
            card.ability.extra.rounds_completed = card.ability.extra.rounds_completed + 1
            
            if card.ability.extra.rounds_completed >= card.ability.extra.rounds_needed then
                card.ability.extra.rounds_completed = 0  
                
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.5,
                    func = function()
                        local new_weezer = create_card('Joker', G.jokers, nil, nil, nil, nil, 'j_mania_weezer')
                        new_weezer:add_to_deck()
                        G.jokers:emplace(new_weezer)
                        
                        new_weezer.ability.extra.rounds_completed = 0
                        new_weezer.ability.extra.processed_round_end = false
                        
                        play_sound('mania_weezer_sound', 1.0, 1.0)
                        
                        card_eval_status_text(card, 'extra', nil, nil, nil, {
                            message = "Weezer duplicates!",
                            colour = G.C.PURPLE
                        })
                        
                        card:juice_up(0.3, 0.5)
                        
                        new_weezer:juice_up(0.3, 0.5)
                        
                        return true
                    end
                }))
                
                return {
                    message = "Duplication!",
                    colour = G.C.GREEN
                }
            else
                local remaining = card.ability.extra.rounds_needed - card.ability.extra.rounds_completed
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.3,
                    func = function()
                        card_eval_status_text(card, 'extra', nil, nil, nil, {
                            message = remaining .. " round" .. (remaining > 1 and "s" or "") .. " to duplicate",
                            colour = G.C.SECONDARY_SET.Spectral
                        })
                        return true
                    end
                }))
            end
        end
    end,

    set_ability = function(self, card, initial, delay_sprites)
        card.ability.extra = card.ability.extra or {}
        card.ability.extra.rounds_completed = card.ability.extra.rounds_completed or 0
        card.ability.extra.rounds_needed = card.ability.extra.rounds_needed or 3
        card.ability.extra.mult_per_weezer = card.ability.extra.mult_per_weezer or 0.5
        card.ability.extra.processed_round_end = card.ability.extra.processed_round_end or false
    end,

    load = function(self, card, card_table)
        card.ability.extra = card.ability.extra or {}
        card.ability.extra.rounds_completed = card_table.ability.extra and card_table.ability.extra.rounds_completed or 0
        card.ability.extra.rounds_needed = card_table.ability.extra and card_table.ability.extra.rounds_needed or 3
        card.ability.extra.mult_per_weezer = card_table.ability.extra and card_table.ability.extra.mult_per_weezer or 0.5
        card.ability.extra.processed_round_end = false
    end,

    can_use = function(self, card)
        return true
    end,

    check_for_unlock = function(self, args)
        unlock_card(self)
    end,
}

-- Comodín Original
SMODS.Atlas{
    key = 'original',
    path = 'original.png',
    px = 71,
    py = 95,
}

SMODS.Joker{
    key = 'original',
    loc_txt = {
        name = 'Comodín Original',
        text = {
            'Da {C:mult}+N{} multi dependiendo del valor',
            'de la {C:attention}última carta{} jugada en tu mano.',
            'Al venderlo, se convierte en',
            '{C:attention}Comodín Monocromático{}'
        }
    },
    atlas = 'original',
    rarity = 3,
    cost = 6,
    pools = {['Maniatromod'] = true},
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = false,
    perishable_compat = true,
    pos = { x = 0, y = 0 },
    config = {},

    loc_vars = function(self, info_queue, center)
        info_queue[#info_queue+1] = {key = 'mania_credit_idea', set = 'Other', vars = { "AppleMania, Dogg-fly" }}
        return { vars = {} }
    end,

    calculate = function(self, card, context)
        if context.joker_main and context.scoring_hand then
            local last_card = context.scoring_hand[#context.scoring_hand]
            if last_card then
                local rank = last_card.base.value
                local mult_value = 0
                
                if rank == 'Ace' then
                    mult_value = 11
                elseif rank == 'King' then
                    mult_value = 10
                elseif rank == 'Queen' then
                    mult_value = 10
                elseif rank == 'Jack' then
                    mult_value = 10
                else
                    mult_value = tonumber(rank) or 0
                end

                return {
                    mult_mod = mult_value,
                    message = "+" .. mult_value .. " Mult",
                    colour = G.C.MULT
                }
            end
        end

        if context.selling_self then
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.3,
                func = function()
                    local new_joker = create_card(
                        'Joker',
                        G.jokers,
                        nil, nil, nil, nil,
                        'j_mania_monocromatico'
                    )
                    new_joker:add_to_deck()
                    G.jokers:emplace(new_joker)

                    card_eval_status_text(new_joker, 'extra', nil, nil, nil, {
                        message = "Transformed!",
                        colour = G.C.RED
                    })

                    return true
                end
            }))
        end
    end,

    set_ability = function(self, card, initial)
        card.ability.extra = card.ability.extra or {}
    end,

    check_for_unlock = function(self, args)
        unlock_card(self)
    end,
}

-- Comodín Monocromático
SMODS.Atlas{
    key = 'monocromatico',
    path = 'original.png',
    px = 71,
    py = 95,
}

SMODS.Joker{
    key = 'monocromatico',
    loc_txt = {
        name = 'Comodín Monocromático',
        text = {
            'Da {C:mult}-N{} multi dependiendo del valor',
            'de la {C:attention}última carta{} jugada en tu mano.',
        }
    },
    atlas = 'monocromatico',
    rarity = 2,
    cost = 6,
    pools = {},
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = false,
    perishable_compat = true,
    pos = {x = 1, y = 0},
    config = {},

    loc_vars = function(self, info_queue, center)
        info_queue[#info_queue+1] = {key = 'mania_credit_idea', set = 'Other', vars = { "AppleMania, Dogg-fly" }}
        return { vars = {} }
    end,

    calculate = function(self, card, context)
        if context.joker_main and context.scoring_hand then
            local last_card = context.scoring_hand[#context.scoring_hand]
            if last_card then
                local rank = last_card.base.value
                local mult_value = 0
                
                if rank == 'Ace' then
                    mult_value = 11
                elseif rank == 'King' then
                    mult_value = 10
                elseif rank == 'Queen' then
                    mult_value = 10
                elseif rank == 'Jack' then
                    mult_value = 10
                else
                    mult_value = tonumber(rank) or 0
                end

                return {
                    mult_mod = -mult_value,
                    message = "-" .. mult_value .. " Mult",
                    colour = G.C.RED
                }
            end
        end
    end,

    set_ability = function(self, card, initial)
        card:add_sticker('mania_temporal', true)
    end,

    check_for_unlock = function(self, args)
        unlock_card(self)
    end,
}

-- PRIDE 
SMODS.Atlas{
    key = 'pride',
    path = 'pride.png',
    px = 71,
    py = 95,
}

SMODS.Joker{
    key = 'pride',
    loc_txt = {
        name = 'Pride',
        text = {
            'Gana {C:mult}+69{} multi por cada carta',
            '{C:dark_edition}policromo{} que poseas.',
            '{C:inactive}Actual: {C:mult}+#1#{} multi'
        }
    },
    atlas = 'pride',
    rarity = 3,
    cost = 8,
    pools = {['Maniatromod'] = true},
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = false,
    pos = {x = 0, y = 0},
    config = { extra = { mult_per_polychrome = 69, total_mult = 0 } },

    loc_vars = function(self, info_queue, center)
        info_queue[#info_queue+1] = {key = 'mania_credit_idea', set = 'Other', vars = { "Julio24pro" }}
        return { vars = { center.ability.extra.total_mult } }
    end,

    calculate = function(self, card, context)
        if context.joker_main and not context.blueprint then
            local polychrome_count = 0
            
            for _, joker in ipairs(G.jokers.cards) do
                if joker.edition and joker.edition.polychrome then
                    polychrome_count = polychrome_count + 1
                end
            end
            
            if G.playing_cards then
                for _, c in ipairs(G.playing_cards) do
                    if c.edition and c.edition.polychrome then
                        polychrome_count = polychrome_count + 1
                    end
                end
            end
            
            card.ability.extra.total_mult = polychrome_count * card.ability.extra.mult_per_polychrome
            
            if card.ability.extra.total_mult > 0 then
                return {
                    mult_mod = card.ability.extra.total_mult,
                    message = "+"..card.ability.extra.total_mult.." ("..polychrome_count.." polychrome)",
                    colour = G.C.MULT
                }
            end
        end
    end,

    set_ability = function(self, card, initial, delay_sprites)
        card.ability.extra = card.ability.extra or {}
        card.ability.extra.mult_per_polychrome = card.ability.extra.mult_per_polychrome or 69
        card.ability.extra.total_mult = card.ability.extra.total_mult or 0
    end,

    check_for_unlock = function(self, args)
        unlock_card(self)
    end,
}

-- Parabettle
SMODS.Atlas{
    key = 'parabettle',
    path = 'parabettle.png',
    px = 71,
    py = 95,
}

SMODS.Joker{
    key = 'parabettle',
    loc_txt = {
        name = 'Parabettle',
        text = {
            'Por cada {C:attention}#2#{} descartes,',
            'gana {C:chips}+25{} fichas permanentes.',
            '{C:inactive}Actual: {C:chips}+#1#{C:inactive} chips',
        }
    },
    atlas = 'parabettle', 
    rarity = 2,
    cost = 5,
    pools = {['Maniatromod'] = true},
    unlocked = true,
    discovered = true,
    blueprint_compat = false,
    eternal_compat = true,
    config = { extra = { chips = 0, count = 0 } },

    loc_vars = function(self, info_queue, center)
        info_queue[#info_queue+1] = {key = 'mania_credit_idea', set = 'Other', vars = { "Javier25" }}
        return { vars = { center.ability.extra.chips, 10 - center.ability.extra.count } }
    end,

    calculate = function(self, card, context)
        if context.discard then
            card.ability.extra.count = card.ability.extra.count + 1
            
            if card.ability.extra.count >= 10 then
                card.ability.extra.chips = card.ability.extra.chips + 25
                card.ability.extra.count = 0
                
                card_eval_status_text(card, 'extra', nil, nil, nil, {
                    message = "+25 chips!",
                    colour = G.C.CHIPS,
                    chip_mod = 25
                })
            end
            
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.1,
                func = function()
                    card_eval_status_text(card, 'extra', nil, nil, nil, {
                        message = "Discard "..card.ability.extra.count.."/10",
                        colour = G.C.UI.TEXT_LIGHT
                    })
                    return true
                end
            }))
        end

        if context.joker_main then
            return {
                chip_mod = card.ability.extra.chips,
                message = localize{type = 'variable', key = 'a_chips', vars = {card.ability.extra.chips}},
                colour = G.C.CHIPS
            }
        end
    end,

    remove_from_deck = function(self, card)
        card.ability.extra.chips = 0
        card.ability.extra.count = 0
    end
}

-- Ludopatía (Animación)
SMODS.Atlas{
    key = "LudopatiaAtlas",
    px = 71,
    py = 95,
    path = "ludopatia.png",
    atlas_table = "ANIMATION_ATLAS",
    frames = 8
}:register()
local _old_set_sprites = Card.set_sprites
function Card:set_sprites(_center, _front)
    if _center and _center.key == "j_mania_ludopatia" then
        self.children.center = AnimatedSprite(
            self.T.x, self.T.y, self.T.w, self.T.h,
            G.ANIMATION_ATLAS["mania_LudopatiaAtlas"],
            self.config.center.pos
        )
        self.children.center.framerate_override = 12
        self.children.center:set_role({
            major = self,
            role_type = "Glued",
            draw_major = self
        })

        local back_atlas = nil
        if G.P_CENTERS and G.P_CENTERS.j_joker then
            back_atlas = G.P_CENTERS.j_joker.atlas or G.ASSET_ATLAS["Joker"]
        elseif _front and _front.atlas then
            back_atlas = _front.atlas
        else
            back_atlas = G.ASSET_ATLAS["Joker"]
        end

        self.children.back = Sprite(
            self.T.x, self.T.y, self.T.w, self.T.h,
            back_atlas,
            self.config.center.pos
        )
        return
    end
    _old_set_sprites(self, _center, _front)
end
if AnimatedSprite and not AnimatedSprite._has_ludopatia_patch then
    AnimatedSprite._has_ludopatia_patch = true
    local _old_animate = AnimatedSprite.animate

    function AnimatedSprite:animate()
        if self.framerate_override then
            local FPS = self.framerate_override
            local new_frame = math.floor(FPS * (G.TIMERS.REAL - self.offset_seconds)) % self.current_animation.frames
            local frame_length = math.floor(self.image_dims[1] / self.animation.w)

            if new_frame ~= self.current_animation.current then
                self.current_animation.current = new_frame % frame_length
                self.frame_offset = math.floor(self.animation.w * self.current_animation.current)
                self.sprite:setViewport(
                    self.frame_offset,
                    self.animation.h * self.animation.y,
                    self.animation.w,
                    self.animation.h
                )
            end
        else
            _old_animate(self)
        end
    end
end

-- Ludopatía
SMODS.Joker{
    key = 'ludopatia',
    loc_txt = {
        name = 'Ludopatía',
        text = {
            'Al final de cada mano,',
            'gana {C:chips}+15{} chips y {C:mult}+5{} multi por cada',
            '{C:attention}Símbolo{} que poseas.',
            '{C:inactive}(Símbolos: #1#)',
            '{C:mult}+#2#{} Multi | {C:chips}+#3#{} Chips'
        }
    },
    rarity = 3,
    cost = 8,
    pools = {['Maniatromod'] = true},
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    pos = {x = 0, y = 0},
    atlas = 'LudopatiaAtlas',
    animated = true,
    config = { 
        extra = { 
            mult = 0,
            chips = 0,
            symbol_count = 0,
            mult_per_symbol = 5,
            chips_per_symbol = 15,
        } 
    },

    loc_vars = function(self, info_queue, center)
        info_queue[#info_queue+1] = {key = 'mania_credit_idea', set = 'Other', vars = { "AppleMania" }}
        return { 
            vars = { 
                center.ability.extra.symbol_count,
                center.ability.extra.mult,
                center.ability.extra.chips
            } 
        }
    end,

    calculate = function(self, card, context)
        if context.before and not context.blueprint then
            local symbol_count = 0

            if G.consumeables and G.consumeables.cards then
                for _, consumable in ipairs(G.consumeables.cards) do
                    if consumable.ability and consumable.ability.set == 'simbolos' then
                        symbol_count = symbol_count + 1
                    end
                end
            end

            card.ability.extra.symbol_count = symbol_count
            card.ability.extra.mult = symbol_count * card.ability.extra.mult_per_symbol
            card.ability.extra.chips = symbol_count * card.ability.extra.chips_per_symbol

            if symbol_count > 0 then
                card_eval_status_text(card, 'extra', nil, nil, nil, {
                    message = symbol_count .. " Símbolo" .. (symbol_count > 1 and "s" or ""),
                    colour = G.C.PURPLE
                })
            end
        end

        if context.joker_main and card.ability.extra.symbol_count > 0 then
            local mult = card.ability.extra.mult
            local chips = card.ability.extra.chips

            local message_parts = {}
            if mult > 0 then table.insert(message_parts, "+" .. mult .. " Multi") end
            if chips > 0 then table.insert(message_parts, "+" .. chips .. " Fichas") end
            local message = table.concat(message_parts, ", ")

            return {
                message = message,
                mult_mod = mult,
                chip_mod = chips,
                colour = G.C.MULT
            }
        end
    end,
}

-- Euro
SMODS.Atlas{
    key = 'euro',
    path = 'euro.png',
    px = 71,
    py = 95,
}

SMODS.Joker{
    key = 'euro',
    loc_txt = {
        name = 'Euro',
        text = {
            '{C:money}+1${} por cada mano jugada.'
        }
    },
    atlas = 'euro',
    rarity = 1,
    cost = 1,
    pools = {['Maniatromod'] = true},
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    pos = {x = 0, y = 0},
    config = {},

    loc_vars = function(self, info_queue, center)
        info_queue[#info_queue+1] = {key = 'mania_credit_idea', set = 'Other', vars = { "AppleMania" }}
        return { vars = {} }
    end,

    calculate = function(self, card, context)
        if context.joker_main then
            return {
                message = "One euro...!",
                dollars = 1,
                colour = G.C.MONEY
            }
        end
    end,

    check_for_unlock = function(self, args)
        unlock_card(self)
    end,
}

-- Joker Tributario
SMODS.Atlas{
    key = 'tributario',
    path = 'tributario.png',
    px = 71,
    py = 95,
}

SMODS.Joker{
    key = "tributario",
    config = {
        extra = {
            dollars = 3,  
            dollars2 = 0,  
            threshold = 20 
        }
    },
    loc_txt = {
        name = 'Comodín tributario',
        text = {
            'Si tienes menos de {C:money}$#1#{}, este Joker',
            'te dará {C:money}+#2#${} por cada mano jugada.',
            'Si tienes más, no tendrá efecto.'
        }
    },
    pos = { x = 0, y = 0 },
    cost = 6,
    pools = {['Maniatromod'] = true},
    rarity = 2,
    blueprint_compat = true,
    eternal_compat = false,
    perishable_compat = false,
    unlocked = true,
    discovered = true,
    atlas = 'tributario',

    loc_vars = function(self, info_queue, center)
        info_queue[#info_queue+1] = {key = 'mania_credit_idea', set = 'Other', vars = { "Jesu.supongo" }}
        return { vars = { center.ability.extra.threshold, center.ability.extra.dollars } }
    end,

    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main then
            local threshold = card.ability.extra.threshold or 20
            local gain = card.ability.extra.dollars or 3
            local nogain = card.ability.extra.dollars2 or 0

            if G.GAME.dollars < to_big(threshold) then
                return {
                    dollars = gain,
                    message = "+" .. gain .. "$",
                    colour = G.C.MONEY
                }
            else
                return {
                    dollars = nogain,
                    message = "No effect.",
                    colour = G.C.MONEY
                }
            end
        end
    end
}

-- Comodín armero
SMODS.Atlas{
    key = 'armero',
    path = 'escopeta.png',
    px = 71,
    py = 95,
}

SMODS.Joker{
    key = 'armero',
    loc_txt = {
        name = 'Comodín armero',
        text = {
            'Al inicio de cada ciega, crea {C:attention}un cartucho de escopeta.{}',
            'Usar {C:attention}un cartucho de escopeta{} aumenta el {X:mult,C:white}Xmulti{} del Joker.',
            'Al jugar una mano con cartuchos ya cargados, el Joker se reinicia.',
            '{C:inactive}(Actualmente: {X:mult,C:white}X#1#{C:inactive} multi)'
        }
    },
    atlas = 'armero',
    rarity = 3,
    cost = 6,
    pools = {['Maniatromod'] = true},
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    pos = {x = 0, y = 0},
    config = {
        extra = {
            shells = 1,
            shell_bonus = 2.25,
            scale = 1,
            rotation = 1
        }
    },

    loc_vars = function(self, info_queue, center)
        info_queue[#info_queue+1] = {key = 'mania_credit_idea', set = 'Other', vars = { "DoggoDS" }}
        return { 
            vars = { 
                string.format("%.2f", center.ability.extra.shells)
            } 
        }
    end,

    calculate = function(self, card, context)
        if context.setting_blind and not context.blueprint then
            return {
                func = function()
                    G.E_MANAGER:add_event(Event({
                        trigger = 'after',
                        delay = 0.4,
                        func = function()
                            play_sound('timpani')
                            SMODS.add_card({ 
                                set = 'municion', 
                                key = 'c_mania_shell'
                            })                            
                            card:juice_up(0.3, 0.5)
                            card_eval_status_text(card, 'extra', nil, nil, nil, {
                                message = "Recharge",
                                colour = G.C.PURPLE
                            })
                            return true
                        end
                    }))
                    delay(0.6)
                    return true
                end
            }
        end

        if context.using_consumeable then
            if context.consumeable and 
               context.consumeable.ability.set == 'municion' and 
               context.consumeable.config.center.key == 'c_mania_shell' then
                return {
                    func = function()
                        card.ability.extra.shells = card.ability.extra.shells + card.ability.extra.shell_bonus
                        return true
                    end,
                    extra = {
                        func = function()
                            card:juice_up(card.ability.extra.scale, card.ability.extra.rotation)
                            card_eval_status_text(card, 'extra', nil, nil, nil, {
                                message = "X" .. string.format("%.2f", card.ability.extra.shells),
                                colour = G.C.RED
                            })
                            return true
                        end,
                        colour = G.C.WHITE
                    }
                }
            end
        end

        if context.joker_main then
            local shells_value = card.ability.extra.shells
            card.ability.extra.shells = 1
            
            if shells_value > 1 then
                return {
                    message = localize{type='variable', key='a_xmult', vars={shells_value}},
                    Xmult_mod = shells_value,
                    colour = G.C.RED
                }
            end
        end
    end,

    set_ability = function(self, card, initial, delay_sprites)
        card.ability.extra = card.ability.extra or {}
        card.ability.extra.shells = card.ability.extra.shells or 1
        card.ability.extra.shell_bonus = card.ability.extra.shell_bonus or 2.25
        card.ability.extra.scale = card.ability.extra.scale or 1
        card.ability.extra.rotation = card.ability.extra.rotation or 1
    end,

    load = function(self, card, card_table)
        card.ability.extra = card.ability.extra or {}
        card.ability.extra.shells = card_table.ability.extra and card_table.ability.extra.shells or 1
        card.ability.extra.shell_bonus = card_table.ability.extra and card_table.ability.extra.shell_bonus or 2.25
        card.ability.extra.scale = card_table.ability.extra and card_table.ability.extra.scale or 1
        card.ability.extra.rotation = card_table.ability.extra and card_table.ability.extra.rotation or 1
    end,

    check_for_unlock = function(self, args)
        unlock_card(self)
    end,
}

-- Pendrive
SMODS.Atlas{
    key = 'pendrive',
    path = 'pendrive.png',
    px = 71,
    py = 95,
}

SMODS.Joker{
    key = 'pendrive',
    loc_txt = {
        name = 'Pendrive',
        text = {
            'Por cada minuto, este dará {C:blue}+5{} chips.',
            'Alcanza un límite de hasta {C:blue}100{} chips.',
            'Actual: {C:blue}+#1#{} chips'
        }
    },
    atlas = 'pendrive',
    rarity = 2,
    cost = 5,
    pools = {['Maniatromod'] = true},
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    pos = {x = 0, y = 0},
    config = {
        extra = {
            chips = 0,
            max_chips = 100,
            chips_per_minute = 5,
            start_time = nil,
            last_minute_check = 0
        }
    },

    loc_vars = function(self, info_queue, center)
        info_queue[#info_queue+1] = {key = 'mania_credit_idea', set = 'Other', vars = { "AppleMania" }}
        return { vars = { center.ability.extra.chips } }
    end,

    calculate = function(self, card, context)
        if context.joker_main and card.ability.extra.chips > 0 then
            return {
                chip_mod = card.ability.extra.chips,
                message = "+" .. card.ability.extra.chips .. " Chips",
                colour = G.C.CHIPS
            }
        end
    end,

    update = function(self, card, dt)
        if not card.ability.extra.start_time then
            card.ability.extra.start_time = love.timer.getTime()
            card.ability.extra.last_minute_check = 0
        end
        
        local elapsed_time = love.timer.getTime() - card.ability.extra.start_time
        local minutes_elapsed = math.floor(elapsed_time / 60)
        
        if minutes_elapsed > card.ability.extra.last_minute_check and 
           card.ability.extra.chips < card.ability.extra.max_chips then
            
            local minutes_to_add = minutes_elapsed - card.ability.extra.last_minute_check
            local chips_to_add = minutes_to_add * card.ability.extra.chips_per_minute
            
            local new_chips = math.min(
                card.ability.extra.chips + chips_to_add, 
                card.ability.extra.max_chips
            )
            
            if new_chips > card.ability.extra.chips then
                local actual_chips_added = new_chips - card.ability.extra.chips
                card.ability.extra.chips = new_chips
                card.ability.extra.last_minute_check = minutes_elapsed
                
                card_eval_status_text(card, 'extra', nil, nil, nil, {
                    message = "+" .. actual_chips_added .. " Chips (" .. minutes_elapsed .. "min)",
                    colour = G.C.CHIPS
                })
            end
        end
    end,

    set_ability = function(self, card, initial, delay_sprites)
        card.ability.extra = card.ability.extra or {}
        card.ability.extra.chips = card.ability.extra.chips or 0
        card.ability.extra.max_chips = card.ability.extra.max_chips or 100
        card.ability.extra.chips_per_minute = card.ability.extra.chips_per_minute or 5
        card.ability.extra.start_time = card.ability.extra.start_time or love.timer.getTime()
        card.ability.extra.last_minute_check = card.ability.extra.last_minute_check or 0
    end,

    load = function(self, card, card_table)
        card.ability.extra = card.ability.extra or {}
        card.ability.extra.chips = card_table.ability.extra and card_table.ability.extra.chips or 0
        card.ability.extra.max_chips = card_table.ability.extra and card_table.ability.extra.max_chips or 100
        card.ability.extra.chips_per_minute = card_table.ability.extra and card_table.ability.extra.chips_per_minute or 5
        card.ability.extra.start_time = love.timer.getTime()
        card.ability.extra.last_minute_check = 0
    end,

    check_for_unlock = function(self, args)
        unlock_card(self)
    end,
}

-- Lata de cerveza
SMODS.Atlas{
    key = 'lata',
    path = 'can.png',
    px = 71,
    py = 95,
}

SMODS.Joker{
    key = 'lata',
    loc_txt = {
        name = 'Lata de cerveza',
        text = {
            'Empieza con {C:mult}+50{} multi.',
            'Pierde {C:red}-5{} multi por cada',
            '{C:attention}mano{} jugada.',
            '{C:inactive}Actual: {C:mult}+#1#{} multi'
        }
    },
    atlas = 'lata',
    rarity = 2,
    cost = 6,
    pools = {['Maniatromod'] = true},
    unlocked = true,
    discovered = true,
    blueprint_compat = false,
    eternal_compat = false,
    perishable_compat = false,
    pos = {x = 0, y = 0},
    config = { 
        extra = { 
            current_mult = 50, 
            decay = 5,
            hand_played = false  
        } 
    },

    loc_vars = function(self, info_queue, center)
        info_queue[#info_queue+1] = {key = 'mania_credit_idea', set = 'Other', vars = { "Alberto.rueda_07" }}
        return { vars = { center.ability.extra.current_mult } }
    end,

    calculate = function(self, card, context)
        if context.joker_main then
            card.ability.extra.hand_played = true 
            return {
                mult_mod = card.ability.extra.current_mult,
                message = "+"..card.ability.extra.current_mult.." Mult",
                colour = G.C.MULT
            }
        end

        if context.end_of_round and not context.blueprint and card.ability.extra.hand_played then
            card.ability.extra.hand_played = false
            
            local prev_mult = card.ability.extra.current_mult
            card.ability.extra.current_mult = math.max(0, prev_mult - card.ability.extra.decay)
            
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.1,
                func = function()
                    card_eval_status_text(card, 'extra', nil, nil, nil, {
                        message = "-"..card.ability.extra.decay.." Mult (Now +"..card.ability.extra.current_mult..")",
                        colour = prev_mult > 0 and G.C.RED or G.C.UI.TEXT_INACTIVE
                    })
                    return true
                end
            }))

            if card.ability.extra.current_mult <= 0 then
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.4,
                    func = function()
                        play_sound('tarot1')
                        card.T.r = -0.2
                        card:juice_up(0.3, 0.4)
                        card.states.drag.is = false
                        card.children.center.pinch.x = true
                        G.E_MANAGER:add_event(Event({
                            trigger = 'after', 
                            delay = 0.3, 
                            func = function()
                                G.jokers:remove_card(card)
                                card:remove()
                                return true
                            end
                        }))
                        return true
                    end
                }))
            end
        end
    end,

    set_ability = function(self, card, initial, delay_sprites)
        card.ability.extra = card.ability.extra or {}
        card.ability.extra.current_mult = card.ability.extra.current_mult or 50
        card.ability.extra.decay = card.ability.extra.decay or 5
        card.ability.extra.hand_played = card.ability.extra.hand_played or false
    end,

    check_for_unlock = function(self, args)
        unlock_card(self)
    end,
}

-- Paquete de cigarros
SMODS.Atlas{
    key = 'smoker',
    path = 'pack.png',
    px = 71,
    py = 95
}

SMODS.Joker{
    key = 'smoker',
    loc_txt = {
        name = 'Paquete de cigarros',
        text = {
            'Al final de cada ronda:',
            'Si tienes dinero acumulado, pierdes {C:money}-1${}',
            'y este gana {C:mult}+3{} multi',
            '{C:inactive}Actual: {C:mult}+#1#{} multi'
        }
    },
    atlas = 'smoker',
    rarity = 2,
    cost = 4,
    pools = {['Maniatromod'] = true},
    unlocked = true,
    discovered = true,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = false,
    config = { extra = { mult = 0, triggered = false } },

    loc_vars = function(self, info_queue, center)
        info_queue[#info_queue+1] = {key = 'mania_credit_idea', set = 'Other', vars = { "Alberto.rueda_07" }}
        return { vars = { center.ability.extra.mult } }
    end,

    calculate = function(self, card, context)
        if context.setting_blind then
            card.ability.extra.triggered = false
            return
        end

        if context.joker_main and card.ability.extra.mult > 0 then
            return {
                mult_mod = card.ability.extra.mult,
                message = "+"..card.ability.extra.mult.." Multi",
                colour = G.C.MULT
            }
        end

        if context.end_of_round and not context.blueprint and not context.individual
        and not card.ability.extra.triggered then

            if G.GAME.dollars >= to_big(1) then
                card.ability.extra.triggered = true
                ease_dollars(-1)
                card.ability.extra.mult = card.ability.extra.mult + 3

                G.E_MANAGER:add_event(Event({
                    trigger = 'immediate',
                    func = (function()
                        card_eval_status_text(card, 'extra', nil, nil, nil, {
                            message = "-$1",
                            colour = G.C.MONEY
                        })
                        return true
                    end)
                }))

                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.3,
                    func = (function()
                        card_eval_status_text(card, 'extra', nil, nil, nil, {
                            message = "+3 Mult",
                            colour = G.C.MULT
                        })
                        return true
                    end)
                }))

            else
                card_eval_status_text(card, 'extra', nil, nil, nil, {
                    message = "No money!",
                    colour = G.C.UI.TEXT_INACTIVE
                })
            end
        end
    end,

    set_ability = function(self, card, initial, delay_sprites)
        card.ability.extra = card.ability.extra or {}
        card.ability.extra.mult = card.ability.extra.mult or 0
        card.ability.extra.triggered = card.ability.extra.triggered or false
    end
}

-- Pocket Pebbles
SMODS.Atlas{
    key = 'pocket_pebbles',
    path = 'pocketpebbles.png',
    px = 71,
    py = 95,
}

SMODS.Joker{ 
    key = "pocket_pebbles",
    config = {
        extra = {
        }
    },
    loc_txt = {
        ['name'] = 'Piedras de bolsillo',
        ['text'] = {
            [1] = 'Si tienes {C:attention}90%{} o más chips',
            [2] = 'necesarias y {C:red}0 manos{} restantes,',
            [3] = '{C:red}se destruye{} y {C:green}ganas{} la ronda.'
        },
        ['unlock'] = {
            [1] = ''
        }
    },
    pos = {
        x = 0,
        y = 0
    },
    cost = 3,
    rarity = 2,
    blueprint_compat = false,
    eternal_compat = false,
    perishable_compat = false,
    pools = {['Maniatromod'] = true},
    unlocked = true,
    discovered = true,
    atlas = 'pocket_pebbles',

    loc_vars = function(self, info_queue, center)
        info_queue[#info_queue+1] = {key = 'mania_credit_idea', set = 'Other', vars = { "DoggoDS" }}
        return { vars = {} }
    end,

    in_pool = function(self, args)
          return (
          not args 
          or args.source ~= 'buf' and args.source ~= 'jud' and args.source ~= 'uta' 
          or args.source == 'sho' or args.source == 'rif' or args.source == 'rta' or args.source == 'sou' or args.source == 'wra'
          )
          and true
      end,

    calculate = function(self, card, context)
        if context.after and context.cardarea == G.jokers  then
            if (G.GAME.chips / G.GAME.blind.chips >= to_big(0.9) and G.GAME.current_round.hands_left == 0) then
                return {
                    func = function()
                card:start_dissolve()
                return true
            end,
                    message = "Close call!",
                    extra = {
                        func = function()
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.5,
                func = function()
                    G.GAME.chips = G.GAME.blind.chips
                    G.STATE = G.STATES.HAND_PLAYED
                        G.STATE_COMPLETE = true
                        card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "Defeated", colour = G.C.RED})
                    return true
                end,
            }))
            
                    return true
                end,
                        colour = G.C.GREEN
                        }
                }
            end
        end
    end
}

-- Medalla Yo-kai
SMODS.Atlas{
    key = 'medalla_yokai',
    path = 'yokai.png',
    px = 71,
    py = 95,
}

SMODS.Joker{
    key = 'medalla_yokai',
    loc_txt = {
        name = 'Medalla Yo-kai',
        text = {
            'Cuando uses un {C:purple}consumible{}, crea otro',
            'del mismo tipo y lo añade a tu inventario.'
        }
    },
    atlas = 'medalla_yokai',
    rarity = 3, 
    cost = 8,
    pools = {['Maniatromod'] = true},
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = false,
    perishable_compat = false,
    pos = {x = 0, y = 0},

    loc_vars = function(self, info_queue, center)
        info_queue[#info_queue+1] = {key = 'mania_credit_idea', set = 'Other', vars = { "AppleMania" }}
        return { vars = {} }
    end,

    calculate = function(self, card, context)
        if context.using_consumeable and context.consumeable then
            local consumed_card = context.consumeable
            local consumed_set = consumed_card.config.center.set

            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.3,
                func = function()
                    local category = nil
                    local new_card = nil
                    
                    if consumed_set == 'Tarot' then
                        category = 'Tarot'
                        new_card = create_card(category, G.consumeables, nil, nil, nil, nil, nil, 'yokai')
                    elseif consumed_set == 'Planet' then
                        category = 'Planet'
                        new_card = create_card(category, G.consumeables, nil, nil, nil, nil, nil, 'yokai')
                    elseif consumed_set == 'Spectral' then
                        category = 'Spectral'
                        new_card = create_card(category, G.consumeables, nil, nil, nil, nil, nil, 'yokai')
                    elseif consumed_set == 'simbolos' then
                        category = 'Symbols'
                        local symbols_pool = {
                            'c_mania_cerezas',
                            'c_mania_limon',
                            'c_mania_treboles',
                            'c_mania_campanas',
                            'c_mania_diamantes',
                            'c_mania_monedas',
                            'c_mania_sietes'
                        }
                        local random_symbol = pseudorandom_element(symbols_pool, pseudoseed('yokai_symbol'))
                        new_card = create_card('Consumeable', G.consumeables, nil, nil, nil, nil, random_symbol, 'yokai')
                    else
                        category = 'Tarot'
                        new_card = create_card(category, G.consumeables, nil, nil, nil, nil, nil, 'yokai')
                    end

                    if new_card then
                        new_card:add_to_deck()
                        G.consumeables:emplace(new_card)

                        local message = "Another "
                        if category == 'Tarot' then
                            message = "Another Tarot!"
                        elseif category == 'Planet' then
                            message = "Another Planet!"
                        elseif category == 'Spectral' then
                            message = "Another Spectral!"
                        elseif category == 'Symbols' then
                            message = "Another Symbol!"
                        end

                        card_eval_status_text(card, 'extra', nil, nil, nil, {
                            message = message,
                            colour = G.C.PURPLE
                        })
                    end

                    return true
                end
            }))

            return {}
        end
    end,

    check_for_unlock = function(self, args)
        unlock_card(self)
    end,
}

-- Diédrico
SMODS.Atlas{
    key = 'diedrico',
    path = 'diedrico.png',
    px = 71,
    py = 95,
}

SMODS.Joker{
    key = 'diedrico',
    loc_txt = {
        name = 'Diédrico',
        text = {
            'Una mano cuenta como {C:attention}dos{} manos.'
        }
    },
    atlas = 'diedrico',
    rarity = 2,
    cost = 6,
    pools = {['Maniatromod'] = true},
    unlocked = true,
    discovered = true,
    eternal_compat = true,
    perishable_compat = true,
    config = { extra = {} },

    loc_vars = function(self, info_queue, center)
        info_queue[#info_queue+1] = {key = 'mania_credit_idea', set = 'Other', vars = { "AppleMania" }}
        return { vars = {} }
    end,

    calculate = function(self, card, context)
        if context.joker_main then
            for _, other in ipairs(G.jokers.cards) do
                if other ~= card and other.ability and other.ability.extra then
                    if type(other.ability.extra.hands_played) == "number" then
                        other.ability.extra.hands_played = other.ability.extra.hands_played + 1
                    end
                end
            end

            return {
                message = "PHP and PVP!",
                colour = G.C.PURPLE
            }
        end
    end,

    set_ability = function(self, card, initial, delay_sprites)
        card.ability.extra = card.ability.extra or {}
    end,

    load = function(self, card, card_table)
        card.ability.extra = card.ability.extra or {}
    end,

    check_for_unlock = function(self, args)
        unlock_card(self)
    end,
}

-- Frutos del bosque
SMODS.Atlas{
    key = 'frutos_bosque',
    path = 'circus.png',
    px = 71,
    py = 95,
}

SMODS.Joker{
    key = 'frutos_bosque',
    loc_txt = {
        name = 'Frutos del bosque',
        text = {
            '{C:blue}+30{} chips o {C:mult}+15{} multi.'
        }
    },
    atlas = 'frutos_bosque',
    rarity = 1,
    cost = 4,
    pools = {['Maniatromod'] = true},
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    pos = {x = 0, y = 0},
    config = {
        extra = {
            chips_bonus = 30,
            mult_bonus = 15
        }
    },

    loc_vars = function(self, info_queue, center)
        info_queue[#info_queue+1] = {key = 'mania_credit_idea', set = 'Other', vars = { "AppleMania" }}
        return { vars = {} }
    end,

    calculate = function(self, card, context)
        if context.joker_main then
            if math.random() < 0.5 then
                return {
                    chip_mod = card.ability.extra.chips_bonus,
                    message = "+" .. card.ability.extra.chips_bonus .. " Chips",
                    colour = G.C.CHIPS
                }
            else
                return {
                    mult_mod = card.ability.extra.mult_bonus,
                    message = "+" .. card.ability.extra.mult_bonus .. " Mult",
                    colour = G.C.MULT
                }
            end
        end
    end,

    set_ability = function(self, card, initial, delay_sprites)
        card.ability.extra = card.ability.extra or {}
        card.ability.extra.chips_bonus = card.ability.extra.chips_bonus or 30
        card.ability.extra.mult_bonus = card.ability.extra.mult_bonus or 15
    end,

    check_for_unlock = function(self, args)
        unlock_card(self)
    end,
}

-- Bola 8 Mágica
SMODS.Atlas{
    key = 'bola8',
    path = '8ball.png',
    px = 71,
    py = 95,
}

SMODS.Joker{
    key = 'bola8',
    loc_txt = {
        name = 'Bola 8 Mágica',
        text = {
            'Durante 8 rondas, este Joker dará {X:mult,C:white}X2.5{} multi.',
            'Faltan {C:attention}#1#{} rondas.'
        }
    },
    atlas = 'bola8',
    rarity = 3,
    cost = 9,
    pools = {['Maniatromod'] = true},
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = false,
    perishable_compat = false,
    config = { 
        extra = { 
            rounds_left = 8, 
            xmult = 2.5,
            processed_round_end = false
        } 
    },

    loc_vars = function(self, info_queue, center)
        info_queue[#info_queue+1] = {key = 'mania_credit_idea', set = 'Other', vars = { "AppleMania" }}
        return { vars = { center.ability.extra.rounds_left } }
    end,
    
    calculate = function(self, card, context)
        if context.setting_blind and not context.blueprint then
            card.ability.extra.processed_round_end = false
        end

        if context.joker_main and card.ability.extra.rounds_left > 0 then
            return {
                Xmult_mod = card.ability.extra.xmult,
                message = "x" .. string.format("%.1f", card.ability.extra.xmult),
                colour = G.C.RED
            }
        end

        if context.end_of_round and not context.blueprint and not card.ability.extra.processed_round_end then
            card.ability.extra.processed_round_end = true

            if card.ability.extra.rounds_left > 0 then
                card.ability.extra.rounds_left = card.ability.extra.rounds_left - 1
                
                if card.ability.extra.rounds_left <= 0 then
                    G.E_MANAGER:add_event(Event({
                        trigger = 'after',
                        delay = 0.4,
                        func = function()
                            card_eval_status_text(card, 'extra', nil, nil, nil, {
                                message = "The magic fades!",
                                colour = G.C.PURPLE
                            })
                            play_sound('tarot1')
                            card:juice_up(0.3, 0.4)
                            G.E_MANAGER:add_event(Event({
                                trigger = 'after', 
                                delay = 0.3, 
                                func = function()
                                    G.jokers:remove_card(card)
                                    card:remove()
                                    card = nil
                                    return true
                                end
                            }))
                            return true
                        end
                    }))
                end
            end
        end
    end,

    set_ability = function(self, card, initial, delay_sprites)
        card.ability.extra = card.ability.extra or {}
        card.ability.extra.rounds_left = card.ability.extra.rounds_left or 8
        card.ability.extra.xmult = card.ability.extra.xmult or 2.5
        card.ability.extra.processed_round_end = card.ability.extra.processed_round_end or false
    end,

    load = function(self, card, card_table)
        card.ability.extra = card.ability.extra or {}
        card.ability.extra.rounds_left = card_table.ability.extra and card_table.ability.extra.rounds_left or 8
        card.ability.extra.xmult = card_table.ability.extra and card_table.ability.extra.xmult or 2.5
        card.ability.extra.processed_round_end = false
    end
}

-- Cotton (Nuevo Comienzo)
SMODS.Atlas{
    key = 'cotton',
    path = 'recuerdo.png',
    px = 71,
    py = 95
}

SMODS.Joker{
    key = 'cotton',
    loc_txt = {
        name = 'Nuevo comienzo',
        text = {
            'Al final de cada ronda:',
            'Destruye {C:spectral}un Joker{} al azar',
            'y gana {X:chips,C:white}+0.5X{} chips',
            'Actual: {X:chips,C:white}X#1#{} chips',
        }
    },
    atlas = 'cotton',
    rarity = 4,
    cost = 9,
    pools = {['Maniatromod'] = true},
    unlocked = true,
    discovered = true,
    blueprint_compat = false,
    eternal_compat = false,
    perishable_compat = false,
    pos = {x = 0, y = 0},
    config = { 
        extra = { 
            x_chips = 1.0,
            chip_gain = 0.5,
            triggered_this_round = false
        } 
    },

    loc_vars = function(self, info_queue, center)
        info_queue[#info_queue+1] = {key = 'mania_credit_idea', set = 'Other', vars = { "AppleMania" }}
        return { vars = { string.format("%.1f", center.ability.extra.x_chips) } }
    end,

    calculate = function(self, card, context)
        if context.setting_blind and not context.blueprint then
            card.ability.extra.triggered_this_round = false
        end

        if context.joker_main and card.ability.extra.x_chips > 1 then
            return {
                message = "X" .. string.format("%.1f", card.ability.extra.x_chips),
                x_chips = card.ability.extra.x_chips,
                colour = G.C.CHIPS
            }
        end

        if context.end_of_round and not context.blueprint and not card.ability.extra.triggered_this_round then
            card.ability.extra.triggered_this_round = true
            
            local destroyable_jokers = {}
            
            for _, j in ipairs(G.jokers.cards) do
                if j ~= card and not j.ability.eternal and j.config.center.key ~= 'j_mania_cotton' then
                    table.insert(destroyable_jokers, j)
                end
            end

            if #destroyable_jokers > 0 then
                local joker_to_destroy = destroyable_jokers[math.random(#destroyable_jokers)]
                
                card.ability.extra.x_chips = card.ability.extra.x_chips + card.ability.extra.chip_gain
                
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.3,
                    blockable = false,
                    func = function()
                        card_eval_status_text(joker_to_destroy, 'extra', nil, nil, nil, {
                            message = "Progress lost!",
                            colour = G.C.RED
                        })
                        
                        play_sound('tarot1')
                        joker_to_destroy.T.r = -0.2
                        joker_to_destroy:juice_up(0.3, 0.4)
                        joker_to_destroy.states.drag.is = false
                        joker_to_destroy.children.center.pinch.x = true
                        
                        G.E_MANAGER:add_event(Event({
                            trigger = 'after', 
                            delay = 0.3, 
                            blockable = false,
                            func = function()
                                G.jokers:remove_card(joker_to_destroy)
                                joker_to_destroy:remove()
                                joker_to_destroy = nil
                                return true
                            end
                        }))
                        
                        return true
                    end
                }))

                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.7,
                    blockable = false,
                    func = function()
                        card_eval_status_text(card, 'extra', nil, nil, nil, {
                            message = "+" .. card.ability.extra.chip_gain .. "X Chips",
                            colour = G.C.CHIPS
                        })
                        return true
                    end
                }))
                
                return {
                    message = "...",
                    colour = G.C.BLUE
                }
            else
                return {
                    message = "!",
                    colour = G.C.UI.TEXT_INACTIVE
                }
            end
        end
    end,

    set_ability = function(self, card, initial, delay_sprites)
        card.ability.extra = card.ability.extra or {}
        card.ability.extra.x_chips = card.ability.extra.x_chips or 1.0
        card.ability.extra.chip_gain = card.ability.extra.chip_gain or 0.5
        card.ability.extra.triggered_this_round = card.ability.extra.triggered_this_round or false
    end,

    load = function(self, card, card_table)
        card.ability.extra = card.ability.extra or {}
        card.ability.extra.x_chips = card_table.ability.extra and card_table.ability.extra.x_chips or 1.0
        card.ability.extra.chip_gain = card_table.ability.extra and card_table.ability.extra.chip_gain or 0.5
        card.ability.extra.triggered_this_round = false 
    end,

    check_for_unlock = function(self, args)
        unlock_card(self)
    end,
}

-- Nira
SMODS.Atlas{
    key = 'nira',
    path = 'nira.png',
    px = 71,
    py = 95,
}

SMODS.Joker{
    key = 'nira',
    loc_txt = {
        name = 'Nira',
        text = {
            '{X:dark_edition,C:white}^#1#{} multi',
            'Si la mano jugada solo contiene {C:hearts}corazones{},',
            'aumenta {X:dark_edition,C:white}+0.2^{} multi.'
        }
    },
    atlas = 'nira',
    rarity = 4,
    cost = 15,
    pools = {['Maniatromod'] = true},
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    pos = {x = 0, y = 0},
    soul_pos = { x = 0, y = 1 },
    config = {
        extra = {
            emult = 1.0,
            emult_gain = 0.2
        }
    },

    loc_vars = function(self, info_queue, center)
        info_queue[#info_queue+1] = {key = 'mania_credit_idea', set = 'Other', vars = { "Bunbxnblxxd" }}
        return { vars = { string.format("%.1f", center.ability.extra.emult) } }
    end,

    calculate = function(self, card, context)
        if context.joker_main and context.full_hand then
            local all_hearts = true
            for _, played_card in ipairs(context.full_hand) do
                if not played_card:is_suit('Hearts') then
                    all_hearts = false
                    break
                end
            end

            if all_hearts then
                card.ability.extra.emult = card.ability.extra.emult + card.ability.extra.emult_gain
                return {
                    message = "^" .. string.format("%.1f", card.ability.extra.emult),
                    e_mult = card.ability.extra.emult,
                    colour = G.C.RED
                }
            end
        end
    end,

    set_ability = function(self, card, initial, delay_sprites)
        card.ability.extra = card.ability.extra or {}
        card.ability.extra.emult = card.ability.extra.emult or 1.0
        card.ability.extra.emult_gain = card.ability.extra.emult_gain or 0.2
    end,

    load = function(self, card, card_table)
        card.ability.extra = card.ability.extra or {}
        card.ability.extra.emult = card_table.ability.extra and card_table.ability.extra.emult or 1.0
        card.ability.extra.emult_gain = card_table.ability.extra and card_table.ability.extra.emult_gain or 0.2
    end,

    check_for_unlock = function(self, args)
        unlock_card(self)
    end,
}

-- Matkrov
SMODS.Atlas{
    key = 'matkrov',
    path = 'matkrov.png',
    px = 71,
    py = 95,
}

SMODS.Joker{
    key = 'matkrov',
    loc_txt = {
        name = 'Matkrov',
        text = {
            'Cada {C:red}Joker raro{} que tengas',
            'dará {X:chips,C:white}X5{} chips.',
        }
    },
    atlas = 'matkrov',
    rarity = 4,
    cost = 15,
    pools = {['Maniatromod'] = true},
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = false,
    perishable_compat = false,
    pos = {x=0, y=0},
    soul_pos = { x = 1, y = 0 },
    config = {
        extra = {
            rare_jokers = 0,
            x_chips = 1
        }
    },

    loc_vars = function(self, info_queue, center)
        info_queue[#info_queue+1] = {key = 'mania_credit_idea', set = 'Other', vars = { "Bunbxnblxxd" }}
        return { vars = { 
            center.ability.extra.rare_jokers,
            center.ability.extra.x_chips
        } }
    end,

    calculate = function(self, card, context)
        if context.joker_main and not context.blueprint then
            local rare_count = 0
            
            for _, joker in ipairs(G.jokers.cards) do
                if joker.config and joker.config.center and joker.config.center.rarity == 3 then
                    rare_count = rare_count + 1
                end
            end
            
            card.ability.extra.rare_jokers = rare_count
            card.ability.extra.x_chips = math.max(1, 5 * rare_count)
            
            if card.ability.extra.x_chips > 1 then
                return {
                    message = "X" .. card.ability.extra.x_chips .. " Chips ",
                    x_chips = card.ability.extra.x_chips,
                    colour = G.C.CHIPS
                }
            end
        end
    end,

    set_ability = function(self, card, initial, delay_sprites)
        card.ability.extra = card.ability.extra or {}
        card.ability.extra.rare_jokers = card.ability.extra.rare_jokers or 0
        card.ability.extra.x_chips = card.ability.extra.x_chips or 1
    end,

    load = function(self, card, card_table)
        card.ability.extra = card.ability.extra or {}
        card.ability.extra.rare_jokers = card_table.ability.extra and card_table.ability.extra.rare_jokers or 0
        card.ability.extra.x_chips = card_table.ability.extra and card_table.ability.extra.x_chips or 1
    end,

    check_for_unlock = function(self, args)
        unlock_card(self)
    end,
}

-- Drokstav
SMODS.Atlas{
    key = 'drokstav',
    path = 'drokstav.png',
    px = 71,
    py = 95,
}

SMODS.Joker{
    key = 'drokstav',
    loc_txt = {
        name = 'Drokstav',
        text = {
            'Al acabar la mano, crea {C:dark_edition}una carta mejorada aleatoria{}',
            'y la añade directamente a tu mano.'
        }
    },
    atlas = 'drokstav',
    rarity = 4,
    cost = 15,
    pools = {['Maniatromod'] = true},
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = false,
    perishable_compat = false,
    pos = {x=0, y=0},
    soul_pos = { x = 0, y = 1 },
    config = { extra = {} },

    loc_vars = function(self, info_queue, center)
        info_queue[#info_queue+1] = {key = 'mania_credit_idea', set = 'Other', vars = { "Bunbxnblxxd" }}
        return { vars = {} }
    end,

    calculate = function(self, card, context)
        if context.after and context.cardarea == G.jokers then
            return {
                message = "AAAAAAAAHHHH!",
                extra = {
                    func = function()
                        local card_front = pseudorandom_element(G.P_CARDS, pseudoseed('drokstav_front'))
                        local chosen_center = pseudorandom_element({
                            G.P_CENTERS.m_gold,
                            G.P_CENTERS.m_steel,
                            G.P_CENTERS.m_glass,
                            G.P_CENTERS.m_wild,
                            G.P_CENTERS.m_mult,
                            G.P_CENTERS.m_lucky,
                            G.P_CENTERS.m_stone,
                            G.P_CENTERS.m_mania_citrico,
                            G.P_CENTERS.m_mania_dulce
                        }, pseudoseed('drokstav_enhance'))

                        local chosen_seal = pseudorandom_element({"Gold", "Red", "Blue", "Purple", "mania_sellocitrico"}, pseudoseed('drokstav_seal'))
                        local chosen_edition = pseudorandom_element({"e_foil", "e_holo", "e_polychrome", "e_negative", "e_mania_citrico", "e_mania_iridiscente"}, pseudoseed('drokstav_edition'))

                        for _, c in ipairs(G.hand.cards) do
                            if c.config.center == chosen_center and c.seal == chosen_seal and c.edition and c.edition.key == chosen_edition then
                                return
                            end
                        end

                        local new_card = create_playing_card({
                            front = card_front,
                            center = chosen_center
                        }, G.hand, true, false, nil, true)

                        new_card:set_seal(chosen_seal, true)
                        new_card:set_edition(chosen_edition, true)

                        G.hand:emplace(new_card)
                    end,
                }
            }
        end
        return {}
    end,
}

-- Letko
SMODS.Atlas{
    key = 'letko',
    path = 'letko.png',
    px = 71,
    py = 95,
}

SMODS.Joker{
    key = 'letko',
    loc_txt = {
        name = 'Letko',
        text = {
            'Aplica {X:green,C:white}N!{} multi basado en el número',
            'de cartas jugadas en tu {C:attention}primera mano{}.',
            'Actual: {X:green,C:white}X#1#{} multi',
        }
    },
    atlas = 'letko',
    rarity = 4,
    cost = 15,
    pools = {['Maniatromod'] = true},
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = false,
    perishable_compat = false,
    pos = {x=0, y=0},
    soul_pos = { x = 0, y = 1 },
    config = {
        extra = {
            factorial_mult = 1,
            first_hand_played = false,
            cards_in_first_hand = 0
        }
    },

    loc_vars = function(self, info_queue, center)
        info_queue[#info_queue+1] = {key = 'mania_credit_idea', set = 'Other', vars = { "Bunbxnblxxd" }}
        return { vars = { center.ability.extra.factorial_mult } }
    end,

    calculate = function(self, card, context)
        if context.setting_blind and not context.blueprint then
            card.ability.extra.first_hand_played = false
            card.ability.extra.factorial_mult = 1
            card.ability.extra.cards_in_first_hand = 0
            return
        end

        if context.joker_main and context.full_hand and not card.ability.extra.first_hand_played then
            card.ability.extra.first_hand_played = true
            card.ability.extra.cards_in_first_hand = #context.full_hand
            
            local function factorial(n)
                if n <= 1 then
                    return 1
                else
                    return n * factorial(n - 1)
                end
            end
            
            card.ability.extra.factorial_mult = factorial(card.ability.extra.cards_in_first_hand)
            
            return {
                message = card.ability.extra.cards_in_first_hand .. '! = X' .. card.ability.extra.factorial_mult,
                Xmult_mod = card.ability.extra.factorial_mult,
                colour = G.C.GREEN
            }
        end
        
        if context.joker_main and card.ability.extra.first_hand_played and card.ability.extra.factorial_mult > 1 then
            return {
                message = 'X' .. card.ability.extra.factorial_mult .. ' (' .. card.ability.extra.cards_in_first_hand .. '!)',
                Xmult_mod = card.ability.extra.factorial_mult,
                colour = G.C.GREEN
            }
        end
    end,

    set_ability = function(self, card, initial, delay_sprites)
        card.ability.extra = card.ability.extra or {}
        card.ability.extra.factorial_mult = card.ability.extra.factorial_mult or 1
        card.ability.extra.first_hand_played = card.ability.extra.first_hand_played or false
        card.ability.extra.cards_in_first_hand = card.ability.extra.cards_in_first_hand or 0
    end,

    load = function(self, card, card_table)
        card.ability.extra = card.ability.extra or {}
        card.ability.extra.factorial_mult = card_table.ability.extra and card_table.ability.extra.factorial_mult or 1
        card.ability.extra.first_hand_played = card_table.ability.extra and card_table.ability.extra.first_hand_played or false
        card.ability.extra.cards_in_first_hand = card_table.ability.extra and card_table.ability.extra.cards_in_first_hand or 0
    end,

    check_for_unlock = function(self, args)
        unlock_card(self)
    end,
}

-- Fireball
SMODS.Atlas{
    key = 'fireball',
    path = 'fireball.png',
    px = 71,
    py = 95,
}

SMODS.Joker{
    key = 'fireball',
    loc_txt = {
        name = 'Fireball',
        text = {
            'Cada carta jugada tiene un {C:green,E:1}25%{} de',
            'probabilidad de {C:attention}quintuplicar{} sus chips base.',
        }
    },
    atlas = 'fireball',
    rarity = 3,
    cost = 7,
    pools = {['Maniatromod'] = true},
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    pos = {x = 0, y = 0},
    config = {
        extra = {
            probability = 0.25,
            multiplier = 5
        }
    },

    loc_vars = function(self, info_queue, center)
        info_queue[#info_queue+1] = {key = 'mania_credit_idea', set = 'Other', vars = { "K4l1z_33" }}
        return { vars = {} }
    end,

    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and context.other_card then
            if math.random() < card.ability.extra.probability then
                local base_chips = context.other_card.base.nominal
                
                local bonus_chips = base_chips * (card.ability.extra.multiplier - 1)
                
                return {
                    chips = bonus_chips,
                }
            end
        end
    end,

    set_ability = function(self, card, initial, delay_sprites)
        card.ability.extra = card.ability.extra or {}
        card.ability.extra.probability = card.ability.extra.probability or 0.25
        card.ability.extra.multiplier = card.ability.extra.multiplier or 5
    end,

    check_for_unlock = function(self, args)
        unlock_card(self)
    end,
}

-- Funciones para lo del sonido del juego
function get_game_volume()
    local volume = G.SETTINGS.SOUND.volume or 50
    
    if volume <= 1 then
        volume = math.floor(volume * 100)
    end
    
    return math.max(0, math.min(100, math.floor(volume)))
end

-- On the Beat
SMODS.Atlas{
    key = 'onthebeat',
    path = 'doret.png',
    px = 71,
    py = 95,
}

SMODS.Joker{
    key = 'onthebeat',
    loc_txt = {
        name = 'On the Beat',
        text = {
            'Gana {C:mult}+#1#{} multi basado en el',
            '{C:attention}volumen principal del juego{}.',
            '{C:inactive}(Volumen actual: #2#%)'
        }
    },
    atlas = 'onthebeat',
    rarity = 3,
    cost = 8,
    pools = {['Maniatromod'] = true},
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    pos = {x = 0, y = 0},
    config = {
        extra = {
            mult = 50,
            current_volume = 50,
            last_check = 0,
            check_interval = 0.5
        }
    },

    loc_vars = function(self, info_queue, center)
        info_queue[#info_queue+1] = {key = 'mania_credit_idea', set = 'Other', vars = { "AppleMania, SrDoret" }}
        return { 
            vars = { 
                center.ability.extra.mult,
                center.ability.extra.current_volume
            } 
        }
    end,

    calculate = function(self, card, context)
        if context.joker_main then
            local safe_mult = math.max(0, math.min(100, card.ability.extra.mult))
            
            if safe_mult > 0 then
                return {
                    mult_mod = safe_mult,
                    message = "+" .. safe_mult .. " Multi",
                    colour = G.C.MULT
                }
            end
        end
    end,

    update = function(self, card, dt)
        card.ability.extra.last_check = (card.ability.extra.last_check or 0) + dt
        
        if card.ability.extra.last_check >= card.ability.extra.check_interval then
            card.ability.extra.last_check = 0
            
            local volume = get_game_volume()
            local old_volume = card.ability.extra.current_volume
            
            card.ability.extra.current_volume = volume
            card.ability.extra.mult = volume
            
            if math.abs(volume - old_volume) >= 5 then
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.1,
                    func = function()
                        card_eval_status_text(card, 'extra', nil, nil, nil, {
                            message = "Vol: " .. volume .. "%",
                            colour = volume > old_volume and G.C.GREEN or G.C.RED
                        })
                        return true
                    end
                }))
            end
        end
    end,

    set_ability = function(self, card, initial, delay_sprites)
        card.ability.extra = card.ability.extra or {}
        card.ability.extra.last_check = 0
        card.ability.extra.check_interval = 0.5
        
        local volume = get_game_volume()
        card.ability.extra.current_volume = volume
        card.ability.extra.mult = volume
    end,

    load = function(self, card, card_table)
        card.ability.extra = card.ability.extra or {}
        card.ability.extra.last_check = 0
        card.ability.extra.check_interval = 0.5
        
        local volume = get_game_volume()
        card.ability.extra.current_volume = volume
        card.ability.extra.mult = volume
    end,

    check_for_unlock = function(self, args)
        unlock_card(self)
    end,
}

-- Freckles
SMODS.Atlas{
    key = 'freckles',
    path = 'freckles.png',
    px = 71,
    py = 95,
}

SMODS.Joker{
    key = 'freckles',
    loc_txt = {
        name = 'Freckles',
        text = {
            'Da {X:mult,C:white}X4{} multi si la velocidad',
            'del juego está a {C:attention}X1{}.'
        }
    },
    atlas = 'freckles',
    rarity = 2,
    cost = 6,
    pools = {['Maniatromod'] = true},
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    pos = {x = 0, y = 0},
    config = {
        extra = {
            xmult = 4
        }
    },

    loc_vars = function(self, info_queue, center)
        info_queue[#info_queue+1] = {key = 'mania_credit_idea', set = 'Other', vars = { "AppleMania" }}
        return { vars = { center.ability.extra.xmult } }
    end,

    calculate = function(self, card, context)
        if context.joker_main then
            local game_speed = G.SETTINGS.GAMESPEED or 1
            
            if game_speed == 1 then
                return {
                    message = "X" .. card.ability.extra.xmult,
                    Xmult_mod = card.ability.extra.xmult,
                    colour = G.C.MULT
                }
            end
        end
    end,

    set_ability = function(self, card, initial, delay_sprites)
        card.ability.extra = card.ability.extra or {}
        card.ability.extra.xmult = card.ability.extra.xmult or 4
    end,

    check_for_unlock = function(self, args)
        unlock_card(self)
    end,
}

-- Lanzaguisantes
SMODS.Atlas{
    key = 'lanzaguisantes',
    path = 'peashooter.png',
    px = 71,
    py = 95,
}

SMODS.Joker{
    key = 'lanzaguisantes',
    loc_txt = {
        name = 'Lanzaguisantes',
        text = {
            '{C:blue}+#1#{} chips.',
            'Aumenta {C:blue}+10{} chips cada mano jugada.',
            '{C:inactive}Se reinicia al final de la ronda.{}',
        }
    },
    atlas = 'lanzaguisantes',
    rarity = 1,
    cost = 4,
    pools = {['Maniatromod'] = true},
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    pos = {x = 0, y = 0},
    config = {
        extra = {
            chips = 10,
            chips_gain = 10
        }
    },

    loc_vars = function(self, info_queue, center)
        info_queue[#info_queue+1] = {key = 'mania_credit_idea', set = 'Other', vars = { "AppleMania" }}
        return { vars = { center.ability.extra.chips } }
    end,

    calculate = function(self, card, context)
        if context.setting_blind and not context.blueprint then
            card.ability.extra.chips = 10
        end

        if context.joker_main then
            local current_chips = card.ability.extra.chips
            card.ability.extra.chips = card.ability.extra.chips + card.ability.extra.chips_gain
            
            return {
                chip_mod = current_chips,
                message = "+" .. current_chips .. " Chips",
                colour = G.C.CHIPS
            }
        end
    end,

    set_ability = function(self, card, initial, delay_sprites)
        card.ability.extra = card.ability.extra or {}
        card.ability.extra.chips = card.ability.extra.chips or 10
        card.ability.extra.chips_gain = card.ability.extra.chips_gain or 10
    end,

    load = function(self, card, card_table)
        card.ability.extra = card.ability.extra or {}
        card.ability.extra.chips = card_table.ability.extra and card_table.ability.extra.chips or 10
        card.ability.extra.chips_gain = card_table.ability.extra and card_table.ability.extra.chips_gain or 10
    end,

    check_for_unlock = function(self, args)
        unlock_card(self)
    end,
}

-- Call 
SMODS.Atlas{
    key = 'call',
    path = 'call.png',
    px = 71,
    py = 95,
}

SMODS.Joker{
    key = "call",
    atlas = 'call',
    pos = { x = 0, y = 0 },
    rarity = 2,
    cost = 5,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    pools = { ["Maniatromod"] = true },
    config = { extra = { ratio = 0.01 } },
    
    loc_txt = {
        name = 'Call',
        text = {
            'Otorga el {C:attention}1%{} de las fichas',
            'requeridas por la {C:attention}Ciega{} actual.',
            '{C:inactive}(Actual: {C:blue}+#1#{C:inactive} Fichas)'
        }
    },

    loc_vars = function(self, info_queue, card)
        local blind_chips = 0
        if G.GAME and G.GAME.blind then
            blind_chips = (type(G.GAME.blind.chips) == 'table') and to_number(G.GAME.blind.chips) or G.GAME.blind.chips
        end
        local current_chips = math.floor(blind_chips * card.ability.extra.ratio)
        info_queue[#info_queue+1] = {key = 'mania_credit_idea', set = 'Other', vars = { "InkystA" }}
        return { vars = { current_chips } }
    end,
    
    calculate = function(self, card, context)
        if context.joker_main then
            local blind_chips = (type(G.GAME.blind.chips) == 'table') and to_number(G.GAME.blind.chips) or G.GAME.blind.chips
            local chips_to_add = math.floor(blind_chips * card.ability.extra.ratio)
            
            return {
                chip_mod = chips_to_add,
                message = '+' .. chips_to_add,
                colour = G.C.CHIPS
            }
        end
    end
}

-- Freddy Fazbear
SMODS.Atlas{
    key = 'freddy',
    path = 'freddy.png',
    px = 71,
    py = 95,
}

SMODS.Joker{
    key = 'freddy',
    loc_txt = {
        name = 'Freddy Fazbear',
        text = {
            'Cada {C:attention}As{}, {C:attention}9{}, {C:attention}8{} o {C:attention}7{} jugado da {C:mult}+20{} multi.',
            'Si este Joker está en el {C:attention}extremo derecho{},',
            'da {C:mult}+40{} multi en su lugar.'
        }
    },
    atlas = 'freddy',
    rarity = 2,
    cost = 6,
    pools = {['Maniatromod'] = true},
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    pos = {x = 0, y = 0},
    config = {
        extra = {
            mult_normal = 20,
            mult_rightmost = 40
        }
    },

    loc_vars = function(self, info_queue, center)
        info_queue[#info_queue+1] = {key = 'mania_credit_idea', set = 'Other', vars = { "AppleMania" }}
        return { vars = {} }
    end,

    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and context.other_card then
            local card_id = context.other_card:get_id()
            
            if card_id == 14 or card_id == 9 or card_id == 8 or card_id == 7 then
                local is_rightmost = true
                
                if G.jokers and G.jokers.cards then
                    for i = 1, #G.jokers.cards do
                        if G.jokers.cards[i] == card then
                            if i < #G.jokers.cards then
                                is_rightmost = false
                            end
                            break
                        end
                    end
                end
                
                local mult_to_give = is_rightmost and card.ability.extra.mult_rightmost or card.ability.extra.mult_normal
                
                return {
                    mult = mult_to_give
                }
            end
        end
    end,

    set_ability = function(self, card, initial, delay_sprites)
        card.ability.extra = card.ability.extra or {}
        card.ability.extra.mult_normal = card.ability.extra.mult_normal or 20
        card.ability.extra.mult_rightmost = card.ability.extra.mult_rightmost or 40
    end,

    check_for_unlock = function(self, args)
        unlock_card(self)
    end,
}

-- Buscaminas
SMODS.Atlas{
    key = 'buscaminas',
    path = 'minesweeper.png',
    px = 71,
    py = 95,
}

SMODS.Joker{
    key = 'buscaminas',
    loc_txt = {
        name = 'Buscaminas',
        text = {
            'Las cartas {C:attention}numeradas del 1 al 8{} tienen',
            'probabilidad de dar {C:mult}+N{} multi igual a su valor.',
            '{C:inactive}(As: 80% | 2: 70% | 3: 60% | 4: 50%)',
            '{C:inactive}(5: 40% | 6: 30% | 7: 20% | 8: 10%)'
        }
    },
    atlas = 'buscaminas',
    rarity = 3,
    cost = 7,
    pools = {['Maniatromod'] = true},
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    pos = {x = 0, y = 0},
    config = {
        extra = {
            probabilities = {
                [14] = 0.80,  
                [2] = 0.70,
                [3] = 0.60,
                [4] = 0.50,
                [5] = 0.40,
                [6] = 0.30,
                [7] = 0.20,
                [8] = 0.10
            }
        }
    },

    loc_vars = function(self, info_queue, center)
        info_queue[#info_queue+1] = {key = 'mania_credit_idea', set = 'Other', vars = { "AppleMania" }}
        return { vars = {} }
    end,

    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and context.other_card then
            local card_id = context.other_card:get_id()
            
            if card_id == 14 or (card_id >= 2 and card_id <= 8) then
                local probability = card.ability.extra.probabilities[card_id]
                local mult_value = card_id == 14 and 1 or card_id
                
                if math.random() < probability then
                    return {
                        mult = mult_value,
                    }
                else
                    return {
                        message = "Miss!",
                        colour = G.C.UI.TEXT_INACTIVE
                    }
                end
            end
        end
    end,

    set_ability = function(self, card, initial, delay_sprites)
        card.ability.extra = card.ability.extra or {}
        card.ability.extra.probabilities = card.ability.extra.probabilities or {
            [14] = 0.80,  
            [2] = 0.70,
            [3] = 0.60,
            [4] = 0.50,
            [5] = 0.40,
            [6] = 0.30,
            [7] = 0.20,
            [8] = 0.10
        }
    end,

    check_for_unlock = function(self, args)
        unlock_card(self)
    end,
}

-- Kloun...?
SMODS.Atlas{
    key = 'kloun',
    path = 'kloun.png', 
    px = 71,
    py = 95,
}

SMODS.Joker{
    key = 'kloun',
    loc_txt = {
        name = 'Kloun...?',
        text = {
            'Gana {C:money}+4${} si la mano jugada',
            'tiene {C:attention}2{} palos distintos o más.'
        }
    },
    atlas = 'kloun',
    rarity = 1,
    cost = 5,
    pools = {['Maniatromod'] = true},
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    pos = {x = 0, y = 0},
    config = { extra = { dollars = 4, min_suits = 2 } },

    loc_vars = function(self, info_queue, center)
        info_queue[#info_queue+1] = {key = 'mania_credit_idea', set = 'Other', vars = { "Dogg-fly" }}
        return { vars = { center.ability.extra.dollars, center.ability.extra.min_suits } }
    end,

    calculate = function(self, card, context)
        if context.joker_main and context.full_hand then
            local suits = {}
            for _, c in ipairs(context.full_hand) do
                suits[c.base.suit] = true
            end
            
            local count = 0
            for _ in pairs(suits) do 
                count = count + 1 
            end

            if count >= card.ability.extra.min_suits then
                return {
                    dollars = card.ability.extra.dollars,
                }
            end
        end
    end
}

-- Jester...?
SMODS.Atlas{
    key = 'jester',
    path = 'jester.png',
    px = 71,
    py = 95,
}

SMODS.Joker{
    key = 'jester',
    loc_txt = {
        name = 'Jester...?',
        text = {
            '{C:chips}+#1#{} fichas y {C:mult}+#2#{} multi.',
            'Gana {C:chips}+#3#{} fichas y {C:mult}+#4#{} multi',
            'por cada {C:attention}Jota{} que anote.',
        }
    },
    atlas = 'jester',
    rarity = 3,
    cost = 8,
    pools = {['Maniatromod'] = true},
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    pos = {x = 0, y = 0},
    config = {
        extra = {
            base_chips = 35,
            base_mult = 2,
            jack_chips = 10,
            jack_mult = 4
        }
    },

    loc_vars = function(self, info_queue, center)
        info_queue[#info_queue+1] = {key = 'mania_credit_idea', set = 'Other', vars = { "AbelSketch" }}
        return {
            vars = {
                center.ability.extra.base_chips,
                center.ability.extra.base_mult,
                center.ability.extra.jack_chips,
                center.ability.extra.jack_mult
            }
        }
    end,

    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and context.other_card then
            if context.other_card:get_id() == 11 then
                card.ability.extra.base_chips = card.ability.extra.base_chips + card.ability.extra.jack_chips
                card.ability.extra.base_mult = card.ability.extra.base_mult + card.ability.extra.jack_mult
                return {
                    message = "Jack!",
                    colour = G.C.CHIPS
                }
            end
        end

        if context.joker_main then
            return {
                chips = card.ability.extra.base_chips,
                mult = card.ability.extra.base_mult,
            }
        end
    end
}

-- Magician...?
SMODS.Atlas{
    key = 'magician',
    path = 'magician.png',
    px = 71,
    py = 95,
}

SMODS.Joker{
    key = 'magician',
    loc_txt = {
        name = 'Magician...?',
        text = {
            'Reduce el precio de la tienda',
            'entre un {C:attention}5%{} y {C:attention}20%{}',
            '{C:inactive}(Actual: {C:red}-#1#%{} desc.){}'
        }
    },
    atlas = 'magician',
    rarity = 3,
    cost = 8,
    pools = {['Maniatromod'] = true},
    unlocked = true,
    discovered = true,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    pos = {x = 0, y = 0},
    config = { extra = { discount = 0 } },

    loc_vars = function(self, info_queue, center)
        info_queue[#info_queue+1] = {key = 'mania_credit_idea', set = 'Other', vars = { "InkystA" }}
        return { vars = { center.ability.extra.discount } }
    end,

    add_to_deck = function(self, card, from_debuff)
        local new_discount = math.random(5, 20)
        card.ability.extra.discount = new_discount
        G.GAME.discount_percent = (G.GAME.discount_percent or 0) + new_discount

        G.E_MANAGER:add_event(Event({
            func = function()
                for k, v in pairs(G.I.CARD) do
                    if v.set_cost then v:set_cost() end
                end
                return true
            end
        }))
    end,

    remove_from_deck = function(self, card, from_debuff)
        G.GAME.discount_percent = (G.GAME.discount_percent or 0) - card.ability.extra.discount
        card.ability.extra.discount = 0

        G.E_MANAGER:add_event(Event({
            func = function()
                for k, v in pairs(G.I.CARD) do
                    if v.set_cost then v:set_cost() end
                end
                return true
            end
        }))
    end,

    calculate = function(self, card, context)
        if context.setting_blind then
            local old_discount = card.ability.extra.discount
            local new_discount = math.random(5, 20)
            card.ability.extra.discount = new_discount
            G.GAME.discount_percent = (G.GAME.discount_percent or 0) - old_discount + new_discount

            G.E_MANAGER:add_event(Event({
                func = function()
                    for k, v in pairs(G.I.CARD) do
                        if v.set_cost then v:set_cost() end
                    end
                    card_eval_status_text(card, 'extra', nil, nil, nil, {
                        message = "-" .. new_discount .. "%!",
                        colour = G.C.MONEY
                    })
                    return true
                end
            }))
        end
    end,
}

-- Spammer
SMODS.Atlas{
    key = 'spammer',
    path = 'message.png',
    px = 71,
    py = 95,
}

SMODS.Joker{
    key = 'spammer',
    loc_txt = {
        name = 'Spammer',
        text = {
            '{C:mult}+#1#{} multi.',
            'Al vencer una {C:attention}ciega jefe{},',
            'crea un joker {C:dark_edition}negativo{} {C:attention}raro{} al azar'
        }
    },
    atlas = 'spammer',
    rarity = 3,
    cost = 8,
    pools = {['Maniatromod'] = true},
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    pos = {x = 0, y = 0},
    config = {
        extra = {
            mult = 4,
            processed_end = false
        }
    },

    loc_vars = function(self, info_queue, center)
        info_queue[#info_queue+1] = {key = 'mania_credit_idea', set = 'Other', vars = { "SrJesusss" }}
        return { vars = { center.ability.extra.mult } }
    end,

    calculate = function(self, card, context)
        if context.joker_main then
            return {
                mult_mod = card.ability.extra.mult,
                message = '+' .. card.ability.extra.mult,
                colour = G.C.MULT
            }
        end

        if context.end_of_round and not context.blueprint and not card.ability.extra.processed_end then
            card.ability.extra.processed_end = true

            if G.GAME.blind and G.GAME.blind.boss then
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.5,
                    func = function()
                        if #G.jokers.cards < G.jokers.config.card_limit then
                            local new_joker = create_card('Joker', G.jokers, nil, 3, nil, nil, nil, 'spammer')
                            new_joker:set_edition({negative = true}, true)
                            new_joker:add_to_deck()
                            G.jokers:emplace(new_joker)
                            new_joker:start_materialize()
                            card_eval_status_text(card, 'extra', nil, nil, nil, {
                                message = 'HAHAHAHAH!',
                                colour = G.C.DARK_EDITION
                            })
                        end
                        return true
                    end
                }))
            end
        end

        if context.setting_blind and not context.blueprint then
            card.ability.extra.processed_end = false
        end
    end,

    set_ability = function(self, card, initial, delay_sprites)
        card.ability.extra = card.ability.extra or {}
        card.ability.extra.processed_end = card.ability.extra.processed_end or false
    end,

    load = function(self, card, card_table)
        card.ability.extra = card.ability.extra or {}
        card.ability.extra.processed_end = card_table.ability.extra and card_table.ability.extra.processed_end or false
    end,

    check_for_unlock = function(self, args)
        unlock_card(self)
    end,
}

-- Collar de luchador
SMODS.Atlas{
    key = 'wrestler_collar',
    path = 'luchador.png',
    px = 71,
    py = 95,
}

SMODS.Joker{
    key = 'wrestler_collar',
    loc_txt = {
        name = 'Collar de luchador',
        text = {
            'Si es la {C:attention}última mano{} de la ronda,',
            'todas las cartas jugadas dan',
            '{X:mult,C:white}X#1#{} multi'
        }
    },
    atlas = 'wrestler_collar',
    rarity = 2,
    cost = 6,
    pools = {['Maniatromod'] = true},
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    pos = {x=0, y=0},
    config = {extra = {x_mult = 1.5}},

    loc_vars = function(self, info_queue, center)
        info_queue[#info_queue+1] = {key = 'mania_credit_idea', set = 'Other', vars = { "AppleMania" }}
        return { vars = {center.ability.extra.x_mult} }
    end,

    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and context.other_card then
            if G.GAME.current_round.hands_left == 0 then
                return {
                    x_mult = card.ability.extra.x_mult,
                    colour = G.C.RED,
                    card = card
                }
            end
        end
    end
}

-- Tanque
SMODS.Atlas{
    key = 'tanque',
    path = 'tanque.png',
    px = 71,
    py = 95,
}

SMODS.Joker{
    key = "tanque",
    config = {
        extra = {
            xmult = 2.5
        }
    },
    loc_txt = {
        ['name'] = 'Tank',
        ['text'] = {
            [1] = 'While you hold a {C:attention}stone card{} in hand,',
            [2] = '{X:mult,C:white}X#1#{} mult.'
        }
    },
    pos = {
        x = 0,
        y = 0
    },
    display_size = {
        w = 71 * 1,
        h = 95 * 1
    },
    cost = 8,
    rarity = 3,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = false,
    unlocked = true,
    discovered = true,
    atlas = 'tanque',
    pools = { ['Maniatromod'] = true },

    loc_vars = function(self, info_queue, center)
        return { vars = { center.ability.extra.xmult } }
    end,

    calculate = function(self, card, context)
        if context.joker_main then
            for _, hand_card in ipairs(G.hand.cards) do
                if SMODS.get_enhancements(hand_card)["m_stone"] == true then
                    return {
                        x_mult = card.ability.extra.xmult,
                        message = 'X' .. card.ability.extra.xmult,
                        colour = G.C.GREY
                    }
                end
            end
        end
    end
}

-- Cazador
SMODS.Atlas{
    key = 'cazador',
    path = 'cazador.png',
    px = 71,
    py = 95,
}

SMODS.Joker{
    key = 'cazador',
    loc_txt = {
        name = 'Cazador',
        text = {
            'Si juegas una mano con',
            '{C:attention}una sola carta{},',
            '{C:green}1 de 5{} de probabilidad de',
            'dar {X:mult,C:white}X5!{} multi'
        }
    },
    atlas = 'cazador',
    rarity = 3,
    cost = 8,
    pools = {['Maniatromod'] = true},
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    pos = {x = 0, y = 0},
    config = {
        extra = {
            odds = 5,
            xmult = 5
        }
    },

    loc_vars = function(self, info_queue, center)
        info_queue[#info_queue+1] = {key = 'mania_credit_idea', set = 'Other', vars = { "AppleMania" }}
        return { vars = { center.ability.extra.odds } }
    end,

    calculate = function(self, card, context)
        if context.joker_main then
            if #context.full_hand == 1 then
                if pseudorandom('cazador') < G.GAME.probabilities.normal / card.ability.extra.odds then
                    local function factorial(n)
                        if n <= 1 then return 1 end
                        return n * factorial(n - 1)
                    end
                    local result = factorial(card.ability.extra.xmult)
                    return {
                        Xmult_mod = result,
                        message = 'X5!',
                        colour = G.C.GREEN
                    }
                else
                    return {
                        message = 'Sin suerte...',
                        colour = G.C.UI.TEXT_INACTIVE
                    }
                end
            end
        end
    end,

    check_for_unlock = function(self, args)
        unlock_card(self)
    end,
}

-- Mago
SMODS.Atlas{
    key = 'mago',
    path = 'mago.png',
    px = 71,
    py = 95,
}

SMODS.Joker{
    key = 'mago',
    loc_txt = {
        name = 'Mago',
        text = {
            'Si acabas la ronda jugando',
            'solo {C:attention}una mano{}, obtienes',
            'una carta {C:spectral}espectral{} al azar'
        }
    },
    atlas = 'mago',
    rarity = 2,
    cost = 6,
    pools = {['Maniatromod'] = true},
    unlocked = true,
    discovered = true,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    pos = {x = 0, y = 0},
    config = {
        extra = {
            hands_this_round = 0,
            processed_end = false
        }
    },

    loc_vars = function(self, info_queue, center)
        info_queue[#info_queue+1] = {key = 'mania_credit_idea', set = 'Other', vars = { "AppleMania" }}
        return { vars = {} }
    end,

    calculate = function(self, card, context)
        if context.before and not context.blueprint then
            card.ability.extra.hands_this_round = card.ability.extra.hands_this_round + 1
        end

        if context.end_of_round and not context.blueprint and not card.ability.extra.processed_end then
            card.ability.extra.processed_end = true

            if card.ability.extra.hands_this_round == 1 then
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.5,
                    func = function()
                        if #G.consumeables.cards < G.consumeables.config.card_limit then
                            local new_card = create_card('Spectral', G.consumeables, nil, nil, nil, nil, nil, 'mago')
                            new_card:add_to_deck()
                            G.consumeables:emplace(new_card)
                            card_eval_status_text(card, 'extra', nil, nil, nil, {
                                message = 'Spectral!',
                                colour = G.C.BLUE
                            })
                        end
                        return true
                    end
                }))
            end

            card.ability.extra.hands_this_round = 0
        end

        if context.setting_blind and not context.blueprint then
            card.ability.extra.hands_this_round = 0
            card.ability.extra.processed_end = false
        end
    end,

    set_ability = function(self, card, initial, delay_sprites)
        card.ability.extra = card.ability.extra or {}
        card.ability.extra.hands_this_round = card.ability.extra.hands_this_round or 0
        card.ability.extra.processed_end = card.ability.extra.processed_end or false
    end,

    load = function(self, card, card_table)
        card.ability.extra = card.ability.extra or {}
        card.ability.extra.hands_this_round = card_table.ability.extra and card_table.ability.extra.hands_this_round or 0
        card.ability.extra.processed_end = card_table.ability.extra and card_table.ability.extra.processed_end or false
    end,

    check_for_unlock = function(self, args)
        unlock_card(self)
    end,
}

-- Clerigo
SMODS.Atlas{
    key = 'clerigo',
    path = 'clerigo.png',
    px = 71,
    py = 95,
}

SMODS.Joker{
    key = 'clerigo',
    loc_txt = {
        name = 'Clérigo',
        text = {
            'En la {C:attention}primera mano{},',
            'deshabilita la {C:attention}Ciega Jefe{}'
        }
    },
    atlas = 'clerigo',
    rarity = 2,
    cost = 6,
    pools = {['Maniatromod'] = true},
    unlocked = true,
    discovered = true,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    pos = {x = 0, y = 0},
    config = {
        extra = {
            first_hand_done = false
        }
    },

    loc_vars = function(self, info_queue, center)
        info_queue[#info_queue+1] = {key = 'mania_credit_idea', set = 'Other', vars = { "LukexsGame" }}
        return { vars = {} }
    end,

    calculate = function(self, card, context)
        if context.setting_blind and not context.blueprint then
            card.ability.extra.first_hand_done = false
            if G.GAME.blind and G.GAME.blind.boss then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        G.GAME.blind:disable()
                        play_sound('timpani')
                        return true
                    end
                }))
                card_eval_status_text(card, 'extra', nil, nil, nil, {
                    message = localize('ph_boss_disabled'),
                    colour = G.C.GREEN
                })
            end
        end

        if context.after and not context.blueprint and not card.ability.extra.first_hand_done then
            card.ability.extra.first_hand_done = true
            if G.GAME.blind and G.GAME.blind.boss and G.GAME.blind.disabled then
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.3,
                    func = function()
                        G.GAME.blind.disabled = false
                        for _, playing_card in ipairs(G.playing_cards) do
                            SMODS.recalc_debuff(playing_card)
                        end
                        for _, joker in ipairs(G.jokers.cards) do
                            SMODS.recalc_debuff(joker)
                        end

                        local key = G.GAME.blind.key
                        if key == 'bl_manacle' then
                            G.hand:change_size(-1)
                        elseif key == 'bl_needle' then
                            G.GAME.blind.hands_sub = G.GAME.round_resets.hands - 1
                            ease_hands_played(-G.GAME.blind.hands_sub)
                        elseif key == 'bl_water' then
                            G.GAME.blind.discards_sub = G.GAME.current_round.discards_left
                            ease_discard(-G.GAME.blind.discards_sub)
                        elseif key == 'bl_wall' then
                            G.GAME.blind.chips = G.GAME.blind.chips * 2
                            G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
                        elseif key == 'bl_final_vessel' then
                            G.GAME.blind.chips = G.GAME.blind.chips * 3
                            G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
                        elseif key == 'bl_final_acorn' then
                            for _, joker in ipairs(G.jokers.cards) do
                                if joker.facing == 'back' then
                                    joker:flip()
                                end
                            end
                        end

                        return true
                    end
                }))
            end
        end
    end,

    set_ability = function(self, card, initial, delay_sprites)
        card.ability.extra = card.ability.extra or {}
        card.ability.extra.first_hand_done = card.ability.extra.first_hand_done or false
    end,

    load = function(self, card, card_table)
        card.ability.extra = card.ability.extra or {}
        card.ability.extra.first_hand_done = card_table.ability.extra and card_table.ability.extra.first_hand_done or false
    end,

    check_for_unlock = function(self, args)
        unlock_card(self)
    end,
}

-- Ladrón
SMODS.Atlas{
    key = 'ladron',
    path = 'ladron.png',
    px = 71,
    py = 95,
}

SMODS.Joker{
    key = 'ladron',
    loc_txt = {
        name = 'Thief',
        text = {
            '{C:green}1 in 4{} chance that the next',
            'shop {C:attention}reroll{} gives you {C:money}${}',
            'equal to your rerolls this run.',
            '{C:inactive}Rerolls: {C:attention}#1#{}'
        }
    },
    atlas = 'ladron',
    rarity = 3,
    cost = 6,
    pools = {['Maniatromod'] = true},
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    pos = {x = 0, y = 0},
    config = { extra = { odds = 4, rerolls = 0 } },

    loc_vars = function(self, info_queue, center)
        info_queue[#info_queue+1] = {key = 'mania_credit_idea', set = 'Other', vars = { "LukexsGame" }}
        local new_numerator, new_denominator = SMODS.get_probability_vars(center, 1, center.ability.extra.odds, 'j_mania_ladron')
        return { vars = { center.ability.extra.rerolls, new_numerator, new_denominator } }
    end,

    calculate = function(self, card, context)
        if context.reroll_shop then
            card.ability.extra.rerolls = card.ability.extra.rerolls + 1

            if SMODS.pseudorandom_probability(card, 'ladron_reroll', 1, card.ability.extra.odds, 'j_mania_ladron', true) then
                SMODS.calculate_effect({
                    func = function()
                        local total = card.ability.extra.rerolls
                        ease_dollars(total)
                        card_eval_status_text(card, 'extra', nil, nil, nil, {
                            message = '+$' .. total,
                            colour = G.C.MONEY
                        })
                        return true
                    end
                }, card)
            end
        end
    end,

    set_ability = function(self, card, initial, delay_sprites)
        card.ability.extra = card.ability.extra or {}
        card.ability.extra.rerolls = card.ability.extra.rerolls or 0
    end,

    load = function(self, card, card_table)
        card.ability.extra = card.ability.extra or {}
        card.ability.extra.rerolls = card_table.ability.extra and card_table.ability.extra.rerolls or 0
    end,

    check_for_unlock = function(self, args)
        unlock_card(self)
    end,
}

-- Nicromante
SMODS.Atlas{
    key = 'nicromante',
    path = 'nicromante.png',
    px = 71,
    py = 95,
}

SMODS.Joker{
    key = 'nicromante',
    loc_txt = {
        name = 'Nicromante',
        text = {
            'Reduce el requerimiento de la',
            '{C:attention}ciega actual{} un {C:green}10%{}.',
            'Ese {C:green}10%{} se convierte en {C:chips}chips{}.',
            '{C:inactive}(Actual: {C:chips}+#1#{C:inactive} chips)'
        }
    },
    atlas = 'nicromante',
    rarity = 3,
    cost = 8,
    pools = {['Maniatromod'] = true},
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    pos = {x = 0, y = 0},
    config = {
        extra = {
            blind_size = 0.9,
            chips_bonus = 0
        }
    },

    loc_vars = function(self, info_queue, center)
        info_queue[#info_queue+1] = {key = 'mania_credit_idea', set = 'Other', vars = { "LukexsGame" }}
        return { vars = { center.ability.extra.chips_bonus } }
    end,

    calculate = function(self, card, context)
        if context.setting_blind then
            return {
                func = function()
                    if G.GAME.blind.in_blind then
                        local chips_removed = math.floor(G.GAME.blind.chips * 0.1)
                        card.ability.extra.chips_bonus = chips_removed

                        card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {
                            message = 'X0.9',
                            colour = G.C.GREEN
                        })
                        G.GAME.blind.chips = G.GAME.blind.chips - chips_removed
                        G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
                        G.HUD_blind:recalculate()
                        return true
                    end
                end
            }
        end

        if context.cardarea == G.jokers and context.joker_main then
            return {
                chips = card.ability.extra.chips_bonus or 0
            }
        end
    end,

    set_ability = function(self, card, initial, delay_sprites)
        card.ability.extra = card.ability.extra or {}
        card.ability.extra.blind_size = card.ability.extra.blind_size or 0.9
        card.ability.extra.chips_bonus = card.ability.extra.chips_bonus or 0
    end,

    load = function(self, card, card_table)
        card.ability.extra = card.ability.extra or {}
        card.ability.extra.blind_size = card_table.ability.extra and card_table.ability.extra.blind_size or 0.9
        card.ability.extra.chips_bonus = card_table.ability.extra and card_table.ability.extra.chips_bonus or 0
    end,

    check_for_unlock = function(self, args)
        unlock_card(self)
    end,
}

-- The Yamminator
SMODS.Atlas{
    key = 'theyamminator',
    path = 'yam.png',
    px = 71,
    py = 95,
}

SMODS.Joker{
    key = 'theyamminator',
    loc_txt = {
        name = 'The Yamminator',
        text = {
            'Cada carta o joker triggerado da {X:mult,C:white}X#1#{} mult',
            'y sube {X:mult,C:white}+0.05X{}.',
            'Se reinicia al acabar la mano.'
        }
    },
    atlas = 'theyamminator',
    rarity = 4,
    cost = 10,
    pools = {['Maniatromod'] = true},
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    pos = {x = 0, y = 0},
    config = { extra = { x_mult = 1.0 } },

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = {key = 'mania_credit_idea', set = 'Other', vars = { "DoggoDS" }}
        return { vars = { card.ability.extra.x_mult } }
    end,

    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and context.other_card then
            local current = card.ability.extra.x_mult
            card.ability.extra.x_mult = current + 0.05
            return {
                x_mult = current,
            }
        end

        if (context.post_trigger and not context.other_context.fixed_probability and not context.other_context.mod_probability and context.other_card ~= card) or context.forcetrigger then
            local current = card.ability.extra.x_mult
            card.ability.extra.x_mult = current + 0.05
            return {
                x_mult = current,
                card = context.other_context and context.other_context.blueprint_card or context.other_card or nil,
            }
        end

        if context.after and not context.blueprint then
            card.ability.extra.x_mult = 1.0
            return {
                message = 'Get Yamminated!',
                colour = G.C.RED
            }
        end
    end
}