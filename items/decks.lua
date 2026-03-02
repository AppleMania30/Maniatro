-- Baraja Programadora
SMODS.Atlas{
    key = 'protodeck',
    path = 'protodeck.png',
    px = 71,
    py = 95,
}

SMODS.Back({
    key = "protodeck",
    loc_txt = {
        name = "Baraja programadora",
        text = {
            "Empiezas con un",
            "{C:attention}Proto{} {C:dark_edition}Eterno{}"
        }
    },
    atlas = "protodeck",
    pos = { x = 0, y = 0 },
    config = {},
    unlocked = true,
    discovered = true,
    
    apply = function(self, back)
        G.E_MANAGER:add_event(Event({
            func = function()
                local proto = create_card('Joker', G.jokers, nil, nil, nil, nil, 'j_mania_proto', 'protodeck')
                proto:set_eternal(true)
                proto:add_to_deck()
                G.jokers:emplace(proto)
                return true
            end,
            delay = 1
        }))
    end
})

-- Watermelon Deck
SMODS.Atlas{
    key = 'melondeck',
    path = 'waterdeck.png',
    px = 71,
    py = 95,
}

SMODS.Back({
    key = 'melondeck',
    loc_txt = {
        name = 'Watermelon Deck',
        text = {
            'A {C:blue}custom{} deck with',
            '{C:red}unique{} effects.'
        },
    },
    atlas = 'melondeck',
    pos = { x = 0, y = 0 },
    config = {
        extra = {
            play_size0 = 1
        },
    },
    unlocked = true,
    discovered = true,
    no_collection = false,

    apply = function(self, back)
        G.E_MANAGER:add_event(Event({
            func = function()
                for i = #G.playing_cards, 1, -1 do
                    if G.playing_cards[i]:is_suit('Diamonds') then
                        G.playing_cards[i]:remove()
                    end
                end
                G.GAME.starting_deck_size = #G.playing_cards
                return true
            end
        }))
        G.E_MANAGER:add_event(Event({
            func = function()
                for i = #G.playing_cards, 1, -1 do
                    if G.playing_cards[i]:is_suit('Clubs') then
                        G.playing_cards[i]:remove()
                    end
                end
                G.GAME.starting_deck_size = #G.playing_cards
                return true
            end
        }))
        G.E_MANAGER:add_event(Event({
            func = function()
                SMODS.change_play_limit(1)
                return true
            end
        }))
    end
})