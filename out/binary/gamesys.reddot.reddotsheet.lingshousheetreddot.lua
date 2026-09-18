







lingshouBaseSheetReddot=reddotSheetBase.new({classname='lingshouBaseSheetReddot'})

lingshouBaseSheetReddot.reddot_type=REDDIT_TYPE.eLingShouBase

lingshouBaseSheetReddot.reddot_config=
{
[REDDIT_SUB_TYPE.sLingShouEnter]=
{
catch={
CATCH_TYPE.eMoney,
CATCH_TYPE.eItem,
CATCH_TYPE.eLingShouMainSkillChange,
},
func=function(catchType,...)
return lingshouModel:checkEnterLingShouReddot()
end,
},

}

lingshouInfoSheetReddot=reddotSheetBase.new({classname='lingshouInfoSheetReddot'})

lingshouInfoSheetReddot.reddot_type=REDDIT_TYPE.eLingShou

lingshouInfoSheetReddot.reddot_config=
{
[REDDIT_SUB_TYPE.sLingShouBase]=
{
catch={
CATCH_TYPE.eMoney,
CATCH_TYPE.eItem,
CATCH_TYPE.eLingShouMainSkillChange,
},
func=function(catchType,...)
if fullScreenUI.isActiveFullEx(FULL_TYPE.eLingShouMain)then
local attach={}
UIFullLingShouMainControl:copyAttach2(attach)
local lsGuid=attach.ls_guid
if lsGuid then
return lingshouModel:checkLingShouReddot(lsGuid)
end
end
return false
end,
},
[REDDIT_SUB_TYPE.sLingShouInfo]=
{
catch={
CATCH_TYPE.eMoney,
CATCH_TYPE.eItem,
CATCH_TYPE.eSystemOpen,
CATCH_TYPE.eLingShouMainSkillChange,
CATCH_TYPE.eLingShouChangeTab,
},
func=function(catchType,...)
if fullScreenUI.isActiveFullEx(FULL_TYPE.eLingShouMain)then
local attach={}
UIFullLingShouMainControl:copyAttach2(attach)
local lsGuid=attach.ls_guid
if lsGuid then
return lingshouModel:checkLingShouReddot_info(lsGuid)
end
end
return false
end,
},
[REDDIT_SUB_TYPE.sLingShouJingJie]=
{
catch={
CATCH_TYPE.eLingShouChangeTab,
},
func=function(catchType,...)
if fullScreenUI.isActiveFullEx(FULL_TYPE.eLingShouMain)then
local attach={}
UIFullLingShouMainControl:copyAttach2(attach)
local lsGuid=attach.ls_guid
if lsGuid then
return lingshouModel:checkLingShouReddot_jingjie(lsGuid)
end
end
return false
end,
},
[REDDIT_SUB_TYPE.sLingShouXueMai]=
{
catch={
CATCH_TYPE.eMoney,
CATCH_TYPE.eItem,
CATCH_TYPE.eLingShouChangeTab,
},
func=function(catchType,...)
if fullScreenUI.isActiveFullEx(FULL_TYPE.eLingShouMain)then
local attach={}
UIFullLingShouMainControl:copyAttach2(attach)
local lsGuid=attach.ls_guid
if lsGuid then
return lingshouModel:checkLingShouReddot_XueMai(lsGuid)
end
end
return false
end,
},

}