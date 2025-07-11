--local icon_root = "__hidden-worlds__/graphics/technology"
---@param domain TechDomain
local function create_domain_tech(domain)
  return {
    type = "technology",
    name = domain.name .. "-domain",
    localised_name = {"technology.hw_domain", {"technology.hw_" .. domain.name}},
    icon_size = 256,
    icon = "__hidden-worlds__/graphics/icons/technology/".. domain.name .. ".png",
    enabled = false,
    visible_when_disabled = true,
    effects = {},
    unit =
    {
      -- The prototype needs to have a cost or trigger, maybe replace this by a dummy science pack or something
      count = 2^32 - 1,
      ingredients = {{"automation-science-pack", 1}},
      time = 2^32 -1
    },
    order = "c-a"
  }
end

---@param domains table<string, data.TechnologyPrototype>
---@param domain_tech TechDomainTech
local function add_domain_tech(domains, domain_tech)
  local domain = domains[domain_tech.domain]

  table.insert(
    domain.effects,
    {
      type = "unlock-recipe",
      recipe = domain_tech.recipe
    }
  )
end

-- Creating prototype recipes and prototype result items
---@param prototype data.PrototypeBase
local function set_prototype_localisation(prototype)
    if prototype.localised_name then
      -- TODO
      log("TODO: Fix localised name for prototype " .. prototype.type .. " " .. prototype.name)
    end
    if prototype.localised_description then
      -- TODO
      log("TODO: Fix localised description for prototype " .. prototype.type .. " " .. prototype.name)
    end
end

local blueprint_tint = {r = 74 / 255, g = 109 / 255, b = 229 / 255, a = 255 / 255} -- Blueprint blue
local experiment_tint = {r = 50 / 255, g = 82 / 255, b = 47 / 255, a = 255 / 255} -- Just some green color

---@param recipe data.RecipePrototype
---@param tint Color
local function tint_prototype_icon(recipe, tint)
  if tint.r > 1 or tint.g > 1 or tint.b > 1 or tint.a > 1 then
    tint.r = tint.r / 255
    tint.g = tint.g / 255
    tint.b = tint.b / 255
    tint.a = tint.a / 255
  end
  if recipe.icon then
    recipe.icons =
    {{
      icon = recipe.icon,
      icon_size = recipe.icon_size,
      tint = tint
    }}
    return
  end
  for _, icon in pairs(recipe.icons) do
    if icon.tint then
      icon.tint.r = icon.tint.r * tint.r
      icon.tint.g = icon.tint.g * tint.g
      icon.tint.b = icon.tint.b * tint.b
    else
      icon.tint = tint
    end
  end
end

---@class LuaSpoilageEventModData : LuaModData
---@field data LuaSpoilageEvent

---@class LuaSpoilageEvent
---@field type SpoilageEventTypes

---@class LuaPrototypeSpoilageEvent : LuaSpoilageEvent
---@field recipe string

---@class LuaExperimentSpoilageEvent : LuaSpoilageEvent
---@field recipe string

---@alias SpoilageEventTypes "prototype"|"experiment"

---@class SpoilageEventData
---@field type SpoilageEventTypes

---@class PrototypeSpoilageEventData : SpoilageEventData
---@field recipe string Base recipe the prototype tries to unlock

---@class ExperimentSpoilageEventData : SpoilageEventData
---@field experiment_name string

---@alias SpoilageEventDatas PrototypeSpoilageEventData|ExperimentSpoilageEventData

---@param item_name string
---@param spoilage_data SpoilageEventDatas
local function create_spoilage_event(item_name, spoilage_data)
  data:extend{{
    type = "mod-data",
    name = "hidden-worlds-" .. item_name .. "-spoilage-event",
    data_type = "hidden-worlds.spoilage-event",
    data = spoilage_data
  }}
end

---@param prototype data.ItemPrototype
local function set_item_spoilage_event(prototype)
  prototype.spoil_ticks = 1
  prototype.spoil_result = nil
  prototype.burnt_result = nil
  prototype.spoil_to_trigger_result = {
    trigger = {
      type = "direct",
      action_delivery =
      {
        type = "instant",
        source_effects =
        {
            {
                type = "script",
                effect_id = "hidden-worlds-" .. prototype.name .. "-spoilage-event"
            },
        }
      }
    },
    items_per_trigger = 1
  }
end

---@param tech TechDomainTech 
local function create_prototype_recipe_and_item(tech)
  local base_recipe = data.raw.recipe[tech.recipe]
  base_recipe.enabled = false

  local prototype_recipe = table.deepcopy(base_recipe)
  prototype_recipe.name = prototype_recipe.name .. "-prototype"
  prototype_recipe.auto_recycle = false
  prototype_recipe.enabled = true -- TODO remove
  prototype_recipe.result_is_always_fresh = true
  set_prototype_localisation(prototype_recipe)
  tint_prototype_icon(prototype_recipe, blueprint_tint)

  local prototype_results = {}

  if not prototype_recipe.main_product then
    error("HWTech requires recipe to have a main_product")
  end
  prototype_recipe.main_product = prototype_recipe.main_product .. "-prototype"

  local base_item = data.raw.item[base_recipe.main_product]
  local prototype_item_name = base_item.name .. "-prototype"
  if data.raw.item[prototype_item_name] then
    error("Prototype item for " .. base_item.name .. " already exists.")
  end

  local prototype_item = table.deepcopy(base_item)
  prototype_item.name = prototype_item_name
  set_prototype_localisation(prototype_item)
  tint_prototype_icon(prototype_item, blueprint_tint)
  set_item_spoilage_event(prototype_item)

  table.insert(prototype_results, {
    type = "item",
    name = prototype_item_name,
    amount = 1
  })
  create_spoilage_event(prototype_item_name, {type = "prototype", recipe = base_recipe.name})
  ---@diagnostic disable-next-line: assign-type-mismatch
  data:extend({prototype_item})
  prototype_recipe.results = prototype_results


  log("prototype recipe prototype: " .. serpent.dump(prototype_recipe))
  ---@diagnostic disable-next-line: assign-type-mismatch
  data:extend({prototype_recipe})
end


local domains = {}

-- Creating all the domains
for _, mod_data in pairs(data.raw["mod-data"]) do
  if mod_data.data_type == "hidden-worlds.tech-domain" then
    ---@cast mod_data TechDomainModData
    domains[mod_data.data.name] = create_domain_tech(mod_data.data)
  end
end

for _, mod_data in pairs(data.raw["mod-data"]) do
  if mod_data.data_type == "hidden-worlds.tech-domain-tech" then
    -- Adding all unlocks to the domain tech and creating the prototype items and recipes
    ---@cast mod_data TechDomainTechModData
    add_domain_tech(domains, mod_data.data)
    create_prototype_recipe_and_item(mod_data.data)
  elseif mod_data.data_type == "hidden-worlds.tech-experiment" then
    -- Creating experiment result items with their spoilage events.
    -- Set the experiment recipe's results to the item
    ---@cast mod_data TechDomainTechExperimentModData
    local experiment = mod_data.data
    local item = {
      type = "item",
      name = experiment.name .. "-experiment-result",
      stack_size = 1,
      icon = "__hidden-worlds__/graphics/icons/experiments/".. experiment.name .. ".png",
      icon_size = 64,
      hidden = true,
      hidden_in_factoriopedia = true
    }
    tint_prototype_icon(item, experiment_tint)
    set_item_spoilage_event(item)
    data:extend({item})

    create_spoilage_event(item.name, {type = "experiment", experiment_name = "hidden-worlds-" .. experiment.name .. "-tech-experiment"})

    local recipe_prototype = data.raw.recipe[experiment.recipe]
    tint_prototype_icon(recipe_prototype, experiment_tint)
    recipe_prototype.results = {{type = "item", name = item.name, amount = 1}}
  end
end

for _, domain in pairs(domains) do
  data:extend({domain})
end
