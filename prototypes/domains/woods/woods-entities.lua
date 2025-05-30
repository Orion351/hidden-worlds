-- axle-5x1
data:extend{{
  name = "axle-5x1",
  type = "assembling-machine",
  fixed_recipe = "axle-torque-recipe",
  crafting_speed = 1,
  crafting_categories = {"wood-axle"},
  energy_usage = "1W",
  energy_source = {type = "void"},
  minable = {mining_time = 0.2, result = "axle-5x1"},
  flags = {"placeable-neutral", "placeable-player", "player-creation"},
  collision_box = {{-0.4, -2.4}, {0.4, 2.4}},
  selection_box = {{-0.5, -2.5}, {0.5, 2.5}},
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
      }
      
    }, {
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
    }
  },
  icon = "__hidden-worlds__/graphics/icons/entity/axle.png",
  graphics_set = {
    animation = {
      north = {
        filename = "__hidden-worlds__/graphics/greybox/grey-boxes/hw-grey-box-1x5.png",
        width = 64,
        height = 320,
        scale = 0.5
      },
      west = {
        filename = "__hidden-worlds__/graphics/greybox/grey-boxes/hw-grey-box-5x1.png",
        width = 320,
        height = 64,
        scale = 0.5
      },
      south = {
        filename = "__hidden-worlds__/graphics/greybox/grey-boxes/hw-grey-box-1x5.png",
        width = 64,
        height = 320,
        scale = 0.5
      },
      east = {
        filename = "__hidden-worlds__/graphics/greybox/grey-boxes/hw-grey-box-5x1.png",
        width = 320,
        height = 64,
        scale = 0.5
      }
    }
  }
}}

-- log-splitter
data:extend{{
  name = "log-splitter",
  type = "furnace",
  crafting_speed = 1,
  minable = {mining_time = 0.2, result = "log-splitter"},
  flags = {"placeable-neutral", "placeable-player", "player-creation"},
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
  crafting_categories = {"log-splitter"},
  collision_box = {{-1.4, -1.4}, {1.4, 1.4}},
  selection_box = {{-1.5, -1.5}, {1.5, 1.5}},
  source_inventory_size = 1,
  result_inventory_size = 1,
  icon = "__hidden-worlds__/graphics/icons/entity/log-splitter.png",
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
            filename = "__hidden-worlds__/graphics/greybox/primitive-titles/hw-label-log-splitter.png",
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
            filename = "__hidden-worlds__/graphics/greybox/primitive-titles/hw-label-log-splitter.png",
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
            filename = "__hidden-worlds__/graphics/greybox/primitive-titles/hw-label-log-splitter.png",
            width = 128,
            height = 64,
            scale = 0.5
          }
        }
      }
    }
  }
}}

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
