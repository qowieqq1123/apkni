







def_class("UIDescribeTips2",UIWindowBase)









function UIDescribeTips2:bindComponents()

self.root=UIObject.get(self,0)
self.descgrid=UIObject.get(self,1)
self.frameImg=UIImage.get(self,2)
self.title=UIText.get(self,3)
self.titleEx=UIText.get(self,4)



end


function UIDescribeTips2:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.descgrid);self.descgrid=nil;
_UIObject_release(self.frameImg);self.frameImg=nil;
_UIObject_release(self.title);self.title=nil;
_UIObject_release(self.titleEx);self.titleEx=nil;
end



















function UIDescribeTips2:onLoaded(...)
self:bindComponents()
end


function UIDescribeTips2:__delete()
self:unbindComponents()
end




function UIDescribeTips2:onShow(argtable,afterOnloaded)
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
local tileOutLine=argtable.framecolor~=nil
if argtable.framecolor then
local abName,frameIcon=UIDiscipleModel.getSpecialityColorFrame(argtable.framecolor)
self.frameImg:setSprite(abName,frameIcon)
self.titleEx:setText(argtable.title)
else
self.titleEx:setText("")
end
local comp=self.title:getCommonComponent('Outline')
comp.enabled=tileOutLine
self.title:setText(argtable.title)
if argtable.alignment then
self.winlua:SetChildTextAlignment(self.title:getID(),argtable.alignment)
end
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


function UIDescribeTips2:onHide()

end



