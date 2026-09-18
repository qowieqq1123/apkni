







def_class("UICdkeyWin",UIWindowBase)









function UICdkeyWin:bindComponents()

self.InputField=UIInputField.get(self,0)
self.sureBtn=UIButton.get(self,1)
self.cancelBtn=UIButton.get(self,2)
self.Placeholder=UIText.get(self,3)

self.sureBtn:setButtonClick(function()self:onSureBtn()end)

self.cancelBtn:setButtonClick(function()self:onCancelBtn()end)



end


function UICdkeyWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.InputField);self.InputField=nil;
_UIObject_release(self.sureBtn);self.sureBtn=nil;
_UIObject_release(self.cancelBtn);self.cancelBtn=nil;
_UIObject_release(self.Placeholder);self.Placeholder=nil;
end
















local maxSendCount=10




function UICdkeyWin:onLoaded(...)
self:bindComponents()
end


function UICdkeyWin:__delete()
self:unbindComponents()
end




function UICdkeyWin:onShow(argtable,afterOnloaded)

end


function UICdkeyWin:onHide()

end



function UICdkeyWin:onSureBtn()
local checkEmpty=false
local list={}
local str=self.InputField:getInputFieldValue()
if str==''then
checkEmpty=true
else
local temp=string.gsub(str,"\r","")
temp=string.split(temp,"\n")
if#temp<=0 then
checkEmpty=true
end
for i,v in ipairs(temp)do
if v~=''then
table.insert(list,v)
end
end
if#list<=0 then
checkEmpty=true
end
end
if checkEmpty then
UIManager.info('请先输入兑换码')
return
end
if#list>maxSendCount then
UIManager.info(FMT.fmt('最多同时输入{0}条兑换码',maxSendCount))
return
end

UISettingController:req_cdkey_reward(list)
self.InputField:setInputFieldValue('')
end

function UICdkeyWin:onCancelBtn()
self.Placeholder:setActive(true)
self.InputField:setInputFieldValue('')
end

function UICdkeyWin:onClickInput()
self.Placeholder:setActive(false)
end