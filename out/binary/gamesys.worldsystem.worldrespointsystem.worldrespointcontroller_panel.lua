













function worldResPointController:showMonsterPanel(guid,subIdx,id,level,height)
local battleCfg=cfgHelper.get1(cfg_worldresbattleconfig_get,id)
local cost=battleCfg.cost and battleCfg.cost[1]or nil
local mcfg=cfgHelper.get(cfg_monstergroup_get,battleCfg.groupid)
local lv=mcfg.levelUp and level or mcfg.level
local items,detail=worldFightModel:getMonsterShowAwards(battleCfg.groupid,lv)
local actRewards=worldFightModel:getMonsterExtraDropActReward(battleCfg.groupid)
local unitKey=worldResPointBaseModel:convertUnitKey(guid,subIdx)
local pointData=worldResPointDataModel:getPointData(guid,subIdx)
local winParam={
groupId=battleCfg.groupid,
name=mcfg.name,
icon=mcfg.model,
level=lv,
skills=mcfg.showSkills,
desc=mcfg.desc,
items=items,
actRewards=actRewards,
highestType=mcfg.monType,


title="妖怪信息",
cost=cost,
unitKey=unitKey,
returnHeight=height,
detail=detail,
close=function()
worldController:resetRightView()
end,
challenge=function()
local checkData=worldResPointDataModel:getPointData(guid,subIdx)
if not checkData then
worldController:resetRightView()
UIManager.error("怪物已离开")
return
end
if cost and not moneyModel.checkEnoughMoney(cost[1],cost[2])then
UIManager.error(FMT.fmt("{0}不足",moneyModel.getMoneyName(cost[1])))
gainControl:showGainWin(cost[1])
return
end
local func=function()
worldController:resetRightView()
fightController.showPrepareWin(fightPreSelectModel.fightType.worldMonster,{
enterTxt="妖怪",
isHomeBattle=false,
monsterList=mcfg.monList,
groupId=battleCfg.groupid,
dzCountLimit=battleCfg.number,



enterCallBack=function(selectList,zfId)
fightController:closeSelectStage(false)
UIFullFightPrepareControl:closeUI()

local checkData=worldResPointDataModel:getPointData(guid,subIdx)
if not checkData then
UIManager.error("怪物已离开")
return
end

local disciples=fightPreSelectModel.convertFightStruct2Disciple(selectList)
roleAudioController:BigWorldRoleSpeak(disciples)
if worldTaskController:startMission(worldModel.UNITTYPE.RESPOINT,guid,subIdx,disciples,zfId)then



fightLaunchController:sendFight(eBattleType.worldResPoint,selectList,mcfg.mapId or 0,zfId,{pointData.world,guid,subIdx})

worldController:stopCameraControl()
if not height then
local worldCfg=cfgHelper.get1(cfg_worldconfig_get,worldModel.world)
height=worldCfg.cameraPos[2]
else
local range=worldController:getCameraZoomRange()
if range then
height=Mathf.Clamp(height,range[1],range[2])
end
end
worldController:lookAtUnit(unitKey,height,false,function()
worldController:resumeCameraControl()
end)

end
end})
end
if cost then
local tipsStr=FMT.fmt("剩余{0}不足{1}，是否继续执行？",itemsConfig.getItemName(cost[1]),cost[2])
moneyPlanModel:checkHandle(cost[1],cost[2],func,tipsStr)
else
func()
end
end,
}

if UIManager:isActive("UIWorldBossWin")then
UIManager:showWindow("UIWorldBossWin",winParam)
else
worldController:changeRightView("UIWorldBossWin",winParam)
end
end




function worldResPointController:showEventPanel(guid,subIdx,id)
local pointData=worldResPointDataModel:getPointData(guid)
local eventCfg=cfgHelper.get1(cfg_worldreseventconfig_get,id)
local param={MysteryEventSendType.eResPoint,pointData.world,guid,subIdx,id}

MysteryEventSystem.event_start(SYSTEM_DEFINE.eWorldResPoint,eventCfg.event,{},param)
end

function worldResPointController:showMysteryPanel(guid,subIdx,id)
local mysteryCfg=cfgHelper.get1(cfg_worldresmysteryconfig_get,id)
MysteryController:openEnterWin(mysteryCfg.mystery)
end