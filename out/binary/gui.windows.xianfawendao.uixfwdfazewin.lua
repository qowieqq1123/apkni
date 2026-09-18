







def_class("UIXFWDFaZeWin",UIWindowBase)









function UIXFWDFaZeWin:bindComponents()

self.icon1=UIObject.get(self,0)
self.name1=UIText.get(self,1)
self.desc1=UIText.get(self,2)
self.icon2=UIObject.get(self,3)
self.name2=UIText.get(self,4)
self.desc2=UIText.get(self,5)
self.effect1=UIObject.get(self,6)
self.effect2=UIObject.get(self,7)



end


function UIXFWDFaZeWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.icon1);self.icon1=nil;
_UIObject_release(self.name1);self.name1=nil;
_UIObject_release(self.desc1);self.desc1=nil;
_UIObject_release(self.icon2);self.icon2=nil;
_UIObject_release(self.name2);self.name2=nil;
_UIObject_release(self.desc2);self.desc2=nil;
_UIObject_release(self.effect1);self.effect1=nil;
_UIObject_release(self.effect2);self.effect2=nil;
end



















function UIXFWDFaZeWin:onLoaded(...)
self:bindComponents()

self.effect1:setChildShowEffect(10104,true)
self.effect2:setChildShowEffect(10108,true)
end


function UIXFWDFaZeWin:__delete()
self:unbindComponents()
end




function UIXFWDFaZeWin:onShow(argtable,afterOnloaded)
local list=UIXianFaWenDaoControl:getFazeList()
local fzId=list[1]
local fcfg=cfgHelper.getSSlawRule(fzId)
self.icon1:setIcon(fcfg.image,true)
self.name1:setText(fcfg.name)
self.desc1:setText(fcfg.desc)

local session=UIXianFaWenDaoControl:getSession()
list=UIXianFaWenDaoControl:getFazeList(session+1)
fzId=list[1]
fcfg=cfgHelper.getSSlawRule(fzId)
self.icon2:setIcon(fcfg.image,true)
self.name2:setText(fcfg.name)
self.desc2:setText(fcfg.desc)
end


function UIXFWDFaZeWin:onHide()

end




function UIXFWDFaZeWin:onCloseClick()
self:closeSelf()
end