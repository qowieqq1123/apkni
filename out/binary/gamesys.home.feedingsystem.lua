
feedingSystem=gameState.addListener({})


local _s_move_check_id=5
local _s_path_check_id=6


local _b_move_check_id=8
local _b_path_check_id=5
function feedingSystem:onAppStart()

end

function feedingSystem:onEnterState(isReconnect)
if isReconnect then
return
end
self.feedBuildingData={}
self.feedMonsterData={}
self.EIDToGUID={}
self.hudIDRecord={}

self.countDownData={}

self.xqLimitCfgVal=cfgHelper.getdef1(cfg_lingshouconfig,'love_create')

notifySystem:listenNotify(notifyConfig.home_event,self.on_home_event)
end

function feedingSystem:onLeaveState(isReconnect)
if isReconnect then
return
end
self.feedBuildingData=nil
self.feedMonsterData=nil
self.EIDToGUID=nil

notifySystem:removelistener(notifyConfig.home_event,self.on_home_event)
end

function feedingSystem.on_home_event(etype)
if etype==homeEvent.eEnterHome then
feedingSystem:onEnterHome()
elseif etype==homeEvent.eLeaveHome then
feedingSystem:onLeaveHome()
end
end

function feedingSystem:onEnterHome()
self.pickUpTarget=-1

timeEventController.addNormalTimerHandler(1,'feedingSystem',self)
end

function feedingSystem:onLeaveHome()






self.feedBuildingData={}
self.feedMonsterData={}
self.EIDToGUID={}

timeEventController.removeNormalTimerHandler(1,'feedingSystem')
end

function feedingSystem:onNormalUpdate(delay)
local time=gameUtilityModel.getServerShortTime()
for k,v in pairs(self.countDownData)do
if time>=v.reqTime then
self.countDownData[k]=nil
local isCanCreate=UIShouLanModel:isShouLanCanCreate(v.slId,k)
if isCanCreate then
UIShouLanControl:reqShouLanRewardList(v.slId,int64.new(k))
end
end
end
end

function feedingSystem:onTouchDown(screenPoint)
if self.pickUpTarget>0 then
local pos=isometricMapSystem:screenToMapPos(screenPoint)
if not _MapManager.IsPositionEqual(pos,self.monsterPos)then
self.monsterPos=pos
_MapManager.SetPositionAndCentered(self.pickUpTarget,pos)
end
end
end

function feedingSystem:isCanRemove(slId,mId,wraning)
local data=UIShouLanModel:getMonsterData(slId,mId)
if data and data.len>0 then
if wraning then
UIManager.error('灵兽材料未领取')
end
return false
end
return true
end

function feedingSystem:checkPutIn(slId,mId)
local volume=lingshouModel.getLingShouPropertyValEx(mId,lingshouPropertyType.VOLUME)
return UIShouLanModel:isCanPutIn_reasonType(slId,volume)
end

function feedingSystem:getShouLanCreateXinQingLimitCfgValue()
return self.xqLimitCfgVal
end

function feedingSystem:onTouchUp(screenPoint,guid)
if self.pickUpTarget>0 then
local data=self:getMonsterDataByEID(self.pickUpTarget)

local mapId=zongmenModel:getMountainId()
local bdEID=_MapManager.GetCoverObjectByPos(mapId,self.monsterPos)



local initData={
data=data,
mapId=mapId,
bdEID=bdEID,
waitReq=false,
reason=0,
home=data.home,
}

behaviorManager:addBehaviorTree('bt_move_lingshou',nil,true,initData,true)



















































end
end

function feedingSystem:mls_check_remove(bt,data)
local bdData=zongmenModel:findBuildingByEntityId(data.home)
bt:setSharedVar('waiting',true)
feedingSystem:checkAndRemoveLingShou(bdData.un_build_id,data.mId,function(isOK)
bt:setSharedVar('waiting',false)
bt:setSharedVar('canRemove',isOK)
end)
end

function feedingSystem:mls_handle_remove(bt,slId,data)
self.waitRemove=true
bt:setSharedVar('waitReq',true)
end

function feedingSystem:mls_can_not_remove(bt,data)
_MapManager.SetPosition(data.stId,self.rcMPos)
data.bt:reset()
bt:setSharedVar('canAdd',false)
end

function feedingSystem:mls_req_add(bt,bdEID,data)
local bdData=zongmenModel:findBuildingByEntityId(bdEID)
local reason=self:checkPutIn(bdData.un_build_id,data.mId)
if reason==0 then
UIShouLanControl:reqAddToShouLan(bdData.un_build_id,1,{int64.new(data.mId)})
self.waitAdd=true
bt:setSharedVar('waitReq',true)
end
bt:setSharedVar('reason',reason)
end

function feedingSystem:mls_can_not_add(bdEID,reason,mapId,data)
if bdEID>0 and not data.home then
self:moveToBuildingNearbySpace(bdEID,data.stId)
if reason==1 then
UIManager.error('兽栏已无法容纳该灵兽')
end
else
if data.home then
_MapManager.SetPosition(data.stId,self.rcMPos)
else
local pos=_MapManager.GetTilemapObjectPosition(data.stId)
local moveCheckId=data.bt:getSharedVar('moveCheckId')
if not _MapManager.IsCanMove(mapId,pos,moveCheckId)then
_MapManager.SetPosition(data.stId,self.rcMPos)
end
end
end
data.bt:reset()
end

function feedingSystem:mls_end()
self.pickUpTarget=-1
self.monsterPos=nil
self.rcMPos=nil
UILayoutControl:closeUI()
isometricMapSystem:setOtherDragFlag(false)
end

function feedingSystem:onLongTapStart(screenPoint,guid)
if isometricMapSystem:getLayoutMode()==layoutMode.eDefault then
local objType=_MapManager.GetObjectType(guid)
if objType==objectType.eLingShou then
self.pickUpTarget=guid
local data=self:getMonsterDataByEID(guid)
data.bt:broke()
local pos=isometricMapSystem:screenToMapPos(screenPoint)
self.monsterPos=pos
self.rcMPos=_MapManager.GetTilemapObjectPosition(data.stId)
isometricMapSystem:enterFeedingLayoutMode({lsdata=data})
isometricMapSystem:setOtherDragFlag(true)
end
end
end

function feedingSystem:onLongTapEnd(screenPoint)

end

function feedingSystem:init()
self.birthPoints=aiManager:getBirthPointList(mapIdType.lingshoudao)
self:addAllMonsterToScene()
UIShouLanControl:addAllMenberToShouLan()
UIShouLanControl:refreshAllShouLanDecorate()


local dzlist=aiManager:getSomeDiscipleByMode(eAICMDMode.eIdle,eAIDZType.eDefault,0.5)
for i,v in ipairs(dzlist)do
aiManager:allocateToMap(v,mapIdType.lingshoudao,nil,_s_move_check_id)
end
end

function feedingSystem:getMonsterData(mId)
mId=tostring(mId)
return self.feedMonsterData[mId]
end

function feedingSystem:getMonsterDataByEID(eId)
local mId=self.EIDToGUID[eId]
return self.feedMonsterData[mId]
end

function feedingSystem:setMonsterBTSharedValue(mId,key,value)
local data=self:getMonsterData(mId)
if data then
data.bt:setSharedVar(key,value)
end
end

function feedingSystem:getABirthPoint()
local bp=self.birthPoints[math.random(1,#self.birthPoints)]
local spos=_MapManager.ToVector3Int(bp[1],bp[2],0)
local pos=_MapManager.RandomANearbyPosition(mapIdType.lingshoudao,spos,bp[3],_s_move_check_id)
return pos
end

function feedingSystem:addAllMonsterToScene()
local datas=lingshouModel:getLingShouDatas()
for k,v in pairs(datas)do
self:addAMonsterToScene(k,v.cfg.model)
end
end

function feedingSystem:addAllMonsterData()
local datas=lingshouModel:getLingShouDatas()
for k,v in pairs(datas)do
self:addAMonsterData(k)
end
end

function feedingSystem:handleAddLingShou(data)
if mountainControl:isLoaded(mapIdType.lingshoudao)then

self:addAMonsterData(data.guid)
end
end

function feedingSystem:handleRemoveLingShou(mId)
if mountainControl:isLoaded(mapIdType.lingshoudao)then

self:removeAMonsterData(mId)
end
end

function feedingSystem:addFeedBuilding(bdData)
self.feedBuildingData[bdData.entityId]={bdId=bdData.un_build_id,monsterDatas={}}
end

function feedingSystem:removeFeedBuilding(entityId)
self.feedBuildingData[entityId]=nil
end

function feedingSystem:addCountDownData(slId,lsId)
lsId=tostring(lsId)
local data=UIShouLanModel:getMonsterData(slId,lsId)
local lsData=lingshouModel:getLingShouData(lsId)
if data and lsData then
local cdTime=data.sec
local reqTime=data.begin_time+cdTime+1
self.countDownData[lsId]={reqTime=reqTime,slId=slId}
end
end

function feedingSystem:removeCountDownData(lsId)
self.countDownData[lsId]=nil
end

function feedingSystem:isInBuildingArea(bdData,pos)
local posArr=_MapManager.Vector3IntToArray(pos)
local size=cfgHelper.get2(cfg_monijybuildconfig_get,bdData.build_id,'buid_size')
local tx=posArr[1]
local ty=posArr[2]
if tx>=bdData.x and tx<bdData.x+size[1]and ty>=bdData.y and ty<bdData.y+size[2]then
return true
end
end

function feedingSystem:addToBuilding(bdData,lsId)
lsId=tostring(lsId)
local eId=bdData.entityId
local lsdata=self:getMonsterData(lsId)
local mapId=_MapManager.GetObjectMapID(eId)
local pos=_MapManager.GetTilemapObjectPosition(lsdata.stId)
if not self.waitAdd or not _MapManager.IsCanMove(mapId,pos,8)or not self:isInBuildingArea(bdData,pos)then
local tpos=_MapManager.GetAPosCanPutDownInLayoutBuilding(eId,8)
_MapManager.SetPosition(lsdata.stId,tpos)
end
local bt=lsdata.bt
bt:setSharedVar('moveCheckId',_b_move_check_id)
bt:setSharedVar('pathCheckId',_b_path_check_id)
if not bt:isEnding()then
bt:broke()
end
bt:reset()
_MapManager.AddMemberToLayoutBuilding(eId,lsdata.stId)

local fbd=self.feedBuildingData[eId]
fbd.monsterDatas[lsId]=lsdata
lsdata.home=eId

self.waitAdd=false
end

function feedingSystem:lsSceneDataAddToBuilding(bdData,lsGuid,lsSceneData)
local lsGuidStr=tostring(lsGuid)
local eId=bdData.entityId
local fbd=self.feedBuildingData[eId]
if fbd and fbd.monsterDatas then
fbd.monsterDatas[lsGuidStr]=lsSceneData
end
end

function feedingSystem:moveToBuildingNearbySpace(bstId,mstId)
local plist=_MapManager.GetPlaceObjectNearbySpace(bstId,1,_s_move_check_id)
if plist then
local tpos=plist[math.random(0,plist.Count-1)]
_MapManager.SetPosition(mstId,tpos)
else
local tpos=_MapManager.GetTilemapObjectPosition(bstId)
_MapManager.SetPosition(mstId,tpos)
end
end

function feedingSystem:removeFormBuilding(eId,lsId)
lsId=tostring(lsId)
local lsdata=self:getMonsterData(lsId)
local mapId=_MapManager.GetObjectMapID(eId)
local pos=_MapManager.GetTilemapObjectPosition(lsdata.stId)
if not self.waitRemove or not _MapManager.IsCanMove(mapId,pos,_s_move_check_id)then
self:moveToBuildingNearbySpace(eId,lsdata.stId)
end
local bt=lsdata.bt
bt:setSharedVar('moveCheckId',_s_move_check_id)
bt:setSharedVar('pathCheckId',_s_path_check_id)
if not bt:isEnding()then
bt:broke()
end
bt:reset()
_MapManager.RemoveMemberFormLayoutBuilding(eId,lsdata.stId)

local fbd=self.feedBuildingData[eId]
fbd.monsterDatas[lsId]=nil
lsdata.home=nil

self.waitRemove=false
end

function feedingSystem:lsSceneDataRemoveFormBuilding(eId,lsGuid)
local lsGuidStr=tostring(lsGuid)
local fbd=self.feedBuildingData[eId]
fbd.monsterDatas[lsGuidStr]=nil
end

function feedingSystem:addAMonsterToScene(mId,model)
mId=tostring(mId)
local pos=feedingSystem:getABirthPoint()
local guid,bt=self:createAMonster(mId,model,pos)
bt:setSharedVar('moveCheckId',_s_move_check_id)
bt:setSharedVar('pathCheckId',_s_path_check_id)
local data={mId=mId,stId=guid,bt=bt}
self.feedMonsterData[mId]=data
self.EIDToGUID[guid]=mId
end

function feedingSystem:addAMonsterData(mId)
mId=tostring(mId)
local data={mId=mId}
self.feedMonsterData[mId]=data
end

function feedingSystem:removeAMonsterFormScene(mId)
mId=tostring(mId)
local data=self.feedMonsterData[mId]
if data then
self:removeAMonster(data)
end
self.feedMonsterData[mId]=nil
self.EIDToGUID[data.stId]=nil
end

function feedingSystem:removeAMonsterData(mId)
mId=tostring(mId)
self.feedMonsterData[mId]=nil
end

function feedingSystem:createAMonster(mId,model,pos)
local scale=isometricMapSystem:getModelScale(model)
local guid=isometricMapSystem:createRoleEntity(objectType.eLingShou,mapIdType.lingshoudao,1116,model,nil,
SortingLayers.ITBuilding,scale,pos)
local initData={
stId=guid,
show_hud=false,
}
local bt=behaviorManager:addBehaviorTree('ai_ys_range_move',{stId=guid},true,initData)
return guid,bt
end

function feedingSystem:removeAMonster(fdata)
behaviorManager:removeBehaviorTree(fdata.bt)
_MapManager.RemoveTilemapObject(fdata.stId)
end

function feedingSystem:pickUpFeedBuilding(entityId)
local fbd=self.feedBuildingData[entityId]
if fbd then
for k,v in pairs(fbd.monsterDatas)do
v.bt:broke()
end
end
end

function feedingSystem:placeFeedBuilding(entityId)
local fbd=self.feedBuildingData[entityId]
if fbd then
for k,v in pairs(fbd.monsterDatas)do
v.bt:reset()
end
end
end


function feedingSystem:getElementDataM(cfg)
local list={}







if cfg.element then
local element=cfg.element
table.insert(list,{1,element})
end









return list
end


function feedingSystem:getElementDataSL(slId,mode)
local slData
local cfg
if mode==1 then
slData=UIShouLanModel:getShouLanData(slId)
cfg=cfgHelper.get1(cfg_petbuildconfig_get,slData.build_id)
else
cfg=cfgHelper.get1(cfg_petbuildconfig_get,slId)
end
local list={}
if cfg.attr then
for i,v in ipairs(cfg.attr)do
list[v]={1,v}
end
end







if mode==1 and slData.decorate_id>0 then
local dcfg=cfgHelper.get1(cfg_petdecorateconfig_get,slData.decorate_id)
if dcfg.add_effect then
local effects=dcfg.add_effect[1]
if effects then
for i,v in ipairs(effects)do
list[v]={1,v}
end
end
end
end
local rlist={}
for k,v in pairs(list)do
table.insert(rlist,v)
end
return rlist
end

function feedingSystem:setElementList(scrollView,index,attrs,checklist)
attrs=attrs or{}
local len=#attrs
scrollView:SetChildScrollViewCreateGrids(index,len,len)
local grids=scrollView:GetChildScrollViewItemWidgets(index)
local count=grids.Count
for i=1,count do
local item=grids[i-1]
local data=attrs[i]
local ecfg
local isElement=data[1]==1
if isElement then
ecfg=cfgHelper.get1(cfg_elementtypeconfig_get,data[2])
else
ecfg=cfgHelper.get1(cfg_environmenttypeconfig_get,data[2])
end
UIShouLanModel.refreshSpecialityItemEx(item,ecfg,nil,isElement)
item:SetChildActive(2,checklist and checklist[data[1]][data[2]]==true or false)
end
end

function feedingSystem:showFeedingHUD()
local data=lingShouAIManager:getPickUpTargetLsSceneData()
if not data then
return
end
local lsData=lingshouModel:getLingShouData(data.lsGuidStr)
local attrs=self:getElementDataM(lsData.cfg)
local checklist={{},{}}
for i,v in ipairs(attrs)do
checklist[v[1]][v[2]]=true
end
local nowSelectVolume=lingshouModel.getLingShouPropertyValEx(lsData.guid,lingshouPropertyType.VOLUME)
for k,v in pairs(self.feedBuildingData)do
local bdData=zongmenModel:getBuildingData(v.bdId)
local cfg=cfgHelper.get1(cfg_monijybuildconfig_get,bdData.build_id)
local offset=Vector3.New(0,cfg.height,0)
local hudId=hudControl:addHUD(INSTANCE_TYPE.eFeedingInfo,k,offset,false,true,function(id)
local widget=hudControl:getHUDWidget(id)
local slcfg=cfgHelper.get1(cfg_petbuildconfig_get,bdData.build_id)

local buildVolume=slcfg.volume
local nowUseVolume=UIShouLanModel:getMonsterVolume(bdData.un_build_id)
local previewSelectCount=nowUseVolume+nowSelectVolume
local maxShowCount=buildVolume

widget:SetChildLayoutGroupCreateItems(1,maxShowCount,function(index)
local volumeWidget=widget:GetChildLayoutGroupGridItem(1,index-1)
local isSelect=index<=nowUseVolume
local isPreview=not isSelect and index<=previewSelectCount
local isGreen=isPreview and previewSelectCount<=buildVolume
local isRed=isPreview and previewSelectCount>buildVolume
local isNotSelect=not isSelect and not isPreview and index<=buildVolume
volumeWidget:SetChildActive(0,isNotSelect)
volumeWidget:SetChildActive(1,isSelect)
volumeWidget:SetChildActive(2,isGreen)
volumeWidget:SetChildActive(3,isRed)
end)

widget:SetChildScrollViewInit(0,0.5,true,nil,nil)
local attrData=self:getElementDataSL(bdData.un_build_id,1)
self:setElementList(widget,0,attrData,checklist)

local hasAttr=#attrData>0
widget:SetChildActive(2,not hasAttr)
end)
self.hudIDRecord[hudId]=true
end
end

function feedingSystem:hideFeedingHUD()
for k,v in pairs(self.hudIDRecord)do
hudControl:removeHUD(k)
end
self.hudIDRecord={}
end

function feedingSystem:getMonsterXinQingAddVal(slId,lsId)
local lsData=lingshouModel:getLingShouData(lsId)
local addVal=0
if lsData then
local addValList=lsData.cfg.base_add_love
local sameElementAddType=feedingSystem:checkSameElementAddType(slId,lsId)
addVal=addValList[sameElementAddType]
end

return addVal
end

function feedingSystem:countMonsterAddExp(slId,lsId)
local bdData=zongmenModel:getBuildingData(slId)
local lsData=lingshouModel:getLingShouData(lsId)
local pcfg=cfgHelper.get1(cfg_petbuildconfig_get,bdData.build_id)
local baseVal=pcfg.add_xiuwei
local addRate=0
local slData=UIShouLanModel:getShouLanData(bdData.un_build_id)
local dcfg=cfgHelper.get1(cfg_petdecorateconfig_get,slData.decorate_id)
if dcfg then
local dAddVal=dcfg.add_effect[2]and dcfg.add_effect[2][1]or nil
if dAddVal then
baseVal=baseVal+dAddVal
end
end
local lsZiZhi=lingshouModel.getLingShouPropertyVal(lsData,lingshouPropertyType.ZIZHI)
local zizhiList=cfgHelper.get2(cfg_lingshouzizhiconfig_get,lsZiZhi,'jingjie_xiulian')
local sameElementAddType=feedingSystem:checkSameElementAddType(slId,lsId)
local zizhiAddRate=zizhiList[sameElementAddType]
addRate=addRate+zizhiAddRate/10000

local dzId=bdData.dizi_id
if tostring(dzId)~='0'then
local level=UIDiscipleModel:getDiscipleJobLevel(dzId,7)
local drate=cfgHelper.get2(cfg_petxiulianconfig_get,level,'add_xiulian')
addRate=addRate+drate/100
end

return baseVal,addRate
end





function feedingSystem:checkSameElementAddType(slId,lsId)
local lsData=lingshouModel:getLingShouData(lsId)
local lsLikeElement=lsData.cfg.element
return self:checkSameElementAddTypeEx(slId,lsLikeElement)
end





function feedingSystem:checkSameElementAddTypeEx(slId,lsLikeElement)
local elementSL=self:getElementDataSL(slId,1)
if not elementSL or not next(elementSL)then

return 1
end

for i,v in ipairs(elementSL)do
if v[1]==1 and v[2]==lsLikeElement then

return 3
end
end


return 2
end

function feedingSystem:getSameElementCount(slId,lsId)
local lsData=lingshouModel:getLingShouData(lsId)
local elementM=self:getElementDataM(lsData.cfg)
local elementSL=self:getElementDataSL(slId,1)
local count=0
for i,v in ipairs(elementSL)do
for ii,vv in ipairs(elementM)do
if v[1]==vv[1]and v[2]==vv[2]then
count=count+1
end
end
end
return count
end

function feedingSystem:getWorkPos(bt,pkey,bdId)
local bdData=zongmenModel:getBuildingData(bdId)
local tpos=_MapManager.GetAPosCanPutDownInLayoutBuilding(bdData.entityId,8)
bt:setSharedVar(pkey,tpos)
end

function feedingSystem:setTargetBuildDoorPos(bt,bdId)
local bdData=zongmenModel:getBuildingData(bdId)
if not bdData then
return nil
end
local tpos,dpos=isometricMapSystem:getDoorWayPos(bdData)
local mapId=_MapManager.GetObjectMapID(bdData.entityId)
bt:setSharedVar("doorPos",tpos)
bt:setSharedVar("bdMapId",mapId)
end

function feedingSystem:setTargetBuildInsideDoorPos(bt,bdId)
local bdData=zongmenModel:getBuildingData(bdId)
if not bdData then
return nil
end
local tpos,dpos=isometricMapSystem:getDoorWayPos_ShouLanInside(bdData)
local mapId=_MapManager.GetObjectMapID(bdData.entityId)
bt:setSharedVar("insideDoorPos",tpos)
bt:setSharedVar("bdDoorPos",dpos)
bt:setSharedVar("bdMapId",mapId)
end

function feedingSystem:setDzEntityToWorkPos(stId,bdId)
local bdData=zongmenModel:getBuildingData(bdId)

local tpos,dpos=isometricMapSystem:getDoorWayPos_ShouLanInside(bdData)
_MapManager.SetPosition(stId,tpos)
end

function feedingSystem:setDzWorkLayer(bt,stId)

_MapManager.SetSortingLayer(stId,SortingLayers.ITGrid2)
if isometricMapSystem:isInNormalMode()then
_MapManager.SetTilemapObjectActive(stId,true)
end
end

function feedingSystem:findLingShowInRange(x1,y1,x2,y2)
local pos1=_MapManager.ToVector3Int(x1,y1,0)
local pos2=_MapManager.ToVector3Int(x2,y2,0)
local idArr=_MapManager.GetObjectInRange(pos1,pos2,objectType.eLingShou)
local list={}
for i,v in ipairs(idArr)do
local lsdata=self:getMonsterDataByEID(v)
if not lsdata.home then
table.insert(list,v)
end
end
return list
end

function feedingSystem:handleLingShouAvoid(guid)
local posInfo=_MapManager.GetObjectPosInfo(guid)
local lsArr=self:findLingShowInRange(posInfo[1],posInfo[2],posInfo[1]+posInfo[4]-1,posInfo[2]+posInfo[5]-1)
if#lsArr>0 then
local posList=_MapManager.GetPlaceObjectNearbySpace(guid,3)
if posList.Count>0 then
local cfg=cfgHelper.get1(cfg_avoidaiconfig_get,1)
for i,v in ipairs(lsArr)do
local pos=_MapManager.GetTheNearestPosInList(v,posList)
local initData={
stId=v,
targetPos=pos,
speed=cfg.speed,
anim=cfg.anim,
speak_time_1=cfg.speak_time_1,
speak_skin_1=cfg.speak_skin_1,
speak_1='!!!',
speak_time_2=cfg.speak_time_2,
speak_skin_2=cfg.speak_skin_2,
speak_2='???',
}
local lsdata=self:getMonsterDataByEID(v)
lsdata.bt:broke()
behaviorManager:addBehaviorTree('ai_ls_avoid',{stId=v},true,initData,true)
end
end
end
end

function feedingSystem:endLingShouAvoid(stId)
local lsdata=self:getMonsterDataByEID(stId)
lsdata.bt:reset()
end

function feedingSystem:checkAndRemoveLingShou(slId,lsId,callback)
lsId=tostring(lsId)
local sdata=UIShouLanModel:getMonsterData(slId,lsId)
if#sdata.commItem>0 then
local rewards={}
for i,v in ipairs(sdata.commItem)do
table.insert(rewards,{v.param_1,v.param_2})
end
local args={
title='灵兽迁出',
des1='是否将灵兽迁出兽栏？',
des2='将获得以下兽材',
rewards=rewards,
callback=function(isOK)
if isOK then
UIShouLanControl:reqReveiveReward(slId,1,{int64.new(lsId)})
UIShouLanControl:reqRemoveFormShouLan(slId,1,{int64.new(lsId)})
end
if callback then
callback(isOK)
end
end,
}
UIManager:showWindow('UISLDialoge',args)
else
UIShouLanControl:reqRemoveFormShouLan(slId,1,{int64.new(lsId)})
if callback then
callback(true)
end
end
end


function feedingSystem:checkAndRemoveLingShou_notSL(lsId,callback)
local slId=UIShouLanModel:getShouLanUbdIdByLsGuid(lsId)
if slId then
lsId=tostring(lsId)
local sdata=UIShouLanModel:getMonsterData(slId,lsId)
if#sdata.commItem>0 then
local rewards={}
for i,v in ipairs(sdata.commItem)do
table.insert(rewards,{v.param_1,v.param_2})
end
local args={
title='灵兽迁出',
des1='是否将灵兽迁出兽栏？',
des2='将获得以下兽材',
rewards=rewards,
callback=function(isOK)
if isOK then
UIShouLanControl:reqReveiveReward(slId,1,{int64.new(lsId)})
UIShouLanControl:reqRemoveFormShouLan(slId,1,{int64.new(lsId)})
end
if callback then
callback(isOK)
end
end,
}
UIManager:showWindow('UISLDialoge',args)
else
local showdata=
{
type='UIDialouge',
title='灵兽迁出',
content='是否将灵兽迁出兽栏？',
oktext='确定',
allowclickBG=true,
showclosebtn=true,
okcallback=function(...)
UIShouLanControl:reqRemoveFormShouLan(slId,1,{int64.new(lsId)})
if callback then
callback(true)
end
end,
}
local confirmDialog=UIDialogManager.newDialog(showdata)
confirmDialog:show()
end
else
if callback then
callback(true)
end
end
end

function feedingSystem:checkAndRemoveLingShouList_notSL_NoTips(lsGuidList)
local lookup={}

for index,lsGuid in ipairs(lsGuidList)do
local slId=UIShouLanModel:getShouLanUbdIdByLsGuid(lsGuid)
local lsGuid_Str=tostring(lsGuid)
local sdata=UIShouLanModel:getMonsterData(slId,lsGuid_Str)
if slId then
table.checkCreateSubTable(lookup,{slId,1})
table.insert(lookup[slId][1],lsGuid)

if#sdata.commItem>0 then
table.checkCreateSubTable(lookup,{slId,2})
table.insert(lookup[slId][2],lsGuid)
end
end
end

for slID,stateList in pairs(lookup)do
if stateList[2]then
UIShouLanControl:reqReveiveReward(slID,#stateList[2],stateList[2])
end
if stateList[1]then
UIShouLanControl:reqRemoveFormShouLan(slID,#stateList[1],stateList[1])
end
end
end
