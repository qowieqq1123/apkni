






qiyuanshuSheetReddot=reddotSheetBase.new({classname='qiyuanshuSheetReddot'})

qiyuanshuSheetReddot.reddot_type=REDDIT_TYPE.eQiYuanShu

qiyuanshuSheetReddot.reddot_config=
{
[REDDIT_SUB_TYPE.sQiYuanShop]=
{
catch={
CATCH_TYPE.eQiYuanShu,
},
func=function(catchType,...)
return qiYuanShuModel:checkQiYuanShopReddot()
end,
},
}