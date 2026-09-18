






local _MODULENAME="xianMengDaZhenController"

gameState.addListener(def_table(_MODULENAME))
xianMengDaZhenController.name=_MODULENAME
xianMengDaZhenController.data={}


function xianMengDaZhenController:onAppStart()
xianMengDaZhenModel:onAppStart()
socketManager:register_receiver(20,81,self.recv_20_81)
notifySystem:listenNotify(notifyConfig.home_event,self.on_home_event)
notifySystem:listenNotify(notifyConfig.onMountainChange,self.onMountainChange)
notifySystem:listenNotify(notifyConfig.onXianMengChange,self.onXianMengChange)
notifySystem:listenNotify(notifyConfig.onNewDay,self.onNewDay)
end


function xianMengDaZhenController:onEnterState(isReconnect)
xianMengDaZhenModel:onEnterState()
end


function xianMengDaZhenController:onProtocolReq()
xianMengDaZhenModel:onProtocolReq()
end


function xianMengDaZhenController:onLeaveState(isReconnect)
xianMengDaZhenModel:onLeaveState(isReconnect)

if not isReconnect then
self.buildEntity=nil
end
end


function xianMengDaZhenController:onLostConnection()

end


function xianMengDaZhenController:onReConnection(isInitPro)

end



function xianMengDaZhenController:send_20_81()
socketManager:send_20_81()
end

function xianMengDaZhenController:send_20_82()
socketManager:send_20_82()
end

function xianMengDaZhenController.recv_20_81(level,sheild,since)
local oldLv=xianMengDaZhenModel:getLevel()
xianMengDaZhenModel:setData(level,sheild,since)

if oldLv~=level then
if isometricMapSystem:IsInHome()and zongmenModel:getMountainId()==mapIdType.xianmeng then
xianMengDaZhenController:createBuildingModel()
end

if oldLv>0 and level>0 then
notifySystem:postNotify(notifyConfig.onXianMengDaZhenLevelUp,oldLv,level)
end
end
end


function xianMengDaZhenController.on_home_event(etype)
if etype==homeEvent.eLeaveHome then
xianMengDaZhenController.buildEntity=nil
end
end

function xianMengDaZhenController.onMountainChange(oldid,id)
if id==mapIdType.xianmeng and xianMengDaZhenController.buildEntity==nil then
xianMengDaZhenController:createBuildingModel()
end
end

function xianMengDaZhenController.onXianMengChange(flag)
if isometricMapSystem:IsInHome()and zongmenModel:getMountainId()==mapIdType.xianmeng then
if flag then
xianMengDaZhenController:createBuildingModel()
else
xianMengDaZhenController:removeBuildingModel()
end
end
end

function xianMengDaZhenController.onNewDay()
if xianMengDaZhenController.buildEntity==nil and isometricMapSystem:IsInHome()and zongmenModel:getMountainId()==mapIdType.xianmeng then
xianMengDaZhenController:createBuildingModel()
end
end

function xianMengDaZhenController:createBuildingModel()
if not self:checkShowBuilding()then return end

local baseCfg=cfgHelper.get1(cfg_devildomdazhenbaseconfig_get,1)
local build_id=baseCfg.buildId
local build_lv=xianMengDaZhenModel:getLevel()
local buildCfg=cfgHelper.get1(cfg_monijybuildconfig_get,build_id)
local model=buildCfg.repair_model[1]
for i=build_lv,1,-1 do
if buildCfg.model[build_lv]then
model=buildCfg.model[build_lv]
end
end

local scale=isometricMapSystem:getModelScale(model)
if self.buildEntity then
_MapManager.ChangeBody(self.buildEntity,model,nil,scale)
else
local bx=buildCfg.buid_size[1]
local by=buildCfg.buid_size[2]
local offset=isometricMapSystem:countOffset(bx,by)
local pos=baseCfg.pos
pos=Vector3Int(pos[1],pos[2],0)
local entity=_MapManager.CreateTilemapObject(objectType.ePlaceObject,model,nil,SortingLayers.ITBuilding,scale,mapIdType.xianmeng,pos,offset)
self.buildEntity=entity
end
end

function xianMengDaZhenController:removeBuildingModel()
if self.buildEntity then
_MapManager.RemoveTilemapObject(self.buildEntity)
self.buildEntity=nil
end
end

function xianMengDaZhenController:checkShowBuilding()
local enterData=xianjieModel:getMoJieEnterData()
if enterData then
local show=cfgHelper.get2(cfg_devildomdazhenbaseconfig_get,1,"show")
if enterData.sId>show then
return true
elseif enterData.sId==show then
local nowTime=timeHelper.getServerShortTime()
return enterData.sTime<=nowTime and nowTime<enterData.eTime
end
end
return false
end

function xianMengDaZhenController:onTouchBuild(entity)
if self.buildEntity==entity then
if xianMengDaZhenModel:getLevel()>0 then
UIFullXianMengDaZhenController:showMainWindow()
else
UIManager.error("仙盟大阵尚未开启")
end
return true
end
return false
end
