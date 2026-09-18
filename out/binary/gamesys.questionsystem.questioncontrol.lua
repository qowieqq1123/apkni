questionControl=gameState.addListener({})

local userSetting_field="userSettingQuestionAnswerList"

function questionControl:onAppStart()
socketManager:register_receiver(254,48,self.onInit)
socketManager:register_receiver(254,49,self.onPrize)
questionModel:init()
notifySystem:listenNotify(notifyConfig.onNewDay,self.onNewDay)
notifySystem:listenNotify(notifyConfig.on_system_open,self.onSystemOpen)
end

function enterManager:onEnterState(isReconnet)
if not isReconnet then
self.wenJuanId=nil
end

end

function questionControl:onLeaveState(isReconnet)
questionModel:init()
if not isReconnet then
self.wenJuanId=nil
end
self.answerlist=nil
end

function questionControl:onProtocolReq()
questionModel:freshId()
self.answerlist=userActorSetting.get(userSetting_field,{})
end


function questionControl.onInit(len,array)
questionModel:setData(len,array)
end

function questionControl.onPrize(id)
questionModel:setPrize()
enterManager:freshFunc('freshReddot',ENTER_TYPE.eWenJuan)
UIManager.info('奖励已发至邮箱')
end

function questionControl.onNewDay()
questionModel:freshId()
end

function questionControl.onSystemOpen(sysid,flag)
if not flag then return end
questionModel:freshId()
end

function questionControl:freshEntry()
local id=questionModel:getId()
if id then
if self.wenJuanId==nil then
self.wenJuanId=enterManager:freshEnter({enterIconType=ENTER_ICON_TYPE.eNomal,enterType=ENTER_TYPE.eWenJuan,getReddotFun=function()
return questionModel:hasPrize()
end})
else
enterManager:freshFunc('freshReddot',ENTER_TYPE.eQuestionnaire)
end
else
if self.wenJuanId then
enterManager:removeEnter(self.wenJuanId)
self.wenJuanId=nil
end
end
end

function questionControl:showClientShowQuestionWin()
UIManager:showWindow("UIClientShowQuestionWin")
end





function questionControl:saveQuestionnirAnswer(id,bankid,answer)
self.answerlist[id]={id=id,bankid=bankid,answer=answer}
userActorSetting.set(userSetting_field,self.answerlist)
userActorSetting.flush()
end

function questionControl:deleteQuestionnirAnswer(id)
self.answerlist[id]=nil
userActorSetting.set(userSetting_field,self.answerlist)
userActorSetting.flush()
end

function questionControl:getQuestionnirAnswer(id)
return self.answerlist[id]or{}
end

function questionControl:submitQuestionnaireAnswer(id,bankid,answer)
local data=self:getArgsData(id,bankid,answer)
local datastr=jsonHelper.encode(data)
local url="http://10.10.1.25:81/report?counter=load"
logPoint.printPoint(FMT.fmt("调查问卷上报:{0}&data={1}",url,datastr))
httpManager.postRequest(url,{'data',datastr},function(state,message)
if state then
logPoint.printPoint(FMT.fmt("调查问卷上报成功"))
UIManager.info("提交成功")
else
logPoint.printPoint(FMT.fmt("调查问卷上报失败"))
end
end)
end

function questionControl:getArgsData(id,bankid,answer)
local question_data={}

for k,v in pairs(answer)do
local temp={
number=v.number,
type=v.type,
topic=v.topic,
option=v.option,
optionContent=v.optionContent,
fillContent=v.fillContent
}
question_data[#question_data+1]=temp
end

local info=loginModel.phpLoginInfo or{}
local data={
pfid=tostring(loginModel:getPfid()or''),
sid=tostring(info.srvid or''),
channel=tostring(loginModel:getChannelID()or''),
actorId=tostring(playerModel:getActorID()or''),
actorName=playerModel:getActorName()or'',
period=id,
questionBank=bankid,
questionData=question_data,
submitTime=os.time()
}
return data
end