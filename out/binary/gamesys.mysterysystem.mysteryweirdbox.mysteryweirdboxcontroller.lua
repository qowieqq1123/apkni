







mysteryWeirdBoxController=mysteryEntityControllerBase.new(eMysteryEntityType.eWeirdBox,mysteryEntityControllerBase)

local _HexMapManager=CS.HexagonMapManagerInterface
local SetPosition=_HexMapManager.SetPosition
local Vector3ToVector3Int=_HexMapManager.Vector3ToVector3Int
local ResumeMove=_HexMapManager.ResumeMove
local PauseMove=_HexMapManager.PauseMove
local StopMove=_HexMapManager.StopMove


local existTimer={}


function mysteryWeirdBoxController:onAppStart()

end

function mysteryWeirdBoxController:onEnterState()



mysteryWeirdBoxModel:init_data()
end

function mysteryWeirdBoxController:onLeaveState()


end



function mysteryWeirdBoxController:create_entity(args)
local id=args.etId
local x=args.x
local y=args.y
local roomId=args.roomId
local hideFlag=args.hideFlag
local gwReward=args.gwReward
roomId=roomId or mysteryRoomModel:get_cur_roomID()
gwReward=gwReward or 0

local cfg=mysteryWeirdBoxModel:get_config(id)
if not cfg then
logErr(FMT.fmt("没有该奖励怪的配置{0}",id))
return
end
local monsterPos=Vector3(x,y,0)
local layer=mysteryRoomModel:get_GroundLayer(roomId)

local shape=cfg.shape
local modelCfg=shape

local model=
{
id=modelCfg[1],
components=modelCfg[3]or{},
layer=SortingLayers.ITBuilding,
scale=modelCfg[2],
isFlip=modelCfg.isFlip,
icon=modelCfg.icon,
iconScale=modelCfg.iconScale,
}


local monsterAICfg=mysteryWeirdBoxModel.get_ai_config(cfg.aiId)

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
}

for key,value in pairs(args)do
data[key]=value
end

local guid=mysteryWeirdBoxModel:create_entity(eMysteryEntityType.eWeirdBox,id,monsterPos,roomId,model,data,hideFlag)

return guid
end

function mysteryWeirdBoxController:init_map_entity(roomId,completeCB)
roomId=roomId or mysteryRoomModel:get_cur_roomID()

local list={}
local num=5
local lIndex=0
local entitys=mysteryRoomModel:get_room_entity_birth_pos_list(roomId,eMysteryEntityType.eWeirdBox)
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
mysteryWeirdBoxController:create_entity(v)
end
else
createTimer:cancel()
if completeCB then
completeCB()
end
end
end,-1)

end











function mysteryWeirdBoxController:update_monster()
local moveList={}
local monster_list=mysteryWeirdBoxModel:get_entity_list()
for i,monster in pairs(monster_list)do
local moveData=self:move_entity(monster)
if moveData then
table.insert(moveList,moveData)
end
end
return monster_list
end


function mysteryWeirdBoxController.handle_meet()
local isMeet=false
local range=0
local entity_list=mysteryWeirdBoxModel:get_entity_list()
for guid,v in pairs(entity_list)do

mysteryWeirdBoxModel:update_visible(guid)
if mysteryAIManager.meet_player(v,v.pos,mysteryWeirdBoxController.meet_result,range)then
isMeet=true
end
end
return isMeet
end


function mysteryWeirdBoxController.meet_result(originEntity)
mysterySkillController:set_hide_steps(0)
if not originEntity then
return
end


if originEntity.data.isRemove then
return
end

if originEntity.data.status==0 then
MysteryGuildOrder:setAutoStart(true)
local role=mysteryWeirdBoxModel:get_role_entity(originEntity.guid)
if role then

role:FadeToColor(Color.New(1,1,1,0),0.8,function()

mysteryTreasureController.req_prize({originEntity})

mysteryAIManager:set_start_event_flag(true)


MysteryGuildOrder:setAutoStart(false)
end)
else

MysteryGuildOrder:setAutoStart(false)
end

originEntity.data.status=1
end
end




function mysteryWeirdBoxController:move_complete_callback(entity,path)



if not mysterySkillModel:has_hold_steps(entity.guid)and MysteryModel:is_moved(entity.guid)then

end


MysteryModel:clear_last_path(entity.guid)

mysteryWeirdBoxModel:set_move_complete_path(entity.guid,path)
mysteryWeirdBoxModel:set_move_complete(entity.guid,true)

end


function mysteryWeirdBoxController:move_point_callback(entity,pos,pathIndex,path)

if not mysteryAIManager:is_running()then
self:stop_move(entity.guid,path)
end

end


function mysteryWeirdBoxController:move_begin_callback(entity,pos)

mysteryWeirdBoxModel:set_entity_forward(entity.guid,pos)

mysteryWeirdBoxModel:set_entity_pos(entity.guid,pos)

mysteryWeirdBoxModel:update_visible(entity.guid)


end






