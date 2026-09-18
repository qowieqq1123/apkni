







def_class("UIXJLittleWorldXingChenSelectWin",UIWindowBase)









function UIXJLittleWorldXingChenSelectWin:bindComponents()

self.BagList=UILoopListView.new(self,0)
self.bagPanel=UIObject.get(self,1)
self.closeFrame=UIButton.get(self,2)
self.closeLeftBtn=UIButton.get(self,3)
self.closeRightBtn=UIButton.get(self,4)
self.groupRoot=UIObject.get(self,5)
self.left=UIObject.get(self,6)
self.right=UIObject.get(self,7)
self.shuaiButton=UIButton.get(self,8)
self.title=UIText.get(self,9)
self.Viewport=UIObject.get(self,10)
self.zhenxiCheck=UIObject.get(self,11)

self.BagList:bindLoopListView(function(...)
self:onFreshAction(...)
end,function(...)
self:onStartAction(...)
end)
self.closeFrame:setButtonClick(function()self:onCloseFrame()end)

self.closeLeftBtn:setButtonClick(function()self:onCloseLeftBtn()end)

self.closeRightBtn:setButtonClick(function()self:onCloseRightBtn()end)

self.shuaiButton:setButtonClick(function()self:onShuaiButton()end)



end


function UIXJLittleWorldXingChenSelectWin:unbindComponents()
local _UIObject_release=UIObject.release
self.BagList:deleteSelf();self.BagList=nil;
_UIObject_release(self.bagPanel);self.bagPanel=nil;
_UIObject_release(self.closeFrame);self.closeFrame=nil;
_UIObject_release(self.closeLeftBtn);self.closeLeftBtn=nil;
_UIObject_release(self.closeRightBtn);self.closeRightBtn=nil;
_UIObject_release(self.groupRoot);self.groupRoot=nil;
_UIObject_release(self.left);self.left=nil;
_UIObject_release(self.right);self.right=nil;
_UIObject_release(self.shuaiButton);self.shuaiButton=nil;
_UIObject_release(self.title);self.title=nil;
_UIObject_release(self.Viewport);self.Viewport=nil;
_UIObject_release(self.zhenxiCheck);self.zhenxiCheck=nil;
end


















local _colomn=1

function UIXJLittleWorldXingChenSelectWin:onLoaded(...)
self:bindComponents()
self.selectEquip=nil

self.BagList:bindSlowWidget(function(...)
if self and not self.isClose then
self:bindGrid(...)
end
end)

self.sortOrder=ITEM_SORT_COMPARE_TYPE.eUpOrder

self.isZhenXi=userActorSetting.get('xc_rongHe_zhen_xi',nil)

local _onDrag=function()
self:onScrollChanged()
end
local _endDragCallback=function()
self:onEndScrollChanged()
end
self.winlua:SetChildUIDragEvent(self.BagList:getID(),0,nil,_onDrag,_endDragCallback)

self.bagPanel:setChildAnchoredPos(-3.85,-113,37)
self.bagPanel:setChildDOAnchorPosY(113,0.2)
end


function UIXJLittleWorldXingChenSelectWin:__delete()
self:unbindComponents()
self.isCloseAnim=nil
end




function UIXJLittleWorldXingChenSelectWin:onShow(argtable,afterOnloaded)
local isLeft=argtable.isLeft
self.selectMainItem=argtable.selectMainItem
self.selectChildItem=argtable.selectChildItem
self.callback=argtable.callback
self.isLeft=isLeft
self.pos=argtable.pos
self:closeWindow("UIXingChenRongHeTipsWin")
if isLeft then
self.title:setText("选择主星辰")
self.left:setActive(true)
self.right:setActive(false)
else
self.title:setText("选择副星辰")
self.left:setActive(false)
self.right:setActive(true)
end



self:refreshBag()
end


function UIXJLittleWorldXingChenSelectWin:onHide()

end

function UIXJLittleWorldXingChenSelectWin:refreshBag()



self.filter=self.filter or{}
self.filter[ITEM_FILTER_TYPE.eColor]={ITEM_FILTER_COMPARE.eEquals,{eQualityColor.eRed}}
if self.isZhenXi then
self.filter[ITEM_FILTER_TYPE.eXingChenZhenXi]={ITEM_FILTER_COMPARE.eEquals,1}
else
self.filter[ITEM_FILTER_TYPE.eXingChenZhenXi]=nil
end

self.zhenxiCheck:setActive(self.isZhenXi or false)

local bagList=xingChenHelper.sortEquip(self.pos,nil,nil,self.filter)

if self.isLeft then
if xingChenBagModel.equipsLookup[self.pos]then
if itemsConfig.getItemColor(xingChenBagModel.equipsLookup[self.pos].itemid)==eQualityColor.eRed then
table.insert(bagList,1,xingChenBagModel.equipsLookup[self.pos])
end
end
end

self.itemsList=bagList
local chlen=#bagList


local jump=1
local select=self.isLeft and self.selectMainItem or self.selectChildItem
if select then
local selectGuid=tostring(select.itemguid)
for i,v in ipairs(bagList)do
if tostring(v.itemguid)==selectGuid then
jump=i
end
end
end









self.BagList:initData('bagItem',bagList)


self.BagList:jumpItem(jump)

self:checkArrowBtn(chlen)
end

function UIXJLittleWorldXingChenSelectWin:onFreshAction(index,grid)
self:bindGrid(index,grid)
end

function UIXJLittleWorldXingChenSelectWin:onStartAction()

end

function UIXJLittleWorldXingChenSelectWin:checkSameCiZhui(selectMainItem,selectChildItem)
if not selectMainItem then
return
end
if not selectChildItem then
return
end
local affixList=xingChenHelper.getAffixList(selectMainItem)
local childAffixList=xingChenHelper.getAffixList(selectChildItem)


for i,v in ipairs(childAffixList)do
if not table.containsValue(affixList,v)then
return false
end
end
return true
end

function UIXJLittleWorldXingChenSelectWin:bindGrid(index,grid)
local item=self.itemsList[index]
if item then
local itemid=item.itemid
local itemguidStr=tostring(item.itemguid)
local config=itemsConfig.getConfig(itemid)
local prop={}
prop[PropIndex(DataPropKey.eWidgetIcon,0)]=iconHelper.getIconName(itemid)
prop[PropIndex(DataPropKey.eWidgetText,2)]=FMT.fmt("{0}级",xingChenBagModel:getOrbitLevel(config.type1))
prop[PropIndex(DataPropKey.eWidgetText,1)]=xingChenHelper.getXingChenName(item)
grid:SetChildActive(-1,true)
grid:SetChildPropData(-1,prop)

grid:SetChildActive(3,(self.selectMainItem and itemguidStr==tostring(self.selectMainItem.itemguid)))
grid:SetChildActive(5,(self.selectChildItem and itemguidStr==tostring(self.selectChildItem.itemguid)))
grid:SetChildActive(4,xingChenBagModel:getEquip(item.itemguid)~=nil)
grid:SetBaseItemClickEvent(-1,function(itemid,idx,itemguid,attach)
















































self:openSelectMode(item,grid)
end)


else
grid:SetChildActive(-1,false)
end
end

function UIXJLittleWorldXingChenSelectWin:openSelectMode(item,grid)
if self.selectGrid then
self.selectGrid:SetChildActive(6,true)
self.selectGrid:SetChildActive(7,false)
end
self.selectGrid=grid

local pos=grid:GetChildScreenPointToLocalPointRectangle(-1)
self:showWindow("UIXingChenRongHeTipsWin",{pos=pos,equip=item})
self.clickTip=true

grid:SetChildActive(6,false)
grid:SetChildActive(7,true)
local itemguidStr=tostring(item.itemguid)
grid:SetChildButtonClick(8,function()
if self:checkSameCiZhui(item,self.selectChildItem)and itemguidStr~=tostring(self.selectChildItem.itemguid)then
UIManager.error("词缀一样的星辰无法融合")
return
end
if self.selectChildItem and itemguidStr==tostring(self.selectChildItem.itemguid)then
if self.selectMainItem then
if self:checkSameCiZhui(self.selectChildItem,self.selectMainItem)then
UIManager.error("词缀一样的星辰无法融合")
return
end
self.selectChildItem=self.selectMainItem
else
return
end
end
self.selectMainItem=item
if self.callback then
self.callback(self.selectMainItem,self.selectChildItem,true,grid:GetChildPosition(-1))
end
self:onCloseFrame()
end)
grid:SetChildButtonClick(9,function()
if self:checkSameCiZhui(self.selectMainItem,item)and itemguidStr~=tostring(self.selectMainItem.itemguid)then
UIManager.error("词缀一样的星辰无法融合")
return
end
if self.selectMainItem and itemguidStr==tostring(self.selectMainItem.itemguid)then
if self.selectChildItem then
if self:checkSameCiZhui(self.selectChildItem,self.selectMainItem)then
UIManager.error("词缀一样的星辰无法融合")
return
end
self.selectMainItem=self.selectChildItem
else
return
end
end
self.selectChildItem=item
if self.callback then
self.callback(self.selectMainItem,self.selectChildItem,false,grid:GetChildPosition(-1))
end
self:onCloseFrame()
end)
end

function UIXJLittleWorldXingChenSelectWin:closeSelectMode()
if self.selectGrid then
self.selectGrid:SetChildActive(6,true)
self.selectGrid:SetChildActive(7,false)
self.selectGrid=nil
end
end

function UIXJLittleWorldXingChenSelectWin:freshSelect()
local startIndex,endIndex=self.BagList:getVisableIndex()
for i=startIndex,endIndex do
local grid=self.BagList:getListViewItemWidgetByDataIndex(i)
if grid then
local item=self.itemsList[i]
local itemguidStr=tostring(item.itemguid)
grid:SetChildActive(3,(self.selectMainItem and itemguidStr==tostring(self.selectMainItem.itemguid)))
grid:SetChildActive(5,(self.selectChildItem and itemguidStr==tostring(self.selectChildItem.itemguid)))
end
end

end

function UIXJLittleWorldXingChenSelectWin:onScrollChanged()
self.isDrag=true
if not self.clickTip then
return
end
self:closeWindow("UIXingChenRongHeTipsWin")
self.clickTip=nil

self:closeSelectMode()
end

function UIXJLittleWorldXingChenSelectWin:onEndScrollChanged()
self.isDrag=false


end


function UIXJLittleWorldXingChenSelectWin:checkArrowBtn(len)



self.closeLeftBtn:setActive(len>6)

self.closeRightBtn:setActive(len>6)

end




function UIXJLittleWorldXingChenSelectWin:onCloseFrame()
if self.isCloseAnim then
return
end
self.bagPanel:setChildAnchoredPos(-3.85,113,37)
self.bagPanel:setChildDOAnchorPosY(-113,0.2,function()
UIManager:callWindowFunc("UIXJLittleWorldXingChenRongHeWin","refreshItem_front")
self.isCloseAnim=nil
self:closeSelf()
end)
self.isCloseAnim=true

end



function UIXJLittleWorldXingChenSelectWin:onCloseLeftBtn()
self.BagList:jumpToSlowItem(0)
end



function UIXJLittleWorldXingChenSelectWin:onCloseRightBtn()
self.BagList:jumpToSlowItem(#self.itemsList-1)
end



function UIXJLittleWorldXingChenSelectWin:onShuaiButton()
self.isZhenXi=not self.isZhenXi

userActorSetting.flushVal('xc_rongHe_zhen_xi',self.isZhenXi)
self:refreshBag()
end



