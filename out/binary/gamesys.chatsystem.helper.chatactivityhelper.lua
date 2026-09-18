chatActivityHelper={}

local _analysis={
[SUB_ACTIVITY_TYPE.eCangBaoGe]=function(actId,subType,subId,paramStr,actorInfo)
local datas=string.split(paramStr,',')

local hType,actorId,itemId,dzData,dzImage,infoGuid
local s,e=pcall(function()
hType=tonumber(datas[1])
actorId=int64.new(datas[2])
itemId=tonumber(datas[3])
dzData=tonumber(datas[4])
dzImage=int64.new(datas[5])
infoGuid=datas[6]and int64.new(datas[6])or nil
end)
if not s then
loggerUtil.logErrFMT('藏宝阁活动链接内容错误：{0}',paramStr)
return
end
if hType and actorId and itemId and dzData and dzImage then
local args={
actId=actId,
subType=subType,
subId=subId,
hType=hType,
actorId=actorId,
itemId=itemId,
dzData=dzData,
dzImage=dzImage,
infoGuid=infoGuid,
serverId=actorInfo and actorInfo.serverId or nil,
}
return args
else
loggerUtil.logErrFMT('藏宝阁活动链接内容错误：{0}',paramStr)
return
end




end,
}

local _cmpTypeName={
[SUB_ACTIVITY_TYPE.eCangBaoGe]={
[1]={CHAT_COM_TYPE.eChatRightCangBaoGeShare,CHAT_COM_TYPE.eChatLeftCangBaoGeShare},
[2]={CHAT_COM_TYPE.eChatRightCangBaoGeSOS,CHAT_COM_TYPE.eChatLeftCangBaoGeSOS},
}
}

local _mainItemDesc={
[SUB_ACTIVITY_TYPE.eCangBaoGe]={
[2]={
function(actArgs)
local itemName=itemsConfig.getColorName(actArgs.itemId)
return FMT.fmt("帮帮我，我需要{0}",itemName)
end,
function(actArgs)
local itemName=itemsConfig.getColorName(actArgs.itemId)
return FMT.fmt("帮帮我，我需要{0}",itemName)
end,
},
}
}

function chatActivityHelper:matchActivity(mesg,actorInfo)
local actInfoStr,actDetailStr=string.match(mesg,chatConfig.actRegex)
if actInfoStr and actDetailStr then
local actInfoData=string.split(actInfoStr,',')
if#actInfoData==3 then
local actId,subType,subId
local s,e=pcall(function()
actId=tonumber(actInfoData[1])
subType=tonumber(actInfoData[2])
subId=tonumber(actInfoData[3])
end)
if not s then
loggerUtil.logErrFMT('活动链接内容错误：{0}',mesg)
return
end
if actId and subType and subId then
local handle=_analysis[subType]
if handle then
return true,handle(actId,subType,subId,actDetailStr,actorInfo)
else
loggerUtil.logErrFMT('活动链接没有解析处理：{0}，{1}',subType,mesg)
return false
end
else
loggerUtil.logErrFMT('活动链接内容错误：{0}',mesg)
return
end
else
loggerUtil.logErrFMT('活动链接内容错误：{0}',mesg)
return false
end
end
end

function chatActivityHelper:getCmpTypeName(subType,type,isSelf)
if _cmpTypeName[subType]then
if _cmpTypeName[subType][type]then
local index=isSelf and 1 or 2
return _cmpTypeName[subType][type][index]
end
end
end

function chatActivityHelper:getMainItemDesc(actArgs,isSelf)
if _mainItemDesc[actArgs.subType]then
if _mainItemDesc[actArgs.subType][actArgs.hType]then
local index=isSelf and 1 or 2
return _mainItemDesc[actArgs.subType][actArgs.hType][index](actArgs)
end
end
return nil
end