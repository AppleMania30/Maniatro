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
        return { vars = {} }
    end,

    calculate = function(self, card, context)
        if context.joker_main and context.full_hand and #context.full_hand == 5 then
            return {
                message = 'Ñam...',
                mult_mod = 5,
                dollars = 3
            }
        end
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
    config = {},

    loc_vars = function(self, info_queue, center)
        return { vars = {} }
    end,

    calculate = function(self, card, context)
        -- Aplicar retriggeo en cadena a cartas de picas
        if context.repetition and context.cardarea == G.play and context.other_card then
            if context.other_card:is_suit('Spades') then
                local repetitions = 0
                local continue_rolling = true
                
                -- Bucle para intentar retriggeos consecutivos
                while continue_rolling do
                    if math.random() < 0.25 then -- 1/4 de probabilidad
                        repetitions = repetitions + 1
                        -- Continúa intentando en la misma carta
                    else
                        -- Falló la probabilidad, detener
                        continue_rolling = false
                    end
                end
                
                -- Si consiguió al menos un retriggeo
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
            'Si la mano usada tiene exactamente',
            '4 cartas en este orden: {C:attention}As, 2, 2, 2{}, gana {X:mult,C:white}X3{} multi.'
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
        return { vars = {} }
    end,

    calculate = function(self, card, context)
        if context.joker_main and context.full_hand and #context.full_hand == 4 then
            local ids = {}
            for i = 1, 4 do
                ids[i] = context.full_hand[i]:get_id()
            end
            if ids[1] == 14 and ids[2] == 2 and ids[3] == 2 and ids[4] == 2 then
                return {
                    message = 'Loss',
                    Xmult_mod = 3
                }
            end
        end
    end,

    check_for_unlock = function(self, args)
        unlock_card(self)
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
        return { vars = { string.format("%.1f", center.ability.extra.xmult) } }
    end,

    calculate = function(self, card, context)
        -- Al inicio de cada ronda (cuando comienza el blind)
        if context.setting_blind and not context.blueprint then
            local success = math.random() < 0.50
            
            if success then
                -- Acierta: suma multiplicador
                card.ability.extra.xmult = card.ability.extra.xmult + card.ability.extra.gain
                card_eval_status_text(card, 'extra', nil, nil, nil, {
                    message = '+' .. card.ability.extra.gain .. 'x',
                    colour = G.C.RED
                })
                return {}
            else
                -- Falla: se autodestruye
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
                    message = 'Por gilipollas.',
                    colour = G.C.RED
                }
            end
        end

        -- Aplicar el multiplicador durante el juego
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
        return { vars = { center.ability.extra.current_mult } }
    end,

    calculate = function(self, card, context)
        -- Al inicio de una nueva ronda, resetear contador de intentos
        if context.setting_blind and not context.blueprint then
            card.ability.extra.round_attempts = 0
            card.ability.extra.round_won = false
        end

        -- Contar cada intento de mano
        if context.joker_main and not card.ability.extra.round_won then
            card.ability.extra.round_attempts = card.ability.extra.round_attempts + 1
        end

        -- Al ganar la ronda
        if context.end_of_round and not context.blueprint and not card.ability.extra.round_won then
            card.ability.extra.round_won = true
            
            if card.ability.extra.round_attempts == 1 then
                -- Ganó en el primer intento - honor alto
                card.ability.extra.current_mult = card.ability.extra.current_mult + card.ability.extra.mult_gain
                
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.3,
                    func = function()
                        card_eval_status_text(card, 'extra', nil, nil, nil, {
                            message = "¡Honor Alto!" .. card.ability.extra.mult_gain .. " Multi",
                            colour = G.C.GREEN
                        })
                        return true
                    end
                }))
                
            else
                -- Usó más de un intento - honor bajo
                local prev_mult = card.ability.extra.current_mult
                card.ability.extra.current_mult = math.max(0, prev_mult - card.ability.extra.mult_loss)
                
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.3,
                    func = function()
                        card_eval_status_text(card, 'extra', nil, nil, nil, {
                            message = "Honor Bajo..." .. card.ability.extra.mult_loss .. " Multi",
                            colour = G.C.RED
                        })
                        return true
                    end
                }))
            end
        end

        -- Aplicar multiplicador durante la jugada
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
        return {
            vars = {
                center.ability.extra.mult_per_common,
                center.ability.extra.total_mult
            }
        }
    end,
    calculate = function(self, card, context)
        -- Aplicar el multiplicador acumulado durante la jugada
        if context.joker_main and card.ability.extra.total_mult > 0 then
            return {
                mult_mod = card.ability.extra.total_mult,
                message = localize{type = 'variable', key = 'a_mult', vars = {card.ability.extra.total_mult}},
                colour = G.C.RED
            }
        end

        -- Detectar cuando se compra un nuevo Joker
        if context.buying_card and context.card and context.card.ability and context.card.ability.set == 'Joker' then
            card.ability.extra.mult_per_common = card.ability.extra.mult_per_common or 15

            if context.card.config and context.card.config.center and context.card.config.center.rarity == 1 then
                card.ability.extra.total_mult = card.ability.extra.total_mult + card.ability.extra.mult_per_common

                return {
                    message = "¡Joker común adquirido! +" .. card.ability.extra.mult_per_common .. " Mult",
                    colour = G.C.RED,
                    card = card
                }
            end
        end
    end,
    update = function(self, card)
        -- Recontar los Jokers comunes actuales (excepto este mismo)
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
        return { vars = {} }
    end,

    calculate = function(self, card, context)
        -- Se activa cada vez que juegas una mano (context.joker_main)
        if context.joker_main then
            local gain = math.random() < 0.5
            local value = card.ability.extra.chips
            return {
                chip_mod = gain and value or -value,
                message = gain and ("+50 fichas"):format(value) or ("-50 fichas"):format(value),
                colour = gain and G.C.BLUE or G.C.RED
            }
        end
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
    pools = { ['Maniatromod'] = true },
    unlocked = true,
    discovered = true,
    blueprint_compat = false,
    eternal_compat = false,
    perishable_compat = false,
    pos = {x = 0, y = 0},
    config = {
        extra = {
            xmult = 1.0,
            last_max_deck_size = 52 -- Seguir el denominador (tamaño máximo)
        }
    },

    loc_vars = function(self, info_queue, center)
        local current_mult = center.ability.extra.xmult or 1.0
        return { vars = { string.format("%.1f", current_mult) } }
    end,

    calculate = function(self, card, context)
        -- Aplicar multiplicador durante la jugada
        if context.joker_main then
            return {
                x_mult = card.ability.extra.xmult,
                message = 'x' .. string.format("%.1f", card.ability.extra.xmult),
                colour = G.C.RED
            }
        end
    end,

    update = function(self, card, dt)
        -- Verificar cambios en el tamaño máximo de la baraja
        if G.deck and G.GAME and G.GAME.current_round then
            -- Obtener el tamaño máximo actual de la baraja (el denominador)
            local current_max_deck_size = G.deck.config.card_limit or 52
            local last_max_size = card.ability.extra.last_max_deck_size
            
            if current_max_deck_size ~= last_max_size then
                local difference = current_max_deck_size - last_max_size
                local xmult_change = difference * 0.2
                
                card.ability.extra.xmult = math.max(0.1, card.ability.extra.xmult + xmult_change)
                card.ability.extra.last_max_deck_size = current_max_deck_size
                
                if difference > 0 then
                    card_eval_status_text(card, 'extra', nil, nil, nil, {
                        message = '+X' .. string.format("%.1f", math.abs(xmult_change)) .. ' (+'.. difference ..' cartas max)',
                        colour = G.C.GREEN
                    })
                elseif difference < 0 then
                    card_eval_status_text(card, 'extra', nil, nil, nil, {
                        message = '-X' .. string.format("%.1f", math.abs(xmult_change)) .. ' ('.. difference ..' cartas max)',
                        colour = G.C.RED
                    })
                end
            end
        end
    end,

    set_ability = function(self, card, initial, delay_sprites)
        card.ability.extra = card.ability.extra or {}
        card.ability.extra.xmult = card.ability.extra.xmult or 1.0
        
        -- Establecer el tamaño máximo inicial de la baraja
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
        return { vars = { string.format("%.1f", current_mult) } }
    end,

    calculate = function(self, card, context)
        if context.joker_main and context.poker_hands and next(context.poker_hands) then
            -- Obtener el tipo de mano actual (el primer tipo en poker_hands)
            local current_hand_type = nil
            for hand_type, _ in pairs(context.poker_hands) do
                current_hand_type = hand_type
                break
            end
            
            if current_hand_type then
                -- Verificar si es la misma mano que la anterior
                if card.ability.extra.last_hand_type == current_hand_type then
                    -- Incrementar contador de repeticiones consecutivas
                    card.ability.extra.consecutive_count = card.ability.extra.consecutive_count + 1
                    
                    -- Calcular multiplicador: base + (incremento * repeticiones adicionales)
                    local total_mult = card.ability.extra.base_mult + 
                                      (card.ability.extra.increment * (card.ability.extra.consecutive_count - 1))
                    
                    -- Guardar para la próxima comparación
                    card.ability.extra.last_hand_type = current_hand_type
                    
                    return {
                        message = string.format("x%.1f (%s x%d)", total_mult, current_hand_type, card.ability.extra.consecutive_count + 1),
                        Xmult_mod = total_mult,
                        colour = G.C.RED
                    }
                else
                    -- Resetear contador si la mano es diferente
                    card.ability.extra.consecutive_count = 0
                    card.ability.extra.last_hand_type = current_hand_type
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
        name = '{C:red}Amongla{}',
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
        return { vars = { center.ability.extra.xmult } }
    end,

    calculate = function(self, card, context)
        if context.joker_main then
            -- Verificar el cierre del juego (1/8 de probabilidad)
            if math.random(1, 8) == 1 then
                -- Programar el cierre para después de mostrar el efecto
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.5,
                    func = function()
                        -- Mostrar mensaje de advertencia
                        card_eval_status_text(card, 'extra', nil, nil, nil, {
                            message = 'AMONGLA',
                            colour = G.C.RED
                        })
                        
                        -- Cerrar el juego después de un breve delay
                        G.E_MANAGER:add_event(Event({
                            trigger = 'after',
                            delay = 1.0,
                            func = function()
                                -- Intentar cerrar el juego de manera limpia
                                love.event.quit()
                                return true
                            end
                        }))
                        return true
                    end
                }))
            end
            
            -- Aplicar el multiplicador x3
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
        name = '{B:1,V:2}FATAL{}',
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
    pos = {x = 0, y = 0},
    config = {},

    loc_vars = function(self, info_queue, center)
        return { 
            vars = {
                colours = { 
                    {1, 0, 0, 1}, --#FF0000 (Rojo)
                    {0, 0, 0, 1}  --#000000 (Negro)
                }
            }
        }
    end,

    calculate = function(self, card, context)
        if context.joker_main then
            -- Obtener el multiplicador actual
            local current_mult = mult or 1
            
            -- Si el mult es mayor que 1, aplicar exponencial
            if current_mult > 1 then
                local exponential = current_mult * (current_mult - 1)
                return {
                    mult_mod = exponential,
                    message = "...",
                    colour = G.C.MULT
                }
            end
        end
    end,

    check_for_unlock = function(self, args)
        unlock_card(self)
    end,
}

--Proto
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
            'Permite descartar {C:attention}cualquier cantidad{}',
            'de cartas de tu mano.'
        }
    },
    atlas = 'proto',
    rarity = 4,
    cost = 15,
    pools = {['Maniatromod'] = true},
    unlocked = true,
    discovered = true,
    blueprint_compat = false,
    eternal_compat = false,
    perishable_compat = false,
    pos = {x = 0, y = 0},
    config = {},
    loc_vars = function(self, info_queue, center)
        return { vars = {} }
    end,
    add_to_deck = function(self, card, from_debuff)
        -- Marcar que Proto está activo
        G.GAME.proto_active = true
        -- Override del límite de selección para descarte
        if G.hand then
            G.hand.config.highlighted_limit = math.huge
        end
    end,
    remove_from_deck = function(self, card, from_debuff)
        -- Desmarcar Proto
        G.GAME.proto_active = false
        -- Restaurar límite normal
        if G.hand then
            G.hand.config.highlighted_limit = 5
            -- Deseleccionar cartas extras
            G.hand:unhighlight_all()
        end
    end,
    calculate = function(self, card, context)
        -- Asegurar que el límite se mantenga alto mientras Proto esté activo
        if G.GAME.proto_active and G.hand and G.hand.config.highlighted_limit ~= math.huge then
            G.hand.config.highlighted_limit = math.huge
        end
    end,
    update = function(self, card, dt)
        -- Mantener el límite alto constantemente
        if G.GAME.proto_active and G.hand and G.hand.config.highlighted_limit ~= math.huge then
            G.hand.config.highlighted_limit = math.huge
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
        return { 
            vars = { 
                center.ability.extra.mult_per_consumed,
                center.ability.extra.total_mult 
            } 
        }
    end,

    calculate = function(self, card, context)
        -- Aplicar multiplicador durante la jugada
        if context.joker_main and card.ability.extra.total_mult > 0 then
            return {
                mult_mod = card.ability.extra.total_mult,
                message = localize{type = 'variable', key = 'a_mult', vars = {card.ability.extra.total_mult}},
                colour = G.C.RED
            }
        end

        -- Detectar cuando se consume una carta
        if context.using_consumeable and context.consumeable then
            card.ability.extra.total_mult = card.ability.extra.total_mult + card.ability.extra.mult_per_consumed
            
            return {
                message = "¡Carta consumida! +" .. card.ability.extra.mult_per_consumed .. " Mult",
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

-- Pisu
SMODS.Atlas{
    key = 'pisu',
    path = 'pisu.png',
    px = 71,
    py = 95,
}

SMODS.Joker{
    key = 'pisu',
    loc_txt = {
        name = 'Pisu',
        text = {
            'Por cada {C:dark_edition}gato{} que tengas',
            'comprado, {X:chips,C:white}+2X{} chips.',
            'Actual: {X:chips,C:white}X#1#{}'
        }
    },
    atlas = 'pisu',
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
        return { vars = { center.ability.extra.x_chips } }
    end,
    calculate = function(self, card, context)
        -- Contar gatos al inicio de cada ronda
        if context.setting_blind and not context.blueprint then
            card.ability.extra.cat_count = 0
            local cat_jokers = {'j_mania_rufino', 'j_mania_sappho', 'j_mania_evil_pisu', 'j_mania_mia'}
            
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
            
            -- Calcular el multiplicador (X2 por cada gato, mínimo X1)
            card.ability.extra.x_chips = math.max(1, 2 * card.ability.extra.cat_count)
            
            if card.ability.extra.cat_count > 0 then
                return {
                    message = 'Gatos: '..card.ability.extra.cat_count,
                    colour = G.C.PURPLE
                }
            end
        end
        
        -- Aplicar multiplicador de chips durante la jugada
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

-- EVIL Pisu
SMODS.Atlas{
    key = 'evil_pisu',
    path = 'evilpisu.png',
    px = 71,
    py = 95,
}
SMODS.Joker{
    key = 'evil_pisu',
    loc_txt = {
        name = '{C:red}EVIL{}Pisu',
        text = {
            '{X:mult,C:white}X#1#{} multi',
            'Aumenta {X:mult,C:white}+0.01X{} por',
            'cada segundo transcurrido.',
        }
    },
    atlas = 'evil_pisu',
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
        return { vars = { center.ability.extra.xmult } }
    end,

    calculate = function(self, card, context)
        if context.joker_main and context.full_hand then
            local has_face_card = false
            
            -- Verificar si hay figuras en la mano
            for _, played_card in ipairs(context.full_hand) do
                local rank = played_card:get_id()
                if rank == 11 or rank == 12 or rank == 13 then -- J, Q, K
                    has_face_card = true
                    break
                end
            end
            
            -- Si no hay figuras, aplicar multiplicador
            if not has_face_card then
                return {
                    message = "X" .. card.ability.extra.xmult .. " (Sin figuras)",
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
        return { vars = { center.ability.extra.chips } }
    end,

    calculate = function(self, card, context)
        -- Al inicio de una nueva ciega, resetear las banderas
        if context.setting_blind and not context.blueprint then
            card.ability.extra.discarded_this_round = false
            card.ability.extra.processed_round_end = false
            return
        end

        -- Detectar cuando se hace un descarte
        if context.discard and not context.blueprint then
            if not card.ability.extra.discarded_this_round then
                card.ability.extra.discarded_this_round = true
                
                -- Si tenía fichas acumuladas, resetearlas inmediatamente
                if card.ability.extra.chips > 0 then
                    card.ability.extra.chips = 0
                    
                    -- Mostrar mensaje de pérdida de progreso
                    G.E_MANAGER:add_event(Event({
                        trigger = 'after',
                        delay = 0.1,
                        func = function()
                            card_eval_status_text(card, 'extra', nil, nil, nil, {
                                message = "¡Progreso perdido!",
                                colour = G.C.RED
                            })
                            return true
                        end
                    }))
                end
            end
        end

        -- Al final de la ronda (cuando se gana)
        if context.end_of_round and not context.blueprint and not card.ability.extra.processed_round_end then
            card.ability.extra.processed_round_end = true
            
            -- Solo ganar fichas si NO se descartó nada en toda la ronda
            if not card.ability.extra.discarded_this_round then
                card.ability.extra.chips = card.ability.extra.chips + 25
                
                -- Mensaje de ganancia
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.3,
                    func = function()
                        card_eval_status_text(card, 'extra', nil, nil, nil, {
                            message = "+25 Fichas permanentes",
                            colour = G.C.CHIPS
                        })
                        return true
                    end
                }))
                
                return {
                    message = "¡Sin descartes!",
                    colour = G.C.GREEN
                }
            end
        end

        -- Aplicar bonus de fichas durante la jugada de mano
        if context.joker_main and card.ability.extra.chips > 0 then
            return {
                chip_mod = card.ability.extra.chips,
                message = "+" .. card.ability.extra.chips .. " Fichas (Mia)",
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
        -- Resetear flags al cargar para evitar problemas
        card.ability.extra.discarded_this_round = false
        card.ability.extra.processed_round_end = false
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
    unlocked = true,
    discovered = true,
    blueprint_compat = false,
    eternal_compat = true,
    config = { extra = { chips = 0, count = 0 } },

    loc_vars = function(self, info_queue, center)
        return { vars = { center.ability.extra.chips, 10 - center.ability.extra.count } }
    end,

    calculate = function(self, card, context)
        -- Contar descartes
        if context.discard then
            card.ability.extra.count = card.ability.extra.count + 1
            
            -- Cada 10 descartes, añadir fichas permanentes
            if card.ability.extra.count >= 10 then
                card.ability.extra.chips = card.ability.extra.chips + 25
                card.ability.extra.count = 0
                
                -- Efecto visual
                card_eval_status_text(card, 'extra', nil, nil, nil, {
                    message = "+25 fichas!",
                    colour = G.C.CHIPS,
                    chip_mod = 25
                })
            end
            
            -- Actualizar contador visual
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.1,
                func = function()
                    card_eval_status_text(card, 'extra', nil, nil, nil, {
                        message = "Descarte "..card.ability.extra.count.."/10",
                        colour = G.C.UI.TEXT_LIGHT
                    })
                    return true
                end
            }))
        end

        -- Aplicar bonificación de fichas en cada mano
        if context.joker_main then
            return {
                chip_mod = card.ability.extra.chips,
                message = localize{type = 'variable', key = 'a_chips', vars = {card.ability.extra.chips}},
                colour = G.C.CHIPS
            }
        end
    end,

    -- Resetear al venderse
    remove_from_deck = function(self, card)
        card.ability.extra.chips = 0
        card.ability.extra.count = 0
    end
}

-- Joker Tributario
SMODS.Atlas{
    key = 'tributario',
    path = 'tributario.png',
    px = 71,
    py = 95,
}

SMODS.Joker{
    key = 'tributario',
    loc_txt = {
        name = 'Comodín tributario',
        text = {
            'Si tienes menos de {C:money}20${}, este joker',
            'te dará {C:money}+3${} por cada mano jugada.',
            'Si tienes más, no surgirá efecto.'
        }
    },
    atlas = 'tributario',
    rarity = 2,
    cost = 6,
    pools = {['Maniatromod'] = true},
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = false,
    perishable_compat = false,
    pos = {x = 0, y = 0}, 
    config = { extra = { money_threshold = 20, money_gain = 3 } },

    loc_vars = function(self, info_queue, center)
        return { vars = {} }
    end,

    calculate = function(self, card, context)
        if context.joker_main then
            -- Verificar si el jugador tiene menos de $20
            local current_money = G.GAME.dollars or 0
            
            if current_money < card.ability.extra.money_threshold then
                return {
                    message = '+$' .. card.ability.extra.money_gain,
                    dollars = card.ability.extra.money_gain,
                    colour = G.C.MONEY
                }
            else
                -- Opcional: mostrar mensaje cuando no hay efecto
                return {
                    message = 'Sin efecto ($' .. current_money .. ')',
                    colour = G.C.UI.TEXT_INACTIVE
                }
            end
        end
    end,

    set_ability = function(self, card, initial, delay_sprites)
        card.ability.extra = card.ability.extra or {}
        card.ability.extra.money_threshold = card.ability.extra.money_threshold or 20
        card.ability.extra.money_gain = card.ability.extra.money_gain or 3
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
        return { vars = { center.ability.extra.discount } }
    end,

    add_to_deck = function(self, card, from_debuff)
        -- Añadir el descuento al sistema global
        G.GAME.discount_percent = (G.GAME.discount_percent or 0) + card.ability.extra.discount
        
        -- Actualizar los costos de todas las cartas existentes
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
        -- Remover el descuento del sistema global
        G.GAME.discount_percent = (G.GAME.discount_percent or 0) - card.ability.extra.discount
        
        -- Actualizar los costos de todas las cartas existentes
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
            
            -- Solo activar si la ronda cambió y el estado indica victoria
            if current_round > card.ability.extra.last_round then
                card.ability.extra.last_round = current_round
                card.ability.extra.xchips = card.ability.extra.xchips + 0.25
                
                -- Mostrar animación y mensaje
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
                    message = '¡Ronda ganada!',
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

-- Weezer
SMODS.Atlas{
    key = 'weezer',
    path = 'weezer.png',
    px = 71,
    py = 95,
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
        -- Calcular multiplicador individual basado en cantidad total de Weezers
        local weezer_count = 0
        if G and G.jokers and G.jokers.cards then
            for _, joker in ipairs(G.jokers.cards) do
                if joker.config and joker.config.center and joker.config.center.key == 'j_mania_weezer' then
                    weezer_count = weezer_count + 1
                end
            end
        end
        -- Cada Weezer individual da: 1 + (0.5 * (total_weezers - 1))
        local individual_mult = 1.0 + (center.ability.extra.mult_per_weezer * (weezer_count - 1))
        return { vars = { 
            string.format("%.1f", individual_mult),
            center.ability.extra.rounds_completed 
        } }
    end,

    calculate = function(self, card, context)
        -- Al inicio de una nueva ciega, resetear flag de procesamiento
        if context.setting_blind and not context.blueprint then
            card.ability.extra.processed_round_end = false
            return
        end

        -- Aplicar multiplicador durante la jugada basado en cantidad de Weezers
        if context.joker_main then
            local weezer_count = 0
            -- Contar todos los Weezers en el mazo
            for _, joker in ipairs(G.jokers.cards) do
                if joker.config and joker.config.center and joker.config.center.key == 'j_mania_weezer' then
                    weezer_count = weezer_count + 1
                end
            end
            
            if weezer_count > 0 then
                -- Cada Weezer individual da: 1 + (0.5 * (total_weezers - 1))
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

        -- Al final de la ronda (cuando se gana)
        if context.end_of_round and not context.blueprint and not card.ability.extra.processed_round_end then
            card.ability.extra.processed_round_end = true
            card.ability.extra.rounds_completed = card.ability.extra.rounds_completed + 1
            
            -- Verificar si es momento de duplicarse
            if card.ability.extra.rounds_completed >= card.ability.extra.rounds_needed then
                card.ability.extra.rounds_completed = 0  -- Resetear contador
                
                -- Crear una copia de este Weezer
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.5,
                    func = function()
                        -- Crear nuevo Weezer
                        local new_weezer = create_card('Joker', G.jokers, nil, nil, nil, nil, 'j_mania_weezer')
                        new_weezer:add_to_deck()
                        G.jokers:emplace(new_weezer)
                        
                        -- Copiar el progreso de rondas al nuevo Weezer
                        new_weezer.ability.extra.rounds_completed = 0
                        new_weezer.ability.extra.processed_round_end = false
                        
                        -- Mensaje de duplicación
                        card_eval_status_text(card, 'extra', nil, nil, nil, {
                            message = "¡Weezer se duplica!",
                            colour = G.C.PURPLE
                        })
                        
                        -- Animación en el Weezer original
                        card:juice_up(0.3, 0.5)
                        
                        -- Animación en el nuevo Weezer
                        new_weezer:juice_up(0.3, 0.5)
                        
                        return true
                    end
                }))
                
                return {
                    message = "¡Duplicación!",
                    colour = G.C.GREEN
                }
            else
                -- Mostrar progreso hacia la siguiente duplicación
                local remaining = card.ability.extra.rounds_needed - card.ability.extra.rounds_completed
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.3,
                    func = function()
                        card_eval_status_text(card, 'extra', nil, nil, nil, {
                            message = remaining .. " ronda" .. (remaining > 1 and "s" or "") .. " para duplicar",
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
        -- Resetear flag al cargar
        card.ability.extra.processed_round_end = false
    end,

    -- Función especial para evitar duplicaciones infinitas con Blueprint
    can_use = function(self, card)
        return true
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
        return { vars = { center.ability.extra.total_mult } }
    end,

    calculate = function(self, card, context)
        -- Actualizar contador al inicio de cada mano
        if context.joker_main and not context.blueprint then
            local polychrome_count = 0
            
            -- Contar Jokers policromo
            for _, joker in ipairs(G.jokers.cards) do
                if joker.edition and joker.edition.polychrome then
                    polychrome_count = polychrome_count + 1
                end
            end
            
            -- Contar cartas de juego policromo
            if G.playing_cards then
                for _, c in ipairs(G.playing_cards) do
                    if c.edition and c.edition.polychrome then
                        polychrome_count = polychrome_count + 1
                    end
                end
            end
            
            card.ability.extra.total_mult = polychrome_count * card.ability.extra.mult_per_polychrome
            
            -- Aplicar multiplicador si hay alguno
            if card.ability.extra.total_mult > 0 then
                return {
                    mult_mod = card.ability.extra.total_mult,
                    message = "+"..card.ability.extra.total_mult.." ("..polychrome_count.." policromo)",
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
            hand_played = false  -- Control para evitar bucles
        } 
    },

    loc_vars = function(self, info_queue, center)
        return { vars = { center.ability.extra.current_mult } }
    end,

    calculate = function(self, card, context)
        -- Aplicar el multiplicador durante la jugada
        if context.joker_main then
            card.ability.extra.hand_played = true  -- Marcar que se jugó una mano
            return {
                mult_mod = card.ability.extra.current_mult,
                message = "+"..card.ability.extra.current_mult.." Multi",
                colour = G.C.MULT
            }
        end

        -- Reducir el multiplicador después de jugar una mano
        if context.end_of_round and not context.blueprint and card.ability.extra.hand_played then
            card.ability.extra.hand_played = false  -- Resetear para la próxima mano
            
            local prev_mult = card.ability.extra.current_mult
            card.ability.extra.current_mult = math.max(0, prev_mult - card.ability.extra.decay)
            
            -- Efecto visual de reducción
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.1,
                func = function()
                    card_eval_status_text(card, 'extra', nil, nil, nil, {
                        message = "-"..card.ability.extra.decay.." Multi (Ahora +"..card.ability.extra.current_mult..")",
                        colour = prev_mult > 0 and G.C.RED or G.C.UI.TEXT_INACTIVE
                    })
                    return true
                end
            }))

            -- Destruir la carta si llega a 0
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
    unlocked = true,
    discovered = true,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = false,
    config = { extra = { mult = 0, triggered = false } },

    loc_vars = function(self, info_queue, center)
        return { vars = { center.ability.extra.mult } }
    end,

    calculate = function(self, card, context)
        -- Resetear al preparar nueva ciega
        if context.setting_blind then
            card.ability.extra.triggered = false
            return
        end

        -- Aplicar Multi acumulado
        if context.joker_main and card.ability.extra.mult > 0 then
            return {
                mult_mod = card.ability.extra.mult,
                message = "+"..card.ability.extra.mult.." Multi",
                colour = G.C.MULT
            }
        end

        -- Efecto principal al final de ronda
        if context.end_of_round and not context.blueprint and not context.individual 
        and not card.ability.extra.triggered then

            if G.GAME.dollars >= 1 then
                card.ability.extra.triggered = true
                G.GAME.dollars = G.GAME.dollars - 1
                card.ability.extra.mult = card.ability.extra.mult + 3

                -- Mensaje de dinero (CORREGIDO)
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

                -- Mensaje de Multi (0.3s después)
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.3,
                    func = (function()
                        card_eval_status_text(card, 'extra', nil, nil, nil, {
                            message = "+3 Multi",
                            colour = G.C.MULT
                        })
                        return true
                    end)
                }))

            else
                -- Mensaje si no hay dinero
                card_eval_status_text(card, 'extra', nil, nil, nil, {
                    message = "¡Sin dinero!",
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

-- Atlas de Caja vacia y Julio
SMODS.Atlas{
    key = 'box',
    path = 'box.png',
    px = 71,
    py = 95
}

SMODS.Atlas{
    key = 'julio',
    path = 'julio.png',
    px = 71,
    py = 95
}

-- Caja vacía
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
        return { vars = { center.ability.extra.hands_played } }
    end,

    calculate = function(self, card, context)
        if context.joker_main then
            card.ability.extra.hands_played = card.ability.extra.hands_played + 1
            
            -- Transformar tras 4 manos
            if card.ability.extra.hands_played >= 4 then
                -- Crear Julio y destruir la caja
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.3,
                    func = function()
                        -- Crear Julio en la misma posición
                        local julio = create_card('Joker', G.jokers, nil, nil, nil, nil, 'j_mania_julio')
                        julio:add_to_deck()
                        G.jokers:emplace(julio)
                        
                        -- Mensaje de transformación
                        card_eval_status_text(julio, 'extra', nil, nil, nil, {
                            message = "¡Julio ha despertado!",
                            colour = G.C.PURPLE
                        })
                        
                        -- Remover la caja
                        G.jokers:remove_card(card)
                        card:remove()
                        
                        return true
                    end
                }))
                
                return {
                    message = "¡Transformando!",
                    colour = G.C.PURPLE
                }
            else
                return {
                    message = card.ability.extra.hands_played .. "/4 manos",
                    colour = G.C.UI.TEXT_LIGHT
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

-- Julio
SMODS.Joker{
    key = 'julio',
    loc_txt = {
        name = '{C:blue}Julio{}',
        text = {
            '{C:spectral}+#1#{} multi',
            'Cada {C:spectral}4 manos{} jugadas,',
            'el multi se {C:spectral}eleva al cuadrado{}',
            '{C:inactive}Manos: {C:spectral}#2#/4'
        }
    },
    atlas = 'julio',
    rarity = 4,
    cost = 20,
    pools = {},  -- NO aparece en ningún pool
    unlocked = true,  
    discovered = true,  
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = false,
    pos = {x = 0, y = 0},
    config = { 
        extra = { 
            base_mult = 24,
            hands_played = 0,
            squaring_cycles = 0
        } 
    },

    loc_vars = function(self, info_queue, center)
        return { 
            vars = { 
                center.ability.extra.base_mult, 
                center.ability.extra.hands_played,
                "N/A"  -- Ya no usamos squaring_cycles de la misma manera
            } 
        }
    end,

    calculate = function(self, card, context)
        if context.joker_main then
            card.ability.extra.hands_played = card.ability.extra.hands_played + 1
            
            -- Calcular multiplicador actual
            local current_mult = card.ability.extra.base_mult ^ (card.ability.extra.squaring_cycles + 1)
            
            -- Elevar al cuadrado cada 4 manos
            if card.ability.extra.hands_played >= 4 then
                card.ability.extra.hands_played = 0
                
                -- CRÍTICO: Elevar el multiplicador ACTUAL al cuadrado
                local old_mult = current_mult
                current_mult = current_mult * current_mult  -- current_mult^2
                
                -- Actualizar el sistema para mantener el nuevo valor
                -- Guardamos el nuevo multiplicador como base para futuros cálculos
                card.ability.extra.base_mult = current_mult
                card.ability.extra.squaring_cycles = 0  -- Resetear ya que ahora base_mult es el nuevo valor
                
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.1,
                    func = function()
                        card_eval_status_text(card, 'extra', nil, nil, nil, {
                            message = "¡Al cuadrado! " .. old_mult .. "² = +" .. current_mult,
                            colour = G.C.RED
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
        
        -- Marcar como descubierto cuando se obtiene
        if initial then
            self.discovered = true
        end
    end,

    add_to_deck = function(self, card, from_debuff)
        -- Marcar como descubierto al añadirlo al mazo
        self.discovered = true
    end,

    -- Función especial para que no aparezca en tiendas ni paquetes
    can_use = function(self, card)
        return true  -- Se puede usar una vez obtenido
    end,

    -- Evitar que aparezca en generación aleatoria
    get_weight = function(self)
        return 0  -- Peso 0 = nunca aparece aleatoriamente
    end,

    check_for_unlock = function(self, args)
        -- Julio no se desbloquea normalmente, solo por transformación
        return false
    end,
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
        name = 'Nuevo Comienzo',
        text = {
            'Al final de cada ronda:',
            'Destruye {C:spectral}un Joker{} al azar',
            'y gana {X:chips,C:white}+0.5X{} chips',
            'Actual: {X:chips,C:white}X#1#{} chips',
        }
    },
    atlas = 'cotton',
    rarity = 3,
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
        return { vars = { string.format("%.1f", center.ability.extra.x_chips) } }
    end,

    calculate = function(self, card, context)
        -- Resetear al inicio de nueva ciega
        if context.setting_blind and not context.blueprint then
            card.ability.extra.triggered_this_round = false
        end

        -- Aplicar multiplicador de chips durante la jugada
        if context.joker_main and card.ability.extra.x_chips > 1 then
            return {
                message = "X" .. string.format("%.1f", card.ability.extra.x_chips),
                x_chips = card.ability.extra.x_chips,
                colour = G.C.CHIPS
            }
        end

        -- Al final de la ronda: destruir joker aleatorio
        if context.end_of_round and not context.blueprint and not card.ability.extra.triggered_this_round then
            card.ability.extra.triggered_this_round = true
            
            local destroyable_jokers = {}
            
            -- Buscar jokers destruibles (excluyéndose a sí mismo y eternales)
            for _, j in ipairs(G.jokers.cards) do
                if j ~= card and not j.ability.eternal and j.config.center.key ~= 'j_mania_cotton' then
                    table.insert(destroyable_jokers, j)
                end
            end

            if #destroyable_jokers > 0 then
                local joker_to_destroy = destroyable_jokers[math.random(#destroyable_jokers)]
                
                -- Aumentar multiplicador PRIMERO
                card.ability.extra.x_chips = card.ability.extra.x_chips + card.ability.extra.chip_gain
                
                -- Programar la destrucción del joker
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.3,
                    blockable = false,
                    func = function()
                        -- Mensaje de destrucción
                        card_eval_status_text(joker_to_destroy, 'extra', nil, nil, nil, {
                            message = "¡Destruido!",
                            colour = G.C.RED
                        })
                        
                        -- Eliminar el joker con animación
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

                -- Mensaje de ganancia de chips
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
                    message = "Nuevo Comienzo...",
                    colour = G.C.PURPLE
                }
            else
                -- No hay jokers para destruir
                return {
                    message = "Nada que destruir",
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
        card.ability.extra.triggered_this_round = false -- Siempre resetear al cargar
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
        return { vars = {
            center.ability.extra.current_mult,
            center.ability.extra.hands_played,
            center.ability.extra.hands_needed,
            center.ability.extra.level
        } }
    end,

    calculate = function(self, card, context)
        -- Contar manos y subir de nivel
        if context.joker_main and not context.blueprint then
            card.ability.extra.hands_played = card.ability.extra.hands_played + 1

            if card.ability.extra.hands_played >= card.ability.extra.hands_needed 
            and card.ability.extra.level < card.ability.extra.max_level then

                card.ability.extra.level = card.ability.extra.level + 1
                card.ability.extra.current_mult = card.ability.extra.current_mult + 1
                card.ability.extra.hands_played = 0
                card.ability.extra.hands_needed = card.ability.extra.hands_needed + 1

                -- Efecto visual al subir de nivel
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.5,
                    func = function()
                        card_eval_status_text(card, 'extra', nil, nil, nil, {
                            message = "¡NIVEL " .. card.ability.extra.level .. "!",
                            colour = G.C.RED
                        })
                        card:juice_up(0.3, 0.5)
                        return true
                    end
                }))
            end

            -- Aplicar solo a sí mismo
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

