
totalTouZiActivitySheetReddot=reddotSheetBase.new({classname='totalTouZiActivitySheetReddot'})

totalTouZiActivitySheetReddot.reddot_type=REDDIT_TYPE.eTotalTouZiActivity

totalTouZiActivitySheetReddot.reddot_config=
{
[REDDIT_SUB_TYPE.sXianShu]=
{
catch={
CATCH_TYPE.eXianShu,
},
func=function(catchType,...)
return UIXianShuControl:checkReddot()
end,
},
[REDDIT_SUB_TYPE.sLoginReward]=
{
catch={
CATCH_TYPE.eWelfare,
},
func=function(catchType,...)
return welfareModel:checkLoginRewardReddot()
end,
},
[REDDIT_SUB_TYPE.sXianDiTouZi]=
{
catch={
CATCH_TYPE.eXianDiTouZi,
},
func=function(catchType,...)
return mysteryWeekActivityModel:checkXuanShangReddot()or false
end,
},
[REDDIT_SUB_TYPE.sLunDaoRewards]=
{
catch={
CATCH_TYPE.eLunDaoRewards,
},
func=function(catchType,...)
return UIXianFaWenDaoControl:checkInvestReddot()
end,
},
[REDDIT_SUB_TYPE.sWuXingShengDianRewards]=
{
catch={
CATCH_TYPE.eWXSDRewards,
},
func=function(catchType,...)
local wxdId=wuXingDianConfig.getSDType()
return wuXingDianModel:hasAnyPrize(wxdId)
end,
},
[REDDIT_SUB_TYPE.sMYZSTXZ]=
{
catch={
CATCH_TYPE.eMYZSTXZ,
},
func=function(catchType,...)
return myzsModel:getTxzReddot()
end,
},
}