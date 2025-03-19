---@ class HW_globals
HW_globals = HW_globals or {}

local items = {
  ["primitive-intermeidates"] = {"rope"},
  ["earths"] = {"dry-clay", "wet-clay"},
  ["woods"] = {"bark", "timber-hardwood", "timber-softwood", "lumber-hardwood", "lumber-softwood", "timber-split-hardwood", "timber-split-softwood", "lumber-split-hardwood", "lumber-split-softwood"}
}

for dir, things in pairs(items) do
  for _, thing in pairs(things) do
    local pics = {}
    for i = 0, 1, 1 do
      table.insert(pics, {size = 128, scale = 0.25, filename = "__hidden-worlds__/graphics/icons/" .. dir .. "/" .. thing .. "/" .. thing .. "-000" .. i .. ".png"})
    end
    
    data:extend{{
      type = "item",
      name = thing,
      stack_size = 100,
      icon_size = 128,
      icon = "__hidden-worlds__/graphics/icons/" .. dir .. "/" .. thing .. "/" .. thing .. "-0000.png",
      pictures = pics
    }}
  end
end

-- Compound Entity POC

data:extend{
  {
    type = "item",
    name = "dispatcher",
    stack_size = 5,
    icon = data.raw.item["assembling-machine-1"].icon,
    icon_size = data.raw.item["assembling-machine-1"].icon_size,
    place_result = "dispatch-cargo",
  },
  {
    type = "container",
    name = "dispatch-cargo",
    inventory_size = 100,
    max_health = 350,
    circuit_connector = data.raw["assembling-machine"]["assembling-machine-1"].circuit_connector,
    circuit_wire_max_distance = 9,
    inventory_type = "with_filters_and_bar",
    picture = {
      filename = "__hidden-worlds__/graphics/entity/dispatcher/dispatcher.png",
      size = {214, 226},
      scale = 0.5,
    },
    minable = {
      results = {{type = "item", name = "dispatcher", amount = 1}},
      mining_time = .5,
    },
    collision_box = {{-1.4, -1.4}, {1.4, 1.4}},
    selection_box = {{-1.5, -1.5}, {1.5, 1.5}},
  }
}

