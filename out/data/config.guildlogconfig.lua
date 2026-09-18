

local __rs={
[1]="<color=#ca631d>{0}</color>创建了<color=#ca631d>{1}</color>",
[2]="<color=#ca631d>{0}</color>将<color=#ca631d>{1}</color>任命为<color=#7d3b17>{2}</color>",
[3]="<color=#ca631d>{0}</color>将<color=#ca631d>{1}</color>移出仙盟",
[4]="<color=#ca631d>{1}</color>加入仙盟",
[5]="<color=#ca631d>{0}</color>退位让贤于<color=#ca631d>{1}</color>",
}
local ___noname___=
{
{
enum="gltCreate",
formatstr=__rs[1],
id=1
},
{
enum="gltChangePos",
formatstr=__rs[2],
id=2
},
{
enum="gltKickMember",
formatstr=__rs[3],
id=3
},
{
enum="gltNewMember",
formatstr=__rs[4],
id=4
},
{
enum="gltChangeLeader",
formatstr=__rs[5],
id=5
}
}

return ___noname___
