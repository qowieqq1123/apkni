







MysteryEventResult={}


MysteryEventResult.EventResultType=
{
getItem=1,
teamAddBuff=2,
discipleAddBuff=3,
getRule=4,
selectRule=5,
removeObstacle=6,
addObstacle=7,
addMonster=8,
removeMonster=9,
nextEvent=10,
addPortal=11,
removePortal=12,
changeMonsterBuff=13,
resurrection=14,
addPower=15,
addSkillTimes=16,
addInteraction=17,
addTreasure=18,
getLingShou=20,
fighting=23,
itemChange=24,
discipleChangeInjuryState=25,
discipleChangeInjury=26,
teamChangeInjuryState=27,
teamChangeInjury=28,
discipleAddHp=29,
teamAddHp=30,
discipleAddStrange=31,
discipleAddExp=32,
teamAddExp=33,
teamAddAttr=34,
discipleAddAttr=35,
changeShaneValue=36,
changeZongmenexp=37,
createPortal=38,
changeMonsterLevel=39,
shop=40,
game=41,
zongmenEvent=42,
resPointEvent=43,
enterMystery=44,
moreDiscipleChangeBlood=45,
moreDiscipleChangeInjury=46,
showPlotBoard=47,
createEntity=48,
removeEntity=49,
mysteryTrigger=50,
recruitTips=51,
showStoryTree=53,
resPointEvent2=54,
RecruitSelect=55,
createMystery=56,
enterQiyuMystery=57,
sfpyAngry=58,
sfpyRule=59,
sfpyAngrynowin=60,
xjresPointEvent=61,
removeEntityById=62,
xjmjresPointEvent=63,
}


function MysteryEventResult:bind_data()

MysteryEventResult.bindCommonResult=
{
[MysteryEventResult.EventResultType.getItem]=MysteryEventResult.result_get_item,
[MysteryEventResult.EventResultType.getRule]=MysteryEventResult.result_get_rule,
[MysteryEventResult.EventResultType.selectRule]=MysteryEventResult.result_select_rule,
[MysteryEventResult.EventResultType.removeObstacle]=MysteryEventResult.result_remove_obstacle,
[MysteryEventResult.EventResultType.addObstacle]=MysteryEventResult.result_add_obstacle,
[MysteryEventResult.EventResultType.addMonster]=MysteryEventResult.result_add_monster,
[MysteryEventResult.EventResultType.removeMonster]=MysteryEventResult.result_remove_monster,
[MysteryEventResult.EventResultType.resurrection]=MysteryEventResult.result_resurrection,
[MysteryEventResult.EventResultType.addPower]=MysteryEventResult.result_add_power,
[MysteryEventResult.EventResultType.addSkillTimes]=MysteryEventResult.result_add_skill_times,
[MysteryEventResult.EventResultType.addInteraction]=MysteryEventResult.result_add_multi_interaction,
[MysteryEventResult.EventResultType.addTreasure]=MysteryEventResult.result_add_multi_treasure,
[MysteryEventResult.EventResultType.fighting]=MysteryEventResult.result_fighting,
[MysteryEventResult.EventResultType.itemChange]=MysteryEventResult.result_item_cost,
[MysteryEventResult.EventResultType.discipleChangeInjuryState]=MysteryEventResult.result_disciple_change_injury_state,
[MysteryEventResult.EventResultType.discipleChangeInjury]=MysteryEventResult.result_disciple_change_injury,
[MysteryEventResult.EventResultType.teamChangeInjuryState]=MysteryEventResult.result_team_change_injury_state,
[MysteryEventResult.EventResultType.teamChangeInjury]=MysteryEventResult.result_team_change_injury,
[MysteryEventResult.EventResultType.discipleAddHp]=MysteryEventResult.result_disciple_add_hp,
[MysteryEventResult.EventResultType.teamAddHp]=MysteryEventResult.result_team_add_hp,
[MysteryEventResult.EventResultType.discipleAddStrange]=MysteryEventResult.result_disciple_change_speciality,
[MysteryEventResult.EventResultType.discipleAddExp]=MysteryEventResult.result_disciple_add_exp,
[MysteryEventResult.EventResultType.teamAddExp]=MysteryEventResult.result_team_add_exp,
[MysteryEventResult.EventResultType.teamAddAttr]=MysteryEventResult.result_team_add_attr,
[MysteryEventResult.EventResultType.discipleAddAttr]=MysteryEventResult.result_disciple_add_attr,
[MysteryEventResult.EventResultType.changeShaneValue]=MysteryEventResult.result_change_shane_value,
[MysteryEventResult.EventResultType.changeZongmenexp]=MysteryEventResult.result_change_zongmen_exp,
[MysteryEventResult.EventResultType.createPortal]=MysteryEventResult.result_create_portal,
[MysteryEventResult.EventResultType.changeMonsterLevel]=MysteryEventResult.changeMonsterLevel,
[MysteryEventResult.EventResultType.shop]=MysteryEventResult.result_shop,

[MysteryEventResult.EventResultType.zongmenEvent]=MysteryEventResult.result_zongmen_event,
[MysteryEventResult.EventResultType.resPointEvent]=MysteryEventResult.result_respoint_event,

[MysteryEventResult.EventResultType.moreDiscipleChangeBlood]=MysteryEventResult.result_more_disciple_change_blood,
[MysteryEventResult.EventResultType.moreDiscipleChangeInjury]=MysteryEventResult.result_more_disciple_change_injury,
[MysteryEventResult.EventResultType.createEntity]=MysteryEventResult.result_add_multi_treasure,
[MysteryEventResult.EventResultType.removeEntity]=MysteryEventResult.result_add_multi_treasure,
[MysteryEventResult.EventResultType.removeEntityById]=MysteryEventResult.result_add_multi_treasure,

[MysteryEventResult.EventResultType.mysteryTrigger]=MysteryEventResult.result_mystery_trigger,
[MysteryEventResult.EventResultType.resPointEvent2]=MysteryEventResult.result_respoint_event2,
[MysteryEventResult.EventResultType.recruitTips]=MysteryEventResult.result_recruitTips,

[MysteryEventResult.EventResultType.createMystery]=MysteryEventResult.result_create_mystery_event,

[MysteryEventResult.EventResultType.enterQiyuMystery]=MysteryEventResult.result_enter_mystery_event,
[MysteryEventResult.EventResultType.sfpyAngry]=MysteryEventResult.result_get_sfpyAngry,
[MysteryEventResult.EventResultType.sfpyRule]=MysteryEventResult.result_get_sfpyrule,
[MysteryEventResult.EventResultType.sfpyAngrynowin]=MysteryEventResult.result_get_sfpyAngrynowin,
[MysteryEventResult.EventResultType.xjresPointEvent]=MysteryEventResult.result_xjrespoint_event,
[MysteryEventResult.EventResultType.xjmjresPointEvent]=MysteryEventResult.result_xjmjrespoint_event,
}


MysteryEventResult.other_main_result=
{
[MysteryEventResult.EventResultType.nextEvent]=MysteryEventResult.result_next_event,
[MysteryEventResult.EventResultType.enterMystery]=MysteryEventResult.result_enter_mystery,
[MysteryEventResult.EventResultType.showPlotBoard]=MysteryEventResult.result_show_plot_board,
[MysteryEventResult.EventResultType.showStoryTree]=MysteryEventResult.result_show_story_tree,
[MysteryEventResult.EventResultType.game]=MysteryEventResult.result_game,
[MysteryEventResult.EventResultType.RecruitSelect]=MysteryEventResult.result_recruitSelect,

}

end

















function MysteryEventResult.result_win(args)

local dealCallBack=function()
MysteryEventModel:clear_event_str_list()
MysteryEventModel:clear_event_dice_str_list()
local childWinList,haveOtherResult=MysteryEventResult.do_result(args)
args.childWinList=childWinList

if haveOtherResult then
if args.confirmCallBack then
args.confirmCallBack()

newbieManager.startNewbie(NEW_BIE_CND_TYPE.eMysteryEvent,args.groupId,args.optionId)
end

local haveshowPlotBoard=false
if type(args.resultCfgList[1])=='table'then
for i,v in ipairs(args.resultCfgList)do
if v[1]==MysteryEventResult.EventResultType.showPlotBoard or v[1]==MysteryEventResult.EventResultType.showStoryTree then
haveshowPlotBoard=true
break
end
end
end

if not haveshowPlotBoard then

local str_list=MysteryEventModel:get_event_dice_str_list()
if next(str_list)then
for i,v in ipairs(str_list)do
if v.uiType==MysteryEventDiceResultAttrType.eDizi then
MysteryEventSystem:flow_text(MysteryEventSystem.flowType.strTips,MysteryEventSystem.flowRoot.center,3,v)
else
MysteryEventSystem:flow_text(MysteryEventSystem.flowType.strTips,MysteryEventSystem.flowRoot.center,2,v)
end
end
MysteryEventModel:clear_event_str_list()
MysteryEventModel:clear_event_dice_str_list()
end
end

else
MysteryEventResult.result_common_result(args)
end

UIManager:invokeUIMethod("UIMysteryEventWin","showChangedEventList",args.optionId,args.resultIndex)




end



local groupCfg=MysteryEventModel.get_group_cfg(args.groupId)
local optionCfg=groupCfg[args.optionId]
local resultTxt=optionCfg[MysteryEventSystem.diceCfg[args.resultIndex].result]


local result=optionCfg[MysteryEventSystem.diceCfg[args.resultIndex].args]
if result and result.image then
local image
if type(result.image)=="table"then
image=result.image[1]
local playerSex=playerModel:getActorSex()
local sexIdx=playerSex==1 and 1 or 2
if result.image[sexIdx]then
image=result.image[sexIdx]
end
else
image=result.image
end

UIManager:invokeUIMethod("UIMysteryEventWin","refreshEventImage",image)
UIManager:invokeUIMethod("UIMysteryEventWin","refreshEventText",resultTxt,0.2)

timeEventController.delayDo(1,dealCallBack)

else
UIManager:invokeUIMethod("UIMysteryEventWin","refreshEventText",resultTxt,0.2)
dealCallBack()
end


end
















function MysteryEventResult:show_event_result_win(isdice,mainArgs,childWinArgs)
if isdice then
local args={mainArgs=mainArgs,childWinArgs=childWinArgs}
UIManager:callWindowFunc("UIMysteryEventDice2Win","refreshResult",args)

else
UIFullMysteryEventControl:showWindow("UIMysteryEventOutResultWin",{mainArgs=mainArgs,childWinArgs=childWinArgs})
end
end



function MysteryEventResult.do_result(args)
local resultCfgList=args.resultCfgList
if type(resultCfgList[1])=='number'then
resultCfgList={resultCfgList}
end

local nIndex=args.nFinishResult or 0

local childWin={}
local haveOtherResult=false
local listChildWin=nil
local listChildArgs=nil
local startCallBack=nil
local endCallBack=nil
local resultFun=nil
local returnList=nil
MysteryEventModel:clear_result_callback(args.guid)
for i,v in pairs(resultCfgList)do
startCallBack=nil
endCallBack=nil
if type(i)=="number"then
resultFun=MysteryEventResult.bindCommonResult[v[1]]
local is_other_main_result=false
if not resultFun then
is_other_main_result=true
resultFun=MysteryEventResult.other_main_result[v[1]]
end
if i>nIndex then
if is_other_main_result then
haveOtherResult=true
end
if resultFun then

returnList=resultFun({resultCfg=v,
groupId=args.groupId,
optionId=args.optionId,
resultIndex=args.resultIndex,
guidList=args.guidList,
sysId=args.sysId,
guid=args.guid,
})



if returnList then
listChildWin=returnList.childWin
listChildArgs=returnList.childWinArgs

startCallBack=returnList.startCallBack
endCallBack=returnList.endCallBack

if listChildWin then
if not childWin[listChildWin]then
childWin[listChildWin]=listChildArgs or{}
else
if listChildArgs then

for k1,argsV1 in pairs(listChildArgs)do
if childWin[listChildWin][k1]then
if type(childWin[listChildWin][k1])=='table'and type(argsV1)=='table'then
for i,tv in ipairs(argsV1)do
table.insert(childWin[listChildWin][k1],tv)
end
end
end
end
end
end
end
end
end
MysteryEventModel:set_result_before_callback(args.guid,{args.sysId,args.groupId,args.optionId,i,startCallBack,args.guid})
if endCallBack then
MysteryEventModel:set_result_callback(args.guid,v[1],endCallBack)
else
MysteryEventModel:set_result_callback(args.guid,v[1],0)
end
end
end
end
local childWinList={}
for win,args in pairs(childWin)do
table.insert(childWinList,{name=win,args=args})
end
return childWinList,haveOtherResult
end



function MysteryEventResult.result_common_result(args)

local mainArgs=
{
groupId=args.groupId,
optionId=args.optionId,
resultIndex=args.resultIndex,
isdice=args.isdice,
confirmCallBack=function()
if args.confirmCallBack then
args.confirmCallBack()

newbieManager.startNewbie(NEW_BIE_CND_TYPE.eMysteryEvent,args.groupId,args.optionId)
end
if not next(args.resultCfgList)then


end
end
}
MysteryEventResult:show_event_result_win(args.isdice,mainArgs,args.childWinList)
end




















function MysteryEventResult.result_get_item(args)
if not args.resultCfg then
return
end

local rewardCfg
local previewValue=MysteryEventModel:get_preview_result_value(args.resultCfg[1])
if previewValue then
rewardCfg=previewValue
else

if type(args.resultCfg[2])=="number"then
rewardCfg=cfgHelper.get2(cfg_awardconfig_get,args.resultCfg[2],"showItems")
else
rewardCfg=args.resultCfg[2]
end
end



local child_win_args=
{
itemList=rewardCfg
}

return{childWin=MysteryEventSystem.ResultPanel.Item,childWinArgs=child_win_args,}
end


function MysteryEventResult.result_get_rule(args)
if not args.resultCfg then
return
end

local child_win_args=
{
ruleList=args.resultCfg[2]
}

return{childWin=MysteryEventSystem.ResultPanel.Rule,childWinArgs=child_win_args,}
end


function MysteryEventResult.result_select_rule(args)
if not args.resultCfg then
return
end
local ruleList=MysteryEventModel:get_preview_result_value(args.resultCfg[1])or{}
local returnList=
{
startCallBack=function(sysId,groupId,optionId,resultIndex)
if next(ruleList)then
local winArgs=
{
enterType=MysteryRuleEnterType.Event,
list=ruleList,
sysId=sysId,
guid=args.guid,
groupId=groupId,
optionId=optionId,
eventResultIndex=resultIndex,
}
UIFullMysteryMainControl:showWindow("UIMysteryRuleSelectWin",winArgs)
else
UIFullMysteryMainControl:closeWindow("UIMysteryEventWin")
end
end
}
return returnList
end


function MysteryEventResult.result_remove_obstacle(args)
if not args.resultCfg then
return
end







local returnList=
{
endCallBack=function()
MysteryEventModel:set_current_result_flag(MysteryEventResult.EventResultType.removeObstacle)
end
}
return returnList
end


function MysteryEventResult.result_add_obstacle(args)
if not args.resultCfg then
return
end
local resultCfg=args.resultCfg[2]
local roomId=mysteryRoomModel:get_cur_roomID()

local returnList=
{
endCallBack=function()
mysteryTriggerManager.triggerMoveCamera(roomId,Vector3(resultCfg[1],resultCfg[2],0),function()

mysteryObstacleController:create_entity({etId=resultCfg[3],x=resultCfg[1],y=resultCfg[2]})
notifySystem:postNotify(notifyConfig.on_mystery_event_result_finish_c,args.guid)
end)
end
}
return returnList
end


function MysteryEventResult.result_add_monster(args)

end


function MysteryEventResult.result_remove_monster(args)

end


function MysteryEventResult.result_next_event(args)
if not args.resultCfg then
return
end
if args.resultCfg.isBreak then
return MysteryEventResult.break_Event(args)
else
local returnList=
{
startCallBack=function(sysId,groupId,optionId,resultIndex)
UIFullMysteryEventControl:closeWindow("UIMysteryEventDice2Win")
local resultCfg=args.resultCfg
local eventList=type(resultCfg[2])=="number"and{resultCfg[2]}or resultCfg[2]
local playerPos=mysteryPlayerModel:get_player_pos()
MysteryEventModel:set_event_flag(playerPos)
if#eventList==1 then
MysteryEventSystem.send_18_8(args.guid,resultIndex,args.sysId,eventList[1])
else
UIFullMysteryEventControl:showWindow("UIMysteryEventSelectWin",{guid=args.guid,sysId=args.sysId,resultIndex=resultIndex,eventList=eventList})
end
end,
endCallBack=function(comfirmData)

if args.sysId==SYSTEM_DEFINE.eMiJing then
local playerPos=mysteryPlayerModel:get_player_pos()
MysteryEventModel:set_event_flag(playerPos)
end
if comfirmData then
MysteryEventListModel:update_event(args.sysId,args.guid,comfirmData[5])
MysteryEventSystem:show_event_win(args.guid,args.sysId,comfirmData[5],args.guidList,nil,nil,true)
end
end,
}
return returnList
end

end

function MysteryEventResult.break_Event(args)
if not args.resultCfg then
return
end

local returnList=
{
startCallBack=function(sysId,groupId,optionId,resultIndex)
UIFullMysteryEventControl:closeWindow("UIMysteryEventDice2Win")
local resultCfg=args.resultCfg
local event=resultCfg[2]

local playerPos=mysteryPlayerModel:get_player_pos()
MysteryEventModel:set_event_flag(playerPos)

MysteryEventSystem.send_18_8(args.guid,resultIndex,args.sysId,event)
end,
endCallBack=function(comfirmData)

if comfirmData then
MysteryEventListModel:update_event(args.sysId,args.guid,comfirmData[5])

UIFullMysteryEventControl:closeUIEX(true,true)
MysteryEventModel:set_event_flag(nil)
notifySystem:postNotify(notifyConfig.on_mystery_event_break,args.sysId,comfirmData[5],args.guid)
end
end,
}
return returnList
end



function MysteryEventResult.result_resurrection(args)
local resultCfg=args.resultCfg

local previewValue=MysteryEventModel:get_preview_result_value(resultCfg[1])
if previewValue then
local disName=UIDiscipleModel:getDiscipleName(previewValue)
if MysteryModel:is_disciple_dead(fightPreSelectModel.teamEntityType.dizi,previewValue)then
MysteryEventModel:add_event_str_data(FMT.fmt("{0} {1}",disName,FMT.cfmt(FONT_COLOR.eGreenColor,"复活了")))
MysteryEventModel:add_event_dice_str_data(MysteryEventDiceResultAttrType.eDizi,FMT.cfmt(FONT_COLOR.eGreenColor,"复活"),previewValue)
else
MysteryEventModel:add_event_str_data(FMT.fmt("{0} {1}",disName,FMT.cfmt(FONT_COLOR.eGreenColor,"恢复50%生命值")))
MysteryEventModel:add_event_dice_str_data(MysteryEventDiceResultAttrType.eDizi,FMT.cfmt(FONT_COLOR.eGreenColor,"+50%生命值"),previewValue)
end
end

return{childWin=MysteryEventSystem.ResultPanel.Attr}
end


function MysteryEventResult.result_add_power(args)
if not args.resultCfg then
return
end
MysteryEventModel:add_event_str_data(FMT.fmt("体力 +{0}",args.resultCfg[2]))
MysteryEventModel:add_event_dice_str_data(MysteryEventDiceResultAttrType.eCommonGreen,FMT.fmt("体力 <color=#549327>+{0}</color>",args.resultCfg[2]))
return{childWin=MysteryEventSystem.ResultPanel.Attr}
end


function MysteryEventResult.result_add_skill_times(args)
if not args.resultCfg then
return
end
local skillCfg=args.resultCfg[2]
local skillname=mysterySkillModel.get_skill_name(skillCfg[1])
local str=FMT.fmt("探索技能-{0}使用次数 <color=#549327>+{1}</color>",skillname,skillCfg[2])
MysteryEventModel:add_event_str_data(str)
MysteryEventModel:add_event_dice_str_data(MysteryEventDiceResultAttrType.eCommonGreen,str)
return{childWin=MysteryEventSystem.ResultPanel.Attr}
end


function MysteryEventResult.result_add_multi_interaction()

end


function MysteryEventResult.result_add_multi_treasure()

end


function MysteryEventResult.result_fighting(args)
if not args.resultCfg then
return
end
local monsterGroupId=args.resultCfg[2]
local monList=cfgHelper.get2(cfg_monstergroup_get,monsterGroupId,"monList")
local tempNPC=args.resultCfg.tempNPC
local discipleSortList=args.resultCfg.discipleSortList
local editorTeam=args.resultCfg.editorTeam
local jumpPrepare=args.resultCfg.jumpPrepare
local dzCountLimit=args.resultCfg.dzCountLimit
local dzCountLeast=args.resultCfg.dzCountLeast
local showAlldisciple=args.resultCfg.showAllDisciple
local mustDiscipleIDs=args.resultCfg.mustDiscipleIDs
local plotDiscipleList=args.resultCfg.plotDiscipleList
local plotGrayDiscipleList=args.resultCfg.plotGrayDiscipleList
local plotNPCDiscipleList=args.resultCfg.plotNPCDiscipleList
local faZeList=args.resultCfg.fazeList
local specialConditions=args.resultCfg.specialConditions
local victoryRounds=args.resultCfg.victoryRounds
local guidList={}
local teamList={}

local forceAutoSelect=args.resultCfg.forceAutoSelect==1

local fightFazeList=args.resultCfg.fightFazeList
if not faZeList and fightFazeList then
faZeList={}
for i,v in ipairs(fightFazeList)do
table.insert(faZeList,v[1])
end
end

local singleFightDescStr=nil
local singleFightDescStr2=nil
if specialConditions then
showAlldisciple=false
local filterCondition={}
local filterSex=0
if specialConditions[1]~=nil then
filterSex=specialConditions[1]
end
if specialConditions[2]and#specialConditions[2]~=0 then
filterCondition[2]=specialConditions[2]
end
if specialConditions[3]then
singleFightDescStr=specialConditions[3]
end
guidList={}
local disciplesList=discipleLookup:getSortDiscipleList(eDiscipleSortType.eFightSort,filterCondition,eSortOrder.eDown)
for i,v in pairs(disciplesList)do
local netdata=v.netData.net
local guid=netdata.discipleguid
local dzSex=UIDiscipleModel:getDiscipleSex(guid)
if filterSex==0 then
table.insert(guidList,guid)
elseif filterSex==4 and dzSex~=1 and dzSex~=2 then
table.insert(guidList,guid)
elseif dzSex==filterSex then
table.insert(guidList,guid)
end
end
elseif args.guidList then
for i,v in pairs(args.guidList)do
if v.unitId~=0 then
if v.blood then
if tonumber(tostring(v.blood))>0 then
table.insert(guidList,v.unitId)
teamList[i]=v.unitId
end
else
table.insert(guidList,v.unitId)
teamList[i]=v.unitId
end

end
end
end

if victoryRounds and victoryRounds[1]then
if singleFightDescStr==nil then
singleFightDescStr=victoryRounds[1]
else
singleFightDescStr2=victoryRounds[1]
end
end
local m_sysId=nil
local m_selectList=nil
local m_nIndex=nil
local m_zf=nil
local returnList=
{
startCallBack=function(sysId,groupId,optionId,resultIndex)
m_sysId=sysId
m_nIndex=resultIndex

local sendData={{0,0,monsterGroupId,int64.zero}}
local mcfg=cfgHelper.get(cfg_monstergroup_get,monsterGroupId)
if sysId==SYSTEM_DEFINE.eMiJing then
local entity=mysteryInteractionModel:get_entity_by_pos(mysteryPlayerModel:get_player_pos(),mysteryRoomModel:get_cur_roomID())
if entity then
sendData={{entity.pos.x,entity.pos.y,monsterGroupId,int64.new(entity.data.guid)}}
end
mysteryFightModel:set_fighting(true)
end

if jumpPrepare then
if m_sysId==SYSTEM_DEFINE.eLiLian then


local task=worldExperienceModel:getTask()
m_selectList=task:getBattleTeam()
m_zf=task.zfId


fightLaunchController:sendFight(eBattleLaunch.qiyuEvent,m_selectList,mcfg.mapId or 0,m_zf or 0,{m_sysId,1,sendData,args.guid,resultIndex,0,{0,0}})
MysteryEventModel:set_current_result_data(MysteryEventResult.EventResultType.fighting,args,resultIndex)

return
elseif m_sysId==SYSTEM_DEFINE.eMiJing then
m_zf=MysteryModel:get_select_zhenFa()
m_selectList=MysteryModel:get_fb_sendTeam()
fightLaunchController:sendFight(eBattleLaunch.qiyuEvent,m_selectList,mcfg.mapId or 0,m_zf or 0,{m_sysId,1,sendData,args.guid,resultIndex,0,{0,0}})

MysteryEventModel:set_current_result_data(MysteryEventResult.EventResultType.fighting,args,resultIndex)
return
end
end
if showAlldisciple then
guidList=nil
end
local winArgs={
skipDiscipleStateCheck=true,
enterTxt="奇遇事件",
lockSelect=guidList,
monsterList=monList,
groupId=monsterGroupId,
sortTypeList=discipleSortList,
editorTeam=editorTeam,
teamList=teamList,
npcList=tempNPC,
dzCountLimit=dzCountLimit,
dzCountLeast=dzCountLeast,
plotDiscipleList=plotDiscipleList,
plotGrayDiscipleList=plotGrayDiscipleList,
plotNPCDiscipleList=plotNPCDiscipleList,
faZeData=faZeList,
singleFightDescStr=singleFightDescStr,
singleFightDescStr2=singleFightDescStr2,
forceAutoSelect=forceAutoSelect,
enterCallBack=function(selectList,zfid)
m_selectList=selectList
m_zf=zfid

if m_sysId==SYSTEM_DEFINE.eLiLian then
if not plotNPCDiscipleList and not plotGrayDiscipleList then
local task=worldExperienceModel:getTask()
if task then
local temp=fightPreSelectModel.convertFightStruct2Disciple(m_selectList)
local check=task:checkTeam(temp)
if check<0 then
UIManager.error("弟子选择有误")
loggerUtil.logErrFMT("大世界区块历练战斗布阵检查出问题：{0}",check)
UIFullFightPrepareControl:closeUI(true,true)
fightController:closeSelectStage()
return
elseif check>0 then
task:changeTeamPos(m_selectList)
task:save()
end
end
end
end

fightLaunchController:sendFight(eBattleLaunch.qiyuEvent,m_selectList,mcfg.mapId or 0,m_zf or 0,{m_sysId,1,sendData,args.guid,resultIndex,0,{0,0}})

MysteryEventModel:set_current_result_data(MysteryEventResult.EventResultType.fighting,args,resultIndex)
end,
cancelCallBack=function()
if MysteryEventSystem.resumeCB and MysteryEventSystem.isNotFullOpen then
MysteryEventSystem.resumeCB()
end
notifySystem:postNotify(notifyConfig.on_mystery_event_break,sysId,groupId,args.guid)
end,
}
if mustDiscipleIDs and#mustDiscipleIDs>0 then
winArgs.mustList={}
winArgs.dzSpeakList={}
for i,v in ipairs(mustDiscipleIDs)do
local list=UIDiscipleModel:findDisciplesByID(v)
local cfg=cfgHelper.get1(cfg_discipleconfig_get,v)
for i,v in ipairs(list)do
table.insert(winArgs.mustList,v.discipleguid)
if cfg.mustFightSpeak then
local r=math.random(1,#cfg.mustFightSpeak)
winArgs.dzSpeakList[tostring(v.discipleguid)]=cfg.mustFightSpeak[r]
end
end
end
end
fightController.showPrepareWin(fightPreSelectModel.fightType.qiyuEvent,winArgs)
end,

endCallBack=function()

end
}
return returnList
end


function MysteryEventResult.result_item_cost(args)
if not args.resultCfg then
return
end
local resultCfg=args.resultCfg[2]

for i,v in ipairs(resultCfg)do
local name=""
if itemsConfig.isMoney(v[1])then
name=moneyModel.getMoneyName(v[1])
else
name=itemsConfig.getItemName(v[1])
end
local str=FMT.fmt("{0} {1}",name,FMT.cfmt(FONT_COLOR.eRedColor,"-{0}",v[2]))
MysteryEventModel:add_event_str_data(str)

MysteryEventModel:add_event_dice_str_data(MysteryEventDiceResultAttrType.eCommonRed,str)
end

return{childWin=MysteryEventSystem.ResultPanel.Attr}
end


function MysteryEventResult.result_disciple_change_injury_state(args)
if not args.resultCfg then
return
end
local resultCfg=args.resultCfg
local injuryType=resultCfg[2]
local selectGuid=MysteryEventModel:get_select_disciple()
if selectGuid then
local name=UIDiscipleModel:getDiscipleName(selectGuid)
MysteryEventModel:add_event_str_data(FMT.fmt("{0} 变为{1}",name,MysteryEventSystem.injuryType[injuryType]))

local str=FMT.fmt("<color=#c82c2c>变为{0}</color>",MysteryEventSystem.injuryType[injuryType])
MysteryEventModel:add_event_dice_str_data(MysteryEventDiceResultAttrType.eDizi,str,selectGuid)
end
return{childWin=MysteryEventSystem.ResultPanel.Attr}
end


function MysteryEventResult.result_disciple_change_injury(args)
if not args.resultCfg then
return
end
local resultCfg=args.resultCfg[2]
local selectGuid=MysteryEventModel:get_select_disciple()
if selectGuid then
local disName=UIDiscipleModel:getDiscipleName(selectGuid)
local channgeInjury=resultCfg[2]
local str=resultCfg[1]==1 and FMT.cfmt(FONT_COLOR.eRedColor,"增加{0}点负伤值",math.abs(channgeInjury))or FMT.cfmt(FONT_COLOR.eGreenColor,"减少{0}点负伤值",math.abs(channgeInjury))
MysteryEventModel:add_event_str_data(FMT.fmt("{0} {1}",disName,str))

if resultCfg[1]==1 then
local str=FMT.fmt("<color=#c82c2c>+{0}点负伤值</color>",math.abs(channgeInjury))
MysteryEventModel:add_event_dice_str_data(MysteryEventDiceResultAttrType.eDizi,str,selectGuid)
else
local str=FMT.fmt("<color=#549327>-{0}点负伤值</color>",math.abs(channgeInjury))
MysteryEventModel:add_event_dice_str_data(MysteryEventDiceResultAttrType.eDizi,str,selectGuid)
end
end
return{childWin=MysteryEventSystem.ResultPanel.Attr}
end


function MysteryEventResult.result_team_change_injury_state(args)
if not args.resultCfg then
return
end
local injuryType=args.resultCfg[2]
local team=args.guidList or MysteryModel:get_fb_probeTeam()
for i,v in ipairs(team)do
if v.unitType==fightPreSelectModel.teamEntityType.dizi then
local name=UIDiscipleModel:getDiscipleName(v.unitId)
MysteryEventModel:add_event_str_data(FMT.fmt("{0} 变为{1}",name,MysteryEventSystem.injuryType[injuryType]))

local str=FMT.fmt("<color=#c82c2c>变为{0}</color>",MysteryEventSystem.injuryType[injuryType])
MysteryEventModel:add_event_dice_str_data(MysteryEventDiceResultAttrType.eDizi,str,v.unitId)
end
end
return{childWin=MysteryEventSystem.ResultPanel.Attr}
end


function MysteryEventResult.result_team_change_injury(args)
if not args.resultCfg then
return
end
local injury=args.resultCfg[2]
local team=args.guidList or MysteryModel:get_fb_probeTeam()
for i,v in ipairs(team)do
if v.unitType==fightPreSelectModel.teamEntityType.dizi then
local name=UIDiscipleModel:getDiscipleName(v.unitId)
local channgeInjury=injury[2]
local str=injury[1]==1 and FMT.cfmt(FONT_COLOR.eRedColor,"增加{0}点负伤值",math.abs(channgeInjury))or FMT.cfmt(FONT_COLOR.eGreenColor,"减少{0}点负伤值",math.abs(channgeInjury))
MysteryEventModel:add_event_str_data(FMT.fmt("{0} {1}",name,str))


if injury[1]==1 then
local str=FMT.fmt("<color=#c82c2c>+{0}点负伤值</color>",math.abs(channgeInjury))
MysteryEventModel:add_event_dice_str_data(MysteryEventDiceResultAttrType.eDizi,str,v.unitId)
else
local str=FMT.fmt("<color=#549327>-{0}点负伤值</color>",math.abs(channgeInjury))
MysteryEventModel:add_event_dice_str_data(MysteryEventDiceResultAttrType.eDizi,str,v.unitId)
end
end
end
return{childWin=MysteryEventSystem.ResultPanel.Attr}
end


function MysteryEventResult.result_disciple_add_hp(args)
if not args.resultCfg then
return
end
local bloodType=args.resultCfg[2]
local changeBlood=0
local previewValue=MysteryEventModel:get_preview_result_value(args.resultCfg[1])

if bloodType==1 then
previewValue=tonumber(tostring(previewValue))
changeBlood=previewValue
elseif bloodType==2 then
previewValue=tonumber(tostring(previewValue))
changeBlood=previewValue
elseif bloodType==3 then
changeBlood=math.abs(args.resultCfg[3])
if args.resultCfg[3]>0 then
bloodType=1
else
bloodType=2
end
end
local selectGuid=MysteryEventModel:get_select_disciple()
if selectGuid then
local disName=UIDiscipleModel:getDiscipleName(selectGuid)
local str=bloodType==1 and FMT.cfmt(FONT_COLOR.eGreenColor,"+{0}%",changeBlood*100)or FMT.cfmt(FONT_COLOR.eRedColor,"-{0}%",changeBlood*100)
MysteryEventModel:add_event_str_data(FMT.fmt("{0} 生命值{1}",disName,str))

if bloodType==1 then
local str=FMT.fmt("<color=#549327>+{0}%生命值</color>",changeBlood*100)
MysteryEventModel:add_event_dice_str_data(MysteryEventDiceResultAttrType.eDizi,str,selectGuid)
else
local str=FMT.fmt("<color=#c82c2c>-{0}%生命值</color>",changeBlood*100)
MysteryEventModel:add_event_dice_str_data(MysteryEventDiceResultAttrType.eDizi,str,selectGuid)
end
end
return{childWin=MysteryEventSystem.ResultPanel.Attr}
end


function MysteryEventResult.result_team_add_hp(args)
if not args.resultCfg then
return
end
local bloodType=args.resultCfg[2]
local changeBlood=0
local previewValue=MysteryEventModel:get_preview_result_value(args.resultCfg[1])

if bloodType==1 then
previewValue=tonumber(tostring(previewValue))
changeBlood=previewValue
elseif bloodType==2 then
previewValue=tonumber(tostring(previewValue))
changeBlood=previewValue
elseif bloodType==3 then
changeBlood=math.abs(args.resultCfg[3])
if args.resultCfg[3]>0 then
bloodType=1
else
bloodType=2
end
end

local team=args.guidList or MysteryModel:get_fb_probeTeam()
for i,v in ipairs(team)do
local name
if v.unitType==fightPreSelectModel.teamEntityType.dizi then
name=UIDiscipleModel:getDiscipleName(v.unitId)
elseif v.unitType==fightPreSelectModel.teamEntityType.npc then
name=fightPreSelectModel.getNPCConfig(v.unitId).name
end
if v.blood then
if tonumber(tostring(v.blood))>0 then
local str=bloodType==1 and FMT.cfmt(FONT_COLOR.eGreenColor,"+{0}%",changeBlood*100)or FMT.cfmt(FONT_COLOR.eRedColor,"-{0}%",changeBlood*100)
MysteryEventModel:add_event_str_data(FMT.fmt("{0} 生命值{1}",name,str))

if bloodType==1 then
local str=FMT.fmt("<color=#549327>+{0}%生命值</color>",changeBlood*100)
MysteryEventModel:add_event_dice_str_data(MysteryEventDiceResultAttrType.eDizi,str,v.unitId)
else
local str=FMT.fmt("<color=#c82c2c>-{0}%生命值</color>",changeBlood*100)
MysteryEventModel:add_event_dice_str_data(MysteryEventDiceResultAttrType.eDizi,str,v.unitId)
end
end
else
local str=bloodType==1 and FMT.cfmt(FONT_COLOR.eGreenColor,"+{0}%",changeBlood*100)or FMT.cfmt(FONT_COLOR.eRedColor,"-{0}%",changeBlood*100)
MysteryEventModel:add_event_str_data(FMT.fmt("{0} 生命值{1}",name,str))

if bloodType==1 then
local str=FMT.fmt("<color=#549327>+{0}%生命值</color>",changeBlood*100)
MysteryEventModel:add_event_dice_str_data(MysteryEventDiceResultAttrType.eDizi,str,v.unitId)
else
local str=FMT.fmt("<color=#c82c2c>-{0}%生命值</color>",changeBlood*100)
MysteryEventModel:add_event_dice_str_data(MysteryEventDiceResultAttrType.eDizi,str,v.unitId)
end
end
end
return{childWin=MysteryEventSystem.ResultPanel.Attr}
end


function MysteryEventResult.result_disciple_change_speciality(args)
if not args.resultCfg then
return
end
local resultCfg=args.resultCfg

local previewValue=MysteryEventModel:get_preview_result_value(resultCfg[1])



if previewValue then
local sType=resultCfg[3]
local configSId=resultCfg[4]
if next(previewValue)then
for i,v in ipairs(previewValue)do
local selectGuid=v[1]
local sId=v[2]or configSId
local netData=UIDiscipleModel:getDiscipleData(selectGuid)
local disName=UIDiscipleModel:getDiscipleNameByData(netData)
local changeType=resultCfg[2]==1 and"获得"or"遗忘"
if resultCfg[2]==1 and sType==DISCIPLE_SPECIALITY_TYPE.eStrange then
changeType="染上了"
end

local effectlist=dzSpecialityEffectHelper.getEffectSpeList(netData,3,nil,'special_effects')
if next(effectlist)and resultCfg[2]==1 and resultCfg[3]==DISCIPLE_SPECIALITY_TYPE.eStrange then
local effect=effectlist[1]
local cfg=UIDiscipleModel:getSpecialityConfig(effect[1],effect[2].param_1)
MysteryEventModel:add_event_str_data(FMT.fmt("{0}因特质<{1}>而无法获得怪癖",disName,cfg.name))
else
local sname=UIDiscipleModel:getSpecialityTypeName(sType)
local cfg=UIDiscipleModel:getSpecialityConfig(sType,tonumber(sId))

MysteryEventModel:add_event_str_data(FMT.fmt("{0} {1}{2} {3}",disName,changeType,sname,FMT.cfmt(FONT_COLOR.eRedColor,"{0}",cfg.name)))

if resultCfg[2]==1 then
if sType==DISCIPLE_SPECIALITY_TYPE.eStrange then
local str=FMT.fmt("<color=#c82c2c>{0}{1} {2}</color>",changeType,sname,cfg.name)
MysteryEventModel:add_event_dice_str_data(MysteryEventDiceResultAttrType.eDizi,str,selectGuid)
else
local str=FMT.fmt("<color=#549327>{0}{1} {2}</color>",changeType,sname,cfg.name)
MysteryEventModel:add_event_dice_str_data(MysteryEventDiceResultAttrType.eDizi,str,selectGuid)
end
else
local str=FMT.fmt("<color=#c82c2c>{0}{1} {2}</color>",changeType,sname,cfg.name)
MysteryEventModel:add_event_dice_str_data(MysteryEventDiceResultAttrType.eDizi,str,selectGuid)
end
end

end
else
local sname=UIDiscipleModel:getSpecialityTypeName(sType)
if resultCfg[2]==1 then
MysteryEventModel:add_event_str_data(FMT.fmt("弟子{0}数量已达到上限，没发生任何变化",sname))
else
MysteryEventModel:add_event_str_data(FMT.fmt("弟子身上无{0}，没发生任何变化",sname))
end
end

else
if resultCfg[4]then
local selectGuid=MysteryEventModel:get_select_disciple()
if selectGuid then
local netData=UIDiscipleModel:getDiscipleData(selectGuid)
local disName=UIDiscipleModel:getDiscipleNameByData(netData)
local changeType=resultCfg[2]==1 and"获得"or"遗忘"
if resultCfg[2]==1 and resultCfg[3]==DISCIPLE_SPECIALITY_TYPE.eStrange then
changeType="染上了"
end

local effectlist=dzSpecialityEffectHelper.getEffectSpeList(netData,3,nil,'special_effects')
if next(effectlist)and resultCfg[2]==1 and resultCfg[3]==DISCIPLE_SPECIALITY_TYPE.eStrange then
local effect=effectlist[1]
local cfg=UIDiscipleModel:getSpecialityConfig(effect[1],effect[2].param_1)
MysteryEventModel:add_event_str_data(FMT.fmt("{0}因特质<{1}>而无法获得怪癖",disName,cfg.name))
else
local sname=UIDiscipleModel:getSpecialityTypeName(resultCfg[3])
local cfg=UIDiscipleModel:getSpecialityConfig(resultCfg[3],resultCfg[4])
MysteryEventModel:add_event_str_data(FMT.fmt("{0} {1}{2} {3}",disName,changeType,sname,FMT.cfmt(FONT_COLOR.eRedColor,"{0}",cfg.name)))

if resultCfg[2]==1 then
if resultCfg[3]==DISCIPLE_SPECIALITY_TYPE.eStrange then
local str=FMT.fmt("<color=#c82c2c>{0}{1} {2}</color>",changeType,sname,cfg.name)
MysteryEventModel:add_event_dice_str_data(MysteryEventDiceResultAttrType.eDizi,str,selectGuid)
else
local str=FMT.fmt("<color=#549327>{0}{1} {2}</color>",changeType,sname,cfg.name)
MysteryEventModel:add_event_dice_str_data(MysteryEventDiceResultAttrType.eDizi,str,selectGuid)
end
else
local str=FMT.fmt("<color=#c82c2c>{0}{1} {2}</color>",changeType,sname,cfg.name)
MysteryEventModel:add_event_dice_str_data(MysteryEventDiceResultAttrType.eDizi,str,selectGuid)
end
end

end
else
local sname=UIDiscipleModel:getSpecialityTypeName(resultCfg[3])
if resultCfg[2]==1 then
MysteryEventModel:add_event_str_data(FMT.fmt("弟子{0}数量已达到上限，没发生任何变化",sname))
else
MysteryEventModel:add_event_str_data(FMT.fmt("弟子身上无{0}，没发生任何变化",sname))
end
end

end

return{childWin=MysteryEventSystem.ResultPanel.Attr}
end


function MysteryEventResult:add_disciple_exp(guid,resultCfg,addVal)
addVal=addVal or 0
local type=resultCfg[2]
local disName=UIDiscipleModel:getDiscipleName(guid)
local changeStr=addVal>=0 and"增加"or"减少"
local color=addVal>=0 and FONT_COLOR.eGreenColor or FONT_COLOR.eRedColor
local diciColor=addVal>=0 and"#549327"or"#c82c2c"
if type==1 then
local baseGrow=cfgHelper.getglobal1('jingjieincr')
local ex_grow=UIDiscipleModel:getJJAutoGrowRate(guid)
local absorb=fabaoModel.getAbsorbExpRate(guid)
local grow=baseGrow*(1+ex_grow)*(1-absorb)
local addStr=0
if addVal>=0 then
local growAdd=math.floor(addVal*grow)-addVal
addStr=growAdd
end
local str=FMT.fmt("{0} 修为经验<color={1}>{2}{3}</color>",disName,FONT_COLOR_VAL[color],changeStr,mathHelper.formatNumber2(addVal+addStr))
MysteryEventModel:add_event_str_data(str)
MysteryEventModel:add_event_dice_str_data(MysteryEventDiceResultAttrType.eDizi,FMT.fmt("<color={0}>修为经验{1}{2}{3}</color>",diciColor,changeStr,mathHelper.formatNumber(addVal+addStr),addStr),guid)
elseif type==2 then
local addStr=0
if addVal>=0 then
local addexp=UIDiscipleModel:calculationLTGrow(guid,addVal)-addVal
addStr=addexp
end
MysteryEventModel:add_event_str_data(FMT.fmt("{0} 炼体经验<color={1}>{2}{3}</color>",disName,FONT_COLOR_VAL[color],changeStr,mathHelper.formatNumber2(addVal+addStr)))
MysteryEventModel:add_event_dice_str_data(MysteryEventDiceResultAttrType.eDizi,FMT.fmt("<color={0}>炼体经验{1}{2}</color>",diciColor,changeStr,mathHelper.formatNumber2(addVal+addStr)),guid)
elseif type==3 then
local skillCfg=resultCfg[4]
for _,skillId in pairs(skillCfg)do
local name=cfgHelper.get2(cfg_discipleproskillconfig_get,skillId,'name')

local addRate=UIDiscipleModel:getDiscipleProskillRate(guid,skillId)
local upAddVal=math.floor(addVal*(addRate/100))
local addStr=""
if addVal>=0 then
if upAddVal>0 then


end
end
MysteryEventModel:add_event_str_data(FMT.fmt("{0} {1}经验<color={2}>{3}{4}{5}</color>",disName,name,FONT_COLOR_VAL[color],changeStr,mathHelper.formatNumber2(addVal),addStr))
MysteryEventModel:add_event_dice_str_data(MysteryEventDiceResultAttrType.eDizi,FMT.fmt("<color={0}>{1}经验{2}{3}{4}</color>",diciColor,name,changeStr,mathHelper.formatNumber2(addVal),addStr),guid)
end

elseif type==4 then
MysteryEventModel:add_event_str_data(FMT.fmt("{0} 功法经验<color={1}>{2}{3}</color>",disName,FONT_COLOR_VAL[color],changeStr,mathHelper.formatNumber2(addVal)))
MysteryEventModel:add_event_dice_str_data(MysteryEventDiceResultAttrType.eDizi,FMT.fmt("<color={0}>功法经验{1}{2}</color>",diciColor,changeStr,mathHelper.formatNumber2(addVal)),guid)
end
end


function MysteryEventResult.result_disciple_add_exp(args)
if not args.resultCfg then
return
end
local resultCfg=args.resultCfg
local selectGuid=MysteryEventModel:get_select_disciple()
local previewValue=MysteryEventModel:get_preview_result_value(resultCfg[1])
previewValue=tonumber(tostring(previewValue))
if selectGuid then
MysteryEventResult:add_disciple_exp(selectGuid,resultCfg,previewValue)
end
return{childWin=MysteryEventSystem.ResultPanel.Attr}
end


function MysteryEventResult.result_team_add_exp(args)
if not args.resultCfg then
return
end
local resultCfg=args.resultCfg
local team=args.guidList or MysteryModel:get_fb_probeTeam()
local previewValue=MysteryEventModel:get_preview_result_value(resultCfg[1])
previewValue=tonumber(tostring(previewValue))
for i,v in ipairs(team)do
if v.unitType==fightPreSelectModel.teamEntityType.dizi then
MysteryEventResult:add_disciple_exp(v.unitId,resultCfg,previewValue)
end
end
return{childWin=MysteryEventSystem.ResultPanel.Attr}
end


function MysteryEventResult:add_disciple_attr(guid,resultCfg,addVal)
local _type=resultCfg[2]
local disName=UIDiscipleModel:getDiscipleName(guid)
local attrName=eSpecialAttrName:getName(_type)
local isPercent=eSpecialAttrName:isPercent(_type)or false
local color=addVal>=0 and FONT_COLOR.eGreenColor or FONT_COLOR.eRedColor
if _type==11 then
color=addVal>=0 and FONT_COLOR.eRedColor or FONT_COLOR.eGreenColor
end
local str=addVal>=0 and FMT.cfmt(color,"+{0}{1}",addVal,isPercent and"%"or"")or FMT.cfmt(color,"{0}{1}",addVal,isPercent and"%"or"")
MysteryEventModel:add_event_str_data(FMT.fmt("{0}{1} {2}",disName,attrName,str))
if addVal>=0 then
local str=FMT.fmt("<color=#549327>{0}+{1}{2}</color>",attrName,addVal,isPercent and"%"or"")
MysteryEventModel:add_event_dice_str_data(MysteryEventDiceResultAttrType.eDizi,str,guid)
else
local str=FMT.fmt("<color=#c82c2c>{0}{1}{2}</color>",attrName,addVal,isPercent and"%"or"")
MysteryEventModel:add_event_dice_str_data(MysteryEventDiceResultAttrType.eDizi,str,guid)
end
return{childWin=MysteryEventSystem.ResultPanel.Attr}
end


function MysteryEventResult.result_team_add_attr(args)
if not args.resultCfg then
return
end
local resultCfg=args.resultCfg
local team=args.guidList or MysteryModel:get_fb_probeTeam()
local previewValue=MysteryEventModel:get_preview_result_value(resultCfg[1])
previewValue=tonumber(tostring(previewValue))
for i,v in ipairs(team)do
if v.unitType==fightPreSelectModel.teamEntityType.dizi then
MysteryEventResult:add_disciple_attr(v.unitId,resultCfg,previewValue)
end
end
return{childWin=MysteryEventSystem.ResultPanel.Attr}
end


function MysteryEventResult.result_disciple_add_attr(args)
if not args.resultCfg then
return
end
local resultCfg=args.resultCfg
local selectGuid=MysteryEventModel:get_select_disciple()
local previewValue=MysteryEventModel:get_preview_result_value(resultCfg[1])
previewValue=tonumber(tostring(previewValue))
if selectGuid then
MysteryEventResult:add_disciple_attr(selectGuid,resultCfg,previewValue)
end
return{childWin=MysteryEventSystem.ResultPanel.Attr}
end


function MysteryEventResult.result_change_shane_value(args)
if not args.resultCfg then
return
end
local resultCfg=args.resultCfg
local previewValue=resultCfg[2]
return{childWin=MysteryEventSystem.ResultPanel.Shane,childWinArgs={previewValue=previewValue},}
end


function MysteryEventResult.result_change_zongmen_exp(args)
if not args.resultCfg then
return
end
local previewValue=args.resultCfg[2]
local str=previewValue>=0 and FMT.cfmt(FONT_COLOR.eGreenColor,"+{0}",previewValue)or FMT.cfmt(FONT_COLOR.eRedColor,"-{0}",previewValue)
MysteryEventModel:add_event_str_data(FMT.fmt("宗门声望 {0}",str))
if previewValue>=0 then
MysteryEventModel:add_event_dice_str_data(MysteryEventDiceResultAttrType.eCommonGreen,FMT.fmt("宗门声望 +{0}",previewValue))
else
MysteryEventModel:add_event_dice_str_data(MysteryEventDiceResultAttrType.eCommonRed,FMT.fmt("宗门声望 -{0}",previewValue))
end

return{childWin=MysteryEventSystem.ResultPanel.Attr}
end


function MysteryEventResult.result_create_portal(args)
if not args.resultCfg then
return
end
local returnList=
{
endCallBack=function()
local playerPos=mysteryPlayerModel:get_player_pos()
notifySystem:postNotify(notifyConfig.on_mystery_event_result_finish_c,args.guid)
end
}
return returnList
end


function MysteryEventResult.result_change_monster_level(args)
local previewValue=args.resultCfg[2]
local str=previewValue>=0 and FMT.cfmt(FONT_COLOR.eGreenColor,"+{0}",previewValue)or FMT.cfmt(FONT_COLOR.eRedColor,"-{0}",previewValue)
MysteryEventModel:add_event_str_data(FMT.fmt("怪物等级 {0}",str))
if previewValue>=0 then
MysteryEventModel:add_event_dice_str_data(MysteryEventDiceResultAttrType.eCommonRed,FMT.fmt("怪物等级 +{0}",previewValue))
else
MysteryEventModel:add_event_dice_str_data(MysteryEventDiceResultAttrType.eCommonGreen,FMT.fmt("怪物等级 -{0}",previewValue))
end
return{childWin=MysteryEventSystem.ResultPanel.Attr}
end


function MysteryEventResult.result_shop(args)
local returnList=
{
endCallBack=function()
local shopId=args.resultCfg[2]
local playerPos=mysteryPlayerModel:get_player_pos()
mysteryEntityController:createEntity(eMysteryEntityType.eShop,{etId=shopId,x=playerPos.x,y=playerPos.y,roomId=mysteryRoomModel:get_cur_roomID()})
notifySystem:postNotify(notifyConfig.on_mystery_event_result_finish_c,args.guid)
end
}
return returnList
end


function MysteryEventResult.result_game(args)
if not args.resultCfg then
return
end

local resultCfg=args.resultCfg

local gameType=resultCfg[2]

local mapId=resultCfg[3]

local success=resultCfg[4]or 0
local fail=resultCfg[5]or 0
local isShowCloseBtn=resultCfg[6]or 0


local endGameCB=function(winState,exatra)
if reconnectState:isReconnectLeaveState()then return end
MysteryEventSystem.send_18_11(args.guid,winState==1,args.sysId)
if gameType==9 then
if winState~=1 then

local winArgs={
extraWin="UIDrawFuResult_game",
extraParams={
grade=exatra,
},
isHideFightBtn=true,
callback=function()
UIManager:closeWindow("UICommonLoseWin")
end,
}
UIManager:showWindow("UICommonLoseWin",winArgs)
elseif winState==1 then

local winArgs={
extraWin="UIDrawFuResult_game",
extraParams={
grade=exatra,
},
isHideFightBtn=true,
callback=function()
UIManager:closeWindow("UICommonVictoryWin")
MysteryEventSystem.send_18_8(args.guid,args.resultIndex,args.sysId,winState==1 and success or fail)
end,
}
UIManager:showWindow("UICommonVictoryWin",winArgs)
end
else
MysteryEventSystem.send_18_8(args.guid,args.resultIndex,args.sysId,winState==1 and success or fail)
end
end

local startGameCB=function()
MysteryEventSystem.send_18_10(args.guid,args.sysId)
end


local returnList=
{
startCallBack=function(sysId,groupId,optionId,nIndex)
UIFullMysteryEventControl:closeUIEX()
UILittleGameController:openLittleGame(gameType,{guid=args.guid,gameType=1,mapId=mapId,isShowCloseBtn=isShowCloseBtn},endGameCB,startGameCB)
end,


endCallBack=function(endArgs)
local nextEventGroupId=endArgs[5]

if nextEventGroupId and nextEventGroupId~=0 then
local team_data=MysteryEventModel:get_team_data()
MysteryEventListModel:update_event(args.sysId,args.guid,nextEventGroupId)
MysteryEventSystem:show_event_win(args.guid,args.sysId,nextEventGroupId,team_data,nil,nil,true)
else
local result_group=MysteryEventModel:get_result_select()
if result_group then

MysteryEventModel:set_result_select()
notifySystem:postNotify(notifyConfig.on_mystery_event_finish,unpack(result_group))
end
end
end
}
return returnList
end


function MysteryEventResult.result_zongmen_event(args)

end

function MysteryEventResult.result_respoint_event(args)













if not args.resultCfg then
return
end
local resultCfg=args.resultCfg
local showText=resultCfg[4]
if showText then
MysteryEventModel:add_event_str_data(showText)
MysteryEventModel:add_event_dice_str_data(MysteryEventDiceResultAttrType.eCommonGreen,showText)
end
return{childWin=MysteryEventSystem.ResultPanel.Attr,}
end

function MysteryEventResult.result_respoint_event2(args)
if not args.resultCfg then
return
end
local resultCfg=args.resultCfg
local showText=resultCfg[6]
if showText then
MysteryEventModel:add_event_str_data(showText)
MysteryEventModel:add_event_dice_str_data(MysteryEventDiceResultAttrType.eCommonGreen,showText)
end
return{childWin=MysteryEventSystem.ResultPanel.Attr,}
end


function MysteryEventResult.result_enter_mystery(args)
if not args.resultCfg then
return
end
local fbId=args.resultCfg[2]
local worldGroup=args.resultCfg[3]
local mysteryCfg=cfgHelper.get1(cfg_secretscenefubenconfig_get,fbId)
local tempNPC=mysteryCfg.tmpNPC

local guidList={}
local teamList={}
for i,v in pairs(args.guidList)do
guidList[i]={v.unitType,v.unitId}
end



if tempNPC then
for i,v in ipairs(tempNPC)do
guidList[v[2]]={fightPreSelectModel.teamEntityType.npc,int64.new(v[1])}
end
end

for i=1,5 do
if guidList[i]then
table.insert(teamList,i,guidList[i])
else
table.insert(teamList,i,{0,int64.zero})
end
end


local returnList=
{
startCallBack=function(sysId,groupId,optionId,nIndex)
local targetKey=worldModel:convertUnitKey({eWorldUnitTpye.EXPERIENCE,worldGroup})
local taskKey=worldTaskModel:findTaskKey_ByTarget(targetKey)
local task=taskKey and worldTaskModel:getTask(taskKey)or nil
local zfId=task and task.zfId or 0
local ret,errType=downAssetManager:needDownLoadMiJing(fbId)
if ret then return end
local precent=MysteryModel:getPercentListData(fbId)
if precent>=100 then
MysteryController.send_4_5(fbId)
MysteryEventSystem.send_18_8(args.guid,args.resultIndex,sysId)
else
UIFullMysteryEventControl:closeUIEX(false)
MysteryController.select_dizi_and_skill(fbId,teamList,
function(fbid,finishType)
MysteryEventModel:set_result_select(sysId,args.guid,groupId,optionId,args.resultIndex)
worldController:resumeCameraControl()
worldController:showCamera(true)
if finishType==eMysteryQuitType.eFinish then
MysteryEventSystem.send_18_8(args.guid,args.resultIndex,sysId)
else
if finishType==eMysteryQuitType.eFail then
MysteryController.send_4_4(fbid)
elseif finishType==eMysteryQuitType.eBreak then
baseFullScreenUI:openMain(true)
end
notifySystem:postNotify(notifyConfig.on_mystery_event_break,sysId,groupId,args.guid)

end
end,zfId)
end
end,
}
return returnList
end


function MysteryEventResult.result_more_disciple_change_blood(args)
if not args.resultCfg then
return
end

local changeBlood=args.resultCfg[3]
local previewValue=MysteryEventModel:get_preview_result_value(args.resultCfg[1])

if previewValue then
local team=previewValue
for i,v in ipairs(team)do
local guid=v
local name=UIDiscipleModel:getDiscipleName(guid)or""

local str=FMT.cfmt(FONT_COLOR.eRedColor,"-{0}%",changeBlood)
MysteryEventModel:add_event_str_data(FMT.fmt("{0} 生命值{1}",name,str))

local str=FMT.fmt("<color=#c82c2c>-{0}%生命值</color>",changeBlood)
MysteryEventModel:add_event_dice_str_data(MysteryEventDiceResultAttrType.eDizi,str,guid)
end
end

return{childWin=MysteryEventSystem.ResultPanel.Attr}
end


function MysteryEventResult.result_more_disciple_change_injury(args)
if not args.resultCfg then
return
end

local changeBlood=args.resultCfg[3]
local previewValue=MysteryEventModel:get_preview_result_value(args.resultCfg[1])

if previewValue then
local team=previewValue
for i,v in ipairs(team)do
local guid=v
local name=UIDiscipleModel:getDiscipleName(guid)or""
local str=changeBlood>0 and FMT.cfmt(FONT_COLOR.eRedColor,"增加{0}点负伤值",changeBlood)or FMT.cfmt(FONT_COLOR.eGreenColor,"减少{0}点负伤值",math.abs(changeBlood))
MysteryEventModel:add_event_str_data(FMT.fmt("{0} {1}",name,str))

if changeBlood>0 then
local str=FMT.fmt("<color=#c82c2c>+{0}点负伤值</color>",math.abs(changeBlood))
MysteryEventModel:add_event_dice_str_data(MysteryEventDiceResultAttrType.eDizi,str,guid)
else
local str=FMT.fmt("<color=#549327>-{0}点负伤值</color>",math.abs(changeBlood))
MysteryEventModel:add_event_dice_str_data(MysteryEventDiceResultAttrType.eDizi,str,guid)
end
end
end

return{childWin=MysteryEventSystem.ResultPanel.Attr}
end


function MysteryEventResult.result_show_plot_board(args)
if not args.resultCfg then
return
end
local returnList=
{
startCallBack=function(sysId,groupId,optionId,resultIndex)
local args={
groupid=args.resultCfg[2],
callback=function()
MysteryEventSystem.send_18_8(args.guid,resultIndex,sysId)
if args.resultCfg[3]~=1 then
MysteryEventSystem:show_event_win(args.guid,sysId,groupId,args.guidList,{optionId,args.resultIndex,resultIndex},nil,true)
end
end,
isFullOpen=args.resultCfg[3]~=1,
}
gameplotController:showPlotBoard(args)
end,
endCallBack=function(endArgs)

local nextEventGroupId=endArgs[5]
if nextEventGroupId and nextEventGroupId~=0 then
local team_data=MysteryEventModel:get_team_data()
MysteryEventListModel:update_event(args.sysId,args.guid,nextEventGroupId)
MysteryEventSystem:show_event_win(args.guid,args.sysId,nextEventGroupId,team_data,nil,nil,true)
else
local size=MysteryEventModel:get_result_callback_count(args.guid)
local result_group=MysteryEventModel:get_result_select()
if result_group then
if size==0 then

MysteryEventModel:set_result_select()
notifySystem:postNotify(notifyConfig.on_mystery_event_finish,unpack(result_group))
if args.resultCfg[3]==1 then
UIFullMysteryEventControl:closeUIEX()
end
else
MysteryEventSystem.do_result_before_callback(args.guid)
end
end
end
end
}

return returnList
end

function MysteryEventResult.result_mystery_trigger(args)
local returnList={}
return returnList
end


function MysteryEventResult.result_show_story_tree(args)
if not args.resultCfg then
return
end
local returnList=
{
startCallBack=function(sysId,groupId,optionId,resultIndex)
local cb=function()
if args.resultCfg[3]~=1 then
MysteryEventSystem:show_event_win(args.guid,sysId,groupId,args.guidList,{optionId,args.resultIndex,resultIndex},nil,true)
end
MysteryEventSystem.send_18_8(args.guid,resultIndex,sysId)
end
if args.resultCfg.Click then
UIFullMysteryEventControl:showWindow("UIMysteryEventMaskWin",{closeCallback=function()
worldStoryController:showStoryTree(args.resultCfg[2],cb)
end})
else
worldStoryController:showStoryTree(args.resultCfg[2],cb)
end


end,

}
return returnList
end


function MysteryEventResult.result_recruitSelect(args)
if not args.resultCfg then
return
end
local previewValue=MysteryEventModel:get_preview_result_value(args.resultCfg[1])

local returnList=
{
startCallBack=function(sysId,groupId,optionId,resultIndex)
local callback=function(npcId)
MysteryEventSystem.send_18_8(args.guid,resultIndex,sysId,npcId)
MysteryEventSystem:show_event_win(args.guid,sysId,groupId,args.guidList,{optionId,args.resultIndex,resultIndex},nil,true)
end
UIFullMysteryEventControl:closeUIEX()
UIManager:showWindow("UILinShiNPCNewWin",{npcList=previewValue,callback=callback})
end,
}
return returnList

end

function MysteryEventResult.result_recruitTips(args)
if not args.resultCfg then
return
end
local returnList=
{
startCallBack=function(sysId,groupId,optionId,resultIndex)
if args.resultCfg[3]==8 then
local name=cfgHelper.get(cfg_discipleconfig_get,args.resultCfg[2],"name")
if args.resultCfg[4]then
UIManager.info(FMT.fmt(args.resultCfg[4],name))
else
UIManager.info(FMT.fmt("{0}加入宗门",name))
end
end

MysteryEventSystem.send_18_8(args.guid,resultIndex,sysId)
end,

}
return returnList
end


function MysteryEventResult.result_create_mystery_event(args)
if not args.resultCfg then
return
end
local resultCfg=args.resultCfg
local showText=resultCfg[3]
if showText then
MysteryEventModel:add_event_str_data(showText)
MysteryEventModel:add_event_dice_str_data(MysteryEventDiceResultAttrType.eCommonGreen,showText)
end
return{childWin=MysteryEventSystem.ResultPanel.Attr,}
end



function MysteryEventResult.result_enter_mystery_event(args)











if not args.resultCfg then
return
end
local fbId=args.resultCfg[2]



local returnList=
{
startCallBack=function(sysId,groupId,optionId,nIndex)

local ret,errType=downAssetManager:needDownLoadMiJing(fbId)
if ret then return end
local precent=MysteryModel:getPercentListData(fbId)
if precent>=100 then
MysteryController.send_4_5(fbId)
MysteryEventSystem.send_18_8(args.guid,args.resultIndex,sysId)
else
local finishCall=function(fbid,finishType)
baseFullScreenUI:openMain(true)
MysteryEventModel:set_result_select(sysId,args.guid,groupId,optionId,args.resultIndex)
worldController:resumeCameraControl()
worldController:showCamera(true)
if finishType==eMysteryQuitType.eFinish then
MysteryModel:setPercentListData(fbId,nil)
MysteryEventSystem.send_18_8(args.guid,args.resultIndex,sysId)
else
if finishType==eMysteryQuitType.eFail then
MysteryController.send_4_4(fbid)
end
notifySystem:postNotify(notifyConfig.on_mystery_event_break,sysId,groupId,args.guid)
end
end

local func=function(mysteryArgs)
local probeStatus=mysteryArgs[9]
if probeStatus==2 then
MysteryEventSystem.send_18_8(args.guid,args.resultIndex,sysId)
else
local tzStatus=mysteryArgs[18]
if tzStatus==1 then


MysteryModel:set_fb_exit(finishCall)
MysteryController.send_4_1(fbId)
else
local cfg_fb=cfg_secretscenefubenconfig_get(fbId)
local jj=MysteryModel:get_mysteryFB_ndLevel(fbId)or 1
local winArgs=
{
enterCallBack=function(guidList,zhenfaId)

MysteryController.select_dizi_and_skill(fbId,guidList,finishCall,zhenfaId)

timeEventController.delayDo(0.5,function()
fightController:closeSelectStage(false)
end)
end,
enterTxt="秘境",
cancelCallBack=function()
if worldController:isInWorld()then
worldController:displayUI(true)
worldController:displayHUD(true)
worldController:displaySymbol(true)
end

end,
fightCompareJingJie=jj,
fightCompareTips="该秘境里的敌人实力强大，是否确认？",
catCatMiJing=cfg_fb.teamFight~=nil and fbId or nil,
}
if worldController:isInWorld()then
worldController:displayUI(false)
worldController:displayHUD(false)
worldController:displaySymbol(false)
end
fightController.showPrepareWin(fightPreSelectModel.fightType.mystery,winArgs,function()
local mysteryPanelCfg=cfgHelper.get1(cfg_secretsceneuishowconfig_get,cfg_fb.uiOpen)
if mysteryPanelCfg.skillPanel then
local sysid=SYSTEM_DEFINE.eMiJingSkill
if systemModel.isOpen(sysid)then
UIFullFightPrepareControl:showWindow("UIMysterySkillSelectWin",{fbId})
end
end
end)
end
end
end

local data=MysteryModel:getFBInfoData(fbId)
if data and data[1]~=nil then
func(data)
else
MysteryEventModel:afterGetMysteryInfoFunc(func)

MysteryController.send_4_3(fbId)
end


end
end,
}
return returnList
end


function MysteryEventResult.result_get_sfpyAngry(args)













if not args.resultCfg then
return
end

local str=""
local bossvalue=args.resultCfg[3]or 0
local name=""
if args.resultCfg[2]==1 then
name="怒气值"
str=FMT.fmt("妖王{0}<color=#c82c2c>+{1}</color>",name,bossvalue)
elseif args.resultCfg[2]==2 then
name="亲和值"
str=FMT.fmt("妖王{0}<color=#549327>+{1}</color>",name,bossvalue)
end
MysteryEventModel:add_event_str_data(str)
return{childWin=MysteryEventSystem.ResultPanel.Attr}
end


function MysteryEventResult.result_get_sfpyrule(args)
if not args.resultCfg then
return
end
SiFangPingYaoModel:setqyfazedata(nil)
local is_debuff=false
local demons_id=SiFangPingYaoModel:getMapIdex()
if demons_id and demons_id>0 then
local debufflist=cfg_foursideskilldemonsconfig_get(demons_id).debufflist
if args.resultCfg[2]and args.resultCfg[2][1]and args.resultCfg[2][1][1]then
local buffid=args.resultCfg[2][1][1]
is_debuff=debufflist[buffid]
end
end
local temp=
{
abname="ui/windows/sifangpingyao/sifangpingyao_atlas_pak.ab",
isdebuff=is_debuff,
}
SiFangPingYaoModel:setqyfazedata(temp)

local child_win_args=
{
ruleList=args.resultCfg[2]
}

return{childWin=MysteryEventSystem.ResultPanel.Rule,childWinArgs=child_win_args,}
end


function MysteryEventResult.result_get_sfpyAngrynowin(args)
if not args.resultCfg then
return
end

end


function MysteryEventResult.result_xjrespoint_event(args)













if not args.resultCfg then
return
end
local resultCfg=args.resultCfg
local showText=resultCfg[5]
if showText then
MysteryEventModel:add_event_str_data(showText)
MysteryEventModel:add_event_dice_str_data(MysteryEventDiceResultAttrType.eCommonGreen,showText)
end
return{childWin=MysteryEventSystem.ResultPanel.Attr,}
end

function MysteryEventResult.result_xjmjrespoint_event(args)













if not args.resultCfg then
return
end
local resultCfg=args.resultCfg
local showText=resultCfg[5]
if showText then
MysteryEventModel:add_event_str_data(showText)
MysteryEventModel:add_event_dice_str_data(MysteryEventDiceResultAttrType.eCommonGreen,showText)
end
return{childWin=MysteryEventSystem.ResultPanel.Attr,}
end
