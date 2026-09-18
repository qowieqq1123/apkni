







def_class("UISubAct_tianxuyishiGuBaoSelectWin",UIWindowBase)









function UISubAct_tianxuyishiGuBaoSelectWin:bindComponents()

self.addBtn=UIButton.get(self,0)
self.closeBtn=UIButton.get(self,1)
self.costItem=UIObject.get(self,2)
self.exchangeBtn=UIButton.get(self,3)
self.handleImg=UIObject.get(self,4)
self.helpBtn=UIButton.get(self,5)
self.itemScrollView=UILoopListView.new(self,6)
self.selectCntSlider=UIObject.get(self,7)
self.selectCntText=UIText.get(self,8)
self.subBtn=UIButton.get(self,9)
self.subSelectItemBtn=UIButton.get(self,10)
self.targetItem=UIObject.get(self,11)
self.tips=UIText.get(self,12)

self.addBtn:setButtonClick(function()self:onAddBtn()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.exchangeBtn:setButtonClick(function()self:onExchangeBtn()end)

self.helpBtn:setButtonClick(function()self:onHelpBtn()end)

self.itemScrollView:bindLoopListView(function(...)
self:onFreshAction(...)
end,function(...)
self:onStartAction(...)
end)
self.subBtn:setButtonClick(function()self:onSubBtn()end)

self.subSelectItemBtn:setButtonClick(function()self:onSubSelectItemBtn()end)



end


function UISubAct_tianxuyishiGuBaoSelectWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.addBtn);self.addBtn=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.costItem);self.costItem=nil;
_UIObject_release(self.exchangeBtn);self.exchangeBtn=nil;
_UIObject_release(self.handleImg);self.handleImg=nil;
_UIObject_release(self.helpBtn);self.helpBtn=nil;
self.itemScrollView:deleteSelf();self.itemScrollView=nil;
_UIObject_release(self.selectCntSlider);self.selectCntSlider=nil;
_UIObject_release(self.selectCntText);self.selectCntText=nil;
_UIObject_release(self.subBtn);self.subBtn=nil;
_UIObject_release(self.subSelectItemBtn);self.subSelectItemBtn=nil;
_UIObject_release(self.targetItem);self.targetItem=nil;
_UIObject_release(self.tips);self.tips=nil;
end


















local _colomn=6
local _row=6
local _this

function UISubAct_tianxuyishiGuBaoSelectWin:onLoaded(...)
self:bindComponents()
_this=self
self.loopListViewCmp=self.winlua:GetChildLoopListView2(self.itemScrollView:getID())
self:addNotify(notifyConfig.on_item_list_changed,function(...)self:on_item_list_changed(...)end)
end


function UISubAct_tianxuyishiGuBaoSelectWin:__delete()
self:unbindComponents()
_this=nil
end




function UISubAct_tianxuyishiGuBaoSelectWin:onShow(argtable,afterOnloaded)
self.needItemColor=argtable.needItemColor
self.needItemCount=argtable.needItemCount
self.targetItemId=argtable.targetItemId
self.targetItemCount=argtable.targetItemCount
self.colorCount=argtable.colorCount
self.okcallback=argtable.okcallback
self.dhId=argtable.dhId

self.max=argtable.max or 1
self.min=0
if self.max<=0 then
self.max=1
end
self.selectCnt=self.min

local func=function(...)
if _this==nil then return end
_this:onSliderChange(...)
end
self.lockSlider=true

self.winlua:SetChildSliderInit(self.selectCntSlider:getID(),self.selectCnt,self.min,self.max,func)
self.winlua:SetChildSliderValue(self.selectCntSlider:getID(),self.selectCnt)
self.winlua:SetChildButtonEnable(self.exchangeBtn:getID(),false,true)
self.selectCntText:setText(self.selectCnt)
self.lockSlider=false

self.selectList={}
self.itemIdLookup={}
self.selectBagIdx=1
self.diffSelectNum=0
self.curItemguid=nil
self.selectSum=0
self.diffSelectNumChanged=false
self:refreshBagList()
self:refreshTargetCostItem()
self:refreshSelectBagList(self.selectCnt)

self.isItemSelected=false
self.curItemguid=nil

if(afterOnloaded)then
if#self.bagList>0 then
local firstItem=self.bagList[1].item
self.selectList[tostring(firstItem.itemguid)]={num=0,index=1,itemid=firstItem.itemid}
self.curItemguid=tostring(firstItem.itemguid)
self.selectSum=0

for idx=1,#self.bagList do
if self.bagList[idx]then
local itemData=self.bagList[idx].item
local itemguid=tostring(itemData.itemguid)
self.selectList[tostring(itemguid)]={num=0,index=idx,itemid=itemData.itemid}
end
end
end
end
self.tips:setText(string.format("以下为宗门可兑换为天墟券的道具，根据选择兑换次数，自动选择道具。也可点击道具自主调整选择。",eQualityColorName_GB[self.needItemColor]))
end

function UISubAct_tianxuyishiGuBaoSelectWin:on_item_list_changed(argstable)
if not self.bagList or#self.bagList==0 then
return
end

local needRefreshIdx={}
local seen={}
for _,v in ipairs(argstable or{})do
local itemid=v[3]
local has=v[5]
if itemid and itemid>0 and has and has>0 then
for idx,data in ipairs(self.bagList or{})do
local itemData=data.item
if itemData and itemData.itemid==itemid then
itemData.itemcount=has
if not seen[idx]then
seen[idx]=true
table.insert(needRefreshIdx,idx)
end
end
end
end
end

for _,idx in ipairs(needRefreshIdx)do
if self.refreshBagListItem then
self:refreshBagListItem(idx)
end
end

if self.refreshTargetCostItem then
self:refreshTargetCostItem()
end
end

function UISubAct_tianxuyishiGuBaoSelectWin:refreshTargetCostItem()
local targetItemWidget=self.targetItem:getWidgetBase()
local itemid=self.targetItemId
local itemcount=self.targetItemCount*self.selectCnt
local conf={itemid=itemid,itemcount=itemcount,showCountBG=true,showname=false}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
targetItemWidget:SetChildPropData(0,prop)
targetItemWidget:SetBaseItemClickEvent(0,function(...)
self:onItemClick(...)
end)
local costItemWidget=self.costItem:getWidgetBase()
local itemcount=self.needItemCount*self.selectCnt
local iconColor=self.needItemColor
local itemid=cfgHelper.get2(cfg_tianxuyishiduihuanconfig_get,self.dhId,'itemid')
local conf={itemid=itemid,itemcount='',showCountBG=false,showname=false,iconColor=iconColor}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
costItemWidget:SetChildPropData(0,prop)
costItemWidget:SetBaseItemClickEvent(0,function(...)
self:onItemClick(...)
end)
costItemWidget:SetChildText(1,string.format("%d/%d",self.colorCount,itemcount))
end

function UISubAct_tianxuyishiGuBaoSelectWin:onSliderChange(newSelectCnt)
if self.lockSlider==true then return end
if newSelectCnt<0 then newSelectCnt=0 end
if newSelectCnt>self.max then newSelectCnt=self.max end
if self.diffSelectNumChanged==false then
self.diffSelectNum=(newSelectCnt-self.selectCnt)*self.needItemCount
end

self.selectCnt=newSelectCnt
self.selectCntText:setText(newSelectCnt)
self:refreshSelectBagList(self.diffSelectNum)
self:refreshTargetCostItem()
local isInteractable=self.selectCnt>0
self.winlua:SetChildButtonEnable(self.exchangeBtn:getID(),isInteractable,not isInteractable)
end

function UISubAct_tianxuyishiGuBaoSelectWin:refreshSelectBagList(diffNum)
local needCount=diffNum
self.selectSum=self.selectSum+diffNum
if self.selectSum<0 then self.selectSum=0 end
if self.selectSum>self.colorCount then self.selectSum=self.colorCount end
if self.selectBagIdx<1 then self.selectBagIdx=1 end
if self.selectBagIdx>#self.bagList then self.selectBagIdx=#self.bagList end
local startIdx=self.selectBagIdx
local refreshItemIdx={}
if needCount>0 then
local lerpNeedCount=needCount
local idx=startIdx
local firstTry=true
local indexChanged=false
while idx<=#self.bagList and lerpNeedCount>0 do
table.insert(refreshItemIdx,idx)
local data=self.bagList[idx]
local itemData=data.item
local itemcount=itemData.itemcount
local itemid=itemData.itemid
local itemguidStr=tostring(itemData.itemguid)
local selectedNum=self.selectList[itemguidStr]and self.selectList[itemguidStr].num or 0
local lerpHasCount=itemcount-selectedNum

self.selectBagIdx=idx
self.curItemguid=itemguidStr
self.selectList[itemguidStr].index=idx
self.selectList[itemguidStr].itemid=itemid

if lerpHasCount>=lerpNeedCount then
self.selectList[itemguidStr].num=selectedNum+lerpNeedCount
self.itemIdLookup[itemid]=(self.itemIdLookup[itemid]or 0)+lerpNeedCount
lerpNeedCount=0
break
else
self.selectList[itemguidStr].num=selectedNum+lerpHasCount
self.itemIdLookup[itemid]=(self.itemIdLookup[itemid]or 0)+lerpHasCount
lerpNeedCount=lerpNeedCount-lerpHasCount

if firstTry and idx==startIdx then
idx=1
firstTry=false
indexChanged=true
end
end
if idx==#self.bagList then
break
elseif indexChanged==false then
idx=idx+1
end
indexChanged=false
end
elseif needCount<0 then
local lerpNeedCount=math.abs(needCount)
local idx=startIdx
local looped=false
while idx>=1 and lerpNeedCount>0 do
table.insert(refreshItemIdx,idx)
local data=self.bagList[idx]
local itemData=data.item
local itemcount=itemData.itemcount
local itemid=itemData.itemid
local itemguidStr=tostring(itemData.itemguid)
local selectedNum=self.selectList[itemguidStr]and self.selectList[itemguidStr].num or 0

self.selectBagIdx=idx
self.curItemguid=itemguidStr
self.selectList[itemguidStr].index=idx
self.selectList[itemguidStr].itemid=itemid

if selectedNum>=lerpNeedCount then
self.selectList[itemguidStr].num=selectedNum-lerpNeedCount
self.itemIdLookup[itemid]=(self.itemIdLookup[itemid]or 0)-lerpNeedCount
lerpNeedCount=0
break
else
self.selectList[itemguidStr].num=0
self.itemIdLookup[itemid]=(self.itemIdLookup[itemid]or 0)-selectedNum
lerpNeedCount=lerpNeedCount-selectedNum
end
if idx==1 then
if looped then
break
end
idx=#self.bagList
looped=true
else
idx=idx-1
end
end
end
for _,idx in ipairs(refreshItemIdx)do
self:refreshBagListItem(idx)
end
end

function UISubAct_tianxuyishiGuBaoSelectWin:refreshBagList()
self.bagList=gubaoLookup:getGoodsSortList3(self.needItemColor)

local hiddenIds={
[37001]=true,
[37002]=true,
[37003]=true,
[37004]=true,
}
local duihuanLIst={}
for _,item in ipairs(self.bagList)do
local itemData=item.item
local itemid=itemData.itemid
if itemid and not hiddenIds[itemid]then
duihuanLIst[#duihuanLIst+1]=item
end
end
self.bagList=duihuanLIst

local rNum=math.ceil(#self.bagList/_colomn)
local pageNum=_row
if rNum<pageNum then rNum=pageNum end
local createList={}
for i=1,rNum do createList[#createList+1]=i end
self.itemScrollView:initData('itemPanel',createList)
end

function UISubAct_tianxuyishiGuBaoSelectWin:getBagItemIdx(bagListIdx)
local idx=bagListIdx%_colomn
return math.ceil(bagListIdx/_colomn),idx==0 and _colomn-1 or idx-1
end

function UISubAct_tianxuyishiGuBaoSelectWin:refreshBagListItem(bagListIdx)
local idx,subIdx=self:getBagItemIdx(bagListIdx)
if idx then
local item=self.loopListViewCmp:GetShownItemByItemIndex(idx-1)
local widget=item.Widget:GetChildWidgetBase(subIdx)
local itemInfo=self.bagList[bagListIdx]
local isTemp=itemInfo==nil
if not isTemp then
local itemData=itemInfo.item
local itemid=itemData.itemid
local itemguid=itemData.itemguid
local itemcount=itemData.itemcount
local countStr=itemcount
if self.selectList[tostring(itemguid)]then
local cnt=self.selectList[tostring(itemguid)].num
if cnt>0 then
countStr=string.format("%d/%d",itemcount,cnt)

widget:SetChildActive(2,true)
widget:SetChildButtonClick(2,function()
local itemInfo=self.bagList[bagListIdx]
if itemInfo and itemInfo.item then
local itemguid=tostring(itemInfo.item.itemguid)
local selectItem=self.selectList[itemguid]
if selectItem and selectItem.num>0 then
self.curItemguid=itemguid
self.selectBagIdx=selectItem.index
self.diffSelectNum=-1
local newSelectCnt=math.floor((self.selectSum-1)/self.needItemCount)
self.diffSelectNumChanged=true
self.winlua:SetChildSliderValue(self.selectCntSlider:getID(),newSelectCnt)
self.diffSelectNumChanged=false
end
end
end)
elseif cnt<=0 then
widget:SetChildActive(2,false)
end
end
local prop={}
prop[PropIndex(DataPropKey.eWidgetText,3)]=countStr
widget:SetChildPropData(0,prop)
end
end
end

function UISubAct_tianxuyishiGuBaoSelectWin:onStartAction()
end

function UISubAct_tianxuyishiGuBaoSelectWin:onFreshAction(index,itemWidget)
local idx=(index-1)*_colomn+1


for i=0,_colomn-1 do
local widget=itemWidget:GetChildWidgetBase(i)
local itemInfo=self.bagList[idx+i]
local isTemp=itemInfo==nil

if not isTemp then
local itemData=itemInfo.item
local itemid=itemData.itemid
local itemguid=itemData.itemguid
local itemcount=itemData.itemcount




local countStr=itemcount
if self.selectList[tostring(itemguid)]then
local cnt=self.selectList[tostring(itemguid)].num
if cnt>0 then
countStr=string.format("%d/%d",itemcount,cnt)
end
end
local conf={itemid=itemid,itemcount=countStr,showCountBG=true,showname=false,itemIndex=idx+i,itemguid=itemguid}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
widget:SetChildPropData(0,prop)
local itemWidget=widget:GetChildWidgetBase(0)
itemsComponentHelper.setUIBaseItemSmallSign(itemWidget,conf)
widget:SetBaseItemClickEvent(0,function(...)
self:onItemClick(...)
end)
end
end
end

function UISubAct_tianxuyishiGuBaoSelectWin:onItemClick(itemid,index,itemguid,attach)
if itemid<=0 then return end
if itemguid and itemid~=self.targetItemId then
local item=bagModel.getItem(itemguid)
local has=itemsModel.getCount(itemid)
local selectedNum=self:getSelectNum(itemguid)
local canSelectNum=has-selectedNum
canSelectNum=math.min(canSelectNum,self.max*self.needItemCount)
local maxItemCount=(self.max*self.needItemCount)-self.selectSum+selectedNum
local selectNumCmpArgs={numFormat='选取：<color=#f1ce78>{0}/{1}</color>',min=1,max=math.min(canSelectNum,maxItemCount),val=1}
if(self.selectCnt>=self.max)then
UIManager.error('已达到最大兑换次数')
return
end
local argstable={
formType=TIPS_FORM_TYPE.eGubaoCheck,
tipsType=TIPS_TYPE.eCommonGubaoMetrial,
itemid=itemid,
itemguid=itemguid,
attach={formType=TIPS_FORM_TYPE.eGubaoCheck,index=index,selectNumCmpArgs=selectNumCmpArgs,},
}
tipsBtnManager.insertBtn(argstable,{TIPS_BTNS_TYPE.ePutAnyItem})
tipsManager.showTips(argstable)
else
tipsManager.showTips({itemid=itemid,itemguid=itemguid})
end
end

function UISubAct_tianxuyishiGuBaoSelectWin:setSelectNum(itemguid,selectedNum,index,itemid)
if self.selectList==nil then self.selectList={}end
if not self.selectList[tostring(itemguid)]then
self.selectList[tostring(itemguid)]={num=0,index=0,itemid=0}
end
self.curItemguid=itemguid
self.selectBagIdx=index
local oldNum=self.selectList[tostring(itemguid)].num or 0
self.diffSelectNum=selectedNum-oldNum
self.selectList[tostring(itemguid)].index=index
self.selectList[tostring(itemguid)].itemid=itemid
local newSelectCnt=math.floor((self.selectSum+self.diffSelectNum)/self.needItemCount)

self.diffSelectNumChanged=true
self.winlua:SetChildSliderValue(self.selectCntSlider:getID(),newSelectCnt)
self.diffSelectNumChanged=false
end

function UISubAct_tianxuyishiGuBaoSelectWin:getSelectNum(itemguid)
if self.selectList==nil then self.selectList={}end
if self.selectList[tostring(itemguid)]then
return self.selectList[tostring(itemguid)].num
else
return 0
end
return 0
end


function UISubAct_tianxuyishiGuBaoSelectWin:onCloseBtn()
self:closeSelf()
end

function UISubAct_tianxuyishiGuBaoSelectWin:onExchangeBtn()
if self.okcallback then
local itemList={}
local itemidList={}
local itemSum=0
local ismax=false
for itemguid,item in pairs(self.selectList)do
if item.num>0 and self.selectCnt>0 then
local itemid=item.itemid
local cnt=item.num

if itemSum+cnt<=self.selectCnt*self.needItemCount then
itemSum=itemSum+cnt
if itemSum==self.selectCnt*self.needItemCount then
ismax=true
end
else
cnt=self.selectCnt*self.needItemCount-itemSum
itemSum=self.selectCnt*self.needItemCount
ismax=true
end

if itemidList[itemid]==nil then
itemidList[itemid]=cnt
table.insert(itemList,{itemid,cnt})
else
itemidList[itemid]=itemidList[itemid]+cnt
for i,v in ipairs(itemList)do
if v[1]==itemid then
v[2]=itemidList[itemid]
break
end
end
end
if ismax then
break
end
end
end

local content=string.format("是否兑换以下物品获得：<color=#ca631d>天墟券</color><color=#549327>x%d</color>？",self.selectCnt*self.targetItemCount)
local showdata={
type='UIDialouge',
canvasindex=9,
title='提示',
content=content,
oktext='兑换',
canceltext='容我三思',
allowclickBG=true,
showclosebtn=true,
itemList=itemList,
okcallback=function()
self.okcallback(self.selectCnt,itemList)
self:closeSelf()
end,
}
local confirmDialog=UIDialogManager.newDialog(showdata)
confirmDialog:show()
end
end

function UISubAct_tianxuyishiGuBaoSelectWin:onSubBtn()
if self.selectCnt<=0 then
return
end

self.diffSelectNum=-1*self.needItemCount
local newSelectCnt=math.floor((self.selectSum-self.needItemCount)/self.needItemCount)
self.diffSelectNumChanged=true
self.winlua:SetChildSliderValue(self.selectCntSlider:getID(),newSelectCnt)
self.diffSelectNumChanged=false
end

function UISubAct_tianxuyishiGuBaoSelectWin:onAddBtn()
if self.max<=0 then
return
end
if self.min==self.max then
return
end
if self.selectCnt>=self.max then
return
end
self.diffSelectNum=self.needItemCount
local newSelectCnt=math.floor((self.selectSum+self.needItemCount)/self.needItemCount)
self.diffSelectNumChanged=true
self.winlua:SetChildSliderValue(self.selectCntSlider:getID(),newSelectCnt)
self.diffSelectNumChanged=false
end

function UISubAct_tianxuyishiGuBaoSelectWin:onHelpBtn()
local d={}
d.mode=3
d.title="规则介绍"
d.name='tianxuyishi_help_%d'
d.showBlack=true
UIManager:showWindow('UIRuleWin',d)
end