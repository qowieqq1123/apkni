









local subActivityInfo_caishenjiadao={name='subActivityInfo_caishenjiadao'}

function subActivityInfo_caishenjiadao:onInit()
self._onNewDay=function(...)
self:onNewDay(...)
end
self._onNewDay5AM=function(...)
self:onNewDay5AM(...)
end
self._onHomeEvent=function(...)
self:onHomeEvent(...)
end
self._onXianMengChange=function(...)
self:onXianMengChange(...)
end







local config=self:getSubActConfig()
local startZero=timeHelper.getServerZeroStamp(self.start_time_l)
self.hbLimitTime=timeHelper.convertShortStamp(startZero)+config.end_day_idx*86400
for i,v in ipairs(config.hb_conf)do
if v.type==1 then
self.freeHBIndex=i
break
end
end
end

function subActivityInfo_caishenjiadao:onStart()
self:listenNotify(notifyConfig.onNewDay,self._onNewDay)
self:listenNotify(notifyConfig.onNewDay5am,self._onNewDay5AM)
self:listenNotify(notifyConfig.home_event,self._onHomeEvent)
self:listenNotify(notifyConfig.onXianMengChange,self._onXianMengChange)
end

function subActivityInfo_caishenjiadao:onDelete()
self:deleteEntity()
end

function subActivityInfo_caishenjiadao:checkReddot()
return false
end

function subActivityInfo_caishenjiadao:onXianMengChange(flag)
activitiesController:sendProtocol(actSendType.eComonReqInfo,self.act_id,self.sub_act_type,self.sub_act_id)
end

function subActivityInfo_caishenjiadao:onHomeEvent(etype)
if etype==homeEvent.eEnterHome then
self:createEntity()
elseif etype==homeEvent.eLeaveHome then
self:deleteEntity()
end
end

function subActivityInfo_caishenjiadao:onNewDay()
if not self:checkEntityTime()then
self:deleteEntity()
end

local flush=self:getSubActConfig("flush_caishen")
if flush==0 then
self:handleOverDay()
else
UIManager:invokeUIMethod("UIBuildingMsgWin","checkMsgSpeShow",8)
end
end

function subActivityInfo_caishenjiadao:onNewDay5AM()
local flush=self:getSubActConfig("flush_caishen")
if flush==5 then
self:handleOverDay()
end
end

function subActivityInfo_caishenjiadao:handleOverDay()
local playerList=self:getPlayerList()
if playerList then
for hbId,playerData in pairs(playerList)do
playerData.buyCnt=0
playerData.getCnt=0
playerData.share=false
end
end

local nowTime=timeHelper.getServerShortTime()
local guildList=self:getGuildList()
local guildLookup=self:getGuildLookup()
if guildList and guildLookup then
local removes={}
for index,guildData in ipairs(guildList)do
if guildData.endTime<=nowTime then
guildLookup[guildData.key]=nil
table.insert(removes,index)
if playerModel:checkActorId(guildData.dispatcher)then
table.removeValue(self.data.myList,guildData.key)
self:markMySort()
end
end
end
local cnt=#removes
if cnt>0 then
for i=cnt,1,-1 do
local index=removes[i]
table.remove(guildList,index)
end
end
end

self:refreshAllGuildData()
self:markGuildSort()
self:refreshHUD()
notifySystem:postNotify(notifyConfig.onCSJDPlayerDataChange,self.act_id,self.sub_act_type,self.sub_act_id)
notifySystem:postNotify(notifyConfig.onCSJDGuildDataChange,self.act_id,self.sub_act_type,self.sub_act_id,nil,true)
end

function subActivityInfo_caishenjiadao:markGuildSort()
local data=self:getData()
if data and data.guildSort==false then
data.guildSort=true
end
end

function subActivityInfo_caishenjiadao:markMySort()
local data=self:getData()
if data and data.mySort==false then
data.mySort=true
end
end

function subActivityInfo_caishenjiadao:checkGuildSort()
local data=self:getData()
if data and data.guildList and data.guildSort then
if#data.guildList>1 then
table.sort(data.guildList,function(a,b)
if a.status~=b.status then
return a.status<b.status
elseif a.money~=b.money then
return a.money>b.money
else
return a.time>b.time
end
end)
end
data.guildSort=false
end
end











function subActivityInfo_caishenjiadao:getEntityData()
local data=self:getData()
if data then
return data.entityData
end
end

function subActivityInfo_caishenjiadao:getPlayerList()
local data=self:getData()
if data then
return data.playerList
end
end

function subActivityInfo_caishenjiadao:getPlayerData(hbId)
local datas=self:getPlayerList()
if datas then
return datas[hbId]
end
end

function subActivityInfo_caishenjiadao:getGuildData(hbGuid)
local key=tostring(hbGuid)
return self:getGuildDataEx(key)
end

function subActivityInfo_caishenjiadao:getGuildDataEx(key)
local data=self:getData()
if data and data.guildLookup then
return data.guildLookup[key]
end
end

function subActivityInfo_caishenjiadao:getGuildList()
local data=self:getData()
if data and data.guildList then
return data.guildList
end
end

function subActivityInfo_caishenjiadao:getGuildLookup()
local data=self:getData()
if data and data.guildLookup then
return data.guildLookup
end
end

function subActivityInfo_caishenjiadao:getMyList()
local data=self:getData()
if data and data.myList then
return data.myList
end
end

function subActivityInfo_caishenjiadao:checkMySort()
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







function subActivityInfo_caishenjiadao:initAllData(playerList,guildList)
local hb_conf=self:getSubActConfig("hb_conf")
local data=self:getData()
if data==nil then
data={}
self:setData(data)
end

data.playerList={}
for i,v in ipairs(playerList)do
local cfg=hb_conf[v.param_1]
data.playerList[v.param_1]={
id=v.param_1,
buyCnt=v.param_2,
buyMax=cfg.send_cnt,
share=v.param_3==0,
getCnt=v.param_4,
getMax=cfg.type==1 and cfg.max_get_cnt or 0,
}
end
for i,v in ipairs(hb_conf)do
if not data.playerList[i]then
data.playerList[i]={
id=i,
buyCnt=0,
buyMax=v.send_cnt,
share=false,
getCnt=0,
getMax=v.type==1 and v.max_get_cnt or 0,
}
end
end

data.guildList={}
data.guildLookup={}
data.myList={}
data.guildSort=true
data.mySort=true
for i,v in ipairs(guildList)do
local v=guildList[i]
local guildData=self:createServerGuildData(v)
data.guildLookup[guildData.key]=guildData
table.insert(data.guildList,guildData)
if playerModel:checkActorId(guildData.dispatcher)then
table.insert(data.myList,guildData.key)
end
end

notifySystem:postNotify(notifyConfig.onCSJDPlayerDataChange,self.act_id,self.sub_act_type,self.sub_act_id)
notifySystem:postNotify(notifyConfig.onCSJDGuildDataChange,self.act_id,self.sub_act_type,self.sub_act_id,nil,true)

self:createEntity()
end

function subActivityInfo_caishenjiadao:addGuildData(hbInfo)
local data=self:getData()
if data and data.guildList and data.guildLookup then
local guildData=self:createServerGuildData(hbInfo)
data.guildLookup[guildData.key]=guildData
table.insert(data.guildList,guildData)
data.guildSort=true

local playerData=self:getPlayerData(guildData.id)
local playerChange=false
local key=tostring(playerModel:getActorID())





local reSort=false
if playerModel:checkActorId(guildData.dispatcher)then
playerData.share=true
table.insert(data.myList,guildData.key)
data.mySort=true
reSort=true
playerChange=true
UIManager.info("已分享红包至仙盟频道")
self:refreshHUD()
elseif guildData.receiverLookup[key]then
playerData.getCnt=playerData.getCnt+1
playerChange=true
end
if playerChange then
notifySystem:postNotify(notifyConfig.onCSJDPlayerDataChange,self.act_id,self.sub_act_type,self.sub_act_id,guildData.id)
end
notifySystem:postNotify(notifyConfig.onCSJDGuildDataChange,self.act_id,self.sub_act_type,self.sub_act_id,guildData.guid,reSort)
end
end

function subActivityInfo_caishenjiadao:countGuildDataStatus(status)
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

function subActivityInfo_caishenjiadao:createServerGuildData(hbInfo)
local cfg=self:getSubActConfig("hb_conf",hbInfo.hb_id)
local list={}
local lookup={}
for j,w in ipairs(hbInfo.acceptList or{})do
local key=tostring(w.param_1)
lookup[key]={actor=w.param_1,reward=w.param_2,key=key}
table.insert(list,key)
end

local money=-1
if cfg.type==2 and cfg.recharge_id~=nil then
local rechargeCfg=cfgHelper.get1(cfg_rechargeconfig_get,cfg.recharge_id)
local rechargeAmount=payControl:getRechargeAmountByCfg(rechargeCfg)
money=rechargeAmount
end

local longStamp=timeHelper.convertLongStamp(hbInfo.send_times)
local zeroStamp=timeHelper.getServerZeroStamp(longStamp)
local zeroTime=timeHelper.convertShortStamp(zeroStamp)
local endTime=zeroTime+cfg.max_exist_time

local data={
key=tostring(hbInfo.un_id),
guid=hbInfo.un_id,
id=hbInfo.hb_id,
dispatcher=hbInfo.actor_id,
getCnt=hbInfo.cnt,
getMax=cfg.cnt,
time=hbInfo.send_times,
endTime=endTime,
bless=hbInfo.blessing_idx,
receiverList=list,
receiverLookup=lookup,
money=money,
status=nil,
}

self:refreshGuildDataStatus(data)
return data
end

function subActivityInfo_caishenjiadao:getGuildDataStatus(guildData)
local playerId=playerModel:getActorID()
local key=tostring(playerId)
local playerData=self:getPlayerData(guildData.id)
if guildData.receiverLookup[key]then
return eCSJDRedPacketStatus.eGetted
elseif guildData.getCnt>=guildData.getMax then
return eCSJDRedPacketStatus.eNotLeast
elseif playerData.getCnt>=playerData.getMax then
return eCSJDRedPacketStatus.eNotTimes
else
return eCSJDRedPacketStatus.eNormal
end
end

function subActivityInfo_caishenjiadao:refreshGuildDataStatus(guildData)
if guildData.status and not eCSJDRedPacketStatusCanChange[guildData.status]then
return
end
guildData.status=self:getGuildDataStatus(guildData)
end

function subActivityInfo_caishenjiadao:refreshAllGuildData(hbId)
local guildList=self:getGuildList()
if guildList then
for i,v in ipairs(guildList)do
if hbId==nil or v.id==hbId then
self:refreshGuildDataStatus(v)
end
end
end
end

function subActivityInfo_caishenjiadao:addReceiverData(hbGuid,actorId,rewardIdx)
local guildData=self:getGuildData(hbGuid)
if guildData then
local key=tostring(actorId)
guildData.receiverLookup[key]={actor=actorId,reward=rewardIdx,key=key}
table.insert(guildData.receiverList,key)
guildData.getCnt=guildData.getCnt+1


local playerData=self:getPlayerData(guildData.id)
if playerModel:checkActorId(actorId)and not playerModel:checkActorId(guildData.dispatcher)then
playerData.getCnt=playerData.getCnt+1
notifySystem:postNotify(notifyConfig.onCSJDPlayerDataChange,self.act_id,self.sub_act_type,self.sub_act_id,guildData.id)

if playerData.getCnt>=playerData.getMax then
self:refreshAllGuildData(guildData.id)
else
self:refreshGuildDataStatus(guildData)
end
self:markGuildSort()
notifySystem:postNotify(notifyConfig.onCSJDGuildDataChange,self.act_id,self.sub_act_type,self.sub_act_id,hbGuid,true)
return
end

local reSort=false
if guildData.getCnt>=guildData.getMax then
self:refreshGuildDataStatus(guildData)
self:markGuildSort()
reSort=true
end
notifySystem:postNotify(notifyConfig.onCSJDGuildDataChange,self.act_id,self.sub_act_type,self.sub_act_id,hbGuid,reSort)
end
end

function subActivityInfo_caishenjiadao:addPlayerBuy(hbId)
local playerData=self:getPlayerData(hbId)
if playerData then
playerData.buyCnt=playerData.buyCnt+1
playerData.share=false
self:refreshHUD()
notifySystem:postNotify(notifyConfig.onCSJDPlayerDataChange,self.act_id,self.sub_act_type,self.sub_act_id,hbId)
end
end

function subActivityInfo_caishenjiadao:randomPos()
local temp=self:getSubActConfig("posLib")
local list={}
for i,v in ipairs(temp)do
local cell=_MapManager.ToVector3Int(v[1],v[2],0)
local area=_MapManager.GetAreaID(mapIdType.zhufeng,cell)
if _MapManager.IsAreaUnlock(mapIdType.zhufeng,area)then
table.insert(list,cell)
end
end
return list[math.random(1,#list)]
end

function subActivityInfo_caishenjiadao:createEntity()
if self:checkDoing()and self:checkOpen()and mainControl:isSceneType(eSceneType.eZongmen)and isometricMapSystem:IsInHome()and self:checkEntityTime()then
local entityData=self:getEntityData()
if entityData==nil then
local modelCfg=self:getSubActConfig("model")
local body=modelCfg[1]
local slots=modelCfg[2]
local scale=modelCfg[3]
local pos=self:randomPos()
local guid=isometricMapSystem:createRoleEntity(objectType.eCaiShenJiaDao,mapIdType.zhufeng,0,body,slots,SortingLayers.ITBuilding,scale,pos)
local bt=behaviorManager:addBehaviorTree('ai_zmvistor_range_move',{stId=guid},true,{})
local offset=_MapManager.GetObjectHeadOffset(guid)
local hud=hudControl:addHUD(INSTANCE_TYPE.eDiscipleState,guid,offset,true,true,function(id)
local widget=hudControl:getHUDWidget(id)
widget:SetChildCSImageSprite(0,globalABLookup.hud_atlas,'icon_fangshigx')
widget:SetChildButtonClick(1,function()
self:onClickEntity()
end)
widget:SetChildActive(1,self:checkBuyCount())
end)
self.data.entityData={guid=guid,hud=hud,bt=bt}
end
end
end

function subActivityInfo_caishenjiadao:deleteEntity()
local entityData=self:getEntityData()
if entityData then
if entityData.bt then
behaviorManager:removeBehaviorTree(entityData.bt)
end
if entityData.hud then
hudControl:removeHUD(entityData.hud)
end
_MapManager.RemoveTilemapObject(entityData.guid)
self.data.entityData=nil
end
end

function subActivityInfo_caishenjiadao:refreshHUD()
local entityData=self:getEntityData()
if entityData and entityData.hud then
local widget=hudControl:getHUDWidget(entityData.hud)
widget:SetChildActive(1,self:checkBuyCount())
end
end

function subActivityInfo_caishenjiadao:checkEntityTime()
local nowTime=timeHelper.getServerShortTime()
return self.hbLimitTime>nowTime
end

function subActivityInfo_caishenjiadao:onClickEntity()
UIManager:showWindow("UICaiShenJiaDaoRedPacketShareWin",{info=self})
end

function subActivityInfo_caishenjiadao:checkBuyCount()
local playerData=self:getPlayerData(self.freeHBIndex)
if playerData then
return playerData.buyCnt<playerData.buyMax or not playerData.share
end
return false
end

return subActivityInfo_caishenjiadao