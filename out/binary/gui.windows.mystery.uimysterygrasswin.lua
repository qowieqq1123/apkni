







def_class("UIMysteryGrassWin",UIWindowBase)









function UIMysteryGrassWin:bindComponents()

self.back=UIObject.get(self,0)
self.maopao=UIObject.get(self,1)



end


function UIMysteryGrassWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.back);self.back=nil;
_UIObject_release(self.maopao);self.maopao=nil;
end



















function UIMysteryGrassWin:onLoaded(...)
self:bindComponents()
end


function UIMysteryGrassWin:__delete()
self:unbindComponents()
end




function UIMysteryGrassWin:onShow(argtable,afterOnloaded)
self.updatePlayerTimer=self:setTimer(0.02,0,function()
local player=mysteryPlayerModel:get_player()
if player then
local playerPos=mysteryPlayerModel:get_hud_position(player.guid,true)
self.maopao:setChildPosition(playerPos)
end
end)
end


function UIMysteryGrassWin:onHide()
if self.updatePlayerTimer then
self:stopTimerByID(self.updatePlayerTimer)
end
end



