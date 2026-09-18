







newbieFindHelper={}

local _funcType=
{
eFindBuildHUDIcon=1,
eFindXiufuBuildHUDIcon=2,
}


local _funcTable=
{

[_funcType.eFindBuildHUDIcon]=function(...)
return newbieFindHelper.findBuildCMP(...)
end,
[_funcType.eFindXiufuBuildHUDIcon]=function(...)
return newbieFindHelper.findXiufuBuildCMP(...)
end,
}


function newbieFindHelper.findCMP(actionid)
local actionConfig=newbieConfig.getNewbieAction(actionid)
if actionConfig.mComponentID then
return actionConfig.mComponentID
elseif actionConfig.luafunc then
local luafunc=actionConfig.luafunc
local funcType=luafunc[1]
local args=luafunc[2]
if _funcTable[funcType]then
return _funcTable[funcType](args and unpack(args)or nil)
else
loggerUtil.logErrFMT('指引 没有找到actionid：{0}中配置的方法名：{1}',actionid,cnd)
end
end
end



function newbieFindHelper.findBuildCMP(entityId)
local sfId=mapIdType.zhufeng
local buildInfoList=zongmenModel:getBuildingDataByBdId(sfId,entityId)or{}
local build=buildInfoList[1]
if build then
local guid=build.entityId
local cmpId=FMT.fmt('buildingStatusHud.build_{0}_{1}',entityId,guid)
newbieControl.log(FMT.fmt('使用方法找到了UI控件：{0}',cmpId))
return cmpId
end
end


function newbieFindHelper.findXiufuBuildCMP(entityId)
local build=isometricMapSystem:getAnyRepairData(entityId)
if build then
local guid=build.guid
local cmpId=FMT.fmt('buildingStatusHud.build_{0}_{1}',entityId,guid)
newbieControl.log(FMT.fmt('使用方法找到了UI控件：{0}',cmpId))
return cmpId
end
end
