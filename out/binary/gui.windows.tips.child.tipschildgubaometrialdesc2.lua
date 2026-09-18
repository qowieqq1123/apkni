







def_class("tipsChildGuBaoMetrialDesc2",UICloneObject)





tipsChildGuBaoMetrialDesc2.abName="ui/windows/tips/child/tipschildgubaometrialdesc2.ab"

tipsChildGuBaoMetrialDesc2.assetName="tipsChildGuBaoMetrialDesc2"


function tipsChildGuBaoMetrialDesc2:bindComponents()

self.desc=UIText.get(self,0)

end


function tipsChildGuBaoMetrialDesc2:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.desc);self.desc=nil;
end







function tipsChildGuBaoMetrialDesc2:onLoaded(...)
self:bindComponents()
end


function tipsChildGuBaoMetrialDesc2:__delete()
self:unbindComponents()
end


function tipsChildGuBaoMetrialDesc2:onHide()

end




function tipsChildGuBaoMetrialDesc2:onShow(argtable,afterOnloaded)
local data=argtable.argtable
local childType=argtable.childType
local nodeidx=argtable.nodeidx
local itemid=data.itemid
local itemguid=data.itemguid
local attach=data.attach

local itemConfig=itemsConfig.getConfig(itemid)
self.desc:setText(itemConfig.desc)
end

