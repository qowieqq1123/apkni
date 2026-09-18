









ComponentHelper=ComponentHelper or{}
ComponentHelper.type_table={}

function ComponentHelper.GetType(comp_name)
local result=ComponentHelper.type_table[comp_name]
if not result then

result=typeof(comp_name)
ComponentHelper.type_table[comp_name]=result
end
return result
end

function ComponentHelper.GetComponent(handle_object,comp_name)
local handle_type=ComponentHelper.GetType(comp_name)

return handle_object:GetComponent(handle_type)
end

function ComponentHelper.GetComponents(handle_object,comp_name)
local handle_type=ComponentHelper.GetType(comp_name)
return handle_object:GetComponents(handle_type)
end

function ComponentHelper.GetComponentInChildren(handle_object,comp_name)
local handle_type=ComponentHelper.GetType(comp_name)
return handle_object:GetComponentInChildren(handle_type)
end

function ComponentHelper.GetComponentsInChildren(handle_object,comp_name)
local handle_type=ComponentHelper.GetType(comp_name)
return handle_object:GetComponentsInChildren(handle_type)
end

function ComponentHelper.AddComponent(handle_object,comp_name)
local handle_type=ComponentHelper.GetType(comp_name)
return handle_object:AddComponent(handle_type)
end

