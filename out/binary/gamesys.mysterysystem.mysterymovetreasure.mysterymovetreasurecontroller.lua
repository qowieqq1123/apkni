







mysteryMoveTreasureController=mysteryEntityControllerBase.new(eMysteryEntityType.eMoveTreasure,mysteryEntityControllerBase)

local _HexMapManager=CS.HexagonMapManagerInterface
local SetPosition=_HexMapManager.SetPosition
local Vector3ToVector3Int=_HexMapManager.Vector3ToVector3Int
local Vector3IntToVector3=_HexMapManager.Vector3IntToVector3
local ResumeMove=_HexMapManager.ResumeMove
local PauseMove=_HexMapManager.PauseMove
local StopMove=_HexMapManager.StopMove


local existTimer={}
local monster_queue=setmetatable({},{__index=queue})


function mysteryMoveTreasureController:onAppStart()

end

function mysteryMoveTreasureController:onEnterState()
notifySystem:listenNotify(notifyConfig.on_mystery_create_entity,self.createEntityCb)
notifySystem:listenNotify(notifyConfig.on_mystery_player_move_start,self.on_mystery_player_move_start)

monster_queue:clear()
mysteryMoveTreasureModel:init_data()
end

function mysteryMoveTreasureController:onLeaveState()
notifySystem:removelistener(notifyConfig.on_mystery_player_move_start,self.on_mystery_player_move_start)
notifySystem:removelistener(notifyConfig.on_mystery_create_entity,self.createEntityCb)
end



function mysteryMoveTreasureController:create_entity(args)
local id=args.etId
local x=args.x
local y=args.y
local roomId=args.roomId
local hideFlag=args.hideFlag
local disappearTime=args.disappearTime
local gwReward=args.gwReward
local status=args.status or 0
local stepNum=args.stepNum
roomId=roomId or mysteryRoomModel:get_cur_roomID()
gwReward=gwReward or 0

local cfg=mysteryMoveTreasureModel:get_config(id)
if not cfg then
logErr(FMT.fmt("没有该奖励怪的配置{0}",id))
return
end
local monsterPos=Vector3(x,y,0)
local layer=mysteryRoomModel:get_GroundLayer(roomId)

local shape=cfg.shape
local modelCfg

if not stepNum or stepNum==0 then
logErr(FMT.fmt("初始化时没有奖励怪{0}的步数",id))
stepNum=cfg.stepNum
end

if status==1 then
modelCfg=shape[2]
else
modelCfg=shape[1]
end

local model=
{
id=modelCfg[1],
components=modelCfg[3]or{},
layer=SortingLayers.ITBuilding,
scale=modelCfg[2],
}



local monsterAICfg=mysteryMoveTreasureModel.get_ai_config(cfg.aiId)

local shufflePath=mysteryPosHelper.get_shuffle_path(monsterPos,monsterAICfg.patrol_range,layer)

local data=
{
origin_pos=monsterPos,
sim_pos=monsterPos,
ai_type=cfg.aiId,
move_complete=true,
fight_value=0,
patrol_index=0,
sim_patrol_index=0,
patrol_path=shufflePath,
showInFog=cfg.showInFog,
isLockPlayer=false,
gwReward=gwReward,
face=cfg.face,
}

for key,value in pairs(args)do
data[key]=value
end

local guid=mysteryMoveTreasureModel:create_entity(eMysteryEntityType.eMoveTreasure,id,monsterPos,roomId,model,data,hideFlag)

UIManager:invokeUIMethod("UIMysteryHUDWin","addUIHUD",eMysteryHUDType.eMoveTreasure,{etType=eMysteryEntityType.eMoveTreasure,guid=guid})

if disappearTime and disappearTime>0 then
existTimer[guid]=disappearTime+1
end

return guid
end

function mysteryMoveTreasureController:init_map_entity(roomId,completeCB)
roomId=roomId or mysteryRoomModel:get_cur_roomID()

local list={}
local num=5
local lIndex=0
local entitys=mysteryRoomModel:get_room_entity_birth_pos_list(roomId,eMysteryEntityType.eMoveTreasure)
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
mysteryMoveTreasureController:create_entity(v)
end
else
createTimer:cancel()
if completeCB then
completeCB()
end
end
end,-1)
end

function mysteryMoveTreasureController.createEntityCb(guid,pos,entityType)
if entityType==eMysteryEntityType.eMoveTreasure then

mysteryMonsterModel:set_entity_forward(guid,mysteryPlayerModel:get_player_pos())
end
end




function mysteryMoveTreasureController:update_monster()
local moveList={}
local monster_list=mysteryMoveTreasureModel:get_entity_list()
for i,monster in pairs(monster_list)do
local moveData=self:move_entity(monster)
if moveData then
table.insert(moveList,moveData)
end
end
return monster_list
end


function mysteryMoveTreasureController.handle_meet()
local isMeet=false
local range=1
local entity_list=mysteryMoveTreasureModel:get_entity_list()
for guid,v in pairs(entity_list)do

mysteryMoveTreasureModel:update_visible(guid)
range=v.data.status==1 and 0 or 1

if mysteryAIManager.meet_player(v,v.pos,mysteryMoveTreasureController.meet_result,range)then
isMeet=true
break
end
end
return isMeet
end


function mysteryMoveTreasureController.meet_result(originEntity)
mysterySkillController:set_hide_steps(0)
if not originEntity then
return
end
MysteryGuildOrder:setAutoStart(true)

if originEntity.data.isRemove then
return
end


originEntity.data.isDisappear=2

mysteryMoveTreasureController:onDisappear(originEntity)
end


function mysteryMoveTreasureController.on_mystery_player_move_start()
local monster_list=mysteryMoveTreasureModel:get_entity_list()
for i,monster in pairs(monster_list)do

if existTimer[monster.guid]then
existTimer[monster.guid]=existTimer[monster.guid]-1
if existTimer[monster.guid]<=0 then

mysteryMoveTreasureModel:remove_entity(monster.guid)
if monster.hud then
monster.hud:recycleHUD()
end
existTimer[monster.guid]=nil
end
end
end
end




function mysteryMoveTreasureController:move_complete_callback(entity,path)


if not mysterySkillModel:has_hold_steps(entity.guid)and MysteryModel:is_moved(entity.guid)then
mysteryMoveTreasureModel:play_animation(entity.guid,eAnimationID.jump3,MysteryModel:getMoveAnimSpeed())
end


mysteryMoveTreasureModel:set_move_complete_path(entity.guid,path)
mysteryMoveTreasureModel:set_move_complete(entity.guid,true)

end


function mysteryMoveTreasureController:move_point_callback(entity,pos,pathIndex,path)



local notRunning=not mysteryAIManager:is_running()
local isDisappear=entity.data.stepNum<=0
local isStop=notRunning or isDisappear

if isStop and not isDisappear then
mysteryMoveTreasureController:stop_move(entity,path)
end

if isDisappear then
mysteryMoveTreasureController:stop_move(entity,path)



local range=entity.data.status==1 and 0 or 1
local playerTargetPos=mysteryPlayerModel:get_player_pos()
if not mysteryAIManager.meet(entity,entity.pos,mysteryPlayerModel:get_player(),playerTargetPos,mysteryMoveTreasureController.meet_result,range)then
entity.data.dropFlag=0
else
entity.data.dropFlag=1
end

mysteryEntityController:upload_move_pos(entity,pos)
end
end



function mysteryMoveTreasureController:move_begin_callback(entity,pos)

mysteryMoveTreasureModel:set_entity_forward(entity.guid,pos)

mysteryMoveTreasureModel:set_entity_pos(entity.guid,pos)


if mysteryMoveTreasureModel:get_state(entity.guid)==eMysteryMonsterState.eAlert then
mysteryMoveTreasureModel:set_disappear_steps(entity.guid,0,true)

if entity.hud then
entity.hud:updateStep(entity.data.stepNum)
end
end


mysteryMoveTreasureModel:update_visible(entity.guid)


if not mysterySkillModel:has_hold_steps(entity.guid)then

mysteryMoveTreasureModel:play_animation(entity.guid,eAnimationID.jump2,MysteryModel:getMoveAnimSpeed())
end

end


function mysteryMoveTreasureController:move_prepare_callback(entity)

if not mysterySkillModel:has_hold_steps(entity.guid)then
mysteryMoveTreasureModel:play_animation(entity.guid,eAnimationID.jump1,MysteryModel:getMoveAnimSpeed())
end
end


function mysteryMoveTreasureController:onRecvMove(serverList)
for i,v in pairs(serverList)do
local entity=mysteryMoveTreasureModel:get_entity_by_server_guid(v.guid)
if entity then
if not entity.data.dropFlag then
local isDisappear=entity.data.stepNum<=0
if isDisappear then
local range=entity.data.status==1 and 0 or 1
local playerTargetPos=mysteryPlayerModel:get_player_pos()
if not mysteryAIManager.meet(entity,entity.pos,mysteryPlayerModel:get_player(),playerTargetPos,mysteryMoveTreasureController.meet_result,range)then
entity.data.dropFlag=0
else
entity.data.dropFlag=1
end
end
end
self:onDisappear(entity)
end
end
end


function mysteryMoveTreasureController:onDisappear(entity)
if entity then
if entity.data.dropFlag==0 then

local role=mysteryMoveTreasureModel:get_role_entity(entity.guid)
if role then
role:RunAnimator(eAnimationID.run)
if entity.hud then
entity.hud:refreshStepVisible(false)
if entity.data.face then
entity.hud:showBiaoQing(entity.data.face[1])
end
end
entity.data.isRemove=true

role:FadeToColor(Color.New(1,1,1,0),0.8,function()
mysteryEntityController.send_4_50({entity})

MysteryGuildOrder:setAutoStart(false)
end)
end
elseif entity.data.dropFlag==1 then

local role=mysteryMoveTreasureModel:get_role_entity(entity.guid)
if role then
if entity.hud and entity.data.face then
entity.hud:showBiaoQing(entity.data.face[2])
end
role:RunAnimator(eAnimationID.run)
role:FadeToColor(Color.New(1,1,1,0),0.8,function()
if entity.hud then
entity.hud:refreshStepVisible(false)
end
mysteryEntityController.send_4_50({entity})

MysteryGuildOrder:setAutoStart(false)
end)
end
end
end
end



function mysteryMoveTreasureController:mystery_created()
local roomId=mysteryRoomModel:get_cur_roomID()
local mapType=mysteryRoomModel:get_mapType_by_roomID(roomId)
local groundLayer=MysteryController.MapLayerLookUp[mapType].GroundLayer
if monster_queue:size()>0 then

local value=monster_queue:dequeue()
if value then



mysteryFogController:createEffect(5,Vector3(value.x,value.y,0),groundLayer,0.8,function()
mysteryMoveTreasureController:create_entity(value)
end)
if monster_queue:size()>0 then
self:mystery_created()
else

notifySystem:postNotify(notifyConfig.on_mystery_entity_create_complete,eMysteryEntityType.eMoveTreasure)
end
end
end
end






