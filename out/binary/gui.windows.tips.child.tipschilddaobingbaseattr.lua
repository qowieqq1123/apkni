







def_class("tipsChildDaoBingBaseAttr",UICloneObject)





tipsChildDaoBingBaseAttr.abName="ui/windows/tips/child/tipschilddaobingbaseattr.ab"

tipsChildDaoBingBaseAttr.assetName="tipsChildDaoBingBaseAttr"


function tipsChildDaoBingBaseAttr:bindComponents()

self.attr1=UIObject.get(self,0)
self.attr2=UIObject.get(self,1)
self.attr3=UIObject.get(self,2)
self.attr4=UIObject.get(self,3)
self.attr5=UIObject.get(self,4)
self.line=UIObject.get(self,5)
self.title=UIText.get(self,6)

end


function tipsChildDaoBingBaseAttr:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.attr1);self.attr1=nil;
_UIObject_release(self.attr2);self.attr2=nil;
_UIObject_release(self.attr3);self.attr3=nil;
_UIObject_release(self.attr4);self.attr4=nil;
_UIObject_release(self.attr5);self.attr5=nil;
_UIObject_release(self.line);self.line=nil;
_UIObject_release(self.title);self.title=nil;
end








function tipsChildDaoBingBaseAttr:onLoaded(...)
self:bindComponents()
end

function tipsChildDaoBingBaseAttr:__delete()
self:unbindComponents()
end

function tipsChildDaoBingBaseAttr:onShow(args,afterOnloaded)
local data=args.argtable
local childType=args.childType
local nodeidx=args.nodeidx
local itemid=data.itemid
local itemguid=data.itemguid
local attach=data.attach
self.attach_starlv=attach.starlv
self.attach_jllv=attach.jllv
local itemConfig=itemsConfig.getConfig(itemid)

local equip=itemguid and equipsHelper.getEquip(itemguid)or nil
local starlv=daobingModel:getStarLv(equip)
if self.attach_starlv then starlv=self.attach_starlv end


local baseAttrList=daobingHelper.getBaseAttrsList(itemConfig)or{}
local jlbaseAttrList=daobingHelper.getJinglianBaseAttrsByEquip(equip)
if self.attach_jllv then
jlbaseAttrList=daobingHelper.getJinglianBaseAttrs(itemid,self.attach_jllv)
end
local jlBaseAttrsLookup=attrListHelper.tramsformToLookup(jlbaseAttrList)


local jlBaseAttrsAddLookup
if self.attach_jllv then
jlBaseAttrsAddLookup=daobingHelper.getJinglianAddPercentBaseAttrs(itemid,self.attach_starlv,self.attach_jllv)or{}
elseif equip then
jlBaseAttrsAddLookup=daobingHelper.getJinglianAddPercentBaseAttrsByEquip(equip)or{}
else
jlBaseAttrsAddLookup={}
end


local starBaseAttrsList=daobingHelper.getStarBaseAttrs(itemid,starlv)or{}
local starBaseAttrsLookup=attrListHelper.tramsformToLookup(starBaseAttrsList)


local starBaseAttrsAddLookup=equip and daobingHelper.getStarAddPercentBaseAttrsByEquip(equip)or{}
if self.attach_starlv then
starBaseAttrsAddLookup=daobingHelper.getStarAddPercentBaseAttrs(itemid,self.attach_starlv,self.attach_jllv)
end

local wltAttr=wanLingTaModel:getWanLingTaDaoBingSpeAttrsLookup()
for i=1,5 do
local attrInfo=baseAttrList[i]
if attrInfo then
local attrType=attrInfo[1]
local baseVal=attrInfo[2]+
(jlBaseAttrsLookup[attrType]or 0)+
(starBaseAttrsLookup[attrType]or 0)
local jlVal=jlBaseAttrsAddLookup[attrType]or 0
local starVal=starBaseAttrsAddLookup[attrType]or 0
local addVal=jlVal+starVal
if wltAttr[attrType]then
local wltPercent=wltAttr[attrType]
baseVal=math.floor(baseVal*(1+wltPercent/100))
addVal=math.floor(addVal*(1+wltPercent/100))
end

self:setAttr(i,attrType,baseVal,addVal)
else
self:setAttr(i)
end
end

self.line:setActive(not self:isLastItem())
end

function tipsChildDaoBingBaseAttr:onHide()

end



function tipsChildDaoBingBaseAttr:setAttr(idx,attrType,attrValue,add)
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

function tipsChildDaoBingBaseAttr:onRecycle()
self.line:setActive(not self:isLastItem())
end
