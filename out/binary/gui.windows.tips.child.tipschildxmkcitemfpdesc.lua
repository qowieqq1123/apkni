







def_class("tipsChildXMKCItemFPDesc",UICloneObject)





tipsChildXMKCItemFPDesc.abName="ui/windows/tips/child/tipschildxmkcitemfpdesc.ab"

tipsChildXMKCItemFPDesc.assetName="tipsChildXMKCItemFPDesc"


function tipsChildXMKCItemFPDesc:bindComponents()

self.desc=UIText.get(self,0)
self.tipsChildXMKCItemFPDesc=UIObject.get(self,1)

end


function tipsChildXMKCItemFPDesc:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.desc);self.desc=nil;
_UIObject_release(self.tipsChildXMKCItemFPDesc);self.tipsChildXMKCItemFPDesc=nil;
end









function tipsChildXMKCItemFPDesc:onLoaded(...)
self:bindComponents()
end


function tipsChildXMKCItemFPDesc:__delete()
self:unbindComponents()
end




function tipsChildXMKCItemFPDesc:onShow(argtable,afterOnloaded)
local data=argtable.argtable
local childType=argtable.childType
local nodeidx=argtable.nodeidx
local itemid=data.itemid
local attach=data.attach
local formType=data.formType

local cfg=cfg_guildconversionconfig_get(itemid)
if cfg then
local maxCnt=cfg.distribution_week_max or 9999
local curCnt=xianmengModel:getkfZHFPData_FPCnt(itemid)

local str=FMT.fmt("本周已分配：<color={0}>{1}/{2}</color>",curCnt>=maxCnt and"#F60202"or"#51F501",curCnt,maxCnt)
self.desc:setText(str)
else
self.tipsChildXMKCItemFPDesc:setActive(false)
end
end


function tipsChildXMKCItemFPDesc:onHide()

end


