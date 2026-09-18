







def_class("UIAStrokeGameTipsWin",UIWindowBase)









function UIAStrokeGameTipsWin:bindComponents()

self.oneObj=UIObject.get(self,0)
self.threeObj=UIObject.get(self,1)
self.tipstxt=UIText.get(self,2)
self.twoObj=UIObject.get(self,3)



end


function UIAStrokeGameTipsWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.oneObj);self.oneObj=nil;
_UIObject_release(self.threeObj);self.threeObj=nil;
_UIObject_release(self.tipstxt);self.tipstxt=nil;
_UIObject_release(self.twoObj);self.twoObj=nil;
end



















function UIAStrokeGameTipsWin:onLoaded(...)
self:bindComponents()
end


function UIAStrokeGameTipsWin:__delete()
self:unbindComponents()
end




function UIAStrokeGameTipsWin:onShow(argtable,afterOnloaded)
local txttable=cfg_lvfatangconfig_get(1).tipstxt
local oneObj=self.oneObj:getWidgetBase()
oneObj:SetChildText(0,txttable[1][1]or"")
oneObj:SetChildText(1,txttable[1][2]or"")

local twoObj=self.twoObj:getWidgetBase()
twoObj:SetChildText(0,txttable[2][1]or"")
twoObj:SetChildText(1,txttable[2][2]or"")

local threeObj=self.threeObj:getWidgetBase()
threeObj:SetChildText(0,txttable[3][1]or"")
threeObj:SetChildText(1,txttable[3][2]or"")
end


function UIAStrokeGameTipsWin:onHide()

end



