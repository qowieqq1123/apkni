
yyhyshopReddot=reddotSheetBase.new({classname='yyhyshopReddot'})

yyhyshopReddot.reddot_type=REDDIT_TYPE.eYiYuHuiYouShop

yyhyshopReddot.reddot_config=
{
[REDDIT_SUB_TYPE.eYiYuHuiYouShopShengji]=
{
catch={
CATCH_TYPE.eYiYuHuiYouShengJiChange,
},
func=function(catchType,...)
return YiYuHuiYouController:yyhyShopShengjiReddot()
end,
},
}