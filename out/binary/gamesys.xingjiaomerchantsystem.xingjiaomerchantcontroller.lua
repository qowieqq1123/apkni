






local _MODULENAME="xingjiaoMerchantController"

gameState.addListener(def_table(_MODULENAME))
xingjiaoMerchantController.name=_MODULENAME
xingjiaoMerchantController.data={}

function xingjiaoMerchantController:onAppStart()

xingjiaoMerchantModel:onAppStart()
socketManager:register_receiver(33,5,self.recv_33_5)
socketManager:register_receiver(33,6,self.recv_33_6)
socketManager:register_receiver(33,7,self.recv_33_7)
notifySystem:listenNotify(notifyConfig.home_event,self.on_home_event)
notifySystem:listenNotify(notifyConfig.onNewDay5am,self.onNewDay5am)
end


function xingjiaoMerchantController:onEnterState(isReconnect)
xingjiaoMerchantModel:onEnterState()
end


function xingjiaoMerchantController:onProtocolReq()
xingjiaoMerchantModel:onProtocolReq()
end


function xingjiaoMerchantController:onLeaveState(isReconnect)
xingjiaoMerchantModel:onLeaveState(isReconnect)


self:deleteEntity()
end


function xingjiaoMerchantController:onLostConnection()

end


function xingjiaoMerchantController:onReConnection(isInitPro)

end



function xingjiaoMerchantController:send_33_6(itemList,buildingList,skyBuildingList)
socketManager:send_33_6(#itemList,itemList,#buildingList,buildingList,#skyBuildingList,skyBuildingList)
end

function xingjiaoMerchantController:send_33_7()
socketManager:send_33_7()
end

function xingjiaoMerchantController.recv_33_5(refreshTimes,randomIndex,code)
if code==0 then
xingjiaoMerchantModel:setData(refreshTimes,randomIndex)

if xingjiaoMerchantModel:isOpenSys()and
mainControl:isSceneType(eSceneType.eZongmen)and
isometricMapSystem:IsInHome()then
xingjiaoMerchantController:newEntity()
UIManager:invokeUIMethod('UIBuildingMsgWin','showMsgSpe',5,true)
end
else
xingjiaoMerchantModel:clearData()
xingjiaoMerchantController:deleteEntity()
UIManager:invokeUIMethod('UIBuildingMsgWin','showMsgSpe',5,false)
end
end

function xingjiaoMerchantController.recv_33_6(res,normalLen,normalList,skyLen,skyList)
if res==1 then
for i=1,normalLen do
local ubdId=normalList[i]
zongmenModel:deleteStorageBuilding(ubdId)
end

for i=1,skyLen do
local ubdId=skyList[i]
zongmenModel:deleteSkyStorageDatas(ubdId)
end

xingjiaoMerchantModel:clearData()
xingjiaoMerchantController:deleteEntity()
UIManager:invokeUIMethod('UIBuildingMsgWin','showMsgSpe',5,false)
UIManager:invokeUIMethod("UIXingJiaoMerchantWin","afterBuy")
else
UIManager.error("交易失败")
end
end

function xingjiaoMerchantController.recv_33_7()
xingjiaoMerchantModel:clearData()
xingjiaoMerchantController:deleteEntity()
UIManager:invokeUIMethod('UIBuildingMsgWin','showMsgSpe',5,false)
UIManager:invokeUIMethod("UIXingJiaoMerchantWin","afterLeave")
end


function xingjiaoMerchantController.on_home_event(etype)
if etype==homeEvent.eEnterHome then
if xingjiaoMerchantModel:hasData()and xingjiaoMerchantModel:isOpenSys()then
xingjiaoMerchantController:createEntity()
end
elseif etype==homeEvent.eLeaveHome then
xingjiaoMerchantController:deleteEntity()
end
end

function xingjiaoMerchantController.onNewDay5am()
if not xingjiaoMerchantModel:isOpenSys()then return end
local check=xingjiaoMerchantModel:hasData()
xingjiaoMerchantModel:clearData()
xingjiaoMerchantController:deleteEntity()
UIFullXingJiaoMerchantControl:closeUI(true,true)
UIManager:invokeUIMethod('UIBuildingMsgWin','showMsgSpe',5,false)
if check then
UIManager.info("行脚商人已离开")
end
end

function xingjiaoMerchantController:createEntity()
local modelCfg=cfgHelper.get2(cfg_business1config_get,1,"model")
local body=modelCfg[1]
local slots=modelCfg[2]
local scale=modelCfg[3]
local pos=self:randomPos()
local guid=isometricMapSystem:createRoleEntity(objectType.eXingJiaoMerchant,mapIdType.zhufeng,0,body,slots,SortingLayers.ITBuilding,scale,pos)
local bt=behaviorManager:addBehaviorTree('ai_zmvistor_range_move',{stId=guid},true,{})
local offset=_MapManager.GetObjectHeadOffset(guid)
local hud=hudControl:addHUD(INSTANCE_TYPE.eDiscipleState,guid,offset,true,true,function(id)
local widget=hudControl:getHUDWidget(id)
widget:SetChildCSImageSprite(0,globalABLookup.hud_atlas,'icon_fangshigx')
widget:SetChildButtonClick(1,function()
UIFullXingJiaoMerchantControl:showMainWindow()
end)
widget:SetChildActive(1,true)
end)
self.entity={guid=guid,hud=hud,bt=bt}
end

function xingjiaoMerchantController:newEntity()
if not xingjiaoMerchantModel:isOpenSys()then return end
local modelCfg=cfgHelper.get2(cfg_business1config_get,1,"model")
local body=modelCfg[1]
local slots=modelCfg[2]
local scale=modelCfg[3]
local pos=self:randomPos()
if self.entity then
if not self.entity.stop then
self:changeEntityPosition()
end
else
self:createEntity()
end
end

function xingjiaoMerchantController:changeEntityPosition()
local modelCfg=cfgHelper.get2(cfg_business1config_get,1,"model")
local body=modelCfg[1]
local slots=modelCfg[2]
local scale=modelCfg[3]
local pos=self:randomPos()
if self.entity.bt then
self.entity.bt:broke()
self.entity.bt:reset()
else
local bt=behaviorManager:addBehaviorTree('ai_zmvistor_range_move',{stId=guid},true,{})
self.entity.bt=bt
end
_MapManager.SetPosition(self.entity.guid,pos)
end

function xingjiaoMerchantController:getEntity()
return self.entity
end

function xingjiaoMerchantController:deleteEntity()
if self.entity==nil then return end
if self.entity.bt then
behaviorManager:removeBehaviorTree(self.entity.bt)
end
if self.entity.hud then
hudControl:removeHUD(self.entity.hud)
end
_MapManager.RemoveTilemapObject(self.entity.guid)
self.entity=nil
end

function xingjiaoMerchantController:stopEntityAI()
if self.entity==nil then return end
if self.entity.bt then
behaviorManager:removeBehaviorTree(self.entity.bt)
self.entity.bt=nil
self.entity.stop=true
end
end

function xingjiaoMerchantController:resumeEntityAI()
if self.entity==nil then return end
if not self.entity.bt then
local bt=behaviorManager:addBehaviorTree('ai_zmvistor_range_move',{stId=self.entity.guid},true,{})
self.entity.bt=bt
end
if self.entity.stop then
self.entity.stop=nil
end
end

function xingjiaoMerchantController:randomPos()
local temp=cfgHelper.get2(cfg_business1config_get,1,"titleMapRandPos")
local list={}
for i,v in ipairs(temp)do
local cell=_MapManager.ToVector3Int(v[1],v[2],0)
local area=_MapManager.GetAreaID(mapIdType.zhufeng,cell)
if _MapManager.IsAreaUnlock(mapIdType.zhufeng,area)then
table.insert(list,cell)
end
end
return list[math.random(1,#list)]
end

function xingjiaoMerchantController:moveCameraToVisitorEntity()
if self.entity then
isometricMapSystem:moveCameraToObjectEx(self.entity.guid,true)
end
end