







def_class("UIEnterXianFaBang",UICloneObject)





UIEnterXianFaBang.abName="ui/windows/main/uientrychild/uienternomalitem.ab"

UIEnterXianFaBang.assetName="UIEnterNomalItem"


function UIEnterXianFaBang:bindComponents()

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


function UIEnterXianFaBang:unbindComponents()
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









function UIEnterXianFaBang:onLoaded(...)
self:bindComponents()

self:addNotify(notifyConfig.onXianFaLunDaoDianZan,function()
self:on_xfld_dianzan()
end)
end


function UIEnterXianFaBang:__delete()
self:unbindComponents()
end

function UIEnterXianFaBang:on_xfld_dianzan()
self.reddot:setActive(UIXianFaWenDaoControl:checkLikeReddot())
end




function UIEnterXianFaBang:onShow(argtable,afterOnloaded)
enterConfig.preInitEnter(self)
local abname=enterConfig.getSpriteAB()
local iconname='button_hdrk_0024'
self.icon:setSprite(abname,iconname)
self.widget:SetChildActive(0,true)
self.widget:SetChildUIModelRemoveTarget(7)
self.name:setText('')

self:startCountDown()
self.reddot:setActive(UIXianFaWenDaoControl:checkLikeReddot())
self.extendbg:setActive(argtable.isEx or false)
self.qipao:setActive(false)
end


function UIEnterXianFaBang:onHide()

end

function UIEnterXianFaBang:startCountDown()
self:clearCountDown()
local endTime=UIXianFaWenDaoControl:getSessionTruceEndTime()
local currtime=gameUtilityModel.getServerShortTime()
local dtime=endTime-currtime
if dtime<=0 then
self.timeBg:setActive(false)
UIXianFaWenDaoControl:removeEnterIcon()
return
end
self.timeBg:setActive(true)
local tick=function()
local dt=endTime-gameUtilityModel.getServerShortTime()
self.time:setText(timeHelper.format_time_stamp11(dt,true))
if dt<=0 then
self:clearCountDown()
UIXianFaWenDaoControl:removeEnterIcon()
end
end
self.timer=self:setTimer(1,0,tick)
tick()
end

function UIEnterXianFaBang:clearCountDown()
if self.timer then
self:stopTimerByID(self.timer)
self.timer=nil
end
end




function UIEnterXianFaBang:showWin()
UIManager:showWindow('UILDRongYuTongWin',{ftype=2})
end

function UIEnterXianFaBang:onIcon()
self:showWin()
end

function UIEnterXianFaBang:onClickBg()
self:showWin()
end