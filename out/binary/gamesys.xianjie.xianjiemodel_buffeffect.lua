xjBuffEffectType=
{
eFangHuZhao=1,
eAttrJiaCheng=2,
eAddYunZhouBingLimit=3,
eDisableFangHuZhao=4,
eKillMonsterRewardUp=5,
eBanMoveZongMen=6,
eZongMenInvisible=7,
eCanNotTanChaAndFangZhu=8,
eLongweiShenDunBuff=9,
eBanFangZhuZongMen=10,
eBanJinGuZongMen=11,
eFangshouJunZhenAttr=12,
eYunZhouAttrJiaChengNotJiJie=13,
eCantLeaveSafeArea=14,
eMoJieShiLiSkillLight=15,
eYunZhouAttrJiaChengMoJun=16,
eFaZeAdd=17,

eEntityAttrTypeHead=100,
eAttrAttackLeader=104,
eAttrAttackXianXu=107,

eMJSLSkillPengLaiAdd=3001,
eMJSLSkillAddIcon=3002,
eMJSLSkillJiuYuanAdd=3003,
eZaieBuQinBuff=60000,



eMingYueMoJun=10397,
eMoJieZhenYan_Big=10520,


}


local xjBuffAttributeType=
{
[xjBuffEffectType.eAttrJiaCheng]=true,
[xjBuffEffectType.eAttrAttackLeader]=true,
[xjBuffEffectType.eAttrAttackXianXu]=true,
[xjBuffEffectType.eYunZhouAttrJiaChengNotJiJie]=true,
[xjBuffEffectType.eYunZhouAttrJiaChengMoJun]=true,
}



local _effectHandle=
{
[xjBuffEffectType.eFangHuZhao]=
{
add=function(...)
tianshudazhenModel:onRefreshFangYuZhaoBuffBuff(...)
end,
remove=function(...)
tianshudazhenModel:onRefreshFangYuZhaoBuffBuff(...)
end,
init=function(...)
tianshudazhenModel:onInitFHZBuff()
end,
refresh=function(...)

end
},
[xjBuffEffectType.eAttrJiaCheng]=
{
add=function(...)
xianjieModel:addBuffAttribute(...)
end,
remove=function(...)
xianjieModel:removeBuffAttribute(...)
end,
init=function(...)

end,
refresh=function(...)

end
},
[xjBuffEffectType.eAddYunZhouBingLimit]=
{
add=function(...)

end,
remove=function(...)

end,
init=function(...)

end,
refresh=function(...)

end
},
[xjBuffEffectType.eDisableFangHuZhao]=
{
add=function(...)
tianshudazhenModel:onRefreshDisableFangYuZhaoBuff(...)
end,
remove=function(...)
tianshudazhenModel:onRefreshDisableFangYuZhaoBuff(...)
end,
init=function(...)

end,
refresh=function(...)

end
},
[xjBuffEffectType.eKillMonsterRewardUp]=
{
add=function(...)

end,
remove=function(...)

end,
init=function(...)

end,
refresh=function(...)

end
},
[xjBuffEffectType.eBanMoveZongMen]=
{
add=function(...)

end,
remove=function(...)

end,
init=function(...)

end,
refresh=function(...)

end
},
[xjBuffEffectType.eAttrAttackLeader]=
{
add=function(...)
xianjieModel:addBuffAttribute(...)
end,
remove=function(...)
xianjieModel:removeBuffAttribute(...)
end,
init=function(...)

end,
refresh=function(...)

end
},
[xjBuffEffectType.eAttrAttackXianXu]=
{
add=function(...)
xianjieModel:addBuffAttribute(...)
end,
remove=function(...)
xianjieModel:removeBuffAttribute(...)
end,
init=function(...)

end,
refresh=function(...)

end
},
[xjBuffEffectType.eZongMenInvisible]=
{
add=function(...)

end,
remove=function(...)

end,
init=function(...)

end,
refresh=function(...)

end
},
[xjBuffEffectType.eCanNotTanChaAndFangZhu]=
{
add=function(...)

end,
remove=function(...)

end,
init=function(...)

end,
refresh=function(...)

end
},
[xjBuffEffectType.eBanFangZhuZongMen]=
{
add=function(...)

end,
remove=function(...)

end,
init=function(...)

end,
refresh=function(...)

end
},
[xjBuffEffectType.eBanJinGuZongMen]=
{
add=function(...)

end,
remove=function(...)

end,
init=function(...)

end,
refresh=function(...)

end
},
[xjBuffEffectType.eFangshouJunZhenAttr]=
{
add=function(...)
tianshudazhenModel:onAddXgAttr(...)
end,
remove=function(...)
tianshudazhenModel:onRemoveXgAttr(...)
end,
init=function(...)

end,
refresh=function(...)

end
},
[xjBuffEffectType.eYunZhouAttrJiaChengNotJiJie]=
{
add=function(...)
xianjieModel:addBuffAttribute(...)
end,
remove=function(...)
xianjieModel:removeBuffAttribute(...)
end,
init=function(...)

end,
refresh=function(...)

end
},
[xjBuffEffectType.eYunZhouAttrJiaChengMoJun]=
{
add=function(...)
xianjieModel:addBuffAttribute(...)
end,
remove=function(...)
xianjieModel:removeBuffAttribute(...)
end,
init=function(...)

end,
refresh=function(...)

end
},
[xjBuffEffectType.eCantLeaveSafeArea]=
{
add=function(...)

end,
remove=function(...)

end,
init=function(...)

end,
refresh=function(...)

end
},

[xjBuffEffectType.eLongweiShenDunBuff]=
{
add=function(...)
tianshudazhenModel:onRefreshTianShuShenDunBuff(...)
end,
remove=function(...)
tianshudazhenModel:onRefreshTianShuShenDunBuff(...)
end,
init=function(...)

end,
refresh=function(...)
end
},
[xjBuffEffectType.eZaieBuQinBuff]=
{
add=function(...)
tianshudazhenModel:onRefreshZaieBuQinBuff(...)
end,
remove=function(...)
tianshudazhenModel:onRefreshZaieBuQinBuff(...)
end,
init=function(...)

end,
refresh=function(...)

end
},
[xjBuffEffectType.eMoJieShiLiSkillLight]=
{
add=function(...)

end,
remove=function(...)

end,
init=function(...)

end,
refresh=function(...)

end
},
[xjBuffEffectType.eMJSLSkillPengLaiAdd]=
{
add=function(...)

end,
remove=function(...)

end,
init=function(...)

end,
refresh=function(...)

end
},
[xjBuffEffectType.eMJSLSkillAddIcon]=
{
add=function(...)

end,
remove=function(...)

end,
init=function(...)

end,
refresh=function(...)

end
},
[xjBuffEffectType.eMJSLSkillJiuYuanAdd]=
{
add=function(...)

end,
remove=function(...)

end,
init=function(...)

end,
refresh=function(...)

end
},
[xjBuffEffectType.eFaZeAdd]=
{
add=function(...)

end,
remove=function(...)

end,
init=function(...)

end,
refresh=function(...)

end
},


[xjBuffEffectType.eMingYueMoJun]=
{
add=function(...)

end,
remove=function(...)

end,
init=function(...)

end,
refresh=function(...)

end
},
[xjBuffEffectType.eMoJieZhenYan_Big]=
{
add=function(...)

end,
remove=function(...)

end,
init=function(...)

end,
refresh=function(...)

end
},

}

local entityAttrTypeCommonHandle={
add=function(...)
xianjieModel:addBuffAttribute(...)
end,
remove=function(...)
xianjieModel:removeBuffAttribute(...)
end,
init=function(...)

end,
refresh=function(...)

end
}
for type=xjBuffEffectType.eEntityAttrTypeHead+1,xjBuffEffectType.eEntityAttrTypeHead+xjServerEnityType.eEnumMax do
_effectHandle[type]=entityAttrTypeCommonHandle
xjBuffAttributeType[type]=true
end

function xianjieModel:addBuffEffect(buffid,times,init)

if xianjieModel.isBuffShieldedInScene and xianjieModel:isBuffShieldedInScene(buffid)then
return
end
local effects=cfgHelper.get2(cfg_fairylandbuffconfig_get,buffid,'effects')
for _,v in ipairs(effects)do
local effecttype=v[1]
local attrId=v[2]

if effecttype==2 then
xianjieModel:setDirty(SYSTEM_ATTRIBUTE_TYPE.aXJBuff,attrId)

end

local info=_effectHandle[effecttype]
if info and info.add then
xpcall(function()
info.add(buffid,v,times,init)
end,function(err)
logErr('addBuffEffect err:',err)
end)
else
loggerUtil.debugErrFMT('暂未支持添加效果类型：{0},buffid：{1}',effecttype,buffid)
end
end
end

function xianjieModel:removeBuffEffect(buffid)


if xianjieModel.isBuffShieldedInScene and xianjieModel:isBuffShieldedInScene(buffid)then
return
end
local effects=cfgHelper.get2(cfg_fairylandbuffconfig_get,buffid,'effects')
for _,v in ipairs(effects)do
local effecttype=v[1]
local attrId=v[2]

if effecttype==2 then
xianjieModel:setDirty(SYSTEM_ATTRIBUTE_TYPE.aXJBuff,attrId)
end

local info=_effectHandle[effecttype]
if info and info.remove then
xpcall(function()
info.remove(buffid,v)
end,function(err)
logErr('removeBuffEffect err:',err)
end)
else
loggerUtil.debugErrFMT('暂未支持删除效果类型：{0}',effecttype)
end
end
end

function xianjieModel:refreshBuffEffect(buffid)
local effects=cfgHelper.get2(cfg_fairylandbuffconfig_get,buffid,'effects')
for _,v in ipairs(effects)do
local effecttype=v[1]
local attrId=v[2]

if effecttype==2 then
xianjieModel:setDirty(SYSTEM_ATTRIBUTE_TYPE.aXJBuff,attrId)

end

local info=_effectHandle[effecttype]
if info and info.refresh then
xpcall(function()
info.refresh(buffid,v)
end,function(err)
logErr('changeBuffEffect err:',err)
end)
else
loggerUtil.debugErrFMT('暂未支持添加效果类型：{0},buffid：{1}',effecttype,buffid)
end
end
end

function xianjieModel:initBuffs()
for effecttype,info in pairs(_effectHandle)do
if info.init then
xpcall(function()
info.init()
end,function(err)
logErr('removeBuffEffect err:',err)
end)
end
end

if xianjieModel.getBuffList then
for _,v in ipairs(xianjieModel:getBuffList())do
local buffid=v.buffid
if xianjieModel.isBuffShieldedInScene and xianjieModel:isBuffShieldedInScene(buffid)then
xianjieModel:removeBuffEffect(buffid)
else
xianjieModel:addBuffEffect(buffid)
end
end
end
end


function xianjieModel:CheckBuffAttribute(attrtype)
return xjBuffAttributeType[attrtype]
end


