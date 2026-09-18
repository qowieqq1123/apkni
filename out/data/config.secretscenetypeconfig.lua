

local __rs={
[1]="宗门秘境",
[2]="奇遇秘境",
[3]="上古险地",
[4]="仙迹福地",
}
local ___noname___=
{
{
id=1,
name=__rs[1],
onClickFunc="onCommonClick",
priority=2,
refreshFunc="refreshCommonItem",
sceneType={
2
}
},
{
id=2,
name=__rs[2],
onClickFunc="onCommonClick",
priority=2,
refreshFunc="refreshCommonItem",
sceneType={
3,
5
}
},
{
id=3,
name=__rs[3],
onClickFunc="onXianDiClick",
priority=3,
refreshFunc="refreshXianDiItem",
sceneType={
4
}
},
{
id=4,
name=__rs[4],
onClickFunc="ohRandomClick",
priority=1,
refreshFunc="refreshRandomItem",
sceneType={
6
}
}
}

return ___noname___
