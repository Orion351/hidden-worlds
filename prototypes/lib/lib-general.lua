---@param t1 table
---@param t2 table
---@return table
function table.merge_overwrite(t1, t2)
  -- t1 keys overwrite t2 keys
  local new_table = table.deepcopy(t2)
  for k1, v1 in pairs(t1) do
    new_table[k1] = v1
  end
  return new_table
end