-- Infinity pipe
-- This is to be used with the Water Wheel.
data:extend{{
  -- Basic
  type = "infinity-pipe",
  name = "linked_water_pipe",
  -- Icon
  icon = "__base__/graphics/icons/fluid/water.png",
  -- Display
  hidden = true,
  icon_draw_specification = {scale = 0.0},
  gui_mode = "none",
  -- Fluid Box
  fluid_box = {
    volume = 100,
    pipe_connections = {{
      -- flow_direction = "output",
      connection_type = "linked",
      linked_connection_id  = 820
    }},
    filter = "water",
    production_type = "output",
    hide_connection_info = true,
  },
  -- Boxes
  horizontal_window_bounding_box = {{0, 0}, {0, 0}},
  vertical_window_bounding_box = {{0, 0}, {0, 0}},
  collision_mask = {layers = {}},
}}