SMODS.Booster {
    key = 'semilla_normal_2',
    atlas = 'normal2',
    SMODS.Atlas {
        key = 'normal2',
        path = 'normal2.png',
        px = 71,
        py = 95
    },
    loc_txt = {
        name = "Paquete Semilla",
        text = {
            "Elige {C:attention}1{} de hasta",
            "{C:attention}3{} {C:red}Poroto Cards{} para",
            "guardar"
        },
        group_name = "Paquete Semilla"
    },
    config = { extra = 3, choose = 1 },
    pos = { x = 0, y = 0 },
    kind = 'Semilla',
    draw_hand = true,
    select_card = "consumeables",
    discovered = false,
    hidden = true,
    loc_vars = function(self, info_queue, card)
        local cfg = (card and card.ability) or self.config
        return {
            vars = { cfg.choose, cfg.extra }
        }
    end,
    create_card = function(self, card, i)
        local weights = {
            1,
        }
        local total_weight = 0
        for _, weight in ipairs(weights) do
            total_weight = total_weight + weight
        end
        local random_value = pseudorandom('bp_semilla_normal_1_card') * total_weight
        local cumulative_weight = 0
        local selected_index = 1
        for j, weight in ipairs(weights) do
            cumulative_weight = cumulative_weight + weight
            if random_value <= cumulative_weight then
                selected_index = j
                break
            end
        end
        if selected_index == 1 then
            return {
                set = "poroto",
                area = G.pack_cards,
                skip_materialize = true,
                soulable = true,
                key_append = "bp_semilla_normal_1"
            }
        end
    end,
    ease_background_colour = function(self)
        ease_colour(G.C.DYN_UI.MAIN, HEX("f8c65b"))
        ease_background_colour({ new_colour = HEX('f8c65b'), special_colour = HEX("f8c65b"), contrast = 2 })
    end,
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
}

SMODS.Booster {
    key = 'semilla_normal_1',
    atlas = 'normal1',
    SMODS.Atlas {
        key = 'normal1',
        path = 'normal1.png',
        px = 71,
        py = 95
    },
    loc_txt = {
        name = "Paquete Semilla",
        text = {
            "Elige {C:attention}1{} de hasta",
            "{C:attention}3{} {C:red}Poroto Cards{} para",
            "guardar"
        },
        group_name = "Paquete Semilla"
    },
    config = { extra = 3, choose = 1 },
    pos = { x = 0, y = 0 },
    kind = 'poroto_bp',
    draw_hand = true,
    select_card = "consumeables",
    discovered = false,
    hidden = true,
    loc_vars = function(self, info_queue, card)
        local cfg = (card and card.ability) or self.config
        return {
            vars = { cfg.choose, cfg.extra }
        }
    end,
    create_card = function(self, card, i)
        local weights = {
            1,
        }
        local total_weight = 0
        for _, weight in ipairs(weights) do
            total_weight = total_weight + weight
        end
        local random_value = pseudorandom('bp_semilla_normal_1_card') * total_weight
        local cumulative_weight = 0
        local selected_index = 1
        for j, weight in ipairs(weights) do
            cumulative_weight = cumulative_weight + weight
            if random_value <= cumulative_weight then
                selected_index = j
                break
            end
        end
        if selected_index == 1 then
            return {
                set = "poroto",
                area = G.pack_cards,
                skip_materialize = true,
                soulable = true,
                key_append = "bp_semilla_normal_1"
            }
        end
    end,
    ease_background_colour = function(self)
        ease_colour(G.C.DYN_UI.MAIN, HEX("f8c65b"))
        ease_background_colour({ new_colour = HEX('f8c65b'), special_colour = HEX("f8c65b"), contrast = 2 })
    end,
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
}


SMODS.Booster {
    key = 'semilla_jumbo_2',
    atlas = 'jumbo1',
    SMODS.Atlas {
        key = 'jumbo1',
        path = 'jumbo1.png',
        px = 71,
        py = 95
    },
    loc_txt = {
        name = "Paquete Semilla Jumbo",
        text = {
            "Elige {C:attention}1{} de hasta",
            "{C:attention}5{} {C:red}Poroto Cards{} para",
            "guardar"
        },
        group_name = "Paquete Semilla Jumbo"
    },
    config = { extra = 5, choose = 1 },
    cost = 6,
    pos = { x = 0, y = 0 },
    kind = 'poroto_bp',
    draw_hand = true,
    select_card = "consumeables",
    discovered = false,
    hidden = true,
    loc_vars = function(self, info_queue, card)
        local cfg = (card and card.ability) or self.config
        return {
            vars = { cfg.choose, cfg.extra }
        }
    end,
    create_card = function(self, card, i)
        local weights = {
            1,
        }
        local total_weight = 0
        for _, weight in ipairs(weights) do
            total_weight = total_weight + weight
        end
        local random_value = pseudorandom('bp_semilla_normal_1_card') * total_weight
        local cumulative_weight = 0
        local selected_index = 1
        for j, weight in ipairs(weights) do
            cumulative_weight = cumulative_weight + weight
            if random_value <= cumulative_weight then
                selected_index = j
                break
            end
        end
        if selected_index == 1 then
            return {
                set = "poroto",
                area = G.pack_cards,
                skip_materialize = true,
                soulable = true,
                key_append = "bp_semilla_normal_1"
            }
        end
    end,
    ease_background_colour = function(self)
        ease_colour(G.C.DYN_UI.MAIN, HEX("f8c65b"))
        ease_background_colour({ new_colour = HEX('f8c65b'), special_colour = HEX("f8c65b"), contrast = 2 })
    end,
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
}

SMODS.Booster {
    key = 'semilla_jumbo_1',
    atlas = 'jumbo2',
    SMODS.Atlas {
        key = 'jumbo2',
        path = 'jumbo2.png',
        px = 71,
        py = 95
    },
    loc_txt = {
        name = "Paquete Semilla Jumbo",
        text = {
            "Elige {C:attention}1{} de hasta",
            "{C:attention}5{} {C:red}Poroto Cards{} para",
            "guardar"
        },
        group_name = "Paquete Semilla Jumbo"
    },
    config = { extra = 5, choose = 1 },
    cost = 6,
    pos = { x = 0, y = 0 },
    kind = 'poroto_bp',
    draw_hand = true,
    select_card = "consumeables",
    discovered = false,
    hidden = true,
    loc_vars = function(self, info_queue, card)
        local cfg = (card and card.ability) or self.config
        return {
            vars = { cfg.choose, cfg.extra }
        }
    end,
    create_card = function(self, card, i)
        local weights = {
            1,
        }
        local total_weight = 0
        for _, weight in ipairs(weights) do
            total_weight = total_weight + weight
        end
        local random_value = pseudorandom('bp_semilla_normal_1_card') * total_weight
        local cumulative_weight = 0
        local selected_index = 1
        for j, weight in ipairs(weights) do
            cumulative_weight = cumulative_weight + weight
            if random_value <= cumulative_weight then
                selected_index = j
                break
            end
        end
        if selected_index == 1 then
            return {
            set = "poroto",
                area = G.pack_cards,
                skip_materialize = true,
                soulable = true,
                key_append = "bp_semilla_normal_1"
            }
        end
    end,
    ease_background_colour = function(self)
        ease_colour(G.C.DYN_UI.MAIN, HEX("f8c65b"))
        ease_background_colour({ new_colour = HEX('f8c65b'), special_colour = HEX("f8c65b"), contrast = 2 })
    end,
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
}

SMODS.Booster {
    key = 'semilla_mega_2',
    atlas = 'mega2',
    SMODS.Atlas {
        key = 'mega2',
        path = 'mega2.png',
        px = 71,
        py = 95
    },
    loc_txt = {
        name = "Paquete Semilla Mega",
        text = {
            "Elige {C:attention}2{} de hasta",
            "{C:attention}5{} {C:red}Poroto Cards{} para",
            "guardar"
        },
        group_name = "Paquete Semilla Mega"
    },
    config = { extra = 5, choose = 2 },
    cost = 8,
    weight = 0.3,
    pos = { x = 0, y = 0 },
    kind = 'poroto_bp',
    draw_hand = true,
    select_card = "consumeables",
    discovered = false,
    hidden = true,
    loc_vars = function(self, info_queue, card)
        local cfg = (card and card.ability) or self.config
        return {
            vars = { cfg.choose, cfg.extra }
        }
    end,
    create_card = function(self, card, i)
        local weights = {
            1,
        }
        local total_weight = 0
        for _, weight in ipairs(weights) do
            total_weight = total_weight + weight
        end
        local random_value = pseudorandom('bp_semilla_normal_1_card') * total_weight
        local cumulative_weight = 0
        local selected_index = 1
        for j, weight in ipairs(weights) do
            cumulative_weight = cumulative_weight + weight
            if random_value <= cumulative_weight then
                selected_index = j
                break
            end
        end
        if selected_index == 1 then
            return {
            set = "poroto",
                area = G.pack_cards,
                skip_materialize = true,
                soulable = true,
                key_append = "bp_semilla_normal_1"
            }
        end
    end,
    ease_background_colour = function(self)
        ease_colour(G.C.DYN_UI.MAIN, HEX("f8c65b"))
        ease_background_colour({ new_colour = HEX('f8c65b'), special_colour = HEX("f8c65b"), contrast = 2 })
    end,
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
}


SMODS.Booster {
    key = 'semilla_mega_1',
    atlas = 'mega1',
    SMODS.Atlas {
        key = 'mega1',
        path = 'mega1.png',
        px = 71,
        py = 95
    },
    loc_txt = {
        name = "Paquete Semilla Mega",
        text = {
            "Elige {C:attention}2{} de hasta",
            "{C:attention}5{} {C:red}Poroto Cards{} para",
            "guardar"
        },
        group_name = "Paquete Semilla Mega"
    },
    config = { extra = 5, choose = 2 },
    cost = 8,
    weight = 0.3,
    pos = { x = 0, y = 0 },
    kind = 'poroto_bp',
    draw_hand = true,
    select_card = "consumeables",
    discovered = false,
    hidden = true,
    loc_vars = function(self, info_queue, card)
        local cfg = (card and card.ability) or self.config
        return {
            vars = { cfg.choose, cfg.extra }
        }
    end,
    create_card = function(self, card, i)
        local weights = {
            1,
        }
        local total_weight = 0
        for _, weight in ipairs(weights) do
            total_weight = total_weight + weight
        end
        local random_value = pseudorandom('bp_semilla_normal_1_card') * total_weight
        local cumulative_weight = 0
        local selected_index = 1
        for j, weight in ipairs(weights) do
            cumulative_weight = cumulative_weight + weight
            if random_value <= cumulative_weight then
                selected_index = j
                break
            end
        end
        if selected_index == 1 then
            return {
            set = "poroto",
                area = G.pack_cards,
                skip_materialize = true,
                soulable = true,
                key_append = "bp_semilla_normal_1"
            }
        end
    end,
    ease_background_colour = function(self)
        ease_colour(G.C.DYN_UI.MAIN, HEX("f8c65b"))
        ease_background_colour({ new_colour = HEX('f8c65b'), special_colour = HEX("f8c65b"), contrast = 2 })
    end,
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
}

SMODS.Booster {
    key = 'semilla_ultra_2',
    atlas = 'hiper1',
    SMODS.Atlas {
        key = 'hiper1',
        path = 'hiper1.png',
        px = 71,
        py = 95
    },
    loc_txt = {
        name = "Paquete Semilla Hiper",
        text = {
            "Elige {C:attention}2{} de hasta",
            "{C:attention}7{} {C:red}Poroto Cards{} para",
            "guardar"
        },
        group_name = "Paquete Semilla Hiper"
    },
    config = { extra = 7, choose = 2 },
    cost = 10,
    weight = 0.3,
    pos = { x = 0, y = 0 },
    kind = 'poroto_bp',
    draw_hand = true,
    select_card = "consumeables",
    discovered = false,
    hidden = true,
    loc_vars = function(self, info_queue, card)
        local cfg = (card and card.ability) or self.config
        return {
            vars = { cfg.choose, cfg.extra }
        }
    end,
    create_card = function(self, card, i)
        local weights = {
            1,
        }
        local total_weight = 0
        for _, weight in ipairs(weights) do
            total_weight = total_weight + weight
        end
        local random_value = pseudorandom('bp_semilla_normal_1_card') * total_weight
        local cumulative_weight = 0
        local selected_index = 1
        for j, weight in ipairs(weights) do
            cumulative_weight = cumulative_weight + weight
            if random_value <= cumulative_weight then
                selected_index = j
                break
            end
        end
        if selected_index == 1 then
            return {
            set = "poroto",
                area = G.pack_cards,
                skip_materialize = true,
                soulable = true,
                key_append = "bp_semilla_normal_1"
            }
        end
    end,
    ease_background_colour = function(self)
        ease_colour(G.C.DYN_UI.MAIN, HEX("f8c65b"))
        ease_background_colour({ new_colour = HEX('f8c65b'), special_colour = HEX("f8c65b"), contrast = 2 })
    end,
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
}


SMODS.Booster {
    key = 'semilla_ultra_1',
    atlas = 'hiper2',
    SMODS.Atlas {
        key = 'hiper2',
        path = 'hiper2.png',
        px = 71,
        py = 95
    },
    loc_txt = {
        name = "Paquete Semilla Hiper",
        text = {
            "Elige {C:attention}2{} de hasta",
            "{C:attention}7{} {C:red}Poroto Cards{} para",
            "guardar"
        },
        group_name = "Paquete Semilla Hiper"
    },
    config = { extra = 7, choose = 2 },
    cost = 10,
    weight = 0.3,
    pos = { x = 0, y = 0 },
    kind = 'poroto_bp',
    draw_hand = true,
    select_card = "consumeables",
    discovered = false,
    hidden = true,
    loc_vars = function(self, info_queue, card)
        local cfg = (card and card.ability) or self.config
        return {
            vars = { cfg.choose, cfg.extra }
        }
    end,
    create_card = function(self, card, i)
        local weights = {
            1,
        }
        local total_weight = 0
        for _, weight in ipairs(weights) do
            total_weight = total_weight + weight
        end
        local random_value = pseudorandom('bp_semilla_normal_1_card') * total_weight
        local cumulative_weight = 0
        local selected_index = 1
        for j, weight in ipairs(weights) do
            cumulative_weight = cumulative_weight + weight
            if random_value <= cumulative_weight then
                selected_index = j
                break
            end
        end
        if selected_index == 1 then
            return {
            set = "poroto",
                area = G.pack_cards,
                skip_materialize = true,
                soulable = true,
                key_append = "bp_semilla_normal_1"
            }
        end
    end,
    ease_background_colour = function(self)
        ease_colour(G.C.DYN_UI.MAIN, HEX("f8c65b"))
        ease_background_colour({ new_colour = HEX('f8c65b'), special_colour = HEX("f8c65b"), contrast = 2 })
    end,
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
}
