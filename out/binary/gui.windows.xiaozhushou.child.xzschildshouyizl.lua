







def_class("xzsChildShouYiZL",UICloneObject)





xzsChildShouYiZL.abName="ui/windows/xiaozhushou/child/xzschildshouyizl.ab"

xzsChildShouYiZL.assetName="xzsChildShouYiZL"


function xzsChildShouYiZL:bindComponents()

self.moneyRewardList=UIObject.get(self,0)
self.itemRewardList=UIObject.get(self,1)
self.icon=UIImage.get(self,2)
self.rewardText=UIText.get(self,3)
self.title=UIText.get(self,4)
self.titleBg=UIObject.get(self,5)

end


function xzsChildShouYiZL:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.moneyRewardList);self.moneyRewardList=nil;
_UIObject_release(self.itemRewardList);self.itemRewardList=nil;
_UIObject_release(self.icon);self.icon=nil;
_UIObject_release(self.rewardText);self.rewardText=nil;
_UIObject_release(self.title);self.title=nil;
_UIObject_release(self.titleBg);self.titleBg=nil;
end





local _ab="ui/windows/xiaozhushou/xzsiconsmall_pak.ab"



function xzsChildShouYiZL:onLoaded(...)
self:bindComponents()
end


function xzsChildShouYiZL:__delete()
self:unbindComponents()
end




function xzsChildShouYiZL:onShow(argtable,afterOnloaded)
self.orderID=argtable.orderID
self.detailId=argtable.detailId
self.titleBg:setActive(false)




local moneyList=argtable.moneyList
if#moneyList>0 then
self.moneyRewardList:setActive(true)
self:refreshMoneyList(moneyList)
else
self.moneyRewardList:setActive(false)
end
local itmeList=argtable.itmeList
if#itmeList>0 then
self.itemRewardList:setActive(true)
self:refreshItemList(itmeList)
else
self.itemRewardList:setActive(false)
end
end


function xzsChildShouYiZL:onHide()

end


function xzsChildShouYiZL:refreshMoneyList(moneyList)
self.moneyRewardList:setChildLayoutGroupCreateItems(#moneyList,function(index)
local moneyItem=self.moneyRewardList:getChildLayoutGroupGridItem(index-1)
local itemData=moneyList[index]
local itemId=itemData.itemid
local itemNum=itemData.num
local iconname=iconHelper.getIconName(itemId)
moneyItem:SetChildIcon(0,iconname,false)
moneyItem:SetChildText(1,mathHelper.formatNumber(itemNum))
end)
self.widget:ForceLayoutRect(self.moneyRewardList:getID())
self.widget:ForceLayoutRect(-1)
end

function xzsChildShouYiZL:refreshItemList(itmeList)
self.itemRewardList:setChildLayoutGroupCreateItems(#itmeList,function(index)
local item=self.itemRewardList:getChildLayoutGroupGridItem(index-1)
local itemData=itmeList[index]
local itemId=itemData.itemid
local itemNum=itemData.num
local itemGuid=itemData.itemguid
local showCountBG=itemNum>1
local countStr=showCountBG and mathHelper.formatNumber(itemNum)or""
local itemConf={itemid=itemId,itemcount=countStr,showCountBG=showCountBG,showname=false,showStage=true}
local itemProp=itemsComponentHelper.getCommonFillDataSmall(itemConf)
item:SetChildPropData(-1,itemProp)
item:SetBaseItemClickEvent(-1,itemsComponentHelper.onItemClickEx)
end)
self.widget:ForceLayoutRect(self.itemRewardList:getID())
self.widget:ForceLayoutRect(-1)
end


