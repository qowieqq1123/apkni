






friendSheetReddot=reddotSheetBase.new({classname='friendSheetReddot'})

friendSheetReddot.reddot_type=REDDIT_TYPE.eFriend

friendSheetReddot.reddot_config=
{
[REDDIT_SUB_TYPE.sFriendBase]=
{
catch={

CATCH_TYPE.eFriend,

},
func=function(catchType,...)
return friendModel:hasApply()
end,
},
}

friendPointSheetReddot=reddotSheetBase.new({classname='friendPointSheetReddot'})

friendPointSheetReddot.reddot_type=REDDIT_TYPE.eFriendPoint

friendPointSheetReddot.reddot_config=
{
[REDDIT_SUB_TYPE.sFriendPoint]=
{
catch={

CATCH_TYPE.eFriendPoint,

},
func=function(catchType,...)
return friendModel:hasSub1Reddot()
end,
},
}
