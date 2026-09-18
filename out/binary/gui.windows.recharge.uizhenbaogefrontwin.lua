







def_class("UIZhenBaoGeFrontWin",UIWindowBase)









function UIZhenBaoGeFrontWin:bindComponents()

self.root=UIObject.get(self,0)
self.scrollerView=UIObject.get(self,1)
self.zbgBtn=UIButton.get(self,2)
self.buyLimit=UIText.get(self,3)
self.ValBar=UIProgress.get(self,4)
self.reddot=UIObject.get(self,5)

self.zbgBtn:setButtonClick(function()self:onZbgBtn()end)



end


function UIZhenBaoGeFrontWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.scrollerView);self.scrollerView=nil;
_UIObject_release(self.zbgBtn);self.zbgBtn=nil;
_UIObject_release(self.buyLimit);self.buyLimit=nil;
_UIObject_release(self.ValBar);self.ValBar=nil;
_UIObject_release(self.reddot);self.reddot=nil;
end



















function UIZhenBaoGeFrontWin:onLoaded(...)
self:bindComponents()
local _onClickRewardItem=function(...)
self:onClickRewardItem(...)
end
self.scrollerView:setChildScrollViewInit(-1,true,_onClickRewardItem,nil)
end


function UIZhenBaoGeFrontWin:__delete()
self:doPunchRotation(false)
self:unbindComponents()
end




function UIZhenBaoGeFrontWin:onShow(argtable,afterOnloaded)
if not systemModel.isOpen(SYSTEM_DEFINE.eRechage)then
self.root:setActive(false)
else
self.root:setActive(true)
self:refreshView()
end
end


function UIZhenBaoGeFrontWin:onHide()
self:doPunchRotation(false)
end

function UIZhenBaoGeFrontWin:refreshView()
local nextIdConfig=rechargeModel:getZhenBaoGeNextId()
if not nextIdConfig then
return
end
local rewards=nextIdConfig.rewards
self.rewards=rewards
self.scrollerView:setChildScrollViewCreateGrids(#rewards,#rewards)
local grids=self.scrollerView:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local item=grids[i-1]
if item then
local reward=rewards[i]
if reward then
local itemid=reward[1]
local count=reward[2]
local conf={itemid=itemid,itemcount=count,showCountBG=true}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetChildPropData(-1,prop)
end
end
end

local totalRecharge=rechargeModel:getTotalRecharge()/10
local target=rechargeModel:getZhenBaoGetarget(nextIdConfig.target)

self.ValBar:setProgress(totalRecharge,target)
self.ValBar:setChildProgressText(FMT.fmt("{0}/{1}",totalRecharge,target))
local reddot=rechargeModel:checkZhenBaoGeReddot()
self.reddot:setActive(reddot)
self:doPunchRotation(reddot)
if totalRecharge<target then
self.buyLimit:setText(FMT.fmt("再获得{0}机缘可获得",target-totalRecharge))
else
local got=rechargeModel:getZhenBaoGeData(nextIdConfig.id)
if got then
self.buyLimit:setText("已领取")
else
self.buyLimit:setText("可领取")
end

end
end
function UIZhenBaoGeFrontWin:onClickRewardItem(clickCount,index)
local rewards=self.rewards
if not rewards then
return
end
local itemid=rewards[index+1][1]
if itemid==-1 then
return
end
tipsManager.showTips({itemid=itemid})
end

function UIZhenBaoGeFrontWin:doPunchRotation(reddot)
local index=self.reddot:getID()
if reddot then
if self.reddotTweener==nil then
self:setChildRotation(index,0,0,0)
local tweener=self:setChildDOPunchRotation(index,Vector3(0,0,15),2,2,1)
tweener:SetEase(_Ease.Linear)
tweener:SetLoops(-1,_LoopType.Restart)
self.reddotTweener=tweener
end
else
if self.reddotTweener~=nil then
self.reddotTweener:Complete()
self.reddotTweener=nil
self:setChildRotation(index,0,0,0)
end
end
end




function UIZhenBaoGeFrontWin:onZbgBtn()
UIManager:showWindow("UIZhenBaoGeWin")
end

