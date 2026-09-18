









local xjEntityData_monster={}


function xjEntityData_monster:onInit()
self.gridX=self.x
self.gridZ=self.y
self.x=nil
self.y=nil
local size=cfgHelper.get2(cfg_fairylandentitytypeconfig_get,self.entitytype,'size')
self.gridWidth=size[1]
self.gridHeight=size[2]
self.gridX_c,self.gridZ_c=xianjieController:worldGridCenterPos(self.gridX,self.gridZ,self.gridWidth,self.gridHeight)

self.gridState=xjMapGridStateType.eMonster




if self.entitytype==xjServerEnityType.eMonster then
self.defaultSpeed=cfgHelper.get4(cfg_fairylandbaseconfig_get,1,"march",xjServerMarchType.eKill,1)
elseif self.entitytype==xjServerEnityType.eBossMonster or self.entitytype==xjServerEnityType.eMoJieMoZong_Small or self.entitytype==xjServerEnityType.eMoJieMoster then
self.defaultSpeed=cfgHelper.get4(cfg_fairylandbaseconfig_get,1,"march",xjServerMarchType.eKillBossMonster,1)
elseif self.entitytype==xjServerEnityType.eMonsterHouse or self.entitytype==xjServerEnityType.eMoJieMoZong_Big then
self.defaultSpeed=cfgHelper.get4(cfg_fairylandbaseconfig_get,1,"march",xjServerMarchType.eJiJieChuZheng,1)
elseif self.entitytype==xjServerEnityType.eMoJieMoJunYaoMo then
self.defaultSpeed=cfgHelper.get4(cfg_fairylandbaseconfig_get,1,"march",xjServerMarchType.eMoJunYaoMo,1)
elseif self.entitytype==xjServerEnityType.eMoJieBox then
self.defaultSpeed=cfgHelper.get4(cfg_fairylandbaseconfig_get,1,"march",xjServerMarchType.eMoJieBoxCJ,1)
elseif self.entitytype==xjServerEnityType.eMoJieShangGuMoster then
self.defaultSpeed=cfgHelper.get4(cfg_fairylandbaseconfig_get,1,"march",xjServerMarchType.eMoJieSG,1)
elseif self.entitytype==xjServerEnityType.eMoJieZhenYan_Small or self.entitytype==xjServerEnityType.eMoJieZhenYan_Spe then
self.defaultSpeed=cfgHelper.get4(cfg_fairylandbaseconfig_get,1,"march",xjServerMarchType.eKillBossMonster,1)
elseif self.entitytype==xjServerEnityType.eMoJieZhenYan_Big then
self.defaultSpeed=cfgHelper.get4(cfg_fairylandbaseconfig_get,1,"march",xjServerMarchType.eJiJieChuZheng,1)
end
end

function xjEntityData_monster:refreshData(d)
if self.isExpire and self.gridState then

xianjieModel:setGridState(self.sceneidx,self.gridX,self.gridZ,self.gridWidth,self.gridHeight,self.gridState,false)
self.gridState=nil
end
if d.x then
self.gridX=d.x
end
if d.y then
self.gridZ=d.y
end
self.gridX_c,self.gridZ_c=xianjieController:worldGridCenterPos(self.gridX,self.gridZ,self.gridWidth,self.gridHeight)
self.sceneidx=d.sceneidx

if self.soldierList then
self.soldierList=d.soldierList
end
if self.shield then
self.isNeedUpdateModel=self.shield~=d.shield
self.shield=d.shield
end

self.bufflistlen=d.bufflistlen or 0
self.buffList=d.buffList


self.curr_hp=d.curr_hp or 0
self.max_hp=d.max_hp or 0
self.owner_server_id=d.owner_server_id or 0
self.owner_actor_name=d.owner_actor_name or 0


if self.forbid_atk_sec~=d.forbid_atk_sec then
self.isPlayEscape=true
end
self.forbid_atk_sec=d.forbid_atk_sec or 0

end

function xjEntityData_monster:getDistanc2ZongMen(sameScene)
local gridX_c,gridZ_c,sceneidx=xianjieModel:getZongMenWorldGridCenterPos()
if sameScene and sceneidx~=self.sceneidx then
return nil
end
local movePath=xianjieController:getMovePath(sceneidx,gridX_c,gridZ_c,self.sceneidx,self.gridX_c,self.gridZ_c)
return xianjieController:getMovePathDistance(movePath)
end

function xjEntityData_monster:getCfg()
local name=cfgHelper.get2(cfg_fairylandentitytypeconfig_get,self.entitytype,'configname')
local func=cfgHelper.getCofingGetFunction(name)
local cfg=cfgHelper.get1(func,self.infoid)





return cfg
end

function xjEntityData_monster:getConstDefCfg()
local name=cfgHelper.get2(cfg_fairylandentitytypeconfig_get,self.entitytype,'configname')
local func=cfgHelper.getCofingGetFunction(name)
local const_def=cfgHelper.get1(func,"const_def")





return const_def
end

function xjEntityData_monster:compareKey(guid)
return self.infoguid_str==tostring(guid)
end

function xjEntityData_monster:createEntity(needRefreshAOI,isSpine_EYid)
if xianjieModel:checkSceneIndex(self.sceneidx)and self.ent_key==nil and not self.isExpire and not self:checkHideEntity()then
self.ent_key=xianjieController:addEntity(XJ_ENTITY_TYPE.eMonster,{self.infoguid,isSpine_EYid},needRefreshAOI)
end
end









function xjEntityData_monster:onDelete()

end

function xjEntityData_monster:getName()
local cfg=self:getCfg()
if cfg.monster then
local monsterGroup=cfg.monster[1]
local monsterCfg=cfgHelper.get1(cfg_monstergroup_get,monsterGroup)
return monsterCfg.name
end
end

function xjEntityData_monster:getModelData()
local cfg=self:getCfg()
local modelSet=cfg.modelSet
local monsterCfg={}
if cfg.monster then
monsterCfg=cfgHelper.get1(cfg_monstergroup_get,cfg.monster[1])
end
if cfg.mutipleModelSet then
if self.entitytype==xjServerEnityType.eMoJieZhenYan_Spe or self.entitytype==xjServerEnityType.eMoJieZhenYan_Small or self.entitytype==xjServerEnityType.eMoJieZhenYan_Big then
if self.shield then
modelSet=self:getChangeModelSet_SpeZhenYan()
end
end
end
local body=modelSet.model or(monsterCfg.model and monsterCfg.model[1])
local componets=modelSet.components or(monsterCfg.model and monsterCfg.model[3])or{}
local scale=modelSet.scale or 1
local flip=modelSet.flip==1
local offset=modelSet.offset and mathHelper.convertArrayToVector(modelSet.offset)or Vector3.zero
local mount=modelSet.mount
local effect=modelSet.effect
local slotInfo=nil
if modelSet.replaceSlot and modelSet.replaceIcon then
slotInfo={modelSet.replaceSlot,modelSet.replaceIcon}
end

return body,componets,scale,flip,offset,slotInfo,mount,effect
end

function xjEntityData_monster:getSelectEffect()
local cfg=self:getCfg()
local modelSet=cfg.modelSet
if self.entitytype==xjServerEnityType.eMoJieZhenYan_Spe or self.entitytype==xjServerEnityType.eMoJieZhenYan_Small or self.entitytype==xjServerEnityType.eMoJieZhenYan_Big then
if self.shield then
modelSet=self:getChangeModelSet_SpeZhenYan()
end
end
return modelSet.selectEffect
end


function xjEntityData_monster:checkHideEntity()
if self.sceneidx and self.gridX and self.gridZ then
local ishide=not xianjieController:check_MoJieEntityHuJian_Unlock(self.sceneidx,self.gridX,self.gridZ)
if ishide then
return true
end

local isLimitPass=xianjieHelper.checkMonsterLimitCND(self)
if not isLimitPass then
return true
end
else
return false
end
end

function xjEntityData_monster:getWorldPos()

local vector=xianjieController:worldGridPos2WorldPos4(self.gridX_c,self.gridZ_c,self.sceneidx)

local offset=cfgHelper.get(cfg_fairylandbaseconfig_get,1,'clickLookAtOffset',self.entitytype)

if offset then
vector.x=vector.x+offset[1]
vector.y=vector.y+offset[2]
end

return vector
end

function xjEntityData_monster:getChangeModelSet_SpeZhenYan()
local cfg=self:getCfg()
local index=1

local intervals=cfg.mutipleModelSet[1]
local modelSetList=cfg.mutipleModelSet[2]

local const_def=self:getConstDefCfg()
local maxShield=const_def.shield[1]
local _shield=self.shield/maxShield*100

for _index,interval in ipairs(intervals)do
if _shield<=interval[1]and _shield>=interval[2]then
index=_index
end
end

return modelSetList[index]
end


return xjEntityData_monster
