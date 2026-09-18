







def_class("UIXianZhanReBuildItemTipsWin",UIWindowBase)









function UIXianZhanReBuildItemTipsWin:bindComponents()

self.nameText=UIText.get(self,0)
self.contentText=UIText.get(self,1)
self.iconImg=UIImage.get(self,2)
self.countText=UIText.get(self,3)



end


function UIXianZhanReBuildItemTipsWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.nameText);self.nameText=nil;
_UIObject_release(self.contentText);self.contentText=nil;
_UIObject_release(self.iconImg);self.iconImg=nil;
_UIObject_release(self.countText);self.countText=nil;
end



















function UIXianZhanReBuildItemTipsWin:onLoaded(...)
self:bindComponents()
end


function UIXianZhanReBuildItemTipsWin:__delete()
self:unbindComponents()
end




function UIXianZhanReBuildItemTipsWin:onShow(argtable,afterOnloaded)
local config=argtable

self.nameText:setText(config.name)
self.contentText:setText(config.desc)
self.iconImg:setImageIcon(iconHelper.getIconName(eMoneyType.mtLingShi),false)
local lsnum=xianzhanModel:getZuJin(config.getLingShi)
self.countText:setText(FMT.fmt('{0}/年',lsnum))
end


function UIXianZhanReBuildItemTipsWin:onHide()

end



