









local xjBehaviorJob_respointGoto={}


function xjBehaviorJob_respointGoto:onInit()
self.rpGuid=self.tree:getShareValue("guid")
self.rpMarch=xianjieModel:getResPointMarch(self.rpGuid)
local teamHandle=self.rpMarch:getTeamHandle()
local state,time=teamHandle:getTeamState()
self.isBack=state==xjMarchTeamStateType.eBack or state==xjMarchTeamStateType.eNone
self.beginTime=time[1]
self.endTime=time[2]

self.dzList=self.rpMarch:getMarchData("dDiscipleList")
self.dDataType=self.rpMarch:getMarchData("dDataType")

end


function xjBehaviorJob_respointGoto:onStart()


local teamHandle=self.rpMarch:getTeamHandle()
if teamHandle:checkLineInScene()then
local d={self.rpGuid,self.isBack,self.beginTime}
self.entKey=xianjieController:addTeamEntity(XJ_ENTITY_TYPE.eRPMarchTeam,d,true)
self.tree:setShareValue('teamEntityKey',self.entKey)
return true
end
return false
end

function xjBehaviorJob_respointGoto:tick(interval)
if not self.isBack and self.dDataType==xjResPointMarchTeamType.eNormal then
local isGotoOver=self.tree:getShareValue('isGotoOver')
if isGotoOver then
self.tree:setShareValue('isGotoOver',nil)
return true
end
local isReqData=self.tree:getShareValue('isReqData')
if not isReqData then
local time=gameUtilityModel.getServerShortTime2()
if time>=self.endTime then
local handleFlag=self.rpMarch:getMarchData("dHandleFlag")
if handleFlag==0 then

local temp={}
for i,disguid_str in ipairs(self.dzList)do
table.insert(temp,{fightPreSelectModel.teamEntityType.dizi,int64.new(disguid_str)})
end

self.rpMarch:setMarchData("dHandleFlag",1)

local rpData=xianjieModel:getResPointData(self.rpGuid)
if rpData then
local targetPos=self.rpMarch:getMarchData("dTargetInfo")
local mapId=self.rpMarch:getMarchData("dFightMap")
local sceneidx=targetPos[1]>0 and 1 or targetPos[1]
if targetPos[1]==100 then
sceneidx=100
end
local x=targetPos[2]
local z=targetPos[3]
local data={self.rpGuid,self.rpMarch.marchJson,sceneidx,x,z}

fightLaunchController:sendFight(eBattleLaunch.xianjieResPoint,temp,mapId or 0,0,data)
self.tree:setShareValue('isReqData',true)

self.reqDataTime=gameUtilityModel.getServerShortTime()
else
self.rpMarch:setBehaviorData('isReqData',true)
self.rpMarch:setBehaviorData('isGotoOver',true)

xianjieController:reqXianJieResPointMarchSave(self.rpGuid,self.rpMarch.marchJson)
end
else
self.tree:setShareValue('isGotoOver',true)
end
end
elseif self.reqDataTime then
if gameUtilityModel.getServerShortTime()-self.reqDataTime>10 then
loggerUtil.logErrFMT("请求资源点行军战斗已超过10秒，但仍未接收到")
self.reqDataTime=nil
self.tree:setShareValue('isGotoOver',true)
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


function xjBehaviorJob_respointGoto:onDispose()
if self.entKey then



self.entKey=nil
end
end

return xjBehaviorJob_respointGoto