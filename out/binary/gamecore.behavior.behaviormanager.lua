







behaviorManager=gameState.addListener({})

local _format=string.format
local _remove=table.remove

local _behaviorNodeDict={}
local _behaviorFileDict={}


local _globalVariables={}


local _allBehaviorTreeDict={}

local _updateBehaviorTreeDict={}


local _behaviorTreePool={}

local _removeBehaviorTreeDict={}
local _pushNum=10
local _guid=0
local _recycleDict={}
local _tempList={}

function behaviorManager:getGUID()
_guid=_guid+1
return _guid
end





function behaviorManager:onAppStart()
self.idCount=0
self.waitCount=0
end

function behaviorManager:onEnterState(isReconnect)
if isReconnect then
return
end
self.waitingList={}
self:startTick()

notifySystem:listenNotify(notifyConfig.onBehaviorTreeError,self.onBehaviorTreeError)
end

function behaviorManager:onLeaveState(isReconnect)
if isReconnect then
return
end
self:stopTick()
self:clearGlobalValues()
notifySystem:removelistener(notifyConfig.onBehaviorTreeError,self.onBehaviorTreeError)
end

function behaviorManager:clearGlobalValues()
_globalVariables={}
end

function behaviorManager:getID()
self.idCount=self.idCount+1
return self.idCount
end

function behaviorManager:getWaitID()
self.waitCount=self.waitCount+1
return self.waitCount
end

function behaviorManager:addWaiting(waitTime,callback,useUnscaledTime)
local id=self:getWaitID()
local time=useUnscaledTime and Time.unscaledTime or Time.time
self.waitingList[id]={
endTime=time+waitTime,
callback=callback,
useUnscaledTime=useUnscaledTime,
}
return id
end

function behaviorManager:removeWaiting(id)
self.waitingList[id]=nil
end

function behaviorManager:startTick()
if self.timer==nil then
self.timer=FrameTimer.New(function()
behaviorManager:tickFunc()
end,1,-1)
self.timer:Start()
end
end

function behaviorManager:tickFunc()
if reconnectState:isDisConnectOrReconnect()then
return
end
if not initProControl.isDone()then
return
end
local nTime=Time.time
local uTime=Time.unscaledTime
for k,v in pairs(self.waitingList)do
local time=v.useUnscaledTime and uTime or nTime
if time>=v.endTime then
self:removeWaiting(k)
v.callback()
end
end
if#_tempList>0 then
local len=_pushNum
while#_tempList>0 and len>0 do
local v=_remove(_tempList,1)
if not _recycleDict[v.GUID]then
v:regularUpdate(nTime,uTime)
end
len=len-1
end
else
table.clear(_recycleDict)
for _,v in pairs(_updateBehaviorTreeDict)do
_tempList[#_tempList+1]=v
end
local len=#_tempList





if len>0 then
local showBattle=fightModel:haveBattleShow()
if deviceHelper.isRunWebGL()then
_pushNum=math.floor(math.max(4,math.min(len/30,7)))
if showBattle then
_pushNum=math.min(_pushNum,2)
end
else
_pushNum=math.floor(math.max(6,math.min(len/20,12)))
if showBattle then
_pushNum=math.min(_pushNum,4)
end
end
end
end

self:handleRemoveList()
end

function behaviorManager:handleRemoveList()
if next(_removeBehaviorTreeDict)then
for k,v in pairs(_removeBehaviorTreeDict)do
_allBehaviorTreeDict[v.uid]=nil
_updateBehaviorTreeDict[v.uid]=nil
_recycleDict[v.GUID]=true
self:setBTToPool(v)
end
_removeBehaviorTreeDict={}
end
end

function behaviorManager:stopTick()
if self.timer then
self.timer:Stop()
self.timer=nil
end
for k,v in pairs(_allBehaviorTreeDict)do
self:removeBehaviorTree(v)
end
self:handleRemoveList()
_tempList={}
_recycleDict={}
end

function behaviorManager:resetBT(bt,stateKey,stateId)
bt:reset(true)
bt:setSharedVar(stateKey,stateId)
end

function behaviorManager:reloadNodeFile()
if strict_if_strict then
strict_if_strict(false)
end
for k,v in pairs(_behaviorNodeDict)do
reload(v)
end
if strict_if_strict then
strict_if_strict(true)
end




end

function behaviorManager:reloadBTFile()
if strict_if_strict then
strict_if_strict(false)
end
for k,v in pairs(_behaviorFileDict)do
v.data=reload(v.fName)
end
if strict_if_strict then
strict_if_strict(true)
end




end

local _genBehaviorTree
_genBehaviorTree=function(json,parent,tree,index)
local file=_behaviorNodeDict[json[1]]
if not file then
file=_format('lua.gamecore.behavior.%s.%s',json[2],json[1])
_behaviorNodeDict[json[1]]=file
require(file)
end
local class=_G[json[1]]
if class then
local node=class:new(tree,parent,json[3],json[5])
node.id=index
node.name=json[1]
parent:addChild(node)
if json[4]then
for i,v in ipairs(json[4])do
_genBehaviorTree(v,node,tree,i)
end
end
end
end


function behaviorManager:loadBehaviorTree(file,args)
local tfile=_behaviorFileDict[file]
if not tfile then
local fName=_format('data.behaviors.%s',file)
local data=require(fName)
tfile={fName=fName,data=data}
_behaviorFileDict[file]=tfile
end
local json=tfile.data
if json then
local uid=self:getID()
local bt=behaviorTree:new(uid,json[3],args,file)
bt.name=file
bt.id=1
_genBehaviorTree(json[4][1],bt,bt,1)
return bt
end
end

function behaviorManager:setSharedValues(bt,data)
if data then
for k,v in pairs(data)do
bt:setSharedVar(k,v)
end
end
end







function behaviorManager:addBehaviorTree(fileName,args,bUpdate,initData,autoRemove)
local bt=self:getBTInPool(fileName)
if bt then
self:setSharedValues(bt,initData)
bt:setArgs(args)
bt:reset()
else
bt=self:loadBehaviorTree(fileName,args)
self:setSharedValues(bt,initData)
bt:start()
end
bt.GUID=self:getGUID()
if bt then
_allBehaviorTreeDict[bt.uid]=bt
if bUpdate then
_updateBehaviorTreeDict[bt.uid]=bt
end
bt.autoRemove=autoRemove
else
logErr('找不到行为树:',fileName)
return nil
end
return bt
end


function behaviorManager:removeBehaviorTree(bt)
if _allBehaviorTreeDict[bt.uid]and not bt:isRemove()then
bt:broke()
bt:remove()
bt:clear()



_removeBehaviorTreeDict[bt.uid]=bt
end
end


function behaviorManager:getBTInPool(fileName)





local trees=_behaviorTreePool[fileName]
if trees then
local tree=_remove(trees,1)
return tree
end
end


function behaviorManager:setBTToPool(bt)





local trees=_behaviorTreePool[bt.file]or{}
table.insert(trees,bt)
_behaviorTreePool[bt.file]=trees
end

function behaviorManager:getBehaviorTree(uid)
local bt=_allBehaviorTreeDict[uid]
if bt and not bt:isRemove()then
return bt
end
end

function behaviorManager:getStateData(uid)
local bt=self:getBehaviorTree(uid)
if bt then
return bt:getStateData()
end
return nil
end

function behaviorManager:printBTAllSharedVar(uid)
local bt=self:getBehaviorTree(uid)
if bt then
bt:printAllSharedVar()
end
end

function behaviorManager:getBTIDByFileName(name)
for k,v in pairs(_allBehaviorTreeDict)do
if v.file==name and not v:isRemove()then
return v.uid
end
end
return nil
end

function behaviorManager:getBehaviorTreeByFile(fileName)
local bts={}
for k,bt in pairs(_allBehaviorTreeDict)do
if bt.file==fileName and not bt:isRemove()then
table.insert(bts,bt)
end
end
return bts
end

function behaviorManager:setGlobalVar(key,value)
_globalVariables[key]=value
end

function behaviorManager:getGlobalVar(key)
return _globalVariables[key]
end

function behaviorManager:hasBehavior(uid)
if _allBehaviorTreeDict then
if _allBehaviorTreeDict[uid]then
return true
end
end
return false
end

function behaviorManager.onBehaviorTreeError(uid,filename)
logErr("onBehaviorTreeError",filename,uid)
end










