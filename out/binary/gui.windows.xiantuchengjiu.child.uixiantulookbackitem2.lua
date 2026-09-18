







def_class("UIXianTuLookBackItem2",UICloneObject)





UIXianTuLookBackItem2.abName="ui/windows/xiantuchengjiu/child/uixiantulookbackitem2.ab"

UIXianTuLookBackItem2.assetName="UIXianTuLookBackItem2"


function UIXianTuLookBackItem2:bindComponents()

self.timeTx=UIText.get(self,0)
self.effect=UIObject.get(self,1)
self.icon=UIImage.get(self,2)
self.desc=UIText.get(self,3)
self.name=UIText.get(self,4)

end


function UIXianTuLookBackItem2:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.timeTx);self.timeTx=nil;
_UIObject_release(self.effect);self.effect=nil;
_UIObject_release(self.icon);self.icon=nil;
_UIObject_release(self.desc);self.desc=nil;
_UIObject_release(self.name);self.name=nil;
end





local _ab="ui/windows/xiantuchengjiu/xiantuchengjiulookbakc_atlas_pak.ab"



function UIXianTuLookBackItem2:onLoaded(...)
self:bindComponents()
end


function UIXianTuLookBackItem2:__delete()
self:unbindComponents()
end




function UIXianTuLookBackItem2:onShow(argtable,afterOnloaded)
self.data=argtable

self.timeTx:setText(FMT.fmt("道历{0}年",gameUtilityModel.getGameYearPass(self.data.time)))
self.desc:setText(self.data.desc)
self.icon:setSprite(_ab,self.data.image)
self.name:setText(self.data.name)
self.effect:setAnimationStringID("xiantuhuigu_effect")
end


function UIXianTuLookBackItem2:onHide()

end


