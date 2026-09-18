







UIDailyPaperModel={}
UIDailyPaperModel.data={}

local _datas
local offlineTime
local serTypeData
local allDatas
local discipleJJLook

eZMDailyPaperType={
eJingJie=1,
eProSkill=2,
eShouYuan=3,
eMoneyChange=4,
eShangPu=5,
eXiuZhenJiaZu=6,
ePostWage=7,


eDzAllType=10000,
eChuiWeiInjury=10001,
eChuiWeiShouYuan=10002,
}

eDailyPaperShowEventType=
{
eDiscipleBaiShan=1,
eDiscipleLunDao=2,
eDiscipleDouFa=3,
eZongmenOptionEvent=4,
eBuildingOnFire=5,
eMonsterInvasion=6,
eJiQuanBuNing=7,
}

local eZMDailyPaperClientType=
{
[0]=eZMDailyPaperType.eDzAllType,
[1]=eZMDailyPaperType.eJingJie,
[2]=eZMDailyPaperType.eProSkill,
[3]=eZMDailyPaperType.eShouYuan,
[4]=eZMDailyPaperType.eChuiWeiInjury,
[5]=eZMDailyPaperType.eChuiWeiShouYuan,
}


function UIDailyPaperModel:onEnterState()
self.data.showEventList={}
offlineTime=0
_datas={}
serTypeData={}
allDatas={}
discipleJJLook={}
end

function UIDailyPaperModel:onLeaveState()

self.data={}
offlineTime=nil
_datas=nil
serTypeData=nil
allDatas=nil
discipleJJLook=nil
end

function UIDailyPaperModel:getConfigCondition(infoType)
return cfgHelper.get2(cfg_zongmendailypaperconfig_get,infoType,'condition')
end

function UIDailyPaperModel:getConfigServerText(infoType)
return cfgHelper.get2(cfg_zongmendailypaperconfig_get,infoType,'servertext')
end

function UIDailyPaperModel:getConfigClientText(infoType)
return cfgHelper.get2(cfg_zongmendailypaperconfig_get,infoType,'clienttext')
end


function UIDailyPaperModel:setOfflineTime(offline_time)
offlineTime=offline_time
end

function UIDailyPaperModel:getOfflineTime()
return offlineTime
end


function UIDailyPaperModel:setData(offlineRecordList)
_datas=offlineRecordList
end

function UIDailyPaperModel:getData()
return _datas
end


function UIDailyPaperModel:initData()

for i,v in ipairs(_datas)do
local t=serTypeData[v.recordtype]
if t==nil then
t={}
serTypeData[v.recordtype]=t
end
v.gameYear=self:randomGameYear()
if v.recordtype==eZMDailyPaperType.eJingJie then
v.gameYear=self:calculateJJGameYear(v)
discipleJJLook[tostring(v.param_1)]=v
end
table.insert(t,v)
end
self:getSeparateDisciples()
self:initAllData()
end

function UIDailyPaperModel:getOfflineDatasByType(infoType)
return serTypeData[infoType]or{}
end

function UIDailyPaperModel:getDatasByType(infoType)
local serDatas=self:getOfflineDatasByType(infoType)
local clientDatas={}
if infoType==eZMDailyPaperType.eJingJie then
clientDatas=self:getClientDatasJingjie()
elseif infoType==eZMDailyPaperType.eShouYuan then
clientDatas=self:getClientDatasShouyuan()
elseif infoType==eZMDailyPaperType.eChuiWeiInjury then
clientDatas=self:getClientDatasChuiWeiInjury()
elseif infoType==eZMDailyPaperType.eChuiWeiShouYuan then
clientDatas=self:getClientDatasChuiWeiShouYuan()
end
local datas=table.concatTableX(serDatas,clientDatas)
return datas
end

function UIDailyPaperModel:initAllData()
local sxConfig=cfg_zongmendailypaperconfig()
for i=0,#sxConfig do
local infoType=eZMDailyPaperClientType[i]
local list
if infoType==eZMDailyPaperType.eDzAllType then
local jjDatas=self:getDatasByType(eZMDailyPaperType.eJingJie)
local proDatas=self:getDatasByType(eZMDailyPaperType.eProSkill)
local syDatas=self:getDatasByType(eZMDailyPaperType.eShouYuan)
local chuiwei1Datas=self:getDatasByType(eZMDailyPaperType.eChuiWeiInjury)
local chuiwei2Datas=self:getDatasByType(eZMDailyPaperType.eChuiWeiShouYuan)
list=table.concatTableX(jjDatas,proDatas,syDatas,chuiwei1Datas,chuiwei2Datas)
self:insertClientDatasOther(list)
else
list=self:getDatasByType(infoType)
end
if#list>0 then
table.sort(list,function(a,b)return a.gameYear>b.gameYear end)
end
allDatas[i]=list
end
end

function UIDailyPaperModel:getDzInfoData(typo)
return allDatas[typo]or{}
end


function UIDailyPaperModel:getSeparateDisciples()
self.data.beforeTwentieth={}
self.data.afterTwentieth={}
local disciples=discipleLookup:getSortDiscipleList(eDiscipleSortType.eFightSort,nil,eSortOrder.eDown)
if#disciples>20 then
for i=21,#disciples do
table.insert(self.data.afterTwentieth,disciples[i])
end
end
local right=#disciples>=20 and 20 or#disciples
for i=1,right do
table.insert(self.data.beforeTwentieth,disciples[i])
end
end


function UIDailyPaperModel:getClientDatasJingjie()
if self.data.jingjieList then
return self.data.jingjieList
end
self.data.jingjieList={}
self:addDiscipleJingJie(self.data.beforeTwentieth)
if#self.data.jingjieList<3 then
self:addDiscipleJingJie(self.data.afterTwentieth)
end
return self.data.jingjieList
end
function UIDailyPaperModel:addDiscipleJingJie(disciples)
for i,v in ipairs(disciples)do
local net=v.netData.net
local guid=net.discipleguid
local show_broke=self:checkShowBroke(guid)
if#self.data.jingjieList<3 then
if show_broke then
local left
if discipleJJLook[tostring(guid)]then
left=discipleJJLook[tostring(guid)].gameYear
end
local gameYear=self:randomGameYear(left)
table.insert(self.data.jingjieList,{recordtype=eZMDailyPaperType.eJingJie,param_1=guid,gameYear=gameYear,client=true})
end
else
break
end
end
end
function UIDailyPaperModel:checkShowBroke(dzId)
local netData=UIDiscipleModel:getDiscipleData(dzId)
local jjlv=netData.jingjielv
local show_broke=UIDiscipleModel:isDiscipleJJLevelWillChangeX(netData)and UIDiscipleModel:checkNextJJNeedBroke(jjlv)and
UIDiscipleModel:checkJJBrokeByHand(jjlv)
return show_broke
end


function UIDailyPaperModel:getClientDatasShouyuan()
if self.data.shouyuanList then
return self.data.shouyuanList
end
self.data.shouyuanList={}
self:addDiscipleShouYuan(self.data.beforeTwentieth)
if#self.data.shouyuanList<5 then
self:addDiscipleShouYuan(self.data.afterTwentieth)
end
return self.data.shouyuanList
end
function UIDailyPaperModel:addDiscipleShouYuan(disciples)
for i,v in ipairs(disciples)do
local net=v.netData.net
local guid=net.discipleguid
local shouyuan=UIDiscipleModel:getDiscipleShouYuan(guid)
local condition=UIDailyPaperModel:getConfigCondition(eZMDailyPaperType.eShouYuan)
local needAdd=condition and shouyuan>=condition[1]and shouyuan<=condition[2]
if#self.data.shouyuanList<5 then
if needAdd then
local gameYear=self:randomGameYear()
table.insert(self.data.shouyuanList,{recordtype=eZMDailyPaperType.eShouYuan,param_1=guid,gameYear=gameYear,client=true})
end
else
break
end
end
end


function UIDailyPaperModel:getClientDatasChuiWeiInjury()
if self.data.chuiweiInjuryList then
return self.data.chuiweiInjuryList
end
self.data.chuiweiInjuryList={}
self:addDiscipleChuiWeiInjury(self.data.beforeTwentieth)
if#self.data.chuiweiInjuryList<2 then
self:addDiscipleChuiWeiInjury(self.data.afterTwentieth)
end
return self.data.chuiweiInjuryList
end
function UIDailyPaperModel:addDiscipleChuiWeiInjury(disciples)
for i,v in ipairs(disciples)do
local net=v.netData.net
local guid=net.discipleguid
if#self.data.chuiweiInjuryList<2 then
local chuiweiType=UIDiscipleModel:checkChuiWeiDiscipleType(guid)
if chuiweiType==DISCIPLE_CHUIWEI_TYPE.eInjury then
local gameYear=self:randomGameYear()
table.insert(self.data.chuiweiInjuryList,{recordtype=eZMDailyPaperType.eChuiWeiInjury,param_1=guid,gameYear=gameYear,client=true})
end
else
break
end
end
end


function UIDailyPaperModel:getClientDatasChuiWeiShouYuan()
if self.data.chuiweiShouYuanList then
return self.data.chuiweiShouYuanList
end
self.data.chuiweiShouYuanList={}
self:addDiscipleChuiWeiShouYuan(self.data.beforeTwentieth)
if#self.data.chuiweiShouYuanList<3 then
self:addDiscipleChuiWeiShouYuan(self.data.afterTwentieth)
end
return self.data.chuiweiShouYuanList
end
function UIDailyPaperModel:addDiscipleChuiWeiShouYuan(disciples)
for i,v in ipairs(disciples)do
local net=v.netData.net
local guid=net.discipleguid
if#self.data.chuiweiShouYuanList<2 then
local chuiweiType=UIDiscipleModel:checkChuiWeiDiscipleType(guid)
if chuiweiType==DISCIPLE_CHUIWEI_TYPE.eShouYuan then
local gameYear=self:randomGameYear()
table.insert(self.data.chuiweiShouYuanList,{recordtype=eZMDailyPaperType.eChuiWeiShouYuan,param_1=guid,gameYear=gameYear,client=true})
end
else
break
end
end
end


function UIDailyPaperModel:insertClientDatasOther(datas)
local list={}
local disciples=self.data.beforeTwentieth
local num=math.random(0,3)
if num>0 then
for i=1,num do
if disciples[i]then
local netData=disciples[i].netData
local net=netData.net
local guid=net.discipleguid
local idx
local gameYear=gameUtilityModel.getGameYear()
if i==1 then

local len=#datas>10 and 10 or#datas
len=len>0 and len or 1
idx=math.random(1,len)
local lastData=datas[idx]
if lastData then
gameYear=lastData.gameYear
end
table.insert(datas,idx,{recordtype=eZMDailyPaperType.eDzAllType,param_1=guid,gameYear=gameYear,client=true})
else
if#datas>10 then
idx=math.random(10,#datas)
else
idx=#datas
end
local lastData=datas[idx]
gameYear=lastData.gameYear
table.insert(datas,idx+1,{recordtype=eZMDailyPaperType.eDzAllType,param_1=guid,gameYear=gameYear,client=true})
end
end
end
end
end


function UIDailyPaperModel:dealDataParams(data)
local params={}
local gameYear=data.gameYear
local infoType=data.recordtype
local guid=data.param_1
local dzName=UIDiscipleModel:getDiscipleName(guid)
local dzNameStr=FMT.fmt('<color=#ca631d>{0}</color>',dzName)
if infoType==eZMDailyPaperType.eJingJie then
local jjlv=UIDiscipleModel:getDiscipleJJLevel(guid)
local jjName=UIDiscipleModel:getJJNameEx(jjlv)
params={gameYear,dzNameStr,jjName}
elseif infoType==eZMDailyPaperType.eProSkill then
local proskillId=data.param_2
local curLv=UIDiscipleModel:getDiscipleJobLevel(guid,proskillId)
local proCfg=cfgHelper.get1(cfg_discipleproskillconfig_get,proskillId)
local appellationStr=''
for i,v in ipairs(proCfg.appellation)do
if curLv>=v[1]and curLv<=v[2]then
appellationStr=v[3]
break
end
end
params={gameYear,dzNameStr,proCfg.name,curLv,appellationStr}
elseif infoType==eZMDailyPaperType.eShouYuan then
local shouyuan=UIDiscipleModel:getDiscipleShouYuan(guid)
params={gameYear,dzNameStr,shouyuan}
else
params={gameYear,dzNameStr}
end
return params
end

function UIDailyPaperModel:randomGameYear(left)
local curGameYear=gameUtilityModel.getGameYear()
local offGameYear=gameUtilityModel.calculateGameYearCeil(offlineTime)
local left=left~=nil and left or curGameYear-offGameYear
return math.random(left,curGameYear)
end


function UIDailyPaperModel:calculateJJGameYear(data)
local guid=data.param_1
local netData=UIDiscipleModel:getDiscipleData(guid)
local jjlv=netData.jingjielv
local nxjjexp=cfgHelper.get2(cfg_disciplejingjieconfig_get,jjlv,'exp')
local grow=UIDiscipleModel:calculationJJSecondGrow(guid)
local needTime=math.floor(nxjjexp/grow)
local curGameYear=gameUtilityModel.getGameYear()
local offGameYear=gameUtilityModel.calculateGameYearCeil(offlineTime)
local need=gameUtilityModel.calculateGameYearCeil(needTime)

local name=UIDiscipleModel:getDiscipleName(guid)

return curGameYear-offGameYear+need
end



function UIDailyPaperModel:getReporterDisciple()
local disciples
local postType
if UIDiscipleModel:hasZongMenPost(eZongMenPostType.eZhangMen)then
disciples=UIDiscipleModel:getDiscipleByZongMenPost(eZongMenPostType.eZhangMen)
postType=eZongMenPostType.eZhangMen
elseif UIDiscipleModel:hasZongMenPost(eZongMenPostType.eChuanGong)then
disciples=UIDiscipleModel:getDiscipleByZongMenPost(eZongMenPostType.eChuanGong)
postType=eZongMenPostType.eChuanGong
elseif UIDiscipleModel:hasZongMenPost(eZongMenPostType.eJieYin)then
disciples=UIDiscipleModel:getDiscipleByZongMenPost(eZongMenPostType.eJieYin)
postType=eZongMenPostType.eJieYin
elseif UIDiscipleModel:hasZongMenPost(eZongMenPostType.eJielu)then
disciples=UIDiscipleModel:getDiscipleByZongMenPost(eZongMenPostType.eJielu)
postType=eZongMenPostType.eJielu
elseif UIDiscipleModel:hasZongMenPost(eZongMenPostType.eZhenYu)then
disciples=UIDiscipleModel:getDiscipleByZongMenPost(eZongMenPostType.eZhenYu)
postType=eZongMenPostType.eZhenYu
else
disciples={UIDiscipleModel:getPlotDiscipleByIndex(1)}
end
return disciples and disciples[1]or nil,postType
end



function UIDailyPaperModel:checkMoneyChange(moneyType)
local datas=self:getOfflineDatasByType(eZMDailyPaperType.eMoneyChange)
local changeCount=0
for i,v in ipairs(datas)do
if v.param_1==moneyType then
changeCount=changeCount+v.param_2
end
end
return changeCount
end



local _handleFunc=
{
[eDailyPaperShowEventType.eDiscipleBaiShan]=function(...)
return UIDailyPaperModel.onHandleDiscipleBaiShan(...)
end,
[eDailyPaperShowEventType.eZongmenOptionEvent]=function(...)
return UIDailyPaperModel.onHandleZongmenOptionEvent(...)
end,
[eDailyPaperShowEventType.eBuildingOnFire]=function(...)
return UIDailyPaperModel.onHandleBuildOnFire(...)
end,
[eDailyPaperShowEventType.eMonsterInvasion]=function(...)
return UIDailyPaperModel.onHandleMonsterInvasion(...)
end,
[eDailyPaperShowEventType.eJiQuanBuNing]=function(...)
return UIDailyPaperModel.onHandleJiQuanBuNing(...)
end,
}

function UIDailyPaperModel.handleData(config,outParams)
local descList=config.desc
local rand=math.random(1,#descList)
local formatStr=descList[rand]
local eventType=config.event_type
local func=_handleFunc[eventType]
if func then
func(config,outParams,formatStr)
end

end

function UIDailyPaperModel.onHandleDiscipleBaiShan(config,out,formatStr)
local bsData=shanmenModel:getBaiShanData()
if#bsData>0 then
table.insert(out,{showType=config.event_type,priorty=config.priority,desc=formatStr})
end
end

function UIDailyPaperModel.onHandleZongmenOptionEvent(config,out,formatStr)
local _,num=eventOptionControl.getOptionShowInfo()
if num>0 then
local desc=FMT.fmt(formatStr,num)
table.insert(out,{showType=config.event_type,priorty=config.priority,desc=desc})
end
end

function UIDailyPaperModel.onHandleBuildOnFire(config,out,formatStr)
local hasHandle=emergenciesModel:hasHandleData()
local updateEvent=emergenciesModel:isInEventTime()
if not hasHandle and updateEvent then
local eventType=emergenciesModel:getCurrentEventType()
if eventType==emergenciesType.eBuildingOnFire then
local eventData=emergenciesModel:getEventData()
if eventData then
local bdName=''
local bdList=emergenciesModel:getOnFireBDCfgList()
local sfId=zongmenModel:getMountainId()
for i,v in ipairs(eventData)do
if v.param_1==0 then
local guid=v.param_3
local bdData=zongmenModel:getBuildingData(guid)
if bdData then
bdName=cfgHelper.get2(cfg_monijybuildconfig_get,bdData.build_id,'name')
local desc=FMT.fmt(formatStr,bdName)
table.insert(out,{showType=config.event_type,priorty=config.priority,desc=desc})
break
end
end
end
end
end
end
end

function UIDailyPaperModel.onHandleMonsterInvasion(config,out,formatStr)
local hasHandle=emergenciesModel:hasHandleData()
local updateEvent=emergenciesModel:isInEventTime()
if not hasHandle and updateEvent then
local eventType=emergenciesModel:getCurrentEventType()
if eventType==emergenciesType.eMonsterInvasion then
local eventData=emergenciesModel:getEventData()
if eventData then
table.insert(out,{showType=config.event_type,priorty=config.priority,desc=formatStr})
end
end
end
end
function UIDailyPaperModel.onHandleJiQuanBuNing(config,out,formatStr)
local hasHandle=emergenciesModel:hasHandleData()
local updateEvent=emergenciesModel:isInEventTime()
if not hasHandle and updateEvent then
local eventType=emergenciesModel:getCurrentEventType()
if eventType==emergenciesType.eJiQuanBuNing then
local eventData=emergenciesModel:getEventData()
if eventData then
table.insert(out,{showType=config.event_type,priorty=config.priority,desc=formatStr})
end
end
end
end


function UIDailyPaperModel:initShowEvent()
local list=self.data.showEventList
local config=cfg_zongmendailypapereventconfig()
for i,v in ipairs(config)do
self.handleData(v,list)
end
if#list>0 then
table.sort(list,function(a,b)return a.priorty>b.priorty end)
end
end

function UIDailyPaperModel:getShowEvent()
return self.data.showEventList[1]
end
