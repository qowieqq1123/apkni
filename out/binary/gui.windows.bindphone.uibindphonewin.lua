







def_class("UIBindPhoneWin",UIWindowBase)









function UIBindPhoneWin:bindComponents()

self.areaCode=UIText.get(self,0)
self.areaCodePanel=UIObject.get(self,1)
self.areaCodeSelectBtn=UIButton.get(self,2)
self.areaCodeSelectMask=UIButton.get(self,3)
self.areaCodeTips=UIText.get(self,4)
self.areaContent=UIObject.get(self,5)
self.btnBind=UIButton.get(self,6)
self.btnClose=UIButton.get(self,7)
self.btnCode=UIButton.get(self,8)
self.btnReceive=UIButton.get(self,9)
self.btnText=UIText.get(self,10)
self.phoneNumber=UIInputField.get(self,11)
self.rewardContent=UIObject.get(self,12)
self.root=UIObject.get(self,13)
self.verificationCode=UIInputField.get(self,14)

self.areaCodeSelectBtn:setButtonClick(function()self:onAreaCodeSelectBtn()end)

self.areaCodeSelectMask:setButtonClick(function()self:onAreaCodeSelectMask()end)

self.btnBind:setButtonClick(function()self:onBtnBind()end)

self.btnClose:setButtonClick(function()self:onBtnClose()end)

self.btnCode:setButtonClick(function()self:onBtnCode()end)

self.btnReceive:setButtonClick(function()self:onBtnReceive()end)



end


function UIBindPhoneWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.areaCode);self.areaCode=nil;
_UIObject_release(self.areaCodePanel);self.areaCodePanel=nil;
_UIObject_release(self.areaCodeSelectBtn);self.areaCodeSelectBtn=nil;
_UIObject_release(self.areaCodeSelectMask);self.areaCodeSelectMask=nil;
_UIObject_release(self.areaCodeTips);self.areaCodeTips=nil;
_UIObject_release(self.areaContent);self.areaContent=nil;
_UIObject_release(self.btnBind);self.btnBind=nil;
_UIObject_release(self.btnClose);self.btnClose=nil;
_UIObject_release(self.btnCode);self.btnCode=nil;
_UIObject_release(self.btnReceive);self.btnReceive=nil;
_UIObject_release(self.btnText);self.btnText=nil;
_UIObject_release(self.phoneNumber);self.phoneNumber=nil;
_UIObject_release(self.rewardContent);self.rewardContent=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.verificationCode);self.verificationCode=nil;
end


















local areaCodeCfg={
{"台灣",886},
{"香港",852},
{"澳門",853},
{"美國",1},
{"澳大利亞",61},
{"馬來西亞",60},
{"新加坡",65},
{"韓國",82},
{"日本",81},
}

function UIBindPhoneWin:onLoaded(...)
self:bindComponents()
end


function UIBindPhoneWin:__delete()
self:unbindComponents()
end




function UIBindPhoneWin:onShow(argtable,afterOnloaded)
local time=timeHelper.getServerLongTime()
userActorSetting.set("bindPhoneClickTime",time)
userActorSetting.flush()
pfwindowslController:refreshBindPhoneEnterReddot()
self.openAreaPanel=false
self.areaCodeNum=nil
self:refreshBtnState()
self:refreshRewardPanel()
self:refreshAreaCodePanel()
self:refreshCodeBtnState()
self.refreshTimer=self:setTimer(1,0,function()
self:refreshCodeBtnState()
end)
end

function UIBindPhoneWin:refreshAreaCodePanel()
self.areaContent:setChildLayoutGroupCreateItems(#areaCodeCfg,function(index)
local item=self.areaContent:getChildLayoutGroupGridItem(index-1)
item:SetChildButtonClick(0,function()
local name,number=unpack(areaCodeCfg[index])
self.areaCodeNum=number
self.areaCode:setText(string.format("%s+%d",name,number))
self.areaCodeTips:setActive(false)
self:onAreaCodeSelectBtn()
end)
local name,number=unpack(areaCodeCfg[index])
item:SetChildText(1,string.format("%s+%d",name,number))
end)
end

function UIBindPhoneWin:refreshBtnState()
local giftId=pfwindowslController:getBindPhoneGiftId()
local flag=FreeGiftController.GetFreeGift(giftId)
local isBind=pfwindowslController:getEfunPhoneBindState()
local canReceive=pfwindowslController:canReceiveBindPhoneGift()
self.btnBind:setActive(not isBind and flag)
self.btnReceive:setActive(canReceive)
end

function UIBindPhoneWin:refreshRewardPanel()
local giftId=pfwindowslController:getBindPhoneGiftId()
local rewardList=cfgHelper.get2(cfg_freegiftconfig_get,giftId,"rewards")
self.rewardContent:setChildLayoutGroupCreateItems(#rewardList,function(index)
local item=self.rewardContent:getChildLayoutGroupGridItem(index-1)
local itemId,itemNum=unpack(rewardList[index])
local countStr=mathHelper.formatNumber(itemNum)
local conf={itemid=itemId,itemcount=countStr,showCountBG=true,showname=false,showStage=true}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetBaseItemClickEvent(-1,function(...)
itemsComponentHelper.onItemClick(...)
end)
item:SetChildPropData(-1,prop)
end)
end

function UIBindPhoneWin:refreshCodeBtnState()
local lastTime=pfwindowslController:getPhoneCaptchaLastTimeStamp()
local nowTime=timeHelper.getServerShortTime()
local lefTime=60-(nowTime-lastTime)
local isCanReq=lefTime<=0
self.winlua:SetChildButtonEnable(self.btnCode:getID(),isCanReq,not isCanReq)
self.btnText:setText(isCanReq and"獲取驗證碼"or string.format("(%d)",lefTime))
end


function UIBindPhoneWin:onBtnBind()
local areaCode=self.areaCodeNum
local phoneNumber=self.phoneNumber:getInputFieldValue()
local phoneNumberStr=FMT.fmt("{0}-{1}",areaCode,phoneNumber)
local verificationCode=self.verificationCode:getInputFieldValue()
platformSDK.printSDK(FMT.fmt("[phoneBind] phoneNumber:{0} verificationCode:{1}",phoneNumberStr,verificationCode))

if not phoneNumber or phoneNumber==""then
return UIManager.error("請輸入正確手機號")
end
if not areaCode then
return UIManager.error("請選擇區號")
end
if not verificationCode or verificationCode==""then
return UIManager.error("請輸入正確驗證碼")
end
pfwindowslController:reqPhoneBind(phoneNumberStr,verificationCode)
end

function UIBindPhoneWin:onBtnClose()
self:closeSelf()
end

function UIBindPhoneWin:onBtnCode()
local areaCode=self.areaCodeNum
local phoneNumber=self.phoneNumber:getInputFieldValue()
local phoneNumberStr=FMT.fmt("{0}-{1}",areaCode,phoneNumber)
platformSDK.printSDK("[phoneBind] phoneNumber:",phoneNumberStr)

if not phoneNumber or phoneNumber==""then
return UIManager.error("請輸入正確手機號")
end
if not areaCode then
return UIManager.error("請選擇區號")
end
pfwindowslController:getPhoneCaptcha(phoneNumberStr)
end

function UIBindPhoneWin:onBtnReceive()
if pfwindowslController:canReceiveBindPhoneGift()then
pfwindowslController:receiveBindPhoneReward()
end
end

function UIBindPhoneWin:onAreaCodeSelectBtn()
self.openAreaPanel=not self.openAreaPanel
self.areaCodePanel:setActive(self.openAreaPanel)
self.areaCodeSelectMask:setActive(self.openAreaPanel)
end

function UIBindPhoneWin:onAreaCodeSelectMask()
self.openAreaPanel=false
self.areaCodePanel:setActive(self.openAreaPanel)
self.areaCodeSelectMask:setActive(self.openAreaPanel)
end
