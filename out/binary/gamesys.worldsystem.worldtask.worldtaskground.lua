









worldTaskGround=simple_class(worldTaskBase)

function worldTaskGround:__init(data)
worldTaskBase.__init(self,data)
end

function worldTaskGround:start(serverTime)
worldTaskBase.start(self,serverTime)

self:calculatePath()

if not self.corners then return end

local length=0
for i=1,self.corners.Length-1 do
length=length+Vector3.Distance(self.corners[i-1],self.corners[i])
end
self.moveTime=length/self.speed
self.onceTime=self.moveTime+(self:getShowDiscipleCnt()+1)*self.waitInterval



end

function worldTaskGround:calculatePath()
self.corners=worldController:calculateNavPath(
worldController:getMainCityPoint(),self.destination)
end


function worldTaskGround:waitWay_StartPoint(forward,time)
local standIndex=forward and 0 or self.corners.Length-1
return CS.WorldWaitWay.New(self.corners[standIndex],time,Vector3Int(0,0,0))
end


function worldTaskGround:waitWay_EndPoint(forward,time)
local standIndex=forward and self.corners.Length-1 or 0
return CS.WorldWaitWay.New(self.corners[standIndex],time,Vector3Int(0,0,0))
end


function worldTaskGround:moveWay(forward)
local corners=self.corners:Clone()
if not forward then
System.Array.Reverse(corners)
end
return CS.WorldNavWay.New(corners,self.speed,Vector3Int(0,self.runAnimation,0))
end

function worldTaskGround:handleForwardWays(ways,disObj,fast,forward,backTime,partTimes)
local addTime=forward and 0 or backTime
if self.LT_Time(fast,partTimes[1]+addTime)then
disObj:ChangeModelColor(Color.clear,0)
disObj:ShowShadow(false)
disObj:StopModelEffect(self.runEffect)
table.insert(ways,self:waitWay_StartPoint(forward,partTimes[1]+addTime))
elseif self.LT_Time(fast,partTimes[2]+addTime)then
local temp=fast-(partTimes[2]+addTime)
if forward then
disObj:PlayModelEffect(self.fadeEffect,Vector3.zero,Vector3.one)
end
if(partTimes[2]+addTime)>fast then
disObj:ChangeModelColor(Color.New(1,1,1,temp/self.waitInterval),0)
disObj:ChangeModelColor(Color.white,partTimes[2]+addTime-fast)
else
disObj:ChangeModelColor(Color.white,0)
end
disObj:StopModelEffect(self.runEffect)
disObj:ShowShadow(false)
table.insert(ways,self:waitWay_StartPoint(forward,partTimes[2]+addTime))
elseif self.LT_Time(fast,partTimes[3]+addTime)then
disObj:ChangeModelColor(Color.white,0)
disObj:PlayModelEffect(self.runEffect,Vector3.zero,Vector3.one)
disObj:ShowShadow(true)
table.insert(ways,self:waitWay_StartPoint(forward,partTimes[2]+addTime))
table.insert(ways,self:moveWay(forward))
elseif self.LT_Time(fast,partTimes[4]+addTime)then
local temp=fast-partTimes[3]+addTime
if not forward then
disObj:PlayModelEffect(self.fadeEffect,Vector3.zero,Vector3.one)
end
if(partTimes[4]+addTime)>fast then
disObj:ChangeModelColor(Color.New(1,1,1,1-temp/self.waitInterval),0)
disObj:ChangeModelColor(Color.New(1,1,1,0),partTimes[4]+addTime-fast)
else
disObj:ChangeModelColor(Color.clear,0)
end
disObj:StopModelEffect(self.runEffect)
disObj:ShowShadow(false)
table.insert(ways,self:waitWay_EndPoint(forward,partTimes[4]+addTime))
else
disObj:StopModelEffect(self.runEffect)
disObj:ShowShadow(false)
disObj:ChangeModelColor(Color.clear,0)
table.insert(ways,self:waitWay_EndPoint(forward,self.onceTime+addTime))
end
end

function worldTaskGround:isLeaderReach()
return self.GE_Time(self.fast,self.waitInterval+self.moveTime)
end