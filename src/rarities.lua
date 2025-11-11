SMODS.Rarity {
    key = "secreto",
    pools = {
        ["jokers.lua"] = true
    },
    default_weight = 0.015,
    badge_colour = HEX('f99717'),
    loc_txt = {
        name = "Secreto"
    },
    get_weight = function(self, weight, object_type)
        return weight
    end,
}