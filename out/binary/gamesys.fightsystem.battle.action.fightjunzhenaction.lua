def_class('fightJunZhenAction',fightBaseAction)


local stopEffect=CS.GameInterface.StopEffect



function fightJunZhenAction:__init()
self.typo=fightActionType.CLIENT_JUN_ZHEN_ACTION
end

function fightJunZhenAction:init(_round,_rawData,_srcID)
self.round=_round
self.battle=_round:getBattle()
self.rawData=_rawData


self.times=self.rawData[2]
self.result=self.rawData[3]

self.isDead=self.rawData[4]

self.waitEnt={}
self.waitBehindEnt={}
self.isExeUpdateData=nil
self.isExeBehavior=nil
self.isComplete=false
end


local _100Length=6

local moveSpeed={3,2,5}
local frontBattleSpeed=0.4
local frontId={[401]=1,[402]=1,[406]=1,[407]=1}
local behindBattleSpeed=0.6
local targetDistance=0.5
local targetDistance2=2

local yanWuEffect={20610,20611}
local yanWuSpine=6014


function fightJunZhenAction:exe()

self.teamListLeft,self.totalLeft=fightModel:getJunZhenTeamList(self.result[1],self.battle.jzLeftTeamNum)
self.teamListRight,self.totalRight=fightModel:getJunZhenTeamList(self.result[2],self.battle.jzRightTeamNum)

self.overTime=30

if self.isDead then
self:exeDead()
else
self:exeLive()
end

end

function fightJunZhenAction:exeLive()
self.ismovedelay=false
self.movedelay=4

self.demageFrontDelay=2.5
self.demageBehindDelay=3.5

self.yanWuStartDelay=3.8
self.yanWuEndDelay=10
self.waitEnt={}
self.waitBehindEnt={}

local frontSize=1
local behindSize=1

if self.battle.entities then

local playEffectLeftIdx={}
local playEffectRightIdx={}

local randomEffectList={}


for i,v in pairs(self.battle.entities)do
if i>=401 and i<=410 then
if frontId[i]then
self.waitEnt[i]=i-400
else
self.waitBehindEnt[i]=i-400
end
local curPos=v:getPosition()
local worldcenter=fightModel.getWorldCenter()
local centerPos=Vector3.New(worldcenter.x,curPos.y,curPos.z)

local size,h=fightManager.getJunZhenSize(v.guid)

size=math.min(_100Length,size)/_100Length

local offsetX=targetDistance*(0.7-size)

local pos=v.isInLeft and centerPos-Vector3.New(offsetX,0,0)or centerPos+Vector3.New(offsetX,0,0)
v:moveTo(pos,false,Vector3.Distance(curPos,pos)/moveSpeed[1],1,function()
self:onCompleteMove1(v)
end)
if not v.isDead then
if i>=401 and i<=405 then
table.insert(playEffectLeftIdx,i)
else
table.insert(playEffectRightIdx,i)
end
end

if frontId[i]then
frontSize=math.min(size,frontSize)
else
behindSize=math.min(size,behindSize)
end

end
end

self.yanWuEffect=behindSize<=0.5 and yanWuEffect[1]or yanWuEffect[2]

if#playEffectLeftIdx==0 then playEffectLeftIdx={401}end
if#playEffectRightIdx==0 then playEffectRightIdx={406}end
for i=1,50 do
local idxl=playEffectLeftIdx[math.random(1,#playEffectLeftIdx)]
local idxr=playEffectRightIdx[math.random(1,#playEffectRightIdx)]
table.insert(randomEffectList,i%2==1 and{idxl,idxr}or{idxr,idxl})
end
self.randomEffectList=randomEffectList
self.randomEffectDelay=0.75
end

end

function fightJunZhenAction:exeDead()
self.ismovedelay=false
self.movedelay=6.5
self.demageDelay=2
self.waitEnt={}

if self.battle.entities then

local playEffectLeftIdx={}
local playEffectRightIdx={}
for i,v in pairs(self.battle.entities)do
if i>=401 and i<=410 then
if v.isInLeft then
self.waitEnt[i]=i-400
v:moveTo(v.RightPos,false,2,1,function()
v.isInLeft=false
v:setRotation(Vector3.New(0,180,0))
v:setScaleVec3(Vector3.New(1,1,-1))

self.ismovedelay=true
end)
if not v.isDead then
table.insert(playEffectLeftIdx,i)
end
else
self.waitEnt[i]=i-400
v:moveTo(v.LeftPos,false,2,1,function()
v.isInLeft=true
v:setScaleVec3(Vector3.New(1,1,1))
v:setRotation(Vector3.New(0,0,0))
self.ismovedelay=true
end)
if not v.isDead then
table.insert(playEffectRightIdx,i)
end
end
end
end
end

end

function fightJunZhenAction:onCompleteMove1(ent)
local curPos=ent:getPosition()
local worldcenter=fightModel.getWorldCenter()
local centerPos=Vector3.New(worldcenter.x,curPos.y,curPos.z)
local pos=ent.isInLeft and centerPos+Vector3.New(targetDistance2,0,0)or centerPos-Vector3.New(targetDistance2,0,0)
local speed=frontId[ent.id]~=nil and frontBattleSpeed or behindBattleSpeed
ent:moveTo(pos,false,targetDistance2/speed,1,function()
self:onCompleteMove2(ent)
end)
end

function fightJunZhenAction:onCompleteMove2(ent)
local pos=ent.isInLeft and ent.RightPos or ent.LeftPos
local speed=frontId[ent.id]~=nil and moveSpeed[2]or moveSpeed[3]
ent:moveTo(pos,false,Vector3.Distance(ent:getPosition(),pos)/speed,1,function()
self:onCompleteMoveEnd(ent)
end)
end

function fightJunZhenAction:onCompleteMoveEnd(ent)
if ent.isInLeft then
ent.isInLeft=false
ent:setRotation(Vector3.New(0,180,0))
ent:setScaleVec3(Vector3.New(1,1,-1))
else
ent.isInLeft=true
ent:setScaleVec3(Vector3.New(1,1,1))
ent:setRotation(Vector3.New(0,0,0))
end

self.ismovedelay=true
end

function fightJunZhenAction:recvDamage(id)
if self.battle.entities==nil then return end
local ent=self.battle.entities[id]
if ent then
local srcEnt
local isLeft=ent:isLeft()
if isLeft then
srcEnt=self.battle.entities[id+5]
else
srcEnt=self.battle.entities[id-5]
end
if srcEnt then

end
if self.result then
if isLeft then
ent:updateJunZhenData(self.teamListLeft)
else
ent:updateJunZhenData(self.teamListRight)
end
end
end
end


function fightJunZhenAction:logExe(logContent)

end

function fightJunZhenAction:statisticsExe()

self.isComplete=true
end


function fightJunZhenAction:update(deltaTime)
if self.ismovedelay then
self.movedelay=self.movedelay-deltaTime
if self.movedelay<=0 then
self.isComplete=true
end
end


if self.overTime then
self.overTime=self.overTime-deltaTime
if self.overTime<=0 then
self.isComplete=true
self.overTime=nil
end
end

if self.yanWuStartDelay then
self.yanWuStartDelay=self.yanWuStartDelay-deltaTime
if self.yanWuStartDelay<=0 then
self.yanwu={}
self.yanwu[1]=fightManager.playEffect(self.yanWuEffect,fightModel:transToBattleWorld(Vector3.New(0,-200,0)),false,Vector3.one)
self.battle.jzBattleXiaoRen=fightManager.addEntity(yanWuSpine,{},fightModel:transToBattleWorld(Vector3.New(0,-200,0)),false,0,1)
for i=2,7 do
local x=math.random(-5000,5000)/1000
local z=math.random(-3000,3000)/1000
self.yanwu[i]=fightManager.playEffect(20612,fightModel:transToBattleWorld(Vector3.New(x,-200,z)),false,Vector3.one)

end
self.yanWuStartDelay=nil
end
end

if self.yanWuEndDelay then
self.yanWuEndDelay=self.yanWuEndDelay-deltaTime
if self.yanWuEndDelay<=0 then
if self.battle.jzBattleXiaoRen then
fightManager.removeEntity(self.battle.jzBattleXiaoRen.GUID)
end
self.yanWuEndDelay=nil
end
end

if self.demageFrontDelay then
self.demageFrontDelay=self.demageFrontDelay-deltaTime
if self.demageFrontDelay<=0 then
for id,v in pairs(self.waitEnt)do
self:recvDamage(id)
end
self.demageFrontDelay=nil

UIManager:invokeUIMethod("UIFightMainTop","updatejunZhen",self.totalLeft,self.totalRight)
end
end


if self.demageBehindDelay then
self.demageBehindDelay=self.demageBehindDelay-deltaTime
if self.demageBehindDelay<=0 then
for id,v in pairs(self.waitBehindEnt)do
self:recvDamage(id)
end
self.demageBehindDelay=nil

end
end

if self.randomEffectList and self.demageBehindDelay then
self.randomEffectDelay=self.randomEffectDelay+deltaTime
if self.randomEffectDelay>=0.2 then
local idxList=self.randomEffectList[1]
if idxList then
local src=idxList[1]
local dst=idxList[2]
local srcEnt=self.battle:getEntity(src)
if srcEnt then
srcEnt:playRandomEffect(dst)
end
table.remove(self.randomEffectList,1)
else
self.randomEffectList=nil
end
self.randomEffectDelay=0
end
end

return self.isComplete
end


function fightJunZhenAction:onDespwan()
self.isExeUpdateData=nil
self.isExeBehavior=nil
self.overTime=nil
self.isComplete=nil
if self.yanwu then
for i,v in ipairs(self.yanwu)do
stopEffect(v)
end
self.yanwu=nil
end
if self.battle.jzBattleXiaoRen then
fightManager.removeEntity(self.battle.jzBattleXiaoRen.GUID)
end
fightActionMrg:recycleAction(self)
end




