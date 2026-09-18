







def_class("xzsChildProgressReward",UICloneObject)





xzsChildProgressReward.abName="ui/windows/xiaozhushou/child/xzschildprogressreward.ab"

xzsChildProgressReward.assetName="xzsChildProgressReward"


function xzsChildProgressReward:bindComponents()

self.doingText=UIText.get(self,0)
self.errorTx=UIText.get(self,1)
self.icon=UIImage.get(self,2)
self.progress=UIProgressBarAni.get(self,3)
self.rewardList=UIObject.get(self,4)
self.rewardText=UIText.get(self,5)
self.title=UIText.get(self,6)

end


function xzsChildProgressReward:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.doingText);self.doingText=nil;
_UIObject_release(self.errorTx);self.errorTx=nil;
_UIObject_release(self.icon);self.icon=nil;
_UIObject_release(self.progress);self.progress=nil;
_UIObject_release(self.rewardList);self.rewardList=nil;
_UIObject_release(self.rewardText);self.rewardText=nil;
_UIObject_release(self.title);self.title=nil;
end





local _ab="ui/windows/xiaozhushou/xzsiconsmall_pak.ab"



function xzsChildProgressReward:onLoaded(...)
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


function xzsChildProgressReward:__delete()
self:unbindComponents()

self:stopOverTick()
end




function xzsChildProgressReward:onShow(argtable,afterOnloaded)
self.orderID=argtable.orderID
self.detailId=argtable.detailId
self.sub_effecttype2=argtable.sub_effecttype2
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

self.rewardList:setActive(false)
self.progress:setActive(true)
self.errorTx:setActive(false)
self.doingText:setText(self.detailCfg.timeTxt)
self.progress:animateThreeParams(0,10000,0)
self.rewardText:setText(argtable.tipsStr or"已获得奖励")
self:doNextStep()
self.widget:ForceLayoutRect(-1)
end
end


function xzsChildProgressReward:onHide()

end



function xzsChildProgressReward:onShowPrize(prizeType,temp,effectData,temp2)
if prizeType==ePrizeType.eXZS_Common and effectData.sub_effecttype==self.orderID then
if(self.sub_effecttype2 and effectData.sub_effecttype2~=self.sub_effecttype2)or(not self.sub_effecttype2 and effectData.sub_effecttype2~=0)then

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

function xzsChildProgressReward:doNextStep()
self:stopOverTick()
self.animComplete=false

if self.currentStep<self.maxValue then
self.currentStep=self.currentStep+1
self.stepFunc(self.excutes[self.currentStep])
self:doProgressAnim()
else
self.rewardList:setActive(true)
self.progress:setActive(false)
self:refreshRewards()
if self.completeFunc then
self.completeFunc()
end
end
end

function xzsChildProgressReward:doProgressAnim()
local value=math.floor(self.currentStep*self.perValue)
self.progress:animateThreeParams(value,10000,self.interval)
end

function xzsChildProgressReward:refreshRewards()
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

function xzsChildProgressReward:onProgressStepComplete()
self.animComplete=true
if self.dataCount>=self.currentStep then
self:doNextStep()
else
self:stopOverTick()
self:startOverTick()
end
end

function xzsChildProgressReward:startOverTick()
if not self.overTick then
self.overTick=self:setTimer(self.overPass,1,function()
self:doNextStep()
end)
end
end

function xzsChildProgressReward:stopOverTick()
if self.overTick then
self:stopTimerByID(self.overTick)
self.overTick=nil
end
end