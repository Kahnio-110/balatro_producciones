--Hamtaro
SMODS.Atlas {
    key = 'hamha',
    path = 'hamha.png',
    px = 71,
    py = 95
}

SMODS.Joker {
    key = "hamha",
    config = {
        extra = {
            chips = 69,
            mult = 14
        }
    },
    loc_txt = {
        ['name'] = 'Hamha',
        ['text'] = {
            [1] = 'Cuando un {C:attention}rey{} y una {C:attention}reina{}',
            [2] = 'se juegan en la misma mano',
            [3] = 'dan {C:red}+14{} Mult y {C:blue}+69{} fichas'
        }
    },
    pos = {
        x = 0,
        y = 0
    },
    cost = 4,
    rarity = 1,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'hamha',

    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main then
            if ((function()
                    local rankCount = 0
                    for i, c in ipairs(context.scoring_hand) do
                        if c:get_id() == 12 then
                            rankCount = rankCount + 1
                        end
                    end

                    return rankCount >= 1
                end)() and (function()
                    local rankCount = 0
                    for i, c in ipairs(context.scoring_hand) do
                        if c:get_id() == 13 then
                            rankCount = rankCount + 1
                        end
                    end

                    return rankCount >= 1
                end)()) then
                return {
                    chips = card.ability.extra.chips,
                    extra = {
                        mult = card.ability.extra.mult
                    }
                }
            end
        end
    end
}

--Papyrus
SMODS.Atlas {
    key = 'papyrus',
    path = 'papyrus.png',
    px = 71,
    py = 95
}

SMODS.Joker {
    key = "papyrus",
    config = {
        extra = {
            mejora = 0
        }
    },
    loc_txt = {
        ['name'] = 'El gran Papyrus',
        ['text'] = {
            [1] = 'Gana {C:blue}+20{} fichas por cada {C:attention}mano{} jugada',
            [2] = 'sin repetir {C:attention}categorias{}',
            [3] = 'Si se juega una {C:attention}escalera{} se destruye',
            [4] = '{C:inactive}(Actualmente {}{C:blue}+#1#{}{C:inactive} fichas){}'
        }
    },
    pos = {
        x = 0,
        y = 0
    },
    cost = 4,
    rarity = 1,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'papyrus',

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mejora } }
    end,

    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main then
            if next(context.poker_hands["Pair"]) then
                card.ability.extra.mejora = (card.ability.extra.mejora) + 0
                return {
                    chips = card.ability.extra.mejora
                }
            elseif next(context.poker_hands["Straight"]) then
                return {
                    func = function()
                        card:start_dissolve()
                        return true
                    end,
                }
            else
                card.ability.extra.mejora = (card.ability.extra.mejora) + 20
                return {
                    message = "Mejora!",
                    extra = {
                        chips = card.ability.extra.mejora,
                        colour = G.C.CHIPS
                    }
                }
            end
        end
    end
}

--Foodfight
SMODS.Atlas {
    key = 'food',
    path = 'food.png',
    px = 71,
    py = 95

}

SMODS.Joker { --Detective MC Perro
    key = "food",
    config = {
        extra = {
            foodvar = 0,
            respect = 0
        }
    },
    loc_txt = {
        ['name'] = 'Detective MC Perro',
        ['text'] = {
            [1] = 'Cuando la {C:attention}ciega jefe{} es derrotada',
            [2] = 'crea un comodín de comida',
            [3] = '{C:inactive}(Debe haber espacio){}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 0,
        y = 0
    },
    display_size = {
        w = 71 * 1,
        h = 95 * 1
    },
    cost = 4,
    rarity = 1,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'food',

    calculate = function(self, card, context)
        if context.end_of_round and context.main_eval and G.GAME.blind.boss then
            return {
                func = function()
                    local created_joker = false
                    if #G.jokers.cards + G.GAME.joker_buffer < G.jokers.config.card_limit then
                        local created_joker = true
                        G.E_MANAGER:add_event(Event({
                            func = function()
                                local random_key = pseudorandom_element(
                                    { "j_ramen", "j_cavendish", "j_popcorn", "j_ice_cream", "j_egg", "j_turtle_bean",
                                        "j_selzer", "j_diet_cola", "j_gros_michel" },
                                    "seed")
                                local joker_card = SMODS.add_card({
                                    set = 'Joker',
                                    key = random_key
                                })
                                return true
                            end
                        }))

                        if created_joker then
                            card_eval_status_text(
                                context.blueprint_card or card,
                                'extra', nil, nil, nil,
                                { message = localize('k_plus_joker'), colour = G.C.BLUE }
                            )
                        end
                    end
                    return true
                end
            }
        end
    end
}

--
SMODS.Atlas {
    key = 'wosh',
    path = 'wosh.png',
    px = 71,
    py = 95
}

SMODS.Joker {
    key = "crash",
    config = {
        extra = {
            ignore = 0
        }
    },
    loc_txt = {
        ['name'] = 'Crash Bandicoot',
        ['text'] = {
            [1] = 'Si compras este {C:common}comodín{} voltea y revuelve',
            [2] = 'todos los {C:attention}comodines{}, al venderse crea',
            [3] = 'una {C:attention}copia{} de un {C:attention}comodín{} aleatorio'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 0,
        y = 0
    },
    display_size = {
        w = 71 * 1,
        h = 95 * 1
    },
    cost = 4,
    rarity = 1,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'wosh',
    in_pool = function(self, args)
        return (
                not args
                or args.source ~= 'buf' and args.source ~= 'jud' and args.source ~= 'rif'
                or args.source == 'sho' or args.source == 'rta' or args.source == 'sou' or args.source == 'uta' or args.source == 'wra'
            )
            and true
    end,

    calculate = function(self, card, context)
        if context.buying_card and context.card.config.center.key == self.key and context.cardarea == G.jokers then
            if #G.jokers.cards > 0 then
                for _, joker in ipairs(G.jokers.cards) do
                    joker:flip()
                end
            end
            if #G.jokers.cards > 1 then
                G.jokers:unhighlight_all()
                G.E_MANAGER:add_event(Event({
                    trigger = 'before',
                    func = function()
                        G.E_MANAGER:add_event(Event({
                            func = function()
                                G.jokers:shuffle('aajk')
                                play_sound('cardSlide1', 0.85)
                                return true
                            end,
                        }))
                        delay(0.15)
                        G.E_MANAGER:add_event(Event({
                            func = function()
                                G.jokers:shuffle('aajk')
                                play_sound('cardSlide1', 1.15)
                                return true
                            end
                        }))
                        delay(0.15)
                        G.E_MANAGER:add_event(Event({
                            func = function()
                                G.jokers:shuffle('aajk')
                                play_sound('cardSlide1', 1)
                                return true
                            end
                        }))
                        delay(0.5)
                        return true
                    end
                }))
            end
            return {
                message = "Wosh",
                extra = {
                    message = "WOSH",
                    colour = G.C.ORANGE
                }
            }
        end
        if context.selling_self then
            if #G.jokers.cards > 0 then
                for _, joker in ipairs(G.jokers.cards) do
                    joker:flip()
                end
            end
            return {
                func = function()
                    local available_jokers = {}
                    for i, joker in ipairs(G.jokers.cards) do
                        table.insert(available_jokers, joker)
                    end
                    local target_joker = #available_jokers > 0 and
                        pseudorandom_element(available_jokers, pseudoseed('copy_joker')) or nil

                    if target_joker then
                        G.GAME.joker_buffer = G.GAME.joker_buffer + 1
                        G.E_MANAGER:add_event(Event({
                            func = function()
                                local copied_joker = copy_card(target_joker, nil, nil, nil,
                                    target_joker.edition and target_joker.edition.negative)

                                copied_joker:add_to_deck()
                                G.jokers:emplace(copied_joker)
                                G.GAME.joker_buffer = 0
                                return true
                            end
                        }))
                        card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil,
                            { message = localize('k_duplicated_ex'), colour = G.C.GREEN })
                    end
                    return true
                end,
                extra = {
                    message = "Flip!",
                    colour = G.C.ORANGE
                }
            }
        end
    end
}

--Poroto
SMODS.Atlas {
    key = 'poroto',
    path = 'poroto.png',
    px = 71,
    py = 95
}

SMODS.Joker {
    key = "porotoj",
    config = {
        extra = {
            Tarot = 0
        }
    },
    loc_txt = {
        ['name'] = 'Comodín Poroto',
        ['text'] = {
            [1] = 'Crea una {C:attention}Poroto card{} cuando',
            [2] = 'se selecciona la {C:attention}ciega{}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 0,
        y = 0
    },
    cost = 4,
    rarity = 1,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'poroto',
    calculate = function(self, card, context)
        if context.setting_blind and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
            G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
            G.E_MANAGER:add_event(Event({
                func = (function()
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            SMODS.add_card {
                                set = 'poroto',
                            }
                            G.GAME.consumeable_buffer = 0
                            return true
                        end
                    }))
                    SMODS.calculate_effect({ message = ('Poroto') == G.C.BLUE },
                        context.blueprint_card or card)
                    return true
                end)
            }))
            return nil, true
        end
    end
}

--Shiro
SMODS.Atlas {
    key = 'shiro',
    path = 'shiro.png',
    px = 71,
    py = 95
}

SMODS.Joker {
    name = "Shiro Beil",
    key = "shiro",
    config = {
        extra = {
            Xmult = 1.5,
            odds = 8, -- 1 en 6
            respect = 0
        }
    },
    loc_txt = {
        ['name'] = 'Shiro',
        ['text'] = {
            [1] = '{X:mult,C:white}X1.5{} de mult si tienes un {C:attention}comodín de plátano{}',
            [2] = '{C:green}#2# en #3#{} de crear un {C:gold}comodín de plátano{} al vender una {C:attention}carta{}'
        },
    },
    pos = { x = 0, y = 0 },
    cost = 6,
    rarity = 2,
    pools = { Ratatin = true },
    blueprint_compat = true,
    eternal_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'shiro',

    loc_vars = function(self, info_queue, card)
        local new_numerator, new_denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'j_bp_shiro')
        return { vars = { card.ability.extra.respect, new_numerator, new_denominator } }
    end,

    calculate = function(self, card, context)
        -- Bonus de mult si tienes Cavendish o Gros Michel
        if context.other_joker then
            local k = context.other_joker.config.center.key
            if k == "j_cavendish" or k == "j_gros_michel" then
                return { Xmult = card.ability.extra.Xmult }
            end
        end

        -- Solo se activa al vender comodines (no consumibles)
        if context.selling_card and context.cardarea == G.jokers then
            -- 1 entre 6 probabilidad total
            if SMODS.pseudorandom_probability(card, 'group_shiro_spawn', 1, card.ability.extra.odds, 'j_bp_shiro', false) then
                SMODS.calculate_effect({
                    func = function()
                        G.GAME.joker_buffer = G.GAME.joker_buffer + 1

                        G.E_MANAGER:add_event(Event({
                            func = function()
                                local rand = pseudorandom('shiro_banana')
                                local banana_key = (rand < 0.85) and 'j_gros_michel' or 'j_cavendish'

                                SMODS.add_card({
                                    set = 'Joker',
                                    key = banana_key
                                })

                                G.GAME.joker_buffer = 0
                                return true
                            end
                        }))

                        card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil,
                            { message = localize('k_plus_joker'), colour = G.C.BLUE })
                        return true
                    end
                }, card)
            end
        end
    end
}

--La mikö
SMODS.Atlas {
    key = 'miko',
    path = 'miko.png',
    px = 71,
    py = 95
}

SMODS.Joker { --Mikö Trash Can
    name = "Mikö Trash Can",
    key = "miko",
    config = {
        extra = {
            addchips = 0,
            addmult = 0
        }
    },
    loc_txt = {
        ['name'] = 'Mikö Trash Can',
        ['text'] = {
            [1] = 'Por cada carta {C:blue}impar{} que descartes gana {C:blue}+3{} fichas',
            [2] = 'Por cada carta {C:red}par{} que descartes gana {C:red}+2{} de multi',
            [3] = '{C:inactive}(Actualmente {}{C:blue}+#1# Fichas{}{C:inactive} y {}{C:red}+#2# de Multi{}{C:inactive}){}'
        }
    },
    pos = {
        x = 0,
        y = 0
    },
    cost = 6,
    rarity = 2,
    pools = { Ratatin = true },
    blueprint_compat = true,
    eternal_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'miko',

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.addchips, card.ability.extra.addmult } }
    end,

    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main then
            return {
                chips = card.ability.extra.addchips,
                extra = {
                    mult = card.ability.extra.addmult
                }
            }
        end
        if context.discard and not context.blueprint then
            if (context.other_card:get_id() == 14 or context.other_card:get_id() == 3 or context.other_card:get_id() == 5 or context.other_card:get_id() == 7 or context.other_card:get_id() == 9) then
                return {
                    func = function()
                        card.ability.extra.addchips = (card.ability.extra.addchips) + 5
                        return true
                    end,
                    message = "Más Fichas!"
                }
            elseif (context.other_card:get_id() == 2 or context.other_card:get_id() == 4 or context.other_card:get_id() == 6 or context.other_card:get_id() == 8 or context.other_card:get_id() == 10) then
                return {
                    func = function()
                        card.ability.extra.addmult = (card.ability.extra.addmult) + 2
                        return true
                    end,
                    message = "Más Multi!"
                }
            end
        end
    end
}

--Civer
SMODS.Atlas {
    key = 'civer',
    path = 'civer.png',
    px = 71,
    py = 95
}

SMODS.Joker {
    key = "civer",
    config = {
        extra = {
        }
    },
    loc_txt = {
        ['name'] = 'Civer',
        ['text'] = {
            [1] = 'Cuando un {C:diamonds}Diamante{} puntúa en la {C:attention}primera mano{}',
            [2] = 'se vuelve una {C:gold}carta de oro{} con {C:gold}sello dorado{}',
            [3] = 'cuando un {C:clubs}Trébol{} puntúa en la {C:attention}primera mano{}',
            [4] = 'se vuelve una {C:blue}carta de acero{} con {C:blue}sello azul{}'
        }
    },
    pos = {
        x = 0,
        y = 0
    },
    cost = 6,
    rarity = 2,
    pools = { Ratatin = true },
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'civer',

    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            if (G.GAME.current_round.hands_played == 0 and context.other_card:is_suit("Clubs")) then
                context.other_card:set_ability(G.P_CENTERS.m_steel)
                context.other_card:set_seal("Blue", true)
                return {
                }
            elseif (G.GAME.current_round.hands_played == 0 and context.other_card:is_suit("Diamonds")) then
                context.other_card:set_ability(G.P_CENTERS.m_gold)
                context.other_card:set_seal("Gold", true)
                return {
                }
            end
        end
    end
}
--Derki
SMODS.Atlas {
    key = 'derki',
    path = 'derki.png',
    px = 71,
    py = 95
}

SMODS.Joker {
    key = "derki",
    config = {
        extra = {
            highestrankinhand = 0
        }
    },
    loc_txt = {
        ['name'] = 'Derker Bluer',
        ['text'] = {
            [1] = 'Agrega {C:attention}la mitad{} de la categoria',
            [2] = 'de la carta más{C:attention} alta{} que tienes',
            [3] = 'en la mano a {C:blue}Multiplicador de Fichas{}'
        }
    },
    pos = {
        x = 0,
        y = 0
    },
    cost = 6,
    rarity = 2,
    pools = { Ratatin = true },
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'derki',

    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main then
            return {
                x_chips = ((function()
                    local max = 0; for _, card in ipairs(G.hand and G.hand.cards or {}) do
                        if card.base.id > max then
                            max =
                                card.base.id
                        end
                    end; return max
                end)()) * 0.5
            }
        end
    end
}

--Dego
local function count_used_vouchers()
    local t = G.GAME.used_vouchers or {}
    local c = 0
    for _ in pairs(t) do c = c + 1 end
    return c
end

SMODS.Atlas {
    key = 'dego',
    path = 'dego.png',
    px = 71,
    py = 95
}

SMODS.Joker {
    key = "dego",
    config = {
        extra = {
            handsize = 0
        }
    },
    loc_txt = {
        ['name'] = 'Dego Draw',
        ['text'] = {
            [1] = 'Gana {C:attention}+1{} de tamaño de mano',
            [2] = 'por cada {C:attention}2{} vales canjeados',
            [3] = '{C:inactive}(Actualmente {C:attention}+#1#{}{C:inactive} tamaño de mano){}'
        },
    },
    pos = {
        x = 0,
        y = 0
    },
    cost = 6,
    rarity = 2,
    pools = { Ratatin = true },
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'dego',

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.handsize } }
    end,

    calculate = function(self, card, context)
        -- Cada 2 vales = +1 tamaño de mano
        local total_vouchers = count_used_vouchers()
        local new_handsize = math.floor(total_vouchers / 2)
        if new_handsize ~= card.ability.extra.handsize then
            local diff = new_handsize - card.ability.extra.handsize
            card.ability.extra.handsize = new_handsize
            G.hand:change_size(diff)
        end
    end,

    add_to_deck = function(self, card, from_debuff)
        local total_vouchers = count_used_vouchers()
        local gained_size = math.floor(total_vouchers / 2)
        card.ability.extra.handsize = gained_size
        G.hand:change_size(gained_size)
    end,

    remove_from_deck = function(self, card, from_debuff)
        G.hand:change_size(-card.ability.extra.handsize)
    end
}


--Damian
SMODS.Atlas {
    key = 'damian',
    path = 'damian.png',
    px = 71,
    py = 95

}

SMODS.Joker {
    key = "damian",
    config = {
        extra = {
            purple = 0
        }
    },
    loc_txt = {
        ['name'] = 'Normal Damian',
        ['text'] = {
            [1] = 'Cuando una carta con {C:purple}sello morado{} puntua',
            [2] = 'se {C:attention}reactiva{} la misma cantidad de veces que',
            [3] = 'se han descartado {C:purple}sellos morados{}, se restablece',
            [4] = 'cuando se derrota a la {C:attention}ciega jefe{}',
            [5] = '{C:inactive}(Actualmente {C:attention}#1#{}{C:inactive} reativaciones){}',
            [6] = ''
        },
        ['unlock'] = {
            [1] = 'Hola'
        }
    },
    pos = {
        x = 0,
        y = 0
    },
    cost = 6,
    rarity = 2,
    pools = { Ratatin = true },
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'damian',
    in_pool = function(self, args)
        return (
                not args

                or args.source == 'sho' or args.source == 'buf' or args.source == 'jud' or args.source == 'rif' or args.source == 'rta' or args.source == 'sou' or args.source == 'uta' or args.source == 'wra'
            )
            and true
    end
    ,

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.purple } }
    end,

    calculate = function(self, card, context)
        if context.repetition and context.cardarea == G.play then
            if context.other_card.seal == "Purple" then
                return {
                    repetitions = card.ability.extra.purple,
                    message = localize('k_again_ex')
                }
            end
        end
        if context.discard then
            if context.other_card.seal == "Purple" and not context.blueprint then
                return {
                    func = function()
                        card.ability.extra.purple = (card.ability.extra.purple) + 1
                        return true
                    end,
                    message = "Mejora"
                }
            end
        end
        if context.end_of_round and context.main_eval and G.GAME.blind.boss then
            return {
                func = function()
                    card.ability.extra.purple = 0
                    return true
                end,
                message = "Restablecer"
            }
        end
    end
}

--TV Nalgas
SMODS.Atlas {
    key = 'tv',
    path = 'tv.png',
    px = 71,
    py = 95

}

SMODS.Joker {
    key = "tv_nauta",
    config = {
        extra = {
        }
    },
    loc_txt = {
        ['name'] = 'El ultimo TV nauta',
        ['text'] = {
            [1] = 'Si la {C:attention}primera mano{} de la ronda tiene',
            [2] = 'exactamente {C:attention}5{} cartas que {C:attention}anotan{} crea',
            [3] = '{C:attention}una copia{} de la ultima y {C:red}destruye{} las demás',
        },
        ['unlock'] = {
            [1] = 'Unlocked by default'
        }
    },
    pos = {
        x = 0,
        y = 0
    },
    cost = 6,
    rarity = 2,
    pools = { Ratatin = true },
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'tv',

    calculate = function(self, card, context)
        if context.destroy_card and context.destroy_card.should_destroy then
            return { remove = true }
        end
        if context.individual and context.cardarea == G.play then
            context.other_card.should_destroy = false
            if (G.GAME.current_round.hands_played == 0 and #context.scoring_hand == 5 and context.other_card == context.scoring_hand[1]) then
                context.other_card.should_destroy = true
                return {
                }
            elseif (G.GAME.current_round.hands_played == 0 and #context.scoring_hand == 5 and context.other_card == context.scoring_hand[2]) then
                context.other_card.should_destroy = true
                return {
                }
            elseif (G.GAME.current_round.hands_played == 0 and #context.scoring_hand == 5 and context.other_card == context.scoring_hand[3]) then
                context.other_card.should_destroy = true
                return {
                }
            elseif (G.GAME.current_round.hands_played == 0 and #context.scoring_hand == 5 and context.other_card == context.scoring_hand[4]) then
                context.other_card.should_destroy = true
                return {
                }
            elseif (G.GAME.current_round.hands_played == 0 and #context.scoring_hand == 5 and context.other_card == context.scoring_hand[#context.scoring_hand]) then
                G.playing_card = (G.playing_card and G.playing_card + 1) or 1
                local copied_card = copy_card(context.other_card, nil, nil, G.playing_card)
                copied_card:add_to_deck()
                G.deck.config.card_limit = G.deck.config.card_limit + 1
                table.insert(G.playing_cards, copied_card)
                G.hand:emplace(copied_card)
                copied_card.states.visible = nil

                G.E_MANAGER:add_event(Event({
                    func = function()
                        copied_card:start_materialize()
                        return true
                    end
                }))
                return {
                    message = "Copiado"
                }
            end
        end
    end
}

--Darknew
SMODS.Atlas {
    key = 'darknew',
    path = 'darknew.png',
    px = 71,
    py = 95

}

SMODS.Joker {
    key = "darknew",
    blueprint_compat = true,
    atlas = 'darknew',
    pos = {
        x = 0,
        y = 0
    },
    unlocked = true,
    discovered = true,
    loc_txt = {
        ['name'] = 'DarkNew',
        ['text'] = {
            'Todos los {C:attention}Comodines{} y {C:attention}Consumibles{} relacionados',
            'con {C:dark_edition}ediciones{} siempre dan {C:edition}policromado{}',
            'Pierde su efecto si se {C:attention}vende{} pero no si se {C:red}destruye{}'
        }
    },
    pools = { Ratatin = true },
    rarity = 2,
    cost = 6,
    config = { extra = {
        bp_poly = 0,
        n = 0
    }
    },
    in_pool = function(self, args)
        return (
                not args
                or args.source ~= 'buf' and args.source ~= 'jud'
                or args.source == 'sho' or args.source == 'rif' or args.source == 'rta' or args.source == 'sou' or args.source == 'uta' or args.source == 'wra'
            )
            and true
    end,

    calculate = function(self, card, context)
        if context.selling_self then
            G.GAME.pool_flags.bp_poly = false
        end
        if context.buying_card and context.card.config.center.key == self.key and context.cardarea == G.jokers then
            G.GAME.pool_flags.bp_poly = true
        end
    end
}
--Cristian Ghost
SMODS.Atlas {
    key = 'cristianghost',
    path = 'cristianghost.png',
    px = 71,
    py = 95

}

SMODS.Joker {
    key = "cristianghost",
    config = {
        extra = {
            otherjokerssellvalue = 0,
            odds = 3
        }
    },
    loc_txt = {
        ['name'] = 'Cristian Ghost',
        ['text'] = {
            [1] = '{C:green}#2# en #3#{} probabilidades de dar el',
            [2] = '{C:attention}50%{} de valo de venta de {C:attention}todos los{}',
            [3] = '{C:attention}comodines{} cuando se juega una {C:attention}mano{}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 0,
        y = 0
    },
    display_size = {
        w = 71 * 1,
        h = 95 * 1
    },
    pools = { Ratatin = true },
    cost = 6,
    rarity = 2,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'cristianghost',

    loc_vars = function(self, info_queue, card)
        local new_numerator, new_denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds,
            'j_modprefix_cristianghost')
        return {
            vars = { ((function()
                local total = 0; for _, joker in ipairs(G.jokers and (G.jokers and G.jokers.cards or {}) or {}) do
                    if joker ~= card then
                        total =
                            total + joker.sell_cost
                    end
                end; return total
            end)()) * 0.5, new_numerator, new_denominator }
        }
    end,

    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main then
            if true then
                if SMODS.pseudorandom_probability(card, 'group_0_b8dc3c5c', 1, card.ability.extra.odds, 'j_modprefix_cristianghost', false) then
                    SMODS.calculate_effect(
                        {
                            dollars = ((function()
                                local total = 0; for _, joker in ipairs(G.jokers and G.jokers.cards or {}) do
                                    if joker ~= card then
                                        total =
                                            total + joker.sell_cost
                                    end
                                end; return total
                            end)()) * 0.5
                        }, card)
                end
            end
        end
    end
}

--SEF
SMODS.Atlas {
    key = 'sef',
    path = 'sef.png',
    px = 71,
    py = 95
}

SMODS.Joker {
    key = "sef",
    config = {
        extra = {
            bolsa = 1,
            odds = 32
        }
    },
    loc_txt = {
        ['name'] = 'SEF',
        ['text'] = {
            [1] = 'Cada que se juegue una {C:attention}mano{} da {C:money}1{} de dinero',
            [2] = 'El {C:money}dinero{} que da en cada {C:attention}mano{} se duplica al seleccionar la {C:attention}ciega{}',
            [3] = '{C:green}1 en 32{} de restablecer el {C:money}dinero{} a {C:money}1{}',
            [4] = '{C:inactive}(La probabilidad aumenta a la par al {C:money}dinero{}{C:inactive})'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 0,
        y = 0
    },
    display_size = {
        w = 71 * 1,
        h = 95 * 1
    },
    pools = { Ratatin = true },
    cost = 6,
    rarity = 2,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'sef',

    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main then
            if true then
                return {
                    dollars = card.ability.extra.bolsa
                    ,
                    func = function()
                        if SMODS.pseudorandom_probability(card, 'group_0_a8df89bc', card.ability.extra.bolsa, card.ability.extra.odds, 'j_modprefix_newjoker', false) then
                            card.ability.extra.bolsa = 1
                            card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil,
                                { message = "Restablecer", colour = G.C.BLUE })
                        end
                        return true
                    end
                }
            end
        end
        if context.setting_blind then
            return {
                func = function()
                    card.ability.extra.bolsa = (card.ability.extra.bolsa) * 2
                    return true
                end,
                message = "Mejora"
            }
        end
    end
}

--Pelo
SMODS.Atlas {
    key = 'pelo',
    path = 'pelo.png',
    px = 71,
    py = 95
}

SMODS.Joker { --New Joker
    key = "pelo",
    config = {
        extra = {
            winner_ante_value = 10,
            ante_value = 1,
            bp_pelo = 0,
            bp_pelo2 = 0,
            bp_pelo3 = 0,
            bp_pelo4 = 0,
            bp_pelo5 = 0,
            bp_pelo6 = 0,
            bp_pelo7 = 0,
            bp_pelo8 = 0,
            bp_pelo9 = 0,
            bp_pelo10 = 0,
            bp_pelo11 = 0,
            bp_pelo12 = 0,
            bp_pelo13 = 0,
            bp_pelo14 = 0,
            bp_pelo15 = 0,
            bp_pelo16 = 0,
            bp_pelo17 = 0,
            bp_pelo18 = 0,
            bp_pelo19 = 0,
            bp_pelo20 = 0,
            bp_pelo21 = 0,
            bp_pelo22 = 0,
            bp_pelo23 = 0,
            bp_pelo24 = 0,
            bp_pelo25 = 0,
            bp_pelo26 = 0,
            bp_pelo27 = 0,
            bp_pelo28 = 0,
            bp_pelo29 = 0,
            bp_pelo30 = 0,
            bp_pelo31 = 0,
            bp_pelo32 = 0,
            bp_pelo33 = 0,
            bp_pelo34 = 0,
            bp_pelo35 = 0,
            bp_pelo36 = 0,
            bp_pelo37 = 0,
            bp_pelo38 = 0,
            bp_pelo39 = 0,
            bp_pelo40 = 0,
            bp_pelo41 = 0,
            bp_pelo42 = 0,
            bp_pelo43 = 0,
            bp_pelo44 = 0,
            bp_pelo45 = 0,
            bp_pelo46 = 0,
            bp_pelo47 = 0,
            bp_pelo48 = 0,
            bp_pelo49 = 0,
            bp_pelo50 = 0,
        }
    },
    loc_txt = {
        ['name'] = 'Sr. Pelo',
        ['text'] = {
            [1] = 'Si {C:red}pierdes{} antes de la {C:attention}apuesta inicial{} {C:attention}8{}',
            [2] = 'Establece la {C:attention}apuesta inicial{} actual como {C:attention}1{}',
            [3] = 'Establece la {C:attention}apuesta inicial{} ganadora como {C:attention}10{}',
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 0,
        y = 0
    },
    display_size = {
        w = 71 * 1,
        h = 95 * 1
    },
    cost = 6,
    rarity = 2,
    blueprint_compat = false,
    pools = { Ratatin = true },
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'pelo',

    calculate = function(self, card, context)
        if context.end_of_round and context.game_over and context.main_eval and not context.blueprint then
            if G.GAME.round_resets.ante <= 8 then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        local sound_options = {
                            "bp_pelo",
                            "bp_pelo2",
                            "bp_pelo3",
                            "bp_pelo4",
                            "bp_pelo5",
                            "bp_pelo6",
                            "bp_pelo7",
                            "bp_pelo8",
                            "bp_pelo9",
                            "bp_pelo10",
                            "bp_pelo11",
                            "bp_pelo12",
                            "bp_pelo13",
                            "bp_pelo14",
                            "bp_pelo15",
                            "bp_pelo16",
                            "bp_pelo17",
                            "bp_pelo18",
                            "bp_pelo19",
                            "bp_pelo20",
                            "bp_pelo21",
                            "bp_pelo22",
                            "bp_pelo23",
                            "bp_pelo24",
                            "bp_pelo25",
                            "bp_pelo26",
                            "bp_pelo27",
                            "bp_pelo28",
                            "bp_pelo29",
                            "bp_pelo30",
                            "bp_pelo31",
                            "bp_pelo32",
                            "bp_pelo33",
                            "bp_pelo34",
                            "bp_pelo35",
                            "bp_pelo36",
                            "bp_pelo37",
                            "bp_pelo38",
                            "bp_pelo39",
                            "bp_pelo40",
                            "bp_pelo41",
                            "bp_pelo42",
                            "bp_pelo43",
                            "bp_pelo44",
                            "bp_pelo45",
                            "bp_pelo46",
                            "bp_pelo47",
                            "bp_pelo48",
                            "bp_pelo49",
                            "bp_pelo50",
                        }

                        local chosen_sound = sound_options[math.random(#sound_options)]

                        play_sound(chosen_sound)

                        return true
                    end,
                }))
                return {
                    saved = true,
                    message = ('Salvado'),
                    extra = {
                        func = function()
                            card:explode()
                            return true
                        end,
                        colour = G.C.RED,
                        extra = {
                            func = function()
                                G.E_MANAGER:add_event(Event({
                                    func = function()
                                        G.GAME.win_ante = card.ability.extra.winner_ante_value
                                        return true
                                    end
                                }))
                                return true
                            end,
                            extra = {
                                func = function()
                                    local mod = card.ability.extra.ante_value - G.GAME.round_resets.ante
                                    ease_ante(mod)
                                    G.E_MANAGER:add_event(Event({
                                        func = function()
                                            G.GAME.round_resets.blind_ante = card.ability.extra.ante_value
                                            return true
                                        end,
                                    }))
                                    return true
                                end,
                            }
                        }
                    }
                }
            end
        end
    end
}

--Cuadrado
SMODS.Atlas {
    key = 'cuadrado',
    path = 'cuadrado.png',
    px = 71,
    py = 95
}

SMODS.Joker {
    key = "cuadrado",
    config = {
        extra = {
            VENTAS = 4,
            ventas_t = 4,
            ignore = 0
        }
    },
    loc_txt = {
        ['name'] = 'Cuadrado muy afamado',
        ['text'] = {
            [1] = 'Crea un {C:common}Comodín Cuadrado{} al salir de la',
            [2] = '{C:attention}tienda{} si has comprado {C:attention}#2#{} cartas y/o booster',
            [3] = 'packs en esta el valor aumenta en {C:attention}4{} por cada tienda',
            [4] = '{C:inactive}({}{C:attention}#1#{}{C:inactive} compras restantes){}',
            [5] = ''
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 0,
        y = 0
    },
    display_size = {
        w = 71 * 1,
        h = 95 * 1
    },
    cost = 8,
    rarity = 3,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'cuadrado',

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.VENTAS, card.ability.extra.ventas_t } }
    end,


    calculate = function(self, card, context)
        if context.starting_shop then
            return {
                func = function()
                    card.ability.extra.VENTAS = card.ability.extra.ventas_t
                    return true
                end
            }
        end
        if context.ending_shop then
            if (card.ability.extra.VENTAS == 0 and not ((G.GAME.pool_flags.bp_poly or false))) then
                return {
                    func = function()
                        local created_joker = true
                        G.E_MANAGER:add_event(Event({
                            func = function()
                                local joker_card = SMODS.add_card({ set = 'Joker', key = 'j_square' })
                                if joker_card then
                                    joker_card:set_edition("e_negative", true)
                                end

                                return true
                            end
                        }))

                        if created_joker then
                            card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil,
                                { message = localize('k_plus_joker'), colour = G.C.BLUE })
                        end
                        return true
                    end,
                    extra = {
                        func = function()
                            card.ability.extra.ventas_t = (card.ability.extra.ventas_t) + 4
                            return true
                        end,
                        colour = G.C.GREEN
                    }
                }
            elseif (card.ability.extra.VENTAS == 0 and (G.GAME.pool_flags.bp_poly or false)) then
                return {
                    func = function()
                        local created_joker = false
                        if #G.jokers.cards + G.GAME.joker_buffer < G.jokers.config.card_limit then
                            created_joker = true
                            G.GAME.joker_buffer = G.GAME.joker_buffer + 1
                            G.E_MANAGER:add_event(Event({
                                func = function()
                                    local joker_card = SMODS.add_card({ set = 'Joker', key = 'j_square' })
                                    if joker_card then
                                        joker_card:set_edition("e_polychrome", true)
                                    end
                                    G.GAME.joker_buffer = 0
                                    return true
                                end
                            }))
                        end
                        if created_joker then
                            card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil,
                                { message = localize('k_plus_joker'), colour = G.C.BLUE })
                        end
                        return true
                    end,
                    extra = {
                        func = function()
                            card.ability.extra.ventas_t = (card.ability.extra.ventas_t) + 4
                            return true
                        end,
                        colour = G.C.GREEN
                    }
                }
            end
        end
        if context.buying_card then
            if card.ability.extra.VENTAS > 0 then
                return {
                    func = function()
                        card.ability.extra.VENTAS = math.max(0, (card.ability.extra.VENTAS) - 1)
                        return true
                    end
                }
            end
        end
        if context.open_booster then
            if card.ability.extra.VENTAS > 0 then
                return {
                    func = function()
                        card.ability.extra.VENTAS = math.max(0, (card.ability.extra.VENTAS) - 1)
                        return true
                    end
                }
            end
        end
    end
}

--Ratatin
SMODS.Atlas {
    key = 'ratatin',
    path = 'ratatin.png',
    px = 71,
    py = 95
}

SMODS.Joker {
    key = "ratatin",
    blueprint_compat = true,
    atlas = 'ratatin',
    unlocked = true,
    discovered = true,
    pos = {
        x = 0,
        y = 0
    },
    loc_txt = {
        ['name'] = 'Ratatin',
        ['text'] = {
            'Da {X:mult,C:white}X2.5{} de Multi por cada',
            '{C:attention}Comodín{} que represente un',
            'miembro de {C:attention}Ratatin Gaming{}'
        }
    },
    rarity = 3,
    cost = 8,
    config = { extra = { xmult = 2.5 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.xmult } }
    end,
    calculate = function(self, card, context)
        if context.other_joker and (context.other_joker.config.center.pools and context.other_joker.config.center.pools.Ratatin == true) then
            return {
                xmult = card.ability.extra.xmult
            }
        end
    end,
}

--Miyamoto
SMODS.Atlas {
    key = 'miyamoto',
    path = 'miyamoto.png',
    px = 71,
    py = 95

}

SMODS.Joker { -- Miyamoto
    key = "miyamoto",
    config = {
        extra = {
            multvar = 1
        }
    },
    loc_txt = {
        ['name'] = 'Miyamoto',
        ['text'] = {
            [1] = 'Elimina a un {C:attention}Comodín{} miembro de',
            [2] = '{C:attention}Ratatin Gaming{} y obtiene',
            [3] = '{X:red,C:white}X0.5{} de su precio de venta',
            [4] = '{C:inactive}(Actual {X:red,C:white}X#1#{}{C:inactive} Multi){}'
        },
    },
    pos = { x = 0, y = 0 },
    cost = 8,
    rarity = 3,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'miyamoto',

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.multvar } }
    end,

    calculate = function(self, card, context)
        if context.joker_main then
            return {
                Xmult = card.ability.extra.multvar
            }
        end
        if context.setting_blind then
            -- Buscar cualquier Ratatin que no sea Miyamoto
            local target_joker = nil
            for _, joker in ipairs(G.jokers.cards or {}) do
                if joker.config.center.pools
                    and joker.config.center.pools.Ratatin == true
                    and joker.config.center.key ~= card.config.center.key
                    and not joker.ability.eternal
                    and not joker.getting_sliced then
                    target_joker = joker
                    break
                end
            end

            -- Si encontró uno, destruirlo
            if target_joker then
                return {
                    func = function()
                        local joker_sell_value = target_joker.sell_cost or 0
                        local sell_value_gain = joker_sell_value * 0.5
                        card.ability.extra.multvar = card.ability.extra.multvar + sell_value_gain
                        target_joker.getting_sliced = true
                        G.E_MANAGER:add_event(Event({
                            func = function()
                                target_joker:start_dissolve({ G.C.RED }, nil, 1.6)
                                return true
                            end
                        }))
                        card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {
                            message = "KKKKKKKKKKKK",
                            colour = G.C.RED
                        })
                        return true
                    end

                }
            end
        end
    end
}

--David el Gnomo
SMODS.Atlas {
    key = 'gnomo',
    path = 'gnomo.png',
    px = 71,
    py = 95
}

SMODS.Joker {
    key = "davidelgnomo",
    config = {
        extra = {
            odds = 5,
            odds2 = 5,
        }
    },
    loc_txt = {
        ['name'] = 'David El Gnomo',
        ['text'] = {
            [1] = '{C:green}1 en 5{} probabilidades de volver las cartas',
            [2] = 'de {C:attention}figura{} que anotan en cartas {C:dark_edition}negativas{}',
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 0,
        y = 0
    },
    display_size = {
        w = 71 * 1,
        h = 95 * 1
    },
    cost = 8,
    rarity = 3,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'gnomo',

    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            if (context.other_card:is_face() and not ((G.GAME.pool_flags.bp_poly or false))) then
                if SMODS.pseudorandom_probability(card, 'group_0_3720d66c', 1, card.ability.extra.odds, 'j_modprefix_davidelgnomo', false) then
                    context.other_card:set_edition("e_negative", true)
                    card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil,
                        { message = "NEGATIVO", colour = G.C.BLUE })
                end
            elseif (context.other_card:is_face() and (G.GAME.pool_flags.bp_poly or false)) then
                if SMODS.pseudorandom_probability(card, 'group_0_14bf8ce9', 1, card.ability.extra.odds, 'j_modprefix_davidelgnomo', false) then
                    context.other_card:set_edition("e_polychrome", true)
                    card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil,
                        { message = "POSITIVO", colour = G.C.BLUE })
                end
            end
        end
    end
}

--Emoji Movie
SMODS.Atlas {
    key = 'emoji',
    path = 'emoji.png',
    px = 71,
    py = 95

}

SMODS.Joker {
    key = "emoji",
    config = {
        extra = {
            Tarot = 0
        }
    },
    loc_txt = {
        ['name'] = 'Emoji Movie',
        ['text'] = {
            [1] = 'Cuando se juega una {C:attention}figura{} con',
            [2] = '{C:gold}sello dorado{} crea una carta de',
            [3] = '{C:tarot}tarot{} con un humano en su {C:attention}arte{}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 0,
        y = 0
    },
    display_size = {
        w = 71 * 1,
        h = 95 * 1
    },
    cost = 8,
    rarity = 3,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'emoji',

    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            if (context.other_card.seal == "Gold" and context.other_card:is_face()) then
                local created_consumable = false
                if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
                    created_consumable = true
                    G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            local random_key = pseudorandom_element(
                                {
                                    "c_fool", "c_magician", "c_high_priestess", "c_empress", "c_emperor",
                                    "c_heirophant", "c_lovers", "c_chariot", "c_strength", "c_justice",
                                    "c_hermit", "c_hanged_man", "c_temperance", "c_star", "c_sun", "c_judgement",
                                    "c_world", "c_death"
                                },
                                "seed")
                            local joker_card = SMODS.add_card({
                                set = 'Tarot',
                                key = random_key
                            })
                            return true
                        end
                    }))
                end
                return {
                    message = created_consumable and localize('k_plus_tarot') or nil
                }
            end
        end
    end
}

--Llon
SMODS.Atlas {
    key = 'llon',
    path = 'llon.png',
    px = 71,
    py = 95
}

SMODS.Joker {
    key = "llon",
    config = {
        extra = {
            xmultvar = 1,
        }
    },
    loc_txt = {
        ['name'] = 'Llon El Toni',
        ['text'] = {
            [1] = 'Gana {X:blue,C:white}X0.5{} de Fichas por',
            [2] = 'cada {C:attention}Poroto Card{} usada',
            [3] = 'Gana {X:red,C:white}X0.5{} de Multi por',
            [4] = 'cada {C:attention}Poroto Card{} usada',
            [5] = '{C:inactive}(Actual{} {X:red,C:white}X#1#{}{C:inactive} y {}{X:blue,C:white}X#1#{}{C:inactive}){}'
        }
    },
    pos = {
        x = 0,
        y = 0
    },
    soul_pos = {
        x = 1,
        y = 0
    },
    cost = 20,
    rarity = 4,
    pools = { Ratatin = true },
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'llon',

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.xmultvar } }
    end,

    calculate = function(self, card, context)
        if context.using_consumeable and not context.blueprint and context.consumeable.ability.set == 'poroto' then
            return {
                func = function()
                    card.ability.extra.xmultvar = (card.ability.extra.xmultvar) + 0.5
                    return true
                end
            }
        end
        if context.cardarea == G.jokers and context.joker_main then
            return {
                Xmult = card.ability.extra.xmultvar,
                extra = {
                    x_chips = card.ability.extra.xmultvar,
                    colour = G.C.DARK_EDITION
                }
            }
        end
    end
}

--Retard Gamer
SMODS.Atlas {
    key = 'retard',
    path = 'retard.png',
    px = 71,
    py = 95
}

SMODS.Joker {
    key = "retard",
    config = {
        extra = {
            perma_bonus = 1,
            perma_mult = 0
        }
    },
    loc_txt = {
        ['name'] = 'Retard Gamer',
        ['text'] = {
            [1] = 'Convierte a {C:attention}todas{} las cartas que anotan en {C:attention}Ases{}',
            [2] = 'de {C:hearts}corazones{} {C:enhanced}adicionales{}, Las cartas obtiene {C:red}+1 de multi{}',
            [3] = 'cada que vuelven a anotar'
        }
    },
    pos = {
        x = 0,
        y = 0
    },
    cost = 20,
    rarity = 4,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'retard',
    soul_pos = {
        x = 1,
        y = 0
    },

    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and not context.blueprint then
            if (context.other_card:get_id() == 14 and context.other_card:is_suit("Hearts") and SMODS.get_enhancements(context.other_card)["m_bonus"] == true) then
                context.other_card.ability.perma_mult = context.other_card.ability.perma_mult or 0
                context.other_card.ability.perma_mult = context.other_card.ability.perma_mult +
                    card.ability.extra.perma_bonus
                return {
                    extra = { message = ('1 Up'), G.C.MULT }, card = card
                }
            else
                assert(SMODS.change_base(context.other_card, "Hearts", "Ace"))
                context.other_card:set_ability(G.P_CENTERS.m_bonus)
                return {
                }
            end
        end
    end
}

--Cogollo Mutante
SMODS.Atlas {
    key = 'cogollo',
    path = 'cogollo.png',
    px = 71,
    py = 95

}

SMODS.Joker {
    key = "cogollo",
    config = {
        extra = {
            ignore = 0
        }
    },
    loc_txt = {
        ['name'] = 'Cogollo Mutante',
        ['text'] = {
            [1] = 'Cuando seleccionas la {C:attention}ciega{}',
            [2] = 'crea un {C:green}comodín verde{} {C:attention}no legendario{}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 0,
        y = 0
    },
    cost = 20,
    rarity = 4,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'cogollo',
    soul_pos = {
        x = 1,
        y = 0
    },
    in_pool = function(self, args)
        return (
                not args
                or args.source ~= 'sho' and args.source ~= 'buf' and args.source ~= 'jud'
                or args.source == 'rif' or args.source == 'rta' or args.source == 'sou' or args.source == 'uta' or args.source == 'wra'
            )
            and true
    end,

    calculate = function(self, card, context)
        if context.setting_blind then
            return {
                func = function()
                    local created_joker = true
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            local random_key = pseudorandom_element(
                                { "j_green_joker", "j_gluttenous_joker", "j_zany", "j_wily", "j_ceremonial", "j_chaos",
                                    "j_pareidolia", "j_blackboard", "j_turtle_bean", "j_to_the_moon", "j_troubadour",
                                    "j_flower_pot", "j_bloodstone", "j_oops", "j_trio", },
                                "seed")
                            local joker_card = SMODS.add_card({
                                set = 'Joker',
                                key = random_key
                            })
                            return true
                        end
                    }))

                    if created_joker then
                        card_eval_status_text(
                            context.blueprint_card or card,
                            'extra', nil, nil, nil,
                            { message = localize('k_plus_joker'), colour = G.C.BLUE }
                        )
                    end
                    return true
                end
            }
        end
    end
}

--Llon en el Kick
SMODS.Atlas {
    key = 'kick',
    path = 'kick.png',
    px = 71,
    py = 95

}

SMODS.Joker {
    key = "kick",
    config = {
        extra = {
            dollars = 2,
            ignore = 0,
            bp_porotin = 0,
            bp_kirby = 0,
            bp_tony = 0
        }
    },
    loc_txt = {
        ['name'] = "Llon en el Kick",
        ['text'] = {
            [1] = 'En la {C:attention}primera mano{} de la {C:attention}ciega pequeña{}',
            [2] = 'da un {C:money}2{} de dinero',
            [3] = 'En la {C:attention}primera mano{} de la {C:attention}ciega grande{}',
            [4] = 'crea copia un {C:attention}consumible{} en {C:dark_edition}negativo{}',
            [5] = 'En la {C:attention}primera mano{} de la {C:attention}ciega jefe{}',
            [6] = 'crea un {C:attention}comodín{} {C:uncommon}inusual{} en {C:dark_edition}negativo{}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 0,
        y = 0
    },
    soul_pos = {
        x = 1,
        y = 0
    },
    display_size = {
        w = 71 * 1,
        h = 95 * 1
    },
    cost = 20,
    rarity = 4,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'kick',


    calculate = function(self, card, context)
        if context.after and context.cardarea == G.jokers then
            if (G.GAME.current_round.hands_played == 0 and G.GAME.blind.boss) and not (G.GAME.pool_flags.bp_poly or false) and not context.blueprint then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        play_sound("bp_porotin")

                        return true
                    end,
                }))
                return {
                    func = function()
                        local created_joker = true
                        G.E_MANAGER:add_event(Event({
                            func = function()
                                local joker_card = SMODS.add_card({ set = 'Joker', rarity = 'Uncommon' })
                                if joker_card then
                                    joker_card:set_edition("e_negative", true)
                                end

                                return true
                            end
                        }))

                        if created_joker then
                            card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil,
                                { message = localize('k_plus_joker'), colour = G.C.BLUE })
                        end
                        return true
                    end
                }
            elseif (G.GAME.current_round.hands_played == 0 and G.GAME.blind:get_type() == 'Big') and not (G.GAME.pool_flags.bp_poly or false) and not context.blueprint then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        play_sound("bp_kirby")

                        return true
                    end,
                }))
                return {
                    func = function()
                        local target_cards = {}
                        for i, consumable in ipairs(G.consumeables.cards) do
                            table.insert(target_cards, consumable)
                        end
                        if #target_cards > 0 then
                            local card_to_copy = pseudorandom_element(target_cards, pseudoseed('copy_consumable'))

                            G.E_MANAGER:add_event(Event({
                                func = function()
                                    local copied_card = copy_card(card_to_copy)
                                    copied_card:set_edition("e_negative", true)
                                    copied_card:add_to_deck()
                                    G.consumeables:emplace(copied_card)

                                    return true
                                end
                            }))
                            card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil,
                                { message = "Copiado", colour = G.C.GREEN })
                        end
                        return true
                    end
                }
            elseif (G.GAME.current_round.hands_played == 0 and G.GAME.blind:get_type() == 'Small') and not context.blueprint then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        play_sound("bp_tony")

                        return true
                    end,
                }))
                return {
                    dollars = card.ability.extra.dollars
                }
            elseif (G.GAME.current_round.hands_played == 0 and (G.GAME.pool_flags.bp_poly or false) and G.GAME.blind.boss) and not context.blueprint then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        play_sound("bp_porotin")

                        return true
                    end,
                }))
                return {
                    func = function()
                        local created_joker = false
                        if #G.jokers.cards + G.GAME.joker_buffer < G.jokers.config.card_limit then
                            created_joker = true
                            G.GAME.joker_buffer = G.GAME.joker_buffer + 1
                            G.E_MANAGER:add_event(Event({
                                func = function()
                                    local joker_card = SMODS.add_card({ set = 'Joker', rarity = 'Uncommon' })
                                    if joker_card then
                                        joker_card:set_edition("e_polychrome", true)
                                    end
                                    G.GAME.joker_buffer = 0
                                    return true
                                end
                            }))
                        end
                        if created_joker then
                            card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil,
                                { message = localize('k_plus_joker'), colour = G.C.BLUE })
                        end
                        return true
                    end
                }
            elseif (G.GAME.current_round.hands_played == 0 and (G.GAME.pool_flags.bp_poly or false) and G.GAME.blind:get_type() == 'Big') and not context.blueprint then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        play_sound("bp_kirby")

                        return true
                    end,
                }))
                return {
                    func = function()
                        local target_cards = {}
                        for i, consumable in ipairs(G.consumeables.cards) do
                            table.insert(target_cards, consumable)
                        end
                        if #target_cards > 0 then
                            local card_to_copy = pseudorandom_element(target_cards, pseudoseed('copy_consumable'))

                            G.E_MANAGER:add_event(Event({
                                func = function()
                                    local copied_card = copy_card(card_to_copy)
                                    copied_card:set_edition("e_polychrome", true)
                                    copied_card:add_to_deck()
                                    G.consumeables:emplace(copied_card)

                                    return true
                                end
                            }))
                            card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil,
                                { message = "Copiado", colour = G.C.GREEN })
                        end
                        return true
                    end
                }
            end
        end
    end
}

--Huerfano producciones
SMODS.Atlas {
    key = 'canal',
    path = 'canal.png',
    px = 71,
    py = 95

}

SMODS.Joker {
    key = "canal",
    config = {
        extra = {
            odds = 8,
            Spectral = 0,
            poroto = 0
        }
    },
    loc_txt = {
        ['name'] = 'Huerfano Producciones',
        ['text'] = {
            [1] = '{C:green}#3# en #4#{} probabilidades de crear una carta de',
            [2] = '{C:spectral}el alma{}, {C:spectral}agujero negro{} o y {C:attention}poroto misterio{}',
            [3] = 'cuando se selecciona la {C:attention}ciega{}',
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 0,
        y = 0
    },
    soul_pos = {
        x = 1,
        y = 0
    },
    display_size = {
        w = 71 * 1,
        h = 95 * 1
    },
    cost = 20,
    rarity = 4,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'canal',

    loc_vars = function(self, info_queue, card)
        local new_numerator, new_denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'j_bp_canal')
        return { vars = { card.ability.extra.Spectral, card.ability.extra.poroto, new_numerator, new_denominator } }
    end,

    calculate = function(self, card, context)
        if context.setting_blind then
            if true then
                if SMODS.pseudorandom_probability(card, 'group_0_6b3bc123', 1, card.ability.extra.odds, 'j_bp_canal') then
                    SMODS.calculate_effect({
                        func = function()
                            local created_consumable = true
                            G.E_MANAGER:add_event(Event({
                                func = function()
                                    SMODS.add_card { set = 'Spectral', key = 'c_soul', key_append = 'joker_forge_spectral' }
                                    return true
                                end
                            }))
                            if created_consumable then
                                card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil,
                                    { message = localize('k_plus_spectral'), colour = G.C.SECONDARY_SET.Spectral })
                            end
                            return true
                        end
                    }, card)
                end
                if SMODS.pseudorandom_probability(card, 'group_1_acc3fec2', 1, card.ability.extra.odds, 'j_bp_canal') then
                    SMODS.calculate_effect({
                        func = function()
                            local created_consumable = true
                            G.E_MANAGER:add_event(Event({
                                func = function()
                                    SMODS.add_card { set = 'poroto', key = 'c_bp_misterio', key_append = 'joker_forge_poroto' }
                                    return true
                                end
                            }))
                            if created_consumable then
                                card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil,
                                    { message = localize('k_plus_consumable'), colour = G.C.PURPLE })
                            end
                            return true
                        end
                    }, card)
                end
                if SMODS.pseudorandom_probability(card, 'group_2_84480462', 1, card.ability.extra.odds, 'j_bp_canal') then
                    SMODS.calculate_effect({
                        func = function()
                            local created_consumable = true
                            G.E_MANAGER:add_event(Event({
                                func = function()
                                    SMODS.add_card { set = 'Spectral', key = 'c_black_hole', key_append = 'joker_forge_spectral' }
                                    return true
                                end
                            }))
                            if created_consumable then
                                card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil,
                                    { message = localize('k_plus_spectral'), colour = G.C.SECONDARY_SET.Spectral })
                            end
                            return true
                        end
                    }, card)
                end
            end
        end
    end
}

--Yo
SMODS.Atlas {
    key = 'yo',
    path = 'yo.png',
    px = 71,
    py = 95
}

SMODS.Joker {
    key = "yomerengues",
    config = {
        extra = {
        }
    },
    loc_txt = {
        ['name'] = 'Kahn',
        ['text'] = {
            [1] = '{X:green,C:white}Creador del Mod{}',
            [2] = '{C:attention}Reactiva{} todos los {C:green}comodines verdes{}',
            [3] = '{C:attention}Desabilita{} todas las {C:green}ciegas verdes{}',
        }
    },
    pos = { x = 0, y = 0 },
    soul_pos = {
        x = 1,
        y = 0
    },
    display_size = { w = 71, h = 95 },
    cost = 50,
    rarity = "bp_secreto",
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'yo',

    calculate = function(self, card, context)
        if context.retrigger_joker_check and context.other_card and (context.other_card.config.center.pools and context.other_card.config.center.pools.Green == true) then
            return {
                repetitions = 1
            }
        else
            if context.setting_blind and not context.blueprint then
                if (G.GAME.blind.boss and (G.GAME.blind.config.blind.key == "bl_wheel" or G.GAME.blind.config.blind.key == "bl_club" or G.GAME.blind.config.blind.key == "bl_plant" or G.GAME.blind.config.blind.key == "bl_serpent" or G.GAME.blind.config.blind.key == "bl_needle" or G.GAME.blind.config.blind.key == "bl_final_leaf")) then
                    return {
                        func = function()
                            if G.GAME.blind and G.GAME.blind.boss and not G.GAME.blind.disabled then
                                G.E_MANAGER:add_event(Event({
                                    func = function()
                                        G.GAME.blind:disable()
                                        play_sound('timpani')
                                        return true
                                    end
                                }))
                                card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil,
                                    { message = localize('ph_boss_disabled'), colour = G.C.GREEN })
                            end
                            return true
                        end
                    }
                end
            end
        end
    end
}

--Yui
SMODS.Atlas {
    key = 'yui',
    path = 'yui.png',
    px = 71,
    py = 95
}

SMODS.Joker {
    key = "yui",
    config = {
        extra = {
            n = 0
        }
    },
    loc_txt = {
        ['name'] = 'Yui',
        ['text'] = {
            [1] = '{X:chips,C:white}Artista DeLasPorotoCards{}',
            [2] = 'Cuando se juega un {C:attention}par{} de {C:attention}reinas{}',
            [3] = 'crea 2 cartas {C:spectral}espectrales{}',
            [4] = '{C:attention}Desabilita{} todas las {C:blue}ciegas azules{}'
        }
    },
    ['unlock'] = {
        [1] = 'Unlocked by default.'
    },
    pos = {
        x = 0,
        y = 0
    },
    soul_pos = {
        x = 1,
        y = 0
    },
    display_size = {
        w = 71 * 1,
        h = 95 * 1
    },
    cost = 50,
    rarity = "bp_secreto",
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'yui',

    calculate = function(self, card, context)
        if context.before and context.cardarea == G.jokers and not context.blueprint then
            if (function()
                    local rankCount = 0
                    for i, c in ipairs(context.scoring_hand) do
                        if c:get_id() == 12 then
                            rankCount = rankCount + 1
                        end
                    end

                    return rankCount >= 2
                end)() then
                return {

                    func = function()
                        for i = 1, 2 do
                            G.E_MANAGER:add_event(Event({
                                trigger = 'after',
                                delay = 0.4,
                                func = function()
                                    play_sound('timpani')
                                    SMODS.add_card({ set = 'Spectral', soulable = true, })
                                    card:juice_up(0.3, 0.5)
                                    return true
                                end
                            }))
                        end
                        delay(0.6)

                        if created_consumable then
                            card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil,
                                { message = localize('k_plus_spectral'), colour = G.C.SECONDARY_SET.Spectral })
                        end
                        return true
                    end
                }
            end
        end
        if context.setting_blind and not context.blueprint then
            if (G.GAME.blind.boss and (G.GAME.blind.config.blind.key == "bl_house" or G.GAME.blind.config.blind.key == "bl_arm" or G.GAME.blind.config.blind.key == "bl_fish" or G.GAME.blind.config.blind.key == "bl_water" or G.GAME.blind.config.blind.key == "bl_eye" or G.GAME.blind.config.blind.key == "bl_final_bell")) then
                return {
                    func = function()
                        if G.GAME.blind and G.GAME.blind.boss and not G.GAME.blind.disabled then
                            G.E_MANAGER:add_event(Event({
                                func = function()
                                    G.GAME.blind:disable()
                                    play_sound('timpani')
                                    return true
                                end
                            }))
                            card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil,
                                { message = localize('ph_boss_disabled'), colour = G.C.GREEN })
                        end
                        return true
                    end
                }
            end
        end
    end
}

--Aidrags
SMODS.Atlas {
    key = 'drags',
    path = 'drags.png',
    px = 71,
    py = 95
}

SMODS.Joker {
    key = "aidrags",
    config = {
        extra = {
            xmultvar = 1
        }
    },
    loc_txt = {
        ['name'] = 'Aidrags',
        ['text'] = {
            [1] = '{X:tarot,C:white}Illustrador{}',
            [2] = 'Acumula {X:red,C:white}X0.2{} de {C:red}multi{} por',
            [3] = 'cada {C:attention}Escalera{} jugada seguida',
            [4] = '{C:inactive}(Actualmente {}{X:red,C:white}X#1#{} {C:inactive}multi){}',
            [5] = '{C:attention}Desabilita{} todas las {C:tarot}ciegas rosas y moradas{}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 0,
        y = 0
    },
    soul_pos = {
        x = 1,
        y = 0
    },
    display_size = {
        w = 71 * 1,
        h = 95 * 1
    },
    cost = 50,
    rarity = "bp_secreto",
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'drags',

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.xmultvar } }
    end,

    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main then
            if next(context.poker_hands["Straight"]) then
                card.ability.extra.xmultvar = (card.ability.extra.xmultvar) + 0.2
                return {
                    message = "Mejora",
                    extra = {
                        Xmult = card.ability.extra.xmultvar
                    }
                }
            elseif not (next(context.poker_hands["Straight"])) then
                card.ability.extra.xmultvar = 1
                return {
                    message = "Restablecer"
                }
            end
        end
        if context.setting_blind then
            if (G.GAME.blind.boss and (G.GAME.blind.config.blind.key == "bl_wall" or G.GAME.blind.config.blind.key == "bl_goad" or G.GAME.blind.config.blind.key == "bl_mouth" or G.GAME.blind.config.blind.key == "bl_head" or G.GAME.blind.config.blind.key == "bl_final_vessel")) then
                return {
                    func = function()
                        if G.GAME.blind and G.GAME.blind.boss and not G.GAME.blind.disabled then
                            G.E_MANAGER:add_event(Event({
                                func = function()
                                    G.GAME.blind:disable()
                                    play_sound('timpani')
                                    return true
                                end
                            }))
                            card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil,
                                { message = localize('ph_boss_disabled'), colour = G.C.GREEN })
                        end
                        return true
                    end
                }
            end
        end
    end
}

--Marronsita
SMODS.Atlas {
    key = 'dios',
    path = 'dios.png',
    px = 71,
    py = 95
}

SMODS.Joker {
    key = "marronsita",
    config = {
        extra = {
            mult = 5,
        }
    },
    loc_txt = {
        ['name'] = 'Marronsita',
        ['text'] = {
            [1] = '{X:diamonds,C:white}Marronsita{}',
            [2] = 'Al venderlo crea otras 2 {C:attention}Marronsitas{}',
            [3] = '{C:red}+5{} mult por cada {C:attention}marronsita{}',
            [4] = '{C:inactive}({}{C:attention}50%{}{C:inactive} de ser {}{C:blue}eterno{}{C:inactive}){}',
            [5] = '{C:inactive}({}{C:attention}25%{}{C:inactive} de ser de {}{C:gold}alquiler{}{C:inactive}){}',
            [6] = '{C:inactive}({}{C:attention}5%{}{C:inactive} de ser {}{C:dark_edition}negativo{}{C:inactive}){}',
            [7] = '{C:attention}Desabilita{} todas las {C:attention}ciegas naranjas y cafes{}'
        }
    },
    pos = { x = 0, y = 0 },
    soul_pos = {
        x = 1,
        y = 0
    },
    display_size = { w = 71, h = 95 },
    cost = 1,
    rarity = "bp_secreto",
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'dios',

    calculate = function(self, card, context)
        -- multiplicador normal
        if context.other_joker and (context.other_joker.config.center.pools and context.other_joker.config.center.pools.Marronsita == true) then
            return { mult = card.ability.extra.mult }
        end

        -- cuando se vende a sí mismo
        if context.selling_self and not context.blueprint then
            return {
                func = function()
                    local created_joker = true
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            local joker_card = SMODS.add_card({ set = 'Joker', key = 'j_bp_marronsita' })
                            if joker_card then
                                -- 50% eterno vs nada
                                if math.random() < 0.5 then
                                    joker_card.ability.eternal = true
                                end
                                -- 25% rental
                                if math.random() < 0.25 then
                                    joker_card.ability.rental = true
                                end
                                -- 5% negativo
                                if math.random() < 0.05 then
                                    joker_card:set_edition('e_negative', true)
                                end

                                card_eval_status_text(
                                    context.blueprint_card or card,
                                    'extra', nil, nil, nil,
                                    { message = "Marronsita", colour = G.C.BLUE }
                                )
                            end

                            return true
                        end
                    }))

                    if created_joker then
                        card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil,
                            { message = localize('k_plus_joker'), colour = G.C.BLUE })
                    end
                    return true
                end,
                extra = {
                    func = function()
                        local created_joker = true
                        G.E_MANAGER:add_event(Event({
                            func = function()
                                local joker_card = SMODS.add_card({ set = 'Joker', key = 'j_bp_marronsita' })
                                if joker_card then
                                    -- 50% eterno vs nada
                                    if math.random() < 0.5 then
                                        joker_card.ability.eternal = true
                                    end
                                    -- 25% rental
                                    if math.random() < 0.25 then
                                        joker_card.ability.rental = true
                                    end
                                    -- 5% negativo
                                    if math.random() < 0.05 then
                                        joker_card:set_edition('e_negative', true)
                                    end

                                    card_eval_status_text(
                                        context.blueprint_card or card,
                                        'extra', nil, nil, nil,
                                        { message = "Marronsita", colour = G.C.BLUE }
                                    )
                                end

                                return true
                            end
                        }))

                        if created_joker then
                            card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil,
                                { message = localize('k_plus_joker'), colour = G.C.BLUE })
                        end
                        return true
                    end,
                    colour = G.C.BLUE
                }
            }
        else
            if context.setting_blind and not context.blueprint then
                if (G.GAME.blind.boss and (G.GAME.blind.config.blind.key == "bl_ox" or G.GAME.blind.config.blind.key == "bl_window" or G.GAME.blind.config.blind.key == "bl_pillar" or G.GAME.blind.config.blind.key == "bl_flint")) then
                    return {
                        func = function()
                            if G.GAME.blind and G.GAME.blind.boss and not G.GAME.blind.disabled then
                                G.E_MANAGER:add_event(Event({
                                    func = function()
                                        G.GAME.blind:disable()
                                        play_sound('timpani')
                                        return true
                                    end
                                }))
                            end
                            return true
                        end
                    }
                end
            end
        end
    end
}
