







local _MODULENAME="mysteryFightController"
gameState.addListener(def_table(_MODULENAME))
mysteryFightController.name=_MODULENAME




local curBattle
function mysteryFightController:onAppStart()
socketManager:register_receiver(4,19,mysteryFightController.recv_4_19)
notifySystem:listenNotify(notifyConfig.on_mystery_fight_complete,self.fightComplete)
notifySystem:listenNotify(notifyConfig.onBattleStageLoad,self.onBattleStageLoad)
end

function mysteryFightController:onEnterState()
mysteryFightModel:init_data()
curBattle=nil
end

function mysteryFightController:onLeaveState()
curBattle=nil
end


function mysteryFightController.fightComplete()

local triggerId=mysteryTriggerManager:get_cur_triggerId()
if triggerId and next(triggerId)then

mysteryTriggerManager:beforeTrigger(triggerId[1],nil,triggerId[2])
mysteryTriggerManager:set_cur_triggerId(nil)
end
end

function mysteryFightController:showFightRewardHUD()
local rewards=mysteryFightModel:get_fighting_reward()
if rewards then
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
local pos=mysteryPlayerModel:get_player_pos()
local roomId=mysteryRoomModel:get_cur_roomID()
local layer=mysteryRoomModel:get_GroundLayer(roomId)
if layer then
UIManager:invokeUIMethod("UIMysteryHUDWin","addUIHUD",eMysteryHUDType.eTreasure,{pos=pos,layer=layer,num=3,rewards=rewards,close=true})
end
mysteryFightModel:set_fighting_reward(nil)
end
end



function mysteryFightController:req_mystery_fight(teamList)
socketManager:send_4_19(#teamList,teamList)
end


function mysteryFightController.recv_4_19(args)
local teamId,fightResult,fightReportStr,evtGroupId,evtChoiceId,evtResultIndex=args[1],args[2],args[3],args[4],args[5],args[6]

local rewardList=fightResultModel:popReward(ePrizeType.eFight)or{}

if mysteryFightModel:has_battle_playing()then

mysteryFightModel:enqueue_result_callback(mysteryFightController.play_fight,teamId,fightResult,fightReportStr,rewardList)
else
mysteryFightController.play_fight(teamId,fightResult,fightReportStr,rewardList)
end



end




function mysteryFightController.play_fight(teamId,fightResult,fightReportStr)
UIManager:showWindow("UIFightPrepareLoading",{
startCallback=function()

curBattle=fightController.onTriggerBattle(eBattleType.mystery,fightResult,fightReportStr,teamId)
timeEventController.delayDo(1.2,function()
curBattle=nil
UIManager:invokeUIMethod("UIFightPrepareLoading","endAni")
end)
end,
})
end

function mysteryFightController.onBattleStageLoad(battleId)
if curBattle==battleId then
UIManager:invokeUIMethod("UIFightPrepareLoading","endAni")
end
end


function mysteryFightController:clear_fight_team()
local teamData=mysteryFightModel:get_fight_team()

for i,v in pairs(teamData)do

if v.hud then

v.hud:recycleSelf()
v.hud=nil
end
mysteryMonsterModel:remove_entity(v.guid)

notifySystem:postNotify(notifyConfig.on_mystery_monster_event,v.id)
end

mysteryFightModel:clear_fight_team()
end


function mysteryFightController:show_result_victory(battleid,rewardList)

fightController:closeBattle(battleid)
local items,exp=worldFightModel:turnResult(rewardList)
local winName="UIBattleVictoryWin"
local winArgs={
title=
{
text='战斗胜利',
},
items=items,
callback=function()
local fbid=MysteryModel:get_cur_fbid()
if fbid then

mysteryAIManager:update_queue()

MysteryController.send_4_21(fbid)

mysteryMonsterModel:refresh_all_hud()



UIManager:invokeUIMethod("UIMysteryWin","initTeamList")



if not mysteryFightModel:on_rule_callback()then

if mysteryFightModel:get_after_queue_size()>0 then
mysteryFightModel:dequeue_after_callback()
end
end
end
end,
}
UIManager:showWindow(winName,winArgs)
end














