local classname='tezhitujianSheetReddot'

tezhitujianSheetReddot=reddotSheetBase.new({classname=classname})

tezhitujianSheetReddot.reddot_type=REDDIT_TYPE.eTeZhiTuJian

tezhitujianSheetReddot.reddot_config=
{
[REDDIT_SUB_TYPE.sTeZhiTuJian]=
{
catch={
CATCH_TYPE.eTeZhiTuJian,
},
func=function(catchType,...)
return TeZhiTuJianController:checkSysRedddot()
end,
},
}
