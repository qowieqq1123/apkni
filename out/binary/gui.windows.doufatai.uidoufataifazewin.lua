







def_class("UIDouFaTaiFaZeWin",UIWindowBase)









function UIDouFaTaiFaZeWin:bindComponents()

self.backEffect=UIObject.get(self,0)
self.effect=UIObject.get(self,1)
self.curSkillIcon=UIImage.get(self,2)
self.curSkillName=UIText.get(self,3)
self.curSkillDesc=UIText.get(self,4)
self.nextSkillIcon=UIImage.get(self,5)
self.nextSkillName=UIText.get(self,6)
self.nextSkillDesc=UIText.get(self,7)



end


function UIDouFaTaiFaZeWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.backEffect);self.backEffect=nil;
_UIObject_release(self.effect);self.effect=nil;
_UIObject_release(self.curSkillIcon);self.curSkillIcon=nil;
_UIObject_release(self.curSkillName);self.curSkillName=nil;
_UIObject_release(self.curSkillDesc);self.curSkillDesc=nil;
_UIObject_release(self.nextSkillIcon);self.nextSkillIcon=nil;
_UIObject_release(self.nextSkillName);self.nextSkillName=nil;
_UIObject_release(self.nextSkillDesc);self.nextSkillDesc=nil;
end



















function UIDouFaTaiFaZeWin:onLoaded(...)
self:bindComponents()
end


function UIDouFaTaiFaZeWin:__delete()
self:unbindComponents()
end




function UIDouFaTaiFaZeWin:onShow(argtable,afterOnloaded)
local curIconName=iconHelper.getSkillIcon(1)
self.curSkillIcon:setImageIcon(curIconName,false)
self.curSkillName:setText('本赛季法则')
self.curSkillDesc:setText('本赛季法则描述')

local nextIconName=iconHelper.getSkillIcon(2)
self.nextSkillIcon:setImageIcon(nextIconName,false)
self.nextSkillName:setText('下赛季法则')
self.nextSkillDesc:setText('下个赛季法则描述')

self.effect:setChildShowEffect(10108,true)
self.backEffect:setChildShowEffect(10104,true)
end


function UIDouFaTaiFaZeWin:onHide()

end





function UIDouFaTaiFaZeWin:onCloseBtn()
UIFullDouFaTaiControl:closeWindow(self.winlua.name)
end

