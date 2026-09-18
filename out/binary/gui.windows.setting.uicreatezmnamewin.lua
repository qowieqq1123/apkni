







def_class("UICreateZMNameWin",UIWindowBase)









function UICreateZMNameWin:bindComponents()

self.back=UIObject.get(self,0)
self.InputField=UIInputField.get(self,1)
self.randomNameBtn=UIButton.get(self,2)
self.Dropdown=UIDropdown.get(self,3)
self.sureBtn=UIButton.get(self,4)
self.Placeholder=UIText.get(self,5)
self.closeBtn=UIButton.get(self,6)

self.randomNameBtn:setButtonClick(function()self:onRandomNameBtn()end)

self.sureBtn:setButtonClick(function()self:onSureBtn()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)



end


function UICreateZMNameWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.back);self.back=nil;
_UIObject_release(self.InputField);self.InputField=nil;
_UIObject_release(self.randomNameBtn);self.randomNameBtn=nil;
_UIObject_release(self.Dropdown);self.Dropdown=nil;
_UIObject_release(self.sureBtn);self.sureBtn=nil;
_UIObject_release(self.Placeholder);self.Placeholder=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
end

















local _this


function UICreateZMNameWin:onLoaded(...)
self:bindComponents()
_this=self
self.lenLimit=UISettingModel:getzmname_len()
self.InputField:setInputCharacterLimit(self.lenLimit[2])
self.Dropdown:setChangeAction(function(...)self:onDropdownChange(...)end)
self.suffixLookup={}
local lookup=cfg_sectsuffixconfig()
for i,v in ipairs(lookup)do
table.insert(self.suffixLookup,v)
end
local desc="输入1-7个字符"
if pfwindowslController:checkIsGameVersion_HWFT()then
desc="输入6個中文或10個英文字母以内)"
elseif pfwindowslController:checkIsGameVersion_yuenan()then
desc="Nhập 2–12 ký tự"
elseif pfwindowslController:checkIsGameVersion_oumei()then
desc="Enter 2-12 characters"
end
self.Placeholder:setText(desc)
end


function UICreateZMNameWin:__delete()
self:unbindComponents()
_this=nil
self.suffixLookup=nil


if self.playNextStory then
storyAIManager:startStoryBehavior('story_8_XiuFuDaDian_2')
end
end




function UICreateZMNameWin:onShow(argtable,afterOnloaded)
if argtable then
self.playNextStory=argtable.playNextStory
end

self.randomSuffix=math.random(1,#self.suffixLookup)
self.curSelectSuffix=self.curSelectSuffix or self.randomSuffix
self:refreshDropDown()
self:updateName()
self.closeBtn:setActive(UISettingModel:getZMName()~='')
self.back:setChildUIModelShowTarget(2049,1,{},2064)
end


function UICreateZMNameWin:onHide()

end

function UICreateZMNameWin:refreshDropDown()
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

function UICreateZMNameWin:onDropdownChange(idx)

idx=idx+1
self.curSelectSuffix=idx
if self.clickRandom then
self.clickRandom=nil
return
end
self.notRandom=true
self:refreshDropDown()
end

function UICreateZMNameWin:updateName()
local randNameList=self.suffixLookup[self.curSelectSuffix].randname
local rand=math.random(1,#randNameList)
self.InputField:setInputFieldValue(randNameList[rand])
end



function UICreateZMNameWin:onRandomNameBtn()
self:updateName()




if not self.notRandom then
self.clickRandom=true
self.curSelectSuffix=math.random(1,#self.suffixLookup)
self.Dropdown:setValue(self.curSelectSuffix-1)
self.clickRandom=true
self:refreshDropDown()
end
end

function UICreateZMNameWin:onSureBtn()

local zmName=UISettingModel:getZMName()
if zmName and zmName~=''and houtaiModel:isForbidenChangeName('该功能正在升级维护中')then
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

function UICreateZMNameWin:onCheckStringLegal(guid,legalStr)
local func=function(str)
if _this==nil then
return
end

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

function UICreateZMNameWin:onCloseBtn()
self:closeSelf()
end
