







def_class("UIFeiShengTaiEffectWin",UIWindowBase)









function UIFeiShengTaiEffectWin:bindComponents()

self.effect_1=UIObject.get(self,0)
self.effect_2=UIObject.get(self,1)
self.effect_3=UIObject.get(self,2)
self.effect_4=UIObject.get(self,3)
self.effect_5=UIObject.get(self,4)
self.passBtn=UIButton.get(self,5)
self.root=UIObject.get(self,6)

self.passBtn:setButtonClick(function()self:onPassBtn()end)
self.effect={
self.effect_1,
self.effect_2,
self.effect_3,
self.effect_4,
self.effect_5,
}



end


function UIFeiShengTaiEffectWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.effect_1);self.effect_1=nil;
_UIObject_release(self.effect_2);self.effect_2=nil;
_UIObject_release(self.effect_3);self.effect_3=nil;
_UIObject_release(self.effect_4);self.effect_4=nil;
_UIObject_release(self.effect_5);self.effect_5=nil;
_UIObject_release(self.passBtn);self.passBtn=nil;
_UIObject_release(self.root);self.root=nil;
self.effect=nil;
end



















function UIFeiShengTaiEffectWin:onLoaded(...)
self:bindComponents()
end


function UIFeiShengTaiEffectWin:__delete()
self:unbindComponents()
end




function UIFeiShengTaiEffectWin:onShow(argtable,afterOnloaded)

end


function UIFeiShengTaiEffectWin:onHide()

end



function UIFeiShengTaiEffectWin:playEffect(id,index)
self.effect[index]:setChildShowEffect(id,true)
end

function UIFeiShengTaiEffectWin:playCameraEffect(id)
local parent=_MapManager.GetCameraTransform()
local effectId=_MapManager.PlayEffectByParent(parent,id)
FeiShengTaiModel:setEffectId(effectId)
end

function UIFeiShengTaiEffectWin:onPassBtn()

end