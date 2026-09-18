







def_class("tipsChildFabaoBaseAttr",UICloneObject)





tipsChildFabaoBaseAttr.abName="ui/windows/tips/child/tipschildfabaobaseattr.ab"

tipsChildFabaoBaseAttr.assetName="tipsChildFabaoBaseAttr"


function tipsChildFabaoBaseAttr:bindComponents()

self.line=UIObject.get(self,0)
self.title=UIText.get(self,1)
self.creater=UIObject.get(self,2)

end


function tipsChildFabaoBaseAttr:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.line);self.line=nil;
_UIObject_release(self.title);self.title=nil;
_UIObject_release(self.creater);self.creater=nil;
end





function tipsChildFabaoBaseAttr:onLoaded()
self:bindComponents()
end

function tipsChildFabaoBaseAttr:__delete()
self:unbindComponents()
end

function tipsChildFabaoBaseAttr:onShow(args)
local data=args.argtable
local childType=args.childType
local nodeidx=args.nodeidx
local itemid=data.itemid
local itemguid=data.itemguid
local attach=data.attach
local itemCfg=itemsConfig.getConfig(itemid)
local item=equipsHelper.getEquip(itemguid)
local isCfg=equipsHelper.isCfgEquip(itemguid)
local attrList=isCfg and fabaoHelper.getBaseAttrsListByCfg(itemCfg)or
fabaoHelper.getBaseAttrsList(item)or{}
local elementList=isCfg and fabaoHelper.getElementAttrsListByCfg(itemCfg)or
fabaoHelper.getElementAttrsList(item)or{}
local attrLen=#attrList
local elementLen=#elementList
local len=attrLen+elementLen
if len==0 then
self:recycleSelf()
return
end
self.line:setActive(not self:isLastItem())
local jilianlv=not isCfg and item.itemData and item.itemData.jilianlv or 0
local hasjilian=jilianlv>0


local jlPercentLookup=not isCfg and fabaoHelper.getJlBaseAttrsPercent(item)or{}


local czPrecentLookup=not isCfg and fabaoCizuiHelper.getAddFabaoBaseAttrsPercentLookup(item)or{}


local addlxBasePrecent=not isCfg and benMingFaBaoHelper.getAddBaseAttrPrecent(itemguid)or 0



local addjlAttrList=not isCfg and fabaoHelper.getAddJilianAttrs(item)or{}
local addjlAttrLookup=attrListHelper.tramsformToLookup(addjlAttrList)

local jlAttrPercent=not isCfg and fabaoHelper.getJlAddAttrsPercent(item)or 0

addjlAttrLookup=attrListHelper.getLookupOnPercent(addjlAttrLookup,jlAttrPercent,true)


local baselist={}
for i,v in ipairs(attrList)do
local attrType=v[1]
local attrValue=v[2]
local jl=jlPercentLookup[attrType]or 0
local cz=czPrecentLookup[attrType]or 0
local lx=addlxBasePrecent or 0
local val=mathHelper.floor(attrValue*(1+(jl+cz+lx)/100))
baselist[i]={attrType,val}
end

local jilianStr=hasjilian and FMT.fmt('（精炼{0}级）',jilianlv)or''
self.title:setText(FMT.fmt('{0}{1}',FMT.fmt('基础属性'),jilianStr))

local tlen=attrLen+elementLen
self.creater:setChildLayoutGroupCreateItems(tlen)
local grids=self.creater:getChildLayoutGroupGridList()

local index=attrLen
if attrLen>0 then
for i=1,attrLen do
local attr=baselist[i]
local attrId=attr[1]
local val=attr[2]
local add=addjlAttrLookup[attrId]or 0
local item=grids[i-1]
self:setAttr(item,attrId,val,add)
end
end

if elementLen>0 then
for i=1,elementLen do
index=index+1
local attr=elementList[i]
local item=grids[index-1]
self:setAttr(item,attr[1],attr[2])
end
end
end

function tipsChildFabaoBaseAttr:setAttr(item,attrType,attrValue,addValue)
addValue=addValue or 0
local name,valstr=equipsHelper.getAttr(attrType,attrValue)
local name,addvalstr=equipsHelper.getAttr(attrType,addValue)
local attrStr=FMT.fmt('{0}：{1}',name,valstr)
if string.find(name,'技能威力')then
name=string.replace(name,'提升','')
attrStr=FMT.fmt('{0}：{1}',name,valstr)
end
local addStr=addValue>0 and FMT.cfmt(eQualityColor.eGreen,'{0}',addvalstr)or''
item:SetChildText(0,attrStr)
item:SetChildActive(1,addValue>0)
if addValue>0 then
item:SetChildText(2,addvalstr)
end
end

function tipsChildFabaoBaseAttr:onRecycle()
self.line:setActive(not self:isLastItem())
end