






local _MODULENAME="DiscipleCoupleController"

gameState.addListener(def_table(_MODULENAME))


DiscipleCoupleController.name=_MODULENAME
DiscipleCoupleController.openPrint=false
local discipleReqCoupleList={}
local localDzList={}
local listNum=0
local tempTimer
local _print=print
local print=function(...)
if DiscipleCoupleController.openPrint then
_print(...)
end
end

function DiscipleCoupleController.setOpenPrint(flag)
DiscipleCoupleController.openPrint=flag
end

function DiscipleCoupleController:onAppStart()

DiscipleCoupleModel:onAppStart()

socketManager:register_receiver(2,141,DiscipleCoupleController.recv_2_141)
socketManager:register_receiver(2,145,DiscipleCoupleController.recv_2_145)
socketManager:register_receiver(2,142,DiscipleCoupleController.recv_2_142)
socketManager:register_receiver(2,143,DiscipleCoupleController.recv_2_143)
socketManager:register_receiver(2,144,DiscipleCoupleController.recv_2_144)
socketManager:register_receiver(3,232,DiscipleCoupleController.recv_3_232)
socketManager:register_receiver(3,233,DiscipleCoupleController.recv_3_233)
socketManager:register_receiver(3,234,DiscipleCoupleController.recv_3_234)































end


function DiscipleCoupleController:onEnterState(isReconnect)
if isReconnect then
return
end
timeEventController.addSlowTimerHandler("DiscipleCoupleController",self)
notifySystem:listenNotify(notifyConfig.onDiscipleRemove,self.on_disciple_remove)
notifySystem:listenNotify(notifyConfig.onNewWeek5am,self.onNewWeek5am)
if tempTimer then
tempTimer:cancel()
end
tempTimer=timer.new()
local f=function()
DiscipleCoupleController:initDiscipleReqCoupleList()
end
tempTimer:start(60,f,-1)
DiscipleCoupleModel:onEnterState()
end


function DiscipleCoupleController:onProtocolReq()
DiscipleCoupleModel:onProtocolReq()
end


function DiscipleCoupleController:onLeaveState(isReconnect)
if isReconnect then
return
end
timeEventController.removeSlowTimerHandler("DiscipleCoupleController")
notifySystem:removelistener(notifyConfig.onDiscipleRemove,self.on_disciple_remove)
notifySystem:removelistener(notifyConfig.onNewWeek5am,self.onNewWeek5am)
DiscipleCoupleModel:onLeaveState(isReconnect)

discipleReqCoupleList={}
localDzList={}
listNum=0
if tempTimer then
tempTimer:cancel()
end
tempTimer=nil
end


function DiscipleCoupleController:onLostConnection()

end


function DiscipleCoupleController:onReConnection(isInitPro)

end

function DiscipleCoupleController.on_disciple_remove(type,guid)
if DiscipleCoupleModel:getDiscipleCoupleGuid(guid)~=nil then
DiscipleCoupleModel:DelCoupleListByGuid(guid)
end
if DiscipleCoupleModel:CheckReqCoupleListContain(guid)then
DiscipleCoupleModel:DelReqCoupleListByGuid(guid)
UIManager:invokeUIMethod('UIFuncStorageWin','refreshCoupleRequestBtn')
end
end







function DiscipleCoupleController.recv_2_141(couplelistlen,coupleList,reqlistlen,reqList)
if couplelistlen>0 then
DiscipleCoupleModel:initCoupleList(coupleList)
taskController.CoupleNumChange()
end
if reqlistlen>0 then
DiscipleCoupleModel:initReqCoupleList(reqList)
end
DiscipleCoupleController:initDiscipleReqCoupleList()
end












function DiscipleCoupleController.recv_2_142(discipleguid1,discipleguid2,ret)
if ret==0 then
DiscipleCoupleModel:AddCoupleList(discipleguid1,discipleguid2)


UIDiscipleModel:setDiscipleAttrListDirtyX(discipleguid1,nil,true)
UIDiscipleModel:setDiscipleAttrListDirtyX(discipleguid2,nil,true)


if DiscipleCoupleModel:CheckReqCoupleListContain(discipleguid1)then
DiscipleCoupleModel:DelReqCoupleListByGuid(discipleguid1)
UIManager:invokeUIMethod('UIFuncStorageWin','refreshCoupleRequestBtn')
end
if DiscipleCoupleModel:CheckReqCoupleListContain(discipleguid2)then
DiscipleCoupleModel:DelReqCoupleListByGuid(discipleguid2)
UIManager:invokeUIMethod('UIFuncStorageWin','refreshCoupleRequestBtn')
end
taskController.CoupleNumChange()
UIManager:invokeUIMethod("UIDiscipleCoupleWin","onShow")
UIManager:invokeUIMethod('UIDiscipleInfoComponent','refreshInfo')
end
UIManager:invokeUIMethod("UIDiscipleCoupleSelectWin","onCoupleCallback",discipleguid1,discipleguid2,ret)
end





function DiscipleCoupleController.recv_2_143(discipleguid1,discipleguid2,dialogueid)
DiscipleCoupleModel:AddReqCoupleList(discipleguid1,discipleguid2,dialogueid)
UIManager:invokeUIMethod('UIFuncStorageWin','refreshCoupleRequestBtn')
UIManager:invokeUIMethod('UIDiscipleRequestCoupleListWin','onShow')


UIDiscipleModel:setDiscipleAttrListDirtyX(discipleguid1,nil,true)
UIDiscipleModel:setDiscipleAttrListDirtyX(discipleguid2,nil,true)
end





function DiscipleCoupleController.recv_2_144(discipleguid1,discipleguid2,way)
DiscipleCoupleModel:DelReqCoupleList(discipleguid1,discipleguid2)
if way==1 then
DiscipleCoupleModel:AddCoupleList(discipleguid1,discipleguid2)
taskController.CoupleNumChange()
UIManager:invokeUIMethod('UIDiscipleInfoComponent','refreshInfo')


UIDiscipleModel:setDiscipleAttrListDirtyX(discipleguid1,nil,true)
UIDiscipleModel:setDiscipleAttrListDirtyX(discipleguid2,nil,true)
end
UIManager:invokeUIMethod('UIFuncStorageWin','refreshCoupleRequestBtn')
UIManager:invokeUIMethod('UIDiscipleRequestCoupleListWin','onShow')
UIManager:invokeUIMethod('UIDiscipleRequestCoupleWin','onCoupleHandleCallback',discipleguid1,discipleguid2,way)
if#DiscipleCoupleModel:getReqCoupleList()<=0 then
UIManager:closeWindow('UIDiscipleRequestCoupleListWin')
end
end










function DiscipleCoupleController.recv_2_145(discipleguid1,discipleguid2,ret)
if ret==0 then
DiscipleCoupleModel:DelCoupleList(discipleguid1,discipleguid2)
UIManager:invokeUIMethod("UIDiscipleCoupleWin","onTerminateCallBack",discipleguid1,discipleguid2)
UIManager:invokeUIMethod('UIDiscipleInfoComponent','refreshInfo')


UIDiscipleModel:setDiscipleAttrListDirtyX(discipleguid1,nil,true)
UIDiscipleModel:setDiscipleAttrListDirtyX(discipleguid2,nil,true)
end
end

function DiscipleCoupleController.recv_3_232(len,data,promote_len,promote_array)
DiscipleCoupleModel:setCoupleLiveId(len,data,promote_len,promote_array)
UIManager:invokeUIMethod("UIDLCultivationWin","refreshCoupleData")
UIManager:invokeUIMethod("UIDLCultivationWin","refreshRepairBtn")
end


function DiscipleCoupleController.recv_3_233(un_build_id,dizi_id_1,dizi_id_2)
if tostring(dizi_id_1)~="0"and tostring(dizi_id_2)~="0"then
DiscipleCoupleModel:addCoupleLiveId(un_build_id,dizi_id_1,dizi_id_2)
else
DiscipleCoupleModel:reduceCoupleLiveId(un_build_id)
end

notifySystem:postNotify(notifyConfig.onDaoLvChange,buildingEvent.switchRoomDizi,un_build_id,dizi_id_1,dizi_id_2)
hudControl:refreshBuildingStatusHUD(un_build_id)
end


function DiscipleCoupleController.recv_3_234(args)
local speList=DiscipleCoupleController.send_3_234_SpeList
if args then
local un_build_id=args[1]
local xiuwei1=args[2]
local lianti1=args[3]
local tiaits1=args[4]
local sixAttr1=args[5]
local xiuwei2=args[6]
local lianti2=args[7]
local tiaits2=args[8]
local sixAttr2=args[9]
DiscipleCoupleModel:setCoupleRepairRewardId(un_build_id,xiuwei1,lianti1,tiaits1,sixAttr1,xiuwei2,lianti2,tiaits2,sixAttr2,speList)
DiscipleCoupleModel:addCouplePromote_cnt(un_build_id)
UIManager:invokeUIMethod("UIDLCultivationWin","playDoubleRepairAnim")
UIManager:invokeUIMethod("UIDLCultivationWin","refreshCoupleData")
UIManager:invokeUIMethod("UIDLCultivationWin","refreshRepairBtn")
hudControl:refreshBuildingStatusHUD(un_build_id)
end
DiscipleCoupleController.send_3_234_SpeList=nil
end

function DiscipleCoupleController.send_2_141()
socketManager:send_2_141()
end




function DiscipleCoupleController.send_2_142(discipleguid1,discipleguid2)
socketManager:send_2_142(discipleguid1,discipleguid2)
end





function DiscipleCoupleController.send_2_143(discipleguid1,discipleguid2,dialogueid)
socketManager:send_2_143(discipleguid1,discipleguid2,dialogueid)
end





function DiscipleCoupleController.send_2_144(discipleguid1,discipleguid2,way)
socketManager:send_2_144(discipleguid1,discipleguid2,way)
end




function DiscipleCoupleController.send_2_145(discipleguid1,discipleguid2)
socketManager:send_2_145(discipleguid1,discipleguid2)
end


function DiscipleCoupleController.reqDaoLvDatas()
socketManager:send_3_232()
end


function DiscipleCoupleController.reqLiveDaoLv(un_build_id,dizi_id_1,dizi_id_2)
socketManager:send_3_233(un_build_id,dizi_id_1,dizi_id_2)
end


function DiscipleCoupleController.reqDaoLvRepair(un_build_id,manGuid,womanGuid)
local manSpeList=UIDiscipleModel:getDiscipleSpeciality(manGuid,DISCIPLE_SPECIALITY_TYPE.eDaoLv)or{}
local womanSpeList=UIDiscipleModel:getDiscipleSpeciality(womanGuid,DISCIPLE_SPECIALITY_TYPE.eDaoLv)or{}
local commonSpeList={}
for i,v in ipairs(manSpeList)do
if not commonSpeList[v.param_1]then
commonSpeList[v.param_1]=true
end
end
for i,v in ipairs(womanSpeList)do
if not commonSpeList[v.param_1]then
commonSpeList[v.param_1]=true
end
end
DiscipleCoupleController.send_3_234_SpeList=commonSpeList

socketManager:send_3_234(un_build_id)
end




function DiscipleCoupleController:showSelectDiscipleWin(sex,otherGuid)
local args={
openType=dzSelectWinOpenType.eCouple,
sex=sex,
otherGuid=otherGuid,
canvasIdx=8,
callback=function(guid)
local win=UIManager:findActiveWindow("UIDiscipleCoupleSelectWin")
if win then
win:selectDiscipleCallback(sex,guid)
end
end,
}
discipleSelectController:openDiscipleSelect(args,sex==1 and"选择男弟子"or"选择女弟子")
end


function DiscipleCoupleController:initDiscipleReqCoupleList()
local open=systemModel.isOpen(SYSTEM_DEFINE.eDiscipleCouple)
if not open then
return false
end

local cfg=cfgHelper.get1(cfg_disciplecoupleconfig_get,1)
local lastTime=userActorSetting.get("event_discipleCouple_time",0)
local nowTime=timeHelper.getServerShortTime()
if lastTime>(nowTime-cfg.coupleInterval)then

return false
end

local reqListLen=#DiscipleCoupleModel:getReqCoupleList()
if reqListLen>=3 then

return false
end
local cnt=gameUtilityModel:getData_counter(gameCounterType.eDiscipleCoupleNum)
if cnt>=cfg.times[2]then

return false
end
self:loadLocalFile()
self:clearExpireReqRecord()
discipleReqCoupleList={}
listNum=0
local total=0
if#localDzList>0 then

for _,v in ipairs(localDzList)do
local guid=int64.new(v)
table.insert(discipleReqCoupleList,guid)
total=total+1
end
else

local dizilist=UIDiscipleModel:getAllDiscipleData()
localDzList={}
for i,v in pairs(dizilist)do
local guid=v.netData.net.discipleguid
local guidStr=v.netData.net.discipleguidStr
table.insert(discipleReqCoupleList,guid)
table.insert(localDzList,guidStr)
total=total+1
end
self:freshLocalFile(true)
end
userActorSetting.set("event_discipleCouple_time",timeHelper.getServerShortTime())
userActorSetting.flush(true)
listNum=total


end

function DiscipleCoupleController:loadLocalFile()
localDzList=userActorArraySetting.get(ACTOR_SETTING_TYPE.eEvent,"event_discipleCouple",{})
end

function DiscipleCoupleController:freshLocalFile(canDelay)
eventControl.freshLocalVal("event_discipleCouple",localDzList,canDelay)
end

function DiscipleCoupleController:clearLocalFile()
eventControl.freshLocalVal("event_discipleCouple",nil,true)
end














function DiscipleCoupleController:clearExpireReqRecord()
local reqRecord=userActorSetting.get("event_discipleCouple_reqRecord",{})
local cfg=cfgHelper.get1(cfg_disciplecoupleconfig_get,1)
local nowTime=timeHelper.getServerShortTime()
for guid1Str,records in pairs(reqRecord)do
local tempRecords={}
for guid2Str,reqTime in pairs(records)do
if reqTime>(nowTime-cfg.sameCoupleInterval)then
tempRecords[guid2Str]=reqTime
end
end
reqRecord[guid1Str]=tempRecords
end

userActorSetting.set("event_discipleCouple_reqRecord",reqRecord)
userActorSetting.flush(true)
end

function DiscipleCoupleController:onSlowUpdate()
if listNum>0 then
local guid1=discipleReqCoupleList[listNum]
table.remove(discipleReqCoupleList,listNum)
table.remove(localDzList,listNum)
DiscipleCoupleController:freshLocalFile(true)
listNum=listNum-1
local netData=UIDiscipleModel:getDiscipleData(guid1)
if not netData then

return
end

local isInReqList=DiscipleCoupleModel:CheckReqCoupleListContain(guid1)
if isInReqList then

return
end
if netData and not isInReqList then
local relationList=DiscipleCoupleModel:getDiscipleDiffSexRelationList(guid1)or{}
if#relationList<=0 then

return
end
local reqRecord=userActorSetting.get("event_discipleCouple_reqRecord",{})
local guid1Str=tostring(guid1)
for _,guid2 in ipairs(relationList)do
if DiscipleCoupleModel:checkDiscipleCoupleValid(guid1,guid2,false,true)then
local records=reqRecord[guid1Str]or{}
local sameCheckPass=true
for guid2Str,reqTime in pairs(records)do
if guid2Str==tostring(guid2)then
local cfg=cfgHelper.get1(cfg_disciplecoupleconfig_get,1)
local nowTime=timeHelper.getServerShortTime()
if reqTime>(nowTime-cfg.sameCoupleInterval)then

sameCheckPass=false
end
break
end
end
if sameCheckPass then
local guid1Name=UIDiscipleModel:getDiscipleName(guid1)
local guid2Name=UIDiscipleModel:getDiscipleName(guid2)

local cfg=cfg_reqcoupledialogueconfig()
local dialogueid=math.random(#cfg)
DiscipleCoupleController.send_2_143(guid1,guid2,dialogueid)

DiscipleCoupleController:clearLocalFile()
discipleReqCoupleList={}
localDzList={}
listNum=0

local guid2Str=tostring(guid2)
records[guid2Str]=timeHelper.getServerShortTime()
reqRecord[guid1Str]=records

records=reqRecord[guid2Str]or{}
records[guid1Str]=timeHelper.getServerShortTime()
reqRecord[guid2Str]=records

userActorSetting.set("event_discipleCouple_reqRecord",reqRecord)
userActorSetting.flush(true)
return
end
end
end

end
end
end

function DiscipleCoupleController.onNewWeek5am()
DiscipleCoupleModel:clearPromoteList()
DiscipleCoupleController.reqDaoLvDatas()
end


function DiscipleCoupleController:printCoupleInfo()
local reqCoupleList=DiscipleCoupleModel:getReqCoupleList()
local cfg=cfgHelper.get1(cfg_disciplecoupleconfig_get,1)
local NowTimeStamp=timeHelper.getServerShortTime()
for _,v in ipairs(reqCoupleList)do
local timeStamp=v.timeStamp
local manGuid=v.man
local womanGuid=v.woman
local pastTime=NowTimeStamp-timeStamp
local manName=UIDiscipleModel:getDiscipleName(manGuid)
local womanName=UIDiscipleModel:getDiscipleName(womanGuid)
loggerUtil.logErrFMT("男弟子：{0} 女弟子：{1} 请求生成时间戳：{2} 配置保留时长：{3} 已经过去的时间：{4}",manName,womanName,timeStamp,cfg.duration,pastTime)
end
end
