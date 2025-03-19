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