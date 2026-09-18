







def_class("UIChangeFightTeamNameWin",UIWindowBase)









function UIChangeFightTeamNameWin:bindComponents()

self.title=UIText.get(self,0)
self.btnClose=UIButton.get(self,1)
self.InputField=UIInputField.get(self,2)
self.sureBtn=UIButton.get(self,3)
self.hwnameTips=UIText.get(self,4)

self.btnClose:setButtonClick(function()self:onBtnClose()end)

self.sureBtn:setButtonClick(function()self:onSureBtn()end)



end


function UIChangeFightTeamNameWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.title);self.title=nil;
_UIObject_release(self.btnClose);self.btnClose=nil;
_UIObject_release(self.InputField);self.InputField=nil;
_UIObject_release(self.sureBtn);self.sureBtn=nil;
_UIObject_release(self.hwnameTips);self.hwnameTips=nil;
end


















local this=nil

function UIChangeFightTeamNameWin:onLoaded(...)
self:bindComponents()
this=self
local isHWFT=pfwindowslController:checkIsGameVersion_HWFT()
self.hwnameTips:setActive(isHWFT)
end


function UIChangeFightTeamNameWin:__delete()
self:unbindComponents()
this=nil
end




function UIChangeFightTeamNameWin:onShow(argtable,afterOnloaded)
local config=cfgHelper.get1(cfg_systemsetconfig_get,1)
local gameVersion=pfwindowslController:getGameVersion()
self.lenLimit=config.teamname_len[gameVersion]or config.teamname_len[1]
self.InputField:setInputCharacterLimit(self.lenLimit[2])
self.args=argtable

if self.args then
if self.args.title then
self.title:setText(self.args.title)
end
end
end


function UIChangeFightTeamNameWin:onHide()

end





function UIChangeFightTeamNameWin:onBtnClose()
UIManager:closeWindow("UIChangeFightTeamNameWin")
end



function UIChangeFightTeamNameWin:onSureBtn()
local changeName=self.InputField:getInputFieldValue()
if changeName==nil or changeName==''then
UIManager.error('阵容名不能为空')
return
end

if not pfwindowslController.checkNameLenInvalid(changeName,self.lenLimit)then
return
end
local func=function(...)
if this==nil then return end
this:onCheckStringLegal(...)
end
self.changeName=changeName
chatProtocolControl.sendCheckLegalStr(changeName,func)

end

function UIChangeFightTeamNameWin:onCheckStringLegal(str,legalStr)
if legalStr~=str then
UIManager.error('名字中含有敏感字符')
return
end
if self.args and self.args.callback then
self.args.callback(legalStr)
end
self:onBtnClose()
end