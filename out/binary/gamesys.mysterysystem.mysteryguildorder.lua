




MysteryGuildOrder={}

eMysteryOrderReason=
{
eOrderSetupOpen=1,
eOrderActive=2,
ePassMystery=3,
eOrderOpen=4,
}

function MysteryGuildOrder.isOrderSetupOpen(fbid)
if MysteryModel:get_mystery_sence_type(fbid)~=MysterySenceType.ZiYuan then
return false
end

if not systemModel.isOpen(SYSTEM_DEFINE.eZongMenOrder)then
return false
end

local cfg=cfgHelper.get(cfg_guildorderconfig_get,GUILD_ORDER_TYPE.eMysteryAuto)
if cfg and((not guildOrderModel:checkSystemCnd(cfg))or(not guildOrderModel:checkOrderCondEx(cfg.unlock)))then
return false
end

if not guildOrderModel:isOrderSetupOpen(GUILD_ORDER_TYPE.eMysteryAuto)then
return false,eMysteryOrderReason.eOrderSetupOpen
end

if not guildOrderModel:checkOrderActive(GUILD_ORDER_TYPE.eMysteryAuto)then
return false,eMysteryOrderReason.eOrderActive
end

if not mysteryZiYuanFuBenModel:checkPassRewardByFbId(fbid)then
return false,eMysteryOrderReason.ePassMystery
end

return true
end

function MysteryGuildOrder:isInAuto()
return self.autoMode
end

function MysteryGuildOrder:setAutoMode(flag)
self.autoMode=flag
if flag then
MysteryGuildOrder:startAutoTimer()
else
MysteryGuildOrder:stopAutoTimer()
end
end

function MysteryGuildOrder:findMonsterPos()
local playerPos=mysteryPlayerModel:get_player_pos()
local roomId=mysteryRoomModel:get_cur_roomID()
local monsterList=mysteryMonsterModel:get_room_entity_list(roomId)
if monsterList and next(monsterList)then
return MysteryGuildOrder:findPos(playerPos,monsterList)
end
local monsterList=mysteryYaranzoModel:get_room_entity_list(roomId)
if monsterList and next(monsterList)then
return MysteryGuildOrder:findPos(playerPos,monsterList)
end





end

function MysteryGuildOrder:findEvent()
local roomId=mysteryRoomModel:get_cur_roomID()
local interactionList=mysteryInteractionModel:get_room_entity_list(roomId)
if interactionList and next(interactionList)then
return true
end
end

function MysteryGuildOrder:findPos(playerPos,list)
local distance=10000
local entGuid,pos
for i,v in pairs(list)do
local dis=mysteryPosHelper.get_pos_distance(playerPos,v.pos)
if dis<distance then
pos=v.pos
distance=dis
end
end
return pos
end

function MysteryGuildOrder:startAuto()
if mysteryAIManager:is_pause()then

return
end
if mysteryAIManager.is_on_round()then

return
end


if MysteryController:GetStopAutoFlag()then
self:setAutoMode(false)
UIManager:callWindowFunc("UIMysteryWin","setAutoMode",false)
MysteryController:SetStopAutoFlag(false)
end

local monsterPos=MysteryGuildOrder:findMonsterPos()
if not monsterPos then



return
end




local roomId=mysteryRoomModel:get_cur_roomID()

if mysteryPosHelper.is_same_pos(mysteryPlayerModel:get_player_pos(),monsterPos,roomId,roomId)then
mysteryEntityController.handle_meet()

return
end




if mysteryAIManager.create_path(monsterPos)then

mysteryAIManager:start_ai()

local groundLayer=mysteryRoomModel:get_GroundLayer(roomId)
UIManager:invokeUIMethod("UIMysteryHUDWin","addEndPointHUD",monsterPos,groundLayer)
else
UIManager.error("此处无法通行")
end
end

function MysteryGuildOrder:setAutoStart(flag)

self.autoFlag=flag
end

function MysteryGuildOrder:isAutoStart()
return self.autoFlag
end

function MysteryGuildOrder.updateAuto()
if not MysteryGuildOrder:isAutoStart()then
MysteryGuildOrder:startAuto()
end
end

function MysteryGuildOrder:startAutoTimer()
self:stopAutoTimer()
local tempTimer=timer.new()
tempTimer:start(1,self.updateAuto,-1)
self.autoTimer=tempTimer

end

function MysteryGuildOrder:stopAutoTimer()

if self.autoTimer then
self.autoTimer:cancel()
end
self.autoTimer=nil
end

function MysteryGuildOrder:stopAuto()
self:setAutoMode(false)
UIManager:callWindowFunc("UIMysteryWin","setAutoMode",false)
MysteryGuildOrder:stopAutoTimer()
end