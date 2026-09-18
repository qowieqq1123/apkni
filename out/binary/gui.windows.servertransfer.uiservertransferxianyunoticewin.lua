







def_class("UIServerTransferXianYuNoticeWin",UIWindowBase)









function UIServerTransferXianYuNoticeWin:bindComponents()

self.descInput=UIInputField.get(self,0)



end


function UIServerTransferXianYuNoticeWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.descInput);self.descInput=nil;
end



















function UIServerTransferXianYuNoticeWin:onLoaded(...)
self:bindComponents()
end


function UIServerTransferXianYuNoticeWin:__delete()
self:unbindComponents()
end




function UIServerTransferXianYuNoticeWin:onShow(argtable,afterOnloaded)
local cross_id=argtable
self.notice=ServerTransferModel:getXianYuDetailsNotice(cross_id)
if not self.notice or self.notice==""then
self.notice=cfgHelper.get2(cfg_switchserverlevelbasicconfig_get,1,"def_notice")
end
self.descInput:setInputFieldValue(self.notice)
end

function UIServerTransferXianYuNoticeWin:onClearBtn()

AudioManager.playBtnClick()
self.descInput:setInputFieldValue('')
end

function UIServerTransferXianYuNoticeWin:onCommitBtn()
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
ServerTransferController:send_35_165(inputdesc)
else
UIManager.error('公告含敏感字符')
end
end)
end
self:closeSelf()
end