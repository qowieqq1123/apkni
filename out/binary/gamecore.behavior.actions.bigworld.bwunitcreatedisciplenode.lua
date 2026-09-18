








bwUnitCreateDiscipleNode=simple_class(baseNode)

function bwUnitCreateDiscipleNode:update(interval)

local getDzType=self:getData('getDzType')

local dzModelParams
if getDzType==1 then

local dzGuid=self:getData('dzGuid')
if dzGuid then
dzModelParams=UIDiscipleModel:getDiscipleHeadModelInfo(dzGuid)
if not dzModelParams then
logErr("给定的弟子guid找不到弟子模型数据")
return nodeState.failure
end
else
logErr("未指定弟子guid")
return nodeState.failure
end
elseif getDzType==2 then

local dzSortType=self:getData('dzSortType')
local dzSortIndex=self:getData('dzSortIndex')or 1
local dzList
if dzSortType then
if dzSortType==1 then

dzList=UIDiscipleModel:getSortList(nil,function(a,b)
return a.jingjielv>b.jingjielv
end)
elseif dzSortType==2 then
dzList=UIDiscipleModel:getSortList(nil,function(a,b)
local aFight=UIDiscipleModel:getDiscipleFightValue(a.discipleguid)
local bFight=UIDiscipleModel:getDiscipleFightValue(b.discipleguid)
return aFight>bFight
end)
else
logErr("指定的是未知排序类型")
return nodeState.failure
end
else
logErr("未指定弟子排序方式【dzSortType】")
return nodeState.failure
end

if dzList and dzList[dzSortIndex]then
dzModelParams=UIDiscipleModel:getDiscipleHeadModelInfo(dzList[dzSortIndex].discipleguid)
else
logErr("未成功获得弟子")
return nodeState.failure
end
else
logErr("未指定获取弟子方式【getDzType】")
return nodeState.failure
end

local bodyCfg=cfgHelper.get1(cfg_dbbodyconfig_get,dzModelParams.body)
local height=bodyCfg.size and bodyCfg.size[2]or 0
local scale=bodyCfg.worldScales and bodyCfg.worldScales[1]or 0.4
local mSetting=CS.WorldEntitySetting.New(
mathHelper.convertArrayToVector(cfgHelper.get2(cfg_worldglobalconfig_get,"taskDiscipleLOD","value")),
height*scale,nil,
dzModelParams.body,dzModelParams.componets,
"Entity",scale,Vector3.zero)

if api_Available_SetWorldEntityUseSmall()then
mSetting:SetWorldEntityUseSmall(false)
end

local mHUDSetting=nil
local needHUD=self:getData('needHUD')
if needHUD then
local hudData=cfgHelper.get2(cfg_worldglobalconfig_get,"taskDiscipleHUD","value")
mHUDSetting=worldModel:getHUDSetting(hudData[1])
end

local unitKey=self:getData('unitKey')
local unitPos=self:getData('unitPos')
local luaData=self:getData('luaData')or{}

if unitKey and unitKey then
worldController:pushUnit(unitKey,unitPos,luaData,mSetting,mHUDSetting,nil,false)
else
logErr("缺少 unitKey 或者 unitPos")
return nodeState.failure
end

return nodeState.success
end