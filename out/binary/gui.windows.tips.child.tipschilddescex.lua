







def_class("tipsChildDescEx",UICloneObject)





tipsChildDescEx.abName="ui/windows/tips/child/tipschilddescex.ab"

tipsChildDescEx.assetName="tipsChildDescEx"


function tipsChildDescEx:bindComponents()

self.desc=UIText.get(self,0)
self.line=UIObject.get(self,1)

end


function tipsChildDescEx:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.desc);self.desc=nil;
_UIObject_release(self.line);self.line=nil;
end








function tipsChildDescEx:onLoaded(...)
self:bindComponents()
end

function tipsChildDescEx:__delete()
self:unbindComponents()
end

function tipsChildDescEx:onShow(args,afterOnloaded)
local data=args.argtable
local childType=args.childType
local nodeidx=args.nodeidx
local itemid=data.itemid
local itemguid=data.itemguid
local attach=data.attach
local itemConfig=itemsConfig.getConfig(itemid)
self.desc:setText(itemConfig.desc or'描叙无配置')
self.line:setActive(not self:isLastItem())
end

function tipsChildDescEx:onHide()

end



function tipsChildDescEx:onRecycle()
self.line:setActive(not self:isLastItem())
end