









worldTaskSky_Experience=simple_class(worldTaskSky)

function worldTaskSky_Experience:__init(data)
worldTaskSky.__init(self,data)
local keys=worldModel:separateUnitKey(self.target)
self.groupCfg=cfgHelper.get1(cfg_experiencegroupconfig_get,tonumber(keys[2]))
self.inlineMove=nil
self.inlineObject=nil

self.wanderPointList=self.groupCfg.wanderPoints
local job=UIDiscipleModel:getDiscipleJob(self:getFirstShowDisciple())
self.aiCfg=cfgHelper.get2(cfg_disciplevocationbuildspeakconfig_get,job,"experienceWeight")
self.aiWeightTotal=0
for i,v in ipairs(self.aiCfg)do
self.aiWeightTotal=self.aiWeightTotal+v[3]
end
self.wanderKind=math.random(0,1)
end

function worldTaskSky_Experience:start(serverTime)
worldTaskSky.start(self,serverTime)

if not self.corners then return end

self.wanderPaths=self:getWanderPath()
local isForward=self.endTime<=0
self.fast=isForward and self.onceTime or

Mathf.Clamp(self.onceTime-(self.endTime-serverTime),0,self.onceTime)

if isForward then
self:createInlineObject()
if self.fast>=self.onceTime then

self.wanderPoint=math.random(1,#self.wanderPointList)
self:startWanderMove()
return
end
end

self.wanderPoint=1
self:startNormalMove(self.fast)
end

function worldTaskSky_Experience:getWanderPath()
local wanderPath={}
local wanderPoints=self.groupCfg.wanderPoints
local wanderCnt=#wanderPoints
for i=1,wanderCnt do
local startIdx=i
local endIdx=startIdx+1
endIdx=endIdx>wanderCnt and endIdx-wanderCnt or endIdx
local startPoint=mathHelper.convertArrayToVector(wanderPoints[startIdx])
local endPoint=mathHelper.convertArrayToVector(wanderPoints[endIdx])
local path=worldController:calculateNavPath(startPoint,endPoint)
if not path then

break
end
table.insert(wanderPath,path)
end
return wanderPath
end

function worldTaskSky_Experience:startWanderMove()
local firstDisciple=self:getFirstShowDisciple()
worldTaskController:showTaskDisciple(self.key,firstDisciple,true)
local unitKey=worldTaskModel:convertMissionUnitKey(self.key,firstDisciple)
local obj=worldController:getUnit(unitKey)
self.objects={obj}
local move=self:createWanderMove()
self.move={move}
worldController:pushMove(move)
end

function worldTaskSky_Experience:startNormalMove(fast)
for i,v in ipairs(self:getShowDisciples())do
worldTaskController:showTaskDisciple(self.key,v,i==1)
local unitKey=worldTaskModel:convertMissionUnitKey(self.key,v)
local obj=worldController:getUnit(unitKey)
self.objects[i]=obj
local move=self:createNormalMove(i,self.endTime<=0,fast)
self.move[i]=move
worldController:pushMove(move)
move:Goto(fast-move.Pass)
end
worldHUDModel:UpdateHUDByKey(self.objects[1].Key)
end



















function worldTaskSky_Experience:createNormalMove(index,forward,fast)
local disObj=self.objects[index]
local moveKey=worldMoveModel:convertMoveKey(self.key,self:getShowDisciple(index))
local move=CS.WorldSingelTeam.New(moveKey,{},disObj)

local partTime1=self.jumpTime*math.floor(index/2)
local partTime2=partTime1+self.jumpTime
local partTime3=partTime2+self.moveTime
local partTime4=partTime3+self.fadeDuration
local partTimes={partTime1,partTime2,partTime3,partTime4}

local ways={}
self:handleForwardWays(ways,index,disObj,fast,forward,0,partTimes)

local path=CS.WorldMovePath.New(ways,CS.WorldLoopType.Restart,1)
move:AddPath(path)
move.onComplete=function(key,pass)
self.fast=pass
if self.LT_Time(pass,self.onceTime)then
if index==1 and((not forward and fast<=0)or self.LT_Time(fast,partTime3))then
worldHUDModel:UpdateHUDByKey(self.objects[1].Key)
end
self:onNormalMoveStep(index,pass)
elseif forward and index==self:getShowDiscipleCnt()then
if self.LT_Time(fast,self.onceTime)then
local disciple=self:getFirstShowDisciple()
UIManager.info(FMT.fmt("{0}队伍开始探索",UIDiscipleModel:getDiscipleName(disciple)))
end
local firstObject=self.objects[1]
firstObject:ChangeModelColor(Color.New(1,1,1,1),0)
worldHUDModel:UpdateHUDByKey(firstObject.Key)
self:onWanderMoveStep()
end
end
return move
end

function worldTaskSky_Experience:onNormalMoveStep(index,fast)
if not self.objects[index]then
local discipleGuid=self:getShowDisciple(index)
worldTaskController:showTaskDisciple(self.key,discipleGuid,index==1)
local unitKey=worldTaskModel:convertMissionUnitKey(self.key,discipleGuid)
local obj=worldController:getUnit(unitKey)
self.objects[index]=obj
end
if self.move[index]then
worldController:popMove(self.move[index].Key)
end
local discipleMove=self:createNormalMove(index,self.endTime<=0,fast)
self.move[index]=discipleMove
worldController:pushMove(discipleMove)
discipleMove:Goto(fast-discipleMove.Pass)
end

function worldTaskSky_Experience:onWanderMoveStep()
local objCnt=#self.objects
if objCnt>0 then
for i=2,objCnt do
worldController:popUnit(self.objects[i].Key)
self.objects[i]=nil
end
for i,v in ipairs(self.move)do
worldController:popMove(v.Key)
end
local move=self:createWanderMove()
self.move={move}
worldController:pushMove(move)
else
self:startWanderMove()
end
worldHUDModel:UpdateHUDByKey(self.objects[1].Key)
end


function worldTaskSky_Experience:quit()
worldTaskBase.quit(self)
self.inlineMove=nil
self.inlineObject=nil
end

function worldTaskSky_Experience:finish()
worldTaskBase.finish(self)
self:popInlineMove()
self:disposeInlineObject()
end

function worldTaskSky_Experience:isWaitingBack()
return self.endTime<=0 and self.GE_Time(self.fast,self.onceTime)
end

function worldTaskSky_Experience:goBack()
if not self.groupCfg.skipReturnDispatch then
local expression=worldExperienceModel:getProgressExpression(self.groupCfg.id)
local point=worldExperienceModel:getExpressionPoint(self.groupCfg.id,expression)
self.destination=mathHelper.convertArrayToVector(point)
worldTaskSky.start(self,timeHelper.getServerShortTime())

if not self.corners then
return print(FMT.fmt("任务{0} 不存在路径",self.key))
end

self.endTime=self.onceTime+timeHelper.getServerShortTime()
self.fast=0
for i,v in ipairs(self:getShowDisciples())do
self:onNormalMoveStep(i,0)
end
worldHUDModel:UpdateHUDByKey(self.objects[1].Key)
else
self.endTime=timeHelper.getServerShortTime()
end
end

function worldTaskSky_Experience:createInlineObject()
worldTaskController:showExperienceDisciple(self.groupCfg.id,self:getFirstShowDisciple())
local inlineUnitKey=worldExperienceModel:getDiscipleKey(self.groupCfg.id)
self.inlineObject=worldController:getUnit(inlineUnitKey)
end

function worldTaskSky_Experience:pushAnimationMove(position,animation,duration,callback)
local moveKey=worldMoveModel:convertMoveKey(self.key,0)
local way=CS.WorldWaitWay.New(position,duration,Vector3Int(0,animation,0))
local ways={way}
local path=CS.WorldMovePath.New(ways,CS.WorldLoopType.Restart,1)
self.inlineMove=CS.WorldSingelTeam.New(moveKey,{path},self.inlineObject)
if callback then
self.inlineMove.onComplete=callback
end
worldController:pushMove(self.inlineMove)
end

function worldTaskSky_Experience:pushWalkMove(inlinePath,finish,callback)
local moveKey=worldMoveModel:convertMoveKey(self.key,0)
local animation0=self.experienceWalkAnimation
local animation=Vector3Int(animation0,animation0,finish and 0 or animation0)
local way=CS.WorldNavWay.New(inlinePath,self.experienceWalkSpeed,animation)
local ways={way}
local path=CS.WorldMovePath.New(ways,CS.WorldLoopType.Restart,1)
self.inlineMove=CS.WorldSingelTeam.New(moveKey,{path},self.inlineObject)
if callback then
self.inlineMove.onComplete=callback
end
worldController:pushMove(self.inlineMove)
end

function worldTaskSky_Experience:popInlineMove()
if self.inlineMove then
worldController:popMove(self.inlineMove.Key)
self.inlineMove=nil
end
end

function worldTaskSky_Experience:disposeInlineObject()
if self.inlineObject then
worldController:popUnit(self.inlineObject.Key)
self.inlineObject=nil
end
end

function worldTaskSky_Experience:isInlineMoving()
return self.inlineMove and self.inlineMove.Pass<self.inlineMove.Duration or false
end


function worldTaskSky_Experience:createWanderMove()

if self.wanderKind>0 and#self.wanderPointList>1 then
self.wanderKind=0
self.objects[1]:PlayModelEffect(self.runEffect,Vector3.zero,Vector3.one)
return self:createWanderWalkMove()
else
self.wanderKind=1
self.objects[1]:StopModelEffect(self.runEffect)
return self:createWanderPointMove()
end
end

function worldTaskSky_Experience:createWanderWalkMove()
local position=mathHelper.convertArrayToVector(self.wanderPointList[self.wanderPoint])
local temp={}
for i,v in ipairs(self.wanderPointList)do
if i~=self.wanderPoint then
table.insert(temp,i)
end
end
local rIdx=math.random(1,#temp)
local dIdx=temp[rIdx]or self.wanderPoint

local dest=mathHelper.convertArrayToVector(self.wanderPointList[dIdx])
local corners=worldController:calculateNavPath(position,dest)
self.wanderPoint=dIdx
local ways={CS.WorldNavWay.New(corners,self.speed,Vector3Int(0,self.runAnimation,0))}
local path={CS.WorldMovePath.New(ways,CS.WorldLoopType.Restart,1)}
local moveKey=worldMoveModel:convertMoveKey(self.key,self:getFirstShowDisciple())
local move=CS.WorldLineTeam.New(moveKey,path,{self.objects[1]},0)
move.onComplete=function()
self:onWanderMoveStep()
end
return move
end

function worldTaskSky_Experience:createWanderPointMove()
local position=self.wanderPointList[self.wanderPoint]
position=worldPositionConfig:getPosition_CurrentWorld(position)
local r=math.random(self.aiWeightTotal)
local sum=0
local info=nil
for i,v in ipairs(self.aiCfg)do
sum=sum+v[3]
if r<=sum then
info=v
break
end
end
if info[1]==1 then
return self:createWanderAnimationPoint(position,info[2])
else
return self:createWanderEffectPoint(position,info[2])
end
end

function worldTaskSky_Experience:createWanderAnimationPoint(position,info)
local animation=info[1]
local timeInfo=info[2]
local duration=#timeInfo==2 and math.random(timeInfo[1],timeInfo[2])or timeInfo[1]

local ways={CS.WorldWaitWay.New(position,duration,Vector3Int(0,animation,0))}
local path={CS.WorldMovePath.New(ways,CS.WorldLoopType.Restart,1)}
local moveKey=worldMoveModel:convertMoveKey(self.key,self:getFirstShowDisciple())
local move=CS.WorldLineTeam.New(moveKey,path,{self.objects[1]},0)
move.onComplete=function()
self:onWanderMoveStep()
end
return move
end

function worldTaskSky_Experience:createWanderEffectPoint(position,info)
local effect=info[1]
local timeInfo=info[2]
local duration=#timeInfo==2 and math.random(timeInfo[1],timeInfo[2])or timeInfo[1]

local ways={CS.WorldWaitWay.New(position,duration,Vector3Int(0,0,0))}
local path={CS.WorldMovePath.New(ways,CS.WorldLoopType.Restart,1)}
local moveKey=worldMoveModel:convertMoveKey(self.key,self:getFirstShowDisciple())
local move=CS.WorldLineTeam.New(moveKey,path,{self.objects[1]},0)
worldController:changeModelColor(self.objects[1].Key,Color.clear,0)
worldController:playModelEffect(self.objects[1].Key,effect)
move.onComplete=function()
worldController:changeModelColor(self.objects[1].Key,Color.white,0)
worldController:stopModelEffect(self.objects[1].Key,effect)
self:onWanderMoveStep()
end
return move
end
