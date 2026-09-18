







def_class("UIWDCQLiveBroadcastRoomHotRewardWin",UIWindowBase)









function UIWDCQLiveBroadcastRoomHotRewardWin:bindComponents()

self.background=UIButton.get(self,0)
self.closeBtn=UIButton.get(self,1)
self.scrollList=UIObject.get(self,2)

self.background:setButtonClick(function()self:onBackground()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)



end


function UIWDCQLiveBroadcastRoomHotRewardWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.background);self.background=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.scrollList);self.scrollList=nil;
end















local _this=nil
local _itemCmp={
title=0,
flag=1,
rewardBtn=2,
rewardTx=3,
got=4,
itemList=5,
}



function UIWDCQLiveBroadcastRoomHotRewardWin:onLoaded(...)
self:bindComponents()
_this=self
self:addNotify(notifyConfig.onWDCQLiveBroadcastRoomTotalHotChange,self.onWDCQLiveBroadcastRoomTotalHotChange)
end


function UIWDCQLiveBroadcastRoomHotRewardWin:__delete()
self:unbindComponents()
_this=nil
end




function UIWDCQLiveBroadcastRoomHotRewardWin:onShow(argtable,afterOnloaded)
self.parentWin=argtable.parentWin
self.closeFunc=argtable.closeFunc
self:initView()
end


function UIWDCQLiveBroadcastRoomHotRewardWin:onHide()

end




function UIWDCQLiveBroadcastRoomHotRewardWin:onBackground()
self:onCloseBtn()
end


function UIWDCQLiveBroadcastRoomHotRewardWin:onCloseBtn()
if self.parentWin then
self.parentWin:closeWindow(self.__name)
elseif self.closeFunc then
self.closeFunc()
else
UIManager:closeWindow(self.__name)
end
end

function UIWDCQLiveBroadcastRoomHotRewardWin:onClickButton()
for index,goal in ipairs(self.listData)do
local got=self.totalHot.flag>=goal
local reach=self.totalHot.num>=goal
if not got and reach then
wdcqLiveBroadcastRoomController:send_38_33()
return
end
end
end

function UIWDCQLiveBroadcastRoomHotRewardWin:initView()
self.listData={}
local cfg=cfgHelper.get2(cfg_wendingcangqiongzhibobasicconfig_get,1,"rdGoalReward")
for i,v in pairs(cfg)do
table.insert(self.listData,i)
end

self:refreshView()
end

function UIWDCQLiveBroadcastRoomHotRewardWin:refreshView()
self.totalHot=wdcqLiveBroadcastRoomModel:getTotalHot()
table.sort(self.listData,self.sortView)
self.scrollList:setChildLayoutGroupCreateItems(#self.listData,function(index)
local item=self.scrollList:getChildLayoutGroupGridItem(index-1)
local goal=self.listData[index]
local items=cfgHelper.get3(cfg_wendingcangqiongzhibobasicconfig_get,1,"rdGoalReward",goal)
local got=self.totalHot.flag>=goal
local reach=self.totalHot.num>=goal
item:SetChildButtonClick(_itemCmp.rewardBtn,function()
self:onClickButton()
end)
item:SetChildLayoutGroupCreateItems(_itemCmp.itemList,#items,function(_index)
local _item=item:GetChildLayoutGroupGridItem(_itemCmp.itemList,_index-1)
local _itemData=items[_index]
local _itemId=_itemData[1]
local _itemNum=_itemData[2]
local showCountBG=_itemNum>1
local countStr=showCountBG and mathHelper.formatNumber(_itemNum)or""
local conf={itemid=_itemId,itemcount=countStr,showCountBG=showCountBG,showname=false,showStage=false}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
_item:SetChildPropData(0,prop)
_item:SetBaseItemClickEvent(0,itemsComponentHelper.onItemClickEx)
end)
item:SetChildText(_itemCmp.title,FMT.fmt("{0}/{1}",self.totalHot.num,goal))
item:SetChildActive(_itemCmp.flag,reach and not got)
item:SetChildActive(_itemCmp.rewardBtn,not got)
item:SetChildActive(_itemCmp.got,got)
if not got then
item:SetChildText(_itemCmp.rewardTx,reach and"领取奖励"or"未达成")
item:SetChildGraphicGray(_itemCmp.rewardBtn,not reach)
end
end)
end

function UIWDCQLiveBroadcastRoomHotRewardWin.sortView(a,b)
local gotA=_this.totalHot.flag>=a and(20000+a)or(_this.totalHot.num>=a and a or(10000+a))
local gotB=_this.totalHot.flag>=b and(20000+b)or(_this.totalHot.num>=b and b or(10000+b))
return gotA<gotB
end

function UIWDCQLiveBroadcastRoomHotRewardWin.onWDCQLiveBroadcastRoomTotalHotChange()
_this:refreshView()
end