







mysteryBoomMonsterController=mysteryEntityControllerBase.new(eMysteryEntityType.eBoomMonster,mysteryEntityControllerBase)

local _HexMapManager=CS.HexagonMapManagerInterface
local SetPosition=_HexMapManager.SetPosition
local Vector3ToVector3Int=_HexMapManager.Vector3ToVector3Int
local Vector3IntToVector3=_HexMapManager.Vector3IntToVector3
local ResumeMove=_HexMapManager.ResumeMove
local PauseMove=_HexMapManager.PauseMove
local StopMove=_HexMapManager.StopMove


local existTimer={}
local boom__queue={}
local boomSendList={}
local boomPlayer=false



function mysteryBoomMonsterController:onAppStart()
socketManager:register_receiver(4,61,mysteryBoomMonsterController.recv_4_61)
end

function mysteryBoomMonsterController:onEnterState()
notifySystem:listenNotify(notifyConfig.on_mystery_create_entity,self.createEntityCb)
notifySystem:listenNotify(notifyConfig.on_mystery_player_move_start,self.on_mystery_player_move_start)
notifySystem:listenNotify(notifyConfig.on_mystery_remove_entity,self.removeEntityCb)
boom__queue={}
mysteryMonsterModel:init_data()
end

function mysteryBoomMonsterController:onLeaveState()
boom__queue={}
notifySystem:removelistener(notifyConfig.on_mystery_player_move_start,self.on_mystery_player_move_start)
notifySystem:removelistener(notifyConfig.on_mystery_create_entity,self.createEntityCb)
notifySystem:removelistener(notifyConfig.on_mystery_remove_entity,self.removeEntityCb)
end



function mysteryBoomMonsterController:create_entity(args)
local id=args.etId
local x=args.x
local y=args.y
local roomId=args.roomId
local hideFlag=args.hideFlag
local disappearTime=args.disappearTime
local gwReward=args.gwReward
local status=args.status or 0




roomId=roomId or mysteryRoomModel:get_cur_roomID()
gwReward=gwReward or 0

local cfg=mysteryBoomMonsterModel:get_config(id)
if not cfg then
logErr(FMT.fmt("没有该奖励怪的配置{0}",id))
return
end
local monsterPos=Vector3(x,y,0)
local layer=mysteryRoomModel:get_GroundLayer(roomId)

local shape=cfg.shape
local modelCfg

modelCfg=shape[1]

local model={
id=modelCfg[1],
components=modelCfg[3]or{},
layer=SortingLayers.ITBuilding,
scale=modelCfg[2],
}



local monsterAICfg=mysteryBoomMonsterModel.get_ai_config(cfg.aiId)

local shufflePath=mysteryPosHelper.get_shuffle_path(monsterPos,monsterAICfg.patrol_range,layer)

local data={
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
status=status,

range=cfg.range or 0,


colorRange=cfg.colorRange,
}


for key,value in pairs(args)do
data[key]=value
end

local guid=mysteryBoomMonsterModel:create_entity(eMysteryEntityType.eBoomMonster,id,monsterPos,roomId,model,data,hideFlag)

if not cfg.stopBombBehave then
UIManager:invokeUIMethod("UIMysteryHUDWin","addUIHUD",eMysteryHUDType.eMoveTreasure,{etType=eMysteryEntityType.eBoomMonster,guid=guid,sortLayer='Entity'})
end

if disappearTime and disappearTime>0 then
existTimer[guid]=disappearTime+1
end

if cfg.colorRange then
local entity=mysteryBoomMonsterModel:get_entity(guid)
mysteryBoomMonsterController:start_color_change()

mysteryBoomMonsterModel:update_color_grid_pos_list(entity)
end

local bombBehavior=cfg.bombBehavior
if args.bornEntity then
local p=math.random(1,10000)>=0.6*10000
if p then
if bombBehavior then
if bombBehavior[1]then
mysteryBoomMonsterModel:runBehavior(guid,bombBehavior[1])
end
else
mysteryBoomMonsterModel:runBehavior(guid,"BoomMonTalk")
end
end
else
if bombBehavior then
if bombBehavior[1]then
mysteryBoomMonsterModel:runBehavior(guid,bombBehavior[1])
end
else
mysteryBoomMonsterModel:runBehavior(guid,"BoomMonTalk")
end
end

return guid
end

function mysteryBoomMonsterController:init_map_entity(roomId,completeCB)
roomId=roomId or mysteryRoomModel:get_cur_roomID()

local list={}
local num=5
local lIndex=0
local entitys=mysteryRoomModel:get_room_entity_birth_pos_list(roomId,eMysteryEntityType.eBoomMonster)
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
mysteryBoomMonsterController:create_entity(v)
end
else
createTimer:cancel()
if completeCB then
completeCB()
end
end
end,-1)

end

function mysteryBoomMonsterController.createEntityCb(guid,pos,entityType)
if entityType==eMysteryEntityType.eBoomMonster then

mysteryBoomMonsterModel:set_entity_forward(guid,mysteryPlayerModel:get_player_pos())
mysteryBoomMonsterModel:show_hud(guid)
end
end

function mysteryBoomMonsterController.removeEntityCb(guid,roomId,pos,eType,id,isDestory)
if eType==eMysteryEntityType.eBoomMonster and not isDestory then
mysteryBoomMonsterModel:hide_hud(guid)
end
end


function mysteryBoomMonsterController.boom_monster_meet_other(entity,notCheckStep)
if not entity then
return false
end
local player=mysteryPlayerModel:get_player()
local isMeetPlayer=false
if player then
isMeetPlayer=mysteryAIManager.meet(entity,entity.pos,player,player.pos)
if isMeetPlayer then
mysterySkillController:set_hide_steps(0)
end
end

local isBoom=false
if not notCheckStep then
if entity.data.stepNum<=0 or isMeetPlayer then
isBoom=true
else
return false
end
else
isBoom=true
end
local roomId=entity.roomId
local meetEntityList={}
if isMeetPlayer then
table.insert(meetEntityList,player)
end
local pos_list=mysteryPosHelper.get_all_round_pos_list(entity.pos,entity.data.range or 0)
for i,pos in ipairs(pos_list)do
local monsterList=mysteryRoomModel:get_pos_entityList(roomId,pos)
if next(monsterList)then
for i,monster in pairs(monsterList)do
if not monster.data.isBooming then
local iscanboom=mysteryEntityBase:isCanBoom(monster.entityType)
if iscanboom then
local isOtherMonster=monster.guid~=entity.guid
if isOtherMonster then
isBoom=true
table.insert(meetEntityList,monster)
end
end
end
end
end
end

if isBoom then
return isBoom,meetEntityList
end

return false
end


function mysteryBoomMonsterController:update_monster()
local moveList={}
local monster_list=mysteryBoomMonsterModel:get_entity_list()
for i,monster in pairs(monster_list)do
local moveData=self:move_entity(monster)
if moveData then
table.insert(moveList,moveData)
end
end
return monster_list
end


function mysteryBoomMonsterController.handle_meet()
local isMeet=false
local range=1
local entity_list=mysteryBoomMonsterModel:get_entity_list()
local meetList={}
for guid,v in pairs(entity_list)do
if not v.data.isBooming then

mysteryBoomMonsterModel:update_visible(guid)
range=v.data.status==1 and 0 or v.data.range

local isMeetOther,otherEntList=mysteryBoomMonsterController.boom_monster_meet_other(v)
if isMeetOther then
isMeet=true
v.data.isBooming=true


table.insert(meetList,{v,otherEntList})
end
end
end
if isMeet then
mysteryBoomMonsterController.meet_result(meetList)
end
return isMeet
end


function mysteryBoomMonsterController.meet_result(meetList)
mysterySkillController:set_hide_steps(0)
if not next(meetList)then
return
end

MysteryGuildOrder:setAutoStart(true)

boomPlayer=false
local listHaveBoom=false
boom__queue={}
boomSendList={}
for i,v in ipairs(meetList)do
local originEntity=v[1]
local otherEntList=v[2]or{}
originEntity.data.isBooming=true
local havePlayer,haveBoom,sendList=mysteryBoomMonsterController.getSendList(otherEntList)
if havePlayer then
boomPlayer=true
end
if haveBoom then
listHaveBoom=true
end
table.insert(boomSendList,{originEntity.pos.x,originEntity.pos.y,originEntity.data.guid,havePlayer and 1 or 0,#sendList,sendList})
end

if listHaveBoom then
mysteryBoomMonsterController:findMutliSendList()
end

mysteryBoomMonsterController.send_4_61(boomSendList,boomPlayer)

end

function mysteryBoomMonsterController.getSendList(otherEntList)
local sendList={}
local havePlayer=false
local haveBoom=false
if otherEntList then
for i,v in ipairs(otherEntList)do
if v.entityType==eMysteryEntityType.ePlayer then
havePlayer=true
elseif v.entityType==eMysteryEntityType.eBoomMonster then
v.data.isBooming=true
boom__queue[v.data.guid]=v
haveBoom=true
else
table.insert(sendList,{v.pos.x,v.pos.y,v.entityType,v.data.guid})
end
end
end
return havePlayer,haveBoom,sendList
end

function mysteryBoomMonsterController:findMutliSendList()
local nextBoomKey=next(boom__queue)
if nextBoomKey then
local boomEntity=boom__queue[nextBoomKey]
local isMeetOther,otherEntList=mysteryBoomMonsterController.boom_monster_meet_other(boomEntity,true)
local havePlayer,haveBoom,sendList=mysteryBoomMonsterController.getSendList(otherEntList)
table.insert(boomSendList,{boomEntity.pos.x,boomEntity.pos.y,boomEntity.data.guid,havePlayer and 1 or 0,#sendList,sendList})
boom__queue[nextBoomKey]=nil
if havePlayer then
boomPlayer=true
end
self:findMutliSendList()
end
end

function mysteryBoomMonsterController.on_mystery_player_move_start()
local monster_list=mysteryBoomMonsterModel:get_entity_list()
for i,monster in pairs(monster_list)do

if existTimer[monster.guid]then
existTimer[monster.guid]=existTimer[monster.guid]-1
if existTimer[monster.guid]<=0 then
mysteryBoomMonsterModel:remove_entity(monster.guid)
if monster.hud then
monster.hud:recycleHUD()
end
existTimer[monster.guid]=nil
end
end
end
end




function mysteryBoomMonsterController:move_complete_callback(entity,path)

if not mysterySkillModel:has_hold_steps(entity.guid)and MysteryModel:is_moved(entity.guid)then
mysteryBoomMonsterModel:play_animation(entity.guid,eAnimationID.jump3,MysteryModel:getMoveAnimSpeed())

end


mysteryBoomMonsterModel:set_move_complete_path(entity.guid,path)
mysteryBoomMonsterModel:set_move_complete(entity.guid,true)

end


function mysteryBoomMonsterController:move_point_callback(monster,pos,pathIndex,path)

mysteryBoomMonsterModel:update_color_grid_pos_list(monster)


mysteryBoomMonsterModel:update_visible(monster.guid)

local notRunning=not mysteryAIManager:is_running()

if notRunning then
mysteryBoomMonsterController:stop_move(monster,path)
end

end


function mysteryBoomMonsterController:move_begin_callback(monster,pos)
local guid=monster.guid

mysteryBoomMonsterModel:set_entity_forward(guid,pos)

if not mysterySkillModel:has_hold_steps(guid)then

mysteryBoomMonsterModel:play_animation(guid,eAnimationID.jump2)
end

mysteryBoomMonsterModel:set_entity_pos(guid,pos)
if monster.data.stepNum<=0 then
mysteryAIManager:stop_ai()
end


if mysteryBoomMonsterModel:get_state(guid)==eMysteryMonsterState.eAlert then
mysteryBoomMonsterModel:set_disappear_steps(guid,0,true)

end
if monster.hud then
monster.hud:updateStep(monster.data.stepNum)
end

local cfg=mysteryBoomMonsterModel:get_config(monster.id)
local bombBehavior=cfg.bombBehavior
local p=math.random(1,10000)>=0.6*10000
if p then
if bombBehavior then
if bombBehavior[2]then
mysteryBoomMonsterModel:runBehavior(guid,bombBehavior[2])
end
else
mysteryBoomMonsterModel:runBehavior(guid,"BoomMonTalk2")
end
end

end


function mysteryBoomMonsterController:move_prepare_callback(monster)

if not mysterySkillModel:has_hold_steps(monster.guid)then
mysteryBoomMonsterModel:play_animation(monster.guid,eAnimationID.jump1,MysteryModel:getMoveAnimSpeed())
end
end




local boomEntList=nil
function mysteryBoomMonsterController.send_4_61(boomList,bombPlayer)
local len=#boomList
if len==0 then
return
end
local fbid=MysteryModel:get_cur_fbid()

socketManager:send_4_61(fbid,len,boomList)
mysteryBoomMonsterController.bombPlayer=bombPlayer

local playBombEffect=true
if bombPlayer then
mysteryBoomMonsterController.waitToBoom=true
if len==1 then
local bomb=boomList[1]
local ent=mysteryBoomMonsterModel:get_entity(bomb[3])
if ent then
local cfg=mysteryBoomMonsterModel:get_config(ent.id)
if cfg.stopBombBehave then
playBombEffect=nil
end
end
end
end
mysteryBoomMonsterController.playBombEffect=playBombEffect

boomEntList=boomList
MysteryModel.currentFBData.isBoomingPause=true
end

function mysteryBoomMonsterController.recv_4_61()
MysteryGuildOrder:setAutoStart(false)
if mysteryBoomMonsterController.bombPlayer then
if not mysteryPlayerController.isPlayerRunBehavior()and mysteryBoomMonsterController.playBombEffect then

mysteryPlayerController.runBehavior("PlayerBoomAction",function()
mysteryAIManager:set_mystery_state(false)
mysteryEntityController.handle_meet()

end)
end
end

mysteryBoomMonsterController.bombPlayer=nil
mysteryBoomMonsterController.playBombEffect=nil
if boomEntList then

local boomTime=(#boomEntList+1)*0.25
for i,v in ipairs(boomEntList)do
local etGuid=v[3]
local delayTime=(i-1)*0.25
timeEventController.delayDo(delayTime,function()
mysteryBoomMonsterModel:remove_entity_by_server_guid(etGuid)
end)
end
boomEntList=nil
timeEventController.delayDo(boomTime,function()
MysteryModel.currentFBData.isBoomingPause=nil
end)
end
end

function mysteryBoomMonsterController:isBooming()
return MysteryModel.currentFBData.isBoomingPause
end

