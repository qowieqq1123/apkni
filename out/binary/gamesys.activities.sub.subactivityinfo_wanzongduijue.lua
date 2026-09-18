









local subActivityInfo_wanzongduijue={name='subActivityInfo_wanzongduijue'}
local reqCooldown=10

function subActivityInfo_wanzongduijue:onInit()

end

function subActivityInfo_wanzongduijue:handleTaskData(index,v,start_time,end_time)
local st=self.start_time_l
local d={}
d.index=index
d.stime=st+start_time
d.etime=st+end_time
d.name=v.sub_name
d.jumplist=v.jumplist
d.rank_min_score=v.rank_min_score
d.join_reward=v.join_reward
local rank_reward={}
for i,vv in ipairs(v.rank)do
local r={}
r.rank=vv[1]
if vv[1]~=vv[2]then
r.rank2=vv[2]
end
r.rewardList=vv[3]
rank_reward[i]=r
end
d.rank_reward=rank_reward
local target_rewards=v.target_rewards
if target_rewards~=nil then
local targets={}
for i,vv in ipairs(target_rewards)do
local t={}
t[1]=i
t[2]=vv[1]
t[3]=vv[2]
targets[i]=t
end
d.targets=targets
end
d.getScore=function(self_)
return self_.score or 0
end
d.getRank=function(self_)
return self_.rank or 0
end
d.setData=function(self_,score,rank,rewardFlag)
self_.score=score
self_.rank=rank
self_.rewardFlag=rewardFlag
self_.reqScoreTime=gameUtilityModel.getServerLongTime()
end
d.setData2=function(self_,score,rank)
local changeScore=self_.score~=score
if changeScore==true then
self_.score=score
end
self_.rank=rank
self_.reqScoreTime=gameUtilityModel.getServerLongTime()
return changeScore
end
d.setData3=function(self_,rewardFlag)
self_.rewardFlag=rewardFlag
end
d.setData4=function(self_,score)
self_.score=score
self_.reqScoreTime=gameUtilityModel.getServerLongTime()
end
d.getEndLeftTime=function(self_)
local cur=gameUtilityModel.getServerLongTime()
local lerp=cur-self_.stime
if lerp<0 then
return lerp
else
lerp=self_.etime-cur
if lerp>=0 then
return lerp
else
return 0
end
end
end
d.checkReddot=function(self_)
for i,t in ipairs(self_.targets)do
local isfinish,hasreward=self_:checkTargetState(t)
if hasreward then
return true
end
end
return false
end

d.checkTargetState=function(self_,t)
local score=self_:getScore()
local isfinish=score>=t[2]
local hasreward=false
local rewardFlag=self_.rewardFlag or 0
hasreward=isfinish and not bitHelper.check_pos(rewardFlag,t[1]-1)
return isfinish,hasreward
end
d.getSortTargets=function(self_)
local list={}
for i,t in ipairs(self_.targets)do
local isfinish,hasreward=self_:checkTargetState(t)
if not isfinish then
t[4]=0
else
if hasreward then
t[4]=1
else
t[4]=-1
end
end
list[i]=t
end
if#list>1 then
table.sort(list,function(a,b)
if a[4]==b[4]then
return a[2]<b[2]
else
return a[4]>b[4]
end
end)
end
return list
end
d.getRewardInRank=function(self_,rank,score)
if rank>0 then
for i,vv in ipairs(self_.rank_reward)do
if vv.rank2~=nil then
if rank>=vv.rank and rank<=vv.rank2 then
return vv.rewardList
end
else
if rank==vv.rank then
return vv.rewardList
end
end
end
end
if score>0 and score>=self_.rank_min_score then
return self_.join_reward
end
return nil
end
return d
end

function subActivityInfo_wanzongduijue:initTaskLookup()
local data=self.data
if data==nil then
data={}
self.data=data
end
local taskLookup=data.taskLookup
if taskLookup==nil then
taskLookup={}
local finishTime
local cfg=self:getSubActConfig()
local n=0
for index,v in pairs(cfg.stageConfs)do
if index~=0 then
local d=self:handleTaskData(index,v,v.start_time,v.end_time)
taskLookup[index]=d
n=n+1
if finishTime==nil or finishTime<d.etime then
finishTime=d.etime
end
end
end
if n==1 then

taskLookup[0]=taskLookup[1]
data.onlyone=true
else
local start_time=cfg.stageConfs[1].start_time
local end_time=cfg.stageConfs[n].end_time
local d=self:handleTaskData(0,cfg.stageConfs[0],start_time,end_time)
taskLookup[0]=d
end
data.taskLookup=taskLookup
data.finishTime=finishTime
data.rankLookup={}
end
return taskLookup
end

function subActivityInfo_wanzongduijue:onStart()

end

function subActivityInfo_wanzongduijue:onUpdate()

end

function subActivityInfo_wanzongduijue:onDelete()

end

function subActivityInfo_wanzongduijue:checkReddot()
local data=self.data
if data~=nil then
for index,d in pairs(data.taskLookup)do
if index>0 then
if d:checkReddot()then
return true
end
end
end
end
return false
end

function subActivityInfo_wanzongduijue:getTaskList()
local taskList=self.taskList
if taskList==nil then
taskList={}
for index,d in pairs(self.data.taskLookup)do
if index>0 then
taskList[index]=d
end
end
self.taskList=taskList
end
return taskList
end

function subActivityInfo_wanzongduijue:getCurTaskIndex()
local cur=gameUtilityModel.getServerLongTime()
local lp=self.data.taskLookup
for index,d in pairs(lp)do
if index~=0 then
if cur>=d.stime and cur<d.etime then
return index
end
end
end

return 0
end

function subActivityInfo_wanzongduijue:getTaskData(index)
return self.data.taskLookup[index]
end

function subActivityInfo_wanzongduijue:refreshRankList(index,rankList,score)
local isChanged=false
local data=self.data
if data~=nil then
local rankLookup=data.rankLookup
if rankLookup==nil then
rankLookup={}
data.rankLookup=rankLookup
end
local list=rankList or{}
local dd={list,gameUtilityModel.getServerLongTime()}
rankLookup[index]=dd
if data.onlyone==true then
local index_=index==0 and 1 or 0
rankLookup[index_]=dd
end
local curRank,curScore
local myActorid=playerModel:getActorID()
for i,data in ipairs(list)do
if mathHelper.compareInt64(myActorid,data.actorid)then
curRank=data.rank
curScore=data.score
break
end
end
local taskData=self:getTaskData(index)
if curRank~=nil then
isChanged=taskData.rank~=curRank or taskData.score~=curScore
if isChanged==true then
taskData:setData2(curScore,curRank)
end
else
taskData:setData4(score)
end
end
return isChanged
end

function subActivityInfo_wanzongduijue:getRankList(index)
local d=self.data.rankLookup[index]
if d~=nil then
if self:checkTimeInTaskRange(d[2],index)then
local lerp=gameUtilityModel.getServerLongTime()-d[2]
if lerp<reqCooldown then
return d[1],lerp
else
return nil,nil
end
else
return d[1],nil
end
else
local cur=gameUtilityModel.getServerLongTime()
if self:checkTimeInTaskRange2(cur,index)then
return nil,nil
else
return{},nil
end
end
end

function subActivityInfo_wanzongduijue:checkTimeInTaskRange(markTime,index)
if markTime==nil then return true end
local taskData=self:getTaskData(index)
local check=false
if markTime>=taskData.stime and markTime<taskData.etime then
check=true
end
return check
end

function subActivityInfo_wanzongduijue:checkTimeInTaskRange2(markTime,index)
if markTime==nil then return true end
local taskData=self:getTaskData(index)
local check=false
if markTime>=taskData.stime then
check=true
end
return check
end

function subActivityInfo_wanzongduijue:checkReqNewScore(index)
local taskData=self:getTaskData(index)
local time=taskData.reqScoreTime
if time~=nil then
if self:checkTimeInTaskRange(time,index)then
local lerp=gameUtilityModel.getServerLongTime()-time
if lerp<reqCooldown then
return true,lerp
else
return true,nil
end
else
return false,nil
end
else
local cur=gameUtilityModel.getServerLongTime()
if self:checkTimeInTaskRange2(cur,index)then
return true,nil
else
return false,nil
end
end
end

return subActivityInfo_wanzongduijue