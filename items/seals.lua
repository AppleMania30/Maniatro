-- Sello cítrico
SMODS.Atlas{
    key = 'sellocitrico',
    path = 'sticker.png',
    px = 71,
    py = 95,
}

SMODS.Seal {
    key = 'sellocitrico',
    loc_txt = {
        name = 'Sello cítrico',
        text = {
            'Reactiva esta carta {C:attention}2{}',
            'veces pero {C:money}-$1{}'
        }
    }, 
    badge_colour = HEX('25ac4d'),
    pos = { x = 0, y = 0 },
    config = {
        extra = {
            retrigger_times = 2,
            dollars = 1,
            trigger_count = 0,
            max_triggers = 3
        }
    },
    atlas = 'sellocitrico',
    unlocked = true,
    discovered = true,
    no_collection = false,
    
    calculate = function(self, card, context)
        -- Manejo de las reactivaciones
        if context.repetition and card.should_retrigger then
            return { repetitions = card.ability.seal.extra.retrigger_times }
        end
        
        -- Activación cuando la carta se juega o está en mano durante scoring
        if (context.main_scoring and context.cardarea == G.play) or 
           (context.cardarea == G.hand and context.main_scoring) then
            
            card.ability.seal.extra.trigger_count = card.ability.seal.extra.trigger_count + 1
            
            -- Si es la primera activación, marcar para reactivación
            if card.ability.seal.extra.trigger_count == 1 then
                card.should_retrigger = true
            end
            
            -- Si hemos completado todas las activaciones (inicial + 2 reactivaciones)
            if card.ability.seal.extra.trigger_count >= card.ability.seal.extra.max_triggers then
                SMODS.calculate_effect({dollars = -lenient_bignum(card.ability.seal.extra.dollars)}, card)
                card.should_retrigger = false
                card.ability.seal.extra.trigger_count = 0
            end
        end
    end
}