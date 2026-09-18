






bulediamondSheetReddot=reddotSheetBase.new({classname='bulediamondSheetReddot'})

bulediamondSheetReddot.reddot_type=REDDIT_TYPE.eBlueDiamond

bulediamondSheetReddot.reddot_config=
{
[REDDIT_SUB_TYPE.sBlueDiamondDailyGift]=
{
catch={

CATCH_TYPE.eXianGouLiBao,

},
func=function(catchType,...)
return rechargeModel:checkBlueDiamondDailyGiftReddot()
end,
},

[REDDIT_SUB_TYPE.sBlueDiamondGrowUpGift]=
{
catch={

CATCH_TYPE.eXianGouLiBao,

},
func=function(catchType,...)
return rechargeModel:checkBlueDiamondGrowUpGiftReddot()
end,
},

[REDDIT_SUB_TYPE.sBlueDiamondNewBieGift]=
{
catch={

CATCH_TYPE.eXianGouLiBao,

},
func=function(catchType,...)
return rechargeModel:checkBlueDiamondNewBieGiftReddot()
end,
},

}
