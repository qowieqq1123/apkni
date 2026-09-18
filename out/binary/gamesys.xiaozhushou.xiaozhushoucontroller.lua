







local _MODULENAME="xiaoZhuShouController"
gameState.addListener(def_table(_MODULENAME))
xiaoZhuShouController.name=_MODULENAME
local _detailQueue={}
local _executeDetail={}
local _executeSec=0
local _executeMaxSec=60

function xiaoZhuShouController:onAppStart()

end

function xiaoZhuShouController:onEnterState(isReconnet)
xiaoZhuShouModel:onEnterState(isReconnet)
if not isReconnet then
notifySystem:listenNotify(notifyConfig.onZongMengLevelChange,self.on_zmlevel_change)
notifySystem:listenNotify(notifyConfig.building_event,self.on_building_event)
notifySystem:listenNotify(notifyConfig.onXianMengChange,self.onXianMengChange)
notifySystem:listenNotify(notifyConfig.onNewDay,self.onNewDay)
notifySystem:listenNotify(notifyConfig.onGuildOrderChange,self.onGuildOrderChange)
notifySystem:listenNotify(notifyConfig.onOpenWXSD,self.onOpenWXSD)
notifySystem:listenNotify(notifyConfig.on_system_open,self.onSystemOpen)

notifySystem:listenNotify(notifyConfig.onShowPrize,self.showPrize)
notifySystem:listenNotify(notifyConfig.onMonthInvestorExpire,self.onMonthInvestorExpire)
notifySystem:listenNotify(notifyConfig.onJiuYouPrizeChange,self.onJiuYouPrizeChange)
end
_detailQueue={}
_executeDetail={}
_executeSec=0
self.stopFlag=false
xiaoZhuShouController:setIdleState(true)
end

function xiaoZhuShouController:onLeaveState(isReconnet)
if not isReconnet then
notifySystem:removelistener(notifyConfig.onZongMengLevelChange,self.on_zmlevel_change)
notifySystem:removelistener(notifyConfig.building_event,self.on_building_event)
notifySystem:removelistener(notifyConfig.onXianMengChange,self.onXianMengChange)
notifySystem:removelistener(notifyConfig.onNewDay,self.onNewDay)
notifySystem:removelistener(notifyConfig.onGuildOrderChange,self.onGuildOrderChange)
notifySystem:removelistener(notifyConfig.onOpenWXSD,self.onOpenWXSD)
notifySystem:removelistener(notifyConfig.on_system_open,self.onSystemOpen)

notifySystem:removelistener(notifyConfig.onShowPrize,self.showPrize)
notifySystem:removelistener(notifyConfig.onMonthInvestorExpire,self.onMonthInvestorExpire)
notifySystem:removelistener(notifyConfig.onJiuYouPrizeChange,self.onJiuYouPrizeChange)
end
timeEventController.removeQuickTimerHandler('xiaoZhuShouController')
self:clearPrizeList()
end

function xiaoZhuShouController:onPlayerCreate(...)
end

function xiaoZhuShouController:onProtocolReqKF(isReconnect)
xiaoZhuShouModel:initXiaoZhuShouActiveData()
timeEventController.addQuickTimerHandler('xiaoZhuShouController',self)
xiaoZhuShouModel:fixSetupData20250904()
end

function xiaoZhuShouController.on_zmlevel_change()
xiaoZhuShouModel:refreshXiaoZhuShouActiveData()
end

function xiaoZhuShouController.on_building_event(etype,sfId,ubdId)
if etype==buildingEvent.buildComplete then
xiaoZhuShouModel:refreshXiaoZhuShouActiveData()
end
end

function xiaoZhuShouController.onXianMengChange()
xiaoZhuShouModel:refreshXiaoZhuShouActiveData()
end

function xiaoZhuShouController.onNewDay()
xiaoZhuShouModel:refreshXiaoZhuShouActiveData()
xiaoZhuShouModel:clearReportData()
end

function xiaoZhuShouController.onGuildOrderChange()
xiaoZhuShouModel:refreshXiaoZhuShouActiveData()
end

function xiaoZhuShouController.onOpenWXSD()
xiaoZhuShouModel:refreshXiaoZhuShouActiveData()
end

function xiaoZhuShouController.onSystemOpen(sysid)
xiaoZhuShouModel:refreshXiaoZhuShouActiveData()
end


local xiaoZhuShouDetailPrizeHandleFunc={
[ePrizeType.eXZS_HouShanZhenLing]=function(prizeType,rewards_,effectData)
xiaoZhuShouDetailFunc.hs_autoCleanupZhenLingShowPrize(prizeType,rewards_,effectData)
end,
}






local xiaoZhuShouDetailCommonPrizeHandleFunc={



[XIAOZHUSHU_ENUM.xzs_MaoHuoLang]=function(prizeType,rewards_,effectData)
xiaoZhuShouDetailFunc.autoReceiveCatShopShowPrize(prizeType,rewards_,effectData)
end,






[XIAOZHUSHU_ENUM.xzs_XuanShangTai]=function(prizeType,rewards_,effectData)
xiaoZhuShouDetailFunc.autoReceiveXuanShangTaiRewardShowPrize(prizeType,rewards_,effectData)
end,
[XIAOZHUSHU_ENUM.xzs_ShangShi]=function(prizeType,rewards_,effectData)
xiaoZhuShouDetailFunc.autoReceiveShangShiRewardShowPrize(prizeType,rewards_,effectData)
end,



[XIAOZHUSHU_ENUM.xzs_YiYuHuiYou]=function(prizeType,rewards_,effectData)
xiaoZhuShouDetailFunc.autoReceiveYYHYShowPrize(prizeType,rewards_,effectData)
end,
[XIAOZHUSHU_ENUM.xzs_HouShan]=function(prizeType,rewards_,effectData)
xiaoZhuShouDetailFunc.hs_autoReceiveDailyChallengeShowPrize(prizeType,rewards_,effectData)
end,
[XIAOZHUSHU_ENUM.xzs_WuDaoTang]=function(prizeType,rewards_,effectData)
xiaoZhuShouDetailFunc.autoReceiveWDTShowPrize(prizeType,rewards_,effectData)
end,
[XIAOZHUSHU_ENUM.xzs_XianWuLou]=function(prizeType,rewards_,effectData)
xiaoZhuShouDetailFunc.autoReceiveXianWuLouShowPrize(prizeType,rewards_,effectData)
end,
[XIAOZHUSHU_ENUM.xzs_TYSC]=function(prizeType,rewards_,effectData)
xiaoZhuShouDetailFunc.autoReceiveTYSCShowPrize(prizeType,rewards_,effectData)
end,
[XIAOZHUSHU_ENUM.xzs_TYCY]=function(prizeType,rewards_,effectData)
xiaoZhuShouDetailFunc.autoReceiveTYCYShowPrize(prizeType,rewards_,effectData)
end,
[XIAOZHUSHU_ENUM.xzs_TWXM]=function(prizeType,rewards_,effectData)
xiaoZhuShouDetailFunc.autoReceiveTWXMShowPrize(prizeType,rewards_,effectData)
end,
}

function xiaoZhuShouController.showPrize(prizeType,rewards_,effectData)
if prizeType==ePrizeType.eXZS_Common then
local subType=effectData.sub_effecttype
if xiaoZhuShouDetailCommonPrizeHandleFunc[subType]then
xiaoZhuShouDetailCommonPrizeHandleFunc[subType](prizeType,rewards_,effectData)
end
if not effectData or effectData.notRealRewards~=true then
xiaoZhuShouController:inserPrizeList(rewards_)
end
elseif xiaoZhuShouDetailPrizeHandleFunc[prizeType]then
xiaoZhuShouDetailPrizeHandleFunc[prizeType](prizeType,rewards_,effectData)
if not effectData or effectData.notRealRewards~=true then
xiaoZhuShouController:inserPrizeList(rewards_)
end
end
end

function xiaoZhuShouController:startAllOrder()
if not self:checkXiaoZhuShouOpen(true)then
return
end
if xiaoZhuShouController:checkRunning()then
logErr("小助手执行中状态")
return
end
xiaoZhuShouModel:clearDetailData()
xiaoZhuShouModel:clearReportData()
self.stopFlag=false

local orderList=xiaoZhuShouModel:getXiaoZhuShouActiveData()
local hasOne=false
for i=#orderList,1,-1 do
local orderData=orderList[i]
local orderID=orderData.id
if xiaoZhuShouModel:checkSetupUnlock(orderID)then
local setupCfg=xiaoZhuShouModel:getSetupConfig(orderID)or{}
local executeCfg=setupCfg.execute
if executeCfg and#executeCfg>0 then
for idx=#executeCfg,1,-1 do
local v=executeCfg[idx]
if v.check(orderID)and v.func then
hasOne=true
local detail={
orderID=orderID,
executeIdx=idx,
func=v.func,
}
table.insert(_detailQueue,detail)
end
end
end
end
end
if not hasOne then
UIManager.info("当前没有可开始的选项")
else
UIManager:invokeUIMethod("UIXiaoZhuShouWin","showDetailPanel")
dialogueRepeatRemindModel.setRepeatVis(REPEAT_TIME_TYPE.eDay,REPEAT_TYPE.eXZSTips,true)
end
end

xzs_state_enum={
idle=0,
busy=1,
}

function xiaoZhuShouController:setBusyState()
self.xzs_state=xzs_state_enum.busy
end

function xiaoZhuShouController:setIdleState(isInit)
_executeSec=0
if not isInit and#_detailQueue<=0 and self:checkBusyState()then
self.xzs_state=xzs_state_enum.idle
if not self.stopFlag then
UIManager.info("已完成宗门执事")





notifySystem:postNotify(notifyConfig.onXiaoZhuShouFinish)
else
notifySystem:postNotify(notifyConfig.onXiaoZhuShouStop)
end
xiaoZhuShouOrderFunc.showXzsShouYiZonglan()
if xiaoZhuShouModel:checkReportReddot()then
xiaoZhuShouController:openReportWin()
end
UIManager:invokeUIMethod("UIXiaoZhuShouWin","refreshPauseBtn",false)
UIManager:invokeUIMethod("UIXiaoZhuShouWin","refreshReportReddot")
end
self.xzs_state=xzs_state_enum.idle
end

function xiaoZhuShouController:checkBusyState()
return self.xzs_state==xzs_state_enum.busy
end

function xiaoZhuShouController:checkIdleState()
return self.xzs_state==xzs_state_enum.idle
end

function xiaoZhuShouController:onQuickUpdate(delta)
if#_detailQueue>0 and self:checkIdleState()then
_executeSec=0
self:setBusyState()
local detail=_detailQueue[#_detailQueue]
table.remove(_detailQueue)
local executeFunc=detail.func
_executeDetail=detail
executeFunc(detail.orderID)
elseif self:checkBusyState()then
_executeSec=_executeSec+delta
if _executeSec>=_executeMaxSec then
local cfg=cfgHelper.get1(cfg_xiaozhushouconfig_get,_executeDetail.orderID)
loggerUtil.logErrFMT("小助手执行超时 名字：{0} 第{1}个执行方法 orderID:{2} ",cfg.name,_executeDetail.executeIdx,_executeDetail.orderID)
self:setIdleState()
end
end
end

function xiaoZhuShouController:checkRunning()
return self.xzs_state==xzs_state_enum.busy or#_detailQueue>0
end

function xiaoZhuShouController:stopRunning()
_detailQueue={}
self.stopFlag=true
if self:checkIdleState()then
xiaoZhuShouOrderFunc.showXzsShouYiZonglan()
if xiaoZhuShouModel:checkReportReddot()then
xiaoZhuShouController:openReportWin()
end
UIManager:invokeUIMethod("UIXiaoZhuShouWin","refreshPauseBtn",false)
UIManager:invokeUIMethod("UIXiaoZhuShouWin","refreshReportReddot")
notifySystem:postNotify(notifyConfig.onXiaoZhuShouStop)
end
end


function xiaoZhuShouController.onMonthInvestorExpire()
_detailQueue={}
xiaoZhuShouController:setIdleState()
end

function xiaoZhuShouController:checkXiaoZhuShouVisiable(showTips)
local baseCfg=cfgHelper.get1(cfg_xiaozhushoubaseconfig_get,1)
local gameVersion=pfwindowslController:getGameVersion()
local zmLevel=baseCfg.zmLv[gameVersion]or baseCfg.zmLv[1]
if zongmenModel:getLevel()<zmLevel then
if showTips then
UIManager.info("宗门等级不足")
end
return false
end
return true
end

function xiaoZhuShouController:checkXiaoZhuShouOpen(showTips)
if not xiaoZhuShouController:checkXiaoZhuShouVisiable(showTips)then
return false
end
local baseCfg=cfgHelper.get1(cfg_xiaozhushoubaseconfig_get,1)
local yuekaId=baseCfg.yueka
if not rechargeModel:checkCardActive(yuekaId)then
if showTips then
local cardName=cfgHelper.get2(cfg_yuekaconfig_get,yuekaId,"name")
UIManager.error(string.format("未开通%s",cardName))
end
return false
end
return true
end

function xiaoZhuShouController:openReportWin()
if xiaoZhuShouModel:checkReportReddot()then
UIManager:showWindow("UIXiaoZhuShouReportWin")
end
end


function xiaoZhuShouController:jumpReportWindow(jumpParams)
UIManager:hideWindow("UIXiaoZhuShouWin")
UIManager:closeWindow("UIXiaoZhuShouReportWin")
local func=function()
UIManager:showWindow("UIXiaoZhuShouWin")

xiaoZhuShouController:openReportWin()
return false
end
local cbfunc=function()
fullScreenUI.setNextActiveUICallback(func)
end

jumpManager:jump(jumpParams,cbfunc,JUMP_BACK.eNoBack)
cbfunc()
end


function xiaoZhuShouController.onJiuYouPrizeChange(len,temp)
if len>0 then
local rewards={}
for i,v in ipairs(temp)do
table.insert(rewards,{itemid=v.param_1,num=v.param_2})
end
xiaoZhuShouController:inserPrizeList(rewards)
end
end

function xiaoZhuShouController:inserPrizeList(rewards)
if not self.prizeList then
self.prizeList={}
self.prizeLookup={}
end

for i,v in ipairs(rewards)do
showPrizeControl.insertCommon(self.prizeList,self.prizeLookup,v.itemguid,v.itemid,v.num,true)
end
end

function xiaoZhuShouController:clearPrizeList()
self.prizeList=nil
self.prizeLookup=nil
end

function xiaoZhuShouController:getPrizeList()
return self.prizeList
end
