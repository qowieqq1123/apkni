
yueLongChiSheetReddot=reddotSheetBase.new({classname='yueLongChiSheetReddot'})

yueLongChiSheetReddot.reddot_type=REDDIT_TYPE.eYueLongChi

yueLongChiSheetReddot.reddot_config=
{
[REDDIT_SUB_TYPE.sYLCHandBook]=
{
catch={
CATCH_TYPE.eYueLongChi,
},
func=function(catchType,...)
return UIAquariumControl:checkHandleBookPageReddot()
end,
},
[REDDIT_SUB_TYPE.sYLCSuit]=
{
catch={
CATCH_TYPE.eYueLongChi,
},
func=function(catchType,...)
return UIAquariumControl:checkHBSuitPageReddot()
end,
},
}