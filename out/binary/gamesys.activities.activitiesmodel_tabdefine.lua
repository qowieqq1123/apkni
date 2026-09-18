











local tabCondConfig={

[SUBACT_DEFINETAB_TYPE.eZongMenDaBi_baoming]={
cond=function(actID,subType,subid)
local sub_actInfo=activitiesModel:getSubActInfo(actID,subType,subid)
if sub_actInfo then
local idx=sub_actInfo:getOpenDayIndex()
return idx==1 or not sub_actInfo:isBaoMing()
end
return false
end,
reddot=function(actID,subType,subid)
local sub_actInfo=activitiesModel:getSubActInfo(actID,subType,subid)
if sub_actInfo then
return not sub_actInfo:isBaoMing()
end
return false
end,
},

[SUBACT_DEFINETAB_TYPE.eZongMenDaBi_info]={
cond=function(actID,subType,subid)
local sub_actInfo=activitiesModel:getSubActInfo(actID,subType,subid)
if sub_actInfo then
local idx=sub_actInfo:getOpenDayIndex()
return idx>1 and sub_actInfo:isBaoMing()
end
return false
end,
reddot=function(actID,subType,subid)
local sub_actInfo=activitiesModel:getSubActInfo(actID,subType,subid)
if sub_actInfo then
return sub_actInfo:hasScoreReward()
end
return false
end,
},

[SUBACT_DEFINETAB_TYPE.eZongMenDaBi_battle]={
cond=function(actID,subType,subid)
local sub_actInfo=activitiesModel:getSubActInfo(actID,subType,subid)
if sub_actInfo then
local idx=sub_actInfo:getOpenDayIndex()
return idx>1 and sub_actInfo:isBaoMing()
end
return false
end,
reddot=function(actID,subType,subid)
local sub_actInfo=activitiesModel:getSubActInfo(actID,subType,subid)
if sub_actInfo then
return sub_actInfo:hasFreeBattle()
end
return false
end,
},

[SUBACT_DEFINETAB_TYPE.eZongMenDaBi_reward]={
cond=function(actID,subType,subid)
local sub_actInfo=activitiesModel:getSubActInfo(actID,subType,subid)
if sub_actInfo then
local idx=sub_actInfo:getOpenDayIndex()
return idx>1 and sub_actInfo:isBaoMing()
end
return false
end,
reddot=function(actID,subType,subid)
return false
end,
},

[SUBACT_DEFINETAB_TYPE.eZongMenDaBi_score]={
cond=function(actID,subType,subid)
local sub_actInfo=activitiesModel:getSubActInfo(actID,subType,subid)
if sub_actInfo then
local idx=sub_actInfo:getOpenDayIndex()
return idx>1 and sub_actInfo:isBaoMing()
end
return false
end,
reddot=function(actID,subType,subid)
return zongmenModel:checkZongMenScoreRewardReddot()
end,
},

[SUBACT_DEFINETAB_TYPE.eZongMenDaBi_target]={
cond=function(actID,subType,subid)
local sub_actInfo=activitiesModel:getSubActInfo(actID,subType,subid)
if sub_actInfo then
local idx=sub_actInfo:getOpenDayIndex()
return idx>1 and sub_actInfo:isBaoMing()
end
return false
end,
reddot=function(actID,subType,subid)
local sub_actInfo=activitiesModel:getSubActInfo(actID,subType,subid)
if sub_actInfo then
return sub_actInfo:hasTargetReward()
end
return false
end,
},

[SUBACT_DEFINETAB_TYPE.eTianMoRuQin_main]={
cond=function(actID,subType,subid)
return true
end,
reddot=function(actID,subType,subid)
local info=activitiesModel:getSubActInfo(actID,subType,subid)
if info then
return info:checkMainReddot()
end
return false
end,
},

[SUBACT_DEFINETAB_TYPE.eTianMoRuQin_qingbao]={
cond=function(actID,subType,subid)
return true
end,
reddot=function(actID,subType,subid)
local info=activitiesModel:getSubActInfo(actID,subType,subid)
if info then
return info:checkQingBaoReddot()
end
return false
end,
exIconAB='ui/sharedtextures/uiglobalspriteatlas_1.ab',
exIconName='image_xin_1',
exIconRefresh=function(actID,subType,subid)
local info=activitiesModel:getSubActInfo(actID,subType,subid)
if info then
return info:checkQingBaoXin()
end
return false
end
},

[SUBACT_DEFINETAB_TYPE.eTianMoRuQin_tujian]={
cond=function(actID,subType,subid)
return true
end,
reddot=function(actID,subType,subid)
local info=activitiesModel:getSubActInfo(actID,subType,subid)
if info then
return info:checkTuJianReddot()
end
return false
end,
},
}

local subActTabCfgLookup

function activitiesModel:initSubActTabCfgLookup()
if subActTabCfgLookup==nil then
subActTabCfgLookup={}
local cfgs=cfg_subactivitytabdefineconfig()
for k,cfg in pairs(cfgs)do
local subType=cfg.subType
if subActTabCfgLookup[subType]==nil then
subActTabCfgLookup[subType]={}
end
table.insert(subActTabCfgLookup[subType],cfg)
end
for subType,lp in pairs(subActTabCfgLookup)do
if#lp>1 then
table.sort(lp,function(a,b)
return a.sortid<b.sortid
end)
end
for i,cfg in ipairs(lp)do
local check=tabCondConfig[cfg.id]
if check then
check.tab_idx=i
end
end
end
end
end

function activitiesModel:getSubActDefineTabList(actID,subType,subid)
activitiesModel:initSubActTabCfgLookup()
local lp=subActTabCfgLookup[subType]
if lp then
local list={}
for i,cfg in ipairs(lp)do
local check=tabCondConfig[cfg.id]
local checkCond=true
if check and check.cond and not check.cond(actID,subType,subid)then
checkCond=false
end
if checkCond then
local d={}
d.id=cfg.id
d.sortid=cfg.sortid
d.name=cfg.name
d.tabIcons=cfg.tabIcons
local subwinLookup={}
for i2,v2 in ipairs(cfg.openPanel)do
local winname=cfgHelper.get2(cfg_subactivityspanelconfig_get,v2[1],'panelname')
local winargs=table.deepCopy(v2[2])or{}
subwinLookup[winname]=winargs
end
d.subwinLookup=subwinLookup
if check then
d.reddot=check.reddot
d.exIconAB=check.exIconAB
d.exIconName=check.exIconName
d.exIconRefresh=check.exIconRefresh
end
d.tab_idx=check.tab_idx
d.actID=actID
d.subType=subType
d.subid=subid
list[#list+1]=d
end
end
if#list>0 then
return list
end
end
return nil
end

function activitiesModel:getSubActDefineTabIndex(sub_act_define_tab_type)
local check=tabCondConfig[sub_act_define_tab_type]
if check then
return check.tab_idx
end
end