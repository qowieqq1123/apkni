






local _MODULENAME="tiandaoshuModel"


def_table(_MODULENAME)
tiandaoshuModel.name=_MODULENAME




































tiandaoshuModel.data={}











tiandaoshuModel.statistics={}

tiandaoshuModel.eFruitStatus={
eLock=1,
eSeal=2,
eNormal=3,
eCountDown=4,
eCompleted=5,
}


function tiandaoshuModel:onAppStart()
tiandaoshuConfig:initVocConfig()
end


function tiandaoshuModel:onEnterState(isReconnect)

end


function tiandaoshuModel:onLeaveState(isReconnect)

self.data={}
self.statistics={}
end


function tiandaoshuModel:getAllData()
return self.data
end

function tiandaoshuModel:existData()
return next(self.data)~=nil
end

function tiandaoshuModel:setAllData(serverDatas)
self.data={}
self.statistics={}
if serverDatas then
for vocIdx,vocData in ipairs(serverDatas)do
local voc=vocData.voc
local vocConfig=tiandaoshuConfig:getVocConfig(voc)
local vData={
list={},
count=0,
complete=0,
max=#vocConfig,
}
local vStatistics={}

local stageList=vocData.stageList or{}
for stageIdx,stageData in ipairs(stageList)do
local stage=stageData.stageid
local stageConfig=vocConfig[stage]
local sData={
list={},
count=0,
complete=0,
max=#stageConfig,
}

local fruitList=stageData.fruitList or{}
for fruitIdx,fruitData in ipairs(fruitList)do
local fruitId=fruitData.fruitid
local serverData=fruitData.cnt
local startTime=fruitData.sec
local fruitConfig=stageConfig[fruitId]
local count=serverData>0 and serverData or 0
local max=#fruitConfig.consume
local fData={
id=fruitId,
voc=voc,
stage=stage,
serverData=serverData,
cdTime=startTime,
status=self.eFruitStatus.eLock,
count=count,
max=max,
duration=fruitConfig.cd or 0,
}
fData.status=self:calculateFruitStatus(fData,fruitConfig)

sData.list[fruitId]=fData
sData.count=sData.count+fData.count
sData.complete=sData.complete+(fData.status==self.eFruitStatus.eCompleted and 1 or 0)

if fData.status~=self.eFruitStatus.eSeal and fData.status~=tiandaoshuModel.eFruitStatus.eLock then
local statisticsData=vStatistics[fruitConfig.statisticsType]
if statisticsData==nil then
statisticsData={
count=0,
max=0,
fruits={}
}
vStatistics[fruitConfig.statisticsType]=statisticsData
end
statisticsData.count=statisticsData.count+count
statisticsData.max=statisticsData.max+max
if fData.status~=self.eFruitStatus.eCompleted then
table.insert(statisticsData.fruits,{stage,fruitId})
end
end
end

for fruitId,fruitCfg in ipairs(stageConfig)do
if not sData.list[fruitId]then
local fruitConfig=stageConfig[fruitId]
local max=#fruitConfig.consume
sData.list[fruitId]={
id=fruitId,
voc=voc,
stage=stage,
serverData=-1,
cdTime=0,
status=self.eFruitStatus.eLock,
count=0,
max=#fruitConfig.consume,
duration=fruitConfig.cd or 0,
}
end
end

vData.list[stage]=sData
vData.count=vData.count+sData.count
vData.complete=vData.complete+sData.complete
end
self.data[voc]=vData

self.statistics[voc]=vStatistics
end
end
end

function tiandaoshuModel:calculateFruitStatus(data,cfg,now)
if data.serverData<0 then
if cfg.unseal and#cfg.unseal>0 then
return self.eFruitStatus.eSeal
else
return self.eFruitStatus.eNormal
end
elseif data.serverData>=data.max then
return self.eFruitStatus.eCompleted
elseif data.cdTime>0 then
local nowTime=now or timeHelper.getServerShortTime()
local deltaTime=nowTime-data.cdTime
if deltaTime>=data.duration then
return self.eFruitStatus.eNormal
else
return self.eFruitStatus.eCountDown
end
else
return self.eFruitStatus.eNormal
end
end

function tiandaoshuModel:isVocActive(voc)
return self:getVocData(voc)~=nil
end

function tiandaoshuModel:isStageActive(voc,stage)
return self:getVocData(voc,stage)~=nil
end

function tiandaoshuModel:isFruitActive(voc,stage,id)
local data=self:getFruitData(voc,stage,id)
return data and data.status~=self.eFruitStatus.eLock
end

function tiandaoshuModel:getVocStatistics(voc)
return self.statistics[voc]
end

function tiandaoshuModel:getStatisticsData(voc,statisticsType)
local vocStatistics=self:getVocStatistics(voc)
if vocStatistics then
return vocStatistics[statisticsType]
end
end

function tiandaoshuModel:getVocData(voc)
return self.data[voc]
end

function tiandaoshuModel:getStageData(voc,stage)
local data=self:getVocData(voc)
return data and data.list[stage]or nil
end

function tiandaoshuModel:getFruitData(voc,stage,id)
local data=self:getStageData(voc,stage)
return data and data.list[id]or nil
end

function tiandaoshuModel:getVocStage(voc)
local data=self:getVocData(voc)
return data and#data.list or 0
end

function tiandaoshuModel:findFruits_Status(status,filter)
local list={}
for voc,vocData in ipairs(self.data)do
for stage,stageData in ipairs(vocData.list)do
for fruitId,fruitData in ipairs(stageData.list)do
if fruitData.status==status and(filter==nil or filter(voc,stage,fruitId))then
table.insert(list,fruitData)
end
end
end
end
return list
end

function tiandaoshuModel:findFruits_VocStatus(voc,status,filter)
local list={}
local vocData=self:getVocData(voc)
if vocData then
for stage,stageData in ipairs(vocData.list)do
for fruitId,fruitData in ipairs(stageData.list)do
if fruitData.status==status and(filter==nil or filter(voc,stage,fruitId))then
table.insert(list,fruitData)
end
end
end
end
return list
end

function tiandaoshuModel:findFruitsEx_VocStatus(voc,status,filter)
local list={}
local vocData=self:getVocData(voc)
if vocData then
for stage,stageData in ipairs(vocData.list)do
for fruitId,fruitData in ipairs(stageData.list)do
if table.containsValue(status,fruitData.status)and(filter==nil or filter(voc,stage,fruitId))then
table.insert(list,fruitData)
end
end
end
end
return list
end

function tiandaoshuModel:findAFruit_VocStageStatus(voc,stage,status,filter)
local list={}
local stageData=self:getStageData(voc)
if stageData then
for fruitId,fruitData in ipairs(stageData.list)do
if fruitData.status==status and(filter==nil or filter(voc,stage,fruitId))then
table.insert(list,fruitData)
end
end
end
return list
end

function tiandaoshuModel:findAFruit_Status(status,filter)
for voc,vocData in pairs(self.data)do
for stage,stageData in ipairs(vocData.list)do
for fruitId,fruitData in ipairs(stageData.list)do
if fruitData.status==status and(filter==nil or filter(voc,stage,fruitId))then
return fruitData
end
end
end
end
end

function tiandaoshuModel:findAFruit_VocStatus(voc,status,filter)
local vocData=self:getVocData(voc)
if vocData then
for stage,stageData in ipairs(vocData.list)do
for fruitId,fruitData in ipairs(stageData.list)do
if fruitData.status==status and(filter==nil or filter(voc,stage,fruitId))then
return fruitData
end
end
end
end
end

function tiandaoshuModel:getVocCount(voc)
local num=0
local vocData=self:getVocData(voc)
if vocData then
num=vocData.count
end
return num
end

function tiandaoshuModel:getVocComplete(voc)
local num=0
local vocData=self:getVocData(voc)
if vocData then
num=vocData.complete
end
return num
end

function tiandaoshuModel:getVocStageMax(voc)
local vocData=self:getVocData(voc)
if vocData then
return vocData.max
end
end

function tiandaoshuModel:activeVocData(voc)
local vocConfig=tiandaoshuConfig:getVocConfig(voc)
self.data[voc]={
list={},
count=0,
complete=0,
max=#vocConfig,
}
self.statistics[voc]={}
end

function tiandaoshuModel:activeStageData(voc,stage)
local vocData=self:getVocData(voc)
if vocData then
local stageConfig=tiandaoshuConfig:getStageConfig(voc,stage)
vocData.list[stage]={
list={},
count=0,
complete=0,
max=#stageConfig,
}
else
loggerUtil.logErrFMT("前置职业{0}未激活，无法激活阶级{1}",voc,stage)
end
end

function tiandaoshuModel:initFruitData(voc,stage,fruit)
local stageData=self:getStageData(voc,stage)
if stageData then
local fruitConfig=tiandaoshuConfig:getFruitConfig(voc,stage,fruit)
local fData={
id=fruit,
voc=voc,
stage=stage,
serverData=-1,
cdTime=0,
status=self.eFruitStatus.eLock,
count=0,
max=#fruitConfig.consume,
duration=fruitConfig.cd or 0,
}
stageData.list[fruit]=fData

return fData
else
loggerUtil.logErrFMT("前置阶级{0}-{1}未激活，无法初始化果实{2}",voc,stage,fruit)
end
end

function tiandaoshuModel:activeFruitData(voc,stage,fruit)
local stageData=self:getStageData(voc,stage)
if stageData then
local fruitConfig=tiandaoshuConfig:getFruitConfig(voc,stage,fruit)
local needSeal=fruitConfig.unseal and#fruitConfig.unseal>0 or false
local max=#fruitConfig.consume
local fData={
id=fruit,
voc=voc,
stage=stage,
serverData=needSeal and-1 or 0,
cdTime=0,
status=needSeal and self.eFruitStatus.eSeal or self.eFruitStatus.eNormal,
count=0,
max=max,
duration=fruitConfig.cd or 0,
}
stageData.list[fruit]=fData

local newStatistics=false
if not needSeal then
local statisticsVoc=self:getVocStatistics(voc)
local statisticsType=fruitConfig.statisticsType
local statisticsData=statisticsVoc[statisticsType]
if not statisticsData then
newStatistics=true
statisticsData={
count=0,
max=0,
fruits={}
}
statisticsVoc[statisticsType]=statisticsData
end
statisticsData.max=statisticsData.max+max
table.insert(statisticsData.fruits,{stage,fruit})
end

return fData,newStatistics
else
loggerUtil.logErrFMT("前置阶级{0}-{1}未激活，无法激活果实{2}",voc,stage,fruit)
end
end

function tiandaoshuModel:unsealFruitData(voc,stage,fruit)
local fruitData=self:getFruitData(voc,stage,fruit)
if not fruitData then
fruitData=self:activeFruitData(voc,stage,fruit)
end
fruitData.status=self.eFruitStatus.eNormal
fruitData.serverData=0
fruitData.count=0

local fruitConfig=tiandaoshuConfig:getFruitConfig(voc,stage,fruit)
local max=fruitData.max
local statisticsVoc=self:getVocStatistics(voc)
local statisticsType=fruitConfig.statisticsType
local statisticsData=statisticsVoc[statisticsType]
local newStatistics=false
if not statisticsData then
newStatistics=true
statisticsData={
count=0,
max=0,
fruits={},
}
statisticsVoc[statisticsType]=statisticsData
end
statisticsData.max=statisticsData.max+max
table.insert(statisticsData.fruits,{stage,fruit})
return fruitData,newStatistics
end

function tiandaoshuModel:setFruitCount(voc,stage,fruit,count,time,now)
local fruitData=self:getFruitData(voc,stage,fruit)or self:activeFruitData(voc,stage,fruit)
if not fruitData then
loggerUtil.logErrFMT("果实{0}-{1}-{2}设置数据失败",voc,stage,fruit)
return
end

local nowTime=now or timeHelper.getServerShortTime()
local startTime=time or nowTime
local dCount=count-fruitData.count
local dComplete=0
if count>=fruitData.max and fruitData.count<fruitData.max then
dComplete=1
elseif fruitData.count>=fruitData.max and count<fruitData.max then
dComplete=-1
end

fruitData.serverData=count
fruitData.count=count
fruitData.cdTime=startTime
if fruitData.count>=fruitData.max then
fruitData.status=self.eFruitStatus.eCompleted
elseif(fruitData.cdTime+fruitData.duration)>nowTime then
fruitData.status=self.eFruitStatus.eCountDown
else
fruitData.status=self.eFruitStatus.eNormal
end

local stageData=self:getStageData(voc,stage)
stageData.count=stageData.count+dCount
stageData.complete=stageData.complete+dComplete

local vocData=self:getVocData(voc)
vocData.count=vocData.count+dCount
vocData.complete=vocData.complete+dComplete

local statisticsVoc=self:getVocStatistics(voc)
local fruitConfig=tiandaoshuConfig:getFruitConfig(voc,stage,fruit)
local statisticsType=fruitConfig.statisticsType
local statisticsData=statisticsVoc[statisticsType]
statisticsData.count=statisticsData.count+dCount
if fruitData.status==self.eFruitStatus.eCompleted then
local cnt=#statisticsData.fruits
for i=cnt,1,-1 do
local v=statisticsData.fruits[i]
if v[1]==stage and v[2]==fruit then
table.remove(statisticsData.fruits,i)
break
end
end
end
return fruitData,dComplete,dCount
end

function tiandaoshuModel:getMaxStage()
local max=0
for voc,vocData in pairs(self.data)do
local curStage=#vocData.list
max=math.max(max,curStage)
end
return max
end

function tiandaoshuModel:getVocReddot(voc)
local cnt=UIDiscipleModel:getDiscipleJobCount(voc)
if cnt>0 then
return not self:isVocActive(voc)
end
return false
end

function tiandaoshuModel:getReddot()
local disciples=UIDiscipleModel:getAllDiscipleData()
local jobs={}
for i,v in pairs(disciples)do
local netData=v.netData.net
local imageInfo=UIDiscipleModel:getDiscipleImageInfo(netData.discipleguid)
if not jobs[imageInfo.job]then
jobs[imageInfo.job]=true
end
end
for i,v in pairs(jobs)do
if not self:isVocActive(i)then
return true
end
end
return false
end

function tiandaoshuModel:checkFruitCost(voc,stage,fruit)
local fruitConfig=tiandaoshuConfig:getFruitConfig(voc,stage,fruit)
local fruitData=tiandaoshuModel:getFruitData(voc,stage,fruit)
local costList=fruitConfig.consume[fruitData.count+1]
for i,v in ipairs(costList)do
local itemId=v[1]
local itemCount=v[2]
local haveCount=itemsModel.getCount(itemId)
if itemCount>haveCount then
return false
end
end
return true
end

function tiandaoshuModel:getStatisticsFruitsCostItems(voc,statisticsType)
local statisticsData=self:getStatisticsData(voc,statisticsType)
local list={}
if statisticsData then
for i,v in ipairs(statisticsData.fruits)do
local stage=v[1]
local fruit=v[2]
local fruitConfig=tiandaoshuConfig:getFruitConfig(voc,stage,fruit)
local fruitData=tiandaoshuModel:getFruitData(voc,stage,fruit)
local costList=fruitConfig.consume[fruitData.count+1]
for i,v in ipairs(costList)do
list[v[1]]=true
end
end
end
return list
end

function tiandaoshuModel:getStatisticsTypeReddot(voc,statisticsType)
local statisticsData=self:getStatisticsData(voc,statisticsType)
if statisticsData then
for i,v in ipairs(statisticsData.fruits)do
if tiandaoshuModel:checkFruitCost(voc,v[1],v[2])then
return true
end
end
end
return false
end

function tiandaoshuModel:getStatisticsVocReddot(voc)
local vocData=self:getVocStatistics(voc)
if vocData then
for statisticsType,statisticsData in pairs(vocData)do
if self:getStatisticsTypeReddot(voc,statisticsType)then
return true
end
end
end
return false
end

function tiandaoshuModel:caculateReturnItemDataList(voc,itemReturnPer,moneyReturnPer,moneyDiscountList,exchangeList)
local vocData=tiandaoshuModel:getVocData(voc)
local consumeList={}

for stageIndex,stageData in ipairs(vocData.list or{})do
for fruitIndex,fruitData in ipairs(stageData.list or{})do
if fruitData.count>0 then
local fruitCfg=tiandaoshuConfig:getFruitConfig(fruitData.voc,fruitData.stage,fruitData.id)
for count=1,fruitData.count do
local countConsumeList=fruitCfg.consume[count]
for _,consumeData in ipairs(countConsumeList)do
local itemId=consumeData[1]
local itemNum=consumeData[2]
if consumeList[itemId]==nil then
consumeList[itemId]=0
end
consumeList[itemId]=consumeList[itemId]+itemNum
end
end
end
end
end

local temp={}
for id,itemnum in pairs(consumeList)do
local rate
if itemsConfig.isMoney(id)then
if moneyDiscountList[id]~=nil then
rate=moneyDiscountList[id]/100
else
rate=moneyReturnPer/100
end
else
rate=itemReturnPer/100
end
local itemcount=Mathf.Floor(itemnum*rate+0.000001)

temp[id]={itemid=id,itemcount=itemcount}
end


for moneyid,exchangeWayList in pairs(exchangeList or{})do
if temp[moneyid]~=nil then
local itemdata=temp[moneyid]
for exIndex,way in ipairs(exchangeWayList or{})do
local exNumLimit=way[1]
local exNum=way[2]
local exItemratio=way[3]
if itemdata.itemcount>=exNumLimit then
local exCount=Mathf.Floor((itemdata.itemcount/exNum)+0.00000001)
exCount=exCount*exItemratio[2]
table.insert(temp,{itemid=exItemratio[1],itemcount=exCount})
itemdata.itemcount=0
break
end
end
end
end

local temp2={}
for k,itemData in pairs(temp)do
if itemData.itemcount>0 then
table.insert(temp2,itemData)
end
end

table.sort(temp2,function(a,b)
return a.itemid>b.itemid
end)

return temp2
end


