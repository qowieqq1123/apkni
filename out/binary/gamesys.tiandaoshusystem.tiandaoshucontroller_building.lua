local _enter={}

function tiandaoshuController:clearBuildModel()
_enter={}
end

function tiandaoshuController:getEnterEntity(sfId)
return _enter[sfId]
end

function tiandaoshuController:onTouchBuild(entity)
local sfId=table.findValue(_enter,entity)
if sfId then

AudioManager.playBtnClick()
UIFullTianDaoShuController:showMainWindow()
return true
end
return false
end

function tiandaoshuController.on_home_event(etype)
if etype==homeEvent.eEnterHome then
local mountid=zongmenModel:getMountainId()
tiandaoshuController:createBuildingModel(mountid)
elseif etype==homeEvent.eLeaveHome then
tiandaoshuController:clearBuildModel()
end
end

function tiandaoshuController.onMountainChange(oldid,id)
if not _enter[id]then
tiandaoshuController:createBuildingModel(id)
elseif tiandaoshuController:checkShowBuilding()and id==mapIdType.xianmeng and xianmengModel:hasSelfHeJu()then
newbieControl.startNewbie(NEW_BIE_CND_TYPE.eLuaFun,NEWBIE_LUA_FUNC_NAME.TianDaoShuOpenLuaFunc)
end
end

function tiandaoshuController.on_system_open(sysId)
if sysId==SYSTEM_DEFINE.eTianDaoShu then
if isometricMapSystem:IsInHome()then
local sfId=zongmenModel:getMountainId()
if sfId then
tiandaoshuController.onMountainChange(sfId,sfId)
end
end
end
end

function tiandaoshuController.onXianMengChange(flag)
if isometricMapSystem:IsInHome()then
if not flag then
if not tiandaoshuController:checkShowBuilding()then
for i,v in pairs(_enter)do
_MapManager.RemoveTilemapObject(v)
end
_enter={}
else
tiandaoshuController:removeBuildingModel(mapIdType.xianmeng)
end
else
local sfId=zongmenModel:getMountainId()
tiandaoshuController.onMountainChange(sfId,sfId)
end
end
end

function tiandaoshuController:checkShowBuilding(isTips)
if not systemModel.isOpen(SYSTEM_DEFINE.eTianDaoShu)then
if isTips then
local tips=systemModel.getOpenTips(SYSTEM_DEFINE.eTianDaoShu)
UIManager.info(tips)
end
return false
end
local flag=xianmengModel:hasXM()or tiandaoshuModel:existData()
if not flag then
if isTips then
UIManager.info("天道树未开启，需要先加入一个仙盟")
end
return false
end
return true

end

function tiandaoshuController:createBuildingModel(sfId)
if not self:checkShowBuilding()then return end
local baseCfg=tiandaoshuConfig:getBaseConfig()
local build_id=baseCfg.buildType
local buildCfg=cfgHelper.get1(cfg_monijybuildconfig_get,build_id)
local pos=baseCfg.pos[sfId]
if pos then
local pos=Vector3Int(pos[1],pos[2],0)

local cfg=cfgHelper.get1(cfg_monijybuildconfig_get,build_id)
local model=cfg.model[1]
local bx=buildCfg.buid_size[1]
local by=buildCfg.buid_size[2]
local offset=isometricMapSystem:countOffset(bx,by)
local scale=isometricMapSystem:getModelScale(model)
if sfId==mapIdType.xianmeng then
local scales2Pram=isometricMapSystem:getModelScales2Pram(model,6)
scale=scale*scales2Pram[1]
end
local entity=_MapManager.CreateTilemapObject(objectType.ePlaceObject,model,nil,SortingLayers.ITBuilding,scale,sfId,pos,offset)


_enter[sfId]=entity

if sfId==mapIdType.xianmeng and xianmengModel:hasSelfHeJu()then
newbieControl.startNewbie(NEW_BIE_CND_TYPE.eLuaFun,NEWBIE_LUA_FUNC_NAME.TianDaoShuOpenLuaFunc)
end
end
end

function tiandaoshuController:removeBuildingModel(sfId)
local entity=_enter[sfId]
if entity then
_MapManager.RemoveTilemapObject(entity)
_enter[sfId]=nil
end
end

function tiandaoshuController:isTianDaoShuBuilding(sfId,entity)
return entity==_enter[sfId]
end