







def_class("UIChatDefineEmotDetailEditorPanel",UIWindowBase)









function UIChatDefineEmotDetailEditorPanel:bindComponents()

self.emotcon=UIImage.get(self,0)
self.InputField=UIInputField.get(self,1)
self.bg=UIObject.get(self,2)
self.desc=UIText.get(self,3)
self.storeTxt=UIText.get(self,4)



end


function UIChatDefineEmotDetailEditorPanel:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.emotcon);self.emotcon=nil;
_UIObject_release(self.InputField);self.InputField=nil;
_UIObject_release(self.bg);self.bg=nil;
_UIObject_release(self.desc);self.desc=nil;
_UIObject_release(self.storeTxt);self.storeTxt=nil;
end

















local _opType=
{
eStore=1,
eSend=2,
}
local _costTime=5

function UIChatDefineEmotDetailEditorPanel:onLoaded(...)
self:bindComponents()
self.checkLookup={}
self.stepCheckLookup={}
self.opList={}
end

function UIChatDefineEmotDetailEditorPanel:__delete()
self:unbindComponents()
end

function UIChatDefineEmotDetailEditorPanel:onShow(argtable,afterOnloaded)
local emotid=argtable
self.emotid=emotid
local defineEmotConfig=chatConfig.getDefineEmotConfigById(emotid)
local limit=defineEmotConfig.limit
self.InputField:setInputCharacterLimit(limit)
local size=defineEmotConfig.size
local position=defineEmotConfig.position
local assetname=defineEmotConfig.assetname
local iconname=iconHelper.getBigEmotIcon(defineEmotConfig.icon)
self.widget:SetChildLocalPos(self.bg:getID(),position[1],position[2],0)
self.widget:SetChildSizeDelta(self.bg:getID(),size[1],size[2])
self.desc:setText('')
self.InputField:setInputFieldValue('')




self.emotcon:setImageIcon(iconname,true)

end

function UIChatDefineEmotDetailEditorPanel:onHide()

end

function UIChatDefineEmotDetailEditorPanel:freshStoreTxt()
local stamp=timeHelper.getServerLongTime()
local lastStamp=self.lastStamp
local div=stamp
if lastStamp then
div=stamp-lastStamp
end
local isDone=div>=_costTime
local leftTimeStr=isDone and''or FMT.fmt('({0})',_costTime-div)
self.storeTxt:setText(FMT.fmt('保存{0}',leftTimeStr))
return isDone
end

function UIChatDefineEmotDetailEditorPanel:stopStoreTimer()
if self.storeTimer then
self:stopTimerByID(self.storeTimer)
self.storeTimer=nil
end
end

function UIChatDefineEmotDetailEditorPanel:startStoreTimer()
self:stopStoreTimer()
self.storeTimer=self:setTimer(1,0,function()
if self and not self.isClose then
if self:freshStoreTxt()then
self:stopStoreTimer()
end
end
end)
end




function UIChatDefineEmotDetailEditorPanel:onInputFieldChanged()
local str=self.InputField:getInputFieldValue()
self.desc:setText(str)
end

function UIChatDefineEmotDetailEditorPanel:onStoreClick()
local stamp=timeHelper.getServerLongTime()
if self.lastStamp then
local div=stamp-self.lastStamp
if div<_costTime then return end
end
self.lastStamp=stamp
self:freshStoreTxt()
self:startStoreTimer()
local str=self.InputField:getInputFieldValue()
if str==''then
UIManager.error('请先编辑文本')
return
end
local legalStr=self.checkLookup[str]
if legalStr==nil then
self:doCheckLegal(_opType.eStore,str)
elseif legalStr and legalStr==str then
self:doStore(self.emotid,str)
else
UIManager.error('含有屏蔽字，请重新编辑')
end
end

function UIChatDefineEmotDetailEditorPanel:onSendClick()
local str=self.InputField:getInputFieldValue()
if str==''then
UIManager.error('请先编辑文本')
return
end
local legalStr=self.checkLookup[str]
if legalStr==nil then
self:doCheckLegal(_opType.eSend,str)
elseif legalStr and legalStr==str then
self:doSend(self.emotid,str)
UIManager:closeWindow('UIChatDefineEmotEditorPanel')
UIManager:closeWindow('UIChatEmotWin')
self:closeSelf()
else
UIManager.error('含有屏蔽字，请重新编辑')
end
end


function UIChatDefineEmotDetailEditorPanel:onCheckLegalStrRet(sendid,legalStr)
local str=self.stepCheckLookup[sendid]
self.checkLookup[str]=legalStr
if str~=legalStr then
UIManager.error('含有屏蔽字，请重新编辑')
self.opList[str]=nil
return
end
self:doAfterCheck(str,legalStr)
end

function UIChatDefineEmotDetailEditorPanel:doSend(emotid,str)
local mesg=chatEmotHelper.getBigEmotMesg(CHAT_EMOT_STYPE.eDefine,emotid,str,2)
chatControl.invokeSelectHandlerFunc('sendMesg',mesg)
end

function UIChatDefineEmotDetailEditorPanel:doStore(emotid,str)
if chatEmotHelper.isMaxDefineEmot()then
UIManager.error('自定义表情已达到上限')
return
end
chatProtocolControl.sendAddDefineEmot(emotid,str)
end

function UIChatDefineEmotDetailEditorPanel:doCheckLegal(opType,str)
local sendid,legalStr=chatProtocolControl.sendCheckLegalStr(str)
self.stepCheckLookup[sendid]=str
if self.opList[str]==nil then self.opList[str]={}end
self.opList[str][opType]=true
if legalStr then
self:onCheckLegalStrRet(sendid,legalStr)
end
end

function UIChatDefineEmotDetailEditorPanel:doAfterCheck(str,legalStr)
local emotid=self.emotid
local oplist=self.opList[str]
for opType,flag in pairs(oplist)do
if opType==_opType.eSend then
self:doSend(emotid,legalStr)
UIManager:closeWindow('UIChatDefineEmotEditorPanel')
UIManager:closeWindow('UIChatEmotWin')
self:closeSelf()
return
elseif opType==_opType.eStore then
self:doStore(emotid,legalStr)
end
end
self.opList[str]=nil
end