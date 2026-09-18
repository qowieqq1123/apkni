








function mysteryEntityController.mysteryEntityMove(guid,isMoving)
MysteryModel:set_moving_entity(guid,isMoving)

if not isMoving and not MysteryModel:have_moving_entity()then
mysteryEntityController.onMovingFinish()
end
end

function mysteryEntityController.onMovingFinish()
mysteryMonsterModel:clear_monster_select()

local completeEntity=MysteryModel:get_move_complete_entity()

if completeEntity then
local uploadList={}
for i,ent in pairs(completeEntity)do
local sendPath=mysteryEntityController:get_move_complete_send_data(ent)
if sendPath then
table.insert(uploadList,sendPath)
end
end
local len=#uploadList
if len>0 then
mysteryEntityController:upload_movelist_pos(len,uploadList,true)
end
end

MysteryModel:clear_moving_entity()
MysteryModel:clear_move_complete_entity()
end




function mysteryEntityController:get_move_pos_data(entity,pos)

local serverguid=entity.data.guid
if entity.entityType==eMysteryEntityType.ePlayer then
serverguid=0
else
if not serverguid then
loggerUtil.logErrFMT('服务器guid不存在',entity.entityType,entity.id,pos.x,pos.y)
return
end
end

local stepNum=entity.data.stepNum or 0

local args=
{
entity.entityType,
serverguid,
1,
{{entity.pos.x,entity.pos.y},{pos.x,pos.y}},
stepNum,
entity.data.dropFlag or 0,
}

return args
end

function mysteryEntityController:getMonsterNum()
local roomId=mysteryRoomModel:get_cur_roomID()
local monsterList=mysteryMonsterModel:get_room_entity_list(roomId)or{}
return#monsterList
end

function mysteryEntityController:upload_move_pos(entity,pos)
local args=mysteryEntityController:get_move_pos_data(entity,pos)
local monsterMoveList={args}
local num=mysteryEntityController:getMonsterNum()
mysteryEntityController:save_move_path(args[2],args[4])
socketManager:send_4_23(1,monsterMoveList,num)
end

function mysteryEntityController:send_4_23(list)
local num=mysteryEntityController:getMonsterNum()

for i,v in ipairs(list)do
mysteryEntityController:save_move_path(v[2],v[4])
end
socketManager:send_4_23(#list,list,num)
end

function mysteryEntityController:upload_movelist_pos(len,monsterMoveList,roundFinish)
local num=mysteryEntityController:getMonsterNum()
for i,v in ipairs(monsterMoveList)do
mysteryEntityController:save_move_path(v[2],v[4])
end
socketManager:send_4_23(len,monsterMoveList,num)
if roundFinish then
if not MysteryModel.currentFBData.waitToMove then
MysteryModel.currentFBData.waitToMove=true
self.waitToMoveTimer=timeEventController.delayDo(6,function()
MysteryModel.currentFBData.waitToMove=nil
end)
end
self.roundFinish=true
end
end

function mysteryEntityController:onEntityMoveRecv()


local triggerId=mysteryTriggerManager:get_cur_triggerId()
if triggerId and next(triggerId)then

mysteryTriggerManager:beforeTrigger(triggerId[1],nil,triggerId[2])
mysteryTriggerManager:set_cur_triggerId(nil)
else
mysteryEntityController.handle_meet()
end


mysteryMonsterController:set_all_entity_parent()
local hideInSamePosList=MysteryModel:get_hide_in_same_pos_type()
if hideInSamePosList then
for eType,_ in pairs(hideInSamePosList)do
local controller=mysteryEntityController.getControllerByEntityType(eType)
if controller then
controller:set_all_entity_parent()
controller:show_entity_count_hud()
end
end
end
MysteryModel:clear_all_last_path()
end


function mysteryEntityController.recv_4_23(recvLen,recvList)
if recvLen>0 then
local entityList={}
for i,v in ipairs(recvList)do
entityList[v.etType]=entityList[v.etType]or{}
if tostring(v.guid)=='0'then
entityList[v.etType]={v}
else
table.insert(entityList[v.etType],v)
end
end

for etType,v in pairs(entityList)do
if etType==eMysteryEntityType.ePlayer then
mysteryPlayerController:onRecvMove(v)
else
mysteryEntityController.invokeControllerFuncByMysteryEntityType(etType,"onRecvMove",v)
end
end
end

if mysteryEntityController.roundFinish then
if mysteryEntityController.waitToMoveTimer then
mysteryEntityController.waitToMoveTimer:cancel()
end
MysteryModel.currentFBData.waitToMove=nil

mysteryEntityController:onEntityMoveRecv()
mysteryEntityController.roundFinish=nil
end
end

function mysteryEntityController.isWaitToMove()
return MysteryModel.currentFBData.waitToMove
end


function mysteryEntityController:get_move_complete_send_data(ent)
if not ent then
logErr("找不到实体")
return
end
local sendPath={}
if ent.data.moveCompletePath then
for i,v in ipairs(ent.data.moveCompletePath)do
table.insert(sendPath,{v.x,v.y})
end
end
local guid=ent.entityType==eMysteryEntityType.ePlayer and 0 or ent.data.guid
local stepNum=ent.data.stepNum or 0

return
{
ent.entityType,
guid,
#sendPath,
sendPath,
stepNum,
ent.data.dropFlag or 0,
}
end


function mysteryEntityController:save_move_path(guid,movePath)
MysteryModel.currentFBData.sendMovePath=MysteryModel.currentFBData.sendMovePath or{}
MysteryModel.currentFBData.sendMovePath[guid]=movePath
end

function mysteryEntityController:get_move_path(guid)
MysteryModel.currentFBData.sendMovePath=MysteryModel.currentFBData.sendMovePath or{}
return MysteryModel.currentFBData.sendMovePath[guid]
end

function mysteryEntityController:get_move_step(guid)
local path=mysteryEntityController:get_move_path(guid)
if path then
return#path-1
end
return 0
end

function mysteryEntityController.entityMoveTo(guid,path,steps,callback,pointCallBack,layer,beginCallBack,prepareCallBack,outSequence)
layer=layer==nil and HexMapLayer.Ground or layer

if outSequence then
outSequence:Kill(false)
end

outSequence=Lua.SequenceProxy.New()
local newPath={}
for i,v in ipairs(path)do
if i>1 then
table.insert(newPath,v)
end
end
local m_pathIndex=0
local maxIndex=#newPath
if maxIndex<1 then
return
end
local realPath={path[1]}
local ent=_EntityManager:GetEntity(guid)
outSequence:AppendCallback(function()
if prepareCallBack then
prepareCallBack(path[1])
end
end)
outSequence:AppendInterval(0.1)
local dur=MysteryModel:getMoveDur()
if steps>=maxIndex then
table.insert(realPath,newPath[maxIndex])
outSequence:AppendCallback(function()
if beginCallBack then
beginCallBack(newPath[maxIndex])
end
end)
local moveTweeener=Lua.DOTweenProxyExtensions.DOMove(ent.transform,_HexMapManager.GetCellCenterWorld(newPath[maxIndex],layer,false),dur,false)
outSequence:Append(moveTweeener)
outSequence:AppendCallback(function()
if pointCallBack then
local sendPath={}
for ri,rv in ipairs(realPath)do
if ri-1>maxIndex then
break
end
table.insert(sendPath,rv)
end
pointCallBack(newPath[maxIndex],maxIndex,sendPath,true)
end
end)
else
for i=steps,maxIndex,steps do
if newPath[i]then
table.insert(realPath,newPath[i])
outSequence:AppendCallback(function()
m_pathIndex=m_pathIndex+steps
if beginCallBack then
beginCallBack(newPath[i])
end
end)
if steps>1 then
if i==steps then
if mysteryPosHelper.is_same_pos(path[1],newPath[i])then
outSequence:AppendInterval(dur*(steps-1))
end
else
if mysteryPosHelper.is_same_pos(newPath[i-steps],newPath[i])then
outSequence:AppendInterval(dur*(steps-1))
end
end
end
local moveTweeener=Lua.DOTweenProxyExtensions.DOMove(ent.transform,_HexMapManager.GetCellCenterWorld(newPath[i],layer,false),dur,false)
outSequence:Append(moveTweeener)
outSequence:AppendCallback(function()
if pointCallBack then
local sendPath={}
for ri,rv in ipairs(realPath)do
if ri-1>i then
break
end
table.insert(sendPath,rv)
end
pointCallBack(newPath[i],i+1,sendPath,maxIndex%steps==0 and i==maxIndex)
end
end)
end
end
if(maxIndex%steps~=0)then
table.insert(realPath,newPath[maxIndex])
outSequence:AppendCallback(function()
if beginCallBack then
beginCallBack(newPath[maxIndex])
end
end)
local moveTweeener=Lua.DOTweenProxyExtensions.DOMove(ent.transform,_HexMapManager.GetCellCenterWorld(newPath[maxIndex],layer,false),dur,false)
outSequence:Append(moveTweeener)
outSequence:AppendCallback(function()
if pointCallBack then
local sendPath={}
for ri,rv in ipairs(realPath)do
if ri-1>maxIndex then
break
end
table.insert(sendPath,rv)
end
pointCallBack(newPath[maxIndex],maxIndex,sendPath,true)
end
end)
end
end

outSequence:OnComplete(function()
if callback then
callback(realPath)
end
end)
return outSequence
end
