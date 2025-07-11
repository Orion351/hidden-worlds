--[[

The vanilla tech screen should only contain "domains" instead of individual techs.
This serves only to show the player the general progression the game will follow.
These domains are unlocked only when a player has completed all individual experiments.
All the tech's individual unlockable recipes are unlocked before the domain tech is unlocked/completed.

To unlock a recipe the player has to create prototypes. Also known as experiments.
These experiments consist of the following parts:
  - Creating prototypes each has a small chance of unlocking the tech.
  - The ingredients of the prototype are equal to the ingredients of the final product.
  - Complete several "side quest"-experiments to increase the odds of unlocking the tech for each prototype.
  - Completing all side quests will unlock the recipe when the next prototype is crafted

--]]

-- Data stage data types
---@class TechDomainModData : data.ModData
---@field data TechDomain

---@class TechDomain
---@field name string

---@class TechDomainTechModData : data.ModData
---@field data TechDomainTech

---@class TechDomainTech
---@field domain string
---@field name string
---@field recipe string
---@field base_probability number
---@field experiments string

---@class TechDomainTechExperimentModData : data.ModData
---@field data TechDomainTechExperiment

---@class TechDomainTechExperiment
---@field name string Name of this experiment
---@field techs string[] Techs this experiment improves
---@field recipe string Name of recipe associated with this experiment
---@field modifier TechExperimentModifier
---@field value number
---@field levels int[] Amount of crafts required for each level.

-- Runtime data types
---@class LuaTechDomainModData : LuaModData
---@field data LuaTechDomain

---@class LuaTechDomain
---@field name string

---@class LuaTechDomainTechModData : LuaModData
---@field data LuaTechDomainTech

---@class LuaTechDomainTech
---@field domain string
---@field name string
---@field recipe string
---@field base_probability number
---@field experiments string

---@class LuaTechDomainTechExperimentModData : LuaModData
---@field data TechDomainTechExperiment


---@param domain string Domain name
---@param name string Tech name
---@param recipe string Recipe name this tech unlocks
---@param base_probability number Base probability to unlock the tech after crafting each prototype
---@return TechDomainTechModData
local function create_domain_tech(domain, name, recipe, base_probability)
  return {
    type = "mod-data",
    name = "hidden-worlds-" .. name .. "-tech",
    data_type = "hidden-worlds.tech-domain-tech",
    data = {
      domain = domain,
      name = name,
      recipe = recipe,
      base_probability = base_probability
    }
  }
end

---@param domain string Domain name
---@return TechDomainModData
local function create_domain(domain)
  return {
    type = "mod-data",
    name = "hidden-worlds-".. domain .."-tech-domain",
    data_type = "hidden-worlds.tech-domain",
    data = {
      name = domain,
    }
  }
end

---@alias TechExperimentModifier "add"|"mult"

---@param data TechDomainTechExperiment
---@return data.ModData
local function create_experiment(data)
  return {
    type = "mod-data",
    name = "hidden-worlds-" .. data.name .. "-tech-experiment",
    data_type = "hidden-worlds.tech-experiment",
    data = {
      name = data.name,
      techs = data.techs,
      recipe = data.recipe,
      modifier = data.modifier,
      value = data.value,
      levels = data.levels
    }
  }
end

---@type data.ModData[]
local customTechDomainsModData = {
  create_domain("timberworking"),
  create_domain_tech("timberworking", "axles", "axle-5x1-recipe", 0.1),
  create_domain_tech("timberworking", "water-wheel", "water-wheel-recipe", 0.1),
  create_experiment({
    name = "wood-planing",
    techs = {"axles-recipe", "water-wheel-recipe"},
    recipe = "wood-planing",
    modifier = "add",
    --value = 1.01,
    value = .05,
    levels = {1, 2, 4, 8, 16, 32} -- Example, realistically it should start way
  }),
}

data:extend(customTechDomainsModData)