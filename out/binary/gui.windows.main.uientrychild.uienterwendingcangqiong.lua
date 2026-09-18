







def_class("UIEnterWenDingCangQiong",UICloneObject)





UIEnterWenDingCangQiong.abName="ui/windows/main/uientrychild/uienternomalitem.ab"

UIEnterWenDingCangQiong.assetName="UIEnterNomalItem"


function UIEnterWenDingCangQiong:bindComponents()

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


function UIEnterWenDingCangQiong:unbindComponents()
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





local iconname='button_hdrk_0063'




function UIEnterWenDingCangQiong:onLoaded(...)
self:bindComponents()
self:addReddotNotify(REDDIT_TYPE.eWenDingCangQiong,function(...)
self:freshReddot(...)
end)
end


function UIEnterWenDingCangQiong:__delete()
self:stopSelfTimer()
self:unbindComponents()
end




function UIEnterWenDingCangQiong:onShow(argtable,afterOnloaded)
enterConfig.preInitEnter(self)
local info=argtable.info
local enterIconType=info.enterIconType
local enterType=info.enterType
local cfg=enterConfig.getConfig(enterIconType,enterType)
local abname=enterConfig.getSpriteAB()

self.icon:setCSImageSprite(abname,iconname)
self.icon:setActive(true)
self.model:setChildUIModelRemoveTarget()

self.reddot:setActive(false)

self:freshReddot()

self.name:setText('')

self.time:setText('')

self.timeBg:setActive(false)

self.extendbg:setActive(argtable.isEx or false)
self.qipao:setActive(false)
self:startTimer()
end


function UIEnterWenDingCangQiong:onHide()

end

function UIEnterWenDingCangQiong:freshReddot()

UIManager:invokeUIMethod('UIMain','freshSimpleBtnReddot')
local reddot=reddotClassManager.get_reddot(REDDIT_TYPE.eWenDingCangQiong)
self.reddot:setActive(reddot)
end


function UIEnterWenDingCangQiong:onIcon()
UIFullWenDingCangQiongControl:showWin({loading=true})
end

function UIEnterWenDingCangQiong:onClickBg()
UIFullWenDingCangQiongControl:showWin({loading=true})
end


function UIEnterWenDingCangQiong:startTimer()
local endShowTime=WDCQController.getGameEnterEndTime()
if endShowTime then
self.timeBg:setActive(true)
self.endTime=endShowTime
self:stopSelfTimer()

local func=function()
if self==nil or self.isClose or self.widget==nil then return end
local nowTime=gameUtilityModel.getServerShortTime()
local left=self.endTime-nowTime
if left<0 then
left=0
WDCQController:removeEnter()
end
self.time:setText(timeHelper.format_time_stamp3(left))
end
self.timer=self:setTimer(1,0,func)
func()
end
end

function UIEnterWenDingCangQiong:stopSelfTimer()
if self.timer then
self:stopTimerByID(self.timer)
end
self.timer=nil
end