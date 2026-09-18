newbieForceHandle={}

NEWBIE_ACTION_ONFORCE_FUNC=
{
TempPauseTaYinGame='TempPauseTaYinGame',
BuildingMsgForceSpe1='BuildingMsgForceSpe1',
StopYunYouMerchantAI='StopYunYouMerchantAI',
BuildingMsgForceSpe2='BuildingMsgForceSpe2',
StopZongMenVisitorAI1='StopZongMenVisitorAI1',
ForcePauseTaYinGame='ForcePauseTaYinGame',
XGSZVisit='XGSZVisit',
UnForceResumtTaYinGame='UnForceResumtTaYinGame',
}

local _handles={
[NEWBIE_ACTION_ONFORCE_FUNC.TempPauseTaYinGame]={
getForce=function()
UIManager:invokeUIMethod("UISystemZongMenTaYinWin1","stopChallengeTimer")
end,
lostForce=function()
UIManager:invokeUIMethod("UISystemZongMenTaYinWin1","startChallengeTimer")
end,
},
[NEWBIE_ACTION_ONFORCE_FUNC.ForcePauseTaYinGame]={
getForce=function()
UIManager:invokeUIMethod("UISystemZongMenTaYinWin1","stopChallengeTimer")
end,
lostForce=function()

end,
},
[NEWBIE_ACTION_ONFORCE_FUNC.UnForceResumtTaYinGame]={
getForce=function()

end,
lostForce=function()
UIManager:invokeUIMethod("UISystemZongMenTaYinWin1","startChallengeTimer")
end,
},
[NEWBIE_ACTION_ONFORCE_FUNC.BuildingMsgForceSpe1]={
getForce=function()
UIManager:invokeUIMethod("UIBuildingMsgWin","forceMsgSpe",1)
end,
lostForce=function()

end,
},
[NEWBIE_ACTION_ONFORCE_FUNC.StopYunYouMerchantAI]={
getForce=function()
yunyouMerchantController:stopEntityAI()
end,
lostForce=function()
yunyouMerchantController:resumeEntityAI()
UIManager:invokeUIMethod("UIBuildingMsgWin","unforceMsgSpe")
end,
},
[NEWBIE_ACTION_ONFORCE_FUNC.BuildingMsgForceSpe2]={
getForce=function()
UIManager:invokeUIMethod("UIBuildingMsgWin","forceMsgSpe",2)
end,
lostForce=function()

end,
},
[NEWBIE_ACTION_ONFORCE_FUNC.StopZongMenVisitorAI1]={
getForce=function()
zongmenVisitorController:stopEntityAI(mapIdType.zhufeng)
end,
lostForce=function()
zongmenVisitorController:resumeEntityAI(mapIdType.zhufeng)
UIManager:invokeUIMethod("UIBuildingMsgWin","unforceMsgSpe")
end,
},
[NEWBIE_ACTION_ONFORCE_FUNC.XGSZVisit]={
getForce=function()
UIManager:invokeUIMethod("UIBuildingMsgWin","forceMsgSpe",4)
end,
lostForce=function()
end,
},
}

function newbieForceHandle:getHandle(type)
return _handles[type]
end

function newbieForceHandle:triggerGetForce(type)
local handle=self:getHandle(type)
if handle and handle.getForce then
handle.getForce()
end
end

function newbieForceHandle:triggerLostForce(type)
local handle=self:getHandle(type)
if handle and handle.lostForce then
handle.lostForce()
end
end