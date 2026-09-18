ims_design_layout={}

ims_design_layout.gongMenId=946

function ims_design_layout.req_3_60(template_id)
socketManager:send_3_60(template_id)
end

function ims_design_layout.recv_3_55(len,lockList)
ims_design_layout:setUnlockList(lockList)
end

function ims_design_layout.recv_3_60(template_id)
zongmenModel.data.unlockTemplateList=zongmenModel.data.unlockTemplateList or{}
zongmenModel.data.unlockTemplateList[template_id]=true

UIManager:callWindowFunc("UILayoutEditWin","refreshTemplateItem",template_id,true)

end

function ims_design_layout.on_system_open(sysid)
if SYSTEM_DEFINE.eTemplate==sysid then
userActorArraySetting.set(ACTOR_SETTING_TYPE.eMyZongMenLayout,'systemReddot',true)
userActorArraySetting.flush(ACTOR_SETTING_TYPE.eMyZongMenLayout)
reddotControl.on_change_catch_type(CATCH_TYPE.eDesignLayoutOpen,true)
ims_design_layout:refreshLayoutReddot()
elseif SYSTEM_DEFINE.eMutipleRoomExtend==sysid then
zongmenModel:getBuildLimitMaxLv(SLG_SYSTEM_TYPE.eDuoRen,true)
end
end

function ims_design_layout:isLayoutReddot()
return userActorArraySetting.get(ACTOR_SETTING_TYPE.eMyZongMenLayout,'systemReddot',false)
end

function ims_design_layout:refreshLayoutReddot()
UIManager:callWindowFunc("UILayoutWin","freshBtnReddot",5)
UIManager:callWindowFunc("UILayoutEditWin","refreshLayoutReddot")
end

function ims_design_layout:getTemplatePosConfig(id)
local config=cfg_monijytemplatePosExportconfig_get(id)
if not config then
return cfg_monijytemplateposconfig_get(id)
else
return config
end
end

function ims_design_layout:getTemplateConfig(sort)
local list={}
local config=cfg_monijytemplateconfig()
if not sort then
return config
end
for i,v in ipairs(config)do
table.insert(list,v)
end

local checkMyLayout=ims_design_layout:checkMyLayout()
if checkMyLayout then
table.insert(list,1,{id=-1,isMyLayout=true,name='上次布局',icon=0})
end

return list
end

function ims_design_layout:setUnlockList(lockList)
zongmenModel.data.unlockTemplateList={}
if lockList then
for i,v in ipairs(lockList)do
zongmenModel.data.unlockTemplateList[v]=true
end
end
end

function ims_design_layout:getUnlockTemplate(template_id)
if zongmenModel.data.unlockTemplateList then
return zongmenModel.data.unlockTemplateList[template_id]
end
end

function ims_design_layout:getAllStorageData()
local datas=zongmenModel:getDesignStorageData()
local idList={}
for uId,v in pairs(datas)do
idList[v.build_id]=idList[v.build_id]or{}
table.insert(idList[v.build_id],{isDesign=true,data=v,uId=uId})
end
local haveDatas=zongmenModel:getAllstorageBuilding()
for k,v in pairs(haveDatas)do
if not zongmenModel:getDesignBuildingData(v.un_build_id)and not datas[v.un_build_id]then
idList[v.build_id]=idList[v.build_id]or{}
table.insert(idList[v.build_id],{data=v,uId=v.un_build_id})
end
end
return idList
end

function ims_design_layout:onEnterTemplateMap(template_id)




local sfId=mapIdType.zhufeng
local mapId=cfgHelper.get(cfg_monijytemplateconfig_get,template_id,"templeId")
local mapConfig=ims_design_layout:getTemplatePosConfig(mapId)
UIManager:showWindow("UIFightPrepareLoading",{startCallback=function()
zongmenModel:setDesignAllBuildingStorage()
timeEventController.delayDo(1,function()
isometricMapSystem:clearDesignRoadData()
ims_design_layout:initRoadDataByConfigId(mapId,true)
isometricMapSystem:drawDesignRoad()

timeEventController.delayDo(1,function()

local idList=ims_design_layout:getAllStorageData()
local usedList={}
local gongMenList={}
for id,posList in pairs(mapConfig.unlock_build_list)do
for _,v in ipairs(posList)do
local isBuilded=false
if idList[id]then
for _,buildData in ipairs(idList[id])do
if isBuilded then
break
end
if not usedList[buildData.uId]then

if ims_design_layout:IsCanPlace(mapIdType.zhufeng_design,id,v[1],v[2],v[3],id==ims_design_layout.gongMenId and conditionConfig.default or conditionConfig.place)then
usedList[buildData.uId]={buildData=buildData,id=id,newPos=v}
isBuilded=true
end
end
end
end
if id==ims_design_layout.gongMenId then
if not isBuilded then
local pos=_MapManager.ToVector3Int(v[1],v[2],0)
local areaId=_MapManager.GetAreaID(sfId,pos)
if zongmenModel:isAreaUnlock(areaId)then
gongMenList[FMT.fmt('{0}_{1}',v[1],v[2])]=v
end
end
end
end
end
ims_design_layout:onBuildStorageBuilding(usedList)

zongmenModel:selectDesignLayoutId(template_id)
zongmenModel:saveSelectDesignLayoutId()



UIManager:invokeUIMethod("UIFightPrepareLoading","endAni")

self:initGongMenData(gongMenList)
end)
end)
end})



end

function ims_design_layout:onBuildStorageBuilding(usedList,afterfunc)
local sfId=mapIdType.zhufeng
if next(usedList)then
local thisId=mapIdType.zhufeng_design
local buildIdx=0
for i,v in pairs(usedList)do
if buildIdx>10 then
break
end
local x=v.newPos[1]
local y=v.newPos[2]
local orientation=v.newPos[3]
local cfg=cfgHelper.get(cfg_monijybuildconfig_get,v.id)


local bdData=table.deepCopy(v.buildData.data)
local bdId=bdData.un_build_id
bdData.x=x
bdData.y=y
bdData.orientation=orientation
local guid=isometricMapSystem:createABuildingToMap(thisId,bdData,nil,true,conditionConfig.designPlace)

zongmenModel:delDesignStorageData(bdId)

zongmenModel:saveDesignBuildingData(nil,bdId,bdData)
zongmenModel:setDesignBuildingMapData(sfId,bdId)
zongmenModel:setDesignEntityId(bdId,guid)
buildIdx=buildIdx+1

usedList[i]=nil
end
end
if next(usedList)then
timeEventController.delayDo(0.02,function()
ims_design_layout:onBuildStorageBuilding(usedList)
end)
else
if afterfunc then
afterfunc()
end
zongmenModel:saveDesignData()
zongmenModel:flushSaveDesignData()
UIManager:callWindowFunc("UILayoutEditWin","refreshSortCount")
end
end

function ims_design_layout:IsCanPlace(mapId,buildId,x,y,orientation,cfgCond)
local cfg=cfgHelper.get(cfg_monijybuildconfig_get,buildId)
local bx=cfg.buid_size[1]
local by=cfg.buid_size[2]
local cx=bx
local cy=by
local flip=orientation==1
if flip then
cx=by
cy=bx
end



return _MapManager.IsCanPlace(mapId,x,y,cx,cy,cfgCond or conditionConfig.place)
end

function ims_design_layout:setAreaLight()
local sfId=mapIdType.zhufeng_design

isometricMapSystem:setAreaCellBrightness(sfId,-1,false)
_MapManager.Erase(sfId,mapLayer.Area1)
end

function ims_design_layout:onEnterPreviewMap(template_id)
if not isometricMapSystem:getDesignMode()then
return
end

UIManager:showWindow("UIFightPrepareLoading",{para=2})
timeEventController.delayDo(0.2,function()
isometricMapSystem:removeDesignSundrise()
isometricMapSystem:clearDesignMap()

ims_design_layout:setAreaLight()
local sfId=mapIdType.zhufeng_design
local mapId=cfgHelper.get(cfg_monijytemplateconfig_get,template_id,"templeId")
local mapConfig=ims_design_layout:getTemplatePosConfig(mapId)
local previewModelList={}
for id,posList in pairs(mapConfig.unlock_build_list)do
for _,v in ipairs(posList)do
local ent=isometricMapSystem:createABuildingToMap(sfId,{build_id=id,level=1,x=v[1],y=v[2],orientation=v[3]})
table.insert(previewModelList,ent)
end
end
self.previewModelList=previewModelList


self.oldDesignRoadData=zongmenModel:getDesignRoadData()
isometricMapSystem:clearDesignRoadData()

local roadDatas={}
local rData={}
if mapConfig.unlock_road then
for id,datas in pairs(mapConfig.unlock_road)do

for ii,vv in ipairs(datas)do
if vv[1]==vv[3]then
local add=vv[2]<vv[4]and 1 or-1
for i=vv[2],vv[4],add do
local x=vv[1]
local y=i
local key=FMT.fmt('{0}_{1}',x,y)
roadDatas[key]={x=x,y=y,style=vv[6]or 1,type=vv[5]or 2}

rData[key]={x=x,y=y,style=vv[5]or 2,type=vv[6]or 1}
end
elseif vv[2]==vv[4]then
local add=vv[1]<vv[3]and 1 or-1
for i=vv[1],vv[3],add do
local x=i
local y=vv[2]
local key=FMT.fmt('{0}_{1}',x,y)
roadDatas[key]={x=x,y=y,style=vv[6]or 1,type=vv[5]or 2}

rData[key]={x=x,y=y,style=vv[5]or 2,type=vv[6]or 1}
end
end
end

end
end
if mapConfig.roadDatas then
for id,datas in pairs(mapConfig.roadDatas)do

for ii,vv in ipairs(datas)do
local x=vv[1]
local y=vv[2]
local key=FMT.fmt('{0}_{1}',x,y)
roadDatas[key]={x=x,y=y,style=vv[3]or 1,type=vv[4]or 2}

rData[key]={x=x,y=y,style=vv[4]or 2,type=vv[3]or 1}
end

end
end

if next(rData)then
isometricMapSystem:drawRoad(sfId,rData)
end
self.previewRoadList=roadDatas
end)

end

function ims_design_layout:calcLoadData(template_id)
local mapId=cfgHelper.get(cfg_monijytemplateconfig_get,template_id,"templeId")
local mapConfig=ims_design_layout:getTemplatePosConfig(mapId)
local roadDatas={}
local zmRoadData
local mdata=zongmenModel:getMountainData(mapId)
if mdata then
zmRoadData=mdata.roadDatas
end
local vmapId=mapIdType.zhufeng
if mapConfig.unlock_road then
for id,datas in pairs(mapConfig.unlock_road)do
if _MapManager.IsAreaUnlock(vmapId,id)then
for ii,vv in ipairs(datas)do
if vv[1]==vv[3]then
local add=vv[2]<vv[4]and 1 or-1
for i=vv[2],vv[4],add do
local x=vv[1]
local y=i
local key=FMT.fmt('{0}_{1}',x,y)
if not zmRoadData[key]then
roadDatas[key]={x=x,y=y,style=vv[6]or 1,type=vv[5]or 2}
end
end
elseif vv[2]==vv[4]then
local add=vv[1]<vv[3]and 1 or-1
for i=vv[1],vv[3],add do
local x=i
local y=vv[2]
local key=FMT.fmt('{0}_{1}',x,y)
if not zmRoadData[key]then
roadDatas[key]={x=x,y=y,style=vv[5]or 1,type=vv[5]or 2}
end
end
end
end
end
end
end
if mapConfig.roadDatas then
for id,datas in pairs(mapConfig.roadDatas)do
if _MapManager.IsAreaUnlock(vmapId,id)then
for ii,vv in ipairs(datas)do
local x=vv[1]
local y=vv[2]
local key=FMT.fmt('{0}_{1}',x,y)
if not zmRoadData[key]then
roadDatas[key]={x=x,y=y,style=vv[3],type=vv[4]or 2}
end
end
end
end
end
return roadDatas
end

function ims_design_layout:onLeavePreviewMap()
if not isometricMapSystem:getDesignMode()then
return
end

UIManager:showWindow("UIFightPrepareLoading",{para=2})

local sfId=mapIdType.zhufeng_design


timeEventController.delayDo(0.2,function()
isometricMapSystem:setAreaCellBrightness(sfId,-1,true)
_MapManager.Erase(sfId,mapLayer.Road1)
_MapManager.Erase(sfId,mapLayer.Data)
if api_Available_SetCellCoverTypeByPosList()then
if self.previewRoadList then
local posArr={}
for i,v in pairs(self.previewRoadList)do
table.insert(posArr,v.x)
table.insert(posArr,v.y)
table.insert(posArr,0)
end
_MapManager.SetCellCoverTypeByPosList(sfId,posArr,0)
end
end
if self.oldDesignRoadData then
zongmenModel:initDesignRoadData(self.oldDesignRoadData)
self.oldDesignRoadData=nil
end
if self.previewModelList then
for i,v in ipairs(self.previewModelList)do
_MapManager.PickUpFromMap(v)
_MapManager.RemoveTilemapObject(v)
hudControl:clearHUDByEntityID(v)
end
end
end)
timeEventController.delayDo(1,function()
isometricMapSystem:loadAndSetDesignMountain()
isometricMapSystem:handleDesignCreateSundrise()

end)


end

function ims_design_layout:initRoadDataByConfigId(mapId,save)
local roadDatas={}
local sfId=mapIdType.zhufeng
local mapConfig=ims_design_layout:getTemplatePosConfig(mapId)
for id,datas in pairs(mapConfig.roadDatas or{})do
if _MapManager.IsAreaUnlock(sfId,id)then
for ii,vv in ipairs(datas)do
if zongmenModel:isActiveRoad(vv[3])then
local x=vv[1]
local y=vv[2]
local key=FMT.fmt('{0}_{1}',x,y)
roadDatas[key]={x,y,vv[3],vv[4]or 2}
end
end
end
end
zongmenModel:initDesignRoadData(roadDatas)

if save then
zongmenModel:saveDesignData()
zongmenModel:flushSaveDesignData()
end
end


function ims_design_layout:saveMyMapData(designBuildData,designStorageData,designRoadData)

local designData={}
for ubdId,v in pairs(designBuildData)do
table.insert(designData,{ubdId,v.x,v.y,v.orientation})
end
local storageData={}
for ubdId,v in pairs(designStorageData)do
table.insert(storageData,ubdId)
end
local roadData={}
if designRoadData then
for k,v in pairs(designRoadData)do
table.insert(roadData,v)
end

else
roadData=nil
end

self.myMapData={designData=designBuildData,storageData=designStorageData,roadData=designRoadData}

userActorArraySetting.set(ACTOR_SETTING_TYPE.eMyZongMenLayout,'designData',designData)
userActorArraySetting.set(ACTOR_SETTING_TYPE.eMyZongMenLayout,'storageData',storageData)
userActorArraySetting.set(ACTOR_SETTING_TYPE.eMyZongMenLayout,'roadData',roadData)

userActorArraySetting.flush(ACTOR_SETTING_TYPE.eMyZongMenLayout)
end

function ims_design_layout:initMyMapData()
local sfId=mapIdType.zhufeng
self.myMapData={}
local saveDesignData=userActorArraySetting.get(ACTOR_SETTING_TYPE.eMyZongMenLayout,'designData',{})
local saveStorageData=userActorArraySetting.get(ACTOR_SETTING_TYPE.eMyZongMenLayout,'storageData',{})
local saveRoadData=userActorArraySetting.get(ACTOR_SETTING_TYPE.eMyZongMenLayout,'roadData',nil)

local storageData={}
for i,v in ipairs(saveStorageData)do
local ubdId=v
local data=zongmenModel:getBuildingData(ubdId)
if data and data.flag==0 then
storageData[ubdId]=data
end
end

local designData={}
for i,v in ipairs(saveDesignData)do
local ubdId=v[1]
local sdata

sdata=zongmenModel:getStorageBuilding(ubdId)
if sdata then
designData[ubdId]={x=v[2],y=v[3],orientation=v[4]}
else
local data=zongmenModel:getBuildingData(ubdId)
if data then
designData[ubdId]={x=v[2],y=v[3],orientation=v[4]}
end
end
end


local roadData={}
if saveRoadData then
for i,v in ipairs(saveRoadData)do
local key=FMT.fmt('{0}_{1}',v[1],v[2])
roadData[key]=v
end
else
local roadDatas=zongmenModel:getMountainRoadDatas(sfId)
if roadDatas then
for k,v in pairs(roadDatas)do
roadData[k]={v.x,v.y,v.type,v.style}
end
end
end

if next(designData)or next(storageData)or next(roadData)then
self.myMapData={designData=designData,storageData=storageData,roadData=roadData}
end
end

function ims_design_layout:loadMyMapData()
ims_design_layout:initMyMapData()

if next(self.myMapData)then


UIManager:showWindow("UIFightPrepareLoading",{startCallback=function()
zongmenModel:setDesignAllBuildingStorage()
timeEventController.delayDo(1.2,function()
zongmenModel.data.designData=self.myMapData.designData
zongmenModel.data.designStorageData=self.myMapData.storageData

isometricMapSystem:clearDesignRoadData()
isometricMapSystem:createDesignBuilding()

zongmenModel:initDesignRoadData(self.myMapData.roadData)
isometricMapSystem:drawDesignRoad()

UIManager:invokeUIMethod("UIFightPrepareLoading","endAni")
UIManager:invokeUIMethod("UILayoutEditWin","refreshSortCount")
end)
end})

end
end

function ims_design_layout:checkMyLayout()
ims_design_layout:initMyMapData()
return next(self.myMapData)~=nil
end

function ims_design_layout:initGongMenData(gongMenData)
self.GongMenData=gongMenData
end

function ims_design_layout:getGongMenData()
return self.GongMenData or{}
end

function ims_design_layout:getConditionsUnlock(condition,isTips)
if not condition then
return true
end
local level=zongmenModel:getLevel()
if condition[1]==1 then
if level<condition[2]and isTips then
UIManager.error(FMT.fmt("宗门等级达到{0}解锁应用布局",condition[2]))
end
return level>=condition[2],FMT.fmt("宗门等级达到{0}",condition[2])
end
return false
end


function ims_design_layout:clearDesignMap()


isometricMapSystem:clearStatus(true)

zongmenModel.data.designData={}
zongmenModel.data.designStorageData={}

self.exportKey=0








local isCanShowNewArea=isometricMapSystem:isCanShowNewArea()
local cfg=cfg_monijyareaconfig()
for i,v in ipairs(cfg)do
local isNewArea=isometricMapSystem:isNewMapArea(v.areaId)
if v.sf_id==mapIdType.zhufeng and(not isNewArea or isCanShowNewArea)then
isometricMapSystem:unlockArea(mapIdType.zhufeng_design,v.id)
end
end

isometricMapSystem:setNewAreaShow(mapIdType.zhufeng_design)
isometricMapSystem:removeDesignSundrise()
isometricMapSystem:clearDesignMap()
end

function ims_design_layout:geyExportKey()
self.exportKey=(self.exportKey or 0)+1
return self.exportKey
end


function ims_design_layout:onTestEnterTemplateMap(mapId,afterfunc)




UIManager:showWindow("UIFightPrepareLoading",{para=2})
local mapConfig=ims_design_layout:getTemplatePosConfig(mapId)
timeEventController.delayDo(0.2,function()
zongmenModel:setDesignAllBuildingStorage()
end)
timeEventController.delayDo(1.2,function()
local idList=ims_design_layout:getAllStorageData()
local usedList={}
for id,posList in pairs(mapConfig.unlock_build_list)do
for _,v in ipairs(posList)do
local isBuilded=false
if idList[id]then
for _,buildData in ipairs(idList[id])do
if isBuilded then
break
end
if not usedList[buildData.uId]then

if ims_design_layout:IsCanPlace(mapIdType.zhufeng_design,id,v[1],v[2],v[3])then
usedList[buildData.uId]={buildData=buildData,id=id,newPos=v}
isBuilded=true
end
end
end
end



end
end
ims_design_layout:onBuildStorageBuilding(usedList,afterfunc)
end)


end

