-- Additional recipes if Space Exploration mod is enabled
local util = require("data-util");

if mods["space-exploration"] then
  se_delivery_cannon_recipes[util.me.lead_ore] = {name= util.me.lead_ore}
  se_delivery_cannon_recipes[util.me.lead_plate] = {name= util.me.lead_plate}
  util.se_landfill({ore="lead-ore"})

  util.se_matter({ore="lead-ore", energy_required=1, quant_out=10, stream_out=60})
  data:extend({
  {
    type = "item-subgroup",
    name = "lead",
    group = "resources",
    order = "a-h-z-a",
  }
  })
  util.set_item_subgroup("lead-plate", "lead")
  data:extend({
  {
    type = "item",
    name = "lead-ingot",
    icons = {{icon = "__bzlead__/graphics/icons/lead-ingot.png", icon_size = 128}},
    order = "b-b",
    stack_size = 50,
    subgroup = "lead",
  },
  {
    type = "fluid",
    name = "molten-lead",
    default_temperature = 600,
    max_temperature = 600,
    base_color = {r=121, g=80, b=80},
    flow_color = {r=121, g=80, b=80},
    icons = {{icon = "__bzlead__/graphics/icons/molten-lead.png", icon_size = 128}},
    order = "a[molten]-a",
    pressure_to_speed_ratio = 0.4,
    flow_to_energy_ratio = 0.59,
    auto_barrel = false,
    subgroup = "fluid",
  },
  {
    type = "recipe",
    category = "smelting",
    name = "molten-lead",
    main_product = "molten-lead",
    subgroup = "lead",
    results = {
      {type = "fluid", name = "molten-lead", amount = util.k2() and 750 or 900},
    },
    energy_required = 60,
    ingredients = {
      {type="item", name = util.k2() and "enriched-lead" or "lead-ore", amount = 24},
      {type = "fluid", name = "se-pyroflux", amount = 10},
    },
    enabled = false,
    always_show_made_in = true,
    allow_as_intermediate = false,
    order = "a-a"
  },
  {
    type = "recipe",
    name = "lead-ingot",
    category = "casting",
    results = {{type="item", name="lead-ingot", amount=1}},
    energy_required = 25,
    ingredients = {
      {type = "fluid", name = "molten-lead", amount = 250},
    },
    enabled = false,
    always_show_made_in = true,
    allow_as_intermediate = false,
  },
  {
    type = "recipe",
    category = "crafting",
    name = "lead-ingot-to-plate",

    icons = {
      {icon = "__bzlead__/graphics/icons/lead-plate.png", icon_size = 64, icon_mipmaps = 3},
      {icon = "__bzlead__/graphics/icons/lead-ingot.png", icon_size = 128, scale = 0.125, shift = {-8, -8}},
    },
    results = {
      {type="item", name = "lead-plate", amount = 10},
    },
    energy_required = 5,
    ingredients = {
      {type="item", name = "lead-ingot", amount = 1}
    },
    enabled = false,
    always_show_made_in = true,
    allow_decomposition = false,
    order = "a-c-b"
  },
  })
  util.add_effect("se-pyroflux-smelting", {type = "unlock-recipe", recipe= "molten-lead"})
  util.add_effect("se-pyroflux-smelting", {type = "unlock-recipe", recipe= "lead-ingot"})
  util.add_effect("se-pyroflux-smelting", {type = "unlock-recipe", recipe= "lead-ingot-to-plate"})
  util.add_effect("se-vulcanite-smelting", {type = "unlock-recipe", recipe= "molten-lead"})
  util.add_effect("se-vulcanite-smelting", {type = "unlock-recipe", recipe= "lead-ingot"})
  util.add_effect("se-vulcanite-smelting", {type = "unlock-recipe", recipe= "lead-ingot-to-plate"})
  if util.k2() then
    util.set_item_subgroup("enriched-lead", "lead")
    data.raw.recipe["enriched-lead-plate"].order= "d[lead-plate]"
    se_delivery_cannon_recipes["enriched-lead"] = {name= "enriched-lead"}
  else
    if util.me.byproduct() then util.add_product("molten-lead", {"copper-ore", 6}) end
  end
  se_delivery_cannon_recipes["lead-ingot"] = {name="lead-ingot"}
end