







def_class("UIPushGiftSelectWin",UIWindowBase)









function UIPushGiftSelectWin:bindComponents()

self.cancalButton=UIButton.get(self,0)
self.enterButton=UIButton.get(self,1)
self.title=UIText.get(self,2)
self.selectText=UIText.get(self,3)
self.name=UIText.get(self,4)
self.packScrollerView=UIObject.get(self,5)
self.Content=UIObject.get(self,6)
self.rewardBg_1=UIObject.get(self,7)
self.rewardBg_2=UIObject.get(self,8)
self.rewardBg_3=UIObject.get(self,9)
self.rewardBg_4=UIObject.get(self,10)
self.rewardItem_1=UIBaseItem.get(self,11)
self.rewardItem_2=UIBaseItem.get(self,12)
self.rewardItem_3=UIBaseItem.get(self,13)
self.rewardItem_4=UIBaseItem.get(self,14)
self.rewardItem_5=UIBaseItem.get(self,15)

self.cancalButton:setButtonClick(function()self:onCancalButton()end)

self.enterButton:setButtonClick(function()self:onEnterButton()end)
self.rewardBg={
self.rewardBg_1,
self.rewardBg_2,
self.rewardBg_3,
self.rewardBg_4,
}
self.rewardItem={
self.rewardItem_1,
self.rewardItem_2,
self.rewardItem_3,
self.rewardItem_4,
self.rewardItem_5,
}



end


function UIPushGiftSelectWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.cancalButton);self.cancalButton=nil;
_UIObject_release(self.enterButton);self.enterButton=nil;
_UIObject_release(self.title);self.title=nil;
_UIObject_release(self.selectText);self.selectText=nil;
_UIObject_release(self.name);self.name=nil;
_UIObject_release(self.packScrollerView);self.packScrollerView=nil;
_UIObject_release(self.Content);self.Content=nil;
_UIObject_release(self.rewardBg_1);self.rewardBg_1=nil;
_UIObject_release(self.rewardBg_2);self.rewardBg_2=nil;
_UIObject_release(self.rewardBg_3);self.rewardBg_3=nil;
_UIObject_release(self.rewardBg_4);self.rewardBg_4=nil;
_UIObject_release(self.rewardItem_1);self.rewardItem_1=nil;
_UIObject_release(self.rewardItem_2);self.rewardItem_2=nil;
_UIObject_release(self.rewardItem_3);self.rewardItem_3=nil;
_UIObject_release(self.rewardItem_4);self.rewardItem_4=nil;
_UIObject_release(self.rewardItem_5);self.rewardItem_5=nil;
self.rewardBg=nil;
self.rewardItem=nil;
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


function UIPushGiftSelectWin:onLoaded(...)
self:bindComponents()
end


function UIPushGiftSelectWin:__delete()
self:unbindComponents()
end




function UIPushGiftSelectWin:onShow(argtable,afterOnloaded)
self.itemList=argtable.itemList
self.selectLookup=argtable.selectLookup or{}
self.selectCallback=argtable.selectCallback
local hodeIndex=argtable.selectHoleIdx or 1
self.attach=argtable.attach
self.holeList=argtable.holeList
self:freshSelectLeftIndex(hodeIndex)
local max=#self.holeList

self:freshSelectRightIndex()
self.max=max
self.itemPos=itemPosList[max]
self:refreshLeftItem()
self:refreshSelectList()
end


function UIPushGiftSelectWin:onHide()

end


function UIPushGiftSelectWin:freshSelectLeftIndex(holeIndex)
self.selectLeftIndex=nil
local holeList=self.holeList
for i,v in ipairs(holeList)do
if v==holeIndex then
self.selectLeftIndex=i
return
end
end
end

function UIPushGiftSelectWin:freshSelectRightIndex()
self.selectRightIndex=nil
local leftIndex=self.selectLeftIndex
local holeIndex=self.holeList[leftIndex]
local itemIdx=self.selectLookup[holeIndex]
local rightList=self.itemList[holeIndex]
for i,v in ipairs(rightList)do
if v[1]==itemIdx then
self.selectRightIndex=i
return
end
end
end

function UIPushGiftSelectWin:refreshLeftItem()
local len=self.max
for k,v in pairs(self.rewardBg)do
local vis=(k+1)==len
v:setActive(vis)
end

for i,v in ipairs(self.rewardItem)do
self:refreshLeftGiftItem(i)
end
self:refreshSelectText()
end

function UIPushGiftSelectWin:refreshSelectList()
local leftIndex=self.selectLeftIndex
local holeIndex=self.holeList[leftIndex]
local list=self.itemList[holeIndex]
self.packScrollerView:setChildScrollViewCreateGrids(#list,5)
local grids=self.packScrollerView:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local itemWidget=grids[i-1]
if itemWidget then
self:refreshRightGiftItem(i,itemWidget)
end
end
end

function UIPushGiftSelectWin:refreshLeftGiftItem(index)
local v=self.rewardItem[index]
local holeIndex=self.holeList[index]
local itemList=self.itemList[holeIndex]
v:setActive(itemList~=nil)
if itemList then
local pos=self.itemPos[index]
v:setLocalPos(pos.x,pos.y,pos.z)
local itemWidget=v:getChildWidgetBase()
local isSelectPage=self.selectLeftIndex==index
local selectRightIdx=self.selectRightIndex
local itemInfo=selectRightIdx and itemList[selectRightIdx]and itemList[selectRightIdx][2]or nil
if itemInfo then
local itemid=itemInfo[1]
itemWidget:SetChildActive(itemCIndex.item,true)
itemWidget:SetChildActive(itemCIndex.addRoot,false)
local conf={showname=false,
showcount=true,
showCountBG=itemInfo[2]>1,
itemcount=itemInfo[2]<=1 and""or itemInfo[2],
nomalname=true,
select=false,
showStageBg=true}
local item={itemid=itemid}
local prop=itemsComponentHelper.getCommonFillData(item,conf)
itemWidget:SetChildPropData(itemCIndex.item,prop)
local longPressFunc=function(...)
itemsComponentHelper.onItemClickEx(itemid,index)
end
itemWidget:SetChildLongPress(itemCIndex.button,index,longPressFunc,nil)

local itemConfig=itemsConfig.getConfig(itemid)
local suitConfig
if itemConfig.bagType==16 then
suitConfig=cfgHelper.get2(cfg_boatequipsuitconfig_get,itemConfig.type2,itemConfig.color)
end
local isZQ=suitConfig~=nil
itemWidget:SetChildActive(itemCIndex.star,isZQ)
itemWidget:SetChildActive(itemCIndex.suitIcon,isZQ)
if isZQ then
local suitIconName=string.format("icon_suit_%d",suitConfig.icon)
itemWidget:SetChildIcon(itemCIndex.suitIcon,suitIconName,false)
local star=itemConfig.stage
itemWidget:SetChildGroundStarNum(itemCIndex.star,star)
itemWidget:SetChildStarNumber(itemCIndex.star,star)
end
else
itemWidget:SetChildActive(itemCIndex.item,false)
itemWidget:SetChildActive(itemCIndex.addRoot,true)
itemWidget:SetChildActive(itemCIndex.star,false)
itemWidget:SetChildActive(itemCIndex.suitIcon,false)
end
itemWidget:SetChildActive(itemCIndex.slect,isSelectPage)

itemWidget:SetChildButtonClick(itemCIndex.button,function()
if self.selectLeftIndex~=index then
if self.selectLeftIndex then
local olditemWidget=self.rewardItem[self.selectLeftIndex]:getChildWidgetBase()
olditemWidget:SetChildActive(itemCIndex.slect,false)
end
self.selectLeftIndex=index
self:freshSelectRightIndex()
itemWidget:SetChildActive(itemCIndex.slect,true)
self:refreshSelectList()
end
end,true)
end
end

function UIPushGiftSelectWin:refreshRightGiftItem(index,itemWidget)
local leftIndex=self.selectLeftIndex
local holeIndex=self.holeList[leftIndex]
local itemInfo=self.itemList[holeIndex][index][2]
local itemid=itemInfo[1]
local count=itemInfo[2]
local conf={showname=false,
showcount=true,
showCountBG=count>1,
itemcount=count<=1 and""or count,
nomalname=true,
select=false,
showStageBg=true}
local item={itemid=itemid,itemcount=count}

itemWidget:SetChildActive(3,false)

local prop=itemsComponentHelper.getCommonFillData(item,conf)

itemWidget:SetChildPropData(itemCIndex.item,prop)

self:refreshGiftItemSelect(itemWidget,index==self.selectRightIndex)

itemWidget:SetChildButtonClick(itemCIndex.button,function()
self:refreshGiftItemSelectByIndex(leftIndex,index)
end)
local longPressFunc=function(...)
itemsComponentHelper.onItemClickEx(itemid,index)
end
itemWidget:SetChildLongTouch(itemCIndex.button,index,0.5,longPressFunc)

local itemConfig=itemsConfig.getConfig(itemid)
local suitConfig
if itemConfig.bagType==16 then
suitConfig=cfgHelper.get2(cfg_boatequipsuitconfig_get,itemConfig.type2,itemConfig.color)
end
local isZQ=suitConfig~=nil
itemWidget:SetChildActive(itemCIndex.star,isZQ)
itemWidget:SetChildActive(itemCIndex.suitIcon,isZQ)
if isZQ then
local suitIconName=string.format("icon_suit_%d",suitConfig.icon)
itemWidget:SetChildIcon(itemCIndex.suitIcon,suitIconName,false)
local star=itemConfig.stage
itemWidget:SetChildGroundStarNum(itemCIndex.star,star)
itemWidget:SetChildStarNumber(itemCIndex.star,star)
end
end

function UIPushGiftSelectWin:refreshGiftItemSelect(itemWidget,isSelected)
itemWidget:SetChildActive(itemCIndex.addRoot,isSelected)
end

function UIPushGiftSelectWin:refreshGiftItemSelectByIndex(leftIndex,index)
if self.selectLeftIndex==leftIndex and self.selectRightIndex==index then return end

local selectRightIndex=self.selectRightIndex
self.selectRightIndex=index
if selectRightIndex then
local itemWidget=self.packScrollerView:getChildScrollViewItemWidget(selectRightIndex-1)
if itemWidget then
self:refreshGiftItemSelect(itemWidget,false)
end
end

local itemWidget=self.packScrollerView:getChildScrollViewItemWidget(index-1)
if itemWidget then
self:refreshGiftItemSelect(itemWidget,true)
end

local leftIndex=self.selectLeftIndex
local holeIndex=self.holeList[leftIndex]
local itemIdx=self.itemList[holeIndex][index][1]
self.selectLookup[holeIndex]=itemIdx
self:refreshLeftGiftItem(leftIndex)
end

function UIPushGiftSelectWin:refreshSelectText()
local num=0
for _,idx in pairs(self.selectLookup)do
num=num+1
end
self.selectText:setText(FMT.fmt("点击选择心仪的奖励（{0}/{1}）",num,self.max))
end

function UIPushGiftSelectWin:onScrollerChanged()

end




function UIPushGiftSelectWin:onCancalButton()
self:closeSelf()
end



function UIPushGiftSelectWin:onEnterButton()
self.selectCallback(self.selectLookup,self.attach)
self:closeSelf()
end

