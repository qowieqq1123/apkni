






local _MODULENAME="tianshudazhenModel"


def_table(_MODULENAME)
tianshudazhenModel.name=_MODULENAME
tianshudazhenModel.data={}

function tianshudazhenModel:onAppStart()

end


function tianshudazhenModel:onEnterState(isReconnect)
self.data={}
end


function tianshudazhenModel:onProtocolReq()

end


function tianshudazhenModel:onLeaveState(isReconnect)
self.data={}
end


function tianshudazhenModel:initData(times)
self.data.times=times
end

function tianshudazhenModel:onTimesResume(idx,times)
self.data.times=idx+times-1
end

function tianshudazhenModel:onYunZhouSet(argstable)
local setData={}
setData.yzid=argstable[1]
setData.dzlist=argstable[3]or{}
setData.soldierlist={}
setData.sortOrder=argstable[6]==1 and eSortOrderEx.eDown or eSortOrderEx.eUp
local dzlookup={}
for i,v in ipairs(setData.dzlist)do
dzlookup[tostring(v)]=true
end
for _,v in ipairs(argstable[5]or{})do
setData.soldierlist[#setData.soldierlist+1]={v.param_1,v.param_2}
end
setData.dzlookup=dzlookup

self.data.setData=setData
end


function tianshudazhenModel:onFYZStampRefreshSet(stamp)
self.data.fyzStamp=stamp
local oldAllValue=tianshudazhenModel:getHudunValue()
local newAllValue=tianshudazhenModel:calutionFangHuZhi()
self.data.fyzVal=newAllValue
if oldAllValue~=newAllValue then
notifySystem:postNotify(notifyConfig.onTianShuDaZhen_fangyuzhi_change,oldAllValue,newAllValue)
end
end

function tianshudazhenModel:refreshHDZAddVal()
if self.data.fyzStamp==nil then return true end
if tianshudazhenModel:isMaxHDZ()then return false end
local oldAllValue=tianshudazhenModel:getHudunValue()
local newAllValue=tianshudazhenModel:calutionFangHuZhi()
self.data.fyzVal=newAllValue
if oldAllValue~=newAllValue then
notifySystem:postNotify(notifyConfig.onTianShuDaZhen_fangyuzhi_change,oldAllValue,newAllValue)
end
return true
end


function tianshudazhenModel:onInitFHZBuff()
local time=0
for buffid,v in pairs(self.data.fyzbufflookup or{})do
local left=xianjieModel:getBuffLeftTime(buffid)
time=time+left
end
local max=tianshudazhenConfig.getMaxFHZValue()
time=math.min(time,max)
if time<=0 then
if tianshudazhenModel:getLocalJiJieYBDData()and not xianjieModel:checkHasJiJieYBDIsOpen(xjJjJieBaseType.eWar)then
xianjieController:reqMassYBDChangeOpenFlagWithType(xjJjJieBaseType.eWar,true)
end
end
end


function tianshudazhenModel:onRefreshFangYuZhaoBuffBuff(buffid,v,times_,init)
if self.data.fyzbufflookup==nil then self.data.fyzbufflookup={}end
self.data.fyzbufflookup[buffid]=xianjieModel:getBuffEndStamp(buffid)
local time=0
for buffid,v in pairs(self.data.fyzbufflookup)do
local left=xianjieModel:getBuffLeftTime(buffid)
time=time+left
end
local max=tianshudazhenConfig.getMaxFHZValue()
time=math.min(time,max)
local leftTime=tianshudazhenModel:getOpeningDaZhenLeftTime()
self.data.fyzbuffTime=time+timeHelper.getServerShortTime()
if not init then
if leftTime<=0 and time>0 then
UIManager.info('护山大阵已激活')
UIManager:closeWindow('UITianShuDaZhenUseWin')
UIManager:callWindowFunc('UITianShuDaZhenWin','onBtnTips')
elseif time>leftTime then
UIManager:callWindowFunc('UITianShuDaZhenUseWin','refreshInfo')
UIManager.info('护盾使用成功')
end
end
if time<=0 then
if tianshudazhenModel:getLocalJiJieYBDData()and not xianjieModel:checkHasJiJieYBDIsOpen(xjJjJieBaseType.eWar)then
xianjieController:reqMassYBDChangeOpenFlagWithType(xjJjJieBaseType.eWar,true)
end
end
UIManager:callWindowFunc('UITianShuDaZhenWin','onChangeDaZhen')
end


function tianshudazhenModel:onRefreshDisableFangYuZhaoBuff(buffid)
if self.data.disfyzbufflookup==nil then self.data.disfyzbufflookup={}end
self.data.disfyzbufflookup[buffid]=xianjieModel:getBuffEndStamp(buffid)
local time=0
for buffid,v in pairs(self.data.disfyzbufflookup)do
local left=xianjieModel:getBuffLeftTime(buffid)
time=time+left
end
self.data.disfyzbuffTime=time+timeHelper.getServerShortTime()
UIManager:callWindowFunc('UITianShuDaZhenWin','onChangeDaZhen')
end


function tianshudazhenModel:isUnlock()
if not mountainControl:isOpen(mapIdType.fort)then return false,1 end
local data=zongmenModel:findBuildingDataByType(mapIdType.fort,SLG_SYSTEM_TYPE.eXianYunGang)
if data==nil then return false,2 end
local list=XianYunGangModel:getBoatList()
if list==nil or#list==0 then return false,3 end
return true
end

function tianshudazhenModel:getYunZhouSetData()
return self.data.setData
end

function tianshudazhenModel:getYunZhouYzid()
return self.data.setData and self.data.setData.yzid or nil
end

function tianshudazhenModel:getYunZhouDZList()
return self.data.setData and self.data.setData.dzlist or nil
end

function tianshudazhenModel:getNextBuyHDZTimes()
return tianshudazhenModel:getAlreadyBuyHDZTimes()+1
end

function tianshudazhenModel:getAlreadyBuyHDZTimes()
return self.data.times or 0
end

function tianshudazhenModel:getHudunValue()
return self.data.fyzVal or 0
end

function tianshudazhenModel:getSoldierSortOrder()
if self.data.setData==nil then return eSortOrderEx.eDown end
return self.data.setData.sortOrder
end

function tianshudazhenModel:getLeftUpTime()
local bdData=tianshudazhenModel:getBuildData()
if bdData==nil then return 0 end
local data=buildingCDControl:getCDData(buildingCDType.build,bdData.un_build_id,true)
return data and data.cd or 0
end

function tianshudazhenModel:calutionFangHuZhi()
if self.data.fyzStamp==nil then return 0 end
local oldStamp=self.data.fyzStamp
local cost=math.max(0,timeHelper.getServerShortTime()-oldStamp)
local autoResumeInfo=tianshudazhenConfig.getFYZResumeInterval()
local interval=autoResumeInfo[1]
local value=autoResumeInfo[2]
local add=math.floor(cost/interval)*value
local val=moneyModel.getMoney(eMoneyType.mtTSDZShield)+add
local level=tianshudazhenModel:getLevel()
if level>0 then
local max=tianshudazhenConfig.getMaxHDZValue(level)
return math.min(max,val)
end
return val
end

function tianshudazhenModel:getMaxHDZValue()
local level=tianshudazhenModel:getLevel()
if level==0 then return 0 end
return tianshudazhenConfig.getMaxHDZValue(level)
end


function tianshudazhenModel:getFHZResetLeftTime()
return timeHelper.getWeekTimeLeftStamp(1,5)
end


function tianshudazhenModel:getBuildData()
return zongmenModel:findBuildingDataByType(mapIdType.fort,SLG_SYSTEM_TYPE.eTianShuDaZhen)
end


function tianshudazhenModel:getDisableDaZhenLeftTime()
if self.data.disfyzbuffTime==nil then return 0 end
local time=self.data.disfyzbuffTime-timeHelper.getServerShortTime()
return math.max(0,time)
end


function tianshudazhenModel:getOpeningDaZhenLeftTime()
if self.data.fyzbuffTime==nil then return 0 end
local time=self.data.fyzbuffTime-timeHelper.getServerShortTime()
return math.max(0,time)
end

function tianshudazhenModel:getHasFHZFreeTimes()
return moneyModel.getMoney(eMoneyType.mtTSDZConsume)
end

function tianshudazhenModel:getAttrLookup(attrid)

end

function tianshudazhenModel:isZhuShouDZ(dzStr)
return self.data.setData and self.data.setData.dzlookup and self.data.setData.dzlookup[dzStr]==true
end

function tianshudazhenModel:isMaxLevel()
local bdData=tianshudazhenModel:getBuildData()
if bdData==nil then return false end
return cfgHelper.get2(cfg_monijybuilduplvlconfig_get,bdData.build_id,bdData.level+1)==nil
end

function tianshudazhenModel:isDoingUp()
return tianshudazhenModel:getLeftUpTime()>0
end

function tianshudazhenModel:isZhuShouTeam()
local data=tianshudazhenModel:getYunZhouSetData()
return data and data.yzid~=nil and data.dzlist~=nil and#data.dzlist~=0
end


function tianshudazhenModel:getLevel()
return zongmenModel:getBuildingLevel(mapIdType.fort,SLG_SYSTEM_TYPE.eTianShuDaZhen)
end

function tianshudazhenModel:isMaxHDZ()
local level=tianshudazhenModel:getLevel()
if level==0 then return false end
local value=tianshudazhenModel:getHudunValue()
local max=tianshudazhenModel:getMaxHDZValue()
return value>=max
end

function tianshudazhenModel:isMaxFHZFreeTimes()
return tianshudazhenModel:getHasFHZFreeTimes()>=tianshudazhenConfig:getMaxFHZFreeTimes()
end


function tianshudazhenModel:isDisableOpenFHZ()
return tianshudazhenModel:getDisableDaZhenLeftTime()>0
end


function tianshudazhenModel:isOpeningFHZ()
return tianshudazhenModel:getOpeningDaZhenLeftTime()>0 and(not xianjieController:checkInMoGongZhengDuo())
end


function tianshudazhenModel:isCanBuChongHuDun()
if tianshudazhenModel:isMaxHDZ()then
return false,2
end

local recover=tianshudazhenConfig.getHuDunValueCost()
local times=tianshudazhenModel:getNextBuyHDZTimes()
local costTable=recover[times]or recover[#recover]
if costTable==nil or#costTable<=0 then return true end
for i,v in ipairs(costTable)do
if not itemsModel.checkItemEnough(v[1],v[2])then return false,1,v end
end
return true
end

function tianshudazhenModel:isBuyMaxHDZTimes()
return tianshudazhenModel:getAlreadyBuyHDZTimes()>=tianshudazhenConfig.getMaxHDZBuyTimes()
end

function tianshudazhenModel:isCanUpLevel()
if not tianshudazhenModel:isUnlock()then return false end
local level=tianshudazhenModel:getLevel()
if level==0 then return false end
local bdData=tianshudazhenModel:getBuildData()
if bdData==nil then return false end
if bdData.flag==buildingStateType.eUpgrading then return false end
local cfg=cfgHelper.get2(cfg_monijybuilduplvlconfig_get,bdData.build_id,bdData.level+1)
if cfg then
return zongmenControl:checkLevelUp(cfg,false,mapIdType.fort)
end
return false
end

function tianshudazhenModel:isCanUpFinish()
local level=tianshudazhenModel:getLevel()
if level==0 then return false end
local bdData=tianshudazhenModel:getBuildData()
if bdData==nil or bdData.begintime==nil then return false end
return bdData.begintime>0 and
buildingCDControl:isComplete(buildingCDType.build,bdData.un_build_id)
end


function tianshudazhenModel:getCurSoldiersSetting()
local data=tianshudazhenModel:getYunZhouSetData()
return data.soldierlist
end

function tianshudazhenModel:getCurSoldiers()
local data=tianshudazhenModel:getYunZhouSetData()
if data==nil or data.soldierlist==nil then return end

local maxCnt=0
local left=0
local lookup={}
for i,v in ipairs(data.soldierlist)do
local moneyType=v[1]
local cnt=v[2]
local has=moneyModel.getMoney(moneyType)
local put=math.min(has,cnt)
lookup[moneyType]=put
maxCnt=maxCnt+cnt-put
end

local order=tianshudazhenModel:getSoldierSortOrder()
local cfgs=cfg_fairylandsoldierconfig()
local len=#cfgs
local putMoney=function(i)
local moneyType=eMoneyType[string.format('mtFLSoldier%d_1',i)]
local left=moneyModel.getMoney(moneyType)-(lookup[moneyType]or 0)
local put=math.min(maxCnt,left)
if put>0 then
lookup[moneyType]=(lookup[moneyType]or 0)+put
end
maxCnt=maxCnt-put
if maxCnt<=0 then
return true
end
return false
end
local isDown=order==eSortOrderEx.eDown
if isDown then
for i=len,1,-1 do
if putMoney(i)then break end
end
else
for i=1,len do
if putMoney(i)then break end
end
end
local list={}
for k,v in pairs(lookup)do
list[#list+1]={k,v}
end
table.sort(list,function(a,b)
return a[1]>b[1]
end)
return list
end

function tianshudazhenModel:setLocalJiJieYBDData(flag)
userActorArraySetting.set(ACTOR_SETTING_TYPE.eTianShuDaZhen,'jjybd',flag)
userActorArraySetting.flush(ACTOR_SETTING_TYPE.eTianShuDaZhen,true)
end

function tianshudazhenModel:getLocalJiJieYBDData()
return userActorArraySetting.get(ACTOR_SETTING_TYPE.eTianShuDaZhen,'jjybd',false)
end


function tianshudazhenModel:getTop5Disciple(checkState)

































local teamNum=5
local copyList={}
local selectList={}
local selectList_lookup={}
local teamPosType={
eFront=1,
eBack=2,
}
local teamPosTypeIndexLookup={
[1]=teamPosType.eFront,
[2]=teamPosType.eFront,
[3]=teamPosType.eBack,
[4]=teamPosType.eBack,
[5]=teamPosType.eBack,
}
local dzList=UIDiscipleModel:getAllDiscipleDataX()
for i=1,teamNum do
if not selectList[i]then
copyList={}
local posType=teamPosTypeIndexLookup[i]
for i2,locData in pairs(dzList)do
local netData=locData.netData.net
local dzguid=netData.discipleguid
local dzguid_str=netData.discipleguidStr
local isOccupy=false
if checkState then
local dzState,stateStr=xianjieModel:getDZState(dzguid,true)
isOccupy=dzState~=nil
end
if selectList_lookup[dzguid_str]==nil and not isOccupy then
local fight=UIDiscipleModel:getDiscipleFightValue(dzguid)
local job=UIDiscipleModel:getDiscipleJob(dzguid)
local pospriorty=UIDiscipleModel.getJobPosPriorty(job)
local priIdx=5
for ii,vv in ipairs(pospriorty)do
local posIdxType=teamPosTypeIndexLookup[vv]

if posIdxType==posType then
priIdx=ii
break
end
end
table.insert(copyList,{discipleguid=dzguid,discipleguidStr=dzguid_str,fight=fight,pospriorty=priIdx})
end
end
table.sort(copyList,function(a,b)
if a.pospriorty==b.pospriorty then
return a.fight>b.fight
else
return a.pospriorty<b.pospriorty
end
end)

local dizi=copyList[1]
if dizi then
selectList[i]=dizi.discipleguidStr
selectList_lookup[dizi.discipleguidStr]=i
end
end
end
return selectList
end



function tianshudazhenModel:getXgJobId()
local xgtype=XIANGUAN_TYPE_ENUM.eTianShuLongWei
local jobInfo=xianguanController:getSelfHasJobByType(xgtype)
return jobInfo and jobInfo.jobId or nil
end

function tianshudazhenModel:hasXgTq(tqid)
local xgtype=XIANGUAN_TYPE_ENUM.eTianShuLongWei
return xianguanController:checkSelfHasTeQuanByType(tqid,xgtype)
end

function tianshudazhenModel:hasXgsdTq()
return tianshudazhenModel:hasXgTq(XIANGUAN_PRIVILEGE_ENUM.eTqType_17)
end

function tianshudazhenModel:hasXgjlTq()
return tianshudazhenModel:hasXgTq(XIANGUAN_PRIVILEGE_ENUM.eTqType_18)
end



function tianshudazhenModel:getUseXgTeQuanLeftTime()
local xgtype=XIANGUAN_TYPE_ENUM.eTianShuLongWei
local xgid=tianshudazhenModel:getXgJobId(xgtype)
if xgid==nil then return 0 end
local tqid=XIANGUAN_PRIVILEGE_ENUM.eTqType_17
local stamp=xianguanModel:callTeQuanObjFunc(xgid,tqid,'getCd')or 0
local left=stamp-timeHelper.getServerShortTime()
return math.max(left,0)
end


function tianshudazhenModel:getOpeningXgsdLeftTime()
if self.data.tssdbuffTime==nil then return 0 end
local time=self.data.tssdbuffTime-timeHelper.getServerShortTime()
return math.max(0,time)
end


function tianshudazhenModel:canUseXgsd(warning)
local xgtype=XIANGUAN_TYPE_ENUM.eTianShuLongWei
local xgid=tianshudazhenModel:getXgJobId(xgtype)
if xgid==nil then return false end
local tqid=XIANGUAN_PRIVILEGE_ENUM.eTqType_17
return xianguanHelper.checkTeQuanUseCondition(xgid,tqid,warning)
end


function tianshudazhenModel:getShenDunTeQuanBuffId()
local tqid=XIANGUAN_PRIVILEGE_ENUM.eTqType_17
return cfg_xianguanprivilegeconfig_get(tqid).effectArgs[1][1]
end


function tianshudazhenModel:getZaieBuQinTeQuanBuffId()
local tqid=XIANGUAN_PRIVILEGE_ENUM.eTqType_18
return cfg_xianguanprivilegeconfig_get(tqid).effectArgs[1][1][1]
end


function tianshudazhenModel:getZaieBuQinTeQuanBuffRange()
local tqid=XIANGUAN_PRIVILEGE_ENUM.eTqType_18
local effectArgs=cfg_xianguanprivilegeconfig_get(tqid).effectArgs
return effectArgs[2],effectArgs[3],effectArgs[4],effectArgs[5]
end


function tianshudazhenModel:getMaxXgHuDunUseCnt()
local tqid=XIANGUAN_PRIVILEGE_ENUM.eTqType_17
return cfg_xianguanprivilegeconfig_get(tqid).times
end


function tianshudazhenModel:getXgHuDunUseCnt()
local xgid=tianshudazhenModel:getXgJobId()
if xgid==nil then return 0 end
local tqid=XIANGUAN_PRIVILEGE_ENUM.eTqType_17
return xianguanModel:callTeQuanObjFunc(xgid,tqid,'getTimes')
end


function tianshudazhenModel:isOpeningTianShuShenDun()
return tianshudazhenModel:getOpeningXgsdLeftTime()>0
end


function tianshudazhenModel:onRefreshTianShuShenDunBuff(buffid)
if self.data.tssdbufflookup==nil then self.data.tssdbufflookup={}end
self.data.tssdbufflookup[buffid]=xianjieModel:getBuffEndStamp(buffid)
local time=0
for buffid,v in pairs(self.data.tssdbufflookup)do
local left=xianjieModel:getBuffLeftTime(buffid)
time=time+left
end
local leftTime=tianshudazhenModel:getOpeningDaZhenLeftTime()
self.data.tssdbuffTime=time+timeHelper.getServerShortTime()
if leftTime<=0 and time>0 then
UIManager.info('天枢神盾大阵开启')
UIManager:closeWindow('UITianShuDaZhenUseWin')
UIManager:callWindowFunc('UITianShuDaZhenWin','onBtnTips')
elseif time>leftTime then
UIManager.info('天枢神盾使用成功')
end
UIManager:callWindowFunc('UITianShuDaZhenOtherUseWin','refreshInfo')
end





function tianshudazhenModel:isOpeningZaieBuQinBuff()
return tianshudazhenModel:getOpeningZaieBuQinLeftTime()>0
end


function tianshudazhenModel:getOpeningZaieBuQinLeftTime()
if self.data.zebqbuffTime==nil then return 0 end
local time=self.data.zebqbuffTime-timeHelper.getServerShortTime()
return math.max(0,time)
end


function tianshudazhenModel:onRefreshZaieBuQinBuff(buffid)
if self.data.zebqbufflookup==nil then self.data.zebqbufflookup={}end
self.data.zebqbufflookup[buffid]=xianjieModel:getBuffEndStamp(buffid)
local time=0
for buffid,v in pairs(self.data.zebqbufflookup)do
local left=xianjieModel:getBuffLeftTime(buffid)
time=time+left
end
local leftTime=tianshudazhenModel:getOpeningDaZhenLeftTime()
self.data.zebqbuffTime=time+timeHelper.getServerShortTime()
if leftTime<=0 and time>0 then
UIManager.info('已开启灾厄不侵')
elseif time>leftTime then

end
end

function tianshudazhenModel:useShenDunTeQuan(actorid)
local xgid=tianshudazhenModel:getXgJobId()
local tqid=XIANGUAN_PRIVILEGE_ENUM.eTqType_17
local ut={}
ut[1]=7
ut[2]=tostring(actorid)
local jsonStr=jsonHelper.encode(ut)
local args={}
args.exInfoJsonStr=jsonStr
xianguanModel:callTeQuanObjFunc(xgid,tqid,'use',args)

self.useActorId=actorid
end

function tianshudazhenModel:getUseActorId()
return self.useActorId
end

function tianshudazhenModel:onRefreshXgAttr(buffid)
self.data.jlyzbuffid=buffid
self.data.jlyzbuffTime=timeHelper.getServerShortTime()+xianjieModel:getBuffLeftTime(buffid)
end


function tianshudazhenModel:onAddXgAttr(buffid,effect)
tianshudazhenModel:onRefreshXgAttr(buffid)
self.jylzAttrlookup=self.jylzAttrlookup or{}
self.jylzAttrlookup[effect[2]]=(self.jylzAttrlookup[effect[2]]or 0)+effect[3]
tianshudazhenAttrsModel:calAttrs()
end

function tianshudazhenModel:onRemoveXgAttr(buffid,effect)
tianshudazhenModel:onRefreshXgAttr(buffid)
self.jylzAttrlookup=self.jylzAttrlookup or{}
self.jylzAttrlookup[effect[2]]=(self.jylzAttrlookup[effect[2]]or 0)-effect[3]
tianshudazhenAttrsModel:calAttrs()
end

function tianshudazhenModel:getJylzAttrlookup()
return self.jylzAttrlookup
end
