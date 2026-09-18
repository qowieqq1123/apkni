
emergenciesControl=gameState.addListener({})

local notTriggerWinList={
"UIPlayerChangeImageWin"
}

function emergenciesControl:onAppStart()
socketManager:register_receiver(8,4,self.recv_8_4)
socketManager:register_receiver(8,5,self.recv_8_5)
socketManager:register_receiver(8,6,self.recv_8_6)
socketManager:register_receiver(8,7,self.recv_8_7)
socketManager:register_receiver(8,10,self.recv_8_10)
socketManager:register_receiver(8,11,self.recv_8_11)
socketManager:register_receiver(8,12,self.recv_8_12)
socketManager:register_receiver(8,13,self.recv_8_13)
socketManager:register_receiver(8,14,self.recv_8_14)
socketManager:register_receiver(8,15,self.recv_8_15)
socketManager:register_receiver(8,16,self.recv_8_16)
end

function emergenciesControl:onEnterState(isReconnect)
if isReconnect then
return
end
emergenciesModel:onEnterState()

self.updateEvent=false
self.triggerTime=nil
self.onlineTriggerMinTime=cfgHelper.get2(cfg_tufaeventbasicconfig_get,1,'onlineTriggerMinTime')or 0

notifySystem:listenNotify(notifyConfig.home_event,self.on_home_event)
notifySystem:listenNotify(notifyConfig.building_event,self.on_building_event)
notifySystem:listenNotify(notifyConfig.on_system_open,self.on_system_open)
end

function emergenciesControl:onLeaveState(isReconnect)
if isReconnect then
return
end
self.isInit=nil
emergenciesModel:onLeaveState()

self.settlementData=nil
self.triggerTime=nil
self.onlineTriggerMinTime=nil

notifySystem:removelistener(notifyConfig.home_event,self.on_home_event)
notifySystem:removelistener(notifyConfig.building_event,self.on_building_event)
notifySystem:removelistener(notifyConfig.on_system_open,self.on_system_open)
end

function emergenciesControl.on_home_event(etype)
if etype==homeEvent.eEnterHome then
emergenciesControl:onEnterHome()
elseif etype==homeEvent.eLeaveHome then
emergenciesControl:onLeaveHome()
end
end

function emergenciesControl.on_building_event(etype,sfId,ubdId,args1,args2)
if systemModel.isOpen(SYSTEM_DEFINE.eTuFaEvent)then
if etype==buildingEvent.buildComplete or etype==buildingEvent.levelUpComplete then
emergenciesControl:onBuildComplete_YiMuCongSheng(ubdId)
elseif etype==buildingEvent.storageBuilding then
emergenciesControl:onBuildRemove_YiMuCongSheng(ubdId)
end
end
end

function emergenciesControl.on_system_open(sysId)
if sysId==SYSTEM_DEFINE.eTuFaEvent then

emergenciesControl:setNextReqTime()
end
end

function emergenciesControl:getSettlementData()
return self.settlementData
end

function emergenciesControl:onEnterHome()

self.isInHome=true

if self.needSetEvent then
self:refreshEvent()
self.needSetEvent=false
end
timeEventController.addNormalTimerHandler(1,'emergenciesControl',self)
end

function emergenciesControl:onLeaveHome()
self:endEvent(nil,nil,true)
self.isInHome=false
timeEventController.removeNormalTimerHandler(1,'emergenciesControl')
end

function emergenciesControl:setNextReqTime()
if not systemModel.isOpen(SYSTEM_DEFINE.eTuFaEvent)then
return
end

local btime=emergenciesModel:getActTriggerTime()

if not btime or btime<=0 then

btime=emergenciesModel:getTriggerTime()
end
if btime then
local ttime=cfgHelper.get2(cfg_tufaeventbasicconfig_get,1,'trriger_time')
self.triggerTime=btime+ttime
end
end

function emergenciesControl:onNormalUpdate(delay)
if reconnectState:isDisConnectOrReconnect()then
return
end
if self.onlineTriggerMinTime and self.triggerTime and not emergenciesModel:isInEventTime()then
if mainControl:isSceneType(eSceneType.eZongmen)and zongmenControl:isMountid(mapIdType.zhufeng)and mainViewsControl.isOpen()then

local currTime=timeHelper.getServerShortTime()
local loginTime=timeHelper.getLoginPassTime()
if currTime>=self.triggerTime and loginTime>=self.onlineTriggerMinTime then

local isShowMsgWin=msgWinControl:checkMsgWinIsShow({msgWinType.eTopEventWin})
if not isShowMsgWin and not self:checkHasNotTriggerWinActive()then

self:reqTriggerEvent()


self.triggerTime=currTime+600
end
end
end
end
if self.updateEvent then
local currTime=timeHelper.getServerShortTime()
local dt=self.endTime-currTime
if dt>=0 then
UIManager:invokeUIMethod('UIMain','setEventTime',dt)
else
self.updateEvent=false
UIManager:invokeUIMethod('UIMain','showEmergenciesPanel')
self:reqSettlement()
end
local eventType=emergenciesModel:getCurrentEventType()
if eventType==emergenciesType.eBuildingOnFire then
self:updateOnFire(currTime)
end
emergenciesControl:checkDZAI()

if mainControl:isSceneType(eSceneType.eZongmen)and zongmenControl:isMountid(mapIdType.zhufeng)and mainViewsControl.isOpen()then
local isShowMsgWin=msgWinControl:checkMsgWinIsShow({msgWinType.eTopEventWin})
local autoCaoLingGuildOrder=guildOrderModel:isOrderSetupOpenEx(GUILD_ORDER_TYPE.eAutoCaoLing)
if autoCaoLingGuildOrder or(not isShowMsgWin and not self:checkHasNotTriggerWinActive())then
if self.needCreateCaoLingIdxList and next(self.needCreateCaoLingIdxList)then

for i,idx in ipairs(self.needCreateCaoLingIdxList)do
emergenciesControl:createCaoLing(idx)
end
self.needCreateCaoLingIdxList=nil
emergenciesControl:showCaoLingTips()
end
end
end
end
if self.updatePost then
self:updateRuiShouStay()
end
end


function emergenciesControl:checkHasNotTriggerWinActive()
for i,winName in ipairs(notTriggerWinList)do
if UIManager:isActive(winName)then
return true
end
end
return false
end

function emergenciesControl:updateOnFire(currTime)
if currTime-self.lastSpreadTime>=self.spreadTime then
self.lastSpreadTime=currTime
local num=self:getEventCount()
if num>=self.maxSpreadNum then
return
end

if isometricMapSystem:getDesignMode()then
return
end

local reqList={}
local bdCfgList=emergenciesModel:getOnFireBDCfgList()
for k,v in pairs(self.fireData)do
if v.isOnFile then
local ndatas=_MapManager.GetNearbyPlaceObject(k,objectType.ePlaceObject,self.spreadRange)
for i=1,#ndatas,2 do
local cid=ndatas[i+1]
if bdCfgList[cid]then
local eid=ndatas[i]
local data=self.fireData[eid]
if not reqList[eid]then
if data then
if not data.isOnFile and(currTime-data.extinguishingTime>self.onFireCD)then
reqList[eid]=data.ubdId
break
end
else
reqList[eid]=0
break
end
end
end
end
end
end
local sfId=zongmenModel:getMountainId()
for k,v in pairs(reqList)do
if v>0 then
self:reqBuildingOnFire(sfId,v,1)
else
local bdData=zongmenModel:findBuildingByEntityId(k)
if bdData then
self:reqBuildingOnFire(sfId,bdData.un_build_id,1)
end
end
end
end
end

function emergenciesControl:playAllRepair()
local datas=emergenciesModel:getRepairData()
for k,v in pairs(datas)do
local bdData=zongmenModel:getBuildingData(k)
self:startRepair(bdData)
end
end

function emergenciesControl:refreshEvent()
if not self.isInHome then
return
end
if emergenciesModel:hasHandleData()then
emergenciesModel:setEventHandData()
self:playAllRepair()
self:showEventHandleHUD()
self:playAllCreeper()
self:startRuiShouStay()

end

self.updateEvent=emergenciesModel:isInEventTime()
if not self.updateEvent then
return
end

if emergenciesModel:isNewEvent()then

msgWinControl:addMsgWin(msgWinType.eEmergenciesWraning,emergenciesModel:getCurrentEventId())
emergenciesModel:setNewFlag(false)


local eventType=emergenciesModel:getCurrentEventType()
local eventId=emergenciesModel:getCurrentEventId()
notifySystem:postNotify(notifyConfig.onEmergenciesStart,eventType,eventId)
end

self.endTime=emergenciesModel:getEndTime()
UIManager:invokeUIMethod('UIMain','showEmergenciesPanel')

self:clear()


local eventData=emergenciesModel:getEventData()
local eventType=emergenciesModel:getCurrentEventType()
if eventType==emergenciesType.eBuildingOnFire then
self.fireData={}
for i,v in ipairs(eventData)do
local mapId=v.param_2
local ubdId=v.param_3
local bdData=zongmenModel:getBuildingData(ubdId)
if bdData then
local isOnFile=v.param_1==0
if isOnFile then

local mdata=isometricMapSystem:getModelByData(bdData)
local effectScale=1/mdata.scale
buildingEffectControl:playEffectByEID(bdData.entityId,bdData.build_id,buildEffectType.eFire,nil,nil,effectScale)


end
self.fireData[bdData.entityId]={isOnFile=isOnFile,ubdId=ubdId,extinguishingTime=0}
hudControl:refreshBuildingStatusHUD(ubdId)
end
end
local cfg=emergenciesModel:getEmergenciesConfig(emergenciesType.eBuildingOnFire)
local olcfg=cfg.event_conf.onlinecfg
local timeScale=1

if webGLHelper:isWebGLOptimization()then
timeScale=2
end
self.spreadRange=olcfg[1]
self.spreadTime=olcfg[2]*timeScale
self.onFireCD=olcfg[3]*timeScale
self.maxSpreadNum=olcfg[4]
self.lastSpreadTime=timeHelper.getServerShortTime()
elseif eventType==emergenciesType.eMonsterInvasion then
self.monsterData={}
self.maxMonsterCount=0
self.surviveMonsterCount=0
for i,v in ipairs(eventData)do
local isdead=v.param_1==1
local mId=v.param_2
if not isdead then


local x=v.param_3
local y=v.param_4
local mcfg=cfgHelper.get1(cfg_monstergroup_get,mId)

local areaId,pos=sundriseCreateControl:getAPosCanPlace(mapIdType.zhufeng)
local model=mcfg.model[1]
local scale=isometricMapSystem:getModelScale(model)
local entityId=isometricMapSystem:createRoleEntity(objectType.eMonster,mapIdType.zhufeng,0,model,nil,SortingLayers.ITBuilding,scale,pos)
_MapManager.ShowShadow(entityId,true)
local bt
local hudId=hudControl:addHUD(INSTANCE_TYPE.eBattleStatusEM,entityId,Vector3(0,0.8,0),false,true,function(id)
local bw=hudControl:getHUDWidget(id)
bw:SetChildButtonClick(1,function()
if isometricMapSystem:checkMonsterAIRecord(entityId)then
UIManager.error("宗门弟子正在前往降妖，请祖师稍等片刻")
else
UIManager:showWindow('UIEmergenciesMonsterWin',{mId,entityId})
end
end)
end)
local posArr=_MapManager.Vector3IntToArray(pos)
self.monsterData[entityId]={mId=mId,stId=entityId,bt=bt,hudId=hudId,x=posArr[1],y=posArr[2]}
self.surviveMonsterCount=self.surviveMonsterCount+1
end
self.maxMonsterCount=self.maxMonsterCount+1
end
elseif eventType==emergenciesType.eJiQuanBuNing then
elseif eventType==emergenciesType.eYiMuCongSheng then
self:refreshEvent_YiMuCongSheng(eventData)
elseif eventType==emergenciesType.eYouHunRaoLuan then
self:refreshEvent_YouHunRaoLuan()
elseif eventType==emergenciesType.eRuiShouLinMen then
self:refreshEvent_RuiShouLinMen(eventData)
elseif eventType==emergenciesType.eYiShiLaiKe then
self:refreshEvent_YiShiLaiKe()
elseif eventType==emergenciesType.eSystemZongMenSpy then
self:refreshEvent_SystemZongMenSpy()
end

UIManager:invokeUIMethod('UIMain','setEventName')
end

function emergenciesControl:setMonsterNesPos(entityId,x,y)
if self.monsterData and self.monsterData[entityId]then
self.monsterData[entityId].x=x
self.monsterData[entityId].y=y
end
end

function emergenciesControl:refreshMonsterListPos(entList)
if not self.isInHome then
return
end
for i,entityId in ipairs(entList)do
emergenciesControl:refreshMonsterPos(entityId)
end
end

function emergenciesControl:refreshMonsterPos(entityId)
if(not self.isInHome)or(not self.monsterData)then
return
end
local handle=self.monsterData[entityId]
if handle then
_MapManager.SetPosition(entityId,_MapManager.ToVector3Int(handle.x,handle.y,0))
hudControl:refreshHUDPosition(handle.hudId)
end
end

function emergenciesControl:clear(result,isLeaveHome)
if self.fireData then
local fireData=self.fireData
self.fireData=nil

for k,v in pairs(fireData)do
local bdData=zongmenModel:getBuildingData(v.ubdId)
if bdData then

buildingEffectControl:stopEffect(bdData.entityId,buildEffectType.eFire)



self:startRepair(bdData)
end
end
self.spreadRange=nil
self.spreadTime=nil
self.onFireCD=nil
self.maxSpreadNum=nil
end
if self.monsterData then
for k,v in pairs(self.monsterData)do
self:removeMonster(v)
end
self.monsterData=nil
self.maxMonsterCount=nil
self.surviveMonsterCount=nil
end
self:clear_YiMuCongSheng(result,isLeaveHome)
self:clear_YouHunRaoLuan()
self:clear_RuiShouLinMen(result,isLeaveHome)
self:clear_YiShiLaiKe()
self:clear_SystemZongMenSpy(result,isLeaveHome)

jctjDuJieXianDanController:playAllRepair()
end

function emergenciesControl:startRepair(bdData)
if emergenciesModel:isInRepairTime(bdData.un_build_id)then
buildingCDControl:addCDData(buildingCDType.xiufu,bdData)
_MapManager.SetFadeToColor(bdData.entityId,Color.New(0.65,0.65,0.65,1),1,nil)
local mdata=isometricMapSystem:getModelByData(bdData)
local effectScale=1/mdata.scale
buildingEffectControl:playEffectByEID(bdData.entityId,bdData.build_id,buildEffectType.eMaoYan,nil,nil,effectScale)
end
hudControl:refreshBuildingStatusHUD(bdData.un_build_id)
end

function emergenciesControl:endRepair(bdData)
hudControl:refreshBuildingStatusHUD(bdData.un_build_id)
buildingCDControl:removeCDData(buildingCDType.xiufu,bdData.un_build_id)
if not jctjDuJieXianDanModel:isInRepairTime(bdData.un_build_id)then
local check=UIDanYaoModel:checkZhaLu(bdData.un_build_id,DANYAO_ZHALU_SEASON.eDiscipleSpecial)
if not check then
_MapManager.SetFadeToColor(bdData.entityId,Color.New(1,1,1,1),1,nil)
buildingEffectControl:stopEffect(bdData.entityId,buildEffectType.eMaoYan)
end
end
end

function emergenciesControl:endEvent(result,eventId,isLeaveHome)

local eventType=emergenciesModel:getCurrentEventType()
notifySystem:postNotify(notifyConfig.onEmergenciesEnd,eventType,eventId,result)

self.updateEvent=false
self:clear(result,isLeaveHome)
end

function emergenciesControl:isBuildingOnFire(entityId)
if self.fireData then
local data=self.fireData[entityId]
return data and data.isOnFile
end
return false
end

function emergenciesControl:getFireData()
return self.fireData
end

function emergenciesControl:setOnFire(sfId,ubdId,rtype)
local bdData=zongmenModel:getBuildingData(ubdId)
local mdata=isometricMapSystem:getModelByData(bdData)
local effectScale=1/mdata.scale
if rtype==1 then
local data=self.fireData[bdData.entityId]or{}
data.isOnFile=true
data.ubdId=ubdId
data.extinguishingTime=0

buildingEffectControl:playEffectByEID(bdData.entityId,bdData.build_id,buildEffectType.eFire,nil,nil,effectScale)




self.fireData[bdData.entityId]=data
else
local data=self.fireData[bdData.entityId]
if data then
data.isOnFile=false
data.extinguishing=false
data.exDZId=nil
data.extinguishingTime=timeHelper.getServerShortTime()

buildingEffectControl:stopEffect(bdData.entityId,buildEffectType.eFire,nil,nil,effectScale)



end
end
hudControl:refreshBuildingStatusHUD(ubdId)
end

function emergenciesControl:updateEntityId(ubdId,oldEntityId)
if self.fireData then
local data=self.fireData[oldEntityId]
if data then
if data.isOnFile then
emergenciesControl:setOnFire(nil,ubdId,1)
else
emergenciesControl:setOnFire(nil,ubdId)
end
self.fireData[oldEntityId]=nil
end
end
end

function emergenciesControl:getEventCount()
local eventType=emergenciesModel:getCurrentEventType()
local curr=0
local max=0
if eventType==emergenciesType.eBuildingOnFire then
if self.fireData then
for k,v in pairs(self.fireData)do
if v.isOnFile then
curr=curr+1
end
max=max+1
end
end
elseif eventType==emergenciesType.eMonsterInvasion then
curr=self.surviveMonsterCount
max=self.maxMonsterCount
elseif eventType==emergenciesType.eYiMuCongSheng then
curr,max=self:getEventCount_YiMuCongSheng()
elseif eventType==emergenciesType.eYouHunRaoLuan then
curr,max=self:getEventCount_YouHunRaoLuan()
elseif eventType==emergenciesType.eRuiShouLinMen then
curr,max=self:getEventCount_RuiShouLinMen()
elseif eventType==emergenciesType.eYiShiLaiKe then
curr,max=self:getEventCount_YiShiLaiKe()
elseif eventType==emergenciesType.eSystemZongMenSpy then
curr,max=self:getEventCount_SystemZongMenSpy()
end
return curr,max
end

function emergenciesControl:moveCameraToEventPos()
local eventType=emergenciesModel:getCurrentEventType()
if eventType==emergenciesType.eBuildingOnFire then
for k,v in pairs(self.fireData)do
if v.isOnFile then
isometricMapSystem:moveCameraToObjectEx(k,true)
break
end
end
elseif eventType==emergenciesType.eMonsterInvasion then
local key,data=next(self.monsterData)
if data then
isometricMapSystem:moveCameraToObjectEx(data.stId,true)
end
elseif eventType==emergenciesType.eYiMuCongSheng then
self:moveCameraToEventPos_YiMuCongSheng()
elseif eventType==emergenciesType.eYouHunRaoLuan then
self:onClickEventWin_YouHunRaoLuan()
elseif eventType==emergenciesType.eRuiShouLinMen then
self:moveCameraToEventPos_RuiShouLinMen()
elseif eventType==emergenciesType.eYiShiLaiKe then
self:moveCameraToEventPos_YiShiLaiKe()
elseif eventType==emergenciesType.eSystemZongMenSpy then
self:onClickEventWin_SystemZongMenSpy()
end
end

function emergenciesControl:extinguishing(ubdId)
local sfId=zongmenModel:getMountainId()
self:reqBuildingOnFire(sfId,ubdId,0)
end

function emergenciesControl:checkIsExtinguishing(bdData)
local data=self.fireData[bdData.entityId]
if data.extinguishing then
return true
end
return false
end

function emergenciesControl:toExtinguishing(bdData)
local data=self.fireData[bdData.entityId]
if data.extinguishing then
UIManager.info('弟子正火速前来')
return false
end
local mapId=_MapManager.GetObjectMapID(bdData.entityId)
local pos=_MapManager.GetTilemapObjectPosition(bdData.entityId)
local dzId=aiManager:getNearbyDisciple(mapId,pos,eAIDZType.eDefault)

local cfg=cfgHelper.get1(cfg_miehuoaiconfig_get,1)
if dzId then
local cmdData={
type=eAIType.eMieHuo,
initData={
entityId=bdData.entityId,
exargs={bdData.un_build_id},
sound=cfg.sound,
effect=cfg.effect,
mapId=mapId,
},
restorePreviousAI=true,
}
aiManager:addCommandToDisciple(dzId,cmdData)
data.extinguishing=true
data.exDZId=dzId
return true
else
UIManager.error('暂无空闲弟子')
end
return false
end

function emergenciesControl:checkDZAI()
if not self.fireData then
return
end
for k,v in pairs(self.fireData)do
local dzId=v.exDZId
if dzId then
local replace=false
local bt=aiManager:getDiscipleCurrentCMDBT(dzId)
if bt then
local cmdType=bt:getSharedVar('cmdType')
if cmdType~=eAIType.eMieHuo then
replace=true
end
else
replace=true
end
if replace then
local bdData=zongmenModel:getBuildingData(v.ubdId)
v.extinguishing=false
v.exDZId=nil
self:toExtinguishing(bdData)
logWarn('灭火弟子未在工作，切换弟子执行')
end
end
end
end

function emergenciesControl:getExtinguishingSpeakText(bt,tkey,stype)
local cfg=cfgHelper.get1(cfg_miehuoaiconfig_get,1)
local speaks=cfg[string.format('speak%d',stype)]
local txt=speaks[math.random(1,#speaks)]
bt:setSharedVar(tkey,txt)
end

function emergenciesControl:showSettlement(data)
if not data then
return
end
if mainControl:isSceneLoaded(eSceneType.eZongmen)then

UIManager:invokeUIMethod('UIMain','showEmergenciesPanel')
local eventCfg=cfgHelper.get1(cfg_tufaeventtypeconfig_get,data[1])
if eventCfg.event_type~=emergenciesType.eRuiShouLinMen then




msgWinControl:addMsgWin(msgWinType.eEmergenciesSettlement,data)
else
if data[2]==0 then
local boxes=emergenciesModel:copyRSLMBoxes()
data[6]=function(event)
emergenciesModel:showRSLMBoxesEffect(event,boxes)
local rs=emergenciesControl:getRuiShou()
if rs then
_MapManager.PlayEffect(rs.obj,20006,Vector3.zero,true,true)
local delay=timer.new()
delay:start(1,function()
self:changeRuiShouModel(event)
end,1)
end
end
msgWinControl:addMsgWin(msgWinType.eEmergenciesSettlement,data)
end
end
self.settlementData=nil
else
self.settlementData=data
end
end

function emergenciesControl:startMonsterFight(mId)

end

function emergenciesControl:removeMonster(data)

_MapManager.RemoveTilemapObject(data.stId)
hudControl:removeHUD(data.hudId)
end

function emergenciesControl:endMonsterFight(mId,result)
if self.monsterData and result==1 then
local data=self:getEventMonsterDataById(mId)
if data then
self:removeMonster(data)
self.monsterData[data.stId]=nil
self.surviveMonsterCount=self.surviveMonsterCount-1
end
end
UIManager:invokeUIMethod('UIMain','showEmergenciesPanel')
end

function emergenciesControl:getEventMonsterDataById(mId)
for k,v in pairs(self.monsterData)do
if v.mId==mId then
return v
end
end
return nil
end

function emergenciesControl:getEventMonsterData(entityId)
if not self.monsterData then
return
end
return self.monsterData[entityId]
end

function emergenciesControl:getEventMonsterDatas()
return self.monsterData
end

function emergenciesControl:showEventHandleHUD()
local currtime=gameUtilityModel.getServerShortTime()
local datas=emergenciesModel:getRepairData()
for k,v in pairs(datas)do
if currtime<v then
hudControl:refreshBuildingStatusHUD(k)
end
end
end

function emergenciesControl:showEventPageEffect(flag)
if flag then
local type=emergenciesModel:getCurrentEventType()
if type==emergenciesType.eYouHunRaoLuan then
UIManager:showWindow("UIEmergenciesPageEffect_ghost")
end
else

local win=UIManager:findActiveWindow('UIEmergenciesPageEffect_ghost')
if win then
win:fadeOutShowModel(true)
elseif UIManager:findLoadingWindow('UIEmergenciesPageEffect_ghost')then

UIManager:closeWindowWithLoading('UIEmergenciesPageEffect_ghost',true)
end

win=UIManager:findActiveWindow('UIEmergenciesPageEffect_ghostBg')
if win then
win:fadeOutShowModel(true)
elseif UIManager:findLoadingWindow('UIEmergenciesPageEffect_ghostBg')then

UIManager:closeWindowWithLoading('UIEmergenciesPageEffect_ghostBg',true)
end
end
end



function emergenciesControl:reqEmergenciesData()
socketManager:send_8_4()
end

function emergenciesControl:reqSettlement()
socketManager:send_8_5()
end

function emergenciesControl:reqBuildingOnFire(sfId,bdId,rtype)
socketManager:send_8_6(sfId,bdId,rtype)
end

function emergenciesControl:reqAppease(rtype)
socketManager:send_8_7(rtype)
end

function emergenciesControl:reqKillMonster(mId,len,dzList)
socketManager:send_8_8(mId,len,dzList)
end

function emergenciesControl:reqClickCaoLing(idx)
socketManager:send_8_10(idx)
end

function emergenciesControl:reqClickGhost(idx)
socketManager:send_8_12(idx)
end

function emergenciesControl:reqTriggerEvent()
socketManager:send_8_14()
end


function emergenciesControl:reqClickZongMenSpy(idx)
socketManager:send_8_16(idx)
end

function emergenciesControl:reqFeedRuiShou(costList)
local rs=self:getRuiShou()
if rs then
local position=_MapManager.GetTilemapObjectPosition(rs.obj)
local pos=_HexMapManager.Vector3IntToVector3(position)
socketManager:send_8_13(#costList,costList,pos.x,pos.y)
end
end


function emergenciesControl.recv_8_4(datas)
emergenciesModel:setEmergenciesData(datas)
emergenciesControl:setNextReqTime()
if emergenciesControl.isInHome then
emergenciesControl:refreshEvent()
emergenciesControl.needSetEvent=false
else
emergenciesControl.needSetEvent=true
end
emergenciesControl.isInit=true
end

function emergenciesControl.recv_8_5(eventId,result,buff,len,arr)
local data={eventId,result,buff,len,arr}
emergenciesModel:setEventFinish()
emergenciesControl:showSettlement(data)
emergenciesControl:endEvent(result,eventId)
end

function emergenciesControl.recv_8_6(sfId,ubdId,rtype)
emergenciesControl:setOnFire(sfId,ubdId,rtype)
UIManager:invokeUIMethod('UIMain','setEventName')
end

function emergenciesControl.recv_8_7(rtype)

end





function emergenciesControl.recv_8_10(idx,len,roGuids)

if len>0 then
local clData=emergenciesControl:getCaoLing(idx)
if clData then
local center=_MapManager.GetTilemapObjectPosition(clData.obj)
local func=function(mapId,id,guid)
local pos=_MapManager.RandomANearbyPosition(mapId,center,5,10)
local area=_MapManager.GetAreaID(mapId,pos)
local _center=_MapManager.Vector3IntToArray(center)
local _pos=_MapManager.Vector3IntToArray(pos)
if _pos[1]==_center[1]and _pos[2]==_center[2]then
area,pos=sundriseCreateControl:getAPosCanPlace(mapId,id)
end
return area,pos
end
sundriseCreateControl:markSpecialRandom(roGuids,func)

end
end
UIManager:invokeUIMethod('UIMain','setEventName')
if mainControl:isSceneLoaded(eSceneType.eZongmen)then
if emergenciesModel:isDead_CaoLing(idx)then

emergenciesControl:deadCaoLing(idx)
else

emergenciesControl:escapeCaoLing(idx)
end
end
end

function emergenciesControl.recv_8_11(idx)
emergenciesModel:addCaoLingData(idx)
if mainControl:isSceneLoaded(eSceneType.eZongmen)then
if zongmenControl:isMountid(mapIdType.zhufeng)and mainViewsControl.isOpen()then
local autoCaoLingGuildOrder=guildOrderModel:isOrderSetupOpenEx(GUILD_ORDER_TYPE.eAutoCaoLing)
local isShowMsgWin=msgWinControl:checkMsgWinIsShow({msgWinType.eTopEventWin})
if autoCaoLingGuildOrder or(not isShowMsgWin and not emergenciesControl:checkHasNotTriggerWinActive())then
emergenciesControl:createCaoLing(idx)
emergenciesControl:showCaoLingTips()
end
else
emergenciesControl:waitCreateCaoLing(idx)
end
end
end


function emergenciesControl.recv_8_12(idx)
emergenciesModel:setGhostDead(idx)


UIManager:invokeUIMethod('UIMain','setEventName')
end

function emergenciesControl.recv_8_13(args)
local costlen=args[1]
local costList=args[2]
local x=args[3]
local y=args[4]
local feed=args[5]
local guidlen=args[6]
local guids=args[7]

local old=emergenciesModel:getFeedRS()
local config=emergenciesModel:getEmergenciesConfig()
local over=false
for i,v in ipairs(config.event_conf.stage)do
if v[1]>old and v[1]<=feed then
over=true
break
end
end

emergenciesModel:setCurrentFeedRS(feed)
if guidlen>0 then
local center=_MapManager.ToVector3Int(x,y,0)
local radius=emergenciesModel:getRadiusRS()or 5
local func=function(mapId,id,guid)
local pos=_MapManager.RandomANearbyPosition(mapId,center,radius,10)
local area=_MapManager.GetAreaID(mapId,pos)
local _center=_MapManager.Vector3IntToArray(center)
local _pos=_MapManager.Vector3IntToArray(pos)
if _pos[1]==_center[1]and _pos[2]==_center[2]then
area,pos=sundriseCreateControl:getAPosCanPlace(mapId,id)
end
return area,pos
end
sundriseCreateControl:markSpecialRandom(guids,func)
end

emergenciesModel:addRSLMBoxes(guids)
if over then

emergenciesControl:waitSundriseClose()
emergenciesControl:changeRuiShouModel(config.id)
else
UIManager:invokeUIMethod("UIRuiShouLinMenWin","refreshView")
end



UIManager:invokeUIMethod("UIRuiShouLinMenSelectWin","Feedrefresh")
UIManager.info('喂养成功')
end

function emergenciesControl.recv_8_14(result,actTriggerTime)

emergenciesModel:setActTriggerTime(actTriggerTime)

emergenciesControl:setNextReqTime()
end


function emergenciesControl.recv_8_15(npcId,event_guid,event_group_id)
emergenciesModel:setAdventureId(npcId,event_guid,event_group_id)





end

function emergenciesControl.recv_8_16(npcIndex)
emergenciesModel:ZongMenSpyEventDataChangeByIndex(npcIndex)
UIManager:invokeUIMethod('UIMain','setEventName')
end



function emergenciesControl:test_checkCanTriggerEvent()
if reconnectState:isDisConnectOrReconnect()then
return UIManager.info("未连接服务器")
end

if not self.onlineTriggerMinTime then
return UIManager.info("未初始化登录最小触发时间")
end

if not self.triggerTime then
return UIManager.info("未初始化触发时间")
end

if emergenciesModel:isInEventTime()then
return UIManager.info("当前正在事件中")
end

if not(mainControl:isSceneType(eSceneType.eZongmen)and zongmenControl:isMountid(mapIdType.zhufeng)and mainViewsControl.isOpen())then
return UIManager.info("未在宗门场景主界面中")
end

local currTime=timeHelper.getServerShortTime()
local loginTime=timeHelper.getLoginPassTime()
if currTime<self.triggerTime then
return UIManager.info("未到触发时间")
end

if loginTime<self.onlineTriggerMinTime then
return UIManager.info("未到登录最小触发时间")
end

local isShowMsgWin=msgWinControl:checkMsgWinIsShow({msgWinType.eTopEventWin})
if isShowMsgWin then
return UIManager.info("存在弹窗 无法触发")
end

if self:checkHasNotTriggerWinActive()then
return UIManager.info("存在冲突界面 无法触发")
end
end