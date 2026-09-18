

local __rs={
[1]="“听取此灯谜谜底”",
[2]="师尊这题我会！",
[3]="“排除两个错误文字”",
[4]="弟子想来这些应不是谜底",
[5]="“填入一个正确文字”",
[6]="弟子知晓此字应和答案有关",
[7]="“排除一半错误文字”",
}
local __r_1={
__rs[4]
}
local ___noname___=
{
{
desc=__rs[1],
id=1,
speakskill={
__rs[2]
}
},
{
desc=__rs[3],
id=2,
speakskill=__r_1
},
{
desc=__rs[5],
id=3,
speakskill={
__rs[6]
}
},
{
desc=__rs[7],
id=4,
speakskill=__r_1
}
}

return ___noname___
