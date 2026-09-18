









gongfaBuildHudSheetReddot=reddotSheetBase.new({classname='gongfaBuildHudSheetReddot',subType_=REDDIT_SUB_TYPE.sGongFaBuildHud})

gongfaBuildHudSheetReddot.reddot_type=REDDIT_TYPE.eGongFaBuildHud

gongfaBuildHudSheetReddot.reddot_config=
{

[gongfaBuildHudSheetReddot:getSubReddotKey(1)]=
{
catch={
CATCH_TYPE.eItem,
},
func=function(catchType,...)
return UIGongFaModel:checkAllActiveReddot()
end,
},

[gongfaBuildHudSheetReddot:getSubReddotKey(2)]=
{
catch={
CATCH_TYPE.eGongFa,
},
func=function(catchType,...)
return UIGongFaModel:checkAllRewardReddot()
end,
},

[gongfaBuildHudSheetReddot:getSubReddotKey(3)]=
{
catch={
CATCH_TYPE.eMoney,
CATCH_TYPE.eItem,
CATCH_TYPE.eGongFa,
},
func=function(catchType,...)
return UIGongFaModel:checkAllStudyReddot()
end,
},
}
