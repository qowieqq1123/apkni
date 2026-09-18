









local xjEntityData_MoJunBoxTeam={}








function xjEntityData_MoJunBoxTeam:onInit()
self.name="xjEntityData_MoJunBoxTeam"
self.guid_str=self.guid_str or tostring(self.guid)

if self.marchData and not self.marchJson then

elseif not self.marchData and self.marchJson then
self.marchData=jsonHelper.decode(self.marchJson)
end

self:correctData()
self.marchJson=jsonHelper.encode(self.marchData)

end

function xjEntityData_MoJunBoxTeam:correctData()
if xianjienSceneIndexType:isMoJie(self.marchData.dSinceInfo[1])then
local zmPos=xianjieModel:getZongMenOutPos_mojie()
self.marchData.dSinceInfo[1]=self.marchData.dSinceInfo[1]~=xianjienSceneIndexType.eMoJie and zmPos[1]or self.marchData.dSinceInfo[1]
self.marchData.dTargetInfo[1]=self.marchData.dTargetInfo[1]~=xianjienSceneIndexType.eMoJie and zmPos[1]or self.marchData.dTargetInfo[1]
end
end

function xjEntityData_MoJunBoxTeam:refreshData(data)
self.marchData=data
self:correctData()
self.marchJson=jsonHelper.encode(self.marchData)
end

function xjEntityData_MoJunBoxTeam:refreshJson(json)
self.marchData=jsonHelper.decode(json)
self:correctData()
self.marchJson=jsonHelper.encode(self.marchData)
end


function xjEntityData_MoJunBoxTeam:getMarchData(key)
return self.marchData[key]
end

function xjEntityData_MoJunBoxTeam:setMarchData(key,data)
self.marchData[key]=data
self.marchJson=jsonHelper.encode(self.marchData)
end

function xjEntityData_MoJunBoxTeam:compareKey(guid)
return self.guid_str==tostring(guid)
end


function xjEntityData_MoJunBoxTeam:initBehaviorData()
if self.behaviorData==nil then
self.behaviorData={guid=self.guid}
end
end

function xjEntityData_MoJunBoxTeam:createBehavior(sceneidx,isStart,isContinue)
local teamHandle=self:getTeamHandle()
if not xianjieModel:isInitScene()then
return
end

sceneidx=sceneidx or xianjieModel:getSceneIndex()
if not xianjienSceneIndexType:isMoJie(sceneidx)then
return
end

local state=teamHandle:getTeamState()
local typo
if state==xjMarchTeamStateType.eBattle then
typo='mojunbox_battle'
elseif state==xjMarchTeamStateType.eGoto or state==xjMarchTeamStateType.eBack then
typo='mojunbox_goto'
end

local guid=self.guid
if typo then
if not isContinue then
self:clearBehaviorEx()
end
self:initBehaviorData()
local finishCB=function(tree)
local march=xianjieModel:getMoJunBoxMarch(guid)
march:clearBehavior(tree)

notifySystem:postNotify(notifyConfig.onXianJieWaiPaiChange,CHANGE_TYPE.eChanged,march:getTeamHandle())
end
self.behaviorID=xjBehaviorManager:createTree(typo,self.behaviorData,finishCB,isStart)
return true
else
xianjieController:doMoJunBoxMarchDelete(self.guid)
end
end


function xjEntityData_MoJunBoxTeam:initTeamHandle()
if self.teamHandleID==nil then
self.teamHandleID=xianjieController:addXJTeamHandle(xjTeamHandleType.eMoJunBoxTeam,{guid=self.guid})
end
end


function xjEntityData_MoJunBoxTeam:onDelete()

end

return xjEntityData_MoJunBoxTeam