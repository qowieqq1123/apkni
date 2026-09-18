






xianJieMXSLLogReddot=reddotSheetBase.new({classname='xianJieMXSLLogReddot'})

xianJieMXSLLogReddot.reddot_type=REDDIT_TYPE.eXianJieMXSLLog

xianJieMXSLLogReddot.reddot_config=
{
[REDDIT_SUB_TYPE.sXianJieMXSLSingleLog]=
{
catch={
CATCH_TYPE.eXianJieLog
},
func=function(catchType,...)
local isReddot=xianjieModel:get_MXSLSingleReddot()or xianjieModel:Check_mxslSingleLogNewFlag()
return isReddot
end,
},

}