







def_class("UIWanBaoXunBaoDui_MainWin",UIWindowBase)









function UIWanBaoXunBaoDui_MainWin:bindComponents()

self.adventureTime=UIText.get(self,0)
self.adventureTimeStateRoot=UIObject.get(self,1)
self.btnsroot=UIObject.get(self,2)
self.channelinfo=UIText.get(self,3)
self.channellInfoRoot=UIObject.get(self,4)
self.channelListContent=UIObject.get(self,5)
self.channelroot=UIObject.get(self,6)
self.channelscrollview=UIObject.get(self,7)
self.chat=UIObject.get(self,8)
self.chatContent=UIObject.get(self,9)
self.chatFlexBtn=UIButton.get(self,10)
self.chatItem=UIButton.get(self,11)
self.chatReddot=UIObject.get(self,12)
self.chatScrollView=UIObject.get(self,13)
self.dealBtn=UIButton.get(self,14)
self.demandlist=UIObject.get(self,15)
self.demandroot=UIObject.get(self,16)
self.downArrow=UIObject.get(self,17)
self.extraRewardList=UIObject.get(self,18)
self.extratitleroot=UIText.get(self,19)
self.finishAdventureRoot=UIObject.get(self,20)
self.finishAdventureState=UIText.get(self,21)
self.finishBtn=UIButton.get(self,22)
self.flex_1=UIObject.get(self,23)
self.flex_2=UIObject.get(self,24)
self.giveupBtn=UIButton.get(self,25)
self.guitai=UIObject.get(self,26)
self.mainroot=UIObject.get(self,27)
self.model=UIObject.get(self,28)
self.modelroot=UIObject.get(self,29)
self.openMapBtn=UIButton.get(self,30)
self.openMapLink=UIObject.get(self,31)
self.openMapTxt=UIText.get(self,32)
self.operationName=UIText.get(self,33)
self.quickDispathBtn=UIButton.get(self,34)
self.quicklyFinishBtn=UIButton.get(self,35)
self.recruitBtn=UIButton.get(self,36)
self.retractBtn=UIButton.get(self,37)
self.returnAdventureBtn=UIButton.get(self,38)
self.returnName=UIText.get(self,39)
self.rewardInfoBtn=UIButton.get(self,40)
self.rewardReddot=UIObject.get(self,41)
self.rewardscrollview=UIObject.get(self,42)
self.rewardSpine=UIObject.get(self,43)
self.rewardTitleName=UIText.get(self,44)
self.rewardview=UIObject.get(self,45)
self.Root=UIObject.get(self,46)
self.specialRewardRoot=UIObject.get(self,47)
self.teqiamReddot=UIObject.get(self,48)
self.tequanBtn=UIButton.get(self,49)
self.tequanRoot=UIObject.get(self,50)
self.tequanState=UIObject.get(self,51)
self.texinglist=UIObject.get(self,52)
self.titleroot=UIObject.get(self,53)
self.uiroot=UIObject.get(self,54)

self.chatFlexBtn:setButtonClick(function()self:onChatFlexBtn()end)

self.chatItem:setButtonClick(function()self:onChatItem()end)

self.dealBtn:setButtonClick(function()self:onDealBtn()end)

self.finishBtn:setButtonClick(function()self:onFinishBtn()end)

self.giveupBtn:setButtonClick(function()self:onGiveupBtn()end)

self.openMapBtn:setButtonClick(function()self:onOpenMapBtn()end)

self.quickDispathBtn:setButtonClick(function()self:onQuickDispathBtn()end)

self.quicklyFinishBtn:setButtonClick(function()self:onQuicklyFinishBtn()end)

self.recruitBtn:setButtonClick(function()self:onRecruitBtn()end)

self.retractBtn:setButtonClick(function()self:onRetractBtn()end)

self.returnAdventureBtn:setButtonClick(function()self:onReturnAdventureBtn()end)

self.rewardInfoBtn:setButtonClick(function()self:onRewardInfoBtn()end)

self.tequanBtn:setButtonClick(function()self:onTequanBtn()end)
self.flex={
self.flex_1,
self.flex_2,
}



end


function UIWanBaoXunBaoDui_MainWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.adventureTime);self.adventureTime=nil;
_UIObject_release(self.adventureTimeStateRoot);self.adventureTimeStateRoot=nil;
_UIObject_release(self.btnsroot);self.btnsroot=nil;
_UIObject_release(self.channelinfo);self.channelinfo=nil;
_UIObject_release(self.channellInfoRoot);self.channellInfoRoot=nil;
_UIObject_release(self.channelListContent);self.channelListContent=nil;
_UIObject_release(self.channelroot);self.channelroot=nil;
_UIObject_release(self.channelscrollview);self.channelscrollview=nil;
_UIObject_release(self.chat);self.chat=nil;
_UIObject_release(self.chatContent);self.chatContent=nil;
_UIObject_release(self.chatFlexBtn);self.chatFlexBtn=nil;
_UIObject_release(self.chatItem);self.chatItem=nil;
_UIObject_release(self.chatReddot);self.chatReddot=nil;
_UIObject_release(self.chatScrollView);self.chatScrollView=nil;
_UIObject_release(self.dealBtn);self.dealBtn=nil;
_UIObject_release(self.demandlist);self.demandlist=nil;
_UIObject_release(self.demandroot);self.demandroot=nil;
_UIObject_release(self.downArrow);self.downArrow=nil;
_UIObject_release(self.extraRewardList);self.extraRewardList=nil;
_UIObject_release(self.extratitleroot);self.extratitleroot=nil;
_UIObject_release(self.finishAdventureRoot);self.finishAdventureRoot=nil;
_UIObject_release(self.finishAdventureState);self.finishAdventureState=nil;
_UIObject_release(self.finishBtn);self.finishBtn=nil;
_UIObject_release(self.flex_1);self.flex_1=nil;
_UIObject_release(self.flex_2);self.flex_2=nil;
_UIObject_release(self.giveupBtn);self.giveupBtn=nil;
_UIObject_release(self.guitai);self.guitai=nil;
_UIObject_release(self.mainroot);self.mainroot=nil;
_UIObject_release(self.model);self.model=nil;
_UIObject_release(self.modelroot);self.modelroot=nil;
_UIObject_release(self.openMapBtn);self.openMapBtn=nil;
_UIObject_release(self.openMapLink);self.openMapLink=nil;
_UIObject_release(self.openMapTxt);self.openMapTxt=nil;
_UIObject_release(self.operationName);self.operationName=nil;
_UIObject_release(self.quickDispathBtn);self.quickDispathBtn=nil;
_UIObject_release(self.quicklyFinishBtn);self.quicklyFinishBtn=nil;
_UIObject_release(self.recruitBtn);self.recruitBtn=nil;
_UIObject_release(self.retractBtn);self.retractBtn=nil;
_UIObject_release(self.returnAdventureBtn);self.returnAdventureBtn=nil;
_UIObject_release(self.returnName);self.returnName=nil;
_UIObject_release(self.rewardInfoBtn);self.rewardInfoBtn=nil;
_UIObject_release(self.rewardReddot);self.rewardReddot=nil;
_UIObject_release(self.rewardscrollview);self.rewardscrollview=nil;
_UIObject_release(self.rewardSpine);self.rewardSpine=nil;
_UIObject_release(self.rewardTitleName);self.rewardTitleName=nil;
_UIObject_release(self.rewardview);self.rewardview=nil;
_UIObject_release(self.Root);self.Root=nil;
_UIObject_release(self.specialRewardRoot);self.specialRewardRoot=nil;
_UIObject_release(self.teqiamReddot);self.teqiamReddot=nil;
_UIObject_release(self.tequanBtn);self.tequanBtn=nil;
_UIObject_release(self.tequanRoot);self.tequanRoot=nil;
_UIObject_release(self.tequanState);self.tequanState=nil;
_UIObject_release(self.texinglist);self.texinglist=nil;
_UIObject_release(self.titleroot);self.titleroot=nil;
_UIObject_release(self.uiroot);self.uiroot=nil;
self.flex=nil;
end

















local _this=nil

local CmpChannelSlotItemIndex={
bg=0,
name=1,
stateinfo=2,
reddot=3,
select=4,
unlockinfo=5,
consumeicon=6,
lockroot=7,
stateroot=8,
taskid=9,
flag=10,
}

local CmpChannelConditionAttrSlotItemIndex={
self=0,
name=1,
progressBarRoot=2,
progressBg=3,
progress=4,
curProgress=5,
maxValue=6,
value=7,
reduceimg=8,
reducevalue=9,
}

local CmpChannelTxConditionAttrSlotItemIndex={
bg=0,
name=1,
}

local _dealBtnClickInterval=1.5




function UIWanBaoXunBaoDui_MainWin:onLoaded(...)
self:bindComponents()
_this=self

self.dealBtnClickStamp=0


self:addNotify(notifyConfig.onWanBaoXunBaoDuiUnlockChannel,function(...)self:onWanBaoXunBaoDuiUnlockChannel(...)end)

self:addNotify(notifyConfig.onWanBaoXunBaoDuiAdventureDone,function(...)self:onWanBaoXunBaoDuiAdventureDone(...)end)

self:addNotify(notifyConfig.onWanBaoXunBaoDuiTakeTask,function(...)self:onWanBaoXunBaoDuiTakeTask(...)end)

self:addNotify(notifyConfig.onWanBaoXunBaoDuiGoAdventure,function(...)self:onWanBaoXunBaoDuiGoAdventure(...)end)

self:addNotify(notifyConfig.onWanBaoXunBaoDuiAdventureReturn,function(...)self:onWanBaoXunBaoDuiAdventureReturn(...)end)
end


function UIWanBaoXunBaoDui_MainWin:__delete()
self:unbindComponents()

self:endAllReddotPunchRotation()
end




function UIWanBaoXunBaoDui_MainWin:onShow(argtable,afterOnloaded)
local isnoShowMap=argtable and argtable.noshowMap or false
self.selectChannelIndex,self.selectChannelId,self.isShowMap=wanBaoXunBaoDuiModel:getChannelDefaultSelectIndex()
self:initUI()

dialogueRepeatRemindModel.setRepeatVis(REPEAT_TIME_TYPE.eDay,REPEAT_TYPE.eWBXBDIdleTip,true)


if not isnoShowMap and self.isShowMap then
self:showWindow('UIWanBaoXunBaoDui_MapWin',{channelId=self.selectChannelId})
end

self:playAnimation()
end


function UIWanBaoXunBaoDui_MainWin:onHide()

end

function UIWanBaoXunBaoDui_MainWin:onShowArgRecv()
self:initUI()
self:playAnimation()
end

function UIWanBaoXunBaoDui_MainWin:playAnimation()
if self.tw then
self.tw:Kill()
self.tw=nil
end

UIManager:invokeUIMethod('UIWanBaoXunBaoDui_MenuWin','playSwitchAnimation',10)
self.mainroot:setChildAnchoredPos(0,600)
self.tw=self.mainroot:setChildDOAnchorPosY(145.9,0.2,function()
UIManager:invokeUIMethod('UIWanBaoXunBaoDui_MenuWin','playSwitchAnimation',0)
end)
end














function UIWanBaoXunBaoDui_MainWin:initData()
self.channelDatas,self.channelLen=wanBaoXunBaoDuiModel:getMainWinChannelDatas()
if verifyManager:isHideBusinessActivity()then
local channelDatas,channelLen=wanBaoXunBaoDuiModel:getMainWinChannelDatas()
self.channelDatas,self.channelLen=table.deepCopy(channelDatas),channelLen
for i=#self.channelDatas,1,-1 do
if self.channelDatas[i].channel_Id==11 then
table.remove(self.channelDatas,i)
end
end
self.selectChannelIndex=self.selectChannelIndex>#self.channelDatas and 1 or self.selectChannelIndex
end
self.selectChannelData=self.channelDatas[self.selectChannelIndex]
end

function UIWanBaoXunBaoDui_MainWin:initUI()
self:initData()
self:freshExplorationChannel()
self:freshRewardDisplay()
self:freshChannelConditionPanel()
self:startChannelCountDown()
self:freshBtnsRoot()
self:freshJWRoot()
self:freshTeQuanBtn()
end

function UIWanBaoXunBaoDui_MainWin:refreshChannelSelectEmployee(channelId)
if self.selectChannelData.channel_Id==channelId then
self:initData()
self:freshBtnsRoot()
self:freshRewardDisplay()
self:freshChannelConditionPanel()
end
end

function UIWanBaoXunBaoDui_MainWin:freshExplorationChannel()
local channelNumber=self.channelLen
local channelDatas=self.channelDatas
local adventureChannelNum=wanBaoXunBaoDuiModel:getAdventureChannelNum()

self.channelinfo:setText(FMT.fmt("({0}/{1})",adventureChannelNum,channelNumber))

self.channelListContent:setChildLayoutGroupCreateItems(#self.channelDatas,function(index)
local data=channelDatas[index]
local item=self.channelListContent:getChildLayoutGroupGridItem(index-1)

self:freshSingleChannel(item,data,self.selectChannelIndex==index)

item:SetChildNewBieComponentId(-1,FMT.fmt('UIWanBaoXunBaoDui_RecruitWin.channel_{0}',index))


item:SetBaseItemClickEvent(-1,function()
if data.isShow and data.open_state then
local preitem=self.channelListContent:getChildLayoutGroupGridItem(self.selectChannelIndex-1)
self:freshSingleChannel(preitem,self.selectChannelData,false)

if self.channelDatas[self.selectChannelIndex].bt_num>0 then
UIManager:invokeUIMethod('UIWanBaoXunBaoDui_MTSceneWin','resetCrew')
self.channelDatas[self.selectChannelIndex].bt_num=0
end

self.selectChannelIndex=index
self.selectChannelId=data.channel_Id
self.selectChannelData=data


self:freshSingleChannel(item,self.selectChannelData,true)

if data.channel_state==WBXBD_Channel_STATE.idle then
UIFullWanBaoXunBaoDuiController:showWindow(
"UIWanBaoXunBaoDui_MapWin",
{channelId=data.channel_Id})
end


self:freshRewardDisplay()

UIManager:invokeUIMethod('UIWanBaoXunBaoDui_MTSceneWin','updataToMainWin',data.channel_Id)

self:freshChannelConditionPanel()

self:startChannelCountDown()

self:freshBtnsRoot()

self:freshJWRoot()
else
local channelCfg=cfgHelper.get1(cfg_catchannelconfig_get,data.channel_Id)
local isTQ=channelCfg.consume and channelCfg.consume[1]==-1

if not isTQ and channelCfg.consume then
if wanBaoXunBaoDuiModel:checkOpenUnlock(data.channel_Id)then
local itemname=itemsConfig.getItemName(channelCfg.consume[1])
local itemIconName=iconHelper.getIconName(channelCfg.consume[1])
local iconStr=chatEmotHelper.getIconEmotMesg(itemIconName,52)
local content=FMT.fmt("是否花费{0} {1} 解锁航道?",iconStr,channelCfg.consume[2])

local func=function()

local hasnum=itemsModel.getCount(channelCfg.consume[1])

if hasnum>=channelCfg.consume[2]then
wanBaoXunBaoDuiController:reqUnlockChannel(data.channel_Id)
else
UIManager.info(FMT.fmt('{0}不足',itemname))
end
end

local func2=function()
local show_data={
type='UIDialougeWithIcon',
title='提示',
content=content,
oktext='确定',
canceltext='取消',
okcallback=func,
moneytypes={{channelCfg.consume[1]}},
}
local dialog=UIDialogManager.newDialog(show_data)
dialog:show()
end


moneySystem:countAndExchange({channelCfg.consume},eMoneyType.mtLingYu,function()
func2()
end,WARNING_TYPE.eWarning,eMoneyType.mtXianYu)
end


else

self:onTequanBtn()
end
end
end)
end)


self.channelscrollview:setChildScrollRectEnable(#self.channelDatas>2)
end

function UIWanBaoXunBaoDui_MainWin:freshSingleChannel(item,data,isSelect)
local channelConfig=cfgHelper.get1(cfg_catchannelconfig_get,data.channel_Id)
local taskConfig

item:SetChildActive(CmpChannelSlotItemIndex.select,isSelect)

local stateInfo
local lockInfo
local lockConsumeItemId
local lockConsumeItemNum
local isShowReddot=false
local taskName
local flagIconName

if data.channel_state>WBXBD_Channel_STATE.idle then
taskConfig=cfgHelper.get1(cfg_catmapconfig_get,data.task_Id)
taskName=taskConfig.name
end

if data.channel_state>WBXBD_Channel_STATE.doing then
flagIconName='button_mmtanxiantp_2'
else
flagIconName='button_mmtanxiantp_1'
end

local fontColor=isSelect and'#f7f7f7'or'#ebd9c8'

if data.channel_state==WBXBD_Channel_STATE.tqlock then

lockInfo='特权开启'

elseif data.channel_state==WBXBD_Channel_STATE.lock then

lockConsumeItemId=channelConfig.consume[1]
lockConsumeItemNum=channelConfig.consume[2]
lockInfo=FMT.fmt('{0}开启',lockConsumeItemNum)

elseif data.channel_state==WBXBD_Channel_STATE.idle then

stateInfo=toColorStringX(fontColor,"前往冒险")

elseif data.channel_state==WBXBD_Channel_STATE.preparing then

stateInfo=toColorStringX(fontColor,"(准备中)")

elseif data.channel_state==WBXBD_Channel_STATE.doing then

stateInfo=toColorStringX(fontColor,"(进行中)")

elseif data.channel_state==WBXBD_Channel_STATE.done then

stateInfo=toColorString(FONT_COLOR.eGreenTxtColor,"(完成)")
isShowReddot=true

elseif data.channel_state==WBXBD_Channel_STATE.early_return then

stateInfo=toColorString(FONT_COLOR.eGreenTxtColor,"(完成)")
isShowReddot=true

elseif data.channel_state==WBXBD_Channel_STATE.finish then

stateInfo=toColorString(FONT_COLOR.eGreenTxtColor,"(完成)")
isShowReddot=true

end

item:SetChildActive(CmpChannelSlotItemIndex.stateinfo,stateInfo~=nil)
item:SetChildActive(CmpChannelSlotItemIndex.reddot,isShowReddot)
item:SetChildActive(CmpChannelSlotItemIndex.name,taskName~=nil)
item:SetChildActive(CmpChannelSlotItemIndex.unlockinfo,lockInfo~=nil)
item:SetChildActive(CmpChannelSlotItemIndex.consumeicon,lockConsumeItemId~=nil)


item:SetChildText(CmpChannelSlotItemIndex.name,toColorStringX(fontColor,taskName))
item:SetChildText(CmpChannelSlotItemIndex.unlockinfo,lockInfo)
item:SetChildText(CmpChannelSlotItemIndex.stateinfo,stateInfo)

item:SetChildCSImageSprite(CmpChannelSlotItemIndex.flag,globalABLookup.wanbaoxunbaodui,flagIconName)

if lockConsumeItemId~=nil then
local itemIconName=iconHelper.getIconName(lockConsumeItemId)

item:SetChildIcon(CmpChannelSlotItemIndex.consumeicon,itemIconName,false)
end

local isEditor=deviceHelper.isRunNoneOrEditor()
item:SetChildActive(CmpChannelSlotItemIndex.taskid,isEditor)
if isEditor then
item:SetChildText(CmpChannelSlotItemIndex.taskid,data.task_Id)
end
end

function UIWanBaoXunBaoDui_MainWin:freshChannelConditionPanel()
local channelConditionData=wanBaoXunBaoDuiModel:getChannelConditionDataByIndex(self.selectChannelData.channel_Id)
self.demandroot:setActive(self.selectChannelData.channel_state>WBXBD_Channel_STATE.idle)
self.specialRewardRoot:setActive(channelConditionData~=nil)
if channelConditionData then

self.demandlist:setChildLayoutGroupCreateItems(#channelConditionData.comditions,function(index)

local data=channelConditionData.comditions[index]
local item=self.demandlist:getChildLayoutGroupGridItem(index-1)
local showReduce=data.maxValue==nil and(data.reduceTili and data.reduceTili>0)or false

item:SetChildText(CmpChannelConditionAttrSlotItemIndex.name,FMT.fmt("{0}:",data.name))

item:SetChildActive(CmpChannelConditionAttrSlotItemIndex.value,not data.maxValue)
item:SetChildActive(CmpChannelConditionAttrSlotItemIndex.progressBarRoot,data.maxValue and true or false)

item:SetChildActive(CmpChannelConditionAttrSlotItemIndex.reduceimg,data.maxValue==nil and showReduce)
item:SetChildActive(CmpChannelConditionAttrSlotItemIndex.reducevalue,data.maxValue==nil and showReduce)

item:SetChildActive(CmpChannelConditionAttrSlotItemIndex.maxValue,data.maxValue~=nil)
item:SetChildActive(CmpChannelConditionAttrSlotItemIndex.curProgress,data.maxValue~=nil)

if data.maxValue~=nil then
item:SetChildUIProgressbar(CmpChannelConditionAttrSlotItemIndex.progressBg,data.value,data.maxValue)
item:SetChildText(CmpChannelConditionAttrSlotItemIndex.maxValue,data.maxValue)
item:SetChildText(CmpChannelConditionAttrSlotItemIndex.curProgress,data.value)
else
item:SetChildText(CmpChannelConditionAttrSlotItemIndex.value,data.value)
if showReduce then
item:SetChildText(CmpChannelConditionAttrSlotItemIndex.reducevalue,data.value-data.reduceTili)
end
end
end)

if channelConditionData.techan then

local spRootWb=self.specialRewardRoot:getWidgetBase()
local techanData=channelConditionData.techan[1]
local techanItemId=techanData[1]
local techanItemNum=techanData[2]

local conf={
itemid=techanItemId,
itemcount=techanItemNum,
showCountBG=true,
showname=false,
gray=channelConditionData.spReachLen>0 and 0 or 1,
}
local propdata=itemsComponentHelper.getCommonFillDataSmall(conf)
spRootWb:SetChildPropData(1,propdata)

local luckValue=channelConditionData.totalProp[WBXBD_Cat_Attr_Type.luck]or 0
spRootWb:SetChildText(2,luckValue)

spRootWb:SetChildActive(3,channelConditionData.spReachLen>0)
spRootWb:SetChildText(4,FMT.fmt('{0}%',channelConditionData.spRewardRate))

spRootWb:SetBaseItemClickEvent(1,function()
itemsComponentHelper.onItemClick(techanItemId)
end)
end

if channelConditionData.txcondition then
self.texinglist:setChildLayoutGroupCreateItems(#channelConditionData.txcondition,function(index)

local data=channelConditionData.txcondition[index]
local item=self.texinglist:getChildLayoutGroupGridItem(index-1)

local name=UIDiscipleModel.getSpecialityNameStr(data.name)
local abName,frameIcon=UIDiscipleModel.getSpecialityColorFrame(data.frame)

item:SetChildText(CmpChannelTxConditionAttrSlotItemIndex.name,name)
item:SetChildGray(CmpChannelTxConditionAttrSlotItemIndex.bg,not data.isReach)
item:SetChildCSImageSprite(CmpChannelTxConditionAttrSlotItemIndex.bg,abName,frameIcon)
item:SetBaseItemClickEvent(-1,function()
self:showWindow('UIWanBaoXunBaoDui_SpeicialWin',{
item=item,
node='bottom',
spid=data.id,
})
end)
end)
end
else

local names={"力量","智慧","灵巧","消耗体力"}
self.demandlist:setChildLayoutGroupCreateItems(4,function(index)

local data=names[index]
local item=self.demandlist:getChildLayoutGroupGridItem(index-1)
item:SetChildText(CmpChannelConditionAttrSlotItemIndex.name,FMT.fmt("{0}:",data))
item:SetChildActive(CmpChannelConditionAttrSlotItemIndex.value,false)
item:SetChildActive(CmpChannelConditionAttrSlotItemIndex.curProgress,false)
item:SetChildActive(CmpChannelConditionAttrSlotItemIndex.maxValue,false)
item:SetChildActive(CmpChannelConditionAttrSlotItemIndex.reduceimg,false)
item:SetChildActive(CmpChannelConditionAttrSlotItemIndex.reducevalue,false)
item:SetChildActive(CmpChannelConditionAttrSlotItemIndex.progressBarRoot,data~="消耗体力")
if data~="消耗体力"then
item:SetChildUIProgressbar(CmpChannelConditionAttrSlotItemIndex.progressBg,0,100)
else
item:SetChildActive(CmpChannelConditionAttrSlotItemIndex.progressBarRoot,false)
end
end)

self.texinglist:setChildLayoutGroupClearAllItems()
end
end

function UIWanBaoXunBaoDui_MainWin:freshRewardDisplay()
local data=self.channelDatas[self.selectChannelIndex]
data=wanBaoXunBaoDuiModel:updateChannelDataByIndex(data.channel_Id)

self.rewardview:setActive(data.channel_state>WBXBD_Channel_STATE.idle)
self.rewardscrollview:setActive(data.channel_state>WBXBD_Channel_STATE.idle)
self.adventureTimeStateRoot:setActive(data.channel_state==WBXBD_Channel_STATE.doing)
self.finishAdventureState:setActive(data.channel_state==WBXBD_Channel_STATE.done)
self.openMapLink:setActive(data.channel_state<=WBXBD_Channel_STATE.idle)
self.extraRewardList:setActive(data.channel_state>WBXBD_Channel_STATE.idle)
self.extratitleroot:setActive(data.channel_state>WBXBD_Channel_STATE.idle)

if data.channel_state>0 then
local title='收获预览'
if data.channel_state==WBXBD_Channel_STATE.preparing then
if data.employeeLen>0 then
title='预计收获'
end
else
title='已收获'
end

self.rewardTitleName:setText(title)

self.rewardscrollview:setChildLayoutGroupCreateItems(#data.reward,function(index)
local item=self.rewardscrollview:getChildLayoutGroupGridItem(index-1)
local baseData=data.reward[index]

item:SetChildActive(-1,baseData~=nil)
if baseData~=nil then
local itemid=baseData[1]
local itemnum=baseData[2]or 0
local range=baseData.range
local gray=baseData.gray

local conf={
itemid=itemid,
itemcount=itemnum>-1 and mathHelper.formatNumber(itemnum)or'',
showCountBG=itemnum>-1 or range~=nil,
showname=false,
range=range,
gray=gray,
}
local propdata=itemsComponentHelper.getCommonFillDataSmall(conf)
local isShowUpRate=baseData.upRate~=nil and baseData.upRate>0

item:SetChildPropData(0,propdata)
item:SetChildActive(1,itemnum==-1)
item:SetChildActive(2,isShowUpRate)
if isShowUpRate then
item:SetChildText(3,FMT.fmt('+{0}%',baseData.upRate))
end
item:SetBaseItemClickEvent(0,itemsComponentHelper.onItemClick)
end
end)

self.extraRewardList:setChildLayoutGroupCreateItems(#data.extraRewrd,function(index)
local item=self.extraRewardList:getChildLayoutGroupGridItem(index-1)
local extraData=data.extraRewrd[index]

item:SetChildActive(-1,extraData~=nil)
if extraData~=nil then
local itemid=extraData[1]
local itemnum=extraData[2]or 0
local range=extraData.range

local sitemnum=mathHelper.formatNumber(itemnum)

local conf={
itemid=itemid,
itemcount=itemnum>0 and sitemnum or'',
showCountBG=itemnum>0 or range~=nil,
showname=false,
range=range
}
local propdata=itemsComponentHelper.getCommonFillDataSmall(conf)

item:SetChildPropData(0,propdata)
item:SetChildActive(1,itemnum==-1)
item:SetChildActive(2,false)
item:SetBaseItemClickEvent(0,itemsComponentHelper.onItemClick)
end
end)
end
end


function UIWanBaoXunBaoDui_MainWin:freshBtnsRoot()
local data=self.channelDatas[self.selectChannelIndex]
self.quickDispathBtn:setActive(data.channel_state==WBXBD_Channel_STATE.preparing
and data.employeeLen~=3)

self.retractBtn:setActive(data.channel_state==WBXBD_Channel_STATE.preparing
and data.employeeLen==3)

self.dealBtn:setActive(data.channel_state==WBXBD_Channel_STATE.preparing)
self.returnAdventureBtn:setActive(data.channel_state==WBXBD_Channel_STATE.doing
or data.channel_state==WBXBD_Channel_STATE.done)

local isShowFinish=data.channel_state==WBXBD_Channel_STATE.finish or data.channel_state==WBXBD_Channel_STATE.early_return
self.finishAdventureRoot:setActive(isShowFinish)
self:doPunchRotation(self.widget,self.rewardReddot:getID(),self.chatEmoreddotIndex,isShowFinish)

local dealBtnTxt=""
if data.channel_state==WBXBD_Channel_STATE.preparing then
dealBtnTxt='出发冒险'
elseif data.channel_state==WBXBD_Channel_STATE.doing then
dealBtnTxt='中途返航'
elseif data.channel_state==WBXBD_Channel_STATE.done then
dealBtnTxt='完成返航'
end
if dealBtnTxt then
self.operationName:setText(dealBtnTxt)
end
self.returnName:setText(dealBtnTxt)

self.giveupBtn:setActive(data.channel_state==WBXBD_Channel_STATE.preparing)
self.quicklyFinishBtn:setActive(data.channel_state==WBXBD_Channel_STATE.doing)
end


function UIWanBaoXunBaoDui_MainWin:freshJWRoot()
local data=self.channelDatas[self.selectChannelIndex]
local isShowChat=data.channel_state>WBXBD_Channel_STATE.preparing and data.log~=nil and#data.log>0
self.chat:setActive(isShowChat)

if isShowChat then
self:setChatContent()
end
end

function UIWanBaoXunBaoDui_MainWin:setChatSize(flex,atOnce)
local height=self.winlua:GetChildSizeDeltaY(self.chatContent:getID())
height=flex and math.max(math.min(height,500),138)or 138
local duration=atOnce and 0 or 0.2
self.winlua:SetStopChildScrollRect(self.chatScrollView:getID())
self.winlua:SetChildDOSizeDelta(self.chatScrollView:getID(),Vector2.New(0,height),duration)
end

function UIWanBaoXunBaoDui_MainWin:setChatContent()
local channelData=self.channelDatas[self.selectChannelIndex]
local chatList=channelData.log
self.chatContent:setChildLayoutGroupCreateItems(#chatList,function(index)
local item=self.chatContent:getChildLayoutGroupGridItem(index-1)
local data=chatList[index]
item:SetChildActive(-1,data~=nil)
if data~=nil and item then
item:SetChildText(0,data.content)
item:SetChildButtonClick(-1,function()self:onClickChat()end,true)
item:ForceLayoutRect(-1)
end
end)
self.chatContent:setChildAnchoredPosition(Vector2.zero)
self.winlua:ForceLayoutRect(self.chatContent:getID())
end

function UIWanBaoXunBaoDui_MainWin:refreshAdventureLog(channel_Id)
local channelData=self.channelDatas[self.selectChannelIndex]
if channelData.channel_Id==channel_Id then
self:initData()
self:freshJWRoot()
end
end







function UIWanBaoXunBaoDui_MainWin:doPunchRotation(widget,componentIndex,reddotIndex,isReddot)
if isReddot then
if self.reddotTweenerList==nil then
self.reddotTweenerList={}
end
if not reddotIndex then
reddotIndex=#self.reddotTweenerList+1
end

if self.reddotTweenerList[reddotIndex]==nil then
widget:SetChildRotation(componentIndex,0,0,0)
local tweener=widget:SetChildDOPunchRotation(componentIndex,Vector3(0,0,15),2,2,1)
tweener:SetEase(_Ease.Linear)
tweener:SetLoops(-1,_LoopType.Restart)
self.reddotTweenerList[reddotIndex]={}
self.reddotTweenerList[reddotIndex].tweener=tweener
self.reddotTweenerList[reddotIndex].widget=widget
self.reddotTweenerList[reddotIndex].componentIndex=componentIndex
end

return reddotIndex
else
if self.reddotTweenerList==nil or not next(self.reddotTweenerList)then
return nil
end
if self.reddotTweenerList[reddotIndex]~=nil then
self.reddotTweenerList[reddotIndex].tweener:Complete()
self.reddotTweenerList[reddotIndex].tweener:Kill()
self.reddotTweenerList[reddotIndex]=nil
widget:SetChildRotation(componentIndex,0,0,0)
return nil
end
end
end


function UIWanBaoXunBaoDui_MainWin:endAllReddotPunchRotation()
if self.reddotTweenerList==nil or not next(self.reddotTweenerList)then
return
end
for i,v in pairs(self.reddotTweenerList)do
if v~=nil then
v.tweener:Complete()
v.tweener:Kill()
local widget=v.widget
local componentIndex=v.componentIndex
widget:SetChildRotation(componentIndex,0,0,0)

self.reddotTweenerList[i]=nil
end
end
end


function UIWanBaoXunBaoDui_MainWin:freshTeQuanBtn()
local tqchannelid=wanbaoXunBaoDuiHelper.getTQChannel()
local channelDatas=wanBaoXunBaoDuiModel:getChannelDatas()
local state=channelDatas[tqchannelid].open_state

if verifyManager:isHideBusinessActivity()then
state=true
end
self.tequanRoot:setActive(not state)
end


function UIWanBaoXunBaoDui_MainWin:startChannelCountDown()
local data=self.channelDatas[self.selectChannelIndex]
local isShow=data.channel_state>WBXBD_Channel_STATE.idle

self.adventureTimeStateRoot:setActive(isShow)
self.finishAdventureState:setActive(isShow)

if isShow then
local server_time=timeHelper.getServerShortTime()
local left
if data.channel_state==WBXBD_Channel_STATE.preparing then
left=cfgHelper.get2(cfg_catmapconfig_get,data.task_Id,'time')
else
left=data.start_time+data.need_time-server_time
end
self.adventureTimeStateRoot:setActive(data.channel_state==WBXBD_Channel_STATE.preparing or data.channel_state==WBXBD_Channel_STATE.doing)
self.finishAdventureState:setActive(data.channel_state>WBXBD_Channel_STATE.early_return)

self:stopChannelCountDown()

if left>0 and data.channel_state>WBXBD_Channel_STATE.preparing then
local stamp=data.start_time+data.need_time

self:stopChannelCountDown()

local func=function()
if self==nil then return end
server_time=server_time+1
local left=stamp-server_time
if left<0 then
left=0


self:stopChannelCountDown()
end
self.adventureTime:setText(FMT.fmt("{0}",timeHelper.format_time_stamp3(left)))
end
self.timer=self:setTimer(1,0,func)
func()
else
self.adventureTime:setText(FMT.fmt("{0}",timeHelper.format_time_stamp3(left)))
end
end
end

function UIWanBaoXunBaoDui_MainWin:stopChannelCountDown()
if self.timer then
self:stopTimerByID(self.timer)
end
self.timer=nil
end


function UIWanBaoXunBaoDui_MainWin:onWanBaoXunBaoDuiAdventureDone(data)
if self.selectChannelData.channel_Id==data.channel_Id then
self:stopChannelCountDown()
self:initUI()
end
end

function UIWanBaoXunBaoDui_MainWin:onWanBaoXunBaoDuiUnlockChannel(channel_id)
self:initUI()
end

function UIWanBaoXunBaoDui_MainWin:onWanBaoXunBaoDuiTakeTask(channel_id,task_id)
self:initUI()
end

function UIWanBaoXunBaoDui_MainWin:onWanBaoXunBaoDuiGoAdventure()
self.giveupBtn:setActive(false)
self.retractBtn:setActive(false)
self.dealBtn:setActive(false)
self.quickDispathBtn:setActive(false)
end

function UIWanBaoXunBaoDui_MainWin:onWanBaoXunBaoDuiAdventureReturn()

end



function UIWanBaoXunBaoDui_MainWin:onQuickDispathBtn()

local channelData=self.channelDatas[self.selectChannelIndex]
if channelData.bt_num==0 then
self.isJumpQuickDispatch=true
wanBaoXunBaoDuiModel:getQuickFillEmployeeToChannel(self.selectChannelId)
else
wanBaoXunBaoDuiModel:showChannelGoInfoTip(self.selectChannelId)
end
end

function UIWanBaoXunBaoDui_MainWin:onRetractBtn()
local channelData=self.channelDatas[self.selectChannelIndex]
if channelData.bt_num==0 then
wanBaoXunBaoDuiModel:doQuickRetractEmployeeToChannel(self.selectChannelId)
else
wanBaoXunBaoDuiModel:showChannelGoInfoTip(self.selectChannelId)
end
end

function UIWanBaoXunBaoDui_MainWin:onDealBtn()
local clickStamp=timeHelper.getServerShortTime()
if clickStamp-self.dealBtnClickStamp<_dealBtnClickInterval then
return
end
self.dealBtnClickStamp=clickStamp

local channelData=self.channelDatas[self.selectChannelIndex]

if(channelData.filling or channelData.bt_num>0)and self.isJumpQuickDispatch then
wanBaoXunBaoDuiModel:doOperation({
state=WanBaoXunBaoDuiOperationType.QuickDispath,
channelId=channelData.channel_Id
})
self.isJumpQuickDispatch=false
else
wanBaoXunBaoDuiModel:doOperation({
state=WanBaoXunBaoDuiOperationType.DoTask,
channelId=channelData.channel_Id
})
end
end

function UIWanBaoXunBaoDui_MainWin:onReturnAdventureBtn()
local channelData=self.channelDatas[self.selectChannelIndex]

local func=function()
wanBaoXunBaoDuiModel:doOperation({
state=WanBaoXunBaoDuiOperationType.StopTask,
channelId=channelData.channel_Id
})
end

local showdata=
{
type='UIDialouge',
title='提示',
content='是否中途返航？中途返航将放弃之后探险奖励',
oktext='确定',
canceltext='取消',
allowclickBG=true,
okcallback=function(...)
func()
end,
showclosebtn=true,
}
local confirmDialog=UIDialogManager.newDialog(showdata)
confirmDialog:show()
end

function UIWanBaoXunBaoDui_MainWin:onFinishBtn()
local channelData=self.channelDatas[self.selectChannelIndex]

wanBaoXunBaoDuiModel:doOperation({
state=WanBaoXunBaoDuiOperationType.FinishTask,
channelId=channelData.channel_Id
})
end

function UIWanBaoXunBaoDui_MainWin:onChatFlexBtn()
local show=self.winlua:GetChildActiveSelf(self.flex_2:getID())
self.flex_2:setActive(not show)
self:setChatSize(not show)
end

function UIWanBaoXunBaoDui_MainWin:onOpenMapLink()
self:showWindow("UIWanBaoXunBaoDui_MapWin",{channelId=self.selectChannelId})
end

function UIWanBaoXunBaoDui_MainWin:onTequanBtn()
local actList=activitiesModel:getActSubList_subType_doing(SUB_ACTIVITY_TYPE.eHangDaoTeQuan)
local sub_act
if#(actList or{})>0 then
for k,subactinfo in ipairs(actList)do
local actinfo=activitiesModel:getActInfo(subactinfo:getActID())
if actinfo:checkOpen(false)then
sub_act=subactinfo
break
end
end
end

if sub_act==nil then
local pageCfg={
{win='UIWanBaoXunBaoDui_TeQuanWin',tabType=FULL_TAB_TYPE.eWBXBD_TQ,reddotType=REDDIT_SUB_TYPE.sWanBaoXunBaoDui_TQ},
}

UIFullCommonControl:showCommonActWindow_notFull(pageCfg)
else
jumpManager:jump({id=JUMP_TYPE.eActivity,args={subType=sub_act:getSubType(),subid=sub_act:getSubID()}},
function()end,
JUMP_BACK.eNomal)
end
end

function UIWanBaoXunBaoDui_MainWin:onClickChat()
local channelData=self.channelDatas[self.selectChannelIndex]
local chatList=channelData.log

local args={
title="探险见闻",
tips="风平浪静，没有发生什么事情",
datas=chatList,
}

UIFullWanBaoXunBaoDuiController:showWindow("UIWanBaoXunBaoDui_TravelEventWin",args)
end

function UIWanBaoXunBaoDui_MainWin:onRewardInfoBtn()

local d={}

d.title='提示'
d.mode=3
d.name='wbxbd_reward_preview_rule_help_%d'

self:showWindow('UIRuleWin',d)
end

function UIWanBaoXunBaoDui_MainWin:onQuicklyFinishBtn()
local channelData=self.channelDatas[self.selectChannelIndex]
local const_def=wanBaoXunBaoDuiModel:getConstDef()
local itemid=const_def.finish_tx_item
local itemNum=itemsModel.getCount(itemid)
local itemlist={{itemid=itemid,itemcount=itemNum,needcount=1}}

local callback=function()
if itemNum>=1 then
local itemdata=wanBaoXunBaoDuiController:getQuickFinishItemInBag()

wanBaoXunBaoDuiController:reqEarlyReturn(channelData.channel_Id,WBXBD_Adventure_Return_Type.return_useItem,itemdata.itemguid)
else
UIManager.error('道具不足')
gainControl:showGainWin(itemid)
end
end

local itemName=itemsConfig.getItemName(itemid)
local tips=FMT.fmt("是否使用一个[{0}]立即完成探险旅途",toColorStringX('#DB6464',itemName))

local show_data={
type='UIDialougeBuyWithConsume',
title='提示',
oktext='确定',
canceltext='取消',
itemlist=itemlist,
tip=tips,
showclosebtn=true,
okcallback=function()
if _this==nil then return end
callback()
end,
cancelcallback=nil,
closecallback=nil,
canvasindex=5,
}
local dialog=UIDialogManager.newDialog(show_data)
dialog:show()

AudioManager.playOpenUI()
end

function UIWanBaoXunBaoDui_MainWin:onGiveupBtn()
local channelData=self.channelDatas[self.selectChannelIndex]
if channelData.bt_num==0 then
UIDialogManager.getCommonDialog("提示","确定放弃当前探险任务？放弃后当天不再刷新",function()
wanBaoXunBaoDuiController:reqGiveUpAdventure(channelData.channel_Id)
end)
else
UIManager.info('猫猫正在赶来')
end
end

function UIWanBaoXunBaoDui_MainWin:onOpenMapBtn()
self:showWindow("UIWanBaoXunBaoDui_MapWin",{channelId=self.selectChannelId})
end

