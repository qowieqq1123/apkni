
UIFullYanFaGeControl=gameState.addListener(fullScreenUI.create())

function UIFullYanFaGeControl:onAppStart()

local _showTrainWindow=function(...)
self:showTrainWindow(...)
end
local _showBattleWindow=function(...)
self:showBattleWindow(...)
end

local menulist=
{

{tabType=FULL_TAB_TYPE.eYanFaGe_Train,callback=_showTrainWindow},

{tabType=FULL_TAB_TYPE.eYanFaGe_Battle,callback=_showBattleWindow},
}

local args=
{
menulist=menulist,
fullType=FULL_TYPE.eYanFaGe,
skinType=fullScreenSkinType.eSkin1,
attachName={'entityId'}
}
self:initUI(args)
end

function UIFullYanFaGeControl:onEnterState()

end


function UIFullYanFaGeControl:onLeaveState()

end

function UIFullYanFaGeControl:showMainWindow(argstable)
local tabType=FULL_TAB_TYPE.eYanFaGe_Train
if argstable.args~=nil and argstable.args.tabType~=nil then
tabType=argstable.args.tabType
end
if argstable and argstable.data then
argstable.entityId=argstable.data.entityId
end
if tabType==FULL_TAB_TYPE.eYanFaGe_Train then
self:showTrainWindow(argstable)
elseif tabType==FULL_TAB_TYPE.eYanFaGe_Battle then
self:showBattleWindow(argstable)
end
end

function UIFullYanFaGeControl:showMainWindowEx(tabType)
if not zongmenModel:haveBuildByBuildId(SLG_SYSTEM_TYPE.eYanFaGe)then
return false
end
local data=zongmenModel:getBuildingDataByBdType(mapIdType.zhufeng,SLG_SYSTEM_TYPE.eYanFaGe)
local bdData=data[1]
UIFullYanFaGeControl:showMainWindow({data=bdData,args={tabType=tabType}})
return true
end

function UIFullYanFaGeControl:showTrainWindow(argstable)
local tabType=FULL_TAB_TYPE.eYanFaGe_Train
local args={
tabType=tabType,
showBg=true,
viewNames={'UIYanFaGe_trainWin'},
viewArgs={['UIYanFaGe_trainWin']=argstable},
}
return self:showUI(args)
end


function UIFullYanFaGeControl:showBattleWindow(argstable)
local tabType=FULL_TAB_TYPE.eYanFaGe_Battle
local args=
{
tabType=tabType,
showBg=true,
viewNames={'UIYanFaGe_battleWin'},
viewArgs={['UIYanFaGe_battleWin']=argstable},
}
return self:showUI(args)
end

function UIFullYanFaGeControl:showYanFaGeFightPrepare(prepareType)
local teamData
local mapId
local monsterList
local groupId
local enterCallBack
local cancelCallBack
if prepareType and prepareType==2 then

mapId=818001
local teamNum=2
teamData=fightPreSelectModel:getMulTeamSaveData(eFightPreSelectType.yanfage,teamNum)
enterCallBack=function(guidList,zfId)
local leftData=guidList[1]
local leftGuidList=leftData[2]
local rightData=guidList[2]
local rightGuidList={}
for i,v in ipairs(rightData[2])do

local guid=v[2]
rightGuidList[i]=guid
end
fightLaunchController:sendFight(eBattleLaunch.yanfage,leftGuidList,mapId or 0,zfId,{#rightGuidList,rightGuidList})
end
cancelCallBack=function()
UIFullYanFaGeControl:showMainWindowEx(FULL_TAB_TYPE.eYanFaGe_Battle)
end
else

local yfgCfg=cfgHelper.get(cfg_yanfageconfig_get,1)
local monsterGroupId=yfgCfg.monster_group_id
local mcfg=cfgHelper.get(cfg_monstergroup_get,monsterGroupId)
monsterList=mcfg.monList
groupId=monsterGroupId
enterCallBack=function(guidList,zfId)
fightLaunchController:sendFight(eBattleLaunch.yanfage,guidList,mcfg.mapId or 0,zfId,{0,{}})
end
cancelCallBack=function()
UIFullYanFaGeControl:showMainWindowEx(FULL_TAB_TYPE.eYanFaGe_Train)
end
end

fightController.showPrepareWin(fightPreSelectModel.fightType.yanfage,
{
prepareType=prepareType,
enterTxt='演法阁',
skipDiscipleInjuryCheck=true,
skipDiscipleStateCheck=true,
skipChuiWeiCheck=false,
isCheckInjuryState=true,
statePriorityCheck=false,
isHomeBattle=true,
monsterList=monsterList,
groupId=groupId,
multipleTeams=teamData,
mapId=mapId,
enterCallBack=enterCallBack,
cancelCallBack=cancelCallBack,
}
)
end