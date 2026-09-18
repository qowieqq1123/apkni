






dailyTaskSheetReddot=reddotSheetBase.new({classname='dailyTaskSheetReddot'})

dailyTaskSheetReddot.reddot_type=REDDIT_TYPE.eDailyTask

dailyTaskSheetReddot.reddot_config=
{
[REDDIT_SUB_TYPE.sDailyTaskBase]=
{
catch={

CATCH_TYPE.eDailyTask,

},
func=function(catchType,...)
return taskModel:checkDailyTaskReddot()
end,
},
[REDDIT_SUB_TYPE.sTaskreddot]=
{
catch={

CATCH_TYPE.eTaskreddot,

},
func=function(catchType,...)
return taskModel:GetNewTaskReddot()
end,
},
}
