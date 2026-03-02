SMODS.Atlas{
    key = 'appleblind',
    path = 'appleblind.png',
    frames = 21,
    px = 34,
    py = 34,
    atlas_table = "ANIMATION_ATLAS"
}

SMODS.Blind {
    key = 'appleblind',
    loc_txt = {
        name = 'The Apple',
        text = {
            'All suits are debuffed',
            'except Apples.'
        }
    },
    boss = {min = 1, max = 10},
    boss_colour = HEX('77e330'),
    atlas = 'appleblind',
    pos = {x = 0, y = 0},
    dollars = 5,
    mult = 2,
    recalc_debuff = function(self, card, from_blind)
        if card.base.suit == 'Clubs' or card.base.suit == 'Diamonds' or card.base.suit == 'Hearts' or card.base.suit == 'Spades' then
            return true
        end
        return false
    end
}

SMODS.Atlas{
    key = 'wornblind',
    path = 'worn.png',
    frames = 21,
    px = 34,
    py = 34,
    atlas_table = "ANIMATION_ATLAS"
}

SMODS.Blind {
    key = 'wornblind',
    loc_txt = {
        name = 'The Worn',
        text = {
            'All Apple cards',
            'are debuffed.'
        }
    },
    boss = {min = 1, max = 10},
    boss_colour = HEX('c782c9'),
    atlas = 'wornblind',
    pos = {x = 0, y = 0},
    dollars = 5,
    mult = 2,
    recalc_debuff = function(self, card, from_blind)
        if card.base.suit == 'mania_applesuit' then
            return true
        end
        return false
    end
}