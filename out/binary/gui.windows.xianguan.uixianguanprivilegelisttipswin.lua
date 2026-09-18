







def_class("UIXianGuanPrivilegeListTipsWin",UIWindowBase)









function UIXianGuanPrivilegeListTipsWin:bindComponents()

self.background=UIButton.get(self,0)
self.bgWenguan=UIObject.get(self,1)
self.bgWuguan=UIObject.get(self,2)
self.content=UIObject.get(self,3)
self.root=UIObject.get(self,4)
self.scrollView=UIObject.get(self,5)

self.background:setButtonClick(function()self:onBackground()end)



end


function UIXianGuanPrivilegeListTipsWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.background);self.background=nil;
_UIObject_release(self.bgWenguan);self.bgWenguan=nil;
_UIObject_release(self.bgWuguan);self.bgWuguan=nil;
_UIObject_release(self.content);self.content=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.scrollView);self.scrollView=nil;
end















local _abName="ui/icons/xianguantequan/xianguantequan_atlas_pak.ab"
local _itemCmp={
root=-1,
kuang=0,
icon=1,
name=2,
descList=3,
line=4,
actor=5,
}
local padding=37



function UIXianGuanPrivilegeListTipsWin:onLoaded(...)
self:bindComponents()
end


function UIXianGuanPrivilegeListTipsWin:__delete()
self:unbindComponents()
end




function UIXianGuanPrivilegeListTipsWin:onShow(argtable,afterOnloaded)
self.parentWin=argtable.parentWin
self.datas=argtable.datas
self.bgType=argtable.background
self.bgWenguan:setActive(self.bgType==XianGuanCampaignType.eWenXuan)
self.bgWuguan:setActive(self.bgType==XianGuanCampaignType.eWuXuan)

local count=#self.datas
self.content:setChildLayoutGroupCreateItems(count,function(index)
local item=self.content:getChildLayoutGroupGridItem(index-1)
local data=self.datas[index]
item:SetChildCSImageSprite(_itemCmp.icon,_abName,data.icon)
item:SetChildText(_itemCmp.name,FMT.fmt("  {0}",data.name))
item:SetChildActive(_itemCmp.actor,data.actor~=nil)
if data.actor then
item:SetChildText(_itemCmp.actor,data.actor)
end
item:SetChildLayoutGroupCreateItems(_itemCmp.descList,#data.descs,function(_index)
local descItem=item:GetChildLayoutGroupGridItem(_itemCmp.descList,_index-1)
local desc=data.descs[_index]
local obj=descItem:GetChildGameObject(1)
local width=descItem:GetChildSizeDeltaX(1)
local descStr=comHelper.getCheckLayoutStr(obj,width,desc,true)
descItem:SetChildText(0,descStr)
descItem:ForceLayoutRect(-1)
end)
item:SetChildActive(_itemCmp.line,index~=count)
item:ForceLayoutRect(_itemCmp.descList)
item:ForceLayoutRect(_itemCmp.root)
end)
self.winlua:ForceLayoutRect(self.content:getID())

local rootHeight=self.root:getChildRectHeight()
local width=self.scrollView:getChildSizeDeltaX()
local contentHeight=self.content:getChildRectHeight()
local targetHeight=contentHeight+padding

if targetHeight>rootHeight then
self.scrollView:setChildSizeDelta(width,rootHeight-padding)
self.scrollView:setChildScrollRectEnable(true)
else
self.scrollView:setChildSizeDelta(width,contentHeight)
self.scrollView:setChildScrollRectEnable(false)
end
end


function UIXianGuanPrivilegeListTipsWin:onHide()

end




function UIXianGuanPrivilegeListTipsWin:onBackground()
if self.parentWin then
self.parentWin:closeWindow(self.__name)
else
self:closeSelf()
end
end

