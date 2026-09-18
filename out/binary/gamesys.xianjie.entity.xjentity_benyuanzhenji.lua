









local xjEntity_benYuanZhenJi={}


function xjEntity_benYuanZhenJi:onInit()
local data=self.data
self.season_id=data.season_id
self.chapter_idx=data.chapter_idx
self.entityId=data.entityId
local entityData=xianjieModel:getBenYuanZhenJiDataByBuildId(self.season_id,self.chapter_idx,self.entityId)
self.pos=entityData:getWorldPos_1()
self.size=entityData:getWorldSize()
local cfg=entityData:getCfg()

self.ent_name=cfg.name
self.xjicontype=1702
self.allowClickGrid=true
end


function xjEntity_benYuanZhenJi:onCreateWidget(widget)
widget=widget or self:getWidget()
if not widget then
return
end

local bdCfg=cfgHelper.get1(cfg_fairylandclientbuildconfig_get,self.entityId)
local modelset=bdCfg.clientParam
local info=modelset.sceneModel

local effectIDList={60032,60033}
local netData=xianjieModel:getBenYuanZhenJiNetData(self.season_id,self.chapter_idx,self.entityId)
local configs=seasonModel:getStageConfigEx(self.season_id,self.chapter_idx)
local byZhenJiCfg=configs.byZhenJi[self.entityId]

local curMQ=netData and netData.ptzjDieNum or 0
local maxMQ=byZhenJiCfg[3]
local countdownTime=netData and netData.countdownTime or 0

local isFinish=false
local effectId
if xianjieModel:checkMoJingZhenJiDestroyed(self.season_id,self.chapter_idx,self.entityId)then
isFinish=true
elseif curMQ>=maxMQ and countdownTime>0 and countdownTime<timeHelper.getServerShortTime()then
effectId=effectIDList[2]
elseif curMQ>=maxMQ and countdownTime>0 then
effectId=effectIDList[1]
elseif curMQ<maxMQ then
effectId=effectIDList[1]
end

local modelId=isFinish and info[2]or info[1]
if self.infoModel~=modelId then
self.infoModel=modelId
widget:SetChildSceneEntityRemoveModel(0)
widget:SetChildSceneEntityCreateObject(0,modelId)

local offset=modelset.sceneModelOffset
widget:SetChildSceneEntitySetOffset(0,mathHelper.convertArrayToVector(offset))

local boxSizeParam={4,22}
local boxSize=Vector2.New(boxSizeParam[1],boxSizeParam[2])
local boxOffset=Vector2.New(0,10)
local boxParams=self:handleBoxParams()
widget:SetChildSceneEntityAddBoxCollider(0,boxSize,boxOffset,boxParams,helper.LAYER_ACTOR)
end

if self.infoEffect==effectIDList[1]and effectId==effectIDList[2]then
self.infoEffect=effectId
widget:SetChildShowEffect(1,effectId,true)
self.delatTimer=timeEventController.delayDo(0.5,function()
if self and self.infoEffect==effectIDList[2]and widget then
widget:SetChildShowEffect(2,0,false)
end
end)
elseif self.infoEffect~=effectId and effectId==effectIDList[1]then
self.infoEffect=effectId
widget:SetChildShowEffect(2,effectId,true)
elseif effectId==nil then
widget:SetChildShowEffect(2,0,false)
end
widget:SetChildNewBieComponentId(0,'xjEntity_benYuanZhenJi.model'..self.entityId)
end

function xjEntity_benYuanZhenJi:onUpdate()
if xianjieModel:checkMoJingZhenJiDestroyed(self.season_id,self.chapter_idx,self.entityId)then
return
end
local configs=seasonModel:getStageConfigEx(self.season_id,self.chapter_idx)
local byZhenJiCfg=configs.byZhenJi[self.entityId]
local netData=xianjieModel:getBenYuanZhenJiNetData(self.season_id,self.chapter_idx,self.entityId)
local curMQ=netData and netData.ptzjDieNum or 0
local maxMQ=byZhenJiCfg[3]
if curMQ>=maxMQ then
local countdownTime=netData and netData.countdownTime or 0
local curTime=timeHelper.getServerShortTime()
if self.oldTime and countdownTime>0 and countdownTime<curTime and countdownTime>=self.oldTime then
self:onCreateWidget()
end
self.oldTime=timeHelper.getServerShortTime()
end
end


function xjEntity_benYuanZhenJi:onRemoveWidget(widget)

self.infoModel=nil
self.infoEffect=nil
widget:SetChildSceneEntityRemoveModel(0)
end


function xjEntity_benYuanZhenJi:refreshInfo()
local hud=self:getHud()
if hud and hud.refreshInfo then
hud:refreshInfo()
end
end


function xjEntity_benYuanZhenJi:onMyClick(boxParams)

xianjieController:reqBenYuanZhenJiData(self.season_id,self.chapter_idx,self.entityId,true)
local bdCfg=cfgHelper.get1(cfg_fairylandclientbuildconfig_get,self.entityId)


end



return xjEntity_benYuanZhenJi