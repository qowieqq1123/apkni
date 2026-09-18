







def_class("UISubAct_WanBaoJianShangAct_settlementWin",UIWindowBase)









function UISubAct_WanBaoJianShangAct_settlementWin:bindComponents()

self.tipsTxt=UIText.get(self,0)



end


function UISubAct_WanBaoJianShangAct_settlementWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.tipsTxt);self.tipsTxt=nil;
end



















function UISubAct_WanBaoJianShangAct_settlementWin:onLoaded(...)
self:bindComponents()
end


function UISubAct_WanBaoJianShangAct_settlementWin:__delete()
if self.showAudioHandleId then
local audioHandleId=self.showAudioHandleId
local fadeTime=2
AudioManager.fadeOutStopAudioById(audioHandleId,fadeTime,false)
end

self:unbindComponents()
end




function UISubAct_WanBaoJianShangAct_settlementWin:onShow(argtable,afterOnloaded)
self.score=argtable.score
self.isVictory=argtable.result==1

if self.isVictory then
self.showAudioHandleId=AudioManager.playAudio(402)
else
self.showAudioHandleId=AudioManager.playAudio(403)
end
self:updateView()
end


function UISubAct_WanBaoJianShangAct_settlementWin:onHide()

end

function UISubAct_WanBaoJianShangAct_settlementWin:updateView()

local pos=self.tipsTxt:getChildAnchoredPosition()
local pos_y=pos.y
if self.isVictory then
self.tipsTxt:setText(FMT.fmt("游戏积分：{0}",self.score))
pos_y=-50
else
self.tipsTxt:setText(FMT.cfmt(FONT_COLOR.eNomalBlackColor,"游戏积分：{0}",self.score))
pos_y=-30
end
self.tipsTxt:setChildAnchoredPos(pos.x,pos_y)
end



