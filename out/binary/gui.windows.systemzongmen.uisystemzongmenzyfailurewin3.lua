







def_class("UISystemZongMenZYFailureWin3",UIWindowBase)









function UISystemZongMenZYFailureWin3:bindComponents()

self.background=UIButton.get(self,0)
self.disModel=UIObject.get(self,1)
self.negotiateBtn=UIButton.get(self,2)

self.background:setButtonClick(function()self:onBackground()end)

self.negotiateBtn:setButtonClick(function()self:onNegotiateBtn()end)



end


function UISystemZongMenZYFailureWin3:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.background);self.background=nil;
_UIObject_release(self.disModel);self.disModel=nil;
_UIObject_release(self.negotiateBtn);self.negotiateBtn=nil;
end



















function UISystemZongMenZYFailureWin3:onLoaded(...)
self:bindComponents()
end


function UISystemZongMenZYFailureWin3:__delete()
self:unbindComponents()
end




function UISystemZongMenZYFailureWin3:onShow(argtable,afterOnloaded)
self.callback=argtable.callback
self.disciple=argtable.disciple
self.serial=argtable.serial

local cmp=self.disModel:getID()
local modelParams=UIDiscipleModel:getDiscipleOutsideModelInfo(self.disciple)
self.winlua:SetChildUIModelShowTarget(cmp,modelParams.body,1,modelParams.componets,eAnimationID.stand)

UIManager:closeWindow("UISystemZongMenZaoYaoWin")
UIManager:closeWindow("UISystemZongMenZaoYaoSelectWin")
UIManager:closeWindow("UISystemZongMenTaYinWin")
UIManager:closeWindow("UISystemZongMenTaYinWin1")
end


function UISystemZongMenZYFailureWin3:onHide()

end




function UISystemZongMenZYFailureWin3:onBackground()
if self.callback then
self.callback()
else
self:closeSelf()
end
end


function UISystemZongMenZYFailureWin3:onNegotiateBtn()
UIFullSystemZongMenControl:showWindow("UISystemZongMenRansomWin",{serial=self.serial})
end

