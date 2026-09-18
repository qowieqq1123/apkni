









local xjTeamHandle_jiJieWait={}


function xjTeamHandle_jiJieWait:onInit()
self.onlykey=FMT.fmt('{0}_{1}',self.teamType,self.guid_str)
self.teamData=xianjieModel:getSelfJiJieTeamData(self.guid)
end

function xjTeamHandle_jiJieWait:getMarchtype()
return self.teamData and self.teamData.marchtype or-1
end

function xjTeamHandle_jiJieWait:getSpeedList()
return self.teamData.speedlist
end

function xjTeamHandle_jiJieWait:getSpeedCnt()
return#self:getSpeedList()
end


function xjTeamHandle_jiJieWait:getSpeedMulti()
local speedlist=self:getSpeedList()
local len=#speedlist
if len>1 then
return math.floor(speedlist[len].param_2/speedlist[1].param_2)
end
return 1
end

function xjTeamHandle_jiJieWait:getBeginTime()
local speedlist=self.teamData.speedlist
return speedlist[1].param_1
end


function xjTeamHandle_jiJieWait:getZongMenPos()
local teamData=self.teamData
local paramList=teamData.data.paramList
local zmData
if paramList and next(paramList)then
local actorId=paramList[2]
zmData=xianjieModel:getZongMenData(actorId)
else
zmData=xianjieModel:getMyZongMenData()
end
local gridX_c,gridZ_c=xianjieController:worldGridCenterPos(zmData.gridX_c,zmData.gridZ_c,zmData.gridWidth,zmData.gridHeight)
return zmData.sceneidx,gridX_c,gridZ_c
end

function xjTeamHandle_jiJieWait:getTargetPos()









local teamData=self.teamData
local paramList=teamData.data.paramList
local zmData
if paramList and next(paramList)then
local actorId=paramList[2]
zmData=xianjieModel:getZongMenData(actorId)
else
zmData=xianjieModel:getMyZongMenData()
end
local gridX_c,gridZ_c=xianjieController:worldGridCenterPos(zmData.gridX_c,zmData.gridZ_c,zmData.gridWidth,zmData.gridHeight)
return zmData.sceneidx,gridX_c,gridZ_c,zmData.gridWidth,zmData.gridHeight
end

function xjTeamHandle_jiJieWait:getTeamState()
local curTime=gameUtilityModel.getServerShortTime2()
local teamData=self.teamData
local paramList=teamData.data.paramList
local targetTime=mathHelper.int64_to_number(paramList[1])
local lerp=targetTime-curTime
if lerp>0 then
return xjJiJieTeamStateType.eWaitJijie,{targetTime,targetTime-curTime},lerp
elseif lerp<=0 then
local isEnoughSoldier=false
if isEnoughSoldier then
return xjJiJieTeamStateType.eWaitStart,{targetTime,targetTime-curTime},lerp
else
return xjJiJieTeamStateType.eNone,{targetTime,targetTime-curTime},lerp
end
end
end



function xjTeamHandle_jiJieWait:getMoveWayTime(isBack)
return 0
end

function xjTeamHandle_jiJieWait:getMyMovePath(isBack)
return nil
end

function xjTeamHandle_jiJieWait:getMoveTagList(movePath,bTime)
local speedlist=self:getSpeedList()
return xianjieController:getMoveTagList(movePath,bTime,speedlist)
end

function xjTeamHandle_jiJieWait:geLerpTime()
local state,time=self:getTeamState()
local endTime=time[1]
local curTime=gameUtilityModel.getServerShortTime2()
local lerpTime=endTime-curTime
if lerpTime<0 then lerpTime=0 end
return lerpTime
end

function xjTeamHandle_jiJieWait:getOwnerName()
local teamData=self.teamData
if teamData.actorid then
local zmData=xianjieModel:getZongMenData(teamData.actorid)
if zmData then
return zmData.actorname
end
end
return'佚名'
end

function xjTeamHandle_jiJieWait:getTeamEnityKey()

return nil
end

function xjTeamHandle_jiJieWait:getTargetName(state)
state=state or self:getTeamState()
if state==xjJiJieTeamStateType.eWaitJijie then
return"集结中"
elseif state==xjJiJieTeamStateType.eWaitStart then
return"等待集结出击"
elseif state==xjJiJieTeamStateType.eNone then
return"集结已超时"
end
end

function xjTeamHandle_jiJieWait:getTargetIconName(state)
state=state or self:getTeamState()
if state==xjJiJieTeamStateType.eNone then
return"icon_zjm_duiwu_2"
elseif state==xjJiJieTeamStateType.eWaitJijie or state==xjJiJieTeamStateType.eWaitStart then
return"icon_zjm_duiwu_4"
end
end

function xjTeamHandle_jiJieWait:getTargetDesc()
local state,time=self:getTeamState()
local nowTime=timeHelper.getServerShortTime()
local lerp=time[1]-nowTime
if state==xjJiJieTeamStateType.eWaitJijie then

local time_str=timeHelper.format_time_stamp(lerp,true)
time_str=string.format('剩余时间：%s',time_str)
return time_str
elseif state==xjJiJieTeamStateType.eWaitStart then
return"等待出击"
elseif state==xjJiJieTeamStateType.eNone then
return"请催促队员尽快赶到"
end
end

function xjTeamHandle_jiJieWait:getStateIconName(state)
state=state or self:getTeamState()
if state==xjJiJieTeamStateType.eBattle then
return"button_xiangongui_4"
end
end

function xjTeamHandle_jiJieWait:checkIsShowProgress(state)
return false
end

function xjTeamHandle_jiJieWait:checkIsOnMove(state,isBack)
state=state or self:getTeamState()
if state==xjJiJieTeamStateType.eWaitJijie or state==xjJiJieTeamStateType.eWaitStart then
return true
end

return false
end

function xjTeamHandle_jiJieWait:checkMyWaiPai()
return self.teamData.isMyWaiPai
end


function xjTeamHandle_jiJieWait:maskSpeeUp()
return true
end




function xjTeamHandle_jiJieWait:doRetract()
if not self:checkRetract(true)then
return false
end
local marchguid=self.marchguid
local content='是否召回本队伍？召回的队伍将返回宗门（如有消耗的仙令会返还）'
local callback=function()
xianjieController:reqMarchRetract(marchguid)
end
local dialogue=UIDialogManager.getConfirmDialogEx(nil,{
content=content,
okcb=callback
})
dialogue:show()
return true
end



function xjTeamHandle_jiJieWait:checkDetailOpen(isWarning)
return true
end

function xjTeamHandle_jiJieWait:onDetailShow()
local teamSceneIdx=self.teamData and self.teamData.sceneidx or xianjienSceneIndexType.eXianJie
local teamLogicSceneType=xianjieController:transSceneIdxToLogicSceneType(teamSceneIdx)
local nowSceneIdx=xianjieModel:getSceneIndex()
local nowLogicSceneType=xianjieController:transSceneIdxToLogicSceneType(nowSceneIdx)
if teamLogicSceneType~=nowLogicSceneType then
local content="该队伍不在当前场景 是否跳转至对应场景？"
local show_data={
type='UIDialouge',
title='提示',
content=content,
oktext='前往',
canceltext='取消',
okcallback=function()
local sceneType=xianjieModel:sceneIndex2SceneType(teamSceneIdx)
return xianjieController:jumpXianJie(sceneType,nil,function()
return self:onDetailShow()
end)
end
}
local dialog=UIDialogManager.newDialog(show_data)
dialog:show()
return false
end

local teamData=self.teamData
local paramList=teamData.data.paramList
if paramList and next(paramList)then
local actorId=paramList[2]
local guid=self.guid
UIManager:showWindow("UIXianJie_JiJie_msgWin",{actorId=actorId,guid=guid,sceneidx=teamSceneIdx})
end
end



function xjTeamHandle_jiJieWait:onDelete()

end

return xjTeamHandle_jiJieWait