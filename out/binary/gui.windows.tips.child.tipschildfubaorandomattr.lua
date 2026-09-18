







def_class("tipsChildFubaoRandomAttr",UICloneObject)





tipsChildFubaoRandomAttr.abName="ui/windows/tips/child/tipschildfubaorandomattr.ab"

tipsChildFubaoRandomAttr.assetName="tipsChildFubaoRandomAttr"


function tipsChildFubaoRandomAttr:bindComponents()

self.scrollview=UIObject.get(self,0)
self.title=UIText.get(self,1)

end


function tipsChildFubaoRandomAttr:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.scrollview);self.scrollview=nil;
_UIObject_release(self.title);self.title=nil;
end









function tipsChildFubaoRandomAttr:onLoaded(...)
self:bindComponents()
self.scrollview:setChildScrollViewInit(0,true,nil,nil)

self.attr_color=cfgHelper.get2(cfg_fubaofangbasicconfig_get,1,'attr_color')
end


function tipsChildFubaoRandomAttr:__delete()
self:unbindComponents()
end




function tipsChildFubaoRandomAttr:onShow(args)
local data=args.argtable
local childType=args.childType
local nodeidx=args.nodeidx
local itemid=data.itemid
local itemguid=data.itemguid

local fubao=equipsHelper.getEquip(itemguid)
if fubao==nil or fubao.itemData==nil then
self:recycleSelf()
return
end

local itemData=fubao.itemData or{}
if itemData.random_attr_len==nil or itemData.random_attr_len<=0 then
self:recycleSelf()
return
end

local list={}
if itemData.random_attr_len>0 then
for k,v in pairs(itemData.randomAttrList)do
local etype=v.param_3
local stype=v.param_1
local value=v.param_2

if etype==FUBAO_EFFECT_TYPE.eProfessionExp or etype==FUBAO_EFFECT_TYPE.eGongFaExpSpeed then
value=value/100
end
local col,s1=self:getChangeArgs(etype,stype,value)
local des,s2=self:getDesStr(etype,stype)
table.insert(list,{col,des,s1,value,s2})
end
end

self.scrollview:setChildScrollViewCreateGrids(#list,0)
local grids=self.scrollview:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local item=grids[i-1]
local d=list[i]
item:SetChildText(0,FMT.fmt('{0}：{1}',d[2],FMT.cfmt(d[1],'{0}{1}{2}',d[3],d[4],d[5])))
end
end

function tipsChildFubaoRandomAttr:getChangeArgs(etype,stype,val)





return self:getAttrColor(etype,stype,val),'+'
end

function tipsChildFubaoRandomAttr:getDesStr(etype,arg1)

if etype==FUBAO_EFFECT_TYPE.eBaseAttr then
local name=helper.getAttributeName(arg1)
return name,''
elseif etype==FUBAO_EFFECT_TYPE.eProfessionLevel then
local cfg=cfgHelper.get1(cfg_discipleproskillconfig_get,arg1)
return FMT.fmt('{0}等级',cfg.name),''
elseif etype==FUBAO_EFFECT_TYPE.eSixAttr then
local name=UIDiscipleModel:discipleBaseAttrName(arg1)
return name,''
elseif etype==FUBAO_EFFECT_TYPE.eProfessionExp then
local cfg=cfgHelper.get1(cfg_discipleproskillconfig_get,arg1)
return FMT.fmt('{0}经验',cfg.name),'%'
elseif etype==FUBAO_EFFECT_TYPE.eBuildLevelUpMaterial then
return'建筑升级所需资源','%'
elseif etype==FUBAO_EFFECT_TYPE.eBuildLevelUpTime then
return'建筑升级所需时间','%'
elseif etype==FUBAO_EFFECT_TYPE.eGongFaExpSpeed then

local name=ELEMENT_TYPE.getNameGF(arg1)
return FMT.fmt('{0}经验',name),'%'
elseif etype==FUBAO_EFFECT_TYPE.eInjuryRecoverSpeed then
return'负伤值回复效率提升','%'
elseif etype==FUBAO_EFFECT_TYPE.eLianTiSpeed then
return'炼体获取效率提升','%'
elseif etype==FUBAO_EFFECT_TYPE.eXiuWeiSpeed then
return'修为获取效率提升','%'
end

return'???',''
end

function tipsChildFubaoRandomAttr:getAttrColor(attrType,attrId,attrValue)
local data1=self.attr_color[attrType]
if data1 then
local data2=data1[attrId]
if data2 then
for i,v in ipairs(data2)do
if attrValue>=v[1]and attrValue<=v[2]then
return i
end
end
end
end
return FONT_COLOR.eTipWhiteColor
end


function tipsChildFubaoRandomAttr:onHide()

end


