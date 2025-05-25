---@param t FungibleInterface
---@return FungibleInterface
function make_property_to_material_table(t)
  local property_to_material = {}
  for material, properties in pairs(t) do
    for _, property in pairs(properties) do
      if property_to_material[property] then
        if not property_to_material[property][material] then table.insert(property_to_material[property], material) end
      else
        property_to_material[property] = {material}
      end
    end
  end
  return property_to_material
end

---@param prefixes string[]
---@param suffixes string[]
---@return string[]
function cross_string_tables(prefixes, suffixes)
  local crossed = {}
  for _, prefix in pairs(prefixes) do
    for _, suffix in pairs(suffixes) do
      table.insert(crossed, prefix .. suffix)
    end
  end
  return crossed
end