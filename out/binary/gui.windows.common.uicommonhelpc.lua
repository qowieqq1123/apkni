







def_class("UICommonHelpC",UIWindowBase)









function UICommonHelpC:bindComponents()

self.root=UIObject.get(self,0)
self.title=UIText.get(self,1)
self.scrollview=UIObject.get(self,2)



end


function UICommonHelpC:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.title);self.title=nil;
_UIObject_release(self.scrollview);self.scrollview=nil;
end



















function UICommonHelpC:onLoaded(...)
self:bindComponents()

self.scrollview:setChildScrollViewInit(0,true,nil,nil)
end


function UICommonHelpC:__delete()
self:unbindComponents()
end




function UICommonHelpC:onShow(argtable,afterOnloaded)
local playScale=argtable.playScale
if playScale then
local scaleStartVal=argtable.scaleStartVal
self.root:setScale(Vector3.New(scaleStartVal[1],scaleStartVal[2],1))
self.root:setChildDOScale(1,0.35)
end
local pos=argtable.pos
local pivot=argtable.pivot
if pivot then
self.root:setChildPivot(Vector2.New(pivot[1],pivot[2]))
end
if argtable.maxAutoSize then


end
if argtable.width then
self.root:setChildSizeDelta(argtable.width,0)
self.scrollview:setChildSizeDelta(argtable.width,0)
end
self.root:setChildAnchoredPos(pos[1],pos[2])
self.title:setText(argtable.title)
self:setDesList(argtable.dlist)
end


function UICommonHelpC:onHide()

end

function UICommonHelpC:setDesList(desDatas)
local len=#desDatas
self.scrollview:setChildScrollViewCreateGrids(len,0)
self.grids=self.scrollview:getChildScrollViewItemWidgets()
local count=self.grids.Count
for i=1,count do
local item=self.grids[i-1]
local des=desDatas[i]
item:SetChildText(0,des)
end
end




function UICommonHelpC:onCloseClick()
self:closeSelf()
end