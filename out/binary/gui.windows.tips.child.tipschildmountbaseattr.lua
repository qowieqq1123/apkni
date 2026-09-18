







def_class("tipsChildMountBaseAttr",UICloneObject)





tipsChildMountBaseAttr.abName="ui/windows/tips/child/tipschildmountbaseattr.ab"

tipsChildMountBaseAttr.assetName="tipsChildMountBaseAttr"


function tipsChildMountBaseAttr:bindComponents()

self.attrs_1=UIObject.get(self,0)
self.attrs_2=UIObject.get(self,1)
self.attrs_3=UIObject.get(self,2)
self.attrs_4=UIObject.get(self,3)
self.attrs_5=UIObject.get(self,4)
self.line=UIObject.get(self,5)
self.title=UIText.get(self,6)
self.attrs={
self.attrs_1,
self.attrs_2,
self.attrs_3,
self.attrs_4,
self.attrs_5,
}

end


function tipsChildMountBaseAttr:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.attrs_1);self.attrs_1=nil;
_UIObject_release(self.attrs_2);self.attrs_2=nil;
_UIObject_release(self.attrs_3);self.attrs_3=nil;
_UIObject_release(self.attrs_4);self.attrs_4=nil;
_UIObject_release(self.attrs_5);self.attrs_5=nil;
_UIObject_release(self.line);self.line=nil;
_UIObject_release(self.title);self.title=nil;
self.attrs=nil;
end








function tipsChildMountBaseAttr:onLoaded(...)
self:bindComponents()
end

function tipsChildMountBaseAttr:__delete()
self:unbindComponents()
end

function tipsChildMountBaseAttr:onShow(args,afterOnloaded)
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
self.isCompareTips=data.isCompareTips
local itemCfg=itemsConfig.getConfig(itemid)
self.itemguid=itemguid

local attrlist=mountHelper.getBaseAttrsList(itemCfg)
local len=#attrlist
for i,v in ipairs(attrlist)do
local name,valstr=equipsHelper.getAttr(v[1],v[2])
self.attrs[i]:setActive(true)
local widget=self.attrs[i]:getWidgetBase()
widget:SetChildText(0,FMT.fmt('{0}：{1}',name,valstr))
end
for i=len+1,5 do
self.attrs[i]:setActive(false)
end
self.line:setActive(not self:isLastItem())
end

function tipsChildMountBaseAttr:onHide()

end




function tipsChildMountBaseAttr:onRecycle()
self.line:setActive(not self:isLastItem())
end