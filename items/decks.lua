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