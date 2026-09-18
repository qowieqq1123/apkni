







def_class("UIInvitationCodeWin",UIWindowBase)









function UIInvitationCodeWin:bindComponents()

self.inputCodePanel=UIObject.get(self,0)
self.codeInputField=UIInputField.get(self,1)
self.bindingBtn=UIButton.get(self,2)
self.bindingFlag=UIObject.get(self,3)
self.bindingRewards=UIObject.get(self,4)
self.tipsText=UIText.get(self,5)
self.invitationPanel=UIObject.get(self,6)
self.myInvitationCode=UIText.get(self,7)
self.copyBtn=UIButton.get(self,8)
self.shareBtn=UIButton.get(self,9)
self.helpBtn=UIButton.get(self,10)
self.invitedCountText=UIText.get(self,11)
self.pageBtnList=UIObject.get(self,12)
self.targetListBtnReddot=UIObject.get(self,13)
self.targetPage=UIObject.get(self,14)
self.targetListScroller=UIObject.get(self,15)
self.invitedPage=UIObject.get(self,16)
self.sortTypeList=UIObject.get(self,17)
self.invitedListScroller=UIObject.get(self,18)
self.freeRewardBtn=UIButton.get(self,19)
self.inputText=UIText.get(self,20)
self.nullTxt=UIText.get(self,21)
self.shareReward=UIObject.get(self,22)
self.shareRewardIcon=UIObject.get(self,23)
self.shareRewardCount=UIText.get(self,24)
self.bgModel=UIObject.get(self,25)
self.Placeholder=UIText.get(self,26)

self.bindingBtn:setButtonClick(function()self:onBindingBtn()end)

self.copyBtn:setButtonClick(function()self:onCopyBtn()end)

self.shareBtn:setButtonClick(function()self:onShareBtn()end)

self.helpBtn:setButtonClick(function()self:onHelpBtn()end)

self.freeRewardBtn:setButtonClick(function()self:onFreeRewardBtn()end)



end


function UIInvitationCodeWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.inputCodePanel);self.inputCodePanel=nil;
_UIObject_release(self.codeInputField);self.codeInputField=nil;
_UIObject_release(self.bindingBtn);self.bindingBtn=nil;
_UIObject_release(self.bindingFlag);self.bindingFlag=nil;
_UIObject_release(self.bindingRewards);self.bindingRewards=nil;
_UIObject_release(self.tipsText);self.tipsText=nil;
_UIObject_release(self.invitationPanel);self.invitationPanel=nil;
_UIObject_release(self.myInvitationCode);self.myInvitationCode=nil;
_UIObject_release(self.copyBtn);self.copyBtn=nil;
_UIObject_release(self.shareBtn);self.shareBtn=nil;
_UIObject_release(self.helpBtn);self.helpBtn=nil;
_UIObject_release(self.invitedCountText);self.invitedCountText=nil;
_UIObject_release(self.pageBtnList);self.pageBtnList=nil;
_UIObject_release(self.targetListBtnReddot);self.targetListBtnReddot=nil;
_UIObject_release(self.targetPage);self.targetPage=nil;
_UIObject_release(self.targetListScroller);self.targetListScroller=nil;
_UIObject_release(self.invitedPage);self.invitedPage=nil;
_UIObject_release(self.sortTypeList);self.sortTypeList=nil;
_UIObject_release(self.invitedListScroller);self.invitedListScroller=nil;
_UIObject_release(self.freeRewardBtn);self.freeRewardBtn=nil;
_UIObject_release(self.inputText);self.inputText=nil;
_UIObject_release(self.nullTxt);self.nullTxt=nil;
_UIObject_release(self.shareReward);self.shareReward=nil;
_UIObject_release(self.shareRewardIcon);self.shareRewardIcon=nil;
_UIObject_release(self.shareRewardCount);self.shareRewardCount=nil;
_UIObject_release(self.bgModel);self.bgModel=nil;
_UIObject_release(self.Placeholder);self.Placeholder=nil;
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


zmLevel=3,
zmFight=4,
bindingTime=5,
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
zmLevel=3,
zmFight=4,
bindingTime=5,
}




function UIInvitationCodeWin:onLoaded(...)
self:bindComponents()
self.codeInputField:setChildInputFieldChange(true,function(...)self:onInputFieldChange(...)end)
end


function UIInvitationCodeWin:__delete()
self:unbindComponents()
end




function UIInvitationCodeWin:onShow(argtable,afterOnloaded)
if afterOnloaded then
self.winlua:SetChildUIModelShowTarget(self.bgModel:getID(),5210,1,{},eAnimationID.stand)
end
self:onShowArgRecv()


if deviceHelper.isRunIOS()and not api_Available_SetSystemCopyBuffer()then
self.copyBtn:setActive(false)
end
end


function UIInvitationCodeWin:onHide()

end

function UIInvitationCodeWin:onShowArgRecv()

self:selectEnterPanel()
end

function UIInvitationCodeWin:selectEnterPanel()

local nowZmLevel=zongmenModel:getLevel()
local const_def=cfg_yaoqingmaconfig().const_def
local targetZmLevel=const_def.openLv

if nowZmLevel<targetZmLevel then

self.inputCodePanel:setActive(true)
self.invitationPanel:setActive(false)
self.selectPanelType=1
self:refreshInputCodePanel()
else

self.invitationPanel:setActive(true)
self.inputCodePanel:setActive(false)
self.selectPanelType=2
self:refreshInvitationPanel()

welfareController:reqInvitedDataList()

welfareController:reqGetInvitationTaskData()
end
end

function UIInvitationCodeWin:refreshInputCodePanel()
if self.selectPanelType~=1 then
return
end


local nowBindingCode=welfareModel:getBindInvitationCode()
self.isBinding=nowBindingCode~=nil and not mathHelper.compareInt64(nowBindingCode,int64.new('0'))









local const_def=cfg_yaoqingmaconfig().const_def
local targetZmLevel=const_def.openLv
local tipsStr=FMT.fmt("宗门等级{0}级前绑定有效哦！",targetZmLevel)
self.tipsText:setText(tipsStr)

if self.isBinding then

local nowBindingCodeStr=mathHelper.convertDecimalTo35System(mathHelper.int64_to_number(nowBindingCode),INVITATION_CODE_MIN_POS_COUNT)
self.codeInputField:setInputFieldValue(nowBindingCodeStr)
end

local inputField=self.codeInputField:getCommonComponent('InputField')
inputField.interactable=not self.isBinding

if webGLHelper:isRunMiniGame()then
local query=webGLHelper:getLastQueryArgs()
inputField.text=query.shareKey or''
end

self.bindingBtn:setActive(not self.isBinding)
self.bindingFlag:setActive(self.isBinding)


local const_def=cfg_yaoqingmaconfig().const_def
local rewards=const_def.bind_reward
self.bindingRewards:setChildLayoutGroupCreateItems(#rewards)
local grids=self.bindingRewards:getChildLayoutGroupGridList()
for i=1,#rewards do
local widget=grids[i-1]
local reward=rewards[i]
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


local isGot=self.isBinding
local isGrayMask=isGot
prop[PropIndex(DataPropKey.eWidgetActive,7)]=isGrayMask

widget:SetChildActive(-1,true)
widget:SetChildPropData(0,prop)
widget:SetBaseItemClickEvent(0,function(...)
self:onClickRewardItem(...)
end)


widget:SetChildActive(1,isGot)
end


local isCanGet=welfareModel:checkInvitationFreeRewardCanGet()
self.freeRewardBtn:setActive(isCanGet)
end

function UIInvitationCodeWin:refreshInvitationPanel(isOnlyRefreshInvitationCode)
if self.selectPanelType~=2 then
return
end

local selfInvitationCode_int_64=welfareModel:getSelfInvitationCode()
if selfInvitationCode_int_64 and not mathHelper.compareInt64(selfInvitationCode_int_64,int64.new('0'))then
self.myInvitationCodeStr=mathHelper.convertDecimalTo35System(mathHelper.int64_to_number(selfInvitationCode_int_64),INVITATION_CODE_MIN_POS_COUNT)
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

function UIInvitationCodeWin:selectInvitationPanelPage(index)
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

function UIInvitationCodeWin:refreshTargetListBtnReddot()
local reddot=welfareModel:checkInvitationAllTaskReddot()
self.targetListBtnReddot:setActive(reddot)
end

function UIInvitationCodeWin:refreshInvitationPanel_targetPage()
if self.selectPanelType~=2 or self.selectPageIndex~=1 then
return
end

local sortTargetCfgList=self:getSortTargetCfgList()
local targetCount=#sortTargetCfgList
self.targetListScroller:setChildScrollViewCreateGrids(targetCount,0)
local grids=self.targetListScroller:getChildScrollViewItemWidgets()
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
local data=welfareModel:getInvitationTaskDataByTaskId(taskId)or{}
local finishCount=data.finishCount or 0
local gotCount=data.gotCount or 0


widget:SetChildText(targetItemIndex.gotLimitText,FMT.fmt("限领：<color=#ca631d>{0}/{1}</color>",gotCount,cfg.maxNum))


local isGotAll=gotCount>=cfg.maxNum
local isFinish=finishCount>gotCount
widget:SetChildActive(targetItemIndex.getRewardBtn,isFinish and not isGotAll)
widget:SetChildActive(targetItemIndex.unFinishBtn,not isFinish and not isGotAll)

widget:SetChildActive(targetItemIndex.getFlag,isGotAll)



widget:SetChildButtonClick(targetItemIndex.getRewardBtn,function(...)
self:onClickGetRewardBtn(taskId)
end)
end
end

function UIInvitationCodeWin:getSortTargetCfgList()
local targetCfgList=cfg_yaoqingmaconfig()
local sortList={}
for i,v in ipairs(targetCfgList)do
local sortItem={}
local taskId=v.id
local data=welfareModel:getInvitationTaskDataByTaskId(taskId)or{}
local finishCount=data.finishCount or 0
local gotCount=data.gotCount or 0

local isGotAll=gotCount>=v.maxNum
local isFinish=finishCount>gotCount
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

function UIInvitationCodeWin:refreshInvitationPanel_invitedPage(sortType,isResetOrder)
if self.selectPanelType~=2 or self.selectPageIndex~=2 then
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


widget:SetChildText(invitedItemIndex.zmLevel,data.level)


local fightStr=mathHelper.formatNumber3(data.fight_val,true)
widget:SetChildText(invitedItemIndex.zmFight,fightStr)


local longstamp=timeHelper.convertLongStamp(data.bind_time)
local bindingTimeStr=timeHelper.dateServerStamp('%Y-%m-%d\n%H:%M:%S',longstamp)
widget:SetChildText(invitedItemIndex.bindingTime,bindingTimeStr)
end

self.nullTxt:setActive(invitedCount<=0)
end

function UIInvitationCodeWin:getSortBindingList()
local bindingList=welfareModel:getInvitedDataList()or{}
local sortList={}
for i,v in ipairs(bindingList)do
local sortWeight=0
if self.sortType==sortTypeIndex.zmLevel then

sortWeight=v.level
elseif self.sortType==sortTypeIndex.zmFight then

sortWeight=v.fight_val
elseif self.sortType==sortTypeIndex.bindingTime then

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

function UIInvitationCodeWin:refreshInvitedListTitleBtn()
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


function UIInvitationCodeWin:refreshShareRewardShow()

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


function UIInvitationCodeWin:refreshInvitedCount()
local invitedCount=welfareModel:getInvitedCount()
self.invitedCountText:setText(FMT.fmt("已经邀请仙友：{0}人",invitedCount))
end




function UIInvitationCodeWin:onBindingBtn()
local codeStr=self.codeInputField:getInputFieldValue()
if not codeStr or codeStr==""then
return UIManager.error("请填入邀请码")
end

local codeNum=mathHelper.convert35SystemToDecimal(codeStr)
local codeNum_int_64=mathHelper.number_to_int64(codeNum)

welfareController:reqInvitationCodeBind(codeNum_int_64)
end



function UIInvitationCodeWin:onCopyBtn()
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



function UIInvitationCodeWin:onShareBtn()
local shareShowType=shareImageModel:getShareShowTypeByWinName(self.window_name)
if webGLHelper:isRunMiniGame()then
platformSDK:reqShareImage('')
local cfg=cfgHelper.get(cfg_shareimagebaseconfig_get,shareShowType)
shareImageController:reqGetShareImageReward(cfg.shareType)
else
shareImageController:showShareImageWin(shareShowType)
end
end



function UIInvitationCodeWin:onHelpBtn()
local d={}
d.title='邀请码规则'
d.mode=3
d.name='invitationcode_help_%d'
UIManager:showWindow('UIRuleWin',d)
end



function UIInvitationCodeWin:onFreeRewardBtn()

welfareController:reqGetInvitedFreeReward()
end

function UIInvitationCodeWin:onClickRewardItem(itemId,index,guid,attach)

if itemId==-1 then
return
end
tipsManager.showTips({itemid=itemId,itemguid=guid})
end

function UIInvitationCodeWin:onClickGetRewardBtn(taskId)
welfareController:reqInvitationCodeGetTaskReward(taskId)
end


function UIInvitationCodeWin:onClickHead(actorId,serverId)
local nowSeverId=playerModel:getActorServerID()
local attach=nil
if nowSeverId~=serverId then attach={serverid=serverId}end
otherPlayerController:openOtherPlayerInfoWin(actorId,nil,nil,attach)

end

function UIInvitationCodeWin:onInputFieldChange(str)
local upperStr=string.upper(str)

self.codeInputField:setInputFieldValue(upperStr)
end

function UIInvitationCodeWin:onClickInput()
self.Placeholder:setActive(false)
end


function UIInvitationCodeWin:onExitInput()
local str=self.codeInputField:getInputFieldValue()
if not str or str==''then
self.Placeholder:setActive(true)
end
end