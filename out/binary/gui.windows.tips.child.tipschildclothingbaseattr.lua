







def_class("tipsChildClothingBaseAttr",UICloneObject)





tipsChildClothingBaseAttr.abName="ui/windows/tips/child/tipschildclothingbaseattr.ab"

tipsChildClothingBaseAttr.assetName="tipsChildClothingBaseAttr"


function tipsChildClothingBaseAttr:bindComponents()

self.attr1=UIObject.get(self,0)
self.attr2=UIObject.get(self,1)
self.attr3=UIObject.get(self,2)
self.attr4=UIObject.get(self,3)
self.attr5=UIObject.get(self,4)
self.attr6=UIObject.get(self,5)
self.attr7=UIObject.get(self,6)
self.attr8=UIObject.get(self,7)
self.attr9=UIObject.get(self,8)
self.attr10=UIObject.get(self,9)
self.attr11=UIObject.get(self,10)
self.attr12=UIObject.get(self,11)
self.line=UIObject.get(self,12)
self.title=UIText.get(self,13)

end


function tipsChildClothingBaseAttr:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.attr1);self.attr1=nil;
_UIObject_release(self.attr2);self.attr2=nil;
_UIObject_release(self.attr3);self.attr3=nil;
_UIObject_release(self.attr4);self.attr4=nil;
_UIObject_release(self.attr5);self.attr5=nil;
_UIObject_release(self.attr6);self.attr6=nil;
_UIObject_release(self.attr7);self.attr7=nil;
_UIObject_release(self.attr8);self.attr8=nil;
_UIObject_release(self.attr9);self.attr9=nil;
_UIObject_release(self.attr10);self.attr10=nil;
_UIObject_release(self.attr11);self.attr11=nil;
_UIObject_release(self.attr12);self.attr12=nil;
_UIObject_release(self.line);self.line=nil;
_UIObject_release(self.title);self.title=nil;
end









function tipsChildClothingBaseAttr:onLoaded(...)
self:bindComponents()
end


function tipsChildClothingBaseAttr:__delete()
self:unbindComponents()
end




function tipsChildClothingBaseAttr:onShow(args,afterOnloaded)
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


local baseAttrList=ClothingHelper.getBaseAttrsList(itemConfig)or{}
local baseAttr=ClothingHelper.getStarBaseAttrs(itemid,starlv,true)
local starAttrsLookup=attrListHelper.tramsformToLookup(baseAttr)


for i=1,12 do
local attrInfo=baseAttrList[i]
if attrInfo then
local attrType=attrInfo[1]
local baseVal=attrInfo[2]

local starVal=starAttrsLookup[attrType]or 0

self:setAttr(i,attrType,starVal,0)
else
self:setAttr(i)
end
end

self.line:setActive(not self:isLastItem())
end


function tipsChildClothingBaseAttr:onHide()

end

function tipsChildClothingBaseAttr:setAttr(idx,attrType,attrValue,add)
local widget=self[FMT.fmt('attr{0}',idx)]:getChildWidgetBase()
if attrType==nil then
widget:SetChildActive(-1,false)
return
end
widget:SetChildActive(-1,true)
local name,str=equipsHelper.getAttr(attrType,attrValue)
local name,addStr=equipsHelper.getAttr(attrType,add)
local hasAdd=add>0
local attrStr=FMT.fmt('{0}：{1}',name,str)
widget:SetChildText(0,attrStr)
widget:SetChildActive(1,hasAdd)
if hasAdd then
widget:SetChildActive(2,true)
widget:SetChildText(3,addStr)
end
end

function tipsChildClothingBaseAttr:onRecycle()
self.line:setActive(not self:isLastItem())
end


