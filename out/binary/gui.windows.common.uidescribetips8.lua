







def_class("UIDescribeTips8",UIWindowBase)









function UIDescribeTips8:bindComponents()

self.title=UIText.get(self,0)
self.descgrid=UIObject.get(self,1)
self.root=UIObject.get(self,2)
self.arrowTopLeft=UIObject.get(self,3)
self.arrowTopRight=UIObject.get(self,4)
self.arrowBottomLeft=UIObject.get(self,5)
self.arrowBottomRight=UIObject.get(self,6)



end


function UIDescribeTips8:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.title);self.title=nil;
_UIObject_release(self.descgrid);self.descgrid=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.arrowTopLeft);self.arrowTopLeft=nil;
_UIObject_release(self.arrowTopRight);self.arrowTopRight=nil;
_UIObject_release(self.arrowBottomLeft);self.arrowBottomLeft=nil;
_UIObject_release(self.arrowBottomRight);self.arrowBottomRight=nil;
end



















function UIDescribeTips8:onLoaded(...)
self:bindComponents()
end


function UIDescribeTips8:__delete()
self:unbindComponents()
end




function UIDescribeTips8:onShow(argtable,afterOnloaded)
local posType=argtable.posType or 1
local pivot_x
local pivot_y
if posType==1 then
pivot_x=0.095
pivot_y=1
elseif posType==2 then
pivot_x=0.905
pivot_y=1
elseif posType==3 then
pivot_x=0.095
pivot_y=0
elseif posType==4 then
pivot_x=0.905
pivot_y=0
end
self.root:setAnchors(0.5,0.5,pivot_x,pivot_y)
self.arrowTopLeft:setActive(posType==1)
self.arrowTopRight:setActive(posType==2)
self.arrowBottomLeft:setActive(posType==3)
self.arrowBottomRight:setActive(posType==4)

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

self.title:setText(argtable.title)
self.desclist=nil
if argtable.mode==1 then
if argtable.datas~=nil and#argtable.datas>0 then
self.desclist=argtable.datas
end
elseif argtable.mode==2 then
if argtable.num~=nil and argtable.num>0 then
self.desclist={}
local name=argtable.name
for i=1,argtable.num do
table.insert(self.desclist,cfgHelper.get1(cfg_lang_get,string.format(name,i)))
end
end
elseif argtable.mode==3 then
self.desclist={}
local num=argtable.num or 10
local name=argtable.name
for i=1,num do
local str=cfgHelper.get1(cfg_lang_get,string.format(name,i))
if str~=nil then
table.insert(self.desclist,str)
end
end
end
self:refreshDesc()
end


function UIDescribeTips8:onHide()

end

function UIDescribeTips8:refreshDesc()
local desclist=self.desclist
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



