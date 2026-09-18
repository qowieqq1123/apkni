







activitiesHandle_zhonglixiexin=new_activitiesHandle('activitiesHandle_zhonglixiexin',activitiesHandle)






function activitiesHandle_zhonglixiexin:onInit()

end


function activitiesHandle_zhonglixiexin.recv_247_70(args)







local subType=SUB_ACTIVITY_TYPE.eZhongLiXieXin
local actID=args[1]
local subid=args[2]
local data=activitiesModel:getSubActInfoData(actID,subType,subid)
if data==nil then return end
local day_list_check_len=args[3]
local day_list_check=args[4]
local rank_len=args[5]
local rank_info=args[6]

local dayLookup={}
for i=1,day_list_check_len do
local dayInfo=day_list_check[i]

local quesLookup={}
for j=1,dayInfo.ques_check_len do
local ques=dayInfo.ques_check_info[j]

local totleCnt=0
local checkCntList={}
local checkCntLookup={}
for k=1,ques.check_len do
local check=ques.ques_check_info[k]
local check_cnt=check and check.check_cnt or 0
if not checkCntLookup[check_cnt]then
checkCntLookup[check_cnt]={}
table.insert(checkCntList,check_cnt)
end
table.insert(checkCntLookup[check_cnt],check)

totleCnt=totleCnt+check_cnt
end

table.sort(checkCntList,function(a,b)
if a==0 or b==0 then
return a>b
end
return a<b
end)

local rank=1
local checkLookup={}

for k,check_cnt in ipairs(checkCntList)do
for _,check in ipairs(checkCntLookup[check_cnt])do
local checkData={}
checkData.check_cnt=check.check_cnt
checkData.totleCnt=totleCnt
checkData.rank=rank
checkLookup[check.check_idx]=checkData
end

rank=rank+#checkCntLookup[check_cnt]
end
for kk=1,4 do
if not checkLookup[kk]then
local checkData={}
checkData.check_cnt=0
checkData.totleCnt=totleCnt
checkData.rank=rank
checkLookup[kk]=checkData
end
end
quesLookup[ques.ques_idx]=checkLookup
end
dayLookup[dayInfo.day]=quesLookup
end
data.dayListCheckLookup=dayLookup

local rankList={}
local scoreList={}
local rankLookup={}
for i=1,rank_len do
local v=rank_info[i]
if not rankLookup[v.score]then
rankLookup[v.score]={}
table.insert(scoreList,v.score)
end
table.insert(rankLookup[v.score],v)
end

if next(scoreList)~=nil then
table.sort(scoreList,function(a,b)
return a>b
end)

for i,score in ipairs(scoreList)do
for j,v in ipairs(rankLookup[score])do
if not rankList[i]then
rankList[i]={}
rankList[i].list={}
rankList[i].rank=i
rankList[i].score=score
rankList[i].isMe=false
end
if playerModel:checkActorId(v.actor_id)then
rankList[i].isMe=true
data.myLastRankData={
rank=i,
score=score,
}
end
table.insert(rankList[i].list,v)
end
end
end
data.lastRankList=rankList

activitiesModel:setSubActInfoData(actID,subType,subid,data)

UIManager:invokeUIMethod('UISubAct_ZhongLiXieXinDaTiTipsWin','closeSelf')
UIManager:invokeUIMethod('UISubAct_ZhenXinHuaQiXiDaTiTipsWin','closeSelf')

reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,subType)
end


function activitiesHandle_zhonglixiexin.recv_247_71(...)




local args={...}
local subType=SUB_ACTIVITY_TYPE.eZhongLiXieXin
local actID=args[1]
local subid=args[2]
local data=activitiesModel:getSubActInfoData(actID,subType,subid)
if data==nil then return end
local rank_len=args[3]
local rank_info=args[4]

local sub_actcfg=activitiesModel:getSubActivityConfig(subType,subid)
local min_rank_score=sub_actcfg.min_rank_score
local rank_limit_len=sub_actcfg.reward_rank_limit_len

local rankList={}
local scoreList={}
local rankLookup={}
local rankScoreLookup={}
for i=1,rank_len do
local v=rank_info[i]

if v.score>=min_rank_score then
if not rankLookup[v.score]then
rankLookup[v.score]={}
table.insert(scoreList,v.score)
end
table.insert(rankLookup[v.score],v)
end
end

if next(scoreList)~=nil then
table.sort(scoreList,function(a,b)
return a>b
end)

local rank=1
for i,score in ipairs(scoreList)do
if rank>rank_limit_len then
break
end
for j,v in ipairs(rankLookup[score])do
local widght=j+rank-1
v.rank=rank
v.widght=widght
table.insert(rankList,v)
rankScoreLookup[widght]=score

if playerModel:checkActorId(v.actor_id)then
data.myRankData=v
end
end
rank=rank+#rankLookup[score]
end
end
table.sort(rankList,function(a,b)
return a.widght<b.widght
end)
data.rankList=rankList
data.rankScoreLookup=rankScoreLookup

activitiesModel:setSubActInfoData(actID,subType,subid,data)

UIManager:invokeUIMethod('UISubAct_ZhongLiXieXinRankWin','refresh')

reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,subType)
end


function activitiesHandle_zhonglixiexin.recv_247_72(args)








local subType=SUB_ACTIVITY_TYPE.eZhongLiXieXin
local actID=args[1]
local subid=args[2]
local data=activitiesModel:getSubActInfoData(actID,subType,subid)
if data==nil then return end
data.day=args[3]
local role_day_check_len=args[4]
local role_day_check_info=args[5]
data.daily_get=args[6]
data.quesLen=0
data.score=args[7]


local roleLookup={}
for i=1,role_day_check_len do
local role=role_day_check_info[i]

local quesLookup={}
for ii=1,role.ques_check_len do
local ques=role.ques_check_info[ii]
quesLookup[ques.ques_idx]=ques.check_idx

if role.day==data.day then
data.quesLen=data.quesLen+1
end
end
roleLookup[role.day]=quesLookup
end
data.roleDayCheckInfoLookup=roleLookup

activitiesModel:setSubActInfoData(actID,subType,subid,data)

UIManager:invokeUIMethod('UISubAct_ZhongLiXieXinWin','refreshAll')
UIManager:invokeUIMethod('UISubAct_ZhenXinHuaQiXiWin','refreshAll')
UIManager:invokeUIMethod('UISubAct_ZhongLiXieXinRankWin','setMyInfo')

reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,subType)
end


function activitiesHandle_zhonglixiexin.recv_247_73(args)







local subType=SUB_ACTIVITY_TYPE.eZhongLiXieXin
local actID=args[1]
local subid=args[2]
local data=activitiesModel:getSubActInfoData(actID,subType,subid)
if data==nil then return end
local day=args[3]
local ques_idx=args[4]
local check_idx=args[5]
local result=args[6]

if result~=0 then
return
end

local lookup=data.roleDayCheckInfoLookup or{}
lookup[day]=lookup[day]or{}
local oldCheckIdx=lookup[day][ques_idx]
if not oldCheckIdx then
data.quesLen=data.quesLen+1
end
lookup[day][ques_idx]=check_idx

activitiesModel:setSubActInfoData(actID,subType,subid,data)
reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,subType)

if not oldCheckIdx then
UIManager:invokeUIMethod('UISubAct_ZhongLiXieXinWin','refreshProgress',true)
UIManager:invokeUIMethod('UISubAct_ZhenXinHuaQiXiWin','refreshProgress',true)
end
UIManager:invokeUIMethod('UISubAct_ZhongLiXieXinDaTiTipsWin','rectSelectCheckIdx',day,ques_idx,check_idx,oldCheckIdx)
UIManager:invokeUIMethod('UISubAct_ZhenXinHuaQiXiDaTiTipsWin','rectSelectCheckIdx',day,ques_idx,check_idx,oldCheckIdx)
end


function activitiesHandle_zhonglixiexin.recv_247_74(...)





local args={...}
local subType=SUB_ACTIVITY_TYPE.eZhongLiXieXin
local actID=args[1]
local subid=args[2]
local data=activitiesModel:getSubActInfoData(actID,subType,subid)
if data==nil then return end
local day=args[3]
local result=args[4]
if day==data.day and result==0 then
data.daily_get=1
end

activitiesModel:setSubActInfoData(actID,subType,subid,data)
reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,subType)

UIManager:invokeUIMethod('UISubAct_ZhongLiXieXinWin','refreshReward')
UIManager:invokeUIMethod('UISubAct_ZhenXinHuaQiXiWin','refreshReward')
end
