







def_class("tipsChildAttachDesc",UICloneObject)





tipsChildAttachDesc.abName="ui/windows/tips/child/tipschildattachdesc.ab"

tipsChildAttachDesc.assetName="tipsChildAttachDesc"

function tipsChildAttachDesc:bindComponents()

self.desc=UILinkImageText.get(self,0)

end


function tipsChildAttachDesc:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.desc);self.desc=nil;
end









function tipsChildAttachDesc:onLoaded(...)
self:bindComponents()
end


function tipsChildAttachDesc:__delete()
self:unbindComponents()
end




function tipsChildAttachDesc:onShow(args,afterOnloaded)

local data=args.argtable






self.desc:setText(data.attach.desc)
end


function tipsChildAttachDesc:onHide()

end



