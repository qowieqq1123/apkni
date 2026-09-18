







def_class("UIQiYuanShu_SelectWin",UIWindowBase)









function UIQiYuanShu_SelectWin:bindComponents()

self.leftBtn=UIButton.get(self,0)
self.rightBtn=UIButton.get(self,1)
self.bgModel=UIObject.get(self,2)
self.tipsText=UIText.get(self,3)
self.selectScrollerView=UIObject.get(self,4)
self.Content=UIObject.get(self,5)
self.changywbtn=UIButton.get(self,6)

self.leftBtn:setButtonClick(function()self:onLeftBtn()end)

self.rightBtn:setButtonClick(function()self:onRightBtn()end)

self.changywbtn:setButtonClick(function()self:onChangywbtn()end)



end


function UIQiYuanShu_SelectWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.leftBtn);self.leftBtn=nil;
_UIObject_release(self.rightBtn);self.rightBtn=nil;
_UIObject_release(self.bgModel);self.bgModel=nil;
_UIObject_release(self.tipsText);self.tipsText=nil;
_UIObject_release(self.selectScrollerView);self.selectScrollerView=nil;
_UIObject_release(self.Content);self.Content=nil;
_UIObject_release(self.changywbtn);self.changywbtn=nil;
end
















local selectItemCmpIndex={
itemRoot=0,
bg=1,
rewardItem=2,
selectBtn=3,
selectFlag=4,
activeFlag=5,
upRate=6,
}
local _this
local maxScrollWidth=1020
local maxShowItemCount=4




function UIQiYuanShu_SelectWin:onLoaded(...)
_this=self
self:bindComponents()
end


function UIQiYuanShu_SelectWin:__delete()
_this=nil
self:clearAllTimer()
self:unbindComponents()
end


function UIQiYuanShu_SelectWin:onChangywbtn()
UIManager:showWindow("UIQiYuanShuPickUp_ChangeWin")
if _this then
UIFullBaoLingShuControl:closeBaoLingShuPickUpWindow()
end
end




function UIQiYuanShu_SelectWin:onShow(argtable,afterOnloaded)
if afterOnloaded then
self.winlua:SetChildUIModelShowTarget(self.bgModel:getID(),5480,1,{},eAnimationID.stand)
end
self:refresh(afterOnloaded)
self:setEndTimer()
self:setUpdateTimer()
end


function UIQiYuanShu_SelectWin:onHide()
self:clearAllTimer()
end

function UIQiYuanShu_SelectWin:onUpdate()

if self.selectItemPosList and next(self.selectItemPosList)then
local nowPos=self.Content:getChildAnchoredPosition()
local showWidth=self.selectScrollerView:getChildSizeDeltaX()
if showWidth<maxScrollWidth then

self:refreshArrowBtn()
return self:clearUpdateTimer()
end
local nowPosX_Left=nowPos.x
local nowPosX_Right=nowPos.x-showWidth
local pageShowItemIdx_left
local pageShowItemIdx_right


















pageShowItemIdx_left=self:getScrollViewPosIndex(-nowPosX_Left,true)
pageShowItemIdx_right=self:getScrollViewPosIndex(-nowPosX_Right,false)

local hasChangeIndex=false
if self.pageShowItemIdx_left~=pageShowItemIdx_left or self.pageShowItemIdx_right~=pageShowItemIdx_right then
hasChangeIndex=true
end
self.pageShowItemIdx_left=pageShowItemIdx_left
self.pageShowItemIdx_right=pageShowItemIdx_right

if hasChangeIndex then
return self:refreshArrowBtn()
end
end
end

function UIQiYuanShu_SelectWin:refresh(isInit)
local gubaoList=qiYuanShuModel:getWishGuBaoSelectList()
local gubaoCount=#gubaoList
self.maxListIndex=gubaoCount
if isInit then
self:initItemPosList()
end

self.selectScrollerView:setChildScrollRectEnable(gubaoCount>maxShowItemCount)
self.selectScrollerView:setChildScrollViewCreateGrids(gubaoCount,gubaoCount)
local selectWishGubaoId=qiYuanShuModel:getQiYuanShuWishGbId()
local grids=self.selectScrollerView:getChildScrollViewItemWidgets()
for i=1,grids.Count do
local widget=grids[i-1]
local item=gubaoList[i]
local itemid=item.itemId
local gubaoId=item.gubaoId
if itemid then
local itemGrid=widget:GetChildWidgetBase(selectItemCmpIndex.rewardItem)

local conf={itemid=itemid,itemcount="",showCountBG=false,showname=false}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
itemGrid:SetChildActive(-1,true)
itemGrid:SetChildPropData(0,prop)
itemGrid:SetBaseItemClickEvent(0,function(...)
self:onClickRewardItem(...)
end)
local itemName=itemsConfig.getItemName(itemid)
itemGrid:SetChildText(1,itemName)
end


local isSelect=selectWishGubaoId and selectWishGubaoId~=0 and gubaoId==selectWishGubaoId or false
widget:SetChildActive(selectItemCmpIndex.selectFlag,isSelect)
widget:SetChildActive(selectItemCmpIndex.selectBtn,not isSelect)
widget:SetChildActive(selectItemCmpIndex.upRate,isSelect)

widget:SetChildButtonClick(selectItemCmpIndex.selectBtn,function()
self:onSelectXinYuanGb(i,gubaoId)
end)

local isActive=gubaoModel:checkActive(gubaoId)
widget:SetChildActive(selectItemCmpIndex.activeFlag,isActive)
end

local isInQiYuanNow=qiYuanShuModel:checkIsInQiYuanNow()
if isInQiYuanNow then

local _List=qiYuanShuModel:getQiYuanShuOpenlist()
if _List and next(_List)then
self.changywbtn:setActive(true)
else
self.changywbtn:setActive(false)
end
else
self.changywbtn:setActive(false)
end
end

function UIQiYuanShu_SelectWin:jumpItem(index,animation,alignEnd)
self.nowSelectItemIndex=index
local jumpIndex=index
if jumpIndex<=1 then
jumpIndex=0
elseif jumpIndex>=self.maxListIndex then
jumpIndex=self.maxListIndex+1
end
self.selectScrollerView:setChildScrollViewSelectItem(jumpIndex-1,animation or false,false,alignEnd or false)
end

function UIQiYuanShu_SelectWin:initItemPosList()
local leftOffset=10
local rightOffset=10
local itemWeight=210
local itemSpace=19

local itemPosList={}
local itemCount=self.maxListIndex
local startPos=leftOffset
for i=1,itemCount do
local itemPos_left=startPos
local itemPos_right=startPos+itemWeight
local itemPos={left=itemPos_left,right=itemPos_right,space=itemSpace}
table.insert(itemPosList,itemPos)

startPos=itemPos_right+itemSpace
end
self.selectItemPosList=itemPosList
end

function UIQiYuanShu_SelectWin:getScrollViewPosIndex(posX,isLeft)
local leftOffset=10
local rightOffset=10
local itemWeight=210
local itemSpace=19
local offset=50
local index=0
local itemCount=self.maxListIndex
if posX<=leftOffset then

return nil
elseif posX>=leftOffset+(itemWeight+itemSpace)*itemCount-itemSpace then

return nil
end

if isLeft then
local tmp=(posX-leftOffset)%(itemWeight+itemSpace)
index=math.floor((posX-leftOffset)/(itemWeight+itemSpace))
if tmp>0 then
if tmp>=offset then
index=index+1
end
end
else
local tmp=(posX-leftOffset)%(itemWeight+itemSpace)
index=math.ceil((posX-leftOffset)/(itemWeight+itemSpace))
if tmp>0 then
if tmp>(itemWeight+itemSpace-offset)then
index=index+1
end
end
end

if index==0 or index>itemCount then
index=nil
end
return index
end

function UIQiYuanShu_SelectWin:refreshArrowBtn()
local isShowLeftBtn=false
local isShowRightBtn=false

if self.pageShowItemIdx_left and self.pageShowItemIdx_left>=1 then
isShowLeftBtn=true
end
if self.pageShowItemIdx_right and self.pageShowItemIdx_right<=self.maxListIndex then
isShowRightBtn=true
end

self.leftBtn:setActive(isShowLeftBtn)
self.rightBtn:setActive(isShowRightBtn)
end

function UIQiYuanShu_SelectWin:onSelectGb(index)
local isClickSelect=index==self.selectIdx
if isClickSelect then
return
end

if self.selectIdx then

local oldWidget=self.selectScrollerView:getChildScrollViewItemWidget(self.selectIdx-1)
oldWidget:SetChildActive(selectItemCmpIndex.selectFlag,false)
oldWidget:SetChildActive(selectItemCmpIndex.selectBtn,true)
oldWidget:SetChildActive(selectItemCmpIndex.upRate,false)
end

local newWidget=self.selectScrollerView:getChildScrollViewItemWidget(index-1)
newWidget:SetChildActive(selectItemCmpIndex.selectFlag,true)
newWidget:SetChildActive(selectItemCmpIndex.selectBtn,false)
newWidget:SetChildActive(selectItemCmpIndex.upRate,true)

self.selectIdx=index
end

function UIQiYuanShu_SelectWin:onSelectXinYuanGb(index,gubaoId)

qiYuanShuController:req_qiyuanshu_wishgubao(gubaoId)
end

function UIQiYuanShu_SelectWin:setEndTimer()
self:clearTimer()
local sTime,eTime=qiYuanShuModel:getQiYuanTime()
local func=function()
if _this==nil then return end
local nowTime=timeHelper.getServerShortTime()
local lerp=eTime-nowTime

if lerp<=0 then
UIManager.error("本轮祈愿已结束")
return _this:onCloseBtn()
end
end
self.timer=self:setTimer(1,0,func)
func()
end

function UIQiYuanShu_SelectWin:setUpdateTimer()
self:clearUpdateTimer()
self.updateTimer=self:setTimer(0.1,0,function()self:onUpdate()end)

self:onUpdate()
end

function UIQiYuanShu_SelectWin:clearTimer()
if self.timer then
self:stopTimerByID(self.timer)
self.timer=nil
end
end

function UIQiYuanShu_SelectWin:clearUpdateTimer()
if self.updateTimer then
self:stopTimerByID(self.updateTimer)
self.updateTimer=nil
end
end

function UIQiYuanShu_SelectWin:clearAllTimer()
self:clearTimer()
self:clearUpdateTimer()
end




function UIQiYuanShu_SelectWin:onLeftBtn()
if not self.pageShowItemIdx_left then
return
end

self:jumpItem(self.pageShowItemIdx_left,true)
end



function UIQiYuanShu_SelectWin:onRightBtn()
if not self.pageShowItemIdx_right then
return
end

self:jumpItem(self.pageShowItemIdx_right,true,true)
end

function UIQiYuanShu_SelectWin:onClickRewardItem(itemId,index,guid,attach)

if itemId==-1 then
return
end
tipsManager.showTips({itemid=itemId,itemguid=guid})
end
