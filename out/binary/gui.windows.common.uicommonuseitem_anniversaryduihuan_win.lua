







def_class("UICommonUseItem_anniversaryDuiHuan_Win",UIWindowBase)









function UICommonUseItem_anniversaryDuiHuan_Win:bindComponents()

self.addBtn=UIButton.get(self,0)
self.buyGrid=UIObject.get(self,1)
self.cancelButton=UIButton.get(self,2)
self.cancelText=UIText.get(self,3)
self.closeBtn=UIButton.get(self,4)
self.costGrid=UIObject.get(self,5)
self.goodsScrollView=UIObject.get(self,6)
self.handleImg=UIObject.get(self,7)
self.okButton=UIButton.get(self,8)
self.okText=UIText.get(self,9)
self.selectCntSlider=UIObject.get(self,10)
self.selectCntText=UIText.get(self,11)
self.subBtn=UIButton.get(self,12)
self.titleText=UIText.get(self,13)

self.addBtn:setButtonClick(function()self:onAddBtn()end)

self.cancelButton:setButtonClick(function()self:onCancelButton()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.okButton:setButtonClick(function()self:onOkButton()end)

self.subBtn:setButtonClick(function()self:onSubBtn()end)



end


function UICommonUseItem_anniversaryDuiHuan_Win:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.addBtn);self.addBtn=nil;
_UIObject_release(self.buyGrid);self.buyGrid=nil;
_UIObject_release(self.cancelButton);self.cancelButton=nil;
_UIObject_release(self.cancelText);self.cancelText=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.costGrid);self.costGrid=nil;
_UIObject_release(self.goodsScrollView);self.goodsScrollView=nil;
_UIObject_release(self.handleImg);self.handleImg=nil;
_UIObject_release(self.okButton);self.okButton=nil;
_UIObject_release(self.okText);self.okText=nil;
_UIObject_release(self.selectCntSlider);self.selectCntSlider=nil;
_UIObject_release(self.selectCntText);self.selectCntText=nil;
_UIObject_release(self.subBtn);self.subBtn=nil;
_UIObject_release(self.titleText);self.titleText=nil;
end
















local _this




function UICommonUseItem_anniversaryDuiHuan_Win:onLoaded(...)
self:bindComponents()
_this=self
end


function UICommonUseItem_anniversaryDuiHuan_Win:__delete()
self:unbindComponents()
_this=nil
end




function UICommonUseItem_anniversaryDuiHuan_Win:onShow(argtable,afterOnloaded)
local showdata=argtable
self.showdata=showdata

self.titleText:setText(showdata.title)
self.okText:setText(showdata.oktext)

self.max=showdata.max or 99
self.min=1
if self.max==0 then
self.max=1
end
self.selectCnt=self.min

if self.max<=1 then
self.selectCntSlider:setActive(false)
end

if showdata.canceltext~=nil then
self.cancelText:setText(showdata.canceltext)
else
self.cancelButton:setActive(false)
end
if showdata.showclosebtn then
self.closeBtn:setActive(showdata.showclosebtn)
else
self.closeBtn:setActive(false)
end

local func=function(...)
if _this==nil then return end
_this:onSliderChange(...)
end
self.lockSlider=true
self.winlua:SetChildImageRaycast(self.handleImg:getID(),self.max>1)
self.winlua:SetChildSliderInit(self.selectCntSlider:getID(),self.selectCnt,self.min,self.max,func)
self.winlua:SetChildSliderValue(self.selectCntSlider:getID(),self.selectCnt)
self.selectCntText:setText(self.selectCnt)
self.lockSlider=false

self:initGoods()
end


function UICommonUseItem_anniversaryDuiHuan_Win:onHide()

end



function UICommonUseItem_anniversaryDuiHuan_Win:initGoods()
local cnt=0
local c

local buys=self.showdata.buyGoods
c=#buys
cnt=cnt+c
self.buyGrid:setChildLayoutGroupCreateItems(c)
local grids1=self.buyGrid:getChildLayoutGroupGridList()
for i=1,c do
local item1=grids1[i-1]
local d1=buys[i]
local itemid=d1[1]
local itemnum=d1[2]*self.selectCnt
local countStr=mathHelper.formatNumber4(itemnum,1)
local conf={itemid=itemid,itemcount=countStr,showCountBG=true,showname=false}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item1:SetChildPropData(0,prop)
item1:SetBaseItemClickEvent(0,function(...)
if _this==nil then return end
_this:onClickItem(...)
end)
end

local costs=self.showdata.costGoods
c=#costs
cnt=cnt+c
self.costGrid:setChildLayoutGroupCreateItems(c)
local grids2=self.costGrid:getChildLayoutGroupGridList()
for i=1,c do
local item2=grids2[i-1]
local d2=costs[i]
local itemid=d2[1]
local itemnum=d2[2]*self.selectCnt

local countStr
if moneyConfig.isMoney(itemid)then
local hasnum=moneyModel.getMoney(itemid)
countStr=mathHelper.formatNumber4(hasnum,1)
else
local hasnum=bagModel.getNotExpireItemCountById(itemid)
countStr=mathHelper.formatNumber4(hasnum,1)
end
local conf={itemid=itemid,itemcount=countStr,showCountBG=true,showname=false}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item2:SetChildPropData(0,prop)
item2:SetBaseItemClickEvent(0,function(...)
if _this==nil then return end
_this:onClickItem(...)
end)

item2:SetChildText(1,mathHelper.formatNumber4(itemnum,1))
end
self.goodsScrollView:setChildScrollRectEnable(cnt>5)
end

function UICommonUseItem_anniversaryDuiHuan_Win:refreshGoods()
local c

local buys=self.showdata.buyGoods
c=#buys
local grids1=self.buyGrid:getChildLayoutGroupGridList()
for i=1,c do
local item1=grids1[i-1]
local d1=buys[i]
local itemid=d1[1]
local itemnum=d1[2]*self.selectCnt
local countStr=mathHelper.formatNumber4(itemnum,1)
local conf={itemid=itemid,itemcount=countStr,showCountBG=true,showname=false}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item1:SetChildPropData(0,prop)
end

local costs=self.showdata.costGoods
c=#costs
local grids2=self.costGrid:getChildLayoutGroupGridList()
for i=1,c do
local item2=grids2[i-1]
local d2=costs[i]
local itemid=d2[1]
local itemnum=d2[2]*self.selectCnt
local countStr=mathHelper.formatNumber4(itemnum,1)
item2:SetChildText(1,countStr)
end
end

function UICommonUseItem_anniversaryDuiHuan_Win:onClickItem(itemId,index,guid,attach)
tipsManager.showTips({itemid=itemId,itemguid=nil,move=TIPS_MOVE_POS.eRight})
end

function UICommonUseItem_anniversaryDuiHuan_Win:onSliderChange(value)
if self.lockSlider==true then return end
self.selectCnt=value
self.selectCntText:setText(self.selectCnt)
self:refreshGoods()
end

function UICommonUseItem_anniversaryDuiHuan_Win:onCloseBtn()
self:doClose()
end

function UICommonUseItem_anniversaryDuiHuan_Win:onBGClick()
self:doClose()
end

function UICommonUseItem_anniversaryDuiHuan_Win:doClose()
local closecallback=self.showdata.closecallback
self:closeSelf()
if closecallback then
closecallback()
end
end

function UICommonUseItem_anniversaryDuiHuan_Win:onCancelButton()
self:closeSelf()
end

function UICommonUseItem_anniversaryDuiHuan_Win:onOkButton()
local okcallback=self.showdata.okcallback
local selectCnt=self.selectCnt
if selectCnt>self.max then
selectCnt=self.max
end
self:closeSelf()
if okcallback then
okcallback(selectCnt)
end
end

function UICommonUseItem_anniversaryDuiHuan_Win:onSubBtn()
if self.selectCnt<=1 then
return
end
self.selectCnt=self.selectCnt-1
self.winlua:SetChildSliderValue(self.selectCntSlider:getID(),self.selectCnt)
end

function UICommonUseItem_anniversaryDuiHuan_Win:onAddBtn()
if self.max<=1 then
return
end

if self.min==self.max then
return
end
if self.selectCnt>=self.max then
return
end
self.selectCnt=self.selectCnt+1
self.winlua:SetChildSliderValue(self.selectCntSlider:getID(),self.selectCnt)
end

