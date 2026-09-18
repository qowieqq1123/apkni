






yanDaoTaiReddot=reddotSheetBase.new({classname='yanDaoTaiReddot'})

yanDaoTaiReddot.reddot_type=REDDIT_TYPE.eYanDaoTai

yanDaoTaiReddot.reddot_config=
{
[REDDIT_SUB_TYPE.sYanDaoTaiCC]=
{
catch={

CATCH_TYPE.eYanDaoTaiChange,

},
func=function(catchType,...)
return yandaotaiModel:getTreeTypeReddot(YDT_TREE_TYPE.eChuanCheng)
end,
},
[REDDIT_SUB_TYPE.sYanDaoTaiDZ]=
{
catch={

CATCH_TYPE.eYanDaoTaiChange,

},
func=function(catchType,...)
return yandaotaiModel:getTreeTypeReddot(YDT_TREE_TYPE.eDaoZang)
end,
},
}