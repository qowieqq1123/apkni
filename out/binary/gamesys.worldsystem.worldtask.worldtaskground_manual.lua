









worldTaskGround_Manual=simple_class(worldTaskGround)

function worldTaskGround_Manual:__init(data)
worldTaskGround.__init(self,data)
end

function worldTaskGround_Manual:start(serverTime)

worldTaskGround.start(self,serverTime)

if not self.corners then return end

local isForward=self.endTime<=0
self.fast=isForward and self.onceTime or

Mathf.Clamp(self.onceTime-(self.endTime-serverTime),0,self.onceTime)


self:showAllDisciples()
self:startMove(isForward,self.fast)
end


function worldTaskGround_Manual:startMove(isForward,fast)
for i=1,self:getShowDiscipleCnt()do
if self.move[i]then
worldController:popMove(self.move[i].Key)
end
local move=self:createMoveData(i,isForward,fast)
self.move[i]=move
worldController:pushMove(move)
move:Goto(fast-move.Pass)
end
worldHUDModel:UpdateHUDByKey(self.target)
worldHUDModel:UpdateHUDByKey(worldTaskModel:convertMissionUnitKey(self.key,self:getFirstShowDisciple()))
end


function worldTaskGround_Manual:createMoveData(index,forward,fast)
local disObj=self.objects[index]
local moveKey=worldMoveModel:convertMoveKey(self.key,self:getShowDisciple(index))
local move=CS.WorldLineTeam.New(moveKey,{},{disObj},0)

local partTime1=self.waitInterval*(index-1)
local partTime2=partTime1+self.waitInterval
local partTime3=partTime2+self.moveTime
local partTime4=partTime3+self.waitInterval
local partTimes={partTime1,partTime2,partTime3,partTime4}
local ways={}
self:handleForwardWays(ways,disObj,fast,forward,0,partTimes)

local path=CS.WorldMovePath.New(ways,CS.WorldLoopType.Restart,1)
move:AddPath(path)
move.onComplete=function(key,pass)
self.fast=pass
if self.LT_Time(pass,partTime4)then
if index==1 and self.LT_Time(fast,partTime3)then
worldHUDModel:UpdateHUDByKey(self.objects[1].Key)
end
self:onMoveComplete(index,pass)
else
move:SetRunning(false)
if index==self:getShowDiscipleCnt()then
worldHUDModel:UpdateHUDByKey(self.target)
elseif index==1 then
worldHUDModel:UpdateHUDByKey(worldTaskModel:convertMissionUnitKey(self.key,self:getFirstShowDisciple()))
end
end
end
return move
end

function worldTaskGround_Manual:onMoveComplete(index,fast)
if self.move[index]then
worldController:popMove(self.move[index].Key)
end
local discipleMove=self:createMoveData(index,self.endTime<=0,fast)
self.move[index]=discipleMove
worldController:pushMove(discipleMove)
discipleMove:Goto(fast-discipleMove.Pass)
end

function worldTaskGround_Manual:goBack()
if not self.corners then
return print(FMT.fmt("任务{0} 不存在路径",self.key))
end

self.endTime=self.onceTime+timeHelper.getServerShortTime()
self.fast=0
if worldController:isInWorld()then
self:startMove(false,0)
end
end

function worldTaskGround_Manual:isWaitingBack()
return self.endTime<=0 and self.GE_Time(self.fast,self.onceTime)
end