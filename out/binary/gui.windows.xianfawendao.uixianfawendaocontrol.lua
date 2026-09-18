
local _LuaHelper=CS.LuaHelper


UIXianFaWenDaoControl=gameState.addListener(fullScreenUI.create())
XFWD_DATA_TYPE=
{
eMatching=1,
eRecord=2,
}

eXFWDLevel2RankType={
eRankListType.eXianFaWenDao5,
eRankListType.eXianFaWenDao4,
eRankListType.eXianFaWenDao3,
eRankListType.eXianFaWenDao2,
eRankListType.eXianFaWenDao1,
}

function UIXianFaWenDaoControl:onAppStart()
socketManager:register_receiver(17,51,self.recv_17_51)
socketManager:register_receiver(17,52,self.recv_17_52)
socketManager:register_receiver(17,53,self.recv_17_53)
socketManager:register_receiver(17,54,self.recv_17_54)
socketManager:register_receiver(17,55,self.recv_17_55)
socketManager:register_receiver(17,56,self.recv_17_56)
socketManager:register_receiver(17,57,self.recv_17_57)
socketManager:register_receiver(17,58,self.recv_17_58)
socketManager:register_receiver(17,59,self.recv_17_59)
socketManager:register_receiver(17,60,self.recv_17_60)
socketManager:register_receiver(17,61,self.recv_17_61)
socketManager:register_receiver(17,62,self.recv_17_62)

local mount=cfgHelper.get2(cfg_xianfawendaoconfig_get,1,'mount')
self.mountList=mount

local args=
{
fullType=FULL_TYPE.eXianFaWenDao,
skinType=fullScreenSkinType.eSkin16,
}
self:initUI(args)
end

function UIXianFaWenDaoControl:onEnterState(isReconnect)
if isReconnect then
self.data.matchingDatas={}
return
end

self.data={}
self.data.rankDatas={}
self.data.myRanks={}
self.data.lastMatchTime=0
self.tempNameData={}
self.lastReqDataTime=0
self.actorMount={}

notifySystem:listenNotify(notifyConfig.home_event,self.on_home_event)
notifySystem:listenNotify(notifyConfig.onNewDay,self.on_new_day)
notifySystem:listenNotify(notifyConfig.on_system_open,self.onSystemOpen)
end

function UIXianFaWenDaoControl:onLeaveState(isReconnect)
if isReconnect then
return
end

self.data=nil
self.nameRecordData=nil
self.tempNameData=nil
self.actorMount=nil
self.bdData=nil

notifySystem:removelistener(notifyConfig.home_event,self.on_home_event)
notifySystem:removelistener(notifyConfig.onNewDay,self.on_new_day)
notifySystem:removelistener(notifyConfig.on_system_open,self.onSystemOpen)
end

function UIXianFaWenDaoControl:onReConnection(isReconnect)
if not isReconnect then
return
end
end

function UIXianFaWenDaoControl.on_home_event(etype)
if etype==homeEvent.eEnterHome then
UIXianFaWenDaoControl:onEnterHome()
elseif etype==homeEvent.eLeaveHome then
UIXianFaWenDaoControl:onLeaveHome()
end
end

function UIXianFaWenDaoControl:onEnterHome()

end

function UIXianFaWenDaoControl:onLeaveHome()
self.bdData=nil
end

function UIXianFaWenDaoControl.on_new_day(is_login)

UIXianFaWenDaoControl:setFirstOpenTime()
UIXianFaWenDaoControl:resetDataCount()
UIXianFaWenDaoControl:checkAndShowEnterIcon()
UIXianFaWenDaoControl:checkAndShowActIcon()
UIFullTotalTouZiActivityontrol:onChanged(TZ_CATCH_TYPE.eXFWD)
WDCQController.onInvitWDCQ()
end

function UIXianFaWenDaoControl.onSystemOpen(sysid)
if sysid==SYSTEM_DEFINE.eXianFaWenDao then
UIXianFaWenDaoControl:reqDatas()
UIXianFaWenDaoControl:checkAndShowActIcon()
end
end

function UIXianFaWenDaoControl:checkAndShowActIcon()
UIManager:callWindowFunc('UILimitActStorageWin','refreshCondShow',LIMIT_ACT_TYPE.eXianFaWenDao)
end

function UIXianFaWenDaoControl:showXianFaWenDaoWin(argstable)
if not self:checkUnlockEx(true)then
return false
end

local tabType=FULL_TAB_TYPE.eXianFaWenDao

local args=
{
tabType=tabType,
showBg=true,
showTopMask=true,
viewNames={'UIXianFaWenDaoWin'},
viewArgs={['UIXianFaWenDaoWin']=argstable},
}
self:showUI(args)

return true
end

function UIXianFaWenDaoControl:showXianFaWenDaoChallengeWin(argstable)
if not self:checkUnlockEx(true)then
return false
end

local tabType=FULL_TAB_TYPE.eXianFaWenDao_Challenge

local args=
{
tabType=tabType,
showBg=true,
showTopMask=true,
viewNames={'UIXFWDChallengeWin'},
viewArgs={['UIXFWDChallengeWin']=argstable},
}
self:showUI(args)

return true
end

function UIXianFaWenDaoControl:showXianFaWenDaoAdjustWin(argstable)
if not self:checkUnlockEx(true)then
return false
end

local tabType=FULL_TAB_TYPE.eXianFaWenDao_Adjust

local args=
{
tabType=tabType,
showBg=true,
showTopMask=true,
viewNames={'UIXFWDAdjustWin'},
viewArgs={['UIXFWDAdjustWin']=argstable},
}
self:showUI(args)

return true
end

function UIXianFaWenDaoControl:checkAndShowEnterIcon()
if self:checkUnlock()and self:isInTruceTime()and self:isHasTopThree()then
self.enterGuid=enterManager:freshEnter({id=1,enterIconType=ENTER_ICON_TYPE.eNomal,enterType=ENTER_TYPE.eXianFaBang,getReddotFun=function()
return false
end})
end
end

function UIXianFaWenDaoControl:removeEnterIcon()
enterManager:removeEnter(self.enterGuid)
self.enterGuid=nil
end

function UIXianFaWenDaoControl:getBuildingData()
if not self.bdData then
self.bdData=zongmenModel:findBuildingDataByID(mapIdType.zhufeng,SLG_SYSTEM_TYPE.eDouFaTai)
end
return self.bdData
end



function UIXianFaWenDaoControl:setMatchTime(time)
self.data.lastMatchTime=time
end

function UIXianFaWenDaoControl:getMatchTime()
return self.data.lastMatchTime
end

function UIXianFaWenDaoControl:checkUnlock(noBDCheck)
if not self.data.firstopentime then
return false,0,''
end

if not noBDCheck then
local bdData=self:getBuildingData()
if not bdData or(bdData.level==1 and bdData.flag~=0)then
return false,0,'请先修复斗法台'
end
end

local currtime=gameUtilityModel.getServerShortTime()

local needDay=cfgHelper.get2(cfg_xianfawendaoconfig_get,1,'open')
local stamp=timeHelper.getOpenServerShortTime()
local dtime=math.floor(stamp/86400)*86400+86400*(needDay-1)-currtime
if dtime>0 then
return false,1,'{0}后可参与',dtime
end

local needLevel=cfgHelper.get2(cfg_xianfawendaolevelconfig_get,1,'min')
needLevel=UIXianFaWenDaoControl:getPlatFormIdCfg(needLevel)
local level=zongmenModel:getLevel()
if level<needLevel then
return false,2,FMT.fmt('达到{0}级可参与',needLevel)
end

if not systemModel.isOpen(SYSTEM_DEFINE.eXianFaWenDao)then
return false,0,'系统未开启'
end

return true
end

function UIXianFaWenDaoControl:checkUnlockEx(warning)
local check,ctype,txt,cd=self:checkUnlock()
if not check and warning then
if ctype==1 then
UIManager.error(FMT.fmt(txt,timeHelper.formatSimpleTime(cd,true)))
else
UIManager.error(txt)
end
end
return check
end

function UIXianFaWenDaoControl:isInTruceTime()
local currtime=gameUtilityModel.getServerShortTime()
return currtime>self.data.endTime and currtime<=self.data.truceEndTime
end

function UIXianFaWenDaoControl:isHasTopThree()
local topThree=UIXianFaWenDaoControl:getTopThree()
local flag=false
if topThree then
for i,v in pairs(topThree)do
if v~=nil then
flag=true
break
end
end
end
return flag
end

function UIXianFaWenDaoControl:isFirstOpenWinInSession()
local flag=userActorArraySetting.get(ACTOR_SETTING_TYPE.eXianFaWenDao,'FIRST_OPEN_FLAG',0)
if flag~=self.data.session then
userActorArraySetting.set(ACTOR_SETTING_TYPE.eXianFaWenDao,'FIRST_OPEN_FLAG',self.data.session)
self:saveRecordData()
return true
end
return false
end

function UIXianFaWenDaoControl:saveFightTeam(team)
self:saveData('FIGHT_TEAM_DATA',team)
end

function UIXianFaWenDaoControl:getFightTeam()
local team=userActorArraySetting.get(ACTOR_SETTING_TYPE.eXianFaWenDao,'FIGHT_TEAM_DATA',nil)
return team
end

function UIXianFaWenDaoControl:setFirstOpenTime()
UIXianFaWenDaoControl:setSessionOpenTime()
local firstopentime=timeHelper.getOpenServerShortTime_kf()
self.data.firstopentime=firstopentime
local session=timeHelper.getPassMonths(firstopentime,self.data.beginTime)
self.data.session=session

local flag=userActorArraySetting.get(ACTOR_SETTING_TYPE.eXianFaWenDao,'NAME_RECORD_FLAG',0)
if flag~=self.data.session then
self.nameRecordData={}
userActorArraySetting.set(ACTOR_SETTING_TYPE.eXianFaWenDao,'NAME_RECORD_FLAG',self.data.session)
self:saveRecordData()
else
self.nameRecordData=userActorArraySetting.get(ACTOR_SETTING_TYPE.eXianFaWenDao,'NAME_RECORD_DATA',{})
end
end

function UIXianFaWenDaoControl:setSessionOpenTime()
local day_time=86400
local currtime=gameUtilityModel.getServerShortTime()

local y,m,d=timeHelper.getServerData()
local day,stamp=timeHelper.getDayByTimeformat(y,m,1,1)
if day==0 then
day,stamp=timeHelper.getDayByTimeformat(y,m,2,1)
end
local longTime=timeHelper.timeServer(y,m,day,0,0,0)
local this_begin_time=timeHelper.convertShortStamp(longTime)


if currtime<this_begin_time then
m=m-1
if m<1 then
m=12
y=y-1
end
day,stamp=timeHelper.getDayByTimeformat(y,m,1,1)
if day==0 then
day,stamp=timeHelper.getDayByTimeformat(y,m,2,1)
end
longTime=timeHelper.timeServer(y,m,day,0,0,0)
this_begin_time=timeHelper.convertShortStamp(longTime)
end



local next_m=m+1
local next_y=y
if next_m>12 then
next_m=1
next_y=y+1
end
local nextDay,nextStamp=timeHelper.getDayByTimeformat(next_y,next_m,1,1)
if nextDay==0 then
nextDay,nextStamp=timeHelper.getDayByTimeformat(next_y,next_m,2,1)
end
local nextLongTime=timeHelper.timeServer(next_y,next_m,nextDay,0,0,0)
local next_begin_time=timeHelper.convertShortStamp(nextLongTime)


local old_m=m-1
local old_y=y
if old_m<1 then
old_m=12
old_y=y-1
end
local old_day,old_stamp=timeHelper.getDayByTimeformat(old_y,old_m,1,1)
if old_day==0 then
old_day,old_stamp=timeHelper.getDayByTimeformat(old_y,old_m,2,1)
end
local old_longTime=timeHelper.timeServer(old_y,old_m,old_day,0,0,0)
local old_begin_time=timeHelper.convertShortStamp(old_longTime)

self.data.beginTime=this_begin_time
self.data.truceEndTime=next_begin_time
self.data.endTime=this_begin_time+21*day_time
self.data.nextEndTime=next_begin_time+21*day_time
self.data.oldEndTime=old_begin_time+21*day_time
end

function UIXianFaWenDaoControl:saveRecordData()
self:saveData('NAME_RECORD_DATA',self.nameRecordData)
end

function UIXianFaWenDaoControl:saveData(key,value)
userActorArraySetting.set(ACTOR_SETTING_TYPE.eXianFaWenDao,key,value)
userActorArraySetting.flush(ACTOR_SETTING_TYPE.eXianFaWenDao)
end

function UIXianFaWenDaoControl:setRecordName(id,name)
self.nameRecordData[tostring(id)]=name
end

function UIXianFaWenDaoControl:getRecordName(id)
return self.nameRecordData[tostring(id)]
end

function UIXianFaWenDaoControl:setBaseData(datasec,challengetimes,likestimes,moneynum)
self:setFirstOpenTime()
self.data.datasec=datasec
local currtime=gameUtilityModel.getServerShortTime()
if math.floor(datasec/86400)~=math.floor(currtime/86400)then
challengetimes=0
likestimes=0
moneynum=0
end
self.data.challengetimes=challengetimes
self.data.likestimes=likestimes
self.data.moneyNum=moneynum

self.data.isInit=true

UIXianFaWenDaoControl:checkAndShowEnterIcon()
UIFullTotalTouZiActivityontrol:onChanged(TZ_CATCH_TYPE.eXFWD)
end

function UIXianFaWenDaoControl:resetDataCount()
self.data.challengetimes=0
self.data.likestimes=0
self.data.moneyNum=0

notifySystem:postNotify(notifyConfig.onXianFaLunDaoDianZan)
UIXianFaWenDaoControl:refreshDouFaTaiHUD()
end

function UIXianFaWenDaoControl:addMoneyNum(num)
self.data.moneyNum=self.data.moneyNum+num
end

function UIXianFaWenDaoControl:isMoneyNumFull()
local max=cfgHelper.get2(cfg_xianfawendaoconfig_get,1,'money')
return self.data.moneyNum>=max
end

function UIXianFaWenDaoControl:addTimes()
local isTruce=UIXianFaWenDaoControl:isInTruceTime()
self.data.challengetimes=self.data.challengetimes+1
if not isTruce then
self.data.totalTimes=self.data.totalTimes+1
end

reddotControl.on_change_catch_type(CATCH_TYPE.eLimitActChange,LIMIT_ACT_TYPE.eXianMengDiGong)
UIXianFaWenDaoControl:refreshDouFaTaiHUD()
reddotControl.on_change_catch_type(CATCH_TYPE.eLunDaoRewards)
UIFullTotalTouZiActivityontrol:onChanged(TZ_CATCH_TYPE.eXFWD)
end

function UIXianFaWenDaoControl:getChallengeTimes()
return self.data.challengetimes
end

function UIXianFaWenDaoControl:getLikestimes()
return self.data.likestimes
end

function UIXianFaWenDaoControl:addLikestimes()
self.data.likestimes=self.data.likestimes+1
end

function UIXianFaWenDaoControl:getLastLikestimes()
local times=self:getLikestimes()
local cfg=cfgHelper.get1(cfg_xianfawendaoconfig_get,1)
return cfg.likes-times
end

function UIXianFaWenDaoControl:getAllChallengeTimes()
local times=UIXianFaWenDaoControl:getChallengeTimes()
local cfg=cfgHelper.get1(cfg_xianfawendaoconfig_get,1)
if times<cfg.free then
local ft=cfg.free-times
local pt=#cfg.consume
return times,ft,pt
else
local ptimes=times-cfg.free
local count=#cfg.consume
local pt=count-ptimes
return times,0,pt
end
end

function UIXianFaWenDaoControl:setDatas(datas)
self.data.level=datas[1]
self.data.team=datas[3]or{}
self.data.investFlag=datas[4]or 0
self.data.score=datas[5]or 0
self.data.flag=datas[6]or 0
self.data.rank=datas[7]or 0
local topThree={}
if datas[9]then
for i,v in ipairs(datas[9])do
if v.actorname then
v.actorname=playerModel:getOtherActorName(v.actorname)
end
topThree[v.rank]=v
end
end
self.data.topThree=topThree

self.data.totalTimes=datas[10]or 0

self.data.previousTopData={}

self:setRegister(self.data.level>0)

self.data.orderLevel=self:countOrderLevel()

self:setTeamDict()
reddotControl.on_change_catch_type(CATCH_TYPE.eLunDaoRewards)
UIFullTotalTouZiActivityontrol:onChanged(TZ_CATCH_TYPE.eXFWD)
end

function UIXianFaWenDaoControl:getTopThree()
return self.data.topThree
end

function UIXianFaWenDaoControl:setRankDatas(level,datas)
local rdatas={}
local myRank=0
for i,v in ipairs(datas)do
if v.actorname then
v.actorname=playerModel:getOtherActorName(v.actorname)
end
rdatas[v.rank]=v
if playerModel:checkActorId(v.actorid)then
myRank=v.rank
end
end
for i=1,3 do
if not rdatas[i]then
rdatas[i]={}
end
end
self.data.rankDatas[level]=rdatas
self.data.myRanks[level]=myRank
end

function UIXianFaWenDaoControl:setRankNumData(datas)
local rankNumDatas={}
if datas then
for i,v in ipairs(datas)do
rankNumDatas[v.param_1]=v.param_2
end
end
self.data.rankNumDatas=rankNumDatas
end

function UIXianFaWenDaoControl:getRankNumData(level)
if not self.data or not self.data.rankNumDatas then return 0 end
return self.data.rankNumDatas[level]or 0
end

function UIXianFaWenDaoControl:getRankDataByLevel(level)
return self.data.rankDatas[level]or{}
end

function UIXianFaWenDaoControl:getMyRankByLevel(level)
return self.data.myRanks[level]or 0
end

function UIXianFaWenDaoControl:setRecordData(datas)
for i,v in ipairs(datas)do
v.index=v.recordid
local robotID,robbotType=UIXianFaWenDaoControl:getRobbotInfo(v.actorid)
v.isRobbit=robbotType==1
if v.actorname then
v.actorname=playerModel:getOtherActorName(v.actorname)
end
end
self.data.recordDatas=datas
end

function UIXianFaWenDaoControl:getRecordData()
return self.data.recordDatas or{}
end

function UIXianFaWenDaoControl:isInRegisterTime()
local cfg=cfgHelper.get1(cfg_xianfawendaoconfig_get,1)
local currtime=gameUtilityModel.getServerShortTime()
local regEndTime=self.data.beginTime+cfg.signup*86400
return currtime<regEndTime
end

function UIXianFaWenDaoControl:setMatchingData(datas)
for i,v in ipairs(datas)do
v.index=i
local robotID,robbotType=UIXianFaWenDaoControl:getRobbotInfo(v.actorid)
v.isRobbit=robbotType==1
end
table.sort(datas,function(a,b)
return a.score>b.score
end)
self.data.matchingDatas=datas
end

function UIXianFaWenDaoControl:getMatchingData()
return self.data.matchingDatas or{}
end

function UIXianFaWenDaoControl:getMatchingTargetFightValue(index,myFVal)
local data=self.data.matchingDatas[index]
if data then
if not data.fvalue then
if data.isRobbit then
myFVal=myFVal or UIXianFaWenDaoControl:getTeamTotalFightValue()
data.fvalue=mathHelper.getRandomNum_precent(myFVal,-0.1,0)
else
data.fvalue=tonumber(tostring(data.fightvalue))
end
end
return data.fvalue
end
return 0
end

function UIXianFaWenDaoControl:getMatchingTargetTeamFValue(index)
local data=self.data.matchingDatas[index]
if data then
if data.teamFValue then
return data.teamFValue
end
if not data.fvalue then
self:getMatchingTargetFightValue(index)
end
local teamFValue={}
local fval=data.fvalue
local tval=fval/3
local cval=tval*0.1
local dval=math.random(-cval,cval)
teamFValue[1]=tval+dval
teamFValue[2]=tval-dval
dval=math.random(-cval,cval)
teamFValue[2]=teamFValue[2]+dval
teamFValue[3]=tval-dval
dval=math.random(-cval,cval)
teamFValue[3]=teamFValue[3]+dval
teamFValue[1]=teamFValue[1]-dval
data.teamFValue=teamFValue
for i,v in ipairs(teamFValue)do
teamFValue[i]=math.floor(v)
end
return teamFValue
end
end

function UIXianFaWenDaoControl:getRecordTargetTeamFValue(index)
if not index then return{}end
local datas=self:getRecordData()
local data=datas[index]
if not data then return{}end
if data.teamFValue then
return data.teamFValue
end
if not data.fvalue then
data.fvalue=mathHelper.getRandomNum_precent(UIXianFaWenDaoControl:getTeamTotalFightValue(),-0.1,0)
end
local teamFValue={}
local fval=data.fvalue
local tval=fval/3
local cval=tval*0.1
local dval=math.random(-cval,cval)
teamFValue[1]=tval+dval
teamFValue[2]=tval-dval
dval=math.random(-cval,cval)
teamFValue[2]=teamFValue[2]+dval
teamFValue[3]=tval-dval
dval=math.random(-cval,cval)
teamFValue[3]=teamFValue[3]+dval
teamFValue[1]=teamFValue[1]-dval
data.teamFValue=teamFValue
for i,v in ipairs(teamFValue)do
teamFValue[i]=math.floor(v)
end
return teamFValue
end

function UIXianFaWenDaoControl:randomAMout()
return self.mountList[math.random(1,#self.mountList)]
end

function UIXianFaWenDaoControl:getMatchingTargetMount(index)
local data=self.data.matchingDatas[index]
if data then
if not data.mount then
data.mount=self:randomAMout()
end
return data.mount
end
end

function UIXianFaWenDaoControl:getActorMount(actorId)
local str=tostring(actorId)
local mount=self.actorMount[str]
if not mount then
mount=self:randomAMout()
self.actorMount[str]=mount
end
return mount
end

function UIXianFaWenDaoControl:getTeamTotalFightValue()
local teams=self:getTeam()
local fv=0
for i,v in ipairs(teams)do
if tostring(v)~='0'then
fv=fv+UIDiscipleModel:getDiscipleFightValue(v)
end
end
return fv
end

function UIXianFaWenDaoControl:getFazeList(session)
local cfg=cfgHelper.get1(cfg_xianfawendaoconfig_get,1)
session=session or UIXianFaWenDaoControl:getSession()
local faze=cfg.faze
local len=#faze
local index=(session-1)%len+1
local fzList=faze[index]
return fzList
end

function UIXianFaWenDaoControl:getRobbotInfo(actorid)
actorid=-actorid
local robbotID=_LuaHelper.SplitInt32(actorid,"0xFFFFFFF",0)
local robbotType=_LuaHelper.SplitInt32(actorid,"0xFFFFFFFF",32)
return robbotID,robbotType
end

function UIXianFaWenDaoControl:getRobbitName(actorid,robotId,isActor)
local name=self:getRecordName(actorid)
if not name then
local idstr=tostring(actorid)
name=self.tempNameData[idstr]
if not name then
local nameId
if isActor then
nameId=robotId
else
if not robotId then
local robotID,robbotType=UIXianFaWenDaoControl:getRobbotInfo(actorid)
if robbotType==2 then
logErr('正常弟子请使用服务器数据')
return
end
robotId=robotID
end
local cfg=cfgHelper.get1(cfg_robotmonsterconfig_get,robotId)
nameId=cfg.name
end
local ncfg=cfgHelper.get1(cfg_robotmonsternameconfig_get,nameId)
name=ncfg.name_list[math.random(1,#ncfg.name_list)]
self.tempNameData[idstr]=name
end
end
return name
end














function UIXianFaWenDaoControl:getFightResultData(data)
local isTruce=UIXianFaWenDaoControl:isInTruceTime()
local level=self:getLevel()
local rwdata=cfgHelper.get2(cfg_xianfawendaoconfig_get,1,'challengereward')
local rewards=isTruce and(rwdata[level][data.result][7]or{})or rwdata[level][data.result][6]
local rwList={}
if data.moneynum>0 then
local rate=gubaoModel:getGBSkil_MoneyUpRate(0,eMoneyType.mtZhanYuDian)
local zyd=math.floor(data.moneynum*(1+rate*0.01))
table.insert(rwList,{eMoneyType.mtZhanYuDian,zyd})
end
for i,v in ipairs(rewards)do
table.insert(rwList,{v[1],v[2]})
end

local currRank=self:getRank()
local dis=data.rank-currRank
local rankInfo={rank=FMT.fmt('<color=#7D3B17>排名：{0}</color>',data.rank)}
if dis<0 then
local rankIcon={}
rankIcon.abName=globalABLookup.global
rankIcon.assetName='icon_jiantou_1'
rankInfo.rankIcon=rankIcon
rankInfo.rankNum=FMT.fmt('<color=green>{0}</color>',-dis)
elseif dis>0 then
local rankIcon={}
rankIcon.abName=globalABLookup.global
rankIcon.assetName='icon_jiantou_2'
rankInfo.rankIcon=data.result~=1 and rankIcon or nil
rankInfo.rankNum=data.result~=1 and FMT.fmt('<color=red>{0}</color>',dis)or nil
rankInfo.iconScale=Vector3.New(1,-1,1)
end

local score=self:getScore()
local ds=data.score-score
local mtxt
if ds>0 then
local color='green'
mtxt=FMT.fmt('{0}<color={1}>（+{2}）</color>',data.score,color,ds)
else
local color='red'
mtxt=FMT.fmt('{0}<color={1}>（{2}）</color>',data.score,color,ds)
end
local resInfo={resNum=mtxt}
local resIcon={assetName=self:getScoreIconName()}
resInfo.resIcon=resIcon

local tips=(data.moneynum==0 and data.result==1)and FMT.fmt('今日获取{0}已达获取上限',moneyModel.getMoneyName(eMoneyType.mtZhanYuDian))or''

return rwList,rankInfo,resInfo,tips
end

function UIXianFaWenDaoControl:getScoreIconName()
local name=cfgHelper.get2(cfg_xianfawendaoconfig_get,1,'score_icon')
return name
end

function UIXianFaWenDaoControl:countOrderLevel()
local scores=UIXianFaWenDaoControl:getScore()
local cfgs=cfg_xianfawendaoscoreconfig()
local level=0
for i,v in ipairs(cfgs)do
if scores>=v.min then
level=i
else
break
end
end
return level
end

function UIXianFaWenDaoControl:getNextOrderLevel()
local cfgs=cfg_xianfawendaoscoreconfig()
local nextLevel=math.min(self.data.orderLevel+1,#cfgs)
return nextLevel
end

function UIXianFaWenDaoControl:getOrderLevel()
return self.data.orderLevel
end

function UIXianFaWenDaoControl:checkAndShowOrderLevelUp()
local level=self:countOrderLevel()
if level>self.data.orderLevel then

if not self:checkOrderRewardReceive(level)then
bitHelper.set_1(self.data.flag,level-1)
UIManager:showWindow('UIXFWDLevelUpWin',level)
end
self.data.orderLevel=level
end
end

function UIXianFaWenDaoControl:checkOrderRewardReceive(level)
if self.data and self.data.flag then
return bitHelper.check_pos(self.data.flag,level-1)
end
return false
end

function UIXianFaWenDaoControl:setSkipFightState(skip)
self.skipFightState=skip
end

function UIXianFaWenDaoControl:isSkipFight()
return self.skipFightState==true
end

function UIXianFaWenDaoControl:checkIsInit()
return self.data and self.data.isInit
end



function UIXianFaWenDaoControl:getLevel()
return self.data.level or 0
end

function UIXianFaWenDaoControl:getScore()
return self.data.score or 0
end

function UIXianFaWenDaoControl:setScore(score)
local lastScore=self.data.score
self.data.score=score
if score>lastScore then
UIXianFaWenDaoControl:checkAndShowOrderLevelUp()
end
local myId=playerModel:getActorID()
local ttdata=self:getTopThree()
for i,v in ipairs(ttdata)do
if v.actorid==myId then
v.score=score
end
end
end

function UIXianFaWenDaoControl:getRank()
return self.data.rank or 0
end

function UIXianFaWenDaoControl:setRank(rank)

if self.data.rank~=rank and(self.data.rank<=3 or rank<=3)then
self:reqDatas()
end
self.data.rank=rank
end

function UIXianFaWenDaoControl:getSession()
return self.data.session or 0
end

function UIXianFaWenDaoControl:getSessionBeginTime()
return self.data.beginTime
end

function UIXianFaWenDaoControl:getSessionTruceEndTime()
return self.data.truceEndTime
end

function UIXianFaWenDaoControl:getSessionEndTime()
return self.data.endTime
end

function UIXianFaWenDaoControl:getSessionTime()
return self.data.beginTime,self.data.endTime
end

function UIXianFaWenDaoControl:getNextSessionTime()
return self.data.truceEndTime,self.data.nextEndTime
end

function UIXianFaWenDaoControl:getOldSessionEndTime()
return self.data.oldEndTime
end

function UIXianFaWenDaoControl:getTeam()
return self.data.team or{}
end

function UIXianFaWenDaoControl:getTeamDict()
return self.data.teamDict or{}
end

function UIXianFaWenDaoControl:setTeam(team)
self.data.team=team or{}
self:setTeamDict()
end

function UIXianFaWenDaoControl:setTeamDict()
local teamDict={}
for i,v in ipairs(self.data.team)do
local str=tostring(v)
if str~='0'then
teamDict[str]=i
end
end
self.data.teamDict=teamDict
end

function UIXianFaWenDaoControl:isInTeamByStr(dzGuidStr)
local dict=self:getTeamDict()
return dict[dzGuidStr]~=nil
end

function UIXianFaWenDaoControl:isInTeam(dzId)
return UIXianFaWenDaoControl:isInTeamByStr(tostring(dzId))
end

function UIXianFaWenDaoControl:setRegister(value)
self.data.isRegister=value
end

function UIXianFaWenDaoControl:getRegister()
return self.data.isRegister
end

function UIXianFaWenDaoControl:setPreviousTopData(level,datas)
for i,v in ipairs(datas)do
if v.actorname then
v.actorname=playerModel:getOtherActorName(v.actorname)
end
end
self.data.previousTopData[level]=datas
end

function UIXianFaWenDaoControl:getPreviousTopData(level)
return self.data.previousTopData[level]or{}
end

function UIXianFaWenDaoControl:checkPreviousTopData()
return self.data.previousTopData~=nil
end

function UIXianFaWenDaoControl:setLikeNum(level,rank)
local datas=self:getPreviousTopData(level)
local data=datas[rank]
data.times=data.times+1
end

function UIXianFaWenDaoControl:setPreviousData(datas)
self.data.previousData=datas
end

function UIXianFaWenDaoControl:getPreviousData()
return self.data.previousData
end

function UIXianFaWenDaoControl:setInvestFlag(flag)
self.data.investFlag=flag
reddotControl.on_change_catch_type(CATCH_TYPE.eLunDaoRewards)
UIFullTotalTouZiActivityontrol:onChanged(TZ_CATCH_TYPE.eXFWD)
end

function UIXianFaWenDaoControl:checkInvestFlag(id,free)
local value=self.data.investFlag
local pos
if free then
pos=2*(id-1)+1
else
pos=2*(id-1)+2
end
local res=_LuaHelper.SplitInt32(value,"0x1",pos)
return res==1
end

function UIXianFaWenDaoControl:isInvestPaid()
local value=self.data.investFlag
local res=_LuaHelper.SplitInt32(value,"0x1",0)
return res==1
end

function UIXianFaWenDaoControl:getTotalTimes()
return self.data.totalTimes or 0
end

function UIXianFaWenDaoControl:checkTeamSame(tlist)
local team=self:getTeam()
local len=#tlist
for i=1,len do
if tostring(team[i])~=tostring(tlist[i])then
return false
end
end
return true
end

function UIXianFaWenDaoControl:checkAndReqNewData()
local time=gameUtilityModel.getServerShortTime()
if time-self.lastReqDataTime>60 then
self:reqDatas()
end
end

function UIXianFaWenDaoControl:checkReddot()
if not self:checkUnlockEx()then
return false
end
return self:checkLikeReddot()or self:checkInvestReddot()
end

function UIXianFaWenDaoControl:checkLikeReddot()
local isTruce=UIXianFaWenDaoControl:isInTruceTime()
if not isTruce then
return false
end
local hasTopThree=UIXianFaWenDaoControl:isHasTopThree()
local times=UIXianFaWenDaoControl:getLastLikestimes()
return times>0 and hasTopThree
end

function UIXianFaWenDaoControl:checkInvestReddot()
local times=self:getTotalTimes()
if times==0 then
return false
end
local cfgs=cfg_xianfawendaoinvestconfig()
for i,v in ipairs(cfgs)do
if times>=v.times then
if not self:checkInvestFlag(v.id,true)then
return true
end
else
break
end
end
local isPaid=self:isInvestPaid()
if isPaid then
for i,v in ipairs(cfgs)do
if times>=v.times then
if not self:checkInvestFlag(v.id)then
return true
end
else
break
end
end
end
return false
end


function UIXianFaWenDaoControl:checkFreeReddot()
local cfg=cfgHelper.get1(cfg_xianfawendaoconfig_get,1)
local btime,etime=UIXianFaWenDaoControl:getSessionTime()
local currtime=gameUtilityModel.getServerShortTime()
local regEndTime=btime+cfg.signup*86400
local isTruce=UIXianFaWenDaoControl:isInTruceTime()

local times,ft,pt=UIXianFaWenDaoControl:getAllChallengeTimes()
return not isTruce and currtime>=regEndTime and ft>0
end


function UIXianFaWenDaoControl:showActorInfo(data)
local callback=function(teamDzList)
local rdata={
teamList=teamDzList,
winName="UICommonLookRival_select3TeamWin",
winArgs={
teamCount=3,
},
lookType=DOUFATAI_LOOK_TYPE.eXianFaWenDao,
}
UIManager:showWindow("UICommonLookRivalWin",rdata)
end
otherPlayerModel:reqActorDefTeams(otherPlayerInfoType.eXianFaWenDao2,data.actorid,{serverid=data.serverid},callback,true)
end



function UIXianFaWenDaoControl:reqDatas()
socketManager:send_17_52()
self.lastReqDataTime=gameUtilityModel.getServerShortTime()
end

function UIXianFaWenDaoControl:reqChangeTeam(len,arr)
socketManager:send_17_53(len,arr)
end

function UIXianFaWenDaoControl:reqRegister()
socketManager:send_17_54()
end

function UIXianFaWenDaoControl:reqRankList(level)
socketManager:send_17_55(level)
end

function UIXianFaWenDaoControl:reqRecordList()
socketManager:send_17_56()
end

function UIXianFaWenDaoControl:reqMatching()
socketManager:send_17_57()
end

function UIXianFaWenDaoControl:reqPreviousTopList(level)
socketManager:send_17_58(level)
end

function UIXianFaWenDaoControl:reqLike(level,rank,assist)
socketManager:send_17_59(level,rank,assist or 0)
end

function UIXianFaWenDaoControl:reqPreviousList()
socketManager:send_17_60()
end

function UIXianFaWenDaoControl:reqInvestReward()
socketManager:send_17_62()
end



function UIXianFaWenDaoControl.recv_17_51(datasec,challengetimes,likestimes,moneynum)
UIXianFaWenDaoControl:setBaseData(datasec,challengetimes,likestimes,moneynum)
if UIXianFaWenDaoControl:checkUnlock()then
UIXianFaWenDaoControl:reqDatas()
end

local btime,etime=UIXianFaWenDaoControl:getSessionTime()
local currtime=gameUtilityModel.getServerShortTime()

if currtime>etime then
btime,etime=UIXianFaWenDaoControl:getNextSessionTime()
end
limitActivitiesModel:addClientAct(LIMIT_ACT_TYPE.eXianFaWenDao,btime,etime)
end

function UIXianFaWenDaoControl.recv_17_52(datas)
UIXianFaWenDaoControl:setDatas(datas)

UIManager:callWindowFunc('UIXianFaWenDaoWin','refresh')

if UIXianFaWenDaoControl:isInTruceTime()then
UIXianFaWenDaoControl:checkAndShowEnterIcon()
notifySystem:postNotify(notifyConfig.onXianFaLunDaoDianZan)
UIXianFaWenDaoControl:refreshDouFaTaiHUD()

WDCQController.onInvitWDCQ()

local level=UIXianFaWenDaoControl:getLevel()
level=(level~=nil and level>0)and level or 1
UIXianFaWenDaoControl:reqPreviousTopList(level)
end
taskController.onXFWDRankLevelChange()
UIFullTotalTouZiActivityontrol:onChanged(TZ_CATCH_TYPE.eXFWD)
end

function UIXianFaWenDaoControl.recv_17_53(len,arr)
UIXianFaWenDaoControl:setTeam(arr)
local win=UIManager:findActiveWindow('UIFightPrepareWin')
if win then
fightController:closeSelectStage()
UIXianFaWenDaoControl:showXianFaWenDaoWin()
end
UIManager.info('保存成功')
end

function UIXianFaWenDaoControl.recv_17_54()

if UIXianFaWenDaoControl:isInRegisterTime()then
UIXianFaWenDaoControl:setRegister(true)
UIManager:callWindowFunc('UIXianFaWenDaoWin','refresh')
end
end

function UIXianFaWenDaoControl.recv_17_55(level,len,arr,nLen,nArr)
if level>0 then
UIXianFaWenDaoControl:setRankDatas(level,arr or{})
UIManager:callWindowFunc('UIXFWDRankingWin','refresh',level)

notifySystem:postNotify(notifyConfig.onXianFaLunDaoRankUpdate)
end
UIXianFaWenDaoControl:setRankNumData(nArr)

notifySystem:postNotify(notifyConfig.onRankListRefresh,eXFWDLevel2RankType[level])
end

function UIXianFaWenDaoControl.recv_17_56(len,arr)
if len>0 then
UIXianFaWenDaoControl:setRecordData(arr)
UIManager:showWindow('UIXFWDRecordWin')
end
end

function UIXianFaWenDaoControl.recv_17_57(len,arr)
UIXianFaWenDaoControl:setMatchingData(arr)
UIManager:callWindowFunc('UIXFWDChallengeWin','refresh',true)
end

function UIXianFaWenDaoControl.recv_17_58(level,len,arr)
UIXianFaWenDaoControl:setPreviousTopData(level,arr or{})
UIManager:callWindowFunc('UILDRongYuTongWin','onRecv')
end

function UIXianFaWenDaoControl.recv_17_59(level,rank)
UIXianFaWenDaoControl:setLikeNum(level,rank)
UIXianFaWenDaoControl:addLikestimes()
UIManager:callWindowFunc('UILDRongYuTongWin','onRecv')
UIManager:callWindowFunc('UIXianFaWenDaoWin','setLikeReddot')

notifySystem:postNotify(notifyConfig.onXianFaLunDaoDianZan)
UIXianFaWenDaoControl:refreshDouFaTaiHUD()
end

function UIXianFaWenDaoControl.recv_17_60(len,arr)
UIXianFaWenDaoControl:setPreviousData(arr or{})
UIManager:callWindowFunc('UIXFWDPreviousWin','refresh')
end

function UIXianFaWenDaoControl.recv_17_61(rank,score)
UIXianFaWenDaoControl:setRank(rank)
UIXianFaWenDaoControl:setScore(score)
UIManager:callWindowFunc('UIXianFaWenDaoWin','refresh')
taskController.onXFWDRankLevelChange()
end

function UIXianFaWenDaoControl.recv_17_62(investflag)
UIXianFaWenDaoControl:setInvestFlag(investflag)
UIManager:callWindowFunc('UIXFWDSessionRewardWin','refresh')
UIManager:callWindowFunc('UIXianFaWenDaoWin','setRewardReddot')
UIManager:callWindowFunc('UITouZiXFWDSessionRewardWin','refresh')
reddotControl.on_change_catch_type(CATCH_TYPE.eLimitActChange,LIMIT_ACT_TYPE.eXianFaWenDao)
reddotControl.on_change_catch_type(CATCH_TYPE.eLunDaoRewards)
UIXianFaWenDaoControl:refreshDouFaTaiHUD()
end

function UIXianFaWenDaoControl:refreshDouFaTaiHUD()
local bdData=zongmenModel:findBuildingDataByID(mapIdType.zhufeng,SLG_SYSTEM_TYPE.eDouFaTai)
if bdData then
hudControl:refreshBuildingStatusHUD(bdData.un_build_id)
end
end


function UIXianFaWenDaoControl:xfwdAutoFight(orderID)
if UIXianFaWenDaoControl:isInTruceTime()then
UIXianFaWenDaoControl:showAutoError(orderID,"玩法活动未开启")
return
end
if UIXianFaWenDaoControl:isInRegisterTime()or not UIXianFaWenDaoControl:checkUnlock()then
UIXianFaWenDaoControl:showAutoError(orderID,"仙法问道未开始")
return
end
if not UIXianFaWenDaoControl:getRegister()then
UIXianFaWenDaoControl:showAutoError(orderID,"仙法问道未报名")
return
end
local team=UIXianFaWenDaoControl:getTeam()
if#team<15 then
UIXianFaWenDaoControl:showAutoError(orderID,"请先设置防守阵容")
return
end
for i=1,3 do
local count=0
for ii=1,5 do
local index=ii+(i-1)*5
local dzId=team[index]
if tostring(dzId)~='0'then
count=count+1
break
end
end
if count==0 then
UIXianFaWenDaoControl:showAutoError(orderID,"请先设置防守阵容")
return
end
end

local autoFightFunc=function()
local setupData=xiaoZhuShouModel:getSetupData(orderID)
local datas=UIXianFaWenDaoControl:getMatchingData()
local fightIdx=1
local targetIdx=1
local lowFight=setupData[xzsDataKey.xfwdPriorityChallenge]==1
if lowFight then
local minFight=math.huge
for i,data in ipairs(datas)do
local fv=UIXianFaWenDaoControl:getMatchingTargetFightValue(i)
if fv<minFight then
fightIdx=data.index
targetIdx=i
minFight=fv
end
end
else

fightIdx=datas[1].index
targetIdx=1
end
local fightName=""
local data=datas[targetIdx]
local robotID,robbotType=UIXianFaWenDaoControl:getRobbotInfo(data.actorid)
if robbotType==1 then
fightName=UIXianFaWenDaoControl:getRobbitName(data.actorid,robotID)
UIXianFaWenDaoControl:setRecordName(data.actorid,fightName)
UIXianFaWenDaoControl:saveRecordData()
else
if data.actorname==''then
fightName=UIXianFaWenDaoControl:getRobbitName(data.actorid,1,true)
UIXianFaWenDaoControl:setRecordName(data.actorid,fightName)
UIXianFaWenDaoControl:saveRecordData()
else
fightName=data.actorname
end
end

local args={orderID=orderID,fightName=fightName,fightIdx=fightIdx}
local detailFunc=function()
local detailId=XIAOZHUSHUDETAIL_ENUM.xzs_sub_xfwd_challenge

xiaoZhuShouModel:addDetailData(detailId,args)
end

local tt,ft,pt=UIXianFaWenDaoControl:getAllChallengeTimes()
local cfg=cfgHelper.get1(cfg_xianfawendaoconfig_get,1)
if ft<=0 then
local autoBuyTimes=setupData[xzsDataKey.xfwdAutoBuyTimes]==1
if autoBuyTimes then
local challengeBuyNum=tt-cfg.free
local buyTimesMax=setupData[xzsDataKey.xfwdBuyTimes]
if challengeBuyNum<buyTimesMax then
local buyTimes=challengeBuyNum+1
local consume=cfg.consume
local costItemCfg=consume[buyTimes][1]
local costItem=costItemCfg[1]
local costNum=costItemCfg[2]
if itemsModel.checkItemEnough(costItem,costNum)then
args.buyNum=buyTimes
detailFunc()
else

UIXianFaWenDaoControl:showAutoError(orderID,"购买挑战次数所需货币不足，已停止自动挑战")
end
else

UIXianFaWenDaoControl:showAutoError(orderID,"挑战次数不足，已停止自动挑战")
end
else

UIXianFaWenDaoControl:showAutoError(orderID,"挑战次数不足，已停止自动挑战")
end
else
detailFunc()
end
end

socketManager:addNotify(17,57,autoFightFunc,1)
UIXianFaWenDaoControl:reqMatching()
end

function UIXianFaWenDaoControl:showAutoError(orderID,errorLog)
local detailCfg=cfg_xiaozhushoudetailconfig_get(XIAOZHUSHUDETAIL_ENUM.xzs_sub_xfwd_challenge)
local args={
orderID=orderID,
state=-1,
title=detailCfg.name,
icon=detailCfg.icon,
error=errorLog,
completeFunc=function()
xiaoZhuShouController:setIdleState()
end,
}
xiaoZhuShouModel:addDetailData(XIAOZHUSHUDETAIL_ENUM.xzs_sub_ss,args)
end

function UIXianFaWenDaoControl:xfwdSkipFight(fightIndex,func)
local time=timeHelper.getServerShortTime()
local last=self.lastSendSkip
if last and time-last<=3 then
return time-last
end

fightIndex=fightIndex or 1

local teamData={{},{},{}}
local team=UIXianFaWenDaoControl:getFightTeam()
if team then
for i,v in ipairs(team)do
if v~='0'then
local dzId=int64.new(v)
local dzData=UIDiscipleModel:getDiscipleData(dzId)
if dzData then
local tId=math.floor((i-1)/5)+1
local pId=(i-1)%5+1
local tdata=teamData[tId]
tdata[pId]={pId,1,dzId}
end
end
end
else
team=UIXianFaWenDaoControl:getTeam()
for i,v in ipairs(team)do
local dzId=tostring(v)
if dzId~='0'then
local tId=math.floor((i-1)/5)+1
local pId=(i-1)%5+1
local tdata=teamData[tId]
tdata[pId]={pId,1,v}
end
end
end
local teamList={}
for i,v in ipairs(teamData)do
local dt={}
for ii=1,5 do
local d=v[ii]
if d then
dt[ii]={1,d[3]}
else
dt[ii]={0,int64.new('0')}
end
end
teamList[i]={#dt,dt,{818004,0}}
end

local args={quickCallback=func}
fightModel:setSendExtraArgs(eBattleType.xianfawendao,args)
local tt,ft,pt=UIXianFaWenDaoControl:getAllChallengeTimes()

fightLaunchController:sendFightEx(eBattleLaunch.xianfawendao,teamList,{-fightIndex,ft>0 and 0 or 1})
self.lastSendSkip=time
return 0
end


function UIXianFaWenDaoControl:getPlatFormIdCfg(cfg)
local pfId=gameUtilityModel.getServerPlatform()
if cfg and pfId then
if cfg[pfId]then
return cfg[pfId]
else
if cfg[-1]then
return cfg[-1]
end
end
end
return cfg
end
