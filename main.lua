--- STEAMODDED HEADER
--- MOD_NAME: Maniatro
--- MOD_ID: MANIATRO
--- MOD_AUTHOR: AppleMania
--- MOD_DESCRIPTION: No
--- PREFIX: mania
----------------------------------------------
------------ MOD CODE -------------------------

-- Atlas de imágenes
SMODS.Atlas{
    key = 'ManiaAtlas',
    path = 'Jokers.png',
    px = 71,
    py = 95
}

SMODS.Joker{
    key = 'manzana_verde',
    loc_txt = {
        name = 'Manzana Verde',
        text = {
            'Si juegas exactamente {C:attention}5{} cartas,',
            'ganas {C:money}+3${} y {C:mult}+5 Mult{} por esa mano.'
        }
    },
    atlas = 'ManiaAtlas',
    rarity = 1,
    cost = 4,
    pools = {['ManiatroOnly'] = true},
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
                message = '+3$ +5 Mult',
                mult_mod = 5,
                dollars = 3
            }
        end
    end,
}


-- Ushanka
SMODS.Joker{
    key = 'ushanka',
    loc_txt = {
        name = 'Ushanka',
        text = {
            'Obtienes {C:dark_edition}+1{} espacio de Joker',
            'pero tu mano se reduce en {C:red}-1{} carta'
        }
    },
    atlas = 'ManiaAtlas',
    rarity = 2,
    cost = 6,
    pools = {['ManiatroOnly'] = true},
    unlocked = true,
    discovered = true,
    blueprint_compat = false,
    eternal_compat = false,
    perishable_compat = false,
    pos = {x=1, y=0},
    config = {},

    loc_vars = function(self, info_queue, center)
        return { vars = {} }
    end,

    add_to_deck = function(self, card, from_debuff)
        G.jokers.config.card_limit = G.jokers.config.card_limit + 1
        G.hand.config.card_limit = G.hand.config.card_limit - 1
    end,

    remove_from_deck = function(self, card, from_debuff)
        G.jokers.config.card_limit = G.jokers.config.card_limit - 1
        G.hand.config.card_limit = G.hand.config.card_limit + 1
    end,
}

-- Xifox (Versión corregida)
SMODS.Joker{
    key = 'xifox',
    loc_txt = {
        name = 'Xifox',
        text = {
            '{X:mult,C:white}x2{} Mult por cada carta de {C:attention}7{} que puntúe.'
        }
    },
    atlas = 'ManiaAtlas',
    rarity = 3,
    cost = 8,
    pools = {['ManiatroOnly'] = true},
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = false,
    perishable_compat = false,
    pos = {x=2, y=0},
    config = { extra = {xmult = 2} },

    loc_vars = function(self, info_queue, center)
        return { vars = { center.ability.extra.xmult } }
    end,

    calculate = function(self, card, context)
        -- Se activa cuando cada carta individual puntúa
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
SMODS.Joker{
    key = 'net',
    loc_txt = {
        name = 'NET',
        text = {
            'Si las cartas jugadas tienen exactamente',
            '{C:attention}3 palos{} diferentes, el Mult se multiplica por {C:mult}X2{}.'
        }
    },
    atlas = 'ManiaAtlas',
    rarity = 3,
    cost = 7,
    pools = {['ManiatroOnly'] = true},
    unlocked = true,
    discovered = true,
    blueprint_compat = false,
    eternal_compat = false,
    perishable_compat = false,
    pos = {x=3, y=0},
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
                    message = 'X2',
                    Xmult_mod = 2
                }
            end
        end
    end,
}

-- Keep Rollin' (Retriggeo Aleatorio de Picas)
SMODS.Joker{
    key = 'keep_rollin',
    loc_txt = {
        name = "Keep Rollin'",
        text = {
            'Cualquier carta de {C:spades}picas{} jugada',
            'tiene {C:attention}1/4{} de probabilidad',
            'de retriggerearse.'
        }
    },
    atlas = 'ManiaAtlas',
    rarity = 2,
    cost = 7,
    pools = {['ManiatroOnly'] = true},
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = false,
    perishable_compat = false,
    pos = {x=4, y=0},
    config = {},

    loc_vars = function(self, info_queue, center)
        return { vars = {} }
    end,

    calculate = function(self, card, context)
        -- Aplicar retriggeo aleatorio a cartas de picas
        if context.repetition and context.cardarea == G.play and context.other_card then
            if context.other_card:is_suit('Spades') and math.random() < 0.25 then
                return {
                    message = 'Keep Rollin!',
                    repetitions = 1,
                    card = context.other_card,
                    colour = G.C.RED
                }
            end
        end
    end,

    check_for_unlock = function(self, args)
        unlock_card(self)
    end,
}


-- Loss
SMODS.Joker{
    key = 'loss',
    loc_txt = {
        name = 'Loss',
        text = {
            'Si la mano usada tiene exactamente',
            '4 cartas en este orden: {C:attention}As, 2, 2, 2{}, gana {X:mult,C:white}x3{} multiplicador.'
        }
    },
    atlas = 'ManiaAtlas',
    rarity = 2,
    cost = 5,
    pools = {['ManiatroOnly'] = true},
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = false,
    perishable_compat = false,
    pos = {x=0, y=1},
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
SMODS.Joker{
    key = 'insomnio',
    loc_txt = {
        name = 'Insomnio',
        text = {
            '{X:mult,C:white}X#1#{} Mult.',
            'Al comenzar una ronda, tiene {C:attention}50%{} de ganar {X:mult,C:white}+0.5x{},',
            'pero si falla, se destruye.'
        }
    },
    atlas = 'ManiaAtlas',
    rarity = 3,
    cost = 8,
    pools = {['ManiatroOnly'] = true},
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = false,
    perishable_compat = false,
    pos = {x = 1, y = 1},
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
SMODS.Joker{
    key = 'reddead2',
    loc_txt = {
        name = 'Red Dead Redemption II',
        text = {
            "{C:red}+#1#{} Mult y {C:blue}+#2#{} Fichas",
            "al jugar un {C:hearts}corazón{} o un {C:attention}8{}",
            "{C:inactive}''Lo di todo por ti.''"
        }
    },
    atlas = 'ManiaAtlas',
    rarity = 2,
    cost = 5,
    pools = {['ManiatroOnly'] = true},
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = false,
    perishable_compat = false,
    pos = {x = 2, y = 1},
    config = { extra = {mult = 2, chips = 30} },

    loc_vars = function(self, info_queue, center)
        return { vars = { center.ability.extra.mult, center.ability.extra.chips } }
    end,

    calculate = function(self, card, context)
        if context.cardarea == G.play and context.individual and context.other_card then
            local rank = context.other_card:get_id()
            if context.other_card:is_suit('Hearts') or rank == 8 then
                return {
                    mult_mod = card.ability.extra.mult,
                    chip_mod = card.ability.extra.chips,
                    message = "Lo di todo por ti."
                }
            end
        end
    end,

    check_for_unlock = function(self, args)
        unlock_card(self)
    end,
}

-- Minion Pigs - King Pig Version
SMODS.Joker{
    key = 'minion_pigs',
    loc_txt = {
        name = 'Minion Pigs',
        text = {
            'Por cada {C:attention}Joker de rareza común{}',
            'adquirido, este Joker obtiene',
            '{C:red}+#1#{} de Mult.',
            'Actual: {C:red}+#2#{} Mult'
        }
    },
    atlas = 'ManiaAtlas',
    rarity = 3,
    cost = 7,
    pools = {['ManiatroOnly'] = true},
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    pos = {x=3, y=1},
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

-- Ale (Versión corregida)
SMODS.Joker{
    key = 'ale',
    loc_txt = {
        name = 'Ale',
        text = {
            'Cada vez que juegas una mano, hay una probabilidad',
            'de {C:attention}1/2{} de darte {C:blue}+50{} fichas o quitarte {C:red}-50{} fichas.'
        }
    },
    atlas = 'ManiaAtlas',
    rarity = 2,
    cost = 6,
    pools = {['ManiatroOnly'] = true},
    unlocked = true,
    discovered = true,
    blueprint_compat = false,
    eternal_compat = false,
    perishable_compat = false,
    pos = {x = 4, y = 1},
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
SMODS.Joker{
    key = 'nauiyo',
    loc_txt = {
        name = 'Nauiyo',
        text = {
            '{X:mult,C:white}X#1#{} Mult.',
            '{X:mult,C:white}+X0.2{} por cada carta más en tu baraja,',
            '{X:mult,C:white}-X0.2{} por cada carta menos en tu baraja.',
            'Actual: {X:mult,C:white}X#1#{}'
        }
    },
    atlas = 'ManiaAtlas',
    rarity = 3,
    cost = 7,
    pools = { ['ManiatroOnly'] = true },
    unlocked = true,
    discovered = true,
    blueprint_compat = false,
    eternal_compat = false,
    perishable_compat = false,
    pos = {x = 0, y = 2},
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

-- Tablet (Versión corregida)
SMODS.Joker{
    key = 'tablet',
    loc_txt = {
        name = 'Tablet',
        text = {
            'Si repites el mismo {C:attention}tipo de mano{} en dos jugadas seguidas,',
            'el multiplicador se multiplica por {X:mult,C:white}x2.5{} y aumenta',
            '{X:mult,C:white}+0.5x{} por cada repetición adicional.',
            'Actual: {X:mult,C:white}x#1#{}'
        }
    },
    atlas = 'ManiaAtlas',
    rarity = 3,
    cost = 8,
    pools = {['ManiatroOnly'] = true},
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = false,
    perishable_compat = false,
    pos = {x = 1, y = 2},
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

-- Amongla (Versión corregida)
SMODS.Joker{
    key = 'amongla',
    loc_txt = {
        name = '{C:red}Amongla{}',
        text = {
            '{X:mult,C:white}X#1#{} mult',
            '{C:attention}1 entre 8{} de probabilidad',
            'de cerrar el juego.'
        }
    },
    atlas = 'ManiaAtlas',
    rarity = 3,
    cost = 8,
    pools = {['ManiatroOnly'] = true},
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = false,
    perishable_compat = false,
    pos = {x = 2, y = 2},
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
SMODS.Joker{
    key = 'fatal',
    loc_txt = {
        name = '{C:red}FATAL{}',
        text = {
            '...'
        }
    },
    atlas = 'ManiaAtlas',
    rarity = 4,
    cost = 10,
    pools = {['ManiatroOnly'] = true},
    unlocked = true,
    discovered = true,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = false,
    pos = {x = 3, y = 2},
    config = {},

    loc_vars = function(self, info_queue, center)
        return { vars = {} }
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
SMODS.Joker{
    key = 'proto',
    loc_txt = {
        name = 'Proto',
        text = {
            'Permite descartar {C:attention}cualquier cantidad{}',
            'de cartas de tu mano.'
        }
    },
    atlas = 'ManiaAtlas',
    rarity = 4,
    cost = 15,
    pools = {['ManiatroOnly'] = true},
    unlocked = true,
    discovered = true,
    blueprint_compat = false,
    eternal_compat = false,
    perishable_compat = false,
    pos = {x = 4, y = 2},
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
