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