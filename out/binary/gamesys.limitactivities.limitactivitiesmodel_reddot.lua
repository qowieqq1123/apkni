








local actReddotCatchLookup={






[LIMIT_ACT_TYPE.eTianYuanShouChao]={
{CATCH_TYPE.eLimitActChange,{LIMIT_ACT_TYPE.eTianYuanShouChao}},
},
[LIMIT_ACT_TYPE.eShiJieShouLing]={
{CATCH_TYPE.eLimitActChange,{LIMIT_ACT_TYPE.eShiJieShouLing}},
},
[LIMIT_ACT_TYPE.eXianMengDiGong]={
{CATCH_TYPE.eLimitActChange,{LIMIT_ACT_TYPE.eXianMengDiGong}},
},
[LIMIT_ACT_TYPE.eXianFaWenDao]={
{CATCH_TYPE.eLimitActChange,{LIMIT_ACT_TYPE.eXianFaWenDao}},
},
[LIMIT_ACT_TYPE.eLingXuWenJian]={
{CATCH_TYPE.eLimitActChange,{LIMIT_ACT_TYPE.eLingXuWenJian}},
},
[LIMIT_ACT_TYPE.eXianJieFuMo]={
{CATCH_TYPE.eLimitActChange,{LIMIT_ACT_TYPE.eXianJieFuMo}},
},
[LIMIT_ACT_TYPE.eMiaoXingShangLv]={
{CATCH_TYPE.eLimitActChange,{LIMIT_ACT_TYPE.eMiaoXingShangLv}},
},

}


local catchSubCheckLookup={
[CATCH_TYPE.eMoney]=function(subs,...)
local params={...}
for i,v in ipairs(subs)do
if v==params[1]then
return true
end
end
return false
end,
[CATCH_TYPE.eLimitActChange]=function(subs,...)
local params={...}
for i,v in ipairs(subs)do
if v==params[1]then
return true
end
end
return false
end,
}


function limitActivitiesModel:disposeActReddotChange(catchType,...)
for actType,changes in pairs(actReddotCatchLookup)do
local f=false
for i,v in ipairs(changes)do
local cType=v[1]
local subs=v[2]
if cType==catchType then
if subs~=nil then
local subCheck=catchSubCheckLookup[cType]
if subCheck then
f=subCheck(subs,...)
end
else
f=true
end
end
if f then
break
end
end
if f then
local actID=actType
local actInfo=limitActivitiesModel:getActInfo(actID)
if actInfo then
actInfo:refreshReddot()
end
end
end
end


function limitActivitiesModel:disposeActConditionChange(typo,...)
local params={...}
local all=limitActivitiesModel:getAllActivities()
for actID,actInfo in pairs(all)do
local actcfg=actInfo:getActConfig()
local f=false
if typo==1 then

if actcfg.zmLevel~=nil then
f=true
end
elseif typo==2 then

if actcfg.kfDay~=nil then
f=true
end






elseif typo==3 then

if actcfg.xychapterid~=nil then
f=true
end
if actcfg.mojieStage~=nil then
f=true
end
end
if f then
actInfo:refreshCondition()
end
end
end