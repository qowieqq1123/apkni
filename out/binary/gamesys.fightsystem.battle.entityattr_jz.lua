entityAttr_jz=
{
JZ_PROP_ATTACK=1,
JZ_PROP_DEF=2,


JZ_PROP_ATTACK_UP=101,
JZ_PROP_DAMAGE_SUB=102,
JZ_PROP_HP_MOD=103,

JZ_PROP_RATE_START=201,
JZ_PROP_RATE_END=300,

}

entityAttrName=
{
[1]='攻击',
[2]='防御',



}



function getEntityFmtAttr(ent,id)
local value=ent:getAttribute(id)
return FMT.fmt("{0}:{1}",entityAttrName[id]or id,value)
end

for i,v in pairs(entityAttr_jz)do

end
