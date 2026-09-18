







def_class("tipsChildEquipFixRandomAttr",UICloneObject)





tipsChildEquipFixRandomAttr.abName="ui/windows/tips/child/tipschildequipfixrandomattr.ab"

tipsChildEquipFixRandomAttr.assetName="tipsChildEquipFixRandomAttr"


function tipsChildEquipFixRandomAttr:bindComponents()

self.attrRoot1=UIObject.get(self,0)
self.attrRoot2=UIObject.get(self,1)
self.attrRoot3=UIObject.get(self,2)
self.attrRoot4=UIObject.get(self,3)
self.attrRoot5=UIObject.get(self,4)
self.line=UIObject.get(self,5)
self.title=UIText.get(self,6)
self.attr1=UIText.get(self,7)
self.attr2=UIText.get(self,8)
self.attr3=UIText.get(self,9)
self.attr4=UIText.get(self,10)
self.attr5=UIText.get(self,11)

end


function tipsChildEquipFixRandomAttr:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.attrRoot1);self.attrRoot1=nil;
_UIObject_release(self.attrRoot2);self.attrRoot2=nil;
_UIObject_release(self.attrRoot3);self.attrRoot3=nil;
_UIObject_release(self.attrRoot4);self.attrRoot4=nil;
_UIObject_release(self.attrRoot5);self.attrRoot5=nil;
_UIObject_release(self.line);self.line=nil;
_UIObject_release(self.title);self.title=nil;
_UIObject_release(self.attr1);self.attr1=nil;
_UIObject_release(self.attr2);self.attr2=nil;
_UIObject_release(self.attr3);self.attr3=nil;
_UIObject_release(self.attr4);self.attr4=nil;
_UIObject_release(self.attr5);self.attr5=nil;
end








function tipsChildEquipFixRandomAttr:onLoaded(...)
self:bindComponents()
end

function tipsChildEquipFixRandomAttr:__delete()
self:unbindComponents()
end

function tipsChildEquipFixRandomAttr:onShow(args,afterOnloaded)
local data=args.argtable
local childType=args.childType
local nodeidx=args.nodeidx
local itemid=data.itemid
local itemCfg=itemsConfig.getConfig(itemid)

local randattrList=itemCfg.fix[0].randattr
if randattrList==nil then
self:recycleSelf()
return
end
for i,v in ipairs(randattrList)do
local name,valstr=equipsHelper.getAttr(v[1],v[2])
self[FMT.fmt('attr{0}',i)]:setText(FMT.fmt('{0}：+{1}',name,valstr))
self[FMT.fmt('attrRoot{0}',i)]:setActive(true)
end
for i=#randattrList+1,5 do
self[FMT.fmt('attrRoot{0}',i)]:setActive(false)
end
self.line:setActive(not self:isLastItem())
end

function tipsChildEquipFixRandomAttr:onHide()

end



function tipsChildEquipFixRandomAttr:onRecycle()
self.line:setActive(not self:isLastItem())
end