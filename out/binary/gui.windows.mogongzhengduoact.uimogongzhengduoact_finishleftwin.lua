







def_class("UIMoGongZhengDuoAct_FinishLeftWin",UIWindowBase)









function UIMoGongZhengDuoAct_FinishLeftWin:bindComponents()

self.finishEffect=UIObject.get(self,0)
self.leftTimeTxt=UIText.get(self,1)
self.Root=UIObject.get(self,2)
self.uiRoot=UIObject.get(self,3)



end


function UIMoGongZhengDuoAct_FinishLeftWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.finishEffect);self.finishEffect=nil;
_UIObject_release(self.leftTimeTxt);self.leftTimeTxt=nil;
_UIObject_release(self.Root);self.Root=nil;
_UIObject_release(self.uiRoot);self.uiRoot=nil;
end



















function UIMoGongZhengDuoAct_FinishLeftWin:onLoaded(...)
self:bindComponents()
end


function UIMoGongZhengDuoAct_FinishLeftWin:__delete()
self:unbindComponents()
end




function UIMoGongZhengDuoAct_FinishLeftWin:onShow(argtable,afterOnloaded)
self.settlementTime=argtable.settlementTime
self.finishCallBack=argtable.callback

self.endLeftShowTime=moGongZhengDuoActModel:getBaseConfig("emdLeftShowTime")

self:startLeft()
end


function UIMoGongZhengDuoAct_FinishLeftWin:onHide()

end

function UIMoGongZhengDuoAct_FinishLeftWin:stopLeft()
if self.leftTimer then
self:stopTimerByID(self.leftTimer)
self.leftTimer=nil
end
end

function UIMoGongZhengDuoAct_FinishLeftWin:startLeft()
self:stopLeft()

local curTime=timeHelper.getServerShortTime()
local endTime=self.settlementTime
local left=endTime-curTime

local func=function()
curTime=timeHelper.getServerShortTime()
left=endTime-curTime
if left>0 then
self.leftTimeTxt:setText(left)
else
self:stopLeft()
self:playFinishEffect()
end
end

self.leftTimer=self:setTimer(0.5,0,func)
func()
end

function UIMoGongZhengDuoAct_FinishLeftWin:playFinishEffect()
self.leftTimeTxt:setActive(false)
self.finishEffect:setChildShowEffect(20524,true)
self:delayDo(2,function()
if self.finishCallBack then
self.finishCallBack()
self:closeSelf()
else
self:closeSelf()
end
end)
end



