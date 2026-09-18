







def_class("UIBoxSelectWin",UIWindowBase)









function UIBoxSelectWin:bindComponents()

self.mask=UIButton.get(self,0)
self.closeBtn=UIButton.get(self,1)
self.topTips=UIText.get(self,2)
self.confirmBtn=UIButton.get(self,3)
self.bottomTips1=UIObject.get(self,4)
self.bottomTips2=UIObject.get(self,5)
self.bottomTipsText1=UIText.get(self,6)
self.bottomTipsText2=UIText.get(self,7)
self.selectBoxScrollViewLt5=UIObject.get(self,8)
self.selectBoxItemLt5_1=UIObject.get(self,9)
self.selectBoxItemLt5_2=UIObject.get(self,10)
self.selectBoxItemLt5_3=UIObject.get(self,11)
self.selectBoxItemLt5_4=UIObject.get(self,12)
self.selectBoxItemLt5_5=UIObject.get(self,13)
self.ScrollerScript=UIEnhancedScrollerLua.get(self,14)
self.selectBoxScrollViewMt5=UIObject.get(self,15)
self.selectCountShowPanel=UIObject.get(self,16)
self.leftPanel=UIObject.get(self,17)
self.rightPanel=UIObject.get(self,18)
self.leftArrow=UIButton.get(self,19)
self.rightArrow=UIButton.get(self,20)
self.leftQipao=UIButton.get(self,21)
self.rightQipao=UIButton.get(self,22)
self.leftCountText=UIText.get(self,23)
self.rightCountText=UIText.get(self,24)

self.mask:setButtonClick(function()self:onMask()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.confirmBtn:setButtonClick(function()self:onConfirmBtn()end)

self.leftArrow:setButtonClick(function()self:onLeftArrow()end)

self.rightArrow:setButtonClick(function()self:onRightArrow()end)

self.leftQipao:setButtonClick(function()self:onLeftQipao()end)

self.rightQipao:setButtonClick(function()self:onRightQipao()end)
self.selectBoxItemLt5={
self.selectBoxItemLt5_1,
self.selectBoxItemLt5_2,
self.selectBoxItemLt5_3,
self.selectBoxItemLt5_4,
self.selectBoxItemLt5_5,
}



end


function UIBoxSelectWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.mask);self.mask=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.topTips);self.topTips=nil;
_UIObject_release(self.confirmBtn);self.confirmBtn=nil;
_UIObject_release(self.bottomTips1);self.bottomTips1=nil;
_UIObject_release(self.bottomTips2);self.bottomTips2=nil;
_UIObject_release(self.bottomTipsText1);self.bottomTipsText1=nil;
_UIObject_release(self.bottomTipsText2);self.bottomTipsText2=nil;
_UIObject_release(self.selectBoxScrollViewLt5);self.selectBoxScrollViewLt5=nil;
_UIObject_release(self.selectBoxItemLt5_1);self.selectBoxItemLt5_1=nil;
_UIObject_release(self.selectBoxItemLt5_2);self.selectBoxItemLt5_2=nil;
_UIObject_release(self.selectBoxItemLt5_3);self.selectBoxItemLt5_3=nil;
_UIObject_release(self.selectBoxItemLt5_4);self.selectBoxItemLt5_4=nil;
_UIObject_release(self.selectBoxItemLt5_5);self.selectBoxItemLt5_5=nil;
_UIObject_release(self.ScrollerScript);self.ScrollerScript=nil;
_UIObject_release(self.selectBoxScrollViewMt5);self.selectBoxScrollViewMt5=nil;
_UIObject_release(self.selectCountShowPanel);self.selectCountShowPanel=nil;
_UIObject_release(self.leftPanel);self.leftPanel=nil;
_UIObject_release(self.rightPanel);self.rightPanel=nil;
_UIObject_release(self.leftArrow);self.leftArrow=nil;
_UIObject_release(self.rightArrow);self.rightArrow=nil;
_UIObject_release(self.leftQipao);self.leftQipao=nil;
_UIObject_release(self.rightQipao);self.rightQipao=nil;
_UIObject_release(self.leftCountText);self.leftCountText=nil;
_UIObject_release(self.rightCountText);self.rightCountText=nil;
self.selectBoxItemLt5=nil;
end















local _this
local abName='ui/windows/wanlingta/sharedtextures/selectbox.ab'
local ItemCompentIndex={
rewardItem=0,
qualityBg=1,
selectBtn=2,
mask=3,
selectPanel_oneBox=4,
selectFlag=5,
selectPanel_pluralityBox=6,
selectAddBtn=7,
selectSubBtn=8,
countText=9,
rewardItemName=10,
lockTips=11,
}
local UIPrepareEnScroller=simple_class(UIEnhancedScroller)



function UIBoxSelectWin:onLoaded(...)
self:bindComponents()
_this=self
self.enhancedscrollscript=UIPrepareEnScroller(self.ScrollerScript:getGameObject(),self.ScrollerScript:getCSharpObject(),nil,nil)
self.enhancedscrollscript.window=self

end


function UIBoxSelectWin:__delete()
self:unbindComponents()
self:stopAllTimer()
end




function UIBoxSelectWin:onShow(argtable,afterOnloaded)
self.selectNum=argtable.funcparam.num
self.itemList=argtable.funcparam.itemList
self.itemListCondition=argtable.funcparam.itemListCondition or{}
self.itemguid=argtable.funcparam.itemguid
self.expire=argtable.funcparam.expire
self.useCount=argtable.useCount
self.itemLen=#self.itemList
self.selectCountList={}
self.selectAllCount=0

self.showIndexRange={1,5}

self.jumpIndex={}
self.halfHideIndex={0,6}

self:refresh()
end

function UIBoxSelectWin:checkItemListCondition(condition)
local type=condition[1]
if type==1 then
local needLv=condition[2]
local zmLevel=zongmenModel:getLevel()
if zmLevel<needLv then
return false,string.format("宗门等级达%d级",needLv)
end
elseif type==2 then
local buildId,needLv=condition[2],condition[3]
local buildNum=zongmenModel:getBuildNum3(buildId,needLv)
if buildNum<=0 then
local cfg=cfgHelper.get1(cfg_monijybuildconfig_get,buildId)
return false,string.format("%s达%d级",cfg.name,needLv)
end
end
return true
end

function UIBoxSelectWin:refresh()
self:refreshSelectBoxList()

self:refreshPanel()

self:refreshSelectCountShowPanel()
end

function UIBoxSelectWin:refreshSelectBoxList()
if self.itemLen>5 then
self:refreshSelectBoxList_mt5()
else
self:refreshSelectBoxList_lt5()
end
end

function UIBoxSelectWin:refreshSelectBoxList_lt5()
self.selectBoxScrollViewMt5:setActive(false)
self.selectBoxScrollViewLt5:setActive(true)

local widget
for i,boxItem in ipairs(self.selectBoxItemLt5)do

if self.itemList[i]then

boxItem:setActive(true)
widget=boxItem:getWidgetBase()
local data=self.itemList[i]
widgetHelper.setNormalRewardItem(widget,ItemCompentIndex.rewardItem,data)
local widget2=widget:GetChildWidgetBase(ItemCompentIndex.rewardItem)
widget2:SetChildButtonClick(3,function()
self:onSelectBoxItemClick(data[1],i)
end)
local unlock=true
local lockTips=''
local condition=self.itemListCondition[i]
if condition then
unlock,lockTips=self:checkItemListCondition(condition)
end
local itemId=data[1]
local itemCount=data[2]
local itemConfig=itemsConfig.getConfig(itemId)
local itemColor=itemConfig.color or 1
local bgName=FMT.fmt("frame_xuanzedaojuui_{0}",itemColor)

widget:SetChildCSImageSprite(ItemCompentIndex.qualityBg,abName,bgName)

widget:SetChildText(ItemCompentIndex.rewardItemName,itemConfig.name)

local isSelect=self.selectCountList[i]~=nil
local isSelectMax=self.selectAllCount>=self.selectNum*self.useCount

widget:SetChildActive(ItemCompentIndex.mask,isSelectMax and not isSelect)

if not unlock then
widget:SetChildActive(ItemCompentIndex.selectPanel_oneBox,false)
widget:SetChildActive(ItemCompentIndex.selectPanel_pluralityBox,false)
widget:SetChildText(ItemCompentIndex.lockTips,lockTips)
else
if self.useCount>1 then


widget:SetChildActive(ItemCompentIndex.selectPanel_oneBox,false)
widget:SetChildActive(ItemCompentIndex.selectPanel_pluralityBox,true)


widget:SetChildButtonClick(-1,function()
self:selectItem_pluralityBox(true,i)
end)


widget:SetChildButtonClick(ItemCompentIndex.selectAddBtn,function()
self:selectItem_pluralityBox(true,i)
end)
widget:SetChildButtonClick(ItemCompentIndex.selectSubBtn,function()
self:selectItem_pluralityBox(false,i)
end)


widget:SetChildInputFieldChange(ItemCompentIndex.countText,true,function(...)
self:changeItemCount_pluralityBox(i,...)
end)


local selectItemCount=self.selectCountList[i]or 0

widget:SetChildInputFieldValue(ItemCompentIndex.countText,selectItemCount)


if selectItemCount>1 then

local countStr=FMT.fmt("<color=#76d81e>{0}</color>",itemCount*selectItemCount)
widget2:SetChildText(4,countStr)
widget2:SetChildActive(10,true)
end
else


widget:SetChildActive(ItemCompentIndex.selectPanel_oneBox,true)
widget:SetChildActive(ItemCompentIndex.selectPanel_pluralityBox,false)


widget:SetChildButtonClick(-1,function()
self:selectItem_oneBox(i)
end)


widget:SetChildButtonClick(ItemCompentIndex.selectBtn,function()
self:selectItem_oneBox(i)
end)


widget:SetChildActive(ItemCompentIndex.selectFlag,isSelect)

widget:SetChildActive(ItemCompentIndex.selectBtn,not isSelect)
end
end
else
boxItem:setActive(false)
end
end
end


function UIBoxSelectWin:selectItem_oneBox(itemIndex)
if self.selectCountList[itemIndex]then

self.selectCountList[itemIndex]=nil
if self.selectAllCount>0 then
self.selectAllCount=self.selectAllCount-1
end
else

if self.selectNum>1 then

if self.selectAllCount+1>self.selectNum then

UIManager.error("已选择道具的数量已达上限")
else

self.selectCountList[itemIndex]=1
self.selectAllCount=self.selectAllCount+1
end
else

self.selectCountList={}
self.selectAllCount=1
self.selectCountList[itemIndex]=1
end

if self.itemLen>5 then

local jumpIndex
if itemIndex<self.showIndexRange[1]then
jumpIndex=itemIndex
elseif itemIndex>self.showIndexRange[2]then
jumpIndex=itemIndex-4
if jumpIndex<1 then
jumpIndex=1
end
end

if jumpIndex then
self:JumpToIndex(jumpIndex)
end
end
end

self:refresh()
end


function UIBoxSelectWin:selectItem_pluralityBox(isAdd,itemIndex)
if isAdd then

if self.selectAllCount+1>self.selectNum*self.useCount then

UIManager.error("已选择道具的数量已达上限")
else
if self.selectCountList[itemIndex]and self.selectCountList[itemIndex]+1>self.useCount then

UIManager.error(FMT.fmt("每一种道具最多可选{0}个",self.useCount))
else

self.selectCountList[itemIndex]=self.selectCountList[itemIndex]and self.selectCountList[itemIndex]+1 or 1
self.selectAllCount=self.selectAllCount+1
end
end

if self.itemLen>5 then

local jumpIndex
if itemIndex<self.showIndexRange[1]then
jumpIndex=itemIndex
elseif itemIndex>self.showIndexRange[2]then
jumpIndex=itemIndex-4
if jumpIndex<1 then
jumpIndex=1
end
end

if jumpIndex then
self:JumpToIndex(jumpIndex)
end
end
else

if self.selectCountList[itemIndex]then
self.selectCountList[itemIndex]=self.selectCountList[itemIndex]-1
if self.selectCountList[itemIndex]<=0 then
self.selectCountList[itemIndex]=nil
end

self.selectAllCount=self.selectAllCount-1
if self.selectAllCount<0 then
self.selectAllCount=0
end
end

end


self:refresh()
end


function UIBoxSelectWin:changeItemCount_pluralityBox(itemIndex,str)

local count=tonumber(str)

local originalCount=self.selectCountList[itemIndex]or 0
if count==nil then

count=0
elseif count==originalCount then

return
elseif count<0 then

UIManager.error("选择的道具数量不能低于0个")
count=0
elseif count>self.useCount then

UIManager.error(FMT.fmt("每一种道具最多可选{0}个",self.useCount))
count=self.useCount
end

local deltaCount=count-originalCount

if self.selectAllCount+deltaCount<0 then

self.selectCountList[itemIndex]=count~=0 and count or nil
self.selectAllCount=0
elseif self.selectAllCount+deltaCount>self.selectNum*self.useCount then

UIManager.error("已选择道具的数量已达上限")

local maxCount=self.selectNum*self.useCount-self.selectAllCount+originalCount
self.selectCountList[itemIndex]=maxCount~=0 and maxCount or nil
self.selectAllCount=self.selectNum*self.useCount
else

self.selectCountList[itemIndex]=count~=0 and count or nil
self.selectAllCount=self.selectAllCount+deltaCount
end


self:refresh()
end


function UIBoxSelectWin:refreshPanel()
local canSelectCount=self.selectNum*self.useCount

if self.useCount>1 then


self.bottomTips1:setActive(true)

self.bottomTipsText1:setText(FMT.fmt("您打开了<color=#ca631d>{0}个宝箱</color>，同种道具最多可选择{1}次",self.useCount,self.useCount))


self.topTips:setText("您可以通过点击道具下方的数字框直接输入想要的数量")
else


self.bottomTips1:setActive(false)

self.topTips:setText(FMT.fmt("请从以下{0}种可选道具中，选择{1}种您想要的",self.itemLen,self.selectNum))
end


self.bottomTipsText2:setText(FMT.fmt("<color=#7d3b17>已选择</color>：{0}/{1}",self.selectAllCount,canSelectCount))


self.selectCountShowPanel:setActive(self.itemLen>5)


local isGray=false
if self.selectNum<=1 then

isGray=self.selectAllCount<self.selectNum
else

isGray=self.selectAllCount<canSelectCount
end
self.confirmBtn:setImageExGray(isGray)
end


function UIBoxSelectWin:refreshSelectCountShowPanel()
local isShowLeftArrow=false
local isShowRightArrow=false
local leftSelectCount=0
local rightSelectCount=0

self.jumpIndex={}
for k,v in ipairs(self.itemList)do
if k<self.showIndexRange[1]then

if not isShowLeftArrow then
isShowLeftArrow=true
end
if self.selectCountList[k]then

leftSelectCount=leftSelectCount+self.selectCountList[k]


self.jumpIndex[1]=k
end
elseif k>self.showIndexRange[2]then

if not isShowRightArrow then
isShowRightArrow=true
end
if self.selectCountList[k]then

rightSelectCount=rightSelectCount+self.selectCountList[k]

if not self.jumpIndex[2]then

self.jumpIndex[2]=k
end
end

end
end

if leftSelectCount>0 then

self.leftQipao:setActive(true)

self.leftCountText:setText(leftSelectCount)
else

self.leftQipao:setActive(false)
end

if rightSelectCount>0 then

self.rightQipao:setActive(true)

self.rightCountText:setText(rightSelectCount)
else

self.rightQipao:setActive(false)
end


self.leftArrow:setActive(isShowLeftArrow)
self.rightArrow:setActive(isShowRightArrow)


end

function UIBoxSelectWin:doRefreshActiveCellViews()
self.enhancedscrollscript:doRefreshActiveCellViews()
end

function UIBoxSelectWin:refreshSelectBoxList_mt5()
self.selectBoxScrollViewMt5:setActive(true)
self.selectBoxScrollViewLt5:setActive(false)

if self.itemList then
if not self.isEnhancedScrollInit then
self.enhancedscrollscript:initData(self.itemList,172,self.itemLen)
self.isEnhancedScrollInit=true
else
self:doRefreshActiveCellViews()
end
end
end

function UIBoxSelectWin:JumpToIndex(index)
if index>self.itemLen-4 then
index=self.itemLen-4
end
local tmpIndex=index-1
local tweenTime=1

self.enhancedscrollscript:jumpToDataIndex(tmpIndex,0,0,true,10,tweenTime,function()
local scrollRect=self.selectBoxScrollViewMt5:getCommonComponent('ScrollRect')
scrollRect.inertia=true
end)

if tweenTime<=0 then




self.showIndexRange[1]=tmpIndex+1

self.showIndexRange[2]=tmpIndex+5




self.halfHideIndex[1]=self.showIndexRange[1]-1
if self.halfHideIndex[1]<0 then
self.halfHideIndex[1]=0
end

self.halfHideIndex[2]=self.showIndexRange[2]+1
if self.halfHideIndex[2]>self.itemLen+1 then
self.halfHideIndex[2]=self.itemLen+1
end
end



self.jumpIndex={}


self:refreshSelectCountShowPanel()
end




function UIBoxSelectWin:onMask()
self:onCloseBtn()
end



function UIBoxSelectWin:onCloseBtn()
self:closeSelf()
end



function UIBoxSelectWin:onConfirmBtn()








local useBoxCount=0
if self.selectNum>1 then

if self.selectAllCount<self.selectNum*self.useCount then
UIManager.error("您还有可以选择的道具")
return
end
useBoxCount=self.useCount
else

useBoxCount=math.floor(self.selectAllCount/self.selectNum)
if useBoxCount<=0 then
UIManager.error("您还有可以选择的道具")
return
end
end

local selectList={}
local selectListLen=0
for i=1,self.itemLen do
if self.itemList[i]then
if self.selectCountList[i]then
local tmpList={}
tmpList[1]=i
tmpList[2]=self.selectCountList[i]
table.insert(selectList,tmpList)
end
end
end
selectListLen=#selectList
local itemData=bagModel.getItem(self.itemguid)

if itemData then
local itemid=itemData.itemid
local cfg=itemsHelper:get_item_config(itemid)
if cfg.selectBoxArgType and cfg.selectBoxArgType==1 then
local tempList={}
for i,v in ipairs(selectList)do
local data=self.itemList[v[1]]
local temp={}
temp[1]=data[1]
temp[2]=data[2]*v[2]


table.insert(tempList,temp)
end
if#tempList>0 then
local contentStr="请祖师确认是否选择以下奖励？\n"
local callback=function()

tipsBtnsFunc.boxSelect(self.itemguid,useBoxCount,selectListLen,selectList)
end
local show_data={
type='UIDialouge',
title='提示',
oktext='确定',
canceltext='取消',
content=contentStr,
itemList=tempList,
showclosebtn=true,
okcallback=callback,
canvasindex=10,
}
local dialog=UIDialogManager.newDialog(show_data)
dialog:show()







return
end
end
end


tipsBtnsFunc.boxSelect(self.itemguid,useBoxCount,selectListLen,selectList)
end


function UIBoxSelectWin:onSelectBoxItemClick(itemId,itemIndex)
tipsManager.showTips({formType=TIPS_FORM_TYPE.eClearBtn,itemid=itemId,backType=TIPS_BACK_TYPE.eSelfBack,attach={boxGuid=self.itemguid,itemIndex=itemIndex,expire=self.expire}})
end

function UIBoxSelectWin.onEventChange(evtType,entityId,posIndex)

end



function UIBoxSelectWin:onLeftArrow()
local jumpIndex
if self.showIndexRange[1]-5>1 then
jumpIndex=self.showIndexRange[1]-5
else
jumpIndex=1
end
self:JumpToIndex(jumpIndex)
end


function UIBoxSelectWin:onRightArrow()
local jumpIndex
if self.showIndexRange[2]+5<self.itemLen then
jumpIndex=self.showIndexRange[2]+1
else
jumpIndex=self.itemLen-4
end
self:JumpToIndex(jumpIndex)
end

function UIBoxSelectWin:onLeftQipao()
local jumpIndex=self.jumpIndex[1]
if not jumpIndex then
return
end
self:JumpToIndex(jumpIndex)
end

function UIBoxSelectWin:onRightQipao()
local jumpIndex=self.jumpIndex[2]
if not jumpIndex then
return
end
self:JumpToIndex(jumpIndex)
end


function UIPrepareEnScroller:OnSetCellView(dataIndex,cellIndex,cell,isActive)
if isActive then
self:RefreshCell(dataIndex,cellIndex,cell)
end
end

function UIPrepareEnScroller:OnRefreshCellView(dataIndex,cellIndex,cell)
self:RefreshCell(dataIndex,cellIndex,cell)
end

function UIPrepareEnScroller:RefreshCell(dataIndex,cellIndex,cell)
local item=cell

if _this.itemList[dataIndex]then

local data=_this.itemList[dataIndex]
widgetHelper.setNormalRewardItem(item,ItemCompentIndex.rewardItem,data)
local widget2=item:GetChildWidgetBase(ItemCompentIndex.rewardItem)
widget2:SetChildButtonClick(3,function()
_this:onSelectBoxItemClick(data[1],dataIndex)
end)
local unlock=true
local lockTips=''
local condition=_this.itemListCondition[dataIndex]
if condition then
unlock,lockTips=_this:checkItemListCondition(condition)
end
local itemId=data[1]
local itemCount=data[2]
local itemConfig=itemsConfig.getConfig(itemId)
local itemColor=itemConfig.color or 1
local bgName=FMT.fmt("frame_xuanzedaojuui_{0}",itemColor)

item:SetChildCSImageSprite(ItemCompentIndex.qualityBg,abName,bgName)

item:SetChildText(ItemCompentIndex.rewardItemName,itemConfig.name)

local isSelect=_this.selectCountList[dataIndex]~=nil
local isSelectMax=_this.selectAllCount>=_this.selectNum*_this.useCount

item:SetChildActive(ItemCompentIndex.mask,isSelectMax and not isSelect)

if not unlock then
item:SetChildActive(ItemCompentIndex.selectPanel_oneBox,false)
item:SetChildActive(ItemCompentIndex.selectPanel_pluralityBox,false)
item:SetChildText(ItemCompentIndex.lockTips,lockTips)
else
if _this.useCount>1 then


item:SetChildActive(ItemCompentIndex.selectPanel_oneBox,false)
item:SetChildActive(ItemCompentIndex.selectPanel_pluralityBox,true)









item:SetChildButtonClick(ItemCompentIndex.selectAddBtn,function()
_this:selectItem_pluralityBox(true,dataIndex)
end)
item:SetChildButtonClick(ItemCompentIndex.selectSubBtn,function()
_this:selectItem_pluralityBox(false,dataIndex)
end)


item:SetChildInputFieldChange(ItemCompentIndex.countText,true,function(...)
_this:changeItemCount_pluralityBox(dataIndex,...)
end)


local selectItemCount=_this.selectCountList[dataIndex]or 0

item:SetChildInputFieldValue(ItemCompentIndex.countText,selectItemCount)

if selectItemCount>1 then

local countStr=FMT.fmt("<color=#76d81e>{0}</color>",itemCount*selectItemCount)
widget2:SetChildText(4,countStr)
widget2:SetChildActive(10,true)
end
else


item:SetChildActive(ItemCompentIndex.selectPanel_oneBox,true)
item:SetChildActive(ItemCompentIndex.selectPanel_pluralityBox,false)


item:SetChildButtonClick(ItemCompentIndex.selectPanel_oneBox,function()
_this:selectItem_oneBox(dataIndex)
end)


item:SetChildButtonClick(ItemCompentIndex.selectBtn,function()
_this:selectItem_oneBox(dataIndex)
end)


item:SetChildActive(ItemCompentIndex.selectFlag,isSelect)

item:SetChildActive(ItemCompentIndex.selectBtn,not isSelect)
end
end
end
end

function UIPrepareEnScroller:onItemBeginDrag(dataIndex,screenPos,cell)
end

function UIPrepareEnScroller:onItemDrag(dataIndex,screenPos)
end

function UIPrepareEnScroller:onItemEndDrag(dataIndex,screenPos,cell)
end





function UIPrepareEnScroller:OnSetBrightness(dataIndex,cellIndex,changeType)

local index=dataIndex+1
if changeType==-1 then

if index~=_this.halfHideIndex[1]and index<_this.showIndexRange[2]then

_this.halfHideIndex[1]=index

_this.showIndexRange[1]=index+1


_this:refreshSelectCountShowPanel()
end
elseif changeType==1 then

if index~=_this.halfHideIndex[2]and index>_this.showIndexRange[1]then

_this.halfHideIndex[2]=index

_this.showIndexRange[2]=index-1


_this:refreshSelectCountShowPanel()
end
else

if index<_this.showIndexRange[1]then

_this.showIndexRange[1]=index

_this.halfHideIndex[1]=_this.showIndexRange[1]-1
if _this.halfHideIndex[1]<0 then
_this.halfHideIndex[1]=0
end


_this:refreshSelectCountShowPanel()
elseif index>_this.showIndexRange[2]then

_this.showIndexRange[2]=index

_this.halfHideIndex[2]=_this.showIndexRange[2]+1
if _this.halfHideIndex[2]>_this.itemLen+1 then
_this.halfHideIndex[2]=_this.itemLen+1
end


_this:refreshSelectCountShowPanel()
end

end
end


function UIBoxSelectWin.test_refreshSelectCountShowPanel()
if _this==nil then return end
_this:refreshSelectCountShowPanel()
end