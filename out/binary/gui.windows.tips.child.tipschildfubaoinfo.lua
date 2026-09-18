







def_class("tipsChildFubaoInfo",UICloneObject)





tipsChildFubaoInfo.abName="ui/windows/tips/child/tipschildfubaoinfo.ab"

tipsChildFubaoInfo.assetName="tipsChildFubaoInfo"


function tipsChildFubaoInfo:bindComponents()

self.name=UIText.get(self,0)
self.type=UIText.get(self,1)
self.item=UIObject.get(self,2)
self.lock=UIObject.get(self,3)

end


function tipsChildFubaoInfo:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.name);self.name=nil;
_UIObject_release(self.type);self.type=nil;
_UIObject_release(self.item);self.item=nil;
_UIObject_release(self.lock);self.lock=nil;
end









function tipsChildFubaoInfo:onLoaded(...)
self:bindComponents()
end


function tipsChildFubaoInfo:__delete()
self:unbindComponents()
end




function tipsChildFubaoInfo:onShow(argtable,afterOnloaded)
local data=argtable.argtable
local childType=argtable.childType
local nodeidx=argtable.nodeidx

local itemid=data.itemid
local itemguid=data.itemguid
local attach=data.attach
self.diziguid=attach.diziguid

local itemConfig=itemsConfig.getConfig(itemid)
self:fillInfo(itemid,itemguid,itemConfig)
end


function tipsChildFubaoInfo:onHide()

end




function tipsChildFubaoInfo:fillInfo(itemid,itemguid,itemConfig)
self.name:setText(itemConfig.name)
self.type:setText('符宝')

local fubao=equipsHelper.getEquip(itemguid)
self.lock:setActive(fubao.itemData.lock_flag~=0)

local item=self.item:getChildWidgetBase()
widgetHelper.setNormalRewardItem(item,0,{itemid,0})
end