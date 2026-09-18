






lingZhenYanJiuSheetReddot=reddotSheetBase.new({classname='lingZhenYanJiuSheetReddot'})

lingZhenYanJiuSheetReddot.reddot_type=REDDIT_TYPE.eLingZhenYanJiu

lingZhenYanJiuSheetReddot.reddot_config=
{
[REDDIT_SUB_TYPE.sLingZhenYanJiu]=
{
catch={

CATCH_TYPE.eShiLianTaLayerChange,
CATCH_TYPE.eLingTuYanJiu,
CATCH_TYPE.eItem,
CATCH_TYPE.eMoney,
},
func=function(catchType,...)
return UIYuFuLingZhenControl:checkAllZhenTyReseach()
end,
},


}
