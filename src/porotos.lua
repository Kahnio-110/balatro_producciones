--SET
SMODS.ConsumableType {
    key = 'poroto',
    primary_colour = HEX('f8c65b'),
    secondary_colour = HEX('f8c65b'),
    collection_rows = { 4, 5 },
    shop_rate = 0.5,
    pools = {
        ['poroton'] = true,
    },
    loc_txt = {
        name = "Porotos",
        collection = "Poroto Cards",
        undiscovered = {
            name = 'Poroto sin descubrir',
            text = { 'Encuentra esta carta' },
        }
    }
}

SMODS.Atlas {
    key = 'p_atlas',
    path = 'Porotocards.png',
    px = 71,
    py = 95
}

SMODS.UndiscoveredSprite {
    key = 'porotomisterio',
    atlas = 'civer',
    SMODS.Atlas {
        atlas = "civer",
        key = 'civer',
        px = 71,
        py = 95,
        path = 'civer.png'
    },
    pos = { x = 0, y = 0 }
}

--Poroto
SMODS.Consumable {
    key = 'poroton',
    set = 'poroto',
    atlas = 'p_atlas',
    pos = { x = 4, y = 1 },
    config = { extra = {
        consumable_count = 2
    } },
    loc_txt = {
        name = 'Poroto',
        text = {
            [1] = 'Genera 2 {C:tarot}Rueda de la fortuna{}',
            [2] = '{C:inactive}(Debe haber espacio){}'
        }
    },
    unlocked = true,
    discovered = false,
    use = function(self, card, area, copier)
        local used_card = copier or card
        for i = 1, math.min(2, G.consumeables.config.card_limit - #G.consumeables.cards) do
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.4,
                func = function()
                    if G.consumeables.config.card_limit > #G.consumeables.cards then
                        play_sound('timpani')
                        SMODS.add_card({ key = 'c_wheel_of_fortune' })
                        used_card:juice_up(0.3, 0.5)
                    end
                    return true
                end
            }))
        end
        delay(0.6)
    end,
    can_use = function(self, card)
        return true
    end
}

--Gemelos
SMODS.Consumable {
    key = 'gemelos',
    set = 'poroto',
    atlas = 'p_atlas',
    pos = { x = 7, y = 0 },
    loc_txt = {
        name = 'Porotos Gemelos',
        text = {
            [1] = 'Genera una {C:attention}etiqueta doble{}.'
        }
    },
    cost = 3,
    unlocked = true,
    discovered = false,
    hidden = false,
    can_repeat_soul = true,
    use = function(self, card, area, copier)
        local used_card = copier or card
        G.E_MANAGER:add_event(Event({
            func = function()
                local tag = Tag("tag_double")
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
    end,
    can_use = function(self, card)
        return true
    end
}

--Apostador
SMODS.Consumable {
    key = 'apostador',
    set = 'poroto',
    atlas = 'p_atlas',
    pos = { x = 1, y = 0 },
    loc_txt = {
        name = 'Poroto Apostador',
        text = {
            [1] = 'Genera una {C:attention}etiqueta D6{}.'
        }
    },
    cost = 3,
    unlocked = true,
    discovered = false,
    hidden = false,
    can_repeat_soul = true,
    use = function(self, card, area, copier)
        local used_card = copier or card
        G.E_MANAGER:add_event(Event({
            func = function()
                local tag = Tag("tag_d_six")
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
    end,
    can_use = function(self, card)
        return true
    end
}

--Ladrón
SMODS.Consumable {
    key = 'ladron',
    set = 'poroto',
    atlas = 'p_atlas',
    pos = { x = 9, y = 0 },
    loc_txt = {
        name = 'Poroto Ladrón',
        text = {
            [1] = 'Genera una {C:attention}etiqueta cupón{}.'
        }
    },
    cost = 3,
    unlocked = true,
    discovered = false,
    hidden = false,
    can_repeat_soul = true,
    use = function(self, card, area, copier)
        local used_card = copier or card
        G.E_MANAGER:add_event(Event({
            func = function()
                local tag = Tag("tag_coupon")
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
    end,
    can_use = function(self, card)
        return true
    end
}

--Astronauta
SMODS.Consumable {
    key = 'astronauta',
    set = 'poroto',
    atlas = 'p_atlas',
    pos = { x = 2, y = 0 },
    loc_txt = {
        name = 'Poroto Astronauta',
        text = {
            [1] = 'Genera una {C:attention}etiqueta orbital{}.'
        }
    },
    cost = 3,
    unlocked = true,
    discovered = false,
    hidden = false,
    can_repeat_soul = true,
    use = function(self, card, area, copier)
        local used_card = copier or card
        G.E_MANAGER:add_event(Event({
            func = function()
                local tag = Tag("tag_orbital")
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
    end,
    can_use = function(self, card)
        return true
    end
}

--Acrobata
SMODS.Consumable {
    key = 'acrobata',
    set = 'poroto',
    atlas = 'p_atlas',
    pos = { x = 0, y = 0 },
    loc_txt = {
        name = 'Poroto Acróbata',
        text = {
            [1] = 'Genera una {C:attention}etiqueta malabar{}.'
        }
    },
    cost = 3,
    unlocked = true,
    discovered = false,
    hidden = false,
    can_repeat_soul = true,
    use = function(self, card, area, copier)
        local used_card = copier or card
        G.E_MANAGER:add_event(Event({
            func = function()
                local tag = Tag("tag_juggle")
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
    end,
    can_use = function(self, card)
        return true
    end
}

--Rebelde
SMODS.Consumable {
    key = 'rebelde',
    set = 'poroto',
    atlas = 'p_atlas',
    pos = { x = 5, y = 1 },
    loc_txt = {
        name = 'Poroto Rebelde',
        text = {
            [1] = 'Genera una {C:attention}etiqueta de jefe{}.'
        }
    },
    cost = 3,
    unlocked = true,
    discovered = false,
    hidden = false,
    can_repeat_soul = true,
    use = function(self, card, area, copier)
        local used_card = copier or card
        G.E_MANAGER:add_event(Event({
            func = function()
                local tag = Tag("tag_boss")
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
    end,
    can_use = function(self, card)
        return true
    end
}

--Cineasta
SMODS.Consumable {
    key = 'cineasta',
    set = 'poroto',
    atlas = 'p_atlas',
    pos = { x = 4, y = 0 },
    loc_txt = {
        name = 'Poroto Cineasta',
        text = {
            [1] = 'Genera una {C:attention}etiqueta de vale{}.'
        }
    },
    cost = 3,
    unlocked = true,
    discovered = false,
    hidden = false,
    can_repeat_soul = true,
    use = function(self, card, area, copier)
        local used_card = copier or card
        G.E_MANAGER:add_event(Event({
            func = function()
                local tag = Tag("tag_voucher")
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
    end,
    can_use = function(self, card)
        return true
    end
}

--Óptico
SMODS.Consumable {
    key = 'optico',
    set = 'poroto',
    atlas = 'p_atlas',
    pos = { x = 2, y = 1 },
    loc_txt = {
        name = 'Poroto Óptico',
        text = {
            'Genera una {C:attention}etiqueta de edición{}.',
            '{C:inactive}(Aleatoria entre {C:dark_edition}laminada, holografica,{}',
            '{C:dark_edition}policromada y negativa{}{C:inactive}){}.'
        }
    },
    cost = 3,
    unlocked = true,
    discovered = false,
    hidden = false,
    can_repeat_soul = true,
    use = function(self, card, area, copier)
        local used_card = copier or card
        if not ((G.GAME.pool_flags.bp_poly or false)) then
            G.E_MANAGER:add_event(Event({
                func = function()
                    local tag = Tag(pseudorandom_element({ "tag_negative", "tag_foil", "tag_holo", "tag_polychrome" },
                        "seed"))
                    tag:set_ability()
                    add_tag(tag)
                    play_sound('holo1', 1.2 + math.random() * 0.1, 0.4)
                    return true
                end
            }))
        else
            local used_card = copier or card
            if (G.GAME.pool_flags.bp_poly or false) then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        local tag = Tag("tag_polychrome")
                        tag:set_ability()
                        add_tag(tag)
                        play_sound('holo1', 1.2 + math.random() * 0.1, 0.4)
                        return true
                    end
                }))
            end
        end
    end,
    can_use = function(self, card)
        return true
    end
}

--Cartero
SMODS.Consumable {
    key = 'cartero',
    set = 'poroto',
    atlas = 'p_atlas',
    pos = { x = 3, y = 0 },
    loc_txt = {
        name = 'Poroto Cartero',
        text = {
            'Genera una {C:attention}etiqueta de booster pack{}.',
            '{C:inactive}(Aleatoria entre {C:attention}standard,{}{C:tarot} encantado,{}',
            '{C:planet}meteoro,{}{C:spectral} etérea{}{C:common} y bufón{}{C:inactive}){}'
        }
    },
    cost = 3,
    unlocked = true,
    discovered = false,
    hidden = false,
    can_repeat_soul = true,
    use = function(self, card, area, copier)
        local used_card = copier or card
        G.E_MANAGER:add_event(Event({
            func = function()
                local tag = Tag(pseudorandom_element(
                    { "tag_charm", "tag_standard", "tag_buffoon", "tag_meteor", "tag_ethereal" }, "seed"))
                tag:set_ability()
                add_tag(tag)
                play_sound('holo1', 1.2 + math.random() * 0.1, 0.4)
                return true
            end
        }))
    end,
    can_use = function(self, card)
        return true
    end
}


--Payaso
SMODS.Consumable {
    key = 'payaso',
    set = 'poroto',
    atlas = 'p_atlas',
    pos = { x = 3, y = 1 },
    loc_txt = {
        name = 'Porotoyaso',
        text = {
            'Genera una {C:attention}etiqueta de comodín{}.',
            '{C:inactive}(Aleatoria entre {C:common}recarga,{}',
            '{C:uncommon} inusual,{} o {C:rare}rara{}{C:inactive}){}'
        }
    },
    cost = 3,
    unlocked = true,
    discovered = false,
    hidden = false,
    can_repeat_soul = true,
    use = function(self, card, area, copier)
        local used_card = copier or card
        G.E_MANAGER:add_event(Event({
            func = function()
                local tag = Tag(pseudorandom_element({ "tag_top_up", "tag_uncommon", "tag_rare" }, "seed"))
                tag:set_ability()
                add_tag(tag)
                play_sound('holo1', 1.2 + math.random() * 0.1, 0.4)
                return true
            end
        }))
    end,
    can_use = function(self, card)
        return true
    end
}

--Inversionista
SMODS.Consumable {
    key = 'inversionista',
    set = 'poroto',
    atlas = 'p_atlas',
    pos = { x = 8, y = 0 },
    loc_txt = {
        name = 'Poroto Inversionista',
        text = {
            'Genera una {C:attention}etiqueta de dinero{}.',
            '{C:inactive}(Aleatoria entre {C:gold}veloz, basura{}',
            '{C:gold}manual, inversión y economia{}{C:inactive}){}'
        }
    },
    cost = 3,
    unlocked = true,
    discovered = false,
    hidden = false,
    can_repeat_soul = true,
    use = function(self, card, area, copier)
        local used_card = copier or card
        G.E_MANAGER:add_event(Event({
            func = function()
                local tag = Tag(pseudorandom_element(
                    { "tag_investment", "tag_economy", "tag_garbage", "tag_handy", "tag_skip" }, "seed"))
                tag:set_ability()
                add_tag(tag)
                play_sound('holo1', 1.2 + math.random() * 0.1, 0.4)
                return true
            end
        }))
    end,
    can_use = function(self, card)
        return true
    end
}

-- Verdugo
SMODS.Consumable {
    key = 'verdugo',
    set = 'poroto',
    atlas = 'p_atlas',
    pos = { x = 7, y = 1 },
    loc_txt = {
        name = 'Poroto Verdugo',
        text = {
            'Destruye a todos los {C:attention}Comodines{}',
            'y agrega {C:attention}+1 ranura de comodín{}',
        }
    },
    cost = 3,
    unlocked = true,
    discovered = false,
    hidden = false,
    can_repeat_soul = false,
    use = function(self, card, area, copier)
        local used_card = copier or card
        local jokers_to_destroy = {}

        -- Recolectar todos los jokers que no sean eternos
        for _, joker in pairs(G.jokers.cards) do
            if joker.ability.set == 'Joker' and not SMODS.is_eternal(joker, card) then
                table.insert(jokers_to_destroy, joker)
            end
        end

        -- Efecto visual de usar el poroto
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                play_sound('tarot1')
                used_card:juice_up(0.3, 0.5)
                return true
            end
        }))

        -- Disolver todos los jokers
        local _first_dissolve = nil
        G.E_MANAGER:add_event(Event({
            trigger = 'before',
            delay = 0.75,
            func = function()
                for _, joker in ipairs(jokers_to_destroy) do
                    joker:start_dissolve(nil, _first_dissolve)
                    _first_dissolve = true
                end
                return true
            end
        }))

        delay(0.6)

        -- Sumar 1 slot de comodín
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                card_eval_status_text(used_card, 'extra', nil, nil, nil,
                    { message = "+1 ranura de comodín", colour = G.C.DARK_EDITION })
                G.jokers.config.card_limit = G.jokers.config.card_limit + 1
                return true
            end
        }))

        delay(0.6)
    end,
    can_use = function(self, card)
        return true
    end
}

-- Vagabundo
SMODS.Consumable {
    key = 'vagabundo',
    set = 'poroto',
    atlas = 'p_atlas',
    pos = { x = 6, y = 1 },
    loc_txt = {
        name = 'Poroto Vagabundo',
        text = {
            '{C:red}+1{} al {C:attention}tamaño de descarte{}',
            '{C:red}-1{} al {C:attention}tamaño de mano{}',
        }
    },
    cost = 3,
    unlocked = true,
    discovered = false,
    hidden = false,
    can_repeat_soul = false,
    use = function(self, card, area, copier)
        local used_card = copier or card
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                card_eval_status_text(used_card, 'extra', nil, nil, nil,
                    { message = "+1 Tamaño de Descarte", colour = G.C.BLUE })
                SMODS.change_discard_limit(1)
                return true
            end
        }))
        delay(0.6)
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                card_eval_status_text(used_card, 'extra', nil, nil, nil,
                    { message = "-1 Tamaño de Mano", colour = G.C.RED })
                G.hand:change_size(-1)
                return true
            end
        }))
        delay(0.6)
    end,
    can_use = function(self, card)
        return true
    end
}

-- Loco
SMODS.Consumable {
    key = 'loco',
    set = 'poroto',
    atlas = 'p_atlas',
    pos = { x = 0, y = 1 },
    loc_txt = {
        name = 'Poroto Loco',
        text = {
            'Le da un encantamiento {C:attention}aleateorio{}',
            'a {C:attention}3{} cartas {C:attention}seleccionadas{}',
        }
    },
    cost = 3,
    unlocked = true,
    discovered = false,
    hidden = false,
    can_repeat_soul = false,
    use = function(self, card, area, copier)
        local used_card = copier or card
        if (#G.hand.highlighted <= 3 and #G.hand.highlighted > 1) then
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.4,
                func = function()
                    play_sound('tarot1')
                    used_card:juice_up(0.3, 0.5)
                    return true
                end
            }))
            for i = 1, #G.hand.highlighted do
                local percent = 1.15 - (i - 0.999) / (#G.hand.highlighted - 0.998) * 0.3
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.15,
                    func = function()
                        G.hand.highlighted[i]:flip()
                        play_sound('card1', percent)
                        G.hand.highlighted[i]:juice_up(0.3, 0.3)
                        return true
                    end
                }))
            end
            delay(0.2)
            for i = 1, #G.hand.highlighted do
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.1,
                    func = function()
                        local cen_pool = {}
                        for _, enhancement_center in pairs(G.P_CENTER_POOLS["Enhanced"]) do
                            if enhancement_center.key ~= 'm_stone' then
                                cen_pool[#cen_pool + 1] = enhancement_center
                            end
                        end
                        local enhancement = pseudorandom_element(cen_pool, 'random_enhance')
                        G.hand.highlighted[i]:set_ability(enhancement)
                        return true
                    end
                }))
            end
            for i = 1, #G.hand.highlighted do
                local percent = 0.85 + (i - 0.999) / (#G.hand.highlighted - 0.998) * 0.3
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.15,
                    func = function()
                        G.hand.highlighted[i]:flip()
                        play_sound('tarot2', percent, 0.6)
                        G.hand.highlighted[i]:juice_up(0.3, 0.3)
                        return true
                    end
                }))
            end
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.2,
                func = function()
                    G.hand:unhighlight_all()
                    return true
                end
            }))
            delay(0.5)
        end
    end,
    can_use = function(self, card)
        return ((#G.hand.highlighted <= 3 and #G.hand.highlighted > 0))
    end
}

-- Fantasma
SMODS.Consumable {
    key = 'fantasma',
    set = 'poroto',
    atlas = 'p_atlas',
    pos = { x = 6, y = 0 },
    loc_txt = {
        name = 'Poroto Fantasma',
        text = {
            'Agrega {C:dark_edition}negativo{} a una carta de juego {C:attention}seleccionada{}',
            'y remueve su {C:attention}sello{} y {C:enhanced}mejora{}',
        }
    },
    cost = 3,
    unlocked = true,
    discovered = false,
    hidden = false,
    can_repeat_soul = false,
    use = function(self, card, area, copier)
        local used_card = copier or card
        if (#G.hand.highlighted == 1 and not (G.GAME.pool_flags.bp_poly or false)) then
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.4,
                func = function()
                    play_sound('tarot1')
                    used_card:juice_up(0.3, 0.5)
                    return true
                end
            }))
            for i = 1, #G.hand.highlighted do
                local percent = 1.15 - (i - 0.999) / (#G.hand.highlighted - 0.998) * 0.3
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.15,
                    func = function()
                        G.hand.highlighted[i]:flip()
                        play_sound('card1', percent)
                        G.hand.highlighted[i]:juice_up(0.3, 0.3)
                        return true
                    end
                }))
            end
            delay(0.2)
            for i = 1, #G.hand.highlighted do
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.1,
                    func = function()
                        G.hand.highlighted[i]:set_ability(G.P_CENTERS.c_base)
                        return true
                    end
                }))
            end
            for i = 1, #G.hand.highlighted do
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.1,
                    func = function()
                        G.hand.highlighted[i]:set_seal(nil, nil, true)
                        return true
                    end
                }))
            end
            for i = 1, #G.hand.highlighted do
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.1,
                    func = function()
                        G.hand.highlighted[i]:set_edition({ negative = true }, true)
                        return true
                    end
                }))
            end
            for i = 1, #G.hand.highlighted do
                local percent = 0.85 + (i - 0.999) / (#G.hand.highlighted - 0.998) * 0.3
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.15,
                    func = function()
                        G.hand.highlighted[i]:flip()
                        play_sound('tarot2', percent, 0.6)
                        G.hand.highlighted[i]:juice_up(0.3, 0.3)
                        return true
                    end
                }))
            end
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.2,
                func = function()
                    G.hand:unhighlight_all()
                    return true
                end
            }))
            delay(0.5)
        end
        if (#G.hand.highlighted == 1 and (G.GAME.pool_flags.bp_poly or false)) then
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.4,
                func = function()
                    play_sound('tarot1')
                    used_card:juice_up(0.3, 0.5)
                    return true
                end
            }))
            for i = 1, #G.hand.highlighted do
                local percent = 1.15 - (i - 0.999) / (#G.hand.highlighted - 0.998) * 0.3
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.15,
                    func = function()
                        G.hand.highlighted[i]:flip()
                        play_sound('card1', percent)
                        G.hand.highlighted[i]:juice_up(0.3, 0.3)
                        return true
                    end
                }))
            end
            delay(0.2)
            for i = 1, #G.hand.highlighted do
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.1,
                    func = function()
                        G.hand.highlighted[i]:set_ability(G.P_CENTERS.c_base)
                        return true
                    end
                }))
            end
            for i = 1, #G.hand.highlighted do
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.1,
                    func = function()
                        G.hand.highlighted[i]:set_seal(nil, nil, true)
                        return true
                    end
                }))
            end
            for i = 1, #G.hand.highlighted do
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.1,
                    func = function()
                        G.hand.highlighted[i]:set_edition('e_polychrome', true)
                        return true
                    end
                }))
            end
            for i = 1, #G.hand.highlighted do
                local percent = 0.85 + (i - 0.999) / (#G.hand.highlighted - 0.998) * 0.3
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.15,
                    func = function()
                        G.hand.highlighted[i]:flip()
                        play_sound('tarot2', percent, 0.6)
                        G.hand.highlighted[i]:juice_up(0.3, 0.3)
                        return true
                    end
                }))
            end
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.2,
                func = function()
                    G.hand:unhighlight_all()
                    return true
                end
            }))
            delay(0.5)
        end
    end,
    can_use = function(self, card)
        return ((#G.hand.highlighted == 1))
    end
}

--Derrochador
SMODS.Consumable {
    key = 'comprador',
    set = 'poroto',
    atlas = 'p_atlas',
    pos = { x = 5, y = 0 },
    config = { extra = {
        voucher_gain = 1,
        booster_slots_value = 1,
        shop_size = 1,
        dollars_value = -20
    } },
    loc_txt = {
        name = 'Poroto Derrochador',
        text = {
            [1] = '{C:attention}Agrega{} un espacio a cada',
            [2] = 'apartado en la {C:attention}tienda{}',
            [3] = 'Deja tu {C:money}dinero{} en {C:red}-20{}'
        }
    },
    cost = 3,
    unlocked = true,
    discovered = false,
    hidden = false,
    can_repeat_soul = false,
    use = function(self, card, area, copier)
        local used_card = copier or card
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                SMODS.change_voucher_limit(card.ability.extra.voucher_gain)
                return true
            end
        }))
        delay(0.6)
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                SMODS.change_booster_limit(1)
                return true
            end
        }))
        delay(0.6)
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                change_shop_size(card.ability.extra.shop_size)
                return true
            end
        }))
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                local current_dollars = G.GAME.dollars
                local target_dollars = -20
                local difference = target_dollars - current_dollars
                ease_dollars(difference, true)
                return true
            end
        }))
        delay(0.6)
    end,
    can_use = function(self, card)
        return true
    end
}

--Poroto Misterio
SMODS.Consumable {
    key = 'misterio',
    set = 'poroto',
    atlas = 'p_atlas',
    pos = { x = 1, y = 1 },
    config = { extra = {
        consumable_count = 2
    } },
    loc_txt = {
        name = 'Poroto Misterio',
        text = {
            [1] = 'Crea un comodín {C:dark_edition}secreto{}',
            [2] = '{C:inactive}(Debe haber espacio){}'
        }
    },
    unlocked = true,
    discovered = false,
    hidden = true,
    soul_set = 'Tarot',
    soul_rate = 0.005,
    use = function(self, card, area, copier)
        local used_card = copier or card
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                play_sound('timpani')
                SMODS.add_card({ set = 'Joker', rarity = 'bp_secreto' })
                used_card:juice_up(0.3, 0.5)
                return true
            end
        }))
        delay(0.6)
    end,
    can_use = function(self, card)
        return true
    end
}
