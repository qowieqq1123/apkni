







def_class("UISystemZongMenOutgoerGiftWin",UIWindowBase)









function UISystemZongMenOutgoerGiftWin:bindComponents()

self.mask=UIButton.get(self,0)
self.root=UIObject.get(self,1)
self.pageBtnsGrid=UIObject.get(self,2)
self.selfScrollView=UIScrollViewSlow.get(self,3)
self.exchangeBtn=UIButton.get(self,4)
self.giftNumTxt=UIText.get(self,5)

self.mask:setButtonClick(function()self:onMask()end)

self.exchangeBtn:setButtonClick(function()self:onExchangeBtn()end)



end


function UISystemZongMenOutgoerGiftWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.mask);self.mask=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.pageBtnsGrid);self.pageBtnsGrid=nil;
_UIObject_release(self.selfScrollView);self.selfScrollView=nil;
_UIObject_release(self.exchangeBtn);self.exchangeBtn=nil;
_UIObject_release(self.giftNumTxt);self.giftNumTxt=nil;
end
















local _col=4
local _row=25
local _pageNum=_col*_row

local pageType={
eElse=1,
}

local pageTypeList={pageType.eElse}


local pageConfig=
{
[pageType.eElse]={
name='礼物',
bagTypes={BAG_TYPE.eItemBag},
check=function(itemid)
local itemConfig=itemsConfig.getConfig(itemid)
if itemConfig.hideWorth and itemConfig.ifxtzmyldzzl then
local pass=false
local type1=itemConfig.type1
if type1~=nil then
pass=type1==4
end
return pass
end
return false
end
},
}

local _this=nil
local _abName="ui/windows/systemzongmen/systemzongmen_outgoer_atlas_pak.ab"
local _itemCmp={
root=0,
item=1,
flag=2,
tick=3,
}



function UISystemZongMenOutgoerGiftWin:onLoaded(...)
self:bindComponents()
_this=self

self.selfScrollView:bindSlowWidget(function(...)
if self and not self.isClose then
self:bindSelfGrid(...)
end
end)
end


function UISystemZongMenOutgoerGiftWin:__delete()
self:unbindComponents()
_this=nil
end




function UISystemZongMenOutgoerGiftWin:onShow(argtable,afterOnloaded)
self.selectChangeFunc=argtable.selectChangeFunc
self.selectCallback=argtable.selectCallback
self.closeCallback=argtable.closeCallback
self.loveList=argtable.loveList or{}
self.selectPageType=1
self:initPageBtns()
self:freshSelfBag()
self:refreshGiftNumTxt()

self:doMyAnim(true,nil)
end


function UISystemZongMenOutgoerGiftWin:onHide()

end





function UISystemZongMenOutgoerGiftWin:onMask()
local callback=function()
if _this==nil then return end
if _this.closeCallback then
_this.closeCallback()
else
self:closeSelf()
end
end
self:doMyAnim(false,callback)
end


function UISystemZongMenOutgoerGiftWin:onExchangeBtn()
if self.selectCallback then
local data=self.bagDataList[self.selectItemIndex]
if data then
self.selectCallback(data)
end
else
if _this.closeCallback then
_this.closeCallback()
else
self:closeSelf()
end
end
end


function UISystemZongMenOutgoerGiftWin:doMyAnim(flag,callback)
if flag then
self.root:setChildAnchoredPosition(Vector2(-300,-9))
self.root:setChildDOAnchorPosX(298,0.25,nil)
else
self.root:setChildDOAnchorPosX(-300,0.25,callback)
end
end

function UISystemZongMenOutgoerGiftWin:getBagDataList()
local dataList={}
local pcfg=pageConfig[self.selectPageType]
local bagTypes=pcfg.bagTypes
for i,bagType in ipairs(bagTypes)do
local list=bagControl.getBagItems(bagType)
for i2,v in ipairs(list)do
if pcfg.check(v.itemid)then
local data={
itemid=v.itemid,
itemcount=v.itemcount,
itemguid=v.itemguid,
weight=itemsConfig.getItemColor(v.itemid),
}
table.insert(dataList,data)
end
end
end
if#dataList>1 then
table.sort(dataList,function(a,b)
return a.weight>b.weight
end)
end
return dataList
end

function UISystemZongMenOutgoerGiftWin:bindSelfGrid(index,item)
local data=self.bagDataList[index]
local _conf={
showname=false,
itemcount=data and data.itemcount>1 and data.itemcount or"",
showStageBg=true,
showCountBG=data and data.itemcount>1 or false,
}
local dataProp=itemsComponentHelper.getCommonFillData(data,_conf)
item:SetChildPropData(_itemCmp.item,dataProp)
if data then
item:SetChildButtonClick(_itemCmp.root,function(...)
self:onItemClick(index)
end)
item:SetChildLongTouch(_itemCmp.root,index,0.5,function(...)
self:onItemLongClick(index)
end)
item:SetChildActive(_itemCmp.flag,table.containsValue(self.loveList,data.itemid))
item:SetChildActive(_itemCmp.tick,self.selectItemIndex==index)
else
item:SetChildButtonClick(_itemCmp.root,function(...)
self:onItemEmptyClick(index)
end)
item:SetChildLongTouch(_itemCmp.root,index,0.5,function(...)
self:onItemEmptyClick(index)
end)
item:SetChildActive(_itemCmp.flag,false)
item:SetChildActive(_itemCmp.tick,false)
end
end

function UISystemZongMenOutgoerGiftWin:freshSelfBag()
self.currentPage=1
self.selfScrollView:clearSlowItems()
self.bagDataList=self:getBagDataList()
self.pageCnt=math.ceil(#self.bagDataList/_pageNum)
self:refreshBagList(true)
end

function UISystemZongMenOutgoerGiftWin:refreshBagList(notSetZero)
local showNum=self.currentPage*_pageNum
local showRow=showNum/_col
self.selfScrollView:freshSlowGrids(showNum,showRow,_col,notSetZero)
end

function UISystemZongMenOutgoerGiftWin:onEdgeEvent()
if self.currentPage>=self.pageCnt then return end
self.currentPage=self.currentPage+1
self:refreshBagList(false)
end

function UISystemZongMenOutgoerGiftWin:onItemLongClick(index)
local data=self.bagDataList[index]
if data then
local itemid=data.itemid
local itemguid=data.itemguid
itemsComponentHelper.onItemClickEx(itemid,index,itemguid,nil)
end
end

function UISystemZongMenOutgoerGiftWin:onItemEmptyClick(index)
end

function UISystemZongMenOutgoerGiftWin:onItemClick(index)
if self.selectItemIndex~=index then
if self.selectItemIndex then
local item=self.selfScrollView:getSlowItemByIndex(self.selectItemIndex-1)
item:SetChildActive(_itemCmp.tick,false)
end

self.selectItemIndex=index

local item=self.selfScrollView:getSlowItemByIndex(self.selectItemIndex-1)
item:SetChildActive(_itemCmp.tick,true)
else
if self.selectItemIndex then
local item=self.selfScrollView:getSlowItemByIndex(self.selectItemIndex-1)
item:SetChildActive(_itemCmp.tick,false)
end

self.selectItemIndex=nil
end

self:refreshGiftNumTxt()

if self.selectChangeFunc then
if self.selectItemIndex then
self.selectChangeFunc(self.bagDataList[index])
else
self.selectChangeFunc(nil)
end
end
end

function UISystemZongMenOutgoerGiftWin:refreshGiftNumTxt()
local num=self.selectItemIndex~=nil and 1 or 0
local str=FMT.fmt("礼物个数：{0}/1",num)
self.giftNumTxt:setText(str)
end

function UISystemZongMenOutgoerGiftWin:initPageBtns()
local func=function(index)
local item=self.pageBtnsGrid:getChildLayoutGroupGridItem(index-1)
self:refreshPageBtn(item,index)
end
self.pageBtnsGrid:setChildLayoutGroupCreateItems(#pageTypeList,func)
end

function UISystemZongMenOutgoerGiftWin:refreshPageBtn(item,index)
local pageType=pageTypeList[index]
local pcfg=pageConfig[pageType]
item:SetChildButtonClick(0,function()
self:onPageClick(pageType)
end)
local isSelect=pageType==self.selectPageType
self:changePageSelect(item,isSelect)

item:SetChildText(1,pcfg.name)
end

function UISystemZongMenOutgoerGiftWin:changePageSelect(item,isSelect)
local iconname=isSelect and'button_zengsongwp_2'or'button_zengsongwp_1'
item:SetChildCSImageSprite(0,_abName,iconname)
end


function UISystemZongMenOutgoerGiftWin:onPageClick(pageType)
if self.selectPageType==pageType then return end
local old=self.selectPageType
if old~=nil then
local olditem=self.pageBtnsGrid:getChildLayoutGroupGridItem(old-1)
self:changePageSelect(olditem,false)
end
local item=self.pageBtnsGrid:getChildLayoutGroupGridItem(pageType-1)
self:changePageSelect(item,true)
self.selectPageType=pageType

self:freshSelfBag()
end