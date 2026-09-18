











mysteryTriggerPointController=mysteryEntityControllerBase.new(eMysteryEntityType.eTriggerPoint,mysteryEntityControllerBase)

local _HexMapManager=CS.HexagonMapManagerInterface

local afterTriggerCallBack=nil



function mysteryTriggerPointController:onAppStart()

end

function mysteryTriggerPointController:onEnterState()
self.afterTriggerCallBack=nil
notifySystem:listenNotify(notifyConfig.mystery_trigger_finish,mysteryTriggerPointController.mysteryTriggerFinish)
mysteryTriggerPointModel:init_data()
end

function mysteryTriggerPointController:onLeaveState()
self.afterTriggerCallBack=nil
notifySystem:removelistener(notifyConfig.mystery_trigger_finish,mysteryTriggerPointController.mysteryTriggerFinish)

end



function mysteryTriggerPointController.create_triggerPoint(args)
local id=args.etId
local x=args.x
local y=args.y
local hideFlag=args.hideFlag
local status=args.status or 0
local roomId=args.roomId or mysteryRoomModel:get_cur_roomID()
local cfg=mysteryTriggerPointModel:get_config(id)
local pos=Vector3(x,y,0)

local modelCfg=nil

if type(cfg.shape[1])=='table'then
modelCfg=cfg.shape[status+1]
if not modelCfg then
modelCfg=cfg.shape[#cfg.shape]
end
else
modelCfg=cfg.shape
end

local model=
{
id=modelCfg[1],
components=modelCfg[3]or{},
layer=SortingLayers.ITDecoration4,
scale=modelCfg[2],

isFlip=modelCfg.isFlip,
icon=modelCfg.icon,
iconScale=modelCfg.iconScale,
animID=modelCfg.animID
}
local data={status=status,nearCollider=cfg.nearCollider}

for key,value in pairs(args)do
data[key]=value
end
local guid=mysteryTriggerPointModel:create_entity(eMysteryEntityType.eTriggerPoint,id,pos,roomId,model,data,hideFlag)
local entity=mysteryTriggerPointModel:get_entity(guid)


if guid and cfg.hide and status>=cfg.hide then
_HexMapManager.SetScale(guid,Vector3(0,0,0))
notifySystem:postNotify(notifyConfig.on_mystery_remove_entity,guid,entity.roomId,entity.pos,entity.entityType,entity.id,false)

end
return guid
end

function mysteryTriggerPointController:create_entity(args)
return mysteryTriggerPointController.create_triggerPoint(args)
end

function mysteryTriggerPointController:init_map_entity(roomId,completeCB)
roomId=roomId or mysteryRoomModel:get_cur_roomID()

local list={}
local num=5
local lIndex=0
local entitys=mysteryRoomModel:get_room_entity_birth_pos_list(roomId,eMysteryEntityType.eTriggerPoint)
if entitys then
for i,v in pairs(entitys)do
if num>=5 then
num=0
lIndex=lIndex+1
list[lIndex]={}
end
num=num+1
v.roomId=roomId
table.insert(list[lIndex],v)
end
end

lIndex=0
local createTimer=timer.new()
createTimer:start(0.01,function()
lIndex=lIndex+1
if list[lIndex]and next(list[lIndex])then
for i,v in ipairs(list[lIndex])do
mysteryTriggerPointController.create_triggerPoint(v)
end
else
createTimer:cancel()
if completeCB then
completeCB()
end
end
end,-1)
end






function mysteryTriggerPointController.update_queue()

if not mysteryTriggerPointController.handle_meet()then

mysteryAIManager:update_queue()
end
end


function mysteryTriggerPointController.handle_meet()
local playerPos=mysteryPlayerModel:get_player_pos()

local entity_list=mysteryTriggerPointModel:get_entity_list()
local isMeet=false
local target=mysteryPlayerModel:get_ori_path()or{}
for guid,v in pairs(entity_list)do

mysteryTriggerPointModel:update_visible(guid)


if mysteryTriggerPointModel:have_collider_ent(v)then
if mysteryPosHelper.is_near_pos(v.pos,playerPos)then
if v.data.nearCollider then
mysteryTriggerPointController.meet_result(v)
v.data.actived=true
isMeet=true
else
for i,pos in ipairs(target)do
if v.pos==pos then

if v.data.actived then
v.data.actived=nil
else
mysteryTriggerPointController.meet_result(v)
v.data.actived=true
isMeet=true
end
end
end
end
end
end


if mysteryAIManager.meet_player(v,v.pos,mysteryTriggerPointController.meet_result)then
isMeet=true
end

end
return isMeet
end


function mysteryTriggerPointController.handle_click(pos,roomID)
local playerPos=mysteryPlayerModel:get_player_pos()
local triggerPoint=mysteryTriggerPointModel:get_entity_by_pos(pos,roomID)
if triggerPoint then
if mysteryPosHelper.is_near_pos(pos,playerPos)then
if triggerPoint.data.actived then
triggerPoint.data.actived=nil
else
triggerPoint.data.actived=true
end
end



if(mysteryTriggerPointModel:have_collider_ent(triggerPoint)and mysteryPosHelper.is_near_pos(pos,playerPos))then
mysteryTriggerPointController.meet_result(triggerPoint)
return true
end

end
end

function mysteryTriggerPointController.removeEntityCb(guid,roomId,pos,eType,id,isDestory)
if eType==eMysteryEntityType.eTriggerPoint and isDestory then

end
end


function mysteryTriggerPointController.meet_result(originEntity,targetEntity)
if not originEntity then
return
end


mysterySkillController:set_hide_steps(0)


if mysteryFightModel:get_after_queue_size()>0 then
mysteryFightModel:dequeue_after_callback()
end

if originEntity.data.destoryed then

return
end



local pos=originEntity.pos
local config=mysteryTriggerPointModel:get_config(originEntity.id)

if(not originEntity.data.status)or originEntity.data.status==0 or(not(config.hide and originEntity.data.status>=config.hide))then

local sendStatus=originEntity.data.status
local checkCond=mysteryTriggerPointModel:checkCondition(originEntity.id,originEntity.data.status,originEntity)
while(sendStatus<=10)do
if mysteryTriggerPointModel:isConditionApplyAll(originEntity.id,sendStatus)and checkCond then
sendStatus=sendStatus+1
checkCond=mysteryTriggerPointModel:checkCondition(originEntity.id,sendStatus,originEntity)
else
break
end
end

local condition=config.setStateCondition
local useFakeitem=nil
local fakeitem=nil
if condition and checkCond then
local curCond=condition[sendStatus+1]
if curCond[1]==2 then

for i,sidata in ipairs(curCond[2])do
fakeitem=MysteryModel:get_fake_item(sidata[1])
if fakeitem then
useFakeitem={fakeitem.itemGuid,sidata[2]}
break
end
end
end
end


if checkCond then
if config.trigger then
if sendStatus<#config.trigger then
sendStatus=sendStatus+1
end
else
sendStatus=sendStatus+1
end
end


if not(config.setStateAgain==nil or config.setStateAgain==1)then
if sendStatus==originEntity.data.status then
return
end
end

if not(config.trigger~=nil or config.state~=nil)then
return
end



if config.fakeItem and checkCond then
MysteryController.send_4_66(pos.x,pos.y,originEntity.data.guid,sendStatus)
end

if useFakeitem then

MysteryController.send_4_65(useFakeitem[1],useFakeitem[2],originEntity.data.guid,sendStatus)
else
mysteryEntityController.send_4_53(originEntity,sendStatus)
end




originEntity.data.isClicked=true


if config.text and checkCond then
UIManager.info(config.text)
end

end

mysteryAIManager:update_queue()
end


function mysteryTriggerPointController.handle_care_entity(id)
local careConfig=mysteryTriggerPointModel:get_care_config(id)
if careConfig then
local careId=careConfig[1]
local careType=careConfig[2]
if careType==1 then
local entityList=mysteryTriggerPointModel:get_entity_list()
for guid,entity in pairs(entityList)do
local status=entity.data.status
if careId==entity.id and status>=1 then
entity.data.destory=true
mysteryEntityController.send_4_50({entity})
break
end
end
end
end
end



function mysteryTriggerPointController.mysteryTriggerFinish()
if mysteryTriggerPointController.afterTriggerCallBack~=nil then
mysteryTriggerPointController.afterTriggerCallBack()
mysteryTriggerPointController.afterTriggerCallBack=nil
else
local playerPos=mysteryPlayerModel:get_player_pos()
if playerPos then
if mysteryRoomModel:get_pos_entityType(mysteryRoomModel:get_cur_roomID(),playerPos,eMysteryEntityType.ePortal)then
return
end
mysteryEntityController.handle_meet()
end
end
end

function mysteryTriggerPointController:changeStatusBody(entity)
local modelCfg=nil
local status=entity.data.status
local cfg=mysteryTriggerPointModel:get_config(entity.id)
if type(cfg.shape[1])=='table'then
modelCfg=cfg.shape[status+1]
if not modelCfg then
modelCfg=cfg.shape[#cfg.shape]
end
mysteryTriggerPointModel:change_body(entity.guid,modelCfg[1],modelCfg[3]or{},modelCfg[2])
end
end

function mysteryTriggerPointController:clearGrassState(guid,entguid)
mysteryTriggerPointModel:setEntGrass(guid,entguid,nil)
if not mysteryTriggerPointModel:haveEntGrass(guid)then
mysteryTriggerPointModel:play_animation(guid,eAnimationID.stand)
end
end

