return {
    descriptions = {
        -- Jokers
        Joker = {
            j_mania_apple = {
                name = 'Green Apple',
                text = {
                    'If you play exactly {C:attention}5{} cards,',
                    'gain {C:money}+$3{} and {C:mult}+5{} mult for that hand.'
                }
            },
            j_mania_apple_plus = {
                name = 'Granny Smith',
                text = {
                    'If the played hand is a {C:green}#1#{}, add',
                    'a {C:green,E:1}sour card{} to your hand.',
                    '{C:inactive}Hand type changes each round.'
                }
            },
            j_mania_fructifero = {
                name = 'Fruitful Joker',
                text = {
                    '{C:mult}+3{} mult for each',
                    'played card with the',
                    '{C:green}Apple{} suit when scoring.'
                }
            },
            j_mania_ushanka = {
                name = 'Ushanka',
                text = {
                    'Gain {C:dark_edition}+1{} Joker slot',
                    'but your hand size is reduced by {C:red}-1{} card'
                }
            },
            j_mania_ushanka_des = {
                name = 'Worn Ushanka',
                text = {
                    'Every {C:attention}4{} rounds, there is a {C:green,E:1}25%{} chance',
                    'to gain {C:dark_edition}+1{} Joker slot.',
                    '{C:inactive}Rounds: {C:attention}#1#/4{}'
                }
            },
            j_mania_xifox = {
                name = 'Xifox',
                text = {
                    '{X:mult,C:white}X2{} mult for each {C:attention}7{} that scores.'
                }
            },
            j_mania_xifox_des = {
                name = 'Worn Xifox',
                text = {
                    'If you play a {C:attention}7{}, there is a {C:green,E:1}10%{}',
                    'chance to make it {C:dark_edition}polychrome{}.'
                }
            },
            j_mania_net = {
                name = 'NET',
                text = {
                    'If the played hand has exactly {C:purple}three different suits{},',
                    'NET gives {X:chips,C:white}X2{} chips.'
                }
            },
            j_mania_mun = {
                name = 'Insomnia',
                text = {
                    '{X:mult,C:white}X#1#{} mult',
                    'At the start of a round, has {C:green,E:1}50%{} chance to gain {X:mult,C:white}+0.5X{}.',
                    'If it fails, it is destroyed.'
                }
            },
            j_mania_proto = {
                name = 'Proto',
                text = {
                    'For each round, copy the ability',
                    'of a {C:attention}random Joker{}.',
                    'Copying: {C:attention}#1#{}'
                }
            },
            j_mania_fatal = {
                name = 'FATAL',
                text = {
                    '. . .'
                }
            },
            j_mania_ocean = {
                name = 'OCEAN',
                text = {
                    '. . .'
                }
            },
            j_mania_rollin = {
                name = "Keep Rollin'",
                text = {
                    'Any {C:spades}Spades{} card played',
                    'has a {C:green,E:1}25%{} chance to retrigger.',
                    'If successful, it tries again on the same card.'
                }
            },
            j_mania_jolteon = {
                name = 'Jolteon',
                text = {
                    'Played cards with the {C:diamonds}Diamonds{} suit have:',
                    '{C:green}25%{} chance to give {C:blue}+1{} hand',
                    '{C:green}60%{} chance to {C:attention}copy{} to hand',
                    '{C:green}60%{} chance to {C:red}destroy{} itself'
                }
            },
            j_mania_loss = {
                name = 'Loss',
                text = {
                    'If the played hand is {C:attention}Loss{},',
                    'gain {X:mult,C:white}X3{} mult.'
                }
            },
            j_mania_obituary = {
                name = 'Obituary',
                text = {
                    'Each {C:attention}Ace{} or {C:attention}2{} played gives {C:mult}+4{} mult.'
                }
            },
            j_mania_amongla = {
                name = 'Amongla',
                text = {
                    '{X:mult,C:white}X#1#{} mult',
                    '{C:green,E:1}0.125%{} chance',
                    'to close the game.'
                }
            },
            j_mania_amongla_des = {
                name = 'Worn Amongla',
                text = {
                    '{X:mult,C:white}X#1#{} mult',
                    '{C:green,E:1}25%{} chance',
                    'to close the game.'
                }
            },
            j_mania_arthur_honor = {
                name = 'Red Dead Redemption II',
                text = {
                    'If you win the round on your first try, {C:mult}+15{} mult',
                    'If you use more than one try, {C:red}-5{} mult at round end.',
                    'Current: {C:mult}+#1#{} mult'
                }
            },
            j_mania_minion_pigs = {
                name = 'Minion Pigs',
                text = {
                    'For each {C:green}Common Joker{}',
                    'acquired, this Joker gains',
                    '{C:red}+#1#{} mult.',
                    'Current: {C:red}+#2#{} mult'
                }
            },
            j_mania_ale = {
                name = 'Ale',
                text = {
                    'Each time you play a hand, there is a',
                    '{C:green,E:1}50%{} chance to give {C:blue}+50{} chips or remove {C:red}-50{} chips.'
                }
            },
            j_mania_bima = {
                name = 'Bima',
                text = {
                    'If the played hand contains',
                    '{C:attention}two aces{}, gain {X:mult,C:white}+0.5X{} mult',
                    '{C:inactive}(Current: {X:mult,C:white}X#1#{C:inactive})'
                }
            },
            j_mania_julio = {
                name = 'Julio',
                text = {
                    '{C:spectral}+#1#{} mult',
                    'Every {C:spectral}4 hands{} played,',
                    '{X:dark_edition,C:white}^2{} mult',
                    '{C:inactive}Hands: {C:spectral}#2#/4'
                }
            },
            j_mania_box = {
                name = 'Empty Box',
                text = {
                    '. . .',
                    '{C:spectral}#1#/4',
                }
            },
            j_mania_nauiyo = {
                name = 'Nauiyo',
                text = {
                    '{X:mult,C:white}+0.2X{} for each additional card in your deck,',
                    '{X:mult,C:white}-0.2X{} for each fewer card in your deck.',
                    'Current: {X:mult,C:white}X#1#{} mult',
                }
            },
            j_mania_tablet = {
                name = 'Tablet',
                text = {
                    'If you repeat the same {C:purple}hand type{} in two consecutive plays,',
                    'mult becomes {X:mult,C:white}X2.5{} and increases',
                    '{X:mult,C:white}+0.5X{} per additional repetition.',
                    'Current: {X:mult,C:white}X#1#{} mult'
                }
            },
            j_mania_rufino = {
                name = 'Rufino',
                text = {
                    '{C:red}+#1#{} mult for each {C:purple}consumable{} used.',
                    'Current: {C:red}+#2#{} mult'
                }
            },
            j_mania_pisu = {
                name = 'Pisu',
                text = {
                    'For each {C:dark_edition}cat{} you have',
                    'bought, {X:chips,C:white}+2X{} chips.',
                    'Current: {X:chips,C:white}X#1#{}'
                }
            },
            j_mania_evil_pisu = {
                name = 'EVIL Pisu',
                text = {
                    '{X:mult,C:white}X#1#{} mult',
                    'Increases {X:mult,C:white}+0.01X{} per',
                    'second elapsed.',
                }
            },
            j_mania_sappho = {
                name = 'Sappho',
                text = {
                    '{X:mult,C:white}X#1#{} mult if the played hand',
                    'contains no {C:purple}face cards.{}'
                }
            },
            j_mania_mia = {
                name = 'Mia',
                text = {
                    'If you win the round without discarding,',
                    'gain {C:chips}+25{} permanent chips.',
                    'If you discard, lose all progress.',
                    'Current: {C:chips}+#1#{} chips'
                }
            },
            j_mania_galileo = {
                name = 'Galileo',
                text = {
                    'When you use a {C:planet}Planet card{}, there is a {C:green,E:1}50%{}',
                    'chance for this Joker to gain {X:mult,C:white}+0.5X{} mult.',
                    'Only applies mult if the played hand is a {C:attention}Flush{}.',
                    '{C:inactive}Current: {X:mult,C:white}X#1#'
                }
            },
            j_mania_pompo = {
                name = 'Pompo',
                text = {
                    'For every {C:purple}#3# consumables{} used, gain {C:green}+1!{} mult',
                    'Current: {C:green}#1#!{} = {C:red}+#2#{} mult'
                }
            },
            j_mania_blue = {
                name = 'Blue',
                text = {
                    'Without {C:attention}Luna{}: {C:red}+#1#{} mult per empty',
                    'consumable slot.',
                    'With {C:attention}Luna{}: {X:blue,C:white}X#2#{} chips'
                }
            },
            j_mania_luna = {
                name = 'Luna',
                text = {
                    'Without {C:attention}Blue{}: {C:blue}+50{} chips per',
                    'consumable you have.',
                    'With {C:attention}Blue{}: {X:red,C:white}X#2#{} mult'
                }
            },
            j_mania_tortuga = {
                name = 'Turtle',
                text = {
                    '{C:inactive}Does nothing.{}'
                }
            },
            j_mania_spamton = {
                name = "Spamton's Glasses",
                text = {
                    'Gain {X:mult,C:white}+1X{} mult for each Joker',
                    'sold during a round.',
                    'Current: {X:mult,C:white}X#1#{} mult'
                }
            },
            j_mania_tenna = {
                name = 'Mr. (Ant)Tenna',
                text = {
                    'Everything in the shop',
                    'has a {C:green,E:1}50%{} discount.'
                }
            },
            j_mania_balatro_tomorrow = {
                name = 'Balatro Tomorrow',
                text = {
                    'Gain {X:chips,C:white}+0.25X{} chips per round won.',
                    'Current: {X:chips,C:white}X#1#{} chips',
                }
            },
            j_mania_determination = {
                name = 'Determination',
                text = {
                    'This Joker applies {X:mult,C:white}X#1#{} mult.',
                    'The more hands you play, the stronger it becomes.',
                    '{C:inactive}Hands: {C:attention}#2#/#3#{}  |||  Level: {C:attention}#4#{}'
                }
            },
            j_mania_weezer = {
                name = 'Weezer',
                text = {
                    'This Joker duplicates every 3 rounds.',
                    'For each repeated {C:blue}Weezer{}, gain {X:mult,C:white}+0.5X{} mult.',
                    'Current: {X:mult,C:white}X#1#{} mult | Rounds: {C:attention}#2#/3{}'
                }
            },
            j_mania_pride = {
                name = 'Pride',
                text = {
                    'Gain {C:mult}+69{} mult for each',
                    '{C:dark_edition}polychrome{} card you own.',
                    '{C:inactive}Current: {C:mult}+#1#{} mult'
                }
            },
            j_mania_parabettle = {
                name = 'Parabettle',
                text = {
                    'For every {C:attention}#2#{} discards,',
                    'gain {C:chips}+25{} permanent chips.',
                    '{C:inactive}Current: {C:chips}+#1#{C:inactive} chips',
                }
            },
            j_mania_ludopatia = {
                name = 'Gambling Addiction',
                text = {
                    'At the end of each hand,',
                    'gain {C:chips}+15{} chips and {C:mult}+5{} mult for each',
                    '{C:attention}Symbol{} you own.',
                    '{C:inactive}(Symbols: #1#)',
                    '{C:mult}+#2#{} Mult | {C:chips}+#3#{} Chips'
                }
            },
            j_mania_euro = {
                name = 'Euro',
                text = {
                    '{C:money}+$1{} per hand played.'
                }
            },
            j_mania_tributario = {
                name = 'Tax Joker',
                text = {
                    'If you have less than {C:money}$#1#{}, this Joker',
                    'gives you {C:money}+$#2#{} per hand played.',
                    'If you have more, it has no effect.'
                }
            },
            j_mania_armero = {
                name = 'Gunsmith Joker',
                text = {
                    'At the start of each blind, create {C:attention}a shotgun shell.{}',
                    'Using {C:attention}a shotgun shell{} increases this Joker\'s {X:mult,C:white}Xmult{}.',
                    'When playing a hand with shells already loaded, the Joker resets.',
                    '{C:inactive}(Currently: {X:mult,C:white}X#1#{C:inactive} mult)'
                }
            },
            j_mania_pendrive = {
                name = 'Flash Drive',
                text = {
                    'For every minute, this gives {C:blue}+5{} chips.',
                    'Reaches a limit of up to {C:blue}100{} chips.',
                    'Current: {C:blue}+#1#{} chips'
                }
            },
            j_mania_lata = {
                name = 'Beer Can',
                text = {
                    'Starts with {C:mult}+50{} mult.',
                    'Loses {C:red}-5{} mult for each',
                    '{C:attention}hand{} played.',
                    '{C:inactive}Current: {C:mult}+#1#{} mult'
                }
            },
            j_mania_smoker = {
                name = 'Cigarette Pack',
                text = {
                    'At the end of each round:',
                    'If you have accumulated money, lose {C:money}-$1{}',
                    'and this gains {C:mult}+3{} mult',
                    '{C:inactive}Current: {C:mult}+#1#{} mult'
                }
            },
            j_mania_pocket_pebbles = {
                name = 'Pocket Pebbles',
                text = {
                    'If you have {C:attention}90%{} or more of the required chips',
                    'and {C:red}0 hands{} remaining,',
                    'it {C:red}destroys itself{} and you {C:green}win{} the round.'
                }
            },
            j_mania_medalla_yokai = {
                name = 'Yo-kai Medal',
                text = {
                    'When you use a {C:purple}consumable{}, create another',
                    'of the same type and add it to your inventory.'
                }
            },
            j_mania_diedrico = {
                name = 'Dihedral',
                text = {
                    'One hand counts as {C:attention}two{} hands.'
                }
            },
            j_mania_frutos_bosque = {
                name = 'Forest Fruits',
                text = {
                    '{C:blue}+30{} chips or {C:mult}+15{} mult.'
                }
            },
            j_mania_bola8 = {
                name = 'Magic 8-Ball',
                text = {
                    'For 8 rounds, this Joker gives {X:mult,C:white}X2.5{} mult.',
                    '{C:attention}#1#{} rounds remaining.'
                }
            },
            j_mania_cotton = {
                name = 'New Beginning',
                text = {
                    'At the end of each round:',
                    'Destroy {C:spectral}a random Joker{}',
                    'and gain {X:chips,C:white}+0.5X{} chips',
                    'Current: {X:chips,C:white}X#1#{} chips',
                }
            },
            j_mania_nira = {
                name = 'Nira',
                text = {
                    '{X:dark_edition,C:white}^#1#{} mult',
                    'If the played hand only contains {C:hearts}Hearts{},',
                    'increase {X:dark_edition,C:white}+0.2^{} mult.'
                }
            },
            j_mania_matkrov = {
                name = 'Matkrov',
                text = {
                    'Each {C:red}Rare Joker{} you have',
                    'gives {X:chips,C:white}X5{} chips.',
                }
            },
            j_mania_drokstav = {
                name = 'Drokstav',
                text = {
                    'At the end of the hand, create {C:dark_edition}a random enhanced card{}',
                    'and add it directly to your hand.'
                }
            },
            j_mania_letko = {
                name = 'Letko',
                text = {
                    'Apply {X:green,C:white}N!{} mult based on the number',
                    'of cards played in your {C:attention}first hand{}.',
                    'Current: {X:green,C:white}X#1#{} mult',
                }
            },
        },
        
        -- Consumables (Tarot, Spectral, Symbols)
        Tarot = {
            c_mania_acidity = {
                name = 'The Acidity',
                text = {
                    'Enhances {C:attention}2 selected cards{}',
                    'to {C:attention}Sour Cards{}'
                }
            },
            c_mania_sweetness = {
                name = 'The Sweetness',
                text = {
                    'Enhances {C:attention}2 selected cards{}',
                    'to {C:attention}Sweet Cards{}'
                }
            },
            c_mania_manzana = {
                name = 'The Apple',
                text = {
                    'Enhances {C:attention}3 selected cards{}',
                    'to {C:green}Apples{}'
                }
            },
        },
        
        Spectral = {
            c_mania_vitamina = {
                name = 'Vitamin',
                text = {
                    'Add a {C:green}citrus seal{}',
                    'to {C:attention}1{} selected card',
                    'from your hand.'
                }
            },
            c_mania_aditivo = {
                name = 'Additive',
                text = {
                    'Add {C:dark_edition}citrus{} to {C:attention}one{} random joker,',
                    'but destroy {C:attention}another{} random joker.'
                }
            },
        },
        
        simbolos = {
            c_mania_cerezas = {
                name = 'Cherries',
                text = {
                    '{C:green}Consume:{} {C:money}+$2{}',
                    '{C:green}Hold:{} Each {C:attention}2{} that',
                    'scores gives {C:red}+2{} mult'
                }
            },
            c_mania_limon = {
                name = 'Lemon',
                text = {
                    '{C:green}Consume:{} {C:money}+$2{}',
                    '{C:green}Hold:{} Each',
                    '{C:attention}Diamond{} card gives {C:money}+$1{}'
                }
            },
            c_mania_treboles = {
                name = 'Clovers',
                text = {
                    '{C:green}Consume:{} {C:money}+$3{}',
                    '{C:green}Hold:{} Each',
                    '{C:attention}Club{} card gives {C:red}+3{} mult'
                }
            },
            c_mania_campanas = {
                name = 'Bells',
                text = {
                    '{C:green}Consume:{} {C:money}+$3{}',
                    '{C:green}Hold:{} One {C:attention}free',
                    '{C:attention}reroll{} at the end of the round'
                }
            },
            c_mania_diamantes = {
                name = 'Diamonds',
                text = {
                    '{C:green}Consume:{} {C:money}+$5{}',
                    '{C:green}Hold:{} Each',
                    '{C:attention}Diamond{} card gives {X:mult,C:white}X1.5{} mult'
                }
            },
            c_mania_monedas = {
                name = 'Coins',
                text = {
                    '{C:green}Consume:{} {C:money}+$5{}',
                    '{C:green}Hold:{} {C:money}+$5{} at the',
                    'end of each round'
                }
            },
            c_mania_sietes = {
                name = 'Sevens',
                text = {
                    '{C:green}Consume:{} {C:money}+$7{}',
                    '{C:green}Hold:{} Each {C:attention}7{}',
                    'played gives {X:mult,C:white}X2.5{} mult'
                }
            },
        },
        
        municion = {
            c_mania_shell = {
                name = 'Shotgun Shell',
                text = {
                    'Increases {X:mult,C:white}+2.25X{} mult to {C:attention}Gunsmith Joker{}',
                }
            },
        },
        
        Planet = {
            c_mania_citra = {
                name = 'Citra',
                text = {
                    'Level up',
                    '{C:attention}Loss{}',
                    '{C:red}+3{} mult and',
                    '{C:blue}+25{} chips'
                }
            },
        },
        
        -- Enhancements
        Enhanced = {
            m_mania_citrico = {
                name = 'Sour Card',
                text = {
                    '{C:red}+20{} mult but {C:money}-$1{}'
                }
            },
            m_mania_dulce = {
                name = 'Sweet Card',
                text = {
                    '{C:blue}+50{} chips but {C:red}-1{} discard'
                }
            },
        },
        
        -- Editions
        Edition = {
            e_mania_citrico = {
                name = 'Citrus',
                text = {
                    'If you have {C:money}$15{} or more:',
                    '{X:mult,C:white}X2{} mult',
                    '{X:chips,C:white}X2{} chips',
                    'Balance {C:blue}chips{} and {C:mult}mult{}'
                }
            },
            e_mania_iridiscente = {
                name = 'Iridescent',
                text = {
                    'Mult {X:mult,C:white}X2{} ',
                    'Chips {X:chips,C:white}X2{}',
                    'Mult {X:dark_edition,C:white}^1.5{} ',
                    'Chips {X:dark_edition,C:white}^1.5{}',
                    'Mult {X:black,C:red}^^1.2{}',
                    'Chips {X:black,C:blue}^^1.2{}',
                    '{X:money,C:white}X5${}',
                }
            },
        },
        
        -- Decks
        Back = {
            b_mania_protodeck = {
                name = "Programmer's Deck",
                text = {
                    "Start with a",
                    "{C:attention}Proto{} {C:dark_edition}Eternal{}"
                }
            },
        },
        
        -- Vouchers
        Voucher = {
            v_mania_todoalrojo = {
                name = 'All In',
                text = {
                    'Gives {X:mult,C:white}X#1#{} mult',
                    'for the rest of the run.'
                }
            },
            v_mania_jackpot = {
                name = 'Jackpot',
                text = {
                    'Gives {X:dark_edition,C:white}^#1#{} mult',
                    'for the rest of the run.'
                }
            },
        },

        -- Tags
        Tag = {
            tag_mania_citrica = {
                name = 'Citrus Tag',
                text = {
                    "The next base edition joker",
                    "in the shop is {C:green}free{} and",
                    "becomes {C:dark_edition}citrus{}"
                }
            },
        },
        
        -- Other
        Other = {
            mania_sellocitrico_seal = {
                name = 'Citrus Seal',
                text = {
                    'Retrigger this card {C:attention}2{}',
                    'times but {C:money}-$1{}'
                }
            },
            p_mania_booster_maniatro = {
                name = 'Apple Seeds',
                text = {
                    "{C:green}Choose 1 Joker from 3",
                    "of the Maniatro edition!{}"
                }
            },
            p_mania_booster_maniatro2 = {
                name = 'Tomato Seeds',
                text = {
                    "{C:red}Choose 1 Joker from 4",
                    "of the Maniatro edition!{}"
                }
            },
            p_mania_booster_maniatro3 = {
                name = 'Blueberry Seeds',
                text = {
                    "{C:spectral}Choose 1 Joker from 5",
                    "of the Maniatro edition!{}"
                }
            },
            p_mania_booster_maniatro4 = {
                name = 'Watermelon Seeds',
                text = {
                    "{C:uncommon}Choose 2 Jokers from 7",
                    "of the Maniatro edition!{}"
                }
            },
        },
    },
    misc = {
        -- Suits
        suits_plural = {
            mania_applesuit = 'Apples',
        },
        suits_singular = {
            mania_applesuit = 'Apple',
        },
        
        -- Poker Hands
        poker_hands = {
            mania_pkr_perdida = 'Loss',
        },
        poker_hand_descriptions = {
            mania_pkr_perdida = {
                'A hand containing one Ace and three 2s.'
            },
        },
        
        -- Dictionary
        dictionary = {
            k_mania_maniatromod = 'Maniatro Jokers',
            k_mania_booster_group = 'Plant your seeds!',
            b_mania_simbolos = 'Symbols',
            b_mania_municion = 'AMMO', 
        },
        
        labels = {
            mania_citrico = 'Citrus',
            mania_iridiscente = 'Iridescent',
            mania_sellocitrico_seal = 'Citrus Seal',
        },
    },
}