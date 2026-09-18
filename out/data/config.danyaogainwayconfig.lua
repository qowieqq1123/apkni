

local __rs={
[1]="在炼丹房炼制",
[2]="仙盟商店",
[3]="参与天渊兽潮活动",
[4]="斗法台商店",
}
local __r_1={
desc=__rs[1],
jump={
id=501,
type=0
},
lv=1
}
local ___noname___=
{
{
id=1,
jingjieProduce={
__r_1,
{
desc=__rs[2],
jump={
id=4801,
type=0
},
lv=1
}
},
liantiProduce={
__r_1,
{
desc=__rs[3],
jump={
args={
actID=1
},
id=4500,
type=0
},
lv=15
},
{
desc=__rs[4],
jump={
id=2902,
type=0
},
lv=15
}
},
tupoProduce={
__r_1
}
}
}

return ___noname___
