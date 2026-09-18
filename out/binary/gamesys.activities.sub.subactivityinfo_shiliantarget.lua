









local subActivityInfo_shilianTarget={name='shilianTarget'}


local rankType=
{
wuXingShengDian=0,
wuXingJinDian=1,
wuXingMuDian=2,
wuXingShuiDian=3,
wuXingHuoDian=4,
wuXingTuDian=5,
}
subActivityInfo_shilianTarget.rankType=rankType

local rankData=
{

[rankType.wuXingShengDian]=
{
getRankData=function(self)
return wuXingDianModel:getRankList(rankType.wuXingShengDian)or{}
end,
getTop3Data=function(self)
return wuXingDianModel:getTop3RankList(rankType.wuXingShengDian)or{}
end,
sendTop3Func=function(self)
return wuXingDianController:send_25_24(rankType.wuXingShengDian)
end,
sendRankFunc=function(self)
return wuXingDianController:send_25_21(rankType.wuXingShengDian)
end,
getMyScore=function(self)
return wuXingDianModel:getFinishLayer(rankType.wuXingShengDian)
end,
isClear=function(self)
local scroe=self:getMyScore()
local max=wuXingDianModel:getMaxLayer(rankType.wuXingShengDian)
return scroe>=max
end,
name="五行圣殿",
},
[rankType.wuXingJinDian]=
{
getRankData=function(self)
return wuXingDianModel:getWuXingDianRankList(rankType.wuXingJinDian)or{}
end,
getTop3Data=function(self)
return wuXingDianModel:getTop3RankList(rankType.wuXingJinDian)or{}
end,
sendTop3Func=function(self)
return wuXingDianController:send_25_24(rankType.wuXingJinDian)
end,
sendRankFunc=function(self)
return wuXingDianController:send_25_21(rankType.wuXingJinDian)
end,
getMyScore=function(self)
return wuXingDianModel:getFinishLayer(rankType.wuXingJinDian)
end,
isClear=function(self)
local scroe=self:getMyScore()
local max=wuXingDianModel:getMaxLayer(rankType.wuXingJinDian)
return scroe>=max
end,
name="五行金殿",
},
[rankType.wuXingMuDian]=
{
name="五行木殿",
getRankData=function(self)
return wuXingDianModel:getWuXingDianRankList(rankType.wuXingMuDian)or{}
end,
getTop3Data=function(self)
return wuXingDianModel:getTop3RankList(rankType.wuXingMuDian)or{}
end,
sendTop3Func=function(self)
return wuXingDianController:send_25_24(rankType.wuXingMuDian)
end,
sendRankFunc=function(self)
return wuXingDianController:send_25_21(rankType.wuXingMuDian)
end,
getMyScore=function(self)
return wuXingDianModel:getFinishLayer(rankType.wuXingMuDian)
end,
isClear=function(self)
local scroe=self:getMyScore()
local max=wuXingDianModel:getMaxLayer(rankType.wuXingMuDian)
return scroe>=max
end,
},
[rankType.wuXingShuiDian]=
{
name="五行水殿",
getRankData=function(self)
return wuXingDianModel:getWuXingDianRankList(rankType.wuXingShuiDian)or{}
end,
getTop3Data=function(self)
return wuXingDianModel:getTop3RankList(rankType.wuXingShuiDian)or{}
end,
sendTop3Func=function(self)
return wuXingDianController:send_25_24(rankType.wuXingShuiDian)
end,
sendRankFunc=function(self)
return wuXingDianController:send_25_21(rankType.wuXingShuiDian)
end,
getMyScore=function(self)
return wuXingDianModel:getFinishLayer(rankType.wuXingShuiDian)
end,
isClear=function(self)
local scroe=self:getMyScore()
local max=wuXingDianModel:getMaxLayer(rankType.wuXingShuiDian)
return scroe>=max
end,
},
[rankType.wuXingHuoDian]=
{
name="五行火殿",
getRankData=function(self)
return wuXingDianModel:getWuXingDianRankList(rankType.wuXingHuoDian)or{}
end,
getTop3Data=function(self)
return wuXingDianModel:getTop3RankList(rankType.wuXingHuoDian)or{}
end,
sendTop3Func=function(self)
return wuXingDianController:send_25_24(rankType.wuXingHuoDian)
end,
sendRankFunc=function(self)
return wuXingDianController:send_25_21(rankType.wuXingHuoDian)
end,
getMyScore=function(self)
return wuXingDianModel:getFinishLayer(rankType.wuXingHuoDian)
end,
isClear=function(self)
local scroe=self:getMyScore()
local max=wuXingDianModel:getMaxLayer(rankType.wuXingHuoDian)
return scroe>=max
end,
},
[rankType.wuXingTuDian]=
{
name="五行土殿",
getRankData=function(self)
return wuXingDianModel:getWuXingDianRankList(rankType.wuXingTuDian)or{}
end,
getTop3Data=function(self)
return wuXingDianModel:getTop3RankList(rankType.wuXingTuDian)or{}
end,
sendTop3Func=function(self)
return wuXingDianController:send_25_24(rankType.wuXingTuDian)
end,
sendRankFunc=function(self)
return wuXingDianController:send_25_21(rankType.wuXingTuDian)
end,
getMyScore=function(self)
return wuXingDianModel:getFinishLayer(rankType.wuXingTuDian)
end,
isClear=function(self)
local scroe=self:getMyScore()
local max=wuXingDianModel:getMaxLayer(rankType.wuXingTuDian)
return scroe>=max
end,
},
}

function subActivityInfo_shilianTarget:onInit()

end

function subActivityInfo_shilianTarget:onStart()

end

function subActivityInfo_shilianTarget:onDelete()

end

function subActivityInfo_shilianTarget:resetDayIndex()
self.data.day_idx=0
end

function subActivityInfo_shilianTarget:checkDayIndex()
if not self.data then
return false
end
return self.data.day_idx==1
end

function subActivityInfo_shilianTarget:getDayIndex()
if not self.data then
return 0
end
return self.data.day_idx
end


function subActivityInfo_shilianTarget:checkNewDay()
if not self.data then
return
end
self.data.day_idx=0
UIManager:callWindowFunc("UISubAct_ShiLianMuBiao","refreshDayBtn")
local subType=SUB_ACTIVITY_TYPE.eShiLianMuBiao
reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,subType)
end

function subActivityInfo_shilianTarget:checkIndexGet(idx)
local cfg=self:getSubActConfig()
local target_reward=cfg.target_reward
local myScore=self:getMyScore(cfg.rank_type)
return myScore>=target_reward[idx][1]
end

function subActivityInfo_shilianTarget:setDayReddot(flag)
if not self.data then
return
end


local nowTime=timeHelper.getServerShortTime()
userActorArraySetting.set(ACTOR_SETTING_TYPE.eSLMBAct,'changeTime'..self.sub_act_id,nowTime)
userActorArraySetting.flush(ACTOR_SETTING_TYPE.eSLMBAct)

reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,SUB_ACTIVITY_TYPE.eShiLianMuBiao)
end

function subActivityInfo_shilianTarget:getDayReddot()
local changeTime=userActorArraySetting.get(ACTOR_SETTING_TYPE.eSLMBAct,'changeTime'..self.sub_act_id,nil)
if not changeTime then

return true
else

local isToday=timeHelper.isTodayShort(changeTime)
return not isToday
end
end

function subActivityInfo_shilianTarget:checkRecvIndexGot(idx)
if not self.data then
return false
end
return idx<=self.data.recv_idx
end

function subActivityInfo_shilianTarget:checkReddot()
if not self.data then
return false
end

if self:checkDayIndex()then
return true
end


if self:getDayReddot()then

return true
end


local cfg=self:getSubActConfig()
local target_reward=cfg.target_reward
local myScore=self:getMyScore(cfg.rank_type)
for i,v in ipairs(target_reward)do
if myScore>=target_reward[i][1]and not self:checkRecvIndexGot(i)then
return true
end
end
return false
end

function subActivityInfo_shilianTarget:getRankData(rankType)
if rankData[rankType]then
return rankData[rankType].getRankData(self)
end
end
function subActivityInfo_shilianTarget:sendTop3Func(rankType)
if rankData[rankType]then
return rankData[rankType].sendTop3Func(self)
end
end
function subActivityInfo_shilianTarget:sendRankFunc(rankType)
if rankData[rankType]then
return rankData[rankType].sendRankFunc(self)
end
end
function subActivityInfo_shilianTarget:getTop3Data(rankType)
if rankData[rankType]then
return rankData[rankType].getTop3Data(self)
end
end
function subActivityInfo_shilianTarget:getMyScore(rankType)
if rankData[rankType]then
return rankData[rankType].getMyScore(self)
end
end
function subActivityInfo_shilianTarget:getName(rankType)
if rankData[rankType]then
return rankData[rankType].name
end
end

function subActivityInfo_shilianTarget:isClear(rankType)
if rankData[rankType]then
return rankData[rankType]:isClear()
end
end
return subActivityInfo_shilianTarget