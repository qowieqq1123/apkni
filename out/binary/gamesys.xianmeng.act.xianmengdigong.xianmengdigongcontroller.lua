


































local _MODULENAME="xianmengdigongController"
gameState.addListener(def_table(_MODULENAME))
xianmengdigongController.name=_MODULENAME

local newGLNoticeCnt=0


local _speRescueStamp=0
local _speRescueColdDown=10

function xianmengdigongController:_checkSpeRewardStuck()
local speRoom=xianmengdigongModel:getSpeRoomData()
if not speRoom then return false end
local ev=speRoom:getEvent(1)
if not ev then return false end
local st=ev:getState()
if st~=xmdgEventState.eReward then
return false
end
local list=xianmengdigongModel:getAllHasRewardEvent()or{}
if#list>0 then
return false
end

platformSDK.printSDK('[XMDG][speDBG][stuck.true]',
'eventId='..tostring(ev and ev.eventId),
'myRewardFlag='..tostring(ev and ev.myRewardFlag),
'startTime='..tostring(ev and ev.startTime),
'jinDu='..tostring(ev and ev.jinDu),
'dzCount='..tostring(ev and ev.dzList and#ev.dzList or 0)
)
return true
end


function xianmengdigongController:_forceResolveSpeToNextRound(reason)
local speRoom=xianmengdigongModel:getSpeRoomData()
if not speRoom then return false end
local ev=speRoom:getEvent(1)
if not ev then return false end

reason=reason or'unknown'
local ok,st=pcall(function()return ev:getState()end)
platformSDK.printSDK('[XMDG][speRescue][force]',
'reason='..tostring(reason),
'ev='..tostring(ev),
'eventId='..tostring(ev.eventId),
'myRewardFlag='..tostring(ev.myRewardFlag),
'state='..tostring(ok and st or'ERR'),
'startTime='..tostring(ev.startTime),
'jinDu='..tostring(ev.jinDu),
'dzCount='..tostring(ev.dzList and#ev.dzList or 0)
)


ev:flagReward(1)
local newEvent={}
xianmengdigongModel:initSpeEvent(newEvent)
speRoom.eventLookup[1]=newEvent
if speRoom.eventList and#speRoom.eventList>0 then
for k=1,#speRoom.eventList do
if speRoom.eventList[k]and speRoom.eventList[k].eventPos==1 then
speRoom.eventList[k]=newEvent
break
end
end
else
speRoom.eventList={newEvent}
speRoom.eventNum=1
end


if ev.eventId then
xianmengdigongModel:clearExploreTimes(ev.eventId)
end


UIManager:invokeUIMethod('UIXM_XMDG_MainWin','refreshEventBtn')
UIManager:invokeUIMethod('UIXM_XMDG_speEventWin','rec_event',speRoom,newEvent)

return true
end

function xianmengdigongController:tryRescueSpeRewardStuck(reason)
if not xianmengdigongController:_checkSpeRewardStuck()then
return false
end

local now=Time.realtimeSinceStartup or 0
if _speRescueStamp~=0 and now-_speRescueStamp<_speRescueColdDown then
return false
end
_speRescueStamp=now

reason=reason or'unknown'
platformSDK.printSDK('[XMDG][speRescue] detected','reason='..tostring(reason))

xianmengdigongController:send_20_105()

timeEventController.delayDo(1.2,function()
if not xianmengdigongController:_checkSpeRewardStuck()then
platformSDK.printSDK('[XMDG][speRescue] okAfter105','reason='..tostring(reason))
return
end
xianmengdigongController:_forceResolveSpeToNextRound('after20_105_'..tostring(reason))
end)

return true
end

function xianmengdigongController:onAppStart()
socketManager:register_receiver(20,105,xianmengdigongController.do_protocol_20_105)
socketManager:register_receiver(20,106,xianmengdigongController.do_protocol_20_106)
socketManager:register_receiver(20,107,xianmengdigongController.do_protocol_20_107)
socketManager:register_receiver(20,108,xianmengdigongController.do_protocol_20_108)
socketManager:register_receiver(20,109,xianmengdigongController.do_protocol_20_109)
socketManager:register_receiver(20,110,xianmengdigongController.do_protocol_20_110)
socketManager:register_receiver(20,111,xianmengdigongController.do_protocol_20_111)
socketManager:register_receiver(20,112,xianmengdigongController.do_protocol_20_112)
socketManager:register_receiver(20,113,xianmengdigongController.do_protocol_20_113)
socketManager:register_receiver(20,114,xianmengdigongController.do_protocol_20_114)
socketManager:register_receiver(20,115,xianmengdigongController.do_protocol_20_115)
socketManager:register_receiver(20,116,xianmengdigongController.do_protocol_20_116)
socketManager:register_receiver(20,117,xianmengdigongController.do_protocol_20_117)
socketManager:register_receiver(20,119,xianmengdigongController.do_protocol_20_119)
socketManager:register_receiver(20,132,xianmengdigongController.do_protocol_20_132)
socketManager:register_receiver(20,133,xianmengdigongController.do_protocol_20_133)
socketManager:register_receiver(20,135,xianmengdigongController.do_protocol_20_135)
socketManager:register_receiver(20,139,xianmengdigongController.do_protocol_20_139)

xianmengdigongController:onAppStart_shop()
xianmengdigongController:onAppStart_pass()
end

function xianmengdigongController:onEnterState(isReconnet)
xianmengdigongController:onEnterState_shop(isReconnet)
xianmengdigongController:onEnterState_pass(isReconnet)
xianmengdigongModel:intLookup()
xianmengdigongModel:initData_shop()
notifySystem:listenNotify(notifyConfig.onLimitActStateChange,self.onLimitActStateChange)
notifySystem:listenNotify(notifyConfig.onDiscipleCreate,self.onDiscipleCreate)
notifySystem:listenNotify(notifyConfig.onNewDay5am,self.onNewDay5am)
notifySystem:listenNotify(notifyConfig.onXianMengChange,self.onXianMengChange)
notifySystem:listenNotify(notifyConfig.on_money_changed,self.on_money_changed)


end

function xianmengdigongController:onLeaveState(isReconnet)
xianmengdigongController:onLeaveState_shop(isReconnet)
xianmengdigongController:onLeaveState_pass(isReconnet)
xianmengdigongModel:clearData()
xianmengdigongModel:clearData_shop()
newGLNoticeCnt=0
notifySystem:removelistener(notifyConfig.onLimitActStateChange,self.onLimitActStateChange)
notifySystem:removelistener(notifyConfig.onDiscipleCreate,self.onDiscipleCreate)
notifySystem:removelistener(notifyConfig.onNewDay5am,self.onNewDay5am)
notifySystem:removelistener(notifyConfig.onXianMengChange,self.onXianMengChange)
notifySystem:removelistener(notifyConfig.on_money_changed,self.on_money_changed)
end

function xianmengdigongController:onPlayerCreate(...)

end

function xianmengdigongController:onProtocolReq(isReconnet)

end

function xianmengdigongController:onLostConnection()
xianmengdigongController:onLostConnection_shop()
end

function xianmengdigongController:initAct()

xianmengdigongController:activeActivity(true)
if xianmengdigongController:checkOpen()and xianmengModel:hasXM()then
xianmengdigongController:reqInit()
xianmengdigongController:onProtocolReq_shop()
end
end

function xianmengdigongController:checkOpen()
local openday=timeHelper.getServerOpenDay_kf()
local openDay_=xianmengdigongModel:getOpenDay()
if openDay_ then
return openday>=openDay_
end
return false
end

function xianmengdigongController:activeActivity(isInit)



local s_t_,e_t_=xianmengdigongController.calculationActTime()

local actID=LIMIT_ACT_TYPE.eXianMengDiGong
if isInit then
local actcfg=cfgHelper.get1(cfg_clientxianshihuodongconfig_get,actID)
local openDay2=limitActivitiesModel.getDayConditionCfg(actcfg)
if openDay2~=nil then
local o_y2,o_m2,o_d2=timeHelper.getDateNumber(gameUtilityModel.getOpenServerLongTime())
local o_time2=timeHelper.timeServer(o_y2,o_m2,o_d2,0,0,0)
local f_o_time2=o_time2+(openDay2-1)*86400
local lerp2=e_t_-f_o_time2
if lerp2>0 and lerp2<=3*86400 then

s_t_,e_t_=xianmengdigongController.calculationActTime(e_t_+1)
end
end
end

limitActivitiesModel:addClientAct_lt(actID,s_t_,e_t_)
end

function xianmengdigongController.calculationActTime(curTime)
curTime=curTime or gameUtilityModel.getServerLongTime()

local stopTime=nil
local uniformEndTime=cfgHelper.get2(cfg_guilddigongbaseconfig_get,1,'uniformEndTime')
local ver=pfwindowslController:getGameVersion()
local pfId=gameUtilityModel.getServerPlatform_kf()
local verCfg=uniformEndTime[ver]
if verCfg~=nil then
local day=verCfg[pfId]or verCfg[-1]
if day~=nil then
stopTime=timeHelper.timeServer(day[1],day[2],day[3],0,0,0)
local w=timeHelper.getWeakDateEx2(stopTime)
if w~=5 then

stopTime=nil
end
end
end

local openDay=xianmengdigongModel:getOpenDay()

local round_time=1209600
local o_y,o_m,o_d=timeHelper.getDateNumber(gameUtilityModel.getOpenServerLongTime_kf())
local o_time=timeHelper.timeServer(o_y,o_m,o_d,0,0,0)
local f_o_time=o_time+(openDay-1)*86400
local f_o_time_w=timeHelper.getWeakDateEx2(f_o_time)
local f_e_time

if f_o_time_w==6 then

f_e_time=f_o_time+1123200
else
f_e_time=f_o_time+((6-f_o_time_w)+13)*86400
end
if stopTime~=nil then

local lerp=f_e_time-stopTime
if lerp>0 and lerp%round_time~=0 then
f_e_time=f_e_time+604800
end
end
local s_t_,e_t_

if curTime<=f_e_time then
s_t_=f_o_time+18000
e_t_=f_e_time
else
if stopTime==nil then
local lerp=curTime-f_e_time
local round=math.floor(lerp/round_time)
local o_t=f_e_time+round*round_time
s_t_=o_t+86400+18000
e_t_=o_t+round_time
else

if stopTime<f_e_time then
s_t_=f_o_time+18000
e_t_=f_e_time
else
local lerp=stopTime-f_e_time
local round=math.floor(lerp/round_time)
local o_t=f_e_time+round*round_time
s_t_=o_t+86400+18000
e_t_=o_t+round_time
if stopTime>s_t_ and stopTime<e_t_ then
e_t_=e_t_+604800
end
end

if curTime<s_t_ then
local lerp=curTime-f_e_time
local round=math.floor(lerp/round_time)
local o_t=f_e_time+round*round_time
s_t_=o_t+86400+18000
e_t_=o_t+round_time
elseif curTime>=e_t_ then
local lerp=curTime-e_t_
local round=math.floor(lerp/round_time)
local o_t=e_t_+round*round_time
s_t_=o_t+86400+18000
e_t_=o_t+round_time
end
end
end
return s_t_,e_t_
end

function xianmengdigongController.onXianMengChange(flag)
local actID=LIMIT_ACT_TYPE.eXianMengDiGong
if flag then
if xianmengdigongController:checkOpen()then
if xianmengdigongModel:checkInit()then

UIManager.close_cache_window('UIXM_XMDG_MapWin')
UIManager.close_cache_window('UIXM_XMDG_MapNoneWin')
end
xianmengdigongController:reqInit()
xianmengdigongController:onProtocolReq_shop()
end
else
UIManager:callWindowFunc('UIXM_XMDG_MainWin','onClickClose')
UIManager:callWindowFunc('UIFuncStorageWin','refreshxmdgRewardBtn')
UIManager:callWindowFunc('UIFuncStorageXMWin','refreshxmdgRewardBtn')
end
end

function xianmengdigongController.on_money_changed(moneyType,lastVal,val)
if moneyType==eMoneyType.mtDiGongXingDongLi then
UIManager:invokeUIMethod('UIXM_XMDG_eventSelectDZWin','refreshMoneyItem',lastVal)
UIManager:invokeUIMethod('UIXM_XMDG_monsterWin','refreshXDL')
UIManager:invokeUIMethod('UIXM_XMDG_bossWin','refreshXDL')
UIManager:invokeUIMethod('UILimitActStorageWin','refreshCondShow',LIMIT_ACT_TYPE.eXianMengDiGong)
end
end

function xianmengdigongController.onLimitActStateChange(actID,state,isNew)
if actID~=LIMIT_ACT_TYPE.eXianMengDiGong then return end
if state==limitActivitiesModel.actPreviewState then


elseif state==limitActivitiesModel.actDoingState then

if not isNew and xianmengdigongController:checkOpen()and xianmengModel:hasXM()then
xianmengdigongModel:markOldData()
xianmengdigongModel:actStartClearPassData()
timeEventController.delayDo(2,function()
if xianmengdigongController:checkOpen()and xianmengModel:hasXM()then
xianmengdigongController:reqInit()
xianmengdigongController:onProtocolReq_shop()
end
end)
end
elseif state==limitActivitiesModel.actIdleState then


elseif state==limitActivitiesModel.actFinishState then
timeEventController.delayDo(2,function()
limitActivitiesModel:removeActInfo(LIMIT_ACT_TYPE.eXianMengDiGong)
xianmengdigongController:activeActivity()
end)
UIManager:callWindowFunc('UIFuncStorageWin','refreshxmdgRewardBtn')
UIManager:callWindowFunc('UIFuncStorageXMWin','refreshxmdgRewardBtn')
end
end


function xianmengdigongController.onNewDay5am(islogin)
if not islogin then
xianmengdigongModel:setXDLCount(0)
xianmengdigongController:send_20_134()
end
end


function xianmengdigongController.onDiscipleCreate(dzguid)
xianmengdigongModel:addNewDZ(dzguid)
end

function xianmengdigongController:openEventRewardWin()
local actID=LIMIT_ACT_TYPE.eXianMengDiGong
if not limitActivitiesModel:checkActDoing(actID)then return end

local list=xianmengdigongModel:getAllHasRewardEvent()
if list~=nil and#list>0 then
local temp={}
local num=0
for i,d in ipairs(list)do
local rewards=d.rewards
if rewards==nil then
table.insert(temp,d)
else
num=num+1
end
end
if#temp<=0 then
if num>0 then
UIManager:showWindow('UIXM_XMDG_eventRewardWin')
end
else
local eventList={}
local uniq={}
for _,d in ipairs(temp)do
local key=tostring(d.x).."_"..tostring(d.y).."_"..tostring(d.eventPos)
if not uniq[key]then
uniq[key]=true
table.insert(eventList,{d.x,d.y,d.eventPos})
end
end
xianmengdigongController:send_20_116(eventList)

end
end
end

local fightLock=nil
function xianmengdigongController:doReqFight(room,nanDu,monsterGroupId)
local roomid=room.base.id
local yscfg=cfgHelper.get1(cfg_guilddigongyaoshouconfig_get,room.ysConfId)
local monsterType=yscfg.gwtype
local gwzId=monsterGroupId

local monsterList=cfgHelper.get2(cfg_monstergroup_get,monsterGroupId,"monList")
local winArgs=
{
enterCallBack=function(selectList,zfId,mapId)
local check=true
if fightLock and Time.realtimeSinceStartup-fightLock<10 then
check=false
end
if check then
if limitActivitiesController:checkJump(nil,LIMIT_ACT_TYPE.eXianMengDiGong)then
local room_=xianmengdigongModel:getRoom(roomid)
if not room_:checkunLock()then
local x=room_.base.x
local y=room_.base.y
fightLaunchController:sendFight(eBattleLaunch.xianmengdigong,selectList,mapId,zfId,{x,y,nanDu})

fightLock=Time.realtimeSinceStartup
else
xianmengdigongController.showRoomUnlockTips()
end
end
end
end,
enterTxt="仙盟地宫",
cancelCallBack=function()
fightController:closeSelectStage()
xianmengdigongController:finishFightOpen()
end,
groupId=monsterGroupId,
monsterList=monsterList,
skipShouYuanCheck=true,
skipDiscipleStateCheck=true,
skipDiscipleInjuryCheck=true,
statePriorityCheck=false,
editorTeam=false,
needSaveTeam=false,
showZhenFa=false,
notNeedDealOverTime=true,
dontCloseStage=true,

}
local dzInfoFuncList={}
local dzlist=UIDiscipleModel:getSortList()
for i,netData in ipairs(dzlist)do
local d={guid=netData.discipleguid}
xianmengdigongController:initBattleDZ(d)
dzInfoFuncList[netData.discipleguidStr]=d
end
winArgs.dzInfoFuncList=dzInfoFuncList



fightController.showPrepareWin(fightPreSelectModel.fightType.xianmengdigong,winArgs)
end



function xianmengdigongController:initBattleDZ(d)
d.checkState=function(guid,isWarning)
local hp=xianmengdigongModel:getDZBlood(guid)
if hp<=0 then
if isWarning then
UIManager.error('弟子已阵亡')
end
return false
end








return true
end
d.getStateIcon=function(guid)
local hp=xianmengdigongModel:getDZBlood(guid)
if hp<=0 then
return'image_yizhenwang_1'
end




return nil
end
d.getBlood=function(guid)
local hp=xianmengdigongModel:getDZBlood(guid)
local str=FMT.fmt('{0}%',hp/100)
return{hp/10000}
end
d.checkMask=function(guid)
local hp=xianmengdigongModel:getDZBlood(guid)
if hp<=0 then
return true
end
return false
end
end

function xianmengdigongController:finishFightOpen(fightData)
local targetPos,jumpClick
if fightData then
targetPos={fightData.x,fightData.y}
jumpClick=true
end
limitActivitiesController:jump(LIMIT_ACT_TYPE.eXianMengDiGong,{showCloud=false,targetPos=targetPos,jumpClick=true})
end

function xianmengdigongController:finishFight(result,fightData)
if result~=fightResultType.Victory then

end
xianmengdigongController:finishFightOpen(fightData)
end


function xianmengdigongController:onBattleBack(result,data)








fightLock=nil
if result==fightResultType.Victory then

local room=xianmengdigongModel:getRoom2(data.x,data.y)
local yscfg=cfgHelper.get1(cfg_guilddigongyaoshouconfig_get,room.ysConfId)
local monsterType=yscfg.gwtype
if monsterType==MONSTER_TYPE.eShouLing then
local hp=room.unlockJinDu-data.bossHurt
if hp<0 then hp=0 end
room.unlockJinDu=hp
room:setFastFlag(1,1)
if room:getBossMaxHurt()<data.bossHurt then
room:setBossMaxHurt(data.bossHurt)
end
else
local add=yscfg.gwzList[data.nanDu][2]
local hp=room.unlockJinDu+add
if hp>10000 then hp=10000 end
room.unlockJinDu=hp
room:setFastFlag(data.nanDu,1)
end
if room:checkunLock()then
xianmengdigongModel:setUnlockRoom(room.base.id)
end

if data.dzList and data.len>0 then
for i,dz in ipairs(data.dzList)do
xianmengdigongModel:setDZBlood(dz.guid,dz.hp)
end
end


xianmengdigongModel:getAllEventSequenceList_doing_idle(true)
end
end

function xianmengdigongController:jump(x,y)
local win=UIManager:findActiveWindow('UIXM_XMDG_MainWin')
if win then
local room=xianmengdigongModel:getRoom2(x,y)
if room then
UIManager:invokeUIMethod('UIXM_XMDG_MainWin','jumpRoom',room)
return true
end
else
return limitActivitiesController:jump(LIMIT_ACT_TYPE.eXianMengDiGong,{targetPos={x,y}})
end
return false
end

function xianmengdigongController:onBuyXDL(isWarning)
local xdlcfg=cfgHelper.get2(cfg_guilddigongbaseconfig_get,1,'xdli')
local curcnt=xianmengdigongModel:getXDLCount()
local maxbuycnt=xdlcfg[6]
if curcnt>=maxbuycnt then
if isWarning~=false then
UIManager.error('已达今日最大购买次数')
end
return false
end

local cur=xianmengdigongModel:getXDL()
local maxXDL=xdlcfg[2]
if cur>=maxXDL then
if isWarning~=false then
UIManager.error(FMT.fmt('存量达到{0}无法进行灵玉购买',maxXDL))
end
return false
end

local lerpcnt=maxbuycnt-curcnt
local costMoneyType=xdlcfg[3]
local iconname=iconHelper.getIconName(costMoneyType)
local iconStr=chatEmotHelper.getIconEmotMesg(iconname,52)

local costs=xdlcfg[5]
local maxcnt=#costs
curcnt=curcnt+1
if curcnt>maxcnt then curcnt=maxcnt end
local usecnt=costs[curcnt]
local hasnum=moneyModel.getMoney(costMoneyType)
local numStr
if hasnum<usecnt then
numStr=FMT.fmt('<color=#FF0000>{0}</color>',usecnt)
else
numStr=FMT.fmt('<color=#549327>{0}</color>',usecnt)
end
local callback_=function()
local func=function()
xianmengdigongController:send_20_107()
end
moneySystem:useMoney(costMoneyType,usecnt,func,WARNING_TYPE.eWarning)
end
local buyName=itemsConfig.getItemName(eMoneyType.mtDiGongXingDongLi)
local contentStr=FMT.fmt('是否消耗{0}{1}购买<color=#6833c0>{2}*{3}</color>\n（今日剩余购买次数：{4}）',iconStr,numStr,buyName,xdlcfg[4],lerpcnt)
local show_data={
type='UIDialougeWithIcon',
title='提示',
content=contentStr,
oktext='确定',
canceltext='取消',
okcallback=callback_,
moneytypes={{costMoneyType}},
}
local dialog=UIDialogManager.newDialog(show_data)
dialog:show()

AudioManager.playOpenUI()
return true
end

function xianmengdigongController.showRoomUnlockTips()
UIManager.error('该房间已解锁')
end

function xianmengdigongController.getHasManTips()
return'同一个事件只能派遣一名弟子'
end

function xianmengdigongController.xdlTips()
local buyName=itemsConfig.getItemName(eMoneyType.mtDiGongXingDongLi)
UIManager.error(FMT.fmt('{0}不足',buyName))
end

function xianmengdigongController:jumpGL()
if limitActivitiesController:checkJump(nil,LIMIT_ACT_TYPE.eXianMengDiGong)then
local glid=xianmengdigongModel:getGLID()
if glid then
local room=xianmengdigongModel:getRoom(glid)
if room then
local targetPos={room.base.x,room.base.y}
return limitActivitiesController:jump(LIMIT_ACT_TYPE.eXianMengDiGong,{targetPos=targetPos})
end
else
local name=xianmengdigongModel:getGLName()
UIManager.error('仙盟地宫探索方向已被取消')
end
end
return false
end

function xianmengdigongController:checkGLChatNotice(isInit)
if limitActivitiesModel:checkActDoing(LIMIT_ACT_TYPE.eXianMengDiGong)then
local glData=xianmengdigongModel:getGLData()
local glid=xianmengdigongModel:getGLID()
if glid~=nil then
local name=xianmengdigongModel:getGLName()
local time=xianmengdigongModel:getGLTime()
if isInit or glData==nil then
local isNew=false
if glData==nil or time>glData[1]then
isNew=true
end
xianmengdigongController:sendGLChatNotice(time,name,isNew)
else
if time>glData[1]then
xianmengdigongController:sendGLChatNotice(time,name,true)
end
end









end
end
end

function xianmengdigongController:sendGLChatNotice(time,name,isNew)
local gl_str=FMT.fmt('<color=#d58c5a>{0}</color>在仙盟地宫活动地图中设置了优先探索标记，呼吁成员优先前往探索',name)
local s='<a;【点击立即前往】;1;0;2,0,4807,args = {};/>'
gl_str=FMT.fmt('{0}{1}',gl_str,s)
chatControl.onRecvSystemMesg(CHAT_MSG_TYPE.eNoFitler,chatConfig.getSystemPosValue({CHAT_CHANNNEL.eXianmeng}),gl_str,"仙盟地宫公告",false,false)
xianmengdigongModel:saveGLData(time,name)

if not isNew then
xianmengdigongController:refreshChannelChatNewNum(1)
else
newGLNoticeCnt=newGLNoticeCnt+1
end
end

function xianmengdigongController:autoReadGLChatNotice()
if newGLNoticeCnt>0 then
xianmengdigongController:refreshChannelChatNewNum(newGLNoticeCnt)
newGLNoticeCnt=0
end
end

function xianmengdigongController:refreshChannelChatNewNum(cNum)
local channelId=CHAT_CHANNNEL.eXianmeng

local nowXMMsgNum=chatControl.getNewestMesgNumByChannel(channelId)


if nowXMMsgNum>0 then
nowXMMsgNum=nowXMMsgNum-cNum
if nowXMMsgNum<0 then nowXMMsgNum=0 end


chatControl.setNewestMesgNumByChannel(channelId,nowXMMsgNum)


UIManager:callWindowFunc('UIFightMainTop','onReadNewestMesg')
chatControl.freshMain('onReadNewestMesg',channelId)
chatControl.freshChatMain('onReadNewestMesg',channelId)
chatControl.freshWorldChatMain('onReadNewestMesg',channelId)
end
end

function xianmengdigongController:clearGLChatNotice()
newGLNoticeCnt=0
end

function xianmengdigongController:levelBack(idx)
UIManager:invokeUIMethod('UIXM_XMDG_MapWin','levelBack',idx)

end



function xianmengdigongController:reqInit()
xianmengdigongController:send_20_105()
xianmengdigongController:send_20_111()
end


function xianmengdigongController:send_20_105()
socketManager:send_20_105()
end


function xianmengdigongController:send_20_106(x,y,eventPos,dzGuid,times)




socketManager:send_20_106(x,y,eventPos,dzGuid,times)
end


function xianmengdigongController:send_20_107()
socketManager:send_20_107()
end


function xianmengdigongController:send_20_108(x,y,flagGL)

socketManager:send_20_108(x,y,flagGL)
end


function xianmengdigongController:send_20_111()
socketManager:send_20_111()
end


function xianmengdigongController:send_20_112()
socketManager:send_20_112()
end


function xianmengdigongController:send_20_113(eventList)




local n=#eventList
if n>0 then
socketManager:send_20_113(n,eventList)
end
end


function xianmengdigongController:send_20_114(dzGuid,itemIndex)

socketManager:send_20_114(dzGuid,itemIndex)
end


function xianmengdigongController:send_20_116(eventList)

local n=#eventList
if n>0 then
socketManager:send_20_116(n,eventList)
end
end

function xianmengdigongController:send_20_132(roomid)
local room_=xianmengdigongModel:getRoom(roomid)
local x=room_.base.x
local y=room_.base.y
socketManager:send_20_132(x,y)
end

function xianmengdigongController:send_20_133(x,y)
socketManager:send_20_133(x,y)
end
function xianmengdigongController:send_20_134()
socketManager:send_20_134()
end

function xianmengdigongController:send_20_135(x,y,nanDu)
socketManager:send_20_135(x,y,nanDu)
end

function xianmengdigongController:send_20_139(startTimeLock,secondsLock)


local _startTimeLock,_secondsLock=xianmengdigongModel:getLockRoomData()
if _startTimeLock==startTimeLock and _secondsLock==secondsLock then
return
end
socketManager:send_20_139(startTimeLock,secondsLock)
end





function xianmengdigongController.do_protocol_20_105(args)









































xianmengdigongModel:initMapData(args[7],args[2])
xianmengdigongModel:initData(args[4],args[5],args[6],args[9])
xianmengdigongModel:initGL(args[9],args[10],args[11])
xianmengdigongModel:initPassFlag(args[12]or 0)
xianmengdigongModel:initSpeRoomData(args[13])
xianmengdigongModel:setLockRoomData(args[14],args[15])

do
local speRoom=xianmengdigongModel:getSpeRoomData()
local ev=speRoom and speRoom.getEvent and speRoom:getEvent(1)or nil
local ok,st=pcall(function()return ev and ev:getState()end)
platformSDK.printSDK('[XMDG][spe][20_105.afterInit]',
'speRoom='..tostring(speRoom),
'eventId='..tostring(ev and ev.eventId),
'myRewardFlag='..tostring(ev and ev.myRewardFlag),
'startTime='..tostring(ev and ev.startTime),
'jinDu='..tostring(ev and ev.jinDu),
'dzCount='..tostring(ev and ev.dzList and#ev.dzList or 0),
'state='..tostring(ok and st or'ERR')
)
end

UIManager:invokeUIMethod('UIXM_XMDG_MainWin','rec_changeMap')

xianmengdigongController:checkGLChatNotice(true)
pushGiftManager:onChanged(GIFT_CHECK_TYPE.eXianMengXingDong)
pushGiftTwoManager:onChanged(GIFT_EX_CHECK_TYPE.eXianMengXingDong)
pushGiftThreeManager:onChanged(GIFT_THREE_CHECK_TYPE.eXianMengXingDong)
xianmengdigongModel:getAllEventSequenceList_doing_idle(true)
end


function xianmengdigongController.do_protocol_20_106(x,y,eventInfo)


local room=xianmengdigongModel:getRoom2(x,y)
if room then
local event=room:getEvent(eventInfo.eventPos)
if event then
event:refreshData(eventInfo)
UIManager.info('派遣成功')
UIManager:invokeUIMethod('UIXM_XMDG_MapWin','rec_roomEvent',room.base.id)
UIManager:invokeUIMethod('UIXM_XMDG_eventWin','rec_event',room,event)
UIManager:invokeUIMethod('UIXM_XMDG_eventCheckWin','rec_event',room,event)
UIManager:invokeUIMethod('UIXM_XMDG_roomWin','rec_refreshEvent',room.base.id,event.eventPos)
UIManager:invokeUIMethod('UIXM_XMDG_MainWin','refreshEventBtn')
UIManager:invokeUIMethod('UIXM_XMDG_eventSelectDZWin','onClickClose')
end
end

if xianmengdigongModel:isSpeRoom(x,y)then
local spRoom=xianmengdigongModel:getSpeRoomData()
if spRoom and spRoom.getEvent then
local event=spRoom:getEvent(eventInfo.eventPos)
if event then
event:refreshData(eventInfo)
else
event=eventInfo
xianmengdigongModel:initEvent(event)
event:initPos()
spRoom.eventLookup[event.eventPos]=event
table.insert(spRoom.eventList,event)
spRoom.eventNum=(spRoom.eventNum or 0)+1
end
UIManager:invokeUIMethod('UIXM_XMDG_speEventWin','rec_event',spRoom,event)

do
local ok,st=pcall(function()return event and event:getState()end)
platformSDK.printSDK('[XMDG][spe][20_106.applied]',
'eventPos='..tostring(event and event.eventPos),
'eventId='..tostring(event and event.eventId),
'myRewardFlag='..tostring(event and event.myRewardFlag),
'startTime='..tostring(event and event.startTime),
'jinDu='..tostring(event and event.jinDu),
'dzCount='..tostring(event and event.dzList and#event.dzList or 0),
'state='..tostring(ok and st or'ERR')
)
end
end
UIManager:invokeUIMethod('UIXM_XMDG_eventSelectDZWin','onClickClose')
end
end









function xianmengdigongController.do_protocol_20_107(buyXDLCount)


xianmengdigongModel:setXDLCount(buyXDLCount)
pushGiftManager:onChanged(GIFT_CHECK_TYPE.eXianMengXingDong)
pushGiftTwoManager:onChanged(GIFT_EX_CHECK_TYPE.eXianMengXingDong)
pushGiftThreeManager:onChanged(GIFT_THREE_CHECK_TYPE.eXianMengXingDong)
end


function xianmengdigongController.do_protocol_20_108(x,y,flagGL,nameGL,timeGL)




if flagGL==1 then
xianmengdigongModel:setGLID(x,y,nameGL,timeGL)
xianmengdigongController:checkGLChatNotice()
else
xianmengdigongModel:clearGLID(nameGL,timeGL)
end
UIManager:invokeUIMethod('UIXM_XMDG_MapWin','refreshGL')
end


function xianmengdigongController.do_protocol_20_109(buffLayer)
xianmengdigongModel:setBufflv(buffLayer)
UIManager:invokeUIMethod('UIXM_XMDG_MainWin','rec_buffchange')
end


function xianmengdigongController.do_protocol_20_110(x,y,jinDu)
local room=xianmengdigongModel:getRoom2(x,y)
if room then
local o_isUnlock=room:checkunLock()
room.unlockJinDu=jinDu
local isUnlock=room:checkunLock()
local changeRound=o_isUnlock~=isUnlock
if changeRound and isUnlock and room.unlockFlag~=1 then
room.unlockFlag=1
end
local roomid=room.base.id
UIManager:invokeUIMethod('UIXM_XMDG_MapWin','rec_roomProgress',roomid,changeRound)
UIManager:invokeUIMethod('UIXM_XMDG_monsterWin','rec_roomProgress',roomid,isUnlock)
UIManager:invokeUIMethod('UIXM_XMDG_bossWin','rec_roomProgress',roomid,isUnlock)
UIManager:invokeUIMethod('UIXM_XMDG_MainWin','refreshFreeEventBtn')

xianmengdigongModel:getAllEventSequenceList_doing_idle(true)
end
end


function xianmengdigongController.do_protocol_20_111(len,logList,newMsg)







if newMsg==0 then
xianmengdigongModel:initDGNotes(logList)
UIManager:invokeUIMethod('UIXM_XMDG_NoteWin','rec_notes')
else
if len>0 then
xianmengdigongModel:setDGNotesNew(logList)
UIManager:invokeUIMethod('UIXM_XMDG_NoteWin','rec_notes')
end
end
UIManager:callWindowFunc("UIXM_XMDG_MainWin","refreshNoteBtnReddot")
reddotControl.on_change_catch_type(CATCH_TYPE.eLimitActChange,LIMIT_ACT_TYPE.eXianMengDiGong)
end


function xianmengdigongController.do_protocol_20_112(len,memberList)







xianmengdigongModel:initDGMembers(memberList)
UIManager:invokeUIMethod('UIXM_XMDG_MemberWin','rec_members')
end


function xianmengdigongController.do_protocol_20_113(len,eventList)





if len>0 then
local rewardList1={}
local rewardList2={}
for i,v in ipairs(eventList)do
local room=xianmengdigongModel:getRoom2(v.x,v.y)
if room then
local event=room:getEvent(v.eventPos)
if event then
event:flagReward(1)
local rewards=event.rewards
for i2=1,3 do
if rewards[i2]then
for i3,reward in ipairs(rewards[i2])do
table.insert(rewardList1,reward)
end
end
end
if rewards[4]then
for i3,reward in ipairs(rewards[4])do
table.insert(rewardList2,reward)
end
end


if xianmengdigongModel:isSpeRoom(v.x,v.y)then
local speRoom=xianmengdigongModel:getSpeRoomData()
if speRoom then
local oldEvent=speRoom:getEvent(v.eventPos)
if oldEvent then
oldEvent:flagReward(1)
end

local newEvent={}
xianmengdigongModel:initSpeEvent(newEvent)
speRoom.eventLookup[v.eventPos]=newEvent
if speRoom.eventList and#speRoom.eventList>0 then
for k=1,#speRoom.eventList do
if speRoom.eventList[k]and speRoom.eventList[k].eventPos==v.eventPos then
speRoom.eventList[k]=newEvent
break
end
end
else
speRoom.eventList={newEvent}
speRoom.eventNum=1
end

xianmengdigongModel:clearExploreTimes(event.eventId)
UIManager:invokeUIMethod('UIXM_XMDG_speEventWin','rec_event',speRoom,newEvent)

do
local ok,st=pcall(function()return newEvent and newEvent:getState()end)
platformSDK.printSDK('[XMDG][spe][20_113.nextEvent]',
'eventPos='..tostring(newEvent and newEvent.eventPos),
'eventId='..tostring(newEvent and newEvent.eventId),
'myRewardFlag='..tostring(newEvent and newEvent.myRewardFlag),
'startTime='..tostring(newEvent and newEvent.startTime),
'jinDu='..tostring(newEvent and newEvent.jinDu),
'dzCount='..tostring(newEvent and newEvent.dzList and#newEvent.dzList or 0),
'state='..tostring(ok and st or'ERR')
)
end
end
end
end
UIManager:invokeUIMethod('UIXM_XMDG_MapWin','rec_roomEvent',room.base.id)
end
end
UIManager:invokeUIMethod('UIXM_XMDG_eventRewardWin','rec_rewards')
UIManager:invokeUIMethod('UIXM_XMDG_MainWin','refreshEventBtn')
end
UIManager:callWindowFunc('UIFuncStorageWin','refreshxmdgRewardBtn')
UIManager:callWindowFunc('UIFuncStorageXMWin','refreshxmdgRewardBtn')

end


function xianmengdigongController.do_protocol_20_114(dzGuid,hp)


if hp>=10000 then
UIManager.info('弟子成功复活')
end
xianmengdigongModel:setDZBlood(dzGuid,hp)
UIManager:invokeUIMethod('UIXM_XMDG_DiZiWin','rec_dzRelive',dzGuid)
UIManager:invokeUIMethod('UIXM_XMDG_eventSelectDZWin','rec_dzRelive',dzGuid)
end


function xianmengdigongController.do_protocol_20_115(x,y,eventData)

local room=xianmengdigongModel:getRoom2(x,y)
if room then
local event_=room:getEvent(eventData.eventPos)
if event_ then
event_:refreshData(eventData)

UIManager:invokeUIMethod('UIXM_XMDG_MapWin','rec_roomEvent',room.base.id)
UIManager:invokeUIMethod('UIXM_XMDG_roomWin','rec_refreshEvent',room.base.id,event_.eventPos)
UIManager:invokeUIMethod('UIXM_XMDG_MainWin','refreshEventBtn')
UIManager:callWindowFunc('UIFuncStorageWin','refreshxmdgRewardBtn')
UIManager:callWindowFunc('UIFuncStorageXMWin','refreshxmdgRewardBtn')
end
end

if xianmengdigongModel:isSpeRoom(x,y)then
local spRoom=xianmengdigongModel:getSpeRoomData()
local event=spRoom:getEvent(eventData.eventPos)
if event then
event:refreshData(eventData)
end
UIManager:invokeUIMethod('UIXM_XMDG_MainWin','refreshEventBtn')
UIManager:callWindowFunc('UIFuncStorageWin','refreshxmdgRewardBtn')
UIManager:callWindowFunc('UIFuncStorageXMWin','refreshxmdgRewardBtn')
end
xianmengdigongModel:getAllEventSequenceList_doing_idle(true)
end


function xianmengdigongController.do_protocol_20_116(len,previewList)













if len>0 then
for i,v in ipairs(previewList)do
local room=xianmengdigongModel:getRoom2(v.x,v.y)
if room then
local event=room:getEvent(v.eventPos)
if event then
local rewards={}
rewards[1]=v.itemList1
rewards[2]=v.itemList2
rewards[3]=v.itemList3
rewards[4]=v.itemList4
event:setRewards(rewards)
end
end
if xianmengdigongModel:isSpeRoom(v.x,v.y)then
local speRoom=xianmengdigongModel:getSpeRoomData()
local event=speRoom:getEvent(v.eventPos)
if event then
local rewards={}
rewards[1]=v.itemList1
rewards[2]=v.itemList2
rewards[3]=v.itemList3
rewards[4]=v.itemList4
event:setRewards(rewards)
end
end
end
local win=UIManager:findActiveWindow('UIXM_XMDG_eventRewardWin')
if win then
win:rec_refreh()
else
UIManager:showWindow('UIXM_XMDG_eventRewardWin')
end
end
end


function xianmengdigongController.do_protocol_20_117(errCode)





local str=nil
if errCode==1 then
str='房间已解锁'
elseif errCode==2 then
str='事件弟子已满,无法再派遣'
elseif errCode==3 then
str='紧急事件已经完成过了'
end
if str then
UIManager.error(str)
end
end


function xianmengdigongController.do_protocol_20_119(openDay)

xianmengdigongModel:initOpenDay(openDay)
end

function xianmengdigongController.do_protocol_20_132(args)
local x,y,len,rankList=args[1],args[2],args[3],args[4]
local pilistlen,piList=args[5],args[6]

if len>0 then
rankList[1].piList=piList
end

local roomid=xianmengdigongModel:getID(x,y)
xianmengdigongModel:setBossRankList(roomid,rankList)

UIManager:callWindowFunc("UIXM_XMDG_bossWin","refreshRank")
UIManager:callWindowFunc("UIXM_XMDG_bossRankWin","refreshView")
end

function xianmengdigongController.do_protocol_20_133(x,y)
local room=xianmengdigongModel:getRoom2(x,y)
if room then
room.rankRewardFlag=1

UIManager:invokeUIMethod('UIXM_XMDG_MapWin','rec_roomEvent',room.base.id)
end
UIManager:callWindowFunc("UIXM_XMDG_bossRankWin","refreshReward")
UIManager:callWindowFunc("UIXM_XMDG_MainWin","refreshNoteBtnReddot")
UIManager:callWindowFunc("UIXM_XMDG_roomWin","refreshRankBtn")
reddotControl.on_change_catch_type(CATCH_TYPE.eLimitActChange,LIMIT_ACT_TYPE.eXianMengDiGong)
end

function xianmengdigongController.do_protocol_20_135(x,y,nanDu,bossHurt)
local room=xianmengdigongModel:getRoom2(x,y)
if room then
room:setFastFlag(nanDu,1)
room:setBossMaxHurt(bossHurt)

local yscfg=cfgHelper.get1(cfg_guilddigongyaoshouconfig_get,room.ysConfId)
local monsterType=yscfg.gwtype
if monsterType==MONSTER_TYPE.eShouLing then
local hp=room.unlockJinDu-bossHurt
if hp<0 then hp=0 end
room.unlockJinDu=hp

xianmengdigongController:send_20_132(room.base.id)
else
local add=yscfg.gwzList[nanDu][2]
local hp=room.unlockJinDu+add
if hp>10000 then hp=10000 end
room.unlockJinDu=hp
end

if room:checkunLock()then
xianmengdigongModel:setUnlockRoom(room.base.id)
UIManager:closeWindow("UIXM_XMDG_monsterWin")
UIManager:closeWindow("UIXM_XMDG_bossWin")
UIManager:invokeUIMethod('UIXM_XMDG_MapWin','rec_roomProgress',room.base.id,true,true)

UIManager:invokeUIMethod('UIXM_XMDG_MainWin','refreshFreeEventBtn')
else
UIManager:callWindowFunc("UIXM_XMDG_monsterWin","refreshView")
UIManager:callWindowFunc("UIXM_XMDG_bossWin","refreshView")


UIManager:invokeUIMethod('UIXM_XMDG_MapWin','rec_roomProgress',room.base.id,false)

UIManager:invokeUIMethod('UIXM_XMDG_MainWin','refreshFreeEventBtn')
end

xianmengdigongModel:setFastResultData({x=x,y=y,nanDu=nanDu,bossHurt=bossHurt})

xianmengdigongModel:getAllEventSequenceList_doing_idle(true)
end
end

function xianmengdigongController.do_protocol_20_139(startTimeLock,secondsLock)


xianmengdigongModel:setLockRoomData(startTimeLock,secondsLock)
UIManager:invokeUIMethod('UIXM_XMDG_MapWin','refreshAllRoomItemLookTime')
end

