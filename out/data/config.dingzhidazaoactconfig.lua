

local __rs={
[1]="定制打造",
[2]="请选择需要定制的部位",
[3]="请定制所需要的套装",
[4]="选择你要的随机属性类型",
[5]="是否需要精炼当前装备",
[6]="请先选择一个部位",
[7]="请先定制套装",
[8]="需定制随机属性",
[9]="需精炼等级",
}
local __r_1={
{
83,
{
bgname="image_xianshiqiandaobg_1"
}
}
}
local __r_2={
__rs[2],
__rs[3],
__rs[4],
__rs[5]
}
local __r_3={
{
10619,
100
}
}
local __r_4={
{
10618,
1
}
}
local __r_5={
{
10619,
200
}
}
local __r_6={
__r_4,
__r_3,
__r_3,
__r_5,
[6]={
{
10619,
50
}
},
[7]=__r_3,
[8]={
{
10619,
1000
}
}
}
local __r_7={
5367,
5368,
5369
}
local __r_8={
"icon_dingzhidazao_1",
"icon_dingzhidazao_2"
}
local __r_9={
__rs[6],
__rs[7],
__rs[8],
__rs[9]
}
local __r_10={
{
25,
34,
3
},
{
35,
44,
4
},
{
45,
999,
5
}
}
local __r_11={
{
10619,
5
}
}
local __r_12={
{
10619,
20
}
}
local __r_13={
{
10619,
10
}
}
local __r_14={
{
10619,
25
}
}
local __r_15={
{
10619,
15
}
}
local __r_16={
{
10619,
30
}
}
local ___noname___=
{
{
bgModelId=__r_7,
color=5,
id=1,
level=25,
openPanel=__r_1,
stage=__r_10,
sub_name=__rs[1],
sub_tabIcons=__r_8,
talkText=__r_2,
tipsText=__r_9,
useItem={
__r_6,
__r_6,
__r_6,
__r_6,
__r_6
}
},
{
bgModelId=__r_7,
color=5,
id=2,
level=25,
openPanel=__r_1,
stage=__r_10,
sub_name=__rs[1],
sub_tabIcons=__r_8,
talkText=__r_2,
tipsText=__r_9,
useItem={
[3]={
__r_4,
__r_12,
__r_12,
__r_13,
[6]=__r_11,
[7]=__r_11,
[8]=__r_3
},
[4]={
__r_4,
__r_14,
__r_14,
__r_15,
[6]=__r_13,
[7]=__r_13,
[8]={
{
10619,
150
}
}
},
[5]={
__r_4,
__r_16,
__r_16,
__r_12,
[6]=__r_15,
[7]=__r_15,
[8]=__r_5
}
}
}
}

return ___noname___
