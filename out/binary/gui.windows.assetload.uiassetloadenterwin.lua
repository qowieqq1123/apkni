







def_class("UIAssetLoadEnterWin",UIWindowBase)









function UIAssetLoadEnterWin:bindComponents()

self.precent=UIText.get(self,0)
self.btn=UIButton.get(self,1)

self.btn:setButtonClick(function()self:onBtn()end)



end


function UIAssetLoadEnterWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.precent);self.precent=nil;
_UIObject_release(self.btn);self.btn=nil;
end



















function UIAssetLoadEnterWin:onLoaded(...)
self:bindComponents()
end


function UIAssetLoadEnterWin:__delete()
self:unbindComponents()
end




function UIAssetLoadEnterWin:onShow(argtable,afterOnloaded)
downAssetManager.enterWinInstance=self
local precent=downAssetManager:getDownPrecent()
self.precent:setText(string.format("%d%%",precent))
end


function UIAssetLoadEnterWin:onHide()

end





function UIAssetLoadEnterWin:onBtn()
if downAssetManager.downMode==0 then
UIManager:showWindow('UIAssetLoadWin')
elseif downAssetManager.downMode==1 then
UIManager:showWindow('UIAssetLoadSceneWin')
else
UIManager:showWindow('UIAssetLoadWin')
end
end

function UIAssetLoadEnterWin:onflushProgressTxt()
local precent=downAssetManager:getDownPrecent()
self.precent:setText(string.format("%d%%",precent))
end
