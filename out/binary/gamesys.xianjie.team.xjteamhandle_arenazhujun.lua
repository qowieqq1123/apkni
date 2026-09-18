









local xjTeamHandle_arenaZhuJun={}


function xjTeamHandle_arenaZhuJun:onInit()
self.onlykey=FMT.fmt('{0}_{1}',self.teamType,self.guid_str)
self.teamData=xianjieModel:getArenaZJTeamData(self.guid)
local arenaId_64=self.teamData.data.paramList[1]
self.arenaId=mathHelper.int64_to_number(arenaId_64)
self.initiatorActorId=self.teamData.data.paramList[2]
if xianjieModel:isArenaAtk(arenaId_64)or xianjieModel:isMoGongAtk(arenaId_64)then
self.hasAtkTarget=true
end
end

function xjTeamHandle_arenaZhuJun:getMarchtype()
return self.teamData and self.teamData.marchtype or-1
end

function xjTeamHandle_arenaZhuJun:getSpeedList()
return self.teamData.speedlist
end


function xjTeamHandle_arenaZhuJun:getSpeedMulti()
local speedlist=self:getSpeedList()
local len=#speedlist
if len>1 then
return math.floor(speedlist[len].param_2/speedlist[1].param_2)
end
return 1
end

function xjTeamHandle_arenaZhuJun:getBeginTime()
local speedlist=self.teamData.speedlist
return speedlist[1].param_1
end


function xjTeamHandle_arenaZhuJun:getZongMenPos()
local zmData=xianjieModel:getMyZongMenData()
local gridX_c,gridZ_c=xianjieController:worldGridCenterPos(zmData.gridX_c,zmData.gridZ_c,zmData.gridWidth,zmData.gridHeight)
return zmData.sceneidx,gridX_c,gridZ_c
end

function xjTeamHandle_arenaZhuJun:getTargetPos()

local targetData=xianjieModel:getArenaDataByArenaId(self.arenaId)
local gridX_c,gridZ_c=xianjieController:worldGridCenterPos(targetData.gridX,targetData.gridZ,targetData.gridWidth,targetData.gridHeight)
return targetData.sceneidx,gridX_c,gridZ_c,targetData.gridWidth,targetData.gridHeight
end


function xjTeamHandle_arenaZhuJun:getTargetData()
return xianjieModel:getArenaDataByArenaId(self.arenaId)
end

function xjTeamHandle_arenaZhuJun:getTeamState()
return nil
end



function xjTeamHandle_arenaZhuJun:getMoveWayTime(isBack)
return 0
end

function xjTeamHandle_arenaZhuJun:getMyMovePath(isBack)
return nil
end

function xjTeamHandle_arenaZhuJun:getMoveTagList(movePath,bTime)
local speedlist=self:getSpeedList()
return xianjieController:getMoveTagList(movePath,bTime,speedlist)
end

function xjTeamHandle_arenaZhuJun:geLerpTime()
return nil
end

function xjTeamHandle_arenaZhuJun:getOwnerName()
local teamData=self.teamData
if teamData.actorid then
local zmData=xianjieModel:getZongMenData(teamData.actorid)
if zmData then
return zmData.actorname
end
end
return'佚名'
end

function xjTeamHandle_arenaZhuJun:getTeamEnityKey()

return nil
end

function xjTeamHandle_arenaZhuJun:getTargetName(state)
local arenaId=self.arenaId
local cfg=cfgHelper.get(cfg_fairylandclientbuildconfig_get,arenaId)
local nameStr=cfg and cfg.name or"未知擂台"
local targetData=xianjieModel:getArenaDataByArenaId(self.arenaId)
local str=nameStr
if targetData then
str=FMT.fmt("{0}({1},{2})",nameStr,targetData.gridX_original,targetData.gridZ_original)
end
return str
end

function xjTeamHandle_arenaZhuJun:getTargetIconName(state)
return"icon_zjm_duiwu_5"
end

function xjTeamHandle_arenaZhuJun:getTargetDesc()
return"驻军中"
end

function xjTeamHandle_arenaZhuJun:getStateIconName(state)
return nil
end

function xjTeamHandle_arenaZhuJun:checkIsShowProgress(state)
return false
end

function xjTeamHandle_arenaZhuJun:checkIsOnMove(state,isBack)
return false
end

function xjTeamHandle_arenaZhuJun:checkMyWaiPai()
return self.teamData.isMyWaiPai
end


function xjTeamHandle_arenaZhuJun:maskSpeeUp()
return true
end




function xjTeamHandle_arenaZhuJun:doRetract()
local content='该部队驻军擂台中，您确定要召回队伍吗？'
local arenaId=self.arenaId
local guid=self.guid
local callback=function()
xianJieArenaActController:reqGetXJArenaZhuJunRetract(arenaId,guid)
end
local dialogue=UIDialogManager.getConfirmDialogEx(nil,{
content=content,
okcb=callback
})
dialogue:show()
end

function xjTeamHandle_arenaZhuJun:checkRetract()

local isSelfInitiator=playerModel:checkActorId(self.initiatorActorId)

return isSelfInitiator
end



function xjTeamHandle_arenaZhuJun:checkDetailOpen(isWarning)
return false
end

function xjTeamHandle_arenaZhuJun:onDetailShow()
return false
end



function xjTeamHandle_arenaZhuJun:onDelete()

end

return xjTeamHandle_arenaZhuJun