worldTripMoveList_FlyTour=simple_class(worldTripMoveList)
worldTripMoveList_FlyTour.name="worldTripMoveList_FlyTour"

worldTripMoveList_FlyTour.MoveType={
Jump=6,
Fly=7,
Wait=8,

Animation=1,
Effect=2,
Bubble=3,
Show=4,
Color=5,
}

function worldTripMoveList_FlyTour:__init(tour,job,objects)
worldTripMoveList.__init(self)

self.objects=objects
self.tourCfg=cfgHelper.get1(cfg_worldtravelconfig_get,tour)
self.points={}
for block,list in pairs(self.tourCfg.wanderPoint)do
if worldBlockModel:checkBlockState(tour,block,eWorldBlockState.OPEN)then
self.points=table.concatTable(self.points,list)
end
end
self.taskPoint=self.tourCfg.taskPoint
self.monsters=self.tourCfg.monster
self.aiCfg=cfgHelper.get2(cfg_disciplevocationbuildspeakconfig_get,job,"tourWeight")
self.weight=0
for i,v in ipairs(self.aiCfg)do
self.weight=self.weight+v[3]
end
end

function worldTripMoveList_FlyTour:start(fast)
self.cPoint=0
self:startAction()
end

function worldTripMoveList_FlyTour:onStep(pass)
self:quit()

if self.action==0 then
if self.actionSub==self.MoveType.Jump then
self:startMove()
elseif self.actionSub==self.MoveType.Fly then
self:startWait()
elseif self.actionSub==self.MoveType.Wait then
self:executeTrigger(0,-1)
self.cPoint=self.nPoint
self:startPost(self.action-1)
end
elseif self.action<0 then
self:startPost(self.action-1)
else
self:startPrev(self.action+1)
end
end

function worldTripMoveList_FlyTour:setMove(moveType,move)
move.callback=function(pass)
self:onStep(pass)
end
self.list[moveType]=move
end

function worldTripMoveList_FlyTour:getMove(moveType)
return self.list[moveType]
end

function worldTripMoveList_FlyTour:extractAIIndex()
local r=math.random(self.weight)
local sum=0
for i,v in ipairs(self.aiCfg)do
sum=sum+v[3]
if r<=sum then
return i
end
end
end

function worldTripMoveList_FlyTour:extractPointIndex()
if self.cPoint<=0 then
return math.random(#self.points)
else
local temp=math.random(#self.points-1)
if temp>=self.cPoint then
return temp+1
else
return temp
end
end
end

function worldTripMoveList_FlyTour:refreshTarget(iPos)
local aiInfo=self.aiCfg[self.aiIdx]
local mInfo=aiInfo[4]
local mIdx=mInfo[1]
local mOffset=mInfo[2]or 0
local mlist=self.monsters[mIdx]
local max=mlist and#mlist or 0
if max>0 then
local obj=self.objects[0]
local rIdx=math.random(1,max)
local pathCnt=#self.path
local pos=self.path[pathCnt]
local delta=self.path[pathCnt]-self.path[pathCnt-1]
local flip=Mathf.Sign(delta.x)
local rValue=mlist[rIdx]
local mSettings=worldModel:getModelSettings(rValue,eWorldUnitTpye.TOURPOINT)
local mPos={iPos.x+mOffset*flip,iPos.y}
local mPosition=worldPositionConfig:getPosition_CurrentWorld(mPos)
worldController:changeUnitModel(obj.Key,mSettings)
worldController:setUnitFlipX(obj.Key,flip>0)
obj:SetPosition(mPosition)
worldHUDModel:callHUDFunc(obj.Key,"showTag",true)

end
end

function worldTripMoveList_FlyTour:startAction()
self.nPoint=self:extractPointIndex()
self.aiIdx=self:extractAIIndex()


local cVec2=self.cPoint<=0 and self.taskPoint or self.points[self.cPoint]
cVec2=mathHelper.convertArrayToVector(cVec2)
local nVec2=self.points[self.nPoint]
nVec2=mathHelper.convertArrayToVector(nVec2)

self.path=worldDispatchFactory:getPathCorners(eWorldTripType.Fly,nVec2,cVec2,self.tourCfg.id)
local flip=self.path[#self.path].x<self.path[1].x
worldController:setUnitFlipX(self.objects[1].Key,flip)

self:refreshTarget(nVec2)

self:startPrev(1)
end

function worldTripMoveList_FlyTour:startJump()
self.action=0
self.actionSub=self.MoveType.Jump
self:setProgress(self.MoveType.Jump)
local jumpMove=self.list[self.MoveType.Jump]
jumpMove.position=self.path[1]
jumpMove.flipX=self.path[#self.path].x<self.path[1].x
jumpMove:start(0)
end

function worldTripMoveList_FlyTour:startMove()

self.action=0
self.actionSub=self.MoveType.Fly
self:setProgress(self.MoveType.Fly)
local runMove=self.list[self.MoveType.Fly]
local corners={self.path[1]+Vector3.up*runMove.flyHeight,self.path[2]}
runMove.corners=corners
runMove.duration=worldDispatchFactory:getDuration(eWorldTripType.Fly,self.path)
runMove:start(0)
end

function worldTripMoveList_FlyTour:startWait()
self.action=0
self.actionSub=self.MoveType.Wait
self:setProgress(self.MoveType.Wait)
local runMove=self.list[self.MoveType.Wait]
runMove.position=self.path[#self.path]
runMove:start(0)
end

function worldTripMoveList_FlyTour:startPrev(index)
self.action=index
self.actionSub=0
local aiInfo=self.aiCfg[self.aiIdx]
local actionList=aiInfo[1]
if actionList and index<=#actionList then

self:startData(actionList[index],true)
return
end
self:startJump()
end

function worldTripMoveList_FlyTour:startPost(index)
self.action=index
self.actionSub=0
local aiInfo=self.aiCfg[self.aiIdx]
local actionList=aiInfo[2]
if actionList and-index<=#actionList then

self:startData(actionList[-index],false)
return
end
self:startAction()
end

function worldTripMoveList_FlyTour:startData(actionData,direction)
local actionType=actionData[1]
local actionParam=actionData[2]
local mixDuration=actionData[3]
local maxDuration=actionData[4]
local duration=maxDuration and math.random(mixDuration,maxDuration)or mixDuration
local position=direction and self.path[1]or self.path[#self.path]

if actionType==self.MoveType.Animation then
local animatinMove=self.list[self.MoveType.Animation]
self:setProgress(self.MoveType.Animation)
animatinMove.position=position
animatinMove.animation=actionParam
animatinMove.duration=duration
animatinMove:start(0)
elseif actionType==self.MoveType.Effect then
local effectMove=self.list[self.MoveType.Effect]
self:setProgress(self.MoveType.Effect)
effectMove.position=position
effectMove.duration=duration
effectMove.effect=actionParam
effectMove:start(0)
elseif actionType==self.MoveType.Bubble then
self:setProgress(self.MoveType.Bubble)
local text=actionParam[1]
local role=actionParam[2]
local duration=maxDuration and math.random(mixDuration,maxDuration)or mixDuration
local objKey=self.objects[1].Key
local unitKey=self.objects[role and 0 or 1].Key
worldHUDModel:callHUDFunc(objKey,"showDragonBone",false)
worldUnitModel:unitEmot(unitKey,text,duration,function()
worldHUDModel:callHUDFunc(objKey,"showDragonBone",true)
self:onStep()
end)
elseif actionType==self.MoveType.Show then
self:setProgress(self.MoveType.Show)
local show=actionParam>0
local objKey=self.objects[0].Key
worldController:showUnitModel(objKey,show)
worldHUDModel:callHUDFunc(objKey,"showTag",show)
self:onStep()
elseif actionType==self.MoveType.Color then
self:setProgress(self.MoveType.Color)
local color=Color.New(actionParam[1],actionParam[2],actionParam[3],actionParam[4])
local objKey=self.objects[1].Key
worldController:changeModelColor(objKey,color,duration,function()
self:onStep()
end)
else
self:onStep()
end
end