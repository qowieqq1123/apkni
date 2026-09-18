









worldTaskSky=simple_class(worldTaskBase)
worldTaskSky.jumpTime=0.4
worldTaskSky.flyAnimtion=0
worldTaskSky.jumpAnimation=2002
worldTaskSky.lineSegment=10
worldTaskSky.lineMiddle=15
function worldTaskSky:__init(data)
worldTaskBase.__init(self,data)
end

function worldTaskSky:start(serverTime)
worldTaskBase.start(self,serverTime)

self:calculatePath()

self.flyHeight=cfgHelper.get2(cfg_worldconfig_get,worldModel.world,"maxAltitude")
self.horizontalLine=cfgHelper.get2(cfg_worldconfig_get,worldModel.world,"horizontalLine")
self.cloudHigher=cfgHelper.get2(cfg_worldconfig_get,worldModel.world,"cloudHigher")
self.cloudMount=cfgHelper.get3(cfg_worldglobalconfig_get,"taskDiscipleCloud","value",1)
self.cloudCfg=cfgHelper.get1(cfg_dbbodyconfig_get,self.cloudMount)


if not self.corners then return end

self.horizontalVector=self.corners[2]-self.corners[1]
self.horizontalVector.y=0
self.perpendicularVector=Vector3.Normalize(Vector3.Cross(self.horizontalVector,Vector3.up))
self.horizontalVector=Vector3.Normalize(self.horizontalVector)

local lX=self.corners[1].x-self.corners[#self.corners].x
local lZ=self.corners[1].z-self.corners[#self.corners].z
local length=math.sqrt(lX*lX+lZ*lZ)
self.moveTime=length/self.speed

self.onceTime=self.moveTime+(math.floor(self:getShowDiscipleCnt()/2)+1)*self.jumpTime+self.fadeDuration









end

function worldTaskSky:calculatePath()
local sPos=worldPositionConfig:getPosition_CurrentWorld(cfgHelper.get2(cfg_worldconfig_get,worldModel.world,"mainCityPos"))
local ePos=worldPositionConfig:getPosition_CurrentWorld({self.destination.x,self.destination.y})

if not sPos or not ePos then return end

self.corners={sPos,ePos}
end

function worldTaskSky:getForwardInfo(forward)
local idx1=forward and 1 or#self.corners
local idx2=forward and#self.corners or 1
return idx1,idx2,self.corners[idx2].x<self.corners[idx1].x
end

function worldTaskSky:getOffset(index,flipX)
local discipleCnt=self:getShowDiscipleCnt()
local temp=self.sky_offset[discipleCnt][index]:Clone()
temp.x=temp.x*(flipX and-1 or 1)
local offset=self.perpendicularVector*temp.z-self.horizontalVector*temp.x
return offset
end


function worldTaskSky:waitWay_StartPoint(index,forward,time)
local standIndex,endIndex,flipX=self:getForwardInfo(forward)
return CS.WorldWaitWay.New(self.corners[standIndex]+self:getOffset(index,flipX),
time,Vector3Int(0,0,0))
end


function worldTaskSky:waitWay_EndPoint(index,forward,time)
local standIndex,endIndex,flipX=self:getForwardInfo(forward)
return CS.WorldWaitWay.New(self.corners[endIndex]+self:getOffset(index,flipX),
time,Vector3Int(0,0,0))
end


function worldTaskSky:moveWay(index,forward)
local standIndex,endIndex,flipX=self:getForwardInfo(forward)
local offset=self:getOffset(index,flipX)
local corners={
self.corners[standIndex]+Vector3.up*self.flyHeight+offset,
self.corners[endIndex]+offset
}
return CS.WorldFlyWay.New(corners,self.speed,self.flyHeight,self.horizontalLine,self.cloudHigher,Vector3Int(0,self.flyAnimtion,0))
end

function worldTaskSky:jumpStartWay(index,forward)
local standIndex,endIndex,flipX=self:getForwardInfo(forward)
local offset=self:getOffset(index,flipX)
return CS.WorldLineWay.New(self.corners[standIndex]+offset,
self.corners[standIndex]+Vector3.up*self.flyHeight+offset,
flipX,self.flyHeight/self.jumpTime,Vector3Int(0,self.jumpAnimation,0))
end

function worldTaskSky:waitJumpPoint(index,forward,time)
local standIndex,endIndex,flipX=self:getForwardInfo(forward)
local offset=self:getOffset(index,flipX)
return CS.WorldWaitWay.New(self.corners[standIndex]+Vector3.up*self.flyHeight+offset,
time,Vector3Int(0,self.flyAnimtion,0))
end

function worldTaskSky:mountCloud(disObj)
disObj:ChangeModelMount(self.cloudMount,{},"root",
self.cloudCfg.scales and self.cloudCfg.scales[2]or 1,Vector3.zero)
end

function worldTaskSky:unmount(disObj)
disObj:ClearModelMount()
end

function worldTaskSky:handleForwardWays(ways,index,disObj,fast,forward,backTime,partTimes)
local addTime=forward and 0 or backTime
if self.LT_Time(fast,partTimes[1]+addTime)then
disObj:ChangeModelColor(Color.clear,0)
disObj:ShowShadow(false)
self:unmount(disObj)
table.insert(ways,self:waitWay_StartPoint(index,forward,partTimes[1]+addTime))
elseif self.LT_Time(fast,partTimes[2]+addTime)then
local temp=fast-(partTimes[1]+addTime)
disObj:PlayModelEffect(self.fadeEffect,Vector3.zero,Vector3.one)
disObj:ShowShadow(false)
if fast<(partTimes[1]+addTime)then
disObj:ChangeModelColor(Color.New(1,1,1,temp/self.fadeDuration),0)
disObj:ChangeModelColor(Color.white,self.fadeDuration-fast)
else
disObj:ChangeModelColor(Color.white,0)
end
self:mountCloud(disObj)
table.insert(ways,self:waitWay_StartPoint(index,forward,partTimes[1]+addTime))
table.insert(ways,self:jumpStartWay(index,forward))
elseif self.LT_Time(fast,partTimes[3]+addTime)then
disObj:ChangeModelColor(Color.white,0)
disObj:ShowShadow(false)
self:mountCloud(disObj)
table.insert(ways,self:waitJumpPoint(index,forward,partTimes[2]+addTime))
table.insert(ways,self:moveWay(index,forward))
elseif self.LT_Time(fast,partTimes[4]+addTime)then
local temp=fast-partTimes[3]+addTime
disObj:PlayModelEffect(self.fadeEffect,Vector3.zero,Vector3.one)
disObj:ShowShadow(false)
if fast<(partTimes[4]+addTime)then
disObj:ChangeModelColor(Color.New(1,1,1,1-temp/self.fadeDuration),0)
disObj:ChangeModelColor(Color.New(1,1,1,0),partTimes[4]+addTime-fast)
else
disObj:ChangeModelColor(Color.clear,0)
end
self:unmount(disObj)
table.insert(ways,self:waitWay_EndPoint(index,forward,partTimes[4]+addTime))
else
disObj:ChangeModelColor(Color.clear,0)
disObj:ShowShadow(false)
self:unmount(disObj)
table.insert(ways,self:waitWay_EndPoint(index,forward,self.onceTime+addTime))
end
end

function worldTaskSky:isLeaderReach()
return self.GE_Time(self.fast,self.jumpTime+self.moveTime)
end