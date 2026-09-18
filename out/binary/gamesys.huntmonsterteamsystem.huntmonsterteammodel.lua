






local _MODULENAME="huntMonsterTeamModel"


def_table(_MODULENAME)
huntMonsterTeamModel.name=_MODULENAME



local _monsterLock={}




















local _teamData={}


function huntMonsterTeamModel:onAppStart()

end


function huntMonsterTeamModel:onEnterState(isReconnect)
self:initSendData()
self:initSelectData()
_monsterLock={}
_teamData={}
end


function huntMonsterTeamModel:onLeaveState(isReconnect)

end

function huntMonsterTeamModel:onProtocolReq()

end


function huntMonsterTeamModel:startTeam(world,team,monsters,zfId)
local segments={}
local cost={}
local positions={}
local duration=0
local cfg=cfgHelper.get2(cfg_huntmonsterteambaseconfig_get,1,"duration")
for i,v in ipairs(monsters)do
local mType=self:getMonsterDataMonType(v)
local d=(cfg[mType]or 1)
duration=duration+d
table.insert(segments,duration)
_monsterLock[v]=world
local costCfg=self:getMonsterDataCost(v)
local money=0
if costCfg then
for i,v in ipairs(costCfg)do
if v[1]==eMoneyType.mtLingPai then
money=money+v[2]
end
end
end
table.insert(cost,money)
local position=self:getMonsterPosition(v)
table.insert(positions,position)
end
local nowTime=timeHelper.getServerShortTime()
local data={
world=world,
monsters=monsters,
team=team,
zhenfa=zfId,
times=segments,
duration=duration,
untilTime=nowTime+duration,
sinceTime=nowTime,
progress=1,
rewardList={},
rewardLookup={},
victory={},
running=true,
stoping=false,
level=self:calculuteMonstersMaxLevel(monsters),
cost=cost,
positions=positions,
}
_teamData[world]=data
end

function huntMonsterTeamModel:abortTeamProgress(world)
local data=self:getTeamData(world)
data.untilTime=data.sinceTime+data.times[data.progress]
data.stoping=true
end

function huntMonsterTeamModel:deleteTeamData(world)
local data=self:getTeamData(world)
if data then
for i=data.progress,#data.monsters do
local key=data.monsters[i]
if _monsterLock[key]then
_monsterLock[key]=nil
end
end
end
_teamData[world]=nil
end





















function huntMonsterTeamModel:addFightVictory(world,monsterKey,rewards)
local data=self:getTeamData(world)
local index=table.findValue(data.monsters,monsterKey)
table.insert(data.victory,index)


for i,v in ipairs(rewards)do


local itemguid=v.itemguid
local itemid=v.itemid
local num=v.num

local itemcfg=itemsConfig.getConfig(itemid)
local lookupIdx=data.rewardLookup[itemid]
if lookupIdx and(itemsConfig.isMoney(itemid)or(itemcfg.dup and itemcfg.dup~=num))then
local lookupData=data.rewardList[lookupIdx]
lookupData.itemguid=nil
local total=lookupData.num+num
local temp=itemcfg.dup or(total+1)
local least=total%temp
local times=(total-least)/temp
lookupData.num=least

for i=1,times do
local rewardData={itemguid=nil,itemid=itemid,num=itemcfg.dup}
table.insert(data.rewardList,rewardData)
end
else
local rewardData={itemguid=itemguid,itemid=itemid,num=num}

table.insert(data.rewardList,rewardData)
data.rewardLookup[itemid]=#data.rewardList
end
end

end

function huntMonsterTeamModel:setProgressPass(world)
local data=self:getTeamData(world)
local monsterKey=data.monsters[data.progress]

data.progress=data.progress+1
end

function huntMonsterTeamModel:haveTeamData(world)
return self:getTeamData(world)~=nil
end

function huntMonsterTeamModel:getTeamData(world)
return _teamData[world]
end

function huntMonsterTeamModel:existOneTeam()
return next(_teamData)~=nil
end

function huntMonsterTeamModel:getAllTeams()
return _teamData
end

function huntMonsterTeamModel:pauseTeam(data)
data.running=false
end

function huntMonsterTeamModel:resumeTeam(data)
data.running=true
end

function huntMonsterTeamModel:findMonsterWorld(unitKey)
return _monsterLock[unitKey]
end

function huntMonsterTeamModel:deleteMonsterWorld(unitKey)
_monsterLock[unitKey]=nil
end

function huntMonsterTeamModel:findTeamMonsterIndexEx(world,unitKey)
local data=self:getTeamData(world)
if data then
return self:findTeamMonsterIndex(data,unitKey)
end
end

function huntMonsterTeamModel:findTeamMonsterIndex(data,unitKey)
return table.findValue(data.monsters,unitKey)
end

function huntMonsterTeamModel:calculateAverageDiscipleLv(teamList)
if teamList and next(teamList)then
local team=teamList
local count=#team
local sum=0
for i,v in ipairs(team)do
if mathHelper.validInt64(v)then
sum=sum+UIDiscipleModel:getDiscipleJJLevel(v)
end
end
return math.floor(sum/count)
end
return-1
end

function huntMonsterTeamModel:existTeamComplete()
for world,data in pairs(_teamData)do
if self:isTeamComplete(data)then
return true
end
end
return false
end

function huntMonsterTeamModel:isTeamComplete(data)
return#data.monsters<data.progress
end

function huntMonsterTeamModel:isCurrentMonster(data,unitKey)
return data.monsters[data.progress]==unitKey
end

function huntMonsterTeamModel:getCurrentMonster(data)
return data.monsters[data.progress]
end

function huntMonsterTeamModel:isTeamStop(data)

return data.stoping
end

function huntMonsterTeamModel:setTeamStop(data)
data.stoping=true
end

function huntMonsterTeamModel:isTeamAbort(data)
return self:isTeamStop(data)and timeHelper.getServerShortTime()>=data.untilTime
end

function huntMonsterTeamModel:checkFightMoment(data)
if data.running then
local nowTime=timeHelper.getServerShortTime()
if(nowTime-data.sinceTime)>=data.times[data.progress]then
return true
end
end
return false
end

function huntMonsterTeamModel:checkFightCondition(data)
local unitKey=self:getCurrentMonster(data)

if not huntMonsterTeamModel:checkMonsterDataExist(unitKey)then
return false
end

local costList=huntMonsterTeamModel:getMonsterDataCost(unitKey)
if costList then
for i,v in ipairs(costList)do
local need=v[2]
local have=itemsModel.getCount(v[1])
if need>have then
return false
end
end
end

return true
end

function huntMonsterTeamModel:getWorldMaxNum(world)
local list=cfgHelper.get2(cfg_huntmonsterteamworldconfig_get,world,"maxnum")
local blockCnt=worldBlockModel:getWorldStateCount(world,eWorldBlockState.OPEN)
for i=blockCnt,1,-1 do
local num=list[i]
if num then
return num
end
end
return-1
end


