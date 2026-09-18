





chatRecentModel={}

local _recentList={}
local _recentLookup={}

function chatRecentModel.init()
_recentList={}
_recentLookup={}
end


function chatRecentModel.setRecentInfo(chatInfo)
local actorId=chatInfo.actorId
if actorId==nil then return end
local idStr=tostring(actorId)
if playerModel:checkActorId(actorId)then return false end
if _recentLookup[idStr]then return end
_recentList[#_recentList+1]=chatInfo
_recentLookup[idStr]=#_recentList
return true
end

function chatRecentModel.sortAllChatData(list)
local sortTag={}

local func=function(data)
return chatControl.getNewestMesgStampByPlayer(data.actorId)
end

local idxLookup,maxlen=sortHelper.getSortLookup(list,func)

for i,v in ipairs(list)do
local actorId=v.actorId
local idStr=tostring(actorId)
local hasTag=chatControl.hasNewMesgByPlayer(actorId)and 1 or 0
local stamp=func(v)
local stampTag=idxLookup[stamp]
sortTag[idStr]=hasTag*maxlen*10+
stampTag+
-0.00001*i
end
if#list>1 then
table.sort(list,function(a,b)
return sortTag[tostring(a.actorId)]>sortTag[tostring(b.actorId)]
end)
end
end

function chatRecentModel.freshAllIdx()
_recentLookup={}
for i,chatInfo in ipairs(_recentList)do
local actorId=chatInfo.actorId
local idStr=tostring(actorId)
_recentLookup[idStr]=i
end
end

function chatRecentModel.getIdx(actorId)
local idStr=tostring(actorId)
return _recentLookup[idStr]
end

function chatRecentModel.getRecentList(sort)
if sort then
chatRecentModel.sortAllChatData(_recentList)
end
return _recentList
end

function chatRecentModel.isTop(actorId)
return chatRecentModel.getIdx(actorId)==1
end

function chatRecentModel.getTop()
return _recentList[1]
end

function chatRecentModel.setTop(actorId)
if chatRecentModel.isTop(actorId)then return false end
local idStr=tostring(actorId)
local idx=_recentLookup[idStr]
if idx then
local chatInfo=_recentList[idx]
if tostring(chatInfo.actorId)==idStr then
table.remove(_recentList,idx)
else
for i,v in ipairs(_recentList)do
if tostring(v.actorId)==idStr then
table.remove(_recentList,i)
chatInfo=v
break
end
end
end
table.insert(_recentList,1,chatInfo)
_recentLookup={}
for i,v in ipairs(_recentList)do
_recentLookup[tostring(v.actorId)]=i
end
return true
end
return false
end

function chatRecentModel.delete(actorId)
local idStr=tostring(actorId)
local idx=_recentLookup[idStr]
if idx then
local flag=false
local chatInfo=_recentList[idx]
if tostring(chatInfo.actorId)==idStr then
table.remove(_recentList,idx)
flag=true
else
for i,v in ipairs(_recentList)do
if tostring(v.actorId)==idStr then
table.remove(_recentList,i)
flag=true
break
end
end
end
if flag then

_recentLookup={}
for i,v in ipairs(_recentList)do
_recentLookup[tostring(v.actorId)]=i
end
return true
end
end
return false
end