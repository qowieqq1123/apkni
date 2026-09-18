



function myzsModel:initRankConf()
self.rankLookup={}

local group=myzsModel:getGroup()
local rank_conf=cfgHelper.get2(cfg_mingyuanzhusharankconfig_get,group,'rank_conf')

local index=1
for _,rankConfInfo in ipairs(rank_conf)do
local isSplit=rankConfInfo[4]==1

if isSplit then
for sindex=rankConfInfo[1],rankConfInfo[2]do
local temp={}
temp.rangeUp=sindex
temp.rangeDown=sindex
temp.rewardList=rankConfInfo[3]
temp.rangeInterval=1
temp.actorList={}
self.rankLookup[index]=temp

index=index+1
end
else
local temp={}
temp.rangeUp=rankConfInfo[1]
temp.rangeDown=rankConfInfo[2]
temp.rewardList=rankConfInfo[3]
temp.rangeInterval=rankConfInfo[2]-rankConfInfo[1]+1
temp.actorList={}
self.rankLookup[index]=temp
index=index+1
end
end
end

function myzsModel:clearRankActorList()
if self==nil or self.rankLookup==nil then
logErr("lose data")
return
end

for index,info in ipairs(self.rankLookup)do
table.clear(info.actorList)
end
end

function myzsModel:initRankServerData(rankList)
self.rankList=rankList or{}

self:initRankLookUp()

UIManager:invokeUIMethod("UIMingYuanZhuSha_RankInfoWin","recvRefresh")
end

function myzsModel:initRankLookUp()
self:clearRankActorList()

self.myRank=-1
self.myRankIndex=-1

local selfActorId=playerModel:getActorID()

local actorIndex=1
local rank=1
for index,info in ipairs(self.rankLookup)do
local isBreak=false
for aindex=actorIndex,info.rangeInterval do
local actor=self.rankList[rank]
if actor==nil then
isBreak=true
break
end

table.insert(info.actorList,actor)

if mathHelper.compareInt64(selfActorId,actor.actor_id)then
self.myRank=rank
self.myRankIndex=index
end
rank=rank+1
end
if isBreak then
break
end
end
end

function myzsModel:getRankLookUp()
return self.rankLookup
end

function myzsModel:getMyRank()
return self.myRank or-1,self.myRankIndex or-1
end

function myzsModel:getGroupMaxCount()
if self.rankLookup==nil or next(self.rankLookup)==nil then return 0 end

local group=myzsModel:getGroup()
local cfgs=cfgHelper.get(cfg_mingyuanzhushagroupconfig_get,group)
local maxGroupLevel=#cfgs

local count=0
for index,data in pairs(self.rankLookup)do
if next(data.actorList)~=nil then
for aindex,rankInfo in ipairs(data.actorList)do
if rankInfo.level>=maxGroupLevel then
count=count+1
end
end
end
end

return count
end