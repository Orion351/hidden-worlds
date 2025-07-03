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

local function get_suffix(str)
    if string.sub(str, 1, 4) == "hwt_" then
        return string.sub(str, 5)
    end
end

---@param event EventData.on_script_trigger_effect
local function on_tech_prototype_spoil(event)
  local suffix = get_suffix(event.effect_id)
  if not suffix then return end
  local resulting_recipe = prototypes.recipe[suffix]
  if not resulting_recipe then error("Item prototype " .. suffix .. " not found") end

  print("prototype spoilage " .. suffix)
  local tech = techs[suffix]
  if not tech then error("Unable to find corresponding tech for " .. suffix) end

  if math.random() <= tech.base_probability then
    print("Unlocked")
    local source_entity = event.source_entity
    if not source_entity then error("Cannot find event source entity") end
    local recipes = source_entity.force.recipes
    recipes[resulting_recipe.name].enabled = true
    recipes[resulting_recipe.name .. "-prototype"].enabled = false
  else
    print("Failed prototype")
  end
end

---@type event_handler 
local lib = {}

lib.events =
{
  [defines.events.on_script_trigger_effect] = on_tech_prototype_spoil,
}

lib.on_init = function()
  storage.tech_gui = storage.tech_gui or script_data
end

lib.on_load = function()
  script_data = storage.tech_gui or script_data
end

return lib