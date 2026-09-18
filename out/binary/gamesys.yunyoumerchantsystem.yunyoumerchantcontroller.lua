






local _MODULENAME="yunyouMerchantController"

gameState.addListener(def_table(_MODULENAME))
yunyouMerchantController.name=_MODULENAME
yunyouMerchantController.data={}
yunyouMerchantController.entity=nil

function yunyouMerchantController:onAppStart()
yunyouMerchantModel:onAppStart()
socketManager:register_receiver(33,1,self.recv_33_1)
socketManager:register_receiver(33,2,self.recv_33_2)
socketManager:register_receiver(33,3,self.recv_33_3)
socketManager:register_receiver(33,4,self.recv_33_4)
notifySystem:listenNotify(notifyConfig.home_event,self.on_home_event)
notifySystem:listenNotify(notifyConfig.onNewDay5am,self.onNewDay5am)
notifySystem:listenNotify(notifyConfig.onNewWeek5am,self.onNewWeek5am)
end


function yunyouMerchantController:onEnterState(isReconnect)
yunyouMerchantModel:onEnterState()
end


function yunyouMerchantController:onProtocolReq()
yunyouMerchantModel:onProtocolReq()
end


function yunyouMerchantController:onLeaveState(isReconnect)
yunyouMerchantModel:onLeaveState(isReconnect)


self:deleteEntity()
end


function yunyouMerchantController:onLostConnection()

end


function yunyouMerchantController:onReConnection(isInitPro)

end



function yunyouMerchantController:send_33_2()
socketManager:send_33_2()
end

function yunyouMerchantController:send_33_4()
socketManager:send_33_4()
end

function yunyouMerchantController.recv_33_1(args)
local refreshTimes=args[1]
local buyFlag=args[2]
local damagePercent=args[3]
local monLevel=args[4]
local zmLevel=args[5]
local giftIdx=args[6]
buyFlag=buyFlag==1
monLevel=monLevel>0 and monLevel or cfgHelper.get4(cfg_business2config_get,1,"mon_conf",refreshTimes,2)
yunyouMerchantModel:initData(monLevel,refreshTimes,buyFlag,damagePercent,zmLevel,giftIdx)
UIManager:invokeUIMethod("UIYunYouMerchantWin","refreshView")
if not buyFlag and mainControl:isSceneType(eSceneType.eZongmen)and isometricMapSystem:IsInHome()then
yunyouMerchantController:newEntity()
UIManager:invokeUIMethod('UIBuildingMsgWin','showMsgSpe',2,not buyFlag)
end
end

function yunyouMerchantController.recv_33_2(errCode)

if errCode==1 then
yunyouMerchantModel:updateBuyFlag(true)
UIManager:invokeUIMethod("UIYunYouMerchantWin","afterBuy")
if mainControl:isSceneType(eSceneType.eZongmen)and isometricMapSystem:IsInHome()then
yunyouMerchantController:deleteEntity()
UIManager:invokeUIMethod('UIBuildingMsgWin','showMsgSpe',2,false)
end

elseif errCode==2 then
UIManager.error("已购买过")

elseif errCode==3 then
UIManager.error("消耗不足")
end
end

function yunyouMerchantController.recv_33_3(monLevel,zmLevel,giftIdx)
yunyouMerchantModel:nextData(monLevel,zmLevel,giftIdx)
if mainControl:isSceneType(eSceneType.eZongmen)and isometricMapSystem:IsInHome()then
yunyouMerchantController:newEntity()
end
local win=UIManager:findActiveWindow("UIYunYouMerchantWin")
if win then
UIManager.info(FMT.fmt("{0}已刷新",systemConfig.getSystemName(SYSTEM_DEFINE.eBusiness)))
UIFullYunYouMerchantControl:closeUI(true,true)
end
UIManager:invokeUIMethod('UIBuildingMsgWin','showMsgSpe',2,true)
end

function yunyouMerchantController.recv_33_4()

yunyouMerchantModel:updateBuyFlag(true)
if mainControl:isSceneType(eSceneType.eZongmen)and isometricMapSystem:IsInHome()then
yunyouMerchantController:deleteEntity()
UIManager:invokeUIMethod('UIBuildingMsgWin','showMsgSpe',2,false)
end
UIManager:invokeUIMethod('UIYunYouMerchantWin','afterLeave')





end


function yunyouMerchantController.on_home_event(etype)
if etype==homeEvent.eEnterHome then
local data=yunyouMerchantModel:getData()
if data and not data.buyFlag then
yunyouMerchantController:createEntity()
end
elseif etype==homeEvent.eLeaveHome then
yunyouMerchantController:deleteEntity()
end
end

function yunyouMerchantController.onNewDay5am()

local config=cfgHelper.get1(cfg_business2config_get,1)
local fixTimes=config.times

local weekTimes=config.week_times
local data=yunyouMerchantModel:getData()


if data and data.refreshTimes<fixTimes and data.refreshTimes<(weekTimes-1)and(data.damagePercent>=10000 or data.buyFlag)then
if yunyouMerchantModel:checkCloseLimit()then
yunyouMerchantController.recv_33_4()
return
end
yunyouMerchantModel:nextData()
yunyouMerchantController:newEntity()
local win=UIManager:findActiveWindow("UIYunYouMerchantWin")
if win then
UIManager.info(FMT.fmt("{0}已刷新",systemConfig.getSystemName(SYSTEM_DEFINE.eBusiness)))
UIFullYunYouMerchantControl:closeUI(true,true)
end
UIManager:invokeUIMethod('UIBuildingMsgWin','showMsgSpe',2,true)
end
end

function yunyouMerchantController.onNewWeek5am()

local config=cfgHelper.get1(cfg_business2config_get,1)
local fixTimes=config.times

local weekTimes=config.week_times
local data=yunyouMerchantModel:getData()


if data and data.refreshTimes<fixTimes and data.refreshTimes>=(weekTimes-1)and(data.damagePercent>=10000 or data.buyFlag)then
if yunyouMerchantModel:checkCloseLimit()then
yunyouMerchantController.recv_33_4()
return
end

yunyouMerchantModel:nextData()
yunyouMerchantController:newEntity()
local win=UIManager:findActiveWindow("UIYunYouMerchantWin")
if win then
UIManager.info(FMT.fmt("{0}已刷新",systemConfig.getSystemName(SYSTEM_DEFINE.eBusiness)))
UIFullYunYouMerchantControl:closeUI(true,true)
end
UIManager:invokeUIMethod('UIBuildingMsgWin','showMsgSpe',2,true)
end
end

function yunyouMerchantController:createEntity()
local modelCfg=cfgHelper.get2(cfg_business2config_get,1,"model")
local body=modelCfg[1]
local slots=modelCfg[2]
local scale=modelCfg[3]
local pos=self:randomPos()
local guid=isometricMapSystem:createRoleEntity(objectType.eYunYouMerchant,mapIdType.zhufeng,0,body,slots,SortingLayers.ITBuilding,scale,pos)
local bt=behaviorManager:addBehaviorTree('ai_zmvistor_range_move',{stId=guid},true,{})
local offset=_MapManager.GetObjectHeadOffset(guid)
local hud=hudControl:addHUD(INSTANCE_TYPE.eDiscipleState,guid,offset,true,true,function(id)
local widget=hudControl:getHUDWidget(id)
widget:SetChildCSImageSprite(0,globalABLookup.hud_atlas,'icon_fangshigx')
widget:SetChildButtonClick(1,function()
UIFullYunYouMerchantControl:showMainWindow()
end)
widget:SetChildActive(1,true)
end)
self.entity={guid=guid,hud=hud,bt=bt}
end

function yunyouMerchantController:newEntity()
local modelCfg=cfgHelper.get2(cfg_business2config_get,1,"model")
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

function yunyouMerchantController:changeEntityPosition()
local modelCfg=cfgHelper.get2(cfg_business2config_get,1,"model")
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

function yunyouMerchantController:getEntity()
return self.entity
end

function yunyouMerchantController:deleteEntity()
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

function yunyouMerchantController:stopEntityAI()
if self.entity==nil then return end
if self.entity.bt then
behaviorManager:removeBehaviorTree(self.entity.bt)
self.entity.bt=nil
self.entity.stop=true
end
end

function yunyouMerchantController:resumeEntityAI()
if self.entity==nil then return end
if not self.entity.bt then
local bt=behaviorManager:addBehaviorTree('ai_zmvistor_range_move',{stId=self.entity.guid},true,{})
self.entity.bt=bt
end
if self.entity.stop then
self.entity.stop=nil
end
end

function yunyouMerchantController:randomPos()
local temp=cfgHelper.get2(cfg_business2config_get,1,"titleMapRandPos")
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

function yunyouMerchantController:moveCameraToVisitorEntity()
if self.entity then
isometricMapSystem:moveCameraToObjectEx(self.entity.guid,true)
end
end
