









local xjTeamHandle_moGongZhuJun={}


function xjTeamHandle_moGongZhuJun:onInit()
self.onlykey=FMT.fmt('{0}_{1}',self.teamType,self.guid_str)
self.teamData=xianjieModel:getMoGongZJTeamData(self.guid)

local arenaId_64=self.teamData.data.paramList[1]
self.arenaId=mathHelper.int64_to_number(arenaId_64)

local arenaData=xianjieModel:getMoGongDataByMoGongId(self.arenaId)
if arenaData then
self.teamData.sceneidx=arenaData.sceneidx
else
local cfg=cfgHelper.get(cfg_fairylandclientbuildconfig_get,self.arenaId)
self.teamData.sceneidx=cfg.sceneidx
end


self.initiatorActorId=self.teamData.data.paramList[2]
if xianjieModel:isMoGongAtk(arenaId_64)then
self.hasAtkTarget=true
end

end

function xjTeamHandle_moGongZhuJun:getMarchtype()
return self.teamData and self.teamData.marchtype or-1
end

function xjTeamHandle_moGongZhuJun:getSpeedList()
return self.teamData.speedlist
end


function xjTeamHandle_moGongZhuJun:getSpeedMulti()
local speedlist=self:getSpeedList()
local len=#speedlist
if len>1 then
return math.floor(speedlist[len].param_2/speedlist[1].param_2)
end
return 1
end

function xjTeamHandle_moGongZhuJun:getBeginTime()
local speedlist=self.teamData.speedlist
return speedlist[1].param_1
end


function xjTeamHandle_moGongZhuJun:getZongMenPos()
local zmData=xianjieModel:getMyZongMenData()
local gridX_c,gridZ_c=xianjieController:worldGridCenterPos(zmData.gridX_c,zmData.gridZ_c,zmData.gridWidth,zmData.gridHeight)
return zmData.sceneidx,gridX_c,gridZ_c
end

function xjTeamHandle_moGongZhuJun:getTargetPos()

local targetData=xianjieModel:getMoGongDataByMoGongId(self.arenaId)
local gridX_c,gridZ_c=xianjieController:worldGridCenterPos(targetData.gridX,targetData.gridZ,targetData.gridWidth,targetData.gridHeight)
return targetData.sceneidx,gridX_c,gridZ_c,targetData.gridWidth,targetData.gridHeight
end


function xjTeamHandle_moGongZhuJun:getTargetData()
return xianjieModel:getMoGongDataByMoGongId(self.arenaId)
end

function xjTeamHandle_moGongZhuJun:getTeamState()
return nil
end



function xjTeamHandle_moGongZhuJun:getMoveWayTime(isBack)
return 0
end

function xjTeamHandle_moGongZhuJun:getMyMovePath(isBack)
return nil
end

function xjTeamHandle_moGongZhuJun:getMoveTagList(movePath,bTime)
local speedlist=self:getSpeedList()
return xianjieController:getMoveTagList(movePath,bTime,speedlist)
end

function xjTeamHandle_moGongZhuJun:geLerpTime()
return nil
end

function xjTeamHandle_moGongZhuJun:getOwnerName()
local teamData=self.teamData
if teamData.actorid then
local zmData=xianjieModel:getZongMenData(teamData.actorid)
if zmData then
return zmData.actorname
end
end
return'佚名'
end

function xjTeamHandle_moGongZhuJun:getTeamEnityKey()
return nil
end

function xjTeamHandle_moGongZhuJun:getTargetName(state)
local arenaId=self.arenaId
local cfg=cfgHelper.get(cfg_fairylandclientbuildconfig_get,arenaId)
local nameStr=cfg and cfg.name or"未知魔宫"
local targetData=xianjieModel:getMoGongDataByMoGongId(self.arenaId)
local str=nameStr
if targetData then
str=FMT.fmt("{0}({1},{2})",nameStr,targetData.gridX_original,targetData.gridZ_original)
end
return str
end

function xjTeamHandle_moGongZhuJun:getTargetIconName(state)
return"icon_zjm_duiwu_5"
end

function xjTeamHandle_moGongZhuJun:getTargetDesc()
return"驻军中"
end

function xjTeamHandle_moGongZhuJun:getStateIconName(state)
return nil
end

function xjTeamHandle_moGongZhuJun:checkIsShowProgress(state)
return false
end

function xjTeamHandle_moGongZhuJun:checkIsOnMove(state,isBack)
return false
end

function xjTeamHandle_moGongZhuJun:checkMyWaiPai()
return self.teamData.isMyWaiPai
end


function xjTeamHandle_moGongZhuJun:maskSpeeUp()
return true
end




function xjTeamHandle_moGongZhuJun:doRetract()
local content='该部队驻军魔宫中，您确定要召回队伍吗？'
local arenaId=self.arenaId
local guid=self.guid
local callback=function()
moGongZhengDuoActController:reqGetMoGongZhuJunRetract(arenaId,guid)
end
local dialogue=UIDialogManager.getConfirmDialogEx(nil,{
content=content,
okcb=callback
})
dialogue:show()
end

function xjTeamHandle_moGongZhuJun:checkRetract()

local isSelfInitiator=playerModel:checkActorId(self.initiatorActorId)

return isSelfInitiator
end



function xjTeamHandle_moGongZhuJun:checkDetailOpen(isWarning)
return false
end

function xjTeamHandle_moGongZhuJun:onDetailShow()
return false
end



function xjTeamHandle_moGongZhuJun:onDelete()

end


function xjTeamHandle_moGongZhuJun:checkMyEnemyType()
local actorid=self.teamData.data.actorid
local selfActorId=playerModel:getActorID()
if mathHelper.compareInt64(actorid,selfActorId)then
return xjEnemyType.eSelf
end

local xmGuid=self.teamData.data.xmGuid
local xm=xianmengModel:getMyXMGuildID()
if mathHelper.compareInt64(xmGuid,xm)then
return xjEnemyType.eAllies
end

return xjEnemyType.eEnemy
end

return xjTeamHandle_moGongZhuJun