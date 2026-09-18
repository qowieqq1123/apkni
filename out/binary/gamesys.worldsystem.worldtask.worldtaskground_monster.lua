









worldTaskGround_Monster=simple_class(worldTaskGround)

function worldTaskGround_Monster:__init(data)
worldTaskGround.__init(self,data)
end

function worldTaskGround_Monster:start(serverTime)
worldTaskGround.start(self,serverTime)

if not self.corners then return end

local targetData=worldModel:separateUnitKey(self.target)
if tonumber(targetData[1])==worldModel.UNITTYPE.FAMILY then
self.waitFight=cfgHelper.get2(cfg_xiuzhenfamilybasicconfig_get,worldModel.world,'jinzhutime')
else
self.waitFight=cfgHelper.get1(cfg_worldmonsterconfig_get,1).resultwaittime
end
self.allTime=self.onceTime*2+self.waitFight
if not self.endTime or self.endTime<0 then
self.endTime=self.startTime+self.allTime
end
self.fast=math.min(serverTime,self.endTime)-self.startTime

local leastTime=self.endTime-serverTime
if leastTime<=self.onceTime then
local targetInfo=worldModel:separateUnitKey(self.target)
local unitType=tonumber(targetInfo[1])
local unitId=tonumber(targetInfo[2])
if unitType==worldModel.UNITTYPE.RESPOINT then
worldResPointFightModel:clearFightResult(unitId)
end
end


self:showAllDisciples()
self:startMove(self.fast)
end


function worldTaskGround_Monster:startMove(fast)
for i=1,self:getShowDiscipleCnt()do
if self.move[i]then
worldController:popMove(self.move[i].Key)
end
local move=self:createMoveData(i,fast)
self.move[i]=move
worldController:pushMove(move)
move:Goto(fast-move.Pass)
end
worldHUDModel:UpdateHUDByKey(self.target)
worldHUDModel:UpdateHUDByKey(worldTaskModel:convertMissionUnitKey(self.key,self:getFirstShowDisciple()))
end

function worldTaskGround_Monster:createMoveData(index,fast)
local disObj=self.objects[index]
local moveKey=worldMoveModel:convertMoveKey(self.key,self:getShowDisciple(index))
local move=CS.WorldLineTeam.New(moveKey,{},{disObj},0)

local targetInfo=worldModel:separateUnitKey(self.target)
local unitType=tonumber(targetInfo[1])

local partTime1=self.waitInterval*(index-1)
local partTime2=partTime1+self.waitInterval
local partTime3=partTime2+self.moveTime
local partTime4=partTime3+self.waitInterval
local partTime5=self.onceTime+self.waitFight
local partTimes={partTime1,partTime2,partTime3,partTime4,}

local ways={}
local forwardSign=self.LT_Time(fast,self.onceTime)and 1 or
(self.GE_Time(fast,partTime5)and-1 or 0)
if forwardSign~=0 then
local forward=forwardSign>0
self:handleForwardWays(ways,disObj,fast,forward,partTime5,partTimes)
else

disObj:ChangeModelColor(Color.New(1,1,1,0),0)
table.insert(ways,self:waitWay_EndPoint(true,partTime5))
end

local path=CS.WorldMovePath.New(ways,CS.WorldLoopType.Restart,1)
move:AddPath(path)
move.onComplete=function(key,pass)
self.fast=math.max(pass,self.fast)
if index==1 and self.LT_Time(pass,partTime4)and self.LT_Time(fast,partTime3)then
worldHUDModel:UpdateHUDByKey(worldTaskModel:convertMissionUnitKey(self.key,self:getFirstShowDisciple()))
end
local unitId=tonumber(targetInfo[2])
if index==1 and self.GE_Time(fast,self.onceTime)and self.LT_Time(fast,self.onceTime+self.waitFight)
and self.GE_Time(pass,self.onceTime+self.waitFight)then

worldHUDModel:UpdateHUDByKey(self.target)
worldHUDModel:UpdateHUDByKey(worldTaskModel:convertMissionUnitKey(self.key,self:getFirstShowDisciple()))


if unitType==worldModel.UNITTYPE.MONSTER then
worldMonsterModel:showTaskResult(unitId,true)
elseif unitType==worldModel.UNITTYPE.RESPOINT then
worldResPointFightModel:showFightResult(unitId)
elseif unitType==worldModel.UNITTYPE.FAMILY then
worldXiuZhenJiaZuModel:showFightResult(unitId)
end

elseif self.LT_Time(fast,partTime4)and self.GE_Time(pass,partTime4)
and self.LT_Time(pass,partTime5)then

if index==self:getShowDiscipleCnt()and
unitType==worldModel.UNITTYPE.FAMILY then
worldXiuZhenJiaZuModel:changeFamilyState(worldModel.world,unitId,familyState.jinzhuzhong)
worldXiuZhenJiaZuController:refreshFamilyLeftWin(unitId)
worldXiuZhenJiaZuController:refreshFamilyRightWin(unitId)

worldHUDModel:UpdateHUDByKey(self.target)
worldHUDModel:UpdateHUDByKey(worldTaskModel:convertMissionUnitKey(self.key,self:getFirstShowDisciple()))
elseif index==1 and(unitType==worldModel.UNITTYPE.MONSTER or
unitType==worldModel.UNITTYPE.RESPOINT)then
worldHUDModel:UpdateHUDByKey(self.target)
worldHUDModel:UpdateHUDByKey(worldTaskModel:convertMissionUnitKey(self.key,self:getFirstShowDisciple()))
end
end
if self.LT_Time(pass,self.allTime)then
self:onMoveComplete(index,pass)
end
end
return move
end

function worldTaskGround_Monster:onMoveComplete(index,fast)
if self.move[index]then
worldController:popMove(self.move[index].Key)
end
local discipleMove=self:createMoveData(index,fast)
self.move[index]=discipleMove
worldController:pushMove(discipleMove)
discipleMove:Goto(fast-discipleMove.Pass)


end

function worldTaskGround_Monster:isPassForward()
return self.GE_Time(self.fast,self.onceTime)
end

function worldTaskGround_Monster:isPassWait()
return self.GE_Time(self.fast,self.onceTime+self.waitFight)
end

function worldTaskGround_Monster:isWaitingBack()
return self.corners and self:isPassForward()and not self:isPassWait()or false
end

function worldTaskGround_Monster:isFightTime()
return self.GE_Time(self.fast,self.moveTime+2*self.waitInterval)
and self.LT_Time(self.fast,self.onceTime+self.waitFight)
end

function worldTaskGround_Monster:getWaitedTime()
return self.fast-self.onceTime
end

function worldTaskGround_Monster:isLeaderReach()
return self:isFightTime()
end

function worldTaskGround_Monster:goBack()
if not self:isPassForward()or self:isPassWait()then
return
end
local nowTime=timeHelper.getServerShortTime()
self.fast=self.waitFight+self.onceTime
local deltaTime=self.fast-(nowTime-self.startTime)
self.startTime=self.startTime-deltaTime
self.endTime=self.startTime+self.allTime
for i,v in pairs(self.move)do
worldController:popMove(v.Key)
end
self:startMove(self.fast)
end