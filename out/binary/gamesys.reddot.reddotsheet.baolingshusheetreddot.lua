






baolingshuSheetReddot=reddotSheetBase.new({classname='baolingshuSheetReddot'})

baolingshuSheetReddot.reddot_type=REDDIT_TYPE.eBaoLingShu

baolingshuSheetReddot.reddot_config=
{
[REDDIT_SUB_TYPE.sBaoLingShu]=
{
catch={
CATCH_TYPE.eBLSPickUp,
},
func=function(catchType,...)
return baoLingShuModel:checkBaolingshuEnterReddot()
end,
},
[REDDIT_SUB_TYPE.sXunBaoShiLian]=
{
catch={
CATCH_TYPE.eBaoLingShuXBSL,
},
func=function(catchType,...)
return xunBaoShiLianModel:checkXBSLEnterReddot()
end,
},
[REDDIT_SUB_TYPE.sQiYuanShu]=
{
catch={
CATCH_TYPE.eQiYuanShu,
},
func=function(catchType,...)
return qiYuanShuModel:checkQiYuanShuEnterReddot()
end,
},
}