-- Global Container
HW_Global.wood = {}

-- Item Constants
HW_Global.wood.wood_stack_size = 100

-- Item Annotations
---@alias WoodMaterial "hardwood" | "softwood" | "burntwood"
---@alias WoodProperty "coarse" | "basic" | "flexible" | "load-bearing"
---@alias WoodPart "wood-beam" | "wood-axle" | "wood-plank" | "wood-sheet" | "wood-gear"
---@alias WoodMaterialToProperty table<WoodMaterial, WoodProperty[]>
---@alias WoodPropertyToMaterial table<WoodProperty, WoodMaterial[]>

-- Fungible Interface "Enums"
---@type WoodProperty[]
HW_Global.wood.wood_properties = {"coarse", "basic", "flexible", "load-bearing"}
---@type WoodPart[]
HW_Global.wood.wood_parts = {"wood-beam", "wood-axle", "wood-plank", "wood-sheet", "wood-gear"}

-- Fungible Interface Context Tables
---@type WoodMaterialToProperty
HW_Global.wood.wood_material_to_properties = {
  hardwood = {"coarse", "basic", "load-bearing"},
  softwood = {"coarse", "basic", "flexible"},
  -- burntwood = {"coarse", "basic"}
}

---@type WoodPropertyToMaterial
HW_Global.wood.wood_properties_to_material = make_property_to_material_table(HW_Global.wood.wood_material_to_properties)