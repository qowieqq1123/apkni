







def_class("UIChangeFaBaoNameWin",UIWindowBase)









function UIChangeFaBaoNameWin:bindComponents()

self.costObj=UIButton.get(self,0)
self.freeText=UIText.get(self,1)
self.InputField=UIInputField.get(self,2)
self.sureBtn=UIButton.get(self,3)
self.cancelBtn=UIButton.get(self,4)
self.costIcon=UIImage.get(self,5)
self.costDesc=UIText.get(self,6)

self.costObj:setButtonClick(function()self:onCostObj()end)

self.sureBtn:setButtonClick(function()self:onSureBtn()end)

self.cancelBtn:setButtonClick(function()self:onCancelBtn()end)



end


function UIChangeFaBaoNameWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.costObj);self.costObj=nil;
_UIObject_release(self.freeText);self.freeText=nil;
_UIObject_release(self.InputField);self.InputField=nil;
_UIObject_release(self.sureBtn);self.sureBtn=nil;
_UIObject_release(self.cancelBtn);self.cancelBtn=nil;
_UIObject_release(self.costIcon);self.costIcon=nil;
_UIObject_release(self.costDesc);self.costDesc=nil;
end


















function UIChangeFaBaoNameWin:onLoaded(...)
self:bindComponents()
end

function UIChangeFaBaoNameWin:__delete()
self:unbindComponents()
end

function UIChangeFaBaoNameWin:onShow(argtable,afterOnloaded)
local itemguid=argtable
self.itemguid=itemguid
local cost=fabaoConfig.getCommonConfig().rename
self.costList=cost
local itemid=cost[1][1]
local need=cost[1][2]
local have=itemsModel.getCount(itemid)
local countStr=FMT.fmt('{0}/{1}',have,need)
if have<need then
countStr=FMT.fmt('<color=#E33021>{0}</color>',countStr)
end
self.costObj:setActive(true)
self.costDesc:setText(countStr)
self.costIcon:setImageIcon(iconHelper.getIconName(itemid),false)
local config=cfgHelper.get1(cfg_systemsetconfig_get,1)
local gameVersion=pfwindowslController:getGameVersion()
self.lenLimit=config.name_len[gameVersion]or config.name_len[1]
if pfwindowslController:checkIsGameVersion_HWFT()then
self.lenLimit[2]=6
end
self.InputField:setInputCharacterLimit(self.lenLimit[2])
end

function UIChangeFaBaoNameWin:onHide()

end





function UIChangeFaBaoNameWin:onCostObj()
local costList=self.costList
local cost=costList[1]
local itemid=cost[1]

gainControl:showGainWin(itemid)
end



function UIChangeFaBaoNameWin:onSureBtn()

if houtaiModel:isForbidenChangeName('该功能正在升级维护中')then
return
end

local changeName=self.InputField:getInputFieldValue()
if changeName==nil or changeName==''then
UIManager.error('法宝名不能为空')
return
end

if pfwindowslController:checkIsGameVersion_guofu()or pfwindowslController:checkIsGameVersion_HWFT()then
if not helper.string_is_ChineseS(changeName)then
UIManager.error('请写汉字名讳')
return
end
end

if helper.check_spec_chars(changeName)then
UIManager.error('名字中含有特殊字符')
return
end

local inputLen=string.lenEx(changeName)
if inputLen>self.lenLimit[2]then
UIManager.error(FMT.fmt('最多输入{0}个字符',self.lenLimit[2]))
return
end

local itemguid=self.itemguid
local equip=fabaoHelper.getFabao(itemguid)
local fabaoname=fabaoHelper.getFabaoName(equip)
if fabaoname==changeName then
UIManager.error('角色名称重复')
return
end

local costList=self.costList
for i,v in ipairs(costList)do
local itemid=v[1]
local have=itemsModel.getCount(itemid)

if have<v[2]then
gainControl:showGainWin(itemid)
return
end
end

local func=function(guid,legalStr)
if self==nil or self.isClose then return end
if legalStr~=changeName then
UIManager.error('名字中含有敏感字符')
return
end
fabaoProtocolControl.reqChangeName(self.itemguid,changeName)
self:closeSelf()
end
chatProtocolControl.sendCheckLegalStr(changeName,func)
end



function UIChangeFaBaoNameWin:onCancelBtn()
self.InputField:setInputFieldValue('')
end

