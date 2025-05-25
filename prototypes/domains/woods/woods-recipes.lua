-- Recipe Categories
data:extend{
  {
    type = "recipe-category",
    name = "wood-splitter"
  },
  {
    type = "recipe-category",
    name = "wood-stripper"
  },
}

-- "Recipe" Subgroups
data:extend{
  {
    type = "item-subgroup",
    name = "wood-splitter",
    group = "intermediate-products"
  },
  {
    type = "item-subgroup",
    name = "wood-stripper",
    group = "intermediate-products"
  },
}

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
      hw_sidecar_recipe = {tags = tags},
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
          icon_size = 128,
        }
      }
      -- FIXME add an SDF to the icons
      Build_img_badge_icon(icons, {"__hidden-worlds__/graphics/icons/woods/" .. material .. "-" .. stock .. "/" .. material .. "-" .. stock .. "-0000.png"}, 128, HW_Global.stock_badge_scale, 0, "right-top", 0)
      -- tags
      local tags = {}
      -- Do The Thing
      make_wood_recipe(name, icons, crafting_machine_tint, category, subgroup, order_full, ingredients, results, main_product, tags)
    end
  end
end

make_stock_to_part_fanout("split-lumber", "plank", {r = 1, g = 1, b = 1, a = 1}, "wood-splitter", "wood-splitter", "d", 2, 5, {}, {})
make_stock_to_part_fanout("split-lumber", "plank", {r = 1, g = 1, b = 1, a = 1}, "wood-splitter", "wood-splitter", "d", 2, 5, {}, {})