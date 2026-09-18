airDropSystem={}


function airDropSystem:onAppStart()

end

function airDropSystem:onEnterState(isReconnect)

end

function airDropSystem:onLeaveState(isReconnect)
airDropSystem:leaveAirGame()
end

function airDropSystem:onProtocolReq(isReconnect)

end

function airDropSystem:enterAirGame()
self.drops={}
self.dropEntities={}
end

function airDropSystem:leaveAirGame()
self.drops={}
self.dropEntities={}
end

function airDropSystem:checkCollectDrop(role,entity)
local dropCfg=entity:getEntityConfig()
local num=entity:getNum()
local type1=dropCfg.type1
if type1==eDropType.eMoney then
return true
elseif type1==eDropType.eBox then
return true
elseif type1==eDropType.eRestoreHP then
return true
end
return false
end

function airDropSystem:getDropNum(dropid,tnum)
local singlenum=airDropSystem:getDropContainsNum(dropid)
return math.ceil(tnum/singlenum)
end


function airDropSystem:getDropContainsNum(dropid)
local dropCfg=cfg_airdropconfig_get(dropid)
local type1=dropCfg.type1
local funcparam=dropCfg.funcparam or{}
if type1==eDropType.eMoney then
return funcparam.value or 1
elseif type1==eDropType.eBox then
return 1
elseif type1==eDropType.eRestoreHP then
return 1
end
return 1
end

function airDropSystem:getRestoreHP(role,dropid)
local cfg=cfg_airdropconfig_get(dropid)
if cfg.type1~=eDropType.eRestoreHP then return 0 end
local funcparam=cfg.funcparam
if funcparam==nil then return 0 end
local value=funcparam.value or 0
local value_p=funcparam.value_p or 0
value=value+value_p/10000*role:getMaxHp()
return value
end

function airDropSystem:createDropEnity(monster,isCirtical)
local entityCfg=monster:getEntityConfig()
local drop=entityCfg.drop
if drop==nil then return end
local droplist=airDropSystem:randomDrop(drop)
if droplist==nil or#droplist==0 then return end

local tlen=0
local list={}
for i,v in ipairs(droplist)do
local dropid=v[1]
local num=v[2]
local multiBykillEnemy=airBuffSystem:getAddDropMultiByKillEnemy(dropid,isCirtical)
local len=num+multiBykillEnemy
tlen=tlen+len
list[dropid]=len
end

local pos=monster:getPosition()
local offsetPos={{pos.x,pos.z}}
if tlen>1 then
offsetPos=airEntitySystem:getEntityRandomPos(pos.x,pos.z,0,2,tlen)
end

local idx=0
for dropid,len in pairs(list)do







for i=1,len do
local pos=offsetPos[idx+i]
local x=pos[1]
local z=pos[2]
airMonsterSystem:createDropEntity(x,z,dropid)
end
idx=idx+len
end
end

function airDropSystem:onCollectDrop(entity,dropid,num)
airBuffSystem:onRoleCollectDrop(entity,dropid,num)
end

function airDropSystem:getCollectDrop(dropid)
return self.drops[dropid]or 0
end

function airDropSystem:addCollectDrop(dropid,num)
local old=self.drops[dropid]or 0
self.drops[dropid]=old+num
end

function airDropSystem:randomDrop(drop)
if drop==nil or#drop==0 then return end
local ratio=math.random(0,10000)
local droplist={}
for _,v in ipairs(drop)do
local dropid=v[1]
local min=v[2]
local max=v[3]
if ratio<=v[4]then
local num=math.random(min,max)
droplist[#droplist+1]={dropid,num}
end
end
return droplist
end

function airDropSystem:addDropEnt(ent)
self.dropEntities[ent.handle]=ent
end

function airDropSystem:removeDropEnt(handle)
self.dropEntities[handle]=nil
end

function airDropSystem:collectAllDripEnt()
local role=airActorSystem:getActor()
if role==nil then return end
local ents={}
for _,v in pairs(self.dropEntities)do
ents[#ents+1]=v
end
self.dropEntities={}

for i=#ents,1,-1 do
role:startCollectDrop(ents[i])
end
ents=nil
end

function airDropSystem:onLevelEnd()
airDropSystem:collectAllDripEnt()
end
