

aiBehaviorNode=simple_class(baseNode)

function aiBehaviorNode:start()
aiBehaviorNode._base.start(self)
self.cmdList={}
self:setSharedVar(ai_cmd_list,self.cmdList)
end

function aiBehaviorNode:broke()
if self.currBT then
behaviorManager:removeBehaviorTree(self.currBT)
if self.currCmd and self.currCmd.removeCallback then
local args=self:getArgs()
self.currCmd.removeCallback(args.dzId,args.stId,self.currBT)
end
end
self.cmdList=nil
self.currBT=nil
self.currCmd=nil
self.cmdData=nil
self.lastCmd=nil
self.lastMode=nil
self.playSPIdleAI=nil
self.workCMD=nil
self:setSharedVar(ai_current_cmd_bt,nil)
end

function aiBehaviorNode:reset()
aiBehaviorNode._base.reset(self)

if self.currBT then
behaviorManager:removeBehaviorTree(self.currBT)
self:setSharedVar(ai_current_cmd_bt,nil)
self.currBT=nil
end

self.mode=eAICMDMode.eIdle

self.cmdList={}
self:setSharedVar(ai_cmd_list,self.cmdList)
end

function aiBehaviorNode:init()
local args=self:getArgs()
self.birthPoint=_MapManager.GetTilemapObjectPosition(args.stId)
end

function aiBehaviorNode:getABT()

if#self.cmdList>0 then
local cmd=self.cmdList[1]
table.remove(self.cmdList,1)
return cmd,eAICMDMode.eWork
end

local cmd
local owner=self:getOwner()
if self.playSPIdleAI and not owner.dying then

for i=1,3 do
cmd=self:getIdleCMD(owner.dzType)
if cmd then
self.playSPIdleAI=false
break
end
end
end
if not cmd then
cmd=aiManager:getDefaultIdleCMD(owner.dzType)
cmd.initData=aiManager:getIdleCMDData(cmd.type,owner)
self.playSPIdleAI=true
end
return cmd,eAICMDMode.eIdle
end

function aiBehaviorNode:getIdleCMD(dzType)
local defaultList=aiManager:getDiscipleDefaultCMD(dzType)
local cmd=defaultList[math.random(#defaultList)]
if cmd then
local owner=self:getOwner()
local initData=aiManager:getIdleCMDData(cmd.type,owner)
if initData and aiManager:checkIdleCMDCondition(cmd.type,owner,initData.cId)then
cmd.initData=initData
return cmd
end
end
return nil
end

function aiBehaviorNode:setCurrCMD(cmd,mode)
if not cmd then
cmd,mode=self:getABT()
end
local cmdData=aiDefineData[cmd.type]

local args=self:getArgs()
args.cmdArgs=cmd.args
local initData=cmd.initData or{}
initData.cmdType=cmd.type
initData.dzId=args.dzId
initData.stId=args.stId
initData.birthPoint=self.birthPoint
local owner=self:getOwner()
initData.dzType=owner.dzType
self.currBT=behaviorManager:addBehaviorTree(cmdData.name,args,true,initData)
if cmd.beginCallback then
cmd.beginCallback(args.dzId,args.stId,self.currBT)
end










self.currCmd=cmd
self.cmdData=cmdData
self.mode=mode

self:setSharedVar(ai_current_cmd_bt,self.currBT)
self:setSharedVar(ai_cmd_mode,self.mode)
self:setSharedVar(ai_allow_interrupt,self:isAllowInterrupt())
end

function aiBehaviorNode:brokeCurrCMD(interrupt,canRestore)
if self.currBT then
behaviorManager:removeBehaviorTree(self.currBT)
self:setSharedVar(ai_current_cmd_bt,nil)
if self.currCmd.endCallback then
local args=self:getArgs()
self.currCmd.endCallback(args.dzId,args.stId,self.currBT,interrupt)
end
local currCmd=self.currCmd
local currMode=self.mode
local cmdData=self.cmdData
self.currBT=nil
self.currCmd=nil
self.cmdData=nil
self:setSharedVar(ai_reset_body_logic,true)


if self.workCMD and not cmdData.isWorkType then
self:setCurrCMD(self.workCMD,eAICMDMode.eWork)
else
if canRestore and currCmd.restorePreviousAI and self.lastCmd then
currCmd.restorePreviousAI=false
self:setCurrCMD(self.lastCmd,self.lastMode)
end
end

self.lastCmd=currCmd
self.lastMode=currMode


if cmdData.isWorkType then
if interrupt then
self.workCMD=currCmd
else
self.workCMD=nil
end
end
end
end

function aiBehaviorNode:isAllowInterrupt()
return self.mode==eAICMDMode.eIdle or(self.cmdData and self.cmdData.allowInterrupt)
end

function aiBehaviorNode:update(interval)


local newWork=self.mode==eAICMDMode.eIdle and#self.cmdList>0

local interrupt=self:getSharedVar(ai_interrupt_cmd)

local check=aiManager:isCanInterruptCMD(self:getOwner())

self:setSharedVar(ai_wait_broke,not check and(newWork or interrupt))


if check then
local allowInterrupt=self:isAllowInterrupt()

if interrupt then
self:setSharedVar(ai_interrupt_cmd,false)
if allowInterrupt then
self:brokeCurrCMD(true,not newWork)
end
end


if newWork then
self:brokeCurrCMD(true,false)
self:setCurrCMD()
end
end

if self.currBT then


if not self.currBT:canExecute()then
self:brokeCurrCMD(false,true)
end
else
self:setCurrCMD()
end

return nodeState.running
end
