







def_class("UITestTagBtnWin",UIWindowBase)









function UITestTagBtnWin:bindComponents()

self.root=UIObject.get(self,0)
self.uiroot=UIObject.get(self,1)
self.head=UIObject.get(self,2)
self.descText=UIText.get(self,3)
self.mid=UIObject.get(self,4)
self.inputField=UIInputField.get(self,5)
self.Placeholder=UIText.get(self,6)
self.botton=UIObject.get(self,7)
self.resideSendCount=UIText.get(self,8)
self.sendBtn=UIButton.get(self,9)
self.rewardBtn=UIButton.get(self,10)
self.rewardReddot=UIObject.get(self,11)
self.descText1=UIText.get(self,12)
self.Content=UIText.get(self,13)
self.tipsText=UIText.get(self,14)

self.sendBtn:setButtonClick(function()self:onSendBtn()end)

self.rewardBtn:setButtonClick(function()self:onRewardBtn()end)



end


function UITestTagBtnWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.uiroot);self.uiroot=nil;
_UIObject_release(self.head);self.head=nil;
_UIObject_release(self.descText);self.descText=nil;
_UIObject_release(self.mid);self.mid=nil;
_UIObject_release(self.inputField);self.inputField=nil;
_UIObject_release(self.Placeholder);self.Placeholder=nil;
_UIObject_release(self.botton);self.botton=nil;
_UIObject_release(self.resideSendCount);self.resideSendCount=nil;
_UIObject_release(self.sendBtn);self.sendBtn=nil;
_UIObject_release(self.rewardBtn);self.rewardBtn=nil;
_UIObject_release(self.rewardReddot);self.rewardReddot=nil;
_UIObject_release(self.descText1);self.descText1=nil;
_UIObject_release(self.Content);self.Content=nil;
_UIObject_release(self.tipsText);self.tipsText=nil;
end



















function UITestTagBtnWin:onLoaded(...)
self:bindComponents()
end


function UITestTagBtnWin:__delete()
self:unbindComponents()
if not self.dataList[self.systemIdStr]then
if self.dataList==nil then self.dataList={}end
self:saveDataToModel()
end




self.dataList=nil
self.isCanReward=nil
self.submitCount=nil
end




function UITestTagBtnWin:onShow(argtable,afterOnloaded)
self.systemId=argtable.systemId
self.systemIdStr=tostring(self.systemId)


self:refreshData()

local descText=comHelper.getCheckLayoutStr(self.descText1:getGameObject(),770,cfgHelper.get2(cfg_testtagconfig_get,self.systemId,'desc'),true)
self.winlua:SetChildText(self.descText:getID(),descText)

self:checkReddotandGray()


self.inputField:setChildInputFieldChange(true,function(...)self:onTextChange(...)end)

self.isCanSubmit=true
end


function UITestTagBtnWin:onHide()

end


function UITestTagBtnWin:refreshData()
self.dataList=UISettingModel:getTestDataList()
local time=cfgHelper.get2(cfg_testtagconfig_get,self.systemId,'time')
self.giftId=cfgHelper.get2(cfg_testtagconfig_get,self.systemId,'reward')

if time then
self.time=timeHelper.getSeconds(time[1][1],time[1][2],time[1][3],time[1][4],time[1][5],time[1][6])
else
self.time=0
end


if self.dataList[self.systemIdStr]then
self.isCanReward=self.dataList[self.systemIdStr].isCanReward
self.submitCount=self.dataList[self.systemIdStr].submitCount
self.startTime=self.dataList[self.systemIdStr].startTime
self.sendTime=self.dataList[self.systemIdStr].sendTime

if self.sendTime>0 then
if timeHelper.isOutFiveStamp(self.sendTime)then
self.submitCount=0
self.sendTime=timeHelper.getServerLongTime()
end
end
else
self.dataList[self.systemIdStr]={}
self.isCanReward=true
self.sendTime=0
self.submitCount=0
self.startTime=self.time
end
local isget=FreeGiftModel:IsCanGetGift(self.giftId,FreeGiftType.system,nil)
if not isget then
self.isCanReward=false
end
self:saveDataToModel()

end




local _httpGetRequest=CS.ResourceHelper.HttpGetRequest;
function UITestTagBtnWin:onSendBtn()
if self.submitCount<1 then
if not self.isCanSubmit then
UIManager.error("请耐心等待提交结果！")
return
else
local logUrl
local counter="counter=feedback"
if deviceHelper.isRunNoneOrEditor()then
logUrl="http://10.10.1.25/report"
else
logUrl=logPoint.GetUploadURL()
end
local data,isLimit=self:collectInfo()
if data==nil then
UIManager.error("请输入您宝贵的建议")
return
end

if not isLimit then
UIManager.error("超过字数限制")
return
end
self.isCanSubmit=false
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

self.isCanSubmit=true
UIManager.error("发送有未知错误，请稍候再试")
end
else
self.isCanSubmit=true
UIManager.error("发送有未知错误，请稍候再试")
end
end)
end
else
UIManager.error("今天已提交过建议啦")
end
end

function UITestTagBtnWin:onRewardBtn()
if self.isCanReward then

FreeGiftController.SendFreeGift(self.giftId,nil,function(arg)
if arg then
self.isCanReward=false
self:saveDataToModel()
self:checkReddotandGray()
userActorArraySetting.set(ACTOR_SETTING_TYPE.eTestTagData,'systemTestData',self.dataList)
userActorArraySetting.flush(ACTOR_SETTING_TYPE.eTestTagData)
local win=UISettingModel:getWinNameConfigById(self.systemId)

if win then
for k,v in pairs(win)do

if v then
UIManager:invokeUIMethod(v,'refreshTestWin')
end
end
end
end
end)
end
end

function UITestTagBtnWin:checkReddotandGray()
local content=self.inputField:getInputFieldValue()
local len=string.lenEx(content)
local check=self.submitCount<1 and len>0 or false
self.winlua:SetChildActive(self.rewardBtn:getID(),self.isCanReward)
self.winlua:SetChildButtonEnable(self.sendBtn:getID(),true,not check)
end

function UITestTagBtnWin:addSendNum()
self.submitCount=self.submitCount+1
self.sendTime=timeHelper.getServerLongTime()
self:saveDataToModel()
self:checkReddotandGray()
userActorArraySetting.set(ACTOR_SETTING_TYPE.eTestTagData,'systemTestData',self.dataList)
userActorArraySetting.flush(ACTOR_SETTING_TYPE.eTestTagData)
end


function UITestTagBtnWin:saveDataToModel()
self.dataList[self.systemIdStr]={isCanReward=self.isCanReward,submitCount=self.submitCount,startTime=self.startTime,sendTime=self.sendTime}
UISettingModel:setTestDataList(self.dataList)
end

function UITestTagBtnWin:onTextChange()
local content=self.inputField:getInputFieldValue()
local check=string.lenEx(content)>0 or false
self.winlua:SetChildButtonEnable(self.sendBtn:getID(),true,not check)
self.winlua:SetChildActive(self.tipsText:getID(),not check)
self.winlua:SetChildText(self.Content:getID(),content)
end

function UITestTagBtnWin:collectInfo()
local content=self.inputField:getInputFieldValue()
if content==''then return end
local info=loginModel.phpLoginInfo or{}
local temp=
{
pfid=tostring(loginModel:getPfid()or''),
sid=tostring(info.srvid or''),
account=info.user or loginModel.userid or'',
actor_id=tostring(playerModel:getActorID()or''),
actor_name=string.encodeURI(playerModel:getActorName()or''),
level=playerModel:getActorLevel()or 1,
fight=playerModel:getActorFightValue()or 0,
recharge=rechargeModel:getTotalRecharge()or 0,
type=self.systemId+10000,
content=string.encodeURI(content),
}

local data=""
local isLimit=string.lenEx(content)<500 or false
for k,v in pairs(temp)do
data=FMT.fmt("{0}&{1}={2}",data,k,v)
end

return data,isLimit
end

function UITestTagBtnWin:closeWin()
self:closeSelf()
end
