






local _MODULENAME="worldSceneryModel"




def_table(_MODULENAME)
worldSceneryModel.name=_MODULENAME
worldSceneryModel.data={}

worldSceneryModel.CLICKFUNCTION={
BACKZONGMEN=0,
}

local _condition_handle={
[1]={
check=function(param)
local sysId=param[1]
local value=param[2]==1
local check=systemModel.isOpen(sysId)
return check==value
end,
have=function(param,value)
return param[1]==value
end
}
}


function worldSceneryModel:onAppStart()

end


function worldSceneryModel:onEnterState()

end


function worldSceneryModel:onLeaveState()

self.data={}
end


function worldSceneryModel:onServerDataInitFinish()

end





function worldSceneryModel:getSceneryKey(id)
return worldModel:convertUnitKey({worldModel.UNITTYPE.SCENERY,id})
end

function worldSceneryModel:getAnimalKey(group,index)
return worldModel:convertUnitKey({worldModel.UNITTYPE.ANIMAL,group,index})
end

function worldSceneryModel:checkShowCondition(conditions)
if conditions then
for i,v in ipairs(conditions)do
local type=v[1]
local param=v[2]
local handle=_condition_handle[type]
if handle and handle.check then
if not handle.check(param)then
return false
end
else
loggerUtil.logErrFMT("没有对应的大世界景观条件类型check：{0}",type)
return false
end
end
end
return true
end

function worldSceneryModel:checkHaveCondition(conditions,type,value)
if conditions then
for i,v in ipairs(conditions)do
local type=v[1]
local param=v[2]
local handle=_condition_handle[type]
if handle and handle.have then
if handle.have(param,value)then
return true
end
else
loggerUtil.logErrFMT("没有对应的大世界景观条件类型have：{0}",type)
return false
end
end
return false
end
return true
end