







def_class("UIXMZengLiTabWin",UIWindowBase)









function UIXMZengLiTabWin:bindComponents()

self.left=UIObject.get(self,0)
self.root=UIObject.get(self,1)



end


function UIXMZengLiTabWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.left);self.left=nil;
_UIObject_release(self.root);self.root=nil;
end

















local _menu_slot_name='button_dytab'
local _leftConfig={























{
name="征战",
showFun=function()
UIFullXianMengXianWuLouControl:showWindow("UIXMZengLiWin",{tabIndex=2})

UIManager:invokeUIMethod("UIXMXianWuLouModelWin","onShowArgRecv")
end,
closeFun=function()
UIFullXianMengXianWuLouControl:closeWindow("UIXMZengLiWin")

end,
refreshFun=function()
UIManager:invokeUIMethod("UIXMZengLiWin","onShow",{tabIndex=2})
end,
reddotfun=function()
return xianMengBaoXiangModel:getGiftReddot(2)
end,

openfunc=function()
return true

end,
},

}

local _leftCmp={
name1=0,
name2=1,
notSelected=2,
selected=3,
reddot=4,
}

local this


function UIXMZengLiTabWin:onLoaded(...)
self:bindComponents()
self:initLeftTabs()
this=self
end


function UIXMZengLiTabWin:__delete()
self:unbindComponents()
end




function UIXMZengLiTabWin:onShow(argtable,afterOnloaded)
if afterOnloaded then
self.root:setChildCanvasGroupAlpha(0)
self:delayDo(0.15,function()
self.root:setChildCanvasGroupDOFade(1,0.5)
end)
end
if argtable and argtable.tabIndex then
self:onClickLeftTab(argtable.tabIndex,true)
else
self:onClickLeftTab(self.lSelect or 1,true)
end
end

function UIXMZengLiTabWin:onShowArgRecv(argtable)
self:onShow(argtable)
end


function UIXMZengLiTabWin:onHide()

end

function UIXMZengLiTabWin:initLeftTabs()
self.left:setChildLayoutGroupCreateItems(#_leftConfig,function(index)
local item=self.left:getChildLayoutGroupGridItem(index-1)
local config=_leftConfig[index]
local selected=self.lSelect==index
if config.openfunc(self)then
item:SetChildActive(-1,true)
item:SetChildText(_leftCmp.name1,config.name)
item:SetChildText(_leftCmp.name2,config.name)
item:SetChildActive(_leftCmp.notSelected,not selected)
item:SetChildActive(_leftCmp.selected,selected)
item:SetChildButtonClick(-1,function()
self:onClickLeftTab(index)
end)
item:SetChildActive(_leftCmp.reddot,config.reddotfun(self))
else
item:SetChildActive(-1,false)
end
end)
end

function UIXMZengLiTabWin:onClickLeftTab(index,refresh)
if index~=self.lSelect or refresh then
if self.lSelect then
local item=self.left:getChildLayoutGroupGridItem(self.lSelect-1)
item:SetChildActive(_leftCmp.notSelected,true)
item:SetChildActive(_leftCmp.selected,false)
local lConfig=_leftConfig[self.lSelect]
lConfig.closeFun()
end
self.lSelect=index
local item=self.left:getChildLayoutGroupGridItem(self.lSelect-1)
item:SetChildActive(_leftCmp.notSelected,false)
item:SetChildActive(_leftCmp.selected,true)
local lConfig=_leftConfig[self.lSelect]
lConfig.showFun(self,true)
end
end

function UIXMZengLiTabWin:getSelectTab()
return self.lSelect
end

function UIXMZengLiTabWin:refreshTab()
local items=this.left:getChildLayoutGroupGridList()
for i=1,#_leftConfig do
local item=items[i-1]
local config=_leftConfig[i]

if config.openfunc(this)then
item:SetChildActive(-1,true)
item:SetChildActive(_leftCmp.reddot,config.reddotfun(this))
end
end
end



