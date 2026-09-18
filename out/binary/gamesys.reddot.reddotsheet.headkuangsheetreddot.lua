






headkuangSheetReddot=reddotSheetBase.new({classname='headkuangSheetReddot'})

headkuangSheetReddot.reddot_type=REDDIT_TYPE.eHeadKuang

headkuangSheetReddot.reddot_config=
{
[REDDIT_SUB_TYPE.sHead]=
{
catch={
CATCH_TYPE.eMoney,
CATCH_TYPE.eItem,
CATCH_TYPE.eActorHeadChange,
},
func=function(catchType,...)
local ret=UISettingModel:checkReddotHead()
return ret
end,
},

[REDDIT_SUB_TYPE.sHeadKuang]=
{
catch={
CATCH_TYPE.eMoney,
CATCH_TYPE.eItem,
CATCH_TYPE.eActorHeadChange,
},
func=function(catchType,...)
local ret=UISettingModel:checkReddotHeadKuang()
return ret
end,
},

[REDDIT_SUB_TYPE.sChatKuang]=
{
catch={
CATCH_TYPE.eMoney,
CATCH_TYPE.eItem,
CATCH_TYPE.eChatBgExperience,
},
func=function(catchType,...)
local ret=UISettingModel:hasChatKuangReddot()
return ret
end,
},

[REDDIT_SUB_TYPE.sSettingZongMen]=
{
catch={
CATCH_TYPE.eZMLevel,
CATCH_TYPE.eSetingTypeChange,
CATCH_TYPE.eItem,
},
func=function(catchType,...)
local ret=UISettingModel:hasZongMenReddot()
return ret
end,
},

[REDDIT_SUB_TYPE.sSettingFeiJian]=
{
catch={
CATCH_TYPE.eZMLevel,
CATCH_TYPE.eSetingTypeChange,
CATCH_TYPE.eItem,
},
func=function(catchType,...)
local ret=UISettingModel:hasFeiJianReddot()
return ret
end,
},

[REDDIT_SUB_TYPE.sSettingYunZhou]=
{
catch={
CATCH_TYPE.eZMLevel,
CATCH_TYPE.eSetingTypeChange,
CATCH_TYPE.eItem,
},
func=function(catchType,...)
local ret=UISettingModel:hasYunZhouReddot()
return ret
end,
},
}
