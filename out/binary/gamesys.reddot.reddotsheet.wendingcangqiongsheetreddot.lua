local classname='wenDingCangQiongSheetReddot'

wenDingCangQiongSheetReddot=reddotSheetBase.new({classname=classname})

wenDingCangQiongSheetReddot.reddot_type=REDDIT_TYPE.eWenDingCangQiong

wenDingCangQiongSheetReddot.reddot_config=
{
[REDDIT_SUB_TYPE.sWenDingCangQiong]=
{
catch={
CATCH_TYPE.eWenDingCangQiong,
},
func=function(catchType)
return WDCQController.checkSysReddotEx()
end,
},
}
