







def_class("UIXianJieLingShouYYXWin",UIWindowBase)









function UIXianJieLingShouYYXWin:bindComponents()

self.applyBtn=UIButton.get(self,0)
self.centerLayout=UIObject.get(self,1)
self.closeBtn=UIButton.get(self,2)
self.itemScrollView=UIScrollView.get(self,3)
self.Root=UIObject.get(self,4)
self.uiRoot=UIObject.get(self,5)

self.applyBtn:setButtonClick(function()self:onApplyBtn()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)



end


function UIXianJieLingShouYYXWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.applyBtn);self.applyBtn=nil;
_UIObject_release(self.centerLayout);self.centerLayout=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.itemScrollView);self.itemScrollView=nil;
_UIObject_release(self.Root);self.Root=nil;
_UIObject_release(self.uiRoot);self.uiRoot=nil;
end
















local _this

local _itemCmpIndex={
select=0,
item=1,
name=2,
desc=3,
select2=4,
}




function UIXianJieLingShouYYXWin:onLoaded(...)
self:bindComponents()

_this=self

local _bindWidget=function(index,item)
if _this==nil then return end
_this:bindWidget(index,item)
end
self.itemScrollView:bindScrollWidget(_bindWidget)

local _clickAction=function(id,index,guid,attach)
if _this==nil then return end
_this:onClickItem(id,index,guid,attach)
end
self.itemScrollView:setClickAction(_clickAction)
end


function UIXianJieLingShouYYXWin:__delete()

_this=nil
self:unbindComponents()
end




function UIXianJieLingShouYYXWin:onShow(argtable,afterOnloaded)
self.selectID=argtable.selectID
self.parent=argtable.parent

self.costList={}

local cfgs=cfg_xianjielingshoulibconfig()
for itemID,cfg in pairs(cfgs)do
table.insert(self.costList,{itemID,cfg.useNum,itemsConfig.getConfig(itemID).color,cfg})
end

table.sort(self.costList,function(a,b)
return a[3]>b[3]
end)

self:refreshAll()
end


function UIXianJieLingShouYYXWin:onHide()

end





function UIXianJieLingShouYYXWin:onApplyBtn()
if self.selectID==nil and self.selectIndex==nil then
UIManager.info("请选择引妖香")
return
end

local itemID=self.costList[self.selectIndex][1]
if self.parent then
self.parent:onFillItem(itemID)
end
self:closeSelf()
end

function UIXianJieLingShouYYXWin:onCloseBtn()
self:closeSelf()
end


function UIXianJieLingShouYYXWin:refreshAll()
self:refreshCostList()
end

function UIXianJieLingShouYYXWin:refreshCostList()
local len=#self.costList
self.itemScrollView:freshGridsNum(len,len,1,true)
end

function UIXianJieLingShouYYXWin:bindWidget(index,item)
local data=self.costList[index]

local itemID=data[1]
local itemNeedCount=data[2]
local itemHasCount=itemsModel.getCount(itemID)
local isEnough=itemHasCount>=itemNeedCount
local grayNum=not isEnough and 1 or 0

local itemCountStr=string.format("%s/%s",mathHelper.formatNumber4(itemHasCount,2),itemNeedCount)

local conf={itemid=itemID,itemcount=itemCountStr,showCountBG=true,showname=false,showStage=true,gray=grayNum}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)

item:SetChildPropData(_itemCmpIndex.item,prop)

local itemCfg=itemsConfig.getConfig(itemID)
item:SetChildText(_itemCmpIndex.name,itemCfg.name)

item:SetChildText(_itemCmpIndex.desc,itemCfg.desc)

local isSelect=self.selectID and self.selectID==itemID
item:SetChildActive(_itemCmpIndex.select,isSelect)
item:SetChildActive(_itemCmpIndex.select2,isSelect)

item:SetBaseItemClickEvent(_itemCmpIndex.item,function()
itemsComponentHelper.onItemClick(itemID)
end)

if isSelect then
self.selectIndex=index
end
end

function UIXianJieLingShouYYXWin:onClickItem(id,index,guid,attach)
if self.selectIndex then
local oldItem=self.itemScrollView:getGridObjectByindex(self.selectIndex-1)
oldItem:SetChildActive(_itemCmpIndex.select,false)
oldItem:SetChildActive(_itemCmpIndex.select2,false)
end

if self.selectIndex==index then self.selectIndex=nil return end

self.selectIndex=index
local item=self.itemScrollView:getGridObjectByindex(index-1)
item:SetChildActive(_itemCmpIndex.select,true)
item:SetChildActive(_itemCmpIndex.select2,true)
end