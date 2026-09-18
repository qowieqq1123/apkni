
xiantuchengjiuSheetReddot_Base=reddotSheetBase.new({classname='xiantuchengjiuSheetReddot_Base'})

xiantuchengjiuSheetReddot_Base.reddot_type=REDDIT_TYPE.eXianTuChengJiu_Base

xiantuchengjiuSheetReddot_Base.reddot_config=
{
[REDDIT_SUB_TYPE.sXianTuChengJiu_Base]=
{
catch={
CATCH_TYPE.eXianTuChengJiuTaskProgress,
CATCH_TYPE.eZongMenXianTuReward,
CATCH_TYPE.eMoney,
CATCH_TYPE.eGuBaoSkillLevelChange,
CATCH_TYPE.eZongMenXianTuStage,
CATCH_TYPE.eZongMenXianTuAnimation,
CATCH_TYPE.eXianZhi,
CATCH_TYPE.eXianGuanTeQuan,
},
func=function(catchType,...)
return xiantuchengjiuModel:getZMXTReddot()or xiantuchengjiuModel:getXTCJReddot()or xiantuchengjiuModel:getFSDTReddot()or xianzhiModel:getReddot()
end,
},
}


xiantuchengjiuSheetReddot_ZongMenXianTu=reddotSheetBase.new({classname='xiantuchengjiuSheetReddot_ZongMenXianTu'})

xiantuchengjiuSheetReddot_ZongMenXianTu.reddot_type=REDDIT_TYPE.eXianTuChengJiu_ZongMenXianTu

xiantuchengjiuSheetReddot_ZongMenXianTu.reddot_config=
{
[REDDIT_SUB_TYPE.sXianTuChengJiu_ZongMenXianTu]=
{
catch={
CATCH_TYPE.eXianTuChengJiuTaskProgress,CATCH_TYPE.eZongMenXianTuReward,CATCH_TYPE.eZongMenXianTuStage,CATCH_TYPE.eZongMenXianTuAnimation
},
func=function(catchType,...)
return xiantuchengjiuModel:getZMXTReddot()
end,
},
}


xiantuchengjiuSheetReddot_XianTuChengJiu=reddotSheetBase.new({classname='xiantuchengjiuSheetReddot_XianTuChengJiu'})

xiantuchengjiuSheetReddot_XianTuChengJiu.reddot_type=REDDIT_TYPE.eXianTuChengJiu_XianTuChengJiu

xiantuchengjiuSheetReddot_XianTuChengJiu.reddot_config=
{
[REDDIT_SUB_TYPE.sXianTuChengJiu_XianTuChengJiu]=
{
catch={
CATCH_TYPE.eXianTuChengJiuTaskProgress,CATCH_TYPE.eMoney,CATCH_TYPE.eGuBaoSkillLevelChange
},
func=function(catchType,...)
return xiantuchengjiuModel:getXTCJReddot()
end,
},
}


xiantuchengjiuSheetReddot_FeiShengDaoTu=reddotSheetBase.new({classname='xiantuchengjiuSheetReddot_FeiShengDaoTu'})

xiantuchengjiuSheetReddot_FeiShengDaoTu.reddot_type=REDDIT_TYPE.eXianTuChengJiu_FeiShengDaoTu

xiantuchengjiuSheetReddot_FeiShengDaoTu.reddot_config=
{
[REDDIT_SUB_TYPE.sXianTuChengJiu_FeiShengDaoTu]=
{
catch={
CATCH_TYPE.eXianTuChengJiuTaskProgress,CATCH_TYPE.eZongMenXianTuStage
},
func=function(catchType,...)
return xiantuchengjiuModel:getFSDTReddot()
end,
},
}


xianzhiSheetReddot=reddotSheetBase.new({classname='xianzhiSheetReddot'})

xianzhiSheetReddot.reddot_type=REDDIT_TYPE.eXianZhi

xianzhiSheetReddot.reddot_config=
{
[REDDIT_SUB_TYPE.sXianZhi]=
{
catch={
CATCH_TYPE.eXianZhi,
CATCH_TYPE.eXianGuanTeQuan,
},
func=function(catchType,...)
return xianzhiModel:getReddot()
end,
},
}