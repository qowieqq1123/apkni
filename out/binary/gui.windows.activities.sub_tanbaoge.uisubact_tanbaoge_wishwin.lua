







def_class("UISubAct_tanbaoge_wishWin",UIWindowBase)









function UISubAct_tanbaoge_wishWin:bindComponents()

self.bgModel=UIObject.get(self,0)
self.root=UIObject.get(self,1)
self.clickMask=UIObject.get(self,2)
self.btnGet=UIButton.get(self,3)
self.btnWish=UIButton.get(self,4)
self.wishValue=UIText.get(self,5)
self.jumpToggle=UIToggleButton.get(self,6)
self.itemsRoot=UIObject.get(self,7)
self.jumpToggleText=UIText.get(self,8)
self.item=UIObject.get(self,9)
self.npcModel=UIObject.get(self,10)
self.speakObj=UIObject.get(self,11)
self.speakText=UIText.get(self,12)
self.closeBtn=UIButton.get(self,13)
self.selectPanel=UIObject.get(self,14)
self.selectDescText=UIText.get(self,15)
self.selectEffect=UIObject.get(self,16)
self.canWishCount=UIText.get(self,17)
self.helpBtn=UIButton.get(self,18)
self.fgModel=UIObject.get(self,19)
self.reddot=UIObject.get(self,20)

self.btnGet:setButtonClick(function()self:onBtnGet()end)

self.btnWish:setButtonClick(function()self:onBtnWish()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.helpBtn:setButtonClick(function()self:onHelpBtn()end)



end


function UISubAct_tanbaoge_wishWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.bgModel);self.bgModel=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.clickMask);self.clickMask=nil;
_UIObject_release(self.btnGet);self.btnGet=nil;
_UIObject_release(self.btnWish);self.btnWish=nil;
_UIObject_release(self.wishValue);self.wishValue=nil;
_UIObject_release(self.jumpToggle);self.jumpToggle=nil;
_UIObject_release(self.itemsRoot);self.itemsRoot=nil;
_UIObject_release(self.jumpToggleText);self.jumpToggleText=nil;
_UIObject_release(self.item);self.item=nil;
_UIObject_release(self.npcModel);self.npcModel=nil;
_UIObject_release(self.speakObj);self.speakObj=nil;
_UIObject_release(self.speakText);self.speakText=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.selectPanel);self.selectPanel=nil;
_UIObject_release(self.selectDescText);self.selectDescText=nil;
_UIObject_release(self.selectEffect);self.selectEffect=nil;
_UIObject_release(self.canWishCount);self.canWishCount=nil;
_UIObject_release(self.helpBtn);self.helpBtn=nil;
_UIObject_release(self.fgModel);self.fgModel=nil;
_UIObject_release(self.reddot);self.reddot=nil;
end
















local _this
local wishCd=3
local useHopeVal=100
local wishItemCmpIndex={
itemIcon=0,
bg=1,
selectBg=2,
click=3,
}




function UISubAct_tanbaoge_wishWin:onLoaded(...)
_this=self
self:bindComponents()
self.isToggle=userActorSetting.get('skipTBGWish',false)
self.jumpToggle:setToggleChange(function(...)self:onToggleChanged(...)end)
self:freshToggle(self.isToggle)
self.jumpToggleText:setText('跳过动画')
self.circle=self.winlua:GetChildList(self.itemsRoot:getID())
self.circle:SetTweenEndTime(1)
end


function UISubAct_tanbaoge_wishWin:__delete()
UIManager:invokeUIMethod("UISubAct_tanbaogeWin","setSkipAnimByWish",false)
userActorSetting.flushVal('skipTBGWish',self.isToggle)
self:unbindComponents()
self:clearAllTimer()
_this=nil
end




function UISubAct_tanbaoge_wishWin:onShow(argtable,afterOnloaded)
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
self.biHuBuffCount=#self.config.towerBiHu
self.wishClickCdTime=0

if afterOnloaded then
self.winlua:SetChildUIModelShowTarget(self.bgModel:getID(),5351,1,{},eAnimationID.stand)
end

if not self.activityData then
logErr(FMT.fmt("没有获取到活动id: {0}, 活动类型: {1}, 子活动id: {2}的活动数据",self.activityId,self.subType,self.subId))
return
end
self.beginTime=self.activityData.start_time
self.endTime=self.activityData.end_time
UIManager:invokeUIMethod("UISubAct_tanbaogeWin","setSkipAnimByWish",true)

self:refreshFloorData(true)

self:refresh(true)
end


function UISubAct_tanbaoge_wishWin:onHide()
self:clearAllTimer()

end

function UISubAct_tanbaoge_wishWin:refresh(isInit)
self.clickMask:setActive(false)
self:refreshWishList()


self:refreshNPCModel(isInit)


self:refreshWishVal(isInit)
end

function UISubAct_tanbaoge_wishWin:refreshWishList()
self:initCircle()
end


function UISubAct_tanbaoge_wishWin:refreshWishVal(isInit)

if isInit then
self.showHopeVal=math.floor(self.activityData.data.hopeVal/100)
self:setWishClickCd(true)
end
self.wishValue:setText(self.showHopeVal)

local scale=1
local hasFloat=self.showHopeVal%1~=0
if self.showHopeVal>=1000 then
if hasFloat then
scale=0.64
else
scale=0.8
end
elseif self.showHopeVal<1000 and self.showHopeVal>=100 then
if hasFloat then
scale=0.75
end
elseif self.showHopeVal<100 and self.showHopeVal>=10 then
if hasFloat then
scale=0.9
end
end
self.wishValue:setScale(Vector3.New(scale,scale,scale))


local canWishNum=math.floor(self.showHopeVal/useHopeVal)
self.canWishCount:setText(FMT.fmt("许愿次数：{0}",canWishNum))

self.reddot:setActive(self.showHopeVal>=useHopeVal)
end

function UISubAct_tanbaoge_wishWin:initCircle()
local num=self.biHuBuffCount
self.circle.m_CreateCount=num
self.circle:IntializeEditor()
for i=1,num do
self:freshItem(i)
end
self.circle.IsAutoCircle=true
end

function UISubAct_tanbaoge_wishWin:freshItem(i)
if i==nil then return end
local widget=self.circle:GetItemWidgetByIndex(i)


local biHuIndex=i
local biHuItemCfg=self.config.towerBiHuShow[biHuIndex]
local itemid=biHuItemCfg[1]
local iconName=iconHelper.getIconName(itemid)
widget:SetChildCSImageIcon(wishItemCmpIndex.itemIcon,iconName,true)
widget:SetChildButtonClick(wishItemCmpIndex.click,function(...)
return self:onClickRewardItem(itemid)
end,true)
end

function UISubAct_tanbaoge_wishWin:onPirze(idx)

UIManager.setMoneyMsgShowState(false,true)

self.idx=idx
if not self.isToggle then
self:playAni()
else
self:playEnd()
end
end

function UISubAct_tanbaoge_wishWin:playAni()
self.fgModel:setChildUIModelShowTarget(5350,1,{},eAnimationID.stand)
self.circle:ScrollToIndex(self.idx,3,-1,3)
self.clickMask:setActive(true)
self.isPlay=true
end

function UISubAct_tanbaoge_wishWin:playEnd()
self.isPlay=false
if self.idx then
self.circle:JumpToIndex(self.idx)
end





local num=self.biHuBuffCount
for i=1,num do
self:freshItem(i)
end

self:showSelectBiHuDesc(true,self.idx)

local index=self.idx
local itemList=self.rewardItemList
self:delayDo(1,function()

self:showBiHuPrizeWin(index,itemList)
self.clickMask:setActive(false)
self.fgModel:setChildUIModelRemoveTarget()
end)


activitiesController:sendProtocol(actSendType.eComonReqInfo,self.activityId,self.subType,self.subId)


self:clearEnableCircleTimer()
self.enableCircleTimer=self:delayDo(3,function()
if not self or self.isClose or self.isDrag then return end
self:showSelectBiHuDesc(false)
self.circle.IsAutoCircle=true
end)
end


function UISubAct_tanbaoge_wishWin:onPlayStart()
self:showSelectBiHuDesc(false)
self:clearEnableCircleTimer()
end


function UISubAct_tanbaoge_wishWin:onPlayEnd()
self:playEnd()

end


function UISubAct_tanbaoge_wishWin:onDragStart()
self:showSelectBiHuDesc(false)
self.isDrag=true
self.circle.IsAutoCircle=false
self:clearEnableCircleTimer()
end


function UISubAct_tanbaoge_wishWin:onDragEnd()
self.isDrag=false
self:clearEnableCircleTimer()
self.enableCircleTimer=self:delayDo(3,function()
if not self or self.isClose or self.isDrag then return end
self.circle.IsAutoCircle=true
end)
end

function UISubAct_tanbaoge_wishWin:showSelectBiHuDesc(isShow,index)


local endVal=isShow and 1 or 0
local fadeTime=0.5
self.selectPanel:setChildCanvasGroupDOFade(endVal,fadeTime)



local selectIndex=self.idx
if isShow then

local biHuItemCfg=self.config.towerBiHuShow[index]
self.selectDescText:setText(biHuItemCfg[2])
end

if selectIndex then
local startVal=isShow and 0 or 1
local widget=_this.circle:GetItemWidgetByIndex(selectIndex)

widget:SetChildCanvasGroupDOFade(wishItemCmpIndex.selectBg,endVal,fadeTime)
end
end

function UISubAct_tanbaoge_wishWin:showBiHuPrizeWin(index,list)
self:showWindow("UISubAct_tanbaoge_biHuPrizeWin",{act_id=self.activityId,sub_act_type=self.subType,sub_act_id=self.subId,biHuIndex=index,list=list})
end

function UISubAct_tanbaoge_wishWin:refreshFloorData(isInit)
if isInit then
self.loopFloorCount=#self.config.layerList
self.stepFloorCount=0
for i=1,self.loopFloorCount do
self.stepFloorCount=self.stepFloorCount+1
local isGold=self.config.layerList[i][2]==1
if isGold then
break
end
end

self.showFloor=2*self.stepFloorCount
end

self.nowFloor=self.activityData.data.layer
self.nowSelectFloor=self.nowFloor
self.loopCount=math.ceil(self.nowFloor/self.loopFloorCount)-1
self.loopNumNow=self.activityData.data.layerIndex

self.stepIndex=math.ceil(self.loopNumNow/self.stepFloorCount)-1
end


function UISubAct_tanbaoge_wishWin:getThisStepGoldFloorIndex()
local startFloor=self.loopNumNow
local endFloor=(self.stepIndex+1)*self.stepFloorCount
for i=startFloor,endFloor do
local itemData=self.config.layerList[i]
local isGold=itemData[2]==1
if isGold then
return i
end
end
end



function UISubAct_tanbaoge_wishWin:refreshNPCModel(isInit)
local fadeTime=isInit and 0.5 or 0
self.speakContent=self.config.npcTalk
local npcModelParms=self.config.npcModel
local modelId=npcModelParms[1]
local scale=npcModelParms[2]
local modelOffSet=npcModelParms[3]
self.npcModel:setChildUIModelShowTarget(modelId,scale,{},eAnimationID.stand,false,false,fadeTime)
self.npcModel:setChildUIModelShowTargetOffset(modelOffSet[1],modelOffSet[2])
local isFlip=self.config.isFlip==true
self.npcModel:setChildUIModelShowFlipX(isFlip)



self.npcTalkTime=2
self.npcTalkShowTime=3

if isInit then

self.speakObj:setScale(Vector3.zero)
end


self:delayDo(0.3,function()
self:doSpeaking()
end)
end


function UISubAct_tanbaoge_wishWin:doSpeaking()
self:clearSpeakTimer()


local rand=math.random(1,#self.speakContent)
local speakStr=self.speakContent[rand]
local speed=30
self.speakObj:setChildCanvasGroupAlpha(1)
self.speakText:setChildTrendsTextPlay(speakStr,speed,nil)

self:doTalkAnim()
end


function UISubAct_tanbaoge_wishWin:doTalkAnim()
if self.talkTween~=nil then
self.talkTween:Kill()
self.talkTween=nil
end
self.speakObj:setScale(Vector3.zero)
self:delayDo(0.1,function()
self.speakObj:setChildCanvasGroupAlpha(1)
self.talkTween=self.speakObj:setChildDOScale(1.2,0.2,function()
if _this==nil then return end
_this.talkTween=nil
_this.talkTween=_this.speakObj:setChildDOScale(1,0.1,function()
if _this==nil then return end
_this.talkTween=nil
return _this:talkEnd()
end)
end)
end)
end


function UISubAct_tanbaoge_wishWin:talkEnd()
self:clearSpeakTimer()
self.speakShowTimer=self:delayDo(self.npcTalkShowTime,function()

self.speakObj:setScale(Vector3.zero)

self.speakTimer=self:delayDo(self.npcTalkTime,function()
return self:doSpeaking()
end)
end)
end




function UISubAct_tanbaoge_wishWin:onBtnGet()
end



function UISubAct_tanbaoge_wishWin:onBtnWish()
if self:IsInWishClickCd()then

return
end


if self.showHopeVal<useHopeVal then
UIManager.error("当前许愿值不足")
return
end


local goldFloorIndex=self:getThisStepGoldFloorIndex()
local itemData=self.config.layerList[goldFloorIndex]
local canSelectRewardItem=itemData[7]==1
local goldFloorNum=self.loopCount*self.loopFloorCount+goldFloorIndex
local selectRewardItemId=self.activityData:getSelectRewardItemIdByFloorNum(goldFloorNum)
local hasSelect=not canSelectRewardItem or selectRewardItemId~=nil
if not hasSelect then
UIManager.error("请先选择黄金层奖励再进行许愿")
return self:onSelectRewardItem(goldFloorIndex,goldFloorNum)
end


self:showSelectBiHuDesc(false)


self:setWishClickCd()
self.activityData:reqTanBaoGeWish()
end

function UISubAct_tanbaoge_wishWin:onCloseBtn()
self:closeSelf()
end

function UISubAct_tanbaoge_wishWin:freshToggle(isToggle)
self.jumpToggle:setToggle(isToggle)
end

function UISubAct_tanbaoge_wishWin:onToggleChanged(name,isToggle,data)
if self.isToggle==isToggle then return end
self.isToggle=isToggle
self:freshToggle(isToggle)
end


function UISubAct_tanbaoge_wishWin:onNPCClick()
self:doSpeaking()
end


function UISubAct_tanbaoge_wishWin:recvWish(rewardIndex,itemList)
self.showHopeVal=self.showHopeVal-useHopeVal
self:refreshWishVal()
self.rewardItemList=itemList or{}
self:onPirze(rewardIndex)
end

function UISubAct_tanbaoge_wishWin:setWishClickCd(isClear)
if isClear then
self.wishClickCdTime=0
else
self.wishClickCdTime=gameUtilityModel.getServerShortTime()+wishCd
end
end

function UISubAct_tanbaoge_wishWin:IsInWishClickCd()
local nowTime=gameUtilityModel.getServerShortTime()
if nowTime-self.wishClickCdTime>0 then
return false
end

return true
end

function UISubAct_tanbaoge_wishWin:onSelectRewardItem(floorIndex,floorNum,selectRewardItemId)
UIManager:invokeUIMethod("UISubAct_tanbaogeWin","onSelectRewardItem",floorIndex,floorNum,selectRewardItemId)
return self:onCloseBtn()
end

function UISubAct_tanbaoge_wishWin:onClickRewardItem(itemId,index,guid,attach)
if itemId==-1 then
return
end

tipsManager.showTips({itemid=itemId,itemguid=guid})
end

function UISubAct_tanbaoge_wishWin:onHelpBtn()
local langId=self.config.ruleLangId or''
local d={}
d.title='规则'
d.mode=3
d.name=langId
self:showWindow('UIRuleWin',d)
end



function UISubAct_tanbaoge_wishWin:clearAllTimer()
self:clearTimer()
self:clearSpeakTimer()

self:clearEnableCircleTimer()
end


function UISubAct_tanbaoge_wishWin:clearTimer()
if self.timer then
self:stopTimerByID(self.timer)
self.timer=nil
end
end


function UISubAct_tanbaoge_wishWin:clearSpeakTimer()
if self.speakTimer then
self:stopTimerByID(self.speakTimer)
self.speakTimer=nil
end

if self.speakShowTimer then
self:stopTimerByID(self.speakShowTimer)
self.speakShowTimer=nil
end
end


function UISubAct_tanbaoge_wishWin:clearModelSpeakAnimTimer()
if self.modelSpeakAnimTimer then
self:stopTimerByID(self.modelSpeakAnimTimer)
self.modelSpeakAnimTimer=nil
end
end


function UISubAct_tanbaoge_wishWin:clearEnableCircleTimer()
if self.enableCircleTimer then
self:stopTimerByID(self.enableCircleTimer)
self.enableCircleTimer=nil
end
end


function UISubAct_tanbaoge_wishWin.jumpToIndex(index)
_this:onPirze(index)
end