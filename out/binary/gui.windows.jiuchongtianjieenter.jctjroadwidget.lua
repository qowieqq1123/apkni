







def_class("jctjRoadWidget",UICloneObject)





jctjRoadWidget.abName="ui/windows/jiuchongtianjieenter/jctjroadwidget.ab"

jctjRoadWidget.assetName="jctjRoadWidget"


function jctjRoadWidget:bindComponents()

self.root=UIObject.get(self,0)
self.road=UIObject.get(self,1)

end


function jctjRoadWidget:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.road);self.road=nil;
end









function jctjRoadWidget:onLoaded(...)
self:bindComponents()
end


function jctjRoadWidget:__delete()
self:unbindComponents()
end




function jctjRoadWidget:onShow(argtable,afterOnloaded)
self:setWidgetPosition(argtable.pos)
self.road:setChildShowEffect(argtable.effect,true)
end

function jctjRoadWidget:setWidgetPosition(pos)
self.root:setChildAnchoredPosition(Vector2.New(pos[1],pos[2]))
self.root:setRotation(0,0,pos[3])
end

function jctjRoadWidget:setRootActive(show)
self.root:setActive(show)
end


function jctjRoadWidget:onHide()

end


