







def_class("UITianShuDaZhenTeQuanTips",UIWindowBase)









function UITianShuDaZhenTeQuanTips:bindComponents()

self.desc=UIText.get(self,0)
self.root=UIObject.get(self,1)
self.tipsName=UIText.get(self,2)



end


function UITianShuDaZhenTeQuanTips:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.desc);self.desc=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.tipsName);self.tipsName=nil;
end



















function UITianShuDaZhenTeQuanTips:onLoaded(...)
self:bindComponents()
end


function UITianShuDaZhenTeQuanTips:__delete()
self:unbindComponents()
end




function UITianShuDaZhenTeQuanTips:onShow(argtable,afterOnloaded)
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
self.tipsName:setText(argtable.name)
self.desc:setText(argtable.str)
self.root:setChildLocalPosition(Vector3.New(self.pos.x,self.pos.y,0))
self.root:setChildCanvasGroupAlpha(0)
self.root:setChildCanvasGroupDOFade(1,0.1,nil)
self.root:setScale(Vector3.New(0,0,0))
self.root:setChildDOScale(1,0.2,nil)
end


function UITianShuDaZhenTeQuanTips:onHide()

end



