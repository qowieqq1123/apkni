







def_class("tipsChildGuBaoSpe",UICloneObject)





tipsChildGuBaoSpe.abName="ui/windows/tips/child/tipschildgubaospe.ab"

tipsChildGuBaoSpe.assetName="tipsChildGuBaoSpe"


function tipsChildGuBaoSpe:bindComponents()

self.desc=UIText.get(self,0)

end


function tipsChildGuBaoSpe:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.desc);self.desc=nil;
end







function tipsChildGuBaoSpe:onLoaded(...)
self:bindComponents()
end


function tipsChildGuBaoSpe:__delete()
self:unbindComponents()
end


function tipsChildGuBaoSpe:onHide()

end




function tipsChildGuBaoSpe:onShow(argtable,afterOnloaded)
local data=argtable.argtable
local childType=argtable.childType
local nodeidx=argtable.nodeidx
local gbid
if data.tipsType==TIPS_TYPE.eCommonGubao then
gbid=data.itemid
else
gbid=gubaoLookup:good2GuBao(data.itemid)
end
local attach=data.attach

self.desc:setText('特殊古宝无法炼化和升星')
end

