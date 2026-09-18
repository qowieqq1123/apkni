






local _MODULENAME="worldLeaderModel"




def_table(_MODULENAME)
worldLeaderModel.name=_MODULENAME
worldLeaderModel.data={}
worldLeaderModel.rank={}

function worldLeaderModel:onAppStart()
self:loadAIName()
end


function worldLeaderModel:onEnterState(isReconnect)
self.mutilTeamNewBie=userActorArraySetting.get(ACTOR_SETTING_TYPE.eWorldBigBoss,"WorldLeaderMutilTeamNewBie",false)
self.skillInfoReaded=userActorArraySetting.get(ACTOR_SETTING_TYPE.eWorldBigBoss,"WorldLeaderSkillInfoReaded",{})
for i,v in ipairs(self.skillInfoReaded)do
if type(v)~="table"then
self.skillInfoReaded[i]=nil
end
end
end


function worldLeaderModel:onLeaveState(isReconnect)

self.data={}
self.rank={}
self.init=false
end







function worldLeaderModel:setData(monsterIdx,stageIdx,lastDamage,totalDamage,challengeTimes,buyTimes)
self.data={
monsterIdx=monsterIdx,
stageIdx=stageIdx,
lastDamage=lastDamage,
totalDamage=totalDamage,
challengeTimes=challengeTimes,
buyTimes=buyTimes,
}
self.init=true
end

function worldLeaderModel:pushRank(stageIdx,list,rank)
self.rank[stageIdx]={
list=list or{},
rank=rank
}
end

function worldLeaderModel:cleanRank()
self.rank={}
end

function worldLeaderModel:getRank(stageIdx)
return self.rank[stageIdx]
end

function worldLeaderModel:getMonsterIdx()
return self.data.monsterIdx
end

function worldLeaderModel:getStageIdx()
return self.data.stageIdx
end

function worldLeaderModel:getLastDamage()
return self.data.lastDamage
end

function worldLeaderModel:getTotalDamage()
return self.data.totalDamage
end

function worldLeaderModel:getChallengeTimes()
return self.data.challengeTimes
end

function worldLeaderModel:getBuyTimes()
return self.data.buyTimes
end

function worldLeaderModel:setLastDamage(damage)
if self.data.lastDamage<damage then
self.data.lastDamage=damage
return true
end
return false
end

function worldLeaderModel:setTotalDamage(damage)
self.data.totalDamage=damage
end

function worldLeaderModel:setChallengeTimes(num)
self.data.challengeTimes=num
end

function worldLeaderModel:setBuyTimes(num)
self.data.buyTimes=num
end

function worldLeaderModel:getStageNameList()
if not self.stageNameList then
self.stageNameList={}
local cfg=cfg_worldbosslevelconfig()

for i,v in ipairs(cfg)do


local str=v.showStageName
table.insert(self.stageNameList,str)
end
end
return self.stageNameList
end

function worldLeaderModel:getReddot()
local curr=self:getChallengeTimes()
local buy=self:getBuyTimes()
if curr and buy then
local free=cfgHelper.get2(cfg_worldbossconfig_get,1,"free")
return curr<(buy+free)
end
return false
end

function worldLeaderModel:hasChallengeCount_canBuy()
local curr=self:getChallengeTimes()
local cfg=cfgHelper.get2(cfg_worldbossconfig_get,1,"buy")
local maxBuy=#cfg

if curr and maxBuy then
local free=cfgHelper.get2(cfg_worldbossconfig_get,1,"free")
return curr<(maxBuy+free)
end
return false
end

function worldLeaderModel:pushFightData(result,log,data)
self.fightData={result,log,data}
end

function worldLeaderModel:popFightData()
local temp=self.fightData
self.fightData=nil
return temp
end

function worldLeaderModel:loadAIName()
local cfg=cfgHelper.get1(cfg_worldbossconfig_get,1)
self.aiName={}
self.useName={}
for i,v in ipairs(cfg.aiName1)do
for j,w in ipairs(cfg.aiName2)do
table.insert(self.aiName,FMT.fmt("{0}{1}",v,w))
end
end
end

function worldLeaderModel:getAIName()
if#self.aiName<=0 then
self.aiName=self.useName
self.useName={}
end
local r=math.random(1,#self.aiName)
local temp=table.remove(self.aiName,r)
table.insert(self.useName,temp)
return temp
end

function worldLeaderModel:isSkillReaded(monsterIdx,skillID)
local temp=self.skillInfoReaded[monsterIdx]
if temp then
return table.containsValue(temp,skillID)
end
return false
end

function worldLeaderModel:setSkillReaded(monsterIdx,skillID)
local temp=self.skillInfoReaded[monsterIdx]
if temp==nil then
temp={}
self.skillInfoReaded[monsterIdx]=temp
end
table.insert(temp,skillID)

userActorArraySetting.set(ACTOR_SETTING_TYPE.eWorldBigBoss,"WorldLeaderSkillInfoReaded",self.skillInfoReaded)
userActorArraySetting.flush(ACTOR_SETTING_TYPE.eWorldBigBoss)
end

function worldLeaderModel:finishMutilTeamNewBie()
self.mutilTeamNewBie=true

userActorArraySetting.set(ACTOR_SETTING_TYPE.eWorldBigBoss,"WorldLeaderMutilTeamNewBie",self.mutilTeamNewBie)
userActorArraySetting.flush(ACTOR_SETTING_TYPE.eWorldBigBoss)
end