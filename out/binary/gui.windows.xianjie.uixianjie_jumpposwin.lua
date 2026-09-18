







def_class("UIXianJie_jumpPosWin",UIWindowBase)









function UIXianJie_jumpPosWin:bindComponents()

self.inputXField=UIInputField.get(self,0)
self.inputYField=UIInputField.get(self,1)
self.sureBtn=UIButton.get(self,2)

self.sureBtn:setButtonClick(function()self:onSureBtn()end)



end


function UIXianJie_jumpPosWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.inputXField);self.inputXField=nil;
_UIObject_release(self.inputYField);self.inputYField=nil;
_UIObject_release(self.sureBtn);self.sureBtn=nil;
end

















function UIXianJie_jumpPosWin:onLoaded(...)
self:bindComponents()
end


function UIXianJie_jumpPosWin:__delete()
self:unbindComponents()
end


function UIXianJie_jumpPosWin:onHide()

end




function UIXianJie_jumpPosWin:onShow(argtable,afterOnloaded)

end

function UIXianJie_jumpPosWin:onSureBtn()

AudioManager.playBtnClick()
local str_x=self.inputXField:getInputFieldValue()
if str_x==nil or str_x==''then
UIManager.error('请输入X坐标')
return
end
local str_y=self.inputYField:getInputFieldValue()
if str_y==nil or str_y==''then
UIManager.error('请输入Y坐标')
return
end
local gridX=tonumber(str_x)
local gridZ=tonumber(str_y)
if not xianjieController:checkGridInMapEx(gridX,gridZ)then
UIManager.error('无法定位至该坐标')
return
end
local pos=xianjieController:worldGridPos2WorldPos1(gridX,gridZ,1,1)
xianjieController:lookAtPosition(pos,nil,0.2,nil,DG.Tweening.Ease.Linear)
self:closeSelf()
end