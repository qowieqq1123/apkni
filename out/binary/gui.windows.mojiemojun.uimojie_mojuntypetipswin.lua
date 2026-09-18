







def_class("UIMoJie_MoJunTypeTipsWin",UIWindowBase)









function UIMoJie_MoJunTypeTipsWin:bindComponents()

self.descL1=UIText.get(self,0)
self.descL2=UIText.get(self,1)
self.descL3=UIText.get(self,2)
self.descR1=UIText.get(self,3)
self.descR2=UIText.get(self,4)
self.descR3=UIText.get(self,5)
self.leftTipsPanel=UIObject.get(self,6)
self.lJt=UIObject.get(self,7)
self.rightTipsPanel=UIObject.get(self,8)
self.rJt=UIObject.get(self,9)
self.root=UIObject.get(self,10)



end


function UIMoJie_MoJunTypeTipsWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.descL1);self.descL1=nil;
_UIObject_release(self.descL2);self.descL2=nil;
_UIObject_release(self.descL3);self.descL3=nil;
_UIObject_release(self.descR1);self.descR1=nil;
_UIObject_release(self.descR2);self.descR2=nil;
_UIObject_release(self.descR3);self.descR3=nil;
_UIObject_release(self.leftTipsPanel);self.leftTipsPanel=nil;
_UIObject_release(self.lJt);self.lJt=nil;
_UIObject_release(self.rightTipsPanel);self.rightTipsPanel=nil;
_UIObject_release(self.rJt);self.rJt=nil;
_UIObject_release(self.root);self.root=nil;
end



















function UIMoJie_MoJunTypeTipsWin:onLoaded(...)
self:bindComponents()
end


function UIMoJie_MoJunTypeTipsWin:__delete()
self:unbindComponents()
end




function UIMoJie_MoJunTypeTipsWin:onShow(argtable,afterOnloaded)
self.parentWin=argtable and argtable.parentWin
local isRight=argtable and argtable.isRight

self.leftTipsPanel:setActive(not isRight)
self.rightTipsPanel:setActive(isRight)

local mojunData=xianjieModel:getMoJunData()
local cfg=cfgHelper.get1(cfg_seasonmojunjieshuconfig_get,mojunData.mojunJieShu)

if isRight then
self.descR1:setText("  魔君具有双形态，会随着生命值变化形态:")

self.descR2:setText(FMT.fmt("<color=#bb8cf1>【初形】</color>\n  魔君生命<color=#f1ce78>高于{0}%</color>，形态为初形",cfg.initHP/100))

self.descR3:setText(FMT.fmt("<color=#f36666>【真身】</color>\n  魔君生命<color=#f1ce78>低于{0}%</color>，形态为真身形态，属性提升，\n  并施展效果更强的技能",cfg.initHP/100))
else
self.descL1:setText("  魔君具有双形态，会随着生命值变化形态:")

self.descL2:setText(FMT.fmt("<color=#bb8cf1>【初形】</color>\n  魔君生命<color=#f1ce78>高于{0}%</color>，形态为初形",cfg.initHP/100))

self.descL3:setText(FMT.fmt("<color=#f36666>【真身】</color>\n  魔君生命<color=#f1ce78>低于{0}%</color>，形态为真身形态，属性提升，\n  并施展效果更强的技能",cfg.initHP/100))
end
end


function UIMoJie_MoJunTypeTipsWin:onHide()

end





function UIMoJie_MoJunTypeTipsWin:onCloseBtn()
if self.parentWin then
self.parentWin:closeWindow(self.__name)
else
self:closeSelf()
end
end