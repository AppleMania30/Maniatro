return {
    descriptions = {
        -- Jokers
        Joker = {
            j_mania_apple = {
                name = 'Manzana verde',
                text = {
                    'Si juegas exactamente {C:attention}5{} cartas,',
                    'ganas {C:money}+3${} y {C:mult}+5{} multi por esa mano.'
                }
            },
            j_mania_apple_plus = {
                name = 'Granny Smith',
                text = {
                    'Si la mano jugada es un {C:green}#1#{}, añade',
                    'una {C:green,E:1}carta ácida{} a tu mano.',
                    '{C:inactive}El tipo de mano cambia cada ronda.'
                }
            },
            j_mania_fructifero = {
                name = 'Comodín fructífero',
                text = {
                    '{C:mult}+3{} multi por cada',
                    'carta jugada con el palo',
                    'de {C:green}Manzana{} cuando anota.'
                }
            },
            j_mania_ushanka = {
                name = 'Comodín invernal',
                text = {
                    'Obtienes {C:dark_edition}+1{} espacio de Joker',
                    'pero tu mano se reduce en {C:red}-1{} carta'
                }
            },
            j_mania_ushanka_des = {
                name = 'Ushanka desgastado',
                text = {
                    'Cada {C:attention}4{} rondas, hay un {C:green,E:1}25%{} de probabilidad',
                    'de conseguir {C:dark_edition}+1{} espacio para Jokers.',
                    '{C:inactive}Rondas: {C:attention}#1#/4{}'
                }
            },
            j_mania_xifox = {
                name = 'Xifox',
                text = {
                    '{X:mult,C:white}X2{} multi por cada {C:attention}7{} que puntúe.'
                }
            },
            j_mania_xifox_des = {
                name = 'Xifox desgastado',
                text = {
                    'Si juegas un {C:attention}7{}, hay un {C:green,E:1}10%{} de',
                    'probabilidad de hacerlo {C:dark_edition}policromo{}.'
                }
            },
            j_mania_net = {
                name = 'NET',
                text = {
                    'Si la mano jugada tiene exactamente {C:purple}tres palos{} distintos,',
                    ' NET dará {X:chips,C:white} X2 {} chips.'
                }
            },
            j_mania_mun = {
                name = 'Insomnio',
                text = {
                    '{X:mult,C:white}X#1#{} multi',
                    'Al comenzar una ronda, tiene {C:green,E:1}50%{} de ganar {X:mult,C:white}+0.5X{}.',
                    'Si falla, se destruye.'
                }
            },
            j_mania_proto = {
                name = 'Proto',
                text = {
                    'Por cada ronda, copia la habilidad',
                    'de un {C:attention}Joker aleatorio{}.',
                    'Copiando: {C:attention}#1#{}'
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
                    'Cualquier carta de {C:spades}picas{} jugada',
                    'tiene un {C:green,E:1}25%{} de probabilidad de retriggearse.',
                    'Si acierta, lo vuelve a intentar en la misma carta.'
                }
            },
            j_mania_jolteon = {
                name = 'Jolteon',
                text = {
                    'Las cartas jugadas con el palo de {C:diamonds}Diamantes{} tienen:',
                    '{C:green}25%{} de probabilidad de dar {C:blue}+1{} mano',
                    '{C:green}60%{} de probabilidad de {C:attention}copiarse{} a la mano',
                    '{C:green}60%{} de probabilidad de {C:red}destruirse{}'
                }
            },
            j_mania_loss = {
                name = 'Loss',
                text = {
                    'Si la mano jugada es {C:attention}Loss{},',
                    'gana {X:mult,C:white}X3{} multi.'
                }
            },
            j_mania_obituary = {
                name = 'Obituary',
                text = {
                    'Cada {C:attention}As{} o {C:attention}2{} jugado dará {C:mult}+4{} multi.'
                }
            },
            j_mania_amongla = {
                name = 'Amongla',
                text = {
                    '{X:mult,C:white}X#1#{} multi',
                    '{C:green,E:1}0.125%{} de probabilidad',
                    'de cerrar el juego.'
                }
            },
            j_mania_amongla_des = {
                name = 'Amongla desgastado',
                text = {
                    '{X:mult,C:white}X#1#{} multi',
                    '{C:green,E:1}25%{} de probabilidad',
                    'de cerrar el juego.'
                }
            },
            j_mania_arthur_honor = {
                name = 'Red Dead Redemption II',
                text = {
                    'Si ganas la ronda en tu primer intento, {C:mult}+15{} multi',
                    'Si usas más de un intento, {C:red}-5{} multi al acabar de la ronda.',
                    'Actual: {C:mult}+#1#{} multi'
                }
            },
            j_mania_minion_pigs = {
                name = 'Minion Pig',
                text = {
                    'Por cada {C:green}Joker de rareza común{}',
                    'adquirido, este Joker obtiene',
                    '{C:red}+#1#{} multi.',
                    'Actual: {C:red}+#2#{} multi'
                }
            },
            j_mania_ale = {
                name = 'Ale',
                text = {
                    'Cada vez que juegas una mano, hay una probabilidad',
                    'del {C:green,E:1}50%{} de darte {C:blue}+50{} chips o quitarte {C:red}-50{} chips.'
                }
            },
            j_mania_bima = {
                name = 'Bima',
                text = {
                    'Si la mano jugada contiene',
                    '{C:attention}dos ases{}, gana {X:mult,C:white}+0.5X{} multi',
                    '{C:inactive}(Actual: {X:mult,C:white}X#1#{C:inactive})'
                }
            },
            j_mania_julio = {
                name = 'Julio',
                text = {
                    '{C:spectral}+#1#{} multi',
                    'Cada {C:spectral}4 manos{} jugadas,',
                    '{X:dark_edition,C:white}^2{} multi',
                    '{C:inactive}Manos: {C:spectral}#2#/4'
                }
            },
            j_mania_box = {
                name = 'Caja vacía',
                text = {
                    '. . .',
                    '{C:spectral}#1#/4',
                }
            },
            j_mania_nauiyo = {
                name = 'Nauiyo',
                text = {
                    '{X:mult,C:white}+0.2X{} por cada carta más en tu baraja,',
                    '{X:mult,C:white}-0.2X{} por cada carta menos en tu baraja.',
                    'Actual: {X:mult,C:white}X#1#{} multi',
                }
            },
            j_mania_tablet = {
                name = 'Tablet',
                text = {
                    'Si repites el mismo {C:purple}tipo de mano{} en dos jugadas seguidas,',
                    'el multiplicador pasa a {X:mult,C:white}X2.5{} y aumenta',
                    '{X:mult,C:white}+0.5X{} por cada repetición adicional.',
                    'Actual: {X:mult,C:white}X#1#{} multi'
                }
            },
            j_mania_espejo = {
                name = 'Espejo',
                text = {
                    'Cada {C:attention}4 rondas{}, crea una copia',
                    'del último Joker vendido.',
                    '{C:inactive}Último vendido: {C:attention}#1#{}',
                    '{C:inactive}Rondas restantes: {C:attention}#2#{}'
                }
            },
            j_mania_rufino = {
                name = 'Rufino',
                text = {
                    '{C:red}+#1#{} multi por cada {C:purple}consumible{} usado.',
                    'Actual: {C:red}+#2#{} multi'
                }
            },
            j_mania_pisu = {
                name = 'Pisu',
                text = {
                    'Por cada {C:dark_edition}gato{} que tengas',
                    'comprado, {X:chips,C:white}+2X{} chips.',
                    'Actual: {X:chips,C:white}X#1#{}'
                }
            },
            j_mania_evil_pisu = {
                name = 'EVIL Pisu',
                text = {
                    '{X:mult,C:white}X#1#{} multi',
                    'Aumenta {X:mult,C:white}+0.01X{} por',
                    'cada segundo transcurrido.',
                }
            },
            j_mania_sappho = {
                name = 'Sappho',
                text = {
                    '{X:mult,C:white}X#1#{} multi si la mano jugada',
                    'no contiene ninguna {C:purple}figura.{}'
                }
            },
            j_mania_mia = {
                name = 'Mia',
                text = {
                    'Si ganas la ronda sin hacer ningún descarte,',
                    'gana {C:chips}+25{} chips permanentes.',
                    'Si descartas, perderá todo el progreso.',
                    'Actual: {C:chips}+#1#{} chips'
                }
            },
            j_mania_galileo = {
                name = 'Galileo',
                text = {
                    'Cuando usas una {C:planet}carta planetaria{}, hay un {C:green,E:1}50%{} de ',
                    'probabilidad de que este Joker gane {X:mult,C:white}+0.5X{} multi.',
                    'Solo aplica el multiplicador si la mano jugada es un {C:attention}color{}.',
                    '{C:inactive}Actual: {X:mult,C:white}X#1#'
                }
            },
            j_mania_pompo = {
                name = 'Pompo',
                text = {
                    'Por cada {C:purple}#3# consumibles{} usados, gana {C:green}+1!{} multi',
                    'Actual: {C:green}#1#!{} = {C:red}+#2#{} multi'
                }
            },
            j_mania_blue = {
                name = 'Blue',
                text = {
                    'Sin {C:attention}Luna{}: {C:red}+#1#{} multi por espacio',
                    'de consumible vacío.',
                    'Con {C:attention}Luna{}: {X:blue,C:white}X#2#{} fichas'
                }
            },
            j_mania_luna = {
                name = 'Luna',
                text = {
                    'Sin {C:attention}Blue{}: {C:blue}+50{} fichas por',
                    'consumible que tengas.',
                    'Con {C:attention}Blue{}: {X:red,C:white}X#2#{} multi'
                }
            },
            j_mania_tortuga = {
                name = 'Tortuga',
                text = {
                    '{C:inactive}No hace nada.{}'
                }
            },
            j_mania_spamton = {
                name = 'Gafas de Spamton',
                text = {
                    'Gana {X:mult,C:white}+1X{} multi por cada Joker',
                    'vendido durante una ronda.',
                    'Actual: {X:mult,C:white}X#1#{} multi'
                }
            },
            j_mania_tenna = {
                name = 'Mr. (Ant)Tenna',
                text = {
                    'Todo lo que hay en la tienda',
                    'tiene un {C:green,E:1}50%{} de descuento.'
                }
            },
            j_mania_balatro_tomorrow = {
                name = 'Balatro Tomorrow',
                text = {
                    'Gana {X:chips,C:white}+0.25X{} chips por cada ronda ganada.',
                    'Actual: {X:chips,C:white}X#1#{} chips',
                }
            },
            j_mania_determination = {
                name = 'Determinación',
                text = {
                    'Este Joker aplica {X:mult,C:white}X#1#{} multi.',
                    'Cuantas más manos juegues, más fuerte se vuelve.',
                    '{C:inactive}Manos: {C:attention}#2#/#3#{}  |||  Nivel: {C:attention}#4#{}'
                }
            },
            j_mania_weezer = {
                name = 'Weezer',
                text = {
                    'Este Joker se duplica cada 3 rondas.',
                    'Por cada {C:blue}Weezer{} repetido, ganará {X:mult,C:white}+0.5X{} multi.',
                    'Actual: {X:mult,C:white}X#1#{} multi | Rondas: {C:attention}#2#/3{}'
                }
            },
            j_mania_pride = {
                name = 'Pride',
                text = {
                    'Gana {C:mult}+69{} multi por cada carta',
                    '{C:dark_edition}policromo{} que poseas.',
                    '{C:inactive}Actual: {C:mult}+#1#{} multi'
                }
            },
            j_mania_parabettle = {
                name = 'Parabettle',
                text = {
                    'Por cada {C:attention}#2#{} descartes,',
                    'gana {C:chips}+25{} fichas permanentes.',
                    '{C:inactive}Actual: {C:chips}+#1#{C:inactive} chips',
                }
            },
            j_mania_ludopatia = {
                name = 'Ludopatía',
                text = {
                    'Al final de cada mano,',
                    'gana {C:chips}+15{} chips y {C:mult}+5{} multi por cada',
                    '{C:attention}Símbolo{} que poseas.',
                    '{C:inactive}(Símbolos: #1#)',
                    '{C:mult}+#2#{} Multi | {C:chips}+#3#{} Chips'
                }
            },
            j_mania_euro = {
                name = 'Euro',
                text = {
                    '{C:money}+1${} por cada mano jugada.'
                }
            },
            j_mania_tributario = {
                name = 'Comodín tributario',
                text = {
                    'Si tienes menos de {C:money}$#1#{}, este Joker',
                    'te dará {C:money}+#2#${} por cada mano jugada.',
                    'Si tienes más, no tendrá efecto.'
                }
            },
            j_mania_armero = {
                name = 'Comodín armero',
                text = {
                    'Al inicio de cada ciega, crea {C:attention}un cartucho de escopeta.{}',
                    'Usar {C:attention}un cartucho de escopeta{} aumenta el {X:mult,C:white}Xmulti{} del Joker.',
                    'Al jugar una mano con cartuchos ya cargados, el Joker se reinicia.',
                    '{C:inactive}(Actualmente: {X:mult,C:white}X#1#{C:inactive} multi)'
                }
            },
            j_mania_pendrive = {
                name = 'Pendrive',
                text = {
                    'Por cada minuto, este dará {C:blue}+5{} chips.',
                    'Alcanza un límite de hasta {C:blue}100{} chips.',
                    'Actual: {C:blue}+#1#{} chips'
                }
            },
            j_mania_lata = {
                name = 'Lata de cerveza',
                text = {
                    'Empieza con {C:mult}+50{} multi.',
                    'Pierde {C:red}-5{} multi por cada',
                    '{C:attention}mano{} jugada.',
                    '{C:inactive}Actual: {C:mult}+#1#{} multi'
                }
            },
            j_mania_smoker = {
                name = 'Paquete de cigarros',
                text = {
                    'Al final de cada ronda:',
                    'Si tienes dinero acumulado, pierdes {C:money}-1${}',
                    'y este gana {C:mult}+3{} multi',
                    '{C:inactive}Actual: {C:mult}+#1#{} multi'
                }
            },
            j_mania_pocket_pebbles = {
                name = 'Piedras de bolsillo',
                text = {
                    'Si tienes {C:attention}90%{} o más chips',
                    'necesarias y {C:red}0 manos{} restantes,',
                    '{C:red}se destruye{} y {C:green}ganas{} la ronda.'
                }
            },
            j_mania_medalla_yokai = {
                name = 'Medalla Yo-kai',
                text = {
                    'Cuando uses un {C:purple}consumible{}, crea otro',
                    'del mismo tipo y lo añade a tu inventario.'
                }
            },
            j_mania_diedrico = {
                name = 'Diédrico',
                text = {
                    'Una mano cuenta como {C:attention}dos{} manos.'
                }
            },
            j_mania_frutos_bosque = {
                name = 'Frutos del bosque',
                text = {
                    '{C:blue}+30{} chips o {C:mult}+15{} multi.'
                }
            },
            j_mania_bola8 = {
                name = 'Bola 8 Mágica',
                text = {
                    'Durante 8 rondas, este Joker dará {X:mult,C:white}X2.5{} multi.',
                    'Faltan {C:attention}#1#{} rondas.'
                }
            },
            j_mania_cotton = {
                name = 'Nuevo comienzo',
                text = {
                    'Al final de cada ronda:',
                    'Destruye {C:spectral}un Joker{} al azar',
                    'y gana {X:chips,C:white}+0.5X{} chips',
                    'Actual: {X:chips,C:white}X#1#{} chips',
                }
            },
            j_mania_nira = {
                name = 'Nira',
                text = {
                    '{X:dark_edition,C:white}^#1#{} multi',
                    'Si la mano jugada solo contiene {C:hearts}corazones{},',
                    'aumenta {X:dark_edition,C:white}+0.2^{} multi.'
                }
            },
            j_mania_matkrov = {
                name = 'Matkrov',
                text = {
                    'Cada {C:red}Joker raro{} que tengas',
                    'dará {X:chips,C:white}X5{} chips.',
                }
            },
            j_mania_drokstav = {
                name = 'Drokstav',
                text = {
                    'Al acabar la mano, crea {C:dark_edition}una carta mejorada aleatoria{}',
                    'y la añade directamente a tu mano.'
                }
            },
            j_mania_letko = {
                name = 'Letko',
                text = {
                    'Aplica {X:green,C:white}N!{} multi basado en el número',
                    'de cartas jugadas en tu {C:attention}primera mano{}.',
                    'Actual: {X:green,C:white}X#1#{} multi',
                }
            },
            j_mania_fireball = {
                name = 'Fireball',
                text = {
                    'Cada carta jugada tiene un {C:green,E:1}25%{} de',
                    'probabilidad de {C:attention}quintuplicar{} sus chips base.'
                }
            },
            j_mania_onthebeat = {
                name = 'On The Beat',
                text = {
                    'Gana {C:mult}+#1#{} multi basado en el',
                    '{C:attention}volumen principal del juego{}.',
                    '{C:inactive}(Volumen actual: #2#%)'
                }
            },
            j_mania_freckles = {
                name = 'Freckles',
                text = {
                    'Da {X:mult,C:white}X4{} multi si la velocidad',
                    'del juego está a {C:attention}X1{}.'
                }
            },
            j_mania_lanzaguisantes = {
                name = 'Goofy ahh Peashooter',
                text = {
                    '{C:blue}+#1#{} chips.',
                    'Aumenta {C:blue}+10{} chips cada mano jugada.',
                    '{C:inactive}Se reinicia al final de la ronda.{}',
                }
            },
        },
        
        -- Consumables (Tarot, Spectral, Symbols)
        Tarot = {
            c_mania_acidity = {
                name = 'La acidez',
                text = {
                    'Mejora {C:attention}2 cartas{}',
                    'seleccionadas a {C:attention}Carta ácida{}'
                }
            },
            c_mania_sweetness = {
                name = 'La dulzura',
                text = {
                    'Mejora {C:attention}2 cartas{}',
                    'seleccionadas a {C:attention}Carta dulce{}'
                }
            },
            c_mania_manzana = {
                name = 'La manzana',
                text = {
                    'Mejora {C:attention}3 cartas{}',
                    'seleccionadas a {C:green}Manzanas{}'
                }
            },
        },
        
        Spectral = {
            c_mania_vitamina = {
                name = 'Vitamina',
                text = {
                    'Agrega un {C:green}sello cítrico{}',
                    'a {C:attention}1{} carta seleccionada',
                    'de tu mano.'
                }
            },
            c_mania_aditivo = {
                name = 'Aditivo',
                text = {
                    'Agrega {C:dark_edition}cítrico{} a {C:attention}un{} comodín al azar,',
                    'pero destruye {C:attention}otro{} comodín al azar.'
                }
            },
        },
        
        simbolos = {
            c_mania_cerezas = {
                name = 'Cerezas',
                text = {
                    '{C:green}Consumir:{} {C:money}+2${}',
                    '{C:green}Mantener:{} Cada {C:attention}2{} que',
                    'puntúe da {C:red}+2{} multi'
                }
            },
            c_mania_limon = {
                name = 'Limones',
                text = {
                    '{C:green}Consumir:{} {C:money}+2${}',
                    '{C:green}Mantener:{} Cada carta de',
                    '{C:attention}Diamantes{} da {C:money}+1${}'
                }
            },
            c_mania_treboles = {
                name = 'Tréboles',
                text = {
                    '{C:green}Consumir:{} {C:money}+3${}',
                    '{C:green}Mantener:{} Cada carta de',
                    '{C:attention}Tréboles{} da {C:red}+3{} multi'
                }
            },
            c_mania_campanas = {
                name = 'Campanas',
                text = {
                    '{C:green}Consumir:{} {C:money}+3${}',
                    '{C:green}Mantener:{} {C:attention}Reposiciones{}',
                    '{C:attention}gratis{} al final de la ronda.'
                }
            },
            c_mania_diamantes = {
                name = 'Diamantes',
                text = {
                    '{C:green}Consumir:{} {C:money}+5${}',
                    '{C:green}Mantener:{} Cada carta de',
                    '{C:attention}Diamantes{} da {X:mult,C:white}X1.5{} multi'
                }
            },
            c_mania_monedas = {
                name = 'Monedas',
                text = {
                    '{C:green}Consumir:{} {C:money}+5${}',
                    '{C:green}Mantener:{} {C:money}+5${} al',
                    'final de cada ronda.'
                }
            },
            c_mania_sietes = {
                name = 'Sietes',
                text = {
                    '{C:green}Consumir:{} {C:money}+7${}',
                    '{C:green}Mantener:{} Cada {C:attention}7{}',
                    'jugado da {X:mult,C:white}X2.5{} multi'
                }
            },
        },
        
        municion = {
            c_mania_shell = {
                name = 'Cartucho de escopeta',
                text = {
                    'Aumenta {X:mult,C:white}+2.25X{} multi al {C:attention}Comodín armero{}',
                }
            },
        },
        
        Planet = {
            c_mania_citra = {
                name = 'Citra',
                text = {
                    'Aumento de nivel',
                    '{C:attention}Loss{}',
                    '{C:red}+3{} multi y',
                    '{C:blue}+25{} chips'
                }
            },
        },
        
        -- Enhancements
        Enhanced = {
            m_mania_citrico = {
                name = 'Carta ácida',
                text = {
                    '{C:red}+20{} multi pero {C:money}-1${}'
                }
            },
            m_mania_dulce = {
                name = 'Carta dulce',
                text = {
                    '{C:blue}+50{} fichas pero {C:red}-1{} descarte'
                }
            },
        },
        
        -- Editions
        Edition = {
            e_mania_citrico = {
                name = 'Cítrico',
                text = {
                    'Si tienes {C:money}15${} o más:',
                    '{X:mult,C:white}X2{} multi',
                    '{X:chips,C:white}X2{} chips',
                    'Equilibra {C:blue}chips{} y {C:mult}multi{}'
                }
            },
            e_mania_iridiscente = {
                name = 'Iridiscente',
                text = {
                    'Multi {X:mult,C:white}X2{} ',
                    'Chips {X:chips,C:white}X2{}',
                    'Multi {X:dark_edition,C:white}^1.5{} ',
                    'Chips {X:dark_edition,C:white}^1.5{}',
                    'Multi {X:black,C:red}^^1.2{}',
                    'Chips {X:black,C:blue}^^1.2{}',
                    '{X:money,C:white}X5${}',
                }
            },
        },
        -- Decks
        Back = {
            b_mania_protodeck = {
                name = "Baraja programadora",
                text = {
                    "Empiezas con un",
                    "{C:attention}Proto{} {C:dark_edition}Eterno{}"
                }
            },
        },
        -- Vouchers
        Voucher = {
            v_mania_todoalrojo = {
                name = 'Todo al rojo',
                text = {
                    'Da {X:mult,C:white}X#1#{} multi',
                    'por el resto de la partida.'
                }
            },
            v_mania_jackpot = {
                name = 'Jackpot',
                text = {
                    'Da {X:dark_edition,C:white}^#1#{} multi',
                    'por el resto de la partida.'
                }
            },
        },
        -- Tags
        Tag = {
            tag_mania_citrica = {
                name = 'Etiqueta cítrica',
                text = {
                    "El siguiente comodín de la tienda",
                    "de edición base es {C:green}gratuito{} y",
                    "se convierte en {C:dark_edition}cítrico{}"
                }
            },
        },
        -- Seals
        Other = {
            mania_sellocitrico_seal = {
                name = 'Sello cítrico',
                text = {
                    'Reactiva esta carta {C:attention}2{}',
                    'veces pero {C:money}-1${}'
                }
            },
            p_mania_booster_maniatro = {
                name = 'Semillas de manzanas',
                text = {
                    "{C:green}¡Elige un joker de 3 de la edición Maniatro!{}"
                },
                group_name = "¡Planta tus semillas!"
            },
            p_mania_booster_maniatro2 = {
                name = 'Semillas de tomates',
                text = {
                    "{C:red}¡Elige un joker de 4 de la edición Maniatro!{}"
                },
                group_name = "¡Planta tus semillas!"
            },
            p_mania_booster_maniatro3 = {
                name = 'Semillas de arándanos',
                text = {
                    "{C:spectral}¡Elige un joker de 5 de la edición Maniatro!{}"
                },
                group_name = "¡Planta tus semillas!"
            },
            p_mania_booster_maniatro4 = {
                name = 'Semillas de sandías',
                text = {
                    "{C:uncommon}¡Elige 2 jokers de 7 de la edición Maniatro!{}"
                },
                group_name = "¡Planta tus semillas!"
            },
        },
    },
    misc = {
        -- Suits
        suits_plural = {
            mania_applesuit = 'Manzanas',
        },
        suits_singular = {
            mania_applesuit = 'Manzana',
        },
        
        -- Poker Hands
        poker_hands = {
            mania_pkr_perdida = 'Loss',
        },
        poker_hand_descriptions = {
            mania_pkr_perdida = {
                'Una mano que contiene un As y tres 2s.'
            },
        },
        
        -- Dictionary
        dictionary = {
            k_mania_maniatromod = 'Jokers Maniatro',
        },
        
        labels = {
            mania_citrico = 'Cítrico',
            mania_iridiscente = 'Iridiscente',
            mania_sellocitrico_seal = 'Sello cítrico',
            mania_simbolos = 'Símbolos',
        },
        
        -- Collabs (if needed for mod info)
        collabs = {
            Maniatro = {
                "Mod creado por AppleMania",
                "¡Gracias por jugar!"
            }
        },
        
        -- Additional v_text for vouchers display
        v_text = {
            ch_c_all_eternal = {
                "Todos los Jokers son {C:dark_edition}Eternos{}"
            },
        },
    },
}