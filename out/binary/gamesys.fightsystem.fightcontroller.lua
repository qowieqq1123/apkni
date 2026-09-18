







local _MODULENAME="fightController"






gameState.addListener(def_table(_MODULENAME))

fightController.name=_MODULENAME
fightController.data={}


function fightController:onAppStart()

fightModel:onAppStart()



socketManager:register_receiver(254,25,self.recv_254_25)
socketManager:register_receiver(254,29,self.recv_254_29)
socketManager:register_receiver(254,58,self.recv_254_58)
socketManager:register_receiver(254,62,self.recv_254_62)





notifySystem:listenNotify(notifyConfig.onTriggerBattle,self.onTriggerBattle)




fightManager.init()
end


function fightController:onEnterState()
fightModel:onEnterState()
fBTBehaviorMrg:enterState()
UIManager:showWindow('UIFightMainHUD')
end


function fightController:onServerDataInitFinish()
fightModel:onServerDataInitFinish()
end


function fightController:onLeaveState(isReconnet)
if self.curBattle then
self.curBattle.onCloseCall=nil
self:closeBattle(self.curBattle.id)
end
fBTBehaviorMrg:leaveState()
self:closeSelectStage()
fightModel:onLeaveState(isReconnet)

self.data={}
self.curBattle=nil
end


function fightController:onLostConnection()

end



function fightController:isSystemOpen()
return true
end


function fightController:onProtocolReq()

fightController.saveTeamPrefabListData(1)
end




function fightController:send_254_29(logId,args,isCrossServer,isBigCrossServer,log_act_type,isZZSHSeason)
local stamp=timeHelper.getServerShortTime()
if self.data.sendLogStamp and self.data.sendLogStamp+3>stamp then
return
end
self.data.sendLogStamp=stamp

logId=tostring(logId)
fightModel:saveRePlayFightParam(args)

local fightLog=fightModel:getLogReport(logId)
if fightLog then
fightController.recv_fight_log(logId,fightLog)
return
end

if isBigCrossServer and log_act_type then
socketManager:send_254_114(log_act_type,logId)
elseif isBigCrossServer and isZZSHSeason then
socketManager:send_254_127(logId)
elseif isBigCrossServer then
socketManager:send_254_113(logId)
elseif isCrossServer then
socketManager:send_254_58(logId)
else
socketManager:send_254_29(logId)
end
end

function fightController.saveTeamPrefabListData(opType)
if opType==1 then
socketManager:send_254_25(1,0,{},0,{},0,{})
else
local nameData,discipleData,zfData=fightPreSelectModel:saveTeamPrefabListData()
if#nameData>0 and#discipleData>0 then
socketManager:send_254_25(2,#nameData,nameData,#discipleData,discipleData,#zfData,zfData)
end
end
end

function fightController.recv_254_25(argtable)
local nameLen,nameList,discipleLen,discipleList,zhenFaLen,zhenFaList=argtable[1],argtable[2],argtable[3],argtable[4],argtable[5],argtable[6]
if nameLen>0 and discipleLen>0 then
fightPreSelectModel:loadTeamPrefabListData(nameList,discipleList,zhenFaList)
end
end

function fightController.recv_254_29(log_id,len,list)
local fightLog=''
if list then
for i,v in ipairs(list)do
fightLog=FMT.fmt("{0}{1}",fightLog,v)
end
end
fightController.recv_fight_log(log_id,fightLog)
end

function fightController.recv_254_58(log_id,len,list)
local fightLog=''
if list then
for i,v in ipairs(list)do
fightLog=FMT.fmt("{0}{1}",fightLog,v)
end
end
fightController.recv_fight_log(log_id,fightLog)
end

function fightController.recv_fight_log(log_id,fightLog)
if fightLog==''then
UIManager.error("回放失败，战斗记录已过期或无效")
return
end
local args=fightModel:getRePlayFightParam(log_id)or{}
local fightType
if args.eReplayType then
fightType=args.eReplayType
else
if args[3]then
fightType=args[3]
end
end

fightModel:saveLogReport(log_id,fightLog)

if args.extraCall then
args.extraCall(fightLog)
return
end

local handle=fightRePlayHandle:getHandle(fightType)
local exchangeHp=handle and handle.exchangeHp
local onComplete=function(battleID,isShowWindow,stageCfg,isReconnet)
if handle then
if handle.onCompleteBattle then
args.isReconnet=isReconnet
handle.onCompleteBattle(battleID,args)
end
end
end

local onClose=function(battleID)
if handle and handle.onCloseBattle then
handle.onCloseBattle(battleID,args)
end
end

local showStage=handle and handle.showStage
if not showStage then
showStage=true
end
local hideExitWatch=handle and handle.hideExitWatch or false
local showSkipAll=handle and handle.showSkipAll or false
local playmoveAni=handle and handle.playmoveAni or false
local isCalcTotalStatistics=handle and handle.isCalcTotalStatistics or false
local showSkipAllByleftBottom=handle and handle.showSkipAllByleftBottom or 0
local battleType=handle.battleType
local useReportMapId=handle.useReportMapId
local battleID=fightController:startBallte(fightLog,showStage,onComplete,onClose,{hideExitWatch=hideExitWatch,showSkipAll=showSkipAll,playmoveAni=playmoveAni,showSkipAllByleftBottom=showSkipAllByleftBottom,isCalcTotalStatistics=isCalcTotalStatistics,isRePlay=true,exchangeHp=exchangeHp,battleType=battleType,useReportMapId=useReportMapId})

if handle and handle.onStartBattle then
handle.onStartBattle(battleID,args)
end
end










local saveLogListArgs={}
function fightController:send_log_list(logList,args,isCrossServer,isBigCrossServer,log_act_type,isZZSHSeason)

local requestLogStamp=self.requestLogStamp
local stamp=timeHelper.getServerShortTime()
if requestLogStamp and stamp<(requestLogStamp+1)then return end
self.requestLogStamp=stamp

saveLogListArgs[table.concat(logList,"|")]=args

local fightLogList={}
for i,id in ipairs(logList)do
local log=fightModel:getLogReport(id)
if log then
table.insert(fightLogList,log)
end
end
if#fightLogList==#logList then
fightController.recv_open_report(logList,fightLogList)
return
end

if isBigCrossServer and log_act_type then
socketManager:send_254_104(log_act_type,#logList,logList)
elseif isBigCrossServer and isZZSHSeason then
socketManager:send_254_126(#logList,logList)
elseif isBigCrossServer then
socketManager:send_254_103(#logList,logList)
elseif isCrossServer then
socketManager:send_254_63(#logList,logList)
else
socketManager:send_254_62(#logList,logList)
end
end


function fightController:send_log_list_ex(logList,showArgs,fightLogReqType,reqArgs)
local requestLogStamp=self.requestLogStamp
local stamp=timeHelper.getServerShortTime()
if requestLogStamp and stamp<(requestLogStamp+1)then return end
self.requestLogStamp=stamp

saveLogListArgs[table.concat(logList,"|")]=showArgs

local fightLogList={}
for i,id in ipairs(logList)do
local log=fightModel:getLogReport(id)
if log then
table.insert(fightLogList,log)
end
end
if#fightLogList==#logList then
fightController.recv_open_report(logList,fightLogList)
return
end

if fightLogReqType==eFightLogReqType.eBigCrossAct then
socketManager:send_254_104(unpack(reqArgs),#logList,logList)
elseif fightLogReqType==eFightLogReqType.eBigCrossAndLocal then
socketManager:send_254_122(unpack(reqArgs),#logList,logList)
elseif fightLogReqType==eFightLogReqType.eBigCross then
socketManager:send_254_103(#logList,logList)
elseif fightLogReqType==eFightLogReqType.eCross then
socketManager:send_254_63(#logList,logList)
else
socketManager:send_254_62(#logList,logList)
end
end

function fightController:checkLogIdList(logIdList)
for i,id in ipairs(logIdList)do
if not fightModel:getLogReport(id)then
return false
end
end
return true
end

function fightController.recv_254_62(fightloglistlen,fightlogList)
local logList={}
local logIdList={}
local key=table.concat(logIdList,"|")
if fightloglistlen>0 then
for i,v in ipairs(fightlogList)do
local fightLog=''
if v.list then
for i,v in ipairs(v.list)do
fightLog=FMT.fmt("{0}{1}",fightLog,v)
end
end
table.insert(logList,fightLog)
table.insert(logIdList,v.fightlog_Id)
if fightLog~=''then
fightModel:saveLogReport(v.fightlog_Id,fightLog)
end
end
end

if fightlogList and fightlogList[1].len and fightlogList[1].len==0 then
saveLogListArgs[key]=nil
UIManager.error("回放失败，战斗记录已过期或无效")
return
end

fightController.recv_open_report(logIdList,logList)
end

function fightController.recv_open_report(logIdList,logList)
local key=table.concat(logIdList,"|")
local args=saveLogListArgs[key]
local showBattle=nil
local fightType
if args then
fightType=args.eReplayType
showBattle=args.showBattle
saveLogListArgs[key]=nil
else
loggerUtil.logErrFMT("回放参数为空,{0}",key)
return
end

args.logIdList=logIdList
args.logList=logList

if args.extraCall then
args.extraCall(logList)
return
end

if showBattle then
fightController.startReplay(fightType,logList,args)
else
if args.callBack then
args.callBack({fightType=fightType,logIdList=logIdList,logStrList=logList,extraArgs=args})
else
fightController.openReplayWin(fightType,logIdList,logList,args)
end
end
end

















function fightController:closeBattle(id,closeFullUI)
if self.curBattle~=nil then

self.curBattle=nil

end

local battle=fightModel:getBattle(id)
if battle then
battle:close(closeFullUI)
end
end

function fightController:completeBattle(id,skip,skipAll)
local battle=fightModel:getBattle(id)
if battle then
if skipAll then
battle:onComplete(skip,true)
else
battle:onComplete(skip)
end
end
end









function fightController:startBallte(reportStr,showStage,onComplete,onClose,args,sendExtraArgs)

if deviceHelper.isRunEditor()and self.testBattleMode then
reportStr=self.testBattleStr
end

args=args or{}

local isSkip=sendExtraArgs~=nil and sendExtraArgs.isSkip or false
if isSkip then
if onComplete then
onComplete(nil,true,nil,false)
end
return
end

local clearStage=args.clearStage==nil and true or args.clearStage
if self.curBattle~=nil and showStage then
if self.curBattle.isShowWindow then
self.curBattle:hideStage(clearStage)
self.curBattle:closeMainUI(clearStage)
end
self.curBattle=nil
end

local useReportMapId=false
if args.useReportMapId then
useReportMapId=true
end
self:saveReport(reportStr)
self.curBattle=fightModel:createBattle(reportStr,onComplete,onClose,useReportMapId)
self.curBattle.isShowStage=showStage
self.curBattle.hideExitWatch=args.hideExitWatch
self.curBattle.isRePlay=args.isRePlay
self.curBattle.newbieGuide=gameplotModel:inNovicePlot()
self.curBattle.mustLook=args.mustLook
self.curBattle.hideStartWin=args.hideStartWin
self.curBattle.repeatPlayRound=args.repeatPlayRound
self.curBattle.entHideHud=args.entHideHud
self.curBattle.onCompleteBattleDelay=args.onCompleteBattleDelay
self.curBattle.fightUseType=args.fightUseType or FIGHT_USE_TYPE.eNormal
self.curBattle.showSkipAll=args.showSkipAll
self.curBattle.playmoveAni=args.playmoveAni
self.curBattle.showSkipAllByleftBottom=args.showSkipAllByleftBottom
self.curBattle.isCalcTotalStatistics=args.isCalcTotalStatistics
if args.fightType then
self.curBattle.fightType=args.fightType
end

if args.exchangeHp then
self.curBattle.exchangeHp=args.exchangeHp
else
if args.teamHpType then
self.curBattle.teamHpType=args.teamHpType
end
end

self.curBattle.battleType=args.battleType
self.curBattle:setSendExtraArgs(sendExtraArgs)

if args.battleType then
local time=cfgHelper.getglobal("fightRoundTime")
if time[args.battleType]then
self.curBattle.roundDefaultTime=time[args.battleType]
end
end

self.curBattle:start(showStage,args.enterAni,args.resetCamera)

notifySystem:postNotify(notifyConfig.onBattleStart)
return self.curBattle.id
end



function fightController:testBattle(flag)
if flag then
self.testBattleMode=true
self.testBattleStr=self:testReport("08m28d22h40m47s-1")
else
self.testBattleMode=false
end
end

function fightController:testReport(reportName)
local filename=''
if deviceHelper.isRunEditor()then
filename=FMT.fmt('fightReport/{0}.json',reportName)
else
filename=FMT.fmt('{0}.json',reportName)
end
local clientReport=jsonHelper.readFile(filename)
if clientReport~=nil then
return clientReport["原始战报"]
end
end


function fightController:openBattle(battleID)

if self.curBattle~=nil then
self.curBattle:hideStage(nil,true)
self.curBattle=nil
end
self.curBattle=fightModel:getBattle(battleID)
if self.curBattle~=nil and self.curBattle.isOver==false then
UIFullFightControl:showFightMain(self.curBattle)
self.curBattle:start(true,nil,nil,true)

if self.curBattle.battleType then
local handle=fightBattleHandle:getHandle(self.curBattle.battleType)
if handle and handle.onOpenPlayingBattle then
handle.onOpenPlayingBattle(battleID)
end
end
return true
end

return false
end



function fightController:isBattlePlaying(battleID)
local battle=fightModel:getBattle(battleID)
if battle~=nil then
return not battle.isOver
end
return false
end


function fightController:restartCurBattle()
if not fightController:openBattle(fightModel.info.fightKey)then
logErr('战斗已结束')
else
baseFullScreenUI:openMain(false)
end
end





local preSelect=nil
function fightController:showSelectStage(onEventChange,stateID,selectMask,onLoadFinish,resetCamera)
if preSelect then

fightController:closeSelectStage()
end
preSelect=fightPreSelect(onEventChange,selectMask)
preSelect:show(stateID,selectMask,onLoadFinish,resetCamera)
return preSelect
end

function fightController:setSelectMask(selectMask)
if preSelect~=nil then
preSelect:setSelectMask(selectMask)
end
end


function fightController:closeSelectStage()
if preSelect~=nil then
preSelect:closeSelectStage()
preSelect=nil
end
end

function fightController:recordPreSelect()
if preSelect~=nil then
preSelect:recordPreSelect()
end
end

function fightController:clearPreEntity()
if preSelect~=nil then
preSelect:clearAllEntity()
end
end


function fightController.showPrepareWin(fightType,args,afterLoading,comCloud)
args=args or{}
args.fightType=fightType
if not args.teamList and not args.isIgnoreSaveData then
local teamList=fightPreSelectModel:getTeamData(fightType)
args.teamList=teamList
end
if not comCloud then
UIFullFightPrepareControl:showPrepareWindow(args,afterLoading)
else
UIFullFightPrepareControl:showPrepareWindowEx(args,afterLoading)
end

end


function fightController.showAdverseSquadWin(fightType,args,afterLoading)
args=args or{}
args.fightType=fightType
UIFullFightPrepareControl:showAdverseSquadWindow(args,afterLoading)
end










function fightController.onTriggerBattle(battleType,result,logIdx,...)

local handle=fightBattleHandle:getHandle(battleType)
local logPackage=fightResultModel:getPackageResutl(logIdx)
local param={...}
local prizeList=logPackage.prizeList
local sendExtraArgs=fightModel:getSendExtraArgs(battleType)
if sendExtraArgs and sendExtraArgs.quickCallback then

sendExtraArgs.quickCallback(param,result,prizeList)
return
end

local onComplete=function(battleID,showWindow,stageCfg,isReconnet)
if handle then
local battle=fightModel:getBattle(battleID)
local useComplete=battle==nil or(battle and not battle.isRestart)

if useComplete and handle.onCompleteBattle then
handle.onCompleteBattle(battleID,result,logIdx,showWindow,isReconnet,unpack(param))
end

if not showWindow then
if handle.onBackStageCompleteBattle then
handle.onBackStageCompleteBattle(battleID,result,{param=param,prizeList=prizeList})
end
end

local callback=function(resultBId)
if not resultBId then
resultBId=battleID
end
if handle.onResultComplete then
handle.onResultComplete(resultBId,result,logIdx,unpack(param))
end

notifySystem:postNotify(notifyConfig.onBattleResultComplete,battleType,result,battleID)
end

fightResultController:startResult({handle.resultType,battleType,result,battleID,
logPackage,callback,param,showWindow,stageCfg})

local sendExtraArgs=fightModel:getSendExtraArgs(battleType)
if sendExtraArgs then
sendExtraArgs.isSkip=nil
end
end
end

local onClose=function(battleID)
if handle and handle.onCloseBattle then
handle.onCloseBattle(battleID,result,logIdx,unpack(param))
end
fightResultModel:clearPackageResult(logIdx)
notifySystem:postNotify(notifyConfig.onBattleClose,battleID)
end

local showStage=handle.showStage
if type(showStage)=='function'then
showStage=showStage()
end
if showStage==nil then
showStage=true
end

local hideExitWatch=false
if handle.hideExitWatch then
if type(handle.hideExitWatch)=='function'then
hideExitWatch=handle.hideExitWatch(...)
else
hideExitWatch=handle.hideExitWatch
end
end

local showSkipAll=false
if handle.showSkipAll then
if type(handle.showSkipAll)=='function'then
showSkipAll=handle.showSkipAll(...)
else
showSkipAll=handle.showSkipAll
end
end

local fightType=handle.fightType or eFightType.eSingle
if logPackage and logPackage.teamNum then
fightType=logPackage.teamNum>1 and eFightType.eMulti or eFightType.eSingle
end

local onCompleteBattleDelay
if handle then
onCompleteBattleDelay=handle.onCompleteBattleDelay
end


local battleID=fightController:startBallte(logPackage.logStr,showStage,onComplete,onClose,
{battleType=battleType,
fightType=fightType,
hideExitWatch=hideExitWatch,
showSkipAll=showSkipAll,
playmoveAni=handle.playmoveAni,
isCalcTotalStatistics=handle.isCalcTotalStatistics,
showSkipAllByleftBottom=handle.showSkipAllByleftBottom,
clearStage=handle.clearStage,
enterAni=handle.enterAni,
mustLook=handle.mustLook,
onCompleteBattleDelay=onCompleteBattleDelay,
},
sendExtraArgs)

if handle then
if handle.onStartBattle then
handle.onStartBattle(battleID,result,logIdx,...)
end
end

return battleID
end

function fightController.openReplayWin(fightType,logIdList,logStrList,extraArgs)
UIManager:showWindow("UIFightReplayWin",{fightType=fightType,logIdList=logIdList,logStrList=logStrList,extraArgs=extraArgs})
end

function fightController.startReplay(fightType,fightLogList,args)
local handle=fightRePlayHandle:getHandle(fightType)
local exchangeHp=handle and handle.exchangeHp
local onComplete=function(battleID,isShowWindow,stageCfg,isReconnet)
if handle then
if handle.onCompleteBattle then
args.isReconnet=isReconnet
handle.onCompleteBattle(battleID,args)
end
end
end

local onClose=function(battleID)
if handle and handle.onCloseBattle then
handle.onCloseBattle(battleID,args)
end
end

local showStage=handle and handle.showStage
if not showStage then
showStage=true
end
local hideExitWatch=handle and handle.hideExitWatch or false
local showSkipAll=handle and handle.showSkipAll or false
local playmoveAni=handle and handle.playmoveAni or false
local isCalcTotalStatistics=handle and handle.isCalcTotalStatistics or false
local showSkipAllByleftBottom=handle and handle.showSkipAllByleftBottom or 0
local battleType=handle.battleType
local useReportMapId=args.useReportMapId or handle.useReportMapId
local sendExtraArgs=fightModel:getSendExtraArgs(handle.battleType)
local mustLook=handle and handle.mustLook
local battleID=fightController:startBallte(fightLogList,showStage,onComplete,onClose,{hideExitWatch=hideExitWatch,showSkipAll=showSkipAll,showSkipAllByleftBottom=showSkipAllByleftBottom,isCalcTotalStatistics=isCalcTotalStatistics,playmoveAni=playmoveAni,isRePlay=true,exchangeHp=exchangeHp,battleType=battleType,useReportMapId=useReportMapId,mustLook=mustLook},sendExtraArgs)

if handle and handle.onStartBattle then
handle.onStartBattle(battleID,args)
end
end


function fightController:testFunc_setLingShouShow(isShow)
local battle=self.curBattle
local entitise
if battle then
entitise=battle:getEntities()
else

if preSelect then
entitise=preSelect.entitityPool
end
end

if entitise and next(entitise)~=nil then
local alpha=isShow and 1 or 0
local color=Color.New(1,1,1,alpha)
for i,ent in pairs(entitise)do
if ent.isAssistant then
ent:fadeToColor(color,0,nil)
end
end
end
end
