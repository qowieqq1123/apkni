







def_class("UIEnterSuperZuShi",UICloneObject)





UIEnterSuperZuShi.abName="ui/windows/main/uientrychild/uienternomalitem.ab"

UIEnterSuperZuShi.assetName="UIEnterNomalItem"


function UIEnterSuperZuShi:bindComponents()

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


function UIEnterSuperZuShi:unbindComponents()
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







local iconname='button_hdrk_0039'


function UIEnterSuperZuShi:onLoaded(...)
self:bindComponents()
end


function UIEnterSuperZuShi:__delete()
self:stopSelfTimer()
self:unbindComponents()
end




function UIEnterSuperZuShi:onShow(argtable,afterOnloaded)
enterConfig.preInitEnter(self)
local info=argtable.info
local enterIconType=info.enterIconType
local enterType=info.enterType
local cfg=enterConfig.getConfig(enterIconType,enterType)
local abname=enterConfig.getSpriteAB()
self.widget:SetChildCSImageSprite(0,abname,iconname)
self.widget:SetChildActive(0,true)
self.widget:SetChildUIModelRemoveTarget(7)

self.widget:SetChildActive(1,false)

self.widget:SetChildText(2,'')

self.widget:SetChildText(3,'')

self.widget:SetChildActive(4,false)

self.widget:SetChildButtonClick(0,function()
UIManager:showWindow("UISuperZuShiWin")
end,true)
self.widget:SetChildButtonClick(self.clickBg:getID(),function()
UIManager:showWindow("UISuperZuShiWin")
end,true)

self:startTimer()

self.extendbg:setActive(argtable.isEx or false)
self.qipao:setActive(false)
end


function UIEnterSuperZuShi:onHide()

end



function UIEnterSuperZuShi:onIcon()

end

function UIEnterSuperZuShi:onClickBg()

end

function UIEnterSuperZuShi:startTimer()
local isShowEnter,beginShowTime,endShowTime=superZuShiModel:checkSuperZuShiEnterShow()
if isShowEnter and endShowTime then
self.widget:SetChildActive(4,true)
self.endTime=endShowTime
self:stopSelfTimer()

local func=function()
if self==nil or self.isClose or self.widget==nil then return end
local nowTime=gameUtilityModel.getServerLongTime()
local left=self.endTime-nowTime
if left<0 then left=0 end
self.widget:SetChildText(3,timeHelper.format_time_stamp3(left))
end
self.timer=self:setTimer(1,0,func)
func()
end
end

function UIEnterSuperZuShi:stopSelfTimer()
if self.timer then
self:stopTimerByID(self.timer)
end
self.timer=nil
end