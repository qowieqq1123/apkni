







def_class("xzsChildWBXBDDispatch",UICloneObject)





xzsChildWBXBDDispatch.abName="ui/windows/xiaozhushou/child/xzschildwbxbddispatch.ab"

xzsChildWBXBDDispatch.assetName="xzsChildWBXBDDispatch"


function xzsChildWBXBDDispatch:bindComponents()

self.costIcon=UIObject.get(self,0)
self.costNum=UIText.get(self,1)
self.costPanel=UIObject.get(self,2)
self.costTitle=UIText.get(self,3)
self.countPanel=UIObject.get(self,4)
self.countText=UIText.get(self,5)
self.doingText=UIText.get(self,6)
self.errorTx=UIText.get(self,7)
self.icon=UIImage.get(self,8)
self.progress=UIProgressBarAni.get(self,9)
self.title=UIText.get(self,10)

end


function xzsChildWBXBDDispatch:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.costIcon);self.costIcon=nil;
_UIObject_release(self.costNum);self.costNum=nil;
_UIObject_release(self.costPanel);self.costPanel=nil;
_UIObject_release(self.costTitle);self.costTitle=nil;
_UIObject_release(self.countPanel);self.countPanel=nil;
_UIObject_release(self.countText);self.countText=nil;
_UIObject_release(self.doingText);self.doingText=nil;
_UIObject_release(self.errorTx);self.errorTx=nil;
_UIObject_release(self.icon);self.icon=nil;
_UIObject_release(self.progress);self.progress=nil;
_UIObject_release(self.title);self.title=nil;
end





local _ab="ui/windows/xiaozhushou/xzsiconsmall_pak.ab"




function xzsChildWBXBDDispatch:onLoaded(...)
self:bindComponents()

self._onProgressStepComplete=function(...)
self:onProgressStepComplete(...)
end
self.progress:setFinishAction(self._onProgressStepComplete)

local func=function(...)
self:onWanBaoXunBaoDuiGoAdventure(...)
end
self:addNotify(notifyConfig.onWanBaoXunBaoDuiGoAdventure,func)
end


function xzsChildWBXBDDispatch:__delete()
self:unbindComponents()
end




function xzsChildWBXBDDispatch:onShow(argtable,afterOnloaded)
self.orderID=argtable.orderID
self.detailId=argtable.detailId
self.detailCfg=cfg_xiaozhushoudetailconfig_get(self.detailId)
self.title:setText(self.detailCfg.name)
local iconName=string.format("image_zsjztps_%d",self.detailCfg.icon)
self.icon:setSprite(_ab,iconName)

self.state=argtable.state
if self.state==-1 then
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
self.result=argtable.result
self.isNeedRestore=argtable.isNeedRestore
self.costCount=argtable.costCount
self.monetType=argtable.monetType

self.commonList={}
self.commonLookup={}
self.currentStep=0
self.dataCount=0
self.animComplete=true
self.maxValue=#self.excutes
self.perValue=10000/self.maxValue

self.progress:setActive(true)
self.errorTx:setActive(false)
self.doingText:setText(self.detailCfg.timeTxt)
self.progress:animateThreeParams(0,10000,0)
self:doNextStep()
end
self.widget:ForceLayoutRect(-1)
end


function xzsChildWBXBDDispatch:onHide()

end




function xzsChildWBXBDDispatch:onWanBaoXunBaoDuiGoAdventure(channel_id)
if self and self.isClose then return end

local idx
for index,excute in ipairs(self.excutes)do
if excute.id==channel_id then
idx=index
break
end
end
if idx then
wanBaoXunBaoDuiController:doShipGo(channel_id)
self.dataCount=self.dataCount+1
if self.animComplete then
if self.currentStep>=self.maxValue then
self:showResult()
elseif self.overTick then
self:doNextStep()
end
end
end
end

function xzsChildWBXBDDispatch:doNextStep()
self:stopOverTick()
self.animComplete=false

if self.currentStep<self.maxValue then
self.currentStep=self.currentStep+1
self.stepFunc(self.excutes[self.currentStep])
self:doProgressAnim()
else
self.progress:setActive(false)
self:showResult()
if self.completeFunc then
self.completeFunc()
end
xiaoZhuShouController:setIdleState()
end
end

function xzsChildWBXBDDispatch:doProgressAnim()
local value=math.floor(self.currentStep*self.perValue)
self.progress:animateThreeParams(value,10000,self.interval)
end

function xzsChildWBXBDDispatch:onProgressStepComplete()
self.animComplete=true
if self.dataCount>=self.currentStep then
self:doNextStep()
else
self:stopOverTick()
self:startOverTick()
end
end

function xzsChildWBXBDDispatch:startOverTick()
if not self.overTick then
self.overTick=self:setTimer(self.overPass,1,function()
self:doNextStep()
end)
end
end

function xzsChildWBXBDDispatch:stopOverTick()
if self.overTick then
self:stopTimerByID(self.overTick)
self.overTick=nil
end
end

function xzsChildWBXBDDispatch:showResult()
self.countText:setText(self.result)

self.countPanel:setActive(true)

self.costPanel:setActive(self.isNeedRestore)
if self.isNeedRestore then
local iconName=itemsModel.getItemIconName(self.monetType)
self.costIcon:setChildIcon(iconName,false)
self.costNum:setText(self.costCount)
self.costTitle:setText("补充体力消耗：")
end
end
