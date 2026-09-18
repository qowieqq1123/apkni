







def_class("UIDiscipleChangeNameWin",UIWindowBase)









function UIDiscipleChangeNameWin:bindComponents()

self.costObj=UIButton.get(self,0)
self.freeText=UIText.get(self,1)
self.InputField=UIInputField.get(self,2)
self.sureBtn=UIButton.get(self,3)
self.costIcon=UIImage.get(self,4)
self.costDesc=UIText.get(self,5)
self.hwnameTips=UIText.get(self,6)

self.costObj:setButtonClick(function()self:onCostObj()end)

self.sureBtn:setButtonClick(function()self:onSureBtn()end)



end


function UIDiscipleChangeNameWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.costObj);self.costObj=nil;
_UIObject_release(self.freeText);self.freeText=nil;
_UIObject_release(self.InputField);self.InputField=nil;
_UIObject_release(self.sureBtn);self.sureBtn=nil;
_UIObject_release(self.costIcon);self.costIcon=nil;
_UIObject_release(self.costDesc);self.costDesc=nil;
_UIObject_release(self.hwnameTips);self.hwnameTips=nil;
end

















local _this


function UIDiscipleChangeNameWin:onLoaded(...)
self:bindComponents()
_this=self


local isHWFT=pfwindowslController:checkIsGameVersion_HWFT()
self.hwnameTips:setActive(isHWFT)
end


function UIDiscipleChangeNameWin:__delete()
self:unbindComponents()
_this=nil
end




function UIDiscipleChangeNameWin:onShow(argtable,afterOnloaded)
self.disciple_guid=argtable.guid
self.costList=cfgHelper.getglobal2('disciplerename','consume')
self.lenLimit=UISettingModel:getdisciplename_len()
self.InputField:setInputCharacterLimit(self.lenLimit[2])
self:flushCost()
end


function UIDiscipleChangeNameWin:onHide()

end

function UIDiscipleChangeNameWin:flushCost()
local netData=UIDiscipleModel:getDiscipleData(self.disciple_guid)

local isFree=false

self.costObj:setActive(not isFree)
if not isFree then
local costList=self.costList
local cost=costList[1]
local itemid=cost[1]
local need=cost[2]
local have=0
if moneyConfig.isMoney(itemid)then
have=moneyModel.getMoney(itemid)
else
have=itemBagModel:getItemCountByItemID(itemid)
end
local countStr=tostring(need)
if have<need then
countStr=FMT.fmt('<color=#E33021>{0}</color>',countStr)
end
self.costDesc:setText(countStr)
self.costIcon:setImageIcon(iconHelper.getIconName(itemid),false)
end
end




function UIDiscipleChangeNameWin:onCostObj()
local costList=self.costList
local cost=costList[1]
local itemid=cost[1]

gainControl:showGainWin(itemid)
end

function UIDiscipleChangeNameWin:onSureBtn()

if houtaiModel:isForbidenChangeName('该功能正在升级维护中')then
return
end

if self.isLock then return end
local changeName=self.InputField:getInputFieldValue()
if changeName==nil or changeName==''then
UIManager.error('弟子名不能为空')
return
end

if not pfwindowslController.checkNameLenInvalid(changeName,self.lenLimit)then
return
end

self:doSend(changeName)
end

function UIDiscipleChangeNameWin:doSend(str)
local netData=UIDiscipleModel:getDiscipleData(self.disciple_guid)

local isFree=false
if not isFree then
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
local modtype=isFree and 0 or 1
self.changeName=str
self.modType=modtype
self.isLock=true
local func=function(...)
if _this==nil then return end
_this:onCheckStringLegal(...)
end
chatProtocolControl.sendCheckLegalStr(str,func)
end

function UIDiscipleChangeNameWin:onCheckStringLegal(str,legalStr)
local func=function(str)
if legalStr~=str then
UIManager.error('名字中含有敏感字符')
if _this then
_this.isLock=nil
end
return
end
UIDiscipleController:requireDiscipleChangeName(self.disciple_guid,self.changeName,self.modType)
end
























platformSDK:reqMsgSecCheck(1,str,function(reContent)
if reContent==str then
func(reContent)
else
UIManager.error('名字中含有敏感字符')
end
end)
end

function UIDiscipleChangeNameWin:onChanageNameBack(result)
self.isLock=nil
end