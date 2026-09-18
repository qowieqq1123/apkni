







def_class("UIBlueDiamondNewBieGiftWin",UIWindowBase)









function UIBlueDiamondNewBieGiftWin:bindComponents()

self.receiveBtn=UIButton.get(self,0)
self.rewardFalg=UIObject.get(self,1)
self.rewardScrollerView=UIObject.get(self,2)
self.root=UIObject.get(self,3)

self.receiveBtn:setButtonClick(function()self:onReceiveBtn()end)



end


function UIBlueDiamondNewBieGiftWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.receiveBtn);self.receiveBtn=nil;
_UIObject_release(self.rewardFalg);self.rewardFalg=nil;
_UIObject_release(self.rewardScrollerView);self.rewardScrollerView=nil;
_UIObject_release(self.root);self.root=nil;
end
















local _this=nil




function UIBlueDiamondNewBieGiftWin:onLoaded(...)
_this=self
self:bindComponents()
self:addNotify(notifyConfig.onActorBlueDiamondChange,self.onActorBlueDiamondChange)
end


function UIBlueDiamondNewBieGiftWin:__delete()
self:unbindComponents()
_this=nil
end

function UIBlueDiamondNewBieGiftWin.onActorBlueDiamondChange()
_this:refreshPanel()
end




function UIBlueDiamondNewBieGiftWin:onShow(argtable,afterOnloaded)
local cfgs=rechargeModel:getXianGouLiBaoConfig(shopLibaoType.blueDiamondNewBieGift)
self.conf=cfgs[1]

self:refreshPanel()

if afterOnloaded then
self:initRoot()
end
end

function UIBlueDiamondNewBieGiftWin:onShowArgRecv(argtable)
self:initRoot()
end

function UIBlueDiamondNewBieGiftWin:initRoot()
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


function UIBlueDiamondNewBieGiftWin:onHide()

end

function UIBlueDiamondNewBieGiftWin:refreshPanel()
local buyNum=rechargeModel:getXianGouLiBaoBuyNum(self.conf.id)
local isOpen=rechargeModel:checkXianGouLiBaoOpen(self.conf.conditions)
local isGot=buyNum>=self.conf.maxcount
self.receiveBtn:setActive(not isGot)
self.rewardFalg:setActive(isGot)
if not isGot then
self.receiveBtn:setGray(not isOpen)
end

local list=rechargeModel:getXianGouLiBaoRewards(self.conf.rewards)

self.rewardScrollerView:setChildLayoutGroupCreateItems(#list,function(index)
local widget=self.rewardScrollerView:getChildLayoutGroupGridItem(index-1)

local itemID=list[index][1]
local num=list[index][2]
local str=''
if num>0 then
str=tostring(num)
end
local graynum=isGot and 1 or 0
local conf={itemid=itemID,itemcount=str,showname=false,showCountBG=str~='',showStage=true,gray=graynum}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
widget:SetChildPropData(0,prop)
widget:SetBaseItemClickEvent(0,function(...)self:onGoodItemClick(...)end)

widget:SetChildActive(1,not isGot and isOpen)
end)
end

function UIBlueDiamondNewBieGiftWin:onGoodItemClick(itemid,index,itemguid,attach)
if itemid~=-1 then
tipsManager.showTips({itemid=itemid,itemguid=itemguid})
end
end






function UIBlueDiamondNewBieGiftWin:onReceiveBtn()
if not rechargeModel:checkXianGouLiBaoOpen(self.conf.conditions,true)then
return
end
local giftid=self.conf.id
local buyNum=rechargeModel:getXianGouLiBaoBuyNum(giftid)
local left=self.conf.maxcount-buyNum
if left>0 then
rechargeController:reqXianGouLiBaoBuy(giftid,1)
else
UIManager.error('奖励已领取')
end
end

