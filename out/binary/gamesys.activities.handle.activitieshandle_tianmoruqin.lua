







activitiesHandle_tianmoruqin=new_activitiesHandle('activitiesHandle_tianmoruqin',activitiesHandle)

local _shareSettingKey="tianmoruqin_sharesetting"
local _shareSetting=nil
local _filterSettingKey="tianmoruqin_filtersetting"
local _filterSetting=nil
local _shareChannels={CHAT_CHANNNEL.eWorld,CHAT_CHANNNEL.eXianmeng}
local _shareMonsterTypes={monType.LittleMonster,monType.EliteMonster,monType.Boss}
local _filterMonsterTypes={monType.Boss,monType.EliteMonster,monType.LittleMonster}
local _filterMonsterNames={
[monType.Boss]="首领",
[monType.EliteMonster]="精英",
[monType.LittleMonster]="普通",
}
local _registerEvent=false
local _autoIncrementGuid=0

function activitiesHandle_tianmoruqin:onEnterState()
if not _registerEvent then
worldController:registerSceneState(worldModel.ON_SCENE_STATE.ENTER,1,self.onEnterWorld)
notifySystem:listenNotify(notifyConfig.onShowPrize,self.onShowPrize)
notifySystem:listenNotify(notifyConfig.onClickObjectInWorld,self.onClickObjectInWorld)
_registerEvent=true
end
end

function activitiesHandle_tianmoruqin:onLeaveState()
_autoIncrementGuid=0
end

function activitiesHandle_tianmoruqin:getAutoIncrementGuid()
_autoIncrementGuid=_autoIncrementGuid+1
return _autoIncrementGuid
end

function activitiesHandle_tianmoruqin:getShareSettings()
if _shareSetting==nil then
_shareSetting=userActorSetting.get(_shareSettingKey,{})
end
return _shareSetting
end

function activitiesHandle_tianmoruqin:setShareSettings(settings)
_shareSetting=settings
userActorSetting.set(_shareSettingKey,_shareSetting)
userActorSetting:flush()
end

function activitiesHandle_tianmoruqin:getFilterSettings()
if _filterSetting==nil then
_filterSetting=userActorSetting.get(_filterSettingKey,0)
end
return _filterSetting
end

function activitiesHandle_tianmoruqin:setFilterSettings(settings)
_filterSetting=settings
userActorSetting.set(_filterSettingKey,_filterSetting)
userActorSetting:flush()
end

function activitiesHandle_tianmoruqin:getShareChannels()
return _shareChannels
end

function activitiesHandle_tianmoruqin:getShareMonsterTypes()
return _shareMonsterTypes
end

function activitiesHandle_tianmoruqin:getFilterMonsterTypes()
return _filterMonsterTypes
end

function activitiesHandle_tianmoruqin:getFilterMonsterName(monType)
return _filterMonsterNames[monType]
end

function activitiesHandle_tianmoruqin.onEnterWorld()
local subType=SUB_ACTIVITY_TYPE.eTianMoRuQin
local subActInfos=activitiesModel:getActSubList_subType_doing(subType)
for index,info in ipairs(subActInfos)do
info:onEnterWorld()
end
end

function activitiesHandle_tianmoruqin.onShowPrize(prizeType,prizelist,effectData)
if prizeType==ePrizeType.eTianMoRuQinRank then
local subType=SUB_ACTIVITY_TYPE.eTianMoRuQin
local actId=effectData.actid
local subId=effectData.act2id
local rank=effectData.rank
local monsterGuid=effectData.mongroupguid
local monster=effectData.mongroupid

local subActInfo=activitiesModel:getSubActInfo(actId,subType,subId)
if subActInfo then
local index=subActInfo:findMonsterIndex(monsterGuid)
if index then
local monsterData=subActInfo:getMonsterData(index)
monsterData.fighted=-monsterData.fighted
subActInfo:refreshWorldBeiHUD(index)
UIManager:invokeUIMethod("UISubAct_TianMoRuQin_MainWin","refreshMonster",index,false)
end

local guidStr=tostring(monsterGuid)
local reddot=subActInfo:deleteRankData(guidStr)
UIManager:invokeUIMethod("UISubAct_TianMoRuQin_QingBaoWin","on_249_135",actId,subType,subId)

if reddot then
reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,subType)
notifySystem:postNotify(notifyConfig.onActTabReddotChange,SUBACT_DEFINETAB_TYPE.eTianMoRuQin_qingbao)
if index then
notifySystem:postNotify(notifyConfig.onActTabReddotChange,SUBACT_DEFINETAB_TYPE.eTianMoRuQin_main)
end
end
end

local callback=function()
if subActInfo and subActInfo:checkDoing()then
call_activitiesHandle_func("activitiesHandle_tianmoruqin","reqMonsterRank",actId,subId,monsterGuid)
else
UIManager.error("活动已结束")
end
end

showPrizeControl.showWindowSevenNow(prizelist,callback,FMT.fmt("伤害排名：<color=#7D3B17>第{0}名</color>",rank),"点击屏幕领取奖励")
elseif prizeType==ePrizeType.eTianMoRuQinRankBatch then
local subType=SUB_ACTIVITY_TYPE.eTianMoRuQin
local actId=effectData.actid
local subId=effectData.act2id
local len=effectData.len
local list=effectData.list

local subActInfo=activitiesModel:getSubActInfo(actId,subType,subId)
if subActInfo then
local reddot=false
local hasSelf=false
for index,guid in ipairs(list)do
local guidStr=tostring(guid)
local check=subActInfo:deleteRankData(guidStr)
reddot=reddot or check
local index=subActInfo:findMonsterIndex(guid)
if index then
local monsterData=subActInfo:getMonsterData(index)
monsterData.fighted=-monsterData.fighted
subActInfo:refreshWorldBeiHUD(index)
UIManager:invokeUIMethod("UISubAct_TianMoRuQin_MainWin","refreshMonster",index,false)
hasSelf=true
end
end
UIManager:invokeUIMethod("UISubAct_TianMoRuQin_QingBaoWin","on_249_135",actId,subType,subId)
if reddot then
reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,subType)
notifySystem:postNotify(notifyConfig.onActTabReddotChange,SUBACT_DEFINETAB_TYPE.eTianMoRuQin_qingbao)
if hasSelf then
notifySystem:postNotify(notifyConfig.onActTabReddotChange,SUBACT_DEFINETAB_TYPE.eTianMoRuQin_main)
end
end
end

showPrizeControl.showWindow(prizelist)
end
end

function activitiesHandle_tianmoruqin.onClickObjectInWorld(args)
if args==nil then return end
if args[1]==eWorldUnitTpye.TIANMORUQIN_BEI then
local subType=SUB_ACTIVITY_TYPE.eTianMoRuQin
local actId=args[2]
local subId=args[3]
local index=args[4]
local subActInfo=activitiesModel:getSubActInfo(actId,subType,subId)
if subActInfo and subActInfo:hasData()then
local data=subActInfo:getMonsterData(index)
local config=subActInfo:getSubActConfig()
if data and data.monster>0 then
local nowTime=timeHelper.getServerShortTime()
local monsterCfg=cfgHelper.get1(cfg_monstergroup_get,data.monster)
local monType=monsterCfg.monType
local leastTime=nil
if data.since>0 then
local deadLine=subActInfo:getMonsterDeadTimeEx(data)
leastTime=deadLine-nowTime
end
if not leastTime or leastTime>0 then
local maxBlood=tonumber(tostring(subActInfo:getMaxBloods(monType)))
local damageBlood=tonumber(tostring(data.damage))
local isLive=damageBlood<maxBlood
if isLive then

call_activitiesHandle_func("activitiesHandle_tianmoruqin","reqMonsterDetail",actId,subId,data.guid,-worldModel.world)
end
return
end
end
end
elseif args[1]==eWorldUnitTpye.TIANMORUQIN_MONSTER then
local subType=SUB_ACTIVITY_TYPE.eTianMoRuQin
local actId=args[2]
local subId=args[3]
local monsterGuid=args[4]
local subActInfo=activitiesModel:getSubActInfo(actId,subType,subId)
if subActInfo and subActInfo:hasData()then
if not subActInfo:checkDoing()then
return UIManager.error("活动已结算")
end
local config=subActInfo:getSubActConfig()
local data,index,event=subActInfo:getExMonster(monsterGuid)
if data then
local monsterCfg=cfgHelper.get1(cfg_monstergroup_get,data.id)
local unitKey=worldModel:convertUnitKey({eWorldUnitTpye.TIANMORUQIN_MONSTER,actId,subId,monsterGuid})
local callback=function()
local checkInfo=activitiesModel:getSubActInfo(actId,subType,subId)
if not checkInfo or not checkInfo:hasData()or not subActInfo:checkDoing()then
UIManager.error("活动已结算")
worldController:resetRightView()
return
end
local checkData=subActInfo:getExMonster(monsterGuid)
if not checkData then
UIManager.error("怪物已离开")
worldController:resetRightView()
return
end

local args={
dontCloseStage=false,
enterTxt=config.sub_name,
groupId=data.id,
monsterList=monsterCfg.monList,
skipDiscipleInjuryCheck=true,
skipDiscipleStateCheck=true,
statePriorityCheck=false,
isHomeBattle=false,
enterCallBack=function(selectList,zfId)
local checkInfo=activitiesModel:getSubActInfo(actId,subType,subId)
if not checkInfo or not checkInfo:hasData()or not subActInfo:checkDoing()then
UIManager.error("活动已结算")
return
end
local checkData=subActInfo:getExMonster(monsterGuid)
if not checkData then
UIManager.error("怪物已离开")
return
end
fightLaunchController:sendFight(eBattleLaunch.tianmoruqin_sj,selectList,monsterCfg.mapId or 0,zfId,{actId,subType,subId,event,index})
end,
}
fightController.showPrepareWin(fightPreSelectModel.fightType.tianmoruqin_sj,args)
end

local lv=subActInfo:getActLevel()
local items,detail=worldFightModel:getMonsterShowAwards(data.id,lv)
local actRewards=worldFightModel:getMonsterExtraDropActReward(data.id)
local winParam={
groupId=data.id,
name=monsterCfg.name,
icon=monsterCfg.model,
level=lv,
desc=monsterCfg.desc,
items=items,
actRewards=actRewards,
highestType=monsterCfg.monType,
title=config.sub_name,
unitKey=unitKey,
detail=detail,
close=function()
worldController:resetRightView()
end,
challenge=callback,
}

if UIManager:isActive("UIWorldBossWin")then
UIManager:showWindow("UIWorldBossWin",winParam)
else
worldController:changeRightView("UIWorldBossWin",winParam)
end
end
end
end
end


function activitiesHandle_tianmoruqin:reqStartEvent(actId,subId,eventIdx)
local subType=SUB_ACTIVITY_TYPE.eTianMoRuQin
local jstr=jsonHelper.encode({1,eventIdx})
activitiesController:sendProtocol(actSendType.eComonReqHandle,actId,subType,subId,jstr)
end

function activitiesHandle_tianmoruqin:reqNewMonster(actId,subId,monsterIdx,itemId)
local subType=SUB_ACTIVITY_TYPE.eTianMoRuQin
local jstr=jsonHelper.encode({2,monsterIdx,itemId or 0})
activitiesController:sendProtocol(actSendType.eComonReqHandle,actId,subType,subId,jstr)
end

function activitiesHandle_tianmoruqin:reqShareMonster(actId,subId,monsterGuid,shareFlag)
local subType=SUB_ACTIVITY_TYPE.eTianMoRuQin
local jstr=jsonHelper.encode({3,monsterGuid,shareFlag})
activitiesController:sendProtocol(actSendType.eComonReqHandle,actId,subType,subId,jstr)
end

function activitiesHandle_tianmoruqin:reqQingBao(actId,subId,warning)
local subType=SUB_ACTIVITY_TYPE.eTianMoRuQin
local info=activitiesModel:getSubActInfo(actId,subType,subId)
if not info then return false end

local least=info:getQingBaoRefreshLeast()
if least<=0 then
local jstr=jsonHelper.encode({4})
activitiesController:sendProtocol(actSendType.eComonReqHandle,actId,subType,subId,jstr)
info:setQingBaoRefreshLimit()
return true
else
if warning then
UIManager.error(FMT.fmt("{0}后可刷新",timeHelper.format_time_stamp2(least)))
end
return false
end
end

function activitiesHandle_tianmoruqin:reqMonsterDetail(actId,subId,monsterGuid,jumpTab,jumpParam)
local subType=SUB_ACTIVITY_TYPE.eTianMoRuQin
local jstr=jsonHelper.encode({5,monsterGuid})
activitiesController:sendProtocol(actSendType.eComonReqHandle,actId,subType,subId,jstr)

local info=activitiesModel:getSubActInfo(actId,subType,subId)
if info then
info:pushMonsterJump(monsterGuid,jumpTab,jumpParam)
end
end

function activitiesHandle_tianmoruqin:reqMonsterRank(actId,subId,monsterGuid)
local subType=SUB_ACTIVITY_TYPE.eTianMoRuQin
local jstr=jsonHelper.encode({6,monsterGuid})
activitiesController:sendProtocol(actSendType.eComonReqHandle,actId,subType,subId,jstr)
end


function activitiesHandle_tianmoruqin:reqMonsterReward(actId,subId,...)
local subType=SUB_ACTIVITY_TYPE.eTianMoRuQin
local jstr=jsonHelper.encode({7,...})
activitiesController:sendProtocol(actSendType.eComonReqHandle,actId,subType,subId,jstr)
end

function activitiesHandle_tianmoruqin:reqServerKill(actId,subId)
local subType=SUB_ACTIVITY_TYPE.eTianMoRuQin
local jstr=jsonHelper.encode({8})
activitiesController:sendProtocol(actSendType.eComonReqHandle,actId,subType,subId,jstr)
end

function activitiesHandle_tianmoruqin:reqMoneyRefresh(actId,subId)
local subType=SUB_ACTIVITY_TYPE.eTianMoRuQin
local jstr=jsonHelper.encode({9})
activitiesController:sendProtocol(actSendType.eComonReqHandle,actId,subType,subId,jstr)
end

function activitiesHandle_tianmoruqin:reqBookReward(actId,subId,index)
local subType=SUB_ACTIVITY_TYPE.eTianMoRuQin
local jstr=jsonHelper.encode({10,index})
activitiesController:sendProtocol(actSendType.eComonReqHandle,actId,subType,subId,jstr)
end

function activitiesHandle_tianmoruqin:reqEventReward(actId,subId,eventIdx)
local subType=SUB_ACTIVITY_TYPE.eTianMoRuQin
local jstr=jsonHelper.encode({11,eventIdx})
activitiesController:sendProtocol(actSendType.eComonReqHandle,actId,subType,subId,jstr)
end


function activitiesHandle_tianmoruqin.recv_249_130(actId,subId,monsterGuid,monsterId,totalDamage)
local subType=SUB_ACTIVITY_TYPE.eTianMoRuQin

local info=activitiesModel:getSubActInfo(actId,subType,subId)
if not info or not info:hasData()then return end

local monsterIdx=info:updateMonsterDamage(monsterGuid,monsterId,totalDamage)
local bookIdx=info:updateBookKill(monsterId,totalDamage)
local rankRefresh=info:updateRankDamage(monsterGuid,totalDamage)

if monsterIdx then
UIManager:invokeUIMethod('UISubAct_TianMoRuQin_MainWin','on_249_130',actId,subType,subId,monsterIdx)
end
if bookIdx then
UIManager:invokeUIMethod('UISubAct_TianMoRuQin_TuJianWin','on_249_130',actId,subType,subId,bookIdx)
end

reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,subType)
notifySystem:postNotify(notifyConfig.onActTabReddotChange,SUBACT_DEFINETAB_TYPE.eTianMoRuQin_main)
if rankRefresh then
notifySystem:postNotify(notifyConfig.onActTabReddotChange,SUBACT_DEFINETAB_TYPE.eTianMoRuQin_qingbao)
end
end


function activitiesHandle_tianmoruqin.recv_249_131(args)
local subType=SUB_ACTIVITY_TYPE.eTianMoRuQin
local actId=args[1]
local subId=args[2]
local maxBloodLen=args[3]
local maxBloodList=args[4]
local serverKill=args[5]
local moneySec=args[6]
local aimLen=args[7]
local aimList=args[8]
local monsterLen=args[9]
local monsterList=args[10]
local bookFlag=args[11]
local level=args[12]
local posLen=args[13]
local posList=args[14]

local info=activitiesModel:getSubActInfo(actId,subType,subId)
if not info then return end

info:initData(monsterList,aimList,maxBloodList,serverKill,moneySec,bookFlag,level,posList)

UIManager:invokeUIMethod('UISubAct_TianMoRuQin_MainWin','on_249_131',actId,subType,subId)

reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,subType)
notifySystem:postNotify(notifyConfig.onActTabReddotChange,SUBACT_DEFINETAB_TYPE.eTianMoRuQin_main)
notifySystem:postNotify(notifyConfig.onActTabReddotChange,SUBACT_DEFINETAB_TYPE.eTianMoRuQin_qingbao)

if worldController:isInWorld()then
info:onEnterWorld()
end
end



function activitiesHandle_tianmoruqin.recv_249_132(actId,subId,eventInfo)
local subType=SUB_ACTIVITY_TYPE.eTianMoRuQin

local info=activitiesModel:getSubActInfo(actId,subType,subId)
if not info or not info:hasData()then return end

local oEvent=info:getEventData(eventInfo.aimidx)
info:updateEvent(eventInfo,oEvent)

UIManager:invokeUIMethod('UISubAct_TianMoRuQin_EventDialog','refreshContentEx',actId,subType,subId)
UIManager:invokeUIMethod('UISubAct_TianMoRuQin_MainWin','on_249_132',actId,subType,subId,eventInfo.aimidx)

reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,subType)
notifySystem:postNotify(notifyConfig.onActTabReddotChange,SUBACT_DEFINETAB_TYPE.eTianMoRuQin_main)
end


function activitiesHandle_tianmoruqin.recv_249_133(actId,subId,monsterInfo)
local subType=SUB_ACTIVITY_TYPE.eTianMoRuQin

local info=activitiesModel:getSubActInfo(actId,subType,subId)
if not info or not info:hasData()then return end

local change=info:updateMonster(monsterInfo)

info:refreshWorldBeiMonster(monsterInfo.mbidx)

UIManager:invokeUIMethod('UISubAct_TianMoRuQin_MainWin','on_249_133',actId,subType,subId,monsterInfo.mbidx,change)

reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,subType)
notifySystem:postNotify(notifyConfig.onActTabReddotChange,SUBACT_DEFINETAB_TYPE.eTianMoRuQin_main)
notifySystem:postNotify(notifyConfig.onActTabReddotChange,SUBACT_DEFINETAB_TYPE.eTianMoRuQin_qingbao)
end


function activitiesHandle_tianmoruqin.recv_249_134(actId,subId,monsterGuid,source)
local subType=SUB_ACTIVITY_TYPE.eTianMoRuQin

local info=activitiesModel:getSubActInfo(actId,subType,subId)
if not info or not info:hasData()then return end

info:shareMonster(monsterGuid,source)

UIManager.info("分享成功")

UIManager:invokeUIMethod('UISubAct_TianMoRuQin_MonsterDialog',"on_249_134",actId,subId,monsterGuid,source)
end


function activitiesHandle_tianmoruqin.recv_249_135(actId,subId,qbLen,qbList)
local subType=SUB_ACTIVITY_TYPE.eTianMoRuQin

local info=activitiesModel:getSubActInfo(actId,subType,subId)
if not info or not info:hasData()then return end

local haveNew=info:initRankData(qbList)
if haveNew and not UIManager:isActive("UISubAct_TianMoRuQin_QingBaoWin")then
info:markQingBaoXin()
notifySystem:postNotify(notifyConfig.onActTabFlagChange,SUBACT_DEFINETAB_TYPE.eTianMoRuQin_qingbao)
end

UIManager:invokeUIMethod('UISubAct_TianMoRuQin_QingBaoWin',"on_249_135",actId,subType,subId)

reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,subType)
notifySystem:postNotify(notifyConfig.onActTabReddotChange,SUBACT_DEFINETAB_TYPE.eTianMoRuQin_qingbao)
end


function activitiesHandle_tianmoruqin.recv_249_136(args)
local subType=SUB_ACTIVITY_TYPE.eTianMoRuQin
local errorCode=args[1]
local actId=args[2]
local subId=args[3]
local iconInfo=args[4]
local actorName=args[5]
local monsterData=args[6]
local level=args[7]
if errorCode>0 then
local info=activitiesModel:getSubActInfo(actId,subType,subId)
if not info or not info:hasData()then return end

local monCfg=cfgHelper.get1(cfg_monstergroup_get,monsterData.mongroupid)
local maxBloodNum=tonumber(tostring(info:getMaxBloods(monCfg.monType)))
local damageBlood=tonumber(tostring(monsterData.totaldamage))
if damageBlood>=maxBloodNum then
return UIManager.error("怪物已被他人击败")
end

local jumpArgs=info:popMonsterJump(monsterData.mongroupguid)
local jumpParams=nil
local jumpType=nil
if jumpArgs then
jumpType=jumpArgs[2]

if jumpType>0 then

local cTabParam=activitiesController:getOpenWinParam()
if cTabParam==nil or not info:compare(cTabParam.actID,cTabParam.subType,cTabParam.subid)or jumpType~=cTabParam.tab_idx then
return
end

elseif jumpType<0 then
if not worldController:isInWorld()or not worldModel:isSameWorld(-jumpType)then
return
end

else
if not fullScreenUI.isActiveBaseFull()then
return
end
end

jumpParams=jumpArgs[3]
else
return
end

local config=activitiesModel:getSubActivityConfig(subType,subId)
local monsterCfg=cfgHelper.get1(cfg_monstergroup_get,monsterData.mongroupid)
local monType=monsterCfg.monType
local leave=monsterData.sec>0 and(monsterData.sec+config.monster[monType][3])or monsterData.sec
local args={
actId=actId,
subType=subType,
subId=subId,
source={
iconInfo=iconInfo,
actorName=actorName,
},
monster=monsterData.mongroupid,
leaveTime=leave,
people=monsterData.num,
fighted=monsterData.times,
damage=monsterData.totaldamage,
guid=monsterData.mongroupguid,
shareFlag=monsterData.flag,
jumpParams=jumpParams,
jumpType=jumpType,
level=level,
}
UIManager:showWindow("UISubAct_TianMoRuQin_MonsterDialog",args)
else
UIManager.error("天魔已离开")
end
end


function activitiesHandle_tianmoruqin.recv_249_137(args)
local subType=SUB_ACTIVITY_TYPE.eTianMoRuQin

local actId=args[1]
local subId=args[2]
local monsterGuid=args[3]
local monsterId=args[4]
local rankLen=args[5]
local rankList=args[6]or{}

if rankLen>1 then
table.sort(rankList,function(a,b)
return a.actordamage>b.actordamage
end)
end

local args={
actId=actId,
subType=subType,
subId=subId,
guid=monsterGuid,
id=monsterId,
datas=rankList,
}
if UIManager:isActive("UICommonShowPrizeSevenWin")then
UIManager:showWindow("UISubAct_TianMoRuQin_ResultRankDialog",args)
elseif UIManager:isActive("UISubAct_TianMoRuQin_MonsterDialog")then
UIManager:showWindow("UISubAct_TianMoRuQin_RankDialog",args)
end
end


function activitiesHandle_tianmoruqin.recv_249_138(actId,subId,killNum)
local subType=SUB_ACTIVITY_TYPE.eTianMoRuQin

local info=activitiesModel:getSubActInfo(actId,subType,subId)
if not info or not info:hasData()then return end

info:setServerKill(killNum)

UIManager:invokeUIMethod('UISubAct_TianMoRuQin_MainWin',"on_249_138",actId,subType,subId)
end


function activitiesHandle_tianmoruqin.recv_249_139(actId,subId,sec)
local subType=SUB_ACTIVITY_TYPE.eTianMoRuQin

local info=activitiesModel:getSubActInfo(actId,subType,subId)
if not info or not info:hasData()then return end

info:setMoneySec(sec)
end


function activitiesHandle_tianmoruqin.recv_249_140(actId,subId,index)
local subType=SUB_ACTIVITY_TYPE.eTianMoRuQin

local info=activitiesModel:getSubActInfo(actId,subType,subId)
if not info or not info:hasData()then return end

info:setBookFlag(index,1)

UIManager:invokeUIMethod('UISubAct_TianMoRuQin_TuJianWin',"on_249_140",actId,subType,subId,index)

reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,subType)
notifySystem:postNotify(notifyConfig.onActTabReddotChange,SUBACT_DEFINETAB_TYPE.eTianMoRuQin_tujian)
end