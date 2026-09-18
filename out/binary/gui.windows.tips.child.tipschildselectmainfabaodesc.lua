







def_class("tipsChildSelectMainFabaoDesc",UICloneObject)





tipsChildSelectMainFabaoDesc.abName="ui/windows/tips/child/tipschildselectmainfabaodesc.ab"

tipsChildSelectMainFabaoDesc.assetName="tipsChildSelectMainFabaoDesc"


function tipsChildSelectMainFabaoDesc:bindComponents()

self.desc=UIText.get(self,0)
self.title=UIText.get(self,1)

end


function tipsChildSelectMainFabaoDesc:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.desc);self.desc=nil;
_UIObject_release(self.title);self.title=nil;
end








function tipsChildSelectMainFabaoDesc:onLoaded(...)
self:bindComponents()
end

function tipsChildSelectMainFabaoDesc:__delete()
self:unbindComponents()
end

function tipsChildSelectMainFabaoDesc:onShow(args,afterOnloaded)
local data=args.argtable
self.desc:setText(data.desc)
self.title:setText(data.title)
end

function tipsChildSelectMainFabaoDesc:onHide()

end


