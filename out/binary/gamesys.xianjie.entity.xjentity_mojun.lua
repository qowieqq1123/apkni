









local xjEntity_MoJun={}


function xjEntity_MoJun:onInit()
local data=xianjieModel:getMoJunEntityData(self.data.seasonType,self.data.stageIndex)
self.pos=data:getWorldPos_1()
self.size=data:getWorldSize()
self.allowClickGrid=true
self.xjicontype=1401
self.data.xjicontype=1401
end


function xjEntity_MoJun:onSelectHandle(widget,isSelect)
if not widget then
self.selectEffect=nil
return
end
if isSelect then
if self.selectEffect==nil then
local data=xianjieModel:getMoJunEntityData(self.data.seasonType,self.data.stageIndex)
local effect=data:getSelectEffect()
if effect then
self.selectEffect=effect[1]
local entCfg=cfgHelper.get1(cfg_xianjieentityconfig_get,self.entityType)
local sortingLayer=helper.getSortingLayerID("Entity")
widget:SetChildShowEffectEx(1,self.selectEffect,sortingLayer,entCfg.sortOrder-1,true)
local pos=effect[2]
widget:SetChildLocalPosition(1,Vector3(pos[1],pos[2],pos[3]))
local scale=effect[3]
widget:SetChildScale(1,Vector3(scale,scale,scale))
end
end
else
if self.selectEffect then
self.selectEffect=nil
widget:SetChildShowEffect(1,0,false)
end
end
end


function xjEntity_MoJun:onCreateWidget(widget)
local data=xianjieModel:getMoJunEntityData(self.data.seasonType,self.data.stageIndex)

local body,componets,scale,flip,offset=data:getModelData()
local boxParams=self:handleBoxParams()
local entCfg=cfgHelper.get1(cfg_xianjieentityconfig_get,self.entityType)
widget:SetChildSceneEntityCreateModel(0,body,componets,'Entity',entCfg.sortOrder,scale,nil,false)
widget:SetChildSceneEntityAddModelBoxCollider(0,boxParams,helper.LAYER_ACTOR)
widget:SetChildSceneEntityFlipX(0,flip)
widget:SetChildLocalPosition(2,offset)
widget:SetChildSceneEntityUnMount(0)
local flipX=self.flipX_mark
if flipX then
self.flipX_mark=nil
self:modelFlipX(widget,flipX)
end

self:refreshState(widget)
end

function xjEntity_MoJun:setPlayAnimationTime(time)
local curTime=gameUtilityModel.getServerShortTime2()
self.atkEndTime=curTime+time
end

function xjEntity_MoJun:modelPlayAnimation(anim)
local curTime=gameUtilityModel.getServerShortTime2()
if self.atkEndTime and self.atkEndTime>=curTime then
return
end
local widget=self:getWidget()
if widget then
if anim>0 then
widget:SetChildSceneEntityPlayAnimation(0,anim)
end
end
end

function xjEntity_MoJun:modelPlayAnimationInPlot(anim,time)
local curTime=gameUtilityModel.getServerShortTime2()
self.atkEndTime=curTime+time
local widget=self:getWidget()
if widget then
if anim>0 then
widget:SetChildSceneEntityPlayAnimation(0,anim)
end
end
end

function xjEntity_MoJun:modelFlipX(widget,flipX)
widget=widget or self:getWidget()
if widget then
widget:SetChildSceneEntityFlipX(0,flipX)
else
self.flipX_mark=flipX
end
end


function xjEntity_MoJun:onRemoveWidget(widget)

end


function xjEntity_MoJun:onMyClick(boxParams)





xianjieController:jumpMoJieMoJun()
end

function xjEntity_MoJun:onDelete()

end

function xjEntity_MoJun:refreshInfo()
self:refreshState()

local hud=self:getHud()
if hud and hud.refreshInfo then
hud:refreshInfo()
end
end

function xjEntity_MoJun:refreshState(widget)
widget=widget or self:getWidget()
if widget then
local mojunData=xianjieModel:getMoJunData()
widget:SetChildSceneEntitySetVisible(0,mojunData.timeType==2 and mojunData.killTime==0)
end
end

return xjEntity_MoJun