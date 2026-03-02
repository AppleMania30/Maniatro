-- Todo al Rojo
SMODS.Atlas{
    key = 'todoalrojo',
    path = 'todoalrojo.png',
    px = 71,
    py = 95,
}

SMODS.Voucher {
    key = 'todoalrojo',
    pos = { x = 0, y = 0 },
    config = { 
        extra = {
            xmult = 2
        } 
    },
    loc_txt = {
        name = 'Todo al rojo',
        text = {
            'Da {X:mult,C:white}X#1#{} multi',
            'por el resto de la partida.'
        }
    },
    loc_vars = function(self, info_queue, card)
        return { vars = { self.config.extra.xmult } }
    end,
    unlocked = true,
    discovered = true,
    no_collection = false,
    can_repeat_soul = false,
    atlas = 'todoalrojo',
    redeem = function(self, card)
        G.E_MANAGER:add_event(Event({
            func = function()
                card:juice_up(0.3, 0.5)
                return true
            end
        }))
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                message = localize{type='variable', key='a_xmult', vars={self.config.extra.xmult}},
                Xmult_mod = self.config.extra.xmult
            }
        end
    end
}

-- Jackpot
SMODS.Atlas{
    key = 'jackpot',
    path = 'jackpot.png',
    px = 71,
    py = 95,
}

SMODS.Voucher {
    key = 'jackpot',
    pos = { x = 0, y = 0 },
    config = { 
        extra = {
            emult = 1.5
        } 
    },
    loc_txt = {
        name = 'Jackpot',
        text = {
            'Da {X:dark_edition,C:white}^#1#{} multi',
            'por el resto de la partida.'
        }
    },
    loc_vars = function(self, info_queue, card)
        return { vars = { self.config.extra.emult } }
    end,
    unlocked = true,
    discovered = true,
    no_collection = false,
    can_repeat_soul = false,
    requires = { "v_mania_todoalrojo" },
    atlas = 'jackpot',
    redeem = function(self, card)
        G.E_MANAGER:add_event(Event({
            func = function()
                card:juice_up(0.3, 0.5)
                return true
            end
        }))
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                message = localize{type='variable', key='a_emult', vars={self.config.extra.emult}},
                e_mult = self.config.extra.emult
            }
        end
    end
}

-- Pacto Cítrico
SMODS.Atlas{
    key = 'pactocitrico',
    path = 'pacto.png',
    px = 71,
    py = 95,
}

SMODS.Voucher {
    key = 'pactocitrico',
    pos = { x = 0, y = 0 },
    config = { 
        extra = {
            probability = 0.15
        } 
    },
    loc_txt = {
        name = 'Pacto Cítrico',
        text = {
            'Los jokers comprados tienen un {C:green}15%{} de',
            'probabilidad de volverse {C:dark_edition}cítricos{}.'
        }
    },
    loc_vars = function(self, info_queue, card)
        return { vars = { self.config.extra.probability * 100 } }
    end,
    unlocked = true,
    discovered = true,
    no_collection = false,
    can_repeat_soul = false,
    atlas = 'pactocitrico',
    redeem = function(self, card)
        G.E_MANAGER:add_event(Event({
            func = function()
                card:juice_up(0.3, 0.5)
                return true
            end
        }))
    end,
    calculate = function(self, card, context)
        if context.buying_card and context.card and context.card.ability and context.card.ability.set == 'Joker' then
            if not context.card.edition and math.random() < self.config.extra.probability then
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.1,
                    func = function()
                        context.card:set_edition({mania_citrico = true}, true)
                        card_eval_status_text(card, 'extra', nil, nil, nil, {
                            message = "Citric!",
                            colour = G.C.GREEN
                        })
                        return true
                    end
                }))
            end
        end
    end
}

-- Iridiscencia
SMODS.Atlas{
    key = 'iridiscencia',
    path = 'pacto.png',
    px = 71,
    py = 95,
}

SMODS.Voucher {
    key = 'iridiscencia',
    pos = { x = 1, y = 0 },
    config = { 
        extra = {
            probability = 0.10
        } 
    },
    loc_txt = {
        name = 'Iridiscencia',
        text = {
            'Los jokers comprados tienen un {C:green}10%{} de',
            'probabilidad de volverse {C:dark_edition}iridiscentes{}.'
        }
    },
    loc_vars = function(self, info_queue, card)
        return { vars = { self.config.extra.probability * 100 } }
    end,
    unlocked = true,
    discovered = true,
    no_collection = false,
    can_repeat_soul = false,
    requires = { "v_mania_pactocitrico" },
    atlas = 'iridiscencia',
    redeem = function(self, card)
        G.E_MANAGER:add_event(Event({
            func = function()
                card:juice_up(0.3, 0.5)
                return true
            end
        }))
    end,
    calculate = function(self, card, context)
        if context.buying_card and context.card and context.card.ability and context.card.ability.set == 'Joker' then
            if not context.card.edition and math.random() < self.config.extra.probability then
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.1,
                    func = function()
                        context.card:set_edition({mania_iridiscente = true}, true)
                        card_eval_status_text(card, 'extra', nil, nil, nil, {
                            message = "Iridiscent!",
                            colour = G.C.DARK_EDITION
                        })
                        return true
                    end
                }))
            end
        end
    end
}

-- Cosecha
SMODS.Atlas{
    key = 'cosecha',
    path = 'cosecha.png',
    px = 71,
    py = 95,
}

SMODS.Voucher {
    key = 'cosecha',
    pos = { x = 0, y = 0 },
    config = { 
        extra = {
            chips = 5
        } 
    },
    loc_txt = {
        name = 'Cosecha',
        text = {
            'Las cartas con el palo de {C:green}Manzana{}',
            'dan {C:blue}+#1#{} chips adicionales cuando puntúan.'
        }
    },
    loc_vars = function(self, info_queue, card)
        return { vars = { self.config.extra.chips } }
    end,
    unlocked = true,
    discovered = true,
    no_collection = false,
    can_repeat_soul = false,
    atlas = 'cosecha',
    redeem = function(self, card)
        G.E_MANAGER:add_event(Event({
            func = function()
                card:juice_up(0.3, 0.5)
                return true
            end
        }))
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and context.other_card then
            if context.other_card:is_suit('mania_applesuit') then
                return {
                    chips = self.config.extra.chips,
                    card = card
                }
            end
        end
    end
}

-- Recogida
SMODS.Atlas{
    key = 'recogida',
    path = 'recogida.png',
    px = 71,
    py = 95,
}

SMODS.Voucher {
    key = 'recogida',
    pos = { x = 0, y = 0 },
    config = { 
        extra = {
            mult = 10
        } 
    },
    loc_txt = {
        name = 'Recogida',
        text = {
            'Las cartas con el palo de {C:green}Manzana{}',
            'dan {C:red}+#1#{} multi adicionales cuando puntúan.'
        }
    },
    loc_vars = function(self, info_queue, card)
        return { vars = { self.config.extra.mult } }
    end,
    unlocked = true,
    discovered = true,
    no_collection = false,
    can_repeat_soul = false,
    requires = { "v_mania_cosecha" },
    atlas = 'recogida',
    redeem = function(self, card)
        G.E_MANAGER:add_event(Event({
            func = function()
                card:juice_up(0.3, 0.5)
                return true
            end
        }))
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and context.other_card then
            if context.other_card:is_suit('mania_applesuit') then
                return {
                    mult = self.config.extra.mult,
                    card = card
                }
            end
        end
    end
}