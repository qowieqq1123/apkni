local _gxRankList={}
local _gxRankNo=0

local _gxbTaskType={
eLimitActivity=1,
eBuilding=2,
eSystem=3,
}

local _gxbTaskTypeCheck={
[_gxbTaskType.eLimitActivity]={
check=function(id)
return limitActivitiesModel:checkActDoing(id)
end,
tips=function(id)
local actCfg=limitActivitiesModel:getActConfig(id)
return limitActivitiesModel.getTimeDesc(actCfg)
end,
state=function(flag)
return flag and"image_huorejinxing_1"or"image_zanweikaiqi_1"
end,
jump=function(id,param)
jumpManager:jump(param)
end,
weight=2,
},
[_gxbTaskType.eBuilding]={
check=function(id)
return zongmenModel:haveBuildByBuildIdEx(id)
end,
state=function(flag)
return flag and"image_chakanrenwu_1"or"image_xiufuzhong_1"
end,
jump=function(id,param)
if zongmenModel:haveBuildByBuildIdEx(id)then
jumpManager:jump(param)
else
local repair=isometricMapSystem:getUnlockRepairDataByID(mapIdType.xianmeng,id)
if repair then
if fullScreenUI.checkFull(UIFullXMGongXunBangControl)then
UIFullXMGongXunBangControl:closeUI(true)
end
isometricMapSystem:checkTouchRepairBuilding(repair.guid,true)
return
end

local cfg=cfgHelper.get1(cfg_monijybuildconfig_get,id)
UIManager.error(FMT.fmt("未建造{0}",cfg.name))
end
end,
weight=1,
},
[_gxbTaskType.eSystem]={
check=function(id)
return systemModel.isOpen(id)
end,
tips=function(id)
return systemModel.getOpenTips(id)
end,
state=function(flag)
return flag and"image_chakanrenwu_1"or"image_shangweijiesuo_1"
end,
jump=function(id,param)
if systemModel.isOpen(id,true)then
jumpManager:jump(param)
end
end,
weight=3,
},
}

local _gxbTaskHandle={
[GXB_TASK_ENUM.eTianYuanShouChao]={
getValue=function()
return xianmengModel:getChallengeNum1_TYSC()
end,
},
[GXB_TASK_ENUM.eXianWuLou]={
getValue=function()
local data=xianmengModel:getXWLData()
return data and data.tjNum or 0
end,
getReddot=function()
local data=xianmengModel:getXWLData()
return data and(data.lunshuId2>0)or false
end,
},
[GXB_TASK_ENUM.eXianMengDiGong]={
getValue=function()
return xianmengdigongModel:getXDL()
end,
getReddot=function()
return limitActivitiesModel:getActReddot(LIMIT_ACT_TYPE.eXianMengDiGong)
end,
},
[GXB_TASK_ENUM.eLingXuWenJian]={
getValue=function()
local data=lingxuwenjianModel:getAttackLeftTimes()
return data
end,
}
}

function xianmengModel:getGXBTypeWeight(eType)
local handle=_gxbTaskTypeCheck[eType]
if handle and handle.weight then
return handle.weight
end
end

function xianmengModel:doGXBTaskJump(eType,id,param)
local handle=_gxbTaskTypeCheck[eType]
if handle and handle.jump then
return handle.jump(id,param)
end
end

function xianmengModel:getGXBTaskValue(eType)
local handle=_gxbTaskHandle[eType]
if handle and handle.getValue then
return handle.getValue()
end
end

function xianmengModel:getGXBTaskReddot(eType)
local handle=_gxbTaskHandle[eType]
if handle and handle.getReddot then
return handle.getReddot()
end
return false
end

function xianmengModel:getGXBTaskCheck(type,id)
local check=_gxbTaskTypeCheck[type]
if check and check.check then
return check.check(id)
end
return false
end

function xianmengModel:getGXBTaskTips(type,id)
local check=_gxbTaskTypeCheck[type]
if check and check.tips then
return check.tips(id)
end
end

function xianmengModel:getGXBTaskStateImageEx(type,flag)
local check=_gxbTaskTypeCheck[type]
if check and check.state then
return check.state(flag)
end
return""
end

function xianmengModel:getGXBTaskStateImage(type,id)
local check=_gxbTaskTypeCheck[type]
if check and check.check then
local flag=check.check(id)
if check.state then
return check.state(flag)
end
end
return""
end

function xianmengModel:getGXBRewardId()
local data=xianmengModel:getXMBaseData()
if data then
return data.ws_conf_id
end
end

function xianmengModel:getGXBValue()
local data=xianmengModel:getXMBaseData()
if data then
return data.ws_score
end
end

function xianmengModel:setGXBValue(value)
local data=xianmengModel:getXMBaseData()
if data then
data.ws_score=value
end
end

function xianmengModel:getGXBRewardFlag()
local data=xianmengModel:getXMBaseData()
if data then
return data.ws_rewards_flag
end
end

function xianmengModel:checkGXBRewrad(index)
local bits=self:getGXBRewardFlag()
if bits then
return mathHelper.getBitValue(bits,index-1)
end
end

function xianmengModel:getGVBRewardCount()
local data=xianmengModel:getXMBaseData()
if data then
local id=data.ws_conf_id
local bits=data.ws_rewards_flag
local cfg=cfgHelper.get1(cfg_guildweekscoreconfig_get,id)
if cfg then
return mathHelper.cntbit(bits,0,#cfg.rewards),#cfg.rewards
else
loggerUtil.logErrFMT("没有对应的仙盟周贡献配置：{0}",id)
return 0,0
end
end
end

function xianmengModel:setGXBRewardFlag(index)
local data=xianmengModel:getXMBaseData()
if data then
data.ws_rewards_flag=mathHelper.setbit(data.ws_rewards_flag,index-1)
end
end

function xianmengModel:resetGXBRewardFlag()
local data=xianmengModel:getXMBaseData()
if data then
data.ws_rewards_flag=0
end
end

function xianmengModel:getGXBRewardReddot()
local data=xianmengModel:getXMBaseData()
if data then
local id=data.ws_conf_id
local cfg=cfgHelper.get1(cfg_guildweekscoreconfig_get,id)
if cfg then
local value=data.ws_score
local flag=data.ws_rewards_flag
for i,v in ipairs(cfg.rewards)do
local need=v[1]
if value>=need and not mathHelper.getBitValue(flag,i-1)then
return true
end
end
end
end
return false
end

function xianmengModel:setGXRankList(list)
list=list or{}
_gxRankList={}
for i,v in ipairs(list)do
v.serverIndex=i
table.insert(_gxRankList,v)
end
local count=#_gxRankList
if count>1 then
table.sort(_gxRankList,function(a,b)
if a.week_score~=b.week_score then
return a.week_score>b.week_score
else
return a.serverIndex<b.serverIndex
end
end)
end
if count>0 then
for i,v in ipairs(_gxRankList)do
if playerModel:checkActorId(v.actor_id)then
self:setGXRankNo(i)
return
end
end
end
self:setGXRankNo(0)
end

function xianmengModel:getGXRankList()
return _gxRankList
end

function xianmengModel:setGXRankNo(no)
_gxRankNo=no
end

function xianmengModel:getGXRankNo()
return _gxRankNo
end