simpleModeControl=gameState.addListener({})


leftSimpleState={
hide=0,
task=1,
moneyDetail=2,
homeBuff=3,
}

leftFortSimpleState={
fort=1,
task=2,
}
leftXMSimpleState={
hide=0,
info=1,
kufang=2,
}

local _isSimple=false
local _isLeftSimple=leftSimpleState.task
local _isRightSimple=false
local _isFSSimple=false
local _isLeftXMSimple=leftXMSimpleState.info
local _isFortLeftSimple=leftFortSimpleState.fort

function simpleModeControl:onEnterState(isReconnect)
self:resetData()
end

function simpleModeControl:onLeaveState(isReconnect)
self:resetData()
end

function simpleModeControl:resetData()
_isSimple=false
_isLeftSimple=leftSimpleState.task
_isRightSimple=false
_isFSSimple=true
_isLeftXMSimple=leftXMSimpleState.info
_isFortLeftSimple=leftFortSimpleState.fort
end


function simpleModeControl:setSimple(flag)
_isSimple=flag
end

function simpleModeControl:isSimple()
return _isSimple
end


function simpleModeControl:setLeftSimple(state)
_isLeftSimple=state
end


function simpleModeControl:getLeftSimple()
return _isLeftSimple
end


function simpleModeControl:setRightSimple(flag)
_isRightSimple=flag
end


function simpleModeControl:getRightSimple()
return _isRightSimple
end


function simpleModeControl:setFuncStorageSimple(flag)
_isFSSimple=flag
end

function simpleModeControl:getFuncStorageSimple()
return _isFSSimple
end


function simpleModeControl:setLeftXMSimple(state)
_isLeftXMSimple=state
end


function simpleModeControl:getLeftXMSimple()
return _isLeftXMSimple
end


function simpleModeControl:setFortLeftSimple(state)
_isFortLeftSimple=state
end


function simpleModeControl:getFortLeftSimple()
return _isFortLeftSimple
end