







def_class("UIEnterFirstRecharge",UICloneObject)





UIEnterFirstRecharge.abName="ui/windows/main/uientrychild/uienternomalitem.ab"

UIEnterFirstRecharge.assetName="UIEnterNomalItem"


function UIEnterFirstRecharge:bindComponents()

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


function UIEnterFirstRecharge:unbindComponents()
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







local iconname='button_hdrk_0004'

function UIEnterFirstRecharge:onLoaded(...)
self:bindComponents()
end

function UIEnterFirstRecharge:__delete()
self.selectIndex=nil
self:stopSelfTimer()
self:unbindComponents()
end

function UIEnterFirstRecharge:onShow(argtable,afterOnloaded)
enterConfig.preInitEnter(self)
local info=argtable.info
local enterIconType=info.enterIconType
local enterType=info.enterType
local cfg=enterConfig.getConfig(enterIconType,enterType)
local abname=enterConfig.getSpriteAB()



self.widget:SetChildActive(0,false)
self.widget:SetChildUIModelShowTarget(7,5206,1,nil,eAnimationID.stand)
self.widget:SetChildUIModelShowTargetOffset(7,0,15)



self:freshReddot()

self.widget:SetChildText(2,'')

self.widget:SetChildText(3,'')

self.widget:SetChildActive(4,false)

self.widget:SetChildButtonClick(0,function()
if not systemModel.isOpen(SYSTEM_DEFINE.eFirstRecharge)then
UIManager.info("首充系统未开启")
return
end

UIManager:showWindow("UIFirstRechargeWin",{id=self.selectIndex})
end,true)
self.widget:SetChildButtonClick(self.clickBg:getID(),function()
if not systemModel.isOpen(SYSTEM_DEFINE.eFirstRecharge)then
UIManager.info("首充系统未开启")
return
end

UIManager:showWindow("UIFirstRechargeWin",{id=self.selectIndex})
end,true)

self.extendbg:setActive(argtable.isEx or false)
self.qipao:setActive(false)
end


function UIEnterFirstRecharge:onHide()

end


function UIEnterFirstRecharge:freshReddot()

UIManager:invokeUIMethod('UIMain','freshSimpleBtnReddot')
local reddot,cfgIndex=firstRechargeModel:checkMainEnterReddot()
self.widget:SetChildActive(1,reddot)

self.selectIndex=firstRechargeModel:getTabSelectIndexBySortCfgIndex(cfgIndex)

local nextRefreshTime=firstRechargeModel:getNextRefreshTime()
if nextRefreshTime then

self:startTimer(nextRefreshTime)
end
end

function UIEnterFirstRecharge:startTimer(nextRefreshTime)
self:stopSelfTimer()

local func=function()
local nowTime=gameUtilityModel.getServerLongTime()
if self==nil or self.isClose or self.widget==nil then return end
if nextRefreshTime-nowTime<=0 then

self:stopSelfTimer()

self:freshReddot()
end
end
self.timer=self:setTimer(1,0,func)
func()
end

function UIEnterFirstRecharge:stopSelfTimer()
if self.timer then
self:stopTimerByID(self.timer)
end
self.timer=nil
end

function UIEnterFirstRecharge:onIcon()

end

function UIEnterFirstRecharge:onClickBg()

end