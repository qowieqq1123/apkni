







def_class("UIWenXinGuanEnterBgWin",UIWindowBase)









function UIWenXinGuanEnterBgWin:bindComponents()

self.bg=UIObject.get(self,0)
self.bgImg=UIObject.get(self,1)
self.effect=UIObject.get(self,2)



end


function UIWenXinGuanEnterBgWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.bg);self.bg=nil;
_UIObject_release(self.bgImg);self.bgImg=nil;
_UIObject_release(self.effect);self.effect=nil;
end



















local this


function UIWenXinGuanEnterBgWin:onLoaded(...)
self:bindComponents()
this=self
end


function UIWenXinGuanEnterBgWin:__delete()
self:unbindComponents()
this=nil
end




function UIWenXinGuanEnterBgWin:onShow(argtable,afterOnloaded)

end


function UIWenXinGuanEnterBgWin:onHide()

end



function UIWenXinGuanEnterBgWin:showBgModel()
local value=1
local animId=eAnimationID.enter
local cb=function()
self:delayDo(2,function()
UIManager:invokeUIMethod("UIWenXinGuanEnterWin","onDoFadeImg",value,value)

end)
end

self.winlua:SetChildUIModelEnableInitUISpineParaEx(self.bg:getID(),false,true,false)
self.bg:setChildUIModelShowTarget(5534,1,{},animId,false,false,0,cb)
end

function UIWenXinGuanEnterBgWin:playEffect()
local animId=2601
self.effect:setChildShowEffect(20426,true)
self.bg:setChildModelAnimationState(animId)
self:doFade(0,1.5)
end

function UIWenXinGuanEnterBgWin:doFade(value,time)
local tweener=this.bgImg:setChildCanvasGroupDOFade(value,time)
tweener:SetEase(DG.Tweening.Ease.Linear)
end