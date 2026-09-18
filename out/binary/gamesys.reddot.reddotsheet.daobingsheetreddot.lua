local classname='daobingSheetReddot'

daobingSheetReddot=reddotSheetBase.new({classname=classname})

daobingSheetReddot.reddot_type=REDDIT_TYPE.eDaoBing

daobingSheetReddot.reddot_config=
{
[REDDIT_SUB_TYPE.sDaoBingCombine]=
{
catch={
CATCH_TYPE.eDaoBingCombine,
},
func=function(catchType)
return daobingHelper.isCanAnyCombine()
end,
},
}
