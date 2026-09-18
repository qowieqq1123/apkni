









local xjTeamHandle_AttackMoJun={}


function xjTeamHandle_AttackMoJun:onInit()
self.onlykey=FMT.fmt('{0}_{1}',self.teamType,self.marchguid_str)
self.teamData=xianjieModel:getSelfMoJunTeamData(self.marchguid)
self.teamData.initiatorActorId=self.teamData.data.paramList[2]
self.build_id=self.teamData.data.paramList[1]
self.hasAtkTarget=true
end


function xjTeamHandle_AttackMoJun:checkMyEnemyType()
return xianjieModel:checkEnemyType(self.teamData.initiatorActorId)
end

function xjTeamHandle_AttackMoJun:getMarchtype()
return self.teamData and self.teamData.marchtype or-1
end

function xjTeamHandle_AttackMoJun:getSpeedList()
return nil
end


function xjTeamHandle_AttackMoJun:getSpeedMulti()
return 1
end

function xjTeamHandle_AttackMoJun:getBeginTime()
return nil




end


function xjTeamHandle_AttackMoJun:getZongMenPos()
local zmData=xianjieModel:getMyZongMenData()
local gridX_c,gridZ_c=xianjieController:worldGridCenterPos(zmData.gridX_c,zmData.gridZ_c,zmData.gridWidth,zmData.gridHeight)
return zmData.sceneidx,gridX_c,gridZ_c
end

function xjTeamHandle_AttackMoJun:getTargetPos()

local targetData=xianjieModel:getMoJunEntityData()
local gridX_c,gridZ_c=xianjieController:worldGridCenterPos(targetData.gridX,targetData.gridZ,targetData.gridWidth,targetData.gridHeight)
return targetData.sceneidx,gridX_c,gridZ_c,targetData.gridWidth,targetData.gridHeight
end


function xjTeamHandle_AttackMoJun:getTargetData()
return xianjieModel:getMoJunEntityData()
end

function xjTeamHandle_AttackMoJun:getTeamState()
return xjMarchTeamStateType.eNone



















end



function xjTeamHandle_AttackMoJun:getMoveWayTime(isBack)
return nil
end

function xjTeamHandle_AttackMoJun:getMyMovePath(isBack)
return nil




























end

function xjTeamHandle_AttackMoJun:geLerpTime()
return nil
end

function xjTeamHandle_AttackMoJun:getOwnerName()
local teamData=self.teamData
if teamData.initiatorActorId then
local zmData=xianjieModel:getZongMenData(teamData.initiatorActorId)
if zmData then
return zmData.actorname
end
end
return'佚名'
end

function xjTeamHandle_AttackMoJun:getTeamEnityKey()

return nil
end

function xjTeamHandle_AttackMoJun:getTargetName(state)
local mojunData=xianjieModel:getMoJunData()
local build_id=mojunData.build_id
local cfg=cfgHelper.get1(cfg_fairylandclientbuildconfig_get,build_id)
local nameStr=cfg and cfg.name or"未知魔君"
local str=nameStr
if cfg then
str=FMT.fmt("{0}({1},{2})",nameStr,cfg.x,cfg.y)
end
return str
end

function xjTeamHandle_AttackMoJun:getTargetIconName(state)
return"icon_zjm_duiwu_5"
end

function xjTeamHandle_AttackMoJun:getTargetDesc()
return"驻军中"
end

function xjTeamHandle_AttackMoJun:getStateIconName(state)
return nil
end

function xjTeamHandle_AttackMoJun:checkIsShowProgress(state)
return false
end

function xjTeamHandle_AttackMoJun:checkIsOnMove(state,isBack)
return false
end

function xjTeamHandle_AttackMoJun:checkMyWaiPai()
return self.teamData.isMyWaiPai
end


function xjTeamHandle_AttackMoJun:maskSpeeUp()
return false
end



function xjTeamHandle_AttackMoJun:checkDetailOpen(isWarning)
return false
end

function xjTeamHandle_AttackMoJun:onDetailShow()
return false
end



function xjTeamHandle_AttackMoJun:onDelete()

end

return xjTeamHandle_AttackMoJun