
playerSettingSheetReddot=reddotSheetBase.new({classname='playerSettingSheetReddot'})

playerSettingSheetReddot.reddot_type=REDDIT_TYPE.ePlayerSetting

playerSettingSheetReddot.reddot_config=
{
[REDDIT_SUB_TYPE.sShowcaseTeam]=
{
catch={
CATCH_TYPE.eShowcaseTeam,
},
func=function(catchType,...)
local ret=UISettingModel:checkRedDotShowcase()
return ret
end,
},

}
