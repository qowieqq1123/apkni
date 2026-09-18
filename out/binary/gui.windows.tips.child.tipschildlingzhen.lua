







def_class("tipsChildLingZhen",UICloneObject)





tipsChildLingZhen.abName="ui/windows/tips/child/tipschildlingzhen.ab"

tipsChildLingZhen.assetName="tipsChildLingZhen"


function tipsChildLingZhen:bindComponents()

self.name=UIText.get(self,0)
self.typename=UIText.get(self,1)
self.level=UIText.get(self,2)
self.icon=UIImage.get(self,3)
self.lock=UIObject.get(self,4)

end


function tipsChildLingZhen:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.name);self.name=nil;
_UIObject_release(self.typename);self.typename=nil;
_UIObject_release(self.level);self.level=nil;
_UIObject_release(self.icon);self.icon=nil;
_UIObject_release(self.lock);self.lock=nil;
end









function tipsChildLingZhen:onLoaded(...)
self:bindComponents()
end


function tipsChildLingZhen:__delete()
self:unbindComponents()
end




function tipsChildLingZhen:onShow(argtable,afterOnloaded)
local argData=argtable.argtable
local itemid=argData.itemid
local itemguid=argData.itemguid
local attach=argData.attach

local yfguid=attach.yfguid
local kongIndex=attach.kongIndex

local cfg=itemsConfig.getConfig(itemid)
local prefix={'金','木','水','火','土','极'}
local pr=prefix[cfg.type1]
local name=FMT.fmt('[{0}]{1}',pr,cfg.name)

local level=attach.level
if not level then
level=UIYuFuLingZhenControl:getItemLevel(itemid)

end

self.name:setText(name)
self.typename:setText('类型：灵阵')
self.level:setText(FMT.fmt('级数：{0}',level))
self.icon:setChildIcon(iconHelper.getIconName(itemid),true)

self.lock:setActive(UIYuFuLingZhenControl:getItemLock(itemguid,yfguid,kongIndex))
end


function tipsChildLingZhen:onHide()

end


