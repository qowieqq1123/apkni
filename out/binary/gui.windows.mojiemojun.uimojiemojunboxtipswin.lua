







def_class("UIMoJieMoJunBoxTipsWin",UIWindowBase)









function UIMoJieMoJunBoxTipsWin:bindComponents()

self.desc=UIText.get(self,0)
self.gotoBtn=UIButton.get(self,1)
self.root=UIObject.get(self,2)
self.spine=UIObject.get(self,3)
self.timeTxt=UIText.get(self,4)

self.gotoBtn:setButtonClick(function()self:onGotoBtn()end)



end


function UIMoJieMoJunBoxTipsWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.desc);self.desc=nil;
_UIObject_release(self.gotoBtn);self.gotoBtn=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.spine);self.spine=nil;
_UIObject_release(self.timeTxt);self.timeTxt=nil;
end



















function UIMoJieMoJunBoxTipsWin:onLoaded(...)
self:bindComponents()
end


function UIMoJieMoJunBoxTipsWin:__delete()
self:unbindComponents()
end




function UIMoJieMoJunBoxTipsWin:onShow(argtable,afterOnloaded)
self.seasonType=argtable.seasonType
self.stageIndex=argtable.stageIndex

local nowTime=timeHelper.getServerShortTime()
local mojunData=xianjieModel:getMoJunData()
local cfg=cfgHelper.get1(cfg_seasonmojunjieshuconfig_get,mojunData.mojunJieShu)
local endTime=mojunData.killTime+cfg.boxDuration
local lerp=endTime-nowTime
self.timeTxt:setText(FMT.fmt("魔君宝箱<color=#f1ce78>{0}</color>后消失",timeHelper.format_time_stamp16(lerp)))

self.root:setChildCanvasGroupAlpha(0)
self.spine:setChildUIModelShowTarget(6280,1,{},eAnimationID.enter,false,false,0)
self:delayDo(0.5,function()
self.root:setChildCanvasGroupDOFade(1,0.2)
end)
end


function UIMoJieMoJunBoxTipsWin:onHide()

end






function UIMoJieMoJunBoxTipsWin:onGotoBtn()
local firstTemp=xianjieModel:getMoJunFirstBox(self.seasonType,self.stageIndex)
xianjieController:jumpMoJieBox(firstTemp.boxId)
self:onCloseBtn()
end

function UIMoJieMoJunBoxTipsWin:onCloseBtn()
if self.parentWin then
self.parentWin:closeWindow(self.__name)
else
self:closeSelf()
end
end