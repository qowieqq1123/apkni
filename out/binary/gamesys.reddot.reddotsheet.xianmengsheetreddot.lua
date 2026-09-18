








xianmengBaseSheetReddot=reddotSheetBase.new({classname='xianmengBaseSheetReddot'})

xianmengBaseSheetReddot.reddot_type=REDDIT_TYPE.eXianMengBase

xianmengBaseSheetReddot.reddot_config=
{
[REDDIT_SUB_TYPE.sXianMengBase]=
{
catch={
CATCH_TYPE.eXMApplication,
CATCH_TYPE.eXMRepairCollect,
CATCH_TYPE.eMountainSwitch,
CATCH_TYPE.eXianXunBangRewardChange,
CATCH_TYPE.eXianMengWeekScoreChange,
CATCH_TYPE.eXianWuLouRewardChange,
CATCH_TYPE.eXianWuLouProgressChange,
CATCH_TYPE.eXMDGShopManage,
CATCH_TYPE.eLimitActChange,
},
func=function(catchType,...)
return(
zongmenModel:getMountainId()~=mapIdType.xianmeng and xianmengModel:checkSystemReddot()
or
(
xianmengModel:getRepairCollectReddot()or xianmengModel:getGXBRewardReddot()or xianmengModel:checkXWLHasReward()
or xianmengdigongModel:check_XMDG_shopManageReddot()or xianmengModel:checkXMZReddot()or xianmengdigongModel:checkPassReddot()
)
)
end,
},
}



xianmengPalaceSheetReddot=reddotSheetBase.new({classname='xianmengPalaceSheetReddot'})

xianmengPalaceSheetReddot.reddot_type=REDDIT_TYPE.eXianMengPalace

xianmengPalaceSheetReddot.reddot_config=
{
[REDDIT_SUB_TYPE.sXianMengPalace]=
{
catch={
CATCH_TYPE.eXMApplication,
},
func=function(catchType,...)
return xianmengModel:checkPalaceReddot()
end,
},
}


xianmengXianWuLouSheetReddot=reddotSheetBase.new({classname='xianmengXianWuLouSheetReddot'})

xianmengXianWuLouSheetReddot.reddot_type=REDDIT_TYPE.eXianWuLou

xianmengXianWuLouSheetReddot.reddot_config=
{
[REDDIT_SUB_TYPE.sXianWuLou]=
{
catch={
CATCH_TYPE.eXianWuLouRewardChange,
CATCH_TYPE.eXianWuLouProgressChange,
},
func=function(catchType,...)
return xianmengModel:checkXWLHasReward()
end,
},
}


xianmengDiGongSheetReddot=reddotSheetBase.new({classname='xianmengDiGongSheetReddot'})

xianmengDiGongSheetReddot.reddot_type=REDDIT_TYPE.eXianMengDiGong

xianmengDiGongSheetReddot.reddot_config=
{
[REDDIT_SUB_TYPE.sXianMengDiGong]=
{
catch={
CATCH_TYPE.eXMDGShopManage,
CATCH_TYPE.eXMDGPass,
},
func=function(catchType,...)
return xianmengdigongModel:check_XMDG_shopManageReddot()
end,
},
}

xianmengZhanSheetReddot=reddotSheetBase.new({classname='xianmengZhanSheetReddot'})

xianmengZhanSheetReddot.reddot_type=REDDIT_TYPE.eXianMengZhan

xianmengZhanSheetReddot.reddot_config=
{
[REDDIT_SUB_TYPE.sXianMengZhan]=
{
catch={
CATCH_TYPE.eLimitActChange,
},
func=function(catchType,...)
return xianmengModel:checkXMZReddot()
end,
},
}