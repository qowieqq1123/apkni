







local format_strs={

[1]='<color=#7d3b17>{0}：</color>{1}',
[2]='<color=#7d3b17>{0}等级：</color>{1}',

[3]='{0}不足',
[4]='职业不符',
[5]='{0}等级不足',

[6]='{0}等级',

[7]='{0}({1})',
[8]='{0}等级({1})',
}

local specialAttrDescLookup={

[eSpecialAttrType.DISCIPLE_SPE_ATTR_ID_ATTR_1]={
getDesc1=function(typo,v)
return FMT.fmt(format_strs[1],eSpecialAttrName:getName(typo),v)
end,
getDesc2=function(typo,v)
return FMT.fmt(format_strs[3],eSpecialAttrName:getName(typo))
end,
getDesc3=function(typo)
return eSpecialAttrName:getName(typo)
end,
getDesc4=function(typo,v)
return FMT.fmt(format_strs[7],eSpecialAttrName:getName(typo),v)
end,
},

[eSpecialAttrType.DISCIPLE_SPE_ATTR_ID_ATTR_2]={
getDesc1=function(typo,v)
return FMT.fmt(format_strs[1],eSpecialAttrName:getName(typo),v)
end,
getDesc2=function(typo,v)
return FMT.fmt(format_strs[3],eSpecialAttrName:getName(typo))
end,
getDesc3=function(typo)
return eSpecialAttrName:getName(typo)
end,
getDesc4=function(typo,v)
return FMT.fmt(format_strs[7],eSpecialAttrName:getName(typo),v)
end,
},

[eSpecialAttrType.DISCIPLE_SPE_ATTR_ID_ATTR_3]={
getDesc1=function(typo,v)
return FMT.fmt(format_strs[1],eSpecialAttrName:getName(typo),v)
end,
getDesc2=function(typo,v)
return FMT.fmt(format_strs[3],eSpecialAttrName:getName(typo))
end,
getDesc3=function(typo)
return eSpecialAttrName:getName(typo)
end,
getDesc4=function(typo,v)
return FMT.fmt(format_strs[7],eSpecialAttrName:getName(typo),v)
end,
},

[eSpecialAttrType.DISCIPLE_SPE_ATTR_ID_ATTR_4]={
getDesc1=function(typo,v)
return FMT.fmt(format_strs[1],eSpecialAttrName:getName(typo),v)
end,
getDesc2=function(typo,v)
return FMT.fmt(format_strs[3],eSpecialAttrName:getName(typo))
end,
getDesc3=function(typo)
return eSpecialAttrName:getName(typo)
end,
getDesc4=function(typo,v)
return FMT.fmt(format_strs[7],eSpecialAttrName:getName(typo),v)
end,
},

[eSpecialAttrType.DISCIPLE_SPE_ATTR_ID_ATTR_5]={
getDesc1=function(typo,v)
return FMT.fmt(format_strs[1],eSpecialAttrName:getName(typo),v)
end,
getDesc2=function(typo,v)
return FMT.fmt(format_strs[3],eSpecialAttrName:getName(typo))
end,
getDesc3=function(typo)
return eSpecialAttrName:getName(typo)
end,
getDesc4=function(typo,v)
return FMT.fmt(format_strs[7],eSpecialAttrName:getName(typo),v)
end,
},

[eSpecialAttrType.DISCIPLE_SPE_ATTR_ID_ATTR_6]={
getDesc1=function(typo,v)
return FMT.fmt(format_strs[1],eSpecialAttrName:getName(typo),v)
end,
getDesc2=function(typo,v)
return FMT.fmt(format_strs[3],eSpecialAttrName:getName(typo))
end,
getDesc3=function(typo)
return eSpecialAttrName:getName(typo)
end,
getDesc4=function(typo,v)
return FMT.fmt(format_strs[7],eSpecialAttrName:getName(typo),v)
end,
},

[eSpecialAttrType.DISCIPLE_SPE_ATTR_ID_VOC]={
getDesc1=function(typo,v)
local jobname=UIDiscipleModel:getJobName(v)
return FMT.fmt(format_strs[1],eSpecialAttrName:getName(typo),jobname)
end,
getDesc2=function(typo,v)
return format_strs[4]
end,
getDesc4=function(typo,v)
local jobname=UIDiscipleModel:getJobName(v)
return FMT.fmt(format_strs[7],eSpecialAttrName:getName(typo),jobname)
end,
},

[eSpecialAttrType.DISCIPLE_SPE_ATTR_ID_PROSKILL_1]={
getDesc1=function(typo,v)
return FMT.fmt(format_strs[2],eSpecialAttrName:getName(typo),v)
end,
getDesc2=function(typo,v)
return FMT.fmt(format_strs[5],eSpecialAttrName:getName(typo))
end,
getDesc3=function(typo)
return FMT.fmt(format_strs[6],eSpecialAttrName:getName(typo))
end,
getDesc4=function(typo,v)
return FMT.fmt(format_strs[8],eSpecialAttrName:getName(typo),v)
end,
},

[eSpecialAttrType.DISCIPLE_SPE_ATTR_ID_PROSKILL_2]={
getDesc1=function(typo,v)
return FMT.fmt(format_strs[2],eSpecialAttrName:getName(typo),v)
end,
getDesc2=function(typo,v)
return FMT.fmt(format_strs[5],eSpecialAttrName:getName(typo))
end,
getDesc3=function(typo)
return FMT.fmt(format_strs[6],eSpecialAttrName:getName(typo))
end,
getDesc4=function(typo,v)
return FMT.fmt(format_strs[8],eSpecialAttrName:getName(typo),v)
end,
},

[eSpecialAttrType.DISCIPLE_SPE_ATTR_ID_PROSKILL_3]={
getDesc1=function(typo,v)
return FMT.fmt(format_strs[2],eSpecialAttrName:getName(typo),v)
end,
getDesc2=function(typo,v)
return FMT.fmt(format_strs[5],eSpecialAttrName:getName(typo))
end,
getDesc3=function(typo)
return FMT.fmt(format_strs[6],eSpecialAttrName:getName(typo))
end,
getDesc4=function(typo,v)
return FMT.fmt(format_strs[8],eSpecialAttrName:getName(typo),v)
end,
},

[eSpecialAttrType.DISCIPLE_SPE_ATTR_ID_PROSKILL_4]={
getDesc1=function(typo,v)
return FMT.fmt(format_strs[2],eSpecialAttrName:getName(typo),v)
end,
getDesc2=function(typo,v)
return FMT.fmt(format_strs[5],eSpecialAttrName:getName(typo))
end,
getDesc3=function(typo)
return FMT.fmt(format_strs[6],eSpecialAttrName:getName(typo))
end,
getDesc4=function(typo,v)
return FMT.fmt(format_strs[8],eSpecialAttrName:getName(typo),v)
end,
},

[eSpecialAttrType.DISCIPLE_SPE_ATTR_ID_PROSKILL_5]={
getDesc1=function(typo,v)
return FMT.fmt(format_strs[2],eSpecialAttrName:getName(typo),v)
end,
getDesc2=function(typo,v)
return FMT.fmt(format_strs[5],eSpecialAttrName:getName(typo))
end,
getDesc3=function(typo)
return FMT.fmt(format_strs[6],eSpecialAttrName:getName(typo))
end,
getDesc4=function(typo,v)
return FMT.fmt(format_strs[8],eSpecialAttrName:getName(typo),v)
end,
},

[eSpecialAttrType.DISCIPLE_SPE_ATTR_ID_PROSKILL_6]={
getDesc1=function(typo,v)
return FMT.fmt(format_strs[2],eSpecialAttrName:getName(typo),v)
end,
getDesc2=function(typo,v)
return FMT.fmt(format_strs[5],eSpecialAttrName:getName(typo))
end,
getDesc3=function(typo)
return FMT.fmt(format_strs[6],eSpecialAttrName:getName(typo))
end,
getDesc4=function(typo,v)
return FMT.fmt(format_strs[8],eSpecialAttrName:getName(typo),v)
end,
},

[eSpecialAttrType.DISCIPLE_SPE_ATTR_ID_PROSKILL_7]={
getDesc1=function(typo,v)
return FMT.fmt(format_strs[2],eSpecialAttrName:getName(typo),v)
end,
getDesc2=function(typo,v)
return FMT.fmt(format_strs[5],eSpecialAttrName:getName(typo))
end,
getDesc3=function(typo)
return FMT.fmt(format_strs[6],eSpecialAttrName:getName(typo))
end,
getDesc4=function(typo,v)
return FMT.fmt(format_strs[8],eSpecialAttrName:getName(typo),v)
end,
},

[eSpecialAttrType.DISCIPLE_SPE_ATTR_ID_PROSKILL_8]={
getDesc1=function(typo,v)
return FMT.fmt(format_strs[2],eSpecialAttrName:getName(typo),v)
end,
getDesc2=function(typo,v)
return FMT.fmt(format_strs[5],eSpecialAttrName:getName(typo))
end,
getDesc3=function(typo)
return FMT.fmt(format_strs[6],eSpecialAttrName:getName(typo))
end,
getDesc4=function(typo,v)
return FMT.fmt(format_strs[8],eSpecialAttrName:getName(typo),v)
end,
},
}

function xianmengdigongModel:get_eventCond_desc1(typo,v)
return specialAttrDescLookup[typo].getDesc1(typo,v)
end

function xianmengdigongModel:get_eventCond_desc2(typo,v)
return specialAttrDescLookup[typo].getDesc2(typo,v)
end

function xianmengdigongModel:get_eventCond_desc3(typo)
return specialAttrDescLookup[typo].getDesc3(typo)
end

function xianmengdigongModel:get_eventCond_desc4(typo,v)
return specialAttrDescLookup[typo].getDesc4(typo,v)
end