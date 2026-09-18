







def_class("UIXianTuLookBackItem3",UICloneObject)





UIXianTuLookBackItem3.abName="ui/windows/xiantuchengjiu/child/uixiantulookbackitem3.ab"

UIXianTuLookBackItem3.assetName="UIXianTuLookBackItem3"


function UIXianTuLookBackItem3:bindComponents()

self.timeTx=UIText.get(self,0)
self.effect=UIObject.get(self,1)
self.desc=UIText.get(self,2)

end


function UIXianTuLookBackItem3:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.timeTx);self.timeTx=nil;
_UIObject_release(self.effect);self.effect=nil;
_UIObject_release(self.desc);self.desc=nil;
end









function UIXianTuLookBackItem3:onLoaded(...)
self:bindComponents()
end


function UIXianTuLookBackItem3:__delete()
self:unbindComponents()
end




function UIXianTuLookBackItem3:onShow(argtable,afterOnloaded)
self.data=argtable

self.timeTx:setText(FMT.fmt("道历{0}年",gameUtilityModel.getGameYearPass(self.data.time)))
self.desc:setText(self.data.desc)
self.effect:setAnimationStringID("xiantuhuigu_effect")
end


function UIXianTuLookBackItem3:onHide()

end


