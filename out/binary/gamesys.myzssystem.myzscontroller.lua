







local _MODULENAME="myzsController"

gameState.addListener(def_table(_MODULENAME))
myzsController.name=_MODULENAME
myzsController.data={}

function myzsController:onAppStart()

myzsModel:onAppStart()

socketManager:register_receiver(13,31,self.recv_13_31)
socketManager:register_receiver(13,33,self.recv_13_33)
socketManager:register_receiver(13,34,self.recv_13_34)
socketManager:register_receiver(13,35,self.recv_13_35)
socketManager:register_receiver(13,36,self.recv_13_36)

end


function myzsController:onEnterState(isReconnect)
myzsModel:onEnterState()


notifySystem:listenNotify(notifyConfig.onDiscipleCreate,self.onExportDisciple)
notifySystem:listenNotify(notifyConfig.onDiscipleRemove,self.onExportDisciple)
notifySystem:listenNotify(notifyConfig.onDiscipleFightChanged,self.onDiscipleFightChanged)


notifySystem:listenNotify(notifyConfig.onTriggerBattle,self.onTriggerBattle)


notifySystem:listenNotify(notifyConfig.onRankListRefresh,self.onRankListRefresh)


notifySystem:listenNotify(notifyConfig.onTYTXZRewardChange,self.onTYTXZRewardChange)

notifySystem:listenNotify(notifyConfig.onNewDay,self.onNewDay)

end


function myzsController:onProtocolReq()
myzsModel:onProtocolReq()






myzsModel:exportDiscipleList()
end

function myzsController:onProtocolReqKF()
myzsModel:onProtocolReqKF()
end


function myzsController:onLeaveState(isReconnect)
myzsModel:onLeaveState(isReconnect)

self.data={}

myzsController.recved_13_31=false

notifySystem:removelistener(notifyConfig.onDiscipleCreate,self.onExportDisciple)
notifySystem:removelistener(notifyConfig.onDiscipleRemove,self.onExportDisciple)
notifySystem:removelistener(notifyConfig.onDiscipleFightChanged,self.onDiscipleFightChanged)
notifySystem:removelistener(notifyConfig.onTriggerBattle,self.onTriggerBattle)
notifySystem:removelistener(notifyConfig.onTYTXZRewardChange,self.onTYTXZRewardChange)
notifySystem:removelistener(notifyConfig.onNewDay,self.onNewDay)
end


function myzsController:onLostConnection()

end


function myzsController:onReConnection(isInitPro)

end






function myzsController.reqInitServerData()
socketManager:send_13_31()
end


function myzsController.reqRestartGame(reset_type)
socketManager:send_13_32(reset_type)
end

function myzsController.reqGameRank()

end












function myzsController.reqInteraction(interaction_type,idx,discipleListLen,discipleList)
socketManager:send_13_34(interaction_type,idx,discipleListLen,discipleList)
end







function myzsController.reqGotoNextLevel(discipleListLen,discipleList)
socketManager:send_13_35(discipleListLen,discipleList)
end


function myzsController.reqNewPassCount()
socketManager:send_13_36()
end




function myzsController.recv_13_31(args)
local isBigCross=args[1]
local group=args[2]
local pass_idx=args[3]
local level_score_len=args[4]
local level_score=args[5]
local disciple_list_len=args[6]
local disciple_list=args[7]
local total_bw_list_len=args[8]
local total_bw_list=args[9]
local cur_Level_Item_List_Len=args[10]
local cur_Level_Item_List=args[11]
local start_sec=args[12]
local push_type=args[13]
local diff_level=args[14]
local diff_pass_count=args[15]

if group<=0 then
myzsModel:setInitFinishFlag(0)
return
end

myzsController.recved_13_31=true


myzsModel:setSeasonType(isBigCross)
myzsModel:setGroup(group)
myzsModel:setDiffLevel(diff_level)
myzsModel:setDiffPassCount(diff_pass_count)

myzsModel:initLevelLookUp()
myzsModel:initSeasonOpenStamp(start_sec)
myzsModel:parseGroupLevel(pass_idx)

myzsModel:initLevelScoreData(level_score_len,level_score)

if push_type>0 then
myzsModel:clearDiscipleData()
end
myzsModel:initDiscipleListData(disciple_list_len,disciple_list)

myzsModel:initBWList(total_bw_list_len,total_bw_list)
myzsModel:setCurLevelItemList(cur_Level_Item_List_Len,cur_Level_Item_List)

myzsModel:initRankConf()

if push_type==1 or push_type==2 then
UIManager.info("重新挑战成功")
end

if push_type>0 and UIManager:isActive("UIMingYuanZhuSha_MainWin")then
local func=function()
UIManager:invokeUIMethod('UIMingYuanZhuSha_MainWin','recv_13_31')
UIFullAirGameEnterController:closeUI()
end
loadingControl.openCloud(func,2)
else
UIManager:invokeUIMethod('UIMingYuanZhuSha_MainWin','recv_13_31')
end

myzsModel:setInitFinishFlag(1)

notifySystem:postNotify(notifyConfig.onMingYuanZhuShaStateChange)
notifySystem:postNotify(notifyConfig.onBuildTiaoZhanItemStateChange,buildTiaoZhanType.eMingYuanZhuSha)

UIFullTotalTouZiActivityontrol:onChanged(TZ_CATCH_TYPE.eMYZSTXZ)

myzsController:req_first_day_cross_rank()
end










function myzsController.recv_13_33(len,rank_list,level,score)

end


function myzsController.recv_13_34(interaction_type,idx,discipleDataListLen,discipleDataList)
if interaction_type==MYZSInteractionType.eBuyItem then

myzsModel:onBuyItem(idx)

elseif interaction_type==MYZSInteractionType.eSelectBW then
UIManager.info("选择成功")


myzsModel:onSelectBW(idx)


UIManager:closeWindow("UIMingYuanZhuSha_SelectBaoWuWin")

myzsModel:insertLevelScore(myzsModel:getShowGameIdx(),0)


local curIndex=myzsModel:getGameIdx()
myzsModel:parseGroupLevel(curIndex)
end

myzsModel:updateDiscipleData(discipleDataListLen,discipleDataList)
end


function myzsController.recv_13_35(level,discipleListLen,discipleList,nextShopItemListLen,nextShopItemList)
local levelConf=myzsModel:getlevelConf(level)
if MYZSStageType:transStageType(levelConf.obj_id)==MYZSStageType.eMonster then
local score=cfgHelper.get(cfg_globalconfig_get,1,'fightcycnum',0)
myzsModel:insertLevelScore(level,score)
UIManager:invokeUIMethod("UIMingYuanZhuSha_MainWin",'showKillMonsterLoseLingLi')
else
myzsModel:insertLevelScore(level,0)
end

myzsModel:parseGroupLevel(level)
myzsModel:updateDiscipleData(discipleListLen,discipleList)
myzsModel:setCurLevelItemList(nextShopItemListLen,nextShopItemList)

end

function myzsController.recv_13_36(diff_pass_count)
myzsModel:setDiffPassCount(diff_pass_count)
end


function myzsController.onExportDisciple()
if not myzsModel:checkOpen()then return end
myzsModel:exportDiscipleList()
end

function myzsController.onRankListRefresh(rankType)
if rankType~=eRankListType.eMingYuanZhuSha and rankType~=eRankListType.eBigCrossMingYuanZhuSha then
return
end

local dataList=rankListModel:getRankList(rankType)
myzsModel:initRankServerData(dataList)
end

function myzsController.onTYTXZRewardChange(passport_guid)
local isSysOpen=systemModel.isOpen(SYSTEM_DEFINE.eMingYuanZhuSha)
if not isSysOpen then return end

local guid=myzsModel:getTxzGuid()
if guid==passport_guid then
reddotControl.on_change_catch_type(CATCH_TYPE.eMYZSTXZ)
shiLianTaController.refreshBuildingReddot()
end
end

function myzsController.onDiscipleFightChanged(dzGuid)
myzsModel:updateDiscipleFightVal(dzGuid)
end

function myzsController.onNewDay()
UIFullTotalTouZiActivityontrol:onChanged(TZ_CATCH_TYPE.eMYZSTXZ)
end

function myzsController:req_first_day_cross_rank()
local flag=dialogueRepeatRemindModel.getRepeatVis(REPEAT_TIME_TYPE.eDay,REPEAT_TYPE.eMingYuanZhuShaCrossRankReq)
if myzsModel:getSeasonType()==2 and not flag then
socketManager:send_254_136()
dialogueRepeatRemindModel.setRepeatVis(REPEAT_TIME_TYPE.eDay,REPEAT_TYPE.eMingYuanZhuShaCrossRankReq,true)
end
end


function myzsController:showFullWin(params)

local winName="UIMingYuanZhuSha_MainWin"

params=params or{}
params.isFull=true

local skinType=fullScreenSkinType.eSkin5

UIFullCommonControl:showCommonWindow(winName,params,true,1,true,skinType,true)
end

function myzsController:showFullWin_Cloud(params)
local func=function()
myzsController:showFullWin(params)
end
loadingControl.openCloud(func,2)
end





function myzsController.test_13_31_1()
local testData={
1,
0,
0,
nil,
0,
nil,
0,
nil,
0,
nil,
timeHelper.getServerShortTime(),
}

myzsController.recv_13_31(testData)
end

function myzsController.test_13_31_2()
local testData={
1,
1,
1,
{20},
0,
nil,
0,
nil,
3,
{{param_1=2,param_2=1,0,0},{param_1=2,param_2=2,0,0},{param_1=2,param_2=3,0,0}},
timeHelper.getServerShortTime(),
}

myzsController.recv_13_31(testData)
end

function myzsController.test_13_31_3()
local testData={
1,
3,
3,
{20,10,10,},
0,
nil,
0,
nil,
3,
{{param_1=1,param_2=1,param_3=0,param_4=0},{param_1=1,param_2=2,param_3=0,param_4=0},{param_1=1,param_2=3,param_3=1,param_4=0}},
timeHelper.getServerShortTime(),
}

myzsController.recv_13_31(testData)
end



function myzsController.test_13_33()
local testData={
0,
nil,
0,
0,
}

myzsController.recv_13_33(testData)
end


function myzsController.printGroupLevel()

end

function myzsController.testPlayObjEnterBehavior(val)
UIManager:invokeUIMethod('UIMingYuanZhuSha_MainWin','startTargetObjectEnterBehavior',val)
end

function myzsController.testPlaykillMonsterBehavior()
UIManager:invokeUIMethod('UIMingYuanZhuSha_MainWin','startKillMonsterBehavior')
end

function myzsController.testPlayRemoveBehavior()
UIManager:invokeUIMethod('UIMingYuanZhuSha_MainWin','startMerchantDisappearBehavior')
end

function myzsController.testPlayLingLiDeep()
UIManager:invokeUIMethod('UIMingYuanZhuSha_MainWin','showKillMonsterLoseLingLi')
end

function myzsController.testBgMove(val)
UIManager:invokeUIMethod('UIMingYuanZhuSha_MainWin','setBgSpineAnim',val)
end

function myzsController.CGM_Check_MYZS_TXZ()
local isOpen=myzsModel:checkOpen()
local group=myzsModel:getGroup()
local txzID=myzsModel:getTxzID()
local txzGuid=myzsModel:getTxzGuid()
local leftTime=myzsModel:getTxzLeftTime()



local txzData=UITYTongXingZhengModel:getDataByGuid(txzGuid)

end

function myzsController.CGM_Check_MYZS_OPEN()
local isSysOpen=systemModel.isOpen(SYSTEM_DEFINE.eMingYuanZhuSha)

local isInit=myzsModel:getInitFinishFlag()

local openDay_conf=myzsModel:getBaseConfig('server_open_day')
local openDay_server=timeHelper.getServerOpenDay_kf()


end


function myzsController.printEnterEndTime()

end
