UIRecruitModel={}

function UIRecruitModel:onEnterState(...)
self.data={}
self:loadWatchRecord()
notifySystem:listenNotify(notifyConfig.on_money_changed,self.on_money_change)
notifySystem:listenNotify(notifyConfig.building_event,self.on_building_event)
end

function UIRecruitModel:onLeaveState(...)
self.data={}
self.severPosList=nil
self.severGuidList=nil
notifySystem:removelistener(notifyConfig.on_money_changed,self.on_money_change)
notifySystem:removelistener(notifyConfig.building_event,self.on_building_event)
end

function UIRecruitModel:setRecruitData(times,lasttime,len,arr,jzlen,jzarr,roundTimes)
local recruitData={}
recruitData.times=times
recruitData.lastTime=lasttime;

local recruitCountDict={}
for i,v in ipairs(roundTimes)do
recruitCountDict[v.param_1]=v.param_2
end
recruitData.recruitCountDict=recruitCountDict
recruitData.discipleData={}
if len>0 then
for i,v in ipairs(arr)do
local guid=tostring(v.discipleInfo.discipleguid)
UIDiscipleModel:addDiscipleDataTemp(v.discipleInfo)
recruitData.discipleData[guid]=v
end
end
self.data.recruitData=recruitData
local familyData={}
if jzlen>0 then
for i,v in ipairs(jzarr)do
v.state=0
familyData[tostring(v.familyid)]=v
if v.discipleInfo then
UIDiscipleModel:addDiscipleDataTemp(v.discipleInfo)
end
end
end
self.data.familyData=familyData
end

function UIRecruitModel:hasRecruitData()
return self.data.recruitData~=nil
end

function UIRecruitModel:getAllFamilyData()
return self.data.familyData
end

function UIRecruitModel:setFamilyData(data)
data.state=0
self.data.familyData[tostring(data.familyid)]=data
if data.discipleInfo then
UIDiscipleModel:addDiscipleDataTemp(data.discipleInfo)
end
self:setWatchRecord(data.familyid)
self:saveWatchRecord()
end

function UIRecruitModel:getFamilyData(fId)
return self.data.familyData and self.data.familyData[tostring(fId)]or nil
end

function UIRecruitModel:setFamilyDiscipleState(fId,guid,state)
local data=self:getFamilyData(fId)
if data then
data.state=state
end
end

function UIRecruitModel:getFamilyDataState()
local datas=self:getAllFamilyData()
local list={}
for k,v in pairs(datas)do
if v.state==0 then
list[v.pos]=v
end
end
local stime=gameUtilityModel.getServerShortTime()
for k,v in pairs(list)do
if stime>=v.endtime then
return 2
end
end
local k,v=next(list)
local check=worldXiuZhenJiaZuModel:isHaveFamilyData()
if not k and not check then
return 0
end
if check and#list<3 then
return 1
end
local dt
for k,v in pairs(list)do
local ct=v.endtime-stime
if not dt or ct<dt then
dt=ct
end
end
return 3,dt
end


function UIRecruitModel:chekHaveAnPai()
local datas=self:getAllFamilyData()
local num=0
for k,v in pairs(datas)do
if v.state==0 then
num=num+1
end
end
return num>0
end


function UIRecruitModel:checkFamilyReddot()

local stime=gameUtilityModel.getServerShortTime()
local allData=UIRecruitModel:getAllFamilyData()
local count=0
if allData then
for _,v in pairs(allData)do
if v.state~=0 then
count=count+1
elseif stime>=v.endtime then
return true
end
end
end
if count<=3 then

local level=zongmenModel:getLevel()
local datas=worldXiuZhenJiaZuModel:getAllSelfFamilyData()
for _,data in ipairs(datas)do
local reddot=false

local jzData=UIRecruitModel:getFamilyData(data.familyId)

if jzData==nil or(jzData and jzData.state~=0)then
local cfg=cfgHelper.get1(cfg_xiuzhenfamilydataconfig_get,data.familyId)
local ciTiaoList=cfg.voc_citiao
for _,v in ipairs(ciTiaoList)do
local jycfg=cfgHelper.get1(cfg_disciplevocationconfig_get,v)
if not reddot and level>=jycfg.level then
reddot=true
end
end
end

if reddot then
local index=worldXiuZhenJiaZuModel:getFamilyScaleData(data.guid)
local cfg=cfgHelper.get1(cfg_yinxiantaijzscaleconfig_get,index)
for _,v in ipairs(cfg.consume)do
local have=moneyModel.getMoney(v[1])
if have<v[2]then
reddot=false
end
end
end
if reddot then
return true
end
end
end
return false
end


function UIRecruitModel:checkFamilyReddot2()

local stime=gameUtilityModel.getServerShortTime()
local allData=UIRecruitModel:getAllFamilyData()
local count=0
if allData then
for _,v in pairs(allData)do
if v.state~=0 then
count=count+1
end
end
end
if count<=3 then

local level=zongmenModel:getLevel()
local datas=worldXiuZhenJiaZuModel:getAllSelfFamilyData()
for _,data in ipairs(datas)do
local reddot=false

local jzData=UIRecruitModel:getFamilyData(data.familyId)

if jzData==nil or(jzData and jzData.state~=0)then
local cfg=cfgHelper.get1(cfg_xiuzhenfamilydataconfig_get,data.familyId)
local ciTiaoList=cfg.voc_citiao
for _,v in ipairs(ciTiaoList)do
local jycfg=cfgHelper.get1(cfg_disciplevocationconfig_get,v)
if not reddot and level>=jycfg.level then
reddot=true
end
end
end

if reddot then
local index=worldXiuZhenJiaZuModel:getFamilyScaleData(data.guid)
local cfg=cfgHelper.get1(cfg_yinxiantaijzscaleconfig_get,index)
for _,v in ipairs(cfg.consume)do
local have=moneyModel.getMoney(v[1])
if have<v[2]then
reddot=false
end
end
end
if reddot then
return true
end
end
end
return false
end


function UIRecruitModel:checkFamilyReddot3()
local allData=UIRecruitModel:getAllFamilyData()
if allData then
local stime=gameUtilityModel.getServerShortTime()
for _,v in pairs(allData)do
if v.state==0 and stime>=v.endtime then
return true
end
end
end
return false
end

function UIRecruitModel:getFamilyMinEndTime()
local allData=UIRecruitModel:getAllFamilyData()
local endtime=0
if allData then
for k,v in pairs(allData)do
if v.state==0 and endtime<v.endtime then
endtime=v.endtime
end
end
end
return endtime
end

function UIRecruitModel:isCanNormalRecruit()
if not UIRecruitModel:hasRecruitData()then
return false
end
local times=UIRecruitModel:getRecruitTimes()
if times>0 then
return true
end

local def=cfgHelper.getdef(cfg_yinxiantaizmconfig)
local itemId=def.itemid
local itemCount=bagModel.getItemCountById(itemId)
if itemCount>0 then
return true
end

return false
end

function UIRecruitModel:checkHaveZhaoMuZhong()
local allData=UIRecruitModel:getAllFamilyData()
if allData then
for _,v in pairs(allData)do
if v.state==0 then
return true
end
end
end
end

function UIRecruitModel:setRecruitTimes(times,lasttime)
local recruitData=self.data.recruitData
recruitData.times=times;
recruitData.lastTime=lasttime
end

function UIRecruitModel:setRecruitDisciple(way,len,arr,roundTimes)
local recruitData=self.data.recruitData
recruitData.discipleData={}
if len>0 then
for i,v in ipairs(arr)do
if v.state==0 then
local guid=tostring(v.discipleInfo.discipleguid)
UIDiscipleModel:addDiscipleDataTemp(v.discipleInfo)
recruitData.discipleData[guid]=v
end
end
end
if way==0 then
recruitData.times=recruitData.times-1
end

local recruitCountDict={}
for i,v in ipairs(roundTimes)do
recruitCountDict[v.param_1]=v.param_2
end
recruitData.recruitCountDict=recruitCountDict
end

function UIRecruitModel:getRecruitDisciple()
return self.data.recruitData.discipleData
end

function UIRecruitModel:removeRecruitDisciple(guid)
self.data.recruitData.discipleData[tostring(guid)]=nil
end

function UIRecruitModel:setRecruitState(guid,state)
self.data.recruitData.discipleData[tostring(guid)].state=state
end

function UIRecruitModel:getRecruitDiscipleCount()
local count=0
for i,v in pairs(self.data.recruitData.discipleData)do
if v.state==0 then
count=count+1
end
end
return count
end

function UIRecruitModel:getRecruitTimes()
return self.data.recruitData.times
end

function UIRecruitModel:getRecruitLastTime()
return self.data.recruitData.lastTime
end

function UIRecruitModel:getRecruitData()
return self.data.recruitData
end

function UIRecruitModel:getRecruitCount(color)

return self.data.recruitData.recruitCountDict[color]
end


function UIRecruitModel:getWatchRecord(fId)
return self.data.watchRecord[tostring(fId)]==true
end

function UIRecruitModel:setWatchRecord(fId,state)
self.data.watchRecord[tostring(fId)]=state
end

function UIRecruitModel:loadWatchRecord()
local datas=userActorSetting.get('watchRecord',{})
self.data.watchRecord=datas
end

function UIRecruitModel:saveWatchRecord()
userActorSetting.set('watchRecord',self.data.watchRecord)
userActorSetting.flush()
end


function UIRecruitModel:initFamilyNeedCost()
self.data.cost={}
local datas=worldXiuZhenJiaZuModel:getAllSelfFamilyData()
for _,data in ipairs(datas)do
local index=worldXiuZhenJiaZuModel:getFamilyScaleData(data.guid)
local cfg=cfgHelper.get1(cfg_yinxiantaijzscaleconfig_get,index)
for _,v in ipairs(cfg.consume)do
self.data.cost[v[1]]=v[2]
end
end
end

function UIRecruitModel.on_money_change(moneyType,lastVal,val)
if UIRecruitModel.data and UIRecruitModel.data.cost then
local needRefresh=UIRecruitModel.data.cost[moneyType]
if needRefresh then
UIRecruitControl.refreshBuildHud()
end
end
end

function UIRecruitModel.on_building_event(etype,level,exp,lastLv)
if etype==buildingEvent.zongmenLevelUp then
UIRecruitControl.refreshBuildHud()
end
end

function UIRecruitModel:getZongMenPeopleMax()
local level=zongmenModel:getLevel()
return cfgHelper.get2(cfg_guildexpconfig_get,level,'dizi_max_cnt')
end

function UIRecruitModel:checkZongMenPeopleMax()
local maxDzCount=UIRecruitModel:getZongMenPeopleMax()
local curDzCount=UIDiscipleModel:checkDiscipleCount()
return curDzCount>=maxDzCount
end

function UIRecruitModel:getDisciplesMaxPinZhi(list)
local maxColor=0
for i,v in ipairs(list)do
local info=self:GetDiscipleImageInfo(v.discipleInfo)
if info.color>maxColor then
maxColor=info.color
end
end
return maxColor
end

function UIRecruitModel:GetDiscipleImageInfo(data)
if not data.imageInfo then
data.imageInfo=UIDiscipleModel.calculationDiscipleImageBase(data)
end
return data.imageInfo
end


function UIRecruitModel:addShowRecruitDiscipleQueue(discipleGuid,item)
if not self.data.itemRecruitShowQueueData then
self.data.itemRecruitShowQueueData=queue.New()
end

self.data.itemRecruitShowQueueData:enqueue({guid=discipleGuid,itemId=item})
end


function UIRecruitModel:pushShowRecruitDiscipleQueue()
if not self.data.itemRecruitShowQueueData then
return nil
end

local data=self.data.itemRecruitShowQueueData:dequeue()
if self.data.itemRecruitShowQueueData:isEmpty()then

self.data.itemRecruitShowQueueData:clear()
end

return data
end


function UIRecruitModel:getShowRecruitDiscipleQueueSize()
if not self.data.itemRecruitShowQueueData then
return 0
end

return self.data.itemRecruitShowQueueData:size()
end


function UIRecruitModel:setItemRecruitDiscipleWindowState(flag)
self.data.itemRecruitDiscipleWindowState=flag
end


function UIRecruitModel:getShowRecruitDiscipleWindowState()
if not self.data.itemRecruitDiscipleWindowState then
return false
end

return self.data.itemRecruitDiscipleWindowState
end

function UIRecruitModel:setDzSeverPos(data)
if not self.severPosList then
self.severGuidList={}
self.severPosList={[1]=-1,[2]=-1,[3]=-1}
end

if data then
for k,v in ipairs(data)do
local pos=v.pos
local temp=v.discipleInfo

if pos then self.severPosList[pos]=k end
if temp then
local guid=temp.discipleguid
local guidStr=tostring(guid)
self.severGuidList[guidStr]=pos
end
end
end
end

function UIRecruitModel:getDzSeverPos(pos)
if self.severPosList then
return self.severPosList[pos]
end
end

function UIRecruitModel:getDzSeverGuid(guid)
local guidStr=tostring(guid)

if self.severPosList then
return self.severGuidList[guidStr]
end
end

function UIRecruitModel:checkAndResetPos(guid)

local pos=self:getDzSeverGuid(guid)
local index=self:getDzSeverPos(pos)
if pos and index then
self.severPosList[pos]=-1
end

for k,v in ipairs(self.severPosList)do

if v and v>index then
local guidStr=tostring(guid)
self.severPosList[k]=v-1
self.severGuidList[guidStr]=nil
end
end


end