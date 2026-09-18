











mysteryCurePointController=mysteryEntityControllerBase.new(eMysteryEntityType.eCurePoint,mysteryEntityControllerBase)

local _HexMapManager=CS.HexagonMapManagerInterface



function mysteryCurePointController:onAppStart()
socketManager:register_receiver(4,37,mysteryCurePointController.recv_4_37)
socketManager:register_receiver(4,47,mysteryCurePointController.recv_4_47)
end

function mysteryCurePointController:onEnterState()
mysteryCurePointModel:init_data()
end

function mysteryCurePointController:onLeaveState()

end



function mysteryCurePointController.create_curepoint(args)
local id=args.etId
local x=args.x
local y=args.y
local hideFlag=args.hideFlag
local roomId=args.roomId or mysteryRoomModel:get_cur_roomID()
local cfg=mysteryCurePointModel:get_config(id)
local pos=Vector3(x,y,0)

local cureType=cfg.hxType

local modelCfg=cfg.shape

local shape
if cureType==1 then
shape=modelCfg[1]
elseif cureType==2 then
shape=modelCfg[1]
end

local model=
{
id=shape[1],
components={},
layer=SortingLayers.ITBuilding,
scale=shape[2],
}
local data={}

for key,value in pairs(args)do
data[key]=value
end
local guid=mysteryCurePointModel:create_entity(eMysteryEntityType.eCurePoint,id,pos,roomId,model,data,hideFlag)


socketManager:send_4_47(x,y,0)
end

function mysteryCurePointController:create_entity(args)
return mysteryCurePointController.create_curepoint(args)
end


function mysteryCurePointController.changebody(guid,id,state)
local cfg=mysteryCurePointModel:get_config(id)
local modelCfg=cfg.shape
local shape
if cfg.hxType==2 then

if state==1 then
shape=modelCfg[1]
elseif state==2 then
shape=modelCfg[2]
end
mysteryCurePointModel:change_body(guid,shape[1],{},shape[2])
end
end

function mysteryCurePointController:init_map_entity(roomId,completeCB)
roomId=roomId or mysteryRoomModel:get_cur_roomID()

local list={}
local num=5
local lIndex=0
local entitys=mysteryRoomModel:get_room_entity_birth_pos_list(roomId,eMysteryEntityType.eCurePoint)
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
mysteryCurePointController:create_entity(v)
end
else
createTimer:cancel()
if completeCB then
completeCB()
end
end
end,-1)
end





function mysteryCurePointController.update_cure()

if not mysteryCurePointController.handle_meet()then

mysteryAIManager:update_queue()
end
end


function mysteryCurePointController.handle_meet()
local isMeet=false

local hmList={}
local hmStepList=mysteryCurePointModel:get_hmStep()
if hmStepList then
for guid,v in pairs(hmStepList)do
hmStepList[guid]=v+1
local entity=mysteryCurePointModel:get_entity(guid)
if entity then

socketManager:send_4_47(entity.pos.x,entity.pos.y,hmStepList[guid])
if mysteryCurePointModel:is_hmStep_enough(entity)then
hmList[guid]=entity
hmStepList[guid]=nil
end
end
end
end

for guid,v in pairs(hmList)do
mysteryCurePointController.changebody(guid,v.id,1)
end


local entity_list=mysteryCurePointModel:get_entity_list()
for guid,v in pairs(entity_list)do

mysteryCurePointModel:update_visible(guid)







if mysteryAIManager.meet_player(v,v.pos,mysteryCurePointController.meet_result)then
isMeet=true
break
end

end
return isMeet
end



function mysteryCurePointController.meet_result(originEntity,targetEntity)

local hmStepList=mysteryCurePointModel:get_hmStep()

MysteryGuildOrder:setAutoStart(true)

local okcallback=function()

mysterySkillController:set_hide_steps(0)


local hmStepList=mysteryCurePointModel:get_hmStep()

if not hmStepList[originEntity.guid]then
socketManager:send_4_37()
mysteryCurePointModel:set_cur_curePoint(originEntity)
else

mysteryAIManager:update_queue()
end


if mysteryFightModel:get_after_queue_size()>0 then
mysteryFightModel:dequeue_after_callback()
end


MysteryGuildOrder:setAutoStart(false)
end

local cancelback=function()

mysteryAIManager:update_queue()

if mysteryFightModel:get_after_queue_size()>0 then
mysteryFightModel:dequeue_after_callback()
end
end


local cfg=mysteryCurePointModel:get_config(originEntity.id)

local addStr=cfg.hxType==mysteryCurePointType.last and FMT.fmt('\n（移动{0}步后可再次使用）',cfg.hmStep or 0)or''

local showdata=
{
type='UIDialouge',
title='提示',
content=FMT.fmt("是否恢复全体弟子{0}生命？ {1}",FMT.fmt('{0}%',cfg.percent),addStr),
oktext='确定',
canceltext='取消',
allowclickBG='false',

okcallback=okcallback,
cancelback=cancelback,
}

if not hmStepList[originEntity.guid]then
if MysteryGuildOrder:isInAuto()then
okcallback()
else
if not mysteryCurePointController.comfirmDialog then
mysteryCurePointController.comfirmDialog=UIDialogManager.newDialog(showdata)
mysteryCurePointController.comfirmDialog.deleteSelf=function(...)
mysteryCurePointController.comfirmDialog=nil
end
mysteryCurePointController.comfirmDialog:show()
end
end
else

mysteryAIManager:update_queue()

if mysteryFightModel:get_after_queue_size()>0 then
mysteryFightModel:dequeue_after_callback()
end


MysteryGuildOrder:setAutoStart(false)
end

end

function mysteryCurePointController.recv_4_37()
local curCurePoint=mysteryCurePointModel:get_cur_curePoint()
local hmStep=mysteryCurePointModel:init_hmStep(curCurePoint)
if not hmStep then
mysteryCurePointModel:remove_entity(curCurePoint.guid)
else
mysteryCurePointController.changebody(curCurePoint.guid,curCurePoint.id,2)
end
local cfg=mysteryCurePointModel:get_config(curCurePoint.id)

UIManager.info(FMT.fmt("生命值回复{0}%",cfg.percent))


mysteryAIManager:update_queue()
end

function mysteryCurePointController.recv_4_47(x,y,stepNum)
local roomId=mysteryRoomModel:get_cur_roomID()
local hmStepList=mysteryCurePointModel:get_hmStep()
local entity=mysteryCurePointModel:get_entity_by_pos(Vector3(x,y,0),roomId)
if entity then
if not mysteryCurePointModel:is_hmStep_enough(entity,stepNum)then
if mysteryCurePointModel:get_type(entity.id)==2 and stepNum>0 then
hmStepList[entity.guid]=stepNum
mysteryCurePointController.changebody(entity.guid,entity.id,2)
end
end
end
end