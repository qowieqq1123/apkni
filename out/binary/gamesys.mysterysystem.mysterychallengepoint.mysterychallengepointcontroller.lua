











mysteryChallengePointController=mysteryEntityControllerBase.new(eMysteryEntityType.eChallengePoint,mysteryEntityControllerBase)

local _HexMapManager=CS.HexagonMapManagerInterface



function mysteryChallengePointController:onAppStart()
socketManager:register_receiver(4,39,mysteryChallengePointController.recv_4_39)
end

function mysteryChallengePointController:onEnterState()
mysteryChallengePointModel:init_data()
end

function mysteryChallengePointController:onLeaveState()

end



function mysteryChallengePointController.create_challengepoint(args)
local id=args.etId
local x=args.x
local y=args.y
local hideFlag=args.hideFlag
local roomId=args.roomId or mysteryRoomModel:get_cur_roomID()
local cfg=mysteryChallengePointModel:get_config(id)
if not cfg then
return
end
local pos=Vector3(x,y,0)

local modelCfg=cfg.shape

local model=
{
id=modelCfg[1],
components={},
layer=SortingLayers.ITBuilding,
scale=modelCfg[2],
}
local data={}

for key,value in pairs(args)do
data[key]=value
end
local guid=mysteryChallengePointModel:create_entity(eMysteryEntityType.eChallengePoint,id,pos,roomId,model,data,hideFlag)

end

function mysteryChallengePointController:create_entity(args)
return mysteryChallengePointController.create_challengepoint(args)
end

function mysteryChallengePointController:init_map_entity(roomId,completeCB)
roomId=roomId or mysteryRoomModel:get_cur_roomID()

local list={}
local num=5
local lIndex=0
local entitys=mysteryRoomModel:get_room_entity_birth_pos_list(roomId,eMysteryEntityType.eChallengePoint)
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
mysteryChallengePointController.create_challengepoint(v)
end
else
createTimer:cancel()
if completeCB then
completeCB()
end
end
end,-1)
end





function mysteryChallengePointController.update_challengepoint()

if not mysteryChallengePointController.handle_meet()then

mysteryAIManager:update_queue()
end
end


function mysteryChallengePointController.handle_meet()
local isMeet=false
local entity_list=mysteryChallengePointModel:get_entity_list()
for guid,v in pairs(entity_list)do

mysteryChallengePointModel:update_visible(guid)







if mysteryAIManager.meet_player(v,v.pos,mysteryChallengePointController.meet_result)then
isMeet=true
end

end
return isMeet
end

function mysteryChallengePointController.meet_result(originEntity,targetEntity)



mysterySkillController:set_hide_steps(0)


local id=originEntity.id

local config=mysteryChallengePointModel:get_config(id)
if config then










local mCfg=mysteryMonsterModel.get_monster_group_config(config.gwzList[1])
local items,detail=worldFightModel:getMonsterShowAwards(config.gwzList[1],mCfg.level)
local actRewards=worldFightModel:getMonsterExtraDropActReward(config.gwzList[1])
local zhenfa=MysteryModel:get_select_zhenFa()
local winParam={
groupId=config.gwzList[1],
name=mCfg.name,
icon=mCfg.model,
level=mCfg.level,
skills=mCfg.showSkills,
desc=mCfg.desc,
items=items,
detail=detail,
actRewards=actRewards,
title="妖怪信息",
highestType=mCfg.monType,


close=function()
UIFullMysteryMainControl:closeUI()
end,
challenge=function()
local mapId
if mCfg then
mapId=mCfg.mapId
end
local sendTeam=MysteryModel:get_fb_sendTeam()
fightLaunchController:sendFight(eBattleLaunch.mystery,sendTeam,mapId or 0,zhenfa,{2,{originEntity.pos.x,originEntity.pos.y,originEntity.data.guid}})

UIFullMysteryMainControl:closeUI()
end,
}
UIFullMysteryMainControl:showWindow("UIWorldBossWin",winParam)
end


if mysteryFightModel:get_after_queue_size()>0 then
mysteryFightModel:dequeue_after_callback()
end
end

function mysteryChallengePointController.recv_4_39(tzId,result,fightLog)
UIManager.info("触发战斗")


notifySystem:postNotify(notifyConfig.on_mystery_fight_start)

MysteryController:slideUI()



notifySystem:postNotify(notifyConfig.onTriggerBattle,eBattleType.mystery,result,fightLog,{})

if result==eMysteryFightResultType.eVictory then
local pos=mysteryPlayerModel:get_player_pos()
local roomId=mysteryRoomModel:get_cur_roomID()
local entity=mysteryChallengePointModel:get_entity_by_pos(pos,roomId)
if not entity then
return
end

mysteryChallengePointModel:remove_entity(entity.guid)
end
end