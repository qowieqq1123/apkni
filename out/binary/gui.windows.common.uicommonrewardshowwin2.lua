







def_class("UICommonRewardShowWin2",UIWindowBase)









function UICommonRewardShowWin2:bindComponents()

self.background=UIButton.get(self,0)
self.closeTips=UIText.get(self,1)
self.descText=UIText.get(self,2)
self.flag=UIImage.get(self,3)
self.goodGrid=UIObject.get(self,4)
self.goodScrollView=UIObject.get(self,5)
self.panel=UIObject.get(self,6)
self.titleTxt=UIText.get(self,7)

self.background:setButtonClick(function()self:onBackground()end)



end


function UICommonRewardShowWin2:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.background);self.background=nil;
_UIObject_release(self.closeTips);self.closeTips=nil;
_UIObject_release(self.descText);self.descText=nil;
_UIObject_release(self.flag);self.flag=nil;
_UIObject_release(self.goodGrid);self.goodGrid=nil;
_UIObject_release(self.goodScrollView);self.goodScrollView=nil;
_UIObject_release(self.panel);self.panel=nil;
_UIObject_release(self.titleTxt);self.titleTxt=nil;
end















local _this



function UICommonRewardShowWin2:onLoaded(...)
self:bindComponents()
_this=self
end


function UICommonRewardShowWin2:__delete()
self:unbindComponents()
_this=nil
end




function UICommonRewardShowWin2:onShow(argtable,afterOnloaded)
self.parentWin=argtable.parentWin
self.closeFunc=argtable.closeFunc

local title_str=argtable.title
self.titleTxt:setText(title_str or"")
local desc_str=argtable.desc
self.descText:setText(desc_str or"")
local tips_str=argtable.tips
self.closeTips:setText(tips_str or"")

local flagInfo=argtable.flag
self.flag:setActive(flagInfo~=nil)
if flagInfo then
if flagInfo.image then
self.flag:setSprite(flagInfo.image[1],flagInfo.image[2])
elseif flagInfo.icon then
self.flag:setImageIcon(flagInfo.icon[1],flagInfo.icon[2])
end
end

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
itemsComponentHelper.onItemClick(...)
end)
end
self.goodScrollView:setChildScrollRectEnable(c>4)

self.winlua:ForceLayoutRect(self.panel:getID())
end


function UICommonRewardShowWin2:onHide()

end




function UICommonRewardShowWin2:onBackground()
if self.closeFunc then
self.closeFunc()
elseif self.parentWin then
self.parentWin:closeWindow(self.__name)
else
self:closeSelf()
end
end

