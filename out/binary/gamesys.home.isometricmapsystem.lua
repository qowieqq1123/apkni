isometricMapSystem=gameState.addListener({})

_MapManager=CS.MapManagerInterface
_InstantiateManager=CS.InstantiateManager
_stopEffect=CS.GameInterface.StopEffect
_sleepEffect=CS.GameInterface.SleepEffect

_EntityManager=CS.EntityManager.Instance

_DOTweenProxy=Lua.DOTweenProxyExtensions
_LoopType=DG.Tweening.LoopType
_Ease=DG.Tweening.Ease
_pathType=DG.Tweening.PathType

_Screen=UnityEngine.Screen














































mapLayer={}

tilemapRenderMode={
eChunk=0,
eIndividual=1,
}

conditionConfig={
skyPlace=-2,
default=0,
drawRoad=1,
drawGrid=2,
place=3,
drawWall=4,
lockArea=7,
showPlace=9,
drawSurface=20,
designPlace=23,
}

findPathConfig={
default=0,
drawRoad=1,
drawWall=2,
}

cellDirection={
Forward=0,
Back=1,
Left=2,
Right=3,
LeftForward=4,
LeftBack=5,
RightForward=6,
RightBack=7,
}

directionType={
Four=0,
Eight=1,
}

editorMode={
eDefault=1,
ePlace=2,
eCreateRoad=3,
eDeleteRoad=4,
eDesign=5,
}

layoutMode={
eDefault=0,
eBuild=1,
eLayout=2,
eFeedLayout=3,
eDesign=4,
eSkyBuild=5,
eSkyLayout=6,
}

objectType={
eDefault=0,
ePlaceObject=1,
eRole=2,
eStillSundrise=3,
eMovementSundrise=4,
eMonster=5,
eLingShou=6,
eXianChong=7,
eFangKe=8,
eCatShop=9,
eStillPlaceObject=10,
eVisitRole=11,
eZMVisitor=12,
eCatWorker=13,
eYunYouMerchant=14,
eTanXianDuiShip=15,
eSkyPlaceObject=16,
eXingJiaoMerchant=17,
eChallengeVisitor=18,
eYiShiLaiKe=19,
eZongMenSpy=20,
eDuJieXianDanMon=21,
eTianMoJieMonster=22,
eTianMoJieMonster_Effect=23,
eVassalPlotNpc=24,
eCaiShenJiaDao=25,
eXingJiaoShangRen=26,
}

objectConfigType={
eBuilding=0,
eSundrise=1,
}

sundriseType={
eStillSundrise=1,
eMovementSundrise=2,
eStillEnemy=3,
eMovementEnemy=4,
eScenery=5,
eRewardBox=6,
eBrand=7,
eMiJing=8,
}

sundrisePosType={
eServer=1,
eConfig=2,
eRandom=3,
eSpe=4,
}

planStatus={
eDefault=0,
eStart=1,
eComplete=2,
}

homeEvent={
eEnterHome=1,
eLeaveHome=2,
}

zmMsgType={
unlinkRoad=1,
mijing=2,
chuiwei=3,
homeless=4,
xianZhanRepair=5,
areaUnlock=6,
shanmenVisit=7,
xianZhanKeShang=8,
zmRelationPlot=9,
areaUnlockWaitEnd=10,

}


cantClickAtNotRepairBuildType={
[SLG_SYSTEM_TYPE.eWanBaoShangHui]=true,
[SLG_SYSTEM_TYPE.eTanXianDui]=true,
[SLG_SYSTEM_TYPE.eBoat1]=true,
[SLG_SYSTEM_TYPE.eBoat2]=true,
[SLG_SYSTEM_TYPE.eBoat3]=true,
[SLG_SYSTEM_TYPE.eBoat4]=true,







}

cantClickAtNotOpenSystem={
[SLG_SYSTEM_TYPE.eYiFangLingTian]=SYSTEM_DEFINE.eYiFangLingTian,
[SLG_SYSTEM_TYPE.eLittleWorld]=SYSTEM_DEFINE.eSmallWorld,
[SLG_SYSTEM_TYPE.eFeiShengTai2]=SYSTEM_DEFINE.eFeiShengTaiSys,
[SLG_SYSTEM_TYPE.eDuJieZhiBaoShui]=SYSTEM_DEFINE.eFeiShengTaiSys,
[SLG_SYSTEM_TYPE.eDuJieZhiBaoMu]=SYSTEM_DEFINE.eFeiShengTaiSys,
[SLG_SYSTEM_TYPE.eDuJieZhiBaoHuo]=SYSTEM_DEFINE.eFeiShengTaiSys,
[SLG_SYSTEM_TYPE.eDuJieZhiBaoTu]=SYSTEM_DEFINE.eFeiShengTaiSys,
[SLG_SYSTEM_TYPE.eDuJieZhiBaoJin]=SYSTEM_DEFINE.eFeiShengTaiSys,
}

objectTypeFastName={
[objectType.eCatShop]="猫货郎",
[objectType.eYunYouMerchant]="云游商人",
[objectType.eXingJiaoMerchant]="行脚商人",
[objectType.eChallengeVisitor]="访客试炼",
[objectType.eYiShiLaiKe]="异世来客",
[objectType.eZongMenSpy]="宗门奸细",
[objectType.eDuJieXianDanMon]="仙丹丹灵",
[objectType.eCaiShenJiaDao]="财神驾到",
[objectType.eXingJiaoShangRen]="行脚商人",
}


notCheckOverlapObjectType={
[objectType.eZMVisitor]=true,
[objectType.eVassalPlotNpc]=true,
[objectType.eLingShou]=true,
}


ignoreClickObjectType={
[objectType.eVisitRole]=true,
[objectType.eCatWorker]=true,
[objectType.eTanXianDuiShip]=true,
[objectType.eSkyPlaceObject]=true,
[objectType.eTianMoJieMonster_Effect]=true,
}


hideOverlapBuildWinType={
[sysWinType.eJingGuang]=true,
}


notCheckOverlapSundriseType={
[sundriseType.eRewardBox]=true,
[sundriseType.eScenery]=true,
[sundriseType.eBrand]=true,
[sundriseType.eStillSundrise]=true,
}

ignoreCheckOverlapLayoutModeList={
[layoutMode.eSkyBuild]=true,
[layoutMode.eLayout]=true,
[layoutMode.eSkyLayout]=true,
[layoutMode.eDesign]=true,
}










local _dragTarget
local _placeTarget
local _longTapTarget

local _top=0.3
local _bottom=0.1
local _left=0.1
local _right=0.1


local _default_orthographic_size=4
local _max_orthographic_size=6
local _min_orthographic_size=2

local _tweener
local _isDrag



local _on_swipe
local _on_pinch
local _on_long_touch
local _swip_begin_pos
local _camera_begin_pos




















_defult_mode_scale=0.39*2

local _touch_scale
local _default_dpi=96



function isometricMapSystem:markEnterSceneAnim(data)
isometricMapSystem.enterSeceneAimParams=data
end

function isometricMapSystem.onCloudOpen()
local animParams=isometricMapSystem.enterSeceneAimParams
if animParams~=nil then
if mainControl:isSceneType(animParams[1])and animParams[2]==zongmenModel:getMountainId()then
isometricMapSystem:playLoadedEffect()
end
end
end

function isometricMapSystem.onCloudOpenDely()
isometricMapSystem:handleReportScene()
local animParams=isometricMapSystem.enterSeceneAimParams
if animParams~=nil then
if mainControl:isSceneType(animParams[1])and animParams[2]==zongmenModel:getMountainId()then
isometricMapSystem:playLoadedEffectDelay()
end
isometricMapSystem:markEnterSceneAnim(nil)
end
end

function isometricMapSystem:handleReportScene()
if not(webGLHelper:isRunDouYin()or webGLHelper:isRunDouYinNative())then
return
end

if not webGLHelper.needReportScene then
return
end

local scene=mainControl:getSceneType()
if scene==eSceneType.eZongmen then
webGLHelper.needReportScene=nil
platformSDK.printSDK('开始上报场景(7001)')
platformSDK:reqReportScene(7001,math.floor(Time.time),function(success,result)
platformSDK.printSDK('场景上报结果(7001)',success,result)
end)
end
end

function isometricMapSystem:onAppStart()
notifySystem:listenNotify(notifyConfig.startEndCloud,self.onCloudOpen)
notifySystem:listenNotify(notifyConfig.endCloud,self.onCloudOpenDely)

self:initCellCheck()

local sceneData={
enter=function(o,...)



isometricMapSystem:onEnterHome(...)
local check=storyAIManager:firstSetZongMenCameraPos()
if not check then
baseFullScreenUI:openWindowOnEnterScene()
end
end,

leave=function(...)
isometricMapSystem:onLeaveHome()
end,
load=function(...)
self:loadScene(...)
end,
}
mainControl:regSceneTypo(eSceneType.eZongmen,sceneData)

local cfgs=cfg_maplogiclayerconfig()
for k,v in pairs(cfgs)do
mapLayer[v.name]=k
end

self.spModelBD={}
self.spModelBdData={}
self.buildActiveCfg={}
local buildActiveCfg=self.buildActiveCfg
local bdcfgs=cfg_monijybuildconfig()
for k,v in pairs(bdcfgs)do
if v.sp_level_up then
self.spModelBD[k]=true
end
if v.activate_cost then
local itemid=v.activate_cost
if buildActiveCfg[itemid]==nil then buildActiveCfg[itemid]={}end
local tcfg=buildActiveCfg[itemid]
tcfg[#tcfg+1]=v.id
end
end

self.roadActiveCfg={}
local roadActiveCfg=self.roadActiveCfg
local bdcfgs=cfg_roadstyleconfig()
for k,v in pairs(bdcfgs)do
if v.allow_place and v.activate_cost then
local itemid=v.activate_cost
if roadActiveCfg[itemid]==nil then roadActiveCfg[itemid]={}end
local tcfg=roadActiveCfg[itemid]
tcfg[#tcfg+1]=v.id
end
end

isometricMapSystem:enableFindPathLimit(true)






self:initAppendObjectData()
self:initRoadData()
self:initFastBuildData()
self:resetSundriesList()

self.freezeAnimationCheckTypes={2,3,4,5,6,7,8,9,10,11,12,13,14,15,17,18,19}
self.freezeAnimationCheckTypesDict={}
for i,v in ipairs(self.freezeAnimationCheckTypes)do
self.freezeAnimationCheckTypesDict[v]=true
end

self.behavior_data={}
end

function isometricMapSystem:setFreezeAnimationCheckValue()
self.check_orthographic_size_v1=_default_orthographic_size+0.2
self.check_orthographic_size_v2=_default_orthographic_size+0.3
end

function isometricMapSystem:checkAndFreezeAnimationEx()
local size=_MapManager.GetCameraOrthographicSize()
self:checkAndFreezeAnimation(size)
end

function isometricMapSystem:handleUnFreezeAnimation()
if not api_Available_SetFreezeAnimationByTypeArray()then
return
end
_MapManager.SetFreezeAnimationByTypeArray(self.freezeAnimationCheckTypes,false)
self.freezeAnimationFlag=false
end

function isometricMapSystem:checkAndFreezeAnimation(size)
if not api_Available_SetFreezeAnimationByTypeArray()then
return
end
if self.isInStoryMode then
return
end
if size<self.check_orthographic_size_v1 then
if self.freezeAnimationFlag then
_MapManager.SetFreezeAnimationByTypeArray(self.freezeAnimationCheckTypes,false)
self.freezeAnimationFlag=false
end
elseif size>self.check_orthographic_size_v2 then
if not self.freezeAnimationFlag then
_MapManager.SetFreezeAnimationByTypeArray(self.freezeAnimationCheckTypes,true)
self.freezeAnimationFlag=true
end
end
end

function isometricMapSystem:enableFindPathLimit(enable)
if api_Available_SetFindPathLimit()then
if enable then
local keyName
if webGLHelper:isRunMiniGame()then
keyName='find_path_limit_webgl'
else
keyName='find_path_limit'
end
local fplimit=cfgHelper.get2(cfg_discipleaiconfig_get,1,keyName)
if fplimit then
_MapManager.SetFindPathLimit(fplimit)
end
else
_MapManager.SetFindPathLimit(0)
end
end
end

function isometricMapSystem:getModelScale(modelId,useInUI)
local cfg=cfgHelper.get1(cfg_dbbodyconfig_get,modelId)
if not cfg then
logErr(FMT.fmt('无法读取龙骨缩放配置 id:{0}',modelId))
return 1
end
return cfg.scales and(useInUI and cfg.scales[1]or cfg.scales[2])or _defult_mode_scale
end





function isometricMapSystem:getModelScales2Pram(modelId,useType)
local cfg=cfgHelper.get1(cfg_dbbodyconfig_get,modelId)
if not cfg then
logErr(FMT.fmt('无法读取龙骨缩放配置 id:{0}',modelId))
return 1
end

local pram={1,0,0}
if cfg.scales2 and cfg.scales2[useType]then
pram=cfg.scales2[useType]
end

return pram
end

function isometricMapSystem:onEnterHome(mapId)
if self.isInit then
return
end
mapId=mapId or mapIdType.zhufeng
mainViewsControl.onChangeSceneMap(eSceneType.eZongmen,mapId)
isometricMapSystem:markEnterSceneAnim({eSceneType.eZongmen,mapId})
self.isInit=true
self.isAreaInit=false
self.repairDatas={}
self.effectRecord={}
self.modelList={}
UIManager:showWindow('UIBuildingMsgWin')
hudControl:showHUDWin()

self:initMap(function()
self.isInHome=true
isometricMapSystem.adjustCameraSize(16,9,UnityEngine.Screen.width,UnityEngine.Screen.height)
mountainControl:onEnterHome()
aiManager:onEnterHome()
discipleStateManager:onEnterHome()
buildingCDControl:onEnterHome()

self:listenNotify()
buildingEffectControl:onEnterHome()
zongmenEffectControl:onEnterHome()
sundriseCreateControl:onEnterHome()
UILayoutControl:onEnterHome()


notifySystem:postNotify(notifyConfig.home_event,homeEvent.eEnterHome)

webGLHelper:onEnterHome()

hudControl:onEnterHome()

self:setLayoutMode(layoutMode.eDefault)
self:setEditorMode(editorMode.eDefault)


isometricMapSystem:leaveStoryMode()

local mapLoaded=function()
if autoLoginHelper:isAutoLogin()or webGLHelper:isSkipLogin()then
if not webGLHelper.DouYinpStraightlay then
if autoLoginHelper:isInAllowAutoShowGGCount()then
msgWinControl:addMsgWin(msgWinType.eGongGao)
autoLoginHelper:addAutoShowGGCount()
end
end
end
if webGLHelper:isRunWebGL()then

loadControl.triggerTimeOut()
end
end

if mapId~=mapIdType.zhufeng then
mountainControl:loadAndswitchMap(mapId,function()
mapLoaded()
end)
else
mapLoaded()
end
end)
end

function isometricMapSystem:onLeaveHome()
if not self.isInit then
return
end
self.isInit=false
baseFullScreenUI:openMain(false)
UIManager:closeWindow('UIBuildingMsgWin')
hudControl:closeHUDWin()
hudControl:onLeaveHome()
zongmenControl:stopPlanFinishTimer(true)
buildingCDControl:onLeaveHome()
fullScreenUI.destroyAllWindow()
discipleStateManager:onLeaveHome()
aiManager:onLeaveHome()
mountainControl:onLeaveHome()
sundriseCreateControl:onLeaveHome()
webGLHelper:onLeaveHome()
self:initSundriesData()
self:removeNotify()
self:clearTweener()
self:clear3DModel()

notifySystem:postNotify(notifyConfig.home_event,homeEvent.eLeaveHome)
buildingEffectControl:onLeaveHome()
zongmenEffectControl:onLeaveHome()
zongmenSkinControl:onLeaveHome()
mountainControl:clearAllMap()
self.isInHome=false
self:resetSundriesList()
self.repairDatas={}
self.effectRecord={}
self.modelList={}
self.isAreaInit=false
isometricMapSystem:markEnterSceneAnim(nil)

self.freezeAnimationFlag=false
end

function isometricMapSystem:onProtocolReq()
webGLHelper:onProtocolReq()
end


function isometricMapSystem:IsInHome()
return self.isInHome
end

function isometricMapSystem:clear3DModel()
for k,v in pairs(self.modelList)do
_EntityManager:RemoveEntity(v)
end
end

function isometricMapSystem:clear3DModelByEID(buildEID)
local hasSPModel=isometricMapSystem:hasSpecialModel(buildEID)
if hasSPModel then
local spModelEID=isometricMapSystem:getSpecialModel(buildEID)
_EntityManager:RemoveEntity(spModelEID)
self.modelList[buildEID]=nil
end
end

function isometricMapSystem:loadScene()
sceneControl:startLoading({sceneId=SCENE_TYPE.home})
end

function isometricMapSystem:clearTweener()




end

function isometricMapSystem:listenNotify()
notifySystem:listenNotify(notifyConfig.swipeStart,self.on_swipe_start)

notifySystem:listenNotify(notifyConfig.swipe,self.on_swipe)

notifySystem:listenNotify(notifyConfig.swipeEnd,self.on_swipe_end)

notifySystem:listenNotify(notifyConfig.pinch,self.on_pinch)

notifySystem:listenNotify(notifyConfig.touchStart,self.on_touch_start)
notifySystem:listenNotify(notifyConfig.touchDown,self.on_touch_down)
notifySystem:listenNotify(notifyConfig.touchUp,self.on_touch_up_notify)
notifySystem:listenNotify(notifyConfig.touchUpList,self.on_touch_up_list)
notifySystem:listenNotify(notifyConfig.longTapStart,self.on_long_tap_start)
notifySystem:listenNotify(notifyConfig.longTapEnd,self.on_long_tap_end)
notifySystem:listenNotify(notifyConfig.screenSulotionChange,self.onScreenSulotionChange)
end

function isometricMapSystem:removeNotify()
notifySystem:removelistener(notifyConfig.swipeStart,self.on_swipe_start)

notifySystem:removelistener(notifyConfig.swipe,self.on_swipe)

notifySystem:removelistener(notifyConfig.swipeEnd,self.on_swipe_end)

notifySystem:removelistener(notifyConfig.pinch,self.on_pinch)

notifySystem:removelistener(notifyConfig.touchStart,self.on_touch_start)
notifySystem:removelistener(notifyConfig.touchDown,self.on_touch_down)
notifySystem:removelistener(notifyConfig.touchUp,self.on_touch_up_notify)
notifySystem:removelistener(notifyConfig.touchUpList,self.on_touch_up_list)
notifySystem:removelistener(notifyConfig.longTapStart,self.on_long_tap_start)
notifySystem:removelistener(notifyConfig.longTapEnd,self.on_long_tap_end)
notifySystem:removelistener(notifyConfig.screenSulotionChange,self.onScreenSulotionChange)
end

function isometricMapSystem:playLoadedEffect()
if mainControl:isSceneLoaded(eSceneType.eZongmen)then
local mapId=zongmenModel:getMountainId()

local check=storyAIManager:firstSetZongMenCameraPos()
if check and mapId==mapIdType.zhufeng then



local btName=cfgHelper.get3(cfg_noviciateconfig_get,"churuzongmenBtTree","value",1)
storyAIManager:startStoryBehavior(btName)
elseif mapId==mapIdType.zhufeng then
self:setCameraOrthoSize(_max_orthographic_size,0)
elseif mapId==mapIdType.lingshoudao then
self:setCameraOrthoSize(_max_orthographic_size,0)
elseif mapId==mapIdType.xianzhan then
local firstIn=xianzhanModel:isFirstIn()
if not firstIn then
self:setCameraOrthoSize(_max_orthographic_size,0)
end
elseif mapId==mapIdType.xianmeng then
self:setCameraOrthoSize(_max_orthographic_size,0)
end
end
end
function isometricMapSystem:playLoadedEffectDelay()
if mainControl:isSceneLoaded(eSceneType.eZongmen)then
local callback=function()
notifySystem:postNotify(notifyConfig.onEnterHomeFinish)
end
local mapId=zongmenModel:getMountainId()
if mapId==mapIdType.zhufeng then
self:setCameraOrthoSize(_default_orthographic_size,0.5,callback)
elseif mapId==mapIdType.lingshoudao then
self:setCameraOrthoSize(_default_orthographic_size,0.5,callback)
elseif mapId==mapIdType.xianzhan then
local firstIn=xianzhanModel:isFirstIn()
local hasyb=xianzhanModel:hasYingBinRoom()
if firstIn then
storyAIManager:startStoryBehavior('story_10_XianZhan_2')
callback()
elseif hasyb then
xianzhanController:moveCameraToYB(callback)
else
self:setCameraOrthoSize(_default_orthographic_size,0.7,callback)
end
elseif mapId==mapIdType.xianmeng then
self:setCameraOrthoSize(_default_orthographic_size,0.5,callback)
else
callback()
end
end
end

function isometricMapSystem:changeCameraOrthoSize(defVal,minVal,maxVal)
_default_orthographic_size=defVal
_min_orthographic_size=minVal
_max_orthographic_size=maxVal
self:setCameraOrthoSize(defVal,0)
if webGLHelper:isRunMiniGame()then
self:setFreezeAnimationCheckValue()
end
end

function isometricMapSystem:setchangeCameraOrthoSize_min(val)
_min_orthographic_size=val
end
function isometricMapSystem:getchangeCameraOrthoSize_min()
return _min_orthographic_size
end
function isometricMapSystem:setchangeCameraOrthoSize_max(val)
_max_orthographic_size=val
end
function isometricMapSystem:getchangeCameraOrthoSize_max()
return _max_orthographic_size
end


function isometricMapSystem:onEnterState(isReconnect)
if isReconnect then
return
end

self.editorMode=editorMode.eDefault
self.layoutMode=layoutMode.eDefault
_dragTarget=-1
local dpi=_Screen.dpi
_touch_scale=dpi>0 and _default_dpi/dpi or 1
self:resetUnlinkData()
self:initSundriesData()

self:loadAllTile()

self.tweeners={}
self.repairDatas={}


self.swipe_count=0
self.buildActiveLookup=table.deepCopy(self.buildActiveCfg)
self.roadActiveLookup=table.deepCopy(self.roadActiveCfg)
isometricMapSystem:LoadNameModel()
isometricMapSystem:setSkyObjectShow(true)
isometricMapSystem:setSurfaceObjectShow(true)

webGLHelper:onEnterState(isReconnect)
end


function isometricMapSystem:onLeaveState(isReconnect)
if isReconnect then
return
end
self:clearSundriesData()
self.previewBuilding=nil
self.groundMode=false
self.unlinkBuildings=nil
self.unlinkBuildingsArr=nil
self.tweeners=nil

webGLHelper:onLeaveState(isReconnect)
end

function isometricMapSystem:onReConnection(isReconnect)
if not isReconnect then
return
end

if not self:IsInHome()then
return
end

for k,v in pairs(mapIdType)do
local buildingDatas=zongmenModel:getAllBuildingData(v)
for kk,vv in pairs(buildingDatas)do
if vv.entityId then
self:changeModel(vv)
end
end
end

self:reCreateSundries(mapIdType.zhufeng)
self:reCreateSundries(mapIdType.lingshoudao)
self:reCreateAllRandomObject()
hudControl:refreshAllBuilding()

local dzDatas=UIDiscipleModel:getAllDiscipleData()
for k,v in pairs(dzDatas)do
discipleStateManager:refreshDiscipleModel(k)
end
if isometricMapSystem:isCanActiveNewArea()then
isometricMapSystem:activeNewArea()
end
end

function isometricMapSystem:reCreateSundries(mapId)
if not mountainControl:isLoaded(mapId)then
return
end




self:handleCreateSundrise(mapId)
end


function isometricMapSystem:getLayoutMode()
return self.layoutMode
end

function isometricMapSystem:initMap(callback)
_MapManager.SetDragCameraBorder(_left,_top,_right,_bottom)
_MapManager.SetObjectScreenBorder(_left,_top-0.05,_right,_bottom-0.05)
_MapManager.SetDefaultAStarConfig(findPathConfig.default)
_MapManager.SetObjectConfigType(objectType.ePlaceObject,objectConfigType.eBuilding)
_MapManager.SetObjectConfigType(objectType.eSkyPlaceObject,objectConfigType.eBuilding)
_MapManager.SetObjectConfigType(objectType.eStillSundrise,objectConfigType.eSundrise)
_MapManager.SetObjectConfigType(objectType.eStillPlaceObject,objectConfigType.eSundrise)

_MapManager.SetRoadStyleLayer(1,mapLayer.Road1)
_MapManager.SetRoadStyleLayer(2,mapLayer.Data)

mountainControl:loadAndswitchMap(mapIdType.zhufeng,callback)

_MapManager.AddCamera()
end











function isometricMapSystem:getCameraBorder(sfId)
local cfg=cfgHelper.get1(cfg_monijysfconfig_get,sfId)
local border=cfg.border
local check=self:isCanShowNewArea(sfId)
if check then
local data={border[1]-25,border[2],border[3],border[4]-2.5}
return data
end
return border
end

function isometricMapSystem:setCameraBorder()
local sfId=zongmenModel:getMountainId()
local size=_MapManager.GetCameraOrthographicSize()
local offset=_default_orthographic_size-size
local border=self:getCameraBorder(sfId)
self.cameraBorder={border[1]-offset,border[2]+offset,border[3]+offset,border[4]-offset}
_MapManager.SetMoveCameraBorder(self.cameraBorder[1],self.cameraBorder[2],self.cameraBorder[3],self.cameraBorder[4])
end

function isometricMapSystem:clampCameraPos(pos)
pos.x=mathHelper.clamp(pos.x,self.cameraBorder[1],self.cameraBorder[3])
pos.y=mathHelper.clamp(pos.y,self.cameraBorder[4],self.cameraBorder[2])
return pos
end

function isometricMapSystem:loadTile(id)
local cfg=cfgHelper.get1(cfg_tileconfig_get,id)
_MapManager.LoadTile(cfg.abName,cfg.assetName,id)
end

function isometricMapSystem:countOffset(bx,by)
return Vector3((bx-by)*0.25,(bx+by)*0.125-0.25,0)
end

function isometricMapSystem:setLockPlaceObject(guid,bLock)
_MapManager.SetLockPlaceObject(guid,bLock)
end

function isometricMapSystem:loadAllTile()
for k,v in pairs(TILE_TYPE)do
isometricMapSystem:loadTile(v)
end
end

function isometricMapSystem:showNormalModel(guid,etype,bShow)
if etype==2 then
local idArr=_MapManager.GetLayoutBuildingMembersGUID(guid,1)
if idArr then
local st=_EntityManager:GetEntity(idArr[1])
st:SetColor(bShow and Color.New(1,1,1,1)or Color.New(1,1,1,0))
end
end
end

function isometricMapSystem:loadMountain(sfId)
self:unlockMountainArea(sfId)
local cpkey=webGLHelper:isRunWebGL()and'def_camera_pos_webgl'or'def_camera_pos'
local camera_pos=cfgHelper.get2(cfg_monijysfconfig_get,sfId,cpkey)
local buildingDatas=zongmenModel:getAllBuildingData(sfId)
local showList={}
for k,v in pairs(buildingDatas)do
local dx=v.x-camera_pos[1]
local dy=v.y-camera_pos[2]
local sortVal=dx*dx+dy*dy
showList[#showList+1]={k=k,v=v,sortVal=sortVal}
end
table.sort(showList,function(a,b)
return a.sortVal<b.sortVal
end)

for i,data in ipairs(showList)do
local k=data.k
local v=data.v
local cfg=cfgHelper.get1(cfg_monijybuildconfig_get,v.build_id)
if cfg==nil then
loggerUtil.logErrFMT("没有建筑配置 id:{0}",v.build_id)
end
local mdata=self:getModelByData(v)
local bx=cfg.buid_size[1]
local by=cfg.buid_size[2]
local offset=self:countOffset(bx,by)
local pos=_MapManager.ToVector3Int(v.x,v.y,0)
local guid=isometricMapSystem:createBuildingEntity(objectType.ePlaceObject,sfId,v.build_id,mdata.model,mdata.slots,mdata.layer,true,
v.orientation~=0,mdata.scale,pos,offset,cfg.pCfgId or conditionConfig.showPlace)
zongmenModel:setBuildingEntityId(sfId,k,guid)
isometricMapSystem:addNameHud(guid,cfg.id)
isometricMapSystem:addQiYuHud(guid,cfg.id)

self:showNormalModel(guid,cfg.etype,mdata.hideNormalModel~=true)
if cfg.sp_model then
if cfg.sp_level_up then
self.spModelBdData[v.un_build_id]=v
end

if v.flag>0 and v.flag~=2 and v.level==1 then
self:showSpecialModel(guid,cfg,0,true,v.flag)
else
self:showSpecialModel(guid,cfg,v.level,false)
end
end












if mdata.offset then
_MapManager.SetOffset(guid,Vector3.New(mdata.offset[1],mdata.offset[2],0))
end








self:checkAndPlayPemanentEffect(v,cfg)

if cfg.showShadow then
_MapManager.ShowShadow(guid,true)
end

local status=zongmenModel:getRepairStatusById(sfId,v.un_build_id)
if status and status~=repairStatus.eNotRepaired then
if v.flag==1 then
self:setLockPlaceObject(guid,true)
else
zongmenModel:setRepairStatusById(sfId,v.build_id,repairStatus.eRepaired,v.un_build_id)
end
end

if cfg.etype==2 and v.flag==0 then
feedingSystem:addFeedBuilding(v)
local dzId=v.dizi_id
if tostring(dzId)~='0'then
aiManager:beginFeedingAI(dzId,v.un_build_id)
end
end
end
end

function isometricMapSystem:loadSkyBuilding(mapId)

local buildingDatas=zongmenModel:getSkyBuildingDatas(mapId)
for k,v in pairs(buildingDatas)do
local cfg=cfgHelper.get1(cfg_monijybuildconfig_get,v.build_id)
if cfg==nil then
loggerUtil.logErrFMT("没有建筑配置 id:{0}",v.build_id)
end
local bx=cfg.buid_size[1]
local by=cfg.buid_size[2]
local offset=self:countOffset(bx,by)
local pos=_MapManager.ToVector3Int(v.x,v.y,0)
local model=cfg.model[1]
local scale=self:getModelScale(model)


local guid=isometricMapSystem:createBuildingEntity(objectType.eSkyPlaceObject,mapId,v.build_id,model,nil,SortingLayers.ITSkyBD,true,
v.orientation~=0,scale,pos,offset,conditionConfig.skyPlace)
zongmenModel:setSkyBuildingEntityId(k,guid)

_MapManager.SetPlaceObjectCover(guid,false)

self:createBehaviorBT(mapId,guid,cfg.stand_behavior)







end
zongmenModel:setSkyBuildingClickEnable(mapId,false)
end

function isometricMapSystem:getMapBehaviorData(mapId)
local dict=self.behavior_data[mapId]
if not dict then
dict={}
self.behavior_data[mapId]=dict
end
return dict
end

function isometricMapSystem:createBehaviorBT(mapId,guid,stand_behavior)
if stand_behavior then
local stype=stand_behavior[1]
local args=stand_behavior[2]
if stype==1 then
local initData={
stId=guid,
enterId=args[1],
closeId=args[3],
standTime=args[4],
playCD=args[5]
}
local bt=behaviorManager:addBehaviorTree(btType.bt_bd_stand,{},true,initData)
local dict=self:getMapBehaviorData(mapId)
dict[guid]=bt
return bt
end
end

return nil
end

function isometricMapSystem:removeBuildingBehavior(mapId)
local dict=self:getMapBehaviorData(mapId)
for k,v in pairs(dict)do
behaviorManager:removeBehaviorTree(v)
end
end

function isometricMapSystem:removeBuildingBehaviorById(mapId,guid)
local dict=self:getMapBehaviorData(mapId)
if dict[guid]then
behaviorManager:removeBehaviorTree(dict[guid])
dict[guid]=nil
end
end

function isometricMapSystem:removeBuildingBehaviorByIdEx(guid)
for k,v in pairs(self.behavior_data)do
if v[guid]then
behaviorManager:removeBehaviorTree(v[guid])
v[guid]=nil
end
end
end

function isometricMapSystem:addNameHud(entityId,cfgId)
if isometricMapSystem:getDesignMode()then return end
if zongmenModel:hasNameHud(entityId)then return end
local cfg=cfgHelper.get1(cfg_monijybuildconfig_get,cfgId)
local showName=cfg.showName or false
if not showName then return end
if cantClickAtNotOpenSystem[cfgId]then
if not systemModel.isOpen(cantClickAtNotOpenSystem[cfgId])then
return false
end
end
local offset=cfg.showNameOffset or{0,0}
hudControl:addHUD(INSTANCE_TYPE.uiBuildNameHud,entityId,Vector3(offset[1],offset[2],0),true,true,function(hud)
local nameModel=isometricMapSystem:isInNameModel()
zongmenModel:addNameHud(entityId,hud)
local widget=hudControl:getHUDWidget(hud)

widget:SetChildActive(2,nameModel)
widget:SetChildCSImageSprite(4,globalABLookup.hud_atlas,iconHelper.getBuildNameIcon(showName))
widget:SetChildButtonClick(3,function()
isometricMapSystem:checkTouchBuilding(entityId)
end,true)
end)
end

function isometricMapSystem:addNameHudBybdid(ubdId)
local bdData=zongmenModel:getBuildingData(ubdId)
if bdData==nil then return end
local entityId=bdData.entityId
local cfg=cfgHelper.get1(cfg_monijybuildconfig_get,bdData.build_id)
local cfgId=cfg.id
isometricMapSystem:addNameHud(entityId,cfgId)
end

function isometricMapSystem:removeNameHud(entityId)
zongmenModel:removeNameHud(entityId)
hudControl:clearHUDByEntityID(entityId)
end

function isometricMapSystem:removeNameHudBybdid(ubdId)
local bdData=zongmenModel:getBuildingData(ubdId)
if bdData==nil then return end
local entityId=bdData.entityId
isometricMapSystem:removeNameHud(entityId)
end

function isometricMapSystem:showNameHud(bdData,vis)
if bdData==nil then return end
local entityId=bdData.entityId
if entityId==nil then return end
local hud=zongmenModel:getNameHud(entityId)
if hud==nil then return end
local widget=hudControl:getHUDWidget(hud)
if widget==nil then return end
widget:SetChildActive(2,vis)
end

function isometricMapSystem:freshAllNameHudVis(vis)
local sfId=mapIdType.zhufeng
local bdDatas=zongmenModel:getAllBuildingData(sfId)
for _,v in pairs(bdDatas)do
isometricMapSystem:showNameHud(v,vis)
end

local bdDatas=isometricMapSystem:getRepairDatas(sfId)
for _,v in pairs(bdDatas)do
isometricMapSystem:showNameHud(v.bdData,vis)
end

local sfId=mapIdType.xianmeng
local bdDatas=zongmenModel:getAllBuildingData(sfId)
for _,v in pairs(bdDatas)do
isometricMapSystem:showNameHud(v,vis)
end

local sfId=mapIdType.fort
local bdDatas=zongmenModel:getAllBuildingData(sfId)
for _,v in pairs(bdDatas)do
isometricMapSystem:showNameHud(v,vis)
end

local bdDatas=isometricMapSystem:getRepairDatas(sfId)
for _,v in pairs(bdDatas)do
isometricMapSystem:showNameHud(v.bdData,vis)
end
end

function isometricMapSystem:addQiYuHud(entityId,cfgId)
if isometricMapSystem:getDesignMode()then return end
if zongmenModel:hasQiYuHud(entityId)then
isometricMapSystem:freshQiYuHudEx(entityId)
return
end
local cfg=cfgHelper.get1(cfg_monijybuildconfig_get,cfgId)
local showQiYu=cfg.qyEventId~=nil and not cfg.hideQYEventHud
if not showQiYu then return end
if cantClickAtNotOpenSystem[cfgId]then
if not systemModel.isOpen(cantClickAtNotOpenSystem[cfgId])then
return false
end
end
local scale=cfg.showQiYuOffset and cfg.showQiYuOffset[1]or 1
local offset=cfg.showQiYuOffset and cfg.showQiYuOffset[2]or{0,0}
hudControl:addHUD(INSTANCE_TYPE.eBuildQiYuHud,entityId,Vector3(offset[1],offset[2],0),true,true,function(hud)
zongmenModel:addQiYuHud(entityId,hud)
local widget=hudControl:getHUDWidget(hud)
local areaId=_MapManager.GetAreaIDByObject(entityId)
local isAreaUnLock=zongmenModel:isAreaUnlock(areaId)
local color
if not isAreaUnLock then
local baseCfg=cfgHelper.get1(cfg_monijybasicconfig_get,1)
local cv=baseCfg.lock_area_brightness
color=Color.New(cv,cv,cv,1)
else
color=Color.New(1,1,1,1)
end
widget:SetChildScale(0,Vector3(scale,scale,scale))
widget:SetChildColor(0,color)
widget:SetChildCSImageSprite(0,globalABLookup.hud_atlas,isAreaUnLock and"image_qiyu_1"or"image_qiyu_2")
widget:SetChildButtonClick(0,function()
local isAreaUnLock=zongmenModel:isAreaUnlock(areaId)
if not isAreaUnLock then
if areaId>0 and isometricMapSystem:isCanShowArea(areaId)then
if not zongmenModel:isAreaUnlock(areaId)then
local mapId=zongmenModel:getMountainId()
isometricMapSystem:openAreaUnLockWin(mapId,areaId,true)
return true
end
end
return
end

local repairData=isometricMapSystem:getRepairDataByID(mapIdType.zhufeng,cfgId)
if repairData then
zongmenControl:reqBuild(mapIdType.zhufeng,repairData.id,repairData.x,repairData.y,repairData.orientation)
return false
else
isometricMapSystem:checkTouchBuilding(entityId)
return true
end
end,true)
end)
end

function isometricMapSystem:addQiYuHudBybdid(ubdId)
local bdData=zongmenModel:getBuildingData(ubdId)
if bdData==nil then return end
local entityId=bdData.entityId
local cfg=cfgHelper.get1(cfg_monijybuildconfig_get,bdData.build_id)
local cfgId=cfg.id
isometricMapSystem:addQiYuHud(entityId,cfgId)
end

function isometricMapSystem:removeQiYuHud(entityId)
zongmenModel:removeQiYuHud(entityId)
hudControl:clearHUDByEntityID(entityId)
end

function isometricMapSystem:removeQiYuHudBybdid(ubdId)
local bdData=zongmenModel:getBuildingData(ubdId)
if bdData==nil then return end
local entityId=bdData.entityId
isometricMapSystem:removeQiYuHud(entityId)
end

function isometricMapSystem:freshQiYuHud(bdData)
if bdData==nil then return end
local entityId=bdData.entityId
if entityId==nil then return end
isometricMapSystem:freshQiYuHudEx(entityId)
end

function isometricMapSystem:freshQiYuHudEx(entityId)
local hud=zongmenModel:getQiYuHud(entityId)
if hud==nil then return end
local widget=hudControl:getHUDWidget(hud)
if widget==nil then return end
local areaId=_MapManager.GetAreaIDByObject(entityId)
local isAreaUnLock=zongmenModel:isAreaUnlock(areaId)
local color
if not isAreaUnLock then
local baseCfg=cfgHelper.get1(cfg_monijybasicconfig_get,1)
local cv=baseCfg.lock_road_brightness
color=Color.New(cv,cv,cv,1)
else
color=Color.New(1,1,1,1)
end
widget:SetChildColor(0,color)
widget:SetChildCSImageSprite(0,globalABLookup.hud_atlas,isAreaUnLock and"image_qiyu_1"or"image_qiyu_2")
end

function isometricMapSystem:freshAllQiYuHud()
local sfId=mapIdType.zhufeng
local bdDatas=isometricMapSystem:getRepairDatas(sfId)
for _,v in pairs(bdDatas)do
isometricMapSystem:freshQiYuHud(v.bdData)
end
end

function isometricMapSystem:checkAndPlayPemanentEffect(bdData,cfg)
if not cfg then
cfg=cfgHelper.get1(cfg_monijybuildconfig_get,bdData.build_id)
end
if cfg.effect then
if bdData.flag==0 then
if cfg.effect[buildEffectType.ePemanent]then
buildingEffectControl:playEffectByEID(bdData.entityId,cfg.id,buildEffectType.ePemanent)
elseif cfg.effect[buildEffectType.eRegular]then
zongmenEffectControl:addBuildinfEffect(bdData,cfg)
end
end
end
end

function isometricMapSystem:hasSpecialModel(guid)
return self.modelList[guid]
end

function isometricMapSystem:getSpecialModel(guid)
return self.modelList[guid]
end

function isometricMapSystem:getSpecialModelLevel(zmLevel,bdLevel,levelData)
local spLevel=-1
local len=#levelData
for i=0,len do
local v=levelData[i]
if zmLevel>=v.level then
if v.bdLevel then
if bdLevel>=v.bdLevel then
spLevel=i
end
else
spLevel=i
end
else
break
end
end
return spLevel
end

function isometricMapSystem:getSpecialModelID(cfg,level,repair,stageflag)
local rmodel
local rlevel

if repair and cfg.sp_model_stage then
if stageflag and stageflag>20 then

local index=stageflag-20
rmodel=cfg.sp_model_stage[index]
elseif stageflag and stageflag>10 then
local index=stageflag-11
rmodel=cfg.sp_model_stage[index]
else

rmodel=cfg.sp_model[level]
end
rlevel=level
elseif cfg.sp_level_up then
local zmLevel=zongmenModel:getLevel()
local spLevel=self:getSpecialModelLevel(zmLevel,level,cfg.sp_level_up)
if repair then
spLevel=math.min(spLevel,0)
end
rmodel=cfg.sp_model[spLevel]
rlevel=spLevel
else
if cfg.sp_model_canMove and stageflag==1 then
rmodel=cfg.sp_model[0]
rlevel=0
else
rmodel=cfg.sp_model[level]
rlevel=level
end
end
local spModel=zongmenSkinControl:getSpecialBDTimeLimitSkin(cfg.id,rlevel)
if spModel then
return spModel,rlevel
else
return rmodel,rlevel
end
end

function isometricMapSystem:showSpecialModel(guid,cfg,level,repair,stageflag)
local modelId,spLevel=self:getSpecialModelID(cfg,level,repair,stageflag)
if modelId then
local st=isometricMapSystem:createModelEntity(modelId)
if st then
self.modelList[guid]=st.GUID
end
if cfg.sp_level_up then
local sdata=cfg.sp_level_up[spLevel]
if sdata.scenery then
local mapId=_MapManager.GetObjectMapID(guid)
for i,v in ipairs(sdata.scenery)do
surfaceControl:setSurfacePartActive(v,mapId,true)
end
end
end
if self:isInGroundModel()and not cfg.no_ground_model then
st:SetVisible(false)
else
st:SetVisible(true)
end

if cfg.sp_model_canMove then
local bdSt=_EntityManager:GetEntity(guid)
local isFlipX=bdSt:GetFlipX()
local bdStTran=bdSt:GetActorRootTransform()
local spModelStTran=st:GetActorRootTransform()
local spModelStParentTran=spModelStTran.parent
spModelStParentTran:SetParent(bdStTran)
spModelStParentTran.localPosition=Vector3.zero
local scaleV3=spModelStTran.localScale
local scale_x=isFlipX and-1 or 1
scaleV3.x=scale_x
spModelStTran.localScale=scaleV3
end

return st
end
return nil
end

function isometricMapSystem:refreshSpecialModelFlipX(guid)
local hasSPModel=isometricMapSystem:hasSpecialModel(guid)
if hasSPModel then
local spModelEID=isometricMapSystem:getSpecialModel(guid)
local bdSt=_EntityManager:GetEntity(guid)
local isFlipX=bdSt:GetFlipX()
local spbdSt=_EntityManager:GetEntity(spModelEID)
local spModelStTran=spbdSt:GetActorRootTransform()
local scaleV3=spModelStTran.localScale
local scale_x=isFlipX and-1 or 1
scaleV3.x=scale_x
spModelStTran.localScale=scaleV3
end
end

function isometricMapSystem:playWaitingBT()
if self.waitPlayBT then
storyAIManager:startStoryBehavior(self.waitPlayBT,nil)
self.waitPlayBT=nil
end
end

function isometricMapSystem:getActiveBuildList(itemid)
return self.buildActiveLookup[itemid]
end

function isometricMapSystem:removeActiveBuildCfg(itemid,bdid)
local cfg=self.buildActiveLookup[itemid]
if cfg then
for i,v in ipairs(cfg)do
if bdid==v then
table.remove(cfg,i)
return
end
end
end
end

function isometricMapSystem:removeAllActiveBuildCfg()
for _,v in pairs(self.buildActiveLookup)do
for i=#v,1,-1 do
local bdid=v[i]
if zongmenModel:isActiveBuild(bdid)then
table.remove(v,i)
end
end
end
end

function isometricMapSystem:getActiveRoadList(itemid)
return self.roadActiveLookup[itemid]
end

function isometricMapSystem:removeActiveRoadCfg(itemid,id)
local cfg=self.roadActiveLookup[itemid]
if cfg then
for i,v in ipairs(cfg)do
if id==v then
table.remove(cfg,i)
return
end
end
end
end

function isometricMapSystem:removeAllActiveRoadCfg()
for _,v in pairs(self.roadActiveLookup)do
for i=#v,1,-1 do
local id=v[i]
if zongmenModel:isActiveRoad(id)then
table.remove(v,i)
end
end
end
end

function isometricMapSystem:triggerSpecialModelLevelUp(lastLevel,currLevel)

for i,bdData in pairs(self.spModelBdData)do
local buildId=bdData.build_id
local cfg=cfgHelper.get1(cfg_monijybuildconfig_get,buildId)
local level1=self:getSpecialModelLevel(lastLevel,bdData.level,cfg.sp_level_up)
local level2=self:getSpecialModelLevel(currLevel,bdData.level,cfg.sp_level_up)
if level2 and(not level1 or(level2>level1))then
local ld=cfg.sp_level_up[level2]
if ld.bt then
self:playStoryBT(ld.bt)
return
end
end
end

self:triggerSceneryShow(lastLevel,currLevel)
end

function isometricMapSystem:triggerSceneryShow(lastLevel,currLevel)
local cfgs=cfg_zongmensceneryconfig()
for k,v in pairs(cfgs)do
if lastLevel<v.level and currLevel>=v.level then
if v.bt then
self:playStoryBT(v.bt)
return
end
end
end
end

function isometricMapSystem:playStoryBT(bt)
if zongmenModel:getMountainId()~=mapIdType.zhufeng then
self.waitPlayBT=bt
else
storyAIManager:startStoryBehavior(bt,nil)
end
end

function isometricMapSystem:resetMap(sfId)
zongmenModel:countWarehouseLimit()
self.isAreaInit=true
self:setNormalMap(sfId)
eventProductControl:freshAllEvent(sfId)
end

function isometricMapSystem:setNormalMap(sfId)
local buildingDatas=zongmenModel:getAllBuildingData(sfId)

self:initNewAreaCheck()

self:showRepairBuilding(sfId)

for k,v in pairs(buildingDatas)do
self:setBenefitBuffBuilding(v)
self:setDiscipleCheckInData(v)
end

self:setNewAreaShow(sfId)

self:drawArea(sfId,-1)
















local roadDatas=zongmenModel:getMountainRoadDatas(sfId)
if roadDatas then
isometricMapSystem:drawRoad(sfId,roadDatas)
end

self:handleCreateSundrise(sfId)

self:createLockAreaSundrise(sfId)

if sfId==mapIdType.zhufeng then
self:reCreateAllRandomObject()
end

self:loadLockAreaRoad(sfId)

self:setAreaCellBrightness(sfId,-1,true)

buildingCDControl:addAllBuildingCDByMapId(sfId)





isometricMapSystem:setLinkRoadData(sfId)
isometricMapSystem:resetHUD(sfId)
end

function isometricMapSystem:createLockAreaSundrise(sfId)
local check=self:isCanShowNewArea(sfId)
if not check then
local cfgs=cfg_monijyareaconfig()
for k,v in pairs(cfgs)do
if v.sf_id==sfId and not self:isNewMapArea(k)and not zongmenModel:isAreaUnlock(k)then
_MapManager.LoadSundriseByArea(sfId,k,function(mapId,areaId,cfgId,flip,pos)
self:createSundries({id=cfgId,flip=flip,pos=pos,areaId=areaId,mapId=mapId})
end)
end
end
else
_MapManager.LoadAllLockSundrise(sfId,function(mapId,areaId,cfgId,flip,pos)
self:createSundries({id=cfgId,flip=flip,pos=pos,areaId=areaId,mapId=mapId})
end)
end
end

function isometricMapSystem:handleCreateSundrise(sfId)

local randomList=zongmenModel:getAllSundriseData(sfId)
for k,v in pairs(randomList)do
if v.end_times>0 and zongmenSundriseTempDataModel.getCDLastTime(v.end_times)<=0 then
randomList[k]=nil
end
end

sundriseCreateControl:createSundriesByDatas(sfId,randomList,true)
end

function isometricMapSystem:showLinkSlot(guid,slotId)
if slotId then
if _MapManager.IsCanShowLinkSlot(guid)then
self:changeSlot(guid,'lu',slotId)
else
self:changeSlot(guid,'lu',-1)
end
end
end

function isometricMapSystem:showGrid()
local sfId=zongmenModel:getMountainId()
local areas=zongmenModel:getAllAreaData(sfId)
local draw_grid=cfgHelper.get2(cfg_monijysfconfig_get,sfId,'draw_grid')or{}
for k,v in pairs(areas)do
local area_id=v.area_id
local tileId=draw_grid[area_id]
_MapManager.DrawByArea(sfId,area_id,tileId or TILE_TYPE.eGrid,mapLayer.Grid,conditionConfig.drawGrid)
end
end

function isometricMapSystem:showGridInRange(mapId,layer,spos,epos,tile,activeRange)
local pos1=_MapManager.ToVector3Int(spos[1],spos[2],0)
local pos2=_MapManager.ToVector3Int(epos[1],epos[2],0)
_MapManager.DrawInRangeEx(mapId,pos1,pos2,tile or TILE_TYPE.eGrid,layer,-2)
if activeRange then
_MapManager.SetCellCheckRange(true,pos1,pos2)
end
end

function isometricMapSystem:showAreaDraw(mapId,tile,layer,condition)
local sfId=mapId or zongmenModel:getMountainId()
local areas=zongmenModel:getAllAreaData(sfId)
for k,v in pairs(areas)do
_MapManager.DrawByArea(sfId,v.area_id,tile,layer,condition or conditionConfig.showPlace)
end
if not self.areaDrawData then
self.areaDrawData={}
end
self.areaDrawData[sfId]=layer
end

function isometricMapSystem:hideGrid(layer)
local mapId=zongmenModel:getMountainId()
_MapManager.Erase(mapId,layer)
end

function isometricMapSystem:hideAreaDraw(mapId,layer)
local sfId=mapId or zongmenModel:getMountainId()
_MapManager.Erase(sfId,layer)
if self.areaDrawData then
self.areaDrawData[sfId]=layer
end
end

function isometricMapSystem:clearAreaDraw()
if self.areaDrawData then
for sfId,layer in pairs(self.areaDrawData)do
_MapManager.Erase(sfId,layer)
end
self.areaDrawData=nil
end
end

function isometricMapSystem:setBuildingPlanStatus(sfId,bdId,status)
local bdData=zongmenModel:getBuildingData(bdId)
bdData.planStatus=status
end

function isometricMapSystem:checkAndSetSlot(bdData)
if not self:isInGroundModel()then
local sdata=UIShopModel:getShopData(bdData.un_build_id)
if sdata then
UIShopControl:refreshShopSlot(sdata)
end
end
end

function isometricMapSystem:changeModel(bdData)
if not bdData.entityId then
return
end

local mdata=self:getModelByData(bdData)

if mdata.hideSpModel then
isometricMapSystem:changeBuildingSpecialModelVisible(bdData,false)
else
isometricMapSystem:changeBuildingSpecialModelVisible(bdData,true)
end

local oldflip=bdData.orientation==1
local model=isometricMapSystem:getMirrorModelByflip(mdata.model,oldflip)
self:changeBody(bdData.entityId,model,mdata.slots,mdata.scale)
_MapManager.SetSortingLayer(bdData.entityId,mdata.layer)
if mdata.offset then
_MapManager.SetOffset(bdData.entityId,Vector3.New(mdata.offset[1],mdata.offset[2],0))
end
local etype=cfgHelper.get2(cfg_monijybuildconfig_get,bdData.build_id,'etype')
self:showNormalModel(bdData.entityId,etype,mdata.hideNormalModel~=true)
self:showLinkSlot(bdData.entityId,mdata.linkSlot)
self:checkAndSetSlot(bdData)
end

function isometricMapSystem:changeModelById(sfId,bdId)
local bdData=zongmenModel:getBuildingData(bdId)
return self:changeModel(bdData)
end

function isometricMapSystem:changeBuildingModelVisible(bdData,isVisible)
local bdEntity=_EntityManager:GetEntity(bdData.entityId)
bdEntity:SetVisible(isVisible)
if isometricMapSystem:hasSpecialModel(bdData.entityId)then
local stId=self.modelList[bdData.entityId]
if stId then
local st=_EntityManager:GetEntity(stId)
st:SetVisible(isVisible)
end
end
end

function isometricMapSystem:changeBuildingSpecialModelVisible(bdData,isVisible)
if isometricMapSystem:hasSpecialModel(bdData.entityId)then
local stId=self.modelList[bdData.entityId]
if stId then
local st=_EntityManager:GetEntity(stId)
st:SetVisible(isVisible)
end
end
end


function isometricMapSystem:change3DModel(bdData)
local stId=self.modelList[bdData.entityId]
if stId then
local st=_EntityManager:GetEntity(stId)
local cfg=cfgHelper.get1(cfg_monijybuildconfig_get,bdData.build_id)
local repairflag=false
if bdData and bdData.flag>20 then
repairflag=true
end
local model=self:getSpecialModelID(cfg,bdData.level,repairflag,bdData.flag)
st:ChangeBody(model,nil,false,1)

if cfg.sp_model_canMove then
local bdSt=_EntityManager:GetEntity(bdData.entityId)
local bdStTran=bdSt:GetActorRootTransform()
local spModelStTran=st:GetActorRootTransform()
local spModelStParentTran=spModelStTran.parent
local bdScaleV3=bdStTran.localScale
local spModelScaleArray={1/bdScaleV3.x,1/bdScaleV3.y,1/bdScaleV3.z}
local spModelScaleV3=Vector3.New(spModelScaleArray[1],spModelScaleArray[2],spModelScaleArray[3])
spModelStParentTran.localScale=spModelScaleV3
end
end
end

function isometricMapSystem:change3DModelById(sfId,bdId)
local bdData=zongmenModel:getBuildingData(bdId)
return self:change3DModel(bdData)
end

function isometricMapSystem:getModelByData(bdData)
return self:getModelByStatus(bdData.build_id,bdData.level,bdData.flag,bdData.planStatus,bdData.model_id,bdData.plant_id,bdData.un_build_id,bdData.build_appearance_id)
end

function isometricMapSystem:getModelByStatus(id,level,flag,status,mdIndex,plant_id,ubdId,skinId,isIgnoreGround,isinfo)
flag=flag or 0
local cfg=cfgHelper.get1(cfg_monijybuildconfig_get,id)
local mdata={}
if not skinId and ubdId then
local bdData=zongmenModel:getBuildingData(ubdId)
skinId=bdData and bdData.build_appearance_id or nil
end
if skinId==0 then
skinId=nil
end
local isInGroundModel=self:isInGroundModel()and not cfg.no_ground_model
if cfg.build_sf and#cfg.build_sf==1 then
if cfg.build_sf[1]==mapIdType.fort then
isInGroundModel=false
end
end
if not isIgnoreGround and isInGroundModel then
mdata.model=cfg.ground_model
mdata.slots={cfg.ground_icon}
mdata.hideNormalModel=true
mdata.hideSpModel=true
elseif cfg.buildTab==1 then
if skinId then
local skinCfg=cfgHelper.get(cfg_monijybuildappearanceconfig_get,skinId)
mdata.model=skinCfg.model
else
local len=#cfg.model
if mdIndex then
if mdIndex<=len then
mdata.modelIndex=mdIndex
else
mdata.modelIndex=math.random(len)
logErr('下发模型下标不在配置范围，请检查配置 参数：',id,level,flag,status,mdIndex,plant_id)
end
else
mdata.modelIndex=math.random(len)
end
mdata.model=cfg.model[mdata.modelIndex]
end
else
local skinCfg
if skinId then
skinCfg=cfgHelper.get(cfg_monijybuildappearanceconfig_get,skinId)
end
if flag==1 then
if skinCfg and skinCfg.build_model then
mdata.model=skinCfg.build_model[1]
else
mdata.model=cfg.build_model[1]
end
mdata.hideNormalModel=true
elseif flag==2 then
if skinCfg and skinCfg.build_model then
mdata.model=skinCfg.build_model[level+1]
if not mdata.model then
mdata.model=skinCfg.build_model[#skinCfg.build_model]
end
else
mdata.model=cfg.build_model[level+1]
if not mdata.model then
mdata.model=cfg.build_model[#cfg.build_model]
end
end
mdata.hideNormalModel=true
elseif flag>10 then
if flag>20 then
mdata.model=cfg.repair_model[flag-19]
else
mdata.model=cfg.repair_build_model[flag-10]
end
elseif flag==-1 then
mdata.model=cfg.repair_model[1]
else
if plant_id and plant_id>0 then
if status==planStatus.eStart then
if skinCfg and skinCfg.start_model then
mdata.model=skinCfg.start_model[plant_id][level]
else
mdata.model=cfg.start_model[plant_id][level]
end
elseif status==planStatus.eComplete then
if skinCfg and skinCfg.complete_model then
mdata.model=skinCfg.complete_model[plant_id][level]
else
mdata.model=cfg.complete_model[plant_id][level]
end
else
if skinCfg and skinCfg.model then
mdata.model=skinCfg.model
if not mdata.model then
mdata.model=skinCfg.model[#skinCfg.model]
end
else
mdata.model=cfg.model[level]
if not mdata.model then
mdata.model=cfg.model[#cfg.model]
end
end
logErr('[isometricMapSystem][getModelByStatus]方案执行中，但建造状态不对',id,level,flag,status,mdIndex,plant_id)
end
else
if skinCfg and skinCfg.model then
mdata.model=skinCfg.model
if not mdata.model then
mdata.model=skinCfg.model[#skinCfg.model]
end
else
mdata.model=cfg.model[level]
if not mdata.model then
mdata.model=cfg.model[#cfg.model]
end
if isinfo and cfg.infomodel then
mdata.model=cfg.infomodel[mdata.modelIndex]
if not mdata.model then
mdata.model=cfg.infomodel[#cfg.infomodel]
end
end
end
end
mdata.linkSlot=cfg.link
end
end

if cfg.is_sky_build==1 then
mdata.model=cfg.model[1]
end

mdata.scale=self:getModelScale(mdata.model)
if cfg.offset then
local offset
if not isInGroundModel then
if flag>0 then
offset=cfg.other_offset[1]
end
end
if not offset then
offset=cfg.offset
end
if((flag>0 and level==1)or flag<0)or isInGroundModel then
mdata.offset=offset[0]
else
mdata.offset=offset[level]
end
end

if cfg.model_layer then
if flag~=0 and cfg.model_layer[2]then
mdata.layer=SortingLayers[cfg.model_layer[2]]
else
if cfg.model_layer[1]then
mdata.layer=SortingLayers[cfg.model_layer[1]]
end
end
end

if not mdata.layer then
mdata.layer=SortingLayers.ITBuilding
end

return mdata
end

function isometricMapSystem:getLinkSlotId(id,flag)
local cfg=cfgHelper.get1(cfg_monijybuildconfig_get,id)
if not self:isInGroundModel()and cfg.buildTab~=1 and(flag~=1 or flag~=2)then
return cfg.link
end
end

function isometricMapSystem:resetHUD(sfId)
local buildingDatas=zongmenModel:getAllBuildingData(sfId)
for k,v in pairs(buildingDatas)do
hudControl:addProgressData(sfId,k,true)
end
end

function isometricMapSystem:setCameraActive(bActive)
local tran=_MapManager.GetCameraTransform()
tran.gameObject:SetActive(bActive)
end

function isometricMapSystem:moveCameraToObjectEx(guid,withAnimation,callback,duration,ease,offset)
local mapId=_MapManager.GetObjectMapID(guid)
if not mapId then
return
end
if mapId~=zongmenModel:getMountainId()then
mountainControl:loadAndswitchMapEx(mapId,true,function()
self:moveCameraToObject(guid,withAnimation,callback,duration,ease,offset)
end)
else
self:moveCameraToObject(guid,withAnimation,callback,duration,ease,offset)
end
end

function isometricMapSystem:moveCameraToObject(guid,withAnimation,callback,duration,ease,offset)
local pos=_MapManager.GetObjectAreaC(guid)
isometricMapSystem:moveCameraToPosition(pos,withAnimation,callback,duration,ease,offset)
end

function isometricMapSystem:moveCameraToPositionEx(mapId,pos,withAnimation,callback,duration,ease,offset)
if mapId~=zongmenModel:getMountainId()then
mountainControl:loadAndswitchMapEx(mapId,true,function()
self:moveCameraToPosition(pos,withAnimation,callback,duration,ease,offset)
end)
else
self:moveCameraToPosition(pos,withAnimation,callback,duration,ease,offset)
end
end

function isometricMapSystem:moveCameraToPosition(pos,withAnimation,callback,duration,ease,offset)

local cameraPos=_MapManager.GetCameraPosition()
local toPos
if offset then
toPos=Vector3(pos.x+offset[1],pos.y+offset[2],cameraPos.z+(offset[3]or 0))
else
toPos=Vector3(pos.x,pos.y,cameraPos.z)
end
toPos=self:clampCameraPos(toPos)
if withAnimation then
local tweener=_DOTweenProxy.DOMove(_MapManager.GetCameraTransform(),toPos,duration or 0.25)
tweener:SetEase(ease or _Ease.Linear)
if callback then
tweener:OnComplete(callback)
end
return tweener
else
_MapManager.SetCameraPosition(toPos)
return nil
end
end

function isometricMapSystem:shakeSceneCamera(duration,strength,vibrato,callback)
local transform=_MapManager.GetCameraTransform()
local tweener=_DOTweenProxy.DOShakePosition(transform,duration,strength,vibrato)
tweener:SetEase(_Ease.Linear)
tweener:OnComplete(callback)
return tweener
end

function isometricMapSystem:screenToMapPos(screenPoint)
local mapId=zongmenModel:getMountainId()
return _MapManager.ScreenPointToCell(mapId,screenPoint,0,mapLayer.Data)
end

function isometricMapSystem:getObjectPosValue(guid)
return _MapManager.GetTilemapObjectPosValue(guid)
end

function isometricMapSystem:setPlaceObject(guid)
_placeTarget=guid
end


function isometricMapSystem:flip(guid)
_MapManager.Flip(guid)
end


function isometricMapSystem:setflip(guid,flag)
_MapManager.SetFlip(guid,flag)
end


function isometricMapSystem:setflipX(guid,bdData,flag,model,scale)
bdData=bdData or zongmenModel:findBuildingByEntityId(guid)
if bdData then
local mdata=self:getModelByData(bdData)
local hasMirror=isometricMapSystem:isMirrorModel(mdata.model)
if hasMirror then
local mirrorModel=isometricMapSystem:getMirrorModelByflip(mdata.model,flag)
isometricMapSystem:changeBody(guid,mirrorModel,mdata.slots,mdata.scale)
end
elseif model then
local hasMirror=isometricMapSystem:isMirrorModel(model)
if hasMirror then
local mirrorModel=isometricMapSystem:getMirrorModelByflip(model,flag)
scale=scale or self:getModelScale(mirrorModel)
isometricMapSystem:changeBody(guid,mirrorModel,{},scale)
end
end

_MapManager.SetFlip(guid,flag)
isometricMapSystem:refreshSpecialModelFlipX(guid)
end

function isometricMapSystem:freshMirrorModelByBuildData(guid,bdData,isflip)
local mdata=self:getModelByData(bdData)
local hasMirror=isometricMapSystem:isMirrorModel(mdata.model)
if hasMirror then
local mirrorModel=isometricMapSystem:getMirrorModelByflip(mdata.model,isflip)
isometricMapSystem:changeBody(guid,mirrorModel,mdata.slots,mdata.scale)
end
end

function isometricMapSystem:freshMirrorModelByModelData(guid,mdata,isflip)
local hasMirror=isometricMapSystem:isMirrorModel(mdata.model)
if hasMirror then
local mirrorModel=isometricMapSystem:getMirrorModelByflip(mdata.model,isflip)
isometricMapSystem:changeBody(guid,mirrorModel,mdata.slots,mdata.scale)
end
end

function isometricMapSystem:changeBody(guid,model,slots,scale)
scale=scale or self:getModelScale(model)
_MapManager.ChangeBody(guid,model,slots,scale)
end

function isometricMapSystem:changeSlot(guid,slotName,slotId)
_MapManager.ChangeSlot(guid,slotName,slotId)
end

function isometricMapSystem:showBuffArea(guid)
if guid then
local mapId=_MapManager.GetObjectMapID(guid)
_MapManager.DrawBenefitBuffArea(mapId,guid,mapLayer.DrawRoad1)
else
local mapId=zongmenModel:getMountainId()
_MapManager.DrawBuffArea(mapId,mapLayer.DrawRoad1)
end
end

function isometricMapSystem:hideBuffArea()
local mapId=zongmenModel:getMountainId()
_MapManager.Erase(mapId,mapLayer.DrawRoad1)
end

function isometricMapSystem:clearStatus(isDelete)
self.beginPos=nil
self.endPos=nil
_placeTarget=nil
_dragTarget=-1
self.editorMode=editorMode.eDefault
self:stopBuildAnimation(isDelete)
self:setPreviewBuilding()
end

function isometricMapSystem:findDiscipleInRange(x1,y1,x2,y2)
local pos1=_MapManager.ToVector3Int(x1,y1,0)
local pos2=_MapManager.ToVector3Int(x2,y2,0)
local idArr=_MapManager.GetObjectInRange(pos1,pos2,objectType.eRole)
if#idArr>0 then
local list={}
for i,v in ipairs(idArr)do
local dzId=discipleStateManager:entityIdToDiscipleId(v)
if dzId then
table.insert(list,dzId)
end
end
return list
end
return nil
end

function isometricMapSystem:pickUpFromMap(guid,etype)
_MapManager.PickUpFromMap(guid)
_MapManager.SetSortingLayer(guid,SortingLayers.ITDrag)

if etype==2 then
local idArr=_MapManager.GetLayoutBuildingMembersGUID(guid,1)
local st=_EntityManager:GetEntity(idArr[1])
st:SetSortingLayer(SortingLayers.ITDrag)
end

feedingSystem:pickUpFeedBuilding(guid)
end

function isometricMapSystem:placeToMap(guid,etype,discipleAvoid)
if discipleAvoid~=false then
discipleAvoid=true
end
_MapManager.PlaceToMap(guid,conditionConfig.place)
local layer
if etype==2 then

layer=SortingLayers.ITBuilding
local idArr=_MapManager.GetLayoutBuildingMembersGUID(guid,1)
local st=_EntityManager:GetEntity(idArr[1])
st:SetSortingLayer(SortingLayers.ITGrid2)
else
layer=SortingLayers.ITBuilding
end
_MapManager.SetSortingLayer(guid,layer)


if discipleAvoid then
feedingSystem:placeFeedBuilding(guid)
self:handleDiscipleAvoid(guid)

lingShouAIManager:handleLingShouAvoid(guid)
end

end

function isometricMapSystem:handleDiscipleAvoid(guid)
local posInfo=_MapManager.GetObjectPosInfo(guid)
local dzArr=self:findDiscipleInRange(posInfo[1],posInfo[2],posInfo[1]+posInfo[4]-1,posInfo[2]+posInfo[5]-1)
if dzArr then
local posList=_MapManager.GetPlaceObjectNearbySpace(guid,3)
if posList.Count>0 then
local cfg=cfgHelper.get1(cfg_avoidaiconfig_get,1)
for i,v in ipairs(dzArr)do
local stId=discipleStateManager:getDiscipleEntity(v)
local pos=_MapManager.GetTheNearestPosInList(stId,posList)
local cmdData={
type=eAIType.eAvoid,
initData={
targetPos=pos,
speed=cfg.speed,
anim=cfg.anim,
speak_time_1=cfg.speak_time_1,
speak_skin_1=cfg.speak_skin_1,
speak_1=cfg.speak_1[math.random(1,#cfg.speak_1)],
speak_time_2=cfg.speak_time_2,
speak_skin_2=cfg.speak_skin_2,
speak_2=cfg.speak_2[math.random(1,#cfg.speak_2)],
}
}
aiManager:addCommandToDisciple(v,cmdData)
end
end
end
end

function isometricMapSystem:applyBuild(ubdId)
if self.editorMode==editorMode.ePlace then
local target=self.previewBuilding
local bdData=zongmenModel:getBuildingData(ubdId)
_MapManager.SetPosition(target.guid,_MapManager.ToVector3Int(bdData.x,bdData.y,0))
isometricMapSystem:setflipX(target.guid,bdData,bdData.orientation==1)
self:placeToMap(target.guid,target.cfg.etype)

buildingEffectControl:playEffectByEID(target.guid,target.cfg.id,buildEffectType.ePlace)
hudControl:removeHUD(target.hudId)
self:clearStatus()
end
end

function isometricMapSystem:applySkyBuild(ubdId)
if self.editorMode==editorMode.ePlace then
local target=self.previewBuilding
local bdData=zongmenModel:getSkyBuildingData(ubdId)
_MapManager.SetPosition(target.guid,_MapManager.ToVector3Int(bdData.x,bdData.y,0))
isometricMapSystem:setflipX(target.guid,bdData,bdData.orientation==1)

_MapManager.PlaceToMap(target.guid,conditionConfig.skyPlace)
_MapManager.SetSortingLayer(target.guid,SortingLayers.ITSkyBD)
_MapManager.SetPlaceObjectCover(target.guid,false)

buildingEffectControl:playEffectByEID(target.guid,target.cfg.id,buildEffectType.ePlace)
hudControl:removeHUD(target.hudId)
self:clearStatus()
end
end

function isometricMapSystem:cancelBuild()
if self.editorMode==editorMode.ePlace then
local target=self.previewBuilding
hudControl:removeHUD(target.hudId)
self:clearStatus(true)
isometricMapSystem:clear3DModelByEID(target.guid)
_MapManager.RemoveTilemapObject(target.guid)
self:removeBuildingBehaviorByIdEx(target.guid)
end
end

function isometricMapSystem:getObjActorRootTransform(guid)

local st=_EntityManager:GetEntity(guid)
local tran=st:GetActorRootTransform()
return tran
end

function isometricMapSystem:playBuildAnimationByType(ttype,guid)
local tran=self:getObjActorRootTransform(guid)
local tweener=_DOTweenProxy.DOLocalMoveY(tran,0.1,0.25)
tweener:SetEase(_Ease.Linear)
tweener:OnComplete(function()
tweener=_DOTweenProxy.DOLocalMoveY(tran,0.3,1)
tweener:SetLoops(-1,_LoopType.Yoyo)
tweener:SetEase(_Ease.InOutSine)
self.tweeners[ttype]=tweener
end)
self.tweeners[ttype]=tweener
end

function isometricMapSystem:stopBuildAnimationByType(ttype,isDelete)
if self.tweeners[ttype]then
self.tweeners[ttype]:Kill()
if not isDelete and self.previewBuilding then
local guid=self.previewBuilding.guid
local tran=self:getObjActorRootTransform(guid)
local tweener=_DOTweenProxy.DOLocalMoveY(tran,0,0.25)
tweener:SetEase(_Ease.Linear)
end
end
end

function isometricMapSystem:playBuildAnimation(guid,etype)









self:playBuildAnimationByType(1,guid)
if etype==2 then
local idArr=_MapManager.GetLayoutBuildingMembersGUID(guid,1)
self:playBuildAnimationByType(2,idArr[1])
end




end

function isometricMapSystem:stopBuildAnimation(isDelete)









self:stopBuildAnimationByType(1,isDelete)
self:stopBuildAnimationByType(2,isDelete)
end

function isometricMapSystem:createABuildingToMap(sfId,bdData,flag,planStatusFlag,pCfgId)
local defaultStatus=planStatus.eDefault
local plant_id
if planStatusFlag then
plant_id=bdData.plant_id
defaultStatus=bdData.planStatus
end
local mdata=self:getModelByStatus(bdData.build_id,bdData.level,flag or 0,defaultStatus,nil,plant_id,bdData.un_build_id)
local cfg=cfgHelper.get1(cfg_monijybuildconfig_get,bdData.build_id)
local bx=cfg.buid_size[1]
local by=cfg.buid_size[2]
local offset=self:countOffset(bx,by)
local pos=_MapManager.ToVector3Int(bdData.x,bdData.y,0)
local entity=isometricMapSystem:createBuildingEntity(objectType.ePlaceObject,sfId,bdData.build_id,mdata.model,
mdata.slots,mdata.layer,true,bdData.orientation==1,mdata.scale,pos,offset,pCfgId or cfg.pCfgId)
return entity
end

function isometricMapSystem:createBuilding(data)
local id=data.id
local skinId=data.skinId
local cfg=data.cfg
local level=data.level
local pos=data.pos
local useDefPos=data.useDefPos
local callback=data.callback
local pCfgId=data.pCfgId
local force=data.force
local flag=data.flag
local checkPlaceId=data.checkPlaceId
local plantid=data.plantid
local plan_status=data.plan_status
local flip=data.flip
local objType=data.objType

local defaultStatus=planStatus.eDefault
if plan_status then
defaultStatus=plan_status
end
local mdata=self:getModelByStatus(id,level,flag or 0,defaultStatus,nil,plantid,nil,skinId)
local bx=cfg.buid_size[1]
local by=cfg.buid_size[2]
local offset=self:countOffset(bx,by)
local mapId=zongmenModel:getMountainId()
objType=objType or objectType.ePlaceObject
local entity=isometricMapSystem:createBuildingEntity(objType,mapId,id,mdata.model,mdata.slots,SortingLayers.ITDrag,false,flip or false,
mdata.scale,pos,offset,pCfgId)

if objType==objectType.eSkyPlaceObject then
_MapManager.SetTilemapObjectLayer(entity,1)
end

if cfg.sp_model and cfg.sp_model_canMove then
self:showSpecialModel(entity,cfg,1,false)
end

if cfg.etype==2 then
local idArr=_MapManager.GetLayoutBuildingMembersGUID(entity,1)
local st=_EntityManager:GetEntity(idArr[1])
st:SetSortingLayer(SortingLayers.ITDrag)
end

if cfg.showShadow then
_MapManager.ShowShadow(entity,true)
end

local building={guid=entity,level=level,cfg=cfg,type=1,id=id,modelIndex=mdata.modelIndex}
self:setPreviewBuilding(building)

local use_def_pos=useDefPos and self:findAndMoveToDefaultPos(mapId,entity,cfg.def_build_pos,bx,by,pCfgId)

if not use_def_pos then
local needRoad=cfg.is_connect_road==1
local radius=force and 100 or nil
self:findAndMoveToPlacePos(entity,pos,needRoad,pCfgId,radius)
if not _MapManager.IsCanPlace(entity,checkPlaceId or conditionConfig.showPlace)then
local data=zongmenModel:getABuildingData(zongmenModel:getMountainId())
if data then
local cpos=_MapManager.GetTilemapObjectPosition(data.entityId)
self:findAndMoveToPlacePos(entity,cpos,needRoad,pCfgId,radius)
end
end
end

local flip=_MapManager.IsFlip(entity)
building.orientation=flip and 1 or 0

if cfg.buildTab==1 then
if cfg.buid_size[1]==cfg.buid_size[2]and math.random(1,2)==1 then
self:flip(entity)
building.orientation=building.orientation==0 and 1 or 0
end
end


isometricMapSystem:freshMirrorModelByModelData(entity,mdata,building.orientation==1)
isometricMapSystem:refreshSpecialModelFlipX(entity)


if objType==objectType.eSkyPlaceObject and data.lastPosArr then
local pArr=data.lastPosArr
if math.random()>0.5 then
pArr[1]=pArr[1]+(math.random()>0.5 and 3 or-3)
else
pArr[2]=pArr[2]+(math.random()>0.5 and 3 or-3)
end
local spos=_MapManager.ToVector3Int(pArr[1],pArr[2],0)
_MapManager.SetPosition(entity,spos)
isometricMapSystem:moveCameraToObject(entity,true,nil,0.25)
end

self:playBuildAnimation(entity,cfg.etype)
hudControl:addHUD(INSTANCE_TYPE.eBuilding,entity,Vector3(0,cfg.height,0),true,true,function(hud)
building.hudId=hud
callback(building)
end)

if cfg.layout_anim then
_MapManager.RunAnimator(entity,eAnimationID[cfg.layout_anim])
end

if force or _MapManager.IsNearbyScreenBorder(entity,{0.1,0.3,0.1,0.1})then
local npos=_MapManager.GetTilemapObjectPosition(entity)
local spos=_MapManager.GetCellCenterWorld(mapId,npos,mapLayer.Data)
isometricMapSystem:moveCameraToPosition(spos,true)
end

self:createBehaviorBT(mapId,entity,cfg.stand_behavior)
end

function isometricMapSystem:findAndMoveToDefaultPos(mapId,stId,poslist,bx,by,pCfgId)
if poslist then
for i,v in ipairs(poslist)do
local pcfg=cfgHelper.get1(cfg_monijyposidxconfig_get,v)
if pcfg.mapId==mapId then
local cx=bx
local cy=by
local flip=pcfg.orientation==1
if flip then
cx=by
cy=bx
end
local check=_MapManager.IsCanPlace(mapId,pcfg.pos[1],pcfg.pos[2],cx,cy,pCfgId)
if check then
local tpos=_MapManager.ToVector3Int(pcfg.pos[1],pcfg.pos[2],0)
_MapManager.SetPosition(stId,tpos)
isometricMapSystem:setflip(stId,flip)
return true
end
end
end
end
return false
end

function isometricMapSystem:findAndMoveToPlacePos(stId,pos,needRoad,pCfgId,radius)
radius=radius or 0
if needRoad then
local check=_MapManager.FindAndMoveToPlacePos(stId,pos,radius,true,pCfgId or conditionConfig.showPlace)
if not check then
_MapManager.FindAndMoveToPlacePos(stId,pos,radius,false,pCfgId or conditionConfig.showPlace)
end
else
_MapManager.FindAndMoveToPlacePos(stId,pos,radius,false,pCfgId or conditionConfig.showPlace)
end
end

function isometricMapSystem:createRoadMark(htype,callback)
local mapId=zongmenModel:getMountainId()
hudControl:addHUDWithPosition(htype,mapId,_MapManager.ToVector3Int(0,0,0),Vector3(0,0,0),false,true,function(id)
local widget=hudControl:getHUDWidget(id)
local data={guid=id,widget=widget}
callback(data)
end)
end

function isometricMapSystem:getPreviewBuilding()
return self.previewBuilding
end

function isometricMapSystem:setPreviewBuilding(building)
self.previewBuilding=building
end

function isometricMapSystem:hasPreviewBuilding()
return self.previewBuilding~=nil
end







function isometricMapSystem:setDragStatus(bDrag)
_isDrag=bDrag
end

function isometricMapSystem:isCanControl()
if MysteryModel:is_in_mystery()then
return false
end
if xianmengdigongModel:is_in_xmdgModel()then
return false
end
if zhengzhanshanhaiModel:is_in_mapModel()then
return false
end

if self.isInStoryMode then
return false
end

if UIFullLittleWorldControl:isOpenPlanent()then
return false
end

return true
end

function isometricMapSystem:setOtherDragFlag(flag)
self.otherDragFlag=flag
end

function isometricMapSystem.on_swipe_start(fingerIndex,touchCount,screenPoint,swipe,swipeVector,swipeLength)
loggerUtil.log('easytouchA start',fingerIndex,touchCount)
if isometricMapSystem:isCanControl()then
isometricMapSystem:onSwipeStart(fingerIndex,touchCount,screenPoint,swipe,swipeVector,swipeLength)
end
end

function isometricMapSystem.on_swipe_start_2f(fingerIndex,touchCount,screenPoint,swipe,swipeVector,swipeLength)
if isometricMapSystem:isCanControl()then
isometricMapSystem:onSwipeStart(fingerIndex,touchCount,screenPoint,swipe,swipeVector,swipeLength)
end
end

function isometricMapSystem:onSwipeStart(fingerIndex,touchCount,screenPoint,swipe,swipeVector,swipeLength)











end

function isometricMapSystem.on_swipe(fingerIndex,touchCount,screenPoint,swipe,swipeVector,swipeLength,deltaTime)
if isometricMapSystem:isCanControl()then
isometricMapSystem:onSwipe(fingerIndex,touchCount,screenPoint,swipe,swipeVector,swipeLength,deltaTime)
else
loggerUtil.log("不能移动 ：",MysteryModel:is_in_mystery(),isometricMapSystem.isInStoryMode)
end
end

function isometricMapSystem.on_swipe_2f(fingerIndex,touchCount,screenPoint,swipe,swipeVector,swipeLength,deltaTime)
if isometricMapSystem:isCanControl()then
isometricMapSystem:onSwipe(fingerIndex,touchCount,screenPoint,swipe,swipeVector,swipeLength,deltaTime)
end
end

function isometricMapSystem:onSwipe(fingerIndex,touchCount,screenPoint,swipe,swipeVector,swipeLength,deltaTime)
if touchCount~=1 then
return
end

if self.editorMode==editorMode.eCreateRoad or self.editorMode==editorMode.eDeleteRoad then
return
end

if(not _isDrag and _dragTarget<0)and not self.otherDragFlag then
if _swip_begin_pos==nil then
_on_swipe=true
_swip_begin_pos=screenPoint
_camera_begin_pos=_MapManager.GetCameraPosition()
end
_MapManager.MoveCameraByScreenSpacing(_camera_begin_pos,_swip_begin_pos,screenPoint)
local curPos=_MapManager.GetCameraPosition()
AudioManager.setListenerPosition(Vector3.New(curPos.x,curPos.y,0))
if self.previewBuilding then
_MapManager.AutoDragObject(zongmenModel:getMountainId(),self.previewBuilding.guid)
end
else
_MapManager.AutoDragCamera(screenPoint,deltaTime*0.1,0)
end
end

function isometricMapSystem.on_swipe_end(fingerIndex,touchCount,screenPoint,swipe,swipeVector,swipeLength)
loggerUtil.log('easytouchA end',fingerIndex,touchCount)
if isometricMapSystem:isCanControl()then
isometricMapSystem:onSwipeEnd(fingerIndex,touchCount,screenPoint,swipe,swipeVector,swipeLength)
end
end

function isometricMapSystem.on_swipe_end_2f(fingerIndex,touchCount,screenPoint,swipe,swipeVector,swipeLength)
if isometricMapSystem:isCanControl()then
isometricMapSystem:onSwipeEnd(fingerIndex,touchCount,screenPoint,swipe,swipeVector,swipeLength)
end
end

function isometricMapSystem:onSwipeEnd(fingerIndex,touchCount,screenPoint,swipe,swipeVector,swipeLength)




_swip_begin_pos=nil
_camera_begin_pos=nil




end

function isometricMapSystem.on_pinch(fingerIndex,touchCount,screenPoint,deltaPinch,deltaTime)
if isometricMapSystem:isCanControl()then
if isometricMapSystem.isInPhotoMode then
return
end

isometricMapSystem:onPinch(screenPoint,deltaPinch,deltaTime)
end
end

function isometricMapSystem:onPinch(screenPoint,deltaPinch,deltaTime)
local size=_MapManager.GetCameraOrthographicSize()
local lastSize=size
size=size-deltaPinch*deltaTime*_touch_scale

local ds=math.abs(size-lastSize)
if ds>2 then
return
end

if size>_max_orthographic_size then
size=_max_orthographic_size
elseif size<_min_orthographic_size then
size=_min_orthographic_size
end

if webGLHelper:isRunMiniGame()then
self:checkAndFreezeAnimation(size)
end

_on_pinch=true
_MapManager.SetCameraOrthographicSize(size)
self:setCameraBorder()

end

function isometricMapSystem:setCameraOrthoSize(size,duration,callback,delay)
if duration>0 then
local tran=_MapManager.GetCameraTransform()
local camera=tran:GetComponent('Camera')
local tweener=_DOTweenProxy.DOOrthoSize(camera,size,duration)
tweener:OnComplete(function()
self:setCameraBorder()
if callback then
callback()
end
end)
if delay then
tweener:SetDelay(delay)
end
return tweener
else
_MapManager.SetCameraOrthographicSize(size)
self:setCameraBorder()
if callback then
callback()
end
return nil
end
end






function isometricMapSystem.on_touch_start(fingerIndex,touchCount,screenPoint,guid)
if isometricMapSystem:isCanControl()and touchCount==1 then
isometricMapSystem:onTouchStart(screenPoint,guid)
end
end

function isometricMapSystem:onTouchStart(screenPoint,guid)
if webGLHelper:isRunMiniGame()then
if webGLHelper:checkPlatform(webGLMGPlatform.windows)then
_swip_begin_pos=nil
_camera_begin_pos=nil
end
end
if self.editorMode==editorMode.eCreateRoad or self.editorMode==editorMode.eDeleteRoad then
local pos=self:screenToMapPos(screenPoint)
local mapId=zongmenModel:getMountainId()
if not _MapManager.IsCanMove(mapId,pos,self.curr_move_check)then
if self.beginPos==nil then
UIManager.error('此位置无法创建道路或围墙')
else
UIManager.error('起点无法自动连接到此位置')
end
return
end
if not self.beginPos then
self.beginPos=pos
end
_isDrag=not self.endPos or _MapManager.IsPositionEqual(pos,self.endPos)
if _isDrag then
self.endPos=pos
self:drawPath()

UIManager:invokeUIMethod('UILayoutWin','SetBeginMarkPos',self.beginPos)
UIManager:invokeUIMethod('UILayoutEditWin','SetBeginMarkPos',self.beginPos)
UIManager:invokeUIMethod('UILayoutWin','ShowMarkPos',false,true)
UIManager:invokeUIMethod('UILayoutEditWin','ShowMarkPos',false,true)
UIManager:invokeUIMethod('UILayoutWin','SetTips','拖动终点或点击位置确定终点')
end
elseif self.editorMode==editorMode.ePlace then
local pos=self:screenToMapPos(screenPoint)
self.endPos=pos
_dragTarget=guid==_placeTarget and guid or-1
end
end

function isometricMapSystem.on_touch_down(fingerIndex,touchCount,screenPoint)
if isometricMapSystem:isCanControl()and touchCount==1 then
isometricMapSystem:onTouchDown(screenPoint)

lingShouAIManager:onTouchDown(screenPoint)
end
end

function isometricMapSystem:onTouchDown(screenPoint)
if self.editorMode==editorMode.eCreateRoad or self.editorMode==editorMode.eDeleteRoad then
if _isDrag and self.beginPos then
self:setPathEndPos(screenPoint)
end
elseif self.editorMode==editorMode.ePlace then
if _dragTarget>0 then
local pos=self:screenToMapPos(screenPoint)
if not _MapManager.IsPositionEqual(pos,self.endPos)then
self.endPos=pos

_MapManager.SetPositionAndCentered(_dragTarget,pos)

UIManager:invokeUIMethod('UILayoutWin','refreshApplyBtn')
end
end
end
end

function isometricMapSystem:reDrawPath()
if self.beginPos and self.endPos then
self:drawPath()
UIManager:invokeUIMethod('UILayoutWin','SetTips','拖动终点或点击位置确定终点')
end
end

function isometricMapSystem:setPathEndPos(screenPoint)
local pos=self:screenToMapPos(screenPoint)
local mapId=zongmenModel:getMountainId()
if not _MapManager.IsPositionEqual(pos,self.endPos)and _MapManager.IsCanMove(mapId,pos,self.curr_move_check)then
self.endPos=pos
self:drawPath()
local samePos=_MapManager.IsPositionEqual(self.beginPos,self.endPos)
UIManager:invokeUIMethod('UILayoutWin','ShowMarkPos',not samePos,true)
UIManager:invokeUIMethod('UILayoutEditWin','ShowMarkPos',not samePos,true)
end
end

function isometricMapSystem.on_touch_up(fingerIndex,touchCount,screenPoint,guid,isIgnoreLs)
if isometricMapSystem:isCanControl()and touchCount==1 then
if isometricMapSystem.isInPhotoMode then
return
end
if UIFullLittleWorldControl:isOpenPlanent()then
return
end

_isDrag=false
_dragTarget=-1

local mapId=zongmenModel:getMountainId()
if not isIgnoreLs and mapId==mapIdType.lingshoudao then

lingShouAIManager:onTouchUp(screenPoint,guid)
end

if _on_swipe or _on_long_touch or _on_pinch then
_on_swipe=false
_on_long_touch=false
_on_pinch=false
return
end

if mapId==mapIdType.zhufeng or mapId==mapIdType.lingshoudao or mapId==mapIdType.xianmeng or mapId==mapIdType.zhufeng_design or mapId==mapIdType.fort then
isometricMapSystem:onTouchUp(screenPoint,guid)
elseif mapId==mapIdType.xianzhan then
xianzhanController:onTouchUp(fingerIndex,touchCount,screenPoint,guid)
elseif mapId==mapIdType.zhufeng_hy then
visitControl:onTouchUp(guid)
end
end
end

function isometricMapSystem.on_touch_up_notify(fingerIndex,touchCount,screenPoint,guid,isIgnoreLs)
if deviceHelper.getAPILevel()>=434 then
return
end
return isometricMapSystem.on_touch_up(fingerIndex,touchCount,screenPoint,guid,isIgnoreLs)
end

function isometricMapSystem.on_touch_up_list(fingerIndex,touchCount,screenPoint,guidList)
if isometricMapSystem:isCanControl()and touchCount==1 then
if isometricMapSystem.isInPhotoMode then
return
end
if UIFullLittleWorldControl:isOpenPlanent()then
return
end

_isDrag=false
_dragTarget=-1

local mapId=zongmenModel:getMountainId()
local isIgnoreLs
if mapId==mapIdType.lingshoudao then
local guid=guidList.Count>0 and guidList[0]or-1

lingShouAIManager:onTouchUp(screenPoint,guid)
isIgnoreLs=true
end

if _on_swipe or _on_long_touch or _on_pinch then
_on_swipe=false
_on_long_touch=false
_on_pinch=false
return
end

local layoutMode=isometricMapSystem:getLayoutMode()
if ignoreCheckOverlapLayoutModeList[layoutMode]then
local guid=guidList.Count>0 and guidList[0]or-1
return isometricMapSystem.on_touch_up(fingerIndex,touchCount,screenPoint,guid,isIgnoreLs)
end

local guidLookup={}
local guidList_notSame={}
local guidList_show={}
local isFirst=true
for i=1,guidList.Count do
local guid=guidList[i-1]
if guid and guid~=-1 and not guidLookup[guid]then
local objType=_MapManager.GetObjectType(guid)
if not ignoreClickObjectType[objType]then
guidLookup[guid]=true
guidList_notSame[#guidList_notSame+1]=guid
local isHide=false


local inUnlockArea=isometricMapSystem:isInUnlockArea(guid)
if objType then
if notCheckOverlapObjectType[objType]then
isHide=true
if isFirst then
return isometricMapSystem.on_touch_up(fingerIndex,touchCount,screenPoint,guid)
end
elseif objType==objectType.eRole then
isHide=true
local ret=isometricMapSystem:checkTouchRole(guid,objType)
if ret and isFirst then
return
end
elseif objType==objectType.ePlaceObject or objType==objectType.eStillSundrise or objType==objectType.eStillPlaceObject then
local data=isometricMapSystem:getSundries(guid)
if data then
local isCheck=notCheckOverlapSundriseType[data.type]
if isCheck then
isHide=true
if isFirst and data.type~=sundriseType.eScenery then
return isometricMapSystem.on_touch_up(fingerIndex,touchCount,screenPoint,guid)
end
end
end
end
end

if not isHide then

local bdData=zongmenModel:findBuildingByEntityId(guid)
if bdData then
local cfg=cfgHelper.get1(cfg_monijybuildconfig_get,bdData.build_id)
local ptype=cfg.win_type
if hideOverlapBuildWinType[ptype]then
isHide=true
end
elseif objType==objectType.ePlaceObject then
local data=isometricMapSystem:getSundries(guid)
if data then
local stype=data.type
if stype==sundriseType.eScenery or stype==sundriseType.eBrand then

isHide=true
elseif stype==sundriseType.eStillSundrise then

isHide=true
end
end
elseif objType==objectType.eStillPlaceObject then
local data=isometricMapSystem:getSundries(guid)
if data then
local stype=data.type
if stype==sundriseType.eScenery or stype==sundriseType.eBrand then

isHide=true
end
end
elseif objType==objectType.eStillSundrise then

isHide=true
elseif objType==objectType.eRole then
local dzId=discipleStateManager:entityIdToDiscipleId(guid)
if dzId and not aiManager:isDZDying(dzId)then

isHide=true
end
end
end

if not isHide then
guidList_show[#guidList_show+1]=guid
isFirst=false
end
end
end
end
local showCount=#guidList_show
local count=#guidList_notSame
if showCount<=1 then
local guid=guidList_show[1]or-1
if showCount<=0 and count>0 then
guid=guidList_notSame[1]or-1
end
return isometricMapSystem.on_touch_up(fingerIndex,touchCount,screenPoint,guid,isIgnoreLs)
else
if mapId==mapIdType.zhufeng or mapId==mapIdType.lingshoudao or mapId==mapIdType.xianmeng or mapId==mapIdType.zhufeng_design or mapId==mapIdType.fort then
isometricMapSystem:onTouchUpList(screenPoint,guidList_show)
elseif mapId==mapIdType.xianzhan then
xianzhanController:onTouchUpList(fingerIndex,touchCount,screenPoint,guidList_notSame)
elseif mapId==mapIdType.zhufeng_hy then
visitControl:onTouchUpList(screenPoint,guidList_show)
end
end
end
end

function isometricMapSystem:onTouchUp(screenPoint,guid)
local objType=_MapManager.GetObjectType(guid)
local inUnlockArea=self:isInUnlockArea(guid)




if inUnlockArea then
if self:checkTouchRole(guid,objType)then
return
end
if self:checkTouchSundrise(guid,objType)then
return
end
if self:checkTouchRandomObject(guid,objType)then
return
end
if self:checkTouchEventTarget(guid,objType)then
return
end
if self:checkTouchRepairBuilding(guid,inUnlockArea)then
return
end
if self:checkTouchBuilding(guid)then
return
end
else
if self:checkTouchlockSundrise(guid,objType)then
return
end
if self:checkTouchRepairBuilding(guid,inUnlockArea)then
return
end
if self:checkTouchArea(screenPoint)then
return
end
end

if objType==objectType.eTianMoJieMonster then
tianMoJieController:checkEntityClick(guid)
return
end

if tiandaoshuController:onTouchBuild(guid)then
return
end

if xianMengDaZhenController:onTouchBuild(guid)then
return
end

if self.layoutMode==layoutMode.eSkyBuild then
local bdData=zongmenModel:findSkyBuildingByEntityId(guid)
if bdData then
local cfg=cfgHelper.get1(cfg_monijybuildconfig_get,bdData.build_id)
if cfg.is_move~=0 then
UIManager:callWindowFunc('UISkyLayoutWin','clickLayoutBtn')
end
end
end

if self.layoutMode==layoutMode.eLayout then
if self.editorMode==editorMode.eCreateRoad or self.editorMode==editorMode.eDeleteRoad then
if self.beginPos then
self:setPathEndPos(screenPoint)
end
return
end


local bdData=zongmenModel:findBuildingByEntityId(guid)

if self.previewBuilding then
if not bdData and guid or(self.previewBuilding.type==2 and bdData.entityId~=self.previewBuilding.guid)then
if guid<0 then
local pos=self:screenToMapPos(screenPoint)
_MapManager.SetPosition(self.previewBuilding.guid,pos)
UIManager:invokeUIMethod('UILayoutWin','refreshApplyBtn')
end
end
end

if self.editorMode~=editorMode.eDefault and self.editorMode~=editorMode.ePlace then
return
end

if self.previewBuilding then
if self.previewBuilding.type==2 then
if bdData then
if bdData.entityId==self.previewBuilding.guid then
return
end
UIManager:invokeUIMethod('UILayoutWin','Cancel')
end
else
return
end
end
if bdData then
local cfg=cfgHelper.get1(cfg_monijybuildconfig_get,bdData.build_id)
if cfg.is_move~=0 then
UIManager:invokeUIMethod('UILayoutWin','PickUpBuilding',guid,bdData)
else
UIManager.info('该建筑不可移动')
end
end
elseif self.layoutMode==layoutMode.eSkyLayout then
local bdData=zongmenModel:findSkyBuildingByEntityId(guid)

if self.previewBuilding then
if not bdData and guid or(self.previewBuilding.type==2 and bdData.entityId~=self.previewBuilding.guid)then
if guid<0 then
local pos=self:screenToMapPos(screenPoint)
_MapManager.SetPosition(self.previewBuilding.guid,pos)
UIManager:invokeUIMethod('UISkyLayoutWin','refreshApplyBtn')
end
end
end

if self.editorMode~=editorMode.eDefault and self.editorMode~=editorMode.ePlace then
return
end

if self.previewBuilding then
if self.previewBuilding.type==2 then
if bdData then
if bdData.entityId==self.previewBuilding.guid then
return
end
UIManager:invokeUIMethod('UISkyLayoutWin','Cancel')
end
else
return
end
end

if bdData then
local cfg=cfgHelper.get1(cfg_monijybuildconfig_get,bdData.build_id)
if cfg.is_move~=0 then
UIManager:invokeUIMethod('UISkyLayoutWin','PickUpBuilding',guid,bdData)
else
UIManager.info('该建筑不可移动')
end
end
elseif self.layoutMode==layoutMode.eDesign then

if self.editorMode==editorMode.eCreateRoad or self.editorMode==editorMode.eDeleteRoad then
if self.beginPos then
self:setPathEndPos(screenPoint)
end
return
end

local bdData=zongmenModel:findBuildingByEntityId(guid)
if not bdData then
bdData=zongmenModel:getDesignBuildingDataByEntityId(guid)
end
if self.previewBuilding then
if not bdData and guid or(self.previewBuilding.type==2 and bdData.entityId~=self.previewBuilding.guid)then
if guid<0 then
local pos=self:screenToMapPos(screenPoint)
_MapManager.SetPosition(self.previewBuilding.guid,pos)
end
end
end

if self.editorMode~=editorMode.eDefault and self.editorMode~=editorMode.ePlace then
return
end

if self.previewBuilding then
if self.previewBuilding.type==2 then
if bdData then
if bdData.entityId==self.previewBuilding.guid then
return
end
UIManager:invokeUIMethod('UILayoutEditWin','Cancel')
end
else
return
end
end
if bdData then
local cfg=cfgHelper.get1(cfg_monijybuildconfig_get,bdData.build_id)
if cfg.is_move~=0 and(bdData.flag==0 or(not bdData.flag))then
UIManager:invokeUIMethod('UILayoutEditWin','PickUpBuilding',guid,bdData)
else
UIManager.info('该建筑不可移动')
end
end
end
end

function isometricMapSystem:onTouchUpList(screenPoint,guidList)
local firstGuid=guidList[1]or-1
if firstGuid==-1 then
return self:onTouchUp(screenPoint,firstGuid)
else

local args={
screenPoint=screenPoint,
guidList=guidList,
}
UIManager:showWindow("UICommonClickSceneEntityListWin",args)
end
end

function isometricMapSystem:getEntityName(guid)
if not guid or guid==-1 then
return
end

local objType=_MapManager.GetObjectType(guid)

local nameStr
if objType and objectTypeFastName[objType]then
nameStr=objType and objectTypeFastName[objType]
return nameStr
end

if isometricMapSystem:iseStillObject(objType)or objType==objectType.eMovementSundrise then

local data=self:getSundries(guid)
if data then
local cfg=cfgHelper.get1(cfg_monijyrandomitemconfig_get,data.id)
if cfg then
nameStr=cfg.name
return nameStr
end
elseif objType==objectType.eMovementSundrise then
if emergenciesControl:checkIsCaoLing(guid)then
return"草灵"
elseif emergenciesControl:checkIsGhost(guid)then
return"鬼魂"
elseif emergenciesControl:checkIsRuiShou(guid)then
return"瑞兽"
end
end
end
if objType==objectType.eMonster then

local data=emergenciesControl:getEventMonsterData(guid)
if data then
local cfg=cfgHelper.get1(cfg_monstergroup_get,data.mId)
if cfg then
nameStr=cfg.name
return nameStr
end
end
elseif objType==objectType.eTianMoJieMonster then

local monsterData=tianMoJieController:getMonsterDataByEntityGuid(guid)
if monsterData then
local monsterCfg=cfgHelper.get1(cfg_tianmojiemonconfig_get,monsterData.id)
local monsterGroup=cfgHelper.get1(cfg_monstergroup_get,monsterCfg.monster)
nameStr=monsterGroup.name
return nameStr
end
elseif objType==objectType.eXianChong then

local xcId=xianChongControl:getXianChongIdByStId(guid)
if xcId then
local cfg=cfgHelper.get1(cfg_xianchongconfig_get,xcId)
if cfg then
nameStr=cfg.name
return nameStr
end
end
elseif objType==objectType.eRole then
local dzId=discipleStateManager:entityIdToDiscipleId(guid)
if dzId and aiManager:isDZDying(dzId)then

nameStr="垂危弟子"
return nameStr
end
else

local repairData=self.repairDatas[guid]
if repairData then
local bdId=repairData.id
local cfg=cfgHelper.get1(cfg_monijybuildconfig_get,bdId)
nameStr=cfg.name
return nameStr
end


local bdData=zongmenModel:findBuildingByEntityId(guid)
if bdData then
local bdId=bdData.build_id
local cfg=cfgHelper.get1(cfg_monijybuildconfig_get,bdId)
nameStr=cfg.name
return nameStr
end
end









end

function isometricMapSystem:isInUnlockArea(guid)
local areaId=_MapManager.GetAreaIDByObject(guid)
if areaId>0 then
if zongmenModel:isAreaUnlock(areaId)then
return true
end
else
return false,false
end
return false,true
end

function isometricMapSystem:checkTouchRole(guid,objType)
if self.layoutMode~=layoutMode.eDefault then
return false
end
if objType==objectType.eRole then
discipleStateManager:clickDisciple(guid)
shanmenController:showBaiShanWin(guid)
xiangongpingdingController:onTouchRole(guid)






return true
elseif objType==objectType.eLingShou then
local sldata=lingShouAIManager:getLingShouSceneDataByEID(guid)
if sldata then

if sldata.home and not sldata.isInShouLanFree then

local bdData=zongmenModel:findBuildingByEntityId(sldata.home)

if not UIShouLanModel:hasRewardCanReceive(bdData.un_build_id)then

UIShouLanControl:showFeedingWindow({data=bdData,mId=sldata.lsGuidStr})
end
else
UIFullLingShouMainControl:myShowWindow({ls_guid=int64.new(sldata.lsGuidStr)})
end
else

end
elseif objType==objectType.eXianChong then
xianChongControl:onTouchXianChong(guid)
elseif objType==objectType.eCatShop then
UICatShopControl:showCatShopWin(guid)
elseif objType==objectType.eZMVisitor then
UIFullZongMenVisitorControl:showMainWindow()
elseif objType==objectType.eYunYouMerchant then
UIFullYunYouMerchantControl:showMainWindow()
elseif objType==objectType.eXingJiaoMerchant then
UIFullXingJiaoMerchantControl:showMainWindow()
elseif objType==objectType.eXingJiaoShangRen then
call_activitiesHandle_func("activitiesHandle_xingjiaoshangren","onTriggerClickEntity",guid)
elseif objType==objectType.eCaiShenJiaDao then
call_activitiesHandle_func("activitiesHandle_caishenjiadao","onTriggerClickEntity",guid)
elseif objType==objectType.eChallengeVisitor then
UIFullZMVisitChallengeControl:showZMVisitChallengeWin()
elseif objType==objectType.eZongMenSpy then
emergenciesControl:onClickZongMenSpy(guid)
elseif objType==objectType.eDuJieXianDanMon then
local dlId=jctjDuJieXianDanModel:hasEntity()
UIManager:showWindow("UIDuJieDanLingWin",dlId)
elseif objType==objectType.eVassalPlotNpc then
systemZongmenRelationController:showStory()
end
return false
end

function isometricMapSystem:checkTouchEventTarget(guid,objType)
if isometricMapSystem:getDesignMode()then
return
end
if objType==objectType.eMonster then
if isometricMapSystem:checkMonsterAIRecord(guid)then
UIManager.error("宗门弟子正在前往降妖，请祖师稍等片刻")
else
local data=emergenciesControl:getEventMonsterData(guid)
UIManager:showWindow('UIEmergenciesMonsterWin',{data.mId,guid})
end
elseif objType==objectType.eMovementSundrise then
if emergenciesControl:onClickCaoLing(guid)then
return true
elseif emergenciesControl:onClickGhost(guid)then
return true
elseif emergenciesControl:onClickRuiShou(guid)then
return true
end
end
end

function isometricMapSystem:checkTouchlockSundrise(guid,objType)
if isometricMapSystem:iseStillObject(objType)or objType==objectType.eMovementSundrise then
local data=self:getSundries(guid)
local stype=data.type
if stype==sundriseType.eStillEnemy or stype==sundriseType.eMovementEnemy then
UIManager:showWindow('UIChallengeWin',data)
return true
end

local cfg=cfgHelper.get1(cfg_monijyrandomitemconfig_get,data.id)
if cfg.win_type==1 then
UIManager:showWindow('UICollectWin',data)
return true
end

if stype==sundriseType.eBrand then
local sfId=zongmenModel:getMountainId()
self:openAreaUnLockWin(sfId,data.areaId,true)
return true
end

if stype==sundriseType.eMiJing then
UIManager:showWindow('UIMiJingWin',data)
return true
end
end
return false
end

function isometricMapSystem:checkTouchSundrise(guid,objType)
if isometricMapSystem:iseStillObject(objType)or objType==objectType.eMovementSundrise then
if self.layoutMode~=layoutMode.eDefault then
return false
end
local data=self:getSundries(guid)
if not data then
return false
end
local stype=data.type
local sfId=zongmenModel:getMountainId()
if stype==sundriseType.eStillSundrise or stype==sundriseType.eMovementSundrise then


self:startClearSundriesAI(data,1)
elseif stype==sundriseType.eStillEnemy or stype==sundriseType.eMovementEnemy then
if data.complete then
self:getMountRandomReward(sfId,data)
else
if data.battleId then
if fightController:openBattle(data.battleId)then
isometricMapSystem:enterBattleMode()
end
else
if isometricMapSystem:checkMonsterAIRecord(guid)then
UIManager.error("宗门弟子正在前往降妖，请祖师稍等片刻")
else
UIManager:showWindow('UIChallengeWin',data)
end
end
end
elseif stype==sundriseType.eRewardBox or stype==sundriseType.eBrand then
self:getMountRandomReward(sfId,data)
elseif stype==sundriseType.eMiJing then
UIManager:showWindow('UIMiJingWin',data)
end
return true
end
return false
end

function isometricMapSystem:checkTouchRepairBuilding(guid,inUnlockArea)
local repairData=self.repairDatas[guid]
if repairData then
if self.layoutMode==layoutMode.eDefault then
if repairData.type==3006 then
if inUnlockArea then
zongmenControl:reqBuild(repairData.mapId,repairData.id,repairData.x,repairData.y,repairData.orientation)
else
return false
end
elseif repairData.type==3002 then
local c1,c2=zongmenControl:getZhenYanCount(repairData.id,true)
if c1>=c2 then
local sfId=zongmenModel:getMountainId()
zongmenControl:reqBuild(sfId,repairData.id,repairData.x,repairData.y,0)
else
UIManager:showWindow('UIMiZhenWin',repairData)
end
elseif repairData.type==3003 then
if inUnlockArea then
UIManager:showWindow('UIZhenYanWin',{1,repairData})
end
elseif repairData.type==81 then
if inUnlockArea then
FeiShengTaiController.openFeiShengTaiRepairWin({1,repairData})

end
elseif repairData.type==82 or repairData.type==83 or repairData.type==84 or repairData.type==85 or repairData.type==86 then
if inUnlockArea then
FeiShengTaiController.openFeiShengTaiRepairWin({1,repairData})

end
elseif repairData.type==95 then
if inUnlockArea then
UIManager:showWindow('UIXianYunGangRepairWin',{1,repairData})
end
else
local cfg=cfgHelper.get1(cfg_monijybuildconfig_get,repairData.id)
if cfg.win_type==sysWinType.eXianMeng then
UIManager:showWindow('UIXMRepairWin',repairData)
elseif#cfg.repair_cost>1 and inUnlockArea then
if cantClickAtNotRepairBuildType[repairData.id]then

return false
end

if cantClickAtNotOpenSystem[repairData.id]then
if not systemModel.isOpen(cantClickAtNotOpenSystem[repairData.id])then
return false
end
end

UIManager:showWindow('UISectionRepair',{1,repairData})
else
if not repairData.lock then
if cantClickAtNotRepairBuildType[repairData.id]then

return false
end

if cantClickAtNotOpenSystem[repairData.id]then
if not systemModel.isOpen(cantClickAtNotOpenSystem[repairData.id])then
return false
end
end
UIManager:showWindow('UIRepairWin',repairData)
end
end
end
else
if not cantClickAtNotRepairBuildType[repairData.id]then
UIManager.info('请先修复建筑')
end
end
return true
end
if self:isRepairBuilding(guid)then
if self.layoutMode~=layoutMode.eDefault then
UIManager.info('建筑未修复完成')
return true
end
end
return false
end

function isometricMapSystem:checkTouchBuilding(guid)
if self.layoutMode~=layoutMode.eDefault then

return false
end

if self.editorMode~=editorMode.eDefault then

return false
end


local data=zongmenModel:findBuildingByEntityId(guid)
if data then
local sfId=zongmenModel:getBuildingLocationMapId(data.un_build_id)



if self:checkBuildState(sfId,data)then
return true
end

self:openBuildingWin(data)

return true
end

return false
end

function isometricMapSystem:checkTouchArea(screenPoint)
if not screenPoint or self.layoutMode~=layoutMode.eDefault then
return false
end
if fullScreenUI.isActiveFull()then

return false
end

local mapId=zongmenModel:getMountainId()
local areaId=_MapManager.GetAreaIDByScreenPoint(mapId,screenPoint)
if areaId>0 and self:isCanShowArea(areaId)then
if not zongmenModel:isAreaUnlock(areaId)then
self:openAreaUnLockWin(mapId,areaId,true)
return true
end
end
return false
end

function isometricMapSystem:openAreaUnLockWin(mapId,areaId,isReq)
if not mapId then
mapId=zongmenModel:getMountainId()
end
local acfg=cfgHelper.get1(cfg_monijyareaconfig_get,areaId)
local areaData=zongmenModel:getAreaData(mapId,areaId)
if not areaData then
return UIManager:showWindow('UIAreaUnlockWin',areaId)
elseif areaData and areaData.begintime>0 then
if isReq then
local curTime=gameUtilityModel.getServerShortTime()
if acfg.unlock_wait==0 or areaData.begintime+acfg.unlock_wait<=curTime then
zongmenControl:reqUnlockAreaComplete(mapId,areaId)
zongmenControl:playUnlockAreaPlot(areaId)
else
return UIManager:showWindow('UIAreaUnlockWaitWin',areaId)
end
else
return UIManager:showWindow('UIAreaUnlockWaitWin',areaId)
end
end
return true
end

function isometricMapSystem:checkLinkRoad(bdData,wraning)
local config=cfgHelper.get1(cfg_monijybuildconfig_get,bdData.build_id)
if config.is_connect_road~=1 then
return true
end
local ftype=zongmenModel:getBDFlagType(bdData.flag)
if not bdData.isLinkRoad and ftype==bdFlagType.normal then
if wraning then
UIManager.error('建筑未连接道路')
end
return false
end
return true
end

function isometricMapSystem:checkBuildState(sfId,data,justOpenUI)
local config=cfgHelper.get1(cfg_monijybuildconfig_get,data.build_id)
if config==nil then
UIManager.error('找不到建筑配置',data.build_id)
return true
end


local ftype=zongmenModel:getBDFlagType(data.flag)
local isBuild=ftype==bdFlagType.build

if not data.isLinkRoad and config.is_connect_road==1 and ftype==bdFlagType.normal then
UIManager:showWindow('UIRoadTipsWin')


return true
end

if emergenciesModel:isCreeper(data.un_build_id)then
UIManager.info('缠绕中无法使用')
return true
end









if buildingCDControl:isTiming(buildingCDType.zhalu,data.un_build_id)then
local check,least=UIDanYaoModel:checkZhaLu(data.un_build_id,DANYAO_ZHALU_SEASON.eDiscipleSpecial)
if check then
UIManager.info(FMT.fmt('丹炉已损毁，正在修复中（{0})',timeHelper.format_time_stamp(least,true)))
return true
end
elseif buildingCDControl:isComplete(buildingCDType.build,data.un_build_id)then
if not justOpenUI then
if self:completeBuildingProgress(sfId,data)then
return true
end
end
elseif buildingCDControl:isCanReceive(buildingCDType.zhifu,data.un_build_id)then

UIFullFuLuFangControl.reqOneKeyPrizeYuFu()
return true
elseif buildingCDControl:isCanReceive(buildingCDType.lianqi,data.un_build_id)then

fabaoProtocolControl.reqOneKeyPrizeFabao()
return true
elseif buildingCDControl:checkReceiveByFType(buildingCDFuncType.manufacture,data.un_build_id)then
if not justOpenUI then



if zongmenControl:receiveAllManufactureEx()then
UIShopControl:reqAutoCreateRecv(0)
return true
end
end
elseif buildingCDControl:isCanReceive(buildingCDType.liandan,data.un_build_id)then

UIDanYaoController:reqOneKeyPrize()
return true
elseif buildingCDControl:isCanReceive(buildingCDType.tiandaohecheng,data.un_build_id)then
tianDaoRongDingController.reqPrize()
return true
elseif buildingCDControl:isCanReceive(buildingCDType.shangpu,data.un_build_id)then
if not justOpenUI then
UIShopControl:reqAutoCreateRecv(0)
zongmenControl:receiveAllManufactureEx()
return true
end
end

local buildType=config.build_type
if buildType==SLG_SYSTEM_TYPE.eShouLan1 or buildType==SLG_SYSTEM_TYPE.eShouLan2 then

if UIShouLanModel:hasRewardCanReceive(data.un_build_id)then
UIShouLanControl:receiveSLReward(data.un_build_id)
return true
end
end

if isBuild then


local status=zongmenModel:getRepairStatusById(sfId,data.un_build_id)





if not status and status==repairStatus.eRepaired then
UIManager.info('正在建造中，请稍候')
return true
end
end

if emergenciesControl:isBuildingOnFire(data.entityId)then

emergenciesControl:toExtinguishing(data)

hudControl:refreshBuildingStatusHUD(data.un_build_id)
return true
end

if emergenciesModel:isInRepairTime(data.un_build_id)then
UIManager.info('修复中无法使用')
return true
end

if jctjDuJieXianDanModel:isInRepairTime(data.un_build_id)then
local currtime=gameUtilityModel.getServerShortTime()
local endtime=jctjDuJieXianDanModel:getRepairTime(data.un_build_id)
UIManager.info(FMT.fmt('丹炉被天劫损毁，正在修复中（{0})',timeHelper.format_time_stamp(endtime-currtime,true)))
return true
end

return false
end

local _openWinFuncA={
[SLG_SYSTEM_TYPE.eCangKu]=function(args)

UIFullCangKuControl:showWarehouseWindow(args.data)
end,
[SLG_SYSTEM_TYPE.eCangJingGe]=function(args)


UIFullCangJingGeControl:showEnterSelectWindow(args)
end,
[SLG_SYSTEM_TYPE.eFangShi]=function(args)

UIFullFairControl:showFairWindow(args.data)
end,
[SLG_SYSTEM_TYPE.eQianJiGe]=function(args)

UIFullQianJiGeControl:showMyWindowByBuild(args)
end,
[SLG_SYSTEM_TYPE.eXueShiShuYuan]=function(args)

local ret=UISchoolController:checkAndShowAutoClassResult()
if not ret then
UIFullSchoolControl:showSchoolMainWindow(args.data)
end
end,
[SLG_SYSTEM_TYPE.eYinXianTai]=function(args)


AudioManager.playBtnClick()
UIRecruitControl:showRecruitWindow({bdData=args.data,exArgs=args.args})
end,
[SLG_SYSTEM_TYPE.eFeiShengTai]=function(args)

UIFullFeiShengTaiControl:showFullFeiShengTaiWindow(args.data)
end,
[SLG_SYSTEM_TYPE.eZongMen]=function(args)

UIFullSectPalaceControl:showMyWindowByBuild(args,nil)
end,
[SLG_SYSTEM_TYPE.eShiLianTa]=function(args)


buildTiaoZhanControl:clickTiaoZhanBuild(args)
end,
[SLG_SYSTEM_TYPE.eBaoLingShu]=function(args)


UIFullBaoLingShuControl:showMainWindow(args)
end,
[SLG_SYSTEM_TYPE.eLaoYu]=function(args)

UIPrisonControl:showPrisonWindow(args)
end,
[SLG_SYSTEM_TYPE.eWuDaoTang]=function(args)

UIFullWuDaoTangControl:showMyWindow({entityID=args.data.entityId})
end,
[SLG_SYSTEM_TYPE.eLvFaTang]=function(args)

UIFullCourtroomControl:showFullWindow(args)
end,
[SLG_SYSTEM_TYPE.eLianDanFang]=function(args)

UIFullLianDanFangControl:showProductionWindow(args.data)
end,
[SLG_SYSTEM_TYPE.eDouFaTai]=function(args)

UIFullDouFaTaiControl:showDouFaTaiJumpWin(args)

end,
[SLG_SYSTEM_TYPE.eLianQiGe]=function(args)

UIFullLianQiGeControl:showMyWindowByBuild(args)
end,
[SLG_SYSTEM_TYPE.eShanMen]=function(args)



















local isOpenSys=systemModel.isOpen(SYSTEM_DEFINE.eShanMenDaZhen)
if isOpenSys and shanMenDaZhenModel:checkHaveShanmenDaZhen()then

UIFullShanMenControl:showDaZhenWindow()
else

if not shanmenModel:hasOptionEventNPCData()and not shanmenModel:hasBaiShanDZ()then

UIFullShanMenControl:showInfoWindow()
end
end
end,
[SLG_SYSTEM_TYPE.eWangShouTang]=function(args)

UIFullLingShouSelectControl:showLingShouSelectWindow()
end,
[SLG_SYSTEM_TYPE.eJiuLiDian]=function(args)

UIFullJiuLiDianControl:showRongHeWindow(args.data)
end,
[SLG_SYSTEM_TYPE.eYuShouFang]=function(args)

local isreddot,flag=yushoufangModel.hasReddotInfo(args.data.un_build_id)
if isreddot and flag==1 then
yushoufangController:send_3_227()
else
UIFullYuShouFangControl:showJPWindow(args.data)
end
end,
[SLG_SYSTEM_TYPE.eShenShouTa]=function(args)

UIFullWanLingTaControl:showMainWindow()
end,
[SLG_SYSTEM_TYPE.eTianGongGe]=function(args)


UIFullTianGongGeControl:showTGGWin(args)
end,
[SLG_SYSTEM_TYPE.eXianZhan]=function(args)

xianzhanController:enterXianZhanMap(args.data)
end,
[SLG_SYSTEM_TYPE.eDanRen]=function(args)
UIFullDanRenControl:showDzRoomWindow(args.data)
end,
[SLG_SYSTEM_TYPE.eDuoRen]=function(args)
UIFullDuoRenControl:showDzRoomWindow(args.data)
end,
[SLG_SYSTEM_TYPE.eGouWo]=function(args)
xianChongControl:showFastManufactureWin()
end,
[SLG_SYSTEM_TYPE.ePaiHangBang]=function(args)
UIFullZaoHuaTianBeiControl:showMainWindow(args.data)
end,
[SLG_SYSTEM_TYPE.eChuanSongZhen]=function(args)
local param={
entityId=args.data.entityId,
travel=args.args and args.args.travel or nil,
args=args,
data=args.data,
}

buildTiaoZhanControl:clickTiaoZhanBuild(param)
end,
[SLG_SYSTEM_TYPE.eXianMengDaDian]=function(args)
UIFullXianMengPalaceControl:showMyWindowByBuild(args)
end,
[SLG_SYSTEM_TYPE.eXianWuLou]=function(args)

AudioManager.playBtnClick()
xianmengController:openXianWuLouWin(nil,args)
end,
[SLG_SYSTEM_TYPE.eXianMengShanDian]=function(args)

AudioManager.playBtnClick()
xianmengController:showXMShop()
end,
[SLG_SYSTEM_TYPE.eChuanGongGe]=function(args)


UIChuanGongGeControl:showChuanGongGeWindowEx(args)
end,
[SLG_SYSTEM_TYPE.eShuWuDian]=function(args)


AudioManager.playBtnClick()
UIFullShuWuDianControl:showMyWindowByBuild(args,nil)
end,
[SLG_SYSTEM_TYPE.eXuanShangTai]=function(args)


AudioManager.playBtnClick()
UIXuanShangControl:showXuanShangWindow(args)
end,
[SLG_SYSTEM_TYPE.eBaGuaLu1]=function(args)

AudioManager.playBtnClick()
UIFullBaGuaLuControl:showMyWindowByBuild(args)
end,
[SLG_SYSTEM_TYPE.eFuLuFang]=function(args)
UIFullFuLuFangControl:openFuLuSystemWin(args)
end,
[SLG_SYSTEM_TYPE.eDiaoXiangBuild]=function(args)
UIManager:showWindow("UILDDiaoXiangShowWin",args.data)
end,
[SLG_SYSTEM_TYPE.eGuanJun1]=function(args)
UIManager:showWindow("UILDDiaoXiangShowWin",args.data)
end,
[SLG_SYSTEM_TYPE.eGuanJun2]=function(args)
UIManager:showWindow("UILDDiaoXiangShowWin",args.data)
end,
[SLG_SYSTEM_TYPE.eGuanJun3]=function(args)
UIManager:showWindow("UILDDiaoXiangShowWin",args.data)
end,

[SLG_SYSTEM_TYPE.eTianDaoRongLu]=function(args)

AudioManager.playBtnClick()
UIFullTianDaoRongLuControl:showMyWindowByBuild(args)
end,
[SLG_SYSTEM_TYPE.eHouShanMiJing]=function(args)
UIHuanJingControl:checkAndOpenSelectWin(args)
end,

[SLG_SYSTEM_TYPE.eTianDaoShu]=function(args)
UIFullTianDaoShuController:showMainWindow(args.data)
end,
[SLG_SYSTEM_TYPE.eWanBaoShangHui]=function(args)


AudioManager.playBtnClick()
UIFullWanBaoShangHuiController:showMainUI(args)
end,
[SLG_SYSTEM_TYPE.eTanXianDui]=function(args)



local cat_sysid=SYSTEM_DEFINE.eCatCatMiJing
local flag=false
if systemModel.isOpen(cat_sysid)then
MysteryController.send_4_81()
flag=wanBaoXunBaoDuiController:checkCatMijinTanShuoRuKou()
end

AudioManager.playBtnClick()
if systemModel.isOpen(cat_sysid)and flag then
UIManager:showWindow("UIWanBaoJumpWin")
else
UIFullWanBaoXunBaoDuiController:showMainUI(args)
end
end,

[SLG_SYSTEM_TYPE.eChengYuanHeJu]=function(args)
local actorId=xianmengModel:getHeJuActor(args.data.un_build_id)

if actorId then
if actorId==playerModel:getActorID()then


else
otherPlayerController:openOtherPlayerInfoWin(actorId,true,actorInterFromType.eXianMeng)
end
end
end,

[SLG_SYSTEM_TYPE.eXianXunBang]=function(args)

AudioManager.playBtnClick()
UIFullXMGongXunBangControl:showWindowReward(args.data)
end,

[SLG_SYSTEM_TYPE.eYueLongChi]=function(args)
UIAquariumControl:showAquariumWin(args)
end,
[SLG_SYSTEM_TYPE.eBingGongFang]=function(args)

UIFullBingGongChangControl:showMyWindowByBuild(args)
end,
[SLG_SYSTEM_TYPE.eShangHang]=function(args)
UIFullShangHangEnterController:showShangHangEnterWindow(args)
end,
[SLG_SYSTEM_TYPE.eDaoLv]=function(args)
UIFullDaoLvControl:showDzRoomWindow(args.data)
end,
[SLG_SYSTEM_TYPE.eFeiShengTai2]=function(args)
UIFullFeiShengTaiControl:showFullFeiShengTaiWindow(args.data)
end,

[SLG_SYSTEM_TYPE.eYiFangLingTian]=function(args)
UIFullYiFangLingTianControl:showFullYiFangLingTianWindow(args)
end,

[SLG_SYSTEM_TYPE.eDuJieZhiBaoJin]=function(args)
UIFullDuJieZhiBaoControl:showDJZBWindow({1,args.data})
end,

[SLG_SYSTEM_TYPE.eDuJieZhiBaoShui]=function(args)
UIFullDuJieZhiBaoControl:showDJZBWindow({1,args.data})
end,

[SLG_SYSTEM_TYPE.eDuJieZhiBaoMu]=function(args)
UIFullDuJieZhiBaoControl:showDJZBWindow({1,args.data})
end,

[SLG_SYSTEM_TYPE.eDuJieZhiBaoHuo]=function(args)
UIFullDuJieZhiBaoControl:showDJZBWindow({1,args.data})
end,

[SLG_SYSTEM_TYPE.eDuJieZhiBaoTu]=function(args)
UIFullDuJieZhiBaoControl:showDJZBWindow({1,args.data})
end,

[SLG_SYSTEM_TYPE.eYuLingZhai]=function(args)
UIFullYuLingZhaiControl:showMainWindow(args.data)
end,

[SLG_SYSTEM_TYPE.eJuTianYi]=function(args)
UIFullJuTianYiControl:showJuTianYiProduceWindow(args.data)
end,

[SLG_SYSTEM_TYPE.eTaiXuCang]=function(args)
UIFullTaiXuCangControl:showMainWindow(args.data)
end,

[SLG_SYSTEM_TYPE.eYunJiaYing]=function(args)
UIFullYunJiaYingControl:showYunJiaYingWindow(args.data)
end,

[SLG_SYSTEM_TYPE.eYingXianGe]=function(args)
UIFullYingXianGeControl:showYingXianGeWindow(args.data)
end,

[SLG_SYSTEM_TYPE.eLunHuiDian]=function(args)
UIFullLunHuiDianControl:showMainWindow(args.data)
end,

[SLG_SYSTEM_TYPE.eLittleWorld]=function(args)
UIFullLittleWorldControl:showTabWindow(args)
end,

[SLG_SYSTEM_TYPE.eXianYunGang]=function(args)

buildTiaoZhanControl:clickTiaoZhanBuild(args)
end,

[SLG_SYSTEM_TYPE.eBoat1]=function(args)
UIFullXianYunGangControl:showMainWindow(args.data)
end,

[SLG_SYSTEM_TYPE.eBoat2]=function(args)
UIFullXianYunGangControl:showMainWindow(args.data)
end,

[SLG_SYSTEM_TYPE.eBoat3]=function(args)
UIFullXianYunGangControl:showMainWindow(args.data)
end,

[SLG_SYSTEM_TYPE.eBoat4]=function(args)
UIFullXianYunGangControl:showMainWindow(args.data)
end,

[SLG_SYSTEM_TYPE.eTianShuDaZhen]=function(args)
UIFullTianShuDaZhenControl:showMainWindow(args.data)
end,

[SLG_SYSTEM_TYPE.eXianBang]=function(args)

AudioManager.playBtnClick()
UIFullXianBangControl:showXianBangWindow(args.data)
end,

[SLG_SYSTEM_TYPE.eTianShuDian]=function(args)
UIFullTianShuDianControl:showMainWindow(args.data)
end,

[SLG_SYSTEM_TYPE.eYanDaoTai]=function(args)
UIFullYanDaoTaiControl:showMainWindow(args.data)
end,

[SLG_SYSTEM_TYPE.eZaoWuGe]=function(args)
UIFullZaoWuGeControl:showMainWindow(args.data)
end,

[SLG_SYSTEM_TYPE.eYanFaGe]=function(args)
UIFullYanFaGeControl:showMainWindow(args)
end,












}

local _openWinFuncB={
[sysWinType.eFangAn]=function(args)

UIManufactureControl:showProductionWindow(args.data)
end,
[sysWinType.eZiRan]=function(args)

UINaturalControl:showNaturalWindow(args.data)
end,
[sysWinType.eJingGuang]=function(args)


end,
[sysWinType.eBuff]=function(args)


UIFullBuffBuildingControl:showBuffBuildingWindow(args.data)
end,
[sysWinType.eShangPu]=function(args)

if args.args and args.args.tabType==FULL_TAB_TYPE.eShopProduction then
UIShopControl:showShopProductionWindow(args.data)
else
UIShopControl:showShopWindow(args.data)
end
end,
[sysWinType.eZhenYan]=function(args)

UIManager:showWindow('UIZhenYanWin',{2,args.data})
end,
[sysWinType.eShouLan]=function(args)

if args.args and args.args.isOpenFeedingWin then
UIShouLanControl:showFeedingWindow(args)
else
UIShouLanControl:showMainWindow(args)
end
end,
[sysWinType.eSuitPart]=function(args)
UIManager:showWindow('UIBuildingSuitBuildingWin',args.data)
end,
[sysWinType.eQiYu]=function(args)
local sfId=zongmenModel:getMountainId()
local areaId=_MapManager.GetAreaIDByObject(args.data.entityId)
local bdcfg=cfgHelper.get1(cfg_monijybuildconfig_get,args.data.build_id)
local signData={MysteryEventSendType.eZongMenScene,sfId,args.data.un_build_id,areaId}
MysteryEventSystem.event_start(SYSTEM_DEFINE.eZongMenSceneQiYuEvent,bdcfg.qyEventId,{},signData)
end,
[sysWinType.eLingShouFengQiYu]=function(args)
local sfId=zongmenModel:getMountainId()
local areaId=_MapManager.GetAreaIDByObject(args.data.entityId)
local bdcfg=cfgHelper.get1(cfg_monijybuildconfig_get,args.data.build_id)
local signData={MysteryEventSendType.eZongMenScene,sfId,args.data.un_build_id,areaId}
MysteryEventSystem.event_start(SYSTEM_DEFINE.eLingShouFeng,bdcfg.qyEventId,{},signData)
end,
}

function isometricMapSystem:openBuildingWin(data,args)
if self.layoutMode~=layoutMode.eDefault and(args==nil or not args.isjump)then

return false
end


if MysteryModel:is_in_mystery()then
return false
end

if data.flag==1 then
if data.build_id==SLG_SYSTEM_TYPE.eWanBaoShangHui then

UIManager:showWindow('UIWanBaoShangHui_questionWin',data)
elseif data.build_id==SLG_SYSTEM_TYPE.eHouShanMiJing then
UIManager:showWindow('UIRepairCDWin',data)
elseif data.build_id==SLG_SYSTEM_TYPE.eXianYunGang then
UIManager:showWindow('UIXianYunGangRepairWin',{2,data})
elseif data.build_id==SLG_SYSTEM_TYPE.eShenShouTa then
local cfg=cfgHelper.get1(cfg_monijybuildconfig_get,SLG_SYSTEM_TYPE.eShenShouTa)
UIManager.info(string.format("%s正在修复中",cfg.name))
end

return true
end

if data.flag>10 then
if data.build_id==SLG_SYSTEM_TYPE.eFeiShengTai2 then
FeiShengTaiController.openFeiShengTaiRepairWin({2,data})

elseif data.build_id==SLG_SYSTEM_TYPE.eDuJieZhiBaoJin or data.build_id==SLG_SYSTEM_TYPE.eDuJieZhiBaoHuo or
data.build_id==SLG_SYSTEM_TYPE.eDuJieZhiBaoMu or data.build_id==SLG_SYSTEM_TYPE.eDuJieZhiBaoShui or
data.build_id==SLG_SYSTEM_TYPE.eDuJieZhiBaoTu then
FeiShengTaiController.openFeiShengTaiRepairWin({2,data})

else
UIManager:showWindow('UISectionRepair',{2,data})
end
return true
end

local cfg=cfgHelper.get1(cfg_monijybuildconfig_get,data.build_id)
local func
func=_openWinFuncA[cfg.id]
if not func then
local ptype=cfg.win_type
func=_openWinFuncB[ptype]
end
if func then
func({data=data,args=args})

return true
else
UIManager.error('这是什么建筑？')
return false
end
end

function isometricMapSystem:completeBuildingProgress(sfId,data)
local ftype=zongmenModel:getBDFlagType(data.flag)
if ftype==bdFlagType.build then

zongmenControl:reqBuildComplete(sfId,data.un_build_id)

return true
elseif ftype==bdFlagType.levelUp or ftype==bdFlagType.sectionBuildStart then

zongmenControl:reqBuildingLevelUpComplete(sfId,data.un_build_id)

return true
else

if data.build_id==SLG_SYSTEM_TYPE.eLianDanFang then

UIDanYaoController:reqOneKeyPrize()

return true
elseif data.plant_id==0 and data.build_id==SLG_SYSTEM_TYPE.eLianQiGe then

fabaoProtocolControl.reqOneKeyPrizeFabao()

return true
elseif data.plant_id==0 and data.build_id==SLG_SYSTEM_TYPE.eTianDaoRongLu then
tianDaoRongDingController.reqPrize()

return true
end
if data.plant_id>0 then
return zongmenControl:getPlantRewards(sfId,data)
else
return zongmenControl:getNaturalRewards(sfId,data)
end
end
end

function isometricMapSystem.on_long_tap_start(fingerIndex,touchCount,screenPoint,guid)
loggerUtil.log('on_long_tap_start',fingerIndex,touchCount)
if isometricMapSystem:isCanControl()and touchCount==1 then
_on_long_touch=true
isometricMapSystem:onLongTapStart(screenPoint,guid)

lingShouAIManager:onLongTapStart(screenPoint,guid)
end
end

function isometricMapSystem:onLongTapStart(screenPoint,guid)
local mapId=zongmenModel:getMountainId()
if mapId==mapIdType.zhufeng_hy then
return
end
if self.layoutMode==layoutMode.eDefault then
local objType=_MapManager.GetObjectType(guid)
if objType==objectType.ePlaceObject then
if mapId==mapIdType.xianmeng and not xianmengModel:checkPostSelfPrivile(GUILD_PRIVILE_TYPE.gptBuild)then
return
end

if self:isRepairBuilding(guid)then
if self.repairDatas[guid]then
local repairData=self.repairDatas[guid]
if cantClickAtNotRepairBuildType[repairData.id]then

return
end

if cantClickAtNotOpenSystem[repairData.id]then
if not systemModel.isOpen(cantClickAtNotOpenSystem[repairData.id])then
return false
end
end
end
UIManager.error('该建筑未修复，不可调整')
return
end
local sfId=zongmenModel:getMountainId()
if tiandaoshuController:isTianDaoShuBuilding(sfId,guid)then
return
end
local cfg=zongmenModel:getConfigByEntityId(sfId,guid)
if not cfg then
logErr(FMT.fmt('获取放置物配置失败，地图ID：{0} 实体ID：{1}',sfId,guid))
return
end
if cfg.is_move==0 then
return
end
local hud=hudControl:addHUD(INSTANCE_TYPE.ePickUp,guid,Vector3(0,2,0),false,true,function(hud)
local hudNode=hudControl:getHUDWidget(hud)
hudNode:SetChildIconFillAmount(0,0)
_tweener=hudNode:SetChildImageDOFillAmount(0,1,1,function()
self:enterLayoutModel({model=layoutMode.eLayout,entity=guid})
local pos=self:screenToMapPos(screenPoint)
self.endPos=pos
self:onLongTapEnd(screenPoint)
end)
end)

_longTapTarget={guid=guid,hudId=hud}
end
end
end

function isometricMapSystem.on_long_tap_end(fingerIndex,touchCount,screenPoint)
loggerUtil.log('on_long_tap_end',fingerIndex,touchCount)
if isometricMapSystem:isCanControl()and touchCount==1 then
isometricMapSystem:onLongTapEnd(screenPoint)

lingShouAIManager:onLongTapEnd(screenPoint)
end
end

function isometricMapSystem:onLongTapEnd(screenPoint)
if _longTapTarget then
if _tweener then
_tweener:Kill()
_tweener=nil
end
hudControl:removeHUD(_longTapTarget.hudId)
_longTapTarget=nil
end
end


function isometricMapSystem.onScreenSulotionChange(preWidth,preHeight,width,height)
isometricMapSystem.adjustCameraSize(preWidth,preHeight,width,height)
end

function isometricMapSystem.adjustCameraSize(preWidth,preHeight,width,height)
if resolutionUtility.enableMinAspect then
local curSize=_MapManager.GetCameraOrthographicSize()
local preAspect=math.max(1,math.min(preWidth/preHeight,resolutionUtility.curMinAspect))
local curAspect=math.max(1,math.min(width/height,resolutionUtility.curMinAspect))
local preScale=1+((resolutionUtility.curMinAspect-preAspect)/(resolutionUtility.curMinAspect-1))/resolutionUtility.curMinAspect
local curSacle=1+((resolutionUtility.curMinAspect-curAspect)/(resolutionUtility.curMinAspect-1))/resolutionUtility.curMinAspect

local minSize=_min_orthographic_size*curSacle
local maxSize=_max_orthographic_size*curSacle
isometricMapSystem:changeCameraOrthoSize((curSize/preScale)*curSacle,minSize,maxSize)
end
end



function isometricMapSystem:checkAndRecoverRoad(bdData)
local mapId=zongmenModel:getMountainId()
local cfg=cfgHelper.get1(cfg_monijybuildconfig_get,bdData.build_id)
local size=cfg.buid_size
local list
for i=0,size[1]-1 do
for j=0,size[2]-1 do
local x=bdData.x+i
local y=bdData.y+j
local rdata,key=zongmenModel:getRoadData(mapId,x,y)
if rdata then
if not list then
list={}
end
list[key]=rdata
end
end
end
if list then
isometricMapSystem:drawRoad(mapId,list)
end
end

function isometricMapSystem:onPickUpBuilding(guid,bdData,callback,skyModel)
local cfg=cfgHelper.get1(cfg_monijybuildconfig_get,bdData.build_id)

self:pickUpFromMap(guid,cfg.etype)
if not skyModel then
self:checkAndRecoverRoad(bdData)
end
self:playBuildAnimation(guid,cfg.etype)
_dragTarget=guid

self:setPlaceObject(guid)
self:setEditorMode(editorMode.ePlace)

local building={guid=guid,cfg=cfg,orientation=bdData.orientation,bdData=bdData,type=2}
self:setPreviewBuilding(building)

hudControl:setHUDShow(bdData.un_build_id,false)

if _MapManager.IsNearbyScreenBorder(guid,{0.1,0.3,0.1,0.1})then
isometricMapSystem:moveCameraToObject(guid,true,nil,0.5,_Ease.OutCubic)
end

hudControl:addHUD(INSTANCE_TYPE.eBuilding,guid,Vector3(0,cfg.height,0),true,true,function(hud)
building.hudId=hud
callback(building)
end)
end

function isometricMapSystem:cancelPickUp(skyModel)
local building=self:getPreviewBuilding()
if not building then
return
end
local guid=building.guid
local bdData=building.bdData
_MapManager.SetPosition(guid,_MapManager.ToVector3Int(bdData.x,bdData.y,0))
if bdData.orientation~=building.orientation then
isometricMapSystem:setflipX(guid,bdData,bdData.orientation==1)
end
if skyModel then
_MapManager.PlaceToMap(guid,conditionConfig.skyPlace)
_MapManager.SetSortingLayer(guid,SortingLayers.ITSkyBD)
else
self:placeToMap(guid,building.cfg.etype)
end

buildingEffectControl:playEffectByEID(guid,building.cfg.id,buildEffectType.ePlace)

if building.hudId then
hudControl:removeHUD(building.hudId)
else
logErr(FMT.fmt('[isometricMapSystem][cancelPickUp]hudId为nil，建筑ID：{0} 实体ID：{1}',bdData.un_build_id,bdData.entityId))
end

hudControl:setHUDShow(bdData.un_build_id,true)

self:clearStatus()
end

function isometricMapSystem:applyMove(data,actor)
if _MapManager.IsPlace(data.entityId)then
_MapManager.PickUpFromMap(data.entityId)
self:checkAndRecoverRoad(data)
end
_MapManager.SetPosition(data.entityId,_MapManager.ToVector3Int(data.x,data.y,0))
isometricMapSystem:setflipX(data.entityId,data,data.orientation==1)
local cfg=cfgHelper.get1(cfg_monijybuildconfig_get,data.build_id)
self:placeToMap(data.entityId,cfg.etype)
hudControl:setHUDShow(data.un_build_id,true)
buildingEffectControl:playEffectByEID(data.un_build_id,data.build_id,buildEffectType.ePlace)

local target=self.previewBuilding
if target then
if target.guid==data.entityId then
if actor~=nil and actor~=playerModel:getActorID()then
UIManager.info(FMT.fmt("该建筑已被其他玩家移动"))
end
self:clearStatus()
end
else
self:clearStatus()
end


if cfg.win_type==8 then
if tostring(data.dizi_id)~='0'then
aiManager:resetFeedingAI(data.dizi_id)
end
end
end

function isometricMapSystem:applyStorage(data,actor)
buildingEffectControl:playEffectByEID(data.entityId,data.build_id,buildEffectType.eDelete,nil,true)

local target=self.previewBuilding
if target then
if target.guid==data.entityId then
if actor~=nil and actor~=playerModel:getActorID()then
UIManager.info(FMT.fmt("该建筑已被其他玩家收纳"))
end
self:clearStatus(true)
end
else
self:clearStatus(true)
end

if _MapManager.IsPlace(data.entityId)then
_MapManager.PickUpFromMap(data.entityId)
self:checkAndRecoverRoad(data)
end

isometricMapSystem:clear3DModelByEID(data.entityId)
_MapManager.RemoveTilemapObject(data.entityId)

self:removeBuildingBehaviorByIdEx(data.entityId)
end

function isometricMapSystem:applySkyStorage(data)
buildingEffectControl:playEffectByEID(data.entityId,data.build_id,buildEffectType.eDelete,nil,true)

self:clearStatus(true)

if _MapManager.IsPlace(data.entityId)then
_MapManager.PickUpFromMap(data.entityId)
end
isometricMapSystem:clear3DModelByEID(data.entityId)
_MapManager.RemoveTilemapObject(data.entityId)

self:removeBuildingBehaviorByIdEx(data.entityId)
end

function isometricMapSystem:applyDelete(data,actor)
if data.entityId then
buildingEffectControl:playEffectByEID(data.entityId,data.build_id,buildEffectType.eDelete,nil,true)

local target=self.previewBuilding
if target then
if target.guid==data.entityId then
if actor~=nil and actor~=playerModel:getActorID()then
UIManager.info(FMT.fmt("该建筑已被其他玩家摧毁"))
end
self:clearStatus(true)
end
else
self:clearStatus(true)
end

if _MapManager.IsPlace(data.entityId)then
_MapManager.PickUpFromMap(data.entityId)
self:checkAndRecoverRoad(data)
end
isometricMapSystem:clear3DModelByEID(data.entityId)
_MapManager.RemoveTilemapObject(data.entityId)
end
end















































function isometricMapSystem:isBuildingInBuffArea(buffBuilding,building)
return _MapManager.IsBuildingInBuffArea(buffBuilding,building)
end

function isometricMapSystem:setBenefitBuffBuilding(bdData,ubdId,isRemove)




















if bdData and not isRemove then
local buffBuildingCfg=cfgHelper.get1(cfg_zengyijianzhuconfig_get,bdData.build_id)
if buffBuildingCfg then

local buffEffect=buffBuildingCfg.effects[bdData.level]
if buffEffect then
for i,v in ipairs(buffEffect)do
local buffEffectType=v[1]
local buffData=nil

buffData=v
zongmenModel:setBenefitBuildingBuffList(buffEffectType,bdData.un_build_id,buffData,i)
end
else
logErr(FMT.fmt("找不到增益建筑id: {0} 等级: {1}对应的效果配置",bdData.build_id,bdData.level))
end
end
else
if isRemove then
zongmenModel:removeBenefitBuildingBuffListByUbdId(ubdId)
end
end
end

function isometricMapSystem:setBenefitBuffBuildingById(sfId,ubdId,isRemove)
local bdData=zongmenModel:getBuildingData(ubdId)
self:setBenefitBuffBuilding(bdData,ubdId,isRemove)
end

function isometricMapSystem:resetAllBenefitBuffBuilding()
local sfId=zongmenModel:getMountainId()
local buildingDatas=zongmenModel:getAllBuildingData(sfId)
for k,v in pairs(buildingDatas)do
self:setBenefitBuffBuilding(v)
end
end

function isometricMapSystem:setDiscipleCheckInData(bdData)
if bdData.build_id==SLG_SYSTEM_TYPE.eDuoRen then

if bdData.caveGeziList then
for i,w in ipairs(bdData.caveGeziList)do
w.dzIdStr=tostring(w.dizi_id)
zongmenModel:setHomelessRecord(w.dizi_id,nil)
end
end
elseif bdData.build_id==SLG_SYSTEM_TYPE.eDanRen then

if bdData.caveGeziList then
for i,w in ipairs(bdData.caveGeziList)do
w.dzIdStr=tostring(w.dizi_id)
zongmenModel:setHomelessRecord(w.dizi_id,nil)
end
end
end
end





function isometricMapSystem:getDoorWayPos(bdData)
local posArr=_MapManager.GetObjectPlacePosValue(bdData.entityId)
if not posArr then
return nil
end
local cfg=cfgHelper.get1(cfg_monijybuildconfig_get,bdData.build_id)
local offset=cfg.doorway
local add=offset[2]>0 and-1 or 1
local tpos
local ipos
if bdData.orientation==0 then
tpos=_MapManager.ToVector3Int(posArr[1]+offset[1],posArr[2]+offset[2],0)
ipos=_MapManager.ToVector3Int(posArr[1]+offset[1],posArr[2]+offset[2]+add,0)
else
tpos=_MapManager.ToVector3Int(posArr[1]+offset[2],posArr[2]+offset[1],0)
ipos=_MapManager.ToVector3Int(posArr[1]+offset[2]+add,posArr[2]+offset[1],0)
end
local mapId=_MapManager.GetObjectMapID(bdData.entityId)
if not _MapManager.IsCanMove(mapId,ipos,6)then
local bpos=_MapManager.GetTilemapObjectPosition(bdData.entityId)
ipos=bpos
tpos=bpos
else
if not _MapManager.IsCanMove(mapId,tpos)then
tpos=ipos
end
end
return tpos,ipos
end





function isometricMapSystem:getDoorWayPos_ShouLanInside(bdData)
local posArr=_MapManager.GetObjectPlacePosValue(bdData.entityId)
if not posArr then
return nil
end
local cfg=cfgHelper.get1(cfg_monijybuildconfig_get,bdData.build_id)
local offset=cfg.doorway
local add=offset[2]>0 and-1 or 1
local add2=offset[2]>0 and-2 or 2
local tpos
local ipos
if bdData.orientation==0 then
tpos=_MapManager.ToVector3Int(posArr[1]+offset[1],posArr[2]+offset[2]+add2,0)
ipos=_MapManager.ToVector3Int(posArr[1]+offset[1],posArr[2]+offset[2]+add,0)
else
tpos=_MapManager.ToVector3Int(posArr[1]+offset[2]+add2,posArr[2]+offset[1],0)
ipos=_MapManager.ToVector3Int(posArr[1]+offset[2]+add,posArr[2]+offset[1],0)
end
local mapId=_MapManager.GetObjectMapID(bdData.entityId)
if not _MapManager.IsCanMove(mapId,ipos,6)then
local bpos=_MapManager.GetTilemapObjectPosition(bdData.entityId)
ipos=bpos
tpos=bpos
else
if not _MapManager.IsCanMove(mapId,tpos,8)then
tpos=ipos
end
end
return tpos,ipos
end





function isometricMapSystem:getDoorWayNBPos(bdData)
local posArr=_MapManager.GetObjectPlacePosValue(bdData.entityId)
if not posArr then
return nil
end
local cfg=cfgHelper.get1(cfg_monijybuildconfig_get,bdData.build_id)
local des=cfg.buid_size[1]-1
local rpos
local lpos
if bdData.orientation==0 then
rpos=_MapManager.ToVector3Int(posArr[1],posArr[2]-1,0)
lpos=_MapManager.ToVector3Int(posArr[1]+des,posArr[2]-1,0)
else
rpos=_MapManager.ToVector3Int(posArr[1]-1,posArr[2]+des,0)
lpos=_MapManager.ToVector3Int(posArr[1]-1,posArr[2],0)
end
local mapId=_MapManager.GetObjectMapID(bdData.entityId)
if not _MapManager.IsCanMove(mapId,rpos)or not _MapManager.IsCanMove(mapId,lpos)then
rpos,lpos=self:getDoorWayPos(bdData)
end
return rpos,lpos
end

function isometricMapSystem:checkAndGetFlyData(dzId,guid,pos,state,init)
local dzData=UIDiscipleModel:getDiscipleData(dzId)
if not dzData then
return nil
end


local dzpos=dzData.pos

local defaltId=cfgHelper.get2(cfg_guildposconfig_get,dzpos,'flymount')

local post=mountHelper.getFlyMountId(dzId)

post=post or defaltId










if not init and state==2 then return post end


if not mountHelper.isCanDressByJingjie(dzId)then return end


local flyCfg=cfgHelper.get1(cfg_discipleflyconfig_get,1)
if not flyCfg.post[dzpos]then return end

if not init then

local spos=_MapManager.GetTilemapObjectPosition(guid)
local mapId=_MapManager.GetObjectMapID(guid)
local distance=_MapManager.CountPositionDistance(mapId,spos,pos,flyCfg.distance[2])
if distance<flyCfg.distance[1]then
return nil
end


if math.random()>flyCfg.probability then
return nil
end
end

return post
end

function isometricMapSystem:moveToPosition(dzId,guid,pos,callback,stepCB,speed,config,state,moveType)
moveType=moveType or eAIMoveType.eDefault

local isFly=moveType==eAIMoveType.eFly
local post=self:checkAndGetFlyData(dzId,guid,pos,isFly and 2 or state)
if not api_Available_SetRoleMoveArgs()then
if post then

_MapManager.SetRoleFlyArgs(guid,1,post,0)
else
_MapManager.SetRoleFlyArgs(guid,-1,0,0)
end
end

local dzType=aiManager:getAIDZType(dzId)
if dzType==eAIDZType.eDefault then
if moveType==eAIMoveType.eDefault then
if post then

self:flyToPosition(guid,pos,callback,stepCB)
return 2
else
_MapManager.MoveToPosition(guid,pos,callback,stepCB,speed,config or-1)
return 1
end
elseif isFly then
self:flyToPosition(guid,pos,callback,stepCB)
return 2
else
_MapManager.MoveToPosition(guid,pos,callback,stepCB,speed,config or-1)
return 1
end
else
_MapManager.MoveToPosition(guid,pos,callback,stepCB,speed,config or-1)
return 1
end
end

function isometricMapSystem:flyToPosition(guid,pos,callback,stepCB)
if stepCB then
stepCB(3,false)
end
_MapManager.FlyToPosition(guid,pos,function(cbType)
if stepCB then
stepCB(3,true)
end
if callback then
callback(cbType)
end
end)
end

function isometricMapSystem:rayHitEntity(screenPos)
if not self.isInit then return end
return _MapManager.RayHitEntity(screenPos)
end


function isometricMapSystem:isMirrorModel(modelId)
local mirrormodel=cfgHelper.get2(cfg_dbbodyconfig_get,modelId,'mirrormodel')
return mirrormodel~=nil
end


function isometricMapSystem:getMirrorModel(modelId)
local mirrormodel=cfgHelper.get2(cfg_dbbodyconfig_get,modelId,'mirrormodel')
return mirrormodel
end



function isometricMapSystem:getMirrorModelByflip(modelId,flip)
local mirrormodel=cfgHelper.get2(cfg_dbbodyconfig_get,modelId,'mirrormodel')
if flip and mirrormodel then
modelId=mirrormodel
end
return modelId,mirrormodel~=nil
end

function isometricMapSystem:checkAndStopAnim(etype,guid,cfgId)
if webGLHelper:isRunWebGL()then
local allow_anim_webgl
if etype==1 then
allow_anim_webgl=cfgHelper.get2(cfg_monijybuildconfig_get,cfgId,'allow_anim_webgl')
else
local cfg=cfgHelper.get1(cfg_monijyrandomitemconfig_get,cfgId)
allow_anim_webgl=cfg.type==sundriseType.eStillEnemy or cfg.allow_anim_webgl
end
if not allow_anim_webgl then

local ent=_EntityManager:GetEntity(guid)
ent:SetFreezeAnimation(true)
end
end
end

function isometricMapSystem:createBuildingEntity(otype,mapId,cfgId,modelId,slots,sortingLayer,isPlace,flip,scale,pos,offset,pCfgId)
if isPlace==nil then isPlace=true end
flip=flip or false
scale=scale or 0.4
if not pos then
logErr('isometricMapSystem:createPlaceObjectEntity','传入pos不应为空')
return
end
offset=offset or Vector3.zero
pCfgId=pCfgId or-1
local modelId=isometricMapSystem:getMirrorModelByflip(modelId,flip)
local loadID=loadControl.markLoadObj(modelId)
local action=function()loadControl.LoadObjFinish(loadID)end
local entity=_MapManager.CreateBuilding(otype,cfgId,modelId,slots,sortingLayer,isPlace,flip,scale,mapId,pos,offset,pCfgId,action)
isometricMapSystem:checkAndStopAnim(1,entity,cfgId)
return entity
end


function isometricMapSystem:createPlaceObjectEntity(otype,mapId,cfgId,modelId,slots,sortingLayer,flip,scale,pos,offset,pCfgId)
flip=flip or false
scale=scale or 0.4
if not pos then
logErr('isometricMapSystem:createPlaceObjectEntity','传入pos不应为空')
return
end
offset=offset or Vector3.zero
pCfgId=pCfgId or-1
local modelId=isometricMapSystem:getMirrorModelByflip(modelId,flip)
local loadID=loadControl.markLoadObj(modelId)
local action=function()loadControl.LoadObjFinish(loadID)end
local entityGUID=_MapManager.CreatePlaceObject(otype,cfgId,modelId,slots,sortingLayer,flip,scale,mapId,pos,offset,pCfgId,action)
isometricMapSystem:checkAndStopAnim(2,entityGUID,cfgId)
return entityGUID
end

function isometricMapSystem:createRoleEntity(otype,mapId,cfgId,modelId,slots,sortingLayer,scale,pos,offset,small)
scale=scale or 0.4
if not pos then
logErr('isometricMapSystem:createPlaceObjectEntity','传入pos不应为空')
return
end
offset=offset or Vector3.zero
local loadID=loadControl.markLoadObj(modelId)
local action=function()loadControl.LoadObjFinish(loadID)end
local guid=_MapManager.CreateRole(otype,cfgId,modelId,slots,sortingLayer,scale,mapId,pos,offset,action,small or false)
if api_Available_SetRoleMoveArgs()then
local flag=aiManager:getAutoToFlyFlag()
_MapManager.SetRoleMoveArgs(guid,{1,7,0,flag})
end
if webGLHelper:isRunMiniGame()then
if self.freezeAnimationFlag then
if self.freezeAnimationCheckTypesDict[otype]then
local ent=_EntityManager:GetEntity(guid)
ent:SetFreezeAnimation(true)
end
end
end
return guid
end

function isometricMapSystem:createModelEntity(bodyID)
local loadID=loadControl.markLoadObj(bodyID)
local action=function()loadControl.LoadObjFinish(loadID)end
return _EntityManager:Add3DEntity(bodyID,action)
end

function isometricMapSystem:createLingShouRoleEntity(otype,mapId,cfgId,modelId,slots,sortingLayer,scale,pos,offset,small,isCanFly)
scale=scale or 0.4
if not pos then
logErr('isometricMapSystem:createPlaceObjectEntity','传入pos不应为空')
return
end
offset=offset or Vector3.zero
local loadID=loadControl.markLoadObj(modelId)
local action=function()loadControl.LoadObjFinish(loadID)end
local guid=_MapManager.CreateRole(otype,cfgId,modelId,slots,sortingLayer,scale,mapId,pos,offset,action,small or false)
if api_Available_SetRoleMoveArgs()then
local flag=isCanFly and aiManager:getAutoToFlyFlag()or 0
_MapManager.SetRoleMoveArgs(guid,{1,7,0,flag})
end
if webGLHelper:isRunMiniGame()then
if self.freezeAnimationFlag then
if self.freezeAnimationCheckTypesDict[otype]then
local ent=_EntityManager:GetEntity(guid)
ent:SetFreezeAnimation(true)
end
end
end
return guid
end


function isometricMapSystem:testFly()
self.testFlyModel=true
end
