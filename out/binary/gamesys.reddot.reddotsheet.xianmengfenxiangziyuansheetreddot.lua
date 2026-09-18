
xianmengfenxiangziyuanSheetReddot=reddotSheetBase.new({classname='xianmengfenxiangziyuanSheetReddot'})

xianmengfenxiangziyuanSheetReddot.reddot_type=REDDIT_TYPE.eXMFXZY

xianmengfenxiangziyuanSheetReddot.reddot_config=
{
[REDDIT_SUB_TYPE.sXMFXZYBase]=
{
catch={
CATCH_TYPE.eXMFXZYSeek,
},
func=function(catchType,...)
return xianmengModel:getReddot_fenxiangziyuan()
end,
},

[REDDIT_SUB_TYPE.sXWLFenXiangZiYuan]=
{
catch={
CATCH_TYPE.eXWLfeiheng,
},
func=function(catchType,...)
return FeiShengTaiModel:ShowHelpReddot()
end,
},

[REDDIT_SUB_TYPE.sXianMengZengLi]=
{
catch={
CATCH_TYPE.eXMZengLi,
},
func=function(catchType,...)
return xianMengBaoXiangModel:getGiftReddot(0)
end,
},
}