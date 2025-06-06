-- Helper Functions
local function make_wood_lumber_assembler_greybox(name)
  data:extend{{
    -- Basic
    type = "assembling-machine",
    name = name,
    -- Crafting
    crafting_speed = 1,
    crafting_categories = {name},
    -- World
    collision_box = {{-1.4, -1.4}, {1.4, 1.4}},
    selection_box = {{-1.5, -1.5}, {1.5, 1.5}},
    vector_to_place_result = {x = 0, y = 1.7},
    minable = {mining_time = 0.2, result = name},
    flags = {"placeable-neutral", "placeable-player", "player-creation"},
    -- Furnace stuff?
    -- source_inventory_size = 1,
    -- result_inventory_size = 1,
    -- Power
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
        pipe_connections = {
          {
            flow_direction = "input-output",
            direction = defines.direction.east --[[@as data.Direction]],
            position = {1, -1},
            connection_category = "torque"
          },
          {
            flow_direction = "input-output",
            direction = defines.direction.west --[[@as data.Direction]],
            position = {-1, -1},
            connection_category = "torque"
          }
        }
      }
    },
    -- Icon
    icon = "__hidden-worlds__/graphics/icons/entity/" .. name ..".png",
    -- Display
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
              filename = "__hidden-worlds__/graphics/greybox/primitive-titles/hw-label-" .. name ..".png",
              width = 128,
              height = 64,
              scale = 0.5
            }
          }
        },
        west = {
          layers = {
            {
              filename = "__hidden-worlds__/graphics/greybox/grey-boxes/hw-grey-box-3x3.png",
              width = 192,
              height = 192,
              scale = 0.5
            },
            {
              filename = "__hidden-worlds__/graphics/greybox/primitive-titles/hw-label-" .. name ..".png",
              width = 128,
              height = 64,
              scale = 0.5
            }
          }
        },
        south = {
          layers = {
            {
              filename = "__hidden-worlds__/graphics/greybox/grey-boxes/hw-grey-box-3x3.png",
              width = 192,
              height = 192,
              scale = 0.5
            },
            {
              filename = "__hidden-worlds__/graphics/greybox/primitive-titles/hw-label-" .. name ..".png",
              width = 128,
              height = 64,
              scale = 0.5
            }
          }
        },
        east = {
          layers = {
            {
              filename = "__hidden-worlds__/graphics/greybox/grey-boxes/hw-grey-box-3x3.png",
              width = 192,
              height = 192,
              scale = 0.5
            },
            {
              filename = "__hidden-worlds__/graphics/greybox/primitive-titles/hw-label-" .. name ..".png",
              width = 128,
              height = 64,
              scale = 0.5
            }
          }
        }
      }
    }
  }}
end

local function make_cut_wood_assembler_greybox(name)
  data:extend{{
    -- Basic
    type = "assembling-machine",
    name = name,
    -- Crafting
    crafting_speed = 1,
    crafting_categories = {name},
    -- World
    collision_box = {{-1.4, -0.9}, {1.4, 0.9}},
    selection_box = {{-1.5, -1.0}, {1.5, 1.0}},
    vector_to_place_result = {x = 0, y = 1.2},
    minable = {mining_time = 0.2, result = name},
    flags = {"placeable-neutral", "placeable-player", "player-creation"},
    -- Furnace stuff?
    -- source_inventory_size = 1,
    -- result_inventory_size = 1,
    -- Power
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
        pipe_connections = {
          {
            flow_direction = "input-output",
            direction = defines.direction.east --[[@as data.Direction]],
            position = {1, -0.5},
            connection_category = "torque"
          },
          {
            flow_direction = "input-output",
            direction = defines.direction.west --[[@as data.Direction]],
            position = {-1, -0.5},
            connection_category = "torque"
          }
        }
      }
    },
    -- Icon
    icon = "__hidden-worlds__/graphics/icons/entity/" .. name ..".png",
    -- Display
    graphics_set = {
      animation = {
        north = {
          layers = {
            {
              filename = "__hidden-worlds__/graphics/greybox/grey-boxes/hw-grey-box-3x2.png",
              width = 192,
              height = 128,
              scale = 0.5
            },
            {
              filename = "__hidden-worlds__/graphics/greybox/primitive-titles/hw-label-" .. name ..".png",
              width = 128,
              height = 64,
              scale = 0.5
            }
          }
        },
        west = {
          layers = {
            {
              filename = "__hidden-worlds__/graphics/greybox/grey-boxes/hw-grey-box-2x3.png",
              width = 128,
              height = 192,
              scale = 0.5
            },
            {
              filename = "__hidden-worlds__/graphics/greybox/primitive-titles/hw-label-" .. name ..".png",
              width = 128,
              height = 64,
              scale = 0.5
            }
          }
        },
        south = {
          layers = {
            {
              filename = "__hidden-worlds__/graphics/greybox/grey-boxes/hw-grey-box-3x2.png",
              width = 192,
              height = 128,
              scale = 0.5
            },
            {
              filename = "__hidden-worlds__/graphics/greybox/primitive-titles/hw-label-" .. name ..".png",
              width = 128,
              height = 64,
              scale = 0.5
            }
          }
        },
        east = {
          layers = {
            {
              filename = "__hidden-worlds__/graphics/greybox/grey-boxes/hw-grey-box-2x3.png",
              width = 128,
              height = 192,
              scale = 0.5
            },
            {
              filename = "__hidden-worlds__/graphics/greybox/primitive-titles/hw-label-" .. name ..".png",
              width = 128,
              height = 64,
              scale = 0.5
            }
          }
        }
      }
    }
  }}
end

-- Assemblers
local lumber_wood_assembler_entity_data = {
  ["log-splitter"]     = {},
  ["log-stripper"]     = {},
  ["grindstone"]       = {},
  ["rope-twister"]     = {},
  ["spin-n-sieve"]     = {},
  ["stone-autohammer"] = {},
  ["stone-crusher"]    = {},
  ["wood-vat"]         = {},
  ["wood-press"]       = {},
}

local cut_wood_assembler_entity_data = {
  ["wood-planer"]      = {},
  ["wood-tablesaw"]    = {},
  ["wood-lathe"]       = {},
}

for name, data in pairs(lumber_wood_assembler_entity_data) do
  make_wood_lumber_assembler_greybox(name)
end

for name, data in pairs(cut_wood_assembler_entity_data) do
  make_cut_wood_assembler_greybox(name)
end


-- Logistics Entities
-- axle-5x1
data:extend{{
  -- Basic
  type = "assembling-machine",
  name = "axle-5x1",
  -- Crafting
  fixed_recipe = "axle-torque-recipe",
  crafting_speed = 1,
  crafting_categories = {"wood-axle"},
  -- Power
  energy_usage = "1W",
  energy_source = {type = "void"},
  -- World
  collision_box = {{-0.4, -2.4}, {0.4, 2.4}},
  selection_box = {{-0.5, -2.5}, {0.5, 2.5}},
  minable = {mining_time = 0.2, result = "axle-5x1"},
  flags = {"placeable-neutral", "placeable-player", "player-creation"},
  -- Fluid Boxes
  fluid_boxes = {
    {
    volume = 100,
    filter = "torque",
    production_type = "input",
    pipe_connections = {
      {
        flow_direction = "input-output",
        direction = defines.direction.north --[[@as data.Direction]],
        position = {0, -2},
        connection_category = "torque"
      }, {
        flow_direction = "input-output",
        direction = defines.direction.south --[[@as data.Direction]],
        position = {0, 2},
        connection_category = "torque"
      }
    }}, {
    volume = 100,
    filter = "torque",
    production_type = "output",
    pipe_connections = {
      {
        flow_direction = "output",
        direction = defines.direction.west --[[@as data.Direction]],
        position = {0, -2},
        connection_category = "torque"
      }, {
        flow_direction = "output",
        direction = defines.direction.east --[[@as data.Direction]],
        position = {0, -2},
        connection_category = "torque"
      }, {
        flow_direction = "output",
        direction = defines.direction.west --[[@as data.Direction]],
        position = {0, 2},
        connection_category = "torque"
      }, {
        flow_direction = "output",
        direction = defines.direction.east --[[@as data.Direction]],
        position = {0, 2},
        connection_category = "torque"
      }
    }
  }},
  -- Icon
  icon = "__hidden-worlds__/graphics/icons/entity/axle-5x1.png",
  icon_size = 64,
  -- Display
  graphics_set = {
    animation = {
      north = {
        layers = {
          {
            filename = "__hidden-worlds__/graphics/greybox/grey-boxes/hw-grey-box-1x5.png",
            width = 64,
            height = 320,
            scale = 0.5
          },
          {
            filename = "__hidden-worlds__/graphics/greybox/primitive-titles/hw-label-axle-5x1.png",
            width = 128,
            height = 64,
            scale = 0.5
          },
        }
      },
      west = {
        layers = {
          {
            filename = "__hidden-worlds__/graphics/greybox/grey-boxes/hw-grey-box-5x1.png",
            width = 320,
            height = 64,
            scale = 0.5
          },
          {
            filename = "__hidden-worlds__/graphics/greybox/primitive-titles/hw-label-axle-5x1.png",
            width = 128,
            height = 64,
            scale = 0.5
          },
        }
      },
      south = {
        layers = {
          {
            filename = "__hidden-worlds__/graphics/greybox/grey-boxes/hw-grey-box-1x5.png",
            width = 64,
            height = 320,
            scale = 0.5
          },
          {
            filename = "__hidden-worlds__/graphics/greybox/primitive-titles/hw-label-axle-5x1.png",
            width = 128,
            height = 64,
            scale = 0.5
          },
        }
      },
      east = {
        layers = {
          {
            filename = "__hidden-worlds__/graphics/greybox/grey-boxes/hw-grey-box-5x1.png",
            width = 320,
            height = 64,
            scale = 0.5
          },
          {
            filename = "__hidden-worlds__/graphics/greybox/primitive-titles/hw-label-axle-5x1.png",
            width = 128,
            height = 64,
            scale = 0.5
          },
        }
      },
    }
  }
}}

-- wood-chute
data:extend{{
  -- Basic
  type = "furnace",
  name = "wood-chute",
  -- Power
  energy_usage = "1W",
  energy_source = {type = "void"},
  -- World
  collision_box = {{-0.4, -2.4}, {0.4, 2.4}},
  selection_box = {{-0.5, -2.5}, {0.5, 2.5}},
  vector_to_place_result = {0, 2.7},
  minable = {mining_time = 0.2, result = "wood-chute"},
  flags = {"placeable-neutral", "placeable-player", "player-creation"},
  -- Crafting
  crafting_speed = 1,
  crafting_categories = {"wood-chute"},
  result_inventory_size = 1,
  source_inventory_size = 1,
  -- Game
  allowed_effects = {},
  -- Icon
  icon = "__hidden-worlds__/graphics/icons/entity/wood-chute.png",
  icon_size = 64,
  -- Display
  graphics_set = {
    animation = {
      north = {
        layers = {
          {
            filename = "__hidden-worlds__/graphics/greybox/grey-boxes/hw-grey-box-1x5.png",
            width = 64,
            height = 320,
            scale = 0.5
          },
          {
            filename = "__hidden-worlds__/graphics/greybox/primitive-titles/hw-label-wood-chute.png",
            width = 128,
            height = 64,
            scale = 0.5
          },
        }
      },
      west = {
        layers = {
          {
            filename = "__hidden-worlds__/graphics/greybox/grey-boxes/hw-grey-box-5x1.png",
            width = 320,
            height = 64,
            scale = 0.5
          },
          {
            filename = "__hidden-worlds__/graphics/greybox/primitive-titles/hw-label-wood-chute.png",
            width = 128,
            height = 64,
            scale = 0.5
          },
        }
      },
      south = {
        layers = {
          {
            filename = "__hidden-worlds__/graphics/greybox/grey-boxes/hw-grey-box-1x5.png",
            width = 64,
            height = 320,
            scale = 0.5
          },
          {
            filename = "__hidden-worlds__/graphics/greybox/primitive-titles/hw-label-wood-chute.png",
            width = 128,
            height = 64,
            scale = 0.5
          },
        }
      },
      east = {
        layers = {
          {
            filename = "__hidden-worlds__/graphics/greybox/grey-boxes/hw-grey-box-5x1.png",
            width = 320,
            height = 64,
            scale = 0.5
          },
          {
            filename = "__hidden-worlds__/graphics/greybox/primitive-titles/hw-label-wood-chute.png",
            width = 128,
            height = 64,
            scale = 0.5
          },
        }
      },
    }
  }
}}

-- wood-trough
local wood_trough = table.deepcopy(data.raw.pipe.pipe)
wood_trough.name = "wood-trough"
wood_trough.minable.result = "wood-trough"
data:extend{wood_trough}

-- Torque Source
data:extend{{
  name = "water-wheel",
  type = "assembling-machine",
  fixed_recipe = "water-wheel-torque-recipe",
  crafting_speed = 1,
  crafting_categories = {"water-wheel"},
  flags = {"placeable-neutral", "placeable-player", "player-creation"},
  energy_usage = "1W",
  energy_source = {type = "void"},
  minable = {mining_time = 0.2, result = "water-wheel"},
  collision_mask = {
    layers={object=true, train=true, is_object=true, is_lower_object=true, meltable=true}},
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
  icon = "__hidden-worlds__/graphics/icons/entity/water-wheel.png",
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
            filename = "__hidden-worlds__/graphics/greybox/primitive-titles/hw-label-water-wheel.png",
            width = 128,
            height = 64,
            scale = 0.5
          }
        }
      },
      west = {
        layers = {
          {
            filename = "__hidden-worlds__/graphics/greybox/grey-boxes/hw-grey-box-3x3.png",
            width = 192,
            height = 192,
            scale = 0.5
          },
          {
            filename = "__hidden-worlds__/graphics/greybox/primitive-titles/hw-label-water-wheel.png",
            width = 128,
            height = 64,
            scale = 0.5
          }
        }
      },
      south = {
        layers = {
          {
            filename = "__hidden-worlds__/graphics/greybox/grey-boxes/hw-grey-box-3x3.png",
            width = 192,
            height = 192,
            scale = 0.5
          },
          {
            filename = "__hidden-worlds__/graphics/greybox/primitive-titles/hw-label-water-wheel.png",
            width = 128,
            height = 64,
            scale = 0.5
          }
        }
      },
      east = {
        layers = {
          {
            filename = "__hidden-worlds__/graphics/greybox/grey-boxes/hw-grey-box-3x3.png",
            width = 192,
            height = 192,
            scale = 0.5
          },
          {
            filename = "__hidden-worlds__/graphics/greybox/primitive-titles/hw-label-water-wheel.png",
            width = 128,
            height = 64,
            scale = 0.5
          }
        }
      }
    }
  }
}}
