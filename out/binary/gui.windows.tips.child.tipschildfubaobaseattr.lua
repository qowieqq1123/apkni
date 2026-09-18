







def_class("tipsChildFubaoBaseAttr",UICloneObject)





tipsChildFubaoBaseAttr.abName="ui/windows/tips/child/tipschildfubaobaseattr.ab"

tipsChildFubaoBaseAttr.assetName="tipsChildFubaoBaseAttr"


function tipsChildFubaoBaseAttr:bindComponents()

self.scrollview=UIObject.get(self,0)
self.title=UIText.get(self,1)

end


function tipsChildFubaoBaseAttr:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.scrollview);self.scrollview=nil;
_UIObject_release(self.title);self.title=nil;
end









function tipsChildFubaoBaseAttr:onLoaded(...)
self:bindComponents()
self.scrollview:setChildScrollViewInit(0,true,nil,nil)
end


function tipsChildFubaoBaseAttr:__delete()
self:unbindComponents()
end




function tipsChildFubaoBaseAttr:onShow(args)
local data=args.argtable
local childType=args.childType
local nodeidx=args.nodeidx
local itemid=data.itemid
local itemguid=data.itemguid

local fubao=equipsHelper.getEquip(itemguid)
local itemData=fubao.itemData

local list={}
if itemData.fix_attr_len>0 then
for k,v in pairs(itemData.fixAttrLst)do
local etype=FUBAO_EFFECT_TYPE.eBaseAttr
local stype=v.param_1
local value=v.param_2
local col,s1=self:getChangeArgs(etype,value)
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

function tipsChildFubaoBaseAttr:setAttrInfo(k,v)
if k==FUBAO_EFFECT_TYPE.eProfessionLevel or
k==FUBAO_EFFECT_TYPE.eSixAttr or
k==FUBAO_EFFECT_TYPE.eProfessionExp or
k==FUBAO_EFFECT_TYPE.eGongFaExpSpeed then
for kk,vv in pairs(v)do
local col,s1=self:getChangeArgs(k,vv)
local des,s2=self:getDesStr(k,kk)
return{col,des,s1,vv,s2}
end
else
local col,s1=self:getChangeArgs(k,v)
local des,s2=self:getDesStr(k)
return{col,des,s1,v,s2}
end
end

function tipsChildFubaoBaseAttr:getChangeArgs(etype,val)
if etype==FUBAO_EFFECT_TYPE.eBuildLevelUpMaterial or
etype==FUBAO_EFFECT_TYPE.eBuildLevelUpTime then
if val>0 then
return FONT_COLOR.eTipWhiteColor,''
else
return FONT_COLOR.eTipWhiteColor,'-'
end
else
if val>0 then
return FONT_COLOR.eTipWhiteColor,''
else
return FONT_COLOR.eTipWhiteColor,'-'
end
end
end

function tipsChildFubaoBaseAttr:getDesStr(etype,arg1)
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
return FMT.fmt('{0}经验获取效率',name),'%'
elseif etype==FUBAO_EFFECT_TYPE.eInjuryRecoverSpeed then
return'负伤值回复效率提升','%'
elseif etype==FUBAO_EFFECT_TYPE.eLianTiSpeed then
return'炼体获取效率提升','%'
elseif etype==FUBAO_EFFECT_TYPE.eXiuWeiSpeed then
return'修为获取效率提升','%'
end

return'???',''
end


function tipsChildFubaoBaseAttr:onHide()

end


