








sectPalaceSheetReddot=reddotSheetBase.new({classname='sectPalaceSheetReddot'})

sectPalaceSheetReddot.reddot_type=REDDIT_TYPE.eSectPalace

sectPalaceSheetReddot.reddot_config=
{
[REDDIT_SUB_TYPE.sSectPalaceInfo]=
{
catch={
CATCH_TYPE.eSectPalaceReddotChange,
},
func=function(catchType,...)
return UISectPalaceController:checkSectPalaceInfoReddot()
end,
},
[REDDIT_SUB_TYPE.sGuildOrder]=
{
catch={
CATCH_TYPE.eGuildOrderReddotChange,
},
func=function(catchType,...)
return guildOrderModel:checkReddot()
end,
},
}
