









local xjEntityData_XJFMBoss={}


function xjEntityData_XJFMBoss:onInit()
self.sceneidx=self.scene
local pos=self.pos
self.gridX=pos[1]
self.gridZ=pos[2]
local size=self.size
self.gridWidth=size[1]
self.gridHeight=size[2]
self.gridX_c,self.gridZ_c=xianjieController:worldGridCenterPos(self.gridX,self.gridZ,self.gridWidth,self.gridHeight)
self.gridState=xjMapGridStateType.eXJFMBoss
end



function xjEntityData_XJFMBoss:onDelete()
if self.buoyId then
xianjieController:removeBuoy(self.buoyId)
end
self:removeAllAniDz()
end

function xjEntityData_XJFMBoss:createEntity(needRefreshAOI)
if xianjieModel:checkSceneIndex(self.sceneidx)and self.ent_key==nil then
self.ent_key=xianjieController:addEntity(XJ_ENTITY_TYPE.eXJFMBoss,{},needRefreshAOI)

end
end

function xjEntityData_XJFMBoss:getBossModel()

local modelCfg=cfgHelper.get2(cfg_fairylandbossconfig_get,1,"modelCfg")
local monIdx=XianJieFuMoModel:getMonsterIdx()

return modelCfg[monIdx]
end

function xjEntityData_XJFMBoss:getBossAnimID()
return self.animID or eAnimationID.idle
end


function xjEntityData_XJFMBoss:chanegeBossAmiState(animID)
if self.animID~=animID then
self.animID=animID
xianjieController:invokeEntityFunc(self.ent_key,"chanegeBossAmiState",animID)
end
end



function xjEntityData_XJFMBoss:getFuBiaoIcon()
local fubiao=cfgHelper.get2(cfg_fairylandbossconfig_get,1,"fubiao")
local monIdx=XianJieFuMoModel:getMonsterIdx()
return fubiao[monIdx]
end

function xjEntityData_XJFMBoss:InvokeEnityFunc(funcName,...)
if self.ent_key then
xianjieController:invokeEntityFunc(self.ent_key,funcName,...)
end
end

function xjEntityData_XJFMBoss:createTeamAniDz(teamIndex)
if not self.aniDzKeyList then
self.aniDzKeyList={}
end
self:removeTeamAllAniDz(teamIndex)
self.aniDzKeyList[teamIndex]={}
local dzTeamPosCfg=cfgHelper.get2(cfg_fairylandbossconfig_get,1,"dzTeamPosCfg")
local npcList=cfgHelper.get2(cfg_fairylandbossconfig_get,1,"npcModelCfg")


































local randomIndex=self.randomIndex or math.random(1,#dzTeamPosCfg)
randomIndex=randomIndex+1
if randomIndex>#dzTeamPosCfg then
randomIndex=1
end
self.randomIndex=randomIndex
local randomPosCfg=dzTeamPosCfg[randomIndex]
for i=1,5 do
local npcModelCfg=npcList[math.random(1,#npcList)]
local pos=randomPosCfg.pos[i]
local targetPos=randomPosCfg.targetpos[i]
local size={1,1}
local moveSpeed=10
local showHud=i==1
local hudName=showHud and XianJieFuMoModel:getAIName()or""
local needRefreshAOI=true
local argEx={}
argEx.teamIndex=teamIndex
local e_key=self:createAniDz(npcModelCfg,pos,targetPos,size,moveSpeed,showHud,hudName,argEx,needRefreshAOI)
self.aniDzKeyList[teamIndex][e_key]=e_key
end
end


function xjEntityData_XJFMBoss:createAniDz(modelCfg,startpos,targetPos,size,moveSpeed,showHud,hudName,argEx,needRefreshAOI)
if xianjieModel:checkSceneIndex(self.sceneidx)then
local gridX=startpos[1]
local gridZ=startpos[2]
local gridWidth=size[1]
local gridHeight=size[2]
local gridX_c,gridZ_c=xianjieController:worldGridCenterPos(gridX,gridZ,gridWidth,gridHeight)
local pos3=xianjieController:worldGridPos2WorldPos41(gridX_c,gridZ_c,self.sceneidx)
local size2=xianjieController:gridSize2WorldSize2(gridWidth,gridHeight)
local _gridX=targetPos[1]
local _gridZ=targetPos[2]
local _gridX_c,_gridZ_c=xianjieController:worldGridCenterPos(_gridX,_gridZ,gridWidth,gridHeight)
local targetPos3=xianjieController:worldGridPos2WorldPos41(_gridX_c,_gridZ_c,self.sceneidx)
local data={startpos=pos3,size=size2,showhud=showHud,modelCfg=modelCfg,targetPos=targetPos3,moveSpeed=moveSpeed,hudName=hudName,argEx=argEx}
if needRefreshAOI==nil then
needRefreshAOI=true
end
local key=xianjieController:addEntity(XJ_ENTITY_TYPE.eXJFMAniDz,data,needRefreshAOI)
return key
end
end


function xjEntityData_XJFMBoss:removeTeamAniDz(teamIndex,key)
xianjieController:removeEntity(key)
if self.aniDzKeyList and self.aniDzKeyList[teamIndex]then
self.aniDzKeyList[teamIndex][key]=nil
end
end

function xjEntityData_XJFMBoss:removeTeamAllAniDz(teamIndex)
if self.aniDzKeyList and self.aniDzKeyList[teamIndex]then
for k,v in pairs(self.aniDzKeyList[teamIndex])do
xianjieController:removeEntity(v)
end
self.aniDzKeyList[teamIndex]=nil
end
end

function xjEntityData_XJFMBoss:removeAllAniDz()
if self.aniDzKeyList then
for k,v in pairs(self.aniDzKeyList)do
self:removeTeamAllAniDz(k)
end
self.aniDzKeyList=nil
end
end

function xjEntityData_XJFMBoss:checkBossAniState()
local attack1Flag=true
if not self.aniDzKeyList[1]or(self.aniDzKeyList[1]and not next(self.aniDzKeyList[1]))then
attack1Flag=false
end
local attack2Flag=true
if not self.aniDzKeyList[2]or(self.aniDzKeyList[2]and not next(self.aniDzKeyList[2]))then
attack2Flag=false
end
if not attack1Flag and not attack2Flag then
self:chanegeBossAmiState(eAnimationID.idle)
self.animID=eAnimationID.idle
end
end

function xjEntityData_XJFMBoss:checkCreateAniTeam()
if not self.aniDzKeyList then
self:createTeamAniDz(1)
self:createTeamAniDz(2)
end
if not self.aniDzKeyList[1]or(self.aniDzKeyList[1]and not next(self.aniDzKeyList[1]))then
self:createTeamAniDz(1)
end
if not self.aniDzKeyList[2]or(self.aniDzKeyList[2]and not next(self.aniDzKeyList[2]))then
self:createTeamAniDz(2)
end
end

return xjEntityData_XJFMBoss