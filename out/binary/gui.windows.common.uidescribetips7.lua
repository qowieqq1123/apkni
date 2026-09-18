







def_class("UIDescribeTips7",UIWindowBase)









function UIDescribeTips7:bindComponents()

self.title1=UIText.get(self,0)
self.descgrid=UIObject.get(self,1)
self.root=UIObject.get(self,2)



end


function UIDescribeTips7:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.title1);self.title1=nil;
_UIObject_release(self.descgrid);self.descgrid=nil;
_UIObject_release(self.root);self.root=nil;
end



















function UIDescribeTips7:onLoaded(...)
self:bindComponents()
end


function UIDescribeTips7:__delete()
self:unbindComponents()
end




function UIDescribeTips7:onShow(argtable,afterOnloaded)
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
local desclist=argtable.desclist
local num=#desclist
self.descgrid:setChildLayoutGroupCreateItems(num)
if num>0 then
local grid=self.descgrid:getChildLayoutGroupGridList()
for i=1,num do
local item=grid[i-1]
local data=desclist[i]
item:SetChildText(0,data)
end
end
end


function UIDescribeTips7:onHide()

end



