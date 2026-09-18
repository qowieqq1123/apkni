






xianJieLogReddot=reddotSheetBase.new({classname='xianJieLogReddot'})

xianJieLogReddot.reddot_type=REDDIT_TYPE.eXianJieLog

xianJieLogReddot.reddot_config=
{
[REDDIT_SUB_TYPE.sXianJieResourceLog]=
{
catch={
CATCH_TYPE.eXianJieLog
},
func=function(catchType,...)
return xianjieModel:get_ResourceReddot()
end,
},
[REDDIT_SUB_TYPE.sXianJieMonsterLog]=
{
catch={
CATCH_TYPE.eXianJieLog
},
func=function(catchType,...)
return xianjieModel:get_monsterReddot()
end,
},
[REDDIT_SUB_TYPE.sXianJieSearchLog]=
{
catch={
CATCH_TYPE.eXianJieLog
},
func=function(catchType,...)
return xianjieModel:get_SearchReddot()
end,
},
[REDDIT_SUB_TYPE.sXianJieArenaLog]=
{
catch={
CATCH_TYPE.eXianJieLog
},
func=function(catchType,...)
local isReddot=xianjieModel:get_ArenaReddot()or xianjieModel:Check_arenaLogNewFlag()
return isReddot
end,
},
[REDDIT_SUB_TYPE.sXianJieMoGongZhengDuoLog]=
{
catch={
CATCH_TYPE.eXianJieLog
},
func=function(catchType,...)
local isReddot=xianjieModel:get_MongGongReddot()or xianjieModel:Check_moGongLogNewFlag()
return isReddot
end,
},

}