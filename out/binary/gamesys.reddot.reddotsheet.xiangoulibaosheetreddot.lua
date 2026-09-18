






xiangoulibaoSheetReddot=reddotSheetBase.new({classname='xiangoulibaoSheetReddot'})

xiangoulibaoSheetReddot.reddot_type=REDDIT_TYPE.eXianGouLiBao

xiangoulibaoSheetReddot.reddot_config=
{
[REDDIT_SUB_TYPE.sXianGouLiBao]=
{
catch={

CATCH_TYPE.eXianGouLiBao,

},
func=function(catchType,...)
return rechargeModel:checkDayPackReddot()
end,
},

[REDDIT_SUB_TYPE.sXianGouWeekLiBao]=
{
catch={

CATCH_TYPE.eXianGouLiBao,

},
func=function(catchType,...)
return rechargeModel:checkWeekPackReddot()
end,
},

[REDDIT_SUB_TYPE.sXianGouMonthLiBao]=
{
catch={

CATCH_TYPE.eXianGouLiBao,

},
func=function(catchType,...)
return rechargeModel:checkMonthPackReddot()
end,
},

[REDDIT_SUB_TYPE.sXianGouGuangGaoLiBao]=
{
catch={

CATCH_TYPE.eXianGouLiBao,

},
func=function(catchType,...)
return rechargeModel:checkGuangGaoPackReddot()
end,
},

[REDDIT_SUB_TYPE.sMonthInvestor]=
{
catch={

CATCH_TYPE.eXianGouLiBao,
CATCH_TYPE.eWeekCard,
CATCH_TYPE.eNewDay,
CATCH_TYPE.eZongMenLevel,
CATCH_TYPE.eSystemOpen,
},
func=function(catchType,...)
return rechargeModel:checkMonthCardEnterReddot()or rechargeModel:checkWeekCardReddot()
end,
},

[REDDIT_SUB_TYPE.sRechargeDailyTeHui]=
{
catch={

CATCH_TYPE.eXianGouLiBao,
CATCH_TYPE.eNewDay,

},
func=function(catchType,...)
return rechargeModel:checkDailyTeHuiEnterReddot()
end,
},

[REDDIT_SUB_TYPE.sRechargeDailyTeHuiSingleDay]=
{
catch={

CATCH_TYPE.eXianGouLiBao,
CATCH_TYPE.eNewDay,

},
func=function(catchType,...)
return rechargeModel:checkDailyTeHuiSingleDayEnterReddot()
end,
},
[REDDIT_SUB_TYPE.sPushGift]=
{
catch={

CATCH_TYPE.efreshGift,
},
func=function(catchType,...)
return pushGiftTwoModel:hasNewGift()or
pushGiftThreeModel:hasNewGift()
end,
},
[REDDIT_SUB_TYPE.sZhenBaoGe]=
{
catch={

CATCH_TYPE.eXianGouLiBao,
},
func=function(catchType,...)
return rechargeModel:checkZhenBaoGeReddot()
end,
},
[REDDIT_SUB_TYPE.sSelectLiBao]=
{
catch={

CATCH_TYPE.eSelectLiBao,
},
func=function(catchType,...)
return rechargeModel:checkSelectLiBaoEnterReddot()
end,
},


}
