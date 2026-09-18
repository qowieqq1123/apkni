







def_class("UIDescribeTips",UIWindowBase)









function UIDescribeTips:bindComponents()

self.title1=UIText.get(self,0)
self.title2=UIText.get(self,1)
self.descgrid=UIObject.get(self,2)
self.root=UIObject.get(self,3)



end


function UIDescribeTips:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.title1);self.title1=nil;
_UIObject_release(self.title2);self.title2=nil;
_UIObject_release(self.descgrid);self.descgrid=nil;
_UIObject_release(self.root);self.root=nil;
end

















function UIDescribeTips:onLoaded(...)
self:bindComponents()
end


function UIDescribeTips:__delete()
self:unbindComponents()
end


function UIDescribeTips:onHide()

end




function UIDescribeTips:onShow(argtable,afterOnloaded)
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
end
self.root:setLocalPos(curpos.x,curpos.y,0)

self.title1:setText(argtable.title1)
self.title2:setText(argtable.title2)
local desclist=argtable.desclist
local num=#desclist
self.descgrid:setChildLayoutGroupCreateItems(num)
if num>0 then
local grid=self.descgrid:getChildLayoutGroupGridList()
for i=1,num do
local item=grid[i-1]
local data=desclist[i]
item:SetChildText(0,data[1])
item:SetChildText(1,data[2])
end
end
end