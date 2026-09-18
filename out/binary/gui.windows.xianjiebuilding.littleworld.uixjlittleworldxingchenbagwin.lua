







def_class("UIXJLittleWorldXingChenBagWin",UIWindowBase)









function UIXJLittleWorldXingChenBagWin:bindComponents()

self.BagList=UIScrollViewSlow.get(self,0)
self.bagNum=UIText.get(self,1)
self.closeBtn=UIButton.get(self,2)
self.emptyRoot=UIObject.get(self,3)
self.groupRoot=UIObject.get(self,4)
self.jumpButton=UIButton.get(self,5)
self.left=UIObject.get(self,6)
self.root=UIButton.get(self,7)
self.shaiXuanButton=UIButton.get(self,8)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.jumpButton:setButtonClick(function()self:onJumpButton()end)

self.root:setButtonClick(function()self:onRoot()end)

self.shaiXuanButton:setButtonClick(function()self:onShaiXuanButton()end)



end


function UIXJLittleWorldXingChenBagWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.BagList);self.BagList=nil;
_UIObject_release(self.bagNum);self.bagNum=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.emptyRoot);self.emptyRoot=nil;
_UIObject_release(self.groupRoot);self.groupRoot=nil;
_UIObject_release(self.jumpButton);self.jumpButton=nil;
_UIObject_release(self.left);self.left=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.shaiXuanButton);self.shaiXuanButton=nil;
end


















local _colomn=4
local _creatGirdPrecent=500

function UIXJLittleWorldXingChenBagWin:onLoaded(...)
self:bindComponents()

self.BagList:bindSlowWidget(function(...)
if self and not self.isClose then
self:bindGrid(...)
end
end)

self:addNotify(notifyConfig.onXCEquipChange,function(pos)
local grids=self.groupRoot:getChildLayoutGroupGridList()
if grids[pos-1]then
LittleWorldController:doPunchRotation(self,grids[pos-1],3,pos,xingChenHelper.isSlotCanEquip(pos))
end
end)

self.sortOrder=ITEM_SORT_COMPARE_TYPE.eUpOrder
end


function UIXJLittleWorldXingChenBagWin:__delete()
self:unbindComponents()
end




function UIXJLittleWorldXingChenBagWin:onShow(argtable,afterOnloaded)
local defaultGroup=self.groupIdx or 1
if argtable then
defaultGroup=argtable.selectGroup or defaultGroup
end


self.left:setChildAnchoredPos(-512,0)
self.left:setChildDOAnchorPosX(0,0.2)

self:refreshBagTypePanel()

self:selectGroupItem(defaultGroup)

local num=bagControl.invokeFuncByBagType(BAG_TYPE.eXingChen,'getBagNum')
local maxNum=bagConfig.getBagMaxNum(BAG_TYPE.eXingChen)
self.bagNum:setText(FMT.fmt("背包容量：<color={2}>{0}/{1}</color>",num,maxNum,num>=maxNum and FONT_COLOR_VAL[FONT_COLOR.eRedColor]or"#7D3B17"))
end


function UIXJLittleWorldXingChenBagWin:onHide()

end

function UIXJLittleWorldXingChenBagWin:onShowArgRecv(argtable)
self:onShow(argtable)
end

function UIXJLittleWorldXingChenBagWin:refreshBagTypePanel()
local pos=cfgHelper.get(cfg_starsbasicconfig_get,1,"pos")
self.groupRoot:setChildLayoutGroupCreateItems(#pos)
local grids=self.groupRoot:getChildLayoutGroupGridList()
for i=1,grids.Count do
local name=pos[i]
local grid=grids[i-1]
grid:SetChildText(0,name)
grid:SetChildButtonClick(2,function()
self:selectGroupItem(i)
end)
LittleWorldController:doPunchRotation(self,grid,3,i,xingChenHelper.isSlotCanEquip(i))
end
end

function UIXJLittleWorldXingChenBagWin:selectGroupItem(i)
if self.groupIdx then
local grid=self.groupRoot:getChildLayoutGroupGridItem(self.groupIdx-1)
if grid then
grid:SetChildActive(1,false)
end
end

local grid=self.groupRoot:getChildLayoutGroupGridItem(i-1)
if grid then
grid:SetChildActive(1,true)

end

self.groupIdx=i

self.isSetZero=nil
self.BagList:clearSlowItems()

self:refreshBagListPanel(true)

UIManager:callWindowFunc("UIPlanent","showHaloIndex",i)
end


function UIXJLittleWorldXingChenBagWin:refreshBagListPanel(resetSelectItem)
self.filter=self.filter or{}
self.filter[ITEM_FILTER_TYPE.eXingChenRongHeChild]={ITEM_FILTER_COMPARE.eNot,{1}}
local bagIdList=xingChenHelper.sortEquip(self.groupIdx,self.sortOrder,true,self.filter)
self.itemsList=bagIdList
local chlen=#bagIdList

local tNum=_creatGirdPrecent
tNum=math.max(tNum,chlen)
local row=math.ceil(tNum/_colomn)+7
tNum=(row+7)*_colomn
local row=math.ceil(tNum/_colomn)

if resetSelectItem then
self.selectItemIdx=1
end

self.emptyList={}

local lookup={}
for i,v in ipairs(self.itemsList)do
lookup[tostring(v.itemguid)]=i
end
self.itemsLookup=lookup

if not self.isSetZero then
self.BagList:freshSlowGrids(tNum,row,_colomn,self.isSetZero)
self.isSetZero=true
else
if self.row~=row then
self.BagList:freshSlowGrids(tNum,row,_colomn,self.isSetZero)
end
self.BagList:freshAllItems()
end

self.row=row

self:refreshInfoPanel()
self.isEmpty=chlen==0
if chlen>0 then
self.emptyRoot:setActive(false)
self.BagList:setChildAnchoredPos(44,306)
else
self.emptyRoot:setActive(true)
self.BagList:setChildAnchoredPos(10000,10000)
end
end

function UIXJLittleWorldXingChenBagWin:freshAllItems()
self.BagList:freshAllItems()
end

function UIXJLittleWorldXingChenBagWin:addItem(item)
if self.isEmpty then
self:refreshBagListPanel()
return
end
local guidStr=tostring(item.itemguid)
local index=self.itemsLookup[guidStr]
if index then
self.itemsList[index]=item
self.itemsLookup[guidStr]=index
self.BagList:freshSlowItem(index-1)
else
if itemsFilterHelper.isFilter(self.filter,item)then
local e,emptyIdx=next(self.emptyList)
if emptyIdx then
index=emptyIdx
self.emptyList[e]=nil
else
index=#self.itemsList+1
end
self.itemsList[index]=item
self.itemsLookup[guidStr]=index
self.BagList:freshSlowItem(index-1)
end
end

end



function UIXJLittleWorldXingChenBagWin:clearItem(item)
local index=self.itemsLookup[tostring(item.itemguid)]
if index then

if xingChenBagModel:getEquip(item.itemguid)then
return
end
self.emptyList[index]=index
self.itemsList[index]=nil
self.BagList:freshSlowItem(index-1)
end
end

function UIXJLittleWorldXingChenBagWin:bindGrid(index,grid)
local item=self.itemsList[index]
local isTemp=item==nil or item.itemguid==nil

local baseItem=grid:GetChildWidgetBase(0)
local starWidget=baseItem and baseItem:GetChildWidgetBase(12)or nil

if not isTemp then

local isEquiped=xingChenBagModel:getEquip(item.itemguid)~=nil

local porp=itemsComponentHelper.getCommonFillData(item,{showCountBG=false,showcount=false,showname=false,showRare=true})

grid:SetChildActive(0,true)
grid:SetChildPropData(0,porp)

local starLevel=xingChenHelper.getStarLevel(item)
if starWidget then
xingChenHelper.setStarFlag(starWidget,starLevel,true)
end

grid:SetBaseItemClickEvent(0,function(itemid,idx,itemguid,attach)
local oldIdx=self.selectItemIdx
self.selectItemIdx=index
self.BagList:freshSlowItem(oldIdx-1)
self.BagList:freshSlowItem(index-1)
self:refreshInfoPanel()
end)

grid:SetChildActive(2,isEquiped)
grid:SetChildActive(3,self.selectItemIdx==index)
else
grid:SetChildActive(0,false)
grid:SetChildActive(2,false)
grid:SetChildActive(3,false)
if starWidget then
xingChenHelper.setStarFlag(starWidget,0,true)
end
end
grid:SetChildNewBieComponentId(-1,'UIXJLittleWorldXingChenBagWin.bagGrid'..index)
end


function UIXJLittleWorldXingChenBagWin:freshSlowItem(itemguid,clear)

local index=self:getIndex(itemguid)
if clear then
self.itemsList[index]=nil
else
local item=equipsHelper.getEquip(itemguid)
self.itemsList[index]=item
end

self.BagList:freshSlowItem(index-1)
end

function UIXJLittleWorldXingChenBagWin:getIndex(itemguid)
local emptyIdx=#self.itemsList+1
for i,v in ipairs(self.itemsList)do
if v.itemguid==itemguid then
return i
end
if v.itemguid==nil then
emptyIdx=i
end
end
return emptyIdx
end

function UIXJLittleWorldXingChenBagWin:refreshInfoPanel()

local equip=self.itemsList[self.selectItemIdx]
if equip then
self:showWindow("UIXJLittleWorldXingChenInfoWin",{equip=equip})
else
self:hideWindow("UIXJLittleWorldXingChenInfoWin")
end
end




function UIXJLittleWorldXingChenBagWin:onCloseBtn()
UIFullLittleWorldControl:showXingChenMainWindow()
UIManager:callWindowFunc("UIPlanent","showHaloIndex",0)
end

function UIXJLittleWorldXingChenBagWin:onRoot()
self:onCloseBtn()
end

function UIXJLittleWorldXingChenBagWin:onShaiXuanButton()
self:showWindow("UIXJXingChenFilterWin",{
sortCondition=self.winFitler,
callback=function(fitler,winFitler)
self.filter=fitler
self.winFitler=winFitler
self:refreshBagListPanel(true)
end})
end

function UIXJLittleWorldXingChenBagWin:onJumpButton()
local itemIdCfg=cfgHelper.get(cfg_starsbasicconfig_get,1,"empty_item_jump")
local itemid=itemIdCfg[self.groupIdx]
gainControl:showGainWin(itemid)
end