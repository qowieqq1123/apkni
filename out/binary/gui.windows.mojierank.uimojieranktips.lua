







def_class("UIMoJieRankTips",UIWindowBase)









function UIMoJieRankTips:bindComponents()

self.Root=UIObject.get(self,0)
self.uiRoot=UIObject.get(self,1)



end


function UIMoJieRankTips:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.Root);self.Root=nil;
_UIObject_release(self.uiRoot);self.uiRoot=nil;
end



















function UIMoJieRankTips:onLoaded(...)
self:bindComponents()
end


function UIMoJieRankTips:__delete()
self:unbindComponents()
local cb=self.callback
if cb then
cb()
end
end




function UIMoJieRankTips:onShow(argtable,afterOnloaded)
self.callback=argtable.callback
local pos=nil
if argtable.posItem then
pos=argtable.posItem:getChildScreenPointToLocalPointRectangle()
elseif argtable.posWidget then
local posWidgetIndex=argtable.posWidgetIndex or-1
pos=argtable.posWidget:GetChildScreenPointToLocalPointRectangle(posWidgetIndex)
end
if pos then
local p=argtable.pos or{x=0,y=0}
pos.x=pos.x+p.x
pos.y=pos.y+p.y
else
pos=argtable.pos or Vector2.zero
end

self.pos=pos

local root=self.uiRoot
root:setChildLocalPosition(Vector3.New(self.pos.x,self.pos.y,0))
root:setChildCanvasGroupAlpha(0)
root:setChildCanvasGroupDOFade(1,0.6,nil)
root:setScale(Vector3.New(1,1,1))

local widget=root:getChildWidgetBase()
local descT=argtable.desc
if descT then
for i=1,9 do
if descT[i]then
widget:SetChildActive(i-1,true)
widget:SetChildText(i-1,descT[i])
else
widget:SetChildActive(i-1,false)
end
end
end
end


function UIMoJieRankTips:onHide()

end



