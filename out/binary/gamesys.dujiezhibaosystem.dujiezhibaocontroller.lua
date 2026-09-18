






local _MODULENAME="DuJieZhiBaoController"

gameState.addListener(def_table(_MODULENAME))
DuJieZhiBaoController.name=_MODULENAME
DuJieZhiBaoController.data={}

function DuJieZhiBaoController:onAppStart()
DuJieZhiBaoModel:onAppStart()

socketManager:register_receiver(34,31,DuJieZhiBaoController.recv_34_31)
socketManager:register_receiver(34,32,DuJieZhiBaoController.recv_34_32)
socketManager:register_receiver(34,33,DuJieZhiBaoController.recv_34_33)
socketManager:register_receiver(34,34,DuJieZhiBaoController.recv_34_34)

end


function DuJieZhiBaoController:onEnterState(isReconnect)
DuJieZhiBaoModel:onEnterState()
notifySystem:listenNotify(notifyConfig.home_event,self.on_home_event)
notifySystem:listenNotify(notifyConfig.building_event,self.on_building_event)
end


function DuJieZhiBaoController:onProtocolReq()
DuJieZhiBaoModel:onProtocolReq()
end


function DuJieZhiBaoController:onLeaveState(isReconnect)
DuJieZhiBaoModel:onLeaveState(isReconnect)
notifySystem:removelistener(notifyConfig.home_event,self.on_home_event)
notifySystem:removelistener(notifyConfig.building_event,self.on_building_event)

self.data={}
end


function DuJieZhiBaoController:onLostConnection()

end


function DuJieZhiBaoController:onReConnection(isInitPro)

end







function DuJieZhiBaoController:send_34_32(id,item_list_len,item_list)

socketManager:send_34_32(id,item_list_len,item_list)
end


function DuJieZhiBaoController:send_34_33(id,item_list_len,item_list)
if item_list_len>0 then
socketManager:send_34_33(id,item_list_len,item_list)
end
end


function DuJieZhiBaoController:send_34_34(id,reward_idx)

socketManager:send_34_34(id)
end




function DuJieZhiBaoController.recv_34_31(len,arry)
DuJieZhiBaoModel:initDJZBData(len,arry)
DuJieZhiBaoController.data.firstFlag=true
end


function DuJieZhiBaoController.recv_34_32(id,refine_rate)
DuJieZhiBaoModel:DJZBLianhuaback(id,refine_rate)

UIManager:invokeUIMethod("UISectionRepair_flyupward","refreshLHdata",id)
end


function DuJieZhiBaoController.recv_34_33(id,reduce_times)
DuJieZhiBaoModel:downCDtimes(id,reduce_times)
end


function DuJieZhiBaoController.recv_34_34(id,reward_idx)
DuJieZhiBaoModel:setRewardFlag(id,reward_idx)
UIManager:invokeUIMethod("UIDJZBRewardWin","refreshGetReward",id)
UIManager:invokeUIMethod("UISectionRepair_flyupward","djzbRewardReddot",id)
UIManager:invokeUIMethod("UIDJZBuplevelWin","djzbRewardReddot",id)
end


function DuJieZhiBaoController:getBuildDataDjzb()
local alldjjz={82,83,84,85,86}
local sfId=zongmenModel:getMountainId()
local templist={}
for k,v in ipairs(alldjjz)do
local temp=
{
stage=0,
jzid=v,
jzdata=nil,
model=1,
isfinish=false
}
templist[v]=temp
end

for k,SLG_type in ipairs(alldjjz)do
local bdDatas=zongmenModel:getBuildingDataByBdType(sfId,SLG_type)
if bdDatas and bdDatas[1]then
local v=bdDatas[1]
local cfg=cfgHelper.get1(cfg_monijybuildconfig_get,v.build_id)
if v.flag>10 then
local temp=
{
stage=1,
jzid=cfg.build_type,
jzdata=v,
model=2,
isfinish=false
}
templist[cfg.build_type]=temp
else
local temp=
{
stage=2,
jzid=cfg.build_type,
jzdata=v,
model=2,
isfinish=true
}
templist[cfg.build_type]=temp
end
end
end


for k,v in pairs(templist)do
local _stage=v.stage
local _jzid=v.jzid
if _stage==0 then
local _data=isometricMapSystem:getRepairDataByID(sfId,_jzid)
local temp=
{
stage=0,
jzid=_jzid,
jzdata=_data,
model=1,
isfinish=false
}
templist[k]=temp
end
end

return templist
end


function DuJieZhiBaoController.on_home_event(etype)

if etype==homeEvent.eEnterHome then
DuJieZhiBaoController:refreshDJZBHUD()
if DuJieZhiBaoController.data.firstFlag then

local builddatas=DuJieZhiBaoController:getBuildDataDjzb()
local jctjpeople=JiuChongTianJieEnterModel:getOpenTianJiePeople()
local allcfg=cfg_dujietreasuresbasicconfig_get(1)
if builddatas and next(builddatas)then
for k,v in pairs(builddatas)do
local jzdata=v.jzdata
if jzdata and jzdata.flag then
if jzdata.flag==11 or jzdata.flag==12 then
local un_build_id=jzdata.un_build_id
local cddata=buildingCDControl:getCDData(buildingCDType.build,un_build_id,false)

if not cddata or cddata.complete then
return
end
if cddata then
local feisheng_cfg=allcfg.server_reduce_conf
local fs_data=nil
for k,v in ipairs(feisheng_cfg)do
if v[1]<=jctjpeople and v[2]>=jctjpeople then
fs_data=v
end
end
local alltime=cddata.ntime
local chatime=cddata.ntime
if fs_data then
local cdrate=fs_data[4]
local cdrate2=100-cdrate
chatime=chatime*(cdrate2/100)
end
local deltime=alltime-chatime
if deltime and deltime>0 then
zongmenModel:setUpgradeSpeedupTime(1,un_build_id,deltime)
buildingCDControl:setSpeedUp(un_build_id,speedUpType.eUpgradeBuilding)
local args={ignorePlayAudio=true}
notifySystem:postNotify(notifyConfig.building_event,buildingEvent.speedUpComplete,1,un_build_id,args)

end
end
end
end
end
end
DuJieZhiBaoController.data.firstFlag=nil
end
end
end

function DuJieZhiBaoController.on_building_event(etype,sfId,ubdId)
if etype==buildingEvent.buildStart or etype==buildingEvent.buildComplete
or etype==buildingEvent.levelUpStart or etype==buildingEvent.levelUpComplete then
local data=zongmenModel:getBuildingData(ubdId)
if data.build_id==82 or data.build_id==83 or data.build_id==84 or data.build_id==85 or data.build_id==86 then
DuJieZhiBaoController:refreshDJZBHUD()
taskController.eDJZBwcNumChange()
taskController.eDJZBlhNumChange()
end
end
end


function DuJieZhiBaoController:JCTJjumpBuild()
local builddata={}
local builddatas=DuJieZhiBaoController:getBuildDataDjzb()
for k,v in pairs(builddatas)do
if v.stage then
if v.stage==0 or v.stage==1 then
builddata=
{
[1]=v.model,
[2]=v.jzdata,
[3]=v.jzid,
[4]=true,
}
break
else
builddata=
{
[1]=v.model,
[2]=v.jzdata,
[3]=v.jzid,
[4]=false,
}
end
end
end

if builddata then
if builddata[4]then


if builddata[1]==1 then
FeiShengTaiController.openFeiShengTaiRepairWin({1,builddata[2]})

else
FeiShengTaiController.openFeiShengTaiRepairWin({2,builddata[2]})

end


else
UIFullDuJieZhiBaoControl:showDJZBWindow({2,builddata[3]})
end
end
end


function DuJieZhiBaoController:JCTJjumpHudBuild(_jzid)
local builddatas=DuJieZhiBaoController:getBuildDataDjzb()
local builddata
for k,v in pairs(builddatas)do
if v.stage then
if v.jzid==_jzid then
builddata=v
break
end
end
end
if builddata then
FeiShengTaiController.openFeiShengTaiRepairWin({1,builddata.jzdata})

end
end


function DuJieZhiBaoController:getAllBuildJinDu()
if not systemModel.isOpen(SYSTEM_DEFINE.eDuJieZhiBao)then
return 0
end
local builddatas=DuJieZhiBaoController:getBuildDataDjzb()
local allnum=0
for k,v in pairs(builddatas)do
if v.jzdata then
if v.isfinish then
allnum=allnum+2
else
if v.jzdata.flag then
if v.jzdata.flag==12 or v.jzdata.flag==21 then
allnum=allnum+1
end
end
end
end
end

return allnum
end


function DuJieZhiBaoController:getDJZBSingleReddot(_buildid)
if not systemModel.isOpen(SYSTEM_DEFINE.eDuJieZhiBao)then
return false
end
local builddatas=DuJieZhiBaoController:getBuildDataDjzb()
local buildid=_buildid

local oneflag=1
local twoflag=1
local builddata=builddatas[buildid]
local severdatas=DuJieZhiBaoModel:getDJZBData()
local severdata=severdatas[buildid]

local refine_rate
if severdata and severdata.refine_rate then
refine_rate=severdata.refine_rate
end
local reward_flag
local bitflag_one=false
local bitflag_two=false
if severdata and severdata.reward_flag then
reward_flag=severdata.reward_flag
bitflag_one=bitHelper.check_pos(reward_flag,0)
bitflag_two=bitHelper.check_pos(reward_flag,1)
end

local _stage=builddata.stage
if _stage==0 then
oneflag=1
twoflag=1
else
local flag=builddata.jzdata.flag
if flag>10 then
if flag>11 and flag<=21 then
if bitflag_one then
oneflag=3
else
oneflag=2
end
elseif flag>21 then
if bitflag_one then
oneflag=3
else
oneflag=2
end
if bitflag_two then
twoflag=3
else
twoflag=2
end
end
else

if refine_rate then
if bitflag_one then
oneflag=3
else
oneflag=2
end
if bitflag_two then
twoflag=3
else
twoflag=2
end
end
end
end

if oneflag==2 or twoflag==2 then
return true
else
return false
end
end


function DuJieZhiBaoController:getDJZBAllReddot()
if not systemModel.isOpen(SYSTEM_DEFINE.eDuJieZhiBao)then
return false
end
return false
end


function DuJieZhiBaoController:checkOpen(sysId)
if sysId then
return systemModel.isOpen(sysId)
end
end

function DuJieZhiBaoController:getColdDay(sysId)
if sysId then
local isCan,errArgs=systemConfig.isEnoughConfigOpenCnd(sysId,true)

if not isCan then
local typo=errArgs[1]
local val=errArgs[2]
local val2=errArgs[3]
if typo==SYSTEM_OPEN_TYPE.eSysOpenDay then
local openSec=systemModel.getSystemOpenTime(val)
if not openSec then
loggerUtil.logErrFMT("系统配置有误，条件配置了已开过的系统,没有生成开启时间")
return 0
end
local zerotime=timeHelper.getTodayZeroStamp()


openSec=timeHelper.getServerZeroStamp(timeHelper.convertLongStamp(openSec))


return(openSec+(val2-1)*86400)-zerotime
end
end
end
return 0
end

function DuJieZhiBaoController:getDJZBAttrAddList()

if not systemModel.isOpen(SYSTEM_DEFINE.eDuJieZhiBao)then
return nil
end

local builddatas=DuJieZhiBaoController:getBuildDataDjzb()
local lookupList={}
for k,v in pairs(builddatas)do
if v.jzdata then
if v.isfinish then
if v.jzdata and v.jzdata.level then
local buildid=v.jzid
local now_level=v.jzdata.level
local djzbLvCfg=cfg_dujietreasureslevelconfig_get(buildid)[now_level]
local attrList=djzbLvCfg.effect

for i,v in ipairs(attrList)do
local attrId=v[1]
local attrCfgVal=v[2]
lookupList[attrId]=attrCfgVal
end
end
end
end
end
if lookupList and next(lookupList)then
return lookupList
else
return nil
end
end

function DuJieZhiBaoController:getDJZBlhNum(buildid)
if not systemModel.isOpen(SYSTEM_DEFINE.eDuJieZhiBao)then
return 0
end
if not buildid then
return 0
end
local builddatas=DuJieZhiBaoController:getBuildDataDjzb()
local allnum=0
for k,v in pairs(builddatas)do
if v.jzid and v.jzid==buildid and v.jzdata then
if v.isfinish then
allnum=2
else
if v.jzdata.flag then
if v.jzdata.flag==12 or v.jzdata.flag==21 then
allnum=1
end
end
end
break
end
end

return allnum
end

function DuJieZhiBaoController:getDJZBAllFinishNum()
if not systemModel.isOpen(SYSTEM_DEFINE.eDuJieZhiBao)then
return 0
end
local builddatas=DuJieZhiBaoController:getBuildDataDjzb()
local allnum=0
for k,v in pairs(builddatas)do
if v.isfinish then
allnum=allnum+1
end
end

return allnum
end


function DuJieZhiBaoController:checklianhuaSingleReddot(buildid)
if not systemModel.isOpen(SYSTEM_DEFINE.eDuJieZhiBao)then
return false
end
local cfg=cfgHelper.get1(cfg_monijybuildconfig_get,buildid)
local builddatas=DuJieZhiBaoController:getBuildDataDjzb()
local builddata=builddatas[buildid]
local isdzreddot=false
local jieduan=0
if builddata then
if builddata.jzdata then
local flag=builddata.jzdata.flag
if flag then
if flag==21 then
jieduan=2
end
else
jieduan=1
end
end
end

if jieduan>0 then

local allcfg=cfg_dujietreasuresbasicconfig_get(1)
local DuJiedata=DuJieZhiBaoModel:getDJZBData()
local jctjpeople=JiuChongTianJieEnterModel:getOpenTianJiePeople()
local feisheng_cfg=allcfg.server_reduce_conf
local fs_data=nil
for k,v in ipairs(feisheng_cfg)do
if v[1]<=jctjpeople and v[2]>=jctjpeople then
fs_data=v
end
end
local refine_rate2=allcfg.refine_rate[jieduan]
if fs_data then
local rate=fs_data[3]
local rate2=100-rate
refine_rate2=refine_rate2*(rate2/100)
end
local now_rate2=0
if DuJiedata and DuJiedata[buildid]then
now_rate2=DuJiedata[buildid].refine_rate or 0
end

if now_rate2>=refine_rate2 then
local rewards=cfg.repair_cost[jieduan]
local isenough=true
for k,v in ipairs(rewards)do
local itemid=v[1]
local itemnum=v[2]
local havecount=0
if moneyConfig.isMoney(itemid)then
havecount=moneyModel.getMoney(itemid)
else
havecount=bagModel.getItemCountById(itemid)
end

if havecount<itemnum then
isenough=false
break
end
end
isdzreddot=isenough
end
end

return isdzreddot
end


function DuJieZhiBaoController:checklianhuaAllReddot()
if not systemModel.isOpen(SYSTEM_DEFINE.eDuJieZhiBao)then
return false
end
local builddatas=DuJieZhiBaoController:getBuildDataDjzb()
local isdzreddot=false
local allcfg=cfg_dujietreasuresbasicconfig_get(1)
local DuJiedata=DuJieZhiBaoModel:getDJZBData()
local jctjpeople=JiuChongTianJieEnterModel:getOpenTianJiePeople()
local feisheng_cfg=allcfg.server_reduce_conf
local fs_data=nil
for k,v in ipairs(feisheng_cfg)do
if v[1]<=jctjpeople and v[2]>=jctjpeople then
fs_data=v
end
end
for i,j in pairs(builddatas)do
local builddata=j
local buildid=builddata.jzid
local cfg=cfgHelper.get1(cfg_monijybuildconfig_get,buildid)
local jieduan=0
if builddata then
if builddata.jzdata then
local flag=builddata.jzdata.flag
if flag then
if flag==21 then
jieduan=2
end
else
jieduan=1
end
end
end

if jieduan>0 then

local refine_rate2=allcfg.refine_rate[jieduan]
if fs_data then
local rate=fs_data[3]
local rate2=100-rate
refine_rate2=refine_rate2*(rate2/100)
end
local now_rate2=0
if DuJiedata and DuJiedata[buildid]then
now_rate2=DuJiedata[buildid].refine_rate or 0
end

if now_rate2>=refine_rate2 then
local rewards=cfg.repair_cost[jieduan]
local isenough=true
for k,v in ipairs(rewards)do
local itemid=v[1]
local itemnum=v[2]
local havecount=0
if moneyConfig.isMoney(itemid)then
havecount=moneyModel.getMoney(itemid)
else
havecount=bagModel.getItemCountById(itemid)
end

if havecount<itemnum then
isenough=false
break
end
end
isdzreddot=isenough
if isdzreddot then
break
end
end
end
end
return isdzreddot
end


function DuJieZhiBaoController:refreshDJZBHUD()
if not systemModel.isOpen(SYSTEM_DEFINE.eDuJieZhiBao)then
return false
end
local builddatas=DuJieZhiBaoController:getBuildDataDjzb()

for k,v in pairs(builddatas)do
if v.jzdata and v.model then
if v.model==1 and v.jzdata.rpId then
hudControl:refreshBuildingStatusHUD(v.jzdata.rpId)
elseif v.model==2 and v.jzdata.un_build_id then
hudControl:refreshBuildingStatusHUD(v.jzdata.un_build_id)
end
end
end
end


function DuJieZhiBaoController:testtttt(buildid)
UIFullDuJieZhiBaoControl:showDJZBWindow({2,buildid})
end

