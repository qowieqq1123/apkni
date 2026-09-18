
activitiesHandle_crossranking=new_activitiesHandle('activitiesHandle_crossranking',activitiesHandle)


local CSTotalRnakingList=function(data)

local myActorId=playerModel:getActorID()

local zsRankData=data.zsRankData

local totalRankList=zsRankData.totalRankList

local lookup=data.zsRankItemInfoLookup

local fillIndex=1
for index=1,#(lookup or{})do

local rankItemData=lookup[index]
if index==rankItemData.range[1]then
rankItemData.rankPlayerList={}
rankItemData.rankPlayerLen=0
end

local sIndex=rankItemData.range[1]
local eIndex=rankItemData.range[2]
local upRankMinVal=rankItemData.upRankMinVal

for tIndex=sIndex,eIndex do
local rankData=totalRankList[fillIndex]
if rankData then
if rankData.score>=upRankMinVal then
if rankItemData.rankPlayerLen<5 then
rankItemData.rankPlayerList[#rankItemData.rankPlayerList+1]=rankData
rankItemData.rankPlayerLen=rankItemData.rankPlayerLen+1
end
fillIndex=fillIndex+1


if mathHelper.compareInt64(rankData.actorid,myActorId)then
zsRankData.myRank=tIndex
zsRankData.myScore=rankData.score
zsRankData.myRewardIndex=index
end
end
else

break
end
end
end

return data
end

local CSTotalRnakingList2=function(data)

local myXMGuildID=xianmengModel:myXMGuildID()

local zsRankData=data.xmRankData

local totalRankList=zsRankData.totalRankList

local lookup=data.xmRankItemInfoLookup

local fillIndex=1
for index=1,#(lookup or{})do

local rankItemData=lookup[index]
if index==rankItemData.range[1]then
rankItemData.rankPlayerList={}
rankItemData.rankPlayerLen=0
end

local sIndex=rankItemData.range[1]
local eIndex=rankItemData.range[2]
local upRankMinVal_Int64=int64.new(rankItemData.upRankMinVal)

for tIndex=sIndex,eIndex do
local rankData=totalRankList[fillIndex]
if rankData then
local isNoDel=rankData.xmIcon~=0
if isNoDel then
if rankData.xmScore>=upRankMinVal_Int64 then
if rankItemData.rankPlayerLen<5 then
rankItemData.rankPlayerList[#rankItemData.rankPlayerList+1]=rankData
rankItemData.rankPlayerLen=rankItemData.rankPlayerLen+1
end
fillIndex=fillIndex+1


if mathHelper.compareInt64(rankData.xmGuid,myXMGuildID)then
zsRankData.myRank=tIndex
zsRankData.myScore=rankData.xmScore
zsRankData.myRewardIndex=index
end
end
end
else

break
end
end
end

return data
end




function activitiesHandle_crossranking.recv_247_3(actID,subID,totalLen,totalRankList,myScore)

local subType=SUB_ACTIVITY_TYPE.eRankActCross

activitiesModel:invokeSubActInfoMethod(actID,subType,subID,'initRankRewardLookup')

local config=activitiesModel:getSubActivityConfig(subType,subID)


if config and config.default_val then
if totalLen>0 then
for index=1,totalLen do
local data=totalRankList[index]
if data.score==0 then
data.score=config.default_val
end
end
end
myScore=myScore>0 and myScore or config.default_val
end



local data=activitiesModel:getSubActInfoData(actID,subType,subID)or{}

data.zsRankData={}
local zsRankData=data.zsRankData

data.actID=actID
data.subType=subType
data.subID=subID
zsRankData.totalLen=totalLen
zsRankData.totalRankList=totalRankList or{}
zsRankData.myRank=data.myRank or 0
zsRankData.myScore=myScore

data=CSTotalRnakingList(data)

activitiesModel:setSubActInfoData(actID,subType,subID,data)


if config.ranking_type==10 then
local win=UIManager:findActiveWindow('UILianQiMG')
if win and win.isVisible then
UIManager:callWindowFunc('UILianQiMG','handleEndGame',data)
end
end
end

function activitiesHandle_crossranking.recv_247_97(args)
local actID,subID,totalLen,totalRankList,myScore,xmRank=table.unpackEx(args)


local subType=SUB_ACTIVITY_TYPE.eRankActCross

activitiesModel:invokeSubActInfoMethod(actID,subType,subID,'initRankRewardLookup2')


local config=activitiesModel:getSubActivityConfig(subType,subID)


if config and config.default_val then
if totalLen>0 then
local default_val_int64=int64.new(config.default_val)
for index=1,totalLen do
local data=totalRankList[index]
if data.xmScore==0 then
data.xmScore=default_val_int64
end
end
end
myScore=myScore>0 and myScore or config.default_val
end

local data=activitiesModel:getSubActInfoData(actID,subType,subID)or{}

data.xmRankData={}
local xmRankData=data.xmRankData

data.actID=actID
data.subType=subType
data.subID=subID
xmRankData.totalLen=totalLen
xmRankData.totalRankList=totalRankList or{}
xmRankData.myRank=data.xmRank or 0
xmRankData.myScore=myScore

data=CSTotalRnakingList2(data)

activitiesModel:setSubActInfoData(actID,subType,subID,data)

end


























function activitiesHandle_crossranking.recv_247_60(actID,subID,len,crossIdList)
local subType=SUB_ACTIVITY_TYPE.eRankActCross

local data=activitiesModel:getSubActInfoData(actID,subType,subID)or{}

data.crossIdList=crossIdList

activitiesModel:setSubActInfoData(actID,subType,subID,data)
end
