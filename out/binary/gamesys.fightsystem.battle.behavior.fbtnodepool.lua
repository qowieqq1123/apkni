fBTNodePool={}
local logErr=print
local node_Creator={}
local obj_pool={}
local is_init=false
local global_guid=0

function registry_pool_class(typo,className,baseClass)

fBTNodePool.registry(typo,def_class(className,baseClass))
end



function fBTNodePool.registry(typo,creator)
if node_Creator[typo]==nil then
node_Creator[typo]=creator
obj_pool[typo]={}
else
logErr(FMT.fmt("重复注册Action:{0}",typo))
end
end


function fBTNodePool.get(typo)
local objPoolArray=obj_pool[typo]
local len=#objPoolArray
if len>0 then
local obj=objPoolArray[len]
objPoolArray[len]=nil
return obj
end

local creator=node_Creator[typo]
if creator~=nil then
global_guid=global_guid+1
return creator(global_guid)
else
logErr(FMT.fmt("不存在类型{0}对应节点",typo))
end
end

function fBTNodePool.recycle(obj)

local typo=obj:getTypo()
local objArray=obj_pool[typo]
if objArray~=nil then
objArray[#objArray+1]=obj
else
logErr(FMT.fmt("不存在类型{0}对应Node 可以存入池",typo))
end
end

