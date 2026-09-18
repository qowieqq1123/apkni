






xainjiefumoReddot=reddotSheetBase.new({classname='xainjiefumoReddot'})

xainjiefumoReddot.reddot_type=REDDIT_TYPE.eXianjieFuMo

xainjiefumoReddot.reddot_config=
{
[REDDIT_SUB_TYPE.sXJFMreward_Target]=
{
catch={
CATCH_TYPE.eXJFM_Target
},
func=function(catchType,...)
return XianJieFuMoController:checkTargetReddot()
end,
},
}