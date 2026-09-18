







def_class("UISubAct_tufaEvent_yccsWin",UIWindowBase)









function UISubAct_tufaEvent_yccsWin:bindComponents()

self.timeText=UIText.get(self,0)
self.title=UIImage.get(self,1)
self.infoText=UIText.get(self,2)
self.rewardList=UIObject.get(self,3)
self.infoBg=UIObject.get(self,4)
self.showModel=UIObject.get(self,5)
self.modelClick=UIButton.get(self,6)
self.caoLingModel=UIObject.get(self,7)
self.xiaoRenModel=UIObject.get(self,8)
self.model={
self.caoLingModel,
self.xiaoRenModel,
}
self.pos_1=UIObject.get(self,9)
self.pos_2=UIObject.get(self,10)
self.pos_3=UIObject.get(self,11)
self.pos_4=UIObject.get(self,12)
self.pos_5=UIObject.get(self,13)
self.pos_6=UIObject.get(self,14)
self.pos_7=UIObject.get(self,15)
self.pos_8=UIObject.get(self,16)
self.pos={
self.pos_1,
self.pos_2,
self.pos_3,
self.pos_4,
self.pos_5,
self.pos_6,
self.pos_7,
self.pos_8,
}
self.caolingEffect=UIObject.get(self,17)
self.xiaorenEffect=UIObject.get(self,18)
self.modelEffect={
self.caolingEffect,
self.xiaorenEffect,
}
self.bgModel=UIObject.get(self,19)

self.modelClick:setButtonClick(function()self:onModelClick()end)



end


function UISubAct_tufaEvent_yccsWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.timeText);self.timeText=nil;
_UIObject_release(self.title);self.title=nil;
_UIObject_release(self.infoText);self.infoText=nil;
_UIObject_release(self.rewardList);self.rewardList=nil;
_UIObject_release(self.infoBg);self.infoBg=nil;
_UIObject_release(self.showModel);self.showModel=nil;
_UIObject_release(self.modelClick);self.modelClick=nil;
_UIObject_release(self.caoLingModel);self.caoLingModel=nil;
_UIObject_release(self.xiaoRenModel);self.xiaoRenModel=nil;
self.model=nil
_UIObject_release(self.pos_1);self.pos_1=nil;
_UIObject_release(self.pos_2);self.pos_2=nil;
_UIObject_release(self.pos_3);self.pos_3=nil;
_UIObject_release(self.pos_4);self.pos_4=nil;
_UIObject_release(self.pos_5);self.pos_5=nil;
_UIObject_release(self.pos_6);self.pos_6=nil;
_UIObject_release(self.pos_7);self.pos_7=nil;
_UIObject_release(self.pos_8);self.pos_8=nil;
self.pos=nil;
_UIObject_release(self.caolingEffect);self.caolingEffect=nil;
_UIObject_release(self.xiaorenEffect);self.xiaorenEffect=nil;
self.modelEffect=nil;
_UIObject_release(self.bgModel);self.bgModel=nil;
end


local _this
local clickModelCd=1.5
















function UISubAct_tufaEvent_yccsWin:onLoaded(...)
_this=self
self:bindComponents()
end


function UISubAct_tufaEvent_yccsWin:__delete()
self:clearAllTimer()
self:resetEffectParent()
self.caoLingModel:setChildCanvasGroupAlpha(0)
self.xiaoRenModel:setChildCanvasGroupAlpha(0)
uiAIManager:removeUIInstance(self.bt_caoLing)
uiAIManager:removeUIInstance(self.bt_xiaoRen)
self.bt_caoLing=nil
self.bt_xiaoRen=nil
self.checkFadeOut={}
self.fadeOutTime={}
self.doFadeInTweener={}
self.doFadeOutTweener={}
self.checkStartPos_x={}
self.checkTargetPos_x={}
self.modelWidget={}
self.modelIndex={}
self.checkTimer={}
self.isClickModel=nil
self:unbindComponents()
_this=nil
end




function UISubAct_tufaEvent_yccsWin:onShow(argtable,afterOnloaded)
if argtable then
if argtable.act_id then
self.activityId=argtable.act_id
end
if argtable.sub_act_type then
self.subType=argtable.sub_act_type
end
if argtable.sub_act_id then
self.subId=argtable.sub_act_id
end
if argtable.parentWin then
self.parentWin=argtable.parentWin
end
end

self.config=activitiesModel:getSubActivityConfig(self.subType,self.subId)

self.activityData=activitiesModel:getSubActInfo(self.activityId,self.subType,self.subId)

if not self.activityData then
logErr(FMT.fmt("没有获取到活动id: {0}, 活动类型: {1}, 子活动id: {2}的活动数据",self.activityId,self.subType,self.subId))
return
end
self.beginTime=self.activityData.start_time
self.endTime=self.activityData.end_time

self.itemList=self.config.showRewards
self.checkFadeOut={}
self.fadeOutTime={}
self.doFadeInTweener={}
self.doFadeOutTweener={}
self.checkStartPos_x={}
self.checkTargetPos_x={}
self.modelWidget={}
self.modelIndex={}
self.checkTimer={}
self.modelEffectCreate={}
self.localPosList=nil
self.isClickModel=nil
local specialPram=self.config.specialPram
if specialPram then
self.xiaoRenDis=specialPram.xiaorenDis
self.caoLingRunSpeed=specialPram.speed
self.routeEndWaitTime_1=specialPram.routeEndWaitTime_1
self.routeEndWaitTime_2=specialPram.routeEndWaitTime_2
self.routeModelSize={}
self.routeModelSize[1]={}
self.routeModelSize[1][1]=specialPram.routeCaoLingSize_1
self.routeModelSize[1][2]=specialPram.routeCaoLingSize_2
self.routeModelSize[2]={}
self.routeModelSize[2][1]=specialPram.routeXiaorenSize_1
self.routeModelSize[2][2]=specialPram.routeXiaorenSize_2
else

logErr(FMT.fmt("没有获取到活动id: {0}, 活动类型: {1}, 子活动id: {2}的特殊参数 请检查配置是否正确",self.activityId,self.subType,self.subId))
end


self:refreshBgModel()

self:refresh()


self:refreshCaoLingRunModel()
self:refreshXiaoRenRunModel()
end


function UISubAct_tufaEvent_yccsWin:onHide()
self:clearAllTimer()
self:resetEffectParent()
self.caoLingModel:setChildCanvasGroupAlpha(0)
self.xiaoRenModel:setChildCanvasGroupAlpha(0)
uiAIManager:removeUIInstance(self.bt_caoLing)
uiAIManager:removeUIInstance(self.bt_xiaoRen)
self.bt_caoLing=nil
self.bt_xiaoRen=nil
end

function UISubAct_tufaEvent_yccsWin:refresh()

local abName="ui/windows/activities/sub_tufaevent/tufaeventact_atlas_pak.ab"
local iconname=self.config.titleImage
if iconname then
self.title:setSprite(abName,iconname)
self.title:setActive(true)
else
self.title:setActive(false)
end


if self.config.infoDesc then
self.infoText:setText(self.config.infoDesc)
self.infoText:setActive(true)
self.infoBg:setActive(true)
else
self.infoText:setActive(false)
self.infoBg:setActive(false)
end


local grids=self.rewardList:getChildCommonLayoutGroupWidgetList()
for i=1,grids.Count do
local widget=grids[i-1]
local reward=self.itemList[i]
if reward then
local itemid=reward[1]
local count=reward[2]
local countStr=''
local showCountBG=false
if count>1 then
showCountBG=true
countStr=mathHelper.formatNumber(count)
end
local conf={itemid=itemid,itemcount=countStr,showCountBG=showCountBG,showname=false}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
widget:SetChildActive(-1,true)
widget:SetChildPropData(0,prop)
widget:SetBaseItemClickEvent(0,function(...)
self:onClickRewardItem(...)
end)
else
widget:SetChildActive(-1,false)
end
end


self.clickAnimIdList={}
local showModelPram=self.config.showModelPram
if showModelPram then
self.showModel:setActive(true)
local modelId=showModelPram.modelId
if modelId then
local offset=showModelPram.offset or{0,0}
local size=showModelPram.size or 1
local animId=showModelPram.animId or eAnimationID.stand
local isFlip=showModelPram.isFlip and showModelPram.isFlip==1 or false
self.showModel:setChildUIModelShowTarget(modelId,size,{},animId,false,false,0.5)
self.showModel:setChildUIModelShowTargetOffset(offset[1],offset[2])
self.showModel:setChildUIModelShowFlipX(isFlip)
else
logErr(FMT.fmt("活动id: {0}, 活动类型: {1}, 子活动id: {2}配置了展示模型参数 但找不到对应的模型id 请检查配置是否正确",self.activityId,self.subType,self.subId))
end

local clickModelPram=self.config.clickModelPram
if not clickModelPram then

self.modelClick:setActive(false)
else
self.modelClick:setActive(true)

local width=clickModelPram.width or 100
local height=clickModelPram.height or 100
self.modelClick:setChildSizeDelta(width,height)

local offset=clickModelPram.offset or{0,0}
self.modelClick:setChildAnchoredPosition(Vector2.New(offset[1],offset[2]))

self.clickAnimIdList=clickModelPram.animIdList
end
else
self.showModel:setActive(false)
end


self:setRemainingTimeTimer()
end


function UISubAct_tufaEvent_yccsWin:refreshCaoLingRunModel()
uiAIManager:removeUIInstance(self.bt_caoLing)
self.bt_caoLing=nil

self.caoLingModel:setChildCanvasGroupAlpha(0)


if not self.localPosList then
self.localPosList=self:getLocalPosList()
end

local modelId=461011
local tran=self.caoLingModel:getCommonComponent('Transform')
local vpos=Vector2.zero
local speed=self.caoLingRunSpeed

local initData={
winName="UISubAct_tufaEvent_yccsWin",
stateId=-1,
pos_1=self.localPosList[1],
pos_2=self.localPosList[2],
pos_3=self.localPosList[3],
pos_4=self.localPosList[4],
pos_5=self.localPosList[5],
pos_6=self.localPosList[6],
pos_7=self.localPosList[7],
pos_8=self.localPosList[8],
runSpeed=speed,
routeEndWaitTime_1=self.routeEndWaitTime_1,
routeEndWaitTime_2=self.routeEndWaitTime_2,
routeIndex=1,
modelBtIndex=1,
isWait=false,
}
local func=function(bt)
self.bt_caoLing=bt
end
uiAIManager:createUIObject('UISubAct_tufaEvent_yccsWin','bt_ui_act_yccs_caoling',INSTANCE_TYPE.eUIDModel,modelId,tran,vpos,initData,nil,func)
end


function UISubAct_tufaEvent_yccsWin:refreshXiaoRenRunModel()
uiAIManager:removeUIInstance(self.bt_xiaoRen)
self.bt_xiaoRen=nil

self.xiaoRenModel:setChildCanvasGroupAlpha(0)


if not self.localPosList then
self.localPosList=self:getLocalPosList()
end

local tran=self.xiaoRenModel:getCommonComponent('Transform')
local vpos=Vector2.zero
local speed=self.caoLingRunSpeed

local initData={
winName="UISubAct_tufaEvent_yccsWin",
stateId=-1,
pos_1=self.localPosList[1],
pos_2=self.localPosList[2],
pos_3=self.localPosList[3],
pos_4=self.localPosList[4],
pos_5=self.localPosList[5],
pos_6=self.localPosList[6],
pos_7=self.localPosList[7],
pos_8=self.localPosList[8],
runSpeed=speed,
routeEndWaitTime_1=self.routeEndWaitTime_1,
routeEndWaitTime_2=self.routeEndWaitTime_2,
routeIndex=1,
modelBtIndex=2,
isWait=false,
}
local func=function(bt)
self.bt_xiaoRen=bt
end


local diziData=UIDiscipleModel:getPlotDiscipleByIndex(3)
if diziData then
local dzId=diziData.discipleguid
uiAIManager:createUIDisciple('UISubAct_tufaEvent_yccsWin','bt_ui_act_yccs_xiaoren',dzId,tran,vpos,initData,nil,func)
end
end

function UISubAct_tufaEvent_yccsWin:getLocalPosList()
local localPostList={}

for i,posItem in ipairs(self.pos)do
local pos=posItem:getChildLocalPosition()
if pos then
localPostList[i]={pos.x,pos.y,pos.z}
end
end

return localPostList
end

function UISubAct_tufaEvent_yccsWin:refreshBgModel()
local bgModelId=self.config.bgModelId
if bgModelId then
local animId=eAnimationID.stand
self.bgModel:setChildUIModelShowTarget(bgModelId,1,{},animId,false,false,0)
self.bgModel:setActive(true)
else
self.bgModel:setActive(false)
self.bgModel:setChildUIModelRemoveTarget()
end
end


function UISubAct_tufaEvent_yccsWin:setRemainingTimeTimer()
self:clearTimer()
local func=function()
local nowTime=gameUtilityModel.getServerShortTime()
local lerp=self.endTime and self.endTime-nowTime or 0
if lerp>0 then

self.timeText:setText(FMT.fmt("<color=#f1ce78>活动剩余时间：</color>{0}",timeHelper.format_time_stamp11(lerp,true)))

else
self.timeText:setText("活动已结束")
UIManager.error("活动已结束")
self:clearTimer()

end
end
func()
self.timer=self:setTimer(1,0,func)
end


function UISubAct_tufaEvent_yccsWin:clearTimer()
if self.timer then
self:stopTimerByID(self.timer)
self.timer=nil
end
end


function UISubAct_tufaEvent_yccsWin:onClickRewardItem(itemId,index,guid,attach)

if itemId==-1 then
return
end
tipsManager.showTips({itemid=itemId,itemguid=guid,move=TIPS_MOVE_POS.eLeft})
end


function UISubAct_tufaEvent_yccsWin:modelBtWait(modelBtIndex,routeIndex)
if not self.waitModelBtList then
self.waitModelBtList={}
end

self.waitModelBtList[modelBtIndex]=routeIndex
if self.waitModelBtList[1]and self.waitModelBtList[2]then

self.waitModelBtList={}

local fadeInStartPos
local fadeInEndPos
if routeIndex==1 then

fadeInStartPos=self.localPosList[1]
fadeInEndPos=self.localPosList[2]
elseif routeIndex==2 then

fadeInStartPos=self.localPosList[5]
fadeInEndPos=self.localPosList[6]
else
logErr(FMT.fmt("没有路线{0}对应的数据 请检查传参是否正确",routeIndex))
return
end
local routeDis=Vector2.Distance(Vector2.New(fadeInStartPos[1],fadeInStartPos[2]),Vector2.New(fadeInEndPos[1],fadeInEndPos[2]))
local dis=self.xiaoRenDis/math.abs(fadeInEndPos[1]-fadeInStartPos[1])*routeDis
local delayTime=dis/self.caoLingRunSpeed

self.bt_caoLing:setSharedVar("stateId",0)

self:clearDelayTimer()
self.delayTimer=self:delayDo(delayTime,function()
_this.bt_xiaoRen:setSharedVar("stateId",0)
end)
end
end

function UISubAct_tufaEvent_yccsWin:changeModelScale(modelBtIndex,routeIndex,modelWidget,modelIndex)
local scale=self.routeModelSize[modelBtIndex][routeIndex]
modelWidget:SetChildUIModelShowScale(modelIndex,scale)

if not self.modelEffectCreate[modelBtIndex]then

self.modelEffect[modelBtIndex]:setChildShowEffect(10196,true)
local modelTransform=modelWidget:GetChildGameObject(modelIndex).transform
local effectTransform=self.modelEffect[modelBtIndex]:getTransform()
effectTransform:SetParent(modelTransform)
self.modelEffectCreate[modelBtIndex]=true
end


local effectScale=120*scale
self.modelEffect[modelBtIndex]:setScale(Vector3.New(effectScale,effectScale,effectScale))
end


function UISubAct_tufaEvent_yccsWin:checkFadeByRouteIndex(modelBtIndex,routeIndex,modelWidget,modelIndex)
self:clearCheckTimer(modelBtIndex)
local fadeInStartPos
local fadeInEndPos
local fadeOutStartPos
local fadeOutEndPos

if routeIndex==1 then

fadeInStartPos=self.localPosList[1]
fadeInEndPos=self.localPosList[2]
fadeOutStartPos=self.localPosList[3]
fadeOutEndPos=self.localPosList[4]
elseif routeIndex==2 then

fadeInStartPos=self.localPosList[5]
fadeInEndPos=self.localPosList[6]
fadeOutStartPos=self.localPosList[7]
fadeOutEndPos=self.localPosList[8]
else
logErr(FMT.fmt("没有路线{0}对应的数据 请检查传参是否正确",routeIndex))
return
end


local fadeInDis=Vector2.Distance(Vector2.New(fadeInStartPos[1],fadeInStartPos[2]),Vector2.New(fadeInEndPos[1],fadeInEndPos[2]))
local fadeInTime=fadeInDis/self.caoLingRunSpeed

local fadeOutDis=Vector2.Distance(Vector2.New(fadeOutStartPos[1],fadeOutStartPos[2]),Vector2.New(fadeOutEndPos[1],fadeOutEndPos[2]))
local fadeOutTime=fadeOutDis/self.caoLingRunSpeed
self.fadeOutTime[modelBtIndex]=fadeOutTime


self:clearDoFadeInTweener(modelBtIndex)
self:clearDoFadeOutTweener(modelBtIndex)
self.doFadeInTweener[modelBtIndex]=self.model[modelBtIndex]:setChildCanvasGroupDOFade(1,fadeInTime)


self.checkStartPos_x[modelBtIndex]=fadeInStartPos[1]
self.checkTargetPos_x[modelBtIndex]=fadeOutStartPos[1]
self.modelWidget[modelBtIndex]=modelWidget
self.modelIndex[modelBtIndex]=modelIndex
self.checkFadeOut[modelBtIndex]=true
local index=modelBtIndex
self.checkTimer[modelBtIndex]=self:setTimer(0.02,0,function()
_this.onCheckFadeOut(index)
end)
end


function UISubAct_tufaEvent_yccsWin:stopCheckFadeOut(modelBtIndex)
self.checkFadeOut[modelBtIndex]=false
self:clearCheckTimer(modelBtIndex)
end


function UISubAct_tufaEvent_yccsWin:clearCheckTimer(modelBtIndex)
if self.checkTimer[modelBtIndex]then
self:stopTimerByID(self.checkTimer[modelBtIndex])
end
end

function UISubAct_tufaEvent_yccsWin.onCheckFadeOut(modelBtIndex)
if not _this.checkFadeOut[modelBtIndex]then
return
end

local modelPos=_this.modelWidget[modelBtIndex]:GetChildLocalPosition(_this.modelIndex[modelBtIndex])
if(modelPos.x-_this.checkStartPos_x[modelBtIndex])*(modelPos.x-_this.checkTargetPos_x[modelBtIndex])>0 then
_this.checkFadeOut[modelBtIndex]=false

_this:clearDoFadeInTweener(modelBtIndex)
_this:clearDoFadeOutTweener(modelBtIndex)
_this.doFadeOutTweener[modelBtIndex]=_this.model[modelBtIndex]:setChildCanvasGroupDOFade(0,_this.fadeOutTime[modelBtIndex])
return _this:clearCheckTimer(modelBtIndex)
end
end

function UISubAct_tufaEvent_yccsWin:clearAllDoFadeTweener()
self:clearDoFadeInTweener(1)
self:clearDoFadeInTweener(2)
self:clearDoFadeOutTweener(1)
self:clearDoFadeOutTweener(2)
end

function UISubAct_tufaEvent_yccsWin:clearDoFadeInTweener(modelBtIndex)
if self.doFadeInTweener[modelBtIndex]then
self.doFadeInTweener[modelBtIndex]:Kill()
self.doFadeInTweener[modelBtIndex]=nil
end
end

function UISubAct_tufaEvent_yccsWin:clearDoFadeOutTweener(modelBtIndex)
if self.doFadeOutTweener[modelBtIndex]then
self.doFadeOutTweener[modelBtIndex]:Kill()
self.doFadeOutTweener[modelBtIndex]=nil
end
end


function UISubAct_tufaEvent_yccsWin:clearAllTimer()
self:clearTimer()
self:clearCheckTimer(1)
self:clearCheckTimer(2)
self:clearAllDoFadeTweener()
self:clearDelayTimer()
self:clearDelayClickTimer()
end

function UISubAct_tufaEvent_yccsWin:clearDelayTimer()
if self.delayTimer then
self:stopTimerByID(self.delayTimer)
end
end

function UISubAct_tufaEvent_yccsWin:clearDelayClickTimer()
if self.delayClickTimer then
self:stopTimerByID(self.delayClickTimer)
end
end

function UISubAct_tufaEvent_yccsWin:resetEffectParent()
local caolingEffectTran=self.caolingEffect:getTransform()
local caoLingModelTran=self.caoLingModel:getTransform()
caolingEffectTran:SetParent(caoLingModelTran)
self.caolingEffect:setChildShowEffect(0,false)
self.caolingEffect:setLocalPos(0,0,0)

local xiaorenEffectTran=self.xiaorenEffect:getTransform()
local xiaoRenModelTran=self.xiaoRenModel:getTransform()
xiaorenEffectTran:SetParent(xiaoRenModelTran)
self.xiaorenEffect:setChildShowEffect(0,false)
self.xiaorenEffect:setLocalPos(0,0,0)
end


function UISubAct_tufaEvent_yccsWin:onModelClick()
if not self.clickAnimIdList or not next(self.clickAnimIdList)then

logErr(FMT.fmt("活动id: {0}, 活动类型: {1}, 子活动id: {2}配置了展示模型点击参数 但找不到对应的点击动作id 请检查配置是否正确",self.activityId,self.subType,self.subId))
return
end


local clickAnimIdCount=#self.clickAnimIdList
local animId
if clickAnimIdCount>1 then
local randomIndex=math.random(1,clickAnimIdCount)
animId=self.clickAnimIdList[randomIndex]
else
animId=self.clickAnimIdList[1]
end

if not self.isClickModel then

self.showModel:setChildModelAnimationState(animId)
self:clearDelayClickTimer()
self.isClickModel=true
self.delayClickTimer=self:delayDo(clickModelCd,function()
_this.isClickModel=false
end)
end

end

