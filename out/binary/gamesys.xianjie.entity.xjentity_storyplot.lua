









local xjEntity_StoryPlot={}


function xjEntity_StoryPlot:onInit()
local data=self.data

self.entCfg=cfgHelper.get1(cfg_xianjieentityconfig_get,data.unitType)
self.modelCfg=cfgHelper.get1(cfg_xianjiestoryplotmodelconfig_get,data.modelId)


self.pos=Vector3(data.pos[1],data.pos[2],data.pos[3])
self.size=Vector2.New(1000,1000)
self.lodLevel=self.entCfg.lodLevel
self.modelId=data.modelId
self.scale=data.scale
end


function xjEntity_StoryPlot:onSelectHandle(widget,isSelect)

end


function xjEntity_StoryPlot:onCreateWidget(widget)



local boxParams=self:handleBoxParams()

local modelParam=xianjieController:getUnitModelParam(self.data.modelId)
local body=modelParam[1]
local componets=modelParam[2]
local offset=modelParam[3]
local scale=self.scale or 1


self.body=body
if body~=nil then
local cfg=cfgHelper.get1(cfg_characterModelConfig_get,body)
if cfg then
widget:SetChildSceneEntityCreateObject(0,body)
local boxSizeParam={0,0}
local boxSize=Vector2.New(boxSizeParam[1],boxSizeParam[2])
local boxOffset=Vector2.New(0,0)
widget:SetChildSceneEntityAddBoxCollider(0,boxSize,boxOffset,boxParams,helper.LAYER_ACTOR)
else
widget:SetChildSceneEntityCreateModel(0,body,componets,'Entity',self.entCfg.sortOrder,scale,nil,false)
widget:SetChildSceneEntityAddModelBoxCollider(0,boxParams,helper.LAYER_ACTOR)
widget:SetChildSceneEntityPlayAnimation(0,self.data.anim,1)
end
end

if offset then
widget:SetChildLocalPosition(0,Vector3(offset[1],offset[2],offset[3]))
end

self:setShow(self.data.show)

xianjieModel:pushUnit(self.data.unitKey,widget)
end



function xjEntity_StoryPlot:onRemoveWidget(widget)
if self.moveDt then
self.moveDt:Complete()
self.moveDt:Kill()
end

if self.scaleDt then
self.scaleDt:Complete()
self.scaleDt:Kill()
end

widget:SetChildSceneEntityRemoveModel(0)
end

function xjEntity_StoryPlot:modelPlayAnimation(anim)
local widget=self:getWidget()
if widget then
widget:SetChildSceneEntityPlayAnimation(0,anim,1)
end
end


function xjEntity_StoryPlot:doMovePosition(pos,duration,ease,callback)
local widget=self:getWidget()
if self.moveDt then
self.moveDt:Complete()
self.moveDt:Kill()
end

if widget then
self.moveDt=widget:SetChildDOMove(-1,pos,duration,callback)
self.moveDt:SetEase(ease)
end
end

function xjEntity_StoryPlot:showEffect(effectID,sortingLayer,sortingOrder,show,offset,scale)
local widget=self:getWidget()
if widget then

if self.body~=nil then
if show then
if offset then
offset=Vector3(offset[1],offset[2],offset[3])
end
if scale then
scale=Vector3(scale[1],scale[2],scale[3])
end

widget:SetChildSceneEntityPlayEffect(0,effectID,offset,scale)
else
widget:SetChildSceneEntityStopEffectOnActor(0,0)
end
else
if show then
widget:SetChildShowEffect(1,effectID,true)






if scale then
self:setScale(scale[1],0)
end
else
widget:SetChildShowEffect(1,0)
end
end
end
end

function xjEntity_StoryPlot:stopEffect()
local widget=self:getWidget()
if widget then
widget:SetChildSceneEntityStopEffectOnActor(0,0)
end
end

function xjEntity_StoryPlot:setPosition(pos)
local widget=self:getWidget()
if widget then
widget:SetChildPosition(-1,pos)
end
end

function xjEntity_StoryPlot:setShow(show,duration,callback)
local widget=self:getWidget()
if widget then
widget:SetChildActive(-1,show)
end
end

function xjEntity_StoryPlot:setModelFlipX(isFlip)
local widget=self:getWidget()
if widget then
widget:SetChildSceneEntityFlipX(0,isFlip)
end
end

function xjEntity_StoryPlot:setScale(scale,duration,callback)
local widget=self:getWidget()
if widget then
if duration>0 then
if self.scaleDt then
self.scaleDt:Complete()
self.scaleDt:Kill()
end

self.scaleDt=widget:SetChildDOScale(-1,scale,duration,callback)
else
widget:SetChildScale(-1,Vector3.New(scale,scale,scale))
end
end
end



function xjEntity_StoryPlot:onMyClick(boxParams)

end

function xjEntity_StoryPlot:onDelete()

end

return xjEntity_StoryPlot
