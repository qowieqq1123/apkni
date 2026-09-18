









local _MODULENAME="fightBattleHandle"
def_table(_MODULENAME)

fightBattleHandle.name=_MODULENAME
























local battleHandle={

[eBattleType.zongmenMonster]={
showStage=true,
hideExitWatch=true,
resultType=eShowResultType.zongmenMonster,
mulitResultType=eFightMulitResultType.AndVictory,
onStartBattle=function(battle,result,logIdx,guid,id)
isometricMapSystem:enterBattleMode()






end,
onCompleteBattle=function(battle,result,logIdx,showWindow,isReconnet,guid,id)




















end,
onResultComplete=function(battle,result,logIdx,guid,id)












fightController:closeBattle(battle)
end,
onCloseBattle=function(battle,result,logIdx,guid,id)
isometricMapSystem:leaveBattleMode()
local cfg=cfgHelper.get1(cfg_monijyrandomitemconfig_get,id)
local callparams=cfg.callparams
if callparams then
local callType=callparams[1]
if callType==1 then
storyAIManager:startStoryBehavior(callparams[2])
end
end
end,
},

[eBattleType.monsterInvade]={
showStage=true,
hideExitWatch=true,
resultType=eShowResultType.monsterInvade,
mulitResultType=eFightMulitResultType.AndVictory,
onStartBattle=function(battle,result,logIdx,mId)
isometricMapSystem:enterBattleMode()
end,
onCompleteBattle=function(battle,result,logIdx,showWindow,isReconnet,mId)

end,
onResultComplete=function(battle,result,logIdx,mId)
fightController:closeBattle(battle)
end,
onCloseBattle=function(battle,result,logIdx,mId)
isometricMapSystem:leaveBattleMode()
emergenciesControl:endMonsterFight(mId,result)
end,
},

[eBattleType.mystery]={
showStage=true,
hideExitWatch=true,
resultType=eShowResultType.MiJing,
mulitResultType=eFightMulitResultType.AndVictory,
onStartBattle=function(battle,result,logIdx,teamId)
mysteryAIManager:set_mystery_state(true)
UIManager:closeWindow("UIWorldBossWin")
if result==fightResultType.Victory then

mysteryFightController:clear_fight_team()
end
end,
onResultComplete=function(battle,result,logIdx,teamId)
fightController:closeBattle(battle)
local isTriggerBattle=false
local triggerData=mysteryTriggerBattle.curTrigger
if triggerData and next(triggerData)then
mysteryTriggerManager.req_4_28(triggerData[1],nil,false,triggerData[2],0)
mysteryTriggerBattle.curTrigger=nil
isTriggerBattle=true
end

if result==fightResultType.Victory then
local fbid=MysteryModel:get_cur_fbid()
if fbid then

mysteryAIManager:update_queue()


MysteryController.send_4_21(fbid)

if not mysteryFightModel:on_rule_callback()then

mysteryEntityController.handle_meet()


mysteryFightController:showFightRewardHUD()
end


UIManager:invokeUIMethod("UIMysteryWin","initTeamList")

mysteryMonsterModel:refresh_all_hud()
end


MysteryGuildOrder:setAutoStart(false)
else
local fbid=MysteryModel:get_cur_fbid()
if fbid then
mysteryFightModel:clear_fight_team()
if MysteryModel:get_fb_progress()>=100 then
MysteryModel:set_fb_finish(eMysteryQuitType.eFinish)
notifySystem:postNotify(notifyConfig.on_mystery_finish,fbid)
MysteryController.send_4_27()
else
if not MysteryModel:canUseAllDisciple(fbid)then
MysteryController:fightCommonDeal()
else


local pos=mysteryPlayerModel:get_last_pos()
if pos then
mysteryPlayerModel:flash(mysteryPlayerModel:get_player_guid(),pos)
end



end
end
end

end
end,
onCompleteBattle=function(battle,result,logIdx,showWindow,isReconnet,teamId)
mysteryPlayerController.resetPlayerPos()
mysteryAIManager:reset_pause()
if result==fightResultType.Victory then

if mysteryFightModel:get_result_queue_size()>0 then

mysteryFightModel:dequeue_result_callback()
return
end

if not MysteryModel:is_enter_Mystery()then
return
end

end

mysteryFightModel:set_fighting(false)
end,
onCloseBattle=function(battle,result,logIdx,teamId)
mysteryAIManager:reset_pause()

notifySystem:postNotify(notifyConfig.on_mystery_fight_complete,result)
end,
},

[eBattleType.worldMonster]={
showStage=true,
hideExitWatch=true,
resultType=eShowResultType.ShiJieGuaiWu,
mulitResultType=eFightMulitResultType.AndVictory,
onStartBattle=function(battle,result,logIdx,posId,posData,rewards)
worldMonsterModel:set_battle(posId,battle)
if result==1 then
worldMonsterModel:remove_fighting_monster(posId)
end
end,
onResultComplete=function(battle,result,logIdx,posId,posData,rewards)
fightController:closeBattle(battle)
end,
onCompleteBattle=function(battle,result,logIdx,showWindow,isReconnet,posId,posData,rewards)
worldMonsterModel:set_battle(posId)
end,
onCloseBattle=function(battle,result,logIdx,posId,posData,rewards)
worldMonsterModel:set_battle(posId)

local unitKey=worldModel:convertUnitKey({worldModel.UNITTYPE.MONSTER,posId})
local taskKey=worldTaskModel:findLastTaskKey_ByTarget(unitKey)
if taskKey then
local task=worldTaskModel:getTask(taskKey)
if task.progress_state<=eWorldTripProgress.Work then
worldTaskController:returnMission(taskKey)
end
end


end,
},

[eBattleType.worldExperience]={
showStage=true,
hideExitWatch=true,
resultType=eShowResultType.LiLianGuaiWu,
mulitResultType=eFightMulitResultType.AndVictory,
onStartBattle=function(battle,result,logIdx,point)
worldExperienceModel:setBattle(battle)
end,
onResultComplete=function(battle,result,logIdx,point)
if worldExperienceModel:checkBattle(battle)then
fightController:closeBattle(battle)
end
end,
onCompleteBattle=function(battle,result,logIdx,showWindow,isReconnet,point)

end,
onCloseBattle=function(battle,result,logIdx,point)
if worldExperienceModel:checkBattle(battle)then
worldExperienceModel:setBattle()
if result==fightResultType.Victory then
worldExperienceController:doContinue()
end
end
end,
},

[eBattleType.worldResPoint]={
showStage=true,
hideExitWatch=true,
resultType=eShowResultType.ZiYuanDianGuaiWu,
mulitResultType=eFightMulitResultType.AndVictory,
onStartBattle=function(battle,result,logIdx,guid,subIdx)
worldResPointFightModel:setBattleData(guid,subIdx,battle)
end,
onResultComplete=function(battle,result,logIdx,guid,subIdx)
fightController:closeBattle(battle)
end,
onCompleteBattle=function(battle,result,logIdx,showWindow,isReconnet,guid,subIdx)
worldResPointFightModel:setBattleData(guid,subIdx)
end,
onCloseBattle=function(battle,result,logIdx,guid,subIdx)
worldResPointFightModel:setBattleData(guid,subIdx)
local unitKey=worldResPointBaseModel:convertUnitKey(guid,subIdx)

local taskKey=worldTaskModel:findLastTaskKey_ByTarget(unitKey)
if taskKey then
local task=worldTaskModel:getTask(taskKey)
if task.progress_state<=eWorldTripProgress.Work then
worldTaskController:returnMission(taskKey)
end
end
end,
},

[eBattleType.wudaotang]={
showStage=true,
hideExitWatch=true,
resultType=eShowResultType.WuDaoTang,
mulitResultType=eFightMulitResultType.AndVictory,
onStartBattle=function(battle,result,logIdx,guid,randjingjieexp)
if result==1 then
wudaotangModel:fightVictory(guid)
end
isometricMapSystem:enterBattleMode()
end,
onResultComplete=function(battle,result,logIdx,guid,randjingjieexp)
fightController:closeBattle(battle)
end,
onCompleteBattle=function(battle,result,logIdx,showWindow,isReconnet,guid,randjingjieexp)

end,
onCloseBattle=function(battle,result,logIdx,guid,randjingjieexp)
isometricMapSystem:leaveBattleMode()
wudaotangController:openWuDaoTang()
end,
},

[eBattleType.doufatai]={
showStage=true,
hideExitWatch=true,
resultType=eShowResultType.DouFaTai,
mulitResultType=eFightMulitResultType.AndVictory,
onStartBattle=function(battle,result,logIdx)
isometricMapSystem:enterBattleMode()
douFaTaiModel.data.fighting=true
end,
onResultComplete=function(battle,result,logIdx)
douFaTaiController.closeBattle(battle)
end,
onCompleteBattle=function(battle,result,logIdx,showWindow,isReconnet)
end,
onCloseBattle=function(battle,result,logIdx)
isometricMapSystem:leaveBattleMode()
douFaTaiModel.data.fighting=false
end,
},

[eBattleType.qiyuEvent]={
showStage=true,
hideExitWatch=true,
resultType=eShowResultType.QiYuEvent,
mulitResultType=eFightMulitResultType.AndVictory,
onStartBattle=function(battle,result,logIdx,sysId,resultCfg)

end,
onResultComplete=function(battle,result,logIdx,sysId,args,nIndex)
fightController:closeBattle(battle)
MysteryEventSystem:fight_result(result,sysId,args.resultCfg)
end,
onCompleteBattle=function(battle,result,logIdx,showWindow,isReconnet,sysId,resultCfg)

end,
onCloseBattle=function(battle,result,logIdx,sysId,resultCfg)

end,
},

[eBattleType.shilianta]={
showStage=function()
return not shiLianTaController.hideStage
end,
hideExitWatch=function(nowLayer)

local layer=nowLayer or shiLianTaModel:getFightingLayer()or shiLianTaModel:getCurLayer()
local hideExitWatch=false
local continueLayer=cfgHelper.get2(cfg_traintowerglobalconfig_get,1,"continueLayer")
if layer<=continueLayer then
hideExitWatch=true
end
return hideExitWatch
end,
clearStage=false,
enterAni=false,
resultType=eShowResultType.ShiLianTa,
launchType=eBattleLaunch.shilianta,
onStartBattle=function(battle,result,logIdx,layer,buildingData,list)
shiLianTaController.onStartBattle(battle,result,logIdx,layer,buildingData,list)
end,
onResultComplete=function(battle,result,logIdx,layer,buildingData,list)
shiLianTaController.onResultComplete(battle,result,logIdx,layer,buildingData,list)
end,
onCompleteBattle=function(battle,result,logIdx,showWindow,isReconnet,layer,buildingData,list)
shiLianTaController.onCompleteBattle(battle,result,logIdx,showWindow,isReconnet,layer,buildingData,list)
end,
onCloseBattle=function(battle,result,logIdx,layer,buildingData,list)
shiLianTaController.onCloseBattle(battle,result,logIdx,layer,buildingData,list)
end,
onBackStageCompleteBattle=function(battle,result,args)
shiLianTaController.onBackStageCompleteBattle(battle,result,args)
end
},

[eBattleType.jiuyouta]={
showStage=function()
return not JiuYouTaController.hideStage
end,
hideExitWatch=false,
clearStage=false,
enterAni=false,
showSkipAllByleftBottom=2,
isCalcTotalStatistics=true,
resultType=eShowResultType.jiuyouta,
launchType=eBattleLaunch.jiuyouta,
onStartBattle=function(battle,result,logIdx,layer,buildingData,list)
JiuYouTaController.onStartBattle(battle,result,logIdx,layer,buildingData,list)
end,
onResultComplete=function(battle,result,logIdx,layer,buildingData,list)
JiuYouTaController.onResultComplete(battle,result,logIdx,layer,buildingData,list)
end,
onCompleteBattle=function(battle,result,logIdx,showWindow,isReconnet,layer,buildingData,list)
JiuYouTaController.onCompleteBattle(battle,result,logIdx,showWindow,isReconnet,layer,buildingData,list)
end,
onCloseBattle=function(battle,result,logIdx,layer,buildingData,list)
JiuYouTaController.onCloseBattle(battle,result,logIdx,layer,buildingData,list)
end,
onBackStageCompleteBattle=function(battle,result,args)
JiuYouTaController.onBackStageCompleteBattle(battle,result,args)
end,
onFightTopHeadBattleEx=function(fightBattle)
return{"UIShiLianTaFightTop",JiuYouTaModel:getFightingLayer()}
end,
},

[eBattleType.worldFamilyJinZhu]={
showStage=true,
hideExitWatch=true,
mulitResultType=eFightMulitResultType.AndVictory,
onStartBattle=function(battle,result,logIdx,world,guid,subType)
end,
onResultComplete=function(battle,result,logIdx,world,guid,subType)
fightController:closeBattle(battle)
end,
onCompleteBattle=function(battle,result,logIdx,showWindow,isReconnet,world,guid,subType)





end,
onCloseBattle=function(battle,result,logIdx,world,guid,subType)


local unitKey=worldXiuZhenJiaZuModel:convertKey(guid)
local taskKey=worldTaskModel:findLastTaskKey_ByTarget(unitKey)
if taskKey then
local task=worldTaskModel:getTask(taskKey)
if task.progress_state<=eWorldTripProgress.Work then
worldTaskController:returnMission(taskKey)
end
end
end,
},

[eBattleType.npcPK]={
showStage=true,
hideExitWatch=true,
resultType=eShowResultType.npcPK,
mulitResultType=eFightMulitResultType.AndVictory,
onStartBattle=function(battle,result,logIdx,npcid,intimacy)

end,
onResultComplete=function(battle,result,logIdx,npcid,intimacy)
fightController:closeBattle(battle)
end,
onCompleteBattle=function(battle,result,logIdx,showWindow,isReconnet,npcid,intimacy)

end,
onCloseBattle=function(battle,result,logIdx,npcid,intimacy)
npcController:finishFight(npcid,result)
end,
},
[eBattleType.tianyuanshouchao]={
showStage=true,
hideExitWatch=true,
resultType=eShowResultType.tianyuanshouchao,
mulitResultType=eFightMulitResultType.AndVictory,
onStartBattle=function(battle,result,logIdx,data)

end,
onResultComplete=function(battle,result,logIdx,data)
fightController:closeBattle(battle)
xianmengController:finishFight_TYSC(result)
end,
onCompleteBattle=function(battle,result,logIdx,showWindow,isReconnet,data)

end,
onCloseBattle=function(battle,result,logIdx,data)

end,
},
[eBattleType.xianmengdigong]={
showStage=true,
hideExitWatch=true,
resultType=eShowResultType.xianmengdigong,
mulitResultType=eFightMulitResultType.AndVictory,
onStartBattle=function(battle,result,logIdx,data)

end,
onResultComplete=function(battle,result,logIdx,data)
fightController:closeBattle(battle)
end,
onCompleteBattle=function(battle,result,logIdx,showWindow,isReconnet,data)

end,
onCloseBattle=function(battle,result,logIdx,data)
xianmengdigongController:finishFight(result,data)
end,
},
[eBattleType.fabaoshilian]={
showStage=true,
hideExitWatch=true,
resultType=eShowResultType.fabaoshilian,
mulitResultType=eFightMulitResultType.AndVictory,
onStartBattle=function(battle,result,logIdx,data)

end,
onResultComplete=function(battle,result,logIdx,data)
fightController:closeBattle(battle)
activitiesController:jump(data.actid,SUB_ACTIVITY_TYPE.eFaBaoShiLian,data.act2id,{jumpIndex=data.monidx})
end,
onCompleteBattle=function(battle,result,logIdx,showWindow,isReconnet,data)

end,
onCloseBattle=function(battle,result,logIdx,data)

end,
},
[eBattleType.tuitu]={
showStage=true,
hideExitWatch=true,
resultType=eShowResultType.tuitu,
mulitResultType=eFightMulitResultType.AndVictory,
onStartBattle=function(battle,result,logIdx,rewardList)

end,
onResultComplete=function(battle,result,logIdx,rewardList)
fightController:closeBattle(battle)
end,
onCompleteBattle=function(battle,result,logIdx,rewardList)
if result==1 then
UILiLianControl:onLevelComplete()
end
end,
onCloseBattle=function(battle,result,logIdx,rewardList)

end,
},
[eBattleType.huanjing]={


showSkipAllByleftBottom=2,
isCalcTotalStatistics=true,
showStage=function()
return not UIHuanJingControl:getAutoFlag()
end,
hideExitWatch=function(param)
local hideExitWatch=false
if param.hstype==0 then
local nextLevel=param.guanqia_id
local continueLayer=cfgHelper.get2(cfg_guanqianewbasicconfig_get,1,"auto_open")
hideExitWatch=nextLevel<=continueLayer
end
return hideExitWatch
end,
fightType=eFightType.eMulti,
resultType=eShowResultType.huanjing,
mulitResultType=eFightMulitResultType.AndVictory,
onStartBattle=function(battle,result,logIdx,param)
if param.hstype~=1 then
UIHuanJingControl:setPlayingBattle(battle)
UIHuanJingControl:clearHud()
UIHuanJingControl:addHouTaiHUD()
end
end,
onResultComplete=function(battle,result,logIdx,param)
fightController:closeBattle(battle)

if param.hstype==1 then
UIHuanJingControl:showDayChallengeWindow()
else
UIHuanJingControl:showLiLianWindow()
if param.pass_result==1 then
local dayChallengeOpenLv=cfgHelper.get2(cfg_guanqianewbasicconfig_get,1,"daily_open")
local jdOpenLv=cfgHelper.get2(cfg_backmountainareabasicconfig_get,1,"open")
if param.guanqia_id==jdOpenLv then
local args={
iconAB="ui/windows/huanjing/huanjing_atlas_pak.ab",
iconName="button_jinditiaozhan_1",
nameAB="ui/windows/huanjing/huanjing_atlas_pak.ab",
nameName="image_houshanjindi_1",
}
UIHuanJingControl:showWindow("UIHuanJingFunOpenWin",args)
elseif param.guanqia_id==dayChallengeOpenLv then
local args={
iconAB="ui/windows/huanjing/huanjing_atlas_pak.ab",
iconName="button_meitiantiaozhan_1",
nameAB="ui/windows/huanjing/huanjing_atlas_pak.ab",
nameName="image_hsmeiritiaozhan_1",
}
UIHuanJingControl:showWindow("UIHuanJingFunOpenWin",args)
end
end
end
end,
onCompleteBattle=function(battleID,result,logIdx,showWindow,isReconnet,param)
if param.hstype==1 then
UIHuanJingControl:setDayChallengeResult(param.guanqia_id,result==1 and 1 or 2)
elseif param.hstype==0 then
UIHuanJingControl:setPlayingBattle()
UIHuanJingControl:clearHud()
UIHuanJingControl:setAutoFlag()
if not showWindow then
if result==fightResultType.Victory then
if not isReconnet then
UIHuanJingControl:onContinue(true,param.guanqia_id)
end
end
end
local continueLayer=cfgHelper.get2(cfg_guanqianewbasicconfig_get,1,"auto_open")
if param.guanqia_id>=continueLayer then
UIHuanJingControl:setChapter(UIHuanJingControl:getChapterById(param.guanqia_id))
end
if result==1 then
UIHuanJingControl:onLevelComplete(param.guanqia_id)
end

xiaodaotongModel:set_daily_time('daily_hssl_time')
end
end,
onCloseBattle=function(battleID,result,logIdx,param)
local battleHandle=fightModel:getBattle(battleID)
if not(battleHandle and battleHandle.isOver)then
UIHuanJingControl:setGuaJILayer(param.guanqia_id)
end
end,
onBackStageCompleteBattle=function(battle,result,args)
UIHuanJingControl.onBackStageCompleteBattle(battle,result,args)
end
},
[eBattleType.lingShanZhengDuo]={
showStage=true,
hideExitWatch=true,
showSkipAllByleftBottom=1,
isCalcTotalStatistics=true,
resultType=eShowResultType.lingShanZhengDuo,
mulitResultType=eFightMulitResultType.AndVictory,
onStartBattle=function(battle,result,logIdx,data)

end,
onResultComplete=function(battle,result,logIdx,data)
fightController:closeBattle(battle)
end,
onCompleteBattle=function(battle,result,logIdx,data)

end,
onCloseBattle=function(battle,result,logIdx,data)
UILSZDControl:showLSZDWinEx({mountId=data.mount_id,areaId=data.area_id,pos=data.pos},true,true)
end,
},
[eBattleType.lingShanZhengDuo2]={
showStage=true,
hideExitWatch=true,
showSkipAllByleftBottom=1,
isCalcTotalStatistics=true,
resultType=eShowResultType.lingShanZhengDuo2,
mulitResultType=eFightMulitResultType.AndVictory,
onStartBattle=function(battle,result,logIdx,data)

end,
onResultComplete=function(battle,result,logIdx,data)
fightController:closeBattle(battle)
end,
onCompleteBattle=function(battle,result,logIdx,data)

end,
onCloseBattle=function(battle,result,logIdx,data)
UILSZDControl:showLSZDWinEx({mountId=data.mount_id,areaId=data.area_id,pos=data.pos},true,true)
end,
},
[eBattleType.worldLeader]={
showStage=true,
hideExitWatch=true,
showSkipAllByleftBottom=1,
isCalcTotalStatistics=true,
resultType=eShowResultType.ShiJieShouLing,
mulitResultType=eFightMulitResultType.AndVictory,
onStartBattle=function(battle,result,logIdx,rewardList,hurt)

end,
onResultComplete=function(battle,result,logIdx,rewardList,hurt)
fightController:closeBattle(battle)
end,
onCompleteBattle=function(battle,result,logIdx,rewardList,hurt)

end,
onCloseBattle=function(battle,result,logIdx,rewardList,hurt)

end,
},
[eBattleType.jiucengyaolou]={
showStage=true,
hideExitWatch=true,
resultType=eShowResultType.JiuCengYaoLou,
mulitResultType=eFightMulitResultType.AndVictory,
launchType=eBattleLaunch.jiucengyaolou,
onStartBattle=function(battle,result,logIdx,data)

end,
onResultComplete=function(battle,result,logIdx,data)
fightController:closeBattle(battle)
local subType=SUB_ACTIVITY_TYPE.eJiuCengYaoLou
local info=activitiesModel:getSubActInfo(data.act_id,subType,data.act2_id)
if info and info:isJXGetReward(data.floor)then
local times=info:getRewardGotTimes(data.floor)
local nextLayer=data.floor
if times>1 then
nextLayer=info:findNotJXClearLayer()or data.floor
end
activitiesController:jump(data.act_id,SUB_ACTIVITY_TYPE.eJiuCengYaoLou,data.act2_id,{jumpIndex=nextLayer})
else
activitiesController:jump(data.act_id,SUB_ACTIVITY_TYPE.eJiuCengYaoLou,data.act2_id,{jumpIndex=data.floor})
end
end,
onCompleteBattle=function(battle,result,logIdx,data)

end,
onCloseBattle=function(battle,result,logIdx,data)

end,
},
[eBattleType.zongmendabi]={
showStage=true,
hideExitWatch=true,
fightType=eFightType.eMulti,
resultType=eShowResultType.zongmendabi,
mulitResultType=eFightMulitResultType.ResultTimes,
onStartBattle=function(battle,result,logIdx,data)

end,
onResultComplete=function(battle,result,logIdx,data)
fightController:closeBattle(battle)
end,
onCompleteBattle=function(battle,result,logIdx,showWindow,isReconnet,data)
local sendExtraArgs=fightModel:getSendExtraArgs(eBattleType.zongmendabi)
if sendExtraArgs.isSkip then
local sub_actInfo=activitiesModel:getSubActInfo(data.act_id,SUB_ACTIVITY_TYPE.eSectCompetition,data.act2_id)
local check=sub_actInfo:checkBattleList()
if not check then
UIManager:invokeUIMethod('UISubAct_zongmendabi_battle_win','rec_matchList')
notifySystem:postNotify(notifyConfig.onActTabReddotChange,SUBACT_DEFINETAB_TYPE.eZongMenDaBi_battle)
end
else
local tab_idx=activitiesModel:getSubActDefineTabIndex(SUBACT_DEFINETAB_TYPE.eZongMenDaBi_battle)
activitiesController:jump(data.act_id,SUB_ACTIVITY_TYPE.eSectCompetition,data.act2_id,{tab_idx=tab_idx})
end
end,
onCloseBattle=function(battle,result,logIdx,data)
local sendExtraArgs=fightModel:getSendExtraArgs(eBattleType.zongmendabi)
if sendExtraArgs.isSkip then
local sub_actInfo=activitiesModel:getSubActInfo(data.act_id,SUB_ACTIVITY_TYPE.eSectCompetition,data.act2_id)
local check=sub_actInfo:checkBattleList()
if not check then
UIManager:invokeUIMethod('UISubAct_zongmendabi_battle_win','rec_matchList')
notifySystem:postNotify(notifyConfig.onActTabReddotChange,SUBACT_DEFINETAB_TYPE.eZongMenDaBi_battle)
end
else
local tab_idx=activitiesModel:getSubActDefineTabIndex(SUBACT_DEFINETAB_TYPE.eZongMenDaBi_battle)
activitiesController:jump(data.act_id,SUB_ACTIVITY_TYPE.eSectCompetition,data.act2_id,{tab_idx=tab_idx})
end
end,
onFightTopHeadBattle=function(battle)
local extra=battle:getSendExtraArgs()
return extra
end,
},
[eBattleType.lingxuwenjian]={
showStage=true,
hideExitWatch=true,
fightType=eFightType.eMulti,
resultType=eShowResultType.lingxuwenjian,
mulitResultType=eFightMulitResultType.ResultTimes,
onStartBattle=function(battle,result,logIdx,data)

end,
onResultComplete=function(battle,result,logIdx,data)
fightController:closeBattle(battle)
end,
onCompleteBattle=function(battle,result,logIdx,showWindow,isReconnet,data)

end,
onCloseBattle=function(battle,result,logIdx,data)

local jumpParam={openPos={1,data.lxwjtype,nil}}
limitActivitiesController:jump(LIMIT_ACT_TYPE.eLingXuWenJian,jumpParam)
end,
onFightTopHeadBattle=function(battle)
local extra=battle:getSendExtraArgs()
return extra
end,
},

[eBattleType.lingxuwenjian2]={
showStage=true,
hideExitWatch=true,
fightType=eFightType.eMulti,
mulitResultType=eFightMulitResultType.ResultTimes,
onFightTopHeadBattle=function(battle)
local extra=battle:getSendExtraArgs()
return extra
end,
},

[eBattleType.lingxuwenjian3]={
showStage=true,
hideExitWatch=true,
fightType=eFightType.eMulti,
mulitResultType=eFightMulitResultType.ResultTimes,
onFightTopHeadBattle=function(battle)
local extra=battle:getSendExtraArgs()
return extra
end,
},
[eBattleType.xianfawendao]={
showStage=true,
hideExitWatch=true,
fightType=eFightType.eMulti,
resultType=eShowResultType.xianfawendao,
mulitResultType=eFightMulitResultType.ResultTimes,
onStartBattle=function(battle,result,logIdx,data)

end,
onResultComplete=function(battle,result,logIdx,data)
UIXianFaWenDaoControl:setRank(data.rank)
UIXianFaWenDaoControl:addTimes()
UIXianFaWenDaoControl:addMoneyNum(data.moneynum)
fightController:closeBattle(battle)

if data.target>0 then
UIXianFaWenDaoControl:showXianFaWenDaoWin()
UIXianFaWenDaoControl:reqRecordList()
else
UIXianFaWenDaoControl:showXianFaWenDaoChallengeWin({data.score})
end
UIXianFaWenDaoControl:setScore(data.score)
end,
onCompleteBattle=function(battle,result,logIdx,showWindow,isReconnet,data)
UIXianFaWenDaoControl:reqMatching()
end,
onCloseBattle=function(battle,result,logIdx,data)
if data.target>0 then
UIXianFaWenDaoControl:showXianFaWenDaoWin()
UIXianFaWenDaoControl:reqRecordList()
else
UIXianFaWenDaoControl:showXianFaWenDaoChallengeWin()
end
end,
onFightTopHeadBattle=function(battle)
local extra=battle:getSendExtraArgs()
return extra
end,
},
[eBattleType.yunchengtanbao]={
showStage=true,
hideExitWatch=true,

resultType=eShowResultType.yunchengtanbao,
mulitResultType=eFightMulitResultType.AndVictory,
onStartBattle=function(battle,result,logIdx,data)

end,
onResultComplete=function(battle,result,logIdx,data)
fightController:closeBattle(battle)
end,
onCompleteBattle=function(battle,result,logIdx,showWindow,isReconnet,data)

end,
onCloseBattle=function(battle,result,logIdx,data)



local sub_actInfo=activitiesModel:getSubActInfo(data[3],SUB_ACTIVITY_TYPE.eCloudCityTreasure,data[2])
local autojump=sub_actInfo:isfrightAuto()

jumpManager:jump({id=JUMP_TYPE.eActivity,args={subType=SUB_ACTIVITY_TYPE.eCloudCityTreasure,subid=data[2],extraParams={autojump=autojump}}},function()
jumpManager:clearJump()
end)
end,
},
[eBattleType.lundaodahuiJueSai]={
showStage=true,
hideExitWatch=true,
fightType=eFightType.eMulti,
mulitResultType=eFightMulitResultType.ResultTimes,
onFightTopHeadBattle=function(battle)
local extra=battle:getSendExtraArgs()
return extra
end,
},
[eBattleType.qiecuo]={
showStage=true,
hideExitWatch=true,

resultType=eShowResultType.qiecuo,
mulitResultType=eFightMulitResultType.AndVictory,
onStartBattle=function(battle,result,logIdx,data)


local selfName=playerModel:getActorName()
local selficonInfo=playerModel:getActorIconInfo()

local otheractorid=data[3]
local otherName=otherPlayerModel:getActorData(otheractorid).name
local othericonInfo=otherPlayerModel:getActorData(otheractorid).iconInfo

local winArgs={selfName,selficonInfo,otherName,othericonInfo}
UIManager:showWindow('UIQieCuoPlayBackWin',winArgs)

end,
onResultComplete=function(battle,result,logIdx,data)
fightController:closeBattle(battle)
end,
onCompleteBattle=function(battle,result,logIdx,showWindow,isReconnet,data)
UIManager:closeWindow('UIQieCuoPlayBackWin')
end,
onCloseBattle=function(battle,result,logIdx,data)

local cbtype=DiZiDuelModel:getCallBackType()
if cbtype then
local otherseverid=data[2]
local otherid=data[3]
local cbfun=DiZiDuelModel:getCallBackFun(cbtype,otherid,otherseverid)
if cbfun then
cbfun()
end
DiZiDuelModel:setCallBackType(false)
end
end,
},
[eBattleType.wuxingdian]={
showStage=function()
return not wuXingDianController:isInBackFight()
end,
hideExitWatch=function(data)
return wuXingDianController:isHideExitBtn(data)
end,
clearStage=false,
resultType=eShowResultType.wuxingdian,
mulitResultType=eFightMulitResultType.AndVictory,
launchType=eBattleLaunch.wuxingdian,
onStartBattle=function(battle,result,logIdx,data)
wuXingDianController:onStartBattle(battle,result,logIdx,data)
end,
onResultComplete=function(battle,result,logIdx,data)
wuXingDianController:onResultComplete(battle,result,logIdx,data)
end,
onCompleteBattle=function(battle,result,logIdx,showWindow,isReconnet,data)
wuXingDianController:onCompleteBattle(battle,result,logIdx,showWindow,isReconnet,data)

xiaodaotongModel:set_daily_time('daily_wxt_time')
end,
onCloseBattle=function(battle,result,logIdx,data)
wuXingDianController:onCloseBattle(battle,result,logIdx,data)
end,
onOpenPlayingBattle=function(battle)
wuXingDianController:onOpenPlayingBattle(battle)
end,
},
[eBattleType.tianmoruqin_tm]={
showStage=true,
hideExitWatch=true,
resultType=eShowResultType.TianMoRuQin_TianMo,
mulitResultType=eFightMulitResultType.AndVictory,
onStartBattle=function(battle,result,logIdx,data)

end,
onResultComplete=function(battle,result,logIdx,data)
fightController:closeBattle(battle)
end,
onCompleteBattle=function(battle,result,logIdx,showWindow,isReconnet,data)

end,
onCloseBattle=function(battle,result,logIdx,data)
local actId=data.actid
local subId=data.act2id
local monsterGuid=data.mongroupguid
local monsterId=data.mongroupid
local totaldamage=data.totaldamage
local subActInfo=activitiesModel:getSubActInfo(actId,SUB_ACTIVITY_TYPE.eTianMoRuQin,subId)
if subActInfo and subActInfo:checkDoing()then
local jumpInfo=subActInfo:popFightMonsterJump(monsterGuid)
if jumpInfo then
local jumpType=jumpInfo[2]
local jumpParam=jumpInfo[3]

local monsterCfg=cfgHelper.get1(cfg_monstergroup_get,monsterId)
local monType=monsterCfg.monType
local maxBlood=subActInfo:getMaxBloods(monType)
local maxBloodNum=tonumber(tostring(maxBlood))
local damageNum=tonumber(tostring(totaldamage))
local isLive=damageNum<maxBloodNum

local index=subActInfo:findMonsterIndex(monsterGuid)
if isLive and index then
local monsterData=subActInfo:getMonsterData(index)
local share=subActInfo:checkShareChannel(monType,monsterData.shareFlag)
if share>0 then
call_activitiesHandle_func("activitiesHandle_tianmoruqin","reqShareMonster",actId,subId,monsterGuid,share)
end
end

subActInfo:jumpAfterFight(monsterGuid,jumpType,jumpParam,isLive)
end
end
end,
},
[eBattleType.tianmoruqin_sj]={
showStage=true,
hideExitWatch=true,
resultType=eShowResultType.TianMoRuQin_ShiJian,
mulitResultType=eFightMulitResultType.AndVictory,
onStartBattle=function(battle,result,logIdx,data)

end,
onResultComplete=function(battle,result,logIdx,data)
fightController:closeBattle(battle)
end,
onCompleteBattle=function(battle,result,logIdx,showWindow,isReconnet,data)

end,
onCloseBattle=function(battle,result,logIdx,data)

end,
},
[eBattleType.yunyouMerchant]={
showStage=true,
hideExitWatch=true,
resultType=eShowResultType.yunyouMerchant,
mulitResultType=eFightMulitResultType.AndVictory,
onStartBattle=function(battle,result,logIdx,data)

end,
onResultComplete=function(battle,result,logIdx,data)
fightController:closeBattle(battle)
end,
onCompleteBattle=function(battle,result,logIdx,showWindow,isReconnet,data)

end,
onCloseBattle=function(battle,result,logIdx,data)
local current=yunyouMerchantModel:getData()
local fTimes=data.refreshTimes
local cTimes=current.refreshTimes
if fTimes~=cTimes then
UIManager.info(FMT.fmt("{0}已刷新",systemConfig.getSystemName(SYSTEM_DEFINE.eBusiness)))
else
UIFullYunYouMerchantControl:showMainWindow()
end
end,
},
[eBattleType.qieshishenshou]={
showStage=true,
hideExitWatch=true,
resultType=eShowResultType.qieshishenshou,
mulitResultType=eFightMulitResultType.AndVictory,
onStartBattle=function(battle,result,logIdx,data)
UIManager:showWindow('UIQSSSInfoWin',data)
end,
onResultComplete=function(battle,result,logIdx,data)
UIManager:closeWindow('UIQSSSInfoWin')
fightController:closeBattle(battle)
local sdata={data.actId,data.subType,data.subId}
local isCanReceive=FreeGiftController.GetFreeGift(data.rwId,sdata)
if isCanReceive then
FreeGiftController.SendFreeGift(data.rwId,sdata,function()
reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,data.subType)
end)
end
end,
onCompleteBattle=function(battle,result,logIdx,showWindow,isReconnet,data)
tipsManager.closeTips()
end,
onCloseBattle=function(battle,result,logIdx,data)
local other={index=data.index}
activitiesController:jump(data.actId,data.subType,data.subId,other)
end,
},
[eBattleType.taigushilian]={
showStage=true,
hideExitWatch=true,
resultType=eShowResultType.taigushilian,
mulitResultType=eFightMulitResultType.AndVictory,

showSkipAllByleftBottom=1,
playmoveAni=true,
isCalcTotalStatistics=true,
onStartBattle=function(battle,result,logIdx,data)

end,
onResultComplete=function(battle,result,logIdx,data)
fightController:closeBattle(battle)
end,
onCompleteBattle=function(battle,result,logIdx,showWindow,isReconnet,data)

end,
onCloseBattle=function(battle,result,logIdx,data)


local subtype=SUB_ACTIVITY_TYPE.eTaiGuShiLian
local subid=data[3]
local extraParams={
jumpbossid=data[4]or 1,
isopentiaozhan=true
}
jumpManager:jump({id=JUMP_TYPE.eActivity,args={subType=subtype,subid=subid,extraParams=extraParams}},function()
jumpManager:clearJump()
end)
end,
},
[eBattleType.visitorchallenge]={
showStage=true,
hideExitWatch=true,
resultType=eShowResultType.visitorchallenge,
mulitResultType=eFightMulitResultType.AndVictory,
onStartBattle=function(battle,result,logIdx,data)

end,
onResultComplete=function(battle,result,logIdx,data)
fightController:closeBattle(battle)
end,
onCompleteBattle=function(battle,result,logIdx,showWindow,isReconnet,data)

end,
onCloseBattle=function(battle,result,logIdx,data)


if data and data.fight_res==1 then
zmvisitchallengeModel:addCurrentLevel()
end
UIFullZMVisitChallengeControl:showZMVisitChallengeWin()
end,
},
[eBattleType.fuyaoshilian]={
showStage=true,
hideExitWatch=true,
resultType=eShowResultType.fuyaoshilian,
mulitResultType=eFightMulitResultType.AndVictory,
onStartBattle=function(battle,result,logIdx,data)

end,
onResultComplete=function(battle,result,logIdx,data)
fightController:closeBattle(battle)
end,
onCompleteBattle=function(battle,result,logIdx,showWindow,isReconnet,data)

end,
onCloseBattle=function(battle,result,logIdx,data)


local subtype=SUB_ACTIVITY_TYPE.eFuYaoShiLian
local subid=data[3]
local extraParams={
jumpbossid=data[4]or 1,
isopentiaozhan=true
}
jumpManager:jump({id=JUMP_TYPE.eActivity,args={subType=subtype,subid=subid,extraParams=extraParams}},function()
jumpManager:clearJump()
end)
end,
},
[eBattleType.zhengzhanshanhailog]={
showStage=true,
hideExitWatch=true,

mulitResultType=eFightMulitResultType.AndVictory,
onStartBattle=function(battle,result,logIdx,data)

end,
onResultComplete=function(battle,result,logIdx,data)

end,
onCompleteBattle=function(battle,result,logIdx,showWindow,isReconnet,data)

end,
onCloseBattle=function(battle,result,logIdx,data)

end,
},
[eBattleType.xianjielog]={
showStage=true,
hideExitWatch=true,

mulitResultType=eFightMulitResultType.AndVictory,
onStartBattle=function(battle,result,logIdx,data)

end,
onResultComplete=function(battle,result,logIdx,data)

end,
onCompleteBattle=function(battle,result,logIdx,showWindow,isReconnet,data)

end,
onCloseBattle=function(battle,result,logIdx,data)

end,
},
[eBattleType.houshanzhenling]={
showStage=true,
hideExitWatch=true,
resultType=eShowResultType.houshanzhenling,
mulitResultType=eFightMulitResultType.AndVictory,
onStartBattle=function(battle,result,logIdx,data)

local cfg=cfgHelper.get2(cfg_houshanzhenlingjiecengconfig_get,data.zlType,data.layer)
UIFullFightControl:showWindow("UIHouShanZhenLingFightTop",cfg.name)
end,
onResultComplete=function(battle,result,logIdx,data)

fightController:closeBattle(battle)
end,
onCompleteBattle=function(battle,result,logIdx,showWindow,isReconnet,data)

if data.fighttype==eBattleLaunch.houshanzhenling then
if result==1 then
UIHuanJingControl:updateZLData(data.zlType,data.layer)
end
end
end,
onCloseBattle=function(battle,result,logIdx,data)

local temp={}
temp.selectType=data.zlType
temp.selectLayer=data.layer
UIHuanJingControl:showZhenLingWindow(temp)
end,
},
[eBattleType.longhuxiangyao]={
showStage=true,
hideExitWatch=true,
resultType=eShowResultType.longhuxiangyao,
mulitResultType=eFightMulitResultType.AndVictory,
onStartBattle=function(battle,result,logIdx,data)

if result==fightResultType.Victory then
local actID=data.actid
local subID=data.act2id
call_activitiesHandle_func("activitiesHandle_longhuxiangyao","RecvBattle_Victory",actID,subID)
end
end,
onResultComplete=function(battle,result,logIdx,data)

fightController:closeBattle(battle)
end,
onCompleteBattle=function(battle,result,logIdx,showWindow,isReconnet,data)

end,
onCloseBattle=function(battle,result,logIdx,data)

local actID=data.actid
local subID=data.act2id
call_activitiesHandle_func("activitiesHandle_longhuxiangyao","OpenActivityMainWin",actID,subID,{result=result})
end,
},
[eBattleType.systemZongMenDefense]={
showStage=true,
hideExitWatch=true,
mulitResultType=eFightMulitResultType.AndVictory,
onStartBattle=function(battle,result,logIdx,data)

end,
onResultComplete=function(battle,result,logIdx,data)

end,
onCompleteBattle=function(battle,result,logIdx,showWindow,isReconnet,data)

end,
onCloseBattle=function(battle,result,logIdx,data)

end,
onFightTopHeadBattleEx=function(fightBattle)
return{"UISystemZongMenFightRoundWin",{battle=fightBattle.id}}
end,
},
[eBattleType.systemZongMenAttack]={
showStage=true,
hideExitWatch=true,
mulitResultType=eFightMulitResultType.AndVictory,
onStartBattle=function(battle,result,logIdx,data)

end,
onResultComplete=function(battle,result,logIdx,data)

end,
onCompleteBattle=function(battle,result,logIdx,showWindow,isReconnet,data)

end,
onCloseBattle=function(battle,result,logIdx,data)

end,
onFightTopHeadBattleEx=function(fightBattle)
return{"UISystemZongMenFightRoundWin",{battle=fightBattle.id}}
end,
},
[eBattleType.sifangpingyao]={
showStage=true,
hideExitWatch=true,
resultType=eShowResultType.sifangpingyao,
mulitResultType=eFightMulitResultType.AndVictory,
onStartBattle=function(battle,result,logIdx,data)

if result~=1 then
SiFangPingYaoModel:setdoingpointid(0)
SiFangPingYaoModel:setfightresult(result)
else
SiFangPingYaoModel:setfightresult(result)
end
end,
onResultComplete=function(battle,result,logIdx,data)

if result~=1 then
SiFangPingYaoModel:setdoingpointid(0)
SiFangPingYaoModel:setfightresult(result)
UIFullSiFangPingYaoControl:showSiFangPingYaoMainWinNoCloud()
fightController:closeBattle(battle)
else






SiFangPingYaoModel:setfightresult(result)
UIFullSiFangPingYaoControl:showSiFangPingYaoMainWinNoCloud()
fightController:closeBattle(battle)


end
end,
onCompleteBattle=function(battle,result,logIdx,showWindow,isReconnet,data)

end,
onCloseBattle=function(battle,result,logIdx,data)

end,
},
[eBattleType.dujiexiandan]={
showStage=true,
hideExitWatch=true,
resultType=eShowResultType.dujiexiandan,

onStartBattle=function(battle,result,logIdx,data)

end,
onResultComplete=function(battle,result,logIdx,data)
fightController:closeBattle(battle)

if result==1 then

jctjDuJieXianDanController:playBattlePlot()
jctjDuJieXianDanModel:setNextJieDuanAfterFight()
jctjDuJieXianDanController:deleteEntity(mapIdType.zhufeng)

taskController.DuJieXianDanJieDuanChange()
end
end,
onCompleteBattle=function(battle,result,logIdx,showWindow,isReconnet,data)

end,
onCloseBattle=function(battle,result,logIdx,data)


end,
},
[eBattleType.chisejindi]={
showStage=true,
hideExitWatch=true,
resultType=eShowResultType.chisejindi,
onStartBattle=function(battle,result,logIdx,data)

end,
onResultComplete=function(battle,result,logIdx,data)
local actId=data.act_id
local subType=SUB_ACTIVITY_TYPE.eChiSeJinDi
local subId=data.act2_id
local info=activitiesModel:getSubActInfo(actId,subType,subId)
if info and info:checkDoing()then
UIManager:showWindow("UIFightPrepareLoading",{
startCallback=function()

fightController:closeBattle(battle)
end
})
end
end,
onCompleteBattle=function(battle,result,logIdx,showWindow,isReconnet,data)

end,
onCloseBattle=function(battle,result,logIdx,data)
local actId=data.act_id
local subType=SUB_ACTIVITY_TYPE.eChiSeJinDi
local subId=data.act2_id
local info=activitiesModel:getSubActInfo(actId,subType,subId)
if info and info:checkDoing()then
local extraParams={
autoContinue=true
}
activitiesController:jump(actId,subType,subId,extraParams)
else
if UIManager:isActive("UIFightPrepareLoading")then
UIManager:invokeUIMethod("UIFightPrepareLoading","endAni")
end
end
end,
},
[eBattleType.zhenyaoshilian]={
showStage=true,
hideExitWatch=true,
resultType=eShowResultType.zhenyaoshilian,
onStartBattle=function(battle,result,logIdx,data)
end,
onResultComplete=function(battle,result,logIdx,data)
fightController:closeBattle(battle)
end,
onCompleteBattle=function(battle,result,logIdx,showWindow,isReconnet,data)

end,
onCompleteBattleDelay=function(battle)
FightBossBoxHUD:clearBox()
return 2
end,
onCloseBattle=function(battle,result,logIdx,data)
local actId=data.actid
local subType=SUB_ACTIVITY_TYPE.eZhenYaoShiLian
local subId=data.act2id
local bossIdx=data.boss_idx
local boxCnt=data.baoxian_cnt

activitiesHandle_zhenyaoshilian:setChallenge_cnt(actId,subId,1)
activitiesHandle_zhenyaoshilian:setMemoryBossIdx(bossIdx)

local cnt=activitiesHandle_zhenyaoshilian:getBossBoxCnt(actId,subId,bossIdx)
if not cnt or cnt==0 or boxCnt>cnt then
activitiesHandle_zhenyaoshilian:setBossBoxCnt(actId,subId,bossIdx,boxCnt)
end

local info=activitiesModel:getSubActInfo(actId,subType,subId)
if info then
activitiesController:jump(actId,subType,subId)
end
end,
},
[eBattleType.tianmojie]={
showStage=true,
hideExitWatch=true,
resultType=eShowResultType.tianmojie,
onStartBattle=function(battle,result,logIdx,data)
if playerModel:checkActorId(data.actorid)then
local endTime=timeHelper.convertShortStamp(timeHelper.getTodayZeroStamp()+86400)
local battle=fightModel:getBattle(battle)
local leftEntities=battle.fightInfo[fightReportTag.attack]
for index,rawData in ipairs(leftEntities)do
if rawData[fightEntityTag.typo]==0 then
local rawAttr=rawData[fightEntityTag.attr]
if rawAttr then
local map=fightModel:remapEntityAttr(rawAttr)
local dis_guid=map[entityAttr.id]
UIDiscipleController:setDiscipleSign(dis_guid,dzSignType.eTianMoJie,endTime)
end
end
end
end
end,
onResultComplete=function(battle,result,logIdx,data)
fightController:closeBattle(battle)
end,
onCompleteBattle=function(battle,result,logIdx,showWindow,isReconnet,data)

end,
onCloseBattle=function(battle,result,logIdx,data)
if data.newpercent<=0 then
if playerModel:checkActorId(data.actorid)then
tianMoJieController:deadEntity(mapIdType.zhufeng,data.tmguid)
elseif visitControl:isCurrentActor(data.actorid)then
tianMoJieController:deadEntity(mapIdType.zhufeng_hy,data.tmguid)
end
end
end,
},
[eBattleType.xunbaoshilian]={
showStage=true,
hideExitWatch=true,
resultType=eShowResultType.xunbaoshilian,
mulitResultType=eFightMulitResultType.AndVictory,
onStartBattle=function(battle,result,logIdx,rewardList)

end,
onResultComplete=function(battle,result,logIdx,data)
fightController:closeBattle(battle)
local chapterId=data.chapter_id
local levelIdx=data.training_idx
local isHardFlag=data.is_difficulty
local modeId=isHardFlag==1 and XBSL_DIFFICULTY_MODE.Hard or XBSL_DIFFICULTY_MODE.Normal
UIFullBaoLingShuControl:showXunBaoShiLianWindow({args={chapterId=chapterId,standLevelIdx=levelIdx,modeId=modeId}})
end,
onCompleteBattle=function(battle,result,logIdx,showWindow,isReconnet,data)
if result==1 then
local chapterId=data.chapter_id
local levelIdx=data.training_idx
local isHardFlag=data.is_difficulty
xunBaoShiLianController:onLevelComplete(chapterId,levelIdx,isHardFlag)
end
end,
onCloseBattle=function(battle,result,logIdx,data)
local chapterId=data.chapter_id
local levelIdx=data.training_idx
local isHardFlag=data.is_difficulty
local modeId=isHardFlag==1 and XBSL_DIFFICULTY_MODE.Hard or XBSL_DIFFICULTY_MODE.Normal
UIFullBaoLingShuControl:showXunBaoShiLianWindow({args={chapterId=chapterId,standLevelIdx=levelIdx,modeId=modeId}})
end,
},
[eBattleType.wengdingcangqiong]={
showStage=true,
showSkipAll=true,
fightType=eFightType.eMulti,

mulitResultType=eFightMulitResultType.ResultTimes,
onStartBattle=function(battle,result,logIdx,rewardList)
end,
onResultComplete=function(battle,result,logIdx,data)
fightController:closeBattle(battle)
end,
onCompleteBattle=function(battle,result,logIdx,showWindow,isReconnet,data)
end,
onCloseBattle=function(battle,result,logIdx,data)
end,




onFightTopHeadBattleEx=function(battle)

local headArgs=battle:getSendExtraArgs()

local player1=headArgs.player1 or{}
local player2=headArgs.player2 or{}
local logIdList=headArgs.logIdList
local leftId=battle:getLeftActorId()
local rightId=battle:getRightActorId()

local showWinTimes=true
if headArgs.showWinTimes~=nil then
showWinTimes=headArgs.showWinTimes
end
local winArgs={player1[1],player1[2],player2[1],player2[2],battle=battle}
winArgs.leftId=leftId
winArgs.rightId=rightId
winArgs.hideFlag=headArgs.hideFlag
winArgs.logIdList=logIdList
winArgs.showWinTimes=showWinTimes
return{"UIWDCQPlayBackWin",winArgs}
end,
},
[eBattleType.wdcqxiweisai]={
showStage=true,
hideExitWatch=true,
fightType=eFightType.eMulti,
resultType=eShowResultType.wdcqxiweisai,
mulitResultType=eFightMulitResultType.ResultTimes,
onStartBattle=function(battle,result,logIdx,data)

end,
onResultComplete=function(battle,result,logIdx,data)
local sendExtraArgs=fightModel:getSendExtraArgs(eBattleType.wdcqxiweisai)
if sendExtraArgs and sendExtraArgs.loading then
UIFullWenDingCangQiongControl:showHaiXuanWin({loading=true})
else
UIFullWenDingCangQiongControl:showHaiXuanWin()
end
fightController:closeBattle(battle)

end,
onCompleteBattle=function(battle,result,logIdx,showWindow,isReconnet,data)
XiWeiSaiController.onCompleteBattle(result,data)

end,
onCloseBattle=function(battle,result,logIdx,data)

end,
onFightTopHeadBattle=function(battle)
local extra=battle:getSendExtraArgs()
return extra
end,
},
[eBattleType.xianjiefumo]={
showStage=true,
hideExitWatch=true,
showSkipAllByleftBottom=1,
isCalcTotalStatistics=true,
resultType=eShowResultType.xianjiefumo,
mulitResultType=eFightMulitResultType.AndVictory,
onStartBattle=function(battle,result,logIdx,rewardList,hurt)

end,
onResultComplete=function(battle,result,logIdx,rewardList,hurt)
fightController:closeBattle(battle)
end,
onCompleteBattle=function(battle,result,logIdx,rewardList,hurt)

end,
onCloseBattle=function(battle,result,logIdx,rewardList,hurt)

end,
},
[eBattleType.xianguanwuxuan]={
showStage=true,
hideExitWatch=true,
mulitResultType=eFightMulitResultType.AndVictory,
onStartBattle=function(battle,result,logIdx,data)

end,
onResultComplete=function(battle,result,logIdx,data)

end,
onCompleteBattle=function(battle,result,logIdx,showWindow,isReconnet,data)

end,
onCloseBattle=function(battle,result,logIdx,data)

end,
},
[eBattleType.gubaoshilian]={
showStage=true,
hideExitWatch=true,
resultType=eShowResultType.gubaoshilian,
mulitResultType=eFightMulitResultType.AndVictory,
onStartBattle=function(battle,result,logIdx,data)
UIFullFightControl:showWindow("UIShiLianTaFightTop",data.layer)
end,
onResultComplete=function(battle,result,logIdx,data)
fightController:closeBattle(battle)
end,
onCompleteBattle=function(battle,result,logIdx,showWindow,isReconnet,data)

end,
onCloseBattle=function(battle,result,logIdx,data)
activitiesController:jump(data.actId,data.subType,data.subId)
end,
},
[eBattleType.xingyu]={

















onFightTopHeadBattle=function(battle)
local leftId=battle:getLeftActorId()
local rightId=battle:getRightActorId()
local extra=battle:getSendExtraArgs()
local actorId=playerModel:getActorID()


if extra.checkActorId and rightId and tostring(tonumber(tostring(rightId)))==tostring(tonumber(tostring(actorId)))then

local player2=extra.player2
extra.player2=extra.player1
extra.player1=player2
end

return extra
end,
},
[eBattleType.yanfage]={
showStage=true,
hideExitWatch=true,
resultType=eShowResultType.yanfage,
mulitResultType=eFightMulitResultType.AndVictory,
onStartBattle=function(battle,result,logIdx,data)

end,
onResultComplete=function(battle,result,logIdx,data)
fightController:closeBattle(battle)
end,
onCompleteBattle=function(battle,result,logIdx,showWindow,isReconnet,data)

end,
onCloseBattle=function(battle,result,logIdx,data)

end,
},
[eBattleType.xianjunyanzhen]={
showStage=true,
hideExitWatch=true,
resultType=eShowResultType.xianjunyanzhen,
mulitResultType=eFightMulitResultType.AndVictory,
onStartBattle=function(battle,result,logIdx,data)

end,
onResultComplete=function(battle,result,logIdx,data)
fightController:closeBattle(battle)
end,
onCompleteBattle=function(battle,result,logIdx,showWindow,isReconnet,data)

end,
onCloseBattle=function(battle,result,logIdx,data)

end,
},
[eBattleType.activitiesPushMap]={
showStage=true,
hideExitWatch=true,

resultType=eShowResultType.activitiesPushMap,
mulitResultType=eFightMulitResultType.ResultOneTimes,
onStartBattle=function(battle,result,logIdx,data)

end,
onResultComplete=function(battle,result,logIdx,data)
fightController:closeBattle(battle)
end,
onCompleteBattle=function(battle,result,logIdx,showWindow,isReconnet,data)
fightController:closeBattle(battle)
end,
onCloseBattle=function(battle,result,logIdx,data)
fightController:closeBattle(battle)
end,
},
[eBattleType.xjCaravanEscort]={
showStage=true,
hideExitWatch=true,

resultType=eShowResultType.xjCaravanEscort,
mulitResultType=eFightMulitResultType.AndVictory,
onStartBattle=function(battle,result,logIdx,data)
local shipGuid=data.xianzhou_guid
local robTimes=data.rob_times






xianJieCaravanEscortModel:setSelfEscortData_robTimes(robTimes)
end,
onResultComplete=function(battle,result,logIdx,data)
fightController:closeBattle(battle)
end,
onCompleteBattle=function(battle,result,logIdx,showWindow,isReconnet,data)

end,
onCloseBattle=function(battle,result,logIdx,data)

end,
},
[eBattleType.mingyuanzhusha]={
showStage=true,
hideExitWatch=true,

resultType=eShowResultType.mingyuanzhusha,
mulitResultType=eFightMulitResultType.AndVictory,
onStartBattle=function(battle,result,logIdx,data)
end,
onResultComplete=function(battle,result,logIdx,data)
fightController:closeBattle(battle)
end,
onCompleteBattle=function(battle,result,logIdx,showWindow,isReconnet,data)
fightController:closeBattle(battle)
end,
onCloseBattle=function(battle,result,logIdx,data)
if result~=1 then
myzsController:showFullWin_Cloud()
return
end

local level=data.level
local score=data.score
local discipleListLen=data.disciple_list_len
local discipleList=data.disciple_list
local next_item_list_len=data.next_item_list_len
local next_item_list=data.next_item_list

local callback=function()
myzsModel:parseGroupLevel(level)
myzsModel:insertLevelScore(level,score)
myzsModel:updateDiscipleData(discipleListLen,discipleList)
myzsModel:setCurLevelItemList(next_item_list_len,next_item_list)
end


local params={
isFightBack=true,
fightCallBack=callback,
}
myzsController:showFullWin_Cloud(params)
UIManager.enableMoneyTips(true)
end,
},
}

function fightBattleHandle:getHandle(battleType)
return battleHandle[battleType]
end
