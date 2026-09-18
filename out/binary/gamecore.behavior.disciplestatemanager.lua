







discipleStateManager=gameState.addListener({})

eBtState={
idle=0,
talk=1,
work=2,
scene=3,
duJie=4,
buyer=5,
playdog=6,
seller=7,
}

local _behaviorTreeFile={
[eBtState.idle]='ai_dz_range_move',
[eBtState.talk]='bt_dz_talk',
[eBtState.work]='ai_dz_work',
[eBtState.scene]='bt_dz_scene',
[eBtState.duJie]='bt_dz_dujie',
[eBtState.buyer]='ai_dz_buyer',
[eBtState.playdog]='bt_dz_playdog',
[eBtState.seller]='ai_dz_seller',
}

local _discipleBTDict

local _discipleDataDict
local _discipleBTBBDict
local _discipleGuidDict
local _disciplePosDict
local showDzHudStateDict

local _discipleEntityDict
local _discipleEntityCount

local _discipleLingShouDict
local _discipleLSFollowBTDict
local _discipleFollowLsEntityCount

local _directionList={
{x=0,y=1},
{x=1,y=0},
{x=0,y=-1},
{x=-1,y=0}
}

function discipleStateManager:onAppStart()
self:onLeaveHome()

self.abName='ui/sharedtextures/uiglobalspriteatlas_1.ab'
self.skins={
'frame_duihuaqipaokuang_1',
'frame_duihuaqipaokuang_2',
}

self.workBDCheck={
[sysWinType.eFangAn]=true,
[sysWinType.eShangPu]=true,
[sysWinType.eShouLan]=true,
}
end

function discipleStateManager:onEnterState(...)
notifySystem:listenNotify(notifyConfig.building_event,self.on_building_event)
notifySystem:listenNotify(notifyConfig.onDiscipleStateChange,self.onDiscipleStateChange)
notifySystem:listenNotify(notifyConfig.onDiscipleTianMingLvChange,self.onDiscipleTianMingLvChange)
end

function discipleStateManager:onLeaveState(...)
notifySystem:removelistener(notifyConfig.building_event,self.on_building_event)
notifySystem:removelistener(notifyConfig.onDiscipleStateChange,self.onDiscipleStateChange)
notifySystem:removelistener(notifyConfig.onDiscipleTianMingLvChange,self.onDiscipleTianMingLvChange)
end

function discipleStateManager:getSpeakSkinInfoById(id)
return self.abName,self.skins[id]
end

function discipleStateManager:getQiPaoSkinInfoById()
return"ui/windows/hud/hud_sprite_atlas_pak.ab","image_qipaokuang_1"
end



function discipleStateManager:onEnterHome()
self.isInHome=true
self:setBirthPoints()

discipleStateManager:loadAllDisciple(mapIdType.zhufeng)
end

function discipleStateManager:onLeaveHome()
self.isInHome=false
_disciplePosDict={}
if _discipleGuidDict then
for guid,dzId in pairs(_discipleGuidDict)do
if aiManager:getAIMapID(guid)==mapIdType.zhufeng then
local pos=_MapManager.GetTilemapObjectPosition(guid)
_disciplePosDict[tostring(dzId)]=pos
end
end
end
_discipleBTDict={}

_discipleDataDict={}
_discipleBTBBDict={}
_discipleGuidDict={}
showDzHudStateDict={}
_discipleEntityDict={}
_discipleLingShouDict={}
_discipleLSFollowBTDict={}
_discipleEntityCount=0
_discipleFollowLsEntityCount=0
end

function discipleStateManager:loadAllDisciple(sfId)
local rposList=zongmenModel:getDiscipleWorkPosList()
local disciples=UIDiscipleModel:getAllDiscipleData()
local nlist={}
for k,v in pairs(disciples)do
local dzId=v.netData.net.discipleguid
if discipleStateManager:isMustCreate(dzId)then
discipleStateManager:createRole(dzId,sfId,rposList[tostring(dzId)])
else
table.insert(nlist,dzId)
end
end

local limit=discipleStateManager:getDZCreateLimit()
for i,v in ipairs(nlist)do
if aiManager:getAIDZCount()<limit then
discipleStateManager:createRole(v,sfId,rposList[tostring(v)])
end
end
end

function discipleStateManager:getDZCreateLimit()
local key
if webGLHelper:isWebGLOptimization()then
key='create_limit_webgl'
else
key='create_limit'
end
local limit=cfgHelper.get2(cfg_discipleaiconfig_get,1,key)
return limit
end

function discipleStateManager.on_building_event(etype,sfId,ubdId,arg1,arg2,arg3,arg4)
if etype==buildingEvent.switchRoomDizi then
if arg4==nil then

local dzIdStr=tostring(arg2)
if dzIdStr~='0'then

aiStateManager:setAIState(dzIdStr,aiStateType.homeless,false)
end
local oldDzIdStr=tostring(arg3)
if oldDzIdStr~='0'then







aiStateManager:setAIState(oldDzIdStr,aiStateType.homeless,true)
end
end
elseif etype==buildingEvent.planStart then
aiManager:beginWorkAI(arg1,ubdId)
elseif etype==buildingEvent.planComplete then
aiManager:endWorkAI(arg1)
elseif etype==buildingEvent.storageBuilding then
local storageBDData=zongmenModel:getAllstorageBuilding()
local bdData=storageBDData[ubdId]
if bdData then
local dzId=bdData.dizi_id
if tostring(dzId)~='0'then
local bt=aiManager:getDiscipleCurrentCMDBT(dzId)
if bt then
bt:broke()
bt:setSharedVar('work',0)
bt:reset()
end
end
end
elseif etype==buildingEvent.replaceDisciple then
local newDzId=arg1
local oldDzId=arg2
local newDzIdStr=tostring(newDzId)
local oldDzIdStr=tostring(oldDzId)
if newDzIdStr~='0'and discipleStateManager:isMustCreate(newDzId)then

if not aiManager:hasDiscipleBT(newDzId)then
local bdData=zongmenModel:getBuildingData(ubdId)
local mapId=_MapManager.GetObjectMapID(bdData.entityId)
discipleStateManager:createRole(newDzId,mapId)
end
end
discipleStateManager:replaceDzResetSceneAI(sfId,ubdId,newDzId,oldDzId)
if oldDzIdStr~='0'and not discipleStateManager:isMustCreate(oldDzId)then
if aiManager:hasDiscipleBT(oldDzId)then
discipleStateManager:removeRole(oldDzId)
end
end
end
end


function discipleStateManager:replaceDzResetSceneAI(sfId,ubdId,newDzId,oldDzId)
local bdData=zongmenModel:getBuildingData(ubdId)
if bdData then
local newDzIdStr=tostring(newDzId)
local oldDzIdStr=tostring(oldDzId)
local cfg=cfgHelper.get1(cfg_monijybuildconfig_get,bdData.build_id)
local beginName
local endName
local ptype=cfg.win_type
if ptype==sysWinType.eShangPu then
beginName='beginSellerAI'
endName='endSellerAI'
elseif ptype==sysWinType.eShouLan then
beginName='beginFeedingAI'

endName='finishFeedingAI'
else
return
end

if newDzIdStr~='0'then
aiManager[beginName](aiManager,newDzId,ubdId)
end

if oldDzIdStr~='0'then
aiManager[endName](aiManager,oldDzId,ubdId)
end
end
end

function discipleStateManager:beginSpeak(dzId,stId,refreshPos,callback)







end

function discipleStateManager:endSpeak(dzId,spId)





end



function discipleStateManager.onDiscipleStateChange(discipleguid,stateType,old,cur)
if stateType==DISCIPLE_STATE_TYPE.edsDispatch then
if old and not cur then
discipleStateManager:createRole(discipleguid,mapIdType.zhufeng)
elseif not old and cur then
discipleStateManager:removeRole(discipleguid)
end
elseif stateType==DISCIPLE_STATE_TYPE.eChuiWei then
local guid=_discipleEntityDict[tostring(discipleguid)]
if guid then




discipleStateManager:refreshDiscipleBody(discipleguid,guid,cur)
local dzWR=zongmenModel:getDiscipleWorkroom(discipleguid)
if dzWR then
hudControl:refreshBuildingStatusHUD(dzWR.un_build_id)
end
end
local home=zongmenModel:getDiZiHome(discipleguid)
if home then
hudControl:refreshBuildingStatusHUD(home)
end
local bdData=zongmenModel:findBuildingByManager(zongmenModel:getMountainId(),discipleguid)
if bdData then
hudControl:refreshBuildingStatusHUD(bdData.un_build_id)
end
end
end

function discipleStateManager.onDiscipleTianMingLvChange(discipleguid,oldtmlv,tmlv)
local guid=_discipleEntityDict[tostring(discipleguid)]
if guid and oldtmlv~=tmlv then
local dying=UIDiscipleModel:checkDiscipleState(discipleguid,DISCIPLE_STATE_TYPE.eChuiWei)
if not dying then
discipleStateManager:refreshDiscipleBody(discipleguid,guid,dying)
end
end
end

function discipleStateManager:refreshDiscipleBody(dzId,guid,dying)
local args={
tmLv=UIDiscipleModel:getTianMingLevel(dzId)
}
local info=UIDiscipleModel:getDiscipleOutsideModelInfo(dzId,nil,nil,args)
local body=info.body
local slots=info.componets
if dying then
local sex=UIDiscipleModel:getDiscipleSex(dzId)
body=sex==1 and 1114103 or 1114104
local scale=isometricMapSystem:getModelScale(body)
isometricMapSystem:changeBody(guid,body,nil,scale)
else
local scale=isometricMapSystem:getModelScale(body)
isometricMapSystem:changeBody(guid,body,slots,scale)
end
end

function discipleStateManager:refreshDiscipleModel(dzId)
local guid=self:getDiscipleEntity(dzId)
if not guid then
return
end
local args={
tmLv=UIDiscipleModel:getTianMingLevel(dzId)
}
local info=UIDiscipleModel:getDiscipleOutsideModelInfo(dzId,nil,nil,args)
local body=info.body
local slots=info.componets
if UIDiscipleModel:checkDiscipleState2(dzId,DISCIPLE_STATE_TYPE.eChuiWei)then
local sex=UIDiscipleModel:getDiscipleSex(dzId)
body=sex==1 and 1114103 or 1114104
local scale=isometricMapSystem:getModelScale(body)
isometricMapSystem:changeBody(guid,body,nil,scale)
else
local scale=isometricMapSystem:getModelScale(body)
isometricMapSystem:changeBody(guid,body,slots,scale)
end
end

function discipleStateManager:setBirthPoints()
self.birthPoints=aiManager:getBirthPointList(mapIdType.zhufeng)
end

function discipleStateManager:getBirthPoint()
local pos=self.birthPoints[math.random(1,#self.birthPoints)]
return pos
end

function discipleStateManager:isMustCreate(dzId)

if webGLHelper:isRunMiniGame()then
return false
end
if UIDiscipleModel:isSpecialDZ(dzId)then
return true
end

local bdData=zongmenModel:getDiscipleWorkroom(dzId)
if not bdData then
return false
end

local cfg=cfgHelper.get1(cfg_monijybuildconfig_get,bdData.build_id)
if cfg.build_type==SLG_SYSTEM_TYPE.eLianDanFang then
return true
end

return self.workBDCheck[cfg.win_type]==true
end

function discipleStateManager:createRoleEx(dzId,mapId,bpos)
if discipleStateManager:isMustCreate(dzId)then
discipleStateManager:createRole(dzId,mapId,bpos)
end
end


function discipleStateManager:enableCreateRole(dzId)
local dzState=UIDiscipleModel:getDiscipleState(dzId)
if dzState==DISCIPLE_STATE_TYPE.edsDispatch then
return false
end

return true
end


function discipleStateManager:createRole(dzId,mapId,bpos)
if self.isInHome then
if not self:enableCreateRole(dzId)then
return false
end
local dzState=UIDiscipleModel:getDiscipleState(dzId)
local dzData=UIDiscipleModel:getDiscipleData(dzId)
if dzData then
local chuiwei=dzState==DISCIPLE_STATE_TYPE.eChuiWei
local dzIdStr=tostring(dzId)
local pos=_disciplePosDict[dzIdStr]
if not pos then
if bpos then
pos=bpos
else
if dzData:check_in()and chuiwei then
local room=zongmenModel:getDiscipleRoom(dzId,mapId)
pos=_MapManager.GetTilemapObjectPosition(room.entityId)
else
local bp=self:getBirthPoint()
local spos=_MapManager.ToVector3Int(bp[1],bp[2],0)
pos=_MapManager.RandomANearbyPosition(mapId,spos,bp[3])
end
end
end

local idxPos=shanmenModel:getBaiShanDzPos(dzId)
if idxPos then
pos=_MapManager.ToVector3Int(idxPos[1],idxPos[2],0)
end
local args={
tmLv=UIDiscipleModel:getTianMingLevel(dzId)
}
local info=UIDiscipleModel:getDiscipleOutsideModelInfo(dzId,nil,nil,args)

if chuiwei then
local sex=UIDiscipleModel:getDiscipleSex(dzId)
info.body=sex==1 and 1114103 or 1114104
info.componets=nil
end
local isSmall=true




local body=info.body
local scale=isometricMapSystem:getModelScale(body)
local slots=info.componets

local guid=isometricMapSystem:createRoleEntity(objectType.eRole,mapId,0,body,slots,SortingLayers.ITBuilding,scale,pos,nil,isSmall)
mountHelper.setRoleMoveMount(guid,dzId)

if not chuiwei then
_MapManager.ShowShadow(guid,true)
end
_discipleDataDict[dzIdStr]=dzData
_discipleGuidDict[guid]=dzId
_discipleEntityDict[dzIdStr]=guid
_discipleEntityCount=_discipleEntityCount+1

aiManager:addDiscipleAI(dzId,guid,eAIDZType.eDefault)

local srcType=UIDiscipleModel:getDiscipleSrcType(dzId)
local disData=UIDiscipleModel:getDiscipleDataX(dzId)
local isNewBs=disData.netData.isnew
if srcType==discipleSrcType.eBaiShan and isNewBs then
local speakstr=shanmenModel:getSuccessSpeakStr()
local enterPos=shanmenModel.getBaiShanConfigField('baishanEnterPos')
aiManager:addCommandToDisciple(dzId,{type=eAIType.eBaiShan,initData={speakstr=speakstr,enterPos=enterPos}})
end

if dzData:check_in()then
local bdData=zongmenModel:getDiscipleWorkroom(dzId)
if bdData then
if chuiwei and bdData.plant_id==0 then

else
local cfg=cfgHelper.get1(cfg_monijybuildconfig_get,bdData.build_id)
local ptype=cfg.win_type
if bdData.plant_id>0 then
aiManager:beginWorkAI(dzId,bdData.un_build_id)
elseif ptype==sysWinType.eShangPu then
aiManager:beginSellerAI(dzId,bdData.un_build_id)
elseif cfg.build_type==SLG_SYSTEM_TYPE.eLianDanFang then

if dzState==DISCIPLE_STATE_TYPE.eLianDan then
aiManager:beginWorkAI(dzId,bdData.un_build_id)
end
end
end
end
end


if not dzData:check_in()and not chuiwei then








aiStateManager:setAIState(dzId,aiStateType.homeless,true)
end
end
end
end

function discipleStateManager:getDiscipleEntity(dzId)
local dzIdStr=tostring(dzId)
local guid=_discipleEntityDict[dzIdStr]
return guid
end

function discipleStateManager:removeRole(dzId)

self:removeFollowRoleLingShou(dzId)

local dzIdStr=tostring(dzId)
local guid=_discipleEntityDict[dzIdStr]
if guid then
aiManager:removeDiscipleAI(dzId)
_MapManager.RemoveTilemapObject(guid)

_discipleGuidDict[guid]=nil

hudControl:clearHUDByEntityID(guid)

_discipleBTBBDict[dzIdStr]=nil
_discipleDataDict[dzIdStr]=nil
_discipleEntityDict[dzIdStr]=nil
_discipleEntityCount=_discipleEntityCount-1
if _discipleEntityCount<0 then
_discipleEntityCount=0
end
end
end

function discipleStateManager:checkNeedRemove(dzId)
if not discipleStateManager:isMustCreate(dzId)then
if aiManager:hasDiscipleBT(dzId)then
discipleStateManager:removeRole(dzId)
end
end
end










function discipleStateManager:addDiscipleNewCMD(dzid,aiType,initData,callback)
if dzid==nil then
return
end





local beginCallback=function(dzId,stId,bt)

if callback then
callback(dzId,bt)
end
end
local endCallback=function(dzId,stId,bt)
bt:setSharedVar(behaviorConfig.stateIdKey)
end
table.insert(initData,{behaviorConfig.stateIdKey,aiType})
local cmdData=
{
type=aiType,
initData=initData,
restorePreviousAI=true,
beginCallback=beginCallback,
endCallback=endCallback,
}
aiManager:addCommandToDisciple(dzid,cmdData)
end

function discipleStateManager:switchBT(dzId,aiType,initData,checkFree,callback)
local bt=self:getCurExecuteBT(dzId)
if bt then
local runType=bt:getSharedVar(behaviorConfig.stateIdKey)
if checkFree and runType~=nil then
return
end

if runType~=aiType then
self:addDiscipleNewCMD(dzId,aiType,initData,callback)
end
end
end

function discipleStateManager:getCurExecuteBT(dzId)
local bt=aiManager:getDiscipleCurrentCMDBT(dzId)
return bt

end

function discipleStateManager:getDiscipleState(dzId)
local bt=self:getActiveBehaviorTree(dzId)
if bt then
return bt:getSharedVar(behaviorConfig.stateIdKey)
end
end

function discipleStateManager:getSharedBlackBoard(dzId)
local dzIdStr=tostring(dzId)
local blackBoard=_discipleBTBBDict[dzIdStr]
if blackBoard==nil then
blackBoard={}
_discipleBTBBDict[dzIdStr]=blackBoard
end
return blackBoard
end

function discipleStateManager:cleanSharedBlackBoard(dzId)
local bb=self:getSharedBlackBoard(dzId)

for k,v in pairs(bb)do
bb[k]=nil
end
end

function discipleStateManager:getActiveBehaviorTree(dzId)








return nil
end

function discipleStateManager:clickDisciple(guid)
local dzId=_discipleGuidDict[guid]




if aiManager:isDZDying(dzId)then
UIFullDiscipleMainControl:showWindowInfo({dis_guid=dzId})
end
end

function discipleStateManager:getTalkContents(dzIdA,dzIdB)
local dataA=_discipleDataDict[tostring(dzIdA)]
local dataB=_discipleDataDict[tostring(dzIdB)]
if dataA and dataB then
local relation
if not dataA:check_in()and not dataB:check_in()then
relation=8
elseif not dataA:check_in()and dataB:check_in()then
relation=9
else
relation=0
end
return cfgHelper.get1(cfg_discipletalkconfig_get,relation)
end
end

function discipleStateManager:getWorkRoom(dzId)
return zongmenModel:getDiscipleWorkroom(dzId)
end

function discipleStateManager:getSelfRoom(dzId)
return zongmenModel:getDiscipleRoom(dzId)
end

function discipleStateManager:getDuJieRoom(dzId)
return FeiShengTaiModel:getBuilding()
end

function discipleStateManager:getBuildingData(dzId,ignore_ubdId)
local dzData=_discipleDataDict[tostring(dzId)]
if dzData then
local bdData=zongmenModel:getAllBuildingDataByBdIdWithIgnoreGUID(zongmenModel:getMountainId(),bdId,ignore_ubdId)
local len=#bdData
if len>0 then
local index=math.random(1,len)
return bdData[index]
end
end
end

function discipleStateManager:getTalkPos(startPos,endPos)
if startPos and endPos then
local index=1
local sp=_MapManager.Vector3IntToArray(startPos)
local ep=_MapManager.Vector3IntToArray(endPos)
local dx=ep[1]-sp[1]
local dy=ep[2]-sp[2]
local k=math.abs(dy/dx)
if k>1 then
if dy>0 then
index=1
else
index=3
end
else
if dx>0 then
index=2
else
index=4
end
end
local dir=_directionList[index]
local target=_MapManager.AddVector3Int(endPos,-dir.x,-dir.y,0)
if _MapManager.IsCanMove(target)then
return target
end
end
end

function discipleStateManager:getDiscipleBTByGuid(guid)
local dzId=_discipleGuidDict[guid]
return self:getActiveBehaviorTree(dzId)
end

function discipleStateManager:entityIdToDiscipleId(stId)
return _discipleGuidDict[stId]
end

function discipleStateManager:getAllDiscipleBTByState(stateId)
local allBts={}
local file=_behaviorTreeFile[stateId]
if file then
for i,bts in pairs(_discipleBTDict)do
local bt=bts[file]
if bt and not bt.sleep then
table.insert(allBts,bt)
end
end
else

end
return allBts
end

function discipleStateManager:getRandomDiscipleBTByState(stateId)
local allBts=self:getAllDiscipleBTByState(stateId)
local len=#allBts
if len>1 then
local index=math.random(1,len)
return allBts[index]
elseif len>0 then
return allBts[1]
end
end



function discipleStateManager:addFollowRoleLingShou(dzId,dzStGuid,pos,mapId,waitTime)
local dzIdStr=tostring(dzId)
dzStGuid=dzStGuid or _discipleEntityDict[dzIdStr]
if dzStGuid then
local dzState=UIDiscipleModel:getDiscipleState(dzId)
local chuiwei=dzState==DISCIPLE_STATE_TYPE.eChuiWei
if chuiwei then

return
end

local dzNowFollowLsGuid=_discipleLingShouDict[dzIdStr]
if dzNowFollowLsGuid then

return
end

local aicfg=cfgHelper.get1(cfg_lingshouaiconfig_get,1)
local maxFollowDzLsPercent=aicfg.maxFollowDzLsPercent
local maxFollowLsCount=math.floor(_discipleEntityCount*maxFollowDzLsPercent)
if _discipleFollowLsEntityCount+1>maxFollowLsCount then

return
end

local lsGuid=UIDiscipleModel:getDZLingShou(dzId)
if lsGuid then
local model=lingshouModel:getLingShouModel(lsGuid)
if model then
pos=pos or _MapManager.GetTilemapObjectPosition(dzStGuid)
mapId=mapId or _MapManager.GetObjectMapID(dzStGuid)

local lsStGuid,followBt=lingShouAIManager:createAFollowLingShou(lsGuid,model,pos,mapId,dzId,waitTime)
_discipleLingShouDict[dzIdStr]=lsStGuid
_discipleLSFollowBTDict[lsStGuid]=followBt
_discipleFollowLsEntityCount=_discipleFollowLsEntityCount+1
end
end
end
end


function discipleStateManager:removeFollowRoleLingShou(dzId)
local dzIdStr=tostring(dzId)
local lsEntGuid=_discipleLingShouDict[dzIdStr]
if lsEntGuid then
local followBt=_discipleLSFollowBTDict[lsEntGuid]
if followBt then
behaviorManager:removeBehaviorTree(followBt)
end
_MapManager.RemoveTilemapObject(lsEntGuid)
_discipleLingShouDict[dzIdStr]=nil
_discipleFollowLsEntityCount=_discipleFollowLsEntityCount-1
if _discipleFollowLsEntityCount<0 then
_discipleFollowLsEntityCount=0
end
end
end
