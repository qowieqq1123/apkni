









local xjBehaviorJob_plotGoto={}


function xjBehaviorJob_plotGoto:onInit()
local cloudid=self.tree:getShareValue('cloudid')
local plotIdx=self.tree:getShareValue('plotIdx')
self.cloudid=cloudid
self.plotIdx=plotIdx
local cloudData=xianjieModel:getCloudData(cloudid)
local plotParams=cloudData:getCloudPlotParams(plotIdx)
local cloudPlotData=cloudData:getCloudPlotData(plotIdx)
local teamHandle=cloudPlotData:getTeamHandle()

local bTime=plotParams[1][1].param_1
local battleBegin=plotParams[3]
local dzList=plotParams[4]
local costTime=plotParams[5]
local state=cloudData:checkCloudPlotState(plotIdx)
if state==xjCloudPlotStateType.eGoto then
local wayTime1=teamHandle:getMoveWayTime(false)
self.isBack=false
self.beginTime=bTime
self.endTime=self.beginTime+wayTime1
else
local wayTime1=teamHandle:getMoveWayTime(false)
local wayTime2=teamHandle:getMoveWayTime(true)
self.isBack=true
local battleTime=cloudPlotData.battleTime
self.beginTime=bTime+wayTime1+battleTime
self.endTime=self.beginTime+wayTime2
end
self.battleBegin=battleBegin
self.dzList=dzList
local func=function()
self:onSpeedUp()
end
self.tree:setShareValue('onSpeedUp',func)
end

function xjBehaviorJob_plotGoto:onSpeedUp()
local cloudData=xianjieModel:getCloudData(self.cloudid)
local plotParams=cloudData:getCloudPlotParams(self.plotIdx)
local cloudPlotData=cloudData:getCloudPlotData(self.plotIdx)
local teamHandle=cloudPlotData:getTeamHandle()
local bTime=plotParams[1][1].param_1
if not self.isBack then
local wayTime1=teamHandle:getMoveWayTime(false)
self.beginTime=bTime
self.endTime=self.beginTime+wayTime1
else
local wayTime1=teamHandle:getMoveWayTime(false)
local wayTime2=teamHandle:getMoveWayTime(true)
local battleTime=cloudPlotData.battleTime
self.beginTime=bTime+wayTime1+battleTime
self.endTime=self.beginTime+wayTime2
end
if self.entKey then
xianjieController:invokeEntityFunc(self.entKey,'onSpeedUp')
end
end


function xjBehaviorJob_plotGoto:onStart()


local cloudPlotData=xianjieModel:getCloudPlotData(self.cloudid,self.plotIdx)
local teamHandle=cloudPlotData:getTeamHandle()
if teamHandle:checkLineInScene()then
local d={self.cloudid,self.plotIdx,self.isBack,self.beginTime}
self.entKey=xianjieController:addTeamEntity(XJ_ENTITY_TYPE.ePlotTeam,d,true)
self.tree:setShareValue('teamEntityKey',self.entKey)
return true
end
return false
end

function xjBehaviorJob_plotGoto:tick(interval)
if not self.isBack then
local isGotoOver=self.tree:getShareValue('isGotoOver')
if isGotoOver then
self.tree:setShareValue('isGotoOver',nil)
return true
end
local isReqData=self.tree:getShareValue('isReqData')
if not isReqData then
local time=gameUtilityModel.getServerShortTime2()
if time>=self.endTime then
if self.battleBegin==0 then

local temp={}
for i,disguid_str in ipairs(self.dzList)do
table.insert(temp,{fightPreSelectModel.teamEntityType.dizi,int64.new(disguid_str)})
end
local cloudData=xianjieModel:getCloudData(self.cloudid)
local plotParams=cloudData:getCloudPlotParams(self.plotIdx)
plotParams[3]=1
local march=xianjieModel:encodeCloudPlotParams(cloudData,self.plotIdx,plotParams)
local data={self.cloudid,self.plotIdx,march}
fightLaunchController:sendFight(eBattleLaunch.xianjiePlotMonster,temp,0,0,data)
self.tree:setShareValue('isReqData',true)
else
self.tree:setShareValue('isGotoOver',true)
end
end
end
else
local time=gameUtilityModel.getServerShortTime2()
if time>=self.endTime then
return true
end
end
return false
end


function xjBehaviorJob_plotGoto:onDispose()
if self.entKey then
xianjieController:removeEntity(self.entKey)
self.tree:setShareValue('teamEntityKey',nil)
self.entKey=nil
end
self.tree:setShareValue('onSpeedUp',nil)
end

return xjBehaviorJob_plotGoto