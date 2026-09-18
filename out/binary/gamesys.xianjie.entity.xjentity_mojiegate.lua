









local xjEntity_mojieGate={}


function xjEntity_mojieGate:onInit()
local data=self.data
self.gateId=data[1]
local gateEntityData=xianjieModel:getMoJieGateData(self.gateId)
self.pos=gateEntityData:getWorldPos_1()
self.size=gateEntityData:getWorldSize()




local gateCfg=cfgHelper.get1(cfg_devildomscenegateconfig_get,self.gateId)
local gateName=gateCfg.name
local gateXYSceneIndex=gateCfg.area
local xyName=xianjieController:getCrossServerNamebySCidx(gateXYSceneIndex)
local nameStr=FMT.fmt("{0}·{1}",xyName,gateName)
self.ent_name=nameStr

self:getXJIconType()
self:setAnimStateId()
end


function xjEntity_mojieGate:onCreateWidget(widget)
widget:SetChildActive(1,false)

local gateCfg=cfgHelper.get1(cfg_devildomscenegateconfig_get,self.gateId)
local entityId=gateCfg.build_id
local bdCfg=cfgHelper.get1(cfg_fairylandclientbuildconfig_get,entityId)
local modelset=bdCfg.clientParam

local offset=modelset.offset or{0,0,0}
widget:SetChildLocalPosition(0,Vector3(offset[1],offset[2],offset[3]))

local rotation=modelset.rotation or{0,0,0}
widget:SetChildRotation(0,rotation[1],rotation[2],rotation[3])
widget:SetChildActive(1,true)

if not self.animStateId then
self:setAnimStateId()
end
widget:SetChildAnimatorInteger(2,'stateId',self.animStateId,false)

widget:SetChildSceneEntityRemoveModel(0)
widget:SetChildSceneEntityCreateObject(0,4)

local boxSizeParam={0,0}
local boxSize=Vector2.New(boxSizeParam[1],boxSizeParam[2])
local boxOffset=Vector2.zero
local boxParams=self:handleBoxParams()
widget:SetChildSceneEntityAddBoxCollider(0,boxSize,boxOffset,boxParams,helper.LAYER_ACTOR)


end


function xjEntity_mojieGate:onRemoveWidget(widget)

widget:SetChildSceneEntityRemoveModel(0)
widget:SetChildActive(1,false)
end


function xjEntity_mojieGate:refreshInfo()
local hud=self:getHud()
if hud and hud.refreshInfo then
hud:refreshInfo()
end

local widget=self:getWidget()
if widget and self.animStateId then
local lastAnimStateId=self.animStateId
self:setAnimStateId()
if self.animStateId~=lastAnimStateId then
if self.animStateId==1 then
widget:SetChildAnimatorParameter(2,'playAnim','trigger','')
end
widget:SetChildAnimatorInteger(2,'stateId',self.animStateId,false)
end
end
self:getXJIconType()
end


function xjEntity_mojieGate:onMyClick(boxParams)
if not self:checkWidget()then return end



xianjieController:openMoJieGateWin(self.gateId)
end

function xjEntity_mojieGate:setAnimStateId()
local isHasOwner=false
local gateEntityData=xianjieModel:getMoJieGateData(self.gateId)
if gateEntityData then
local gateData=gateEntityData.data
local xmData=gateData and gateData.xmInfo or nil
local xmGuid=xmData and xmData.param_1 or nil
isHasOwner=xmGuid and not mathHelper.compareInt64(xmGuid,Int64_0)
end

local animStateId=isHasOwner and 1 or 0
self.animStateId=animStateId
end

function xjEntity_mojieGate:getXJIconType()
local isHasOwner=false
local gateEntityData=xianjieModel:getMoJieGateData(self.gateId)
if gateEntityData then
local gateData=gateEntityData.data
local xmData=gateData and gateData.xmInfo or nil
local xmGuid=xmData and xmData.param_1 or nil
isHasOwner=xmGuid and not mathHelper.compareInt64(xmGuid,Int64_0)
end

local xjicontype=isHasOwner and 1301 or 1302
self.xjicontype=xjicontype
return xjicontype
end


return xjEntity_mojieGate