






local _MODULENAME="worldResPointDataModel"




def_table(_MODULENAME)
worldResPointDataModel.name=_MODULENAME


















worldResPointDataModel.data={}










worldResPointDataModel.lookup={}
worldResPointDataModel.data_ls={}
worldResPointDataModel.lookup_ls={}

function worldResPointDataModel:onAppStart()

end


function worldResPointDataModel:onEnterState()

end


function worldResPointDataModel:onLeaveState(isReconnect)


if not isReconnect then
self.data={}
self.lookup={}
self.data_ls={}
self.lookup_ls={}
end


end


function worldResPointDataModel:onServerDataInitFinish()

end

function worldResPointDataModel:addPointDatas(world,array)
for i,v in ipairs(array)do
if v.len>0 then
local subData={}
for j,w in ipairs(v.contentList)do
subData[w.param_3]={w.param_1,w.param_2}
end
self:addPointData(v.guid,world,v.block_id,v.data_idx,v.world_level,v.task,v.coor_idx,v.fixedIndex,v.end_times,subData)
end
end
end

function worldResPointDataModel:addPointData(guid,world,block,template,level,task,fix,fix2,overTime,subData)
if subData==nil then
local templateCfg=cfgHelper.get1(cfg_worldrestemplatedataconfig_get,template)
subData={}
for i,v in ipairs(templateCfg.data)do
subData[i]={v[1],v[2]}
end
end

local data={
world=world,
block=block,
template=template,
level=level,
datas=subData,
guid=guid,
fix=fix,
task=task,
time=overTime,
fix2=fix2,
}
if not self:handleDataCorrect(data)then
return
end
self.data[tostring(guid)]=data

self:markPosInfo(data)
table.checkCreateSubTable(self.lookup,{world,block})
table.insert(self.lookup[world][block],guid)

if overTime>0 then
worldResPointBaseModel:addTimeData(guid,overTime)
end

self:checkAddCatchLingShouResData(data)

return data
end

function worldResPointDataModel:markPosInfo(data)

local world=data.world
local block=data.block
local template=data.template
local subData=data.datas
local guid=data.guid
local fix=data.fix
local fix2=data.fix2
local task=data.task
local tempalteCfg=cfgHelper.get1(cfg_worldrestemplatedataconfig_get,template)
local offsets={}
local needRePos=false
for subIndex,temp in pairs(subData)do
local subCfg=tempalteCfg.data[subIndex]
local offset=subCfg[3]
table.insert(offsets,{offset[1],offset[2]})

local posData=worldPositionLibrary:getData(guid,subIndex)
if not posData or posData.world~=world then
needRePos=true
break
else
local v3,block=worldPositionConfig:getPosition(posData.world,{posData.x,posData.z})
if v3~=Vector3.zero then
temp.x=posData.x
temp.z=posData.z
temp.flip=posData.flip
else
needRePos=true
break
end
end
end

if needRePos then
worldPositionLibrary:eraseDatas(guid)

local x=0
local z=0
local valid=false
if fix>0 then
local fixCfg=cfgHelper.get2(cfg_worldresfixdataconfig_get,world,block)
local fixInfo=fixCfg.point[fix]
x=fixInfo[2]
z=fixInfo[3]
valid=true
elseif fix2>0 then
local randomCfg=cfgHelper.get2(cfg_worldresrandompointconfig_get,world,block)
local library=randomCfg.fixed
local fixInfo=library[fix2]
x=fixInfo[1]
z=fixInfo[2]
valid=true
else
local randomCfg=cfgHelper.get2(cfg_worldresrandompointconfig_get,world,block)
local library=randomCfg.random
local check,list=worldPositionLibrary:extract(library,1,true,offsets)
if check and list[1]then
local temp=list[1]
x=temp.x
z=temp.z
valid=true
else
loggerUtil.logErrFMT("随机位置资源点分配位置失败 {0}, {1}",world,block)
end
end
if valid then
for subIndex,subData in pairs(subData)do
local subCfg=tempalteCfg.data[subIndex]
local offset=subCfg[3]
local flip=offset[3]==nil and true or offset[3]
local sx=x+offset[1]
local sz=z+offset[2]
worldPositionLibrary:markData(world,sx,sz,flip,eWorldUnitTpye.RESPOINT,guid,subIndex)

subData.x=sx
subData.z=sz
subData.flip=flip
end
end
end
end

function worldResPointDataModel:getPointData(guid)
return self.data[tostring(guid)]
end

function worldResPointDataModel:getPointSubData(guid,subIndex)
local data=self:getPointData(guid)
if data then
return data.datas[subIndex]
end
end

function worldResPointDataModel:clearPointData(guid,withPos)
local data=self:getPointData(guid)
if data then
if withPos then
for subIdx,subData in pairs(data.datas)do
worldPositionLibrary:eraseData(guid,subIdx)
end
end
self.data[tostring(guid)]=nil
table.removeValueEx(self.lookup[data.world][data.block],guid,function(value)return tostring(value)end)

worldResPointBaseModel:removeTimeData(guid)
self:removeCatchLingShouResData(guid)

end
end

function worldResPointDataModel:getWorldGuids(world)
return self.lookup[world]
end

function worldResPointDataModel:findWorldGuidList(world)
local datas=self:getWorldGuids(world)or{}
local list={}
for b,gList in pairs(datas)do
list=table.concatTable(list,gList)
end
return list
end

function worldResPointDataModel:getBlockGuids(world,block)
return self.lookup[world]and self.lookup[world][block]or nil
end

function worldResPointDataModel:clearWorldData(world,rePos)
if self.lookup[world]then
for block,list1 in pairs(self.lookup[world])do
for index,guid in ipairs(list1)do
if rePos then
local data=self.data[tostring(guid)]
for subIdx,subData in pairs(data.datas)do
worldPositionLibrary:eraseData(guid,subIdx)
end
end
self.data[tostring(guid)]=nil
self:removeCatchLingShouResData(guid)
end
end
self.lookup[world]=nil
end
end

function worldResPointDataModel:clearBlockData(world,block,rePos)
if self.lookup[world]and self.lookup[world][block]then
local list=self.lookup[world][block]
for index,guid in ipairs(list)do
if rePos then
local data=self.data[tostring(guid)]
for subIdx,subData in pairs(data.datas)do
worldPositionLibrary:eraseData(guid,subIndex)
end
end
self.data[tostring(guid)]=nil
self:removeCatchLingShouResData(guid)
end
self.lookup[world][block]=nil
end
end

function worldResPointDataModel:getSubPointData(guid,subIndex)
local data=self:getPointData(guid)
return data and data.datas[subIndex]or nil
end

function worldResPointDataModel:clearSubPointData(guid,subIndex)
local data=self:getPointData(guid)
if data then
data.datas[subIndex]=nil
worldPositionLibrary:eraseData(guid,subIndex)
if next(data.datas)==nil then
self:clearPointData(guid)
end
end
end

function worldResPointDataModel:setSubPointData(guid,subIndex,subType,subId)
local data=self:getPointData(guid)
if data then
local subData=data.datas[subIndex]
if subData then
subData[1]=subType
subData[2]=subId
end
end
end









function worldResPointDataModel:getSubPointPos(guid,subIndex)
local subData=self:getSubPointData(guid,subIndex)
return{subData.x,subData.z}
end

function worldResPointDataModel:getSubPointPosition(guid,subIndex)
local data=self:getPointData(guid)
local subData=data.datas[subIndex]
local posInfo={subData.x,subData.z}
local position=worldPositionConfig:getPosition(data.world,posInfo)
return position,subData.flip
end

function worldResPointDataModel:countWorldData(world)
local fixCnt=0
local taskCnt=0
local randomCnt=0
if self.lookup[world]then
for block,list1 in pairs(self.lookup[world])do
for index,guid in ipairs(list1)do
local data=self:getPointData(guid)
if data.fix>0 then
fixCnt=fixCnt+1


else
randomCnt=randomCnt+1
end
if data.task then
taskCnt=taskCnt+1
end
end
end
end
return randomCnt,fixCnt,taskCnt
end

function worldResPointDataModel.isTempldateAllMonster(template)
local cfg=cfgHelper.get(cfg_worldrestemplatedataconfig_get,template)
for i,v in ipairs(cfg.data)do
if v[1]~=eWorldResPointUnitType.Monster then
return false
end
end
return true
end

function worldResPointDataModel:get_monster_list()
local list={}
local temp={}
for guidStr,point in pairs(self.data)do
for subIdx,subData in pairs(point.datas)do
if subData[1]==eWorldResPointUnitType.Monster then
local key=FMT.fmt("{0}_{1}",tostring(guidStr),subIdx)
local rpCfg=cfgHelper.get1(cfg_worldresbattleconfig_get,subData[2])
local mgCfg=cfgHelper.get1(cfg_monstergroup_get,rpCfg.groupid)
local level=mgCfg.levelUp and point.level or mgCfg.level
temp[key]={guid=key,id=subData[2],world=point.world,level=level,mType=mgCfg.monType,}
end
end
end
for key,v in pairs(worldResPointFightModel:getAllFightResult())do
if not temp[key]then
local subId=v.subId
local rpCfg=cfgHelper.get1(cfg_worldresbattleconfig_get,subId)
local mgCfg=cfgHelper.get1(cfg_monstergroup_get,rpCfg.groupid)
local level=mgCfg.levelUp and v.level or mgCfg.level
temp[key]={guid=key,id=v.subId,world=v.world,level=level,mType=mgCfg.monType,}
end
end
for i,v in pairs(temp)do
table.insert(list,v)
end
local sortFunc=function(a,b)
return a.mType>b.mType
end
table.sort(list,sortFunc)
return list
end

function worldResPointDataModel:get_monster_data_by_id(subId)
local respointList=self:get_monster_list()
for i,v in pairs(respointList)do
if subId==v.id then
return v
end
end
end

function worldResPointDataModel:findMysteryData(mysteryId)
for guidStr,data in pairs(self.data)do
for subIdx,subData in pairs(data.datas)do
local subType=subData[1]
local subId=subData[2]
if subType==eWorldResPointUnitType.Mystery then
local subCfg=cfgHelper.get1(cfg_worldresmysteryconfig_get,subId)
if subCfg.mystery==mysteryId then
return data,data.guid,subIdx
end
end
end
end
end

function worldResPointDataModel:findTaskData(taskId)
for guidStr,data in pairs(self.data)do
if data.task==taskId then
return data
end
end
end

function worldResPointDataModel:findTaskPosition(taskId)
local data=self:findTaskData(taskId)
if data then
local subIndex=next(data.datas)
if subIndex then
local position,flip=worldResPointDataModel:getSubPointPosition(data.guid,subIndex)
return position
end
end
end

function worldResPointDataModel:handleDataCorrect(data)
local removeList={}
for i,v in pairs(data.datas)do
if not self:checkSubDataCorrent(i,v,data.world,data.guid)then
table.insert(removeList,i)
end
end
for i,v in ipairs(removeList)do
local subData=data.datas[v]
local subType=subData[1]
local subId=subData[2]
loggerUtil.warn(FMT.fmt("初始化数据纠正<资源点>:相关系统已不存在对应数据,强制清理 {0} ({1}-{2}-{3}）",serializeHelper.serialize(data),v,subType,subId))


local unitKey=worldResPointBaseModel:convertUnitKey(data.guid,v)
local targetKey=unitKey
if subType==eWorldResPointUnitType.Mystery then
local cfg=cfgHelper.get1(cfg_worldresmysteryconfig_get,subId)
local mystery=cfg.mystery
targetKey=worldModel:convertUnitKey({eWorldUnitTpye.MYSTERY,mystery})
end

local taskKeys=worldTaskModel:findAllTaskKey_ByTarget(targetKey)
for j,w in ipairs(taskKeys)do
local task=worldTaskModel:getTask(w)
if task.progress_state<=eWorldTripProgress.Work then
worldTaskController:returnMission(w)
worldHUDModel:UpdateHUDByKey(unitKey)
end
end

data.datas[v]=nil
end
return next(data.datas)~=nil
end

function worldResPointDataModel:checkSubDataCorrent(subIdx,subData,world,guid)
local subType=subData[1]
local subId=subData[2]
if subType==eWorldResPointUnitType.Mystery then
local cfg=cfgHelper.get1(cfg_worldresmysteryconfig_get,subId)
local mystery=cfg.mystery
return MysteryModel:get_mysteryFB_list_data_fbid(mystery)~=nil




end
return true
end

function worldResPointDataModel:checkAddCatchLingShouResData(data)
if data.template>1000 and data.template<=2000 then
self.data_ls[tostring(data.guid)]=data
table.checkCreateSubTable(self.lookup_ls,{data.world})
table.insert(self.lookup_ls[data.world],data.guid)
end
end

function worldResPointDataModel:removeCatchLingShouResData(guid)
if self.data_ls==nil then return end
local data=self.data_ls[tostring(guid)]
if data==nil then return end
table.removeValueEx(self.lookup_ls[data.world],guid,function(value)return tostring(value)end)
self.data_ls[tostring(guid)]=nil

UIManager:invokeUIMethod('UIWorldWin','refreshEventWin_ls')
end

function worldResPointDataModel:getLingShouCatchData(guid)
return self.data_ls[tostring(guid)]
end

function worldResPointDataModel:getLingShouCatchResDataList(world)

local unlockList={}

if self.lookup_ls[world]then
for index,guid in ipairs(self.lookup_ls[world])do
local data=self.data_ls[tostring(guid)]
local state=worldBlockModel:getBlockState(data.world,data.block)
if state==worldBlockModel.BLOCKSTATE.OPEN then
table.insert(unlockList,guid)
end
end
end

return unlockList
end

function worldResPointDataModel:getNextCatchLingShouResData()
for guid,data in pairs(self.data_ls)do
local state=worldBlockModel:getBlockState(data.world,data.block)
if state==worldBlockModel.BLOCKSTATE.OPEN then
return guid,data
end
end
end

function worldResPointDataModel:getCatchLingShouResNum()
local num=0
for index,data in pairs(self.data_ls)do
local state=worldBlockModel:getBlockState(data.world,data.block)
if state==worldBlockModel.BLOCKSTATE.OPEN then
num=num+1
end
end

return num
end

