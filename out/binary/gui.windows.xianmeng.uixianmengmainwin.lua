







def_class("UIXianMengMainWin",UIWindowBase)









function UIXianMengMainWin:bindComponents()

self.xmdgBtn=UIButton.get(self,0)

self.xmdgBtn:setButtonClick(function()self:onXmdgBtn()end)



end


function UIXianMengMainWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.xmdgBtn);self.xmdgBtn=nil;
end
















local _this=nil


function UIXianMengMainWin:onLoaded(...)
_this=self
self:bindComponents()
self:addNotify(notifyConfig.onNewDay,self.onNewDay)
end


function UIXianMengMainWin:__delete()
_this=nil
self:unbindComponents()
end


function UIXianMengMainWin:onHide()

end

function UIXianMengMainWin.onNewDay()
if _this==nil then return end

_this:refreshxmdgBtn()
end




function UIXianMengMainWin:onShow(argtable,afterOnloaded)
self:refreshxmdgBtn()
end

function UIXianMengMainWin:refreshxmdgBtn()
local isshow=xianmengdigongController:checkOpen()
self.xmdgBtn:setActive(isshow)
end

function UIXianMengMainWin:onXmdgBtn()
limitActivitiesController:jump(LIMIT_ACT_TYPE.eXianMengDiGong)
end