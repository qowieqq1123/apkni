





local optionEventNpcData
local _optionEventNpcGuidDict
local _optionEventNpcEntityDict
local _optionEventNpcHudDict
local _posIndex
local _optionEventNPCBTDict
local _speakIntervalTimer
local _freePosIndexList
local _speakingEventGuidStr
local _hasNpcList_lookup
local _needMovePosList
local _lastLeaveTimeList_lookup
local _optionEventEndShow
local _optionEventWaitEndShowList
local _optionEventCanClickList_lookup


function shanmenModel.initOptionEventNpc()
shanmenModel:removeAllOptionEventNpcData()
shanmenModel:clearOptionEventNPCSpeakIntervalTimer()
optionEventNpcData={}
_optionEventNpcGuidDict={}
_optionEventNpcEntityDict={}
_optionEventNpcHudDict={}
_posIndex={}
_optionEventNPCBTDict={}
_freePosIndexList={}
_speakingEventGuidStr=nil
_hasNpcList_lookup={}
_needMovePosList={}
_lastLeaveTimeList_lookup={}
_optionEventEndShow=nil
_optionEventWaitEndShowList={}
_optionEventCanClickList_lookup={}
end


function shanmenModel:clearOptionEventNpc()

shanmenModel:removeAllOptionEventNpcData()
shanmenModel:clearOptionEventNPCSpeakIntervalTimer()
optionEventNpcData=nil
_optionEventNpcGuidDict=nil
_optionEventNpcEntityDict=nil
_optionEventNpcHudDict=nil
_posIndex=nil
_optionEventNPCBTDict=nil
_freePosIndexList=nil
_speakingEventGuidStr=nil
_hasNpcList_lookup=nil
_needMovePosList=nil
_lastLeaveTimeList_lookup=nil
_optionEventEndShow=nil
_optionEventWaitEndShowList={}
_optionEventCanClickList_lookup={}
end


function shanmenModel.getShanmenOptionConfigField(str)
return cfgHelper.get2(cfg_shanmenoptionconfig_get,1,str)
end


function shanmenModel:addOptionEventNpcData(npcData)

local eventId=npcData.eventId
local eventGuid=int64.new(npcData.eventGuidStr)
local isCanFly=eventOptionControl.checkOptionNpcIsCanFly(npcData)
local localNpcData=eventLocalOptionModel.getOptionEventNpcData(npcData.eventGuidStr)
local posIndex=localNpcData and localNpcData.posIndex or nil
local needWait
if posIndex then
needWait=false
_freePosIndexList[posIndex]=nil
else
posIndex,needWait=shanmenModel:getOptionEventNpcFreePosIndex(isCanFly)
if posIndex then
eventLocalOptionModel.setOptionEventNpcPosIndex(posIndex,npcData.eventGuidStr)
end
end

if not posIndex then
return
end

_posIndex[posIndex]=eventGuid
if not needWait and _lastLeaveTimeList_lookup[posIndex]then
local nowTime=timeHelper.getServerShortTime()
local lastLeaveTime=_lastLeaveTimeList_lookup[posIndex]
local waitLeaveTime=2
if nowTime-lastLeaveTime<waitLeaveTime then

needWait=true
end
end

self:createOptionEventNpcModel(npcData,posIndex,eventGuid,needWait)
table.insert(optionEventNpcData,{data=npcData,posIdx=posIndex,eventId=eventId,eventGuid=eventGuid,})
if not _hasNpcList_lookup then
_hasNpcList_lookup={}
end
local npcType=npcData.type
local npcDataId=npcData.id
if not _hasNpcList_lookup[npcType]then
_hasNpcList_lookup[npcType]={}
end
_hasNpcList_lookup[npcType][npcDataId]=true



shanmenModel:setOptionEventNPCSpeakIntervalTimer()
end

function shanmenModel:hideOptionEventNPCClick(eventguid)
local eventGuidStr=tostring(eventguid)
local bt=_optionEventNPCBTDict[eventGuidStr]
if bt then
local hudId=_optionEventNpcHudDict[eventGuidStr]
if hudId then



_optionEventCanClickList_lookup[eventGuidStr]=true
end
end
end

function shanmenModel:optionEventNPCLeave(eventguid,optionid)
local eventGuidStr=tostring(eventguid)
local bt=_optionEventNPCBTDict[eventGuidStr]
if bt then
local stateId=bt:getSharedVar("stateId")
if stateId==-2 or stateId==-1 or stateId==1 then

bt:setSharedVar("needChangeStateId",2)
local hudId=_optionEventNpcHudDict[eventGuidStr]
if hudId then




_optionEventCanClickList_lookup[eventGuidStr]=true
end
else

bt:setSharedVar("stateId",2)
end
bt:setSharedVar("selectIndex",optionid)
end

local data=self:getOptionEventNpcDataByEventGuidStr(eventGuidStr)
local eventId=data and data.eventId or nil

eventOptionControl:setRefreshNewOptionEventCd(eventId)
local posIndex=data and data.posIdx or nil
if not posIndex then
return
end
local leaveTime=timeHelper.getServerShortTime()
_lastLeaveTimeList_lookup[posIndex]=leaveTime

shanmenModel:removeOptionEventNpcPosDataByPosIndex(posIndex)
end

function shanmenModel:getOptionEventNpcData()
return optionEventNpcData
end

function shanmenModel:getOptionEventNpcDataByEventGuidStr(eventGuidStr)
local datas=self:getOptionEventNpcData()
for i,v in ipairs(datas)do
local eventGuid=v.eventGuid
local str=tostring(eventGuid)
if str==eventGuidStr then
return v,i
end
end
end

function shanmenModel:setLastOptionEventNpcTime(lastTime)
self.data.lastOETime=lastTime
end

function shanmenModel:getLastOptionEventNpcTime()
return self.data.lastOETime
end


function shanmenModel:initFreePosIndexList()
_freePosIndexList={}
local optionNPCPosList=shanmenModel.getShanmenOptionConfigField('optionEventPos')
if not optionNPCPosList then
logErr("找不到决策事件NPC的山门位置 请检查配置是否正确")
end
for i,v in ipairs(optionNPCPosList)do
if not _posIndex[i]then
_freePosIndexList[i]=true
end
end

_freePosIndexList.init=true
end

function shanmenModel:getOptionEventNpcFreePosIndex(isCanFly,isInit,isOnlyCheck)
if not _freePosIndexList.init then
shanmenModel:initFreePosIndexList()
end

local freePosIndex_notFly={}
local freePosIndex_Fly={}
local hasNPCPosIndex_notFly={}
local optionNPCPosList=shanmenModel.getShanmenOptionConfigField('optionEventPos')
if not optionNPCPosList then
logErr("找不到决策事件NPC的山门位置 请检查配置是否正确")
end
for i,v in ipairs(optionNPCPosList)do
local isFlyPos=v[5]==1
if _freePosIndexList[i]then
if isFlyPos then
table.insert(freePosIndex_Fly,i)
else
table.insert(freePosIndex_notFly,i)
end
else
if not isFlyPos then
table.insert(hasNPCPosIndex_notFly,i)
end
end
end

if next(freePosIndex_notFly)then

local selectPosIdx=freePosIndex_notFly[1]
if not isOnlyCheck then
_freePosIndexList[selectPosIdx]=nil
end
return selectPosIdx
else

if next(freePosIndex_Fly)then

if isCanFly then

local selectPosIdx=freePosIndex_Fly[1]
if not isOnlyCheck then
_freePosIndexList[selectPosIdx]=nil
end
return selectPosIdx
else

for _,v in ipairs(hasNPCPosIndex_notFly)do
local posIdx=v
local posEventGuid=_posIndex[posIdx]
local posEventGuidStr=tostring(posEventGuid)
local posEventData=shanmenModel:getOptionEventNpcDataByEventGuidStr(posEventGuidStr)
local posNPCCanFly=eventOptionControl.checkOptionNpcIsCanFly(posEventData.data)
if posNPCCanFly then

local targetPosIdx=freePosIndex_Fly[1]
if isInit then
if not isOnlyCheck then

_freePosIndexList[targetPosIdx]=nil
_posIndex[targetPosIdx]=posEventGuid
_posIndex[posIdx]=nil
end
return posIdx
else
if not isOnlyCheck then
local res=shanmenModel:changeOptionEventNPCPos(posIdx,targetPosIdx)
if not res then

_freePosIndexList[targetPosIdx]=nil
end
end
return posIdx,true
end
end
end
end
end
end


return nil
end


function shanmenModel:checkOptionEventNpcHasFreePos(isCanFly)
if not _freePosIndexList.init then
shanmenModel:initFreePosIndexList()
end

if shanmenModel:getOptionEventNpcFreePosIndex(isCanFly,nil,true)then
return true
end

return false
end


function shanmenModel:getOptionEventNpcHasFreePosCount()
if not _freePosIndexList.init then
shanmenModel:initFreePosIndexList()
end

local count=0
for i,v in pairs(_freePosIndexList)do
if i~='init'then
count=count+1
end
end

return count
end


function shanmenModel:checkOptionEventNpcHasSame(npcType,npcDataId)
if not _hasNpcList_lookup then
return false
end
if _hasNpcList_lookup[npcType]and _hasNpcList_lookup[npcType][npcDataId]then
return true
end

return false
end

function shanmenModel:createAllOptionEventNpcModel()
if not optionEventNpcData then
return
end


for i,v in ipairs(optionEventNpcData)do

self:createOptionEventNpcModel(v.data,v.posIdx,v.eventGuid)
end


shanmenModel:setOptionEventNPCSpeakIntervalTimer()
end


function shanmenModel:createOptionEventNpcModel(npcData,index,eventGuid,needWait)
local eventGuidStr=tostring(eventGuid)
if mainControl:isSceneLoaded(eSceneType.eZongmen)and not _optionEventNpcEntityDict[eventGuidStr]then
local optionNPCPosList=shanmenModel.getShanmenOptionConfigField('optionEventPos')
if not optionNPCPosList then
logErr("找不到决策事件NPC的山门位置 请检查配置是否正确")
end
local idxPos=optionNPCPosList[index]
if idxPos then
local pos=_MapManager.ToVector3Int(idxPos[1],idxPos[2],0)

local modelParams=eventOptionControl.getOptionNpcModel(npcData,eventGuid)
local scale=isometricMapSystem:getModelScale(modelParams.body)
local offset=Vector3(idxPos[3]or 0,idxPos[4]or 0,0)

local pos_V3=_MapManager.GetCellCenterWorld(mapIdType.zhufeng,pos,mapLayer.Data)

local hideColor=Color.New(1,1,1,0)
local guid=isometricMapSystem:createRoleEntity(objectType.eRole,mapIdType.zhufeng,0,modelParams.body,modelParams.componets,SortingLayers.ITBuilding,scale,pos,Vector3.zero)
local npcEntity=_EntityManager:GetEntity(guid)
npcEntity:SetPosition(pos_V3+offset)

if idxPos[5]and idxPos[5]==1 then

_MapManager.ShowShadow(guid,false)

local post=98
local npcType=npcData.type
if npcType==EVENT_OPTION_NPC_TYPE.eWorldNPC then

post=npcData.mountId or 98
elseif npcType==EVENT_OPTION_NPC_TYPE.eMortalNPC then
post=-1
end

if post~=-1 then
shanmenModel:setOptionEventNPCUpMount(npcEntity,post,nil)
end
else

_MapManager.ShowShadow(guid,true)
end
_MapManager.SetFadeToColor(guid,hideColor,0,nil)
local defaultStateId=needWait and-2 or-1
local timeParam=shanmenModel.getShanmenOptionConfigField('optionEventQiPaoParam')
local showSpeakTime=timeParam.showTime or 5
local btData={
guid=guid,
stateId=defaultStateId,
eventGuidStr=eventGuidStr,
speakStateId=0,
showSpeakTime=showSpeakTime,
}

local bt=behaviorManager:addBehaviorTree('ai_option_event_npc',{stId=guid},true,btData)
_optionEventNPCBTDict[eventGuidStr]=bt
if _needMovePosList[eventGuidStr]then
local oldPosIndex=_needMovePosList[eventGuidStr][1]
local newPosIndex=_needMovePosList[eventGuidStr][2]
_needMovePosList[eventGuidStr]=nil
shanmenModel:changeOptionEventNPCPos(oldPosIndex,newPosIndex,eventGuid)
end
local eventId=npcData.eventId
local eventType2=eventConfig.getEventConfig(eventId).type2
local iconCfg=shanmenModel.getShanmenOptionConfigField('optionEventHUDIcon')

hudControl:addHUD(INSTANCE_TYPE.eOptionEventNPCHUD,guid,Vector3.zero,true,true,function(hudId)
local widget=hudControl:getHUDWidget(hudId)
widget:SetChildButtonClick(2,function(...)

shanmenController:showOpenEventWinByEventGuid(eventGuid)

end)
widget:SetChildRotation(1,0,0,0)
local iconParam=iconCfg[eventType2]
if iconParam then
local iconAbName=iconParam[1]
local iconName=iconParam[2]
widget:SetChildCSImageSprite(1,iconAbName,iconName)
else
logErr(FMT.fmt("找不到决策事件副类型为{0} 对应的HUD图标配置 请检查山门配置表是否正确",eventType2))
end
local tweener=widget:SetChildDOPunchRotation(1,Vector3(0,0,15),2,6,1)
tweener:SetEase(_Ease.Linear)
tweener:SetLoops(-1,_LoopType.Restart)

local bt=_optionEventNPCBTDict[eventGuidStr]
local isShowIcon=true
if bt then
local stateId=bt:getSharedVar("stateId")
if stateId==-2 then

isShowIcon=false
end
end
widget:SetChildActive(1,isShowIcon)
widget:SetChildActive(2,isShowIcon)

_optionEventNpcHudDict[eventGuidStr]=hudId
end)
_optionEventNpcGuidDict[guid]=eventGuid
_optionEventNpcEntityDict[eventGuidStr]=guid
end
end
end


function shanmenModel:changeOptionEventNpcModel(npcData,eventGuid)
local eventGuidStr=tostring(eventGuid)
if mainControl:isSceneLoaded(eSceneType.eZongmen)and _optionEventNpcEntityDict[eventGuidStr]then
local guid=_optionEventNpcEntityDict[eventGuidStr]

local modelParams=eventOptionControl.getOptionNpcModel(npcData,eventGuid)
local scale=isometricMapSystem:getModelScale(modelParams.body)
_MapManager.ChangeBody(guid,modelParams.body,modelParams.componets,scale)
end
end


function shanmenModel:checkZMZhangMenTypeOptionEventNpcModel()
if _optionEventNpcEntityDict and next(_optionEventNpcEntityDict)~=nil then
for eventGuidStr,guid in pairs(_optionEventNpcEntityDict)do
local data,index=shanmenModel:getOptionEventNpcDataByEventGuidStr(eventGuidStr)
if data then
local npcData=data.data
local npcType=npcData.type
if npcType==EVENT_OPTION_NPC_TYPE.eZMZhangMen then
local eventGuid=_optionEventNpcGuidDict[guid]
shanmenModel:changeOptionEventNpcModel(npcData,eventGuid)
end
end
end
end
end


function shanmenModel:checkOptionEventNpcChangeFinishStartModelByEventGuid(eventGuid)
local eventGuidStr=tostring(eventGuid)
local data,index=shanmenModel:getOptionEventNpcDataByEventGuidStr(eventGuidStr)
if data then
local npcData=data.data
local npcType=npcData.type
local eventId=data.eventId
local eventCfg=eventConfig.getEventConfig(eventId)
local changeNpcId=eventCfg.changeNpcId
if changeNpcId then
shanmenModel:changeOptionEventNpcModel(npcData,eventGuid)
end
end
end


function shanmenModel:changeOptionEventNpcShow(isShow)
if mainControl:isSceneLoaded(eSceneType.eZongmen)then
for eventGuidStr,guid in pairs(_optionEventNpcEntityDict)do
local npcEntity=_EntityManager:GetEntity(guid)


npcEntity:SetVisible(isShow)

local hudId=_optionEventNpcHudDict[eventGuidStr]
if hudId then
local hudWidget=hudControl:getHUDWidget(hudId)
hudWidget:SetChildActive(0,isShow)
end
end
end
end


function shanmenModel:optionEventNpcFinishInitFunc(eventGuidStr)
local bt=_optionEventNPCBTDict[eventGuidStr]
if bt then




local hudId=_optionEventNpcHudDict[eventGuidStr]
if hudId then
local hudWidget=hudControl:getHUDWidget(hudId)

hudWidget:SetChildActive(1,true)

hudWidget:SetChildActive(2,true)
_optionEventCanClickList_lookup[eventGuidStr]=nil
end

local needChangeStateId=bt:getSharedVar("needChangeStateId")
if needChangeStateId then

bt:setSharedVar("needChangeStateId",nil)
bt:setSharedVar("stateId",needChangeStateId)
end
end
end

function shanmenModel:optionEventNpcPosChangeFunc(eventGuidStr,inPos)
local bt=_optionEventNPCBTDict[eventGuidStr]
if bt then
local speedCfg=shanmenModel.getShanmenOptionConfigField('optionEventSpeed')
local speed=speedCfg and speedCfg[2]or 0.5
local guid=_optionEventNpcEntityDict[eventGuidStr]
local targetPos=inPos
local ent=_EntityManager:GetEntity(guid)
if targetPos then
local moveType=eAIMoveType.eFly
local post=98

local finishFlyCallBack=function(isFlipOnFly)

if isFlipOnFly then
ent:SetFlipX(false)
end

bt:setSharedVar("stateId",0)
end

local mountCallBack=function()

local pos=_MapManager.GetCellCenterWorld(mapIdType.zhufeng,targetPos,mapLayer.Data)
local offset=bt:getSharedVar("targetPosOffset")
local finalPos=pos+offset


local nowPos=ent:GetPosition()
local deltaPos=finalPos-nowPos
local distance=math.sqrt(math.pow(deltaPos.x,2)+math.pow(deltaPos.y,2)+math.pow(deltaPos.z,2))

local duration=distance/speed
local isFlip=deltaPos.x>0
ent:SetFlipX(isFlip)
local tweener=Lua.DOTweenProxyExtensions.DOMove(ent.transform,finalPos,duration,false)
tweener:OnComplete(function()
return finishFlyCallBack(isFlip)
end)
tweener:SetEase(_Ease.InOutQuart)
end

local jumpCallBack=function()

return shanmenModel:setOptionEventNPCUpMount(ent,post,mountCallBack)
end


local jumpCfg=cfgHelper.get1(cfg_discipleflyconfig_get,1)
local jumpUpParam=jumpCfg.ju_args or{0,0,0,0}
local nowPos=ent:GetPosition()
local jumpPos=Vector3.New(nowPos.x,nowPos.y,nowPos.z+jumpUpParam[2])
_MapManager.RunAnimator(guid,jumpUpParam[1])
_MapManager.ShowShadow(guid,false)
local tweener=Lua.DOTweenProxyExtensions.DOJump(ent.transform,jumpPos,jumpUpParam[3],1,jumpUpParam[4])
tweener:OnComplete(jumpCallBack)
end
end
end

function shanmenModel:optionEventNpcFinishPosChangeFunc(eventGuidStr)
local bt=_optionEventNPCBTDict[eventGuidStr]
if bt then
local stateId=bt:getSharedVar("stateId")

end
end

function shanmenModel:optionEventNpcNormalFunc(eventGuidStr)
local bt=_optionEventNPCBTDict[eventGuidStr]
if bt then
local stateId=bt:getSharedVar("stateId")

end
end

function shanmenModel:optionEventNpcFinishSpeakFunc(eventGuidStr)
shanmenModel:finishOptionEventNPCSpeak(eventGuidStr)
end

function shanmenModel:optionEventNpcLeaveFunc(eventGuidStr)

local leavePosNum=shanmenModel:getOptionEventNpcLeavePos(eventGuidStr)
if not leavePosNum then
logErr("找不到决策事件NPC退场位置 请检查配置是否正确")
return
end
local bt=_optionEventNPCBTDict[eventGuidStr]
if bt then
local guid=_optionEventNpcEntityDict[eventGuidStr]
local targetPos=_MapManager.ToVector3Int(leavePosNum[1],leavePosNum[2],0)
local data=shanmenModel:getOptionEventNpcDataByEventGuidStr(eventGuidStr)


local hudId=_optionEventNpcHudDict[eventGuidStr]
if hudId then
local hudWidget=hudControl:getHUDWidget(hudId)

hudWidget:SetChildActive(1,false)


_optionEventCanClickList_lookup[eventGuidStr]=true
end

local res,selectCfg=shanmenModel:setOptionEventNPCSpeak(eventGuidStr)
if res then

local expressId=selectCfg.expressid
if expressId then
bt:setSharedVar("expressId",expressId)
bt:setSharedVar("hasExpressId",true)
else
bt:setSharedVar("hasExpressId",false)
end
end


local finishFadeOutCallback=function()

return shanmenModel:removeOptionEventNpcModel(eventGuidStr)
end


local finishMoveToLeaveCallback=function()
_MapManager.RunAnimator(guid,eAnimationID.stand)

local target=Color.New(1,1,1,0)
local duration=1
return _MapManager.SetFadeToColor(guid,target,duration,finishFadeOutCallback)
end


local posIdx=data.posIdx
local speedCfg=shanmenModel.getShanmenOptionConfigField('optionEventSpeed')
local optionNPCPosList=shanmenModel.getShanmenOptionConfigField('optionEventPos')
if not optionNPCPosList then
logErr("找不到决策事件NPC的山门位置 请检查配置是否正确")
end
local isFlyPos=optionNPCPosList[posIdx][5]==1
if isFlyPos then

local flySpeed=speedCfg and speedCfg[2]or 0.5
local pos=_MapManager.GetCellCenterWorld(mapIdType.zhufeng,targetPos,mapLayer.Data)
local ent=_EntityManager:GetEntity(guid)

local nowPos=ent:GetPosition()
local deltaPos=pos-nowPos
local distance=math.sqrt(math.pow(deltaPos.x,2)+math.pow(deltaPos.y,2)+math.pow(deltaPos.z,2))

local duration=distance/flySpeed
local isFlip=deltaPos.x>0
ent:SetFlipX(isFlip)
local tweener=Lua.DOTweenProxyExtensions.DOMove(ent.transform,pos,duration,false)
tweener:OnComplete(finishMoveToLeaveCallback)

tweener:SetEase(_Ease.InOutQuart)
else

local runSpeed=speedCfg and speedCfg[1]or 1
_MapManager.RunAnimator(guid,eAnimationID.run)
_MapManager.MoveToPosition(guid,targetPos,finishMoveToLeaveCallback,nil,runSpeed,-1)
end


shanmenModel:removeOptionEventNpcModelData(eventGuidStr)
end
end

function shanmenModel:changeOptionEventNPCPos(oldPosIndex,newPosIndex,eventGuid)
if not eventGuid then
eventGuid=_posIndex[oldPosIndex]
if not eventGuid then
return false
end
end

local eventGuidStr=tostring(eventGuid)

local bt=_optionEventNPCBTDict[eventGuidStr]
if not bt then

_needMovePosList[eventGuidStr]={oldPosIndex,newPosIndex}
return false
end


local optionNPCPosList=shanmenModel.getShanmenOptionConfigField('optionEventPos')
if not optionNPCPosList then
logErr("找不到决策事件NPC的山门位置 请检查配置是否正确")
end
local idxPos=optionNPCPosList[newPosIndex]
local data=shanmenModel:getOptionEventNpcDataByEventGuidStr(eventGuidStr)
if data then
data.posIdx=newPosIndex
end
_posIndex[oldPosIndex]=_posIndex[newPosIndex]
_posIndex[newPosIndex]=eventGuid
_freePosIndexList[oldPosIndex]=_freePosIndexList[newPosIndex]
_freePosIndexList[newPosIndex]=nil
eventLocalOptionModel.setOptionEventNpcPosIndex(newPosIndex,eventGuidStr)
if idxPos then
local pos=_MapManager.ToVector3Int(idxPos[1],idxPos[2],0)
bt:setSharedVar("targetPos",pos)
local offset=Vector3(idxPos[3]or 0,idxPos[4]or 0,0)
bt:setSharedVar("targetPosOffset",offset)


local stateId=bt:getSharedVar("stateId")
if stateId==-1 then
local needChangeStateId=bt:getSharedVar("needChangeStateId")
if not needChangeStateId or needChangeStateId~=2 then

bt:setSharedVar("needChangeStateId",1)
end
else

bt:setSharedVar("stateId",1)
end
end

return true
end


function shanmenModel:setOptionEventNPCUpMount(npcEntity,post,callBack)
local postCfg=cfgHelper.get1(cfg_disciplepostflyconfig_get,post)
if postCfg then
local slots=postCfg.mount_slots or nil
local hp=postCfg.mount_hp or""
local offset
if postCfg.offset then
offset=Vector3.New(postCfg.offset[1],postCfg.offset[2],postCfg.offset[3])
else
offset=Vector3.zero
end
local scale=postCfg.scale or 1
return npcEntity:Mount(postCfg.mount_body,slots,hp,scale,offset,callBack);
end
end


function shanmenModel:setOptionEventNPCSpeak(eventGuidStr)

local hudId=_optionEventNpcHudDict[eventGuidStr]
if not hudId then
return
end
local hudWidget=hudControl:getHUDWidget(hudId)


local bt=_optionEventNPCBTDict[eventGuidStr]
if bt then
local stateId=bt:getSharedVar("stateId")
local isLeave=stateId==2
local data=self:getOptionEventNpcDataByEventGuidStr(eventGuidStr)
local eventId=data.eventId

local qiPaoCfg
local selectCfg
local speakContent
if isLeave then
local qiPaoAllCfg=eventConfig.getEventConfig(eventId).optionEndSpeak
local selectIndex=bt:getSharedVar("selectIndex")
qiPaoCfg=qiPaoAllCfg and qiPaoAllCfg[selectIndex]or nil
else
qiPaoCfg=eventConfig.getEventConfig(eventId).optionSpeak
end


if qiPaoCfg and#qiPaoCfg>0 then
local count=#qiPaoCfg
local randomIndex
if count>1 then
randomIndex=math.random(1,count)
else
randomIndex=1
end
selectCfg=qiPaoCfg[randomIndex]
if isLeave then
speakContent=selectCfg.content
else
speakContent=selectCfg
end
else

return false
end

bt:setSharedVar("speakContent",speakContent)
bt:setSharedVar("speakStateId",1)

hudWidget:SetChildActive(1,false)

if not isLeave then
_speakingEventGuidStr=eventGuidStr
end

return true,selectCfg
end
end


function shanmenModel:finishOptionEventNPCSpeak(eventGuidStr)
if _speakingEventGuidStr and eventGuidStr==_speakingEventGuidStr then
_speakingEventGuidStr=nil
end


local hudId=_optionEventNpcHudDict[eventGuidStr]
if not hudId then
return
end

local bt=_optionEventNPCBTDict[eventGuidStr]
if bt then
local stateId=bt:getSharedVar("stateId")
if stateId~=2 then
local hudWidget=hudControl:getHUDWidget(hudId)

hudWidget:SetChildActive(1,true)
end
end


shanmenModel:setOptionEventNPCSpeakIntervalTimer()
end


function shanmenModel:setOptionEventNPCSpeakIntervalTimer()
if _speakIntervalTimer or _speakingEventGuidStr then

return
end

if not optionEventNpcData or not next(optionEventNpcData)then
return shanmenModel:clearOptionEventNPCSpeakIntervalTimer()
end


local timeParam=shanmenModel.getShanmenOptionConfigField('optionEventQiPaoParam')
local minTime=timeParam.minTime or 15
local maxTime=timeParam.maxTime or 30
local intervalTime=math.random(minTime,maxTime)

local func=function()
if not optionEventNpcData or not next(optionEventNpcData)then
return shanmenModel:clearOptionEventNPCSpeakIntervalTimer()
end

local canSpeakNpcList={}
for i,v in ipairs(optionEventNpcData)do
local eventGuid=v.eventGuid
local eventGuidStr=tostring(eventGuid)
local bt=_optionEventNPCBTDict[eventGuidStr]
if bt then
local stateId=bt:getSharedVar("stateId")
local speakStateId=bt:getSharedVar("speakStateId")
if stateId==0 and speakStateId==0 then

table.insert(canSpeakNpcList,eventGuidStr)
end
end
end

local showEventCount=#canSpeakNpcList
if showEventCount>0 then
local randomIndex
if showEventCount>1 then
randomIndex=math.random(1,showEventCount)
else
randomIndex=1
end
local targetEventGuidStr=canSpeakNpcList[randomIndex]


local res=shanmenModel:setOptionEventNPCSpeak(targetEventGuidStr)
shanmenModel:clearOptionEventNPCSpeakIntervalTimer()
if not res then
return shanmenModel:setOptionEventNPCSpeakIntervalTimer()
end
else

shanmenModel:clearOptionEventNPCSpeakIntervalTimer()
return shanmenModel:setOptionEventNPCSpeakIntervalTimer()
end
end

_speakIntervalTimer=timer.new()
_speakIntervalTimer:start(intervalTime,func,1)
end


function shanmenModel:clearOptionEventNPCSpeakIntervalTimer()
if _speakIntervalTimer then
_speakIntervalTimer:cancel()
_speakIntervalTimer=nil
end
end

function shanmenModel:removeAllOptionEventNpcData()
local removeList=table.weakCopy(optionEventNpcData)
for _,v in ipairs(removeList or{})do
local eventGuidStr=tostring(v.eventGuid)
shanmenModel:removeOptionEventNpcModel(eventGuidStr)
shanmenModel:removeOptionEventNpcPosDataByPosIndex(v.posIdx)
shanmenModel:removeOptionEventNpcModelData(eventGuidStr)
end
end

function shanmenModel:removeAllOptionEventNpcModel()
local removeList=table.weakCopy(optionEventNpcData)
for _,v in ipairs(removeList or{})do
local eventGuidStr=tostring(v.eventGuid)
shanmenModel:removeOptionEventNpcModel(eventGuidStr)
end
end


function shanmenModel:removeOptionEventNpcModel(eventGuid)
if eventGuid==nil then return end
local eventGuidStr=tostring(eventGuid)
local guid=_optionEventNpcEntityDict[eventGuidStr]
if guid then
_MapManager.RemoveTilemapObject(guid)
end

_optionEventNpcEntityDict[eventGuidStr]=nil
self:removeOptionEventNpcHUD(eventGuidStr)
self:removeOptionEventNpcBT(eventGuidStr)
if _speakingEventGuidStr and eventGuidStr==_speakingEventGuidStr then
_speakingEventGuidStr=nil
end
end


function shanmenModel:removeOptionEventNpcModelData(eventGuidStr)
if eventGuidStr==nil then return end
self:removeOptionEventNpcData(eventGuidStr)
end


function shanmenModel:removeOptionEventNpcPosData(eventGuidStr)
if eventGuidStr==nil then return end
local data=self:getOptionEventNpcDataByEventGuidStr(eventGuidStr)
local index=data and data.posIdx or nil
if index then
_posIndex[index]=nil
_freePosIndexList[index]=true
end
end


function shanmenModel:removeOptionEventNpcPosDataByPosIndex(posIndex)
if posIndex then
_posIndex[posIndex]=nil
_freePosIndexList[posIndex]=true
end
end

function shanmenModel:removeOptionEventNpcHUD(eventGuidStr)
local hudId=_optionEventNpcHudDict[eventGuidStr]
if hudId then
hudControl:removeHUD(hudId)
_optionEventNpcHudDict[eventGuidStr]=nil
end
end

function shanmenModel:removeOptionEventNpcBT(eventGuidStr)
local bt=_optionEventNPCBTDict[eventGuidStr]
if bt then
behaviorManager:removeBehaviorTree(bt)
_optionEventNPCBTDict[eventGuidStr]=nil
end
end

function shanmenModel:removeAllOptionEventNpcBT()
for k,v in pairs(_optionEventNPCBTDict)do
behaviorManager:removeBehaviorTree(v)
end
end

function shanmenModel:removeOptionEventNpcData(eventGuidStr)
local data,index=shanmenModel:getOptionEventNpcDataByEventGuidStr(eventGuidStr)
if data then
local npcData=data.data
local npcType=npcData.type
local npcDataId=npcData.id
if _hasNpcList_lookup and _hasNpcList_lookup[npcType]and _hasNpcList_lookup[npcType][npcDataId]then
_hasNpcList_lookup[npcType][npcDataId]=nil
end
table.remove(optionEventNpcData,index)
end
end


function shanmenModel:getOptionEventGuidByEntityGuid(guid)
if guid and _optionEventNpcGuidDict[guid]then
return _optionEventNpcGuidDict[guid]
end

return nil
end

function shanmenModel:getOptionEventNpcLeavePos(eventGuidStr)
local defaultLeavePos=shanmenModel.getShanmenOptionConfigField('optionEventLeavePos')
local bt=_optionEventNPCBTDict[eventGuidStr]
if bt then
local selectIndex=bt:getSharedVar("selectIndex")

local data=self:getOptionEventNpcDataByEventGuidStr(eventGuidStr)
local eventId=data.eventId
local optionLeavePos=eventConfig.getEventConfig(eventId).optionLeavePos
if optionLeavePos and optionLeavePos[selectIndex]then
return optionLeavePos[selectIndex]
end
end
return defaultLeavePos
end


function shanmenModel:getFirstOptionEventNPCPos()
local optionNPCPosList=shanmenModel.getShanmenOptionConfigField('optionEventPos')
if not optionNPCPosList then
logErr("找不到决策事件NPC的山门位置 请检查配置是否正确")
return
end

local eventGuid
local posCount=#optionNPCPosList
if _posIndex and next(_posIndex)then
for i=1,posCount do
if _posIndex[i]then
eventGuid=_posIndex[i]
break
end
end
end

if eventGuid then
local eventGuidStr=tostring(eventGuid)

local guid=_optionEventNpcEntityDict[eventGuidStr]
local npcEntity=_EntityManager:GetEntity(guid)
local pos=npcEntity:GetPosition()
return pos
else
return nil
end
end

function shanmenModel:hasOptionEventNPCData()
return#optionEventNpcData>0
end


function shanmenModel:checkOptionEventNPCCanClick(eventGuid)
local eventGuidStr=tostring(eventGuid)
if _optionEventCanClickList_lookup and _optionEventCanClickList_lookup[eventGuidStr]then

local eventInfo=eventLocalOptionModel.getEventData(eventGuid)
local errStr
if eventInfo then

local eventInfoStr=eventInfo and serializeHelper.serialize(eventInfo)or""
errStr=FMT.fmt("事件NPC点击已禁用 事件guid:{0}, 事件数据:{1}",eventGuidStr,eventInfoStr)
else
errStr=FMT.fmt("事件NPC点击已禁用 事件guid:{0}, 找不到本地事件数据",eventGuidStr)
end

logErr(errStr)
return false
end

return true
end


function shanmenModel:test_NPCChangePos(oldPosIndex,newPosIndex)
shanmenModel:changeOptionEventNPCPos(oldPosIndex,newPosIndex)
end

function shanmenModel:test_deleteNPCByPosIdx(posIdx)
local eventId=_posIndex[posIdx]
if not eventId then
return
end

local bt=_optionEventNPCBTDict[eventId]
if bt then
bt:setSharedVar("stateId",2)
end
end


