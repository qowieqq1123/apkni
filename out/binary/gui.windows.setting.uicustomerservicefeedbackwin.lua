







def_class("UICustomerServiceFeedbackWin",UIWindowBase)









function UICustomerServiceFeedbackWin:bindComponents()

self.root=UIObject.get(self,0)
self.uiroot=UIObject.get(self,1)
self.head=UIObject.get(self,2)
self.recipientRoot=UIObject.get(self,3)
self.titleRoot=UIObject.get(self,4)
self.titleinfo=UIText.get(self,5)
self.topicalRoot=UIObject.get(self,6)
self.sortTypeDropdown=UIDropdown.get(self,7)
self.mid=UIObject.get(self,8)
self.inputField=UIInputField.get(self,9)
self.Placeholder=UIText.get(self,10)
self.botton=UIObject.get(self,11)
self.resideWord=UIText.get(self,12)
self.resideSendCount=UIText.get(self,13)
self.sendBtn=UIButton.get(self,14)
self.bgmodel=UIObject.get(self,15)

self.sendBtn:setButtonClick(function()self:onSendBtn()end)



end


function UICustomerServiceFeedbackWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.uiroot);self.uiroot=nil;
_UIObject_release(self.head);self.head=nil;
_UIObject_release(self.recipientRoot);self.recipientRoot=nil;
_UIObject_release(self.titleRoot);self.titleRoot=nil;
_UIObject_release(self.titleinfo);self.titleinfo=nil;
_UIObject_release(self.topicalRoot);self.topicalRoot=nil;
_UIObject_release(self.sortTypeDropdown);self.sortTypeDropdown=nil;
_UIObject_release(self.mid);self.mid=nil;
_UIObject_release(self.inputField);self.inputField=nil;
_UIObject_release(self.Placeholder);self.Placeholder=nil;
_UIObject_release(self.botton);self.botton=nil;
_UIObject_release(self.resideWord);self.resideWord=nil;
_UIObject_release(self.resideSendCount);self.resideSendCount=nil;
_UIObject_release(self.sendBtn);self.sendBtn=nil;
_UIObject_release(self.bgmodel);self.bgmodel=nil;
end
















local limitWordNum=500

local localUserKuFuFKDataKey="userKeFuFKData"

local optionNameList={
"意见",
"BUG",
"投诉",
"其他",
"其他",
}

local optionTitleNameList={
"意见反馈",
"BUG提交",
"投诉处理",
"其他",
}




function UICustomerServiceFeedbackWin:onLoaded(...)
self:bindComponents()
self.sortTypeDropdown:setChangeAction(function(...)self:onDropdownChange(...)end)


self:addNotify(notifyConfig.onNewDay,function(...)self:onNewDay(...)end)

end


function UICustomerServiceFeedbackWin:__delete()
self:unbindComponents()
end




function UICustomerServiceFeedbackWin:onShow(argtable,afterOnloaded)
self.Placeholder:setText("游戏中不完善之处还请海涵，我们将会尽快核查并修复\n祖师如有任何建议，请联系我们，期待您的来信！")
self.inputField:setInputCharacterLimit(limitWordNum)


self.curKefufkData=userActorSetting.get(localUserKuFuFKDataKey,{time=os.time(),num=0})
if not timeHelper.isTodayStamp(self.curKefufkData.time)then
self:onNewDay()
end

self.kefufkMaxNum=cfgHelper.get2(cfg_globalconfig_get,1,"kefunum")
self.resideSendCount:setText(FMT.fmt("<color=#36756b>今日发送次数：</color>{0}/{1}",self.curKefufkData.num,self.kefufkMaxNum))

self.optionIndex=1
self.sortTypeDropdown:setOption(optionNameList)
self.sortTypeDropdown:setValue(self.optionIndex-1)
self.titleinfo:setText(optionTitleNameList[self.optionIndex])

self.uiroot:setChildCanvasGroupAlpha(0)
self.bgmodel:setChildUIModelShowTarget(4863,1,{},eAnimationID.enter,false,false,0,function()
self:delayDo(1.5,function()
self.uiroot:setChildCanvasGroupDOFade(1,1,nil)
end)
end)
end


function UICustomerServiceFeedbackWin:onHide()

end

function UICustomerServiceFeedbackWin:collectInfo()
local content=self.inputField:getInputFieldValue()
if content==''then return end
local info=loginModel.phpLoginInfo or{}
local temp={
pfid=tostring(loginModel:getPfid()or''),
sid=tostring(info.srvid or''),
account=info.user or loginModel.userid or'',
actor_id=tostring(playerModel:getActorID()or''),
actor_name=string.encodeURI(playerModel:getActorName()or''),
level=playerModel:getActorLevel()or 1,
fight=playerModel:getActorFightValue()or 0,
recharge=rechargeModel:getTotalRecharge()or 0,
type=tostring(self.optionIndex),
content=string.encodeURI(content)
}

local data=""
for k,v in pairs(temp)do
data=FMT.fmt("{0}&{1}={2}",data,k,v)
end
return data
end

function UICustomerServiceFeedbackWin:addSendNum()
self.curKefufkData.num=self.curKefufkData.num+1
userActorSetting.set(localUserKuFuFKDataKey,self.curKefufkData)
userActorSetting.flush()
end

function UICustomerServiceFeedbackWin:onSendSuccessRecv()
self.optionIndex=1
self.sortTypeDropdown:setValue(self.optionIndex-1)
self.inputField:setInputFieldValue("")
self.resideSendCount:setText(FMT.fmt("<color=#36756b>今日发送次数：</color>{0}/{1}",self.curKefufkData.num,self.kefufkMaxNum))
end

function UICustomerServiceFeedbackWin:onChangeInputField(str)






end

function UICustomerServiceFeedbackWin:onDropdownChange(idx)

idx=idx+1
self.optionIndex=idx
self.titleinfo:setText(optionTitleNameList[self.optionIndex])
end

function UICustomerServiceFeedbackWin:onNewDay()
self.curKefufkData.time=os.time()
self.curKefufkData.num=0
userActorSetting.set(localUserKuFuFKDataKey,self.curKefufkData)
userActorSetting.flush()
end




local _httpGetRequest=CS.ResourceHelper.HttpGetRequest;
function UICustomerServiceFeedbackWin:onSendBtn()
if self.curKefufkData.num<self.kefufkMaxNum then
local logUrl
local counter="counter=feedback"
if deviceHelper.isRunNoneOrEditor()then
logUrl="http://10.10.1.25/report"
else
logUrl=logPoint.GetUploadURL()
end
local data=self:collectInfo()
if data==nil then
UIManager.error("请输入您宝贵的建议")
return
end
local url=FMT.fmt("{0}?{1}{2}",logUrl,counter,data)
loggerUtil.log(FMT.fmt("kefufk log data:{0}",url))
_httpGetRequest(url,function(content,err)
loggerUtil.log(FMT.fmt("kefufk log result:{0} {1}",content,err))
if err==""or err==nil then
if content=='1'then
UIManager.info("发送成功")
self:addSendNum()

self:closeSelf()
else

UIManager.error("发送有未知错误，请稍候再试")
end
else
UIManager.error("发送有未知错误，请稍候再试")
end
end)
else
UIManager.error("祖师还请休息一下，明天再来反馈")
end
end

