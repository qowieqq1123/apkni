







lingxuwenjianModel={}
lingxuwenjianModel.wjFightTime=180


eLXWJ_State={
eIdle=1,
eStandby=2,
eFight=3,
eFinish=4,
}

eLXWJ_ZhenFa_Enum={
eXH=1,
eLX=2,
eYT=3,
}


eLXWJ_Fight_State={
eNone=0,
eFight=1,
eWJIdle=2,
eWJ1=3,
eWJ2=4,
eWJ3=5,
}

local rankRefreshTime=60
local baseDataRefreshTime=60
local notesRefreshTime=60
local scoreNotesRefreshTime=60
local memberListRefreshTime=30
local enemyXMInfoRefreshTime=300
local replayRefreshTime=60
local likeRefreshTime=10

local fazhenNum=3
local zhenyanNum=8



local fazhenAnimChanges={
[0]={
[1]=2144,
[2]=2145,
[3]=2146,
},
[1]={
[1]=2144,
[2]=2147,
[3]=2146,
},
[2]={
[1]=2144,
[2]=2145,
[3]=2148,
},
[3]={
[1]=2144,
[2]=2145,
[3]=2146,
},
}



local zhenyanAnimChanges={
[0]={
[1]=2149,
[2]=2150,
[3]=2151,
[4]=2152,
},
[1]={
[1]=2149,
[2]=2153,
[3]=2151,
[4]=2152,
},
[2]={
[1]=2149,
[2]=2150,
[3]=2154,
[4]=2152,
},
[3]={
[1]=2149,
[2]=2150,
[3]=2151,
[4]=2155,
},
[4]={
[1]=2149,
[2]=2150,
[3]=2151,
[4]=2152,
},
}

function lingxuwenjianModel:getAllZhenYanNum()
return fazhenNum*zhenyanNum
end

function lingxuwenjianModel:clearData()
self.data=nil
self.baseDataRefreshTimer=nil
self.top3RankDatas=nil
self.rankDatas1=nil
self.rankRefreshTimer=nil
self.rankDatas2=nil
self.notesList=nil
self.notesRefreshTimer=nil
self.scoreNotesList=nil
self.scoreNotesRefreshTimer=nil
self.memberListRefreshTimer=nil
self.memberList=nil
self.enemyXMInfo=nil
self.enemyXMInfoRefreshTimer=nil
self.replayRefreshTimer=nil
self.replayLookup=nil
self.raceIndex=nil
self.likeRefreshTimer=nil
self.LEDData=nil
end

function lingxuwenjianModel:checkInit()
return self.data~=nil
end

function lingxuwenjianModel:setEnterBattle(flag)
if self.data then
self.data.enterBattle=flag
end
end

function lingxuwenjianModel:getEnterBattle()
if self.data then
return self.data.enterBattle==true
end
return false
end

function lingxuwenjianModel:initData(team1,team2,attackTimes,battleidx)
if self.data==nil then
self.data={}
end
self.data.fightTeam1=team1
self.data.fightTeam2=team2
self.data.attackTimes=attackTimes
self.data.battleidx=battleidx
end

function lingxuwenjianModel:resetData()
if self.data then
self.data.fightTeam1=nil
self.data.fightTeam2=nil
self.data.attackTimes=0
self.data.battleidx=0

self.data.timesList=nil
if UIManager:isActive('UIXM_LXWJ_Enter_win')then
lingxuwenjianModel:checkBaseDataRefersh()
end
end
end

function lingxuwenjianModel:checkBaseDataRefersh()
local needRefresh
if self.data.timesList==nil or Time.realtimeSinceStartup-self.baseDataRefreshTimer>=baseDataRefreshTime then
self.baseDataRefreshTimer=Time.realtimeSinceStartup
lingxuwenjianController:reqInfo2()
needRefresh=true
else
needRefresh=false
end
return needRefresh
end

function lingxuwenjianModel:initTimesList(list)
self.data.timesList=list or{}
end

function lingxuwenjianModel:getTimes(index)
if self.data then
if index==nil then
return self.data.timesList
else
return self.data.timesList[index]or 0
end
end
return false
end

function lingxuwenjianModel:refreshTimes(index)
if self.data then
local num=self.data.timesList[index]or 0
num=num+1
self.data.timesList[index]=num
end
return false
end

function lingxuwenjianModel:getMaxAttackTimes()
return cfgHelper.get3(cfg_lingxuwenjianconfig_get,1,'match',2)
end

function lingxuwenjianModel:getAttackTimes()
if self.data then
return self.data.attackTimes
end
return nil
end

function lingxuwenjianModel:getAttackLeftTimes()
local lerp=0
if lingxuwenjianModel:checkInit()then
local raceState=lingxuwenjianModel:getLunState()
if raceState==eLXWJ_State.eFight then
if lingxuwenjianModel:hasEnemy()then
local fightState=lingxuwenjianModel:getFightState()
if fightState==eLXWJ_Fight_State.eFight then
if lingxuwenjianModel:checkBattleResult()==nil then
local max=lingxuwenjianModel:getMaxAttackTimes()
local cur=lingxuwenjianModel:getAttackTimes()or max
lerp=max-cur
if lerp<0 then lerp=0 end
end
end
end
end
end
return lerp
end


function lingxuwenjianModel:checkInAttack()
if lingxuwenjianModel:checkInit()then
local raceState,left=lingxuwenjianModel:getLunState()
if raceState==eLXWJ_State.eStandby or raceState==eLXWJ_State.eFight then
return true,left
end
end
return false
end

function lingxuwenjianModel:clearAttackTimes()
if self.data then
self.data.attackTimes=0
end
return nil
end

function lingxuwenjianModel:setAttackTimes()
if self.data then
local times=self.data.attackTimes
times=times+1
self.data.attackTimes=times
end
return nil
end

function lingxuwenjianModel:getOpenDay()
return cfgHelper.get2(cfg_lingxuwenjianconfig_get,1,'open')
end

function lingxuwenjianModel:getLunList(start_time_l)
local lunList={}
local cfg=cfgHelper.get1(cfg_lingxuwenjianconfig_get,1)
for i=1,cfg.battle do
local time_l=start_time_l+(i-1)*7*86400
for i,v in ipairs(cfg.week)do
local d={}
d[1]=time_l+v[1]
d[2]=time_l+v[2]
d[3]=time_l+v[3]
d[4]=time_l+v[4]
d[5]=time_l+v[4]+lingxuwenjianModel.wjFightTime
d[6]=time_l+v[5]
d[7]=time_l+v[5]+lingxuwenjianModel.wjFightTime
d[8]=time_l+v[6]
d[9]=time_l+v[6]+lingxuwenjianModel.wjFightTime
d[10]=time_l+v[7]
d[11]=time_l+v[8]
table.insert(lunList,d)
end
end
return lunList
end

function lingxuwenjianModel:getLunState(cur)
local luntime=limitActivitiesModel:invokeMethod(LIMIT_ACT_TYPE.eLingXuWenJian,'getCurLunTime')
cur=cur or gameUtilityModel.getServerLongTime()
local raceState
local left,left2
if cur>=luntime[1]and cur<luntime[2]then
raceState=eLXWJ_State.eStandby
left=luntime[2]-cur
elseif cur>=luntime[2]and cur<luntime[#luntime-1]then
raceState=eLXWJ_State.eFight
left=luntime[#luntime-1]-cur
left2=luntime[#luntime]-cur
elseif cur>=luntime[#luntime-1]and cur<luntime[#luntime]then
raceState=eLXWJ_State.eFinish
left=luntime[#luntime]-cur
else
raceState=eLXWJ_State.eIdle
if cur<luntime[1]then
left=luntime[1]-cur
else
left=limitActivitiesModel:getActEndLeftTime(LIMIT_ACT_TYPE.eLingXuWenJian)
end
end
return raceState,left,left2
end

function lingxuwenjianModel:getFightState()
local raceState=lingxuwenjianModel:getLunState()
local state
local left
if raceState==eLXWJ_State.eFight then
local luntime=limitActivitiesModel:invokeMethod(LIMIT_ACT_TYPE.eLingXuWenJian,'getCurLunTime')
local cur=gameUtilityModel.getServerLongTime()
if cur>=luntime[2]and cur<luntime[3]then
state=eLXWJ_Fight_State.eFight
left=luntime[3]-cur
elseif cur>=luntime[3]and cur<luntime[4]then
state=eLXWJ_Fight_State.eWJIdle
left=luntime[4]-cur
elseif cur>=luntime[4]and cur<luntime[6]then
state=eLXWJ_Fight_State.eWJ1
left=luntime[6]-cur
elseif cur>=luntime[6]and cur<luntime[8]then
state=eLXWJ_Fight_State.eWJ2
left=luntime[8]-cur
elseif cur>=luntime[8]and cur<luntime[10]then
state=eLXWJ_Fight_State.eWJ3
left=luntime[10]-cur
end
end
if state==nil then
state=eLXWJ_Fight_State.eNone
left=0
end
return state,left
end

function lingxuwenjianModel:checkInWJTFight(fightState,idx)
if fightState==nil then
fightState=lingxuwenjianModel:getFightState()
end
local luntime=limitActivitiesModel:invokeMethod(LIMIT_ACT_TYPE.eLingXuWenJian,'getCurLunTime')
if idx==1 then
if fightState==eLXWJ_Fight_State.eWJ1 then
local cur=gameUtilityModel.getServerLongTime()
if cur<luntime[5]then
return true
end
end
elseif idx==2 then
if fightState==eLXWJ_Fight_State.eWJ2 then
local cur=gameUtilityModel.getServerLongTime()
if cur<luntime[7]then
return true
end
end
elseif idx==3 then
if fightState==eLXWJ_Fight_State.eWJ3 then
local cur=gameUtilityModel.getServerLongTime()
if cur<luntime[9]then
return true
end
end
end
return false
end

function lingxuwenjianModel:checkInWJTFightIndex(fightState)
if fightState==nil then
fightState=lingxuwenjianModel:getFightState()
end
local luntime=limitActivitiesModel:invokeMethod(LIMIT_ACT_TYPE.eLingXuWenJian,'getCurLunTime')
if fightState==eLXWJ_Fight_State.eWJ1 then
local cur=gameUtilityModel.getServerLongTime()
if cur<luntime[5]then
return 1
end
elseif fightState==eLXWJ_Fight_State.eWJ2 then
local cur=gameUtilityModel.getServerLongTime()
if cur<luntime[7]then
return 2
end
elseif fightState==eLXWJ_Fight_State.eWJ3 then
local cur=gameUtilityModel.getServerLongTime()
if cur<luntime[9]then
return 3
end
end
return nil
end

function lingxuwenjianModel:getWJTFightTimeDesc(idx)
local luntime=limitActivitiesModel:invokeMethod(LIMIT_ACT_TYPE.eLingXuWenJian,'getCurLunTime')
local lun
if idx==1 then
lun=luntime[4]
elseif idx==2 then
lun=luntime[6]
elseif idx==3 then
lun=luntime[8]
end
return timeHelper.dateServerStamp('%H:%M',lun)
end

function lingxuwenjianModel:getLunStateName(state)
if state==eLXWJ_State.eStandby then
return'备战阶段'
elseif state==eLXWJ_State.eFight then
return'决战阶段'
elseif state==eLXWJ_State.eFinish then
return'结算阶段'
else
return'休战阶段'
end
end

function lingxuwenjianModel:getLunStateIcon(state)
local icon
if state==eLXWJ_State.eStandby then
icon='image_lingxuwenjianwz_3'
elseif state==eLXWJ_State.eFight then
local result=lingxuwenjianModel:checkBattleResult()

if result~=nil then
icon='image_lingxuwenjianwz_6'
else
icon='image_lingxuwenjianwz_4'
end
elseif state==eLXWJ_State.eFinish then
icon='image_lingxuwenjianwz_6'
else
icon='image_lingxuwenjianwz_5'
end
return globalABLookup.lingxuwenjianicons,icon
end

function lingxuwenjianModel:setScore(score)
self.data.score=score
end

function lingxuwenjianModel:getScore()
if self.data then
return self.data.score
end
return nil
end

function lingxuwenjianModel:getScoreLevel()
local score=lingxuwenjianModel:getScore()or 0
local f
local cfgs=cfg_lingxuwenjianlevelconfig()
for i,cfg in ipairs(cfgs)do
if score<=cfg.max then
f=cfg
break
end
end
return f.id,f.name
end

function lingxuwenjianModel:getScoreCfg(score)
local f
local cfgs=cfg_lingxuwenjianlevelconfig()
for i,cfg in ipairs(cfgs)do
if score<=cfg.max then
f=cfg
break
end
end
local icon=f.icon
local name=f.name
return globalABLookup.lingxuwenjianicons,icon,name
end


function lingxuwenjianModel:getRaceIndex()
if limitActivitiesModel:checkActDoing(LIMIT_ACT_TYPE.eLingXuWenJian)then
return self.raceIndex
else
return self.raceIndex-1
end
end

function lingxuwenjianModel:setRaceIndex(raceIndex)
self.raceIndex=raceIndex
end


function lingxuwenjianModel:getRaceLunIndex()
local lunIndex=limitActivitiesModel:invokeMethod(LIMIT_ACT_TYPE.eLingXuWenJian,'getCurLunIndex')
return lunIndex
end



function lingxuwenjianModel:isBaoMing()
if self.data then
local fightTeam1=self.data.fightTeam1
return fightTeam1~=nil and#fightTeam1>0
end
return false
end

function lingxuwenjianModel:checkInDefTeam(dis_guid)
local data=self.data
if data then
local guidList=data.fightTeam1
if guidList then
for i,dis_guid_ in ipairs(guidList)do
if dis_guid_==dis_guid then
return true
end
end
end
end
return false
end

function lingxuwenjianModel:checkInDefTeam2(dis_guid)
local data=self.data
if data then
local guidList=data.fightTeam2
if guidList then
for i,dis_guid_ in ipairs(guidList)do
if dis_guid_==dis_guid then
return true
end
end
end
end
return false
end

function lingxuwenjianModel:setDefTeam(typo,list)
local data=self.data
if data then
local guidList
if typo==1 then
data.fightTeam1=list
else
data.fightTeam2=list
end
end
return nil
end

function lingxuwenjianModel:getDefTeam(typo)
local data=self.data
if data then
local guidList
if typo==1 then
return data.fightTeam1
else
return data.fightTeam2
end
end
return nil
end

function lingxuwenjianModel:getDefTeamFive(typo,idx)
local data=self.data
if data then
local guidList
if typo==1 then
guidList=data.fightTeam1
else
guidList=data.fightTeam2
end
if guidList then
local result={}
for i=(idx-1)*5+1,idx*5 do
table.insert(result,guidList[i])
end
return result
end
end
return nil
end





function lingxuwenjianModel:setRank(rank)
self.data.rank=rank
end

function lingxuwenjianModel:getRank()
if self.data then
return self.data.rank
end
return nil
end

function lingxuwenjianModel:refreshRankTopThree(list)
self.top3RankDatas=list or{}
end

function lingxuwenjianModel:getRankTopThree()
return self.top3RankDatas
end

function lingxuwenjianModel:checkRefreshRank1()
local needRefresh
if self.rankDatas1==nil or Time.realtimeSinceStartup-self.rankRefreshTimer>=rankRefreshTime then
self.rankRefreshTimer=Time.realtimeSinceStartup
lingxuwenjianController:reqRank1()
needRefresh=true
else
needRefresh=false
end
return needRefresh
end

function lingxuwenjianModel:getRanklist1()
return self.rankDatas1 or{}
end

function lingxuwenjianModel:setRanklist1(list)
self.rankDatas1=list or{}
end

function lingxuwenjianModel:checkRefreshRank2()
local needRefresh
if self.rankDatas2==nil then
lingxuwenjianController:reqRank2()
needRefresh=true
else
needRefresh=false
end
return needRefresh
end

function lingxuwenjianModel:getRanklist2()
return self.rankDatas2 or{}
end

function lingxuwenjianModel:setRanklist2(list)
self.rankDatas2=list or{}
end





function lingxuwenjianModel:setMemberList(list)
self.memberList=list
end

function lingxuwenjianModel:checkMemberList()
local needRefresh
if self.memberList==nil or Time.realtimeSinceStartup-self.memberListRefreshTimer>=memberListRefreshTime then
self.memberListRefreshTimer=Time.realtimeSinceStartup
needRefresh=true
else
needRefresh=false
end
return needRefresh
end

function lingxuwenjianModel:getMemberList1()
local list={}
if self.memberList~=nil then
for i,v in ipairs(self.memberList)do
if v.fightValNum>0 then
table.insert(list,v)
end
end
end
return list
end





function lingxuwenjianModel:getMaxBattleScore()
return cfgHelper.get3(cfg_lingxuwenjianconfig_get,1,'score',1)
end


function lingxuwenjianModel:checkBattleResult()
if lingxuwenjianModel:hasEnemy()then
local raceState=lingxuwenjianModel:getLunState()
if raceState==eLXWJ_State.eFight then
local max=lingxuwenjianModel:getMaxBattleScore()
local cur_my=lingxuwenjianModel:getMyRaceScore()
local cur_enemy=lingxuwenjianModel:getEnemyRaceScore()
local my_broke=lingxuwenjianModel:checkAllMyFaZhenBroke()
local enmey_broke=lingxuwenjianModel:checkAllEnemyFaZhenBroke()
if cur_my>=max or enmey_broke then
return 1
elseif cur_enemy>=max or my_broke then
return 2
end
elseif raceState==eLXWJ_State.eFinish then
local cur_my=lingxuwenjianModel:getMyRaceScore()
local cur_enemy=lingxuwenjianModel:getEnemyRaceScore()
if cur_my>cur_enemy then
return 1
elseif cur_my<cur_enemy then
return 2
else
return 3
end
end
end
return nil
end

function lingxuwenjianModel:getResultIcon(result,ismy)
local icon
if result==1 then

if ismy then
icon='image_xmzzhanjiui_4'
else
icon='image_xmzzhanjiui_5'
end
elseif result==2 then

if ismy then
icon='image_xmzzhanjiui_5'
else
icon='image_xmzzhanjiui_4'
end
else

icon='image_xmzzhanjiui_6'
end
return globalABLookup.lingxuwenjianicons,icon
end

function lingxuwenjianModel:getResultIcon2(result)
local icon
if result==1 then

icon='image_lingxuwenjianui_29'
elseif result==2 then

icon='image_lingxuwenjianui_30'
else

icon='image_lingxuwenjianui_31'
end
return globalABLookup.lingxuwenjianicons,icon
end

function lingxuwenjianModel:getResultIcon3(result,ismy)
local icon
if result==1 then

if ismy then
icon='image_zongmenduizhanui_3'
else
icon='image_zongmenduizhanui_5'
end
elseif result==2 then

if ismy then
icon='image_zongmenduizhanui_5'
else
icon='image_zongmenduizhanui_3'
end
else

icon='image_zongmenduizhanui_4'
end
return globalABLookup.lingxuwenjianicons,icon
end

function lingxuwenjianModel:getResultIcon4(result,ismy)
local icon
if result==1 then

if ismy then
icon='image_pqjsshengbai_1'
else
icon='image_pqjsshengbai_2'
end
elseif result==2 then

if ismy then
icon='image_pqjsshengbai_2'
else
icon='image_pqjsshengbai_1'
end
else

icon='image_pqjsshengbai_3'
end
return globalABLookup.global,icon
end

function lingxuwenjianModel:getResultIcon5(result,ismy)
local icon
if result==1 then

if ismy then
icon='image_shengli'
else
icon='image_shibai'
end
elseif result==2 then

if ismy then
icon='image_shibai'
else
icon='image_shengli'
end
else

icon='image_pingju'
end
return globalABLookup.lingxuwenjianicons,icon
end


function lingxuwenjianModel:isLeader()
local myActorid=playerModel:getActorID()
if xianmengModel.checkActorPost(myActorid,GUILD_POST_TYPE.gpAllyLeader)or
xianmengModel.checkActorPost(myActorid,GUILD_POST_TYPE.gpViceLeader)then
return true
end
return false
end

function lingxuwenjianModel:getFaZhenBloodRate(src,idx,curman,raceState)
local rate
if raceState==eLXWJ_State.eStandby then
if curman>0 then
rate=1
else
rate=0
end
else
if lingxuwenjianModel:hasEnemy()then
if src==0 then
rate=lingxuwenjianModel:getMyFaZhenBlood(idx)/10000
else
rate=lingxuwenjianModel:getEnemyFaZhenBlood(idx)/10000
end
else
if curman>0 then
rate=1
else
rate=0
end
end
end
return rate
end

function lingxuwenjianModel:getFaZhenSpine(src,idx)
local cfg=cfgHelper.get1(cfg_lingxuwenjianfazhenconfig_get,idx)
local id=src==0 and cfg.my_fz_spineID or cfg.enemy_fz_spineID
return id
end

function lingxuwenjianModel:checkFaZhenAnim(bloodRate,raceState)
if raceState==eLXWJ_State.eStandby then
return 1
else
if lingxuwenjianModel:hasEnemy()then
if bloodRate<=0 then
return 3
elseif bloodRate<=0.5 then
return 2
else
return 1
end
else
return 1
end
end
end

function lingxuwenjianModel:getFaZhenAnimChange(old,cur)
old=old or 0
local lp=fazhenAnimChanges[old]
return lp[cur]
end

function lingxuwenjianModel:getZhenYanSpine(src,idx)
local cfg=cfgHelper.get1(cfg_lingxuwenjianfazhenconfig_get,idx)
local id=src==0 and cfg.my_zy_spineID or cfg.enemy_zy_spineID
return id
end

function lingxuwenjianModel:checkZhenYanAnim(hasman,blood,raceState)
if raceState==eLXWJ_State.eStandby then
if hasman then
return 2
else
return 1
end
else
if lingxuwenjianModel:hasEnemy()then
if hasman then
if blood==nil then
return 2
elseif blood<=0 then
return 4
elseif blood<=5000 then
return 3
else
return 2
end
else
return 4
end
else
if hasman then
return 2
else
return 1
end
end
end
end

function lingxuwenjianModel:getZhenYanAnimChange(old,cur)
old=old or 0
local lp=zhenyanAnimChanges[old]
return lp[cur]
end

function lingxuwenjianModel:getZhenYanBrokeBlood()
return cfgHelper.get3(cfg_lingxuwenjianconfig_get,1,'match',5)
end


function lingxuwenjianModel:checkInDef()
local actorid=playerModel:getActorID()
local zyData=lingxuwenjianModel:getMyPosData2(actorid)
return zyData~=nil
end


















function lingxuwenjianModel:setMyRaceScore(score)
self.data.myRaceScore=score
end

function lingxuwenjianModel:getMyRaceScore()
if self.data then
return self.data.myRaceScore or 0
end
return nil
end

function lingxuwenjianModel:initPosData()
if self.data~=nil then
local data=self.data
data.myPosList={}
data.myPosLookup={}
data.myAllPosLookup={}
data.enemyPosList={}
data.enemyPosLookup={}
data.enemyAllPosLookup={}
data.wjtDatasList={}
data.wjtResultList={}
data.winSignLookup={}
end
end

function lingxuwenjianModel:handlePosData(d)
d.fightvalue_num=mathHelper.int64_to_number(d.fightvalue)
d.actorid_str=tostring(d.actorid)
end

function lingxuwenjianModel:setMyPosData(d)
if self.data~=nil and self.data.myPosLookup~=nil then
local data=self.data
local has=d.actorid~=nil
if has then
lingxuwenjianModel:handlePosData(d)

local f=nil
for i,v in ipairs(data.myPosList)do
if v.actorid_str==d.actorid_str then
f=i
break
end
end
if f~=nil then
local d__=table.remove(data.myPosList,f)
local fazhen_=data.myPosLookup[d__.lxwjtype]
if fazhen_ then
fazhen_[d__.lxwjkey]=nil
end
data.myAllPosLookup[d__.actorid_str]=nil
end

local ff=nil
for i,v in ipairs(data.myPosList)do
if d.lxwjtype==v.lxwjtype and d.lxwjkey==v.lxwjkey then
ff=i
break
end
end
if ff~=nil then
local d__=table.remove(data.myPosList,ff)
local fazhen_=data.myPosLookup[d__.lxwjtype]
if fazhen_ then
fazhen_[d__.lxwjkey]=nil
end
data.myAllPosLookup[d__.actorid_str]=nil
end

local fazhen=data.myPosLookup[d.lxwjtype]
if fazhen==nil then
fazhen={}
data.myPosLookup[d.lxwjtype]=fazhen
end
fazhen[d.lxwjkey]=d
table.insert(data.myPosList,d)
data.myAllPosLookup[d.actorid_str]=d
else

local fazhen=data.myPosLookup[d.lxwjtype]
local d_
if fazhen~=nil then
d_=fazhen[d.lxwjkey]
end
if d_~=nil then
local f=nil
local has=false
for i,v in ipairs(data.myPosList)do
if d_.lxwjtype==v.lxwjtype and d_.lxwjkey==v.lxwjkey then
f=i
else
if v.actorid_str==d_.actorid_str then
has=true
end
end
end
if f~=nil then
table.remove(data.myPosList,f)
end
fazhen[d_.lxwjkey]=nil
if not has then
data.myAllPosLookup[d_.actorid_str]=nil
end
end
end
end
end

function lingxuwenjianModel:setMyPosBlood(d)
if self.data~=nil then
local data=self.data
local d_
local lxwjtype=d.lxwjtype
local fazhen=data.myPosLookup[lxwjtype]
if fazhen~=nil then
d_=fazhen[d.lxwjkey]
if d_~=nil then
d_.blood=d.blood
end
end
end
end


function lingxuwenjianModel:getMyPosData(lxwjtype,lxwjkey)
if self.data~=nil then
local data=self.data
local fazhen=data.myPosLookup[lxwjtype]
if fazhen then
return fazhen[lxwjkey]
end
end
end

function lingxuwenjianModel:checkZhenYanReddot()
if lingxuwenjianModel:getMyPosData2(playerModel:getActorID())~=nil then
return false
end
if self.data~=nil and self.data.myPosLookup then
local data=self.data
for i=1,fazhenNum do
local fazhen=data.myPosLookup[i]or{}
for ii=1,zhenyanNum do
if fazhen[i]==nil then
return true
end
end
end
end
return false
end

function lingxuwenjianModel:checkInMyPos(actorid,lxwjtype)
local zyData=lingxuwenjianModel:getMyPosData2(actorid)
if zyData then
return zyData.lxwjtype==lxwjtype
end
return false
end

function lingxuwenjianModel:fingEmptyZhenYanID(lxwjtype)
if self.data~=nil then
local data=self.data
local fazhen=data.myPosLookup[lxwjtype]
if fazhen then
for i=1,zhenyanNum do
if fazhen[i]==nil then
return i
end
end
else
return 1
end
end
end

function lingxuwenjianModel:getMyPosData2(actorid)
if self.data~=nil then
local data=self.data
local actorid_str=tostring(actorid)
return data.myAllPosLookup and data.myAllPosLookup[actorid_str]or nil
end
end

function lingxuwenjianModel:checkBattleCond()
local cur=0
local max=lingxuwenjianModel:getMaxJoinBattleNum()
if self.data~=nil then
if self.data.myPosList then
cur=#self.data.myPosList
end
end
return cur>=max,cur,max
end

function lingxuwenjianModel:getMaxJoinBattleNum()
return cfgHelper.get3(cfg_lingxuwenjianconfig_get,1,'match',4)
end

function lingxuwenjianModel:getMyFaZhenManNum(index)
local num=0
if self.data~=nil then
local data=self.data
local fazhen=data.myPosLookup[index]
if fazhen then
for idx,v in pairs(fazhen)do
num=num+1
end
end
end
return num,zhenyanNum
end

function lingxuwenjianModel:getMyFaZhenBlood(index)
local rate=0
local lv=0
if self.data~=nil then
local data=self.data
local fazhen=data.myPosLookup[index]
if fazhen then
local num=0
local blood=0
for idx,v in pairs(fazhen)do
num=num+1
local b=v.blood or 0
blood=blood+b
if v.blood==nil or v.blood>0 then
lv=lv+1
end
end
if num>0 then
rate=blood/num
end
end
end
return rate,lv
end

function lingxuwenjianModel:checkAllMyFaZhenBroke()
local num=0
for i=1,3 do
local rate=lingxuwenjianModel:getMyFaZhenBlood(i)
if rate<=0 then
num=num+1
end
end
return num>=3
end

function lingxuwenjianModel:initWinSign(list)
if self.data~=nil then
if list then
local lp=self.data.winSignLookup
for i,v in ipairs(list)do
if lp[v.param_1]==nil then
lp[v.param_1]={}
end
lp[v.param_1][v.param_2]=true
end
end
end
end

function lingxuwenjianModel:getWinSign(lxwjtype,lxwjkey)
if self.data~=nil then
local lp=self.data.winSignLookup
if lp[lxwjtype]~=nil then
return lp[lxwjtype][lxwjkey]==true
end
end
return false
end

function lingxuwenjianModel:setWinSign(lxwjtype,lxwjkey)
if self.data~=nil then
local lp=self.data.winSignLookup
if lp[lxwjtype]==nil then
lp[lxwjtype]={}
end
lp[lxwjtype][lxwjkey]=true
end
end





function lingxuwenjianModel:setEnemyRaceScore(score)
self.data.enemyRaceScore=score
end

function lingxuwenjianModel:getEnemyRaceScore()
if self.data then
return self.data.enemyRaceScore or 0
end
return nil
end

function lingxuwenjianModel:setEnemyData(enemyData)
local change=false
if self.data~=nil then
if self.data.enemyData~=nil and enemyData~=nil then

if self.data.enemyData.enemyname~=enemyData.enemyname then
change=true
end
end
self.data.enemyData=enemyData
end
return change
end

function lingxuwenjianModel:getEnemyScore()
if self.data then
if self.data.enemyData~=nil then
return self.data.enemyData.enemyscore
end
end
return nil
end

function lingxuwenjianModel:hasEnemy()
if self.data~=nil then
return self.data.enemyData~=nil
end
return false
end

function lingxuwenjianModel:hasEnemyEx()
if self.data~=nil then
return self.data.battleidx>0
end
return false
end

function lingxuwenjianModel:getEnemyData()
if self.data~=nil then
return self.data.enemyData
end
end

function lingxuwenjianModel:setEnemyPosData(d)
if self.data~=nil then
local data=self.data
local has=d.actorid~=nil
if has then
lingxuwenjianModel:handlePosData(d)

local f=nil
for i,v in ipairs(data.enemyPosList)do
if v.actorid_str==d.actorid_str then
f=i
break
end
end
if f~=nil then
local d__=table.remove(data.enemyPosList,f)
local fazhen_=data.enemyPosLookup[d__.lxwjtype]
if fazhen_ then
fazhen_[d__.lxwjkey]=nil
end
data.enemyAllPosLookup[d__.actorid_str]=nil
end

local ff=nil
for i,v in ipairs(data.enemyPosList)do
if d.lxwjtype==v.lxwjtype and d.lxwjkey==v.lxwjkey then
ff=i
break
end
end
if ff~=nil then
local d__=table.remove(data.enemyPosList,ff)
local fazhen_=data.enemyPosLookup[d__.lxwjtype]
if fazhen_ then
fazhen_[d__.lxwjkey]=nil
end
data.enemyAllPosLookup[d__.actorid_str]=nil
end

local fazhen=data.enemyPosLookup[d.lxwjtype]
if fazhen==nil then
fazhen={}
data.enemyPosLookup[d.lxwjtype]=fazhen
end
fazhen[d.lxwjkey]=d
table.insert(data.enemyPosList,d)
data.enemyAllPosLookup[d.actorid_str]=d
else

local fazhen=data.enemyPosLookup[d.lxwjtype]
local d_
if fazhen~=nil then
d_=fazhen[d.lxwjkey]
end
if d_~=nil then
local f=nil
local has=false
for i,v in ipairs(data.enemyPosList)do
if d_.lxwjtype==v.lxwjtype and d_.lxwjkey==v.lxwjkey then
f=i
else
if v.actorid_str==d_.actorid_str then
has=true
end
end
end
if f~=nil then
table.remove(data.enemyPosList,f)
end
fazhen[d_.lxwjkey]=nil
if not has then
data.enemyAllPosLookup[d_.actorid_str]=nil
end
end
end
end
end

function lingxuwenjianModel:setEnemyPosBlood(d)
if self.data~=nil and self.data.enemyPosLookup~=nil then
local d_
local lxwjtype=d.lxwjtype
local fazhen=self.data.enemyPosLookup[lxwjtype]
if fazhen~=nil then
d_=fazhen[d.lxwjkey]
if d_~=nil then
d_.blood=d.blood
end
end
end
end


function lingxuwenjianModel:getEnemyPosData(lxwjtype,lxwjkey)
if self.data~=nil then
local data=self.data
local fazhen=data.enemyPosLookup[lxwjtype]
if fazhen then
return fazhen[lxwjkey]
end
end
end

function lingxuwenjianModel:checkInEnemyPos(actorid,lxwjtype)
local zyData=lingxuwenjianModel:getEnemyPosData2(actorid)
if zyData then
return zyData.lxwjtype==lxwjtype
end
return false
end

function lingxuwenjianModel:getEnemyPosData2(actorid)
if self.data~=nil then
local data=self.data
local actorid_str=tostring(actorid)
return data.enemyAllPosLookup[actorid_str]
end
end

function lingxuwenjianModel:getEnemyFaZhenManNum(index)
local num=0
if self.data~=nil then
local data=self.data
local fazhen=data.enemyPosLookup[index]
if fazhen then
for idx,v in pairs(fazhen)do
num=num+1
end
end
end
return num,zhenyanNum
end

function lingxuwenjianModel:getEnemyFaZhenBlood(index)
local rate=0
local lv=0
if self.data~=nil then
local data=self.data
local fazhen=data.enemyPosLookup[index]
if fazhen then
local num=0
local blood=0
for idx,v in pairs(fazhen)do
num=num+1
local b=v.blood or 0
blood=blood+b
if v.blood==nil or v.blood>0 then
lv=lv+1
end
end
if num>0 then
rate=blood/num
end
end
end
return rate,lv
end

function lingxuwenjianModel:checkAllEnemyFaZhenBroke()
local num=0
for i=1,3 do
local rate=lingxuwenjianModel:getEnemyFaZhenBlood(i)
if rate<=0 then
num=num+1
end
end
return num>=3
end

function lingxuwenjianModel:checkRefreshEnemyXMInfo()
local needRefresh
if self.enemyXMInfo==nil or Time.realtimeSinceStartup-self.enemyXMInfoRefreshTimer>=enemyXMInfoRefreshTime then
self.enemyXMInfoRefreshTimer=Time.realtimeSinceStartup
lingxuwenjianController:reqEnemyInfo()
needRefresh=true
else
needRefresh=false
end
return needRefresh
end

function lingxuwenjianModel:getEnemyXMInfo()
return self.enemyXMInfo
end

function lingxuwenjianModel:setEnemyXMInfo(info)
self.enemyXMInfo=info
end





function lingxuwenjianModel:setWJTData(d)
if self.data~=nil then
local wjtDatasList=self.data.wjtDatasList
local has=d.actorid~=nil
if has then
if wjtDatasList[d.src]==nil then
wjtDatasList[d.src]={}
else

for lxwjkey_,dd in pairs(wjtDatasList[d.src])do
if mathHelper.compareInt64(dd.actorid,d.actorid)then
wjtDatasList[d.src][lxwjkey_]=nil
break
end
end
end

lingxuwenjianModel:handlePosData(d)
wjtDatasList[d.src][d.lxwjkey]=d
else

if wjtDatasList[d.src]then
wjtDatasList[d.src][d.lxwjkey]=nil
end
end
end
end

function lingxuwenjianModel:getWJTData(scr,lxwjkey)
if self.data~=nil then
local wjtDatasList=self.data.wjtDatasList
if wjtDatasList[scr]then
return wjtDatasList[scr][lxwjkey]
end
end
end

function lingxuwenjianModel:getWJTData2(scr,actorid)
if self.data~=nil then
local wjtDatasList=self.data.wjtDatasList
if wjtDatasList[scr]then
for k,v in pairs(wjtDatasList[scr])do
if mathHelper.compareInt64(actorid,v.actorid)then
return v
end
end
end
end
end


function lingxuwenjianModel:getInWJTSide(actorid)
local zyData=lingxuwenjianModel:getWJTData2(0,actorid)
if zyData~=nil then
return 1
end
zyData=lingxuwenjianModel:getWJTData2(1,actorid)
if zyData~=nil then
return 2
end
return 0
end

function lingxuwenjianModel:setWJTResult(d)
if self.data~=nil then
local data=self.data
data.wjtResultList[d.lxwjkey]=d.result
end
end

function lingxuwenjianModel:getWJTResult(idx)
if self.data~=nil then
local data=self.data
return data.wjtResultList[idx]
end
return nil
end

function lingxuwenjianModel:hasWJResult()
if self.data~=nil then
local data=self.data
if data.wjtResultList then
if next(data.wjtResultList)~=nil then
return true
end
end
end
return false
end

function lingxuwenjianModel:canOpenWJT(isWarning)
local raceState=lingxuwenjianModel:getLunState()
if raceState==eLXWJ_State.eFinish then
if not lingxuwenjianModel:hasWJResult()then
local result=lingxuwenjianModel:checkBattleResult()
if result~=nil then
if isWarning then
UIManager.error('胜负已分，无需问剑')
end
return false
end
end
else
local result=lingxuwenjianModel:checkBattleResult()
if result~=nil then
if isWarning then
UIManager.error('胜负已分，无需问剑')
end
return false
end
end
return true
end

function lingxuwenjianModel:canOpenWJTNote()
local raceState=lingxuwenjianModel:getLunState()
if raceState==eLXWJ_State.eFight then
if lingxuwenjianModel:hasEnemy()then
local result=lingxuwenjianModel:checkBattleResult()
if result==nil then
local fightState=lingxuwenjianModel:getFightState()
if fightState>=eLXWJ_Fight_State.eWJIdle then
return true
end
end
end
elseif raceState==eLXWJ_State.eFinish then
if lingxuwenjianModel:hasEnemy()then
if lingxuwenjianModel:hasWJResult()then
return true
end
end
end
return false
end





function lingxuwenjianModel:checkRefreshScoreNotes()
local needRefresh
if self.scoreNotesList==nil or Time.realtimeSinceStartup-self.scoreNotesRefreshTimer>=scoreNotesRefreshTime then
self.scoreNotesRefreshTimer=Time.realtimeSinceStartup
needRefresh=true
else
needRefresh=false
end
return needRefresh
end

function lingxuwenjianModel:getScoreNotesList()
return self.scoreNotesList
end

function lingxuwenjianModel:setScoreNotesList(d)
self.scoreNotesList=d
end

function lingxuwenjianModel:handleScoreNotesList(list,checkMy)
if#list>0 then
local actorid=nil
if checkMy then
actorid=playerModel:getActorID()
end
local temp={}
for i,v in ipairs(list)do
local atkRate=0
local defRate=0
local defSuccessNum=0
local atkNum=0
local timesList=v.timesList
if timesList then
if timesList[1]~=nil and timesList[2]~=nil and timesList[2]>0 then
atkRate=mathHelper.decimal(timesList[1]/timesList[2],2)
end
atkNum=timesList[2]or 0
if timesList[3]~=nil and timesList[4]~=nil and timesList[4]>0 then
defRate=mathHelper.decimal(timesList[3]/timesList[4],2)
end
defSuccessNum=timesList[3]or 0
end
v.atkRate=atkRate
v.defRate=defRate
v.defSuccessNum=defSuccessNum
v.atkNum=atkNum
if actorid~=nil then
v.ismy=mathHelper.compareInt64(actorid,v.actorid)
end
table.insert(temp,v)
end
table.sort(temp,function(a,b)
return a.score>b.score
end)

local rank_=nil
local score_=nil
for i,v in ipairs(temp)do
v.scoreRank=i
if rank_==nil or score_~=v.score then
rank_=i
score_=v.score
end
v.scoreRank2=rank_
end
temp={}
for i,v in ipairs(list)do
table.insert(temp,v)
end
table.sort(temp,function(a,b)
return a.defSuccessNum>b.defSuccessNum
end)
for i,v in ipairs(temp)do
v.defRank=i
end
end
end





function lingxuwenjianModel:checkRefreshNotes()
local needRefresh
if self.notesList==nil or Time.realtimeSinceStartup-self.notesRefreshTimer>=notesRefreshTime then
self.notesRefreshTimer=Time.realtimeSinceStartup
lingxuwenjianController:reqNotes()
needRefresh=true
else
needRefresh=false
end
return needRefresh
end

function lingxuwenjianModel:getNotesList()
return self.notesList or{}
end

function lingxuwenjianModel:setNotesList(list)
self.notesList=list or{}
end

function lingxuwenjianModel:getNoteDesc(d)
local str
local ismy=xianmengModel:isMyXM(d.guildid)
local notesDesc=cfgHelper.get2(cfg_lingxuwenjianconfig_get,1,'notesDesc')
local fzname=cfgHelper.get2(cfg_lingxuwenjianfazhenconfig_get,d.lxwjtype,'name')
local myAdd,enemyAdd
if ismy then

if d.result==1 then
str=notesDesc[1]
elseif d.result==2 then
str=notesDesc[2]
else
str=notesDesc[3]
end
str=FMT.fmt(str,d.attackname,fzname,d.defendname,d.attackname)
myAdd=d.attackscore
enemyAdd=d.defendscore
else
if d.result==1 then
str=notesDesc[4]
elseif d.result==2 then
str=notesDesc[5]
else
str=notesDesc[6]
end
str=FMT.fmt(str,d.attackname,fzname,d.defendname,d.defendname)
myAdd=d.defendscore
enemyAdd=d.attackscore
end
local s
local ss
if myAdd~=0 then
local name='我方仙盟积分'
if myAdd>0 then
s=FMT.fmt('<color=#549327>{0}+{1}</color>',name,myAdd)
else
s=FMT.fmt('<color=#c82c2c>{0}-{0}</color>',name,myAdd)
end
end
if enemyAdd~=0 then
local name='敌方仙盟积分'
if enemyAdd>0 then
ss=FMT.fmt('<color=#549327>{0}+{1}</color>',name,enemyAdd)
else
ss=FMT.fmt('<color=#c82c2c>{0}-{0}</color>',name,enemyAdd)
end
end
local sss
if s~=nil then
sss=s
end
if ss~=nil then
if sss==nil then
sss=ss
else
sss=FMT.fmt('{0}，{1}',sss,ss)
end
end
if sss~=nil then
str=FMT.fmt('{0}{1}。',str,sss)
end
return str
end





function lingxuwenjianModel:checkReplayList(src,lxwjtype,lxwjkey)
local needRefresh=false
local lp=self.replayLookup
local timelp=self.replayRefreshTimer
if lp==nil or lp[src]==nil or lp[src][lxwjtype]==nil
or lp[src][lxwjtype][lxwjkey]==nil then
needRefresh=true
elseif timelp==nil or timelp[src]==nil or timelp[src][lxwjtype]==nil
or timelp[src][lxwjtype][lxwjkey]==nil
or Time.realtimeSinceStartup-timelp[src][lxwjtype][lxwjkey]>=replayRefreshTime then
needRefresh=true
end
if needRefresh then
if timelp==nil then
timelp={}
self.replayRefreshTimer=timelp
end
if timelp[src]==nil then
timelp[src]={}
end
if timelp[src][lxwjtype]==nil then
timelp[src][lxwjtype]={}
end
timelp[src][lxwjtype][lxwjkey]=Time.realtimeSinceStartup
lingxuwenjianController:reqFightReport(src,lxwjtype,lxwjkey)
end
return needRefresh
end

function lingxuwenjianModel:getReplayList(src,lxwjtype,lxwjkey)
local lp=self.replayLookup
if lp~=nil then
if lp[src]~=nil then
if lp[src][lxwjtype]~=nil then
return lp[src][lxwjtype][lxwjkey]
end
end
end
end

function lingxuwenjianModel:setReplayList(src,lxwjtype,lxwjkey,list)
local lp=self.replayLookup
if lp==nil then
lp={}
self.replayLookup=lp
end
if lp[src]==nil then
lp[src]={}
end
if lp[src][lxwjtype]==nil then
lp[src][lxwjtype]={}
end
lp[src][lxwjtype][lxwjkey]=list
end





function lingxuwenjianModel:checkRefreshLike()
local needRefresh=false
if self.data~=nil then
if self.data.likeTimes==nil or Time.realtimeSinceStartup-self.likeRefreshTimer>=likeRefreshTime then
self.likeRefreshTimer=Time.realtimeSinceStartup
lingxuwenjianController:reqLikeList()
needRefresh=true
end
end
return needRefresh
end

function lingxuwenjianModel:setLikeTimes(num)
if self.data~=nil then
local data=self.data
data.likeTimes=num
end
end

function lingxuwenjianModel:refreshLikeTimes()
if self.data~=nil then
local data=self.data
if data.likeTimes~=nil then
data.likeTimes=data.likeTimes+1
end
end
end

function lingxuwenjianModel:getLikeTimes()
if self.data~=nil then
local data=self.data
return data.likeTimes
end
end

function lingxuwenjianModel:getMamLikeTimes()
return cfgHelper.get3(cfg_lingxuwenjianconfig_get,1,'match',11)
end

function lingxuwenjianModel:checkLikeRedot()
if lingxuwenjianModel:checkInit()then
local cur=lingxuwenjianModel:getLikeTimes()
local max=lingxuwenjianModel:getMamLikeTimes()
local lerp=max-cur
return lerp>0
end
return false
end

function lingxuwenjianModel:checkDayRedot()
local raceState=lingxuwenjianModel:getLunState()
local hasEnemy=lingxuwenjianModel:hasEnemyEx()
local max=lingxuwenjianModel:getMaxAttackTimes()
local cur=lingxuwenjianModel:getAttackTimes()or max
local lerp=max-cur
return hasEnemy and raceState==eLXWJ_State.eFight and lerp>0
end

function lingxuwenjianModel:initLikeTopThree(list)
if self.data~=nil then
local data=self.data
data.likeTopThree=list or{}
self.likeRefreshTimer=Time.realtimeSinceStartup
end
end

function lingxuwenjianModel:setLikeTopThree(list)
if self.data~=nil then
local data=self.data
if data.likeTopThree~=nil then
for i,v in ipairs(list)do
local d=data.likeTopThree[i]
if d~=nil then
d.likestimes=v
end
end
end
end
end

function lingxuwenjianModel:setLikeTopOne(rank)
if self.data~=nil then
local data=self.data
local d=data.likeTopThree[rank]
if d~=nil then
d.likestimes=d.likestimes+1
end
end
end

function lingxuwenjianModel:getLikeTopThree()
if self.data~=nil then
local data=self.data
return data.likeTopThree or{}
end
end



function lingxuwenjianModel:markFisrtEnter(raceIndex)
userActorArraySetting.set(ACTOR_SETTING_TYPE.eLingXuWenJian,'firstEnter',raceIndex)
userActorArraySetting.flush(ACTOR_SETTING_TYPE.eLingXuWenJian)
end

function lingxuwenjianModel:checkFisrtEnter(raceIndex)
local idx=userActorArraySetting.get(ACTOR_SETTING_TYPE.eLingXuWenJian,'firstEnter',nil)
return raceIndex~=idx
end

function lingxuwenjianModel:markFisrtBegin(raceIndex,lunIndex)
userActorArraySetting.set(ACTOR_SETTING_TYPE.eLingXuWenJian,'firstBegin',{raceIndex,lunIndex})
userActorArraySetting.flush(ACTOR_SETTING_TYPE.eLingXuWenJian)
end

function lingxuwenjianModel:checkFisrtBegin(raceIndex,lunIndex)
local d=userActorArraySetting.get(ACTOR_SETTING_TYPE.eLingXuWenJian,'firstBegin',nil)
if d then
return raceIndex~=d[1]or lunIndex~=d[2]
end
return true
end

function lingxuwenjianModel:markFisrtOver(raceIndex,lunIndex)
userActorArraySetting.set(ACTOR_SETTING_TYPE.eLingXuWenJian,'firstOver',{raceIndex,lunIndex})
userActorArraySetting.flush(ACTOR_SETTING_TYPE.eLingXuWenJian)
end

function lingxuwenjianModel:checkFisrtOver(raceIndex,lunIndex)
local d=userActorArraySetting.get(ACTOR_SETTING_TYPE.eLingXuWenJian,'firstOver',nil)
if d then
return raceIndex~=d[1]or lunIndex~=d[2]
end
return true
end




function lingxuwenjianModel:clearMark(key)
userActorArraySetting.set(ACTOR_SETTING_TYPE.eLingXuWenJian,key,nil)
userActorArraySetting.flush(ACTOR_SETTING_TYPE.eLingXuWenJian)
end

function lingxuwenjianModel:getMessageStr()
local state
local raceState=lingxuwenjianModel:getLunState()
if raceState==eLXWJ_State.eStandby then
state=1
elseif raceState==eLXWJ_State.eFight then
if lingxuwenjianModel:checkBattleResult()~=nil then
state=4
else
local fightState=lingxuwenjianModel:getFightState()
if fightState==eLXWJ_Fight_State.eFight then
state=2
else
state=3
end
end
elseif raceState==eLXWJ_State.eFinish then
state=4
end
if state~=nil then
local d=self.LEDData
if d==nil or d[1]~=state then
d={state,1}
self.LEDData=d
else
d[2]=d[2]+1
end
local idx=d[2]
local desclist=cfgHelper.get3(cfg_lingxuwenjianconfig_get,1,'tipsLED',state)
if idx>#desclist then
idx=1
d[2]=1
end
return desclist[idx]
end
end

function lingxuwenjianModel:testChangeAnimationData()




local Changedata=userActorArraySetting.get(ACTOR_SETTING_TYPE.eLingXuWenJian,'zhenyanWin_Changedata',nil)

local BattleChangedata=userActorArraySetting.get(ACTOR_SETTING_TYPE.eLingXuWenJian,'BattleWin_Changedata',nil)

end


function lingxuwenjianModel:getChangeAnimationData(_idx,pos2,pos1)
local Changedata=userActorArraySetting.get(ACTOR_SETTING_TYPE.eLingXuWenJian,'zhenyanWin_Changedata',nil)
if Changedata then
return Changedata[pos1*3+pos2][_idx]
end
return 0
end
function lingxuwenjianModel:setChangeAnimationData(_idx,animState,pos2,pos1)
local Changedata=userActorArraySetting.get(ACTOR_SETTING_TYPE.eLingXuWenJian,'zhenyanWin_Changedata',nil)
if Changedata then
Changedata[pos1*3+pos2][_idx]=animState
userActorArraySetting.set(ACTOR_SETTING_TYPE.eLingXuWenJian,'zhenyanWin_Changedata',Changedata)
userActorArraySetting.flush(ACTOR_SETTING_TYPE.eLingXuWenJian)
end
end



function lingxuwenjianModel:getZhenFaChangeAnimationData(_idx,index)
local BattleChangedata=userActorArraySetting.get(ACTOR_SETTING_TYPE.eLingXuWenJian,'BattleWin_Changedata',nil)
if BattleChangedata then
return BattleChangedata[index*3+_idx]
end
end

function lingxuwenjianModel:setZhenFaChangeAnimationData(_idx,animState,index)
local BattleChangedata=userActorArraySetting.get(ACTOR_SETTING_TYPE.eLingXuWenJian,'BattleWin_Changedata',nil)
if BattleChangedata then
BattleChangedata[index*3+_idx]=animState
userActorArraySetting.set(ACTOR_SETTING_TYPE.eLingXuWenJian,'BattleWin_Changedata',BattleChangedata)
userActorArraySetting.flush(ACTOR_SETTING_TYPE.eLingXuWenJian)
end
end
