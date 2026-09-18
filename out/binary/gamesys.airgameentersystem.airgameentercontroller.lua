






local _MODULENAME="airGameEnterController"

gameState.addListener(def_table(_MODULENAME))
airGameEnterController.name=_MODULENAME
airGameEnterController.data={}

function airGameEnterController:onAppStart()

airGameEnterModel:onAppStart()

socketManager:register_receiver(36,7,self.recv_36_7)
socketManager:register_receiver(36,8,self.recv_36_8)
socketManager:register_receiver(36,9,self.recv_36_9)
socketManager:register_receiver(36,10,self.recv_36_10)
socketManager:register_receiver(36,11,self.recv_36_11)
socketManager:register_receiver(36,14,self.recv_36_14)

socketManager:register_receiver(36,15,self.recv_36_15)
socketManager:register_receiver(36,16,self.recv_36_16)


notifySystem:listenNotify(notifyConfig.onNewDay,self.onNewDay)
end


function airGameEnterController:onEnterState(isReconnect)
airGameEnterModel:onEnterState()
end


function airGameEnterController:onProtocolReq()
airGameEnterModel:onProtocolReq()
self:checkTXZOpen()
end


function airGameEnterController:onLeaveState(isReconnect)
airGameEnterModel:onLeaveState(isReconnect)

self.data={}

notifySystem:removelistener(notifyConfig.onNewDay,self.onNewDay)
end


function airGameEnterController:onLostConnection()

end


function airGameEnterController:onReConnection(isInitPro)

end




function airGameEnterController:reqActiveXianBao(xbid)
socketManager:send_36_7(xbid)
end

function airGameEnterController:reqAddLevleXianBao(xbid)
socketManager:send_36_8(xbid)
end

function airGameEnterController:reqReceiveChengJiuReward(len,chieveIdList)
socketManager:send_36_9(len,chieveIdList)
end

function airGameEnterController:reqReceiveChengJiuReward(len,chieveIdList)
socketManager:send_36_9(len,chieveIdList)
end

function airGameEnterController:reqBuyCount()
socketManager:send_36_14()
end

function airGameEnterController:reqResetBwLv(bwid)
socketManager:send_36_16(bwid)
end


function airGameEnterController.recv_36_7(xbid)
airGameEnterModel:activeXianBao(xbid)

notifySystem:postNotify(notifyConfig.onAirBaoWuUpdate,xbid,1)

airGameEnterController:refreshBuildHud()
end

function airGameEnterController.recv_36_8(xbid,xbLevel)
airGameEnterModel:levelUpXianBao(xbid,xbLevel)

notifySystem:postNotify(notifyConfig.onAirBaoWuUpdate,xbid,2)

airGameEnterController:refreshBuildHud()
end

function airGameEnterController.recv_36_9(len,chieveIdList)
airGameEnterModel:updateFinishChengJiuData(len,chieveIdList)

UIManager.info("领取成功")


UIManager:invokeUIMethod("UIAirGameChenJiuWin","refreshAll")

notifySystem:postNotify(notifyConfig.onAirChenJiuUpdate)

airGameEnterController:refreshBuildHud()
end


function airGameEnterController.recv_36_10(len,achieveDataList)
airGameEnterModel:updateStateChengJiuData(len,achieveDataList)


UIManager:invokeUIMethod("UIAirGameChenJiuWin","refreshAll")

notifySystem:postNotify(notifyConfig.onAirChenJiuUpdate)

airGameEnterController:refreshBuildHud()
end

function airGameEnterController.recv_36_11(len,airAchieveList)
airGameEnterModel:updateFirstReachChengJiuData(len,airAchieveList)


UIManager:invokeUIMethod("UIAirGameChenJiuWin","refreshAll")

notifySystem:postNotify(notifyConfig.onAirChenJiuUpdate)

airGameEnterController:refreshBuildHud()
end

function airGameEnterController.recv_36_14(times)
airGameEnterModel:setBuyCount(times)

UIManager.info("购买成功")

UIManager:invokeUIMethod("UIAirGamePrepareWin","refreshCountAndCost")


local buyCallBack=airGameEnterController:getBuyCountCallBack()
if buyCallBack then
buyCallBack()

airGameEnterController:setBuyCountCallBack(nil)
end
end

function airGameEnterController.recv_36_15(open_sec)
airGameEnterModel:setOpenSec(open_sec)
end

function airGameEnterController.recv_36_16(bwid,level)
airGameEnterModel:resetXianBaoLevel(bwid,level)

notifySystem:postNotify(notifyConfig.onAirBaoWuUpdate,bwid,2)
end

function airGameEnterController:refreshBuildHud()
local bdDatas=zongmenModel:getBuildingDataByBdType(mapIdType.zhufeng,SLG_SYSTEM_TYPE.eChuanSongZhen)
if bdDatas and bdDatas[1]then
hudControl:refreshBuildingStatusHUD(bdDatas[1].un_build_id)
end
end


function airGameEnterController.onNewDay()
airGameEnterModel:resetUsedTimes()
end




function airGameEnterController:showDiscipleSelectWin(argstable)
local disciple=airGameEnterModel:getSelectDisciple()

local args={
openType=dzSelectWinOpenType.eAirGameEnter,
selectdzguid=disciple,
dzFilterTypeList={{2}},
dzShowTypeList={{2}},
sortPlanId=2,
canvasIdx=5,
isNotShowSearchBox=true,
isShowFireBtn=false,

workCallBack=function(data)
airGameEnterModel:setSelectDisciple(data.discipleguid)
end,
fireCallBack=function()
airGameEnterModel:setSelectDisciple(nil)
end
}
UIFullAirGameEnterController:showWindow('UIMDiscipleSelect_AirGameWin',args)
end


function airGameEnterController:enterGame(group,level,dzGuid)
local enterFunc=function()
local mountItemGuid=airGameEnterModel:getMount()
local mountDressDzGuid=Int64_0
if mountItemGuid~=nil then
local dressDzGuid=mountModel:getDzguidByItemguid(mountItemGuid)
if dressDzGuid then
mountDressDzGuid=dressDzGuid
end
else
mountItemGuid=Int64_0
end
local fbid=cfgHelper.get3(cfg_airgamepushmaplevelconfig_get,group,level,'fbid')
if fbid~=nil then
airController:reqSendPrepareGameInfo(dzGuid,mountDressDzGuid,mountItemGuid)
airController:reqEnterFb(fbid)
else
logErr(FMT.fmt("缺少推图fbid,参数：group,level",group,level))
end
end

if dzGuid~=nil then
if airGameEnterModel:checkLevelCondition(group,level)then
if airGameEnterModel:checkNeedCostStart(level)then
if airGameEnterModel:checkCostEnoughStartGame(true)then
enterFunc()
end
else
enterFunc()
end
else
local info=airGameEnterConfig.checkOpenConditionDescEx(group,level)
UIManager.error(info)
end
else
UIManager.error("请先选择弟子")
end
end

function airGameEnterController:checkShowBuyCountDialouge(cb,level,isShowGain)
if airGameEnterModel:checkNeedCostStart(level)then
if airGameEnterModel:checkCostEnoughStartGame(isShowGain)then
airGameEnterController:showCostDialougeWin(cb)
else
local cost=airGameEnterConfig.getFbConstConfig('challenge_consume')
local itemId=cost[1]
UIManager.error(FMT.fmt("{0}不足",itemsConfig.getItemName(itemId)))
end
else
cb()
end
end

function airGameEnterController:showCostDialougeWin(cb)
local okFunc=function()



if airGameEnterModel:checkCostEnoughStartGame(true)then

airGameEnterController:setBuyCountCallBack(cb)


airGameEnterController:reqBuyCount()
end
end

local cost=airGameEnterConfig.getFbConstConfig('challenge_consume')
local itemId=cost[1]
local have=itemsModel.getCount(itemId)
local need=cost[2]

local colorStr=have>=need and"549327"or"FF0000"
local iconStr=iconHelper.getIconName(itemId)
local costStr=FMT.fmt("<color=#{0}>{1}</color>quad-icon={2}-quad",colorStr,need,iconStr)
local contentStr=FMT.fmt("今日挑战次数不足，花费{0}，可购买1次",costStr)
local showdata=
{
type='UIDialougeWithIcon',
title='提示',
content=contentStr,
oktext='确定',
canceltext='取消',

okcallback=function(...)
if not moneyModel.checkEnoughMoney(itemId,need)then
local str=FMT.fmt('{0}不足',moneyModel.getMoneyName(itemId))
UIManager.error(str)
gainControl:showGainWin(itemId)
return
end
okFunc()
end,
showclosebtn=true,
}
local comfirmDialog=UIDialogManager.newDialog(showdata)
comfirmDialog:show()
end

function airGameEnterController:setBuyCountCallBack(okFunc)
self.data.buyCountCallBack=okFunc
end

function airGameEnterController:getBuyCountCallBack()
return self.data.buyCountCallBack
end

function airGameEnterController:checkTXZOpen()
local configs=cfg_airgamepushmapgroupconfig()
local group=airGameEnterModel:getGroup()
local level=airGameEnterModel:getLevel()
local list={}
for id,cfg in ipairs(configs)do
local guid=UITYTongXingZhengModel:getGuidBySysID(txzType.sys,SYSTEM_DEFINE.eAirGame,id,false)
if not guid then
local open=cfg.passport_condition==nil or group>cfg.passport_condition[1]or(group==cfg.passport_condition[1]and level>=cfg.passport_condition[2])
if open then
table.insert(list,{SYSTEM_DEFINE.eAirGame,id})
end
end
end
local count=#list
if count>0 then
socketManager:send_29_16(count,list)
end
end

