def_class('fightAimAttackAction',fightBaseAction)

function fightAimAttackAction:__init()
self.typo=fightActionType.AIM_ATTACK
end

function fightAimAttackAction:getTypo()
return self.typo
end



function fightAimAttackAction:init(_round,_rawData,_srcID,_dstID)
self.round=_round
self.battle=_round:getBattle()
self.dstID=_rawData[2]
self.srcIDs={}
self.actionObjs={}
self.imageID=21
for i=3,#_rawData do
self.srcIDs[#self.srcIDs+1]=_rawData[i]
end
end


function fightAimAttackAction:exe(immediately)
local dataCount=#self.actionObjs
if dataCount>0 then
self.isExe=true
self.isFlow=true
self.flowDelay=0.5
end
self.isComplete=true
end

function fightAimAttackAction:srcFlowText(deltaTime)
self.flowDelay=self.flowDelay-deltaTime
if self.isFlow and self.flowDelay<0 then
local srcEnt=self.battle:getEntity(self.dstID)
if srcEnt then
if srcEnt:isShow()then
srcEnt:flowText(flowObjTypo.skillEffect,{nunPara=self.imageID})
end
end
self.isFlow=false
end
end

function fightAimAttackAction:fetchData(curIndex,parentRawData)
self.uaRawDatas={}
local count=#self.srcIDs
local index=0
for i=curIndex,curIndex+count do
if parentRawData[i]then
local actionData=parentRawData[i]
local typo=actionData[fightCommonTag.typo]
local actionObj=fightActionMrg:getAction(typo)
if actionObj~=nil then
self.actionObjs[#self.actionObjs+1]={obj=actionObj,delay=0.5*index}
actionObj:init(self.round,actionData)
end
end
index=index+1
end
local dataCount=#self.actionObjs
return dataCount
end

function fightAimAttackAction:logExe(logContent)
local dstEnt=self.battle:getEntity(self.dstID)
local dstName=dstEnt and dstEnt:logName()or'未定义'
local logStr=''
for _i,srcID in ipairs(self.srcIDs)do
local srcEnt=self.battle:getEntity(srcID)
if srcEnt~=nil then
logStr=FMT.fmt('{0}{1}',logStr,srcEnt:logName())
end
end
logStr=FMT.fmt('{0} [指挥攻击][{1}]',logStr,dstName)
logContent(logStr)
self.isComplete=true
end

function fightAimAttackAction:update(deltaTime)

local ret=true
if self.isExe then
ret=true
self:srcFlowText(deltaTime)
for i,v in ipairs(self.actionObjs)do
if v.hasExe then
local sRet=v.obj:update(deltaTime)
ret=ret and sRet
else
v.delay=v.delay-deltaTime
if v.delay<0 then
v.hasExe=true
v.obj:exe()
v.obj:update(deltaTime)
end
ret=false
end
end
end

self.isComplete=ret
return self.isComplete
end


function fightAimAttackAction:onDespwan()
fightActionMrg:recycleAction(self)
end

