






local _MODULENAME="wuXingDianController"

gameState.addListener(def_table(_MODULENAME))
wuXingDianController.name=_MODULENAME
wuXingDianController.data={}

local _EntityManager=CS.EntityManager.Instance

function wuXingDianController:onAppStart()

wuXingDianModel:onAppStart()


socketManager:register_receiver(25,15,wuXingDianController.recv_25_15)
socketManager:register_receiver(25,16,wuXingDianController.recv_25_16)
socketManager:register_receiver(25,17,wuXingDianController.recv_25_17)
socketManager:register_receiver(25,18,wuXingDianController.recv_25_18)
socketManager:register_receiver(25,19,wuXingDianController.recv_25_19)
socketManager:register_receiver(25,20,wuXingDianController.recv_25_20)
socketManager:register_receiver(25,21,wuXingDianController.recv_25_21)
socketManager:register_receiver(25,22,wuXingDianController.recv_25_22)
socketManager:register_receiver(25,23,wuXingDianController.recv_25_23)
socketManager:register_receiver(25,24,wuXingDianController.recv_25_24)
socketManager:register_receiver(25,25,wuXingDianController.recv_25_25)









notifySystem:listenNotify(notifyConfig.onShowPrize,function(...)
self:onShowPrize(...)
end)
notifySystem:listenNotify(notifyConfig.onNewDay,function(...)
self:onNewDay(...)
end)
notifySystem:listenNotify(notifyConfig.onNewDay5am,function(...)
self:onNewDay5am(...)
end)

notifySystem:listenNotify(notifyConfig.home_event,self.onHomeEvent)

notifySystem:listenNotify(notifyConfig.on_system_open,self.onSystemOpen)

notifySystem:listenNotify(notifyConfig.building_event,self.onBuildingEvent)

notifySystem:listenNotify(notifyConfig.onBattleSendOverTime,self.onBattleSendOverTime)

end


function wuXingDianController:onEnterState(isReconnect)
end


function wuXingDianController:onProtocolReq()

end


function wuXingDianController:onLeaveState(isReconnect)
wuXingDianModel:onLeaveState(isReconnect)
self.stamp_21=nil
self.stamp_22=nil
if isReconnect then return end
self:setBattle()
self:removeBuildingModel()
self:clearBackHud()
self:stopBackFight()

self.data={}
end


function wuXingDianController:onLostConnection()

end


function wuXingDianController:onReConnection(isInitPro)

end



function wuXingDianController:send_25_22()
local stamp=timeHelper.getServerShortTime()
if self.stamp_22==nil or self.stamp_22 and(stamp-self.stamp_22)>5 then
socketManager:send_25_22()
self.stamp_22=stamp
return true
end
end

function wuXingDianController:send_25_21(id)
local stamp=timeHelper.getServerShortTime()
if self.stamp_21==nil or(not self.stamp_21[id])or self.stamp_21[id]and(stamp-self.stamp_21[id])>5 then
self.stamp_21=self.stamp_21 or{}
self.stamp_21[id]=stamp
socketManager:send_25_21(id)
return true
end
end

function wuXingDianController:send_25_24(id)
local stamp=timeHelper.getServerShortTime()
if self.stamp_24==nil or not self.stamp_24[id]or self.stamp_24[id]and(stamp-self.stamp_24[id])>5 then
self.stamp_24=self.stamp_24 or{}
self.stamp_24[id]=stamp
socketManager:send_25_24(id)
return true
end
end



function wuXingDianController.recv_25_15(argstable)
wuXingDianModel:onInitData(argstable)
wuXingDianModel:initCurJie()
wuXingDianController:freshReddot()
notifySystem:postNotify(notifyConfig.wuxingta_init)
end

function wuXingDianController.recv_25_16(id,free_recv_id,recv_id,recharge_recv_id)
wuXingDianModel:onRewards(id,free_recv_id,recv_id,recharge_recv_id)
UIManager:callWindowFunc('UIWuXingDianRewardsWin','freshInfo')
UIManager:callWindowFunc('UITouZiWuXingDianRewardsWin','freshInfo')
UIManager:callWindowFunc('UIWuXingDianMainWin','onPrize')
wuXingDianController:freshReddot()
reddotControl.on_change_catch_type(CATCH_TYPE.eWXSDRewards)
end

function wuXingDianController.recv_25_17(id,invest_bit)
local old=wuXingDianModel:getTouZiFlagById(id)
wuXingDianModel:onTouZi(id,invest_bit)
if old~=invest_bit then
UIManager.info('购买成功')
end

AudioManager.playAudio(638)
UIManager:callWindowFunc('UIWuXingDianTouZiWin','freshInfo')
UIManager:callWindowFunc('UIWuXingDianRewardsWin','freshInfo')
UIManager:callWindowFunc('UIWuXingDianMainWin','onTouZi')
UIManager:callWindowFunc('UITouZiWuXingDianRewardsWin','freshInfo')
wuXingDianController:freshReddot()
reddotControl.on_change_catch_type(CATCH_TYPE.eWXSDRewards)
end

function wuXingDianController.recv_25_18(begin_sec,drop_lv)
wuXingDianModel:onSDData(begin_sec,drop_lv)
UIManager:callWindowFunc('UIWuXingDianMainWin','freshSelectBtn')
UIManager:callWindowFunc('UIWuXingDianMainWin','freshSaoDang')
wuXingDianController:freshReddot()
end

function wuXingDianController.recv_25_19(num,is_assistant)
wuXingDianModel:onSaoDang(num)
UIManager:callWindowFunc('UIWuXingDianMainWin','freshSaoDang')
UIManager:callWindowFunc('UIWuXingDianSaoDangWin','freshReddot')
wuXingDianController:freshReddot()
end

function wuXingDianController.recv_25_20(id)
wuXingDianModel:onStarPrize(id)
UIManager:callWindowFunc('UIWuXingDianStarRewardsWin','freshInfo')
UIManager:callWindowFunc('UIWuXingDianMainWin','onShouTongFresh')
wuXingDianController:freshReddot()
end


function wuXingDianController.recv_25_21(len,ranlist,myrank,id)
wuXingDianModel:setRankList(id,myrank,ranlist)
UIManager:callWindowFunc('UIWuXingDianSDRankWin','freshInfo')
UIManager:callWindowFunc('UISubAct_ShiLianMuBiaoRankWin','freshInfo')
wuXingDianController:freshReddot()
end


function wuXingDianController.recv_25_22(len,recordList)
wuXingDianModel:initSTRecord(recordList)
UIManager:callWindowFunc('UIWuXingDianMainWin','onShouTongFresh')
UIManager:callWindowFunc('UIWuXingDianShouTongWin','freshInfo')
wuXingDianController:freshReddot()
end


function wuXingDianController.recv_25_23(len,list)
wuXingDianModel:onSTPrize(list)
UIManager:callWindowFunc('UIWuXingDianMainWin','onShouTongFresh')
UIManager:callWindowFunc('UIWuXingDianShouTongWin','freshInfo')
wuXingDianController:freshReddot()


AudioManager.playAudio(533)
end

function wuXingDianController.recv_25_24(temple_id,len,threeList,myrank)
wuXingDianModel:setTop3RankList(temple_id,threeList)
wuXingDianModel:setMyRank(temple_id,myrank)
UIManager:callWindowFunc('UISubAct_ShiLianMuBiao','refreshRankInfo')
end

function wuXingDianController.recv_25_25(buylayer)
wuXingDianModel:setBuyLayer(buylayer)
UIManager:closeWindow('UIWuXingDianBuyLayerWin')
UIManager:callWindowFunc('UIWuXingDianRewardsWin','freshInfo')
UIManager:callWindowFunc('UIWuXingDianMainWin','onFreshReddot')
UIManager:callWindowFunc('UITouZiWuXingDianRewardsWin','freshInfo')
wuXingDianController:freshReddot()
reddotControl.on_change_catch_type(CATCH_TYPE.eWXSDRewards)
end


function wuXingDianController:onFightResultBaseBtn(this,battleId,param)
param=param[1]
local wxdId=param.temple_id
local layer=param.layer
local maxLayer=wuXingDianModel:getMaxLayer(wxdId)
local hasNext=layer<maxLayer
local isSD=wuXingDianConfig.isSD(wxdId)
local quitCallBack=function()
local battle=fightModel:getBattle(battleId)
local entities=battle:getEntities()

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
local func=function()
fightController:closeBattle(battleId)

local slayer=nil
if not wuXingDianConfig.isSD(wxdId)then
slayer=layer
end
UIFullWuXingDianControl:showWuXingDian({wxdId=wxdId,layer=slayer})
wuXingDianModel:setInFight(false)
end
wuXingDianController:clearRewards()
loadingControl.openCloud(func,nil,true)
end
local continueCallBack=function(outtime)
local battle=fightModel:getBattle(battleId)
local entities=battle:getEntities()

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
local func=function()
fightModel:onBattleContinue(battleId)
local ret,typo=wuXingDianController:startFight(wxdId,layer+1)
if not ret then
if typo==2 then
fightModel:removeBattle(battleId)
wuXingDianController:showPrepareWin(wxdId,layer+1)
else
loadingControl.closeCloud()
fightController:closeBattle(battleId)
end
else
fightModel:removeBattle(battleId)
end
end
wuXingDianController:clearRewards()
loadingControl.openCloud(func,1.5)
end
if hasNext then

return fightResultWinConfig:getBaseWinParam(this.baseWin,3,'继续挑战',continueCallBack,"退 出",quitCallBack,5,false)



else
return fightResultWinConfig:getBaseWinParam(this.baseWin,1,"退 出",quitCallBack)
end
end



function wuXingDianController:onFightFailResultBaseBtn(this,battleId,param)
param=param[1]
local wxdId=param.temple_id
local layer=param.layer
local quitCallBack=function()
local func=function()
fightController:closeBattle(battleId)
local slayer=nil
if not wuXingDianConfig.isSD(wxdId)then
slayer=layer
end
UIFullWuXingDianControl:showWuXingDian({wxdId=wxdId,layer=slayer})
end
wuXingDianController:clearRewards()
loadingControl.openCloud(func,nil,true)
end
local continueCallBack=function()
local battle=fightModel:getBattle(battleId)
if battle then
battle:hideAllEntity()
battle:stopAllEffect()
battle:resumeMusic()

end
wuXingDianController:clearRewards()
fightModel:removeBattle(battleId)
wuXingDianController:showPrepareWin(wxdId,layer)
end
return fightResultWinConfig:getBaseWinParam(this.baseWin,2,'重新挑战',continueCallBack,"退 出",quitCallBack)
end

function wuXingDianController:showPrepareWin(wxdId,layer)
local isSD=wuXingDianConfig.isSD(wxdId)
if wuXingDianModel:isFinishMaxLayer(wxdId)then
if isSD then
UIManager.error('本期圣殿已通关')
return
else
if wuXingDianModel:isPassMaxStar(wxdId,layer)then
UIManager.error('本殿已通关')
return
end
end
end
layer=layer or wuXingDianModel:getCurLayer(wxdId)

local allData=UIDiscipleModel:getAllDiscipleData()
local dzlist={}
local dzdatalist={}
for i,v in pairs(allData)do
local dzguid=v.netData.net.discipleguid
if wuXingDianModel:canFightLingGen(dzguid,wxdId,layer)then

dzlist[#dzlist+1]=dzguid
end
end

local lglist=wuXingDianModel:getFightLingGen(wxdId,layer)
local lgid=lglist[1]
local prepareLgSprite=wuXingDianConfig.getCfg(wxdId).prepareLgSprite
local lgbgParam=prepareLgSprite[0]
local lgParam=prepareLgSprite[lgid]
local groupID=wuXingDianModel:getMonsterGroupId(wxdId,layer)
local monsterList=cfgHelper.get2(cfg_monstergroup_get,groupID,'monList')
local name=wuXingDianConfig.getFullName(wxdId)
local layerCfgEx=wuXingDianModel:getLayerCfgEx(wxdId,layer)
local view_fight=layerCfgEx.view_fight


local faZeList2Args={}

local layerfzlist=wuXingDianModel:getLayerFaZeList(wxdId,layer)or{}
local len=#layerfzlist
local newfaze=len>0
if len>0 then
for i=1,len do
local fzId=layerfzlist[i]
local fzlv=1
local fzRuleCfg=cfgHelper.getSSlawRule(fzId)
local hasParam=fzRuleCfg.descparm and fzRuleCfg.descparm[fzlv]and true or false
local fzdesc=not hasParam and fzRuleCfg.desc or
string.format(fzRuleCfg.desc,unpack(fzRuleCfg.descparm[fzlv]))
faZeList2Args[#faZeList2Args+1]={name=fzRuleCfg.name,icon=fzRuleCfg.image,desc=fzdesc}
end
end

local layerCfg=wuXingDianModel:getLayerCfg(wxdId,layer)
local fzlist=layerCfg.faze_list2 or{}
local len=#fzlist
if len>0 then
for i=1,len do
local fzId=fzlist[i]
local fzlv=1
local fzRuleCfg=cfgHelper.getSSlawRule(fzId)
local hasParam=fzRuleCfg.descparm and fzRuleCfg.descparm[fzlv]and true or false
local fzdesc=not hasParam and fzRuleCfg.desc or
string.format(fzRuleCfg.desc,unpack(fzRuleCfg.descparm[fzlv]))
faZeList2Args[#faZeList2Args+1]={name=fzRuleCfg.name,icon=fzRuleCfg.image,desc=fzdesc}
end
end

local slfzlist=wuXingDianModel:getShiLianFaZeList(wxdId,layer)
local fzId=wuXingDianModel:getShiLianFaZeId(wxdId,layer)
local fzdesc=wuXingDianModel:getShiLianFaZeDesc(wxdId)
local fzRuleCfg=cfgHelper.getSSlawRule(fzId)
faZeList2Args[#faZeList2Args+1]={name=fzRuleCfg.name,icon=fzRuleCfg.image,desc=fzdesc}
local sdfzlv=isSD and layerCfgEx.train_faze_lv or 1

local len=#slfzlist or{}
if len>1 then
for i=2,len do
local fzId=not isSD and slfzlist[i][1]or slfzlist[i]
local fzlv=not isSD and slfzlist[i][2]or sdfzlv
local fzRuleCfg=cfgHelper.getSSlawRule(fzId)
local hasParam=fzRuleCfg.descparm and fzRuleCfg.descparm[fzlv]and true or false
local fzdesc=not hasParam and fzRuleCfg.desc or
string.format(fzRuleCfg.desc,unpack(fzRuleCfg.descparm[fzlv]))
faZeList2Args[#faZeList2Args+1]={name=fzRuleCfg.name,icon=fzRuleCfg.image,desc=fzdesc}
end
end
local extraWin=not isSD and'UIWuXingDianFightPrepareWin'or'UIWuXingDianPrepareFaZeWin'
local star_bits=wuXingDianModel:getPassLayerStar(wxdId,layer)
local extraParams={wxdId=wxdId,layer=layer,star_bits=star_bits}
local layerTxt=FMT.fmt('第{0}层',layer)
local winArgs=
{
enterTxt=name,
lockSelect=dzlist,
defTeamLingGenLimit={lgbgParam,lgParam},
groupId=groupID,
monsterList=monsterList,
showZhenFa=false,
skipShouYuanCheck=true,
monsterFight=view_fight,
skipDiscipleStateCheck=true,
faZeList2Args=faZeList2Args,
faZeList2Default=false,
place=layerTxt,
statePriorityCheck=false,
faZe2Reddot=newfaze,
closeByCloud=true,
closeByCloudDelay=1,
extraWin=extraWin,
extraParams=extraParams,
cancelCallBack=function()
UIManager:closeWindow("UIRawImageBackWin")
local slayer=nil
if not wuXingDianConfig.isSD(wxdId)then
slayer=layer
end
UIFullWuXingDianControl:showWuXingDian({wxdId=wxdId,layer=slayer})
wuXingDianModel:setInFight(false)
end,
enterCallBack=function(teamList,zfId)
local mapId=cfgHelper.get2(cfg_monstergroup_get,groupID,"mapId")
local fightKey=fightLaunchController:sendFight(eBattleLaunch.wuxingdian,teamList,mapId or 0,zfId or 0,{wxdId,layer})
self.fightKey=fightKey

local flag=dialogueRepeatRemindModel.getRepeatVis(REPEAT_TIME_TYPE.eDay,REPEAT_TYPE.eWXSDFight)
if not flag and wuXingDianConfig.isSD(wxdId)then
dialogueRepeatRemindModel.setRepeatVis(REPEAT_TIME_TYPE.eDay,REPEAT_TYPE.eWXSDFight,true)
end
end,
}
wuXingDianModel:setInFight(true)
local fightType=fightTeam[lgid]
wuXingDianController:clearRewards()
fightController.showPrepareWin(fightType,winArgs,nil,true)
end

function wuXingDianController:onShowPrize(prizeType,rewards,effectData)
if prizeType==ePrizeType.eWuXingDian then
self.prizeRewards=rewards
end
end

function wuXingDianController:onNewDay()
local oldjie,oldStamp=wuXingDianModel:getCurJie()
local newjie,newStamp=wuXingDianModel:getCurJieByCfg()
if oldjie~=newjie then
wuXingDianModel:resetDataOnNewJie(newjie,newStamp)
UIManager:callWindowFunc('UIWuXingDianMainWin','freshInfo')
UIManager:closeWindow('UIWuXingDianRewardsWin')
UIManager:closeWindow('UIWuXingDianSaoDangWin')
UIManager:closeWindow('UIWuXingDianTouZiWin')
end
wuXingDianController:createBuildingModel()
end

function wuXingDianController:onNewDay5am()
wuXingDianModel:onSaoDang(0)
UIManager:callWindowFunc('UIWuXingDianMainWin','freshSaoDang')
wuXingDianController:createBuildingModel()
end

function wuXingDianController.onHomeEvent(etype,args1,args2)
if etype==homeEvent.eEnterHome then
wuXingDianController:createBuildingModel()
wuXingDianController:initBackHud()
elseif etype==homeEvent.eLeaveHome then
wuXingDianController:removeBuildingModel()
wuXingDianController:clearBackHud()
end
end


function wuXingDianController.onBattleSendOverTime(fightType,fightKey)
if fightKey==wuXingDianController.fightKey then
UIManager:closeWindow('UIWuXingDianFightFaZeWin')
end
end

function wuXingDianController.onBuildingEvent(etype,args1,args2,args3)
if etype==buildingEvent.buildComplete then
if args1==mapIdType.zhufeng and args3==SLG_SYSTEM_TYPE.eShiLianTa then
wuXingDianController:createBuildingModel()
end
elseif etype==buildingEvent.zongmenLevelUp then
wuXingDianController:createBuildingModel()
end
end

function wuXingDianController.onSystemOpen(sysid)
if sysid~=SYSTEM_DEFINE.eWuXingDian then return end
if not isometricMapSystem:IsInHome()then return end
wuXingDianController:createBuildingModel()
end



function wuXingDianController:getRewards()
return self.prizeRewards
end

function wuXingDianController:clearRewards()
self.prizeRewards=nil
end

function wuXingDianController:canCreateBuild()
local ret=systemModel.isOpen(SYSTEM_DEFINE.eWuXingDian)
if not ret then return false end
local build_id=SLG_SYSTEM_TYPE.eShiLianTa
local bdData=zongmenModel:findBuildingDataByID(mapIdType.zhufeng,build_id)
if bdData==nil then return false end
return true
end

function wuXingDianController:createBuildingModel()
if not self:canCreateBuild()then return end
if not mainControl:isSceneType(eSceneType.eZongmen)then return end
local sfId=mapIdType.zhufeng
local modelArgs=cfgHelper.getdef(cfg_fiveelementsholytempleconfig,'model')
for i,v in ipairs(modelArgs)do
local wxdId=i
if self.models==nil or self.models[wxdId]==nil then
local isOpen=wuXingDianModel:isWXDOpen(wxdId)
if isOpen then
if self.models==nil then self.models={}end
local model=v[1]
local posId=v[2]
local poscfg=cfg_monijyposidxconfig_get(posId)
local vector3pos=Vector3Int(poscfg.x,poscfg.y,0)
local pos=_MapManager.GetCellCenterWorld(sfId,vector3pos,mapLayer.Data)
local entity=isometricMapSystem:createModelEntity(model)
_MapManager.SetPosition(entity.GUID,vector3pos)
self.models[wxdId]=entity
wuXingDianController:freshReddot()
end
end
end
end

function wuXingDianController:removeBuildingModel()
if self.models==nil then return end
for _,entity in ipairs(self.models)do
_EntityManager:RemoveEntity(entity.GUID)
end
self.models=nil
end

function wuXingDianController:getBattle(clear)
local battleId=self.battleId
if clear then
self.battleId=nil
end
return battleId
end

function wuXingDianController:setBattle(battleId)
self.battleId=battleId
end

function wuXingDianController:setBackFight(flag)
self.inBackFight=flag
end

function wuXingDianController:isInBackFight()
return self.inBackFight or false
end


function wuXingDianController:onStartBattle(battle,result,logIdx,data)
loadingControl.closeCloud()
if result==fightResultType.Victory then
wuXingDianModel:onFinishLayer(data)
wuXingDianController:freshReddot()
end
local wxdId=data.temple_id
data.battleId=battle
self.battleData=table.deepCopy(data)
wuXingDianController:setBattle(battle)
if not self:isInBackFight()then
isometricMapSystem:enterBattleMode()
UIManager:showWindow('UIWuXingDianFightFaZeWin',data)
end
end


function wuXingDianController:onCompleteBattle(battle,result,logIdx,showWindow,isReconnet,data)
if not showWindow then
if result==fightResultType.Victory then
if not wuXingDianController:continueBackFight(data)then
wuXingDianController:stopBackFight()
end
else
wuXingDianController:stopBackFight()
end
fightController:closeBattle(battle)
else
if result==fightResultType.Lose then
local rewards=self.prizeRewards
local winArgs={
extraWin="UIWorldBattleLoseWin",
extraParams={
items=rewards,
title=nil,
},
}
UIManager:showWindow("UICommonLoseWin",winArgs)
else
local rewards=self.prizeRewards
local winArgs={
extraWin="UIWorldBattleVictoryWin",
extraParams={
items=rewards,
title=nil,
},
}
UIManager:showWindow("UICommonVictoryWin",winArgs)
end
end
end


function wuXingDianController:onCloseBattle(battle,result,logIdx,data)
UIManager:closeWindow('UIWuXingDianFightFaZeWin')
if fightController:isBattlePlaying(battle)then
isometricMapSystem:leaveBattleMode()
wuXingDianController:enterBackFight()
end
end



function wuXingDianController:onResultComplete(battle,result,logIdx,data)
wuXingDianController:stopBackFight()
end

function wuXingDianController:onOpenPlayingBattle(battle)
local battleData=self.battleData
UIManager:showWindow('UIWuXingDianFightFaZeWin',battleData)
end


function wuXingDianController:stopBackFight()
wuXingDianController:clearBackHud()
wuXingDianController:setBackFight(false)
buildTiaoZhanModel:clearShiLianTaFightType(buildShiLianTaFightType.eWuXingDian)
end


function wuXingDianController:enterBackFight()
wuXingDianController:createBackHud()
wuXingDianController:setBackFight(true)
buildTiaoZhanModel:setShiLianTaFightType(buildShiLianTaFightType.eWuXingDian)
end


function wuXingDianController:continueBackFight(data)
local wxdId=data.temple_id
if not wuXingDianConfig.isSD(wxdId)then return false end

local fightType=buildTiaoZhanModel:getShiLianTaFightType()
if fightType~=buildShiLianTaFightType.eWuXingDian then return false end

local layer=data.layer+1

return wuXingDianController:startFight(wxdId,layer,true)
end

function wuXingDianController:startFight(wxdId,layer,inback)
local maxLayer=wuXingDianModel:getMaxLayer(wxdId)
if layer>maxLayer then return false,1 end

local groupID=wuXingDianModel:getMonsterGroupId(wxdId,layer)
local mapId=cfgHelper.get2(cfg_monstergroup_get,groupID,'mapId')
local lglist=wuXingDianModel:getFightLingGen(wxdId,layer)
local lgid=lglist[1]
local fightType=fightTeam[lgid]
local guidList=fightPreSelectModel:getTeamData(fightType)
if guidList==nil then return false,2 end

if inback then
self:enterBackFight()
end

local teamlist={}
for i=1,fightPreSelectModel.maxPosNum do
if guidList[i]then
teamlist[i]={1,guidList[i]}
else
teamlist[i]={0,int64.zero}
end
end

local fightKey=fightLaunchController:sendFight(eBattleLaunch.wuxingdian,teamlist,mapId or 0,0,{wxdId,layer},inback)
self.fightKey=fightKey
return true
end


function wuXingDianController:isHideExitBtn(data)
local layer=data.layer
local wxdId=data.temple_id
if wuXingDianConfig.isSD(wxdId)and
layer~=wuXingDianModel:getMaxLayer(wxdId)then
return false
end
return true
end

function wuXingDianController:enterFightScene()
local battleId=self:getBattle()
if battleId and fightController:isBattlePlaying(battleId)then
wuXingDianController:stopBackFight()
fightController:openBattle(battleId)
isometricMapSystem:enterBattleMode()
return true
end
return false
end

function wuXingDianController:addHUD(hudid)
self.hudid=hudid
end

function wuXingDianController:getHUD()
return self.hudid
end

function wuXingDianController:isHUD(hudid)
return self.hudid==hudid
end

function wuXingDianController:createBackHud()
if not self:canCreateBuild()then return end
local battleId=self:getBattle()
local hud=self:getHUD()
local buildinfo=shiLianTaModel:getBuildingData()
local sdType=wuXingDianConfig.getSDType()
if battleId then
if not hud then
self.hudid=hudControl:addHUD(INSTANCE_TYPE.eShiLianTa,buildinfo.entityId,Vector3(-1.2,0.7,0),false,true,function(id)
if self:isHUD(id)then
local bw=hudControl:getHUDWidget(id)
bw:SetChildUIModelShowTarget(0,2076,1,{},eAnimationID.stand,false,false,0,nil)
bw:SetChildText(1,FMT.fmt("当前通关{0}层",wuXingDianModel:getFinishLayer(sdType)))
bw:SetChildButtonClick(2,function()
wuXingDianController:enterFightScene()
end)
else
hudControl:removeHUD(id)
end
end)
else
local bw=hudControl:getHUDWidget(hud)
if bw==nil then return end
bw:SetChildText(1,FMT.fmt("当前通关{0}层",wuXingDianModel:getFinishLayer(sdType)))
end
end
end

function wuXingDianController:clearBackHud()
local hud=self:getHUD()
if hud then
hudControl:removeHUD(hud)
end
self:addHUD()
end

function wuXingDianController:initBackHud()
if not self:isInBackFight()then return end
local battleId=self:getBattle()
if battleId and fightController:isBattlePlaying(battleId)then
wuXingDianController:createBackHud()
end
end

function wuXingDianController:getWuXingDianReddotFunc(refresh)

if self.models==nil then return false end


local ret=wuXingDianModel:isCanSaoDang()
if ret then return true end


if wuXingDianModel:isOpenSDByData()then
local sdId=wuXingDianConfig.getSDType()
local isRead=wuXingDianModel:isOpenTitle(sdId)
local ret=not isRead or wuXingDianModel:hasAnyPrize(sdId)
if ret then return true end
end


if wuXingDianModel:hasAnyPrize(1)then return true end


if wuXingDianModel:isCanAnyPrizeStar()then return true end


if wuXingDianModel:hasAnyNewLayer()then return true end

return false
end

function wuXingDianController:freshReddot()
local oldReddot=self.mainReddot
self.mainReddot=wuXingDianController:getWuXingDianReddotFunc()
if oldReddot==self.mainReddot then return end
wuXingDianController:callReddotFunction()
end

function wuXingDianController:getReddot()
return self.mainReddot or false
end

function wuXingDianController:callReddotFunction()
local build_id=SLG_SYSTEM_TYPE.eShiLianTa
local bdData=zongmenModel:findBuildingDataByID(mapIdType.zhufeng,build_id)
if bdData==nil then return end
hudControl:refreshBuildingStatusHUD(bdData.un_build_id)
end