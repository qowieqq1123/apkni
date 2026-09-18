







def_class("UIXianJie_MsgWin",UIWindowBase)









function UIXianJie_MsgWin:bindComponents()

self.msgItemSpe=UIObject.get(self,0)



end


function UIXianJie_MsgWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.msgItemSpe);self.msgItemSpe=nil;
end
















local _this
local _speItem_ChangeInterval=30






local _speItem={
[1]={
sort=1,
abName=globalABLookup.xjcloudicons,
icon="image_xianwutancha_1",
desc="仙雾探查",
showBgImage=true,
click=function()
UIFullCloudUnlockMapControl:showMainWindow()
end,
check=function()
return xianjieModel:checkCloudMsg()
end,
checkReddot=function()
return xianjieModel:checkCloudMsgReddot()
end,
},
}



function UIXianJie_MsgWin:onLoaded(...)
_this=self
self:bindComponents()

self:addNotify(notifyConfig.onXianJieMsgChange,self.onXianJieMsgChange)
self:addNotify(notifyConfig.onXianJieWaiPaiChange,function(...)self.onXianJieMsgChange(1)end)
self.speMsgList={}
end


function UIXianJie_MsgWin:__delete()
self:stopMsgSpeTick()
self:unbindComponents()
_this=nil
end

function UIXianJie_MsgWin.onXianJieMsgChange(iType)
if _this==nil then return end
_this:refreshMsgSpe(iType)
end




function UIXianJie_MsgWin:onShow(argtable,afterOnloaded)
self:checkMsgSpe()
self:setAsLastSibling(-1)
end


function UIXianJie_MsgWin:onHide()

end

function UIXianJie_MsgWin:checkMsgSpe()
for i,v in ipairs(_speItem)do
local check=v.check()
if check then
self:showMsgSpe(i,true)
end
end
end

function UIXianJie_MsgWin:refreshMsgSpe(iType)
local data=_speItem[iType]
local check=data.check()
self:showMsgSpe(iType,check)
end

function UIXianJie_MsgWin:onClickSpeMsg()
local cType=self.forceMsgSpeType or self.speMsgList[self.speMsgShow or 1]
local cData=_speItem[cType]
cData.click()
end

function UIXianJie_MsgWin:forceMsgSpe(iType)
self.forceMsgSpeType=iType
local widget=self.msgItemSpe:getChildWidgetBase()
local data=_speItem[iType]
self.msgItemSpe:setActive(true)
widget:SetChildText(1,data.desc)
widget:SetChildCSImageSprite(2,data.abName,data.icon)
widget:SetChildButtonClick(3,function()
self:onClickSpeMsg()
end)
if data.showBgImage then
widget:SetChildShowEffect(4,0,false)
widget:SetChildActive(7,true)
else
widget:SetChildShowEffect(4,10324,true)
widget:SetChildActive(7,false)
end
widget:SetChildCanvasGroupAlpha(0,1)
widget:SetChildCanvasGroupAlpha(5,0)
local isRed=data.checkReddot and data.checkReddot()
self:doPunchRotation(iType,widget,6,isRed)
self:delayDo(0.2,function()
return widget:SetChildCanvasGroupDOFade(5,1,0.3)
end)
self:stopMsgSpeTick()
end

function UIXianJie_MsgWin:unforceMsgSpe()
self.forceMsgSpeType=nil
local iType=self.speMsgList[1]
if iType then
local widget=self.msgItemSpe:getChildWidgetBase()
local data=_speItem[iType]
self.msgItemSpe:setActive(true)
widget:SetChildText(1,data.desc)
widget:SetChildCSImageSprite(2,data.abName,data.icon)
widget:SetChildButtonClick(3,function()
self:onClickSpeMsg()
end)
if data.showBgImage then
widget:SetChildShowEffect(4,0,false)
widget:SetChildActive(7,true)
else
widget:SetChildShowEffect(4,10324,true)
widget:SetChildActive(7,false)
end
widget:SetChildCanvasGroupAlpha(0,1)
widget:SetChildCanvasGroupAlpha(5,0)
local isRed=data.checkReddot and data.checkReddot()
self:doPunchRotation(iType,widget,6,isRed)
self:delayDo(0.2,function()
return widget:SetChildCanvasGroupDOFade(5,1,0.3)
end)
if#self.speMsgList>1 then
self:startMsgSpeTick()
end
else
local widget=self.msgItemSpe:getChildWidgetBase()
widget:SetChildShowEffect(4,0,false)
widget:SetChildActive(7,false)
self.msgItemSpe:setActive(false)
self:stopMsgSpeTick()
end
end

function UIXianJie_MsgWin:showMsgSpe(iType,iShow)
if iShow then
if not table.containsValue(self.speMsgList,iType)then
local widget=self.msgItemSpe:getChildWidgetBase()
local data=_speItem[iType]
if data then
local oType=self.speMsgList[1]
table.insert(self.speMsgList,iType)
table.sort(self.speMsgList,function(a,b)
return _speItem[a].sort<_speItem[b].sort
end)
if oType~=self.speMsgList[1]and not self.isForceMsgSpe then
self.msgItemSpe:setActive(true)
widget:SetChildText(1,data.desc)
widget:SetChildCSImageSprite(2,data.abName,data.icon)
widget:SetChildButtonClick(3,function()
self:onClickSpeMsg()
end)
if data.showBgImage then
widget:SetChildShowEffect(4,0,false)
widget:SetChildActive(7,true)
else
widget:SetChildShowEffect(4,10324,true)
widget:SetChildActive(7,false)
end
widget:SetChildCanvasGroupAlpha(0,1)
widget:SetChildCanvasGroupAlpha(5,0)
local isRed=data.checkReddot and data.checkReddot()
self:doPunchRotation(iType,widget,6,isRed)
self:delayDo(0.2,function()
return widget:SetChildCanvasGroupDOFade(5,1,0.3)
end)
end
if#self.speMsgList>1 then
self:startMsgSpeTick()
end
end
else
local widget=self.msgItemSpe:getChildWidgetBase()
local data=_speItem[iType]
local isRed=data.checkReddot and data.checkReddot()
self:doPunchRotation(iType,widget,6,isRed)
end
else
local index=table.findValue(self.speMsgList,iType)
if index then
local curIType=table.remove(self.speMsgList,index)
if index==1 and not self.isForceMsgSpe then
local data=_speItem[curIType]
local widget=self.msgItemSpe:getChildWidgetBase()
if#self.speMsgList>0 then
self.msgItemSpe:setActive(true)
widget:SetChildText(1,data.desc)
widget:SetChildCSImageSprite(2,data.abName,data.icon)
widget:SetChildButtonClick(3,function()
data.click()
end)
if data.showBgImage then
widget:SetChildShowEffect(4,0,false)
widget:SetChildActive(7,true)
else
widget:SetChildShowEffect(4,10324,true)
widget:SetChildActive(7,false)
end
widget:SetChildCanvasGroupAlpha(0,1)
widget:SetChildCanvasGroupAlpha(5,0)
local isRed=data.checkReddot and data.checkReddot()
self:doPunchRotation(curIType,widget,6,isRed)
self:delayDo(0.2,function()
return widget:SetChildCanvasGroupDOFade(5,1,0.3)
end)
else
widget:SetChildShowEffect(4,0,false)
widget:SetChildActive(7,false)
self.msgItemSpe:setActive(false)
end
end
if#self.speMsgList<=1 then
self:stopMsgSpeTick()
end
end
end
end

function UIXianJie_MsgWin:startMsgSpeTick()
if not self.speMsgTick then
self.speMsgTick=self:setTimer(_speItem_ChangeInterval,0,function()
self:onMsgSpeTick()
end)
self.speMsgShow=1
end
end

function UIXianJie_MsgWin:stopMsgSpeTick()
if self.speMsgTick then
self:stopTimerByID(self.speMsgTick)
self.speMsgTick=nil
self.speMsgShow=nil
end
end

function UIXianJie_MsgWin:onMsgSpeTick()
self.speMsgShow=self.speMsgShow+1
local count=#self.speMsgList
if self.speMsgShow>count then
self.speMsgShow=1
end
local iType=self.speMsgList[self.speMsgShow]
local data=_speItem[iType]
local widget=self.msgItemSpe:getChildWidgetBase()
self.msgItemSpe:setActive(true)
widget:SetChildText(1,data.desc)
widget:SetChildCSImageSprite(2,data.abName,data.icon)
widget:SetChildButtonClick(3,function()
data.click()
end)
if data.showBgImage then
widget:SetChildShowEffect(4,0,false)
widget:SetChildActive(7,true)
else
widget:SetChildShowEffect(4,10324,true)
widget:SetChildActive(7,false)
end
widget:SetChildCanvasGroupAlpha(0,1)
widget:SetChildCanvasGroupAlpha(5,0)
local isRed=data.checkReddot and data.checkReddot()
self:doPunchRotation(iType,widget,6,isRed)
self:delayDo(0.2,function()
return widget:SetChildCanvasGroupDOFade(5,1,0.3)
end)
end

function UIXianJie_MsgWin:doPunchRotation(type,widget,idx,isRed)
if self.reddotTweener==nil then
self.reddotTweener={}
end
widget:SetChildActive(idx,isRed)
if isRed then
widget:SetChildActive(idx,true)
if self.reddotTweener[type]==nil then
widget:SetChildRotation(idx,0,0,0)
local tweener=widget:SetChildDOPunchRotation(idx,Vector3(0,0,15),2,2,1)
tweener:SetEase(_Ease.Linear)
tweener:SetLoops(-1,_LoopType.Restart)
self.reddotTweener[type]=tweener
end
else
widget:SetChildActive(idx,false)
if self.reddotTweener[type]~=nil then
self.reddotTweener[type]:Complete()
self.reddotTweener[type]:Kill()
self.reddotTweener[type]=nil
widget:SetChildRotation(idx,0,0,0)
end
end
end