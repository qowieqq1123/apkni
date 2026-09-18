local classname='wenDingCangQiongQuFuActSheetReddot'

wenDingCangQiongQuFuActSheetReddot=reddotSheetBase.new({classname=classname})

wenDingCangQiongQuFuActSheetReddot.reddot_type=REDDIT_TYPE.eWDCQQFAct

wenDingCangQiongQuFuActSheetReddot.reddot_config=
{
[REDDIT_SUB_TYPE.sWDCQQFActReward]=
{
catch={
CATCH_TYPE.eWDCQQFAct,
},
func=function(catchType)
return WDCQController.checkQuFuEnterReddot()
end,
},
}
