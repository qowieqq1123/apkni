







def_class("UISystemZongMenDiscipleTalkWin",UIWindowBase)









function UISystemZongMenDiscipleTalkWin:bindComponents()

self.backBtn=UIButton.get(self,0)
self.talkdesc=UIText.get(self,1)
self.nameTx=UIText.get(self,2)
self.modelImage=UIObject.get(self,3)

self.backBtn:setButtonClick(function()self:onBackBtn()end)



end


function UISystemZongMenDiscipleTalkWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.backBtn);self.backBtn=nil;
_UIObject_release(self.talkdesc);self.talkdesc=nil;
_UIObject_release(self.nameTx);self.nameTx=nil;
_UIObject_release(self.modelImage);self.modelImage=nil;
end















local _this=nil



function UISystemZongMenDiscipleTalkWin:onLoaded(...)
self:bindComponents()
_this=self
end


function UISystemZongMenDiscipleTalkWin:__delete()
self:unbindComponents()
_this=nil
end




function UISystemZongMenDiscipleTalkWin:onShow(argtable,afterOnloaded)
self.callback=argtable.callback
local imageInfo=UIDiscipleModel.calculationDiscipleImage(argtable.discipledata,argtable.discipleimage)
local modelParams=UIDiscipleModel:getDiscipleInsideModelInfoByData(imageInfo)
comHelper.setChildInSideModelEx(self.modelImage,modelParams,1,eAnimationID.stand)
self.nameTx:setText(argtable.disciplename)
self.talkdesc:setText(argtable.talkcontent)
end


function UISystemZongMenDiscipleTalkWin:onHide()

end





function UISystemZongMenDiscipleTalkWin:onBackBtn()
if self.callback then
self.callback()
else
self:closeSelf()
end
end

