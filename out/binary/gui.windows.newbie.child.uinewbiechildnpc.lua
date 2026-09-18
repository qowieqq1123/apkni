







def_class("UINewbieChildNPC",UICloneObject)





UINewbieChildNPC.abName="ui/windows/newbie/child/uinewbiechildnpc.ab"

UINewbieChildNPC.assetName="UINewbieChildNPC"


function UINewbieChildNPC:bindComponents()

self.UINewbieChildNPC=UIObject.get(self,0)
self.desc=UIText.get(self,1)
self.modelObj=UIObject.get(self,2)

end


function UINewbieChildNPC:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.UINewbieChildNPC);self.UINewbieChildNPC=nil;
_UIObject_release(self.desc);self.desc=nil;
_UIObject_release(self.modelObj);self.modelObj=nil;
end








function UINewbieChildNPC:onLoaded(...)
self:bindComponents()
end

function UINewbieChildNPC:__delete()
self.modelObj:setChildUIModelRemoveTarget()
self:unbindComponents()
end

function UINewbieChildNPC:onShow(argtable,afterOnloaded)
local model=argtable.model
local dire=argtable.dire or{1,1}
local body=model[1]
local componets=model[2]
local scale=model[3]
local anim=model[4]
local offsetX=model[5]or 0
local offsetY=model[6]or 0
if componets==nil or#componets==0 then componets=nil end
self.modelObj:setChildUIModelShowTarget(body,scale,componets,anim,false,false,0)
self.widget:SetChildScale(self.modelObj:getID(),Vector3(dire[1]or 1,dire[2]or 1,1))
self.widget:SetChildLocalPosition(self.modelObj:getID(),Vector3(offsetX,offsetY,0))
self.desc:setText(argtable.desc or'')
self.widget:SetChildScale(self.UINewbieChildNPC:getID(),Vector3.zero)
self.widget:SetChildDOScale(self.UINewbieChildNPC:getID(),1,0.2,nil)
end

function UINewbieChildNPC:onHide()

end


