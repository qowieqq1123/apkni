






schoolSheetReddot=reddotSheetBase.new({classname='schoolSheetReddot'})

schoolSheetReddot.reddot_type=REDDIT_TYPE.eSchoolReward

schoolSheetReddot.reddot_config=
{
[REDDIT_SUB_TYPE.sSchoolReward]=
{
catch={

CATCH_TYPE.eSchool,

},
func=function(catchType,...)
return UISchoolModel:checkReward()
end,
},


}
