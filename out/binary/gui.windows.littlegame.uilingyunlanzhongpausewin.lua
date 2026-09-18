







def_class("UILingYunLanZhongPauseWin",UIWindowBase)









function UILingYunLanZhongPauseWin:bindComponents()

self.root=UIObject.get(self,0)
self.level=UIText.get(self,1)
self.info=UIText.get(self,2)
self.backbtn=UIButton.get(self,3)
self.outbtn=UIButton.get(self,4)

self.backbtn:setButtonClick(function()self:onBackbtn()end)

self.outbtn:setButtonClick(function()self:onOutbtn()end)



end


function UILingYunLanZhongPauseWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.level);self.level=nil;
_UIObject_release(self.info);self.info=nil;
_UIObject_release(self.backbtn);self.backbtn=nil;
_UIObject_release(self.outbtn);self.outbtn=nil;
end



















function UILingYunLanZhongPauseWin:onLoaded(...)
self:bindComponents()
end


function UILingYunLanZhongPauseWin:__delete()
self:unbindComponents()
end




function UILingYunLanZhongPauseWin:onShow(argtable,afterOnloaded)
self.levelNum=argtable.levelNum
self.mainWin=argtable.mainWin
self.outcallback=argtable.outcallback

self.level:setText(FMT.fmt("当前层数{0}",self.levelNum))
self.info.setText("是否退出天梯试炼")

end


function UILingYunLanZhongPauseWin:onHide()

end





function UILingYunLanZhongPauseWin:onBackbtn()
self.mainWin:continueCountDown()
self:closeSelf()
end



function UILingYunLanZhongPauseWin:onOutbtn()
self.outcallback()
self:closeSelf()
end

