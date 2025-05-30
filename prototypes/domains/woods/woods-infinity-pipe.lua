data:extend{{
  type = "infinity-pipe",
  name = "linked_water_pipe",
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
}}