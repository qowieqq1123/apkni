







local lookAtTime=0.3
local lookAtEase=DG.Tweening.Ease.InQuart
local leaveBackTime=0.3
local leaveBackEase=DG.Tweening.Ease.OutExpo
local cameraLookAtWin={
['UIXianJie_plotMonsterWin']=true,
['UIXianJie_emptyPosWin']=true,
['UIXianJie_monsterInfoWin']=true,
['UIXianJie_selfZmInfoWin']=true,
['UIXianJie_otherZmInfoWin']=true,
['UIXianJie_stationInfoWin']=true,
['UIXianJie_RPMonsterWin']=true,
['UIMysteryEnterWin']=true,
['UIXJFMChallengeWIn']=true,
['UIXianJie_RPCtCollectWin']=true,
['UIXianJie_RPXBCollectWin']=true,
['UIXianJie_XMInfoWin']=true,
['UIXianJie_MJBoxInfoWin']=true,
['UIXianJie_puTongZhenJiInfoWin']=true,
['UIXianJie_lingshouInfoWin']=true,
}
local rightWinLookup={
['UIXianJie_plotMonsterWin']=true,
['UIXianJie_emptyPosWin']=true,
['UIXianJie_monsterInfoWin']=true,
['UIXianJie_selfZmInfoWin']=true,
['UIXianJie_otherZmInfoWin']=true,
['UIXianJie_stationInfoWin']=true,
['UIXianJie_RPMonsterWin']=true,
['UIMysteryEnterWin']=true,
['UIXianJie_LeyLineInfoWin']=true,
['UIXJFMChallengeWIn']=true,
['UIXianJie_RPCtCollectWin']=true,
['UIXianJie_RPXBCollectWin']=true,
['UIXianJie_XMInfoWin']=true,
['UIMoJie_MoJunInfoWin']=true,
['UIXianJie_MJBoxInfoWin']=true,
['UIXianJie_puTongZhenJiInfoWin']=true,
['UIXianJie_lingshouInfoWin']=true,
}
local leftWinLookup={
['UIXianJieExplorationWin']=true,
["UIMoJieExplorationWin"]=true,
}
local middleWinLookup={
['UIXianJieArenaAct_infoWin']=true,
['UIXianJieArenaAct_buffWin']=true,
['UIXYInfoListWIn']=true,
['UIMoGongZhengDuoAct_infoWin']=true,
['UIMoGongZhengDuoAct_buffWin']=true,
['UIZhengTaoMoJiangMonsterInfoWin']=true,
['UIBenYuanZhenJiWin']=true,
['UIMoJieGate_attackWin']=true,
['UIMoJieGate_infoWin']=true,
['UIMoJieMoJunBoxInfoWin']=true,

['UIMoGongZhengDuoAct_buffInfoWin']=true,
['UIMoGongZhengDuoAct_SettlementWin']=true,
['UIMoGongZhengDuoAct_FightInfoWin']=true,
['UIMoJieZhenTaiWin']=true,
['UIMoGongZhengDuoAct_rankBgWin']=true,
}
local lookAtBefore_cameraY

function xianjieController.onShowUI(winName,afterLoading)
if afterLoading then
if rightWinLookup[winName]then
xianjieController.rightWin=winName
end
if leftWinLookup[winName]then
xianjieController.leftWin=winName
end
if middleWinLookup[winName]then
xianjieController.middleWin=winName
end
end
end

function xianjieController:clearData_openWin()
self.leftWin=nil
self.rightWin=nil
self.middleWin=nil
lookAtBefore_cameraY=nil
end

function xianjieController:isShowSideWin()
return self.leftWin~=nil or self.rightWin~=nil
end





function xianjieController:openWin(winName,winParams)
local key=nil
if rightWinLookup[winName]==true then
key='rightWin'
elseif leftWinLookup[winName]==true then
key='leftWin'
elseif middleWinLookup[winName]==true then
xianjieController:closeWin4()
if self.middleWin and self.middleWin~=winName then
UIManager:closeWindow(self.middleWin)
self.middleWin=nil
end
self.middleWin=winName
xianjieController:openWinEx(winName,winParams)
return
end
if key==nil then
return
end
local cameraY
local lookAtPos
if xianjieController:checkCameraLookatWin(winName)then
cameraY=winParams.cameraY




lookAtPos=winParams.lookAtPos
end

if self[key]~=nil and self[key]~=winName then
UIManager:closeWindow(self[key])
if lookAtPos==nil and lookAtBefore_cameraY~=nil then

local height=lookAtBefore_cameraY
lookAtBefore_cameraY=nil
local pos=xianjieController:getCameraLookAtPlanePos()
xianjieController:lookAtPosition(pos,height,leaveBackTime,nil,leaveBackEase)
end
end
self[key]=winName
if lookAtPos~=nil then
if lookAtBefore_cameraY==nil then

local pos=xianjieController:getCameraPosition()
lookAtBefore_cameraY=pos.y
end

xianjieController:lookAtPosition(lookAtPos,cameraY,lookAtTime,nil,lookAtEase)
xianjieController:openWinEx(winName,winParams)
else
xianjieController:openWinEx(winName,winParams)
end
end


function xianjieController:openWinEx(winName,winParams)
if UIManager:isActive(winName)then
local win=UIManager:findActiveWindow(winName)
if win and win.onShowArgRecv then
win:onShowArgRecv(winParams)
return
end
end
UIManager:showWindow(winName,winParams)
end

function xianjieController:closeWin(winName,atOnce)
if self.leftWin==winName then
self.leftWin=nil
elseif self.rightWin==winName then
self.rightWin=nil
elseif self.middleWin==winName then
self.middleWin=nil
else
return
end
xianjieController:resetCameraLookAt(atOnce)
UIManager:closeWindow(winName)
end

function xianjieController:closeWin2(winName)
if self.leftWin==winName then
self.leftWin=nil
elseif self.rightWin==winName then
self.rightWin=nil
else
return
end
end

function xianjieController:closeWin3()
if self.leftWin~=nil then
UIManager:closeWindow(self.leftWin)
self.leftWin=nil
end
if self.rightWin~=nil then
UIManager:closeWindow(self.rightWin)
self.rightWin=nil
end
if self.middleWin~=nil then
UIManager:closeWindow(self.middleWin)
self.middleWin=nil
end
lookAtBefore_cameraY=nil
end

function xianjieController:closeWin4()
if self.leftWin~=nil then
UIManager:closeWindow(self.leftWin)
self.leftWin=nil
end
if self.rightWin~=nil then
UIManager:closeWindow(self.rightWin)
self.rightWin=nil
end
lookAtBefore_cameraY=nil
end

function xianjieController:closeRightWin()
if self.rightWin~=nil then
UIManager:closeWindow(self.rightWin)
self.rightWin=nil
end
lookAtBefore_cameraY=nil
end

function xianjieController:resetCameraLookAt(atOnce)
if lookAtBefore_cameraY~=nil then
local check=true
if self.leftWin~=nil and xianjieController:checkCameraLookatWin(self.leftWin)then
check=false
elseif self.rightWin~=nil and xianjieController:checkCameraLookatWin(self.rightWin)then
check=false
end
if check then

local height=lookAtBefore_cameraY
lookAtBefore_cameraY=nil
local pos=xianjieController:getCameraLookAtPlanePos()
local time
if atOnce then
time=0
else
time=leaveBackTime
end
xianjieController:lookAtPosition(pos,height,time,nil,leaveBackEase)
end
end
end

function xianjieController:resetCameraLookAt2(height,time,ease)
local pos=xianjieController:getCameraLookAtPlanePos()
xianjieController:lookAtPosition(pos,height,time,nil,ease)
end

function xianjieController:checkCameraLookatWin(winName)
return cameraLookAtWin[winName]==true
end

function xianjieController:jumpGrid(sceneidx,gridX,gridZ,cb,iscameraLow,lookAtDuration,height)
if fightModel:haveBattleShow()then
UIManager.error("战斗中无法跳转")
return false
end

lookAtDuration=lookAtDuration or 0.2
local lookpos=xianjieController:worldGridPos2WorldPos4(gridX,gridZ,sceneidx)
if xianjieModel:checkSceneIndex(sceneidx)then
if iscameraLow then
xianjieController:lookAtPositionLow(lookpos,sceneidx,lookAtDuration,cb,DG.Tweening.Ease.Linear,height)
else
xianjieController:lookAtPosition(lookpos,nil,lookAtDuration,cb,DG.Tweening.Ease.Linear)
end
else
local sceneType=xianjieModel:sceneIndex2SceneType(sceneidx)
local func=function()
if iscameraLow then
xianjieController:lookAtPositionLow(lookpos,sceneidx,lookAtDuration,cb,DG.Tweening.Ease.Linear,height)
else
xianjieController:lookAtPosition(lookpos,nil,lookAtDuration,cb,DG.Tweening.Ease.Linear)
end
end
xianjieController:jumpXianJie(sceneType,nil,func)
end
end

function xianjieController:jumpGrid2(sceneidx,gridX,gridZ,cb,ease,cameraHeightOffset,lockRange)
local lookpos=xianjieController:worldGridPos2WorldPos4(gridX,gridZ,sceneidx)
if xianjieModel:checkSceneIndex(sceneidx)then
local func2=function()
local height_=xianjieController:getCameraPosition().y
height_=height_+cameraHeightOffset
xianjieController:lookAtPosition(lookpos,height_,0.2,cb,ease,lockRange)
end
xianjieController:lookAtPosition(lookpos,nil,0.2,func2,DG.Tweening.Ease.Linear,lockRange)
else
local sceneType=xianjieModel:sceneIndex2SceneType(sceneidx)
local func=function()
local func2=function()
local height_=xianjieController:getCameraPosition().y
height_=height_+cameraHeightOffset
xianjieController:lookAtPosition(lookpos,height_,0.2,cb,ease,lockRange)
end
xianjieController:lookAtPosition(lookpos,nil,0.2,func2,DG.Tweening.Ease.Linear,lockRange)
end
xianjieController:jumpXianJie(sceneType,nil,func)
end
end

function xianjieController:checkClickCloseSideWin()
if xianjieController:isShowSideWin()then
xianjieController:resetCameraLookAt()
xianjieController:closeWin3()
return true
end
return false
end



function xianjieController:openMonsterInfoWin(infoguid)
local monsterData=xianjieModel:getMonsterData(infoguid)
if monsterData then
if monsterData.entitytype==xjServerEnityType.eMoJieBox then
if xianjienSceneIndexType:isOhterXianYu(monsterData.sceneidx)then
UIManager.error('无法采集其他仙域宝箱')
return
end
local winParams={infoguid=infoguid}
winParams.lookAtPos=monsterData:getWorldPos()
xianjieController:openWin('UIXianJie_MJBoxInfoWin',winParams)
else
if xianjienSceneIndexType:isOhterXianYu(monsterData.sceneidx)then
UIManager.error('无法征讨其他仙域魔物')
return
end
local winParams={infoguid=infoguid}
winParams.lookAtPos=monsterData:getWorldPos()
xianjieController:openWin('UIXianJie_monsterInfoWin',winParams)
end
end
end


function xianjieController:openStationInfoWin(infoguid)
local stationData=xianjieModel:getStationData(infoguid)
local winParams={infoguid=infoguid}
winParams.lookAtPos=stationData:getWorldPos()
xianjieController:openWin('UIXianJie_stationInfoWin',winParams)
end


function xianjieController:openZmInfoWin(ismy,actorId,extra)
local winParams={extra=extra}
local zmData
if not ismy then
winParams={actorId=actorId}
zmData=xianjieModel:getZongMenData(actorId)
else
zmData=xianjieModel:getMyZongMenData()
end
winParams.lookAtPos=zmData:getWorldPos()

local isInvisible=xianjieModel:isZmInvisible(actorId)
if isInvisible then

local enemyType=xianjieModel:checkEnemyType2(actorId,zmData.ownersceneidx)
local isFriend=enemyType==xjEnemyType.eSelf or enemyType==xjEnemyType.eAllies
if not isFriend then

return UIManager.error("该位置似乎已被占据")
end
end

if ismy then
xianjieController:openWin('UIXianJie_selfZmInfoWin',winParams)
else
xianjieController:openWin('UIXianJie_otherZmInfoWin',winParams)
end
end

function xianjieController:openArenaInfoWin(arenaId,openPageIndex,param)
if not arenaId then
logErr("擂台Id为空 请检查传入id是否正确")
return
end
local arenaData=xianjieModel:getArenaDataByArenaId(arenaId)
if not arenaData then
logErr(FMT.fmt("擂台数据为空 擂台id={0}",arenaId))
return
end
local winParams={arenaId=arenaId,openSelectMenuIndex=openPageIndex}
if param and next(param)then
for k,v in pairs(param)do
winParams[k]=v
end
end
winParams.lookAtPos=arenaData:getWorldPos()
local isDoing=xianJieArenaActModel:checkIsXJArenaActDoing()
local isOpen=xianJieArenaActModel:checkIsXJArenaActCanOpen()
if isOpen and isDoing then
xianjieController:openWin('UIXianJieArenaAct_infoWin',winParams)
else
xianjieController:openWin('UIXianJieArenaAct_buffWin',winParams)
end
end

function xianjieController:openMoJiangWin(seasonType,stageIndex,build_id)
local stage=seasonModel:getStage(seasonType,stageIndex)
if stage:checkOpen()and stage:isOverBegin()then
local data=xianjieModel:getMoJiangEntity(seasonType,stageIndex,build_id)
if data then
local winParams={
seasonType=seasonType,
stageIndex=stageIndex,
build_id=build_id,
}
local pos=xianjieController:getCameraPosition()
local cameraY=pos.y
local lookAtPos=data:getWorldPos()
xianjieController:lookAtPosition(lookAtPos,cameraY,lookAtTime,nil,lookAtEase)
xianjieController:openWin('UIZhengTaoMoJiangMonsterInfoWin',winParams)
end
else
local seasonName=seasonModel:getHandleConfig(seasonType,"name")
local stageName=stage:getConfig("name")
UIManager.info(FMT.fmt("{0}第{1}章开启后可查看",seasonName,stageIndex))
end
end

function xianjieController:openBenYuanZhenJiWin(seasonType,stageIndex,build_id)
local stage=seasonModel:getStage(seasonType,stageIndex)
if not stage then
return
end
if stage:checkOpen()and stage:isOverBegin()then
local data=xianjieModel:getBenYuanZhenJiDataByBuildId(seasonType,stageIndex,build_id)
if data then
local winParams={
seasonType=seasonType,
stageIndex=stageIndex,
build_id=build_id,
}
local pos=xianjieController:getCameraPosition()
local cameraY=pos.y
local lookAtPos=data:getWorldPos()
xianjieController:lookAtPosition(lookAtPos,cameraY,lookAtTime,function()
xianjieController:openWin('UIBenYuanZhenJiWin',winParams)
end,lookAtEase)
end
else
local seasonName=seasonModel:getHandleConfig(seasonType,"name")
local stageName=stage:getConfig("name")
UIManager.info(FMT.fmt("{0}·{1}开启后开放",seasonName,stageName))
end
end



function xianjieController:openPuTongZhenJiInfoWin(infoguid)
local monsterData=xianjieModel:getPuTongZhenJiData(infoguid)
if monsterData then
if xianjienSceneIndexType:isOhterXianYu(monsterData.sceneidx)then
UIManager.error('无法征讨其他仙域魔物')
return false
end
local winParams={infoguid=infoguid}
winParams.lookAtPos=monsterData:getWorldPos()
xianjieController:openWin('UIXianJie_puTongZhenJiInfoWin',winParams)
return true
end
return false
end


function xianjieController:openMoJieGateWin(gateId,isShowPassList,isIgnoreEnterAnim,isWarning)
if isWarning==nil then
isWarning=true
end
local gateCfg=cfgHelper.get1(cfg_devildomscenegateconfig_get,gateId)
local gateXYSceneIndex=gateCfg.area
local isSelfXianYu=gateXYSceneIndex==xianjieModel:getXianYuSceneIndex()
if not isSelfXianYu then
if isWarning then
UIManager.error("非本仙域关口，无法查看")
end
return
end


local isHasOwner=false
local gateEntityData=xianjieModel:getMoJieGateData(gateId)
if gateEntityData then
local gateData=gateEntityData.data
local xmData=gateData and gateData.xmInfo or nil
local xmGuid=xmData and xmData.param_1 or nil
isHasOwner=xmGuid and not mathHelper.compareInt64(xmGuid,Int64_0)
end

local winParams={gateId=gateId,isShowPassList=isShowPassList,isIgnoreEnterAnim=isIgnoreEnterAnim}
if isHasOwner then

xianjieController:openWin('UIMoJieGate_infoWin',winParams)
else

xianjieController:openWin('UIMoJieGate_attackWin',winParams)
end

end

function xianjieController:openXianMengWin(guid)
local guidStr=mathHelper.int64_to_string(guid)
self:openXianMengWinEx(guidStr)
end

function xianjieController:openXianMengWinEx(guidStr)
local data=xianjieModel:getXianMengDataEx(guidStr)
if data then
local winArgs={
guild=data.guildid,
lookAtPos=data:getWorldPos(),
}
xianjieController:openWin('UIXianJie_XMInfoWin',winArgs)
end
end

function xianjieController:openMoJunWin()
local mojunData=xianjieModel:getMoJunData()
local seasonType=mojunData.seasonType
local stageIndex=mojunData.stageIndex
local build_id=mojunData.build_id
local stage=seasonModel:getStage(seasonType,stageIndex)
if stage:checkOpen()and stage:isOverBegin()then
local data=xianjieModel:getMoJunEntityData(seasonType,stageIndex)
if data then
local winParams={
seasonType=seasonType,
stageIndex=stageIndex,
build_id=build_id,
}
local pos=xianjieController:getCameraPosition()
local cameraY=pos.y
local lookAtPos=data:getWorldPos()
xianjieController:lookAtPosition(lookAtPos,cameraY,lookAtTime,nil,lookAtEase)
xianjieController:openWin('UIMoJie_MoJunInfoWin',winParams)
end
else
local seasonName=seasonModel:getHandleConfig(seasonType,"name")
local stageName=stage:getConfig("name")
UIManager.info(FMT.fmt("{0}·{1}开启后开放",seasonName,stageName))
end
end

function xianjieController:openMoJunBoxWin(boxId)
local mojunData=xianjieModel:getMoJunData()
local seasonType=mojunData.seasonType
local stageIndex=mojunData.stageIndex
local stage=seasonModel:getStage(seasonType,stageIndex)
if stage:checkOpen()and stage:isOverBegin()then
local data=xianjieModel:getMoJunBoxEntityData(seasonType,stageIndex,boxId)
if data then
local winParams={
seasonType=seasonType,
stageIndex=stageIndex,
boxId=boxId,
}
local pos=xianjieController:getCameraPosition()
local cameraY=pos.y
local lookAtPos=data:getWorldPos()
xianjieController:lookAtPosition(lookAtPos,cameraY,lookAtTime,nil,lookAtEase)
xianjieController:openWin('UIMoJieMoJunBoxInfoWin',winParams)
end
else

local seasonName=seasonModel:getHandleConfig(seasonType,"name")
local stageName=stage:getConfig("name")
UIManager.info(FMT.fmt("{0}·{1}开启后开放",seasonName,stageName))
end
end

function xianjieController:openXJCaravanEscortShipMsgWin(showType,guid,isOpenRecordWin,isNeedJumpWithLD)
local params={showType=showType,guid=guid,isOpenRecordWin=isOpenRecordWin,isNeedJumpWithLD=isNeedJumpWithLD}

local shipData=xianJieCaravanEscortModel:getShipTeamDataByShipGuid(guid)
if not shipData then
UIManager.error("派遣已完成，无法查看仙舟详情")
return
end


UIManager:showWindow('UIXJCaravanEscort_shipMsgWin',params)
end


function xianjieController:openMGZDMoGongInfoWin(arenaId,openSelectMenuIndex)

local data=xianjieModel:getMoGongDataByMoGongId(arenaId)
if data then
local params={arenaId=arenaId,openSelectMenuIndex=openSelectMenuIndex}
local pos=xianjieController:getCameraPosition()
local cameraY=pos.y
local lookAtPos=data:getWorldPos()
xianjieController:lookAtPosition(lookAtPos,cameraY,lookAtTime,function()
xianjieController:openWin('UIMoGongZhengDuoAct_infoWin',params)
end,lookAtEase)
end
end


function xianjieController:openMGZDZhanHunGeInfoWin(arenaId)
local data=xianjieModel:getMGZDBuildDataByBuildID(arenaId)
if data then
local params={arenaId=arenaId}
local pos=xianjieController:getCameraPosition()
local cameraY=pos.y
local lookAtPos=data:getWorldPos()
xianjieController:lookAtPosition(lookAtPos,cameraY,lookAtTime,function()
xianjieController:openWin('UIMoGongZhengDuoAct_buffInfoWin',params)
end,lookAtEase)
end
end


function xianjieController:openMGZDHuLingTaInfoWin(arenaId)
local data=xianjieModel:getMGZDBuildDataByBuildID(arenaId)
if data then
local params={arenaId=arenaId}
local pos=xianjieController:getCameraPosition()
local cameraY=pos.y
local lookAtPos=data:getWorldPos()
xianjieController:lookAtPosition(lookAtPos,cameraY,lookAtTime,function()
xianjieController:openWin('UIMoGongZhengDuoAct_buffInfoWin',params)
end,lookAtEase)
end
end


function xianjieController:openMGZDSettlementWin()
xianjieController:openWin('UIMoGongZhengDuoAct_SettlementWin')
end

function xianjieController:openMGZDFightInfoWin(args)
xianjieController:openWin('UIMoGongZhengDuoAct_FightInfoWin',args)
end

function xianjieController:openMGZDRanktInfoWin(args)
xianjieController:openWin('UIMoGongZhengDuoAct_rankBgWin',args)
end



function xianjieController:openZhenTaiWin(seasonType,stageIndex,build_id)
local stage=seasonModel:getStage(seasonType,stageIndex)
if not stage then return end
if stage:checkOpen()and stage:isOverBegin()then
local data=xianjieModel:getZhenTaiEntity(seasonType,stageIndex,build_id)
if data then
local winParams={
seasonType=seasonType,
stageIndex=stageIndex,
build_id=build_id,
}
local pos=xianjieController:getCameraPosition()
local cameraY=pos.y
local lookAtPos=data:getWorldPos()
xianjieController:lookAtPosition(lookAtPos,cameraY,lookAtTime,nil,lookAtEase)
xianjieController:openWin('UIMoJieZhenTaiWin',winParams)
end
else
local seasonName=seasonModel:getHandleConfig(seasonType,"name")
local stageName=stage:getConfig("name")
UIManager.info(FMT.fmt("{0}第{1}章开启后可查看",seasonName,stageIndex))
end
end


function xianjieController:openLingShouInfoWin(infoguid)
local lsData=xianjieModel:getXJLingShouData(infoguid)
if lsData then
local winParams={infoguid=infoguid}
winParams.lookAtPos=lsData:getWorldPos()
xianjieController:openWin('UIXianJie_lingshouInfoWin',winParams)
end
end

function xianjieController:openLingShouGroupInfoWin(infoguid)
local lsData=xianjieModel:getXJLingShouGroupData(infoguid)
if lsData then
local winParams={infoguid=infoguid}
winParams.lookAtPos=lsData:getWorldPos()
xianjieController:openWin('UIXianJie_lingshouInfoWin',winParams)
end
end