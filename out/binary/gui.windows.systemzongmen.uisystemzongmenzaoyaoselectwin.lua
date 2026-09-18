







def_class("UISystemZongMenZaoYaoSelectWin",UIWindowBase)









function UISystemZongMenZaoYaoSelectWin:bindComponents()

self.selectBtn=UIButton.get(self,0)
self.sortTypeDropdown=UIDropdown.get(self,1)
self.sortConditionButton=UIButton.get(self,2)
self.sortOrderButton=UIButton.get(self,3)
self.closeBtn=UIButton.get(self,4)
self.listPanel=UIObject.get(self,5)

self.selectBtn:setButtonClick(function()self:onSelectBtn()end)

self.sortConditionButton:setButtonClick(function()self:onSortConditionButton()end)

self.sortOrderButton:setButtonClick(function()self:onSortOrderButton()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)



end


function UISystemZongMenZaoYaoSelectWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.selectBtn);self.selectBtn=nil;
_UIObject_release(self.sortTypeDropdown);self.sortTypeDropdown=nil;
_UIObject_release(self.sortConditionButton);self.sortConditionButton=nil;
_UIObject_release(self.sortOrderButton);self.sortOrderButton=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.listPanel);self.listPanel=nil;
end
















local _this=nil
local _itemCmp={
owner=-1,
selected=0,
jingjieTx=1,
loyaltyTx=2,
posTx=3,
headSlot=4,
head=5,
headEmpty=6,
name=7,
}



function UISystemZongMenZaoYaoSelectWin:onLoaded(...)
self:bindComponents()
_this=self
self.sortTypeDropdown:setChangeAction(function(...)self:onDropdownChange(...)end)
end


function UISystemZongMenZaoYaoSelectWin:__delete()
self:unbindComponents()
_this=nil
end




function UISystemZongMenZaoYaoSelectWin:onShow(argtable,afterOnloaded)
self.callback=argtable.callback
self.dataList=argtable.dataList
self.current=argtable.current
self.selected=argtable.current
self.sortTypeList=argtable.sortList
self.sortType=argtable.defaultSort

self.sortTypeDropdown:setOption(eDiscipleSortTypeName:getName2List2(self.sortTypeList))
for i,v in ipairs(self.sortTypeList)do
if v==self.sortType then
self.sortTypeIndex=i
end
end
if self.sortTypeIndex==nil then
self.sortTypeIndex=1
self.sortType=self.sortTypeList[self.sortTypeIndex]
end
self.sortTypeDropdown:setValue(self.sortTypeIndex-1)
self.sortOrder=eSortOrder.eDown
self.sortParams={[-1]=true}
self:initListPanel()
end


function UISystemZongMenZaoYaoSelectWin:onHide()

end




function UISystemZongMenZaoYaoSelectWin:onSelectBtn()
if self.callback and self.current~=self.selected then
for i,v in ipairs(self.dataList)do
local data=v.netData.net
if mathHelper.compareInt64(data.discipleguid,self.selected)then
self.callback(data)
break
end
end
end
self:closeSelf()
end


function UISystemZongMenZaoYaoSelectWin:onSortConditionButton()
local filterName,filterFlag=discipleLookup:getConditonFilterEx(self.sortCondition)
self.filterName=filterName
local args={}
args.titleName=cfgHelper.getlang('filter_title_name')
args.pos=1
args.extraWin='UIFilterWin'
local extraParams={filterName=filterName,filterFlag=filterFlag,comfirmCallback=self.selecConditionBack}
args.extraParams=extraParams
UIFullSystemZongMenControl:showWindow('UICommonPageWin',args)
end


function UISystemZongMenZaoYaoSelectWin:onSortOrderButton()
self.sortOrder=not self.sortOrder
self:initListPanel()
end


function UISystemZongMenZaoYaoSelectWin:onCloseBtn()
self:closeSelf()
end

function UISystemZongMenZaoYaoSelectWin:onDropdownChange(idx)
idx=idx+1
self.sortType=idx
self:initListPanel()
end

function UISystemZongMenZaoYaoSelectWin.selecConditionBack(data)
if _this==nil then
return
end
local filterFlag=data.filterFlag
_this.sortCondition={}
for i,v in ipairs(filterFlag)do
_this.sortCondition[i]={}
local fns=_this.filterName[i][2]
for i1,v1 in ipairs(v)do
if v1==true then
table.insert(_this.sortCondition[i],fns[i1].typeid)
end
end
end

_this:initListPanel()
end

function UISystemZongMenZaoYaoSelectWin:initListPanel()
discipleLookup:sortList(self.dataList,self.sortType,self.sortOrder,self.sortParams)
self.winlua:SetChildLayoutGroupCreateItems(self.listPanel:getID(),#self.dataList,function(idx)
self:refreshItem(idx)
end)
end

function UISystemZongMenZaoYaoSelectWin:refreshItem(index)
local item=self.winlua:GetChildLayoutGroupGridItem(self.listPanel:getID(),index-1)
local data=self.dataList[index]
item:SetChildActive(_itemCmp.selected,self.selected==data.netData.net.discipleguid)
item:SetChildText(_itemCmp.name,data.netData.net.disciplename)
item:SetChildText(_itemCmp.jingjieTx,UIDiscipleModel:getJJNameEx(data.netData.net.jingjielv))
item:SetChildText(_itemCmp.loyaltyTx,data.netData.net.loyalty)
local pos=UIDiscipleModel:getDisciplePostEX(data.netData.net)

item:SetChildText(_itemCmp.posTx,eZongMenPostType.getName(pos))
local modelParams=UIDiscipleModel:getDiscipleInsideModelInfoEx(data.netData.net)
comHelper.setChildModelRawImageEx(_itemCmp.head,item,modelParams)
item:SetChildButtonClick(_itemCmp.owner,function()
self:onClickItem(index)
end)
end

function UISystemZongMenZaoYaoSelectWin:onClickItem(index)
local data=self.dataList[index]
local discipleguid=data.netData.net.discipleguid
if self.selected~=discipleguid then
local cmpId=self.listPanel:getID()
if self.selected then
for i,v in ipairs(self.dataList)do
if mathHelper.compareInt64(v.netData.net.discipleguid,self.selected)then
local item=self.winlua:GetChildLayoutGroupGridItem(cmpId,i-1)
item:SetChildActive(_itemCmp.selected,false)
break
end
end
end
self.selected=discipleguid
local item=self.winlua:GetChildLayoutGroupGridItem(cmpId,index-1)
item:SetChildActive(_itemCmp.selected,true)
end
end