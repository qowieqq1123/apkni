







def_class("UIXianJie_stationTeamInfoWin",UIWindowBase)









function UIXianJie_stationTeamInfoWin:bindComponents()

self.fightValue=UIText.get(self,0)
self.teamLeader=UIButton.get(self,1)
self.teamScrollView=UIObject.get(self,2)

self.teamLeader:setButtonClick(function()self:onTeamLeader()end)



end


function UIXianJie_stationTeamInfoWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.fightValue);self.fightValue=nil;
_UIObject_release(self.teamLeader);self.teamLeader=nil;
_UIObject_release(self.teamScrollView);self.teamScrollView=nil;
end



















function UIXianJie_stationTeamInfoWin:onLoaded(...)
self:bindComponents()
end


function UIXianJie_stationTeamInfoWin:__delete()
self:unbindComponents()
end




function UIXianJie_stationTeamInfoWin:onShow(argtable,afterOnloaded)
self.fightValue:setText(argtable)
end


function UIXianJie_stationTeamInfoWin:onHide()

end




function UIXianJie_stationTeamInfoWin:onCloseClick()
self:closeSelf()
end