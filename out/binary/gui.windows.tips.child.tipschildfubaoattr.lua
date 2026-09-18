







def_class("tipsChildFuBaoAttr",UICloneObject)





tipsChildFuBaoAttr.abName="ui/windows/tips/child/tipschildfubaoattr.ab"

tipsChildFuBaoAttr.assetName="tipsChildFuBaoAttr"


function tipsChildFuBaoAttr:bindComponents()

self.title=UIText.get(self,0)
self.scrollview=UIObject.get(self,1)

end


function tipsChildFuBaoAttr:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.title);self.title=nil;
_UIObject_release(self.scrollview);self.scrollview=nil;
end









function tipsChildFuBaoAttr:onLoaded(...)
self:bindComponents()

self.scrollview:setChildScrollViewInit(0.5,true,nil,nil)
end


function tipsChildFuBaoAttr:__delete()
self:unbindComponents()
end




function tipsChildFuBaoAttr:onShow(argtable,afterOnloaded)
local data=argtable.argtable
local itemid=data.itemid
local attrs=UIFuLuFangModel:getFuBaoEffectList(itemid)
local list={}

for k,v in pairs(attrs)do
local d=self:setAttrInfo(k,v)
table.insert(list,d)

end
local guid=data.itemguid
local fubao=equipsHelper.getEquip(guid)
local itemData=fubao.itemData
if itemData.random_attr_len>0 then
for k,v in pairs(itemData.randomAttrList)do
local etype=v.param_3
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
item:SetChildText(0,FMT.fmt('{0}{1}',d[2],FMT.cfmt(d[1],'{0}{1}{2}',d[3],d[4],d[5])))
end
end

function tipsChildFuBaoAttr:setAttrInfo(k,v)
if k==FUBAO_EFFECT_TYPE.eProfessionLevel or
k==FUBAO_EFFECT_TYPE.eSixAttr or
k==FUBAO_EFFECT_TYPE.eProfessionExp then
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

function tipsChildFuBaoAttr:getChangeArgs(etype,val)
if etype==FUBAO_EFFECT_TYPE.eBuildLevelUpMaterial or
etype==FUBAO_EFFECT_TYPE.eBuildLevelUpTime then
if val>0 then
return FONT_COLOR.eRedColor,'+'
else
return FONT_COLOR.eGreenColor,'-'
end
else
if val>0 then
return FONT_COLOR.eGreenColor,'+'
else
return FONT_COLOR.eRedColor,'-'
end
end
end

function tipsChildFuBaoAttr:getDesStr(etype,arg1)
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
end
end








function tipsChildFuBaoAttr:onHide()

end


