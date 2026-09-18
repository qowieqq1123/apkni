















local _monsters={}









local _positions={}

local _fight={}

local _dump={}

function tianMoJieModel:printAllMonsterData()

end

function tianMoJieModel:resetMonsterData()
table.clear(_monsters)
table.clear(_positions)
table.clear(_dump)
end

function tianMoJieModel:getMonster(actorId,monsterGuid,includeDump)
local monsters=self:getMonstersByActor(actorId)
local str=tostring(monsterGuid)
local data=monsters[str]
if data then
return data
end
if includeDump then
return self:getDumpData(actorId,monsterGuid)
end
end

function tianMoJieModel:clearMonster(actorId,monsterGuid,dump)
local monsters=self:getMonstersByActor(actorId)
local str=tostring(monsterGuid)
local data=monsters[str]
monsters[str]=nil
if dump then
self:addDumpData(actorId,monsterGuid,data)
else
self:clearPosition(actorId,data.position[1],data.position[2])
end
end

function tianMoJieModel:clearDumpDataByActor(actorId)
actorId=actorId or playerModel:getActorID()
local key=tostring(actorId)
if _dump[key]then
table.clear(_dump[key])
end
end

function tianMoJieModel:addDumpData(actorId,monsterGuid,data)
local key=tostring(actorId)
local list=_dump[key]
if not list then
list={}
_dump[key]=list
end
key=tostring(monsterGuid)
list[key]=data
end

function tianMoJieModel:deleteDumpData(actorId,monsterGuid)
local key=tostring(actorId)
local list=_dump[key]
if not list then
return
end
key=tostring(monsterGuid)
local data=list[key]
if data then
self:clearPosition(actorId,data.position[1],data.position[2])
end
list[key]=nil
end

function tianMoJieModel:getDumpData(actorId,monsterGuid)
local key=tostring(actorId)
local list=_dump[key]
if not list then
return
end
key=tostring(monsterGuid)
local data=list[key]
return data
end

function tianMoJieModel:isDumpData(actorId,monsterGuid)
return self:getDumpData(actorId,monsterGuid)~=nil
end

function tianMoJieModel:setMonsterByServerData(actorId,tmjTM,stage)

local list=self:getMonstersByActor(actorId)
local key=tostring(tmjTM.tmguid)
local data=list[key]
if data==nil then
data={}
list[key]=data


local fix=cfgHelper.get2(cfg_tianmojiebaseconfig_get,1,"fixPos")
local pos=nil
if fix and fix[tmjTM.tmguid]then
pos=fix[tmjTM.tmguid]
else
local lib=cfgHelper.get2(cfg_tianmojiestageconfig_get,stage,"pos")
pos=self:randomPosition(actorId,lib)
end
if pos then
data.position=pos
self:recordPosition(actorId,pos[1],pos[2])
else
loggerUtil.logErrFMT("没有找到天魔劫怪物位置：{0}, {1}",tmjTM.tmguid,stage)
end
end
data.guid=tmjTM.tmguid
data.id=tmjTM.tmid
data.since=tmjTM.sec
data.percent=tmjTM.percent
data.actor=actorId
end

function tianMoJieModel:getMonstersByActor(actorId)
local str=tostring(actorId)
local list=_monsters[str]
if list==nil then
list={}
_monsters[str]=list
end
return list
end

function tianMoJieModel:haveMonsterByActor(actorId)
local list=self:getMonstersByActor(actorId)
return next(list)~=nil
end

function tianMoJieModel:haveMonsterBySelf()
local actorId=playerModel:getActorID()
return self:haveMonsterByActor(actorId)
end

function tianMoJieModel:setMonstersByActor(actorId,tmjTMList,stage)
if#tmjTMList>1 then
table.sort(tmjTMList,function(a,b)
return a.tmguid<b.tmguid
end)
end

local news={}
for i,v in ipairs(tmjTMList)do
local key=tostring(v.tmguid)
news[key]=true
end
local list=self:getMonstersByActor(actorId)
for guidStr,data in pairs(list)do
if not news[guidStr]then
self:clearMonster(actorId,data.guid)
end
end
local config=cfgHelper.get1(cfg_tianmojiestageconfig_get,stage)
if config then
for i,v in ipairs(tmjTMList)do
self:setMonsterByServerData(actorId,v,stage)
end
end
end









function tianMoJieModel:updateMonsterPercent(monsterGuid,percent,actorId)
local actorId=actorId or playerModel:getActorID()
local data=self:getMonster(actorId,monsterGuid)
if data then
if percent>0 then
data.percent=percent
else




self:clearMonster(actorId,monsterGuid,true)
end
end
end

function tianMoJieModel:getPositions(actorId)
local str=tostring(actorId)
local list=_positions[str]
if list==nil then
list={}
_positions[str]=list
end
return list
end

function tianMoJieModel:clearPosition(actorId,x,y)
local list=self:getPositions(actorId)
local key=FMT.fmt("{0}_{1}",x,y)
list[key]=nil
end

function tianMoJieModel:havePosition(actorId,x,y)
local list=self:getPositions(actorId)
local key=FMT.fmt("{0}_{1}",x,y)
return list[key]or false
end

function tianMoJieModel:recordPosition(actorId,x,y)
local list=self:getPositions(actorId)
local key=FMT.fmt("{0}_{1}",x,y)
list[key]=true
end

function tianMoJieModel:randomPosition(actorId,lib)
local count=#lib
local sIdx=math.random(1,count)
for i=1,count do
local index=sIdx+i
index=index>count and(index-count)or index
local info=lib[index]
if not self:havePosition(actorId,info[1],info[2])then
return info
end
end
end

function tianMoJieModel:pushFightData(result,log,data)
_fight={
result=result,
log=log,
data=data,
}
end

function tianMoJieModel:popFightData()
local temp=_fight
_fight=nil
return temp
end
