







def_class("UIEnterPushGift",UICloneObject)





UIEnterPushGift.abName="ui/windows/main/uientrychild/uienternomalitem.ab"

UIEnterPushGift.assetName="UIEnterNomalItem"


function UIEnterPushGift:bindComponents()

self.icon=UIButton.get(self,0)
self.reddot=UIObject.get(self,1)
self.name=UIText.get(self,2)
self.time=UIText.get(self,3)
self.timeBg=UIObject.get(self,4)
self.qipao=UIObject.get(self,5)
self.qipaoText=UIText.get(self,6)
self.model=UIObject.get(self,7)
self.clickBg=UIButton.get(self,8)
self.extendbg=UIObject.get(self,9)
self.lldhQiPao=UIObject.get(self,10)

self.icon:setButtonClick(function()self:onIcon()end)

self.clickBg:setButtonClick(function()self:onClickBg()end)

end


function UIEnterPushGift:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.icon);self.icon=nil;
_UIObject_release(self.reddot);self.reddot=nil;
_UIObject_release(self.name);self.name=nil;
_UIObject_release(self.time);self.time=nil;
_UIObject_release(self.timeBg);self.timeBg=nil;
_UIObject_release(self.qipao);self.qipao=nil;
_UIObject_release(self.qipaoText);self.qipaoText=nil;
_UIObject_release(self.model);self.model=nil;
_UIObject_release(self.clickBg);self.clickBg=nil;
_UIObject_release(self.extendbg);self.extendbg=nil;
_UIObject_release(self.lldhQiPao);self.lldhQiPao=nil;
end







local iconname='button_hdrk_0000'

function UIEnterPushGift:onLoaded(...)
self:bindComponents()
notifySystem:listenNotify(notifyConfig.onZongMenFightChange,self.freshReddot_event)
notifySystem:listenNotify(notifyConfig.onDiscipleCreate,self.freshReddot_event)
notifySystem:listenNotify(notifyConfig.onDiscipleJJChange,self.freshReddot_event)
notifySystem:listenNotify(notifyConfig.onDiscipleJJBroke,self.freshReddot_event)
notifySystem:listenNotify(notifyConfig.onDiscipleLTChange,self.freshReddot_event)
notifySystem:listenNotify(notifyConfig.onGuBaoActive,self.freshReddot_event)

self.widget:SetChildButtonClick(0,function()
UIManager:showWindow('UIPushGiftWin')
end,true)
self.widget:SetChildButtonClick(self.clickBg:getID(),function()
UIManager:showWindow('UIPushGiftWin')
end,true)
end

function UIEnterPushGift:__delete()
self.showLeft=nil
self:stopLeftTimer()
notifySystem:removelistener(notifyConfig.onZongMenFightChange,self.freshReddot_event)
notifySystem:removelistener(notifyConfig.onDiscipleCreate,self.freshReddot_event)
notifySystem:removelistener(notifyConfig.onDiscipleJJChange,self.freshReddot_event)
notifySystem:removelistener(notifyConfig.onDiscipleJJBroke,self.freshReddot_event)
notifySystem:removelistener(notifyConfig.onDiscipleLTChange,self.freshReddot_event)
notifySystem:removelistener(notifyConfig.onGuBaoActive,self.freshReddot_event)
self:unbindComponents()
end

function UIEnterPushGift:onShow(argtable,afterOnloaded)
enterConfig.preInitEnter(self)
local info=argtable.info
local enterIconType=info.enterIconType
local enterType=info.enterType
local cfg=enterConfig.getConfig(enterIconType,enterType)
local abname=enterConfig.getSpriteAB()

self.widget:SetChildCSImageSprite(0,abname,iconname)
self.widget:SetChildActive(0,true)
self.widget:SetChildUIModelRemoveTarget(7)


self.reddot:setActive(false)






self.widget:SetChildButtonClick(0,function()
UIManager:showWindow('UIPushGiftWin')
end,true)
self.widget:SetChildButtonClick(self.clickBg:getID(),function()
UIManager:showWindow('UIPushGiftWin')
end,true)


self:startLeftTimer()
self.extendbg:setActive(argtable.isEx or false)
self.qipao:setActive(false)
end

function UIEnterPushGift:onHide()

end




function UIEnterPushGift:freshReddot()

end

function UIEnterPushGift:freshLeftID()
local ids=pushGiftModel:getGiftIds()
if#ids==0 then
self:stopLeftTimer()
pushGiftManager:removeEnter()
return
end
local left
local leftId
for _,id in ipairs(ids)do
local leftTimes=pushGiftModel:getLeftBuyTimes(id)or 0
local _left=pushGiftModel:getLeftBuyTime(id)or 0
if leftTimes>0 and(left==nil or left>_left)then
left=_left
leftId=id
end
end
self.leftId=leftId
end

function UIEnterPushGift:startLeftTimer()
self:freshLeftID()
self:stopLeftTimer()
local func=function()
if self.widget==nil then return end
if self.leftId==nil then
self:freshLeftID()

if not self.timer then

return
end
end
if self.leftId==nil then
if self.showLeft==false then return end
self.showLeft=false
self.widget:SetChildText(3,'')
self.widget:SetChildActive(4,false)
return
end
local leftTime=pushGiftModel:getLeftBuyTime(self.leftId)
if leftTime==nil or leftTime<0 then
self:freshLeftID()
leftTime=pushGiftModel:getLeftBuyTime(self.leftId)

if not self.timer then

return
end
end
if leftTime and leftTime>=0 and leftTime<=24*3600 then
if not self.showLeft then
self.widget:SetChildActive(4,true)
end
self.showLeft=true
self.widget:SetChildText(3,timeHelper.format_time_stamp13(leftTime))
else
if self.showLeft==false then return end
self.showLeft=false
self.widget:SetChildText(3,'')
self.widget:SetChildActive(4,false)
end
end
self.timer=self:setTimer(1,0,func)
func()
end

function UIEnterPushGift:stopLeftTimer()
if self.timer then
self:stopTimerByID(self.timer)
end
self.timer=nil
end

function UIEnterPushGift:onIcon()

end

function UIEnterPushGift:onClickBg()

end