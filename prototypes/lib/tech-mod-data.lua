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
---@field name string

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


---@param domain string
---@param name string
---@param recipe string
---@param base_probability number
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

local function create_domain(domain)
  return {
    type = "mod-data",
    name = "hidden-worlds-timberworking-tech-domain",
    data_type = "hidden-worlds.tech-domain",
    data = {
      name = domain,
    }
  }
end

---@type data.ModData[]
local customTechDomainsModData = {
  create_domain("timberworking"),
  create_domain_tech("timberworking", "axles", "axle-5x1-recipe", 0.1),
  create_domain_tech("timberworking", "water-wheel", "water-wheel-recipe", 0.1),
}

data:extend(customTechDomainsModData)