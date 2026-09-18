







def_class("UITianShuDaZhenSettingWin",UIWindowBase)









function UITianShuDaZhenSettingWin:bindComponents()

self.btnConfirm=UIButton.get(self,0)
self.toggle1=UIToggleButton.get(self,1)
self.toggle2=UIToggleButton.get(self,2)
self.toggleText1=UIText.get(self,3)
self.toggleText2=UIText.get(self,4)

self.btnConfirm:setButtonClick(function()self:onBtnConfirm()end)



end


function UITianShuDaZhenSettingWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.btnConfirm);self.btnConfirm=nil;
_UIObject_release(self.toggle1);self.toggle1=nil;
_UIObject_release(self.toggle2);self.toggle2=nil;
_UIObject_release(self.toggleText1);self.toggleText1=nil;
_UIObject_release(self.toggleText2);self.toggleText2=nil;
end


















function UITianShuDaZhenSettingWin:onLoaded(...)
self:bindComponents()
end

function UITianShuDaZhenSettingWin:__delete()
self:unbindComponents()
end

function UITianShuDaZhenSettingWin:onShow(argtable,afterOnloaded)
self.toggle1:setToggleChange(function(...)self:onToggleChanged(eSortOrderEx.eDown,...)end)
self.toggle2:setToggleChange(function(...)self:onToggleChanged(eSortOrderEx.eUp,...)end)
self.sortOrder=argtable.sortOrder
self.orginSortOrder=self.sortOrder
self.callback=argtable.callback
self.toggleText1:setText('自动补充境界最高修士')
self.toggleText2:setText('自动补充境界最低修士')
self:refreshToggles()
end

function UITianShuDaZhenSettingWin:onHide()

end





function UITianShuDaZhenSettingWin:onBtnUp()
end

function UITianShuDaZhenSettingWin:onToggleChanged(sortOrder,name,isToggle,data)
if not isToggle then return end
self.sortOrder=sortOrder
self:refreshToggleRaycast()
if sortOrder==eSortOrderEx.eDown then
self.toggle2:setToggle(self.sortOrder==eSortOrderEx.eUp)
else
self.toggle1:setToggle(self.sortOrder==eSortOrderEx.eDown)
end
end

function UITianShuDaZhenSettingWin:refreshToggles()
self.toggle1:setToggle(self.sortOrder==eSortOrderEx.eDown)
self.toggle2:setToggle(self.sortOrder==eSortOrderEx.eUp)
end

function UITianShuDaZhenSettingWin:refreshToggleRaycast()
self.winlua:SetChildCanvasGroupRaycast(self.toggle1:getID(),self.sortOrder==eSortOrderEx.eUp)
self.winlua:SetChildCanvasGroupRaycast(self.toggle2:getID(),self.sortOrder==eSortOrderEx.eDown)
end

function UITianShuDaZhenSettingWin:onBtnConfirm()
if self.sortOrder~=self.orginSortOrder then
self.callback(self.sortOrder)
end
self:closeSelf()
end