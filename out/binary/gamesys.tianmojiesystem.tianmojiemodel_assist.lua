
local _playerAssist={}











local _monsterAssist={}

local _sortPlayerAssist=function(a,b)
if a.sec~=b.sec then
return a.sec>b.sec
elseif a.percent~=b.percent then
return a.percent>b.percent
else
return a.actorid>b.actorid
end
end

local _sortMonsterAssist=function(a,b)
if a.percent~=b.percent then
return a.percent>b.percent
else
return a.actorid>b.actorid
end
end

function tianMoJieModel:setMonsterAssists(actorId,monsterGuid,assistList)
assistList=assistList or{}
local idStr=tostring(actorId)
local actorData=_monsterAssist[idStr]
if actorData==nil then
actorData={}
_monsterAssist[idStr]=actorData
end
local guidStr=tostring(monsterGuid)
actorData[guidStr]=assistList
if#assistList>1 then
table.sort(assistList,_sortMonsterAssist)
end
end

function tianMoJieModel:getMonsterAssists(actorId,monsterGuid)
local idStr=tostring(actorId)
local actorData=_monsterAssist[idStr]
if actorData==nil then
actorData={}
_monsterAssist[idStr]=actorData
end
local guidStr=tostring(monsterGuid)
return actorData[guidStr]or{}
end

function tianMoJieModel:clearMonsterAssists(actorId,monsterGuid)
local idStr=tostring(actorId)
local actorData=_monsterAssist[idStr]
if actorData==nil then
actorData={}
_monsterAssist[idStr]=actorData
end
local guidStr=tostring(monsterGuid)
actorData[guidStr]=nil
end

function tianMoJieModel:resetMonsterAssists()
table.clear(_monsterAssist)
end

function tianMoJieModel:setPlayerAssists(assistList)
assistList=assistList or{}
_playerAssist=assistList
if#assistList>1 then
table.sort(_playerAssist,self.sortPlayerAssist)
end
end

function tianMoJieModel.sortPlayerAssist(a,b)
return a.sec>b.sec
end

function tianMoJieModel:getPlayerAssists()
return _playerAssist
end

function tianMoJieModel:resetPlayerAssists()
table.clear(_playerAssist)
end