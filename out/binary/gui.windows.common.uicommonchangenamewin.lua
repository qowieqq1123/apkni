







def_class("UICommonChangeNameWin",UIWindowBase)









function UICommonChangeNameWin:bindComponents()

self.titleText=UIText.get(self,0)
self.inputField=UIInputField.get(self,1)
self.costIcon=UIImage.get(self,2)
self.costDesc=UIText.get(self,3)
self.costObj=UIButton.get(self,4)
self.inputDefaultTxt=UIText.get(self,5)
self.hwnameTips=UIText.get(self,6)

self.costObj:setButtonClick(function()self:onCostObj()end)



end


function UICommonChangeNameWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.titleText);self.titleText=nil;
_UIObject_release(self.inputField);self.inputField=nil;
_UIObject_release(self.costIcon);self.costIcon=nil;
_UIObject_release(self.costDesc);self.costDesc=nil;
_UIObject_release(self.costObj);self.costObj=nil;
_UIObject_release(self.inputDefaultTxt);self.inputDefaultTxt=nil;
_UIObject_release(self.hwnameTips);self.hwnameTips=nil;
end
















local _this


function UICommonChangeNameWin:onLoaded(...)
self:bindComponents()
_this=self
notifySystem:listenNotify(notifyConfig.onChangeName,self.onChangeName)
local isHWFT=pfwindowslController:checkIsGameVersion_HWFT()
self.hwnameTips:setActive(isHWFT)
self.lenLimit=UISettingModel:getzmname_len()
self.inputField:setInputCharacterLimit(self.lenLimit[2])
end


function UICommonChangeNameWin:__delete()
_this=nil
self:unbindComponents()
notifySystem:removelistener(notifyConfig.onChangeName,self.onChangeName)
end


function UICommonChangeNameWin:onHide()

end




function UICommonChangeNameWin:onShow(argtable,afterOnloaded)
self.changeNameType=argtable.changeNameType
if self.changeNameType==changeNameType.eXianMeng then
self.lenLimit=UISettingModel:getcommonname_len()
self.inputField:setInputCharacterLimit(self.lenLimit[2])
elseif argtable.lenLimit then
self.lenLimit=argtable.lenLimit
self.inputField:setInputCharacterLimit(self.lenLimit[2])
end
self.title=argtable.title or'改名'
self.defaultName=argtable.defaultName
self.defaultDesc=argtable.defaultDesc or'请输入新名字'
self.is_Chinese=argtable.is_Chinese
if self.defaultName==''then
self.defaultName=nil
end
self.cost=argtable.cost
self.callback=argtable.callback
self.crossCheck=argtable.crossCheck

self:upDateView()
end

function UICommonChangeNameWin:upDateView()

self.titleText:setText(self.title)

self.inputDefaultTxt:setText(self.defaultDesc)

local cost=self.cost
local showCost=cost~=nil
self.showCost=showCost
self.costObj:setActive(showCost)
if showCost then
local costItemID=cost[1]
local costNum=cost[2]
self.costItemID=costItemID
self.costNum=costNum
local have=0
if moneyConfig.isMoney(costItemID)then
have=moneyModel.getMoney(costItemID)
else
have=itemBagModel:getItemCountByItemID(costItemID)
end
self.hasCostNum=have
local iconName=iconHelper.getIconName(costItemID)
self.costIcon:setImageIcon(iconName,false)
local nunStr
if have<costNum then
nunStr=FMT.fmt('<color=#E33021>{0}</color>',costNum)
else
nunStr=tostring(costNum)
end
self.costDesc:setText(nunStr)
end
end

function UICommonChangeNameWin:onSureBtn()

AudioManager.playBtnClick()
local changeName=self.inputField:getInputFieldValue()
if changeName==nil or changeName==''then
UIManager.error('名字不能为空')
return
end
self.isGuoFu=pfwindowslController:checkIsGameVersion_guofu()
if self.isGuoFu then

if self.is_Chinese==true then
if not helper.string_is_ChineseS(changeName)then
UIManager.error('请写汉字名讳')
return
end
end

if helper.check_spec_chars(changeName)then
UIManager.error('名字中含有特殊字符')
return
end
end
if not pfwindowslController.checkNameLenInvalid(changeName,self.lenLimit)then
return
end
if self.defaultName~=nil then
if changeName==self.defaultName then
UIManager.error('请输入新的名字')
return
end
end

if self.showCost then
if self.hasCostNum<self.costNum then
UIManager.error(FMT.fmt('{0}不足',itemsConfig.getItemName(self.costItemID)))
return
end
end

if not self.crossCheck then
local func=function(...)
if _this==nil then return end
_this:onCheckStringLegal(...)
end
chatProtocolControl.sendCheckLegalStr(changeName,func)
else
local callback=self.callback
if callback then
callback(changeName)
end
self:closeSelf()
end
end

function UICommonChangeNameWin:onCheckStringLegal(str,legalStr)
local func=function(str)
if legalStr~=str then
UIManager.error('名字中含有敏感字符')
return
end
local callback=self.callback
if callback then
callback(legalStr)
end
end




















platformSDK:reqMsgSecCheck(1,str,function(reContent)
if reContent==str then
func(reContent)
else
UIManager.error('名字中含有敏感字符')
end
end)
end

function UICommonChangeNameWin.onChangeName(changeType,oldName,newName)
if _this==nil then return end

if changeType==_this.changeNameType then
UIManager.info('名字修改成功')
_this:closeSelf()
end
end

function UICommonChangeNameWin:onCostObj()
gainControl:showGainWin(self.costItemID)
end
