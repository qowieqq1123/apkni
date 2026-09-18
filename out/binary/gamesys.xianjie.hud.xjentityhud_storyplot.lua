









local xjEntityHud_StoryPlot={}
local abname="ui/windows/xianjie/xianjietask_atlas_pak.ab"

function xjEntityHud_StoryPlot:onInit()
self.needFollow=true

local data=self.data
self.modelCfg=cfgHelper.get1(cfg_xianjiestoryplotmodelconfig_get,data.modelId)
end


function xjEntityHud_StoryPlot:onCreateWidget(widget)
self:refreshInfo()
end


function xjEntityHud_StoryPlot:onRemoveWidget(widget)
if self.showTimer then
self.showTimer:cancel()
self.showTimer=nil
end
self:hideSpeak(widget)
end


function xjEntityHud_StoryPlot:refreshInfo()
local widget=self:getWidget()
widget:SetChildActive(0,false)

local offset=self.modelCfg.hudOffset
if offset~=nil then
widget:SetChildAnchoredPos(0,offset[1],offset[2])
end
end

function xjEntityHud_StoryPlot:speak(content,duration,offset,callback)
local widget=self:getWidget()
if widget then
widget:SetChildActive(0,true)

widget:SetChildText(1,chatEmotHelper.decodeEmot(content))

if offset then
widget:SetChildAnchoredPos(0,offset[1],offset[2])
end

if self.showTimer then
self.showTimer:cancel()
self.showTimer=nil
end

if duration then
self.emotTimer=timer.new()
self.emotTimer:start(duration,function()
self:hideSpeak(widget)
if callback then
callback()
end
end,1)
end
end
end

function xjEntityHud_StoryPlot:hideSpeak(widget)
widget:SetChildActive(0,false)
end

function xjEntityHud_StoryPlot:onClick()

end


function xjEntityHud_StoryPlot:onDelete()
if self.showTimer then
self.showTimer:cancel()
self.showTimer=nil
end
end

return xjEntityHud_StoryPlot