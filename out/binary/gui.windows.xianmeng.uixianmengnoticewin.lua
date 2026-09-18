







def_class("UIXianMengNoticeWin",UIWindowBase)









function UIXianMengNoticeWin:bindComponents()

self.descInput=UIInputField.get(self,0)



end


function UIXianMengNoticeWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.descInput);self.descInput=nil;
end

















function UIXianMengNoticeWin:onLoaded(...)
self:bindComponents()
end


function UIXianMengNoticeWin:__delete()

AudioManager.playBtnClick()
self:unbindComponents()
end


function UIXianMengNoticeWin:onHide()

end




function UIXianMengNoticeWin:onShow(argtable,afterOnloaded)
local lenMax=cfgHelper.get2(cfg_guildbaseconfig_get,1,"noticelen")
self.descInput:setInputCharacterLimit(lenMax)
self.notice=xianmengModel:getXMNotice()or''
self.descInput:setInputFieldValue(self.notice)
end

function UIXianMengNoticeWin:onClearBtn()

AudioManager.playBtnClick()
self.descInput:setInputFieldValue('')
end

function UIXianMengNoticeWin:onCommitBtn()
local inputdesc=self.descInput:getInputFieldValue()
inputdesc=inputdesc or''

if houtaiModel:isForbidenChangeName('该功能正在升级维护中')then
return
end

if inputdesc==''then
UIManager.info('请输入公告内容')
return
end
if helper.check_spec_chars(inputdesc)then
UIManager.info('公告含敏感字符')
return
end

if inputdesc~=self.notice then




















platformSDK:reqMsgSecCheck(1,inputdesc,function(reContent)
if reContent==inputdesc then
xianmengController:reqXMChangeNotice(inputdesc)
else
UIManager.error('公告含敏感字符')
end
end)
end
self:closeSelf()
end