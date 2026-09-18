

local __rs={
[1]="道侣洞府灵力充盈，乃用女娲补天之石所建，可为弟子提供源源灵力，摈弃杂念，弟子在修炼中似心心相连，使得修炼效率倍增，修为大进；",
[2]="进行双修不仅可以获得大量修为，还有几率获得<color=#CA631D>炼体经验</color>，<color=#CA631D>六维属性</color>，<color=#CA631D>道侣专属特质</color>",
[3]="道侣双修有几率获得约<color=#aae252>30万炼体经验</color>  （不受根骨加成）",
[4]="炼体",
[5]="道侣弟子在修炼时候有几率获得六维属性之一，每种属性有一定上限",
[6]="六维属性",
[7]="有几率获得道侣专属特质\n\n<color=#f1ce78>【特质升级】</color>\n道侣特质可重复获得进行升级\n<color=#9999FF>执子之手</color> → <color=#9999FF>知音相伴</color> → <color=#9999FF>琴瑟和鸣</color> → <color=#9999FF>心有灵犀</color> → <color=#9999FF>永结同心</color> → <color=#9999FF>神仙眷侣</color>  ",
[8]="道侣特质",
}
local __r_1={
{
72,
500
}
}
local __r_2={
{
4,
21
}
}
local __r_3={
{
desc=__rs[3],
icon="icon_zmzt_29",
name=__rs[4]
},
{
desc=__rs[5],
icon="icon_zmzt_30",
name=__rs[6]
},
{
desc=__rs[7],
icon="icon_zmzt_42",
name=__rs[8]
}
}
local __r_4={
100,
100,
100,
90,
100,
100
}
local ___noname___=
{
[80]={
{
build_id=80,
desc=__rs[1],
enter_cond=__r_2,
id=1,
jj_xiulian_up=4,
jyTips=__r_3,
level=1,
promote_cost=__r_1,
promote_sixattr_max=__r_4,
sxDesc=__rs[2]
},
{
build_id=80,
desc=__rs[1],
enter_cond=__r_2,
id=2,
jj_xiulian_up=8,
jyTips=__r_3,
level=2,
promote_cost=__r_1,
promote_sixattr_max=__r_4,
sxDesc=__rs[2]
},
{
build_id=80,
desc=__rs[1],
enter_cond=__r_2,
id=3,
jj_xiulian_up=12,
jyTips=__r_3,
level=3,
promote_cost=__r_1,
promote_sixattr_max=__r_4,
sxDesc=__rs[2]
},
{
build_id=80,
desc=__rs[1],
enter_cond=__r_2,
id=4,
jj_xiulian_up=20,
jyTips=__r_3,
level=4,
promote_cost=__r_1,
promote_sixattr_max=__r_4,
sxDesc=__rs[2]
},
{
build_id=80,
desc=__rs[1],
enter_cond=__r_2,
id=5,
jj_xiulian_up=30,
jyTips=__r_3,
level=5,
promote_cost=__r_1,
promote_sixattr_max=__r_4,
sxDesc=__rs[2]
}
}
}
___noname___.const_def=
{
cannot_promote_state={
3,
4
},
week_dizi_promote_cnt=1,
week_promote_cnt=1
}

return ___noname___
