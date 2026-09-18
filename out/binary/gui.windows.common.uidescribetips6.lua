







def_class("UIDescribeTips6",UIWindowBase)









function UIDescribeTips6:bindComponents()

self.root=UIObject.get(self,0)
self.titleTxt=UIText.get(self,1)
self.title2Txt=UIText.get(self,2)
self.descTxt=UIText.get(self,3)



end


function UIDescribeTips6:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.titleTxt);self.titleTxt=nil;
_UIObject_release(self.title2Txt);self.title2Txt=nil;
_UIObject_release(self.descTxt);self.descTxt=nil;
end

















function UIDescribeTips6:onLoaded(...)
self:bindComponents()
end


function UIDescribeTips6:__delete()
self:unbindComponents()
end


function UIDescribeTips6:onHide()

end




function UIDescribeTips6:onShow(argtable,afterOnloaded)
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

local title_str=argtable.title
self.titleTxt:setText(title_str)
local title_str2=argtable.title2
self.title2Txt:setText(title_str2)
local desc_str=argtable.desc
self.descTxt:setText(desc_str)
end