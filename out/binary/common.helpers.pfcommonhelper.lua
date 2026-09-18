
pfCommonHelper={}

local _AppConfig_GetBool=CS.AppDataModel.AppConfig_GetBool
local platformSDK_UWP

local _proxy=CS.AndroidSDKProxy
local _ExecCmd=_proxy.ExecCmd
local _IOSSDKHelper=CS.IOSSDKHelper
local cjson=require'cjson'


function pfCommonHelper:init()

end


function pfCommonHelper:isRunPC()
if deviceHelper.isRunPC then
return deviceHelper.isRunPC()
else
return false
end
end



function pfCommonHelper:isRunUWP()
if platformSDK_UWP==nil then
local pfname=deviceHelper.getAppPlatform()
if pfname=="platformSDK_UWP"then
platformSDK_UWP=true
else
platformSDK_UWP=false
end
end
return platformSDK_UWP
end


function pfCommonHelper:ShowSDKUserCenter()
return _AppConfig_GetBool('ShowSDKUserCenter',false)
end



function pfCommonHelper.otherPFLogPoint(logType)
local platform_name=deviceHelper.getAppPlatform()
local EventCfg=pfPointCodeConfig[platform_name]
if EventCfg and EventCfg[logType]then
local EventCode=EventCfg[logType]
if deviceHelper.isRunAndroid()then
local EventCodeData={}
EventCodeData.EventCode=EventCode
local jsonStr=cjson.encode(EventCodeData)
_ExecCmd('pfPointLog',jsonStr)
logPoint.printPoint("pfCommonHelper.otherPFLogPoint"..logType..jsonStr)
elseif deviceHelper.isRunIOS()then
local data={}
data.eventName=EventCode
data.key=EventCode
data.value=1
local info=cjson.encode(data)
_IOSSDKHelper.CallSDKFunc("event",info)
logPoint.printPoint("pfCommonHelper.otherPFLogPoint"..logType..info)
end
end
end







pfCommonHelper.efunTrackEventName=
{
finishguide="finishguide",
JoinGroup="JoinGroup",
LaunchApp="LaunchApp",
recharge_first="recharge_first",
Rev_1="Rev_1",
Rev_3="Rev_3",
Rev_5="Rev_5",
Rev_10="Rev_10",
Rev_20="Rev_20",
Rev_50="Rev_50",
Rev_100="Rev_100",
upgradeRole_1="upgradeRole_l2",
upgradeRole_5="upgradeRole_l5",
upgradeRole_l0="upgradeRole_l10",
}






function pfCommonHelper.efunTrackEventPoint(eventName)
platformSDK:reqEfunTrackEvent(eventName)
end


function pfCommonHelper.onLevelChange(lastLevel,curLevel)
if curLevel>=10 then
pfCommonHelper.efunTrackEventPoint(pfCommonHelper.efunTrackEventName.upgradeRole_l0)
if lastLevel<2 then
pfCommonHelper.efunTrackEventPoint(pfCommonHelper.efunTrackEventName.upgradeRole_5)
pfCommonHelper.efunTrackEventPoint(pfCommonHelper.efunTrackEventName.upgradeRole_1)
elseif lastLevel<5 then
pfCommonHelper.efunTrackEventPoint(pfCommonHelper.efunTrackEventName.upgradeRole_5)
end
elseif curLevel>=5 then
pfCommonHelper.efunTrackEventPoint(pfCommonHelper.efunTrackEventName.upgradeRole_5)
if lastLevel<2 then
pfCommonHelper.efunTrackEventPoint(pfCommonHelper.efunTrackEventName.upgradeRole_1)
end
elseif curLevel>=2 then
pfCommonHelper.efunTrackEventPoint(pfCommonHelper.efunTrackEventName.upgradeRole_1)
end
pfCommonHelper.CommonLevelPoint(lastLevel,curLevel)
end


local GangAoRechargeNumber=
{
[pfCommonHelper.efunTrackEventName.Rev_1]=60,
[pfCommonHelper.efunTrackEventName.Rev_3]=180,
[pfCommonHelper.efunTrackEventName.Rev_5]=300,
[pfCommonHelper.efunTrackEventName.Rev_10]=680,
[pfCommonHelper.efunTrackEventName.Rev_20]=1280,
[pfCommonHelper.efunTrackEventName.Rev_50]=3280,
[pfCommonHelper.efunTrackEventName.Rev_100]=6480,
}

local OuMeiRechargeNumber={
[pfCommonHelper.efunTrackEventName.Rev_1]=1,
[pfCommonHelper.efunTrackEventName.Rev_3]=3,
[pfCommonHelper.efunTrackEventName.Rev_5]=5,
[pfCommonHelper.efunTrackEventName.Rev_10]=10,
[pfCommonHelper.efunTrackEventName.Rev_20]=20,
[pfCommonHelper.efunTrackEventName.Rev_50]=50,
[pfCommonHelper.efunTrackEventName.Rev_100]=100,
}

local platformRechargePointCfg=
{
["platformSDK_iOS_EFun"]=GangAoRechargeNumber,
["platformSDK_Android_HWFT"]=GangAoRechargeNumber,
["platformSDK_PC_Efun"]=GangAoRechargeNumber,

["platformSDK_Android_HWOuMei"]=GangAoRechargeNumber,
["platformSDK_iOS_EFun_Eu"]=GangAoRechargeNumber,
["platformSDK_PC_Efun_OuMei"]=GangAoRechargeNumber,
}



local rechargeEventOrder={
pfCommonHelper.efunTrackEventName.Rev_1,
pfCommonHelper.efunTrackEventName.Rev_3,
pfCommonHelper.efunTrackEventName.Rev_5,
pfCommonHelper.efunTrackEventName.Rev_10,
pfCommonHelper.efunTrackEventName.Rev_20,
pfCommonHelper.efunTrackEventName.Rev_50,
pfCommonHelper.efunTrackEventName.Rev_100,
}



function pfCommonHelper.onRechargeChange(lastTotalRecharge,totalrecharge)
local pfName=deviceHelper.getAppPlatform()
local RechargePointCfg=platformRechargePointCfg[pfName]
if not RechargePointCfg then return end


if lastTotalRecharge==0 and totalrecharge~=0 then
pfCommonHelper.efunTrackEventPoint(pfCommonHelper.efunTrackEventName.recharge_first)
end


local maxRechargeEvent=rechargeEventOrder[#rechargeEventOrder]
local maxRechargeAmount=RechargePointCfg[maxRechargeEvent]


if lastTotalRecharge>=maxRechargeAmount then
return
end


local highestTriggeredIndex=0


for i=#rechargeEventOrder,1,-1 do
local eventName=rechargeEventOrder[i]
if totalrecharge>=RechargePointCfg[eventName]then
highestTriggeredIndex=i
break
end
end


if highestTriggeredIndex==0 then return end


pfCommonHelper.efunTrackEventPoint(rechargeEventOrder[highestTriggeredIndex])


for i=1,highestTriggeredIndex-1 do
local eventName=rechargeEventOrder[i]
if lastTotalRecharge<RechargePointCfg[eventName]then
pfCommonHelper.efunTrackEventPoint(eventName)
end
end
end




local _i1=0
local function _cindex()
_i1=_i1+1
return _i1
end

pfCommonHelper.CommonEventName=
{
sdk_30min_active=_cindex(),
custom_time_spent_min_30=_cindex(),
custom_time_spent_min_60=_cindex(),
custom_time_spent_min_180=_cindex(),
custom_time_spent_min_360=_cindex(),
custom_recharge_1=_cindex(),
custom_recharge_2=_cindex(),
custom_recharge_3=_cindex(),
custom_recharge_store_6RMB=_cindex(),
custom_recharge_store_18RMB=_cindex(),
custom_recharge_store_30RMB=_cindex(),
custom_recharge_store_68RMB=_cindex(),
custom_recharge_store_128RMB=_cindex(),
custom_recharge_store_198RMB=_cindex(),
custom_recharge_store_328RMB=_cindex(),
custom_recharge_store_648RMB=_cindex(),
custom_recharge_yueka1=_cindex(),
custom_recharge_yueka2=_cindex(),
custom_recharge_xianshu68=_cindex(),
custom_recharge_xianshu98=_cindex(),

custom_player_level=_cindex(),
custom_xinshou1=_cindex(),
custom_xinshou2=_cindex(),
custom_xinshou3=_cindex(),
custom_xinshou4=_cindex(),
custom_xinshou5=_cindex(),
custom_xinshou6=_cindex(),
custom_xinshou7=_cindex(),
custom_xinshou8=_cindex(),
custom_xinshou9=_cindex(),
custom_xinshou10=_cindex(),
custom_xinshou11=_cindex(),
custom_xinshou12=_cindex(),
custom_xinshou13=_cindex(),
custom_xinshou14=_cindex(),
custom_xinshou15=_cindex(),
custom_xinshou16=_cindex(),
custom_xinshou17=_cindex(),
custom_xinshou18=_cindex(),
custom_xinshou19=_cindex(),
custom_xinshou20=_cindex(),
custom_xinshou21=_cindex(),
custom_xinshou22=_cindex(),
custom_xinshou23=_cindex(),

custom_play_dengji_16=_cindex(),
custom_play_dengji_18=_cindex(),
custom_play_dengji_21=_cindex(),
custom_play_dengji_24=_cindex(),

custom_play_2retention=_cindex(),
custom_play_3retention=_cindex(),
custom_play_5retention=_cindex(),
custom_play_7retention=_cindex(),

custom_game_notice_close=_cindex(),
custom_create_role_button_click=_cindex(),
custom_create_role_success=_cindex(),
custom_create_role_error=_cindex(),



custom_req_loginverification=_cindex(),
custom_loginverification_success=_cindex(),
}





local commonConfig={

[pfCommonHelper.CommonEventName.sdk_30min_active]="custom_sdk_30min_active",
[pfCommonHelper.CommonEventName.custom_time_spent_min_30]="custom_time_spent_min_30",
[pfCommonHelper.CommonEventName.custom_time_spent_min_60]="custom_time_spent_min_60",
[pfCommonHelper.CommonEventName.custom_time_spent_min_180]="custom_time_spent_min_180",
[pfCommonHelper.CommonEventName.custom_time_spent_min_360]=" custom_time_spent_min_360",

[pfCommonHelper.CommonEventName.custom_recharge_1]="custom_recharge_1",
[pfCommonHelper.CommonEventName.custom_recharge_2]="custom_recharge_2",
[pfCommonHelper.CommonEventName.custom_recharge_3]="custom_recharge_3",

[pfCommonHelper.CommonEventName.custom_recharge_store_6RMB]="custom_recharge_store_25000",
[pfCommonHelper.CommonEventName.custom_recharge_store_18RMB]="custom_recharge_store_69000",
[pfCommonHelper.CommonEventName.custom_recharge_store_30RMB]="custom_recharge_store_129000",
[pfCommonHelper.CommonEventName.custom_recharge_store_68RMB]="custom_recharge_store_249000",
[pfCommonHelper.CommonEventName.custom_recharge_store_128RMB]="custom_recharge_store_499000",
[pfCommonHelper.CommonEventName.custom_recharge_store_198RMB]="custom_recharge_store_779000",
[pfCommonHelper.CommonEventName.custom_recharge_store_328RMB]="custom_recharge_store_1299000",
[pfCommonHelper.CommonEventName.custom_recharge_store_648RMB]="custom_recharge_store_2499000",

[pfCommonHelper.CommonEventName.custom_recharge_yueka1]="custom_recharge_yueka1",
[pfCommonHelper.CommonEventName.custom_recharge_yueka2]="custom_recharge_yueka2",

[pfCommonHelper.CommonEventName.custom_recharge_xianshu68]="custom_recharge_xianshu68",
[pfCommonHelper.CommonEventName.custom_recharge_xianshu98]="custom_recharge_xianshu98",

[pfCommonHelper.CommonEventName.custom_player_level]="custom_player_level",

[pfCommonHelper.CommonEventName.custom_xinshou1]="custom_xinshou1",
[pfCommonHelper.CommonEventName.custom_xinshou2]="custom_xinshou2",
[pfCommonHelper.CommonEventName.custom_xinshou3]="custom_xinshou3",
[pfCommonHelper.CommonEventName.custom_xinshou4]="custom_xinshou4",
[pfCommonHelper.CommonEventName.custom_xinshou5]="custom_xinshou5",
[pfCommonHelper.CommonEventName.custom_xinshou6]="custom_xinshou6",
[pfCommonHelper.CommonEventName.custom_xinshou7]="custom_xinshou7",
[pfCommonHelper.CommonEventName.custom_xinshou8]="custom_xinshou8",
[pfCommonHelper.CommonEventName.custom_xinshou9]="custom_xinshou9",
[pfCommonHelper.CommonEventName.custom_xinshou10]="custom_xinshou10",
[pfCommonHelper.CommonEventName.custom_xinshou11]="custom_xinshou11",
[pfCommonHelper.CommonEventName.custom_xinshou12]="custom_xinshou12",
[pfCommonHelper.CommonEventName.custom_xinshou13]="custom_xinshou13",
[pfCommonHelper.CommonEventName.custom_xinshou14]="custom_xinshou14",
[pfCommonHelper.CommonEventName.custom_xinshou15]="custom_xinshou15",
[pfCommonHelper.CommonEventName.custom_xinshou16]="custom_xinshou16",
[pfCommonHelper.CommonEventName.custom_xinshou17]="custom_xinshou17",
[pfCommonHelper.CommonEventName.custom_xinshou18]="custom_xinshou18",
[pfCommonHelper.CommonEventName.custom_xinshou19]="custom_zhaomu",
[pfCommonHelper.CommonEventName.custom_xinshou20]="custom_xinshou20",
[pfCommonHelper.CommonEventName.custom_xinshou21]="custom_xinshou21",
[pfCommonHelper.CommonEventName.custom_xinshou22]="custom_xinshou22",
[pfCommonHelper.CommonEventName.custom_xinshou23]="custom_xinshou23",

[pfCommonHelper.CommonEventName.custom_play_dengji_16]="custom_play_dengji_16",
[pfCommonHelper.CommonEventName.custom_play_dengji_18]="custom_play_dengji_18",
[pfCommonHelper.CommonEventName.custom_play_dengji_21]="custom_play_dengji_21",
[pfCommonHelper.CommonEventName.custom_play_dengji_24]="custom_play_dengji_24",

[pfCommonHelper.CommonEventName.custom_game_notice_close]="custom_game_notice_close",
[pfCommonHelper.CommonEventName.custom_create_role_button_click]="custom_create_role_button_click",
[pfCommonHelper.CommonEventName.custom_create_role_success]="custom_create_role_success",


[pfCommonHelper.CommonEventName.custom_req_loginverification]="g30061",
[pfCommonHelper.CommonEventName.custom_loginverification_success]="g30081",
}


pfPointCodeConfig=
{
["platformSDK_Android_yuenan"]=commonConfig,
["platformSDK_iOS_FeiFang"]=commonConfig,
["platformSDK_Android_HWOuMei"]=commonConfig,
["platformSDK_iOS_EFun_Eu"]=commonConfig,
["platformSDK_iOS_EFun_US"]=commonConfig,
}





local REPORT_POINTS=
{
[30]=pfCommonHelper.CommonEventName.custom_time_spent_min_30,
[60]=pfCommonHelper.CommonEventName.custom_time_spent_min_60,
[180]=pfCommonHelper.CommonEventName.custom_time_spent_min_180,
[360]=pfCommonHelper.CommonEventName.custom_time_spent_min_360,
}


function pfCommonHelper.reportOnlineTime(point,FixedReport)
local logType=REPORT_POINTS[point]
pfCommonHelper.otherPFLogPoint(logType)
if FixedReport then
pfCommonHelper.otherPFLogPoint(pfCommonHelper.CommonEventName.sdk_30min_active)
end
end


local REPORT_FirstRecharge=
{
[1]=pfCommonHelper.CommonEventName.custom_recharge_2,
[2]=pfCommonHelper.CommonEventName.custom_recharge_1,
[3]=pfCommonHelper.CommonEventName.custom_recharge_3,
}


function pfCommonHelper.reportFirstRechargeBuy1(rechargeId)
local all=cfg_firstchargeconfig()
local tempIndex=0
for i,v in pairs(all)do
tempIndex=tempIndex+1
if v.id==rechargeId then
local logType=REPORT_FirstRecharge[tempIndex]
pfCommonHelper.otherPFLogPoint(logType)
break
end
end
end


function pfCommonHelper.reportFirstRechargeBuy2(rechargeId)
local all=cfg_firstcharge2config()
local tempIndex=0
for i,v in pairs(all)do
tempIndex=tempIndex+1
if v.id==rechargeId then
local logType=REPORT_FirstRecharge[tempIndex]
pfCommonHelper.otherPFLogPoint(logType)
break
end
end
end


function pfCommonHelper.reportFirstRechargeBuy3(rechargeId)
local all=cfg_firstcharge3config()
local tempIndex=0
for i,v in pairs(all)do
tempIndex=tempIndex+1
if v.id==rechargeId then
local logType=REPORT_FirstRecharge[tempIndex]
pfCommonHelper.otherPFLogPoint(logType)
break
end
end
end


local rechargeIdMaping=
{
[1]=pfCommonHelper.CommonEventName.custom_recharge_store_6RMB,
[2]=pfCommonHelper.CommonEventName.custom_recharge_store_18RMB,
[3]=pfCommonHelper.CommonEventName.custom_recharge_store_30RMB,
[4]=pfCommonHelper.CommonEventName.custom_recharge_store_68RMB,
[5]=pfCommonHelper.CommonEventName.custom_recharge_store_128RMB,
[6]=pfCommonHelper.CommonEventName.custom_recharge_store_198RMB,
[7]=pfCommonHelper.CommonEventName.custom_recharge_store_328RMB,
[8]=pfCommonHelper.CommonEventName.custom_recharge_store_648RMB,


[34]=pfCommonHelper.CommonEventName.custom_recharge_xianshu68,
[35]=pfCommonHelper.CommonEventName.custom_recharge_xianshu98,
}



function pfCommonHelper.reportRecharge(rechargeId)
local logType=rechargeIdMaping[rechargeId]
if logType then
pfCommonHelper.otherPFLogPoint(logType)
end
end


local reportCardItemIDMapping=
{
[1]=pfCommonHelper.CommonEventName.custom_recharge_yueka1,
[2]=pfCommonHelper.CommonEventName.custom_recharge_yueka2,
}




function pfCommonHelper.reportCardItemID(ID)
local logType=reportCardItemIDMapping[ID]
if logType then
pfCommonHelper.otherPFLogPoint(logType)
end
end

local reportLevelUpMapping=
{
[2]=pfCommonHelper.CommonEventName.custom_xinshou12,
[6]=pfCommonHelper.CommonEventName.custom_xinshou23,
[16]=pfCommonHelper.CommonEventName.custom_play_dengji_16,
[18]=pfCommonHelper.CommonEventName.custom_play_dengji_18,
[21]=pfCommonHelper.CommonEventName.custom_play_dengji_21,
[24]=pfCommonHelper.CommonEventName.custom_play_dengji_24,
}



function pfCommonHelper.CommonLevelPoint(lastLevel,curLevel)
pfCommonHelper.otherPFLogPoint(pfCommonHelper.CommonEventName.custom_player_level)
local logType=reportLevelUpMapping[curLevel]
if logType then
pfCommonHelper.otherPFLogPoint(logType)
end
end


local pvSkipMapping=
{
[0]=pfCommonHelper.CommonEventName.custom_xinshou1,
[2]=pfCommonHelper.CommonEventName.custom_xinshou5,
}


function pfCommonHelper.skipPvPoint(pvIndex)
local logType=pvSkipMapping[pvIndex]
if logType then
pfCommonHelper.otherPFLogPoint(logType)
end
end


local selectClickMapping={
[1]=pfCommonHelper.CommonEventName.custom_xinshou2,
[2]=pfCommonHelper.CommonEventName.custom_xinshou3,
[3]=pfCommonHelper.CommonEventName.custom_xinshou4,
}


function pfCommonHelper.selectClickPoint(selectIndex)
local logType=selectClickMapping[selectIndex]
if logType then
pfCommonHelper.otherPFLogPoint(logType)
end
end


local taskPointMapping={
[1]=pfCommonHelper.CommonEventName.custom_xinshou6,
[10]=pfCommonHelper.CommonEventName.custom_xinshou7,
[20]=pfCommonHelper.CommonEventName.custom_xinshou8,
[21]=pfCommonHelper.CommonEventName.custom_xinshou9,
[30]=pfCommonHelper.CommonEventName.custom_xinshou10,
[40]=pfCommonHelper.CommonEventName.custom_xinshou11,
[90]=pfCommonHelper.CommonEventName.custom_xinshou13,
[91]=pfCommonHelper.CommonEventName.custom_xinshou14,
[130]=pfCommonHelper.CommonEventName.custom_xinshou16,
[145]=pfCommonHelper.CommonEventName.custom_xinshou17,
[150]=pfCommonHelper.CommonEventName.custom_xinshou18,
}


function pfCommonHelper.taskPoint(taskiD)
local logType=taskPointMapping[taskiD]
if logType then
pfCommonHelper.otherPFLogPoint(logType)
end
end


local taskPointCompletedMapping={
[280]=pfCommonHelper.CommonEventName.custom_xinshou19,
[390]=pfCommonHelper.CommonEventName.custom_xinshou21,

}


function pfCommonHelper.taskPointCompleted(taskiD)
local logType=taskPointCompletedMapping[taskiD]
if logType then
pfCommonHelper.otherPFLogPoint(logType)
end
end

local zheXianLingPointMapping=
{
[11]=pfCommonHelper.CommonEventName.custom_xinshou20,
}


function pfCommonHelper.zheXianLingPoint(id)
local logType=zheXianLingPointMapping[id]
if logType then
pfCommonHelper.otherPFLogPoint(logType)
end
end


function pfCommonHelper.changeRoleNamePoint()
pfCommonHelper.otherPFLogPoint(pfCommonHelper.CommonEventName.custom_xinshou15)
end



function pfCommonHelper.createRole(name)
local roleinfo=UICreateRoleModel:getRoleInfo()
if not pfwindowslController:Report_255_2_PF()then
if playerModel:getActorLevel()<=2 then
roleinfo.name=name
roleinfo.id=playerModel:getActorID()
roleinfo.level=playerModel:getActorLevel()
loginControl:reportCreateRole(roleinfo)
end
else
loginControl:reportCreateRole(roleinfo)
end
end



local newbieUIActionMapping=
{
[11006]=pfCommonHelper.CommonEventName.custom_xinshou19,
[11104]=pfCommonHelper.CommonEventName.custom_xinshou21,

}

local newbieUIActionEvent=
{
haoping="haoping"
}


function pfCommonHelper.newbieUIActionPoint(actionid)
local logType=newbieUIActionMapping[actionid]
if logType then
pfCommonHelper.otherPFLogPoint(logType)
end
pfCommonHelper.newbieUIActionEfun(actionid,newbieUIActionEvent.haoping)
end


local newbieUIActionMappingEfun={
[10962]={
_default={haoping=function()pfwindowslController:checkHaoPingPopUP_OuMei()end}
},
[11505]={
_default={haoping=function()pfwindowslController:checkHaoPingPopUP_OuMei()end}
}
}

function pfCommonHelper.newbieUIActionEfun(actionid,eventName)
local PfCfg=newbieUIActionMappingEfun[actionid]
if not PfCfg then return end
platformSDK.printSDK("newbieUIActionEfunx",actionid)

local platform_name=deviceHelper.getAppPlatform()
local EventCfg=PfCfg[platform_name]or PfCfg._default
if EventCfg and EventCfg[eventName]then
EventCfg[eventName]()
end
end



local systemMapping=
{

}


function pfCommonHelper.systemOpenPoint(systemid)
local logType=systemMapping[systemid]
if logType then
pfCommonHelper.otherPFLogPoint(logType)
end
end



function pfCommonHelper.closeGongGao()
pfCommonHelper.otherPFLogPoint(pfCommonHelper.CommonEventName.custom_game_notice_close)
end


function pfCommonHelper.clickCreateRole()
pfCommonHelper.otherPFLogPoint(pfCommonHelper.CommonEventName.custom_create_role_button_click)
end


function pfCommonHelper.CreateRoleSuccess()
pfCommonHelper.otherPFLogPoint(pfCommonHelper.CommonEventName.custom_create_role_success)
end


function pfCommonHelper.CreateRoleError()
pfCommonHelper.otherPFLogPoint(pfCommonHelper.CommonEventName.custom_create_role_error)
end


local LoginDay=
{
[2]=pfCommonHelper.CommonEventName.custom_play_2retention,
[3]=pfCommonHelper.CommonEventName.custom_play_3retention,
[5]=pfCommonHelper.CommonEventName.custom_play_5retention,
[7]=pfCommonHelper.CommonEventName.custom_play_7retention,
}

local DayLoginPointRecord


function pfCommonHelper.openDayLoginPoint()
local ServerOpenDay=timeHelper.getServerOpenDay()
local logType=LoginDay[ServerOpenDay]
if logType then
if not DayLoginPointRecord then
DayLoginPointRecord=userActorSetting.get("DayLoginPointRecord",0)
end
if DayLoginPointRecord<ServerOpenDay then
pfCommonHelper.otherPFLogPoint(logType)
DayLoginPointRecord=ServerOpenDay
userActorSetting.set("DayLoginPointRecord",DayLoginPointRecord)
end
end
end

local gubaoReportRecord

function pfCommonHelper.gubaoReport()
if not gubaoReportRecord then
gubaoReportRecord=userActorSetting.get("gubaoReportRecord",0)
end
if gubaoReportRecord==0 then
pfCommonHelper.otherPFLogPoint(pfCommonHelper.CommonEventName.custom_xinshou22)
gubaoReportRecord=1
userActorSetting.set("DayLoginPointRecord",gubaoReportRecord)
end
end

local DownloadProgres_OM=
{
[0]="g40026",
[20]="g40027",
[40]="g40028",
[60]="g40029",
[80]="g40030",
[100]="g40031",
}

local DownloadProgresReport=
{
["platformSDK_Android_HWOuMei"]=DownloadProgres_OM,
["platformSDK_iOS_EFun_Eu"]=DownloadProgres_OM,
["platformSDK_iOS_EFun_US"]=DownloadProgres_OM,
["platformSDK_PC_Efun_OuMei"]=DownloadProgres_OM,
}



local reportedProgress


function pfCommonHelper.DownloadProgressReport(value)
platformSDK.printSDK("DownloadProgressReport",value)
local platform_name=deviceHelper.getAppPlatform()
local EventCfg=DownloadProgresReport[platform_name]
if not EventCfg then
return
end

local valueNum=tonumber(value)or 0
local EventCode=EventCfg[valueNum]
if not EventCode then
return
end
reportedProgress=userActorSetting.get("reportedProgressRecord",-1)
if reportedProgress>valueNum then
return
end
reportedProgress=valueNum
if EventCode then

reported[currentTarget]=true

if deviceHelper.isRunAndroid()then
local EventCodeData={EventCode=EventCode}
local jsonStr=cjson.encode(EventCodeData)
_ExecCmd('pfPointLog',jsonStr)
logPoint.printPoint("pfCommonHelper.DownloadProgressReport"..currentTarget..jsonStr)

userActorSetting.set("reportedProgressRecord",reportedProgress)
platformSDK.printSDK("DownloadProgressReportXx",reportedProgress)
elseif deviceHelper.isRunIOS()then
local data={}
data.eventName=EventCode
data.key=EventCode
data.value=1
local info=cjson.encode(data)
if platform_name=="platformSDK_iOS_FeiFang"then
_IOSSDKHelper.CallSDKFunc("event",info)
else
_IOSSDKHelper.CallSDKFunc("performanceranalysis",info)
end
logPoint.printPoint("pfCommonHelper.DownloadProgressReport"..currentTarget..info)
userActorSetting.set("reportedProgressRecord",reportedProgress)
end
end

end


function pfCommonHelper.checkSkipAPICheck(apiLevel)

local platform_name=deviceHelper.getAppPlatform()
if apiLevel==432 and(platform_name=="platformSDK_Android_yuenan"or platform_name=="platformSDK_iOS_FeiFang")then
return true
end
return false
end
