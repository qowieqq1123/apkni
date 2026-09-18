






fulufangSheetReddot=reddotSheetBase.new({classname='fulufangSheetReddot'})

fulufangSheetReddot.reddot_type=REDDIT_TYPE.eFuLu

fulufangSheetReddot.reddot_config=
{
[REDDIT_SUB_TYPE.sFuLuReward]=
{
catch={

CATCH_TYPE.eFuluReward,

},
func=function(catchType,...)
return UIFuLuFangModel:checkHaveReward()
end,
},

[REDDIT_SUB_TYPE.sYuFuMake]=
{
catch={

CATCH_TYPE.eItem,

},
func=function(catchType,...)
return UIFuLuFangModel:checkCanMakeAll()
end,
},

}
