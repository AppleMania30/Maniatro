-- Temporal Sticker
SMODS.Atlas{
    key = 'temporal',
    path = 'temporal.png',
    px = 71,
    py = 95,
}

SMODS.Sticker {
    key = "temporal",
    atlas = "temporal",
    badge_colour = HEX('68e76c'),
    pos = { x = 0, y = 0 },
    loc_txt = {
        name = "Temporal",
        label = "Temporal",
        text = {
            "No se puede {C:attention}vender{} ni {C:attention}destruir{}",
            "durante {C:attention}#1#{} rondas"
        }
    },
    should_apply = function(self, card, center, area, bypass_roll)
        return false
    end,
    apply = function(self, card, val)
        card.ability[self.key] = val
        if card.ability[self.key] then 
            card.ability.temporal_rounds = 5
            card.ability.temporal_indestructible = true
        end
    end,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.temporal_rounds or 5 } }
    end,
    calculate = function(self, card, context)
        if context.end_of_round and not context.repetition and not context.individual then
            if card.ability.temporal_rounds and card.ability.temporal_rounds > 0 then
                card.ability.temporal_rounds = card.ability.temporal_rounds - 1
                
                if card.ability.temporal_rounds <= 0 then
                    card.ability.temporal_indestructible = false
                    
                    G.E_MANAGER:add_event(Event({
                        trigger = 'after',
                        delay = 0.3,
                        func = function()
                            card_eval_status_text(card, 'extra', nil, nil, nil, {
                                message = "Unlocked!",
                                colour = G.C.GREEN
                            })
                            return true
                        end
                    }))
                else
                    G.E_MANAGER:add_event(Event({
                        trigger = 'after',
                        delay = 0.3,
                        func = function()
                            card_eval_status_text(card, 'extra', nil, nil, nil, {
                                message = card.ability.temporal_rounds .. " round" .. (card.ability.temporal_rounds > 1 and "s" or ""),
                                colour = G.C.GREEN
                            })
                            return true
                        end
                    }))
                end
            end
        end
    end
}

local card_can_sell_ref = Card.can_sell_card
function Card:can_sell_card(context)
    if self.ability.temporal_indestructible then
        return false
    end
    return card_can_sell_ref(self, context)
end

local card_start_dissolve_ref = Card.start_dissolve
function Card:start_dissolve(dissolve_colours, silent, dissolve_time_fac, no_juice)
    if self.ability.temporal_indestructible then
        card_eval_status_text(self, 'extra', nil, nil, nil, {
            message = "Protected!",
            colour = G.C.PURPLE
        })
        return
    end
    return card_start_dissolve_ref(self, dissolve_colours, silent, dissolve_time_fac, no_juice)
end