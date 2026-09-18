







def_class("xzsChildDayGiftFree",UICloneObject)





xzsChildDayGiftFree.abName="ui/windows/xiaozhushou/child/xzschilddaygiftfree.ab"

xzsChildDayGiftFree.assetName="xzsChildDayGiftFree"


function xzsChildDayGiftFree:bindComponents()

self.doingText=UIText.get(self,0)
self.errorTx=UIText.get(self,1)
self.icon=UIImage.get(self,2)
self.progress=UIProgressBarAni.get(self,3)
self.rewardContent=UIObject.get(self,4)
self.rewardPanel=UIObject.get(self,5)
self.rewardText=UIText.get(self,6)
self.title=UIText.get(self,7)

end


function xzsChildDayGiftFree:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.doingText);self.doingText=nil;
_UIObject_release(self.errorTx);self.errorTx=nil;
_UIObject_release(self.icon);self.icon=nil;
_UIObject_release(self.progress);self.progress=nil;
_UIObject_release(self.rewardContent);self.rewardContent=nil;
_UIObject_release(self.rewardPanel);self.rewardPanel=nil;
_UIObject_release(self.rewardText);self.rewardText=nil;
_UIObject_release(self.title);self.title=nil;
end






local _ab="ui/windows/xiaozhushou/xzsiconsmall_pak.ab"




function xzsChildDayGiftFree:onLoaded(...)
self:bindComponents()

self._onProgressStepComplete=function(...)
self:onProgressStepComplete(...)
end
self.progress:setFinishAction(self._onProgressStepComplete)

self._onShowPrize=function(...)
self:onShowPrize(...)
end
self:addNotify(notifyConfig.onShowPrize,self._onShowPrize)
end


function xzsChildDayGiftFree:__delete()
self:unbindComponents()

self:stopOverTick()
end




function xzsChildDayGiftFree:onShow(argtable,afterOnloaded)
self.orderID=argtable.orderID
self.detailId=argtable.detailId
self.sub_effecttype2=argtable.sub_effecttype2
self.detailCfg=cfg_xiaozhushoudetailconfig_get(self.detailId)
self.title:setText(self.detailCfg.name)
local iconName=string.format("image_zsjztps_%d",self.detailCfg.icon)
self.icon:setSprite(_ab,iconName)

self.state=argtable.state
if self.state==-1 then
self.rewardPanel:setActive(false)
self.progress:setActive(false)
self.errorTx:setActive(true)
self.errorTx:setText(argtable.error or"")
self.widget:ForceLayoutRect(-1)
if argtable.completeFunc then
argtable.completeFunc()
end
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

self.rewardPanel:setActive(false)
self.progress:setActive(true)
self.errorTx:setActive(false)
self.doingText:setText(self.detailCfg.timeTxt)
self.progress:animateThreeParams(0,10000,0)
self.rewardText:setText(argtable.tipsStr or"获得奖励：")
self:doNextStep()
self.widget:ForceLayoutRect(-1)
end
end


function xzsChildDayGiftFree:onHide()

end



function xzsChildDayGiftFree:onShowPrize(prizeType,temp,effectData,temp2)
if prizeType==ePrizeType.eXZS_Common and effectData.sub_effecttype==self.orderID then
if self.sub_effecttype2 and effectData.sub_effecttype2~=self.sub_effecttype2 then

return
end

for i,v in ipairs(temp)do
showPrizeControl.insertCommon(self.commonList,self.commonLookup,v.itemguid,v.itemid,v.num,true)
end
self.dataCount=self.dataCount+1
if self.animComplete then
if self.currentStep>=self.maxValue then
self:refreshRewards()
elseif self.overTick then
self:doNextStep()
end
end
end
end

function xzsChildDayGiftFree:doNextStep()
self:stopOverTick()
self.animComplete=false

if self.currentStep<self.maxValue then
self.currentStep=self.currentStep+1
self.stepFunc(self.excutes[self.currentStep])
self:doProgressAnim()
else
self.rewardPanel:setActive(true)
self.progress:setActive(false)
self:refreshRewards()
if self.completeFunc then
self.completeFunc()
end
end
end

function xzsChildDayGiftFree:doProgressAnim()
local value=math.floor(self.currentStep*self.perValue)
self.progress:animateThreeParams(value,10000,self.interval)
end

function xzsChildDayGiftFree:refreshRewards()
local count=#self.commonList
table.sort(self.commonList,function(a,b)
return a.sortWeight>b.sortWeight
end)
self.rewardContent:setChildLayoutGroupCreateItems(count,function(index)
local rewardItem=self.rewardContent:getChildLayoutGroupGridItem(index-1)
local itemData=self.commonList[index]
local itemId=itemData.itemid
local itemNum=itemData.num
local itemGuid=itemData.itemguid
local showCountBG=itemNum>1
local countStr=showCountBG and mathHelper.formatNumber(itemNum)or""
local itemConf={itemid=itemId,itemcount=countStr,showCountBG=showCountBG,showname=false,showStage=true}
local itemProp=itemsComponentHelper.getCommonFillDataSmall(itemConf)
rewardItem:SetChildPropData(0,itemProp)
rewardItem:SetBaseItemClickEvent(0,function(...)
itemsComponentHelper.onItemClick(...)
end)
end)
self.widget:ForceLayoutRect(self.rewardContent:getID())
self.widget:ForceLayoutRect(-1)
end

function xzsChildDayGiftFree:onProgressStepComplete()
self.animComplete=true
if self.dataCount>=self.currentStep then
self:doNextStep()
else
self:stopOverTick()
self:startOverTick()
end
end

function xzsChildDayGiftFree:startOverTick()
if not self.overTick then
self.overTick=self:setTimer(self.overPass,1,function()
self:doNextStep()
end)
end
end

function xzsChildDayGiftFree:stopOverTick()
if self.overTick then
self:stopTimerByID(self.overTick)
self.overTick=nil
end
end