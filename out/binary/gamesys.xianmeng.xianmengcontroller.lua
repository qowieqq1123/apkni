







local _MODULENAME="xianmengController"
gameState.addListener(def_table(_MODULENAME))
xianmengController.name=_MODULENAME







local enterXMMapMark=nil
local enterXMShopMark=nil
local enterXMJoinMark=nil



function xianmengController:setEnterXMMapMark(flag,callback)
if flag==nil then
enterXMMapMark=nil
else
enterXMMapMark={callback}
end
end
function xianmengController:setEnterXMShopMark(flag)
enterXMShopMark=flag
end
function xianmengController:setEnterXMJoinMark(flag)
enterXMJoinMark=flag
end

function xianmengController:onAppStart()
socketManager:register_receiver(20,1,xianmengController.do_protocol_20_1)
socketManager:register_receiver(20,2,xianmengController.do_protocol_20_2)
socketManager:register_receiver(20,3,xianmengController.do_protocol_20_3)
socketManager:register_receiver(20,4,xianmengController.do_protocol_20_4)
socketManager:register_receiver(20,7,xianmengController.do_protocol_20_7)
socketManager:register_receiver(20,8,xianmengController.do_protocol_20_8)
socketManager:register_receiver(20,9,xianmengController.do_protocol_20_9)
socketManager:register_receiver(20,11,xianmengController.do_protocol_20_11)
socketManager:register_receiver(20,12,xianmengController.do_protocol_20_12)
socketManager:register_receiver(20,13,xianmengController.do_protocol_20_13)
socketManager:register_receiver(20,14,xianmengController.do_protocol_20_14)
socketManager:register_receiver(20,15,xianmengController.do_protocol_20_15)
socketManager:register_receiver(20,16,xianmengController.do_protocol_20_16)
socketManager:register_receiver(20,21,xianmengController.do_protocol_20_21)
socketManager:register_receiver(20,22,xianmengController.do_protocol_20_22)
socketManager:register_receiver(20,23,xianmengController.do_protocol_20_23)
socketManager:register_receiver(20,24,xianmengController.do_protocol_20_24)
socketManager:register_receiver(20,25,xianmengController.do_protocol_20_25)
socketManager:register_receiver(20,26,xianmengController.do_protocol_20_26)
socketManager:register_receiver(20,27,xianmengController.do_protocol_20_27)
socketManager:register_receiver(20,28,xianmengController.do_protocol_20_28)
socketManager:register_receiver(20,29,xianmengController.do_protocol_20_29)
socketManager:register_receiver(20,31,xianmengController.do_protocol_20_31)
socketManager:register_receiver(20,32,xianmengController.do_protocol_20_32)
socketManager:register_receiver(20,33,xianmengController.do_protocol_20_33)
socketManager:register_receiver(20,34,xianmengController.do_protocol_20_34)
socketManager:register_receiver(20,37,xianmengController.do_protocol_20_37)
socketManager:register_receiver(254,85,xianmengController.do_protocol_254_85)
socketManager:register_receiver(20,39,xianmengController.do_protocol_20_39)



socketManager:register_receiver(20,136,xianmengController.do_protocol_20_136)
socketManager:register_receiver(20,137,xianmengController.do_protocol_20_137)
socketManager:register_receiver(20,138,xianmengController.do_protocol_20_138)


xianmengController:onAppStart_xianwulou()
xianmengController:onAppStart_TYSC()
xianmengController:onAppStart_building()
xianmengController:onAppStart_gongxunbang()
xianmengController:onAppStart_fenxiangziyuan()
xianmengController:onAppStart_moulue()
xianmengController:onAppStart_kufangZHFP()
xianmengController:onAppStart_DonationStatistics()

end

function xianmengController:onEnterState(isReconnect)
xianmengController:setEnterXMMapMark(nil)
xianmengController:setEnterXMShopMark(nil)
xianmengController:setEnterXMJoinMark(nil)
xianmengModel:initData()
xianmengModel:initApplyJoinList()
xianmengModel:initInviteJoinList()

xianmengController:onEnterState_xianwulou()
xianmengController:onEnterState_gongxunbang()
xianmengController:onEnterState_TYSC()
xianmengController:onEnterState_fenxiangziyuan()
xianmengController:onEnterState_ai(isReconnect)
xianmengController:onEnterState_moulue()
xianmengController:onEnterState_kufangZHFP()
xianmengController:onEnterState_DonationStatistics(isReconnect)

notifySystem:listenNotify(notifyConfig.onMountainChange,xianmengController.onMountainChange)
notifySystem:listenNotify(notifyConfig.onNewDay5am,xianmengController.onNewDay5am)
notifySystem:listenNotify(notifyConfig.onCommonShopData,xianmengController.onCommonShopData)
notifySystem:listenNotify(notifyConfig.onCommonShopChange,xianmengController.onCommonShopChange)
notifySystem:listenNotify(notifyConfig.onNewWeek5am,xianmengController.onNewWeek5am)
notifySystem:listenNotify(notifyConfig.home_event,self.on_home_event)
notifySystem:listenNotify(notifyConfig.building_event,self.on_building_event)
notifySystem:listenNotify(notifyConfig.onNewDay5am,self._on_new_day)
notifySystem:listenNotify(notifyConfig.inNewbie,self.inNewbie)
end

function xianmengController:onLeaveState(isReconnet)
xianmengController:setEnterXMMapMark(nil)
xianmengController:setEnterXMShopMark(nil)
xianmengController:setEnterXMJoinMark(nil)
xianmengController.dialogueFunc=nil
xianmengModel:clearData()
xianmengController:onLeaveState_building(isReconnet)
xianmengController:onLeaveState_xianwulou(isReconnet)
xianmengController:onLeaveState_gongxunbang(isReconnet)
xianmengController:onLeaveState_fenxiangziyuan()
xianmengController:onLeaveState_TYSC(isReconnet)
xianmengController:onLeaveState_ai(isReconnet)
xianmengController:onLeaveState_moulue(isReconnet)
xianmengController:onLeaveState_kufangZHFP(isReconnet)
xianmengController:onLeaveState_DonationStatistics(isReconnet)

notifySystem:removelistener(notifyConfig.onMountainChange,xianmengController.onMountainChange)
notifySystem:removelistener(notifyConfig.onNewDay5am,xianmengController.onNewDay5am)
notifySystem:removelistener(notifyConfig.onCommonShopData,xianmengController.onCommonShopData)
notifySystem:removelistener(notifyConfig.onCommonShopChange,xianmengController.onCommonShopChange)
notifySystem:removelistener(notifyConfig.home_event,self.on_home_event)
notifySystem:removelistener(notifyConfig.onNewWeek5am,xianmengController.onNewWeek5am)
notifySystem:removelistener(notifyConfig.building_event,self.on_building_event)
notifySystem:removelistener(notifyConfig.onNewDay5am,self._on_new_day)
notifySystem:removelistener(notifyConfig.inNewbie,self.inNewbie)

end

function xianmengController.on_home_event(etype)
if etype==homeEvent.eEnterHome then
xianmengController:onEnterHome()
elseif etype==homeEvent.eLeaveHome then
xianmengController:onLeaveHome()
end
end

function xianmengController:onEnterHome()
xianmengController:onEnterHome_ai()
end

function xianmengController:onLeaveHome()
xianmengController:onLeaveHome_ai()
end

function xianmengController:onPlayerCreate(...)

end

function xianmengController:onProtocolReq()

end


function xianmengController:onProtocolReqKF(isReconnet)

xianmengController:onProtocolReq_xianwulou(isReconnet)
xianmengController:onProtocolReq_kufangZHFP(isReconnet)
end

function xianmengController:doInit()

if xianmengModel:hasXM()then
if xianmengModel:getMyXMDetialData()==nil then
xianmengController:reqXMDataDetail()
end
notifySystem:postNotify(notifyConfig.onXianMengInit)
end
self:checkHeJuAutoBuild()
end

function xianmengController:onLostConnection()

end

function xianmengController.onMountainChange(old_sfId,sfId)
if old_sfId==sfId then return end
if old_sfId==mapIdType.xianmeng then


elseif sfId==mapIdType.xianmeng then







end
end

function xianmengController.onNewDay5am()
xianjieModel:setCurCountToday(0)
xianmengModel:setXMShopNewFlag(true)
xianmengModel:clearAllRepairCollectDaily()
UIManager:invokeUIMethod("UIXMRepairWin","refreshCommitNum")

xianmengController:refreshXianWuLouHud()
reddotControl.on_change_catch_type(CATCH_TYPE.eXianWuLouProgressChange)

local baseData=xianmengModel:getXMBaseData()
if baseData then
baseData.shareTimes=0
end
notifySystem:postNotify(notifyConfig.onXMFXZYShare)
end

function xianmengController.onNewWeek5am()
xianmengController.do_protocol_20_41(0,nil,0,nil)
xianmengModel:setGXBValue(0)
xianmengModel:resetGXBRewardFlag()

local has=xianmengModel:hasXM()and xianmengController:getXianWuLouBuild()~=nil
if has and not xianmengModel:checkXWLInit()then
xianmengController:reqXWLInfo()
end
end

function xianmengController.on_building_event(eType,param1,param2,param3)
if eType==buildingEvent.zongmenLevelUp and param3~=param1 then
xianmengModel:clearSeekItemSort_fenxiangziyuan()
elseif eType==buildingEvent.buildComplete then
local bdData=zongmenModel:getBuildingData(param2)
local cfg=cfgHelper.get1(cfg_monijybuildconfig_get,bdData.build_id)
if cfg.build_type==SLG_SYSTEM_TYPE.eChengYuanHeJu then
local ver=pfwindowslController:getGameVersion()
local enterTips=cfgHelper.get2(cfg_guildbaseconfig_get,1,'enterTips')
if enterTips[ver]then
local dialogueFunc=function()
UIDialogManager.getCommonDialog3('提示',enterTips[ver],nil,function(data)
data.alignment=3
data.canceltext=nil
data.okcallback=function()
data.alignment=nil
end
data.closecallback=function()
data.alignment=nil
end
end)
end
if newbieControl.isInNewbie()then
xianmengController.dialogueFunc=dialogueFunc
else
dialogueFunc()
end
end
end
end
end

function xianmengController.inNewbie(newbieid,flag)
if xianmengController.dialogueFunc then
if not flag then
local func=function()
local win=UIManager:findActiveWindow("UICommonShowPrizeWin")
local cb=function()
xianmengController.dialogueFunc()
xianmengController.dialogueFunc=nil
end
if win then
win:setAttachCB(cb)
else
cb()
end
end
timeEventController.delayDo(0.5,func)
end
end
end

function xianmengController.onCommonShopData(shopType)
if shopType==eFuncShopType.eXianMeng then
xianmengModel:setXMShopNewFlag(nil)

if enterXMShopMark==true then
xianmengController:setEnterXMShopMark(nil)

xianmengController:showXMShop()
else
UIManager:invokeUIMethod('UIXianMengShopWin','refreshItemList')
end
end
end

function xianmengController.onCommonShopChange(shopType,buyId,buyNum)
if shopType==eFuncShopType.eXianMeng then
UIManager:invokeUIMethod('UIXianMengShopWin','refreshItemByID',buyId)
end
end


function xianmengController:checkInsideNoticeSend(notice)
if xianmengModel:getXMNoticeEx(notice)~=xianmengModel:getXMNotice()then
UIManager:callWindowFunc('UIChatWin','freshTopMsg')
end
end

function xianmengController:checkKuafuMemberOpen()
local cross=cfgHelper.get2(cfg_guildbaseconfig_get,1,'cross')
local openDay=timeHelper.getServerOpenDay()
return openDay>=cross
end

function xianmengController:getKuafuMemberOpenTime()
local cross=cfgHelper.get2(cfg_guildbaseconfig_get,1,'cross')
local y,m,d=timeHelper.getDateNumber(gameUtilityModel.getOpenServerLongTime())
local t=timeHelper.timeServer(y,m,d,0,0,0)
t=t+(cross-1)*86400
local cur=gameUtilityModel.getServerLongTime()
return t-cur
end



function xianmengController:enterXianMengMap(argstable,callback)
local check=xianmengModel:checkXMDetialDataOutData()
if check==true then
xianmengController:reqXMDataDetail()

xianmengController:setEnterXMMapMark(true)
elseif check==false then
local callback_
if callback then
callback_=function(flag,...)
if not flag then
return
end
callback(flag,...)
end
end
cameraMoveController:Begin({eSceneType.eZongmen,mapIdType.xianmeng},nil,callback_)
end
end

function xianmengController:leaveXianMengMap(callback)
local callback_
if callback then
callback_=function(flag,...)
if not flag then
return
end
callback(flag,...)
end
end
local func=function()
cameraMoveController:Begin({eSceneType.eZongmen,mapIdType.zhufeng},nil,callback_)
end
local win=UIManager:findActiveWindow('UIXianMengMainWin')
if win then



func()
else
func()
end
end


function xianmengController:openXianMengMainWin(argstable)
UIManager:showWindow('UIXianMengMainWin',argstable)
end

function xianmengController:closeXianMengMainWin()
UIManager:closeWindow('UIXianMengMainWin')
end



function xianmengController:openJoinWin()
local flag=xianmengModel:checkSearchXMData()
if flag then
xianmengController:setEnterXMJoinMark(true)
else
UIManager:showWindow('UIXianMengJoinWin')
end
end

function xianmengController:openXMDetailInfoWin(guildid,canvasIdx)
xianmengController:reqXMDetailData(guildid)
UIManager:showWindow('UIXianMengInfoWin',{guildid=guildid,canvasIdx=canvasIdx})
end

function xianmengController:openXMMemberListWin(guildid,canvasIdx)
xianmengController:reqXMMemberList(guildid)
UIManager:showWindow('UIXianMengMemberWin',{guildid=guildid,canvasIdx=canvasIdx})
end

function xianmengController:showXMShop()
if not zongmenModel:haveBuildByBuildId(SLG_SYSTEM_TYPE.eXianMengShanDian)then
return false
end
xianmengModel:checkNeedNewShopItems(true)




funcShopController:openShopWin({shopId=eFuncShopType.eXianMeng})
return true
end

function xianmengController:onClickLeaveXM()






local tips=cfgHelper.getlang("leaveXianMeng_activityTips")

if tips~=nil then
local func=function()
xianmengController:onClickLeaveXM2()
end
UIDialogManager.getCommonDialog(nil,tips,func)
else
xianmengController:onClickLeaveXM2()
end
end

function xianmengController:onClickLeaveXM2()
local memberData=xianmengModel:getXMMemberData(playerModel:getActorID())
local pos=memberData.pos
if pos==GUILD_POST_TYPE.gpAllyLeader then

local memberNum=xianmengModel:getXMMemberNum()
if memberNum>1 then
UIManager.error('请先转让盟主')
else
local func=function()
xianmengController:reqDelXM()
end
local content=cfgHelper.getlang("leaderExitXianMengDissolveTips")
UIDialogManager.getCommonDialog(nil,content,func)
end
else

local func=function()
xianmengController:reqLeaveXM()
end
local joinCD=xianmengModel:getJoinCD(gameUtilityModel.getServerShortTime())
local ver=pfwindowslController:getGameVersion()
local exit=cfgHelper.get2(cfg_guildbaseconfig_get,1,'exit')
local NotCD=exit[ver]and not xianmengModel:hadXM()
if joinCD>0 and not NotCD then

local CDTeQuanTimes=xianmengModel:getAcTCDTeQuan()

local timestr=timeHelper.formatSimpleTime(joinCD)
local content=FMT.fmt('退出后需等待{0}才能重新加入仙盟\n确定要退出吗',timestr)
if CDTeQuanTimes>0 then
content=FMT.fmt(cfgHelper.get1(cfg_lang_get,'xianmengAct_freeCD_tips'),CDTeQuanTimes)
end
UIDialogManager.getCommonDialog(nil,content,func)
else
func()
end
end
end

function xianmengController:sendUseTeQuan(typo,times)
local subInfo=xianmengModel:isInTeQuanAct(typo)
if subInfo then
activitiesController:sendProtocol(actSendType.eComonReqHandle,subInfo.act_id,subInfo.sub_act_type,subInfo.sub_act_id,jsonHelper.encode({typo,times}))
end
end

function xianmengController:setAfterUseTimeFunc(func)
self.afterUseTimeFunc=func
end

function xianmengController:getAfterUseTimeFunc()
return self.afterUseTimeFunc
end


function xianmengController:checkFreeCDTimes(func)
local lerp=xianmengModel:getJoinCoolDownTime()
if lerp>0 then
local CDTeQuanTimes,maxTimes=xianmengModel:getAcTCDTeQuan()
if CDTeQuanTimes>0 then
local args={title="加入仙盟",oktext="免除冷却",okTipsText=FMT.fmt("免除冷却次数：{0}/{1}",CDTeQuanTimes,maxTimes),
okcb=function()
xianmengController:sendUseTeQuan(1,1)
xianmengController:setAfterUseTimeFunc(func)
end,
cancelcb=nil,
content=FMT.fmt("离开仙盟12小时后才可重进仙盟，\n 盛会期间，享有免除重进仙盟冷却时间特权",timeHelper.formatSimpleTime(xianmengModel:getJoinCD(gameUtilityModel.getServerShortTime())))
}
self.CDTimesDialog=UIDialogManager.getConfirmDialogEx(self.CDTimesDialog,args)
self.CDTimesDialog:show()
else
if not xianmengModel:checkCanJoin(true)then
return
end
func()
end
else
if not xianmengModel:checkCanJoin(true)then
return
end
func()
end
end


function xianmengController:onEnterXM()
limitActivitiesController:onStartAllXMAct()
if enterXMMapMark==nil then

xianmengController:initXWL()
end
end


function xianmengController:onLeaveXM()
xianmengModel:leaveXM()

xianmengModel:clearXMNotes()

xianmengModel:clearSearchXMData()

xianmengModel:clearInvitationList()

xianmengModel:clearApplicationList()

xianmengModel:clearData_fenxiangziyuan(true)

xianmengModel:clearData_xianwulou()

if zongmenControl:isMountid(mapIdType.xianmeng)then
local callback=function()
if fullScreenUI.isActiveFullEx(FULL_TYPE.eXianMengPalace)then
fullScreenUI.closeActiveUI()
end
UIManager:closeWindow("UIXMRepairWin")
end
xianmengController:leaveXianMengMap(callback)
end
xianmengController.autoBuild=false
mountainControl:removeMap(mapIdType.xianmeng)
xianmengController:clearMoniJYData(mapIdType.xianmeng)

reddotControl.on_xianmeng_application_changed()
notifySystem:postNotify(notifyConfig.onXianMengChange,false)
end




function xianmengController:reqXMData()
socketManager:send_20_1()
end


function xianmengController:reqXMDataDetail()
socketManager:send_20_2()
end


function xianmengController:reqXMList(pageidx,pagesize)




socketManager:send_20_11(1,1)
end


function xianmengController:reqXMDetailData(guildid)

socketManager:send_20_12(guildid)
end


function xianmengController:reqXMMemberList(guildid)

socketManager:send_20_13(guildid)
end


function xianmengController:reqXMMemberListCheckCD(guildid)
local now=timeHelper.getServerShortTime()
if self.req_20_13_stamp and self.req_20_13_stamp+60>now then
return
end

socketManager:send_20_13(guildid)
self.req_20_13_stamp=now
end


function xianmengController:reqXMApplicationList()
socketManager:send_20_14()
end


function xianmengController:reqXMInvitationList()
socketManager:send_20_15()
end


function xianmengController:reqXMNoteList()
socketManager:send_20_16()
end


function xianmengController:reqApllyJoinXM(guildidlist,refresh)
if ServerTransferModel:checkTransferServerState()then
UIManager.error("已申请转服，该功能无法使用")
return
end
socketManager:send_20_21(#guildidlist,guildidlist)
if refresh==true then
for i,guildid in ipairs(guildidlist)do
xianmengController:reqXMDetailData(guildid)
end
end
end


function xianmengController:reqLeaveXM()
socketManager:send_20_22()
end


function xianmengController:reqCreateXM(guildicon,guildname,guildnotice,guildnotice2)
if ServerTransferModel:checkTransferServerState()then
UIManager.error("已申请转服，该功能无法使用")
return
end



guildnotice=guildnotice or cfgHelper.get2(cfg_guildbaseconfig_get,1,'defaultguildnotice')
guildnotice2=guildnotice2 or cfgHelper.get2(cfg_guildbaseconfig_get,1,'defaultexnotice')

socketManager:send_20_23(guildicon,guildname,guildnotice,guildnotice2)
end


function xianmengController:reqDelXM()
socketManager:send_20_24()
end


function xianmengController:reqXMChangeName(guildname)
socketManager:send_20_25(guildname)
end


function xianmengController:reqSetXMLimit(joinlimit,levellimit)
socketManager:send_20_26(joinlimit,levellimit)
end




function xianmengController:reqInviteJoinXM(actorid)

socketManager:send_20_27(actorid)
end


function xianmengController:reqHandelXMRequir(targetid,flag)


socketManager:send_20_28(targetid,flag)
end


function xianmengController:reqChangeXMPost(actorid,posid)


socketManager:send_20_29(actorid,posid)
end


function xianmengController:reqChangeXMSign(guildicon)

socketManager:send_20_31(guildicon)
end


function xianmengController:reqXMKickout(actorid)

socketManager:send_20_32(actorid)
end



function xianmengController:reqXMChangeNotice(notice)

socketManager:send_20_33(notice)
end


function xianmengController:reqXMChangeNotice2(notice)

socketManager:send_20_34(notice)
end


function xianmengController:reqPostRechange(actor1,actor2)
socketManager:send_20_37(actor1,actor2)
end





function xianmengController.do_protocol_20_1(args)




local guildid=args[1]
local weekscore=args[2]
local exitsec=args[3]
local ws_conf_id=args[4]
local ws_score=args[5]
local ws_rewards_flag=args[6]
local shareTimes=args[7]
local cooperation_earn=args[8]

local isInit=xianmengModel:checkInit()
local old_hasXM=xianmengModel:hasXM()
local xmData={}
xmData.guildid=guildid
xmData.weekscore=weekscore
xmData.exitsec=exitsec
xmData.ws_conf_id=ws_conf_id
xmData.ws_score=ws_score
xmData.ws_rewards_flag=ws_rewards_flag
xmData.shareTimes=shareTimes
xmData.cooperation_earn=cooperation_earn
xianmengModel:initXMData(xmData)

if initProControl.isDone()then
local hasXM=xianmengModel:hasXM()
if isInit and not old_hasXM and hasXM then

UIManager.info('成功加入仙盟')

xianmengModel:clearInvitationList()

xianmengModel:clearApplicationList()

UIManager:closeWindow('UIXianMengJoinWin')

UIManager:invokeUIMethod('UIFuncStorageWin','refreshXianMengInviteBtn')

notifySystem:postNotify(notifyConfig.onXianMengChange,true)
pfCommonHelper.efunTrackEventPoint(pfCommonHelper.efunTrackEventName.JoinGroup)
end

if hasXM then

xianmengdigongController:send_20_134()

xianjieController.reqCooperationList()
end

local mountainCfg=cfg_monijysfconfig()
for _,v in ipairs(mountainCfg)do
local bdDatas=zongmenModel:getBuildingDataByBdId(v.id,SLG_SYSTEM_TYPE.eXianXunBang)
for _,v1 in ipairs(bdDatas)do
hudControl:refreshBuildingStatusHUD(v1.un_build_id)
end
end

UIManager:invokeUIMethod("UIXianMengGXBTaskWin","refreshRewardList")
UIManager:invokeUIMethod("UIMainXMTaskWin","freshGXReddot")

notifySystem:postNotify(notifyConfig.onXMFXZYShare)

reddotControl.on_change_catch_type(CATCH_TYPE.eXianMengWeekScoreChange)
if not isInit then
xianmengController:doInit()
end
end
end


function xianmengController.do_protocol_20_2(guildInfoItem,recruit)

























guildInfoItem.recruit=recruit
local oldlv,oldexp=xianmengModel:getXMLevel()
if guildInfoItem.guildexnotice==nil or guildInfoItem.guildexnotice==""then
guildInfoItem.guildexnotice=cfgHelper.get2(cfg_guildbaseconfig_get,1,'defaultexnotice')
end
xianmengController:checkInsideNoticeSend(guildInfoItem.guildnotice)
xianmengModel:initMyXMDetialData(guildInfoItem)
xianmengModel:markXMDetialDataTime(true)

UIManager:invokeUIMethod('UIXianMengPalaceWin','rec_refresh')


if enterXMMapMark~=nil then
local cb=enterXMMapMark[1]
xianmengController:setEnterXMMapMark(nil)

xianmengController:enterXianMengMap(nil,cb)
end

notifySystem:postNotify(notifyConfig.onXianMengLevelChange,oldlv or 0,guildInfoItem.guildlevel,oldexp or 0,guildInfoItem.guildexp)
end


function xianmengController.do_protocol_20_3(len)



if not xianmengModel:hasXM()then
return
end

xianmengModel:clearApplicationList()

if len>0 then
xianmengController:reqXMApplicationList()
else
reddotControl.on_xianmeng_application_changed()
end
end


function xianmengController.do_protocol_20_4()

if xianmengModel:hasXM()then
return
end

xianmengModel:clearInvitationList()

xianmengController:reqXMInvitationList()
end


function xianmengController.do_protocol_20_7(reason)


if reason==0 then
UIManager.error('盟主已解散仙盟')
elseif reason==1 then
UIManager.error('你的仙盟已被强制解散')
elseif reason==2 then
UIManager.error('你的仙盟已自动解散')
end
xianmengController:onLeaveXM()
end


function xianmengController.do_protocol_20_8(guildlevel,guildexp)



local oldlv,oldexp=xianmengModel:getXMLevel()
xianmengModel:setXMLevelAndExp(guildlevel,guildexp)
if oldlv~=nil then
notifySystem:postNotify(notifyConfig.onXianMengLevelChange,oldlv,guildlevel,oldexp,guildexp)
end
xianmengController:refreshAllHUD(mapIdType.xianmeng)
end


function xianmengController.do_protocol_20_9()

if zongmenControl:isMountid(mapIdType.xianmeng)then
xianmengController:reqXMDataDetail()
else
xianmengModel:markXMDetialDataTime(nil)
end
end


function xianmengController.do_protocol_20_11(pageidx,pagesize,pagecnt,len,list)

















xianmengModel:recordSearchXMData(list)


if enterXMJoinMark==true then
xianmengController:setEnterXMJoinMark(nil)
UIManager:showWindow('UIXianMengJoinWin')
else
UIManager:invokeUIMethod('UIXianMengJoinWin','rec_data')
end
UIManager:invokeUIMethod('UIXianMengListWin','rec_data')
end


function xianmengController.do_protocol_20_12(guildDetailItem)













local guildid=guildDetailItem.guildid
xianmengModel:recordSearchXMDetailData(guildDetailItem)
UIManager:invokeUIMethod('UIXianMengInfoWin','rec_detail',guildid)
UIManager:invokeUIMethod('UIXianMengListWin','refresh_item',guildid)
UIManager:invokeUIMethod('UIXianMengJoinWin','refresh_item',guildid)
UIManager:invokeUIMethod('UIXM_ZZSH_xmWin','rec_detail',guildid)
UIManager:invokeUIMethod('UIXianJie_otherZmInfoWin','rec_detail',guildid)
UIManager:invokeUIMethod('UIXianJie_JiJie_teamListWarWin','rec_detail',guildid)
UIManager:invokeUIMethod('UIXianJie_JiJie_msgWin','rec_detail',guildid)
end


function xianmengController.do_protocol_20_13(guildid,len,list)










list=list or{}
xianmengModel:recordSearchXMMemberList(guildid,list)
UIManager:invokeUIMethod('UIXianMengMemberWin','rec_memberlist',guildid)

notifySystem:postNotify(notifyConfig.onGuildMemberChange)
end


function xianmengController.do_protocol_20_14(len,list)






xianmengModel:initApplicationList(list)

UIManager:invokeUIMethod('UIXianMengRequireWin','rec_refresh')
UIManager:invokeUIMethod('UIXianMengPalaceWin','refreshApplicationBtn')

reddotControl.on_xianmeng_application_changed()
end


function xianmengController.do_protocol_20_15(len,list)







xianmengModel:initInvitationList(list)

UIManager:invokeUIMethod('UIXianMengInviteWin','rec_refresh')

UIManager:invokeUIMethod('UIFuncStorageWin','refreshXianMengInviteBtn')
end


function xianmengController.do_protocol_20_16(len,list)






xianmengModel:initXMNotes(list)

if UIManager:isActive('UIXianMengNoteWin')then
UIManager:invokeUIMethod('UIXianMengNoteWin','refreshView')
else
UIManager:showWindow('UIXianMengNoteWin')
end
end


function xianmengController.do_protocol_20_21(ret,len,guildidlist)



if ret==0 then



if xianmengModel:hasXM()then

xianMengBaoXiangController:check_item_not_use()

xianmengController:reqXMDataDetail()
if UIManager:isActive('UIMain')or UIManager:isActive('UIWorldWin')then

xianmengController:setEnterXMMapMark(true)
end
xianmengController:onEnterXM()
else

if guildidlist~=nil then
for i,v in ipairs(guildidlist)do
xianmengModel:setApplyJoinState(v,true)
end
end
UIManager.info('成功申请，等待仙盟审核')

UIManager:invokeUIMethod('UIXianMengJoinWin','changeRefresh')
end
elseif ret==1 then
UIManager.error('已经有仙盟')
elseif ret==2 then
UIManager.error('加入仙盟冷却中')
elseif ret==3 then
UIManager.error('启禀祖师，该仙盟已满员')
elseif ret==4 then
UIManager.error('启禀祖师，本宗等级不符合入盟条件')
elseif ret==5 then
UIManager.error('启禀祖师，该仙盟已不再招人')
elseif ret==6 then
UIManager.error('启禀祖师，该仙盟已解散')
elseif ret==7 then
local lerp=xianmengController:getKuafuMemberOpenTime()
local timestr=FMT.fmt(cfgHelper.getlang('xianmeng_tips4'),timeHelper.formatSimpleTime(lerp))
UIManager.error(timestr)
end
end


function xianmengController.do_protocol_20_22(ret)



if ret==0 then
UIManager.info('成功退出仙盟')
xianmengController:onLeaveXM()
xianmengModel:markLeaveXMTime()
local depotarry=cfgHelper.get2(cfg_guildbaseconfig_get,1,'depot')
if depotarry then
local temp={}
for k,v in pairs(depotarry)do
temp[#temp+1]={param_1=k,param_2=0}
end
if#temp>0 then
moneySystem.recvInitMoney4(#temp,temp)
end
end
else
local logstr
if ret==1 then
logstr='没仙盟'
elseif ret==2 then
logstr='盟主不能退'
elseif ret==3 then
logstr='有山海世界外派队伍，操作失败'
elseif ret==4 then
logstr='处于征战山海战争期，操作失败'
elseif ret==5 then
logstr='入驻灵山中，操作失败'
elseif ret==6 then
logstr='山海日志有未领取奖励，操作失败'
end
UIManager.error(logstr)
end
end


function xianmengController.do_protocol_20_23(ret,guildid)



if ret==0 then
xianmengModel:createXM(guildid)


xianmengModel:clearInvitationList()

xianmengModel:clearApplicationList()


xianmengModel:clearSearchXMData()

xianmengController:reqXMDataDetail()

if UIManager:isActive('UIMain')then

xianmengController:setEnterXMMapMark(true)
end
xianmengController:onEnterXM()

UIManager.info('仙盟创建成功')
UIManager:closeWindow('UIXianMengCreateWin')
UIManager:closeWindow('UIXianMengJoinWin')


AudioManager.playAudio(526)







notifySystem:postNotify(notifyConfig.onXianMengChange,true)
pfCommonHelper.efunTrackEventPoint(pfCommonHelper.efunTrackEventName.JoinGroup)
platformSDK:gongHuiReport()
else
local logstr
if ret==1 then
logstr='已经有仙盟'
elseif ret==2 then
logstr='名称不合规'
elseif ret==3 then
logstr='名称已存在'
elseif ret==4 then
logstr='消耗不足'
elseif ret==5 then
logstr='盟徽不合规'
elseif ret==6 then
logstr='名称含非中文'
elseif ret==7 then
logstr='对内公告不合规'
elseif ret==8 then
logstr='对外公告不合规'
elseif ret==9 then
local max=cfgHelper.get3(cfg_guildbaseconfig_get,1,'namelen',2)
logstr=FMT.fmt('仙盟名不能超过{0}个字',max)
end
UIManager.error(logstr)


AudioManager.playBtnClick()
end


end


function xianmengController.do_protocol_20_24(ret)


if ret==0 then
UIManager.info('仙盟解散成功')
xianmengController:onLeaveXM()
local depotarry=cfgHelper.get2(cfg_guildbaseconfig_get,1,'depot')
if depotarry then
local temp={}
for k,v in pairs(depotarry)do
temp[#temp+1]={param_1=k,param_2=0}
end
if#temp>0 then
moneySystem.recvInitMoney4(#temp,temp)
end
end
else
local logstr
if ret==1 then
logstr='没仙盟'
elseif ret==2 then
logstr='权限不足'
elseif ret==3 then
logstr='有山海世界外派队伍，操作失败'
elseif ret==4 then
logstr='处于征战山海战争期，操作失败'
elseif ret==5 then
logstr='入驻灵山中，操作失败'
elseif ret==6 then
logstr='山海日志有未领取奖励，操作失败'
end
UIManager.error(logstr)
end
end


function xianmengController.do_protocol_20_25(ret,guildname)



if ret==0 or ret==-1 then
local old=xianmengModel:getXMName()
xianmengModel:setXMName(guildname)
UIManager:callWindowFunc('UIXianMengPalaceWin','refreshXMName')
notifySystem:postNotify(notifyConfig.onChangeName,changeNameType.eXianMeng,old,guildname)
else
local logstr
if ret==1 then
logstr='没仙盟'
elseif ret==2 then
logstr='名称不合规'
elseif ret==3 then
logstr='名称已存在'
elseif ret==4 then
logstr='消耗不足'
elseif ret==5 then
logstr='权限不足'
elseif ret==6 then
logstr='名称含非中文'
elseif ret==7 then
local max=cfgHelper.get3(cfg_guildbaseconfig_get,1,'namelen',2)
logstr=FMT.fmt('仙盟名不能超过{0}个字',max)
end
UIManager.error(logstr)
end
end


function xianmengController.do_protocol_20_26(ret,joinlimit,levellimit)




if ret==0 then
xianmengModel:setXMLimit(joinlimit,levellimit)
UIManager.info('设置成功')
else
local logstr
if ret==1 then
logstr='没仙盟'
elseif ret==2 then
logstr='权限不足'
end
UIManager.error(logstr)
end
end


function xianmengController.do_protocol_20_27(ret,actorid)



if ret==0 then
xianmengModel:setInviteJoinState(actorid,true)
UIManager.info('邀请成功，请等待回复')

UIManager:invokeUIMethod('UIOthePlayerInfoWin','rebuildBtns')
else
local logstr
if ret==1 then
logstr='没仙盟'
elseif ret==2 then
logstr='权限不足'
elseif ret==3 then
logstr='对方有仙盟了'
elseif ret==4 then
logstr='对方拒绝三次了'
elseif ret==5 then
logstr='对方加入仙盟冷却中'
elseif ret==6 then
logstr='已邀请过对方'
elseif ret==7 then
logstr='对方仙盟系统未开启'
elseif ret==8 then
logstr='对方跨服仙盟系统未开启'
end
UIManager.error(logstr)
end
end


function xianmengController.do_protocol_20_28(ret,targetid,flag)





if ret==0 then
if flag==-1 then

local targetid_str=tostring(targetid)
if targetid_str=='0'then
UIManager.info('已全部拒绝')
else
local applicationData=xianmengModel:getApplication(targetid)
if applicationData~=nil then
local actorname=applicationData.actorname
UIManager.info(FMT.fmt('已拒绝{0}的申请',actorname))
end
end

xianmengModel:removeApplication(targetid)

UIManager:invokeUIMethod('UIXianMengRequireWin','rec_refresh')
UIManager:invokeUIMethod('UIXianMengPalaceWin','refreshApplicationBtn')

reddotControl.on_xianmeng_application_changed()
elseif flag==1 then

local targetid_str=tostring(targetid)
if targetid_str=='0'then
UIManager.info('已全部同意')
else
local applicationData=xianmengModel:getApplication(targetid)
if applicationData~=nil then
local actorname=applicationData.actorname
UIManager.info(FMT.fmt('已同意{0}加入仙盟',actorname))
end
end

xianmengModel:removeApplication(targetid)

UIManager:invokeUIMethod('UIXianMengRequireWin','rec_refresh')
UIManager:invokeUIMethod('UIXianMengPalaceWin','refreshApplicationBtn')

reddotControl.on_xianmeng_application_changed()
elseif flag==-2 then

xianmengModel:removeInvitation(targetid)
UIManager:invokeUIMethod('UIXianMengInviteWin','rec_refresh')

UIManager:invokeUIMethod('UIFuncStorageWin','refreshXianMengInviteBtn')
elseif flag==2 then



if xianmengModel:hasXM()then
xianmengController:reqXMDataDetail()
if UIManager:isActive('UIXianMengInviteWin')then
UIManager:closeWindow('UIXianMengInviteWin')

xianmengController:setEnterXMMapMark(true)
end
xianmengController:onEnterXM()
end
end
else
local logstr
if ret==1 then
logstr='自己没仙盟'
elseif ret==2 then
logstr='自己权限不足'
elseif ret==3 then
logstr='自己有仙盟了'
elseif ret==4 then
logstr='对方有仙盟了'
elseif ret==5 then
logstr='自己加入仙盟冷却中'
elseif ret==6 then
logstr='对方加入仙盟冷却中'
elseif ret==7 then
logstr='对方仙盟满员了'
end
UIManager.error(logstr)


local flag_=math.abs(flag)
if flag_==1 then
xianmengController:reqXMApplicationList()
elseif flag_==2 then
xianmengController:reqXMInvitationList()
end
end
end


function xianmengController.do_protocol_20_29(ret,actorid,posid,oldposid)





if ret==0 or ret==-1 then
local myActorid=playerModel:getActorID()
local ismy=mathHelper.compareInt64(myActorid,actorid)
if ismy then
local old_postPrivile=xianmengModel.checkPostPrivile(oldposid,GUILD_PRIVILE_TYPE.gptHandle)
local postPrivile=xianmengModel.checkPostPrivile(posid,GUILD_PRIVILE_TYPE.gptHandle)
if old_postPrivile and not postPrivile then

xianmengModel:clearApplicationList()
UIManager:closeWindow('UIXianMengRequireWin')
reddotControl.on_xianmeng_application_changed()
elseif not old_postPrivile and postPrivile then

xianmengController:reqXMApplicationList()
end
end

local data=xianmengModel:getXMMemberData(actorid)
if data==nil then

return
end


xianmengModel:setXMMemberPost(actorid,posid)

if ret==0 then
local postName=xianmengModel.getXMPostName(posid)
if posid>oldposid then
UIManager.info(FMT.fmt('{0}已降职为{1}',data.actorname,postName))
elseif posid<oldposid then
UIManager.info(FMT.fmt('{0}已升职为{1}',data.actorname,postName))
end
elseif ret==-1 then
if posid==GUILD_POST_TYPE.gpAllyLeader then

local actorname=xianmengModel:getXMMemberName(actorid)
xianmengModel:setXMLeaderName(actorname)

UIManager:invokeUIMethod('UIXianMengPalaceWin','refreshXMLeaderName')
end
UIManager:invokeUIMethod('UIXianMengPostSetWin','refreshView',actorid,posid,oldposid)
end

if ismy then
UIManager:invokeUIMethod('UIXianMengPalaceWin','initBtnsView')
UIManager:invokeUIMethod('UIXianMengPalaceWin','refreshChangeBtns')
UIManager:invokeUIMethod('UIXM_XMDG_ShopWin','refreshManageBtnShow')
reddotControl.on_change_catch_type(CATCH_TYPE.eXMDGShopManage)
reddotControl.on_change_catch_type(CATCH_TYPE.eLimitActChange,LIMIT_ACT_TYPE.eXianMengDiGong)
end

UIManager:invokeUIMethod('UIXianMengPalaceWin','rec_actor_post',actorid)
UIManager:invokeUIMethod('UIOthePlayerInfoWin','rebuildBtns')

if ismy and oldposid>posid then
local hourPos=chatMesgFilterControl.getHourPosByMsgType(CHAT_MSG_TYPE.eXianMengPosChange)
local content=FMT.fmt("祖师已被任命为仙盟{0}",xianmengModel.getXMPostName(posid,true))
chatControl.onHandleCustomMesg(timeHelper.getServerShortTime(),'',content,hourPos,{CHAT_CHANNNEL.eXianmeng})
end
else
local logstr
if ret==1 then
logstr='没仙盟'
elseif ret==2 then
logstr='权限不足'
elseif ret==3 then
local postName=xianmengModel.getXMPostName(posid)
logstr=FMT.fmt('{0}职位已满',postName)
end
UIManager.error(logstr)
end
end


function xianmengController.do_protocol_20_31(ret,guildicon)



if ret==0 or ret==-1 then
xianmengModel:setGuildImage(guildicon)

if ret==0 then
UIManager.info('更换成功')
UIManager:closeWindow('UIXianMengSignSetupWin')
end

UIManager:invokeUIMethod('UIXianMengPalaceWin','refreshXMSign')
UIManager:invokeUIMethod('UIMainXMInfoWin','freshXMSign')
else
local logstr
if ret==1 then
logstr='没仙盟'
elseif ret==2 then
logstr='权限不足'
end
UIManager.error(logstr)
end
end


function xianmengController.do_protocol_20_32(ret,actorid)




if ret==0 then
local data=xianmengModel:getXMMemberData(actorid)
if data~=nil then
local name=data.actorname
xianmengModel:removeXMMember(actorid)

UIManager.info(FMT.fmt('玩家{0}已被移除仙盟',name))
UIManager:invokeUIMethod('UIXianMengPalaceWin','rec_remove_actor',actorid)
end
UIManager:invokeUIMethod('UIOthePlayerInfoWin','rebuildBtns')
elseif ret==-1 then

UIManager.info('你已被踢出仙盟')
xianmengController:onLeaveXM()
xianmengModel:markLeaveXMTime()
else
local logstr
if ret==1 then
logstr='没仙盟'
elseif ret==2 then
logstr='权限不足'
elseif ret==3 then
logstr='没这个玩家'
elseif ret==4 then
logstr='有山海世界外派队伍，操作失败'
elseif ret==5 then
logstr='处于征战山海战争期，操作失败'
end
UIManager.error(logstr)
end
end


function xianmengController.do_protocol_20_33(ret,notice)



if ret==0 or ret==-1 then
xianmengController:checkInsideNoticeSend(notice)
xianmengModel:setXMNotice(notice)

if ret==0 then
UIManager.info('公告修改成功')
end

UIManager:invokeUIMethod('UIXianMengPalaceWin','refreshXMNotice')
else
local logstr
if ret==1 then
logstr='没仙盟'
elseif ret==2 then
logstr='权限不足'
elseif ret==3 then
logstr='敏感字符串'
end
UIManager.error(logstr)
end
end


function xianmengController.do_protocol_20_34(ret,notice)



if ret==0 or ret==-1 then
xianmengModel:setXMNotice2(notice)

if ret==0 then
xianmengModel:recordNoticeStamp(true)
UIManager.info('公告修改成功')
end


else
local logstr
if ret==1 then
logstr='没仙盟'
elseif ret==2 then
logstr='权限不足'
elseif ret==3 then
logstr='敏感字符串'
end
UIManager.error(logstr)
end
end

function xianmengController.do_protocol_20_37(ret,actor1,actor2,pos1_old,pos2_old)
if ret==0 or ret==-1 then
local data1=xianmengModel:getXMMemberData(actor1)
local data2=xianmengModel:getXMMemberData(actor2)
if data1==nil or data2==nil then

return
end

local pos1_new=pos2_old
local pos2_new=pos1_old

local myActorid=playerModel:getActorID()
local ismy1=mathHelper.compareInt64(myActorid,actor1)
if ismy1 then
local old_postPrivile=xianmengModel.checkPostPrivile(pos1_old,GUILD_PRIVILE_TYPE.gptHandle)
local postPrivile=xianmengModel.checkPostPrivile(pos1_new,GUILD_PRIVILE_TYPE.gptHandle)
if old_postPrivile and not postPrivile then

xianmengModel:clearApplicationList()
UIManager:closeWindow('UIXianMengRequireWin')
reddotControl.on_xianmeng_application_changed()
elseif not old_postPrivile and postPrivile then

xianmengController:reqXMApplicationList()
end
end

local ismy2=mathHelper.compareInt64(myActorid,actor2)
if ismy2 then
local old_postPrivile=xianmengModel.checkPostPrivile(pos2_old,GUILD_PRIVILE_TYPE.gptHandle)
local postPrivile=xianmengModel.checkPostPrivile(pos2_new,GUILD_PRIVILE_TYPE.gptHandle)
if old_postPrivile and not postPrivile then

xianmengModel:clearApplicationList()
UIManager:closeWindow('UIXianMengRequireWin')
reddotControl.on_xianmeng_application_changed()
elseif not old_postPrivile and postPrivile then

xianmengController:reqXMApplicationList()
end
end


xianmengModel:setXMMemberPost(actor1,pos1_new)
xianmengModel:setXMMemberPost(actor2,pos2_new)

if ret==0 then
local postName=xianmengModel.getXMPostName(pos1_new)
local actorname=xianmengModel:getXMMemberName(actor1)
if pos1_new>pos1_old then
UIManager.info(FMT.fmt('{0}已降职为{1}',actorname,postName))
elseif pos1_new<pos1_old then
UIManager.info(FMT.fmt('{0}已升职为{1}',actorname,postName))
end

postName=xianmengModel.getXMPostName(pos2_new)
actorname=xianmengModel:getXMMemberName(actor2)
if pos2_new>pos2_old then
UIManager.info(FMT.fmt('{0}已降职为{1}',actorname,postName))
elseif pos2_new<pos2_old then
UIManager.info(FMT.fmt('{0}已升职为{1}',actorname,postName))
end
elseif ret==-1 then
if pos1_new==GUILD_POST_TYPE.gpAllyLeader then

local actorname=xianmengModel:getXMMemberName(actor1)
xianmengModel:setXMLeaderName(actorname)
UIManager:invokeUIMethod('UIXianMengPalaceWin','refreshXMLeaderName')
end
if pos2_new==GUILD_POST_TYPE.gpAllyLeader then

local actorname=xianmengModel:getXMMemberName(actor2)
xianmengModel:setXMLeaderName(actorname)
UIManager:invokeUIMethod('UIXianMengPalaceWin','refreshXMLeaderName')
end
UIManager:invokeUIMethod('UIXianMengPostSetWin','refreshView2',actor1,actor2,pos1_new,pos2_new)
end

if ismy1 and pos1_old>pos1_new then
local hourPos=chatMesgFilterControl.getHourPosByMsgType(CHAT_MSG_TYPE.eXianMengPosChange)
local content=FMT.fmt("祖师已被任命为仙盟{0}",xianmengModel.getXMPostName(pos1_new,true))
chatControl.onHandleCustomMesg(timeHelper.getServerShortTime(),'',content,hourPos,{CHAT_CHANNNEL.eXianmeng})
end

if ismy2 and pos2_old>pos2_new then
local hourPos=chatMesgFilterControl.getHourPosByMsgType(CHAT_MSG_TYPE.eXianMengPosChange)
local content=FMT.fmt("祖师已被任命为仙盟{0}",xianmengModel.getXMPostName(pos2_new,true))
chatControl.onHandleCustomMesg(timeHelper.getServerShortTime(),'',content,hourPos,{CHAT_CHANNNEL.eXianmeng})
end
if ismy1 or ismy2 then
UIManager:invokeUIMethod('UIXM_XMDG_ShopWin','refreshManageBtnShow')
reddotControl.on_change_catch_type(CATCH_TYPE.eXMDGShopManage)
reddotControl.on_change_catch_type(CATCH_TYPE.eLimitActChange,LIMIT_ACT_TYPE.eXianMengDiGong)
end
else
local logstr
if ret==1 then
logstr='没仙盟'
elseif ret==2 then
logstr='权限不足'
elseif ret==3 then
local postName=xianmengModel.getXMPostName(posid)
logstr=FMT.fmt('{0}职位已满',postName)
end
UIManager.error(logstr)
end
end

function xianmengController.req_254_85()
socketManager:send_254_85()
end


function xianmengController.do_protocol_254_85(len,list)

local xmList={}
if len>0 then
for i,v in ipairs(list)do
xmList[v.serverid]=v
end
end
xianmengModel:setDaQianShiJieData(xmList)
UIManager:callWindowFunc("UISubAct_KuaFuLieBiaoWin","refreshList",xmList)

end


function xianmengController.req_20_39()
socketManager:send_20_39()
end


function xianmengController.do_protocol_20_39(recruit,actorid)
local info=xianmengModel:getXMDetialData()
info.recruit=recruit
info.recruitActorid=actorid
UIManager:invokeUIMethod('UIXianMengPalaceWin','refreshInviteBtn')
end


function xianmengController._on_new_day()

xianmengModel:resetXMJuanXianData()
UIManager:invokeUIMethod('UIXMKuFangWin','refreshKuFangMoneyPanel')
UIManager:invokeUIMethod('UIXMKuFangWin','refreshKuFangJXPanel')
end


function xianmengController.req_20_136()
socketManager:send_20_136()
end

function xianmengController.req_20_137(itemId,jxNum)
socketManager:send_20_137(itemId,jxNum)
end

function xianmengController:testtt(itemId)
local a=int64.new("200")
socketManager:send_20_137(itemId,a)
end


function xianmengController.do_protocol_20_136(arge1,arge2,arge3,arge4)
xianmengModel:setXMJuanXianAllData(arge1,arge2,arge3,arge4)
end

function xianmengController.do_protocol_20_137(arge)
xianmengModel:setXMJuanXianSelfLogData(arge)
UIManager.info("捐赠成功")
UIManager:invokeUIMethod('UIXMKuFangWin','refreshKuFangMoneyPanel')
end

function xianmengController.do_protocol_20_138(arge)
xianmengModel:setXMJuanXianLogData(arge)
UIManager:invokeUIMethod('UIXMKuFangWin','refreshKuFangJXPanel')
end

