







def_class("UILingYunLanZhongLittleGameWin",UIWindowBase)









function UILingYunLanZhongLittleGameWin:bindComponents()

self.grids=UIGameobjectClone.new(self,0)
self.player=UIObject.get(self,1)
self.craneFlyEventRoot=UIGameobjectClone.new(self,2)
self.closebtn=UIButton.get(self,3)
self.scoringRoot=UIObject.get(self,4)
self.levelNum=UIText.get(self,5)
self.progress=UIProgressBarAni.get(self,6)
self.operationRoot=UIObject.get(self,7)
self.returnBtnRoot=UIObject.get(self,8)
self.returnBtnTip=UIObject.get(self,9)
self.returnBtn=UIButton.get(self,10)
self.jumpBtnRoot=UIObject.get(self,11)
self.jumpBtnTip=UIObject.get(self,12)
self.jumpBtn=UIButton.get(self,13)
self.bgroot=UIObject.get(self,14)
self.fallDiscipleRoot=UIGameobjectClone.new(self,15)
self.gameroot=UIObject.get(self,16)

self.closebtn:setButtonClick(function()self:onClosebtn()end)

self.returnBtn:setButtonClick(function()self:onReturnBtn()end)

self.jumpBtn:setButtonClick(function()self:onJumpBtn()end)



end


function UILingYunLanZhongLittleGameWin:unbindComponents()
local _UIObject_release=UIObject.release
self.grids:deleteSelf();self.grids=nil;
_UIObject_release(self.player);self.player=nil;
self.craneFlyEventRoot:deleteSelf();self.craneFlyEventRoot=nil;
_UIObject_release(self.closebtn);self.closebtn=nil;
_UIObject_release(self.scoringRoot);self.scoringRoot=nil;
_UIObject_release(self.levelNum);self.levelNum=nil;
_UIObject_release(self.progress);self.progress=nil;
_UIObject_release(self.operationRoot);self.operationRoot=nil;
_UIObject_release(self.returnBtnRoot);self.returnBtnRoot=nil;
_UIObject_release(self.returnBtnTip);self.returnBtnTip=nil;
_UIObject_release(self.returnBtn);self.returnBtn=nil;
_UIObject_release(self.jumpBtnRoot);self.jumpBtnRoot=nil;
_UIObject_release(self.jumpBtnTip);self.jumpBtnTip=nil;
_UIObject_release(self.jumpBtn);self.jumpBtn=nil;
_UIObject_release(self.bgroot);self.bgroot=nil;
self.fallDiscipleRoot:deleteSelf();self.fallDiscipleRoot=nil;
_UIObject_release(self.gameroot);self.gameroot=nil;
end
















local _this=nil

local gridRewardType={
lingpo=1,
rewardbox=2,
}

local gridRewardItemid={
[gridRewardType.lingpo]=1,
[gridRewardType.rewardbox]=2,
}

local evolutionGridPathIndex={
single_Path=1,
line_Path=2,
L_R_Path=3,
reward_Path=4,
series_reward_Path=5,
}

local joinRandomPathList={
evolutionGridPathIndex.line_Path,
evolutionGridPathIndex.L_R_Path,
evolutionGridPathIndex.reward_Path,
}

local evolutionGridPathCondition={
[evolutionGridPathIndex.line_Path]={
evolutionGrid_min=2,
evolutionGrid_max=4,
},
[evolutionGridPathIndex.L_R_Path]={
evolutionGrid_min=2,
evolutionGrid_max=4,
},
[evolutionGridPathIndex.reward_Path]={
evolutionGrid_min=1,
evolutionGrid_max=3,
},
}

local evolutionGridPathFunc
evolutionGridPathFunc={
[evolutionGridPathIndex.single_Path]={
evolutionFunc=function(self)


local evolutionDirection=-1
if self.showArea.x/2>=self.prePosX then
evolutionDirection=1
else
evolutionDirection=-1
end
local posx=self.prePosX+(self.gridOffset.x+self.gridDeltaSize.x)*evolutionDirection
local posy=self.prePosY+self.gridOffset.y+self.gridDeltaSize.y
local stepid=Mathf.Floor(posx/self.gridDeltaSize.x)
self:evolutionGrids(posx,posy,stepid)

self.prePosX=posx
self.prePosY=posy
self.floorNum=self.floorNum+1

end,
checkCondition=function(self)
return evolutionGridPathIndex.single_Path
end
},
[evolutionGridPathIndex.line_Path]={
evolutionFunc=function(self)
local condition=evolutionGridPathCondition[evolutionGridPathIndex.line_Path]
local evolutionDirection=-1
local maxEvolutionGridNum=0
if self.showArea.x/2>=self.prePosX then
evolutionDirection=1
local evolutionWidth=self.showArea.x-self.prePosX
maxEvolutionGridNum=Mathf.Floor(evolutionWidth/self.gridDeltaSize.x)
else
evolutionDirection=-1
local evolutionWidth=self.prePosX
maxEvolutionGridNum=Mathf.Floor(evolutionWidth/self.gridDeltaSize.x)
end

maxEvolutionGridNum=Mathf.Min(condition.evolutionGrid_max,maxEvolutionGridNum)
local evolutionGridNum=Mathf.Random(condition.evolutionGrid_min,maxEvolutionGridNum)
for index=1,evolutionGridNum do
local posx=self.prePosX+(self.gridOffset.x+self.gridDeltaSize.x)*evolutionDirection
local posy=self.prePosY+self.gridOffset.y+self.gridDeltaSize.y
local stepid=Mathf.Floor(posx/self.gridDeltaSize.x)
self:evolutionGrids(posx,posy,stepid)

self.prePosX=posx
self.prePosY=posy
self.floorNum=self.floorNum+1
end

end,
checkCondition=function(self)
return evolutionGridPathIndex.line_Path
end
},
[evolutionGridPathIndex.L_R_Path]={
evolutionFunc=function(self)
local condition=evolutionGridPathCondition[evolutionGridPathIndex.L_R_Path]
local evolutionDirection=-1
if self.showArea.x/2>=self.prePosX then
evolutionDirection=1
else
evolutionDirection=-1
end
local evolutionGridNum=Mathf.Random(condition.evolutionGrid_min,condition.evolutionGrid_max)
for index=1,evolutionGridNum do
local posx=self.prePosX+(self.gridOffset.x+self.gridDeltaSize.x)*evolutionDirection
local posy=self.prePosY+self.gridOffset.y+self.gridDeltaSize.y
local stepid=Mathf.Floor(posx/self.gridDeltaSize.x)
self:evolutionGrids(posx,posy,stepid)

self.prePosX=posx
self.prePosY=posy
self.floorNum=self.floorNum+1
evolutionDirection=evolutionDirection*-1
end

end,
checkCondition=function(self)
return evolutionGridPathIndex.L_R_Path
end
},
[evolutionGridPathIndex.reward_Path]={
evolutionFunc=function(self)
local condition=evolutionGridPathCondition[evolutionGridPathIndex.reward_Path]
local canEvolutionGridNum=0
local evolutionDirection=-1
if self.showArea.x/2>=self.prePosX then
evolutionDirection=1
local evolutionWidth=self.prePosX
canEvolutionGridNum=Mathf.Floor(evolutionWidth/self.gridDeltaSize.x)
else
evolutionDirection=-1
local evolutionWidth=self.showArea.x-self.prePosX
canEvolutionGridNum=Mathf.Floor(evolutionWidth/self.gridDeltaSize.x)
end

if canEvolutionGridNum==0 then

evolutionGridPathFunc[evolutionGridPathIndex.single_Path].evolutionFunc(self)
canEvolutionGridNum=1
end


local canEvolutionGridNum=Mathf.Min(canEvolutionGridNum,condition.evolutionGrid_max)
local evolutionGridNum=Mathf.Random(condition.evolutionGrid_min,condition.evolutionGrid_max)
local curPosY=self.prePosY
local leftPosX=self.prePosX
local rightPosX=self.prePosX
local leftRewardType=Mathf.Random(1,2)
local rightRewardType=leftRewardType==gridRewardType.lingpo and gridRewardType.rewardbox or gridRewardType.lingpo

for index=1,evolutionGridNum do
local posy=curPosY+self.gridOffset.y+self.gridDeltaSize.y

local lposx=leftPosX+(self.gridOffset.x+self.gridDeltaSize.x)*-1
local lstepid=Mathf.Floor(lposx/self.gridDeltaSize.x)
self:evolutionGrids(lposx,posy,lstepid,leftRewardType)
leftPosX=lposx


local rposx=rightPosX+(self.gridOffset.x+self.gridDeltaSize.x)*1
local rstepid=Mathf.Floor(rposx/self.gridDeltaSize.x)
self:evolutionGrids(rposx,posy,rstepid,rightRewardType)
rightPosX=rposx

curPosY=posy

self.floorNum=self.floorNum+1
end

if evolutionGridNum-1>0 then
for index=1,evolutionGridNum-1 do
local posy=curPosY+self.gridOffset.y+self.gridDeltaSize.y

local lposx=leftPosX+(self.gridOffset.x+self.gridDeltaSize.x)*1
local lstepid=Mathf.Floor(lposx/self.gridDeltaSize.x)
self:evolutionGrids(lposx,posy,lstepid,leftRewardType)
leftPosX=lposx


local rposx=rightPosX+(self.gridOffset.x+self.gridDeltaSize.x)*-1
local rstepid=Mathf.Floor(rposx/self.gridDeltaSize.x)
self:evolutionGrids(rposx,posy,rstepid,rightRewardType)
rightPosX=rposx

curPosY=posy

self.floorNum=self.floorNum+1
end
end

local posy=curPosY+self.gridOffset.y+self.gridDeltaSize.y
local lposx=leftPosX+(self.gridOffset.x+self.gridDeltaSize.x)*1
local lstepid=Mathf.Floor(lposx/self.gridDeltaSize.x)
self:evolutionGrids(lposx,posy,lstepid)
leftPosX=lposx

self.prePosX=leftPosX
self.prePosY=posy
self.floorNum=self.floorNum+1


end,
checkCondition=function(self)
local state=self.floorNum>self.cfg.rewardCondition[1]*(self.showRewardPathNum+1)+self.cfg.rewardCondition[2]*self.showRewardPathNum
if state then
if self.floorNum>self.cfg.seriesRewardCondition[1]and not self.triggerSeriesRewardPath then
local rv=Mathf.Random(1,self.cfg.seriesRewardCondition[2])
if rv<self.cfg.seriesRewardCondition[3]then
self.showRewardPathNum=self.showRewardPathNum+1
return evolutionGridPathIndex.series_reward_Path
end
end
self.showRewardPathNum=self.showRewardPathNum+1
return evolutionGridPathIndex.reward_Path
end
end
},
[evolutionGridPathIndex.series_reward_Path]={
evolutionFunc=function(self)
local triggerNum=Mathf.Random(self.cfg.seriesRewardCondition[4][1],self.cfg.seriesRewardCondition[4][2])
for i=1,triggerNum do
evolutionGridPathFunc[evolutionGridPathIndex.reward_Path].evolutionFunc(self)
end
self.triggerSeriesRewardPath=true
end,
checkCondition=function(self)
local state=self.floorNum>self.cfg.rewardCondition[1]*(self.showRewardPathNum+1)+self.cfg.rewardCondition[2]*self.showRewardPathNum
return state
end
},
}


local specialEventIndex={
crane_Fade_InOut=1,
run_Into_disciple=2,
fall_disciple=3,
}

local specialEventFunc={
[specialEventIndex.crane_Fade_InOut]={
doEvent=function(self,grid,grouplayer)
local _,stepData=next(grouplayer)
local posy=stepData.posy

local direction=Mathf.Random(1,2)
self:freshCrane(posy,direction)
end,
checkCondition=function(self,step)
return self.curJumpFloor>5
end
},
[specialEventIndex.run_Into_disciple]={
doEvent=function(self,grid,grouplayer)

local radomDiscipleid=1113002
grid:freshRestDisciple(radomDiscipleid)
end,
checkCondition=function(self,step)
return self.curJumpFloor>5 and step.itemid==nil
end
},
[specialEventIndex.fall_disciple]={
doEvent=function(self,grid,grouplayer)

local radomDiscipleid=1113002
local _,stepData=next(grouplayer)
local posy=stepData.posy
self:freshFallDisciple(radomDiscipleid,posy)
end,
checkCondition=function(self,step)
return self.curJumpFloor>5
end
},
}




function UILingYunLanZhongLittleGameWin:onLoaded(...)
self:bindComponents()

_this=self

self.gridList={}
self.craneFlyList={}
self.failgridList={}


self.evolutionStartPos=Vector2(200,700)

self.prePosX=250

self.prePosY=150

self.playerStartPosY=100

self.pathWayQueue=queue.New()
self.floorNum=0

self.showArea=Vector2(1000,2000)
self.gridOffset=Vector2(0,0)
self.gridDeltaSize=Vector2(100,100)

self.playerDirection=-1
self.curJumpFloor=0
self.curJumpStempIndex=2
self.playerJumping=false
self.showRewardPathNum=0

self.triggerSeriesRewardPath=false

self.freshItemNum=0
self.freshItemStep=0
self.freshItemRandomStep=-1

self.pickupRewardList={}

self.curLingLiValue=0
self.maxLingLiValue=300
end


function UILingYunLanZhongLittleGameWin:__delete()
self:unbindComponents()

if self.countdown then
self.countdown:cancel()
self.countdown=nil
end
_this=nil
end




function UILingYunLanZhongLittleGameWin:onShow(argtable,afterOnloaded)
local subid=argtable and argtable.subid or 1
self.cfg=cfgHelper.get1(cfg_lingyunlanzhongconfig_get,subid)
self.selectdzguid=argtable.discipleguid
local dzjiyuanvalue=UIDiscipleModel:getDiscipleBaseAttr(self.selectdzguid,DISCIPLE_BASE_ATTR_TYPE.eJiYuan)
local morejy=self.cfg.discipleupuplval[1]-dzjiyuanvalue
self.curLingLiValue=morejy>0 and self.cfg.baselval+morejy*self.cfg.discipleupuplval[2]or self.cfg.baselval
self.maxLingLiValue=self.curLingLiValue
self.limitSwapRewardBoxNum=argtable.limitSwapRewardBoxNum
self.settlementFunc=argtable.settlementFunc

self.freshItemStep=self.cfg.freshitemrule[1]


self:initUI()
self:startGame()
end


function UILingYunLanZhongLittleGameWin:onHide()

end


function UILingYunLanZhongLittleGameWin:evolutionGrids(posx,posy,stepid,rewardType)
local params={
posx=posx,
posy=posy
}


if rewardType then
params.rewardtype=rewardType
params.itemid=gridRewardItemid[rewardType]
end

local luaid=self.grids:createObject('UICSGridItem',self.grids:getID(),self.floorNum+1,params)
if luaid then
params.luaid=luaid
else
logWarn("LingYunLanZhi LittleGame Create grid failed")
end

if not self.gridList[self.floorNum+1]then
self.gridList[self.floorNum+1]={}
end
self.gridList[self.floorNum+1][stepid]=params

self:evolutionFailGrids(posx,posy,stepid)
end

function UILingYunLanZhongLittleGameWin:evolutionFailGrids(posx,posy,stepid)
local leftArgs={
posx=posx+(self.gridOffset.x+self.gridDeltaSize.x)*-1*2,
posy=posy,
active=false
}
local lluaid=self.grids:createObject('UICSGridItem',self.grids:getID(),10000+self.floorNum+1,leftArgs)
if lluaid then
leftArgs.luaid=lluaid
else
logWarn("LingYunLanZhi LittleGame Create grid failed")
end

if not self.failgridList[self.floorNum+1]then
self.failgridList[self.floorNum+1]={}
end
self.failgridList[self.floorNum+1][stepid-2]=leftArgs

local rightArgs={
posx=posx+(self.gridOffset.x+self.gridDeltaSize.x)*1*2,
posy=posy,
active=false
}
local rluaid=self.grids:createObject('UICSGridItem',self.grids:getID(),10000+self.floorNum+1,rightArgs)
if rluaid then
rightArgs.luaid=rluaid
else
logWarn("LingYunLanZhi LittleGame Create grid failed")
end

if not self.failgridList[self.floorNum+1]then
self.failgridList[self.floorNum+1]={}
end
self.failgridList[self.floorNum+1][stepid+2]=rightArgs
end

function UILingYunLanZhongLittleGameWin:freshlayer()
self:freshlayerToCurStep()
self:freshlayerToFiveStep()
self:freshlayerToTenStep()
end

function UILingYunLanZhongLittleGameWin:freshlayerToCurStep()
local stepData=self.gridList[self.curJumpFloor][self.curJumpStempIndex]

if stepData.itemid~=nil then

self.pickupRewardList[stepData.itemid]=self.pickupRewardList[stepData.itemid]and self.pickupRewardList[stepData.itemid]+1 or 1
if stepData.rewardtype==gridRewardType.lingpo then

self:addLingLiValue(self.cfg.itemlist[gridRewardType.lingpo][3][1])
end

local gridLuaObject=self.grids:getLuaObject(stepData.luaid)
gridLuaObject:doPickUpRewardItem()
end

end

function UILingYunLanZhongLittleGameWin:freshlayerToFiveStep()
local frehgridIndex=self.curJumpFloor+5
local grouplayer=self.gridList[frehgridIndex]

local stepindex,stepdata=next(grouplayer)

local eventid=self:randomSpecialEvent(stepdata)
if eventid then
local gridLuaObject=self.grids:getLuaObject(stepdata.luaid)
specialEventFunc[eventid].doEvent(self,gridLuaObject,grouplayer)
end
end

function UILingYunLanZhongLittleGameWin:freshlayerToTenStep()
local frehgridIndex=self.curJumpFloor+10
local grouplayer=self.gridList[frehgridIndex]


local needGridNum=self.cfg.freshitemrule[1]+self.cfg.freshitemrule[4]*(Mathf.Floor(frehgridIndex/self.cfg.freshitemrule[3]))
if frehgridIndex>=needGridNum and frehgridIndex>=self.freshItemNum*self.cfg.freshitemrule[4]+self.cfg.freshitemrule[1]then
self:setNormalItem(frehgridIndex)
end
end

function UILingYunLanZhongLittleGameWin:setNormalItem(stepIndex)
for i=1,self.cfg.freshitemrule[2]do
local grouplayer=self.gridList[stepIndex+i]
local isfresh=false
for k,step in pairs(grouplayer)do
if not step.itemid then
local type=Mathf.Random(1,2)
local gridLuaObject=self.grids:getLuaObject(step.luaid)
step.rewardtype=type
step.itemid=gridRewardItemid[type]
if type==gridRewardType.rewardbox then


if self.pickupRewardList[gridRewardType.rewardbox]>=self.limitSwapRewardBoxNum then
step.itemid=gridRewardItemid[gridRewardType.lingpo]
end
end
gridLuaObject:freshRewardItem(step.itemid)

isfresh=true
end
end
if isfresh then
self.freshItemNum=self.freshItemNum+1
break
end
end
end

function UILingYunLanZhongLittleGameWin:randomSpecialEvent(stepData)
local isTriggleEvent=Mathf.Random(1,2)==1
if isTriggleEvent then
local randomlist={}

for k,v in pairs(specialEventIndex)do
if specialEventFunc[v].checkCondition(self,stepData)then
table.insert(randomlist,v)
end
end

if#randomlist>0 then
local randomIndex=Mathf.Random(1,#randomlist)
return randomlist[randomIndex]
end
end
end

function UILingYunLanZhongLittleGameWin:randomSwapPathWay()
local randomList={}
local evolutionPathId
for k,v in pairs(joinRandomPathList)do
local rid=evolutionGridPathFunc[v].checkCondition(self)
if rid==evolutionGridPathIndex.reward_Path or rid==evolutionGridPathIndex.series_reward_Path then
evolutionPathId=rid
end
table.insert(randomList,rid)
end
if not evolutionPathId then
local index=Mathf.Random(1,#randomList)
evolutionPathId=randomList[index]
end
evolutionGridPathFunc[evolutionPathId].evolutionFunc(self)
end

function UILingYunLanZhongLittleGameWin:checkDoSwapPath()
if self.floorNum-self.curJumpFloor<10 then
self:randomSwapPathWay()
end
end


function UILingYunLanZhongLittleGameWin:initUI()
self:freshScoreCount()
end


function UILingYunLanZhongLittleGameWin:preparationGame()


self:initPlayer()
for i=1,10 do
self:randomSwapPathWay()
end
end

function UILingYunLanZhongLittleGameWin:initPlayer()

local modelParams=UIDiscipleModel:getDiscipleOutsideModelInfo(self.selectdzguid,true,nil,nil)
self.player:setChildUIModelShowTarget(modelParams.body,1,modelParams.componets,0,false,false,0,nil)
end


function UILingYunLanZhongLittleGameWin:startGame()
self:preparationGame()
self:startCountDown()
end

function UILingYunLanZhongLittleGameWin:startCountDown()

if self.countdown then
self.countdown:cancel()
self.countdown=nil
end
self.countdown=timer.new()
local func=function()
if not _this then return end
local llvstep=Mathf.Floor(_this.curJumpFloor/_this.cfg.lvalcomsume[2])*_this.cfg.lvalcomsume[3]
_this.curLingLiValue=_this.curLingLiValue-_this.cfg.lvalcomsume[1]-llvstep
_this:freshProgress()
if _this.curLingLiValue<=0 then

_this.countdown:cancel()
_this.countdown=nil
_this:gameOver()
end

end
self.countdown:start(1,func)
func()
end


function UILingYunLanZhongLittleGameWin:addLingLiValue(val)
if self.curLingLiValue==self.maxLingLiValue then

self.maxLingLiValue=Mathf.Min(self.curLingLiValue+val,self.cfg.maxlval)
end
self.curLingLiValue=Mathf.Min(self.curLingLiValue+val,self.cfg.maxlval)
self:freshProgress()
end

function UILingYunLanZhongLittleGameWin:freshProgress()
self.progress:animateThreeParams(self.curLingLiValue,self.maxLingLiValue,0.1)
end

function UILingYunLanZhongLittleGameWin:pauseCountDown()
if self.countdown then
self.countdown:pause()
end
end

function UILingYunLanZhongLittleGameWin:continueCountDown()
if self.countdown then
self.countdown:continue()
end
end


function UILingYunLanZhongLittleGameWin:gameOver()
if not self.playerJumping then
self.playerJumping=true
_this.settlementFunc(_this.curJumpFloor,_this.pickupRewardList[gridRewardItemid[gridRewardType.rewardbox]])
self:closeSelf()
else
self.gameoverstate=true
end
end

function UILingYunLanZhongLittleGameWin:onClosebtn()
self.playerJumping=true
self:pauseCountDown()
local outcallback=function()
_this.settlementFunc(_this.curJumpFloor,_this.pickupRewardList[gridRewardType.rewardbox])
self:closeSelf()
end
self:showWindow("UILingYunLanZhongPauseWin",{
levelNum=self.curJumpFloor,
mainWin=_this,
outcallback=outcallback
})
end

function UILingYunLanZhongLittleGameWin:onReturnBtn()
if self.playerJumping then return end
self.playerDirection=self.playerDirection*-1
local rv=self.playerDirection==1 and 180 or 0
self.player:setRotation(0,rv,0)
self:onJumpBtn()
end

function UILingYunLanZhongLittleGameWin:onJumpBtn()

if self.playerJumping then return end
local nextStepIndex=self.curJumpStempIndex+self.playerDirection
local nextFloor=self.curJumpFloor+1
self.playerJumping=true
if self.gridList[nextFloor][nextStepIndex]then


local nextStep=self.gridList[nextFloor][nextStepIndex]


local gridLuaObject=self.grids:getLuaObject(nextStep.luaid)
local pos=gridLuaObject:getPosition()
local jumpCallBack=function()
self.player:setChildModelAnimationState(eAnimationID.jump3,0.1,nil)

local scrollCallback=function()
if not self.gameoverstate then
self.playerJumping=false
self.curJumpStempIndex=self.curJumpStempIndex+self.playerDirection
self.curJumpFloor=self.curJumpFloor+1
self:checkDoSwapPath()
self:freshlayer()
self:recycleGridItem()
self:freshScoreCount()
else
self.playerJumping=false
self:gameOver()
end
end
if self.curJumpFloor>1 then
local gridspos=self.gameroot:getChildLocalPosition()
self.gameroot:setChildDOLocalMoveY(gridspos.y-self.gridDeltaSize.y-self.gridOffset.y,0.53,scrollCallback)
self:moveBg()
self:moveCraneRoot()
else
scrollCallback()
end
end
self.player:setChildModelAnimationState(eAnimationID.jump1,1,function()
self.player:setChildModelAnimationState(eAnimationID.jump2,1,nil)
self.player:setChildDOJump(pos,0.1,0,0.4,jumpCallBack)
end)
else


local curStep=self.failgridList[nextFloor][nextStepIndex]
local gridLuaObject=self.grids:getLuaObject(curStep.luaid)
local pos=gridLuaObject:getPosition()

self.player:setChildModelAnimationState(eAnimationID.ui_jump1,1,nil)
local jumpCallBack=function()
self.player:setChildModelAnimationState(eAnimationID.stand,1,nil)

local curPlayerPos=self.player:getChildLocalPosition()
self.player:setChildDOLocalMoveY(self.playerStartPosY,0.5,function()

self.playerJumping=false
_this:gameOver()
end)
end
self.player:setChildModelAnimationState(eAnimationID.jump1,1,function()
self.player:setChildModelAnimationState(eAnimationID.jump2,1,nil)
self.player:setChildDOJump(pos,0.1,0,0.4,jumpCallBack)
end)
end



end

function UILingYunLanZhongLittleGameWin:recycleGridItem()
local frehgridIndex=self.curJumpFloor-10
if frehgridIndex>0 then
local grouplayer=self.gridList[frehgridIndex]
for k,step in pairs(grouplayer)do
self.grids:recycleItemById(step.luaid)
end
end
end

function UILingYunLanZhongLittleGameWin:freshCrane(posy,direction)

local luaid=self.craneFlyEventRoot:createObject('UICSCraneItem',self.craneFlyEventRoot:getID(),posy,{modelid=1113002})
local gridLuaObject=self.craneFlyEventRoot:getLuaObject(luaid)
gridLuaObject:doMoveX(posy,direction)
end

function UILingYunLanZhongLittleGameWin:freshFallDisciple(radomDiscipleid,posy)
local frehgridIndex=self.curJumpFloor-10
local grouplayer=self.gridList[frehgridIndex]
local _,stepData=next(grouplayer)
local toPosy=stepData.posy
local randomPosIndex=Mathf.Random(1,2)
local posx=randomPosIndex==1 and 100 or 1100
local luaid=self.fallDiscipleRoot:createObject('UICSFallDisciple',self.fallDiscipleRoot:getID(),posy,{discipleid=radomDiscipleid})
local gridLuaObject=self.fallDiscipleRoot:getLuaObject(luaid)
gridLuaObject:doMoveY(posx,posy,toPosy)
end

function UILingYunLanZhongLittleGameWin:freshScoreCount()
self.levelNum:setText(FMT.fmt("{0}层",self.curJumpFloor))
end

function UILingYunLanZhongLittleGameWin:moveBg()
local pos=self.bgroot:getChildLocalPosition()
self.bgroot:setChildDOLocalMoveY(pos.y-self.gridDeltaSize.y-self.gridOffset.y,0.53,nil)
end

function UILingYunLanZhongLittleGameWin:moveCraneRoot()
local pos=self.craneFlyEventRoot:getChildLocalPosition()
self.craneFlyEventRoot:setChildDOLocalMoveY(pos.y-self.gridDeltaSize.y-self.gridOffset.y,0.53,nil)
end

function UILingYunLanZhongLittleGameWin:outGame()
self:closeSelf()
end






