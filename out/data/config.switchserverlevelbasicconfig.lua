

local __rs={
[1]="招人啦，客官里面请！",
[2]="基础\n规则",
[3]="破界跃迁说明",
[4]="个人规则",
[5]="宗门规则",
[6]="财产",
}
local ___noname___=
{
{
def_notice=__rs[1],
id=1,
open_conf={
{
1
}
},
sync_yuzhu_time=3600,
transferRules={
{
rules={
{
name=__rs[4],
prefix="serverTransfer_help_%d"
},
{
name=__rs[5],
prefix="serverTransfer_help2_%d"
}
},
tabName=__rs[2],
tabTitle=__rs[3]
},
{
rules={
{
name="",
prefix="serverTransfer_help3_%d"
}
},
tabName=__rs[6],
tabTitle=__rs[3]
}
},
xianyu_level_time_conf={
1,
2,
0,
0
},
zhizun_dianfeng_cnt=20,
zm_level_time_conf={
1,
1,
0,
0
}
}
}

return ___noname___
