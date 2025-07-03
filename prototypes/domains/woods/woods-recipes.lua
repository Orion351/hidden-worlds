-- Recipe Helper Functions
local function make_wood_recipe(name, icons, crafting_machine_tint, category, subgroup, order, ingredients, results, main_product, tags)
  data:extend{
    {
      -- Basic
      type = "recipe",
      name = name,
      -- Game
      emissions_multiplier = 0,
      energy_required = 0.3,
      -- Display
      icons = icons,
      crafting_machine_tint = crafting_machine_tint,
      -- Organization
      category = category,
      hide_from_player_crafting = false,
      hide_from_signal_gui = false,
      hide_from_stats = false,
      subgroup = subgroup,
      order = order,
      -- Input/Output
      ingredients = ingredients,
      results = results,
      main_product = main_product,
      -- Quality Mod
      auto_recycle = true,
      -- Sidecar
      hw_sidecar_recipe = tags,
      -- Icon Badges FIXME
      -- Localization FIXME
    }
  }
end

local function make_stock_to_part_fanout(stock, part, crafting_machine_tint, category, subgroup, order, ingredient_amount, result_amount, byproducts, tags)
  for material, properties in pairs(HW_Global.wood.wood_material_to_properties) do
    for _, property in pairs(properties) do
      -- name
      local name = material .. "-" .. stock .. "-to-" .. property .. "-wood-" .. part
      -- order
      local order_full = order .. "[" .. name .. "]"
      -- ingredients
      local ingredients = {{type = "item", name = material .. "-" .. stock, amount = ingredient_amount}}
      -- results
      local results = {{type = "item", name = property .. "-wood-" .. part, amount = result_amount}}
      byproducts = byproducts or {}
      results = table.merge_overwrite(results, byproducts)
      -- main_product
      local main_product = property .. "-wood-" .. part
      -- icons
      local icons = {
        {
          icon = "__hidden-worlds__/graphics/icons/woods/" .. property .. "-wood-" .. part .. "/" .. property .. "-wood-" .. part .. "-0000.png",
          icon_size = 64,
        }
      }
      -- FIXME add an SDF to the icons
      Build_img_badge_icon(icons, {"__hidden-worlds__/graphics/icons/woods/" .. material .. "-" .. stock .. "/" .. material .. "-" .. stock .. "-0000.png"}, 64, HW_Global.stock_badge_scale, 0, "right-top", 0)
      -- tags
      local tags = {} -- TODO
      -- Do The Thing
      make_wood_recipe(name, icons, crafting_machine_tint, category, subgroup, order_full, ingredients, results, main_product, tags)
    end
  end
end

local function make_wood_crafter_recipe(name, subgroup, order, ingredients, tags)
  data:extend{{
    -- Basic
    type = "recipe",
    name = name .. "-recipe",
    -- Game
    emissions_multiplier = 0,
    energy_required = 0.3,
    -- Icon
    icon = "__hidden-worlds__/graphics/icons/entity/" .. name .. ".png",
    icon_size = 64,
    -- Organization
    category = "crafting",
    order = order,
    subgroup = subgroup,
    -- Input/Output
    ingredients = ingredients,
    results = {{type = "item", name = name, amount = 1}},
    main_product = name,
    -- Quality Mod
    auto_recycle = true,
    -- Sidecar
    hw_sidecar_recipe = tags,
  }}
end

-- Recipes Declarations
-- Intermediates
make_stock_to_part_fanout("split-lumber", "plank", {r = 1, g = 1, b = 1, a = 1}, "log-splitter", "log-splitter", "d", 2, 5, {}, {})
make_stock_to_part_fanout("split-lumber", "plank", {r = 1, g = 1, b = 1, a = 1}, "log-splitter", "log-splitter", "d", 2, 5, {}, {})

local wood_crafter_names_to_ingredients = {
  ["log-splitter"]   = {},
  ["log-stripper"]   = {},
  ["wood-vat"]       = {},
  ["spin-n-sieve"]   = {},
  ["wood-press"]     = {},
  ["grindstone"]     = {},
  ["stone-crusher"]  = {},
  ["rope-twister"]   = {},
  ["wood-lathe"]     = {},
  ["wood-tablesaw"]  = {},
  ["wood-planer"]    = {},
}

for name, ingredients in pairs(wood_crafter_names_to_ingredients) do
  make_wood_crafter_recipe(name, "wood-assemblers", "a" .. name, ingredients, {domain = "wood"})
end

-- Wood Logistics
data:extend{{ -- axle-5x1
  -- Basic
  type = "recipe",
  name = "axle-5x1-recipe",
  enabled = false,
  -- Game
  emissions_multiplier = 0,
  energy_required = 0.1,
  -- Icon
  icon = "__hidden-worlds__/graphics/icons/entity/axle-5x1.png",
  icon_size = 64,
  -- Organization
  category = "crafting",
  order = "a axle-5x1-recipe",
  subgroup = "wood-logistics",
  -- Input/Output
  ingredients = {
    { type = "item", name = "wood", amount = 1 },
  },
  results = {{type = "item", name = "axle-5x1", amount = 1}},
  main_product = "axle-5x1",
  -- Quality Mod
  auto_recycle = true,
  -- Sidecar
  hw_sidecar_recipe = {}, -- TODO
}}

data:extend{{ -- wood-trough
  -- Basic
  type = "recipe",
  name = "wood-trough-recipe",
  -- Game
  emissions_multiplier = 0,
  energy_required = 0.1,
  -- Icon
  icon = "__hidden-worlds__/graphics/icons/entity/wood-trough.png",
  icon_size = 64,
  -- Organization
  category = "crafting",
  order = "a wood-trough-recipe",
  subgroup = "wood-logistics",
  -- Input/Output
  ingredients = {},
  results = {{type = "item", name = "wood-trough", amount = 1}},
  main_product = "wood-trough",
  -- Quality Mod
  auto_recycle = true,
  -- Sidecar
  hw_sidecar_recipe = {}, -- TODO
}}

data:extend{{ -- wood-chute
  -- Basic
  type = "recipe",
  name = "wood-chute-recipe",
  -- Game
  emissions_multiplier = 0,
  energy_required = 0.1,
  -- Icon
  icon = "__hidden-worlds__/graphics/icons/entity/wood-chute.png",
  icon_size = 64,
  -- Organization
  category = "crafting",
  order = "a wood-chute-recipe",
  subgroup = "wood-logistics",
  -- Input/Output
  ingredients = {},
  results = {{type = "item", name = "wood-chute", amount = 1}},
  main_product = "wood-chute",
  -- Quality Mod
  auto_recycle = true,
  -- Sidecar
  hw_sidecar_recipe = {}, -- TODO
}}

-- Torque Source
data:extend{{ -- water-wheel
  -- Basic
  type = "recipe",
  name = "water-wheel-recipe",
  enabled = false,
  -- Game
  emissions_multiplier = 0,
  energy_required = 0.1,
  -- Icon
  icon = "__hidden-worlds__/graphics/icons/entity/water-wheel.png",
  icon_size = 64,
  -- Organization
  category = "crafting",
  order = "a water-wheel-recipe",
  subgroup = "wood-torque-source",
  -- Input/Output
  ingredients = {
    { type = "item", name = "wood", amount = 1 },
  },
  results = {{type = "item", name = "water-wheel", amount = 1}},
  main_product = "water-wheel",
  -- Quality Mod
  auto_recycle = true,
  -- Sidecar
  hw_sidecar_recipe = {}, -- TODO
}}

-- Supplementary Recipes
-- Torque Dummy Recipies
data:extend{{ -- axle-torque-recipe
  name = "axle-torque-recipe",
  type = "recipe",
  category = "wood-axle",
  ingredients = {{type = "fluid", name = "torque", amount = 100}},
  results = {{type = "fluid", name = "torque", amount = 90}}
}}

data:extend{{ -- water-wheel-torque-recipe
  name = "water-wheel-torque-recipe",
  type = "recipe",
  category = "water-wheel",
  ingredients = {{type = "fluid", name = "water", amount = 50}},
  results = {{type = "fluid", name = "torque", amount = 100}}
}}

-- Wood chute Recipes
for item_name, item_data in pairs(data.raw.item) do
  data:extend{{
    type = "recipe",
    name = item_name .. "wood-chute-recipe",
    icon = item_data.icon,
    icons = item_data.icons,
    icon_size = item_data.icon_size,
    ingredients = {{type = "item", name = item_name, amount = 1}},
    results = {{type = "item", name = item_name, amount = 1}},
    energy_required = 1,
    category = "wood-chute",
    hide_from_player_crafting = true,
    hide_from_signal_gui = true,
    hide_from_stats = true,
    hidden_in_factoriopedia = true,
    hidden = true,
  }}
end