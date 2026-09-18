







def_class("UIShowEquipSuitInfoWin",UIWindowBase)









function UIShowEquipSuitInfoWin:bindComponents()

self.root=UIObject.get(self,0)
self.content=UIText.get(self,1)
self.suitName=UIText.get(self,2)



end


function UIShowEquipSuitInfoWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.content);self.content=nil;
_UIObject_release(self.suitName);self.suitName=nil;
end



















function UIShowEquipSuitInfoWin:onLoaded(...)
self:bindComponents()
end


function UIShowEquipSuitInfoWin:__delete()
self:unbindComponents()
end




function UIShowEquipSuitInfoWin:onShow(argtable,afterOnloaded)
local data=argtable.data
local suitConfig=equipsConfig.getSuitConfig(data[1])
local name=suitConfig.name
local count=data[2]
local content='???'
if count==2 then
content=suitConfig.attr2desc
elseif count==3 then
content=suitConfig.attr3desc
end
self.suitName:setText(FMT.fmt('{0}[{1}件]',name,count))
self.content:setText(content)

local pos=argtable.pos
if pos then
self.root:setChildCanvasGroupAlpha(0)
local style=argtable.style or'top'
local offset=argtable.offset
self:delayDo(0.05,function()
if style=='top'then
local size=self.root:getChildRectHeight()
pos.y=pos.y+size/2
elseif style=='bottom'then
local size=self.root:getChildRectHeight()
pos.y=pos.y-size/2
elseif style=='left'then
local size=self.root:getChildRectWidth()
pos.x=pos.x-size/2
elseif style=='right'then
local size=self.root:getChildRectWidth()
pos.x=pos.x+size/2
end
pos.x=pos.x+offset[1]
pos.y=pos.y+offset[2]
self.root:setChildLocalPosition(pos)
self.root:setChildCanvasGroupAlpha(1)
end)
end
end


function UIShowEquipSuitInfoWin:onHide()

end




function UIShowEquipSuitInfoWin:onCloseClick()
self:closeSelf()
end