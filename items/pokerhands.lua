SMODS.PokerHand({
    key = "pkr_perdida",
    mult = 8,
    chips = 70,
    l_mult = 3,
    l_chips = 25,
    example = {
        { 'S_A', true }, 
        { 'D_2', true },
        { 'H_2', true },
        { 'C_2', true },
        { 'S_K', false }
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
            
            local other_hands = next(parts._flush) or next(parts._straight)

            for i, card in ipairs(hand) do
                if card:get_id() == 14 and _hasAce == false then 
                    _hasAce = true
                    eligible_cards[#eligible_cards + 1] = card
                elseif card:get_id() == 2 and _twos_count < 3 then 
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

-- Triple Pareja
SMODS.PokerHand({
    key = "pkr_triple_pareja",
    mult = 4,
    chips = 40,
    l_mult = 2,
    l_chips = 20,
    example = {
        { 'S_A', true },
        { 'H_A', true },
        { 'S_K', true },
        { 'H_K', true },
        { 'S_Q', true },
        { 'H_Q', true },
    },
    loc_txt = {
        name = "Triple Pareja",
        description = { "Tres parejas." },
    },
    visible = true,

    evaluate = function(parts, hand)
        if #hand >= 6 then
            local rank_counts = {}
            for _, card in ipairs(hand) do
                local id = card:get_id()
                rank_counts[id] = (rank_counts[id] or 0) + 1
            end

            local pairs_cards = {}
            local pair_count = 0
            for id, count in pairs(rank_counts) do
                if count >= 2 then
                    pair_count = pair_count + 1
                    local added = 0
                    for _, card in ipairs(hand) do
                        if card:get_id() == id and added < 2 then
                            pairs_cards[#pairs_cards + 1] = card
                            added = added + 1
                        end
                    end
                end
            end

            if pair_count >= 3 then
                return { pairs_cards }
            end
        end
        return {}
    end,
})

-- Doble Trío
SMODS.PokerHand({
    key = "pkr_doble_trio",
    mult = 6,
    chips = 60,
    l_mult = 3,
    l_chips = 20,
    example = {
        { 'S_A', true },
        { 'H_A', true },
        { 'D_A', true },
        { 'S_K', true },
        { 'H_K', true },
        { 'D_K', true },
    },
    loc_txt = {
        name = "Doble Trío",
        description = { "Dos tríos." },
    },
    visible = true,

    evaluate = function(parts, hand)
        if #hand >= 6 then
            local rank_counts = {}
            for _, card in ipairs(hand) do
                local id = card:get_id()
                rank_counts[id] = (rank_counts[id] or 0) + 1
            end

            local trio_cards = {}
            local trio_count = 0
            for id, count in pairs(rank_counts) do
                if count >= 3 then
                    trio_count = trio_count + 1
                    local added = 0
                    for _, card in ipairs(hand) do
                        if card:get_id() == id and added < 3 then
                            trio_cards[#trio_cards + 1] = card
                            added = added + 1
                        end
                    end
                end
            end

            if trio_count >= 2 then
                return { trio_cards }
            end
        end
        return {}
    end,
})

-- Color+
SMODS.PokerHand({
    key = "pkr_color_plus",
    mult = 10,
    chips = 75,
    l_mult = 4,
    l_chips = 30,
    example = {
        { 'S_A', true },
        { 'S_K', true },
        { 'S_Q', true },
        { 'S_J', true },
        { 'S_9', true },
        { 'S_7', true },
    },
    loc_txt = {
        name = "Color+",
        description = { "Seis cartas del mismo palo." },
    },
    visible = true,

    evaluate = function(parts, hand)
        if #hand >= 6 then
            local suit_cards = {}
            for _, card in ipairs(hand) do
                local suit = card.base.suit
                suit_cards[suit] = suit_cards[suit] or {}
                suit_cards[suit][#suit_cards[suit] + 1] = card
            end

            for suit, cards in pairs(suit_cards) do
                if #cards >= 6 then
                    local eligible = {}
                    for i = 1, 6 do
                        eligible[#eligible + 1] = cards[i]
                    end
                    return { eligible }
                end
            end
        end
        return {}
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

-- Visio
SMODS.Atlas{
    key = 'visio',
    path = 'visio.png',
    px = 71,
    py = 96,
}

SMODS.Consumable {
    key = 'visio',
    set = 'Planet',
    pos = { x = 0, y = 0 },
    config = { extra = { hand_type = "mania_pkr_triple_pareja", levels = 1 } },
    loc_txt = {
        name = 'Visio',
        text = {
            [1] = 'Aumento de nivel',
            [2] = '{C:attention}Triple Pareja{}',
            [3] = '{C:red}+2{} multi y',
            [4] = '{C:blue}+20{} chips'
        }
    },
    cost = 3,
    unlocked = true,
    discovered = true,
    atlas = 'visio',
    use = function(self, card, area, copier)
        update_hand_text({ sound = 'button', volume = 0.7, pitch = 0.8, delay = 0.3 },
            { handname = localize('mania_pkr_triple_pareja', 'poker_hands'), 
              chips = G.GAME.hands['mania_pkr_triple_pareja'].chips, 
              mult = G.GAME.hands['mania_pkr_triple_pareja'].mult, 
              level = G.GAME.hands['mania_pkr_triple_pareja'].level })
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
        level_up_hand(card, "mania_pkr_triple_pareja", true, 1)
        update_hand_text({sound = 'button', volume = 0.7, pitch = 1.1, delay = 0}, 
            {handname=localize('mania_pkr_triple_pareja', 'poker_hands'), 
             chips = G.GAME.hands['mania_pkr_triple_pareja'].chips, 
             mult = G.GAME.hands['mania_pkr_triple_pareja'].mult, 
             level=G.GAME.hands['mania_pkr_triple_pareja'].level})
        delay(1.3)
    end,
    can_use = function(self, card) return true end
}

-- Aromatidas
SMODS.Atlas{
    key = 'aromatidas',
    path = 'aromatidas.png',
    px = 71,
    py = 96,
}

SMODS.Consumable {
    key = 'aromatidas',
    set = 'Planet',
    pos = { x = 0, y = 0 },
    config = { extra = { hand_type = "mania_pkr_doble_trio", levels = 1 } },
    loc_txt = {
        name = 'Aromatidas',
        text = {
            [1] = 'Aumento de nivel',
            [2] = '{C:attention}Doble Trío{}',
            [3] = '{C:red}+3{} multi y',
            [4] = '{C:blue}+20{} chips'
        }
    },
    cost = 3,
    unlocked = true,
    discovered = true,
    atlas = 'aromatidas',
    use = function(self, card, area, copier)
        update_hand_text({ sound = 'button', volume = 0.7, pitch = 0.8, delay = 0.3 },
            { handname = localize('mania_pkr_doble_trio', 'poker_hands'), 
              chips = G.GAME.hands['mania_pkr_doble_trio'].chips, 
              mult = G.GAME.hands['mania_pkr_doble_trio'].mult, 
              level = G.GAME.hands['mania_pkr_doble_trio'].level })
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
        level_up_hand(card, "mania_pkr_doble_trio", true, 1)
        update_hand_text({sound = 'button', volume = 0.7, pitch = 1.1, delay = 0}, 
            {handname=localize('mania_pkr_doble_trio', 'poker_hands'), 
             chips = G.GAME.hands['mania_pkr_doble_trio'].chips, 
             mult = G.GAME.hands['mania_pkr_doble_trio'].mult, 
             level=G.GAME.hands['mania_pkr_doble_trio'].level})
        delay(1.3)
    end,
    can_use = function(self, card) return true end
}

-- Ilyko
SMODS.Atlas{
    key = 'ilyko',
    path = 'ilyko.png',
    px = 71,
    py = 96,
}

SMODS.Consumable {
    key = 'ilyko',
    set = 'Planet',
    pos = { x = 0, y = 0 },
    config = { extra = { hand_type = "mania_pkr_color_plus", levels = 1 } },
    loc_txt = {
        name = 'Ilyko',
        text = {
            [1] = 'Aumento de nivel',
            [2] = '{C:attention}Color+{}',
            [3] = '{C:red}+4{} multi y',
            [4] = '{C:blue}+30{} chips'
        }
    },
    cost = 3,
    unlocked = true,
    discovered = true,
    atlas = 'ilyko',
    use = function(self, card, area, copier)
        update_hand_text({ sound = 'button', volume = 0.7, pitch = 0.8, delay = 0.3 },
            { handname = localize('mania_pkr_color_plus', 'poker_hands'), 
              chips = G.GAME.hands['mania_pkr_color_plus'].chips, 
              mult = G.GAME.hands['mania_pkr_color_plus'].mult, 
              level = G.GAME.hands['mania_pkr_color_plus'].level })
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
        level_up_hand(card, "mania_pkr_color_plus", true, 1)
        update_hand_text({sound = 'button', volume = 0.7, pitch = 1.1, delay = 0}, 
            {handname=localize('mania_pkr_color_plus', 'poker_hands'), 
             chips = G.GAME.hands['mania_pkr_color_plus'].chips, 
             mult = G.GAME.hands['mania_pkr_color_plus'].mult, 
             level=G.GAME.hands['mania_pkr_color_plus'].level})
        delay(1.3)
    end,
    can_use = function(self, card) return true end
}