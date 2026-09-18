zongmenControl=gameState.addListener({})

buildingEvent={
buildStart=0,
buildComplete=1,
levelUpStart=2,
levelUpComplete=3,
moveBuilding=4,
removeBuilding=5,
storageBuilding=6,
placeBuilding=7,
receiveNatural=8,
planStart=9,
planComplete=10,
replaceDisciple=11,
planCancel=12,
zongmenLevelUp=13,
speedUpComplete=14,
switchRoomFlag=15,
switchRoomDizi=16,
buildDataChange=17,
liandanStart=18,
liandanComplete=19,
liandanBreak=20,
planCollect=21,
planChange=22,
planStatusChange=23,
zhiFuStart=24,
zhiFuComplete=25,
zhiFuBreak=26,
shangpuComplete=27,
zwgPlaneStart=28,
zwgPlaneComplete=29,
}

buildingStateType={
eNode=0,
eBuilding=1,
eUpgrading=2,
}

buildingEffectType={
eProfBuild=1,
eAttrBuild=2,
eBuffBuild=3,
eFuncBuild=4,
eWareBuild=5,
eRandomBuild=6,
eRoomBuild=7,
}

speedUpMode={
eMoney=1,
eItem=2,
eAds=3,
eFree=4,
eItemBuilding=5,
eAskHelp=6,
eMoneyBuilding=7,
}

speedUpType={
eOpenMount=1,
eOpenArea=2,
eUpgradeBuilding=3,
eExecutePlant=4,
eZhenFaStudy=5,
eYunJiaYingTrain=6,
eYuLingZhai=7,
eJuTianYi=8,
eYanDaoTai=9,
}

discipleEffectType={
ePlant=1,
eMountain=2,
eArea=3,
eBuilding=4,
}

repairStatus={
eNotRepaired=0,
eUnderRepair=1,
eRepaired=2,
}

sharedBuildId={
[SLG_SYSTEM_TYPE.eWangShouTang]=true
}

autoFinishLvUpBuildId={
[SLG_SYSTEM_TYPE.eShanMen]=true,
[SLG_SYSTEM_TYPE.eYunJiaYing]=true,
}

local _effectScore={
-2,
-5,
8,
}

local isInit=false

local _refreshFreeManufactureBdReddotCdTime=3
local _planFinishUpdateData=nil

local _checkBdDzCanFireFunc={
[SLG_SYSTEM_TYPE.eShouLan1]=function(sfId,ubdId,okCallBack)

return UIShouLanControl:checkShouLanDzFire(sfId,ubdId,okCallBack)
end,
[SLG_SYSTEM_TYPE.eShouLan2]=function(sfId,ubdId,okCallBack)

return UIShouLanControl:checkShouLanDzFire(sfId,ubdId,okCallBack)
end,
[SLG_SYSTEM_TYPE.eYuShouFang]=function(sfId,ubdId,okCallBack)

return yushoufangModel:checkYSFShouLanDzFire(sfId,ubdId,okCallBack)
end,
}

function zongmenControl:onAppStart()
socketManager:register_receiver(3,1,self.recv_3_1)
socketManager:register_receiver(3,2,self.recv_3_2)
socketManager:register_receiver(3,3,self.recv_3_3)
socketManager:register_receiver(3,4,self.recv_3_4)
socketManager:register_receiver(3,5,self.recv_3_5)
socketManager:register_receiver(3,6,self.recv_3_6)
socketManager:register_receiver(3,7,self.recv_3_7)
socketManager:register_receiver(3,8,self.recv_3_8)
socketManager:register_receiver(3,9,self.recv_3_9)
socketManager:register_receiver(3,10,self.recv_3_10)
socketManager:register_receiver(3,12,self.recv_3_12)
socketManager:register_receiver(3,13,self.recv_3_13)

socketManager:register_receiver(3,18,self.recv_3_18)
socketManager:register_receiver(3,19,self.recv_3_19)
socketManager:register_receiver(3,21,self.recv_3_21)
socketManager:register_receiver(3,22,self.recv_3_22)
socketManager:register_receiver(3,23,self.recv_3_23)
socketManager:register_receiver(3,24,self.recv_3_24)
socketManager:register_receiver(3,31,self.recv_3_31)
socketManager:register_receiver(3,32,self.recv_3_32)
socketManager:register_receiver(3,33,self.recv_3_33)
socketManager:register_receiver(3,34,self.recv_3_34)
socketManager:register_receiver(3,35,self.recv_3_35)
socketManager:register_receiver(3,36,self.recv_3_36)
socketManager:register_receiver(3,37,self.recv_3_37)
socketManager:register_receiver(3,38,self.recv_3_38)
socketManager:register_receiver(3,39,self.recv_3_39)
socketManager:register_receiver(3,40,self.recv_3_40)
socketManager:register_receiver(3,41,self.recv_3_41)
socketManager:register_receiver(3,42,self.recv_3_42)
socketManager:register_receiver(3,43,self.recv_3_43)
socketManager:register_receiver(3,44,self.recv_3_44)
socketManager:register_receiver(3,45,self.recv_3_45)
socketManager:register_receiver(3,46,self.recv_3_46)
socketManager:register_receiver(3,47,self.recv_3_47)
socketManager:register_receiver(3,48,self.recv_3_48)
socketManager:register_receiver(3,49,self.recv_3_49)
socketManager:register_receiver(3,52,self.recv_3_52)
socketManager:register_receiver(3,53,self.recv_3_53)
socketManager:register_receiver(3,58,zongmenControl.recv_3_58)
socketManager:register_receiver(3,59,zongmenControl.recv_3_59)

socketManager:register_receiver(3,55,ims_design_layout.recv_3_55)
socketManager:register_receiver(3,60,ims_design_layout.recv_3_60)

socketManager:register_receiver(3,61,self.recv_3_61)
socketManager:register_receiver(3,62,self.recv_3_62)
socketManager:register_receiver(3,63,self.recv_3_63)
socketManager:register_receiver(3,64,self.recv_3_64)
socketManager:register_receiver(3,65,self.recv_3_65)
socketManager:register_receiver(3,66,self.recv_3_66)
socketManager:register_receiver(3,67,self.recv_3_67)
socketManager:register_receiver(3,68,self.recv_3_68)
socketManager:register_receiver(3,69,self.recv_3_69)

socketManager:register_receiver(3,75,self.recv_3_75)
socketManager:register_receiver(3,76,self.recv_3_76)
socketManager:register_receiver(3,77,self.recv_3_77)
socketManager:register_receiver(3,78,self.recv_3_78)
socketManager:register_receiver(3,79,self.recv_3_79)

socketManager:register_receiver(3,99,self.recv_3_99)

socketManager:register_receiver(3,111,self.recv_3_111)
socketManager:register_receiver(3,112,self.recv_3_112)
socketManager:register_receiver(3,113,self.recv_3_113)

socketManager:register_receiver(3,249,self.recv_3_249)
socketManager:register_receiver(3,250,self.recv_3_250)

socketManager:register_receiver(254,59,self.recv_254_59)

socketManager:register_receiver(6,185,self.recv_6_185)


notifySystem:listenNotify(notifyConfig.on_item_list_changed,self.onItemListChanged)
notifySystem:listenNotify(notifyConfig.on_money_changed,self.onMoneyChanged)
notifySystem:listenNotify(notifyConfig.building_event,self.on_building_event)
notifySystem:listenNotify(notifyConfig.onDiscipleStateChange,self.onDiscipleStateChange)
notifySystem:listenNotify(notifyConfig.onDiscipleLoyaltyChange,self.onDiscipleLoyaltyChange)
notifySystem:listenNotify(notifyConfig.onDiscipleInjuryChange,self.onDiscipleInjuryChange)
notifySystem:listenNotify(notifyConfig.onDiscipleShouYuanChange,self.onDiscipleShouYuanChange)

notifySystem:listenNotify(notifyConfig.on_system_open,ims_design_layout.on_system_open)

notifySystem:listenNotify(notifyConfig.onEnterHomeFinish,self.onEnterHomeFinish)
end

function zongmenControl:onEnterState(isReconnect)
if isReconnect then
return
end
sceneLightControl:init()
zongmenModel:onEnterState()
zongmenModel:setMountainId(1)
isInit=false


self.zongmenTipsFlags={}
self.speedUpTipsFlag={}






_planFinishUpdateData=nil
self.recordData={}
self.refreshFreeManufactureBdTime=nil

eventTextNotifyControl.register(EVENT_TYPE.eNomal,{EVENT_NORMAL_SUB_TYPE.eDiziProduct},self.onRecvProductMesg)

timeEventController.addNormalTimerHandler(1,"zongmenControl",self)
end

function zongmenControl:onLeaveState(isReconnect)
if isReconnect then
return
end
zongmenModel:onLeaveState()

self.speedUpTipsFlag=nil

self.checkMouse=nil

self.recordData=nil
self.refreshFreeManufactureBdTime=nil
zongmenControl:stopPlanFinishTimer()

eventTextNotifyControl.unregister(EVENT_TYPE.eNomal,{EVENT_NORMAL_SUB_TYPE.eDiziProduct},self.onRecvProductMesg)

timeEventController.removeNormalTimerHandler(1,"zongmenControl")
end

function zongmenControl:onProtocolReq()

end

function zongmenControl:onEnterHomeFinish()
local sfId=zongmenModel:getMountainId()
local lookup=zongmenModel:getAreaSearchRecord()
for areaId,v in pairs(lookup)do
hudControl:showAreaSearchToPos(sfId,areaId)
end
end

function zongmenControl.tickUpdate()
if _planFinishUpdateData==nil or#_planFinishUpdateData==0 then
zongmenControl:stopPlanFinishTimer()
return
end
local data=_remove(_planFinishUpdateData,1)
zongmenControl:showPlanFinish(data[1],data[2])
end

function zongmenControl:startPlanFinishTimer()
if self.planFinishTimer==nil then
self.planFinishTimer=FrameTimer.New(self.tickUpdate,2,-1)
self.planFinishTimer:Start()
end
end

function zongmenControl:stopPlanFinishTimer(leaveHome)
if self.planFinishTimer then
self.planFinishTimer:Stop()
self.planFinishTimer=nil
end

if leaveHome and _planFinishUpdateData then
for i,v in ipairs(_planFinishUpdateData)do
zongmenControl:showPlanFinishEx(v[1],v[2])
end
end

_planFinishUpdateData=nil
end

function zongmenControl:setRecordData(key,val)
self.recordData[key]=val
end

function zongmenControl:getRecordData(key)
return self.recordData[key]
end









function zongmenControl:getSpeedUpFlag(stype)
return self.speedUpTipsFlag[stype]
end

function zongmenControl:setSpeedUpFlag(stype,flag)
self.speedUpTipsFlag[stype]=flag
end

function zongmenControl.onRecvProductMesg(mesg,eventid,paramList,timeStamp)
zongmenModel:recordManufactureEvent(mesg,eventid,paramList,timeStamp)
end

function zongmenControl:checkInit()
return isInit==true
end

function zongmenControl:onNormalUpdate(delay)
if self.checkMouse then

if zongmenModel:getMouseLeastTime()<0 then
zongmenModel:addMouseCnt()
zongmenModel:setMouseLastTime(timeHelper.getServerShortTime())
if zongmenModel:isMaxMouse()then
zongmenControl.checkMouse=nil
end
end
end


isometricMapSystem:checkDZCollectAI()

local time=Time.realtimeSinceStartup
if self.refreshFreeManufactureBdTime==nil or time-self.refreshFreeManufactureBdTime>=_refreshFreeManufactureBdReddotCdTime then
self.refreshFreeManufactureBdTime=time

zongmenModel:clearFreeManufactureBuildingReddotNum()

UIManager:invokeUIMethod('UIFuncStorageWin','refreshFastManagerBtn')
end
end


function zongmenControl:reqZongmenDatas()
socketManager:send_3_1()
end

function zongmenControl:reqUnlockMountain(id,len,arr)
socketManager:send_3_4(id,len,arr)
end

function zongmenControl:reqUnlockMountainComplete(id)
socketManager:send_3_5(id)
end

function zongmenControl:reqChangeMountainName(id,name)
socketManager:send_3_6(id,name)
end

function zongmenControl:reqChangeMountainMaster(id,diziId)
socketManager:send_3_7(id,diziId)
end

function zongmenControl:reqMountainDatas(mId)
socketManager:send_3_8(mId)
end










function zongmenControl:reqSpeedup(type1,cnt,itemid,type2,sfId,guid,datas)
if datas then
socketManager:send_3_10(type1,type2,sfId,#datas,datas)
else
socketManager:send_3_10(type1,type2,sfId,1,{{guid,cnt,itemid}})
end
end

function zongmenControl:reqBreakZongmenLv()
socketManager:send_3_11()
end

function zongmenControl:reqMountRandomReward(sfId)
socketManager:send_3_12(sfId)
end





function zongmenControl:reqGetMountRandomReward(sfId,len,arr)
socketManager:send_3_14(sfId,len,arr)
end

function zongmenControl:reqUnlockArea(id,areaId,cost,len,arr)
socketManager:send_3_21(id,areaId,cost,len,arr)
end

function zongmenControl:reqUnlockAreaComplete(id,areaId)
socketManager:send_3_22(id,areaId)
end

function zongmenControl:reqAreaDatas(id,areaId)
socketManager:send_3_23(id,areaId)
end

function zongmenControl:reqBuild(id,bdId,x,y,orientation,dirIndex,param,itemGuid,relatedUbdId)

local suit=zongmenBuildingSuitModel:findSuitIdByBuilding(bdId)
if suit then
isometricMapSystem:cancelBuild()
zongmenBuildingSuitController:reqBuildSuit(id,x,y,bdId,orientation)
return
end


if id==mapIdType.xianmeng then
xianmengController:reqXMBuildingStart(id,bdId,x,y,orientation,dirIndex or 1)
return
end

relatedUbdId=relatedUbdId or 0
local bdCfg=cfgHelper.get1(cfg_monijybuildconfig_get,bdId)
if bdCfg.win_type~=sysWinType.eXianMeng then
socketManager:send_3_31(id,bdId,x,y,orientation,dirIndex or 1,param or 0,itemGuid or int64.zero,relatedUbdId)
end


if sharedBuildId[bdId]then
for sfId=mapIdType.zhufeng,mapIdType.lingshoudao do
local sfCfg=cfgHelper.get1(cfg_monijysfconfig_get,sfId)
local rplist=sfCfg.repair_build_list or{}
for bId,posList in pairs(rplist)do
if bId==SLG_SYSTEM_TYPE.eJiuLiDian then
for posIdx,posId in ipairs(posList)do
local state=zongmenModel:getRepairStatus(sfId,posId)
if state==repairStatus.eNotRepaired then
local posCfg=cfgHelper.get1(cfg_monijyposidxconfig_get,posId)
local posData=posCfg.pos
socketManager:send_3_31(sfId,bdId,posData[1],posData[2],orientation,dirIndex or 1,param or 0,itemGuid or int64.zero,relatedUbdId)
end
end
end
end
end
end
end

function zongmenControl:reqBuildComplete(id,bdId)
if id==mapIdType.xianmeng then


return
end

local bdData=zongmenModel:getBuildingData(bdId)
local buidID=bdData.build_id
local bdCfg=cfgHelper.get1(cfg_monijybuildconfig_get,buidID)
if bdCfg.win_type~=sysWinType.eXianMeng then
socketManager:send_3_32(id,bdId)
end


if sharedBuildId[buidID]then
for sfId=mapIdType.zhufeng,mapIdType.lingshoudao do
local datas=zongmenModel:getBuildingDataByBdId(sfId,buidID)
for index,data in ipairs(datas)do
if sfId~=id or data.un_build_id~=bdId then
socketManager:send_3_32(sfId,data.un_build_id)
end
end
end
end
end

function zongmenControl:reqBuildingLevelUp(id,bdId,len,arr)
socketManager:send_3_33(id,bdId,len,arr)
end

function zongmenControl:reqBuildingLevelUpComplete(id,bdId)
socketManager:send_3_34(id,bdId)
end

function zongmenControl:reqMoveBuilding(id,bdId,x,y,orientation)
if id==mapIdType.xianmeng then
xianmengController:reqXMBuildingMove(id,bdId,x,y,orientation)
return
end
socketManager:send_3_35(id,bdId,x,y,orientation)
end

function zongmenControl:reqDeleteBuilding(id,bdId)
socketManager:send_3_36(id,bdId)
end

function zongmenControl:reqStorageBuilding(id,bdId)
if id==mapIdType.xianmeng then
xianmengController:reqXMBuildingStore(id,bdId)
return
end
socketManager:send_3_37(id,bdId)
end

function zongmenControl:reqPlaceBuilding(id,bdId,x,y,orientation,mdIndex)
if id==mapIdType.xianmeng then
xianmengController:reqXMBuildingPlace(id,bdId,x,y,orientation,mdIndex or 1)
return
end
socketManager:send_3_38(id,bdId,x,y,orientation,mdIndex or 1)
end

function zongmenControl:reqDrawRoad(id,len,arr)
socketManager:send_3_39(id,len,arr)
end

function zongmenControl:reqDeleteRoad(id,len,arr)
socketManager:send_3_40(id,len,arr)
end

function zongmenControl:reqRoadData(id)
socketManager:send_3_41(0,id,{0,0,0,0})
end

function zongmenControl:reqBuyStorageNum(btype)
socketManager:send_3_42(btype)
end

function zongmenControl:reqBuildingData(id,bdId)
socketManager:send_3_43(id,bdId)
end

function zongmenControl:reqChangeBuildingManager(id,bdId,dzId)
socketManager:send_3_44(id,bdId,dzId)
end

function zongmenControl:reqAnimalReward()
socketManager:send_3_45()
end

function zongmenControl:reqBuildChangeName(sfId,ubdId,name)
socketManager:send_3_46(sfId,ubdId,name)
end


function zongmenControl:reqCancel(list)
guildOrderModel:setIsStopAutoShengChan(true)
socketManager:send_3_49(#list,list)
end


function zongmenControl:reqNaturalPlant(sfId,ubdId)
socketManager:send_3_61(sfId,ubdId)
end

function zongmenControl:reqSchemePlant(sfId,len,arr)
socketManager:send_3_62(sfId,len,arr)
end

function zongmenControl:reqGetPlantRewards(sfId,len,arr)
socketManager:send_3_63(sfId,len,arr)
end

function zongmenControl:reqCleanPlantReward(sfId,ubdId)
socketManager:send_3_64(sfId,ubdId)
end


function zongmenControl:reqSchemePlantEx(sfId,len,arr,bdData)
socketManager:send_3_68(sfId,len,arr)
if bdData and bdData.dizi_id then
roleAudioController:playRoleSpeak(bdData.dizi_id,roleAudioNodeType.FanAnShengChan)
end
end


function zongmenControl:reqGetPlantRewardsEx(sfId,len,arr)
socketManager:send_3_69(sfId,len,arr)
end

function zongmenControl:reqSkyBuildingData(sfId)
socketManager:send_3_75(sfId)
end

function zongmenControl:reqSkyBuild(sfId,bdId,x,y,dir)
socketManager:send_3_76(sfId,bdId,x,y,dir)
end

function zongmenControl:reqSkyBDMove(sfId,bdId,x,y,dir)
socketManager:send_3_77(sfId,bdId,x,y,dir)
end

function zongmenControl:reqSkyBDStorage(sfId,ubdId)
socketManager:send_3_78(sfId,ubdId)
end

function zongmenControl:reqSkyBuildSB(sfId,bdId,x,y,dir)
socketManager:send_3_79(sfId,bdId,x,y,dir)
end

function zongmenControl:reqBuildingLevelUp_batch(id,bdId,len,arr,addLevel)
socketManager:send_3_99(id,bdId,len,arr,addLevel)
end

function zongmenControl:reqChallengeMonster(id,x,y,len,arr)
socketManager:send_3_100(id,x,y,len,arr)
end


function zongmenControl:reqSwitchRoomFlag(sfId,ubdId,gridId,flag)
socketManager:send_3_111(sfId,ubdId,gridId,flag)
end

function zongmenControl:reqSwitchRoomDizi(sfId,ubdId,gridId,dzId)
socketManager:send_3_112(sfId,ubdId,gridId,dzId)
end

function zongmenControl:reqExChangeRoomDizi(dizi_id_1,dizi_id_2)
socketManager:send_3_113(dizi_id_1,dizi_id_2)
end

function zongmenControl:reqRewardRandomObject(guid)
socketManager:send_3_250(guid)
end


function zongmenControl:reqGetZongmenScoreReward(id)
socketManager:send_254_59(id)
end


function zongmenControl.recv_3_1(datas)
isInit=true
zongmenModel:setZongmenDatas(datas)
if not zongmenModel:isMaxMouse()then
zongmenControl.checkMouse=true
end
UIFullYanDaoTaiControl:refreshMainMenu()
end

function zongmenControl.recv_3_2(level,exp)
local lastLv=zongmenModel:getLevel()or 1
zongmenModel:setLevel(level,exp)
local args={lastLv,level}
args.callback=function()
if fullScreenUI.checkFull(UIFullShanMenControl)then
UIFullShanMenControl:closeUI(true,true)
end
UIManager:closeWindow('UIZongmenInfoWin')
UIManager:closeWindow('UIPlayerInfoWin')
isometricMapSystem:triggerSpecialModelLevelUp(lastLv,level)
end
loginControl:reportUpLevel()
msgWinControl.markLock(true)
UIManager:showWindow('UIZongmenLevelUpWin',args)
notifySystem:postNotify(notifyConfig.building_event,buildingEvent.zongmenLevelUp,level,exp,lastLv)
notifySystem:postNotify(notifyConfig.onZongMengLevelChange,level,exp)
reddotControl.on_change_catch_type(CATCH_TYPE.eZMLevel)
UIFullYanDaoTaiControl:refreshMainMenu()

if webGLHelper:isRunWeiXin()then
if lastLv<3 and level>=3 then
loginControl:tutorialFinish()
end
end
pfCommonHelper.onLevelChange(lastLv,level)
end

function zongmenControl.recv_3_3(curr,add)
zongmenModel:setExp(curr,add)
notifySystem:postNotify(notifyConfig.on_money_changed,eMoneyType.mtExp,
tonumber(tostring(curr-add)),tonumber(tostring(curr)))
end

function zongmenControl.recv_3_4(id,time,len,arr)
zongmenModel:startMountainUnlock(id,time,len,arr)
zongmenControl:reqUnlockMountainComplete(id)
end

function zongmenControl.recv_3_5(id,time)
zongmenModel:completeMountainUnlock(id,time)
mountainControl:mapUnlockComplete(id)
end

function zongmenControl.recv_3_6(id,name)

end

function zongmenControl.recv_3_7(id,roleId)

end

function zongmenControl.recv_3_8(datas)







end

function zongmenControl.recv_3_9(build_type,sf_id,ex_build_cnt)

end

function zongmenControl.recv_3_10(...)

local args={...}
local type1=args[1]
local type2=args[2]
local sfId=args[3]


local len=args[4]
local datas=args[5]
if type1==speedUpMode.eAds then
local cnt=zongmenModel:getAdsSpeedupCount()
zongmenModel:setAdsSpeedupTimes(cnt+1)
end
if len>0 then
local isNormalSPU=len==1
local func=function(v)
local guid=v.param_1
local time=v.param_2
if type2==speedUpType.eUpgradeBuilding then
zongmenModel:setUpgradeSpeedupTime(sfId,guid,time)
elseif type2==speedUpType.eExecutePlant then
zongmenModel:setProductSpeedupTime(sfId,guid,time)
elseif type2==speedUpType.eOpenArea then
zongmenModel:setAreaSpeedupTime(sfId,guid,time)
elseif type2==speedUpType.eOpenMount then
zongmenModel:setMountSpeedupTime(sfId,time)
elseif type2==speedUpType.eZhenFaStudy then
zhenfaModel:accelerateStudyingData(sfId,guid,time)
elseif type2==speedUpType.eYuLingZhai then
YuLingZhaiController:setItemAccTime(time)
elseif type2==speedUpType.eYunJiaYingTrain then


elseif type2==speedUpType.eYanDaoTai then



local un_build_id=yandaotaiController:getBuildUnBulidId()
hudControl:refreshBuildingStatusHUD(un_build_id)
end
buildingCDControl:setSpeedUp(guid,type2)
if isNormalSPU and(type2~=speedUpType.eJuTianYi)then
UIManager.info(FMT.fmt('已加速{0}',timeHelper.format_time_stamp11(time)))
end
local sendArgs={
type1=type1,
type2=type2,
ignorePlayAudio=not isNormalSPU
}
notifySystem:postNotify(notifyConfig.building_event,buildingEvent.speedUpComplete,sfId,guid,sendArgs)
end
local titleTable=cfgHelper.get2(cfg_onekeyguoduconfig_get,1,'desc')
local range=math.random(1,#titleTable)
zongmenControl:dothingSlow(func,datas,function()
UIManager.info('一键加速完成')
UIManager:closeWindow("UICommonLoadingWin")
if type2==speedUpType.eYuLingZhai then
YuLingZhaiController:onItemAccTimeEnd()
end
end,titleTable[range])

if len==1 then
if type2==speedUpType.eYuLingZhai then
YuLingZhaiController:onItemAccTimeEnd()
end
end
end
end


function zongmenControl:dothingSlow(func,datas,endCall,title)
if datas==nil then return end

if not zongmenControl.datas_3_10 then
zongmenControl.datas_3_10={}
end
zongmenControl.datas_3_10=table.concatTable(zongmenControl.datas_3_10,datas)
if self.oneKeySpeedTimer then
loggerUtil.logErrFMT('还有没处理完的事件')
return
end
local len=#zongmenControl.datas_3_10
if len>1 then
local tlen=0
local funcEx=function()
tlen=tlen+1
func(zongmenControl.datas_3_10[tlen])
if tlen>=#zongmenControl.datas_3_10 then
self.oneKeySpeedTimer:cancel()
self.oneKeySpeedTimer=nil
zongmenControl.datas_3_10=nil
end
end
self.oneKeySpeedTimer=timer.new()
self.oneKeySpeedTimer:start(0.1,funcEx)
funcEx()
UIManager:showWindow('UICommonLoadingWin',{time=0.1*len,callback=endCall,title=title})
else
for i,v in ipairs(zongmenControl.datas_3_10)do
func(v)
end
zongmenControl.datas_3_10=nil
end
end

function zongmenControl.recv_3_12(sfId,len,datas)
if len>0 then
for i,v in ipairs(datas)do

zongmenModel:addSundriseData(sfId,v)
end
end

if isometricMapSystem:IsInHome()and mountainControl:isLoaded(sfId)then
sundriseCreateControl:createSundriesByDatas(sfId,datas)
end
end

function zongmenControl.recv_3_13(sfId,len,datas)
if len>0 then
for i,v in ipairs(datas)do
zongmenModel:removeSundriseData(sfId,v)
sundriseCreateControl:removeData(v)
isometricMapSystem:receiveSundries(sfId,v)
end
end















end





function zongmenControl.recv_3_18(len,array)
for i=1,len do
local datas=array[i]
local mapId=datas.sf_id

if mapId~=mapIdType.xianmeng then
zongmenModel:setMountainDatas(datas)
end
end
if not reconnectState:isReconnect()then
mountainControl:finishEnterMountain(1)
end
moneyAutoIncreaseModel:initMax()
notifySystem:postNotify(notifyConfig.recvPro,3,18)
end

function zongmenControl.recv_3_19(pushType,len,jzList)
zongmenModel:setQiYuBuildDatas(pushType,len,jzList)
end

function zongmenControl.recv_3_21(id,areaId,time,len,arr)
zongmenModel:startAreaUnlock(id,areaId,time,len,arr)
local acfg=cfgHelper.get1(cfg_monijyareaconfig_get,areaId)

if acfg.unlock_wait==0 then
zongmenControl:reqUnlockAreaComplete(id,areaId)
zongmenControl:playUnlockAreaPlot(areaId)
else
zongmenModel:setAreaSearch(areaId)
hudControl:showAreaSearchToPos(id,areaId)
UIManager.info("弟子派遣成功，等待探索完成")
notifySystem:postNotify(notifyConfig.onZongMenAreaWaitUnLock,id,areaId)
end
end

function zongmenControl.recv_3_22(id,areaId,time)
zongmenModel:completeAreaUnlock(id,areaId,time)
isometricMapSystem:unlockArea(id,areaId)
hudControl:removeAreaSearch(areaId)

zongmenModel:addMountainRoadDatasByArea(id,areaId)
isometricMapSystem:playUnlockArea(areaId)


isometricMapSystem:setAreaCellBrightness(id,areaId,false)

isometricMapSystem:setLinkRoadData(id)

notifySystem:postNotify(notifyConfig.onZongMenAreaUnLock,id,areaId)


isometricMapSystem:autoRepair(id,areaId)


hudControl:refreshAllBuilding()
end

function zongmenControl.recv_3_23(id,areaId,data)
zongmenModel:setAreaData(id,areaId,data)
end


function zongmenControl.recv_3_24()

end

function zongmenControl.recv_3_31(id,bdId,time,linkBD)
zongmenControl.recv_3_31_imp(id,bdId,time,linkBD,nil)
end

function zongmenControl.recv_3_31_imp(id,bdId,time,linkBD,actorId)
zongmenModel:startBuild(id,bdId,time)

if not mountainControl:isLoaded(id)then
return
end

local data=zongmenModel:getBuildingData(bdId)

local cfg=cfgHelper.get1(cfg_monijybuildconfig_get,data.build_id)
local ultime
if cfg.repair_time then
ultime=cfg.repair_time[data.flag-10]
else
local lcfg=cfgHelper.get2(cfg_monijybuilduplvlconfig_get,data.build_id,1)
ultime=lcfg.uplevel_times
end

if linkBD>0 then
local lcfg=cfgHelper.get1(cfg_monijybuildconfig_get,linkBD)
if lcfg.win_type==6 then
ultime=0
end
end







local fastBuild=false
local directBuild=false

local entityId=isometricMapSystem:handleFastBuild(data)
if not entityId then

if actorId==nil or actorId==playerModel:getActorID()then
local building=isometricMapSystem:getPreviewBuilding()
if building then
entityId=building.guid
else

local repairData=isometricMapSystem:getRepairData(id,data.x,data.y)
if repairData then
isometricMapSystem:removeRepairData(id,repairData.guid)
zongmenModel:setRepairStatusByPos(id,data.build_id,repairStatus.eUnderRepair,data.un_build_id,data.x,data.y)
entityId=repairData.guid
isometricMapSystem:addNameHud(entityId,cfg.id)
isometricMapSystem:addQiYuHud(entityId,cfg.id)
if repairData.mapId==mapIdType.xianmeng then
timeEventController.delayDo(1,function()
UIManager.info(FMT.fmt("开始修复{0}",cfg.name))
end)
end
else

entityId=isometricMapSystem:createABuildingToMap(id,data)
isometricMapSystem:addNameHud(entityId,cfg.id)
isometricMapSystem:addQiYuHud(entityId,cfg.id)

end
end
else
local repairData=isometricMapSystem:getRepairData(id,data.x,data.y)
if repairData then
isometricMapSystem:removeRepairData(id,repairData.guid)
zongmenModel:setRepairStatusByPos(id,data.build_id,repairStatus.eUnderRepair,data.un_build_id,data.x,data.y)
entityId=repairData.guid
isometricMapSystem:addNameHud(entityId,cfg.id)
isometricMapSystem:addQiYuHud(entityId,cfg.id)
else
entityId=isometricMapSystem:createABuildingToMap(id,data)
isometricMapSystem:addNameHud(entityId,cfg.id)
isometricMapSystem:addQiYuHud(entityId,cfg.id)
fastBuild=true
end
end
else
fastBuild=true
isometricMapSystem:reqFastBuild()
end

zongmenModel:setBuildingEntityId(id,bdId,entityId)

if not fastBuild then
isometricMapSystem:applyBuild(bdId)
end

if ultime>0 then

AudioManager.playAudio(433)
isometricMapSystem:changeModelById(id,bdId)
isometricMapSystem:change3DModelById(id,bdId)
end

zongmenModel:addBuildingCount(data.build_id,id)

if not fastBuild then
notifySystem:postNotify(notifyConfig.building_event,buildingEvent.buildStart,id,bdId)
end

if ultime==0 then
zongmenControl:reqBuildComplete(id,bdId)
directBuild=true
end
hudControl:addProgressData(id,bdId,not directBuild)

if linkBD==0 and data.flag==1 and cfg.is_move~=0 then
zongmenModel:saveBuildTempData(data)
end
end

function zongmenControl.recv_3_32(sfId,ubdId,time,linkBD)
zongmenModel:completeBuild(sfId,ubdId,time)


local data=zongmenModel:getBuildingData(ubdId)
local build_id
if data then
build_id=data.build_id
systemControl.onBuildCreated(build_id)
end

if not mountainControl:isLoaded(sfId)then
return
end

hudControl:closeProgress(ubdId)

isometricMapSystem:addNameHudBybdid(ubdId)
isometricMapSystem:addQiYuHudBybdid(ubdId)
isometricMapSystem:changeModelById(sfId,ubdId)
isometricMapSystem:change3DModelById(sfId,ubdId)

isometricMapSystem:setBenefitBuffBuildingById(sfId,ubdId)

mainBtnConfig.freshBuildBtnVis(data.build_id)


local status=zongmenModel:getRepairStatusById(sfId,data.un_build_id)
if status and status~=repairStatus.eNotRepaired then
isometricMapSystem:setLockPlaceObject(data.entityId,false)

zongmenModel:setRepairStatusById(sfId,data.build_id,repairStatus.eRepaired,data.un_build_id)
end

isometricMapSystem:setBuildingLinkRoad(sfId,ubdId)


buildingEffectControl:playEffectByEID(data.entityId,data.build_id,buildEffectType.eLevelUp,nil,true)
buildingEffectControl:refreshBuildingBuffEffect(sfId,ubdId)



local cfg=cfgHelper.get1(cfg_monijybuildconfig_get,data.build_id)
if cfg.etype==2 then
feedingSystem:addFeedBuilding(data)
end

isometricMapSystem:checkAndPlayPemanentEffect(data,cfg)

notifySystem:postNotify(notifyConfig.building_event,buildingEvent.buildComplete,sfId,ubdId,data.build_id)

hudControl:refreshBuildingStatusHUD(ubdId)

if cfg.finishbehavior then
storyAIManager:startStoryBehavior(cfg.finishbehavior)
end

if cfg.win_type==7 then
UIManager.info('成功')
elseif cfg.win_type==6 then
elseif sfId~=mapIdType.xianmeng then

AudioManager.playAudio(434)
if linkBD==0 then
if data.flag==0 then
UIManager.info('建造成功')
if cfg.is_move~=0 then
zongmenModel:saveBuildTempData(data)
end
end
else
local lcfg=cfgHelper.get1(cfg_monijybuildconfig_get,linkBD)
if lcfg.win_type==6 then
UIManager.info('修复成功')
end
end
end
newbieControl.startNewbie(NEW_BIE_CND_TYPE.eLuaFun,FMT.fmt('buildComplete_{0}',build_id))
end

function zongmenControl.recv_3_33(sfId,ubdId,time,len,arr)
zongmenModel:startLevelUp(sfId,ubdId,time,len,arr)

AudioManager.playAudio(433)

isometricMapSystem:changeModelById(sfId,ubdId)

notifySystem:postNotify(notifyConfig.building_event,buildingEvent.levelUpStart,sfId,ubdId)
notifySystem:postNotify(notifyConfig.onDaoLvChange,buildingEvent.levelUpStart,sfId,ubdId)

hudControl:refreshBuildingStatusHUD(ubdId)

local building=zongmenModel:getBuildingData(ubdId)
if building and autoFinishLvUpBuildId[building.build_id]and building.level>=1 then
if buildingCDControl:isComplete(buildingCDType.build,ubdId)then

zongmenControl:reqBuildingLevelUpComplete(sfId,ubdId)
end
end
end

function zongmenControl.recv_3_34(sfId,ubdId,level)
zongmenModel:completeLevelUp(sfId,ubdId,level)
hudControl:closeProgress(ubdId)


AudioManager.playAudio(434)

isometricMapSystem:changeModelById(sfId,ubdId)
isometricMapSystem:change3DModelById(sfId,ubdId)

local data=zongmenModel:getBuildingData(ubdId)
zongmenModel:setLevelDirty(data.build_id)
isometricMapSystem:setBenefitBuffBuildingById(sfId,ubdId)

buildingEffectControl:playEffectByEID(data.entityId,data.build_id,buildEffectType.eLevelUp,nil,true)

notifySystem:postNotify(notifyConfig.building_event,buildingEvent.levelUpComplete,sfId,ubdId)
notifySystem:postNotify(notifyConfig.onDaoLvChange,buildingEvent.levelUpComplete,sfId,ubdId)
hudControl:refreshBuildingStatusHUD(ubdId)

local cfg=cfgHelper.get1(cfg_monijybuildconfig_get,data.build_id)
if data.flag~=0 and cfg.repair_cost and#cfg.repair_cost>1 then
UIManager.info('修复成功')
else
UIManager.info('升级成功')
end
end

function zongmenControl.recv_3_35(id,bdId,x,y,orientation)
zongmenControl.recv_3_35_imp(id,bdId,x,y,orientation,nil)
end

function zongmenControl.recv_3_35_imp(id,bdId,x,y,orientation,actor)


local blist=buildingEffectControl:getPlayBenefitBuildingList(id,bdId)
zongmenModel:moveBuilding(id,bdId,x,y,orientation)

isometricMapSystem:setBuildingLinkRoad(id,bdId)

local building=isometricMapSystem:getPreviewBuilding()
if building and building.bdData and building.bdData.un_build_id==bdId then
hudControl:removeHUD(building.hudId)
end

local data=zongmenModel:getBuildingData(bdId)
isometricMapSystem:applyMove(data,actor)

hudControl:refreshBuildingStatusHUD(bdId)

isometricMapSystem:setBenefitBuffBuildingById(id,bdId)

buildingEffectControl:playBenefitBuildingEffect(id,blist)
buildingEffectControl:refreshBuildingBuffEffect(id,bdId)

notifySystem:postNotify(notifyConfig.building_event,buildingEvent.moveBuilding,id,bdId)
end

function zongmenControl.recv_3_36(id,bdId)
local data=zongmenModel:getBuildingData(bdId)
local cfg=cfgHelper.get1(cfg_monijybuildconfig_get,data.build_id)

hudControl:removeProgressData(bdId)

zongmenModel:deleteBuilding(id,bdId)

zongmenModel:setLevelDirty(bdId)






isometricMapSystem:removeNameHudBybdid(bdId)
isometricMapSystem:applyDelete(data)

if data.entityId then
hudControl:clearHUDByEntityID(data.entityId)
end

zongmenModel:delDesignStorageData(bdId)

local showInfo=true
if cfg.win_type==sysWinType.eZhenYan then

local rpdata=isometricMapSystem:getRepairDataByID(id,cfg.related)
hudControl:refreshBuildingStatusHUD(rpdata.rpId)
showInfo=false
elseif cfg.win_type==sysWinType.eShouLan then

feedingSystem:removeFeedBuilding(data.entityId)
elseif cfg.win_type==sysWinType.eMiZhen then
showInfo=false
elseif id==mapIdType.xianmeng then
showInfo=false
end

if showInfo then
UIManager.info(string.format('%s已从宗门中移除',cfg.name))
end

zongmenControl:triggerBuildingEvent(1,cfg.trigger,{bd_st=data.entityId})

isometricMapSystem:setBenefitBuffBuildingById(id,bdId,true)
zongmenEffectControl:removeBuildinfEffect(bdId)
notifySystem:postNotify(notifyConfig.building_event,buildingEvent.removeBuilding,id,bdId)
end

function zongmenControl.recv_3_37(id,bdId)
zongmenControl.recv_storage(id,bdId)
UIManager.info('建筑已成功收纳')
end

function zongmenControl.recv_storage(id,bdId)
local data=zongmenModel:getBuildingData(bdId)
local cfg=cfgHelper.get1(cfg_monijybuildconfig_get,data.build_id)
local dzid=data.dizi_id
if mathHelper.validInt64(dzid)then
zongmenModel:setDiscipleBuilding(dzid,nil)
end

isometricMapSystem:removeNameHudBybdid(bdId)
hudControl:removeProgressData(bdId)
zongmenModel:storageBuilding(id,bdId)
UIShopModel:removeShopData(id,bdId)
UIShopControl:removeShopBuyer(id,bdId)








isometricMapSystem:applyStorage(data)
hudControl:clearHUDByEntityID(data.entityId)

isometricMapSystem:removeUnlinkRecord(bdId)
isometricMapSystem:conversionUnlinkData()

if cfg.win_type==sysWinType.eShouLan then

feedingSystem:removeFeedBuilding(data.entityId)
end

isometricMapSystem:setBenefitBuffBuildingById(id,bdId,true)
zongmenEffectControl:removeBuildinfEffect(bdId)
notifySystem:postNotify(notifyConfig.building_event,buildingEvent.storageBuilding,id,bdId)
end

function zongmenControl.recv_3_38(id,bdId)
zongmenModel:placeBuilding(id,bdId)



local building=isometricMapSystem:getPreviewBuilding()

local data=zongmenModel:getBuildingData(bdId)
if building==nil then
local entityId=isometricMapSystem:createABuildingToMap(id,data)
zongmenModel:setBuildingEntityId(id,bdId,entityId)
else
zongmenModel:setBuildingEntityId(id,bdId,building.guid)
isometricMapSystem:applyBuild(bdId)
end

isometricMapSystem:setBuildingLinkRoad(id,bdId)

emergenciesControl:onBuildComplete_YiMuCongSheng(bdId)

hudControl:addProgressData(id,bdId,true)

isometricMapSystem:setBenefitBuffBuildingById(id,bdId)

buildingEffectControl:refreshBuildingBuffEffect(id,bdId)

local cfg=cfgHelper.get1(cfg_monijybuildconfig_get,data.build_id)
if cfg.etype==2 then
feedingSystem:addFeedBuilding(data)
end

notifySystem:postNotify(notifyConfig.building_event,buildingEvent.placeBuilding,id,bdId)
end

function zongmenControl.recv_3_39(id,len,arr)
if len>0 then
zongmenModel:addMountainRoadDatas(id,arr)
isometricMapSystem:handleApplyRoad()
isometricMapSystem:setLinkRoadData(id)

if isometricMapSystem:getEditorMode()~=editorMode.eCreateRoad then
local temp={}
for i,v in ipairs(arr or{})do
temp[FMT.fmt("{0}_{1}",v.x,v.y)]={
x=v.x,
y=v.y,
style=v.type,
type=v.style,
}
end
isometricMapSystem:drawRoad(id,temp)
end
end
end

function zongmenControl.recv_3_40(id,len,arr)
if len>0 then
zongmenModel:removeMountainRoadDatas(id,arr)
isometricMapSystem:handleApplyRoad()
isometricMapSystem:setLinkRoadData(id)
end
end

function zongmenControl.recv_3_41(id,len,arr)





end

function zongmenControl.recv_3_42(collectCount)
zongmenModel:setExtraStorage(collectCount)
UIManager:invokeUIMethod('UILayoutWin','setStorageNum')
end

function zongmenControl.recv_3_43(sfId,ubdId,data)
local bdData=zongmenModel:getBuildingData(ubdId)
local needHUD
if not bdData then
local guid=isometricMapSystem:conversionSundries(sfId,data.x,data.y)
data.entityId=guid
needHUD=guid~=nil
if guid then
zongmenModel:setEntityIdRecord(guid,ubdId)
_MapManager.SetFadeToColor(guid,Color.New(1,1,1,1),0.5,nil)
end
end
zongmenModel:setBuildingData(sfId,ubdId,data)
if needHUD then
hudControl:addProgressData(sfId,ubdId,true)
end

notifySystem:postNotify(notifyConfig.building_event,buildingEvent.buildDataChange,sfId,ubdId)

hudControl:refreshBuildingStatusHUD(ubdId)
end

function zongmenControl.recv_3_44(sfId,ubdId,dzId)
local oldDzId=zongmenModel:changeBuildingManager(sfId,ubdId,dzId)
zongmenModel:setDiscipleBuilding(oldDzId,nil)
zongmenModel:setDiscipleBuilding(dzId,ubdId)


local autoSCflag=guildOrderController:getAutoSC()
if autoSCflag then
guildOrderController:setAutoSC(false)
guildOrderController:handleAutoShengChan()
end

hudControl:refreshBuildingStatusHUD(ubdId)
notifySystem:postNotify(notifyConfig.building_event,buildingEvent.replaceDisciple,sfId,ubdId,dzId,oldDzId)
end

function zongmenControl.recv_3_45(beginTime,count,rewardLen,rewardList)
zongmenModel:setMouseLastTime(beginTime)
zongmenModel:setMouseCnt(count)
if not zongmenModel:isMaxMouse()then
timeEventController.addNormalTimerHandler(1,"zongmenControl",zongmenControl)
end

UIManager:invokeUIMethod("UIBottomMaskWin","rewardMouse",rewardList)
end

function zongmenControl.recv_3_46(sfId,ubdId,newName,ret)

if ret==0 then
UIManager.info('修改成功')
local bdData=zongmenModel:getBuildingData(ubdId)
bdData.name=newName
bdData.rename_flag=1
UIManager:invokeUIMethod("UIDzRoomWin","refreshBuildName",newName)
UIManager:invokeUIMethod("UIDLRoomWin","refreshBuildName",newName)
UIManager:invokeUIMethod("UIXianYunGangWin","refreshBuildName",newName)
UIManager:invokeUIMethod("UIBuildChangeNameWin","closeSelf")
UIManager:invokeUIMethod("UIXianJie_YunZhouSelectWin","changeNameRecv",newName)
else
UIManager.error('名字中含有敏感字符')
end
end

function zongmenControl.recv_3_47(len,array)
zongmenModel:initActiveBuildData(len,array)
isometricMapSystem:removeAllActiveBuildCfg()
zongmenControl.initActiveBuild()
end

function zongmenControl.recv_3_48(bdId,ret)
if ret==1 then
zongmenModel:addActiveBuild(bdId)
isometricMapSystem:removeAllActiveBuildCfg()
local name=cfgHelper.get2(cfg_monijybuildconfig_get,bdId,'name')
UIManager.info(FMT.fmt('{0}已激活',name))
else
local itemid=cfgHelper.get2(cfg_monijybuildconfig_get,bdId,'activate_cost')
if itemid then
zongmenControl.tryActiveBuild(itemid)
end
end
end

function zongmenControl.recv_3_49(len,list)
guildOrderModel:setIsStopAutoShengChan(false)
UIManager:invokeUIMethod('UIFastManagerWin','refreshCancel')
end

function zongmenControl.recv_3_52(len,array)
zongmenModel:initActiveRoadData(len,array)
isometricMapSystem:removeAllActiveRoadCfg()
zongmenControl.initActiveRoad()
end

function zongmenControl.recv_3_53(id)
zongmenModel:addActiveRoad(id)
isometricMapSystem:removeAllActiveRoadCfg()
local name=cfgHelper.get2(cfg_roadstyleconfig_get,id,'name')
UIManager.info(FMT.fmt('{0}已激活',name))
end

function zongmenControl.recv_3_61(sfId,ubdId,len,arr)
zongmenModel:resetNaturalProduction(sfId,ubdId)
hudControl:closeProgress(ubdId)
if len>0 then
local datas={}
for i,v in ipairs(arr)do
table.insert(datas,{v.param_1,v.param_2})
end
zongmenControl:showPlanReward(sfId,ubdId,datas)
end
notifySystem:postNotify(notifyConfig.building_event,buildingEvent.receiveNatural,sfId,ubdId)
buildingCDControl:updateCDData(buildingCDType.natural,ubdId)
hudControl:refreshBuildingStatusHUD(ubdId)
end

function zongmenControl.recv_3_62(sfId,len,arr)







end

function zongmenControl:handlePlanStart(datas)
local sfId=datas[1]
local ubdId=datas[2]
local plantId=datas[3]
local dzId=datas[4]

local data=zongmenModel:getBuildingData(ubdId)
data.pcreate_effect_len=datas[7]
data.pEffectList=datas[8]

data.spe_reward_len=datas[9]or 0
data.speRewardList=datas[10]

zongmenModel:startPlanProduction(sfId,ubdId,plantId,dzId,datas[5],datas[6])

isometricMapSystem:setBuildingPlanStatus(sfId,ubdId,planStatus.eStart)
isometricMapSystem:changeModelById(sfId,ubdId)


buildingEffectControl:playEffectByEID(data.entityId,data.build_id,buildEffectType.eProduce)

zongmenControl:setDiscipleState(data,DISCIPLE_STATE_TYPE.ePlantCreate)

notifySystem:postNotify(notifyConfig.building_event,buildingEvent.planStart,sfId,ubdId,dzId,plantId)

hudControl:refreshBuildingStatusHUD(ubdId)
end

function zongmenControl.recv_3_63(sfId,len,arr)





end

function zongmenControl:handlePlanFinish(sfId,ubdId)
zongmenControl:showPlanReward(sfId,ubdId)
zongmenModel:endPlanProduction(sfId,ubdId)
hudControl:closeProgress(ubdId)

emergenciesModel:setProductionCutValue(ubdId,nil)

isometricMapSystem:setBuildingPlanStatus(sfId,ubdId,planStatus.eDefault)
isometricMapSystem:changeModelById(sfId,ubdId)

local data=zongmenModel:getBuildingData(ubdId)

buildingEffectControl:stopEffect(data.entityId,buildEffectType.eProduce)

zongmenControl:setDiscipleState(data,DISCIPLE_STATE_TYPE.ePlantCreate,true)



notifySystem:postNotify(notifyConfig.building_event,buildingEvent.planComplete,sfId,ubdId,data.dizi_id)

UICatShopControl:checkAndShowEvent()

hudControl:refreshBuildingStatusHUD(ubdId)
end

function zongmenControl.recv_3_64(sfId,ubdId)
zongmenModel:endPlanProduction(sfId,ubdId)
hudControl:closeProgress(ubdId)

emergenciesModel:setProductionCutValue(ubdId,nil)

isometricMapSystem:setBuildingPlanStatus(sfId,ubdId,planStatus.eDefault)
isometricMapSystem:changeModelById(sfId,ubdId)

local data=zongmenModel:getBuildingData(ubdId)
buildingEffectControl:stopEffect(data.entityId,buildEffectType.eProduce)

zongmenControl:setDiscipleState(data,DISCIPLE_STATE_TYPE.ePlantCreate,true)

notifySystem:postNotify(notifyConfig.building_event,buildingEvent.planCancel,sfId,ubdId)

hudControl:refreshBuildingStatusHUD(ubdId)
end

function zongmenControl.recv_3_65(sfId,ubdId,plan,reason)
zongmenModel:stopBuilding(sfId,ubdId,plan,reason)
hudControl:refreshBuildingStatusHUD(ubdId)
notifySystem:postNotify(notifyConfig.building_event,buildingEvent.planStatusChange,sfId,ubdId,0)
end

function zongmenControl.recv_3_66(sfId,ubdId,plan)
zongmenModel:restoreBuilding(sfId,ubdId,plan)
hudControl:refreshBuildingStatusHUD(ubdId)
notifySystem:postNotify(notifyConfig.building_event,buildingEvent.planStatusChange,sfId,ubdId,1)
end

function zongmenControl.recv_3_67(sfId,ubdId,planId,len,arr)
zongmenModel:refreshPlanInfo(sfId,ubdId,planId,len,arr)

buildingCDControl:resetCDData(buildingCDType.plan,ubdId)
notifySystem:postNotify(notifyConfig.building_event,buildingEvent.planChange,sfId,ubdId,nil)
end

function zongmenControl.recv_3_68(sfId,len,arr)
if len==0 then return end
for i,v in ipairs(arr)do
zongmenControl:handlePlanStartEx(sfId,v)
end







end

function zongmenControl:handlePlanStartEx(sfId,data)
local ubdId=data.un_build_id
local plantId=data.plant_id

local bdData=zongmenModel:getBuildingData(ubdId)
bdData.pcreate_effect_len=data.create_effect_len
bdData.pEffectList=data.pEffectList

bdData.len=data.len
bdData.rewardList=data.rewardList

bdData.effect_len=0
bdData.effectLst=nil

local dzId=bdData.dizi_id

emergenciesModel:setProductionCutValue(ubdId,nil)

zongmenModel:startPlanProduction(sfId,ubdId,plantId,dzId,data.exaddpercent,data.extimepercent)

isometricMapSystem:setBuildingPlanStatus(sfId,ubdId,planStatus.eStart)
isometricMapSystem:changeModelById(sfId,ubdId)

buildingEffectControl:playEffectByEID(bdData.entityId,bdData.build_id,buildEffectType.eProduce)

zongmenControl:setDiscipleState(bdData,DISCIPLE_STATE_TYPE.ePlantCreate)

notifySystem:postNotify(notifyConfig.building_event,buildingEvent.planStart,sfId,ubdId,dzId,plantId)

hudControl:refreshBuildingStatusHUD(ubdId)
end

function zongmenControl.recv_3_69(sfId,len,arr)
if len>0 then
if webGLHelper.isRunWeiXin()then
_planFinishUpdateData={}
for i,v in ipairs(arr)do
_planFinishUpdateData[#_planFinishUpdateData+1]={sfId,v}
end
zongmenControl:startPlanFinishTimer()
else
for i,v in ipairs(arr)do
zongmenControl:showPlanFinish(sfId,v)
end
end
end

end

function zongmenControl.recv_3_75(sfId,len,arr,slen,sarr)
zongmenModel:setSkyBuildingDatas(sfId,len,arr,slen,sarr)
end


function zongmenControl.recv_3_76(datas)
local sfId=datas[1]
local ubdId=datas[6]
zongmenModel:addSkyBuildingData(datas)
local building=isometricMapSystem:getPreviewBuilding()
zongmenModel:setSkyBuildingEntityId(ubdId,building.guid)
isometricMapSystem:applySkyBuild(ubdId)
UIManager:callWindowFunc('UISkyLayoutWin','HandleApplyBuild',sfId,ubdId)
end

function zongmenControl.recv_3_77(sfId,ubdId,x,y,dir)
zongmenModel:moveSkyBuilding(sfId,ubdId,x,y,dir)
isometricMapSystem:applySkyBuild(ubdId)
UIManager:callWindowFunc('UISkyLayoutWin','HandleApplyMove')
end

function zongmenControl.recv_3_78(sfId,ubdId)
local data=zongmenModel:storageSkyBuilding(sfId,ubdId)
if data then
hudControl:clearHUDByEntityID(data.entityId)
isometricMapSystem:applySkyStorage(data)
data.entityId=nil
end
UIManager.info('空中装饰已成功收纳')
UIManager:callWindowFunc('UISkyLayoutWin','HandleStorage')
end

function zongmenControl.recv_3_79(sfId,ubdId,x,y,dir)
zongmenModel:placeSkyBuilding(sfId,ubdId,x,y,dir)
local data=zongmenModel:getSkyBuildingData(ubdId)
local building=isometricMapSystem:getPreviewBuilding()
zongmenModel:setSkyBuildingEntityId(ubdId,building.guid)
hudControl:clearHUDByEntityID(data.entityId)
isometricMapSystem:applySkyBuild(ubdId)
UIManager:callWindowFunc('UISkyLayoutWin','HandleApplyPlace')
end


function zongmenControl:showPlanFinish(sfId,datas)
local ubdId=datas.un_build_id
local data=zongmenModel:getBuildingData(ubdId)

zongmenControl:showPlanReward(sfId,ubdId)

local cddata=buildingCDControl:getCDData(buildingCDType.plan,ubdId)
if not cddata.complete then
data.pcreateopentime=datas.begin_times
data.pcreatetotaltimes=datas.total_times
data.hasExNum=datas.hasExNum
data.pcreatereducetimes=0
buildingCDControl:resetCDData(buildingCDType.plan,ubdId)
notifySystem:postNotify(notifyConfig.building_event,buildingEvent.planCollect,sfId,ubdId,data.dizi_id)
else
zongmenModel:endPlanProduction(sfId,ubdId)
hudControl:closeProgress(ubdId)

emergenciesModel:setProductionCutValue(ubdId,nil)

isometricMapSystem:setBuildingPlanStatus(sfId,ubdId,planStatus.eDefault)
isometricMapSystem:changeModelById(sfId,ubdId)

buildingEffectControl:stopEffect(data.entityId,buildEffectType.eProduce)

zongmenControl:setDiscipleState(data,DISCIPLE_STATE_TYPE.ePlantCreate,true)

notifySystem:postNotify(notifyConfig.building_event,buildingEvent.planComplete,sfId,ubdId,data.dizi_id)

UICatShopControl:checkAndShowEvent()

hudControl:refreshBuildingStatusHUD(ubdId)


guildOrderController:handleSingleAutoShengChan(ubdId)
end
end

function zongmenControl:showPlanFinishEx(sfId,datas)
local ubdId=datas.un_build_id
local data=zongmenModel:getBuildingData(ubdId)



local cddata=buildingCDControl:getCDData(buildingCDType.plan,ubdId)
if not cddata.complete then
data.pcreateopentime=datas.begin_times
data.pcreatetotaltimes=datas.total_times
data.hasExNum=datas.hasExNum
data.pcreatereducetimes=0
buildingCDControl:resetCDData(buildingCDType.plan,ubdId)
notifySystem:postNotify(notifyConfig.building_event,buildingEvent.planCollect,sfId,ubdId,data.dizi_id)
else
zongmenModel:endPlanProduction(sfId,ubdId)
hudControl:closeProgress(ubdId)

emergenciesModel:setProductionCutValue(ubdId,nil)

isometricMapSystem:setBuildingPlanStatus(sfId,ubdId,planStatus.eDefault)
isometricMapSystem:changeModelById(sfId,ubdId)

buildingEffectControl:stopEffect(data.entityId,buildEffectType.eProduce)

zongmenControl:setDiscipleState(data,DISCIPLE_STATE_TYPE.ePlantCreate,true)

notifySystem:postNotify(notifyConfig.building_event,buildingEvent.planComplete,sfId,ubdId,data.dizi_id)

UICatShopControl:checkAndShowEvent()

hudControl:refreshBuildingStatusHUD(ubdId)


guildOrderController:handleSingleAutoShengChan(ubdId)
end
end

function zongmenControl.recv_3_99(sfId,ubdId,oldLevel,level)
zongmenModel:completeLevelUp(sfId,ubdId,level)
hudControl:closeProgress(ubdId)


AudioManager.playAudio(434)

isometricMapSystem:changeModelById(sfId,ubdId)
isometricMapSystem:change3DModelById(sfId,ubdId)

local data=zongmenModel:getBuildingData(ubdId)
isometricMapSystem:setBenefitBuffBuildingById(sfId,ubdId)
buildingEffectControl:playEffectByEID(data.entityId,data.build_id,buildEffectType.eLevelUp,nil,true)

notifySystem:postNotify(notifyConfig.building_event,buildingEvent.levelUpComplete,sfId,ubdId,oldLevel)
notifySystem:postNotify(notifyConfig.onDaoLvChange,buildingEvent.levelUpComplete,sfId,ubdId)
hudControl:refreshBuildingStatusHUD(ubdId)

local cfg=cfgHelper.get1(cfg_monijybuildconfig_get,data.build_id)
if data.flag~=0 and cfg.repair_cost and#cfg.repair_cost>1 then
UIManager.info('修复成功')
else
UIManager.info('升级成功')
end
end

function zongmenControl.recv_3_100(id,x,y,result,fightLog)
notifySystem:postNotify(notifyConfig.onTriggerBattle,eBattleType.zongmenMonster,result,fightLog,x,y)
end

function zongmenControl.recv_3_111(sfId,ubdId,gzId,flag)
zongmenModel:setRoomGridFlag(sfId,ubdId,gzId,flag)
notifySystem:postNotify(notifyConfig.building_event,buildingEvent.switchRoomFlag,sfId,ubdId,gzId,flag)
end

function zongmenControl.recv_3_112(sfId,ubdId,gzId,dzId,replace)
local oldDzId=zongmenModel:getRoomGridDizi(sfId,ubdId,gzId)
zongmenModel:setRoomGridDizi(sfId,ubdId,gzId,dzId,oldDzId,replace)

hudControl:refreshBuildingStatusHUD(ubdId)
notifySystem:postNotify(notifyConfig.building_event,buildingEvent.switchRoomDizi,sfId,ubdId,gzId,dzId,oldDzId,replace)
end

function zongmenControl.recv_3_113(datas)
zongmenControl.recv_3_112(datas[1],datas[2],datas[3],datas[4],true)
zongmenControl.recv_3_112(datas[5],datas[6],datas[7],datas[8],true)
end

function zongmenControl.recv_3_249(len,array)
if len>0 then
zongmenModel:addRandomObjects(array)
zongmenModel:flushRandomObjectPosition()
if isometricMapSystem:IsInHome()then
for i,v in ipairs(array)do
local data=zongmenModel:getRandomObject(v.randItemGuid)
isometricMapSystem:createRandomObject(data)
end
end
end
end

function zongmenControl.recv_3_250(guid,len,rewards)
zongmenModel:removeRandomObject(guid)
zongmenModel:flushRandomObjectPosition()
if isometricMapSystem:IsInHome()then
local data=isometricMapSystem:getRandomObject(guid)
if len>0 then
local isBox=data.type==sundriseType.eRewardBox
local showRW={}
local showDrop={}
for i,v in ipairs(rewards)do
if isBox then
showPrizeControl.insertTemp(showRW,nil,v.param_1,v.param_2)
end
table.insert(showDrop,{v.param_1,v.param_2})
end

if#showRW>0 then
msgWinControl:addMsgWin(msgWinType.eCommonShowPrize,{list=showRW})
end

if data.type==sundriseType.eStillSundrise or data.type==sundriseType.eRewardBox then
isometricMapSystem:showStillSundriesRewardHud(data.mapId,data.x,data.y,showDrop)
end
end
isometricMapSystem:removeRandomObject(guid)
end
end


function zongmenControl.recv_254_59(flag)
local isReset=false
if not bitHelper.check_pos(flag,0)then

isReset=zongmenModel:getZongMenScoreGetRewardFlag(1)
end

zongmenModel:setZongMenScoreGetRewardFlag(flag)

zongmenModel:refreshZongMenScoreGetRewardProgressPoint()


UIManager:callWindowFunc('UISubAct_zongmendabi_score_win','refresh',isReset)


reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,SUB_ACTIVITY_TYPE.eSectCompetition)
notifySystem:postNotify(notifyConfig.onActTabReddotChange,SUBACT_DEFINETAB_TYPE.eZongMenDaBi_score)
end


function zongmenControl:getSpecialityAddDesc(len,config)
local specialitytype=config.specialitytype or config.typo
local effect_adddesc=config.effects_adddesc
local content=''
if effect_adddesc then
local effectDescList
if specialitytype==DISCIPLE_SPECIALITY_TYPE.eSpiritRoot then
if len then
if len>0 then
effectDescList=effect_adddesc[len]
else
if type(effect_adddesc[1]=='string')then
effectDescList=effect_adddesc
end
end
end
else
effectDescList=effect_adddesc
end
if effectDescList then
content=table.concat(effectDescList,"\n")
end
end
return content
end


function zongmenControl:getPlantEffect(effect,bd_type)
local data=self:getEffectByType(effect,discipleEffectType.ePlant)
if data then
local effectData=data[bd_type]or data[0]
for i,v in ipairs(effectData)do
v.addType=discipleEffectType.ePlant
end
return effectData
end
return nil
end


function zongmenControl:getEffectByType(effect,eft_type)
if effect then
for i,v in ipairs(effect)do
if v.type==eft_type then
for i1,v1 in ipairs(v.param)do
v1.addType=eft_type
end
return v.param
end
end
end
return nil
end


function zongmenControl:getPlantEffectScore(plant_effect)
local score=0
if plant_effect then
for i,data in ipairs(plant_effect)do
local percent=data[2]
local factor=_effectScore[data[1]]
score=score+percent*factor
end
end
return score
end


function zongmenControl:getSkillPlantEffectScore(plant_effect)
local score=0
if plant_effect then
score=score+plant_effect[1]*_effectScore[3]-plant_effect[2]*_effectScore[1]
end
return score
end



function zongmenControl:showSelectManagerWin(sfId,bdData,openType,effectType,funcIndex)
local args={
openType=openType or dzSelectWinOpenType.eManager,
effectType=effectType or dzSelectEffectType.ePlan,
bdData=bdData,
sfId=sfId,
funcIndex=funcIndex or 1,
callback=function(dzId)
if bdData.dizi_id then

roleAudioController:playRoleSpeak(dzId,roleAudioNodeType.RenMingJianZu)
end
self:reqChangeBuildingManager(sfId,bdData.un_build_id,dzId)
end
}
discipleSelectController:openDiscipleSelect(args)
end

function zongmenControl:getMinNeedLevel(cfg,sfId)
local sfId=sfId or zongmenModel:getMountainId()
for i,v in ipairs(cfg.guildlvl_limit)do
if v.param[sfId]then
return v[1]
end
end

return 0
end

function zongmenControl:checkMinNeedLevel(cfg,sfId)
local sfId=sfId or zongmenModel:getMountainId()
local level=zongmenModel:getLevel()
if sfId==mapIdType.xianmeng then
local xmLv=xianmengModel:getXMLevel()
level=xmLv or-1
end
if cfg.guildlvl_limit then
for i,v in ipairs(cfg.guildlvl_limit)do
if v.param[sfId]then
return v[1]<=level
end
end
end
return true
end


function zongmenControl:checkBuildingPassRepairCondition(buildId)
local cfg=cfgHelper.get1(cfg_monijybuildconfig_get,buildId)
local tips=''


if cfg.repair_tips then
local tipsDatas=cfg.repair_tips
for i,tipsData in ipairs(tipsDatas)do
local ctype=tipsData.ctype
local tipsStr=tipsData.desc
local gsubRule="<.->"
tips=string.gsub(tipsStr,gsubRule,"")
if ctype==1 then
local areaId=tipsData.cargs[1]
local isUnlock=zongmenModel:isAreaUnlock(areaId)
if not isUnlock then
local acfg=cfgHelper.get1(cfg_monijyareaconfig_get,areaId)
tips=FMT.fmt(tips,acfg.name)
return false,tips
end
elseif ctype==2 then
local sysId=tipsData.cargs[1]
local isOpen=systemModel.isOpen(sysId)
if not isOpen then
return false,tips
end
elseif ctype==3 then
local taskId=tipsData.cargs[1]
local isOpen=taskModel:checkTaskFinish(taskId)
if not isOpen then
local tcfg=taskModel:getTaskConfig(taskId)
tips=FMT.fmt(tips,tcfg.name)
return false,tips
end
end
end
end


local needSys=cfg.repair_system
if needSys and not systemModel.isOpen(needSys)then
tips=systemModel.getOpenTips(needSys,nil,'后可修复')
return false,tips
end

return true
end

function zongmenControl:isMountid(mountid)
return zongmenModel:getMountainId()==mountid
end


function zongmenControl:checkLevelUp(config,warning,sfId,retArgs)
local maxLevel=zongmenModel:getBuildLimitMaxLv(config.build_id)
if config.level-1>=maxLevel then
return false
end

local checkCND,data=zongmenControl:checkCondition(config,warning,sfId,retArgs)
if not checkCND then
if retArgs then
return false,data
else
return false
end
end

local check,itemId,itemCount=zongmenControl:checkEnough(config.uplevel_cost,warning,retArgs)
if not check then
if retArgs then
return false,{0,itemId,itemCount}
else
return false
end
end
return true,nil
end

function zongmenControl:getCanbuildCount(config)
local count
for i,v in ipairs(config.uplevel_cost)do
local itemId=v[1]
local needCount=v[2]
local have=0
if moneyConfig.isMoney(itemId)then
have=moneyModel.getMoney(itemId)
else
have=bagModel.getItemCountById(itemId)
end
local num=math.floor(have/needCount)
if count==nil then count=num end
count=math.min(count,num)
end
return count or 0
end

local _checkCndfunc=
{
[1]=function(sfId,cfg,v,warning,retArgs)
local level=zongmenModel:getLevel()
if level<v.param then
if warning then
UIManager.error(string.format('需要宗门达到%d级',v.param))
end
if retArgs then
return false,{v.type}
else
return false
end
end
return true
end,
[2]=function(sfId,cfg,v,warning,retArgs)
if not taskModel:checkTaskFinish(v.param)then
if warning then
UIManager.error(cfg.build_tips[2][2])
end
if retArgs then
return false,{v.type}
else
return false
end
end
return true
end,
[3]=function(sfId,cfg,v,warning,retArgs)
if v.param then
local cnd=v.param
local check,ncount=zongmenModel:checkBuildingWithCondition(sfId,cnd)
if not check then
if warning then
local bdcfg=cfgHelper.get1(cfg_monijybuildconfig_get,cnd[1])
if cnd[2]>1 then
UIManager.error(string.format('需要%s级%s<color=#db3f3f>%s</color>座',cnd[3],bdcfg.name,cnd[2]))
else
UIManager.error(string.format('需要%s等级达到<color=#db3f3f>%s级</color>',bdcfg.name,cnd[3]))
end
end
if retArgs then
return false,{v.type,cnd}
else
return false
end
end
end
return true
end,
[4]=function(sfId,cfg,v,warning,retArgs)
if v.param then
local cnd=v.param
local check=zheXianLingModel:checkFinish(cnd[1],cnd[2]or 0)
if not check then
if warning then
if cnd[2]and cnd[2]>0 then
UIManager.error(FMT.fmt("谪仙令第{0}章{1}节",cnd[1],cnd[2]))
else
UIManager.error(FMT.fmt("谪仙令第{0}章",cnd[1]))
end
end
if retArgs then
return false,{v.type}
else
return false
end
end
end
return true
end,
[5]=function(sfId,cfg,v,warning,retArgs)
if v.param>shiLianTaModel:getCurLayer()then
if warning then
UIManager.error(string.format('需要试练塔达到%d层',v.param))
end
if retArgs then
return false,{v.type}
else
return false
end
end
return true
end,
[6]=function(sfId,cfg,v,warning,retArgs)
if not systemModel.isOpen(v.param)then
if warning then
UIManager.error(systemModel.getOpenTips(v.param))
end
if retArgs then
return false,{v.type}
else
return false
end
end
return true
end,
[7]=function(sfId,cfg,v,warning,retArgs)
local level=yandaotaiModel:getTechnologyListLevel(v.param[1])or 0
if level<v.param[2]then
if warning then
local cfg=cfgHelper.get2(cfg_monijybuilduplvlconfig_get,v.param[1],v.param[2])
UIManager.error("需要衍道台的<color=#db3f3f>{0}</color>科技达到{1}级",cfg.name,v.param[2])
end
if retArgs then
return false,{v.type}
else
return false
end
end
return true
end,
[8]=function(sfId,cfg,v,warning,retArgs)

local _sfId=v.param[1]
local bdId=v.param[2]
local bdData=zongmenModel:getBuildingDataByBdId(_sfId,bdId)
if#bdData<=0 then
if warning then
UIManager.error("需要先修复{0}",cfg.name)
end
if retArgs then
return false,{v.type}
else
return false
end
end
return true
end,
}


function zongmenControl:checkCondition(config,warning,sfId,retArgs)
if config.uplevel_condition==nil then
if retArgs then
return false,{-1}
else
return false
end
end

local cfg=cfg_monijybuildconfig_get(config.build_id)
sfId=sfId or zongmenModel:getMountainId()
for i,v in ipairs(config.uplevel_condition)do
local ret,args=_checkCndfunc[v.type](sfId,cfg,v,warning,retArgs)
if not ret then
return ret,args
end
end

return true
end


function zongmenControl:getBuildConditionFinishCount(config,sfId)
local finishCount=0
local maxCndCount=0
if config.uplevel_condition==nil then
return 0,0
end
maxCndCount=#config.uplevel_condition
local level=zongmenModel:getLevel()
sfId=sfId or zongmenModel:getMountainId()
for i,v in ipairs(config.uplevel_condition)do
local isFinish=true
if v.type==1 and level<v.param then
isFinish=false
elseif v.type==2 and not taskModel:checkTaskFinish(v.param)then
isFinish=false
elseif v.type==3 and v.param then
local cnd=v.param
local check,ncount=zongmenModel:checkBuildingWithCondition(sfId,cnd)
if not check then
isFinish=false
end
elseif v.type==4 and v.param then
local cnd=v.param
local check=zheXianLingModel:checkFinish(cnd[1],cnd[2]or 0)
if not check then
isFinish=false
end
elseif v.type==5 and v.param>shiLianTaModel:getCurLayer()then
isFinish=false
elseif v.type==6 then
if not systemModel.isOpen(v.param)then
isFinish=false
end
end

if isFinish then
finishCount=finishCount+1
end
end

return finishCount,maxCndCount
end

function zongmenControl:checkEnough(costs,warning,retArgs)
for i,v in ipairs(costs)do
local itemId=v[1]
local itemCount=v[2]
if moneyConfig.isMoney(itemId)then
local have=moneyModel.getMoney(itemId)
if have<itemCount then
if warning then
moneySystem:useMoney(itemId,itemCount,nil,WARNING_TYPE.eWarning)
end
if retArgs then
return false,itemId,itemCount
else
return false
end
end
else
local have=bagModel.getItemCountById(itemId)
if have<itemCount then
if warning then
local name=itemsConfig.getItemName(itemId)
gainControl:showGainWin(itemId)
UIManager.error(string.format('需要%s个%s',itemCount,name))
end
if retArgs then
return false,itemId,itemCount
else
return false
end
end
end
end
return true
end


function zongmenControl:getPlantRewards(sfId,bdData)
local getRewardFunc=function()
zongmenControl:reqGetPlantRewardsEx(sfId,1,{bdData.un_build_id})
end
local result,errParam=self:checkWarehouse(bdData,true,getRewardFunc)
if result then



getRewardFunc()
else


end
return result
end


function zongmenControl:getNaturalRewards(sfId,bdData)
local getRewardFunc=function()
zongmenControl:reqNaturalPlant(sfId,bdData.un_build_id)
end
local result,errParam=self:checkWarehouse(bdData,true,getRewardFunc)
if result then


getRewardFunc()
else


end
return result
end

function zongmenControl:isNaturalRewardCanReceive(bdData)
if isometricMapSystem:isInLayoutMode()then
return false
end
local cfg=cfgHelper.get2(cfg_monijybuilduplvlconfig_get,bdData.build_id,bdData.level)
local beginTime=bdData.ncreateopentime
local curTime=gameUtilityModel.getServerShortTime()
local dtime=curTime-beginTime+bdData.ncreatetotaltimes
return dtime>cfg.normal_produce[1]
end

function zongmenControl:checkNaturalRewardPercent(bdData,percent)
local cfg=cfgHelper.get2(cfg_monijybuilduplvlconfig_get,bdData.build_id,bdData.level)
local beginTime=bdData.ncreateopentime
local curTime=gameUtilityModel.getServerShortTime()
local dtime=curTime-beginTime+bdData.ncreatetotaltimes
local rtime=cfg.normal_produce[1]
local cv=math.floor(dtime/rtime)*cfg.normal_produce.rewards[1][2]
local pv=cv/cfg.normal_produce.maxrewards[1][2]
return pv>=percent
end


function zongmenControl:checkWarehouse(bdData,isShowSolution,notSolutionCallback)
local config=cfgHelper.get2(cfg_monijybuilduplvlconfig_get,bdData.build_id,bdData.level)
if config then
local rewardId
local rewardCount
if config.normal_produce then
local rewards=config.normal_produce.rewards
if rewards then
rewardId=rewards[1][1]
local beginTime=bdData.ncreateopentime
local profitTime=config.normal_produce[1]
if beginTime>0 then
local curTime=gameUtilityModel.getServerShortTime()
local dtime=curTime-beginTime+bdData.ncreatetotaltimes
local dtimeS=math.floor(dtime/profitTime)*profitTime
local profit=rewards[1][2]/profitTime
rewardCount=math.floor(profit*dtimeS)
end
end
elseif config.produce_plans then
local plant=config.produce_plans[bdData.plant_id]
if plant and plant.rewards then
rewardId=plant.rewards[1][1]
local datas=zongmenControl:getPlanStepReward(bdData,true)
for i,v in ipairs(datas)do
local itemId=v[1]
if itemId==rewardId then
rewardCount=v[2]
break
end
end
end
end
if rewardId then
local limit=zongmenModel:getWarehouseLimit(rewardId)
if limit<0 then
return true
elseif limit==0 then
if isShowSolution then
cangkuFullSolutionController:showCangKuFullSolutionByItemList({{rewardId,rewardCount}},notSolutionCallback)
end
return false,{msg='请先建造仓库',item={rewardId,rewardCount}}
else
local have=moneyModel.getMoney(rewardId)
if have<limit then
return true
else
if isShowSolution then
cangkuFullSolutionController:showCangKuFullSolutionByItemList({{rewardId,rewardCount}},notSolutionCallback)
end
return false,{msg='仓库已满，请建造或升级仓库',item={rewardId,rewardCount}}
end
end
end
end
local errMsg=FMT.fmt('建筑生产配置异常:build_id={0}, level={1}',bdData.build_id,bdData.level)
logErr(errMsg)
return false,{msg=errMsg}
end

function zongmenControl:getPlantNeedTime(bdData,plantId)
plantId=plantId or bdData.plant_id
if plantId>0 then
local config=cfgHelper.get1(cfg_monijybuildconfig_get,bdData.build_id)
if config then
local plants=zongmenModel:getBuildingAllPlant(config.id,bdData.level)
if plants and plants[plantId]then
local plant_time=plants[plantId][1]
local time_percent=bdData.pcreatetimepercent/100+1
return math.floor(plant_time*time_percent)
end
end
end
return 0
end

function zongmenControl:fastManufacture(customize,top_type)
local list={}
local sfId=zongmenModel:getMountainId()
local datas=zongmenModel:getAllBuildingData(sfId)
for k,v in pairs(datas)do
local dzguidStr=v.dzIdStr
if v.flag==0 and v.plant_id==0 and dzguidStr~='0'then
local netData=UIDiscipleModel:getDiscipleDataByStr(dzguidStr)
if UIDiscipleModel:checkDZStateToDoSomethingByData(netData,eCheckDiscipleStateOpType.eProduce,false)then
local id=v.build_id
local cfg=cfgHelper.get1(cfg_monijybuildconfig_get,id)
if cfg.win_type==sysWinType.eFangAn then
zongmenModel:countManufacturePercent(v)
local lcfg=cfgHelper.get2(cfg_monijybuilduplvlconfig_get,id,v.level)
local plans=lcfg.produce_plans
local defId=0
local defTime=0
for ii,vv in ipairs(plans)do
local costs=vv.cost
local pass=true
for iii,vvv in ipairs(costs)do
local have=moneyModel.getMoney(vvv[1])
local need=math.ceil(vvv[2]*(1+v.pcreatesubpercent/100))
if have<need then
pass=false
break
end
end
if pass then
defId=ii
defTime=vv[1]
else
break
end
end
if defId>0 then
local maxId=defId
local cId=customize[v.un_build_id]
if cId then
defId=cId
if cId>0 then
defTime=plans[cId][1]
end
end
local sortId=cfg.id==top_type and 0 or cfg.id
table.insert(list,{data=v,cfg=cfg,lcfg=lcfg,maxId=maxId,
defId=defId,defTime=defTime,sortId=sortId})
end
end
end
end
end

local func=function(a,b)
local idA=a.sortId
local idB=b.sortId
if idA<idB then
return true
elseif idA==idB then
return a.defTime<b.defTime
else
return false
end
end
table.sort(list,func)

local lastMoney={}
local countMoney=function(cost)
local mtype=cost[1]
local num=cost[2]
local mv=moneyModel.getMoney(mtype)
local dv=lastMoney[mtype]or mv
dv=dv-num
lastMoney[mtype]=dv
return dv
end

local topTypes={}
for i,v in ipairs(list)do
local plan=v.lcfg.produce_plans[v.defId]
local need={}
if plan then
for ii,vv in ipairs(plan.cost)do
local last=countMoney(vv)
if last<0 then
need[vv[1]]=-last
end
end
end
v.need=need
topTypes[v.cfg.id]=true
end

local topList={}
for k,v in pairs(topTypes)do
table.insert(topList,k)
end

table.sort(topList,function(a,b)
return a<b
end)

return list,topList
end

function zongmenControl:fastManufactureSingleBdId(ubdId,customize,top_type)
local list={}
local v=zongmenModel:getBuildingData(ubdId)
local dzguidStr=v.dzIdStr
if v.flag==0 and v.plant_id==0 and dzguidStr~='0'then
local netData=UIDiscipleModel:getDiscipleDataByStr(dzguidStr)
if UIDiscipleModel:checkDZStateToDoSomethingByData(netData,eCheckDiscipleStateOpType.eProduce,false)then
local id=v.build_id
local cfg=cfgHelper.get1(cfg_monijybuildconfig_get,id)
if cfg.win_type==sysWinType.eFangAn then
zongmenModel:countManufacturePercent(v)
local lcfg=cfgHelper.get2(cfg_monijybuilduplvlconfig_get,id,v.level)
local plans=lcfg.produce_plans
local defId=0
local defTime=0
for ii,vv in ipairs(plans)do
local costs=vv.cost
local pass=true
for iii,vvv in ipairs(costs)do
local have=moneyModel.getMoney(vvv[1])
local need=math.ceil(vvv[2]*(1+v.pcreatesubpercent/100))
if have<need then
pass=false
break
end
end
if pass then
defId=ii
defTime=vv[1]
else
break
end
end
if defId>0 then
local maxId=defId
local cId=customize[v.un_build_id]
if cId then
defId=cId
if cId>0 then
defTime=plans[cId][1]
end
end
local sortId=cfg.id==top_type and 0 or cfg.id
table.insert(list,{data=v,cfg=cfg,lcfg=lcfg,maxId=maxId,
defId=defId,defTime=defTime,sortId=sortId})
end
end
end
end

if list and next(list)then
local func=function(a,b)
local idA=a.sortId
local idB=b.sortId
if idA<idB then
return true
elseif idA==idB then
return a.defTime<b.defTime
else
return false
end
end
table.sort(list,func)
end

local lastMoney={}
local countMoney=function(cost)
local mtype=cost[1]
local num=cost[2]
local mv=moneyModel.getMoney(mtype)
local dv=lastMoney[mtype]or mv
dv=dv-num
lastMoney[mtype]=dv
return dv
end

local topTypes={}
for i,v in ipairs(list)do
local plan=v.lcfg.produce_plans[v.defId]
local need={}
if plan then
for ii,vv in ipairs(plan.cost)do
local last=countMoney(vv)
if last<0 then
need[vv[1]]=-last
end
end
end
v.need=need
topTypes[v.cfg.id]=true
end

local topList={}
for k,v in pairs(topTypes)do
table.insert(topList,k)
end

if list and next(topList)then
table.sort(topList,function(a,b)
return a<b
end)
end
return list,topList
end

function zongmenControl:receiveAllManufacture(hudData)
local flag=false
local htype=hudData.type
if htype==hudType.plan or htype==hudType.natural then
local sfId=zongmenModel:getMountainId()
local datas=zongmenModel:getAllBuildingData(sfId)
local playAudioType=nil
for k,v in pairs(datas)do
local data=hudControl:getProgressData(v.un_build_id)
if data and(v.plant_id>0 or data.type==hudType.natural)then
if data.complete then
local flag1=hudControl:receiveReward(data)
if flag1 then
if not playAudioType then

playAudioType=data.bdData.build_id
else
if playAudioType~=data.bdData.build_id then

playAudioType=0
end
end
end
flag=flag or flag1
end
end
end
self:playAudio(playAudioType)
else
flag=hudControl:receiveReward(hudData)
end
return flag
end

function zongmenControl:playAudio(playAudioType)
if playAudioType then
if playAudioType==0 then


AudioManager.playAudio(449)
elseif playAudioType==2 then


AudioManager.playAudio(437)
elseif playAudioType==3 then


AudioManager.playAudio(439)
elseif playAudioType==7 then


AudioManager.playAudio(446)
elseif playAudioType==8 then


AudioManager.playAudio(443)
end
end
end

function zongmenControl:receiveAllManufactureEx(bdData)
local select_un_build_id=bdData and bdData.un_build_id or nil
local sfId=zongmenModel:getMountainId()
local datas=zongmenModel:getAllBuildingData(sfId)
local reqList={{},{}}

local playAudioType
local reqCount=0
local cangKuFullData
for k,v in pairs(datas)do
local wtype=cfgHelper.get2(cfg_monijybuildconfig_get,v.build_id,'win_type')
local list=reqList[wtype]
local canReceive=false
if wtype==1 then
canReceive=buildingCDControl:isCanReceive(buildingCDType.plan,v.un_build_id)
elseif wtype==2 then
canReceive=buildingCDControl:isCanReceive(buildingCDType.natural,v.un_build_id)
end
if canReceive then
local result,errParam=self:checkWarehouse(v)
if result then
if select_un_build_id and select_un_build_id==v.un_build_id then
_insert(list,1,v.un_build_id)
else
_insert(list,v.un_build_id)
end
playAudioType=v.build_id
reqCount=reqCount+1
else


local item=errParam.item
if item then
local itemId=item[1]
local itemCount=item[2]
local ubdId=v.un_build_id
if not cangKuFullData then
cangKuFullData={}
cangKuFullData.itemList={}
cangKuFullData.ubdIdList={}
end
if not cangKuFullData.ubdIdList[wtype]then
cangKuFullData.ubdIdList[wtype]={}
end
if cangKuFullData.itemList[itemId]then
cangKuFullData.itemList[itemId]=cangKuFullData.itemList[itemId]+itemCount
else
cangKuFullData.itemList[itemId]=itemCount
end
table.insert(cangKuFullData.ubdIdList[wtype],ubdId)
end
end
end
















end
local rdatas=reqList[1]
local len=#rdatas
if len>0 then
zongmenControl:reqGetPlantRewardsEx(sfId,len,rdatas)
end
rdatas=reqList[2]
for i,v in ipairs(rdatas)do
local bdData=zongmenModel:getBuildingData(v)
zongmenControl:getNaturalRewards(sfId,bdData)
end










if reqCount>1 then
playAudioType=0
end

self:playAudio(playAudioType)

if cangKuFullData then
local itemList={}
for itemId,itemCount in pairs(cangKuFullData.itemList)do
itemList[#itemList+1]={itemId,itemCount}
end
local ubdIdList=cangKuFullData.ubdIdList
local notSolutionCallback=function()
local playAudioType_callback
local ubdIdListCount_1=ubdIdList[1]and#ubdIdList[1]or 0
local ubdIdListCount_2=ubdIdList[2]and#ubdIdList[2]or 0
if ubdIdListCount_1>0 then
for i,v in ipairs(ubdIdList[1])do
local bdData=zongmenModel:getBuildingData(v)
playAudioType_callback=bdData.build_id
end
zongmenControl:reqGetPlantRewardsEx(sfId,#ubdIdList[1],ubdIdList[1])
end
if ubdIdListCount_2>0 then
for i,v in ipairs(ubdIdList[2])do
local bdData=zongmenModel:getBuildingData(v)
zongmenControl:getNaturalRewards(sfId,bdData)
playAudioType_callback=v.build_id
end
end
if ubdIdListCount_1+ubdIdListCount_2>1 then
playAudioType_callback=0
end
zongmenControl:playAudio(playAudioType_callback)
end
cangkuFullSolutionController:showCangKuFullSolutionByItemList(itemList,notSolutionCallback)
end

return reqCount>0
end

function zongmenControl:countLikeDatas(cfgs)
local datas={}
for i,v in ipairs(cfgs)do
datas[v.id]=0
end

local cfg=cfgHelper.get1(cfg_shangpubasicconfig_get,1)
local likeData=cfg.voc_max_like

local discipleDatas=UIDiscipleModel:getAllDiscipleData()
for k,v in pairs(discipleDatas)do
local info=UIDiscipleModel:getDiscipleImageInfo(k)
local job=info.job
local id=likeData[job]
if id then
local count=datas[id]or 0
datas[id]=count+1
end
end

return datas
end

function zongmenControl:countLikeDatasByShopId(ShopId)
local sum=0
local cfg=cfgHelper.get1(cfg_shangpubasicconfig_get,1)
local likeData=cfg.voc_max_like

local discipleDatas=UIDiscipleModel:getAllDiscipleData()
for k,v in pairs(discipleDatas)do
local info=UIDiscipleModel:getDiscipleImageInfo(k)
local job=info.job
local id=likeData[job]
if id==ShopId then
sum=sum+1
end
end
return sum
end



function zongmenControl:setDiscipleState(bdData,state,bclear)
if tostring(bdData.dizi_id)~='0'then
UIDiscipleModel:setDiscipleStateData(bdData.dizi_id,state,bclear and nil or{buildingId=bdData.build_id})
end
end

function zongmenControl:getBuildingArgs(args)

local buildid=args.type
local openMountid=args.openMountid
local mountIdList={}
if args.mountid then
mountIdList={args.mountid}
elseif buildid then
mountIdList=zongmenModel:getMountainIdListByBdType(buildid)
else
local mountid=zongmenModel:getMountainId()
mountIdList={mountid}
end
return mountIdList,buildid,openMountid
end

function zongmenControl:isBuildingCanUse(data,getTips)
local config=cfgHelper.get1(cfg_monijybuildconfig_get,data.build_id)
if not config then
logErr('未找到建筑配置',data.build_id)
return false
end

local ftype=zongmenModel:getBDFlagType(data.flag)
if not data.isLinkRoad and config.is_connect_road==1 and ftype==bdFlagType.normal then
if getTips then
local tips="建筑未连接道路"
return false,tips
else
return false
end
end

local isBuild=ftype==bdFlagType.build or ftype==bdFlagType.sectionBuildStart or ftype==bdFlagType.sectionBuildComplete
if isBuild then
if getTips then
local tips="建筑正在建造中"
return false,tips
else
return false
end
end

if emergenciesControl:isBuildingOnFire(data.entityId)then
if getTips then
local tips="着火状态无法使用"
return false,tips
else
return false
end
end

if emergenciesModel:isInRepairTime(data.un_build_id)then
if getTips then
local tips="修复中无法使用"
return false,tips
else
return false
end
end

if emergenciesModel:isCreeper(data.un_build_id)then
if getTips then
local tips="缠绕中无法使用"
return false,tips
else
return false
end
end

if jctjDuJieXianDanModel:isInRepairTime(data.un_build_id)then
local currtime=gameUtilityModel.getServerShortTime()
local endtime=jctjDuJieXianDanModel:getRepairTime(data.un_build_id)
if getTips then
return false,FMT.fmt('丹炉被天劫损毁，正在修复中（{0})',timeHelper.format_time_stamp(endtime-currtime,true))
else
return false
end
end

local check,least=UIDanYaoModel:checkZhaLu(data.un_build_id,DANYAO_ZHALU_SEASON.eDiscipleSpecial)
if check then
if getTips then
return false,FMT.fmt('丹炉已损毁，正在修复中（{0})',timeHelper.format_time_stamp(least,true))
else
return false
end
end

return true
end

function zongmenControl:getBuilding(args,isIncludeCantUse)

local mountIdList,buildid,openMountid=zongmenControl:getBuildingArgs(args)
local mountid
local un_build_id=nil
if args.args~=nil then
un_build_id=args.args.un_build_id
end
local data
if un_build_id then
local bdData=zongmenModel:getBuildingData(un_build_id)
if bdData and(isIncludeCantUse or zongmenControl:isBuildingCanUse(bdData))then
data=bdData
end
mountid=zongmenModel:getBuildingLocationMapId(un_build_id)
else
local cfg=cfgHelper.get1(cfg_monijybuildconfig_get,buildid)
local max_pro_skill_lv=-1
local isCheckProSkill=cfg.pro_skill_id~=nil
if isCheckProSkill then
for i,sfId in ipairs(mountIdList)do
local datas=zongmenModel:getAllBuildingData(sfId)
for k,v in pairs(datas)do
if v.build_id==buildid and(isIncludeCantUse or zongmenControl:isBuildingCanUse(v))then


local bdData=v
local diziguid=bdData.dizi_id
diziguid=tostring(diziguid)=='0'and 0 or diziguid
local level=diziguid~=0 and UIDiscipleModel:getDiscipleJobLevel(diziguid,cfg.pro_skill_id)or 0
if max_pro_skill_lv<level then
data=v
mountid=sfId
max_pro_skill_lv=level
end
end
end
end
else
for i,sfId in ipairs(mountIdList)do
local datas=zongmenModel:getAllBuildingData(sfId)
for k,v in pairs(datas)do
if v.build_id==buildid and(isIncludeCantUse or zongmenControl:isBuildingCanUse(v))then
data=v
mountid=sfId
break
end
end
if data then
break
end
end
end
end
return data,mountid or mountIdList[1],buildid,openMountid
end

function zongmenControl:jumpBuildingWin(args)
local data,mountid,buildid=zongmenControl:getBuilding(args)

local un_build_id=nil
if args.args~=nil then
un_build_id=args.args.un_build_id
end
if data then
local argstable=args.args or{}
argstable.isjump=true
argstable.tabType=args.tabType
local nowMountainId=zongmenModel:getMountainId()
if mountid and mountid==nowMountainId then
isometricMapSystem:openBuildingWin(data,argstable)
else

if not mountainControl:isOpen(mountid,true)then
return false
end
mountainControl:loadAndswitchMapEx(mountid,true,function()
isometricMapSystem:openBuildingWin(data,argstable)
end)
end

return true
else

if un_build_id then

local bdData=zongmenModel:getBuildingData(un_build_id)
local _,tips=zongmenControl:isBuildingCanUse(bdData,true)
UIManager.error(tips)
return false
else

local cannotUseData,cannotUseMountId=zongmenControl:getBuilding(args,true)
local isDifferentMountain=false
if cannotUseData and cannotUseMountId then
local nowMountainId=zongmenModel:getMountainId()
isDifferentMountain=nowMountainId~=cannotUseMountId
end
if isDifferentMountain then

if not mountainControl:isOpen(mountid,true)then
return false
end
return mountainControl:loadAndswitchMapEx(mountid,true,function()
return zongmenControl:jumpBuildingWin(args)
end)
end


local cfg=cfgHelper.get1(cfg_monijybuildconfig_get,buildid)
local mapId=args.mapId or mountid or zongmenModel:getMountainId()
local isOpenRepairWin=args.isOpenRepairWin
if isOpenRepairWin then
fullScreenUI.closeActiveUI(true)

local func=function(flag,pos,backParams)

if flag then
local guid=backParams.guid
local inUnlockArea=isometricMapSystem:isInUnlockArea(guid)
if isometricMapSystem:checkTouchRepairBuilding(guid,inUnlockArea)then
elseif isometricMapSystem:checkTouchBuilding(guid)then
end
end
end
cameraMoveController:Begin({eSceneType.eZongmen,mapId},{cameraMoveTargetType.eZongmeng_build8,buildid},func)
return true
end

local rdata=isometricMapSystem:getUnlockRepairDataByID(mapId,buildid)
if rdata then
if emergenciesModel:checkBuildingCreeper(buildid)then
UIManager.info('缠绕中无法使用')
else
local pass,tips=zongmenControl:checkBuildingPassRepairCondition(buildid)
if not pass then
UIManager.error(tips)
return false
end

UIManager.error(FMT.fmt('请先修复{0}',cfg.name))
end
else


local needSys=cfg.build_system
if needSys and not systemModel.isOpen(needSys)then
local errStr=cfg.build_tips and cfg.build_tips[1]and cfg.build_tips[1][2]
UIManager.error(errStr)
return false
end


local pass,tips=zongmenControl:checkBuildingPassRepairCondition(buildid)
if not pass then
UIManager.error(tips)
return false
end


local level=zongmenModel:getLevel()
local minNeedLevel=zongmenControl:getMinNeedLevel(cfg,mapId)
if level<minNeedLevel then
UIManager.error(FMT.fmt("达到宗门{0}级后开启",minNeedLevel))
return false
end


local bdData=zongmenControl:getBuilding(args,true)
if bdData then
local _,errTips=zongmenControl:isBuildingCanUse(bdData,true)
UIManager.error(errTips)
return false
end

local func=function()


UIManager.error(FMT.fmt('尚未建造{0}',cfg.name))

local sortType=cfg.func_type
local jumpArgs={model=1,sortType=sortType,bdId=buildid}
isometricMapSystem:enterLayoutModel(jumpArgs)
end
if mountid then
local nowMountainId=zongmenModel:getMountainId()
if mountid and mountid==nowMountainId then
func()
else

if not mountainControl:isOpen(mountid,true)then
return false
end
mountainControl:loadAndswitchMapEx(mountid,true,function()
func()
end)
end
else
func()
end
return false,true
end
end
return false
end
end

function zongmenControl:openFangsheBuild(args)
local level=args.level
local data=zongmenControl:getOneBuild(SLG_SYSTEM_TYPE.eDuoRen,level)
if data then
isometricMapSystem:openBuildingWin(data)
return true
else
local cfg=cfgHelper.get1(cfg_monijybuildconfig_get,buildid)
UIManager.error(FMT.fmt('尚未建造{0}',cfg.name))
return false
end
end

function zongmenControl:getOneBuild(buildType,level)
local datas=zongmenModel:getAllBuildingData(zongmenModel:getMountainId())
local data
for k,v in pairs(datas)do
if v.build_id==buildType then
if level then
if v.level==level then
data=v
break
end
else
data=v
break
end
end
end
return data
end



function zongmenControl:setZongmenTipsFlag(ftype,flag)
self.zongmenTipsFlags[ftype]=flag
end

function zongmenControl:getZongmenTipsFlag(ftype)
return self.zongmenTipsFlags[ftype]or false
end


function zongmenControl:showPlanReward(sfId,ubdId,rwlist)
local bdData=zongmenModel:getBuildingData(ubdId)
if not rwlist then













rwlist=zongmenControl:getPlanStepReward(bdData,true)
end
if#rwlist==0 then return end
local offset=Vector3(0,1,0)
local posArr=_MapManager.GetObjectPlacePosValue(bdData.entityId)
isometricMapSystem:showStillSundriesRewardHud(sfId,posArr[1],posArr[2],rwlist,offset)
end

function zongmenControl:getZhenYanCount(bdId,is_main)
local tcfg
if is_main then
tcfg=cfgHelper.get1(cfg_monijybuildconfig_get,bdId)
else
local cfg=cfgHelper.get1(cfg_monijybuildconfig_get,bdId)
tcfg=cfgHelper.get1(cfg_monijybuildconfig_get,cfg.related)
end
local datas=tcfg.repair_build
local rlist={}
for i,v in ipairs(datas)do
rlist[v[1]]={0,v[2]}
end
local allBD=zongmenModel:getAllBuildingData(zongmenModel:getMountainId())
for k,v in pairs(allBD)do
for kk,vv in pairs(rlist)do
if v.build_id==kk then
vv[1]=vv[1]+1
end
end
end
local allRP=isometricMapSystem:getAllRepairData()
for k,v in pairs(allRP)do
for kk,vv in pairs(rlist)do
if v.id==kk then
vv[1]=vv[1]+1
end
end
end
local c1=0
local c2=0
for k,v in pairs(rlist)do
c1=c1+v[1]
c2=c2+v[2]
end
return c2-c1,c2
end

function zongmenControl:zhenYanJieChu(mapId,bdData)
local cfg=cfgHelper.get1(cfg_monijybuildconfig_get,bdData.build_id)
local data=isometricMapSystem:getRepairDataByID(mapId,cfg.related)
hudControl:refreshBuildingStatusHUD(data.rpId)
end

function zongmenControl:triggerBuildingEvent(htype,triggerData,initData)
if not triggerData then
return
end

local data=triggerData[htype]
if not data then
return
end

local ttype=data[1]
if ttype==1 then
storyAIManager:startStoryBehavior(data[2],initData)
end
end

function zongmenControl:playSmallGame(gtype,args,callback,startCallback)
args=args or{}
UILittleGameController:openLittleGame(gtype,args,callback,startCallback)
end

function zongmenControl:checkShowFuncStorageWin()

local data=emergenciesControl:getSettlementData()
if data then
return true
end

local check=systemModel.isOpen(SYSTEM_DEFINE.eJianZhuTiShi)
if check then
return true
end

check=worldFightRecordController.enoughOpenDialogueConditon()
if check then
return true
end

check=eventOptionControl.needOption()or shanmenModel:hasBaiShanDZ()
if check then
return true
end

check=systemModel.isOpen(SYSTEM_DEFINE.eYouJian)and mailModel:checkReddot()
if check then
return true
end


if systemModel.isOpen(SYSTEM_DEFINE.eXiTongZongMenZhanDou)then

check=systemZongMenModel:isExistFightFlags({systemZongMenFightFlagType.eBeAttacked,systemZongMenFightFlagType.eAttacking})
if check then
return true
end

check=systemZongMenModel:haveSGReward()
if check then
return true
end
end

return false
end

function zongmenControl:getPlanStepReward(bdData,isCurrent)
local cddata=buildingCDControl:getCDData(buildingCDType.plan,bdData.un_build_id)
if cddata==nil then return defaultT end
local planDatas=cddata.planDatas
local finishStep=cddata.finishStep

local start=isCurrent and(bdData.hasExNum+1)or 1

local rlist={}
for i=start,finishStep do
local v=planDatas[i]
local rt=v.stepReward[1]
local rc=rlist[rt]or 0
rc=rc+v.stepReward[2]
rlist[rt]=rc

if v.specialty then
for ii,vv in ipairs(v.specialty)do
local sc=rlist[vv[1]]or 0
sc=sc+vv[2]
rlist[vv[1]]=sc
end
end
end

local slist={}
for k,v in pairs(rlist)do
local cfg=itemsConfig.getConfig(k)
table.insert(slist,{k,v,color=cfg.color})
end

table.sort(slist,function(a,b)
return a.color>b.color
end)

return slist
end

function zongmenControl:getPlanTimeRemaining(bdData)
local cddata=buildingCDControl:getCDData(buildingCDType.plan,bdData.un_build_id)
local planDatas=cddata.planDatas
local step=cddata.currStep+1
local len=#planDatas
local count=0
for i=step,len do
local pd=planDatas[i]
count=count+pd.stepTime
end
count=count+cddata.stepCD

return count
end

function zongmenControl:getRewardConfigData(rwId,val)
local rcfg=cfgHelper.get1(cfg_awardconfig_get,rwId)
if not rcfg then
logErr('无法读取奖励配置，id：',rwId)
return nil
end
if not rcfg.groupInfo then
return rcfg.showItems
end
local gcfg=cfgHelper.get1(cfg_awardgroupconfig_get,rcfg.groupInfo[1])
if not gcfg then
logErr('无法读取自适应组配置，id：',rwId)
return nil
end
local tId
for i,v in ipairs(gcfg.groupInfo)do
if val>=v[1]and val<=v[2]then
tId=v[3]
break
end
end
local tcfg=cfgHelper.get1(cfg_awardconfig_get,tId)
if not tcfg then
logErr('无法读取奖励配置，id：',tcfg)
return nil
end
return tcfg.showItems
end

function zongmenControl:getQuickUseItems(mtype)
local cfg=itemsConfig.getConfig(mtype)
if not cfg.quickUse then
return nil
end
local filter={}
filter[ITEM_FILTER_TYPE.eItemid]={ITEM_FILTER_COMPARE.eEquals,cfg.quickUse}
local items=bagControl.getBagItemsByFilter(BAG_TYPE.eItemBag,filter)
return items
end

function zongmenControl:playUnlockAreaPlot(id)
local cfg=cfg_monijyareaconfig_get(id)
local screenParams=cfg.screenParams
local targetParams=cfg.targetParams
local params=cfg.playplot
if params==nil then return end
local plot_type=params[1]
local plot_name=params[2]
local isBehavier=plot_type==1
local check=true
if isBehavier then
check=zongmenControl:checkAreaPlot(plot_name)
end
if check then
local callBack=function(flag_)
if flag_ then
local flag=gameplotController.activePlot(params)
if flag and isBehavier then
zongmenControl:setAreaPlot(plot_name)
end
end
end
if screenParams~=nil then
cameraMoveController:Begin(screenParams,targetParams,callBack)
else
callBack(true)
end
return true
end
end

function zongmenControl:checkAreaPlot(plot_name)
local marklist=userActorSetting.get('zmAreaPlot',{})
if marklist[plot_name]~=nil then
return false
end
return true
end

function zongmenControl:setAreaPlot(plot_name)
local marklist=userActorSetting.get('zmAreaPlot',{})
marklist[plot_name]=true
userActorSetting.flushVal('zmAreaPlot',marklist,{})
end

function zongmenControl.onItemListChanged(argsTable)
for i,v in ipairs(argsTable)do
local changeType=v[1]
local itemid=v[3]
local lastcount=v[4]
local count=v[5]
if changeType~=CHANGE_TYPE.eDelete and count>lastcount then
zongmenControl.tryActiveBuild(itemid)
zongmenControl.tryActiveRoad(itemid)
end
end
end

function zongmenControl.onMoneyChanged(moneyType,oldVal,newVal)
if moneyType==eMoneyType.mtSectScore then

notifySystem:postNotify(notifyConfig.onActTabReddotChange,SUBACT_DEFINETAB_TYPE.eZongMenDaBi_score)
end
end

function zongmenControl.tryActiveBuild(itemid)
local list=isometricMapSystem:getActiveBuildList(itemid)
if list==nil or#list==0 then return end
local num=bagModel.getItemCountById(itemid)
local i=0
while num>0 do
i=i+1
local bdid=list[i]
if bdid==nil then break end
if num<=0 then break end
num=num-1
socketManager:send_3_48(bdid)
end
end

function zongmenControl.initActiveBuild()
local lookup=bagModel.getAllItems()
local temp={}
for itemid,_ in pairs(lookup)do
if temp[itemid]==nil then
temp[itemid]=true
zongmenControl.tryActiveBuild(itemid)
end
end
end

function zongmenControl.tryActiveRoad(itemid)
local list=isometricMapSystem:getActiveRoadList(itemid)
if list==nil or#list==0 then return end
local num=bagModel.getItemCountById(itemid)
local i=0
while num>0 do
i=i+1
local id=list[i]
if id==nil then break end
if num<=0 then break end
num=num-1
socketManager:send_3_53(id)
end
end

function zongmenControl.initActiveRoad()
local lookup=bagModel.getAllItems()
local temp={}
for itemid,_ in pairs(lookup)do
if temp[itemid]==nil then
temp[itemid]=true
zongmenControl.tryActiveRoad(itemid)
end
end
end

function zongmenControl:checkAndUseMatItem(itemList,callback)
local countList={}
local retlist={}
for i,v in ipairs(itemList)do
local itemId=v[1]
local itemCount=v[2]
local cfg=itemsConfig.getConfig(itemId)
local gain=cfg.gain
local mtype=gain[1]
local mcount=gain[2]
if moneyConfig.isMoney(mtype)then
local limit=zongmenModel:getWarehouseLimit(mtype)
if not limit or limit<0 then

limit=moneyModel.getMoneyMax(mtype)or-1
end

local have=moneyModel.getMoney(mtype)
local count=countList[mtype]or 0
local rcount=count+mcount*itemCount
countList[mtype]=rcount
if limit>0 and have+rcount>=limit then
local dis=limit-have-count
local rc=math.ceil(dis/mcount)
rc=math.min(rc,itemCount)
rc=math.max(rc,1)
retlist[i]={v[1],rc}
local tips
if have>=limit then
tips='{0}已达到储存上限，是否确定使用？'
else
tips='使用后{0}将达到储存上限，是否确定？'
end
local content=FMT.fmt(tips,moneyModel.getMoneyName(mtype))
self:showDialog(content,function()


if not moneyModel.checkMoneyOverflow(mtype,mcount*itemCount)then
callback(retlist)
end
end)
return
else
retlist[i]=v
end
end
end
callback(retlist)
end

function zongmenControl:showDialog(content,onOK)
local showdata=
{
type='UIDialouge',
title='提示',
content=content,
oktext='确定',
canceltext=onOK and'取消'or nil,
allowclickBG='false',
okcallback=onOK,
showclosebtn=true,
}
local comfirmDialog=UIDialogManager.newDialog(showdata)
comfirmDialog:show()
end



function zongmenControl:useWuFangSpeedUpFu(itemId)
local funcparam=itemsConfig.getConfig(itemId).funcparam
if not funcparam then
logErr(FMT.fmt("找不到道具Id为{0} 的功能参数配置 请检查配置是否正确",itemId))
return
end

local sfId=mapIdType.zhufeng
local buildIdList=funcparam.build
local buildTypeList=funcparam.build_type
local time=funcparam.time

local list={}
local listLookUp={}
if buildIdList then

for bdId,v in pairs(buildIdList)do
local bdDataList=zongmenModel:getBuildingDataByBdId(sfId,bdId)
local buildCfg=cfgHelper.get1(cfg_monijybuildconfig_get,bdId)
local bdType=buildCfg and buildCfg.build_type or nil
if bdId==SLG_SYSTEM_TYPE.eLianDanFang then

for i,bdData in ipairs(bdDataList)do
local ubdIdStr=tostring(bdData.un_build_id)
if not listLookUp[ubdIdStr]then
local liandanCd=buildingCDControl:getCD(buildingCDType.liandan,bdData.un_build_id)
if liandanCd and liandanCd>0 then
list[#list+1]={1,bdData}
listLookUp[ubdIdStr]=true
end
end

end
elseif bdType and bdType==24 then

for i,bdData in ipairs(bdDataList)do
local ubdIdStr=tostring(bdData.un_build_id)
if not listLookUp[ubdIdStr]then
local planCd=buildingCDControl:getCD(buildingCDType.shangpu,bdData.un_build_id)
if planCd and planCd>0 then
list[#list+1]={3,bdData}
listLookUp[ubdIdStr]=true
end
end
end
else

for i,bdData in ipairs(bdDataList)do
local ubdIdStr=tostring(bdData.un_build_id)
if not listLookUp[ubdIdStr]then
local planCd=buildingCDControl:getCD(buildingCDType.plan,bdData.un_build_id)
if planCd and planCd>0 then
list[#list+1]={2,bdData}
listLookUp[ubdIdStr]=true
end
end
end
end
end
end

if buildTypeList then

for bdType,v in pairs(buildTypeList)do
local bdDataList=zongmenModel:getBuildingDataByBdType(sfId,bdType)
if bdType==6 then

for i,bdData in ipairs(bdDataList)do
local ubdIdStr=tostring(bdData.un_build_id)
if not listLookUp[ubdIdStr]then
local liandanCd=buildingCDControl:getCD(buildingCDType.liandan,bdData.un_build_id)
if liandanCd and liandanCd>0 then
list[#list+1]={1,bdData}
listLookUp[ubdIdStr]=true
end
end
end
elseif bdType==24 then

for i,bdData in ipairs(bdDataList)do
local ubdIdStr=tostring(bdData.un_build_id)
if not listLookUp[ubdIdStr]then
local planCd=buildingCDControl:getCD(buildingCDType.shangpu,bdData.un_build_id)
if planCd and planCd>0 then
list[#list+1]={3,bdData}
listLookUp[ubdIdStr]=true
end
end
end
else

for i,bdData in ipairs(bdDataList)do
local ubdIdStr=tostring(bdData.un_build_id)
if not listLookUp[ubdIdStr]then
local planCd=buildingCDControl:getCD(buildingCDType.plan,bdData.un_build_id)
if planCd and planCd>0 then
list[#list+1]={2,bdData}
listLookUp[ubdIdStr]=true
end
end
end
end
end
end

local func=function(data)
local typo=data[1]
local bdData=data[2]
if typo==1 then

UIDanYaoModel:update_data_time_by_speedup(sfId,bdData.un_build_id,time)


buildingCDControl:addCDData(buildingCDType.liandan,bdData)
hudControl:refreshBuildingStatusHUD(bdData.un_build_id)
elseif typo==3 then
UIShopModel:setProductSpeedupTime(bdData.un_build_id,time)

buildingCDControl:updateCDData(buildingCDType.shangpu,bdData.un_build_id)
UIManager:invokeUIMethod("UIShopProductionWin","refreshRightPanel")
else
zongmenModel:setProductSpeedupTime(sfId,bdData.un_build_id,time)
buildingCDControl:setSpeedUp(bdData.un_build_id,speedUpType.eExecutePlant)
local args={ignorePlayAudio=true}
notifySystem:postNotify(notifyConfig.building_event,buildingEvent.speedUpComplete,sfId,bdData.un_build_id,args)
end
end
local titleTable=cfgHelper.get2(cfg_onekeyguoduconfig_get,1,'desc')
local range=math.random(1,#titleTable)
zongmenControl:dothingSlow(func,list,function()
AudioManager.playAudio(312)
UIManager:closeWindow("UICommonLoadingWin")
end,titleTable[range])
end

local _checkFreeManufacture=
{
[buildingEvent.buildStart]=true,
[buildingEvent.buildComplete]=true,
[buildingEvent.levelUpStart]=true,
[buildingEvent.levelUpComplete]=true,
[buildingEvent.planStart]=true,
[buildingEvent.planComplete]=true,
[buildingEvent.planCancel]=true,
[buildingEvent.speedUpComplete]=true,
[buildingEvent.storageBuilding]=true,
[buildingEvent.removeBuilding]=true,
}

function zongmenControl.on_building_event(etype,sfId,ubdId,arg1,arg2)
if sfId~=mapIdType.zhufeng then
return
end




if _checkFreeManufacture[etype]then
zongmenModel:setFreeManufactureBuildingByUbdId(ubdId)
elseif etype==buildingEvent.replaceDisciple then
zongmenModel:checkFreeManufactureBuildingDzStateByUbdId(ubdId)
UIManager:invokeUIMethod('UIXiaoDaoTongMainWin','refreshMenuReddot',1)
UIManager:invokeUIMethod('UIFastManagerWin','refreshManufacturePanelReddot')
end
end


function zongmenControl.onDiscipleStateChange(discipleguid,stateType,old,cur)
zongmenControl:checkFreeManufactureBdDzStateByDzGuid(discipleguid)
end


function zongmenControl.onDiscipleLoyaltyChange(guid,oldValue,newValue)
zongmenControl:checkFreeManufactureBdDzStateByDzGuid(guid)
end


function zongmenControl.onDiscipleInjuryChange(guid,oldInjury,injury)
zongmenControl:checkFreeManufactureBdDzStateByDzGuid(guid)
end


function zongmenControl.onDiscipleShouYuanChange(guid,old,shouyuan)
zongmenControl:checkFreeManufactureBdDzStateByDzGuid(guid)
end

function zongmenControl:checkFreeManufactureBdDzStateByDzGuid(guid)

local bdData=zongmenModel:getDiscipleWorkroom(guid)
if bdData then
local ubdId=bdData.un_build_id
if zongmenModel:checkFreeManufactureBuildingListHasUbdId(ubdId)then
zongmenModel:checkFreeManufactureBuildingDzStateByUbdId(ubdId)
UIManager:invokeUIMethod('UIXiaoDaoTongMainWin','refreshMenuReddot',1)
UIManager:invokeUIMethod('UIFastManagerWin','refreshManufacturePanelReddot')
end
end
end

function zongmenControl:isRequireBuilding(b_type)
local args={type=b_type}
local data,mountid,buildid=zongmenControl:getBuilding(args,true)
return data~=nil
end




function zongmenControl:getSpeedUpItemAutoSelectList(itemList,allTime)
if not itemList or not next(itemList)then
return
end


local sortList=table.weakCopy(itemList)
table.sort(sortList,function(a,b)
if a[3]==b[3]then
local price_a=a[4]or 0
local price_b=b[4]or 0
return price_a>price_b
else
return a[3]>b[3]
end
end)

local selectList={}
local overSelect={}
local remainingTime=allTime
local isFinish=false
for _,item in ipairs(sortList)do
local itemId=item[1]
local itemCount=item[2]
local itemTime=item[3]
local selectCount=0
if itemCount*itemTime>remainingTime then
selectCount=math.floor(remainingTime/itemTime)
else
selectCount=itemCount
end
selectList[itemId]=selectCount
remainingTime=remainingTime-selectCount*itemTime
isFinish=remainingTime<=0
if not isFinish then
if selectCount<itemCount then
overSelect[#overSelect+1]={
itemId=itemId,
itemCount=itemCount-selectCount,
itemTime=itemTime,
}
end
else
break
end
end

if not isFinish and next(overSelect)then
local minOverSelectPlan
for _,item in ipairs(overSelect)do
local itemId=item.itemId
local itemCount=item.itemCount
local itemTime=item.itemTime
local selectCount=math.ceil(remainingTime/itemTime)
selectCount=math.min(selectCount,itemCount)
if selectCount>0 then
local overTime=remainingTime-selectCount*itemTime
local minOverTime=minOverSelectPlan and minOverSelectPlan.overTime or nil
local isUse=false
if minOverTime then
local weight_a=overTime<0 and 100 or 0
local weight_b=minOverTime<0 and 100 or 0
if weight_a==weight_b then
local abs_a=math.abs(overTime)
local abs_b=math.abs(minOverTime)
isUse=abs_a<abs_b
else
isUse=weight_a>weight_b
end
else
isUse=true
end

if isUse then
minOverSelectPlan={
itemId=itemId,
itemTime=itemTime,
selectCount=selectCount,
overTime=overTime,
}
end
end
end

if minOverSelectPlan then
local itemId=minOverSelectPlan.itemId
local selectCount=minOverSelectPlan.selectCount
if selectList[itemId]then
selectList[itemId]=selectList[itemId]+selectCount
else
selectList[itemId]=selectCount
end
end
end
return selectList
end



function zongmenControl:checkBuildingManagerCanFire(sfId,ubdId,okCallBack)
local bdData=zongmenModel:getBuildingData(ubdId)
local cfg=cfgHelper.get1(cfg_monijybuildconfig_get,bdData.build_id)
local buildType=cfg.build_type
local checkFunc=_checkBdDzCanFireFunc[buildType]
if checkFunc then
return checkFunc(sfId,ubdId,okCallBack)
end
return true
end



function zongmenControl.testJumpBuildingWinTips(bdType)
zongmenControl:jumpBuildingWin({type=bdType})
end



function zongmenControl.recv_6_185(sfId,ubdId,plan_id,times)
local data=zongmenModel:getBuildingData(ubdId)
zongmenModel:endPlanProduction(sfId,ubdId)
hudControl:closeProgress(ubdId)

emergenciesModel:setProductionCutValue(ubdId,nil)

isometricMapSystem:setBuildingPlanStatus(sfId,ubdId,planStatus.eDefault)
isometricMapSystem:changeModelById(sfId,ubdId)

buildingEffectControl:stopEffect(data.entityId,buildEffectType.eProduce)

zongmenControl:setDiscipleState(data,DISCIPLE_STATE_TYPE.ePlantCreate,true)

notifySystem:postNotify(notifyConfig.building_event,buildingEvent.planComplete,sfId,ubdId,data.dizi_id)

UICatShopControl:checkAndShowEvent()

hudControl:refreshBuildingStatusHUD(ubdId)

guildOrderController:handleAutoShengChan()
end

