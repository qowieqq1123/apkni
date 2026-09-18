





function zhengzhanshanhaiModel:onEnterState_Rank(isReconnect)
notifySystem:listenNotify(notifyConfig.onXianMengLevelChange,self.onXianMengLevelChange)
end

function zhengzhanshanhaiModel:onLeaveState_Rank(isReconnet)
notifySystem:removelistener(notifyConfig.onXianMengLevelChange,self.onXianMengLevelChange)

self.isRecvRankInfo=nil
self.rankLen_ZZSH=nil
self.rankList_ZZSH=nil

self.rankList_Rank_LookUp_ZZSH=nil
self.rankList_Info_LookUp_ZZSH=nil
self.selfRankIndex_ZZSH=nil
end


local sort_RankList=function(self)
if self.rankLen_ZZSH<2 then return end
table.sort(self.rankList_ZZSH,function(a,b)
return a.score>b.score
end)
end

local lookup_RankList_Rank=function(self)
self.rankList_Rank_LookUp_ZZSH={}
if self.rankLen_ZZSH==0 then return end
local rankCfgs=zhengzhanshanhaiController.getRankeCfg_ZZSH_Rank()

local xmIndex=1
local rankInfo
for rankIndex,rankCfg in ipairs(rankCfgs)do
rankInfo=self.rankList_ZZSH[xmIndex]
if rankInfo.score>=rankCfg.min_score then
self.rankList_Rank_LookUp_ZZSH[rankIndex]=rankInfo
xmIndex=xmIndex+1
end

if xmIndex>self.rankLen_ZZSH then
break
end
end
end

local lookup_RankList_Info=function(self)
self.rankList_Info_LookUp_ZZSH={}
if self.rankLen_ZZSH==0 then return end
for index,rankInfo in ipairs(self.rankList_ZZSH)do
self.rankList_Info_LookUp_ZZSH[tostring(rankInfo.guildid)]=rankInfo
end
end

local lock_SelfRankIndex=function(self)
if self.rankLen_ZZSH==0 then return end
local selfGuildInfo=xianmengModel:getXMDetialData()

if selfGuildInfo==nil then return end
if self.rankList_Rank_LookUp_ZZSH==nil then return end

local selfGuildId=selfGuildInfo.guildid
local selfGuildIdStr=tostring(selfGuildId)

for rankIndex,rankInfo in pairs(self.rankList_Rank_LookUp_ZZSH)do
if tostring(rankInfo.guildid)==selfGuildIdStr then
self.selfRankIndex_ZZSH=rankIndex
break
end
end
end

local deal_Rank=function(rankInfo)

rankInfo.xmImg=xianmengModel.splitGuildIcon(rankInfo.guildicon)
end

local deal_RankList=function(self)
if self.rankLen_ZZSH<=0 then return end

for index,rankInfo in ipairs(self.rankList_ZZSH)do
deal_Rank(rankInfo)
end
end

local del_ErrData=function(self)
if self.rankLen_ZZSH<=0 then return end

local mTemp={}
for index,rankInfo in ipairs(self.rankList_ZZSH)do
if mathHelper.validInt64(rankInfo.guildicon)then
mTemp[#mTemp+1]=rankInfo
end
end

self.rankList_ZZSH=mTemp
end






function zhengzhanshanhaiModel:setRankList_ZZSH(len,rankList)
self.rankLen_ZZSH=len
self.rankList_ZZSH=rankList
self.isRecvRankInfo=true

del_ErrData(self)
sort_RankList(self)
deal_RankList(self)
lookup_RankList_Rank(self)
lookup_RankList_Info(self)
lock_SelfRankIndex(self)
end



function zhengzhanshanhaiModel:getRankList_ZZSH()
return self.rankList_ZZSH,self.rankLen_ZZSH
end




function zhengzhanshanhaiModel:getRankInfoByRankIndex_ZZSH(rankIndex)
return self.rankList_Rank_LookUp_ZZSH[rankIndex]
end




function zhengzhanshanhaiModel:getRankInfoByGuildIdStr_ZZSH(guildIdStr)
return self.rankList_Info_LookUp_ZZSH[guildIdStr]
end


function zhengzhanshanhaiModel:getSelfRankIndex_ZZSH()
return self.selfRankIndex_ZZSH
end

function zhengzhanshanhaiModel:isRecvRankInfo_ZZSH()
return self.isRecvRankInfo
end




function zhengzhanshanhaiModel.onXianMengLevelChange()
lock_SelfRankIndex(zhengzhanshanhaiModel)
end