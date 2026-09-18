
xianGongSheetReddot=reddotSheetBase.new({classname='xianGongSheetReddot'})

xianGongSheetReddot.reddot_type=REDDIT_TYPE.eXianGong

xianGongSheetReddot.reddot_config=
{
[REDDIT_SUB_TYPE.sXianGongBangYu]=
{
catch={
CATCH_TYPE.eXianGongBangYu,
CATCH_TYPE.eXianGuanJingXuan,
CATCH_TYPE.eXianGuanTeQuan,
CATCH_TYPE.eXJFaction_XianGong,
},
func=function(catchType,...)
return XianGongController.getReddot()
end,
},
[REDDIT_SUB_TYPE.sXianGongXianGuan]=
{
catch={
CATCH_TYPE.eXianGuanTeQuan,
},
func=function(catchType,...)
return xianguanController.getReddot()
end,
},
[REDDIT_SUB_TYPE.sXianGongFaction]=
{
catch={
CATCH_TYPE.eXJFaction_XianGong,
},
func=function(catchType,...)
return xjFactionNPCModel:getFactionReddot(xianjieForceType.eXianGong)
end,
}
}
