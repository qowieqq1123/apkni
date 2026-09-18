







local _MODULENAME="plotActionController"
gameState.addListener(def_table(_MODULENAME))
plotActionController.name=_MODULENAME

plotActionController.plotBlackInTime=0.2
plotActionController.plotBlackStayTime=0.2
plotActionController.plotBlackOutTime=0.1

local hideScreenData


local hideScreenType=
{
elilian_bigworld=1,
ejudian_bigworld=2,
ejingguan_bigworld=3,
eMystery=4,
}
local hideScreecFuncs=
{

[hideScreenType.elilian_bigworld]=function(flag,param1)
local unitKey=worldExperienceModel:getDiscipleKey()
worldController:showUnitModel(unitKey,flag)
end,

[hideScreenType.ejudian_bigworld]=function(flag,param1)
local unitKey=worldExperienceModel:getPointKey(param1)
worldController:showUnitModel(unitKey,flag)
end,

[hideScreenType.ejingguan_bigworld]=function(flag,param1)
local unitKey=worldSceneryModel:getSceneryKey(param1)
worldController:showUnitModel(unitKey,flag)
end,

[hideScreenType.eMystery]=function(flag)
mysteryEntityController.setEntityRootActive(flag)
end,
}

function plotActionController:onAppStart()
end
function plotActionController:onEnterState()
end
function plotActionController:onLeaveState()
plotActionController:clear()
end
function plotActionController:onPlayerCreate(...)
end
function plotActionController:onLostConnection()
end

function plotActionController:createUpdateTimer()
self.updateTimer=timer.new()
local f=function(...)
plotActionController:onTimerUpdata()
end
self.updateTimer:start(0.01,f,-1)
end

function plotActionController:clearUpdateTimer()
if self.updateTimer~=nil then
self.updateTimer:cancel()
self.updateTimer=nil
end
end

function plotActionController:onTimerUpdata()
if not self.isPlaying then return end
if not self.isReady then return end

local curTime=Time.realtimeSinceStartup
local lerp=curTime-self.startTime

local frozenIndex=nil
if self.frozenData~=nil then
frozenIndex=self.frozenData.excuteIndex
end
for i,v in ipairs(self.actionList)do
if v.flag==nil then
local sTime=v.sTime
if lerp>=sTime then
v.flag=true
self:doAction(i,v.effect)
end
elseif v.flag==true then
local check=true
if frozenIndex~=nil and frozenIndex==i then
check=false
end
if check then
local eTime=v.eTime
if lerp>=eTime then
v.flag=false
self:killAction(v.effect)
end
end
end
end

if self.frozenData==nil then
if self.plotBlackLeaveMark~=nil then
if lerp>=self.plotBlackLeaveMark then
self.plotBlackLeaveMark=nil
UIManager:showWindow('UIPlotBlackLoadWin',{callback=nil,initFunc=nil})
end
end

if lerp>=self.life then

plotActionController:clearUpdateTimer()
self:finish()
end
end
end

function plotActionController:finish()

UIManager:invokeUIMethod('UIPlotActionWin','onFinish')
end

function plotActionController:play(params,isFullOpen)
plotActionController:closeStage()

local groupID=params.groupid
if self.groupID~=nil and self.groupID==groupID then return end
local groupcfg=cfgHelper.get1(cfg_plotactiongroupconfig_get,groupID)
if groupcfg==nil then



return
end


self.groupID=groupID
self.groupCfg=groupcfg


local extraStage=params.extraStage
self.extraStage=extraStage

local stage=groupcfg.screenid

if self.groupCfg.plotBlackInOut~=nil then
local initFunc=function()
plotActionController:showStage(stage)
end
local func=function()
plotActionController:begin(params,isFullOpen)
end
UIManager:showWindow('UIPlotBlackLoadWin',{callback=func,initFunc=initFunc})
else
local func=function()
plotActionController:begin(params,isFullOpen)
end
plotActionController:showStage(stage,func)
end
end

local loadIndex
function plotActionController:showStage(stageId,callback)

loadIndex=0
local loadBack=function()
loadIndex=loadIndex+1
if loadIndex==2 then

plotActionController.hideScreen(plotActionController.groupCfg.screenhide)
if callback then
callback()
end
end
end
local id=stageId or screenStageType.plotAction



self.stage=fightStage:create(id,loadBack)


if stageId then
UIManager:showWindow("UIFightPrepareLoading",{para=1})
timeEventController.delayDo(1,function()
fightManager.setCameraActive(true,fightCameraMode.fight)
end)
end


self.actionList=plotActionController.initActionList(self.groupCfg.effectlist)

self.imagePoolList=plotActionController.initIamgePool(self.stage,self.groupCfg.imagePool,loadBack)
end

function plotActionController:closeStage(groupID)
local needClear=false
if self.groupID~=nil and(groupID==nil or groupID==self.groupID)then
needClear=true
end
if needClear then

plotActionController.doShowScreen()
self:clear()
end
end



function plotActionController:begin(params,isFullOpen)
self.isPlaying=true
self.isReady=false
self.startTime=Time.realtimeSinceStartup
self.life=self.groupCfg.life/1000
if self.groupCfg.plotBlackInOut~=nil then
self.plotBlackLeaveMark=self.life
self.life=self.life+plotActionController.plotBlackInTime
end

plotActionController:createUpdateTimer()

UIFullStoryBoardControl:showActionWindow(params,isFullOpen)
end

function plotActionController:setReady(flag)
self.isReady=flag
end

function plotActionController:doAction(excuteIndex,effect)
local imageData=self.imagePoolList[effect[1]]
local actionID=effect[2]
local extraParams={}
extraParams.frozenBegin=function(stayTime)
return plotActionController:frozenBegin(excuteIndex,stayTime)
end
extraParams.frozenEnd=function()
plotActionController:frozenEnd()
end
plotActionController.doAcitionComom(self.stage,imageData,actionID,effect[3],effect[4],extraParams)
end

function plotActionController:killAction(effect)
local imageData=self.imagePoolList[effect[1]]
local actionID=effect[2]
plotActionController.killAcitionComom(self.stage,imageData,actionID,effect[3],effect[4])
end

function plotActionController:findAcition(idx)
if self.actionList==nil then return nil end
for i,v in ipairs(self.actionList)do
if v.index==idx then
return v
end
end
return nil
end

function plotActionController:frozenBegin(excuteIndex,stayTime)
if self.frozenData~=nil then return false end
local frozenEndTime=Time.realtimeSinceStartup+stayTime
self.frozenData={frozenEndTime=frozenEndTime,excuteIndex=excuteIndex}
return true
end

function plotActionController:frozenEnd()
if self.frozenData==nil then return end


local lerp=Time.realtimeSinceStartup-self.frozenData.frozenEndTime
if lerp==0 then return end

local excuteIndex=self.frozenData.excuteIndex
for i,v in ipairs(self.actionList)do
if i~=excuteIndex and v.flag~=false and v.isFrozenOffset then
v.eTime=v.eTime+lerp
end
end
if self.plotBlackLeaveMark~=nil then
self.plotBlackLeaveMark=self.plotBlackLeaveMark+lerp
end
self.life=self.life+lerp

self.frozenData=nil
end

function plotActionController:clear()
if self.isPlaying==true then
plotActionController.clearImagePool(self.imagePoolList)
self.imagePoolList=nil
self.isPlaying=nil
self.actionList=nil
self.startTime=nil
self.life=nil
self.plotBlackLeaveMark=nil
self.groupID=nil
self.groupcfg=nil
self.frozenData=nil
end

if self.stage~=nil then
self.stage:close(self.extraStage)
self.stage=nil
end


plotActionController:clearUpdateTimer()
end



function plotActionController.hideScreen(data)

if data~=nil then
if hideScreenData~=nil then
local temp={}
for i,v in ipairs(hideScreenData)do
local same=false
for i2,v2 in ipairs(data)do
if v[1]==v2[1]and v[2]==v2[2]and v[3]==v2[3]then
same=true
break
end
end
if not same then
table.insert(temp,v)
end
end
if#temp>0 then
plotActionController.showScreen(temp)
end
end
else
plotActionController.showScreen(hideScreenData)
end

plotActionController.setHideScreenData(data)

if data then
for i,v in ipairs(data)do
local hideType=v[1]
local param1=v[2]
local param2=v[3]
local func=hideScreecFuncs[hideType]
if func then
func(false,param1,param2)
end
end
end
end

function plotActionController.setHideScreenData(data)
hideScreenData=data
end

function plotActionController.doShowScreen()
if hideScreenData~=nil then


plotActionController.showScreen(hideScreenData)
plotActionController.setHideScreenData(nil)


end
end

function plotActionController.showScreen(data)
if data then
for i,v in ipairs(data)do
local showType=v[1]
local param1=v[2]
local param2=v[3]
local func=hideScreecFuncs[showType]
if func then
func(true,param1,param2)
end
end
end
end








function plotActionController.initActionList(effectList)
local list={}
for i,v in ipairs(effectList)do
local action={}
action.effect=v
if v[3]then
action.sTime=v[3]/1000
else
action.sTime=0
end
if v[4]then
action.eTime=v[4]/1000+action.sTime
end
action.isFrozenOffset=v[5]==1
action.index=i
action.flag=nil
table.insert(list,action)
end
return list
end

local loadIndexs={}
function plotActionController.initIamgePool(stage,imagePool,callback)
local imagePoolList={}
loadIndexs[imagePool]=0
if#imagePool>0 then
for i,v in ipairs(imagePool)do
local imagecfg=cfgHelper.get1(cfg_plotroleimageconfig_get,v)
local d={}
d.imagecfg=imagecfg
local model=plotActionController.getImageModelData(imagecfg.image)
d.modeData=model

local tpos=imagecfg.pos or{0,0,0}
local pos=Vector3.New(tpos[1],tpos[2],tpos[3])
local func=function()
loadIndexs[imagePool]=loadIndexs[imagePool]+1
if loadIndexs[imagePool]>=#imagePool then
loadIndexs[imagePool]=nil
if callback then
callback()
end
end
end
local idx,entity=stage:addEntityEx(pos,model.body,model.componets,imagecfg.scale,imagecfg.flipX,func)
d.pos=pos
d.entity=entity
d.entityIndex=idx

entity:setVisible(false)

table.insert(imagePoolList,d)
end
else
if callback then
callback()
end
end
return imagePoolList
end

function plotActionController.doAcitionComom(stage,imageData,actionID,beginTime,stayTime,extraParams)
local actioncfg=cfgHelper.get1(cfg_plotactionconfig_get,actionID)

if imageData==nil then

if actioncfg.actionTree~=nil then
local func=nil
if actioncfg.actionTree[2]==1 then

if extraParams~=nil and extraParams.frozenBegin~=nil then
local stay=stayTime/1000
local flag=extraParams.frozenBegin(stay)
if flag==true then
func=function()
extraParams.frozenEnd()
end
end
end
end
stage:runBehaviorNoEntity(actioncfg.actionTree[1],func)
end
return
end

local entity=imageData.entity
local entityIndex=imageData.entityIndex
entity:setVisible(true)

if actioncfg.actionTree~=nil then
local func=nil
if actioncfg.actionTree[2]==1 then

if extraParams~=nil and extraParams.frozenBegin~=nil then
local stay=stayTime/1000
local flag=extraParams.frozenBegin(stay)
if flag==true then
func=function()
extraParams.frozenEnd()
end
end
end
end
stage:runBehavior(entityIndex,actioncfg.actionTree[1],func)
end

if actioncfg.talk~=nil then
if imageData.talkid then
entity:stopText(imageData.talkid)
imageData.talkid=nil
end
local stay=stayTime
if stay==nil then
stay=3000
end
stay=stay/1000
imageData.talkid=entity:flowText(flowObjTypo.tip,{strPara=actioncfg.talk,nunPara=nil,stayTime=stay})
end

if actioncfg.actionid~=nil then
entity:runAnimator(actioncfg.actionid)
end

if actioncfg.emotid~=nil then
if imageData.emotid then
entity:stopText(imageData.emotid)
imageData.emotid=nil
end
local stay=stayTime
if stay==nil then
stay=3000
end
stay=stay/1000
imageData.emotid=entity:flowText(flowObjTypo.biaoQing,{strPara=nil,nunPara=actioncfg.emotid,stayTime=stay})
end

if actioncfg.move~=nil then
local movePos=actioncfg.move[1]
local moveTime=actioncfg.move[2]
local endFlipX=actioncfg.move[3]
local func=function()
entity:runAnimator(eAnimationID.stand)
if endFlipX then
entity:flipX(endFlipX)
end
end
local startFlipX=false
local curpos=entity:getPosition()
local lerp=movePos[1]-curpos.x
if lerp>0 then
startFlipX=true
end
entity:moveTo(Vector3.New(movePos[1],movePos[2],movePos[3]),false,moveTime or 1,1,func)
entity:runAnimator(eAnimationID.run)
entity:flipX(startFlipX)
end

if actioncfg.appear~=nil then
local appearType=actioncfg.appear[1]
if appearType==1 then

local effectid=actioncfg.appear[2]
local endFlipX=actioncfg.appear[3]
if effectid~=nil and effectid>0 then
local stay=actioncfg.appear[4]or 1
if stay>0 then
entity:setVisible(false)
local func=function()
entity:setVisible(true)
entity:flipX(endFlipX)
end
timeEventController.delayDo(stay,func)
else
entity:flipX(endFlipX)
end
entity:playEffect(effectid,Vector3.zero,true,true)
else
entity:flipX(endFlipX)
end
elseif appearType==2 then

local effectid=actioncfg.appear[2]
local movePos=actioncfg.appear[3]
local moveTime=actioncfg.appear[4]
local endFlipX=actioncfg.appear[5]
local movefunc=function()
local func=function()
entity:runAnimator(eAnimationID.stand)
entity:flipX(endFlipX)
end
local startFlipX=false
local curpos=entity:getPosition()
local lerp=movePos[1]-curpos.x
if lerp>0 then
startFlipX=true
end
entity:moveTo(Vector3.New(movePos[1],movePos[2],movePos[3]),false,moveTime or 1,1,func)
entity:runAnimator(eAnimationID.run)
entity:flipX(startFlipX)
end
if effectid~=nil and effectid>0 then
local stay=actioncfg.appear[6]or 1
if stay>0 then
timeEventController.delayDo(stay,movefunc)
else
movefunc()
end
entity:playEffect(effectid,Vector3.zero,true,true)
else
movefunc()
end
elseif appearType==3 then

local btName=actioncfg.appear[2]
stage:runBehavior(entityIndex,btName,nil)
end
end

if actioncfg.disappear~=nil then
local disappearType=actioncfg.disappear[1]
if disappearType==1 then

local effectid=actioncfg.disappear[2]
if effectid~=nil and effectid>0 then
local stay=actioncfg.disappear[3]or 1
local func=function()
entity:setVisible(false)
end
if stay>0 then
timeEventController.delayDo(stay,func)
else
func()
end
entity:playEffect(effectid,Vector3.zero,false,true)
else
entity:setVisible(false)
end
elseif disappearType==2 then

local effectid=actioncfg.disappear[2]
local movePos=actioncfg.disappear[3]
local moveTime=actioncfg.disappear[4]
local func=function()
if effectid~=nil and effectid>0 then
local stay=actioncfg.disappear[5]or 1
local func2=function()
entity:setVisible(false)
end
if stay>0 then
timeEventController.delayDo(stay,func2)
else
func2()
end
entity:playEffect(effectid,Vector3.zero,false,true)
else
entity:setVisible(false)
end
end
local startFlipX=false
local curpos=entity:getPosition()
local lerp=movePos[1]-curpos.x
if lerp>0 then
startFlipX=true
end
entity:moveTo(Vector3.New(movePos[1],movePos[2],movePos[3]),false,moveTime or 1,1,func)
entity:runAnimator(eAnimationID.run)
entity:flipX(startFlipX)
elseif disappearType==3 then

local btName=actioncfg.disappear[2]
local func=function()
entity:setVisible(false)
end
stage:runBehavior(entityIndex,btName,func)
end
end
end

function plotActionController.killAcitionComom(stage,imageData,actionID,beginTime,stayTime)

if imageData==nil then
return
end

local entity=imageData.entity
local actioncfg=cfgHelper.get1(cfg_plotactionconfig_get,actionID)

if actioncfg.talk~=nil then
if imageData.talkid then
entity:stopText(imageData.talkid)
imageData.talkid=nil
end
end

if actioncfg.emotid~=nil then
if imageData.emotid then
entity:stopText(imageData.emotid)
imageData.emotid=nil
end
end
end

function plotActionController.getImageModelData(image)
local typo=image[1]
local data=image[2]
if typo==1 then
local model=npcModel:getImageInfoOutSide(data)
return model
elseif typo==2 then
local monsterCfg=cfgHelper.get1(cfg_monsterconfig_get,data)
local model={}
model.componets={}
model.body=monsterCfg.modelid
return model
end
return nil
end

function plotActionController.clearImagePool(poolList)
if poolList~=nil then
for i,v in ipairs(poolList)do
local entity=v.entity



end
end
end


