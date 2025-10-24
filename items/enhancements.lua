-- Citrico
SMODS.Atlas{
    key = 'citrico',
    path = 'citrico.png',
    px = 71,
    py = 95,
}

SMODS.Enhancement{
    key = 'citrico',
    loc_txt = {
        name = 'Carta ácida',
        text = {
            '{C:red}+20{} multi pero {C:money}-1${}'
        }
    },
    atlas = 'citrico',
    pos = {x = 0, y = 0},
    config = {
        mult = 20,
        extra = {
            dollars = 1
        }
    },
    any_suit = false,
    replace_base_card = false,
    no_rank = false,
    no_suit = false,
    always_scores = false,
    unlocked = true,
    discovered = true,
    no_collection = false,

    calculate = function(self, card, context)
        if context.main_scoring and context.cardarea == G.play then
            return {
                dollars = -lenient_bignum(card.ability.extra.dollars)
            }
        end
    end
}

-- Carta Dulce
SMODS.Atlas{
    key = 'dulce',
    path = 'dulce.png',
    px = 71,
    py = 95,
}

SMODS.Enhancement{
    key = 'dulce',
    loc_txt = {
        name = 'Carta dulce',
        text = {
            '{C:blue}+50{} fichas pero {C:red}-1{} descarte'
        }
    },
    atlas = 'dulce',
    pos = {x = 0, y = 0},
    config = {
        chips = 50,
        extra = {
            discards = 1
        }
    },
    any_suit = false,
    replace_base_card = false,
    no_rank = false,
    no_suit = false,
    always_scores = false,
    unlocked = true,
    discovered = true,
    no_collection = false,

    calculate = function(self, card, context)
        if context.main_scoring and context.cardarea == G.play then
            if G.GAME.current_round.discards_left > 0 then
                ease_discard(-card.ability.extra.discards)
            end
            return {
                chips = card.ability.chips
            }
        end
    end
}