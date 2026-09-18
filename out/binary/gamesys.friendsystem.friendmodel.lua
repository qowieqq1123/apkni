







friendModel={}

friendModel.data={}




function friendModel.get_config()
local config=cfg_friendbaseconfig_get(1)
return config
end


function friendModel.get_local_limit()
local config=friendModel.get_config()
return config.localServerMax
end


function friendModel.get_cross_limit()
local config=friendModel.get_config()
return config.crossServerMax
end


function friendModel.get_black_limit()
local config=friendModel.get_config()
return config.blacklistMax
end


function friendModel.get_friend_point_limit()
local config=friendModel.get_config()
return config.friendship[3]
end


function friendModel.get_give_point_limit()
local config=friendModel.get_config()
return config.friendship[4]
end



function friendModel:init_data()
self.data=
{

localList={},
crossList={},
blackList={},
applyList={},
addableList={},

friendPoint=0,
givePoint=0,
}
end


function friendModel.getFriendList()
local dataList=friendModel:getList(eFriendDataType.eLocal)
local crossList=friendModel:getList(eFriendDataType.eCross)

local tempList={}
local tempOfflineList={}
local insert=function(v,flag)
local temp={}
temp.actorId=v.actorId
temp.actorName=v.playerName
temp.actorLevel=v.zmLevel
temp.serverId=playerModel:getActorServerID()




temp.iconInfo=v.iconInfo
temp.offline=v.offline

if v.offline==0 then

tempList[#tempList+1]=temp
else

tempOfflineList[#tempOfflineList+1]=temp
end
end
for i,v in ipairs(dataList)do
insert(v,true)
end
for i,v in ipairs(crossList)do
insert(v,false)
end


for i,v in ipairs(tempOfflineList)do
tempList[#tempList+1]=v
end

return tempList
end


function friendModel:getActorInfo(actorId)
local data

data=friendModel:getFromList(eFriendDataType.eLocal,actorId)
if data then
return data,eFriendDataType.eLocal
end

data=friendModel:getFromList(eFriendDataType.eCross,actorId)
if data then
return data,eFriendDataType.eCross
end

data=friendModel:getFromList(eFriendDataType.eApply,actorId)
if data then
return data,eFriendDataType.eApply
end

data=friendModel:getFromList(eFriendDataType.eAddable,actorId)
if data then
return data,eFriendDataType.eAddable
end

data=friendModel:getFromList(eFriendDataType.eBlack,actorId)
if data then
return data,eFriendDataType.eBlack
end
end

function friendModel:getFriendInfo(actorId)
local data=friendModel:getFromList(eFriendDataType.eLocal,actorId)
if data==nil then
data=friendModel:getFromList(eFriendDataType.eCross,actorId)
end
return data
end






function friendModel:addToList(dataType,friend,isFromLocal)
local data

if not isFromLocal then
data=
{
actorId=friend.actorId,





iconInfo=friend.iconInfo,
zmLevel=friend.zmLevel,
zmName=friend.zmName,
playerName=friend.playerName,
guildName=friend.guildName,
crossServerName=friend.crossServerName,
offline=friend.offlineTime,
pointButton=friend.zsButton,
fight=tonumber(tostring(friend.fightForce)),
sqFlag=friend.sqFlag,
serverid=friend.serverId or 0,
}
else
data=friend
end


local count=#self.data[dataType]
self.data[dataType][count+1]=data
end

function friendModel:addToListEx(dataType,data)
if data==nil then return end
local list=self.data[dataType]
if list==nil then
list={}
self.data[dataType]=list
end
local f=nil
for i,v in ipairs(list)do
if mathHelper.compareInt64(v.actorId,data.actorId)then
f=i
break
end
end
if f then
list[f]=data
else
table.insert(list,data)
end
end


function friendModel:removeFromList(dataType,actorId)
local list=self.data[dataType]
if list==nil then return end
for i,v in pairs(list)do
if mathHelper.compareInt64(v.actorId,actorId)then
table.remove(list,i)
break
end
end
end


function friendModel:removeListFromList(dataType,actorIdList)
local list=self.data[dataType]
if list==nil then return end
local actorIdList_lookup={}
for i,v in ipairs(actorIdList)do
local actorIdStr=tostring(v)
actorIdList_lookup[actorIdStr]=true
end

local tmpList={}
for i,v in pairs(list)do
local actorIdStr=tostring(v.actorId)
if not actorIdList_lookup[actorIdStr]then
table.insert(tmpList,v)
end
end

self.data[dataType]=tmpList
end


function friendModel:getFromList(dataType,actorId)
local list=self.data[dataType]
if list~=nil then
for i,v in pairs(self.data[dataType])do
if mathHelper.compareInt64(v.actorId,actorId)then
return v
end
end
end
return nil
end


function friendModel:setOffline(actorId,offline)

local dataType=eFriendDataType.eLocal
local data=friendModel:getFromList(dataType,actorId)

if not data then

dataType=eFriendDataType.eCross
data=friendModel:getFromList(dataType,actorId)
end

if not data then
return
end

data.offline=offline
end


function friendModel:setSqFlagByPlayIdList(playerIdList)
for i,v in ipairs(playerIdList)do
local data=friendModel:getFromList(eFriendDataType.eAddable,v)
if data then
data.sqFlag=1
end
end
end







function friendModel:setList(dataType,friendList)
self:clearListByType(dataType)
if not friendList then
return
end
for i,v in pairs(friendList)do
self:addToList(dataType,v)
end
end


function friendModel:getList(dataType)
return self.data[dataType]
end


function friendModel:getSortList(List)
local t={}
local time=timeHelper.getServerShortTime()
for i,v in ipairs(List)do
v.sortflag=10000000
if v.offline~=0 then
v.sortflag=v.sortflag-(time-v.offline)
end
if v.zmLevel then
v.sortflag=v.sortflag+v.zmLevel
end
table.insert(t,v)
end
table.sort(t,function(a,b)return a.sortflag>b.sortflag end)
return t
end


function friendModel:getSortList_remove(List)
local t={}
local time=timeHelper.getServerShortTime()
for i,v in ipairs(List)do
v.sortflag=0
if v.offline~=0 then
v.sortflag=v.sortflag+(time-v.offline)*100
end
if v.zmLevel then
v.sortflag=v.sortflag+v.zmLevel
end
table.insert(t,v)
end
table.sort(t,function(a,b)return a.sortflag>b.sortflag end)
return t
end


function friendModel:clearListByType(dataType)
self.data[dataType]={}
end

function friendModel:clearList()
for _,dataType in ipairs(eFriendListType)do
self.data[dataType]={}
end
end




function friendModel:setFriendPoint(friendPoint)
self.data.friendPoint=friendPoint
end


function friendModel:getFriendPoint()
return self.data.friendPoint
end


function friendModel:isFriendPointLimit(isWarning)
if self.data.friendPoint>=friendModel.get_friend_point_limit()then
if isWarning then
UIManager.error("达到已领取友情点数上限")
end
return true
end
return false
end


function friendModel:hasGivedFriendPoint(isWarning)
local dataList=friendModel:getList(eFriendDataType.eLocal)
for i,v in pairs(dataList)do
if v.pointButton==2 then
return true
end
end
if isWarning then
UIManager.error("暂无仙友点数可领取")
end
return false
end



function friendModel:hasGivedFriend(isWarning)
local dataList=friendModel:getList(eFriendDataType.eLocal)
for i,v in pairs(dataList)do
if v.pointButton==1 then
return true
end
end
if isWarning then
UIManager.error("当前无可赠送的仙友")
end
return false
end




function friendModel:setGivePoint(friendPoint)
self.data.givePoint=friendPoint
end


function friendModel:getGivePoint()
return self.data.givePoint
end


function friendModel:isGivePointLimit(isWarning)
if self.data.givePoint>=friendModel.get_give_point_limit()then
if isWarning then
UIManager.error("达到已赠送友情点数上限")
end
return true
end
return false
end




function friendModel:hasApply()
return#self.data.applyList>0
end

function friendModel:isOnline(dataType,actorId)
local friendInfo=friendModel:getFromList(dataType,actorId)
if friendInfo==nil then return nil end
return friendInfo.offline==0
end

function friendModel:hasSub1Reddot()

return false
end

function friendModel:isFriend(actorId)
local data=friendModel:getFriendInfo(actorId)
return data~=nil
end

function friendModel:canAddFriend(actorId)
return not friendModel:isBlack(actorId)and not friendModel:isFriend(actorId)
end

function friendModel:isBlack(actorId)
local data=friendModel:getFromList(eFriendDataType.eBlack,actorId)
return data~=nil
end

function friendModel:isBlackMax()
local list=self:getList(eFriendDataType.eBlack)
return#list>=self.get_black_limit()
end

function friendModel:isLocalMax()
local list=self:getList(eFriendDataType.eLocal)
return#list>=self.get_local_limit()
end

function friendModel:isCrossMax()
local list=self:getList(eFriendDataType.eCross)
return#list>=self.get_cross_limit()
end


