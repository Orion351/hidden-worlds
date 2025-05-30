---@type data.FurnacePrototype
local splitterEntity = {
  name = "log-splitter",
  type = "furnace",
  crafting_speed = 1,
  minable = {mining_time = 0.2, result = "log-splitter"},
  energy_usage = "100kW",
  energy_source = {
    type = "fluid",
    --fluid_usage_per_tick = 1,
    burns_fluid = true,
    scale_fluid_usage = true,
    fluid_box = {
      volume = 100,
      filter = "torque",
      production_type = "input",
      pipe_connections = {{
        flow_direction = "input",
        direction = defines.direction.north --[[@as data.Direction]],
        position = {0, -1},
        connection_category = "torque"
      }}
    }
  },
  crafting_categories = {
    "log-splitter"
  },
  collision_box = {{-1.4, -1.4}, {1.4, 1.4}},
  selection_box = {{-1.5, -1.5}, {1.5, 1.5}},
  source_inventory_size = 1,
  result_inventory_size = 1,
  icon = "__hidden-worlds__/graphics/icons/entity/logSplitter.png",
  graphics_set = {
    animation = {
      north = {
        layers = {
          {
            filename = "__hidden-worlds__/graphics/greybox/grey-boxes/hw-grey-box-3x3.png",
            width = 192,
            height = 192,
            scale = 0.5
          },
          {
            filename = "__hidden-worlds__/graphics/greybox/primitive-titles/hw-label-log-splitter.png",
            width = 128,
            height = 64,
            scale = 0.5
          }
        }
      }
    }
  }
}

---@type data.ItemPrototype
local splitterItem = {
  type = "item",
  name = splitterEntity.name,
  icon = splitterEntity.icon,
  icon_size = 64,
  flags = {},
  subgroup = "extraction-machine",
  place_result = splitterEntity.name,
  stack_size = 50
}

---@type data.RecipePrototype
local splitterRecipe = {
  name = "log-splitter-recipe",
  type = "recipe",
  category = "basic-crafting",
  ingredients = {
    -- TODO
  },
  results = {
    {type = "item", name = splitterItem.name, amount = 1}
  }
}

---@diagnostic disable-next-line: assign-type-mismatch
data:extend {splitterEntity, splitterItem, splitterRecipe}