cjxyBuildingRepairStage=simple_class(seasonStage)

local _buildHandle={
[xjClientBuildType.flcbXianYuLingMai]={
getStage=function()
local stage=xianjieModel:getLeyLineRepairStage()
local isFinish=xianjieModel:isLeyLineRepairFinish()
return isFinish and stage or math.max(stage-1,0)
end,
getScore=function()
return xianjieModel:getLeyLineRepairScore()
end,
getFlag=function()
return xianjieModel:getLeyLineRepairFlagEx()
end,
isFinish=function()
return xianjieModel:isLeyLineRepairFinish()
end,
getProgress=function()
return xianjieModel:getLeyLineRepairProgress()
end
}
}
local _callBuildFunc=function(stage,funcName)
local entityID=stage:getConfig("entityID")
local handle=_buildHandle[entityID]
if handle and handle[funcName]then
return handle[funcName]()
else
loggerUtil.logErrFMT("没有定义处理：{0},{1}",entityID,funcName)
end
end

function cjxyBuildingRepairStage:onRefresh(serverData,isInit)
self.free=serverData.free_reward_flag or 0

if self:getConfig("free_reward")==nil then
self.free=1
end
end

function cjxyBuildingRepairStage:onDelete()

end

function cjxyBuildingRepairStage:getReddot()
return self:getTargetReddot()
end

function cjxyBuildingRepairStage:isFinish()
return self:isRepairOver()
end

function cjxyBuildingRepairStage:isOver()
if self.free==0 then
return false
end
local flag=self:getRepairFlag()
local isFinish=self:isRepairOver()
local stage=self:getRepairStage()
return isFinish and flag>=stage
end

function cjxyBuildingRepairStage:getProgress()
return _callBuildFunc(self,"getProgress")
end

function cjxyBuildingRepairStage:getTargetReddot()
if not self:isOverBegin()or not self:checkOpen()then return false end

if self.free==0 then
return true
end

local stage=self:getRepairStage()
local flag=self:getRepairFlag()
if flag<stage then
return true
end

return false
end

function cjxyBuildingRepairStage:getRankReddot()
if not self:isOverBegin()or not self:checkOpen()then return false end
return self.free==0
end

function cjxyBuildingRepairStage:getRepairStage()
return _callBuildFunc(self,"getStage")
end

function cjxyBuildingRepairStage:getRepairScore()
return _callBuildFunc(self,"getScore")
end

function cjxyBuildingRepairStage:getRepairFlag()
return _callBuildFunc(self,"getFlag")
end

function cjxyBuildingRepairStage:isRepairOver()
return _callBuildFunc(self,"isFinish")
end

function cjxyBuildingRepairStage:onBegin()
if self:checkOpen()then
local entityID=self:getConfig("entityID")
xianjieController:send_35_91(entityID)
end
end

function cjxyBuildingRepairStage:on_39_2(param1,param2,param3)

if param1==1 then
self.free=1
elseif param1==5 then
self.buff_flag=param2
end
end

return cjxyBuildingRepairStage