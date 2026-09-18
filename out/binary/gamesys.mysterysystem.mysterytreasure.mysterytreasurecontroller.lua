











mysteryTreasureController=mysteryEntityControllerBase.new(eMysteryEntityType.eTreasure,mysteryEntityControllerBase)

local _HexMapManager=CS.HexagonMapManagerInterface
local CreateRole=_HexMapManager.CreateRole
local SetPosition=_HexMapManager.SetPosition
local Vector3ToVector3Int=_HexMapManager.Vector3ToVector3Int




function mysteryTreasureController:onAppStart()
socketManager:register_receiver(4,12,mysteryTreasureController.recv_4_12)
socketManager:register_receiver(4,32,mysteryTreasureController.recv_4_32)
socketManager:register_receiver(4,33,mysteryTreasureController.recv_4_33)
socketManager:register_receiver(4,34,mysteryTreasureController.recv_4_34)
end

function mysteryTreasureController:onEnterState()
notifySystem:listenNotify(notifyConfig.on_mystery_player_move_start,mysteryTreasureController.on_mystery_player_move_start)
notifySystem:listenNotify(notifyConfig.onShowPrize,self.onShowPrize)
end

function mysteryTreasureController:onLeaveState()
notifySystem:removelistener(notifyConfig.on_mystery_player_move_start,mysteryTreasureController.on_mystery_player_move_start)
end



function mysteryTreasureController.create_treasure(args)
local id=args.etId
local x=args.x
local y=args.y
local roomId=args.roomId
local hideFlag=args.hideFlag
local stepNum=args.stepNum
local boxType=args.status
roomId=roomId or mysteryRoomModel:get_cur_roomID()
local treasureId=id
local treasurePos=Vector3(x,y,0)
local treasureCfg
boxType=boxType or mysteryTreasureModel.boxType.box
if boxType==mysteryTreasureModel.boxType.rule then
treasureCfg=mysteryTreasureModel.get_rule_treasure_config(id)
treasureCfg.model=treasureCfg.dropBoxModel
else
treasureCfg=mysteryTreasureModel.get_treasure_config(treasureId)
end







local model=
{
id=treasureCfg.model[1],
components={},
layer=SortingLayers.ITBuilding,
scale=treasureCfg.model[2],
isFlip=treasureCfg.model.isFlip,
icon=treasureCfg.model.icon,
iconScale=treasureCfg.model.iconScale,
}
local data=
{
boxType=boxType,
showInFog=treasureCfg.showInFog,
}


for key,value in pairs(args)do
data[key]=value
end

local guid=mysteryTreasureModel:create_entity(eMysteryEntityType.eTreasure,treasureId,treasurePos,roomId,model,data,hideFlag)

if stepNum and stepNum>0 then
mysteryTreasureModel.existTimer[guid]=stepNum+1
end
end

function mysteryTreasureController:create_entity(args)
return mysteryTreasureController.create_treasure(args)
end

function mysteryTreasureController:init_map_entity(roomId,completeCB)
roomId=roomId or mysteryRoomModel:get_cur_roomID()

local list={}
local num=5
local lIndex=0
local entitys=mysteryRoomModel:get_room_entity_birth_pos_list(roomId,eMysteryEntityType.eTreasure)
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
mysteryTreasureController.create_treasure(v)
end
else
createTimer:cancel()
if completeCB then
completeCB()
end
end
end,-1)
end


function mysteryTreasureController.update_treasure()

if not mysteryTreasureController.handle_meet()then

mysteryAIManager:update_queue()
end
end

function mysteryTreasureController.on_mystery_player_move_start()

mysteryTreasureController.disappear_update()
end

function mysteryTreasureController.disappear_update()
local treasure_list=mysteryTreasureModel:get_entity_list()
for guid,v in pairs(treasure_list)do
if mysteryTreasureModel.existTimer[guid]then
mysteryTreasureModel.existTimer[guid]=mysteryTreasureModel.existTimer[v.guid]-1
if mysteryTreasureModel.existTimer[guid]<=0 then
mysteryTreasureModel:remove_entity(guid)
mysteryTreasureModel.existTimer[guid]=nil
end
end
end
end


function mysteryTreasureController.handle_meet()
local isMeet=false
local treasure_list=mysteryTreasureModel:get_entity_list()
for guid,v in pairs(treasure_list)do

mysteryTreasureModel:update_visible(guid)







if mysteryAIManager.meet_player(v,v.pos,mysteryTreasureController.meet_result)then
isMeet=true
end

end


return isMeet
end

function mysteryTreasureController.meet_result(originEntity,targetEntity)



mysterySkillController:set_hide_steps(0)


local mysteryId=MysteryModel:get_cur_fbid()
local treasure=originEntity
if treasure.data.isMeet then
return
end
treasure.data.isMeet=true





mysteryTreasureController.req_prize({treasure})




if mysteryFightModel:get_after_queue_size()>0 then
mysteryFightModel:dequeue_after_callback()
end
end

function mysteryTreasureController:autoRemove(lookUp)
UIManager.setMoneyMsgShowState(false,true)
local treasure_list=mysteryTreasureModel:get_entity_list()
local roomId=mysteryRoomModel:get_cur_roomID()
local layer=mysteryRoomModel:get_GroundLayer(roomId)
UIManager.info("即将拾取剩余物品")
local pos=mysteryPlayerModel:get_player_pos()
mysteryFogController:createEffect(10317,pos,layer,0)
local epos=_HexMapManager.GetCellCenterWorld(pos,layer)
timeEventController.delayDo(1,function()
local delayList={}
for guid,v in pairs(treasure_list)do
UIManager:invokeUIMethod("UIMysteryHUDWin","addUIHUD",eMysteryHUDType.eTreasure,{pos=v.pos,layer=layer,playEffect=true,close=true})
local entity=_HexMapManager.GetRole(guid)
if entity then
entity:RunAnimator(eAnimationID.openBox)
Lua.DOTweenProxyExtensions.DOJump(entity:GetActorRootTransform(),epos,1,1,1.7)
entity:FadeToColor(Color.New(1,1,1,0),0.3,nil,1.7)
delayList[guid]=true
else

mysteryTreasureModel:remove_entity(guid)
end
end
timeEventController.delayDo(2,function()
for guid,v in pairs(delayList)do
mysteryTreasureModel:remove_entity(guid)
end
end)
end)
timeEventController.delayDo(2,function()
UIManager.setMoneyMsgShowState(true,true)
local ii=0
for i,v in pairs(lookUp)do
if ii>6 then
break
end
UIManager.rewardInfo(iconHelper.getIconName(v[1]),FMT.fmt('X{0}',v[2]))
ii=ii+1
end
end)


end




function mysteryTreasureController.req_prize(entityList)

local sendList={}
for i,v in ipairs(entityList)do
table.insert(sendList,{v.pos.x,v.pos.y,v.entityType,v.data.guid})
end
socketManager:send_4_12(#sendList,sendList)
end


function mysteryTreasureController.recv_4_12(etListLen,etList)
if etListLen>0 then
for i,v in ipairs(etList)do
mysteryTreasureController.recv_treasure(v.x,v.y,v.etType,v.etGuid)
end
end
end

function mysteryTreasureController.recv_treasure(x,y,etType,sGUID)

local pos=Vector3.New(x,y,0)
local roomId=mysteryRoomModel:get_cur_roomID()
local layer=mysteryRoomModel:get_GroundLayer(roomId)

local treasure

if etType==eMysteryEntityType.eTreasure then
AudioManager.playAudio(429)
treasure=mysteryTreasureModel:get_entity_by_server_guid(sGUID)
else
treasure=mysteryEntityController.invokeFuncByMysteryEntityType(etType,'get_entity_by_server_guid',sGUID)
end


if not treasure then
return
end

local entity=_HexMapManager.GetRole(treasure.guid)
if entity then
entity:RunAnimator(eAnimationID.openBox)
local _timer=timer.new()
_timer:start(1,function()

mysteryEntityController.invokeFuncByMysteryEntityType(etType,'remove_entity',treasure.guid)

end)
end



local rewards={}

local config=mysteryEntityController.invokeFuncByMysteryEntityType(etType,'get_config',treasure.id)or mysteryTreasureModel:get_config(treasure.id)

local rare=false
if config then
rare=config.rare
end
local haveRare=rare


if mysteryTreasureController.recordItemData and next(mysteryTreasureController.recordItemData)then
rewards=mysteryTreasureController.recordItemData
else
mysteryTreasureController.sortPrize(rewards)
end

UIManager:invokeUIMethod("UIMysteryHUDWin","addUIHUD",eMysteryHUDType.eTreasure,{pos=pos,layer=layer,num=3,rewards=rewards,close=true})

if haveRare and not mysteryTreasureModel.showWindow and not MysteryGuildOrder:isInAuto()then
mysteryTreasureModel.showWindow=true

showPrizeControl.showWindowFullScreen(rewards,UIFullMysteryMainControl,function()
mysteryTreasureModel.showWindow=false
if mysteryTreasureModel.finCB then
mysteryTreasureModel.finCB()
mysteryTreasureModel.finCB=nil
else

mysteryAIManager:update_queue()
end
end)
else

mysteryAIManager:update_queue()
end




mysteryTreasureController.recordItemData={}
end

function mysteryTreasureController.sortPrize(rewards)
table.sort(rewards,function(a,b)
local aConfig=itemsConfig.getConfig(a.itemid)
local bConfig=itemsConfig.getConfig(b.itemid)
local aRareLv=itemsConfig.getRareLv(a.itemid)
local bRareLv=itemsConfig.getRareLv(b.itemid)
local aScore=aRareLv*10000
local bScore=bRareLv*10000
aScore=aScore+aConfig.color
bScore=bScore+bConfig.color
return aScore>bScore
end)
end

function mysteryTreasureController.onShowPrize(prizeType,prizelist,effectData)
if prizeType==ePrizeType.eMysteryTreasure then
prizelist=prizelist or{}
for i,v in ipairs(prizelist or{})do
mysteryTreasureModel:recordItem(v.itemid,v.num,v.itemguid)
local _itemcount=v.num
if _itemcount>0 then
bagModel.popupRewardInfo(v.itemid,v,_itemcount)
end
end
mysteryTreasureModel:saveRecordItemList()
UIManager:invokeUIMethod("UIMysteryWin","showRecordCorner")
mysteryTreasureController.sortPrize(prizelist)
mysteryTreasureController.recordItemData=prizelist
end
end

function mysteryTreasureController.recv_4_32(len,treasureList)
if len>0 then

for i,data in ipairs(treasureList)do
mysteryTreasureModel.treasure_queue:enqueue(data)
end
mysteryTreasureController:mystery_created()
end
end

function mysteryTreasureController.recv_4_33(fzBoxListLen,fzBoxList)








end

function mysteryTreasureController.req_rule()
socketManager:send_4_34()
end


function mysteryTreasureController.recv_4_34(result,x,y)
if result==1 then

return
end

AudioManager.playAudio(429)
local pos=Vector3(x,y,0)
local roomId=mysteryRoomModel:get_cur_roomID()
local treasure=mysteryTreasureModel:get_entity_by_pos(pos,roomId,mysteryTreasureModel.boxType.rule)
if not treasure then
return
end




mysteryTreasureModel:remove_entity(treasure.guid)

end



function mysteryTreasureController:mystery_created()
local roomId=mysteryRoomModel:get_cur_roomID()
local mapType=mysteryRoomModel:get_mapType_by_roomID(roomId)
local groundLayer=MysteryController.MapLayerLookUp[mapType].GroundLayer
if mysteryTreasureModel.treasure_queue:size()>0 then

local value=mysteryTreasureModel.treasure_queue:dequeue()
if value then
mysteryFogController:createEffect(5,Vector3(value.x,value.y,0),groundLayer,0.5,function()
if value.boxType==mysteryTreasureModel.boxType.rule then
mysteryTreasureController:create_entity({etId=value.fzLibId,x=value.x,y=value.y,roomId=roomId,stepNum=value.hhNum,boxType=value.boxType})

else
mysteryTreasureController:create_entity({etId=value.boxId,x=value.x,y=value.y,roomId=roomId,stepNum=value.hhNum,boxType=value.boxType})

end
end)
if mysteryTreasureModel.treasure_queue:size()>0 then
self:mystery_created()
else
notifySystem:postNotify(notifyConfig.on_mystery_entity_create_complete,eMysteryEntityType.eTreasure)
end



end
end
end
