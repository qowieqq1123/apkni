







def_class("UIHuiGuiBangDingDialogWin",UIWindowBase)









function UIHuiGuiBangDingDialogWin:bindComponents()

self.InputField=UIInputField.get(self,0)
self.bindBtn=UIButton.get(self,1)
self.goBtn=UIButton.get(self,2)
self.bindFlag=UIObject.get(self,3)

self.bindBtn:setButtonClick(function()self:onBindBtn()end)

self.goBtn:setButtonClick(function()self:onGoBtn()end)



end


function UIHuiGuiBangDingDialogWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.InputField);self.InputField=nil;
_UIObject_release(self.bindBtn);self.bindBtn=nil;
_UIObject_release(self.goBtn);self.goBtn=nil;
_UIObject_release(self.bindFlag);self.bindFlag=nil;
end



















function UIHuiGuiBangDingDialogWin:onLoaded(...)
self:bindComponents()
self.InputField:setChildInputFieldChange(true,function(...)self:onInputFieldChange(...)end)
end


function UIHuiGuiBangDingDialogWin:__delete()
self:unbindComponents()
end




function UIHuiGuiBangDingDialogWin:onShow(argtable,afterOnloaded)
if argtable then
self.actId=argtable[1]
self.subId=argtable[2]
end

local nowBindingCode=welfareModel:getBindReturnCode()
self.isBinding=nowBindingCode~=nil and not mathHelper.compareInt64(nowBindingCode,int64.new('0'))

local zhm_const_def=cfg_zhaohuimaconfig().const_def
if self.isBinding then

local nowBindingCodeStr=mathHelper.convertDecimalTo35System(mathHelper.int64_to_number(nowBindingCode),INVITATION_CODE_MIN_POS_COUNT,zhm_const_def.turnStr)
self.InputField:setInputFieldValue(nowBindingCodeStr)
end

local inputField=self.InputField:getCommonComponent('InputField')
inputField.interactable=not self.isBinding

self.bindBtn:setActive(not self.isBinding)
self.bindFlag:setActive(self.isBinding)
end


function UIHuiGuiBangDingDialogWin:onHide()

end




function UIHuiGuiBangDingDialogWin:onBindBtn()
local codeStr=self.InputField:getInputFieldValue()
if not codeStr or codeStr==""then
return UIManager.error("请先输入回归码")
end
local zhm_const_def=cfg_zhaohuimaconfig().const_def
local codeNum=mathHelper.convert35SystemToDecimal(codeStr,zhm_const_def.turnStr)
local codeNum_int_64=mathHelper.number_to_int64(codeNum)

welfareController:reqReturnCodeBind(codeNum_int_64)
end

function UIHuiGuiBangDingDialogWin:onGoBtn()
if self.actId and self.subId then
call_activitiesHandle_func('activitiesHandle_guituzhiyin','reqSelectReturnWay',self.actId,self.subId,2)
else
UIManager:invokeUIMethod('UIGuiTuZhiYinWin','callActivityFunc','reqSelectReturnWay',2)
self:closeSelf()
end
end

function UIHuiGuiBangDingDialogWin:onInputFieldChange(str)
if self:isAlphanumeric(str)then
local upperStr=string.upper(str)
self.InputField:setInputFieldValue(upperStr)
else
self.InputField:setInputFieldValue("")
end
end


function UIHuiGuiBangDingDialogWin:isAlphanumeric(str)
return not string.match(str,"[^%w]")
end