







def_class("UILDJingCaiShowWin",UIWindowBase)









function UILDJingCaiShowWin:bindComponents()

self.ScrollView=UIScrollViewSlow.get(self,0)



end


function UILDJingCaiShowWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.ScrollView);self.ScrollView=nil;
end



















function UILDJingCaiShowWin:onLoaded(...)
self:bindComponents()
end


function UILDJingCaiShowWin:__delete()
self:unbindComponents()
end




function UILDJingCaiShowWin:onShow(argtable,afterOnloaded)

end


function UILDJingCaiShowWin:onHide()

end


function UILDJingCaiShowWin:refreshResult()

end


