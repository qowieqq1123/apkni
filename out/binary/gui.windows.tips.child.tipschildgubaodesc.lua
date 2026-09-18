







def_class("tipsChildGuBaoDesc",UICloneObject)





tipsChildGuBaoDesc.abName="ui/windows/tips/child/tipschildgubaodesc.ab"

tipsChildGuBaoDesc.assetName="tipsChildGuBaoDesc"


function tipsChildGuBaoDesc:bindComponents()

self.title=UIText.get(self,0)
self.desc=UIText.get(self,1)

end


function tipsChildGuBaoDesc:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.title);self.title=nil;
_UIObject_release(self.desc);self.desc=nil;
end







function tipsChildGuBaoDesc:onLoaded(...)
self:bindComponents()
end


function tipsChildGuBaoDesc:__delete()
self:unbindComponents()
end


function tipsChildGuBaoDesc:onHide()

end

function tipsChildGuBaoDesc:onShow(args)
local data=args.argtable
local childType=args.childType
local nodeidx=args.nodeidx
local gbid
if data.tipsType==TIPS_TYPE.eCommonGubao then
gbid=data.itemid
else
gbid=gubaoLookup:good2GuBao(data.itemid)
end
local attach=data.attach

self.title:setText('古宝传说')
local desc_str=cfgHelper.get2(cfg_gubaoconfig_get,gbid,'story')
self.desc:setText(desc_str)
end

