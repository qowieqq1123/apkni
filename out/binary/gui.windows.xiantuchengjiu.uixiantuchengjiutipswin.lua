







def_class("UIXianTuChengJiuTipsWin",UIWindowBase)









function UIXianTuChengJiuTipsWin:bindComponents()

self.item_1=UIObject.get(self,0)
self.item_2=UIObject.get(self,1)
self.item_3=UIObject.get(self,2)
self.item={
self.item_1,
self.item_2,
self.item_3,
}



end


function UIXianTuChengJiuTipsWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.item_1);self.item_1=nil;
_UIObject_release(self.item_2);self.item_2=nil;
_UIObject_release(self.item_3);self.item_3=nil;
self.item=nil;
end















local _this=nil
local _itemCmp={
root=-1,
background=0,
nameTx=1,
desc=2,
flag=3,
}
local _waits={

5,11,13,
}
local _interval=0.25
local _waitCnt=6
local _waitAdd=4
local _itemWidth=338









function UIXianTuChengJiuTipsWin:onLoaded(...)
self:bindComponents()
_this=self






for i,v in ipairs(self.item)do
local widget=v:getChildWidgetBase()
widget:SetChildButtonClick(_itemCmp.background,function()
self:onClickItem(i)
end)
widget:SetChildUIModelShowTarget(_itemCmp.background,4233,1,{},eAnimationID.stand,false,false,0)
widget:SetChildUIModelShowTargetOffset(_itemCmp.background,169,0)
end

self.itemCnt=#self.item
self.count=0
self.wait=0
end


function UIXianTuChengJiuTipsWin:__delete()
self:stopUpdateTick()
self:unbindComponents()
_this=nil

end




function UIXianTuChengJiuTipsWin:onShow(argtable,afterOnloaded)
if afterOnloaded then
self:startUpdateTick()
end
end


function UIXianTuChengJiuTipsWin:onHide()

end



function UIXianTuChengJiuTipsWin:startUpdateTick()
if not self.updateTick then
if not self:onUpdateTick()then return end
self.updateTick=self:setTimer(_interval,0,function()
self:onUpdateTick()
end)
end
end

function UIXianTuChengJiuTipsWin:onUpdateTick()
if self.itemCnt>self.count then
if xiantuchengjiuController:checkCanShowTips(false)then

local data=xiantuchengjiuModel:popTaskTips()
self.count=self.count+1
self.wait=_waits[self.count]
local item=self.item[self.count]
self:refreshItem(item,data)
self:doEnter(item)
return true
elseif self.count<=0 then
self:stopUpdateTick()
self:closeSelf()
return false
end
end

if self.wait>0 then
self.wait=self.wait-1
else
for i=1,self.count do
local item=self.item[i]
self:doExit(item)
end
self.count=0
end
return true
end

function UIXianTuChengJiuTipsWin:stopUpdateTick()
if self.updateTick then
self:stopTimerByID(self.updateTick)
self.updateTick=nil
end
end

function UIXianTuChengJiuTipsWin:refreshItem(item,data)



local config=xiantuchengjiuModel:getTaskConfig(data[1],data[2],data[3])
local aimIdx=data[4]
if aimIdx==nil then
loggerUtil.logErrFMT("错误的仙途成就提示文本获取调用 aimIdx {0}",aimIdx)
end
if config==nil then
loggerUtil.logErrFMT("错误的仙途成就提示文本获取调用 config {0}, {1}, {2}, {3}",data[1],data[2],data[3],data[4])
end
if config.taskaims==nil or config.taskaims[aimIdx]==nil then
loggerUtil.logErrFMT("错误的仙途成就提示文本获取调用 没有taskAims {0}, {1}, {2}, {3}",data[1],data[2],data[3],data[4])
end
local desc=xiantuchengjiuModel:findTaskDescEx(config,aimIdx,true)
local widget=item:getChildWidgetBase()
widget:SetChildText(_itemCmp.nameTx,config.taskname)
widget:SetChildText(_itemCmp.desc,desc)
end

function UIXianTuChengJiuTipsWin:doEnter(item)
local widget=item:getChildWidgetBase()
widget:SetChildDOAnchorPosX(_itemCmp.background,0,_interval)
widget:SetChildModelAnimationState(_itemCmp.background,eAnimationID.enter)
end

function UIXianTuChengJiuTipsWin:doExit(item)
local widget=item:getChildWidgetBase()
widget:SetChildDOAnchorPosX(_itemCmp.background,_itemWidth,_interval)
end

function UIXianTuChengJiuTipsWin:onClickItem(index)
self.count=self.itemCnt
self.wait=0
xiantuchengjiuModel:cleanTaskTips()
end
