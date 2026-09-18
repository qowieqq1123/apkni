






xmdgPassSheetReddot=reddotSheetBase.new({classname='xmdgPassSheetReddot'})

xmdgPassSheetReddot.reddot_type=REDDIT_TYPE.eXMDGPass

xmdgPassSheetReddot.reddot_config=
{
[REDDIT_SUB_TYPE.sXMDGPass]=
{
catch={
CATCH_TYPE.eXMDGPass,
},
func=function(catchType,...)
return xianmengdigongModel:checkPassReddot()
end,
},
}