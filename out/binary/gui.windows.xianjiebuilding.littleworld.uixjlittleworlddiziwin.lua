







def_class("UIXJLittleWorldDiZiWin",UIWindowBase)









function UIXJLittleWorldDiZiWin:bindComponents()

self.levelPanel=UIObject.get(self,0)
self.shuomingButton=UIButton.get(self,1)
self.skillAddNumRoot=UIObject.get(self,2)
self.teamDiziRoot=UIObject.get(self,3)
self.techanScrollView=UIScrollView.get(self,4)
self.tezhiRoot=UIObject.get(self,5)

self.shuomingButton:setButtonClick(function()self:onShuomingButton()end)



end


function UIXJLittleWorldDiZiWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.levelPanel);self.levelPanel=nil;
_UIObject_release(self.shuomingButton);self.shuomingButton=nil;
_UIObject_release(self.skillAddNumRoot);self.skillAddNumRoot=nil;
_UIObject_release(self.teamDiziRoot);self.teamDiziRoot=nil;
_UIObject_release(self.techanScrollView);self.techanScrollView=nil;
_UIObject_release(self.tezhiRoot);self.tezhiRoot=nil;
end



















function UIXJLittleWorldDiZiWin:onLoaded(...)
self:bindComponents()
end


function UIXJLittleWorldDiZiWin:__delete()
self:unbindComponents()
end




function UIXJLittleWorldDiZiWin:onShow(argtable,afterOnloaded)

end


function UIXJLittleWorldDiZiWin:onHide()

end





function UIXJLittleWorldDiZiWin:onShuomingButton()
end

