







local _MODULENAME="mysteryTriggerManager"
gameState.addListener(def_table(_MODULENAME))
mysteryTriggerManager.name=_MODULENAME

eMysteryTrigger=
{
eMoveCamera=-1,
ePlot=1,
eOpenTrigger=6,
eFlash=7,
eLockPlayer=8,
eFinish=15,
eStoryTree=16,
eTeamTalk=17,
eRoleTalk=18,
eGetReward=23,
eBattle=25,
eWait=26,
eOtherFlash=27,
eTipsWin=28,
eFlashToRoom=36,
eDelFog=38,
}

mysteryTriggerManager.mysteryTriggerNeedMoveCamera=
{
[10]=eMysteryTrigger.eMoveCamera,
[21]=eMysteryTrigger.eMoveCamera,
}

eMysteryTriggerCondition=
{
eRangeEntity=1,
}

local _register_list={}

local cameraMoveTweenQueue=nil
local cameraDelay=nil
local cameraMoveFlag=nil



local _curTriggerId=nil
local _breakInfo=nil

local _finishTriggerList={}
local _checkPosTriggerList={}

local isLockTrigger=nil

local _banTriList={}

function mysteryTriggerManager:onAppStart()
socketManager:register_receiver(4,28,mysteryTriggerManager.recv_4_28)
socketManager:register_receiver(4,57,mysteryTriggerManager.recv_4_57)
socketManager:register_receiver(4,52,mysteryTriggerManager.recv_4_52)
notifySystem:listenNotify(notifyConfig.on_mystery_finish,self.onMysteryFinish)
end

function mysteryTriggerManager:onEnterState()
cameraMoveTweenQueue=queue.New()
self.isPreview=nil
self.previewResult=nil
isLockTrigger=nil
_banTriList={}
end

function mysteryTriggerManager:onLeaveState()
cameraMoveTweenQueue:clear()
_curTriggerId=nil
_breakInfo=nil
cameraMoveFlag=nil
isLockTrigger=nil
_banTriList={}
end

function mysteryTriggerManager:set_cur_triggerId(id,nIndex)
_curTriggerId={id,nIndex}
end

function mysteryTriggerManager:get_cur_triggerId()
return _curTriggerId
end


function mysteryTriggerManager:set_trigger_break_info(triggerInfo)
_breakInfo=triggerInfo
end

function mysteryTriggerManager:get_trigger_break_info()
return _breakInfo
end

function mysteryTriggerManager:set_lock_trigger(flag)
isLockTrigger=flag
end

function mysteryTriggerManager:get_lock_trigger()
return isLockTrigger
end

function mysteryTriggerManager:clearBanTri()
_banTriList={}
end
function mysteryTriggerManager:setBanTri(triId)
_banTriList=_banTriList or{}
if _banTriList then
_banTriList[triId]=1
end
end
function mysteryTriggerManager:removeBanTri(triId)
if _banTriList then
_banTriList[triId]=nil
end
end
function mysteryTriggerManager:getBanTri(triId)
if _banTriList then
return _banTriList[triId]
end
end

function mysteryTriggerManager.checkAreaDontStop(triId)
return cfgHelper.get(cfg_secretscenetriggerconfig_get,triId,"areastopcheck")
end


function mysteryTriggerManager:init_check_pos_trigger_list(finishlist)
_finishTriggerList={}
_checkPosTriggerList={}

if finishlist and next(finishlist)then
for i,v in ipairs(finishlist)do
_finishTriggerList[v.param_1]=v.param_2
end
end

local fbid=MysteryModel:get_cur_fbid()
if not fbid then
return
end

local mjConfig=cfgHelper.get(cfg_secretscenefubenconfig_get,fbid)
local triggerList=mjConfig.trigger
local targetList=mjConfig.target
local fbTriggerList={}
if triggerList then
for i,triggerid in ipairs(triggerList)do
table.insert(fbTriggerList,{triggerid,_finishTriggerList[triggerid]or 0})
end
end
if targetList then
if targetList.trigger then
for i,v in ipairs(targetList.trigger)do
table.insert(fbTriggerList,{v,_finishTriggerList[v]or 0})
end
end
for i,targetData in ipairs(targetList)do
local tList=targetData.trigger
if tList and type(tList)=="table"then
for i,v in ipairs(tList)do
table.insert(fbTriggerList,{v,_finishTriggerList[v]or 0})
end
end
end
end



for i,v in ipairs(fbTriggerList)do
local triggerid=v[1]
local times=v[2]
local tCfg=cfgHelper.get(cfg_secretscenetriggerconfig_get,triggerid)
if not tCfg then
logErr(FMT.fmt('没有触发器id{0}',triggerid))
end


if tCfg.area then
local areaPosList={}
local areaType=tCfg.area[1]
if type(areaType)=="table"then
for _,v1 in ipairs(tCfg.area)do

for ii,vv in ipairs(v1)do
if ii>1 then
local val=vv
val.areaType=v1[1]
table.insert(areaPosList,val)
end
end

end

else
if areaType==1 or areaType==2 then
for ii,vv in ipairs(tCfg.area)do
if ii>1 then
local val=vv
val.areaType=areaType
table.insert(areaPosList,val)
end
end
end
end


if#areaPosList>0 then
if tCfg.validnum then
local validnum=tCfg.validnum[2]
if validnum-times>0 then
_checkPosTriggerList[triggerid]={areaPosList,validnum-times}
end
else

_checkPosTriggerList[triggerid]={areaPosList,1000}
end
end
end
end
end



function mysteryTriggerManager:get_check_pos_trigger_list()
return _checkPosTriggerList
end

function mysteryTriggerManager:on_finish_trigger(triggerId)
local triggerData=_checkPosTriggerList[triggerId]
if triggerData then
if triggerData[2]then
triggerData[2]=triggerData[2]-1
if triggerData[2]<=0 then
_checkPosTriggerList[triggerId]=nil
end
end
end
end



function mysteryTriggerManager.get_reselt(id,nIndex)
local result=nil
local resultList=cfgHelper.get2(cfg_secretscenetriggerconfig_get,id,'result')
if resultList then
if type(resultList[1])=="number"then
if nIndex==1 then
result=resultList
end
elseif type(resultList[1])=="table"then
result=resultList[nIndex]
end
end
return result
end

function mysteryTriggerManager.get_area(id)
local areaConfig=cfgHelper.get2(cfg_secretscenetriggerconfig_get,id,'area')
if areaConfig then
if areaConfig[1]==eTriggerAreaType.eMystery then
local areaList={}
for i,v in ipairs(areaConfig)do
if i>1 then
table.insert(areaList,v)
end
end
return areaList
else
return
end
end
return 0
end

function mysteryTriggerManager.bindClass(class)
local triggerType=class.triggerType

if _register_list[triggerType]then return end
_register_list[triggerType]=class
end

function mysteryTriggerManager.moveCamera(roomId,pos,delayCallback,moveSpeed,delay,isStay,beforeDelayCallback)
local action=function()
if beforeDelayCallback then
beforeDelayCallback()
end
if cameraDelay then
cameraDelay:cancel()
end
local after=function()
if delayCallback then
delayCallback()
end
local deQueue=cameraMoveTweenQueue:dequeue()
if deQueue then
mysteryTriggerManager.moveCamera(unpack(deQueue))
else
if not isStay then
local playerPos=mysteryPlayerModel:get_player_pos()
MysteryController.set_camera_fcous_pos(roomId,playerPos,moveSpeed,function()
mysteryAIManager:set_mystery_state(false)
cameraMoveTweenQueue:clear()
cameraMoveFlag=nil
end,true,_Ease.InOutSine)
else
cameraMoveTweenQueue:clear()
cameraMoveFlag=nil
end
end
cameraDelay=nil
end

if delay and delay>0 then
cameraDelay=timeEventController.delayDo(delay,after)

else
after()
end
end
MysteryController.set_camera_fcous_pos(roomId,pos,moveSpeed,action,true)
end

function mysteryTriggerManager.triggerMoveCamera(roomId,pos,delayCallback,moveSpeed,delay,isStay,beforeDelayCallback)
moveSpeed=moveSpeed or 8
delay=delay or 0.2
if cameraMoveFlag then
cameraMoveTweenQueue:enqueue({roomId,pos,delayCallback,moveSpeed,delay,isStay,beforeDelayCallback})
else
cameraMoveFlag=true
mysteryAIManager:set_mystery_state(true)
mysteryTriggerManager.moveCamera(roomId,pos,delayCallback,moveSpeed,delay,isStay,beforeDelayCallback)
end
end

function mysteryTriggerManager.getCameraMoveFlag()
return cameraMoveFlag
end




function mysteryTriggerManager.req_4_28(triggerId,choiceIndex,isClient,nIndex,preview)
if not MysteryModel:is_in_mystery()then
return
end
choiceIndex=choiceIndex or 0
if not isClient then
socketManager:send_4_28(triggerId,choiceIndex,nIndex,preview or 0)
end

mysteryAIManager:set_mystery_state(false)

local nextResult=mysteryTriggerManager.get_reselt(triggerId,nIndex+1)

if not nextResult then
if not mysteryTriggerManager:get_lock_trigger()then
mysteryTriggerManager.isInTrigger=false
end
cameraMoveFlag=nil

notifySystem:postNotify(notifyConfig.mystery_trigger_finish)
mysteryTriggerManager:on_finish_trigger(triggerId)
end
end

function mysteryTriggerManager.recv_4_28(triggerId,nIndex,preview,previewResultStr,haveOther)
if not MysteryModel:is_in_mystery()then
return
end




mysteryTriggerManager.isPreview=preview
if preview==1 then
mysteryTriggerManager.previewResult=jsonHelper.decode(previewResultStr)
else
mysteryTriggerManager.previewResult=nil
end

local result=mysteryTriggerManager.get_reselt(triggerId,nIndex)

mysteryTriggerManager:set_lock_trigger(haveOther==1)


if(mysteryAIManager.is_on_round()or mysteryFightModel:is_fighting())and(result[1]~=eMysteryTrigger.eFinish)or mysteryRoomModel:isInitRoom()then

mysteryAIManager:stop_ai()
mysteryTriggerManager:set_cur_triggerId(triggerId,nIndex)
else
mysteryTriggerManager:beforeTrigger(triggerId,nil,nIndex)
end
end


function mysteryTriggerManager.req_4_52(triggerId,sGUID)
socketManager:send_4_52(triggerId,sGUID)
end


function mysteryTriggerManager.req_4_57(fbid)
socketManager:send_4_57(fbid)
end


function mysteryTriggerManager.recv_4_57(triListLen,triList)
mysteryTriggerManager:init_check_pos_trigger_list(triList)
end

function mysteryTriggerManager.recv_4_52(fbid,len,triList)
_banTriList={}
if len>0 then
for i,v in ipairs(triList)do
_banTriList[v]=1
end
end
end





function mysteryTriggerManager:beforeTrigger(triggerId,isClient,nIndex)

local roomId=mysteryRoomModel:get_cur_roomID()
local result=mysteryTriggerManager.get_reselt(triggerId,nIndex)

mysteryAIManager:set_mystery_state(true)
mysteryTriggerManager.isInTrigger=true


local areaConfig=cfgHelper.get2(cfg_secretscenetriggerconfig_get,triggerId,'area')
if areaConfig then
mysterySkillController:set_hide_steps(0)
end

if result then
if self.mysteryTriggerNeedMoveCamera[result[1]]then
mysteryTriggerManager.invokeFunc(self.mysteryTriggerNeedMoveCamera[result[1]],triggerId,result,roomId,isClient,nIndex)
else
mysteryTriggerManager.invokeFunc(result[1],triggerId,result,roomId,isClient,nIndex)
end
else
loggerUtil.logErrFMT('triggerEvent 没有找到对应结果: {0},{1} ',triggerId,nIndex)
end
end


function mysteryTriggerManager.invokeFunc(triggerType,triggerId,result,roomId,isClient,nIndex)

local model=_register_list[triggerType]
if model==nil then
mysteryTriggerManager.req_4_28(triggerId,nil,isClient,nIndex)
return
end
if model.triggerEvent then
return model.triggerEvent(model,triggerId,result,roomId,isClient,nIndex)
else
loggerUtil.logErrFMT('实体类型{0}没有找到执行方法: triggerEvent ',triggerType)
end
end



local getEntity=function(condition)
if condition[1]==eMysteryTriggerCondition.eRangeEntity then
local cData=condition[2]
local range=cData[1]
local entityType=cData[2]
local playerPos=mysteryPlayerModel:get_player_pos()
local roomId=mysteryRoomModel:get_cur_roomID()
if range~=-1 then
local posList=mysteryPosHelper.get_all_round_pos_list(playerPos,range)
local entityList=mysteryEntityController.invokeFuncByMysteryEntityType(entityType,"get_all_entity_list_by_posList",posList,roomId)
return entityList,range
else
local entityList=mysteryEntityController.invokeFuncByMysteryEntityType(entityType,"get_room_entity_list",roomId)
return entityList,range
end
end
end

function mysteryTriggerManager.getTriggerRangeEntity(triggerId)
local condition=cfgHelper.get2(cfg_secretscenetriggerconfig_get,triggerId,'conditionclient')
if condition then
local list={}
local entityList=nil
local range=nil
local isRecord=nil
if type(condition[1])=="number"then
entityList,range=getEntity(condition)
if entityList then
for i,v in ipairs(entityList)do
isRecord=mysteryEntityController.invokeFuncByMysteryEntityType(v.entityType,"is_trigger_tip_record",v.guid,triggerId)
if not isRecord then
table.insert(list,{v.pos.x,v.pos.y,v.entityType,v.id})
mysteryEntityController.invokeFuncByMysteryEntityType(v.entityType,"set_trigger_tip_record",v.guid,triggerId,true)
end
end
return 1,list,range
end
elseif type(condition[1])=="table"then
local subList=nil
for i,condSub in ipairs(condition)do
entityList,range=getEntity(condSub)
if entityList then
subList={}
for i,v in ipairs(entityList)do
isRecord=mysteryEntityController.invokeFuncByMysteryEntityType(v.entityType,"is_trigger_tip_record",v.guid,triggerId)
if not isRecord then
table.insert(subList,{v.pos.x,v.pos.y,v.entityType,v.id})
mysteryEntityController.invokeFuncByMysteryEntityType(v.entityType,"set_trigger_tip_record",v.guid,triggerId,true)
end
end
subList.range=range
table.insert(list,subList)
end
end
return 2,list
end
end
end

function mysteryTriggerManager:sendFbRangeEntity(fbId)
fbId=fbId or MysteryModel:get_cur_fbid()
local triggerList=cfgHelper.get2(cfg_secretscenefubenconfig_get,fbId,"clientTrigger")
if triggerList and next(triggerList)then
local triType=nil
local entityList=nil
local range=nil
for _,triggerId in ipairs(triggerList)do
triType,entityList,range=self.getTriggerRangeEntity(triggerId)
if entityList then
if triType==1 then
if#entityList>0 then
mysteryTriggerManager:beforeTrigger(triggerId,true,1)

end
elseif triType==2 then
for i,v in ipairs(entityList)do
if v.range then
range=v.range
v.range=nil
if#v>0 then
mysteryTriggerManager:beforeTrigger(triggerId,true,1)

end
end
end
end
end
end
end
end




mysteryTriggerBase={}
function mysteryTriggerBase.new(class)
local _clone={}
if class then
for i,v in pairs(class)do
_clone[i]=v
end
_clone._base=class

end
if class.triggerType==nil then
logErr('没有传入类型 environmentEffectType')
end
local clone_mt={}
clone_mt.__index=mysteryTriggerBase
setmetatable(_clone,clone_mt)
mysteryTriggerManager.bindClass(_clone)
return _clone
end

function mysteryTriggerBase:triggerEvent(...)

end



mysteryTriggerMoveCamera=mysteryTriggerBase.new({triggerType=eMysteryTrigger.eMoveCamera})
function mysteryTriggerMoveCamera:triggerEvent(triggerId,result,roomId,isClient,nIndex)

local moveSpeed=result[2][5]
local cb=function()
mysteryTriggerManager.req_4_28(triggerId,nil,isClient,nIndex)


if result[3]then
local newbieFunc=result[3]
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
end
if result[2][1]==-1 then
local playerPos=mysteryPlayerModel:get_player_pos()
MysteryController.set_camera_fcous_pos(roomId,playerPos,moveSpeed,cb,true,_Ease.InOutSine)
else
local pos=Vector3(result[2][1],result[2][2],0)
mysteryTriggerManager.triggerMoveCamera(roomId,pos,nil,moveSpeed,result[2][4]or 0,result[2][3]~=1,cb)
end

end


