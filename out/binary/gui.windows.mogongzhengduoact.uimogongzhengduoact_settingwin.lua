







def_class("UIMoGongZhengDuoAct_SettingWin",UIWindowBase)









function UIMoGongZhengDuoAct_SettingWin:bindComponents()

self.cliskMask=UIButton.get(self,0)
self.closeBtn=UIButton.get(self,1)
self.pageOneItem=UIObject.get(self,2)
self.pageThreeItem=UIObject.get(self,3)
self.pageTwoItem=UIObject.get(self,4)

self.cliskMask:setButtonClick(function()self:onCliskMask()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)



end


function UIMoGongZhengDuoAct_SettingWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.cliskMask);self.cliskMask=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.pageOneItem);self.pageOneItem=nil;
_UIObject_release(self.pageThreeItem);self.pageThreeItem=nil;
_UIObject_release(self.pageTwoItem);self.pageTwoItem=nil;
end

















function UIMoGongZhengDuoAct_SettingWin:onLoaded(...)
self:bindComponents()
end


function UIMoGongZhengDuoAct_SettingWin:__delete()
self:unbindComponents()
end


function UIMoGongZhengDuoAct_SettingWin:onHide()

end




function UIMoGongZhengDuoAct_SettingWin:onShow(argtable,afterOnloaded)


local setting=moGongZhengDuoActModel:getPvESetting()
self.sortCondition=table.deepCopy(setting)
if self.sortCondition[1]==nil then
self.sortCondition[1]={}
end
self:refreshView()
end

function UIMoGongZhengDuoAct_SettingWin:refreshView()

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
























end

function UIMoGongZhengDuoAct_SettingWin:refreshPage3()

local threeWidget=self.pageThreeItem:getChildWidgetBase()

self.autoRever=moGongZhengDuoActModel:checkPvPAutoReverFlag()
local childItem1=threeWidget:GetChildWidgetBase(0)
childItem1:SetChildToggle(0,self.autoRever)
self.lockToggle=true
childItem1:SetChildToggleChange(0,function(name,isOn)
if self.lockToggle then return end
self.autoRever=isOn
end)
self.lockToggle=false
end

function UIMoGongZhengDuoAct_SettingWin:checkSelectOneAll()
local n=self.pageOneNum
for i=1,n do
if self.sortCondition[1][i]==false then
return false
end
end
return true
end

function UIMoGongZhengDuoAct_SettingWin:refreshPageItemToggle()
local oneWidget=self.pageOneItem:getChildWidgetBase()
local isall=self:checkSelectOneAll()
self.lockToggle=true
oneWidget:SetChildToggle(1,isall)
self.lockToggle=false
end

function UIMoGongZhengDuoAct_SettingWin:selectPageAll(isOn)
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

function UIMoGongZhengDuoAct_SettingWin:onCliskMask()
self:onCloseBtn()
end

function UIMoGongZhengDuoAct_SettingWin:onCloseBtn()
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
local setting=moGongZhengDuoActModel:getPvESetting()
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
moGongZhengDuoActModel:setPvESetting(setting_)
UIManager.info('设置成功')
end
self:closeSelf()
end
