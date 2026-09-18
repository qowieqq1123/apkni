







local _MODULENAME="xjBehaviorManager"
gameState.addListener(def_table(_MODULENAME))
xjBehaviorManager.name=_MODULENAME


xjBehaviorNodeType={
eParallel=1,
eSequence=2,
}
xjBehaviorNodeCfg={
[xjBehaviorNodeType.eParallel]='xjBehaviorNode_parallel',
[xjBehaviorNodeType.eSequence]='xjBehaviorNode_sequence',
}


xjBehaviorJobType={
eJob_gotoSearch=100,
eJob_searchCloud=101,
eJob_plotGoto=102,
eJob_plotBattle=103,
eJob_marchGoto=104,
eJob_marchBattle=105,
eJob_marchSingleGoto=106,
eJob_plotRetract=107,
eJob_respointGoto=102,
eJob_respointBattle=103,
eJob_respointRetract=104,
eJob_mojunboxGoto=108,
eJob_mojunboxBattle=109,
eJob_mojunboxRetract=110,
eJob_caravanEscortGoto=111,
}
xjBehaviorJobCfg={
[xjBehaviorJobType.eJob_gotoSearch]='xjBehaviorJob_gotoSearch',
[xjBehaviorJobType.eJob_searchCloud]='xjBehaviorJob_searchCloud',
[xjBehaviorJobType.eJob_plotGoto]='xjBehaviorJob_plotGoto',
[xjBehaviorJobType.eJob_plotBattle]='xjBehaviorJob_plotBattle',
[xjBehaviorJobType.eJob_marchGoto]='xjBehaviorJob_marchGoto',
[xjBehaviorJobType.eJob_marchBattle]='xjBehaviorJob_marchBattle',
[xjBehaviorJobType.eJob_marchSingleGoto]='xjBehaviorJob_marchSingleGoto',
[xjBehaviorJobType.eJob_plotRetract]='xjBehaviorJob_plotRetract',
[xjBehaviorJobType.eJob_respointGoto]="xjBehaviorJob_respointGoto",
[xjBehaviorJobType.eJob_respointBattle]="xjBehaviorJob_respointBattle",
[xjBehaviorJobType.eJob_mojunboxGoto]="xjBehaviorJob_mojunboxGoto",
[xjBehaviorJobType.eJob_mojunboxBattle]="xjBehaviorJob_mojunboxBattle",
[xjBehaviorJobType.eJob_caravanEscortGoto]="xjBehaviorJob_caravanEscortGoto",
}

local treeLookup
local cfgLookup
local isInitTimer

function xjBehaviorManager:onEnterState(isReconnet)
xjBehaviorManager:initData()
end

function xjBehaviorManager:onLeaveState(isReconnet)
xjBehaviorManager:clearData()
end


function xjBehaviorManager.isNodeType(typo)
return typo<100
end

function xjBehaviorManager:initData()
treeLookup={}
cfgLookup=require('lua.gamesys.xianjie.behavior.xjBehaviorConfig')
end

function xjBehaviorManager:clearData()
if treeLookup==nil then return end
timeEventController.removeQuickTimerHandler(_MODULENAME)
for key,tree in pairs(treeLookup)do
tree:doBreak()
release_xjBehaviorTree(tree)
end
treeLookup=nil
cfgLookup=nil
isInitTimer=nil
end


function xjBehaviorManager:clearData2()
if treeLookup==nil then return end
timeEventController.removeQuickTimerHandler(_MODULENAME)
for key,tree in pairs(treeLookup)do
tree:doBreak()
release_xjBehaviorTree(tree)
end
treeLookup={}
isInitTimer=nil
end


function xjBehaviorManager:onQuickUpdate(interval)
if treeLookup==nil then return end
if next(treeLookup)~=nil then
local lp={}
for key,tree in pairs(treeLookup)do
if not tree.pcallerror then
local func=function()
if tree:tick(interval)then
lp[key]=tree
end
end
local func2=function(err)
tree.pcallerror=true
loggerUtil.logErrFMT('xjBehaviorManager tick err!{0}',err)
end
xpcall(func,func2)
end
end
if next(lp)then
for key,tree in pairs(lp)do
treeLookup[key]=nil
tree:doEnd()
release_xjBehaviorTree(tree)
end
end
lp=nil
else

isInitTimer=nil
timeEventController.removeQuickTimerHandler(_MODULENAME)
end
end


function xjBehaviorManager:triggerUpdate(key)
if treeLookup==nil then return end
local tree=treeLookup[key]
if tree then
if tree:tick()then
treeLookup[key]=nil
tree:doEnd()
release_xjBehaviorTree(tree)
end
end
end


function xjBehaviorManager:createTree(cfgname,initData,finishCB,isStart)
if treeLookup==nil then return end
local data=cfgLookup[cfgname]
if data==nil then



return
end
if not isInitTimer then
isInitTimer=true
timeEventController.addQuickTimerHandler(_MODULENAME,xjBehaviorManager)
end
local tree=new_xjBehaviorTree(data,initData,finishCB)
local key=tree:getKey()
treeLookup[key]=tree




return key
end


function xjBehaviorManager:removeTree(key)
if treeLookup==nil then return end
local tree=treeLookup[key]
if tree then
treeLookup[key]=nil
tree:doBreak()
release_xjBehaviorTree(tree)
end
end


function xjBehaviorManager:skipTree(key)
if treeLookup==nil then return end
local tree=treeLookup[key]
if tree then
treeLookup[key]=nil
tree:skip()
release_xjBehaviorTree(tree)
end
end
