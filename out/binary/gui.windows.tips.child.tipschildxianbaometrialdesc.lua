







def_class("tipsChildXianBaoMetrialDesc",UICloneObject)





tipsChildXianBaoMetrialDesc.abName="ui/windows/tips/child/tipschildxianbaometrialdesc.ab"

tipsChildXianBaoMetrialDesc.assetName="tipsChildXianBaoMetrialDesc"


function tipsChildXianBaoMetrialDesc:bindComponents()

self.desc=UIText.get(self,0)
self.tipsChildXianBaoMetrialDesc=UIObject.get(self,1)

end


function tipsChildXianBaoMetrialDesc:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.desc);self.desc=nil;
_UIObject_release(self.tipsChildXianBaoMetrialDesc);self.tipsChildXianBaoMetrialDesc=nil;
end









function tipsChildXianBaoMetrialDesc:onLoaded(...)
self:bindComponents()
end


function tipsChildXianBaoMetrialDesc:__delete()
self:unbindComponents()
end




function tipsChildXianBaoMetrialDesc:onShow(argtable,afterOnloaded)
local data=argtable.argtable
local childType=argtable.childType
local nodeidx=argtable.nodeidx
local xbid=data.itemid
local attach=data.attach
local formType=data.formType
local xbItemId=attach.xbItemId
if formType==TIPS_FORM_TYPE.eXianBaoTujian or formType==TIPS_FORM_TYPE.eXianBaoUpStar or not xbItemId then
self.tipsChildXianBaoMetrialDesc:setActive(false)
return
end
local xbItemIdCfg=itemsConfig.getConfig(xbItemId)
if xbItemIdCfg.desc then
self.desc:setText(xbItemIdCfg.desc)
end
end


function tipsChildXianBaoMetrialDesc:onHide()

end


