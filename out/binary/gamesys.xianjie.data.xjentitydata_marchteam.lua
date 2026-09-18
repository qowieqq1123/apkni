









local xjEntityData_marchTeam={}


function xjEntityData_marchTeam:onInit()
self.speedlist=self.list
self.len=nil
self.list=nil
self.battleTime=cfgHelper.get4(cfg_fairylandbaseconfig_get,1,'march',self.marchtype,2)


self.isMyWaiPai=xianjieModel:checkInBaseWaiPai(xjWaiPiaBaseType.eMarckTeam,self.marchguid)
self.defaultSpeed=cfgHelper.get3(cfg_fairylandbaseconfig_get,1,"march",self.marchtype)

self.actuallyTarX=nil
self.actuallyTarY=nil
self.actuallySrcX=nil
self.actuallySrcY=nil

local marchtype=self.marchtype
if marchtype==xjServerMarchType.eKillBossMonster then

local entityData=xianjieModel:getEntityDataByGuid(self.infoguid,self.tarsceneidx)
if entityData and entityData.dataType==xjDataType.eMoJieGate then

local s_areaID=xianjieModel:checkMapGridDataAreaID(self.srcsceneidx,self.srcx,self.srcy)
if s_areaID<=0 then

local gateCfg=entityData:getCfg()
local pos=gateCfg.tagPos
self.actuallyTarX=pos and pos[1]or nil
self.actuallyTarY=pos and pos[2]or nil
end
end
elseif marchtype==xjServerMarchType.eBack then

if self.entitytype==xjServerEnityType.eClientBuild then
if xianjienSceneIndexType:isMoJie(self.srcsceneidx)then
local isGate,buildId,gateId=xianjieModel:checkClientBuildIsGateByPos(self.srcx,self.srcy)
if isGate then

local t_areaID=xianjieModel:checkMapGridDataAreaID(self.tarsceneidx,self.tarx,self.tary)
if t_areaID<=0 then

local gateCfg=cfgHelper.get1(cfg_devildomscenegateconfig_get,gateId)
local pos=gateCfg.tagPos
self.actuallySrcX=pos and pos[1]or nil
self.actuallySrcY=pos and pos[2]or nil
end
end
end
end
end
end

function xjEntityData_marchTeam:refreshData(d)
if d.len~=#self.speedlist then
self.speedlist=d.list
self:handleSpeedUp()
end
end

function xjEntityData_marchTeam:markMyWaiPai()
self.isMyWaiPai=true
end

function xjEntityData_marchTeam:compareKey(guid)
return self.marchguid_str==tostring(guid)
end


function xjEntityData_marchTeam:initBehaviorData()
if self.behaviorData==nil then
self.behaviorData={marchguid=self.marchguid}
end
end

function xjEntityData_marchTeam:createBehavior(sceneidx,isStart)
if self.infoguid~=nil then
local entitytype=xianjieModel:getEntityTypeByGuid(self.infoguid,self.tarsceneidx)
if entitytype==nil then



return
end
end
local teamHandle=self:getTeamHandle()
sceneidx=sceneidx or xianjieModel:getSceneIndex()
if not teamHandle:checkLineInScene(sceneidx)then
return
end
local typo
local state=teamHandle:getTeamState()
local marchtype=self.marchtype
if marchtype==xjServerMarchType.eKill or marchtype==xjServerMarchType.eAttackRole or
marchtype==xjServerMarchType.eSpy or marchtype==xjServerMarchType.eYuanZhu or
marchtype==xjServerMarchType.eJiJieJoin or marchtype==xjServerMarchType.eJiJieChuZheng or
marchtype==xjServerMarchType.eKillBossMonster or marchtype==xjServerMarchType.eCarry or
marchtype==xjServerMarchType.eStation or marchtype==xjServerMarchType.eMoZongAttack or
marchtype==xjServerMarchType.eMoJingZhenJi_Normal or marchtype==xjServerMarchType.eMoJingZhenJi_Origin or
marchtype==xjServerMarchType.eDefendXianMeng or marchtype==xjServerMarchType.eAttackXianMeng or
marchtype==xjServerMarchType.eMoJunYaoMo or marchtype==xjServerMarchType.eMoJunFenShenAttack or
marchtype==xjServerMarchType.eMJSLDebuffAdd or marchtype==xjServerMarchType.eMoJieBoxCJ or
marchtype==xjServerMarchType.eZhenYanAttack or
marchtype==xjServerMarchType.eMoJieSG or marchtype==xjServerMarchType.eLingShouAttack or marchtype==xjServerMarchType.eLingShouGroupAttak then
if state==xjMarchTeamStateType.eBattle then
typo='march_battle'
elseif state==xjMarchTeamStateType.eGoto or state==xjMarchTeamStateType.eBack then
typo='march_goto'
end
elseif marchtype==xjServerMarchType.eBack or marchtype==xjServerMarchType.eMoZongBack or marchtype==xjServerMarchType.eDefendXianMengBack or marchtype==xjServerMarchType.eMoGongZhanHunGe or
marchtype==xjServerMarchType.eMoGongHuLingTa or marchtype==xjServerMarchType.eZhenYanBack then
if state==xjMarchTeamStateType.eGoto then
typo='march_single_goto'
end
end
if typo then
self:initBehaviorData()
local marchguid=self.marchguid
if self.behaviorID==nil then
local finishCB=function(tree)
xianjieModel:clearMarchTeamBehavior(marchguid,tree)
local flag=xianjieModel:createMarchTeamBehavior(marchguid,true)
if not flag then

xianjieModel:clearMarchTeamBehaviorEx(marchguid)
end

if self.isMyWaiPai then
local march=xianjieModel:getMarchTeamData(marchguid)
notifySystem:postNotify(notifyConfig.onXianJieWaiPaiChange,CHANGE_TYPE.eChanged,march:getTeamHandle())
end
end
self.behaviorID=xjBehaviorManager:createTree(typo,self.behaviorData,finishCB,isStart)
return true
end
end
end


function xjEntityData_marchTeam:playBattleResult()

local marchtype=self.marchtype
if marchtype==xjServerMarchType.eBack then
local fightres=self.fightres
if fightres>0 then
local teamHandle=self:getTeamHandle()
if teamHandle:checkMyWaiPai()then
local sceneidx,gridX_c,gridZ_c=teamHandle:getResPos()
if xianjieModel:checkSceneIndex(sceneidx)then
local pos=xianjieController:worldGridPos2WorldPos4(gridX_c,gridZ_c,sceneidx)
local checkAOI=xianjieController:checkPosInAOI(pos)
if checkAOI then
local size=xianjieController:gridSize2WorldSize2(1,1)
local modelID
if fightres==1 then
modelID=6051
elseif fightres==0 then
else
modelID=6052
end
local offoctY=0
if teamHandle.teamData.entitytype==xjServerEnityType.eMoJingZhenJi_Normal then
offoctY=-5
end
if modelID~=nil then
xianjieController:createNormalEffect2(modelID,pos,size,2,3,Vector3(0,0.5,offoctY))
end

local marchguid=self.marchguid
local teamData=xianjieModel:getMarchTeamData(marchguid)

if teamData.shieldList and teamData.premarchtype==14 and fightres==1 then

local entity=xianjieController:findEntityByGridEX(sceneidx,gridX_c,gridZ_c,XJ_ENTITY_TYPE.eZongMen)


if entity~=nil then
entity:playProgressbar(nil,teamData.shieldList[1],teamData.shieldList[2],100,1,false)
end
end
end
end
end
end
end
end

function xjEntityData_marchTeam:handleSpeedUp()
local teamHandle=self:getTeamHandle()
teamHandle:onSpeedUp()
local onSpeedUpFunc=self:getBehaviorData('onSpeedUp')
if onSpeedUpFunc then
onSpeedUpFunc()
end
end


function xjEntityData_marchTeam:initTeamHandle()
if self.teamHandleID==nil then
local marchtype=self.marchtype
local teamType=xjServerMarch2TeamHandleType[marchtype]
if teamType then
self.teamHandleID=xianjieController:addXJTeamHandle(teamType,{marchguid=self.marchguid,marchguid_str=self.marchguid_str})
end
end
end


function xjEntityData_marchTeam:onDelete()

end

return xjEntityData_marchTeam
