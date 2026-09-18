











mysteryYaranzoController=mysteryEntityControllerBase.new(eMysteryEntityType.eYaranzo,mysteryEntityControllerBase)



function mysteryYaranzoController:onAppStart()

end

function mysteryYaranzoController:onEnterState()
mysteryYaranzoModel:init_data()
notifySystem:listenNotify(notifyConfig.on_mystery_create_entity,self.createEntityCb)
end

function mysteryYaranzoController:onLeaveState()
notifySystem:removelistener(notifyConfig.on_mystery_create_entity,self.createEntityCb)
end



function mysteryYaranzoController:create_entity(args)
local id=args.etId
local x=args.x
local y=args.y
local hideFlag=args.hideFlag
local roomId=args.roomId or mysteryRoomModel:get_cur_roomID()
local cfg=mysteryYaranzoModel:get_config(id)
local pos=Vector3(x,y,0)

if not cfg then
error(FMT.fmt("宝箱怪配置找不到{0},坐标：({1},{2})",id,x,y))
return
end


local modelCfg=cfg.shape

local model=
{
id=modelCfg[1],
components={},
layer=SortingLayers.ITBuilding,
scale=modelCfg[2],

isFlip=modelCfg.isFlip,
icon=modelCfg.icon,
iconScale=modelCfg.iconScale,
}
local data={}

for key,value in pairs(args)do
data[key]=value
end
local guid=mysteryYaranzoModel:create_entity(eMysteryEntityType.eYaranzo,id,pos,roomId,model,data,hideFlag)


return guid
end

function mysteryYaranzoController:init_map_entity(roomId,completeCB)
roomId=roomId or mysteryRoomModel:get_cur_roomID()
local list={}
local num=5
local lIndex=0
local entitys=mysteryRoomModel:get_room_entity_birth_pos_list(roomId,eMysteryEntityType.eYaranzo)
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
mysteryYaranzoController:create_entity(v)
end
else
createTimer:cancel()
if completeCB then
completeCB()
end
end
end,-1)
end





function mysteryYaranzoController.update_queue()

if not mysteryYaranzoController.handle_meet()then

mysteryAIManager:update_queue()
end
end


function mysteryYaranzoController.handle_meet()
local isMeet=false
local entity_list=mysteryYaranzoModel:get_entity_list()
for guid,v in pairs(entity_list)do

mysteryYaranzoModel:update_visible(guid)







if mysteryAIManager.meet_player(v,v.pos,mysteryYaranzoController.meet_result)then
isMeet=true
end

end
return isMeet
end

function mysteryYaranzoController.meet_result(originEntity,targetEntity)
mysterySkillController:set_hide_steps(0)
if not originEntity then
return
end


if originEntity.data.isRemove then
return
end

if originEntity.data.status==0 then
local role=mysteryYaranzoModel:get_role_entity(originEntity.guid)
if role then
role:FadeToColor(Color.New(1,1,1,0),0.4,function()
if originEntity.hud then
originEntity.hud:refreshStepVisible(false)
end

mysteryYaranzoModel.bornMonster=true
mysteryTreasureController.req_prize({originEntity})






end)
mysteryAIManager:set_mystery_state(true,nil,2)
originEntity.data.status=1
end
end
end

function mysteryYaranzoController.createEntityCb(guid,pos,entityType,id)
if entityType==eMysteryEntityType.eMonster then
if mysteryYaranzoModel.bornMonster then
mysteryAIManager:set_mystery_state(false)
mysteryYaranzoModel.bornMonster=false
local player=mysteryPlayerModel:get_player()
local playerRole=_HexMapManager.GetRole(player.guid)
local flipX=playerRole:GetFlipX()

local monsterRole=_HexMapManager.GetRole(guid)
if flipX then
monsterRole:SetFlipX(false)
mysteryPlayerController.runBehavior("PlayerMeetMonsterBoxLeft",function()
mysteryEntityController.handle_meet()
end)
mysteryMonsterModel:runBehavior(guid,"MonsterBoxRight")
else
monsterRole:SetFlipX(true)
mysteryPlayerController.runBehavior("PlayerMeetMonsterBoxRight",function()
mysteryEntityController.handle_meet()
end)
mysteryMonsterModel:runBehavior(guid,"MonsterBoxLeft")
end
end
end
end