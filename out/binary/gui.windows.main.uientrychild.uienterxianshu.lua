







def_class("UIEnterXianShu",UICloneObject)





UIEnterXianShu.abName="ui/windows/main/uientrychild/uienternomalitem.ab"

UIEnterXianShu.assetName="UIEnterNomalItem"


function UIEnterXianShu:bindComponents()

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


function UIEnterXianShu:unbindComponents()
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









function UIEnterXianShu:onLoaded(...)
self:bindComponents()

self:addNotify(notifyConfig.onXianShuChange,function()
self:on_xianshu_change()
end)
end


function UIEnterXianShu:__delete()
self:unbindComponents()

self:clearCountDown()
end

function UIEnterXianShu:on_xianshu_change()
self.reddot:setActive(UIXianShuControl:checkReddot())
end




function UIEnterXianShu:onShow(argtable,afterOnloaded)
enterConfig.preInitEnter(self)
local abname=enterConfig.getSpriteAB()
local iconname='button_hdrk_0002'
self.icon:setSprite(abname,iconname)
self.widget:SetChildActive(0,true)
self.widget:SetChildUIModelRemoveTarget(7)
self.name:setText('')

self:startCountDown()


self.widget:SetChildActive(1,UIXianShuControl:checkReddot())
self.extendbg:setActive(argtable.isEx or false)
self.qipao:setActive(false)
end


function UIEnterXianShu:onHide()

end

function UIEnterXianShu:startCountDown()
self:clearCountDown()
local rtime=UIXianShuControl:getRemainingTime()
if rtime<=0 then
self.timeBg:setActive(false)
return
end
self.timeBg:setActive(true)
local endTime=os.time()+rtime
local tick=function()
if not self or self.isClose then return end
local dt=endTime-os.time()
self.time:setText(timeHelper.format_time_stamp11(dt,true))
if dt<=0 then
UIXianShuControl:removeEnterIcon()
end
end
self.timer=self:setTimer(1,rtime+5,tick)
tick()
end

function UIEnterXianShu:clearCountDown()
if self.timer then
self:stopTimerByID(self.timer)
self.timer=nil
end
end




function UIEnterXianShu:onIcon()
UIXianShuControl:showXianShuWin()
end

function UIEnterXianShu:onClickBg()
UIXianShuControl:showXianShuWin()
end