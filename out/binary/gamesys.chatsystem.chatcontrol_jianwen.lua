local _jianwenMesgCache={}
local _jianwenInit=false

function chatControl:onAppStart_jianwen()
notifySystem:listenNotify(notifyConfig.onEventInitFinish,self.onEventInitFinish)
end

function chatControl:onEnterState_jianwen(isReconnet)
_jianwenMesgCache={}
_jianwenInit=false
end

function chatControl:onLeaveState_jianwen(isReconnet)
_jianwenMesgCache={}
_jianwenInit=false
end

function chatControl.onEventInitFinish()
_jianwenInit=true
chatControl.dequeueJianwenCache()
end


function chatControl.onRecvEventJianWenMesg(mesg,eventid,paramList,timeStamp,mainType,subType)
if mesg==''then
logErr('见闻下发消息为空')
return
end


local initStamp=gameUtilityModel.getServerLongInitTime()
if timeStamp<initStamp then





return
end

chatControl.addJianWenMesg(CHAT_MSG_TYPE.eNoFitler,mesg,timeStamp)
end

function chatControl.addJianWenMesg(msgFilterType,mesg,timeStamp)
if not chatMesgFilterControl.check(msgFilterType,mesg)then return end

local channelId=CHAT_CHANNNEL.eJianwen
if timeStamp==nil then timeStamp=timeHelper.getServerLongTime()end
_jianwenMesgCache[#_jianwenMesgCache+1]={mesg,timeStamp,msgFilterType}
chatControl.dequeueJianwenCache()
end

function chatControl.sortJianwenCache()
if#_jianwenMesgCache>1 then
table.sort(_jianwenMesgCache,function(a,b)
return a[2]<b[2]
end)
end
end


function chatControl.dequeueJianwenCache()
if _jianwenInit and#_jianwenMesgCache>0 then
chatControl.sortJianwenCache()
for i,v in ipairs(_jianwenMesgCache)do
chatControl.updateJianwenMesg(v[1],v[2],v[3])
end
_jianwenMesgCache={}
end
end

function chatControl.updateJianwenMesg(mesg,timeStamp,msgFilterType)
if msgFilterType==nil then
loggerUtil.logErrFMT('没有传递消息筛选类型')
return
end
local channelId=CHAT_CHANNNEL.eJianwen
if chatControl.isDisableReceive(channelId)then return end
local year=gameUtilityModel.getGameYearPassByLongStamp(timeStamp)

local title=FMT.cfmt(FONT_COLOR.eNomalGrayColor,'第{0}年',year)
local systemInfo=chatSystemStruct.create(timeStamp,channelId,mesg,{showTitle=title})
chatControl.onHandleRecvMesg(systemInfo)

local mainSystemInfo=chatSystemStruct.create(timeStamp,channelId,mesg)
chatControl.onHandleMainRecvMesg(mainSystemInfo)

local hourPos=chatMesgFilterControl.getHourPosByMsgType(msgFilterType)
chatControl.onHandleCustomMesg(timeStamp,'',mesg,hourPos,{channelId})

notifySystem:postNotify(notifyConfig.onRecvMessage,channelId)
end
