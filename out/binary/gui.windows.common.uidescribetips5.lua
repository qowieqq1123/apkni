







def_class("UIDescribeTips5",UIWindowBase)









function UIDescribeTips5:bindComponents()

self.titleTxt=UIText.get(self,0)
self.descTxt=UIText.get(self,1)
self.root=UIObject.get(self,2)



end


function UIDescribeTips5:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.titleTxt);self.titleTxt=nil;
_UIObject_release(self.descTxt);self.descTxt=nil;
_UIObject_release(self.root);self.root=nil;
end

















function UIDescribeTips5:onLoaded(...)
self:bindComponents()
end


function UIDescribeTips5:__delete()
self:unbindComponents()
end


function UIDescribeTips5:onHide()

end




function UIDescribeTips5:onShow(argtable,afterOnloaded)
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

self.titleTxt:setText(argtable.title)
self.descTxt:setText(argtable.desc)
end


