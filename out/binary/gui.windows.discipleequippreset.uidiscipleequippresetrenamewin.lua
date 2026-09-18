







def_class("UIDiscipleEquipPresetRenameWin",UIWindowBase)









function UIDiscipleEquipPresetRenameWin:bindComponents()

self.inputDefaultTxt=UIText.get(self,0)
self.inputField=UIInputField.get(self,1)



end


function UIDiscipleEquipPresetRenameWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.inputDefaultTxt);self.inputDefaultTxt=nil;
_UIObject_release(self.inputField);self.inputField=nil;
end


















local _this

function UIDiscipleEquipPresetRenameWin:onLoaded(...)
self:bindComponents()
_this=self
self.lenLimit={1,6}
self.is_Chinese=false
end


function UIDiscipleEquipPresetRenameWin:__delete()
self:unbindComponents()
_this=nil
end




function UIDiscipleEquipPresetRenameWin:onShow(argtable,afterOnloaded)
self.disciple_guid=argtable[1]
self.presetIdx=argtable[2]
end

function UIDiscipleEquipPresetRenameWin:onSureBtn()

AudioManager.playBtnClick()
local changeName=self.inputField:getInputFieldValue()
if changeName==nil or changeName==''then
UIManager.error('名称不能为空')
return
end
if discipleEquipPresetController:checkPresetNameExisted(self.disciple_guid,changeName)then
UIManager.error('已有同名的配装方案')
return
end
local isGuoFu=pfwindowslController:checkIsGameVersion_guofu()
if isGuoFu then
if self.is_Chinese==true then
if not helper.string_is_ChineseS(changeName)then
UIManager.error('请输入中文名称')
return
end
end

if helper.check_spec_chars(changeName)then
UIManager.error('名称中含有特殊字符')
return
end
end
if not pfwindowslController.checkNameLenInvalid(changeName,self.lenLimit)then
return
end

local func=function(...)
if _this==nil then return end
_this:onCheckStringLegal(...)
end
chatProtocolControl.sendCheckLegalStr(changeName,func)
end

function UIDiscipleEquipPresetRenameWin:onCheckStringLegal(str,legalStr)
local func=function(str)
if legalStr~=str then
UIManager.error('名称中含有敏感字符')
return
end
discipleEquipPresetController:renameDiscipleEquipPreset(self.disciple_guid,self.presetIdx,legalStr)
self:closeSelf()
end
platformSDK:reqMsgSecCheck(1,str,function(reContent)
if reContent==str then
func(reContent)
else
UIManager.error('名称中含有敏感字符')
end
end)
end