







def_class("UIPlotBoardFiveWin",UIWindowBase)









function UIPlotBoardFiveWin:bindComponents()

self.back=UIButton.get(self,0)
self.root=UIObject.get(self,1)
self.testObj=UIObject.get(self,2)
self.modelObj=UIObject.get(self,3)
self.shakeRoot=UIObject.get(self,4)
self.modelImage=UIObject.get(self,5)
self.talkframe=UIObject.get(self,6)
self.talkdesc=UIText.get(self,7)

self.back:setButtonClick(function()self:onBack()end)



end


function UIPlotBoardFiveWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.back);self.back=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.testObj);self.testObj=nil;
_UIObject_release(self.modelObj);self.modelObj=nil;
_UIObject_release(self.shakeRoot);self.shakeRoot=nil;
_UIObject_release(self.modelImage);self.modelImage=nil;
_UIObject_release(self.talkframe);self.talkframe=nil;
_UIObject_release(self.talkdesc);self.talkdesc=nil;
end















local _this=nil



function UIPlotBoardFiveWin:onLoaded(...)
self:bindComponents()
_this=self
end


function UIPlotBoardFiveWin:__delete()
self:unbindComponents()
_this=nil
end




function UIPlotBoardFiveWin:onShow(argtable,afterOnloaded)
self.isFullOpen=argtable.isFullOpen
self.callback=argtable.callback

local image=argtable.model
if image then
self.modelImage:setChildUIModelShowTarget(image.body,image.scale,image.componets,image.anim,false,true,0.3)
else
self.modelImage:setChildUIModelRemoveTarget()
end
self.talkdesc:setText(argtable.talk or"")

local showTest=false



self.testObj:setActive(showTest)
end


function UIPlotBoardFiveWin:onHide()

end



function UIPlotBoardFiveWin:onBack()
if self.callback then
self.callback()
end

if self.isFullOpen then
fullScreenUI.closeActiveUI()
else
UIManager:closeWindow('UIPlotBoardFiveWin')
UIManager:closeWindow('UIPlotBlackWin')
end
end
