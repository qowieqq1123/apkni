







def_class("UISystemZongMenFightRoundWin",UIWindowBase)









function UISystemZongMenFightRoundWin:bindComponents()

self.text_left=UIText.get(self,0)
self.text_right=UIText.get(self,1)
self.text={
["left"]=self.text_left,
["right"]=self.text_right,
}



end


function UISystemZongMenFightRoundWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.text_left);self.text_left=nil;
_UIObject_release(self.text_right);self.text_right=nil;
self.text=nil;
end















local _this=nil



function UISystemZongMenFightRoundWin:onLoaded(...)
self:bindComponents()
_this=self
end


function UISystemZongMenFightRoundWin:__delete()
self:unbindComponents()
_this=nil
end




function UISystemZongMenFightRoundWin:onShow(argtable,afterOnloaded)
self.battle=fightModel:getBattle(argtable.battle)
self:refreshView()
end


function UISystemZongMenFightRoundWin:onHide()

end



function UISystemZongMenFightRoundWin:refreshView()
local leftWinTimes=self.battle:getfightLeftWinTimes()
local rightWinTimes=self.battle:getfightRightWinTimes()
self.text_left:setText(rightWinTimes+1)
self.text_right:setText(leftWinTimes+1)
end