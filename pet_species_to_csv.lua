-- package.path = package.path .. ';../../../?.lua'
require('workshop.base')

local json_file_name = arg[1]
assert_string(json_file_name)

local json_data = request('workshop.file.as_string')(json_file_name)
local json_to_lua = request('workshop.load_from.json.qd')

local pets = json_to_lua(json_data)
pets = pets.pets

local result = {}
local csv = request('workshop.save_to.csv')
local data, header = csv.table_to_record(pets[1])
result[#result + 1] = header
result[#result + 1] = data
for i = 2, #pets do
  data = csv.table_to_record(pets[i])
  result[#result + 1] = data
end

local file_text = csv.matrix_to_csv(result)
print(file_text)

--[[
local used_files = request('workshop.handy_mechs.get_loaded_module_files')()
local deploy_script = request('workshop.save_to.deploy_script')
deploy_script.save_script(used_files)
--]]
