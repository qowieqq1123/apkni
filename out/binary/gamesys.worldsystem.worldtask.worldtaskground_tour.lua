









worldTaskGround_Tour=simple_class(worldTaskGround)

function worldTaskGround_Tour:__init(data)
worldTaskGround.__init(self,data)
local keys=worldModel:separateUnitKey(self.target)
local tourID=tonumber(keys[2])
local pointData=worldTourModel:getData(tourID)
self.startTime=pointData.begintime
self.endTime=pointData.endtime
self.pointCfg=cfgHelper.get1(cfg_worldtravelpointconfig_get,tourID)
local job=UIDiscipleModel:getDiscipleJob(self:getFirstShowDisciple())
self.aiCfg=cfgHelper.get2(cfg_disciplevocationbuildspeakconfig_get,job,"tourWeight")
self.aiWeightTotal=0
for i,v in ipairs(self.aiCfg)do
self.aiWeightTotal=self.aiWeightTotal+v[3]
end

end

function worldTaskGround_Tour:start(serverTime)
worldTaskGround.start(self,serverTime)

if not self.corners then return end

self.fast=Mathf.Clamp(serverTime-self.startTime,0,self.onceTime)

local isWander=self.fast>=self.onceTime

self.wanderPoint=isWander and math.random(1,#self.pointCfg.wanderPoint)or 0

if isWander then
self:startWanderMove()
else
self:startNormalMove(self.fast)
end
end

function worldTaskGround_Tour:showUnitObject()
local disciple=self:getFirstShowDisciple()
worldTaskController:showTaskDisciple(self.key,disciple,true,true)
local unitKey=worldTaskModel:convertMissionUnitKey(self.key,disciple)
local obj=worldController:getUnit(unitKey)
self.objects[1]=obj
end

function worldTaskGround_Tour:startNormalMove(fast)
self:showUnitObject()
local move=self:createNormalMove(fast)
self.move[1]=move
worldController:pushMove(move)
move:Goto(fast-move.Pass)
worldHUDModel:UpdateHUDByKey(self.objects[1].Key)
end

function worldTaskGround_Tour:createNormalMove(fast)
local disObj=self.objects[1]
local moveKey=worldMoveModel:convertMoveKey(self.key,self:getFirstShowDisciple())
local move=CS.WorldLineTeam.New(moveKey,{},{disObj},0)

local partTime1=self.waitInterval*(1-1)
local partTime2=partTime1+self.waitInterval
local partTime3=partTime2+self.moveTime
local partTime4=partTime3+self.waitInterval
local partTimes={partTime1,partTime2,partTime3,partTime4}

local ways={}
self:handleForwardWays(ways,disObj,fast,true,0,partTimes)

local path=CS.WorldMovePath.New(ways,CS.WorldLoopType.Restart,1)
move:AddPath(path)
move.onComplete=function(key,pass)
self.fast=pass
if self.LT_Time(pass,self.onceTime)then
self:onNormalMoveStep(pass)
else





disObj:ChangeModelColor(Color.New(1,1,1,1),0)
worldHUDModel:UpdateHUDByKey(disObj.Key)
self:startWanderMove()
end
end
return move
end

function worldTaskGround_Tour:onNormalMoveStep(fast)
if not self.objects[1]then
self:showUnitObject()
end
if self.move[1]then
worldController:popMove(self.move[1].Key)
end
local discipleMove=self:createNormalMove(fast)
self.move[1]=discipleMove
worldController:pushMove(discipleMove)
discipleMove:Goto(fast-discipleMove.Pass)
end

function worldTaskGround_Tour:startWanderMove()
if not self.objects[1]then
self:showUnitObject()
end
local destIdx=self:extractPointIndex()
local aiIdx=self:extractAIIndex()
local aiInfo=self.aiCfg[aiIdx]
local pos=self.pointCfg.wanderPoint[destIdx]
local position=worldPositionConfig:getPosition_CurrentWorld(pos)
if self.wanderObj then
worldController:popUnit(self.wanderObj.Key)
self.wanderObj=nil
end

self.wanderPath=self:getWanderPath(self.wanderPoint,destIdx)

if position then

local mInfo=aiInfo[4]
local mIdx=mInfo[1]
local mOffset=mInfo[2]or 0

if mIdx then
local mlist=self.pointCfg.monster[mIdx]
if mlist then
local max=#mlist
if max>0 then

local pathCnt=self.wanderPath.Length
local delta=self.wanderPath[pathCnt-1]-self.wanderPath[pathCnt-2]
local flip=Mathf.Sign(delta.x)

local mPos={pos[1]+mOffset*flip,pos[2]}
local mPosition=worldPositionConfig:getPosition_CurrentWorld(mPos)

if mPosition then
local rIdx=math.random(1,max)
local rValue=mlist[rIdx]
local unitKey=worldModel:convertUnitKey({eWorldUnitTpye.TOURPOINT,self.pointCfg.id})
local modelSettings=worldModel:getModelSettings(rValue,eWorldUnitTpye.TOURPOINT)
local hudSettings=worldModel:getHUDSetting(self.tourHUD)
worldController:pushUnit(unitKey,mPosition,{eWorldUnitTpye.TOURPOINT,self.pointCfg.id},modelSettings,hudSettings)
worldController:setUnitFlipX(unitKey,flip>0)
self.wanderObj=worldController:getUnit(unitKey)
end
end
end
end

local obj=self.objects[1]
worldController:setUnitFlipX(obj.Key,position.x<obj.Position.x)

self:doAiAction(1,aiInfo,1,self.wanderPoint,destIdx)
end
end

function worldTaskGround_Tour:getWanderPath(startIdx,endIdx)
local temp=startIdx>0 and self.pointCfg.wanderPoint[startIdx]or self.pointCfg.taskPoint
local dept=mathHelper.convertArrayToVector(temp)
local dest=mathHelper.convertArrayToVector(self.pointCfg.wanderPoint[endIdx])

return worldController:calculateNavPath(dept,dest)
end

function worldTaskGround_Tour:doAiAction(kind,aiInfo,infoIdx,sPos,ePos)

if self.move[1]then

worldController:popMove(self.move[1].Key)
self.move[1]=nil
end
if kind==0 then
self:createWanderWalkMove(sPos,ePos,aiInfo)
return
end
local actionType=kind>0 and 1 or 2
local actionInfo=aiInfo[actionType]
if actionInfo and infoIdx<=#actionInfo then
local actionData=actionInfo[infoIdx]
local actionType=actionData[1]
local param={kind,aiInfo,infoIdx,sPos,ePos}
if actionType==1 then
self:createWanderAnimationPoint(actionData[2],actionData[3],actionData[4],param)
elseif actionType==2 then
self:createWanderEffectPoint(actionData[2],actionData[3],actionData[4],param)
elseif actionType==3 then
self:createWanderEmotPoint(actionData[2],actionData[3],actionData[4],param)
elseif actionType==4 then
self:createWanderObjectShow(actionData[2],actionData[3],actionData[4],param)
elseif actionType==5 then
self:createWanderColorChange(actionData[2],actionData[3],actionData[4],param)
else
self:doAiAction(kind,aiInfo,infoIdx+1,sPos,ePos)
end
return
end
local nextKind=kind-1
if nextKind>=-1 then
self:doAiAction(nextKind,aiInfo,1,sPos,ePos)
else
self:startWanderMove()
end
end

function worldTaskGround_Tour:extractAIIndex()
local r=math.random(self.aiWeightTotal)
local sum=0
for i,v in ipairs(self.aiCfg)do
sum=sum+v[3]
if r<=sum then
return i
end
end
end

function worldTaskGround_Tour:extractPointIndex()
local temp={}
for i,v in ipairs(self.pointCfg.wanderPoint)do
if i~=self.wanderPoint then
table.insert(temp,i)
end
end
local rIdx=math.random(1,#temp)
return temp[rIdx]
end

function worldTaskGround_Tour:createWanderWalkMove(startIdx,endIdx,aiInfo)







local obj=self.objects[1]
local ways={CS.WorldNavWay.New(self.wanderPath,self.speed,Vector3Int(0,self.runAnimation,0))}
local path={CS.WorldMovePath.New(ways,CS.WorldLoopType.Restart,1)}
local moveKey=worldMoveModel:convertMoveKey(self.key,self:getFirstShowDisciple())
local move=CS.WorldLineTeam.New(moveKey,path,{obj},0)
move.onComplete=function()
self.wanderPoint=endIdx
self:doAiAction(-1,aiInfo,1,startIdx,endIdx)
obj:StopModelEffect(self.runEffect)
end
self.move[1]=move
obj:PlayModelEffect(self.runEffect,Vector3.zero,Vector3.one)
worldController:pushMove(move)
end

function worldTaskGround_Tour:createWanderAnimationPoint(id,minTime,maxTime,param)
local animation=id
local duration=maxTime and math.random(minTime,maxTime)or minTime

local obj=self.objects[1]
local position=obj.Position
local ways={CS.WorldWaitWay.New(position,duration,Vector3Int(0,animation,0))}
local path={CS.WorldMovePath.New(ways,CS.WorldLoopType.Restart,1)}
local moveKey=worldMoveModel:convertMoveKey(self.key,self:getFirstShowDisciple())
local move=CS.WorldLineTeam.New(moveKey,path,{obj},0)
move.onComplete=function()

self:doAiAction(param[1],param[2],param[3]+1,param[4],param[5])
end
self.move[1]=move
worldController:pushMove(move)
end

function worldTaskGround_Tour:createWanderEffectPoint(id,minTime,maxTime,param)
local effect=id
local duration=maxTime and math.random(minTime,maxTime)or minTime

local obj=self.objects[1]
local position=obj.Position
local unitKey=obj.Key
local ways={CS.WorldWaitWay.New(position,duration,Vector3Int(0,0,0))}
local path={CS.WorldMovePath.New(ways,CS.WorldLoopType.Restart,1)}
local moveKey=worldMoveModel:convertMoveKey(self.key,self:getFirstShowDisciple())
local move=CS.WorldLineTeam.New(moveKey,path,{obj},0)



worldController:playModelEffect(unitKey,effect)
worldHUDModel:callHUDFunc(unitKey,"showDragonBone",false)
move.onComplete=function()




worldController:stopModelEffect(unitKey,effect)
worldHUDModel:callHUDFunc(unitKey,"showDragonBone",true)
self:doAiAction(param[1],param[2],param[3]+1,param[4],param[5])
end
self.move[1]=move
worldController:pushMove(move)
end

function worldTaskGround_Tour:createWanderEmotPoint(info,minTime,maxTime,param)
local text=info[1]
local role=info[2]
local duration=maxTime and math.random(minTime,maxTime)or minTime

local obj=self.objects[1]
local unitKey=role and self.wanderObj.Key or obj.Key
worldHUDModel:callHUDFunc(obj.Key,"showDragonBone",false)
worldUnitModel:unitEmot(unitKey,text,duration,function()

worldHUDModel:callHUDFunc(obj.Key,"showDragonBone",true)
self:doAiAction(param[1],param[2],param[3]+1,param[4],param[5])
end)
end

function worldTaskGround_Tour:createWanderObjectShow(info,minTime,maxTime,param)

local show=info>0
if self.wanderObj then
worldController:showUnitModel(self.wanderObj.Key,show)
worldHUDModel:callHUDFunc(self.wanderObj.Key,"showTag",show)
end
self:doAiAction(param[1],param[2],param[3]+1,param[4],param[5])
end

function worldTaskGround_Tour:createWanderColorChange(info,minTime,maxTime,param)
local color=Color.New(info[1],info[2],info[3],info[4])
local duration=maxTime and math.random(minTime,maxTime)or minTime
local obj=self.objects[1]
worldController:changeModelColor(obj.Key,color,duration,function()
self:doAiAction(param[1],param[2],param[3]+1,param[4],param[5])
end)
end

function worldTaskGround_Tour:quit()
worldTaskBase.quit(self)
self.wanderObj=nil
end

function worldTaskGround_Tour:finish()
worldTaskBase.finish(self)
if self.wanderObj then
worldController:popUnit(self.wanderObj.Key)
self.wanderObj=nil
end
end

function worldTaskGround_Tour:isWaitingBack()
return self.GE_Time(self.fast,self.onceTime)
end
