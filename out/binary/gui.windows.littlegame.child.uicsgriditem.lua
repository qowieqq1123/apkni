







def_class("UICSGridItem",UICloneObject)





UICSGridItem.abName="ui/windows/littlegame/child/uicsgriditem.ab"

UICSGridItem.assetName="UICSGridItem"


function UICSGridItem:bindComponents()

self.UICSGridItem=UIObject.get(self,0)
self.restDisciple=UIObject.get(self,1)
self.reward=UIObject.get(self,2)

end


function UICSGridItem:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.UICSGridItem);self.UICSGridItem=nil;
_UIObject_release(self.restDisciple);self.restDisciple=nil;
_UIObject_release(self.reward);self.reward=nil;
end









function UICSGridItem:onLoaded(...)
self:bindComponents()
end


function UICSGridItem:__delete()
self:unbindComponents()
end




function UICSGridItem:onShow(argtable,afterOnloaded)
self.posx=argtable.posx
self.posy=argtable.posy
self.itemid=argtable.itemid
self.active=argtable.active

if self.itemid then
self:freshRewardItem(self.itemid)
end

self:setActive(self.active)

self.UICSGridItem:setChildAnchoredPosition(Vector2(self.posx,self.posy))
end


function UICSGridItem:onHide()

end

function UICSGridItem:getPosition()
return self.UICSGridItem:getChildPosition()
end

function UICSGridItem:freshRewardItem(itemid)
if itemid then
local itemicon=iconHelper.getIconName(itemid)
self.reward:setChildIcon(itemicon,false)
end
end

function UICSGridItem:freshRestDisciple(discipleId)
if discipleId then
self.restDisciple:setChildUIModelShowTarget(discipleId,1,nil,eAnimationID.stand)
end
end

function UICSGridItem:doPickUpRewardItem()
self.reward:setActive(false)
end

function UICSGridItem:setActive(state)
self.UICSGridItem:setActive(state)
end


