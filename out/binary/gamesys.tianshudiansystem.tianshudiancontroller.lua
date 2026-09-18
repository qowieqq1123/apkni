






local _MODULENAME="tianShuDianController"

gameState.addListener(def_table(_MODULENAME))
tianShuDianController.name=_MODULENAME
tianShuDianController.data={}

function tianShuDianController:onAppStart()

tianShuDianModel:onAppStart()









end


function tianShuDianController:onEnterState(isReconnect)
tianShuDianModel:onEnterState()




notifySystem:listenNotify(notifyConfig.building_event,self.building_event)
notifySystem:listenNotify(notifyConfig.onMountainChange,self.onMountainChange)
end


function tianShuDianController:onProtocolReq()
tianShuDianModel:onProtocolReq()


end


function tianShuDianController:onLeaveState(isReconnect)
tianShuDianModel:onLeaveState(isReconnect)

self.data={}



notifySystem:removelistener(notifyConfig.building_event,self.building_event)
end


function tianShuDianController:onLostConnection()

end


function tianShuDianController:onReConnection(isInitPro)

end






function tianShuDianController:getBuildData()
local buildDataList=zongmenModel:getAllBuildingDataByBdId(mapIdType.fort,SLG_SYSTEM_TYPE.eTianShuDian)or{}
return buildDataList[1]
end

function tianShuDianController:getBuildLevel()
local data=tianShuDianController:getBuildData()
return data and data.level or 0
end

function tianShuDianController:checkIsFullLevel()
local bdLevel=zongmenModel:getBuildingLevel(mapIdType.fort,SLG_SYSTEM_TYPE.eTianShuDian)
local tsdNextLevelCfg=cfgHelper.get1(cfg_tianshudianconfig_get,bdLevel+1)
return tsdNextLevelCfg==nil
end

function tianShuDianController:checkCanLevelUp(warning)
local bdData=tianShuDianController:getBuildData()

local nextLvCfg=cfgHelper.get2(cfg_monijybuilduplvlconfig_get,bdData.build_id,bdData.level+1)
if nextLvCfg then
local flag=zongmenControl:checkLevelUp(nextLvCfg,warning,mapIdType.fort)
if flag then
return true
end
end

return false
end

function tianShuDianController:getCurLevelCfg()
local lv=tianShuDianController:getBuildLevel()
local cfg=cfgHelper.get1(cfg_tianshudianconfig_get,lv)
return cfg or{}
end

function tianShuDianController:getXianLingMaxCount()
local cfg=tianShuDianController:getCurLevelCfg()
return cfg.auto_max_cnt and cfg.auto_max_cnt[eMoneyType.mtXianLing]
end


function tianShuDianController:getJiJieXiuShiMaxCount(targetEntityType)
local cfg=tianShuDianController:getCurLevelCfg()
local baseVal=cfg.jjxs_max_cnt

if targetEntityType~=nil then
local effectID=xianjieModel:getUpMassMaxSoldierNumEffectId(targetEntityType)
local activeEffectList=xianjieModel:getAvtiveEffectListByEffectID(effectID)
if next(activeEffectList)then
for index,effectData in ipairs(activeEffectList)do
baseVal=baseVal+effectData[2]
end
end
end

return baseVal
end

function tianShuDianController:getChuZhengXiuShiMaxCount()
local cfg=tianShuDianController:getCurLevelCfg()
return cfg.czxs_max_cnt
end

function tianShuDianController:getMoneygMaxLimit(moneyType)
local cfg=tianShuDianController:getCurLevelCfg()
return cfg.auto_max_cnt and cfg.auto_max_cnt[moneyType]
end


function tianShuDianController.onCheckBuildUpLevel()
if tianShuDianController:checkCanLevelUp()then
local bdDatas=zongmenModel:getBuildingDataByBdType(mapIdType.fort,SLG_SYSTEM_TYPE.eTianShuDian)
if bdDatas and bdDatas[1]then
hudControl:refreshBuildingStatusHUD(bdDatas[1].un_build_id)
end
end
end


function tianShuDianController.building_event(etype,sfId,ubdId,dzId,olddzId)
if sfId~=mapIdType.fort then return end


local bdData=tianShuDianController:getBuildData()
if bdData and bdData.un_build_id==ubdId then

if etype==buildingEvent.levelUpComplete then
moneyAutoIncreaseModel:initMax(bdData.build_id)
UIManager:invokeUIMethod("UITianShuDianWin","refreshAll")
isometricMapSystem:changeBuildingSpecialModelVisible(bdData,true)
elseif etype==buildingEvent.levelUpStart then
isometricMapSystem:changeBuildingSpecialModelVisible(bdData,false)
end
end
end

function tianShuDianController.onMountainChange(old_sfId,sfId)
if sfId==mapIdType.fort then
local bdData=tianShuDianController:getBuildData()
if bdData then
if bdData.flag==bdFlagType.levelUp or bdData.flag==bdFlagType.build then
isometricMapSystem:changeBuildingSpecialModelVisible(bdData,false)
end
end
end
end

