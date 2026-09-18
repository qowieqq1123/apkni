local _rankList={}
local _myRank={}

local _convertScore={
[seasonStageType.eJRXY]=function(score)
if score>0 then
local longstamp=timeHelper.convertLongStamp(score)
return timeHelper.dateServerStamp("%Y/%m/%d %H:%M",longstamp)
end
return"————"
end,
[seasonStageType.eTZMJ]=function(score,selectIdx)
if selectIdx==eSeasonRankType.eGuild then
return mathHelper.formatNumber2(score)
else
return score
end
end
}

function seasonModel:clearRankData()
table.clear(_rankList)
table.clear(_myRank)
end

function seasonModel:setRankList(season_id,chapter_idx,type,rankList)
if table.checkCreateSubTable(_rankList,{season_id,chapter_idx})then
_rankList[season_id][chapter_idx][type]=rankList
end
end

function seasonModel:setMyRank(season_id,chapter_idx,type,rank,score)
if table.checkCreateSubTable(_myRank,{season_id,chapter_idx})then
_myRank[season_id][chapter_idx][type]={rank=rank,score=score}
end
end

function seasonModel:getRankList(season_id,chapter_idx,type)
if table.checkCreateSubTable(_rankList,{season_id,chapter_idx})then
return _rankList[season_id][chapter_idx][type]
end
end

function seasonModel:getRankData(season_id,chapter_idx,type,rank)
if table.checkCreateSubTable(_rankList,{season_id,chapter_idx,type})then
return _rankList[season_id][chapter_idx][type][rank]
end
end

function seasonModel:getRankDatas(season_id,chapter_idx,type,beginRank,endRank)
local list={}
if table.checkCreateSubTable(_rankList,{season_id,chapter_idx,type})then
for i=beginRank,endRank do
table.insert(list,_rankList[season_id][chapter_idx][type][i])
end
return list
end
end

function seasonModel:getMyRank(season_id,chapter_idx,type)
if table.checkCreateSubTable(_myRank,{season_id,chapter_idx})then
return _myRank[season_id][chapter_idx][type]
end
end

function seasonModel:getRankScoreStr(stageType,score,selectIdx)
local convert=_convertScore[stageType]
if convert then
return convert(score,selectIdx)
end
return score
end