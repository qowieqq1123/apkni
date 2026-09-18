fightDebug={}




function reloadFightScript()
if appUtils.enableProfiler then return end
if strict_if_strict then
strict_if_strict(false)
end
reload"lua.gameSys.fightSystem.battle.fightBattle"
reload"lua.gameSys.fightSystem.battle.fightEntity"
reload"lua.gameSys.fightSystem.battle.fightRound"
reload"lua.gameSys.fightSystem.battle.action.fightActionMrg"
reload"lua.gameSys.fightSystem.battle.action.fightBaseAction"
reload"lua.gameSys.fightSystem.battle.action.fightAddBuffAction"
reload"lua.gameSys.fightSystem.battle.action.fightBaseAction"
reload"lua.gameSys.fightSystem.battle.action.fightBuffAction"
reload"lua.gameSys.fightSystem.battle.action.fightChangeHpAction"
reload"lua.gameSys.fightSystem.battle.action.fightDelBuffEffectAction"
reload"lua.gameSys.fightSystem.battle.action.fightDeleteBuffAction"
reload"lua.gameSys.fightSystem.battle.action.fightDispelBuffAction"
reload"lua.gameSys.fightSystem.battle.action.fightDispelBuffEffectAction"
reload"lua.gameSys.fightSystem.battle.action.fightReboundAction"
reload"lua.gameSys.fightSystem.battle.action.fightResurrectionAction"
reload"lua.gameSys.fightSystem.battle.action.fightSkillAction"
reload"lua.gameSys.fightSystem.battle.action.fightSkillDodgeAction"
reload"lua.gameSys.fightSystem.battle.action.fightStealBuffAction"
reload"lua.gameSys.fightSystem.battle.action.fightSkillActionAction"
reload"lua.gameSys.fightSystem.battle.action.fightGMAction"
reload"lua.gameSys.fightSystem.battle.action.fightNewMonAction"
reload"lua.gameSys.fightSystem.battle.action.fightChangePropAction"
reload"lua.gameSys.fightSystem.battle.action.fightGemPowerAction"
reload"lua.gameSys.fightSystem.battle.action.fightSkillActionTargetAction"
fightActionMrg:init()
if strict_if_strict then
strict_if_strict(true)
end
end

local battleObj
local config_init=false
local replayInit=function(clearStage)
if config_init==false then
userActorSetting.init('fightDebug')
config_init=true
fightManager.init()
UIManager:closeAllWindow()
end

if battleObj~=nil then
battleObj:skipProcess()
battleObj:removeAllEntity()
battleObj=nil
end
if clearStage then
fightManager.clearStage()
end
UIManager:showWindow('UIFightMainHUD')
updateState.closeLoading()
end

function fightDebug.getBattleObj()
return battleObj
end
shaderHelper.setCommomEffectFadeBaseHeight(fightModel.fightWorldBaseHeight)
function fightDebug.showSelectStage()
replayInit(true)
fightController:closeSelectStage()
preSelect=fightPreSelect()
preSelect:showSelectStage()
preSelect:addEntity(1,'',2199056875521)
preSelect:addEntity(6,'',0,1)
preSelect:addEntity(6,'',0,2)

fightManager.setCameraActive(true,fightCameraMode.fight)
end


function fightDebug.reloadScript(file)
if appUtils.enableProfiler then return end
strict_if_strict(false)

reload(file)
strict_if_strict(true)
end


function fightDebug.retargetActionPara(id,paras)
local actionCfg=cfgHelper.get1(cfg_skillaction_get,id)
if actionCfg~=nil then
for key,value in pairs(paras)do
actionCfg[key]=value
end
end
end


function fightDebug.retargetSkillPara(id,paras)

local skillCfg=cfgHelper.get1(cfg_skillconfig_get,id)
if skillCfg~=nil then
for key,value in pairs(paras)do
skillCfg[key]=value
end
end
end

























function reloaFightBehaviorConfig()
local content=fileHelper.readFileEx("data/config/fightbehaviorconfig.lua")
_fightbehaviorconfig=loadstring(content)()
return _fightbehaviorconfig
end

local emptyFightStage="[[0,0,1],{},{},[0,0],[[{},{},{},{}]]]"


function fightDebug.showStage(para)
fightDebug.show=true
para=para or{}
if para.stageTypo~=nil then
emptyFightStage[1][3]=para.stageTypo
end
replayInit(true)

battleObj=fightBattle(emptyFightStage,-1,nil,nil)
battleObj.debug=true
fightController.curBattle=battleObj
UIFullFightControl:showFightMain(fightController.curBattle)
battleObj:start(true)

end

function fightDebug.resetCamera(stageCfg)
local cameraPara=stageCfg.initCamera
if cameraPara then
fightManager.initCamera(Vector3.New(cameraPara[1][1],cameraPara[1][2],cameraPara[1][3]),
Vector3.New(cameraPara[2][1],cameraPara[2][2],cameraPara[2][3]),
Vector3.New(cameraPara[3][1],cameraPara[3][2],cameraPara[3][3]),
Vector3.New(cameraPara[4][1],cameraPara[4][2],cameraPara[4][3]),
cameraPara[5])
else
fightManager.resetCamera()
fightManager.setCameraActive(true,fightCameraMode.fight)
end
end

function fightDebug.changeStage(stageID,onFinish)
local stageCfg=fightModel:getStage(stageID)
fightDebug.resetCamera(stageCfg)
fightManager.loadStage(stageCfg.assetbundle,onFinish)
fightManager.initCameraEffect(stageCfg)
fightManager.playSceneEffect(stageCfg)
end

function fightDebug.addEntity(index,typo,baseInfo,modelData,weapon)
if battleObj~=nil then
local posInfo=fightModel:getPosInfo(index)
local name="缺少配置"
if posInfo~=nil then
if posInfo.flipX then
name=FMT.fmt("右侧{0}",index)
else
name=FMT.fmt("左侧{0}",index)
end
end

local data=fightDebug.getImageData(typo,name,baseInfo,modelData,weapon)
battleObj:addEntity(index,data)
end
end

function fightDebug.removeEntity(index)
if battleObj~=nil then
battleObj:removeEntity(index)
end
end


function fightDebug.getEntity(index)
if battleObj~=nil then
return battleObj:getEntity(index)
end
return nil
end

function fightDebug.getImageData(typo,name,baseInfo,modelData,weapon)
if typo==fightCommonTag.typoDizi then
local info={}
info.typo=fightEntityType.diZi
local attr={}
info.attr=attr
attr[entityAttr.hp]=100000
attr[entityAttr.max_hp]=100000
info.name=name
local image,outSideImage=UIDiscipleModel.getDiscipleFightModelInfo(baseInfo,modelData,weapon,1.0)
info.model=outSideImage
info.image=image
return info

elseif typo>fightCommonTag.typoDizi then
return fightModel:createMonsterInfo(typo,1000000,10000)
end
end

local testSkillRound=
{
[1]="[0,0,0],[[1,1,60000,1,[60000,[6,[3,6,106,1]]]]]",
"[[1,1, 60000,1,[60000,[3,7,1000,0]]]]]"
}
function fightDebug.fightReplaySkill(strData)
if type(strData)=='number'then
strData=testSkillRound[strData]
end
battleObj.debug=true

if strData~=nil then
local roundData={}
roundData[1]={}
roundData[2]=jsonHelper.decode(strData)
roundData[3]={}
roundData[4]={}

battleObj:playRound(roundData)
end
end


function fightReplay(reportName,showStage,reloadScript,genWenZiReport)
replayInit(true)
local filename=''
if deviceHelper.isRunEditor()then
filename=FMT.fmt('fightReport/{0}.json',reportName)
else
filename=FMT.fmt('{0}.json',reportName)
end
local clientReport=jsonHelper.readFile(filename)

if clientReport~=nil then
UIManager:closeWindow('UIFightMainTop',battleObj)
if battleObj~=nil then
battleObj:skipProcess()
battleObj:removeAllEntity()
battleObj=nil
end

fightManager.clearStage()
battleObj=fightBattle(clientReport["原始战报"],-1,nil,nil)
fightController.curBattle=battleObj
battleObj:start(showStage)

if genWenZiReport then
local weiziReportFileName=FMT.fmt('fightReport/{0}-wenzi.txt',reportName)
local wenziFightReport=clientReport['战斗过程']
local str=''
for i,v in ipairs(wenziFightReport)do
str=FMT.fmt("{0}{1}\n",str,v)
end
fileHelper.writeFileEx(weiziReportFileName,str)
end








end
end

function playCustomFight(id,showStage,reloadScript)
replayInit(true)
local report=fightModel:getFightReport(id)
if report then
battleObj=fightBattle(report,-1,nil,nil)
fightController.curBattle=battleObj
UIFullFightControl:showFightMain(battleObj)
battleObj:start(showStage)
end
end

function fightDebug:printStatisticsTimes()
if battleObj then
battleObj:printStatisticsTimes()
end
end


function playCustomFightStr(reportStr)
replayInit(false)
if reportStr then
fightManager.cleanEntity()
battleObj=fightBattle(reportStr,-1,nil,nil)
fightController.curBattle=battleObj
UIFullFightControl:showFightMain(battleObj)
battleObj:start(true)
end
end

function fightDebug:progressBuild(buildGroups,deltaTime,delayComplete,startX,startY)
if fightDebug.createTimer~=nil then
fightDebug.createTimer:cancel()
fightDebug.createTimer=nil

end

local buildInfos={}
for i,v in ipairs(buildGroups)do
buildInfos[i]={index=i,id=v,select=false,create=false,complete=false}
end
fightDebug.recv_3_31={}

local buildIndex=1
local timePass=0
local completeCheckTime=0-delayComplete
local completeIndex=1
local initPos=false
local createFun=function()
timePass=timePass+Time.deltaTime
local info=buildInfos[buildIndex]
if info~=nil then
if not info.select then
local win=UIManager:findActiveWindow("UILayoutWin")
if win~=nil then
if not initPos and startX~=nil then
initPos=true
win.lastBDPos=_MapManager.ToVector3Int(startX,startY,0)
end

win:OnSelectItem(info.id)
info.select=true
end
else
if not info.create and timePass>deltaTime and fightDebug.createOkFun then
timePass=timePass-deltaTime
fightDebug.createOkFun()
buildIndex=buildIndex+1
fightDebug.createOkFun=nil
end
end
else
if fightDebug.createCancelFun~=nil and timePass>deltaTime then
local win=UIManager:findActiveWindow("UILayoutWin")
if win~=nil then
fightDebug.createCancelFun()
fightDebug.createCancelFun=nil
end
end
end

completeCheckTime=completeCheckTime+Time.deltaTime
local completeInfo=buildInfos[completeIndex]
if completeInfo~=nil and not completeInfo.complete then
if completeCheckTime>deltaTime then
local data=fightDebug.recv_3_31[completeIndex]
if data~=nil then
completeCheckTime=completeCheckTime-deltaTime
completeInfo.complete=true
completeIndex=completeIndex+1
isometricMapSystem:completeBuildingProgress(1,data)
end
end
else
fightDebug.createTimer:cancel()
fightDebug.createTimer=nil
end
end

fightDebug.createTimer=timer.new()
fightDebug.createTimer:start(0,createFun)
end

