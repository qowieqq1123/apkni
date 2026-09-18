







def_class("UIShangHangRuleViewWin",UIWindowBase)









function UIShangHangRuleViewWin:bindComponents()

self.closeButton=UIButton.get(self,0)
self.select=UIObject.get(self,1)
self.frame=UIImage.get(self,2)
self.name=UIText.get(self,3)
self.icon=UIImage.get(self,4)
self.desc=UIText.get(self,5)
self.quality=UIText.get(self,6)

self.closeButton:setButtonClick(function()UIManager:closeWindow("UIShangHangRuleViewWin")end)



end


function UIShangHangRuleViewWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.closeButton);self.closeButton=nil;
_UIObject_release(self.select);self.select=nil;
_UIObject_release(self.frame);self.frame=nil;
_UIObject_release(self.name);self.name=nil;
_UIObject_release(self.icon);self.icon=nil;
_UIObject_release(self.desc);self.desc=nil;
_UIObject_release(self.quality);self.quality=nil;
end



















function UIShangHangRuleViewWin:onLoaded(...)
self:bindComponents()
end


function UIShangHangRuleViewWin:__delete()
self:unbindComponents()
end




function UIShangHangRuleViewWin:onShow(argtable,afterOnloaded)
local buffList=shangHangModel:getbuffList()

local id=buffList[1]
if not id then
UIManager.error("暂无法则")
self:closeSelf()
return
end

local cfg=cfgHelper.get(cfg_shanghangbuffconfig_get,id)

self.icon:setChildIcon(FMT.fmt("icon_shanghangbuff_{0}",cfg.icon))
self.name:setText(cfg.name)
self.desc:setText(cfg.desc)
end


function UIShangHangRuleViewWin:onHide()

end



