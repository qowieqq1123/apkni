






hunqitaiReddot=reddotSheetBase.new({classname='hunqitaiReddot'})

hunqitaiReddot.reddot_type=REDDIT_TYPE.eHunQiTai

hunqitaiReddot.reddot_config=
{
[REDDIT_SUB_TYPE.eHunQiTai]=
{
catch={
CATCH_TYPE.eHunQiTai,
},
func=function(catchType,...)
return LunHuiDianModel:firstHQTReddot()
end,
},
}