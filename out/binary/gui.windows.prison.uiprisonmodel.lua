
UIPrisonModel={}

ePrisonRoomType={
eDisciple=1,
eMonster=2,
}

function UIPrisonModel:onEnterState(...)
self.data={}
self.data.cellData={}
self:initLanguage()

self.shenWenList=
{
[1]=nil,
[2]=nil,
[3]=nil,
[4]=nil,
}
self.shenWenStateList={}

self.serialList={}
end

function UIPrisonModel:onLeaveState(...)
self.data={}
self.data.cellData={}
self:clearLanguage()

self.shenWenList=nil
self.shenWenStateList=nil
end

function UIPrisonModel:setOnePrisonData(datas)
if datas then
if datas.yyTime>0 then
datas.yyTime=math.max(datas.swEndTime,datas.yyTime)
end
if datas.swEndTime>0 then
self.data.sw=true
end
local lfId=datas.lfConfId
self.data.cellData[lfId]=datas
self.serialList[lfId]=datas.xtzmSerial
self.shenWenList[lfId]=tostring(datas.dzGuidShenWen)
end
end

function UIPrisonModel:setPrisonData(datas)
local cellData={}
if datas then
for i,v in ipairs(datas)do
if v.yyTime>0 then
v.yyTime=math.max(v.swEndTime,v.yyTime)
end
if v.swEndTime>0 then
self.data.sw=true
end
local lfId=v.lfConfId
local lytype=cfgHelper.get2(cfg_laofangconfig_get,lfId,"lytype")
v.lytype=lytype
cellData[lfId]=v
self.serialList[lfId]=v.xtzmSerial
end
end
self.data.cellData=cellData

for lfId,v in pairs(cellData)do
self.shenWenList[lfId]=tostring(v.dzGuidShenWen)

end
end

function UIPrisonModel:getAllPrisonData()
return self.data.cellData
end

function UIPrisonModel:getPrisonData(lfId)
return self.data.cellData[lfId]
end

function UIPrisonModel:setYueyu(lfId)
local data=self.data.cellData[lfId]
data.fuluGuid=0

UIPrisonModel:setShenWenState(lfId,tostring(0))
end

function UIPrisonModel:unlockCell(lfId)
local lfdata={}
lfdata.lfConfId=lfId
lfdata.fuluGuid=0
lfdata.dzGuidShenWen=0
lfdata.swEndTime=0
lfdata.yyTime=0
lfdata.zmNum=0
self.data.cellData[lfId]=lfdata
end

function UIPrisonModel:getShenWenTime(lfId)
local data=self.data.cellData[lfId]
return data.swEndTime
end

function UIPrisonModel:setHandInCaptive(lfId)
local data=self.data.cellData[lfId]
data.fuluGuid=0
end

function UIPrisonModel:setInterrogate(lfId,guid,time)
local data=self.data.cellData[lfId]
data.dzGuidShenWen=guid
data.swEndTime=time
if data.yyTime>0 then
data.yyTime=math.max(time,data.yyTime)
end
self.data.sw=true

UIPrisonModel:setShenWenState(lfId,tostring(guid))
end

function UIPrisonModel:finishInterrogate(lfId)
local data=self.data.cellData[lfId]

data.dzGuidShenWen=0
data.swEndTime=0
data.swNum=data.swNum+1

data.swFinish=false
self.data.sw=nil

UIPrisonModel:setShenWenState(lfId,tostring(0))
end

function UIPrisonModel:setRecruit(lfId,success)
local data=self.data.cellData[lfId]
if success then
data.fuluGuid=0
end
data.zmNum=data.zmNum+1
end

function UIPrisonModel:setFreed(lfId)
local data=self.data.cellData[lfId]
data.fuluGuid=0
end

function UIPrisonModel:setSuppress(lfId)
local data=self.data.cellData[lfId]
data.fuluGuid=0
end

function UIPrisonModel:hasShenWen()
return self.data.sw~=nil
end

function UIPrisonModel:setLogs(logs)
self.data.logs=logs or{}
end

function UIPrisonModel:getLogs()
return self.data.logs
end

function UIPrisonModel:isCanGetReward()
if self.data.cellData==nil then return false end
local stime=gameUtilityModel.getServerShortTime()
for k,v in pairs(self.data.cellData)do
if tostring(v.fuluGuid)~='0'and v.swEndTime>0 and stime>=v.swEndTime then
return true
end
end
return false
end

function UIPrisonModel:existEmptyRoom(type)
for lfId,lfData in pairs(self.data.cellData)do
local lytype=cfgHelper.get2(cfg_laofangconfig_get,lfData.lfConfId,"lytype")
if(type==nil or type==lytype)and tostring(lfData.fuluGuid)=='0'then
return true
end
end
return false
end

function UIPrisonModel:getEmptyRoomNum(type)
local _count=0
for lfId,lfData in pairs(self.data.cellData)do
local lytype=cfgHelper.get2(cfg_laofangconfig_get,lfData.lfConfId,"lytype")
if(type==nil or type==lytype)and tostring(lfData.fuluGuid)=='0'then
_count=_count+1
end
end
return _count
end

function UIPrisonModel:checkEmptyRoomNum(type,count)
local _count=self:getEmptyRoomNum(type)
return _count>=count
end

function UIPrisonModel:initLanguage()
local cfg=cfg_laoyubaseconfig_get(1)

self.sflibrary=cfg.sflibrary
self.fzlibrary=cfg.fzlibrary
self.zmlibrary=cfg.zmlibrary
self.jylibrary=cfg.jylibrary
end

function UIPrisonModel:clearLanguage()
self.sflibrary=nil
self.fzlibrary=nil
self.zmlibrary=nil
self.jylibrary=nil
end

function UIPrisonModel:randomLanguage(type,layer)
local len=0
if type==1 then
len=#self.sflibrary
local index=math.random(1,len)
return self.sflibrary[index][1]
elseif type==2 then
len=#self.fzlibrary
local index=math.random(1,len)
return self.fzlibrary[index][1]
elseif type==3 then
len=#self.zmlibrary
local index=math.random(1,len)
return self.zmlibrary[index][1]
elseif type==4 and layer then
len=#self.jylibrary[layer]
local index=math.random(1,len)
return self.jylibrary[layer][index]
end
end


function UIPrisonModel:checkCanShenWen()
local canSW=false
local cfgs=cfg_laofangconfig()
local list={}
local stime=gameUtilityModel.getServerShortTime()
for i,v in ipairs(cfgs)do
local pd=UIPrisonModel:getPrisonData(v.id)
local swstate=0
if pd and pd.swEndTime>0 then
swstate=pd.swEndTime<stime and 2 or 1
end
table.insert(list,{cfg=v,data=pd,isUnlock=pd~=nil,swstate=swstate})
end

if#list>0 then
for k,v in ipairs(list)do
if v.data and v.swstate==0 and v.data.yyTime and v.data.yyTime~=0 and v.data.swNum and v.data.swNum<=0 then
canSW=true
break
end
end



end

return canSW
end


function UIPrisonModel:checkFinishShenWen()
local finishSW=false
local cfgs=cfg_laofangconfig()
local list={}
local stime=gameUtilityModel.getServerShortTime()
for i,v in ipairs(cfgs)do
local pd=UIPrisonModel:getPrisonData(v.id)
local swstate=0
if pd and pd.swEndTime>0 then
swstate=pd.swEndTime<stime and 2 or 1
end
table.insert(list,{cfg=v,data=pd,isUnlock=pd~=nil,swstate=swstate})
end
if#list>0 then
for k,v in ipairs(list)do
if v.data and v.swstate==2 and v.data.yyTime and v.data.yyTime~=0 then
finishSW=true
break
end
end
end

return finishSW
end


function UIPrisonModel:getSiXuSpeciality()
local havenum=0
local maxnum=0
local specialityType=DISCIPLE_SPECIALITY_TYPE.eXX
local disciplesList=discipleLookup:getSortDiscipleList()
local const_def=cfg_disciplespetype6config().const_def
if const_def and const_def.disciplenum and const_def.disciplenum[1]then
maxnum=const_def.disciplenum[1]
end
for i,v in ipairs(disciplesList)do
local netdata=v.netData.net
local len=UIDiscipleModel:getDiscipleSpecialityLen(netdata,specialityType)
if len>0 then
havenum=havenum+1
end
end
return maxnum,havenum
end

function UIPrisonModel:setInfoIndex(index)
if not self.showInfoIndex then
self.showInfoIndex=nil
end
self.showInfoIndex=index
end

function UIPrisonModel:getInfoIndex()
if not self.showInfoIndex then
self.showInfoIndex=nil
end

return self.showInfoIndex
end

function UIPrisonModel:setShenWenState(index,value)
self.shenWenList[index]=value
UIPrisonModel:setshenWenStateList()

end

function UIPrisonModel:getShenWenState(index)
return self.shenWenList[index]
end

function UIPrisonModel:getshenWenStateList()
return self.shenWenStateList
end

function UIPrisonModel:setshenWenStateList()
self.shenWenStateList={}
for k,v in ipairs(self.shenWenList)do
if tonumber(v)>0 then
local name=UIDiscipleModel:getDiscipleData(v).disciplename
self.shenWenStateList[name]=true
end
end

end

function UIPrisonModel:getserialListByIndex(index)
return self.serialList[index]
end

function UIPrisonModel:setserialListByIndex(index,value)
self.serialList[index]=value
end



function UIPrisonModel:setMoYuLockState(value)
if value==1 then
self.MoYuUnLock=true
else
self.MoYuUnLock=false
end
end

function UIPrisonModel:getMoYuLockState()
return self.MoYuUnLock
end

function UIPrisonModel:getMoYuLockReddotState()
local cfg=cfg_laoyubaseconfig_get(1)
local cost=cfg.moyuUnlock

if cost and cost[2]then
local costs=cost[2]
local limitLv=cost[1]
local lv=zongmenModel:getLevel()
if lv<limitLv then return false end

for i,v in ipairs(costs)do
local itemId=v[1]
local itemCount=v[2]
local have
if moneyConfig.isMoney(itemId)then
have=moneyModel.getMoney(itemId)
else
have=bagModel.getItemCountById(itemId)
end
if have<itemCount then
return false
end
end
return true
end
return false
end

function UIPrisonModel:getJYReward(stage,layer)
local baseCfg=cfg_laoyubaseconfig_get(1)
local jyCfg=baseCfg.sjjy
local cost=jyCfg[layer]

for k,v in ipairs(cost)do
local minStage=v[1]
local maxStage=v[2]

if stage>=minStage and stage<=maxStage then
return v[3]
end
end
end

function UIPrisonModel:showText(itemList)
local text=nil
for k,v in ipairs(itemList)do
if v then
local itemConfig=itemsConfig.getConfig(v[1])
local str=string.format("%s * %s ",itemConfig.name,v[2])
if not text then
text=str
else
text=string.format("%s%s",text,str)
end
end
end

return text
end

function UIPrisonModel:setJyCount(value,falg)
if falg then
self.jyCount=value
else
self.jyCount=self.jyCount+value
end
notifySystem:postNotify(notifyConfig.onJyCountChange)
end

function UIPrisonModel:getJyCount()
return self.jyCount or 0
end

function UIPrisonModel:getStateData()
local cfgs=cfg_laofangconfig()
local list={}
local stime=gameUtilityModel.getServerShortTime()

for i,v in ipairs(cfgs)do
local pd=self:getPrisonData(v.id)
local swstate=0
if pd and pd.swEndTime>0 then
swstate=pd.swEndTime<stime and 2 or 1
end
table.insert(list,{cfg=v,data=pd,isUnlock=pd~=nil,swstate=swstate})
end

return list
end

function UIPrisonModel:isFirstOpenMoyu()
return userActorSetting.get('isFirstOpenMoyu',false)
end

function UIPrisonModel:saveOpenMoyuState(isOpened)
userActorSetting.set('isFirstOpenMoyu',isOpened)
userActorSetting.flush()
end