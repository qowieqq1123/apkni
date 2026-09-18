







def_class("UILimitActPreviewMainWin",UIWindowBase)









function UILimitActPreviewMainWin:bindComponents()

self.blackBG=UIButton.get(self,0)

self.blackBG:setButtonClick(function()self:onBlackBG()end)



end


function UILimitActPreviewMainWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.blackBG);self.blackBG=nil;
end
















local _this


function UILimitActPreviewMainWin:onLoaded(...)
_this=self
self:bindComponents()

notifySystem:listenNotify(notifyConfig.onLimitActOpen,self.onLimitActOpen)
end


function UILimitActPreviewMainWin:__delete()
_this=nil
self:unbindComponents()

notifySystem:removelistener(notifyConfig.onLimitActOpen,self.onLimitActOpen)
end


function UILimitActPreviewMainWin:onHide()

end

function UILimitActPreviewMainWin.onLimitActOpen(actID,flag)
if _this==nil then return end
if _this.actID~=actID then return end

if not flag then
_this:onBlackBG()
end
end




function UILimitActPreviewMainWin:onShow(argtable,afterOnloaded)
self.actID=argtable.actID

local prewin=limitActivitiesModel:getActConfig(self.actID,'prewin')
if prewin then
local params={actID=self.actID,parentWin='UILimitActPreviewMainWin'}
self:showWindow(prewin,params)
end
end

function UILimitActPreviewMainWin:onBlackBG()
self:closeSelf()
end