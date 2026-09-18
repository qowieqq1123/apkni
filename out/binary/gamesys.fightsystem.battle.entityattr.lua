entityAttr=
{
attack=1,
def=2,
max_hp=3,
speed=4,


jin_add=101,
jin_def=102,
mu_add=103,
mu_def=104,
shui_add=105,
shui_def=106,
huo_add=107,
huo_def=108,
tu_add=109,
tu_def=110,
feng_add=111,
feng_def=112,
lei_add=113,
lei_def=114,
du_add=115,
du_def=116,
hun_add=117,
hun_def=118,
xue_add=119,
xue_def=120,


critical_rate=201,
critical_mod=202,
critical_def=203,
critical_def_mod=204,
buff_hit=205,
buff_dodge=206,
hit=207,
dodge=208,
cure=209,
cured=210,
attack_up=211,
attack_def=212,
out_attack_up=213,
out_attack_def=214,
in_attack_up=215,
in_attack_def=216,
damage2hp=217,
normal_attack_up=218,
gem_up=219,
gem_def=220,
rebound_damage_up=221,
gem_power_up=222,
buff_damage_up=223,
debuff_back_rate=224,

normal_end=300,
mod_diff=300,

rate_start=301,
rate_end=400,


id=401,
id_idx=402,
hp=403,
fight_val=404,
gem_power=405,
max_gem_power=406,
gem_skillid=407,
gem_skilllv=408,
speed_fight=409,
entity_type=410,
level=411,

hudun=412,
sub_max_hp=415,

change_hp_type=1001,

}

entityAttrName=
{
[1]='攻击',
[2]='防御',
[3]='最大生命',
[4]='速度',


[101]='金系技能威力',
[102]='金系技能减伤',
[103]='木系技能威力',
[104]='木系技能减伤',
[105]='水系技能威力',
[106]='水系技能减伤',
[107]='火系技能威力',
[108]='火系技能减伤',
[109]='土系技能威力',
[110]='土系技能减伤',
[111]='风系技能威力',
[112]='风系技能减伤',
[113]='雷系技能威力',
[114]='雷系技能减伤',
[115]='毒系技能威力',
[116]='毒系技能减伤',
[117]='魂系技能威力',
[118]='魂系技能减伤',
[119]='血系技能威力',
[120]='血系技能减伤',


[201]='暴击几率(万分比)',
[202]='暴击伤害',
[203]='抗暴几率',
[204]='暴击减伤',
[205]='效果命中',
[206]='效果抵抗',
[207]='命中几率',
[208]='闪避几率',
[209]='治疗效果',
[210]='受疗效果',
[211]='全伤害提升',
[212]='全伤害减免',
[213]='物理伤害提升',
[214]='物理伤害减免',
[215]='法术伤害提升',
[216]='法术伤害减免',
[217]='攻击吸血',
[218]='普攻伤害提升+n%%',
[219]='法宝神通威力+n%%',
[220]='受到法宝神通伤害减免+n%%',
[221]='反射伤害+n%%',
[222]='法宝能量+n%%',
[223]='buff持续伤害+n%%',
[224]='负面buff反弹概率+n%%',

[300]='百分比属性和普通属性的差值',

[301]='百分比的增强',

[400]='百分比属性结束',

[401]='id',
[402]='idx',
[403]='生命',
[404]='战力',
[405]='法宝能量',
[406]='最大法宝能量',
[407]='法宝技能id',
[408]='法宝技能等级',
[409]='当前回合的速度',
[410]='是否怪物标志',
[411]='等级',
[412]='护盾值',
}



function getEntityFmtAttr(ent,id)
local value=ent:getAttribute(id)
return FMT.fmt("{0}:{1}",entityAttrName[id]or id,value)
end

for i,v in pairs(entityAttr)do

end
