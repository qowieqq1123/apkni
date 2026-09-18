local attrDatas={}
local _lookupAttr={}
local _lookupAttach={}


function xianjieModel:clearJZAttribute()
attrDatas={}
_lookupAttr={}
_lookupAttach={}
end




SYSTEM_ATTRIBUTE_TYPE={
aYanDaoTai=1,
aGuBao=2,
aZMBuff=3,
aXJBuff=4,
aSettingType=5,
aLittleWorld=6,
aWanLingTa=7,
}

local xianjie_attribute_funcs=
{

[SYSTEM_ATTRIBUTE_TYPE.aYanDaoTai]={
func=function()
return yandaotaiModel:getAddrateDatasByEffectId(5)or{}
end,
attach=
{
eAttributeType.ePoZhen,
eAttributeType.eYZ_Speed,
eAttributeType.eZL_Speed,
eAttributeType.eXL_Speed,
eAttributeType.eJZ_CNT_VALUE,
eAttributeType.eJZATK_PCT,
eAttributeType.eJZDEF_PCT,
eAttributeType.eJZHP_PCT,
}
},


[SYSTEM_ATTRIBUTE_TYPE.aGuBao]={
func=function()
return gubaoModel:getJunZhenAttrAttr()or{}
end,
attach=
{
eAttributeType.eYZ_Speed,
eAttributeType.eZL_Speed,
eAttributeType.eJZ_CNT_VALUE,
eAttributeType.eJZATK_PCT,
eAttributeType.eJZDEF_PCT,
eAttributeType.eJZHP_PCT,
},
},


[SYSTEM_ATTRIBUTE_TYPE.aZMBuff]={
func=function()
return homeBuffModel.getBuffAddValue(BUFF_EFFECT_TYPE.eJunZhenAttr)or{}
end,
attach=
{
eAttributeType.eZL_Speed,
eAttributeType.eXL_Speed,
},
},


[SYSTEM_ATTRIBUTE_TYPE.aXJBuff]={
func=function()
return xianjieModel:getBuffTotalAttribute(xjBuffEffectType.eAttrJiaCheng)or{}
end,
sceneFunc=function(sceneIdx)
return xianjieModel:getBuffSceneAttribute(xjBuffEffectType.eAttrJiaCheng,sceneIdx)or{}
end,
attach=
{
eAttributeType.ePoZhen,
eAttributeType.eYZ_Speed,
eAttributeType.eJZATK_PCT,
eAttributeType.eJZDEF_PCT,
eAttributeType.eJZHP_PCT,
eAttributeType.eJunSha,
eAttributeType.eJZ_CNT,
eAttributeType.eJZ_CNT_VALUE,
},
},


[SYSTEM_ATTRIBUTE_TYPE.aSettingType]={
func=function()
return UISettingModel:getAddJZAttrList()or{}
end,
attach=function()
return UISettingModel:getAddJZAttrAttachList()or{}
end,
},


[SYSTEM_ATTRIBUTE_TYPE.aLittleWorld]={
func=function()
return xingChenCiZhuiEffectController:getEquippedXingChenJunZhenVal()
end,
attach=function()
return xingChenCiZhuiEffectController:getAttachJZAttr()
end,
},


[SYSTEM_ATTRIBUTE_TYPE.aWanLingTa]={
func=function()
return wanLingTaModel:getWanLingTaJunZhenSpeAttrsLookup()
end,
attach=
{
eAttributeType.eJZATK_PCT,
eAttributeType.eJZDEF_PCT,
eAttributeType.eJZHP_PCT,
eAttributeType.eJZ_CNT,
eAttributeType.eJZ_CNT_VALUE,
},
},
}


function xianjieModel:setDirty(sysid,attrId)
local cfg=xianjie_attribute_funcs[sysid]
if not cfg.dirty then cfg.dirty={}end
cfg.dirty[attrId]=true
end

function xianjieModel:setAllDirty(sysid)
local cfg=xianjie_attribute_funcs[sysid]
if not cfg.dirty then cfg.dirty={}end
local attach=nil
if type(cfg.attach)=="table"then
attach=cfg.attach
elseif type(cfg.attach)=="function"then
attach=cfg.attach()
end
if attach then
for i,attrId in ipairs(attach)do
xianjieModel:setDirty(sysid,attrId)
end
end
end

function xianjieModel:initXJAddAttr()
self:initXJAttrCfg()
self:initXJAttrLookup()
end

function xianjieModel:initXJAttrCfg()
for k,v in pairs(xianjie_attribute_funcs)do
local attach=nil
if type(v.attach)=="table"then
attach=v.attach
elseif type(v.attach)=="function"then
attach=v.attach()
end
if attach==nil then
logErr('仙界系统加成属性--没有配置关注类型')
end

for i,v in ipairs(attach)do
if _lookupAttach[v]==nil then _lookupAttach[v]={}end
local list=_lookupAttach[v]
list[#list+1]=k
end
end
end

function xianjieModel:initXJAttrLookup()
for k,v in ipairs(xianjie_attribute_funcs)do
local list=v.func()
v.dirty={}
v.lookup=list
for id,value in pairs(list)do
local val=attrDatas[id]or 0
attrDatas[id]=val+value
end
end
end

function xianjieModel:getJZAttrLookup(attrId,sceneIdx)
local list=_lookupAttach[attrId]
if list==nil then return nil end
local expVal=0
for _,sysType in pairs(list)do
local v=xianjie_attribute_funcs[sysType]
if v.dirty[attrId]then
local old=v.lookup
local new=v.func()
local val=attrDatas[attrId]or 0
local oldValue=old[attrId]or 0
local newValue=new[attrId]or 0
v.lookup[attrId]=newValue
v.dirty[attrId]=false
attrDatas[attrId]=val+newValue-oldValue
end
if sceneIdx and v.sceneFunc then
local exp=v.sceneFunc(sceneIdx)
local val=exp[attrId]or 0
expVal=expVal+val
end
end

return(attrDatas[attrId]or 0)+expVal
end


function xianjieModel:printJZAttrLookup(attrId)
local list=_lookupAttach[attrId]
if list==nil then return end
for _,sysType in pairs(list)do
local v=xianjie_attribute_funcs[sysType]
local old=v.lookup
local new=v.func()
local oldValue=old[attrId]or 0
local newValue=new[attrId]or 0

end
end
