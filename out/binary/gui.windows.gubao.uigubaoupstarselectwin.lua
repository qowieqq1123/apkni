







def_class("UIGuBaoUpStarSelectWin",UIWindowBase)









function UIGuBaoUpStarSelectWin:bindComponents()

self.tipstxt=UIText.get(self,0)
self.oneKeyBtn=UIButton.get(self,1)
self.noTips=UIObject.get(self,2)
self.bagGrid=UIObject.get(self,3)

self.oneKeyBtn:setButtonClick(function()self:onOneKeyBtn()end)



end


function UIGuBaoUpStarSelectWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.tipstxt);self.tipstxt=nil;
_UIObject_release(self.oneKeyBtn);self.oneKeyBtn=nil;
_UIObject_release(self.noTips);self.noTips=nil;
_UIObject_release(self.bagGrid);self.bagGrid=nil;
end
















local _this=nil


function UIGuBaoUpStarSelectWin:onLoaded(...)
self:bindComponents()
_this=self
end


function UIGuBaoUpStarSelectWin:__delete()
self:unbindComponents()
_this=nil
end


function UIGuBaoUpStarSelectWin:onHide()

end




function UIGuBaoUpStarSelectWin:onShow(argtable,afterOnloaded)
self.lockcolor=argtable.lockcolor
self.needcnt=argtable.needcnt
self.goodIndex=argtable.goodIndex
self.goodlist=argtable.goodlist
self.onNewBack=argtable.onNewBack
self.onAddBack=argtable.onAddBack
self.onSubtractBack=argtable.onSubtractBack
self.onOneKeyBack=argtable.onOneKeyBack
self:resetSelectList()

self:updataBagView()
self:initView()
end

function UIGuBaoUpStarSelectWin:initView()
local tips_str
if self.lockcolor>0 then
tips_str=FMT.fmt('{0}古宝满星后的碎片可供使用',eQualityColorName[self.lockcolor])
else
tips_str=FMT.fmt('{0}及以上古宝满星后的碎片可供使用',eQualityColorName[math.abs(self.lockcolor)])
end
self.tipstxt:setText(tips_str)
end

function UIGuBaoUpStarSelectWin:resetSelectList()
self.selectList={}
for i,v in ipairs(self.goodlist)do
local itemguid=v.item.itemguid
local cnt=v.cnt
self.selectList[tostring(itemguid)]={cnt,i}
end
end

function UIGuBaoUpStarSelectWin:getBaglist()
if self.lockcolor>0 then
self.baglist=gubaoLookup:getGoodsSortList3(self.lockcolor)
else
self.baglist=gubaoLookup:getGoodsSortList4(math.abs(self.lockcolor))
end
end

function UIGuBaoUpStarSelectWin:updataBagView()
self:getBaglist()
local c=#self.baglist
self.bagGrid:setChildLayoutGroupCreateItems(c,function(idx)
if _this==nil then return end
_this:refreshItemView(nil,idx)
end)
local isShow=c>0
self.oneKeyBtn:setActive(isShow)
self.noTips:setActive(not isShow)
end

function UIGuBaoUpStarSelectWin:refreshItemView(item,idx)
if item==nil then
item=self.bagGrid:getChildLayoutGroupGridItem(idx-1)
end
local data=self.baglist[idx]

local itemData=data.item
local itemid=itemData.itemid
local itemguid=itemData.itemguid
local itemcount=itemData.itemcount
local selectData=self.selectList[tostring(itemguid)]
local scount=0
if selectData then scount=selectData[1]end


local conf={itemid=itemid,itemcount='',showname=false,itemIndex=idx}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetChildPropData(0,prop)
local itemWidget=item:GetChildWidgetBase(0)
itemsComponentHelper.setUIBaseItemSmallSign(itemWidget,conf)
item:SetBaseItemClickEvent(0,function(...)
self:onItemClick(...)
end)

local itemConfig=itemsConfig.getConfig(itemid)
item:SetChildText(1,itemConfig.name)

local mixCount=0
local maxCount=itemcount
local curCount=scount
item:SetChildSliderInit(2,curCount,mixCount,maxCount,function(value)
if _this==nil then return end
_this:on_slider_change(idx,value)
end)
self:refreshItemSlider(item,idx,curCount,maxCount)
end

function UIGuBaoUpStarSelectWin:refreshItemSlider(item,idx,cur,max)
if item==nil then
item=self.bagGrid:getChildLayoutGroupGridItem(idx-1)
end

item:SetChildText(3,FMT.fmt('{0}/{1}',cur,max))
end

function UIGuBaoUpStarSelectWin:on_slider_change(idx,value)
if self.lockSlider then return end
local item=self.bagGrid:getChildLayoutGroupGridItem(idx-1)

local itemData=self.baglist[idx].item
local itemguid=itemData.itemguid
local itemcount=itemData.itemcount
local guid_str=tostring(itemguid)
local selectData=self.selectList[guid_str]
if value>itemcount then return end
if value<0 then return end

if selectData==nil then
if value<=0 then return end

local c=#self.goodlist
local flag,nennum=self.onNewBack(self.goodIndex,c,itemData,value)
if flag==nil then return end
if flag then
local n_idx=c+1
self.selectList[guid_str]={nennum,n_idx}
end
if nennum~=value then
self.lockSlider=true
item:SetChildSliderValue(2,nennum)
self.lockSlider=nil
self:refreshItemSlider(item,idx,nennum,itemcount)
end
else

local cur=selectData[1]
if value==cur then return end
if cur<value then

local flag,nennum=self.onAddBack(self.goodIndex,selectData[2],itemData,value)
if flag==nil then return end
if flag then
selectData[1]=nennum
end
self.lockSlider=true
item:SetChildSliderValue(2,nennum)
self.lockSlider=nil
self:refreshItemSlider(item,idx,nennum,itemcount)
else

local flag=self.onSubtractBack(self.goodIndex,selectData[2],itemData,value)
if flag==nil then return end

if not flag then
self:resetSelectList()
else
selectData[1]=value
end
self:refreshItemSlider(item,idx,value,itemcount)
end
end
end

function UIGuBaoUpStarSelectWin:onItemClick(itemid,index,guid,attach)
tipsManager.showTips({itemid=itemid,itemguid=guid,attach=attach})
end

function UIGuBaoUpStarSelectWin:onOneKeyBtn()
if#self.baglist<0 then return end

local list={}
local needcnt=self.needcnt
for i,v in ipairs(self.baglist)do
local itemData=v.item
local itemcount=itemData.itemcount
if itemcount>needcnt then
local d={item=itemData,cnt=needcnt}
table.insert(list,d)
break
else
local d={item=itemData,cnt=itemcount}
table.insert(list,d)
needcnt=needcnt-itemcount
if needcnt<=0 then
break
end
end
end
if#list<0 then return end

if self.onOneKeyBack(self.goodIndex,list)~=true then return end

self.goodlist=list
self:resetSelectList()

self:updataBagView()
end