







def_class("UIXianTuLookBackItem1",UICloneObject)





UIXianTuLookBackItem1.abName="ui/windows/xiantuchengjiu/child/uixiantulookbackitem1.ab"

UIXianTuLookBackItem1.assetName="UIXianTuLookBackItem1"


function UIXianTuLookBackItem1:bindComponents()

self.timeTx=UIText.get(self,0)
self.effect=UIObject.get(self,1)
self.icon=UIImage.get(self,2)
self.desc=UIText.get(self,3)

end


function UIXianTuLookBackItem1:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.timeTx);self.timeTx=nil;
_UIObject_release(self.effect);self.effect=nil;
_UIObject_release(self.icon);self.icon=nil;
_UIObject_release(self.desc);self.desc=nil;
end









function UIXianTuLookBackItem1:onLoaded(...)
self:bindComponents()
end


function UIXianTuLookBackItem1:__delete()
self:unbindComponents()
end




function UIXianTuLookBackItem1:onShow(argtable,afterOnloaded)
self.data=argtable

self.timeTx:setText(FMT.fmt("道历{0}年",gameUtilityModel.getGameYearPass(self.data.time)))
self.desc:setText(self.data.desc)
self.icon:setImageIcon(self.data.image,true)
self.effect:setAnimationStringID("xiantuhuigu_effect")
end


function UIXianTuLookBackItem1:onHide()

end


