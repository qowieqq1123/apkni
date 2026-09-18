







def_class("UIBaoShuZhuLingSelectWin",UIWindowBase)









function UIBaoShuZhuLingSelectWin:bindComponents()

self.bagGrid=UIObject.get(self,0)
self.noTips=UIObject.get(self,1)
self.oneKeyBtn=UIButton.get(self,2)
self.tipstxt=UIText.get(self,3)

self.oneKeyBtn:setButtonClick(function()self:onOneKeyBtn()end)



end


function UIBaoShuZhuLingSelectWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.bagGrid);self.bagGrid=nil;
_UIObject_release(self.noTips);self.noTips=nil;
_UIObject_release(self.oneKeyBtn);self.oneKeyBtn=nil;
_UIObject_release(self.tipstxt);self.tipstxt=nil;
end


















local _this=nil


function UIBaoShuZhuLingSelectWin:onLoaded(...)
self:bindComponents()
_this=self
end


function UIBaoShuZhuLingSelectWin:__delete()
self:unbindComponents()
_this=nil
end


function UIBaoShuZhuLingSelectWin:onHide()

end




function UIBaoShuZhuLingSelectWin:onShow(argtable,afterOnloaded)
self.lockcolor=argtable.lockcolor
self.maxExp=argtable.maxExp
self.goodlist=argtable.goodlist
self.onNewBack=argtable.onNewBack
self.onAddBack=argtable.onAddBack
self.onSubtractBack=argtable.onSubtractBack
self.onOneKeyBack=argtable.onOneKeyBack
self:resetSelectList()

self:updataBagView(true)
self:initView()
end

function UIBaoShuZhuLingSelectWin:initView()
local tips_str
if self.lockcolor>0 then
tips_str=FMT.fmt('{0}古宝觉醒后的碎片可供使用',eQualityColorName[self.lockcolor])
else
tips_str=FMT.fmt('{0}及以上古宝觉醒后的碎片可供使用',eQualityColorName[math.abs(self.lockcolor)])
end
self.tipstxt:setText(tips_str)
end

function UIBaoShuZhuLingSelectWin:resetSelectList()
self.selectList={}
for i,v in ipairs(self.goodlist)do
local itemguid=v.item.itemguid
local cnt=v.cnt
self.selectList[tostring(itemguid)]={cnt,i}
end
end

function UIBaoShuZhuLingSelectWin:getBaglist()
local fullstarPieceList={}
self.baglist={}
if self.lockcolor>0 then
fullstarPieceList=gubaoLookup:getGoodsSortList3(self.lockcolor)
else
fullstarPieceList=gubaoLookup:getGoodsSortList4(math.abs(self.lockcolor))
end
for i,v in ipairs(fullstarPieceList)do
local itemid=v.item.itemid
local gbid=gubaoLookup:good2GuBaoPiece(itemid)
local exp=gubaoModel:getGuBaoPieceBSZLExp(itemid)
if gbid and gubaoModel:checkAwake(gbid)and exp>0 then
table.insert(self.baglist,v)
end
end
end

function UIBaoShuZhuLingSelectWin:updataBagView(init)
if init then
self:getBaglist()
end
local c=#self.baglist
self.bagGrid:setChildLayoutGroupCreateItems(c,function(idx)
if _this==nil then return end
_this:refreshItemView(nil,idx)
end)
local isShow=c>0
self.oneKeyBtn:setActive(isShow)
self.noTips:setActive(not isShow)
end

function UIBaoShuZhuLingSelectWin:refreshItemView(item,idx)
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

function UIBaoShuZhuLingSelectWin:refreshItemSlider(item,idx,cur,max)
if item==nil then
item=self.bagGrid:getChildLayoutGroupGridItem(idx-1)
end
item:SetChildText(3,FMT.fmt('{0}/{1}',cur,max))
end

function UIBaoShuZhuLingSelectWin:on_slider_change(idx,value)
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
local flag,nennum=self.onNewBack(c,itemData,value)
if flag==nil then return end
if flag then
local n_idx=c+1
self.selectList[guid_str]={nennum,n_idx}
end
self.lockSlider=true
item:SetChildSliderValue(2,nennum)
self.lockSlider=nil
self:refreshItemSlider(item,idx,nennum,itemcount)

else

local cur=selectData[1]
if value==cur then return end
if cur<value then

local flag,nennum=self.onAddBack(selectData[2],itemData,value)
if flag==nil then return end
if flag then
selectData[1]=nennum
end
self.lockSlider=true
item:SetChildSliderValue(2,nennum)
self.lockSlider=nil
self:refreshItemSlider(item,idx,nennum,itemcount)
else

local flag=self.onSubtractBack(selectData[2],itemData,value)
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

function UIBaoShuZhuLingSelectWin:onItemClick(itemid,index,guid,attach)
tipsManager.showTips({itemid=itemid,itemguid=guid,attach=attach})
end

function UIBaoShuZhuLingSelectWin:onOneKeyBtn()
if#self.baglist<0 then return end

local list={}
local addExp=0
local _,curExp=gubaoModel:getBSZLData()
local maxExp=gubaoModel:getBSZLNextLevelNeedExp()-curExp
for i,v in ipairs(self.baglist)do
local itemData=v.item
local itemid=itemData.itemid
local itemcount=itemData.itemcount
local unit_exp=gubaoModel:getGuBaoPieceBSZLExp(itemid)
local lerp_exp=maxExp-addExp
local lerp_full=math.ceil(lerp_exp/unit_exp)
if itemcount>=lerp_full then
local d={item=itemData,cnt=lerp_full}
table.insert(list,d)
break
else
local d={item=itemData,cnt=itemcount}
table.insert(list,d)
addExp=addExp+(itemcount*unit_exp)
end
end
if#list<0 then return end

if self.onOneKeyBack(list)~=true then return end

self.goodlist=list
self:resetSelectList()

self:updataBagView()
end