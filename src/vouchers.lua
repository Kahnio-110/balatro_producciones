--Mercader
SMODS.Voucher {
    key = 'mercader',
    atlas = 'porotolandia',
    SMODS.Atlas {
        key = 'porotolandia',
        path = 'porotolandia.png',
        px = 71,
        py = 95
    },
    pos = { x = 0, y = 0 },
    unlocked = true,
    loc_txt = {
        name = 'Mercader de Hamsters',
        text = {
            [1] = 'Las {C:attention}Poroto Cards{} aparecen',
            [2] = '{C:attention}2X{} veces más seguido',
            [3] = 'en la tienda'
        }
    },
    config = { extra = { rate = 2.4, display = 2 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.display } }
    end,
    redeem = function(self, card)
        G.E_MANAGER:add_event(Event({
            func = function()
                G.GAME.poroto_rate = 2 * card.ability.extra.rate
                return true
            end
        }))
    end
}

--Magnate
SMODS.Voucher {
    key = 'magnate',
    atlas = 'porotonia',
    SMODS.Atlas {
        key = 'porotonia',
        path = 'porotonia.png',
        px = 71,
        py = 95
    },
    pos = { x = 0, y = 0 },
    unlocked = true,
    requires = { 'v_bp_mercader' },
    loc_txt = {
        name = 'Magnate de Hamsters',
        text = {
            [1] = 'Las {C:attention}Poroto Cards{} aparecen',
            [2] = '{C:attention}4X{} veces más seguido',
            [3] = 'en la tienda'
        }
    },
    config = { extra = { rate = 2.4, display = 2 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.display } }
    end,
    redeem = function(self, card)
        G.E_MANAGER:add_event(Event({
            func = function()
                G.GAME.poroto_rate = 2 * card.ability.extra.rate
                return true
            end
        }))
    end,
}

--Porotonia
SMODS.Voucher({
    key = "porotonia",
    atlas = 'pais',
    SMODS.Atlas {
        key = 'pais',
        path = 'pais.png',
        px = 71,
        py = 95
    },
    pos = { x = 0, y = 0 },
    loc_txt = {
        name = 'Porotonia',
        text = {
            [1] = 'Las {C:attention}Poroto Cards{} pueden',
            [2] = 'aparecer en {C:tarot}paquetes arcanos{}'
        }
    },
})

SMODS.Booster:take_ownership_by_kind('Arcana', {
        group_key = "k_arcana_pack",
        draw_hand = true,
        update_pack = SMODS.Booster.update_pack,
        ease_background_colour = function(self) ease_background_colour_blind(G.STATES.TAROT_PACK) end,
        create_UIBox = SMODS.Booster.create_UIBox,
        particles = function(self)
            G.booster_pack_sparkles = Particles(1, 1, 0, 0, {
                timer = 0.015,
                scale = 0.2,
                initialize = true,
                lifespan = 1,
                speed = 1.1,
                padding = -1,
                attach = G.ROOM_ATTACH,
                colours = { G.C.WHITE, lighten(G.C.PURPLE, 0.4), lighten(G.C.PURPLE, 0.2), lighten(G.C.GOLD, 0.2) },
                fill = true
            })
            G.booster_pack_sparkles.fade_alpha = 1
            G.booster_pack_sparkles:fade(1, 0)
        end,
        create_card = function(self, card, i)
            local _card
            if G.GAME.used_vouchers.v_omen_globe and pseudorandom('omen_globe') > 0.8 then
                _card = {
                    set = "Spectral",
                    area = G.pack_cards,
                    skip_materialize = true,
                    soulable = true,
                    key_append =
                    "ar2"
                }
            elseif G.GAME.used_vouchers.v_bp_porotonia and pseudorandom('bp_porotonia') > 0.8 then
                _card = {
                    set = "poroto",
                    area = G.pack_cards,
                    skip_materialize = true,
                    soulable = true,
                    key_append =
                    "ar3"
                }
            else
                _card = {
                    set = "Tarot",
                    area = G.pack_cards,
                    skip_materialize = true,
                    soulable = true,
                    key_append =
                    "ar1"
                }
            end
            return _card
        end,
        loc_vars = pack_loc_vars,
    },
    true
)

--Porotinvasión
SMODS.Voucher({
    key = "porotinvasion",
    atlas = 'invasion',
    SMODS.Atlas {
        key = 'invasion',
        path = 'invasion.png',
        px = 71,
        py = 95
    },
    requires = { 'v_bp_porotonia' },
    pos = { x = 0, y = 0 },
    loc_txt = {
        name = 'Porotinvasión',
        text = {
            [1] = 'Las {C:attention}Poroto Cards{} pueden',
            [2] = 'aparecer en {C:planet}paquetes celestiales{}',
            [3] = 'y en {C:spectral}paquetes espectrales{}'
        }
    },
})

SMODS.Booster:take_ownership_by_kind('Celestial', {
        group_key = "k_celestial_pack",
        draw_hand = false,
        update_pack = SMODS.Booster.update_pack,
        ease_background_colour = function(self)
            ease_background_colour_blind(G.STATES.PLANET_PACK)
        end,
        create_UIBox = SMODS.Booster.create_UIBox,

        particles = function(self)
            G.booster_pack_stars = Particles(1, 1, 0, 0, {
                timer = 0.07,
                scale = 0.1,
                initialize = true,
                lifespan = 15,
                speed = 0.1,
                padding = -4,
                attach = G.ROOM_ATTACH,
                colours = { G.C.WHITE, HEX('a7d6e0'), HEX('fddca0') },
                fill = true
            })
            G.booster_pack_meteors = Particles(1, 1, 0, 0, {
                timer = 2,
                scale = 0.05,
                lifespan = 1.5,
                speed = 4,
                attach = G.ROOM_ATTACH,
                colours = { G.C.WHITE },
                fill = true
            })
        end,

        create_card = function(self, card, i)
            local _card

            -- Si tienes el voucher Porotinvasión, hay un 20% de que salga una carta Poroto
            if G.GAME.used_vouchers.v_bp_porotinvasion and pseudorandom('bp_porotinvasion') > 0.8 then
                _card = {
                    set = "poroto",
                    area = G.pack_cards,
                    skip_materialize = true,
                    soulable = true,
                    key_append = "pl2"
                }

                -- Si tienes Telescope activo, fuerza el planeta de la mano más jugada
            elseif G.GAME.used_vouchers.v_telescope and i == 1 then
                local _planet, _hand, _tally = nil, nil, 0
                for _, handname in ipairs(G.handlist) do
                    if SMODS.is_poker_hand_visible(handname) and G.GAME.hands[handname].played > _tally then
                        _hand = handname
                        _tally = G.GAME.hands[handname].played
                    end
                end
                if _hand then
                    for _, planet_center in pairs(G.P_CENTER_POOLS.Planet) do
                        if planet_center.config.hand_type == _hand then
                            _planet = planet_center.key
                            break
                        end
                    end
                end
                _card = {
                    set = "Planet",
                    area = G.pack_cards,
                    skip_materialize = true,
                    soulable = true,
                    key = _planet,
                    key_append = "pl1"
                }

                -- Caso normal: carta planeta aleatoria
            else
                _card = {
                    set = "Planet",
                    area = G.pack_cards,
                    skip_materialize = true,
                    soulable = true,
                    key_append = "pl1"
                }
            end

            return _card
        end,

        loc_vars = pack_loc_vars,
    },
    true
)

SMODS.Booster:take_ownership_by_kind('Spectral', {
        group_key = "k_spectral_pack",
        draw_hand = true,
        update_pack = SMODS.Booster.update_pack,
        ease_background_colour = function(self) ease_background_colour_blind(G.STATES.SPECTRAL_PACK) end,
        create_UIBox = SMODS.Booster.create_UIBox,
        particles = function(self)
            G.booster_pack_stars = Particles(1, 1, 0, 0, {
                timer = 0.07,
                scale = 0.1,
                initialize = true,
                lifespan = 15,
                speed = 0.1,
                padding = -4,
                attach = G.ROOM_ATTACH,
                colours = { G.C.WHITE, HEX('a7d6e0'), HEX('fddca0') },
                fill = true
            })
            G.booster_pack_meteors = Particles(1, 1, 0, 0, {
                timer = 2,
                scale = 0.05,
                lifespan = 1.5,
                speed = 4,
                attach = G.ROOM_ATTACH,
                colours = { G.C.WHITE },
                fill = true
            })
        end,
        create_card = function(self, card, i)
            local _card
            if G.GAME.used_vouchers.v_bp_porotinvasion and pseudorandom('bp_porotinvasion') > 0.8 then
                _card = {
                    set = "poroto",
                    area = G.pack_cards,
                    skip_materialize = true,
                    soulable = true,
                    key_append =
                    "spe2"
                }
            else
                _card = {
                    set = "Spectral",
                    area = G.pack_cards,
                    skip_materialize = true,
                    soulable = true,
                    key_append =
                    "spe1"
                }
            end
            return _card
        end,
        loc_vars = pack_loc_vars,
    },
    true
)

--POPTAGONO
SMODS.Voucher {
    key = "poptagono",
    atlas = 'pop',
    SMODS.Atlas {
        key = 'pop',
        path = 'pop.png',
        px = 71,
        py = 95
    },
    loc_txt = {
        name = 'Poptagono',
        text = {
            [1] = 'Crea {C:attention}5{} etiquetas aleatorias',
            [2] = 'al derrotar {C:attention}ciega jefe{}',
        }
    },
    config = { extra = {
        repetitions = 5
    } },
    pos = { x = 0, y = 0 },
    cost = 10,
    loc_vars = function(self, info_queue, card)
        return { vars = { (G.GAME.probabilities.normal or 1), card.ability.extra.odds } }
    end,
    calculate = function(self, card, context)
        if
            G.GAME.last_blind.boss
            and context.end_of_round
            and context.main_eval
        then
            for i = 1, card.ability.extra.repetitions do
                G.E_MANAGER:add_event(Event({
                    func = function()
                        local selected_tag = pseudorandom_element(G.P_TAGS, pseudoseed("create_tag")).key
                        local tag = Tag(selected_tag)
                        if tag.name == "Orbital Tag" then
                            local _poker_hands = {}
                            for k, v in pairs(G.GAME.hands) do
                                if v.visible then
                                    _poker_hands[#_poker_hands + 1] = k
                                end
                            end
                            tag.ability.orbital_hand = pseudorandom_element(_poker_hands, "jokerforge_orbital")
                        end
                        tag:set_ability()
                        add_tag(tag)
                        play_sound('holo1', 1.2 + math.random() * 0.1, 0.4)
                        return true
                    end
                }))
            end
        end
        can_use = function(self, card)
            return true
        end
    end
}


--OCTAGOPOP
SMODS.Voucher {
    key = "poctagono",
    atlas = 'oct',
    SMODS.Atlas {
        key = 'oct',
        path = 'oct.png',
        px = 71,
        py = 95
    },
    loc_txt = {
        name = 'OctagoPop',
        text = {
            [1] = 'Crea {C:attention}8{} etiquetas aleatorias',
            [2] = 'al derrotar {C:attention}ciega jefe{}',
        }
    },
    requires = { 'v_bp_poptagono' },
    config = { extra = {
        repetitions = 3
    } },
    pos = { x = 0, y = 0 },
    cost = 10,
    loc_vars = function(self, info_queue, card)
        return { vars = { (G.GAME.probabilities.normal or 1), card.ability.extra.odds } }
    end,
    calculate = function(self, card, context)
        if
            G.GAME.last_blind.boss
            and context.end_of_round
            and context.main_eval
        then
            for i = 1, card.ability.extra.repetitions do
                G.E_MANAGER:add_event(Event({
                    func = function()
                        local selected_tag = pseudorandom_element(G.P_TAGS, pseudoseed("create_tag")).key
                        local tag = Tag(selected_tag)
                        if tag.name == "Orbital Tag" then
                            local _poker_hands = {}
                            for k, v in pairs(G.GAME.hands) do
                                if v.visible then
                                    _poker_hands[#_poker_hands + 1] = k
                                end
                            end
                            tag.ability.orbital_hand = pseudorandom_element(_poker_hands, "jokerforge_orbital")
                        end
                        tag:set_ability()
                        add_tag(tag)
                        play_sound('holo1', 1.2 + math.random() * 0.1, 0.4)
                        return true
                    end
                }))
            end
        end
        can_use = function(self, card)
            return true
        end
    end
}

SMODS.Voucher {
    key = "betoid",
    atlas = 'betoid',
    SMODS.Atlas {
        key = 'betoid',
        path = 'betoid.png',
        px = 71,
        py = 95
    },
    pos = { x = 0, y = 0 },
    cost = 10,
    config = { reduction = 0.90 }, -- 5% menos
    unlocked = true,
    discovered = false,
    loc_txt = {
        name = "Betoid",
        text = {
            "Reduce en {C:attention}5%{} el precio a alcanzar",
            "en todas las {C:attention}ciegas{}"
        }
    },

    -- cuando se canjea, aplicar reducción a las ciegas actuales y futuras
    redeem = function(self, card)
        -- bajar 5% a la ciega actual
        if G.GAME.blind and G.GAME.blind.chips then
            G.GAME.blind.chips = math.floor(G.GAME.blind.chips * self.config.reduction)
            G.GAME.blind.current_chips = G.GAME.blind.chips
        end
        -- y también modificar el escalado para las siguientes ciegas
        if G.GAME.starting_params and G.GAME.starting_params.ante_scaling then
            G.GAME.starting_params.ante_scaling = G.GAME.starting_params.ante_scaling * self.config.reduction
        end
    end,
}

SMODS.Voucher {
    key = "maloid",
    atlas = 'maloid',
    SMODS.Atlas {
        key = 'maloid',
        path = 'maloid.png',
        px = 71,
        py = 95
    },
    pos = { x = 0, y = 0 },
    cost = 10,
    config = { reduction = 5 / 6 },
    unlocked = true,
    discovered = false,
    requires = { 'v_bp_betoid' },
    loc_txt = {
        name = "Maloid",
        text = {
            "Reduce en {C:attention}25%{} el escaladado",
            "de las {C:attention}apuestas iniciales{}"
        }
    },

    -- cuando se canjea, aplicar reducción a las ciegas actuales y futuras
    redeem = function(self, card)
        -- bajar 5% a la ciega actuals
        if G.GAME.blind and G.GAME.blind.chips then
            G.GAME.blind.chips = math.floor(G.GAME.blind.chips * self.config.reduction)
            G.GAME.blind.current_chips = G.GAME.blind.chips
        end
        -- y también modificar el escalado para las siguientes ciegas
        if G.GAME.starting_params and G.GAME.starting_params.ante_scaling then
            G.GAME.starting_params.ante_scaling = G.GAME.starting_params.ante_scaling * self.config.reduction
        end
    end,
}
