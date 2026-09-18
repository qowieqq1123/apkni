






local _MODULENAME="JiuYouTaController"

gameState.addListener(def_table(_MODULENAME))
JiuYouTaController.name=_MODULENAME
JiuYouTaController.data={}

function JiuYouTaController:onAppStart()

JiuYouTaModel:onAppStart()


socketManager:register_receiver(13,21,JiuYouTaController.recv_13_21)
socketManager:register_receiver(13,22,JiuYouTaController.recv_13_22)
socketManager:register_receiver(13,23,JiuYouTaController.recv_13_23)



















end


function JiuYouTaController:onEnterState(isReconnect)
JiuYouTaModel:onEnterState()
notifySystem:listenNotify(notifyConfig.building_event,self.on_building_event)

notifySystem:listenNotify(notifyConfig.onNewDay5am,self.onNewDay5am)
notifySystem:listenNotify(notifyConfig.onRankListRefresh,self.onRankListRefresh)
end


function JiuYouTaController:onProtocolReq()
JiuYouTaModel:onProtocolReq()
end


function JiuYouTaController:onLeaveState(isReconnect)
JiuYouTaModel:onLeaveState(isReconnect)
notifySystem:removelistener(notifyConfig.building_event,self.on_building_event)
notifySystem:removelistener(notifyConfig.onNewDay5am,JiuYouTaController.onNewDay5am)
notifySystem:removelistener(notifyConfig.onRankListRefresh,self.onRankListRefresh)

self.data={}
end


function JiuYouTaController:onLostConnection()

end


function JiuYouTaController:onReConnection(isInitPro)

end


function JiuYouTaController.on_building_event(etype,id,bdId,args)
if etype==buildingEvent.buildStart then
if JiuYouTaModel:isJiuYouTaUnlock()then
JiuYouTaController.req_13_21()
end
end
end



function JiuYouTaController.onNewDay5am()
if JiuYouTaModel:isJiuYouTaUnlock()then
timeEventController.delayDo(3,function()
socketManager:send_13_21()
end)
end
end

function JiuYouTaController.onRankListRefresh(rankType)
if rankType==eRankListType.eJiuYouTa1 or rankType==eRankListType.eJiuYouTa2 or rankType==eRankListType.eJiuYouTa3 then
JiuYouTaModel:initJiuYouTaClearNumber(true)
end
end

function JiuYouTaController.req_13_21()
socketManager:send_13_21()
end

function JiuYouTaController.req_13_22(layer_id)
local reqTime=JiuYouTaModel:getRecordReqTime(layer_id)
if reqTime and timeHelper.getServerShortTime()<reqTime+60*5 then
return false
else
socketManager:send_13_22(layer_id)
return true
end
end

function JiuYouTaController.req_13_23(layer_id,idxList)
socketManager:send_13_23(layer_id,#idxList,idxList)
end











function JiuYouTaController.recv_13_21(args)
local rank_type,layer_id,begintimes,layer_list_len,layerList,diff_level=unpack(args)
JiuYouTaModel:setJiuYouTaRankType(rank_type)
JiuYouTaModel:setClearLayer(layer_id)
JiuYouTaModel:setJiuYouTaRating(diff_level)
JiuYouTaModel:setSectionRewardData(layer_list_len,layerList)
JiuYouTaModel:setBeginTime(begintimes)

UIManager:callWindowFunc("UIJiuYouTaEnterWin","refreshPanel")

if rank_type>0 then
JiuYouTaModel:setSectionRewardState()
end

taskModel:disposeClientCheckTaskTypeEvent(clientCheckTaskTypeEventType.eJiuYouTaLayer)

taskModel:disposeConditionsEvent(taskConditionEventType.eJiuYouTaOpen)
end







function JiuYouTaController.recv_13_22(args)
local layer_id,maxFightInfo,minFightInfo,recent_record_len,recentList,maxScoreInfo=unpack(args)
local now=timeHelper.getServerShortTime()
JiuYouTaModel:setRecordList(layer_id,maxFightInfo,minFightInfo,recentList,now,maxScoreInfo)
UIManager:callWindowFunc("UIJiuYouTaLogWin","onRefresh")
end



function JiuYouTaController.recv_13_23(layer_id,idx_len,idxList)
JiuYouTaModel:setSectionRewardGot(layer_id,idx_len,idxList)
JiuYouTaModel:setSectionRewardState()
UIManager:callWindowFunc("UIJiuYouTaRewardSelectWin","onRecv")
UIManager:callWindowFunc("UIJiuYouTaEnterWin","onRecvGotReward")

end

function JiuYouTaController.req_rank_list(rank_type)
rank_type=rank_type or JiuYouTaModel:getJiuYouTaRankType()
local listType=JiuYouTaModel:getJiuYouTaRankListType(rank_type)
rankListController:req_rankList_data(listType,true)
end

function JiuYouTaController.req_rank_score_list(rank_type)
rank_type=rank_type or JiuYouTaModel:getJiuYouTaRankType()
local listType=JiuYouTaModel:getJiuYouTaScoreRankListType(rank_type)
rankListController:req_rankList_data(listType,true)
end





function JiuYouTaController:showPrepareWindow(layer)
layer=layer or JiuYouTaModel:getCurLayer()

local monsterList=JiuYouTaModel.getLayerMonsterGroupList(layer)

local fightList={}
local multipleMonsterList={}
for i,v in ipairs(monsterList)do
table.insert(fightList,JiuYouTaModel:getMonsterFightVal(layer,i))
table.insert(multipleMonsterList,cfgHelper.get2(cfg_monstergroup_get,v,"monList"))
end

local temNum=#monsterList
local teamData=fightPreSelectModel:getMulTeamSaveData(eFightPreSelectType.jiuyouta,temNum)

local winArgs=
{
enterCallBack=function(guidList,zfId,map)
self.selectDiscipleCallBack(guidList,zfId,nil)
end,
enterTxt="九幽塔",
cancelCallBack=self.cancelSelectDiscipleCallBack,
skipDiscipleStateCheck=true,
skipDiscipleInjuryCheck=true,
multipleMonsterList=multipleMonsterList,
groupId=monsterList[1],
multipleTeams=teamData,


fightType=eFightPreSelectType.jiuyouta,
dontCloseStage=true,
enterBehaviorId=1,
statePriorityCheck=false,
monsterFightEx=fightList,
}



fightController:setSelectMask({1,2,3,4,5})

UIFullFightPrepareControl:showPrepareWindow(winArgs)
end


function JiuYouTaController.selectDiscipleCallBack(guidList,zfId,hideStage,selectLayer)
selectLayer=selectLayer or JiuYouTaModel:getCurLayer()
local isClearAll=false
if not isClearAll then
JiuYouTaModel:setSelectZhenFa(zfId)

JiuYouTaController.hideStage=hideStage
fightLaunchController:sendFightEx(eBattleLaunch.jiuyouta,guidList,{selectLayer},hideStage)

else
if hideStage then
JiuYouTaController:showBackMsg()
end
UIManager.error("九幽塔已通关")
end
end

function JiuYouTaController:showBackMsg()
local args={}
JiuYouTaModel:setGuaJILoseArgs(args)
msgWinControl:addMsgWin(msgWinType.eJiuYouTa,args)
end

function JiuYouTaController.cancelSelectDiscipleCallBack()
fightManager.cleanEntity()
UIFullJiuYouTaControl:showEnterWindow()
end



function JiuYouTaController.onStartBattle(battle,result,logIdx,layer,buildingData,list)
buildTiaoZhanModel:setShiLianTaFightType(buildShiLianTaFightType.eJiuYouTa)

JiuYouTaModel.data.isFighting=true


local handle=fightBattleHandle:getHandle(eBattleType.jiuyouta)
handle.enterAni=false
JiuYouTaModel:setPlayingBattle(battle)
local curBattle=fightModel:getBattle(battle)


if buildingData then
local hud=JiuYouTaModel:getHUD()
if hud then
hudControl:removeHUD(hud)
end
local battleHUD=hudControl:addHUD(INSTANCE_TYPE.eShiLianTa,
buildingData.entityId,Vector3(-1.2,0.7,0),false,true,function(id)
local bw=hudControl:getHUDWidget(id)
bw:SetChildUIModelShowTarget(0,2076,1,{},eAnimationID.stand,false,false,0,nil)
local layer=JiuYouTaModel:getClearLayer()
bw:SetChildText(1,FMT.fmt("当前通关{0}层",result==fightResultType.Victory and layer-1 or layer))
bw:SetChildButtonClick(2,function()
UIFullJiuYouTaControl:showEnterWindow()
end)
end)
JiuYouTaModel:addHUD(battleHUD)
buildingData.battleId=battle
end
end

function JiuYouTaController.onResultComplete(battle,result,logIdx,layer,buildingData,list)

local curBattle=fightModel:getBattle(battle)
local isOpenWindow=false
if curBattle and curBattle.isShowWindow and curBattle.jump==nil then
isOpenWindow=true
end
fightController:closeBattle(battle)
if isOpenWindow and result==1 then
local clayer=JiuYouTaModel:getClearLayer()
if layer<clayer then
UIFullJiuYouTaControl:showEnterWindow(layer)
else
UIFullJiuYouTaControl:showEnterWindow()
end

end
isometricMapSystem:leaveBattleMode()

end

function JiuYouTaController.onCompleteBattle(battle,result,logIdx,showWindow,isReconnet,layer,buildingData,list)
if not showWindow then
if result==fightResultType.Victory then
if not isReconnet then

JiuYouTaController:onContinue(true,layer)
JiuYouTaModel:setSectionRewardState()
end
taskModel:disposeClientCheckTaskTypeEvent(clientCheckTaskTypeEventType.eJiuYouTaLayer)
end
else

if result==fightResultType.Victory then
JiuYouTaModel:setSectionRewardState()
taskModel:disposeClientCheckTaskTypeEvent(clientCheckTaskTypeEventType.eJiuYouTaLayer)
end
end

JiuYouTaModel:setPlayingBattle()



local hud=JiuYouTaModel:getHUD()
if hud then
hudControl:removeHUD(hud)
end

end

function JiuYouTaController.onBackStageCompleteBattle(battle,result,args)
local param=args.param
if param then
JiuYouTaModel:insertGuaJIReward(param[3]or{})
end
end

function JiuYouTaController.onCloseBattle(battle,result,logIdx,layer,buildingData,list)
isometricMapSystem:leaveBattleMode()
JiuYouTaModel.data.isFighting=false
local battleHandle=fightModel:getBattle(battle)
if not(battleHandle and battleHandle.isOver)then
JiuYouTaModel:setGuaJILayer(layer)
end


end

function JiuYouTaController.onFightResultBaseBtn(this,bId,param)
local layer=param[1]
if not param[4]then

local nextLayer=layer+1
local mapId=nil
local monsterList=JiuYouTaModel.getLayerMonsterGroupList(nextLayer)
local checkList={}
if monsterList then
local temNum=#monsterList
mapId=cfgHelper.get2(cfg_monstergroup_get,monsterList[1],"mapId")
checkList=fightPreSelectModel:getMulTeamSendData(eFightPreSelectType.jiuyouta,temNum,mapId,JiuYouTaModel:getSelectZhenFa())or{}
end


local continuCallBack=function()

UIFullFightControl:hideWindow("UIFightMainTop")
UIFullFightControl:hideWindow("UIShiLianTaFightTop")


if mapId then
local entities=nil
local battle=fightModel:getBattle(bId)
if battle~=nil then
entities=battle:getEntities()
else
return
end


for i=6,10 do
if entities and entities[i]then
battle:removeEntity(i)
end
end

for i=101,110 do
if entities and entities[i]then
battle:removeEntity(i)
end
end

local stageIndex=fightManager.getActiveStageIndex()
local nextStage=fightStage:create(mapId,function(args)
fightManager.activeStage(stageIndex==1 and 2 or 1)
fightManager.setState(fightSceneTypo.enter)
fightManager.setScale(nil,Vector3.zero)
timeEventController.delayDo(2,function()
fightManager.setScale(nil,Vector3.one)
end)
local btId=args.fightStage:runBehaviorNoEntity(stageIndex==1 and"shilianta"or"shilianta2",function()
if checkList then
local handle=fightBattleHandle:getHandle(eBattleType.jiuyouta)
handle.enterAni=true
local zfId=JiuYouTaModel:getSelectZhenFa()
JiuYouTaController.selectDiscipleCallBack(checkList,zfId)
end
end)
local bt=fBTBehaviorMrg:getRunBT(btId)
if bt then
for i=1,5 do
if entities and entities[i]then
bt:setSharedValue(FMT.fmt("entity_{0}",i),entities[i])
entities[i]:showHuD(false)
end
end

end
end,nil,stageIndex==1 and 2 or 1,0)
end


end
local cd=5
local continueText="继续"

local checkBan,banPlayTime=JiuYouTaModel:isInBanPlayTime()

local topLayer=JiuYouTaModel:getTopLayer()

local quitCallBack=function()
fightResultController:afterShowResult()
end
if next(checkList)and layer<topLayer and not checkBan then
return fightResultWinConfig:getBaseWinParam(this.baseWin,this.baseType,continueText,continuCallBack,"退 出",quitCallBack,cd)
else
return fightResultWinConfig:getBaseWinParam(this.baseWin,1,"退 出",quitCallBack)
end
end
end

function JiuYouTaController.onFightResultExtraWinArgs(this,bId,prizeList,param)
local list={}
for i,v in ipairs(param[3]or{})do
table.insert(list,{itemid=v.itemid,num=v.itemcount})
end

local clearLayer=JiuYouTaModel:getFightingLayer()
local aimLayer,reType=JiuYouTaModel:getCurAimLayer()

local middle={text=FMT.fmt("本层挑战积分：<color=#549327>{0}</color>",JiuYouTaModel:getScore(clearLayer))}








return fightResultWinConfig:getExtraWinParam(this.extraWin,this.extraType,list,nil,middle)
end

function JiuYouTaController:onContinue(hideStage,layer)

if buildTiaoZhanModel:getShiLianTaFightType()~=buildShiLianTaFightType.eJiuYouTa then
JiuYouTaController:showBackMsg()
return
end

local monsterList=JiuYouTaModel.getLayerMonsterGroupList(layer+1)
local checkList={}
if monsterList then
local temNum=#monsterList
local mapId=cfgHelper.get2(cfg_monstergroup_get,monsterList[1],"mapId")
checkList=fightPreSelectModel:getMulTeamSendData(eFightPreSelectType.jiuyouta,temNum,mapId,JiuYouTaModel:getSelectZhenFa())or{}

end


if not next(checkList)then
JiuYouTaController:showBackMsg()
return
end
local isBanPlay,banPlayTime=JiuYouTaModel:isInBanPlayTime()
if isBanPlay then
UIManager.error("玩法已结算，无法再进行挑战")
JiuYouTaController:showBackMsg()
return
end


local zfId=JiuYouTaModel:getSelectZhenFa()
JiuYouTaController.selectDiscipleCallBack(checkList,zfId,hideStage)
end
