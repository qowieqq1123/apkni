







def_class("UIFriendWin",UIWindowBase)









function UIFriendWin:bindComponents()

self.root=UIObject.get(self,0)
self.helpButton=UIButton.get(self,1)
self.menuScroller=UIObject.get(self,2)

self.helpButton:setButtonClick(function()self:onHelpButton()end)



end


function UIFriendWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.helpButton);self.helpButton=nil;
_UIObject_release(self.menuScroller);self.menuScroller=nil;
end

















local MenuCmpIndex=
{
select=0,
reddot=1,
bg=2,
}

local _menuBody=2017




function UIFriendWin:onLoaded(...)
self:bindComponents()
self:initData()
self:initUI()
end


function UIFriendWin:__delete()
self:unbindComponents()

UIFullFriendMainControl:closeUI()
end




function UIFriendWin:onShow(argtable,afterOnloaded)
self:updateData(argtable)
self:refreshUI()
end


function UIFriendWin:onHide()

end






function UIFriendWin:initData()
self.menuIndex=1
end

function UIFriendWin:updateData(argtable)
end




function UIFriendWin:initUI()
self:initMenu()
end


function UIFriendWin:initMenu()
self.menuScroller:setChildScrollViewInit(0.5,false,function(...)self:onClickMenu(...)end)
local menuList=
{
"仙友",
"添加",
"申请",
}
self.menuScroller:setChildScrollViewCreateGrids(#menuList,1)
local grids=self.menuScroller:getChildScrollViewItemWidgets()
for i,v in ipairs(menuList)do
local slot=grids[i-1]
slot:SetChildUIModelShowTarget(MenuCmpIndex.bg,_menuBody,1,{},eAnimationID.common_window_enter,false,false,0,nil)
slot:SetChildActive(MenuCmpIndex.select,i==self.menuIndex)
self:refreshReddot(i)
end
end


function UIFriendWin:refreshUI()
if self.menuIndex==eFriendMenu.eFriend then


friendProtocolController.req_friend_list(eFriendListType.eLocal,1)
friendProtocolController.req_prized_point()

UIManager:showWindow("UIFriendListWin")
UIManager:closeWindow("UIFriendAddWin")
UIManager:closeWindow("UIFriendApplyWin")

elseif self.menuIndex==eFriendMenu.eAdd then


friendProtocolController.req_find_friend()

UIManager:closeWindow("UIFriendListWin")
UIManager:showWindow("UIFriendAddWin")
UIManager:closeWindow("UIFriendApplyWin")

elseif self.menuIndex==eFriendMenu.eApply then


friendProtocolController.req_apply_list()

UIManager:closeWindow("UIFriendListWin")
UIManager:closeWindow("UIFriendAddWin")
UIManager:showWindow("UIFriendApplyWin")

end
end

function UIFriendWin:refreshReddot(id)
local grids=self.menuScroller:getChildScrollViewItemWidgets()
local slot=grids[id-1]
if slot then
if id==eFriendMenu.eApply then
local list=friendModel:getList(eFriendDataType.eApply)
slot:SetChildActive(MenuCmpIndex.reddot,#list>0)
end
end
end




function UIFriendWin:onClickMenu(chickNum,index)
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
