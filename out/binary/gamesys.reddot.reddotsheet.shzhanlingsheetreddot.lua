






shZhanLingSheetReddot=reddotSheetBase.new({classname='shZhanLingSheetReddot'})

shZhanLingSheetReddot.reddot_type=REDDIT_TYPE.eSHZhanLing

shZhanLingSheetReddot.reddot_config=
{
[REDDIT_SUB_TYPE.sSHZhanLing]=
{
catch={

CATCH_TYPE.eSHZhanLing,

},
func=function(catchType,...)
return zhengzhanshanhaiModel:checkSHZhanLingReddot()
end,
},
[REDDIT_SUB_TYPE.sSaiJiXianZang]=
{
catch={

CATCH_TYPE.eSJXianZang,

},
func=function(catchType,...)
return zhengzhanshanhaiModel:checkSJXianZangReddot()
end,
},
}