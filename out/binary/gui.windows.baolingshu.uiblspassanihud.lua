







def_class("UIBLSPassAniHUD",UICloneObject)





UIBLSPassAniHUD.abName="ui/windows/baolingshu/uiblspassanihud.ab"

UIBLSPassAniHUD.assetName="UIBLSPassAniHUD"


function UIBLSPassAniHUD:bindComponents()

self.passAni=UIToggleButton.get(self,0)
self.root=UIObject.get(self,1)

end


function UIBLSPassAniHUD:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.passAni);self.passAni=nil;
_UIObject_release(self.root);self.root=nil;
end









function UIBLSPassAniHUD:onLoaded(...)
self:bindComponents()

self:setChildButtonClickDown(self.passAni:getID(),function(...)
self:onChangePassAni()
end,true,0)
end


function UIBLSPassAniHUD:__delete()
baoLingShuModel:saveBLSPassAniState()
self:unbindComponents()
end




function UIBLSPassAniHUD:onShow(argtable,afterOnloaded)
self.checkPass=baoLingShuModel:getBLSPassAniState()
self.passAni:setToggle(self.checkPass)

local _worldOffset=fightModel.getWorldCenter()
self:setChildPosition(self.root:getID(),Vector3.New(-9.5,1.6,4)+_worldOffset)

self:setChildScale(self.root:getID(),Vector3(1.7,1.7,1))
end


function UIBLSPassAniHUD:onHide()

end

function UIBLSPassAniHUD:onChangePassAni()
self.checkPass=not self.checkPass
baoLingShuModel:changeBLSPassAniState(self.checkPass)
end

