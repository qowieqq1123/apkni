







def_class("UICommonRewardShowWin",UIWindowBase)









function UICommonRewardShowWin:bindComponents()

self.titleTxt=UIText.get(self,0)
self.goodGrid=UIObject.get(self,1)
self.descText=UIText.get(self,2)
self.goodScrollView=UIObject.get(self,3)



end


function UICommonRewardShowWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.titleTxt);self.titleTxt=nil;
_UIObject_release(self.goodGrid);self.goodGrid=nil;
_UIObject_release(self.descText);self.descText=nil;
_UIObject_release(self.goodScrollView);self.goodScrollView=nil;
end
















local _this


function UICommonRewardShowWin:onLoaded(...)
_this=self
self:bindComponents()
end


function UICommonRewardShowWin:__delete()
_this=nil
self:unbindComponents()
end


function UICommonRewardShowWin:onHide()

end




function UICommonRewardShowWin:onShow(argtable,afterOnloaded)
local title_str=argtable.title
self.titleTxt:setText(title_str)
local desc_str=argtable.desc
self.descText:setText(desc_str)

local rewards=argtable.rewards or{}
local c=#rewards
self.goodGrid:setChildLayoutGroupCreateItems(c)
local grids=self.goodGrid:getChildLayoutGroupGridList()
for i=1,c do
local reward=rewards[i]
local item=grids[i-1]
local itemid=reward[1]
local itemnum=reward[2]
local countStr=''
local showCountBG=false
if itemnum>1 then
showCountBG=true
countStr=tostring(itemnum)
end
local conf={itemid=itemid,itemcount=countStr,showCountBG=showCountBG,showname=false}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetChildPropData(0,prop)
item:SetBaseItemClickEvent(0,function(...)
if _this==nil then return end
_this:onClickItem(...)
end)
end
self.goodScrollView:setChildScrollRectEnable(c>4)
end

function UICommonRewardShowWin:onClickItem(itemId,index,guid,attach)
tipsManager.showTips({itemid=itemId,itemguid=nil,move=TIPS_MOVE_POS.eLeft})
end
