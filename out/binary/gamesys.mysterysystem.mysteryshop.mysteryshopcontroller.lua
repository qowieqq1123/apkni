











mysteryShopController=mysteryEntityControllerBase.new(eMysteryEntityType.eShop,mysteryEntityControllerBase)

local _HexMapManager=CS.HexagonMapManagerInterface



function mysteryShopController:onAppStart()
socketManager:register_receiver(4,40,mysteryShopController.recv_4_40)
socketManager:register_receiver(4,41,mysteryShopController.recv_4_41)
end

function mysteryShopController:onEnterState()
mysteryObstacleModel:init_data()
end

function mysteryShopController:onLeaveState()

end



function mysteryShopController.create_shop(args)
local id=args.etId
local x=args.x
local y=args.y
local hideFlag=args.hideFlag
local roomId=args.roomId or mysteryRoomModel:get_cur_roomID()
local cfg=mysteryShopModel:get_config(id)

if not cfg then
logErr(FMT.fmt("没有该商店的配置{0} x {1}, y {2}",id,x,y))
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
isFlip=modelCfg.isFlip,
}
local data={}

for key,value in pairs(args)do
data[key]=value
end
local guid=mysteryShopModel:create_entity(eMysteryEntityType.eShop,id,pos,roomId,model,data,hideFlag)

end

function mysteryShopController:create_entity(args)
return mysteryShopController.create_shop(args)
end

function mysteryShopController:init_map_entity(roomId,completeCB)
roomId=roomId or mysteryRoomModel:get_cur_roomID()
local list={}
local num=5
local lIndex=0
local entitys=mysteryRoomModel:get_room_entity_birth_pos_list(roomId,eMysteryEntityType.eShop)
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
mysteryShopController.create_shop(v)
end
else
createTimer:cancel()
if completeCB then
completeCB()
end
end
end,-1)


end





function mysteryShopController.update_shop()

if not mysteryShopController.handle_meet()then

mysteryAIManager:update_queue()
end
end


function mysteryShopController.handle_meet()
local isMeet=false
local entity_list=mysteryShopModel:get_entity_list()
for guid,v in pairs(entity_list)do

mysteryShopModel:update_visible(guid)







if mysteryAIManager.meet_player(v,v.pos,mysteryShopController.meet_result)then
isMeet=true
end

end
return isMeet
end

function mysteryShopController.meet_result(originEntity,targetEntity)



mysterySkillController:set_hide_steps(0)

mysteryShopModel.openEntity=originEntity


socketManager:send_4_40()




if mysteryFightModel:get_after_queue_size()>0 then
mysteryFightModel:dequeue_after_callback()
end
end

function mysteryShopController.send_4_41(shopItemIndex)
local canBuy,reason,itemid=fairModel:can_buy(eFairType.eMysteryMarket,shopItemIndex)
if canBuy then
socketManager:send_4_41(shopItemIndex)
else
if reason==1 then
UIManager.error("已购买")
elseif reason==2 then
UIManager.error("所需货币不足")
gainControl:showGainWin(itemid)
end
end
end





function mysteryShopController.recv_4_40(len,itemList)
if len>0 then
local goodsList={}
for i,v in ipairs(itemList)do
table.insert(goodsList,{v.itemId,v.itemNum,v.hbId,v.hbNum,buyFlag=v.buyFlag})
end
fairModel:set_type_data(eFairType.eMysteryMarket,goodsList)

local desc=''
if mysteryShopModel.openEntity then
local config=mysteryShopModel:get_config(mysteryShopModel.openEntity.id)
desc=config.desc or''
mysteryShopModel.openEntity=nil
end

UIFullMysteryShopControl:showMysteryShopWindow({desc=desc})
end
end

function mysteryShopController.recv_4_41(itemId,itemNum)
fairModel:update_type_goods_data(eFairType.eMysteryMarket,itemId,1)
UIManager:invokeUIMethod("UIGuiShiWin","refreshOtherListGoods")
end
