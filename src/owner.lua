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
