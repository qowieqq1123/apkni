







def_class("UIXM_ZZSH_filterWin",UIWindowBase)









function UIXM_ZZSH_filterWin:bindComponents()

self.cliskMask=UIButton.get(self,0)
self.pageOneItem=UIObject.get(self,1)
self.pageTwoItem=UIObject.get(self,2)
self.titleName=UIText.get(self,3)
self.closeBtn=UIButton.get(self,4)
self.btnReset=UIButton.get(self,5)
self.btnConfirm=UIButton.get(self,6)

self.cliskMask:setButtonClick(function()self:onCliskMask()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.btnReset:setButtonClick(function()self:onBtnReset()end)

self.btnConfirm:setButtonClick(function()self:onBtnConfirm()end)



end


function UIXM_ZZSH_filterWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.cliskMask);self.cliskMask=nil;
_UIObject_release(self.pageOneItem);self.pageOneItem=nil;
_UIObject_release(self.pageTwoItem);self.pageTwoItem=nil;
_UIObject_release(self.titleName);self.titleName=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.btnReset);self.btnReset=nil;
_UIObject_release(self.btnConfirm);self.btnConfirm=nil;
end

















function UIXM_ZZSH_filterWin:onLoaded(...)
self:bindComponents()
local nameList2={300,600,1200,1800,3600}
self.nameList2=nameList2
end


function UIXM_ZZSH_filterWin:__delete()
self:unbindComponents()
end


function UIXM_ZZSH_filterWin:onHide()

end




function UIXM_ZZSH_filterWin:onShow(argtable,afterOnloaded)
self.infotype=argtable.infotype
self.callback=argtable.callback
self.sortCondition=table.deepCopy(argtable.sortCondition)
if self.sortCondition[1]==nil then
self.sortCondition[1]={}
end

local nameList={}
for i=5,1,-1 do
local name
if self.infotype==zhengzhanshanhaiModel.qbType.eMonster then
name=FMT.fmt('{0}阶异兽',eNumberType:getName(i))
else
name=FMT.fmt('{0}阶宝地',eNumberType:getName(i))
end
table.insert(nameList,name)
end
self.nameList=nameList

self:refreshView()
end

function UIXM_ZZSH_filterWin:refreshView()

local title_str
local title_str2
if self.infotype==zhengzhanshanhaiModel.qbType.eMonster then
title_str='异兽筛选'
title_str2='异兽等阶'
else
title_str='宝地筛选'
title_str2='宝地等阶'
end
self.titleName:setText(title_str)

local oneWidget=self.pageOneItem:getChildWidgetBase()

oneWidget:SetChildText(0,title_str2)

local childnum=#self.nameList
oneWidget:SetChildLayoutGroupCreateItems(1,childnum)
local childGrids=oneWidget:GetChildLayoutGroupGridList(1)
for i=1,childnum do
local childItem=childGrids[i-1]
local isselect=self.sortCondition[1][i]or false
self.lockToggle=true
childItem:SetChildToggle(0,isselect)
self.lockToggle=false
childItem:SetChildToggleChange(0,function(name,isOn)
if self.lockToggle then return end
self.sortCondition[1][i]=isOn==true and true or nil
self:refreshPageItemToggle()
end)
childItem:SetChildText(1,self.nameList[i])
end

self:refreshPageItemToggle()
oneWidget:SetChildToggleChange(2,function(name,isOn)
if self.lockToggle then return end
self:selectPageAll(isOn)
end)

local twoWidget=self.pageTwoItem:getChildWidgetBase()

twoWidget:SetChildText(0,'出击路程')


local childnum2=#self.nameList2
twoWidget:SetChildLayoutGroupCreateItems(1,childnum2)
local childGrids2=twoWidget:GetChildLayoutGroupGridList(1)
for i=1,childnum2 do
local childItem=childGrids2[i-1]
local isselect=self.sortCondition[2]==self.nameList2[i]
self.lockToggle=true
childItem:SetChildToggle(0,isselect)
self.lockToggle=false
local str=FMT.fmt('{0}分钟以内',self.nameList2[i]/60)
childItem:SetChildText(1,str)
end
end

function UIXM_ZZSH_filterWin:checkSelectOneAll()
if self.sortCondition[1]~=nil then
local n=#self.nameList
for i=1,n do
if self.sortCondition[1][i]==nil then
return false
end
end
return true
end
return false
end

function UIXM_ZZSH_filterWin:refreshPageItemToggle()
local oneWidget=self.pageOneItem:getChildWidgetBase()
local isall=self:checkSelectOneAll()
self.lockToggle=true
oneWidget:SetChildToggle(2,isall)
self.lockToggle=false
end

function UIXM_ZZSH_filterWin:selectPageAll(isOn)
local oneWidget=self.pageOneItem:getChildWidgetBase()
local childGrids=oneWidget:GetChildLayoutGroupGridList(1)
for i=1,childGrids.Count do
self.sortCondition[1][i]=isOn==true and true or nil
local childItem=childGrids[i-1]
self.lockToggle=true
childItem:SetChildToggle(0,isOn)
self.lockToggle=false
end
end

function UIXM_ZZSH_filterWin:onCliskMask()
self:onCloseBtn()
end

function UIXM_ZZSH_filterWin:onCloseBtn()
self:closeSelf()
end

function UIXM_ZZSH_filterWin:onBtnReset()
self.sortCondition[1]={}
self.sortCondition[2]=nil
self:refreshView()
end

function UIXM_ZZSH_filterWin:onBtnConfirm()
local time=nil
local twoWidget=self.pageTwoItem:getChildWidgetBase()
local childGrids=twoWidget:GetChildLayoutGroupGridList(1)
for i=1,childGrids.Count do
local childItem=childGrids[i-1]
local isOn=childItem:GetChildToggle(0)
if isOn then
time=self.nameList2[i]
break
end
end
self.sortCondition[2]=time
if self.callback then
self.callback(table.deepCopy(self.sortCondition))
end
self:onCloseBtn()
end
