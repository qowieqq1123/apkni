





chatVoiceHelper=gameState.addListener({})

local _instance=CS.GMECompoment.Instance
local _widget
local _completeAction={}
local _supportSpeech=true

function chatVoiceHelper:onAppStart()
notifySystem:listenNotify(notifyConfig.onActorDataInit,self.onActorDataInit)
self._onSpeechComplete=function(...)
self:onSpeechComplete(...)
end
if not chatVoiceHelper:checkAPI()then return false end
local widget=_instance.Widget
CS.BindWidget(widget,chatVoiceHelper)
self:init()
end

function chatVoiceHelper:onEnterState()
self:registerSpeechCompleteAction(self._onSpeechComplete,true)
end

function chatVoiceHelper:onLeaveState()
self:registerSpeechCompleteAction(self._onSpeechComplete,false)
end

function chatVoiceHelper.onActorDataInit()
if not chatVoiceHelper:checkAPI()then return end
local actorId=playerModel:getActorID()
_instance:SetActorId(tostring(actorId))
end










function chatVoiceHelper:registerPlayStartAction(action,flag)
if not self:checkAPI()then return end
if flag then
_instance:RegisterPlayStartAction(action)
else
_instance:UnRegisterPlayStartAction(action)
end
end






function chatVoiceHelper:registerPlayCompleteAction(action,flag)
if not self:checkAPI()then return end
if flag then
_completeAction[action]=true
_instance:RegisterPlayEndAction(action)
else
_completeAction[action]=nil
_instance:UnRegisterPlayEndAction(action)
end
end











function chatVoiceHelper:registerSpeechCompleteAction(action,flag)
if not self:checkAPI()then return end
if flag then
_instance:RegisterTranslatorCompleteAction(action)
else
_instance:UnRegisterTranslatorCompleteAction(action)
end
end

function chatVoiceHelper:onSpeechComplete(args,fileId,CKId,len,speechTxt)
if not self:checkAPI()then return end
local jsonTable=jsonHelper.decode(args)
local channelId=jsonTable.channelId
local msg=self:getVoice(CKId,fileId,len,speechTxt)
if channelId==CHAT_CHANNNEL.ePrivate then
local actorId=tonumber(tostring(jsonTable.actorId))
local fromType=jsonTable.fromType
chatControl.reqPrivateMesg(fromType,actorId,msg)
else
chatControl.reqPublicMesg(channelId,msg)
end
end


function chatVoiceHelper:init()
if not self:checkAPI()then return end
local errCode=_instance:InitGVoice()
if errCode==0 then return true end
self:debug('init',errCode)
return false,errCode
end


function chatVoiceHelper:isPlay()
if not self:checkAPI()then return false end
if deviceHelper.isRunEditor()then return false end
return _instance:IsPlaying()
end


function chatVoiceHelper:isPlayCKId(CKId)
if not self:checkAPI()then return false end
if deviceHelper.isRunEditor()then return false end
return _instance:IsPlayingByCKID(CKId)
end


function chatVoiceHelper:startPlay(CKId)
if not self:checkAPI()then return false end

if self:isPlayCKId(CKId)then
self:stopPlay(CKId)
return
end
if self:isPlay()then
self:stopPlay(CKId)
end
local errCode=_instance:PlayVoice(CKId)
if deviceHelper.isRunEditor()then return true end
if errCode==0 then return true end
self:debug('PlayVoice',errCode)
return false,errCode
end


function chatVoiceHelper:stopPlay(CKId)
if not self:checkAPI()then return end
if deviceHelper.isRunEditor()then return end
for k,_ in pairs(_completeAction)do
k(CKId)
end
_instance:StopPlay()
end



function chatVoiceHelper:startRecord(args)
if not self:checkAPI()then return false end
if not self:checkAPI()then return false end
if deviceHelper.isRunEditor()then return true end
local permissions,code=permissionConfig.getVoicePermissions()
if not platformSDK:hasPermission(permissions)then
platformSDK:reqPermission(permissions,code)
return false
end
args=args or''
local errCode=_instance:StartRecord(args)
if errCode==0 then return true end
self:debug('startRecord',errCode)
if errCode==-1 then
UIManager.error('请稍后，正在处理上一个语音')
end
return false,errCode
end


function chatVoiceHelper:stopRecord()
if not self:checkAPI()then return false end
if deviceHelper.isRunEditor()then return true end
local errCode=_instance:StopRecord()
if errCode==0 then return true end
self:debug('stopRecord',errCode)
if errCode==-3 then
UIManager.error('录制时间过短')
end
return false,errCode
end


function chatVoiceHelper:cancelRecord()
if not self:checkAPI()then return false end
if deviceHelper.isRunEditor()then return true end
local errCode=_instance:CancelRecord()
if errCode==0 then return true end
self:debug('cancelRecord',errCode)
return false,errCode
end


function chatVoiceHelper:upload(CKId)
if not self:checkAPI()then return false end
if deviceHelper.isRunEditor()then return true end
local errCode=_instance:StartUploadFile(CKId)
if errCode==0 then return true end
self:debug('upload',errCode)
return false,errCode
end


function chatVoiceHelper:downloadFile(fileId,filePath)
if not self:checkAPI()then return false end
if deviceHelper.isRunEditor()then return true end
local errCode=_instance:StartDownloadFile(fileId,filePath)
if errCode==0 then return true end
self:debug('downloadFile',errCode)
return false,errCode
end


function chatVoiceHelper:playFile(filePath)
if not self:checkAPI()then return false end
if deviceHelper.isRunEditor()then return true end
local errCode=_instance:StartPlayFile(filePath)
if errCode==0 then return true end
self:debug('playFile',errCode)
return false,errCode
end


function chatVoiceHelper:playMusic()
if not self:checkAPI()then return end
_instance:PlayMusic()
end


function chatVoiceHelper:stopMusic()
if not self:checkAPI()then return end
_instance:StopMusic()
end



function chatVoiceHelper:enableSpeech(flag)
if not self:checkAPI()then return end
if deviceHelper.isRunEditor()then return end
_instance.mEnableSpeech=flag
_supportSpeech=flag
end

function chatVoiceHelper:isSupportSpeech()
return _supportSpeech
end

function chatVoiceHelper:getCKId(fileId)
if not self:checkAPI()then return end
if deviceHelper.isRunEditor()then return end
local CKId
local ret=_instance:GetCKIdByFileId(fileId,CKId)
if ret then return CKId end
return nil
end

function chatVoiceHelper:addKeyValue(CKId,fileId)
if not self:checkAPI()then return end
if deviceHelper.isRunEditor()then return end
_instance:AddFileId(CKId,fileId)
end

function chatVoiceHelper:getNowCKId()
if not self:checkAPI()then return end
if deviceHelper.isRunEditor()then return end
return _instance:GetCKID()
end

function chatVoiceHelper:getFilePath(CKId)
if not self:checkAPI()then return end
if deviceHelper.isRunEditor()then return end
return _instance:GetLoadFilePath(CKId)
end


function chatVoiceHelper:matchVoice(mesg)
local CKId,fileId,length,speechTxt=string.match(mesg,chatConfig.voiceRegex)
return CKId,fileId,length,speechTxt
end

function chatVoiceHelper:getVoice(CKId,fileId,length,speechTxt)
speechTxt=speechTxt or''
return FMT.fmt(chatConfig.voiceString,CKId,fileId,length,speechTxt)
end

function chatVoiceHelper:getArgsJson(channelId,actorId,formType)
local uit={}
uit.channelId=channelId
uit.actorId=actorId
uit.fromType=formType
return jsonHelper.encode(uit)
end


function chatVoiceHelper:checkAPI()
return false











end

function chatVoiceHelper:debug(func,errCode)
loggerUtil.log(FMT.fmt('voice2 方法{0}调用返回错误码{1}',func,errCode))
end












