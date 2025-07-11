-- Item Helper Functions
local function make_wood_items(names, domain, order, weight, subgroup, fuel_value, tags)
  for _, name in pairs(names) do
    local localized_description = {}
    -- FIXME: add localized description

    data:extend{
      {
        -- Basic
        type = "item",
        name = name,
        -- Game
        stack_size = HW_Global.wood.wood_stack_size,
        -- Display
        icon = "__hidden-worlds__/graphics/icons/" .. domain .. "/" ..  name .. "/" .. name .. "-0000.png",
        icon_size = 64,
        pictures = {
          {size = 64, filename = "__hidden-worlds__/graphics/icons/" .. domain .. "/" .. name .. "/" .. name .. "-0000.png", scale = 0.5},
          {size = 64, filename = "__hidden-worlds__/graphics/icons/" .. domain .. "/" .. name .. "/" .. name .. "-0001.png", scale = 0.5},
          {size = 64, filename = "__hidden-worlds__/graphics/icons/" .. domain .. "/" .. name .. "/" .. name .. "-0002.png", scale = 0.5},
          {size = 64, filename = "__hidden-worlds__/graphics/icons/" .. domain .. "/" .. name .. "/" .. name .. "-0003.png", scale = 0.5},
        },
        -- Organization
        group = "intermediate-products",
        subgroup = subgroup,
        order = order,
        -- Fuel
        fuel_category = "wood",
        fuel_value = fuel_value,
        -- Space Age
        weight = weight,
        -- Quality Mod
        auto_recycle = true,
        -- Sidecar
        hw_sidecar_item = {tags = tags, item_type = domain} --[[@as hw_sidecar_item]] ---@diagnostic disable-line: assign-type-mismatch
        -- Icon Badges FIXME
        -- Localization FIXME
      },
    }
  end
end

local function make_wood_assembler_item(name, domain, order, weight, flags, tags)
  data:extend{{
    -- Basic
    type = "item",
    name = name,
    -- Game
    stack_size = HW_Global.wood.wood_assembler_stack_size,
    place_result = name,
    flags = flags,
    -- Display
    icon = "__hidden-worlds__/graphics/icons/entity/" ..  name .. ".png",
    icon_size = 64,
    -- Organization
    group = "production",
    subgroup = "wood-assemblers",
    order = order .. " " .. name,
    -- Space Age
    weight = weight,
    -- Quality Mod
    auto_recycle = true,
    -- Sidecar
    hw_sidecar_item = tags --[[@as hw_sidecar_item]] ---@diagnostic disable-line: assign-type-mismatch
    -- Icon Badges FIXME
    -- Localization FIXME
  }}
end

-- Items Creation
--   Intermediates

-- FIXME: Work out proper values for fuel_value

-- Make timber
make_wood_items({"hardwood-timber", "softwood-timber"},
  "woods", "a", 2 * kg, "wood", "2MJ", {"wood", "timber", "stock"})

-- Make lumber
make_wood_items({"hardwood-lumber", "softwood-lumber"},
  "woods", "b", 1.8 * kg, "wood", "2MJ", {"wood", "lumber", "stock"})

-- Make split-lumber
make_wood_items({"hardwood-split-lumber", "softwood-split-lumber"},
  "woods", "c", 2 * kg, "wood", "2MJ", {"wood", "split-lumber", "stock"})

-- Make bark
make_wood_items({"bark"},
  "woods", "d", 2 * kg, "wood", "1MJ", {"wood", "bark", "byproduct"})

-- Make plant-debris
make_wood_items({"plant-debris"},
  "woods", "d", 1 * kg, "wood", "1MJ", {"wood", "plant-debris", "byproduct"})

-- Make dried-plant-debris
make_wood_items({"dried-plant-debris"},
  "woods", "d", 1 * kg, "wood", "1MJ", {"wood", "dried-plant-debris"})

-- Make Wood Parts
for _, property in pairs(HW_Global.wood.wood_properties) do
  make_wood_items({property .. "-wood-beam"},
    "woods", "d", 1 * kg, "wood", "1MJ", {"wood", "beam", "part", property})
  make_wood_items({property .. "-wood-axle"},
    "woods", "d", 1 * kg, "wood", "1MJ", {"wood", "axle", "part", property})
  make_wood_items({property .. "-wood-plank"},
    "woods", "d", 1 * kg, "wood", "1MJ", {"wood", "plank", "part", property})
  make_wood_items({property .. "-wood-sheet"},
    "woods", "d", 1 * kg, "wood", "1MJ", {"wood", "sheet", "part", property})
  make_wood_items({property .. "-wood-gear"},
    "woods", "d", 1 * kg, "wood", "1MJ", {"wood", "gear", "part", property})
end



--   Entities
--   Wood Assemblers
local wood_assembler_data = {
  ["log-splitter"]     = {},
  ["log-stripper"]     = {},
  ["grindstone"]       = {},
  ["rope-twister"]     = {},
  ["spin-n-sieve"]     = {},
  ["stone-autohammer"] = {},
  ["stone-crusher"]    = {},
  ["wood-planer"]      = {},
  ["wood-tablesaw"]    = {},
  ["wood-lathe"]       = {},
  ["wood-vat"]         = {},
  ["wood-press"]       = {},
}
for name, _ in pairs(wood_assembler_data) do
  make_wood_assembler_item(name, "wood", "a", HW_Global.wood.wood_assembler_weight, {}, {})
end

-- Wood Logistics
data:extend{{
  -- Basic
  type = "item",
  name = "axle-5x1",
  -- Game
  stack_size = 100,
  place_result = "axle-5x1",
  flags = {},
  -- Display
  icon = "__hidden-worlds__/graphics/icons/entity/axle-5x1.png",
  icon_size = 64,
  -- Organization
  group = "logistics",
  subgroup = "wood-logistics",
  order = "a axle-5x1",
  -- Space Age
  weight = 1 * kg,
  -- Quality Mod
  auto_recycle = true,
  -- Sidecar
  hw_sidecar_item = {} --[[@as hw_sidecar_item]] ---@diagnostic disable-line: assign-type-mismatch
  -- Icon Badges FIXME
  -- Localization FIXME
}}

data:extend{{
  -- Basic
  type = "item",
  name = "wood-trough",
  -- Game
  stack_size = 100,
  place_result = "wood-trough",
  flags = {},
  -- Display
  icon = "__hidden-worlds__/graphics/icons/entity/wood-trough.png",
  icon_size = 64,
  -- Organization
  group = "logistics",
  subgroup = "wood-logistics",
  order = "a wood-trough",
  -- Space Age
  weight = 1 * kg,
  -- Quality Mod
  auto_recycle = true,
  -- Sidecar
  hw_sidecar_item = {} --[[@as hw_sidecar_item]] ---@diagnostic disable-line: assign-type-mismatch
  -- Icon Badges FIXME
  -- Localization FIXME
}}

data:extend{{
  -- Basic
  type = "item",
  name = "wood-chute",
  -- Game
  stack_size = 100,
  place_result = "wood-chute",
  flags = {},
  -- Display
  icon = "__hidden-worlds__/graphics/icons/entity/wood-chute.png",
  icon_size = 64,
  -- Organization
  group = "logistics",
  subgroup = "wood-logistics",
  order = "a wood-chute",
  -- Space Age
  weight = 1 * kg,
  -- Quality Mod
  auto_recycle = true,
  -- Sidecar
  hw_sidecar_item = {} --[[@as hw_sidecar_item]] ---@diagnostic disable-line: assign-type-mismatch
  -- Icon Badges FIXME
  -- Localization FIXME
}}

-- Wood Torque Source
data:extend{{
  -- Basic
  type = "item",
  name = "water-wheel",
  -- Game
  stack_size = 50,
  place_result = "water-wheel",
  flags = {},
  -- Display
  icon = "__hidden-worlds__/graphics/icons/entity/water-wheel.png",
  icon_size = 64,
  -- Organization
  group = "production",
  subgroup = "wood-torque-source",
  order = "a water-wheel",
  -- Space Age
  weight = 1 * kg,
  -- Quality Mod
  auto_recycle = true,
  -- Sidecar
  hw_sidecar_item = {} --[[@as hw_sidecar_item]] ---@diagnostic disable-line: assign-type-mismatch
  -- Icon Badges FIXME
  -- Localization FIXME
}}

-- Workshop
data:extend{{
  -- Basic
  type = "item",
  name = "wood-workshop",
  -- Game
  stack_size = 50,
  place_result = "wood-workshop",
  flags = {},
  -- Display
  icon = "__hidden-worlds__/graphics/icons/entity/wood-workshop.png",
  icon_size = 64,
  -- Organization
  group = "production",
  subgroup = "wood-workshop",
  order = "a wood-workshop",
  -- Space Age
  weight = 1 * kg,
  -- Quality Mod
  auto_recycle = true,
  -- Sidecar
  hw_sidecar_item = {} --[[@as hw_sidecar_item]] ---@diagnostic disable-line: assign-type-mismatch
  -- Icon Badges FIXME
  -- Localization FIXME
}}