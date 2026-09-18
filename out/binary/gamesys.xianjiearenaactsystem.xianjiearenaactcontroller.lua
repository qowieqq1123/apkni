






local _MODULENAME="xianJieArenaActController"

gameState.addListener(def_table(_MODULENAME))
xianJieArenaActController.name=_MODULENAME
xianJieArenaActController.data={}

function xianJieArenaActController:onAppStart()

xianJieArenaActModel:onAppStart()



socketManager:register_receiver(35,79,xianJieArenaActController.recv_35_79)
socketManager:register_receiver(35,80,xianJieArenaActController.recv_35_80)
socketManager:register_receiver(35,81,xianJieArenaActController.recv_35_81)
socketManager:register_receiver(35,82,xianJieArenaActController.recv_35_82)
socketManager:register_receiver(35,83,xianJieArenaActController.recv_35_83)
socketManager:register_receiver(35,84,xianJieArenaActController.recv_35_84)
socketManager:register_receiver(35,85,xianJieArenaActController.recv_35_85)
socketManager:register_receiver(35,86,xianJieArenaActController.recv_35_86)
socketManager:register_receiver(35,87,xianJieArenaActController.recv_35_87)
socketManager:register_receiver(35,88,xianJieArenaActController.recv_35_88)
socketManager:register_receiver(35,89,xianJieArenaActController.recv_35_89)
socketManager:register_receiver(35,98,xianJieArenaActController.recv_35_98)
socketManager:register_receiver(35,99,xianJieArenaActController.recv_35_99)





notifySystem:listenNotify(notifyConfig.enterXianJie,self.onEnterXianJie)
notifySystem:listenNotify(notifyConfig.leaveXianJie,self.onLeaveXianJie)
end


function xianJieArenaActController:onEnterState(isReconnect)
xianJieArenaActModel:onEnterState()

notifySystem:listenNotify(notifyConfig.onLimitActStateChange,self.onLimitActStateChange)
notifySystem:listenNotify(notifyConfig.onLimitActOpen,self.onLimitActOpen)
notifySystem:listenNotify(notifyConfig.onShowPrize,self.showPrize)
notifySystem:listenNotify(notifyConfig.onXianJieDataFreshInit,self.onXianJieDataFreshInit)
end


function xianJieArenaActController:onProtocolReq()
xianJieArenaActModel:onProtocolReq()
end


function xianJieArenaActController:onLeaveState(isReconnect)
self:clearDelayTimer()
xianJieArenaActModel:onLeaveState(isReconnect)


self.data={}

notifySystem:removelistener(notifyConfig.onLimitActStateChange,self.onLimitActStateChange)
notifySystem:removelistener(notifyConfig.onLimitActOpen,self.onLimitActOpen)
notifySystem:removelistener(notifyConfig.onShowPrize,self.showPrize)
notifySystem:removelistener(notifyConfig.onXianJieDataFreshInit,self.onXianJieDataFreshInit)
end


function xianJieArenaActController:onLostConnection()

end


function xianJieArenaActController:onReConnection(isInitPro)

end



function xianJieArenaActController:reqGetXJArenaZhuJunDzList(massActorid,massGuid,arenaId,sendArgs)
if sendArgs then
xianJieArenaActController.send_35_79_sendArgs=sendArgs
else
xianJieArenaActController.send_35_79_sendArgs=nil
end
socketManager:send_35_79(massActorid,massGuid,arenaId)
end


function xianJieArenaActController:reqGetXJArenaActData(sendArgs)
if sendArgs then
xianJieArenaActController.send_35_80_sendArgs=sendArgs
else
xianJieArenaActController.send_35_80_sendArgs=nil
end
socketManager:send_35_80()
end


function xianJieArenaActController:reqGetXJArenaZhuJunRetract(arenaId,guid)
socketManager:send_35_81(arenaId,guid)
end


function xianJieArenaActController:reqGetXJArenaActData_arenaInfo(arenaId)
socketManager:send_35_82(arenaId)
end


function xianJieArenaActController:reqGetXJArenaRankList(rankType)
if rankType==LTYW_Rank_Type.ePersonRank then
socketManager:send_35_83()
elseif rankType==LTYW_Rank_Type.eXianMengRank then
socketManager:send_35_85()
elseif rankType==LTYW_Rank_Type.eZhanYunRank then
socketManager:send_35_84()
end
end


function xianJieArenaActController:reqGetXJArenaActOccupyReward()
socketManager:send_35_86()
end


function xianJieArenaActController:reqGetXJArenaSetRewardWinShowFlag(flag)
socketManager:send_35_88(flag)
end


function xianJieArenaActController:reqGetXJArenaAllTeamList()
socketManager:send_35_89()
end


function xianJieArenaActController:reqGetXJArenaCompensation()
socketManager:send_35_98()
end


function xianJieArenaActController.recv_35_79(massActorid,massGuid,len,dzList,arenaId)
xianJieArenaActModel:setArenaZhuJunDzList(massActorid,massGuid,len,dzList,arenaId)
if xianJieArenaActController.send_35_79_sendArgs then
if xianJieArenaActController.send_35_79_sendArgs.callback then
xianJieArenaActController.send_35_79_sendArgs.callback(massActorid,massGuid,len,dzList)
end
xianJieArenaActController.send_35_79_sendArgs=nil
end
end


function xianJieArenaActController.recv_35_80(len,list,jsrwFlag,dlgFlag)
xianJieArenaActModel:setArenaBuildList(len,list)
xianJieArenaActModel:setArenaRewardGotFlag(jsrwFlag)
xianJieArenaActModel:setArenaRewardWinShowFlag(dlgFlag)
xianJieArenaActController:checkCreateArenaBuild()

UIManager:invokeUIMethod("UIXianJieArenaAct_arenaOccupyWin","refresh",true)

UIManager:invokeUIMethod("UIXianJieFuncStorageWin","refreshLTYWReward")

UIManager:invokeUIMethod("UIXianJieArenaAct_rankBgWin","refreshAllMenuReddot")

xianJieArenaActController:resetAllArenaHud()


local isInSettlement,delaySettleTime=xianJieArenaActController:checkActIsInSettlement()
if isInSettlement and delaySettleTime>0 then

xianJieArenaActController:reqXJArenaUpdateDataDelay(delaySettleTime)
end

if xianJieArenaActController.send_35_80_sendArgs then
if xianJieArenaActController.send_35_80_sendArgs.callback then
xianJieArenaActController.send_35_80_sendArgs.callback(list)
end
xianJieArenaActController.send_35_80_sendArgs=nil
end

end


function xianJieArenaActController.recv_35_81(arenaId,guid)
UIManager.info("撤离驻军成功")
end


function xianJieArenaActController.recv_35_82(arenaId,logLen,logList,zjLen,zjList)
xianJieArenaActModel:setArenaLogList(arenaId,logLen,logList)
xianJieArenaActModel:setArenaZhuJunList(arenaId,zjLen,zjList)


UIManager:invokeUIMethod("UIXianJieArenaAct_infoWin","refresh",true)
end


function xianJieArenaActController.recv_35_83(len,list,myZhanJi)
xianJieArenaActModel:setArenaRankList(LTYW_Rank_Type.ePersonRank,len,list)
xianJieArenaActModel:setArenaSelfRankValue(LTYW_Rank_Type.ePersonRank,myZhanJi)


UIManager:invokeUIMethod("UIXianJieArenaAct_rankPersonWin","refresh",true)
end


function xianJieArenaActController.recv_35_84(len,list,myZhanSun)
xianJieArenaActModel:setArenaRankList(LTYW_Rank_Type.eZhanYunRank,len,list)
xianJieArenaActModel:setArenaSelfRankValue(LTYW_Rank_Type.eZhanYunRank,myZhanSun)


UIManager:invokeUIMethod("UIXianJieArenaAct_rankZhanYunWin","refresh",true)
end


function xianJieArenaActController.recv_35_85(len,list,myGuildZhanJi)
xianJieArenaActModel:setArenaRankList(LTYW_Rank_Type.eXianMengRank,len,list)
xianJieArenaActModel:setArenaSelfRankValue(LTYW_Rank_Type.eXianMengRank,myGuildZhanJi)


UIManager:invokeUIMethod("UIXianJieArenaAct_rankXMWin","refresh",true)
end


function xianJieArenaActController.recv_35_86(jsrwFlag)
xianJieArenaActModel:setArenaRewardGotFlag(jsrwFlag)

UIManager:invokeUIMethod("UIXianJieArenaAct_arenaOccupyWin","refresh")

UIManager:invokeUIMethod("UIXianJieFuncStorageWin","refreshLTYWReward")

UIManager:invokeUIMethod("UIXianJieArenaAct_rankBgWin","refreshAllMenuReddot")
end


function xianJieArenaActController.recv_35_87(data)
local arenaId=data.buildId
xianJieArenaActModel:setArenaBuildDataByArenaId(arenaId,data)

UIManager:invokeUIMethod("UIXianJieArenaAct_infoWin","refresh",true)

UIManager:invokeUIMethod("UIXianJieArenaAct_ovArenaWin","refresh",nil,true)

xianJieArenaActController:resetArenaHudById(arenaId)
end


function xianJieArenaActController.recv_35_88(jsrwFlag,dlgFlag,hasCompensationFlag,gotCompensationFlag,mojunDieTime)
xianJieArenaActModel:setArenaRewardGotFlag(jsrwFlag)
xianJieArenaActModel:setArenaRewardWinShowFlag(dlgFlag)
xianJieArenaActModel:setArenaHasCompensationFlag(hasCompensationFlag)
xianJieArenaActModel:setArenaGotCompensationFlag(gotCompensationFlag)













UIManager:invokeUIMethod("UIXianJieFuncStorageWin","refreshLTYWReward")

UIManager:invokeUIMethod("UIXianJieArenaAct_rankBgWin","refreshAllMenuReddot")

UIManager:invokeUIMethod('UIFuncStorageWin','refreshArenaCompensationBtn')
UIManager:invokeUIMethod('UIXianJieFuncStorageWin','refreshLTYWCompensation')
end


function xianJieArenaActController.recv_35_89(len,list)
xianJieArenaActModel:setAllArenaMassDataList(len,list)

UIManager:invokeUIMethod("UIXianJieArenaAct_ovTeamWin","refresh")
end


function xianJieArenaActController.recv_35_98(getFlag)
xianJieArenaActModel:setArenaGotCompensationFlag(getFlag)


UIManager:invokeUIMethod('UIFuncStorageWin','refreshArenaCompensationBtn')
UIManager:invokeUIMethod('UIXianJieFuncStorageWin','refreshLTYWCompensation')
end


function xianJieArenaActController.recv_35_99()
xianJieArenaActModel:setArenaHasCompensationFlag(1)
xianJieArenaActModel:setArenaGotCompensationFlag(0)


UIManager:invokeUIMethod('UIFuncStorageWin','refreshArenaCompensationBtn')
UIManager:invokeUIMethod('UIXianJieFuncStorageWin','refreshLTYWCompensation')
end



function xianJieArenaActController.onEnterXianJie(sceneType)

local isOpenedAct=xianJieArenaActModel:checkIsXJArenaActOpened()
local isOpen=xianJieArenaActModel:checkIsXJArenaActCanOpen()
if isOpenedAct and isOpen then

xianJieArenaActController:createArenaBuild(true)
end
end

function xianJieArenaActController.onLeaveXianJie(sceneType)
if sceneType==xianjienSceneType.eXianJie then


end
end

function xianJieArenaActController.onLimitActStateChange(actID,actState)
local flag=actID==LIMIT_ACT_TYPE.eLeiTaiYanWu
if not flag then
return
end

if actState==limitActivitiesModel.actDoingState or actState==limitActivitiesModel.actFinishState then
if actState==limitActivitiesModel.actDoingState then


xianJieArenaActModel:setArenaRewardGotFlag(0)
xianJieArenaActModel:setArenaRewardWinShowFlag(0)
xianJieArenaActModel:resetAllArenaOccupyData()


xianJieArenaActModel:setArenaHasCompensationFlag(0)


UIManager:invokeUIMethod('UIFuncStorageWin','refreshArenaCompensationBtn')
UIManager:invokeUIMethod('UIXianJieFuncStorageWin','refreshLTYWCompensation')

xianJieArenaActController:checkCreateArenaBuild(nil,true)
end

xianJieArenaActController:resetAllArenaHud()
end
end

function xianJieArenaActController.onLimitActOpen(actID,flag)
local actFlag=actID==LIMIT_ACT_TYPE.eLeiTaiYanWu
if actFlag and flag then
xianJieArenaActController:checkCreateArenaBuild(true)
end
end

function xianJieArenaActController.showPrize(prizeType,rewards_,effectData)
if prizeType==ePrizeType.eLTYW_OccupyReward then

local arenaCount=effectData.len
if arenaCount>0 then
local tempLookup={}
local occupyRewardBuffShowList_cfg=cfgHelper.get(cfg_leitaiyanwubaseconfig_get,1,"occupyRewardBuffShow")or{}
local occupyRewardBuffShowList=pfwindowsModel:getVersionAndPfCfg_severPf(occupyRewardBuffShowList_cfg)
local buffItemList=occupyRewardBuffShowList[arenaCount]
if buffItemList and next(buffItemList)then
for _,itemId in ipairs(buffItemList)do
showPrizeControl.insertCommon(rewards_,tempLookup,nil,itemId,1,false)
end
end
showPrizeControl.showWindow(rewards_,nil)
end
end
end

function xianJieArenaActController.onXianJieDataFreshInit()

xianJieArenaActController:checkReqArenaDataByIgnoreMJ()
end

function xianJieArenaActController:checkCreateArenaBuild(isInit,isIgnoreCheckOpened)

local isOpenedAct=xianJieArenaActModel:checkIsXJArenaActOpened()
local isOpen=xianJieArenaActModel:checkIsXJArenaActCanOpen()
if(isIgnoreCheckOpened or isOpenedAct)and isOpen then
xianJieArenaActController:createArenaBuild(isInit)
end
end

function xianJieArenaActController:checkReqArenaDataByIgnoreMJ()
local isOpenedAct=xianJieArenaActModel:checkIsXJArenaActOpened()
local isOpen=xianJieArenaActModel:checkIsXJArenaActCanOpen()
local isOpen_ignoreMJ=xianJieArenaActModel:checkIsXJArenaActCanOpen_ignoreCustomCdn()
if isOpenedAct and not isOpen and isOpen_ignoreMJ then

xianJieArenaActController:reqGetXJArenaActData()
end
end

function xianJieArenaActController:createArenaBuild(isInitMap,isOnly)

local arenaList=xianJieArenaActModel:getArenaBuildList()
if arenaList then
local createNum=0
for i,v in pairs(arenaList)do
local arenaId=v.buildId
local ret=xianjieModel:createArenaData(arenaId)
createNum=createNum+1
end

if createNum>1 then
xianjieModel:createAllArenaEntities()
end
elseif isInitMap then

xianJieArenaActController:reqGetXJArenaActData()
end
end

function xianJieArenaActController:clearArenaBuild()
xianjieModel:clearData_allArena()
end

function xianJieArenaActController:resetAllArenaHud()
local allArenaIndexList={
[1]=xjClientBuildType.flcbLeiTai1,
[2]=xjClientBuildType.flcbLeiTai2,
[3]=xjClientBuildType.flcbLeiTai3,
[4]=xjClientBuildType.flcbLeiTai4,
[5]=xjClientBuildType.flcbLeiTai5,
[6]=xjClientBuildType.flcbLeiTai6,
[7]=xjClientBuildType.flcbLeiTai7,
[8]=xjClientBuildType.flcbLeiTai8,
}
for _,arenaId in ipairs(allArenaIndexList)do
self:resetArenaHudById(arenaId)
end
end

function xianJieArenaActController:resetArenaHudById(arenaId)

local arenaEntData=xianjieModel:getArenaDataByArenaId(arenaId)
if not arenaEntData then
return
end


local arenaEnt=xianjieController:getEntity(arenaEntData.ent_key)
if not arenaEnt then
return
end


local arenaHud=arenaEnt:getHud()
if not arenaHud then
return
end


if arenaHud.resetShow~=nil then
arenaHud:resetShow()
end
end


function xianJieArenaActController:reqXJArenaUpdateDataDelay(delaTime)
self:clearDelayTimer()
self.delayTimer=timer.new()
delaTime=delaTime or 5
self.delayTimer:start(delaTime,function()
return xianJieArenaActController:reqGetXJArenaActData()
end,1)
end


function xianJieArenaActController:clearDelayTimer()
if self.delayTimer then
self.delayTimer:cancel()
self.delayTimer=nil
end
end


function xianJieArenaActController:checkActIsInSettlement()
local actInfo=limitActivitiesModel:getActInfo(LIMIT_ACT_TYPE.eLeiTaiYanWu)
local delayTime=0
if actInfo then
local nowTime=timeHelper.getServerShortTime()
local settlementTime=cfgHelper.get(cfg_leitaiyanwubaseconfig_get,1,"delaySettlementTime")
local isInSettlement=false
if actInfo.pre_end_time then

if nowTime>=actInfo.pre_end_time and nowTime<actInfo.pre_end_time+settlementTime then
isInSettlement=true
delayTime=actInfo.pre_end_time+settlementTime-nowTime
end
end

if not isInSettlement and actInfo.end_time then

if nowTime>=actInfo.end_time and nowTime<actInfo.end_time+settlementTime then
isInSettlement=true
delayTime=actInfo.end_time+settlementTime-nowTime
end
end

return isInSettlement,delayTime
else

return false,delayTime
end
end


function xianJieArenaActController:openArenaInfoWin(arenaId)
UIManager:showWindow("UIXianJieArenaAct_infoWin",{arenaId=arenaId})
end


function xianJieArenaActController:openArenaCompensationWin()

local treeId=cfgHelper.get(cfg_leitaiyanwubaseconfig_get,1,"mjsjbcStoryTreeId")
if treeId then
local callback=function()

xianJieArenaActController:reqGetXJArenaCompensation()
end
worldStoryController:showStoryTree(treeId,callback)
else



end

end

