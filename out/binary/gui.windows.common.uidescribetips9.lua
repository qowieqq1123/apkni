







def_class("UIDescribeTips9",UIWindowBase)









function UIDescribeTips9:bindComponents()

self.root=UIObject.get(self,0)
self.descTxt=UIText.get(self,1)



end


function UIDescribeTips9:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.descTxt);self.descTxt=nil;
end



















function UIDescribeTips9:onLoaded(...)
self:bindComponents()
end


function UIDescribeTips9:__delete()
self:unbindComponents()
end




function UIDescribeTips9:onShow(argtable,afterOnloaded)
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

local desc=argtable.str
self.descTxt:setText(desc)
end


function UIDescribeTips9:onHide()

end



