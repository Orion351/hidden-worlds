-- Domains
---@alias Domain "Wood" | "Metal"

---@alias MaterialToPropertyInterface WoodMaterialToProperty
---@alias PropertyToMaterialInterface WoodPropertyToMaterial

-- Fungible Interface
---@alias FungibleInterface table<string, string[]>

-- Sidecars
---@class hw_sidecar
---@field tags string[]

---@class hw_sidecar_recipe: hw_sidecar
---@field recipe_type string

---@class hw_sidecar_item: hw_sidecar
---@field item_type string

---@class hw_sidecar_technology: hw_sidecar
---@field technology_type string

---@class hw_sidecar_group: hw_sidecar
---@field group_type string

---@class hw_sidecar_subgroup: hw_sidecar
---@field subgroup_type string

-- Question: What kinds of sidecars do we need?