local _channelsFlag={}

local _checkRegexInfoLost={
[CHAT_REGEX_TYPE.eTianMoRuQin]=function(regexInfo,actorInfo)
if actorInfo then
if playerModel:checkServerId(actorInfo.serverId)then
return false
else
return true
end
else
return false
end
end
}

function chatControl:onEnterState_func()

end

function chatControl:onLeaveState_func()

end


function chatControl.talkToActor(formType,actorInfo)
local handle=chatControl.getHandlers(CHAT_CHANNNEL.ePrivate)


if handle and
handle.mesgType==mesgType and
handle:checkActorSend(actorInfo)then
return
end

UIManager:showWindow('UIChatWin',{channelId=CHAT_CHANNNEL.ePrivate,actorInfo=actorInfo})
end

function chatControl.setChannelFlag(channelId,flag)
if _channelsFlag==nil then _channelsFlag={}end
_channelsFlag[channelId]=flag
end

function chatControl.getChannelFlag(channelId)
if _channelsFlag==nil then _channelsFlag={}end
if _channelsFlag[channelId]==nil then return true end
return _channelsFlag[channelId]
end

function chatControl.isDisableReceive(channelId,canShield)
if not initProControl.isDone()then



return true
end
if canShield==false then return false end
if channelId==nil then return false end
local ret=chatControl.getChannelFlag(channelId)==false or
not chatCommonHelper.isChannelUnlock(channelId)
return ret
end

function chatControl.onServertimeInit()
if chatControl.WarningMsg then return end
chatControl.WarningMsg=true
if pfwindowslController:checkIsGameVersion_guofu()then
chatControl.onRecvSystemMesg(CHAT_MSG_TYPE.eWarningPianzi,chatConfig.getSystemPosValue({CHAT_CHANNNEL.eSystem}),cfg_lang_get('xitong_gonggao_tips_1'),nil,false)
end
end

function chatControl.checkRegexInfoLost(regexType,regexInfo,actorInfo)
if regexType then
local check=_checkRegexInfoLost[regexType]
if check then
return check(regexInfo,actorInfo)
end
end
return false
end
