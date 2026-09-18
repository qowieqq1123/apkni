






local _MODULENAME="MysteryEventPart"
gameState.addListener(def_table(_MODULENAME))
MysteryEventPart.name=_MODULENAME


MysteryEventPart.data={}



function MysteryEventPart:onAppStart()
socketManager:register_receiver(4,7,MysteryEventPart.recv_event_data)
socketManager:register_receiver(4,15,MysteryEventPart.recv_4_15)
end

function MysteryEventPart:onEnterState()

notifySystem:listenNotify(notifyConfig.on_mystery_interaction_event,self.onMysteryInteractionEvent)
notifySystem:listenNotify(notifyConfig.on_mystery_entity_create_complete,self.onMysteryEntityCreateComplete)

notifySystem:listenNotify(notifyConfig.on_mystery_event_finish,self.onMysteryEventFightFinish)
notifySystem:listenNotify(notifyConfig.on_mystery_event_finish_s,self.onMysteryEventFightFinishServer)
notifySystem:listenNotify(notifyConfig.onShowPrize,self.onShowPrize)
notifySystem:listenNotify(notifyConfig.on_mystery_event_break,self.on_mystery_event_break)

self:initData()
end

function MysteryEventPart:onLeaveState()
notifySystem:removelistener(notifyConfig.on_mystery_interaction_event,self.onMysteryInteractionEvent)
notifySystem:removelistener(notifyConfig.on_mystery_entity_create_complete,self.onMysteryEntityCreateComplete)
notifySystem:removelistener(notifyConfig.on_mystery_event_finish,self.onMysteryEventFightFinish)
notifySystem:removelistener(notifyConfig.on_mystery_event_finish_s,self.onMysteryEventFightFinishServer)
notifySystem:removelistener(notifyConfig.onShowPrize,self.onShowPrize)
notifySystem:removelistener(notifyConfig.on_mystery_event_break,self.on_mystery_event_break)


self:initData()
end

function MysteryEventPart:initData()
self.data={}
self.data.qiYuPos={}
self.data.qiYuGUID={}
end

function MysteryEventPart:setQiYuPos(guid,playerPos)
self.data.qiYuPos[tostring(guid)]=playerPos
end

function MysteryEventPart:getQiYuPos(guid)
return self.data.qiYuPos[tostring(guid)]
end

function MysteryEventPart:setQiYuGUID(guid,hdwGuid)
self.data.qiYuGUID[tostring(guid)]=hdwGuid
end

function MysteryEventPart:getQiYuGUID(guid)
return self.data.qiYuGUID[tostring(guid)]
end

function MysteryEventPart:sethdwGUID(hdwGuid,guid)
self.data.qiYuGUID[tostring(hdwGuid)]=guid
end

function MysteryEventPart:gethdwGUID(hdwGuid)
return self.data.qiYuGUID[tostring(hdwGuid)]
end


function MysteryEventPart.recv_4_15(fbid,x,y,hdwGuid,qiyuItem)
if UIManager:isActive("UIMysteryFinishWin")then
return
end
local qiyuguid=qiyuItem.guid





MysteryEventPart:sethdwGUID(hdwGuid,qiyuguid)

MysteryEventListModel:add_event(SYSTEM_DEFINE.eMiJing,qiyuItem)
MysteryEventModel:set_dice_max_count(qiyuItem.guid,qiyuItem.diceNum)
local eventGroupId=qiyuItem.eventGroupId
local optionId=qiyuItem.choiceId
MysteryEventPart:setQiYuGUID(qiyuguid,hdwGuid)
if eventGroupId~=0 and optionId==0 then
local playerPos=mysteryPlayerModel:get_player_pos()
MysteryEventModel:set_event_flag(playerPos)
MysteryEventPart:setQiYuPos(qiyuguid,playerPos)
MysteryEventSystem:show_event_win(qiyuItem.guid,SYSTEM_DEFINE.eMiJing,eventGroupId,MysteryModel:get_fb_probeTeam(),{qiyuItem.choiceId,qiyuItem.resultConf,qiyuItem.resultIndex})
baseFullScreenUI:openMain(false)
elseif eventGroupId~=0 and optionId~=0 then
local playerPos=mysteryPlayerModel:get_player_pos()
MysteryEventModel:set_event_flag(playerPos)
MysteryEventPart:setQiYuPos(qiyuguid,playerPos)
local diziguid
if qiyuItem.dzList then
diziguid=qiyuItem.dzList[1]
end
MysteryEventModel:set_select_disciple(diziguid)
MysteryEventSystem:show_event_win(qiyuItem.guid,SYSTEM_DEFINE.eMiJing,eventGroupId,MysteryModel:get_fb_probeTeam(),{qiyuItem.choiceId,qiyuItem.resultConf,qiyuItem.resultIndex})
baseFullScreenUI:openMain(false)
end
mysteryAIManager:set_mystery_state(true,false,2)
MysteryEventPart.data.isInMysteryEvent=true

mysteryMonsterModel:clear_monster_select()
UIManager:closeWindow("UIWorldBossWin")
end


function MysteryEventPart.recv_event_data(dataListlen,dataList)
if dataListlen<=0 then
return
end
for i,v in ipairs(dataList)do
if v.dataType==1 then
MysteryModel:set_fb_power(v.newVal)
UIManager:invokeUIMethod("UIMysteryWin","refreshPower")
elseif v.dataType==2 then
local skillid=v.param_1
mysterySkillModel:set_fb_probeSkill_use_count(skillid,v.newVal)
elseif v.dataType==3 then

elseif v.dataType==4 then

elseif v.dataType==5 then

elseif v.dataType==6 then

elseif v.dataType==9 then
local x=v.newVal
local y=tonumber(tostring(v.param_1))
local id=tonumber(tostring(v.param_2))
local roomID=mysteryRoomModel:get_cur_roomID()
mysteryTreasureController.create_treasure({etId=id,x=x,y=y,roomId=roomID,hideFlag=eMysteryTreasureStatus.eProbed})
elseif v.dataType==10 then
local x=v.newVal
local y=tonumber(tostring(v.param_1))
local id=tonumber(tostring(v.param_2))
local roomID=mysteryRoomModel:get_cur_roomID()
mysteryObstacleController:create_entity({etId=id,x=x,y=y,roomId=roomID})

end
end
end




function MysteryEventPart.onMysteryInteractionEvent(interaction)
if not interaction then
return
end

if interaction.data.isRemove then
return
end

local interactionCfg=mysteryInteractionModel.get_interaction_config(interaction.id)

if UIManager:isActive("UIMysteryFinishWin")then
return
end


local eventgroupid=interactionCfg.eventgroupid
if eventgroupid then
MysteryEventSystem.send_4_15(interaction.pos.x,interaction.pos.y,interaction.data.guid)
mysteryAIManager:set_mystery_state(true,false,2)
end
end

function MysteryEventPart.onMysteryEntityCreateComplete(entityType)
local result_group=MysteryEventModel:get_result_select()
if result_group then
local guid=result_group[2]
local flag=MysteryEventModel:get_current_result_flag()
local check=flag==MysteryEventResult.EventResultType.addMonster or flag==MysteryEventResult.EventResultType.addInteraction or
flag==MysteryEventResult.EventResultType.addTreasure
if MysteryEventModel:get_result_callback_count(guid)>0 and check then
notifySystem:postNotify(notifyConfig.on_mystery_event_result_finish_c,guid)
end
end
end

function MysteryEventPart.onMysteryEventFightFinish(sysId,evtGuid,eventgroupid)
if not MysteryModel:is_enter_Mystery()then
return
end
local hdwGUID=MysteryEventPart:getQiYuGUID(evtGuid)
if hdwGUID then
local interaction=mysteryInteractionModel:get_entity_by_server_guid(hdwGUID)
if interaction then
interaction.data.isRemove=true
mysteryInteractionModel:remove_entity(interaction.guid)
end
else
local evtPos=evtGuid~=nil and MysteryEventPart:getQiYuPos(evtGuid)
if evtPos then
local interaction=mysteryInteractionModel:get_entity_by_pos(evtPos,mysteryRoomModel:get_cur_roomID())
if interaction then
mysteryInteractionModel:remove_entity(interaction.guid)
else
logErr(FMT.fmt('mystery not find qiyuEnt1:{0}',serializeHelper.serialize(evtPos)))
end
else
local interaction=mysteryInteractionModel:get_entity_by_pos(mysteryPlayerModel:get_player_pos(),mysteryRoomModel:get_cur_roomID())
if interaction then
mysteryInteractionModel:remove_entity(interaction.guid)
else
logErr(FMT.fmt('mystery not find qiyuEnt2:{0}',serializeHelper.serialize(mysteryPlayerModel:get_player_pos())))
end
end
end







baseFullScreenUI:openMain(true)

mysteryEntityController.handle_meet()

MysteryController:bloodCheck()
MysteryEventPart.data.isInMysteryEvent=false

mysteryFightModel:set_fighting(nil)
end

function MysteryEventPart.on_mystery_event_break(sysId,groupId,evtGuid)
local hdwGUID=MysteryEventPart:getQiYuGUID(evtGuid)
MysteryEventPart:sethdwGUID(hdwGUID,nil)
MysteryEventPart:setQiYuGUID(evtGuid,nil)
end

function MysteryEventPart.onMysteryEventFightFinishServer(evtGuid,endData)
if not MysteryModel:is_enter_Mystery()then
return
end
local hdwGUID=MysteryEventPart:getQiYuGUID(evtGuid)
if hdwGUID then
MysteryEventPart:sethdwGUID(hdwGUID,nil)
end
MysteryEventPart:setQiYuGUID(evtGuid,nil)

if endData~=nil and endData.mjEntityGuid then
local interaction=mysteryInteractionModel:get_entity_by_server_guid(endData.mjEntityGuid)
if interaction then
mysteryInteractionModel:remove_entity(interaction.guid)
end
end
baseFullScreenUI:openMain(true)
end

function MysteryEventPart:isInEvent()
return MysteryEventPart.data.isInMysteryEvent
end

function MysteryEventPart.onShowPrize(prizeType,prizelist)
if not MysteryModel:is_enter_Mystery()then
return
end
if prizeType==ePrizeType.eMystery then
if prizelist then
local haveRare=false

for i,v in ipairs(prizelist or{})do
if itemsConfig.isRare(v.itemid)and(not haveRare)then
haveRare=true
end
mysteryTreasureModel:recordItem(v.itemid,v.num,v.itemguid)
end
mysteryTreasureModel:saveRecordItemList()
UIManager:invokeUIMethod("UIMysteryWin","showRecordCorner")
end
end
end


