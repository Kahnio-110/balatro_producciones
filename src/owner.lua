SMODS.Consumable:take_ownership(
    'wheel_of_fortune',
    {
        loc_txt = {
            ['name'] = 'La rueda de la fortuna',
            ['text'] = {
                '{C:green}1 en 4{} probabilidades de agregar',
                'que sean {C:dark_edition}laminadas{}, {C:dark_edition}holográficas{} o',
                '{C:dark_edition}policromas{} a un {C:attention}comodín al azar{}'
            }
        },
        config = {
            extra = {
                odds = 4,
                edition_amount = 1,
                odds = 4,
                edition_amount = 1
            }
        },

        use = function(self, card, area, copier)
            local used_card = copier or card
            if not (G.GAME.pool_flags.bp_poly or false) then
                if SMODS.pseudorandom_probability(card, 'group_0_e9be5884', 1, card.ability.extra.odds, 'c_thewheeloffortune', false) then
                    local jokers_to_edition = {}
                    local eligible_jokers = {}

                    if 'editionless' == 'editionless' then
                        eligible_jokers = SMODS.Edition:get_edition_cards(G.jokers, true)
                    else
                        for _, joker in pairs(G.jokers.cards) do
                            if joker.ability.set == 'Joker' then
                                eligible_jokers[#eligible_jokers + 1] = joker
                            end
                        end
                    end

                    if #eligible_jokers > 0 then
                        local temp_jokers = {}
                        for _, joker in ipairs(eligible_jokers) do
                            temp_jokers[#temp_jokers + 1] = joker
                        end

                        pseudoshuffle(temp_jokers, 76543)

                        for i = 1, math.min(card.ability.extra.edition_amount, #temp_jokers) do
                            jokers_to_edition[#jokers_to_edition + 1] = temp_jokers[i]
                        end
                    end

                    G.E_MANAGER:add_event(Event({
                        trigger = 'after',
                        delay = 0.4,
                        func = function()
                            play_sound('timpani')
                            used_card:juice_up(0.3, 0.5)
                            return true
                        end
                    }))

                    for _, joker in pairs(jokers_to_edition) do
                        G.E_MANAGER:add_event(Event({
                            trigger = 'after',
                            delay = 0.2,
                            func = function()
                                local edition = pseudorandom_element(
                                    { 'e_foil', 'e_holo', 'e_polychrome' },
                                    'random edition')
                                joker:set_edition(edition, true)
                                return true
                            end
                        }))
                    end
                    delay(0.6)
                end
            else
                if (G.GAME.pool_flags.bp_poly or false) then
                    if SMODS.pseudorandom_probability(card, 'group_0_fbb599b4', 1, card.ability.extra.odds, 'c_thewheeloffortune', false) then
                        local jokers_to_edition = {}
                        local eligible_jokers = {}

                        if 'editionless' == 'editionless' then
                            eligible_jokers = SMODS.Edition:get_edition_cards(G.jokers, true)
                        else
                            for _, joker in pairs(G.jokers.cards) do
                                if joker.ability.set == 'Joker' then
                                    eligible_jokers[#eligible_jokers + 1] = joker
                                end
                            end
                        end

                        if #eligible_jokers > 0 then
                            local temp_jokers = {}
                            for _, joker in ipairs(eligible_jokers) do
                                temp_jokers[#temp_jokers + 1] = joker
                            end

                            pseudoshuffle(temp_jokers, 76543)

                            for i = 1, math.min(card.ability.extra.edition_amount, #temp_jokers) do
                                jokers_to_edition[#jokers_to_edition + 1] = temp_jokers[i]
                            end
                        end

                        G.E_MANAGER:add_event(Event({
                            trigger = 'after',
                            delay = 0.4,
                            func = function()
                                play_sound('timpani')
                                used_card:juice_up(0.3, 0.5)
                                return true
                            end
                        }))

                        for _, joker in pairs(jokers_to_edition) do
                            G.E_MANAGER:add_event(Event({
                                trigger = 'after',
                                delay = 0.2,
                                func = function()
                                    joker:set_edition('e_polychrome', true)
                                    return true
                                end
                            }))
                        end
                        delay(0.6)
                    end
                end
            end
        end
    },
    true
)

SMODS.Consumable:take_ownership(
    'aura', {
        use = function(self, card, area, copier)
            local used_card = copier or card
            if (#G.hand.highlighted == 1 and not ((G.GAME.pool_flags.bp_poly or false))) then
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
                            local edition = pseudorandom_element({ 'e_foil', 'e_holo', 'e_polychrome', },
                                'random edition')
                            G.hand.highlighted[i]:set_edition(edition, true)
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
    },
    true
)

SMODS.Consumable:take_ownership(
    'ectoplasm', {
        config = {
            extra = {
                edition_amount = 1,
                hand_size_value = 1,
                edition_amount = 1,
                hand_size_value = 1
            }
        },
        use = function(self, card, area, copier)
            local used_card = copier or card
            if not ((G.GAME.pool_flags.bp_poly or false)) then
                local jokers_to_edition = {}
                local eligible_jokers = {}

                if 'editionless' == 'editionless' then
                    eligible_jokers = SMODS.Edition:get_edition_cards(G.jokers, true)
                else
                    for _, joker in pairs(G.jokers.cards) do
                        if joker.ability.set == 'Joker' then
                            eligible_jokers[#eligible_jokers + 1] = joker
                        end
                    end
                end

                if #eligible_jokers > 0 then
                    local temp_jokers = {}
                    for _, joker in ipairs(eligible_jokers) do
                        temp_jokers[#temp_jokers + 1] = joker
                    end

                    pseudoshuffle(temp_jokers, 76543)

                    for i = 1, math.min(card.ability.extra.edition_amount, #temp_jokers) do
                        jokers_to_edition[#jokers_to_edition + 1] = temp_jokers[i]
                    end
                end

                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.4,
                    func = function()
                        play_sound('timpani')
                        used_card:juice_up(0.3, 0.5)
                        return true
                    end
                }))

                for _, joker in pairs(jokers_to_edition) do
                    G.E_MANAGER:add_event(Event({
                        trigger = 'after',
                        delay = 0.2,
                        func = function()
                            joker:set_edition('e_negative', true)
                            return true
                        end
                    }))
                end
                delay(0.6)
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.4,
                    func = function()
                        card_eval_status_text(used_card, 'extra', nil, nil, nil,
                            { message = "-" .. tostring(1) .. " Hand Size", colour = G.C.RED })
                        G.hand:change_size(-1)
                        return true
                    end
                }))
                delay(0.6)
            end
            if (G.GAME.pool_flags.bp_poly or false) then
                local jokers_to_edition = {}
                local eligible_jokers = {}

                if 'editionless' == 'editionless' then
                    eligible_jokers = SMODS.Edition:get_edition_cards(G.jokers, true)
                else
                    for _, joker in pairs(G.jokers.cards) do
                        if joker.ability.set == 'Joker' then
                            eligible_jokers[#eligible_jokers + 1] = joker
                        end
                    end
                end

                if #eligible_jokers > 0 then
                    local temp_jokers = {}
                    for _, joker in ipairs(eligible_jokers) do
                        temp_jokers[#temp_jokers + 1] = joker
                    end

                    pseudoshuffle(temp_jokers, 76543)

                    for i = 1, math.min(card.ability.extra.edition_amount, #temp_jokers) do
                        jokers_to_edition[#jokers_to_edition + 1] = temp_jokers[i]
                    end
                end

                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.4,
                    func = function()
                        play_sound('timpani')
                        used_card:juice_up(0.3, 0.5)
                        return true
                    end
                }))

                for _, joker in pairs(jokers_to_edition) do
                    G.E_MANAGER:add_event(Event({
                        trigger = 'after',
                        delay = 0.2,
                        func = function()
                            joker:set_edition('e_polychrome', true)
                            return true
                        end
                    }))
                end
                delay(0.6)
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.4,
                    func = function()
                        card_eval_status_text(used_card, 'extra', nil, nil, nil,
                            { message = "-" .. tostring(1) .. " Hand Size", colour = G.C.RED })
                        G.hand:change_size(-1)
                        return true
                    end
                }))
                delay(0.6)
            end
        end,
    },
    true
)

SMODS.Joker:take_ownership(
    'perkeo', {
        calculate = function(self, card, context)
            if context.ending_shop then
                if not ((G.GAME.pool_flags.bp_poly or false)) then
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
                            end
                            return true
                        end
                    }
                elseif (G.GAME.pool_flags.bp_poly or false) then
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
                            end
                            return true
                        end
                    }
                end
            end
        end
    },
    true
)

SMODS.Back:take_ownership(
    'zodiac', {
        loc_txt = {
            ['name'] = 'Baraja zodiacal',
            ['text'] = {
                'Comienza con',
                '{C:tarot}Mercader de tarot{},',
                '{C:planet}Mercader de planetas{},',
                '{C:attention}Mercader de hamsters{}',
                'y {C:red}Excedente{}',
            }
        },
        config = { vouchers = { 'v_tarot_merchant', 'v_planet_merchant', 'v_bp_mercader', 'v_overstock_norm' } },
    },
    true
)

SMODS.Challenge:take_ownership(
    'non_perishable_1',
    {
        rules = {
            custom = {
                { id = 'all_eternal' },
            }
        },
        restrictions = {
            banned_cards = {
                { id = 'j_gros_michel' },
                { id = 'j_cavendish' },
                { id = 'j_ice_cream' },
                { id = 'j_turtle_bean' },
                { id = 'j_ramen' },
                { id = 'j_diet_cola' },
                { id = 'j_selzer' },
                { id = 'j_popcorn' },
                { id = 'j_mr_bones' },
                { id = 'j_invisible' },
                { id = 'j_luchador' },
                { id = 'j_bp_food' },
                { id = 'j_bp_crash' },
                { id = 'j_bp_pelo' }
            },
            banned_other = {
                { id = 'bl_final_leaf', type = 'blind' },
            }
        }
    },
    true
)

SMODS.Challenge:take_ownership(
    'typecast_1',
    {
        rules = {
            custom = {
                { id = 'set_eternal_ante',     value = 4 },
                { id = 'set_joker_slots_ante', value = 0 },
            }
        },
        restrictions = {
            banned_cards = {
                { id = 'c_bp_verdugo' },
                { id = 'v_antimatter' },
                banned_other = {
                    { id = 'bl_final_leaf', type = 'blind' },
                }
            }
        }
    },
    true
)

SMODS.Challenge:take_ownership(
    'fragile_1',
    {
        rules = {},
        jokers = {
            { id = 'j_oops', eternal = true, negative = true },
            { id = 'j_oops', eternal = true, negative = true },
        },
        restrictions = {
            banned_cards = {
                { id = 'j_marble' },
                { id = 'j_vampire' },
                { id = 'j_midas_mask' },
                { id = 'j_certificate' },
                { id = 'j_bp_civer' },
                { id = 'j_bp_retard' },
                { id = 'c_magician' },
                { id = 'c_empress' },
                { id = 'c_heirophant' },
                { id = 'c_chariot' },
                { id = 'c_devil' },
                { id = 'c_tower' },
                { id = 'c_lovers' },
                { id = 'c_incantation' },
                { id = 'c_grim' },
                { id = 'c_familiar' },
                { id = 'c_bp_cartero' },
                { id = 'c_bp_loco' },
                { id = 'c_bp_fantasma' },
                { id = 'v_magic_trick' },
                { id = 'v_illusion' },
                { id = 'v_bp_poptagono' },
                { id = 'v_bp_poctagono' },
                {
                    id = 'p_standard_normal_1',
                    ids = {
                        'p_standard_normal_1', 'p_standard_normal_2',
                        'p_standard_normal_3', 'p_standard_normal_4',
                        'p_standard_jumbo_1', 'p_standard_jumbo_2',
                        'p_standard_mega_1', 'p_standard_mega_2' }
                },
            },
            banned_tags = {
                { id = 'tag_standard' },
            }
        },
        deck = {
            enhancement = 'm_glass'
        }
    },
    true
)

SMODS.Challenge:take_ownership(
    'five_card_1',
    {
        rules = {
            modifiers = {
                { id = 'discards',    value = 6 },
                { id = 'hand_size',   value = 5 },
                { id = 'joker_slots', value = 7 },
            }
        },
        jokers = {
            { id = 'j_card_sharp' },
            { id = 'j_joker' },
        },
        restrictions = {
            banned_cards = {
                { id = 'j_juggler' },
                { id = 'j_troubadour' },
                { id = 'j_turtle_bean' },
                { id = 'j_bp_dego' },
            }
        }
    },
    true
)

SMODS.Challenge:take_ownership(
    'jokerless_1',
    {
        rules = {
            custom = {
                { id = 'no_shop_jokers' },
            },
            modifiers = {
                { id = 'joker_slots', value = 0 },
            }
        },
        restrictions = {
            banned_cards = {
                { id = 'c_judgement' },
                { id = 'c_wraith' },
                { id = 'c_soul' },
                { id = 'c_bp_optico' },
                { id = 'c_bp_cartero' },
                { id = 'c_bp_payaso' },
                { id = 'c_bp_verdugo' },
                { id = 'c_bp_misterio' },
                {
                    id = 'p_standard_normal_1',
                    ids = {
                        'p_standard_normal_1', 'p_standard_normal_2',
                        'p_standard_normal_3', 'p_standard_normal_4',
                        'p_standard_jumbo_1', 'p_standard_jumbo_2',
                        'p_standard_mega_1', 'p_standard_mega_2' }
                },
                { id = 'v_antimatter' },
                { id = 'v_bp_poptagono' },
                { id = 'v_bp_poctagono' },
            },
            banned_tags = {
                { id = 'tag_uncommon' },
                { id = 'tag_rare' },
                { id = 'tag_negative' },
                { id = 'tag_foil' },
                { id = 'tag_holographic' },
                { id = 'tag_polychrome' },
                { id = 'tag_buffoon' },
                { id = 'tag_top_up' },
            },
            banned_other = {
                { id = 'bl_final_heart', type = 'blind' },
                { id = 'bl_final_leaf',  type = 'blind' },
                { id = 'bl_final_acorn', type = 'blind' },
            }
        }
    },
    true
)