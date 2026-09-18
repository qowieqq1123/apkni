







def_class("UISubAct_TianMoRuQin_EventDialog",UIWindowBase)









function UISubAct_TianMoRuQin_EventDialog:bindComponents()

self.background=UIButton.get(self,0)
self.bgModel=UIObject.get(self,1)
self.root=UIObject.get(self,2)
self.contentImg=UIImage.get(self,3)
self.closeBtn=UIButton.get(self,4)
self.descTx=UIText.get(self,5)
self.rightBtnTx=UIText.get(self,6)
self.rightBtnTips=UIText.get(self,7)
self.rightBtn=UIButton.get(self,8)
self.topTips=UIText.get(self,9)
self.finished=UIObject.get(self,10)
self.leftTips=UIText.get(self,11)
self.previewTips=UIText.get(self,12)
self.midTips=UIText.get(self,13)
self.rewardTips=UIText.get(self,14)
self.titleTx=UIText.get(self,15)
self.rewardList=UIObject.get(self,16)
self.previewList=UIObject.get(self,17)

self.background:setButtonClick(function()self:onBackground()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.rightBtn:setButtonClick(function()self:onRightBtn()end)



end


function UISubAct_TianMoRuQin_EventDialog:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.background);self.background=nil;
_UIObject_release(self.bgModel);self.bgModel=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.contentImg);self.contentImg=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.descTx);self.descTx=nil;
_UIObject_release(self.rightBtnTx);self.rightBtnTx=nil;
_UIObject_release(self.rightBtnTips);self.rightBtnTips=nil;
_UIObject_release(self.rightBtn);self.rightBtn=nil;
_UIObject_release(self.topTips);self.topTips=nil;
_UIObject_release(self.finished);self.finished=nil;
_UIObject_release(self.leftTips);self.leftTips=nil;
_UIObject_release(self.previewTips);self.previewTips=nil;
_UIObject_release(self.midTips);self.midTips=nil;
_UIObject_release(self.rewardTips);self.rewardTips=nil;
_UIObject_release(self.titleTx);self.titleTx=nil;
_UIObject_release(self.rewardList);self.rewardList=nil;
_UIObject_release(self.previewList);self.previewList=nil;
end















local _this=nil
local _eventShow={
[TianMoRuQinEventType.eUnlockMonsterType]='showInfo1',
[TianMoRuQinEventType.eAddExtraMonster]='showInfo2',
[TianMoRuQinEventType.ePlayLitteGame]='showInfo3',
[TianMoRuQinEventType.eDirectAward]='showInfo4',
}



function UISubAct_TianMoRuQin_EventDialog:onLoaded(...)
self:bindComponents()
_this=self
end


function UISubAct_TianMoRuQin_EventDialog:__delete()
self:unbindComponents()
_this=nil
end




function UISubAct_TianMoRuQin_EventDialog:onShow(argtable,afterOnloaded)
self.actId=argtable.actId
self.subType=argtable.subType
self.subId=argtable.subId
self.open=argtable.open
self.config=activitiesModel:getSubActivityConfig(argtable.subType,argtable.subId)
self.info=activitiesModel:getSubActInfo(argtable.actId,argtable.subType,argtable.subId)
self.eventIdx=argtable.index
self.eventType=self.config.aim[self.eventIdx][2]
self:showContent()
self:showContentEx()

self.bgModel:setChildUIModelShowTarget(4935,1,{},eAnimationID.enter,false,false,0,function()
self:delayDo(0.4,function()
self.canClose=true
self.root:setChildCanvasGroupAlpha(1)
end)
end)
end


function UISubAct_TianMoRuQin_EventDialog:onHide()

end





function UISubAct_TianMoRuQin_EventDialog:onCloseBtn()
if self.canClose then
self:closeSelf()
end
end


function UISubAct_TianMoRuQin_EventDialog:onRightBtn()
if not self.open then
UIManager.error("天魔入侵事件会随着活动时间逐渐解锁")
return
end
if self.eventType==TianMoRuQinEventType.eUnlockMonsterType then

elseif self.eventType==TianMoRuQinEventType.eAddExtraMonster then
local flag=self.info:getEventData(self.eventIdx)
if flag==TianMoRuQinEventFlagType.Completed then
call_activitiesHandle_func("activitiesHandle_tianmoruqin","reqEventReward",self.actId,self.subId,self.eventIdx)
else
self.info:jumpEventMonster(self.eventIdx)
self:closeSelf()
end
elseif self.eventType==TianMoRuQinEventType.ePlayLitteGame then
local aimInfo=self.config.aim[self.eventIdx]
local aimParam=aimInfo[3]
local littleGameInfo=aimParam[2]
local littleGameType=littleGameInfo[1]
local littleGameID=littleGameInfo[2]
UILittleGameController:openLittleGame(littleGameType,{mapId=littleGameID},function(isWin)
if isWin==1 then
call_activitiesHandle_func("activitiesHandle_tianmoruqin","reqStartEvent",self.actId,self.subId,self.eventIdx)
end
end)
elseif self.eventType==TianMoRuQinEventType.eDirectAward then
call_activitiesHandle_func("activitiesHandle_tianmoruqin","reqStartEvent",self.actId,self.subId,self.eventIdx)
end
end


function UISubAct_TianMoRuQin_EventDialog:onBackground()
self:onCloseBtn()
end

function UISubAct_TianMoRuQin_EventDialog:showContent()
local descInfo=self.config.aimDesc[self.eventIdx]
local imageName=descInfo[2]
local descStr=descInfo[3]
local title=descInfo[1]
self.contentImg:setSprite(FMT.fmt("ui/icons/mystery/sharedtextures/{0}.ab",imageName),imageName)
self.descTx:setText(descStr)
self.titleTx:setText(title)
end

function UISubAct_TianMoRuQin_EventDialog:showContentEx()
self[_eventShow[self.eventType]](self)
end

function UISubAct_TianMoRuQin_EventDialog:refreshContentEx(actId,subType,subId)
if self.info:compare(actId,subType,subId)then
self:showContentEx()
end
end

function UISubAct_TianMoRuQin_EventDialog:showInfo1()
local flag=self.info:getEventData(self.eventIdx)
local descInfo=self.config.aimDesc[self.eventIdx]
local tipsStr=descInfo[4]
local rewardDatas=descInfo[6]
local name=descInfo[1]
local tipsName=descInfo[7]
if not rewardDatas then
self.midTips:setText(tipsStr)
else
self.topTips:setText(tipsStr)
self.previewTips:setText(tipsName or FMT.fmt("{0}奖励：",name))
self.previewTips:setActive(true)
self.previewList:setChildLayoutGroupCreateItems(#rewardDatas,function(index)
local rewardItem=self.previewList:getChildLayoutGroupGridItem(index-1)
local rewardData=rewardDatas[index]
local showCountBG=rewardData[2]>1
local countStr=showCountBG and rewardData[2]or""
local conf={itemid=rewardData[1],itemcount=countStr,showCountBG=showCountBG,showname=false,showStage=true}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
rewardItem:SetChildPropData(0,prop)
rewardItem:SetBaseItemClickEvent(0,itemsComponentHelper.onItemClickEx)
end)
end
self.rightBtn:setActive(false)
self.rightBtnTips:setActive(false)

if flag==nil then
if self.open then
call_activitiesHandle_func("activitiesHandle_tianmoruqin","reqStartEvent",self.actId,self.subId,self.eventIdx)
else
UIManager.error("事件尚未解锁")
end
end
end

function UISubAct_TianMoRuQin_EventDialog:showInfo2()
local flag=self.info:getEventData(self.eventIdx)
if flag==TianMoRuQinEventFlagType.NotOpen then
flag=TianMoRuQinEventFlagType.Doing
self.info:setEventData(self.eventIdx,flag)
UIManager:invokeUIMethod('UISubAct_TianMoRuQin_MainWin','on_249_132',self.actId,self.subType,self.subId,self.eventIdx)
notifySystem:postNotify(notifyConfig.onActTabReddotChange,SUBACT_DEFINETAB_TYPE.eTianMoRuQin_main)
end
self.rightBtnTx:setText(flag==TianMoRuQinEventFlagType.Completed and"领取"or"前往")
self.rightBtn:setActive(not self.open or(flag~=nil and flag~=TianMoRuQinEventFlagType.Rewarded))
self.rightBtn:setChildGraphicGray(not self.open)
self.finished:setActive(flag==TianMoRuQinEventFlagType.Rewarded)
self.rightBtnTips:setActive(flag~=nil and flag~=TianMoRuQinEventFlagType.Rewarded)
local rewardDatas=self.config.aim[self.eventIdx][3][3]
self.rewardTips:setActive(rewardDatas~=nil)
if rewardDatas then
self.rewardTips:setText("剿灭奖励：")
self.rewardList:setChildLayoutGroupCreateItems(#rewardDatas,function(index)
local rewardItem=self.rewardList:getChildLayoutGroupGridItem(index-1)
local rewardData=rewardDatas[index]
local showCountBG=rewardData[2]>1
local countStr=showCountBG and rewardData[2]or""
local conf={itemid=rewardData[1],itemcount=countStr,showCountBG=showCountBG,showname=false,showStage=true}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
rewardItem:SetChildPropData(0,prop)
rewardItem:SetBaseItemClickEvent(0,itemsComponentHelper.onItemClickEx)
end)
self.leftTips:setText("")
else
local descInfo=self.config.aimDesc[self.eventIdx]
local tipsStr=descInfo[4]
self.leftTips:setText(tipsStr)
end
if flag==TianMoRuQinEventFlagType.Doing then
local exMonster=self.info:getExMonsterData(self.eventIdx)
self.rightBtnTips:setActive(true)
self.rightBtnTips:setText(FMT.fmt("天魔剩余数量：{0}",#exMonster.list))
else
self.rightBtnTips:setActive(false)
end
if flag==nil then
if self.open then
call_activitiesHandle_func("activitiesHandle_tianmoruqin","reqStartEvent",self.actId,self.subId,self.eventIdx)
end
end
end

function UISubAct_TianMoRuQin_EventDialog:showInfo3()
local flag=self.info:getEventData(self.eventIdx)



self.rightBtnTx:setText("立刻封印")
self.rightBtn:setActive(flag==nil)
self.rightBtn:setChildGraphicGray(not self.open)
self.finished:setActive(flag==TianMoRuQinEventFlagType.Rewarded)
self.rightBtnTips:setActive(false)

local aimInfo=self.config.aim[self.eventIdx]
local aimParam=aimInfo[3]
local rewardDatas=aimParam[1]
self.rewardTips:setActive(true)
self.rewardTips:setText("封印奖励：")
self.rewardList:setChildLayoutGroupCreateItems(#rewardDatas,function(index)
local rewardItem=self.rewardList:getChildLayoutGroupGridItem(index-1)
local rewardData=rewardDatas[index]
local showCountBG=rewardData[2]>1
local countStr=showCountBG and rewardData[2]or""
local conf={itemid=rewardData[1],itemcount=countStr,showCountBG=showCountBG,showname=false,showStage=true}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
rewardItem:SetChildPropData(0,prop)
rewardItem:SetBaseItemClickEvent(0,itemsComponentHelper.onItemClickEx)
end)
end

function UISubAct_TianMoRuQin_EventDialog:showInfo4()
local flag=self.info:getEventData(self.eventIdx)
local descInfo=self.config.aimDesc[self.eventIdx]
local aimInfo=self.config.aim[self.eventIdx]
local aimParam=aimInfo[3]
local rewardDatas=aimParam[1]
self.rewardTips:setActive(true)
self.rewardList:setChildLayoutGroupCreateItems(#rewardDatas,function(index)
local rewardItem=self.rewardList:getChildLayoutGroupGridItem(index-1)
local rewardData=rewardDatas[index]
local showCountBG=rewardData[2]>1
local countStr=showCountBG and rewardData[2]or""
local conf={itemid=rewardData[1],itemcount=countStr,showCountBG=showCountBG,showname=false,showStage=true}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
rewardItem:SetChildPropData(0,prop)
rewardItem:SetBaseItemClickEvent(0,itemsComponentHelper.onItemClickEx)
end)
self.rightBtnTx:setText("领 取")
self.rightBtn:setActive(flag==nil)
self.rightBtn:setChildGraphicGray(not self.open)
self.finished:setActive(flag==TianMoRuQinEventFlagType.Rewarded)
self.rightBtnTips:setActive(false)
end