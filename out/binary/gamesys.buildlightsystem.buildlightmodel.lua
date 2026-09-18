






local _MODULENAME="buildlightModel"


def_table(_MODULENAME)
buildlightModel.name=_MODULENAME
buildlightModel.data={}

function buildlightModel:onAppStart()

end


function buildlightModel:onEnterState(isReconnect)

end


function buildlightModel:onProtocolReq()

end


function buildlightModel:onLeaveState(isReconnect)

self.data={}
end




function buildlightModel:isChangeOpenBL_fightPreSelect()
local flag=MysteryModel:is_in_mystery()
local ret=systemModel.isOpen(SYSTEM_DEFINE.eBuildLight)
local isinxj=mainControl:isInScene(eSceneType.eXianJie)
local ischange=ret and not flag and not isinxj
return ischange
end

function buildlightModel:isChangeOpenBL_fightBattle()
local flag=MysteryModel:is_in_mystery()
local ret=systemModel.isOpen(SYSTEM_DEFINE.eBuildLight)
local isinxj=mainControl:isInScene(eSceneType.eXianJie)
local ischange=ret and not flag and not isinxj
return ischange
end

function buildlightModel:isChangeOpenBL_fightStage()
local flag=MysteryModel:is_in_mystery()
local ret=systemModel.isOpen(SYSTEM_DEFINE.eBuildLight)
local isinxj=mainControl:isInScene(eSceneType.eXianJie)
local ischange=ret and not flag and not isinxj
return ischange
end

