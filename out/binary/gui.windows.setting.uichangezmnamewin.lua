







def_class("UIChangeZMNameWin",UIWindowBase)









function UIChangeZMNameWin:bindComponents()

self.costObj=UIButton.get(self,0)
self.freeText=UIText.get(self,1)
self.InputField=UIInputField.get(self,2)
self.Dropdown=UIDropdown.get(self,3)
self.sureBtn=UIButton.get(self,4)
self.cancelBtn=UIButton.get(self,5)
self.costIcon=UIImage.get(self,6)
self.costDesc=UIText.get(self,7)
self.hwnameTips=UIText.get(self,8)

self.costObj:setButtonClick(function()self:onCostObj()end)

self.sureBtn:setButtonClick(function()self:onSureBtn()end)

self.cancelBtn:setButtonClick(function()self:onCancelBtn()end)



end


function UIChangeZMNameWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.costObj);self.costObj=nil;
_UIObject_release(self.freeText);self.freeText=nil;
_UIObject_release(self.InputField);self.InputField=nil;
_UIObject_release(self.Dropdown);self.Dropdown=nil;
_UIObject_release(self.sureBtn);self.sureBtn=nil;
_UIObject_release(self.cancelBtn);self.cancelBtn=nil;
_UIObject_release(self.costIcon);self.costIcon=nil;
_UIObject_release(self.costDesc);self.costDesc=nil;
_UIObject_release(self.hwnameTips);self.hwnameTips=nil;
end

















local _this


function UIChangeZMNameWin:onLoaded(...)
self:bindComponents()
_this=self
self.Dropdown:setChangeAction(function(...)self:onDropdownChange(...)end)
self.suffixLookup={}
local lookup=cfg_sectsuffixconfig()
for i,v in ipairs(lookup)do
table.insert(self.suffixLookup,v)
end
local lenLimit=UISettingModel:getzmname_len()
self.InputField:setInputCharacterLimit(lenLimit[2])
local isHWFT=pfwindowslController:checkIsGameVersion_HWFT()
self.hwnameTips:setActive(isHWFT)
end


function UIChangeZMNameWin:__delete()
self:unbindComponents()
_this=nil
self.suffixLookup=nil
self.randomSuffix=nil
self.curSelectSuffix=nil
end




function UIChangeZMNameWin:onShow(argtable,afterOnloaded)
self.changedCnt=UISettingModel:getZMNameChangeCnt()
self.randomSuffix=math.random(1,#self.suffixLookup)
self.curSelectSuffix=self.curSelectSuffix or self.randomSuffix
self:refreshDropDown()

local config=cfgHelper.get1(cfg_systemsetconfig_get,1)
self.costList=config.change_zmname_cost
self.freeCnt=config.name_free_count

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
end


function UIChangeZMNameWin:onHide()

end

function UIChangeZMNameWin:refreshDropDown()
local suffixID=self.suffixLookup[self.curSelectSuffix].id
table.sort(self.suffixLookup,function(a,b)
local va=a.id==suffixID and 1 or 0
local vb=b.id==suffixID and 1 or 0
if va==1 or vb==1 then
return va>vb
else
return a.id<b.id
end
end)
local list={}
for i,v in ipairs(self.suffixLookup)do
table.insert(list,v.name)
end
self.curSelectSuffix=1
self.Dropdown:setOption(list)
self.Dropdown:setValue(self.curSelectSuffix-1)
end

function UIChangeZMNameWin:onDropdownChange(idx)

idx=idx+1
self.curSelectSuffix=idx
self:refreshDropDown()
end




function UIChangeZMNameWin:onCostObj()
local costList=self.costList
local cost=costList[1]
local itemid=cost[1]

gainControl:showGainWin(itemid)
end

function UIChangeZMNameWin:onSureBtn()

if houtaiModel:isForbidenChangeName('该功能正在升级维护中')then
return
end

local inputStr=self.InputField:getInputFieldValue()
local option=self.suffixLookup[self.curSelectSuffix]
local optionStr=option.name
local check=UISettingModel:checkZMName(inputStr,optionStr)
if check then
self.changeName=inputStr
self.optionId=option.id
self.zongmenName=FMT.fmt('{0}{1}',inputStr,optionStr)
local func=function(...)
if _this==nil then return end
_this:onCheckStringLegal(...)
end
chatProtocolControl.sendCheckLegalStr(self.zongmenName,func)
end
end

function UIChangeZMNameWin:onCancelBtn()
self.InputField:setInputFieldValue('')
end

function UIChangeZMNameWin:onCheckStringLegal(str,legalStr)
local func=function(str)
if legalStr~=str then
UIManager.error('名字中含有敏感字符')
return
end
UISettingController:req_change_zongmen_name(_this.changeName,_this.optionId)
end












platformSDK:reqMsgSecCheck(1,_this.zongmenName,function(reContent)
if reContent==_this.zongmenName then
func(reContent)
else
UIManager.error('名字中含有敏感字符')
end
end)
end
