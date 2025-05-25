-- Item Subgroup
data:extend{
  {
    type = "item-subgroup",
    name = "wood",
    group = "intermediate-products"
  }
}

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
        icon_size = 128,
        pictures = {
          {size = 128, filename = "__hidden-worlds__/graphics/icons/" .. domain .. "/" .. name .. "/" .. name .. "-0000.png", scale = 0.25},
          {size = 128, filename = "__hidden-worlds__/graphics/icons/" .. domain .. "/" .. name .. "/" .. name .. "-0001.png", scale = 0.25},
          {size = 128, filename = "__hidden-worlds__/graphics/icons/" .. domain .. "/" .. name .. "/" .. name .. "-0002.png", scale = 0.25},
          {size = 128, filename = "__hidden-worlds__/graphics/icons/" .. domain .. "/" .. name .. "/" .. name .. "-0003.png", scale = 0.25},
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

-- Items Creation
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