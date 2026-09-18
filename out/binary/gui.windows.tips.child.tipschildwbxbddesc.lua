







def_class("tipsChildWBXBDDesc",UICloneObject)





tipsChildWBXBDDesc.abName="ui/windows/tips/child/tipschildwbxbddesc.ab"

tipsChildWBXBDDesc.assetName="tipsChildWBXBDDesc"


function tipsChildWBXBDDesc:bindComponents()

self.desc=UILinkImageText.get(self,0)

end


function tipsChildWBXBDDesc:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.desc);self.desc=nil;
end









function tipsChildWBXBDDesc:onLoaded(...)
self:bindComponents()
end


function tipsChildWBXBDDesc:__delete()
self:unbindComponents()
end




function tipsChildWBXBDDesc:onShow(argtable,afterOnloaded)
local data=argtable.argtable
local itemid=data.itemid
local itemConfig=itemsConfig.getConfig(itemid)
self.desc:setText(itemConfig.desc)
self.widget:ForceLayoutRect(-1)
end


function tipsChildWBXBDDesc:onHide()

end


