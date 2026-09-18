






mysteryTriggerFlash=mysteryTriggerBase.new({triggerType=eMysteryTrigger.eFlash})
function mysteryTriggerFlash:triggerEvent(triggerId,result,roomId,isClient,nIndex)
local areaList=mysteryTriggerManager.get_area(triggerId)
if not areaList then
mysteryAIManager:set_mystery_state(false)
return
end

if type(areaList)=='table'then
for i,area in ipairs(areaList)do
self.resultTransform(Vector3(area[1],area[2],0),area[3],roomId,Vector3(result[2][1],result[2][2],0))
end
elseif type(areaList)=='number'and areaList==0 then
local unittype=cfgHelper.get2(cfg_secretscenetriggerconfig_get,triggerId,'unittype')
if unittype then
self.resultTransform(mysteryPlayerModel:get_player_pos(),0,roomId,Vector3(result[2][1],result[2][2],0))
else
self.resultTransform(nil,nil,roomId,Vector3(result[2][1],result[2][2],0),true)
end
end

mysteryTriggerManager.req_4_28(triggerId,nil,isClient,nIndex)
end


function mysteryTriggerFlash.resultTransform(oriPos,round,roomId,targetPos,isAllScene)

if isAllScene then
local entityList=mysteryEntityController.invokeAllMoveModelsFunc('get_room_entity_list',roomId)
for entityType,el in pairs(entityList)do
for _,v in ipairs(el)do
if v then
mysteryEntityController.invokeFuncByMysteryEntityType(entityType,"flash",v.guid,targetPos)
end
end
end
else
local posList=mysteryPosHelper.get_all_round_pos_list(oriPos,round)
for _,pos in ipairs(posList)do
local entityList=mysteryEntityController.invokeAllMoveModelsFunc('get_all_entity_list_by_pos',pos,roomId)
if entityList then
for entityType,el in pairs(entityList)do
for _,v in ipairs(el)do
if v then
mysteryEntityController.invokeFuncByMysteryEntityType(entityType,"flash",v.guid,targetPos)
end
end
end
end
end
end
end


mysteryTriggerFlashRoom=mysteryTriggerBase.new({triggerType=eMysteryTrigger.eFlashToRoom})
function mysteryTriggerFlashRoom:triggerEvent(triggerId,result,roomId,isClient,nIndex)
mysteryRoomModel.data.isInitRoom=true
mysteryTriggerManager.req_4_28(triggerId,nil,isClient,nIndex)
mysteryRoomController.send_4_18(result[3],result[4],0,result[2],1)
end


mysteryTriggerLockPlayer=mysteryTriggerBase.new({triggerType=eMysteryTrigger.eLockPlayer})
function mysteryTriggerLockPlayer:triggerEvent(triggerId,result,roomId,isClient,nIndex)
local areaList=mysteryTriggerManager.get_area(triggerId)
if not areaList then
mysteryAIManager:set_mystery_state(false)
return
end
if type(areaList)=='table'then
for i,area in ipairs(areaList)do
self.resultTargetPlayer(Vector3(area[1],area[2],0),area[3],roomId,false)
end
elseif type(areaList)=='number'and areaList==0 then
self.resultTargetPlayer(nil,nil,roomId,true)
end
end



function mysteryTriggerLockPlayer.resultTargetPlayer(oriPos,round,roomId,isAllScene)
if isAllScene then
local entityList=mysteryEntityController.invokeFuncByMysteryEntityType(eMysteryEntityType.eMonster,'get_room_entity_list',roomId)
if entityList then
for _,v in ipairs(entityList)do
mysteryMonsterModel:set_lock_player(v.guid,true)
end
end
else
local posList=mysteryPosHelper.get_all_round_pos_list(oriPos,round)
for _,pos in ipairs(posList)do
local entityList=mysteryEntityController.invokeFuncByMysteryEntityType(eMysteryEntityType.eMonster,'get_all_entity_list_by_pos',pos,roomId)
if entityList then
for _,v in ipairs(entityList)do
mysteryMonsterModel:set_lock_player(v.guid,true)
end
end
end
end
end



mysteryTriggerGamePlot=mysteryTriggerBase.new({triggerType=eMysteryTrigger.ePlot})
function mysteryTriggerGamePlot:triggerEvent(triggerId,result,roomId,isClient,nIndex)
self.resultGamePlot(triggerId,result,roomId,isClient,nIndex)
end

function mysteryTriggerGamePlot.resultGamePlot(triggerId,PlotParms,roomId,isClient,nIndex)
local plotType=PlotParms[1]
local plotId=PlotParms[2]
local cb=function(idx)
idx=idx or 0
mysteryTriggerGamePlot:setGamePlotData(nil)
mysteryTriggerManager.req_4_28(triggerId,idx,isClient,nIndex)
end



local params=
{
groupid=plotId,
movie=plotId,
callback=cb,

}
gameplotController:showGamePlot(plotType,params)
local now=timeHelper.getServerShortTime()
mysteryTriggerGamePlot:setGamePlotData({now,triggerId,nIndex})
end

function mysteryTriggerGamePlot:setGamePlotData(args)
self.plotData=args
end

function mysteryTriggerGamePlot:getGamePlotData()
return self.plotData
end

function mysteryTriggerGamePlot:showGamePlotDialog()
local func=function()
MysteryModel:set_fb_finish(eMysteryQuitType.eBreak)
MysteryController.send_4_27()
end
local content="秘境空间发生震荡不稳，请祖师重新进入\n<color=#c82c2c>（网络不稳定，请重新进入）</color>"
UIDialogManager.getCommonDialog3(nil,content,func)
end



mysteryTriggerFinish=mysteryTriggerBase.new({triggerType=eMysteryTrigger.eFinish})
function mysteryTriggerFinish:triggerEvent(triggerId,result,roomId,isClient,nIndex)



if mysteryTreasureModel.showWindow then

local win=UIManager:findActiveWindow("UICommonShowPrizeWin")
local cb=function()
mysteryAIManager:stop_ai()
MysteryController.quitMysteryFuBen()
mysteryTriggerManager.req_4_28(triggerId,nil,isClient,nIndex)
mysteryAIManager:set_mystery_state(true,nil,5)
end
if win then
win:setAttachCB(cb)
else
mysteryTreasureModel.finCB=cb
end
else


mysteryAIManager:stop_ai()
MysteryController.quitMysteryFuBen()
mysteryTriggerManager.req_4_28(triggerId,nil,isClient,nIndex)
mysteryAIManager:set_mystery_state(true,nil,5)
end
end

function mysteryTriggerManager.onMysteryFinish(fbid)








end



mysteryTriggerStoryTree=mysteryTriggerBase.new({triggerType=eMysteryTrigger.eStoryTree})
function mysteryTriggerStoryTree:triggerEvent(triggerId,result,roomId,isClient,nIndex)
self.resultStoryTree(triggerId,result,isClient,nIndex)
end


function mysteryTriggerStoryTree.resultStoryTree(triggerId,result,isClient,nIndex)
local treeId=result[2]
local newbieFunc=result[4]
local cb=function()

timeEventController.delayDo(0.06,function()
mysteryTriggerManager.req_4_28(triggerId,nil,isClient,nIndex)
end)
mysteryAIManager:set_mystery_state(false)
if newbieFunc and NEWBIE_LUA_FUNC_NAME[newbieFunc]then
local luaFuncName=NEWBIE_LUA_FUNC_NAME[newbieFunc]
local config=newbieModel.getLookupConfig(NEW_BIE_CND_TYPE.eLuaFun,luaFuncName)
if config then
local newbieId=config.id
if not newbieModel.isFinish(newbieId)then
newbieControl.startNewbie(NEW_BIE_CND_TYPE.eLuaFun,luaFuncName)
mysteryAIManager:set_mystery_state(true)
end
end
end
mysteryTriggerGamePlot:setGamePlotData(nil)
end
local guid=MysteryModel:get_team_first()

worldStoryController:showStoryTree(treeId,cb,nil,guid)
mysteryAIManager:set_mystery_state(true,false,30)
timeEventController.delayDo(0.2,function()
baseFullScreenUI:openMain(false)
end)
local now=timeHelper.getServerShortTime()
mysteryTriggerGamePlot:setGamePlotData({now,triggerId,nIndex})
end



mysteryTriggerTeamTalk=mysteryTriggerBase.new({triggerType=eMysteryTrigger.eTeamTalk})
function mysteryTriggerTeamTalk:triggerEvent(triggerId,result,roomId,isClient,nIndex)
self.resultTeamTalk(result[2],result[3])
mysteryTriggerManager.req_4_28(triggerId,nil,isClient,nIndex)
end

function mysteryTriggerTeamTalk.resultTeamTalk(talkId,name)
UIManager:invokeUIMethod("UIMysteryWin","talk",talkId,name)
end

function mysteryTriggerTeamTalk.resultTeamTalkId(triggerId,nIndex)
local result=mysteryTriggerManager.get_reselt(triggerId,nIndex)
if result then
UIManager:invokeUIMethod("UIMysteryWin","talk",result[2],result[3])
end
end



mysteryTriggerRoleTalk=mysteryTriggerBase.new({triggerType=eMysteryTrigger.eRoleTalk})
function mysteryTriggerRoleTalk:triggerEvent(triggerId,result,roomId,isClient,nIndex)
local player=mysteryPlayerModel:get_player()
self.resultRoleTalk(result[2],eMysteryEntityType.ePlayer,player.guid)
mysteryTriggerManager.req_4_28(triggerId,nil,isClient,nIndex)
end

function mysteryTriggerRoleTalk.resultRoleTalk(talkId,eType,guid)
if not guid then
eType=eMysteryEntityType.ePlayer
guid=mysteryPlayerModel:get_player().guid
end
UIManager:invokeUIMethod("UIMysteryHUDWin","addUIHUD",eMysteryHUDType.eTalk,{talkId=talkId,bindType=eType,bindguid=guid})
end

function mysteryTriggerRoleTalk.resultRoleTalkStr(str,eType,guid,delay,callback)
if not guid then
eType=eMysteryEntityType.ePlayer
guid=mysteryPlayerModel:get_player().guid
end
UIManager:invokeUIMethod("UIMysteryHUDWin","addUIHUD",eMysteryHUDType.eTalk,{str=str or"",bindType=eType,bindguid=guid,delay=delay or 3,callback=callback})
end

function mysteryTriggerRoleTalk.resultRoleBloodNum(blood,eType,guid,delay)
if not guid then
eType=eMysteryEntityType.ePlayer
guid=mysteryPlayerModel:get_player().guid
end
UIManager:invokeUIMethod("UIMysteryHUDWin","addUIHUD",eMysteryHUDType.eBloodNumShow,{str=blood or 0,bindType=eType,bindguid=guid,delay=delay or 3})
end




mysteryTriggerGetReward=mysteryTriggerBase.new({triggerType=eMysteryTrigger.eGetReward})
function mysteryTriggerGetReward:triggerEvent(triggerId,result,roomId,isClient,nIndex)
if mysteryTriggerManager.isPreview==1 then
for i,r in ipairs(mysteryTriggerManager.previewResult)do
if tonumber(r[1])==eMysteryTrigger.eGetReward then
local list=r[2]
local conf={}
for i,v in ipairs(list)do
table.insert(conf,{itemid=tonumber(v[1]),num=tonumber(v[2])})
end
showPrizeControl.showWindow(conf,function()
mysteryTriggerManager.req_4_28(triggerId,nil,isClient,nIndex,0)
end)
end
end
else
mysteryTriggerManager.req_4_28(triggerId,nil,isClient,nIndex,1)
end
end




mysteryTriggerBattle=mysteryTriggerBase.new({triggerType=eMysteryTrigger.eBattle})
function mysteryTriggerBattle:triggerEvent(triggerId,result,roomId,isClient,nIndex)
local monsterGroup=result[2]

local monster1=monsterGroup[1]
local mapId
if monster1 then
mapId=cfgHelper.get2(cfg_monstergroup_get,monster1,"mapId")
end
local zhenfa=MysteryModel:get_select_zhenFa()

local sendMonster={}

for i,v in ipairs(monsterGroup)do
sendMonster[#sendMonster+1]={0,0,v}
end

UIFullDiscipleMainControl:closeUI()
mysteryFightModel:set_fighting(true)

local sendTeam=MysteryModel:get_fb_sendTeam()
fightLaunchController:sendFight(eBattleLaunch.mystery,sendTeam,mapId or 0,zhenfa,{1,sendMonster})

MysteryController:slideUI()



mysteryTriggerBattle.curTrigger={triggerId,nIndex}
end




mysteryTriggerWait=mysteryTriggerBase.new({triggerType=eMysteryTrigger.eWait})
function mysteryTriggerWait:triggerEvent(triggerId,result,roomId,isClient,nIndex)
local wait=result[2]

if wait and wait>0 then
timeEventController.delayDo(wait,function()
mysteryTriggerManager.req_4_28(triggerId,nil,isClient,nIndex,0)
end)
else
mysteryTriggerManager.req_4_28(triggerId,nil,isClient,nIndex,0)
end
end




mysteryTriggerOtherFlash=mysteryTriggerBase.new({triggerType=eMysteryTrigger.eOtherFlash})
function mysteryTriggerOtherFlash:triggerEvent(triggerId,result,roomId,isClient,nIndex)
local list=result[2]
local roomId=mysteryRoomModel:get_cur_roomID()
local entityList={}
for i,v in ipairs(list)do
local model=mysteryEntityController.getModelByEntityType(v[5])
if model then
local entity
if v[5]==eMysteryEntityType.ePlayer then
entity=mysteryPlayerModel:get_player()
else
local oriPos=Vector3(v[1],v[2],0)
if v[6]then
entity=model:get_entity_by_pos_id(oriPos,roomId,v[6])
else
entity=model:get_entity_by_pos(oriPos,roomId)
end
end

table.insert(entityList,{ent=entity,tarPos=Vector3(v[3],v[4])})
end
end

if next(entityList)then
for i,v in ipairs(entityList)do
local model=mysteryEntityController.getModelByEntityType(v.ent.entityType)
if model then
model:flash(v.ent.guid,v.tarPos,false)
end
end
end

mysteryTriggerManager.req_4_28(triggerId,nil,isClient,nIndex)
end


mysteryTriggerTipsWin=mysteryTriggerBase.new({triggerType=eMysteryTrigger.eTipsWin})
function mysteryTriggerTipsWin:triggerEvent(triggerId,result,roomId,isClient,nIndex)
UIFullMysteryMainControl:showWindow('UIMysteryTipsWin',{str=result[2],delay=result[3],icon=result[4],iconPosX=result[5],iconPosY=result[6]})
mysteryTriggerManager.req_4_28(triggerId,nil,isClient,nIndex)
end


mysteryTriggerOpenTrigger=mysteryTriggerBase.new({triggerType=eMysteryTrigger.eOpenTrigger})
function mysteryTriggerOpenTrigger:triggerEvent(triggerId,result,roomId,isClient,nIndex)
local rType=result[2][1]
if rType==1 then
mysteryTriggerManager:setBanTri(result[2][2])
else
mysteryTriggerManager:removeBanTri(result[2][2])
end
mysteryTriggerManager.req_4_28(triggerId,nil,isClient,nIndex)
end


mysteryTriggerDelFog=mysteryTriggerBase.new({triggerType=eMysteryTrigger.eDelFog})
function mysteryTriggerDelFog:triggerEvent(triggerId,result,roomId,isClient,nIndex)
local fbid=MysteryModel:get_cur_fbid()
local list=result[2]
for i,v in ipairs(list)do
local pos=Vector3.New(v[1],v[2],0)
mysteryFogController:updateFog(fbid,pos,v[3])
end
mysteryTriggerManager.req_4_28(triggerId,nil,isClient,nIndex)
end
