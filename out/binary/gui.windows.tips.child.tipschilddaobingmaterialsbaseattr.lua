







def_class("tipsChildDaoBingMaterialsBaseAttr",UICloneObject)





tipsChildDaoBingMaterialsBaseAttr.abName="ui/windows/tips/child/tipschilddaobingmaterialsbaseattr.ab"

tipsChildDaoBingMaterialsBaseAttr.assetName="tipsChildDaoBingMaterialsBaseAttr"


function tipsChildDaoBingMaterialsBaseAttr:bindComponents()

self.attr1=UIObject.get(self,0)
self.attr2=UIObject.get(self,1)
self.attr3=UIObject.get(self,2)
self.attr4=UIObject.get(self,3)
self.attr5=UIObject.get(self,4)
self.line=UIObject.get(self,5)
self.title=UIText.get(self,6)

end


function tipsChildDaoBingMaterialsBaseAttr:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.attr1);self.attr1=nil;
_UIObject_release(self.attr2);self.attr2=nil;
_UIObject_release(self.attr3);self.attr3=nil;
_UIObject_release(self.attr4);self.attr4=nil;
_UIObject_release(self.attr5);self.attr5=nil;
_UIObject_release(self.line);self.line=nil;
_UIObject_release(self.title);self.title=nil;
end








function tipsChildDaoBingMaterialsBaseAttr:onLoaded(...)
self:bindComponents()
end

function tipsChildDaoBingMaterialsBaseAttr:__delete()
self:unbindComponents()
end

function tipsChildDaoBingMaterialsBaseAttr:onShow(args,afterOnloaded)
local data=args.argtable
local childType=args.childType
local nodeidx=args.nodeidx

local oitemid=data.itemid
local oitemCfg=itemsConfig.getConfig(oitemid)
local piece=oitemCfg.piece
local need=piece[2]
local itemid=piece[1]

local itemCfg=itemsConfig.getConfig(itemid)


local baseAttrList=daobingHelper.getBaseAttrsList(itemCfg)or{}


for i=1,5 do
local attrInfo=baseAttrList[i]
if attrInfo then
local attrType=attrInfo[1]
local baseVal=attrInfo[2]
self:setAttr(i,attrType,baseVal,0)
else
self:setAttr(i)
end
end

self.line:setActive(not self:isLastItem())
end

function tipsChildDaoBingMaterialsBaseAttr:onHide()

end



function tipsChildDaoBingMaterialsBaseAttr:setAttr(idx,attrType,attrValue,add)
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

function tipsChildDaoBingMaterialsBaseAttr:onRecycle()
self.line:setActive(not self:isLastItem())
end