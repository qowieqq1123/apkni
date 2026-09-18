






cangJingGeXinFaSheetReddot=reddotSheetBase.new({classname='cangJingGeXinFaSheetReddot'})

cangJingGeXinFaSheetReddot.reddot_type=REDDIT_TYPE.eCangJingGeXinFa

cangJingGeXinFaSheetReddot.reddot_config=
{
[REDDIT_SUB_TYPE.sCangJingGeXianShu]=
{
catch={
CATCH_TYPE.eItem,
CATCH_TYPE.eMoney,
},
func=function(catchType,...)
return UIDiscipleModel:checkXinFaTypeReddot(1)
end,
},
[REDDIT_SUB_TYPE.sCangJingGeMoGong]=
{
catch={
CATCH_TYPE.eItem,
CATCH_TYPE.eMoney,
},
func=function(catchType,...)
return UIDiscipleModel:checkXinFaTypeReddot(2)
end,
},
}