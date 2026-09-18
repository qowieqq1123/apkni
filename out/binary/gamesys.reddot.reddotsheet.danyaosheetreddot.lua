






danyaoSheetReddot=reddotSheetBase.new({classname='danyaoSheetReddot'})

danyaoSheetReddot.reddot_type=REDDIT_TYPE.eDanYao

danyaoSheetReddot.reddot_config=
{
[REDDIT_SUB_TYPE.sDanFang]=
{
catch={

CATCH_TYPE.eDanFangNew,

},
func=function(catchType,...)
return UIDanYaoModel:checkHaveDanFangNew()
end,
},

[REDDIT_SUB_TYPE.sDuJieXianDan]=
{
catch={

CATCH_TYPE.eDuJieXianDan,

},
func=function(catchType,...)
return jctjDuJieXianDanController:checkReddot()
end,
},
}
