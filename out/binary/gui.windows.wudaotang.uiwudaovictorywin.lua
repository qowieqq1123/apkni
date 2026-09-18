







def_class("UIWuDaoVictoryWin",UIWindowBase)









function UIWuDaoVictoryWin:bindComponents()

self.tipsTxt=UIText.get(self,0)
self.disItem=UIObject.get(self,1)



end


function UIWuDaoVictoryWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.tipsTxt);self.tipsTxt=nil;
_UIObject_release(self.disItem);self.disItem=nil;
end

















function UIWuDaoVictoryWin:onLoaded(...)
self:bindComponents()
end


function UIWuDaoVictoryWin:__delete()
self:unbindComponents()
end


function UIWuDaoVictoryWin:onHide()

end




function UIWuDaoVictoryWin:onShow(argtable,afterOnloaded)
self.tipstr=argtable.tipstr
self.disguid=argtable.disguid
self.xwexp=argtable.xwexp

self:updateView()
end

function UIWuDaoVictoryWin:updateView()
self.tipsTxt:setText(self.tipstr or'')

local guid=self.disguid
local disWidget=self.disItem:getChildWidgetBase()

local scale=0.35
comHelper.setChildModelRawImage(disWidget,guid,0,0,eHeadCenterType.eHead)

disWidget:SetChildText(1,UIDiscipleModel:getDiscipleName(guid))

local add_str=FMT.fmt('修为+{0}',self.xwexp)
disWidget:SetChildText(2,add_str)
end