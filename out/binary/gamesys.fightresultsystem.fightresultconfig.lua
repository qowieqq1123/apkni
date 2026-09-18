









local _MODULENAME="fightResultConfig"
def_table(_MODULENAME)

fightResultConfig.name=_MODULENAME









































local _ResultHandle={

[eShowResultType.MiJing]={
[fightResultType.Victory]={
baseWin="UICommonVictoryWin",
extraWin="UIWorldBattleVictoryWin",
extraType=5,
extraWinArgs=function(this,bId,prizeList,param)
return fightResultWinConfig:getExtraWinParam(this.extraWin,this.extraType,prizeList,"\n\n\n<size=24>该敌人身上没有任何有价值的道具</size>")
end,
},
[fightResultType.Lose]={
baseWin="UICommonLoseWin",
extraWin="UIWorldBattleLoseWin",
},
},

[eShowResultType.ShiJieGuaiWu]={
[fightResultType.Victory]={
baseWin="UICommonVictoryWin",
extraWin="UIWorldBattleVictoryWin",
extraType=2,
extraWinArgs=function(this,bId,prizeList,param)
return fightResultWinConfig:getExtraWinParam(this.extraWin,this.extraType,prizeList)
end,
},
[fightResultType.Lose]={
baseWin="UICommonLoseWin",
extraWin="UIWorldBattleLoseWin",
},
},

[eShowResultType.LiLianGuaiWu]={
[fightResultType.Victory]={
baseWin="UICommonVictoryWin",
extraWin="UIWorldBattleVictoryWin",
extraType=2,
extraWinArgs=function(this,bId,prizeList,param)
return fightResultWinConfig:getExtraWinParam(this.extraWin,this.extraType,prizeList)
end,
},
[fightResultType.Lose]={
baseWin="UICommonLoseWin",
extraWin="UIWorldBattleLoseWin",
},
},

[eShowResultType.ZiYuanDianGuaiWu]={
[fightResultType.Victory]={
baseWin="UICommonVictoryWin",
extraWin="UIWorldBattleVictoryWin",
extraType=2,
extraWinArgs=function(this,bId,prizeList,param)
return fightResultWinConfig:getExtraWinParam(this.extraWin,this.extraType,prizeList)
end,
},
[fightResultType.Lose]={
baseWin="UICommonLoseWin",
extraWin="UIWorldBattleLoseWin",
},
},

[eShowResultType.WuDaoTang]={
[fightResultType.Victory]={
baseWin="UICommonVictoryWin",
extraWin="UIWuDaoVictoryWin",
extraType=1,
extraWinArgs=function(this,bId,prizeList,param)
return fightResultWinConfig:getExtraWinParam(this.extraWin,this.extraType,param[1],param[2])
end
},
[fightResultType.Lose]={
baseWin="UICommonLoseWin",
extraWin="UIWorldBattleLoseWin",
},
},

[eShowResultType.DouFaTai]={
[fightResultType.Victory]={
baseWin="UICommonVictoryWin",
baseType=2,



extraWin="UIDouFaTaiVictoryWin",
extraType=1,
extraWinArgs=function(this,bId,prizeList,param)
return fightResultWinConfig:getExtraWinParam(this.extraWin,this.extraType,param[1],prizeList,bId)
end
},
[fightResultType.Lose]={
baseWin="UICommonLoseWin2",
baseType=1,






extraWin="UIDouFaTaiLoseWin",
extraType=1,
extraWinArgs=function(this,bId,prizeList,param)
return fightResultWinConfig:getExtraWinParam(this.extraWin,this.extraType,param[1],prizeList,bId)
end
},
},

[eShowResultType.ShiLianTa]={
[fightResultType.Victory]={
baseWin="UICommonVictoryWin",
baseType=3,
btnsInfo=function(this,bId,param)
return shiLianTaController.onFightResultBaseBtn(this,bId,param)
end,
extraWin="UIShiLianTaVictoryWin",
extraType=1,
extraWinArgs=function(this,bId,prizeList,param)
return shiLianTaController.onFightResultExtraWinArgs(this,bId,prizeList,param)
end,
},
[fightResultType.Lose]={
baseWin="UICommonLoseWin",
extraWin="UIWorldBattleLoseWin",
checkShowSpeFunc=function(this,bId,battleType,btnsInfo,extraWinArgs,fightData,logPackage,param,showWindow)
if not showWindow then
local args={fightData=fightData,extraWinArgs=extraWinArgs,logPackage=logPackage,btnsInfo=btnsInfo,param=param}
shiLianTaModel:setGuaJILoseArgs(args)
msgWinControl:addMsgWin(msgWinType.eShiliantaGuaJi,args)





end
end,
baseType=1,
btnsInfo=function(this,bId,prizeList,param)
local quitCallBack=function()

local func=function()
fightController:closeBattle(bId)
shiLianTaController:showEnterWindow()
end
loadingControl.openCloud(func,nil,true)
end
local continueCallBack=function()
local battle=fightModel:getBattle(bId)
if battle then
battle:hideAllEntity()
battle:stopAllEffect()

end
fightModel:removeBattle(bId)

shiLianTaController:showPrepareWindow()
end
return fightResultWinConfig:getBaseWinParam(this.baseWin,2,'重新挑战',continueCallBack,"退 出",quitCallBack)
end,
},
},

[eShowResultType.jiuyouta]={
[fightResultType.Victory]={
baseWin="UICommonVictoryWin",
baseType=3,
btnsInfo=function(this,bId,param)
return JiuYouTaController.onFightResultBaseBtn(this,bId,param)
end,
extraWin="UIShiLianTaVictoryWin",
extraType=1,
extraWinArgs=function(this,bId,prizeList,param)
return JiuYouTaController.onFightResultExtraWinArgs(this,bId,prizeList,param)
end,
},
[fightResultType.Lose]={
baseWin="UICommonLoseWin",
extraWin="UIWorldBattleLoseWin",
checkShowSpeFunc=function(this,bId,battleType,btnsInfo,extraWinArgs,fightData,logPackage,param,showWindow)
if not showWindow then
local args={fightData=fightData,extraWinArgs=extraWinArgs,logPackage=logPackage,btnsInfo=btnsInfo,param=param}
JiuYouTaModel:setGuaJILoseArgs(args)
msgWinControl:addMsgWin(msgWinType.eJiuYouTa,args)
end
end,
baseType=1,
btnsInfo=function(this,bId,param)
local quitCallBack=function()

local func=function()
fightController:closeBattle(bId)
UIFullJiuYouTaControl:showEnterWindow()
end
loadingControl.openCloud(func,nil,true)
end
local continueCallBack=function()
local battle=fightModel:getBattle(bId)
if battle then
battle:hideAllEntity()
battle:stopAllEffect()

end
fightModel:removeBattle(bId)


JiuYouTaController:showPrepareWindow(param[1])
end
return fightResultWinConfig:getBaseWinParam(this.baseWin,2,'重新挑战',continueCallBack,"退 出",quitCallBack)
end,
},
},

[eShowResultType.zongmenMonster]={
[fightResultType.Victory]={
baseWin="UICommonVictoryWin",
extraWin="UIWorldBattleVictoryWin",
extraType=2,
extraWinArgs=function(this,bId,prizeList,param)
return fightResultWinConfig:getExtraWinParam(this.extraWin,this.extraType,prizeList)
end
},
[fightResultType.Lose]={
baseWin="UICommonLoseWin",
extraWin="UIWorldBattleLoseWin",
},
},

[eShowResultType.monsterInvade]={
[fightResultType.Victory]={
baseWin="UICommonVictoryWin",
extraWin="UIWorldBattleVictoryWin",
extraType=2,
extraWinArgs=function(this,bId,prizeList,param)
return fightResultWinConfig:getExtraWinParam(this.extraWin,this.extraType,prizeList)
end
},
[fightResultType.Lose]={
baseWin="UICommonLoseWin",
extraWin="UIWorldBattleLoseWin",
},
},

[eShowResultType.QiYuEvent]={
[fightResultType.Victory]={
baseWin="UICommonVictoryWin",
extraWin="UIWorldBattleVictoryWin",
extraType=2,
extraWinArgs=function(this,bId,prizeList,param)
return fightResultWinConfig:getExtraWinParam(this.extraWin,this.extraType,prizeList)
end
},
[fightResultType.Lose]={
baseWin="UICommonLoseWin",
extraWin="UIWorldBattleLoseWin",
},
},

[eShowResultType.npcPK]={
[fightResultType.Victory]={
baseWin="UICommonVictoryWin",
extraWin="UINPCPKVictoryWin",
extraType=1,
extraWinArgs=function(this,bId,prizeList,param)
return fightResultWinConfig:getExtraWinParam(this.extraWin,this.extraType,param[1],param[2],prizeList)
end
},
[fightResultType.Lose]={
baseWin="UICommonLoseWin",
extraWin="UIWorldBattleLoseWin",
},
},
[eShowResultType.tianyuanshouchao]={
[fightResultType.Victory]={
baseWin="UICommonVictoryWin",
extraWin="UIXM_TYSC_VictoryWin",
extraType=1,
extraWinArgs=function(this,bId,prizeList,param)
return fightResultWinConfig:getExtraWinParam(this.extraWin,this.extraType,param[1],prizeList)
end
},
[fightResultType.Lose]={
baseWin="UICommonLoseWin",
extraWin="UIWorldBattleLoseWin",
},
},
[eShowResultType.xianmengdigong]={
[fightResultType.Victory]={
baseWin="UICommonVictoryWin",
extraWin="UIXM_XMDG_resultWin",
extraType=1,
extraWinArgs=function(this,bId,prizeList,param)
return fightResultWinConfig:getExtraWinParam(this.extraWin,this.extraType,param[1],prizeList)
end
},
[fightResultType.Lose]={
baseWin="UICommonLoseWin",
extraWin="UIWorldBattleLoseWin",
},
},
[eShowResultType.fabaoshilian]={
[fightResultType.Victory]={
baseWin="UICommonVictoryWin",
extraWin="UIWorldBattleVictoryWin",
extraType=5,
extraWinArgs=function(this,bId,prizeList,bdata)
local data=bdata[1]
local rewards=data.rewards or{}
local tips="\n\n\n<size=24>恭喜挑战成功，可前往活动界面领取奖励！</size>"
return fightResultWinConfig:getExtraWinParam(this.extraWin,this.extraType,rewards,tips)
end
},
[fightResultType.Lose]={
baseWin="UICommonLoseWin",
extraWin="UIWorldBattleLoseWin",
},
},
[eShowResultType.tuitu]={
[fightResultType.Victory]={
baseWin="UICommonVictoryWin",
baseType=3,
btnsInfo=function(this,bId,param)
local continueText='继续挑战'
local continuCallBack=function()
fightResultController:afterShowResult()
UILiLianControl:showLiLianWindow({autoToNext=true})
end
local quitCallBack=function()
fightResultController:afterShowResult()
UILiLianControl:showLiLianWindow()
end
local cd=nil
local clevel=UILiLianControl:getCurrentLevel()
local nlevel=UILiLianControl:getNextLevel()
local hideContinue=nlevel<=clevel
if not hideContinue then
local autoLevel=cfgHelper.get2(cfg_guanqiabasicconfig_get,1,'auto_level')
if nlevel>autoLevel then
continueText='继续'
cd=5
end
end
return fightResultWinConfig:getBaseWinParam(this.baseWin,this.baseType,continueText,
continuCallBack,"退 出",quitCallBack,cd,hideContinue)
end,
extraWin="UITuiTuVictoryWin",
extraType=1,
extraWinArgs=function(this,bId,prizeList,param)
local auto_level=cfgHelper.get2(cfg_guanqiabasicconfig_get,1,'auto_level')
local currLevel=UILiLianControl:getCurrentLevel()
local tips
if currLevel<auto_level then
local lname=UILiLianControl:getLevelName('',auto_level)
tips=FMT.fmt('通关 {0} 开启自动挑战',lname)
end
return fightResultWinConfig:getExtraWinParam(this.extraWin,this.extraType,param[1],tips)
end
},
[fightResultType.Lose]={
baseWin="UICommonLoseWin",
extraWin="UIWorldBattleLoseWin",
baseType=1,
btnsInfo=function(this,bId,prizeList,param)
local quitCallBack=function()
fightResultController:afterShowResult()
UILiLianControl:showLiLianWindow({standLevel=UILiLianControl:getNextLevel()})
end
return fightResultWinConfig:getBaseWinParam(this.baseWin,this.baseType,"关闭",quitCallBack)
end,
},
},
[eShowResultType.huanjing]={
[fightResultType.Victory]={
baseWin="UICommonVictoryWin",
baseType=3,
btnsInfo=function(this,bId,param)
param=param~=nil and param[1]or{}
local continueText='继续挑战'
local continuCallBack=function()
fightResultController:afterShowResult()
if param.hstype==0 then
UIHuanJingControl:onContinue(false,param.guanqia_id)
end
end
local quitCallBack=function()
fightResultController:afterShowResult()

end
local cd=nil

local hideContinue=param.hstype~=0

if param.hstype==0 then
local nextLevel=param.guanqia_id
local continueLayer=cfgHelper.get2(cfg_guanqianewbasicconfig_get,1,"auto_open")
hideContinue=nextLevel<continueLayer
end

if not hideContinue then
cd=5
end

if param.hstype~=1 then
return fightResultWinConfig:getBaseWinParam(this.baseWin,this.baseType,continueText,
continuCallBack,"退 出",quitCallBack,cd,hideContinue)
end
end,
extraWin="UIWorldBattleVictoryWin",
extraType=4,
extraWinArgs=function(this,bId,prizeList,param)
param=param~=nil and param[1]or{}
if param.hstype==1 then
local id=param.guanqia_id
local cfg=cfgHelper.get1(cfg_guanqianewconfig_get,id)
local drops=cfg.daily_reward
local level=zongmenModel:getLevel()
local rewardList=itemsAwardConfig:getAwardInConfigByLevel(drops,level)
return fightResultWinConfig:getExtraWinParam(this.extraWin,3,rewardList.staticItems)
elseif param.hstype==0 then
local str=''
local nextLevel=UIHuanJingControl:getNextLevel(param.guanqia_id)
local continueLayer=cfgHelper.get2(cfg_guanqianewbasicconfig_get,1,"auto_open")
local cha=UIHuanJingControl:getChapterLevel(nextLevel)

if nextLevel<=continueLayer then
local continuecha=UIHuanJingControl:getChapterLevel(continueLayer)
str=FMT.fmt('<color=#843C0C>通关{0}-{1}后开启自动挑战</color>',continuecha[1],continuecha[2])
return fightResultWinConfig:getExtraWinParam(this.extraWin,this.extraType,prizeList,{},str)
else
if cha then
local cha2=UIHuanJingControl:getChapterLevel(param.guanqia_id)
local reward=UIHuanJingControl:getChapterRewardDataCaphater(cha2[1])
local rwLevel=reward.level
local rwCha=UIHuanJingControl:getChapterLevel(rwLevel)

local datas=UIHuanJingControl:getLevelRewardData()
local haveFlag=false
for k,v in pairs(datas)do
local state=UIHuanJingControl:getLevelReceiveState(k)
if state==0 then
haveFlag=true
break
end
end

if rwCha[2]-cha2[2]>0 then
str=FMT.fmt('<color=#843C0C>再挑战{0}关可领取阶段奖励</color>',rwCha[2]-cha2[2])
else
local cha3=UIHuanJingControl:getChapterLevel(nextLevel)
reward=UIHuanJingControl:getChapterRewardDataCaphater(cha3[1])
rwLevel=reward.level
rwCha=UIHuanJingControl:getChapterLevel(rwLevel)
str=FMT.fmt('再挑战{0}关可领取阶段奖励',rwCha[2])
end
if haveFlag then
str=FMT.fmt("<color=#843C0C>{0}\n(当前有奖励未领取)</color>",str)
end
return fightResultWinConfig:getExtraWinParam(this.extraWin,this.extraType,prizeList,{},str)
end
end
end
return fightResultWinConfig:getExtraWinParam(this.extraWin,this.extraType,prizeList)
end
},
[fightResultType.Lose]={
baseWin="UICommonLoseWin",
extraWin="UIWorldBattleLoseWin",
btnsInfo=function(this,bId,param)
param=param~=nil and param[1]or{}
local continueCallBack=function()
local battle=fightModel:getBattle(bId)
if battle then
battle:hideAllEntity()
battle:stopAllEffect()
battle:resumeMusic()

end
fightModel:removeBattle(bId)
UIHuanJingControl:openFighting(param.guanqia_id,param.hstype)
end
local quitCallBack=function()
local func=function()
fightResultController:afterShowResult()

end
loadingControl.openCloud(func,nil,true)
end
return fightResultWinConfig:getBaseWinParam(this.baseWin,2,'重新挑战',continueCallBack,"退 出",quitCallBack)
end,

checkShowSpeFunc=function(this,bId,battleType,btnsInfo,extraWinArgs,fightData,logPackage,param,showWindow)
if not showWindow then
local args={fightData=fightData,extraWinArgs=extraWinArgs,logPackage=logPackage,btnsInfo=btnsInfo,param=param}
UIHuanJingControl:setGuaJILoseArgs(args)
msgWinControl:addMsgWin(msgWinType.eHouShanGuaJi,args)
end
end,
},
},
[eShowResultType.ShiJieShouLing]={
[fightResultType.Victory]={
baseWin="UICommonVictoryWin",
extraWin="UIWorldBattleVictoryWin",
extraType=4,
extraWinArgs=function(this,bId,prizeList,param)
local lastValue=param[2]
local tips=FMT.fmt("本次战斗造成伤害量：<color=#39ba28>{0}</color>",mathHelper.formatNumber4(tonumber(tostring(lastValue)),2))
local rewards=param[1]
return fightResultWinConfig:getExtraWinParam(this.extraWin,this.extraType,rewards,nil,tips)
end,
},
[fightResultType.Lose]={
baseWin="UICommonVictoryWin",
extraWin="UIWorldBattleVictoryWin",
extraType=4,
extraWinArgs=function(this,bId,prizeList,param)
local lastValue=param[2]
local tips=FMT.fmt("本次战斗造成伤害量：<color=#39ba28>{0}</color>",mathHelper.formatNumber4(tonumber(tostring(lastValue)),2))
local rewards=param[1]
return fightResultWinConfig:getExtraWinParam(this.extraWin,this.extraType,rewards,nil,tips)
end,
},
},

[eShowResultType.JiuCengYaoLou]={
[fightResultType.Victory]={
baseWin="UICommonVictoryWin",
extraWin="UIWorldBattleVictoryWin",
extraType=5,
extraWinArgs=function(this,bId,prizeList,bdata)
local data=bdata[1]
local rewards=data.rewards or{}
local canGet=data.canGet

local tips=nil
if canGet then
tips=canGet==1 and"\n\n\n<size=24>恭喜挑战成功，可前往活动界面领取奖励！</size>"or"\n\n\n<size=24>已通关该层，无法再获得首通奖励</size>"
end

return fightResultWinConfig:getExtraWinParam(this.extraWin,this.extraType,rewards,tips)
end
},
[fightResultType.Lose]={
baseWin="UICommonLoseWin",
extraWin="UIWorldBattleLoseWin",
btnsInfo=function(this,bId,param)
param=param~=nil and param[1]or{}
local quitCallBack=function()
fightResultController:afterShowResult()
activitiesController:jump(param.act_id,SUB_ACTIVITY_TYPE.eJiuCengYaoLou,param.act2_id,{jumpIndex=param.floor})
end
local continueCallBack=function()
local subType=SUB_ACTIVITY_TYPE.eJiuCengYaoLou
local serverData=activitiesModel:getSubActInfoData(param.act_id,subType,param.act2_id)
local config=activitiesModel:getSubActivityConfig(subType,param.act2_id)
if serverData and next(serverData)then
local battle=fightModel:getBattle(bId)
if battle then
battle:hideAllEntity()
battle:stopAllEffect()
battle:resumeMusic()
end
fightModel:removeBattle(bId)

local citiaoList=param.citiaoList or{}
local length=#citiaoList
local monsterList=serverData.monidxList or{}
local floor=param.floor
local monsterIdx=monsterList[floor]
local monsterData=config.floor[floor][5][monsterIdx][1]
local monsterCfg=cfgHelper.get(cfg_monstergroup_get,monsterData[1])
fightController.showPrepareWin(eFightPreSelectType.jiucengyaolou,
{
enterTxt='九层妖楼',
skipDiscipleInjuryCheck=true,
skipDiscipleStateCheck=true,
statePriorityCheck=false,
monsterList=monsterCfg.monList,
groupId=monsterData[1],
enterCallBack=function(guidList,zfId)
fightLaunchController:sendFight(eBattleLaunch.jiucengyaolou,guidList,monsterCfg.mapId or 0,zfId,{param.act_id,subType,param.act2_id,param.floor,length,citiaoList})
end,
cancelCallBack=function()
activitiesController:jump(param.act_id,SUB_ACTIVITY_TYPE.eJiuCengYaoLou,param.act2_id,{jumpIndex=param.floor})
end,
})
else
fightResultController:afterShowResult()
end
end
return fightResultWinConfig:getBaseWinParam(this.baseWin,2,'重新挑战',continueCallBack,"退 出",quitCallBack)
end,
},
},
[eShowResultType.lingShanZhengDuo]={
[fightResultType.Victory]={
baseWin="UICommonVictoryWin",
extraWin="UILingShanFightResultWin",
extraType=1,
extraWinArgs=function(this,bId,prizeList,param)
return fightResultWinConfig:getExtraWinParam(this.extraWin,this.extraType,1,param)
end
},
[fightResultType.Lose]={
baseWin="UICommonLoseWin2",
extraWin="UILingShanFightResultWin",
extraType=1,
extraWinArgs=function(this,bId,prizeList,param)
return fightResultWinConfig:getExtraWinParam(this.extraWin,this.extraType,-1,param)
end
}
},
[eShowResultType.lingShanZhengDuo2]={
[fightResultType.Victory]={
baseWin="UICommonVictoryWin",
extraWin="UILingShanFightResultWin",
extraType=1,
extraWinArgs=function(this,bId,prizeList,param)
return fightResultWinConfig:getExtraWinParam(this.extraWin,this.extraType,1,param)
end
},
[fightResultType.Lose]={
baseWin="UICommonLoseWin",
extraWin="UIWorldBattleLoseWin",
},
},
[eShowResultType.zongmendabi]={
[fightResultType.Victory]={
baseWin="UICommonVictoryWin",
extraWin="UISubAct_zongmendabi_result_win",
extraType=1,
extraWinArgs=function(this,bId,prizeList,param)
return fightResultWinConfig:getExtraWinParam(this.extraWin,this.extraType,param[1],prizeList)
end
},
[fightResultType.Lose]={
baseWin="UICommonLoseWin2",
extraWin="UISubAct_zongmendabi_result_win",
extraType=1,
extraWinArgs=function(this,bId,prizeList,param)
return fightResultWinConfig:getExtraWinParam(this.extraWin,this.extraType,param[1],prizeList)
end
},
[fightResultType.Tie]={
baseWin="UICommonTieWin",
extraWin="UISubAct_zongmendabi_result_win",
extraType=1,
extraWinArgs=function(this,bId,prizeList,param)
return fightResultWinConfig:getExtraWinParam(this.extraWin,this.extraType,param[1],prizeList)
end
},
},
[eShowResultType.lingxuwenjian]={
[fightResultType.Victory]={
baseWin="UICommonVictoryWin",
extraWin="UIXM_LXWJ_result_win",
extraType=1,
extraWinArgs=function(this,bId,prizeList,param)
return fightResultWinConfig:getExtraWinParam(this.extraWin,this.extraType,param[1],prizeList)
end
},
[fightResultType.Lose]={
baseWin="UICommonLoseWin2",
extraWin="UIXM_LXWJ_result_win",
extraType=1,
extraWinArgs=function(this,bId,prizeList,param)
return fightResultWinConfig:getExtraWinParam(this.extraWin,this.extraType,param[1],prizeList)
end
},
[fightResultType.Tie]={
baseWin="UICommonTieWin",
extraWin="UIXM_LXWJ_result_win",
extraType=1,
extraWinArgs=function(this,bId,prizeList,param)
return fightResultWinConfig:getExtraWinParam(this.extraWin,this.extraType,param[1],prizeList)
end
},
},
[eShowResultType.lingxuwenjian3]={
[fightResultType.Victory]={
baseWin="UICommonVictoryWin",
extraWin="UIXM_LXWJ_wjresult_win",
extraType=1,
extraWinArgs=function(this,bId,prizeList,param)
return fightResultWinConfig:getExtraWinParam(this.extraWin,this.extraType,param[1],prizeList)
end
},
[fightResultType.Lose]={
baseWin="UICommonLoseWin2",
extraWin="UIXM_LXWJ_wjresult_win",
extraType=1,
extraWinArgs=function(this,bId,prizeList,param)
return fightResultWinConfig:getExtraWinParam(this.extraWin,this.extraType,param[1],prizeList)
end
},
[fightResultType.Tie]={
baseWin="UICommonTieWin",
extraWin="UIXM_LXWJ_wjresult_win",
extraType=1,
extraWinArgs=function(this,bId,prizeList,param)
return fightResultWinConfig:getExtraWinParam(this.extraWin,this.extraType,param[1],prizeList)
end
},
},
[eShowResultType.xianfawendao]={
[fightResultType.Victory]={
baseWin="UICommonVictoryWin",
extraWin="UIXFWDResultWin",
extraType=1,
extraWinArgs=function(this,bId,prizeList,param)
local data=param[1]
return fightResultWinConfig:getExtraWinParam(this.extraWin,this.extraType,UIXianFaWenDaoControl:getFightResultData(data))
end
},
[fightResultType.Lose]={
baseWin="UICommonLoseWin2",
extraWin="UIXFWDResultWin",
extraType=1,
extraWinArgs=function(this,bId,prizeList,param)
local data=param[1]
return fightResultWinConfig:getExtraWinParam(this.extraWin,this.extraType,UIXianFaWenDaoControl:getFightResultData(data))
end
},
},
[eShowResultType.yunchengtanbao]={
[fightResultType.Victory]={
baseWin="UICommonVictoryWin",
extraWin="UIWorldBattleVictoryWin",
extraType=8,
extraWinArgs=function(this,bId,prizeList,param)

local lastValue=param[2]
local tips=FMT.fmt("成功击败盗宝猫，获得以下奖励")
local rewards=param[1][1]
return fightResultWinConfig:getExtraWinParam(this.extraWin,this.extraType,rewards,nil,tips)
end,
},
[fightResultType.Lose]={
baseWin="UICommonLoseWin",
extraWin="UIYCTBBattleLoseWin",
extraType=1,
extraWinArgs=function(this,bId,prizeList,param)
local lastValue=param[2]
local tips=FMT.fmt("获得以下奖励")
local rewards=param[1][1]

return fightResultWinConfig:getExtraWinParam(this.extraWin,this.extraType,{tips,rewards},nil,tips)
end,
},
},
[eShowResultType.qiecuo]={
[fightResultType.Victory]={
baseWin="UICommonVictoryWin",
extraWin="UIWorldBattleVictoryWin",
extraType=9,
extraWinArgs=function(this,bId,prizeList,param)


local myactorid=param[1][1]
local myserverid=param[1][2]
local hisactorid=param[1][3]
local hisserverid=param[1][4]
local isfenxiang=true

local selfFright=nil
local otherFright=nil

local actordata
local name
local selfactordata
local myname
if not hisactorid then
actordata=param[1][5]
name=param[1][6]
selfactordata=param[1][7]
isfenxiang=false
else
actordata=otherPlayerModel:getActorData(hisactorid).iconInfo
name=otherPlayerModel:getActorData(hisactorid).name
selfactordata=playerModel:getActorIconInfo()
selfFright=param[1][5]or nil
otherFright=param[1][6]or nil
end
if not myactorid then
myname=param[1][8]
else
myname=playerModel:getActorName()
end
if param[1][10]and param[1][11]then
selfFright=param[1][10]or nil
otherFright=param[1][11]or nil
end

return fightResultWinConfig:getExtraWinParam(this.extraWin,this.extraType,nil,nil,nil,{myactorid,myserverid,selfactordata,hisactorid,hisserverid,actordata,name,myname,isfenxiang,selfFright,otherFright})
end,
},
[fightResultType.Lose]={
baseWin="UICommonLoseWin",
extraWin="UIQieCuoBattleLoseWin",
extraType=1,
extraWinArgs=function(this,bId,prizeList,param)

local myactorid=param[1][1]
local myserverid=param[1][2]
local hisactorid=param[1][3]
local hisserverid=param[1][4]
local isfenxiang=true

local selfFright=nil
local otherFright=nil

local actordata
local name
local selfactordata
local myname
if not hisactorid then
actordata=param[1][5]
name=param[1][6]
selfactordata=param[1][7]
isfenxiang=false
else
actordata=otherPlayerModel:getActorData(hisactorid).iconInfo
name=otherPlayerModel:getActorData(hisactorid).name
selfactordata=playerModel:getActorIconInfo()
selfFright=param[1][5]or nil
otherFright=param[1][6]or nil
end
if not myactorid then
myname=param[1][8]
else
myname=playerModel:getActorName()
end
if param[1][10]and param[1][11]then
selfFright=param[1][10]or nil
otherFright=param[1][11]or nil
end


return fightResultWinConfig:getExtraWinParam(this.extraWin,this.extraType,{myactorid,myserverid,selfactordata,hisactorid,hisserverid,actordata,name,myname,isfenxiang,selfFright,otherFright})
end,
},
},
[eShowResultType.wuxingdian]={
[fightResultType.Victory]={
baseWin="UICommonVictoryWin",
extraWin="UIWuXingDianBattleVictoryWin",
extraType=1,
btnsInfo=function(this,bId,param)
return wuXingDianController:onFightResultBaseBtn(this,bId,param)
end,
extraWinArgs=function(this,bId,prizeList,param)
prizeList=wuXingDianController:getRewards()
return fightResultWinConfig:getExtraWinParam(this.extraWin,this.extraType,{prizeList,param})
end,
},
[fightResultType.Lose]={
baseWin="UICommonLoseWin",
extraWin="UIWorldBattleLoseWin",
btnsInfo=function(this,bId,param)
return wuXingDianController:onFightFailResultBaseBtn(this,bId,param)
end,
extraWinArgs=function(this,bId,prizeList,param)
prizeList=nil
return fightResultWinConfig:getExtraWinParam(this.extraWin,this.extraType,prizeList)
end,
},
},
[eShowResultType.TianMoRuQin_TianMo]={
[fightResultType.Victory]={
baseWin="UICommonVictoryWin",
extraWin="UIWorldBattleVictoryWin",
extraType=10,
extraWinArgs=function(this,bId,prizeList,param)
local data=param[1]
local subActInfo=activitiesModel:getSubActInfo(data.actid,SUB_ACTIVITY_TYPE.eTianMoRuQin,data.act2id)
if subActInfo and subActInfo:checkDoing()then
local monsterCfg=cfgHelper.get1(cfg_monstergroup_get,data.mongroupid)
local monType=monsterCfg.monType
local maxBlood=tonumber(tostring(subActInfo:getMaxBloods(monType)))
local damage=tonumber(tostring(data.damage))
local totaldamage=tonumber(tostring(data.totaldamage))
local percent=math.floor(damage/maxBlood*100)
percent=(damage<=0 or percent>0)and percent or"小于1"
local tips=FMT.fmt("<size=22>本次伤害：<color=#4F7E1E>{0}%</color>（{1}）</size>",percent,mathHelper.formatNumber6(damage))
local progress={maxBlood-totaldamage+damage,maxBlood,maxBlood-totaldamage}
return fightResultWinConfig:getExtraWinParam(this.extraWin,this.extraType,prizeList,nil,tips,progress)
else
return fightResultWinConfig:getExtraWinParam(this.extraWin,this.extraType,prizeList,nil,"活动已结束",nil)
end
end,
},
[fightResultType.Lose]={
baseWin="UICommonVictoryWin",
extraWin="UIWorldBattleVictoryWin",
extraType=10,
extraWinArgs=function(this,bId,prizeList,param)
local data=param[1]
local subActInfo=activitiesModel:getSubActInfo(data.actid,SUB_ACTIVITY_TYPE.eTianMoRuQin,data.act2id)
if subActInfo and subActInfo:checkDoing()then
local monsterCfg=cfgHelper.get1(cfg_monstergroup_get,data.mongroupid)
local monType=monsterCfg.monType
local maxBlood=tonumber(tostring(subActInfo:getMaxBloods(monType)))
local damage=tonumber(tostring(data.damage))
local totaldamage=tonumber(tostring(data.totaldamage))
local percent=math.floor(damage/maxBlood*100)
percent=(damage<=0 or percent>0)and percent or"小于1"
local tips=FMT.fmt("<size=22>本次伤害：<color=#4F7E1E>{0}%</color>（{1}）</size>",percent,mathHelper.formatNumber6(damage))
local progress={maxBlood-totaldamage+damage,maxBlood,maxBlood-totaldamage}
return fightResultWinConfig:getExtraWinParam(this.extraWin,this.extraType,prizeList,nil,tips,progress)
else
return fightResultWinConfig:getExtraWinParam(this.extraWin,this.extraType,prizeList,nil,"活动已结束",nil)
end
end,
},
},
[eShowResultType.TianMoRuQin_ShiJian]={
[fightResultType.Victory]={
baseWin="UICommonVictoryWin",
extraWin="UIWorldBattleVictoryWin",
extraType=2,
extraWinArgs=function(this,bId,prizeList,param)
return fightResultWinConfig:getExtraWinParam(this.extraWin,this.extraType,prizeList)
end,
},
[fightResultType.Lose]={
baseWin="UICommonLoseWin",
extraWin="UIWorldBattleLoseWin",
},
},
[eShowResultType.yunyouMerchant]={
[fightResultType.Victory]={
baseWin="UICommonVictoryWin",
extraWin="UIYunYouMerchantFightResultWin",
extraType=1,
extraWinArgs=function(this,bId,prizeList,param)
local data=param[1]
local attributes=cfgHelper.get2(cfg_business2config_get,1,"attributes")
local monLevel=data.monLevel
attributes=attributes[monLevel]or attributes[0]
local maxBlood=attributes[1]
local damagePercent=data.damage
local progress={10000,10000,10000-damagePercent}
local damageValue=math.ceil(maxBlood*(damagePercent/10000))
local tips=FMT.fmt("<size=22>本次伤害：<color=#4F7E1E>{0}%</color></size>",damagePercent/100)

return fightResultWinConfig:getExtraWinParam(this.extraWin,this.extraType,tips,progress)
end,
},
[fightResultType.Lose]={
baseWin="UICommonVictoryWin",
extraWin="UIYunYouMerchantFightResultWin",
extraType=1,
extraWinArgs=function(this,bId,prizeList,param)
local data=param[1]
local attributes=cfgHelper.get2(cfg_business2config_get,1,"attributes")
local monLevel=data.monLevel
attributes=attributes[monLevel]or attributes[0]
local maxBlood=attributes[1]
local damagePercent=data.damage
local progress={10000,10000,10000-damagePercent}
local damageValue=math.ceil(maxBlood*(damagePercent/10000))
local tips=FMT.fmt("<size=22>本次伤害：<color=#4F7E1E>{0}%</color></size>",damagePercent/100)

return fightResultWinConfig:getExtraWinParam(this.extraWin,this.extraType,tips,progress)
end,
},
},
[eShowResultType.qieshishenshou]={
[fightResultType.Victory]={
baseWin="UICommonVictoryWin",
extraWin="UIQSSSBattleVictoryWin",
extraType=2,
extraWinArgs=function(this,bId,prizeList,param)
local list={}










return fightResultWinConfig:getExtraWinParam(this.extraWin,this.extraType,list)
end,
},
[fightResultType.Lose]={
baseWin="UICommonLoseWin",
extraWin="UIWorldBattleLoseWin",
},
},
[eShowResultType.taigushilian]={
[fightResultType.Victory]={
baseWin="UICommonVictoryWinTG",
extraWin="UIWorldBattleVictoryWin",
extraType=11,
extraWinArgs=function(this,bId,prizeList,param)

local tgsldata=param
return fightResultWinConfig:getExtraWinParam(this.extraWin,this.extraType,tgsldata)
end,
},
[fightResultType.Lose]={
baseWin="UICommonVictoryWinJS",
extraWin="UIWorldBattleVictoryWin",
extraType=11,
extraWinArgs=function(this,bId,prizeList,param)
local tgsldata=param
return fightResultWinConfig:getExtraWinParam(this.extraWin,this.extraType,tgsldata)
end,
},
[fightResultType.Lose2]={
baseWin="UICommonLoseWin",
extraWin="UIWorldBattleLoseWin",
extraWinArgs=function(this,bId,prizeList,param)
local tgsl=param
return{tgsl=tgsl}
end,
},
},
[eShowResultType.visitorchallenge]={
[fightResultType.Victory]={
baseWin="UICommonVictoryWin",
extraWin="UIVisitorChallengeFightResultWin",
extraType=1,
extraWinArgs=function(this,bId,prizeList,param)
local data=param[1]
return fightResultWinConfig:getExtraWinParam(this.extraWin,this.extraType,prizeList,data)
end,
},
[fightResultType.Lose]={
baseWin="UICommonLoseWin",
extraWin="UIVisitorChanllengeFightLoseWin",
extraType=1,
extraWinArgs=function(this,bId,prizeList,param)
local data=param[1]
return fightResultWinConfig:getExtraWinParam(this.extraWin,this.extraType,prizeList,data)
end,
},
},
[eShowResultType.fuyaoshilian]={
[fightResultType.Victory]={
baseWin="UICommonVictoryWinTG",
extraWin="UIWorldBattleVictoryWin",
extraType=11,
extraWinArgs=function(this,bId,prizeList,param)

local tgsldata=param
return fightResultWinConfig:getExtraWinParam(this.extraWin,this.extraType,tgsldata)
end,
},
[fightResultType.Lose]={
baseWin="UICommonVictoryWinJS",
extraWin="UIWorldBattleVictoryWin",
extraType=11,
extraWinArgs=function(this,bId,prizeList,param)
local tgsldata=param
return fightResultWinConfig:getExtraWinParam(this.extraWin,this.extraType,tgsldata)
end,
},
[fightResultType.Lose2]={
baseWin="UICommonLoseWin",
extraWin="UIWorldBattleLoseWin",
extraWinArgs=function(this,bId,prizeList,param)
local tgsl=param
return{tgsl=tgsl}
end,
},
},
[eShowResultType.zhengzhanshanhailog]={
[fightResultType.Victory]={
baseWin="UICommonVictoryWin",
extraWin="UIZhengZhanShanHaiLogVictoryWin",
extraType=1,
extraWinArgs=function(this,bId,prizeList,param)


local logstr=param[1]
local flag=param[2]
local hurt_hp=param[3]
local itemlist=param[4]
local jijie=param[5]
return fightResultWinConfig:getExtraWinParam(this.extraWin,this.extraType,logstr,flag,hurt_hp,itemlist,jijie)
end,
},

[fightResultType.Lose]={
baseWin="UICommonLoseWin",
extraWin="UIZhengZhanShanHaiLogVictoryWin",
extraType=1,
extraWinArgs=function(this,bId,prizeList,param)


local logstr=param[1]
local flag=param[2]
local hurt_hp=param[3]
local itemlist=param[4]
return fightResultWinConfig:getExtraWinParam(this.extraWin,this.extraType,logstr,flag,hurt_hp,itemlist)
end,
},
},
[eShowResultType.xianjielog]={
[fightResultType.Victory]={
baseWin="UICommonVictoryWin",
extraWin="UIZhengZhanShanHaiLogVictoryWin",
extraType=1,
extraWinArgs=function(this,bId,prizeList,param)

local logstr="{0}"
local flag=0
local hurt_hp=param[1]
local itemlist=nil
local jijie=nil
return fightResultWinConfig:getExtraWinParam(this.extraWin,this.extraType,logstr,flag,hurt_hp,itemlist,jijie,param)
end,
},

[fightResultType.Lose]={
baseWin="UICommonLoseWin",












extraWin="UIXJRZBattleLoseWin",
extraType=1,
extraWinArgs=function(this,bId,prizeList,param)
local rzdata={}
local lose_txt=param[1]
rzdata.lose_txt=lose_txt
return fightResultWinConfig:getExtraWinParam(this.extraWin,this.extraType,rzdata)
end,
},
},
[eShowResultType.houshanzhenling]={
[fightResultType.Victory]={
baseWin="UICommonVictoryWin",
baseType=3,
extraWin="UIHouShanZLChallengeFightResultWin",
extraType=1,
extraWinArgs=function(this,bId,prizeList,param)
local data=param[1]
return fightResultWinConfig:getExtraWinParam(this.extraWin,this.extraType,prizeList,data,1)
end,
btnsInfo=function(self,bId,param)
local data=param[1]
local type=data.zlType
local layer=data.layer

if UIHuanJingControl:getLayerState(type,layer+1)~=HouShanZhenLingLayerStateList.Challenge then
return
end
local continueCallBack=function()
local func=function()
fightModel:removeBattle(bId)
UIHuanJingControl:doNextFight(type,layer+1)
loadingControl.closeCloud()
end
loadingControl.openCloud(func,1.5)
end

local quitCallBack=function()
fightResultController:afterShowResult()
end

return fightResultWinConfig:getBaseWinParam(self.baseWin,self.baseType,'继续挑战',continueCallBack,"退 出",quitCallBack,5)
end
},
[fightResultType.Lose]={
baseWin="UICommonLoseWin",
extraWin="UIWorldBattleLoseWin",
extraType=1,
extraWinArgs=function(this,bId,prizeList,param)
return fightResultWinConfig:getExtraWinParam(this.extraWin,this.extraType)
end,
},
},
[eShowResultType.longhuxiangyao]={
[fightResultType.Victory]={
baseWin="UICommonVictoryWin",
baseType=3,
btnsInfo=function(self,bId,param)

local data=param[1]
local actID=data.actid
local subID=data.act2id
local subType=SUB_ACTIVITY_TYPE.eLongHuXiangYao
local monIndex=data.monster_idx

local continueCallBack=function()

local battle=fightModel:getBattle(bId)
if battle then
battle:hideAllEntity()
battle:stopAllEffect()
battle:resumeMusic()

end
fightModel:removeBattle(bId)
call_activitiesHandle_func("activitiesHandle_longhuxiangyao","NextBattle",actID,subID,{monIndex=monIndex})
end

local quitCallBack=function()

fightResultController:afterShowResult()

end
local hideContinueList=activitiesModel:getSubActivityConfig(subType,subID,"hideContinueList")
local cd=5
local hideContinue=hideContinueList[monIndex]==1
return fightResultWinConfig:getBaseWinParam(self.baseWin,self.baseType,'继续挑战',continueCallBack,"退 出",quitCallBack,cd,hideContinue)
end,
extraWin="UIWorldBattleVictoryWin",
extraType=5,
extraWinArgs=function(this,bId,prizeList,param)
local data=param[1]


local tips="\n\n\n<size=24>该敌人身上没有任何有价值的道具</size>"
return fightResultWinConfig:getExtraWinParam(this.extraWin,this.extraType,prizeList,tips)
end,
},
[fightResultType.Lose]={
baseWin="UICommonLoseWin",
btnsInfo=function(this,bId,param)
local data=param[1]
local actID=data.actid
local subID=data.act2id
local monIndex=data.monster_idx

local continueCallBack=function()

local battle=fightModel:getBattle(bId)
if battle then
battle:hideAllEntity()
battle:stopAllEffect()
battle:resumeMusic()

end
fightModel:removeBattle(bId)
call_activitiesHandle_func("activitiesHandle_longhuxiangyao","BattleAgain",actID,subID,{monIndex=monIndex})
end

local quitCallBack=function()

fightResultController:afterShowResult()

end
return fightResultWinConfig:getBaseWinParam(this.baseWin,2,'重新挑战',continueCallBack,"退 出",quitCallBack)
end,

extraWin="UIWorldBattleLoseWin",
},
},
[eShowResultType.systemZongMenAttack]={
[fightResultType.Victory]={
baseWin="UICommonVictoryWin",
extraWin="UISystemZongMenFightAttackSuccessWin",
extraType=1,
extraWinArgs=function(this,bId,prizeList,param)
local zmData=systemZongMenModel:getInfoData(param[1])
local zmName=systemZongMenModel:getNameStr(zmData.id,zmData.nameIdx)
local str=FMT.fmt("已成功攻占<color=green><{0}></color>",zmName)
return fightResultWinConfig:getExtraWinParam(this.extraWin,this.extraType,bId,str)
end,
},
[fightResultType.Lose]={
baseWin="UICommonLoseWin3",
extraWin="UISystemZongMenFightAttackFailureWin",
extraType=1,
extraWinArgs=function(this,bId,prizeList,param)
return fightResultWinConfig:getExtraWinParam(this.extraWin,this.extraType,bId)
end,
},
},
[eShowResultType.sifangpingyao]={
[fightResultType.Victory]={
baseWin="UICommonVictoryWin",
extraWin="UIWorldBattleVictoryWin",
extraType=13,
extraWinArgs=function(this,bId,prizeList,param)

local data=param[1]


local chapter_id=data.chapter_id
local point_id=data.demons_point
local str=FMT.fmt("战斗胜利，可继续前往下一个挑战点")
if chapter_id==3 and point_id==1000 then
str=FMT.fmt("战斗胜利，恭喜通关全部章节！")
end
return fightResultWinConfig:getExtraWinParam(this.extraWin,this.extraType,str)
end,
},
[fightResultType.Lose]={
baseWin="UICommonLoseWin",
extraWin="UIWorldBattleLoseWin",
extraType=1,
extraWinArgs=function(this,bId,prizeList,param)
return fightResultWinConfig:getExtraWinParam(this.extraWin,this.extraType)
end,
},
},
[eShowResultType.ShiJieGuaiWu]={
[fightResultType.Victory]={
baseWin="UICommonVictoryWin",
extraWin="UIWorldBattleVictoryWin",
extraType=2,
extraWinArgs=function(this,bId,prizeList,param)
return fightResultWinConfig:getExtraWinParam(this.extraWin,this.extraType,prizeList)
end,
},
[fightResultType.Lose]={
baseWin="UICommonLoseWin",
extraWin="UIWorldBattleLoseWin",
},
},
[eShowResultType.chisejindi]={
[fightResultType.Victory]={
baseWin="UICommonVictoryWin",
extraWin="UISubAct_ChiSeJinDi_CopyFightVictoryWin",
extraType=1,
extraWinArgs=function(this,bId,prizeList,param)
local data=param[1]
local actId=data.act_id
local subType=SUB_ACTIVITY_TYPE.eChiSeJinDi
local subId=data.act2_id
local info=activitiesModel:getSubActInfo(actId,subType,subId)
if info and info:checkDoing()then
return fightResultWinConfig:getExtraWinParam(this.extraWin,this.extraType,data.level)
end
end,
},
[fightResultType.Lose]={
baseWin="UICommonLoseWin",
extraWin="UISubAct_ChiSeJinDi_CopyFightLoseWin",
extraType=1,
extraWinArgs=function(this,bId,prizeList,param)
local data=param[1]
local actId=data.act_id
local subType=SUB_ACTIVITY_TYPE.eChiSeJinDi
local subId=data.act2_id
local info=activitiesModel:getSubActInfo(actId,subType,subId)
if info and info:checkDoing()then
local maxHP=info:getSubActConfig("times")
return fightResultWinConfig:getExtraWinParam(this.extraWin,this.extraType,data.hp,maxHP)
end
end,
},
},
[eShowResultType.dujiexiandan]={
[fightResultType.Victory]={
baseWin="UICommonVictoryWin",
extraWin="UIWorldBattleVictoryWin",
extraType=2,
extraWinArgs=function(this,bId,prizeList,param)
return fightResultWinConfig:getExtraWinParam(this.extraWin,this.extraType,prizeList)
end
},
[fightResultType.Lose]={
baseWin="UICommonLoseWin",
extraWin="UIWorldBattleLoseWin",
},
},
[eShowResultType.zhenyaoshilian]={
[fightResultType.Victory]={
baseWin="UICommonVictoryWinGain",
extraWin="UIZYSLShowPrizeWin",
extraType=1,
extraWinArgs=function(this,bId,prizeList,param)
return fightResultWinConfig:getExtraWinParam(this.extraWin,this.extraType,param)
end
},
[fightResultType.Lose]={
baseWin="UICommonVictoryWinGain",
extraWin="UIZYSLShowPrizeWin",
extraType=1,
extraWinArgs=function(this,bId,prizeList,param)
return fightResultWinConfig:getExtraWinParam(this.extraWin,this.extraType,param)
end
},
},
[eShowResultType.tianmojie]={
[fightResultType.Victory]={
baseWin="UICommonVictoryWin",
extraWin="UITianMoJieFightResultWin",
extraType=1,
extraWinArgs=function(this,bId,prizeList,param)
local data=param[1]
local monsterCfg=cfgHelper.get1(cfg_tianmojiemonconfig_get,data.tmid)
local rewards=data.prizeList~=nil and#data.prizeList>0 and data.prizeList or nil
local content="天魔未灭，此劫未过，不可懈怠，再接再厉！"
if rewards then
if playerModel:checkActorId(data.actorid)then
content=FMT.fmt("获得魔劫积分：<color=#ca631d>{0}</color>",monsterCfg.score)
local stage=tianMoJieModel:getStage()
local stageCfg=cfgHelper.get1(cfg_tianmojiestageconfig_get,stage)
if stageCfg then
local score=tianMoJieModel:getScore()
content=FMT.fmt("{0}\t距离下一魔劫阶段还需魔劫积分：<color=#ca631d>{1}</color>",content,stageCfg.score-score)
end
else
content=nil
end
end
local oldVal=data.oldpercent
local newVal=data.newpercent
local hurt=math.max(0,math.floor(monsterCfg.hp*((oldVal-newVal)/10000)))
local tips=FMT.fmt("本次战斗造成伤害量：<color=#549327>{0}</color>",mathHelper.formatNumber(hurt))
return fightResultWinConfig:getExtraWinParam(this.extraWin,this.extraType,rewards,content,oldVal,newVal,tips)
end
},
[fightResultType.Lose]={
baseWin="UICommonVictoryWin",
extraWin="UITianMoJieFightResultWin",
extraType=1,
extraWinArgs=function(this,bId,prizeList,param)
local data=param[1]
local monsterCfg=cfgHelper.get1(cfg_tianmojiemonconfig_get,data.tmid)
local rewards=data.prizeList~=nil and#data.prizeList>0 and data.prizeList or nil
local content=rewards==nil and"天魔未灭，此劫未过，不可懈怠，再接再厉！"or nil
local oldVal=data.oldpercent
local newVal=data.newpercent
local hurt=math.max(0,math.floor(monsterCfg.hp*((oldVal-newVal)/10000)))
local tips=FMT.fmt("本次战斗造成伤害量：<color=#549327>{0}</color>",mathHelper.formatNumber(hurt))
return fightResultWinConfig:getExtraWinParam(this.extraWin,this.extraType,rewards,content,oldVal,newVal,tips)
end
},
},
[eShowResultType.xunbaoshilian]={
[fightResultType.Victory]={
baseWin="UICommonVictoryWin",
extraWin="UIWorldBattleVictoryWin",
extraType=2,
btnsInfo=function(this,bId,param)
return xunBaoShiLianController:onFightResultBaseBtn(this,bId,param)
end,
extraWinArgs=function(this,bId,prizeList,param)
return fightResultWinConfig:getExtraWinParam(this.extraWin,this.extraType,prizeList)
end
},
[fightResultType.Lose]={
baseWin="UICommonLoseWin",
extraWin="UIWorldBattleLoseWin",
baseType=2,
btnsInfo=function(this,bId,param)
local data=param[1]
local fightType=data.fighttype
local chapterId=data.chapter_id
local levelIdx=data.training_idx
local isHardFlag=data.is_difficulty
local modeId=isHardFlag==1 and XBSL_DIFFICULTY_MODE.Hard or XBSL_DIFFICULTY_MODE.Normal
local continueCallBack=function()
local battle=fightModel:getBattle(bId)
if battle then
battle:hideAllEntity()
battle:stopAllEffect()
battle:resumeMusic()

end
fightModel:removeBattle(bId)
xunBaoShiLianController:openXBSLFight(chapterId,levelIdx,modeId)
end

local quitCallBack=function()
fightResultController:afterShowResult()

end
return fightResultWinConfig:getBaseWinParam(this.baseWin,this.baseType,'重新挑战',continueCallBack,"关闭",quitCallBack)
end,
},
},
[eShowResultType.wdcqxiweisai]={
[fightResultType.Victory]={
baseWin="UICommonVictoryWin",
extraWin="UIXWSResultWin",
extraType=1,
extraWinArgs=function(this,bId,prizeList,param)
local data=param[1]
data.result=true
return fightResultWinConfig:getExtraWinParam(this.extraWin,this.extraType,XiWeiSaiController:getFightResultData(data))
end
},
[fightResultType.Lose]={
baseWin="UICommonLoseWin2",
extraWin="UIXWSResultWin",
extraType=1,
extraWinArgs=function(this,bId,prizeList,param)
local data=param[1]
data.result=false
return fightResultWinConfig:getExtraWinParam(this.extraWin,this.extraType,XiWeiSaiController:getFightResultData(data))
end
},
},
[eShowResultType.xianjiefumo]={
[fightResultType.Victory]={
baseWin="UICommonVictoryWin",
extraWin="UIWorldBattleVictoryWin",
extraType=4,
extraWinArgs=function(this,bId,prizeList,param)

local data=param[1]
local lastValue=data and data.damage or XianJieFuMoModel:getLastdamage()
local tips=FMT.fmt("本次战斗造成伤害量：<color=#39ba28>{0}</color>",mathHelper.formatNumber4(tonumber(tostring(lastValue)),2))
local rewards=prizeList
return fightResultWinConfig:getExtraWinParam(this.extraWin,this.extraType,rewards,nil,tips)
end,
},
[fightResultType.Lose]={
baseWin="UICommonVictoryWin",
extraWin="UIWorldBattleVictoryWin",
extraType=4,
extraWinArgs=function(this,bId,prizeList,param)

local data=param[1]
local lastValue=data and data.damage or XianJieFuMoModel:getLastdamage()
local tips=FMT.fmt("本次战斗造成伤害量：<color=#39ba28>{0}</color>",mathHelper.formatNumber4(tonumber(tostring(lastValue)),2))
local rewards=prizeList
return fightResultWinConfig:getExtraWinParam(this.extraWin,this.extraType,rewards,nil,tips)
end,
},
},
[eShowResultType.xianguanwuxuan]={
[fightResultType.Victory]={
baseWin="UICommonVictoryWin",
extraWin="UIWorldBattleVictoryWin",
extraType=12,
extraWinArgs=function(this,bId,prizeList,param)
return fightResultWinConfig:getExtraWinParam(this.extraWin,this.extraType,"")
end,
},

[fightResultType.Lose]={
baseWin="UICommonLoseWin",
extraWin="UIWorldBattleLoseWin",
},
},
[eShowResultType.gubaoshilian]={
[fightResultType.Victory]={
baseWin="UICommonVictoryWin",
baseType=3,
btnsInfo=function(this,bId,param)
local data=param[1]
local quitText="退 出"
local quitCallBack=function()
fightResultController:afterShowResult()
end
local continueText=nil
local continueCallBack=nil
local cd=nil
local config=activitiesModel:getSubActivityConfig(data.subType,data.subId)
if data.layer<#config.layer_list then
continueText="继续挑战"
cd=5
continueCallBack=function()
local guidList=fightPreSelectModel:getTeamSendData(eFightPreSelectType.gubaoshilian)or{}
local zfId=fightPreSelectModel:getZhenFaData(eFightPreSelectType.gubaoshilian)or 0
local levelCfg=cfgHelper.get1(cfg_gubaoshilianlayerconfig_get,config.layer_list[data.layer+1])
local monCfg=cfgHelper.get1(cfg_monstergroup_get,levelCfg.mon_group_list[1])
fightLaunchController:sendFight(eBattleLaunch.gubaoshilian,guidList,monCfg.mapId or 0,zfId,{data.actId,data.subType,data.subId})
end
end
return fightResultWinConfig:getBaseWinParam(this.baseWin,this.baseType,continueText,continueCallBack,quitText,quitCallBack,cd)
end,
extraWin="UIWorldBattleVictoryWin",
extraType=3,
extraWinArgs=function(this,bId,prizeList,param)
return fightResultWinConfig:getExtraWinParam(this.extraWin,this.extraType,prizeList)
end,
},

[fightResultType.Lose]={
baseWin="UICommonLoseWin",
baseType=2,
btnsInfo=function(this,bId,param)
local data=param[1]
local quitText="退 出"
local quitCallBack=function()
fightResultController:afterShowResult()
end
local continueText=nil
local continueCallBack=nil
local config=activitiesModel:getSubActivityConfig(data.subType,data.subId)
if data.layer<#config.layer_list then
continueText="重新挑战"
continueCallBack=function()
local guidList=fightPreSelectModel:getTeamSendData(eFightPreSelectType.gubaoshilian)or{}
local zfId=fightPreSelectModel:getZhenFaData(eFightPreSelectType.gubaoshilian)or 0
local levelCfg=cfgHelper.get1(cfg_gubaoshilianlayerconfig_get,config.layer_list[data.layer])
local monCfg=cfgHelper.get1(cfg_monstergroup_get,levelCfg.mon_group_list[1])
fightLaunchController:sendFight(eBattleLaunch.gubaoshilian,guidList,monCfg.mapId or 0,zfId,{data.actId,data.subType,data.subId})
end
end
return fightResultWinConfig:getBaseWinParam(this.baseWin,this.baseType,continueText,continueCallBack,quitText,quitCallBack)
end,
extraWin="UIWorldBattleLoseWin",
},
},

[eShowResultType.yanfage]={
[fightResultType.Victory]={
baseWin="UICommonVictoryWin",
extraWin="UIYFGBattleVictoryWin",
extraType=1,
extraWinArgs=function(this,bId,prizeList,param,fightData)
local winSide=0
return fightResultWinConfig:getExtraWinParam(this.extraWin,this.extraType,fightData,winSide,param)
end,
baseType=6,
btnsInfo=function(this,bId,param,fightData)
local data=param[1]
local prepareType
local tabType
if data.fight_flag==1 then

prepareType=2
tabType=FULL_TAB_TYPE.eYanFaGe_Battle
else

prepareType=1
tabType=FULL_TAB_TYPE.eYanFaGe_Train
end
local quitText="退 出"
local quitCallBack=function()
fightResultController:afterShowResult()
UIFullYanFaGeControl:showMainWindowEx(tabType)
end
local continueText="重新挑战"
local cfg=cfgHelper.get(cfg_yanfageconfig_get,1)
local cd=cfg.cd
local continueCallBack=function()

local battle=fightModel:getBattle(bId)
if battle then
battle:hideAllEntity()
battle:stopAllEffect()
battle:resumeMusic()

end
fightModel:removeBattle(bId)

UIFullYanFaGeControl:showYanFaGeFightPrepare(prepareType)
end
return fightResultWinConfig:getBaseWinParam(this.baseWin,this.baseType,continueText,continueCallBack,quitText,quitCallBack,cd)
end,
},
[fightResultType.Lose]={
baseWin="UICommonVictoryWin",
extraWin="UIYFGBattleVictoryWin",
extraType=1,
extraWinArgs=function(this,bId,prizeList,param,fightData)
local winSide=1
return fightResultWinConfig:getExtraWinParam(this.extraWin,this.extraType,fightData,winSide,param)
end,
baseType=6,
btnsInfo=function(this,bId,param,fightData)
local data=param[1]
local prepareType
local tabType
if data.fight_flag==1 then

prepareType=2
tabType=FULL_TAB_TYPE.eYanFaGe_Battle
else

prepareType=1
tabType=FULL_TAB_TYPE.eYanFaGe_Train
end
local quitText="退 出"
local quitCallBack=function()
fightResultController:afterShowResult()
UIFullYanFaGeControl:showMainWindowEx(tabType)
end
local continueText="重新挑战"
local cfg=cfgHelper.get(cfg_yanfageconfig_get,1)
local cd=cfg.cd
local continueCallBack=function()

local battle=fightModel:getBattle(bId)
if battle then
battle:hideAllEntity()
battle:stopAllEffect()
battle:resumeMusic()

end
fightModel:removeBattle(bId)

UIFullYanFaGeControl:showYanFaGeFightPrepare(prepareType)
end
return fightResultWinConfig:getBaseWinParam(this.baseWin,this.baseType,continueText,continueCallBack,quitText,quitCallBack,cd)
end,
},
},
[eShowResultType.activitiesPushMap]={
[fightResultType.Victory]={
baseWin="UICommonVictoryWin",
baseType=3,
btnsInfo=function(this,bId,param)
local data=param[1]
local quitText="退 出"
local quitCallBack=function()


if data and data.tuituId and data.progress then
local fightWinEndPlotList=cfgHelper.get(cfg_acttutuiconfig_get,data.tuituId,'fightWinEndPlotList')
if fightWinEndPlotList then
local fightWinEndPlot=fightWinEndPlotList[data.progress]
if fightWinEndPlot then
local args={
groupid=fightWinEndPlot,
isFullOpen=false,
callback=function()
activitiesHandle_fangyingting:fightResultQuitCB(data,true)
end,
}
gameplotController:showPlotBoard(args)
return
end
end
end
activitiesHandle_fangyingting:fightResultQuitCB(data,true)
end

local DelayedClose=1






return fightResultWinConfig:getBaseWinParam(this.baseWin,7,quitText,quitCallBack,DelayedClose)
end,
extraWin="UIWorldBattleVictoryWin",
extraType=2,
extraWinArgs=function(this,bId,prizeList,param)
return fightResultWinConfig:getExtraWinParam(this.extraWin,this.extraType,prizeList)
end,
},
[fightResultType.Lose]={
baseWin="UICommonLoseWin",
extraWin="UIWorldBattleLoseWin",
baseType=1,
btnsInfo=function(this,bId,param)
local data=param[1]
local quitCallBack=function()
activitiesHandle_fangyingting:fightResultQuitCB(data,false)
end
local continueCallBack=function()
activitiesHandle_fangyingting:fightResultContinueCB(data,false)
end
return fightResultWinConfig:getBaseWinParam(this.baseWin,2,'重新挑战',continueCallBack,"退 出",quitCallBack)
end,
},
},
[eShowResultType.xjCaravanEscort]={
[fightResultType.Victory]={
baseWin="UICommonVictoryWin",
extraWin="UIXJCaravanEscort_victoryWin",
extraType=1,
extraWinArgs=function(this,bId,prizeList,param)
local data=param[1]
local rewards=data.reward_list
return fightResultWinConfig:getExtraWinParam(this.extraWin,this.extraType,rewards,data)
end,
btnsInfo=function(this,bId,param)
local quitCallBack=function()
fightResultController:afterShowResult()
local data=param[1]
local shipGuid=data.xianzhou_guid
local robTimes=data.rob_times
local flag=data.flag

if flag==1 then


local args={
selectPageIdx=2,
openMsgShipGuid=shipGuid,
}
UIFullXJCaravanEscortController:showMainWindowByJump(args)
else
local entityData=xianjieModel:getCaravanEscortTeamDataByShipGuid(shipGuid)
if entityData then
local getEntityDataFunc=function()
return xianjieModel:getCaravanEscortTeamDataByShipGuid(shipGuid)
end
local clickEntKey=entityData:getTeamEnityKey()
if clickEntKey then
xianjieModel:enterSceneState_clickTeam_before_notTeam(clickEntKey,getEntityDataFunc)
else

local shipNowSceneIdx,pos=entityData:getTeamPos()
if shipNowSceneIdx then
local nowSceneIdx=xianjieModel:getSceneIndex()
if nowSceneIdx~=shipNowSceneIdx then
local sceneType=xianjieModel:sceneIndex2SceneType(shipNowSceneIdx)
return xianjieController:jumpXianJie(sceneType,nil,function()
local entityData=xianjieModel:getCaravanEscortTeamDataByShipGuid(shipGuid)
local clickEntKey=entityData:getTeamEnityKey()
if clickEntKey then
xianjieModel:enterSceneState_clickTeam_before_notTeam(clickEntKey,getEntityDataFunc)
end
end)
end
end
end
else
local showType=2
xianjieController:openXJCaravanEscortShipMsgWin(showType,shipGuid)
end
end
end
return fightResultWinConfig:getBaseWinParam(this.baseWin,1,"退 出",quitCallBack)
end,
},
[fightResultType.Lose]={
baseWin="UICommonLoseWin",
extraWin="UIWorldBattleLoseWin",
btnsInfo=function(this,bId,param)
local quitCallBack=function()
fightResultController:afterShowResult()
local data=param[1]
local shipGuid=data.xianzhou_guid
local robTimes=data.rob_times
local flag=data.flag

if flag==1 then


local args={
selectPageIdx=2,
openMsgShipGuid=shipGuid,
}
UIFullXJCaravanEscortController:showMainWindowByJump(args)
else
local entityData=xianjieModel:getCaravanEscortTeamDataByShipGuid(shipGuid)
if entityData then
local getEntityDataFunc=function()
return xianjieModel:getCaravanEscortTeamDataByShipGuid(shipGuid)
end
local clickEntKey=entityData:getTeamEnityKey()
if clickEntKey then
xianjieModel:enterSceneState_clickTeam_before_notTeam(clickEntKey,getEntityDataFunc)
else

local shipNowSceneIdx,pos=entityData:getTeamPos()
if shipNowSceneIdx then
local nowSceneIdx=xianjieModel:getSceneIndex()
if nowSceneIdx~=shipNowSceneIdx then
local sceneType=xianjieModel:sceneIndex2SceneType(shipNowSceneIdx)
return xianjieController:jumpXianJie(sceneType,nil,function()
local entityData=xianjieModel:getCaravanEscortTeamDataByShipGuid(shipGuid)
local clickEntKey=entityData:getTeamEnityKey()
if clickEntKey then
xianjieModel:enterSceneState_clickTeam_before_notTeam(clickEntKey,getEntityDataFunc)
end
end)
end
end
end
else
local showType=2
xianjieController:openXJCaravanEscortShipMsgWin(showType,shipGuid)
end
end
end
return fightResultWinConfig:getBaseWinParam(this.baseWin,1,"退 出",quitCallBack)
end,
},
},
[eShowResultType.mingyuanzhusha]={
[fightResultType.Victory]={
baseWin="UICommonVictoryWin",
extraWin="UIMingYuanZhuSha_FightVictoryExWin",
extraType=1,
isCloudClose=true,
argtableEx={
closeTipPos={0,35}
},
extraWinArgs=function(this,bId,prizeList,param)
local data=param[1]
return fightResultWinConfig:getExtraWinParam(this.extraWin,this.extraType,bId,data)
end,









},
[fightResultType.Lose]={
baseWin="UICommonLoseWin",
extraWin="UIWorldBattleLoseWin",
baseType=1,
isCloudClose=true,
btnsInfo=function(this,bId,param)
local quitCallBack=function()
myzsController:showFullWin_Cloud()
fightResultController:afterShowResult()
end
local continueCallBack=function()
myzsController:startFight()
end
return fightResultWinConfig:getBaseWinParam(this.baseWin,2,'再次挑战',continueCallBack,"退 出",quitCallBack)
end,
extraWinArgs=function(this,bId,prizeList,param)
local data=param[1]
return fightResultWinConfig:getExtraWinParam(this.extraWin,this.extraType,bId,data)
end,
},
},
[eShowResultType.xingyu]={
[fightResultType.Victory]={
baseWin="UICommonVictoryWin",
extraWin="UIXingYu_jiesuanWin",
extraType=1,
extraWinArgs=function(this,bId,prizeList,param)
return fightResultWinConfig:getExtraWinParam(this.extraWin,this.extraType,param[1],prizeList)
end
},
[fightResultType.Lose]={
baseWin="UICommonLoseWin2",
extraWin="UIXingYu_jiesuanWin",
extraType=1,
extraWinArgs=function(this,bId,prizeList,param)
return fightResultWinConfig:getExtraWinParam(this.extraWin,this.extraType,param[1],prizeList)
end
},
},
}

function fightResultConfig:getResultConfig(resultType)
return _ResultHandle[resultType]
end
