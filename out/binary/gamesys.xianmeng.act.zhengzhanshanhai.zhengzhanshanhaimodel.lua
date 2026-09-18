







zhengzhanshanhaiModel={}
zhengzhanshanhaiModel.clickEntityCoolTime=0.5
zhengzhanshanhaiModel.clickBtnCoolTime=0.5
zhengzhanshanhaiModel.grid2CircleEffect=0.18
zhengzhanshanhaiModel.entityShowCircleRadius=2
zhengzhanshanhaiModel.maskPvP=false


zhengzhanshanhaiModel.opType={
eInit=-1,
eDel=0,
eAdd=1,
eRefresh=2,
}


zhengzhanshanhaiModel.qbType={
eMonster=1,
eResource=2,
eLingShan=3,
}


eZZSH_State={
eIdle=1,
ePVPStandby=2,
ePVPFight=3,
ePVEFight=4,
}


eZZSH_Season_State={
eNone=0,
ePlanting=1,
eSettlement=2,
eOffSeason=3,
}

local mapBaseCofig
local dontMovePosLookup
local qingbaoDetailRefreshTime=30
local jijieRefreshTime=30
local zhaojiCoolTime=60
local fastCheckBXKeyLookup

function zhengzhanshanhaiModel.getPosKey(x,y)
return x*10000+y
end

function zhengzhanshanhaiModel:get_mapBaseCfg()
if mapBaseCofig==nil then
local baseCfgName="zhengzhanshanhaimapbaseconfig"
local bgMapId=zhengzhanshanhaiController:getZZSHCfg("bgmapid")
if bgMapId then
local mapCfg=cfgHelper.get(cfg_zhengzhanshanhaimapnewconfig_get,bgMapId)
baseCfgName=mapCfg.mapCfgName
end
local cfgPathStr=string.format('lua.gamesys.xianmeng.act.zhengzhanshanhai.%s',baseCfgName)
mapBaseCofig=require(cfgPathStr)
dontMovePosLookup={}
local forbid=zhengzhanshanhaiController:getZZSHCfg('forbid')
for i,v in ipairs(forbid)do
local libs=v[1]
local radius=v[2]
for i2,libid in ipairs(libs)do
local poslist=mapBaseCofig.libs[libid]
if poslist then
for i3,pos in ipairs(poslist)do
local key=zhengzhanshanhaiModel.getPosKey(pos[1],pos[2])
dontMovePosLookup[key]={pos[1],pos[2],radius}
end
end
end
end
end
return mapBaseCofig
end

function zhengzhanshanhaiModel:initDefaultData()
self.pveSetting={}
self.entityAutoScaleMin=zhengzhanshanhaiController:getZZSHCfg('entityAutoScaleMin')

self.raceList={}
local cfgs=cfg_zhengzhanshanhaisessionconfig()
for i,v in ipairs(cfgs)do
local s_t=timeHelper.dataToTimeStam(v.time[1])
local e_t=timeHelper.dataToTimeStam(v.time[2])
local d={s_t,e_t,v.id}
table.insert(self.raceList,d)
end
end

function zhengzhanshanhaiModel:clearData()
self.data=nil
self.baseData=nil
self.isModel=nil
self.raceIndex=nil
self.lingdiCfgLookup=nil
self.lingdiPosLookup=nil
self.lingdiGridLookup=nil
self.pveMainOpenTeamFlag=nil
mapBaseCofig=nil
dontMovePosLookup=nil
fastCheckBXKeyLookup=nil

self.initBoxData=nil
self.initBoxData_season=nil
self.treasureBoxData=nil
self.treasureBoxData_season=nil
self.mZhaoJiCoolTime=nil
self.pveSetting=nil
self.entityAutoScaleMin=nil
self.raceList=nil
self.seasonData=nil

self.MomentumData=nil
zhengzhanshanhaiModel:clearData_WeekTask()
end

function zhengzhanshanhaiModel:clearDataGM()
self.data={}
self.baseData=nil
self.seasonData=nil
zhengzhanshanhaiController:clearListenMark()
UIManager:invokeUIMethod('UIXM_ZZSH_MapWin','closeWin')
end

function zhengzhanshanhaiModel:clearData_changeSeason()
zhengzhanshanhaiModel:set_zzshModel(nil)

zhengzhanshanhaiModel:removeAllEntitys()
if zhengzhanshanhaiModel:checkJoin()then

zhengzhanshanhaiController:reqMapListen_initial(0)
zhengzhanshanhaiController:reqMapListen_season(0)
end

self.data=nil
self.baseData=nil
mapBaseCofig=nil
end

function zhengzhanshanhaiModel:clearMapBasConfig()
mapBaseCofig=nil
end

function zhengzhanshanhaiModel:initData(teamList,attend,searchtimes)
local isInit=false
if self.data==nil then
self.data={}
isInit=true
end
local defTeamLookup={}
if teamList then
for i,v in ipairs(teamList)do
defTeamLookup[v.idx]=v
end
end
self.data.defTeamLookup=defTeamLookup
self.data.attend=attend


if not self.initBoxData then
self.treasureBoxData={}
self:initTreasureBoxData_initial()
end

return isInit
end

function zhengzhanshanhaiModel:checkInit()
return self.data~=nil
end

function zhengzhanshanhaiModel:checkBaseDataRefersh()
if self.baseData==nil then
zhengzhanshanhaiController:reqInfo2()
end
end

function zhengzhanshanhaiModel:initBaseData(availv,momentum,searchtimes)
if self.baseData==nil then
self.baseData={}
end
self.baseData.momentum=momentum
self.baseData.availv=availv
zhengzhanshanhaiModel:setSearchUsed(searchtimes)
end

function zhengzhanshanhaiModel:getMonsterLv(cfg)
local lv=cfg.monster[2]or 0
local availv=zhengzhanshanhaiModel:getPlayerAverageLv()

local num=availv+lv
if num<0 then num=0 end
return num
end


function zhengzhanshanhaiModel:getPlayerAverageLv()
local shSeasonId=zhengzhanshanhaiModel:getSHSeasonId()
if shSeasonId==-1 then

return self.baseData.availv
else

local shSeasonLv=zhengzhanshanhaiModel:getSeasonLv()or 0
local mon_level=zhengzhanshanhaiController:getZZSHCfg_yishou_getdef('mon_level')
if mon_level then
local maxLevel=#mon_level
if shSeasonLv<=maxLevel then
return mon_level[shSeasonLv]
else
return mon_level[maxLevel]
end
else
return shSeasonLv
end
end
end

function zhengzhanshanhaiModel:setPvEMoveTime(time,needRefresh)
if self.baseData then
if time~=nil then
time=time+zhengzhanshanhaiModel:getPvEMoveCoolTime()
end
self.baseData.pveMoveTime=time
if needRefresh then
UIManager:invokeUIMethod('UIXM_ZZSH_PvEMainWin','refershMoveBtn')
end
end
end

function zhengzhanshanhaiModel:getPvEMoveTime()
if self.baseData then
return self.baseData.pveMoveTime
end
end

function zhengzhanshanhaiModel:getPvEMoveCoolTime()
local move=zhengzhanshanhaiController:getZZSHCfg('movecd')
return move
end


function zhengzhanshanhaiModel:getMonsterBattleStage()
local max_=zhengzhanshanhaiController:getZZSHCfg_yishou_getdef('max')

local add=xianmengModel:GetSkill_Effect(eXMMouLueEffectType.eZZSHAddMonsterJiJieStage)
local max=max_+add
return max,add,max_
end

function zhengzhanshanhaiModel:checkMonsterBattleState(stage,isWarning)
local max,add,max_=zhengzhanshanhaiModel:getMonsterBattleStage()
local lerp=max-stage
if lerp<0 then
local lerp_=stage-max_
if isWarning then
UIManager.error(FMT.fmt('仙盟谋略“山海巡狩”升级至{0}级可集结',lerp_))
end
return false,lerp_
end
return true
end

function zhengzhanshanhaiModel:is_in_mapModel()
return self.isModel==true
end

function zhengzhanshanhaiModel:set_zzshModel(v)
self.isModel=v
end

function zhengzhanshanhaiModel:setJoin()
if self.data then
self.data.attend=1
end
end

function zhengzhanshanhaiModel:checkJoin()
if self.data then
return self.data.attend==1
end
return false
end

function zhengzhanshanhaiModel:setSearchUsed(times)
if self.baseData then
self.baseData.searchtimes=times
self.baseData.searchtimes_time=gameUtilityModel.getServerLongTime()
end
end

function zhengzhanshanhaiModel:getSearchUsed()
if self.baseData then
local used=self.baseData.searchtimes
if used then
local time=self.baseData.searchtimes_time
local y,m,d=timeHelper.getServerData()
local t1=timeHelper.timeServer(y,m,d,0,0,5)
if time>=t1 then
return used
else
local cur=gameUtilityModel.getServerLongTime()
if cur<t1 then
return used
else
self.baseData.searchtimes_time=cur
self.baseData.searchtimes=0
return 0
end
end
end
end
return nil
end

function zhengzhanshanhaiModel:getSearchNum()
local max=zhengzhanshanhaiController:getZZSHCfg_search_getdef('max')
local used=zhengzhanshanhaiModel:getSearchUsed()
local cur=max-used
return cur,max
end

function zhengzhanshanhaiModel:setpveMainOpenTeamFlag(flag)
self.pveMainOpenTeamFlag=flag
end

function zhengzhanshanhaiModel:checkpveMainOpenTeamFlag()
return self.pveMainOpenTeamFlag==nil or self.pveMainOpenTeamFlag==true
end

function zhengzhanshanhaiModel:getXuKongLing()
return moneyModel.getMoney(eMoneyType.mtXuKongLing)
end

function zhengzhanshanhaiModel:getXuKongLingNeed(infotype)
local need
if infotype==zhengzhanshanhaiModel.qbType.eMonster then
need=zhengzhanshanhaiController:getZZSHCfg('consume',1)
else
need=zhengzhanshanhaiController:getZZSHCfg('consume',2)
end
return need
end

function zhengzhanshanhaiModel:checkXuKongLingCost(infotype,isWarning)
local need=zhengzhanshanhaiModel:getXuKongLingNeed(infotype)
local has=zhengzhanshanhaiModel:getXuKongLing()
if has<need then
if isWarning then

gainControl:showGainWin(eMoneyType.mtXuKongLing)
end
return false
end
return true
end



function zhengzhanshanhaiModel:checkInDefTeam(dis_guid)
local data=self.data
if data then
local defTeamLookup=data.defTeamLookup
if defTeamLookup then
for k,v in pairs(defTeamLookup)do
if v.guidList then
for i,dis_guid_ in ipairs(v.guidList)do
if dis_guid_==dis_guid then
return true
end
end
end
end
end
end
return false
end

function zhengzhanshanhaiModel:getInDefTeamDZ(teamIdx,posIdx)
local data=self.data
if data then
local defTeamLookup=data.defTeamLookup
if defTeamLookup then
local team=defTeamLookup[teamIdx]
if team then
local dis_guid=team[posIdx]
if mathHelper.validInt64(dis_guid)then
local netData=UIDiscipleModel:getDiscipleData(dis_guid)
return netData
end
end
end
end
return nil
end

function zhengzhanshanhaiModel:setDefTeams(list)
local data=self.data
if data and data.defTeamLookup then
for i,v in ipairs(list)do
data.defTeamLookup[v.idx]=v
end
end
end

function zhengzhanshanhaiModel:getAllDefTeam()
local data=self.data
if data then
return data.defTeamLookup
end
end

function zhengzhanshanhaiModel:checkEmptyDefTeam()
local allTeams=zhengzhanshanhaiModel:getAllDefTeam()
if allTeams then
local max=zhengzhanshanhaiModel:getMaxWaiPaiNum_pvp()
for teamIdx=1,max do
if allTeams[teamIdx]==nil then
return true
end
end
end
return false
end





function zhengzhanshanhaiModel:getRaceData(curTime)
curTime=curTime or gameUtilityModel.getServerLongTime()
local f=nil
if self.raceList then
for i,v in ipairs(self.raceList)do
if curTime<v[2]then
f=v
break
end
end
end
if f then
return f[1],f[2],f[3]
end
end

function zhengzhanshanhaiModel:getLunList(start_time_l,end_time_l)
local o_y,o_m,o_d=timeHelper.getDateNumber(start_time_l)
local start_time_zero=timeHelper.timeServer(o_y,o_m,o_d,0,0,0)
local start_time_firstSat
local startWeakDay=timeHelper.getWeakDate(start_time_l)
local weekDay=6
startWeakDay=startWeakDay==0 and 7 or startWeakDay
local divDay
if startWeakDay<weekDay then
divDay=startWeakDay+1
else
divDay=startWeakDay-weekDay
end
start_time_firstSat=start_time_zero-divDay*24*3600

local o_time=start_time_firstSat
local lunList={}
local battle
local cfg=zhengzhanshanhaiController:getZZSHCfg()
local shSeasonId=zhengzhanshanhaiModel:getSHSeasonId()
if shSeasonId==-1 then
battle=cfg.battle
else
local deltaTime=end_time_l-o_time
battle=math.ceil(deltaTime/(7*86400))
end
local week=cfg.week
local pve=cfg.pve
for i=1,battle do
local time_l=o_time+(i-1)*7*86400
local lun={}
local d

for i,v in ipairs(week)do
d={time_l+v[1],time_l+v[2],eZZSH_State.ePVPStandby,i}
table.insert(lun,d)
d={time_l+v[2],time_l+v[3],eZZSH_State.ePVPFight,i}
table.insert(lun,d)
end

d={time_l+week[#week][3]+pve[2]}
if i<battle then
local time_l_=o_time+i*7*86400
d[2]=time_l_+week[1][1]-pve[1]
else
d[2]=end_time_l
end
d[3]=eZZSH_State.ePVEFight
d[4]=1
table.insert(lun,d)

table.insert(lunList,lun)
end
return lunList
end

















function zhengzhanshanhaiModel:getLunList2(start_time_l,end_time_l)

local c_t=start_time_l
local partlist={}
while c_t<end_time_l do
local o_y,o_m,o_d=timeHelper.getDateNumber(c_t)
local o_time=timeHelper.timeServer(o_y,o_m,o_d,0,0,0)
local o_t=o_time
local w=timeHelper.getWeakDateEx3(c_t)
local lerp_day
if w<=5 then
lerp_day=5-w+1
o_t=o_t-(w-1)*86400
else
lerp_day=7-w+5+1
o_t=o_t-(w-6)*86400
end
local e_t=o_time+lerp_day*86400
if e_t>end_time_l then
e_t=end_time_l
end
local d={c_t,e_t,o_t}
table.insert(partlist,d)
c_t=e_t
end

local lunList={}
local cfg=zhengzhanshanhaiController:getZZSHCfg()
local week=cfg.week
local pve=cfg.pve
local partNum=#partlist
for i=1,partNum do
local v=partlist[i]
local lun={}
local s_t=v[1]
local e_t=v[2]
local w=timeHelper.getWeakDateEx3(s_t)
local d,s_t_,e_t_
if w<=5 then


s_t_=s_t
e_t_=e_t
if i<partNum then
e_t_=e_t_+week[1][1]
if e_t_>end_time_l then
e_t_=end_time_l
end
end
if s_t_<e_t_ then
d={s_t_,e_t_,eZZSH_State.ePVEFight,1}
table.insert(lun,d)
end
else

local o_t=v[3]

if i==1 then
s_t_=s_t
e_t_=o_t+week[1][1]
if e_t_>e_t then
e_t_=e_t
end
if s_t_<e_t_ then
d={s_t_,e_t_,eZZSH_State.ePVEFight,1}
table.insert(lun,d)
end
end

for i2,v2 in ipairs(week)do
local t1=o_t+v2[1]
local t2=o_t+v2[2]
local t3=o_t+v2[3]

s_t_=t1
e_t_=t2
if s_t_<s_t then
s_t_=s_t
end
if e_t_>e_t then
e_t_=e_t
end
if s_t_<e_t_ then
d={s_t_,e_t_,eZZSH_State.ePVPStandby,i2}
table.insert(lun,d)
end

s_t_=t2
e_t_=t3
if s_t_<s_t then
s_t_=s_t
end
if e_t_>e_t then
e_t_=e_t
end
if s_t_<e_t_ then
d={s_t_,e_t_,eZZSH_State.ePVPFight,i2}
table.insert(lun,d)
end
end

s_t_=o_t+week[#week][3]+pve[2]
e_t_=e_t
if i<partNum then
e_t_=e_t_+week[1][1]
if e_t_>end_time_l then
e_t_=end_time_l
end
end
if s_t_<e_t_ then
d={s_t_,e_t_,eZZSH_State.ePVEFight,1}
table.insert(lun,d)
end
end
if#lun>0 then
table.insert(lunList,lun)
end
end

return lunList
end

function zhengzhanshanhaiModel:getCurLunPvETime()
local luntime=limitActivitiesModel:invokeMethod(LIMIT_ACT_TYPE.eZhengZhanShanHai,'getCurLunTime')
if luntime then

return luntime[#luntime]
end
end

function zhengzhanshanhaiModel:getLunState(cur)
local luntime=limitActivitiesModel:invokeMethod(LIMIT_ACT_TYPE.eZhengZhanShanHai,'getCurLunTime')
cur=cur or gameUtilityModel.getServerLongTime()
local raceState
local curState
local left

for i,v in ipairs(luntime)do
if cur>=v[1]and cur<v[2]then
raceState=v[3]
left=v[2]-cur
curState=-1
break
end
end

if raceState==nil then
local n=#luntime
for i,v in ipairs(luntime)do
if cur<v[1]then
raceState=eZZSH_State.eIdle
left=v[1]-cur
curState=v[3]
break
end
end
if raceState==nil then
raceState=eZZSH_State.eIdle
left=limitActivitiesModel:getActEndLeftTime(LIMIT_ACT_TYPE.eZhengZhanShanHai)
curState=nil
end
end
return raceState,left,curState
end



function zhengzhanshanhaiModel:getPvPIndex()
local luntime=limitActivitiesModel:invokeMethod(LIMIT_ACT_TYPE.eZhengZhanShanHai,'getCurLunTime')
local cur=gameUtilityModel.getServerLongTime()
local idx=0

for i,v in ipairs(luntime)do
if v[3]==eZZSH_State.ePVPFight and cur>=v[2]then
idx=idx+1
end
end
return idx
end



function zhengzhanshanhaiModel:getPvPIndex2()
local luntime=limitActivitiesModel:invokeMethod(LIMIT_ACT_TYPE.eZhengZhanShanHai,'getCurLunTime')
local cur=gameUtilityModel.getServerLongTime()
local idx=0

for i,v in ipairs(luntime)do
if v[3]==eZZSH_State.ePVPStandby and cur>=v[2]then
idx=idx+1
end
end
return idx
end

function zhengzhanshanhaiModel:getPvPFightTime()
local luntime=limitActivitiesModel:invokeMethod(LIMIT_ACT_TYPE.eZhengZhanShanHai,'getCurLunTime')
local cur=gameUtilityModel.getServerLongTime()

for i,v in ipairs(luntime)do
if cur>=v[1]and cur<v[2]then
if v[3]==eZZSH_State.ePVPFight then
return v[1],v[2]
elseif v[3]==eZZSH_State.ePVPStandby then
local nx=luntime[i+1]
if nx then
return nx[1],nx[2]
end
end
break
end
end
return nil,nil
end




function zhengzhanshanhaiModel:getPvETime()
local luntime=limitActivitiesModel:invokeMethod(LIMIT_ACT_TYPE.eZhengZhanShanHai,'getCurLunTime')
if luntime then
local n=#luntime
for i=n,1,-1 do
local v=luntime[i]
if v[3]==eZZSH_State.ePVEFight then
return v[1],v[2]
end
end
end
return nil,nil
end




function zhengzhanshanhaiModel:getPvPTime()
local luntime=limitActivitiesModel:invokeMethod(LIMIT_ACT_TYPE.eZhengZhanShanHai,'getCurLunTime')
if luntime then
local n=#luntime
local startTime,endTime
for i=n,1,-1 do
local v=luntime[i]
if v[3]==eZZSH_State.ePVPFight and endTime==nil then
endTime=v[2]
elseif v[3]==eZZSH_State.ePVPStandby then
startTime=v[1]
end
end
return startTime,endTime
end
return nil,nil
end


function zhengzhanshanhaiModel:getRaceIndex()
if limitActivitiesModel:checkActDoing(LIMIT_ACT_TYPE.eZhengZhanShanHai)then

return 1
else

return 0
end
end

function zhengzhanshanhaiModel:setRaceIndex(raceIndex)
self.raceIndex=raceIndex
zhengzhanshanhaiModel:initLingDiCfg()
end


function zhengzhanshanhaiModel:getRaceLunIndex()
local lunIndex=limitActivitiesModel:invokeMethod(LIMIT_ACT_TYPE.eZhengZhanShanHai,'getCurLunIndex')
return lunIndex
end





function zhengzhanshanhaiModel:initMapData(args)
if self.data==nil then return end
local mapData=self.data.mapData
local isInit=false
if mapData==nil or self.data.mapData_timeOut==true then
mapData={}
self.data.mapData=mapData
self.data.mapData_timeOut=nil
isInit=true
end

if args[1]>0 then
if isInit then
mapData.guildLookup={}
for i,v in ipairs(args[2])do
if v.guildicon~=0 then
zhengzhanshanhaiModel:handleXMData(v)
mapData.guildLookup[v.guildid_str]=v
else



end
end
else
if mapData.guildLookup==nil then
mapData.guildLookup={}
end
for i,v in ipairs(args[2])do
zhengzhanshanhaiModel:handleXMData(v)
if v.guildicon==0 then
local d=mapData.guildLookup[v.guildid_str]
if d~=nil then
mapData.guildLookup[v.guildid_str]=nil
notifySystem:postNotify(notifyConfig.onZZSHXMChange,zhengzhanshanhaiModel.opType.eDel,d)

if xianmengModel:isMyXM(v.guildid)then

UIManager:invokeUIMethod('UIXM_ZZSH_MapWin','rec_leaveXM')

zhengzhanshanhaiController:reqMapListen(0)
end
else



end
else
local d=mapData.guildLookup[v.guildid_str]
if d==nil then
mapData.guildLookup[v.guildid_str]=v
notifySystem:postNotify(notifyConfig.onZZSHXMChange,zhengzhanshanhaiModel.opType.eAdd,v)
else
d:refreshData(v)
notifySystem:postNotify(notifyConfig.onZZSHXMChange,zhengzhanshanhaiModel.opType.eRefresh,d)
end
end
end
end
end

if args[3]>0 or isInit then
if isInit then
mapData.domainLookup={}
mapData.xm2domainLookup={}
if args[3]>0 then
for i,v in ipairs(args[4])do
local cfg=zhengzhanshanhaiModel:getLingDiCfg(v.domainid)
if cfg then
zhengzhanshanhaiModel:handleLingDiData(v)
mapData.domainLookup[v.domainid]=v
mapData.xm2domainLookup[v.guildid_str]=v
else



end
end
end

local baseCfg=zhengzhanshanhaiModel:get_mapBaseCfg()
for pos,v in pairs(baseCfg.domain)do
local cfg=zhengzhanshanhaiModel:getLingDiCfgByPos(pos)
if mapData.domainLookup[cfg.domain]==nil then
local v={domainid=cfg.domain,guildid=int64.new('0')}
zhengzhanshanhaiModel:handleLingDiData(v)
mapData.domainLookup[cfg.domain]=v
end
end
else
if mapData.domainLookup==nil then
mapData.domainLookup={}
mapData.xm2domainLookup={}
end
for i,v in ipairs(args[4])do
local d=mapData.domainLookup[v.domainid]
local cfg=zhengzhanshanhaiModel:getLingDiCfg(v.domainid)
if d==nil or cfg==nil then



else
local guildid_str=tostring(v.guildid)
if d.guildid_str~=guildid_str then
if guildid_str~='0'then
local old_str=d.guildid_str
d:refreshData(v)
mapData.xm2domainLookup[old_str]=nil
mapData.xm2domainLookup[d.guildid_str]=d
notifySystem:postNotify(notifyConfig.onZZSHLingDiChange,zhengzhanshanhaiModel.opType.eRefresh,d)
else
d:refreshData(v)
mapData.xm2domainLookup[d.guildid_str]=nil
notifySystem:postNotify(notifyConfig.onZZSHLingDiChange,zhengzhanshanhaiModel.opType.eRefresh,d)
end
else



end
end
end
end
end

zhengzhanshanhaiModel:initPvPOrderData(args[5],args[6])

if args[7]>0 then
if isInit then
mapData.qingbaoLookup={}
for i,v in ipairs(args[8])do
zhengzhanshanhaiModel:handleQBData(v)
if v.ysid==0 or v.bdid==0 then




else
mapData.qingbaoLookup[v.guid]=v
end
end
else
if mapData.qingbaoLookup==nil then
mapData.qingbaoLookup={}
end
for i,v in ipairs(args[8])do
zhengzhanshanhaiModel:handleQBData(v)
if v.ysid==0 or v.bdid==0 then
local d=mapData.qingbaoLookup[v.guid]
if d~=nil then

if d.infotype==zhengzhanshanhaiModel.qbType.eMonster then
if UIManager:invokeUIMethod('UIXM_ZZSH_monsterInfoWin','containQBGuid',d.guid)==true then
UIManager:closeWindow('UIXM_ZZSH_monsterInfoWin')
end
if UIManager:invokeUIMethod('UIXM_ZZSH_monsterMyTeamWin','containQBGuid',d.guid)==true then
UIManager:closeWindow('UIXM_ZZSH_monsterMyTeamWin')
end
else
if UIManager:invokeUIMethod('UIXM_ZZSH_resourceInfoWin','containQBGuid',d.guid)==true then
UIManager:closeWindow('UIXM_ZZSH_resourceInfoWin')
end
end

zhengzhanshanhaiModel:refreshPvETeamByDelQingBao(v.guid)
mapData.qingbaoLookup[v.guid]=nil
notifySystem:postNotify(notifyConfig.onZZSHPvEQingBaoChange,zhengzhanshanhaiModel.opType.eDel,d)
end
else
local d=mapData.qingbaoLookup[v.guid]
if d==nil then
v.bornTime=gameUtilityModel.getServerShortTime()
mapData.qingbaoLookup[v.guid]=v
notifySystem:postNotify(notifyConfig.onZZSHPvEQingBaoChange,zhengzhanshanhaiModel.opType.eAdd,v)
else
d:refreshData(v)
notifySystem:postNotify(notifyConfig.onZZSHPvEQingBaoChange,zhengzhanshanhaiModel.opType.eRefresh,d)
end
end
end
end
end
if isInit then
notifySystem:postNotify(notifyConfig.onZZSHMapDataInit)
end
end

function zhengzhanshanhaiModel:delMapData(guid)
if self.data==nil then return end
local qbData=zhengzhanshanhaiModel:getQingBaoData(guid)

if qbData.infotype==zhengzhanshanhaiModel.qbType.eMonster then
if UIManager:invokeUIMethod('UIXM_ZZSH_monsterInfoWin','containQBGuid',qbData.guid)==true then
UIManager:closeWindow('UIXM_ZZSH_monsterInfoWin')
end
if UIManager:invokeUIMethod('UIXM_ZZSH_monsterMyTeamWin','containQBGuid',qbData.guid)==true then
UIManager:closeWindow('UIXM_ZZSH_monsterMyTeamWin')
end
else
if UIManager:invokeUIMethod('UIXM_ZZSH_resourceInfoWin','containQBGuid',qbData.guid)==true then
UIManager:closeWindow('UIXM_ZZSH_resourceInfoWin')
end
end

zhengzhanshanhaiModel:setQingBaoDetailDirty(qbData.guid)
zhengzhanshanhaiModel:refreshPvETeamByDelQingBao(qbData.guid)
end

function zhengzhanshanhaiModel:timeOutMapData()
if self.data then
self.data.mapData_timeOut=true
end
end

function zhengzhanshanhaiModel:getDontMovePosLookup()
return dontMovePosLookup
end

function zhengzhanshanhaiModel:checkPosDontMove(g_x,g_y)
if dontMovePosLookup then
for k,pos in pairs(dontMovePosLookup)do
local radius=pos[3]
if radius>0 then
return mathHelper.isInRadius(g_x,g_y,pos[1],pos[2],radius)
else
return g_x==pos[1]and g_y==pos[2]
end
end
end
return false
end

function zhengzhanshanhaiModel:getPosDontMoveRadius(g_x,g_y)
if dontMovePosLookup then
local key=zhengzhanshanhaiModel.getPosKey(g_x,g_y)
local d=dontMovePosLookup[key]
if d then
return d[3]
end
end
end





function zhengzhanshanhaiModel:handleXMData(xmData)







xmData.guildid_str=tostring(xmData.guildid)

xmData.refreshData=function(self_,d)
self_.guildname=d.guildname
local o_x=self_.x
local o_y=self_.y
self_.x=d.x
self_.y=d.y
if o_x~=self_.x or o_y~=self_.y then
if self_:checkMyXM()then
local raceState=zhengzhanshanhaiModel:getLunState()
if raceState==eZZSH_State.ePVEFight then
zhengzhanshanhaiModel:setPvEMoveTime(gameUtilityModel.getServerShortTime(),true)
end
end
end
self_.state=d.state
end

xmData.setObjID=function(self_,ojbID)
self_.ojbID=ojbID
end
xmData.checkMyXM=function(self_)
if self_.isMy==nil then
local guildid_=xianmengModel:myXMGuildID()
local guildid_str_=tostring(guildid_)
self_.isMy=guildid_str_==self_.guildid_str
end
return self_.isMy
end
xmData.checkFigthSign=function(self_)

return self_.state==0
end
end

function zhengzhanshanhaiModel:getAllXMLookup(check)
if self.data~=nil then
local mapData=self.data.mapData
if mapData then
if check then
if not self.data.mapData_timeOut then
return mapData.guildLookup
end
else
return mapData.guildLookup
end
end
end
return nil
end

function zhengzhanshanhaiModel:getMyXMGridPos()
local guid=xianmengModel:myXMGuildID()
if guid~=nil and self.data~=nil then
local mapData=self.data.mapData
if mapData and mapData.guildLookup then
local guid_str=tostring(guid)
local data=mapData.guildLookup[guid_str]
if data then
return data.x,data.y
end
end
end
return nil,nil
end

function zhengzhanshanhaiModel:setMyXMGridPos(g_x,g_y)
local guid=xianmengModel:myXMGuildID()
if guid~=nil and self.data~=nil then
local mapData=self.data.mapData
if mapData and mapData.guildLookup then
local guid_str=tostring(guid)
local data=mapData.guildLookup[guid_str]
if data then
data.x=g_x
data.y=g_y
end
end
end
end

function zhengzhanshanhaiModel:getXMData(guid)
if self.data~=nil then
local mapData=self.data.mapData
if mapData and mapData.guildLookup then
local guid_str=tostring(guid)
return mapData.guildLookup[guid_str]
end
end
return nil
end

function zhengzhanshanhaiModel:getMyXMData()
local guid=xianmengModel:myXMGuildID()
if guid then
return zhengzhanshanhaiModel:getXMData(guid)
end
return nil
end





function zhengzhanshanhaiModel:handleLingDiData(ldData)
ldData.guildid_str=tostring(ldData.guildid)
local cfg=zhengzhanshanhaiModel:getLingDiCfg(ldData.domainid)
local pos=cfg.pos
local baseCfg=zhengzhanshanhaiModel:get_mapBaseCfg()
local d=baseCfg.domain[pos]
ldData.x=d[1]
ldData.y=d[2]
ldData.radius=d[3]

ldData.refreshData=function(self_,d)
self_.guildid=d.guildid
self_.guildid_str=tostring(self_.guildid)
end
ldData.setObjID=function(self_,ojbID)
self_.ojbID=ojbID
end

ldData.distance=function(self_,g_x,g_y)
return mathHelper.distance(g_x,g_y,self_.x,self_.y)
end

ldData.getWayTime=function(self_,g_x,g_y)
local dis=self_:distance(g_x,g_y)
local step=zhengzhanshanhaiModel:getPvEMoveStep()
return math.max(1,math.ceil(dis/step))
end

ldData.checkIn=function(self_,g_x,g_y)
return mathHelper.isInRadius(g_x,g_y,self_.x,self_.y,self_.radius)
end

ldData.getXM=function(self_)
if self_.guildid_str~='0'then
return zhengzhanshanhaiModel:getXMData(self_.guildid)
end
return nil
end
end

function zhengzhanshanhaiModel:getAllLDLookup()
if self.data~=nil then
local mapData=self.data.mapData
if mapData then
return mapData.domainLookup
end
end
return nil
end

function zhengzhanshanhaiModel:getLDData(cfgid)
if self.data~=nil then
local mapData=self.data.mapData
if mapData and mapData.domainLookup then
return mapData.domainLookup[cfgid]
end
end
return nil
end

function zhengzhanshanhaiModel:getLDDataByXM(guildid)
if self.data~=nil then
local mapData=self.data.mapData
if mapData and mapData.xm2domainLookup then
local guildid_str=tostring(guildid)
return mapData.xm2domainLookup[guildid_str]
end
end
return nil
end

function zhengzhanshanhaiModel:getMyLDData()
local guid=xianmengModel:myXMGuildID()
if guid then
return zhengzhanshanhaiModel:getLDDataByXM(guid)
end
return nil
end

function zhengzhanshanhaiModel:getMyLDGridPos()
local ldData=zhengzhanshanhaiModel:getMyLDData()
if ldData then
return ldData.x,ldData.y
end
return nil,nil
end

function zhengzhanshanhaiModel:checkGridPosInLD(g_x,g_y)
if self.data~=nil then
local mapData=self.data.mapData
if mapData and mapData.domainLookup then
for cfgid,ldData in pairs(mapData.domainLookup)do
if ldData:checkIn(g_x,g_y)then
return ldData
end
end
end
end
return nil
end

function zhengzhanshanhaiModel:setLDDailyReward(flag,isInit)
if self.data~=nil then
self.data.ldDailyRewardFlag=flag

if not isInit then
local raceState=zhengzhanshanhaiModel:getLunState()
if raceState==eZZSH_State.ePVEFight then
local ldData=zhengzhanshanhaiModel:getMyLDData()
if ldData and ldData.ojbID then
zhengzhanshanhaiModel:invokeFunc(ldData.ojbID,'changeXM')
end
end
end
end
end

function zhengzhanshanhaiModel:getLDDailyReward()




return false
end

function zhengzhanshanhaiModel:initLingDiCfg()
local lingdiCfgLookup={}
local lingdiPosLookup={}
local lingdiGridLookup={}
local baseCfg=zhengzhanshanhaiModel:get_mapBaseCfg()
local lp=baseCfg.domain
local list=zhengzhanshanhaiController:getZZSHCfg_domain()
for i,cfg in ipairs(list)do
lingdiCfgLookup[cfg.domain]=cfg
lingdiPosLookup[cfg.pos]=cfg
lingdiGridLookup[cfg.domain]=lp[cfg.pos]
end
self.lingdiCfgLookup=lingdiCfgLookup
self.lingdiPosLookup=lingdiPosLookup
self.lingdiGridLookup=lingdiGridLookup
end

function zhengzhanshanhaiModel:getLingDiCfg(cfgid)
return self.lingdiCfgLookup[cfgid]
end

function zhengzhanshanhaiModel:getLingDiGridPos(cfgid)
local grid=self.lingdiGridLookup[cfgid]
if grid then
return grid[1],grid[2]
end
return nil,nil
end

function zhengzhanshanhaiModel:getLingDiCfgByPos(pos)
return self.lingdiPosLookup[pos]
end





function zhengzhanshanhaiModel:handleQBData(qbData)
if qbData.ysid==0 or qbData.bdid==0 then
return
end

local ldCfgID
local ldData=zhengzhanshanhaiModel:checkGridPosInLD(qbData.x,qbData.y)
if ldData then
ldCfgID=ldData.domainid
end
qbData.ldCfgID=ldCfgID

qbData.refreshData=function(self_,d)

end
qbData.setObjID=function(self_,ojbID)
self_.ojbID=ojbID
end
qbData.invokeObjFunc=function(self_,funcName,...)
if self_.ojbID then
return zhengzhanshanhaiModel:invokeFunc(self_.ojbID,funcName,...)
end
end
qbData.getName=function(self_)
local name=self_.name
if name==nil then
local cfg=self_:getCfg()
name=zhengzhanshanhaiModel:getQingBaoName(self_.infotype,cfg)
self_.name=name
end
return name
end
qbData.getColorName=function(self_,fmt_str)
local colorName=self_.colorName
if colorName==nil then
local cfg=self_:getCfg()
local name=self_:getName()
if fmt_str~=nil then
name=FMT.fmt(fmt_str,name)
end
colorName=toColorString2(cfg.stage,name)
self_.colorName=colorName
end
return colorName
end
qbData.getColorName2=function(self_,fmt_str)
local cfg=self_:getCfg()
local name=self_:getName()
if fmt_str~=nil then
name=FMT.fmt(fmt_str,name)
end
return zhengzhanshanhaiModel:getColorStr(name,cfg.stage)
end

qbData.getCfg=function(self_)
local cfg=self_.cfg
if cfg==nil then
local id
if self_.infotype==zhengzhanshanhaiModel.qbType.eMonster then
id=self_.ysid
else
id=self_.bdid
end
cfg=zhengzhanshanhaiModel:getQingBaoCfg(self_.infotype,id)
self_.cfg=cfg
end
return cfg
end

qbData.distance=function(self_,g_x,g_y)
return mathHelper.distance(g_x,g_y,self_.x,self_.y)
end

qbData.getInLD=function(self_)

if self_.ldCfgID then
local ldData=zhengzhanshanhaiModel:getLDData(self_.ldCfgID)
return ldData
end
return nil
end

qbData.getXM=function(self_)

if mathHelper.validInt64(self_.guildid)then

return zhengzhanshanhaiModel:getXMData(self_.guildid),1
end


local ldData=self_:getInLD()
if ldData then
return ldData:getXM()
end

return nil
end

qbData.checkXM=function(self_,isWarning)
local xmData=self_:getXM()
if xmData then
if not xmData:checkMyXM()then
if isWarning then
if self_.infotype==zhengzhanshanhaiModel.qbType.eMonster then
UIManager.error('该异兽已有归属，无法集结')
else
UIManager.error('该宝地已有归属，无法采集')
end
end
return false
end
end
return true
end

qbData.getTeamInfo=function(self_,key)
if self_.detail~=nil then
if self_.infotype==zhengzhanshanhaiModel.qbType.eMonster then
if key==nil then
key=xianmengModel:myXMGuildID()
end
local key_str=tostring(key)
return self_.detail.allTeam[key_str]
end
end
end
qbData.getAllTeamNum=function(self_)
if self_.detail~=nil then
return self_.detail.teamNum
end
end
qbData.getDetail=function(self_,check)
if self_.detail~=nil then
if check then
if self_.detail_time==nil or gameUtilityModel.getServerShortTime()-self_.detail_time>=qingbaoDetailRefreshTime then
return nil
else
return self_.detail
end
else
return self_.detail
end
end
end
qbData.getDetail_xm=function(self_)
if self_.detail_xm~=nil then
return self_.detail_xm
end
end

qbData.getZMTeamInfo=function(self_,key)
if self_.detail_xm~=nil then
if self_.infotype==zhengzhanshanhaiModel.qbType.eMonster then
if key==nil then
key=playerModel:getActorID()
end
local key_str=tostring(key)
return self_.detail_xm.allTeam[key_str]
end
end
end
qbData.checkNewSign=function(self_)
if self_.bornTime and gameUtilityModel.getServerShortTime()-self_.bornTime<=10 then
return true
end
return false
end
end

function zhengzhanshanhaiModel:getAllQingBaoLookup(check)
if self.data~=nil then
local mapData=self.data.mapData
if mapData then
if check then
if not self.data.mapData_timeOut then
return mapData.qingbaoLookup
end
else
return mapData.qingbaoLookup
end
end
end
return nil
end

function zhengzhanshanhaiModel:getQingBaoData(guid)
if self.data~=nil then
local mapData=self.data.mapData
if mapData and mapData.qingbaoLookup then
return mapData.qingbaoLookup[guid]
end
end
return nil
end


function zhengzhanshanhaiModel:getQingBaoWayTime(qbData)


local dis
local g_x,g_y=zhengzhanshanhaiModel:getMyXMGridPos()
if g_x==nil then return 0 end
local dis1=qbData:distance(g_x,g_y)
dis=dis1








local step=zhengzhanshanhaiModel:getPvEMoveStep()
return math.max(1,math.ceil(dis/step))
end

function zhengzhanshanhaiModel:setQingBaoDetailDirty(guid)
local qbData=zhengzhanshanhaiModel:getQingBaoData(guid)
if qbData==nil then return end
if qbData.infotype==zhengzhanshanhaiModel.qbType.eMonster then
if UIManager:invokeUIMethod('UIXM_ZZSH_monsterInfoWin','containQBGuid',guid)==true then
zhengzhanshanhaiController:reqMonsterDetail(guid)
else
qbData.detail_time=nil
end
if UIManager:invokeUIMethod('UIXM_ZZSH_monsterMyTeamWin','containQBGuid',guid)==true or
UIManager:invokeUIMethod('UIXMZZSH_YuBeiDuiMainWin','containQBGuid',guid)==true then
zhengzhanshanhaiController:reqMonsterXMDetail(guid)
else
qbData.detail_time_xm=nil
end
else
if UIManager:invokeUIMethod('UIXM_ZZSH_resourceInfoWin','containQBGuid',guid)==true then
zhengzhanshanhaiController:reqResourceDetail(guid)
else
qbData.detail_time=nil
end
end
end

function zhengzhanshanhaiModel:setQingBaoDetailDirty2(guid)
local qbData=zhengzhanshanhaiModel:getQingBaoData(guid)
if qbData==nil then return end
if qbData.infotype==zhengzhanshanhaiModel.qbType.eMonster then
if UIManager:invokeUIMethod('UIXM_ZZSH_monsterInfoWin','containQBGuid',guid)==true then
zhengzhanshanhaiController:reqMonsterDetail(guid)
else
qbData.detail_time=nil
end
if UIManager:invokeUIMethod('UIXM_ZZSH_monsterMyTeamWin','containQBGuid',guid)==true then
UIManager:closeWindow('UIXM_ZZSH_monsterMyTeamWin')
end
if UIManager:invokeUIMethod('UIXMZZSH_YuBeiDuiMainWin','containQBGuid',guid)==true then
UIManager:closeWindow('UIXMZZSH_YuBeiDuiMainWin')
end
else
if UIManager:invokeUIMethod('UIXM_ZZSH_resourceInfoWin','containQBGuid',guid)==true then
zhengzhanshanhaiController:reqResourceDetail(guid)
else
qbData.detail_time=nil
end
end
end

function zhengzhanshanhaiModel:setQingBaoDetailDirty3(guid)
local qbData=zhengzhanshanhaiModel:getQingBaoData(guid)
if qbData==nil then return end
if qbData.infotype==zhengzhanshanhaiModel.qbType.eMonster then
if UIManager:invokeUIMethod('UIXM_ZZSH_monsterInfoWin','containQBGuid',guid)==true then
zhengzhanshanhaiController:reqMonsterDetail(guid)
if zhengzhanshanhaiModel:checkInMyWaiPai(guid)then
if UIManager:isActive('UIXM_ZZSH_MapWin')and UIManager:isActive('UIXM_ZZSH_monsterInfoWin')then

zhengzhanshanhaiModel:checkQingBaoDetail_xm(guid)
end
end
else
qbData.detail_time=nil
end
if UIManager:invokeUIMethod('UIXM_ZZSH_monsterMyTeamWin','containQBGuid',guid)==true or
UIManager:invokeUIMethod('UIXMZZSH_YuBeiDuiMainWin','containQBGuid',guid)==true then
zhengzhanshanhaiController:reqMonsterXMDetail(guid)
else
qbData.detail_time_xm=nil
end
else
if UIManager:invokeUIMethod('UIXM_ZZSH_resourceInfoWin','containQBGuid',guid)==true then
if zhengzhanshanhaiController:getOpenCollectMark()then
zhengzhanshanhaiController:setOpenCollectMark()
zhengzhanshanhaiModel:checkQingBaoDetail(guid,true)
else
zhengzhanshanhaiController:reqResourceDetail(guid)
end
else
qbData.detail_time=nil
end
end
end

function zhengzhanshanhaiModel:reqQingBaoDetail(qbData)
if qbData.infotype==zhengzhanshanhaiModel.qbType.eMonster then
zhengzhanshanhaiController:reqMonsterDetail(qbData.guid)
else
zhengzhanshanhaiController:reqResourceDetail(qbData.guid)
end
end

function zhengzhanshanhaiModel:checkQingBaoRefresh(qbData)
local needRefresh=false
if qbData.detail_time==nil or gameUtilityModel.getServerShortTime()-qbData.detail_time>=qingbaoDetailRefreshTime then
needRefresh=true
end
return needRefresh
end


function zhengzhanshanhaiModel:checkQingBaoDetail(guid,isNew,baodiflag)
local qbData=zhengzhanshanhaiModel:getQingBaoData(guid)
if qbData then
local needRefresh=zhengzhanshanhaiModel:checkQingBaoRefresh(qbData)
if isNew or needRefresh then
zhengzhanshanhaiModel:reqQingBaoDetail(qbData)
zhengzhanshanhaiController:setOpenQingBaoMark(guid,baodiflag)
else
zhengzhanshanhaiController:openQingBaoDetail(guid,baodiflag)
end
end
end

function zhengzhanshanhaiModel:insertQingBaoDetail(guid,detail)
local qbData=zhengzhanshanhaiModel:getQingBaoData(guid)
if qbData then
qbData.detail=detail
qbData.detail_time=gameUtilityModel.getServerShortTime()
end
end

function zhengzhanshanhaiModel:refreshQingBaoDetail(guid,setoutnum)
local qbData=zhengzhanshanhaiModel:getQingBaoData(guid)
if qbData then
if qbData.detail and qbData.detail.allTeam then
for k,team in pairs(qbData.detail.allTeam)do
if team.ismy then
team.setoutnum=setoutnum
end
end
end
end
end

function zhengzhanshanhaiModel:checkQingBaoDetail_xm(guid,isNew)
local qbData=zhengzhanshanhaiModel:getQingBaoData(guid)
if qbData then
local needRefresh=false
if qbData.detail_time_xm==nil or gameUtilityModel.getServerShortTime()-qbData.detail_time_xm>=qingbaoDetailRefreshTime then
needRefresh=true
end
if isNew or needRefresh then
if qbData.infotype==zhengzhanshanhaiModel.qbType.eMonster then
zhengzhanshanhaiController:reqMonsterXMDetail(guid)
else

end
zhengzhanshanhaiController:setOpenQingBaoMark_xm(guid)
else
zhengzhanshanhaiController:openQingBaoDetail_xm(guid)
end
end
end

function zhengzhanshanhaiModel:insertQingBaoDetail_xm(guid,detail)
local qbData=zhengzhanshanhaiModel:getQingBaoData(guid)
if qbData then
qbData.detail_xm=detail
qbData.detail_time_xm=gameUtilityModel.getServerShortTime()
end
end

function zhengzhanshanhaiModel:testQingBaoFight(guid)
local qbData=zhengzhanshanhaiModel:getQingBaoData(guid)
if qbData~=nil and qbData.ojbID then
zhengzhanshanhaiModel:invokeFunc(qbData.ojbID,'activeFightEffect')
end
end





function zhengzhanshanhaiModel.getPvETeamOnlyKey(guid,key)
return FMT.fmt('{0}_{1}',guid,tostring(key))
end

function zhengzhanshanhaiModel:getMyPvETeamKey(infotype)
local key
if infotype==zhengzhanshanhaiModel.qbType.eMonster then
key=xianmengModel:myXMGuildID()
else
key=playerModel:getActorID()
end
return key
end

function zhengzhanshanhaiModel:getMyPvETeamOnlyKey(guid,infotype)
local key=zhengzhanshanhaiModel:getMyPvETeamKey(infotype)
return zhengzhanshanhaiModel.getPvETeamOnlyKey(guid,key)
end

function zhengzhanshanhaiModel:handlePvETeamData(teamData)
teamData.only_key=zhengzhanshanhaiModel.getPvETeamOnlyKey(teamData.guid,teamData.key)
if teamData.sec==0 then return end

local l_x,l_y=zhengzhanshanhaiModel:gridPos2localPos(teamData.x,teamData.y)
teamData.l_x=l_x
teamData.l_y=l_y

teamData.refreshData=function(self_,d)
self_.sec=d.sec
self_.x=d.x
self_.y=d.y
local l_x_,l_y_=zhengzhanshanhaiModel:gridPos2localPos(self_.x,self_.y)
self_.l_x=l_x_
self_.l_y=l_y_
end
teamData.setObjID=function(self_,ojbID)
self_.ojbID=ojbID
end
teamData.getName=function(self_)
local name=self_.name
if name==nil then
local qbData=self_:getQingBaoData()
if qbData then
name=qbData:getName()
end
end
return name
end
teamData.getColorName=function(self_,fmt_str)
local colorName=self_.colorName
if colorName==nil then
local qbData=self_:getQingBaoData()
if qbData then
colorName=qbData:getColorName(fmt_str)
end
end
return colorName
end
teamData.getColorName2=function(self_,fmt_str)
local qbData=self_:getQingBaoData()
if qbData then
return qbData:getColorName2(fmt_str)
end
end
teamData.get_infotype=function(self_)
if self_.infotype==nil then
local qbData=self_:getQingBaoData()
if qbData then
self_.infotype=qbData.infotype
end
end
return self_.infotype
end
teamData.valid=function(self_,isWarning)
local qbData=self_:getQingBaoData()
if qbData then
return true
end





return false
end
teamData.getQingBaoData=function(self_)
return zhengzhanshanhaiModel:getQingBaoData(self_.guid)
end
teamData.getState=function(self_,isColor)
local infotype=self_:get_infotype()
local sec=self_.sec
return zhengzhanshanhaiModel:getPvETeamState(infotype,sec,isColor)
end

teamData.distance=function(self_)
local e_x,e_y=self_:getEndGridPos()
if e_x then
return mathHelper.distance(self_.x,self_.y,e_x,e_y)
end
return 0
end
teamData.distance2=function(self_)
local e_x,e_y=self_:getEndGridPos()
if e_x then
return mathHelper.distance(self_.l_x,self_.l_y,self_.l_e_x,self_.l_e_y)
end
return 0
end
teamData.getEndGridPos=function(self_)
if self_.e_x==nil then
local qbData=self_:getQingBaoData()
if qbData then
self_.e_x=qbData.x
self_.e_y=qbData.y
local l_e_x,l_e_y=zhengzhanshanhaiModel:gridPos2localPos(self_.e_x,self_.e_y)
self_.l_e_x=l_e_x
self_.l_e_y=l_e_y
end
end
return self_.e_x,self_.e_y
end
teamData.getCurLocalPos=function(self_)
local e_x,e_y=self_:getEndGridPos()
if e_x==nil then
return self_.l_x,self_.l_y,0,0,0
end

local dis,dx,dy=mathHelper.distanceEx(self_.l_x,self_.l_y,self_.l_e_x,self_.l_e_y)
if dis==0 then
return self_.l_e_x,self_.l_e_y,dis,0,0
end

local ux=dx/dis
local uy=dy/dis

local wayT=self_:getWayTime()
local moveBeginTime=self_.moveBeginTime
local moveEndTime=self_.moveEndTime
if moveBeginTime==nil then
local infotype=self_:get_infotype()
if infotype then
local t=self_.sec
if infotype==zhengzhanshanhaiModel.qbType.eMonster then
if t>0 then
moveEndTime=t
moveBeginTime=moveEndTime-wayT
end
else
if t<0 then
moveEndTime=-t
moveBeginTime=moveEndTime-wayT
end
end
end
self_.moveBeginTime=moveBeginTime
self_.moveEndTime=moveEndTime
end
if moveBeginTime==nil then
return self_.l_e_x,self_.l_e_y,dis,0,0
end
local cur=gameUtilityModel.getServerShortTime()
local costT
if cur>=moveEndTime then
costT=wayT
else
if cur>=moveBeginTime then
costT=cur-moveBeginTime
else
costT=0
end
end
local rate=costT/wayT
local lerp_time=wayT-costT
local move=dis*rate
local lerp_move=dis-move

local m_l_x=self_.l_x+move*ux
local m_l_y=self_.l_y+move*uy
return m_l_x,m_l_y,move,lerp_move,lerp_time
end

teamData.getWayTime=function(self_)
local dis=self_:distance()
local step=zhengzhanshanhaiModel:getPvEMoveStep()
return math.max(1,math.ceil(dis/step))
end
teamData.isMyXMTeam=function(self_)
local isMyXM=self_.isMyXM
if isMyXM==nil then
local infotype=self_:get_infotype()
if infotype then
if infotype==zhengzhanshanhaiModel.qbType.eMonster then
isMyXM=xianmengModel:isMyXM(self_.key)
else
isMyXM=xianmengModel:checkActorInXM(self_.key)
end
self_.isMyXM=isMyXM
end
end
return isMyXM==true
end
teamData.isMonterTeam=function(self_)
local infotype=self_:get_infotype()
return infotype==zhengzhanshanhaiModel.qbType.eMonster
end

teamData.isResourceTeam=function(self_)
local infotype=self_:get_infotype()
return infotype==zhengzhanshanhaiModel.qbType.eResource
end
end

function zhengzhanshanhaiModel:checkPvETeamsInit()
if self.data~=nil and self.data.teamsData~=nil then
return true
end
return false
end

function zhengzhanshanhaiModel:getAllPvETeams(check)
if self.data then
if check then
if not self.data.teamsData_timeOut then
return self.data.teamsData
end
else
return self.data.teamsData
end
end
return nil
end

function zhengzhanshanhaiModel:printAllPvETeams()
local list={}
local all=zhengzhanshanhaiModel:getAllPvETeams()
if all then
for k,v in pairs(all)do
if v:valid(true)then
local check
local infotype=v:get_infotype()
if infotype==zhengzhanshanhaiModel.qbType.eMonster then
check=v.sec>0
else
check=v.sec<0
end
if check then
table.insert(list,{infotype=v:get_infotype(),guid=v.guid,key=v.key})
end
end
end
end

end

function zhengzhanshanhaiModel:getMyXMAllMonsterPvETeams()
local lp={}
if self.data and self.data.teamsData then
for k,teamData in pairs(self.data.teamsData)do
if teamData:isMonterTeam()and teamData:isMyXMTeam()then
lp[teamData.guid]=teamData
end
end
end
return lp
end


function zhengzhanshanhaiModel:getAllResourcePvETeams_goto(guid,arriveTime)
local list={}
local qbData=zhengzhanshanhaiModel:getQingBaoData(guid)
if qbData==nil then
return list
end
local detail=qbData:getDetail()
local allTeams=detail.allTeam
for k,teamData in ipairs(allTeams)do
if teamData.sec<0 then
if arriveTime then
if-teamData.sec<=arriveTime then
table.insert(list,teamData)
end
else
table.insert(list,teamData)
end
end
end
return list
end


function zhengzhanshanhaiModel:getMyXMAllResourcePvETeams_goto(guid)
local list={}
local qbData=zhengzhanshanhaiModel:getQingBaoData(guid)
if qbData==nil then
return list
end
local detail=qbData:getDetail()
local allTeams=detail.allTeam or{}
for k,teamData in ipairs(allTeams)do
if teamData.sec<0 and teamData.isMyXM then
table.insert(list,teamData)
end
end
return list
end

function zhengzhanshanhaiModel:initPvETeams(len,targetList)
if self.data==nil then return end
local teamsData=self.data.teamsData
local isInit=false
if teamsData==nil or self.data.teamsData_timeOut==true then
teamsData={}
self.data.teamsData=teamsData
self.data.teamsData_timeOut=nil
isInit=true
end

if len>0 then
if isInit then
for i,v in ipairs(targetList)do
zhengzhanshanhaiModel:handlePvETeamData(v)
if v.sec~=0 then
teamsData[v.only_key]=v
else





end
end
notifySystem:postNotify(notifyConfig.onZZSHPvETeamChange,zhengzhanshanhaiModel.opType.eInit)
else
local changlp={}
local changlp2={}
local changlp3={}
for i,v in ipairs(targetList)do
zhengzhanshanhaiModel:handlePvETeamData(v)

if v.sec==0 then

local d=teamsData[v.only_key]
if d then
teamsData[v.only_key]=nil
changlp2[v.guid]=true
notifySystem:postNotify(notifyConfig.onZZSHPvETeamChange,zhengzhanshanhaiModel.opType.eDel,d)
else





end
else
local d=teamsData[v.only_key]
if d==nil then

teamsData[v.only_key]=v
changlp3[v.guid]=true
notifySystem:postNotify(notifyConfig.onZZSHPvETeamChange,zhengzhanshanhaiModel.opType.eAdd,v)
else

d:refreshData(v)
changlp[v.guid]=true
notifySystem:postNotify(notifyConfig.onZZSHPvETeamChange,zhengzhanshanhaiModel.opType.eRefresh,d)
end
end
end
for guid,v in pairs(changlp)do

zhengzhanshanhaiModel:setQingBaoDetailDirty(guid)

zhengzhanshanhaiModel:refreshPvEWaiPaiData(zhengzhanshanhaiModel.opType.eRefresh,guid)
end
for guid,v in pairs(changlp2)do

zhengzhanshanhaiModel:setQingBaoDetailDirty2(guid)

zhengzhanshanhaiModel:refreshPvEWaiPaiData(zhengzhanshanhaiModel.opType.eDel,guid)
end
for guid,v in pairs(changlp3)do

zhengzhanshanhaiModel:setQingBaoDetailDirty3(guid)

zhengzhanshanhaiModel:refreshPvEWaiPaiData(zhengzhanshanhaiModel.opType.eAdd,guid)
end
end
end
end

function zhengzhanshanhaiModel:refreshPvETeamByDelQingBao(guid)
if self.data~=nil and self.data.teamsData~=nil then
local teamsData=self.data.teamsData
local list={}
for only_key,teamData in pairs(teamsData)do
if teamData.guid==guid then
table.insert(list,only_key)
end
end
if#list>0 then
for i,only_key in ipairs(list)do
local d=teamsData[only_key]
teamsData[only_key]=nil
notifySystem:postNotify(notifyConfig.onZZSHPvETeamChange,zhengzhanshanhaiModel.opType.eDel,d)
end

zhengzhanshanhaiModel:refreshPvEWaiPaiData(zhengzhanshanhaiModel.opType.eDel,guid)
end
end
end

function zhengzhanshanhaiModel:getPvETeam(only_key)
if self.data~=nil and self.data.teamsData~=nil then
return self.data.teamsData[only_key]
end
end

function zhengzhanshanhaiModel:getMyPvETeam(guid,infotype)
local only_key=zhengzhanshanhaiModel:getMyPvETeamOnlyKey(guid,infotype)
return zhengzhanshanhaiModel:getPvETeam(only_key)
end

function zhengzhanshanhaiModel:timeOutPvETeams()
if self.data then
self.data.teamsData_timeOut=true
end
end

function zhengzhanshanhaiModel:getPvETeamState(infotype,sec,isColor)
local state,time
if infotype==zhengzhanshanhaiModel.qbType.eMonster then
if sec<0 then
state='集结中'
local t=-sec
local cur=gameUtilityModel.getServerShortTime()
time=t-cur
if isColor then
state=toColorStringX('#f36666',state)
end
else
state='前往中'
local t=sec
local cur=gameUtilityModel.getServerShortTime()
time=t-cur
if isColor then
state=toColorStringX('#549327',state)
end
end
else
if sec<0 then
state='前往中'
local t=-sec
local cur=gameUtilityModel.getServerShortTime()
time=t-cur
if isColor then
state=toColorStringX('#549327',state)
end
else
state='采集中'
local t=sec
local cur=gameUtilityModel.getServerShortTime()
time=cur-t
if time<0 then time=0 end
if isColor then
state=toColorStringX('#549327',state)
end
end
end
return state,time
end

function zhengzhanshanhaiModel:checkPvETeamInFight(teamData)
local infotype=teamData:get_infotype()
if infotype then
local sec=teamData.sec
if infotype==zhengzhanshanhaiModel.qbType.eMonster then
if sec>0 then
local t=sec
local cur=gameUtilityModel.getServerShortTime()

return cur>=t
end
else
if sec<0 then
local t=-sec
local cur=gameUtilityModel.getServerShortTime()

return cur>=t
end
end
end
return false
end

function zhengzhanshanhaiModel:checkPvETeamShowEntity(infotype,sec)
if infotype==zhengzhanshanhaiModel.qbType.eMonster then
if sec>0 then
local t=sec
local cur=gameUtilityModel.getServerShortTime()
return cur<=t
end
else
if sec<0 then



return true
end
end
return false
end

function zhengzhanshanhaiModel:checkFightingInQingBao(guid)
if self.data~=nil and self.data.teamsData~=nil then
local teamsData=self.data.teamsData
for only_key,teamData in pairs(teamsData)do
if teamData.guid==guid then
if zhengzhanshanhaiModel:checkPvETeamInFight(teamData)then
return true
end
end
end
end
return false
end





function zhengzhanshanhaiModel:handlePvEWaiPaiData(wpData)
local dzLookup={}
if wpData.guidList then
for i,v in ipairs(wpData.guidList)do
dzLookup[tostring(v)]=true
end
end
wpData.dzLookup=dzLookup

wpData.getFight=function(self_)
local fight_num=self_.fight_num
if fight_num==nil then
fight_num=0
if self_.guidList then
for i,v in ipairs(self_.guidList)do
fight_num=fight_num+UIDiscipleModel:getDiscipleFightValue(v)
end
end
self_.fight_num=fight_num
end
return fight_num
end

wpData.getDZGroupCollectCfg=function(self_,moneyType)
return zhengzhanshanhaiModel:getDZGroupCollectCfg(self_.guidList,moneyType)
end

wpData.getDZGroupCollectCfg2=function(self_)
return self_.speed,self_.max
end
wpData.getName=function(self_)
local name=self_.name
if name==nil then
local qbData=self_:getQingBaoData()
if qbData then
name=qbData:getName()
end
end
return name
end
wpData.getColorName=function(self_,fmt_str)
local colorName=self_.colorName
if colorName==nil then
local qbData=self_:getQingBaoData()
if qbData then
colorName=qbData:getColorName(fmt_str)
end
end
return colorName
end
wpData.getColorName2=function(self_,fmt_str)
local qbData=self_:getQingBaoData()
if qbData then
return qbData:getColorName2(fmt_str)
end
end
wpData.getQingBaoData=function(self_)
return zhengzhanshanhaiModel:getQingBaoData(self_.guid)
end
wpData.get_infotype=function(self_)
if self_.infotype==nil then
local qbData=self_:getQingBaoData()
if qbData then
self_.infotype=qbData.infotype
end
end
return self_.infotype
end
wpData.get_key=function(self_)
if self_.key==nil then
local infotype=self_:get_infotype()
if infotype then
self_.key=zhengzhanshanhaiModel:getMyPvETeamKey(infotype)
end
end
return self_.key
end
wpData.get_onlykey=function(self_)
local key=self_:get_key()
if self_.only_key==nil then
self_.only_key=zhengzhanshanhaiModel.getPvETeamOnlyKey(self_.guid,key)
end
return self_.only_key
end
wpData.getTeamData=function(self_)
local only_key=self_:get_onlykey()
return zhengzhanshanhaiModel:getPvETeam(only_key)
end

wpData.distance=function(self_)
local teamData=self_:getTeamData()
if teamData then
return teamData:distance()
end
return 0
end

wpData.getWayTime=function(self_)
local teamData=self_:getTeamData()
if teamData then
return teamData:getWayTime()
end
return 0
end
wpData.checkHasDZ=function(self_,dzguid)
local dzguid_str=tostring(dzguid)
return self_.dzLookup[dzguid_str]==true
end
wpData.valid=function(self_)
return self_:getQingBaoData()~=nil and self_:getTeamData()~=nil
end
end

function zhengzhanshanhaiModel:initPvEWaiPaiDatas(len,datas)
if self.baseData==nil then return end
local lp={}
if len>0 then
for i,v in ipairs(datas)do
zhengzhanshanhaiModel:handlePvEWaiPaiData(v)
lp[v.guid]=v
end
end
self.baseData.mPvEWaiPaiLookup=lp
end

function zhengzhanshanhaiModel:addPvEWaiPaiData(guid,dzList,speed,max)
local qbData=zhengzhanshanhaiModel:getQingBaoData(guid)
if qbData==nil then
logErr(FMT.fmt('征战山海,添加外派队伍失败,找不到情报点{0}',guid))
return
end
if self.baseData==nil or self.baseData.mPvEWaiPaiLookup==nil then
logErr('征战山海,添加外派队伍失败,数据未初始化')
return
end
local d={
guid=guid,
guidlistlen=#dzList,
guidList=dzList,
speed=speed or 0,
max=max or 0,
}
zhengzhanshanhaiModel:handlePvEWaiPaiData(d)
self.baseData.mPvEWaiPaiLookup[d.guid]=d


end

function zhengzhanshanhaiModel:refreshPvEWaiPaiData(opType,guid)
if self.baseData==nil or self.baseData.mPvEWaiPaiLookup==nil then return end
local wpData=self.baseData.mPvEWaiPaiLookup[guid]
if wpData then
notifySystem:postNotify(notifyConfig.onZZSHPvEWaiPaiChange,opType,guid)
end
end

function zhengzhanshanhaiModel:delPvEWaiPaiData(guid)
if self.baseData==nil or self.baseData.mPvEWaiPaiLookup==nil then return end
local wpData=self.baseData.mPvEWaiPaiLookup[guid]
if wpData then
self.baseData.mPvEWaiPaiLookup[guid]=nil
notifySystem:postNotify(notifyConfig.onZZSHPvEWaiPaiChange,zhengzhanshanhaiModel.opType.eDel,guid)
end
end

function zhengzhanshanhaiModel:getMyPvEWaiPaiList()
local list={}
if self.baseData and self.baseData.mPvEWaiPaiLookup then
for guid,wpData in pairs(self.baseData.mPvEWaiPaiLookup)do
if wpData:valid()then
table.insert(list,wpData)
end
end
end
return list
end

function zhengzhanshanhaiModel:getMyPvEWaiPaiNum()
local num=0
if self.baseData and self.baseData.mPvEWaiPaiLookup then
for guid,wpData in pairs(self.baseData.mPvEWaiPaiLookup)do
if wpData:valid()then
num=num+1
end
end
end
return num
end

function zhengzhanshanhaiModel:checkMyPvEWaiPaiNum(isWarning)
local num=zhengzhanshanhaiModel:getMyPvEWaiPaiNum()
local max=zhengzhanshanhaiModel:getMaxWaiPaiNum()
if num>=max then
if isWarning then
UIManager.error(FMT.fmt('最多外派{0}支队伍',max))
end
return false
end
return true
end

function zhengzhanshanhaiModel:getMyPvEWaiPaiData(guid)
if self.baseData and self.baseData.mPvEWaiPaiLookup then
local wpData=self.baseData.mPvEWaiPaiLookup[guid]
if wpData and wpData:valid()then
return wpData
end
end
return nil
end

function zhengzhanshanhaiModel:checkInMyWaiPai(guid)
if self.baseData and self.baseData.mPvEWaiPaiLookup then
local wpData=self.baseData.mPvEWaiPaiLookup[guid]
if wpData and wpData:valid()then
return true
end
end
return false
end

function zhengzhanshanhaiModel:checkDZInMyWaiPai(dzguid)
if self.baseData and self.baseData.mPvEWaiPaiLookup then
for guid,wpData in pairs(self.baseData.mPvEWaiPaiLookup)do
if wpData:valid()then
if wpData:checkHasDZ(dzguid)then
return wpData:get_infotype()
end
end
end
end
return nil
end

function zhengzhanshanhaiModel:initPvEJoinDatas(len,list)
if self.baseData==nil then return end
local lp={}
if len>0 then
for i,v in ipairs(list)do
lp[v]=1
end
end
self.baseData.mPvEJoinLookup=lp
self.baseData.mPvEJoinLookup_refrsh=gameUtilityModel.getServerLongTime()
end

function zhengzhanshanhaiModel:checkPvEJoinDatas()
if self.baseData==nil then return end
local time=self.baseData.mPvEJoinLookup_refrsh
if time then
local check
local y,m,d=timeHelper.getServerData()
local t1=timeHelper.timeServer(y,m,d,0,0,5)
if time>=t1 then
check=true
else
local cur=gameUtilityModel.getServerLongTime()
if cur<t1 then
check=true
else
check=false
end
end
if not check then
self.baseData.mPvEJoinLookup={}
self.baseData.mPvEJoinLookup_refrsh=gameUtilityModel.getServerLongTime()
end
end
end

function zhengzhanshanhaiModel:setPvEJoin(qbguid)
zhengzhanshanhaiModel:checkPvEJoinDatas()
if self.baseData==nil then return end
local lp=self.baseData.mPvEJoinLookup
if lp then
if lp[qbguid]then
lp[qbguid]=lp[qbguid]+1
else
lp[qbguid]=1
end
end
end

function zhengzhanshanhaiModel:getPvEJoin(qbguid)
zhengzhanshanhaiModel:checkPvEJoinDatas()
if self.baseData==nil then return end
local lp=self.baseData.mPvEJoinLookup
if lp then
return lp[qbguid]
end
end

function zhengzhanshanhaiModel:checkPvEJoin(qbguid,isWarning)
local num=zhengzhanshanhaiModel:getPvEJoin(qbguid)
if num~=nil and num>0 then
if isWarning then
UIManager.error('该异兽今日已参与过集结')
end
return false
end
return true
end





function zhengzhanshanhaiModel:handlePvEJiJieData(jjData)
jjData.fight_num=mathHelper.int64_to_number(jjData.fight)
end

function zhengzhanshanhaiModel:initPvEJiJieDatas(len,datas)
if self.baseData==nil then return end
local lp={}
if len>0 then
for i,v in ipairs(datas)do
zhengzhanshanhaiModel:handlePvEJiJieData(v)
lp[v.guid]=v
end
end
self.baseData.mPvEJiJieLookup=lp
self.baseData.mPvEJiJie_time=gameUtilityModel.getServerShortTime()
end

function zhengzhanshanhaiModel:getPvEJiJieDatasList()
local list={}
if self.baseData then
local lp=zhengzhanshanhaiModel:getMyXMAllMonsterPvETeams()
local lp2=self.baseData.mPvEJiJieLookup or{}
for k,teamData in pairs(lp)do
local qbData=teamData:getQingBaoData()
if qbData then
local jjData=lp2[teamData.guid]
if jjData then
table.insert(list,jjData)
end
end
end
end
return list
end

function zhengzhanshanhaiModel:recv_changePVEJiJie(guid,setoutnum)
if self.baseData and self.baseData.mPvEJiJieLookup then
local jjData=self.baseData.mPvEJiJieLookup[guid]
if jjData then
jjData.setoutnum=setoutnum
end
end
end

function zhengzhanshanhaiModel:getPvEJiJieDatasNum()
local num=0
if self.baseData then
local lp=zhengzhanshanhaiModel:getMyXMAllMonsterPvETeams()
for k,teamData in pairs(lp)do
local qbData=teamData:getQingBaoData()
if qbData then
num=num+1
end
end
end
return num
end




function zhengzhanshanhaiModel:checkPvEJiJie()
if self.baseData then
local needRefresh=false
if self.baseData.mPvEJiJie_time==nil or gameUtilityModel.getServerShortTime()-self.baseData.mPvEJiJie_time>=jijieRefreshTime then
needRefresh=true
end
if needRefresh then
zhengzhanshanhaiController:reqXMJiJie()
zhengzhanshanhaiController:reqSHBaodi()
zhengzhanshanhaiController:setOpenXMJiJieMark(true)

else
zhengzhanshanhaiController:openXMJiJie()
end
end
end

function zhengzhanshanhaiModel:rec_zhaoji()
self.mZhaoJiCoolTime=gameUtilityModel.getServerShortTime()
end

function zhengzhanshanhaiModel:checkZhaoJiCoolDown(isWarning)
if self.mZhaoJiCoolTime==nil or gameUtilityModel.getServerShortTime()-self.mZhaoJiCoolTime>=zhaojiCoolTime then
return true
end
if isWarning then
UIManager.error('召集过于频繁，请稍后尝试')
end
return false
end





function zhengzhanshanhaiModel:getDZCollectCfg(dzguid,moneyType)

local res={0,0}
local jjlv=UIDiscipleModel:getDiscipleJJLevel(dzguid)
local cfg=cfgHelper.get3(cfg_disciplejingjieconfig_get,jjlv,'zzsh',moneyType)
res[1]=res[1]+cfg[1]
res[2]=res[2]+cfg[2]
local ltlv=UIDiscipleModel:getDiscipleLTLevel(dzguid)
cfg=cfgHelper.get3(cfg_disciplelianticonfig_get,ltlv,'zzsh',moneyType)
res[1]=res[1]+cfg[1]
res[2]=res[2]+cfg[2]
return res
end

function zhengzhanshanhaiModel:getDZGroupCollectCfg(dzlist,moneyType)

local res={0,0}

local add={0,0}
if dzlist then
local dzColletRate=0
local dzColletKeepRate=0
for i,dzguid in ipairs(dzlist)do
if tostring(dzguid)~='0'then
local res_=zhengzhanshanhaiModel:getDZCollectCfg(dzguid,moneyType)
res[1]=res[1]+res_[1]
res[2]=res[2]+res_[2]

local netData=UIDiscipleModel:getAnyDiscipleDataByStr(tostring(dzguid))
dzColletRate=dzColletRate+dzSpecialitySpecialEffectController:getZZSHCollectRate(netData)
dzColletKeepRate=dzColletKeepRate+dzSpecialitySpecialEffectController:getZZSHCollectKeepRate(netData)
end
end

dzColletRate=dzColletRate+xianmengModel:GetSkill_Effect(eXMMouLueEffectType.eZZSHAddCollectRate)
dzColletKeepRate=dzColletKeepRate+xianmengModel:GetSkill_Effect(eXMMouLueEffectType.eZZSHAddCollectKeepRate)

add[1]=add[1]+dzColletRate
add[2]=add[2]+dzColletKeepRate
res[1]=res[1]*(1+add[1]/100)
res[2]=math.floor(res[2]*(1+add[2]/100))
end
return res,add
end

function zhengzhanshanhaiModel:checkDZFree(dzguid,isWarning)
local infotype=zhengzhanshanhaiModel:checkDZInMyWaiPai(dzguid)
if infotype then
if isWarning then
if infotype==zhengzhanshanhaiModel.qbType.eMonster then
UIManager.error('弟子已被派遣去集结异兽')
else
UIManager.error('弟子已被派遣去采集宝地')
end
end
return false
end
return true
end

function zhengzhanshanhaiModel.checkDZSortFunc(dzguid)
local infotype=zhengzhanshanhaiModel:checkDZInMyWaiPai(dzguid)
if infotype then
return false
end
return true
end





function zhengzhanshanhaiModel:getSignRecord()
local record=userActorArraySetting.getBase(ACTOR_SETTING_TYPE.eZhengZhanShanHai,{})
if record.signs==nil then
record.signs={}
end
return record.signs
end

function zhengzhanshanhaiModel:setSignRecord(data)
local record=userActorArraySetting.getBase(ACTOR_SETTING_TYPE.eZhengZhanShanHai,{})
if record.signs==nil then
record.signs={}
end
table.insert(record.signs,data)
userActorArraySetting.flush(ACTOR_SETTING_TYPE.eZhengZhanShanHai)
end

function zhengzhanshanhaiModel:checkSignRecord(x,y)
local record=userActorArraySetting.getBase(ACTOR_SETTING_TYPE.eZhengZhanShanHai,{})
if record.signs==nil then
record.signs={}
end
for i,v in ipairs(record.signs)do
if v.x==x and v.y==y then
return true,i
end
end
return false,nil
end

function zhengzhanshanhaiModel:getSignRecordNum()
local record=userActorArraySetting.getBase(ACTOR_SETTING_TYPE.eZhengZhanShanHai,{})
if record.signs==nil then
record.signs={}
end
return#record.signs
end


function zhengzhanshanhaiModel:removeSignRecord(idxs)
if idxs==nil then return end
local c=#idxs
if c<=0 then return end
if c>1 then
table.sort(idxs,function(a,b)
return a>b
end)
end
local record=userActorArraySetting.getBase(ACTOR_SETTING_TYPE.eZhengZhanShanHai,{})
if record.signs==nil then
record.signs={}
end
for i,id in ipairs(idxs)do
table.remove(record.signs,id)
end
userActorArraySetting.flush(ACTOR_SETTING_TYPE.eZhengZhanShanHai)
end

function zhengzhanshanhaiModel:removeSignRecordEx(idx)
local record=userActorArraySetting.getBase(ACTOR_SETTING_TYPE.eZhengZhanShanHai,{})
if record.signs==nil then
record.signs={}
end
local sign=table.remove(record.signs,idx)
if sign then
userActorArraySetting.flush(ACTOR_SETTING_TYPE.eZhengZhanShanHai)
return true
end
return false
end





function zhengzhanshanhaiModel:getPvESetting()
return self.pveSetting
end

function zhengzhanshanhaiModel:setPvESetting(setting)
if setting==nil then return end
self.pveSetting[1]=setting[1]
self.pveSetting[2]=setting[2]
end

function zhengzhanshanhaiModel:checkPvETeamBySetting(teamData)
local teamSelect=self.pveSetting[1]
if teamSelect then
local isMy=teamData:isMyXMTeam()
if isMy then
if zhengzhanshanhaiModel:checkInMyWaiPai(teamData.guid)then
return teamSelect[1]~=false
else
return teamSelect[2]~=false
end
else
return teamSelect[3]~=false
end
end
return true
end

function zhengzhanshanhaiModel:checkPvPTeamBySetting(teamData)
local teamSelect=self.pveSetting[1]
if teamSelect then
local isMy=teamData:isMyXMTeam()
if isMy then
return teamSelect[2]~=false
else
return teamSelect[3]~=false
end
end
return true
end





function zhengzhanshanhaiModel:getQingBaoCfg(infotype,id)
local cfg
if infotype==zhengzhanshanhaiModel.qbType.eMonster then
cfg=zhengzhanshanhaiController:getZZSHCfg_yishou(id)
else
cfg=zhengzhanshanhaiController:getZZSHCfg_baodi(id)
end
return cfg
end

function zhengzhanshanhaiModel:getQingBaoName(infotype,cfg)
local name
if infotype==zhengzhanshanhaiModel.qbType.eMonster then
local monsterGroupId=cfg.monster[1]
local groupcfg=cfgHelper.get1(cfg_monstergroup_get,monsterGroupId)
name=groupcfg.name
else
local moneyName=moneyModel.getMoneyName(cfg.moneytype)
name=FMT.fmt('{0}阶{1}',cfg.stage,moneyName)
end
return name
end

function zhengzhanshanhaiModel:getMonsterMassCfg()
return zhengzhanshanhaiController:getZZSHCfg('mass')
end

function zhengzhanshanhaiModel:getMaxMonsterTeamNum()
local mass=zhengzhanshanhaiModel:getMonsterMassCfg()
local max=mass[2]

max=max+xianmengModel:GetSkill_Effect(eXMMouLueEffectType.eZZSHAddMonsterTeamNum)
local fix=mass[1]
return max,fix
end

function zhengzhanshanhaiModel:getMaxWaiPaiNum()
return zhengzhanshanhaiController:getZZSHCfg('team',2)
end


local colorStrLookup={
'<color=#309e35>{0}</color>','<color=#2694af>{0}</color>','<color=#8e3ab1>{0}</color>',
'<color=#c38226>{0}</color>','<color=#d23535>{0}</color>',
}
function zhengzhanshanhaiModel:getColorStr(str,color)
return FMT.fmt(colorStrLookup[color],str)
end

function zhengzhanshanhaiModel:getMapID(typo)
return zhengzhanshanhaiController:getZZSHCfg('mapid',typo)
end

function zhengzhanshanhaiModel:getShareStr(data)
local contentStr
if data.shareType<=7 then
contentStr=cfgHelper.getlang(FMT.fmt("zhengzhanshanhai_share_pos{0}",data.shareType))
end
local name_str=data.shareName
if name_str~=''then
name_str=FMT.fmt('【{0}】',name_str)
if data.stage and data.stage>0 then
name_str=toColorString(data.stage,name_str)
end
end
if contentStr~=nil then
local str=FMT.fmt(contentStr,name_str,data.x,data.y)
return str
else
return data.shareName
end
end

function zhengzhanshanhaiModel:get_entityAutoScaleMin()
return self.entityAutoScaleMin or 0.8
end

function zhengzhanshanhaiModel:calculateWayTime(x1,y1,x2,y2)
local dis=mathHelper.distance(x1,y1,x2,y2)
local step=zhengzhanshanhaiModel:getPvEMoveStep()
return math.max(1,math.ceil(dis/step))
end

function zhengzhanshanhaiModel:getPvEMoveStep()
return zhengzhanshanhaiController:getZZSHCfg('step',2)
end

function zhengzhanshanhaiModel:getRewardShow(config)
local rewards=config.rewardShow
local zmlv=zongmenModel:getLevel()
local n=#rewards
for i=n,1,-1 do
local v=rewards[i]
if zmlv>=v[1]then
return v[2]
end
end
return rewards[1][2]
end






function zhengzhanshanhaiModel:isBXReddot()
local reddotCount=0

local num_initial=zhengzhanshanhaiModel:isBXReddot_initial()
reddotCount=reddotCount+num_initial

if reddotCount<99 then
local shSeasonId=zhengzhanshanhaiModel:getSHSeasonId()
if shSeasonId and shSeasonId>-1 then
local num_season=zhengzhanshanhaiModel:isBXReddot_season()
reddotCount=reddotCount+num_season
end
end

if reddotCount>99 then reddotCount=99 end

return reddotCount
end


function zhengzhanshanhaiModel:isBXReddotout()
local reddot_initial=zhengzhanshanhaiModel:isBXReddotout_initial()
if reddot_initial then
return true
end

local shSeasonId=zhengzhanshanhaiModel:getSHSeasonId()
if shSeasonId and shSeasonId>-1 then
return zhengzhanshanhaiModel:isBXReddotout_season()
end

return false
end

function zhengzhanshanhaiModel:getBXKeyLookupList()
if fastCheckBXKeyLookup then
return fastCheckBXKeyLookup
end

fastCheckBXKeyLookup={
[eMoneyType.mtBaoXia1]=true,
[eMoneyType.mtBaoXia2]=true,
[eMoneyType.mtBaoXia3]=true,
[eMoneyType.mtBaoXia4]=true,
[eMoneyType.mtBaoXia5]=true,
}

local allBoxCfg=cfg_zhengzhanshanhaiboxnewconfig()
for seasonLv,lvCfg in pairs(allBoxCfg)do
for stage,cfg in pairs(lvCfg)do
local consume=cfg.consume
if consume then
for i,v in ipairs(consume)do
local moneyType=v[1]
if not fastCheckBXKeyLookup[moneyType]then
fastCheckBXKeyLookup[moneyType]=true
end
end
end
end
end

return fastCheckBXKeyLookup
end


function zhengzhanshanhaiModel:initTreasureBoxData_initial()
if not self.initBoxData then
local cfg=cfg_zhengzhanshanhaiboxconfig()
for k,v in ipairs(cfg)do
local temp=
{
idx=v.id,
recv=0,
cfg=v,
}
table.insert(self.treasureBoxData,v.id,temp)
end

end

self.initBoxData=true
end

function zhengzhanshanhaiModel:setTreasureBoxData_initial(idx,recv,flag)
if not self.initBoxData then return end
local temp=self.treasureBoxData[idx]

if flag then
temp.recv=recv
else
temp.recv=temp.recv+recv
end
end

function zhengzhanshanhaiModel:getTreasureBoxData_initial()
return self.treasureBoxData
end


function zhengzhanshanhaiModel:isBXReddot_initial()
local reddotCount=0

for k,v in ipairs(self.treasureBoxData)do
if v.recv<v.cfg.max then
local consume=v.cfg.consume[1]
local boxCount=moneyModel.getMoney(consume[1])or 0
local box_cost=consume[2]
local canOpenBoxCount=v.cfg.max-v.recv
if canOpenBoxCount<0 then canOpenBoxCount=0 end
local isEnoughOpen=boxCount>=box_cost*canOpenBoxCount or false

if canOpenBoxCount>0 and not isEnoughOpen and boxCount>=box_cost then
canOpenBoxCount=math.floor(boxCount/box_cost)
isEnoughOpen=boxCount>=box_cost*canOpenBoxCount or false
end

if canOpenBoxCount>0 and isEnoughOpen then
reddotCount=reddotCount+canOpenBoxCount
end
end
end

if reddotCount>99 then reddotCount=99 end

return reddotCount
end


function zhengzhanshanhaiModel:isBXReddotout_initial()
for k,v in ipairs(self.treasureBoxData)do
if v.recv<v.cfg.max then
local consume=v.cfg.consume[1]
local boxCount=moneyModel.getMoney(consume[1])or 0
local box_cost=consume[2]
local canOpenBoxCount=v.cfg.max-v.recv
if canOpenBoxCount<0 then canOpenBoxCount=0 end
local isEnoughOpen=boxCount>=box_cost*canOpenBoxCount or false

if canOpenBoxCount>0 and not isEnoughOpen and boxCount>=box_cost then
canOpenBoxCount=math.floor(boxCount/box_cost)
isEnoughOpen=boxCount>=box_cost*canOpenBoxCount or false
end

if canOpenBoxCount>0 and isEnoughOpen then
return true
end
end
end
return false
end


function zhengzhanshanhaiModel:isHasInitialBXCost()
for k,v in ipairs(self.treasureBoxData)do
local consume=v.cfg.consume[1]
local boxCount=moneyModel.getMoney(consume[1])or 0
local box_cost=consume[2]
local isEnoughOpen=boxCount>=box_cost or false
if isEnoughOpen then
return true
end
end

return false
end

function zhengzhanshanhaiModel:checkTreasureBoxDataIsInit_season()
return self.initBoxData_season
end

function zhengzhanshanhaiModel:setTempTreasureBoxData_season(len,data)
self.tempTreasureBoxData_season={len=len,data=data}
end

function zhengzhanshanhaiModel:checkTempTreasureBoxData_season()
if self.tempTreasureBoxData_season then

local len=self.tempTreasureBoxData_season.len
if len>0 then
local data=self.tempTreasureBoxData_season.data
for i=1,len do
zhengzhanshanhaiModel:setTreasureBoxData_season(data[i].param_1,data[i].param_2,true)
end
end
self.tempTreasureBoxData_season=nil
end
end

function zhengzhanshanhaiModel:initTreasureBoxData_season(isReset)
if not isReset and self.initBoxData_season then
return
end

self.treasureBoxData_season={}
local shSeasonId=zhengzhanshanhaiModel:getSHSeasonId()
if shSeasonId and shSeasonId>-1 then
local shSeasonLv=zhengzhanshanhaiModel:getSeasonLv()or 1
local cfg=cfgHelper.get(cfg_zhengzhanshanhaiboxnewconfig_get,shSeasonLv)
if cfg then
for k,v in ipairs(cfg)do
local temp=
{
idx=v.stage,
recv=0,
cfg=v,
}
table.insert(self.treasureBoxData_season,v.stage,temp)
end
end

end

self.initBoxData_season=true
end

function zhengzhanshanhaiModel:setTreasureBoxData_season(stage,recv,flag)
if not self.initBoxData_season then return end
local temp=self.treasureBoxData_season[stage]
if temp then

if flag then
temp.recv=recv
else
temp.recv=temp.recv+recv
end
else
logErr(FMT.fmt("找不到山海赛季-山海宝匣{0}阶对应的宝箱数据 请检查初始化流程是否正确 当前山海宝匣数据:{1}",stage,serializeHelper.serialize(self.treasureBoxData_season)))
end
end

function zhengzhanshanhaiModel:getTreasureBoxData_season()
return self.treasureBoxData_season
end


function zhengzhanshanhaiModel:isBXReddot_season()
local reddotCount=0
if self.treasureBoxData_season then
for k,v in ipairs(self.treasureBoxData_season)do
if v.recv<v.cfg.max then
local consume=v.cfg.consume[1]
local boxCount=moneyModel.getMoney(consume[1])or 0
local box_cost=consume[2]
local canOpenBoxCount=v.cfg.max-v.recv
if canOpenBoxCount<0 then canOpenBoxCount=0 end
local isEnoughOpen=boxCount>=box_cost*canOpenBoxCount or false

if canOpenBoxCount>0 and not isEnoughOpen and boxCount>=box_cost then
canOpenBoxCount=math.floor(boxCount/box_cost)
isEnoughOpen=boxCount>=box_cost*canOpenBoxCount or false
end

if canOpenBoxCount>0 and isEnoughOpen then
reddotCount=reddotCount+canOpenBoxCount
end
end
end
else
logErr("获取正式赛季宝匣红点时未初始化宝匣数据 请检查协议顺序")
end

if reddotCount>99 then reddotCount=99 end

return reddotCount
end


function zhengzhanshanhaiModel:isBXReddotout_season()
for k,v in ipairs(self.treasureBoxData_season)do
if v.recv<v.cfg.max then
local consume=v.cfg.consume[1]
local boxCount=moneyModel.getMoney(consume[1])or 0
local box_cost=consume[2]
local canOpenBoxCount=v.cfg.max-v.recv
if canOpenBoxCount<0 then canOpenBoxCount=0 end
local isEnoughOpen=boxCount>=box_cost*canOpenBoxCount or false

if canOpenBoxCount>0 and not isEnoughOpen and boxCount>=box_cost then
canOpenBoxCount=math.floor(boxCount/box_cost)
isEnoughOpen=boxCount>=box_cost*canOpenBoxCount or false
end

if canOpenBoxCount>0 and isEnoughOpen then
return true
end
end
end
return false
end



function zhengzhanshanhaiModel:getMomentNum()
if self.baseData then
return self.baseData.momentum
end
return 0
end

function zhengzhanshanhaiModel:setMomentNum(num)
if self.baseData then
self.baseData.momentum=num
end
end

function zhengzhanshanhaiModel:getTimeRecord()
if not self.timeRecord then
self.timeRecord={}
end
return self.timeRecord
end


function zhengzhanshanhaiModel:getMomentumData()
return self.MomentumData
end


function zhengzhanshanhaiModel:SetZCMomentumData(attacklistlen,ZCattacklist,defendlistlen,ZCdefendlist)
if not self.MomentumData then
self.MomentumData={}
end
self.MomentumData.ZCattacklist=ZCattacklist or{}
self.MomentumData.ZCdefendlist=ZCdefendlist or{}
self.MomentumData.mappingZcList={}
for i=1,attacklistlen do
local cur=self.MomentumData.ZCattacklist[i]
cur.attackSort=cur.times*100+(attacklistlen-i)
cur.defend=0
self.MomentumData.mappingZcList[cur.actorid]=cur
end

for i=1,defendlistlen do
local cur=self.MomentumData.ZCdefendlist[i]
cur.defendSort=cur.times*100+(defendlistlen-i)
if self.MomentumData.mappingZcList[cur.actorid]then
self.MomentumData.mappingZcList[cur.actorid].defend=cur.times
cur.attack=self.MomentumData.mappingZcList[cur.actorid].times
else
cur.attack=0
end
end

table.sort(self.MomentumData.ZCattacklist,function(a,b)
return a.attackSort>b.attackSort
end)

table.sort(self.MomentumData.ZCdefendlist,function(a,b)
return a.defendSort>b.defendSort
end)
end


function zhengzhanshanhaiModel:SetXMMomentumData(attacklistlen,XMattacklist)
if not self.MomentumData then
self.MomentumData={}
end
self.MomentumData.XMattacklist=XMattacklist or{}
for i=1,attacklistlen do
local cur=self.MomentumData.XMattacklist[i]
cur.attackSort=cur.attack*10000+cur.defend*100+(attacklistlen-i)
cur.defendSort=cur.defend*10000+cur.attack*100+(attacklistlen-i)
end
end


function zhengzhanshanhaiModel:SetBZMomentumData(attacklistlen,BZattacklist)
if not self.MomentumData then
self.MomentumData={}
end
self.MomentumData.BZattacklist=BZattacklist or{}
end



function zhengzhanshanhaiModel:SetXMRankList(XMRanklen,RaceXMRankList)
if not self.MomentumData then
self.MomentumData={}
end
self.MomentumData.RaceXMRankList=RaceXMRankList or{}
for i=1,#self.MomentumData.RaceXMRankList do
local guildid=self.MomentumData.RaceXMRankList[i].guildid
if xianmengModel:myXMGuildID()==guildid then
self.MomentumData.myRaceXMRankIndex=i
break
end
end
end

function zhengzhanshanhaiModel:GetXMRankList()
return self.MomentumData.RaceXMRankList or{}
end


function zhengzhanshanhaiModel:SetLocalXMDataList(localXMDataLen,localRaceXMDataList)
if not self.MomentumData then
self.MomentumData={}
end
self.MomentumData.localRaceXMDataList=localRaceXMDataList or{}
end


function zhengzhanshanhaiModel:SetHisList(hisListLen,RacehisList)
if not self.MomentumData then
self.MomentumData={}
end
self.MomentumData.RacehisList=RacehisList or{}
end


function zhengzhanshanhaiModel:initPvEResourceDatas(len,datas)
if self.baseData==nil then return end
local lp={}
if len>0 then
for i,v in ipairs(datas)do
zhengzhanshanhaiModel:handlePvEJiJieData(v)
lp[v.guid]=v
end
end
self.baseData.mPvEBaoDiLookup=lp

end


function zhengzhanshanhaiModel:getPvEResourceDatasList()
local list={}
if self.baseData then
local lp=zhengzhanshanhaiModel:getMyXMAllResourcePvETeams()
local lp2=self.baseData.mPvEBaoDiLookup or{}
for k,teamData in pairs(lp)do

local qbData=teamData:getQingBaoData()
if qbData then
local jjData=lp2[teamData.guid]
if jjData then
table.insert(list,jjData)
end

end


end
end
return list
end

function zhengzhanshanhaiModel:getMyXMAllResourcePvETeams()
local lp={}
if self.data and self.data.teamsData then
for k,teamData in pairs(self.data.teamsData)do
if teamData:isResourceTeam()and teamData:isMyXMTeam()then
lp[teamData.guid]=teamData
end
end
end
return lp
end

function zhengzhanshanhaiModel:getPvEBaodiDatasNum()
local num=0
if self.baseData then
local lp=zhengzhanshanhaiModel:getMyXMAllResourcePvETeams()
local lp2={}
for k,teamData in pairs(lp)do

local qbData=teamData:getQingBaoData()
if qbData then

if lp2[qbData.guid]==nil then
lp2[qbData.guid]=true
num=num+1
end
end

end
end
return num
end


function zhengzhanshanhaiModel:needrefresh()
self.baseData.mPvEJiJie_time=nil
end


function zhengzhanshanhaiModel:setMapRecord(data)

local record=userActorArraySetting.getBase(ACTOR_SETTING_TYPE.eZhengZhanShanHai,{})
record.SHMap=data
userActorArraySetting.flush(ACTOR_SETTING_TYPE.eZhengZhanShanHai)
end

function zhengzhanshanhaiModel:getMapRecord()
local record=userActorArraySetting.getBase(ACTOR_SETTING_TYPE.eZhengZhanShanHai,{})

return record.SHMap
end


function zhengzhanshanhaiModel:getSHSeasonId()
if self.seasonData==nil then
self.seasonData={}
end

if self.seasonData.shSeasonId and not self.seasonData.shSeasonId_dirty then
return self.seasonData.shSeasonId
end

self.seasonData.shSeasonId_dirty=nil
local firstTime=zhengzhanshanhaiModel:getFirstSeasonBeginTime()
if not firstTime then
self.seasonData.shSeasonId=-1
return self.seasonData.shSeasonId
end

local id=-1
local nowTime=timeHelper.getServerShortTime()
if nowTime>=firstTime then
local allSeasonCfg=cfg_zhengzhanshanhainewconfig()
local nowTime_long=timeHelper.getServerLongTime()
local serverPlatform=gameUtilityModel.getServerPlatform()
for _,cfg in ipairs(allSeasonCfg)do
local startTime=cfg.start_time[serverPlatform]or cfg.start_time[0]
startTime=timeHelper.dataToTimeStam(startTime)
if nowTime_long>=startTime then
id=cfg.id
end


local settleTime=cfg.settle_time[serverPlatform]or cfg.settle_time[0]
settleTime=timeHelper.dataToTimeStam(settleTime)
if nowTime_long<=settleTime then
break
end
end
end

self.seasonData.shSeasonId=id

return self.seasonData.shSeasonId
end

function zhengzhanshanhaiModel:getFirstSHSeasonId()
if self.seasonData==nil then
self.seasonData={}
end

if self.seasonData.firstShSeasonId then
return self.seasonData.firstShSeasonId
end

local firstTime=zhengzhanshanhaiModel:getFirstSeasonBeginTime()
if not firstTime then

return nil
end
local firstTime_long=timeHelper.convertLongStamp(firstTime)

local id
local allSeasonCfg=cfg_zhengzhanshanhainewconfig()
local serverPlatform=gameUtilityModel.getServerPlatform()
for _,cfg in pairs(allSeasonCfg)do
local startTime=cfg.start_time[serverPlatform]or cfg.start_time[0]
startTime=timeHelper.dataToTimeStam(startTime)
local endTime=cfg.end_time[serverPlatform]or cfg.end_time[0]
endTime=timeHelper.dataToTimeStam(endTime)
if firstTime_long>=startTime and firstTime_long<endTime then
id=cfg.id
break
end
end

self.seasonData.firstShSeasonId=id

return self.seasonData.firstShSeasonId
end



function zhengzhanshanhaiModel:setSHSeasonId_DirtyMark()
if self.seasonData==nil then
self.seasonData={}
end
self.seasonData.shSeasonId_dirty=true
end






function zhengzhanshanhaiModel:getSeasonState()
local state=eZZSH_Season_State.eNone
local startTime,endTime,settleTime,settleEndTime=zhengzhanshanhaiModel:getSeasonTime()
local nowTime_long=timeHelper.getServerLongTime()
if nowTime_long<startTime then
state=eZZSH_Season_State.eNone
else
if settleTime then
if nowTime_long<settleTime then
state=eZZSH_Season_State.ePlanting
else

if settleEndTime and nowTime_long<settleEndTime then
state=eZZSH_Season_State.eSettlement
else
state=eZZSH_Season_State.eOffSeason
end
end
else
state=eZZSH_Season_State.ePlanting
end
end

return state
end



function zhengzhanshanhaiModel:getSeasonTime()
local shSeasonId=zhengzhanshanhaiModel:getSHSeasonId()
local startTime,endTime,settleTime,settleEndTime=zhengzhanshanhaiModel:getSeasonTimeBySHSeasonId(shSeasonId)
if shSeasonId==-1 then
startTime=0

local finalSettleTime=zhengzhanshanhaiModel:getInitialSeasonSettleTime()
if finalSettleTime then
local finalSettleTime_long=timeHelper.convertLongStamp(finalSettleTime)
local initialSeasonSettleTime=finalSettleTime_long
if initialSeasonSettleTime and initialSeasonSettleTime>0 then

settleTime=initialSeasonSettleTime
end
end

local firstTime=zhengzhanshanhaiModel:getFirstSeasonBeginTime()
if not firstTime and finalSettleTime then
local nowTime=timeHelper.getServerShortTime()
if nowTime>=finalSettleTime then

local openDays=cfgHelper.getglobal1('newzzsh_open_days')
firstTime=finalSettleTime+openDays*86400
end
end

if firstTime then
local firstTime_long=timeHelper.convertLongStamp(firstTime)
local initialSeasonEndTime=firstTime_long
if initialSeasonEndTime and initialSeasonEndTime>0 then
endTime=initialSeasonEndTime
settleEndTime=endTime
end
end
end

return startTime,endTime,settleTime,settleEndTime
end



function zhengzhanshanhaiModel:getSeasonTimeBySHSeasonId(shSeasonId)
if not shSeasonId or shSeasonId==-1 then
return nil
end
if self.seasonData==nil then
self.seasonData={}
end
if self.seasonData.seasonTimeLookup==nil then
self.seasonData.seasonTimeLookup={}
end

local startTime
local endTime
local settleTime
local settleEndTime
if self.seasonData.seasonTimeLookup[shSeasonId]then
local times=self.seasonData.seasonTimeLookup[shSeasonId]
startTime=times.startTime
endTime=times.endTime
settleTime=times.settleTime
settleEndTime=times.settleEndTime
else
local cfg=cfgHelper.get(cfg_zhengzhanshanhainewconfig_get,shSeasonId)
local serverPlatform=gameUtilityModel.getServerPlatform()
if cfg then
startTime=cfg.start_time[serverPlatform]or cfg.start_time[0]
startTime=timeHelper.dataToTimeStam(startTime)
endTime=cfg.end_time[serverPlatform]or cfg.end_time[0]
endTime=timeHelper.dataToTimeStam(endTime)
settleTime=cfg.settle_time[serverPlatform]or cfg.settle_time[0]
settleTime=timeHelper.dataToTimeStam(settleTime)
settleEndTime=cfg.settle_end_time[serverPlatform]or cfg.settle_end_time[0]
settleEndTime=timeHelper.dataToTimeStam(settleEndTime)

local times={
startTime=startTime,
endTime=endTime,
settleTime=settleTime,
settleEndTime=settleEndTime,
}
self.seasonData.seasonTimeLookup[shSeasonId]=times
end
end

startTime=startTime and startTime+60 or nil
endTime=endTime and endTime+60 or nil
return startTime,endTime,settleTime,settleEndTime
end


function zhengzhanshanhaiModel:getSeasonLv()
if self.baseData then
return self.baseData.availv or 1
end
return 1
end


function zhengzhanshanhaiModel:getServerIdList()
if self.seasonData then
return self.seasonData.serverIdList
end
return nil
end

function zhengzhanshanhaiModel:setServerIdList(len,list)
if self.seasonData==nil then
self.seasonData={}
end
self.seasonData.serverIdList=list
end

function zhengzhanshanhaiModel:getFirstSeasonBeginTime()
if self.seasonData then
return self.seasonData.firstSeasonBeginTime
end
return nil
end

function zhengzhanshanhaiModel:setFirstSeasonBeginTime(time)
if self.seasonData==nil then
self.seasonData={}
end


self.seasonData.firstSeasonBeginTime=time+3
end

function zhengzhanshanhaiModel:getInitialSeasonSettleTime()
if self.seasonData then
return self.seasonData.initialSeasonSettleTime
end
return nil
end

function zhengzhanshanhaiModel:setInitialSeasonSettleTime(time)
if self.seasonData==nil then
self.seasonData={}
end


self.seasonData.initialSeasonSettleTime=time+3
end

function zhengzhanshanhaiModel:clearSeasonData()
self.seasonData=nil
end


function zhengzhanshanhaiModel:checkIsInSeason()

local firstTime=zhengzhanshanhaiModel:getFirstSeasonBeginTime()
if firstTime then
local nowTime=timeHelper.getServerShortTime()
return nowTime>firstTime
end
return false
end


function zhengzhanshanhaiModel:getServerList()
local shSeasonId=zhengzhanshanhaiModel:getSHSeasonId()
if shSeasonId==-1 then

return loginModel:getServerList()
else

return zhengzhanshanhaiModel:getServerIdList()
end
end


function zhengzhanshanhaiModel:loadServerListBrowsedSeasonId()
local seasonId=userActorSetting.get('serverListBrowsedSeasonId',-1)
return seasonId
end


function zhengzhanshanhaiModel:saveServerListBrowsedSeasonId()

local shSeasonId=zhengzhanshanhaiModel:getSHSeasonId()
local saveSeasonId=zhengzhanshanhaiModel:loadServerListBrowsedSeasonId()
if shSeasonId>saveSeasonId then
userActorSetting.set('serverListBrowsedSeasonId',shSeasonId)
userActorSetting.flush()
return true
end

return false
end


function zhengzhanshanhaiModel:loadUpdateMsgBrowsedSeasonId()
local seasonId=userActorSetting.get('updateMsgBrowsedSeasonId',-1)
return seasonId
end


function zhengzhanshanhaiModel:saveUpdateMsgBrowsedSeasonId(shSeasonId)
local saveSeasonId=zhengzhanshanhaiModel:loadUpdateMsgBrowsedSeasonId()
if shSeasonId>saveSeasonId then
userActorSetting.set('updateMsgBrowsedSeasonId',shSeasonId)
userActorSetting.flush()
return true
end

return false
end


function zhengzhanshanhaiModel:checkIsSeasonDoNotResetTaskAndZhanLing()

if zhengzhanshanhaiModel:checkIsInSeason()then
local firstTime=zhengzhanshanhaiModel:getFirstSeasonBeginTime()
if firstTime then
local firstTime_long=timeHelper.convertLongStamp(firstTime)

local o_y,o_m,o_d=timeHelper.getDateNumber(firstTime_long)
local start_time_zero=timeHelper.timeServer(o_y,o_m,o_d,0,0,0)
local start_time_firstSat
local startWeakDay=timeHelper.getWeakDate(firstTime_long)
local weekDay=6
startWeakDay=startWeakDay==0 and 7 or startWeakDay
local divDay
if startWeakDay<weekDay then
divDay=weekDay-startWeakDay
else
divDay=7-startWeakDay+weekDay
end
start_time_firstSat=start_time_zero+divDay*24*3600


local nowTime=timeHelper.getServerLongTime()


if nowTime<=start_time_firstSat then

if startWeakDay<weekDay and weekDay-startWeakDay<=3 then
return true
end
end
end
end


return false
end



function zhengzhanshanhaiModel:testFun_getNowTimeMinStamp(addTime)
local nowTime=timeHelper.getServerShortTime()
local minStamp=math.floor(nowTime/60)
addTime=addTime or 0
local finalMinStamp=math.floor((nowTime+addTime)/60)
logErr(FMT.fmt("测试方法-获取当前分钟时间戳：{0}, 追加时间戳：{1}",minStamp,finalMinStamp))
end

function zhengzhanshanhaiModel:testFun_clearServerListBrowsedSeasonId()
userActorSetting.set('serverListBrowsedSeasonId',nil)
userActorSetting.flush()
end

function zhengzhanshanhaiModel:testFun_clearAllBrowsedSeasonId()
userActorSetting.set('serverListBrowsedSeasonId',nil)
userActorSetting.set('updateMsgBrowsedSeasonId',nil)
userActorSetting.flush()
end


function zhengzhanshanhaiModel:testFun_printSeasonTime()
local startTime,endTime,settleTime,settleEndTime=zhengzhanshanhaiModel:getSeasonTime()
local nowTime_long=timeHelper.getServerLongTime()

local str1=timeHelper.getFormatByStamp2(nowTime_long)

startTime=startTime or 0
local str2
if startTime and startTime>0 then
str2=timeHelper.getFormatByStamp2(startTime)
else
str2="无"
end

local str3
if settleTime and settleTime>0 then
str3=timeHelper.getFormatByStamp2(settleTime)
else
str3="无"
end

local str4
if settleEndTime and settleEndTime>0 then
str4=timeHelper.getFormatByStamp2(settleEndTime)
else
str4="无"
end

local str5
if endTime and endTime>0 then
str5=timeHelper.getFormatByStamp2(endTime)
else
str5="无"
end

end


function zhengzhanshanhaiModel:testFun_printSeasonLunTime(lunList)
local strList={}
for _,lun in ipairs(lunList)do
for _,d in ipairs(lun)do
local state=d[3]
local startTime=d[1]
local endTime=d[2]
local stateName
if state==eZZSH_State.ePVPStandby then
stateName="PVP备战期"
elseif state==eZZSH_State.ePVPFight then
stateName="PVP战争期"
elseif state==eZZSH_State.ePVEFight then
stateName="PVE期"
end
local startTimeStr=string.format("开始时间: %s",timeHelper.getFormatByStamp2(startTime))
local endTimeStr=string.format("结束时间: %s",timeHelper.getFormatByStamp2(endTime))
local strItem={
stateName=stateName,
startTimeStr=startTimeStr,
endTimeStr=endTimeStr,
}
strList[#strList+1]=strItem
end
end

local printStr=serializeHelper.serialize(strList)

end

function zhengzhanshanhaiModel:testFun_printSeasonLunTimeEx()
limitActivitiesModel:invokeMethod(LIMIT_ACT_TYPE.eZhengZhanShanHai,'printLunTime')
end

