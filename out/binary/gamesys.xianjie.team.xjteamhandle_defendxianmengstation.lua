









local xjTeamHandle_DefendXianMengStation={}


function xjTeamHandle_DefendXianMengStation:onInit()
self.onlykey=FMT.fmt('{0}_{1}',self.teamType,self.guid_str)
self.teamData=xianjieModel:getSelfDefendXianMengTeamData(self.guid)
self.teamState=xjMarchTeamStateType.eNone
end

function xjTeamHandle_DefendXianMengStation:getMarchtype()
return self.teamData and self.teamData.marchtype or-1
end

function xjTeamHandle_DefendXianMengStation:getSpeedList()
return self.teamData.speedlist
end

function xjTeamHandle_DefendXianMengStation:getSpeedCnt()
return#self:getSpeedList()
end


function xjTeamHandle_DefendXianMengStation:getSpeedMulti()
local speedlist=self:getSpeedList()
local len=#speedlist
if len>1 then
return math.floor(speedlist[len].param_2/speedlist[1].param_2)
end
return 1
end

function xjTeamHandle_DefendXianMengStation:getBeginTime()
local speedlist=self.teamData.speedlist
return speedlist[1].param_1
end


function xjTeamHandle_DefendXianMengStation:getZongMenPos()
local zmData=xianjieModel:getMyZongMenData()
local gridX_c,gridZ_c=xianjieController:worldGridCenterPos(zmData.gridX,zmData.gridZ,zmData.gridWidth,zmData.gridHeight)
return zmData.sceneidx,gridX_c,gridZ_c
end

function xjTeamHandle_DefendXianMengStation:getTargetPos()
local guildId=xianmengModel:getMyXMGuildID()
local xmData=xianjieModel:getXianMengData(guildId)
local gridX_c,gridZ_c=xianjieController:worldGridCenterPos(xmData.gridX,xmData.gridZ,xmData.gridWidth,xmData.gridHeight)
return xmData.sceneidx,gridX_c,gridZ_c,xmData.gridWidth,xmData.gridHeight
end

function xjTeamHandle_DefendXianMengStation:getTeamState()
return self.teamState
end



function xjTeamHandle_DefendXianMengStation:getMoveWayTime(isBack)
return 0
end

function xjTeamHandle_DefendXianMengStation:getMyMovePath(isBack)
return nil
end

function xjTeamHandle_DefendXianMengStation:getMoveTagList(movePath,bTime)
local speedlist=self:getSpeedList()
return xianjieController:getMoveTagList(movePath,bTime,speedlist)
end

function xjTeamHandle_DefendXianMengStation:geLerpTime()
local state,time=self:getTeamState()
local endTime=time[1]
local curTime=gameUtilityModel.getServerShortTime2()
local lerpTime=endTime-curTime
if lerpTime<0 then lerpTime=0 end
return lerpTime
end

function xjTeamHandle_DefendXianMengStation:getOwnerName()
return playerModel:getActorName()
end

function xjTeamHandle_DefendXianMengStation:getTeamEnityKey()
return nil
end

function xjTeamHandle_DefendXianMengStation:getTargetName(state)
return"仙盟"
end

function xjTeamHandle_DefendXianMengStation:getTargetIconName(state)
state=state or self:getTeamState()
if state==xjMarchTeamStateType.eNone then
return"icon_zjm_duiwu_2"
else
return"icon_zjm_duiwu_4"
end
end

function xjTeamHandle_DefendXianMengStation:getTargetDesc()
return"驻守中"
end

function xjTeamHandle_DefendXianMengStation:getStateIconName(state)
state=state or self:getTeamState()
if state==xjMarchTeamStateType.eNone then
return"button_xiangongui_4"
end
end

function xjTeamHandle_DefendXianMengStation:checkIsShowProgress(state)
return false
end

function xjTeamHandle_DefendXianMengStation:checkIsOnMove(state,isBack)
return true
end

function xjTeamHandle_DefendXianMengStation:checkMyWaiPai()
return true
end


function xjTeamHandle_DefendXianMengStation:maskSpeeUp()
return true
end




function xjTeamHandle_DefendXianMengStation:doRetract()
if not self:checkRetract(true)then
return false
end
local marchguid=self.marchguid
local content='是否召回本队伍？召回的队伍将返回宗门（如有消耗的魔令会返还）'
local callback=function()

local param=jsonHelper.encode({playerModel:getActorIDStr()})
local guildId=xianmengModel:getMyXMGuildID()
xianjieController:reqOrder(guildId,xjOrderType.eDefendXianMengBack,{},{},param,0,nil,{})
end
local dialogue=UIDialogManager.getConfirmDialogEx(nil,{
content=content,
okcb=callback
})
dialogue:show()
return true
end



function xjTeamHandle_DefendXianMengStation:onDelete()

end

return xjTeamHandle_DefendXianMengStation