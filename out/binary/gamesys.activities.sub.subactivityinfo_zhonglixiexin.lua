









local subActivityInfo_zhonglixiexin={name='subActivityInfo_zhonglixiexin'}

function subActivityInfo_zhonglixiexin:onInit()
self:initQuesLenList()
self:initRankRewardList()
end

function subActivityInfo_zhonglixiexin:onStart()

end

function subActivityInfo_zhonglixiexin:onUpdate()

end

function subActivityInfo_zhonglixiexin:onDelete()
self.isInitQuesLenList=nil
self.quesLenList_Lookup=nil
self.isInitRankRewardList=nil
self.rankRewardList_lookup=nil
end

function subActivityInfo_zhonglixiexin:checkReddot()
local data=self.data
if data then
return self:checkRewardReddot()or self:checkQuesReddot()or self:checkRecordReddot()
end
return false
end

function subActivityInfo_zhonglixiexin:checkRewardReddot()
local data=self.data
if data and data.day then
local quesLen=self.quesLenList_Lookup[data.day]
if quesLen and data.quesLen>=quesLen and data.daily_get==0 then
return true
end
end
return false
end

function subActivityInfo_zhonglixiexin:checkQuesReddot()
local data=self.data
if data and data.day then
local quesLen=self.quesLenList_Lookup[data.day]
if quesLen and data.quesLen<quesLen then
return true
end
end
return false
end

function subActivityInfo_zhonglixiexin:checkRecordReddot()
local data=self.data
if data and data.day then
local flag=dialogueRepeatRemindModel.getRepeatVis(REPEAT_TIME_TYPE.eDay,REPEAT_TYPE.eSubZLXXRecordReddot)
return data.day>1 and not flag
end
return false
end


function subActivityInfo_zhonglixiexin:initQuesLenList()
if not self.isInitQuesLenList then
local ques_list=self:getSubActConfig('ques_list')
self.quesLenList_Lookup={}
for day,v in ipairs(ques_list)do
self.quesLenList_Lookup[day]=#v[1]
end

self.isInitQuesLenList=true
end
end


function subActivityInfo_zhonglixiexin:initRankRewardList()
if not self.isInitRankRewardList then

local rank_config=self:getSubActConfig('rank_config')
local rank_limit_len=self:getSubActConfig('reward_rank_limit_len')
self.rankRewardList_lookup={}
for i=1,#rank_config do
local startIndex=rank_config[i][1]
local endIndex=rank_config[i][2]
local rewards=rank_config[i][3]
if endIndex==-1 then
endIndex=rank_limit_len
end
for j=startIndex,endIndex do
self.rankRewardList_lookup[j]=rewards
end
end

self.isInitRankRewardList=true
end
end

function subActivityInfo_zhonglixiexin:getIsDailyGet()
local data=self.data
if data then
return data.daily_get==1
end
return false
end

function subActivityInfo_zhonglixiexin:getCurDay()
local data=self.data
if data then
return data.day
end
return nil
end

function subActivityInfo_zhonglixiexin:getCurProgress(day)
local data=self.data
if data then
day=day or data.day
local quesLen=self.quesLenList_Lookup[day]
return data.quesLen or 0,quesLen or 0
end
return 0,0
end

function subActivityInfo_zhonglixiexin:getRankList()
local data=self.data
if data then
return data.rankList
end
return nil
end

function subActivityInfo_zhonglixiexin:getRankReward(rank)
return self.rankRewardList_lookup[rank]
end

function subActivityInfo_zhonglixiexin:getRankScore(rank)
local data=self.data
if data and data.rankScoreLookup then
return data.rankScoreLookup[rank]
end
return nil
end

function subActivityInfo_zhonglixiexin:getMyScore()
local data=self.data
if data then
return data.score or 0
end
return nil
end

function subActivityInfo_zhonglixiexin:getMyRankData()
local data=self.data
if data then
return data.myRankData
end
return nil
end

function subActivityInfo_zhonglixiexin:getLastRankList()
local data=self.data
if data then
return data.lastRankList
end
return nil
end

function subActivityInfo_zhonglixiexin:getMyLastRankData()
local data=self.data
if data then
return data.myLastRankData
end
return nil
end

function subActivityInfo_zhonglixiexin:getRoleQuesCheckIdx(day,quesIdx)
local data=self.data
if data and data.roleDayCheckInfoLookup then
if not data.roleDayCheckInfoLookup[day]then
return nil
end
return data.roleDayCheckInfoLookup[day][quesIdx]
end
return nil
end

function subActivityInfo_zhonglixiexin:getDayQuesInfo(day,quesIdx)
local data=self.data
if data and data.dayListCheckLookup then
local quesData=data.dayListCheckLookup[day]
if not quesData then
return nil,0
end
return quesData[quesIdx]
end
return nil,0
end

function subActivityInfo_zhonglixiexin:reqSelectCheck(ques_idx,check_idx)
local json_str=jsonHelper.encode({1,ques_idx,check_idx})
activitiesController:sendProtocol(actSendType.eComonReqHandle,self.act_id,self.sub_act_type,self.sub_act_id,json_str)
end

function subActivityInfo_zhonglixiexin:reqGetReward()
local json_str=jsonHelper.encode({2})
activitiesController:sendProtocol(actSendType.eComonReqHandle,self.act_id,self.sub_act_type,self.sub_act_id,json_str)
end

return subActivityInfo_zhonglixiexin