







def_class("UIWorldZaWuPuDialogueWin",UIWindowBase)









function UIWorldZaWuPuDialogueWin:bindComponents()

self.btn=UIObject.get(self,0)
self.reddotImage=UIObject.get(self,1)
self.reddotTxt=UIText.get(self,2)
self.root=UIObject.get(self,3)
self.oldImg=UIButton.get(self,4)
self.NewImg=UIButton.get(self,5)

self.oldImg:setButtonClick(function()self:onOldImg()end)

self.NewImg:setButtonClick(function()self:onNewImg()end)



end


function UIWorldZaWuPuDialogueWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.btn);self.btn=nil;
_UIObject_release(self.reddotImage);self.reddotImage=nil;
_UIObject_release(self.reddotTxt);self.reddotTxt=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.oldImg);self.oldImg=nil;
_UIObject_release(self.NewImg);self.NewImg=nil;
end



















function UIWorldZaWuPuDialogueWin:onLoaded(...)
self:bindComponents()
end


function UIWorldZaWuPuDialogueWin:__delete()
self:unbindComponents()
end




function UIWorldZaWuPuDialogueWin:onShow(argtable,afterOnloaded)
self:refreshreddot()
end


function UIWorldZaWuPuDialogueWin:onHide()

end





function UIWorldZaWuPuDialogueWin:onBtn()
UIManager:showWindow('UIXiaoDaoTongMainWin',{page=3})
end

function UIWorldZaWuPuDialogueWin:onOldImg()
self:onBtn()
end



function UIWorldZaWuPuDialogueWin:onNewImg()
self:onBtn()
end


function UIWorldZaWuPuDialogueWin:refreshreddot()
local num=0
local mNum=xiaodaotongModel:getManufactureReddotNum()
local bdNum=xiaodaotongModel:getBuildingReddotNum()
local tipsNum=xiaodaotongModel:getReddotNum()or 0
num=num+mNum+bdNum+tipsNum
self.winlua:SetChildActive(6,num>0)
self.winlua:SetChildText(7,num)
end