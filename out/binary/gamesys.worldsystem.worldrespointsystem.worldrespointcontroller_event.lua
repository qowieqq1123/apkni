









local _this=worldResPointController

function worldResPointController.onWorldPositionReRandom(rData,aData)

if rData.unitType==eWorldUnitTpye.RESPOINT then
local key=rData.key
local guid=int64.new(key)
local subIdx=rData.sub
local data=worldResPointDataModel:getPointData(guid)
if data==nil then
loggerUtil.logErrFMT("空资源点数据被顶替: {0}",serializeHelper.serialize(rData))
worldPositionLibrary:eraseData(guid,subIdx)
return
end
local template=data.template
local subData=data.datas
local world=data.world
local block=data.block
local tempalteCfg=cfgHelper.get1(cfg_worldrestemplatedataconfig_get,template)
local offsets={}
for subIndex,subData in pairs(subData)do
local subCfg=tempalteCfg.data[subIndex]
local offset=subCfg[3]
table.insert(offsets,{offset[1],offset[2]})
end

local x=nil
local z=nil
local valid=false
if data.fix>0 then
loggerUtil.logErrFMT("固定资源点位置被顶替：{0}， {1}",serializeHelper.serialize(rData),serializeHelper.serialize(aData))
return
elseif data.fix2>0 then
loggerUtil.logErrFMT("随机固定资源点位置被顶替：{0}， {1}",serializeHelper.serialize(rData),serializeHelper.serialize(aData))
return
















else
local randomCfg=cfgHelper.get2(cfg_worldresrandompointconfig_get,world,block)
local library=randomCfg.random
local check,list=worldPositionLibrary:extract(library,1,true,offsets)
if check and list[1]then
local temp=list[1]
x=temp.x
z=temp.z
valid=true
end
end
if valid then

for subIndex,subData in pairs(subData)do
local subCfg=tempalteCfg.data[subIndex]
local offset=subCfg[3]
local flip=offset[3]==nil and true or offset[3]
local sx=x+offset[1]
local sz=z+offset[2]
worldPositionLibrary:eraseData(guid,subIndex)
worldPositionLibrary:markData(world,sx,sz,flip,eWorldUnitTpye.RESPOINT,guid,subIndex)
local unitKey=worldResPointBaseModel:convertUnitKey(guid,subIndex)
worldTaskModel:changeTaskTargetDestination(unitKey)
if worldController:isInWorld()and worldModel:isSameWorld(world)then
worldController:setUnitFlipX(unitKey,flip)
local position,block=worldPositionConfig:getPosition(world,{sx,sz})
worldController:setUnitPosition(unitKey,position)
end
end
else

end
end
end

function worldResPointController.onMysteryClose(mysteryId)

for guidStr,data in pairs(worldResPointDataModel.data)do
for subIdx,subData in pairs(data.datas)do
local subType=subData[1]
local subId=subData[2]
if subType==eWorldResPointUnitType.Mystery then
local subCfg=cfgHelper.get1(cfg_worldresmysteryconfig_get,subId)
if subCfg.mystery==mysteryId then
local unitKey=worldResPointBaseModel:convertUnitKey(data.guid,subIdx)
_this:hideResPointUnit(unitKey)
worldResPointDataModel:clearSubPointData(data.guid,subIdx)
return
end
end
end
end
end



function worldResPointController.onClickUnitEvent(args)
if(args and args[1]==worldModel.UNITTYPE.RESPOINT)then
local guid=args[2]
local subIdx=args[3]
local dataType=args[4]
local dataId=args[5]
local info=worldResPointDataModel:getPointData(guid)
local fightData=worldResPointFightModel:getFightResult(guid,subIdx)
if info==nil and fightData==nil then

return
end
local unitKey=worldResPointBaseModel:convertUnitKey(guid,subIdx)
if huntMonsterTeamModel:findMonsterWorld(unitKey)then
UIManager.info("猎妖队狩猎中")
return
end


if dataType==eWorldResPointUnitType.Monster then

local taskKey=worldTaskModel:findLastTaskKey_ByTarget(unitKey)
if taskKey then
local task=worldTaskModel:getTask(taskKey)
if task.progress_state>eWorldTripProgress.Go then
if task.progress_state<eWorldTripProgress.Back then


if fightData then
local fightResult=fightData.result
local logIdx=fightData.logIdx
worldResPointFightModel:fight(guid,subIdx,fightResult,logIdx)
else
UIManager.error("没有战斗数据")
end
else

local fightData=worldResPointFightModel:getFightResult(guid,subIdx)
if not fightData or fightData.result~=fightResultType.Victory then
_this:onClickUnit(guid,subIdx,dataType,dataId)
end
end
else
UIManager.error("正在派遣前往战斗")
end
return
end
else

local tasks=worldTaskModel:getAllTaskingRecord()
for taskKey,task in pairs(tasks)do
local targetType=task.target_type
local targetId=task.target_id
if targetType==eWorldUnitTpye.RESPOINT and mathHelper.compareInt64(guid,task.guid)then
if task.progress_state<eWorldTripProgress.Back then


return UIManager.error("有敌人挡住了去路")



end
end
end

local isBreak=false
for i,v in pairs(info.datas)do
local subDataType=v[1]
if subDataType==eWorldResPointUnitType.Monster then
local monsterKey=worldResPointBaseModel:convertUnitKey(guid,i)
worldUnitModel:unitEmot(monsterKey,"#11",2)
worldUnitModel:unitAttack(monsterKey,2,nil)

UIManager.error("有敌人挡住了去路")



isBreak=true
end
end

if isBreak then
return
end
end

_this:onClickUnit(guid,subIdx,dataType,dataId)
end
end



function worldResPointController.onNewDayEvent(islogin)
if _this:checkSystemOpen()then
_this:doRefreshRandom()
end
end



function worldResPointController.onSystemOpenEvent(sysid)
if sysid==SYSTEM_DEFINE.eWorldResPoint then


worldResPointController.onInitDataEvent()
end
end

function worldResPointController.onWorldBlockDataChangedEvent(world,block,state)
if state==worldBlockModel.BLOCKSTATE.OPEN and _this.checkSystemOpen()then

local needRefreshRandom=not worldResPointRandomLibraryModel:checkRandomLibrary(world)
worldResPointRandomLibraryModel:addRandomLibrary(world,block)
if needRefreshRandom then
worldResPointController:doRefreshRandom()
end
end
end





function worldResPointController.onWorldBlockStateChangedEvent(world,block,state)
if state==worldBlockModel.BLOCKSTATE.OPEN and _this.checkSystemOpen()then








worldResPointController:showBlockResPoint(world,block)
end
end

function worldResPointController.onWorldBlockDataInited(reInit)
worldResPointRandomLibraryModel:initExtractLibrary()
if initProControl.isDone()and worldController:isInWorld()then
worldResPointController:hideWorldResPoint(worldModel.world)
worldResPointController:showWorldResPoint(worldModel.world)
end
end


function worldResPointController.onEnterWorldSceneEvent()
if _this:checkSystemOpen()then
_this:showWorldResPoint(worldModel.world)
end
end


function worldResPointController.onInitDataEvent()

worldResPointController:init_proto_data()
end
























































function worldResPointController.onQiYuEventFinish(sysId)

if sysId==SYSTEM_DEFINE.eWorldResPoint then


local tempData=worldResPointBaseModel:getTempCemaraData()
worldController:lookAtPosition(tempData[2],tempData[3])
worldResPointBaseModel:setTempCemaraData()










end
end

function worldResPointController.onQiYuEventBreak(sysId)
if sysId==SYSTEM_DEFINE.eWorldResPoint then
local tempData=worldResPointBaseModel:getTempCemaraData()
worldController:lookAtPosition(tempData[2],tempData[3])
worldResPointBaseModel:setTempCemaraData()








end
end
