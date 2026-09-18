







def_class("UIMoJieMoJunAttackTipsWin",UIWindowBase)









function UIMoJieMoJunAttackTipsWin:bindComponents()

self.root=UIObject.get(self,0)



end


function UIMoJieMoJunAttackTipsWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
end
















local ishide=false
local isbattle=false
local _this



function UIMoJieMoJunAttackTipsWin:onLoaded(...)
self:bindComponents()
_this=self
notifySystem:listenNotify(notifyConfig.onBattleClose,self.onBattleClose)
notifySystem:listenNotify(notifyConfig.onBattlePlayClose,self.onBattlePlayClose)
notifySystem:listenNotify(notifyConfig.onBattleStart,self.onBattleStart)
ishide=false
end


function UIMoJieMoJunAttackTipsWin:__delete()
self:unbindComponents()
notifySystem:removelistener(notifyConfig.onBattleClose,self.onBattleClose)
notifySystem:removelistener(notifyConfig.onBattlePlayClose,self.onBattlePlayClose)
notifySystem:removelistener(notifyConfig.onBattleStart,self.onBattleStart)
self.tween:Kill()
self.tween=nil
self:stopSelfTimer()
_this=nil
end





function UIMoJieMoJunAttackTipsWin:onShow(argtable,afterOnloaded)
if not self.tween then
ishide=false
isbattle=false
self.root:setChildCanvasGroupAlpha(0)
self.tween=self.root:setChildCanvasGroupDOFade(1,1)
self.tween:SetDelay(0.2)
self.tween:SetLoops(-1,_LoopType.Yoyo)

self:startTimer()
end
end


function UIMoJieMoJunAttackTipsWin:onHide()

end






function UIMoJieMoJunAttackTipsWin.onBattleStart()
isbattle=true
end

function UIMoJieMoJunAttackTipsWin.onBattleClose()
isbattle=false
end
function UIMoJieMoJunAttackTipsWin.onBattlePlayClose()
isbattle=false
end

function UIMoJieMoJunAttackTipsWin:startTimer()
self:stopSelfTimer()
local func=function()
ishide=false
local win=UIManager:findActiveWindow('UIFightPrepareWin')
if win then
ishide=true
end
if isbattle then
ishide=true
end
self.root:setActive(not ishide)
end
func()
self.timer=self:setTimer(2,0,func)
end
function UIMoJieMoJunAttackTipsWin:stopSelfTimer()
if self.timer then
self:stopTimerByID(self.timer)
end
self.timer=nil
end