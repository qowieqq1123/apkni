









local subActivityInfo_crossranking={name='crossranking'}
function subActivityInfo_crossranking:onInit()

self.isPostStateChange=false
end

function subActivityInfo_crossranking:onStart()

end

function subActivityInfo_crossranking:onUpdate()
if not self.data then return end

if self.isPostStateChange then return end

if self:getEndLeftTime()<=0 then
notifySystem:postNotify(notifyConfig.onSubActivityFlagChange,self.act_id,SUB_ACTIVITY_TYPE.eRankActCross,self.sub_act_id)
self.isPostStateChange=true
end
end

function subActivityInfo_crossranking:onDelete()

end

function subActivityInfo_crossranking:checkReddot()
if not self.data then

return false
end
local reddot=self:checkDailyReward()
return reddot
end



function subActivityInfo_crossranking:checkNewDay()





end

function subActivityInfo_crossranking:getEndLeftTime()
local lerp=0
local realDuration=self:getSubActConfig('duration')
local duration=self.end_time-self.start_time
if not self:checkFinish()then
local cur=timeHelper.getServerShortTime()
if duration>realDuration then
lerp=(self.start_time+realDuration)-cur
if lerp<=0 then
lerp=0
end
else
lerp=self.end_time-cur
end
end
return lerp
end

local initRankLookup=function(data,rankRewardList,mergeRule)
local limitRank=mergeRule[1]
local showLen=mergeRule[2]

local infList={}
for index,rankRewardData in ipairs(rankRewardList)do
local sIndex=rankRewardData[1]
local eIndex=rankRewardData[2]
local reward=rankRewardData[3]
local upRankMinVal=rankRewardData[4]

local isMultiple=eIndex-sIndex>0

local temp={
index=index,
range={sIndex,eIndex},
rankPlayerList={},
rankPlayerLen=0,
showNum=1,
reward=reward,
upRankMinVal=upRankMinVal,
isMutiple=isMultiple
}

if sIndex<limitRank then
for fIndex=sIndex,eIndex do
temp.range={fIndex,fIndex}
infList[fIndex]=table.deepCopy(temp)
end
else
temp.showNum=showLen
infList[#infList+1]=temp
end
end

return infList
end

function subActivityInfo_crossranking:initRankRewardLookup()
local zsRankNum=self:getSubActConfig("rankNum")

local isShowZSRank=zsRankNum>0

local data=self:getData()or{}

if isShowZSRank then
local rankRewardList=self:getSubActConfig("rank")
local mergeRule=self:getSubActConfig("merge_rule")
data.zsRankItemInfoLookup=initRankLookup(data,rankRewardList,mergeRule)
end

self:setData(data)
end

function subActivityInfo_crossranking:initRankRewardLookup2()
local xmRankNum=self:getSubActConfig("rankNum2")

local isShowXMRank=xmRankNum>0

local data=self:getData()or{}

if isShowXMRank then
local rankRewardList=self:getSubActConfig("rank2")
local mergeRule=self:getSubActConfig("merge_rule")
data.xmRankItemInfoLookup=initRankLookup(data,rankRewardList,mergeRule)
end

self:setData(data)
end


function subActivityInfo_crossranking:checkRealFinish()

local result=self:getEndLeftTime()<=0

return result
end


function subActivityInfo_crossranking:checkDailyReward()
local giftid=self:getSubActConfig("free_gift_id")
if giftid~=nil then
local baseData={self.act_id,self.sub_act_type,self.sub_act_id}
return FreeGiftModel:IsCanGetGift(giftid,FreeGiftType.kuafu,baseData)
end
return false
end


return subActivityInfo_crossranking