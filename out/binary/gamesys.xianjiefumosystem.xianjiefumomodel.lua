






local _MODULENAME="XianJieFuMoModel"


def_table(_MODULENAME)
XianJieFuMoModel.name=_MODULENAME
XianJieFuMoModel.data={}

function XianJieFuMoModel:onAppStart()
self:loadAIName()
end


function XianJieFuMoModel:onEnterState(isReconnect)
self.mutilTeamNewBie=userActorArraySetting.get(ACTOR_SETTING_TYPE.eXianJieFuMo,"XJFMMutilTeamNewBie",false)
self.skillInfoReaded=userActorArraySetting.get(ACTOR_SETTING_TYPE.eXianJieFuMo,"XJFMLeaderSkillInfoReaded",{})
for i,v in ipairs(self.skillInfoReaded)do
if type(v)~="table"then
self.skillInfoReaded[i]=nil
end
end
end


function XianJieFuMoModel:onProtocolReq()

end


function XianJieFuMoModel:onLeaveState(isReconnect)

self.data={}
self.init=false
end

function XianJieFuMoModel:getData()
return self.data
end

function XianJieFuMoModel:getMonsterIdx()
return self.data.monIdx
end

function XianJieFuMoModel:getMonsterLvIdx()
return self.data.lvIdx
end

function XianJieFuMoModel:getMaxdamage()
return self.data.maxdamage
end

function XianJieFuMoModel:getTotaldamage()
return self.data.totaldamage
end

function XianJieFuMoModel:getXMTotaldamage()
return self.data.xmTotaldamage
end


function XianJieFuMoModel:getLastdamage()
return self.data.lastdamage or 0
end

function XianJieFuMoModel:getChallengedCnt()
return self.data.challengedCnt
end

function XianJieFuMoModel:getBuyedCnt()
return self.data.buyedCnt
end

function XianJieFuMoModel:getRecvIdx()
return self.data.recvIdx
end


function XianJieFuMoModel:getRank(type)
if not self.data.rankList then
self.data.rankList={}
end
return self.data.rankList[type]
end




function XianJieFuMoModel:loadAIName()
local cfg=cfgHelper.get1(cfg_fairylandbossconfig_get,1)
self.aiName={}
self.useName={}
for i,v in ipairs(cfg.aiName1)do
for j,w in ipairs(cfg.aiName2)do
table.insert(self.aiName,FMT.fmt("{0}{1}",v,w))
end
end
end

function XianJieFuMoModel:getAIName()
if#self.aiName<=0 then
self.aiName=self.useName
self.useName={}
end
local r=math.random(1,#self.aiName)
local temp=table.remove(self.aiName,r)
table.insert(self.useName,temp)
return temp
end

function XianJieFuMoModel:isSkillReaded(monsterIdx,skillID)
local temp=self.skillInfoReaded[monsterIdx]
if temp then
return table.containsValue(temp,skillID)
end
return false
end

function XianJieFuMoModel:setSkillReaded(monsterIdx,skillID)
local temp=self.skillInfoReaded[monsterIdx]
if temp==nil then
temp={}
self.skillInfoReaded[monsterIdx]=temp
end
table.insert(temp,skillID)

userActorArraySetting.set(ACTOR_SETTING_TYPE.eXianJieFuMo,"XJFMLeaderSkillInfoReaded",self.skillInfoReaded)
userActorArraySetting.flush(ACTOR_SETTING_TYPE.eXianJieFuMo)
end


function XianJieFuMoModel:pushFightData(result,log,data)
self.fightData={result,log,data}
end

function XianJieFuMoModel:popFightData()
local temp=self.fightData
self.fightData=nil
return temp
end

function XianJieFuMoModel:finishMutilTeamNewBie()
self.mutilTeamNewBie=true
userActorArraySetting.set(ACTOR_SETTING_TYPE.eXianJieFuMo,"XJFMMutilTeamNewBie",self.mutilTeamNewBie)
userActorArraySetting.flush(ACTOR_SETTING_TYPE.eXianJieFuMo)
end