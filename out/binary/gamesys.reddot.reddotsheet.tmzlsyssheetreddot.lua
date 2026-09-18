






tmzlSysSheetReddot=reddotSheetBase.new({classname='tmzlSysSheetReddot'})

tmzlSysSheetReddot.reddot_type=REDDIT_TYPE.eTMZLsys

tmzlSysSheetReddot.reddot_config=
{
[REDDIT_SUB_TYPE.sTMZLsys]=
{
catch={

CATCH_TYPE.eTMZLsys,

},
func=function(catchType,...)
local reddot,dzId=tianmingzengliModel:getTMZLEnterReddot()
return reddot
end,
},

}