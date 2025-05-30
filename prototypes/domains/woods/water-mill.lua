---@type data.InfinityPipePrototype
local linked_water_pipe = {
  name = "linked_water_pipe",
  type = "infinity-pipe",
  gui_mode = "none",
  icon = "__base__/graphics/icons/fluid/water.png",
  fluid_box = {
    volume = 100,
    hide_connection_info = true,
    pipe_connections = {{
      --flow_direction = "output",
      connection_type = "linked",
      linked_connection_id  = 820
    }},
    filter = "water",
    production_type = "output",
  },
  horizontal_window_bounding_box = {{0, 0}, {0, 0}},
  vertical_window_bounding_box = {{0, 0}, {0, 0}},
  collision_mask = {layers = {}},
  icon_draw_specification = {scale = 0.0},
  hidden = true
}

---@type data.RecipeCategory
local waterWheelRecipeCategory = {
  name = "water-wheel",
  type = "recipe-category"
}

---@type data.RecipePrototype
local waterWheelTorqueRecipe = {
  name = "water-wheel-torque-recipe",
  type = "recipe",
  category = waterWheelRecipeCategory.name,
  ingredients = {
    {type="fluid", name="water", amount=50}
  },
  results = {
    {type = "fluid", name = "torque", amount = 100}
  }
}

---@type data.AssemblingMachinePrototype
local waterWheel = {
  name = "water-wheel",
  type = "assembling-machine",
  fixed_recipe = waterWheelTorqueRecipe.name,
  crafting_speed = 1,
  crafting_categories = {"water-wheel"},
  flags = {"placeable-neutral", "placeable-player", "player-creation"},
  energy_usage = "1W",
  energy_source = {type = "void"},
  minable = {mining_time = 0.2, result = "water-wheel"},
  
  collision_mask = {layers={object=true, train=true, is_object=true, is_lower_object=true, meltable=true}},
  collision_box = {{-1.4, -1.3}, {1.4, 1.4}},
  selection_box = {{-1.5, -1.5}, {1.5, 1.5}},
  fluid_boxes = {
    {
      volume = 100,
      filter = "water",
      production_type = "input",
      pipe_connections = {{
        connection_type = "linked",
        linked_connection_id  = 820
      }}
    },
    {
      volume = 100,
      filter = "torque",
      production_type = "output",
      pipe_connections = {{
        flow_direction = "output",
        direction = defines.direction.north --[[@as data.Direction]],
        position = {0, -1},
        connection_category = "torque"
      }}
    }
  },
  tile_buildability_rules = {
    {
      area = {{-1.2, -1.2}, {1.2, -0.7}},
      required_tiles = {layers={ground_tile=true}},
      colliding_tiles = {layers={water_tile=true}},
      remove_on_collision = false
    },
    {
      area = {{-1.2, 0}, {1, 1.2}},
      required_tiles = {layers={water_tile=true}},
      colliding_tiles = {layers={}}
    },
  },
  icon = "__hidden-worlds__/graphics/icons/entity/waterWheel.png"
}
waterWheel.graphics_set = table.deepcopy(data.raw["assembling-machine"]["assembling-machine-1"].graphics_set)

---@type data.ItemPrototype
local waterWheelItem = {
  type = "item",
  name = waterWheel.name,
  icon = waterWheel.icon,
  icon_size = 64,
  flags = {},
  subgroup = "extraction-machine",
  --order = "za"..name,
  place_result = waterWheel.name,
  stack_size = 50
}

---@type data.RecipePrototype
local waterWheelRecipe = {
  name = "water-wheel-recipe",
  type = "recipe",
  category = "basic-crafting",
  ingredients = {
  },
  results = {
    {type = "item", name = waterWheelItem.name, amount = 1}
  }
}

---@diagnostic disable-next-line: assign-type-mismatch
data:extend{linked_water_pipe, waterWheelRecipeCategory, waterWheelTorqueRecipe, waterWheel, waterWheelItem, waterWheelRecipe}
