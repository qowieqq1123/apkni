
fazeBaoJianReddot=reddotSheetBase.new({classname='fazeBaoJianReddot'})

fazeBaoJianReddot.reddot_type=REDDIT_TYPE.eFaZeBaoDian

fazeBaoJianReddot.reddot_config=
{
[REDDIT_SUB_TYPE.sFaZeBaoDian]=
{
catch={

CATCH_TYPE.eFaZeBaoDian,

},
func=function(catchType,...)
return mysteryWeekActivityModel:checkAllReddot()or false
end,
},
}




















