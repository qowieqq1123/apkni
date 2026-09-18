







def_class("UILingShouQLTips",UIWindowBase)









function UILingShouQLTips:bindComponents()

self.Root=UIObject.get(self,0)
self.root=UIObject.get(self,1)
self.arr=UIObject.get(self,2)
self.title=UIText.get(self,3)



end


function UILingShouQLTips:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.Root);self.Root=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.arr);self.arr=nil;
_UIObject_release(self.title);self.title=nil;
end















local _this



function UILingShouQLTips:onLoaded(...)
self:bindComponents()
_this=self
end


function UILingShouQLTips:__delete()
self:unbindComponents()
local cb=self.callback
if cb then
cb()
end
_this=nil
end




function UILingShouQLTips:onShow(argtable,afterOnloaded)
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
local exparem=argtable.exparem

local root=self.root
if exparem then
root:setChildLocalPosition(Vector3.New(exparem[1][1],exparem[1][2],exparem[1][3]))
self.arr:setChildLocalPosition(Vector3.New(exparem[2][1],exparem[2][2],exparem[2][3]))
self.arr:setRotation(exparem[3][1],exparem[3][2],exparem[3][3])
else
root:setChildLocalPosition(Vector3.New(self.pos.x,self.pos.y,0))
end
root:setChildCanvasGroupAlpha(0)
root:setChildCanvasGroupDOFade(1,0.6,nil)
root:setScale(Vector3.New(1,1,1))


local title=argtable.title or''

self.title:setText(title)



end


function UILingShouQLTips:onHide()

end