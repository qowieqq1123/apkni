







def_class("UIEnterPushGiftTwo",UICloneObject)





UIEnterPushGiftTwo.abName="ui/windows/main/uientrychild/uienternomalitem.ab"

UIEnterPushGiftTwo.assetName="UIEnterNomalItem"


function UIEnterPushGiftTwo:bindComponents()

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


function UIEnterPushGiftTwo:unbindComponents()
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

function UIEnterPushGiftTwo:onLoaded(...)
self:bindComponents()

self.widget:SetChildButtonClick(0,function()
UIFullRechargeController:showPushGiftWin({giftId={self.leftId}})
end,true)
self.widget:SetChildButtonClick(self.clickBg:getID(),function()
UIFullRechargeController:showPushGiftWin({giftId={self.leftId}})
end,true)
end

function UIEnterPushGiftTwo:__delete()
self.showLeft=nil
self:stopLeftTimer()

self:unbindComponents()
end

function UIEnterPushGiftTwo:onShow(argtable,afterOnloaded)
enterConfig.preInitEnter(self)
self:initCountID()
local info=argtable.info
local enterIconType=info.enterIconType
local enterType=info.enterType
local cfg=enterConfig.getConfig(enterIconType,enterType)
local abname=enterConfig.getSpriteAB()

self.reddot:setActive(false)
self.widget:SetChildCSImageSprite(0,abname,iconname)
self.widget:SetChildActive(0,true)
self.widget:SetChildUIModelRemoveTarget(7)

self.widget:SetChildButtonClick(0,function()
UIFullRechargeController:showPushGiftWin({giftId={self.leftId}})
end,true)
self.widget:SetChildButtonClick(self.clickBg:getID(),function()
UIFullRechargeController:showPushGiftWin({giftId={self.leftId}})
end,true)


self:startLeftTimer()
self.extendbg:setActive(argtable.isEx or false)
self.qipao:setActive(false)
end

function UIEnterPushGiftTwo:onHide()

end



function UIEnterPushGiftTwo:onfreshGifts()
local giftIds=pushGiftTwoModel:getLimitGiftIds()
local leftId=giftIds[1]
local change=leftId~=self.leftId
if change then
self:initCountID()
self:startLeftTimer()
end
end


function UIEnterPushGiftTwo:initCountID()
local giftIds=pushGiftTwoModel:getLimitGiftIds()
self.leftId=nil
self.giftIds={}
if#giftIds==0 then
pushGiftTwoManager:removeEnter()
return
end
self.giftIds=table.deepCopy(giftIds)
self.leftId=self.giftIds[1]
end

function UIEnterPushGiftTwo:startLeftTimer()
self:stopLeftTimer()
local func=function()
if self==nil or self.widget==nil then return end
local leftTime=pushGiftTwoModel:getLeftBuyTime(self.leftId)
if leftTime==nil or leftTime<0 then
self:initCountID()
if self.leftId==nil then return end
leftTime=pushGiftTwoModel:getLeftBuyTime(self.leftId)
end
if leftTime and leftTime>=0 then
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
self.ticktimer=self:setTimer(1,0,func)
func()
end

function UIEnterPushGiftTwo:stopLeftTimer()
if self.ticktimer then
self:stopTimerByID(self.ticktimer)
end
self.ticktimer=nil
end

function UIEnterPushGiftTwo:onIcon()

end

function UIEnterPushGiftTwo:onClickBg()

end