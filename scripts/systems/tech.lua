---@class TechScriptDataExperiment
---@field level int
---@field crafts_completed int

---@class TechScriptDataForce
---@field experiments table<string, TechScriptDataExperiment>?
---@field tech_multipliers table<string, number>?
---@field tech_adders table<string, number>?

---@class TechScriptData
---@field force table<int, TechScriptDataForce>
local script_data = {
  force = {}
}


---@type table<string, LuaTechDomainTech>
local techs = {}

for _, mod_data in pairs(prototypes.mod_data) do
  if mod_data.data_type ~= "hidden-worlds.tech-domain-tech" then
    goto continue
  end
  ---@cast mod_data LuaTechDomainTechModData

  techs[mod_data.data.recipe] = mod_data.data

  ::continue::
end

local function print(str)
  game.print(str, {["sound"] = defines.print_sound.never, ["skip"] = defines.print_skip.never})
end

---@param force LuaForce
---@param tech LuaTechDomainTech
local function get_tech_probability(force, tech)
  local force_data = script_data.force[force.index]
  if not force_data then return tech.base_probability end

  local probability_multiplier = force_data.tech_multipliers and force_data.tech_multipliers[tech.recipe] or 1
  local probability_additive = force_data.tech_adders and force_data.tech_adders[tech.recipe] or 0
  return tech.base_probability * probability_multiplier + probability_additive
end

---@param source_entity LuaEntity
---@param data LuaPrototypeSpoilageEvent
local function handle_prototype_spoilage(source_entity, data)
  local resulting_recipe = prototypes.recipe[data.recipe]

  print("prototype spoilage " .. data.recipe)
  local tech = techs[data.recipe]
  if not tech then error("Unable to find corresponding tech for " .. data.recipe) end

  local probability = get_tech_probability(source_entity.force --[[@as LuaForce]], tech)
  print("probability: " .. probability)
  if math.random() <= probability  then
    print("Unlocked")
    local source_entity = source_entity
    if not source_entity then error("Cannot find event source entity") end
    local recipes = source_entity.force.recipes
    recipes[resulting_recipe.name].enabled = true
    recipes[resulting_recipe.name .. "-prototype"].enabled = false
  else
    print("Failed prototype")
  end
end

---@param force LuaForce
---@param experiment TechDomainTechExperiment
---@return int
local function get_experiment_level(force, experiment)
  local experiment_store = script_data.force[force.index].experiments[experiment.name]
  return experiment_store and experiment_store.level or 0
end

---@param force LuaForce
---@param experiment_store TechScriptDataExperiment
---@param experiment TechDomainTechExperiment
local function level_experiment(force, experiment_store, experiment)
  experiment_store.level = experiment_store.level + 1
  experiment_store.crafts_completed = 0

  local force_data = script_data.force[force.index]
  if not force_data then error("No data for force " .. force.index) end

  local modifier_name
  if experiment.modifier == "add" then
    modifier_name = "tech_adders"
  elseif experiment.modifier == "mult" then
    modifier_name = "tech_multipliers"
  else
    error("Unknown modifier " .. experiment.modifier)
  end

  if not force_data[modifier_name] then
    force_data[modifier_name] = {}
  end

  for _, tech_name in pairs(experiment.techs) do
    if not force_data[modifier_name][tech_name] then
      force_data[modifier_name][tech_name] = experiment.value
    else
      if experiment.modifier == "add" then
        force_data[modifier_name][tech_name] = force_data[modifier_name][tech_name] + experiment.value
        print("New adder: " .. force_data[modifier_name][tech_name] .. " for tech " .. tech_name)
      elseif experiment.modifier == "mult" then
        force_data[modifier_name][tech_name] = force_data[modifier_name][tech_name] * experiment.value
        print("New multiplier: " .. force_data[modifier_name][tech_name] .. " for tech " .. tech_name)
      else
        error("Unknown modifier " .. experiment.modifier)
      end
    end
  end

  if not experiment.levels[experiment_store.level + 1] then
    print("Max level reached")
    force.recipes[experiment.recipe].enabled = false
  end
end

---@param force LuaForce
---@param experiment_store TechScriptDataExperiment
---@param experiment TechDomainTechExperiment
local function check_experiment_level(force, experiment_store, experiment)
  local required_crafts = experiment.levels[experiment_store.level + 1]
  if experiment_store.crafts_completed >= required_crafts then
    level_experiment(force, experiment_store, experiment)
    print("Experiment " .. experiment.name .. " level up to " .. experiment_store.level)
  else
    print("Experiment " .. experiment.name .. " level " .. experiment_store.level .. " " .. experiment_store.crafts_completed .. "/" .. required_crafts)
  end
end

---@param force LuaForce
---@param experiment TechDomainTechExperiment
local function add_experiment_craft(force, experiment)
  local force_data = script_data.force[force.index]
  if not force_data then
    force_data = {experiments = {}}
    script_data.force[force.index] = force_data
  end

  local experiment_store = force_data[experiment.name]
  if not experiment_store then
    experiment_store =  {level = 0, crafts_completed = 1}
    force_data[experiment.name] = experiment_store
  else
    experiment_store.crafts_completed = experiment_store.crafts_completed + 1
  end
  check_experiment_level(force, experiment_store, experiment)
end

---@param source_entity LuaEntity
---@param data ExperimentSpoilageEventData
local function handle_experiment_spoilage(source_entity, data)
    --print("experiment spoilage " .. data.experiment_name)
    local experiment_data = prototypes.mod_data[data.experiment_name] --[[@as LuaTechDomainTechExperimentModData]]
    if not experiment_data then return end
    --print("experiment: " .. experiment_data.data.name)
    add_experiment_craft(source_entity.force --[[@as LuaForce]], experiment_data.data)
end

---@param event EventData.on_script_trigger_effect
local function on_spoil_event(event)
  local mod_data = prototypes.mod_data[event.effect_id]
  if not mod_data or mod_data.data_type ~= "hidden-worlds.spoilage-event" then return end
  ---@cast mod_data LuaSpoilageEventModData

  if mod_data.data.type == "prototype" then
    handle_prototype_spoilage(event.source_entity, mod_data.data --[[@as LuaPrototypeSpoilageEvent]])
  elseif mod_data.data.type == "experiment" then
    handle_experiment_spoilage(event.source_entity, mod_data.data --[[@as ExperimentSpoilageEventData]])
  end
end

---@type event_handler 
local lib = {}

lib.events =
{
  [defines.events.on_script_trigger_effect] = on_spoil_event,
}

local function ensure_storage()
  storage.tech = storage.tech or script_data
end

lib.on_init = function()
  ensure_storage()
end

lib.on_load = function()
  script_data = storage.tech or script_data
end

lib.on_configuration_changed = function()
  print("Configuration changed. Setting storage")
  ensure_storage()
end

return lib