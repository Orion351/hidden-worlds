local a = 1
local p2p_antenna = table.deepcopy(data.raw["constant-combinator"]["constant-combinator"])
local temp = table.deepcopy(data.raw["arithmetic-combinator"]["arithmetic-combinator"])
p2p_antenna.collision_box = temp.collision_box
p2p_antenna.selection_box = temp.selection_box
p2p_antenna.fast_replaceable_group = temp.fast_replaceable_group
p2p_antenna.selection_box = temp.selection_box

p2p_antenna.name = "p2p-antenna"
p2p_antenna.icon = "__hidden-worlds__/graphics/experimental/p2p-antenna-icon.png"
p2p_antenna.sprites = {
  north = {
    layers = {
      {
        filename = "__hidden-worlds__/graphics/experimental/p2p-antenna3.png",
        priority = "high",
        x = 0,
        y = 0,
        width = 128,
        height = 128,
        shift = {0 / 32, -32 / 32},
        tint_as_overlay = false,
        scale = 0.5
      },
    }
  },
  south = {
    layers = {
      {
        filename = "__hidden-worlds__/graphics/experimental/p2p-antenna3.png",
        priority = "high",
        x = 0,
        y = 0,
        width = 128,
        height = 128,
        shift = {0 / 32, -32 / 32},
        tint_as_overlay = false,
        scale = 0.5
      },
    }
  },
  east = {
    layers = {
      {
        filename = "__hidden-worlds__/graphics/experimental/p2p-antenna3.png",
        priority = "high",
        x = 0,
        y = 0,
        width = 128,
        height = 128,
        shift = {0 / 32, -32 / 32},
        tint_as_overlay = false,
        scale = 0.5
      },
    }
  },
  west = {
    layers = {
      {
        filename = "__hidden-worlds__/graphics/experimental/p2p-antenna3.png",
        priority = "high",
        x = 0,
        y = 0,
        width = 128,
        height = 128,
        shift = {0 / 32, -32 / 32},
        tint_as_overlay = false,
        scale = 0.5
      },
    }
  },
}

data:extend{p2p_antenna}


data:extend{{
  type = "item",
  name = "p2p_antenna_item",
  stack_size = 100,
  icon = "__hidden-worlds__/graphics/experimental/p2p-antenna-icon.png",
  icon_size = 64,
  order = data.raw.item["constant-combinator"].order .. "1",
  subgroup = data.raw.item["constant-combinator"].subgroup,
  place_result = "p2p-antenna"
}}