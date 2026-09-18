







def_class("UIDescribeTips4",UIWindowBase)









function UIDescribeTips4:bindComponents()

self.root=UIObject.get(self,0)
self.descgrid=UIObject.get(self,1)
self.icon=UIImage.get(self,2)
self.title=UIText.get(self,3)



end


function UIDescribeTips4:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.descgrid);self.descgrid=nil;
_UIObject_release(self.icon);self.icon=nil;
_UIObject_release(self.title);self.title=nil;
end



















function UIDescribeTips4:onLoaded(...)
self:bindComponents()
end


function UIDescribeTips4:__delete()
self:unbindComponents()
end




function UIDescribeTips4:onShow(argtable,afterOnloaded)
self.callback=argtable.callback
local curpos=argtable.pos or Vector2.New(0,0)
local pos=nil
if argtable.posItem then
pos=argtable.posItem:getChildScreenPointToLocalPointRectangle()
elseif argtable.posWidget then
pos=argtable.posWidget:GetChildScreenPointToLocalPointRectangle(-1)
end
if pos then
curpos.x=curpos.x+pos.x
curpos.y=curpos.y+pos.y
if argtable.offsetY then
curpos.y=curpos.y+argtable.offsetY
end
end
if argtable.pivot then
self.winlua:SetChildPivot(self.root:getID(),argtable.pivot)
end
self.root:setLocalPos(curpos.x,curpos.y,0)
if argtable.iconName then
self.icon:setChildIcon(argtable.iconName,argtable.iconnative or false)
end
self.title:setText(argtable.title)
local desclist=argtable.desclist
local num=#desclist
self.descgrid:setChildLayoutGroupCreateItems(num)
if num>0 then
local grid=self.descgrid:getChildLayoutGroupGridList()
for i=1,num do
local item=grid[i-1]
local str=desclist[i]
item:SetChildText(0,str)
end
end
end


function UIDescribeTips4:onHide()

end



function UIDescribeTips4:onClickClose()
local cb=self.callback
if cb then
cb()
end
self:closeSelf()
end