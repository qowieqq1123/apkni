






local _MODULENAME="chuanSongZhenModel"




def_table(_MODULENAME)
chuanSongZhenModel.name=_MODULENAME


chuanSongZhenModel.data={}
chuanSongZhenModel.record={}
chuanSongZhenModel.time={}
chuanSongZhenModel.flag={}
chuanSongZhenModel.rewardInfo=nil
local _listenMoney={}
local _record_max=20


function chuanSongZhenModel:onAppStart()
local cfg=cfgHelper.get1(cfg_monijybuilduplvlconfig_get,SLG_SYSTEM_TYPE.eChuanSongZhen)
for level,config in ipairs(cfg)do
if level>1 then
for i,v in ipairs(config.uplevel_cost)do
local moneyType=v[1]
table.checkCreateSubTable(_listenMoney,{moneyType})
table.insert(_listenMoney[moneyType],level-1)
end
end
end
end


function chuanSongZhenModel:onEnterState(isReconnect)
chuanSongZhenModel:loadEventData()
chuanSongZhenModel:loadTimeData()
end


function chuanSongZhenModel:onLeaveState(isReconnect)

self.data={}
self.flag={}
self.record={}
self.time={}
end



function chuanSongZhenModel:checkDiscipleChuiWei()
local list={}
for i,v in pairs(self.data)do
for j,w in pairs(v.current)do
local discipleGuid=w.disciple
if UIDiscipleModel:checkDiscipleState2(discipleGuid,DISCIPLE_STATE_TYPE.eChuiWei)then
table.insert(list,{i,discipleGuid})
end
end
end
return list
end

function chuanSongZhenModel:setDatas(list)
self.data={}
self.flag={}
for i,v in ipairs(list or{})do
self:setData(v)
self:setFlag(v)
end
for i,v in ipairs(cfg_worldtravelconfig())do
local data=self:getData(v.id)
local flag=self:getFlag(v.id)
if not data then
self.data[v.id]={
world=v.id,
current={},
pass={},
}
end
if not flag then
self.flag[v.id]=0
end
end
end

function chuanSongZhenModel:getFlag(world)
return self.flag[world]
end

function chuanSongZhenModel:getFlagBit(world,block)
local flag=self:getFlag(world)
return mathHelper.getBitValue(flag,block-1)
end

function chuanSongZhenModel:setFlagBit(world,block)
self.flag[world]=mathHelper.setbit(self.flag[world],block-1)
end

function chuanSongZhenModel:checkAllFlag(world)
local wCfg=cfgHelper.get1(cfg_worldblocktransportconfig_get,world)
local flag=self:getFlag(world)
for block,config in pairs(wCfg)do
if not mathHelper.getBitValue(flag,block-1)then
return false
end
end
return true
end

function chuanSongZhenModel:countFlagBit(world)
local wCfg=cfgHelper.get1(cfg_worldblocktransportconfig_get,world)
local flag=self:getFlag(world)
local count=0
for block,config in pairs(wCfg)do
if mathHelper.getBitValue(flag,block-1)then
count=count+1
end
end
return count
end

function chuanSongZhenModel:setFlag(data)
self.flag[data.worldid]=data.flag
end

function chuanSongZhenModel:setData(data)
local current={}
if data.datalistlen>0 then
for j,w in ipairs(data.dataList)do
table.insert(current,{disciple=w.discipleguid,money=w.moneysec,item=w.itemsec,dead=w.dyingsec})
end
end
local pass={}
if data.durationlistlen>0 then
for i,v in ipairs(data.durationList)do
table.insert(pass,{money=v.param_1,item=v.param_1})
end
end
self.data[data.worldid]={
world=data.worldid,
current=current,
pass=pass,
}
end

function chuanSongZhenModel:startData(world,disciple,time)
local data=self:getData(world)
if data then
for i,v in ipairs(data.current)do
if v.disciple==disciple then
v.begintime=time
return i
end
end
table.insert(data.current,{disciple=disciple,money=time,item=time,dead=0})
return#data.current
else
local current={}
table.insert(current,{disciple=disciple,money=time,item=time,dead=0})
self.data[world]={
world=data.worldid,
current=current,
pass={},
}
return#current
end
end

function chuanSongZhenModel:endData(world,index,moneyduration,itemduration)
local data=self:getData(world)
if data then
table.remove(data.current,index)
table.insert(data.pass,{money=moneyduration,item=itemduration})
end
end

function chuanSongZhenModel:getData(world)
return self.data[world]
end

function chuanSongZhenModel:getDatas()
return self.data
end

function chuanSongZhenModel:getSlotData(world,index)
local data=self:getData(world)
return data and data.current[index]or nil
end

function chuanSongZhenModel:getMaxDuration(world)
local data=self:getData(world)
local max=0
if data then
for i,v in ipairs(data.pass)do
max=math.max(max,v.money,v.item)
end
local now=timeHelper.getServerShortTime()
for i,v in ipairs(data.current)do
local temp=v.dead>0 and v.dead or now
max=math.max(max,temp-v.money,temp-v.item)
end
end
local limit=cfgHelper.getdef(cfg_worldtravelconfig,"maxstore")
return math.min(max,limit)
end

function chuanSongZhenModel:getMaxMoneyDuration(world)
local data=self:getData(world)
local max=0
if data then
for i,v in ipairs(data.pass)do
max=math.max(max,v.money)
end
local now=timeHelper.getServerShortTime()
for i,v in ipairs(data.current)do
local temp=v.dead>0 and v.dead or now
max=math.max(max,temp-v.money)
end
end
local limit=cfgHelper.getdef(cfg_worldtravelconfig,"maxstore")
return math.min(max,limit)
end

function chuanSongZhenModel:getCurrentMaxMoneyDuration(world)
local data=self:getData(world)
local max=0
if data then
local now=timeHelper.getServerShortTime()
for i,v in ipairs(data.current)do
local temp=v.dead>0 and v.dead or now
max=math.max(max,temp-v.money)
end
end
local limit=cfgHelper.getdef(cfg_worldtravelconfig,"maxstore")
return math.min(max,limit)
end

function chuanSongZhenModel:getRewardTimeCurrentMoney()
local time=0
for world,data in pairs(self.data)do
local duration=chuanSongZhenModel:getCurrentMaxMoneyDuration(world)
time=math.max(duration,time)
end
return time
end

function chuanSongZhenModel:getMaxDurationSum(world)
local data=self:getData(world)
local times={0,0}
local cfg=cfgHelper.getdef(cfg_worldtravelconfig,"interval")
if data then
local now=timeHelper.getServerShortTime()
for i,v in ipairs(data.current)do
local temp=v.dead>0 and v.dead or now
times[1]=times[1]+math.floor((temp-v.money)/cfg[1])
times[2]=times[2]+math.floor((temp-v.item)/cfg[2])
end
for i,v in ipairs(data.pass)do
times[1]=times[1]+math.floor(v.money/cfg[1])
times[2]=times[2]+math.floor(v.item/cfg[2])
end
end



return times[1]+times[2]
end

function chuanSongZhenModel:checkEmptySlot(world)
local cfg=cfgHelper.get1(cfg_worldtravelconfig_get,world)
local data=self:getData(world)
return cfg.max>#data.current
end

function chuanSongZhenModel:getDisciples(world)
local data=self:getData(world)
local list={}
if data then
for i,v in ipairs(data.current)do
table.insert(list,v.disciple)
end
end
return list
end

function chuanSongZhenModel:getDisciple(world,index)
local data=self:getData(world)
local disciple=nil
if data then
local temp=data.current[index]
if temp then
disciple=temp.disciple
end
end
return disciple
end

function chuanSongZhenModel:findDiscipleSlot(world,disciple)
local data=self:getData(world)
if data then
for i,v in ipairs(data.current)do
if v.disciple==disciple then
return i
end
end
end
end











function chuanSongZhenModel:findDiscipleData(disciple)
for world,data in pairs(self.data)do
for i,v in ipairs(data.current)do
if v.disciple==disciple then
return v,world,i
end
end
end
end

function chuanSongZhenModel:getTaskTarget(world,disciple)
return worldModel:convertUnitKey({worldModel.UNITTYPE.TOURPOINT,world,tostring(disciple)})
end

function chuanSongZhenModel:extractDisciple(world)
local data=self:getData(world)
if data then
local cfg=cfgHelper.get2(cfg_eventbaseconfig_get,1,"travelconf")
local weights={}
local sum=0
for i,v in ipairs(data.current)do
local attr=UIDiscipleModel:getDiscipleBaseAttr(v.disciple,cfg[3])
local w=math.max((attr-cfg[4])*cfg[5],0)+cfg[6]
table.insert(weights,w)
sum=sum+w
end
local r=math.random(sum)

for i,w in ipairs(weights)do
if r<=w then
return data.current[i].disciple
else
r=r-w
end
end
end



end

function chuanSongZhenModel:checkPeople(bdData)
local cfg=cfg_worldtravelconfig()
for id,info in ipairs(cfg)do
if worldBlockModel:getWorldStateCount(id,eWorldBlockState.OPEN)>0 and info.level<=bdData.level then
local data=self:getData(id)
if data and info.max>#data.current then
return true
end
end
end
return false
end

function chuanSongZhenModel:checkReward()
local time=cfgHelper.getdef1(cfg_worldtravelconfig,"recvtips")
for world,data in pairs(self.data)do
local duration=chuanSongZhenModel:getMaxDuration(world)
if time<=duration then
return true
end
end
return false
end

function chuanSongZhenModel:checkReward2(time)
for world,data in pairs(self.data)do
local duration=chuanSongZhenModel:getMaxDuration(world)
duration=math.floor(duration/3600)
if duration>=time then
return true
end
end
return false
end

function chuanSongZhenModel:getRewardTime()
local time=0
for world,data in pairs(self.data)do
local duration=chuanSongZhenModel:getMaxDuration(world)
if duration>time then
time=duration
end
end
return time
end

function chuanSongZhenModel:getRewardNotifyTime()
local rewardTime=self:getRewardTime()
local time=cfgHelper.getdef1(cfg_worldtravelconfig,"recvtips")
local deltaTime=math.max(time-rewardTime,0)
return timeHelper.getServerLongTime()+deltaTime
end

function chuanSongZhenModel:checkBuildLevelUp(bdData)
if zongmenModel:getBDFlagType(bdData.flag)~=bdFlagType.normal then
return false
end

local nextLvCfg=cfgHelper.get2(cfg_monijybuilduplvlconfig_get,bdData.build_id,bdData.level+1)
if nextLvCfg then
if not zongmenModel:checkBuildingLevelUpCondition(nextLvCfg.uplevel_condition)then
return false
end
if not moneyModel.checkEnoughMoneyX(nextLvCfg.uplevel_cost)then
return false
end
return true
end
return false
end

function chuanSongZhenModel:checkDiscipleState(world,index)
local discipleguid=self:getDisciple(world,index)
if discipleguid then
return not UIDiscipleModel:checkDiscipleState2(discipleguid,DISCIPLE_STATE_TYPE.eChuiWei)
end
return false
end

function chuanSongZhenModel:checkRewardSingle(world)
local duration=chuanSongZhenModel:getMaxDuration(world)
local check=cfgHelper.getdef1(cfg_worldtravelconfig,"recvtips")
return check<=duration
end

function chuanSongZhenModel:checkAllEmpty()
for world,data in pairs(self.data)do
if#data.current>0 or#data.pass>0 then
return false
end
end
return true
end

function chuanSongZhenModel:getWorldDead(world)
local data=self:getData(world)
if data then
local max=0
for i,v in ipairs(data.current)do
if v.dead>0 then
max=math.max(max,v.dead)
else
return 0
end
end
return max
end
return 0
end

function chuanSongZhenModel:checkMoneyListen(money,level)
local listen=_listenMoney[money]
if listen then
return table.containsValue(listen,level)
end
return false
end

function chuanSongZhenModel:checkMoneyListenXX(money)
return _listenMoney[money]~=nil
end

function chuanSongZhenModel:convertUnitKey(world,block)
return worldModel:convertUnitKey({eWorldUnitTpye.CHUANSONGZHEN,world,block})
end

function chuanSongZhenModel:setRewardInfo(rewardInfo)
self.rewardInfo=rewardInfo
end

function chuanSongZhenModel:getRewardInfo(rewardInfo)
local info=self.rewardInfo
self.rewardInfo=nil
return info
end

function chuanSongZhenModel:checkReddot(bdData)
local reddot=false
reddot=reddot or chuanSongZhenModel:checkReward()
reddot=reddot or chuanSongZhenModel:checkBuildLevelUp(bdData)
reddot=reddot or chuanSongZhenModel:checkPeople(bdData)
return reddot
end
