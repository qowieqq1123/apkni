







def_class("UILittleWorldAttrDetailWin",UIWindowBase)









function UILittleWorldAttrDetailWin:bindComponents()

self.instructionBtn=UIButton.get(self,0)
self.attrCreater1=UIObject.get(self,1)
self.questionBtn=UIButton.get(self,2)
self.attrCreater2=UIObject.get(self,3)
self.contentRoot=UIObject.get(self,4)

self.instructionBtn:setButtonClick(function()self:onInstructionBtn()end)

self.questionBtn:setButtonClick(function()self:onQuestionBtn()end)



end


function UILittleWorldAttrDetailWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.instructionBtn);self.instructionBtn=nil;
_UIObject_release(self.attrCreater1);self.attrCreater1=nil;
_UIObject_release(self.questionBtn);self.questionBtn=nil;
_UIObject_release(self.attrCreater2);self.attrCreater2=nil;
_UIObject_release(self.contentRoot);self.contentRoot=nil;
end



















function UILittleWorldAttrDetailWin:onLoaded(...)
self:bindComponents()
end


function UILittleWorldAttrDetailWin:__delete()
self:unbindComponents()
end




function UILittleWorldAttrDetailWin:onShow(argtable,afterOnloaded)

end


function UILittleWorldAttrDetailWin:onHide()

end





function UILittleWorldAttrDetailWin:onInstructionBtn()
end



function UILittleWorldAttrDetailWin:onQuestionBtn()
end

