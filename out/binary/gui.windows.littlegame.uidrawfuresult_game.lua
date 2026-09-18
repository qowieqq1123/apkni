







def_class("UIDrawFuResult_game",UIWindowBase)









function UIDrawFuResult_game:bindComponents()

self.ratingImg=UIImage.get(self,0)
self.tipsTxt=UIText.get(self,1)



end


function UIDrawFuResult_game:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.ratingImg);self.ratingImg=nil;
_UIObject_release(self.tipsTxt);self.tipsTxt=nil;
end



















function UIDrawFuResult_game:onLoaded(...)
self:bindComponents()
end


function UIDrawFuResult_game:__delete()
self:unbindComponents()
end
local abName='ui/windows/fulu/sharedtextures/fulufang.ab'



function UIDrawFuResult_game:onShow(argtable,afterOnloaded)
local grade=argtable.grade
if grade>0 then
local imgName=cfgHelper.get2(cfg_fubaoratingconfig_get,grade,'imgname')
self.ratingImg:setSprite(abName,imgName)

self.tipsTxt:setText("当前绘制灵符评级")
end

end


function UIDrawFuResult_game:onHide()

end



