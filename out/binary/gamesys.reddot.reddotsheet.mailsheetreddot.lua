






mailSheetReddot=reddotSheetBase.new({classname='mailSheetReddot'})

mailSheetReddot.reddot_type=REDDIT_TYPE.eMail

mailSheetReddot.reddot_config=
{
[REDDIT_SUB_TYPE.sMailBase]=
{
catch={

CATCH_TYPE.eMail,

},
func=function(catchType,...)
return mailController:hasReddot()
end,
},


}
