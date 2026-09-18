






welfareSheetReddot=reddotSheetBase.new({classname='welfareSheetReddot'})

welfareSheetReddot.reddot_type=REDDIT_TYPE.eWelfare

welfareSheetReddot.reddot_config=
{
[REDDIT_SUB_TYPE.sDailySignIn]=
{
catch={

CATCH_TYPE.eWelfare,

},
func=function(catchType,...)
return welfareModel:checkDailySignInReddot()
end,
},
[REDDIT_SUB_TYPE.sSevenDaySignIn]=
{
catch={

CATCH_TYPE.eWelfare,

},
func=function(catchType,...)
return welfareModel:checkSevenDaySignInReddot()
end,
},
[REDDIT_SUB_TYPE.sZongmenLevelInvestor]=
{
catch={

CATCH_TYPE.eWelfare,
CATCH_TYPE.eZongMenLevel,

},
func=function(catchType,...)
return welfareModel:checkZongmenLevelInvestorReddot()
end,
},
[REDDIT_SUB_TYPE.sZongmenLevelInvestor2]=
{
catch={

CATCH_TYPE.eWelfare,
CATCH_TYPE.eZongMenLevel,

},
func=function(catchType,...)
return welfareModel:checkZongmenLevelInvestorReddot2()
end,
},
[REDDIT_SUB_TYPE.sWelfareCdKey]=
{
catch={

CATCH_TYPE.eWelfare,
},
func=function(catchType,...)
return welfareModel:checkCdKeyReddot()
end,
},
[REDDIT_SUB_TYPE.sWelfareKaiZongZengLi]=
{
catch={
CATCH_TYPE.eWelfare,
CATCH_TYPE.eZongMenLevel,
CATCH_TYPE.eDiscipleJJ,
},
func=function(catchType,...)
return welfareModel:checkKaiZongReddot()
end,
},











[REDDIT_SUB_TYPE.sDailyRebate]=
{
catch={
CATCH_TYPE.eWelfare,
},
func=function(catchType,...)
return welfareModel:checkDailyRebateEnterReddot()
end,
},
[REDDIT_SUB_TYPE.sWelfareInvitationCode]=
{
catch={
CATCH_TYPE.eWelfare,
},
func=function(catchType,...)
return welfareModel:checkInvitationCodeEnterReddot()
end,
},
[REDDIT_SUB_TYPE.sXianYuanShare]=
{
catch={
CATCH_TYPE.eWelfare,
},
func=function(catchType,...)
return welfareModel:checkXianYuanShareOpen()and xianyuanShareModel:checkSharedTimes()and(xianyuanShareModel:getReddot()or xianyuanShareModel:getValibTimes()>0)
end,
},
[REDDIT_SUB_TYPE.sGuanZhuAct]=
{
catch={
CATCH_TYPE.eWelfare,
},
func=function(catchType,...)
return welfareModel:checkGuanZhuActReddot()
end,
},
[REDDIT_SUB_TYPE.sWeekendWelfare]=
{
catch={
CATCH_TYPE.eWelfare,
CATCH_TYPE.eNewDay,
},
func=function(catchType,...)
return welfareModel:checkWeekendWelfareReddot()
end,
},
[REDDIT_SUB_TYPE.sHuiGuiBangDing]=
{
catch={
CATCH_TYPE.eWelfare,
},
func=function(catchType,...)
return welfareModel:checkHuiGuiBangDingReddot()
end,
},
[REDDIT_SUB_TYPE.sXianYouZhaoHui]=
{
catch={
CATCH_TYPE.eWelfare,
},
func=function(catchType,...)
return welfareModel:checkXianYouZhaoHuiReddot()
end,
},
[REDDIT_SUB_TYPE.sWXGameCircle]=
{
catch={
CATCH_TYPE.eWelfare,
},
func=function(catchType,...)
return welfareModel:checkWXGameCircleReddot()
end,
},
[REDDIT_SUB_TYPE.sActivityCalendar]=
{
catch={
CATCH_TYPE.eWelfare,
},
func=function(catchType,...)
return welfareController:checkActivityCalendarReddot()
end,
},
[REDDIT_SUB_TYPE.eSheQuAct]=
{
catch={
CATCH_TYPE.eSheQuAct,
},
func=function(catchType,...)
return shequModel:hasReddot()
end,
},
[REDDIT_SUB_TYPE.eSheQuAct2]=
{
catch={
CATCH_TYPE.eSheQuAct,
},
func=function(catchType,...)
return shequModel:hasReddot2()
end,
},
[REDDIT_SUB_TYPE.eSheQuAct3]=
{
catch={
CATCH_TYPE.eSheQuAct,
},
func=function(catchType,...)
return shequModel:hasReddot3()
end,
},
[REDDIT_SUB_TYPE.sWXAddReward]=
{
catch={
CATCH_TYPE.eWelfare,
},
func=function(catchType,...)
return welfareController:checkWXAddRewardReddot()
end,
},
[REDDIT_SUB_TYPE.eChangeAct]=
{
catch={
CATCH_TYPE.eChangeAct,
},
func=function(catchType,...)
return ChangeActController:checkHdReddotAll()
end,
},
[REDDIT_SUB_TYPE.eChangeBao]=
{
catch={
CATCH_TYPE.eChangeBao,
},
func=function(catchType,...)
return ChangeActController:checkHBZYReddot()
end,
},
}