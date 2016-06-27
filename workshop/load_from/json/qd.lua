--[[
  Just substitutes syntax in string with assumed JSON code to Lua syntax.
  This is not safe, not flexible and not universal method. But simple and
  very fast.
--]]

local table_from_lua_string = request('^.lua_table')

local json_as_table =
  function(json_str)
    if not is_string(json_str) then
      return
    end
    local result = json_str
    result = result:gsub('%[', '{')
    result = result:gsub('%]', '}')
    result = result:gsub('"([^"]+)"%s*:', '["%1"]=')
    result = table_from_lua_string(result)
    return result
  end

return json_as_table
