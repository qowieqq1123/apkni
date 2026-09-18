





tagNumberHandleBase={}

tagNumberHandleBase.handle_type=nil

tagNumberHandleBase.catch_list={}

function tagNumberHandleBase.new(class)
local _clone={}
if class then
for i,v in pairs(class)do
_clone[i]=v
end
_clone._base=class

end
if class.classname==nil then
logErr('没有传入classname')
end
local clone_mt={}
clone_mt.__index=tagNumberHandleBase
setmetatable(_clone,clone_mt)
return _clone
end

function tagNumberHandleBase.refresh()

end