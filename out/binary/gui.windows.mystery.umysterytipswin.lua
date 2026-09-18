







def_class("UMysteryTipsWin",UIWindowBase)









function UMysteryTipsWin:bindComponents()

self.leftObj=UIObject.get(self,0)
self.centerObj=UIObject.get(self,1)
self.rightObj=UIObject.get(self,2)
self.tipstxt=UIText.get(self,3)
self.spinebg=UIObject.get(self,4)
self.leftmovebtn=UIObject.get(self,5)
self.rightmovebtn=UIObject.get(self,6)
self.scrollview=UIObject.get(self,7)
self.content=UIObject.get(self,8)



end


function UMysteryTipsWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.leftObj);self.leftObj=nil;
_UIObject_release(self.centerObj);self.centerObj=nil;
_UIObject_release(self.rightObj);self.rightObj=nil;
_UIObject_release(self.tipstxt);self.tipstxt=nil;
_UIObject_release(self.spinebg);self.spinebg=nil;
_UIObject_release(self.leftmovebtn);self.leftmovebtn=nil;
_UIObject_release(self.rightmovebtn);self.rightmovebtn=nil;
_UIObject_release(self.scrollview);self.scrollview=nil;
_UIObject_release(self.content);self.content=nil;
end
















local _this




function UMysteryTipsWin:onLoaded(...)
self:bindComponents()
_this=self
end


function UMysteryTipsWin:__delete()
self:unbindComponents()
end




function UMysteryTipsWin:onShow(argtable,afterOnloaded)
self.isMoveRight=false
self.scrollview:setChildCanvasGroupDOFade(0,0,nil)
self.spinebg:setChildUIModelShowTarget(4086,1,{},0,false,false,0.3,function()

_this:delayDo(0.3,function()
_this.scrollview:setChildCanvasGroupDOFade(1,0.2,function()
_this:freshBtns();
end)
end)
end)
end


function UMysteryTipsWin:onHide()

end





function UMysteryTipsWin:onClickLeftBtn()
self.leftmovebtn:setActive(false);
self.content:setChildDOLocalMoveX(0,0.3,function()
self.isMoveRight=not self.isMoveRight
self:freshBtns()
end)
end

function UMysteryTipsWin:onClickRightBtn()
self.rightmovebtn:setActive(false)
self.content:setChildDOLocalMoveX(-400,0.3,function()
self.isMoveRight=not self.isMoveRight
self:freshBtns()
end)
end

function UMysteryTipsWin:freshBtns()
self.leftmovebtn:setActive(self.isMoveRight);
self.rightmovebtn:setActive(not self.isMoveRight)
end


