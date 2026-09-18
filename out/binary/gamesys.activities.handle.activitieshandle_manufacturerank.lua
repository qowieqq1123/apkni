







activitiesHandle_manufactureRank=new_activitiesHandle('activitiesHandle_manufactureRank',activitiesHandle)

function activitiesHandle_manufactureRank:onInit()

end


function activitiesHandle_manufactureRank.recv_249_30(actId,subId,len,manufactureList)
local subType=SUB_ACTIVITY_TYPE.eBigShengChanRank
local rankFirstList={}
manufactureList=manufactureList or{}
for i=1,len do
local listItem=manufactureList[i]
local rankItemId=listItem.itemId

rankFirstList[rankItemId]=listItem
end


local config=activitiesModel:getSubActivityConfig(subType,subId)
local rankListCfg=config.rankList
for i=1,#rankListCfg do
local rankCfg=rankListCfg[i]
local rankItemId=rankCfg[2]
if not rankFirstList[rankItemId]then

local emptyData=
{
itemId=rankItemId,
topPlayerId=int64.zero,
topName="",
topZmName="",
topIcon=0,
topShengChanNum=int64.zero,
myShengChanNum=int64.zero,
myRank=0,
}
rankFirstList[rankItemId]=emptyData
end
end

local data=activitiesModel:getSubActInfoData(actId,subType,subId)
if not data then

return
end

data.rankFirstList=rankFirstList

if not data.isInitConfig then

local model=activitiesModel:getSubActInfo(actId,subType,subId)
model:initConfigList_sort()
end

activitiesModel:setSubActInfoData(actId,subType,subId,data)

UIManager:invokeUIMethod('UISubAct_manufactureRank_mainWin','refresh')
UIManager:invokeUIMethod('UISubAct_manufactureRank_rankWin','refresh')

end


function activitiesHandle_manufactureRank.recv_249_43(actId,subId,itemId,len,rankList)
local subType=SUB_ACTIVITY_TYPE.eBigShengChanRank

local data=activitiesModel:getSubActInfoData(actId,subType,subId)
if not data.manufactureRankList then
data.manufactureRankList={}
end

data.manufactureRankList[itemId]=rankList


UIManager:invokeUIMethod('UISubAct_manufactureRank_rankWin','refresh')
end