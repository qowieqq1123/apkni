
function isometricMapSystem:enterStoryMode(closeTips,closeWin)
if self.isInStoryMode then
return
end
loggerUtil.log('进入故事模式',closeTips)

self.isInStoryMode=true

if closeWin==nil then closeWin=true end
if closeWin then
baseFullScreenUI:closeAllActiveWindow()
end
UIManager.disableAllTips(closeTips)

if webGLHelper:isRunMiniGame()then

isometricMapSystem:handleUnFreezeAnimation()
end
end

function isometricMapSystem:leaveStoryMode(showMain,openMain)
if showMain==nil then showMain=true end
if not self.isInStoryMode then
return
end
loggerUtil.log('离开故事模式')

self.isInStoryMode=false
if openMain==nil then openMain=true end
if openMain then
baseFullScreenUI:openMain(showMain)
end
UIManager.enableAllTips()

if webGLHelper:isRunMiniGame()then

isometricMapSystem:checkAndFreezeAnimationEx()
end
end

function isometricMapSystem:enterPhotoMode(closeTips)
if self.isInPhotoMode then
return
end
loggerUtil.log('进入拍照模式',closeTips)
self.isInPhotoMode=true
UIManager.disableAllTips(closeTips)
end

function isometricMapSystem:leavePhotoMode()
if not self.isInPhotoMode then
return
end
loggerUtil.log('离开拍照模式')
self.isInPhotoMode=false
UIManager.enableAllTips()
end

function isometricMapSystem:enterBattleMode()
UIManager:closeWindow('UIChallengeWin')
baseFullScreenUI:openMain(false)
end

function isometricMapSystem:leaveBattleMode()
baseFullScreenUI:openMain(true)
end

function isometricMapSystem:enterGroundModel()
if self.groundMode then
return
end



self.groundMode=true

for k,v in pairs(self.repairDatas)do
local mdata=self:getModelByStatus(v.id,1,-1)
self:changeBody(v.guid,mdata.model,mdata.slots,mdata.scale)
_MapManager.SetSortingLayer(v.guid,mdata.layer)
self:isOnHideSpecialMode(v,mdata)
end

self:changeBuildingModelInMap(mapIdType.zhufeng)
self:changeBuildingModelInMap(mapIdType.lingshoudao)
self:changeBuildingModelInMap(mapIdType.xianmeng)

local target=self.previewBuilding
if target and target.level then
if target.bdData then
self:changeModel(target.bdData)
else
local mdata=self:getModelByStatus(target.id,target.level)
self:changeBody(target.guid,mdata.model,mdata.slots,mdata.scale)
_MapManager.SetSortingLayer(target.guid,mdata.layer)
self:showNormalModel(target.guid,target.cfg.etype,mdata.hideNormalModel~=true)
end
end

local scenerys=self:getAllSundriesDataByType(-1,sundriseType.eScenery)
for i,v in ipairs(scenerys)do
local cfg=cfgHelper.get1(cfg_monijyrandomitemconfig_get,v.id)
local mdata=self:getModelByStatus(cfg.rewards_conf.buildid,1)
self:changeBody(v.guid,mdata.model,mdata.slots,mdata.scale)
end

local eventId=emergenciesModel:getCurrentEventId()
eventId=eventId>0 and eventId or emergenciesModel:getOldEventIdByType(emergenciesType.eYiMuCongSheng)
if eventId>0 then
local creepers=emergenciesModel:getAllCreeper()
for k,v in pairs(creepers)do
hudControl:refreshBuildingStatusHUD(k)
end
end

visitControl:enterGroundModel()
end

function isometricMapSystem:changeBuildingModelInMap(mapId)
local buildingDatas=zongmenModel:getAllBuildingData(mapId)
for k,v in pairs(buildingDatas)do
self:changeModel(v)
end
end

function isometricMapSystem:leaveGroundModel()
if not self.groundMode then
return
end

self.groundMode=false




for k,v in pairs(self.repairDatas)do
local mdata=self:getModelByStatus(v.id,1,-1)
self:changeBody(v.guid,mdata.model,mdata.slots,mdata.scale)
_MapManager.SetSortingLayer(v.guid,mdata.layer)
self:isOnHideSpecialMode(v,mdata)
end

self:changeBuildingModelInMap(mapIdType.zhufeng)
self:changeBuildingModelInMap(mapIdType.lingshoudao)
self:changeBuildingModelInMap(mapIdType.xianmeng)

local eventId=emergenciesModel:getCurrentEventId()
eventId=eventId>0 and eventId or emergenciesModel:getOldEventIdByType(emergenciesType.eYiMuCongSheng)
if eventId>0 then
local now=timeHelper.getServerShortTime()
local eventCfg=cfgHelper.get1(cfg_tufaeventtypeconfig_get,eventId)
local creepers=emergenciesModel:getAllCreeper()
for k,v in pairs(creepers)do
local bdData=zongmenModel:getBuildingData(k)
local changeModel=eventCfg.event_conf.twine_model
if changeModel and changeModel[bdData.build_id]and now<v then
self:changeBody(bdData.entityId,changeModel[bdData.build_id],{})
end
hudControl:refreshBuildingStatusHUD(k)
end
end

local target=self.previewBuilding
if target and target.level then
if target.bdData then
self:changeModel(target.bdData)
else
local mdata=self:getModelByStatus(target.id,target.level,0,planStatus.eDefault,target.modelIndex)
self:changeBody(target.guid,mdata.model,mdata.slots,mdata.scale)
_MapManager.SetSortingLayer(target.guid,mdata.layer)
self:showNormalModel(target.guid,target.cfg.etype,mdata.hideNormalModel~=true)
end
end

local scenerys=self:getAllSundriesDataByType(-1,sundriseType.eScenery)
for i,v in ipairs(scenerys)do
local cfg=cfgHelper.get1(cfg_monijyrandomitemconfig_get,v.id)
local model=cfg.model[1]
local slots=cfg.model[2]
local scale=self:getModelScale(model)
self:changeBody(v.guid,model,slots,scale)
end

visitControl:leaveGroundModel()
end

function isometricMapSystem:isInGroundModel()
return self.groundMode and not isometricMapSystem:isBanGroundModel()
end

function isometricMapSystem:isBanGroundModel()
return zongmenModel:getMountainId()==mapIdType.fort
end

function isometricMapSystem:LoadNameModel()
self.nameMode=userActorSetting.get('buildNameModel',true)
end

function isometricMapSystem:leaveNameModel()
if not self.nameMode then return end
self.nameMode=false
userActorSetting.flushVal('buildNameModel',false)
isometricMapSystem:freshAllNameHudVis(false)
end

function isometricMapSystem:enterNameModel()
if self.nameMode then return end
self.nameMode=true
userActorSetting.flushVal('buildNameModel',true)
isometricMapSystem:freshAllNameHudVis(true)
end


function isometricMapSystem:isInNameModel()
return self.nameMode
end

function isometricMapSystem:setSkyObjectShow(bShow,apply)
self.bShowSkyObject=bShow
if apply then
local mapId=zongmenModel:getMountainId()
zongmenModel:setSkyBuildingShow(mapId,bShow)
end
end

function isometricMapSystem:isShowSkyObject()
return self.bShowSkyObject
end

function isometricMapSystem:setSurfaceObjectShow(bShow,apply)
self.bShowSurfaceObject=bShow
if apply then
local mapId=zongmenModel:getMountainId()
zongmenModel:setSurfaceBuildingShow(mapId,bShow)
end
end

function isometricMapSystem:isShowSurfaceObject()
return self.bShowSurfaceObject
end






function isometricMapSystem:enterLayoutModel(args,warning)
if args.model==6 and not UILayoutControl:isOpenSkyLayout()then
if warning then
UIManager.error('尚未开启空中模式')
end
return false
end
UILayoutControl:showLayoutWindow(args)
self:setLayoutMode(args.model)
if not self:isShowSkyObject()then
local mapId=zongmenModel:getMountainId()
zongmenModel:setSkyBuildingShow(mapId,false)
end
return true
end

function isometricMapSystem:enterFeedingLayoutMode(args)
UILayoutControl:showFeedingLayoutWindow(args)
self:setLayoutMode(layoutMode.eFeedLayout)
feedingSystem:showFeedingHUD()
return true
end

function isometricMapSystem:leaveLayoutModel()
self:setLayoutMode(layoutMode.eDefault)
self:setEditorMode(editorMode.eDefault)
feedingSystem:hideFeedingHUD()
if not self:isShowSkyObject()then
local mapId=zongmenModel:getMountainId()
zongmenModel:setSkyBuildingShow(mapId,true)
end
end

function isometricMapSystem:refreshHUDOnLayoutChange(lastMode,currMode)
if lastMode==layoutMode.eLayout and currMode~=layoutMode.eLayout then
hudControl:refreshAllBuilding()
elseif lastMode~=layoutMode.eLayout and currMode==layoutMode.eLayout then
hudControl:refreshAllBuilding()
end
end

function isometricMapSystem:setEditorMode(mode)
self.editorMode=mode
end

function isometricMapSystem:getEditorMode()
return self.editorMode
end

function isometricMapSystem:setLayoutMode(mode)
local lastMode=self.layoutMode
self.layoutMode=mode
self:refreshHUDOnLayoutChange(lastMode,self.layoutMode)
end

function isometricMapSystem:getLayoutMode()
return self.layoutMode
end

function isometricMapSystem:isInLayoutMode()
return self.layoutMode==layoutMode.eLayout
end

function isometricMapSystem:isInNormalMode()
return not self.isInStoryMode
end


function isometricMapSystem:isOnHideSpecialMode(v,mdata)
if self.modelList and v and mdata then
if v.id==82 or v.id==83 or v.id==84 or v.id==85 or v.id==86 then
if mdata.hideSpModel then
local stId=self.modelList[v.guid]
if stId then
local st=_EntityManager:GetEntity(stId)
st:SetVisible(false)
end
else
local stId=self.modelList[v.guid]
if stId then
local st=_EntityManager:GetEntity(stId)
st:SetVisible(true)
end
end
end
end
end