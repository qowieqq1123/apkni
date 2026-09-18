







def_class("UIEnterWenDingBang",UICloneObject)





UIEnterWenDingBang.abName="ui/windows/main/uientrychild/uienternomalitem.ab"

UIEnterWenDingBang.assetName="UIEnterNomalItem"


function UIEnterWenDingBang:bindComponents()

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


function UIEnterWenDingBang:unbindComponents()
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





local iconname='button_hdrk_0064'



function UIEnterWenDingBang:onLoaded(...)
self:bindComponents()
end


function UIEnterWenDingBang:__delete()
self:unbindComponents()
end




function UIEnterWenDingBang:onShow(argtable,afterOnloaded)
enterConfig.preInitEnter(self)
local info=argtable.info
local enterIconType=info.enterIconType
local enterType=info.enterType
local abname=enterConfig.getSpriteAB()


self:freshReddot()


self.widget:SetChildText(2,'')


self.widget:SetChildText(3,'')


self.widget:SetChildActive(4,true)

self:startLeftTimer()

self.widget:SetChildCSImageSprite(0,abname,iconname)
self.widget:SetChildActive(0,true)
self.widget:SetChildUIModelRemoveTarget(7)

self.extendbg:setActive(argtable.isEx or false)
self.qipao:setActive(false)
end


function UIEnterWenDingBang:onHide()

end


function UIEnterWenDingBang:freshReddot()
local reddot=WDCQController.checkRongYuBangEnterReddot()
self.widget:SetChildActive(1,reddot)
end



function UIEnterWenDingBang:onClickBg()
WDCQController.clickRongYuBangEnter()
end

function UIEnterWenDingBang:onIcon()
WDCQController.clickRongYuBangEnter()
end


function UIEnterWenDingBang:stopLeftTimer()
if self.timeId then
self:stopTimerByID(self.timeId)
self.timeId=nil
end
end

function UIEnterWenDingBang:startLeftTimer()
self:stopLeftTimer()



local leftStamp=WDCQController.getRongYuBangEnterLeftTime()

local func=function()

local serverTime=timeHelper.getServerShortTime()
local left=leftStamp-serverTime

local timeStr=timeHelper.format_time_stamp3(left)
self.widget:SetChildText(3,timeStr)

if left<=0 then
WDCQController:removeRongYuBangActEnter()
end
end

self.timeId=self:setTimer(1,0,func)
func()
end


