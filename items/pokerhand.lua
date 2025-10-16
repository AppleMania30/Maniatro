SMODS.PokerHand({
    key = "pkr_perdida",
    mult = 8,
    chips = 70,
    l_mult = 3,
    l_chips = 25,
    example = {
        { 'S_A', true }, -- Ace of Spades, scores
        { 'D_2', true }, -- 2 of Diamonds, scores
        { 'H_2', true }, -- 2 of Hearts, scores
        { 'C_2', true }, -- 2 of Clubs, scores
        { 'S_K', false } -- King of Spades, does not score
    },
    loc_txt = {
        name = "Loss",
        description = {"Una mano que contiene un As y tres 2s."},
    },
    visible = true,

    evaluate = function(parts, hand)
        if #hand >= 4 then
            local _hasAce = false
            local _twos_count = 0
            local eligible_cards = {}
            
            -- Check for conflicts with higher priority hands
            local other_hands = next(parts._flush) or next(parts._straight)

            for i, card in ipairs(hand) do
                if card:get_id() == 14 and _hasAce == false then -- Ace is ID 14
                    _hasAce = true
                    eligible_cards[#eligible_cards + 1] = card
                elseif card:get_id() == 2 and _twos_count < 3 then -- 2 is ID 2
                    _twos_count = _twos_count + 1
                    eligible_cards[#eligible_cards + 1] = card
                end
            end

            if _hasAce and _twos_count == 3 and not other_hands then
                return {eligible_cards}
            end
        end
        return {}
    end,

    modify_display_text = function(self, cards, scoring_hand)
        return "Loss"
    end,
})

-- Citra
SMODS.Atlas{
    key = 'citra',
    path = 'citra.png',
    px = 71,
    py = 96,
}

SMODS.Consumable {
    key = 'citra',
    set = 'Planet',
    pos = { x = 0, y = 0 },
    config = { extra = {
        hand_type = "mania_pkr_perdida",
        levels = 1
    } },
    loc_txt = {
        name = 'Citra',
        text = {
        [1] = 'Aumento de nivel',
        [2] = '{C:attention}Loss{}',
        [3] = '{C:red}+3{} multi y',
        [4] = '{C:blue}+25{} chips'
    }
    },
    cost = 3,
    unlocked = true,
    discovered = true,
    hidden = false,
    can_repeat_soul = false,
    atlas = 'citra',
    use = function(self, card, area, copier)
        local used_card = copier or card
            update_hand_text({ sound = 'button', volume = 0.7, pitch = 0.8, delay = 0.3 },
                { handname = localize('mania_pkr_perdida', 'poker_hands'), 
                  chips = G.GAME.hands['mania_pkr_perdida'].chips, 
                  mult = G.GAME.hands['mania_pkr_perdida'].mult, 
                  level = G.GAME.hands['mania_pkr_perdida'].level })
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.2,
                func = function()
                    play_sound('tarot1')
                    card:juice_up(0.8, 0.5)
                    G.TAROT_INTERRUPT_PULSE = true
                    return true
                end
            }))
            update_hand_text({ delay = 0 }, { mult = '+', StatusText = true })
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.9,
                func = function()
                    play_sound('tarot1')
                    card:juice_up(0.8, 0.5)
                    return true
                end
            }))
            update_hand_text({ delay = 0 }, { chips = '+', StatusText = true })
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.9,
                func = function()
                    play_sound('tarot1')
                    card:juice_up(0.8, 0.5)
                    G.TAROT_INTERRUPT_PULSE = nil
                    return true
                end
            }))
            update_hand_text({ sound = 'button', volume = 0.7, pitch = 0.9, delay = 0 }, { level = '+'..tostring(1) })
            delay(1.3)
            level_up_hand(card, "mania_pkr_perdida", true, 1)
            update_hand_text({sound = 'button', volume = 0.7, pitch = 1.1, delay = 0}, 
                {handname=localize('mania_pkr_perdida', 'poker_hands'), 
                 chips = G.GAME.hands['mania_pkr_perdida'].chips, 
                 mult = G.GAME.hands['mania_pkr_perdida'].mult, 
                 level=G.GAME.hands['mania_pkr_perdida'].level})
            delay(1.3)
    end,
    can_use = function(self, card)
        return true
    end
}