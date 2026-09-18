







def_class("UINewbieChildSelect",UICloneObject)





UINewbieChildSelect.abName="ui/windows/newbie/child/uinewbiechildselect.ab"

UINewbieChildSelect.assetName="UINewbieChildSelect"


function UINewbieChildSelect:bindComponents()

self.icon=UIObject.get(self,0)

end


function UINewbieChildSelect:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.icon);self.icon=nil;
end








function UINewbieChildSelect:onLoaded(...)
self:bindComponents()
end

function UINewbieChildSelect:__delete()
self:unbindComponents()
end

function UINewbieChildSelect:onShow(argtable,afterOnloaded)
local args=argtable.args or{}
local entityInfo=argtable.entityInfo
local cmpid=argtable.cmpid
local size=args.size
local pos=args.pos
local aspect=args.aspect or 0
local isAspect=aspect==1
if isAspect then
local scale=self.widget:GetChildScale(self.icon:getID())



local x=scale.x
local y=scale.y
self.widget:SetChildScale(self.icon:getID(),Vector3(x,y,0))
end
if cmpid then
size=size or newbieManager.getTargetSize(cmpid)
end
if size then
self.icon:setChildSizeDelta(size.x,size.y)
end
if pos then
self.icon:setChildLocalPosition(Vector3(pos[1],pos[2],0))
end
end

function UINewbieChildSelect:onHide()

end


