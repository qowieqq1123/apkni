local classname='xianbaoSheetReddot'

xianbaoSheetReddot=reddotSheetBase.new({classname=classname})

xianbaoSheetReddot.reddot_type=REDDIT_TYPE.eXianBao

xianbaoSheetReddot.reddot_config=
{
[REDDIT_SUB_TYPE.sXBBag]=
{
catch={
CATCH_TYPE.eXianBao,
CATCH_TYPE.eItem,
},
func=function(catchType,...)
return xianbaoModel:getBagReddot()
end,
},
[REDDIT_SUB_TYPE.sXBTujian]=
{
catch={
CATCH_TYPE.eXianBao,
CATCH_TYPE.eItem,
},
func=function(catchType,...)
return xianbaoModel:getTujianReddot()
end,
},
}
