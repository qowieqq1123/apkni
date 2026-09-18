








act_jump_in_type={
eEnterIn=1,
}

activityExtracheckType={
eTianDaoMiJi=1,
eExchangeShop=2,

eFangYingTing=3,
eLianQiDaHui=4,
}

local extra_checks={

[activityExtracheckType.eExchangeShop]=function(actID,subType,subid,extraParams)

if extraParams~=nil and extraParams.jumpInType==act_jump_in_type.eEnterIn then

local flag=onlineDataSetting:getData('act_exchargeShopTip_open',nil)
if flag~=true then
local sub_actInfo=nil
local actInfo=activitiesModel:getActInfo(actID)
if actInfo then

local sublist=actInfo:getSubList_subType_doing(SUB_ACTIVITY_TYPE.eDuiHuanShangDian)
if#sublist>0 then
for i,sub_actInfo_ in ipairs(sublist)do
local day=sub_actInfo_:getEndLeftDayTime()
if day<=1 then
local moneyType=activitiesModel:getSubActivityConfig(sub_actInfo_.sub_act_type,sub_actInfo_.sub_act_id,'money')
local num=itemsModel.getCount(moneyType)

if num>0 then
sub_actInfo=sub_actInfo_
break
end
end
end
end
if sub_actInfo then
local args={
act_id=sub_actInfo.act_id,sub_act_type=sub_actInfo.sub_act_type,sub_act_id=sub_actInfo.sub_act_id,extraParams=extraParams
}
UIManager:showWindow('UIExchargeShopTipsWin',args)
return true
end

local sublist=actInfo:getSubList_subType_doing(SUB_ACTIVITY_TYPE.eDuiHuanShangDian2)
if#sublist>0 then
for i,sub_actInfo_ in ipairs(sublist)do
local day=sub_actInfo_:getEndLeftDayTime()
if day<=1 then
local moneyType=activitiesModel:getSubActivityConfig(sub_actInfo_.sub_act_type,sub_actInfo_.sub_act_id,'money')
local exchangeTips=activitiesModel:getSubActivityConfig(sub_actInfo_.sub_act_type,sub_actInfo_.sub_act_id,'exchangeTips')
local num=itemsModel.getCount(moneyType)

if num>0 and exchangeTips then
sub_actInfo=sub_actInfo_
break
end
end
end
end
if sub_actInfo then
local args={
act_id=sub_actInfo.act_id,sub_act_type=sub_actInfo.sub_act_type,sub_act_id=sub_actInfo.sub_act_id,extraParams=extraParams
}
UIManager:showWindow('UIExchargeShopTipsWin',args)
return true
end
end
end
end
return false
end,

[activityExtracheckType.eTianDaoMiJi]=function(actID,subType,subid,extraParams)

if extraParams~=nil and extraParams.jumpInType==act_jump_in_type.eEnterIn then

local sub_actInfo=nil
local actInfo=activitiesModel:getActInfo(actID)
if actInfo then
local sublist=actInfo:getSubList_subType_doing(SUB_ACTIVITY_TYPE.eTianDaoMiJi)
if#sublist>0 then
for i,sub_actInfo_ in ipairs(sublist)do
local config=sub_actInfo_:getSubActConfig()
local tips=config.endTips

if tips~=nil then
local day=sub_actInfo_:getEndLeftDayTime()
if day<=1 then
local key=FMT.fmt("act_gongfaGainTip_open_{0}_{1}",sub_actInfo_.act_id,sub_actInfo_.sub_act_id)
local flag=onlineDataSetting:getData(key,nil)

if flag~=true then
local aim=config.aim
local data=sub_actInfo_:getData()
local progress=tonumber(tostring(data.taskProgress))

if progress<aim then
sub_actInfo=sub_actInfo_
break
end
end
end
end
end
end
end
if sub_actInfo then
local args={
act_id=sub_actInfo.act_id,sub_act_type=sub_actInfo.sub_act_type,sub_act_id=sub_actInfo.sub_act_id,extraParams=extraParams
}
UIManager:showWindow('UIGongfaGainTipsWin',args)
return true
end
end
return false
end,






































[activityExtracheckType.eFangYingTing]=function(actID,subType,subid,extraParams)

if extraParams~=nil and subType==SUB_ACTIVITY_TYPE.eFangYingTing then
local winname=extraParams.winName
if winname then
local tempArgtable={actID=actID,subType=subType,subid=subid}

if UIManager:isActive("UIFightPrepareLoading")then
UIManager:showWindow(winname,tempArgtable)
else
UIManager:showWindow("UIFightPrepareLoading",{
startCallback=function()
UIManager:showWindow(winname,tempArgtable)
UIManager:invokeUIMethod("UIFightPrepareLoading","endAni")
end
})
end
end
end
end,
[activityExtracheckType.eLianQiDaHui]=function(actID,subType,subid,extraParams)

if extraParams~=nil and extraParams.jumpInType==act_jump_in_type.eEnterIn then

local sub_actInfo=nil
local exList=nil
local actInfo=activitiesModel:getActInfo(actID)
if actInfo then
local sublist=actInfo:getSubList_subType_doing(SUB_ACTIVITY_TYPE.eLianQiDaHui)
if#sublist>0 then
for i,sub_actInfo_ in ipairs(sublist)do
local day=sub_actInfo_:getEndLeftDayTime()
if day<=1 then
exList=sub_actInfo_:getExchangeList()
if#exList>0 then
local key=FMT.fmt("act_lianqidahui_open_{0}_{1}",sub_actInfo_.act_id,sub_actInfo_.sub_act_id)
local flag=onlineDataSetting:getData(key,nil)
if flag~=true then
sub_actInfo=sub_actInfo_
end
end
end
end
end
end
if sub_actInfo then
local args={
act_id=sub_actInfo.act_id,
sub_act_type=sub_actInfo.sub_act_type,
sub_act_id=sub_actInfo.sub_act_id,
extraParams=extraParams,
exList=exList
}
UIManager:showWindow('UILianQiMGExcharge',args)
return true
end
end
return false
end,
}

local _extraChecksLookUp=nil

function activitiesModel:getExtraChecksLookup()
if not _extraChecksLookUp then
local temp={}
for i,v in pairs(activityExtracheckType)do
table.insert(temp,v)
end
table.sort(temp)
_extraChecksLookUp=temp
end
return _extraChecksLookUp
end

function activitiesModel:extraCheck(actID,subType,subid,extraParams,since)
local lookup=self:getExtraChecksLookup()

local sIdx=0
if since then
sIdx=table.findValue(lookup,since)or 0
end
for i=sIdx+1,#lookup do
local type=lookup[i]
local func=extra_checks[type]
if func then
local check=func(actID,subType,subid,extraParams)
if check then
return
end
end
end
end

