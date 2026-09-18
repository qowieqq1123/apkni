
xianjieMainWinSimpleModeConfig={}

function xianjieMainWinSimpleModeConfig:onAppStart()
self.recordList={}
end







local _stateEnum={
eClose=0,
eOpen=1,
}

function xianjieMainWinSimpleModeConfig:getRecordState(key,sceneIdx)
sceneIdx=sceneIdx or xianjieModel:getSceneIndex()
if sceneIdx==nil then return false end
local logicSceneType=xianjieController:transSceneIdxToLogicSceneType(sceneIdx)
if logicSceneType==nil then return false end
local sceneRecord=self.recordList[logicSceneType]
sceneRecord=sceneRecord or{}
self.recordList[logicSceneType]=sceneRecord

key=key or'default'
local state=sceneRecord[key]

if state==nil then
sceneRecord[key]=sceneRecord['default']or _stateEnum.eClose
return sceneRecord[key]==_stateEnum.eOpen
else
return state==_stateEnum.eOpen
end
end


function xianjieMainWinSimpleModeConfig:changeRecordState(key,state)
local sceneIdx=xianjieModel:getSceneIndex()
if sceneIdx==nil then return false end
local logicSceneType=xianjieController:transSceneIdxToLogicSceneType(sceneIdx)
if logicSceneType==nil then return false end

state=state or _stateEnum.eClose

key=key or'default'
local sceneRecord=self.recordList[logicSceneType]
sceneRecord=sceneRecord or{}
self.recordList[logicSceneType]=sceneRecord

local lastState=sceneRecord[key]or _stateEnum.eClose
local nowState=lastState==_stateEnum.eOpen and _stateEnum.eClose or _stateEnum.eOpen

sceneRecord[key]=nowState

return nowState==_stateEnum.eOpen
end

function xianjieMainWinSimpleModeConfig:changeSceneRecordState()
local sceneIdx=xianjieModel:getSceneIndex()
if sceneIdx==nil then return false end
local logicSceneType=xianjieController:transSceneIdxToLogicSceneType(sceneIdx)
if logicSceneType==nil then return false end

local key='default'
local sceneRecord=self.recordList[logicSceneType]
sceneRecord=sceneRecord or{}
self.recordList[logicSceneType]=sceneRecord

local lastState=sceneRecord[key]or _stateEnum.eClose
local nowState=lastState==_stateEnum.eOpen and _stateEnum.eClose or _stateEnum.eOpen

for key,state in pairs(sceneRecord)do
sceneRecord[key]=nowState
end

return nowState==_stateEnum.eOpen
end


function xianjieMainWinSimpleModeConfig:print_CurScene_SimpleNode_State_GM()
local sceneIdx=xianjieModel:getSceneIndex()
if sceneIdx==nil then return false end
local logicSceneType=xianjieController:transSceneIdxToLogicSceneType(sceneIdx)
if logicSceneType==nil then return false end
local sceneRecord=self.recordList[logicSceneType]

if next(sceneRecord)then
for key,state in pairs(sceneRecord)do

end
end
end
