







def_class("UIMER_Attr_Panel",UIWindowBase)









function UIMER_Attr_Panel:bindComponents()

self.eventPanel=UIObject.get(self,0)



end


function UIMER_Attr_Panel:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.eventPanel);self.eventPanel=nil;
end


















function UIMER_Attr_Panel:onChildLoaded(child)
self.child=child
self:bindChildComponents()
end


function UIMER_Attr_Panel:onLoaded(...)
self:bindComponents()
end


function UIMER_Attr_Panel:__delete()
MysteryEventModel:clear_event_str_list()
self:unbindComponents()
self.child=nil
end




function UIMER_Attr_Panel:onShow(argtable,afterOnloaded)
self:initAttrList()
if argtable and argtable.pos then
self:setAttrPanelPosition(argtable.pos)
end
end

function UIMER_Attr_Panel:setAttrPanelPosition(pos)

self.eventPanel:setLocalPos(pos.x,pos.y,pos.z)
end

function UIMER_Attr_Panel:initAttrList()
local eventlist=MysteryEventModel:get_event_str_list()
self.eventPanel:setChildScrollViewCreateGrids(#eventlist,1)
local grids=self.eventPanel:getChildScrollViewItemWidgets()
for i,v in ipairs(eventlist)do
local item=grids[i-1]
if item then
item:SetChildText(0,v)
end
end
end


function UIMER_Attr_Panel:onHide()

end



