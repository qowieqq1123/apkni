







def_class("UISubAct_SHXB_itemGirdRewardWin",UIWindowBase)









function UISubAct_SHXB_itemGirdRewardWin:bindComponents()

self.clickMask=UIButton.get(self,0)
self.root=UIObject.get(self,1)
self.arrow=UIObject.get(self,2)
self.rewardScrollView=UIObject.get(self,3)

self.clickMask:setButtonClick(function()self:onClickMask()end)



end


function UISubAct_SHXB_itemGirdRewardWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.clickMask);self.clickMask=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.arrow);self.arrow=nil;
_UIObject_release(self.rewardScrollView);self.rewardScrollView=nil;
end



















function UISubAct_SHXB_itemGirdRewardWin:onLoaded(...)
self:bindComponents()
end


function UISubAct_SHXB_itemGirdRewardWin:__delete()
self:unbindComponents()
end




function UISubAct_SHXB_itemGirdRewardWin:onShow(argtable,afterOnloaded)
self.rewardList=argtable and argtable.rewardList
self.posWidget=argtable and argtable.posWidget
self.posItem=argtable and argtable.posItem
self.offset=argtable and argtable.offset

self:refresh()
end


function UISubAct_SHXB_itemGirdRewardWin:onHide()

end

function UISubAct_SHXB_itemGirdRewardWin:refresh()
self:refreshRoot()

local count=#self.rewardList
self.rewardScrollView:setChildScrollViewCreateGrids(count,5)
local grids=self.rewardScrollView:getChildScrollViewItemWidgets()
for i=1,grids.Count do
local widget=grids[i-1]
local reward=self.rewardList[i]
local itemId=reward[1]
local itemCount=reward[2]
local rate=reward[3]
local itemCountStr=''
local showCountBG=false
if itemCount>1 then
showCountBG=true
itemCountStr=mathHelper.formatNumber(itemCount)
end

local conf={itemid=itemId,itemcount=itemCountStr,showCountBG=showCountBG,showname=false}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
widget:SetChildActive(-1,true)
widget:SetChildPropData(0,prop)
widget:SetBaseItemClickEvent(0,function(...)
self:onClickRewardItem(...)
end)








local gailvStr=FMT.fmt("{0}%",rate)
widget:SetChildText(1,gailvStr)
end
end

function UISubAct_SHXB_itemGirdRewardWin:refreshRoot()
local curpos=self.offset and Vector2.New(self.offset[1],self.offset[2])or Vector2.New(0,0)
local pos=nil
if self.posItem then
pos=self.posItem:getChildScreenPointToLocalPointRectangle()
elseif self.posWidget then
pos=self.posWidget:GetChildScreenPointToLocalPointRectangle(-1)
end
if pos then
curpos.x=curpos.x+pos.x
curpos.y=curpos.y+pos.y
end
self.root:setLocalPos(curpos.x,curpos.y,0)
end




function UISubAct_SHXB_itemGirdRewardWin:onClickMask()
self:closeSelf()
end

function UISubAct_SHXB_itemGirdRewardWin:onClickRewardItem(itemId,index,guid,attach)

if itemId==-1 then
return
end
tipsManager.showTips({itemid=itemId,itemguid=guid})
end
