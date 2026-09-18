






mojiePreviewExtendReddot=reddotSheetBase.new({classname='mojiePreviewExtendReddot'})

mojiePreviewExtendReddot.reddot_type=REDDIT_TYPE.eMJYGExtend

mojiePreviewExtendReddot.reddot_config=
{
[REDDIT_SUB_TYPE.sMJYGTJYX]=
{
catch={
CATCH_TYPE.eMJYGExtend
},
func=function(catchType,...)
return MojiePreviewExtendController.checkReddot()
end,
},
[REDDIT_SUB_TYPE.sMJYGBZZM]=
{
catch={
CATCH_TYPE.eMJYGExtend
},
func=function(catchType,...)
return MojiePreviewExtendController.checkAllBZZhengMoReddot()
end,
},
[REDDIT_SUB_TYPE.sMJYGMZYH]=
{
catch={
CATCH_TYPE.eMJYGExtend
},
func=function(catchType,...)
return MojiePreviewExtendController.checkMzyhRewardReddot()
end,
},
}