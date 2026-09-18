






local _MODULENAME="lundaodahuiController"





gameState.addListener(def_table(_MODULENAME))
lundaodahuiController.name=_MODULENAME
lundaodahuiController.data={}

function lundaodahuiController:onAppStart()
lundaodahuiModel:onAppStart()


socketManager:register_receiver(17,20,lundaodahuiController.recv_17_20)
socketManager:register_receiver(17,21,lundaodahuiController.recv_17_21)
socketManager:register_receiver(17,22,lundaodahuiController.recv_17_22)
socketManager:register_receiver(17,23,lundaodahuiController.recv_17_23)
socketManager:register_receiver(17,24,lundaodahuiController.recv_17_24)
socketManager:register_receiver(17,25,lundaodahuiController.recv_17_25)
socketManager:register_receiver(17,26,lundaodahuiController.recv_17_26)
socketManager:register_receiver(17,27,lundaodahuiController.recv_17_27)
socketManager:register_receiver(17,28,lundaodahuiController.recv_17_28)
socketManager:register_receiver(17,29,lundaodahuiController.recv_17_29)
socketManager:register_receiver(17,30,lundaodahuiController.recv_17_30)
socketManager:register_receiver(17,32,lundaodahuiController.recv_17_32)
socketManager:register_receiver(17,33,lundaodahuiController.recv_17_33)
socketManager:register_receiver(17,34,lundaodahuiController.recv_17_34)
socketManager:register_receiver(17,35,lundaodahuiController.recv_17_35)
socketManager:register_receiver(17,36,lundaodahuiController.recv_17_36)
socketManager:register_receiver(17,37,lundaodahuiController.recv_17_37)
socketManager:register_receiver(17,38,lundaodahuiController.recv_17_38)
socketManager:register_receiver(17,40,lundaodahuiController.recv_17_40)


socketManager:register_receiver(6,70,lundaodahuiController.recv_6_70)

notifySystem:listenNotify(notifyConfig.onNewDay,lundaodahuiController.on_new_day)
end



function lundaodahuiController:onEnterState(isReconnect)
self.openYuGao=nil
lundaodahuiModel:onEnterState()
end


function lundaodahuiController:onProtocolReq()
lundaodahuiModel:onProtocolReq()
lundaodahuiController.req_17_30()
timeEventController.addNormalTimerHandler(2,lundaodahuiController.name,lundaodahuiController)

end


function lundaodahuiController:onLeaveState(isReconnect)
lundaodahuiModel:onLeaveState(isReconnect)
if self.enterGuid then
enterManager:removeEnter(self.enterGuid)
self.enterGuid=nil
end
if self.enterRongYuTangGuid then
enterManager:removeEnter(self.enterRongYuTangGuid)
self.enterRongYuTangGuid=nil
end



self.data={}
self.stamp_20=nil
end


function lundaodahuiController:onLostConnection()

end


function lundaodahuiController:onReConnection(isInitPro)

end

function lundaodahuiController:onOpenView(isReconnect)
if not isReconnect then

end
end

function lundaodahuiController.on_new_day()
if lundaodahuiModel:checkOpenDay()then
lundaodahuiController.req_17_33()
end
end


function lundaodahuiController:onNormalUpdate(delay)
if lundaodahuiModel:checkLunDaoDaHuiEntryOpen()then
lundaodahuiModel:clearTTSGroupInfo()
lundaodahuiController.req_17_20()
end
local id,index=lundaodahuiModel:checkMatchTime()
if id then
lundaodahuiController.req_17_28(0)
lundaodahuiController.req_17_30()
lundaodahuiController.checkRongYuTangOpen()
self:showMatchStartPrompt(id)
end

if lundaodahuiModel:checkJueSaiMatchTime()then
UIFullLunDaoDaHuiControl:showTieLian()
UIManager:callWindowFunc("UIJueSaiZhiBoWin","refreshTopPanel")
end
end


function lundaodahuiController.req_17_20()

local stamp=timeHelper.getServerShortTime()
if lundaodahuiController.stamp_20==nil or lundaodahuiController.stamp_20 and(stamp-lundaodahuiController.stamp_20)>5 then
socketManager:send_17_20()
lundaodahuiController.stamp_20=stamp
return true
end
end


function lundaodahuiController.req_17_21(groupId)
socketManager:send_17_21(groupId)
end


function lundaodahuiController.req_17_22(groupId)
socketManager:send_17_22(groupId)
end


function lundaodahuiController.req_17_23(teamList)
local len=#teamList
if len>0 then
socketManager:send_17_23(len,teamList)
lundaodahuiController.isTeamUpdate=true
else
socketManager:send_17_23(0,{})
end
end


function lundaodahuiController.req_17_24(fightId,serverId,playerId,xzNum)
socketManager:send_17_24(fightId,serverId,playerId,xzNum)
end


function lundaodahuiController.req_17_25()
socketManager:send_17_25()
end


function lundaodahuiController.req_17_26()
socketManager:send_17_26()
end


function lundaodahuiController.req_17_27(startId,endId)
socketManager:send_17_27(startId,endId)
end


function lundaodahuiController.req_17_28(groupId)
socketManager:send_17_28(groupId)
end

function lundaodahuiController.req_17_29(jieShu,serverId,playerId,assist)
socketManager:send_17_29(jieShu,serverId,playerId,assist or 0)
end


function lundaodahuiController.req_17_30()
socketManager:send_17_30()
end

function lundaodahuiController.req_17_33()
socketManager:send_17_33()
end


function lundaodahuiController.req_17_34()
socketManager:send_17_34()
end


function lundaodahuiController.req_17_35()
if not lundaodahuiModel:getIsReqCredentialsList()then
lundaodahuiModel:setIsReqCredentialsList(true)
socketManager:send_17_35()
end
end

function lundaodahuiController.reqReceiveFirstSetTeamReward()
socketManager:send_17_40()
end

function lundaodahuiController.req_6_70(un_build_id)
socketManager:send_6_70(un_build_id)
end


function lundaodahuiController.recv_17_20(args)
local jieShu,myRank,len,xbsList,myRank2,jcbNum=args[1],args[2],args[3],args[4],args[5],args[6]
local startTime=timeHelper.convertLongStamp(args[7])
local myGroup=args[8]

lundaodahuiModel:initMyData(jieShu,myRank,myRank2,startTime)

lundaodahuiModel:initXBSData(xbsList,myGroup)

lundaodahuiModel:setJcbNum(jcbNum)



lundaodahuiModel:initMatchTime()
lundaodahuiController.checkMatchEnterOpen()
lundaodahuiController.checkRongYuTangOpen()
if not lundaodahuiModel.data.isInitTeam and lundaodahuiModel:checkLunDaoDaHuiEntry()then
lundaodahuiController.req_17_23({})
lundaodahuiModel.data.isInitTeam=true
end


UIManager:invokeUIMethod("UIXuanBaSaiMainWin","onRecv")
UIManager:invokeUIMethod("UIJueSaiZhiBoWin","freshMoney")
UIManager:invokeUIMethod("UILunDaoJinJiWin","refreshRank",myRank2)
UIManager:invokeUIMethod("UILunDaoDaHuiLeftWin","refreshMainItemGray",nil,1)


if(not lundaodahuiController.openYuGao)and mainControl:isInScene(eSceneType.eZongmen)then
UIFullLunDaoDaHuiControl:showTieLian()
lundaodahuiController.openYuGao=true
end
end

function lundaodahuiController.recv_17_21(groupInfo)
lundaodahuiModel:setXBSGroupInfo(groupInfo.groupId,groupInfo)

UIManager:invokeUIMethod("UILDGroupInfoWin","recvData")
end

function lundaodahuiController.recv_17_22(groupId,len,playerList)
lundaodahuiModel:setXBSRankData(groupId,playerList)

UIManager:invokeUIMethod("UILDGroupRankWin","recvData")
end

function lundaodahuiController.recv_17_23(len,teamList)
lundaodahuiModel:setMyTeam(teamList)
if lundaodahuiController.isTeamUpdate then
UIManager.info("保存成功")
lundaodahuiController.isTeamUpdate=nil
end
end

function lundaodahuiController.recv_17_24(fightInfo,xzNum,serverId,playerId,jcbNum)
local oldFightInfo=lundaodahuiModel:getTTSFightInfoByFightId(fightInfo.fightId)
local oldjcb=lundaodahuiModel:getJcbNum()
if oldFightInfo then

end
lundaodahuiModel:setJingCaiInfoStamp(fightInfo.fightId)
lundaodahuiModel:setTTSGroupInfo(fightInfo.fightId,fightInfo)
lundaodahuiModel:setJcbNum(jcbNum)
lundaodahuiModel:setJingCaiInfo(fightInfo.fightId,{xzNum,playerId})
UIManager:callWindowFunc("UILDJingCaiWin","onRefresh",fightInfo,xzNum,true,playerId,jcbNum)

UIManager:invokeUIMethod("UIXiaoZuSaiMainWin","doRefreshActiveCellViews")
UIManager:invokeUIMethod("UIBanJueSaiMainWin","onRecv")
UIManager:invokeUIMethod("UIJueSaiMainWin","onRecv")

UIManager:invokeUIMethod("UIJueSaiZhiBoWin","onRecv")
UIManager:invokeUIMethod("UIJueSaiZhiBoWin","freshMoney")

if oldjcb~=jcbNum then
notifySystem:postNotify(notifyConfig.onLundaodahuiJingCai)
lundaodahuiController:send_17_32()
end
end

function lundaodahuiController.recv_17_25(len,rankList,jcbNum)
UIManager:invokeUIMethod("UILDTTSRankWin","onRecvJingCai",rankList,jcbNum)
end

function lundaodahuiController.recv_17_26(len,sjList)
lundaodahuiModel:setTop3Data(sjList)

UIManager:invokeUIMethod("UILDRongYuTongListWin","onRecv")
end

function lundaodahuiController.recv_17_27(len,xbsList)

end

function lundaodahuiController.recv_17_28(len,ttsList)
lundaodahuiModel:initTTSGroupInfo(ttsList)

UIManager:invokeUIMethod("UIXiaoZuSaiMainWin","onRecv")
UIManager:invokeUIMethod("UIBanJueSaiMainWin","onRecv")
UIManager:invokeUIMethod("UIJueSaiMainWin","onRecv")

UIManager:invokeUIMethod("UIJueSaiZhiBoWin","onRecv")


notifySystem:postNotify(notifyConfig.onLundaodahuiJingCai)
lundaodahuiController.refreshDouFaTaiBaoXiang()

end

function lundaodahuiController.recv_17_29(jieShu,serverId,playerId,dzNum,myNum)
lundaodahuiModel:setDzNum(myNum)
lundaodahuiModel:setNewTop3DzNum(serverId,playerId,dzNum)
UIManager:invokeUIMethod("UILDRongYuTongWin","refreshZanNum")
UIManager:invokeUIMethod("UILDRongYuTongWin","refreshTopZanNum")
UIManager:invokeUIMethod("UIXiaoZuSaiMainWin","refreshRongYuReddot")
UIManager:invokeUIMethod("UILunDaoDaHuiLeftWin","refreshMainReddot",2)
UIManager:invokeUIMethod("UILunDaoDaHuiLeftWin","refreshChildReddot",1)
notifySystem:postNotify(notifyConfig.onLundaodahuiDianZan)
lundaodahuiController.refreshDouFaTaiBaoXiang()
end

function lundaodahuiController.recv_17_30(jieShu,listLen,sjList,myNum)
lundaodahuiModel.data.serverDzReddot=nil
lundaodahuiModel:setNewTop3Data(jieShu,sjList)
lundaodahuiModel:setDzNum(myNum)
UIManager:invokeUIMethod("UILDRongYuTongWin","onRecv")
UIManager:invokeUIMethod("UIXiaoZuSaiMainWin","refreshRongYuReddot")
notifySystem:postNotify(notifyConfig.onLundaodahuiDianZan)
lundaodahuiController.refreshDouFaTaiBaoXiang()
if listLen==0 then
lundaodahuiController:removeRongYuTangEnter()
end
end

function lundaodahuiController.recv_6_70(listLen,dxList)
lundaodahuiModel:setDxData(dxList)
UIManager:invokeUIMethod("UILDDiaoXiangShowWin","onRecv")
end

function lundaodahuiController:send_17_32()
socketManager:send_17_32()
end

function lundaodahuiController.recv_17_32(len,msgList)
if len>0 then
local isAdd=false
local list={}
for i,v in ipairs(msgList)do
local chatInfo=lundaodahuiModel:addGuessMsg(v)
isAdd=chatInfo~=nil or isAdd
if chatInfo then
table.insert(list,chatInfo)
end
end
if isAdd then

UIManager:invokeUIMethod("UIJueSaiZhiBoWin","onRecvMesgList",list)
end

end
end

function lundaodahuiController.recv_17_33(a)
local startTime,dzNum,sjNum,csFlag,jieshu=a[1],a[2],a[3],a[4],a[5]
local jjType,jjResult,xbsRank,lddhRank=a[6],a[7],a[8],a[9]
local teamSetFlag=a[10]
lundaodahuiModel.data.sjNum=sjNum
lundaodahuiModel:setDzNum(dzNum)
lundaodahuiModel:setTeamSetFlag(teamSetFlag)
lundaodahuiModel:initStartTimeData(timeHelper.convertLongStamp(startTime))
lundaodahuiModel:initJieShuData(jieshu)
lundaodahuiModel:initMatchTime()
lundaodahuiController.checkMatchEnterOpen()
lundaodahuiController.checkRongYuTangOpen()
if lundaodahuiModel:checkLunDaoDaHuiEntry()then
lundaodahuiController.req_17_23({})
end
notifySystem:postNotify(notifyConfig.onLundaodahuiDianZan)
lundaodahuiController.refreshDouFaTaiBaoXiang()

local sTime,eTime=lundaodahuiModel:getLunDaoDaHuiTime(true)
if sTime then
limitActivitiesModel:addClientAct(LIMIT_ACT_TYPE.eLunDaoDaHui,sTime,eTime)
end
enterManager:freshFunc('startTimer',ENTER_TYPE.eLunDaoDaHui)

local nowTime=timeHelper.getServerShortTime()
if csFlag==1 and(eTime and nowTime<eTime)then

local isShowed=false
local invitationStartTime=userActorArraySetting.get(ACTOR_SETTING_TYPE.eLunDaoDaHui,'invitationStartTime',nil)
if invitationStartTime and invitationStartTime==startTime then
isShowed=true
end
if not isShowed then

msgWinControl:addMsgWin(msgWinType.eLunDaoInvitation)
userActorArraySetting.set(ACTOR_SETTING_TYPE.eLunDaoDaHui,'invitationStartTime',startTime)
userActorArraySetting.flush(ACTOR_SETTING_TYPE.eLunDaoDaHui)
end
end

if jjType>0 then
lundaodahuiController.recv_17_37(jjType,jjResult,xbsRank,lddhRank)
end
end


function lundaodahuiController.recv_17_34(len,recordList)
UIManager:invokeUIMethod("UILDTTSRankWin","onRecvRecord",recordList)
end


function lundaodahuiController.recv_17_35(len,credentialsList)
lundaodahuiModel:setCredentialsList(len,credentialsList)


UIManager:invokeUIMethod("UIDouFaTaiRankWin","refreshSelfInfo")
UIManager:invokeUIMethod("UIDouFaTaiRankWin","refreshRank")


UIManager:invokeUIMethod("UIDouFaTaiCredentialsListWin","refreshCredentialsList")
UIManager:invokeUIMethod("UIDouFaTaiCredentialsListWin2","refreshCredentialsList")
end


function lundaodahuiController.recv_17_36()

douFaTaiModel:set_doufatai_truceStartTime()


local isTruce=douFaTaiModel:checkIsTruce()
local doufataiSettleTime
if isTruce then

doufataiSettleTime=douFaTaiModel:get_doufatai_truceStartTime()
else

doufataiSettleTime=douFaTaiModel:get_doufatai_settleTime()
end
if doufataiSettleTime then
local entryTime=cfgHelper.get(cfg_dftlundaodahuibasicconfig_get,1,"actTime")
local deltaTime=cfgHelper.get(cfg_dftlundaodahuibasicconfig_get,1,"startTime")
local startTime=doufataiSettleTime+deltaTime
local endTime=startTime+entryTime
local nowTime=timeHelper.getServerShortTime()
if endTime and nowTime<endTime then

local isShowed=false
local invitationStartTime=userActorArraySetting.get(ACTOR_SETTING_TYPE.eLunDaoDaHui,'invitationStartTime',nil)
if invitationStartTime and invitationStartTime==startTime then
isShowed=true
end
if not isShowed then

msgWinControl:addMsgWin(msgWinType.eLunDaoInvitation)
userActorArraySetting.set(ACTOR_SETTING_TYPE.eLunDaoDaHui,'invitationStartTime',startTime)
userActorArraySetting.flush(ACTOR_SETTING_TYPE.eLunDaoDaHui)
end
end
end
end

function lundaodahuiController.recv_17_37(jjType,jjRst,xbsRank,lddhRank)
if jjRst==1 then
if jjType==1 or jjType==2 or jjType==3 or jjType==6 or jjType==7 then
msgWinControl:addMsgWin(msgWinType.eLunDaoJinJi,{JinJiType=jjType,xbsRank=xbsRank,lddhRank=lddhRank})
else
if jjType==4 then
local hideResult,time=lundaodahuiModel:checkJueSaiAfterMatchTime(eLDMatchType.jijunsai,true)
if hideResult then
timeEventController.delayDo(time,function()
msgWinControl:addMsgWin(msgWinType.eLunDaoRank,{JinJiType=jjType,xbsRank=xbsRank,lddhRank=lddhRank,isWin=true})
end)
else
msgWinControl:addMsgWin(msgWinType.eLunDaoRank,{JinJiType=jjType,xbsRank=xbsRank,lddhRank=lddhRank,isWin=true})
end
elseif jjType==5 then
local hideResult,time=lundaodahuiModel:checkJueSaiAfterMatchTime(eLDMatchType.juesai,true)
if hideResult then
timeEventController.delayDo(time,function()
msgWinControl:addMsgWin(msgWinType.eLunDaoRank,{JinJiType=jjType,xbsRank=xbsRank,lddhRank=lddhRank,isWin=true})
end)
else
msgWinControl:addMsgWin(msgWinType.eLunDaoRank,{JinJiType=jjType,xbsRank=xbsRank,lddhRank=lddhRank,isWin=true})
end
end
end
else
if jjType==3 then
msgWinControl:addMsgWin(msgWinType.eLunDaoXiBai,{JinJiType=jjType})
else
if jjType==4 then
local hideResult,time=lundaodahuiModel:checkJueSaiAfterMatchTime(eLDMatchType.jijunsai,true)
if hideResult then
timeEventController.delayDo(time,function()
msgWinControl:addMsgWin(msgWinType.eLunDaoRank,{JinJiType=jjType,xbsRank=xbsRank,lddhRank=lddhRank,isWin=false})
end)
else
msgWinControl:addMsgWin(msgWinType.eLunDaoRank,{JinJiType=jjType,xbsRank=xbsRank,lddhRank=lddhRank,isWin=false})
end
elseif jjType==5 then
local hideResult,time=lundaodahuiModel:checkJueSaiAfterMatchTime(eLDMatchType.juesai,true)
if hideResult then
timeEventController.delayDo(time,function()
msgWinControl:addMsgWin(msgWinType.eLunDaoRank,{JinJiType=jjType,xbsRank=xbsRank,lddhRank=lddhRank,isWin=false})
end)
else
msgWinControl:addMsgWin(msgWinType.eLunDaoRank,{JinJiType=jjType,xbsRank=xbsRank,lddhRank=lddhRank,isWin=false})
end
else
msgWinControl:addMsgWin(msgWinType.eLunDaoRank,{JinJiType=jjType,xbsRank=xbsRank,lddhRank=lddhRank,isWin=false})
end
end
end
end

function lundaodahuiController.recv_17_38(serverId,playerId,name,iconInfo)
local watchTimes=lundaodahuiModel:getWatchJueSaiTimes(eLDMatchType.juesai)
local hideResult,time=lundaodahuiModel:checkJueSaiAfterMatchTime(eLDMatchType.juesai,true)




if hideResult then
timeEventController.delayDo(time,function()
msgWinControl:addMsgWin(msgWinType.eLunDaoGuanJun,{serverId=serverId,playerId=playerId,name=name,piList=iconInfo})
end)
else
msgWinControl:addMsgWin(msgWinType.eLunDaoGuanJun,{serverId=serverId,playerId=playerId,name=name,piList=iconInfo})
end

end

function lundaodahuiController.recv_17_40(flag)
lundaodahuiModel:setTeamSetFlag(flag)

UIManager:invokeUIMethod("UIXuanBaSaiMainWin","refreshSetTeamButtonTips")
UIManager:invokeUIMethod("UIXiaoZuSaiMainWin","refreshSetTeamButtonTips")
UIManager:invokeUIMethod("UIBanJueSaiMainWin","refreshSetTeamButtonTips")
UIManager:invokeUIMethod("UIJueSaiMainWin","refreshSetTeamButtonTips")

UIManager:invokeUIMethod("UILunDaoDaHuiLeftWin","refreshComboWidget")

enterManager:freshFunc('refreshQiPao',ENTER_TYPE.eLunDaoDaHui)
end


function lundaodahuiController.checkMatchEnterOpen()
local result=lundaodahuiModel:checkLunDaoDaHuiEntry()
if result then
if not lundaodahuiController.enterGuid then
lundaodahuiController.enterGuid=enterManager:freshEnter({id=1,enterIconType=ENTER_ICON_TYPE.eNomal,enterType=ENTER_TYPE.eLunDaoDaHui,getReddotFun=function()return lundaodahuiModel:checkJingCaiAllReddot()end})
end
lundaodahuiModel:initMatchTime()
end
end


function lundaodahuiController:removeMatchEnter()
if self.enterGuid then
enterManager:freshFunc('onClose',ENTER_TYPE.eLunDaoDaHui)
enterManager:removeEnter(self.enterGuid)
UIManager:callWindowFunc('UIMainEntryWin','freshInfo')
self.enterGuid=nil
end
end


function lundaodahuiController.checkRongYuTangOpen()
local result=lundaodahuiModel:checkRongYuTangEntry()
local num=lundaodahuiModel:getNewTop3DataNum()
local sjNum=lundaodahuiModel:getSJNum()
if result and(num>0 or sjNum>0)then
lundaodahuiController.req_17_26()
if not lundaodahuiController.enterRongYuTangGuid then
lundaodahuiController.enterRongYuTangGuid=enterManager:freshEnter({id=1,enterIconType=ENTER_ICON_TYPE.eNomal,enterType=ENTER_TYPE.eRongYuTang})
end
end
timeEventController.delayDo(2,function()
local sTime,eTime=lundaodahuiModel:getLunDaoDaHuiTime(true)
if sTime then
limitActivitiesModel:removeActInfo(LIMIT_ACT_TYPE.eLunDaoDaHui)
limitActivitiesModel:addClientAct(LIMIT_ACT_TYPE.eLunDaoDaHui,sTime,eTime)
end
end)
end

function lundaodahuiController:removeRongYuTangEnter()
if self.enterRongYuTangGuid then
enterManager:freshFunc('onClose',ENTER_TYPE.eRongYuTang)
enterManager:removeEnter(self.enterRongYuTangGuid)
self.enterRongYuTangGuid=nil
UIManager:callWindowFunc('UIMainEntryWin','freshInfo')
end
end

function lundaodahuiController.refreshDouFaTaiBaoXiang()
local bdData=zongmenModel:getBuildingDataByBdType(mapIdType.zhufeng,SLG_SYSTEM_TYPE.eDouFaTai)
if bdData and next(bdData)then
hudControl:refreshBuildingStatusHUD(bdData[1].un_build_id)
end
end


function lundaodahuiController:setHead(grid,icon)
playerController:setHeadIcon(grid,0,{scale=0.55,iconInfo=icon})
end

function lundaodahuiController:showTime(timeWidget,titleWidget,titleBgWidget)
local showBg=true
local isOpen=lundaodahuiModel:checkLunDaoDaHuiEntry()
if isOpen then
local id=lundaodahuiModel:getCurMatchType()
if id and id<2 then
timeWidget:setText("淘汰赛尚未开启")
showBg=false
else
local nowTime=timeHelper.getServerLongTime()
local matchType=eLDMatchType.top8
local matchList={eLDMatchType.top32,eLDMatchType.top16,eLDMatchType.top8}
for i,v in ipairs(matchList)do
local matchTime=lundaodahuiModel:getMatchTime(v)
if matchTime and nowTime<matchTime then
matchType=v
break
end
end
if matchType==eLDMatchType.top32 then
timeWidget:setText("比赛阶段：16强赛")
local nowTime=timeHelper.getServerLongTime()
local matchTime=lundaodahuiModel:getMatchTime(eLDMatchType.top32)
local bsTime=cfgHelper.get(cfg_dftlundaodahuibisaiconfig_get,eLDMatchType.top32,"bsTime")
if nowTime<timeHelper.getServerZeroStamp(matchTime)then
titleWidget:setText(FMT.fmt("明日{0}点进行16强赛",bsTime[2]))
else
titleWidget:setText(FMT.fmt("{0}点进行16强赛",bsTime[2]))
end
elseif matchType==eLDMatchType.top16 then
timeWidget:setText("比赛阶段：8强赛")
local bsTime=cfgHelper.get(cfg_dftlundaodahuibisaiconfig_get,eLDMatchType.top16,"bsTime")
if bsTime[3]>0 then
titleWidget:setText(FMT.fmt("{0}点{1}分进行8强赛",bsTime[2],bsTime[3]))
else
titleWidget:setText(FMT.fmt("{0}点进行8强赛",bsTime[2]))
end
elseif matchType==eLDMatchType.top8 then
local nowTime=timeHelper.getServerLongTime()
local matchTime=lundaodahuiModel:getMatchTime(eLDMatchType.top8)
timeWidget:setText("比赛阶段：4强赛")
if nowTime>=matchTime then
local matchTimeBan=lundaodahuiModel:getMatchTime(eLDMatchType.banjuesai)
local zeroTime=timeHelper.getServerZeroStamp(matchTimeBan)
if nowTime>=zeroTime then
if nowTime<matchTimeBan then
local bsTime=cfgHelper.get(cfg_dftlundaodahuibisaiconfig_get,eLDMatchType.banjuesai,"bsTime")
timeWidget:setText("比赛阶段：半决赛")
if bsTime[3]>0 then
titleWidget:setText(FMT.fmt("{0}点{1}分进行半决赛",bsTime[2],bsTime[3]))
else
titleWidget:setText(FMT.fmt("{0}点进行半决赛",bsTime[2]))
end
else
local matchTimeJiJun=lundaodahuiModel:getMatchTime(eLDMatchType.jijunsai)
if nowTime<matchTimeJiJun then
local bsTime=cfgHelper.get(cfg_dftlundaodahuibisaiconfig_get,eLDMatchType.jijunsai,"bsTime")
if nowTime<timeHelper.getServerZeroStamp(matchTimeJiJun)then
timeWidget:setText("比赛阶段：季军赛")
if bsTime[3]>0 then
titleWidget:setText(FMT.fmt("明日{0}点{1}分进行季军赛",bsTime[2],bsTime[3]))
else
titleWidget:setText(FMT.fmt("明日{0}点进行季军赛",bsTime[2]))
end

else
timeWidget:setText("比赛阶段：季军赛")
if bsTime[3]>0 then
titleWidget:setText(FMT.fmt("{0}点{1}分进行季军赛",bsTime[2],bsTime[3]))
else
titleWidget:setText(FMT.fmt("{0}点进行季军赛",bsTime[2]))
end
end
else
local matchTimeJue=lundaodahuiModel:getMatchTime(eLDMatchType.juesai)
if nowTime<matchTimeJue then
local bsTime=cfgHelper.get(cfg_dftlundaodahuibisaiconfig_get,eLDMatchType.juesai,"bsTime")
if nowTime<timeHelper.getServerZeroStamp(matchTimeJue)then
timeWidget:setText("比赛阶段：冠军赛")
if bsTime[3]>0 then
titleWidget:setText(FMT.fmt("明日{0}点{1}分进行冠军赛",bsTime[2],bsTime[3]))
else
titleWidget:setText(FMT.fmt("明日{0}点进行冠军赛",bsTime[2]))
end

else
timeWidget:setText("比赛阶段：冠军赛")
if bsTime[3]>0 then
titleWidget:setText(FMT.fmt("{{0}点{1}分进行冠军赛",bsTime[2]))
else
titleWidget:setText(FMT.fmt("{0}点进行冠军赛",bsTime[2]))
end
end
else
showBg=false
local startTime=lundaodahuiModel:getLunDaoDaHuiTime()
if startTime and startTime>nowTime then
local y,m,d,h=timeHelper.getDateNumber(startTime)
timeWidget:setText(FMT.fmt("{0}月{1}日{2}点开启下届",m,d,h))
else
timeWidget:setText("淘汰赛已结束")
end
end
end
end
else
local bsTime=cfgHelper.get(cfg_dftlundaodahuibisaiconfig_get,eLDMatchType.banjuesai,"bsTime")
timeWidget:setText("比赛阶段：半决赛")
titleWidget:setText(FMT.fmt("明日{0}点进行半决赛",bsTime[2]))
end
else
local bsTime=cfgHelper.get(cfg_dftlundaodahuibisaiconfig_get,eLDMatchType.top8,"bsTime")
titleWidget:setText(FMT.fmt("{0}点进行4强赛",bsTime[2]))
end
end
end
else
showBg=false
local nowTime=timeHelper.getServerLongTime()
local startTime=lundaodahuiModel:getLunDaoDaHuiTime()
if startTime and startTime>nowTime then
local y,m,d,h=timeHelper.getDateNumber(startTime)
timeWidget:setText(FMT.fmt("{0}月{1}日{2}点开启下届",m,d,h))
else
timeWidget:setText("淘汰赛已结束")
end
end

titleBgWidget:setActive(showBg)
end


function lundaodahuiController:checkShowSetTeamFlag()
local flag=lundaodahuiModel:getTeamSetFlag()
return flag==0 and lundaodahuiController:checkNotEnd()and(lundaodahuiModel:getMyRank()or 0)>0
end

function lundaodahuiController:checkNotEnd()
local juesaiMatchTime=lundaodahuiModel:getMatchTime(eLDMatchType.juesai)
local checkOpen=false
local now=timeHelper.getServerLongTime()
if juesaiMatchTime then
checkOpen=lundaodahuiModel:checkLunDaoDaHuiEntry()and now<juesaiMatchTime
end

return checkOpen and lundaodahuiModel:checkOpenDay()
end

function lundaodahuiController:checkInMatchTypes(types)
local matchType=lundaodahuiModel:getCurMatchType()
for index,type in ipairs(types)do
if matchType==type then
return true
end
end
return false
end

function lundaodahuiController:tryGetTaoTaiMatchTips()

local nowTime=timeHelper.getServerLongTime()
local matchType=eLDMatchType.top8
local matchList={eLDMatchType.top32,eLDMatchType.top16,eLDMatchType.top8}
for i,v in ipairs(matchList)do
local matchTime=lundaodahuiModel:getMatchTime(v)
if matchTime and nowTime>=matchTime then
matchType=v
end
end

local tenMinutesInSeconds=60*10
local matchTime=lundaodahuiModel:getMatchTime(matchType)

if matchType==eLDMatchType.top32 then
return self:getMatchName(eLDMatchType.top32),
1,
(nowTime>=matchTime)and(nowTime<matchTime+tenMinutesInSeconds)
elseif matchType==eLDMatchType.top16 then
return self:getMatchName(eLDMatchType.top16),
1,
(nowTime>=matchTime)and(nowTime<matchTime+tenMinutesInSeconds)
elseif matchType==eLDMatchType.top8 then

local matchTimeBan=lundaodahuiModel:getMatchTime(eLDMatchType.banjuesai)

if nowTime>=matchTimeBan then
return self:getMatchName(eLDMatchType.banjuesai),
2,
(nowTime>=matchTimeBan)and(nowTime<matchTimeBan+tenMinutesInSeconds)
else
return self:getMatchName(eLDMatchType.top8),
1,
(nowTime>=matchTime)and(nowTime<matchTime+tenMinutesInSeconds)
end

end
return"",false
end

function lundaodahuiController:getMatchName(matchType)
if matchType==eLDMatchType.top32 then
return"论道16强赛"
elseif matchType==eLDMatchType.top16 then
return"论道8强赛"
elseif matchType==eLDMatchType.top8 then
return"论道4强赛"
elseif matchType==eLDMatchType.banjuesai then
return"论道半决赛"
end

return""
end

function lundaodahuiController:showMatchStartPrompt(matchType)
if matchType<eLDMatchType.top32 or matchType>eLDMatchType.banjuesai then
return
end

local subPage=1
if matchType==eLDMatchType.banjuesai then
subPage=2
end

local args={
actID=LIMIT_ACT_TYPE.eLunDaoDaHui,
tipsText=self:getMatchName(matchType),
gotoText="前往查看",
gotoExtraParams={
page=2,
subPage=subPage
}
}


UIManager:showWindow("UILimitActTipsWin",args)
end


function lundaodahuiController.enterOpen_test()
lundaodahuiController.enterGuid=enterManager:freshEnter({id=1,enterIconType=ENTER_ICON_TYPE.eNomal,enterType=ENTER_TYPE.eLunDaoDaHui})
end
