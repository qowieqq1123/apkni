







def_class("tipsChildXMFXZYCondition",UICloneObject)





tipsChildXMFXZYCondition.abName="ui/windows/tips/child/tipschildxmfxzycondition.ab"

tipsChildXMFXZYCondition.assetName="tipsChildXMFXZYCondition"


function tipsChildXMFXZYCondition:bindComponents()

self.root=UIObject.get(self,0)
self.tips=UIText.get(self,1)

end


function tipsChildXMFXZYCondition:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.tips);self.tips=nil;
end









function tipsChildXMFXZYCondition:onLoaded(...)
self:bindComponents()
end


function tipsChildXMFXZYCondition:__delete()
self:unbindComponents()
end




function tipsChildXMFXZYCondition:onShow(args,afterOnloaded)
local data=args.argtable
local itemid=data.itemid
local config=cfgHelper.get1(cfg_guildaskforconfig_get,itemid)
local tipsStr=nil
if config and config.condition then
tipsStr=xianmengModel:getConditionTipsList_fenxiangziyuan(config.condition)
if tipsStr then
self.tips:setText(tipsStr)
return
end
end

local cur=xianmengModel:getSeekTimes_fenxiangziyuan()
local max=cfgHelper.get2(cfg_guildbaseconfig_get,1,"askfor")
if cur>=max then
local owners=xianmengModel:getShareOwnerSort_fenxiangziyuan()
if#owners>0 then
tipsStr=FMT.cfmt(FONT_COLOR.eRedColor,"当前发布求助数已达上限")
end
end

if config then
local find=xianmengModel:findOwnerDataSameTypeData_fenxiangziyuan(data.itemid)
if find then
tipsStr=FMT.cfmt(FONT_COLOR.eRedColor,"本周已求助{0}",config.aftypeName)
end
end
self.tips:setText(tipsStr or"")
end


function tipsChildXMFXZYCondition:onHide()

end


