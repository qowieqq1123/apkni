







def_class("UIXJCaravanEscort_rewardsInfoWin",UIWindowBase)









function UIXJCaravanEscort_rewardsInfoWin:bindComponents()

self.root=UIObject.get(self,0)
self.closeBtn=UIButton.get(self,1)
self.clickMask=UIButton.get(self,2)
self.rewardGroup=UIObject.get(self,3)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.clickMask:setButtonClick(function()self:onClickMask()end)



end


function UIXJCaravanEscort_rewardsInfoWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.clickMask);self.clickMask=nil;
_UIObject_release(self.rewardGroup);self.rewardGroup=nil;
end



















function UIXJCaravanEscort_rewardsInfoWin:onLoaded(...)
self:bindComponents()
end


function UIXJCaravanEscort_rewardsInfoWin:__delete()
self:unbindComponents()
end




function UIXJCaravanEscort_rewardsInfoWin:onShow(argtable,afterOnloaded)
self.shipId=argtable and argtable.shipId

self:refresh()
end


function UIXJCaravanEscort_rewardsInfoWin:onHide()

end

function UIXJCaravanEscort_rewardsInfoWin:refresh()
local shipCfg=cfgHelper.get(cfg_miaoxingshanglvboatconfig_get,self.shipId)
local rewardCfgList=shipCfg.showRewards
local rewardList={}
for i,v in ipairs(rewardCfgList)do
local itemId=v[1]
local itemCount=v[2]
local itemColor=itemsConfig.getItemColor(itemId)
rewardList[#rewardList+1]={itemId=itemId,itemCount=itemCount,itemColor=itemColor}
end

table.sort(rewardList,function(a,b)
if a.itemColor==b.itemColor then
return a.itemId<b.itemId
else
return a.itemColor>b.itemColor
end
end)

self.rewardGroup:setChildLayoutGroupCreateItems(#rewardList,function(index)
local widget=self.rewardGroup:getChildLayoutGroupGridItem(index-1)
local reward=rewardList[index]
if reward then
widget:SetChildActive(-1,true)
local itemid=reward.itemId
local count=reward.itemCount
local countStr=''
local showCountBG=false
if count>1 then
showCountBG=true
countStr=mathHelper.formatNumber(count)
end

local conf={itemid=itemid,itemcount=countStr,showCountBG=showCountBG,showname=false}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
widget:SetChildActive(-1,true)
widget:SetChildPropData(0,prop)
widget:SetBaseItemClickEvent(0,function(...)
self:onClickRewardItem(...)
end)
else
widget:SetChildActive(-1,false)
end
end)
end





function UIXJCaravanEscort_rewardsInfoWin:onCloseBtn()
self:closeSelf()
end



function UIXJCaravanEscort_rewardsInfoWin:onClickMask()
return self:onCloseBtn()
end

function UIXJCaravanEscort_rewardsInfoWin:onClickRewardItem(itemId,index,guid,attach)
if itemId==-1 then
return
end
tipsManager.showTips({itemid=itemId,itemguid=guid})
end

