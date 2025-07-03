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

---@param recipe data.RecipePrototype
local function tint_prototype_icon(recipe)
  local tint = {r = 74 / 255, g = 109 / 255, b = 229 / 255, a = 255 / 255} -- Blueprint blue
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

---@param tech TechDomainTech 
local function create_prototype_recipe_and_item(tech)
  local base_recipe = data.raw.recipe[tech.recipe]
  base_recipe.enabled = false

  local prototype_recipe = table.deepcopy(base_recipe)
  prototype_recipe.name = prototype_recipe.name .. "-prototype"
  prototype_recipe.auto_recycle = false
  prototype_recipe.enabled = true -- TODO remove
  set_prototype_localisation(prototype_recipe)
  tint_prototype_icon(prototype_recipe)

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
  tint_prototype_icon(prototype_item)
  prototype_item.spoil_ticks = 1
  prototype_item.spoil_result = nil
  prototype_item.burnt_result = nil
  prototype_item.spoil_to_trigger_result = {
    trigger = {
      type = "direct",
      action_delivery =
      {
        type = "instant",
        source_effects =
        {
            {
                type = "script",
                effect_id = "hwt_" .. base_recipe.name
            },
        }
      }
    },
    items_per_trigger = 1
  }

  table.insert(prototype_results, {
    type = "item",
    name = prototype_item_name,
    amount = 1
  })

  ---@diagnostic disable-next-line: assign-type-mismatch
  data:extend({prototype_item})
  prototype_recipe.results = prototype_results


  log("prototype recipe prototype: " .. serpent.dump(prototype_recipe))
  ---@diagnostic disable-next-line: assign-type-mismatch
  data:extend({prototype_recipe})
  -- end
end


local domains = {}

-- Creating all the domains
for _, mod_data in pairs(data.raw["mod-data"]) do
  if mod_data.data_type == "hidden-worlds.tech-domain" then
    ---@cast mod_data TechDomainModData
    domains[mod_data.data.name] = create_domain_tech(mod_data.data)
  end
end

-- Adding all unlocks to the domain tech and creating the prototype items and recipes
for _, mod_data in pairs(data.raw["mod-data"]) do
  if mod_data.data_type == "hidden-worlds.tech-domain-tech" then
    ---@cast mod_data TechDomainTechModData
    add_domain_tech(domains, mod_data.data)
    create_prototype_recipe_and_item(mod_data.data)
  end
end

for _, domain in pairs(domains) do
  data:extend({domain})
end
