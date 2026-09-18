







def_class("UIXM_ZZSH_jumpPosWin",UIWindowBase)









function UIXM_ZZSH_jumpPosWin:bindComponents()

self.inputXField=UIInputField.get(self,0)
self.inputYField=UIInputField.get(self,1)
self.sureBtn=UIButton.get(self,2)

self.sureBtn:setButtonClick(function()self:onSureBtn()end)



end


function UIXM_ZZSH_jumpPosWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.inputXField);self.inputXField=nil;
_UIObject_release(self.inputYField);self.inputYField=nil;
_UIObject_release(self.sureBtn);self.sureBtn=nil;
end

















function UIXM_ZZSH_jumpPosWin:onLoaded(...)
self:bindComponents()
end


function UIXM_ZZSH_jumpPosWin:__delete()
self:unbindComponents()
end


function UIXM_ZZSH_jumpPosWin:onHide()

end




function UIXM_ZZSH_jumpPosWin:onShow(argtable,afterOnloaded)

end

function UIXM_ZZSH_jumpPosWin:onSureBtn()

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
local x=tonumber(str_x)
local y=tonumber(str_y)
if not zhengzhanshanhaiModel:checkGridPosInMap(x,y)then
UIManager.error('无法定位至该坐标')
return
end
UIManager:invokeUIMethod('UIXM_ZZSH_MapWin','move2GridPos',x,y,0,false,0)
self:closeSelf()
end
