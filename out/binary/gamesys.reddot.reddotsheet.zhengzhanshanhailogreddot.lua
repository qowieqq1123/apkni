






zhengZhanShanHaiLogReddot=reddotSheetBase.new({classname='zhengZhanShanHaiLogReddot'})

zhengZhanShanHaiLogReddot.reddot_type=REDDIT_TYPE.eZZSHLog

zhengZhanShanHaiLogReddot.reddot_config=
{
[REDDIT_SUB_TYPE.szzshResourceLog]=
{
catch={

CATCH_TYPE.eZZSHLog

},
func=function(catchType,...)
return zhengzhanshanhaiModel:get_ResourceReddot()
end,
},
[REDDIT_SUB_TYPE.szzshMonsterLog]=
{
catch={

CATCH_TYPE.eZZSHLog

},
func=function(catchType,...)
return zhengzhanshanhaiModel:get_monsterReddot()
end,
},
[REDDIT_SUB_TYPE.szzshLingShanLog]=
{
catch={

CATCH_TYPE.eZZSHLog

},
func=function(catchType,...)
return zhengzhanshanhaiModel:get_LingShanReddot()
end,
},
}