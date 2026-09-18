







def_class("UIBlueDiamondGrowUpGiftWin",UIWindowBase)









function UIBlueDiamondGrowUpGiftWin:bindComponents()

self.Content=UIObject.get(self,0)
self.root=UIObject.get(self,1)
self.ScrollerView=UIObject.get(self,2)



end


function UIBlueDiamondGrowUpGiftWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.Content);self.Content=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.ScrollerView);self.ScrollerView=nil;
end
















local _this=nil




function UIBlueDiamondGrowUpGiftWin:onLoaded(...)
_this=self
self:bindComponents()
self:addNotify(notifyConfig.onActorBlueDiamondChange,self.onActorBlueDiamondChange)
end


function UIBlueDiamondGrowUpGiftWin:__delete()
self:unbindComponents()
_this=nil
end

function UIBlueDiamondGrowUpGiftWin.onActorBlueDiamondChange()
_this:refreshPanel()
end




function UIBlueDiamondGrowUpGiftWin:onShow(argtable,afterOnloaded)
self:refreshPanel()

if afterOnloaded then
self:initRoot()
end
end

function UIBlueDiamondGrowUpGiftWin:onShowArgRecv(argtable)
self:initRoot()
end

function UIBlueDiamondGrowUpGiftWin:initRoot()
self.root:setChildCanvasGroupAlpha(0)
local cavasGroup=self.root:getCommonComponent('CanvasGroup')
if self.delayTimer then
self:stopTimerByID(self.delayTimer)
self.delayTimer=nil
end
if self.tweener then
self.tweener:Kill(false)
self.tweener=nil
end
self.delayTimer=self:delayDo(0.3,function()
if not _this then return end
_this.tweener=_DOTweenProxy.DOFade(cavasGroup,1,0.5)
_this.tweener:SetDelay(0.2)
_this.delayTimer=nil
end)
end


function UIBlueDiamondGrowUpGiftWin:onHide()

end

function UIBlueDiamondGrowUpGiftWin:refreshPanel()
local giftList=rechargeModel:getSortBlueDiamondLiBaoList(shopLibaoType.blueDiamondGrowUpGift)
local len=#giftList
self.ScrollerView:setChildScrollViewCreateGrids(len,len)
local grids=self.ScrollerView:getChildScrollViewItemWidgets()
for i=1,len do
local widget=grids[i-1]

local conf=giftList[i]
local buyNum=rechargeModel:getXianGouLiBaoBuyNum(conf.id)
local isGot=buyNum>=conf.maxcount
local isOpen,desc=rechargeModel:checkXianGouLiBaoOpen(conf.conditions)

widget:SetChildText(0,self:getTaskDesc(conf.conditions))
widget:SetChildActive(2,not isGot and isOpen)
widget:SetChildActive(3,isGot)
widget:SetChildActive(4,not isGot and not isOpen)
widget:SetChildText(4,desc or"")

widget:SetChildButtonClick(2,function()
if not rechargeModel:checkXianGouLiBaoOpen(conf.conditions,true)then
return
end
if not isGot then
rechargeController:reqXianGouLiBaoBuy(conf.id,1)
else
UIManager.error('奖励已领取')
end
end)

local rewards=rechargeModel:getXianGouLiBaoRewards(conf.rewards)
widget:SetChildLayoutGroupCreateItems(1,#rewards,function(index)
local item=widget:GetChildLayoutGroupGridItem(1,index-1)

local itemID=rewards[index][1]
local num=rewards[index][2]
local str=''
if num>0 then
str=tostring(num)
end
local graynum=isGot and 1 or 0
local conf={itemid=itemID,itemcount=str,showname=false,showCountBG=str~='',showStage=true,gray=graynum}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetChildPropData(0,prop)
item:SetBaseItemClickEvent(0,function(...)self:onGoodItemClick(...)end)

item:SetChildActive(1,not isGot and isOpen)
end)
end
end

function UIBlueDiamondGrowUpGiftWin:getTaskDesc(conditions)
if conditions==nil then
return""
end
for i,v in pairs(conditions)do
if v[1]==1 then
return FMT.fmt("宗门等级达到{0}级",v[2])
end
end
return""
end

function UIBlueDiamondGrowUpGiftWin:onGoodItemClick(itemid,index,itemguid,attach)
if itemid~=-1 then
tipsManager.showTips({itemid=itemid,itemguid=itemguid})
end
end




