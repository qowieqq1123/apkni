










shanmenModel={}
shanmenModel.data={}

SHANMEN_TYPE=
{
eBaiShan=1,
eOptionEvent=2,
}

shanmenTreeType=
{
eBaiShanFail=1,

}

local shanmenBTName=
{
[shanmenTreeType.eBaiShanFail]='ai_dz_baishan_fail',
}

local _shanmenEntityDict
local _shanmenBTList


function shanmenModel:onAppStart()

end


function shanmenModel:onEnterState(isReconnect)
shanmenModel.initBaiShan()
shanmenModel.initOptionEventNpc()
_shanmenEntityDict={}
_shanmenBTList={}
if not isReconnect then
shanmenModel:loadFirstBaiShanState()
end
notifySystem:listenNotify(notifyConfig.home_event,self.on_home_event)
end


function shanmenModel:onLeaveState(isReconnect)

self.data={}
_shanmenEntityDict=nil
_shanmenBTList=nil
shanmenModel.clearBaiShan()
shanmenModel:clearOptionEventNpc()
notifySystem:removelistener(notifyConfig.home_event,self.on_home_event)
end


function shanmenModel:onServerDataInitFinish()

end

function shanmenModel.on_home_event(etype)
if etype==homeEvent.eEnterHome then
shanmenModel:onEnterHome()
elseif etype==homeEvent.eLeaveHome then
shanmenModel:onLeaveHome()
end
end

function shanmenModel:onEnterHome()

end

function shanmenModel:onLeaveHome()
self:removeAllShanMenBT()
self:removeAllBaiShanBT()
end


function shanmenModel:checkHaveShanmen()
local bdType=shanmenModel.getBaiShanConfigField('buildid')
local smData=zongmenModel:findBuildingDataByType(zongmenModel:getMountainId(),bdType)
if smData then
return true
end
return false
end

function shanmenModel:getShanMenDisciplePos(typo,dzId)
local pos
if typo==SHANMEN_TYPE.eBaiShan then
pos=shanmenModel:getBaiShanDisciplePos(dzId)
end
return pos
end

function shanmenModel:removeShanMenDisciple(typo,dzId)
if typo==SHANMEN_TYPE.eBaiShan then
shanmenModel:removeBaiShanModel(dzId,true)
end
end


function shanmenModel:changeModel(typo,dzId)
if mainControl:isSceneLoaded(eSceneType.eZongmen)then
local pos=shanmenModel:getShanMenDisciplePos(typo,dzId)
shanmenModel:removeShanMenDisciple(typo,dzId)
if not pos then

local posIndexList=shanmenModel:getBaiShanDisciplePosIndexList()
local posIndexStr=posIndexList and serializeHelper.serialize(posIndexList)or""
logErr(FMT.fmt("找不到拜山弟子位置 弟子id：{0}, 当前位置列表：{1}",tostring(dzId),posIndexStr))
return
end

local info=UIDiscipleModel:getDiscipleOutsideModelInfo(dzId)
local scale=isometricMapSystem:getModelScale(info.body)
local guid=isometricMapSystem:createRoleEntity(objectType.eRole,mapIdType.zhufeng,0,info.body,info.componets,SortingLayers.ITBuilding,scale,pos)
_MapManager.ShowShadow(guid,true)

_shanmenEntityDict[tostring(dzId)]=guid
end
end

function shanmenModel:removeModel(dzId)
local guid=_shanmenEntityDict[tostring(dzId)]
shanmenModel:removeBehaviourTree(dzId)
_MapManager.RemoveTilemapObject(guid)
_shanmenEntityDict[tostring(dzId)]=nil
end

function shanmenModel:playSMDzBehaviour(dzId,typo)
local stId=_shanmenEntityDict[tostring(dzId)]
local treeName=shanmenBTName[typo]
local initData=self:getInitDataByType(typo)
initData.dzId=dzId
local bt=behaviorManager:addBehaviorTree(treeName,{dzId=dzId,stId=stId},true,initData)
_shanmenBTList[tostring(dzId)]=bt
end

function shanmenModel:removeBehaviourTree(dzId)
local bt=_shanmenBTList[tostring(dzId)]
behaviorManager:removeBehaviorTree(bt)
_shanmenBTList[tostring(dzId)]=nil
end

function shanmenModel:removeAllShanMenBT()
for k,v in pairs(_shanmenBTList)do
behaviorManager:removeBehaviorTree(v)
end
end

function shanmenModel:getInitDataByType(typo)
local initData={}
if typo==shanmenTreeType.eBaiShanFail then
local speakstr=shanmenModel:getFailSpeakStr()
local leavePos=shanmenModel.getBaiShanConfigField('baishanLeavePos')
initData={
speakstr=speakstr,
leavePos=leavePos,
}
end
return initData
end

function shanmenModel:setIsShanMenModelHide(flag)
self.data.isShanMenModelHide=flag
end

function shanmenModel:getIsShanMenModelHide()
if not self.data or self.data.isShanMenModelHide==nil then
return false
end

return self.data.isShanMenModelHide
end


