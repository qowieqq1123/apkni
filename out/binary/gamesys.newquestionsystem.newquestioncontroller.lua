newQuestionController=gameState.addListener({})

local userSetting_field="userSettingQuestionAnswerList2"
local _httpGetRequest=CS.ResourceHelper.HttpGetRequest;

function newQuestionController:onAppStart()
socketManager:register_receiver(254,45,self.onInit)
socketManager:register_receiver(254,46,self.onPrize)
newQuestionModel:init()
end

function enterManager:onEnterState(isReconnet)
if not isReconnet then
self.wenJuanId=nil
end
end

function newQuestionController:onLeaveState(isReconnet)

if not isReconnet then
self.wenJuanId=nil
end
self.answerlist=nil
userActorSetting.flush()
end

function newQuestionController:onProtocolReq(isReconnect)
self:initUserSetttingData()

self:requestQuestionList()
end


function newQuestionController.onInit(len,array)
newQuestionModel:setData(len,array)
end

function newQuestionController.onPrize(id)
newQuestionModel:setPrize(id)
enterManager:freshFunc('freshReddot',ENTER_TYPE.eWenJuan)
newQuestionController:deleteQuestionnirAnswer(id)

if newQuestionModel:hasPrize()then
UIManager:invokeUIMethod("UIClientShowQuestionWin","refresh")
else
UIManager:closeWindow("UIClientShowQuestionWin")
end
newQuestionController:freshEntry()
end

function newQuestionController:showClientShowQuestionWin()
UIManager:showWindow("UIClientShowQuestionWin")
end

function newQuestionController:initUserSetttingData()
local answerlist=userActorSetting.get(userSetting_field,"{}")
self.lookupAnswerList={}
self.answerlist=jsonHelper.decode(answerlist)
comHelper.cleanUserData(self.answerlist)
if next(self.answerlist or{})then
for k,v in pairs(self.answerlist)do
self.lookupAnswerList[v.id]=v

for _,ans in pairs(v.answer)do
if ans.fillContentDir then
ans.fillContents={}
for _,fv in pairs(ans.fillContentDir)do
ans.fillContents[fv.index]=fv.content
end
ans.fillContentDir={}
end

if ans.optionContenttDir then
ans.optionContent={}
for _,fv in pairs(ans.optionContenttDir)do
ans.optionContent[fv.index]=fv.content
end
ans.optionContenttDir={}
end

if ans.option then
ans.lookup={}
for _,ov in pairs(ans.option)do
ans.lookup[ov]=true
end
else
ans.lookup={}
end
end

end
end
end





function newQuestionController:saveQuestionnirAnswer(id,bankid,answer)
self.lookupAnswerList[id]={id=id,bankid=bankid,answer=answer}
self.answerlist={}
for k,v in pairs(self.lookupAnswerList)do
self.answerlist[#self.answerlist+1]=v
end

local jsonstr=jsonHelper.encode(self.answerlist)
userActorSetting.set(userSetting_field,jsonstr)
userActorSetting.flush()
end

function newQuestionController:deleteQuestionnirAnswer(id)
self.lookupAnswerList[id]=nil
self.answerlist={}
for k,v in pairs(self.lookupAnswerList)do
self.answerlist[#self.answerlist+1]=v
end
comHelper.cleanUserData(self.answerlist)
local jsonstr=jsonHelper.encode(self.answerlist)
userActorSetting.set(userSetting_field,jsonstr)
userActorSetting.flush()
end

function newQuestionController:getQuestionnirAnswer(id)
local answer=self.lookupAnswerList[id]
if answer then
for _,ans in pairs(answer.answer)do
if ans.fillContentDir then
ans.fillContents={}
for _,fv in pairs(ans.fillContentDir)do
ans.fillContents[fv.index]=fv.content
end
ans.fillContentDir={}
end

if ans.optionContenttDir then
ans.optionContent={}
for _,fv in pairs(ans.optionContenttDir)do
ans.optionContent[fv.index]=fv.content
end
ans.optionContenttDir={}
end

if ans.option then
ans.lookup={}
for _,ov in pairs(ans.option)do
ans.lookup[ov]=true
end
else
ans.lookup={}
end
end
end
return answer
end

local _httpJsonPostRequest=CS.ResourceHelper.HttpJsonPostRequest
local _httpPostRequest=CS.ResourceHelper.HttpPostRequest

function newQuestionController:submitQuestionnaireAnswer(id,bankid,answer)
local data=self:getArgsData(id,bankid,answer)


local datastr=jsonHelper.encode(data)






if deviceHelper.isRunNoneOrEditor()then

if deviceHelper.isRunEditor()then
local qlpurl="http://10.10.1.25/report"
local url=FMT.fmt("{0}?counter=question",qlpurl)

_httpPostRequest(url,data,function(state,message)

if state=='1'then
logPoint.printPoint(FMT.fmt("调查问卷上报成功"))
UIManager.info("提交成功")
else
logPoint.printPoint(FMT.fmt("调查问卷上报失败"))

end
end)
end
else
local qlpurl=logPoint.GetUploadURL()
local url=FMT.fmt("{0}?counter=question",qlpurl)
logWarn(FMT.fmt("client wenjuan url:{0}",url))
_httpPostRequest(url,data,function(state,message)

logWarn(FMT.fmt("client wenjuan _httpPostRequest result::{0},{1}",state,message))
if state=='1'then
logPoint.printPoint(FMT.fmt("调查问卷上报成功"))
UIManager.info("提交成功")
else
logPoint.printPoint(FMT.fmt("调查问卷上报失败"))

end
end)
end
end

function newQuestionController:getArgsData(id,bankid,answer)
local question_data={}

for k,v in pairs(answer)do
table.sort(v.option or{})
local temp={
number=v.number,
type=v.type,
topic=v.topic,
option=v.option,
optionContent={},
fillContent=v.fillContent
}
for k,oc in pairs(v.optionContent)do
temp.optionContent[#temp.optionContent+1]=oc
end
question_data[#question_data+1]=temp
end

local info=loginModel.phpLoginInfo or{}
local data={
pfid=tostring(loginModel:getPfid()or''),
sid=tostring(info.srvid or''),
channel=tostring(loginModel:getChannelID()or''),
actorId=tostring(playerModel:getActorID()or''),
actorName=playerModel:getActorName()or'',
period=tostring(id),
questionBank=tostring(bankid),
questionData=string.encodeURI(jsonHelper.encode(question_data)),
submitTime=tostring(os.time())
}
local str={}
for k,v in pairs(data)do
table.insert(str,k)
table.insert(str,v)
end
return str
end

function newQuestionController:requestQuestionList()
local pfname
local url
local sid=loginModel.server_id or 0
if deviceHelper.isRunNoneOrEditor()then
pfname="sqzs"
url=FMT.fmt("http://10.10.1.49:89/{0}/api/questionList",pfname)

if deviceHelper.isRunNonePlatform()then
return
end

sid=359
else

if verifyManager:isOpen()then
return
end
pfname=gameInfo:getPfname()
url=gameInfo:getParams('questionnaireURL')
end
local urlStr=FMT.fmt("{0}?sid={1}",url,sid)
loggerUtil.log(FMT.fmt("client wenjuan 1 {0}",urlStr))
_httpGetRequest(urlStr,function(content,err)

loggerUtil.log(FMT.fmt("client wenjuan 2:{0} {1}",content,tostring(err)))
if err==""or err==nil then
if type(content)=='table'then
newQuestionModel:setQuestionListCondition(content)
newQuestionController:freshEntry()
else
local data={}
local s,e=pcall(function()
data=jsonHelper.decode(content)
end)
if s and data then
newQuestionModel:setQuestionListCondition(data)
newQuestionController:freshEntry()
else
logWarn(FMT.fmt("request wenjuan list ,php return message is error,content :: {0},error:{1}",content,e))
end
end

else
logWarn(FMT.fmt("{0} get questionnaire list is failed"))
end
end)
end

function newQuestionController:freshEntry()
if newQuestionModel:hasPrize()then
if self.wenJuanId==nil then
self.wenJuanId=enterManager:freshEnter({enterIconType=ENTER_ICON_TYPE.eNomal,enterType=ENTER_TYPE.eNewWenJuan,getReddotFun=function()
return newQuestionModel:hasPrize()
end})
else
enterManager:freshFunc('freshReddot',ENTER_TYPE.eNewWenJuan)
end
else
if self.wenJuanId then
enterManager:removeEnter(self.wenJuanId)
self.wenJuanId=nil
end
end
end

function newQuestionController:onPrize_test(id)
newQuestionController.onPrize(id)
end

function newQuestionController:req_test()
local content={
[1]={
question_id="1",
begin_time="1695780231",
end_time="1728007431",
condition={
open_day=5,
level=10,
min_recharge_yb=10,
max_recharge_yb=100000
}
},
[2]={
question_id="2",
begin_time="1695780231",
end_time="1728007431",
condition={
open_day=5,
level=10,
min_recharge_yb=10,
max_recharge_yb=100000
}
},
[3]={
question_id="3",
begin_time="1695780231",
end_time="1728007431",
condition={
open_day=5,
level=10,
min_recharge_yb=10,
max_recharge_yb=10000
}
}
}

if type(content)=='table'then
newQuestionModel:setQuestionListCondition(content)
newQuestionController:freshEntry()
else
local data={}
local s,e=pcall(function()
data=jsonHelper.decode(content)
end)
if s and data then
newQuestionModel:setQuestionListCondition(data)
newQuestionController:freshEntry()
else
logWarn(FMT.fmt("request wenjuan list ,php return message is error,content :: {0},error:{1}",content,e))
end
end
end


function newQuestionController:req_test_open(question_id)
local content={
[1]={
question_id=1,
bank_id=question_id,
begin_time=tostring(os.time()-1),
end_time=tostring(os.time()+timeSecLook.eOneDaySec),
},
}
newQuestionModel:setQuestionListCondition(content)
newQuestionController:freshEntry()
end




function newQuestionController:printActiveWenjuanInfo()
local activeWjList=newQuestionModel:getOpenQuestionList()

end

