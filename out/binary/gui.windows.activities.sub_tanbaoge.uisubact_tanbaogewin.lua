







def_class("UISubAct_tanbaogeWin",UIWindowBase)









function UISubAct_tanbaogeWin:bindComponents()

self.clickMask=UIObject.get(self,0)
self.tanbaoBtnTen=UIButton.get(self,1)
self.tanbaoBtnOne=UIButton.get(self,2)
self.ListPanel=UIObject.get(self,3)
self.tanbaoOneText=UIText.get(self,4)
self.tanbaoOneCost=UIObject.get(self,5)
self.tanbaoOneFreeText=UIText.get(self,6)
self.wishValue=UIText.get(self,7)
self.wishBuffPanel=UIObject.get(self,8)
self.tanbaoTenMoneyImg=UIImage.get(self,9)
self.tanbaoOneMoneyImg=UIImage.get(self,10)
self.nowPos=UIObject.get(self,11)
self.ListContent=UIObject.get(self,12)
self.tanbaoOneMoneyTxt=UIText.get(self,13)
self.tanbaoTenMoneyTxt=UIText.get(self,14)
self.wishClick=UIButton.get(self,15)
self.rewardBtn=UIButton.get(self,16)
self.rankBtn=UIButton.get(self,17)
self.freeBtnReddot=UIObject.get(self,18)
self.wishReddot=UIObject.get(self,19)
self.rankReddot=UIObject.get(self,20)
self.posTips=UIText.get(self,21)
self.wishDoubleKeyBuff=UIObject.get(self,22)
self.wishNextKeyBuff=UIObject.get(self,23)
self.posTipsPanel=UIObject.get(self,24)
self.timeText=UIText.get(self,25)
self.jumpToggle=UIToggleButton.get(self,26)
self.jumpToggleText=UIText.get(self,27)
self.bgModel=UIObject.get(self,28)
self.fgModel=UIObject.get(self,29)
self.wishModel=UIObject.get(self,30)
self.tenBtnReddot=UIObject.get(self,31)
self.isShowReddotBtn=UIButton.get(self,32)

self.tanbaoBtnTen:setButtonClick(function()self:onTanbaoBtnTen()end)

self.tanbaoBtnOne:setButtonClick(function()self:onTanbaoBtnOne()end)

self.wishClick:setButtonClick(function()self:onWishClick()end)

self.rewardBtn:setButtonClick(function()self:onRewardBtn()end)

self.rankBtn:setButtonClick(function()self:onRankBtn()end)

self.isShowReddotBtn:setButtonClick(function()self:onIsShowReddotBtn()end)



end


function UISubAct_tanbaogeWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.clickMask);self.clickMask=nil;
_UIObject_release(self.tanbaoBtnTen);self.tanbaoBtnTen=nil;
_UIObject_release(self.tanbaoBtnOne);self.tanbaoBtnOne=nil;
_UIObject_release(self.ListPanel);self.ListPanel=nil;
_UIObject_release(self.tanbaoOneText);self.tanbaoOneText=nil;
_UIObject_release(self.tanbaoOneCost);self.tanbaoOneCost=nil;
_UIObject_release(self.tanbaoOneFreeText);self.tanbaoOneFreeText=nil;
_UIObject_release(self.wishValue);self.wishValue=nil;
_UIObject_release(self.wishBuffPanel);self.wishBuffPanel=nil;
_UIObject_release(self.tanbaoTenMoneyImg);self.tanbaoTenMoneyImg=nil;
_UIObject_release(self.tanbaoOneMoneyImg);self.tanbaoOneMoneyImg=nil;
_UIObject_release(self.nowPos);self.nowPos=nil;
_UIObject_release(self.ListContent);self.ListContent=nil;
_UIObject_release(self.tanbaoOneMoneyTxt);self.tanbaoOneMoneyTxt=nil;
_UIObject_release(self.tanbaoTenMoneyTxt);self.tanbaoTenMoneyTxt=nil;
_UIObject_release(self.wishClick);self.wishClick=nil;
_UIObject_release(self.rewardBtn);self.rewardBtn=nil;
_UIObject_release(self.rankBtn);self.rankBtn=nil;
_UIObject_release(self.freeBtnReddot);self.freeBtnReddot=nil;
_UIObject_release(self.wishReddot);self.wishReddot=nil;
_UIObject_release(self.rankReddot);self.rankReddot=nil;
_UIObject_release(self.posTips);self.posTips=nil;
_UIObject_release(self.wishDoubleKeyBuff);self.wishDoubleKeyBuff=nil;
_UIObject_release(self.wishNextKeyBuff);self.wishNextKeyBuff=nil;
_UIObject_release(self.posTipsPanel);self.posTipsPanel=nil;
_UIObject_release(self.timeText);self.timeText=nil;
_UIObject_release(self.jumpToggle);self.jumpToggle=nil;
_UIObject_release(self.jumpToggleText);self.jumpToggleText=nil;
_UIObject_release(self.bgModel);self.bgModel=nil;
_UIObject_release(self.fgModel);self.fgModel=nil;
_UIObject_release(self.wishModel);self.wishModel=nil;
_UIObject_release(self.tenBtnReddot);self.tenBtnReddot=nil;
_UIObject_release(self.isShowReddotBtn);self.isShowReddotBtn=nil;
end
















local towerItemIndex={
floorNum=0,
floorNumBg=1,
floorNumSelectBg=2,
normalPanel=3,
specialPanel=4,
rewardGrid=5,
selectItemBg=6,
keyItemBg=7,
keyItemSelectBg=8,
keyItem=9,
specialItem=10,
dzModel=11,
lockMask=12,
specialLockMask=13,
topPanel=14,
bottomPanel=15,
normalItemRoot=16,
specialDzModel=17,
}

local _this
local _order={
eZongMenPostType.eZhangMen,
eZongMenPostType.eChuanGong,
eZongMenPostType.eJieYin,
eZongMenPostType.eJielu,
eZongMenPostType.eZhenYu,
eZongMenPostType.eNeiMen,
eZongMenPostType.eWaiMen,
}

local tanBaoCd=3



function UISubAct_tanbaogeWin:onLoaded(...)
_this=self
self:bindComponents()
self.isSkipAnim=userActorSetting.get('skipTBGLotteryAnim',false)
self.jumpToggle:setToggleChange(function(...)self:onToggleChanged(...)end)
self:freshToggle(self.isSkipAnim)
self.jumpToggleText:setText('跳过动画')

self.ListPanel:setChildScrollViewInit(0,true)

self:addNotify(notifyConfig.onShowPrize,function(...)
self:onShowPrize(...)
end)
self:addNotify(notifyConfig.onSubActivityOverBeforeEndTime24Hour,self.onSubActivityOverBeforeEndTime24Hour)
end


function UISubAct_tanbaogeWin:__delete()
self:clearAnimTimer()
self:closeWindow("UITopMoneyWin6")
userActorSetting.flushVal('skipTBGLotteryAnim',self.isSkipAnim)
self:clearTimer()
self:clearAllTweener()
self:unbindComponents()
_this=nil
end




function UISubAct_tanbaogeWin:onShow(argtable,afterOnloaded)
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
if afterOnloaded then
self.winlua:SetChildUIModelShowTarget(self.bgModel:getID(),5353,1,{},eAnimationID.stand)
self.winlua:SetChildUIModelShowTarget(self.fgModel:getID(),5354,1,{},eAnimationID.stand)
end
self.animTimerList={}


local costItemId=self.config.useItem[1]
self:showWindow("UITopMoneyWin6",{moneys={{costItemId}},offsetX=-372,offsetY=-31})

if not self.activityData then
logErr(FMT.fmt("没有获取到活动id: {0}, 活动类型: {1}, 子活动id: {2}的活动数据",self.activityId,self.subType,self.subId))
return
end
self.beginTime=self.activityData.start_time
self.endTime=self.activityData.end_time




self.tanBaoClickCdTime=0

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
self.goldItemEffectList={}



self:initDzModel()
self.clickMask:setActive(false)
self:refresh(true)

local itemData=self.config.layerList[self.activityData.data.layerIndex]
local isGold=itemData[2]==1
local alpha=isGold and 0 or 1
self.nowPos:setChildCanvasGroupAlpha(alpha)


local npcModelParms=self.config.npcModel
local modelId=npcModelParms[1]
self.wishModel:setChildUIModelShowTarget(modelId,0.2,{},eAnimationID.stand)
self.wishModel:setChildUIModelShowTargetOffset(0,-24)

self:refreshIsShowReddotBtn()


self:setRemainingTimeTimer()
end


function UISubAct_tanbaogeWin:onHide()
self:clearAnimTimer()
self:closeWindow("UITopMoneyWin6")
self:clearTimer()
self:clearAllTweener()
end

function UISubAct_tanbaogeWin:initFloorData()
self.nowFloor=self.activityData.data.layer
self.loopCount=math.ceil(self.nowFloor/self.loopFloorCount)-1
self.loopNumNow=self.activityData.data.layerIndex

self.stepIndex=math.ceil(self.loopNumNow/self.stepFloorCount)-1

end

function UISubAct_tanbaogeWin:refresh(isInit)
self.needRefresh=false
local isSkip=self.isSkipAnim or self.skipAnimFlag_wish or false
self.nowSelectFloor=self.nowFloor
self.nowSelectFloorIndex=self.loopNumNow
if isInit or isSkip then
self:setTanBaoClickCd(true)
self:initFloorData()
if isInit then

self.nowSelectFloor=self.nowFloor
self.nowSelectFloorIndex=self.loopNumNow
end
else
self.nowFloor=self.activityData.data.layer
self.loopNumNow=self.activityData.data.layerIndex
end

local isJump=self.nowSelectFloor~=self.nowFloor
if isSkip or not isJump then

self:refreshTowList(isInit)
end


self:refreshBtnPanel()


self:refreshWishPanel()

end


function UISubAct_tanbaogeWin:refreshPosTips()
local itemData=self.config.layerList[self.activityData.data.layerIndex]
local isGold=itemData[2]==1

if isGold then
return
else
local nowFloorIndex=self.activityData.data.layerIndex%self.stepFloorCount
local deltaFloor=self.stepFloorCount-nowFloorIndex
self.posTips:setText(FMT.fmt("距离黄金层\n还剩 <color=#F7F7F7>{0}</color> 层",deltaFloor))
end
end


function UISubAct_tanbaogeWin:refreshTowList(isInit,ignoreJump)
self:clearAnimTweener()

local count=self.showFloor
self.ListPanel:setChildScrollViewCreateGrids(count,1)
local grids=self.ListPanel:getChildScrollViewItemWidgets()
self.towerItemCount=grids.Count
for i=1,grids.Count do
local floorNum=self.loopCount*self.loopFloorCount+self.stepIndex*self.stepFloorCount+i
local itemIndex=self:getTowerItemIndexByFloor(floorNum)
local item=grids[itemIndex]
local ignoreLoopFloor=self.stepIndex*self.stepFloorCount+i
if ignoreLoopFloor>self.loopFloorCount then
ignoreLoopFloor=ignoreLoopFloor-self.loopFloorCount
end
local itemData=self.config.layerList[ignoreLoopFloor]
if item then
local isSelectFloor=floorNum==self.nowFloor
item:SetChildText(towerItemIndex.floorNum,floorNum)
item:SetChildActive(towerItemIndex.floorNumBg,not isSelectFloor)
item:SetChildActive(towerItemIndex.floorNumSelectBg,isSelectFloor)
local isGold=itemData[2]==1
item:SetChildActive(towerItemIndex.normalPanel,not isGold)
item:SetChildActive(towerItemIndex.specialPanel,isGold)

local isTop=i==grids.Count
local isBottom=i==1
item:SetChildActive(towerItemIndex.topPanel,isTop)
item:SetChildActive(towerItemIndex.bottomPanel,isBottom)

local isLock=floorNum>self.nowFloor
local isOver=floorNum<self.nowFloor

if isGold then

local selectItemList=self.config.zxReward
local canSelectRewardItem=itemData[7]==1
local selectRewardItemId=self.activityData:getSelectRewardItemIdByFloorNum(floorNum)
local hasSelect=not canSelectRewardItem or selectRewardItemId~=nil
local itemWidget=item:GetChildWidgetBase(towerItemIndex.specialItem)

if hasSelect then
local rw
if canSelectRewardItem then
local selectRewardItemCount=1
for _,v in ipairs(selectItemList)do
local itemId=v[1]
local itemCount=v[2]
if itemId==selectRewardItemId then
selectRewardItemCount=itemCount
break
end
end
rw={{selectRewardItemId,selectRewardItemCount,isKey=true}}
else
local rwDropId=itemData[6]
local showItems=cfgHelper.get2(cfg_awardconfig_get,rwDropId,'showItems')or{}
rw=table.weakCopy(showItems)
end

local reward=rw[1]
local itemid=reward[1]
local itemcount=reward[2]
local countStr=''
local showCountBG=false
if itemcount>1 then
showCountBG=true
countStr=mathHelper.formatNumber(itemcount)
end
local isDaoBing=itemsConfig.isDaoBing(itemid)
local showStage=not isDaoBing
local conf={itemid=itemid,itemcount=countStr,showCountBG=showCountBG,showname=false,showStage=showStage}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
prop[PropIndex(DataPropKey.eWidgetActive,7)]=isOver
itemWidget:SetChildPropData(0,prop)
itemWidget:SetBaseItemClickEvent(0,function(...)
self:onClickRewardItem(...)
end)
itemWidget:SetChildActive(-1,true)
itemWidget:SetChildActive(0,true)
itemWidget:SetChildActive(6,isOver)

local isShowChangeBtn=canSelectRewardItem
itemWidget:SetChildActive(4,isShowChangeBtn)
if isShowChangeBtn then
itemWidget:SetChildButtonClick(4,function(...)
return self:onSelectRewardItem(ignoreLoopFloor,floorNum,selectRewardItemId)
end)
end
itemWidget:SetChildActive(1,false)
itemWidget:SetChildActive(3,true)

if not isOver and not self.goldItemEffectList[itemIndex]then
local goldItemEffectId=10608
itemWidget:SetChildShowEffect(5,goldItemEffectId,true)
self.goldItemEffectList[itemIndex]=true
elseif isOver then
itemWidget:SetChildShowEffect(5,0,false)
self.goldItemEffectList[itemIndex]=nil
end
else
itemWidget:SetChildActive(-1,not isOver)
itemWidget:SetChildActive(0,false)
itemWidget:SetChildActive(1,true)
itemWidget:SetChildActive(2,true)
itemWidget:SetChildActive(3,false)
itemWidget:SetChildActive(4,false)
itemWidget:SetChildShowEffect(5,0,false)
itemWidget:SetChildActive(6,false)
self.goldItemEffectList[itemIndex]=nil
itemWidget:SetChildButtonClick(1,function(...)
return self:onSelectRewardItem(ignoreLoopFloor,floorNum)
end,true)
end

item:SetChildCanvasGroupAlpha(towerItemIndex.specialLockMask,1)

item:SetChildActive(towerItemIndex.specialLockMask,false)
else
item:SetChildCanvasGroupAlpha(towerItemIndex.normalItemRoot,1)
item:SetChildLocalPosY(towerItemIndex.normalItemRoot,-15)


item:SetChildActive(towerItemIndex.keyItemBg,not isSelectFloor)
item:SetChildActive(towerItemIndex.keyItemSelectBg,isSelectFloor)

local keyItemId=itemData[1]

local rwDropId=itemData[6]
local showItems=cfgHelper.get2(cfg_awardconfig_get,rwDropId,'showItems')or{}
local rw={}
for i,v in ipairs(showItems)do
local itemId=v[1]
if itemId~=keyItemId then
rw[#rw+1]=v
end
end
item:SetChildLayoutGroupCreateItems(towerItemIndex.rewardGrid,#rw)
local rewardGrids=item:GetChildLayoutGroupGridList(towerItemIndex.rewardGrid)
for i=1,#rw do
local widget=rewardGrids[i-1]
local reward=rw[i]
local itemid=reward[1]
local itemcount=reward[2]
local countStr=''
local showCountBG=false
if itemcount>1 then
showCountBG=true
countStr=mathHelper.formatNumber(itemcount)
end
local isDaoBing=itemsConfig.isDaoBing(itemid)
local showStage=not isDaoBing
local conf={itemid=itemid,itemcount=countStr,showCountBG=showCountBG,showname=false,showStage=showStage}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
prop[PropIndex(DataPropKey.eWidgetActive,7)]=isOver
widget:SetChildActive(-1,true)
widget:SetChildPropData(0,prop)
widget:SetChildShowEffect(2,0,false)

widget:SetBaseItemClickEvent(0,function(...)
self:onClickRewardItem(...)
end)
widget:SetChildActive(3,isOver)
end


local keyItem=showItems[1]
local keyItemid=keyItem[1]
local keyItemCount=keyItem[2]
local keyItemCountStr=''
local showCountBG=false
if keyItemCount>1 then
showCountBG=true
keyItemCountStr=mathHelper.formatNumber(keyItemCount)
end
local isDaoBing=itemsConfig.isDaoBing(keyItemid)
local showStage=not isDaoBing
local keyItemConf={itemid=keyItemid,itemcount=keyItemCountStr,showCountBG=showCountBG,showname=false,showStage=showStage}
local keyItemProp=itemsComponentHelper.getCommonFillDataSmall(keyItemConf)
local keyItemWidget=item:GetChildWidgetBase(towerItemIndex.keyItem)
keyItemWidget:SetChildActive(-1,true)
keyItemProp[PropIndex(DataPropKey.eWidgetActive,7)]=isOver
keyItemWidget:SetChildPropData(0,keyItemProp)
keyItemWidget:SetBaseItemClickEvent(0,function(...)
self:onClickRewardItem(...)
end)
keyItemWidget:SetChildShowEffect(3,0,false)
keyItemWidget:SetChildActive(4,isOver)


item:SetChildCanvasGroupAlpha(towerItemIndex.lockMask,1)
item:SetChildActive(towerItemIndex.lockMask,isLock)
end


local dzModelIndex=isGold and towerItemIndex.specialDzModel or towerItemIndex.dzModel
if isSelectFloor then
local isSkip=self.isSkipAnim or self.skipAnimFlag_wish or false
if(not self.showDzItemIndex or self.showDzItemIndex~=itemIndex)and(isSkip or self.nowSelectFloor==self.nowFloor)then
local fadeInTime=isSkip and 0 or 0.5
item:SetChildUIModelShowTarget(dzModelIndex,self.dzModelParams.body,0.6,self.dzModelParams.componets,eAnimationID.stand,false,false,0)
if isSkip then
item:SetChildCanvasGroupAlpha(dzModelIndex,1)
else
item:SetChildCanvasGroupDOFade(dzModelIndex,1,fadeInTime)
end
self.showDzItemIndex=itemIndex
local initData={
winName="UISubAct_tanbaogeWin",
dzFloorWidget=item,
dzModelIndex=dzModelIndex,
stateId=0,
}
self.showDzBt=behaviorManager:addBehaviorTree('bt_ui_act_tbg_xiaoren',{},true,initData)
end
else
item:SetChildUIModelRemoveTarget(dzModelIndex)
if self.showDzItemIndex and self.showDzItemIndex==itemIndex then
self.showDzItemIndex=nil

if self.showDzBt then
local bt=self.showDzBt
self.showDzBt=nil
behaviorManager:removeBehaviorTree(bt)
end
end
end
end
end

if not ignoreJump then
self:JumpToNowFloor(isInit)
end
end

function UISubAct_tanbaogeWin:JumpToNowFloor(isInit)


self:dzModelJumpToNowFloor(isInit)







end


function UISubAct_tanbaogeWin:testDzBtByStateId(stateId)

self.showDzBt:setSharedVar("stateId",stateId)
end

function UISubAct_tanbaogeWin:finishDzBt(stateId)
self:clearAnimTimer()

self.showDzBt:setSharedVar("stateId",0)
local rewards=self.showDzBt:getSharedVar("rewards")
local effectData=self.showDzBt:getSharedVar("effectData")
local effectItemList=self.showDzBt:getSharedVar("effectItemList")
local isHideDrawBtn=self.showDzBt:getSharedVar("isHideDrawBtn")
local widget=self.showDzBt:getSharedVar("dzFloorWidget")
local delayTime=1

self.nowPos:setChildCanvasGroupDOFade(0,0.5)
if stateId==1 then

local showItemIndexList_lookup={}
local showEffectIndexList={}

if not self.itemTypeList_lookup or not next(self.itemTypeList_lookup)then
self:initItemTypeList()
end

local itemData=self.config.layerList[self.nowSelectFloorIndex]
local keyItemId=itemData[1]
local rwDropId=itemData[6]
local showItems=cfgHelper.get2(cfg_awardconfig_get,rwDropId,'showItems')or{}
local rw={}
for i,v in ipairs(showItems)do
local itemId=v[1]
if itemId~=keyItemId then
local index=#rw+1
rw[index]=v
local itemType=self.itemTypeList_lookup[itemId]
if itemType then
showItemIndexList_lookup[itemType]=index
end
end
end
for i,v in ipairs(rewards)do
local itemId=v.itemid
local itemType=self.itemTypeList_lookup[itemId]
if itemType then
local index=showItemIndexList_lookup[itemType]
if index then
showItemIndexList_lookup[itemType]=nil
showEffectIndexList[index]=true
end
end

if not next(showItemIndexList_lookup)then
break
end
end

local rewardGrids=widget:GetChildLayoutGroupGridList(towerItemIndex.rewardGrid)
for i=1,rewardGrids.Count do
if showEffectIndexList[i]then
local item=rewardGrids[i-1]
item:SetChildShowEffect(2,10582,true)
end
end
delayTime=2
elseif stateId==2 then

local keyItemWidget=widget:GetChildWidgetBase(towerItemIndex.keyItem)
keyItemWidget:SetChildShowEffect(3,10581,true)
self.animTimerList[1]=self:delayDo(0.5,function()
local rewardGrids=widget:GetChildLayoutGroupGridList(towerItemIndex.rewardGrid)
for i=1,rewardGrids.Count do
local item=rewardGrids[i-1]
item:SetChildShowEffect(2,10582,true)
end
end)
self.animTimerList[2]=self:delayDo(2,function()
self.animTweener1=widget:SetChildDOLocalMoveY(towerItemIndex.normalItemRoot,10,2)
self.animTweener2=widget:SetChildCanvasGroupDOFade(towerItemIndex.normalItemRoot,0,2)
end)
delayTime=3
elseif stateId==3 then

local itemWidget=widget:GetChildWidgetBase(towerItemIndex.specialItem)
itemWidget:SetChildShowEffect(5,10581,true)
delayTime=2
end

local finishFunc=function()
if not _this then return end
if stateId==1 then
self.nowPos:setChildCanvasGroupDOFade(1,0.5)
end
self:JumpToNowFloor(false)
self:showPrize(rewards,effectData,effectItemList,isHideDrawBtn)

if stateId==2 then

self.animTimerList[3]=self:delayDo(1,function()
return self:refreshTowList(nil,true)
end)
else
return self:refreshTowList(nil,true)
end
end
self.animTimerList[4]=self:delayDo(delayTime,finishFunc)

end

function UISubAct_tanbaogeWin:initItemTypeList()
self.itemTypeList_lookup={}
local cfg=self.config.showItemTypeList or{}
for typeIndex,itemIdList in ipairs(cfg)do
for _,itemId in ipairs(itemIdList)do
self.itemTypeList_lookup[itemId]=typeIndex
end
end
end

function UISubAct_tanbaogeWin:getDzSpeakText(stateId)
local speakLib
if stateId==1 then
speakLib=self.config.normalNotKeySpeakLib
elseif stateId==2 then
speakLib=self.config.normalKeySpeakLib
elseif stateId==3 then
speakLib=self.config.specialSpeakLib
end

local count=#speakLib
local selectIndex
if count>1 then
selectIndex=math.random(1,count)
else
selectIndex=1
end

local dzSpeakText=speakLib[selectIndex]
self.showDzBt:setSharedVar("dzSpeakText",dzSpeakText)
end

function UISubAct_tanbaogeWin:initDzModel()
self.showDzGuid=nil
local all=UIDiscipleModel:getAllDiscipleDataX()
if all then
local temp={}
for i,v in pairs(all)do
local netData=v.netData.net
if temp[netData.pos]==nil then
temp[netData.pos]=netData
end
end
for i,v in ipairs(_order)do
if temp[v]then
self.showDzGuid=temp[v].discipleguid
break
end
end
if temp[0]and self.showDzGuid==nil then
self.showDzGuid=temp[0].discipleguid
end
end
if self.showDzGuid==nil then
return
end


self.dzModelParams=UIDiscipleModel:getDiscipleOutsideModelInfo(self.showDzGuid,true,nil,nil)
local fadeInTime=0.5






end


function UISubAct_tanbaogeWin:dzModelJumpToNowFloor(isInit,isCallBack)

self.winlua:SetAsLastSibling(self.nowPos:getID())

local isSkip=self.isSkipAnim or self.skipAnimFlag_wish or false
if not isInit and not isSkip then
if isCallBack then

self.nowPos:setChildCanvasGroupDOFade(1,0.5)
end
end

if not isInit and self.nowSelectFloor==self.nowFloor then
self:setTanBaoClickCd(true)
self.clickMask:setActive(false)
return
end
self:clearPosTweener()
local nowFloorItemIndex=self:getTowerItemIndexByFloor(self.nowFloor)
local nowFloorItem=self.ListPanel:getChildScrollViewItemWidget(nowFloorItemIndex)

local nowFloorPos=nowFloorItem:GetChildAnchoredPosition(-1)

local targetFloor=self.nowFloor
local itemData=self.config.layerList[self.loopNumNow]
local isGold=itemData[2]==1
self.nowPos:setChildAnchoredPosition(nowFloorPos)
self:refreshPosTips()
if not isInit and isSkip then
local alpha=isGold and 0 or 1
self.nowPos:setChildCanvasGroupAlpha(alpha)
end

if not isCallBack then
self:JumpToFloorStepPage(targetFloor,isInit)
else
return self:refresh(true)
end
end


function UISubAct_tanbaogeWin:JumpToFloorStepPage(targetFloor,isInit)
if not isInit and self.nowSelectFloor==targetFloor then
self.clickMask:setActive(false)
return
end

self:clearTowerMoveTweener()

if isInit then

if not self.contentHeight then
self.contentHeight=self.ListContent:getChildSizeDeltaY()
end
if not self.showHeight then
self.showHeight=self.ListPanel:getChildSizeDeltaY()
end

local showBottomPos=Vector2.New(0,self.contentHeight-self.showHeight)
self.ListContent:setChildAnchoredPosition(showBottomPos)
self.clickMask:setActive(false)
return
end

local callBack=function()
if not _this then return end
_this.towerMoving=false
_this.needMoveTower=false

_this:clearPosTweener()
return _this:dzModelJumpToNowFloor(nil,true)
end


local targetPosY=0


local targetLoopNum=targetFloor%self.loopFloorCount
if targetLoopNum==0 then
targetLoopNum=self.loopFloorCount
end
local targetStep=math.ceil(targetLoopNum/self.stepFloorCount)-1
if targetStep==self.stepIndex then

local nowPos=self.ListContent:getChildAnchoredPosition()
if nowPos.y==self.contentHeight-self.showHeight then

if self.isSkipAnim or self.skipAnimFlag_wish then
self.clickMask:setActive(false)
return
else
return callBack()
end
else

targetPosY=self.contentHeight-self.showHeight
end
end

if targetStep-self.stepIndex>1 then

logErr(FMT.fmt("当前层数为{0}, 目标跳转层数为{1}, 两者距离已超过一个黄金层间隔, 请确认前端代码是否正确",self.nowFloor,targetFloor))
end


local duration=1


if self.isSkipAnim or self.skipAnimFlag_wish then

local showBottomPos=Vector2.New(0,targetPosY)
self.ListContent:setChildAnchoredPosition(showBottomPos)
else
self.towerMoving=true
self.needMoveTower=true

self:setShowPrizeMoveArgs(targetPosY,duration,callBack)
end
end

function UISubAct_tanbaogeWin:setShowPrizeMoveArgs(targetPosY,duration,callBack)
self.showPrizeCbArgs={targetPosY=targetPosY,duration=duration,callBack=callBack}




end

function UISubAct_tanbaogeWin:checkTowerMove()
if self.showPrizeCbArgs then
local targetPosY=self.showPrizeCbArgs.targetPosY
local duration=self.showPrizeCbArgs.duration
local callBack=self.showPrizeCbArgs.callBack
self.showPrizeCbArgs=nil
self.towerMoveTweener=self.ListContent:setChildDOAnchorPosY(targetPosY,duration,callBack)
end
end


function UISubAct_tanbaogeWin:refreshBtnPanel()







local costItemId=self.config.useItem[1]
local iconName=iconHelper.getIconName(costItemId)
local hasItemCount=itemsModel.getCount(costItemId)or 0
if self.activityData.data.freeNum<self.config.freeNum then
self.tanbaoOneFreeText:setActive(true)
self.freeBtnReddot:setActive(true)
self.tanbaoOneCost:setActive(false)
else
self.freeBtnReddot:setActive(false)
self.tanbaoOneFreeText:setActive(false)
self.tanbaoOneCost:setActive(true)

self.tanbaoOneMoneyImg:setImageIcon(iconName)
local needCount=1
if hasItemCount>=needCount then
self.tanbaoOneMoneyTxt:setText(needCount)
else

self.tanbaoOneMoneyTxt:setText(FMT.cfmt(FONT_COLOR.eRedColor,"{0}",needCount))
end
end

self.tanbaoTenMoneyImg:setImageIcon(iconName)
local needCount=10
self.tenBtnReddot:setActive(hasItemCount>=needCount)
if hasItemCount>=needCount then
self.tanbaoTenMoneyTxt:setText(needCount)
else

self.tanbaoTenMoneyTxt:setText(FMT.cfmt(FONT_COLOR.eRedColor,"{0}",needCount))
end
end


function UISubAct_tanbaogeWin:refreshWishPanel()
local hopeVal=math.floor(self.activityData.data.hopeVal/100)
self.wishValue:setText(hopeVal)
local isShowWishReddot=hopeVal>=100
self.wishReddot:setActive(isShowWishReddot)


local isShowJumpGoldFloorTips=self.activityData.data.jmpGoldFlag and self.activityData.data.jmpGoldFlag==1 or false
if isShowJumpGoldFloorTips then
self:showJumpToNextGoldFloorTips()
end


local isShowDoubleLayer=self.activityData.data.doubleLayer and self.activityData.data.doubleLayer>0 or false

if isShowDoubleLayer then
local widget=self.wishDoubleKeyBuff:getWidgetBase()
widget:SetChildText(0,self.activityData.data.doubleLayer)
end


local itemData=self.config.layerList[self.activityData.data.layerIndex]
local isGold=itemData[2]==1
local isShowNextMustKey=not isGold and(self.activityData.data.nextMustKeyCount and self.activityData.data.nextMustKeyCount>0 or false)

if isShowNextMustKey then
local widget=self.wishNextKeyBuff:getWidgetBase()
local itemWidget=widget:GetChildWidgetBase(0)

local keyItemId=itemData[1]
local keyItemCountStr=''
local isDaoBing=itemsConfig.isDaoBing(keyItemId)
local showStage=not isDaoBing
local keyItemConf={itemid=keyItemId,itemcount=keyItemCountStr,showCountBG=false,showname=false,showStage=showStage}
local keyItemProp=itemsComponentHelper.getCommonFillDataSmall(keyItemConf)
itemWidget:SetChildPropData(0,keyItemProp)
itemWidget:SetBaseItemClickEvent(0,function(...)
self:onClickRewardItem(...)
end)
end

if isShowDoubleLayer and isShowNextMustKey then
if not self.wishBuffTweener and not self.wishBuffShowTimer then
if not self.showBuffIndex then
self.showBuffIndex=1
end
self.wishDoubleKeyBuff:setActive(self.showBuffIndex==1)
self.wishNextKeyBuff:setActive(self.showBuffIndex==2)
local showTime=2
self.wishBuffPanel:setChildCanvasGroupAlpha(1)
self.wishBuffShowTimer=self:delayDo(showTime,function()
return self:changeWishBuffShow()
end)
end
else
self:clearWishBuffTweenerAndTimer()
self.wishBuffPanel:setChildCanvasGroupAlpha(1)
self.wishDoubleKeyBuff:setActive(isShowDoubleLayer)
self.wishNextKeyBuff:setActive(isShowNextMustKey)
self.showBuffIndex=nil
end
end

function UISubAct_tanbaogeWin:changeWishBuffShow(isFadeIn)
if not self.showBuffIndex then
return
end

local duration=0.5
local maxIndex=2
if isFadeIn then
self.showBuffIndex=self.showBuffIndex+1
if self.showBuffIndex>maxIndex then
self.showBuffIndex=1
end

self.wishDoubleKeyBuff:setActive(self.showBuffIndex==1)
self.wishNextKeyBuff:setActive(self.showBuffIndex==2)
self.wishBuffPanel:setChildCanvasGroupAlpha(0)
self:clearWishBuffTweenerAndTimer()
self.wishBuffTweener=self.wishBuffPanel:setChildCanvasGroupDOFade(1,duration,function()
if not _this then return end
self:clearWishBuffTweenerAndTimer()
return self:refreshWishPanel()
end)
else
self.wishBuffPanel:setChildCanvasGroupAlpha(1)
self:clearWishBuffTweenerAndTimer()
self.wishBuffTweener=self.wishBuffPanel:setChildCanvasGroupDOFade(0,duration,function()
if not _this then return end
return self:changeWishBuffShow(true)
end)
end
end


function UISubAct_tanbaogeWin:showJumpToNextGoldFloorTips()
local contentStr='是否晋升至下一个黄金层？'
local show_data={
type='UIDialouge',
title='提示',
content=contentStr,
oktext='确定',
canceltext='取消',
allowclickBG=false,
okcallback=function()
if _this==nil then return end
_this:jumpToNextGoldFloor()
end,
cancelcallback=function()
if _this==nil then return end
_this:cancelJumpToNextGoldFloor()
end,
}
local dialog=UIDialogManager.newDialog(show_data)
dialog:show()

AudioManager.playOpenUI()
end

function UISubAct_tanbaogeWin:setSkipAnimByWish(flag)
self.skipAnimFlag_wish=flag
end


function UISubAct_tanbaogeWin:setRemainingTimeTimer()
self:clearTimer()
local func=function()
local nowTime=gameUtilityModel.getServerShortTime()
local lerp=self.endTime and self.endTime-nowTime or 0
if lerp>0 then

self.timeText:setText(FMT.fmt("活动时间：{0}",timeHelper.format_time_stamp11(lerp,true)))
else
self.timeText:setText("活动已结束")
UIManager.error("活动已结束")
self:clearTimer()
end
end
func()
self.timer=self:setTimer(1,0,func)
end


function UISubAct_tanbaogeWin:clearTimer()
if self.timer then
self:stopTimerByID(self.timer)
self.timer=nil
end
end


function UISubAct_tanbaogeWin:getTowerItemIndexByFloor(floor)
local index=floor-(self.loopCount*self.loopFloorCount+self.stepIndex*self.stepFloorCount)
local itemIndex=self.towerItemCount-index
return itemIndex
end


function UISubAct_tanbaogeWin:getThisStepGoldFloorIndex()
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

function UISubAct_tanbaogeWin:clearAllTweener()
self:clearPosTweener()
self:clearTowerMoveTweener()
self:clearWishBuffTweenerAndTimer()
self:clearAnimTweener()
end

function UISubAct_tanbaogeWin:clearPosTweener()
if self.posTweener then
local tweener=self.posTweener
self.posTweener=nil
tweener:Complete()
tweener:Kill()
end
self.posMoving=false
end

function UISubAct_tanbaogeWin:clearTowerMoveTweener()
if self.towerMoveTweener then
self.towerMoveTweener:Complete()
self.towerMoveTweener:Kill()
self.towerMoveTweener=nil
end
self.towerMoving=false
end

function UISubAct_tanbaogeWin:clearAnimTweener()
if self.animTweener1 then
self.animTweener1:Complete()
self.animTweener1:Kill()
self.animTweener1=nil
end

if self.animTweener2 then
self.animTweener2:Complete()
self.animTweener2:Kill()
self.animTweener2=nil
end
end

function UISubAct_tanbaogeWin:clearWishBuffTweenerAndTimer()
if self.wishBuffTweener then
self.wishBuffTweener:Kill()
self.wishBuffTweener=nil
end
if self.wishBuffShowTimer then
self:stopTimerByID(self.wishBuffShowTimer)
end
self.wishBuffShowTimer=nil
end


function UISubAct_tanbaogeWin:clearAnimTimer()
if self.animTimerList and next(self.animTimerList)then
for i,timer in pairs(self.animTimerList)do
self:stopTimerByID(timer)
self.animTimerList[i]=nil
end
end
end


function UISubAct_tanbaogeWin:onClickRewardItem(itemId,index,guid,attach)
if self.towerMoving or self.posMoving then
return
end

if itemId==-1 then
return
end


tipsManager.showTips({itemid=itemId,itemguid=guid,move=TIPS_MOVE_POS.eRight})
end

function UISubAct_tanbaogeWin:onSelectRewardItem(floorIndex,floorNum,selectRewardItemId)
self:showWindow("UISubAct_tanbaoge_selectWin",{act_id=self.activityId,
sub_act_type=self.subType,
sub_act_id=self.subId,
floorIndex=floorIndex,
floorNum=floorNum,
selectRewardItemId=selectRewardItemId})
end


function UISubAct_tanbaogeWin:onTanbaoBtnOne()
if self.towerMoving or self.posMoving then
return
end

if self:IsInTanBaoClickCd()then

return
end


local goldFloorIndex=self:getThisStepGoldFloorIndex()
local itemData=self.config.layerList[goldFloorIndex]
local canSelectRewardItem=itemData[7]==1
local goldFloorNum=self.loopCount*self.loopFloorCount+goldFloorIndex
local selectRewardItemId=self.activityData:getSelectRewardItemIdByFloorNum(goldFloorNum)
local hasSelect=not canSelectRewardItem or selectRewardItemId~=nil
if not hasSelect then
UIManager.error("请先选择黄金层奖励再进行探宝")
return self:onSelectRewardItem(goldFloorIndex,goldFloorNum)
end


if self.activityData.data.freeNum<self.config.freeNum then

self.activityData:reqTanBaoGeDraw_free()
self:setTanBaoClickCd()
else
local callback=function()
self.activityData:reqTanBaoGeDraw_once()
self:setTanBaoClickCd()
end


local costItemId=self.config.useItem[1]
local useCount=self.config.useItem[2]
if not gainControl:showGainWin(costItemId,useCount)then

local flag=dialogueRepeatRemindModel.getRepeatVis(REPEAT_TIME_TYPE.eDay,REPEAT_TYPE.eTanBaoGeUseDialog)
if not flag then
local iconname=iconHelper.getIconName(costItemId)
local iconStr=chatEmotHelper.getIconEmotMesg(iconname,52)
local contentStr=FMT.fmt('是否消耗{0}<color=#7d3b17>{1}</color> 进行1次探宝？',iconStr,useCount)
local show_data={
type='UIDialougeWithIcon',
title='提示',
content=contentStr,
oktext='确定',
canceltext='取消',
choosetext='今日不再提示',
choosecallback=function(flag)
if _this==nil then return end

dialogueRepeatRemindModel.setRepeatVis(REPEAT_TIME_TYPE.eDay,REPEAT_TYPE.eTanBaoGeUseDialog,flag)
end,
okcallback=function()
if _this==nil then return end
callback()
end,
}
local dialog=UIDialogManager.newDialog(show_data)
dialog:show()

AudioManager.playOpenUI()
else
callback()
end
else
UIManager.error(FMT.fmt('{0}不足',itemsConfig.getItemName(costItemId)))
end
end
end


function UISubAct_tanbaogeWin:onTanbaoBtnTen()
if self.towerMoving or self.posMoving then
return
end

if self:IsInTanBaoClickCd()then

return
end


local goldFloorIndex=self:getThisStepGoldFloorIndex()
local itemData=self.config.layerList[goldFloorIndex]
local canSelectRewardItem=itemData[7]==1
local goldFloorNum=self.loopCount*self.loopFloorCount+goldFloorIndex
local selectRewardItemId=self.activityData:getSelectRewardItemIdByFloorNum(goldFloorNum)
local hasSelect=not canSelectRewardItem or selectRewardItemId~=nil
if not hasSelect then
UIManager.error("请先选择黄金层奖励再进行探宝")
return self:onSelectRewardItem(goldFloorIndex,goldFloorNum)
end

local callback=function()
self.activityData:reqTanBaoGeDraw_tenTimes()
self:setTanBaoClickCd()
end


local costItemId=self.config.useItem[1]
local useCount=self.config.useItem[2]*10
if not gainControl:showGainWin(costItemId,useCount)then

local flag=dialogueRepeatRemindModel.getRepeatVis(REPEAT_TIME_TYPE.eDay,REPEAT_TYPE.eTanBaoGeUseDialog)
if not flag then
local iconname=iconHelper.getIconName(costItemId)
local iconStr=chatEmotHelper.getIconEmotMesg(iconname,52)
local contentStr=FMT.fmt('是否消耗{0}<color=#7d3b17>{1}</color> 进行10次探宝？',iconStr,useCount)
local show_data={
type='UIDialougeWithIcon',
title='提示',
content=contentStr,
oktext='确定',
canceltext='取消',
choosetext='今日不再提示',
choosecallback=function(flag)
if _this==nil then return end

dialogueRepeatRemindModel.setRepeatVis(REPEAT_TIME_TYPE.eDay,REPEAT_TYPE.eTanBaoGeUseDialog,flag)
end,
okcallback=function()
if _this==nil then return end
callback()
end,
}
local dialog=UIDialogManager.newDialog(show_data)
dialog:show()

AudioManager.playOpenUI()
else
callback()
end
else
UIManager.error(FMT.fmt('{0}不足',itemsConfig.getItemName(costItemId)))
end
end

function UISubAct_tanbaogeWin:setTanBaoClickCd(isClear)
if isClear then
self.tanBaoClickCdTime=0
else
self.tanBaoClickCdTime=gameUtilityModel.getServerShortTime()+tanBaoCd
end
end

function UISubAct_tanbaogeWin:IsInTanBaoClickCd()
local nowTime=gameUtilityModel.getServerShortTime()
if nowTime-self.tanBaoClickCdTime>0 then
return false
end

return true
end

function UISubAct_tanbaogeWin:onWishClick()

self:showWindow("UISubAct_tanbaoge_wishWin",{act_id=self.activityId,sub_act_type=self.subType,sub_act_id=self.subId})
end

function UISubAct_tanbaogeWin:onRewardBtn()

local floorNumMin=self.loopCount*self.loopFloorCount+self.stepIndex*self.stepFloorCount
local floorNumMax=self.loopCount*self.loopFloorCount+(self.stepIndex+1)*self.stepFloorCount
local floorNumMin_ignoreLoop=self.stepIndex*self.stepFloorCount
local floorNumMax_ignoreLoop=(self.stepIndex+1)*self.stepFloorCount
local args={
activityId=self.activityId,
subType=self.subType,
subId=self.subId,
normalTitle="道具预览",
specialTitle="黄金层",

floorNumMin=floorNumMin,
floorNumMax=floorNumMax,
floorNumMin_ignoreLoop=floorNumMin_ignoreLoop,
}

oneTabScreenController:openTabUI(SEC_FULL_TAB_TYPE.tanbaogeLotteryDetail,args)
end

function UISubAct_tanbaogeWin:onRankBtn()




end


function UISubAct_tanbaogeWin:jumpToNextGoldFloor()
self.activityData:reqTanBaoGe_TLBH_jumpToNextGoldFloor()


self:closeWindow('UISubAct_tanbaoge_wishWin')
end


function UISubAct_tanbaogeWin:cancelJumpToNextGoldFloor()
self.activityData:reqTanBaoGe_TLBH_cancelJumpToNextGoldFloor()
end

function UISubAct_tanbaogeWin:onToggleChanged(name,isToggle,data)
if self.isSkipAnim==isToggle then return end
self.isSkipAnim=isToggle
self:freshToggle(isToggle)
end

function UISubAct_tanbaogeWin:freshToggle(isToggle)
self.jumpToggle:setToggle(isToggle)
end

function UISubAct_tanbaogeWin:onShowPrize(prizeType,rewards,effectData)
if prizeType~=ePrizeType.eTBGReward then
return
end
local isSkip=self.isSkipAnim or self.skipAnimFlag_wish or false

local nowFloorIndex=self.activityData.data.layerIndex
local originalFloorIndex=self.nowSelectFloorIndex
local maxFloorIndex=self.loopFloorCount
local effectItemList={}
local isHideDrawBtn=false
if nowFloorIndex>=originalFloorIndex then
for i=originalFloorIndex,nowFloorIndex do
local itemData=self.config.layerList[i]
if itemData then
local keyItemId=itemData[1]
effectItemList[keyItemId]=true
end
end

local newStepMaxFloor=(self.stepIndex+1)*self.stepFloorCount
if(originalFloorIndex<=newStepMaxFloor and nowFloorIndex>newStepMaxFloor)and not self.isSkipAnim and not self.skipAnimFlag_wish then

isHideDrawBtn=true
end

else
for i=originalFloorIndex,maxFloorIndex do
local itemData=self.config.layerList[i]
if itemData then
local keyItemId=itemData[1]
effectItemList[keyItemId]=true
end
end

for i=1,nowFloorIndex do
local itemData=self.config.layerList[i]
if itemData then
local keyItemId=itemData[1]
effectItemList[keyItemId]=true
end
end
if not self.isSkipAnim and not self.skipAnimFlag_wish then

isHideDrawBtn=true
end
end

local selectCfgList=self.config.zxReward or{}
for i,v in ipairs(selectCfgList)do
local itemId=v[1]
effectItemList[itemId]=true
end

if isSkip then
return self:showPrize(rewards,effectData,effectItemList,isHideDrawBtn)
else
local stateId=1

local itemData=self.config.layerList[self.nowSelectFloorIndex]
local isGold=itemData[2]==1
if isGold then
stateId=3
else

local keyItemId=itemData[1]
for i,v in ipairs(rewards)do
local itemId=v.itemid
if itemId==keyItemId then
stateId=2
break
end
end
end


self.showDzBt:setSharedVar("rewards",rewards)
self.showDzBt:setSharedVar("effectData",effectData)
self.showDzBt:setSharedVar("stateId",stateId)
self.showDzBt:setSharedVar("effectItemList",effectItemList)
self.showDzBt:setSharedVar("isHideDrawBtn",isHideDrawBtn)
self.clickMask:setActive(true)
end
end

function UISubAct_tanbaogeWin:showPrize(rewards,effectData,effectItemList,isHideDrawBtn)
table.sort(rewards,function(a,b)
return a.sortWeight>b.sortWeight
end)

local args={
list=rewards,
effect=effectItemList,
isHideDrawBtn=isHideDrawBtn,
act_id=self.activityId,
sub_act_type=self.subType,
sub_act_id=self.subId,
}
UIManager:showWindow('UISubAct_tanbaoge_prizeWin',args)
end



function UISubAct_tanbaogeWin:refreshIsShowReddotBtn()
local actInfo=activitiesModel:getSubActInfo(self.activityId,self.subType,self.subId)
local isForbiddenShowReddot=actInfo:checkIsForbiddenShowReddot()
self.isShowReddotBtn:setActive(not isForbiddenShowReddot)
if isForbiddenShowReddot then
return
end

local isShowReddot=actInfo:checkIsShowReddot()
local btnWidget=self.isShowReddotBtn:getWidgetBase()
btnWidget:SetChildActive(0,not isShowReddot)
btnWidget:SetChildActive(1,isShowReddot)
end

function UISubAct_tanbaogeWin:onIsShowReddotBtn()
local actInfo=activitiesModel:getSubActInfo(self.activityId,self.subType,self.subId)
local isShowReddot=actInfo:checkIsShowReddot()
isShowReddot=not isShowReddot

actInfo:setIsShowReddot(isShowReddot)
reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,self.subType)
self:refreshIsShowReddotBtn()
end

function UISubAct_tanbaogeWin.onSubActivityOverBeforeEndTime24Hour(actId,subType,subId)
if _this==nil then return end
if _this.activityId==actId and _this.subType==subType and _this.subId==subId then
_this:refreshIsShowReddotBtn()
end
end
