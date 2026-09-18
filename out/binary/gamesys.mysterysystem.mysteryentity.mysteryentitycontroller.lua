







local _MODULENAME="mysteryEntityController"
gameState.addListener(def_table(_MODULENAME))
mysteryEntityController.name=_MODULENAME

local waitToRemoveList={}
local waitToSetStatusList={}


function mysteryEntityController:onAppStart()

socketManager:register_receiver(4,22,mysteryEntityController.recv_4_22)
socketManager:register_receiver(4,23,mysteryEntityController.recv_4_23)
socketManager:register_receiver(4,50,mysteryEntityController.recv_4_50)
socketManager:register_receiver(4,53,mysteryEntityController.recv_4_53)
socketManager:register_receiver(4,62,mysteryEntityController.recv_4_62)
socketManager:register_receiver(4,69,mysteryEntityController.recv_4_69)
end

function mysteryEntityController:onEnterState()
self:initTempData()
notifySystem:listenNotify(notifyConfig.on_mystery_create_entity,self.entityCreateFinish)
end

function mysteryEntityController:onLeaveState()
self:initTempData()
end

function mysteryEntityController:initTempData()
waitToRemoveList={}
waitToSetStatusList={}
if not self.create_queue then
self.create_queue=queue.New()
end
self.create_queue:clear()
end

function mysteryEntityController.send_4_50(entityList)







local sendList={}
for i,v in ipairs(entityList)do
v.data.destoryed=true
table.insert(sendList,{v.pos.x,v.pos.y,v.data.guid,v.entityType})
end
socketManager:send_4_50(#sendList,sendList)

end

function mysteryEntityController.recv_4_22(fbId,recvLen,recvList)
if recvLen>0 then
local roomId=mysteryRoomModel:get_cur_roomID()
local haveMonster
for i,v in ipairs(recvList)do
local entity=v
local model=mysteryEntityController.getModelByEntityType(entity.etType)
local data=model:dealServerData(entity)


mysteryEntityController.create_queue:enqueue(data)
if data.etType==eMysteryEntityType.eMonster then
haveMonster=true
elseif data.etType==eMysteryEntityType.ePortal then
mysteryPortalModel:add_portal_room_data(data,roomId,entity.x,entity.y)
end
end
mysteryEntityController:mystery_entity_new()
if haveMonster then
local bindType=eMysteryEntityType.ePlayer
local bindguid=mysteryPlayerModel:get_player_guid()

mysteryPlayerModel:setExpression(bindguid,10)
timeEventController.delayDo(2,function()
mysteryPlayerModel:setExpression(bindguid,0)
end)
UIManager:invokeUIMethod("UIMysteryHUDWin","addUIHUD","UIMysteryTalkHUD",{ganhanhao2=true,bindType=bindType,bindguid=bindguid,delay=2})
end
end
end


function mysteryEntityController.recv_4_50(fbId,recvLen,recvList)







local haveTP=false
if recvLen>0 then

for i,v in ipairs(recvList)do
if v.etType==eMysteryEntityType.eTriggerPoint then
haveTP=true
end
local entity=mysteryEntityController.invokeFuncByMysteryEntityType(v.etType,'get_entity_by_server_guid',v.guid)
if entity and v.etType==eMysteryEntityType.eObstacle then
local mapType=mysteryRoomModel:get_mapType_by_roomID(entity.roomId)
local groundLayer=MysteryController.MapLayerLookUp[mapType].GroundLayer
mysteryFogController:createEffect(5,entity.pos,groundLayer,0.5,nil)
end
mysteryEntityController:removeEntityServerGUID(v.etType,v.guid)
end
end

if haveTP==eMysteryEntityType.eTriggerPoint then
UIManager:invokeUIMethod("UIMysteryWin","showTriggerItemPanel")
end
end


function mysteryEntityController.send_4_53(entity,status,stepNum)
if not stepNum then
if entity.data.sendingStatus and entity.data.sendingStatus==status then
return
else
entity.data.sendingStatus=status
timeEventController.delayDo(2,function()
if entity and entity.data then
entity.data.sendingStatus=nil
end
end)
end
end
socketManager:send_4_53(entity.data.guid,entity.pos.x,entity.pos.y,status,stepNum or 0)
end


function mysteryEntityController.recv_4_53(args)
local sguid,etType,x,y,status,stepNum=args[1],args[2],args[3],args[4],args[5],args[6]
local entity=mysteryEntityController.invokeFuncByMysteryEntityType(etType,"get_entity_by_server_guid",sguid)
if entity then
entity.data.sendingStatus=nil
entity.data.status=status
entity.data.stepNum=stepNum
if etType==eMysteryEntityType.eTriggerPoint then

local config=mysteryTriggerPointModel:get_config(entity.id)
if config.destory or(config.hide and status>=config.hide)then


mysteryTriggerPointController.afterTriggerCallBack=function()

if config.destory then
mysteryEntityController.send_4_50({entity})
end









if config.hideEffect then
local effect=config.hideEffect[1]
local delay=config.hideEffect[2]or 1.5
local layer=mysteryRoomModel:get_GroundLayer(entity.roomId)

mysteryAIManager:set_mystery_state(true,false,delay)
local effectLife=cfgHelper.get(cfg_effectconfig_get,effect,"lifetime")
local lifetime=1.5
if effectLife then
lifetime=effectLife/1000
end
MysteryController.addUIHUD(eMysteryHUDType.eModel,{pos=entity.pos,layer=layer,sortLayer="UIWindow",sortOrder=100,effectArgs={effectId=effect},destoryTime=lifetime})
timeEventController.delayDo(delay,function()
mysteryAIManager:set_mystery_state(false)
mysteryTriggerPointController.handle_care_entity(entity.id)

local roleEntity=mysteryTriggerPointModel:get_role_entity(entity.guid)
roleEntity:FadeToColor(Color.New(1,1,1,0),1,nil,0)

entity.data.collider=nil
mysteryObstacleModel:erase_obstacle(entity.roomId,entity.pos)

notifySystem:postNotify(notifyConfig.on_mystery_remove_entity,entity.guid,entity.roomId,entity.pos,entity.entityType,entity.id,false)

end)
else
mysteryTriggerPointController.handle_care_entity(entity.id)

local roleEntity=mysteryTriggerPointModel:get_role_entity(entity.guid)
if roleEntity then
roleEntity:FadeToColor(Color.New(1,1,1,0),2.5,nil,0)
end
entity.data.collider=nil
mysteryObstacleModel:erase_obstacle(entity.roomId,entity.pos)

notifySystem:postNotify(notifyConfig.on_mystery_remove_entity,entity.guid,entity.roomId,entity.pos,entity.entityType,entity.id,false)
end
end
if not config.trigger then
mysteryTriggerPointController.afterTriggerCallBack()
mysteryTriggerPointController.afterTriggerCallBack=nil
end
else

mysteryTriggerPointController:changeStatusBody(entity)
end
UIManager:invokeUIMethod("UIMysteryWin","showTriggerItemPanel")
end
end

end


function mysteryEntityController.recv_4_62(recvLen,recvList)
if recvLen>0 then

local oldVal,newVal,isChange
local newList={}
for i,v in ipairs(recvList)do
local model=mysteryEntityController.getModelByEntityType(v.etType)
local data=model:dealServerData(v)


local entity=model:get_entity_by_server_guid(data.guid)
if entity then
for key,value in pairs(data)do
oldVal=entity.data[key]
newVal=value
isChange=tostring(oldVal)~=tostring(newVal)
entity.data[key]=value
if isChange then
mysteryEntityController:mystery_entity_data_change(data.etType,entity,key,oldVal,newVal)
end
end
else
table.insert(newList,data)
end
end
if next(newList)then
for i,v in ipairs(newList)do



mysteryEntityController.create_queue:enqueue(v)
end
mysteryEntityController:mystery_entity_new()
end
end
end


function mysteryEntityController.send_4_69()
local stepNum=MysteryModel:get_wing_step()
local direct=MysteryModel:get_wing_direct()
socketManager:send_4_69(stepNum,direct)
end

function mysteryEntityController.recv_4_69(stepNum,direction)
MysteryModel:set_wing_step(stepNum,direction)
end



local _register_model_list={}

local _register_controller_list={}

local _HexMapManager=CS.HexagonMapManagerInterface

local invokeFuncByMysteryEntityType=function(mysteryEntityType,func_name,...)
local model=_register_model_list[mysteryEntityType]
if model==nil then return end
if model[func_name]then
local args={...}
return model[func_name](model,unpack(args))
else
loggerUtil.logErrFMT('实体类型{0}没有找到{1}方法',mysteryEntityType,func_name)
end
end

local invokeMysteryEntityModelFunc=function(func_name,...)
local returnList={}
for _,entityType in pairs(eMysteryEntityType)do
local args={...}
returnList[entityType]=invokeFuncByMysteryEntityType(entityType,func_name,unpack(args))
end
return returnList
end

local invokeControllerFuncByMysteryEntityType=function(mysteryEntityType,func_name,...)
local controller=_register_controller_list[mysteryEntityType]
if controller==nil then return end
if controller[func_name]then
local args={...}
return controller[func_name](controller,unpack(args))
else

end
end


function mysteryEntityController.register(model)
local entityType=model.entityType

if _register_model_list[entityType]then return end
_register_model_list[entityType]=model
end

function mysteryEntityController.registerController(class)
local entityType=class.entityType

if _register_controller_list[entityType]then return end
_register_controller_list[entityType]=class
if _register_model_list[entityType]then
class.model=_register_model_list[entityType]
end
end


function mysteryEntityController.getModelByEntityType(eType)
if eType==eMysteryEntityType.ePlayer then
return mysteryPlayerModel
elseif eType==eMysteryEntityType.eSurface then
return
elseif eType==eMysteryEntityType.emysteryLingShou then
return
end
local model=_register_model_list[eType]
if model==nil then
loggerUtil.logErrFMT('实体类型{0}没有找到model',eType)
return
end
return model
end


function mysteryEntityController.invokeFuncByMysteryEntityType(mysteryEntityType,func_name,...)
local args={...}
return invokeFuncByMysteryEntityType(mysteryEntityType,func_name,unpack(args))
end


function mysteryEntityController.invokeAllModelsFunc(func_name,...)
local args={...}
return invokeMysteryEntityModelFunc(func_name,unpack(args))
end


function mysteryEntityController.invokeAllMoveModelsFunc(func_name,...)
local args={...}
local returnList={}
for _,entityType in pairs(eMysteryMoveEntityType)do
returnList[entityType]=invokeFuncByMysteryEntityType(entityType,func_name,unpack(args))
end
return returnList
end


function mysteryEntityController.invokeAllStaticModelsFunc(func_name,...)
local args={...}
local returnList={}
for _,entityType in pairs(eMysteryStaticEntityType)do
returnList[entityType]=invokeFuncByMysteryEntityType(entityType,func_name,unpack(args))
end
return returnList

end


function mysteryEntityController.invokeControllerFuncByMysteryEntityType(mysteryEntityType,func_name,...)
local args={...}
return invokeControllerFuncByMysteryEntityType(mysteryEntityType,func_name,unpack(args))
end


function mysteryEntityController.getControllerByEntityType(eType)
if eType==eMysteryEntityType.ePlayer then
return mysteryPlayerController
elseif eType==eMysteryEntityType.eSurface then
return
end
local controller=_register_controller_list[eType]
if controller==nil then
loggerUtil.logWarnFMT('实体类型{0}没有找到Controller',eType)
return
end
return controller
end




function mysteryEntityController:initEntity(roomID,completeCB)
local hideInSamePosList=MysteryModel:get_hide_in_same_pos_type()


local completeList={}
completeList[eMysteryEntityType.eTriggerPoint]=true
mysteryTriggerPointController:init_map_entity(roomID,function()
completeList[eMysteryEntityType.eTriggerPoint]=nil

for _,entityType in pairs(eMysteryEntityType)do
if entityType~=eMysteryEntityType.ePlayer and entityType~=eMysteryEntityType.eTriggerPoint then
local controller=mysteryEntityController.getControllerByEntityType(entityType)
if controller then
completeList[entityType]=true
controller:init_map_entity(roomID,function()
if hideInSamePosList[entityType]then
controller:set_all_entity_parent()
controller:show_entity_count_hud()
end
completeList[entityType]=nil

if next(completeList)==nil then
if completeCB then
completeCB()
end
end
end)
end
end
end
end)



end


function mysteryEntityController:createEntity(entityType,args)
return self.invokeControllerFuncByMysteryEntityType(entityType,"create_entity",args)
end


function mysteryEntityController:removeEntity(entityType,entityId,pos,roomId)
local entity=mysteryEntityController.invokeFuncByMysteryEntityType(entityType,'get_entity_by_pos_id',pos,roomId,entityId)
if entity then
mysteryEntityController.invokeFuncByMysteryEntityType(entityType,'remove_entity',entity.guid)
end
end

function mysteryEntityController:removeEntityServerGUID(entityType,guid)
local entity=mysteryEntityController.invokeFuncByMysteryEntityType(entityType,'get_entity_by_server_guid',guid)
if entity then
mysteryEntityController.invokeFuncByMysteryEntityType(entityType,'remove_entity',entity.guid)
end
end




function mysteryEntityController.update_grid_Entity_data(roomId,gridData)
local entityDict={}
if gridData.etListLen>0 then
for i,v in ipairs(gridData.etList)do
if not entityDict[v.etType]then
entityDict[v.etType]={}
end
entityDict[v.etType][v.etId]=v
end
end

local entityList=mysteryEntityController.invokeAllStaticModelsFunc('get_all_entity_list_by_pos',Vector3(gridData.x,gridData.y,0),roomId)
if entityList then
for entityType,el in pairs(entityList)do
for _,v in ipairs(el)do
if v then
if entityDict[entityType][v.id]then

entityDict[v.etType][v.etId].isExist=true
else
mysteryEntityController.invokeFuncByMysteryEntityType(entityType,'remove_entity',v.guid)
end
end
end
end
end
local mapType=mysteryRoomModel:get_mapType_by_roomID(roomId)
local groundLayer=MysteryController.MapLayerLookUp[mapType].GroundLayer
for k,group in pairs(entityDict)do
if k~=eMysteryEntityType.eeSurface then
for id,v in pairs(group)do
if not v.isExist then
mysteryFogController:createEffect(5,Vector3(gridData.x,gridData.y,0),groundLayer,0.5,function()
mysteryEntityController:createEntity(v.etType,v)

end)
end
end
end
end

end



function mysteryEntityController.handle_meet()

local pause,t=mysteryAIManager:is_pause({[eMysteryPauseType.eWaitToMoveRecv]=true,[eMysteryPauseType.eFireBomb]=true})

if pause then
return
end

for i,v in pairs(eMysteryAIEntityType)do
if mysteryEntityController.invokeControllerFuncByMysteryEntityType(v,"handle_meet")then
break
end
end

mysteryAIManager.queueIndex=1
mysteryAIManager:update_queue()
end


function mysteryEntityController.handle_one_meet()
local pause,t=mysteryAIManager:is_pause({[eMysteryPauseType.eWaitToMoveRecv]=true})
if pause then
return
end

mysteryAIManager:start_one_meet()
end


function mysteryEntityController.setEntityRootActive(flag)
_HexMapManager.SetEntityRootActive(flag)
end

function mysteryEntityController:mystery_entity_new()
local roomId=mysteryRoomModel:get_cur_roomID()
local mapType=mysteryRoomModel:get_mapType_by_roomID(roomId)
local groundLayer=MysteryController.MapLayerLookUp[mapType].GroundLayer
if self.create_queue:size()>0 then
local value=self.create_queue:dequeue()

if value then
if value.etType>0 then
value.roomId=roomId
local guid=mysteryEntityController:createEntity(value.etType,value)
if guid then
mysteryEntityController.invokeFuncByMysteryEntityType(value.etType,"set_entity_visible",guid,false)
end
mysteryFogController:createEffect(5,Vector3(value.x,value.y,0),groundLayer,0.5,function()
if guid then
mysteryEntityController.invokeFuncByMysteryEntityType(value.etType,"set_entity_visible",guid,true)
end
if self.create_queue:isEmpty()then
notifySystem:postNotify(notifyConfig.on_mystery_entity_create_complete,value.etType)
mysteryEntityController.on_mystery_entity_create_complete(value.etType)
end
end)
end
if self.create_queue:size()>0 then
self:mystery_entity_new()
end
end
end
end


function mysteryEntityController:mystery_entity_data_change(etType,entity,key,oldVal,newVal)
notifySystem:postNotify(notifyConfig.mystery_entity_data_change,etType,entity,key,oldVal,newVal)

if key=='blood'then
if entity.bloodBar then
entity.bloodBar:refreshBlood()
else
MysteryController.addUIHUD(eMysteryHUDType.eBloodShow,{etType=entity.entityType,guid=entity.guid,oldBlood=oldVal,blood=newVal,time=0.5})
end

end
end


function mysteryEntityController.on_mystery_entity_create_complete(eType)
if mysteryAIManager:get_start_event_flag()then
mysteryAIManager:set_start_event_flag(false)
mysteryAIManager:set_mystery_state(false)
mysteryEntityController.handle_meet()
end
end


function mysteryEntityController.entityCreateFinish(guid,pos,entityType,id,isCreate)

if entityType~=eMysteryEntityType.ePlayer then
local controller=mysteryEntityController.getControllerByEntityType(entityType)
if controller then
controller:inGrassBehavior(guid,pos)
end
end

end

function mysteryEntityController.entityMove(entityType,guid,pos)
if entityType~=eMysteryEntityType.ePlayer and entityType~=eMysteryEntityType.eTriggerPoint then
local controller=mysteryEntityController.getControllerByEntityType(entityType)
if controller then
controller:inGrassBehavior(guid,pos)
end
end
end



