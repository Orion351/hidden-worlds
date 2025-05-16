local slide_sizes = {{1, 1}, {2, 1}, {3, 1}}
local slide_names = {}
for _, size in pairs(slide_sizes) do
  table.insert(slide_names, "slide-" .. size[1] .. "x" .. size[2])
end
data:extend({
  {
    type = "recipe-category",
    name = "slide-recipes"
  }
})

for i, slide_name in pairs(slide_names) do
  data:extend({
    {
      type = "recipe-category",
      name = slide_name .. "-recipes"
    },
    {
      type = "item",
      name = slide_name .. "-slide",
      stack_size = 10,
      icon = "__hidden-worlds__/graphics/entity/slide/slide-1x1-n.png",
      icon_size = 64,
      place_result = slide_name .. "-slide"
    },
    {
      type = "furnace",
      name = slide_name .. "-slide",
      crafting_categories = {slide_name .. "-recipes"},
      crafting_speed = 1,
      energy_source = {
        type = "void",
      },
      energy_usage = "1W",
      allowed_effects = {},
      vector_to_place_result = {0.5 * i, 0},
      placeable_by = {item = slide_name .. "-slide", count = 1},
      minable = {result = slide_name .. "-slide", mining_time = 0.1},
      selection_box = {{(-0.5 * i), -0.5}, {(0.5 * i), 0.5}},
      collision_box = {{(-0.45 * i), -0.45}, {(0.45 * i), 0.45}},
      result_inventory_size = 1,
      source_inventory_size = 1,
      graphics_set = {
        idle_animation = {
          north = {
            filenames = {"__hidden-worlds__/graphics/entity/slide/" .. slide_name .. "-n.png"},
            width = 64 * i,
            height = 64,
            lines_per_file = 1,
            scale = 0.5
          },
          east = {
            filenames = {"__hidden-worlds__/graphics/entity/slide/" .. slide_name .. "-e.png"},
            width = 64,
            height = 64 * i,
            lines_per_file = 1,
            scale = 0.5
          },
          south = {
            filenames = {"__hidden-worlds__/graphics/entity/slide/" .. slide_name .. "-n.png"},
            width = 64 * i,
            height = 64,
            lines_per_file = 1,
            scale = 0.5
          },
          west = {
            filenames = {"__hidden-worlds__/graphics/entity/slide/" .. slide_name .. "-e.png"},
            width = 64,
            height = 64 * i,
            lines_per_file = 1,
            scale = 0.5
          }
        },
        working_visualisations = {{
          north_animation = {
            filenames = {"__hidden-worlds__/graphics/entity/slide/" .. slide_name .. "-n.png"},
            width = 64 * i,
            height = 64,
            lines_per_file = 1,
            scale = 0.5
          },
          east_animation = {
            filenames = {"__hidden-worlds__/graphics/entity/slide/" .. slide_name .. "-e.png"},
            width = 64,
            height = 64 * i,
            lines_per_file = 1,
            scale = 0.5
          },
          south_animation = {
            filenames = {"__hidden-worlds__/graphics/entity/slide/" .. slide_name .. "-n.png"},
            width = 64 * i,
            height = 64,
            lines_per_file = 1,
            scale = 0.5
          },
          west_animation = {
            filenames = {"__hidden-worlds__/graphics/entity/slide/" .. slide_name .. "-e.png"},
            width = 64,
            height = 64 * i,
            lines_per_file = 1,
            scale = 0.5
          }
        }
      }}
    }
  })
  for item_name, item_data in pairs(data.raw.item) do
    data:extend{
      {
        type = "recipe",
        name = item_name .. slide_name .. "-recipe",
        icon = item_data.icon,
        icons = item_data.icons,
        icon_size = item_data.icon_size,
        ingredients = {{type = "item", name = item_name, amount = 1}},
        results = {{type = "item", name = item_name, amount = 1}},
        energy_required = i * 0.1,
        category = slide_name .. "-recipes",
        hide_from_player_crafting = true,
        hide_from_signal_gui = true,
        hide_from_stats = true,
        hidden_in_factoriopedia = true,
        hidden = true
      }
    }
  end
end

data:extend{
  {
    type = "fluid",
    name = "torque",
    base_color = {r = 1, g = 1, b = 1, a = 1},
    flow_color = {r = 1, g = 1, b = 1, a = 1},
    default_temperature = 273,
    auto_barrel = false,
    fuel_value = "0W",
    icon = "__hidden-worlds__/graphics/icons/fluids/torque.png",
    icon_size = 64,
  },
  {
    type = "item",
    name = "test_pipe",
    icon = "__hidden-worlds__/graphics/icons/fluids/torque.png",
    icon_size = 64,
    stack_size = 10,
    place_result = "test_pipe"
  }
}

local test_pipe = table.deepcopy(data.raw.pipe.pipe)
test_pipe.name = "test_pipe"
test_pipe.fluid_box.filter = "torque"
data:extend{test_pipe}
local a = 1

-- data:extend{
--   {
--     type = "container",
--     name = "slide_container",
--   }
-- }

data:extend({
  {
    type = "item",
    name = "spaceship-control-console",
    stack_size = 10,
    icon = "__hidden-worlds__/graphics/icons/entity/spaceship-control-console-icon.png",
    icon_size = 64,
    place_result = "spaceship-control-console"
  },
  {
    type = "simple-entity-with-owner",
    name = "spaceship-control-console",
    animations = {
      sheets = {{
        filename = "__hidden-worlds__/graphics/entity/spaceship-control-console/spaceship-control-console-frames.png",
        height = 256,
        width = 256,
        variation_count = 1,
        scale = 0.5,
        line_length = 6,
        frame_count = 30,
        animation_speed = 0.5,
      },
      {
        filename = "__hidden-worlds__/graphics/entity/spaceship-control-console/spaceship-control-console-shadow.png",
        height = 205,
        width = 287,
        variation_count = 1,
        scale = 0.5,
        draw_as_shadow = true,
        line_length = 1,
        frame_count = 1,
        frame_sequence = {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, },
        animation_speed = 0.5,
        shift = {x = 10.5 / 32, y = 15 / 32},
      },
      -- {
      --   filename = "__hidden-worlds__/graphics/entity/spaceship-control-console/spaceship-control-console-glow-frames.png",
      --   height = 256,
      --   width = 256,
      --   variation_count = 1,
      --   scale = 0.5,
      --   draw_as_glow = true,
      --   line_length = 6,
      --   frame_count = 30,
      --   animation_speed = 0.5,
      --   blend_mode = "additive",
      --   tint = {r = 1, g = 1, b = 1, a = 0.0}
      -- }
    },
    },
    placeable_by = {item = "spaceship-control-console", count = 1},
    collision_box = {{-1.9, -1.9}, {1.9, 1.9}},
    selection_box = {{-2, -2}, {2, 2}},
    minable = {
      mining_time = 1,
      count = 1,
      result = "spaceship-control-console",
    }
  }
})