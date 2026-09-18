







EngineTools=EngineTools or{}



function EngineTools.InstantiateBase(prefab,parent)
local instance=GameObject.Instantiate(prefab,parent,false)
return instance
end


function EngineTools.Instantiate(prefab,parent,worldPositionStays)
local instance=GameObject.Instantiate(prefab,parent,worldPositionStays)
return instance
end


function EngineTools.InstantiateAndAddChild(prefab,parent,keep_layer)

local instance=GameObject.Instantiate(prefab,parent,false)
local child_transform=instance.transform
child_transform.localPosition=Vector3.zero
child_transform.localRotation=Quaternion.identity
child_transform.localScale=Vector3.one
if not keep_layer then
instance.gameObject.layer=parent.gameObject.layer
end
return instance
end

function EngineTools.AddChild(parent,child,keep_layer)
local child_transform=child.transform
child_transform.localPosition=Vector3.zero
child_transform.localRotation=Quaternion.identity
child_transform.localScale=Vector3.one
child_transform:SetParent(parent.transform,false)
if not keep_layer then
child.layer=parent.layer
end
end

function EngineTools.AddChildUI(parent,child)
child.transform:SetParent(parent.transform,false)
end

function EngineTools.FindGameObject(parent,childName)
local transform=parent.transform:Find(childName)
return transform and transform.gameObject or nil
end

function EngineTools.PrintAssetbundle(asset_bundle)

local name_table=asset_bundle:GetAllAssetNames()
for key,value in pairs(name_table)do

end

end

function EngineTools.SplitString(szFullString,szSeparator)
local szSeparator,fields=szSeparator or"\t",{}
local pattern=string.format("([^%s]+)",szSeparator)
string.gsub(szFullString,pattern,function(c)fields[#fields+1]=c end)
return fields
end

function EngineTools.OrganizeHttpParam(handle_param)
if handle_param==nil then
return""
end

local param_table={}
for key,value in pairs(handle_param)do
table.insert(param_table,string.format("%s=%s",StringUtility.UrlEncode(key),StringUtility.UrlEncode(value)))
end

if#param_table==0 then
return""
end

return table.concat(param_table,"&")
end

function EngineTools.CombinePath(path1,path2)
path1=string.gsub(path1,"\\","/")
path2=string.gsub(path2,"\\","/")

if string.sub(path1,-1)~="/"then
path1=path1.."/"
end

if string.sub(path2,1,1)=="/"then
path2=string.sub(path2,2)
end

return path1..path2
end

function EngineTools.GetShaderByName(shader_name)
if not EngineTools.IsSplitAlpha()then
shader_name=shader_name.."NoAlpha"
end
return EngineExport.GetShaderByName(shader_name)
end
