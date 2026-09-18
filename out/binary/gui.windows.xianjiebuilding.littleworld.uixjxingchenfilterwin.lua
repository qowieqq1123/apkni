







def_class("UIXJXingChenFilterWin",UIWindowBase)









function UIXJXingChenFilterWin:bindComponents()

self.applyBtn=UIButton.get(self,0)
self.btnConfirm=UIButton.get(self,1)
self.btnReset=UIButton.get(self,2)
self.cizhuiScrollView=UIObject.get(self,3)
self.closeBtn=UIButton.get(self,4)
self.colorScrollView=UIObject.get(self,5)
self.num=UIText.get(self,6)
self.pageItem_1=UIObject.get(self,7)
self.pageItem_2=UIObject.get(self,8)
self.pageItem_3=UIObject.get(self,9)
self.pageItem_4=UIObject.get(self,10)
self.resetBtn=UIButton.get(self,11)
self.setAllBtnA=UIButton.get(self,12)
self.setAllBtnASF=UIObject.get(self,13)
self.setAllBtnB=UIButton.get(self,14)
self.setAllBtnBSF=UIObject.get(self,15)
self.titleName=UIText.get(self,16)
self.zhenxiScrollView=UIObject.get(self,17)

self.applyBtn:setButtonClick(function()self:onApplyBtn()end)

self.btnConfirm:setButtonClick(function()self:onBtnConfirm()end)

self.btnReset:setButtonClick(function()self:onBtnReset()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.resetBtn:setButtonClick(function()self:onResetBtn()end)

self.setAllBtnA:setButtonClick(function()self:onSetAllBtnA()end)

self.setAllBtnB:setButtonClick(function()self:onSetAllBtnB()end)
self.pageItem={
self.pageItem_1,
self.pageItem_2,
self.pageItem_3,
self.pageItem_4,
}



end


function UIXJXingChenFilterWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.applyBtn);self.applyBtn=nil;
_UIObject_release(self.btnConfirm);self.btnConfirm=nil;
_UIObject_release(self.btnReset);self.btnReset=nil;
_UIObject_release(self.cizhuiScrollView);self.cizhuiScrollView=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.colorScrollView);self.colorScrollView=nil;
_UIObject_release(self.num);self.num=nil;
_UIObject_release(self.pageItem_1);self.pageItem_1=nil;
_UIObject_release(self.pageItem_2);self.pageItem_2=nil;
_UIObject_release(self.pageItem_3);self.pageItem_3=nil;
_UIObject_release(self.pageItem_4);self.pageItem_4=nil;
_UIObject_release(self.resetBtn);self.resetBtn=nil;
_UIObject_release(self.setAllBtnA);self.setAllBtnA=nil;
_UIObject_release(self.setAllBtnASF);self.setAllBtnASF=nil;
_UIObject_release(self.setAllBtnB);self.setAllBtnB=nil;
_UIObject_release(self.setAllBtnBSF);self.setAllBtnBSF=nil;
_UIObject_release(self.titleName);self.titleName=nil;
_UIObject_release(self.zhenxiScrollView);self.zhenxiScrollView=nil;
self.pageItem=nil;
end


















local color={FONT_COLOR.eGreenColor,FONT_COLOR.eBlueColor,FONT_COLOR.ePurpleColor}

local sortTypeList=
{
[ITEM_FILTER_TYPE.eColor]=
{
title="品质",
getNameList=function()
return{{"紫",3},{"橙",4},{"红",5}}
end
},












[ITEM_FILTER_TYPE.eXingChenZhenXi]=
{
title="珍稀",
getNameList=function()
return{{"珍稀",1}}
end
},
[ITEM_FILTER_TYPE.eItemType1]=
{
title="轨道",
getNameList=function()
return{{"东",1},{"南",2},{"西",3},{"北",4}}
end
}
}


function UIXJXingChenFilterWin:onLoaded(...)
self:bindComponents()
self.sortCondition={}
self.nameList={}
end


function UIXJXingChenFilterWin:__delete()
self:unbindComponents()
end




function UIXJXingChenFilterWin:onShow(argtable,afterOnloaded)
local defaultList={ITEM_FILTER_TYPE.eColor}
self.filterList=argtable.filterList or defaultList

self.callback=argtable.callback

self.freshNumCall=argtable.freshNumCall

if argtable.sortCondition then
self.sortCondition=argtable.sortCondition
else
for i,v in ipairs(self.filterList)do
self.sortCondition[i]={}
end
end

self:refreshView()
end


function UIXJXingChenFilterWin:onHide()

end

function UIXJXingChenFilterWin:refreshView()
for i,pageItem in ipairs(self.pageItem)do
local filterType=self.filterList[i]

if filterType then
pageItem:setActive(true)
local title=sortTypeList[filterType].title
local nameList=sortTypeList[filterType].getNameList()
self.nameList[i]=nameList

local pageWidget=pageItem:getChildWidgetBase()
local childnum=#nameList
pageWidget:SetChildText(0,title)
pageWidget:SetChildActive(2,childnum>1)

pageWidget:SetChildLayoutGroupCreateItems(1,childnum)
local childGrids=pageWidget:GetChildLayoutGroupGridList(1)
for i2=1,childnum do
local childItem=childGrids[i2-1]
local isselect=self.sortCondition[i][i2]or false
self.lockToggle=true
childItem:SetChildToggle(0,isselect)
self.lockToggle=false
childItem:SetChildToggleChange(0,function(name,isOn)
if self.lockToggle then return end
self.sortCondition[i][i2]=isOn==true and true or nil
self:refreshPageItemToggle(i)
end)
childItem:SetChildText(1,nameList[i2][1])
end

if childnum>1 then
pageWidget:SetChildToggleChange(2,function(name,isOn)
if self.lockToggle then return end
self:selectPageAll(i,isOn)
end)
end
else
pageItem:setActive(false)
end
end

if self.freshNumCall then
local sortCondition,empty=self:getSortCond()
self.freshNumCall(self,sortCondition,empty)
end
end


function UIXJXingChenFilterWin:checkSelectOneAll(pageIdx)
if self.sortCondition[pageIdx]~=nil then
local n=#self.nameList[pageIdx]or{}
for i=1,n do
if self.sortCondition[pageIdx][i]==nil then
return false
end
end
return true
end
return false
end

function UIXJXingChenFilterWin:refreshPageItemToggle(pageIdx)
local widget=self.pageItem[pageIdx]:getChildWidgetBase()
local isall=self:checkSelectOneAll(pageIdx)
self.lockToggle=true
widget:SetChildToggle(2,isall)
self.lockToggle=false

if self.freshNumCall then
local sortCondition,empty=self:getSortCond()
self.freshNumCall(self,sortCondition,empty)
end
end

function UIXJXingChenFilterWin:selectPageAll(pageIdx,isOn)
local oneWidget=self.pageItem[pageIdx]:getChildWidgetBase()
local childGrids=oneWidget:GetChildLayoutGroupGridList(1)
for i=1,childGrids.Count do
self.sortCondition[pageIdx][i]=isOn==true and true or nil
local childItem=childGrids[i-1]
self.lockToggle=true
childItem:SetChildToggle(0,isOn)
self.lockToggle=false
end
if self.freshNumCall then
local sortCondition,empty=self:getSortCond()
self.freshNumCall(self,sortCondition,empty)
end
end


function UIXJXingChenFilterWin:getSortCond()
local empty=true
local sortCondition={}
for i,v in ipairs(self.filterList)do
local list={}
local name=self.nameList[i]
for ii,vv in ipairs(name)do
if self.sortCondition[i][ii]then
local id=vv[2]
table.insert(list,id)
end
end
if#list>0 then
sortCondition[v]={ITEM_FILTER_COMPARE.eEquals,list}
empty=false
end
end
return sortCondition,empty
end





function UIXJXingChenFilterWin:onApplyBtn()
end

function UIXJXingChenFilterWin:onCliskMask()
self:onCloseBtn()
end

function UIXJXingChenFilterWin:onCloseBtn()
self:closeSelf()
end

function UIXJXingChenFilterWin:onCloseClick()
self:closeSelf()
end

function UIXJXingChenFilterWin:onBtnReset()
for i,v in ipairs(self.filterList)do
self.sortCondition[i]={}
end
self:refreshView()
end

function UIXJXingChenFilterWin:onBtnConfirm()
local sortCondition,empty=self:getSortCond()
if self.callback then
self.callback(sortCondition,table.weakCopy(self.sortCondition),empty)
end
self:onCloseBtn()
end


function UIXJXingChenFilterWin:onSetAllBtnA()
end



function UIXJXingChenFilterWin:onSetAllBtnB()
end

