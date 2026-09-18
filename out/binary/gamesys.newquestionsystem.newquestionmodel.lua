newQuestionModel={}

function newQuestionModel:init()
self.data={}
self.data.openQuestionList={}
self.data.waitQuestionList={}
end

function newQuestionModel:setData(len,array)
self.data=array or{}
self.data.openQuestionList={}
self.data.waitQuestionList={}
end

function newQuestionModel:setPrize(id)
table.insert(self.data,id)
end

function newQuestionModel:isPrize(id)
return table.containsValue(self.data,id)
end

function newQuestionModel:hasPrize()
local list=newQuestionModel:getOpenQuestionIdList()
if list and#list>0 then
for k,v in pairs(list)do
if not self:isPrize(v.bank_id)then
return true
end
end
end
return false
end

function newQuestionModel:setQuestionListCondition(data)
self.data.questionListCondition=data


self.data.openQuestionList={}
self.data.waitQuestionList={}


local allCfg=cfg_questionbankconfig()


local curtime=os.time()
local open_day=timeHelper.getServerOpenDay()
local recharge_yb_count=rechargeModel:getTotalRecharge()
local level=playerModel:getActorLevel()
for k,qdata in pairs(self.data.questionListCondition)do
comHelper.cleanUserData(qdata)

qdata.question_id=tonumber(qdata.question_id)
qdata.bank_id=tonumber(qdata.bank_id)
local state=true
local isWait=false

if qdata.begin_time then
qdata.begin_time=tonumber(qdata.begin_time)
if curtime<qdata.begin_time then
state=false
isWait=true
end
end

if qdata.end_time then
qdata.end_time=tonumber(qdata.end_time)
if curtime>(qdata.end_time-60)then
state=false
end
end

if qdata.condition then
qdata.condition=qdata.condition

if qdata.condition.open_day then
qdata.condition.open_day=tonumber(qdata.condition.open_day)
if open_day<qdata.condition.open_day then
state=false
end
end


if qdata.condition.open_end_day then
qdata.condition.open_end_day=tonumber(qdata.condition.open_end_day)
if open_day>qdata.condition.open_end_day then
state=false
end
end


if qdata.condition.min_recharge_yb then
qdata.condition.min_recharge_yb=tonumber(qdata.condition.min_recharge_yb)
if recharge_yb_count<qdata.condition.min_recharge_yb then
state=false
end
end

if qdata.condition.max_recharge_yb then
qdata.condition.max_recharge_yb=tonumber(qdata.condition.max_recharge_yb)
if recharge_yb_count>qdata.condition.max_recharge_yb then
state=false
end
end

if qdata.condition.level then
qdata.condition.level=tonumber(qdata.condition.level)
if level<qdata.condition.level then
state=false
end
end


if qdata.condition.open_end_day then

local serverOpenDayStamp=timeHelper.getServerOpenDayEndLongStamp(timeHelper.getServerOpenLongTime())
local onydaysec=86400
local endOpenDayTime=serverOpenDayStamp+(qdata.condition.open_end_day-1)*onydaysec
qdata.end_time=Mathf.Min(endOpenDayTime,qdata.end_time)
end
end

if self:isPrize(qdata.bank_id)then
state=false
end


if allCfg[qdata.bank_id]==nil then
state=false
logErr(FMT.fmt("问卷缺少题库配置，题库id为 ： {0}",qdata.bank_id))
end

if state then
table.insert(self.data.openQuestionList,qdata)
end

if isWait then
table.insert(self.data.waitQuestionList,qdata)
end
end


if#self.data.openQuestionList>0 or#self.data.waitQuestionList>0 then
self:setQuestionnaireTimer()
end
end

function newQuestionModel:getOpenQuestionList()
return self.data.openQuestionList
end

function newQuestionModel:getOpenQuestionIdList()
local temp={}
for k,v in pairs(self.data.openQuestionList or{})do
table.insert(temp,{
question_id=v.question_id,
bank_id=v.bank_id,
title=v.title
})
end
return temp
end

function newQuestionModel:setQuestionnaireTimer()
self.data.questionnaire_Timer=timer.new()
local func=function()
local curtime=os.time()
for k,v in pairs(self.data.openQuestionList or{})do
local id=tonumber(v.bank_id)
if not self:isPrize(id)and v.end_time then
local end_time=tonumber(v.end_time)
if curtime>=end_time then
newQuestionModel:setPrize(id)
newQuestionController:freshEntry()
end
end
end

local waitList={}
for k,v in pairs(self.data.waitQuestionList or{})do
local id=tonumber(v.bank_id)
if not self:isPrize(id)and v.begin_time then
local begin_time=tonumber(v.begin_time)
if curtime>=begin_time then
table.insert(self.data.openQuestionList,v)
newQuestionController:freshEntry()
else
table.insert(waitList,v)
end
end
end
self.data.waitQuestionList=waitList
end
self.data.questionnaire_Timer:start(1,func,-1)
end

function newQuestionModel:getWenJuanLeftTime()
local leftTime=nil
local qid=nil
if self.data.openQuestionList~=nil then
for k,v in pairs(self.data.openQuestionList)do
if v.end_time then
local end_time=tonumber(v.end_time)
local question_id=tonumber(v.question_id)
if leftTime then
if end_time>leftTime then
leftTime=end_time
qid=question_id
end
else
leftTime=end_time
qid=question_id
end
end
end
end
return leftTime,qid
end



