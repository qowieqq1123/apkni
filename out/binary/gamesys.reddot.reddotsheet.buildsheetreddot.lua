
buildSheetReddot=reddotSheetBase.new({classname='buildSheetReddot'})

buildSheetReddot.reddot_type=REDDIT_TYPE.eLayoutBuild

buildSheetReddot.reddot_config=
{
[REDDIT_SUB_TYPE.sLayoutBuild]=
{
catch={
CATCH_TYPE.eZongMenLevel,
CATCH_TYPE.eItem,
CATCH_TYPE.eMoney,
CATCH_TYPE.eBuildActive,
CATCH_TYPE.eRoadActive,
CATCH_TYPE.eBuildSuitActive,
CATCH_TYPE.eBuildSuitReward,
CATCH_TYPE.eDesignLayoutOpen,
},
func=function(catchType,...)
return zongmenModel:hasAnyActiveBuildReddot()or
zongmenBuildingSuitModel:checkReddot()or
zongmenModel:hasAnyActiveRoadReddot()or
zongmenModel:hasAllProductionBuildReddot()or
zongmenModel:hasAllFunctionBuildReddot()or
ims_design_layout:isLayoutReddot()
end,
},
}