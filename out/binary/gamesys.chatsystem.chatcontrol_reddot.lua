
local _initReddot=nil

function chatControl:onAppStart_reddot()

end

function chatControl:onEnterState_reddot(isReconnet)
_initReddot=nil
end

function chatControl:onLeaveState_reddot(isReconnet)
_initReddot=nil
end

function chatControl:checkInitReddot(len,array)
if len==0 then return end
for i,v in ipairs(array)do
local channelId=v.channelid
local msgLen=v.len
local msgList=v.list
if _initReddot==nil then _initReddot={}end
_initReddot[channelId]=0
if msgLen>0 then
for ii=1,msgLen do
local msgInfo=msgList[ii]
local stamp=msgInfo.sec
local isBlack=false
if msgInfo.senderid then
isBlack=friendModel:isBlack(msgInfo.senderid)
end
if not chatControl:hasReadChannelMsgByStamp(channelId,stamp)and not isBlack then
_initReddot[channelId]=_initReddot[channelId]+1
end
end
end
end
UIManager:callWindowFunc('UIMain','freshChatReddot')
UIManager:callWindowFunc('UIMainBottomWin','freshChatReddot')
UIManager:callWindowFunc('UIWorldWin','freshChatReddot')
end

function chatControl:getInitReddot(channelId)
if _initReddot==nil then return 0 end
return _initReddot[channelId]or 0
end

function chatControl:clearInitReddot(channelId)
if _initReddot==nil then return end
_initReddot[channelId]=0
end

function chatControl:setReadStamp(channelId)
local stamp=timeHelper.getServerShortTime()
local typo=ACTOR_SETTING_TYPE.eChat
local readStampTable=userActorArraySetting.get(typo,'readStamp',nil)
if readStampTable==nil then readStampTable={}end
local keyStr=FMT.fmt('{0}_',channelId)
if readStampTable[keyStr]==stamp then return end
readStampTable[keyStr]=stamp
userActorArraySetting.set(typo,'readStamp',readStampTable)
userActorArraySetting.flush(typo,true)
end

function chatControl:hasReadChannelMsgByStamp(channelId,stamp)
local typo=ACTOR_SETTING_TYPE.eChat
local readStampTable=userActorArraySetting.get(typo,'readStamp',nil)
if readStampTable==nil then return false end
local keyStr=FMT.fmt('{0}_',channelId)
if readStampTable[keyStr]==nil then return false end
return readStampTable[keyStr]>=stamp
end

function chatControl:setReadActorStamp(actorId)
local stamp=timeHelper.getServerShortTime()
local typo=ACTOR_SETTING_TYPE.eChat
local readStampTable=userActorArraySetting.get(typo,'readActorStamp',nil)
if readStampTable==nil then readStampTable={}end
local keyStr=FMT.fmt('{0}_',actorId)
if readStampTable[keyStr]==stamp then return end
readStampTable[keyStr]=stamp
userActorArraySetting.set(typo,'readActorStamp',readStampTable)
userActorArraySetting.flush(typo,true)
end

function chatControl:hasReadActorMsgByStamp(actorId,stamp)
local typo=ACTOR_SETTING_TYPE.eChat
local readStampTable=userActorArraySetting.get(typo,'readActorStamp',nil)
if readStampTable==nil then return false end
local keyStr=FMT.fmt('{0}_',actorId)
if readStampTable[keyStr]==nil then return false end
return readStampTable[keyStr]>=stamp
end