







def_class("UIXM_ZZSH_settingWin",UIWindowBase)









function UIXM_ZZSH_settingWin:bindComponents()

self.cliskMask=UIButton.get(self,0)
self.pageOneItem=UIObject.get(self,1)
self.pageTwoItem=UIObject.get(self,2)
self.pageThreeItem=UIObject.get(self,3)
self.closeBtn=UIButton.get(self,4)

self.cliskMask:setButtonClick(function()self:onCliskMask()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)



end


function UIXM_ZZSH_settingWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.cliskMask);self.cliskMask=nil;
_UIObject_release(self.pageOneItem);self.pageOneItem=nil;
_UIObject_release(self.pageTwoItem);self.pageTwoItem=nil;
_UIObject_release(self.pageThreeItem);self.pageThreeItem=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
end

















function UIXM_ZZSH_settingWin:onLoaded(...)
self:bindComponents()
end


function UIXM_ZZSH_settingWin:__delete()
self:unbindComponents()
local autoRever=zhengzhanshanhaiModel:checkPvPAutoReverFlag()
if self.autoRever~=nil and self.autoRever~=autoRever then
if self.autoRever then
zhengzhanshanhaiController:reqAutoRever(1)
else
zhengzhanshanhaiController:reqAutoRever(0)
end
end
end


function UIXM_ZZSH_settingWin:onHide()

end




function UIXM_ZZSH_settingWin:onShow(argtable,afterOnloaded)
local myActorid=playerModel:getActorID()
self.isManager=xianmengModel.checkPostPrivileByActor(myActorid,GUILD_PRIVILE_TYPE.gptZZSHSign)
local setting=zhengzhanshanhaiModel:getPvESetting()
self.sortCondition=table.deepCopy(setting)
if self.sortCondition[1]==nil then
self.sortCondition[1]={}
end
self:refreshView()
end

function UIXM_ZZSH_settingWin:refreshView()

local oneWidget=self.pageOneItem:getChildWidgetBase()

local childGrids=oneWidget:GetChildCommonLayoutGroupWidgetList(0)
self.pageOneNum=childGrids.Count
self.lockToggle=true
for i=1,self.pageOneNum do
local childItem=childGrids[i-1]
local isselect=self.sortCondition[1][i]
if isselect==nil then isselect=true end
childItem:SetChildToggle(0,isselect)
childItem:SetChildToggleChange(0,function(name,isOn)
if self.lockToggle then return end
if isOn==true then
self.sortCondition[1][i]=nil
else
self.sortCondition[1][i]=false
end
self:refreshPageItemToggle()
end)
end
self.lockToggle=false

self:refreshPageItemToggle()
oneWidget:SetChildToggleChange(1,function(name,isOn)
if self.lockToggle then return end
self:selectPageAll(isOn)
end)

local twoWidget=self.pageTwoItem:getChildWidgetBase()

local childGrids2=twoWidget:GetChildCommonLayoutGroupWidgetList(0)
self.pageTwoNum=childGrids2.Count
local idx2=self.sortCondition[2]or 1
self.lockToggle=true
for i=1,self.pageTwoNum do
local childItem=childGrids2[i-1]
local isselect=idx2==i
childItem:SetChildToggle(0,isselect)
end
self.lockToggle=false

local showPage3=false
if self.isManager then
if zhengzhanshanhaiModel:checkJoin()then
showPage3=not zhengzhanshanhaiModel.maskPvP
end
end
self.pageThreeItem:setActive(showPage3)
if showPage3 then
self:refreshPage3()
end
end

function UIXM_ZZSH_settingWin:refreshPage3()

local threeWidget=self.pageThreeItem:getChildWidgetBase()

self.autoRever=zhengzhanshanhaiModel:checkPvPAutoReverFlag()
local childItem1=threeWidget:GetChildWidgetBase(0)
childItem1:SetChildToggle(0,self.autoRever)
self.lockToggle=true
childItem1:SetChildToggleChange(0,function(name,isOn)
if self.lockToggle then return end
self.autoRever=isOn
end)
self.lockToggle=false
end

function UIXM_ZZSH_settingWin:checkSelectOneAll()
local n=self.pageOneNum
for i=1,n do
if self.sortCondition[1][i]==false then
return false
end
end
return true
end

function UIXM_ZZSH_settingWin:refreshPageItemToggle()
local oneWidget=self.pageOneItem:getChildWidgetBase()
local isall=self:checkSelectOneAll()
self.lockToggle=true
oneWidget:SetChildToggle(1,isall)
self.lockToggle=false
end

function UIXM_ZZSH_settingWin:selectPageAll(isOn)
local oneWidget=self.pageOneItem:getChildWidgetBase()
local childGrids=oneWidget:GetChildCommonLayoutGroupWidgetList(0)
self.lockToggle=true
for i=1,childGrids.Count do
if isOn==true then
self.sortCondition[1][i]=nil
else
self.sortCondition[1][i]=false
end
local childItem=childGrids[i-1]
childItem:SetChildToggle(0,isOn)
end
self.lockToggle=false
end

function UIXM_ZZSH_settingWin:onCliskMask()
self:onCloseBtn()
end

function UIXM_ZZSH_settingWin:onCloseBtn()
local idx2=nil
local twoWidget=self.pageTwoItem:getChildWidgetBase()
local childGrids=twoWidget:GetChildCommonLayoutGroupWidgetList(0)
for i=1,childGrids.Count do
local childItem=childGrids[i-1]
local isOn=childItem:GetChildToggle(0)
if isOn then
idx2=i
break
end
end

local setting_={}
if next(self.sortCondition[1])then
setting_[1]=table.weakCopy(self.sortCondition[1])
end
if idx2~=nil and idx2>1 then
setting_[2]=idx2
end
local setting=zhengzhanshanhaiModel:getPvESetting()
local isChange=false
local isChange2=false
if setting_[1]~=nil and setting[1]~=nil then
for i=1,self.pageOneNum do
if setting_[1][i]~=setting[1][i]then
isChange=true
break
end
end
elseif setting_[1]~=nil or setting[1]~=nil then
isChange=true
end
isChange2=setting_[2]~=setting[2]
if isChange or isChange2 then
zhengzhanshanhaiModel:setPvESetting(setting_)
UIManager.info('设置成功')
end
if isChange then
UIManager:invokeUIMethod('UIXM_ZZSH_MapWin','refreshTeamEntity')
end
if isChange2 then
UIManager:invokeUIMethod('UIXM_ZZSH_MapWin','refreshSettingModel')
end
self:closeSelf()
end
