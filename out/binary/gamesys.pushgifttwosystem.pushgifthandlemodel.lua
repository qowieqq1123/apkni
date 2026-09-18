





pushGiftHandleModel=gameState.addListener({})

pushGiftHandleModel.data={}
local SeasonInit=nil

function pushGiftHandleModel:onAppStart()

end


function pushGiftHandleModel:onEnterState(isReconnect)
notifySystem:listenNotify(notifyConfig.onSeasonChange,self.onSeasonChange)
end


function pushGiftHandleModel:onProtocolReq()

end


function pushGiftHandleModel:onProtocolReqKF()
end


function pushGiftHandleModel:onLeaveState(isReconnect)

notifySystem:removelistener(notifyConfig.onSeasonChange,self.onSeasonChange)
self.data={}
SeasonInit=nil
end


function pushGiftHandleModel:onLostConnection()

end


function pushGiftHandleModel:onReConnection(isInitPro)

end


function pushGiftHandleModel.onSeasonChange()
SeasonInit=true
end


local _checkNumFun=
{

[SUB_ACTIVITY_TYPE.eXianShiChouKa]=
{
getnum=function(actID,subType,subID)
local data=activitiesModel:getSubActInfoData(actID,subType,subID)
if data then
local total=data.total or 0
return total
else
return 0
end
end,
},

[SUB_ACTIVITY_TYPE.eXianShiChouKa_Role]=
{
getnum=function(actID,subType,subID)
local data=activitiesModel:getSubActInfoData(actID,subType,subID)
if data then
local total=data.total or 0
return total
else
return 0
end
end,
},















[SUB_ACTIVITY_TYPE.eXianShiChouKa2]=
{
getnum=function(actID,subType,subID)
local data=activitiesModel:getSubActInfoData(actID,subType,subID)
if data then
local total=data.total or 0
return total
else
return 0
end
end,
},

[SUB_ACTIVITY_TYPE.eDongTianFuDi]=
{
getnum=function(actID,subType,subID)
local data=activitiesModel:getSubActInfoData(actID,subType,subID)
if data then
local total=data.total_num or 0
return total
else
return 0
end
end,
},

[SUB_ACTIVITY_TYPE.eCloudCityTreasure]=
{
getnum=function(actID,subType,subID)
local data=activitiesModel:getSubActInfoData(actID,subType,subID)
if data then
local total=data.circle_num or 0
return total
else
return 0
end
end,
},

[SUB_ACTIVITY_TYPE.eCloudCityTreasure]=
{
getnum=function(actID,subType,subID)
local data=activitiesModel:getSubActInfoData(actID,subType,subID)
if data then
local total=data.circle_num or 0
return total
else
return 0
end
end,
},

[SUB_ACTIVITY_TYPE.eDressLottery]=
{
getnum=function(actID,subType,subID)
local data=activitiesModel:getSubActInfoData(actID,subType,subID)
if data then
local total=data.history_use_times or 0
return total
else
return 0
end
end,
},

[SUB_ACTIVITY_TYPE.eXianJieQiYuan]=
{
getnum=function(actID,subType,subID)
local data=activitiesModel:getSubActInfoData(actID,subType,subID)
if data then
local total=data.history_use_times or 0
return total
else
return 0
end
end,
},

[SUB_ACTIVITY_TYPE.eNiuDanJi]=
{
getnum=function(actID,subType,subID)
local data=activitiesModel:getSubActInfoData(actID,subType,subID)
if data then
local total=data.great or 0
return total
else
return 0
end
end,
},

[SUB_ACTIVITY_TYPE.eTanBaoGe]=
{
getnum=function(actID,subType,subID)
local data=activitiesModel:getSubActInfoData(actID,subType,subID)
if data then
local total=data.layer or 0
return total
else
return 0
end
end,
},
}


function pushGiftHandleModel:getActivityRoleNum(subtypelist)
local allnum=0
if subtypelist and#subtypelist>0 then


for k,v in ipairs(subtypelist)do
local _subtype=v[1]
local _subid_list=v[2]

local _subtypeNum=0
if pushGiftHandleModel:checkopen(_subtype)then
local allactlist=pushGiftHandleModel:getActivityData(_subtype)
local act_fundata=_checkNumFun[_subtype]
if act_fundata then
if _subid_list then
for subid,_ in pairs(_subid_list)do
local actinfo=allactlist[subid]
if actinfo then
local total=act_fundata.getnum(actinfo.act_id,actinfo.sub_act_type,actinfo.sub_act_id)
_subtypeNum=_subtypeNum+total
end
end
else
for i,actinfo in pairs(allactlist)do
local total=act_fundata.getnum(actinfo.act_id,actinfo.sub_act_type,actinfo.sub_act_id)
_subtypeNum=_subtypeNum+total
end
end
else
logErr(FMT.fmt("代码需要添加子活动类型{0}方法，需检查 推送礼包配置表 的子活动类型",_subtype))
return allnum
end
end
allnum=allnum+_subtypeNum
end
end
return allnum
end


function pushGiftHandleModel:checkopen(subType)
local sub_actList=activitiesModel:getActSubList_subType_doing(subType)
if#sub_actList<=0 then
return false
end
return true
end


function pushGiftHandleModel:getActivityData(subType)
local sub_actList=activitiesModel:getActSubList_subType_doing(subType)
local activitylist={}
for i,sub_actInfo in ipairs(sub_actList)do
if sub_actInfo:checkOpen()then
local actInfo=activitiesModel:getActInfo(sub_actInfo.act_id)
if actInfo and actInfo:checkSubUnlock_first(true)then
local base=sub_actInfo:getBaseData()
local temp2=
{
act_id=base.act_id,
sub_act_type=base.sub_act_type,
sub_act_id=base.sub_act_id,
}
activitylist[base.sub_act_id]=temp2
end
end
end
return activitylist
end


function pushGiftHandleModel:checkOpenByBadItem(itemlist)
for k,v in ipairs(itemlist)do
local itemid=v[1]
local neednum=v[2]
local havecount=neednum+1
if moneyConfig.isMoney(itemid)then
havecount=moneyModel.getMoney(itemid)
else
havecount=bagModel.getItemCountById(itemid)
end
if havecount<=neednum then
return true
end
end
return false
end

function pushGiftHandleModel:getJiuChongTianJiejd(jctjid)
local num=JiuChongTianJieEnterModel:getSubSystemProgress(jctjid)
return num or 0
end

function pushGiftHandleModel:checkOpenByBuildlevel(bdId,needlevel)
local mountainCfg=cfg_monijysfconfig()
for _,v in ipairs(mountainCfg)do
local bdDatas=zongmenModel:getBuildingDataByBdId(v.id,bdId)
for _,bd in ipairs(bdDatas)do
if bd.level>=needlevel then
return true
end
end
end
return false
end

function pushGiftHandleModel:checkXianJieCloudNum(cloudnum,libaoid)
if libaoid then
local param=pushGiftThreeConfig.getHideConfig(libaoid)

if param and param[1]and param[2]then
if param[1]==2 then
if param[2]==3 and xianjieModel:getCloudIsRecvQueue()then
return false
elseif param[2]==4 then
if SeasonInit then
if seasonController:checkSeasonHandleComplete(0)then
return false
end
else
return false
end
end
end
end
end
local num=xianjieModel:getCloudUnlockCount()

if num>=cloudnum then
return true
end
return false
end

