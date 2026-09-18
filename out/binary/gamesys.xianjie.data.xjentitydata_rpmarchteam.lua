









local xjEntityData_RPMarchTeam={}












function xjEntityData_RPMarchTeam:onInit()
self.name="xjEntityData_RPMarchTeam"
self.guid_str=self.guid_str or tostring(self.guid)
self.rpData=xianjieModel:getResPointData(self.guid)

if self.marchData and not self.marchJson then

elseif not self.marchData and self.marchJson then
self.marchData=jsonHelper.decode(self.marchJson)
end

self:correctData()
self.marchJson=jsonHelper.encode(self.marchData)
end

function xjEntityData_RPMarchTeam:correctData()
if not xianjienSceneIndexType:isMoJie(self.marchData.dSinceInfo[1])then
local zmPos=xianjieModel:getZongMenOutPos()
self.marchData.dSinceInfo[1]=self.marchData.dSinceInfo[1]>xianjienSceneIndexType.eXianJie and zmPos[1]or self.marchData.dSinceInfo[1]
self.marchData.dTargetInfo[1]=self.marchData.dTargetInfo[1]>xianjienSceneIndexType.eXianJie and zmPos[1]or self.marchData.dTargetInfo[1]
end
end

function xjEntityData_RPMarchTeam:refreshData(data)
self.marchData=data
self:correctData()
self.marchJson=jsonHelper.encode(self.marchData)
end

function xjEntityData_RPMarchTeam:refreshJson(json)
self.marchData=jsonHelper.decode(json)
self:correctData()
self.marchJson=jsonHelper.encode(self.marchData)
end


function xjEntityData_RPMarchTeam:getMarchData(key)
return self.marchData[key]
end

function xjEntityData_RPMarchTeam:setMarchData(key,data)
self.marchData[key]=data
self.marchJson=jsonHelper.encode(self.marchData)
end

function xjEntityData_RPMarchTeam:compareKey(guid)
return self.guid_str==tostring(guid)
end


function xjEntityData_RPMarchTeam:initBehaviorData()
if self.behaviorData==nil then
self.behaviorData={guid=self.guid}
end
end

function xjEntityData_RPMarchTeam:createBehavior(sceneidx,isStart,isContinue)
local dDataType=self:getMarchData("dDataType")
if dDataType<=0 then
return
end
local teamHandle=self:getTeamHandle()
if not xianjieModel:isInitScene()then
return
end





local state=teamHandle:getTeamState()
local typo
if state==xjMarchTeamStateType.eBattle then
typo='respoint_battle'
elseif state==xjMarchTeamStateType.eGoto or state==xjMarchTeamStateType.eBack then
typo='respoint_goto'
end

local guid=self.guid
if typo then
if teamHandle.teamType==xjTeamHandleType.eResPointTeam and state==xjMarchTeamStateType.eBack then
local correct=xianjieModel:checkMarchSoureCorrect(self)
if correct then
xianjieController:reqXianJieResPointMarchSave(self.guid,self.marchJson)
end
end
if not isContinue then
self:clearBehaviorEx()
end
self:initBehaviorData()
local finishCB=function(tree)
local march=xianjieModel:getResPointMarch(guid)
march:clearBehavior(tree)
local flag=march:createBehavior(nil,true,true)
if not flag then

march:clearBehaviorEx()
end









notifySystem:postNotify(notifyConfig.onXianJieWaiPaiChange,CHANGE_TYPE.eChanged,march:getTeamHandle())
end
self.behaviorID=xjBehaviorManager:createTree(typo,self.behaviorData,finishCB,isStart)
return true
else
xianjieController:doResPointMarchDelete(self.guid)
end
end

function xjEntityData_RPMarchTeam:playBattleResult()
local dataType=self:getMarchData("dDataType")
if dataType==xjResPointMarchTeamType.eNormal then
local teamHandle=self:getTeamHandle()
local sceneidx,gridX_c,gridZ_c=teamHandle:getTargetPos()
if xianjieModel:checkSceneIndex(sceneidx)then
local pos=xianjieController:worldGridPos2WorldPos4(gridX_c,gridZ_c,sceneidx)
local checkAOI=xianjieController:checkPosInAOI(pos)
if checkAOI then
local size=xianjieController:gridSize2WorldSize2(1,1)
local modelID

local rpData=xianjieModel:getResPointData(self.guid)
if rpData and rpData.deadTime==nil then

modelID=6052
else

modelID=6051
end
xianjieController:createNormalEffect2(modelID,pos,size,2,3,Vector3(0,0.5,0))
end
end
end
end


function xjEntityData_RPMarchTeam:initTeamHandle()
if self.teamHandleID==nil then
local dataType=self:getMarchData("dDataType")
local teamType=xianjieModel:getResPointMarchTeamType(dataType)
if teamType then
self.teamHandleID=xianjieController:addXJTeamHandle(teamType,{guid=self.guid})
end
end
end


function xjEntityData_RPMarchTeam:onDelete()

end

return xjEntityData_RPMarchTeam