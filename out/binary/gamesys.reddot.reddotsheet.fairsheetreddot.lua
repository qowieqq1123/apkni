






fairSheetReddot=reddotSheetBase.new({classname='fairSheetReddot'})

fairSheetReddot.reddot_type=REDDIT_TYPE.eFair

fairSheetReddot.reddot_config=
{
[REDDIT_SUB_TYPE.sHeiShi]=
{
catch={

CATCH_TYPE.eFair,

},
func=function(catchType,...)
return fairModel:checkGuiShiReddot()
end,
},

}