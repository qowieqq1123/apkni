







def_class("UIWorldFightRecordDialogueWin",UIWindowBase)









function UIWorldFightRecordDialogueWin:bindComponents()

self.btn=UIObject.get(self,0)
self.reddotImage=UIObject.get(self,1)
self.reddotTxt=UIText.get(self,2)
self.root=UIObject.get(self,3)
self.oldImg=UIButton.get(self,4)
self.NewImg=UIButton.get(self,5)

self.oldImg:setButtonClick(function()self:onOldImg()end)

self.NewImg:setButtonClick(function()self:onNewImg()end)



end


function UIWorldFightRecordDialogueWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.btn);self.btn=nil;
_UIObject_release(self.reddotImage);self.reddotImage=nil;
_UIObject_release(self.reddotTxt);self.reddotTxt=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.oldImg);self.oldImg=nil;
_UIObject_release(self.NewImg);self.NewImg=nil;
end
















local _this=nil




function UIWorldFightRecordDialogueWin:onLoaded(...)
self:bindComponents()
_this=self
notifySystem:listenNotify(notifyConfig.onWorldFightRecordChanged,self.refreshUI)
end


function UIWorldFightRecordDialogueWin:__delete()
self:unbindComponents()
self.isnew=nil
_this=nil
notifySystem:removelistener(notifyConfig.onWorldFightRecordChanged,self.refreshUI)
end




function UIWorldFightRecordDialogueWin:onShow(argtable,afterOnloaded)

self.refreshUI()
end


function UIWorldFightRecordDialogueWin:onHide()

end





function UIWorldFightRecordDialogueWin:onBtn()
UIManager:showWindow("UIWorldFightRecordWin")
end

function UIWorldFightRecordDialogueWin:onOldImg()
self:onBtn()
end

function UIWorldFightRecordDialogueWin:onNewImg()
self:onBtn()
end

function UIWorldFightRecordDialogueWin.refreshUI()
local num=worldFightRecordModel:getNewRecordCount()
local new=num>0

if _this.isnew~=new then
_this.winlua:SetChildAnimatorParameter(_this.btn:getID(),_this.isnew~=new and'state'or'stating','bool',tostring(new))
_this.winlua:SetChildAnimatorParameter(_this.btn:getID(),'trigger','trigger',"")
_this.isnew=new
end
_this.reddotTxt:setText(num)
end
