







def_class("tipsChildYunZhouBaseAttr",UICloneObject)





tipsChildYunZhouBaseAttr.abName="ui/windows/tips/child/tipschildyunzhoubaseattr.ab"

tipsChildYunZhouBaseAttr.assetName="tipsChildYunZhouBaseAttr"


function tipsChildYunZhouBaseAttr:bindComponents()

self.attr1=UIText.get(self,0)
self.attr2=UIText.get(self,1)
self.attr3=UIText.get(self,2)
self.attr4=UIText.get(self,3)
self.attr5=UIText.get(self,4)
self.attrRoot1=UIObject.get(self,5)
self.attrRoot2=UIObject.get(self,6)
self.attrRoot3=UIObject.get(self,7)
self.attrRoot4=UIObject.get(self,8)
self.attrRoot5=UIObject.get(self,9)
self.line=UIObject.get(self,10)
self.title=UIText.get(self,11)

end


function tipsChildYunZhouBaseAttr:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.attr1);self.attr1=nil;
_UIObject_release(self.attr2);self.attr2=nil;
_UIObject_release(self.attr3);self.attr3=nil;
_UIObject_release(self.attr4);self.attr4=nil;
_UIObject_release(self.attr5);self.attr5=nil;
_UIObject_release(self.attrRoot1);self.attrRoot1=nil;
_UIObject_release(self.attrRoot2);self.attrRoot2=nil;
_UIObject_release(self.attrRoot3);self.attrRoot3=nil;
_UIObject_release(self.attrRoot4);self.attrRoot4=nil;
_UIObject_release(self.attrRoot5);self.attrRoot5=nil;
_UIObject_release(self.line);self.line=nil;
_UIObject_release(self.title);self.title=nil;
end









function tipsChildYunZhouBaseAttr:onLoaded(...)
self:bindComponents()
end


function tipsChildYunZhouBaseAttr:__delete()
self:unbindComponents()
end




function tipsChildYunZhouBaseAttr:onShow(argtable,afterOnloaded)
local data=argtable.argtable
local childType=argtable.childType
local nodeidx=argtable.nodeidx
local itemid=data.itemid
local itemguid=data.itemguid
local attach=data.attach
local boatid=attach.yzId
local pos=attach.pos

local item
if boatid and boatid>0 then
item=XianYunGangModel:getYunZhouComponentsPosData(boatid,pos)
else
item=bagModel.getItem(itemguid)
end
local otherData=item~=nil and item.itemData or{}
local strengthLv=otherData.jinglianlv or 0
local attrLookup=yunZhouEquipsConfig.getStrengthenBaseAttrs(itemid,strengthLv)
local baseAttr={}
for attrType,attrValue in pairs(attrLookup)do
table.insert(baseAttr,{attrType,attrValue})
end
for i,v in ipairs(baseAttr)do
local name,valstr=equipsHelper.getAttr(v[1],v[2])
local yzAttrName=yunZhouEquipsConfig.getYunZhouSpecialAttrName(v[1])
if yzAttrName then
name=yzAttrName
end
self[FMT.fmt('attr{0}',i)]:setText(FMT.fmt('{0}：{1}',name,valstr))
self[FMT.fmt('attrRoot{0}',i)]:setActive(true)
end
for i=#baseAttr+1,5 do
self[FMT.fmt('attrRoot{0}',i)]:setActive(false)
end

self.line:setActive(not self:isLastItem())
end

function tipsChildYunZhouBaseAttr:onRecycle()
self.line:setActive(not self:isLastItem())
end