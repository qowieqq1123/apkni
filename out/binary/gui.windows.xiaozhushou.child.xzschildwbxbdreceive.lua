







def_class("xzsChildWBXBDReceive",UICloneObject)





xzsChildWBXBDReceive.abName="ui/windows/xiaozhushou/child/xzschildwbxbdreceive.ab"

xzsChildWBXBDReceive.assetName="xzsChildWBXBDReceive"


function xzsChildWBXBDReceive:bindComponents()

self.countPanel=UIObject.get(self,0)
self.countText=UIText.get(self,1)
self.doingText=UIText.get(self,2)
self.errorTx=UIText.get(self,3)
self.icon=UIImage.get(self,4)
self.progress=UIProgressBarAni.get(self,5)
self.rewardList=UIObject.get(self,6)
self.rewardText=UIText.get(self,7)
self.title=UIText.get(self,8)

end


function xzsChildWBXBDReceive:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.countPanel);self.countPanel=nil;
_UIObject_release(self.countText);self.countText=nil;
_UIObject_release(self.doingText);self.doingText=nil;
_UIObject_release(self.errorTx);self.errorTx=nil;
_UIObject_release(self.icon);self.icon=nil;
_UIObject_release(self.progress);self.progress=nil;
_UIObject_release(self.rewardList);self.rewardList=nil;
_UIObject_release(self.rewardText);self.rewardText=nil;
_UIObject_release(self.title);self.title=nil;
end





local _ab="ui/windows/xiaozhushou/xzsiconsmall_pak.ab"



function xzsChildWBXBDReceive:onLoaded(...)
self:bindComponents()

self._onProgressStepComplete=function(...)
self:onProgressStepComplete(...)
end
self.progress:setFinishAction(self._onProgressStepComplete)

self._onShowPrize=function(...)
self:onShowPrize(...)
end
self:addNotify(notifyConfig.onShowPrize,self._onShowPrize)

self._onWanBaoXunBaoDuiAadcentrueFinish=function(...)
self:onWanBaoXunBaoDuiAadcentrueFinish(...)
end
self:addNotify(notifyConfig.onWanBaoXunBaoDuiAadcentrueFinish,self._onWanBaoXunBaoDuiAadcentrueFinish)
end


function xzsChildWBXBDReceive:__delete()
self:unbindComponents()
end




function xzsChildWBXBDReceive:onShow(argtable,afterOnloaded)
self.orderID=argtable.orderID
self.detailId=argtable.detailId
self.detailCfg=cfg_xiaozhushoudetailconfig_get(self.detailId)
self.title:setText(self.detailCfg.name)
local iconName=string.format("image_zsjztps_%d",self.detailCfg.icon)
self.icon:setSprite(_ab,iconName)

self.state=argtable.state
if self.state==-1 then
self.rewardList:setActive(false)
self.progress:setActive(false)
self.errorTx:setActive(true)
self.errorTx:setText(argtable.error or"")
if argtable.completeFunc then
argtable.completeFunc()
end
xiaoZhuShouController:setIdleState()
else
self.excutes=argtable.excutes
self.interval=argtable.interval or 1
self.overPass=argtable.overPass or 5
self.stepFunc=argtable.stepFunc
self.completeFunc=argtable.completeFunc
self.errorStr=argtable.error

self.commonList={}
self.commonLookup={}
self.currentStep=0
self.dataCount=0
self.animComplete=true
self.maxValue=#self.excutes
self.perValue=10000/self.maxValue

self.rewardList:setActive(false)
self.progress:setActive(true)
self.errorTx:setActive(false)
self.doingText:setText(self.detailCfg.timeTxt)
self.progress:animateThreeParams(0,10000,0)
self.rewardText:setText(argtable.tipsStr or"已获得奖励")
self:doNextStep()
end
self.widget:ForceLayoutRect(-1)
end


function xzsChildWBXBDReceive:onHide()

end


function xzsChildWBXBDReceive:onShowPrize(prizeType,temp,effectData,temp2)

if prizeType==ePrizeType.eXZS_Common and effectData.sub_effecttype==self.orderID then
for i,v in ipairs(temp)do
showPrizeControl.insertCommon(self.commonList,self.commonLookup,v.itemguid,v.itemid,v.num,true)
end
end
end

function xzsChildWBXBDReceive:onWanBaoXunBaoDuiAadcentrueFinish(channel_id)
self.dataCount=self.dataCount+1
wanBaoXunBaoDuiController:doShipReturn(channel_id)
if self.animComplete then
if self.currentStep>=self.maxValue then
self:refreshResult()
self:refreshRewards()
elseif self.overTick then
self:doNextStep()
end
end
end

function xzsChildWBXBDReceive:doNextStep()
self:stopOverTick()
self.animComplete=false

if self.currentStep<self.maxValue then
self.currentStep=self.currentStep+1
self.stepFunc(self.excutes[self.currentStep])
self:doProgressAnim()
else
self.rewardList:setActive(true)
self.progress:setActive(false)
self:refreshResult()
self:refreshRewards()
if self.completeFunc then
self.completeFunc()
end

end
end

function xzsChildWBXBDReceive:doProgressAnim()
local value=math.floor(self.currentStep*self.perValue)
self.progress:animateThreeParams(value,10000,self.interval)
end

function xzsChildWBXBDReceive:refreshResult()
self.countPanel:setActive(true)
self.countText:setText(FMT.fmt("已收集{0}支队伍的探险奖励",self.dataCount))
end

function xzsChildWBXBDReceive:refreshRewards()
local count=#self.commonList
table.sort(self.commonList,function(a,b)
return a.sortWeight>b.sortWeight
end)
self.rewardList:setChildLayoutGroupCreateItems(count,function(index)
local item=self.rewardList:getChildLayoutGroupGridItem(index-1)
local itemData=self.commonList[index]
local itemId=itemData.itemid
local itemNum=itemData.num
local itemGuid=itemData.itemguid
local showCountBG=itemNum>1
local countStr=showCountBG and mathHelper.formatNumber(itemNum)or""
local itemConf={itemid=itemId,itemcount=countStr,showCountBG=showCountBG,showname=false,showStage=true}
local itemProp=itemsComponentHelper.getCommonFillDataSmall(itemConf)
item:SetChildPropData(-1,itemProp)
item:SetBaseItemClickEvent(-1,itemsComponentHelper.onItemClickEx)
end)
self.widget:ForceLayoutRect(self.rewardList:getID())
self.widget:ForceLayoutRect(-1)
end

function xzsChildWBXBDReceive:onProgressStepComplete()
self.animComplete=true
if self.dataCount>=self.currentStep then
self:doNextStep()
else
self:stopOverTick()
self:startOverTick()
end
end

function xzsChildWBXBDReceive:startOverTick()
if not self.overTick then
self.overTick=self:setTimer(self.overPass,1,function()
self:doNextStep()
end)
end
end

function xzsChildWBXBDReceive:stopOverTick()
if self.overTick then
self:stopTimerByID(self.overTick)
self.overTick=nil
end
end




