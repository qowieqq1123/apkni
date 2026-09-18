







def_class("UIXianJieJieYin_FinishWin",UIWindowBase)









function UIXianJieJieYin_FinishWin:bindComponents()

self.groupItem=UIObject.get(self,0)
self.okSpine=UIObject.get(self,1)
self.Root=UIObject.get(self,2)
self.uiRoot=UIObject.get(self,3)



end


function UIXianJieJieYin_FinishWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.groupItem);self.groupItem=nil;
_UIObject_release(self.okSpine);self.okSpine=nil;
_UIObject_release(self.Root);self.Root=nil;
_UIObject_release(self.uiRoot);self.uiRoot=nil;
end



















function UIXianJieJieYin_FinishWin:onLoaded(...)
self:bindComponents()
end


function UIXianJieJieYin_FinishWin:__delete()
self:unbindComponents()
end




function UIXianJieJieYin_FinishWin:onShow(argtable,afterOnloaded)

jiuchongtianjieGuideController:req_xjGuideAskConfirm()









self.okSpine:setChildUIModelShowTarget(6064,1,{},eAnimationID.enter)
end


function UIXianJieJieYin_FinishWin:onHide()

end



