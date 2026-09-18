







def_class("UILimitTimeGiftSelectWin",UIWindowBase)









function UILimitTimeGiftSelectWin:bindComponents()

self.cancalButton=UIButton.get(self,0)
self.enterButton=UIButton.get(self,1)
self.title=UIText.get(self,2)
self.selectText=UIText.get(self,3)
self.name=UIText.get(self,4)
self.packScrollerView=UIObject.get(self,5)
self.rewardBg2=UIObject.get(self,6)
self.rewardBg3=UIObject.get(self,7)
self.rewardBg4=UIObject.get(self,8)
self.rewardBg5=UIObject.get(self,9)
self.rewardItem1=UIBaseItem.get(self,10)
self.rewardItem2=UIBaseItem.get(self,11)
self.rewardItem3=UIBaseItem.get(self,12)
self.rewardItem4=UIBaseItem.get(self,13)
self.rewardItem5=UIBaseItem.get(self,14)
self.Content=UIObject.get(self,15)

self.cancalButton:setButtonClick(function()self:onCancalButton()end)

self.enterButton:setButtonClick(function()self:onEnterButton()end)



end


function UILimitTimeGiftSelectWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.cancalButton);self.cancalButton=nil;
_UIObject_release(self.enterButton);self.enterButton=nil;
_UIObject_release(self.title);self.title=nil;
_UIObject_release(self.selectText);self.selectText=nil;
_UIObject_release(self.name);self.name=nil;
_UIObject_release(self.packScrollerView);self.packScrollerView=nil;
_UIObject_release(self.rewardBg2);self.rewardBg2=nil;
_UIObject_release(self.rewardBg3);self.rewardBg3=nil;
_UIObject_release(self.rewardBg4);self.rewardBg4=nil;
_UIObject_release(self.rewardBg5);self.rewardBg5=nil;
_UIObject_release(self.rewardItem1);self.rewardItem1=nil;
_UIObject_release(self.rewardItem2);self.rewardItem2=nil;
_UIObject_release(self.rewardItem3);self.rewardItem3=nil;
_UIObject_release(self.rewardItem4);self.rewardItem4=nil;
_UIObject_release(self.rewardItem5);self.rewardItem5=nil;
_UIObject_release(self.Content);self.Content=nil;
end


















local itemPosList={
[1]={Vector3.New(-12,-19,0)},
[2]={Vector3.New(-67,15,0),Vector3.New(49,-55,0)},
[3]={Vector3.New(-7,47,0),Vector3.New(-100,-31,0),Vector3.New(50,-57,0)},
[4]={Vector3.New(-100,-31,0),Vector3.New(-7,47,0),Vector3.New(100,-3,0),Vector3.New(17,-92,0)},
[5]={Vector3.New(-68,91,0),Vector3.New(-115,-33,0),Vector3.New(0,15,0),Vector3.New(114,13,0),Vector3.New(22,-93,0)},
}

local itemCIndex=
{
item=0,
addRoot=1,
button=2,
slect=3,
star=4,
suitIcon=5,
}


function UILimitTimeGiftSelectWin:onLoaded(...)
self:bindComponents()
self.rewardItem=
{
self.rewardItem1,
self.rewardItem2,
self.rewardItem3,
self.rewardItem4,
self.rewardItem5
}
self.rewardBg=
{

[2]=self.rewardBg2,
[3]=self.rewardBg3,
[4]=self.rewardBg4,
[5]=self.rewardBg5,
}
end


function UILimitTimeGiftSelectWin:__delete()
self:unbindComponents()
end




function UILimitTimeGiftSelectWin:onShow(argtable,afterOnloaded)
self.actid=argtable.actid
self.subid=argtable.subid
self.rewardIndex=argtable.rewardIndex
self.itemList=argtable.itemList
self.sortIndex=argtable.sortIndex
self.perentWin=argtable.perentWin
self.subType=argtable.subType or SUB_ACTIVITY_TYPE.eXianShiLiBao
self.info=activitiesModel:getSubActInfo(self.actid,self.subType,self.subid)
self.isRoleType=self.info:isRoleType()
if self.isRoleType then
self.actHandle=activitiesHandle_xianshilibao2
else
self.actHandle=activitiesHandle_xianshilibao
end

self:refreshLeftItem()

end


function UILimitTimeGiftSelectWin:onHide()

end

function UILimitTimeGiftSelectWin:refreshLeftItem()
self.selectIndexList={}
local selectList={}
for i,v in ipairs(self.itemList)do
if#v>1 then
table.insert(selectList,{key=i,list=v})
end
end
local num=#selectList
local potList=itemPosList[num]
self.max=num
if self.rewardBg[num]then
self.rewardBg[num]:setActive(true)
end

if potList then
for i,v in ipairs(self.rewardItem)do
if potList[i]then
v:setActive(true)
v:setLocalPos(potList[i].x,potList[i].y,potList[i].z)
local itemWidget=v:getChildWidgetBase()
local index=selectList[i].key
local list=selectList[i].list
local selectData=self.actHandle:getLiBaoSelectData(self.actid,self.subid,self.rewardIndex,index)

if selectData then
local isYunZhouEquip=itemsConfig.isYunZhouComponents(list[selectData][1])
itemWidget:SetChildActive(itemCIndex.item,true)
itemWidget:SetChildActive(itemCIndex.addRoot,false)
local conf={showname=false,showcount=true,showCountBG=list[selectData][2]>1,itemcount=list[selectData][2]==1 and"",nomalname=true,select=false,showStageBg=not isYunZhouEquip}
local item={itemid=list[selectData][1],itemcount=list[selectData][2]}
local prop=itemsComponentHelper.getCommonFillData(item,conf)

itemWidget:SetChildActive(itemCIndex.suitIcon,isYunZhouEquip)
itemWidget:SetChildActive(itemCIndex.star,isYunZhouEquip)
if isYunZhouEquip then
local itemConfig=itemsConfig.getConfig(list[selectData][1])
local color=itemConfig.color
local stage=itemConfig.stage or 0
local suitConfig=cfgHelper.get2(cfg_boatequipsuitconfig_get,itemConfig.type2,color)
itemWidget:SetChildIcon(itemCIndex.suitIcon,string.format("icon_suit_%d",suitConfig.icon),false)
local starWidget=itemWidget:GetChildWidgetBase(itemCIndex.star)
for i=1,5 do
starWidget:SetChildActive(i-1,i<=stage)
end
end

itemWidget:SetChildPropData(itemCIndex.item,prop)
local longPressFunc=function(...)
itemsComponentHelper.onItemClickEx(list[selectData][1],i)
end
itemWidget:SetChildLongPress(itemCIndex.button,i,longPressFunc,nil)
else
itemWidget:SetChildActive(itemCIndex.item,false)
itemWidget:SetChildActive(itemCIndex.addRoot,true)
end

itemWidget:SetChildButtonClick(itemCIndex.button,function()
if self.selectBox~=i then
if self.selectBox then
local olditemWidget=self.rewardItem[self.selectBox]:getChildWidgetBase()
olditemWidget:SetChildActive(itemCIndex.slect,false)
end
self.selectBox=i
itemWidget:SetChildActive(itemCIndex.slect,true)

self:refreshSelectList(index,list,selectData,i)
end
end,true)



if i==1 then
self:refreshSelectList(index,list,selectData,i)
self.selectBox=i
itemWidget:SetChildActive(itemCIndex.slect,true)
end
else
v:setActive(false)
end
end
end
self:refreshSelectText()
end

function UILimitTimeGiftSelectWin:selectAndRefreshLeftItem(posIndex,itemData)
local widget=self.rewardItem[posIndex]
if widget then
local itemWidget=widget:getChildWidgetBase()
local isYunZhouEquip=itemsConfig.isYunZhouComponents(itemData[1])
itemWidget:SetChildActive(itemCIndex.item,true)
itemWidget:SetChildActive(itemCIndex.addRoot,false)
local conf={showname=false,showcount=true,showCountBG=itemData[2]>1,itemcount=itemData[2]==1 and"",nomalname=true,select=false,showStageBg=not isYunZhouEquip}
local item={itemid=itemData[1],itemcount=itemData[2]==1 and 0 or itemData[2]}
local prop=itemsComponentHelper.getCommonFillData(item,conf)
itemWidget:SetChildPropData(itemCIndex.item,prop)

itemWidget:SetChildActive(itemCIndex.suitIcon,isYunZhouEquip)
itemWidget:SetChildActive(itemCIndex.star,isYunZhouEquip)
if isYunZhouEquip then
local itemConfig=itemsConfig.getConfig(itemData[1])
local color=itemConfig.color
local stage=itemConfig.stage or 0
local suitConfig=cfgHelper.get2(cfg_boatequipsuitconfig_get,itemConfig.type2,color)
itemWidget:SetChildIcon(itemCIndex.suitIcon,string.format("icon_suit_%d",suitConfig.icon),false)
local starWidget=itemWidget:GetChildWidgetBase(itemCIndex.star)
for i=1,5 do
starWidget:SetChildActive(i-1,i<=stage)
end
end

local longPressFunc=function(...)
itemsComponentHelper.onItemClickEx(itemData[1],posIndex)
end
itemWidget:SetChildLongPress(itemCIndex.button,posIndex,longPressFunc,nil)
end
self:refreshSelectText()
end

function UILimitTimeGiftSelectWin:refreshSelectList(leftIndex,list,selectData,posIndex)
self.selectIndexList[leftIndex]=selectData
self.packScrollerView:setChildScrollViewCreateGrids(#list,5)
local grids=self.packScrollerView:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local cmp=grids[i-1]
if cmp then
local isSelected=i==selectData
self:refreshGiftItem(cmp,list[i],leftIndex,i,posIndex)
self:refreshGiftItemSelect(cmp,isSelected)
end
end
end

function UILimitTimeGiftSelectWin:refreshGiftItem(cmp,itemData,listIndex,itemIndex,posIndex)
local isYunZhouEquip=itemsConfig.isYunZhouComponents(itemData[1])
local conf={showname=false,showcount=true,showCountBG=itemData[2]>1,itemcount=itemData[2]==1 and""or itemData[2],nomalname=true,select=false,showStageBg=not isYunZhouEquip}
local item={itemid=itemData[1],itemcount=itemData[2]}

cmp:SetChildActive(3,false)

local prop=itemsComponentHelper.getCommonFillData(item,conf)


cmp:SetChildPropData(itemCIndex.item,prop)

cmp:SetChildActive(itemCIndex.suitIcon,isYunZhouEquip)
cmp:SetChildActive(itemCIndex.star,isYunZhouEquip)
if isYunZhouEquip then
local itemConfig=itemsConfig.getConfig(itemData[1])
local color=itemConfig.color
local stage=itemConfig.stage or 0
local suitConfig=cfgHelper.get2(cfg_boatequipsuitconfig_get,itemConfig.type2,color)
cmp:SetChildIcon(itemCIndex.suitIcon,string.format("icon_suit_%d",suitConfig.icon),false)
local starWidget=cmp:GetChildWidgetBase(itemCIndex.star)
for i=1,5 do
starWidget:SetChildActive(i-1,i<=stage)
end
end

cmp:SetChildButtonClick(itemCIndex.button,function()
if self.selectBox then
local widget=self.rewardItem[self.selectBox]
if widget then
local itemWidget=widget:getChildWidgetBase()
itemWidget:SetChildActive(itemCIndex.slect,false)
end
end
self.selectBox=posIndex
local widget=self.rewardItem[posIndex]
if widget then
local itemWidget=widget:getChildWidgetBase()
itemWidget:SetChildActive(itemCIndex.slect,true)
end

self:refreshGiftItemSelectByIndex(listIndex,itemIndex)

self:selectAndRefreshLeftItem(posIndex,itemData)
end)
local longPressFunc=function(...)
itemsComponentHelper.onItemClickEx(itemData[1],posIndex)
end
cmp:SetChildLongTouch(itemCIndex.button,posIndex,0.5,longPressFunc)
end

function UILimitTimeGiftSelectWin:refreshGiftItemSelect(cmp,isSelected)
cmp:SetChildActive(itemCIndex.addRoot,isSelected)
end

function UILimitTimeGiftSelectWin:refreshGiftItemSelectByIndex(index,selectIndex)
local oldselectIndex=self.selectIndexList[index]
self.selectIndexList[index]=selectIndex
if oldselectIndex then
local grid=self.packScrollerView:getChildScrollViewItemWidget(oldselectIndex-1)
if grid then
self:refreshGiftItemSelect(grid,false)
end
end

local grid=self.packScrollerView:getChildScrollViewItemWidget(selectIndex-1)
if grid then
self:refreshGiftItemSelect(grid,true)

end

end

function UILimitTimeGiftSelectWin:onScrollerChanged()

end

function UILimitTimeGiftSelectWin:refreshSelectText()
local num=0
if next(self.selectIndexList)then
for i,v in pairs(self.selectIndexList)do
num=num+1
end
end
self.selectText:setText(FMT.fmt("点击选择心仪的奖励（{0}/{1}）",num,self.max))
end




function UILimitTimeGiftSelectWin:onCancalButton()
self:closeSelf()
end



function UILimitTimeGiftSelectWin:onEnterButton()

if next(self.selectIndexList)then
for i,v in pairs(self.selectIndexList)do
self.actHandle:setLiBaoSelectData(self.actid,self.subid,self.rewardIndex,i,v)
end
if self.perentWin then
self.perentWin:refreshGiftItemByIndex(self.rewardIndex,self.sortIndex)
else
UIManager:invokeUIMethod("UILimitTimeGiftWin","refreshGiftItemByIndex",self.rewardIndex,self.sortIndex)
end
end

self:closeSelf()
end

