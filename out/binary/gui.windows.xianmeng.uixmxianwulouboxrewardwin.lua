







def_class("UIXMXianWuLouBoxRewardWin",UIWindowBase)









function UIXMXianWuLouBoxRewardWin:bindComponents()

self.goodsCreater=UIObject.get(self,0)



end


function UIXMXianWuLouBoxRewardWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.goodsCreater);self.goodsCreater=nil;
end
















local _this=nil


function UIXMXianWuLouBoxRewardWin:onLoaded(...)
_this=self
self:bindComponents()
end


function UIXMXianWuLouBoxRewardWin:__delete()
_this=nil
self:unbindComponents()
end


function UIXMXianWuLouBoxRewardWin:onHide()

end




function UIXMXianWuLouBoxRewardWin:onShow(argtable,afterOnloaded)
self.boxID=argtable.boxID
self:refreshView()
end

function UIXMXianWuLouBoxRewardWin:refreshView()
self.rewardlist=cfgHelper.get2(cfg_awardconfig_get,self.boxID,'showItems')
local num=#self.rewardlist
local callback=function(idx)
if _this==nil then
return
end
_this:refreshItem(nil,idx)
end
self.goodsCreater:setChildLayoutGroupCreateItems(num,callback)
end

function UIXMXianWuLouBoxRewardWin:refreshItem(item,idx)
if item==nil then
item=self.goodsCreater:getChildLayoutGroupGridItem(idx-1)
end

local itemid=self.rewardlist[idx][1]
local conf={itemid=itemid,showCountBG=false,showStage=true,showname=false,range=self.rewardlist[idx].range}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetChildPropData(0,prop)
local itemWidget=item:GetChildWidgetBase(0)
itemsComponentHelper.setUIBaseItemSmallSign(itemWidget,conf)
item:SetBaseItemClickEvent(0,self.onClickItem)
end

function UIXMXianWuLouBoxRewardWin.onClickItem(itemid,index,itemguid,attach)
if itemid==-1 then
return
end
itemsComponentHelper.onItemClickEx(itemid,index,itemguid,attach)
end