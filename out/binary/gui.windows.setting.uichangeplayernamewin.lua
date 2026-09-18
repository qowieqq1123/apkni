







def_class("UIChangePlayerNameWin",UIWindowBase)









function UIChangePlayerNameWin:bindComponents()

self.cancelBtn=UIButton.get(self,0)
self.costDesc=UIText.get(self,1)
self.costIcon=UIImage.get(self,2)
self.costObj=UIButton.get(self,3)
self.freeText=UIText.get(self,4)
self.gou=UIObject.get(self,5)
self.hwnameTips=UIText.get(self,6)
self.InputField=UIInputField.get(self,7)
self.notifyXMMenberBg=UIObject.get(self,8)
self.notifyXMMenberRoot=UIButton.get(self,9)
self.sureBtn=UIButton.get(self,10)

self.cancelBtn:setButtonClick(function()self:onCancelBtn()end)

self.costObj:setButtonClick(function()self:onCostObj()end)

self.notifyXMMenberRoot:setButtonClick(function()self:onNotifyXMMenberRoot()end)

self.sureBtn:setButtonClick(function()self:onSureBtn()end)



end


function UIChangePlayerNameWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.cancelBtn);self.cancelBtn=nil;
_UIObject_release(self.costDesc);self.costDesc=nil;
_UIObject_release(self.costIcon);self.costIcon=nil;
_UIObject_release(self.costObj);self.costObj=nil;
_UIObject_release(self.freeText);self.freeText=nil;
_UIObject_release(self.gou);self.gou=nil;
_UIObject_release(self.hwnameTips);self.hwnameTips=nil;
_UIObject_release(self.InputField);self.InputField=nil;
_UIObject_release(self.notifyXMMenberBg);self.notifyXMMenberBg=nil;
_UIObject_release(self.notifyXMMenberRoot);self.notifyXMMenberRoot=nil;
_UIObject_release(self.sureBtn);self.sureBtn=nil;
end

















local _this
local _localSaveNoticeKey="Player_Change_Name_DoNoticeXMMenber"


function UIChangePlayerNameWin:onLoaded(...)
self:bindComponents()
_this=self
local isHWFT=pfwindowslController:checkIsGameVersion_HWFT()
self.hwnameTips:setActive(isHWFT)

end


function UIChangePlayerNameWin:__delete()
_this=nil
self:unbindComponents()
end




function UIChangePlayerNameWin:onShow(argtable,afterOnloaded)
self.changedCnt=UISettingModel:getActorNameChangeCnt()
local config=cfgHelper.get1(cfg_systemsetconfig_get,1)
self.costList=config.change_name_cost
self.freeCnt=config.name_free_count
local gameVersion=pfwindowslController:getGameVersion()
self.lenLimit=config.name_len[gameVersion]or config.name_len[1]
self.InputField:setInputCharacterLimit(self.lenLimit[2])
self.costObj:setActive(self.freeCnt<=self.changedCnt)
self.freeText:setActive(self.freeCnt>self.changedCnt)
if self.freeCnt<=self.changedCnt then
local cost=self.costList[1]
local itemid=cost[1]
local need=cost[2]
local have=0
if moneyConfig.isMoney(itemid)then
have=moneyModel.getMoney(itemid)
else
have=itemBagModel:getItemCountByItemID(itemid)
end
local countStr=FMT.fmt('{0}/{1}',have,need)
if have<need then
countStr=FMT.fmt('<color=#E33021>{0}</color>',countStr)
end
self.costDesc:setText(countStr)
self.costIcon:setImageIcon(iconHelper.getIconName(itemid),false)
end

local isHasXM=xianmengModel:hasXM()
self.notifyXMMenberRoot:setActive(isHasXM)
if isHasXM then
self.isNotifyXmMenber=userActorSetting.get(_localSaveNoticeKey,1)==1
self:refreshNotifyXMMenber()
end
end


function UIChangePlayerNameWin:onHide()

end




function UIChangePlayerNameWin:onCostObj()
local costList=self.costList
local cost=costList[1]
local itemid=cost[1]

gainControl:showGainWin(itemid)
end

function UIChangePlayerNameWin:onSureBtn()

if houtaiModel:isForbidenChangeName('该功能正在升级维护中')then
return
end

local changeName=self.InputField:getInputFieldValue()
if changeName==nil or changeName==''then
UIManager.error('角色名不能为空')
return
end
if not pfwindowslController.checkNameLenInvalid(changeName,self.lenLimit)then
return
end

local myname=playerModel:getActorName()or''
if myname==changeName then
UIManager.error('角色名称重复')
return
end

if self.freeCnt<=self.changedCnt then
local costList=self.costList
for i,v in ipairs(costList)do
local have=0
local itemid=v[1]
if moneyConfig.isMoney(itemid)then
have=moneyModel.getMoney(itemid)
else
have=itemBagModel:getItemCountByItemID(itemid)
end
if have<v[2]then

gainControl:showGainWin(itemid)
return
end
end
end
self.changeName=changeName
local func=function(...)
if _this==nil then return end
_this:onCheckStringLegal(...)
end
platformSDK.printSDK('onreMsgSecCheck0',deviceHelper.getRuntimePlatformStr())

chatProtocolControl.sendCheckLegalStr(changeName,func)
end

function UIChangePlayerNameWin:onCancelBtn()
self.InputField:setInputFieldValue('')
end

function UIChangePlayerNameWin:onCheckStringLegal(guid,legalStr)
local func=function(str)
if legalStr~=str then
UIManager.error('名字中含有敏感字符')
return
end
local isNotice=self.isNotifyXmMenber and 1 or 0
UISettingController:req_change_actor_name(_this.changeName,isNotice)
end




















platformSDK:reqMsgSecCheck(1,_this.changeName,function(reContent)
if reContent==_this.changeName then
func(reContent)
else
UIManager.error('名字中含有敏感字符')
end
end)
end

function UIChangePlayerNameWin:onNotifyXMMenberRoot()
self.isNotifyXmMenber=not self.isNotifyXmMenber
local localSaveNotifyXmMenberVal=self.isNotifyXmMenber and 1 or 0
userActorSetting.set(_localSaveNoticeKey,localSaveNotifyXmMenberVal)
userActorSetting.flush(true)
self:refreshNotifyXMMenber()
end

function UIChangePlayerNameWin:refreshNotifyXMMenber()
self.gou:setActive(self.isNotifyXmMenber)
self.notifyXMMenberBg:setGray(not self.isNotifyXmMenber)
end