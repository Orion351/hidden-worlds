---@alias unit_number integer
---@class WaterWheelScriptData
---@field wheels table<unit_number, WaterWheel>
local script_data = {
  wheels = {}
}

---@class WaterWheel
---@field entity LuaEntity
---@field surface_index int
---@field force_index int
---@field unit_number int
---@field input_pipe LuaEntity
local water_wheel = {}
water_wheel.metatable = {__index = water_wheel}

script.register_metatable("water_wheel", water_wheel.metatable)

function water_wheel:create()
  local entity = self.entity
  local pipe = entity.surface.create_entity {
    name = "linked_water_pipe",
    position = self.entity.position,
    force = self.force_index
  }
  if not pipe or not pipe.valid then error("Input pipe not valid") end
  self.input_pipe = pipe
  entity.fluidbox.add_linked_connection(820, pipe, 820)
  pipe.set_infinity_pipe_filter {
    name = "water",
    percentage = 1,
    mode = "exactly"
  }
end

function water_wheel:destroy()
  if self.input_pipe and self.input_pipe.valid then
    self.input_pipe.destroy()
  end
  script_data.wheels[self.entity.unit_number] = nil
end

function water_wheel.new(entity)
  script.register_on_object_destroyed(entity)
  
  local wheel = {
    entity = entity,
    surface_index = entity.surface.index,
    force_index = entity.force.index,
    unit_number = entity.unit_number,
  }
  setmetatable(wheel, water_wheel.metatable)
  
  wheel:create()
  
  script_data.wheels[entity.unit_number] = wheel
end

---@param event EventData.on_built_entity|EventData.on_robot_built_entity|EventData.on_space_platform_built_entity|EventData.script_raised_revive|EventData.script_raised_built
local on_built_entity = function(event)
  local entity = event.entity
  if not (entity and entity.valid) then return end
  
  if not (entity.name == "water-wheel") then return end
  
  water_wheel.new(entity)
end

---@param event EventData.on_player_mined_entity|EventData.on_robot_mined_entity|EventData.on_space_platform_mined_entity|EventData.on_entity_died|EventData.script_raised_destroy
local on_entity_removed = function(event)
  ---@diagnostic disable-next-line: undefined-field
  local unit_number = event.unit_number
  if not unit_number then
    local entity = event.entity
    if not (entity and entity.valid) then return end
    unit_number = entity.unit_number
  end
  
  if not unit_number then return end
  local wheel = script_data.wheels[unit_number]
  if not wheel then return end
  wheel:destroy()
end

local entity_died_event_type = defines.events.on_entity_died
---@param event EventData.on_object_destroyed
local on_object_destroyed = function(event)
  if event.type ~= entity_died_event_type then return end
  local unit_number = event.useful_id
  
  if not unit_number then return end
  local wheel = script_data.wheels[unit_number]
  if not wheel then return end
  wheel:destroy()
end

local lib = {}

lib.events =
{
  [defines.events.on_built_entity] = on_built_entity,
  [defines.events.on_robot_built_entity] = on_built_entity,
  [defines.events.script_raised_revive] = on_built_entity,
  [defines.events.script_raised_built] = on_built_entity,
  [defines.events.on_space_platform_built_entity] = on_built_entity,
  
  [defines.events.on_player_mined_entity] = on_entity_removed,
  [defines.events.on_robot_mined_entity] = on_entity_removed,
  [defines.events.on_space_platform_mined_entity] = on_entity_removed,
  
  [defines.events.on_entity_died] = on_entity_removed,
  [defines.events.script_raised_destroy] = on_entity_removed,
  [defines.events.on_object_destroyed] = on_object_destroyed,
}

lib.on_init = function()
  storage.water_wheel = storage.water_wheel or script_data
end

lib.on_load = function()
  script_data = storage.water_wheel or script_data
end

lib.on_configuration_changed = function()
end

return lib