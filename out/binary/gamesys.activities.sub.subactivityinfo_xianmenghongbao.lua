









local subActivityInfo_xianmenghongbao={name='subActivityInfo_xianmenghongbao'}

function subActivityInfo_xianmenghongbao:onInit()








self._onXianMengChange=function(...)
self:onXianMengChange(...)
end



















end

function subActivityInfo_xianmenghongbao:onStart()


self:listenNotify(notifyConfig.onXianMengChange,self._onXianMengChange)
end

function subActivityInfo_xianmenghongbao:onDelete()

end

function subActivityInfo_xianmenghongbao:checkReddot()
local progressRwList=self:getSubActConfig("score_reward")
local data=self:getData()
if data==nil then
return false
end
local score=data.score
local maxGotIdx=data.scoreGotRewardIdx
for i,rewardCfg in ipairs(progressRwList)do
local targetScore=rewardCfg[1]
local isGot=i<=maxGotIdx
local isCanGet=score>=targetScore
if isCanGet and not isGot then
return true
end
end

return false
end

function subActivityInfo_xianmenghongbao:onUpdate()
if self.nextCheckTime then
local nowTime=timeHelper.getServerShortTime()
if nowTime>=self.nextCheckTime then
self.nextCheckTime=nil
self:handleOverDay()
return self:setNextCheckTime()
end
end
end

function subActivityInfo_xianmenghongbao:onXianMengChange(flag)
activitiesController:sendProtocol(actSendType.eComonReqInfo,self.act_id,self.sub_act_type,self.sub_act_id)
end




















function subActivityInfo_xianmenghongbao:setNextCheckTime()
self.nextCheckTime=nil

local nowTime=timeHelper.getServerShortTime()
local guildList=self:getGuildList()
local minEndTime
if guildList then
for index,guildData in ipairs(guildList)do
if nowTime<guildData.endTime then
if not minEndTime or guildData.endTime<minEndTime then
minEndTime=guildData.endTime
end
end
end
end
self.nextCheckTime=minEndTime
end

function subActivityInfo_xianmenghongbao:handleOverDay()
local nowTime=timeHelper.getServerShortTime()
local guildList=self:getGuildList()
local guildLookup=self:getGuildLookup()
if guildList and guildLookup then

for index,guildData in ipairs(guildList)do
if guildData.endTime<=nowTime then


if playerModel:checkActorId(guildData.dispatcher)then

self:markMySort()
end
end
end
end

self:refreshAllGuildData()
self:markGuildSort()
notifySystem:postNotify(notifyConfig.onXMHBPlayerDataChange,self.act_id,self.sub_act_type,self.sub_act_id)
notifySystem:postNotify(notifyConfig.onXMHBGuildDataChange,self.act_id,self.sub_act_type,self.sub_act_id,nil,true)
end

function subActivityInfo_xianmenghongbao:markGuildSort()
local data=self:getData()
if data and data.guildSort==false then
data.guildSort=true
end
end

function subActivityInfo_xianmenghongbao:markMySort()
local data=self:getData()
if data and data.mySort==false then
data.mySort=true
end
end

function subActivityInfo_xianmenghongbao:checkGuildSort()
local data=self:getData()
if data and data.guildList and data.guildSort then
if#data.guildList>1 then
table.sort(data.guildList,function(a,b)
if a.status~=b.status then
return a.status<b.status
else
return a.time>b.time
end
end)
end
data.guildSort=false
end
end











function subActivityInfo_xianmenghongbao:getPlayerList()
local data=self:getData()
if data then
return data.playerList
end
end

function subActivityInfo_xianmenghongbao:getPlayerData(hbId)
local datas=self:getPlayerList()
if datas then
return datas[hbId]
end
end

function subActivityInfo_xianmenghongbao:getGuildData(hbGuid)
local key=tostring(hbGuid)
return self:getGuildDataEx(key)
end

function subActivityInfo_xianmenghongbao:getGuildDataEx(key)
local data=self:getData()
if data and data.guildLookup then
return data.guildLookup[key]
end
end

function subActivityInfo_xianmenghongbao:getGuildList()
local data=self:getData()
if data and data.guildList then
return data.guildList
end
end

function subActivityInfo_xianmenghongbao:getGuildLookup()
local data=self:getData()
if data and data.guildLookup then
return data.guildLookup
end
end

function subActivityInfo_xianmenghongbao:getMyList()
local data=self:getData()
if data and data.myList then
return data.myList
end
end

function subActivityInfo_xianmenghongbao:checkMySort()
local data=self:getData()
if data and data.myList and data.mySort then
if#data.myList>1 then
table.sort(data.myList,function(a,b)
local aData=self:getGuildDataEx(a)
local bData=self:getGuildDataEx(b)
return aData.time<bData.time
end)
end
data.mySort=false
end
end







function subActivityInfo_xianmenghongbao:initAllData(sendHBList,xmhbList,score,scoreGotRewardIdx,hbGotCountListLen,hbGotCountList)

local data=self:getData()
if data==nil then
data={}
self:setData(data)
end
data.score=score
data.scoreGotRewardIdx=scoreGotRewardIdx


data.sendHBCountLookup={}
for i,v in ipairs(sendHBList)do
local hbLv=v.param_1
local hbId=v.param_2
local sendCount=v.param_3
if not data.sendHBCountLookup[hbLv]then
data.sendHBCountLookup[hbLv]={}
end
data.sendHBCountLookup[hbLv][hbId]=sendCount
end

data.guildList={}
data.guildLookup={}
data.myList={}
data.guildSort=true
data.mySort=true
for i,v in ipairs(xmhbList)do
local guildData=self:createServerGuildData(v)
data.guildLookup[guildData.key]=guildData
table.insert(data.guildList,guildData)
if playerModel:checkActorId(guildData.dispatcher)then
table.insert(data.myList,guildData.key)
end
end

data.gotCountList={}
if hbGotCountListLen>0 then
for i,v in ipairs(hbGotCountList)do
local hbLv=v.param_1
local gotCount=v.param_2
data.gotCountList[hbLv]=gotCount
end
end


self:setNextCheckTime()
end

function subActivityInfo_xianmenghongbao:addGotHbCountByHbLv(hbLv)
local maxCount=self:getMaxCanGetHbCount(hbLv)
local data=self:getData()
if data then
if not data.gotCountList then
data.gotCountList={}
end
if not data.gotCountList[hbLv]then
data.gotCountList[hbLv]=1
elseif data.gotCountList[hbLv]+1<=maxCount then
data.gotCountList[hbLv]=data.gotCountList[hbLv]+1
end
end
end

function subActivityInfo_xianmenghongbao:getGotHbCount(hbLv)
local data=self:getData()
if data and data.gotCountList then
return data.gotCountList[hbLv]or 0
end
return 0
end

function subActivityInfo_xianmenghongbao:getAllGotHbCount()
local data=self:getData()
local gotCount=0
if data and data.gotCountList then
for hbLv,count in pairs(data.gotCountList)do
gotCount=gotCount+count
end
end
return 0
end

function subActivityInfo_xianmenghongbao:getMaxCanGetHbCount(hbLv)

local hbAllCfgList=self:getSubActConfig("hongbao_level_conf")
local hbCfgList=hbAllCfgList[hbLv]
local maxCount=hbCfgList and hbCfgList[5]or 0
return maxCount
end

function subActivityInfo_xianmenghongbao:getAllMaxCanGetHbCount()

local hbAllCfgList=self:getSubActConfig("hongbao_level_conf")
local maxCount=0
for hbLv,v in ipairs(hbAllCfgList)do
local count=v and v[5]or 0
maxCount=maxCount+count
end
return maxCount
end

function subActivityInfo_xianmenghongbao:getCanGetHbCount(hbLv)
local maxCount=self:getMaxCanGetHbCount(hbLv)
local gotCount=self:getGotHbCount(hbLv)
local canGetCount=maxCount-gotCount
return canGetCount
end

function subActivityInfo_xianmenghongbao:getAllCanGetHbCount()
local maxCount=self:getAllMaxCanGetHbCount()
local gotCount=self:getAllGotHbCount()
local canGetCount=maxCount-gotCount
return canGetCount
end

function subActivityInfo_xianmenghongbao:getSendHBCount(hbLv,hbId)
local data=self:getData()
if data and data.sendHBCountLookup and data.sendHBCountLookup[hbLv]then
return data.sendHBCountLookup[hbLv][hbId]or 0
end
return 0
end

function subActivityInfo_xianmenghongbao:setScoreGotRewardIdx(scoreGotRewardIdx)
local data=self:getData()
if data then
data.scoreGotRewardIdx=scoreGotRewardIdx
end
end

function subActivityInfo_xianmenghongbao:addGuildData(hbInfo)
local data=self:getData()
if data and data.guildList and data.guildLookup then
local guildData=self:createServerGuildData(hbInfo)
data.guildLookup[guildData.key]=guildData
table.insert(data.guildList,guildData)
data.guildSort=true

local playerChange=false
local reSort=false
if playerModel:checkActorId(guildData.dispatcher)then

table.insert(data.myList,guildData.key)


local hbLvCfgList=self:getSubActConfig("hongbao_level_conf")
local hbLv=hbInfo.level
local hbId=hbInfo.hb_id
local hbLvCfg=hbLvCfgList[hbLv]
local hbScore=hbLvCfg[3]
data.score=data.score+hbScore
local sendHBCountLookup=data.sendHBCountLookup
if not sendHBCountLookup[hbLv]then
sendHBCountLookup[hbLv]={}
end

if sendHBCountLookup[hbLv][hbId]then
data.sendHBCountLookup[hbLv][hbId]=data.sendHBCountLookup[hbLv][hbId]+1
else
data.sendHBCountLookup[hbLv][hbId]=1
end
local sendHBCount=data.sendHBCountLookup[hbLv][hbId]

data.mySort=true
reSort=true
playerChange=true
local win=UIManager:findActiveWindow("UISubAct_XMHB_mainWin")
if win then
win:playSendAnim(hbInfo)
else
UIManager.info("已分享红包至仙盟频道")
end

local hbCfgList=self:getSubActConfig("hongbao_conf")
local hbCfg=hbCfgList and hbCfgList[hbLv]and hbCfgList[hbLv][hbId]or nil
local maxSendCount=hbCfg and hbCfg[3]or nil
local isSendMax=maxSendCount and sendHBCount>=maxSendCount or false
if isSendMax then

local _key=FMT.fmt('actid{0}_subtype{1}_subid{2}',self.act_id,self.sub_act_type,self.sub_act_id)
local localData=userActorArraySetting.get(ACTOR_SETTING_TYPE.eXianMengHongBaoAct,_key,{})
localData[tostring(hbLv)]=nil
userActorArraySetting.set(ACTOR_SETTING_TYPE.eXianMengHongBaoAct,_key,localData)
userActorArraySetting.flush(ACTOR_SETTING_TYPE.eXianMengHongBaoAct)
end
end
if playerChange then
notifySystem:postNotify(notifyConfig.onXMHBPlayerDataChange,self.act_id,self.sub_act_type,self.sub_act_id,guildData.id)
end
notifySystem:postNotify(notifyConfig.onXMHBGuildDataChange,self.act_id,self.sub_act_type,self.sub_act_id,guildData.guid,reSort)


self:setNextCheckTime()
end
end

function subActivityInfo_xianmenghongbao:countGuildDataStatus(status)
local count=0
local guildList=self:getGuildList()
if guildList then
for i,v in ipairs(guildList)do
if v.status==status then
count=count+1
end
end
end
return count
end

function subActivityInfo_xianmenghongbao:getGuildDataCanGetRedPacketCount()
local count=0
local redPacketAllCount=0
local guildList=self:getGuildList()
local nowTime=timeHelper.getServerShortTime()
local levelCountList={}
if guildList then
for i,v in ipairs(guildList)do
if v.status==eXMRedPacketStatus.eNormal and nowTime<v.endTime then
local hbLv=v.level
local canGetCount=self:getCanGetHbCount(hbLv)
if canGetCount>0 then
if not levelCountList[hbLv]then
levelCountList[hbLv]=0
end
if levelCountList[hbLv]+1<=canGetCount then
levelCountList[hbLv]=levelCountList[hbLv]+1
end
end
redPacketAllCount=redPacketAllCount+1
end
end
end

for hbLv,lvCount in pairs(levelCountList)do
count=count+1
end
return count,redPacketAllCount
end

function subActivityInfo_xianmenghongbao:createServerGuildData(hbInfo)
local hbCfgList=self:getSubActConfig("hongbao_conf")
local hbLvCfgList=self:getSubActConfig("hongbao_level_conf")
local hbShowParamList=self:getSubActConfig("hongbaoShowParam")
local hbLv=hbInfo.level
local hbId=hbInfo.hb_id
local hbCfg=hbCfgList[hbLv]and hbCfgList[hbLv][hbId]or nil
local hbLvCfg=hbLvCfgList[hbLv]or nil
local lookup={}
if hbInfo.recv_list_len>0 then
for j,w in ipairs(hbInfo.recvHbList or{})do
local key=tostring(w.recv_actor_id)
lookup[key]=w
end
end













local hbShowParam=hbShowParamList[hbLv]
local hbSkinId=hbShowParam.skinid

local maxRewardCnt=hbLvCfg and hbLvCfg[2]or 0
local data={
key=tostring(hbInfo.un_id),
guid=hbInfo.un_id,
level=hbInfo.level,
id=hbInfo.hb_id,
dispatcher=hbInfo.send_actor_id,
dispatcherName=hbInfo.send_name,
getCnt=hbInfo.recv_cnt,
getMax=maxRewardCnt,
time=hbInfo.send_time,
endTime=hbInfo.end_time,

receiverList=hbInfo.recvHbList,
receiverLookup=lookup,

status=nil,
hbSkinId=hbSkinId,
}

self:refreshGuildDataStatus(data)
return data
end


function subActivityInfo_xianmenghongbao:refreshGuildData(gildData,hbInfo)
local guidKey=tostring(hbInfo.un_id)
if gildData.key~=guidKey then

return
end

local hbCfgList=self:getSubActConfig("hongbao_conf")
local hbLvCfgList=self:getSubActConfig("hongbao_level_conf")
local hbShowParamList=self:getSubActConfig("hongbaoShowParam")
local hbLv=hbInfo.level
local hbId=hbInfo.hb_id
local hbCfg=hbCfgList[hbLv]and hbCfgList[hbLv][hbId]or nil
local hbLvCfg=hbLvCfgList[hbLv]or nil
local lookup={}
if hbInfo.recv_list_len>0 then
for j,w in ipairs(hbInfo.recvHbList or{})do
local key=tostring(w.recv_actor_id)
lookup[key]=w
end
end
local hbShowParam=hbShowParamList[hbLv]
local hbSkinId=hbShowParam.skinid

local maxRewardCnt=hbLvCfg and hbLvCfg[2]or 0
gildData.level=hbInfo.level
gildData.id=hbInfo.hb_id
gildData.dispatcher=hbInfo.send_actor_id
gildData.dispatcherName=hbInfo.send_name
gildData.getCnt=hbInfo.recv_cnt
gildData.getMax=maxRewardCnt
gildData.time=hbInfo.send_time
gildData.endTime=hbInfo.end_time
gildData.receiverList=hbInfo.recvHbList
gildData.receiverLookup=lookup
gildData.status=nil
gildData.hbSkinId=hbSkinId

self:refreshGuildDataStatus(gildData)
end

function subActivityInfo_xianmenghongbao:getGuildDataStatus(guildData)
local playerId=playerModel:getActorID()
local key=tostring(playerId)
local playerData=self:getPlayerData(guildData.id)
if guildData.receiverLookup[key]then
return eXMRedPacketStatus.eGetted
elseif guildData.getCnt>=guildData.getMax then
return eXMRedPacketStatus.eNotLeast




else
return eXMRedPacketStatus.eNormal
end
end

function subActivityInfo_xianmenghongbao:refreshGuildDataStatus(guildData)
if guildData.status and not eXMRedPacketStatusCanChange[guildData.status]then
return
end
guildData.status=self:getGuildDataStatus(guildData)
end

function subActivityInfo_xianmenghongbao:refreshAllGuildData(hbId)
local guildList=self:getGuildList()
if guildList then
for i,v in ipairs(guildList)do
if hbId==nil or v.id==hbId then
self:refreshGuildDataStatus(v)
end
end
end
end

function subActivityInfo_xianmenghongbao:addReceiverData(actorId,guidHBData)
local hbGuid=guidHBData.un_id
local guildData=self:getGuildData(hbGuid)
if guildData then
self:refreshGuildData(guildData,guidHBData)
else
guildData=self:createServerGuildData(guidHBData)
local data=self:getData()
if data==nil then
data={}
self:setData(data)
end
if not data.guildLookup then
data.guildLookup={}
end
if not data.myList then
data.myList={}
end
data.guildLookup[guildData.key]=guildData
table.insert(data.guildList,guildData)
end

local reSort=false
if playerModel:checkActorId(actorId)then

reSort=true

self:addGotHbCountByHbLv(guildData.level)
notifySystem:postNotify(notifyConfig.onXMHBPlayerDataChange,self.act_id,self.sub_act_type,self.sub_act_id,guildData.id)
else
if guildData.getCnt>=guildData.getMax then
self:refreshGuildDataStatus(guildData)
self:markGuildSort()
reSort=true
end
end
notifySystem:postNotify(notifyConfig.onXMHBGuildDataChange,self.act_id,self.sub_act_type,self.sub_act_id,hbGuid,reSort)
end

return subActivityInfo_xianmenghongbao