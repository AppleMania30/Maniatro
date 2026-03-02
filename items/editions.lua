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
    config = {},
    in_shop = true,
    weight = 5,
    extra_cost = 6,
    apply_to_float = true,
    badge_colour = HEX('c468a7'),
    sound = { sound = "polychrome1", per = 1.2, vol = 0.4 },
    disable_shadow = false,
    disable_base_shader = false,
    loc_txt = {
        name = 'Iridiscente',
        label = 'Iridiscente',
        text = {
            [1] = 'Se retriggea {C:attention}1{} vez por cada',
            [2] = '{C:blue}mano{} y {C:red}descarte{} restante',
        }
    },
    unlocked = true,
    discovered = true,
    no_collection = false,
    get_weight = function(self)
        return G.GAME.edition_rate * self.weight
    end,

    calculate = function(self, card, context)
        local retrigs = (G.GAME.current_round.hands_left or 0) + (G.GAME.current_round.discards_left or 0)
        if retrigs <= 0 then return end

        if context.other_card == card and (context.repetition or context.retrigger_joker_check) then
            return {
                message = localize('k_again_ex'),
                repetitions = retrigs,
                card = card,
            }
        end
    end
}