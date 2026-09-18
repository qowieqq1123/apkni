






storeHouseSheetReddot=reddotSheetBase.new({classname='storeHouseSheetReddot'})

storeHouseSheetReddot.reddot_type=REDDIT_TYPE.eStoreHouseBase

storeHouseSheetReddot.reddot_config=
{
[REDDIT_SUB_TYPE.sStoreHouseBase]=
{
catch={

CATCH_TYPE.eItem,
CATCH_TYPE.eInitBagData,

},
func=function(catchType,...)
return itemBagModel:checkReddot()or
daobingHelper.isCanAnyCombine()or
lingzhenBagModel:checkReddot()
end,
},
}