







def_class("UIShiLianTaRankBackWin",UIWindowBase)









function UIShiLianTaRankBackWin:bindComponents()

self.closeBtn=UIButton.get(self,0)
self.helpButton=UIButton.get(self,1)
self.menuScroller=UIObject.get(self,2)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.helpButton:setButtonClick(function()self:onHelpButton()end)



end


function UIShiLianTaRankBackWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.helpButton);self.helpButton=nil;
_UIObject_release(self.menuScroller);self.menuScroller=nil;
end


















local MenuCmpIndex=
{
select=0,
reddot=1,
name=2,
}


function UIShiLianTaRankBackWin:onLoaded(...)
self:bindComponents()
UIManager:invokeUIMethod("UIFightPrepareWin","registerEasyTouch",false)
end


function UIShiLianTaRankBackWin:__delete()
self:unbindComponents()
UIManager:invokeUIMethod("UIFightPrepareWin","registerEasyTouch",true)
end




function UIShiLianTaRankBackWin:onShow(argtable,afterOnloaded)
self.menuIndex=argtable or 1
self:initUI()
end


function UIShiLianTaRankBackWin:onHide()

end

function UIShiLianTaRankBackWin:initUI()
self:initMenu()
self:refreshUI()
end


function UIShiLianTaRankBackWin:initMenu()
self.menuScroller:setChildScrollViewInit(0.5,false,function(...)self:onClickMenu(...)end)
local menuList=shiLianTaModel.RankPanelName
self.menuScroller:setChildScrollViewCreateGrids(#menuList,1)
local grids=self.menuScroller:getChildScrollViewItemWidgets()
for i,v in ipairs(menuList)do
local slot=grids[i-1]
slot:SetChildText(MenuCmpIndex.name,v)
slot:SetChildActive(MenuCmpIndex.select,i==self.menuIndex)
if i==2 then
slot:SetChildActive(MenuCmpIndex.reddot,shiLianTaModel:checkFirstClearRewardReddot()or false)
end
end
end

function UIShiLianTaRankBackWin:refreshReddot(index,reddot)
local grid=self.menuScroller:getChildScrollViewItemWidget(index-1)
if grid then
grid:SetChildActive(MenuCmpIndex.reddot,reddot)
end
end


function UIShiLianTaRankBackWin:refreshUI()
if self.menuIndex==shiLianTaModel.RankPanelType.Rank then
UIManager:showWindow("UIShiLianTaRankWin")
UIManager:hideWindow("UIShiLianTaTaskWin")
elseif self.menuIndex==shiLianTaModel.RankPanelType.Reward then
UIManager:showWindow("UIShiLianTaTaskWin")
UIManager:hideWindow("UIShiLianTaRankWin")
end
end


function UIShiLianTaRankBackWin:onClickMenu(chickNum,index)
if self.menuIndex==index+1 then
return
end

local grids=self.menuScroller:getChildScrollViewItemWidgets()

local newSlot=grids[index]
if newSlot then
newSlot:SetChildActive(MenuCmpIndex.select,true)
end

local oldSlot=grids[self.menuIndex-1]
if oldSlot then
oldSlot:SetChildActive(MenuCmpIndex.select,false)
end
self.menuIndex=index+1


self:refreshUI()
end




function UIShiLianTaRankBackWin:onHelpButton()
end

function UIShiLianTaRankBackWin:onCloseBtn()
UIManager:closeWindow("UIShiLianTaRankBackWin")
UIManager:closeWindow("UIShiLianTaRankWin")
UIManager:closeWindow("UIShiLianTaTaskWin")
end

