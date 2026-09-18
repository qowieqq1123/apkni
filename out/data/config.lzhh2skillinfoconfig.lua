

local __rs={
[1]="移除靠前的三张灵阵，放入旁边，之后可随时点击进入槽位进行消除",
[2]="移除灵阵",
[3]="移除",
[4]="撤回上一次选中放入槽位的灵阵，此灵阵会回到之前灵阵池中的位置",
[5]="撤回灵阵",
[6]="撤回",
[7]="随机打乱灵阵池当中所有的灵阵",
[8]="重设灵阵",
[9]="重设",
[10]="复活并移除槽位所有灵阵",
[11]="槽位已满",
[12]="复活",
}
local ___noname___=
{
{
desc=__rs[1],
iconName="icon_huodongygt_02",
id=1,
maxUseCount=2,
name=__rs[2],
useButtonName=__rs[3]
},
{
desc=__rs[4],
iconName="icon_huodongygt_03",
id=2,
maxUseCount=2,
name=__rs[5],
useButtonName=__rs[6]
},
{
desc=__rs[7],
iconName="icon_huodongygt_04",
id=3,
maxUseCount=2,
name=__rs[8],
useButtonName=__rs[9]
},
{
desc=__rs[10],
iconName="icon_huodongygt_01",
id=4,
maxUseCount=1,
name=__rs[11],
useButtonName=__rs[12]
}
}

return ___noname___
