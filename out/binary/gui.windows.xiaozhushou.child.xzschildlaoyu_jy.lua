







def_class("xzsChildLaoYu_JY",UICloneObject)





xzsChildLaoYu_JY.abName="ui/windows/xiaozhushou/child/xzschildlaoyu_jy.ab"

xzsChildLaoYu_JY.assetName="xzsChildLaoYu_JY"


function xzsChildLaoYu_JY:bindComponents()

self.countPanel=UIObject.get(self,0)
self.countText=UIText.get(self,1)
self.doingText=UIText.get(self,2)
self.errPanel=UIObject.get(self,3)
self.errText=UIText.get(self,4)
self.icon=UIImage.get(self,5)
self.progress=UIProgressBarAni.get(self,6)
self.rewardList=UIObject.get(self,7)
self.rewardPanel=UIObject.get(self,8)
self.rewardText=UIText.get(self,9)
self.rewardView=UIObject.get(self,10)
self.title=UIText.get(self,11)

end


function xzsChildLaoYu_JY:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.countPanel);self.countPanel=nil;
_UIObject_release(self.countText);self.countText=nil;
_UIObject_release(self.doingText);self.doingText=nil;
_UIObject_release(self.errPanel);self.errPanel=nil;
_UIObject_release(self.errText);self.errText=nil;
_UIObject_release(self.icon);self.icon=nil;
_UIObject_release(self.progress);self.progress=nil;
_UIObject_release(self.rewardList);self.rewardList=nil;
_UIObject_release(self.rewardPanel);self.rewardPanel=nil;
_UIObject_release(self.rewardText);self.rewardText=nil;
_UIObject_release(self.rewardView);self.rewardView=nil;
_UIObject_release(self.title);self.title=nil;
end









function xzsChildLaoYu_JY:onLoaded(...)
self:bindComponents()
self._onProgressStepComplete=function(...)
self:onProgressStepComplete(...)
end
self.progress:setFinishAction(self._onProgressStepComplete)

self._onShowPrize=function(...)
self:onShowPrize(...)
end
self:addNotify(notifyConfig.onJiuYouPrizeChange,self._onShowPrize)
end


function xzsChildLaoYu_JY:__delete()
self:unbindComponents()

self:stopOverTick()
end




function xzsChildLaoYu_JY:onShow(argtable,afterOnloaded)
local detailId=argtable.detailId
self.orderID=argtable.orderID
self.detailId=argtable.detailId
self.detailCfg=cfg_xiaozhushoudetailconfig_get(detailId)
self.title:setText(self.detailCfg.name)
self.icon:setSprite("ui/windows/xiaozhushou/xzsiconsmall_pak.ab",string.format("image_zsjztps_%d",self.detailCfg.icon))

self.state=argtable.state
if self.state==-1 then
self.rewardPanel:setActive(false)
self.progress:setActive(false)
self.errPanel:setActive(true)
self.errText:setText(argtable.error or"")
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
self.errPanel:setActive(false)
self.doingText:setText(self.detailCfg.timeTxt)
self.progress:animateThreeParams(0,10000,0)
self.rewardText:setText(argtable.tipsStr or"已获得奖励：")
self.countTextStr=argtable.countStr
self:doNextStep()
end
end


function xzsChildLaoYu_JY:onHide()

end

function xzsChildLaoYu_JY:onShowPrize(len,temp)
if len>0 then
for i,v in ipairs(temp)do
showPrizeControl.insertCommon(self.commonList,self.commonLookup,nil,v.param_1,v.param_2,true)
end
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

function xzsChildLaoYu_JY:doNextStep()
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

function xzsChildLaoYu_JY:doProgressAnim()
local value=math.floor(self.currentStep*self.perValue)
self.progress:animateThreeParams(value,10000,self.interval)
end

function xzsChildLaoYu_JY:refreshRewards()
local count=#self.commonList
table.sort(self.commonList,function(a,b)
return a.sortWeight>b.sortWeight
end)
self.rewardView:setChildScrollRectEnable(count>10)
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

if self.countTextStr then
self.countPanel:setActive(true)
self.countText:setText(self.countTextStr)
else
self.countPanel:setActive(false)
end
end

function xzsChildLaoYu_JY:onProgressStepComplete()
self.animComplete=true
if self.dataCount>=self.currentStep then
self:doNextStep()
else
self:stopOverTick()
self:startOverTick()
end
end

function xzsChildLaoYu_JY:startOverTick()
if not self.overTick then
self.overTick=self:setTimer(self.overPass,1,function()
self:doNextStep()
end)
end
end

function xzsChildLaoYu_JY:stopOverTick()
if self.overTick then
self:stopTimerByID(self.overTick)
self.overTick=nil
end
end


