











mysteryMonsterController=mysteryEntityControllerBase.new(eMysteryEntityType.eMonster,mysteryEntityControllerBase)

local _HexMapManager=CS.HexagonMapManagerInterface
local CreateRole=_HexMapManager.CreateRole
local SetPosition=_HexMapManager.SetPosition
local Vector3ToVector3Int=_HexMapManager.Vector3ToVector3Int
local Vector3IntToVector3=_HexMapManager.Vector3IntToVector3
local ResumeMove=_HexMapManager.ResumeMove
local PauseMove=_HexMapManager.PauseMove
local StopMove=_HexMapManager.StopMove


local existTimer={}
local monster_queue=setmetatable({},{__index=queue})


function mysteryMonsterController:onAppStart()

socketManager:register_receiver(4,31,mysteryMonsterController.recv_4_31)
end

function mysteryMonsterController:onEnterState()
notifySystem:listenNotify(notifyConfig.on_mystery_create_entity,self.createEntityCb)
notifySystem:listenNotify(notifyConfig.on_mystery_player_move_start,mysteryMonsterController.on_mystery_player_move_start)
monster_queue:clear()
mysteryMonsterModel:init_data()
end

function mysteryMonsterController:onLeaveState()
notifySystem:removelistener(notifyConfig.on_mystery_player_move_start,mysteryMonsterController.on_mystery_player_move_start)
notifySystem:removelistener(notifyConfig.on_mystery_create_entity,self.createEntityCb)
end



function mysteryMonsterController.create_monster(args)
local id=args.etId
local x=args.x
local y=args.y
local hideFlag=args.hideFlag
local disappearTime=args.disappearTime
local roomId=args.roomId or mysteryRoomModel:get_cur_roomID()

local monsterGroupId=id
local monsterGroupCfg=mysteryMonsterModel.get_monster_group_config(monsterGroupId)
if not monsterGroupCfg then
logErr(FMT.fmt("没有该怪物的配置{0}",id))
return
end
local monsterPos=Vector3(x,y,0)
local layer=mysteryRoomModel:get_GroundLayer(roomId)
local model=
{
id=monsterGroupCfg.model[1],
components=monsterGroupCfg.model[3]or{},
layer=SortingLayers.ITBuilding,
scale=monsterGroupCfg.model[2],
isFlip=monsterGroupCfg.model.isFlip,
icon=monsterGroupCfg.model.icon,
iconScale=monsterGroupCfg.model.iconScale,
}


local fightValue=0
for i,v in pairs(monsterGroupCfg.monList)do
local monsterId=v
if monsterId~=0 then
local monsterCfg=mysteryMonsterModel.get_monster_config(monsterId)
fightValue=fightValue+monsterCfg.level*200000
end
end

local monsterAICfg=mysteryMonsterModel.get_ai_config(monsterGroupCfg.AIid)
local spiralPath=mysteryPosHelper.get_passable_near_pos_list(monsterPos,monsterAICfg.patrol_range)
local shufflePath=mysteryPosHelper.get_shuffle_path(monsterPos,monsterAICfg.patrol_range,layer)

local data=
{
origin_pos=monsterPos,
sim_pos=monsterPos,
ai_type=monsterGroupCfg.AIid,
move_complete=true,
fight_value=fightValue,
patrol_index=0,
sim_patrol_index=0,
patrol_path=shufflePath,
showInFog=monsterGroupCfg.showInFog,
isLockPlayer=false,

range=monsterGroupCfg.mjRange or 0,
colorRange=monsterGroupCfg.colorRange,
huge=monsterGroupCfg.hugeMon,
dontShowAppear=monsterGroupCfg.dontShowAppear
}

for key,value in pairs(args)do
data[key]=value
end

local guid=mysteryMonsterModel:create_entity(eMysteryEntityType.eMonster,monsterGroupId,monsterPos,roomId,model,data,hideFlag)

UIManager:invokeUIMethod("UIMysteryHUDWin","addMonsterHUD",guid)

mysteryMonsterController.send_monster_born(x,y,data.guid)
if disappearTime and disappearTime>0 then
existTimer[guid]=disappearTime+1
end
local entity=mysteryMonsterModel:get_entity(guid)
mysteryMonsterController.set_entity_parent(entity)
mysteryMonsterModel:update_visible(guid)
mysteryMonsterModel:refresh_hud(guid)

if data.colorRange then
mysteryMonsterController:start_color_change()
mysteryMonsterModel:update_color_grid_pos_list(entity)
end

return guid
end

function mysteryMonsterController:create_entity(args)
return mysteryMonsterController.create_monster(args)
end

function mysteryMonsterController:init_map_entity(roomId,completeCB)
roomId=roomId or mysteryRoomModel:get_cur_roomID()
local list={}
local num=5
local lIndex=0
local entitys=mysteryRoomModel:get_room_entity_birth_pos_list(roomId,eMysteryEntityType.eMonster)
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

mysteryMonsterController.create_monster(v)
end
else
createTimer:cancel()
if completeCB then
completeCB()
end
end
end,-1)

end

function mysteryMonsterController.createEntityCb(guid,pos,entityType)
if entityType==eMysteryEntityType.eMonster then
local entity=mysteryMonsterModel:get_entity(guid)
if entity.model.isFlip==nil then

mysteryMonsterModel:set_entity_forward(guid,mysteryPlayerModel:get_player_pos())
end

mysteryMonsterModel:refresh_hud(guid)
end
end





function mysteryMonsterController:update_monster()
local moveList={}
local monster_list=mysteryMonsterModel:get_entity_list()
for i,monster in pairs(monster_list)do
local moveData=self:move_entity(monster)
if moveData then
table.insert(moveList,moveData)
end
end
return monster_list
end


function mysteryMonsterController.handle_meet()
local isMeet=false
local monsters=mysteryMonsterModel:get_entity_list()
for i,monster in pairs(monsters)do

if mysteryAIManager.meet_player(monster,monster.pos,mysteryMonsterController.meet_result,monster.data.range)then
mysteryFightModel:set_fighting(true)
isMeet=true
break
end

end
return isMeet
end


function mysteryMonsterController.meet_result(originEntity,targetEntity)
mysterySkillController:set_hide_steps(0)
local monster=originEntity
if not monster then
return
end

MysteryGuildOrder:setAutoStart(true)

mysteryMonsterController.send_monster_attack(monster.pos.x,monster.pos.y,monster.data.guid)


mysteryFightModel:add_fight_team(monster)
local teamList={}
for i,v in pairs(mysteryMonsterModel:get_entity_list())do
local lastPath=MysteryModel:get_last_path(v.guid)
local lastPos=lastPath and lastPath[#lastPath]or v.pos
if v.roomId==monster.roomId and lastPos.x==monster.pos.x and lastPos.y==monster.pos.y then
teamList[#teamList+1]={monster.pos.x,monster.pos.y,v.data.guid,id=v.id}
mysteryMonsterController.send_monster_attack(monster.pos.x,monster.pos.y,v.data.guid)

mysteryFightModel:add_fight_team(v)
end
end
local monster1=teamList[1]
local mapId=cfgHelper.get(cfg_secretscenefubenconfig_get,MysteryModel:get_cur_fbid(),"fightMap")
if not mapId then
if monster1 then
mapId=cfgHelper.get2(cfg_monstergroup_get,monster.id,"mapId")
end
end

local zhenfa=MysteryModel:get_select_zhenFa()
local sendTeam=MysteryModel:get_fb_sendTeam()

local sortFunc=function(a,b)
local ida=a.id
local idb=b.id
local numA=0
local numB=0
if ida then
local monLista=cfgHelper.get(cfg_monstergroup_get,ida,"monList")
numA=monLista and#monLista or 0
end
if idb then
local monListb=cfgHelper.get(cfg_monstergroup_get,idb,"monList")
numB=monListb and#monListb or 0
end
return numA>numB
end

if teamList and#teamList>1 then
table.sort(teamList,sortFunc)

for i,v in ipairs(teamList)do
v.id=nil
end
end


fightLaunchController:sendFight(eBattleLaunch.mystery,sendTeam,mapId or 0,zhenfa,{1,teamList})

notifySystem:postNotify(notifyConfig.on_mystery_fight_start)

MysteryController:slideUI()
loggerUtil.log(FMT.fmt("秘境挑战怪物数量{0}",#teamList))

mysteryAIManager:set_mystery_state(true)



UIFullMysteryMainControl:closeUI()
end


function mysteryMonsterController.showInfoWin(monsterList,index)

index=index or 1
local monster=monsterList[index]
if not monster then
return
end



local mCfg=mysteryMonsterModel.get_monster_group_config(monster.id)

local aiid=mCfg.AIid
local isSlect=true
if aiid then
local aiCfg=mysteryMonsterModel.get_ai_config(aiid)
if aiCfg.is_escape then
isSlect=false
end
end
if isSlect then
mysteryMonsterModel:set_monster_select(monster.guid)
end


local fbId=MysteryModel:get_cur_fbid()
local lv=mCfg.levelUp and MysteryModel:get_mysteryFB_ndLevel(fbId)or mCfg.level
local items,detail=worldFightModel:getMonsterShowAwards(monster.id,lv)
local actRewards=worldFightModel:getMonsterExtraDropActReward(monster.id)
local gwReward=monster.data.gwReward


if fbId==1 and monster.id==110020 and(not monster.guide)then
weakGuideController:beginGuide(210)
monster.guide=true
end

local winParam={
groupId=mCfg.id,
name=mCfg.name,
icon=mCfg.model,
level=lv,
skills=mCfg.showSkills,
desc=mCfg.desc,
items=items,
detail=detail,
actRewards=actRewards,
title="妖怪信息",
gotReward=gwReward==1,
highestType=mCfg.monType,


close=function()
UIFullMysteryMainControl:closeUI()
end,
challenge=function()
MysteryController.onMapClick(monster.pos,true)
UIFullMysteryMainControl:closeUI()
end,
}
if monsterList[index+1]then
winParam.nextCallback=function()
mysteryMonsterController.showInfoWin(monsterList,index+1)
end
end
if monsterList[index-1]then
winParam.previousCallback=function()
mysteryMonsterController.showInfoWin(monsterList,index-1)
end
end
UIFullMysteryMainControl:showWindow("UIWorldBossWin",winParam)

end


function mysteryMonsterController.on_mystery_player_move_start()
local monster_list=mysteryMonsterModel:get_entity_list()
for i,monster in pairs(monster_list)do

if existTimer[monster.guid]then
existTimer[monster.guid]=existTimer[monster.guid]-1
if existTimer[monster.guid]<=0 then
mysteryMonsterController:stop_move(monster,{monster.pos})
mysteryMonsterModel:remove_entity(monster.guid)
if monster.hud then
UIManager:invokeUIMethod("UIMysteryHUDWin","removeMonsterHUD",monster.hud)
end
existTimer[monster.guid]=nil
end
end
end
end






function mysteryMonsterController:move_complete_callback(monster,path)

if not mysterySkillModel:has_hold_steps(monster.guid)and MysteryModel:is_moved(monster.guid)then
mysteryMonsterModel:play_animation(monster.guid,eAnimationID.jump3,MysteryModel:getMoveAnimSpeed())
if monster.hud then
monster.hud:doRootFade(true,0.2)
end
end


mysteryAIManager.meet_other_camp(monster,mysteryMonsterController.meet_result)


mysteryMonsterModel:set_move_complete_path(monster.guid,path)
mysteryMonsterModel:set_move_complete(monster.guid,true)

end


function mysteryMonsterController:move_point_callback(monster,pos,pathIndex,path)
if not mysteryAIManager:is_running()then
mysteryMonsterController:stop_move(monster,path)
end
end


function mysteryMonsterController:move_begin_callback(monster,pos)

mysteryMonsterModel:set_entity_forward(monster.guid,pos)

local is_in_view_pre=mysteryMonsterModel:get_monster_view(monster.guid,monster.roomId,monster.pos)


mysteryMonsterModel:set_entity_pos(monster.guid,pos)

mysteryMonsterModel:update_color_grid_pos_list(monster)


mysteryMonsterModel:update_visible(monster.guid)

if is_in_view_pre and not mysteryMonsterModel:get_monster_view(monster.guid,monster.roomId,pos)then
mysteryMonsterController.send_monster_lose_target(pos.x,pos.y,monster.data.guid)
end


if not mysterySkillModel:has_hold_steps(monster.guid)then

mysteryMonsterModel:play_animation(monster.guid,eAnimationID.jump2,MysteryModel:getMoveAnimSpeed())
end

end


function mysteryMonsterController:move_prepare_callback(monster)
if not mysterySkillModel:has_hold_steps(monster.guid)and monster.hud then
monster.hud:doRootFade(false,0.2)
end

if not mysterySkillModel:has_hold_steps(monster.guid)then
mysteryMonsterModel:play_animation(monster.guid,eAnimationID.jump1,MysteryModel:getMoveAnimSpeed())
end
end


function mysteryMonsterController:pause_move(guid)
PauseMove(guid)
end


function mysteryMonsterController:resume_move(guid)
ResumeMove(guid)
end

function mysteryMonsterController.set_entity_parent(entity,index)

if entity.data.range and not entity.data.huge then
local roundList={}
local pos=nil
local simPath=nil
local monsters=mysteryMonsterModel:get_entity_list()
for _,monster in pairs(monsters)do
if entity.guid~=monster.guid then
for i=0,monster.data.range do
pos=nil
if index then

simPath=MysteryModel:get_last_path(monster.guid)
if simPath then
pos=simPath[index+1]
end
else

pos=monster.pos
end
if pos then
roundList=mysteryPosHelper.get_round_pos_list(pos,i)
for _,v in ipairs(roundList)do
if entity.pos.x==v.x and entity.pos.y==v.y then
mysteryMonsterModel:set_merge_entity_parent(entity,monster)
return
end
end
end
end
end
end
end
mysteryMonsterModel:set_merge_entity_parent(entity,nil)
end


function mysteryMonsterController.send_monster_born(x,y,sGUID)
socketManager:send_4_31(x,y,sGUID,1)
end

function mysteryMonsterController.send_monster_lose_target(x,y,sGUID)
socketManager:send_4_31(x,y,sGUID,2)
end

function mysteryMonsterController.send_monster_attack(x,y,sGUID)
socketManager:send_4_31(x,y,sGUID,3)
end

function mysteryMonsterController.recv_4_31(result)
if result==0 then

end
end

