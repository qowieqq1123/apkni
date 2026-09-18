






local _MODULENAME="shiLianTaController"




gameState.addListener(def_table(_MODULENAME))
shiLianTaController.name=_MODULENAME


shiLianTaController.data={}



function shiLianTaController:onAppStart()

shiLianTaModel:onAppStart()





socketManager:register_receiver(13,1,shiLianTaController.recv_13_1)

socketManager:register_receiver(13,3,shiLianTaController.recv_13_3)
socketManager:register_receiver(13,4,shiLianTaController.recv_13_4)
socketManager:register_receiver(13,5,shiLianTaController.recv_13_5)
socketManager:register_receiver(13,6,shiLianTaController.recv_13_6)
socketManager:register_receiver(13,7,shiLianTaController.recv_13_7)
socketManager:register_receiver(13,8,shiLianTaController.recv_13_8)


socketManager:register_receiver(13,12,shiLianTaController.recv_13_12)

socketManager:register_receiver(13,13,shiLianTaController.recv_13_13)
socketManager:register_receiver(13,14,shiLianTaController.recv_13_14)
socketManager:register_receiver(13,15,shiLianTaController.recv_13_15)





end


function shiLianTaController:onEnterState(isReconnect)
shiLianTaModel:onEnterState()
if isReconnect then
shiLianTaController.clearHud()
end
notifySystem:listenNotify(notifyConfig.home_event,self.onHomeEvent)
notifySystem:listenNotify(notifyConfig.building_event,self.onBuildingEvent)
end


function shiLianTaController:onServerDataInitFinish()
shiLianTaModel:onServerDataInitFinish()

end


function shiLianTaController:onLeaveState()
shiLianTaController.clearHud()
shiLianTaModel:onLeaveState()

self.data={}
notifySystem:removelistener(notifyConfig.home_event,self.onHomeEvent)
notifySystem:removelistener(notifyConfig.building_event,self.onBuildingEvent)
end


function shiLianTaController:onLostConnection()

end

function shiLianTaController:initBuildingData()
local bdData=zongmenModel:findBuildingDataByType(mapIdType.zhufeng,SLG_SYSTEM_TYPE.eShiLianTa)
if bdData then
shiLianTaController.req_13_1()
socketManager:send_13_3()
shiLianTaController.req_13_6()
end
end


function shiLianTaController.onHomeEvent(etype)
if etype==homeEvent.eEnterHome then
local shiliantaData=shiLianTaModel:getBuildingData()
if shiliantaData then
local battleId=shiLianTaModel:getPlayingBattle()
local hud=shiLianTaModel:getHUD()
if not hud and battleId then

hud=hudControl:addHUD(INSTANCE_TYPE.eShiLianTa,
shiliantaData.entityId,Vector3(-1.2,0.7,0),false,true,function(id)
local bw=hudControl:getHUDWidget(id)
bw:SetChildUIModelShowTarget(0,2076,1,{},eAnimationID.stand,false,false,0,nil)
bw:SetChildText(1,FMT.fmt("当前通关{0}层",shiLianTaModel:getClearLayer()))
bw:SetChildButtonClick(2,function()
shiLianTaController:showEnterWindow()
end)
end)
shiliantaData.battleId=battleId
shiLianTaModel:addHUD(hud)
end
end
end
end

function shiLianTaController.clearHud()
local hud=shiLianTaModel:getHUD()
if hud then
hudControl:removeHUD(hud)
shiLianTaModel:setPlayingBattle()
end








end

function shiLianTaController.onBuildingEvent(etype,sfId,ubdId,arg1,arg2,arg3)
if etype==buildingEvent.buildComplete then
local bdData=zongmenModel:getBuildingData(ubdId)
local cfg=cfgHelper.get1(cfg_monijybuildconfig_get,bdData.build_id)
local buildType=cfg.build_type
if buildType==SLG_SYSTEM_TYPE.eShiLianTa then
shiLianTaController.req_13_1()
socketManager:send_13_3()
shiLianTaController.req_13_6()
end
end
end



function shiLianTaController.unlockShiLianTa(repairData)
local unlockCond,lockStr=shiLianTaModel:checkUnlockCondition()
if unlockCond then
local sfId=zongmenModel:getMountainId()
zongmenControl:reqBuild(sfId,repairData.id,repairData.x,repairData.y,0)
else
UIManager.error(lockStr)
end
end

function shiLianTaController.selectDiscipleCallBack(guidList,zfId,hideStage)
UIManager:closeWindow("UIShiLianTaEnterWin")
local curLayer=shiLianTaModel:getCurLayer()
local isClearAll=shiLianTaModel:isClearAll()
if not isClearAll then
if shiLianTaModel:isZMLevelNotEnough(curLayer)then
return
end
local monsterList,groupID=shiLianTaModel.getLayerMonsterList(curLayer)

local mapId=nil
if groupID then
mapId=cfgHelper.get2(cfg_monstergroup_get,groupID,"mapId")
end
shiLianTaModel:setSelectZhenFa(zfId)

shiLianTaController.hideStage=hideStage
socketManager:send_13_12(#guidList,guidList)
fightLaunchController:sendFight(eBattleLaunch.shilianta,guidList,mapId or 0,zfId or 0,{curLayer},hideStage)

else
UIManager.error("锁妖塔已通关")
end
end

function shiLianTaController:onContinue(hideStage,layer)

if buildTiaoZhanModel:getShiLianTaFightType()~=buildShiLianTaFightType.eShiLianTa then
return
end

local guidList=fightPreSelectModel:getTeamData(fightPreSelectModel.fightType.shilianta)
local team={}
for i=1,fightPreSelectModel.maxPosNum do
if guidList[i]then
team[i]={1,guidList[i]}
else
team[i]={0,int64.zero}
end
end

local continueLayer=cfgHelper.get2(cfg_traintowerglobalconfig_get,1,"continueLayer")
if layer<=continueLayer then
return
end


local zfId=shiLianTaModel:getSelectZhenFa()
shiLianTaController.selectDiscipleCallBack(team,zfId,hideStage)
end

function shiLianTaController.cancelSelectDiscipleCallBack()

fightManager.cleanEntity()
shiLianTaController:showEnterWindow()
end


function shiLianTaController.fight(layer,fightResult,fightReportStr)

local reward=shiLianTaModel.getLayerReward(layer)

local list={}
if reward then
for i,v in ipairs(reward)do
table.insert(list,{itemid=v[1],itemcount=v[2]})
end
end

local buildingData=shiLianTaModel:getBuildingData()

local isClearAll=cfgHelper.get1(cfg_traintowerconfig_get,layer+1)==nil
shiLianTaModel:setClearLayerData(cfgHelper.get1(cfg_traintowerconfig_get,layer+1)==nil,layer+1)

notifySystem:postNotify(notifyConfig.onTriggerBattle,eBattleType.shilianta,fightResult,fightReportStr,
layer,buildingData,list,isClearAll)

isometricMapSystem:enterBattleMode()
end






function shiLianTaController:showEnterWindow(refresh,layer,afterOpenCB)
local battleId=shiLianTaModel:getPlayingBattle()
if battleId and fightController:isBattlePlaying(battleId)then
fightController:openBattle(battleId)
isometricMapSystem:enterBattleMode()
UIFullFightControl:showWindow("UIShiLianTaFightTop")
local guajiLayer=shiLianTaModel:getGuaJILayer()
if guajiLayer then
local layer=shiLianTaModel:getFightingLayer()
if layer>guajiLayer then
UIManager:showWindow("UIShiLianTaGuaJiRewardWin",{guajiLayer=guajiLayer,curLayer=layer})
end
end
else
if refresh then
shiLianTaController.req_13_1(true)
else
shiLianTaController:showEnterWindowRecv(nil,layer,afterOpenCB)
end
end
end

function shiLianTaController:showEnterWindowRecv(winArgs,layer,afterOpenCB)
local guidList=shiLianTaModel:getTempTeamData()
local lArgs=
{
[1]=shiLianTaModel:getClearAll(),
[2]=layer or shiLianTaModel:getCurLayer(),
[5]=guidList and#guidList or 0,
[6]=guidList,
}

winArgs=winArgs or lArgs
local mapId=nil
local curLayer=winArgs[2]or shiLianTaModel:getCurLayer()

local monsterList,groupID=shiLianTaModel.getLayerMonsterList(curLayer)

if groupID then
mapId=cfgHelper.get2(cfg_monstergroup_get,groupID,"mapId")
end

winArgs.groupId=groupID
isometricMapSystem:enterBattleMode()
local onLoadCallback=function()

fightManager.initCamera(Vector3.New(0,1,2.5),Vector3.New(0,1.85,0),Vector3.New(0,-2,5),Vector3.New(0,0,0),15)

UIManager:hideWindow("UITaskListWin")


UIFullFightPrepareControl:showShiLianTaWindow(winArgs)
if afterOpenCB then
afterOpenCB()
end
UIManager:invokeUIMethod("UIFightPrepareLoading","endAni")

local guajiLayer=shiLianTaModel:getGuaJILayer()
if guajiLayer then
local layer=shiLianTaModel:getFightingLayer()or shiLianTaModel:getCurLayer()
if layer>guajiLayer then
UIManager:showWindow("UIShiLianTaGuaJiRewardWin",{guajiLayer=guajiLayer,curLayer=layer})
end
end
end

local startCallback=function()
winArgs.selectStage=fightController:showSelectStage(nil,mapId,{},onLoadCallback,false)
end

if shiLianTaModel.data.selectStage then
startCallback()
else
UIFullFightPrepareControl:showWindow("UIFightPrepareLoading",{
startCallback=startCallback
})
end
end

function shiLianTaController:showPrepareWindow()
local layer=shiLianTaModel:getCurLayer()
local viewFight=cfgHelper.get2(cfg_traintowerconfig_get,layer,"viewFight")
local globalCfg=cfgHelper.get(cfg_traintowerglobalconfig_get,1)
local monsterList,groupID=shiLianTaModel.getLayerMonsterList(layer)
local guidList=shiLianTaModel:getTempTeamData()
local winArgs=
{
enterCallBack=function(guidList,zfId,map)
shiLianTaController.selectDiscipleCallBack(guidList,zfId,nil)
end,
enterTxt="锁妖塔",
cancelCallBack=shiLianTaController.cancelSelectDiscipleCallBack,
skipDiscipleStateCheck=true,
skipDiscipleInjuryCheck=true,
monsterList=monsterList,
groupId=groupID,
cantEnter=shiLianTaModel:isClearAll(),
cantEnterTips="锁妖塔已通关",
fightType=fightPreSelectModel.fightType.shilianta,
dontCloseStage=true,
enterBehaviorId=1,
monsterFight=viewFight,
statePriorityCheck=false,
fightCompareTips=globalCfg.fightCompareTips,
fightCompareValue=globalCfg.fightCompare,
}
if guidList and next(guidList)~=nil then
local teamList={}
for i,v in ipairs(guidList)do
if v.unitType>0 then
teamList[i]=v.unitId
end
end
winArgs.teamList=teamList
else
local teamList=fightPreSelectModel:getTeamData(fightPreSelectModel.fightType.shilianta)
winArgs.teamList=teamList
end




fightController:setSelectMask({1,2,3,4,5})
UIFullFightPrepareControl:showPrepareWindow(winArgs)
end

function shiLianTaController:showRewardWindow()
local aimLayer,reType=shiLianTaModel:getCurAimLayer()
local topLayer=shiLianTaModel.finalRewardLayer
local sectionSelectLayer=shiLianTaModel:getSectionSelectLayer()
if(shiLianTaModel:getSectionSelectTimes()==0 and(not shiLianTaModel:getSectionRewardData())and shiLianTaModel:isClearAll())or(sectionSelectLayer>topLayer)then
UIManager.info("已领取所有通关奖励")
return
end

if(not shiLianTaModel:getSectionRewardState())then
local weakGuide=3501
local isGuide=userActorSetting.get(FMT.fmt("weakGuide_{0}",weakGuide),0)
if isGuide~=1 then
weakGuideController:beginGuide(weakGuide)

end
UIManager:showWindow("UIShiLianTaRewardSelectWin",{panelType=shiLianTaModel.RewardPanelType.Clear,layer=aimLayer})
else
UIManager:showWindow("UIShiLianTaRewardSelectWin",{panelType=shiLianTaModel.RewardPanelType.NotClear,layer=aimLayer})
end
end

function shiLianTaController:showRankWindow(panelType)
UIManager:showWindow("UIShiLianTaRankBackWin",panelType)
end











function shiLianTaController:openReplay(recordId,layer)





























fightController:send_254_29(recordId,{layer,recordId,eRePlayerType.shilianta},false)
end


function shiLianTaController:getShiLianZhengTuData()
socketManager:send_13_13()
end


function shiLianTaController:getShiLianZhengTuRewardByMenuId(menuId)
socketManager:send_13_14(menuId)
end

function shiLianTaController.refreshBuildingReddot()
local sfId=zongmenModel:getMountainId()
if sfId then
local bdDatas=zongmenModel:getBuildingDataByBdType(sfId,SLG_SYSTEM_TYPE.eShiLianTa)
for i,v in ipairs(bdDatas)do
hudControl:refreshBuildingStatusHUD(v.un_build_id)
end
end
end



function shiLianTaController.req_13_1(showWindow)
shiLianTaController.data.showMainWindow=showWindow
socketManager:send_13_1(showWindow)
end


function shiLianTaController.req_13_4(layer,itemIdListLen,itemIdList)
socketManager:send_13_4(layer,itemIdListLen,itemIdList)
end


function shiLianTaController.req_13_5()
socketManager:send_13_5()
end


function shiLianTaController.req_13_6()
socketManager:send_13_6()
end


function shiLianTaController.req_13_7()
socketManager:send_13_7()
end



function shiLianTaController.recv_13_1(argtable)
local isChallengeAll,curLayer,stRewardLayerListLen,stRewardLayerList,teamGuidListLen,teamGuidList=argtable[1],argtable[2],argtable[3],argtable[4],argtable[5],argtable[6]

local isInit=shiLianTaModel:isInit()

local oldLayer=shiLianTaModel:getCurLayer()

shiLianTaModel:setClearLayerData(isChallengeAll,curLayer)
shiLianTaModel:setFirstClearRewardLayerFlagList(stRewardLayerListLen,stRewardLayerList)
shiLianTaModel:setTempTeamData(teamGuidList)
if not isInit then
notifySystem:postNotify(notifyConfig.shilianta_init,curLayer,isChallengeAll)
end

if shiLianTaController.data.showMainWindow then


shiLianTaController:showEnterWindowRecv(argtable)

shiLianTaController.data.showMainWindow=nil
else
UIManager:invokeUIMethod("UIShiLianTaEnterWin","refreshPanel")
end
taskModel:disposeConditionsEvent(taskConditionEventType.eShiLianTa)
end

function shiLianTaController.recv_13_3(layer,itemListLen,itemList,canGetNum)
shiLianTaModel:setSectionRewardData(itemListLen,itemList)
shiLianTaModel:setSectionSelectLayer(layer)

local topLayer=shiLianTaModel.finalRewardLayer
if canGetNum>0 then
shiLianTaModel:setSectionSelectTimes(canGetNum)
shiLianTaModel:setSectionRewardState(layer>topLayer)
else
shiLianTaModel:setSectionSelectTimes(0)

shiLianTaModel:setSectionRewardState(true)
end
if shiLianTaModel.data.afterGotReward and layer<=topLayer then
UIManager:showWindow("UIShiLianTaRewardSelectWin",{panelType=shiLianTaModel.RewardPanelType.Clear,layer=layer})
end
UIManager:invokeUIMethod("UIShiLianTaEnterWin","refreshPanel")
shiLianTaModel.data.afterGotReward=nil
shiLianTaController.refreshBuildingReddot()
end

function shiLianTaController.recv_13_4(layer,itemListLen,itemList)
shiLianTaModel.data.afterGotReward=true
if itemListLen>0 then
local list={}
for i,v in ipairs(itemList)do
table.insert(list,{itemid=v.param_1,num=v.param_2})
end

showPrizeControl.showWindowNow(list)
socketManager:send_13_3()
UIManager:closeWindow("UIShiLianTaRewardSelectWin")
else
socketManager:send_13_3()
end

local weakGuide=3500
local isGuide=userActorSetting.get(FMT.fmt("weakGuide_{0}",weakGuide),0)
if isGuide~=1 then
userActorSetting.flushVal(FMT.fmt("weakGuide_{0}",weakGuide),1)
end
local weakGuide=3501
local isGuide=userActorSetting.get(FMT.fmt("weakGuide_{0}",weakGuide),0)
if isGuide~=1 then
userActorSetting.flushVal(FMT.fmt("weakGuide_{0}",weakGuide),1)
end
end

function shiLianTaController.recv_13_5(rankListLen,rankList)
shiLianTaModel:setRankData(rankListLen,rankList)
UIManager:invokeUIMethod("UIShiLianTaRankWin","refreshRankList")
UIManager:invokeUIMethod("UIShiLianTaRankWin","refreshMyRank")


UIManager:invokeUIMethod("UISubAct_suoyaoshilianWin","refresh")
UIManager:invokeUIMethod("UISubAct_suoyaoshilian_rewardWin","refresh")
end

function shiLianTaController.recv_13_6(tarListLen,tarList)
shiLianTaModel:setFirstClearRewardLayerList(tarListLen,tarList)

UIManager:invokeUIMethod("UIShiLianTaTaskWin","refreshFirstClearList")
end

function shiLianTaController.recv_13_7(layer)
shiLianTaModel:setFirstClearRewardLayerFlag(layer)
UIManager:invokeUIMethod("UIShiLianTaTaskWin","refreshFirstClearItem",layer)
local reddot=shiLianTaModel:checkFirstClearRewardReddot()or false
UIManager:invokeUIMethod("UIShiLianTaRankBackWin","refreshReddot",2,reddot)
UIManager:invokeUIMethod("UIShiLianTaEnterWin","refreshRankReddot",reddot)

shiLianTaController.refreshBuildingReddot()
end

function shiLianTaController.recv_13_8(listLen,recordList)
UIManager:invokeUIMethod("UIShiLianTaLogWin","onRefresh",listLen,recordList)
end



















function shiLianTaController.recv_13_12(len,diziList)
shiLianTaModel:setTempTeamData(diziList)
end


function shiLianTaController.recv_13_13(len,list)
shiLianTaModel:setShiLianZhengTuData(len,list)


local win=UIManager:findActiveWindow('UIShiLianZhengTu_MainWin')
if win then
win:refreshPage()
win:refreshMenu()
end


win=UIManager:findActiveWindow('UIShiLianTaEnterWin')
if win then
win:refreshZhengTuBtn()
end
end


function shiLianTaController.recv_13_14(menuId,freeLayerMax,moneyLayerMax)
shiLianTaModel:setShiLianZhengTuDataByMenuId(menuId,freeLayerMax,moneyLayerMax)


local win=UIManager:findActiveWindow('UIShiLianZhengTu_MainWin')
if win then
win:refreshPage(menuId)
win:refreshMenu()
end


win=UIManager:findActiveWindow('UIShiLianTaEnterWin')
if win then
win:refreshZhengTuBtn()
end
end


function shiLianTaController.recv_13_15(menuId)
shiLianTaModel:setShiLianZhengTuRechargeByMenuId(menuId)


local win=UIManager:findActiveWindow('UIShiLianZhengTu_MainWin')
if win then
win:refreshPage(menuId)
win:refreshMenu()
end


win=UIManager:findActiveWindow('UIShiLianTaEnterWin')
if win then
win:refreshZhengTuBtn()
end
end


function shiLianTaController.onStartBattle(battle,result,logIdx,layer,buildingData,list)
buildTiaoZhanModel:setShiLianTaFightType(buildShiLianTaFightType.eShiLianTa)

shiLianTaModel.data.isFighting=true
shiLianTaModel:setFightingLayer(layer)
shiLianTaModel:setGuaJILoseLayer(nil)
shiLianTaController.req_13_1()
socketManager:send_13_3()
local handle=fightBattleHandle:getHandle(eBattleType.shilianta)
handle.enterAni=false
shiLianTaModel:setPlayingBattle(battle)
local curBattle=fightModel:getBattle(battle)
if curBattle and curBattle.isShowWindow then
UIFullFightControl:showWindow("UIShiLianTaFightTop")
end
if buildingData then
local hud=shiLianTaModel:getHUD()
if hud then
hudControl:removeHUD(hud)
end
local battleHUD=hudControl:addHUD(INSTANCE_TYPE.eShiLianTa,
buildingData.entityId,Vector3(-1.2,0.7,0),false,true,function(id)
local bw=hudControl:getHUDWidget(id)
bw:SetChildUIModelShowTarget(0,2076,1,{},eAnimationID.stand,false,false,0,nil)
local layer=shiLianTaModel:getClearLayer()
bw:SetChildText(1,FMT.fmt("当前通关{0}层",result==fightResultType.Victory and layer-1 or layer))
bw:SetChildButtonClick(2,function()
shiLianTaController:showEnterWindow()
end)
end)
shiLianTaModel:addHUD(battleHUD)
buildingData.battleId=battle
end
end

function shiLianTaController.onResultComplete(battle,result,logIdx,layer,buildingData,list)

local curBattle=fightModel:getBattle(battle)
local isOpenWindow=false
if curBattle and curBattle.isShowWindow and curBattle.jump==nil then
isOpenWindow=true
end
fightController:closeBattle(battle)
if isOpenWindow and result==1 then
shiLianTaController:showEnterWindow()
end
isometricMapSystem:leaveBattleMode()

end

function shiLianTaController.onCompleteBattle(battle,result,logIdx,showWindow,isReconnet,layer,buildingData,list)
if not showWindow then
if result==fightResultType.Victory then

if not isReconnet then

chatControl.addJianWenMesg(CHAT_MSG_TYPE.eTrainTower,FMT.fmt(cfgHelper.getlang('shilianta_auto_victory'),layer),nil)


if shiLianTaModel:isZMLevelNotEnough(layer+1)then
local args={}
shiLianTaModel:setGuaJILoseLayer(layer)
shiLianTaModel:setGuaJILoseArgs(args)
msgWinControl:addMsgWin(msgWinType.eShiliantaGuaJi,args)
else
shiLianTaController:onContinue(true,layer)
end


end
else
if not isReconnet then

chatControl.addJianWenMesg(CHAT_MSG_TYPE.eTrainTower,FMT.fmt(cfgHelper.getlang('shilianta_auto_lose'),layer),nil)
end

shiLianTaModel:setGuaJILoseLayer(layer)
end
else
UIFullFightControl:closeWindow("UIShiLianTaFightTop")
UIManager:closeWindow("UIShiLianTaGuaJiRewardWin")
end
shiLianTaModel:setFightingLayer()
shiLianTaModel:setPlayingBattle()
pushGiftManager:onChanged(GIFT_CHECK_TYPE.eShiLianTaLayer)
pushGiftTwoManager:onChanged(GIFT_EX_CHECK_TYPE.eShiLianTaLayer)
pushGiftThreeManager:onChanged(GIFT_THREE_CHECK_TYPE.eShiLianTaLayer)

local hud=shiLianTaModel:getHUD()
if hud then
hudControl:removeHUD(hud)
end
if buildingData and buildingData.battleHUD then


end
end

function shiLianTaController.onBackStageCompleteBattle(battle,result,args)

local param=args.param
if param then

shiLianTaModel:insertGuaJIReward(param[3]or{})
end
end

function shiLianTaController.onCloseBattle(battle,result,logIdx,layer,buildingData,list)
isometricMapSystem:leaveBattleMode()
shiLianTaModel.data.isFighting=false
local battleHandle=fightModel:getBattle(battle)
if not(battleHandle and battleHandle.isOver)then
shiLianTaModel:setGuaJILayer(layer)
end



end

function shiLianTaController.onFightResultBaseBtn(this,bId,param)
local layer=param[1]
if not param[4]then

local guidList=fightPreSelectModel:getTeamData(fightPreSelectModel.fightType.shilianta)
local team,checkList={},{}
for i=1,fightPreSelectModel.maxPosNum do
if guidList[i]and UIDiscipleModel:getMyDiscipleData(guidList[i])~=nil then
team[i]={1,guidList[i]}
checkList[i]=true
else
team[i]={0,int64.zero}
end
end


local continuCallBack=function()

UIFullFightControl:hideWindow("UIFightMainTop")




local monsterList,groupID=shiLianTaModel.getLayerMonsterList(layer+1)

local mapId=nil
if groupID then
mapId=cfgHelper.get2(cfg_monstergroup_get,groupID,"mapId")
end

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
if guidList then
local handle=fightBattleHandle:getHandle(eBattleType.shilianta)
handle.enterAni=true
local zfId=shiLianTaModel:getSelectZhenFa()
shiLianTaController.selectDiscipleCallBack(team,zfId)
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
local continueLayer=cfgHelper.get2(cfg_traintowerglobalconfig_get,1,"continueLayer")
if layer<continueLayer then
cd=nil
continueText="继续挑战"
end


local topLayer=cfgHelper.get2(cfg_traintowerglobalconfig_get,1,'topLayer')

local quitCallBack=function()
fightResultController:afterShowResult()
end
if next(checkList)and layer<topLayer and not shiLianTaModel:isZMLevelNotEnough(layer+1)then
return fightResultWinConfig:getBaseWinParam(this.baseWin,this.baseType,continueText,continuCallBack,"退 出",quitCallBack,cd)
else
return fightResultWinConfig:getBaseWinParam(this.baseWin,1,"退 出",quitCallBack)
end
end
end

function shiLianTaController.onFightResultExtraWinArgs(this,bId,prizeList,param)
local list={}
for i,v in ipairs(param[3]or{})do
table.insert(list,{itemid=v.itemid,num=v.itemcount})
end
local curLayer=shiLianTaModel:getCurLayer()
local clearLayer=shiLianTaModel:getClearLayer()
local aimLayer,reType=shiLianTaModel:getCurAimLayer()
local isClearAll=shiLianTaModel:isClearAll()
if aimLayer==curLayer-1 and not isClearAll then
aimLayer,reType=shiLianTaModel:getAimLayer(curLayer)
end
local middle=nil
if not isClearAll then
local isShow=(not shiLianTaModel:getSectionRewardState())
if isShow then
middle={text=FMT.fmt("再挑战{0}层可选取层数大奖\n（当前有奖励未选取）",aimLayer-clearLayer)}
else
middle={text=FMT.fmt("再挑战{0}层可选取层数大奖",aimLayer-clearLayer)}
end
end
local bottom=nil
local continueLayer=cfgHelper.get2(cfg_traintowerglobalconfig_get,1,"continueLayer")
if curLayer<=continueLayer then
bottom={text=FMT.fmt("通关{0}层开启自动挑战",continueLayer)}
end
newbieControl.startNewbie(NEW_BIE_CND_TYPE.eSuoyaotaBalance,curLayer-1)
return fightResultWinConfig:getExtraWinParam(this.extraWin,this.extraType,list,nil,middle,bottom)
end


function shiLianTaController:showShiLianZhengTuWindow(menuId)
UIManager:showWindow("UIShiLianZhengTu_MainWin",{jumpMenuId=menuId})
end

function shiLianTaController:showShiLianZhengTuBuyWindow(menuId)
UIManager:showWindow("UIShiLianZhengTu_BuyWin",{menuId=menuId})
end


function shiLianTaController:checkShiLianZhengTuEnter()

if verifyManager:isHideBusinessActivity()then
return false
end

local allMenuCfg=cfg_traintowerzhengtutagconfig()
for i,v in ipairs(allMenuCfg)do
local menuId=v.id
if shiLianTaController:checkShiLianZhengTuMenu(menuId,true)then
return true
end
end

return false
end


function shiLianTaController:checkShiLianZhengTuMenu(menuId,isCheckAllGot)

local menuCfg=cfgHelper.get1(cfg_traintowerzhengtutagconfig_get,menuId)
if not menuCfg then
logErr(FMT.fmt("找不到页签id为{0}对应的试炼征途页签配置 请检查配置是否正确",menuId))
return false
end

local isUnlock=false
local unlock=menuCfg.unlock
if not unlock then

isUnlock=true
else

isUnlock=true
for i,v in ipairs(unlock)do
local checkType=v[1]
local paramValue=v[2]
if checkType==1 then

if playerModel:getActorLevel()<paramValue then
isUnlock=false
break
end
elseif checkType==2 then

local openDay=timeHelper.getServerOpenDay()
if openDay<paramValue then
isUnlock=false
break
end
elseif checkType==3 then

local nowClearFloor=shiLianTaModel:getClearLayer()
if nowClearFloor<paramValue then
isUnlock=false
break
end
end
end
end

if not isCheckAllGot then

return isUnlock
end

if isUnlock then

local isBuyChaozhi=shiLianTaModel:checkShiLianZhengTuIsRechargeByMenuId(menuId)
if not isBuyChaozhi then

return true
end


local taskCfgList=cfgHelper.get1(cfg_traintowerzhengturewardconfig_get,menuId)
if not taskCfgList then
logErr(FMT.fmt("找不到页签id为{0}对应的试炼奖励列表 请检查配置是否正确",menuId))
return false
end

for i,v in pairs(taskCfgList)do
local targetFloor=v.id
local taskState=shiLianTaModel:checkShiLianZhengTuTaskState(menuId,targetFloor)
if taskState~=2 then

return true
end
end
end

return false
end


function shiLianTaController:checkShiLianZhengTuEnterReddot()
local allMenuCfg=cfg_traintowerzhengtutagconfig()
local notFinishMinMenuId
for i,v in ipairs(allMenuCfg)do
local menuId=v.id
if shiLianTaController:checkShiLianZhengTuMenu(menuId,true)then
if shiLianTaController:checkShiLianZhengTuMenuReddot(menuId)then
return true,menuId
else
if not notFinishMinMenuId or menuId<notFinishMinMenuId then
notFinishMinMenuId=menuId
end
end
end
end

return false,notFinishMinMenuId
end


function shiLianTaController:checkShiLianZhengTuMenuReddot(menuId)
local taskCfgList=cfgHelper.get1(cfg_traintowerzhengturewardconfig_get,menuId)
if not taskCfgList then
logErr(FMT.fmt("找不到页签id为{0}对应的试炼奖励列表 请检查配置是否正确",menuId))
return false
end


local isBuyChaozhi=shiLianTaModel:checkShiLianZhengTuIsRechargeByMenuId(menuId)

local nowClearFloor=shiLianTaModel:getClearLayer()
for i,v in pairs(taskCfgList)do
local targetFloor=v.id

local isFinish=nowClearFloor>=targetFloor
if isFinish then
local taskState=shiLianTaModel:checkShiLianZhengTuTaskState(menuId,targetFloor)
if isBuyChaozhi and taskState~=2 or taskState==0 then

return true
end
end
end

return false
end

