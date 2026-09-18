







def_class("UIXMKuFangTabWin",UIWindowBase)









function UIXMKuFangTabWin:bindComponents()

self.left=UIObject.get(self,0)
self.root=UIObject.get(self,1)



end


function UIXMKuFangTabWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.left);self.left=nil;
_UIObject_release(self.root);self.root=nil;
end


















local _menu_slot_name='button_dytab'
local _leftConfig={
{
name="捐赠",
showFun=function()
UIFullXianMengXianWuLouControl:showWindow("UIXMKuFangWin")
UIFullXianMengXianWuLouControl:showWindow("UITopMoneyWin7",{{{1},{78},{77}},"个人："})
UIManager:invokeUIMethod("UIXMXianWuLouModelWin","onShowArgRecv")
end,
closeFun=function()
UIFullXianMengXianWuLouControl:closeWindow("UIXMKuFangWin")

end,
refreshFun=function()
UIManager:invokeUIMethod("UIXMKuFangWin","onShow")
end,
reddotfun=function()
return false
end,

openfunc=function()
return true
end,
},
{
name="库存",
showFun=function()
UIFullXianMengXianWuLouControl:showWindow("UIXMKuCunWin")
UIFullXianMengXianWuLouControl:showWindow("UITopMoneyWin7",{{{84},{86},{85}},"仙盟："})
UIManager:invokeUIMethod("UIXMXianWuLouModelWin","onShowArgRecv")
end,
closeFun=function()
UIFullXianMengXianWuLouControl:closeWindow("UIXMKuCunWin")

end,
refreshFun=function()
UIManager:invokeUIMethod("UIXMKuCunWin","onShow")
end,
reddotfun=function()
return false
end,

openfunc=function()
return systemModel.isOpen(SYSTEM_DEFINE.eXMKFkuCun)
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


function UIXMKuFangTabWin:onLoaded(...)
self:bindComponents()
self:initLeftTabs()
end


function UIXMKuFangTabWin:__delete()
self:unbindComponents()
end




function UIXMKuFangTabWin:onShow(argtable,afterOnloaded)
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

function UIXMKuFangTabWin:onShowArgRecv(argtable)
self:onShow(argtable)
end


function UIXMKuFangTabWin:onHide()

end

function UIXMKuFangTabWin:initLeftTabs()
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


function UIXMKuFangTabWin:onClickLeftTab(index,refresh)
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

function UIXMKuFangTabWin:getSelectTab()
return self.lSelect
end


