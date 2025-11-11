assert(SMODS.load_file("src/jokers.lua"))()
assert(SMODS.load_file("src/porotos.lua"))()
assert(SMODS.load_file("src/rarities.lua"))()
assert(SMODS.load_file("src/packs.lua"))()
assert(SMODS.load_file("src/vouchers.lua"))()
assert(SMODS.load_file("src/owner.lua"))()
assert(SMODS.load_file("src/sounds.lua"))()

SMODS.current_mod.optional_features = {
  retrigger_joker = true,
  post_trigger = true,
  quantum_enhancements = true,
  cardareas = {
    discard = true,
    deck = true
  }
}

SMODS.ObjectType {
  key = "Ratatin",
  cards = {
    j_bp_shiro = true,
    j_bp_miko = true,
    j_bp_civer = true,
  }
}

SMODS.ObjectType {
  key = "Red",
  cards = {
    j_lusty_joker = true,
    j_mad = true,
    j_droll = true,
    j_clever = true,
    j_crafty = true,
    j_credit_card = true,
    j_raised_fist = true,
    j_hack = true,
    j_even_steven = true,
    j_red_card = true,
    j_madness = true,
    j_baron = true,
    j_gift = true,
    j_reserved_parking = true,
    j_drunkard = true,
    j_popcorn = true,
    j_matador = true,
    j_family = true,
    j_tribe = true,
    j_burnt = true,
    j_chicot = true,
    j_bp_retard = true,
  }
}

SMODS.ObjectType {
  key = "Green",
  cards = {
    j_green_joker = true,
    j_gluttenous_joker = true,
    j_zany = true,
    j_wily = true,
    j_ceremonial = true,
    j_chaos = true,
    j_pareidolia = true,
    j_blackboard = true,
    j_turtle_bean = true,
    j_to_the_moon = true,
    j_troubadour = true,
    j_flower_pot = true,
    j_bloodstone = true,
    j_cavendish = true,
    j_flash = true,
    j_oops = true,
    j_trio = true,
    j_perkeo = true,
    j_bp_cogollo = true,
    j_bp_kick = true,
    j_bp_aidrags = true
  }
}

SMODS.ObjectType {
  key = "Marronsita",
  cards = {
    j_bp_marronsita = true,
  }
}

SMODS.Atlas({
  key = "modicon",
  path = "modicon.png",
  px = 32,
  py = 32
})

SMODS.Atlas({
  key = "balatro",
  path = "balatro.png",
  px = 333,
  py = 216,
  prefix_config = { key = false },
})
