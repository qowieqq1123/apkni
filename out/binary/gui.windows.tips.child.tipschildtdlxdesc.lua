







def_class("tipsChildTDLXDesc",UICloneObject)





tipsChildTDLXDesc.abName="ui/windows/tips/child/tipschildtdlxdesc.ab"

tipsChildTDLXDesc.assetName="tipsChildTDLXDesc"


function tipsChildTDLXDesc:bindComponents()

self.desc=UIText.get(self,0)
self.title=UIText.get(self,1)

end


function tipsChildTDLXDesc:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.desc);self.desc=nil;
_UIObject_release(self.title);self.title=nil;
end









function tipsChildTDLXDesc:onLoaded(...)
self:bindComponents()
end


function tipsChildTDLXDesc:__delete()
self:unbindComponents()
end




function tipsChildTDLXDesc:onShow(args)
local data=args.argtable
local childType=args.childType
local nodeidx=args.nodeidx
local tjId=wanLingTaModel:good2TDLX(data.itemid)
local tjCfg=wanLingTaModel:getTuJianConfig(tjId)
local attach=data.attach

self.title:setText('灵秀传说')
local desc_str=tjCfg.desc
self.desc:setText(desc_str)
end