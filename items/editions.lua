-- Citrico
SMODS.Shader{
    key = 'citrico',
    path = 'citrico.fs',
}

SMODS.Sound{
    key = 'bite',
    path = 'bite.ogg',
}

SMODS.Edition {
    key = 'citrico',
    shader = 'citrico',
    config = {
        x_mult = 2,
        x_chips = 2
    },
    in_shop = true,
    weight = 33,
    extra_cost = 2,
    apply_to_float = false,
    badge_colour = HEX('78d704'),
    sound = { sound = "mania_bite", per = 1.2, vol = 1.0 },
    disable_shadow = false,
    disable_base_shader = false,
    loc_txt = {
        name = 'Citrico',
        label = 'Citrico',
        text = {
            [1] = 'Si tienes {C:money}15${} o más:',
            [2] = '{X:mult,C:white}X2{} multi',
            [3] = '{X:chips,C:white}X2{} chips',
            [4] = 'Equilibra {C:blue}chips{} y {C:mult}multi{}'
        }
    },
    unlocked = true,
    discovered = true,
    no_collection = false,
    get_weight = function(self)
        return G.GAME.edition_rate * self.weight
    end,
  
    calculate = function(self, card, context)
        if G.GAME.dollars < to_big(15) then
            return nil
        end
        
        if context.pre_joker or (context.main_scoring and context.cardarea == G.play) then
            return { x_mult = card.edition.x_mult, x_chips = card.edition.x_chips, balance = true }
        end
    end
}
-- Iridiscente
SMODS.Shader{
    key = 'allinone',
    path = 'allinone.fs',
}

SMODS.Edition {
    key = 'iridiscente',
    shader = 'allinone',
    config = {
        x_mult = 2,
        x_chips = 2,
        e_mult = 1.5,
        e_chips = 1.5,
        hypermult_n = 1.2,
        hypermult_arrows = 2,
        hyperchips_n = 1.2,
        hyperchips_arrows = 2,
        dollars = 5,
        dollars_mult = true   
    },
    in_shop = true,
    weight = 5,
    extra_cost = 10,
    apply_to_float = true,
    badge_colour = HEX('c468a7'),
    sound = { sound = "polychrome1", per = 1.2, vol = 0.4 },
    disable_shadow = false,
    disable_base_shader = false,
    loc_txt = {
        name = 'Iridiscente',
        label = 'Iridiscente',
        text = {
            [1] = 'Multi {X:mult,C:white}X2{} ',
            [2] = 'Chips {X:chips,C:white}X2{}',
            [3] = 'Multi {X:dark_edition,C:white}^1.5{} ',
            [4] = 'Chips {X:dark_edition,C:white}^1.5{}',
            [5] = 'Multi {X:black,C:red}^^1.2{}',
            [6] = 'Chips {X:black,C:blue}^^1.2{}',
            [7] = '{X:money,C:white}X5${}',
        }
    },
    unlocked = true,
    discovered = true,
    no_collection = false,
    get_weight = function(self)
        return G.GAME.edition_rate * self.weight
    end,
  
    calculate = function(self, card, context)
        if context.pre_joker or (context.main_scoring and context.cardarea == G.play) then
            local money_bonus = 0
            
            if card.edition.dollars_mult then
                local current_money = G.GAME.dollars or 0
                money_bonus = lenient_bignum(current_money * (card.edition.dollars - 1))
            else
                money_bonus = lenient_bignum(card.edition.dollars)
            end
            
            return { 
                x_mult = card.edition.x_mult, 
                x_chips = card.edition.x_chips, 
                e_mult = card.edition.e_mult, 
                e_chips = card.edition.e_chips, 
                hypermult = {card.edition.hypermult_arrows, card.edition.hypermult_n}, 
                hyperchips = {card.edition.hyperchips_arrows, card.edition.hyperchips_n}, 
                dollars = money_bonus
            }
        end
    end
}