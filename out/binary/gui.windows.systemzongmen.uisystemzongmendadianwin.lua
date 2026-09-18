







def_class("UISystemZongMenDaDianWin",UIWindowBase)









function UISystemZongMenDaDianWin:bindComponents()

self.switchBtn_1=UIButton.get(self,0)
self.switchBtn_2=UIButton.get(self,1)
self.view_1=UIObject.get(self,2)
self.view_2=UIObject.get(self,3)

self.switchBtn_1:setButtonClick(function()self:onSwitchBtn_1()end)

self.switchBtn_2:setButtonClick(function()self:onSwitchBtn_2()end)
self.switchBtn={
self.switchBtn_1,
self.switchBtn_2,
}
self.view={
self.view_1,
self.view_2,
}



end


function UISystemZongMenDaDianWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.switchBtn_1);self.switchBtn_1=nil;
_UIObject_release(self.switchBtn_2);self.switchBtn_2=nil;
_UIObject_release(self.view_1);self.view_1=nil;
_UIObject_release(self.view_2);self.view_2=nil;
self.switchBtn=nil;
self.view=nil;
end
















local _this=nil
local view1Cmp={
owner=-1,
leadSlot=0,
elderGrid=1,
insideGrid=2,
insiderTx=3,
}
local view2Cmp={
owner=-1,
sortTypeDropDown=0,
sortOrderButton=1,
sortConditionButton=2,
list=3,
}
local slotCmp={
owner=-1,
name=0,
head=1,
pos=2,
postxt=3,
headEmpty=4,
}
local itemCmp={
owner=-1,
selected=0,
name=1,
jingjie=2,
loyalty=3,
injured=4,
duty=5,
head=6,
headEmpty=7,
headSlot=8,
}



function UISystemZongMenDaDianWin:onLoaded(...)
self:bindComponents()
_this=self
notifySystem:listenNotify(notifyConfig.onSystemZMDetailInfo,self.onSystemZMDetailInfo)
notifySystem:listenNotify(notifyConfig.onSystemZMLoyaltyChange,self.onSystemZMLoyaltyChange)
self.page=1
self.sortParams={[-1]=true}
end


function UISystemZongMenDaDianWin:__delete()
self:unbindComponents()
_this=nil
notifySystem:removelistener(notifyConfig.onSystemZMDetailInfo,self.onSystemZMDetailInfo)
notifySystem:removelistener(notifyConfig.onSystemZMLoyaltyChange,self.onSystemZMLoyaltyChange)
end




function UISystemZongMenDaDianWin:onShow(argtable,afterOnloaded)
self.serial=argtable.serial
if systemZongMenModel:checkDetailPartInfo(self.serial,systemZongMenDetailDataPart.eDZList)then
self:initView()
self:refreshView()
end
end


function UISystemZongMenDaDianWin:onHide()

end




function UISystemZongMenDaDianWin:onSwitchBtn()
if self.dataList then
self.page=self.page==1 and 2 or 1
self:refreshView()
end
end

function UISystemZongMenDaDianWin:onSwitchBtn_1()
if self.dataList then
self.page=2
self:refreshView()
end
end

function UISystemZongMenDaDianWin:onSwitchBtn_2()
if self.dataList then
self.page=1
self:refreshView()
end
end

function UISystemZongMenDaDianWin.onSystemZMDetailInfo(partType,serial)
if serial==_this.serial and partType==systemZongMenDetailDataPart.eDZList then
_this:initView()
_this:refreshView()
end
end

function UISystemZongMenDaDianWin:onDropdownChange(idx)
self.sortTypeIndex=idx+1
self.sortType=self.sortTypeList[self.sortTypeIndex]


self:refreshViewList2()
end

function UISystemZongMenDaDianWin:onSortOrderButton()
self.sortOrder=not self.sortOrder
self:refreshViewList2()
end

function UISystemZongMenDaDianWin:onSortConditionButton()
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

function UISystemZongMenDaDianWin.selecConditionBack()
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
self:refreshViewList2()
end

function UISystemZongMenDaDianWin:refreshView()
for i,v in ipairs(self.view)do

local scale=self.page==i and 1 or 0
v:setScale(Vector3.New(scale,1,1))
end
end

function UISystemZongMenDaDianWin:initView()
self.detailInfo=systemZongMenModel:getDetailPartInfo(self.serial,systemZongMenDetailDataPart.eDZList)
self.dataList={}
if self.detailInfo.num>0 then
for i,v in ipairs(self.detailInfo.discipleList)do
table.insert(self.dataList,{netData={net=v}})
end
end
self:initView1()
self:initView2()
end

function UISystemZongMenDaDianWin:initView1()
local widget_v1=self.view_1:getWidgetBase(view1Cmp.owner)
local slot=widget_v1:GetChildWidgetBase(view1Cmp.leadSlot)
local list=self:findPosDisciple(eZongMenPostType.eZhangMen)
self:setSlot_View1(slot,eZongMenPostType.eZhangMen,list[1])

local slots=widget_v1:GetChildCommonLayoutGroupWidgetList(view1Cmp.elderGrid)
for i=1,slots.Count do
slot=slots[i-1]
local pos=i+eZongMenPostType.eJielu-1
list=self:findPosDisciple(pos)
self:setSlot_View1(slot,pos,list[1])
end

slots=widget_v1:GetChildCommonLayoutGroupWidgetList(view1Cmp.insideGrid)
list=self:findPosDisciple(eZongMenPostType.eNeiMen)
for i=1,slots.Count do
slot=slots[i-1]
self:setSlot_View1(slot,eZongMenPostType.eNeiMen,list[i])
end
end

function UISystemZongMenDaDianWin:initView2()
local widget_v2=self.view_2:getWidgetBase(view2Cmp.owner)
widget_v2:SetChildDropDownChangeAction(view2Cmp.sortTypeDropDown,function(...)self:onDropdownChange(...)end)
widget_v2:SetChildButtonClick(view2Cmp.sortOrderButton,function()self:onSortOrderButton()end)
widget_v2:SetChildButtonClick(view2Cmp.sortConditionButton,function()self:onSortConditionButton()end)

self.sortTypeList=eDiscipleSortType:getSystemZongMenList2()
widget_v2:SetChildDropDownOption(view2Cmp.sortTypeDropDown,eDiscipleSortTypeName:getName2List2(self.sortTypeList))
self.sortTypeIndex=1
self.sortType=self.sortTypeList[self.sortTypeIndex]
self.sortOrder=eSortOrder.eDown
widget_v2:SetChildDropDownValue(view2Cmp.sortTypeDropDown,self.sortTypeIndex-1)

widget_v2:SetChildLayoutGroupCreateItems(view2Cmp.list,#self.dataList)
self:refreshViewList2()
end

function UISystemZongMenDaDianWin:findPosDisciple(pos)
local list={}
for i,v in ipairs(self.dataList)do
if v.netData.net.pos==pos then
table.insert(list,v)
end
end
return list
end

function UISystemZongMenDaDianWin:setSlot_View1(slotItem,pos,discipleData)
local exsit=discipleData~=nil
local nameStr=exsit and discipleData.netData.net.disciplename or""
slotItem:SetChildText(slotCmp.name,nameStr)
local posStr=eZongMenPostType.getName(pos)
slotItem:SetChildText(slotCmp.postxt,posStr)
slotItem:SetChildActive(slotCmp.headEmpty,false)
slotItem:SetChildActive(slotCmp.head,exsit)
if exsit then
local modelParams=UIDiscipleModel:getDiscipleInsideModelInfoEx(discipleData.netData.net)
comHelper.setChildModelRawImageEx(slotCmp.head,slotItem,modelParams)
end
slotItem:SetChildButtonClick(slotCmp.owner,function()
self:onClickHead(discipleData)
end)
end

function UISystemZongMenDaDianWin:setItem_View2(listItem,discipleData)
listItem:SetChildText(itemCmp.name,discipleData.netData.net.disciplename)
local jingjieStr=UIDiscipleModel:getJJNameEx(discipleData.netData.net.jingjielv)
listItem:SetChildText(itemCmp.jingjie,jingjieStr)
listItem:SetChildText(itemCmp.loyalty,discipleData.netData.net.loyalty)
listItem:SetChildText(itemCmp.injured,discipleData.netData.net.injury)
listItem:SetChildText(itemCmp.duty,eZongMenPostType.getName(discipleData.netData.net.pos))
listItem:SetChildActive(itemCmp.headEmpty,false)
local modelParams=UIDiscipleModel:getDiscipleInsideModelInfoEx(discipleData.netData.net)
comHelper.setChildModelRawImageEx(itemCmp.head,listItem,modelParams)
listItem:SetChildButtonClick(itemCmp.headSlot,function()
self:onClickHead(discipleData)
end)
end

function UISystemZongMenDaDianWin:refreshViewList2()

discipleLookup:sortList(self.dataList,self.sortType,self.sortOrder,self.sortParams)




local widget_v2=self.view_2:getWidgetBase(view2Cmp.owner)
for i,v in ipairs(self.dataList)do
local item=widget_v2:GetChildLayoutGroupGridItem(view2Cmp.list,i-1)
self:setItem_View2(item,v)
end
end

function UISystemZongMenDaDianWin.onSystemZMLoyaltyChange(serial,list)
if _this.serial==serial then
local widget_v2=_this.view_2:getWidgetBase(view2Cmp.owner)
for i,v in ipairs(_this.dataList)do
for j,w in ipairs(list)do
if w==v.netData.net.discipleguid then
local item=widget_v2:GetChildLayoutGroupGridItem(view2Cmp.list,i-1)
item:SetChildText(itemCmp.loyalty,v.netData.net.loyalty)
break
end
end
end
end
end

function UISystemZongMenDaDianWin:onClickHead(discipleData)
if discipleData then







UIFullSystemZongMenControl:showOtherDiscipleWin(discipleData.netData.net.discipleguid,self.detailInfo.discipleList)
end
end
