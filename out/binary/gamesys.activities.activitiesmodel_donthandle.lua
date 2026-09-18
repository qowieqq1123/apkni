
dontHandleSubActivityJump={
[SUB_ACTIVITY_TYPE.ePassPortAct2]=function(actId,subType,subId,extraParams)
local passporttype=txzType.act
local guid=UITYTongXingZhengModel:getGuidByActID(passporttype,actId,subType,subId)
if guid then
return UITYTongXingZhengController:showTXZWin(guid)
end
return false
end
}

dontHandleSubActivityReddot={
[SUB_ACTIVITY_TYPE.ePassPortAct2]=function(actId,subType,subId)
local passporttype=txzType.act
local guid=UITYTongXingZhengModel:getGuidByActID(passporttype,actId,subType,subId)
if guid then
return UITYTongXingZhengController:checkReddot(guid)
end
return false
end
}

function activitiesModel:getDontHandleSubTypeJump(subType)
return dontHandleSubActivityJump[subType]
end

function activitiesModel:getDontHandleSubTypeReddot(subType)
return dontHandleSubActivityReddot[subType]
end

function activitiesModel:isDontHandleSubType(subType)
return cfgHelper.get2(cfg_subactivitytypeconfig_get,subType,'dontHandle')
end