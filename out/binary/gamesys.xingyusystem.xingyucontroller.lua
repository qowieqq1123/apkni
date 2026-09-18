






local _MODULENAME="XingYuController"

gameState.addListener(def_table(_MODULENAME))
XingYuController.name=_MODULENAME
XingYuController.data={}
XingYuState={
eDataErr=-1,
eNone=0,
eTanSuo=1,
eHunZhan=2,
eZhenDuo=3,
eFinish=4,
}


XYHJTYPE={
eFaZe=1,
eLimit=2,
}


FailType={
eTanSuo=1,
eHunZhan=2,
eZhenDuo=3,
}

LOGTYPE={
eNull=0,
eGetReward=1,
eGetFaZe=2,
eAllDzHurt=3,
eDzHurt=4,
eAllDzAddJJExp=5,
eDzAddJJExp=6,
eAllDzAddLTExp=7,
eDzAddLTExp=8,
eTeamFail=9,
eFewReward=10,
eTanSuoBigReward=11,
eTanSuoFail=12,
eTanSuoGaiLvFail=13,
}

local reqStr={
req35_100_ts="35_100_ts",
req35_100_hz="35_100_hz",
}

local stateChangeStr={
ts="ts",
hz="hz",
zd='zd'
}



function XingYuController:onAppStart()

XingYuModel:onAppStart()

socketManager:register_receiver(35,100,XingYuController.recv_35_100)
socketManager:register_receiver(35,101,XingYuController.recv_35_101)
socketManager:register_receiver(35,102,XingYuController.recv_35_102)
socketManager:register_receiver(35,103,XingYuController.recv_35_103)
socketManager:register_receiver(35,104,XingYuController.recv_35_104)
socketManager:register_receiver(35,105,XingYuController.recv_35_105)
socketManager:register_receiver(35,106,XingYuController.recv_35_106)
socketManager:register_receiver(35,107,XingYuController.recv_35_107)
socketManager:register_receiver(35,108,XingYuController.recv_35_108)
socketManager:register_receiver(35,109,XingYuController.recv_35_109)
socketManager:register_receiver(35,110,XingYuController.recv_35_110)
socketManager:register_receiver(35,111,XingYuController.recv_35_111)

end


function XingYuController:onEnterState(isReconnect)
self.reqFlagList={}
self.stateChangeList={}
self.firstPaiQianList={}
XingYuController.autoRePlayInfo=nil
XingYuController.replayFlag=nil
XingYuModel:onEnterState()
notifySystem:listenNotify(notifyConfig.onLimitActStateChange,self.onLimitActStateChange)
notifySystem:listenNotify(notifyConfig.onLimitActOpen,self.onLimitActOpen)
notifySystem:listenNotify(notifyConfig.enterXianJie,self.onEnterXianJie)
notifySystem:listenNotify(notifyConfig.leaveXianJie,self.onLeaveXianJie)
timeEventController.addNormalTimerHandler(1,'XingYuController',self)
end


function XingYuController:onProtocolReq()
XingYuModel:onProtocolReq()
end


function XingYuController:onLeaveState(isReconnect)
XingYuModel:onLeaveState(isReconnect)
if isReconnect then
if UIFullXingYuController.fightStage then
UIFullXingYuController.fightStage:close()
end
end
notifySystem:removelistener(notifyConfig.onLimitActStateChange,self.onLimitActStateChange)
notifySystem:removelistener(notifyConfig.onLimitActOpen,self.onLimitActOpen)
notifySystem:removelistener(notifyConfig.enterXianJie,self.onEnterXianJie)
notifySystem:removelistener(notifyConfig.leaveXianJie,self.onLeaveXianJie)
timeEventController.removeNormalTimerHandler(1,'XingYuController',self)

self.data={}
end


function XingYuController:onLostConnection()

end


function XingYuController:onReConnection(isInitPro)

end

function XingYuController:onNormalUpdate(delay)

if not XingYuController.checkSysOpen()then
return
end

local isInit=XingYuModel:getInitFlag()
if not isInit then
return
end
if not limitActivitiesModel:checkActDoing(LIMIT_ACT_TYPE.eXianJieXingYu)then
return
end


if not self.reqFlagList[reqStr.req35_100_hz]then

if XingYuController.checkAllXingYuHasZDZTeamCnt()then
self.reqFlagList[reqStr.req35_100_hz]=true
self.reqFlagList[reqStr.req35_100_ts]=true
else
local curTime=timeHelper.getServerShortTime()
local tsEndTime=XingYuController.getTanSuoEndTime()
local hzEndTime=XingYuController.getHunZhanEndTime()
if hzEndTime<=curTime then
self.reqFlagList[reqStr.req35_100_hz]=true
self.reqFlagList[reqStr.req35_100_ts]=true
XingYuController.req_35_100()

end
end
end

if not self.reqFlagList[reqStr.req35_100_ts]then

if XingYuController.checkAllXingYuHasHZTeamCnt()then
self.reqFlagList[reqStr.req35_100_ts]=true
else
local curTime=timeHelper.getServerShortTime()
local tsEndTime=XingYuController.getTanSuoEndTime()
if tsEndTime<=curTime then
self.reqFlagList[reqStr.req35_100_ts]=true
XingYuController.req_35_100()

end
end
end


if not limitActivitiesModel:checkActOpen(LIMIT_ACT_TYPE.eXianJieXingYu)then
return
end

local needReedFresh=false
local endState=0
if not self.stateChangeList[stateChangeStr.zd]then
local xingyuList=XingYuModel:getXingYuIdList()
if xingyuList then
local xyId=xingyuList[1]
local curTime=timeHelper.getServerShortTime()
local zhenDouEndTime=XingYuController.getZhenDouEndTime(xyId)
if zhenDouEndTime and curTime>=zhenDouEndTime+3 then
self.stateChangeList[stateChangeStr.zd]=true
needReedFresh=true
endState=3
end
end
end

if not needReedFresh and not self.stateChangeList[stateChangeStr.hz]then
local curTime=timeHelper.getServerShortTime()
local hzEndTime=XingYuController.getHunZhanEndTime()
if curTime>=hzEndTime+3 then
self.stateChangeList[stateChangeStr.hz]=true
needReedFresh=true
endState=2
end
end

if not needReedFresh and not self.stateChangeList[stateChangeStr.ts]then
local curTime=timeHelper.getServerShortTime()
local tsEndTime=XingYuController.getTanSuoEndTime()
if curTime>=tsEndTime+3 then
self.stateChangeList[stateChangeStr.ts]=true
needReedFresh=true
endState=1
end
end

if needReedFresh then

self.stateChangeRefresh(endState)
end

end










































































































function XingYuController.req_35_100()

socketManager:send_35_100()
end





function XingYuController.req_35_101(xingyuId,len,teamList)
socketManager:send_35_101(xingyuId,len,teamList)
end



function XingYuController.req_35_102(xingyuId)
socketManager:send_35_102(xingyuId)
end



function XingYuController.req_35_103(xingyuId)
socketManager:send_35_103(xingyuId)
end



function XingYuController.req_35_104(xingyuId)
socketManager:send_35_104(xingyuId)
end



function XingYuController.req_35_105(xingyuId)
socketManager:send_35_105(xingyuId)
end



function XingYuController.req_35_106(xingyuId)
socketManager:send_35_106(xingyuId)
end



function XingYuController.req_35_107(xingyuId)
socketManager:send_35_107(xingyuId)
end


function XingYuController.req_35_108(rwType,xyId)
socketManager:send_35_108(rwType,xyId)
end


function XingYuController.req_35_109(xingyuId)
socketManager:send_35_109(xingyuId)
end


function XingYuController.req_35_110(xingyuId,teamIndex)
socketManager:send_35_110(xingyuId,teamIndex)
end


function XingYuController.req_35_111(xingyuId,teamIndex,zdzindex)
socketManager:send_35_111(xingyuId,teamIndex,zdzindex)
end















function XingYuController.recv_35_100(len,xyList,len2,xyList2)

XingYuModel:refreshlookUpData_xingyuDataLookUp(xyList)
XingYuModel:refreshlookUpData_lastXingyuDataLookUp(xyList2)

XingYuModel:setInitFlag(true)



XingYuController:CreateXingYuData()
UIManager:invokeUIMethod("UIXianJieExplorationXingYuWin","refreshView")
UIManager:invokeUIMethod("UIXYInfoListWIn","refreshView")
UIManager:invokeUIMethod("UIXingYuMainWin","refreshView")
XingYuController.freshFuncStorageBtn()
end





function XingYuController.recv_35_101(xingyuId,len,teamList)
XingYuController:setFirstPaiQianList(xingyuId,true)
XingYuModel:refreshlookUpData_xingyuData_teamList(xingyuId,teamList)

local localCfg=userActorArraySetting.getBase(ACTOR_SETTING_TYPE.eXingYu,{})
if not localCfg.localteamListEx then
localCfg.localteamListEx={}
end
local localteamList=localCfg.localteamListEx




for teamIndex=1,3 do
local dzList=XingYuController.getXingYuTeamPosDzList_TeamIndex(xingyuId,teamIndex)
local strdzList={}
for i,v in ipairs(dzList or{})do
strdzList[i]=mathHelper.int64_to_string(v)
end
localteamList[tostring(teamIndex)]=strdzList
end

userActorArraySetting.setBase(ACTOR_SETTING_TYPE.eXingYu,localCfg)
userActorArraySetting.flush(ACTOR_SETTING_TYPE.eXingYu)

XingYuController.req_35_102(xingyuId)



end















function XingYuController.recv_35_102(args)
local xingyuId=args[1]
local lastTime=args[2]
local len=args[3]
local xyLogList=args[4]
local len2=args[5]
local tsrwList=args[6]
local xingyuLog=args[7]
local len3=args[8]
local leaveList=args[9]
local hzTeamNum=args[10]
local zdzTeamNum=args[11]
local len4=args[12]
local zdzrwidList=args[13]
XingYuModel:refreshlookUpData_lastEnterTimeList(xingyuId,lastTime)
XingYuModel:refreshlookUpData_xingyuData_zdzrwidList(xingyuId,zdzrwidList)

local popWin
if len2>0 and xingyuLog.logType~=LOGTYPE.eNull then
local args={}
args.xyId=xingyuId
args.tsrwList=tsrwList
args.xingyuLog=xingyuLog

popWin={}
popWin.winName="UIXYTSTipsWin"
popWin.winArgs=args
end

if len3>0 then
local hzList={}
local zdList={}
for i,xingyuLeaveInfo in ipairs(leaveList)do
local teamp={}
teamp.teamIndex=xingyuLeaveInfo.teamIndex
teamp.guidList=XingYuController.getXingYuTeamDzList_TeamIndex(xingyuId,xingyuLeaveInfo.teamIndex)
if xingyuLeaveInfo.zdzLastFail~=xingyuLeaveInfo.zdzFail then
teamp.isWin=false
teamp.showRound=xingyuLeaveInfo.zdzFail
table.insert(zdList,teamp)
elseif xingyuLeaveInfo.hzLastFail~=xingyuLeaveInfo.hzFail then
teamp.isWin=false
teamp.showRound=xingyuLeaveInfo.hzFail
table.insert(hzList,teamp)
elseif xingyuLeaveInfo.zdzLastWin~=xingyuLeaveInfo.zdzWin then
teamp.isWin=true
teamp.showRound=xingyuLeaveInfo.zdzWin+1
teamp.isGJ=xingyuLeaveInfo.zdzWin==XingYuController.getRound(zdzTeamNum)
if zdzTeamNum==1 then
teamp.isGJ=xingyuLeaveInfo.zdzWin==1
end
table.insert(zdList,teamp)
elseif xingyuLeaveInfo.hzLastWin~=xingyuLeaveInfo.hzWin then
teamp.isWin=true
teamp.showRound=xingyuLeaveInfo.hzWin+1
teamp.isJJZDZ=xingyuLeaveInfo.hzWin==XingYuController.getRound(hzTeamNum,32)
if hzTeamNum<=32 then
teamp.isJJZDZ=true
end
table.insert(hzList,teamp)
end
end

if#hzList>0 or#zdList>0 then
local args={}
args.xyId=xingyuId
args.hzList=hzList
args.zdList=zdList

popWin={}
popWin.winName="UIXYTeamStateChangeWin"
popWin.winArgs=args
end
end

local argstable={}
argstable.xyId=xingyuId
argstable.popWin=popWin





if UIManager:isActive("UIXingYuMainWin")then
UIManager:invokeUIMethod("UIXingYuMainWin","onShow",argstable)
else
UIFullXingYuController:showMainWindow(argstable)
end

if len>0 then
local fewList={}
for i,xingyuLog in ipairs(xyLogList)do
if xingyuLog.logType==LOGTYPE.eFewReward and xingyuLog.logTime>lastTime then
local args=jsonHelper.decode(xingyuLog.jsonStr)
local msg=""
local evnid=args[1]
local evncfg=cfg_xingyueventconfig_get(evnid)
local result=evncfg.result
local desc=evncfg.desc
local sNmae=loginModel:getServerName(args[2])

local fewItemId=evncfg.fewShowItem
local item_config=itemsConfig.getConfig(fewItemId)

local itemName=FMT.cfmt(item_config.color,"[{0}]",item_config.name)
local msg=FMT.fmt(desc,sNmae,args[3],itemName)
UIManager.topHourceLamp(FMT.cfmt(FONT_COLOR.eNomalBlackColor,msg))
XingYuController.showHource=true
elseif xingyuLog.logType==LOGTYPE.eTanSuoBigReward and xingyuLog.logTime>lastTime then
local args=jsonHelper.decode(xingyuLog.jsonStr)
local msg=""
local tsRId=args[3]
local tsRCfg=cfg_xingyutansuorewardconfig_get(tsRId)
if tsRCfg and tsRCfg.zxItemId then
if tsRCfg.zxDesc then
local desc=tsRCfg.zxDesc
local sNmae=loginModel:getServerName(args[1])

local fewItemId=tsRCfg.zxItemId
local item_config=itemsConfig.getConfig(fewItemId)

local itemName=FMT.cfmt(item_config.color,"[{0}]",item_config.name)
local msg=FMT.fmt(desc,sNmae,args[2],itemName)
UIManager.topHourceLamp(FMT.cfmt(FONT_COLOR.eNomalBlackColor,msg))
XingYuController.showHource=true
else
logErr("探索獎勵配置珍稀道具 沒有配置獲得描述")
return
end

end
end
end
end
end





function XingYuController.recv_35_103(xingyuId,len,rwList)
XingYuModel:refreshlookUpData_xingyuData_teamRewardList(xingyuId,len,rwList)

local args={
xyId=xingyuId,
}
oneTabScreenController:openUI(SEC_FULL_TYPE.XYRewardSecondary,args)
end







function XingYuController.recv_35_104(xingyuId,len,zsLogList,len2,xyLogList)
XingYuModel:refreshlookUpData_xingyuData_LogList(xingyuId,zsLogList,xyLogList)
local args={
xyId=xingyuId,
}
oneTabScreenController:openUI(SEC_FULL_TYPE.XYTanSuoJiShi,args)
end







function XingYuController.recv_35_105(xingyuId,len,teamList,len2,fzList)
XingYuModel:refreshlookUpData_xingyuData_teamList(xingyuId,teamList)
XingYuModel:refreshlookUpData_xingyuData_fazeList(xingyuId,fzList)

local args={
xyId=xingyuId,
}
UIManager:showWindow('UIXYTeamDetailWin',args)
end




function XingYuController.recv_35_106(xingyuId,teamNum)
XingYuModel:refreshlookUpData_xingyuData_hzTeamCnt(xingyuId,teamNum)
local args={
xyId=xingyuId,
}
UIManager:showWindow('UIXYHZRounWin',args)
end





function XingYuController.recv_35_107(xingyuId,len,zdzList)
XingYuModel:refreshlookUpData_xingyuData_zdzList(xingyuId,zdzList)
if XingYuController.autoRePlayInfo then
local info=XingYuController.autoRePlayInfo
local fightdata=XingYuController:getZDZFightData(xingyuId,info.round,playerModel:getActorID(),info.teamIndex)
XingYuController.autoRePlay(fightdata,xingyuId)
XingYuController.autoRePlayInfo=nil
return
end
if len>0 then
local args={
xyId=xingyuId,
}
local tabTpye
if XingYuController.tabType then
tabTpye=XingYuController.tabType
XingYuController.tabType=nil
end

if not tabTpye then
local nextzdzRound=XingYuController.getZDZNextRound(xingyuId)
if nextzdzRound==1 then
tabTpye=SEC_FULL_TAB_TYPE.eXYZhenDuoZhan_Round1
elseif nextzdzRound==2 then
tabTpye=SEC_FULL_TAB_TYPE.eXYZhenDuoZhan_Round2
elseif nextzdzRound==3 then
tabTpye=SEC_FULL_TAB_TYPE.eXYZhenDuoZhan_Round3
elseif nextzdzRound==4 then
tabTpye=SEC_FULL_TAB_TYPE.eXYZhenDuoZhan_Round4
elseif nextzdzRound==5 then
tabTpye=SEC_FULL_TAB_TYPE.eXYZhenDuoZhan_Round5
else
local sumRound=XingYuModel:getXingYuData_zdzSumRound(xingyuId)

if sumRound==0 or sumRound==1 then
tabTpye=SEC_FULL_TAB_TYPE.eXYZhenDuoZhan_Round1
elseif sumRound==2 then
tabTpye=SEC_FULL_TAB_TYPE.eXYZhenDuoZhan_Round2
elseif sumRound==3 then
tabTpye=SEC_FULL_TAB_TYPE.eXYZhenDuoZhan_Round3
elseif sumRound==4 then
tabTpye=SEC_FULL_TAB_TYPE.eXYZhenDuoZhan_Round4
elseif sumRound==5 then
tabTpye=SEC_FULL_TAB_TYPE.eXYZhenDuoZhan_Round5
end
end
end

if tabTpye then
oneTabScreenController:openTabUI(tabTpye,args)
else
oneTabScreenController:openUI(SEC_FULL_TYPE.XYZhenDuoZhan,args)
end

else
UIManager:showWindow("UINoZDZRoundWin")
end

if XingYuController.replayFlag then
XingYuController.replayFlag=false
loadingControl.closeCloud()
end

end




function XingYuController.recv_35_108(rwType,xingyuId)
if rwType==1 then
XingYuModel:refreshlookUpData_lastxingyuData_rwFlag(xingyuId,1)
elseif rwType==2 then
XingYuModel:refreshlookUpData_xingyuData_rwFlag(xingyuId,1)
end

XingYuController.freshFuncStorageBtn()

if not XingYuController.checkXingYuReddot()then

local localCfg=userActorArraySetting.getBase(ACTOR_SETTING_TYPE.eXingYu,{})

localCfg.showFlagList=nil
userActorArraySetting.setBase(ACTOR_SETTING_TYPE.eXingYu,localCfg)
userActorArraySetting.flush(ACTOR_SETTING_TYPE.eXingYu)
end
end


function XingYuController.recv_35_109(xingyuId)
if XingYuController.showHource then
XingYuController.showHource=nil
UIManager.closeTopHourceLamp()
end
end


function XingYuController.recv_35_110(args)












local temp={}
temp.xingyuId=args[1]
temp.teamIndex=args[2]
temp.tsqFail=args[3]
temp.hzFailIndex=args[4]
temp.rActorId=args[5]
local isSelf=mathHelper.compareInt64(temp.rActorId,playerModel:getActorID())
temp.rServerId=isSelf and loginModel.server_id or args[6]
temp.rName=isSelf and playerModel:getActorName()or args[7]
temp.rIconInfo=isSelf and playerModel:getActorIconInfo()or args[8]
temp.rTeamIndex=args[14]
local _len=args[9]
local _teamDzList=args[10]
local _fight=mathHelper.int64_to_number(args[11])
if isSelf then
_len=5
_teamDzList={}
_fight=XingYuController.getXingYuTeamFight_TeamIndex(temp.xingyuId,temp.rTeamIndex)
local posguidList=XingYuController.getXingYuTeamPosDzList_TeamIndex(temp.xingyuId,temp.rTeamIndex)
for i,guid in pairs(posguidList)do
local xingyuDisciple={}
xingyuDisciple.dzInfo={discipleguid=Int64_0}
if not mathHelper.compareInt64(guid,Int64_0)then
local netdata=UIDiscipleModel:getDiscipleDataX(guid).netData.net
xingyuDisciple.dzInfo=netdata

end
table.insert(_teamDzList,xingyuDisciple)
end
end
temp.len=_len
temp.teamDzList=_teamDzList
temp.fight=_fight
temp.len2=args[12]

local tsRewardList
local rwlist=args[13]
if rwlist then
tsRewardList={}
for i,v in ipairs(rwlist)do
local color=itemsConfig.getItemColor(v.param_1)
table.insert(tsRewardList,{v.param_1,v.param_2,color=color,showStage=true,})
end
end
table.sort(tsRewardList,function(a,b)
return a.color>b.color
end)
temp.tsRewardList=tsRewardList
local myOdds,bOdds=XingYuController.getOdds(temp.xingyuId,temp.teamIndex,_fight)
temp.myOdds=myOdds
temp.bOdds=bOdds
temp.fightLogId=args[15]

temp.fightActorId=args[16]
temp.fightServerId=args[17]
temp.fightName=args[18]
temp.fightIcon=args[19]
temp.glttFlag=args[20]

XingYuModel:refreshlookUpData_xingyuData_hzRivalList(temp.xingyuId,temp.teamIndex,temp)
UIManager:invokeUIMethod("UIXingYu_HZ_ZDWin","recvData",temp.teamIndex)
end


function XingYuController.recv_35_111(args)
local temp={}
temp.xingyuId=args[1]
temp.teamIndex=args[2]
temp.zdzidx=args[3]
temp.zdzWinIndex=args[4]
temp.zdzFailIndex=args[5]
temp.rActorId=args[6]
local isSelf=mathHelper.compareInt64(temp.rActorId,playerModel:getActorID())
temp.rServerId=isSelf and loginModel.server_id or args[7]
temp.rName=isSelf and playerModel:getActorName()or args[8]
temp.rIconInfo=isSelf and playerModel:getActorIconInfo()or args[9]
temp.rTeamIndex=args[17]
local _len=args[10]
local _teamDzList=args[11]
local _fight=mathHelper.int64_to_number(args[12])
if isSelf then
_len=5
_teamDzList={}
_fight=XingYuController.getXingYuTeamFight_TeamIndex(temp.xingyuId,temp.rTeamIndex)
local posguidList=XingYuController.getXingYuTeamPosDzList_TeamIndex(temp.xingyuId,temp.rTeamIndex)
for i,guid in pairs(posguidList)do
local xingyuDisciple={}
xingyuDisciple.dzInfo={discipleguid=Int64_0}
if not mathHelper.compareInt64(guid,Int64_0)then
local netdata=UIDiscipleModel:getDiscipleDataX(guid).netData.net
xingyuDisciple.dzInfo=netdata

end
table.insert(_teamDzList,xingyuDisciple)
end
end
temp.len=_len
temp.teamDzList=_teamDzList
temp.fight=_fight
temp.tsqFail=args[13]
temp.len2=args[14]
local tsRewardList
local rwlist=args[15]
if rwlist then
tsRewardList={}
for i,v in ipairs(rwlist)do
local color=itemsConfig.getItemColor(v.param_1)
table.insert(tsRewardList,{v.param_1,v.param_2,color=color,showStage=true,})
end
end
table.sort(tsRewardList,function(a,b)
return a.color>b.color
end)
temp.tsRewardList=tsRewardList
temp.hzFailIndex=args[16]
temp.fightLogId=args[18]



temp.fightActorId=args[19]
temp.fightServerId=args[20]
temp.fightName=args[21]
temp.fightIcon=args[22]
temp.glttFlag=args[23]

XingYuModel:refreshlookUpData_xingyuData_zdzRivalList(temp.xingyuId,temp.teamIndex,temp)
UIManager:invokeUIMethod("UIXingYu_HZ_ZDWin","recvData",temp.teamIndex)
end







































function XingYuController:CreateXingYuData()

XingYuController:removeAllEntityData()
if not xianjieModel:checkSceneType(xianjienSceneType.eXianJie)then
return
end

if not limitActivitiesModel:checkActDoing(LIMIT_ACT_TYPE.eXianJieXingYu)then
return
end

local xingyuIdList=XingYuModel:getXingYuIdList()
if not xingyuIdList then
return
end

for i,xyId in ipairs(xingyuIdList)do
XingYuController:createEntityData(xyId)
end

XingYuController:refreshAllEntity()

end

function XingYuController:removeAllEntityData()
if self.xingyuEntityDataList then
for k,v in pairs(self.xingyuEntityDataList)do
xianjieController:removeXJClass(v)
end
self.xingyuEntityDataList=nil
end
end

function XingYuController:removeEntityData(xyId)
if self.xingyuEntityDataList and self.xingyuEntityDataList[xyId]then
local entityData=self.xingyuEntityDataList[xyId]
xianjieController:removeXJClass(entityData)
self.xingyuEntityDataList[xyId]=nil
end
end

function XingYuController:addEntityData(xyId,entitydata)
XingYuController:removeEntityData(xyId)
if not self.xingyuEntityDataList then
self.xingyuEntityDataList={}
end
self.xingyuEntityDataList[xyId]=entitydata
end

function XingYuController:getEntityData(xyId)
if self.xingyuEntityDataList then
return self.xingyuEntityDataList[xyId]
end
end

function XingYuController:createEntityData(xyId)
local _entitydata={}
local sceneType=xianjienSceneType.eXianJie
local xyCfg=XingYuModel:getXingYuConfig(xyId)
local pos=xyCfg.pos
local size=xyCfg.size
_entitydata.scene=xianjieModel:getSceneIndex(sceneType)
_entitydata.size=size
_entitydata.pos=pos
_entitydata.xyId=xyId
local entitydata=xianjieController:createXJClass(xjDataType.eXJXingYu,_entitydata)
XingYuController:addEntityData(xyId,entitydata)
end

function XingYuController:refreshAllEntity()
if self.xingyuEntityDataList then
for k,entityData in pairs(self.xingyuEntityDataList)do
entityData:refreshEntity()
end
end
end

function XingYuController:refreshEntity(xyId)
if self.xingyuEntityDataList and self.xingyuEntityDataList[xyId]then
local entityData=self.xingyuEntityDataList[xyId]
entityData:refreshEntity()
end
end



function XingYuController.onLimitActStateChange(actId,actState,isNew)
if actId==LIMIT_ACT_TYPE.eXianJieXingYu then
if actState==limitActivitiesModel.actDoingState then
timeEventController.delayDo(3,function()
XingYuController.req_35_100()
end)


else
XingYuController:removeAllEntityData()
UIFullXingYuController:closeWin()
XingYuController.freshFuncStorageBtn()
end
if isNew then
xianjieController:refreshFilterlookup()
end
end
end

function XingYuController.onLimitActOpen(actId,flag)
if actId==LIMIT_ACT_TYPE.eXianJieXingYu then
if flag==1 then
local actInfo=limitActivitiesModel:getActInfo(actId)
if actInfo.state==limitActivitiesModel.actDoingState then
timeEventController.delayDo(3,function()
XingYuController.req_35_100()
end)


XingYuController.showFlyIconTips()
else
XingYuController:removeAllEntityData()
UIFullXingYuController:closeWin()
end
else
XingYuController:removeAllEntityData()
UIFullXingYuController:closeWin()
XingYuController.freshFuncStorageBtn()
end
end
end

function XingYuController.onEnterXianJie(sceneType)
if not XingYuController.checkSysOpen()then
return
end
if xianjienSceneType.eXianJie==sceneType then
XingYuController:CreateXingYuData()
end
end

function XingYuController.onLeaveXianJie(sceneType)
if not XingYuController.checkSysOpen()then
return
end
if xianjienSceneType.eXianJie==sceneType then
XingYuController:removeAllEntityData()
end
end








function XingYuController.checkSysOpen()
return limitActivitiesModel:getActInfo(LIMIT_ACT_TYPE.eXianJieXingYu)~=nil and XingYuModel:getInitFlag()
end


function XingYuController.checkHasTeam(xyId)
local len=XingYuModel:getXingYuData_teamGuidListLen(xyId)
return len~=nil and len>0
end

function XingYuController.checkCanPaiQian()
if not limitActivitiesModel:checkActOpen(LIMIT_ACT_TYPE.eXianJieXingYu)or not limitActivitiesModel:checkActDoing(LIMIT_ACT_TYPE.eXianJieXingYu)then
return false
end

local xingyuList=XingYuModel:getXingYuIdList()
if not xingyuList then
return false
end
local xyId=xingyuList[1]
local inLimtTime=XingYuController.checkInPaiQianLimtTime(xyId)
if inLimtTime then
return false
end
return not XingYuController.checkHasTeam(xyId)
end

function XingYuController.checkInPaiQianLimtTime(xyId)

local curTime=timeHelper.getServerShortTime()
local limtTime=XingYuController.getTeamDispLimit()
return curTime>=limtTime
end




function XingYuController.checkTeamLock(xyId,teamIndex)
local teamGuidList=XingYuModel:getXingYuData_teamGuidList(xyId)
if not teamGuidList then
return false
end
local guidList=teamGuidList[teamIndex]
return guidList~=nil
end

function XingYuController.checkXingYuDz(dzguid)

local xyIdList=XingYuModel:getXingYuIdList()
if not xyIdList or not limitActivitiesModel:checkActDoing(LIMIT_ACT_TYPE.eXianJieXingYu)then
return false
end
for _,xyId in ipairs(xyIdList)do
local teamGuidList=XingYuModel:getXingYuData_teamGuidList(xyId)
if teamGuidList then
for __,guidlist in pairs(teamGuidList)do
for ___,guid in ipairs(guidlist)do










if guid==dzguid then
return true
end
end
end
end
end

return false
end


function XingYuController.checkXingYuDzAndGetParams(dzguid)
local xyIdList=XingYuModel:getXingYuIdList()
if not xyIdList or not limitActivitiesModel:checkActDoing(LIMIT_ACT_TYPE.eXianJieXingYu)then
return false
end
for _,xyId in ipairs(xyIdList)do
local teamGuidList=XingYuModel:getXingYuData_teamGuidList(xyId)
if teamGuidList then
for teamIndex,guidlist in pairs(teamGuidList)do
for ___,guid in ipairs(guidlist)do










if guid==dzguid then
return true,xyId,teamIndex
end
end
end
end
end

return false
end

function XingYuController.checkXingYuHasZDRound(xyId,round)
local sumRound=XingYuModel:getXingYuData_zdzSumRound(xyId)
if sumRound==0 and round==1 then
local cnt=XingYuModel:getXingYuData_zdzTeamCnt(xyId)
return cnt and cnt>0
end
return round<=sumRound
end

function XingYuController.checkXingYuTeamFail(xyId,teamIndex)
local zdzFightTemp=XingYuModel:getXingYuData_zdzFightTemp(xyId,teamIndex)
if zdzFightTemp then
if zdzFightTemp.tsqFail==1 or zdzFightTemp.glttFlag==1 then
return true,FailType.eTanSuo,0
elseif zdzFightTemp.hzFailIndex>0 then
return true,FailType.eHunZhan,zdzFightTemp.hzFailIndex
elseif zdzFightTemp.zdzFailIndex>0 then
return true,FailType.eZhenDuo,zdzFightTemp.zdzFailIndex
end
end

local hzFightTemp=XingYuModel:getXingYuData_hzFightTemp(xyId,teamIndex)
if hzFightTemp then
if hzFightTemp.tsqFail==1 or hzFightTemp.glttFlag==1 then
return true,FailType.eTanSuo,0
elseif hzFightTemp.hzFailIndex>0 then
return true,FailType.eHunZhan,hzFightTemp.hzFailIndex
end
end
return false
end

function XingYuController.checkXingYuStateTeamRival(xyId,teamIndex,state)
if state==XingYuState.eHunZhan then
local hzFightTemp=XingYuModel:getXingYuData_hzFightTemp(xyId,teamIndex)
if hzFightTemp then
return not mathHelper.compareInt64(hzFightTemp.rActorId,Int64_0)
end
else
local zdzFightTemp=XingYuModel:getXingYuData_zdzFightTemp(xyId,teamIndex)
if zdzFightTemp then
return not mathHelper.compareInt64(zdzFightTemp.rActorId,Int64_0)
end
end
return false
end



function XingYuController.checkXingYuLimtDz(xyId,guid)

local xyCfg=XingYuModel:getXingYuConfig(xyId)
local jjLevel=xyCfg.jjLevel
local guiddata=UIDiscipleModel:getDiscipleDataX(guid)

if not guiddata then
return true
end
local netdata=guiddata.netData.net
if netdata.jingjielv<jjLevel then
return true
end
local envId=XingYuModel:getXingYuData_envId(xyId)
if not envId then

return false
end
local hjCfg=XingYuModel:getXingYuHuanJingConfig(envId)
if not hjCfg.limit then
return false
end
return XingYuController.checkLimt(hjCfg.limit,guid)
end

function XingYuController.checkLimt(limitCfg,guid)
for i,v in ipairs(limitCfg)do
local type=v[1]
if type==1 then
local netdata=UIDiscipleModel:getDiscipleDataX(guid).netData.net
local image=UIDiscipleModel.calculationDiscipleImageBase(netdata)
if image.job==v[2]then
return true
end
elseif type==2 then
if not UIDiscipleModel:getDiscipleSpecialityByID(guid,v[2],v[3])then
return true
end
end
end
return false
end

function XingYuController.checkXingYuHasLimt(xyId)
local envId=XingYuModel:getXingYuData_envId(xyId)
if not envId then

return false
end
local hjCfg=XingYuModel:getXingYuHuanJingConfig(envId)
return hjCfg.limit~=nil
end


function XingYuController.checkAllXingYuHasHZTeamCnt()
local xyIdList=XingYuModel:getXingYuIdList()
if not xyIdList then
return false
end
for i,xyId in ipairs(xyIdList)do
local cnt=XingYuModel:getXingYuData_hzTeamCnt(xyId)
if not cnt or cnt==0 then
return false
end
end
return true
end


function XingYuController.checkAllXingYuHasZDZTeamCnt()
local xyIdList=XingYuModel:getXingYuIdList()
if not xyIdList then
return false
end
for i,xyId in ipairs(xyIdList)do
local cnt=XingYuModel:getXingYuData_zdzTeamCnt(xyId)
if not cnt or cnt==0 then
return false
end
end
return true
end

function XingYuController.checkXingYuReddot()
local flag=false
if limitActivitiesModel:checkActDoing(LIMIT_ACT_TYPE.eXianJieXingYu)then
flag=XingYuController.checkLastXingYuRecv()
else
flag=XingYuController.checkXingYuRecv()
end
return flag
end

function XingYuController.checkLastXingYuRecv()
local lastxyIdList=XingYuModel:getLastXingYuIdList()
if lastxyIdList then
for i,xyId in ipairs(lastxyIdList)do
local xyData=XingYuModel:getLastXingYuData(xyId)
if xyData and xyData._hasRw and xyData._rwFlag==0 then
return true,xyId
end
end
end
return false
end

function XingYuController.checkXingYuRecv()
local xyIdList=XingYuModel:getXingYuIdList()
if xyIdList then
for i,xyId in ipairs(xyIdList)do
local xyData=XingYuModel:getXingYuData(xyId)
if xyData and xyData._hasRw and xyData._rwFlag==0 then
return true,xyId
end
end
end
return false
end

function XingYuController.checkFirstReddot()
if limitActivitiesModel:checkActOpen(LIMIT_ACT_TYPE.eXianJieXingYu)and limitActivitiesModel:checkActDoing(LIMIT_ACT_TYPE.eXianJieXingYu)then
local localCfg=userActorArraySetting.getBase(ACTOR_SETTING_TYPE.eXingYu,{})
return localCfg["FirstReddot"]~=1
end
return false
end

function XingYuController.checkShowFlyIconFlag()
if limitActivitiesModel:checkActOpen(LIMIT_ACT_TYPE.eXianJieXingYu)and limitActivitiesModel:checkActDoing(LIMIT_ACT_TYPE.eXianJieXingYu)then
local localCfg=userActorArraySetting.getBase(ACTOR_SETTING_TYPE.eXingYu,{})
return localCfg["ShowFlyIconFlag"]~=1
end
return false
end







function XingYuController.getXingYuState(xyId)
if not limitActivitiesModel:checkActDoing(LIMIT_ACT_TYPE.eXianJieXingYu)then
return XingYuState.eNone
end
local curTime=timeHelper.getServerShortTime()
local tansuoEndTime=XingYuController.getTanSuoEndTime()
if curTime<tansuoEndTime then
return XingYuState.eTanSuo,tansuoEndTime
end
local hunzhanEndTime=XingYuController.getHunZhanEndTime()
if curTime<hunzhanEndTime then
return XingYuState.eHunZhan,hunzhanEndTime
end

local zhendouEndTime=XingYuController.getZhenDouEndTime(xyId)
if zhendouEndTime then
if curTime<zhendouEndTime then
return XingYuState.eZhenDuo,zhendouEndTime
end
end
local actInfo=limitActivitiesModel:getActInfo(LIMIT_ACT_TYPE.eXianJieXingYu)
return XingYuState.eFinish,actInfo.end_time
end

function XingYuController.getTanSuoEndTime()
local baseCfg=XingYuModel:getXingYuBaseConfig()
local tansuoEndTime=baseCfg.tansuoEndTime
return XingYuController.changeTime(tansuoEndTime)
end

function XingYuController.getTeamDispLimit()
local baseCfg=XingYuModel:getXingYuBaseConfig()
local teamDispLimit=baseCfg.teamDispLimit
return XingYuController.changeTime(teamDispLimit)
end

function XingYuController.getHunZhanEndTime()
local baseCfg=XingYuModel:getXingYuBaseConfig()
local hunzhanEndTime=baseCfg.hunzhanEndTime
return XingYuController.changeTime(hunzhanEndTime)
end

function XingYuController.getZhenDouEndTime(xyId)
local baseCfg=XingYuModel:getXingYuBaseConfig()
local zhengduoTime=baseCfg.zhengduoTime
local allCnt=XingYuModel:getXingYuData_zdzSumRound(xyId)
local endTimeCfg=zhengduoTime[allCnt]
if not endTimeCfg then
return
end
return XingYuController.changeTime(endTimeCfg)
end

function XingYuController.getHuanjingList(xyId)
local envId=XingYuModel:getXingYuData_envId(xyId)
if not envId then
logErr("getHuanjinLing -->> envId nil",xyId)
return
end

local refreshFlag=false
local localCfg=userActorArraySetting.getBase(ACTOR_SETTING_TYPE.eXingYu,{})
local xyLocalCfg=localCfg[tostring(xyId)]
if not xyLocalCfg or type(xyLocalCfg)=="number"then
localCfg[tostring(xyId)]={}
xyLocalCfg=localCfg[tostring(xyId)]
end
local hjCfg=XingYuModel:getXingYuHuanJingConfig(envId)
local list={}
if hjCfg.fzList then
for i,v in ipairs(hjCfg.fzList)do
local newFlag=true
if xyLocalCfg.fzList then
for i,vv in ipairs(xyLocalCfg.fzList)do
if table.equals(v,vv)then
newFlag=false
break
end
end
end
if newFlag and not refreshFlag then
refreshFlag=true
end
list[#list+1]={id=v[1],parms=v[2],type=XYHJTYPE.eFaZe,newFlag=newFlag}
end
end

if hjCfg.limit then
for i,v in ipairs(hjCfg.limit)do
local parms={}
for ii=2,#v do
table.insert(parms,v[ii])
end

local newFlag=true
if xyLocalCfg.limit then
for i,vv in ipairs(xyLocalCfg.limit)do
if table.equals(v,vv)then
newFlag=false
break
end
end
end
if newFlag and not refreshFlag then
refreshFlag=true
end

list[#list+1]={id=v[1],parms=parms,type=XYHJTYPE.eLimit,newFlag=newFlag}
end
end

if refreshFlag then
xyLocalCfg.fzList=hjCfg.fzList
xyLocalCfg.limit=hjCfg.limit
userActorArraySetting.setBase(ACTOR_SETTING_TYPE.eXingYu,localCfg)
userActorArraySetting.flush(ACTOR_SETTING_TYPE.eXingYu)
end
return list
end


function XingYuController.getXingYuRewardList(xyId)
local tsList=XingYuController.getTanSuoRewardList(xyId)
local hzList=XingYuController.getHunZhanRewardList(xyId)
local zdList=XingYuController.getZhenDouRewardList(xyId)

local lookup={}
local List={}
local fList={tsList,hzList,zdList}
for i,_list in ipairs(fList)do
for k,v in pairs(_list)do
local itemId=k
local num=v
local pos=lookup[itemId]
if pos then
List[pos][2]=List[pos][2]+num
else
pos=#List+1
List[pos]={itemId,num}
lookup[itemId]=pos
end
end
end
return List
end



function XingYuController.getTanSuoRewardList(xyId)
local xyCfg=XingYuModel:getXingYuConfig(xyId)
local tsItems=xyCfg.tsItems
local tsBigItems=xyCfg.tsBigItems
local alltsRwId={}
for i,v in ipairs(tsItems)do
alltsRwId[#alltsRwId+1]=v[1]
end
for i,v in ipairs(tsBigItems)do
alltsRwId[#alltsRwId+1]=v[1]
end





local list={}
for _,tsRewardId in ipairs(alltsRwId)do


local items=cfgHelper.get(cfg_xingyutansuorewardconfig_get,tsRewardId,"items")
for __,v2 in ipairs(items)do
local itemId=v2[1]
local num=v2[2]
if list[itemId]then
list[itemId]=list[itemId]+num
else
list[itemId]=num
end
end

local items2=cfgHelper.get(cfg_xingyutansuorewardconfig_get,tsRewardId,"items2")
for __,v2 in ipairs(items2)do
local itemId=v2[1]


local num=v2[2]
if list[itemId]then
list[itemId]=list[itemId]+num
else
list[itemId]=num
end
end
end

local allEvId={}
local event=xyCfg.event
local specialEvent=xyCfg.specialEvent
local allEvId={}
for i,v in ipairs(event)do
allEvId[#allEvId+1]=v[1]
end
for i,v in ipairs(specialEvent)do
allEvId[#allEvId+1]=v[1]
end
for _,evId in ipairs(allEvId)do
local result=cfgHelper.get(cfg_xingyueventconfig_get,evId,"result")

if result and result[1]==1 then
for __,v in ipairs(result[2])do
local itemId=v[1]
local num=v[2]
if list[itemId]then
list[itemId]=list[itemId]+num
else
list[itemId]=num
end
end
end
end
return list
end

function XingYuController.getHunZhanRewardList(xyId)
local xyCfg=XingYuModel:getXingYuConfig(xyId)
local color=xyCfg.color
local cfg=cfgHelper.get(cfg_xingyuhunzhanrewardconfig_get,color)
local list={}
for _,v in ipairs(cfg)do
local winRewards=v.winRewards
local lostRewards=v.lostRewards
for __,v2 in ipairs(winRewards)do
local itemId=v2[1]
local num=v2[2]
if list[itemId]then
list[itemId]=list[itemId]+num
else
list[itemId]=num
end
end
for __,v2 in ipairs(lostRewards)do
local itemId=v2[1]
local num=v2[2]
if list[itemId]then
list[itemId]=list[itemId]+num
else
list[itemId]=num
end
end
end
return list
end

function XingYuController.getZhenDouRewardList(xyId)
local xyCfg=XingYuModel:getXingYuConfig(xyId)
local color=xyCfg.color
local cfg=cfgHelper.get(cfg_xingyuzhengduozhanrewardconfig_get,color)
local list={}
for _,v in ipairs(cfg)do
local winRewards=v.winRewards
local lostRewards=v.lostRewards
for __,v2 in ipairs(winRewards)do
local rwid=v2[1]
local cfg=cfgHelper.get(cfg_xingyuzhengduozhanjiangliconfig_get,rwid)
for ___,v3 in ipairs(cfg.winRewards)do
local itemId=v3[1]
local num=v3[2]
if list[itemId]then
list[itemId]=list[itemId]+num
else
list[itemId]=num
end
end
end
for __,v2 in ipairs(lostRewards)do
local itemId=v2[1]
local num=v2[2]
if list[itemId]then
list[itemId]=list[itemId]+num
else
list[itemId]=num
end
end
end
return list
end

function XingYuController.getZhenDouRoundWinRewardList(xyId,round,nonOverlap)

local sumRound=XingYuModel:getXingYuData_zdzSumRound(xyId)
local cnt=XingYuModel:getXingYuData_zdzTeamCnt(xyId)
if sumRound<0 or cnt<=0 then
return{}
end
sumRound=sumRound==0 and 1 or sumRound
local realLun=sumRound-round+1

local xyCfg=XingYuModel:getXingYuConfig(xyId)
local color=xyCfg.color
local colorcfg=cfgHelper.get(cfg_xingyuzhengduozhanrewardconfig_get,color)
local list={}
local luncfg=colorcfg[realLun]

local winRewards=luncfg.winRewards
for __,v2 in ipairs(winRewards)do
local rwid=v2[1]
local cfg=cfgHelper.get(cfg_xingyuzhengduozhanjiangliconfig_get,rwid)
for ___,v3 in ipairs(cfg.winRewards)do
local itemId=v3[1]
local num=v3[2]
if nonOverlap then
table.insert(list,{itemId,num})
else
if list[itemId]then
list[itemId]=list[itemId]+num
else
list[itemId]=num
end
end
end
end

return list
end


function XingYuController.getXingYuTeamDzList_TeamIndex(xyId,teamIndex)
local teamGuidList=XingYuModel:getXingYuData_teamGuidList(xyId)
if not teamGuidList then
return
end
return teamGuidList[teamIndex]
end

function XingYuController.getXingYuTeamPosDzList_TeamIndex(xyId,teamIndex)
local teamPosGuidList=XingYuModel:getXingYuData_teamPosGuidList(xyId)
if not teamPosGuidList then
return
end
return teamPosGuidList[teamIndex]
end

function XingYuController.getXingYuTeamFight_TeamIndex(xyId,teamIndex)
local teamFightList=XingYuModel:getXingYuData_teamFightList(xyId)
if not teamFightList then
return 0
end
return teamFightList[teamIndex]or 0
end

function XingYuController.getXingYuTeamJiYuan_TeamIndex(xyId,teamIndex)
local teamJiYuanList=XingYuModel:getXingYuData_teamJiYuanList(xyId)
if not teamJiYuanList then
return 0
end
return teamJiYuanList[teamIndex]or 0
end

function XingYuController.getHasTeamXingYuList()
local list={}
local xyIdList=XingYuModel:getXingYuIdList()
if xyIdList then
for i,xyId in ipairs(xyIdList)do
if XingYuController.checkHasTeam(xyId)then
table.insert(list,xyId)
end
end
end
return list
end

function XingYuController.getNextTSRewardLerpTime()
local baseCfg=XingYuModel:getXingYuBaseConfig()
local tansuoAwardTime=baseCfg.tansuoAwardTime
local curTime=timeHelper.getServerShortTime()
for i,v in ipairs(tansuoAwardTime)do
local time=XingYuController.changeTime(v)
if curTime<=time then
return time-curTime
end
end
return nil
end


function XingYuController.getXingYuTeamRewardList_TeamIndex(xyId,teamIndex)
local xingyuReward=XingYuModel:getXingYuData_teamReward(xyId,teamIndex)
if not xingyuReward then
return
end
return xingyuReward.allRewardList
end

function XingYuController.getRound(cnt,limt)
local round=0
if cnt then
while cnt>1 do
if limt and cnt<=limt then
break
end
round=round+1
cnt=math.ceil(cnt/2)
end
end
return round
end

function XingYuController.getTriConditionStr(cfgCnd)
local str=""
local cnd=cfgCnd[1]
local type=cnd[1]

if type==1 then
local spetype=cnd[2]
local speId=cnd[3]
local specialityConfig
if spetype==DISCIPLE_SPECIALITY_TYPE.eSpiritRoot then
specialityConfig=cfg_disciplespiritrootbookconfig_get(speId)
else
specialityConfig=UIDiscipleModel:getSpecialityConfig(spetype,speId)
end
str=FMT.fmt("队伍任意弟子拥有{0}特质有几率触发",specialityConfig.name)
elseif type==2 then
local spetype=cnd[2]
local speId=cnd[3]
local specialityConfig
if spetype==DISCIPLE_SPECIALITY_TYPE.eSpiritRoot then
specialityConfig=cfg_disciplespiritrootbookconfig_get(speId)
else
specialityConfig=UIDiscipleModel:getSpecialityConfig(spetype,speId)
end
str=FMT.fmt("队伍所有弟子拥有{0}特质有几率触发",specialityConfig.name)
elseif type==3 then
local attrId=cnd[2]
local needValue=cnd[3]
local attrConfig=equipsConfig.getAttributesconfig(attrId)
local name=attrConfig.attrname
str=FMT.fmt("队伍任意弟子{0}属性达到{1}以上有几率触发",name,needValue)
elseif type==4 then
local attrId=cnd[2]
local needValue=cnd[3]
local attrConfig=equipsConfig.getAttributesconfig(attrId)
local name=attrConfig.attrname
str=FMT.fmt("队伍所有弟子{0}总属性达到{1}以上有几率触发",name,needValue)
end
return str
end

function XingYuController.getHZRoundFightTime(round)
local baseCfg=XingYuModel:getXingYuBaseConfig()
local hunzhanTime=baseCfg.hunzhanTime
local roundTime=hunzhanTime[round]
if not roundTime then
logErr("没有星域混战对战轮次时间",round)
return
end
return XingYuController.changeTime(roundTime)
end

function XingYuController.getZDRoundFightTime(round)
local baseCfg=XingYuModel:getXingYuBaseConfig()
local zhengduoTime=baseCfg.zhengduoTime
local roundTime=zhengduoTime[round]
if not roundTime then
logErr("没有星域争夺战对战轮次时间",round)
return
end
return XingYuController.changeTime(roundTime)
end


function XingYuController.getHZRoundTeamCnt(xyId,round)
local Cnt=XingYuModel:getXingYuData_hzTeamCnt(xyId)
local _round=0
if Cnt then
while Cnt>1 do
if Cnt<=32 then
return Cnt
end
_round=_round+1
if _round==round then
return Cnt
end
Cnt=math.ceil(Cnt/2)
end
end
return Cnt
end

function XingYuController.getHZRoundRwList(xyId,round,winFlag,level)
local sumRound=XingYuModel:getXingYuData_hzSumRound(xyId)
local cnt=XingYuModel:getXingYuData_hzTeamCnt(xyId)
if sumRound<0 or cnt<=0 then
return{}
end
sumRound=sumRound==0 and 1 or sumRound

local xyCfg=XingYuModel:getXingYuConfig(xyId)
local color=xyCfg.color
local colorCfg=cfgHelper.get(cfg_xingyuhunzhanrewardconfig_get,color)
local realLun=sumRound-round+1
local rwList=winFlag and colorCfg[realLun].winRewards or colorCfg[realLun].lostRewards

if level then
local dwRewards=colorCfg[realLun].dwRewards[level]
if dwRewards then
rwList=table.concatTable(dwRewards[winFlag and 1 or 2],rwList)
end
end
return rwList
end

function XingYuController.getZDRoundRwList(xyId,round,winFlag,level)
local sumRound=XingYuModel:getXingYuData_zdzSumRound(xyId)
local cnt=XingYuModel:getXingYuData_zdzTeamCnt(xyId)
if sumRound<0 or cnt<=0 then
return{}
end
sumRound=sumRound==0 and 1 or sumRound
local realLun=sumRound-round+1
















local rwId=XingYuModel:getXingYuData_zdzRoundRwId(xyId,realLun)
if not rwId then
logErr("拿不到争夺战获胜奖励id失败",round,realLun)
return
end
local cfg=cfgHelper.get(cfg_xingyuzhengduozhanjiangliconfig_get,rwId)

local list=winFlag and cfg.winRewards or cfg.lostRewards

if level and level>0 then
local dwRewards=cfg.dwRewards[level]
if dwRewards then
list=table.concatTable(dwRewards[winFlag and 1 or 2],list)
end
end

return list
end

function XingYuController.getHZNextRound(xyId)
local hzSumRound=XingYuModel:getXingYuData_hzSumRound(xyId)
if hzSumRound>0 then
local curTime=timeHelper.getServerShortTime()
for nextR=1,hzSumRound do
if XingYuController.getHZRoundFightTime(nextR)>curTime then
return nextR
end
end
end
return
end

function XingYuController.getHZNextRoundEx(xyId)
local hzSumRound=XingYuModel:getXingYuData_hzSumRound(xyId)
if hzSumRound>0 then
local curTime=timeHelper.getServerShortTime()
for nextR=1,hzSumRound do
if XingYuController.getHZRoundFightTime(nextR)>=curTime then
return nextR
end
end
end
return
end

function XingYuController.getZDZNextRound(xyId)
local Cnt=XingYuModel:getXingYuData_zdzTeamCnt(xyId)
local _round=0
local curTime=timeHelper.getServerShortTime()
if Cnt then
while Cnt>1 do
_round=_round+1
if XingYuController.getZDRoundFightTime(_round)>curTime then
return _round
end
Cnt=math.ceil(Cnt/2)
end
end
return
end

function XingYuController.getZDZNextRoundEx(xyId)
local Cnt=XingYuModel:getXingYuData_zdzTeamCnt(xyId)
local _round=0
local curTime=timeHelper.getServerShortTime()
if Cnt then
while Cnt>1 do
_round=_round+1
if XingYuController.getZDRoundFightTime(_round)>=curTime then
return _round
end
Cnt=math.ceil(Cnt/2)
end
end
return
end

function XingYuController.getXingYuReddotCnt()
local cnt=0
if limitActivitiesModel:checkActDoing(LIMIT_ACT_TYPE.eXianJieXingYu)then
cnt=XingYuController.getLastXingYuRecvCnt()
else
cnt=XingYuController.getXingYuRecvCnt()
end
return cnt
end

function XingYuController.getLastXingYuRecvCnt()
local lastxyIdList=XingYuModel:getLastXingYuIdList()
local cnt=0
if lastxyIdList then
for i,xyId in ipairs(lastxyIdList)do
local xyData=XingYuModel:getLastXingYuData(xyId)
if xyData and xyData._hasRw and xyData._rwFlag==0 then
cnt=cnt+1
end
end
end
return cnt
end

function XingYuController.getXingYuRecvCnt()
local xyIdList=XingYuModel:getXingYuIdList()
local cnt=0
if xyIdList then
for i,xyId in ipairs(xyIdList)do
local xyData=XingYuModel:getXingYuData(xyId)
if xyData and xyData._hasRw and xyData._rwFlag==0 then
cnt=cnt+1
end
end
end
return cnt
end

function XingYuController.getOdds(xingyuId,teamIndex,rfight)

local sfight=XingYuController.getXingYuTeamFight_TeamIndex(xingyuId,teamIndex)





local baseCfg=XingYuModel:getXingYuBaseConfig()
local hunzhanFormula=baseCfg.hunzhanFormula
local hFlag=sfight>=rfight
local fLeft=hFlag and sfight/rfight-1 or rfight/sfight-1

for i,v in ipairs(hunzhanFormula)do
if v[1]<fLeft and((v[2]~=-1 and fLeft<=v[2])or v[2]==-1)then
if hFlag then
return v[3]/100,v[4]/100
else
return v[4]/100,v[3]/100
end
end
end
return 0,0
end


function XingYuController.getXingYuTeamAdd_TeamIndex(xingyuId,teamIndex)
local fight=XingYuController.getXingYuTeamFight_TeamIndex(xingyuId,teamIndex)
return XingYuController.getAddValue(fight)
end

function XingYuController.getAddValue(fight)
local baseCfg=XingYuModel:getXingYuBaseConfig()
local tsrwPercent=baseCfg.tsrwPercent
for i,v in ipairs(tsrwPercent)do
if v[1]<fight and((v[2]~=-1 and fight<=v[2])or v[2]==-1)then
return v[3],i
end
end
return 0,0
end

function XingYuController.getOpenZSLogTime(xyId)
local localCfg=userActorArraySetting.getBase(ACTOR_SETTING_TYPE.eXingYu,{})
if not localCfg["OpenZSLogTimeList"]then
return 0
end
local OpenXyLogTimeList=localCfg["OpenZSLogTimeList"]
return OpenXyLogTimeList[tostring(xyId)]or 0
end

function XingYuController.getOpenXYLogTime(xyId)
local localCfg=userActorArraySetting.getBase(ACTOR_SETTING_TYPE.eXingYu,{})
if not localCfg["OpenXYLogTimeList"]then
return 0
end
local OpenXyLogTimeList=localCfg["OpenXYLogTimeList"]
return OpenXyLogTimeList[tostring(xyId)]or 0
end

function XingYuController:getFirstPaiQianFlag(xingyuId)
return self.firstPaiQianList[xingyuId]
end


function XingYuController:getZDZFightData(xyId,round,actorId,teamIdnex)

local fightInfoList=XingYuModel:getXingYuData_zdzSequenceList(xyId,round)
if not fightInfoList then

return
end
local data
for i,sequenceTemp in ipairs(fightInfoList)do
local player1=sequenceTemp[1]
local player2=sequenceTemp[2]
if(mathHelper.compareInt64(player1.actorId,actorId)and player1.teamIndex==teamIdnex)or
(mathHelper.compareInt64(player2.actorId,actorId)and player2.teamIndex==teamIdnex)then

data=sequenceTemp
break
end
end
return data
end




function XingYuController.setFirstReddot()
if limitActivitiesModel:checkActOpen(LIMIT_ACT_TYPE.eXianJieXingYu)and limitActivitiesModel:checkActDoing(LIMIT_ACT_TYPE.eXianJieXingYu)then
local localCfg=userActorArraySetting.getBase(ACTOR_SETTING_TYPE.eXingYu,{})
if not localCfg["FirstReddot"]or localCfg["FirstReddot"]~=1 then
localCfg["FirstReddot"]=1
userActorArraySetting.setBase(ACTOR_SETTING_TYPE.eXingYu,localCfg)
userActorArraySetting.flush(ACTOR_SETTING_TYPE.eXingYu)
end
end
end

function XingYuController.setShowFlyIconFlag()









local localCfg=userActorArraySetting.getBase(ACTOR_SETTING_TYPE.eXingYu,{})
if not localCfg["ShowFlyIconFlag"]or localCfg["ShowFlyIconFlag"]~=1 then

localCfg["ShowFlyIconFlag"]=1
userActorArraySetting.setBase(ACTOR_SETTING_TYPE.eXingYu,localCfg)
userActorArraySetting.flush(ACTOR_SETTING_TYPE.eXingYu)
end
end

function XingYuController.setOpenZSLogTime(xyId)
local localCfg=userActorArraySetting.getBase(ACTOR_SETTING_TYPE.eXingYu,{})
if not localCfg["OpenZSLogTimeList"]then
localCfg["OpenZSLogTimeList"]={}
end
local OpenXyLogTimeList=localCfg["OpenZSLogTimeList"]
OpenXyLogTimeList[tostring(xyId)]=timeHelper.getServerShortTime()
userActorArraySetting.setBase(ACTOR_SETTING_TYPE.eXingYu,localCfg)
userActorArraySetting.flush(ACTOR_SETTING_TYPE.eXingYu)
end

function XingYuController.setOpenXYLogTime(xyId)
local localCfg=userActorArraySetting.getBase(ACTOR_SETTING_TYPE.eXingYu,{})
if not localCfg["OpenXYLogTimeList"]then
localCfg["OpenXYLogTimeList"]={}
end
local OpenXyLogTimeList=localCfg["OpenXYLogTimeList"]
OpenXyLogTimeList[tostring(xyId)]=timeHelper.getServerShortTime()
userActorArraySetting.setBase(ACTOR_SETTING_TYPE.eXingYu,localCfg)
userActorArraySetting.flush(ACTOR_SETTING_TYPE.eXingYu)
end

function XingYuController:setFirstPaiQianList(xingyuId,flag)
if not self.firstPaiQianList then
self.firstPaiQianList={}
end
self.firstPaiQianList[xingyuId]=flag
end


function XingYuController.changeTime(cfg)
if not limitActivitiesModel:checkActDoing(LIMIT_ACT_TYPE.eXianJieXingYu)then

return
end
local actInfo=limitActivitiesModel:getActInfo(LIMIT_ACT_TYPE.eXianJieXingYu)
local start_time=actInfo.start_time
local time=start_time+cfg[1]*86400+cfg[2]*3600+cfg[3]*60+cfg[4]
return time
end


function XingYuController:openXYListWin(needJump,xyId,otherArgs)
local entityData=XingYuController:getEntityData(xyId)
if entityData then
local cb=function()
local winParams={}
winParams.xyId=xyId
winParams.otherArgs=otherArgs
xianjieController:openWin("UIXYInfoListWIn",winParams)
end
if needJump then

xianjieController:jumpGrid(entityData.sceneidx,entityData.gridX_c,entityData.gridZ_c,cb,true,nil,35.6)
else
cb()
end
else

end
end


function XingYuController.freshFuncStorageBtn()
UIManager:invokeUIMethod("UIFuncStorageWin","refreshXingYuBtn")
UIManager:invokeUIMethod("UIXianJieFuncStorageWin","refreshFuncButton","XingYu")
end

function XingYuController.showGetReward()
local args={}
local flag,xyId,teamList

if limitActivitiesModel:checkActDoing(LIMIT_ACT_TYPE.eXianJieXingYu)then
flag,xyId=XingYuController.checkLastXingYuRecv()
args.rtype=1
teamList=XingYuModel:getLastXingYuData_teamList(xyId)
else
args.rtype=2
flag,xyId=XingYuController.checkXingYuRecv()
teamList=XingYuModel:getXingYuData_teamList(xyId)
end
if not flag then
UIManager.info("已全部领取")
return
end

local lookup={}
for _,xingyuTeam in ipairs(teamList or{})do
if xingyuTeam.len2>0 then
for __,v in ipairs(xingyuTeam.itemList)do
if lookup[v.param_1]then
lookup[v.param_1]=lookup[v.param_1]+v.param_2
else
lookup[v.param_1]=v.param_2
end
end
end

end
local itemList={}
for k,v in pairs(lookup)do
local color=itemsConfig.getItemColor(k)
table.insert(itemList,{k,v,color=color,showStage=true,})
end
table.sort(itemList,function(a,b)
return a.color>b.color
end)
args.xyId=xyId
args.itemList=itemList
args.teamList=teamList
UIManager:showWindow("UIXYGetRewardWin",args)
end


function XingYuController.showActorInfo(actorId,serverid,xyId,teamIndex,playerHeadInfo,name,dzguid)
local lookType=DOUFATAI_LOOK_TYPE.eXingYu_OtherTeam
if mathHelper.compareInt64(actorId,playerModel:getActorID())then
lookType=DOUFATAI_LOOK_TYPE.eXingYu_SelfTeam
end
local otherArgs={}
otherArgs.playerHeadInfo=playerHeadInfo
otherArgs.name=name
otherArgs.serverId=serverid
local callback=function(teamDzList)
local rdata={
teamList=teamDzList,




lookType=lookType,
otherArgs=otherArgs,
title="对战阵容"
}
UIManager:showWindow("UICommonLookRivalWin",rdata)
end

local args={}
args.dzguid=dzguid
args.isXianJie=true
args.serverid=serverid
args.xyId=xyId
args.teamIndex=teamIndex
otherPlayerModel:reqActorDefTeams(otherPlayerInfoType.eXingYu,actorId,args,callback,true,true)
end

function XingYuController.showFlyIconTips()
if not XingYuController.checkShowFlyIconFlag()then

return
end
XingYuController.setShowFlyIconFlag()
UIManager:showWindow("UIFlyIconWin",{guid=systemIconFlyControl.getGUID(),args={1,60,nil,"星域",finishCall=function()

UIManager:invokeUIMethod("UIXianJieMainWin","refreshTanChaBtn")
UIManager:invokeUIMethod('UIXianJieExplorationWin','refreshAllMenuItemSingleReddot',6)
UIManager:invokeUIMethod('UIXianJieExplorationXingYuWin','refreshView')

end}})
end

function XingYuController.stateChangeRefresh(endState)
UIManager:invokeUIMethod('UILimitActStorageWin','refreshTipsShow',LIMIT_ACT_TYPE.eXianJieXingYu)
end

function XingYuController.autoRePlay(data,xingyuId)
if not data then
return
end
local fightLogId=data.fightLogId

local args={}
args.eReplayType=eRePlayerType.xingyu
args.showBattle=true
local player1=data[1]
local player2=data[2]
args.player1={player1.name,player1.iconInfo}
args.player2={player2.name,player2.iconInfo}
local xyId=xingyuId
args.battleType=eBattleType.xingyu
args.fightCloseCallBack=function(battle)
loadingControl.openCloud(function()
if battle then
fightController:closeBattle(battle)
end
XingYuController.req_35_102(xyId)
end)
end

if fightLogId and fightLogId~=""then
loadingControl.openCloud(function()
if UIFullXingYuController.fightStage then
UIFullXingYuController.fightStage:close()
UIFullXingYuController.fightStage=nil
end

fightModel:setSendExtraArgs(eBattleType.xingyu,args)
fightController:send_log_list({fightLogId},args,true,true)
end,nil,true)
else

end
end





function XingYuController:createEntityDataTest(xyId,x,y)
XingYuController:removeAllEntityData()
local _entitydata={}
local sceneType=xianjienSceneType.eXianJie
local xyCfg=XingYuModel:getXingYuConfig(xyId)
local pos=xyCfg.pos
local size=xyCfg.size
_entitydata.scene=xianjieModel:getSceneIndex(sceneType)
_entitydata.size=size
_entitydata.pos={x,y}
_entitydata.xyId=xyId
local entitydata=xianjieController:createXJClass(xjDataType.eXJXingYu,_entitydata)
XingYuController:addEntityData(xyId,entitydata)
XingYuController:refreshAllEntity()
end


