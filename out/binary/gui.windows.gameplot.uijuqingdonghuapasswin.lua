







def_class("UIJuQingDongHuaPassWin",UIWindowBase)









function UIJuQingDongHuaPassWin:bindComponents()

self.passBtn=UIButton.get(self,0)

self.passBtn:setButtonClick(function()self:onPassBtn()end)



end


function UIJuQingDongHuaPassWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.passBtn);self.passBtn=nil;
end



















function UIJuQingDongHuaPassWin:onLoaded(...)
self:bindComponents()
end


function UIJuQingDongHuaPassWin:__delete()
self:unbindComponents()
end




function UIJuQingDongHuaPassWin:onShow(argtable,afterOnloaded)
self.owner=argtable
end


function UIJuQingDongHuaPassWin:onHide()

end



function UIJuQingDongHuaPassWin:onPassBtn()





storyAIManager:removeAllStoryEntity(true)
local func=function()
storyAICommonManager:executeEndCallBack()
end
timeEventController.delayDo(0.1,func,true)
end

