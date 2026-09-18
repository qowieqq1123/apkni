
buildingEffectControl=gameState.addListener({})

buildEffectType={
eLevelUp=1,
ePlace=2,
eProduce=3,
eProduceSuccess=4,
eProduceFailure=5,
eLianDanZhong=6,
eDanJie=7,
eFire=8,
eDelete=9,
eWuDaoTang=10,
eBuff=11,
eMaoYan=12,
eFanYan=13,
eChanRao=14,
ePemanent=15,
eRegular=16,
eYanDaoTai=17,
}





local _effect_deffine={
[buildEffectType.eProduce]={
play_when_enter_home=function(bdData)
if bdData.planStatus==planStatus.eStart or bdData.planStatus==planStatus.eComplete then
buildingEffectControl:playEffectByEID(bdData.entityId,bdData.build_id,buildEffectType.eProduce)
end
end,
keep_playing=true,
},
[buildEffectType.eWuDaoTang]={
play_when_enter_home=function(bdData)
if bdData.build_id==SLG_SYSTEM_TYPE.eWuDaoTang then
wudaotangController:refreshBuildEffct(bdData,true)
end
end,
keep_playing=true,
},
[buildEffectType.eLianDanZhong]={
keep_playing=true,
play_when_enter_home=function(bdData)
if bdData.build_id==SLG_SYSTEM_TYPE.eLianDanFang then
UIDanYaoController:refreshBuildEffct(bdData)
end
end,
},
[buildEffectType.eFanYan]={
keep_playing=true,
play_when_enter_home=function(bdData)
if bdData.build_id==SLG_SYSTEM_TYPE.eYuShouFang then
local data=yushoufangModel:getData(bdData.un_build_id)
if yushoufangModel:isStartMating(data)then
buildingEffectControl:playEffectByEID(bdData.entityId,SLG_SYSTEM_TYPE.eYuShouFang,buildEffectType.eFanYan)
end
end
end,
},
[buildEffectType.eDanJie]={
keep_playing=true,
play_when_enter_home=function(bdData)
if bdData.build_id==SLG_SYSTEM_TYPE.eLianDanFang then
UIDanYaoController:refreshBuildEffct(bdData)
end
end,
},
[buildEffectType.eFire]={
keep_playing=true,
},
[buildEffectType.eMaoYan]={
keep_playing=true,
},
[buildEffectType.eChanRao]={
keep_playing=true,
},
[buildEffectType.eBuff]={
play_when_enter_home=function(bdData)




local sfId=_MapManager.GetObjectMapID(bdData.entityId)
buildingEffectControl:refreshBuildingBuffEffect(sfId,bdData.un_build_id)
end,
keep_playing=true,
},
[buildEffectType.ePemanent]={
keep_playing=true,
},
[buildEffectType.eRegular]={
keep_playing=true,
},
}

function buildingEffectControl:onEnterState(isReconnect)
if isReconnect then
return
end

self.effectDatas={}
end

function buildingEffectControl:onLeaveState(isReconnect)
if isReconnect then
return
end

end









function buildingEffectControl:onEnterHome()
self.effectDatas={}
self:checkAllBuilding()
notifySystem:listenNotify(notifyConfig.building_event,self.on_building_event)
end

function buildingEffectControl:onLeaveHome()
self.effectDatas={}
notifySystem:removelistener(notifyConfig.building_event,self.on_building_event)
end

function buildingEffectControl.on_building_event(etype,sfId,bdId,arg1,arg2)
if etype==buildingEvent.removeBuilding or etype==buildingEvent.storageBuilding then
buildingEffectControl:stopLoopEffect(sfId,bdId)
end
end

function buildingEffectControl:checkAllBuilding()
local datas=zongmenModel:getAllBuildingData(zongmenModel:getMountainId())
for k,v in pairs(datas)do
for kk,vv in pairs(_effect_deffine)do
if vv.play_when_enter_home then
vv.play_when_enter_home(v)
end
end
end
end










function buildingEffectControl:playEffectByEID(entityId,cfgId,etype,offset,playInPos,scale,skinId)
if not entityId then
logErr('[buildingEffectControl][playEffectByEID]播放特效的实体ID为nil，请确保实体已创建，若特效播放异常需处理')
return
end
if webGLHelper:isHidePunchAni()then
if etype==buildEffectType.eProduce then return end
end

local cfg=cfgHelper.get1(cfg_monijybuildconfig_get,cfgId)
if cfg.effect then
local effectId
if cfgId==4 and etype==3 then
if not skinId then
local bdData=zongmenModel:findBuildingByEntityId(entityId)
if bdData then
local skinIdStr=tostring(bdData.build_appearance_id)
effectId=cfg.effect[etype][skinIdStr]
else
effectId=cfg.effect[etype]
end
else
local skinIdStr=tostring(skinId)
effectId=cfg.effect[etype][skinIdStr]
end
else
effectId=cfg.effect[etype]
end
if effectId then
if not offset and cfg.effectArgs then
local args=cfg.effectArgs[etype]
if args and args.offset then
offset=Vector3.New(args.offset[1],args.offset[2],0)
end
end
local defData=_effect_deffine[etype]
local id
local stopFun
if playInPos then
local pos=_MapManager.GetObjectAreaC(entityId)
if offset then
pos=Vector3.New(pos.x+offset.x,pos.y+offset.y,pos.z+offset.z)
end
id=_MapManager.PlayEffectByPos(pos,effectId)
else
if api_Available_DisableAllEffect()then
local effectScale=scale and Vector3.New(scale,scale,scale)or Vector3.one
id=_MapManager.PlayEffectOnActor(entityId,effectId,'root',offset or Vector3.zero,effectScale)
stopFun=_MapManager.RemoveEffectOnActor
else
id=_MapManager.PlayEffect(entityId,effectId,offset or Vector3.New(0,0,0),true,true)
end
end
if defData and defData.keep_playing then
local edatas=self.effectDatas[entityId]or{}

if edatas[etype]then
self:stopEffect(entityId,etype)
end
edatas[etype]={id,stopFun}
self.effectDatas[entityId]=edatas
end
end
end
end

function buildingEffectControl:playEffectByBDID(sfId,bdId,etype,offset,playInPos)
local bdData=zongmenModel:getBuildingData(bdId)
self:playEffectByEID(bdData.entityId,bdData.build_id,etype,offset,playInPos)
end

function buildingEffectControl:stopEffect(entityId,etype)
local edatas=self.effectDatas[entityId]
if edatas then
local effectStopInfo=edatas[etype]
if effectStopInfo then
local id=effectStopInfo[1]
local func=effectStopInfo[2]
if func~=nil then
func(entityId,id)
else
_stopEffect(id)
end

edatas[etype]=nil
end
end
end



function buildingEffectControl:stopLoopEffect(sfId,bdId)
local bdData=zongmenModel:getBuildingData(bdId)
if bdData then
for k,v in pairs(_effect_deffine)do
if v.keep_playing then
self:stopEffect(bdData.entityId,k)
end
end
end
end

function buildingEffectControl:getPlayBenefitBuildingList(sfId,bdId)
local bdData=zongmenModel:getBuildingData(bdId)
return _MapManager.GetBenefitBuildingList(bdData.entityId)
end

function buildingEffectControl:playBenefitBuildingEffect(sfId,blist)
if blist then
for i,v in ipairs(blist)do
local tdata=zongmenModel:findBuildingByEntityId(v)
self:refreshBuildingBuffEffect(sfId,tdata.un_build_id)
end
end
end

function buildingEffectControl:refreshBuildingBuffEffect(sfId,bdId)
local bdData=zongmenModel:getBuildingData(bdId)
local cfg=cfgHelper.get1(cfg_monijybuildconfig_get,bdData.build_id)
if cfg.benefit_type then
local datas=zongmenModel:getBuffBuildingBenefitList(bdData)
if next(datas)then
self:playEffectByEID(bdData.entityId,bdData.build_id,buildEffectType.eBuff)
else
self:stopEffect(bdData.entityId,buildEffectType.eBuff)
end
else
local blist=_MapManager.GetBenefitBuildingList(bdData.entityId)
if blist then
for i,v in ipairs(blist)do
local tdata=zongmenModel:findBuildingByEntityId(v)
self:refreshBuildingBuffEffect(sfId,tdata.un_build_id)
end
end
end








end










function buildingEffectControl:removeBuildingBuffEffect(sfId,bdId)
local bdData=zongmenModel:getBuildingData(bdId)
local cfg=cfgHelper.get1(cfg_monijybuildconfig_get,bdData.build_id)
if not cfg.benefit_type then
local blist=_MapManager.GetBenefitBuildingList(bdData.entityId)
if blist then
for i,v in ipairs(blist)do
local tdata=zongmenModel:findBuildingByEntityId(v)
self:refreshBuildingBuffEffect(sfId,tdata.un_build_id)
end
end
end






end