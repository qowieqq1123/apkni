









local xjBehaviorJob_gotoSearch={}


function xjBehaviorJob_gotoSearch:onInit()
self.cloudid=self.tree:getShareValue('cloudid')
local cloudData=xianjieModel:getCloudData(self.cloudid)
local teamHandle=cloudData:getTeamHandle()

local typo=cloudData:getCurType()
if typo==xjCloudSearchType.eBegin then

self.isBack=false
else

self.isBack=true
end
local wayTime=teamHandle:getMoveWayTime(self.isBack)

if self.isBack then
self.endTime=teamHandle:getBackBeginTime()+wayTime
else
self.endTime=cloudData.beginsec+wayTime
end


local func=function()
self:onSpeedUp()
end
self.tree:setShareValue('onSpeedUp',func)
end

function xjBehaviorJob_gotoSearch:onSpeedUp()
local cloudData=xianjieModel:getCloudData(self.cloudid)
local teamHandle=cloudData:getTeamHandle()
local wayTime=teamHandle:getMoveWayTime(self.isBack)
if self.isBack then
self.endTime=teamHandle:getBackBeginTime()+wayTime
else
self.endTime=cloudData.beginsec+wayTime
end
if self.entKey then
xianjieController:invokeEntityFunc(self.entKey,'onSpeedUp')
end
end


function xjBehaviorJob_gotoSearch:onStart()


if xianjieController:checkInPlotScene()then
self.entKey=xianjieController:addTeamEntity(XJ_ENTITY_TYPE.eSearchTeam,{self.cloudid,self.isBack},true)
self.tree:setShareValue('teamEntityKey',self.entKey)
return true
end
return false
end

function xjBehaviorJob_gotoSearch:tick(interval)
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
local cloudData=xianjieModel:getCloudData(self.cloudid)
xianjieController:reqSearchCloudIdx(cloudData.cloudid,cloudData.idx+1)
self.tree:setShareValue('isReqData',true)
end
end
else
local time=gameUtilityModel.getServerShortTime2()
if time>=self.endTime then

local cloudData=xianjieModel:getCloudData(self.cloudid)
local teamHandleID=cloudData.teamHandleID
notifySystem:postNotify(notifyConfig.onXianJieWaiPaiChange,CHANGE_TYPE.eDelete,teamHandleID)
return true
end
end
return false
end


function xjBehaviorJob_gotoSearch:onDispose()
if self.entKey then
xianjieController:removeEntity(self.entKey)
self.tree:setShareValue('teamEntityKey',nil)
self.entKey=nil
end
self.tree:setShareValue('onSpeedUp',nil)
end

return xjBehaviorJob_gotoSearch