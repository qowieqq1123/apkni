

local __rs={
[1]="记得领取今日收益哦",
[2]="您买不到吃亏,买不到上当",
[3]="商会投资,一本万利！",
[4]="十座仙门八家商,还有两家在开张",
[5]="一份利能致富,十分利可暴富",
[6]="祖师的{0}将要过期，记得追加投资哦",
[7]="祖师的{0}将要过期，记得追加投资哦！",
[8]="祖师的{0}将要过期，记得追加投资哦！！",
}
local __r_1={
__rs[1]
}
local __r_2={
0,
0
}
local __r_3={
__rs[2],
__rs[3],
__rs[4],
__rs[5]
}
local __r_4={
__rs[2],
__rs[3],
__rs[5]
}
local ___noname___=
{
{
id=1,
npcModel={
4015,
0.2,
__r_2
},
npcTalkShowTime=3,
npcTalkTime=2,
npcTalk_after=__r_1,
npcTalk_before=__r_3
},
{
id=2,
npcModel={
4015,
0.4,
__r_2
},
npcTalkShowTime=3,
npcTalkTime=2,
npcTalk_after=__r_1,
npcTalk_before=__r_3
},
{
id=3,
npcModel={
4015,
0.24,
__r_2
},
npcTalkShowTime=3,
npcTalkTime=2,
npcTalk_expire={
__rs[6],
__rs[7],
__rs[8]
}
},
{
id=4,
npcModel={
4015,
0.18,
__r_2
},
npcTalkShowTime=3,
npcTalkTime=4,
npcTalk_after=__r_4,
npcTalk_before=__r_4
}
}

return ___noname___
