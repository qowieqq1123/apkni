









local xjEntity_LeyLine={}


function xjEntity_LeyLine:onInit()
local data=xianjieModel:getLeyLineData()
self.pos=data:getWorldPos_1()
self.size=data:getWorldSize()
end


function xjEntity_LeyLine:onCreateWidget(widget)

local data=xianjieModel:getLeyLineData()
local cfg=data:getCfg()
local info=cfg.clientParam.sceneModel
local stage=xianjieModel:getLeyLineRepairStage()
local isFinish=xianjieModel:isLeyLineRepairFinish()
stage=math.max(isFinish and stage or(stage-1),0)
for i=stage,0,-1 do
local v=info[i]
if v then
if self.infoModel~=v then
self.infoModel=v
widget:SetChildSceneEntityRemoveModel(0)
widget:SetChildSceneEntityCreateObject(0,v)

local offset=cfg.clientParam.sceneModelOffset
widget:SetChildSceneEntitySetOffset(0,mathHelper.convertArrayToVector(offset))
end
break
end
end
end


function xjEntity_LeyLine:onRemoveWidget(widget)

self.infoModel=nil
widget:SetChildSceneEntityRemoveModel(0)
end


function xjEntity_LeyLine:refreshInfo()
local widget=self:getWidget()
if widget then
self:onCreateWidget(widget)
end

local hud=self:getHud()
if hud and hud.refreshInfo then
hud:refreshInfo()
end
end



return xjEntity_LeyLine