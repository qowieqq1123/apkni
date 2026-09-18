







def_class("UIXianJieJieYinWin",UIWindowBase)









function UIXianJieJieYinWin:bindComponents()

self.randomXianGongRoot=UIObject.get(self,0)
self.myXianGongRoot=UIObject.get(self,1)
self.closeButton=UIButton.get(self,2)
self.leftRoot=UIObject.get(self,3)
self.xiangongListButton=UIButton.get(self,4)
self.myXianGongButton=UIButton.get(self,5)
self.ScrollView=UILoopListView.new(self,6)
self.changeButton=UIButton.get(self,7)
self.ScrollView2=UILoopListView.new(self,8)

self.closeButton:setButtonClick(function()UIManager:closeWindow("UIXianJieJieYinWin")end)

self.xiangongListButton:setButtonClick(function()self:onXiangongListButton()end)

self.myXianGongButton:setButtonClick(function()self:onMyXianGongButton()end)

self.ScrollView:bindLoopListView(function(...)
self:onFreshAction(...)
end,function(...)
self:onStartAction(...)
end)
self.changeButton:setButtonClick(function()self:onChangeButton()end)

self.ScrollView2:bindLoopListView(function(...)
self:onFreshAction_2(...)
end,function(...)
self:onStartAction_2(...)
end)


end


function UIXianJieJieYinWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.randomXianGongRoot);self.randomXianGongRoot=nil;
_UIObject_release(self.myXianGongRoot);self.myXianGongRoot=nil;
_UIObject_release(self.closeButton);self.closeButton=nil;
_UIObject_release(self.leftRoot);self.leftRoot=nil;
_UIObject_release(self.xiangongListButton);self.xiangongListButton=nil;
_UIObject_release(self.myXianGongButton);self.myXianGongButton=nil;
self.ScrollView:deleteSelf();self.ScrollView=nil;
_UIObject_release(self.changeButton);self.changeButton=nil;
self.ScrollView2:deleteSelf();self.ScrollView2=nil;
end



















function UIXianJieJieYinWin:onLoaded(...)
self:bindComponents()
end


function UIXianJieJieYinWin:__delete()
self:unbindComponents()
end




function UIXianJieJieYinWin:onShow(argtable,afterOnloaded)

end


function UIXianJieJieYinWin:onHide()

end

function UIXianJieJieYinWin:refreshXianGongList()

end

function UIXianJieJieYinWin:refreshMyXGList()

end

function UIXianJieJieYinWin:reqHelp()

end

function UIXianJieJieYinWin:onFreshAction(index,widget)

end

function UIXianJieJieYinWin:onFreshAction_2(index,widget)

end

function UIXianJieJieYinWin:onStartAction(index,widget)

end

function UIXianJieJieYinWin:onStartAction_2(index,widget)

end




function UIXianJieJieYinWin:onXiangongListButton()
end



function UIXianJieJieYinWin:onMyXianGongButton()
end



function UIXianJieJieYinWin:onChangeButton()
end

