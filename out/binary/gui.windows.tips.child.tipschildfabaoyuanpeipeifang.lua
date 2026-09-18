







def_class("tipsChildFabaoYuanPeiPeiFang",UICloneObject)





tipsChildFabaoYuanPeiPeiFang.abName="ui/windows/tips/child/tipschildfabaoyuanpeipeifang.ab"

tipsChildFabaoYuanPeiPeiFang.assetName="tipsChildFabaoYuanPeiPeiFang"


function tipsChildFabaoYuanPeiPeiFang:bindComponents()

self.title=UIText.get(self,0)
self.itemSlot_1=UIObject.get(self,1)
self.itemSlot_2=UIObject.get(self,2)
self.itemSlot_3=UIObject.get(self,3)
self.itemSlot={
self.itemSlot_1,
self.itemSlot_2,
self.itemSlot_3,
}

end


function tipsChildFabaoYuanPeiPeiFang:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.title);self.title=nil;
_UIObject_release(self.itemSlot_1);self.itemSlot_1=nil;
_UIObject_release(self.itemSlot_2);self.itemSlot_2=nil;
_UIObject_release(self.itemSlot_3);self.itemSlot_3=nil;
self.itemSlot=nil;
end








function tipsChildFabaoYuanPeiPeiFang:onLoaded(...)
self:bindComponents()
end

function tipsChildFabaoYuanPeiPeiFang:__delete()
self:unbindComponents()
end

function tipsChildFabaoYuanPeiPeiFang:onShow(args,afterOnloaded)
local data=args.argtable
local childType=args.childType
local nodeidx=args.nodeidx
local itemid=data.itemid
local itemguid=data.itemguid
local attach=data.attach
local diziguid=attach.diziguid
self.diziguid=diziguid
self.itemid=itemid
self.formType=data.formType
local itemConfig=itemsConfig.getConfig(itemid)
self.itemguid=itemguid

local item=equipsHelper.getEquip(itemguid)or{}
local itemData=item.itemData
if not itemData or not next(itemData)then
self:recycleSelf()
return
end

local fbtypeList=itemData.fbtypeList
local color=itemConfig.color

for i,v in ipairs(self.itemSlot)do
local widget=v:getWidgetBase()
local fbtype=fbtypeList[i]
local cfg=cfg_fabaoyuanpeitypeconfig_get(fbtype)
local iconname=iconHelper.getFaBaoTypeIcon(cfg.icon)
widget:SetChildQulaity(0,color)
widget:SetChildIcon(1,iconname,false)
widget:SetChildText(2,cfg.name)

widget:SetChildButtonClick(4,function()
UIManager:showWindow('UIFabaoYuanPeiMetrialWin',{type=fbtype,color=color})
end,true)
end
end

function tipsChildFabaoYuanPeiPeiFang:onHide()

end


