







local _LuaHelper=CS.LuaHelper

activitiesHandle_taiguBoss=new_activitiesHandle('activitiesHandle_taiguBoss',activitiesHandle)



local showRewards

function activitiesHandle_taiguBoss:onEnterState()

end

function activitiesHandle_taiguBoss:onLeaveState()

end

function activitiesHandle_taiguBoss:get_showRewards()
return showRewards
end

local nowbossID
local endbossID


function activitiesHandle_taiguBoss.recv_249_151(...)






local args={...}
local subType=SUB_ACTIVITY_TYPE.eTaiGuShiLian
local actID=args[1]
local subID=args[2]
local data=activitiesModel:getSubActInfoData(actID,subType,subID)

if data==nil then return end
data.severBosslist={}
if args[3]>0 then
local bossdata=args[4]
for k,v in ipairs(bossdata)do
data.severBosslist[v.bossid]=v
end
end
data.monlv=args[5]or 0
data.AllRanklist={}
data.Ranklist={}
data.activityOutFlag=false

activitiesModel:setSubActInfoData(actID,subType,subID,data)
reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,subType)


local info=activitiesModel:getSubActInfo(actID,subType,subID)
local list=activitiesHandle_taiguBoss:checkbossOpen(actID,subType,subID)
local start_time=info.start_time
nowbossID=1
endbossID=0
for k,v in ipairs(list)do
if v==1 then
nowbossID=k
end
if v==2 then
endbossID=k
end
end


local flag=userActorSetting.get(FMT.fmt('actid{0}_subid{1}_time{2}_tgsljiesuan',actID,subID,start_time),false)
if not flag then

flag=endbossID
userActorSetting.set(FMT.fmt('actid{0}_subid{1}_time{2}_tgsljiesuan',actID,subID,start_time),flag)
end


local flag2=userActorSetting.get(FMT.fmt('actid{0}_subid{1}_time{2}_tgslopen',actID,subID,start_time),false)
if not flag2 then
flag2=0
userActorSetting.set(FMT.fmt('actid{0}_subid{1}_time{2}_tgslopen',actID,subID,start_time),flag2)
end


local flag3=userActorSetting.get(FMT.fmt('actid{0}_subid{1}_time{2}_tgsldaojishi',actID,subID,start_time),false)
if not flag3 then
flag3=0
userActorSetting.set(FMT.fmt('actid{0}_subid{1}_time{2}_tgsldaojishi',actID,subID,start_time),flag3)
end


local flag4=userActorSetting.get(FMT.fmt('actid{0}_subid{1}_time{2}_tgsldjtwo',actID,subID,start_time),false)
if not flag4 then
flag4=0
userActorSetting.set(FMT.fmt('actid{0}_subid{1}_time{2}_tgsldjtwo',actID,subID,start_time),flag4)
end


local flag5=userActorSetting.get(FMT.fmt('actid{0}_subid{1}_time{2}_tgslopenboss',actID,subID,start_time),false)
if not flag5 then
flag5=0
userActorSetting.set(FMT.fmt('actid{0}_subid{1}_time{2}_tgslopenboss',actID,subID,start_time),flag5)
end


info:startActTime()
end


function activitiesHandle_taiguBoss.recv_249_152(...)





local args={...}
local subType=SUB_ACTIVITY_TYPE.eTaiGuShiLian
local actID=args[1]
local subID=args[2]
local data=activitiesModel:getSubActInfoData(actID,subType,subID)

if data==nil then return end
data.bossid=args[3]
data.Ranklist={}

local List={}
if args[4]>0 then
data.Ranklist=args[5]
local cfg=cfg_taigushilianconfig_get(subID).boss[data.bossid]


local list=cfg[6]

local _idx=1
local _num=0
for k,v in ipairs(list)do
for i=1,(v[1]-_num)do
local _data=data.Ranklist[_idx]
if _data then
local dame=_data.totaldamage
if type(dame)~="number"then
dame=mathHelper.int64_to_number(dame)
end

local bdlist=v[3]
local bddame=activitiesHandle_taiguBoss:getbaodiDeamValue(actID,subType,subID,bdlist,data.bossid)
if dame>=bddame then
table.insert(List,_data)
_idx=_idx+1
else
table.insert(List,false)
end
else
table.insert(List,false)
end

end
_num=v[1]
end

if not List[1]then

local bdlist=list[1][3]
local bddame=activitiesHandle_taiguBoss:getbaodiDeamValue(actID,subType,subID,bdlist,data.bossid)
local temp={flag=bddame,idx=1}

List[1]=temp
end
if not List[2]then
local bdlist=list[2][3]
local bddame=activitiesHandle_taiguBoss:getbaodiDeamValue(actID,subType,subID,bdlist,data.bossid)
local temp={flag=bddame,idx=2}

List[2]=temp
end
if not List[3]then
local bdlist=list[3][3]
local bddame=activitiesHandle_taiguBoss:getbaodiDeamValue(actID,subType,subID,bdlist,data.bossid)
local temp={flag=bddame,idx=3}

List[3]=temp
end
data.Ranklist=List
else
local cfg=cfg_taigushilianconfig_get(subID).boss[data.bossid]
local list=cfg[6]

if not List[1]then
local bdlist=list[1][3]
local bddame=activitiesHandle_taiguBoss:getbaodiDeamValue(actID,subType,subID,bdlist,data.bossid)
local temp={flag=bddame,idx=1}
List[1]=temp
end
if not List[2]then
local bdlist=list[2][3]
local bddame=activitiesHandle_taiguBoss:getbaodiDeamValue(actID,subType,subID,bdlist,data.bossid)
local temp={flag=bddame,idx=2}
List[2]=temp
end
if not List[3]then
local bdlist=list[3][3]
local bddame=activitiesHandle_taiguBoss:getbaodiDeamValue(actID,subType,subID,bdlist,data.bossid)
local temp={flag=bddame,idx=3}
List[3]=temp
end
data.Ranklist=List
end
if data.AllRanklist then
data.AllRanklist[data.bossid]=data.Ranklist
else
data.AllRanklist={}
data.AllRanklist[data.bossid]=data.Ranklist
end
















































































































activitiesModel:setSubActInfoData(actID,subType,subID,data)


UIManager:invokeUIMethod('UISubAct_taigushilianWin','refreshBossRank',actID,subType,subID,data.bossid)
UIManager:invokeUIMethod('UISubAct_tgslRankWin','recv_paihangbang',actID,subType,subID)
end


function activitiesHandle_taiguBoss:getbaodiDeamValue(actID,subType,subID,bdlist,bossid)
local monlv=activitiesHandle_taiguBoss:getMonlv(actID,subType,subID)
local cfg=cfg_taigushilianconfig_get(subID).boss[bossid]
local bossmonlv=cfg[1][4][2]
local pylevel=monlv+bossmonlv
local bddame=0
if bdlist then

for m,n in ipairs(bdlist)do
if pylevel<=n[1]then
bddame=n[2]
break
end
end
end

return bddame
end


function activitiesHandle_taiguBoss.recv_249_153(...)




local args={...}
local subType=SUB_ACTIVITY_TYPE.eTaiGuShiLian
local actID=args[1]
local subID=args[2]
local data=activitiesModel:getSubActInfoData(actID,subType,subID)

if data==nil then return end
data.bossid=args[3]
data.recvaimid=args[4]or 0
if data.severBosslist then
if data.severBosslist[data.bossid]then
data.severBosslist[data.bossid].recvaimid=data.recvaimid
end
end

activitiesModel:setSubActInfoData(actID,subType,subID,data)
reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,subType)

UIManager:invokeUIMethod('UISubAct_tgslRankWin','recv_reward',actID,subType,subID)
UIManager:invokeUIMethod('UISubAct_taigushilianWin','refreshBossDamage',actID,subType,subID)
UIManager:invokeUIMethod('UISubAct_taigushilianWin','refreshReddot')
UIManager:invokeUIMethod('UISubAct_taigushilianWin','refreshbjbtnimg',actID,subType,subID)
end


function activitiesHandle_taiguBoss:checkbossOpen(actID,subType,subid)
local bossliststate={}
local mydata=activitiesModel:getSubActInfoData(actID,subType,subid)
if mydata then
local sub_actInfo=activitiesModel:getSubActInfo(actID,subType,subid)
local start_time=sub_actInfo.start_time
local nowstamp=timeHelper.getServerShortTime()
local cfg=cfg_taigushilianconfig_get(subid).boss
for k,v in ipairs(cfg)do
local bossstart=v[2]+start_time
local bossend=v[3]+start_time
if nowstamp<bossstart then
bossliststate[k]=0
end
if nowstamp>=bossstart and nowstamp<bossend then
bossliststate[k]=1
end
if nowstamp>=bossend then
bossliststate[k]=2
end
end
end

return bossliststate
end


function activitiesHandle_taiguBoss:grtbossOpen(actID,subType,subid)
local mydata=activitiesModel:getSubActInfoData(actID,subType,subid)
if mydata then

end
end


function activitiesHandle_taiguBoss:clearbossdata(actID,subType,subid)

local strkey=FMT.fmt("taiguBoss_{0}_{1}_{2}",tostring(actID),tostring(subType),tostring(subid))
local bossarry=userActorSetting.get(strkey,{})
if bossarry and#bossarry>0 then

end
end


function activitiesHandle_taiguBoss:getDamageRole(actID,subType,subid,bossid)
local all_damage=0
local mydata=activitiesModel:getSubActInfoData(actID,subType,subid)
if mydata then
local severBosslist=mydata.severBosslist
if mydata.severBosslist then
local severBossdata=severBosslist[bossid]
if severBossdata then

if severBossdata.damagelistlen and severBossdata.damagelistlen>0 then
local damagelist=severBossdata.damageList or{}
for k,v in ipairs(damagelist)do
local num=0
if type(v)~="number"then
num=mathHelper.int64_to_number(v)
else
num=v
end
all_damage=all_damage+math.abs(num)
end
end
end
end
end


return all_damage
end


function activitiesHandle_taiguBoss:checkBossNanDuPass(actID,subType,subid,bossid,idx)
local mydata=activitiesModel:getSubActInfoData(actID,subType,subid)
if mydata then

local severBosslist=mydata.severBosslist
if mydata.severBosslist then
local severBossdata=severBosslist[bossid]
if severBossdata then
if severBossdata.damagelistlen and severBossdata.damagelistlen>0 then
local damagelist=severBossdata.damageList
if damagelist[idx]then
local num=0
if type(damagelist[idx])~="number"then
num=mathHelper.int64_to_number(damagelist[idx])
else
num=damagelist[idx]
end

return num
end
end
end
end
end
return false
end


function activitiesHandle_taiguBoss:getSubOpenDayIndex(actID,subType,subid)
local sub_actInfo=activitiesModel:getSubActInfo(actID,subType,subid)
local startday=sub_actInfo.start_time_l
return activitiesModel.get_open_day_index(startday)or 1
end


function activitiesHandle_taiguBoss:setBossJieDuanDamege(actID,subType,subid,bossid,guankaIdx,damage)
local mydata=activitiesModel:getSubActInfoData(actID,subType,subid)
if mydata then
if damage then
if type(damage)~="number"then
damage=mathHelper.int64_to_number(damage)
end
end
if not mydata.severBosslist then
mydata.severBosslist={}
end
if mydata.severBosslist[bossid]then

local data=mydata.severBosslist[bossid]
local bossid=data.bossid
local len=data.damagelistlen
local damagelist=data.damageList
local recvaimid=data.recvaimid
if len>0 then
if damagelist[guankaIdx]then
if damage<=0 then

damagelist[guankaIdx]=damage
else

local num=0
if damagelist[guankaIdx]then
if type(damagelist[guankaIdx])~="number"then
num=mathHelper.int64_to_number(damagelist[guankaIdx])
else
num=damagelist[guankaIdx]
end
end
damagelist[guankaIdx]=math.max(num or 0,damage)
end
else
len=len+1
damagelist[guankaIdx]=damage
end
end
mydata.severBosslist[bossid]={bossid=bossid,damagelistlen=len,damageList=damagelist,recvaimid=recvaimid}
else
mydata.severBosslist[bossid]={}
local bossid=bossid
local len=1
local damagelist={}
damagelist[guankaIdx]=damage
local recvaimid=0
mydata.severBosslist[bossid]={bossid=bossid,damagelistlen=len,damageList=damagelist,recvaimid=recvaimid}
end

activitiesModel:setSubActInfoData(actID,subType,subid,mydata)
end
end


function activitiesHandle_taiguBoss:getBossJieDuanDamegelist(actID,subType,subid,bossid)
local mydata=activitiesModel:getSubActInfoData(actID,subType,subid)
if mydata then

local monlv=mydata.monlv
if monlv then
local cfg=cfg_taigushilianconfig_get(subid).boss
local monlv_cfg=cfg[bossid][5]
if monlv_cfg then
for k,v in ipairs(monlv_cfg)do
if monlv<=v[1]then
return v[2]
end
end
end
end
end
return nil
end


function activitiesHandle_taiguBoss:getBossJieDuanDamegeIdx(actID,subType,subid,bossid)
local mydata=activitiesModel:getSubActInfoData(actID,subType,subid)
local idx=0
if mydata then
local JieDuanDamegelist=activitiesHandle_taiguBoss:getBossJieDuanDamegelist(actID,subType,subid,bossid)

if JieDuanDamegelist then
local score=activitiesHandle_taiguBoss:getDamageRole(actID,subType,subid,bossid)
for k,v in ipairs(JieDuanDamegelist)do
if score>=v[1]then
idx=k
end
end
end
end
return idx
end


function activitiesHandle_taiguBoss:getBossTongGuangIdx(actID,subType,subid,bossid)
local mydata=activitiesModel:getSubActInfoData(actID,subType,subid)
local idx=0
if mydata then

local severBosslist=mydata.severBosslist
if mydata.severBosslist then
local severBossdata=severBosslist[bossid]
if severBossdata then
if severBossdata.damagelistlen and severBossdata.damagelistlen>0 then
return severBossdata.damagelistlen
end
end
end
end
return idx
end


function activitiesHandle_taiguBoss:getBossNormalIdx(actID,subType,subid,bossid)
local mydata=activitiesModel:getSubActInfoData(actID,subType,subid)
local idx=0
local iconidx=0
if mydata then
local monlv=mydata.monlv
if monlv then
local score=activitiesHandle_taiguBoss:getDamageRole(actID,subType,subid,bossid)
local damagelevel=cfg_taigushilianconfig_get(subid).damagelevel
local tempArry={}
for k,v in ipairs(damagelevel)do
if monlv<=v[1]then
tempArry=v[2]
break
end
end

if#tempArry>0 then
for k,v in ipairs(tempArry[bossid])do
if score>=v[1]then
idx=k
iconidx=v[2]
end
end
end
end

end
return idx,iconidx
end


function activitiesHandle_taiguBoss:getBossJieDuanDamageValue(actID,subType,subid,bossid,guankaIdx)
local mydata=activitiesModel:getSubActInfoData(actID,subType,subid)
if mydata then
local severBosslist=mydata.severBosslist
if mydata.severBosslist then
local severBossdata=severBosslist[bossid]
if severBossdata then
if severBossdata.damageList then
if severBossdata.damageList[guankaIdx]then
local num=0
local value=severBossdata.damageList[guankaIdx]
if type(value)~="number"then
num=mathHelper.int64_to_number(value)
else
num=value
end
return num,true
end
end
end
end
end
return 0,false
end


function activitiesHandle_taiguBoss.onShowPrize(prizeType,prizelist,effectData)

if prizeType==ePrizeType.eShiZhuanJianLi then




if effectData and prizelist then
local subType=SUB_ACTIVITY_TYPE.eDressLottery
local actID=effectData.actid
local subID=effectData.act2id
local data=activitiesModel:getSubActInfoData(actID,subType,subID)
if data==nil then return end

data.use_free_times=effectData.use_free_times
data.history_use_times=effectData.history_use_times
data.specialPrize={}
data.specialPrize=prizelist

activitiesModel:setSubActInfoData(actID,subType,subID,data)

UIManager:invokeUIMethod('UISubAct_shizhuanchoujianWin','checkSuitReward')
UIManager:invokeUIMethod('UISubAct_shizhuanchoujianWin','handelShowBuySuccess')
UIManager:invokeUIMethod('UISubAct_shizhuanchoujianWin','refreshCostBtn')
UIManager:invokeUIMethod('UISubAct_shizhuanchoujianWin','baodinum')
reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,subType)
else
UIManager.error('抽奖失败')
end

end
end


function activitiesHandle_taiguBoss:checkreddotSingleBoss(actID,subType,subid,bossid)
local reddotlist={}
local mydata=activitiesModel:getSubActInfoData(actID,subType,subid)
if mydata then



local severBosslist=mydata.severBosslist
local monlv=mydata.monlv
if mydata.severBosslist then
local all_damage=activitiesHandle_taiguBoss:getDamageRole(actID,subType,subid,bossid)
local cfg=cfg_taigushilianconfig_get(subid).boss
local cfg_damagelist={}
local monlv_cfg=cfg[bossid][5]
for k,v in ipairs(monlv_cfg)do
if monlv<=v[1]then
cfg_damagelist=v[2]
break
end
end
if severBosslist[bossid]then
local recvaimid=severBosslist[bossid].recvaimid or 0
for k,v in ipairs(cfg_damagelist)do
reddotlist[#reddotlist+1]=0
if all_damage>=v[1]then
if recvaimid>=k then
reddotlist[k]=1
else
reddotlist[k]=2
end
end
end
else
for i,j in ipairs(cfg_damagelist)do
reddotlist[#reddotlist+1]=0
end
end
end
end
if#reddotlist>0 then
for i,j in ipairs(reddotlist)do
if j==2 then
return true,reddotlist
end
end
end
return false,reddotlist
end


function activitiesHandle_taiguBoss:checkActivityIocnShow(actID,subType,subid,flag)

end


function activitiesHandle_taiguBoss:checkreddotBossAll(actID,subType,subid)
local reddot=false
local mydata=activitiesModel:getSubActInfoData(actID,subType,subid)
if mydata then
local boss_config=cfg_taigushilianconfig_get(subid).boss
local list={}
local statelist=activitiesHandle_taiguBoss:checkbossOpen(actID,subType,subid)
for k,v in ipairs(boss_config)do
if statelist[k]==2 or statelist[k]==1 then
table.insert(list,v)
end
end
if#list>0 then
for k,v in ipairs(list)do
local bossid=v[7]
local flag=activitiesHandle_taiguBoss:checkreddotSingleBoss(actID,subType,subid,bossid)

if flag then
reddot=true
break
end
end
end
end

return reddot
end



function activitiesHandle_taiguBoss:checkIsNewBoss(actID,subType,subid,bossid)

local mydata=activitiesModel:getSubActInfoData(actID,subType,subid)
if mydata then


if not mydata.severBosslist then
return false
end
end
local statelist=activitiesHandle_taiguBoss:checkbossOpen(actID,subType,subid)
if statelist[bossid]and statelist[bossid]==1 then
local guankaIdx=1
local damage,isbattle=activitiesHandle_taiguBoss:getBossJieDuanDamageValue(actID,subType,subid,bossid,guankaIdx)

if damage==0 and not isbattle then
return true
end
if damage>-1 or isbattle then
return false
end
end
return false
end

function activitiesHandle_taiguBoss:checkIsNewBossYeQian(actID,subType,subid)
local reddot=false
local boss_config=cfg_taigushilianconfig_get(subid).boss
local statelist=activitiesHandle_taiguBoss:checkbossOpen(actID,subType,subid)
for k,v in ipairs(boss_config)do
if statelist[k]==1 then
local _reddot=activitiesHandle_taiguBoss:checkIsNewBoss(actID,subType,subid,k)
if _reddot then
reddot=true
break
end
end
end

return reddot
end


function activitiesHandle_taiguBoss:checkIsLastDayBoss(actID,subType,subid)
local reddot=false
local info=activitiesModel:getSubActInfo(actID,subType,subid)
local startday=info:getOpenDayIndex()
local faze=cfg_taigushilianconfig_get(subid).faze
if startday>=#faze then


local info=activitiesModel:getSubActInfo(actID,subType,subid)
local start_time=info.start_time
local flag5=userActorSetting.get(FMT.fmt('actid{0}_subid{1}_time{2}_tgsllastday',actID,subid,start_time),false)
if not flag5 then
local cfg=cfg_taigushilianconfig_get(subid).boss
local index=#cfg
for k,v in ipairs(cfg)do
local index=index-1
local _reddot=activitiesHandle_taiguBoss:checkNowBossIsBattle(actID,subType,subid,index)
if _reddot then
reddot=true
break
end
end
end
end

return reddot
end


function activitiesHandle_taiguBoss:checkIsLastDayBossSingle(actID,subType,subid,bossid)
local reddot=false
local info=activitiesModel:getSubActInfo(actID,subType,subid)
local startday=info:getOpenDayIndex()
local faze=cfg_taigushilianconfig_get(subid).faze
if startday>=#faze then
local info=activitiesModel:getSubActInfo(actID,subType,subid)
local start_time=info.start_time
local flag5=userActorSetting.get(FMT.fmt('actid{0}_subid{1}_time{2}_tgsllastday',actID,subid,start_time),false)
if not flag5 then
local _reddot=activitiesHandle_taiguBoss:checkNowBossIsBattle(actID,subType,subid,bossid)
if _reddot then
reddot=true
end
end
end

return reddot
end


function activitiesHandle_taiguBoss:checkNowBossIsBattle(actID,subType,subid,bossid)
local reddot=false

local bossState=activitiesHandle_taiguBoss:checkbossOpen(actID,subType,subid)
local isJieShuan=bossState[bossid]
if isJieShuan and isJieShuan==2 then


local jianglilist=activitiesHandle_taiguBoss:getBossJieDuanDamegelist(actID,subType,subid,bossid)
local alldamage=0
alldamage=activitiesHandle_taiguBoss:getDamageRole(actID,subType,subid,bossid)
if type(alldamage)~="number"then
alldamage=mathHelper.int64_to_number(alldamage)
end
if jianglilist and#jianglilist and jianglilist[#jianglilist]then
local _max=jianglilist[#jianglilist][1]
if _max and alldamage<_max then
reddot=true
end
end
end

return reddot
end


function activitiesHandle_taiguBoss:getMonlv(actID,subType,subid)
local mydata=activitiesModel:getSubActInfoData(actID,subType,subid)
if mydata then
return mydata.monlv or 0
end
end
