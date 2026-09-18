
wanBaoXunBaoDuiReddot=reddotSheetBase.new({classname='wanBaoXunBaoDuiReddot'})

wanBaoXunBaoDuiReddot.reddot_type=REDDIT_TYPE.eWanBaoXunBaoDui

wanBaoXunBaoDuiReddot.reddot_config=
{
[REDDIT_SUB_TYPE.sWanBaoXunBaoDui_MT]=
{
catch={
CATCH_TYPE.eWanBaoXunBaoDuiTask,
CATCH_TYPE.eWanBaoXunBaoDuiRecruit,
},
func=function(catchType,...)
wanBaoXunBaoDuiController:refreshMTBuildHud()
return UIFullWanBaoXunBaoDuiController:checkMTReddot()
end,
},
[REDDIT_SUB_TYPE.sWanBaoXunBaoDui_GY]=
{
catch={

},
func=function(catchType,...)
return UIFullWanBaoXunBaoDuiController:checkGYReddot()
end,
},
[REDDIT_SUB_TYPE.sWanBaoXunBaoDui_DZ]=
{
catch={
CATCH_TYPE.eWanBaoXunBaoDuiRecruit,
},
func=function(catchType,...)
return false
end,
},
[REDDIT_SUB_TYPE.sWanBaoXunBaoDui_TQ]=
{
catch={
CATCH_TYPE.eWanBaoXunBaoDuiRecruit,
},
func=function(catchType,...)
return false
end,
},
}