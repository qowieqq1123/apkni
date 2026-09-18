







def_class("tipsChildClothingSixAttr",UICloneObject)





tipsChildClothingSixAttr.abName="ui/windows/tips/child/tipschildclothingsixattr.ab"

tipsChildClothingSixAttr.assetName="tipsChildClothingSixAttr"


function tipsChildClothingSixAttr:bindComponents()

self.attr1=UIObject.get(self,0)
self.attr2=UIObject.get(self,1)
self.attr3=UIObject.get(self,2)
self.attr4=UIObject.get(self,3)
self.attr5=UIObject.get(self,4)
self.attr6=UIObject.get(self,5)
self.line=UIObject.get(self,6)
self.title=UIText.get(self,7)

end


function tipsChildClothingSixAttr:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.attr1);self.attr1=nil;
_UIObject_release(self.attr2);self.attr2=nil;
_UIObject_release(self.attr3);self.attr3=nil;
_UIObject_release(self.attr4);self.attr4=nil;
_UIObject_release(self.attr5);self.attr5=nil;
_UIObject_release(self.attr6);self.attr6=nil;
_UIObject_release(self.line);self.line=nil;
_UIObject_release(self.title);self.title=nil;
end








function tipsChildClothingSixAttr:onLoaded(...)
self:bindComponents()
end

function tipsChildClothingSixAttr:__delete()
self:unbindComponents()
end

function tipsChildClothingSixAttr:onShow(args,afterOnloaded)
local data=args.argtable
local childType=args.childType
local nodeidx=args.nodeidx
local itemid=data.itemid
local itemguid=data.itemguid
local attach=data.attach
self.attach_starlv=attach.starlv

local itemConfig=itemsConfig.getConfig(itemid)

local equip=itemguid and equipsHelper.getEquip(itemguid)or nil
local starlv=ClothingModel:getStarLv(itemguid)
if self.attach_starlv then starlv=self.attach_starlv end


local diziAttrList=ClothingHelper.getDiziAttrsList(itemConfig)or{}
local baseAttr,diziAttr=ClothingHelper.getStarBaseAttrs(itemid,starlv,true)
local diziAttrsLookup=attrListHelper.tramsformToLookup(diziAttr)


for i=1,6 do
local diziattrInfo=diziAttrList[i]
if diziattrInfo then
local attrType=diziattrInfo[1]
local baseVal=diziattrInfo[2]

local starVal=diziAttrsLookup[attrType]or 0

self:setAttr(i,attrType,starVal,0)
else
self:setAttr(i)
end
end

self.line:setActive(not self:isLastItem())
end


function tipsChildClothingSixAttr:onHide()

end

function tipsChildClothingSixAttr:setAttr(idx,attrType,attrValue,add)
local widget=self[FMT.fmt('attr{0}',idx)]:getChildWidgetBase()
if attrType==nil then
widget:SetChildActive(-1,false)
return
end
widget:SetChildActive(-1,true)
local name,str=equipsHelper.getDiziAttr(attrType,attrValue)
local name,addStr=equipsHelper.getDiziAttr(attrType,add)
local hasAdd=add>0
local attrStr=FMT.fmt('{0}+{1}',name or'',str)
widget:SetChildText(0,attrStr)
widget:SetChildActive(1,hasAdd)
if hasAdd then
widget:SetChildActive(2,true)
widget:SetChildText(3,addStr)
end
end

function tipsChildClothingSixAttr:onRecycle()
self.line:setActive(not self:isLastItem())
end
