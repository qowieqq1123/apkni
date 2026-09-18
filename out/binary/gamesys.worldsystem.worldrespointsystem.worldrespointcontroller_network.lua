









local _this=worldResPointController

function worldResPointController:doRefreshRandom()
local datas=worldResPointRandomLibraryModel:extractRandomRefresh()

for i,v in pairs(datas)do
local infos={}
for j,w in ipairs(v)do
table.insert(infos,{w[1],w[2]})
end
self:send_5_41(i,infos)
end
end


function worldResPointController:init_proto_data()
local worlds=worldBlockModel:findOpenWorlds()
for i,v in ipairs(worlds)do
worldResPointController:send_5_44(v)
worldResPointBaseModel:addInitWorld(v)
end
end




function worldResPointController:send_5_41(world,array)
socketManager:send_5_41(world,#array,array)
end








function worldResPointController:send_5_43(guid,subIdx,world)
socketManager:send_5_43(guid,subIdx,world)
end



function worldResPointController:send_5_44(world)
socketManager:send_5_44(world)
end




function worldResPointController:send_5_45(world,block)
socketManager:send_5_45(world,block)
end






function worldResPointController.recv_5_41(world,len,array,level)
local now=timeHelper.getServerShortTime()
if len>0 then
for i,v in ipairs(array)do
local block=v.block
local template=v.template
local task=v.task
local overTime=v.endtime
local guid=v.guid
local coor=v.coor
local fix2=v.fixedIndex
if overTime<=0 or overTime>now then
worldResPointDataModel:addPointData(guid,world,block,template,level,task,coor,fix2,overTime,nil)
if worldController:isInWorld()and worldModel:isSameWorld(world)then
worldResPointController:showResPointUnits(guid)
end
end
end
end
worldResPointController:checkUpdate()
worldResPointRandomLibraryModel:setRefreshTime(world,now)
end













function worldResPointController.recv_5_42(guid,subIdx,newType,newId)
local unitKey=worldResPointBaseModel:convertUnitKey(guid,subIdx)
_this:hideResPointUnit(unitKey)

local old=worldResPointDataModel:getSubPointData(guid,subIdx)
if old[1]==eWorldResPointUnitType.Event then
local cfg=cfgHelper.get1(cfg_worldreseventconfig_get,old[2])
if cfg and cfg.afterFinish then
worldStoryAIManager:startStoryBehavior(cfg.afterFinish)
end
end

if newType==0 then
worldResPointDataModel:clearSubPointData(guid,subIdx)
else
worldResPointDataModel:setSubPointData(guid,subIdx,newType,newId)
local position,flip=worldResPointDataModel:getSubPointPosition(guid,subIdx)
_this:showResPointUnit(guid,subIdx,newType,newId,position,true,flip)
worldUnitModel:unitAppear(unitKey,function()
worldUnitModel.speResPoint(unitKey)
end)
end
end













function worldResPointController.recv_5_43(guid,subIdx,len,rewards)
local unitKey=worldResPointBaseModel:convertUnitKey(guid,subIdx)
local subData=worldResPointDataModel:getSubPointData(guid,subIdx)
local dataType=subData[1]
local dataId=subData[2]
if dataType==eWorldResPointUnitType.Collection then
local cfg=cfgHelper.get1(cfg_worldrescollectionconfig_get,dataId)
local monsterId=cfg.monster
if monsterId then
worldResPointDataModel:setSubPointData(guid,subIdx,eWorldResPointUnitType.Monster,monsterId)
else
worldResPointDataModel:clearSubPointData(guid,subIdx)
end
local afterFadeOut=function()
_this:hideResPointUnit(unitKey)
if monsterId then
local position,flip=worldResPointDataModel:getSubPointPosition(guid,subIdx)
_this:showResPointUnit_Monster(guid,subIdx,monsterId,position,true,flip)
worldUnitModel:unitAppear(unitKey,function()
worldUnitModel.speResPoint(unitKey)
end)
end
end
worldController:setAnimation(unitKey,entityStateID.dead)
worldController:stopModelEffect(unitKey,worldResPointBaseModel.collection_effect)
if len>0 then
worldController:changeModelColor(unitKey,Color.clear,1)
worldHUDModel:dropItem(unitKey,len,rewards,afterFadeOut)

if len>1 then


AudioManager.playAudio(430)
else


AudioManager.playAudio(451)
end
else
worldController:changeModelColor(unitKey,Color.clear,1,afterFadeOut)
end
else
_this:hideResPointUnit(unitKey)
worldResPointDataModel:clearSubPointData(guid,subIdx)
end
end






function worldResPointController.recv_5_44(world,last,len,array)
worldResPointRandomLibraryModel:setRefreshTime(world,last)

worldResPointBaseModel:removeInitWorld(world,array)
worldResPointBaseModel:checkInitWorld()
if worldModel:isSameWorld(world)then
_this:hideWorldResPoint(world)
end

worldResPointDataModel:clearWorldData(world)
worldResPointDataModel:addPointDatas(world,array or{})
if worldModel:isSameWorld(world)then

_this:showWorldResPoint(world)
end
_this:checkUpdate()
worldTaskController:handleErrData_ResPoint(world)
if not worldModel:checkInit(eWorldUnitTpye.RESPOINT)then
worldModel:finishInit(eWorldUnitTpye.RESPOINT)
end
huntMonsterTeamController:checkMonsterDataRefresh()
end






function worldResPointController.recv_5_45(world,block,len,array)
if len>0 then
worldResPointDataModel:addPointDatas(world,array)
if worldModel:isSameWorld(world)then
for i,v in ipairs(array)do
_this:showResPointUnits(v.guid)
end
end
end
_this:checkUpdate()
end



function worldResPointController.recv_5_46(guid)
worldResPointController:hideResPointAllUnit(guid)
local data=worldResPointDataModel:getPointData(guid)
if data then
for i,v in pairs(data.datas)do
worldResPointDataModel:clearSubPointData(guid,i)
end
end
end