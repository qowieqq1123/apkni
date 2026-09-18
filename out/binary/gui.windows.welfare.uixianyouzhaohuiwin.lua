







def_class("UIXianYouZhaoHuiWin",UIWindowBase)









function UIXianYouZhaoHuiWin:bindComponents()

self.bgModel=UIObject.get(self,0)
self.invitationPanel=UIObject.get(self,1)
self.invitedPage=UIObject.get(self,2)
self.targetPage=UIObject.get(self,3)
self.pageBtnList=UIObject.get(self,4)
self.invitedCountText=UIText.get(self,5)
self.copyBtn=UIButton.get(self,6)
self.myInvitationCode=UIText.get(self,7)
self.shareBtn=UIButton.get(self,8)
self.freeRewardBtn=UIButton.get(self,9)
self.shareReward=UIObject.get(self,10)
self.targetListScroller=UIObject.get(self,11)
self.sortTypeList=UIObject.get(self,12)
self.invitedListScroller=UIObject.get(self,13)
self.nullTxt=UIText.get(self,14)
self.shareRewardCount=UIText.get(self,15)
self.shareRewardIcon=UIObject.get(self,16)
self.leftTime=UIText.get(self,17)
self.helpBtn=UIButton.get(self,18)
self.targetListBtnReddot=UIObject.get(self,19)

self.copyBtn:setButtonClick(function()self:onCopyBtn()end)

self.shareBtn:setButtonClick(function()self:onShareBtn()end)

self.freeRewardBtn:setButtonClick(function()self:onFreeRewardBtn()end)

self.helpBtn:setButtonClick(function()self:onHelpBtn()end)



end


function UIXianYouZhaoHuiWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.bgModel);self.bgModel=nil;
_UIObject_release(self.invitationPanel);self.invitationPanel=nil;
_UIObject_release(self.invitedPage);self.invitedPage=nil;
_UIObject_release(self.targetPage);self.targetPage=nil;
_UIObject_release(self.pageBtnList);self.pageBtnList=nil;
_UIObject_release(self.invitedCountText);self.invitedCountText=nil;
_UIObject_release(self.copyBtn);self.copyBtn=nil;
_UIObject_release(self.myInvitationCode);self.myInvitationCode=nil;
_UIObject_release(self.shareBtn);self.shareBtn=nil;
_UIObject_release(self.freeRewardBtn);self.freeRewardBtn=nil;
_UIObject_release(self.shareReward);self.shareReward=nil;
_UIObject_release(self.targetListScroller);self.targetListScroller=nil;
_UIObject_release(self.sortTypeList);self.sortTypeList=nil;
_UIObject_release(self.invitedListScroller);self.invitedListScroller=nil;
_UIObject_release(self.nullTxt);self.nullTxt=nil;
_UIObject_release(self.shareRewardCount);self.shareRewardCount=nil;
_UIObject_release(self.shareRewardIcon);self.shareRewardIcon=nil;
_UIObject_release(self.leftTime);self.leftTime=nil;
_UIObject_release(self.helpBtn);self.helpBtn=nil;
_UIObject_release(self.targetListBtnReddot);self.targetListBtnReddot=nil;
end
















local targetItemIndex={
titleText=0,
rewards=1,
getRewardBtn=2,
unFinishBtn=3,
gotLimitText=4,
getFlag=5,
}

local sortTypeIndex={


bindingTime=3,
}

local orderTypeIndex={
asc=1,
desc=2,
}

local sortTypeBtnItemIndex={
name=0,
bg=1,
upBg=2,
downBg=3,
}

local invitedItemIndex={
playerName=0,
headBg=1,
serverName=2,
bindingTime=3,
}




function UIXianYouZhaoHuiWin:onLoaded(...)
self:bindComponents()
end


function UIXianYouZhaoHuiWin:__delete()
self:unbindComponents()
if self.leftTimer then
self:stopTimerByID(self.leftTimer)
end
self.leftTimer=nil
end




function UIXianYouZhaoHuiWin:onShow(argtable,afterOnloaded)
if afterOnloaded then
self.winlua:SetChildUIModelShowTarget(self.bgModel:getID(),5346,1,{},eAnimationID.stand)
end
self:onShowArgRecv()


if deviceHelper.isRunIOS()and not api_Available_SetSystemCopyBuffer()then
self.copyBtn:setActive(false)
end
end


function UIXianYouZhaoHuiWin:refreshFreeReward()

local isCanGet=welfareModel:checkXianYouZhaoHuiFreeRewardCanGet()
self.freeRewardBtn:setActive(isCanGet)
end

function UIXianYouZhaoHuiWin:onShowArgRecv()
if not self.leftTimer then
self.leftTimer=self:setTimer(10,0,function()self:refreshLeftTime()end)
end
self:refreshLeftTime()
self:refreshInvitationPanel()
self:refreshFreeReward()

welfareController:reqReturnCodePlayerData()

welfareController:reqGetReturnCodeData()
end

function UIXianYouZhaoHuiWin:refreshLeftTime()
local zhm_const_def=cfg_zhaohuimaconfig().const_def
local sTime,eTime=zhm_const_def.opentime[1],zhm_const_def.opentime[2]
local eTimeStamp=timeHelper.getDateStamp(eTime)
local nowTime=timeHelper.getServerLongTime()
local leftTime=timeHelper.format_time_stamp15(eTimeStamp-nowTime)
self.leftTime:setText(FMT.fmt("活动剩余时间：{0}",leftTime))
end

function UIXianYouZhaoHuiWin:refreshInvitationPanel(isOnlyRefreshInvitationCode)

local zhm_const_def=cfg_zhaohuimaconfig().const_def
local selfInvitationCode_int_64=welfareModel:getSelfReturnCode()
if selfInvitationCode_int_64 and not mathHelper.compareInt64(selfInvitationCode_int_64,int64.new('0'))then
self.myInvitationCodeStr=mathHelper.convertDecimalTo35System(mathHelper.int64_to_number(selfInvitationCode_int_64),INVITATION_CODE_MIN_POS_COUNT,zhm_const_def.turnStr)
self.myInvitationCode:setText(self.myInvitationCodeStr)
else
self.myInvitationCode:setText("")
end
if isOnlyRefreshInvitationCode then

return
end


self:refreshInvitedCount()


local isShowShareBtn=shareImageModel:isOpenShareImage()
self.shareBtn:setActive(isShowShareBtn)
if isShowShareBtn then

self:refreshShareRewardShow()
end

if not self.selectPageIndex then
self.selectPageIndex=1
end

self:selectInvitationPanelPage(self.selectPageIndex)
self:refreshTargetListBtnReddot()
end

function UIXianYouZhaoHuiWin:selectInvitationPanelPage(index)
self.selectPageIndex=index

local grids=self.pageBtnList:getChildCommonLayoutGroupWidgetList()
for i=1,grids.Count do
local widget=grids[i-1]
local isSelect=i==self.selectPageIndex
widget:SetChildActive(0,isSelect)
widget:SetChildButtonClick(-1,function(...)
self:selectInvitationPanelPage(i)
end)
end

if self.selectPageIndex==1 then

self.targetPage:setActive(true)
self.invitedPage:setActive(false)
self:refreshInvitationPanel_targetPage()
elseif self.selectPageIndex==2 then

self.targetPage:setActive(false)
self.invitedPage:setActive(true)
self.sortType=nil
self:refreshInvitationPanel_invitedPage(nil,true)
end
end

function UIXianYouZhaoHuiWin:refreshTargetListBtnReddot()
local reddot=welfareModel:checkReturnCodeAllTaskReddot()
self.targetListBtnReddot:setActive(reddot)
end

function UIXianYouZhaoHuiWin:refreshInvitationPanel_targetPage()
if self.selectPageIndex~=1 then
return
end

local sortTargetCfgList=self:getSortTargetCfgList()
local targetCount=#sortTargetCfgList
self.targetListScroller:setChildScrollViewCreateGrids(targetCount,0)
local grids=self.targetListScroller:getChildScrollViewItemWidgets()
local recallNum=welfareModel:getReturnCodeInviteNum()or 0
local receive_idx=welfareModel:getReturnCodeRewardIdx()or 0
for i=1,grids.Count do
local widget=grids[i-1]
local cfg=sortTargetCfgList[i].cfg

widget:SetChildText(targetItemIndex.titleText,cfg.desc)


local rewards=cfg.rewards
widget:SetChildLayoutGroupCreateItems(targetItemIndex.rewards,#rewards)
local rwGrids=widget:GetChildLayoutGroupGridList(targetItemIndex.rewards)
for i=1,#rewards do
local rwWidget=rwGrids[i-1]
local reward=rewards[i]
local itemid=reward[1]
local count=reward.showCount or reward[2]
local countStr=''
local showCountBG=false
if count>1 then
showCountBG=true
countStr=mathHelper.formatNumber(count)
end
local conf={itemid=itemid,itemcount=countStr,showCountBG=showCountBG,showname=false,showStage=true}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
rwWidget:SetChildActive(-1,true)
rwWidget:SetChildPropData(0,prop)
rwWidget:SetBaseItemClickEvent(0,function(...)
self:onClickRewardItem(...)
end)
end

local taskId=cfg.id

widget:SetChildText(targetItemIndex.gotLimitText,FMT.fmt("人数：<color=#ca631d>{0}/{1}</color>",recallNum,cfg.num))


local isGotAll=receive_idx>=taskId
local isFinish=recallNum>=cfg.num
widget:SetChildActive(targetItemIndex.getRewardBtn,isFinish and not isGotAll)
widget:SetChildActive(targetItemIndex.unFinishBtn,not isFinish and not isGotAll)

widget:SetChildActive(targetItemIndex.getFlag,isGotAll)



widget:SetChildButtonClick(targetItemIndex.getRewardBtn,function(...)
self:onClickGetRewardBtn(taskId)
end)
end
end

function UIXianYouZhaoHuiWin:getSortTargetCfgList()
local targetCfgList=cfg_zhaohuimaconfig()
local sortList={}
local recallNum=welfareModel:getReturnCodeInviteNum()or 0
local receive_idx=welfareModel:getReturnCodeRewardIdx()or 0
for i,v in ipairs(targetCfgList)do
local sortItem={}
local taskId=v.id

local isGotAll=receive_idx>=i
local isFinish=recallNum>=v.num
local sortWeight=v.sortId
if isGotAll then
sortWeight=sortWeight+10000
elseif isFinish then
sortWeight=sortWeight-1000
end
sortItem.cfg=v
sortItem.sortWeight=sortWeight
table.insert(sortList,sortItem)
end
table.sort(sortList,function(a,b)
return a.sortWeight<b.sortWeight
end)
return sortList
end

function UIXianYouZhaoHuiWin:refreshInvitationPanel_invitedPage(sortType,isResetOrder)
if self.selectPageIndex~=2 then
return
end
if isResetOrder then
self.orderType=orderTypeIndex.desc
end
if not sortType and not self.sortType then
sortType=sortTypeIndex.bindingTime
end

if self.sortType==sortType then
if self.orderType==orderTypeIndex.desc then
self.orderType=orderTypeIndex.asc
elseif self.orderType==orderTypeIndex.asc then
self.orderType=orderTypeIndex.desc
end
end

if sortType then
self.sortType=sortType
end


self:refreshInvitedListTitleBtn()

local sortBindingList=self:getSortBindingList()
local invitedCount=#sortBindingList
self.invitedListScroller:setChildScrollViewCreateGrids(invitedCount,0)
local grids=self.invitedListScroller:getChildScrollViewItemWidgets()
for i=1,grids.Count do
local widget=grids[i-1]
local data=sortBindingList[i].data

local headArgs={}
headArgs.iconInfo=data.iconInfo
headArgs.scale=0.75
playerController:setHeadIcon(widget,-1,headArgs)







widget:SetChildText(invitedItemIndex.playerName,data.name)


local serverName=loginModel:getServerName(data.server_id)
widget:SetChildText(invitedItemIndex.serverName,serverName)


local longstamp=timeHelper.convertLongStamp(data.bind_time)
local bindingTimeStr=timeHelper.dateServerStamp('%Y-%m-%d  %H:%M:%S',longstamp)
widget:SetChildText(invitedItemIndex.bindingTime,bindingTimeStr)
end

self.nullTxt:setActive(invitedCount<=0)
end

function UIXianYouZhaoHuiWin:getSortBindingList()
local bindingList=welfareModel:getReturnCodePlayerData()or{}
local sortList={}
for i,v in ipairs(bindingList)do
local sortWeight=0
if self.sortType==sortTypeIndex.bindingTime then

sortWeight=v.bind_time
end
local sortItem={
data=v,
sortWeight=sortWeight,
}

table.insert(sortList,sortItem)
end

if self.orderType==orderTypeIndex.asc then

table.sort(sortList,function(a,b)
return a.sortWeight<b.sortWeight
end)
elseif self.orderType==orderTypeIndex.desc then

table.sort(sortList,function(a,b)
return a.sortWeight>b.sortWeight
end)
end
return sortList
end

function UIXianYouZhaoHuiWin:refreshInvitedListTitleBtn()
local grids=self.sortTypeList:getChildCommonLayoutGroupWidgetList()
for i=1,grids.Count do
local widget=grids[i-1]
local isSort=self.sortType==i
widget:SetChildActive(sortTypeBtnItemIndex.bg,not isSort)
if isSort then
local isASC=self.orderType==orderTypeIndex.asc
widget:SetChildActive(sortTypeBtnItemIndex.upBg,isASC)
widget:SetChildActive(sortTypeBtnItemIndex.downBg,not isASC)
else
widget:SetChildActive(sortTypeBtnItemIndex.upBg,false)
widget:SetChildActive(sortTypeBtnItemIndex.downBg,false)
end

if i~=1 and i~=2 then
widget:SetChildButtonClick(-1,function(...)
self:refreshInvitationPanel_invitedPage(i)
end)
end
end
end


function UIXianYouZhaoHuiWin:refreshShareRewardShow()

local shareType=shareImageModel:getShareTypeByWinName(self.window_name)
local isShow=false
if shareType then
local canGetNum=shareImageModel:getShareRewardCanGetNumByType(shareType)
isShow=canGetNum>0
end
self.shareReward:setActive(isShow)
if isShow then

local rewards=cfgHelper.get(cfg_yaoqingmadailyconfig_get,shareType,"rewards")
if rewards then

local reward=rewards[1]
local itemId=reward[1]
local itemCount=reward[2]
local countStr=mathHelper.formatNumber(itemCount)
self.shareRewardIcon:setChildIcon(iconHelper.getIconName(itemId),false)
self.shareRewardCount:setText(countStr)
end
end
end


function UIXianYouZhaoHuiWin:refreshInvitedCount()
local invitedCount=welfareModel:getReturnCodeInviteNum()
self.invitedCountText:setText(FMT.fmt("已邀请仙友回归：{0}人",invitedCount))
end

function UIXianYouZhaoHuiWin:onCopyBtn()
if not self.myInvitationCodeStr then
return
end
if deviceHelper.isRunIOS()then
if api_Available_SetSystemCopyBuffer()then
CS.GameInterface.SetSystemCopyBuffer(self.myInvitationCodeStr)
end
else
local result=platformHelper.copyTextToClipboard(self.myInvitationCodeStr)
if result then
UIManager.info("复制成功")
else
UIManager.error("复制失败")
end
end
end

function UIXianYouZhaoHuiWin:onShareBtn()
local shareShowType=shareImageModel:getShareShowTypeByWinName(self.window_name)
local param={
zhm=true,
}
shareImageController:showShareImageWin(shareShowType,param)
end

function UIXianYouZhaoHuiWin:onHelpBtn()
local d={}
d.title='召回码规则'
d.mode=3
d.name='returningcode_help_%d'
UIManager:showWindow('UIRuleWin',d)
end

function UIXianYouZhaoHuiWin:onClickRewardItem(itemId,index,guid,attach)

if itemId==-1 then
return
end
tipsManager.showTips({itemid=itemId,itemguid=guid})
end

function UIXianYouZhaoHuiWin:onClickGetRewardBtn(taskId)
welfareController:reqReturnCodeGetTaskReward(taskId)
end


function UIXianYouZhaoHuiWin:onClickHead(actorId,serverId)
local nowSeverId=playerModel:getActorServerID()
local attach=nil
if nowSeverId~=serverId then attach={serverid=serverId}end
otherPlayerController:openOtherPlayerInfoWin(actorId,nil,nil,attach)
end

function UIXianYouZhaoHuiWin:onFreeRewardBtn()

welfareController:reqGetXianYouZhaoHuiFreeReward()
end